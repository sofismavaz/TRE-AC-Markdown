# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_bootstrap`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 3 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `bootstrap/app.php`
## <BOOTSTRAP_APP_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `bootstrap/app.php`
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

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->validateCsrfTokens(except: [
            'rotas-publicas/integracoes/zenvia/sms/webhook',
            'rotas-publicas/integracoes/textbee/sms/webhook',
        ]);
        $middleware->appendToGroup('web', \App\Http\Middleware\ConfigureUserSession::class);
        $middleware->appendToGroup('web', \App\Http\Middleware\AuthorizeRouteAccess::class);
        $middleware->appendToGroup('web', \App\Http\Middleware\RequireMacroprojetoContext::class);
        $middleware->appendToGroup('web', \App\Http\Middleware\RequireMacroprojetoTurnoContext::class);
        $middleware->alias([
            'macroprojeto.contexto' => \App\Http\Middleware\RequireMacroprojetoContext::class,
            'nat.externo.auth' => \App\Http\Middleware\Nat\RequireNatExternalSession::class,
            'nat.externo.guest' => \App\Http\Middleware\Nat\RedirectIfNatExternalAuthenticated::class,
            'seguranca.externo.auth' => \App\Http\Middleware\ForcasSeguranca\RequireForcasSegurancaExternalSession::class,
            'seguranca.externo.guest' => \App\Http\Middleware\ForcasSeguranca\RedirectIfForcasSegurancaExternalAuthenticated::class,
            'mesario.publico.auth' => \App\Http\Middleware\MesarioPublico\RequireMesarioPublicSession::class,
            'mesario.publico.guest' => \App\Http\Middleware\MesarioPublico\RedirectIfMesarioPublicAuthenticated::class,
            'mesario.publico.ocorrencia' => \App\Http\Middleware\MesarioPublico\RedirectMesarioLdaParaSituacao::class,
            'mesario.publico.situacao' => \App\Http\Middleware\MesarioPublico\RequireMesarioLdaSituacao::class,
            'seu-voto-importa.publico.auth' => \App\Http\Middleware\SeuVotoImporta\RequireSeuVotoImportaPublicSession::class,
            'seu-voto-importa.headers' => \App\Http\Middleware\SeuVotoImporta\SeuVotoImportaSecurityHeaders::class,
            'acessibilidade.eleitoral.publico.auth' => \App\Http\Middleware\AcessibilidadeEleitoral\AcessibilidadeEleitoralRequirePublicSession::class,
            'acessibilidade.eleitoral.headers' => \App\Http\Middleware\AcessibilidadeEleitoral\AcessibilidadeEleitoralSecurityHeaders::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->render(function (\App\Exceptions\RegistroNaoEncontradoException $e) {
            abort(404, $e->getMessage());
        });
    })->create();
```
</BOOTSTRAP_APP_PHP>

