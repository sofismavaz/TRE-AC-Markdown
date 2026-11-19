# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_forcas_seguranca`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 3  
> **Tamanho do Arquivo:** 9 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/NotificacaoAtrasoRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_NOTIFICACAOATRASOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/NotificacaoAtrasoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class NotificacaoAtrasoRequest extends FormRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function authorize(): bool
public function rules(): array
protected function prepareForValidation(): void
public function messages(): array
public function withValidator($validator)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use App\Support\Tarefas\TarefaStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class NotificacaoAtrasoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $assuntoRules = ['nullable', 'string', 'max:255'];
        if ($this->routeIs('tarefas.alertas.enviar', 'tarefas.alertas.enviar.imediato')) {
            $assuntoRules[] = 'required';
        }

        return [
            'status' => ['required', 'array', 'min:1'],
            'status.*' => ['string', Rule::in(TarefaStatus::OPCOES)],
            'data_prevista_inicio_de' => ['nullable', 'date_format:Y-m-d'],
            'data_prevista_fim_ate' => ['nullable', 'date_format:Y-m-d', 'after_or_equal:data_prevista_inicio_de'],
            'projeto_id' => ['nullable', 'integer'],
            'subprojeto_id' => ['nullable', 'array'],
            'subprojeto_id.*' => ['integer'],
            'unidade_id' => ['nullable', 'integer'],
            'incluir_unidade_tarefa' => ['nullable', 'boolean'],
            'incluir_unidade_subprojeto' => ['nullable', 'boolean'],
            'incluir_unidade_projeto' => ['nullable', 'boolean'],
            'assunto' => $assuntoRules,
            'mensagem' => ['nullable', 'string'],
            'preview_confirmado' => $this->routeIs('tarefas.alertas.enviar', 'tarefas.alertas.enviar.imediato')
                ? ['required', 'accepted']
                : ['nullable'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $subprojetos = $this->input('subprojeto_id', []);
        if (!is_array($subprojetos)) {
            $subprojetos = $subprojetos !== null && $subprojetos !== '' ? [$subprojetos] : [];
        }

        $subprojetos = collect($subprojetos)
            ->map(static fn ($id) => is_numeric($id) ? (int) $id : null)
            ->filter(static fn ($id) => $id !== null && $id > 0)
            ->unique()
            ->values()
            ->all();

        $this->merge([
            'incluir_unidade_tarefa' => $this->boolean('incluir_unidade_tarefa'),
            'incluir_unidade_subprojeto' => $this->boolean('incluir_unidade_subprojeto'),
            'incluir_unidade_projeto' => $this->boolean('incluir_unidade_projeto'),
            'subprojeto_id' => $subprojetos,
        ]);
    }

    public function messages(): array
    {
        return [
            'status.required' => 'Selecione ao menos um status.',
            'status.*.in' => 'Status inválido informado.',
            'data_prevista_fim_ate.after_or_equal' => 'A data final precisa ser maior ou igual à data inicial.',
            'assunto.required' => 'Informe o assunto para o e-mail.',
            'preview_confirmado.accepted' => 'Visualize os destinatários e as tarefas antes de solicitar o envio.',
        ];
    }

    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            $tarefa = $this->boolean('incluir_unidade_tarefa');
            $subprojeto = $this->boolean('incluir_unidade_subprojeto');
            $projeto = $this->boolean('incluir_unidade_projeto');

            if (!$tarefa && !$subprojeto && !$projeto) {
                $validator->errors()->add('destinatarios', 'Selecione ao menos um tipo de destinatário para receber o alerta.');
            }
        });
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_NOTIFICACAOATRASOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_03_04_170000_create_ce_candidatura_notificacao_table.php`
## <DATABASE_MIGRATIONS_2026_03_04_170000_CREATE_CE_CANDIDATURA_NOTIFICACAO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_03_04_170000_create_ce_candidatura_notificacao_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_candidatura_notificacao (
    id                    NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    candidatura_id        NUMBER                                  NOT NULL,
    status_candidatura    VARCHAR2(20 CHAR)                       NOT NULL,
    email_destino         VARCHAR2(200 CHAR)                      NOT NULL,
    assunto               VARCHAR2(250 CHAR),
    enviado               NUMBER(1)          DEFAULT 0            NOT NULL,
    dt_primeira_tentativa DATE,
    dt_ultimo_envio       DATE,
    tentativas            NUMBER             DEFAULT 0            NOT NULL,
    erro_ultimo_envio     VARCHAR2(2000 CHAR),
    payload_json          CLOB,
    dt_criacao            DATE               DEFAULT SYSDATE      NOT NULL,
    dt_atualizacao        DATE,
    CONSTRAINT fk_ce_cand_notif_candidatura
        FOREIGN KEY (candidatura_id) REFERENCES ce_candidatura_colaborador(id) ON DELETE CASCADE,
    CONSTRAINT ck_ce_cand_notif_status
        CHECK (status_candidatura IN ('DEFERIDA', 'INDEFERIDA')),
    CONSTRAINT ck_ce_cand_notif_enviado
        CHECK (enviado IN (0, 1))
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_ce_cand_notif_01 ON ce_candidatura_notificacao (candidatura_id, status_candidatura)');
        DB::statement('CREATE INDEX ix_ce_cand_notif_01 ON ce_candidatura_notificacao (enviado, status_candidatura)');
        DB::statement('CREATE INDEX ix_ce_cand_notif_02 ON ce_candidatura_notificacao (dt_criacao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ce_candidatura_notificacao');
    }
};
```
</DATABASE_MIGRATIONS_2026_03_04_170000_CREATE_CE_CANDIDATURA_NOTIFICACAO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_06_130000_expand_ce_candidatura_notificacao_status_for_cancelada.php`
## <DATABASE_MIGRATIONS_2026_08_06_130000_EXPAND_CE_CANDIDATURA_NOTIFICACAO_STATUS_FOR_CANCELADA_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_06_130000_expand_ce_candidatura_notificacao_status_for_cancelada.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function constraintExists(string $table, string $constraint): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        if ($this->constraintExists('CE_CANDIDATURA_NOTIFICACAO', 'CK_CE_CAND_NOTIF_STATUS')) {
            DB::statement('ALTER TABLE CE_CANDIDATURA_NOTIFICACAO DROP CONSTRAINT CK_CE_CAND_NOTIF_STATUS');
        }

        DB::statement(<<<'SQL'
ALTER TABLE CE_CANDIDATURA_NOTIFICACAO
ADD CONSTRAINT CK_CE_CAND_NOTIF_STATUS
CHECK (STATUS_CANDIDATURA IN ('DEFERIDA', 'INDEFERIDA', 'CANCELADA'))
SQL);
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
DELETE FROM CE_CANDIDATURA_NOTIFICACAO
WHERE STATUS_CANDIDATURA = 'CANCELADA'
SQL);

        if ($this->constraintExists('CE_CANDIDATURA_NOTIFICACAO', 'CK_CE_CAND_NOTIF_STATUS')) {
            DB::statement('ALTER TABLE CE_CANDIDATURA_NOTIFICACAO DROP CONSTRAINT CK_CE_CAND_NOTIF_STATUS');
        }

        DB::statement(<<<'SQL'
ALTER TABLE CE_CANDIDATURA_NOTIFICACAO
ADD CONSTRAINT CK_CE_CAND_NOTIF_STATUS
CHECK (STATUS_CANDIDATURA IN ('DEFERIDA', 'INDEFERIDA'))
SQL);
    }

    private function constraintExists(string $table, string $constraint): bool
    {
        $registro = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS TOTAL
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = :table_name
  AND CONSTRAINT_NAME = :constraint_name
SQL, [
            'table_name' => strtoupper($table),
            'constraint_name' => strtoupper($constraint),
        ]);

        return (int) ($registro->total ?? 0) > 0;
    }
};
```
</DATABASE_MIGRATIONS_2026_08_06_130000_EXPAND_CE_CANDIDATURA_NOTIFICACAO_STATUS_FOR_CANCELADA_PHP>

