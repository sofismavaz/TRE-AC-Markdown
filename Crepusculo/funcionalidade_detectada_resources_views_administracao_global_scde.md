# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_administracao_global_scde`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 3  
> **Tamanho do Arquivo:** 14 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/administracao-global/scde/form.blade.php`
## <RESOURCES_VIEWS_ADMINISTRACAO_GLOBAL_SCDE_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/administracao-global/scde/form.blade.php`
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
@extends('layouts.app')

@section('titulo', ($configuracao ? 'Editar' : 'Nova').' configuração SCDE')

@section('conteudo')
<div class="container py-3">
    <div class="d-flex justify-content-between align-items-center mb-3"><h1 class="h3 mb-0">{{ $configuracao ? 'Editar' : 'Nova' }} configuração SCDE</h1><a class="btn btn-outline-secondary" href="{{ route('administracao-global.scde.index') }}">Voltar</a></div>
    @if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
    <div class="alert alert-info">A URL e o token são definidos somente no ambiente. Ao salvar, a configuração permanece inativa até o acionamento do botão de ativação.</div>
    <div class="card shadow-sm"><div class="card-body">
        <form method="POST" action="{{ $configuracao ? route('administracao-global.scde.update', $configuracao['id']) : route('administracao-global.scde.store') }}">
            @csrf @if($configuracao)@method('PUT')@endif
            <div class="row g-3">
                <div class="col-md-6"><label class="form-label" for="cod_pleito">Código do pleito</label><input class="form-control" id="cod_pleito" name="cod_pleito" type="number" min="1" value="{{ old('cod_pleito', $configuracao['cod_pleito'] ?? '') }}" required></div>
                <div class="col-md-6"><label class="form-label" for="cod_eleicao">Código da eleição</label><input class="form-control" id="cod_eleicao" name="cod_eleicao" type="number" min="1" value="{{ old('cod_eleicao', $configuracao['cod_eleicao'] ?? '') }}" required></div>
            </div>
            <button class="btn btn-primary mt-3" type="submit"><i class="fa-solid fa-floppy-disk me-1"></i> Salvar</button>
        </form>
    </div></div>
</div>
@endsection
```
</RESOURCES_VIEWS_ADMINISTRACAO_GLOBAL_SCDE_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/administracao-global/scde/index.blade.php`
## <RESOURCES_VIEWS_ADMINISTRACAO_GLOBAL_SCDE_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/administracao-global/scde/index.blade.php`
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
@extends('layouts.app')

@section('titulo', 'Sincronização SCDE')

