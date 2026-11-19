# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_config`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 11  
> **Tamanho do Arquivo:** 108 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `config/app.php`
## <CONFIG_APP_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/app.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Application Name
    |--------------------------------------------------------------------------
    |
    | This value is the name of your application, which will be used when the
    | framework needs to place the application's name in a notification or
    | other UI elements where an application name needs to be displayed.
    |
    */

    'name' => env('APP_NAME', 'Laravel'),

    /*
    |--------------------------------------------------------------------------
    | Application Environment
    |--------------------------------------------------------------------------
    |
    | This value determines the "environment" your application is currently
    | running in. This may determine how you prefer to configure various
    | services the application utilizes. Set this in your ".env" file.
    |
    */

    'env' => env('APP_ENV', 'production'),

    /*
    |--------------------------------------------------------------------------
    | Application Debug Mode
    |--------------------------------------------------------------------------
    |
    | When your application is in debug mode, detailed error messages with
    | stack traces will be shown on every error that occurs within your
    | application. If disabled, a simple generic error page is shown.
    |
    */

    'debug' => (bool) env('APP_DEBUG', false),

    /*
    |--------------------------------------------------------------------------
    | Application URL
    |--------------------------------------------------------------------------
    |
    | This URL is used by the console to properly generate URLs when using
    | the Artisan command line tool. You should set this to the root of
    | the application so that it's available within Artisan commands.
    |
    */

    'url' => env('APP_URL', 'http://localhost'),

    /*
    |--------------------------------------------------------------------------
    | Application Timezone
    |--------------------------------------------------------------------------
    |
    | Here you may specify the default timezone for your application, which
    | will be used by the PHP date and date-time functions. The timezone
    | is set to "UTC" by default as it is suitable for most use cases.
    |
    */

    'timezone' => 'America/Rio_Branco',

    /*
    |--------------------------------------------------------------------------
    | Application Locale Configuration
    |--------------------------------------------------------------------------
    |
    | The application locale determines the default locale that will be used
    | by Laravel's translation / localization methods. This option can be
    | set to any locale for which you plan to have translation strings.
    |
    */

    'locale' => env('APP_LOCALE', 'en'),

    'fallback_locale' => env('APP_FALLBACK_LOCALE', 'en'),

    'faker_locale' => env('APP_FAKER_LOCALE', 'en_US'),

    /*
    |--------------------------------------------------------------------------
    | Encryption Key
    |--------------------------------------------------------------------------
    |
    | This key is utilized by Laravel's encryption services and should be set
    | to a random, 32 character string to ensure that all encrypted values
    | are secure. You should do this prior to deploying the application.
    |
    */

    'cipher' => 'AES-256-CBC',

    'key' => env('APP_KEY'),

    'previous_keys' => [
        ...array_filter(
            explode(',', (string) env('APP_PREVIOUS_KEYS', ''))
        ),
    ],

    /*
    |--------------------------------------------------------------------------
    | Maintenance Mode Driver
    |--------------------------------------------------------------------------
    |
    | These configuration options determine the driver used to determine and
    | manage Laravel's "maintenance mode" status. The "cache" driver will
    | allow maintenance mode to be controlled across multiple machines.
    |
    | Supported drivers: "file", "cache"
    |
    */

    'maintenance' => [
        'driver' => env('APP_MAINTENANCE_DRIVER', 'file'),
        'store' => env('APP_MAINTENANCE_STORE', 'database'),
    ],

];
```
</CONFIG_APP_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/cache.php`
## <CONFIG_CACHE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/cache.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Support\Str;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Cache Store
    |--------------------------------------------------------------------------
    |
    | This option controls the default cache store that will be used by the
    | framework. This connection is utilized if another isn't explicitly
    | specified when running a cache operation inside the application.
    |
    */

    'default' => env('CACHE_STORE', 'database'),

    /*
    |--------------------------------------------------------------------------
    | Cache Stores
    |--------------------------------------------------------------------------
    |
    | Here you may define all of the cache "stores" for your application as
    | well as their drivers. You may even define multiple stores for the
    | same cache driver to group types of items stored in your caches.
    |
    | Supported drivers: "array", "database", "file", "memcached",
    |                    "redis", "dynamodb", "octane",
    |                    "failover", "null"
    |
    */

    'stores' => [

        'array' => [
            'driver' => 'array',
            'serialize' => false,
        ],

        'database' => [
            'driver' => 'database',
            'connection' => env('DB_CACHE_CONNECTION'),
            'table' => env('DB_CACHE_TABLE', 'cache'),
            'lock_connection' => env('DB_CACHE_LOCK_CONNECTION'),
            'lock_table' => env('DB_CACHE_LOCK_TABLE'),
        ],

        'file' => [
            'driver' => 'file',
            'path' => storage_path('framework/cache/data'),
            'lock_path' => storage_path('framework/cache/data'),
        ],

        'memcached' => [
            'driver' => 'memcached',
            'persistent_id' => env('MEMCACHED_PERSISTENT_ID'),
            'sasl' => [
                env('MEMCACHED_USERNAME'),
                env('MEMCACHED_PASSWORD'),
            ],
            'options' => [
                // Memcached::OPT_CONNECT_TIMEOUT => 2000,
            ],
            'servers' => [
                [
                    'host' => env('MEMCACHED_HOST', '127.0.0.1'),
                    'port' => env('MEMCACHED_PORT', 11211),
                    'weight' => 100,
                ],
            ],
        ],

        'redis' => [
            'driver' => 'redis',
            'connection' => env('REDIS_CACHE_CONNECTION', 'cache'),
            'lock_connection' => env('REDIS_CACHE_LOCK_CONNECTION', 'default'),
        ],

        'dynamodb' => [
            'driver' => 'dynamodb',
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
            'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
            'table' => env('DYNAMODB_CACHE_TABLE', 'cache'),
            'endpoint' => env('DYNAMODB_ENDPOINT'),
        ],

        'octane' => [
            'driver' => 'octane',
        ],

        'failover' => [
            'driver' => 'failover',
            'stores' => [
                'database',
                'array',
            ],
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Cache Key Prefix
    |--------------------------------------------------------------------------
    |
    | When utilizing the APC, database, memcached, Redis, and DynamoDB cache
    | stores, there might be other applications using the same cache. For
    | that reason, you may prefix every cache key to avoid collisions.
    |
    */

    'prefix' => env('CACHE_PREFIX', Str::slug((string) env('APP_NAME', 'laravel')).'-cache-'),

];
```
</CONFIG_CACHE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/database.php`
## <CONFIG_DATABASE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/database.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Support\Str;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Database Connection Name
    |--------------------------------------------------------------------------
    |
    | Here you may specify which of the database connections below you wish
    | to use as your default connection for database operations. This is
    | the connection which will be utilized unless another connection
    | is explicitly specified when you execute a query / statement.
    |
    */

    'default' => env('DB_CONNECTION', 'sqlite'),

    /*
    |--------------------------------------------------------------------------
    | Database Connections
    |--------------------------------------------------------------------------
    |
    | Below are all of the database connections defined for your application.
    | An example configuration is provided for each database system which
    | is supported by Laravel. You're free to add / remove connections.
    |
    */

    'connections' => [

        'sqlite' => [
            'driver' => 'sqlite',
            'url' => env('DB_URL'),
            'database' => env('DB_DATABASE', database_path('database.sqlite')),
            'prefix' => '',
            'foreign_key_constraints' => env('DB_FOREIGN_KEYS', true),
            'busy_timeout' => null,
            'journal_mode' => null,
            'synchronous' => null,
            'transaction_mode' => 'DEFERRED',
        ],

        'mysql' => [
            'driver' => 'mysql',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '3306'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'unix_socket' => env('DB_SOCKET', ''),
            'charset' => env('DB_CHARSET', 'utf8mb4'),
            'collation' => env('DB_COLLATION', 'utf8mb4_unicode_ci'),
            'prefix' => '',
            'prefix_indexes' => true,
            'strict' => true,
            'engine' => null,
            'options' => extension_loaded('pdo_mysql') ? array_filter([
                PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
            ]) : [],
        ],
'oracle' => [
    'driver'   => 'oracle',
    'host'     => env('DB_HOST', '127.0.0.1'),
    'port'     => env('DB_PORT', '1521'),
    'database' => env('DB_SERVICE', 'adm'),
    'username' => env('DB_USERNAME', 'planeleito'),
    'password' => env('DB_PASSWORD', ''),
    'charset'  => 'AL32UTF8',
    'prefix'   => '',
],

        'mariadb' => [
            'driver' => 'mariadb',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '3306'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'unix_socket' => env('DB_SOCKET', ''),
            'charset' => env('DB_CHARSET', 'utf8mb4'),
            'collation' => env('DB_COLLATION', 'utf8mb4_unicode_ci'),
            'prefix' => '',
            'prefix_indexes' => true,
            'strict' => true,
            'engine' => null,
            'options' => extension_loaded('pdo_mysql') ? array_filter([
                PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
            ]) : [],
        ],

        'pgsql' => [
            'driver' => 'pgsql',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '5432'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'charset' => env('DB_CHARSET', 'utf8'),
            'prefix' => '',
            'prefix_indexes' => true,
            'search_path' => 'public',
            'sslmode' => 'prefer',
        ],
        'rcand_pje' => [
            'driver' => 'pgsql',
            'url' => env('DB_URL_PG'),
            'host' => env('DB_HOST_PG', '10.24.2.13'),
            'port' => env('DB_PORT_PG', '5432'),
            'database' => env('DB_BANCO_PG', 'pje'),
            'username' => env('DB_USERNAME_PG'),
            'password' => env('DB_PASSWORD_PG'),
            'charset' => env('DB_CHARSET_PG', 'utf8'),
            'prefix' => '',
            'prefix_indexes' => true,
            'search_path' => 'public',
            'sslmode' => env('DB_SSLMODE_PG', 'prefer'),
        ],

        'sqlsrv' => [
            'driver' => 'sqlsrv',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', 'localhost'),
            'port' => env('DB_PORT', '1433'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'charset' => env('DB_CHARSET', 'utf8'),
            'prefix' => '',
            'prefix_indexes' => true,
            // 'encrypt' => env('DB_ENCRYPT', 'yes'),
            // 'trust_server_certificate' => env('DB_TRUST_SERVER_CERTIFICATE', 'false'),
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Migration Repository Table
    |--------------------------------------------------------------------------
    |
    | This table keeps track of all the migrations that have already run for
    | your application. Using this information, we can determine which of
    | the migrations on disk haven't actually been run on the database.
    |
    */

    'migrations' => [
        'table' => 'migrations',
        'update_date_on_publish' => true,
    ],

    /*
    |--------------------------------------------------------------------------
    | Redis Databases
    |--------------------------------------------------------------------------
    |
    | Redis is an open source, fast, and advanced key-value store that also
    | provides a richer body of commands than a typical key-value system
    | such as Memcached. You may define your connection settings here.
    |
    */

    'redis' => [

        'client' => env('REDIS_CLIENT', 'phpredis'),

        'options' => [
            'cluster' => env('REDIS_CLUSTER', 'redis'),
            'prefix' => env('REDIS_PREFIX', Str::slug((string) env('APP_NAME', 'laravel')).'-database-'),
            'persistent' => env('REDIS_PERSISTENT', false),
        ],

        'default' => [
            'url' => env('REDIS_URL'),
            'host' => env('REDIS_HOST', '127.0.0.1'),
            'username' => env('REDIS_USERNAME'),
            'password' => env('REDIS_PASSWORD'),
            'port' => env('REDIS_PORT', '6379'),
            'database' => env('REDIS_DB', '0'),
            'max_retries' => env('REDIS_MAX_RETRIES', 3),
            'backoff_algorithm' => env('REDIS_BACKOFF_ALGORITHM', 'decorrelated_jitter'),
            'backoff_base' => env('REDIS_BACKOFF_BASE', 100),
            'backoff_cap' => env('REDIS_BACKOFF_CAP', 1000),
        ],

        'cache' => [
            'url' => env('REDIS_URL'),
            'host' => env('REDIS_HOST', '127.0.0.1'),
            'username' => env('REDIS_USERNAME'),
            'password' => env('REDIS_PASSWORD'),
            'port' => env('REDIS_PORT', '6379'),
            'database' => env('REDIS_CACHE_DB', '1'),
            'max_retries' => env('REDIS_MAX_RETRIES', 3),
            'backoff_algorithm' => env('REDIS_BACKOFF_ALGORITHM', 'decorrelated_jitter'),
            'backoff_base' => env('REDIS_BACKOFF_BASE', 100),
            'backoff_cap' => env('REDIS_BACKOFF_CAP', 1000),
        ],

    ],

];
```
</CONFIG_DATABASE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/filesystems.php`
## <CONFIG_FILESYSTEMS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/filesystems.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Default Filesystem Disk
    |--------------------------------------------------------------------------
    |
    | Here you may specify the default filesystem disk that should be used
    | by the framework. The "local" disk, as well as a variety of cloud
    | based disks are available to your application for file storage.
    |
    */

    'default' => env('FILESYSTEM_DISK', 'local'),

    /*
    |--------------------------------------------------------------------------
    | Filesystem Disks
    |--------------------------------------------------------------------------
    |
    | Below you may configure as many filesystem disks as necessary, and you
    | may even configure multiple disks for the same driver. Examples for
    | most supported storage drivers are configured here for reference.
    |
    | Supported drivers: "local", "ftp", "sftp", "s3"
    |
    */

    'disks' => [

        'local' => [
            'driver' => 'local',
            'root' => storage_path('app/private'),
            'serve' => true,
            'throw' => false,
            'report' => false,
        ],

        'public' => [
            'driver' => 'local',
            'root' => storage_path('app/public'),
            'url' => env('APP_URL').'/storage',
            'visibility' => 'public',
            'throw' => false,
            'report' => false,
        ],

        's3' => [
            'driver' => 's3',
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
            'region' => env('AWS_DEFAULT_REGION'),
            'bucket' => env('AWS_BUCKET'),
            'url' => env('AWS_URL'),
            'endpoint' => env('AWS_ENDPOINT'),
            'use_path_style_endpoint' => env('AWS_USE_PATH_STYLE_ENDPOINT', false),
            'throw' => false,
            'report' => false,
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Symbolic Links
    |--------------------------------------------------------------------------
    |
    | Here you may configure the symbolic links that will be created when the
    | `storage:link` Artisan command is executed. The array keys should be
    | the locations of the links and the values should be their targets.
    |
    */

    'links' => [
        public_path('storage') => storage_path('app/public'),
    ],

];
```
</CONFIG_FILESYSTEMS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/logging.php`
## <CONFIG_LOGGING_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/logging.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Monolog\Handler\NullHandler;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\SyslogUdpHandler;
use Monolog\Processor\PsrLogMessageProcessor;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Log Channel
    |--------------------------------------------------------------------------
    |
    | This option defines the default log channel that is utilized to write
    | messages to your logs. The value provided here should match one of
    | the channels present in the list of "channels" configured below.
    |
    */

    'default' => env('LOG_CHANNEL', 'stack'),

    /*
    |--------------------------------------------------------------------------
    | Deprecations Log Channel
    |--------------------------------------------------------------------------
    |
    | This option controls the log channel that should be used to log warnings
    | regarding deprecated PHP and library features. This allows you to get
    | your application ready for upcoming major versions of dependencies.
    |
    */

    'deprecations' => [
        'channel' => env('LOG_DEPRECATIONS_CHANNEL', 'null'),
        'trace' => env('LOG_DEPRECATIONS_TRACE', false),
    ],

    /*
    |--------------------------------------------------------------------------
    | Log Channels
    |--------------------------------------------------------------------------
    |
    | Here you may configure the log channels for your application. Laravel
    | utilizes the Monolog PHP logging library, which includes a variety
    | of powerful log handlers and formatters that you're free to use.
    |
    | Available drivers: "single", "daily", "slack", "syslog",
    |                    "errorlog", "monolog", "custom", "stack"
    |
    */

    'channels' => [

        'stack' => [
            'driver' => 'stack',
            'channels' => explode(',', (string) env('LOG_STACK', 'daily')),
            'ignore_exceptions' => false,
        ],

        'single' => [
            'driver' => 'single',
            'path' => storage_path('logs/laravel.log'),
            'level' => env('LOG_LEVEL', 'debug'),
            'replace_placeholders' => true,
        ],

        'daily' => [
            'driver' => 'daily',
            'path' => storage_path('logs/laravel.log'),
            'level' => env('LOG_LEVEL', 'debug'),
            'days' => (int) env('LOG_DAILY_DAYS', 30),
            'replace_placeholders' => true,
        ],

        'slack' => [
            'driver' => 'slack',
            'url' => env('LOG_SLACK_WEBHOOK_URL'),
            'username' => env('LOG_SLACK_USERNAME', 'Laravel Log'),
            'emoji' => env('LOG_SLACK_EMOJI', ':boom:'),
            'level' => env('LOG_LEVEL', 'critical'),
            'replace_placeholders' => true,
        ],

        'papertrail' => [
            'driver' => 'monolog',
            'level' => env('LOG_LEVEL', 'debug'),
            'handler' => env('LOG_PAPERTRAIL_HANDLER', SyslogUdpHandler::class),
            'handler_with' => [
                'host' => env('PAPERTRAIL_URL'),
                'port' => env('PAPERTRAIL_PORT'),
                'connectionString' => 'tls://'.env('PAPERTRAIL_URL').':'.env('PAPERTRAIL_PORT'),
            ],
            'processors' => [PsrLogMessageProcessor::class],
        ],

        'stderr' => [
            'driver' => 'monolog',
            'level' => env('LOG_LEVEL', 'debug'),
            'handler' => StreamHandler::class,
            'handler_with' => [
                'stream' => 'php://stderr',
            ],
            'formatter' => env('LOG_STDERR_FORMATTER'),
            'processors' => [PsrLogMessageProcessor::class],
        ],

        'syslog' => [
            'driver' => 'syslog',
            'level' => env('LOG_LEVEL', 'debug'),
            'facility' => env('LOG_SYSLOG_FACILITY', LOG_USER),
            'replace_placeholders' => true,
        ],

        'errorlog' => [
            'driver' => 'errorlog',
            'level' => env('LOG_LEVEL', 'debug'),
            'replace_placeholders' => true,
        ],

        'null' => [
            'driver' => 'monolog',
            'handler' => NullHandler::class,
        ],

        'emergency' => [
            'path' => storage_path('logs/laravel.log'),
        ],

    ],

];
```
</CONFIG_LOGGING_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/mail.php`
## <CONFIG_MAIL_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/mail.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

$allowSelfSigned = filter_var(env('MAIL_STREAM_ALLOW_SELF_SIGNED', false), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
if ($allowSelfSigned === null) {
    $allowSelfSigned = false;
}

$verifyPeer = filter_var(env('MAIL_STREAM_VERIFY_PEER', true), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
if ($verifyPeer === null) {
    $verifyPeer = true;
}

$verifyPeerName = filter_var(env('MAIL_STREAM_VERIFY_PEER_NAME', true), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
if ($verifyPeerName === null) {
    $verifyPeerName = true;
}

$cryptoMethodEnv = env('MAIL_STREAM_CRYPTO_METHOD');
$cryptoMethod = $cryptoMethodEnv && defined($cryptoMethodEnv) ? constant($cryptoMethodEnv) : null;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Mailer
    |--------------------------------------------------------------------------
    |
    | This option controls the default mailer that is used to send all email
    | messages unless another mailer is explicitly specified when sending
    | the message. All additional mailers can be configured within the
    | "mailers" array. Examples of each type of mailer are provided.
    |
    */

    'default' => env('MAIL_MAILER', 'log'),

    /*
    |--------------------------------------------------------------------------
    | Mailer Configurations
    |--------------------------------------------------------------------------
    |
    | Here you may configure all of the mailers used by your application plus
    | their respective settings. Several examples have been configured for
    | you and you are free to add your own as your application requires.
    |
    | Laravel supports a variety of mail "transport" drivers that can be used
    | when delivering an email. You may specify which one you're using for
    | your mailers below. You may also add additional mailers if needed.
    |
    | Supported: "smtp", "sendmail", "mailgun", "ses", "ses-v2",
    |            "postmark", "resend", "log", "array",
    |            "failover", "roundrobin"
    |
    */

    'mailers' => [

        'smtp' => [
            'transport' => 'smtp',
            'scheme' => env('MAIL_SCHEME'),
            'url' => env('MAIL_URL'),
            'host' => env('MAIL_HOST', '127.0.0.1'),
            'port' => env('MAIL_PORT', 2525),
            'encryption' => env('MAIL_ENCRYPTION') ?: null,
            'username' => env('MAIL_USERNAME'),
            'password' => env('MAIL_PASSWORD'),
            'timeout' => null,
            'local_domain' => env('MAIL_EHLO_DOMAIN', parse_url((string) env('APP_URL', 'http://localhost'), PHP_URL_HOST)),
            'stream' => [
                'ssl' => array_filter([
                    'allow_self_signed' => $allowSelfSigned,
                    'verify_peer' => $verifyPeer,
                    'verify_peer_name' => $verifyPeerName,
                    'crypto_method' => $cryptoMethod,
                ], static function ($value) {
                    return !is_null($value);
                }),
            ],
        ],

        'ses' => [
            'transport' => 'ses',
        ],

        'postmark' => [
            'transport' => 'postmark',
            // 'message_stream_id' => env('POSTMARK_MESSAGE_STREAM_ID'),
            // 'client' => [
            //     'timeout' => 5,
            // ],
        ],

        'resend' => [
            'transport' => 'resend',
        ],

        'sendmail' => [
            'transport' => 'sendmail',
            'path' => env('MAIL_SENDMAIL_PATH', '/usr/sbin/sendmail -bs -i'),
        ],

        'log' => [
            'transport' => 'log',
            'channel' => env('MAIL_LOG_CHANNEL'),
        ],

        'array' => [
            'transport' => 'array',
        ],

        'failover' => [
            'transport' => 'failover',
            'mailers' => [
                'smtp',
                'log',
            ],
            'retry_after' => 60,
        ],

        'roundrobin' => [
            'transport' => 'roundrobin',
            'mailers' => [
                'ses',
                'postmark',
            ],
            'retry_after' => 60,
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Global "From" Address
    |--------------------------------------------------------------------------
    |
    | You may wish for all emails sent by your application to be sent from
    | the same address. Here you may specify a name and address that is
    | used globally for all emails that are sent by your application.
    |
    */

    'from' => [
        'address' => env('MAIL_FROM_ADDRESS', 'hello@example.com'),
        'name' => env('MAIL_FROM_NAME', 'Example'),
    ],

    'disable_auto_tls' => env('MAIL_DISABLE_AUTO_TLS', false),

];
```
</CONFIG_MAIL_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/planeleito.php`
## <CONFIG_PLANELEITO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/planeleito.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

$diariasSeiBaseUrl = rtrim((string) env('DIARIAS_SEI_BASE_URL', 'https://naosei.tre-ac.jus.br'), '/');
$diariasSeiVerifySsl = filter_var(env('DIARIAS_SEI_VERIFY_SSL', true), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
if ($diariasSeiVerifySsl === null) {
    $diariasSeiVerifySsl = true;
}

$seuVotoImportaRotasPublicas = [
    'seu-voto-importa.publico.identificacao',
    'seu-voto-importa.publico.identificar',
    'seu-voto-importa.publico.solicitacao.nova',
    'seu-voto-importa.publico.representante.identificar',
    'seu-voto-importa.publico.solicitacao.store',
    'seu-voto-importa.publico.solicitacao.sucesso',
    'seu-voto-importa.publico.acesso.form',
    'seu-voto-importa.publico.acesso.entrar',
    'seu-voto-importa.publico.acompanhamento',
    'seu-voto-importa.publico.logout',
];

$acessibilidadeEleitoralRotasPublicas = [
    'coordenador-acessibilidade.publico.index',
    'coordenador-acessibilidade.publico.acessar',
    'coordenador-acessibilidade.publico.logout',
    'coordenador-acessibilidade.publico.registro.edit',
    'coordenador-acessibilidade.publico.registro.update',
    'coordenador-acessibilidade.publico.registro.enviar',
    'coordenador-acessibilidade.publico.registro.reabrir',
    'coordenador-acessibilidade.publico.registro.sucesso',
];

return [
    'opcao_binaria' => [
        // Codigo logico estavel da opcao afirmativa do dominio binario (gatilho de campos dependentes).
        'codigo_afirmativo' => 'SIM',
    ],
    'auth' => [
        'admin_routes' => [
            'zonas.create',
            'zonas.store',
            'zonas.update',
            'zonas.edit',
            'municipios.update',
            'municipios.edit',
        ],
        'bypass_path_prefixes' => [
            'rotas-publicas/',
        ],
        'auth_bypass_routes' => [
            'home',
            'logout',
            'integracoes.zenvia.sms.webhook.receber',
            'integracoes.textbee.sms.webhook.receber',
            'tarefas.monitoramento.geral.publico',
            'cadastro-eleitoral.pesquisa-satisfacao.form',
            'cadastro-eleitoral.pesquisa-satisfacao.store',
            'cadastro-eleitoral.pesquisa-satisfacao.sucesso',
            'mesario.publico.acesso.form',
            'mesario.publico.acesso.validar',
            'mesario.publico.logout',
            'mesario.publico.ocorrencias.form',
            'mesario.publico.ocorrencias.store',
            'mesario.publico.ocorrencias.sucesso',
            'mesario.publico.situacao.form',
            'mesario.publico.situacao.store',
            'mesario.publico.situacao.mensagens',
            'mesario.publico.situacao.mensagens.enviar',
            'mesario.publico.situacao.monitoramento',
            ...$seuVotoImportaRotasPublicas,
            ...$acessibilidadeEleitoralRotasPublicas,
        ],
        'route_acl_bypass_routes' => [
            'home',
            'logout',
            'integracoes.zenvia.sms.webhook.receber',
            'integracoes.textbee.sms.webhook.receber',
            'tarefas.monitoramento.geral.publico',
            'cadastro-eleitoral.pesquisa-satisfacao.form',
            'cadastro-eleitoral.pesquisa-satisfacao.store',
            'cadastro-eleitoral.pesquisa-satisfacao.sucesso',
            'mesario.publico.acesso.form',
            'mesario.publico.acesso.validar',
            'mesario.publico.logout',
            'mesario.publico.ocorrencias.form',
            'mesario.publico.ocorrencias.store',
            'mesario.publico.ocorrencias.sucesso',
            'mesario.publico.situacao.form',
            'mesario.publico.situacao.store',
            'mesario.publico.situacao.mensagens',
            'mesario.publico.situacao.mensagens.enviar',
            'mesario.publico.situacao.monitoramento',
            'macroprojeto.contexto.selecionar',
            'macroprojeto.contexto.salvar',
            'macroprojeto.contexto.alternar',
            ...$seuVotoImportaRotasPublicas,
            ...$acessibilidadeEleitoralRotasPublicas,
        ],
        'macro_context_bypass_routes' => [
            'home',
            'logout',
            'integracoes.zenvia.sms.webhook.receber',
            'integracoes.textbee.sms.webhook.receber',
            'macroprojeto.contexto.selecionar',
            'macroprojeto.contexto.salvar',
            'macroprojeto.contexto.alternar',
            ...$seuVotoImportaRotasPublicas,
            ...$acessibilidadeEleitoralRotasPublicas,
        ],
        'macro_context_bypass_route_patterns' => array_values(array_filter([
            'tabelas-auxiliares.calendario-eleitoral.*',
            filter_var(env('PLANELEITO_DIARIAS_ENABLED', false), FILTER_VALIDATE_BOOLEAN) ? 'diarias.*' : null,
        ])),
        'turno_context_required_routes' => [
            'lda.form',
            'lda.store',
            'lda.update',
            'lda.locais-votacao.edit',
            'lda.locais-votacao.update',
            'lda.monitoramento-lda',
            'lda.monitoramento-lda.dados',
            'nat.lda.mensagens.garantir',
            'nat.rotas.vistorias.historico',
            'nat.rotas.vistorias.exportar-pdf',
            'nat.vistorias.dashboard.index',
            'nat.vistorias.dashboard.dados',
            'disque-eleicao.index',
            'disque-eleicao.store',
            'disque-eleicao.edit',
            'disque-eleicao.update',
            'disque-eleicao.destroy',
            'disque-eleicao.relatorios.index',
            'disque-eleicao.relatorios.pdf',
            'disque-eleicao.relatorios.xlsx',
            'colaboradores-eleitorais.convocacoes-sms.index',
            'colaboradores-eleitorais.convocacoes-sms.dashboard',
            'colaboradores-eleitorais.convocacoes-sms.dashboard.elegibilidade',
            'colaboradores-eleitorais.convocacoes-sms.destinatarios.pdf',
            'colaboradores-eleitorais.convocacoes-sms.envios.store',
            'colaboradores-eleitorais.convocacoes-sms.destinatarios.telefone.update',
            'colaboradores-eleitorais.convocacoes-sms.envios.reenviar',
            'colaboradores-eleitorais.convocacoes-sms.historico.index',
            'colaboradores-eleitorais.convocacoes-sms.historico.show',
            'colaboradores-eleitorais.convocacoes-sms.historico.pdf',
            'colaboradores-eleitorais.convocacoes-sms.modelos.index',
            'colaboradores-eleitorais.convocacoes-sms.modelos.store',
            'colaboradores-eleitorais.convocacoes-sms.modelos.update',
            'colaboradores-eleitorais.convocacoes-sms.modelos.pdf',
        ],
        'use_adm_macro_scope' => env('PLANELEITO_USE_ADM_MACRO_SCOPE', true),
        'authelia_logout_url' => env(
            'PLANELEITO_AUTHELIA_LOGOUT_URL',
            'https://authelia.tre-ac.jus.br/logout?rd='.rawurlencode(rtrim((string) env('APP_URL', 'http://localhost'), '/').'/')
        ),
    ],
    'seu_voto_importa' => [
        'turnstile' => [
            'site_key' => env('SEU_VOTO_IMPORTA_TURNSTILE_SITE_KEY'),
            'secret_key' => env('SEU_VOTO_IMPORTA_TURNSTILE_SECRET_KEY'),
            'hostname' => env('SEU_VOTO_IMPORTA_TURNSTILE_HOSTNAME', parse_url((string) env('APP_URL'), PHP_URL_HOST)),
            'timeout' => max(1, (int) env('SEU_VOTO_IMPORTA_TURNSTILE_TIMEOUT', 5)),
        ],
    ],
    'acessibilidade_eleitoral' => [
        'timezone' => 'America/Rio_Branco',
        'turnstile' => [
            'site_key' => env('ACESSIBILIDADE_ELEITORAL_TURNSTILE_SITE_KEY')
                ?: env('SEU_VOTO_IMPORTA_TURNSTILE_SITE_KEY'),
            'secret_key' => env('ACESSIBILIDADE_ELEITORAL_TURNSTILE_SECRET_KEY')
                ?: env('SEU_VOTO_IMPORTA_TURNSTILE_SECRET_KEY'),
            'hostname' => env('ACESSIBILIDADE_ELEITORAL_TURNSTILE_HOSTNAME')
                ?: env('SEU_VOTO_IMPORTA_TURNSTILE_HOSTNAME', parse_url((string) env('APP_URL'), PHP_URL_HOST)),
            'timeout' => max(1, (int) (env('ACESSIBILIDADE_ELEITORAL_TURNSTILE_TIMEOUT')
                ?: env('SEU_VOTO_IMPORTA_TURNSTILE_TIMEOUT', 5))),
        ],
    ],
    'sync' => [
        'local_votacao_dblink' => env('PLANELEITO_SYNC_LOCAL_VOTACAO_DBLINK', 'cad_tse'),
        'mrj_dblink' => env('PLANELEITO_SYNC_MRJ_DBLINK', 'cad_tse'),
        'bairro_dblink' => env('PLANELEITO_SYNC_BAIRRO_DBLINK', 'CAD_TSE.WORLD'),
        'convocacao_mesario_dblink' => env('PLANELEITO_SYNC_CONVOCACAO_MESARIO_DBLINK', 'cad_Tse'),
        'treinamento_tse_dblink' => env('PLANELEITO_SYNC_TREINAMENTO_TSE_DBLINK', 'cad_tse'),
        'treinamento_tse_macroprojeto_id' => (int) env('PLANELEITO_SYNC_TREINAMENTO_TSE_MACROPROJETO_ID', 1),
        'gel_dblink' => env('PLANELEITO_SYNC_GEL_DBLINK', 'cad_tse'),
        'gel_uf' => env('PLANELEITO_SYNC_GEL_UF', 'AC'),
        'gel_cd_uf' => (int) env('PLANELEITO_SYNC_GEL_CD_UF', 24),
        'rcand_pje_connection' => env('RCAND_PJE_CONNECTION', 'rcand_pje'),
        'rcand_cand_dblink' => env('RCAND_CAND_DBLINK', 'cand'),
        'rcand_eleicao_codigos' => env('RCAND_ELEICAO_CODIGOS', '6259'),
        'rcand_eleicao_codigo' => env('RCAND_ELEICAO_CODIGO', '6259'),
        'rcand_cand_context_schema' => env('RCAND_CAND_CONTEXT_SCHEMA', 'admcentral'),
        'rcand_uf' => env('RCAND_UF', 'AC'),
        'rcand_ano_eleicao' => env('RCAND_ANO_ELEICAO', '2026'),
        'rcand_sync_enabled' => filter_var(env('RCAND_SYNC_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'rcand_sync_daily_at' => env('RCAND_SYNC_DAILY_AT', '23:30'),
    ],
    'restore' => [
        'private_data_path' => env('RESTORE_PRIVATE_DATA_PATH'),
    ],
    'convocacao_sms' => [
        'sending_start' => env('PLANELEITO_SMS_SENDING_START', '07:00'),
        'sending_end' => env('PLANELEITO_SMS_SENDING_END', '18:00'),
    ],
    'sms_zenvia' => [
        'enabled' => filter_var(env('PLANELEITO_SMS_ZENVIA_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'worker_enabled' => filter_var(env('PLANELEITO_SMS_ZENVIA_WORKER_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'base_url' => env('PLANELEITO_SMS_ZENVIA_BASE_URL', 'https://api.zenvia.com'),
        'api_token' => env('PLANELEITO_SMS_ZENVIA_API_TOKEN'),
        'sender' => env('PLANELEITO_SMS_ZENVIA_SENDER'),
        'delivery_webhook_url' => env('PLANELEITO_SMS_ZENVIA_DELIVERY_WEBHOOK_URL'),
        'webhook_secret' => env('PLANELEITO_SMS_ZENVIA_WEBHOOK_SECRET'),
        'connect_timeout' => max(1, (int) env('PLANELEITO_SMS_ZENVIA_CONNECT_TIMEOUT', 3)),
        'timeout' => max(1, (int) env('PLANELEITO_SMS_ZENVIA_TIMEOUT', 8)),
        'processing_stale_minutes' => max(1, (int) env('PLANELEITO_SMS_ZENVIA_PROCESSING_STALE_MINUTES', 15)),
        'legacy_webhook_enabled' => filter_var(env('PLANELEITO_SMS_ZENVIA_LEGACY_WEBHOOK_ENABLED', true), FILTER_VALIDATE_BOOLEAN),
    ],
    'sms_textbee' => [
        'enabled' => filter_var(env('PLANELEITO_SMS_TEXTBEE_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'worker_enabled' => filter_var(env('PLANELEITO_SMS_TEXTBEE_WORKER_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'base_url' => env('PLANELEITO_SMS_TEXTBEE_BASE_URL', 'https://api.textbee.dev'),
        'api_key' => env('PLANELEITO_SMS_TEXTBEE_API_KEY'),
        'device_id' => env('PLANELEITO_SMS_TEXTBEE_DEVICE_ID'),
        'sim_subscription_id' => env('PLANELEITO_SMS_TEXTBEE_SIM_SUBSCRIPTION_ID'),
        'webhook_url' => env('PLANELEITO_SMS_TEXTBEE_WEBHOOK_URL'),
        'webhook_secret' => env('PLANELEITO_SMS_TEXTBEE_WEBHOOK_SECRET'),
        'sync_enabled' => filter_var(env('PLANELEITO_SMS_TEXTBEE_SYNC_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'sync_initial_from' => env('PLANELEITO_SMS_TEXTBEE_SYNC_INITIAL_FROM', '2026-08-16T00:00:00Z'),
        'connect_timeout' => max(1, (int) env('PLANELEITO_SMS_TEXTBEE_CONNECT_TIMEOUT', 3)),
        'timeout' => max(1, (int) env('PLANELEITO_SMS_TEXTBEE_TIMEOUT', 8)),
        'processing_stale_minutes' => max(1, (int) env('PLANELEITO_SMS_PROCESSING_STALE_MINUTES', 15)),
        'min_interval_seconds' => max(1, (int) env('PLANELEITO_SMS_TEXTBEE_MIN_INTERVAL_SECONDS', 15)),
        'seconds_per_segment' => max(1, (int) env('PLANELEITO_SMS_TEXTBEE_SECONDS_PER_SEGMENT', 3)),
        'limit_cooldown_seconds' => max(1, (int) env('PLANELEITO_SMS_TEXTBEE_LIMIT_COOLDOWN_SECONDS', 900)),
        'limit_max_attempts' => max(2, (int) env('PLANELEITO_SMS_TEXTBEE_LIMIT_MAX_ATTEMPTS', 2)),
    ],
    'diarias' => [
        'enabled' => filter_var(env('PLANELEITO_DIARIAS_ENABLED', false), FILTER_VALIDATE_BOOLEAN),
        'comprovante_temporario_ttl_minutos' => max(1, (int) env('DIARIAS_COMPROVANTE_TEMPORARIO_TTL_MINUTOS', 120)),
        'pessoa_api_url' => env('DIARIAS_PESSOA_API_URL'),
        'pessoa_api_token' => env('DIARIAS_PESSOA_API_TOKEN'),
        'pessoa_api_connect_timeout' => env('DIARIAS_PESSOA_API_CONNECT_TIMEOUT', 3),
        'pessoa_api_timeout' => env('DIARIAS_PESSOA_API_TIMEOUT', 5),
        'bcb_ptax_url' => env('DIARIAS_BCB_PTAX_URL', 'https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoMoedaPeriodo(moeda=@moeda,dataInicial=@dataInicial,dataFinalCotacao=@dataFinalCotacao)'),
        'bcb_ptax_timeout' => env('DIARIAS_BCB_PTAX_TIMEOUT', 5),
        'sei' => [
            'base_url' => $diariasSeiBaseUrl,
            'wsdl_url' => env('DIARIAS_SEI_WSDL_URL', $diariasSeiBaseUrl.'/sei/controlador_ws.php?servico=sei'),
            'sigla_sistema' => env('DIARIAS_SEI_SIGLA_SISTEMA'),
            'identificacao_servico' => env('DIARIAS_SEI_IDENTIFICACAO_SERVICO'),
            'id_unidade' => env('DIARIAS_SEI_ID_UNIDADE'),
            'id_tipo_procedimento' => env('DIARIAS_SEI_ID_TIPO_PROCEDIMENTO'),
            'assuntos' => env('DIARIAS_SEI_ASSUNTOS'),
            'assunto_codigo' => env('DIARIAS_SEI_ASSUNTO_CODIGO'),
            'assunto_descricao' => env('DIARIAS_SEI_ASSUNTO_DESCRICAO', 'Diárias'),
            'nivel_acesso' => env('DIARIAS_SEI_NIVEL_ACESSO', '0'),
            'id_hipotese_legal' => env('DIARIAS_SEI_ID_HIPOTESE_LEGAL'),
            'id_serie_resumo_solicitacao' => env('DIARIAS_SEI_ID_SERIE_RESUMO_SOLICITACAO'),
            'id_serie_comprovacao_viagem' => env('DIARIAS_SEI_ID_SERIE_COMPROVACAO_VIAGEM', '50159'),
            'id_serie_deferimento_unidade' => env('DIARIAS_SEI_ID_SERIE_DEFERIMENTO_UNIDADE', '291'),
            'id_serie_deferimento_dg' => env('DIARIAS_SEI_ID_SERIE_DEFERIMENTO_DG', '291'),
            'id_serie_deferimento_gapres' => env('DIARIAS_SEI_ID_SERIE_DEFERIMENTO_GAPRES', '291'),
            'id_serie_informacao_setran' => env('DIARIAS_SEI_ID_SERIE_INFORMACAO_SETRAN', '310'),
            'id_serie_anexo_reserva' => env('DIARIAS_SEI_ID_SERIE_ANEXO_RESERVA', '293'),
            'id_serie_calculo_fin' => env('DIARIAS_SEI_ID_SERIE_CALCULO_FIN', '550'),
            'id_serie_relatorio_financeiro' => env('DIARIAS_SEI_ID_SERIE_RELATORIO_FINANCEIRO', '348'),
            'id_serie_comprovante_pagamento' => env('DIARIAS_SEI_ID_SERIE_COMPROVANTE_PAGAMENTO', '330'),
            'id_tipo_conferencia_reserva' => env('DIARIAS_SEI_ID_TIPO_CONFERENCIA_RESERVA'),
            'id_tipo_conferencia_pagamento' => env('DIARIAS_SEI_ID_TIPO_CONFERENCIA_PAGAMENTO'),
            'pdf_max_kb' => (int) env('DIARIAS_SEI_PDF_MAX_KB', 10240),
            'resumo_nivel_acesso' => env('DIARIAS_SEI_RESUMO_NIVEL_ACESSO', env('DIARIAS_SEI_NIVEL_ACESSO', '0')),
            'resumo_id_hipotese_legal' => env('DIARIAS_SEI_RESUMO_ID_HIPOTESE_LEGAL'),
            'sin_manter_aberto_unidade' => env('DIARIAS_SEI_MANTER_ABERTO_UNIDADE', 'S'),
            'sin_enviar_email_notificacao' => env('DIARIAS_SEI_ENVIAR_EMAIL_NOTIFICACAO', 'N'),
            'unidades_envio' => env('DIARIAS_SEI_UNIDADES_ENVIO', ''),
            'timeout' => (int) env('DIARIAS_SEI_TIMEOUT', 15),
            'verify_ssl' => $diariasSeiVerifySsl,
        ],
        'siafi' => [
            'exportacao_habilitada' => filter_var(env('DIARIAS_SIAFI_EXPORTACAO_HABILITADA', false), FILTER_VALIDATE_BOOLEAN),
        ],
        'pessoas_mock' => [
            [
                'cpf' => '12345678901',
                'nome' => 'Ana Silva',
                'email' => 'ana.silva@tre-ac.jus.br',
                'lotacao' => 'FIN',
                'cargo' => 'Analista Judiciário',
                'funcao' => 'Servidor',
                'banco' => '001',
                'agencia' => '1234',
                'conta' => '12345-6',
            ],
            [
                'cpf' => '98765432100',
                'nome' => 'Bruno Souza',
                'email' => 'bruno.souza@tre-ac.jus.br',
                'lotacao' => 'SETRAN',
                'cargo' => 'Técnico Judiciário',
                'funcao' => 'Servidor',
                'banco' => '104',
                'agencia' => '4321',
                'conta' => '65432-1',
            ],
            [
                'cpf' => '11122233344',
                'nome' => 'Carla Nascimento',
                'email' => 'carla.nascimento@tre-ac.jus.br',
                'lotacao' => 'DG',
                'cargo' => 'Analista Judiciário',
                'funcao' => 'Gestora',
                'banco' => '341',
                'agencia' => '0001',
                'conta' => '99887-0',
            ],
        ],
    ],
];
```
</CONFIG_PLANELEITO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/planeleito_menu.php`
## <CONFIG_PLANELEITO_MENU_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/planeleito_menu.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

return [
    'planejamento' => [
        'label' => 'Planejamento',
        'sections' => [
            'cadastros' => [
                'label' => 'Cadastros',
                'items' => [
                    [
                        'label' => 'Projetos',
                        'route' => 'projetos.index',
                        'route_patterns' => ['projetos.*'],
                        'menu_path' => 'Planejamento > Cadastros > Projetos',
                    ],
                    [
                        'label' => 'Subprojetos',
                        'route' => 'subprojetos.index',
                        'route_patterns' => ['subprojetos.*'],
                        'menu_path' => 'Planejamento > Cadastros > Subprojetos',
                    ],
                    [
                        'label' => 'Atividades',
                        'route' => 'tarefas.index',
                        'route_patterns' => [
                            'tarefas.index',
                            'tarefas.listar',
                            'tarefas.form',
                            'tarefas.salvar',
                            'tarefas.iniciar.*',
                            'tarefas.finalizar.*',
                            'tarefas.andamentos*',
                            'tarefas.deletar',
                            'tarefas.unidades',
                            'tarefas.projetos',
                            'tarefas.subprojetos',
                            'tarefas.solicitacoes.prazo',
                            'tarefas.solicitacoes.prazo.salvar',
                            'tarefas.solicitacoes.prazo.aprovar',
                            'tarefas.solicitacoes.prazo.rejeitar',
                            'tarefas.kanban.iniciar',
                            'tarefas.kanban.reiniciar',
                            'tarefas.kanban.finalizar',
                            'tarefas.kanban.reabrir',
                        ],
                        'menu_path' => 'Planejamento > Cadastros > Atividades',
                    ],
                    [
                        'label' => 'Riscos',
                        'route' => 'riscos.index',
                        'route_patterns' => ['riscos.*'],
                        'menu_path' => 'Planejamento > Cadastros > Riscos',
                    ],
                ],
            ],
            'dashboards' => [
                'label' => 'Painéis',
                'items' => [
                    [
                        'label' => 'Cronograma',
                        'route' => 'tarefas.gantt',
                        'route_patterns' => ['tarefas.gantt'],
                        'menu_path' => 'Planejamento > Painéis > Cronograma',
                    ],
                    [
                        'label' => 'Quadro de Atividades',
                        'route' => 'tarefas.kanban',
                        'route_patterns' => ['tarefas.kanban'],
                        'menu_path' => 'Planejamento > Painéis > Quadro de Atividades',
                    ],
                    [
                        'label' => 'Monitoramento da Execução',
                        'route' => 'tarefas.monitoramento',
                        'route_patterns' => ['tarefas.monitoramento'],
                        'menu_path' => 'Planejamento > Painéis > Monitoramento da Execução',
                    ],
                    [
                        'label' => 'Monitoramento da Execução (Geral)',
                        'route' => 'tarefas.monitoramento.geral',
                        'route_patterns' => ['tarefas.monitoramento.geral'],
                        'menu_path' => 'Planejamento > Painéis > Monitoramento da Execução (Geral)',
                    ],
                ],
            ],
            'consulta' => [
                'label' => 'Consulta',
                'items' => [
                    [
                        'label' => 'Consulta Geral',
                        'route' => 'tarefas.consulta.index',
                        'route_patterns' => ['tarefas.consulta.*'],
                        'menu_path' => 'Planejamento > Consulta > Consulta Geral',
                    ],
                ],
            ],
            'administracao' => [
                'label' => 'Administração',
                'items' => [
                    [
                        'label' => 'Alertas de Atraso',
                        'route' => 'tarefas.alertas.index',
                        'route_patterns' => ['tarefas.alertas.*'],
                        'menu_path' => 'Planejamento > Administração > Alertas de Atraso',
                    ],
                    [
                        'label' => 'Categorias de Atividades',
                        'route' => 'categorias.index',
                        'route_patterns' => ['categorias.*'],
                        'menu_path' => 'Planejamento > Administração > Categorias de Atividades',
                    ],
                    [
                        'label' => 'Fases de Atividades',
                        'route' => 'fases.index',
                        'route_patterns' => ['fases.*'],
                        'menu_path' => 'Planejamento > Administração > Fases de Atividades',
                    ],
                    [
                        'label' => 'Grupos de Unidades',
                        'route' => 'grupos.index',
                        'route_patterns' => ['grupos.*'],
                        'menu_path' => 'Planejamento > Administração > Grupos de Unidades',
                    ],
                    [
                        'label' => 'Gerenciar Solicitações de Alteração',
                        'route' => 'tarefas.solicitacoes.prazo.painel',
                        'route_patterns' => ['tarefas.solicitacoes.prazo.painel'],
                        'menu_path' => 'Planejamento > Administração > Gerenciar Solicitações de Alteração',
                    ],
                ],
            ],
        ],
    ],
    'rcand' => [
        'label' => 'RCAND',
        'items' => [
            [
                'label' => 'Painel',
                'route' => 'rcand.index',
                'route_patterns' => ['rcand.*'],
                'menu_path' => 'RCAND > Painel',
            ],
        ],
    ],
    'fechamento_cadastro' => [
        'label' => 'Fechamento do Cadastro',
        'sections' => [
            'agendamento' => [
                'label' => 'Agendamento',
                'items' => [
                    [
                        'label' => 'Administração',
                        'route' => 'cadastro-eleitoral.agendamentos.admin.cadastros',
                        'route_patterns' => [
                            'cadastro-eleitoral.agendamentos.admin.index',
                            'cadastro-eleitoral.agendamentos.admin.cadastros',
                            'cadastro-eleitoral.agendamentos.admin.cadastros.*',
                            'cadastro-eleitoral.agendamentos.admin.funcionamento',
                            'cadastro-eleitoral.agendamentos.admin.funcionamento.*',
                            'cadastro-eleitoral.agendamentos.admin.slots',
                            'cadastro-eleitoral.agendamentos.admin.slots.*',
                            'cadastro-eleitoral.agendamentos.admin.monitoramento',
                            'cadastro-eleitoral.agendamentos.admin.monitoramento.*',
                            'cadastro-eleitoral.agendamentos.admin.agendamentos.*',
                            'cadastro-eleitoral.agendamentos.admin.unidades.*',
                            'cadastro-eleitoral.agendamentos.admin.guiches.*',
                            'cadastro-eleitoral.agendamentos.admin.servicos.*',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Agendamento > Administração',
                    ],
                    [
                        'label' => 'Agendamento',
                        'route' => 'cadastro-eleitoral.agendamentos.index',
                        'route_patterns' => [
                            'cadastro-eleitoral.agendamentos.index',
                            'cadastro-eleitoral.agendamentos.opcoes',
                            'cadastro-eleitoral.agendamentos.slots',
                            'cadastro-eleitoral.agendamentos.listar',
                            'cadastro-eleitoral.agendamentos.eleitor.*',
                            'cadastro-eleitoral.agendamentos.store',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Agendamento > Agendamento',
                    ],
                    [
                        'label' => 'Recepção',
                        'route' => 'cadastro-eleitoral.agendamentos.recepcao',
                        'route_patterns' => [
                            'cadastro-eleitoral.agendamentos.recepcao',
                            'cadastro-eleitoral.agendamentos.recepcao.*',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Agendamento > Recepção',
                    ],
                    [
                        'label' => 'Relatórios',
                        'route' => 'cadastro-eleitoral.agendamentos.relatorios',
                        'route_patterns' => [
                            'cadastro-eleitoral.agendamentos.relatorios',
                            'cadastro-eleitoral.agendamentos.relatorios.*',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Agendamento > Relatórios',
                    ],
                ],
            ],
            'filas' => [
                'label' => 'Filas',
                'items' => [
                    [
                        'label' => 'Triagem',
                        'route' => 'cadastro-eleitoral.filas.triagem',
                        'route_patterns' => [
                            'cadastro-eleitoral.filas.triagem',
                            'cadastro-eleitoral.filas.triagem.*',
                            'cadastro-eleitoral.filas.senhas.emitir',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Filas > Triagem',
                    ],
                    [
                        'label' => 'Atendimento',
                        'route' => 'cadastro-eleitoral.filas.atendimento',
                        'route_patterns' => [
                            'cadastro-eleitoral.filas.atendimento',
                            'cadastro-eleitoral.filas.atendimento.*',
                            'cadastro-eleitoral.filas.senhas.chamar-proxima',
                            'cadastro-eleitoral.filas.senhas.iniciar',
                            'cadastro-eleitoral.filas.senhas.finalizar',
                            'cadastro-eleitoral.filas.senhas.nao-compareceu',
                            'cadastro-eleitoral.filas.senhas.cancelar',
                            'cadastro-eleitoral.filas.senhas.reativar',
                            'cadastro-eleitoral.filas.senhas.transferir',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Filas > Atendimento',
                    ],
                    [
                        'label' => 'Monitoramento',
                        'route' => 'cadastro-eleitoral.filas.monitoramento',
                        'route_patterns' => [
                            'cadastro-eleitoral.filas.monitoramento',
                            'cadastro-eleitoral.filas.monitoramento.*',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Filas > Monitoramento',
                    ],
                    [
                        'label' => 'Painel',
                        'route' => 'cadastro-eleitoral.filas.painel.index',
                        'route_patterns' => [
                            'cadastro-eleitoral.filas.painel.index',
                            'cadastro-eleitoral.filas.painel.bootstrap',
                            'cadastro-eleitoral.filas.painel.eventos',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Filas > Painel',
                    ],
                    [
                        'label' => 'Administração',
                        'route' => 'cadastro-eleitoral.filas.admin.index',
                        'route_patterns' => [
                            'cadastro-eleitoral.filas.admin.index',
                            'cadastro-eleitoral.filas.admin.*',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Filas > Administração',
                    ],
                ],
            ],
            'vagas' => [
                'label' => 'Vagas',
                'items' => [
                    [
                        'label' => 'Vagas em Locais de Votação',
                        'route' => 'cadastro-eleitoral.vagas-locais',
                        'route_patterns' => ['cadastro-eleitoral.vagas-locais'],
                        'menu_path' => 'Fechamento do Cadastro > Vagas > Vagas em Locais de Votação',
                    ],
                    [
                        'label' => 'Dashboard',
                        'route' => 'cadastro-eleitoral.monitoramento-mapa.dashboard',
                        'route_patterns' => ['cadastro-eleitoral.monitoramento-mapa.dashboard*'],
                        'menu_path' => 'Fechamento do Cadastro > Vagas > Dashboard',
                    ],
                ],
            ],
            'pesquisa_satisfacao' => [
                'label' => 'Pesquisa de Satisfação',
                'items' => [
                    [
                        'label' => 'Responder Pesquisa',
                        'route' => 'cadastro-eleitoral.pesquisa-satisfacao.form',
                        'route_patterns' => [
                            'cadastro-eleitoral.pesquisa-satisfacao.form',
                            'cadastro-eleitoral.pesquisa-satisfacao.store',
                            'cadastro-eleitoral.pesquisa-satisfacao.sucesso',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Pesquisa de Satisfação > Responder Pesquisa',
                    ],
                    [
                        'label' => 'Resultados',
                        'route' => 'cadastro-eleitoral.pesquisa-satisfacao.admin.index',
                        'route_patterns' => [
                            'cadastro-eleitoral.pesquisa-satisfacao.admin.index',
                        ],
                        'menu_path' => 'Fechamento do Cadastro > Pesquisa de Satisfação > Resultados',
                    ],
                ],
            ],
        ],
    ],
    'colaboradores_eleitorais' => [
        'label' => 'Colaboradores Eleitorais',
        'sections' => [
            'internos' => [
                'label' => 'Colaboradores Internos',
                'items' => [
                    [
                        'label' => 'Administração',
                        'route' => 'colaboradores-eleitorais.administracao',
                        'route_patterns' => [
                            'colaboradores-eleitorais.administracao',
                            'colaboradores-eleitorais.administracao.*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Internos > Administração',
                    ],
                    [
                        'label' => 'Inscrições',
                        'route' => 'colaboradores-eleitorais.candidaturas',
                        'route_patterns' => [
                            'colaboradores-eleitorais.candidaturas',
                            'colaboradores-eleitorais.candidaturas.*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Internos > Inscrições',
                    ],
                    [
                        'label' => 'Deferimento',
                        'route' => 'colaboradores-eleitorais.deferimento',
                        'route_patterns' => [
                            'colaboradores-eleitorais.deferimento',
                            'colaboradores-eleitorais.deferimento.*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Internos > Deferimento',
                    ],
                    [
                        'label' => 'Relatórios',
                        'route' => 'colaboradores-eleitorais.relatorios',
                        'route_patterns' => ['colaboradores-eleitorais.relatorios'],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Internos > Relatórios',
                    ],
                ],
            ],
            'externos' => [
                'label' => 'Colaboradores Externos',
                'items' => [
                    [
                        'label' => 'Voluntários Externos',
                        'route' => 'colaboradores-eleitorais.externos.voluntarios',
                        'route_patterns' => [
                            'colaboradores-eleitorais.externos.voluntarios',
                            'colaboradores-eleitorais.externos.voluntarios.exportar',
                            'colaboradores-eleitorais.externos.voluntarios.pdf.*',
                            'colaboradores-eleitorais.externos.voluntarios.excluidos*',
                            'colaboradores-eleitorais.externos.voluntarios.excluir',
                            'colaboradores-eleitorais.externos.voluntarios.restaurar',
                            'colaboradores-eleitorais.externos.voluntarios.confirmar-email',
                            'colaboradores-eleitorais.externos.voluntarios.funcoes*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Voluntários Externos',
                    ],
                    [
                        'label' => 'Eventos',
                        'route' => 'colaboradores-eleitorais.externos.voluntarios.eventos.index',
                        'route_patterns' => [
                            'colaboradores-eleitorais.externos.voluntarios.eventos.*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Eventos',
                    ],
                    [
                        'label' => 'Voluntários Manuais',
                        'route' => 'colaboradores-eleitorais.externos.voluntarios-manuais.index',
                        'route_patterns' => [
                            'colaboradores-eleitorais.externos.voluntarios-manuais.*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Voluntários Manuais',
                    ],
                    [
                        'label' => 'Supervisores de Prédio Voluntários',
                        'route' => 'colaboradores-eleitorais.externos.supervisores-predio-voluntarios',
                        'route_patterns' => [
                            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Supervisores de Prédio Voluntários',
                    ],
                    [
                        'label' => 'Coordenadores de Acessibilidade',
                        'route' => 'colaboradores-eleitorais.externos.coordenadores-acessibilidade',
                        'route_patterns' => [
                            'colaboradores-eleitorais.externos.coordenadores-acessibilidade*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Coordenadores de Acessibilidade',
                    ],
                    [
                        'label' => 'Mesários Convocados',
                        'route' => 'colaboradores-eleitorais.externos.mesarios-convocados',
                        'route_patterns' => [
                            'colaboradores-eleitorais.externos.mesarios-convocados',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Mesários Convocados',
                    ],
                    [
                        'label' => 'Convocação por SMS',
                        'route' => 'colaboradores-eleitorais.convocacoes-sms.index',
                        'route_patterns' => [
                            'colaboradores-eleitorais.convocacoes-sms.*',
                        ],
                        'menu_path' => 'Colaboradores Eleitorais > Colaboradores Externos > Convocação por SMS',
                    ],
                ],
            ],
            'treinamentos' => [
                'label' => 'Treinamento de Mesários',
                'items' => [
                    [
                        'label' => 'Treinamento de Mesários',
                        'route' => 'treinamentos.index',
                        'route_patterns' => ['treinamentos.*'],
                        'menu_path' => 'Colaboradores Eleitorais > Treinamento de Mesários',
                    ],
                ],
            ],
        ],
    ],
    'registro_candidaturas' => [
        'label' => 'Registro de Inscrições',
        'url' => '#',
        'requires_wildcard' => true,
    ],
    'dia_e' => [
        'label' => 'Dia-E',
        'sections' => [
            'NAT' => [
                [
                    'label' => 'Ocorrências',
                    'route' => 'nat.ocorrencias.index',
                    'route_patterns' => ['nat.ocorrencias.*'],
                    'menu_path' => 'Dia-E > NAT > Ocorrências',
                ],
                [
                    'label' => 'Painel da Rota',
                    'route' => 'nat.rotas.index',
                    'route_patterns' => ['nat.rotas.*'],
                    'menu_path' => 'Dia-E > NAT > Painel da Rota',
                ],
                [
                    'label' => 'Dashboard das vistorias de instalação das urnas',
                    'route' => 'nat.vistorias.dashboard.index',
                    'route_patterns' => ['nat.vistorias.dashboard.*'],
                    'menu_path' => 'Dia-E > NAT > Dashboard das vistorias de instalação das urnas',
                ],
                [
                    'label' => 'Ocorrências por Rota',
                    'route' => 'nat.ocorrencias-por-rota.index',
                    'route_patterns' => ['nat.ocorrencias-por-rota.*', 'nat.lda.mensagens.*'],
                    'menu_path' => 'Dia-E > NAT > Ocorrências por Rota',
                ],
                [
                    'label' => 'Monitoramento',
                    'route' => 'nat.monitoramento.index',
                    'route_patterns' => ['nat.monitoramento.*'],
                    'menu_path' => 'Dia-E > NAT > Monitoramento',
                ],
            ],
        ],
        'items' => [
            [
                'label' => 'Disque Eleição',
                'route' => 'disque-eleicao.index',
                'route_patterns' => ['disque-eleicao.*'],
                'menu_path' => 'Dia-E > Disque Eleição',
            ],
        ],
    ],
    'diarias' => [
        'label' => 'Diárias',
        'sections' => [
            'operacional' => [
                'label' => 'Operacional',
                'items' => [
                    [
                        'label' => 'Solicitações',
                        'route' => 'diarias.solicitacoes.index',
                        'route_patterns' => [
                            'diarias.index',
                            'diarias.solicitacoes.*',
                            'diarias.cidades.*',
                            'diarias.pessoas.*',
                            'diarias.processos-sei.*',
                            'diarias.documentos-sei.*',
                        ],
                        'menu_path' => 'Diárias > Operacional > Solicitações',
                    ],
                    [
                        'label' => 'Aprovações',
                        'route' => 'diarias.aprovacoes.index',
                        'route_patterns' => ['diarias.aprovacoes.*'],
                        'menu_path' => 'Diárias > Operacional > Aprovações',
                    ],
                    [
                        'label' => 'SETRAN',
                        'route' => 'diarias.setran.index',
                        'route_patterns' => ['diarias.setran.*'],
                        'menu_path' => 'Diárias > Operacional > SETRAN',
                    ],
                    [
                        'label' => 'Pagamentos',
                        'route' => 'diarias.pagamentos.index',
                        'route_patterns' => ['diarias.pagamentos.*'],
                        'menu_path' => 'Diárias > Operacional > Pagamentos',
                    ],
                    [
                        'label' => 'Comprovações',
                        'route' => 'diarias.comprovacoes.index',
                        'route_patterns' => ['diarias.comprovacoes.*'],
                        'menu_path' => 'Diárias > Operacional > Comprovações',
                    ],
                ],
            ],
            'consulta' => [
                'label' => 'Consulta',
                'items' => [
                    [
                        'label' => 'Solicitações',
                        'route' => 'diarias.consulta-solicitacoes.index',
                        'route_patterns' => ['diarias.index', 'diarias.consulta-solicitacoes.*'],
                        'menu_path' => 'Diárias > Consulta > Solicitações',
                    ],
                    [
                        'label' => 'Relatórios',
                        'route' => 'diarias.relatorios.index',
                        'route_patterns' => ['diarias.relatorios.*'],
                        'menu_path' => 'Diárias > Consulta > Relatórios',
                    ],
                    [
                        'label' => 'Painéis',
                        'route' => 'diarias.paineis.index',
                        'route_patterns' => ['diarias.paineis.*'],
                        'menu_path' => 'Diárias > Consulta > Painéis',
                    ],
                ],
            ],
            'administracao' => [
                'label' => 'Administração',
                'items' => [
                    [
                        'label' => 'Parâmetros gerais',
                        'route' => 'diarias.parametros.index',
                        'route_patterns' => ['diarias.parametros.index', 'diarias.parametros.store', 'diarias.parametros.update', 'diarias.parametros.toggle', 'diarias.parametros.destroy'],
                        'menu_path' => 'Diárias > Administração > Parâmetros gerais',
                    ],
                    [
                        'label' => 'Valores de diária',
                        'route' => 'diarias.parametros.valores.index',
                        'route_patterns' => ['diarias.parametros.valores.*'],
                        'menu_path' => 'Diárias > Administração > Valores de diária',
                    ],
                    [
                        'label' => 'Modais',
                        'route' => 'diarias.parametros.modais.index',
                        'route_patterns' => ['diarias.parametros.modais.*'],
                        'menu_path' => 'Diárias > Administração > Modais',
                    ],
                    [
                        'label' => 'Transportes terrestres',
                        'route' => 'diarias.parametros.transportes-terrestres.index',
                        'route_patterns' => ['diarias.parametros.transportes-terrestres.*'],
                        'menu_path' => 'Diárias > Administração > Transportes terrestres',
                    ],
                    [
                        'label' => 'Veículos',
                        'route' => 'diarias.parametros.veiculos.index',
                        'route_patterns' => ['diarias.parametros.veiculos.*'],
                        'menu_path' => 'Diárias > Administração > Veículos',
                    ],
                    [
                        'label' => 'Motoristas',
                        'route' => 'diarias.parametros.motoristas.index',
                        'route_patterns' => ['diarias.parametros.motoristas.*'],
                        'menu_path' => 'Diárias > Administração > Motoristas',
                    ],
                    [
                        'label' => 'Grupos',
                        'route' => 'diarias.parametros.grupos.index',
                        'route_patterns' => ['diarias.parametros.grupos.*'],
                        'menu_path' => 'Diárias > Administração > Grupos',
                    ],
                    [
                        'label' => 'Unidades confirmadoras',
                        'route' => 'diarias.parametros.confirmadoras.index',
                        'route_patterns' => ['diarias.parametros.confirmadoras.*'],
                        'menu_path' => 'Diárias > Administração > Unidades confirmadoras',
                    ],
                    [
                        'label' => 'Distâncias',
                        'route' => 'diarias.parametros.distancias.index',
                        'route_patterns' => ['diarias.parametros.distancias.*'],
                        'menu_path' => 'Diárias > Administração > Distâncias',
                    ],
                ],
            ],
        ],
    ],
    'operacoes_eleitorais' => [
        'label' => 'Operações Eleitorais',
        'items' => [
            [
                'label' => 'Seu Voto Importa',
                'route' => 'seu-voto-importa.admin.index',
                'route_patterns' => ['seu-voto-importa.admin.*'],
                'menu_path' => 'Operações Eleitorais > Seu Voto Importa',
            ],
            [
                'label' => 'Acessibilidade',
                'route' => 'operacoes-eleitorais.acessibilidade.registros.index',
                'route_patterns' => ['operacoes-eleitorais.acessibilidade.*'],
                'menu_path' => 'Operações Eleitorais > Acessibilidade',
            ],
        ],
    ],
    'transmissao_dados' => [
        'label' => 'Transmissão de Dados',
        'sections' => [
            'LDA' => [
                [
                    'label' => 'Locais de Difícil Acesso',
                    'route' => 'lda.locais-dificil-acesso',
                    'route_patterns' => ['lda.locais-dificil-acesso', 'lda.form', 'lda.listar', 'lda.show', 'lda.store', 'lda.update', 'lda.destroy', 'lda.por-zona', 'lda.contar-bgan', 'lda.contar-bgan.zona', 'lda.contar-internet.zona', 'lda.resumo-energia', 'lda.resumoTransporte'],
                    'menu_path' => 'Transmissão de Dados > LDA > Locais de Difícil Acesso',
                ],
                [
                    'label' => 'Monitoramento - LDA',
                    'route' => 'lda.monitoramento-lda',
                    'route_patterns' => ['lda.monitoramento-lda'],
                    'menu_path' => 'Transmissão de Dados > LDA > Monitoramento - LDA',
                ],
                [
                    'label' => 'Mapa - LDA',
                    'route' => 'lda.mapa',
                    'route_patterns' => ['lda.mapa', 'lda.mapa.dados'],
                    'menu_path' => 'Transmissão de Dados > LDA > Mapa - LDA',
                ],
            ],
            'Geral' => [
                [
                    'label' => 'Monitoramento - Geral',
                    'route' => 'lda.monitoramento-geral',
                    'route_patterns' => ['lda.monitoramento-geral*'],
                    'menu_path' => 'Transmissão de Dados > Geral > Monitoramento - Geral',
                ],
                [
                    'label' => 'Mapa - Geral',
                    'route' => 'lda.monitoramento-mapa',
                    'route_patterns' => ['lda.monitoramento-mapa*'],
                    'menu_path' => 'Transmissão de Dados > Geral > Mapa - Geral',
                ],
                [
                    'label' => 'Cadastro de Locais de Transmissão',
                    'route' => 'lda.local-transmissao',
                    'route_patterns' => ['lda.local-transmissao*'],
                    'menu_path' => 'Transmissão de Dados > Geral > Cadastro de Locais de Transmissão',
                ],
                [
                    'label' => 'Vistorias de Transmissão',
                    'route' => 'lda.vistoria-transmissao',
                    'route_patterns' => ['lda.vistoria-transmissao*'],
                    'menu_path' => 'Transmissão de Dados > Geral > Vistorias de Transmissão',
                ],
            ],
            'Rotas' => [
                [
                    'label' => 'Cadastro de Rotas',
                    'route' => 'lda.rotas.index',
                    'route_patterns' => ['lda.rotas.index', 'lda.rotas.form', 'lda.rotas.store', 'lda.rotas.update', 'lda.rotas.destroy', 'lda.rotas.locais'],
                    'menu_path' => 'Transmissão de Dados > Rotas > Cadastro de Rotas',
                ],
            ],
            'Consolidação' => [
                [
                    'label' => 'Locais de votação x Transmissão',
                    'route' => 'lda.consolidacao.locais-transmissao',
                    'route_patterns' => ['lda.consolidacao.locais-transmissao*'],
                    'menu_path' => 'Transmissão de Dados > Consolidação > Locais de votação x Transmissão',
                ],
                [
                    'label' => 'Autogeração de Locais de Transmissão',
                    'route' => 'lda.consolidacao.autogeracao-transmissao',
                    'route_patterns' => ['lda.consolidacao.autogeracao-transmissao*'],
                    'menu_path' => 'Transmissão de Dados > Consolidação > Autogeração de Locais de Transmissão',
                ],
                [
                    'label' => 'Dashboard de distribuição de urnas',
                    'route' => 'lda.consolidacao.dashboard-locais-votacao',
                    'route_patterns' => ['lda.consolidacao.dashboard-locais-votacao*'],
                    'menu_path' => 'Transmissão de Dados > Consolidação > Dashboard de distribuição de urnas',
                ],
                [
                    'label' => 'Mapa de Locais de Votação',
                    'route' => 'lda.consolidacao.mapa-locais-votacao',
                    'route_patterns' => ['lda.consolidacao.mapa-locais-votacao'],
                    'menu_path' => 'Transmissão de Dados > Consolidação > Mapa de Locais de Votação',
                ],
                [
                    'label' => 'Cadastro de Locais de Votação',
                    'route' => 'lda.locais-votacao.index',
                    'route_patterns' => ['lda.locais-votacao.*'],
                    'menu_path' => 'Transmissão de Dados > Consolidação > Cadastro de Locais de Votação',
                ],
            ],
        ],
    ],
    'tabelas_auxiliares' => [
        'label' => 'Tabelas Auxiliares',
        'items' => [
            [
                'label' => 'Calendário Eleitoral',
                'route' => 'tabelas-auxiliares.calendario-eleitoral.eventos.index',
                'route_patterns' => ['tabelas-auxiliares.calendario-eleitoral.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Calendário Eleitoral',
            ],
            [
                'label' => 'Zonas',
                'route' => 'tabelas-auxiliares.zonas.index',
                'route_patterns' => ['tabelas-auxiliares.zonas.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Zonas',
            ],
            [
                'label' => 'Tipos de Internet',
                'route' => 'tabelas-auxiliares.internets.index',
                'route_patterns' => ['tabelas-auxiliares.internets.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipos de Internet',
            ],
            [
                'label' => 'Tipos de Energia',
                'route' => 'tabelas-auxiliares.energias.index',
                'route_patterns' => ['tabelas-auxiliares.energias.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipos de Energia',
            ],
            [
                'label' => 'Tipos de Acesso',
                'route' => 'tabelas-auxiliares.acessos.index',
                'route_patterns' => ['tabelas-auxiliares.acessos.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipos de Acesso',
            ],
            [
                'label' => 'Situações LDA',
                'route' => 'tabelas-auxiliares.lda-situacoes.index',
                'route_patterns' => ['tabelas-auxiliares.lda-situacoes.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Situações LDA',
            ],
            [
                'label' => 'Recursos logísticos LDA',
                'route' => 'tabelas-auxiliares.lda-recursos-logisticos.index',
                'route_patterns' => ['tabelas-auxiliares.lda-recursos-logisticos.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Recursos logísticos LDA',
            ],
            [
                'label' => 'Percentuais de urnas de contingência',
                'route' => 'tabelas-auxiliares.urnas-contingencia-urbana.index',
                'route_patterns' => ['tabelas-auxiliares.urnas-contingencia-urbana.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Percentuais de urnas de contingência',
            ],
            [
                'label' => 'Turnos por Macroprojeto',
                'route' => 'tabelas-auxiliares.macroprojeto-turnos.index',
                'route_patterns' => ['tabelas-auxiliares.macroprojeto-turnos.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Turnos por Macroprojeto',
            ],
            [
                'label' => 'Assuntos do Disque Eleição',
                'route' => 'tabelas-auxiliares.disque-eleicao-assuntos.index',
                'route_patterns' => ['tabelas-auxiliares.disque-eleicao-assuntos.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Assuntos do Disque Eleição',
            ],
            [
                'label' => 'Perguntas da vistoria NAT',
                'route' => 'tabelas-auxiliares.nat-vistoria-perguntas.index',
                'route_patterns' => ['tabelas-auxiliares.nat-vistoria-perguntas.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Perguntas da vistoria NAT',
            ],
            [
                'label' => 'Opção Binária',
                'route' => 'tabelas-auxiliares.opcoes-binarias.index',
                'route_patterns' => ['tabelas-auxiliares.opcoes-binarias.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Opção Binária',
            ],
            [
                'label' => 'Qualidade',
                'route' => 'tabelas-auxiliares.qualidades.index',
                'route_patterns' => ['tabelas-auxiliares.qualidades.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Qualidade',
            ],
            [
                'label' => 'Operadora',
                'route' => 'tabelas-auxiliares.operadoras.index',
                'route_patterns' => ['tabelas-auxiliares.operadoras.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Operadora',
            ],
            [
                'label' => 'Tipo de Sinal',
                'route' => 'tabelas-auxiliares.tipos-sinal.index',
                'route_patterns' => ['tabelas-auxiliares.tipos-sinal.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipo de Sinal',
            ],
            [
                'label' => 'Esfera',
                'route' => 'tabelas-auxiliares.esferas.index',
                'route_patterns' => ['tabelas-auxiliares.esferas.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Esfera',
            ],
            [
                'label' => 'Tipo de Tomada',
                'route' => 'tabelas-auxiliares.tipos-tomada.index',
                'route_patterns' => ['tabelas-auxiliares.tipos-tomada.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipo de Tomada',
            ],
            [
                'label' => 'Municípios',
                'route' => 'tabelas-auxiliares.municipios.index',
                'route_patterns' => ['tabelas-auxiliares.municipios.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Municípios',
            ],
            [
                'label' => 'Cargos da Equipe',
                'route' => 'tabelas-auxiliares.cargos-equipe.index',
                'route_patterns' => ['tabelas-auxiliares.cargos-equipe.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Cargos da Equipe',
            ],
            [
                'label' => 'Tipos de Ocorrência NAT',
                'route' => 'tabelas-auxiliares.nat-tipos-ocorrencia.index',
                'route_patterns' => ['tabelas-auxiliares.nat-tipos-ocorrencia.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipos de Ocorrência NAT',
            ],
            [
                'label' => 'Macroprojetos',
                'route' => 'macroprojetos.index',
                'route_patterns' => ['macroprojetos.*'],
                'menu_path' => 'Administração Global > Tabelas Auxiliares > Macroprojetos',
            ],
        ],
    ],
    'administracao_global' => [
        'label' => 'Administração Global',
        'items' => [
            [
                'label' => 'Auditoria do Sistema',
                'route' => 'planejamento.auditoria.index',
                'route_patterns' => ['planejamento.auditoria.*'],
                'menu_path' => 'Administração Global > Auditoria do Sistema',
            ],
            [
                'label' => 'Rotas Cadastradas',
                'route' => 'acesso-rotas.index',
                'route_patterns' => ['acesso-rotas.*'],
                'menu_path' => 'Administração Global > Rotas Cadastradas',
            ],
            [
                'label' => 'Permissões por Rota',
                'route' => 'acesso-rotas-grupos.index',
                'route_patterns' => ['acesso-rotas-grupos.*'],
                'menu_path' => 'Administração Global > Permissões por Rota',
            ],
            [
                'label' => 'Forças de Segurança',
                'route' => 'seguranca.admin.index',
                'route_patterns' => ['seguranca.admin.*'],
                'menu_path' => 'Administração Global > Acesso Externo > Forças de Segurança',
            ],
            [
                'label' => 'Sincronização de Banco de Dados',
                'route' => 'administracao-global.sync-local-votacao.index',
                'route_patterns' => ['administracao-global.sync-local-votacao.*', 'administracao-global.sync-rcand.*', 'administracao-global.sync-gel.*'],
                'menu_path' => 'Administração Global > Sincronização de Banco de Dados',
            ],
            [
                'label' => 'Sincronização SCDE',
                'route' => 'administracao-global.scde.index',
                'route_patterns' => ['administracao-global.scde.*'],
                'menu_path' => 'Administração Global > Sincronização SCDE',
            ],
        ],
    ],
];
```
</CONFIG_PLANELEITO_MENU_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/queue.php`
## <CONFIG_QUEUE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/queue.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Default Queue Connection Name
    |--------------------------------------------------------------------------
    |
    | Laravel's queue supports a variety of backends via a single, unified
    | API, giving you convenient access to each backend using identical
    | syntax for each. The default queue connection is defined below.
    |
    */

    'default' => env('QUEUE_CONNECTION', 'database'),

    /*
    |--------------------------------------------------------------------------
    | Queue Connections
    |--------------------------------------------------------------------------
    |
    | Here you may configure the connection options for every queue backend
    | used by your application. An example configuration is provided for
    | each backend supported by Laravel. You're also free to add more.
    |
    | Drivers: "sync", "database", "beanstalkd", "sqs", "redis",
    |          "deferred", "failover", "null"
    |
    */

    'connections' => [

        'sync' => [
            'driver' => 'sync',
        ],

        'database' => [
            'driver' => 'database',
            'connection' => env('DB_QUEUE_CONNECTION'),
            'table' => env('DB_QUEUE_TABLE', 'jobs'),
            'queue' => env('DB_QUEUE', 'default'),
            'retry_after' => (int) env('DB_QUEUE_RETRY_AFTER', 90),
            'after_commit' => false,
        ],

        'beanstalkd' => [
            'driver' => 'beanstalkd',
            'host' => env('BEANSTALKD_QUEUE_HOST', 'localhost'),
            'queue' => env('BEANSTALKD_QUEUE', 'default'),
            'retry_after' => (int) env('BEANSTALKD_QUEUE_RETRY_AFTER', 90),
            'block_for' => 0,
            'after_commit' => false,
        ],

        'sqs' => [
            'driver' => 'sqs',
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
            'prefix' => env('SQS_PREFIX', 'https://sqs.us-east-1.amazonaws.com/your-account-id'),
            'queue' => env('SQS_QUEUE', 'default'),
            'suffix' => env('SQS_SUFFIX'),
            'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
            'after_commit' => false,
        ],

        'redis' => [
            'driver' => 'redis',
            'connection' => env('REDIS_QUEUE_CONNECTION', 'default'),
            'queue' => env('REDIS_QUEUE', 'default'),
            'retry_after' => (int) env('REDIS_QUEUE_RETRY_AFTER', 90),
            'block_for' => null,
            'after_commit' => false,
        ],

        'deferred' => [
            'driver' => 'deferred',
        ],

        'failover' => [
            'driver' => 'failover',
            'connections' => [
                'database',
                'deferred',
            ],
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Job Batching
    |--------------------------------------------------------------------------
    |
    | The following options configure the database and table that store job
    | batching information. These options can be updated to any database
    | connection and table which has been defined by your application.
    |
    */

    'batching' => [
        'database' => env('DB_CONNECTION', 'sqlite'),
        'table' => 'job_batches',
    ],

    /*
    |--------------------------------------------------------------------------
    | Failed Queue Jobs
    |--------------------------------------------------------------------------
    |
    | These options configure the behavior of failed queue job logging so you
    | can control how and where failed jobs are stored. Laravel ships with
    | support for storing failed jobs in a simple file or in a database.
    |
    | Supported drivers: "database-uuids", "dynamodb", "file", "null"
    |
    */

    'failed' => [
        'driver' => env('QUEUE_FAILED_DRIVER', 'database-uuids'),
        'database' => env('DB_CONNECTION', 'sqlite'),
        'table' => 'failed_jobs',
    ],

];
```
</CONFIG_QUEUE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/services.php`
## <CONFIG_SERVICES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/services.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'resend' => [
        'key' => env('RESEND_KEY'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

    'api_pessoa' => [
        'token' => env('API_PESSOA_TOKEN'),
    ],

    'glpi' => [
        'base_url' => env('GLPI_BASE_URL'),
        'app_token' => env('GLPI_APP_TOKEN'),
        'user_token' => env('GLPI_USER_TOKEN'),
        'profile_id' => env('GLPI_PROFILE_ID'),
        'profile_name' => env('GLPI_PROFILE_NAME', 'Super-Admin'),
        'connect_timeout' => env('GLPI_CONNECT_TIMEOUT', 5),
        'timeout' => env('GLPI_TIMEOUT', 15),
    ],

    'jecmon' => [
        'base_url' => env('JECMON_BASE_URL', 'https://jecmon.tse.jus.br/painel-api'),
        'token_url' => env('JECMON_TOKEN_URL', 'https://sso-interno.tse.jus.br/realms/tse/protocol/openid-connect/token'),
        'client_id' => env('JECMON_CLIENT_ID'),
        'client_secret' => env('JECMON_CLIENT_SECRET'),
        'processo_eleitoral' => env('JECMON_PROCESSO_ELEITORAL'),
        'verify_tls' => env('JECMON_VERIFY_TLS', true),
        'connect_timeout' => env('JECMON_CONNECT_TIMEOUT', 5),
        'timeout' => env('JECMON_TIMEOUT', 15),
        'online_sync_enabled' => env('JECMON_KIT_ONLINE_SYNC_ENABLED', false),
    ],

    'scde' => [
        'base_url' => env('SCDE_BASE_URL'),
        'api_token' => env('SCDE_API_TOKEN'),
        'verify_tls' => env('SCDE_VERIFY_TLS', true),
        'connect_timeout' => env('SCDE_CONNECT_TIMEOUT', 5),
        'timeout' => env('SCDE_TIMEOUT', 30),
        'sync_enabled' => env('SCDE_SYNC_ENABLED', false),
    ],

];
```
</CONFIG_SERVICES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `config/session.php`
## <CONFIG_SESSION_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `config/session.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Support\Str;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Session Driver
    |--------------------------------------------------------------------------
    |
    | This option determines the default session driver that is utilized for
    | incoming requests. Laravel supports a variety of storage options to
    | persist session data. Database storage is a great default choice.
    |
    | Supported: "file", "cookie", "database", "memcached",
    |            "redis", "dynamodb", "array"
    |
    */

    'driver' => env('SESSION_DRIVER', 'database'),

    /*
    |--------------------------------------------------------------------------
    | Session Lifetime
    |--------------------------------------------------------------------------
    |
    | Here you may specify the number of minutes that you wish the session
    | to be allowed to remain idle before it expires. If you want them
    | to expire immediately when the browser is closed then you may
    | indicate that via the expire_on_close configuration option.
    |
    */

    'lifetime' => (int) env('SESSION_LIFETIME', 120),

    'expire_on_close' => env('SESSION_EXPIRE_ON_CLOSE', false),

    /*
    |--------------------------------------------------------------------------
    | Session Encryption
    |--------------------------------------------------------------------------
    |
    | This option allows you to easily specify that all of your session data
    | should be encrypted before it's stored. All encryption is performed
    | automatically by Laravel and you may use the session like normal.
    |
    */

    'encrypt' => env('SESSION_ENCRYPT', false),

    /*
    |--------------------------------------------------------------------------
    | Session File Location
    |--------------------------------------------------------------------------
    |
    | When utilizing the "file" session driver, the session files are placed
    | on disk. The default storage location is defined here; however, you
    | are free to provide another location where they should be stored.
    |
    */

    'files' => storage_path('framework/sessions'),

    /*
    |--------------------------------------------------------------------------
    | Session Database Connection
    |--------------------------------------------------------------------------
    |
    | When using the "database" or "redis" session drivers, you may specify a
    | connection that should be used to manage these sessions. This should
    | correspond to a connection in your database configuration options.
    |
    */

    'connection' => env('SESSION_CONNECTION'),

    /*
    |--------------------------------------------------------------------------
    | Session Database Table
    |--------------------------------------------------------------------------
    |
    | When using the "database" session driver, you may specify the table to
    | be used to store sessions. Of course, a sensible default is defined
    | for you; however, you're welcome to change this to another table.
    |
    */

    'table' => env('SESSION_TABLE', 'sessions'),

    /*
    |--------------------------------------------------------------------------
    | Session Cache Store
    |--------------------------------------------------------------------------
    |
    | When using one of the framework's cache driven session backends, you may
    | define the cache store which should be used to store the session data
    | between requests. This must match one of your defined cache stores.
    |
    | Affects: "dynamodb", "memcached", "redis"
    |
    */

    'store' => env('SESSION_STORE'),

    /*
    |--------------------------------------------------------------------------
    | Session Sweeping Lottery
    |--------------------------------------------------------------------------
    |
    | Some session drivers must manually sweep their storage location to get
    | rid of old sessions from storage. Here are the chances that it will
    | happen on a given request. By default, the odds are 2 out of 100.
    |
    */

    'lottery' => [2, 100],

    /*
    |--------------------------------------------------------------------------
    | Session Cookie Name
    |--------------------------------------------------------------------------
    |
    | Here you may change the name of the session cookie that is created by
    | the framework. Typically, you should not need to change this value
    | since doing so does not grant a meaningful security improvement.
    |
    */

    'cookie' => env(
        'SESSION_COOKIE',
        Str::slug((string) env('APP_NAME', 'laravel')).'-session'
    ),

    /*
    |--------------------------------------------------------------------------
    | Session Cookie Path
    |--------------------------------------------------------------------------
    |
    | The session cookie path determines the path for which the cookie will
    | be regarded as available. Typically, this will be the root path of
    | your application, but you're free to change this when necessary.
    |
    */

    'path' => env('SESSION_PATH', '/'),

    /*
    |--------------------------------------------------------------------------
    | Session Cookie Domain
    |--------------------------------------------------------------------------
    |
    | This value determines the domain and subdomains the session cookie is
    | available to. By default, the cookie will be available to the root
    | domain and all subdomains. Typically, this shouldn't be changed.
    |
    */

    'domain' => env('SESSION_DOMAIN'),

    /*
    |--------------------------------------------------------------------------
    | HTTPS Only Cookies
    |--------------------------------------------------------------------------
    |
    | By setting this option to true, session cookies will only be sent back
    | to the server if the browser has a HTTPS connection. This will keep
    | the cookie from being sent to you when it can't be done securely.
    |
    */

    'secure' => env('SESSION_SECURE_COOKIE'),

    /*
    |--------------------------------------------------------------------------
    | HTTP Access Only
    |--------------------------------------------------------------------------
    |
    | Setting this value to true will prevent JavaScript from accessing the
    | value of the cookie and the cookie will only be accessible through
    | the HTTP protocol. It's unlikely you should disable this option.
    |
    */

    'http_only' => env('SESSION_HTTP_ONLY', true),

    /*
    |--------------------------------------------------------------------------
    | Same-Site Cookies
    |--------------------------------------------------------------------------
    |
    | This option determines how your cookies behave when cross-site requests
    | take place, and can be used to mitigate CSRF attacks. By default, we
    | will set this value to "lax" to permit secure cross-site requests.
    |
    | See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#samesitesamesite-value
    |
    | Supported: "lax", "strict", "none", null
    |
    */

    'same_site' => env('SESSION_SAME_SITE', 'lax'),

    /*
    |--------------------------------------------------------------------------
    | Partitioned Cookies
    |--------------------------------------------------------------------------
    |
    | Setting this value to true will tie the cookie to the top-level site for
    | a cross-site context. Partitioned cookies are accepted by the browser
    | when flagged "secure" and the Same-Site attribute is set to "none".
    |
    */

    'partitioned' => env('SESSION_PARTITIONED_COOKIE', false),

];
```
</CONFIG_SESSION_PHP>

