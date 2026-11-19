# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_database_migrations`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 54  
> **Tamanho do Arquivo:** 198 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/0001_01_01_000000_create_users_table.php`
## <DATABASE_MIGRATIONS_0001_01_01_000000_CREATE_USERS_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/0001_01_01_000000_create_users_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('users', function (Blueprint $table) {
Schema::create('password_reset_tokens', function (Blueprint $table) {
Schema::create('sessions', function (Blueprint $table) {
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
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
    }
};
```
</DATABASE_MIGRATIONS_0001_01_01_000000_CREATE_USERS_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/0001_01_01_000001_create_cache_table.php`
## <DATABASE_MIGRATIONS_0001_01_01_000001_CREATE_CACHE_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/0001_01_01_000001_create_cache_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('cache', function (Blueprint $table) {
Schema::create('cache_locks', function (Blueprint $table) {
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
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cache', function (Blueprint $table) {
            $table->string('key')->primary();
            $table->mediumText('value');
            $table->integer('expiration');
        });

        Schema::create('cache_locks', function (Blueprint $table) {
            $table->string('key')->primary();
            $table->string('owner');
            $table->integer('expiration');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cache');
        Schema::dropIfExists('cache_locks');
    }
};
```
</DATABASE_MIGRATIONS_0001_01_01_000001_CREATE_CACHE_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/0001_01_01_000002_create_jobs_table.php`
## <DATABASE_MIGRATIONS_0001_01_01_000002_CREATE_JOBS_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/0001_01_01_000002_create_jobs_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('jobs', function (Blueprint $table) {
Schema::create('job_batches', function (Blueprint $table) {
Schema::create('failed_jobs', function (Blueprint $table) {
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
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('jobs', function (Blueprint $table) {
            $table->id();
            $table->string('queue')->index();
            $table->longText('payload');
            $table->unsignedTinyInteger('attempts');
            $table->unsignedInteger('reserved_at')->nullable();
            $table->unsignedInteger('available_at');
            $table->unsignedInteger('created_at');
        });

        Schema::create('job_batches', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->string('name');
            $table->integer('total_jobs');
            $table->integer('pending_jobs');
            $table->integer('failed_jobs');
            $table->longText('failed_job_ids');
            $table->mediumText('options')->nullable();
            $table->integer('cancelled_at')->nullable();
            $table->integer('created_at');
            $table->integer('finished_at')->nullable();
        });

        Schema::create('failed_jobs', function (Blueprint $table) {
            $table->id();
            $table->string('uuid')->unique();
            $table->text('connection');
            $table->text('queue');
            $table->longText('payload');
            $table->longText('exception');
            $table->timestamp('failed_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jobs');
        Schema::dropIfExists('job_batches');
        Schema::dropIfExists('failed_jobs');
    }
};
```
</DATABASE_MIGRATIONS_0001_01_01_000002_CREATE_JOBS_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_02_01_000000_create_restore_legacy_baseline_tables.php`
## <DATABASE_MIGRATIONS_2026_02_01_000000_CREATE_RESTORE_LEGACY_BASELINE_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_02_01_000000_create_restore_legacy_baseline_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
foreach ($this->tables() as $table => $statements) {
return DB::table('user_objects')
return DB::table('user_indexes')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function tables(): array
private function views(): array
private function execute(string $sql): void
private function objectExists(string $name, string $type): bool
private function indexExists(string $name): bool
private function dropViewIfExists(string $view): void
private function dropTableIfExists(string $table): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Baseline para tabelas herdadas que existiam no Oracle, mas nao tinham CREATE TABLE versionado.
     *
     * Esta migration deve rodar antes das migrations incrementais antigas que alteram essas tabelas.
     * Tabelas sincronizadas recebem apenas DDL; a carga continua sendo responsabilidade dos comandos de sync.
     */
    public function up(): void
    {
        foreach ($this->tables() as $table => $statements) {
            if (!$this->objectExists($table, 'TABLE')) {
                $this->execute($statements[0]['sql']);
            }

            foreach (array_slice($statements, 1) as $statement) {
                if ($statement['kind'] === 'INDEX' && $statement['name'] !== null && $this->indexExists($statement['name'])) {
                    continue;
                }

                $this->execute($statement['sql']);
            }
        }

        foreach ($this->views() as $view => $sql) {
            if (!$this->objectExists($view, 'VIEW')) {
                $this->execute($sql);
            }
        }
    }

    public function down(): void
    {
        foreach (array_reverse(array_keys($this->views())) as $view) {
            $this->dropViewIfExists($view);
        }

        foreach (array_reverse(array_keys($this->tables())) as $table) {
            $this->dropTableIfExists($table);
        }
    }

    /**
     * @return array<string, array<int, array{kind:string,name:?string,sql:string}>>
     */
    private function tables(): array
    {
        return [
            'ACESSO' => [
            [
                'kind' => 'TABLE',
                'name' => 'ACESSO',
                'sql' => <<<'SQL'
CREATE TABLE "ACESSO" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(120 CHAR) NOT NULL ENABLE, 
	"IDHTML" VARCHAR2(60 CHAR), 
	 CONSTRAINT "UK_ACESSO_DESCRICAO" UNIQUE ("DESCRICAO")
  USING INDEX  ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'ENERGIA' => [
            [
                'kind' => 'TABLE',
                'name' => 'ENERGIA',
                'sql' => <<<'SQL'
CREATE TABLE "ENERGIA" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 5 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(120 CHAR) NOT NULL ENABLE, 
	"IDHTML" VARCHAR2(60 CHAR), 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UK_ENERGIA_DESCRICAO" UNIQUE ("DESCRICAO")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'INTERNET' => [
            [
                'kind' => 'TABLE',
                'name' => 'INTERNET',
                'sql' => <<<'SQL'
CREATE TABLE "INTERNET" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 8 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(100 CHAR) NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UK_INTERNET_DESCRICAO" UNIQUE ("DESCRICAO")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'ZONA' => [
            [
                'kind' => 'TABLE',
                'name' => 'ZONA',
                'sql' => <<<'SQL'
CREATE TABLE "ZONA" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 86 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NUM_ZONA" NUMBER(5,0) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(150 CHAR) NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UK_ZONA_NUM" UNIQUE ("NUM_ZONA")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'BAIRRO' => [
            [
                'kind' => 'TABLE',
                'name' => 'BAIRRO',
                'sql' => <<<'SQL'
CREATE TABLE "BAIRRO" 
   (	"COD_OBJETO" VARCHAR2(18), 
	"NOM_BAIRRO" VARCHAR2(60), 
	"COD_OBJETO_LOCALIDADE" VARCHAR2(18)
   )
SQL,
            ],
            ],
            'LOCAL_VOTACAO_ST' => [
            [
                'kind' => 'TABLE',
                'name' => 'LOCAL_VOTACAO_ST',
                'sql' => <<<'SQL'
CREATE TABLE "LOCAL_VOTACAO_ST" 
   (	"COD_OBJETO" VARCHAR2(18), 
	"NOM_LOCAL" VARCHAR2(70), 
	"NUM_LOCAL" NUMBER, 
	"COD_OBJETO_ZONA" VARCHAR2(18), 
	"COD_OBJETO_LOCALIDADE" VARCHAR2(18), 
	"COD_OBJETO_BAIRRO" VARCHAR2(18), 
	"DES_ENDERECO" VARCHAR2(70), 
	"NUM_CEP" VARCHAR2(8), 
	"TIP_LOCAL" NUMBER, 
	"NUM_LATITUDE" NUMBER, 
	"NUM_LONGITUDE" NUMBER, 
	"NOM_LOCALIDADE" VARCHAR2(50), 
	"SITUACAO" NUMBER, 
	"QTD_SECOES_PREVISTAS" NUMBER, 
	"QTD_ELEITORES_SECAO" NUMBER, 
	 CONSTRAINT "PK_LV_ST" PRIMARY KEY ("COD_OBJETO")
  USING INDEX  ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_COD_OBJETO_BAIRRO_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_COD_OBJETO_BAIRRO_IDX" ON "LOCAL_VOTACAO_ST" ("COD_OBJETO_BAIRRO")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_COD_OBJETO_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_COD_OBJETO_IDX" ON "LOCAL_VOTACAO_ST" ("COD_OBJETO", "COD_OBJETO_ZONA", "COD_OBJETO_LOCALIDADE", "COD_OBJETO_BAIRRO")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_COD_OBJETO_ZONA_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_COD_OBJETO_ZONA_IDX" ON "LOCAL_VOTACAO_ST" ("COD_OBJETO_ZONA")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_NOM_LOCALIDADE_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_NOM_LOCALIDADE_IDX" ON "LOCAL_VOTACAO_ST" ("NOM_LOCALIDADE")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_NOM_LOCAL_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_NOM_LOCAL_IDX" ON "LOCAL_VOTACAO_ST" ("NOM_LOCAL", "NUM_LOCAL")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_NOM_LOCAL_IDX_2',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_NOM_LOCAL_IDX_2" ON "LOCAL_VOTACAO_ST" ("NOM_LOCAL")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'LOCAL_VOTACAO_ST_NUM_LOCAL_IDX_2',
                'sql' => <<<'SQL'
CREATE INDEX "LOCAL_VOTACAO_ST_NUM_LOCAL_IDX_2" ON "LOCAL_VOTACAO_ST" ("NUM_LOCAL")
SQL,
            ],
            ],
            'LOCAL_VOTACAO_VAGAS' => [
            [
                'kind' => 'TABLE',
                'name' => 'LOCAL_VOTACAO_VAGAS',
                'sql' => <<<'SQL'
CREATE TABLE "LOCAL_VOTACAO_VAGAS" 
   (	"COD_OBJETO" VARCHAR2(18), 
	"NUM_ZONA" NUMBER(*,0), 
	"NOM_LOCALIDADE" VARCHAR2(50), 
	"NOM_BAIRRO" VARCHAR2(60), 
	"NUM_LOCAL" NUMBER(*,0), 
	"NOM_LOCAL" VARCHAR2(70), 
	"SECOES" CLOB, 
	"QTD_VAGAS_LOCAL" NUMBER, 
	"QTD_ELEITORES_APTOS_LOCAL" NUMBER, 
	"QTD_SECOES_LOCAL" NUMBER
   )
SQL,
            ],
            ],
            'SECOES' => [
            [
                'kind' => 'TABLE',
                'name' => 'SECOES',
                'sql' => <<<'SQL'
CREATE TABLE "SECOES" 
   (	"COD_OBJETO" VARCHAR2(18 CHAR), 
	"COD_OBJETO_LOCAL" VARCHAR2(18 CHAR), 
	"COD_OBJETO_ZONA" VARCHAR2(18 CHAR), 
	"COD_OBJETO_MUNIC" VARCHAR2(18 CHAR), 
	"NUM_SECAO" NUMBER, 
	"QTD_APTOS" NUMBER, 
	"SITUACAO" NUMBER, 
	"QTD_VAGAS_RESERVADAS" NUMBER, 
	"QTD_SUSPENSOS" NUMBER, 
	"COD_OBJETO_UF" VARCHAR2(18 CHAR), 
	 PRIMARY KEY ("COD_OBJETO")
  USING INDEX  ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'SECOES_COD_OBJETO_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "SECOES_COD_OBJETO_IDX" ON "SECOES" ("COD_OBJETO", "COD_OBJETO_LOCAL", "COD_OBJETO_ZONA", "COD_OBJETO_MUNIC")
SQL,
            ],
            ],
            'SECOES_AGREGADAS' => [
            [
                'kind' => 'TABLE',
                'name' => 'SECOES_AGREGADAS',
                'sql' => <<<'SQL'
CREATE TABLE "SECOES_AGREGADAS" 
   (	"COD_OBJETO_SECAO_AGREGADORA" VARCHAR2(18) NOT NULL ENABLE, 
	"COD_OBJETO_SECAO" VARCHAR2(18) NOT NULL ENABLE, 
	"COD_OBJETO_DAT_ELEICAO" VARCHAR2(18), 
	 CONSTRAINT "PK_SECOES_AGREGADAS" PRIMARY KEY ("COD_OBJETO_SECAO_AGREGADORA", "COD_OBJETO_SECAO")
  USING INDEX  ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'SECOES_AGREGADAS_COD_OBJETO_SECAO_AGREGADORA_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "SECOES_AGREGADAS_COD_OBJETO_SECAO_AGREGADORA_IDX" ON "SECOES_AGREGADAS" ("COD_OBJETO_SECAO_AGREGADORA")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'SECOES_AGREGADAS_COD_OBJETO_SECAO_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "SECOES_AGREGADAS_COD_OBJETO_SECAO_IDX" ON "SECOES_AGREGADAS" ("COD_OBJETO_SECAO")
SQL,
            ],
            ],
            'SECAO_ALOCACAO_PROVISORIA' => [
            [
                'kind' => 'TABLE',
                'name' => 'SECAO_ALOCACAO_PROVISORIA',
                'sql' => <<<'SQL'
CREATE TABLE "SECAO_ALOCACAO_PROVISORIA" 
   (	"SGL_UF" VARCHAR2(2), 
	"COD_MUNICIPIO" NUMBER(*,0), 
	"NOM_MUNICIPIO" VARCHAR2(50), 
	"NUM_ZONA" NUMBER(*,0), 
	"NUM_LOCAL" NUMBER(*,0), 
	"NUM_SECAO" NUMBER(*,0), 
	"NUM_LOCAL_PROVISORIO" NUMBER(*,0), 
	"NOM_LOCAL_PROVISORIO" VARCHAR2(70), 
	"ENDERECO_PROVISORIO" VARCHAR2(70), 
	"BAIRRO_PROVISORIO" VARCHAR2(60), 
	"CEP_PROVISORIO" VARCHAR2(8), 
	"TELEFONE_PROVISORIO" VARCHAR2(15), 
	"COD_OBJETO_SECAO" VARCHAR2(18), 
	"COD_OBJETO_LOCAL_PROVISORIO" VARCHAR2(18), 
	"DAT_ELEICAO" TIMESTAMP (6), 
	"COD_OBJETO_DAT_ELEICAO" VARCHAR2(18), 
	"DAT_CRIACAO_ALOC_PROV" TIMESTAMP (6)
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'SECAO_ALOCACAO_PROVISORIA_COD_OBJETO_LOCAL_PROVISORIO_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "SECAO_ALOCACAO_PROVISORIA_COD_OBJETO_LOCAL_PROVISORIO_IDX" ON "SECAO_ALOCACAO_PROVISORIA" ("COD_OBJETO_LOCAL_PROVISORIO")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'SECAO_ALOCACAO_PROVISORIA_COD_OBJETO_SECAO_IDX',
                'sql' => <<<'SQL'
CREATE INDEX "SECAO_ALOCACAO_PROVISORIA_COD_OBJETO_SECAO_IDX" ON "SECAO_ALOCACAO_PROVISORIA" ("COD_OBJETO_SECAO")
SQL,
            ],
            ],
            'ELEITOR' => [
            [
                'kind' => 'TABLE',
                'name' => 'ELEITOR',
                'sql' => <<<'SQL'
CREATE TABLE "ELEITOR" 
   (	"NOM_ELEITOR" VARCHAR2(70), 
	"NOM_PAI" VARCHAR2(70), 
	"DAT_NASC" NUMBER(*,0), 
	"NOM_MAE" VARCHAR2(70), 
	"DES_ENDERECO" VARCHAR2(120), 
	"NUM_CPF" VARCHAR2(11), 
	"NUM_INSCRICAO" VARCHAR2(12), 
	"COD_SEXO" NUMBER(*,0), 
	"COD_OBJETO_SECAO" VARCHAR2(18), 
	"NOM_BAIRRO" VARCHAR2(60), 
	"NUM_ZONA" NUMBER(*,0), 
	"NOM_LOCALIDADE" VARCHAR2(50), 
	"COD_SIT_ELEITOR" NUMBER(*,0), 
	"DAT_DOMIC_UF" TIMESTAMP (6)
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UX_ELEITOR_NUM_INSCRICAO',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UX_ELEITOR_NUM_INSCRICAO" ON "ELEITOR" ("NUM_INSCRICAO")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UX_ELEITOR_SECAO_INSCR',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UX_ELEITOR_SECAO_INSCR" ON "ELEITOR" ("COD_OBJETO_SECAO", "NUM_INSCRICAO")
SQL,
            ],
            ],
            'MUNICIPIO' => [
            [
                'kind' => 'TABLE',
                'name' => 'MUNICIPIO',
                'sql' => <<<'SQL'
CREATE TABLE "MUNICIPIO" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 54 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"ZONAID" NUMBER(10,0) NOT NULL ENABLE, 
	"LOCALIDADE" VARCHAR2(150 CHAR) NOT NULL ENABLE, 
	"COD_OBJETO_LOCALIDADE" VARCHAR2(30 CHAR), 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_MUNICIPIO_ZONA" FOREIGN KEY ("ZONAID")
	  REFERENCES "ZONA" ("ID") ENABLE
   )
SQL,
            ],
            ],
            'LOCAL_TRANSMISSAO' => [
            [
                'kind' => 'TABLE',
                'name' => 'LOCAL_TRANSMISSAO',
                'sql' => <<<'SQL'
CREATE TABLE "LOCAL_TRANSMISSAO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 132 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NOME" VARCHAR2(120) NOT NULL ENABLE, 
	"NUM_LATITUDE" NUMBER, 
	"NUM_LONGITUDE" NUMBER, 
	"COD_OBJETO_LOCALIDADE" VARCHAR2(18) NOT NULL ENABLE, 
	"COD_OBJETO_BAIRRO" VARCHAR2(18) NOT NULL ENABLE, 
	"COD_OBJETO_LOCAL_VOTACAO" VARCHAR2(18 CHAR), 
	 CONSTRAINT "LOCAL_TRANSMISSAO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UX_LOCAL_TRANSMISSAO_COD_OBJETO_LOCAL',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UX_LOCAL_TRANSMISSAO_COD_OBJETO_LOCAL" ON "LOCAL_TRANSMISSAO" ("COD_OBJETO_LOCAL_VOTACAO")
SQL,
            ],
            ],
            'LDA' => [
            [
                'kind' => 'TABLE',
                'name' => 'LDA',
                'sql' => <<<'SQL'
CREATE TABLE "LDA" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 97 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NOME_LOCAL" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"COMUNIDADE" VARCHAR2(255 CHAR), 
	"ENDERECO" VARCHAR2(400 CHAR), 
	"TELEFONE" VARCHAR2(30 CHAR), 
	"LATITUDE" NUMBER(12,8), 
	"LONGITUDE" NUMBER(12,8), 
	"INTERNET_ID" NUMBER(10,0), 
	"ZONA_ID" NUMBER(10,0), 
	"MUNICIPIO_ID" NUMBER(10,0), 
	"OBS" CLOB, 
	"APARELHO_SATELITE" VARCHAR2(10 CHAR), 
	"NUM_LOCAL_ELO" VARCHAR2(20 CHAR), 
	"COD_OBJETO_LOCAL_VOTACAO" VARCHAR2(18 CHAR), 
	"DETALHAMENTO_TRAJETO" CLOB, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_LDA_LOCAL_VOTACAO" FOREIGN KEY ("COD_OBJETO_LOCAL_VOTACAO")
	  REFERENCES "LOCAL_VOTACAO_ST" ("COD_OBJETO") DISABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IX_LDA_COD_OBJETO_LOCAL_VOTACAO',
                'sql' => <<<'SQL'
CREATE INDEX "IX_LDA_COD_OBJETO_LOCAL_VOTACAO" ON "LDA" ("COD_OBJETO_LOCAL_VOTACAO")
SQL,
            ],
            ],
            'TBTRANSMISSAOVOTACAO' => [
            [
                'kind' => 'TABLE',
                'name' => 'TBTRANSMISSAOVOTACAO',
                'sql' => <<<'SQL'
CREATE TABLE "TBTRANSMISSAOVOTACAO" 
   (	"LOCAL_TRANSMISSAO_ID" NUMBER(38,0), 
	"COD_OBJETO_LOCAL" VARCHAR2(18) NOT NULL ENABLE, 
	"ORDEM_PREFERENCIA" NUMBER(3,0) NOT NULL ENABLE, 
	"LDA_ID" NUMBER(10,0), 
	 CONSTRAINT "CK_TBTV_ORIGEM_EXCLUSIVA" CHECK (
    (local_transmissao_id IS NOT NULL AND lda_id IS NULL) OR
    (local_transmissao_id IS NULL AND lda_id IS NOT NULL)
) ENABLE, 
	 CONSTRAINT "FK_TBTV_LDA" FOREIGN KEY ("LDA_ID")
	  REFERENCES "LDA" ("ID") ENABLE NOVALIDATE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UX_TBTRANSMISSAOVOTACAO_LOCAL_LDA',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UX_TBTRANSMISSAOVOTACAO_LOCAL_LDA" ON "TBTRANSMISSAOVOTACAO" ("COD_OBJETO_LOCAL", "LDA_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UX_TBTRANSMISSAOVOTACAO_LOCAL_ORDEM',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UX_TBTRANSMISSAOVOTACAO_LOCAL_ORDEM" ON "TBTRANSMISSAOVOTACAO" ("COD_OBJETO_LOCAL", "ORDEM_PREFERENCIA")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UX_TBTRANSMISSAOVOTACAO_LOCAL_TRANSMISSAO',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UX_TBTRANSMISSAOVOTACAO_LOCAL_TRANSMISSAO" ON "TBTRANSMISSAOVOTACAO" ("COD_OBJETO_LOCAL", "LOCAL_TRANSMISSAO_ID", "LDA_ID")
SQL,
            ],
            ],
            'TBLDAACESSO' => [
            [
                'kind' => 'TABLE',
                'name' => 'TBLDAACESSO',
                'sql' => <<<'SQL'
CREATE TABLE "TBLDAACESSO" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 278 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"LDA_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"ACESSO_ID" NUMBER(10,0) NOT NULL ENABLE, 
	 CONSTRAINT "UK_TBLDAACESSO" UNIQUE ("LDA_ID", "ACESSO_ID")
  USING INDEX  ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_TBLDAACESSO_LDA" FOREIGN KEY ("LDA_ID")
	  REFERENCES "LDA" ("ID") ENABLE, 
	 CONSTRAINT "FK_TBLDAACESSO_ACESSO" FOREIGN KEY ("ACESSO_ID")
	  REFERENCES "ACESSO" ("ID") ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_TBLDAACESSO_ACESSO',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_TBLDAACESSO_ACESSO" ON "TBLDAACESSO" ("ACESSO_ID")
SQL,
            ],
            ],
            'TBLDAENERGIA' => [
            [
                'kind' => 'TABLE',
                'name' => 'TBLDAENERGIA',
                'sql' => <<<'SQL'
CREATE TABLE "TBLDAENERGIA" 
   (	"ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 160 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"LDA_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"ENERGIA_ID" NUMBER(10,0) NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UK_TBLDAENERGIA" UNIQUE ("LDA_ID", "ENERGIA_ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_TBLDAENERGIA_LDA" FOREIGN KEY ("LDA_ID")
	  REFERENCES "LDA" ("ID") ENABLE, 
	 CONSTRAINT "FK_TBLDAENERGIA_ENERGIA" FOREIGN KEY ("ENERGIA_ID")
	  REFERENCES "ENERGIA" ("ID") ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_TBLDAENERGIA_ENERGIA',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_TBLDAENERGIA_ENERGIA" ON "TBLDAENERGIA" ("ENERGIA_ID")
SQL,
            ],
            ],
            'ROTA' => [
            [
                'kind' => 'TABLE',
                'name' => 'ROTA',
                'sql' => <<<'SQL'
CREATE TABLE "ROTA" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 70 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NUMERO" NUMBER NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(255) NOT NULL ENABLE, 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DT_ATUALIZACAO" DATE, 
	"ZONA_ID" NUMBER(19,0), 
	"MUNICIPIO_ID" NUMBER(19,0), 
	 CONSTRAINT "UK_ROTA_NUMERO" UNIQUE ("NUMERO")
  USING INDEX  ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_ROTA_ZONA" FOREIGN KEY ("ZONA_ID")
	  REFERENCES "ZONA" ("ID") ENABLE, 
	 CONSTRAINT "FK_ROTA_MUNICIPIO" FOREIGN KEY ("MUNICIPIO_ID")
	  REFERENCES "MUNICIPIO" ("ID") ENABLE
   )
SQL,
            ],
            ],
            'ROTA_LOCAL' => [
            [
                'kind' => 'TABLE',
                'name' => 'ROTA_LOCAL',
                'sql' => <<<'SQL'
CREATE TABLE "ROTA_LOCAL" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 313 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"ROTA_ID" NUMBER NOT NULL ENABLE, 
	"COD_OBJETO_LOCAL" VARCHAR2(18) NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "UK_ROTA_LOCAL" UNIQUE ("ROTA_ID", "COD_OBJETO_LOCAL")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_ROTA_LOCAL_ROTA" FOREIGN KEY ("ROTA_ID")
	  REFERENCES "ROTA" ("ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "FK_ROTA_LOCAL_LOC" FOREIGN KEY ("COD_OBJETO_LOCAL")
	  REFERENCES "LOCAL_VOTACAO_ST" ("COD_OBJETO") DISABLE
   )
SQL,
            ],
            ],
            'CATEGORIA_TAREFA' => [
            [
                'kind' => 'TABLE',
                'name' => 'CATEGORIA_TAREFA',
                'sql' => <<<'SQL'
CREATE TABLE "CATEGORIA_TAREFA" 
   (	"ID" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 72 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NOME" VARCHAR2(150) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(500), 
	"ATIVO" CHAR(1) DEFAULT 'S' NOT NULL ENABLE, 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DT_ATUALIZACAO" DATE, 
	 CONSTRAINT "CK_CAT_TAR_ATIVO" CHECK (ATIVO IN ('S','N')) ENABLE, 
	 CONSTRAINT "UK_CAT_TAR_NOME" UNIQUE ("NOME")
  USING INDEX  ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'ESTADO_TAREFA' => [
            [
                'kind' => 'TABLE',
                'name' => 'ESTADO_TAREFA',
                'sql' => <<<'SQL'
CREATE TABLE "ESTADO_TAREFA" 
   (	"ID" NUMBER, 
	"NOME" VARCHAR2(50 CHAR) NOT NULL ENABLE, 
	"ORDEM" NUMBER NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'FASE_TAREFA' => [
            [
                'kind' => 'TABLE',
                'name' => 'FASE_TAREFA',
                'sql' => <<<'SQL'
CREATE TABLE "FASE_TAREFA" 
   (	"ID" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 242 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NOME" VARCHAR2(150) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(500), 
	"ATIVO" CHAR(1) DEFAULT 'S' NOT NULL ENABLE, 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DT_ATUALIZACAO" DATE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "CK_FASE_TAR_ATIVO" CHECK (ATIVO IN ('S','N')) ENABLE, 
	 CONSTRAINT "UK_FASE_TAR_NOME" UNIQUE ("NOME")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'GRUPO_UNIDADE' => [
            [
                'kind' => 'TABLE',
                'name' => 'GRUPO_UNIDADE',
                'sql' => <<<'SQL'
CREATE TABLE "GRUPO_UNIDADE" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NOME" VARCHAR2(150) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(500), 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DT_ATUALIZACAO" DATE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'GRUPO_UNIDADE_MEMBRO' => [
            [
                'kind' => 'TABLE',
                'name' => 'GRUPO_UNIDADE_MEMBRO',
                'sql' => <<<'SQL'
CREATE TABLE "GRUPO_UNIDADE_MEMBRO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 10 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"GRUPO_ID" NUMBER NOT NULL ENABLE, 
	"UNIDADE_ID" NUMBER NOT NULL ENABLE, 
	 UNIQUE ("GRUPO_ID", "UNIDADE_ID")
  USING INDEX  ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 FOREIGN KEY ("GRUPO_ID")
	  REFERENCES "GRUPO_UNIDADE" ("ID") ON DELETE CASCADE ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_GRUPO_UNIDADE_MEMBRO_GRUPO',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_GRUPO_UNIDADE_MEMBRO_GRUPO" ON "GRUPO_UNIDADE_MEMBRO" ("GRUPO_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_GRUPO_UNIDADE_MEMBRO_UNIDADE',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_GRUPO_UNIDADE_MEMBRO_UNIDADE" ON "GRUPO_UNIDADE_MEMBRO" ("UNIDADE_ID")
SQL,
            ],
            ],
            'TAREFA_LOTE' => [
            [
                'kind' => 'TABLE',
                'name' => 'TAREFA_LOTE',
                'sql' => <<<'SQL'
CREATE TABLE "TAREFA_LOTE" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 3 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"LOTE_UUID" VARCHAR2(50) NOT NULL ENABLE, 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 UNIQUE ("LOTE_UUID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'PROJETO' => [
            [
                'kind' => 'TABLE',
                'name' => 'PROJETO',
                'sql' => <<<'SQL'
CREATE TABLE "PROJETO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 263 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NOME" VARCHAR2(120 CHAR) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(4000 CHAR), 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DATA_INICIO" DATE, 
	"DATA_FIM" DATE, 
	"UNIDADE_ID" NUMBER, 
	"MACROPROJETO_ID" NUMBER, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_PROJETO_MACROPROJETO',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_PROJETO_MACROPROJETO" ON "PROJETO" ("MACROPROJETO_ID")
SQL,
            ],
            ],
            'SUBPROJETO' => [
            [
                'kind' => 'TABLE',
                'name' => 'SUBPROJETO',
                'sql' => <<<'SQL'
CREATE TABLE "SUBPROJETO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 270 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"PROJETO_ID" NUMBER NOT NULL ENABLE, 
	"NOME" VARCHAR2(120 CHAR) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(4000 CHAR), 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DATA_INICIO" DATE, 
	"DATA_FIM" DATE, 
	"UNIDADE_ID" NUMBER(*,0), 
	"GERENTE_ID" NUMBER(*,0), 
	"NORMATIVOS" VARCHAR2(4000 CHAR), 
	"METAS" VARCHAR2(4000 CHAR), 
	"INDICADORES" VARCHAR2(4000 CHAR), 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_SUBPROJETO_PROJETO" FOREIGN KEY ("PROJETO_ID")
	  REFERENCES "PROJETO" ("ID") ON DELETE CASCADE ENABLE
   )
SQL,
            ],
            ],
            'SUBPROJETO_IMPACTO' => [
            [
                'kind' => 'TABLE',
                'name' => 'SUBPROJETO_IMPACTO',
                'sql' => <<<'SQL'
CREATE TABLE "SUBPROJETO_IMPACTO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 30 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"SUBPROJETO_ID" NUMBER NOT NULL ENABLE, 
	"TIPO" VARCHAR2(20) NOT NULL ENABLE, 
	"PROJETO_ID" NUMBER, 
	"SUBPROJETO_ALVO_ID" NUMBER, 
	"UNIDADE_ID" NUMBER, 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "CHK_SI_ALVO" CHECK (
            (TIPO = 'PROJETO'    AND PROJETO_ID IS NOT NULL AND SUBPROJETO_ALVO_ID IS NULL AND UNIDADE_ID IS NULL) OR
            (TIPO = 'SUBPROJETO' AND PROJETO_ID IS NULL     AND SUBPROJETO_ALVO_ID IS NOT NULL AND UNIDADE_ID IS NULL) OR
            (TIPO = 'UNIDADE'    AND PROJETO_ID IS NULL     AND SUBPROJETO_ALVO_ID IS NULL     AND UNIDADE_ID IS NOT NULL)
        ) ENABLE, 
	 CONSTRAINT "CHK_SI_TIPO" CHECK (TIPO IN ('PROJETO','SUBPROJETO','UNIDADE')) ENABLE, 
	 CONSTRAINT "FK_SI_SUBPROJETO" FOREIGN KEY ("SUBPROJETO_ID")
	  REFERENCES "SUBPROJETO" ("ID") ENABLE, 
	 CONSTRAINT "FK_SI_PROJETO" FOREIGN KEY ("PROJETO_ID")
	  REFERENCES "PROJETO" ("ID") ENABLE, 
	 CONSTRAINT "FK_SI_SUBPROJETO_ALVO" FOREIGN KEY ("SUBPROJETO_ALVO_ID")
	  REFERENCES "SUBPROJETO" ("ID") ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_SI_SUBPROJETO',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_SI_SUBPROJETO" ON "SUBPROJETO_IMPACTO" ("SUBPROJETO_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'UK_SI_ALVO',
                'sql' => <<<'SQL'
CREATE UNIQUE INDEX "UK_SI_ALVO" ON "SUBPROJETO_IMPACTO" ("SUBPROJETO_ID", "TIPO", NVL("PROJETO_ID",NVL("SUBPROJETO_ALVO_ID","UNIDADE_ID")))
SQL,
            ],
            ],
            'TAREFA' => [
            [
                'kind' => 'TABLE',
                'name' => 'TAREFA',
                'sql' => <<<'SQL'
CREATE TABLE "TAREFA" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 202 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"SUBPROJETO_ID" NUMBER NOT NULL ENABLE, 
	"UNIDADE_ID" NUMBER NOT NULL ENABLE, 
	"NOME" VARCHAR2(150 CHAR) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(4000 CHAR), 
	"DATA_PREVISTA_INICIO" DATE NOT NULL ENABLE, 
	"DATA_PREVISTA_FIM" DATE NOT NULL ENABLE, 
	"DATA_REAL_INICIO" DATE, 
	"DATA_REAL_FIM" DATE, 
	"DT_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"OBSERVACAO" VARCHAR2(200), 
	"GRUPO_UNIDADE_ID" NUMBER, 
	"LOTE_ID" NUMBER, 
	"HORAS_EXTRAS" NUMBER(10,2), 
	"PESSOAS_ENVOLVIDAS" NUMBER(6,0), 
	"CATEGORIA_ID" NUMBER, 
	"NR_PROCESSO_SEI" VARCHAR2(40), 
	"FASE_ID" NUMBER(38,0), 
	 CONSTRAINT "PK_TAREFA" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "FK_TAREFA_SUBPROJETO" FOREIGN KEY ("SUBPROJETO_ID")
	  REFERENCES "SUBPROJETO" ("ID") ON DELETE CASCADE ENABLE, 
	 FOREIGN KEY ("GRUPO_UNIDADE_ID")
	  REFERENCES "GRUPO_UNIDADE" ("ID") ENABLE, 
	 FOREIGN KEY ("LOTE_ID")
	  REFERENCES "TAREFA_LOTE" ("ID") ENABLE, 
	 CONSTRAINT "FK_TAREFA_CATEGORIA" FOREIGN KEY ("CATEGORIA_ID")
	  REFERENCES "CATEGORIA_TAREFA" ("ID") ENABLE, 
	 CONSTRAINT "FK_TAREFA_FASE" FOREIGN KEY ("FASE_ID")
	  REFERENCES "FASE_TAREFA" ("ID") ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_TAREFA_CATEGORIA',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_TAREFA_CATEGORIA" ON "TAREFA" ("CATEGORIA_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_TAREFA_FASE',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_TAREFA_FASE" ON "TAREFA" ("FASE_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_TAREFA_LOTE',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_TAREFA_LOTE" ON "TAREFA" ("LOTE_ID")
SQL,
            ],
            ],
            'RISCO' => [
            [
                'kind' => 'TABLE',
                'name' => 'RISCO',
                'sql' => <<<'SQL'
CREATE TABLE "RISCO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"TITULO" VARCHAR2(150) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(2000), 
	"PROBABILIDADE" VARCHAR2(20) NOT NULL ENABLE, 
	"IMPACTO" VARCHAR2(20) NOT NULL ENABLE, 
	"NIVEL" VARCHAR2(30), 
	"STATUS" VARCHAR2(30) DEFAULT 'ABERTO' NOT NULL ENABLE, 
	"UNIDADE_ID" NUMBER(38,0), 
	"DATA_REGISTRO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"DATA_ATUALIZACAO" DATE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
SQL,
            ],
            ],
            'RISCO_ALVO' => [
            [
                'kind' => 'TABLE',
                'name' => 'RISCO_ALVO',
                'sql' => <<<'SQL'
CREATE TABLE "RISCO_ALVO" 
   (	"ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 68 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"RISCO_ID" NUMBER NOT NULL ENABLE, 
	"PROJETO_ID" NUMBER, 
	"SUBPROJETO_ID" NUMBER, 
	"TAREFA_ID" NUMBER, 
	"TIPO" VARCHAR2(20) DEFAULT 'MITIGACAO' NOT NULL ENABLE, 
	 CONSTRAINT "CHK_RISCO_ALVO_TIPO" CHECK (tipo IN ('MITIGACAO','CONTINGENCIA','MONITORAMENTO')) ENABLE, 
	 PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CHECK (
        projeto_id IS NOT NULL
        OR subprojeto_id IS NOT NULL
        OR tarefa_id IS NOT NULL
    ) ENABLE, 
	 FOREIGN KEY ("RISCO_ID")
	  REFERENCES "RISCO" ("ID") ON DELETE CASCADE ENABLE, 
	 FOREIGN KEY ("PROJETO_ID")
	  REFERENCES "PROJETO" ("ID") ENABLE, 
	 FOREIGN KEY ("SUBPROJETO_ID")
	  REFERENCES "SUBPROJETO" ("ID") ENABLE, 
	 FOREIGN KEY ("TAREFA_ID")
	  REFERENCES "TAREFA" ("ID") ENABLE
   )
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_RISCO_ALVO_PROJETO',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_RISCO_ALVO_PROJETO" ON "RISCO_ALVO" ("PROJETO_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_RISCO_ALVO_SUBPROJETO',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_RISCO_ALVO_SUBPROJETO" ON "RISCO_ALVO" ("SUBPROJETO_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_RISCO_ALVO_TAREFA',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_RISCO_ALVO_TAREFA" ON "RISCO_ALVO" ("TAREFA_ID")
SQL,
            ],
            [
                'kind' => 'INDEX',
                'name' => 'IDX_RISCO_ALVO_TIPO_TAREFA',
                'sql' => <<<'SQL'
CREATE INDEX "IDX_RISCO_ALVO_TIPO_TAREFA" ON "RISCO_ALVO" ("TIPO", "TAREFA_ID")
SQL,
            ],
            ],
        ];
    }

    /**
     * @return array<string, string>
     */
    private function views(): array
    {
        return [
            'VW_UNIDADE_TITULAR' => <<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE_TITULAR" ("MAT_SERVIDOR", "CD", "SIGLA_UNID_TSE", "DS_SITUACAO_SERV_UNIDADE", "TP_SITUACAO_SERV_UNIDADE", "TITULAR") AS 
  SELECT OC.MAT_SERVIDOR, 
        UT.cd, 
        REPLACE(SIGLA_UNID_TSE,'ª ZE', 'ZONA') AS SIGLA_UNID_TSE,
       'Titular' as ds_situacao_serv_unidade,
       'T' as tp_situacao_serv_unidade,
       S.NOM AS TITULAR
FROM SRH2.QFC_OCUP_COM OC,
     SRH2.QFC_VAGAS_COM VC,
     SRH2.UNIDADE_TSE UT,
     SRH2.SERVIDOR S
WHERE OC.DT_DISPENSA IS NULL
AND OC.TITULAR_COM = 1
AND OC.NOME_COM = VC.NOME_COM
AND OC.COD_COMISSIONADO = VC.COD_COMISSIONADO
AND OC.NUM_VAGA_COM = VC.NUM_VAGA_COM 
 AND VC.UNID_ATUAL_COM = UT.CD 
AND OC.MAT_SERVIDOR = S.MAT_SERVIDOR
SQL,
            'VW_UNIDADE' => <<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS 
  SELECT
    U.ID_UNIDADE,
    REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA, 'ª ZE', ''))
        WHEN SIGLA IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE =
            CASE
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'COCRE' THEN 'VICE-CRE'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'STI' THEN 'GSTI'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SAOF' THEN 'GASAOF'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SEJUD' THEN 'GAJUD'
                ELSE REPLACE(U.SIGLA, 'ª ZE', 'ZONA')
            END
    ) AS TITULAR,
    U.DESCRICAO,
    EU.EMAIL
FROM SIPTSE.UNIDADE U
INNER JOIN SEITSE.EMAIL_UNIDADE EU
    ON U.ID_UNIDADE = EU.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA) LIKE 'Z-ARQUIVO%'
  )
SQL,
            'VW_USUARIOS_SEI' => <<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_USUARIOS_SEI" ("UNIDADE", "USUARIO", "NOME", "SIN_ATIVO", "CPF", "EMAIL", "SIN_BLOQUEADO") AS 
  SELECT DISTINCT 

                UD.SIGLA UNIDADE,

                U.SIGLA AS USUARIO, 

                U.NOME, 

                U.SIN_ATIVO, 

                U.CPF,  

                U.EMAIL, 

                U.SIN_BLOQUEADO 

                FROM SIPTSE.USUARIO U

                INNER JOIN SIPTSE.PERMISSAO P ON (P.ID_USUARIO = U.ID_USUARIO)

                INNER JOIN SIPTSE.UNIDADE UD ON (P.ID_UNIDADE = UD.ID_UNIDADE)

                INNER JOIN SIPTSE.SISTEMA  S ON (P.ID_SISTEMA = S.ID_SISTEMA)

                WHERE U.SIN_ATIVO = 'S'
                
                AND UD.SIN_ATIVO = 'S'
               
                AND U.SIGLA NOT IN ('SIP')

                AND (P.DTA_FIM IS NULL or P.DTA_FIM > SYSDATE)

                AND S.SIGLA = 'SEI'

                ORDER BY UD.SIGLA
SQL,
            'VW_ELEITOR_SECAO_ZONA_LOCALIDADE' => <<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_ELEITOR_SECAO_ZONA_LOCALIDADE" ("NUM_INSCRICAO", "NOM_ELEITOR", "NUM_SECAO", "NUM_ZONA", "LOCALIDADE") AS 
  SELECT e.num_inscricao, e.nom_eleitor, s.num_secao, z.num_zona, m.localidade FROM planeleito.eleitor e JOIN planeleito.secoes s ON s.cod_objeto = e.cod_objeto_secao JOIN planeleito.zona z ON TO_CHAR(z.num_zona) = TRIM(s.cod_objeto_zona) JOIN planeleito.local_votacao_st lv ON lv.cod_objeto = s.cod_objeto_local JOIN planeleito.municipio m ON m.cod_objeto_localidade = lv.cod_objeto_localidade AND m.zonaid = z.id
SQL,
            'VW_SECOES_AGREGADAS' => <<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_SECOES_AGREGADAS" ("COD_OBJETO_ZONA", "COD_OBJETO", "COD_OBJETO_LOCAL", "NUM_SECAO", "SOMENTE_AGREGADAS", "SECOES_AGREGADAS") AS 
  SELECT
  b.cod_objeto_zona   AS cod_objeto_zona,
  b.cod_objeto        AS cod_objeto,
  NVL(SAP.COD_OBJETO_LOCAL_PROVISORIO,b.cod_objeto_local)  AS cod_objeto_local,
  b.num_secao         AS num_secao,
  b.somente_agregadas AS somente_agregadas,
  CASE
    WHEN b.somente_agregadas IS NOT NULL THEN b.num_secao || '(' || b.somente_agregadas || ')'
    ELSE b.num_secao
  END AS secoes_agregadas
FROM (
  SELECT DISTINCT
    s.cod_objeto_zona,
    s.cod_objeto,
    LPAD(s.num_secao, 3, '0') AS num_secao,
    s.cod_objeto_local,
    sa.cod_objeto_secao_agregadora,
    (
      SELECT LISTAGG(LPAD(se.num_secao, 3, '0'), ',') WITHIN GROUP (ORDER BY se.num_secao)
      FROM planeleito.secoes_agregadas sai
      JOIN planeleito.secoes se
        ON se.cod_objeto = sai.cod_objeto_secao
      WHERE sai.cod_objeto_secao_agregadora = sa.cod_objeto_secao_agregadora
    ) AS somente_agregadas
  FROM planeleito.secoes s
  LEFT JOIN planeleito.secoes_agregadas sa
    ON s.cod_objeto = sa.cod_objeto_secao_agregadora
  WHERE NOT EXISTS (
    SELECT
      1
    FROM planeleito.secoes_agregadas sa2
    WHERE sa2.cod_objeto_secao = s.cod_objeto
  )
) b
LEFT JOIN SECAO_ALOCACAO_PROVISORIA SAP ON (SAP.COD_OBJETO_SECAO = B.COD_OBJETO)
ORDER BY
  b.cod_objeto_zona
SQL,
            'VW_TAREFA_STATUS' => <<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_TAREFA_STATUS" ("ID", "PROJETO_NOME", "SUBPROJETO_ID", "SUBPROJETO_NOME", "UNIDADE_ID", "UNIDADE_SIGLA", "NOME", "DESCRICAO", "DATA_PREVISTA_INICIO", "DATA_PREVISTA_FIM", "DATA_REAL_INICIO", "DATA_REAL_FIM", "DT_CRIACAO", "STATUS") AS 
  SELECT
    T.ID,
    P.NOME AS PROJETO_NOME,
    T.SUBPROJETO_ID,
    SP.NOME AS SUBPROJETO_NOME,
    T.UNIDADE_ID,
    U.SIGLA AS UNIDADE_SIGLA,
    T.NOME,
    T.DESCRICAO,
    T.DATA_PREVISTA_INICIO,
    T.DATA_PREVISTA_FIM,
    T.DATA_REAL_INICIO,
    T.DATA_REAL_FIM,
    T.DT_CRIACAO,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM RISCO_ALVO RA
            WHERE RA.TAREFA_ID = T.ID
              AND UPPER(RA.TIPO) = 'CONTINGENCIA'
        ) THEN 'EM ESPERA (CONTINGÊNCIA)'
        WHEN T.DATA_REAL_FIM IS NOT NULL THEN 'CONCLUÍDA'
        WHEN T.DATA_REAL_INICIO IS NULL AND SYSDATE < T.DATA_PREVISTA_INICIO THEN 'A INICIAR'
        WHEN T.DATA_REAL_INICIO IS NULL AND SYSDATE >= T.DATA_PREVISTA_INICIO THEN 'ATRASADA'
        WHEN T.DATA_REAL_INICIO IS NOT NULL AND T.DATA_REAL_FIM IS NULL AND SYSDATE <= T.DATA_PREVISTA_FIM THEN 'EM ANDAMENTO (NO PRAZO)'
        WHEN T.DATA_REAL_INICIO IS NOT NULL AND T.DATA_REAL_FIM IS NULL AND SYSDATE > T.DATA_PREVISTA_FIM THEN 'EM ANDAMENTO (ATRASADA)'
        ELSE 'INDEFINIDO'
    END AS STATUS
FROM PLANELEITO.TAREFA T
    LEFT JOIN PLANELEITO.SUBPROJETO SP ON SP.ID = T.SUBPROJETO_ID
    LEFT JOIN PLANELEITO.VW_UNIDADE U ON U.ID_UNIDADE = T.UNIDADE_ID
    LEFT JOIN PLANELEITO.PROJETO P ON P.ID = SP.PROJETO_ID
SQL,
        ];
    }

    private function execute(string $sql): void
    {
        DB::statement(rtrim(trim($sql), ';'));
    }

    private function objectExists(string $name, string $type): bool
    {
        return DB::table('user_objects')
            ->where('object_name', strtoupper($name))
            ->where('object_type', strtoupper($type))
            ->exists();
    }

    private function indexExists(string $name): bool
    {
        return DB::table('user_indexes')
            ->where('index_name', strtoupper($name))
            ->exists();
    }

    private function dropViewIfExists(string $view): void
    {
        if (!$this->objectExists($view, 'VIEW')) {
            return;
        }

        DB::statement('DROP VIEW ' . $view);
    }

    private function dropTableIfExists(string $table): void
    {
        if (!$this->objectExists($table, 'TABLE')) {
            return;
        }

        DB::statement('DROP TABLE ' . $table . ' CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_02_01_000000_CREATE_RESTORE_LEGACY_BASELINE_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_02_08_120000_add_username_to_sessions_table.php`
