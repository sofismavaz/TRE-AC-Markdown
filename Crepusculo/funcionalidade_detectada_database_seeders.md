# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_database_seeders`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 6  
> **Tamanho do Arquivo:** 12 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/DatabaseSeeder.php`
## <DATABASE_SEEDERS_DATABASESEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/DatabaseSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class DatabaseSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's reference data.
     */
    public function run(): void
    {
        $this->call([
            RestoreReferenceDataSeeder::class,
            DominioAuxiliarSeeder::class,
            CadastroEleitoralParametroSeeder::class,
            NatStatusOcorrenciaSeeder::class,
            LdaSituacaoOpcaoSeeder::class,
            LdaRecursoLogisticoOpcaoSeeder::class,
            DisqueEleicaoSeeder::class,
        ]);
    }
}
```
</DATABASE_SEEDERS_DATABASESEEDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/DominioAuxiliarSeeder.php`
## <DATABASE_SEEDERS_DOMINIOAUXILIARSEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/DominioAuxiliarSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class DominioAuxiliarSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$idExistente = DB::table($table)
DB::table($table)
DB::table($table)->insert($row + ['dt_criacao' => DB::raw('SYSDATE')]);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
private function seedDominio(string $table, array $rows): void
private function dominios(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DominioAuxiliarSeeder extends Seeder
{
    public function run(): void
    {
        foreach ($this->dominios() as $dominio) {
            $this->seedDominio($dominio['table'], $dominio['rows']);
        }
    }

    /**
     * @param array<int, array{codigo:string,descricao:string,ordem:int}> $rows
     */
    private function seedDominio(string $table, array $rows): void
    {
        foreach ($rows as $row) {
            $idExistente = DB::table($table)
                ->whereRaw('UPPER(codigo) = ?', [mb_strtoupper($row['codigo'], 'UTF-8')])
                ->value('id');

            if ($idExistente !== null) {
                DB::table($table)
                    ->where('id', $idExistente)
                    ->update([
                        'descricao' => $row['descricao'],
                        'ordem' => $row['ordem'],
                        'dt_atualizacao' => DB::raw('SYSDATE'),
                    ]);

                continue;
            }

            DB::table($table)->insert($row + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }

    /**
     * @return array<int, array{table:string,rows:array<int, array{codigo:string,descricao:string,ordem:int}>}>
     */
    private function dominios(): array
    {
        return [
            [
                'table' => 'opcao_binaria',
                'rows' => [
                    ['codigo' => 'SIM', 'descricao' => 'Sim', 'ordem' => 1],
                    ['codigo' => 'NAO', 'descricao' => 'Não', 'ordem' => 2],
                ],
            ],
            [
                'table' => 'qualidade',
                'rows' => [
                    ['codigo' => 'OTIMA', 'descricao' => 'Ótima', 'ordem' => 1],
                    ['codigo' => 'BOA', 'descricao' => 'Boa', 'ordem' => 2],
                    ['codigo' => 'REGULAR', 'descricao' => 'Regular', 'ordem' => 3],
                    ['codigo' => 'RUIM', 'descricao' => 'Ruim', 'ordem' => 4],
                    ['codigo' => 'INEXISTENTE', 'descricao' => 'Inexistente', 'ordem' => 5],
                ],
            ],
            [
                'table' => 'operadora',
                'rows' => [
                    ['codigo' => 'VIVO', 'descricao' => 'Vivo', 'ordem' => 1],
                    ['codigo' => 'CLARO', 'descricao' => 'Claro', 'ordem' => 2],
                    ['codigo' => 'TIM', 'descricao' => 'Tim', 'ordem' => 3],
                ],
            ],
            [
                'table' => 'tipo_sinal',
                'rows' => [
                    ['codigo' => '3G', 'descricao' => '3G', 'ordem' => 1],
                    ['codigo' => '4G', 'descricao' => '4G', 'ordem' => 2],
                    ['codigo' => '5G', 'descricao' => '5G', 'ordem' => 3],
                ],
            ],
            [
                'table' => 'tipo_tomada',
                'rows' => [
                    ['codigo' => '3PINOS_CHATOS', 'descricao' => '3 pinos chatos (padrão antigo)', 'ordem' => 1],
                    ['codigo' => '3PINOS_NBR', 'descricao' => '3 pinos (NBR)', 'ordem' => 2],
                    ['codigo' => '2PINOS_CHATOS', 'descricao' => '2 pinos chatos', 'ordem' => 3],
                    ['codigo' => '2PINOS_REDONDOS', 'descricao' => '2 pinos redondos', 'ordem' => 4],
                ],
            ],
            [
                'table' => 'esfera',
                'rows' => [
                    ['codigo' => 'FEDERAL', 'descricao' => 'Federal', 'ordem' => 1],
                    ['codigo' => 'ESTADUAL', 'descricao' => 'Estadual', 'ordem' => 2],
                    ['codigo' => 'MUNICIPAL', 'descricao' => 'Municipal', 'ordem' => 3],
                    ['codigo' => 'PARTICULAR', 'descricao' => 'Particular', 'ordem' => 4],
                ],
            ],
        ];
    }
}
```
</DATABASE_SEEDERS_DOMINIOAUXILIARSEEDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/NatStatusOcorrenciaSeeder.php`
## <DATABASE_SEEDERS_NATSTATUSOCORRENCIASEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/NatStatusOcorrenciaSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class NatStatusOcorrenciaSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$idExistente = DB::table('nat_status_ocorrencia')
DB::table('nat_status_ocorrencia')
DB::table('nat_status_ocorrencia')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class NatStatusOcorrenciaSeeder extends Seeder
{
    public function run(): void
    {
        $registros = [
            [
                'codigo' => 'ATRIBUIDA',
                'nome' => 'Atribuida',
                'ordem' => 1,
                'ativo' => 'S',
            ],
            [
                'codigo' => 'EM_ANDAMENTO',
                'nome' => 'Em andamento',
                'ordem' => 2,
                'ativo' => 'S',
            ],
            [
                'codigo' => 'FINALIZADA',
                'nome' => 'Finalizada',
                'ordem' => 3,
                'ativo' => 'S',
            ],
        ];

        foreach ($registros as $registro) {
            $idExistente = DB::table('nat_status_ocorrencia')
                ->whereRaw('UPPER(codigo) = ?', [mb_strtoupper($registro['codigo'], 'UTF-8')])
                ->value('id_status');

            if ($idExistente !== null) {
                DB::table('nat_status_ocorrencia')
                    ->where('id_status', $idExistente)
                    ->update([
                        'nome' => $registro['nome'],
                        'ordem' => $registro['ordem'],
                        'ativo' => $registro['ativo'],
                        'dt_atualizacao' => DB::raw('SYSDATE'),
                    ]);

                continue;
            }

            DB::table('nat_status_ocorrencia')->insert($registro + ['dt_criacao' => DB::raw('SYSDATE')]);
        }
    }
}
```
</DATABASE_SEEDERS_NATSTATUSOCORRENCIASEEDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/RestoreHomologacaoSeeder.php`
## <DATABASE_SEEDERS_RESTOREHOMOLOGACAOSEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/RestoreHomologacaoSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class RestoreHomologacaoSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class RestoreHomologacaoSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            DatabaseSeeder::class,
            RestorePrivateDataSeeder::class,
        ]);
    }
}
```
</DATABASE_SEEDERS_RESTOREHOMOLOGACAOSEEDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/RestorePrivateDataSeeder.php`
## <DATABASE_SEEDERS_RESTOREPRIVATEDATASEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/RestorePrivateDataSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class RestorePrivateDataSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use App\Support\DatabaseRestore\RestoreJsonTableLoader;
use Illuminate\Database\Seeder;

class RestorePrivateDataSeeder extends Seeder
{
    public function run(): void
    {
        (new RestoreJsonTableLoader())->loadPrivateTables();
    }
}
```
</DATABASE_SEEDERS_RESTOREPRIVATEDATASEEDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/RestoreReferenceDataSeeder.php`
## <DATABASE_SEEDERS_RESTOREREFERENCEDATASEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/RestoreReferenceDataSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class RestoreReferenceDataSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use App\Support\DatabaseRestore\RestoreJsonTableLoader;
use Illuminate\Database\Seeder;

class RestoreReferenceDataSeeder extends Seeder
{
    public function run(): void
    {
        (new RestoreJsonTableLoader())->loadReferenceTables();
    }
}
```
</DATABASE_SEEDERS_RESTOREREFERENCEDATASEEDER_PHP>

