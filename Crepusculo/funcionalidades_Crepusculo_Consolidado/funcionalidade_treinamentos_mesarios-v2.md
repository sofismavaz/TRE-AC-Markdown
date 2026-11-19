# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Treinamentos de Mesários

### 1. Visão Geral e Escopo Funcional
**Propósito**: Gestão de turmas de treinamento presenciais e EAD para mesários convocados, reconciliação de dados com o sistema ELO/TSE, controle de presenças, emissão de listas de presença em PDF/XLSX e certificados.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-TRE-001: Reconciliação Transacional de Turmas ELO/TSE
- As turmas e convocados são consumidos da visão remota do TSE (`VW_CONVOCACAO_TREINAMENTO@cad_tse`) para o processo eleitoral 1219.
- A chave única da turma no sistema é `cod_objeto_turma_pe`.
- A sincronização atualiza os dados em `TREINAMENTO_TSE_TURMA` e `TREINAMENTO_TSE_CONVOCADO` sem executar TRUNCATE, preservando as complementações e observações locais registradas pelos chefes de cartório.

#### RN-TRE-002: Escopo Zonal por Convocado
- Os convocados de uma turma são filtrados pelas zonas eleitorais do usuário logado. Uma turma multizona exibe apenas os convocados das zonas que o usuário possui permissão para visualizar.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Turmas Sincronizadas do TSE
CREATE TABLE TREINAMENTO_TSE_TURMA (
    ID NUMBER(10) PRIMARY KEY,
    COD_OBJETO_TURMA_PE VARCHAR2(50) NOT NULL UNIQUE,
    PROCESSO_ELEITORAL_ID NUMBER(10) NOT NULL,
    ZONA_NUM NUMBER(5) NOT NULL,
    NOME_TURMA VARCHAR2(150) NOT NULL,
    INSTRUTOR_NOME VARCHAR2(150),
    LOCAL_TREINAMENTO VARCHAR2(255),
    DATA_INICIO TIMESTAMP NOT NULL,
    DATA_FIM TIMESTAMP NOT NULL,
    TOTAL_CONVOCADOS NUMBER(5) DEFAULT 0 NOT NULL,
    DT_SINCRONIZACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Convocados da Turma
CREATE TABLE TREINAMENTO_TSE_CONVOCADO (
    ID NUMBER(10) PRIMARY KEY,
    TURMA_ID NUMBER(10) NOT NULL,
    NUM_INSCRICAO VARCHAR2(12) NOT NULL, -- Título Eleitoral
    NOME VARCHAR2(150) NOT NULL,
    ZONA_TRABALHO NUMBER(5) NOT NULL,
    PRESENCA_CONFIRMADA NUMBER(1) DEFAULT 0 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_TTC_TURMA FOREIGN KEY (TURMA_ID) REFERENCES TREINAMENTO_TSE_TURMA(ID) ON DELETE CASCADE
);

-- Visao de Servidores Auxiliares de Instrutoria
-- VW_SERVIDOR_FOR_TREINAMENTO: Visão corporativa contendo a relação de servidores ativos habilitados para instrutoria.
```

---

### 4. Componentes e Código PHP Essencial

#### Serviço de Sincronização de Turmas (`TreinamentoTseSyncService.php`)
```php
namespace App\Services\Treinamentos;

use App\Repositories\Treinamentos\Contracts\TreinamentoTseSyncRepositoryInterface;
use Exception;

class TreinamentoTseSyncService
{
    public function __construct(private readonly TreinamentoTseSyncRepositoryInterface $repository) {}

    public function executarSincronizacao(): array
    {
        try {
            $turmasRemotas = $this->repository->consultarOrigemRemotaTse();
            $totalProcessado = $this->repository->sincronizarSemTruncate($turmasRemotas);

            return ['sucesso' => true, 'total' => $totalProcessado];
        } catch (Exception $e) {
            return ['sucesso' => false, 'erro' => $e->getMessage()];
        }
    }
}
```

---

### 5. Fronteiras de Integração
- **ELO / TSE**: Conexão DBLINK (`@cad_tse`) para carga e sincronização de turmas e nomeações.