## <DATABASE_MIGRATIONS_2026_02_08_120000_ADD_USERNAME_TO_SESSIONS_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_02_08_120000_add_username_to_sessions_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('sessions', function (Blueprint $table) {
            if (!Schema::hasColumn('sessions', 'username')) {
                $table->string('username', 255)->nullable()->index();
            }
        });
    }

    public function down(): void
    {
        Schema::table('sessions', function (Blueprint $table) {
            if (Schema::hasColumn('sessions', 'username')) {
                $table->dropIndex(['username']);
                $table->dropColumn('username');
            }
        });
    }
};
```
</DATABASE_MIGRATIONS_2026_02_08_120000_ADD_USERNAME_TO_SESSIONS_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_02_17_100000_create_auditoria_acao_table.php`
## <DATABASE_MIGRATIONS_2026_02_17_100000_CREATE_AUDITORIA_ACAO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_02_17_100000_create_auditoria_acao_table.php`
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
CREATE TABLE auditoria_acao (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    data_evento       DATE             DEFAULT SYSDATE NOT NULL,
    usuario           VARCHAR2(120),
    rota              VARCHAR2(255),
    ip                VARCHAR2(64),
    request_id        VARCHAR2(100),
    entidade          VARCHAR2(120)    NOT NULL,
    registro_id       VARCHAR2(120),
    acao              VARCHAR2(10)     NOT NULL,
    comando_sql       CLOB             NOT NULL,
    bindings_json     CLOB,
    dados_antes_json  CLOB,
    dados_depois_json CLOB,
    sucesso           CHAR(1)          DEFAULT 'S' NOT NULL,
    erro_msg          VARCHAR2(4000),
    CONSTRAINT chk_auditoria_acao_acao CHECK (acao IN ('INSERT', 'UPDATE', 'DELETE')),
    CONSTRAINT chk_auditoria_acao_sucesso CHECK (sucesso IN ('S', 'N'))
)
SQL
        );

        DB::statement('CREATE INDEX idx_auditoria_acao_data ON auditoria_acao (data_evento)');
        DB::statement('CREATE INDEX idx_auditoria_acao_entidade ON auditoria_acao (entidade, registro_id)');
        DB::statement('CREATE INDEX idx_auditoria_acao_usuario ON auditoria_acao (usuario)');
        DB::statement('CREATE INDEX idx_auditoria_acao_acao ON auditoria_acao (acao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE auditoria_acao');
    }
};
```
</DATABASE_MIGRATIONS_2026_02_17_100000_CREATE_AUDITORIA_ACAO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_190000_make_cad_unidade_zona_nullable.php`
## <DATABASE_MIGRATIONS_2026_04_02_190000_MAKE_CAD_UNIDADE_ZONA_NULLABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_190000_make_cad_unidade_zona_nullable.php`
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
        DB::statement("ALTER TABLE cad_unidade MODIFY (zona_eleitoral VARCHAR2(20 CHAR) NULL)");
    }

    public function down(): void
    {
        DB::statement("UPDATE cad_unidade SET zona_eleitoral = '-' WHERE zona_eleitoral IS NULL");
        DB::statement("ALTER TABLE cad_unidade MODIFY (zona_eleitoral VARCHAR2(20 CHAR) NOT NULL)");
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_190000_MAKE_CAD_UNIDADE_ZONA_NULLABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_220000_create_cad_funcionamento_unidade.php`
## <DATABASE_MIGRATIONS_2026_04_02_220000_CREATE_CAD_FUNCIONAMENTO_UNIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_220000_create_cad_funcionamento_unidade.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$unidades = DB::table('cad_unidade')
DB::table('cad_funcionamento_unidade')->insert([
DB::table('cad_funcionamento_unidade')->insert([
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
CREATE TABLE cad_funcionamento_unidade (
    id_funcionamento       NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade             NUMBER NOT NULL,
    dia_semana             NUMBER(1) NOT NULL,
    hora_inicio            VARCHAR2(5 CHAR) NOT NULL,
    hora_fim               VARCHAR2(5 CHAR) NOT NULL,
    ativo                  CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT fk_cfu_unid FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT uk_cfu_unid_dia_hora UNIQUE (id_unidade, dia_semana, hora_inicio, hora_fim),
    CONSTRAINT ck_cfu_dia CHECK (dia_semana BETWEEN 0 AND 6),
    CONSTRAINT ck_cfu_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_cfu_unid_dia ON cad_funcionamento_unidade (id_unidade, dia_semana, ativo)');

        $unidades = DB::table('cad_unidade')
            ->select('id_unidade', 'hora_abertura', 'hora_fechamento', 'intervalo_inicio', 'intervalo_fim')
            ->orderBy('id_unidade')
            ->get();

        foreach ($unidades as $unidade) {
            for ($dia = 1; $dia <= 5; $dia++) {
                DB::table('cad_funcionamento_unidade')->insert([
                    'id_unidade' => (int) $unidade->id_unidade,
                    'dia_semana' => $dia,
                    'hora_inicio' => $unidade->hora_abertura,
                    'hora_fim' => $unidade->intervalo_inicio ?: $unidade->hora_fechamento,
                    'ativo' => 'S',
                    'dt_criacao' => DB::raw('SYSDATE'),
                    'dt_atualizacao' => null,
                ]);

                if (!empty($unidade->intervalo_inicio) && !empty($unidade->intervalo_fim)) {
                    DB::table('cad_funcionamento_unidade')->insert([
                        'id_unidade' => (int) $unidade->id_unidade,
                        'dia_semana' => $dia,
                        'hora_inicio' => $unidade->intervalo_fim,
                        'hora_fim' => $unidade->hora_fechamento,
                        'ativo' => 'S',
                        'dt_criacao' => DB::raw('SYSDATE'),
                        'dt_atualizacao' => null,
                    ]);
                }
            }
        }
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_cfu_unid_dia');
        DB::statement('DROP TABLE cad_funcionamento_unidade');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_220000_CREATE_CAD_FUNCIONAMENTO_UNIDADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_230000_change_cad_funcionamento_unidade_to_date_based.php`
## <DATABASE_MIGRATIONS_2026_04_02_230000_CHANGE_CAD_FUNCIONAMENTO_UNIDADE_TO_DATE_BASED_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_230000_change_cad_funcionamento_unidade_to_date_based.php`
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
        DB::statement('ALTER TABLE cad_funcionamento_unidade DROP CONSTRAINT uk_cfu_unid_dia_hora');
        DB::statement('ALTER TABLE cad_funcionamento_unidade DROP CONSTRAINT ck_cfu_dia');
        DB::statement('DROP INDEX ix_cfu_unid_dia');
        DB::statement('ALTER TABLE cad_funcionamento_unidade ADD (data_funcionamento DATE)');
        DB::statement('DELETE FROM cad_funcionamento_unidade');
        DB::statement('ALTER TABLE cad_funcionamento_unidade DROP COLUMN dia_semana');
        DB::statement('ALTER TABLE cad_funcionamento_unidade MODIFY (data_funcionamento DATE NOT NULL)');
        DB::statement('ALTER TABLE cad_funcionamento_unidade ADD CONSTRAINT uk_cfu_unid_data_hora UNIQUE (id_unidade, data_funcionamento, hora_inicio, hora_fim)');
        DB::statement('CREATE INDEX ix_cfu_unid_data ON cad_funcionamento_unidade (id_unidade, data_funcionamento, ativo)');
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE cad_funcionamento_unidade DROP CONSTRAINT uk_cfu_unid_data_hora');
        DB::statement('DROP INDEX ix_cfu_unid_data');
        DB::statement('ALTER TABLE cad_funcionamento_unidade ADD (dia_semana NUMBER(1))');
        DB::statement('DELETE FROM cad_funcionamento_unidade');
        DB::statement('ALTER TABLE cad_funcionamento_unidade DROP COLUMN data_funcionamento');
        DB::statement('ALTER TABLE cad_funcionamento_unidade MODIFY (dia_semana NUMBER(1) NOT NULL)');
        DB::statement("ALTER TABLE cad_funcionamento_unidade ADD CONSTRAINT ck_cfu_dia CHECK (dia_semana BETWEEN 0 AND 6)");
        DB::statement('ALTER TABLE cad_funcionamento_unidade ADD CONSTRAINT uk_cfu_unid_dia_hora UNIQUE (id_unidade, dia_semana, hora_inicio, hora_fim)');
        DB::statement('CREATE INDEX ix_cfu_unid_dia ON cad_funcionamento_unidade (id_unidade, dia_semana, ativo)');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_230000_CHANGE_CAD_FUNCIONAMENTO_UNIDADE_TO_DATE_BASED_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_05_140000_add_campos_sincronizacao_to_secoes.php`
## <DATABASE_MIGRATIONS_2026_04_05_140000_ADD_CAMPOS_SINCRONIZACAO_TO_SECOES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_05_140000_add_campos_sincronizacao_to_secoes.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('user_tab_columns')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function columnExists(string $table, string $column): bool
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
        $columns = [
            'situacao' => 'NUMBER',
            'qtd_vagas_reservadas' => 'NUMBER',
            'qtd_suspensos' => 'NUMBER',
            'cod_objeto_uf' => 'VARCHAR2(18 CHAR)',
        ];

        foreach ($columns as $column => $definition) {
            if (!$this->columnExists('SECOES', $column)) {
                DB::statement("ALTER TABLE planeleito.secoes ADD {$column} {$definition}");
            }
        }

        DB::statement("COMMENT ON COLUMN planeleito.secoes.situacao IS 'Situação da seção no cadastro de origem'");
        DB::statement("COMMENT ON COLUMN planeleito.secoes.qtd_vagas_reservadas IS 'Quantidade de vagas reservadas da seção'");
        DB::statement("COMMENT ON COLUMN planeleito.secoes.qtd_suspensos IS 'Quantidade de eleitores suspensos da seção'");
        DB::statement("COMMENT ON COLUMN planeleito.secoes.cod_objeto_uf IS 'Código do objeto da UF da seção'");
    }

    public function down(): void
    {
        foreach (['cod_objeto_uf', 'qtd_suspensos', 'qtd_vagas_reservadas', 'situacao'] as $column) {
            if ($this->columnExists('SECOES', $column)) {
                DB::statement("ALTER TABLE planeleito.secoes DROP COLUMN {$column}");
            }
        }
    }

    private function columnExists(string $table, string $column): bool
    {
        return DB::table('user_tab_columns')
            ->where('table_name', strtoupper($table))
            ->where('column_name', strtoupper($column))
            ->exists();
    }
};
```
</DATABASE_MIGRATIONS_2026_04_05_140000_ADD_CAMPOS_SINCRONIZACAO_TO_SECOES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_12_225602_create_vw_convocados.php`
## <DATABASE_MIGRATIONS_2026_04_12_225602_CREATE_VW_CONVOCADOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_12_225602_create_vw_convocados.php`
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
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    nom_eleitor,
    dat_nasc,
    num_inscricao,
    num_cpf,
    num_zona,
    nom_localidade
FROM planeleito.eleitor
SQL
        );
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
DROP VIEW planeleito.vw_convocados
SQL
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_04_12_225602_CREATE_VW_CONVOCADOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_12_230000_create_cargos_equipe_table.php`
## <DATABASE_MIGRATIONS_2026_04_12_230000_CREATE_CARGOS_EQUIPE_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_12_230000_create_cargos_equipe_table.php`
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
CREATE TABLE cargos_equipe (
    id            NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome          VARCHAR2(120 CHAR)                       NOT NULL,
    descricao     VARCHAR2(1000 CHAR),
    ativo         CHAR(1 CHAR) DEFAULT 'S'                NOT NULL,
    dt_criacao    DATE DEFAULT SYSDATE                     NOT NULL,
    dt_atualizacao DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_cargos_equipe_01 ON cargos_equipe (nome)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE cargos_equipe');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_12_230000_CREATE_CARGOS_EQUIPE_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_12_230100_create_equipe_table.php`
## <DATABASE_MIGRATIONS_2026_04_12_230100_CREATE_EQUIPE_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_12_230100_create_equipe_table.php`
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
CREATE TABLE equipe (
    id            NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    rota_id       NUMBER                                   NOT NULL,
    cargo_id      NUMBER                                   NOT NULL,
    num_inscricao VARCHAR2(30 CHAR)                        NOT NULL,
    observacao    VARCHAR2(1000 CHAR),
    dt_criacao    DATE DEFAULT SYSDATE                     NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT fk_equipe_rota
        FOREIGN KEY (rota_id) REFERENCES rota(id) ON DELETE CASCADE,
    CONSTRAINT fk_equipe_cargo
        FOREIGN KEY (cargo_id) REFERENCES cargos_equipe(id)
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_equipe_01 ON equipe (rota_id, num_inscricao)');
        DB::statement('CREATE INDEX ix_equipe_01 ON equipe (rota_id)');
        DB::statement('CREATE INDEX ix_equipe_02 ON equipe (cargo_id)');
        DB::statement('CREATE INDEX ix_equipe_03 ON equipe (num_inscricao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE equipe');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_12_230100_CREATE_EQUIPE_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_13_030000_update_vw_convocados_with_zona_municipio_ids.php`
## <DATABASE_MIGRATIONS_2026_04_13_030000_UPDATE_VW_CONVOCADOS_WITH_ZONA_MUNICIPIO_IDS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_13_030000_update_vw_convocados_with_zona_municipio_ids.php`
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
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc                      AS dat_nasc,
    e.num_inscricao,
    v.num_cpf,
    v.telefone,
    e.num_zona,
    m.localidade                     AS nom_localidade,
    m.id                             AS municipio_id,
    z.id                             AS zona_id
FROM planeleito.eleitor e
JOIN planeleito.secoes s
    ON s.cod_objeto = e.cod_objeto_secao
JOIN local_votacao_st lv
    ON lv.cod_objeto = s.cod_objeto_local
JOIN planeleito.municipio m
    ON m.cod_objeto_localidade = lv.cod_objeto_localidade
JOIN planeleito.zona z
    ON z.id = m.zonaid
JOIN ac_pessoa.vw_voluntario_perfil v
    ON TRIM(v.num_inscricao) = TRIM(e.num_inscricao)
SQL
        );
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc                      AS dat_nasc,
    v.num_inscricao,
    v.num_cpf,
    v.telefone,
    v.num_zona,
    ev.localidade                    AS nom_localidade
FROM ac_pessoa.vw_voluntario_perfil v
LEFT JOIN planeleito.vw_eleitor_secao_zona_localidade ev
    ON TRIM(ev.num_inscricao) = TRIM(v.num_inscricao)
SQL
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_04_13_030000_UPDATE_VW_CONVOCADOS_WITH_ZONA_MUNICIPIO_IDS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_13_030100_fix_vw_convocados_zona_municipio_join.php`
## <DATABASE_MIGRATIONS_2026_04_13_030100_FIX_VW_CONVOCADOS_ZONA_MUNICIPIO_JOIN_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_13_030100_fix_vw_convocados_zona_municipio_join.php`
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
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc                      AS dat_nasc,
    e.num_inscricao,
    v.num_cpf,
    v.telefone,
    e.num_zona,
    m.localidade                     AS nom_localidade,
    m.id                             AS municipio_id,
    z.id                             AS zona_id
FROM planeleito.eleitor e
JOIN planeleito.secoes s
    ON s.cod_objeto = e.cod_objeto_secao
JOIN local_votacao_st lv
    ON lv.cod_objeto = s.cod_objeto_local
JOIN planeleito.municipio m
    ON m.cod_objeto_localidade = lv.cod_objeto_localidade
JOIN planeleito.zona z
    ON z.id = m.zonaid
    AND z.num_zona = TO_NUMBER(lv.cod_objeto_zona)
JOIN ac_pessoa.vw_voluntario_perfil v
    ON TRIM(v.num_inscricao) = TRIM(e.num_inscricao)
SQL
        );
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc                      AS dat_nasc,
    e.num_inscricao,
    v.num_cpf,
    v.telefone,
    e.num_zona,
    m.localidade                     AS nom_localidade,
    m.id                             AS municipio_id,
    z.id                             AS zona_id