@section('conteudo')
<div class="container-fluid py-3" data-scde-status-url="{{ route('administracao-global.scde.status') }}">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <div>
            <h1 class="h3 mb-1">Sincronização SCDE</h1>
            <p class="text-muted mb-0">Snapshot estadual de situação das seções do Acre.</p>
        </div>
        <a class="btn btn-primary" href="{{ route('administracao-global.scde.form') }}">
            <i class="fa-solid fa-plus me-1"></i> Nova configuração
        </a>
    </div>

    @if(session('status'))
        <div class="alert alert-success">{{ session('status') }}</div>
    @endif
    @if($errors->any())
        <div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>
    @endif

    @php
        $classeEstado = match($statusScde['estado']) {
            'sucesso' => 'text-bg-success',
            'erro', 'indisponivel' => 'text-bg-danger',
            'em_execucao' => 'text-bg-primary',
            'aguardando' => 'text-bg-warning',
            default => 'text-bg-secondary',
        };
    @endphp
    <section class="card shadow-sm mb-3" aria-labelledby="scde-status-titulo">
        <div class="card-body" id="scde-status-bloco">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
                <h2 class="h5 mb-0" id="scde-status-titulo">Estado da sincronização</h2>
                <span class="badge {{ $classeEstado }}" id="scde-status-estado">{{ $statusScde['rotulo'] }}</span>
            </div>
            <div class="row g-3 mt-1">
                <div class="col-md-3"><strong>Contexto ativo</strong><div id="scde-status-contexto">{{ $statusScde['configuracao_id'] ? 'Pleito '.$statusScde['cod_pleito'].' / Eleição '.$statusScde['cod_eleicao'] : '—' }}</div></div>
                <div class="col-md-3"><strong>Última tentativa</strong><div id="scde-status-tentativa">{{ $statusScde['ultima_tentativa'] ?? '—' }}</div></div>
                <div class="col-md-3"><strong>Último sucesso</strong><div id="scde-status-sucesso">{{ $statusScde['ultimo_sucesso'] ?? '—' }}</div></div>
                <div class="col-md-3"><strong>Duração</strong><div id="scde-status-duracao">{{ $statusScde['duracao_ms'] !== null ? number_format($statusScde['duracao_ms'], 0, ',', '.').' ms' : '—' }}</div></div>
                <div class="col-md-4"><strong>Zonas</strong><div id="scde-status-zonas">{{ $statusScde['qtd_zonas'] ?? '—' }}</div></div>
                <div class="col-md-4"><strong>Seções</strong><div id="scde-status-secoes">{{ $statusScde['qtd_secoes'] ?? '—' }}</div></div>
                <div class="col-md-4"><strong>Registros</strong><div id="scde-status-registros">{{ $statusScde['qtd_registros'] ?? '—' }}</div></div>
                <div class="col-12 {{ $statusScde['mensagem_erro'] ? '' : 'd-none' }}" id="scde-status-erro-bloco">
                    <strong>Último erro (<span id="scde-status-erro-data">{{ $statusScde['ultimo_erro'] ?? '—' }}</span>)</strong>
                    <div class="text-danger" id="scde-status-erro">{{ $statusScde['mensagem_erro'] }}</div>
                </div>
            </div>
        </div>
    </section>

    <form class="row g-2 mb-3" method="GET" action="{{ route('administracao-global.scde.index') }}">
        <div class="col-md-3"><label class="form-label" for="cod_pleito">Pleito</label><input class="form-control" id="cod_pleito" name="cod_pleito" type="number" min="1" value="{{ $filtros['cod_pleito'] ?? '' }}"></div>
        <div class="col-md-3"><label class="form-label" for="cod_eleicao">Eleição</label><input class="form-control" id="cod_eleicao" name="cod_eleicao" type="number" min="1" value="{{ $filtros['cod_eleicao'] ?? '' }}"></div>
        <div class="col-md-3"><label class="form-label" for="ativo">Estado</label><select class="form-select" id="ativo" name="ativo"><option value="">Todos</option><option value="1" @selected(($filtros['ativo'] ?? null) === '1')>Ativa</option><option value="0" @selected(($filtros['ativo'] ?? null) === '0')>Inativa</option></select></div>
        <div class="col-md-3 d-flex align-items-end gap-2"><button class="btn btn-primary" type="submit">Filtrar</button><button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#modalScdePdf"><i class="fa-solid fa-file-pdf me-1"></i> Exportar para PDF</button></div>
    </form>

    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead><tr><th>Configuração</th><th>Execução</th><th>Ações</th></tr></thead>
            <tbody>
            @forelse($configuracoes as $configuracao)
                <tr>
                    <td><strong>Pleito:</strong> {{ $configuracao->cod_pleito }}<br><strong>Eleição:</strong> {{ $configuracao->cod_eleicao }}<br><strong>Estado:</strong> {{ (int) $configuracao->ativo === 1 ? 'Ativa' : 'Inativa' }}</td>
                    <td><strong>Última tentativa:</strong> {{ $configuracao->dt_ultima_tentativa_fmt ?? '—' }}<br><strong>Último sucesso:</strong> {{ $configuracao->dt_ultimo_sucesso_fmt ?? '—' }}<br><strong>Totais:</strong> {{ $configuracao->qtd_zonas ?? 0 }} zona(s), {{ $configuracao->qtd_secoes ?? 0 }} seção(ões), {{ $configuracao->qtd_registros ?? 0 }} registro(s)@if($configuracao->ds_ultimo_erro ?? null)<br><span class="text-danger"><strong>Erro:</strong> {{ $configuracao->ds_ultimo_erro }}</span>@endif</td>
                    <td class="text-nowrap">
                        @if((int) $configuracao->ativo === 1)
                            <form class="d-inline" method="POST" action="{{ route('administracao-global.scde.desativar', $configuracao->id) }}">@csrf<button class="btn btn-sm btn-outline-warning" type="submit" title="Desativar" aria-label="Desativar"><i class="fa-solid fa-pause"></i></button></form>
                        @else
                            <a class="btn btn-sm btn-outline-primary" href="{{ route('administracao-global.scde.form', $configuracao->id) }}" title="Editar" aria-label="Editar"><i class="fa-solid fa-pen"></i></a>
                            <form class="d-inline" method="POST" action="{{ route('administracao-global.scde.ativar', $configuracao->id) }}">@csrf<button class="btn btn-sm btn-outline-success" type="submit" title="Ativar sincronização" aria-label="Ativar sincronização"><i class="fa-solid fa-play"></i></button></form>
                            <form class="d-inline" method="POST" action="{{ route('administracao-global.scde.destroy', $configuracao->id) }}" onsubmit="return confirm('Excluir esta configuração SCDE?');">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger" type="submit" title="Excluir" aria-label="Excluir"><i class="fa-solid fa-trash"></i></button></form>
                        @endif
                    </td>
                </tr>
            @empty
                <tr><td class="text-center text-muted" colspan="3">Nenhuma configuração encontrada.</td></tr>
            @endforelse
            </tbody>
        </table>
    </div>
    @if($configuracoes->hasPages()){{ $configuracoes->links('pagination::bootstrap-5') }}@endif
