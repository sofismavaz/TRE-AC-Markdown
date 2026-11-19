# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_services`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 20 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Services/EscopoUnidadeService.php`
## <APP_SERVICES_ESCOPOUNIDADESERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/EscopoUnidadeService.php`
- **Namespace Declaração:** `App\Services`
- **Entidade / Classe:** `class EscopoUnidadeService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function escopoAtual(): EscopoUnidade
public function escopoPorRota(?string $routeName): EscopoUnidade
public function unidadesParaConsultaAtual(): ?array
public function aplicaEscopoAtual(): bool
private function ignoraUnidadesNaRota(?string $routeName): bool
private function normalizarUnidades(array $unidades): array
private function lancarContratoInvalido(?string $routeName, string $motivo): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services;

use App\Support\EscopoUnidade;
use RuntimeException;

class EscopoUnidadeService
{
    public function escopoAtual(): EscopoUnidade
    {
        $rotaAtual = (string) optional(request()->route())->getName();
        return $this->escopoPorRota($rotaAtual);
    }

    public function escopoPorRota(?string $routeName): EscopoUnidade
    {
        if (session('is_admin') === true || $this->ignoraUnidadesNaRota($routeName)) {
            return EscopoUnidade::irrestrito();
        }

        $aplicaEscopo = session('aplica_escopo_unidade');
        if (!is_bool($aplicaEscopo)) {
            $this->lancarContratoInvalido(
                $routeName,
                'Campo aplica_escopo_unidade ausente ou inválido.'
            );
        }

        if ($aplicaEscopo === false) {
            return EscopoUnidade::irrestrito();
        }

        $unidades = session('unidades_permitidas_ids');
        if (!is_array($unidades)) {
            $this->lancarContratoInvalido(
                $routeName,
                'Campo unidades_permitidas_ids ausente ou inválido.'
            );
        }

        return EscopoUnidade::restrito($this->normalizarUnidades($unidades));
    }

    /**
     * @return array<int>|null
     */
    public function unidadesParaConsultaAtual(): ?array
    {
        $escopo = $this->escopoAtual();
        return $escopo->aplicaEscopo ? $escopo->unidades : null;
    }

    public function aplicaEscopoAtual(): bool
    {
        return $this->escopoAtual()->aplicaEscopo;
    }

    private function ignoraUnidadesNaRota(?string $routeName): bool
    {
        if (session('ignora_unidades_na_rota') === true) {
            return true;
        }

        $rotas = session('rotas_ignora_unidades', []);
        if (!is_array($rotas) || empty($rotas)) {
            return false;
        }

        if (in_array('*', $rotas, true)) {
            return true;
        }

        $rota = trim(mb_strtoupper((string) $routeName));
        if ($rota === '') {
            return false;
        }

        return in_array($rota, $rotas, true);
    }

    /**
     * @param array<int|string> $unidades
     * @return array<int>
     */
    private function normalizarUnidades(array $unidades): array
    {
        return collect($unidades)
            ->map(static fn ($id) => is_numeric($id) ? (int) $id : null)
            ->filter(static fn ($id) => $id !== null && $id > 0)
            ->unique()
            ->values()
            ->all();
    }

    private function lancarContratoInvalido(?string $routeName, string $motivo): void
    {
        $rota = (string) $routeName;
        $usuario = (string) session('user.username', '');

        throw new RuntimeException(
            sprintf(
                'Contrato de escopo de unidade inválido. rota=%s usuario=%s motivo=%s',
                $rota !== '' ? $rota : '(sem rota)',
                $usuario !== '' ? $usuario : '(sem usuario)',
                $motivo
            )
        );
    }
}
```
</APP_SERVICES_ESCOPOUNIDADESERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/MenuCatalogService.php`
## <APP_SERVICES_MENUCATALOGSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/MenuCatalogService.php`
- **Namespace Declaração:** `App\Services`
- **Entidade / Classe:** `class MenuCatalogService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buildForLayout(array $rotasPermitidas): array
public function menuPathForRoute(string $rotaNome): ?string
private function normalizarRotasPermitidas(array $rotasPermitidas): Collection
private function filtrarItens(array $itens, Collection $permitidas): Collection
private function itemEhPermitido(array $item, Collection $permitidas): bool
private function transformarItem(array $item): array
private function resolverHref(array $item): string
private function rotaBatePadrao(string $rota, string $padrao): bool
private function coletarItensRoteaveis(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
if ($routeName !== '' && Route::has($routeName)) {
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services;

use Illuminate\Support\Arr;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Route;

class MenuCatalogService
{
    /**
     * @param array<int, string> $rotasPermitidas
     */
    public function buildForLayout(array $rotasPermitidas): array
    {
        $permitidas = $this->normalizarRotasPermitidas($rotasPermitidas);

        $planejamento = (array) config('planeleito_menu.planejamento', []);
        $cadastros = $this->filtrarItens((array) Arr::get($planejamento, 'sections.cadastros.items', []), $permitidas);
        $dashboards = $this->filtrarItens((array) Arr::get($planejamento, 'sections.dashboards.items', []), $permitidas);
        $consulta = $this->filtrarItens((array) Arr::get($planejamento, 'sections.consulta.items', []), $permitidas);
        $administracao = $this->filtrarItens((array) Arr::get($planejamento, 'sections.administracao.items', []), $permitidas);
        $rcandCfg = (array) config('planeleito_menu.rcand', []);
        $rcand = $this->filtrarItens((array) Arr::get($rcandCfg, 'items', []), $permitidas);

        $fechamento = $this->filtrarItens((array) config('planeleito_menu.fechamento_cadastro.items', []), $permitidas);
        $fechamentoSecoes = collect((array) config('planeleito_menu.fechamento_cadastro.sections', []))
            ->map(function ($secao, $chave) use ($permitidas) {
                $itens = $this->filtrarItens((array) Arr::get((array) $secao, 'items', []), $permitidas);
                if ($itens->isEmpty()) {
                    return null;
                }

                $labelSecao = (string) Arr::get((array) $secao, 'label', ucfirst((string) $chave));

                return [
                    'titulo' => $labelSecao,
                    'itens' => $itens->all(),
                ];
            })
            ->filter()
            ->values();
        $colaboradoresSecoes = collect((array) config('planeleito_menu.colaboradores_eleitorais.sections', []))
            ->map(function ($secao, $chave) use ($permitidas) {
                $itens = $this->filtrarItens((array) Arr::get((array) $secao, 'items', []), $permitidas);
                if ($itens->isEmpty()) {
                    return null;
                }

                $labelSecao = (string) Arr::get((array) $secao, 'label', ucfirst((string) $chave));

                return [
                    'titulo' => $labelSecao,
                    'itens' => $itens->all(),
                ];
            })
            ->filter()
            ->values();
        $colaboradoresEleitorais = $this->filtrarItens((array) config('planeleito_menu.colaboradores_eleitorais.items', []), $permitidas);
        $diaE = $this->filtrarItens((array) config('planeleito_menu.dia_e.items', []), $permitidas);
        $operacoesEleitoraisCfg = (array) config('planeleito_menu.operacoes_eleitorais', []);
        $operacoesEleitorais = $this->filtrarItens((array) Arr::get($operacoesEleitoraisCfg, 'items', []), $permitidas);
        $diaESecoes = collect((array) config('planeleito_menu.dia_e.sections', []))
            ->map(function ($itens, $titulo) use ($permitidas) {
                $filtrados = $this->filtrarItens((array) $itens, $permitidas);
                if ($filtrados->isEmpty()) {
                    return null;
                }

                return [
                    'titulo' => (string) $titulo,
                    'itens' => $filtrados->all(),
                ];
            })
            ->filter()
            ->values();
        $tabelas = $this->filtrarItens((array) config('planeleito_menu.tabelas_auxiliares.items', []), $permitidas);
        $adminGlobal = $this->filtrarItens((array) config('planeleito_menu.administracao_global.items', []), $permitidas);

        $diariasEnabled = (bool) config('planeleito.diarias.enabled', false);
        $diariasCfg = $diariasEnabled ? (array) config('planeleito_menu.diarias', []) : [];
        $diariasSecoes = $diariasEnabled
            ? collect((array) config('planeleito_menu.diarias.sections', []))
                ->map(function ($secao, $chave) use ($permitidas) {
                    $itens = $this->filtrarItens((array) Arr::get((array) $secao, 'items', []), $permitidas);
                    if ($itens->isEmpty()) {
                        return null;
                    }

                    $labelSecao = (string) Arr::get((array) $secao, 'label', ucfirst((string) $chave));

                    return [
                        'titulo' => $labelSecao,
                        'itens' => $itens->all(),
                    ];
                })
                ->filter()
                ->values()
            : collect();

        $transmissaoSecoes = collect((array) config('planeleito_menu.transmissao_dados.sections', []))
            ->map(function ($itens, $titulo) use ($permitidas) {
                $filtrados = $this->filtrarItens((array) $itens, $permitidas);
                if ($filtrados->isEmpty()) {
                    return null;
                }

                return [
                    'titulo' => (string) $titulo,
                    'itens' => $filtrados->all(),
                ];
            })
            ->filter()
            ->values();

        $registroCfg = (array) config('planeleito_menu.registro_candidaturas', []);
        $registro = $this->itemEhPermitido($registroCfg, $permitidas)
            ? $this->transformarItem($registroCfg)
            : null;

        return [
            'planejamento' => [
                'label' => (string) Arr::get($planejamento, 'label', 'Planejamento'),
                'cadastros' => $cadastros->all(),
                'dashboards' => $dashboards->all(),
                'consulta' => $consulta->all(),
                'administracao' => $administracao->all(),
            ],
            'rcand' => [
                'label' => (string) Arr::get($rcandCfg, 'label', 'RCAND'),
                'itens' => $rcand->all(),
            ],
            'fechamento' => [
                'label' => (string) Arr::get(config('planeleito_menu.fechamento_cadastro', []), 'label', 'Fechamento do Cadastro'),
                'itens' => $fechamento->all(),
                'secoes' => $fechamentoSecoes->all(),
            ],
            'colaboradores_eleitorais' => [
                'label' => (string) Arr::get(config('planeleito_menu.colaboradores_eleitorais', []), 'label', 'Colaboradores Eleitorais'),
                'itens' => $colaboradoresEleitorais->all(),
                'secoes' => $colaboradoresSecoes->all(),
            ],
            'registro_candidaturas' => $registro,
            'dia_e' => [
                'label' => (string) Arr::get(config('planeleito_menu.dia_e', []), 'label', 'Dia-E'),
                'itens' => $diaE->all(),
                'secoes' => $diaESecoes->all(),
            ],
            'diarias' => [
                'label' => (string) Arr::get($diariasCfg, 'label', 'Diárias'),
                'secoes' => $diariasSecoes->all(),
            ],
            'operacoes_eleitorais' => [
                'label' => (string) Arr::get($operacoesEleitoraisCfg, 'label', 'Operações Eleitorais'),
                'itens' => $operacoesEleitorais->all(),
            ],
            'transmissao_dados' => [
                'label' => (string) Arr::get(config('planeleito_menu.transmissao_dados', []), 'label', 'Transmissão de Dados'),
                'secoes' => $transmissaoSecoes->all(),
            ],
            'tabelas_auxiliares' => [
                'label' => (string) Arr::get(config('planeleito_menu.tabelas_auxiliares', []), 'label', 'Tabelas Auxiliares'),
                'itens' => $tabelas->all(),
            ],
            'administracao_global' => [
                'label' => (string) Arr::get(config('planeleito_menu.administracao_global', []), 'label', 'Administração Global'),
                'itens' => $adminGlobal->all(),
            ],
        ];
    }

    public function menuPathForRoute(string $rotaNome): ?string
    {
        $rota = trim($rotaNome);
        if ($rota === '') {
            return null;
        }

        foreach ($this->coletarItensRoteaveis() as $item) {
            $menuPath = (string) ($item['menu_path'] ?? '');
            if ($menuPath === '') {
                continue;
            }

            foreach ((array) ($item['route_patterns'] ?? []) as $pattern) {
                if ($this->rotaBatePadrao($rota, (string) $pattern)) {
                    return $menuPath;
                }
            }
        }

        return null;
    }

    /**
     * @param array<int, string> $rotasPermitidas
     */
    private function normalizarRotasPermitidas(array $rotasPermitidas): Collection
    {
        return collect($rotasPermitidas)
            ->map(fn ($rota) => mb_strtoupper(trim((string) $rota)))
            ->filter()
            ->unique()
            ->values();
    }

    /**
     * @param array<int, array<string, mixed>> $itens
     */
    private function filtrarItens(array $itens, Collection $permitidas): Collection
    {
        return collect($itens)
            ->filter(fn (array $item) => $this->itemEhPermitido($item, $permitidas))
            ->map(fn (array $item) => $this->transformarItem($item))
            ->values();
    }

    /**
     * @param array<string, mixed> $item
     */
    private function itemEhPermitido(array $item, Collection $permitidas): bool
    {
        if ($permitidas->contains('*')) {
            return true;
        }

        if (($item['requires_wildcard'] ?? false) === true) {
            return false;
        }

        $padroes = collect((array) ($item['route_patterns'] ?? []))
            ->map(fn ($pattern) => trim((string) $pattern))
            ->filter()
            ->values();

        if ($padroes->isEmpty() && !empty($item['route'])) {
            $padroes->push((string) $item['route']);
        }

        if ($padroes->isEmpty()) {
            return false;
        }

        foreach ($padroes as $padrao) {
            foreach ($permitidas as $rotaPermitida) {
                if ($this->rotaBatePadrao((string) $rotaPermitida, (string) $padrao)) {
                    return true;
                }
            }
        }

        return false;
    }

    /**
     * @param array<string, mixed> $item
     * @return array{label:string,href:string}
     */
    private function transformarItem(array $item): array
    {
        return [
            'label' => (string) ($item['label'] ?? ''),
            'href' => $this->resolverHref($item),
        ];
    }

    /**
     * @param array<string, mixed> $item
     */
    private function resolverHref(array $item): string
    {
        $routeName = (string) ($item['route'] ?? '');
        if ($routeName !== '' && Route::has($routeName)) {
            return route($routeName);
        }

        $url = (string) ($item['url'] ?? '#');
        if ($url === '' || $url === '#') {
            return '#';
        }

        if (str_starts_with($url, 'http://') || str_starts_with($url, 'https://') || str_starts_with($url, '#')) {
            return $url;
        }

        return url($url);
    }

    private function rotaBatePadrao(string $rota, string $padrao): bool
    {
        $rotaNorm = mb_strtoupper(trim($rota));
        $padraoNorm = mb_strtoupper(trim($padrao));

        if ($padraoNorm === '') {
            return false;
        }

        if (str_ends_with($padraoNorm, '*')) {
            $prefixo = substr($padraoNorm, 0, -1);
            return str_starts_with($rotaNorm, $prefixo);
        }

        return $rotaNorm === $padraoNorm;
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function coletarItensRoteaveis(): array
    {
        $itens = [];

        $planejamento = (array) config('planeleito_menu.planejamento.sections', []);
        foreach ($planejamento as $secao) {
            foreach ((array) ($secao['items'] ?? []) as $item) {
                if (!empty($item['route'])) {
                    $itens[] = $item;
                }
            }
        }

        foreach ((array) config('planeleito_menu.rcand.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }
        foreach ((array) config('planeleito_menu.fechamento_cadastro.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }
        foreach ((array) config('planeleito_menu.fechamento_cadastro.sections', []) as $secao) {
            foreach ((array) ($secao['items'] ?? []) as $item) {
                if (!empty($item['route'])) {
                    $itens[] = $item;
                }
            }
        }

        foreach ((array) config('planeleito_menu.colaboradores_eleitorais.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }
        foreach ((array) config('planeleito_menu.colaboradores_eleitorais.sections', []) as $secao) {
            foreach ((array) ($secao['items'] ?? []) as $item) {
                if (!empty($item['route'])) {
                    $itens[] = $item;
                }
            }
        }

        foreach ((array) config('planeleito_menu.dia_e.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }
        foreach ((array) config('planeleito_menu.dia_e.sections', []) as $secao) {
            foreach ((array) $secao as $item) {
                if (!empty($item['route'])) {
                    $itens[] = $item;
                }
            }
        }

        if ((bool) config('planeleito.diarias.enabled', false)) {
            foreach ((array) config('planeleito_menu.diarias.sections', []) as $secao) {
                foreach ((array) ($secao['items'] ?? []) as $item) {
                    if (!empty($item['route'])) {
                        $itens[] = $item;
                    }
                }
            }
        }

        foreach ((array) config('planeleito_menu.operacoes_eleitorais.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }

        foreach ((array) config('planeleito_menu.transmissao_dados.sections', []) as $secao) {
            foreach ((array) $secao as $item) {
                if (!empty($item['route'])) {
                    $itens[] = $item;
                }
            }
        }

        foreach ((array) config('planeleito_menu.tabelas_auxiliares.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }

        foreach ((array) config('planeleito_menu.administracao_global.items', []) as $item) {
            if (!empty($item['route'])) {
                $itens[] = $item;
            }
        }

        return $itens;
    }
}
```
</APP_SERVICES_MENUCATALOGSERVICE_PHP>

