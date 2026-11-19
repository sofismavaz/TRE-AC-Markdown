# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_layouts`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 27 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/layouts/app.blade.php`
## <RESOURCES_VIEWS_LAYOUTS_APP_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/layouts/app.blade.php`
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
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('titulo', 'Crepúsculo')</title>
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
     
    
     
    <!-- Bootstrap -->
    <link href="{{ asset('vendor/bootstrap/css/bootstrap.min.css') }}" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="{{ asset('vendor/fontawesome/css/all.min.css') }}" rel="stylesheet">
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="{{ asset('favicon.ico') }}">
    <!-- jQuery -->
    <script src="{{ asset('vendor/jquery/jquery-3.7.1.min.js') }}"></script>
    <!-- Select2 CSS -->
    <link href="{{ asset('vendor/select2/css/select2.min.css') }}" rel="stylesheet" />

    <!-- Select2 JS -->
    <script src="{{ asset('vendor/select2/js/select2.min.js') }}"></script>

   
    <script>
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
    </script>

    @stack('estilos')
    @stack('styles')
    <style>
        .brand-word {
            display: inline-flex;
            align-items: center;
            gap: 0;
            line-height: 1;
        }

        .brand-crescent-img {
            width: 1.95em;
            height: 1.95em;
            display: inline-block;
            flex: 0 0 auto;
            margin-right: -0.82em;
            transform: translateY(0.03em) scaleX(-1);
            position: relative;
            z-index: 2;
        }

        .brand-rest {
            letter-spacing: 0.01em;
            position: relative;
            z-index: 1;
        }

        .navbar-brand .brand-crescent-img {
            filter: brightness(0) invert(1);
        }

        .dropdown-submenu {
            position: relative;
        }

        .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -0.125rem;
        }

        @media (min-width: 992px) {
            .dropdown-submenu:hover > .dropdown-menu {
                display: block;
            }
        }

        @media (max-width: 991.98px) {
            .dropdown-submenu > .dropdown-menu {
                position: static;
                float: none;
                margin-left: 1rem;
                margin-top: 0.25rem;
            }
        }

    </style>
</head>