</div>

<div class="modal fade" id="modalScdePdf" tabindex="-1" aria-labelledby="modalScdePdfTitulo" aria-hidden="true">
    <div class="modal-dialog"><form class="modal-content" method="GET" action="{{ route('administracao-global.scde.exportar-pdf') }}" target="_blank">
        <div class="modal-header"><h2 class="modal-title h5" id="modalScdePdfTitulo">Exportar configurações para PDF</h2><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button></div>
        <div class="modal-body">
            <input type="hidden" name="cod_pleito" value="{{ $filtros['cod_pleito'] ?? '' }}"><input type="hidden" name="cod_eleicao" value="{{ $filtros['cod_eleicao'] ?? '' }}"><input type="hidden" name="ativo" value="{{ $filtros['ativo'] ?? '' }}">
            @foreach($camposPdf as $campo => $rotulo)<div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="scde-campo-{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="scde-campo-{{ $campo }}">{{ $rotulo }}</label></div>@endforeach
        </div>
        <div class="modal-footer"><button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit">Gerar PDF</button></div>
    </form></div>
</div>
@endsection

@push('scripts')
    <script src="{{ asset('js/administracao-global/scde.js') }}?v={{ @filemtime(public_path('js/administracao-global/scde.js')) }}"></script>
@endpush
```
</RESOURCES_VIEWS_ADMINISTRACAO_GLOBAL_SCDE_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/administracao-global/scde/pdf.blade.php`
## <RESOURCES_VIEWS_ADMINISTRACAO_GLOBAL_SCDE_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/administracao-global/scde/pdf.blade.php`
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
<!doctype html>
<html lang="pt-BR"><head><meta charset="utf-8"><style>body{font-family:DejaVu Sans,sans-serif;font-size:9px}table{width:100%;border-collapse:collapse}th,td{border:1px solid #bbb;padding:5px;vertical-align:top}th{background:#eee}</style></head>
<body><h1>Configurações SCDE</h1><p>Gerado em {{ $geradoEm }}</p><table><thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead><tbody>
@forelse($configuracoes as $configuracao)<tr>@foreach($campos as $campo)<td>@switch($campo)
@case('contexto')Pleito {{ $configuracao->cod_pleito }} / eleição {{ $configuracao->cod_eleicao }}@break
@case('status'){{ (int) $configuracao->ativo === 1 ? 'Ativa' : 'Inativa' }}@break
@case('ativacao'){{ $configuracao->dt_ativacao_fmt ?? '—' }}@break
@case('ultima_tentativa'){{ $configuracao->dt_ultima_tentativa_fmt ?? '—' }}@break
@case('ultimo_sucesso'){{ $configuracao->dt_ultimo_sucesso_fmt ?? '—' }}@break
@case('ultimo_erro'){{ $configuracao->dt_ultimo_erro_fmt ?? '—' }}@if($configuracao->ds_ultimo_erro ?? null)<br>{{ $configuracao->ds_ultimo_erro }}@endif @break
@case('duracao'){{ isset($configuracao->duracao_ultima_ms) ? $configuracao->duracao_ultima_ms.' ms' : '—' }}@break
@case('totais'){{ $configuracao->qtd_zonas ?? 0 }} zona(s), {{ $configuracao->qtd_secoes ?? 0 }} seção(ões), {{ $configuracao->qtd_registros ?? 0 }} registro(s)@break
@endswitch</td>@endforeach</tr>@empty<tr><td colspan="{{ count($campos) }}">Nenhuma configuração encontrada.</td></tr>@endforelse
</tbody></table></body></html>
```
</RESOURCES_VIEWS_ADMINISTRACAO_GLOBAL_SCDE_PDF_BLADE_PHP>

