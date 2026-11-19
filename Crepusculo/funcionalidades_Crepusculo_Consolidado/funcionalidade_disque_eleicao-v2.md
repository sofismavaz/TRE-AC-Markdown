# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Disque Eleição (Atendimento ao Cidadão)

### 1. Visão Geral e Escopo Funcional
**Propósito**: Atendimento telefônico e presencial ao cidadão para orientação sobre serviços eleitorais, locais de votação, situação de título, justificativas e denúncias, englobando catálogo de assuntos, registro de chamadas individuais e em lote, além de relatórios estatísticos consolidados.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-DIS-001: Isolamento por Contexto Eleitoral
- Todos os atendimentos pertencem obrigatoriamente à combinação de `macroprojeto_id` + `turno` ativos na sessão institucional.
- Não é permitido sobrescrever `macroprojeto_id` ou `turno` via payload HTTP ou parâmetro de URL.

#### RN-DIS-002: Lotes de Atendimento e Unicidade
- O registro em lote gera uma transação atômica identificada por `LOTE_UUID`.
- A combinação `LOTE_UUID` + `ASSUNTO_ID` deve ser única, impedindo duplicação de contagem no mesmo lote.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Catálogo de Assuntos do Disque Eleição
CREATE TABLE DISQUE_ELEICAO_ASSUNTO (
    ID NUMBER(10) PRIMARY KEY,
    CODIGO VARCHAR2(20) NOT NULL UNIQUE,
    DESCRICAO VARCHAR2(255) NOT NULL,
    ORDEM NUMBER(5) DEFAULT 1 NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Atendimentos Registrados
CREATE TABLE DISQUE_ELEICAO_ATENDIMENTO (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    TURNO VARCHAR2(20) NOT NULL,
    ASSUNTO_ID NUMBER(10) NOT NULL,
    DOMICILIO_MUNICPIO_COD VARCHAR2(20) NOT NULL,
    QUANTIDADE NUMBER(5) DEFAULT 1 NOT NULL,
    LOTE_UUID VARCHAR2(36),
    COMPLEMENTO VARCHAR2(500),
    OPERADOR_USERNAME VARCHAR2(100) NOT NULL,
    DT_ATENDIMENTO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_DEA_ASSUNTO FOREIGN KEY (ASSUNTO_ID) REFERENCES DISQUE_ELEICAO_ASSUNTO(ID)
);

-- Apoio de Domicílios Extras
CREATE TABLE DISQUE_ELEICAO_DOMICILIO_EXTRA (
    ID NUMBER(10) PRIMARY KEY,
    CODIGO VARCHAR2(20) NOT NULL UNIQUE,
    DESCRICAO VARCHAR2(100) NOT NULL,
    ORDEM NUMBER(5) DEFAULT 1 NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Controller de Atendimentos (`DisqueEleicaoAtendimentoController.php`)
```php
namespace App\Http\Controllers\DisqueEleicao;

use App\Http\Controllers\Controller;
use App\Http\Requests\DisqueEleicao\DisqueEleicaoAtendimentoStoreRequest;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAtendimentoRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class DisqueEleicaoAtendimentoController extends Controller
{
    public function __construct(private readonly DisqueEleicaoAtendimentoRepositoryInterface $repository) {}

    public function index(Request $request): View
    {
        $macroprojetoId = (int) session('macroprojeto_ativo_id');
        $turno = (string) session('turno_ativo', '1_TURNO');
        $filtros = $request->only(['assunto_id', 'municipio_cod', 'data_inicio', 'data_fim']);

        $atendimentos = $this->repository->listarHistorico($filtros, $macroprojetoId, $turno, 15);
        $assuntos = $this->repository->listarAssuntosAtivos();

        return view('disque-eleicao.atendimento.index', compact('atendimentos', 'assuntos', 'filtros'));
    }

    public function store(DisqueEleicaoAtendimentoStoreRequest $request): JsonResponse
    {
        $dados = $request->validated();
        $macroprojetoId = (int) session('macroprojeto_ativo_id');
        $turno = (string) session('turno_ativo', '1_TURNO');

        $loteId = $this->repository->registrarLote($dados['atendimentos'], $macroprojetoId, $turno, auth()->user()->username);

        return response()->json(['sucesso' => true, 'lote_id' => $loteId]);
    }
}
```

---

### 5. Fronteiras de Integração
- **Mapeamento de Municípios**: Consome o catálogo territorial unificado de municípios do Acre e domicílios especiais do TRE-AC.
