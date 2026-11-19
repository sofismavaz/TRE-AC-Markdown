# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Serviços Auxiliares, Portais Públicos e Módulos Transversais

### 1. Visão Geral e Escopo Funcional
**Propósito**: Agrupamento dos portais de serviços públicos e componentes transversais do ecossistema Crepúsculo:
- **Seu Voto Importa**: Portal público de solicitação de transporte acessível para eleitores com deficiência ou mobilidade reduzida, acompanhamento por protocolo e triagem administrativa.
- **Mesário Público e Vistorias NAT**: Registro de ocorrências operacionais no dia da eleição pelo Núcleo de Apoio Técnico (NAT) e interações do Mesário Público.
- **Cerimonial e Eventos Institucionais (`SOLENE`)**: Módulo de gestão de solenidades, posses, diplomações e nominata oficial.
- **Controle de Acesso Físico (`VISIT`)**: Módulo de registro de visitantes, acautelamento de armas e controle de crachás.
- **Calendário Eleitoral Público**: Exibição dos 105 eventos oficiais do pleito.
- **Integrador RCAND / PJe / CAND**: Monitoramento e sincronização dos processos de registro de candidaturas.

---

### 2. Regras de Negócio e Parâmetros

#### RN-SVI-001: Solicitação do Seu Voto Importa
- Formulário público sem exigência de e-mail obrigatório para o eleitor.
- O acompanhamento do pedido pelo eleitor opera exclusivamente via número de **Protocolo** e validação do Título Eleitoral/CPF.
- A triagem administrativa atribui rotas e veículos adaptados, isolada pelo escopo zonal da unidade responsável.

#### RN-SOL-002: Cerimonial e Presença (`SOLENE`)
- Fonte única da verdade para dados de pessoas consumida da visão corporativa (`Pessoa` / `VW_SERVIDOR`).
- Organização de autoridades, nominata, precedência oficial e emissão de listas de presença/convites.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Seu Voto Importa (Transporte Acessível)
CREATE TABLE SVI_SOLICITACAO (
    ID NUMBER(10) PRIMARY KEY,
    PROTOCOLO VARCHAR2(20) NOT NULL UNIQUE,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    NUM_INSCRICAO VARCHAR2(12) NOT NULL, -- Título do Eleitor
    NOME_ELEITOR VARCHAR2(150) NOT NULL,
    CPF_ELEITOR VARCHAR2(11),
    ZONA_NUM NUMBER(5) NOT NULL,
    MUNICIPIO_COD VARCHAR2(20) NOT NULL,
    TIPO_DEFICIENCIA VARCHAR2(100) NOT NULL,
    NECESSITA_VEICULO_ADAPTADO NUMBER(1) DEFAULT 0 NOT NULL,
    STATUS VARCHAR2(20) DEFAULT 'SOLICITADO' NOT NULL, -- SOLICITADO, EM_TRIAGEM, ATENDIDO, CANCELADO
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Ocorrências NAT (Núcleo de Apoio Técnico)
CREATE TABLE NAT_OCORRENCIA (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_TURNO_ID NUMBER(10) NOT NULL,
    COD_OBJETO_LOCAL_VOTACAO VARCHAR2(20) NOT NULL,
    TIPO_OCORRENCIA_ID NUMBER(10) NOT NULL,
    DESCRICAO VARCHAR2(2000) NOT NULL,
    STATUS VARCHAR2(20) DEFAULT 'ABERTA' NOT NULL, -- ABERTA, EM_ATENDIMENTO, FINALIZADA
    OPERADOR_ASSUMIU VARCHAR2(100),
    DT_OCORRENCIA TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DT_FINALIZACAO TIMESTAMP
);

-- Calendário Eleitoral Oficial
CREATE TABLE ELE_CAL_EVENTO (
    ID NUMBER(10) PRIMARY KEY,
    PLEITO_ID NUMBER(10) NOT NULL,
    COMPETENCIA_ID NUMBER(10) NOT NULL,
    CODIGO VARCHAR2(50) NOT NULL,
    DESCRICAO VARCHAR2(1000) NOT NULL,
    DATA_INICIO DATE NOT NULL,
    DATA_FIM DATE NOT NULL,
    PUBLICADO NUMBER(1) DEFAULT 1 NOT NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Controller do Seu Voto Importa (`SeuVotoImportaPublicoController.php`)
```php
namespace App\Http\Controllers;

use App\Http\Requests\SeuVotoImportaSolicitacaoStoreRequest;
use App\Repositories\Contracts\SeuVotoImportaRepositoryInterface;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class SeuVotoImportaPublicoController extends Controller
{
    public function __construct(private readonly SeuVotoImportaRepositoryInterface $repository) {}

    public function store(SeuVotoImportaSolicitacaoStoreRequest $request): RedirectResponse
    {
        $dados = $request->validated();
        $protocolo = $this->repository->criarSolicitacaoCompleta($dados);

        return redirect()->route('seu-voto-importa.sucesso', ['protocolo' => $protocolo]);
    }

    public function acompanhamento(Request $request): View
    {
        $protocolo = $request->input('protocolo');
        $solicitacao = $protocolo ? $this->repository->buscarAcompanhamentoPorProtocolo($protocolo) : null;

        return view('seu-voto-importa.publico.acompanhamento', compact('solicitacao', 'protocolo'));
    }
}
```

---

### 5. Fronteiras de Integração
- **SEI / PJe / RCAND**: Barramento de interoperabilidade com os sistemas judiciais e de registro de candidaturas.
- **Auditoria DML (`AuditaDml`)**: Interceptador global para registro automático de payload antes/depois de todas as operações de mutação no banco de dados.