<body class="bg-light">

    <!-- Navbar -->
    @php
        $isLocalEnvironment = app()->environment('local');
        $menuThemeColor = $isLocalEnvironment ? 'success' : 'primary';
    @endphp
    <nav class="navbar navbar-expand-lg navbar-dark bg-{{ $menuThemeColor }} mb-3">
        <div class="container-fluid">
            <div class="navbar-brand-group d-flex align-items-center flex-shrink-0 me-3">
                <a class="navbar-brand me-2" href="{{ url('/') }}">
                    <span class="brand-word" aria-hidden="true">
                        <img
                            class="brand-crescent-img"
                            src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHZpZXdCb3g9JzAgMCA2NCA2NCc+CiAgPHBhdGggZmlsbD0nIzBkNmVmZCcgZmlsbC1ydWxlPSdldmVub2RkJyBkPSdNNTAgMzJjMCAxMi4xNS05Ljg1IDIyLTIyIDIyLTMuODIgMC03LjQyLS45Ny0xMC41Ni0yLjY5IDkuNzktMi4xNyAxNy4xMi0xMC44OSAxNy4xMi0yMS4zNCAwLTkuMDMtNS40OC0xNi43OC0xMy4yOS0yMC4xM0EyMS45MiAyMS45MiAwIDAgMSAyOCAxMGMxMi4xNSAwIDIyIDkuODUgMjIgMjJ6Jy8+Cjwvc3ZnPgo="
                            alt=""
                        >
                        <span class="brand-rest">repúsculo</span>
                    </span>
                    <span class="visually-hidden">Crepúsculo</span>
                </a>
                @if($isLocalEnvironment)
                    <span class="badge text-bg-warning border border-light text-uppercase">Homologação</span>
                @endif
            </div>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                    aria-controls="mainNavbar" aria-expanded="false" aria-label="Alternar navegação">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNavbar">
            @php
                $menuLayout = app(\App\Services\MenuCatalogService::class)
                    ->buildForLayout((array) session('rotas_permitidas', []));
            @endphp
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                @if(
                    !empty($menuLayout['planejamento']['cadastros']) ||
                    !empty($menuLayout['planejamento']['dashboards']) ||
                    !empty($menuLayout['planejamento']['consulta']) ||
                    !empty($menuLayout['planejamento']['administracao'])
                )
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="planejamentoDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['planejamento']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="planejamentoDropdown">
                            @if(!empty($menuLayout['planejamento']['cadastros']))
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">Cadastros</a>
                                    <ul class="dropdown-menu">
                                        @foreach($menuLayout['planejamento']['cadastros'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endif
                            @if(!empty($menuLayout['planejamento']['dashboards']))
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">Painéis</a>
                                    <ul class="dropdown-menu">
                                        @foreach($menuLayout['planejamento']['dashboards'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endif
                            @if(!empty($menuLayout['planejamento']['consulta']))
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">Consulta</a>
                                    <ul class="dropdown-menu">
                                        @foreach($menuLayout['planejamento']['consulta'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endif
                            @if(!empty($menuLayout['planejamento']['administracao']))
                                <li><hr class="dropdown-divider"></li>
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">Administração</a>
                                    <ul class="dropdown-menu">
                                        @foreach($menuLayout['planejamento']['administracao'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endif
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['rcand']['itens']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="rcandDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['rcand']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="rcandDropdown">
                            @foreach($menuLayout['rcand']['itens'] as $itemMenu)
                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                            @endforeach
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['colaboradores_eleitorais']['itens']) || !empty($menuLayout['colaboradores_eleitorais']['secoes']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="colaboradoresEleitoraisDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['colaboradores_eleitorais']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="colaboradoresEleitoraisDropdown">
                            @if(!empty($menuLayout['colaboradores_eleitorais']['secoes']))
                                @foreach($menuLayout['colaboradores_eleitorais']['secoes'] as $secao)
                                    @if(!$loop->first)
                                        <li><hr class="dropdown-divider"></li>
                                    @endif
                                    <li class="dropdown-submenu">
                                        <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">
                                            {{ $secao['titulo'] }}
                                        </a>
                                        <ul class="dropdown-menu">
                                            @foreach($secao['itens'] as $itemMenu)
                                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                            @endforeach
                                        </ul>
                                    </li>
                                @endforeach
                            @else
                                @foreach($menuLayout['colaboradores_eleitorais']['itens'] as $itemMenu)
                                    <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                @endforeach
                            @endif
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['fechamento']['itens']) || !empty($menuLayout['fechamento']['secoes']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="cadastroEleitoralDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['fechamento']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="cadastroEleitoralDropdown">
                            @if(!empty($menuLayout['fechamento']['secoes']))
                                @foreach($menuLayout['fechamento']['secoes'] as $secao)
                                    <li class="dropdown-submenu">
                                        <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">
                                            {{ $secao['titulo'] }}
                                        </a>
                                        <ul class="dropdown-menu">
                                            @foreach($secao['itens'] as $itemMenu)
                                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                            @endforeach
                                        </ul>
                                    </li>
                                @endforeach
                                @if(!empty($menuLayout['fechamento']['itens']))
                                    <li><hr class="dropdown-divider"></li>
                                @endif
                            @endif
                            @foreach($menuLayout['fechamento']['itens'] as $itemMenu)
                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                            @endforeach
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['dia_e']['itens']) || !empty($menuLayout['dia_e']['secoes']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="diaEDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['dia_e']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="diaEDropdown">
                            @if(!empty($menuLayout['dia_e']['secoes']))
                                @foreach($menuLayout['dia_e']['secoes'] as $secao)
                                    <li class="dropdown-submenu">
                                        <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">
                                            {{ $secao['titulo'] }}
                                        </a>
                                        <ul class="dropdown-menu">
                                            @foreach($secao['itens'] as $itemMenu)
                                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                            @endforeach
                                        </ul>
                                    </li>
                                @endforeach
                                @if(!empty($menuLayout['dia_e']['itens']))
                                    <li><hr class="dropdown-divider"></li>
                                @endif
                            @endif
                            @foreach($menuLayout['dia_e']['itens'] as $itemMenu)
                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                            @endforeach
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['diarias']['secoes']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="diariasDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['diarias']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="diariasDropdown">
                            @foreach($menuLayout['diarias']['secoes'] as $secao)
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">
                                        {{ $secao['titulo'] }}
                                    </a>
                                    <ul class="dropdown-menu">
                                        @foreach($secao['itens'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endforeach
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['operacoes_eleitorais']['itens']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="operacoesEleitoraisDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['operacoes_eleitorais']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="operacoesEleitoraisDropdown">
                            @foreach($menuLayout['operacoes_eleitorais']['itens'] as $itemMenu)
                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                            @endforeach
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['transmissao_dados']['secoes']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="ldaDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['transmissao_dados']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="ldaDropdown">
                            @foreach($menuLayout['transmissao_dados']['secoes'] as $secao)
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">
                                        {{ $secao['titulo'] }}
                                    </a>
                                    <ul class="dropdown-menu">
                                        @foreach($secao['itens'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endforeach
                        </ul>
                    </li>
                @endif
                @if(!empty($menuLayout['administracao_global']['itens']) || !empty($menuLayout['tabelas_auxiliares']['itens']))
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="administracaoGlobalDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {{ $menuLayout['administracao_global']['label'] }}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="administracaoGlobalDropdown">
                            @if(!empty($menuLayout['tabelas_auxiliares']['itens']))
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle" href="#" role="button" aria-expanded="false">
                                        {{ $menuLayout['tabelas_auxiliares']['label'] }}
                                    </a>
                                    <ul class="dropdown-menu">
                                        @foreach($menuLayout['tabelas_auxiliares']['itens'] as $itemMenu)
                                            <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                                        @endforeach
                                    </ul>
                                </li>
                            @endif
                            @if(!empty($menuLayout['administracao_global']['itens']) && !empty($menuLayout['tabelas_auxiliares']['itens']))
                                <li><hr class="dropdown-divider"></li>
                            @endif
                            @foreach($menuLayout['administracao_global']['itens'] as $itemMenu)
                                <li><a class="dropdown-item" href="{{ $itemMenu['href'] }}">{{ $itemMenu['label'] }}</a></li>
                            @endforeach
                        </ul>
                    </li>
                @endif
            </ul>

            @php
                $usuario = session('user.username');
                $gruposSessao = session('matchingGroups', session('user.groups', []));
                $gruposCollection = collect($gruposSessao);
                $gruposVisiveis = $gruposCollection->take(4);
                $gruposRestantes = max($gruposCollection->count() - $gruposVisiveis->count(), 0);
                $gruposFormatados = $gruposVisiveis->join(', ');
                $macroAtivoNome = session('macroprojeto_ativo_nome');
                $macroAtivoId = (int) session('macroprojeto_ativo_id', 0);
                $macroDisponiveis = collect(session('macroprojetos_disponiveis', []))->map(fn ($item) => (array) $item)->values();
            @endphp

            <div class="text-end text-white small">
                <div class="d-flex justify-content-end align-items-center gap-2">
                    <div title="{{ $macroAtivoNome ?: 'Sem macroprojeto selecionado' }}">
                        <i class="fa-solid fa-layer-group"></i>
                        {{ $macroAtivoNome ?: 'Sem macroprojeto' }}
                    </div>
                    <div><i class="fa-solid fa-user"></i> {{ $usuario ?? 'Usuário' }}</div>
                    <button type="button" id="btnLogoffAuthelia" class="btn btn-primary btn-sm">
                        <i class="fa-solid fa-right-from-bracket"></i> Logoff
                    </button>
                </div>
                <div title="{{ $gruposSessao ? implode(', ', $gruposSessao) : 'Sem grupos' }}">
                    <i class="fa-solid fa-users"></i>
                    {{ $gruposFormatados ?: 'Sem grupos' }}@if($gruposRestantes > 0), +{{ $gruposRestantes }} @endif
                </div>
                @if ($macroDisponiveis->count() > 1)
                    <form method="POST" action="{{ route('macroprojeto.contexto.alternar') }}" class="mt-1 d-flex gap-1 justify-content-end">
                        @csrf
                        <select name="macroprojeto_id" class="form-select form-select-sm" style="max-width: 200px;">
                            @foreach ($macroDisponiveis as $macro)
                                <option value="{{ $macro['id'] ?? '' }}" @selected((int) ($macro['id'] ?? 0) === $macroAtivoId)>
                                    {{ $macro['nome'] ?? 'Macroprojeto' }}
                                </option>
                            @endforeach
                        </select>
                        <button type="submit" class="btn btn-light btn-sm">Alternar</button>
                    </form>
                @endif
            </div>
            </div>
        </div>
    </nav>

    <!-- Conteúdo específico -->
    <main class="@yield('main_class', 'container')">
        @yield('conteudo')
    </main>

    <footer class="mt-4 py-3 bg-transparent">
        <div class="container text-center text-secondary small">
            Desenvolvido pela STI/AGEL/CSCOR/ASPGOVTI/SDBD/TRE-AC
            @php
                $nomeRodape = session('user.name');
                $usernameRodape = session('user.username');
                $emailRodape = session('user.email');
            @endphp
            @if($nomeRodape || $usernameRodape || $emailRodape)
                <div class="mt-1">
                    Sessão:
                    {{ $nomeRodape ?: ($usernameRodape ?: 'Usuário') }}
                    @if($emailRodape)
                        <span class="text-muted">({{ $emailRodape }})</span>
                    @endif
                </div>
            @endif
        </div>
    </footer>

    <!-- Scripts Bootstrap -->
    <script src="{{ asset('vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const isTouch = () => window.matchMedia('(max-width: 991.98px)').matches;
            const submenuToggles = document.querySelectorAll('.dropdown-submenu > .dropdown-toggle');

            submenuToggles.forEach((toggle) => {
                toggle.addEventListener('click', (event) => {
                    if (!isTouch()) {
                        return;
                    }
                    event.preventDefault();
                    event.stopPropagation();
                    const submenu = toggle.nextElementSibling;
                    if (!submenu) {
                        return;
                    }
                    submenu.classList.toggle('show');
                });
            });

            document.querySelectorAll('.dropdown').forEach((dropdown) => {
                dropdown.addEventListener('hidden.bs.dropdown', () => {
                    dropdown.querySelectorAll('.dropdown-menu.show').forEach((menu) => {
                        menu.classList.remove('show');
                    });
                });
            });

            const autheliaLogoutUrl = @json(config('planeleito.auth.authelia_logout_url'));
            const btnLogoffAuthelia = document.getElementById('btnLogoffAuthelia');
            if (btnLogoffAuthelia) {
                btnLogoffAuthelia.addEventListener('click', () => {
                    const confirmar = window.confirm(
                        'Ao fazer logoff no Authelia, sistemas que dependem dele também serão desconectados, como o SEI. Deseja continuar?'
                    );
                    if (!confirmar) {
                        return;
                    }

                    window.location.href = autheliaLogoutUrl;
                });
            }
        });
    </script>
    @if (request()->routeIs('diarias.*'))
        <div
            id="diarias-formulario-retorno"
            hidden
            data-diarias-formulario-retorno
            data-diarias-formulario-ativo="{{ old('_diarias_formulario', '') }}"
            data-diarias-campos-erro="{{ json_encode($errors->keys(), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) }}"
        ></div>
        <script src="{{ asset('js/diarias/formulario-retorno.js') }}?v={{ @filemtime(public_path('js/diarias/formulario-retorno.js')) }}"></script>
    @endif
    @stack('scripts')
</body>

</html>
```
</RESOURCES_VIEWS_LAYOUTS_APP_BLADE_PHP>