FROM planeleito.eleitor e
JOIN planeleito.secoes s
    ON s.cod_objeto = e.cod_objeto_secao
JOIN local_votacao_st lv
    ON lv.cod_objeto = s.cod_objeto_local
JOIN planeleito.municipio m
    ON m.cod_objeto_localidade = lv.cod_objeto_localidade
JOIN planeleito.zona z
    ON z.id = m.zonaid
JOIN ac_pessoa.vw_voluntario_perfil v
    ON TRIM(v.num_inscricao) = TRIM(e.num_inscricao)
SQL
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_04_13_030100_FIX_VW_CONVOCADOS_ZONA_MUNICIPIO_JOIN_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_24_120000_create_cad_pesquisa_satisfacao_table.php`
## <DATABASE_MIGRATIONS_2026_04_24_120000_CREATE_CAD_PESQUISA_SATISFACAO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_24_120000_create_cad_pesquisa_satisfacao_table.php`
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
CREATE TABLE cad_pesquisa_satisfacao (
    id_pesquisa_satisfacao      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade                  NUMBER NOT NULL,
    avaliacao_tempo_espera      VARCHAR2(10 CHAR) NOT NULL,
    avaliacao_atendimento       VARCHAR2(10 CHAR) NOT NULL,
    avaliacao_local             VARCHAR2(10 CHAR) NOT NULL,
    ip_resposta                 VARCHAR2(45 CHAR),
    user_agent                  VARCHAR2(500 CHAR),
    dt_criacao                  DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_cps_unidade
        FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT ck_cps_tempo_espera
        CHECK (avaliacao_tempo_espera IN ('OTIMO','BOM','RUIM')),
    CONSTRAINT ck_cps_atendimento
        CHECK (avaliacao_atendimento IN ('OTIMO','BOM','RUIM')),
    CONSTRAINT ck_cps_local
        CHECK (avaliacao_local IN ('OTIMO','BOM','RUIM'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_cps_unidade_data ON cad_pesquisa_satisfacao (id_unidade, dt_criacao)');
        DB::statement('CREATE INDEX ix_cps_data ON cad_pesquisa_satisfacao (dt_criacao)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_cps_data');
        DB::statement('DROP INDEX ix_cps_unidade_data');
        DB::statement('DROP TABLE cad_pesquisa_satisfacao');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_24_120000_CREATE_CAD_PESQUISA_SATISFACAO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_26_120000_create_equipe_vinculo_table.php`
## <DATABASE_MIGRATIONS_2026_04_26_120000_CREATE_EQUIPE_VINCULO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_26_120000_create_equipe_vinculo_table.php`
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
CREATE TABLE equipe_vinculo (
    id             NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tipo_vinculo   VARCHAR2(40 CHAR)                       NOT NULL,
    vinculo_id     NUMBER                                  NOT NULL,
    dt_criacao     DATE DEFAULT SYSDATE                    NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT ck_equipe_vinculo_tipo
        CHECK (tipo_vinculo IN ('ROTA', 'LDA', 'LOCAL_TRANSMISSAO'))
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_equipe_vinculo_01 ON equipe_vinculo (tipo_vinculo, vinculo_id)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE equipe_vinculo');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_26_120000_CREATE_EQUIPE_VINCULO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_26_120100_generalize_equipe_table.php`
## <DATABASE_MIGRATIONS_2026_04_26_120100_GENERALIZE_EQUIPE_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_26_120100_generalize_equipe_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$rotas = DB::table('EQUIPE')
$jaExiste = DB::table('EQUIPE_VINCULO')
DB::table('EQUIPE_VINCULO')->insert([
return DB::table('USER_TAB_COLUMNS')
return DB::table('USER_INDEXES')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function columnExists(string $table, string $column): bool
private function indexExists(string $index): bool
private function constraintExists(string $constraint): bool
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
        DB::statement('ALTER TABLE equipe MODIFY (rota_id NUMBER)');

        if (!$this->columnExists('EQUIPE', 'EQUIPE_VINCULO_ID')) {
            DB::statement('ALTER TABLE equipe ADD (equipe_vinculo_id NUMBER)');
        }

        if (!$this->indexExists('IX_EQUIPE_04')) {
            DB::statement('CREATE INDEX ix_equipe_04 ON equipe (equipe_vinculo_id)');
        }

        $rotas = DB::table('EQUIPE')
            ->select('ROTA_ID')
            ->whereNotNull('ROTA_ID')
            ->distinct()
            ->orderBy('ROTA_ID')
            ->get();

        foreach ($rotas as $rota) {
            $rotaId = $rota->ROTA_ID ?? $rota->rota_id ?? null;
            if ($rotaId === null) {
                continue;
            }

            $jaExiste = DB::table('EQUIPE_VINCULO')
                ->where('TIPO_VINCULO', 'ROTA')
                ->where('VINCULO_ID', $rotaId)
                ->exists();

            if ($jaExiste) {
                continue;
            }

            DB::table('EQUIPE_VINCULO')->insert([
                'TIPO_VINCULO' => 'ROTA',
                'VINCULO_ID' => $rotaId,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);
        }

        DB::statement(<<<'SQL'
UPDATE equipe e
   SET e.equipe_vinculo_id = (
       SELECT ev.id
         FROM equipe_vinculo ev
        WHERE ev.tipo_vinculo = 'ROTA'
          AND ev.vinculo_id = e.rota_id
   )
 WHERE e.rota_id IS NOT NULL
   AND e.equipe_vinculo_id IS NULL
SQL
        );

        DB::statement('ALTER TABLE equipe MODIFY (equipe_vinculo_id NUMBER NOT NULL)');

        if (!$this->constraintExists('FK_EQUIPE_VINCULO')) {
            DB::statement('ALTER TABLE equipe ADD CONSTRAINT fk_equipe_vinculo FOREIGN KEY (equipe_vinculo_id) REFERENCES equipe_vinculo(id) ON DELETE CASCADE');
        }

        if (!$this->indexExists('UX_EQUIPE_02')) {
            DB::statement('CREATE UNIQUE INDEX ux_equipe_02 ON equipe (equipe_vinculo_id, num_inscricao)');
        }
    }

    public function down(): void
    {
        if ($this->indexExists('UX_EQUIPE_02')) {
            DB::statement('DROP INDEX ux_equipe_02');
        }
        if ($this->constraintExists('FK_EQUIPE_VINCULO')) {
            DB::statement('ALTER TABLE equipe DROP CONSTRAINT fk_equipe_vinculo');
        }
        if ($this->indexExists('IX_EQUIPE_04')) {
            DB::statement('DROP INDEX ix_equipe_04');
        }
        if ($this->columnExists('EQUIPE', 'EQUIPE_VINCULO_ID')) {
            DB::statement('ALTER TABLE equipe DROP COLUMN equipe_vinculo_id');
        }
        DB::statement('ALTER TABLE equipe MODIFY (rota_id NUMBER NOT NULL)');
        DB::statement("DELETE FROM equipe_vinculo WHERE tipo_vinculo = 'ROTA'");
    }

    private function columnExists(string $table, string $column): bool
    {
        return DB::table('USER_TAB_COLUMNS')
            ->where('TABLE_NAME', strtoupper($table))
            ->where('COLUMN_NAME', strtoupper($column))
            ->exists();
    }

    private function indexExists(string $index): bool
    {
        return DB::table('USER_INDEXES')
            ->where('INDEX_NAME', strtoupper($index))
            ->exists();
    }

    private function constraintExists(string $constraint): bool
    {
        return DB::table('USER_CONSTRAINTS')
            ->where('CONSTRAINT_NAME', strtoupper($constraint))
            ->exists();
    }
};
```
</DATABASE_MIGRATIONS_2026_04_26_120100_GENERALIZE_EQUIPE_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_02_120000_add_capacidade_flags_to_cad_unidade.php`
## <DATABASE_MIGRATIONS_2026_05_02_120000_ADD_CAPACIDADE_FLAGS_TO_CAD_UNIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_02_120000_add_capacidade_flags_to_cad_unidade.php`
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
ALTER TABLE cad_unidade
ADD (usa_filas CHAR(1 CHAR) DEFAULT 'S' NOT NULL)
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE cad_unidade
ADD (usa_pesquisa_satisfacao CHAR(1 CHAR) DEFAULT 'S' NOT NULL)
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE cad_unidade
ADD (usa_agendamentos CHAR(1 CHAR) DEFAULT 'S' NOT NULL)
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE cad_unidade
ADD CONSTRAINT ck_cu_usa_filas CHECK (usa_filas IN ('S', 'N'))
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE cad_unidade
ADD CONSTRAINT ck_cu_usa_pesq_sat CHECK (usa_pesquisa_satisfacao IN ('S', 'N'))
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE cad_unidade
ADD CONSTRAINT ck_cu_usa_agend CHECK (usa_agendamentos IN ('S', 'N'))
SQL);
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE cad_unidade DROP CONSTRAINT ck_cu_usa_agend');
        DB::statement('ALTER TABLE cad_unidade DROP CONSTRAINT ck_cu_usa_pesq_sat');
        DB::statement('ALTER TABLE cad_unidade DROP CONSTRAINT ck_cu_usa_filas');

        DB::statement('ALTER TABLE cad_unidade DROP COLUMN usa_agendamentos');
        DB::statement('ALTER TABLE cad_unidade DROP COLUMN usa_pesquisa_satisfacao');
        DB::statement('ALTER TABLE cad_unidade DROP COLUMN usa_filas');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_02_120000_ADD_CAPACIDADE_FLAGS_TO_CAD_UNIDADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_17_130000_create_nat_status_ocorrencia_table.php`
## <DATABASE_MIGRATIONS_2026_05_17_130000_CREATE_NAT_STATUS_OCORRENCIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_17_130000_create_nat_status_ocorrencia_table.php`
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
CREATE TABLE nat_status_ocorrencia (
    id_status                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo                   VARCHAR2(30 CHAR) NOT NULL,
    nome                     VARCHAR2(100 CHAR) NOT NULL,
    ordem                    NUMBER(4) NOT NULL,
    ativo                    CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao               DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao           DATE,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    CONSTRAINT uk_nso_codigo UNIQUE (codigo),
    CONSTRAINT ck_nso_ativo CHECK (ativo IN ('S','N')),
    CONSTRAINT ck_nso_ordem CHECK (ordem >= 0)
)
SQL);
    }

    public function down(): void
    {
        DB::statement('DROP TABLE nat_status_ocorrencia');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_17_130000_CREATE_NAT_STATUS_OCORRENCIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_17_130100_seed_nat_status_ocorrencia_table.php`
## <DATABASE_MIGRATIONS_2026_05_17_130100_SEED_NAT_STATUS_OCORRENCIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_17_130100_seed_nat_status_ocorrencia_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('nat_status_ocorrencia')->insert([
DB::table('nat_status_ocorrencia')
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
        DB::table('nat_status_ocorrencia')->insert([
            [
                'codigo' => 'ATRIBUIDA',
                'nome' => 'Atribuida',
                'ordem' => 1,
                'ativo' => 'S',
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            [
                'codigo' => 'EM_ANDAMENTO',
                'nome' => 'Em andamento',
                'ordem' => 2,
                'ativo' => 'S',
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            [
                'codigo' => 'FINALIZADA',
                'nome' => 'Finalizada',
                'ordem' => 3,
                'ativo' => 'S',
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
        ]);
    }

    public function down(): void
    {
        DB::table('nat_status_ocorrencia')
            ->whereIn('codigo', ['ATRIBUIDA', 'EM_ANDAMENTO', 'FINALIZADA'])
            ->delete();
    }
};
```
</DATABASE_MIGRATIONS_2026_05_17_130100_SEED_NAT_STATUS_OCORRENCIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_17_130200_create_nat_tipo_ocorrencia_table.php`
## <DATABASE_MIGRATIONS_2026_05_17_130200_CREATE_NAT_TIPO_OCORRENCIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_17_130200_create_nat_tipo_ocorrencia_table.php`
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
CREATE TABLE nat_tipo_ocorrencia (
    id_tipo_ocorrencia       NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome                     VARCHAR2(120 CHAR) NOT NULL,
    descricao                VARCHAR2(500 CHAR),
    ordem                    NUMBER(4) DEFAULT 0 NOT NULL,
    ativo                    CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao               DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao           DATE,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    CONSTRAINT uk_nto_nome UNIQUE (nome),
    CONSTRAINT ck_nto_ativo CHECK (ativo IN ('S','N')),
    CONSTRAINT ck_nto_ordem CHECK (ordem >= 0)
)
SQL);
    }

    public function down(): void
    {
        DB::statement('DROP TABLE nat_tipo_ocorrencia');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_17_130200_CREATE_NAT_TIPO_OCORRENCIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_17_130300_create_nat_ocorrencia_table.php`
## <DATABASE_MIGRATIONS_2026_05_17_130300_CREATE_NAT_OCORRENCIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_17_130300_create_nat_ocorrencia_table.php`
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
CREATE TABLE nat_ocorrencia (
    id_ocorrencia                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    rota_id                      NUMBER NOT NULL,
    id_tipo_ocorrencia           NUMBER NOT NULL,
    id_status                    NUMBER NOT NULL,
    cod_objeto_local_votacao     VARCHAR2(18 CHAR) NOT NULL,
    num_secao                    VARCHAR2(20 CHAR) NOT NULL,
    zona_id                      NUMBER NOT NULL,
    municipio_id                 NUMBER NOT NULL,
    descricao_problema           VARCHAR2(2000 CHAR) NOT NULL,
    descricao_resolucao          VARCHAR2(2000 CHAR),
    nome_solicitante             VARCHAR2(160 CHAR),
    telefone_solicitante         VARCHAR2(40 CHAR),
    dt_abertura                  DATE DEFAULT SYSDATE NOT NULL,
    dt_atribuicao                DATE DEFAULT SYSDATE NOT NULL,
    dt_inicio_atendimento        DATE,
    dt_finalizacao               DATE,
    usuario_criacao              VARCHAR2(120 CHAR),
    usuario_nome_criacao         VARCHAR2(160 CHAR),
    usuario_atualizacao          VARCHAR2(120 CHAR),
    usuario_nome_atualizacao     VARCHAR2(160 CHAR),
    dt_atualizacao               DATE,
    CONSTRAINT fk_no_rota FOREIGN KEY (rota_id) REFERENCES rota(id),
    CONSTRAINT fk_no_tipo FOREIGN KEY (id_tipo_ocorrencia) REFERENCES nat_tipo_ocorrencia(id_tipo_ocorrencia),
    CONSTRAINT fk_no_status FOREIGN KEY (id_status) REFERENCES nat_status_ocorrencia(id_status),
    CONSTRAINT fk_no_zona FOREIGN KEY (zona_id) REFERENCES zona(id),
    CONSTRAINT fk_no_municipio FOREIGN KEY (municipio_id) REFERENCES municipio(id),
    CONSTRAINT ck_no_data_inicio CHECK (
        dt_inicio_atendimento IS NULL OR dt_inicio_atendimento >= dt_atribuicao
    ),
    CONSTRAINT ck_no_data_final CHECK (
        dt_finalizacao IS NULL OR dt_finalizacao >= NVL(dt_inicio_atendimento, dt_atribuicao)
    )
)
SQL);

        DB::statement('CREATE INDEX ix_no_rota_status ON nat_ocorrencia (rota_id, id_status)');
        DB::statement('CREATE INDEX ix_no_zona_municipio ON nat_ocorrencia (zona_id, municipio_id)');
        DB::statement('CREATE INDEX ix_no_local_secao ON nat_ocorrencia (cod_objeto_local_votacao, num_secao)');
        DB::statement('CREATE INDEX ix_no_tipo_status ON nat_ocorrencia (id_tipo_ocorrencia, id_status)');
        DB::statement('CREATE INDEX ix_no_dt_abertura ON nat_ocorrencia (dt_abertura)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_no_dt_abertura');
        DB::statement('DROP INDEX ix_no_tipo_status');
        DB::statement('DROP INDEX ix_no_local_secao');
        DB::statement('DROP INDEX ix_no_zona_municipio');
        DB::statement('DROP INDEX ix_no_rota_status');
        DB::statement('DROP TABLE nat_ocorrencia');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_17_130300_CREATE_NAT_OCORRENCIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_17_130400_create_nat_ocorrencia_evento_table.php`
## <DATABASE_MIGRATIONS_2026_05_17_130400_CREATE_NAT_OCORRENCIA_EVENTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_17_130400_create_nat_ocorrencia_evento_table.php`
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
CREATE TABLE nat_ocorrencia_evento (
    id_ocorrencia_evento      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_ocorrencia             NUMBER NOT NULL,
    id_status_anterior        NUMBER,
    id_status_novo            NUMBER,
    tipo_evento               VARCHAR2(30 CHAR) NOT NULL,
    descricao                 VARCHAR2(1000 CHAR),
    payload_json              CLOB,
    dt_evento                 DATE DEFAULT SYSDATE NOT NULL,
    usuario_criacao           VARCHAR2(120 CHAR),
    usuario_nome_criacao      VARCHAR2(160 CHAR),
    CONSTRAINT fk_noe_ocorrencia FOREIGN KEY (id_ocorrencia) REFERENCES nat_ocorrencia(id_ocorrencia),
    CONSTRAINT fk_noe_status_ant FOREIGN KEY (id_status_anterior) REFERENCES nat_status_ocorrencia(id_status),
    CONSTRAINT fk_noe_status_novo FOREIGN KEY (id_status_novo) REFERENCES nat_status_ocorrencia(id_status),
    CONSTRAINT ck_noe_tipo CHECK (tipo_evento IN ('ABERTURA','ATRIBUICAO','INICIO_ATENDIMENTO','FINALIZACAO','ALTERACAO'))
)
SQL);

        DB::statement('CREATE INDEX ix_noe_ocorrencia_data ON nat_ocorrencia_evento (id_ocorrencia, dt_evento)');
        DB::statement('CREATE INDEX ix_noe_tipo_data ON nat_ocorrencia_evento (tipo_evento, dt_evento)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_noe_tipo_data');
        DB::statement('DROP INDEX ix_noe_ocorrencia_data');
        DB::statement('DROP TABLE nat_ocorrencia_evento');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_17_130400_CREATE_NAT_OCORRENCIA_EVENTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_31_120000_add_email_to_vw_convocados.php`
## <DATABASE_MIGRATIONS_2026_05_31_120000_ADD_EMAIL_TO_VW_CONVOCADOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_31_120000_add_email_to_vw_convocados.php`
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
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc                      AS dat_nasc,
    e.num_inscricao,
    v.num_cpf,
    v.email,
    v.telefone,
    e.num_zona,
    m.localidade                     AS nom_localidade,
    m.id                             AS municipio_id,
    z.id                             AS zona_id
