# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Gestão de Tarefas, Fases e Alertas Automáticos

### 1. Visão Geral e Escopo Funcional
**Propósito**: Acompanhamento operacional de tarefas e atividades eleitorais por fase e categoria, visualização em quadros Kanban e cronogramas Gantt, gestão de solicitações de alteração de prazo, registro de andamentos e motor de envio e agendamento de alertas automáticos por e-mail.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-TAR-001: Estado Derivado da Tarefa (`VW_TAREFA_STATUS`)
- O status funcional de uma tarefa (Em Andamento, Concluída, Atrasada, Não Iniciada) é calculado em tempo de execução pela visão `VW_TAREFA_STATUS` combinando as datas previstas, datas reais de início/fim e andamentos registrados.

#### RN-TAR-002: Edição de Campos Restritos
- A alteração de campos de governança (`NR_PROCESSO_SEI`, `DATA_REAL_INICIO`, `DATA_REAL_FIM`, `FASE_ID`) é restrita a usuários com perfil administrativo do macroprojeto (`PLANELEITO_ADMIN` ou gestor do projeto).

#### RN-TAR-003: Alertas Automáticos de Atraso
- O job `EnviarAlertaTarefasJob` é agendado para varrer tarefas ativas com data fim prevista expirada e sem data real de conclusão.
- Dispara e-mails para os responsáveis das unidades com layout formatado e grava o histórico em `TAREFA_HISTORICO_ALERTA`.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Tarefa Operacional
CREATE TABLE TAREFA (
    ID NUMBER(10) PRIMARY KEY,
    SUBPROJETO_ID NUMBER(10) NOT NULL,
    UNIDADE_RESPONSAVEL_ID NUMBER(10) NOT NULL,
    CATEGORIA_ID NUMBER(10) NOT NULL,
    FASE_ID NUMBER(10) NOT NULL,
    DESCRICAO VARCHAR2(500) NOT NULL,
    DATA_INICIO_PREVISTA DATE NOT NULL,
    DATA_FIM_PREVISTA DATE NOT NULL,
    DATA_REAL_INICIO DATE,
    DATA_REAL_FIM DATE,
    NR_PROCESSO_SEI VARCHAR2(50),
    LOTE_ID NUMBER(10),
    CONSTRAINT FK_TAR_SUBPROJETO FOREIGN KEY (SUBPROJETO_ID) REFERENCES SUBPROJETO(ID)
);

-- Solicitações de Prorrogação de Prazo
CREATE TABLE TAREFA_SOLICITACAO_PRAZO (
    ID NUMBER(10) PRIMARY KEY,
    TAREFA_ID NUMBER(10) NOT NULL,
    NOVA_DATA_FIM_SOLICITADA DATE NOT NULL,
    JUSTIFICATIVA VARCHAR2(1000) NOT NULL,
    STATUS VARCHAR2(20) DEFAULT 'PENDENTE' NOT NULL, -- PENDENTE, APROVADO, REJEITADO
    JUSTIFICATIVA_DECISAO VARCHAR2(1000),
    SOLICITANTE_USERNAME VARCHAR2(100) NOT NULL,
    APROVADOR_USERNAME VARCHAR2(100),
    DT_SOLICITACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DT_DECISAO TIMESTAMP,
    CONSTRAINT FK_TSP_TAREFA FOREIGN KEY (TAREFA_ID) REFERENCES TAREFA(ID) ON DELETE CASCADE
);

-- Visão Status Calculado
-- VW_TAREFA_STATUS: Projetada a partir de TAREFA, SUBPROJETO, PROJETO, UNIDADE e FASE.
```

---

### 4. Componentes e Código PHP Essencial

#### Job de Disparo de Alertas (`EnviarAlertaTarefasJob.php`)
```php
namespace App\Jobs\Tarefas;

use App\Repositories\Tarefas\Contracts\TarefaConsultaRepositoryInterface;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Mail;

class EnviarAlertaTarefasJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function handle(TarefaConsultaRepositoryInterface $repository): void
    {
        $atrasadas = $repository->buscarTarefasAtrasadasSemAlertaHoje();

        foreach ($atrasadas as $tarefa) {
            if (!empty($tarefa->email_responsavel)) {
                Mail::to($tarefa->email_responsavel)
                    ->send(new \App\Mail\Tarefas\AlertaTarefaAtrasadaMail($tarefa));
                    
                $repository->registrarHistoricoAlerta($tarefa->id, $tarefa->email_responsavel);
            }
        }
    }
}
```

---

### 5. Fronteiras de Integração
- **E-mail (SMTP)**: Envio automático de alertas de vencimento e relatórios de pendência.
