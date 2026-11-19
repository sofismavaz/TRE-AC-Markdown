# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_controllers`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 4 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Controller.php`
## <APP_HTTP_CONTROLLERS_CONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Controller.php`
- **Namespace Declaração:** `App\Http\Controllers`
- **Entidade / Classe:** `abstract class Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function autorizarAdmin(): void
protected function autorizarAdminMacroprojeto(?int $macroprojetoId = null): void
protected function autorizarRotaMacro(int $macroprojetoId): void
protected function macroprojetoAtivoIdSessao(): int
protected function macroprojetoAtivoTurnoSessao(): string
protected function macroprojetoAtivoTurnoIdSessao(): int
protected function zonasPermitidasSessao(): array
protected function acessoTodasZonasSessao(): bool
protected function usuarioSemAcessoZona(): bool
protected function escopoZonalSessao(): EscopoZonal
protected function usuarioTemAcessoRotaSessao(string $rotaNome): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers;

use App\Services\Planejamento\MacroprojetoPermissoes;
use App\Services\PermissaoDominioService;
use App\Support\Access\EscopoZonal;

abstract class Controller
{
    /**
     * Garante que apenas administradores executem ações sensíveis.
     */
    protected function autorizarAdmin(): void
    {
        if (session('is_admin') !== true) {
            abort(403, 'Operação permitida apenas para administradores!');
        }
    }

    protected function autorizarAdminMacroprojeto(?int $macroprojetoId = null): void
    {
        /** @var MacroprojetoPermissoes $permissoes */
        $permissoes = app(MacroprojetoPermissoes::class);
        $permissoes->autorizarAdmin($macroprojetoId);
    }

    protected function autorizarRotaMacro(int $macroprojetoId): void
    {
        if ($macroprojetoId <= 0) {
            abort(403, 'Macroprojeto inválido para autorização.');
        }

        $rotaNome = (string) optional(request()->route())->getName();
        $grupos = session('matchingGroups', []);
        if (! is_array($grupos)) {
            $grupos = [];
        }

        /** @var PermissaoDominioService $permissoes */
        $permissoes = app(PermissaoDominioService::class);
        $autorizado = trim($rotaNome) !== ''
            ? $permissoes->podeExecutar($rotaNome, $macroprojetoId, $grupos)
            : $permissoes->podeOperarMacro($macroprojetoId, $grupos);

        if (! $autorizado) {
            abort(403, 'Operação permitida apenas para grupos autorizados neste macroprojeto.');
        }
    }

    protected function macroprojetoAtivoIdSessao(): int
    {
        return (int) session('macroprojeto_ativo_id', 0);
    }

    protected function macroprojetoAtivoTurnoSessao(): string
    {
        return trim((string) session('macroprojeto_ativo_turno', ''));
    }

    protected function macroprojetoAtivoTurnoIdSessao(): int
    {
        return (int) session('macroprojeto_turno_ativo_id', 0);
    }

    /**
     * @return array<int>
     */
    protected function zonasPermitidasSessao(): array
    {
        return $this->escopoZonalSessao()->zonas();
    }

    protected function acessoTodasZonasSessao(): bool
    {
        return $this->escopoZonalSessao()->acessoTodas();
    }

    protected function usuarioSemAcessoZona(): bool
    {
        return $this->escopoZonalSessao()->semAcesso();
    }

    protected function escopoZonalSessao(): EscopoZonal
    {
        return EscopoZonal::from(
            (array) session('cod_zonas_permitidas', []),
            session('acesso_todas_zonas') === true,
        );
    }

    protected function usuarioTemAcessoRotaSessao(string $rotaNome): bool
    {
        $rotaNome = mb_strtoupper(trim($rotaNome));
        if ($rotaNome === '') {
            return false;
        }

        $rotasPermitidas = collect((array) session('rotas_permitidas', []))
            ->map(static fn ($rota) => mb_strtoupper(trim((string) $rota)))
            ->filter()
            ->unique()
            ->values()
            ->all();

        if (in_array('*', $rotasPermitidas, true)) {
            return true;
        }

        foreach ($rotasPermitidas as $permitida) {
            if ($permitida === $rotaNome) {
                return true;
            }

            if (str_ends_with($permitida, '*')) {
                $prefixo = rtrim($permitida, '*');
                if ($prefixo !== '' && str_starts_with($rotaNome, $prefixo)) {
                    return true;
                }
            }
        }

        return false;
    }
}
```
</APP_HTTP_CONTROLLERS_CONTROLLER_PHP>