FROM planeleito.eleitor e
JOIN planeleito.secoes s
    ON s.cod_objeto = e.cod_objeto_secao
JOIN local_votacao_st lv
    ON lv.cod_objeto = s.cod_objeto_local
JOIN planeleito.municipio m
    ON m.cod_objeto_localidade = lv.cod_objeto_localidade
JOIN planeleito.zona z
    ON z.id = m.zonaid
    AND z.num_zona = TO_NUMBER(lv.cod_objeto_zona)
JOIN ac_pessoa.vw_voluntario_perfil v
    ON TRIM(v.num_inscricao) = TRIM(e.num_inscricao)
SQL
        );
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc                      AS dat_nasc,
    e.num_inscricao,
    v.num_cpf,
    v.telefone,
    e.num_zona,
    m.localidade                     AS nom_localidade,
    m.id                             AS municipio_id,
    z.id                             AS zona_id
FROM planeleito.eleitor e
JOIN planeleito.secoes s
    ON s.cod_objeto = e.cod_objeto_secao
JOIN local_votacao_st lv
    ON lv.cod_objeto = s.cod_objeto_local
JOIN planeleito.municipio m
    ON m.cod_objeto_localidade = lv.cod_objeto_localidade
JOIN planeleito.zona z
    ON z.id = m.zonaid
    AND z.num_zona = TO_NUMBER(lv.cod_objeto_zona)
