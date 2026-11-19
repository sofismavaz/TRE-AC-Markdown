# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Supervisores de Prédio

### 1. Visão Geral e Escopo Funcional
**Propósito**: Cadastro, validação por título eleitoral, alocação em locais de votação, gestão de questionários operacionais e envio de confirmações e notificações para supervisores de prédio.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-SUP-001: Validação de Elegibilidade
- O supervisor é identificado obrigatoriamente pelo Título Eleitoral (`num_inscricao` de 12 dígitos) e data de nascimento.
- A validação de elegibilidade consulta a tabela oficial de eleitores (`planeleito.eleitor`).
- Não é permitida a alocação de mais de um supervisor ativo no mesmo local de votação para o mesmo macroprojeto, exceto quando a flag de exceção por capacidade for concedida pelo administrador.

#### RN-SUP-002: Notificações de Alocação
- Ao salvar a alocação do supervisor, o sistema dispara o job assíncrono `EnviarNotificacaoSupervisorPredioJob` para enviar o e-mail de confirmação contendo o local de votação e as diretrizes da função.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Cadastro Principal de Supervisores de Prédio
CREATE TABLE CAD_SUPERVISOR_PREDIO (
    ID NUMBER(10) PRIMARY KEY,
    NUM_INSCRICAO VARCHAR2(12) NOT NULL UNIQUE,
    NOME VARCHAR2(150) NOT NULL,
    CPF VARCHAR2(11) NOT NULL,
    EMAIL VARCHAR2(150),
    TELEFONE VARCHAR2(20) NOT NULL,
    COD_OBJETO_LOCAL_VOTACAO VARCHAR2(20) NOT NULL,
    ZONA_NUM NUMBER(5) NOT NULL,
    BANCO_CODIGO VARCHAR2(10),
    AGENCIA VARCHAR2(20),
    CONTA VARCHAR2(20),
    PIX_CHAVE VARCHAR2(100),
    ORIGEM VARCHAR2(20) DEFAULT 'INTERNO' NOT NULL, -- PUBLICO, INTERNO
    CONFIRMADO_EMAIL NUMBER(1) DEFAULT 0 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Perguntas e Questionário do Supervisor
CREATE TABLE CAD_SUPERVISOR_PERGUNTA (
    ID NUMBER(10) PRIMARY KEY,
    ORDEM NUMBER(5) NOT NULL,
    ENUNCIADO VARCHAR2(500) NOT NULL,
    GRUPO VARCHAR2(50) DEFAULT 'GERAL' NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL
);

CREATE TABLE CAD_SUPERVISOR_RESPOSTA (
    ID NUMBER(10) PRIMARY KEY,
    SUPERVISOR_PREDIO_ID NUMBER(10) NOT NULL,
    PERGUNTA_ID NUMBER(10) NOT NULL,
    RESPOSTA VARCHAR2(10) NOT NULL, -- SIM, NAO, NAO_APLICA
    JUSTIFICATIVA VARCHAR2(1000),
    DT_RESPOSTA TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_CSR_SUPERVISOR FOREIGN KEY (SUPERVISOR_PREDIO_ID) REFERENCES CAD_SUPERVISOR_PREDIO(ID) ON DELETE CASCADE,
    CONSTRAINT FK_CSR_PERGUNTA FOREIGN KEY (PERGUNTA_ID) REFERENCES CAD_SUPERVISOR_PERGUNTA(ID)
);
```

---

### 4. Componentes e Código PHP Essencial

#### Controller de Supervisores (`SupervisorPredioController.php`)
```php
namespace App\Http\Controllers\SupervisoresPredio;

use App\Http\Controllers\Controller;
use App\Http\Requests\SupervisoresPredio\SupervisorPredioRequest;
use App\Repositories\SupervisoresPredio\Contracts\SupervisorPredioRepositoryInterface;
use App\Support\Access\EscopoZonal;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class SupervisorPredioController extends Controller
{
    public function __construct(private readonly SupervisorPredioRepositoryInterface $repository) {}

    public function index(Request $request): View
    {
        $escopo = EscopoZonal::daSessao();
        $filtros = $request->only(['busca', 'zona', 'municipio']);
        $supervisores = $this->repository->listar($filtros, $escopo, 15);

        return view('supervisores-predio.index', compact('supervisores', 'filtros'));
    }

    public function store(SupervisorPredioRequest $request): RedirectResponse
    {
        $dados = $request->validated();
        $this->repository->salvarCadastroInterno($dados);

        return redirect()->route('supervisores-predio.index')
            ->with('sucesso', 'Supervisor de prédio alocado com sucesso.');
    }
}
```

---

### 5. Fronteiras de Integração
- **E-mail / Queue**: Envio assíncrono de notificações de convocação e confirmação de e-mail por token.
