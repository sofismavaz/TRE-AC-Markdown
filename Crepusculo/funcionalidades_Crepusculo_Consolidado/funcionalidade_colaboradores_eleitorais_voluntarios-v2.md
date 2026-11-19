# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Colaboradores Eleitorais e Voluntários Externos

### 1. Visão Geral e Escopo Funcional
**Propósito**: Gestão das candidaturas, alocação, escalas de trabalho e ciclo de vida de colaboradores eleitorais (internos e externos), voluntários, coordenadores de acessibilidade e mesários convocados para o pleito.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-COL-001: Fluxo de Deferimento e Solicitações de Desistência
- Inscritos passam pelos status: `PENDENTE`, `DEFERIDA`, `INDEFERIDA`, `CANCELADA`.
- Reanálise de candidatura só é permitida na direção `INDEFERIDA` -> `DEFERIDA`.
- Solicitação de desistência voluntária apresentada pelo inscrito deferido exige motivo justificado e homologação pelo gestor.
- Desistência direta registrada pelo gestor atualiza o status para `CANCELADA` e grava a justificativa de cancelamento no histórico auditado.

#### RN-COL-002: Exclusão Lógica Global de Voluntários (`CE_VOLUNTARIO_EXTERNO_EXCLUSAO`)
- A exclusão de um voluntário é lógica e mantida em `CE_VOLUNTARIO_EXTERNO_EXCLUSAO` com o motivo e o usuário autor.
- A exclusão oculta o voluntário de novos cadastros e escalas, mas preserva a integridade de históricos e certidões passadas.
- Voluntário com dependências operacionais ativas (ex: alocado em rota ativa) não pode ser excluído antes da remoção prévia do vínculo.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Processo Eleitoral Seletivo
CREATE TABLE CE_PROCESSO_ELEITORAL (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    UNIDADE_ID NUMBER(10) NOT NULL,
    TITULO VARCHAR2(150) NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Candidaturas de Colaboradores
CREATE TABLE CE_CANDIDATURA_COLABORADOR (
    ID NUMBER(10) PRIMARY KEY,
    PROCESSO_ELEITORAL_ID NUMBER(10) NOT NULL,
    NUM_INSCRICAO VARCHAR2(20) NOT NULL, -- Título Eleitoral (12 dígitos)
    NOME VARCHAR2(150) NOT NULL,
    EMAIL VARCHAR2(150),
    STATUS VARCHAR2(20) DEFAULT 'PENDENTE' NOT NULL, -- PENDENTE, DEFERIDA, INDEFERIDA, CANCELADA
    JUSTIFICATIVA_CANCELAMENTO VARCHAR2(1000),
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_CC_PROCESSO FOREIGN KEY (PROCESSO_ELEITORAL_ID) REFERENCES CE_PROCESSO_ELEITORAL(ID)
);

-- Voluntários Manuais (Cadastro Interno Avulso)
CREATE TABLE CE_VOLUNTARIO_MANUAL (
    ID NUMBER(10) PRIMARY KEY,
    NUM_INSCRICAO VARCHAR2(12) NOT NULL UNIQUE,
    NOME VARCHAR2(150) NOT NULL,
    CPF VARCHAR2(11),
    EMAIL VARCHAR2(150),
    TELEFONE VARCHAR2(20),
    ZONA_NUM NUMBER(5),
    MUNICIPIO_COD VARCHAR2(20),
    LOCAL_VOTACAO_COD VARCHAR2(20),
    ORIGEM VARCHAR2(20) DEFAULT 'MANUAL' NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    MOTIVO_INATIVACAO VARCHAR2(500),
    USUARIO_CRIACAO VARCHAR2(100) NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Coordenadores de Acessibilidade
CREATE TABLE CAD_COORDENADOR_ACESSIBILIDADE (
    ID NUMBER(10) PRIMARY KEY,
    NUM_INSCRICAO VARCHAR2(12) NOT NULL UNIQUE,
    NOME VARCHAR2(150) NOT NULL,
    CPF VARCHAR2(11) NOT NULL,
    LOCAL_ATUACAO_COD VARCHAR2(20) NOT NULL,
    POSSUI_WHATSAPP NUMBER(1) DEFAULT 0 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
```

#### Visão de Perfil Efetivo:
- **`VW_VOLUNTARIO_PERFIL_EFETIVO`**: Visão do schema consolidando os dados pessoais, endereço, contatos e disponibilidade de voluntários vindos do Autocadastro e bases oficiais do TRE-AC.

---

### 4. Componentes e Código PHP Essencial

#### Repository de Colaboradores e Candidaturas (`ColaboradorEleitoralRepository.php`)
```php
namespace App\Repositories\ColaboradoresEleitorais;

use App\Repositories\ColaboradoresEleitorais\Contracts\ColaboradorEleitoralRepositoryInterface;
use App\Support\Access\EscopoZonal;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class ColaboradorEleitoralRepository implements ColaboradorEleitoralRepositoryInterface
{
    public function listarCandidaturas(array $filtros, EscopoZonal $escopo, int $perPage = 15): LengthAwarePaginator
    {
        $query = DB::table('CE_CANDIDATURA_COLABORADOR as C')
            ->join('CE_PROCESSO_ELEITORAL as PE', 'PE.ID', '=', 'C.PROCESSO_ELEITORAL_ID')
            ->select('C.*', 'PE.TITULO as PROCESSO_TITULO', 'PE.UNIDADE_ID');

        if (!$escopo->isIrrestrito()) {
            $query->whereIn('PE.UNIDADE_ID', $escopo->unidadesPermitidas());
        }

        if (!empty($filtros['status'])) {
            $query->where('C.STATUS', $filtros['status']);
        }

        if (!empty($filtros['busca'])) {
            $busca = '%' . strtoupper($filtros['busca']) . '%';
            $query->where(function ($q) use ($busca) {
                $q->where('C.NOME', 'LIKE', $busca)
                  ->orWhere('C.NUM_INSCRICAO', 'LIKE', $busca);
            });
        }

        return $query->orderBy('C.NOME')->paginate($perPage);
    }
}
```

---

### 5. Fronteiras de Integração
- **ELO / TSE**: Sincronização remota de nomeações e situações de convocados.
- **TextBee / Zenvia**: Disparo de convocações em lote via SMS/WhatsApp para os inscritos deferidos.