JOIN ac_pessoa.vw_voluntario_perfil v
    ON TRIM(v.num_inscricao) = TRIM(e.num_inscricao)
SQL
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_05_31_120000_ADD_EMAIL_TO_VW_CONVOCADOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_31_150000_create_nat_externo_evento_table.php`
## <DATABASE_MIGRATIONS_2026_05_31_150000_CREATE_NAT_EXTERNO_EVENTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_31_150000_create_nat_externo_evento_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE nat_externo_evento (
    id                    NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    macroprojeto_id       NUMBER,
    tipo_evento           VARCHAR2(80 CHAR) NOT NULL,
    email                 VARCHAR2(255 CHAR),
    integrante_referencia VARCHAR2(30 CHAR),
    rotas_json            CLOB,
    payload_json          CLOB,
    ip_origem             VARCHAR2(64 CHAR),
    user_agent            VARCHAR2(500 CHAR),
    dt_evento             DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_nat_ext_evento_macro
        FOREIGN KEY (macroprojeto_id) REFERENCES macroprojeto(id)
)
SQL
        );

        DB::statement('CREATE INDEX ix_nat_ext_evento_01 ON nat_externo_evento (tipo_evento)');
        DB::statement('CREATE INDEX ix_nat_ext_evento_02 ON nat_externo_evento (email)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE nat_externo_evento');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_31_150000_CREATE_NAT_EXTERNO_EVENTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_18_130000_add_sessions_username_index.php`
## <DATABASE_MIGRATIONS_2026_06_18_130000_ADD_SESSIONS_USERNAME_INDEX_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_18_130000_add_sessions_username_index.php`
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
private function hasIndexOnUsername(): bool
private function hasIndex(string $indexName): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    private const TABLE_NAME = 'SESSIONS';
    private const COLUMN_NAME = 'USERNAME';
    private const INDEX_NAME = 'IX_SESSIONS_USERNAME';

    public function up(): void
    {
        if (!Schema::hasTable('sessions') || !Schema::hasColumn('sessions', 'username')) {
            return;
        }

        if ($this->hasIndexOnUsername()) {
            return;
        }

        DB::statement('CREATE INDEX ' . self::INDEX_NAME . ' ON sessions (username)');
    }

    public function down(): void
    {
        if (!$this->hasIndex(self::INDEX_NAME)) {
            return;
        }

        DB::statement('DROP INDEX ' . self::INDEX_NAME);
    }

    private function hasIndexOnUsername(): bool
    {
        $row = DB::selectOne(
            "SELECT COUNT(*) AS total
             FROM user_ind_columns
             WHERE table_name = :table_name
               AND column_name = :column_name",
            [
                'table_name' => self::TABLE_NAME,
                'column_name' => self::COLUMN_NAME,
            ]
        );

        return (int) ($row->total ?? $row->TOTAL ?? 0) > 0;
    }

    private function hasIndex(string $indexName): bool
    {
        $row = DB::selectOne(
            "SELECT COUNT(*) AS total
             FROM user_indexes
             WHERE index_name = :index_name",
            ['index_name' => mb_strtoupper($indexName)]
        );

        return (int) ($row->total ?? $row->TOTAL ?? 0) > 0;
    }
};
```
</DATABASE_MIGRATIONS_2026_06_18_130000_ADD_SESSIONS_USERNAME_INDEX_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_19_140000_create_trigger_bloqueio_escrita_conversa_arquivada.php`
## <DATABASE_MIGRATIONS_2026_06_19_140000_CREATE_TRIGGER_BLOQUEIO_ESCRITA_CONVERSA_ARQUIVADA_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_19_140000_create_trigger_bloqueio_escrita_conversa_arquivada.php`
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

/**
 * Ultima linha de defesa do ciclo de escrita: rejeita inserir mensagem cuja conversa esteja
 * arquivada. Contrato: docs/contratos/mesario-publico-situacao.md (Ciclo de escrita).
 */
