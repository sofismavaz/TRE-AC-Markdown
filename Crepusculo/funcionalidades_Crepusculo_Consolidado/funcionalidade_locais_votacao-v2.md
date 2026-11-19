# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Locais de Votação e Seções Eleitorais

### 1. Visão Geral e Escopo Funcional
**Propósito**: Manutenção do acervo de locais de votação, seções eleitorais, seções agregadas, alocações provisórias, atribuição de dia de instalação de urnas (Sábado/Domingo), indicadores geográficos, tempo de deslocamento (GEL), emissão de etiquetas A5/A4 de sinalização e dashboard de vistorias de instalação de urnas.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-LOC-001: Fonte Autoritativa e Visão Efetiva
- A tabela `LOCAL_VOTACAO_ST` é a tabela base sincronizada do cadastro eleitoral.
- A visão `VW_LOCAIS_VOTACAO_EFETIVOS` é a fonte canônica para todas as consultas do sistema, aplicando filtros de elegibilidade e ignorando locais desativados ou excluídos da operação.

#### RN-LOC-002: Eleitores Aptos Consolidados
- A contagem de eleitores aptos exibida para uma seção agregadora (ex: linha `033(044)`) soma os aptos da seção principal (`033`) e de todas as seções agregadas a ela (`044`).
- Se houver alocação provisória, o total consolidado acompanha a seção para o local de destino efetivo.

#### RN-LOC-003: Dia de Instalação Operacional de Urnas
- Tabela `LOCAL_VOTACAO_OPERACIONAL` armazena o dia previsto para instalação física das urnas (`SABADO` ou `DOMINGO`) no macroprojeto ativo.
- O campo é editável via formulário interno e filtrável nos relatórios e exportações.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Cadastro de Locais de Votação
CREATE TABLE LOCAL_VOTACAO_ST (
    COD_OBJETO VARCHAR2(20) PRIMARY KEY,
    NUM_LOCAL NUMBER(8) NOT NULL,
    NOME VARCHAR2(150) NOT NULL,
    ENDERECO VARCHAR2(255),
    BAIRRO VARCHAR2(100),
    ZONA_NUM NUMBER(5) NOT NULL,
    MUNICIPIO_COD VARCHAR2(20) NOT NULL,
    AREA_LOCAL VARCHAR2(10) DEFAULT 'URBANA' NOT NULL, -- URBANA, RURAL
    STATUS VARCHAR2(1) DEFAULT 'A' NOT NULL
);

-- Seções Eleitorais
CREATE TABLE SECOES (
    COD_OBJETO_SECAO VARCHAR2(20) PRIMARY KEY,
    COD_OBJETO_LOCAL VARCHAR2(20) NOT NULL,
    NUM_SECAO NUMBER(5) NOT NULL,
    QTDE_ELEITORES_APTOS NUMBER(6) DEFAULT 0 NOT NULL,
    CONSTRAINT FK_SEC_LOCAL FOREIGN KEY (COD_OBJETO_LOCAL) REFERENCES LOCAL_VOTACAO_ST(COD_OBJETO)
);

-- Seções Agregadas
CREATE TABLE SECOES_AGREGADAS (
    COD_OBJETO_AGREGADORA VARCHAR2(20) NOT NULL,
    COD_OBJETO_AGREGADA VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_SECOES_AGREGADAS PRIMARY KEY (COD_OBJETO_AGREGADORA, COD_OBJETO_AGREGADA)
);

-- Dia de Instalação Operacional de Urnas
CREATE TABLE LOCAL_VOTACAO_OPERACIONAL (
    ID NUMBER(10) PRIMARY KEY,
    COD_OBJETO_LOCAL VARCHAR2(20) NOT NULL,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    DIA_INSTALACAO_URNAS VARCHAR2(10) NOT NULL, -- SABADO, DOMINGO
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT UK_LVO_LOCAL_MACRO UNIQUE (COD_OBJETO_LOCAL, MACROPROJETO_ID)
);
```

#### Visões Principais:
- **`VW_LOCAIS_VOTACAO_EFETIVOS`**: Filtra e normaliza os locais de votação válidos para a operação.
- **`VW_SECOES_AGREGADAS`**: Consolida os números de seções agregadoras e agregadas e quantitativo de eleitores aptos.

---

### 4. Componentes e Código PHP Essencial

#### Controller do Dashboard de Locais (`DashboardLocaisVotacaoController.php`)
```php
namespace App\Http\Controllers\LocaisVotacao;

use App\Http\Controllers\Controller;
use App\Http\Requests\LocaisVotacao\DashboardLocaisVotacaoRequest;
use App\Repositories\LocaisVotacao\Contracts\LocalDeVotacaoRepositoryInterface;
use App\Support\Access\EscopoZonal;
use Illuminate\Http\JsonResponse;

class DashboardLocaisVotacaoController extends Controller
{
    public function __construct(private readonly LocalDeVotacaoRepositoryInterface $repository) {}

    public function index(DashboardLocaisVotacaoRequest $request)
    {
        $macroprojetoId = (int) session('macroprojeto_ativo_id');
        $escopo = EscopoZonal::daSessao();
        $filtros = $request->validated();

        $fatos = $this->repository->listarFatosDashboard($macroprojetoId, $escopo, $filtros);

        if ($request->expectsJson()) {
            return response()->json($fatos);
        }

        return view('locais-votacao.dashboard', compact('fatos', 'filtros'));
    }
}
```

---

### 5. Fronteiras de Integração
- **GEL**: Cálculo georreferenciado e consulta de tempos de deslocamento até cada local.
- **Sincronização Oficial**: Carga automatizada do cadastro de seções e locais de votação do TSE.
