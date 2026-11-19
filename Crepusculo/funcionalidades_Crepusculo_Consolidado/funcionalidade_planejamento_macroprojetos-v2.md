# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Planejamento, Macroprojetos e Projetos

### 1. Visão Geral e Escopo Funcional
**Propósito**: Estruturação institucional do planejamento eleitoral, organizando o trabalho em Macroprojetos, Turnos (1º e 2º Turno), Grupos de Unidades, Projetos e Subprojetos, com cálculo de visibilidade estendida por leitura derivada.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-PLA-001: Contexto de Macroprojeto Ativo
- A navegação do sistema fixa em sessão o `macroprojeto_ativo_id` e o `turno_ativo`.
- Se o usuário navegar para uma tela de planejamento sem macroprojeto ativo selecionado, o middleware redireciona para a tela de seleção de contexto.
- Se a instalação possui apenas um macroprojeto ativo cadastrado, o sistema realiza auto-ativação na primeira requisição.

#### RN-PLA-002: Leitura Derivada de Projetos por Atividade (`PlanejamentoLeituraDerivadaService`)
- Um usuário da unidade 'X' pode visualizar um projeto da unidade 'Y' se a sua unidade for responsável por ao menos uma atividade/tarefa vinculada àquele projeto em `VW_TAREFA_STATUS`.
- **Importante**: A leitura derivada concede permissão de **visualização consultiva**, mas não concede permissão de **edição/escrita** no projeto ou subprojeto pai.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Macroprojeto Eleitoral
CREATE TABLE MACROPROJETO (
    ID NUMBER(10) PRIMARY KEY,
    NOME VARCHAR2(150) NOT NULL UNIQUE,
    DESCRICAO VARCHAR2(500),
    ANO_ELEICAO NUMBER(4) NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Turnos do Macroprojeto
CREATE TABLE MACROPROJETO_TURNO (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    TURNO VARCHAR2(20) NOT NULL, -- 1_TURNO, 2_TURNO
    DESCRICAO VARCHAR2(100),
    ATIVO NUMBER(1) DEFAULT 0 NOT NULL,
    CONSTRAINT FK_MT_MACRO FOREIGN KEY (MACROPROJETO_ID) REFERENCES MACROPROJETO(ID) ON DELETE CASCADE,
    CONSTRAINT UK_MACRO_TURNO UNIQUE (MACROPROJETO_ID, TURNO)
);

-- Projetos Estratégicos
CREATE TABLE PROJETO (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    UNIDADE_RESPONSAVEL_ID NUMBER(10) NOT NULL,
    NOME VARCHAR2(150) NOT NULL,
    DESCRICAO VARCHAR2(1000),
    DATA_INICIO_PREVISTA DATE,
    DATA_FIM_PREVISTA DATE,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT FK_PROJ_MACRO FOREIGN KEY (MACROPROJETO_ID) REFERENCES MACROPROJETO(ID)
);

-- Subprojetos e Impactos
CREATE TABLE SUBPROJETO (
    ID NUMBER(10) PRIMARY KEY,
    PROJETO_ID NUMBER(10) NOT NULL,
    UNIDADE_RESPONSAVEL_ID NUMBER(10) NOT NULL,
    NOME VARCHAR2(150) NOT NULL,
    DESCRICAO VARCHAR2(1000),
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT FK_SUB_PROJETO FOREIGN KEY (PROJETO_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE
);

CREATE TABLE SUBPROJETO_IMPACTO (
    SUBPROJETO_ID NUMBER(10) NOT NULL,
    PROJETO_IMPACTADO_ID NUMBER(10),
    UNIDADE_IMPACTADA_ID NUMBER(10),
    CONSTRAINT FK_SI_SUBPROJETO FOREIGN KEY (SUBPROJETO_ID) REFERENCES SUBPROJETO(ID) ON DELETE CASCADE
);
```

---

### 4. Componentes e Código PHP Essencial

#### Serviço de Leitura Derivada (`PlanejamentoLeituraDerivadaService.php`)
```php
namespace App\Services\Planejamento;

use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class PlanejamentoLeituraDerivadaService
{
    public function projetosElegiveisPorAtividade(int $macroprojetoId, array $unidadesUsuario): Collection
    {
        if (empty($unidadesUsuario)) {
            return collect();
        }

        return DB::table('VW_TAREFA_STATUS as V')
            ->where('V.MACROPROJETO_ID', $macroprojetoId)
            ->whereIn('V.UNIDADE_RESPONSAVEL_ID', $unidadesUsuario)
            ->whereNotNull('V.PROJETO_ID')
            ->pluck('V.PROJETO_ID')
            ->unique();
    }
}
```

---

### 5. Fronteiras de Integração
- **Módulo de Tarefas e Riscos**: Herança do contexto de Macroprojeto para amarração das atividades e matrizes de risco.