return new class extends Migration {
    public function up(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE TRIGGER trg_nat_msg_block_arquivada
BEFORE INSERT ON nat_rota_mensagem
FOR EACH ROW
DECLARE
    v_arquivada DATE;
BEGIN
    SELECT arquivada_em INTO v_arquivada
      FROM nat_rota_conversa
     WHERE id = :NEW.conversa_id;

    IF v_arquivada IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20021, 'Conversa arquivada: envio de mensagem bloqueado (somente leitura).');
    END IF;
END;
SQL);
    }

    public function down(): void
    {
        DB::unprepared('DROP TRIGGER trg_nat_msg_block_arquivada');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_19_140000_CREATE_TRIGGER_BLOQUEIO_ESCRITA_CONVERSA_ARQUIVADA_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_110000_create_opcao_binaria_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_110000_CREATE_OPCAO_BINARIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_110000_create_opcao_binaria_table.php`
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
CREATE TABLE opcao_binaria (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER DEFAULT 0 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_ob_descricao ON opcao_binaria (UPPER(descricao))');
        DB::statement('CREATE INDEX ix_ob_ordem ON opcao_binaria (ordem)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE opcao_binaria');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_110000_CREATE_OPCAO_BINARIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_120000_add_codigo_to_opcao_binaria_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_120000_ADD_CODIGO_TO_OPCAO_BINARIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_120000_add_codigo_to_opcao_binaria_table.php`
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
        DB::statement('ALTER TABLE opcao_binaria ADD (codigo VARCHAR2(20 CHAR))');

        // Popula o codigo estavel a partir dos registros existentes do dominio binario.
        DB::statement(<<<'SQL'
UPDATE opcao_binaria
   SET codigo = CASE
       WHEN UPPER(descricao) IN ('SIM', 'S') THEN 'SIM'
       WHEN UPPER(descricao) IN ('NÃO', 'NAO', 'N') THEN 'NAO'
       ELSE UPPER(REGEXP_REPLACE(descricao, '[^A-Za-z0-9]+', '_'))
   END
 WHERE codigo IS NULL
SQL
        );

        DB::statement('ALTER TABLE opcao_binaria MODIFY (codigo VARCHAR2(20 CHAR) NOT NULL)');
        DB::statement('CREATE UNIQUE INDEX ux_ob_codigo ON opcao_binaria (UPPER(codigo))');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ux_ob_codigo');
        DB::statement('ALTER TABLE opcao_binaria DROP COLUMN codigo');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_120000_ADD_CODIGO_TO_OPCAO_BINARIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_140000_create_qualidade_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_140000_CREATE_QUALIDADE_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_140000_create_qualidade_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('qualidade')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
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
CREATE TABLE qualidade (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(20 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER DEFAULT 0 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_qualidade_codigo ON qualidade (UPPER(codigo))');
        DB::statement('CREATE INDEX ix_qualidade_ordem ON qualidade (ordem)');

        $semente = [
            ['codigo' => 'OTIMA', 'descricao' => 'Ótima', 'ordem' => 1],
            ['codigo' => 'BOA', 'descricao' => 'Boa', 'ordem' => 2],
            ['codigo' => 'REGULAR', 'descricao' => 'Regular', 'ordem' => 3],
            ['codigo' => 'RUIM', 'descricao' => 'Ruim', 'ordem' => 4],
            ['codigo' => 'INEXISTENTE', 'descricao' => 'Inexistente', 'ordem' => 5],
        ];

        foreach ($semente as $registro) {
            DB::table('qualidade')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }

    public function down(): void
    {
        DB::statement('DROP TABLE qualidade');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_140000_CREATE_QUALIDADE_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_150000_create_operadora_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_150000_CREATE_OPERADORA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_150000_create_operadora_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('operadora')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
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
CREATE TABLE operadora (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(20 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER DEFAULT 0 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_operadora_codigo ON operadora (UPPER(codigo))');
        DB::statement('CREATE INDEX ix_operadora_ordem ON operadora (ordem)');

        $semente = [
            ['codigo' => 'VIVO', 'descricao' => 'Vivo', 'ordem' => 1],
            ['codigo' => 'CLARO', 'descricao' => 'Claro', 'ordem' => 2],
            ['codigo' => 'TIM', 'descricao' => 'Tim', 'ordem' => 3],
        ];

        foreach ($semente as $registro) {
            DB::table('operadora')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }

    public function down(): void
    {
        DB::statement('DROP TABLE operadora');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_150000_CREATE_OPERADORA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_160000_create_tipo_sinal_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_160000_CREATE_TIPO_SINAL_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_160000_create_tipo_sinal_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('tipo_sinal')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
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
CREATE TABLE tipo_sinal (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(20 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER DEFAULT 0 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_tipo_sinal_codigo ON tipo_sinal (UPPER(codigo))');
        DB::statement('CREATE INDEX ix_tipo_sinal_ordem ON tipo_sinal (ordem)');

        $semente = [
            ['codigo' => '3G', 'descricao' => '3G', 'ordem' => 1],
            ['codigo' => '4G', 'descricao' => '4G', 'ordem' => 2],
            ['codigo' => '5G', 'descricao' => '5G', 'ordem' => 3],
        ];

        foreach ($semente as $registro) {
            DB::table('tipo_sinal')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tipo_sinal');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_160000_CREATE_TIPO_SINAL_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_180000_create_esfera_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_180000_CREATE_ESFERA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_180000_create_esfera_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('esfera')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
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
CREATE TABLE esfera (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(20 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER DEFAULT 0 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_esfera_codigo ON esfera (UPPER(codigo))');
        DB::statement('CREATE INDEX ix_esfera_ordem ON esfera (ordem)');

        $semente = [
            ['codigo' => 'FEDERAL', 'descricao' => 'Federal', 'ordem' => 1],
            ['codigo' => 'ESTADUAL', 'descricao' => 'Estadual', 'ordem' => 2],
            ['codigo' => 'MUNICIPAL', 'descricao' => 'Municipal', 'ordem' => 3],
            ['codigo' => 'PARTICULAR', 'descricao' => 'Particular', 'ordem' => 4],
        ];

        foreach ($semente as $registro) {
            DB::table('esfera')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }

    public function down(): void
    {
        DB::statement('DROP TABLE esfera');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_180000_CREATE_ESFERA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_190000_remove_chk_lvt_tipo_internet.php`
## <DATABASE_MIGRATIONS_2026_06_20_190000_REMOVE_CHK_LVT_TIPO_INTERNET_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_190000_remove_chk_lvt_tipo_internet.php`
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
        DB::statement('ALTER TABLE lda_vistoria_transmissao DROP CONSTRAINT chk_lvt_tipo_internet');
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE lda_vistoria_transmissao ADD CONSTRAINT chk_lvt_tipo_internet CHECK (tipo_internet IS NULL OR tipo_internet IN ('FIBRA', 'RADIO', 'ADSL', '4G', '5G', 'STARLINK', 'CORPORATIVA', 'OUTRO'))");
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_190000_REMOVE_CHK_LVT_TIPO_INTERNET_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_20_200000_create_tipo_tomada_table.php`
## <DATABASE_MIGRATIONS_2026_06_20_200000_CREATE_TIPO_TOMADA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_20_200000_create_tipo_tomada_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('tipo_tomada')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
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
CREATE TABLE tipo_tomada (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(20 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER DEFAULT 0 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_tipo_tomada_codigo ON tipo_tomada (UPPER(codigo))');
        DB::statement('CREATE INDEX ix_tipo_tomada_ordem ON tipo_tomada (ordem)');

        $semente = [
            ['codigo' => '3PINOS_CHATOS', 'descricao' => '3 pinos chatos (padrão antigo)', 'ordem' => 1],
            ['codigo' => '3PINOS_NBR', 'descricao' => '3 pinos (NBR)', 'ordem' => 2],
            ['codigo' => '2PINOS_CHATOS', 'descricao' => '2 pinos chatos', 'ordem' => 3],
            ['codigo' => '2PINOS_REDONDOS', 'descricao' => '2 pinos redondos', 'ordem' => 4],
        ];

        foreach ($semente as $registro) {
            DB::table('tipo_tomada')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tipo_tomada');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_20_200000_CREATE_TIPO_TOMADA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_26_132100_remove_legacy_veiculo_proprio_modal.php`
## <DATABASE_MIGRATIONS_2026_06_26_132100_REMOVE_LEGACY_VEICULO_PROPRIO_MODAL_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_26_132100_remove_legacy_veiculo_proprio_modal.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('diarias_modal_transporte')
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

return new class extends Migration
{
    public function up(): void
    {
        DB::table('diarias_modal_transporte')
            ->where('codigo', 'VEICULO_PROPRIO')
            ->delete();
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
MERGE INTO diarias_modal_transporte d
USING (
    SELECT 'VEICULO_PROPRIO' codigo,
           'Veículo próprio' label,
           0 exige_reserva,
           0 exige_veiculo_motorista,
           0 exige_motorista,
           1 exige_distancia,
           1 gera_combustivel,
           0 is_aereo,
           0 ativo,
           3 ordem
      FROM dual
) s
ON (d.codigo = s.codigo)
WHEN MATCHED THEN UPDATE SET
    d.label = s.label,
    d.exige_reserva = s.exige_reserva,
    d.exige_veiculo_motorista = s.exige_veiculo_motorista,
    d.exige_motorista = s.exige_motorista,
    d.exige_distancia = s.exige_distancia,
    d.gera_combustivel = s.gera_combustivel,
    d.is_aereo = s.is_aereo,
    d.ativo = s.ativo,
    d.ordem = s.ordem,
    d.dt_atualizacao = SYSDATE
WHEN NOT MATCHED THEN INSERT
    (codigo, label, exige_reserva, exige_veiculo_motorista, exige_motorista, exige_distancia, gera_combustivel, is_aereo, ativo, ordem, dt_criacao)
VALUES
    (s.codigo, s.label, s.exige_reserva, s.exige_veiculo_motorista, s.exige_motorista, s.exige_distancia, s.gera_combustivel, s.is_aereo, s.ativo, s.ordem, SYSDATE)
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_06_26_132100_REMOVE_LEGACY_VEICULO_PROPRIO_MODAL_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_19_120000_add_cod_objeto_local_responsavel_to_equipe.php`
## <DATABASE_MIGRATIONS_2026_07_19_120000_ADD_COD_OBJETO_LOCAL_RESPONSAVEL_TO_EQUIPE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_19_120000_add_cod_objeto_local_responsavel_to_equipe.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('USER_TAB_COLUMNS')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function columnExists(): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        if (! $this->columnExists()) {
            DB::statement('ALTER TABLE EQUIPE ADD (COD_OBJETO_LOCAL_RESPONSAVEL VARCHAR2(18 CHAR))');
        }
    }

    public function down(): void
    {
        if ($this->columnExists()) {
            DB::statement('ALTER TABLE EQUIPE DROP COLUMN COD_OBJETO_LOCAL_RESPONSAVEL');
        }
    }

    private function columnExists(): bool
    {
        return DB::table('USER_TAB_COLUMNS')
            ->where('TABLE_NAME', 'EQUIPE')
            ->where('COLUMN_NAME', 'COD_OBJETO_LOCAL_RESPONSAVEL')
            ->exists();
    }
};
```
</DATABASE_MIGRATIONS_2026_07_19_120000_ADD_COD_OBJETO_LOCAL_RESPONSAVEL_TO_EQUIPE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_29_101000_create_ce_wa_domain_tables.php`
## <DATABASE_MIGRATIONS_2026_07_29_101000_CREATE_CE_WA_DOMAIN_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_29_101000_create_ce_wa_domain_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table($tabela)->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function inserirDominio(string $tabela, array $itens): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_campo_variavel (
    codigo          VARCHAR2(40 CHAR) PRIMARY KEY,
    descricao       VARCHAR2(160 CHAR) NOT NULL,
    ordem           NUMBER(4) NOT NULL,
    ativo           NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao  DATE,
    CONSTRAINT ck_ce_wa_campo_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_modelo_situacao (
    codigo          VARCHAR2(30 CHAR) PRIMARY KEY,
    descricao       VARCHAR2(160 CHAR) NOT NULL,
    ordem           NUMBER(4) NOT NULL,
    ativo           NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao  DATE,
    CONSTRAINT ck_ce_wa_mod_sit_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_envio_status (
    codigo          VARCHAR2(30 CHAR) PRIMARY KEY,
    descricao       VARCHAR2(160 CHAR) NOT NULL,
    ordem           NUMBER(4) NOT NULL,
    ativo           NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao  DATE,
    CONSTRAINT ck_ce_wa_env_st_ativo CHECK (ativo IN (0, 1))
)
SQL);

        $this->inserirDominio('ce_wa_campo_variavel', [
            ['NOME', 'Nome', 10],
            ['ZONA', 'Zona', 20],
            ['MUNICIPIO', 'Município', 30],
            ['NUMERO_LOCAL', 'Número do local', 40],
            ['LOCAL_VOTACAO', 'Local de votação', 50],
            ['SECOES', 'Seções', 60],
            ['FUNCOES', 'Funções', 70],
            ['DATA_ELEICAO', 'Data da eleição', 80],
            ['TURNO', 'Turno', 90],
            ['RESUMO_CONVOCACOES', 'Resumo das convocações', 100],
        ]);

        $this->inserirDominio('ce_wa_modelo_situacao', [
            ['ATIVO', 'Ativo', 10],
            ['INATIVO', 'Inativo', 20],
            ['REQUER_REVALIDACAO', 'Requer revalidação', 30],
            ['INDISPONIVEL_META', 'Indisponível na Meta', 40],
        ]);

        $this->inserirDominio('ce_wa_envio_status', [
            ['PENDENTE', 'Pendente', 10],
            ['PROCESSANDO', 'Processando', 20],
            ['CANCELADO_ANTES_ENVIO', 'Cancelado antes do envio', 30],
            ['REJEITADO', 'Rejeitado', 40],
            ['INDETERMINADO', 'Indeterminado', 50],
            ['ACEITO', 'Aceito pela Meta', 60],
            ['ENVIADO', 'Enviado', 70],
            ['ENTREGUE', 'Entregue', 80],
            ['LIDO', 'Lido', 90],
            ['FALHA_APOS_ACEITE', 'Falha após aceite', 100],
        ]);
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ce_wa_envio_status');
        DB::statement('DROP TABLE ce_wa_modelo_situacao');
        DB::statement('DROP TABLE ce_wa_campo_variavel');
    }

    /** @param array<int, array{0:string,1:string,2:int}> $itens */
    private function inserirDominio(string $tabela, array $itens): void
    {
        foreach ($itens as [$codigo, $descricao, $ordem]) {
            DB::table($tabela)->insert([
                'codigo' => $codigo,
                'descricao' => $descricao,
                'ordem' => $ordem,
                'ativo' => 1,
                'dt_criacao' => DB::raw('SYSDATE'),
            ]);
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_07_29_101000_CREATE_CE_WA_DOMAIN_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_29_102000_create_ce_wa_model_tables.php`
## <DATABASE_MIGRATIONS_2026_07_29_102000_CREATE_CE_WA_MODEL_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_29_102000_create_ce_wa_model_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_modelo_meta (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    meta_template_id    VARCHAR2(100 CHAR) NOT NULL,
    nome                VARCHAR2(512 CHAR) NOT NULL,
    idioma              VARCHAR2(20 CHAR) NOT NULL,
    categoria           VARCHAR2(40 CHAR) NOT NULL,
    status_meta         VARCHAR2(40 CHAR) NOT NULL,
    componentes_json    CLOB NOT NULL,
    componentes_hash    VARCHAR2(64 CHAR) NOT NULL,
    dt_sincronizacao    DATE DEFAULT SYSDATE NOT NULL,
    dt_criacao          DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao      DATE
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_mod_meta_01 ON ce_wa_modelo_meta (meta_template_id)');
        DB::statement('CREATE INDEX ix_ce_wa_mod_meta_01 ON ce_wa_modelo_meta (status_meta, categoria, idioma)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_modelo (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    modelo_meta_id          NUMBER NOT NULL,
    macroprojeto_turno_id   NUMBER NOT NULL,
    num_zona                VARCHAR2(10 CHAR) NOT NULL,
    nome_exibicao           VARCHAR2(160 CHAR) NOT NULL,
    situacao_codigo         VARCHAR2(30 CHAR) NOT NULL,
    usuario_criacao         VARCHAR2(120 CHAR),
    usuario_atualizacao     VARCHAR2(120 CHAR),
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao          DATE,
    CONSTRAINT fk_ce_wa_mod_meta FOREIGN KEY (modelo_meta_id) REFERENCES ce_wa_modelo_meta (id),
    CONSTRAINT fk_ce_wa_mod_turno FOREIGN KEY (macroprojeto_turno_id) REFERENCES macroprojeto_turno (id),
    CONSTRAINT fk_ce_wa_mod_sit FOREIGN KEY (situacao_codigo) REFERENCES ce_wa_modelo_situacao (codigo)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_modelo_01 ON ce_wa_modelo (modelo_meta_id, macroprojeto_turno_id, num_zona)');
        DB::statement('CREATE INDEX ix_ce_wa_modelo_01 ON ce_wa_modelo (macroprojeto_turno_id, num_zona, situacao_codigo)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_modelo_parametro (
    id              NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    modelo_id       NUMBER NOT NULL,
    componente      VARCHAR2(10 CHAR) NOT NULL,
    posicao         NUMBER(4) NOT NULL,
    campo_codigo    VARCHAR2(40 CHAR) NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_wa_mod_par_mod FOREIGN KEY (modelo_id) REFERENCES ce_wa_modelo (id),
    CONSTRAINT fk_ce_wa_mod_par_cpo FOREIGN KEY (campo_codigo) REFERENCES ce_wa_campo_variavel (codigo),
    CONSTRAINT ck_ce_wa_mod_par_cmp CHECK (componente IN ('HEADER', 'BODY')),
    CONSTRAINT ck_ce_wa_mod_par_pos CHECK (posicao > 0)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_mod_par_01 ON ce_wa_modelo_parametro (modelo_id, componente, posicao)');
        DB::statement('CREATE INDEX ix_ce_wa_mod_par_01 ON ce_wa_modelo_parametro (campo_codigo)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ce_wa_modelo_parametro');
        DB::statement('DROP TABLE ce_wa_modelo');
        DB::statement('DROP TABLE ce_wa_modelo_meta');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_29_102000_CREATE_CE_WA_MODEL_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_29_103000_create_ce_wa_delivery_tables.php`
## <DATABASE_MIGRATIONS_2026_07_29_103000_CREATE_CE_WA_DELIVERY_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_29_103000_create_ce_wa_delivery_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_lote (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    request_uuid            VARCHAR2(36 CHAR) NOT NULL,
    macroprojeto_turno_id   NUMBER NOT NULL,
    modelo_id               NUMBER NOT NULL,
    num_zona                VARCHAR2(10 CHAR) NOT NULL,
    usuario_login           VARCHAR2(120 CHAR) NOT NULL,
    usuario_nome            VARCHAR2(200 CHAR) NOT NULL,
    total_selecionados      NUMBER DEFAULT 0 NOT NULL,
    total_enfileirados      NUMBER DEFAULT 0 NOT NULL,
    total_ignorados         NUMBER DEFAULT 0 NOT NULL,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_wa_lote_turno FOREIGN KEY (macroprojeto_turno_id) REFERENCES macroprojeto_turno (id),
    CONSTRAINT fk_ce_wa_lote_modelo FOREIGN KEY (modelo_id) REFERENCES ce_wa_modelo (id)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_lote_uuid ON ce_wa_lote (request_uuid)');
        DB::statement('CREATE INDEX ix_ce_wa_lote_01 ON ce_wa_lote (macroprojeto_turno_id, num_zona, dt_criacao)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_envio (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lote_id                 NUMBER NOT NULL,
    modelo_id               NUMBER NOT NULL,
    macroprojeto_turno_id   NUMBER NOT NULL,
    num_inscricao           VARCHAR2(20 CHAR) NOT NULL,
    cod_pleito              VARCHAR2(30 CHAR) NOT NULL,
    dt_eleicao              DATE NOT NULL,
    num_zona                VARCHAR2(10 CHAR) NOT NULL,
    municipio               VARCHAR2(160 CHAR) NOT NULL,
    nome                    VARCHAR2(300 CHAR) NOT NULL,
    telefone_e164           VARCHAR2(20 CHAR) NOT NULL,
    telefone_fonte          VARCHAR2(40 CHAR) NOT NULL,
    atribuicoes_json        CLOB NOT NULL,
    parametros_json         CLOB NOT NULL,
    payload_hash            VARCHAR2(64 CHAR) NOT NULL,
    status_codigo           VARCHAR2(30 CHAR) NOT NULL,
    wamid                   VARCHAR2(255 CHAR),
    tentativas              NUMBER DEFAULT 0 NOT NULL,
    erro_codigo             VARCHAR2(80 CHAR),
    erro_detalhe            VARCHAR2(1000 CHAR),
    dt_processamento        DATE,
    dt_aceite               DATE,
    dt_ultimo_evento        DATE,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao          DATE,
    CONSTRAINT fk_ce_wa_env_lote FOREIGN KEY (lote_id) REFERENCES ce_wa_lote (id),
    CONSTRAINT fk_ce_wa_env_modelo FOREIGN KEY (modelo_id) REFERENCES ce_wa_modelo (id),
    CONSTRAINT fk_ce_wa_env_turno FOREIGN KEY (macroprojeto_turno_id) REFERENCES macroprojeto_turno (id),
    CONSTRAINT fk_ce_wa_env_status FOREIGN KEY (status_codigo) REFERENCES ce_wa_envio_status (codigo)
)
SQL);
        DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_wa_envio_ativo ON ce_wa_envio (
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN num_inscricao END
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_envio_wamid ON ce_wa_envio (wamid)');
        DB::statement('CREATE INDEX ix_ce_wa_envio_01 ON ce_wa_envio (macroprojeto_turno_id, num_zona, status_codigo)');
        DB::statement('CREATE INDEX ix_ce_wa_envio_02 ON ce_wa_envio (lote_id)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_lote_item (
    id              NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lote_id         NUMBER NOT NULL,
    envio_id        NUMBER,
    num_inscricao   VARCHAR2(20 CHAR) NOT NULL,
    enfileirado     NUMBER(1) DEFAULT 0 NOT NULL,
    motivo_codigo   VARCHAR2(80 CHAR),
    motivo_detalhe  VARCHAR2(500 CHAR),
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_wa_lot_item_lot FOREIGN KEY (lote_id) REFERENCES ce_wa_lote (id),
    CONSTRAINT fk_ce_wa_lot_item_env FOREIGN KEY (envio_id) REFERENCES ce_wa_envio (id),
    CONSTRAINT ck_ce_wa_lot_item_enq CHECK (enfileirado IN (0, 1))
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_lote_item_01 ON ce_wa_lote_item (lote_id, num_inscricao)');
        DB::statement('CREATE INDEX ix_ce_wa_lote_item_01 ON ce_wa_lote_item (envio_id)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_wa_envio_evento (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    envio_id                NUMBER NOT NULL,
    provider_event_hash     VARCHAR2(64 CHAR) NOT NULL,
    status_anterior         VARCHAR2(30 CHAR),
    status_novo             VARCHAR2(30 CHAR) NOT NULL,
    status_meta             VARCHAR2(40 CHAR),
    erro_codigo             VARCHAR2(80 CHAR),
    erro_detalhe            VARCHAR2(1000 CHAR),
    dt_evento_provedor      DATE,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_wa_evt_env FOREIGN KEY (envio_id) REFERENCES ce_wa_envio (id),
    CONSTRAINT fk_ce_wa_evt_st_ant FOREIGN KEY (status_anterior) REFERENCES ce_wa_envio_status (codigo),
    CONSTRAINT fk_ce_wa_evt_st_nov FOREIGN KEY (status_novo) REFERENCES ce_wa_envio_status (codigo)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_evento_hash ON ce_wa_envio_evento (provider_event_hash)');
        DB::statement('CREATE INDEX ix_ce_wa_evento_01 ON ce_wa_envio_evento (envio_id, dt_criacao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ce_wa_envio_evento');
        DB::statement('DROP TABLE ce_wa_lote_item');
        DB::statement('DROP TABLE ce_wa_envio');
        DB::statement('DROP TABLE ce_wa_lote');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_29_103000_CREATE_CE_WA_DELIVERY_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_02_100000_create_ele_cal_pleito_table.php`
## <DATABASE_MIGRATIONS_2026_08_02_100000_CREATE_ELE_CAL_PLEITO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_02_100000_create_ele_cal_pleito_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ELE_CAL_PLEITO (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ano                 NUMBER(4) NOT NULL,
    titulo              VARCHAR2(160 CHAR) NOT NULL,
    fonte_referencia    VARCHAR2(255 CHAR) NOT NULL,
    fonte_url           VARCHAR2(1000 CHAR) NOT NULL,
    ativo               NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    dt_atualizacao      TIMESTAMP,
    CONSTRAINT UK_ELE_CAL_PLEITO_ANO UNIQUE (ano),
    CONSTRAINT CK_ELE_CAL_PLEITO_ATIVO CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement('CREATE INDEX IX_ELE_CAL_PLEITO_ATIVO ON ELE_CAL_PLEITO (ativo, ano)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ELE_CAL_PLEITO CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_02_100000_CREATE_ELE_CAL_PLEITO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_02_101000_create_ele_cal_competencia_table.php`
## <DATABASE_MIGRATIONS_2026_08_02_101000_CREATE_ELE_CAL_COMPETENCIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_02_101000_create_ele_cal_competencia_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ELE_CAL_COMPETENCIA (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo              VARCHAR2(60 CHAR) NOT NULL,
    nome                VARCHAR2(160 CHAR) NOT NULL,
    cor                 VARCHAR2(7 CHAR) NOT NULL,
    ordem               NUMBER(5) DEFAULT 0 NOT NULL,
    ativo               NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    dt_atualizacao      TIMESTAMP,
    CONSTRAINT CK_ELE_CAL_COMP_ATIVO CHECK (ativo IN (0, 1)),
    CONSTRAINT CK_ELE_CAL_COMP_COR CHECK (REGEXP_LIKE(cor, '^#[0-9A-Fa-f]{6}$'))
)
SQL);

        DB::statement('CREATE UNIQUE INDEX UX_ELE_CAL_COMP_COD ON ELE_CAL_COMPETENCIA (UPPER(codigo))');
        DB::statement('CREATE INDEX IX_ELE_CAL_COMP_ATIVO ON ELE_CAL_COMPETENCIA (ativo, ordem, nome)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ELE_CAL_COMPETENCIA CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_02_101000_CREATE_ELE_CAL_COMPETENCIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_02_102000_create_ele_cal_evento_table.php`
## <DATABASE_MIGRATIONS_2026_08_02_102000_CREATE_ELE_CAL_EVENTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_02_102000_create_ele_cal_evento_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ELE_CAL_EVENTO (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    pleito_id           NUMBER NOT NULL,
    competencia_id      NUMBER NOT NULL,
    codigo              VARCHAR2(60 CHAR) NOT NULL,
    descricao_oficial   VARCHAR2(4000 CHAR) NOT NULL,
    data_inicio         DATE NOT NULL,
    data_fim            DATE NOT NULL,
    ordem               NUMBER(5) DEFAULT 0 NOT NULL,
    publicado           NUMBER(1) DEFAULT 0 NOT NULL,
    dt_criacao          TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    dt_atualizacao      TIMESTAMP,
    CONSTRAINT FK_ELE_CAL_EVT_PLEITO FOREIGN KEY (pleito_id) REFERENCES ELE_CAL_PLEITO (id),
    CONSTRAINT FK_ELE_CAL_EVT_COMP FOREIGN KEY (competencia_id) REFERENCES ELE_CAL_COMPETENCIA (id),
    CONSTRAINT CK_ELE_CAL_EVT_PUB CHECK (publicado IN (0, 1)),
    CONSTRAINT CK_ELE_CAL_EVT_DATAS CHECK (data_fim >= data_inicio)
)
SQL);

        DB::statement('CREATE UNIQUE INDEX UX_ELE_CAL_EVT_COD ON ELE_CAL_EVENTO (pleito_id, UPPER(codigo))');
        DB::statement('CREATE INDEX IX_ELE_CAL_EVT_PERIODO ON ELE_CAL_EVENTO (pleito_id, data_inicio, data_fim)');
        DB::statement('CREATE INDEX IX_ELE_CAL_EVT_PUBLIC ON ELE_CAL_EVENTO (pleito_id, publicado, data_inicio)');
        DB::statement('CREATE INDEX IX_ELE_CAL_EVT_COMP ON ELE_CAL_EVENTO (competencia_id)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ELE_CAL_EVENTO CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_02_102000_CREATE_ELE_CAL_EVENTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_05_120000_create_mrj_sync_tables.php`
## <DATABASE_MIGRATIONS_2026_08_05_120000_CREATE_MRJ_SYNC_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_05_120000_create_mrj_sync_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE mrj_sync_stage (
    cod_objeto                    VARCHAR2(18 CHAR) NOT NULL,
    num_mesa                      NUMBER(3, 0) NOT NULL,
    cod_objeto_zona               VARCHAR2(18 CHAR) NOT NULL,
    num_zona                      NUMBER(4, 0) NOT NULL,
    cod_objeto_municipio          VARCHAR2(18 CHAR) NOT NULL,
    cod_objeto_dat_eleicao        VARCHAR2(18 CHAR) NOT NULL,
    dat_eleicao                   DATE NOT NULL,
    tip_mrj                       NUMBER(1, 0),
    ind_publico                   NUMBER(1, 0),
    cod_objeto_local_votacao      VARCHAR2(18 CHAR),
    nom_local                     VARCHAR2(70 CHAR),
    des_endereco                  VARCHAR2(70 CHAR),
    des_observacao                VARCHAR2(70 CHAR),
    dat_criacao                   DATE
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE mrj (
    cod_objeto                    VARCHAR2(18 CHAR) NOT NULL,
    num_mesa                      NUMBER(3, 0) NOT NULL,
    cod_objeto_zona               VARCHAR2(18 CHAR) NOT NULL,
    num_zona                      NUMBER(4, 0) NOT NULL,
    cod_objeto_municipio          VARCHAR2(18 CHAR) NOT NULL,
    cod_objeto_dat_eleicao        VARCHAR2(18 CHAR) NOT NULL,
    dat_eleicao                   DATE NOT NULL,
    tip_mrj                       NUMBER(1, 0),
    ind_publico                   NUMBER(1, 0),
    cod_objeto_local_votacao      VARCHAR2(18 CHAR),
    nom_local                     VARCHAR2(70 CHAR),
    des_endereco                  VARCHAR2(70 CHAR),
    des_observacao                VARCHAR2(70 CHAR),
    dat_criacao                   DATE,
    CONSTRAINT pk_mrj PRIMARY KEY (cod_objeto)
)
SQL);

        DB::statement(
            'CREATE INDEX ix_mrj_local_eleicao_pub '
            .'ON mrj (cod_objeto_local_votacao, dat_eleicao, ind_publico)'
        );
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_mrj_local_eleicao_pub');
        DB::statement('DROP TABLE mrj_sync_stage');
        DB::statement('DROP TABLE mrj');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_05_120000_CREATE_MRJ_SYNC_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_10_123000_map_dg_to_gadg_in_vw_unidade.php`
## <DATABASE_MIGRATIONS_2026_08_10_123000_MAP_DG_TO_GADG_IN_VW_UNIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_10_123000_map_dg_to_gadg_in_vw_unidade.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS
SELECT
    U.ID_UNIDADE,
    REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA, 'ª ZE', ''))
        WHEN U.SIGLA IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE =
            CASE
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'COCRE' THEN 'VICE-CRE'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'DG' THEN 'GADG'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'STI' THEN 'GSTI'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SAOF' THEN 'GASAOF'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SEJUD' THEN 'GAJUD'
                ELSE REPLACE(U.SIGLA, 'ª ZE', 'ZONA')
            END
    ) AS TITULAR,
    U.DESCRICAO,
    EU.EMAIL
FROM SIPTSE.UNIDADE U
INNER JOIN SEITSE.EMAIL_UNIDADE EU
    ON U.ID_UNIDADE = EU.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA) LIKE 'Z-ARQUIVO%'
  )
SQL);
    }

    public function down(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS
SELECT
    U.ID_UNIDADE,
    REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA, 'ª ZE', ''))
        WHEN U.SIGLA IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE =
            CASE
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'COCRE' THEN 'VICE-CRE'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'STI' THEN 'GSTI'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SAOF' THEN 'GASAOF'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SEJUD' THEN 'GAJUD'
                ELSE REPLACE(U.SIGLA, 'ª ZE', 'ZONA')
            END
    ) AS TITULAR,
    U.DESCRICAO,
    EU.EMAIL
FROM SIPTSE.UNIDADE U
INNER JOIN SEITSE.EMAIL_UNIDADE EU
    ON U.ID_UNIDADE = EU.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA) LIKE 'Z-ARQUIVO%'
  )
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_10_123000_MAP_DG_TO_GADG_IN_VW_UNIDADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_10_124000_map_presi_to_gapres_in_vw_unidade.php`
## <DATABASE_MIGRATIONS_2026_08_10_124000_MAP_PRESI_TO_GAPRES_IN_VW_UNIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_10_124000_map_presi_to_gapres_in_vw_unidade.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS
SELECT
    U.ID_UNIDADE,
    REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA, 'ª ZE', ''))
        WHEN U.SIGLA IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE =
            CASE
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'COCRE' THEN 'VICE-CRE'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'DG' THEN 'GADG'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'PRESI' THEN 'GAPRES'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'STI' THEN 'GSTI'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SAOF' THEN 'GASAOF'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SEJUD' THEN 'GAJUD'
                ELSE REPLACE(U.SIGLA, 'ª ZE', 'ZONA')
            END
    ) AS TITULAR,
    U.DESCRICAO,
    EU.EMAIL
FROM SIPTSE.UNIDADE U
LEFT JOIN SEITSE.EMAIL_UNIDADE EU
    ON U.ID_UNIDADE = EU.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA) LIKE 'Z-ARQUIVO%'
  )
  AND (EU.ID_UNIDADE IS NOT NULL OR U.SIGLA = 'PRESI')
SQL);
    }

    public function down(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS
SELECT
    U.ID_UNIDADE,
    REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA, 'ª ZE', ''))
        WHEN U.SIGLA IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE =
            CASE
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'COCRE' THEN 'VICE-CRE'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'DG' THEN 'GADG'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'STI' THEN 'GSTI'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SAOF' THEN 'GASAOF'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SEJUD' THEN 'GAJUD'
                ELSE REPLACE(U.SIGLA, 'ª ZE', 'ZONA')
            END
    ) AS TITULAR,
    U.DESCRICAO,
    EU.EMAIL
FROM SIPTSE.UNIDADE U
INNER JOIN SEITSE.EMAIL_UNIDADE EU
    ON U.ID_UNIDADE = EU.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA) LIKE 'Z-ARQUIVO%'
  )
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_10_124000_MAP_PRESI_TO_GAPRES_IN_VW_UNIDADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_10_125000_map_converted_emails_in_vw_unidade.php`
## <DATABASE_MIGRATIONS_2026_08_10_125000_MAP_CONVERTED_EMAILS_IN_VW_UNIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_10_125000_map_converted_emails_in_vw_unidade.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS
WITH UNIDADES_NORMALIZADAS AS (
    SELECT
        U.ID_UNIDADE,
        U.SIGLA AS SIGLA_ORIGINAL,
        REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA_NORMALIZADA,
        U.DESCRICAO,
        U.SIN_ATIVO,
        U.SIN_GLOBAL
    FROM SIPTSE.UNIDADE U
),
UNIDADES_REFERENCIADAS AS (
    SELECT
        UNIDADE_NORMALIZADA.*,
        CASE
            WHEN SIGLA_NORMALIZADA = 'COCRE' THEN 'VICE-CRE'
            WHEN SIGLA_NORMALIZADA = 'DG' THEN 'GADG'
            WHEN SIGLA_NORMALIZADA = 'PRESI' THEN 'GAPRES'
            WHEN SIGLA_NORMALIZADA = 'STI' THEN 'GSTI'
            WHEN SIGLA_NORMALIZADA = 'SAOF' THEN 'GASAOF'
            WHEN SIGLA_NORMALIZADA = 'SEJUD' THEN 'GAJUD'
            ELSE SIGLA_NORMALIZADA
        END AS SIGLA_TITULAR,
        CASE
            WHEN SIGLA_NORMALIZADA = 'COCRE' THEN 'COCRE'
            WHEN SIGLA_NORMALIZADA = 'DG' THEN 'GADG'
            WHEN SIGLA_NORMALIZADA = 'PRESI' THEN 'GAPRES'
            WHEN SIGLA_NORMALIZADA = 'STI' THEN 'GSTI'
            WHEN SIGLA_NORMALIZADA = 'SAOF' THEN 'GASAOF'
            WHEN SIGLA_NORMALIZADA = 'SEJUD' THEN 'GAJUD'
            ELSE SIGLA_NORMALIZADA
        END AS SIGLA_EMAIL
    FROM UNIDADES_NORMALIZADAS UNIDADE_NORMALIZADA
)
SELECT
    U.ID_UNIDADE,
    U.SIGLA_NORMALIZADA AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA_ORIGINAL, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA_ORIGINAL, 'ª ZE', ''))
        WHEN U.SIGLA_ORIGINAL IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE = U.SIGLA_TITULAR
    ) AS TITULAR,
    U.DESCRICAO,
    CASE
        WHEN U.SIGLA_EMAIL = U.SIGLA_NORMALIZADA THEN EMAIL_ORIGEM.EMAIL
        ELSE (
            SELECT EMAIL_REFERENCIA.EMAIL
            FROM SIPTSE.UNIDADE UNIDADE_REFERENCIA_EMAIL
            INNER JOIN SEITSE.EMAIL_UNIDADE EMAIL_REFERENCIA
                ON EMAIL_REFERENCIA.ID_UNIDADE = UNIDADE_REFERENCIA_EMAIL.ID_UNIDADE
            WHERE UNIDADE_REFERENCIA_EMAIL.SIGLA = U.SIGLA_EMAIL
              AND UNIDADE_REFERENCIA_EMAIL.SIN_ATIVO = 'S'
              AND UNIDADE_REFERENCIA_EMAIL.SIN_GLOBAL = 'N'
        )
    END AS EMAIL
FROM UNIDADES_REFERENCIADAS U
LEFT JOIN SEITSE.EMAIL_UNIDADE EMAIL_ORIGEM
    ON EMAIL_ORIGEM.ID_UNIDADE = U.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA_ORIGINAL) LIKE 'Z-ARQUIVO%'
  )
  AND (EMAIL_ORIGEM.ID_UNIDADE IS NOT NULL OR U.SIGLA_ORIGINAL = 'PRESI')
SQL);
    }

    public function down(): void
    {
        DB::unprepared(<<<'SQL'
CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE" ("ID_UNIDADE", "SIGLA", "COD_OBJETO_ZONA", "TITULAR", "DESCRICAO", "EMAIL") AS
SELECT
    U.ID_UNIDADE,
    REPLACE(U.SIGLA, 'ª ZE', 'ZONA') AS SIGLA,
    CASE
        WHEN REGEXP_LIKE(TRIM(REPLACE(U.SIGLA, 'ª ZE', '')), '^[0-9]+$')
        THEN TRIM(REPLACE(U.SIGLA, 'ª ZE', ''))
        WHEN U.SIGLA IN ('CIE','SDBD','GSTI','CAVE','AGEL','GADG','CRE') THEN '0'
        ELSE NULL
    END AS COD_OBJETO_ZONA,
    (
        SELECT VW.TITULAR
        FROM VW_UNIDADE_TITULAR VW
        WHERE VW.SIGLA_UNID_TSE =
            CASE
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'COCRE' THEN 'VICE-CRE'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'DG' THEN 'GADG'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'PRESI' THEN 'GAPRES'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'STI' THEN 'GSTI'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SAOF' THEN 'GASAOF'
                WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'SEJUD' THEN 'GAJUD'
                ELSE REPLACE(U.SIGLA, 'ª ZE', 'ZONA')
            END
    ) AS TITULAR,
    U.DESCRICAO,
    EU.EMAIL
FROM SIPTSE.UNIDADE U
LEFT JOIN SEITSE.EMAIL_UNIDADE EU
    ON U.ID_UNIDADE = EU.ID_UNIDADE
WHERE U.SIN_ATIVO = 'S'
  AND U.SIN_GLOBAL = 'N'
  AND NOT (
      UPPER(U.SIGLA) LIKE 'Z-ARQUIVO%'
  )
  AND (EU.ID_UNIDADE IS NOT NULL OR U.SIGLA = 'PRESI')
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_10_125000_MAP_CONVERTED_EMAILS_IN_VW_UNIDADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_21_160000_create_svi_domain_tables.php`
## <DATABASE_MIGRATIONS_2026_08_21_160000_CREATE_SVI_DOMAIN_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_21_160000_create_svi_domain_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table($tabela)->insert([
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

return new class extends Migration
{
    /** @var array<string, array<string, string>> */
    private const DOMINIOS = [
        'SVI_SOLICITANTE_TIPO' => [
            'ELEITOR' => 'Eleitor', 'CURADOR' => 'Curador', 'APOIADOR' => 'Apoiador', 'PROCURADOR' => 'Procurador',
        ],
        'SVI_CONTATO_PREFERENCIA' => [
            'WHATSAPP' => 'WhatsApp', 'LIGACAO' => 'Ligação', 'SMS' => 'SMS',
        ],
        'SVI_CONDICAO' => [
            'FISICA' => 'Deficiência física', 'VISUAL' => 'Deficiência visual',
            'AUDITIVA' => 'Deficiência auditiva', 'INTELECTUAL' => 'Deficiência intelectual',
            'MULTIPLA' => 'Deficiência múltipla', 'TEA' => 'Transtorno do espectro autista',
            'MOBILIDADE_REDUZIDA' => 'Mobilidade reduzida',
        ],
        'SVI_EQUIPAMENTO' => [
            'CADEIRA_MANUAL' => 'Cadeira de rodas manual', 'CADEIRA_MOTORIZADA' => 'Cadeira de rodas motorizada',
            'ANDADOR' => 'Andador', 'MULETAS' => 'Muletas', 'BENGALA' => 'Bengala',
            'PROTESE' => 'Prótese', 'OXIGENIO' => 'Oxigênio', 'CAO_GUIA' => 'Cão-guia',
            'OUTRO' => 'Outro', 'NENHUM' => 'Nenhum',
        ],
        'SVI_SOLICITACAO_STATUS' => [
            'RECEBIDA' => 'Recebida', 'EM_ANALISE' => 'Em análise', 'PENDENCIA' => 'Pendência',
            'DEFERIDA' => 'Deferida', 'INDEFERIDA' => 'Indeferida', 'CANCELADA' => 'Cancelada',
        ],
        'SVI_TURNO_STATUS' => [
            'AGUARDANDO_AGENDAMENTO' => 'Aguardando agendamento', 'AGENDADA' => 'Agendada',
            'CONCLUIDA' => 'Concluída', 'CANCELADA' => 'Cancelada',
        ],
    ];

    /** @var array<string, string> */
    private const CONSTRAINTS_ATIVO = [
        'SVI_SOLICITANTE_TIPO' => 'CK_SVI_SOL_TIPO_ATIVO',
        'SVI_CONTATO_PREFERENCIA' => 'CK_SVI_CONT_PREF_ATIVO',
        'SVI_CONDICAO' => 'CK_SVI_COND_ATIVO',
        'SVI_EQUIPAMENTO' => 'CK_SVI_EQUIP_ATIVO',
        'SVI_SOLICITACAO_STATUS' => 'CK_SVI_SOL_STATUS_ATIVO',
        'SVI_TURNO_STATUS' => 'CK_SVI_TUR_STATUS_ATIVO',
    ];

    public function up(): void
    {
        foreach (self::DOMINIOS as $tabela => $itens) {
            $constraintAtivo = self::CONSTRAINTS_ATIVO[$tabela];
            DB::statement("CREATE TABLE {$tabela} (
                CODIGO VARCHAR2(40 CHAR) PRIMARY KEY,
                DESCRICAO VARCHAR2(200 CHAR) NOT NULL,
                ORDEM NUMBER(5) NOT NULL,
                ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
                DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
                CONSTRAINT {$constraintAtivo} CHECK (ATIVO IN (0, 1))
            )");

            $ordem = 1;
            foreach ($itens as $codigo => $descricao) {
                DB::table($tabela)->insert([
                    'CODIGO' => $codigo,
                    'DESCRICAO' => $descricao,
                    'ORDEM' => $ordem++,
                    'ATIVO' => 1,
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ]);
            }
        }
    }

    public function down(): void
    {
        foreach (array_reverse(array_keys(self::DOMINIOS)) as $tabela) {
            DB::statement("DROP TABLE {$tabela}");
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_08_21_160000_CREATE_SVI_DOMAIN_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_21_161000_create_svi_business_tables.php`
## <DATABASE_MIGRATIONS_2026_08_21_161000_CREATE_SVI_BUSINESS_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_21_161000_create_svi_business_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE SVI_CONFIGURACAO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    MACROPROJETO_ID NUMBER NOT NULL,
    DT_ABERTURA DATE NOT NULL,
    DT_ENCERRAMENTO DATE NOT NULL,
    DT_PRIMEIRO_TURNO DATE NOT NULL,
    DT_SEGUNDO_TURNO DATE,
    SEGUNDO_TURNO_CONFIRMADO NUMBER(1) DEFAULT 0 NOT NULL,
    AVISO_PRIVACIDADE CLOB NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    CONSTRAINT UX_SVI_CONFIG_MACRO UNIQUE (MACROPROJETO_ID),
    CONSTRAINT FK_SVI_CONFIG_MACRO FOREIGN KEY (MACROPROJETO_ID) REFERENCES MACROPROJETO(ID),
    CONSTRAINT CK_SVI_CONFIG_ATIVO CHECK (ATIVO IN (0, 1)),
    CONSTRAINT CK_SVI_CONFIG_2T CHECK (SEGUNDO_TURNO_CONFIRMADO IN (0, 1)),
    CONSTRAINT CK_SVI_CONFIG_JANELA CHECK (DT_ENCERRAMENTO >= DT_ABERTURA)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE SVI_SOLICITACAO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    PROTOCOLO VARCHAR2(30 CHAR) NOT NULL,
    MACROPROJETO_ID NUMBER NOT NULL,
    CONFIGURACAO_ID NUMBER NOT NULL,
    NUM_INSCRICAO VARCHAR2(12 CHAR) NOT NULL,
    ELEITOR_NOME VARCHAR2(200 CHAR) NOT NULL,
    DT_NASCIMENTO DATE NOT NULL,
    IDADE NUMBER(3) NOT NULL,
    ZONA_NUMERO NUMBER(5) NOT NULL,
    SECAO_NUMERO VARCHAR2(10 CHAR) NOT NULL,
    LOCAL_COD_OBJETO VARCHAR2(80 CHAR) NOT NULL,
    LOCAL_NUMERO NUMBER(10),
    LOCAL_NOME VARCHAR2(255 CHAR) NOT NULL,
    LOCAL_ENDERECO VARCHAR2(500 CHAR),
    MUNICIPIO_NOME VARCHAR2(160 CHAR) NOT NULL,
    SOLICITANTE_TIPO_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    SOLICITANTE_NOME VARCHAR2(200 CHAR),
    SOLICITANTE_TITULO VARCHAR2(12 CHAR),
    SOLICITANTE_TELEFONE VARCHAR2(20 CHAR),
    ELEITOR_TELEFONE VARCHAR2(20 CHAR) NOT NULL,
    ELEITOR_EMAIL VARCHAR2(255 CHAR) NOT NULL,
    CONTATO_PREFERENCIA_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    ENDERECO_LOGRADOURO VARCHAR2(255 CHAR) NOT NULL,
    ENDERECO_NUMERO VARCHAR2(30 CHAR) NOT NULL,
    ENDERECO_BAIRRO VARCHAR2(160 CHAR) NOT NULL,
    ENDERECO_MUNICIPIO VARCHAR2(160 CHAR) NOT NULL,
    ENDERECO_REFERENCIA VARCHAR2(500 CHAR) NOT NULL,
    VEICULO_ACESSA_CODIGO VARCHAR2(3 CHAR) NOT NULL,
    ENDERECO_ALTERNATIVO VARCHAR2(1000 CHAR),
    CONDICAO_DESCRICAO VARCHAR2(1000 CHAR),
    COMPROVACAO_TIPO_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    IMPACTO_CODIGO VARCHAR2(20 CHAR) NOT NULL,
    EQUIPAMENTO_OUTRO VARCHAR2(500 CHAR),
    TRANSPORTE_PUBLICO_CODIGO VARCHAR2(20 CHAR) NOT NULL,
    ACOMPANHANTE_CODIGO VARCHAR2(3 CHAR) NOT NULL,
    ACOMPANHANTE_NOME VARCHAR2(200 CHAR),
    ACOMPANHANTE_TELEFONE VARCHAR2(20 CHAR),
    SEGUNDO_TURNO_CODIGO VARCHAR2(3 CHAR) NOT NULL,
    OBSERVACOES VARCHAR2(2000 CHAR),
    STATUS_CODIGO VARCHAR2(40 CHAR) DEFAULT 'RECEBIDA' NOT NULL,
    MENSAGEM_PUBLICA VARCHAR2(2000 CHAR),
    DECLARACAO_ESPERA NUMBER(1) DEFAULT 1 NOT NULL,
    DECLARACAO_SEM_TRANSPORTE NUMBER(1) DEFAULT 1 NOT NULL,
    DECLARACAO_ANALISE NUMBER(1) DEFAULT 1 NOT NULL,
    DECLARACAO_SEM_AJUDANTE NUMBER(1) DEFAULT 1 NOT NULL,
    DECLARACAO_COMPARTILHADO NUMBER(1) DEFAULT 1 NOT NULL,
    DECLARACAO_HORARIO NUMBER(1) DEFAULT 1 NOT NULL,
    DECLARACAO_PRIVACIDADE NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    VERSAO NUMBER(10) DEFAULT 1 NOT NULL,
    CONSTRAINT UX_SVI_SOL_PROTOCOLO UNIQUE (PROTOCOLO),
    CONSTRAINT UX_SVI_SOL_MACRO_TIT UNIQUE (MACROPROJETO_ID, NUM_INSCRICAO),
    CONSTRAINT FK_SVI_SOL_CONFIG FOREIGN KEY (CONFIGURACAO_ID) REFERENCES SVI_CONFIGURACAO(ID),
    CONSTRAINT FK_SVI_SOL_TIPO FOREIGN KEY (SOLICITANTE_TIPO_CODIGO) REFERENCES SVI_SOLICITANTE_TIPO(CODIGO),
    CONSTRAINT FK_SVI_SOL_CONTATO FOREIGN KEY (CONTATO_PREFERENCIA_CODIGO) REFERENCES SVI_CONTATO_PREFERENCIA(CODIGO),
    CONSTRAINT FK_SVI_SOL_STATUS FOREIGN KEY (STATUS_CODIGO) REFERENCES SVI_SOLICITACAO_STATUS(CODIGO),
    CONSTRAINT CK_SVI_SOL_DECL CHECK (
        DECLARACAO_ESPERA = 1 AND DECLARACAO_SEM_TRANSPORTE = 1 AND DECLARACAO_ANALISE = 1
        AND DECLARACAO_SEM_AJUDANTE = 1 AND DECLARACAO_COMPARTILHADO = 1
        AND DECLARACAO_HORARIO = 1 AND DECLARACAO_PRIVACIDADE = 1
    )
)
SQL);

        DB::statement('CREATE INDEX IX_SVI_SOL_STATUS ON SVI_SOLICITACAO (STATUS_CODIGO, DT_CRIACAO)');
        DB::statement('CREATE INDEX IX_SVI_SOL_ZONA ON SVI_SOLICITACAO (ZONA_NUMERO, DT_CRIACAO)');
        DB::statement('CREATE INDEX IX_SVI_SOL_MUNICIPIO ON SVI_SOLICITACAO (MUNICIPIO_NOME)');

        DB::statement(<<<'SQL'
CREATE TABLE SVI_SOLICITACAO_CONDICAO (
    SOLICITACAO_ID NUMBER NOT NULL,
    CONDICAO_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_SVI_SOL_COND PRIMARY KEY (SOLICITACAO_ID, CONDICAO_CODIGO),
    CONSTRAINT FK_SVI_SOL_COND_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT FK_SVI_SOL_COND_DOM FOREIGN KEY (CONDICAO_CODIGO) REFERENCES SVI_CONDICAO(CODIGO)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE SVI_SOLICITACAO_EQUIP (
    SOLICITACAO_ID NUMBER NOT NULL,
    EQUIPAMENTO_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_SVI_SOL_EQUIP PRIMARY KEY (SOLICITACAO_ID, EQUIPAMENTO_CODIGO),
    CONSTRAINT FK_SVI_SOL_EQ_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT FK_SVI_SOL_EQ_DOM FOREIGN KEY (EQUIPAMENTO_CODIGO) REFERENCES SVI_EQUIPAMENTO(CODIGO)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE SVI_SOLICITACAO_TURNO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    SOLICITACAO_ID NUMBER NOT NULL,
    NUMERO_TURNO NUMBER(1) NOT NULL,
    STATUS_CODIGO VARCHAR2(40 CHAR) DEFAULT 'AGUARDANDO_AGENDAMENTO' NOT NULL,
    DATA_VOTACAO DATE NOT NULL,
    PONTO_EMBARQUE VARCHAR2(1000 CHAR),
    HORARIO_PREVISTO DATE,
    OBSERVACAO_PUBLICA VARCHAR2(2000 CHAR),
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    CONSTRAINT UX_SVI_TURNO_SOL_NUM UNIQUE (SOLICITACAO_ID, NUMERO_TURNO),
    CONSTRAINT FK_SVI_TURNO_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT FK_SVI_TURNO_STATUS FOREIGN KEY (STATUS_CODIGO) REFERENCES SVI_TURNO_STATUS(CODIGO),
    CONSTRAINT CK_SVI_TURNO_NUM CHECK (NUMERO_TURNO IN (1, 2))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE SVI_ANEXO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    SOLICITACAO_ID NUMBER NOT NULL,
    CATEGORIA VARCHAR2(20 CHAR) NOT NULL,
    DISCO VARCHAR2(40 CHAR) DEFAULT 'local' NOT NULL,
    CAMINHO VARCHAR2(1000 CHAR) NOT NULL,
    NOME_ORIGINAL VARCHAR2(255 CHAR) NOT NULL,
    MIME VARCHAR2(100 CHAR) NOT NULL,
    TAMANHO_BYTES NUMBER(15) NOT NULL,
    SHA256 VARCHAR2(64 CHAR) NOT NULL,
    SCAN_STATUS VARCHAR2(20 CHAR) DEFAULT 'PENDENTE' NOT NULL,
    SCANNER VARCHAR2(100 CHAR),
    SCANEADO_EM DATE,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT UX_SVI_ANEXO_CATEG UNIQUE (SOLICITACAO_ID, CATEGORIA),
    CONSTRAINT FK_SVI_ANEXO_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT CK_SVI_ANEXO_CAT CHECK (CATEGORIA IN ('REPRESENTACAO', 'CONDICAO')),
    CONSTRAINT CK_SVI_ANEXO_SCAN CHECK (SCAN_STATUS IN ('PENDENTE', 'LIMPO', 'INFECTADO', 'ERRO'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE SVI_HISTORICO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    SOLICITACAO_ID NUMBER NOT NULL,
    TURNO_ID NUMBER,
    TIPO_EVENTO VARCHAR2(60 CHAR) NOT NULL,
    STATUS_ANTERIOR VARCHAR2(40 CHAR),
    STATUS_NOVO VARCHAR2(40 CHAR),
    MENSAGEM_PUBLICA VARCHAR2(2000 CHAR),
    USUARIO VARCHAR2(160 CHAR),
    DT_EVENTO DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT FK_SVI_HIST_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT FK_SVI_HIST_TURNO FOREIGN KEY (TURNO_ID) REFERENCES SVI_SOLICITACAO_TURNO(ID)
)
SQL);
        DB::statement('CREATE INDEX IX_SVI_HIST_SOL_DATA ON SVI_HISTORICO (SOLICITACAO_ID, DT_EVENTO)');
    }

    public function down(): void
    {
        foreach (['SVI_HISTORICO', 'SVI_ANEXO', 'SVI_SOLICITACAO_TURNO', 'SVI_SOLICITACAO_EQUIP',
            'SVI_SOLICITACAO_CONDICAO', 'SVI_SOLICITACAO', 'SVI_CONFIGURACAO'] as $tabela) {
            DB::statement("DROP TABLE {$tabela}");
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_08_21_161000_CREATE_SVI_BUSINESS_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_21_162000_create_svi_access_tables.php`
## <DATABASE_MIGRATIONS_2026_08_21_162000_CREATE_SVI_ACCESS_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_21_162000_create_svi_access_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE SVI_ACESSO_DESAFIO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    SOLICITACAO_ID NUMBER NOT NULL,
    CODIGO_HMAC VARCHAR2(64 CHAR) NOT NULL,
    TENTATIVAS NUMBER(2) DEFAULT 0 NOT NULL,
    EXPIRA_EM DATE NOT NULL,
    USADO_EM DATE,
    BLOQUEADO_EM DATE,
    IP_HASH VARCHAR2(64 CHAR),
    USER_AGENT_HASH VARCHAR2(64 CHAR),
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT FK_SVI_DESAFIO_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT CK_SVI_DESAFIO_TENT CHECK (TENTATIVAS BETWEEN 0 AND 5)
)
SQL);
        DB::statement('CREATE INDEX IX_SVI_DESAFIO_SOL ON SVI_ACESSO_DESAFIO (SOLICITACAO_ID, EXPIRA_EM)');

        DB::statement(<<<'SQL'
CREATE TABLE SVI_NOTIFICACAO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    SOLICITACAO_ID NUMBER NOT NULL,
    DESAFIO_ID NUMBER,
    TIPO VARCHAR2(40 CHAR) NOT NULL,
    STATUS VARCHAR2(20 CHAR) NOT NULL,
    DESTINO_HASH VARCHAR2(64 CHAR),
    TENTATIVAS NUMBER(5) DEFAULT 0 NOT NULL,
    ERRO_CATEGORIA VARCHAR2(100 CHAR),
    ENVIADO_EM DATE,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    CONSTRAINT FK_SVI_NOTIF_SOL FOREIGN KEY (SOLICITACAO_ID) REFERENCES SVI_SOLICITACAO(ID),
    CONSTRAINT FK_SVI_NOTIF_DES FOREIGN KEY (DESAFIO_ID) REFERENCES SVI_ACESSO_DESAFIO(ID),
    CONSTRAINT CK_SVI_NOTIF_STATUS CHECK (STATUS IN ('PENDENTE', 'ENVIADA', 'ERRO'))
)
SQL);
        DB::statement('CREATE INDEX IX_SVI_NOTIF_STATUS ON SVI_NOTIFICACAO (STATUS, DT_CRIACAO)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE SVI_NOTIFICACAO');
        DB::statement('DROP TABLE SVI_ACESSO_DESAFIO');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_21_162000_CREATE_SVI_ACCESS_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_27_214000_evolve_svi_public_form.php`
## <DATABASE_MIGRATIONS_2026_08_27_214000_EVOLVE_SVI_PUBLIC_FORM_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_27_214000_evolve_svi_public_form.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
&& DB::table('SVI_SOLICITACAO')->whereNull('ELEITOR_EMAIL')->exists()) {
if ($colunasExistentes !== [] && DB::table('SVI_SOLICITACAO')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function columnExists(string $table, string $column): bool
private function columnNullable(string $table, string $column): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /** @var array<string, string> */
    private const COLUNAS = [
        'END_ALT_LOGRADOURO' => 'VARCHAR2(255 CHAR)',
        'END_ALT_NUMERO' => 'VARCHAR2(30 CHAR)',
        'END_ALT_BAIRRO' => 'VARCHAR2(160 CHAR)',
        'END_ALT_REFERENCIA' => 'VARCHAR2(500 CHAR)',
        'AUTODECLARACAO_TEXTO' => 'VARCHAR2(2000 CHAR)',
        'IMPACTO_DESCRICAO' => 'VARCHAR2(2000 CHAR)',
    ];

    public function up(): void
    {
        if (! $this->columnNullable('SVI_SOLICITACAO', 'ELEITOR_EMAIL')) {
            DB::statement('ALTER TABLE SVI_SOLICITACAO MODIFY (ELEITOR_EMAIL NULL)');
        }

        foreach (self::COLUNAS as $coluna => $tipo) {
            if (! $this->columnExists('SVI_SOLICITACAO', $coluna)) {
                DB::statement("ALTER TABLE SVI_SOLICITACAO ADD ({$coluna} {$tipo})");
            }
        }
    }

    public function down(): void
    {
        if ($this->columnExists('SVI_SOLICITACAO', 'ELEITOR_EMAIL')
            && DB::table('SVI_SOLICITACAO')->whereNull('ELEITOR_EMAIL')->exists()) {
            throw new RuntimeException(
                'Rollback recusado: existem solicitações sem e-mail no novo fluxo público.'
            );
        }

        $colunasExistentes = array_values(array_filter(
            array_keys(self::COLUNAS),
            fn (string $coluna): bool => $this->columnExists('SVI_SOLICITACAO', $coluna),
        ));
        if ($colunasExistentes !== [] && DB::table('SVI_SOLICITACAO')
            ->where(function (Builder $query) use ($colunasExistentes): void {
                foreach ($colunasExistentes as $coluna) {
                    $query->orWhereNotNull($coluna);
                }
            })->exists()) {
            throw new RuntimeException(
                'Rollback recusado: existem solicitações com dados do formulário revisado.'
            );
        }

        foreach (array_reverse(array_keys(self::COLUNAS)) as $coluna) {
            if ($this->columnExists('SVI_SOLICITACAO', $coluna)) {
                DB::statement("ALTER TABLE SVI_SOLICITACAO DROP COLUMN {$coluna}");
            }
        }

        if ($this->columnNullable('SVI_SOLICITACAO', 'ELEITOR_EMAIL')) {
            DB::statement('ALTER TABLE SVI_SOLICITACAO MODIFY (ELEITOR_EMAIL NOT NULL)');
        }
    }

    private function columnExists(string $table, string $column): bool
    {
        return DB::selectOne(
            "SELECT 1 AS ok
             FROM ALL_TAB_COLUMNS
             WHERE OWNER = 'PLANELEITO'
               AND TABLE_NAME = :table_name
               AND COLUMN_NAME = :column_name",
            [
                'table_name' => strtoupper($table),
                'column_name' => strtoupper($column),
            ],
        ) !== null;
    }

    private function columnNullable(string $table, string $column): bool
    {
        $registro = DB::selectOne(
            "SELECT NULLABLE
             FROM ALL_TAB_COLUMNS
             WHERE OWNER = 'PLANELEITO'
               AND TABLE_NAME = :table_name
               AND COLUMN_NAME = :column_name",
            [
                'table_name' => strtoupper($table),
                'column_name' => strtoupper($column),
            ],
        );

        return strtoupper((string) ($registro->nullable ?? 'N')) === 'Y';
    }
};
```
</DATABASE_MIGRATIONS_2026_08_27_214000_EVOLVE_SVI_PUBLIC_FORM_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_09_11_120000_create_ca_registro_domain_tables.php`
## <DATABASE_MIGRATIONS_2026_09_11_120000_CREATE_CA_REGISTRO_DOMAIN_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_09_11_120000_create_ca_registro_domain_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table($tabela)->insert([
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

return new class extends Migration
{
    /** @var array<string, array<int, array{0:string,1:string,2:int}>> */
    private const CATALOGOS = [
        'CA_REGISTRO_STATUS' => [
            ['RASCUNHO', 'Rascunho', 1],
            ['ENVIADO', 'Enviado', 2],
        ],
        'CA_ATENDIMENTO_TIPO' => [
            ['FISICA_MOBILIDADE', 'Deficiência física ou mobilidade reduzida (gestante, idoso ou pessoa obesa)', 1],
            ['VISUAL', 'Deficiência visual', 2],
            ['AUDITIVA', 'Deficiência auditiva', 3],
            ['INTELECTUAL', 'Deficiência intelectual', 4],
            ['TEA', 'Transtorno do Espectro Autista (TEA)', 5],
            ['OUTROS', 'Outros', 6],
        ],
        'CA_OCORRENCIA_TIPO' => [
            ['SINALIZACAO_INADEQUADA', 'Falta de sinalização adequada', 1],
            ['PORTA_ESTREITA', 'Porta estreita impedindo a passagem de cadeira de rodas', 2],
            ['RAMPA_INADEQUADA', 'Ausência ou inadequação de rampa', 3],
            ['BANHEIRO_INACESSIVEL', 'Banheiro inacessível', 4],
            ['PRIORIDADE_NAO_RESPEITADA', 'Falta de atendimento prioritário', 5],
            ['CONFLITO_CONSTRANGIMENTO', 'Conflito ou situação constrangedora', 6],
            ['OUTROS', 'Outras ocorrências', 7],
        ],
    ];

    public function up(): void
    {
        foreach (self::CATALOGOS as $tabela => $itens) {
            DB::statement("CREATE TABLE {$tabela} (
                CODIGO VARCHAR2(40 CHAR) NOT NULL,
                DESCRICAO VARCHAR2(255 CHAR) NOT NULL,
                ORDEM NUMBER(3) NOT NULL,
                ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
                CONSTRAINT PK_{$tabela} PRIMARY KEY (CODIGO),
                CONSTRAINT CK_{$tabela}_ATIVO CHECK (ATIVO IN (0, 1))
            )");

            foreach ($itens as [$codigo, $descricao, $ordem]) {
                DB::table($tabela)->insert([
                    'CODIGO' => $codigo,
                    'DESCRICAO' => $descricao,
                    'ORDEM' => $ordem,
                    'ATIVO' => 1,
                ]);
            }
        }

        DB::statement(<<<'SQL'
CREATE TABLE CA_REGISTRO_CONFIGURACAO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    MACROPROJETO_TURNO_ID NUMBER NOT NULL,
    DT_ABERTURA DATE,
    DT_FECHAMENTO DATE,
    ATIVO NUMBER(1) DEFAULT 0 NOT NULL,
    VERSAO NUMBER(10) DEFAULT 1 NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    USUARIO_ATUALIZACAO VARCHAR2(120 CHAR),
    CONSTRAINT PK_CA_REG_CFG PRIMARY KEY (ID),
    CONSTRAINT FK_CA_REG_CFG_TURNO FOREIGN KEY (MACROPROJETO_TURNO_ID) REFERENCES MACROPROJETO_TURNO (ID),
    CONSTRAINT UK_CA_REG_CFG_TURNO UNIQUE (MACROPROJETO_TURNO_ID),
    CONSTRAINT CK_CA_REG_CFG_ATIVO CHECK (ATIVO IN (0, 1)),
    CONSTRAINT CK_CA_REG_CFG_VERSAO CHECK (VERSAO > 0),
    CONSTRAINT CK_CA_REG_CFG_PERIODO CHECK (DT_ABERTURA IS NULL OR DT_FECHAMENTO IS NULL OR DT_FECHAMENTO > DT_ABERTURA)
)
SQL);
        DB::statement('CREATE INDEX IX_CA_REG_CFG_JANELA ON CA_REGISTRO_CONFIGURACAO (ATIVO, DT_ABERTURA, DT_FECHAMENTO)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE CA_REGISTRO_CONFIGURACAO');
        foreach (array_reverse(array_keys(self::CATALOGOS)) as $tabela) {
            DB::statement("DROP TABLE {$tabela}");
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_09_11_120000_CREATE_CA_REGISTRO_DOMAIN_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_09_11_121000_create_ca_registro_eleicao_tables.php`
## <DATABASE_MIGRATIONS_2026_09_11_121000_CREATE_CA_REGISTRO_ELEICAO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_09_11_121000_create_ca_registro_eleicao_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

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

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE CA_REGISTRO_ELEICAO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    MACROPROJETO_TURNO_ID NUMBER NOT NULL,
    ID_COORDENADOR_ACESSIBILIDADE NUMBER,
    NUM_INSCRICAO VARCHAR2(20 CHAR) NOT NULL,
    ORIGEM_CADASTRO VARCHAR2(20 CHAR) NOT NULL,
    NOME_COORDENADOR VARCHAR2(255 CHAR) NOT NULL,
    NUM_ZONA VARCHAR2(20 CHAR) NOT NULL,
    MUNICIPIO_NOME VARCHAR2(255 CHAR) NOT NULL,
    LOCAL_CODIGO VARCHAR2(30 CHAR) NOT NULL,
    LOCAL_NOME VARCHAR2(255 CHAR) NOT NULL,
    DATA_ELEICAO DATE,
    HORARIO_INICIAL VARCHAR2(5 CHAR),
    HORARIO_FINAL VARCHAR2(5 CHAR),
    TOTAL_ATENDIDO NUMBER(9),
    PROVIDENCIAS CLOB,
    SUGESTOES CLOB,
    STATUS_CODIGO VARCHAR2(20 CHAR) DEFAULT 'RASCUNHO' NOT NULL,
    VERSAO NUMBER(10) DEFAULT 1 NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ENVIO DATE,
    DT_REABERTURA DATE,
    IP_ULTIMA_ALTERACAO VARCHAR2(45 CHAR),
    USER_AGENT_ULTIMA_ALTERACAO VARCHAR2(500 CHAR),
    CONSTRAINT PK_CA_REG_ELEICAO PRIMARY KEY (ID),
    CONSTRAINT FK_CA_REG_ELEICAO_TURNO FOREIGN KEY (MACROPROJETO_TURNO_ID) REFERENCES MACROPROJETO_TURNO (ID),
    CONSTRAINT FK_CA_REG_ELEICAO_COORD FOREIGN KEY (ID_COORDENADOR_ACESSIBILIDADE) REFERENCES CAD_COORDENADOR_ACESSIBILIDADE (ID_COORDENADOR_ACESSIBILIDADE) ON DELETE SET NULL,
    CONSTRAINT FK_CA_REG_ELEICAO_STATUS FOREIGN KEY (STATUS_CODIGO) REFERENCES CA_REGISTRO_STATUS (CODIGO),
    CONSTRAINT UK_CA_REG_ELEICAO UNIQUE (MACROPROJETO_TURNO_ID, NUM_INSCRICAO),
    CONSTRAINT CK_CA_REG_ELEICAO_ORIGEM CHECK (ORIGEM_CADASTRO IN ('AVULSO', 'VOLUNTARIO')),
    CONSTRAINT CK_CA_REG_ELEICAO_TOTAL CHECK (TOTAL_ATENDIDO IS NULL OR TOTAL_ATENDIDO >= 0),
    CONSTRAINT CK_CA_REG_ELEICAO_VERSAO CHECK (VERSAO > 0)
)
SQL);
        DB::statement('CREATE INDEX IX_CA_REG_ELEICAO_STATUS ON CA_REGISTRO_ELEICAO (MACROPROJETO_TURNO_ID, STATUS_CODIGO)');
        DB::statement('CREATE INDEX IX_CA_REG_ELEICAO_ZONA ON CA_REGISTRO_ELEICAO (NUM_ZONA, MUNICIPIO_NOME)');
        DB::statement('CREATE INDEX IX_CA_REG_ELEICAO_LOCAL ON CA_REGISTRO_ELEICAO (LOCAL_CODIGO)');

        DB::statement(<<<'SQL'
CREATE TABLE CA_REGISTRO_ATENDIMENTO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    REGISTRO_ID NUMBER NOT NULL,
    TIPO_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    QUANTIDADE NUMBER(9) NOT NULL,
    DETALHES CLOB,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    CONSTRAINT PK_CA_REG_ATEND PRIMARY KEY (ID),
    CONSTRAINT FK_CA_REG_ATEND_REG FOREIGN KEY (REGISTRO_ID) REFERENCES CA_REGISTRO_ELEICAO (ID) ON DELETE CASCADE,
    CONSTRAINT FK_CA_REG_ATEND_TIPO FOREIGN KEY (TIPO_CODIGO) REFERENCES CA_ATENDIMENTO_TIPO (CODIGO),
    CONSTRAINT UK_CA_REG_ATEND UNIQUE (REGISTRO_ID, TIPO_CODIGO),
    CONSTRAINT CK_CA_REG_ATEND_QTD CHECK (QUANTIDADE >= 0)
)
SQL);
        DB::statement('CREATE INDEX IX_CA_REG_ATEND_TIPO ON CA_REGISTRO_ATENDIMENTO (TIPO_CODIGO, QUANTIDADE)');

        DB::statement(<<<'SQL'
CREATE TABLE CA_REGISTRO_OCORRENCIA (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    REGISTRO_ID NUMBER NOT NULL,
    TIPO_CODIGO VARCHAR2(40 CHAR) NOT NULL,
    QUANTIDADE NUMBER(9) NOT NULL,
    DETALHES CLOB,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    CONSTRAINT PK_CA_REG_OCOR PRIMARY KEY (ID),
    CONSTRAINT FK_CA_REG_OCOR_REG FOREIGN KEY (REGISTRO_ID) REFERENCES CA_REGISTRO_ELEICAO (ID) ON DELETE CASCADE,
    CONSTRAINT FK_CA_REG_OCOR_TIPO FOREIGN KEY (TIPO_CODIGO) REFERENCES CA_OCORRENCIA_TIPO (CODIGO),
    CONSTRAINT UK_CA_REG_OCOR UNIQUE (REGISTRO_ID, TIPO_CODIGO),
    CONSTRAINT CK_CA_REG_OCOR_QTD CHECK (QUANTIDADE >= 0)
)
SQL);
        DB::statement('CREATE INDEX IX_CA_REG_OCOR_TIPO ON CA_REGISTRO_OCORRENCIA (TIPO_CODIGO, QUANTIDADE)');

        DB::statement(<<<'SQL'
CREATE TABLE CA_REGISTRO_HISTORICO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    REGISTRO_ID NUMBER NOT NULL,
    STATUS_ANTERIOR VARCHAR2(20 CHAR),
    STATUS_NOVO VARCHAR2(20 CHAR) NOT NULL,
    NUM_INSCRICAO VARCHAR2(20 CHAR) NOT NULL,
    DT_EVENTO DATE DEFAULT SYSDATE NOT NULL,
    IP_EVENTO VARCHAR2(45 CHAR),
    USER_AGENT_EVENTO VARCHAR2(500 CHAR),
    CONSTRAINT PK_CA_REG_HIST PRIMARY KEY (ID),
    CONSTRAINT FK_CA_REG_HIST_REG FOREIGN KEY (REGISTRO_ID) REFERENCES CA_REGISTRO_ELEICAO (ID) ON DELETE CASCADE,
    CONSTRAINT FK_CA_REG_HIST_ANT FOREIGN KEY (STATUS_ANTERIOR) REFERENCES CA_REGISTRO_STATUS (CODIGO),
    CONSTRAINT FK_CA_REG_HIST_NOVO FOREIGN KEY (STATUS_NOVO) REFERENCES CA_REGISTRO_STATUS (CODIGO)
)
SQL);
        DB::statement('CREATE INDEX IX_CA_REG_HIST_REG ON CA_REGISTRO_HISTORICO (REGISTRO_ID, DT_EVENTO)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE CA_REGISTRO_HISTORICO');
        DB::statement('DROP TABLE CA_REGISTRO_OCORRENCIA');
        DB::statement('DROP TABLE CA_REGISTRO_ATENDIMENTO');
        DB::statement('DROP TABLE CA_REGISTRO_ELEICAO');
    }
};
```
</DATABASE_MIGRATIONS_2026_09_11_121000_CREATE_CA_REGISTRO_ELEICAO_TABLES_PHP>

