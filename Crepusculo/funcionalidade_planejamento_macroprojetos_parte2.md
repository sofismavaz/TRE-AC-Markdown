# 📦 Documentação Consolidada do Sistema Crepúsculo (Parte 2)
## Funcionalidade: `funcionalidade_planejamento_macroprojetos`
> **Volume Fracionado para Otimização de Leitura por IA**
> **Tamanho Máximo:** 1500 KB

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/calendario-eleitoral/partials/navegacao.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PARTIALS_NAVEGACAO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/calendario-eleitoral/partials/navegacao.blade.php`
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
<nav class="nav nav-pills flex-column flex-sm-row gap-2 mb-4" aria-label="Seções do Calendário Eleitoral">
    <a class="nav-link @if(request()->routeIs('tabelas-auxiliares.calendario-eleitoral.eventos.*')) active @endif" href="{{ route('tabelas-auxiliares.calendario-eleitoral.eventos.index') }}">Eventos</a>
    <a class="nav-link @if(request()->routeIs('tabelas-auxiliares.calendario-eleitoral.pleitos.*')) active @endif" href="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.index') }}">Pleitos</a>
    <a class="nav-link @if(request()->routeIs('tabelas-auxiliares.calendario-eleitoral.competencias.*')) active @endif" href="{{ route('tabelas-auxiliares.calendario-eleitoral.competencias.index') }}">Competências</a>
    <a class="nav-link @if(request()->routeIs('tabelas-auxiliares.calendario-eleitoral.importacoes.*')) active @endif" href="{{ route('tabelas-auxiliares.calendario-eleitoral.importacoes.index') }}">Importar XLSX</a>
</nav>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PARTIALS_NAVEGACAO_BLADE_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/calendario-eleitoral/pleitos/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PLEITOS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/calendario-eleitoral/pleitos/form.blade.php`
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
@section('titulo',($pleito?'Editar':'Novo').' pleito — Calendário Eleitoral')
@section('conteudo')<h1 class="h3 mb-3">{{ $pleito?'Editar pleito':'Novo pleito' }}</h1>@include('tabelas-auxiliares.calendario-eleitoral.partials.navegacao') @if($errors->any())<div class="alert alert-danger"><ul>@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<form class="card card-body" method="POST" action="{{ $pleito?route('tabelas-auxiliares.calendario-eleitoral.pleitos.update',$pleito->id):route('tabelas-auxiliares.calendario-eleitoral.pleitos.store') }}">@csrf @if($pleito)@method('PUT')@endif <div class="row g-3"><div class="col-md-3"><label class="form-label" for="ano">Ano</label><input class="form-control" type="number" min="2000" max="2200" id="ano" name="ano" required value="{{ old('ano',$pleito->ano??'') }}"></div><div class="col-md-9"><label class="form-label" for="titulo">Título</label><input class="form-control" id="titulo" name="titulo" maxlength="160" required value="{{ old('titulo',$pleito->titulo??'') }}"></div><div class="col-12"><label class="form-label" for="fonte_referencia">Referência da fonte</label><input class="form-control" id="fonte_referencia" name="fonte_referencia" maxlength="255" required value="{{ old('fonte_referencia',$pleito->fonte_referencia??'') }}"></div><div class="col-12"><label class="form-label" for="fonte_url">URL oficial</label><input class="form-control" type="url" id="fonte_url" name="fonte_url" maxlength="1000" required value="{{ old('fonte_url',$pleito->fonte_url??'') }}"></div><div class="col-12"><input type="hidden" name="ativo" value="0"><div class="form-check form-switch"><input class="form-check-input" type="checkbox" id="ativo" name="ativo" value="1" @checked((bool)old('ativo',(int)($pleito->ativo??1)===1))><label class="form-check-label" for="ativo">Ativo</label></div></div></div><div class="mt-4 d-flex gap-2"><button class="btn btn-primary">Salvar</button><a class="btn btn-outline-secondary" href="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.index') }}">Cancelar</a></div></form>@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PLEITOS_FORM_BLADE_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/calendario-eleitoral/pleitos/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PLEITOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/calendario-eleitoral/pleitos/index.blade.php`
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
@section('titulo','Pleitos — Calendário Eleitoral')
@section('conteudo')
<div class="d-flex flex-column flex-lg-row justify-content-between gap-3 mb-3"><div><h1 class="h3">Pleitos</h1><p class="text-muted">Pleitos disponíveis para publicação do calendário.</p></div><div class="d-flex flex-wrap gap-2 align-self-start"><a class="btn btn-primary" href="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.form') }}">Novo pleito</a><button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalPdfPleitos">Exportar para PDF</button></div></div>
@include('tabelas-auxiliares.calendario-eleitoral.partials.navegacao')
@if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif
<form method="GET" class="card card-body mb-3"><div class="row g-2 align-items-end"><div class="col-md-8"><label class="form-label" for="busca">Busca</label><input class="form-control" id="busca" name="busca" value="{{ $busca }}"></div><div class="col-md-4 d-flex gap-2"><button class="btn btn-secondary">Filtrar</button><a class="btn btn-outline-secondary" href="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.index') }}">Limpar</a></div></div></form>
<div class="table-responsive"><table class="table table-striped align-middle"><thead><tr><th>Ano</th><th>Título</th><th>Fonte</th><th>Status</th><th class="text-end">Ações</th></tr></thead><tbody>@forelse($pleitos as $pleito)<tr><td>{{ $pleito->ano }}</td><td>{{ $pleito->titulo }}</td><td><a href="{{ $pleito->fonte_url }}" target="_blank" rel="noopener">{{ $pleito->fonte_referencia }}</a></td><td><span class="badge text-bg-{{ (int)$pleito->ativo===1?'success':'secondary' }}">{{ (int)$pleito->ativo===1?'Ativo':'Inativo' }}</span></td><td class="text-end"><div class="d-inline-flex gap-1"><a class="btn btn-sm btn-outline-primary" href="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.form',$pleito->id) }}">Editar</a><form method="POST" action="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.status',$pleito->id) }}">@csrf<input type="hidden" name="ativo" value="{{ (int)$pleito->ativo===1?0:1 }}"><button class="btn btn-sm btn-outline-secondary" onclick="return confirm('Confirma a alteração de status?')">{{ (int)$pleito->ativo===1?'Inativar':'Ativar' }}</button></form></div></td></tr>@empty<tr><td colspan="5" class="text-center text-muted">Nenhum pleito encontrado.</td></tr>@endforelse</tbody></table></div>
{{ $pleitos->links('pagination::bootstrap-5') }}
<div class="modal fade" id="modalPdfPleitos" tabindex="-1" aria-labelledby="tituloPdfPleitos" aria-hidden="true"><div class="modal-dialog"><form method="GET" action="{{ route('tabelas-auxiliares.calendario-eleitoral.pleitos.exportar-pdf') }}" class="modal-content"><div class="modal-header"><h2 id="tituloPdfPleitos" class="modal-title fs-5">Exportar para PDF</h2><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button></div><div class="modal-body">@foreach($camposPdf as $campo=>$rotulo)<div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="pdf-pleito-{{ $campo }}" @checked(in_array($campo,$camposPdfPadrao,true))><label for="pdf-pleito-{{ $campo }}">{{ $rotulo }}</label></div>@endforeach @if($busca!=='')<input type="hidden" name="busca" value="{{ $busca }}">@endif</div><div class="modal-footer"><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger">Gerar PDF</button></div></form></div></div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PLEITOS_INDEX_BLADE_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/calendario-eleitoral/pleitos/pdf.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PLEITOS_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/calendario-eleitoral/pleitos/pdf.blade.php`
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
<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><style>body{font-family:DejaVu Sans,sans-serif;font-size:10px}table{width:100%;border-collapse:collapse}th,td{border:1px solid #bbb;padding:5px}th{background:#eee}</style></head><body><h1>Pleitos do Calendário Eleitoral</h1><p>Gerado em {{ $geradoEm }}</p><table><thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead><tbody>@forelse($pleitos as $pleito)<tr>@foreach($campos as $campo)<td>@switch($campo)@case('ano'){{ $pleito->ano }}@break @case('titulo'){{ $pleito->titulo }}@break @case('fonte'){{ $pleito->fonte_referencia }} — {{ $pleito->fonte_url }}@break @case('status'){{ (int)$pleito->ativo===1?'Ativo':'Inativo' }}@break @endswitch</td>@endforeach</tr>@empty<tr><td colspan="{{ count($campos) }}">Nenhum registro.</td></tr>@endforelse</tbody></table></body></html>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_CALENDARIO_ELEITORAL_PLEITOS_PDF_BLADE_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/macroprojeto-turnos/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_MACROPROJETO_TURNOS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/macroprojeto-turnos/form.blade.php`
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

@php
    /** @var object|null $turnoRegistro */
    $titulo = $turnoRegistro ? 'Editar Turno do Macroprojeto' : 'Novo Turno do Macroprojeto';
    $rotaSalvar = $turnoRegistro
        ? route('tabelas-auxiliares.macroprojeto-turnos.update', $turnoRegistro->id)
        : route('tabelas-auxiliares.macroprojeto-turnos.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-repeat"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Escolha o macroprojeto, informe o turno e marque qual está operacionalmente ativo.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.macroprojeto-turnos.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($turnoRegistro)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-6">
                    <label for="macroprojeto_id" class="form-label">Macroprojeto</label>
                    <select id="macroprojeto_id" name="macroprojeto_id" class="form-select @error('macroprojeto_id') is-invalid @enderror" required>
                        <option value="">Selecione...</option>
                        @foreach ($macroprojetos as $macro)
                            <option value="{{ $macro['id'] ?? '' }}" @selected((int) old('macroprojeto_id', $turnoRegistro->macroprojeto_id ?? 0) === (int) ($macro['id'] ?? 0))>
                                {{ $macro['nome'] ?? 'Macroprojeto' }}
                            </option>
                        @endforeach
                    </select>
                    @error('macroprojeto_id')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="turno" class="form-label">Turno</label>
                    <select id="turno" name="turno" class="form-select @error('turno') is-invalid @enderror" required>
                        <option value="">Selecione...</option>
                        <option value="1" @selected(old('turno', $turnoRegistro->turno ?? '') === '1')>1</option>
                        <option value="2" @selected(old('turno', $turnoRegistro->turno ?? '') === '2')>2</option>
                    </select>
                    @error('turno')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3 d-flex align-items-end">
                    <div class="form-check mb-2">
                        <input type="checkbox" id="ativo" name="ativo" value="1" class="form-check-input" @checked(old('ativo', isset($turnoRegistro) ? (int) ($turnoRegistro->ativo ?? 0) === 1 : false))>
                        <label class="form-check-label" for="ativo">Turno ativo</label>
                    </div>
                </div>

                <div class="col-12">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="160" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $turnoRegistro->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="cod_pleito" class="form-label">Código do pleito</label>
                    <input type="text" id="cod_pleito" name="cod_pleito" maxlength="30"
                           class="form-control @error('cod_pleito') is-invalid @enderror"
                           value="{{ old('cod_pleito', $turnoRegistro->cod_pleito ?? '') }}">
                    @error('cod_pleito')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="dt_eleicao" class="form-label">Data da eleição</label>
                    <input type="date" id="dt_eleicao" name="dt_eleicao"
                           class="form-control @error('dt_eleicao') is-invalid @enderror"
                           value="{{ old('dt_eleicao', isset($turnoRegistro->dt_eleicao) ? \Illuminate\Support\Carbon::parse($turnoRegistro->dt_eleicao)->format('Y-m-d') : '') }}">
                    @error('dt_eleicao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                    <div class="form-text">Os dois campos são obrigatórios antes de ativar o turno.</div>
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_MACROPROJETO_TURNOS_FORM_BLADE_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/macroprojeto-turnos/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_MACROPROJETO_TURNOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/macroprojeto-turnos/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Turnos por Macroprojeto')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-repeat"></i>
                    Turnos por Macroprojeto
                </h5>
                <small class="text-muted">Defina os dois turnos operacionais de cada macroprojeto e indique qual está ativo.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.macroprojeto-turnos.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Novo turno
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.macroprojeto-turnos.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-4">
                    <label for="macroprojeto_id" class="form-label">Macroprojeto</label>
                    <select id="macroprojeto_id" name="macroprojeto_id" class="form-select">
                        <option value="0">Todos</option>
                        @foreach ($macroprojetos as $macro)
                            <option value="{{ $macro['id'] ?? 0 }}" @selected((int) ($macro['id'] ?? 0) === (int) ($macroprojetoId ?? 0))>
                                {{ $macro['nome'] ?? 'Macroprojeto' }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-12 col-md-3">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Macroprojeto, turno ou descrição">
                </div>
                <div class="col-12 col-md-2">
                    <label for="ativo" class="form-label">Ativo</label>
                    <select id="ativo" name="ativo" class="form-select">
                        <option value="">Todos</option>
                        <option value="1" @selected(($ativo ?? '') === '1')>Sim</option>
                        <option value="0" @selected(($ativo ?? '') === '0')>Não</option>
                    </select>
                </div>
                <div class="col-12 col-md-3 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.macroprojeto-turnos.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Macroprojeto</th>
                        <th style="width: 12%;">Turno</th>
                        <th style="width: 16%;">Ativo</th>
                        <th style="width: 16%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($turnos as $turno)
                        <tr>
                            <td>
                                <strong>Macroprojeto:</strong> {{ $turno->macroprojeto_nome }} <br>
                                <strong>Descrição:</strong> {{ $turno->descricao }} <br>
                                <strong>Código do pleito:</strong> {{ $turno->cod_pleito ?: 'Não informado' }} <br>
                                <strong>Data da eleição:</strong> {{ $turno->dt_eleicao_fmt ?: 'Não informada' }}
                            </td>
                            <td>{{ $turno->turno }}</td>
                            <td>
                                @if ((int) ($turno->ativo ?? 0) === 1)
                                    <span class="badge text-bg-success">Ativo</span>
                                @else
                                    <span class="badge text-bg-secondary">Inativo</span>
                                @endif
                            </td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.macroprojeto-turnos.form', $turno->id) }}"
                                       title="Editar"
                                       aria-label="Editar turno {{ $turno->turno }} do macroprojeto {{ $turno->macroprojeto_nome }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.macroprojeto-turnos.destroy', $turno->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão deste turno do macroprojeto?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir turno {{ $turno->turno }} do macroprojeto {{ $turno->macroprojeto_nome }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhum turno de macroprojeto cadastrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($turnos, 'links'))
            <div class="card-footer">{{ $turnos->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_MACROPROJETO_TURNOS_INDEX_BLADE_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/CalendarioEleitoralPublicoTest.php`
## <TESTS_FEATURE_CALENDARIOELEITORALPUBLICOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/CalendarioEleitoralPublicoTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class CalendarioEleitoralPublicoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_home_exibe_calendario_antes_do_status_sem_boas_vindas(): void
public function test_rota_publica_e_anonima_e_nao_expoe_status_ou_layout_interno(): void
public function test_pleito_informado_e_repassado_como_ano_para_consulta(): void
private function mockConsulta(): void
private function dadosCalendario(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Services\CalendarioEleitoral\CalendarioEleitoralConsultaService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use Mockery;
use Tests\TestCase;

class CalendarioEleitoralPublicoTest extends TestCase
{
    public function test_home_exibe_calendario_antes_do_status_sem_boas_vindas(): void
    {
        $this->mockConsulta();
        $status = Mockery::mock(LocalVotacaoSyncStatusService::class);
        $status->shouldReceive('obterRegistrosMonitorados')->once()->andReturn([
            [
                'label' => 'Sequencial',
                'status' => 'sucesso',
                'executado_em_formatado' => '02/08/2026 10:00:00',
            ],
        ]);
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $response = $this->get('/');

        $response->assertOk();
        $response->assertSeeInOrder(['id="calendario-eleitoral"', 'Status das sincronizações'], false);
        $response->assertSee('Evento oficial de teste');
        $response->assertDontSee('Sistema de Planejamento e Gestão');
    }

    public function test_rota_publica_e_anonima_e_nao_expoe_status_ou_layout_interno(): void
    {
        $this->mockConsulta();
        $status = Mockery::mock(LocalVotacaoSyncStatusService::class);
        $status->shouldNotReceive('obterRegistrosMonitorados');
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $response = $this->get('/rotas-publicas/calendario-eleitoral');

        $response->assertOk();
        $response->assertSee('id="calendario-eleitoral"', false);
        $response->assertSee('Evento oficial de teste');
        $response->assertSee('/rotas-publicas/vendor/fullcalendar/index.global.min.js', false);
        $response->assertDontSee('Status das sincronizações');
        $response->assertDontSee('Logoff');
        $response->assertDontSee('src="/vendor/fullcalendar/index.global.min.js"', false);
    }

    public function test_pleito_informado_e_repassado_como_ano_para_consulta(): void
    {
        $service = Mockery::mock(CalendarioEleitoralConsultaService::class);
        $service->shouldReceive('consultar')->once()->with(2026)->andReturn($this->dadosCalendario());
        $this->app->instance(CalendarioEleitoralConsultaService::class, $service);

        $response = $this->get('/rotas-publicas/calendario-eleitoral?pleito=2026');

        $response->assertOk()->assertSee('Eleições 2026');
    }

    private function mockConsulta(): void
    {
        $service = Mockery::mock(CalendarioEleitoralConsultaService::class);
        $service->shouldReceive('consultar')->once()->with(null)->andReturn($this->dadosCalendario());
        $this->app->instance(CalendarioEleitoralConsultaService::class, $service);
    }

    /** @return array<string, mixed> */
    private function dadosCalendario(): array
    {
        return [
            'pleito' => [
                'id' => 1,
                'ano' => 2026,
                'titulo' => 'Eleições 2026',
                'fonte_referencia' => 'Resolução TSE nº 23.750/2026',
                'fonte_url' => 'https://www.tse.jus.br/legislacao/compilada/res/2026/resolucao-no-23-750-de-26-de-fevereiro-de-2026',
            ],
            'pleitos' => [
                ['ano' => 2026, 'titulo' => 'Eleições 2026'],
            ],
            'competencias' => [
                ['codigo' => 'TSE', 'nome' => 'TSE', 'cor' => '#1d4ed8'],
            ],
            'eventos' => [
                [
                    'codigo' => 'TSE-2026-001',
                    'title' => 'Evento oficial de teste',
                    'start' => '2026-04-06',
                    'end' => '2026-04-07',
                    'competencia_codigo' => 'TSE',
                    'competencia_nome' => 'TSE',
                    'cor' => '#1d4ed8',
                    'periodo' => '06/04/2026',
                ],
            ],
        ];
    }
}
```
</TESTS_FEATURE_CALENDARIOELEITORALPUBLICOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/HomeMacroprojetoContextTest.php`
## <TESTS_FEATURE_HOMEMACROPROJETOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/HomeMacroprojetoContextTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class HomeMacroprojetoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_home_redireciona_para_selecao_quando_usuario_tem_multiplos_macroprojetos_sem_contexto_ativo(): void
public function test_home_mantem_tela_inicial_quando_macroprojeto_ativo_ja_esta_definido(): void
private function dadosCalendario(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\ConfigureUserSession;
use App\Services\CalendarioEleitoral\CalendarioEleitoralConsultaService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use Tests\TestCase;

class HomeMacroprojetoContextTest extends TestCase
{
    public function test_home_redireciona_para_selecao_quando_usuario_tem_multiplos_macroprojetos_sem_contexto_ativo(): void
    {
        $this->withoutMiddleware(ConfigureUserSession::class);

        $response = $this->withSession([
            'user' => ['username' => 'servidor.teste'],
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
        ])->get('/');

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
    }

    public function test_home_mantem_tela_inicial_quando_macroprojeto_ativo_ja_esta_definido(): void
    {
        $this->withoutMiddleware(ConfigureUserSession::class);
        $this->mock(CalendarioEleitoralConsultaService::class)
            ->shouldReceive('consultar')->once()->with(null)->andReturn($this->dadosCalendario());
        $this->mock(LocalVotacaoSyncStatusService::class)
            ->shouldReceive('obterRegistrosMonitorados')->once()->andReturn([]);

        $response = $this->withSession([
            'user' => ['username' => 'servidor.teste'],
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
            'macroprojeto_ativo_id' => 7,
            'macroprojeto_ativo_nome' => 'Macro A',
        ])->get('/');

        $response->assertOk();
        $response->assertViewIs('index');
    }

    /** @return array<string, mixed> */
    private function dadosCalendario(): array
    {
        return [
            'pleito' => [
                'id' => 1,
                'ano' => 2026,
                'titulo' => 'Eleições 2026',
                'fonte_referencia' => 'Resolução TSE nº 23.750/2026',
                'fonte_url' => 'https://example.test/calendario',
            ],
            'pleitos' => [['ano' => 2026, 'titulo' => 'Eleições 2026']],
            'competencias' => [],
            'eventos' => [],
        ];
    }
}
```
</TESTS_FEATURE_HOMEMACROPROJETOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/MacroprojetoContextoTurnoSelectionTest.php`
## <TESTS_FEATURE_MACROPROJETOCONTEXTOTURNOSELECTIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/MacroprojetoContextoTurnoSelectionTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class MacroprojetoContextoTurnoSelectionTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_selecao_de_macro_limpa_turno_ativo_anterior_quando_macro_muda(): void
public function test_selecao_do_mesmo_macro_preserva_turno_ativo_atual(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use Tests\TestCase;

class MacroprojetoContextoTurnoSelectionTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_selecao_de_macro_limpa_turno_ativo_anterior_quando_macro_muda(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'servidor.teste'],
                'macroprojetos_disponiveis' => [
                    ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                    ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
                ],
                'macroprojeto_ativo_id' => 7,
                'macroprojeto_ativo_nome' => 'Macro A',
                'macroprojeto_turno_ativo_id' => 71,
                'macroprojeto_ativo_turno' => '1',
                'macroprojeto_ativo_turno_descricao' => '1o turno',
            ])
            ->post(route('macroprojeto.contexto.salvar'), [
                'macroprojeto_id' => 8,
            ]);

        $response->assertRedirect(route('home'));
        $this->assertSame(8, session('macroprojeto_ativo_id'));
        $this->assertSame('Macro B', session('macroprojeto_ativo_nome'));
        $this->assertNull(session('macroprojeto_turno_ativo_id'));
        $this->assertNull(session('macroprojeto_ativo_turno'));
        $this->assertNull(session('macroprojeto_ativo_turno_descricao'));
    }

    public function test_selecao_do_mesmo_macro_preserva_turno_ativo_atual(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'servidor.teste'],
                'macroprojetos_disponiveis' => [
                    ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
                ],
                'macroprojeto_ativo_id' => 8,
                'macroprojeto_ativo_nome' => 'Macro B',
                'macroprojeto_turno_ativo_id' => 82,
                'macroprojeto_ativo_turno' => '2',
                'macroprojeto_ativo_turno_descricao' => '2o turno',
            ])
            ->post(route('macroprojeto.contexto.salvar'), [
                'macroprojeto_id' => 8,
            ]);

        $response->assertRedirect(route('home'));
        $this->assertSame(82, session('macroprojeto_turno_ativo_id'));
        $this->assertSame('2', session('macroprojeto_ativo_turno'));
        $this->assertSame('2o turno', session('macroprojeto_ativo_turno_descricao'));
    }
}
```
</TESTS_FEATURE_MACROPROJETOCONTEXTOTURNOSELECTIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/NatOcorrenciasPorRotaMacroprojetoContextTest.php`
## <TESTS_FEATURE_NATOCORRENCIASPORROTAMACROPROJETOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/NatOcorrenciasPorRotaMacroprojetoContextTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class NatOcorrenciasPorRotaMacroprojetoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_index_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
public function test_dados_retorna_409_quando_macroprojeto_ativo_esta_ausente(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Nat\NatRotaMensagemRepository;
use App\Services\Nat\NatEscopoService;
use Mockery;
use Tests\TestCase;

class NatOcorrenciasPorRotaMacroprojetoContextTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
        ]);

        $repository = Mockery::mock(NatOcorrenciaRepository::class);
        $repository->shouldReceive('contarNaoFinalizadasPorRota')
            ->andReturn([]);

        $mensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $mensagemRepository->shouldReceive('cardsRotaComNaoLidas')
            ->andReturn([]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->andReturn([
            'login' => 'nat.teste',
            'nome' => 'NAT Teste',
        ]);

        $this->app->instance(NatOcorrenciaRepository::class, $repository);
        $this->app->instance(NatRotaMensagemRepository::class, $mensagemRepository);
        $this->app->instance(NatEscopoService::class, $escopo);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'nat.teste'],
                'macroprojetos_disponiveis' => [
                    ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                    ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
                ],
            ])
            ->get(route('nat.ocorrencias-por-rota.index'));

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
        $response->assertSessionHas('erro', 'Selecione um macroprojeto para continuar.');
    }

    public function test_dados_retorna_409_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'nat.teste'],
                'macroprojetos_disponiveis' => [
                    ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                    ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
                ],
            ])
            ->getJson(route('nat.ocorrencias-por-rota.dados'));

        $response->assertStatus(409);
        $response->assertJson([
            'mensagem' => 'Selecione um macroprojeto para continuar.',
        ]);
    }
}
```
</TESTS_FEATURE_NATOCORRENCIASPORROTAMACROPROJETOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/SupervisoresPredioExportarPdfMacroprojetoContextTest.php`
## <TESTS_FEATURE_SUPERVISORESPREDIOEXPORTARPDFMACROPROJETOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/SupervisoresPredioExportarPdfMacroprojetoContextTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class SupervisoresPredioExportarPdfMacroprojetoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_exportar_pdf_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use Tests\TestCase;

class SupervisoresPredioExportarPdfMacroprojetoContextTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_exportar_pdf_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'teste.admin'],
                'rotas_permitidas' => [
                    'COLABORADORES-ELEITORAIS.EXTERNOS.SUPERVISORES-PREDIO-VOLUNTARIOS.EXPORTAR-PDF',
                ],
                'acesso_todas_zonas' => true,
                'cod_zonas_permitidas' => [],
                'macroprojetos_disponiveis' => [
                    ['id' => 1, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                    ['id' => 2, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
                ],
            ])
            ->get(route('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.exportar-pdf'));

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
        $response->assertSessionHas('erro', 'Selecione um macroprojeto para continuar.');
    }
}
```
</TESTS_FEATURE_SUPERVISORESPREDIOEXPORTARPDFMACROPROJETOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/VoluntarioManualMacroprojetoContextTest.php`
## <TESTS_FEATURE_VOLUNTARIOMANUALMACROPROJETOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/VoluntarioManualMacroprojetoContextTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class VoluntarioManualMacroprojetoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_catalogo_redireciona_sem_macroprojeto_ativo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use Tests\TestCase;

class VoluntarioManualMacroprojetoContextTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        $this->withoutMiddleware([ConfigureUserSession::class, AuthorizeRouteAccess::class]);
    }

    public function test_catalogo_redireciona_sem_macroprojeto_ativo(): void
    {
        $response = $this->withSession([
            'user' => ['username' => 'teste.admin'],
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'macroprojetos_disponiveis' => [
                ['id' => 1, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 2, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
        ])->get(route('colaboradores-eleitorais.externos.voluntarios-manuais.index'));

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
        $response->assertSessionHas('erro', 'Selecione um macroprojeto para continuar.');
    }
}
```
</TESTS_FEATURE_VOLUNTARIOMANUALMACROPROJETOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/VoluntariosExternosExportarPdfMacroprojetoContextTest.php`
## <TESTS_FEATURE_VOLUNTARIOSEXTERNOSEXPORTARPDFMACROPROJETOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/VoluntariosExternosExportarPdfMacroprojetoContextTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class VoluntariosExternosExportarPdfMacroprojetoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
private function sessaoSemMacro(array $rotasPermitidas): array
public function test_listagem_principal_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
public function test_listagem_de_eventos_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
public function test_solicitar_pdf_retorna_409_quando_macroprojeto_ativo_esta_ausente(): void
public function test_relatorio_de_eventos_redireciona_quando_macroprojeto_ativo_esta_ausente(): void
public function test_relatorio_de_eventos_exige_permissao_da_rota_ou_da_tela_base(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use Tests\TestCase;

class VoluntariosExternosExportarPdfMacroprojetoContextTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    private function sessaoSemMacro(array $rotasPermitidas): array
    {
        return [
            'user' => ['username' => 'teste.colaboradores'],
            'rotas_permitidas' => $rotasPermitidas,
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
            'macroprojetos_disponiveis' => [
                ['id' => 1, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 2, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
        ];
    }

    public function test_listagem_principal_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession($this->sessaoSemMacro([
                'COLABORADORES-ELEITORAIS.EXTERNOS.VOLUNTARIOS',
            ]))
            ->get(route('colaboradores-eleitorais.externos.voluntarios'));

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
    }

    public function test_listagem_de_eventos_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession($this->sessaoSemMacro([
                'COLABORADORES-ELEITORAIS.EXTERNOS.VOLUNTARIOS.EVENTOS.INDEX',
            ]))
            ->get(route('colaboradores-eleitorais.externos.voluntarios.eventos.index'));

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
    }

    public function test_solicitar_pdf_retorna_409_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession($this->sessaoSemMacro([
                'COLABORADORES-ELEITORAIS.EXTERNOS.VOLUNTARIOS.PDF.SOLICITAR',
            ]))
            ->postJson(route('colaboradores-eleitorais.externos.voluntarios.pdf.solicitar'));

        $response->assertStatus(409);
        $response->assertJson(['mensagem' => 'Selecione um macroprojeto para continuar.']);
    }

    public function test_relatorio_de_eventos_redireciona_quando_macroprojeto_ativo_esta_ausente(): void
    {
        $response = $this
            ->withSession($this->sessaoSemMacro([
                'COLABORADORES-ELEITORAIS.EXTERNOS.VOLUNTARIOS.RELATORIO-EVENTOS.PDF',
            ]))
            ->get(route('colaboradores-eleitorais.externos.voluntarios.relatorio-eventos.pdf'));

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
    }

    public function test_relatorio_de_eventos_exige_permissao_da_rota_ou_da_tela_base(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'teste.sem.permissao'],
                'rotas_permitidas' => [],
                'macroprojeto_ativo_id' => 1,
                'macroprojetos_disponiveis' => [
                    ['id' => 1, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ],
            ])
            ->get(route('colaboradores-eleitorais.externos.voluntarios.relatorio-eventos.pdf'));

        $response->assertForbidden();
    }
}
```
</TESTS_FEATURE_VOLUNTARIOSEXTERNOSEXPORTARPDFMACROPROJETOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/WebMacroprojetoContextEnforcementTest.php`
## <TESTS_FEATURE_WEBMACROPROJETOCONTEXTENFORCEMENTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/WebMacroprojetoContextEnforcementTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class WebMacroprojetoContextEnforcementTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_rota_interna_do_grupo_web_redireciona_para_selecao_quando_ha_multiplos_macros_sem_contexto_ativo(): void
public function test_rota_interna_do_grupo_web_autoativa_macro_unico(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
Route::middleware('web')
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use Illuminate\Support\Facades\Route;
use Tests\TestCase;

class WebMacroprojetoContextEnforcementTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
        ]);

        Route::middleware('web')
            ->get('/_teste/macroprojeto-contexto-interno', static fn () => response('ok'))
            ->name('teste.macroprojeto.interno');
    }

    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_rota_interna_do_grupo_web_redireciona_para_selecao_quando_ha_multiplos_macros_sem_contexto_ativo(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'servidor.teste'],
                'macroprojetos_disponiveis' => [
                    ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                    ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
                ],
            ])
            ->get('/_teste/macroprojeto-contexto-interno');

        $response->assertRedirect(route('macroprojeto.contexto.selecionar'));
    }

    public function test_rota_interna_do_grupo_web_autoativa_macro_unico(): void
    {
        $response = $this
            ->withSession([
                'user' => ['username' => 'servidor.teste'],
                'macroprojetos_disponiveis' => [
                    ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ],
            ])
            ->get('/_teste/macroprojeto-contexto-interno');

        $response->assertOk();
        $response->assertSee('ok');
        $this->assertSame(7, session('macroprojeto_ativo_id'));
        $this->assertSame('Macro A', session('macroprojeto_ativo_nome'));
    }
}
```
</TESTS_FEATURE_WEBMACROPROJETOCONTEXTENFORCEMENTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AcessibilidadeEleitoralConfiguracaoServiceTest.php`
## <TESTS_UNIT_ACESSIBILIDADEELEITORALCONFIGURACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AcessibilidadeEleitoralConfiguracaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AcessibilidadeEleitoralConfiguracaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function aceita_janelas_independentes_sem_sobreposicao(): void
public function recusa_janelas_ativas_sobrepostas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\AcessibilidadeEleitoral\AcessibilidadeEleitoralConfiguracaoRepository;
use App\Services\AcessibilidadeEleitoral\AcessibilidadeEleitoralConfiguracaoService;
use Illuminate\Validation\ValidationException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class AcessibilidadeEleitoralConfiguracaoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function aceita_janelas_independentes_sem_sobreposicao(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralConfiguracaoRepository::class);
        $configuracoes = [
            ['macroprojeto_turno_id' => 1, 'ativo' => true, 'dt_abertura' => '2026-10-04 05:00', 'dt_fechamento' => '2026-10-04 20:00', 'versao' => 0],
            ['macroprojeto_turno_id' => 2, 'ativo' => true, 'dt_abertura' => '2026-10-25 05:00', 'dt_fechamento' => '2026-10-25 20:00', 'versao' => 0],
        ];
        $repository->shouldReceive('salvar')->once()->with(9, $configuracoes, 'gestor');

        (new AcessibilidadeEleitoralConfiguracaoService($repository))->atualizar(9, $configuracoes, 'gestor');
        $this->addToAssertionCount(1);
    }

    #[Test]
    public function recusa_janelas_ativas_sobrepostas(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralConfiguracaoRepository::class);
        $repository->shouldNotReceive('salvar');
        $configuracoes = [
            ['macroprojeto_turno_id' => 1, 'ativo' => true, 'dt_abertura' => '2026-10-04 05:00', 'dt_fechamento' => '2026-10-04 20:00', 'versao' => 0],
            ['macroprojeto_turno_id' => 2, 'ativo' => true, 'dt_abertura' => '2026-10-04 19:00', 'dt_fechamento' => '2026-10-05 08:00', 'versao' => 0],
        ];

        $this->expectException(ValidationException::class);
        (new AcessibilidadeEleitoralConfiguracaoService($repository))->atualizar(9, $configuracoes, 'gestor');
    }

    #[Test]
    public function aceita_primeiro_turno_sem_criar_segundo_turno_implícito(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralConfiguracaoRepository::class);
        $configuracoes = [[
            'macroprojeto_turno_id' => 1, 'ativo' => true,
            'dt_abertura' => '2026-10-04 05:00', 'dt_fechamento' => '2026-10-04 20:00', 'versao' => 0,
        ]];
        $repository->shouldReceive('salvar')->once()->with(9, $configuracoes, 'gestor');

        (new AcessibilidadeEleitoralConfiguracaoService($repository))->atualizar(9, $configuracoes, 'gestor');
        $this->addToAssertionCount(1);
    }
}
```
</TESTS_UNIT_ACESSIBILIDADEELEITORALCONFIGURACAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AcessibilidadeEleitoralMigrationsTest.php`
## <TESTS_UNIT_ACESSIBILIDADEELEITORALMIGRATIONSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AcessibilidadeEleitoralMigrationsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AcessibilidadeEleitoralMigrationsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migrations_separam_catalogos_registros_e_acl(): void
public function constraints_das_novas_tabelas_respeitam_o_limite_do_oracle(): void
private function migration(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class AcessibilidadeEleitoralMigrationsTest extends TestCase
{
    #[Test]
    public function migrations_separam_catalogos_registros_e_acl(): void
    {
        $dominio = $this->migration('2026_09_11_120000_create_ca_registro_domain_tables.php');
        $eleicao = $this->migration('2026_09_11_121000_create_ca_registro_eleicao_tables.php');
        $acl = $this->migration('2026_09_11_122000_grant_ca_registro_eleicao_routes_acl.php');

        foreach (['CA_REGISTRO_STATUS', 'CA_ATENDIMENTO_TIPO', 'CA_OCORRENCIA_TIPO', 'CA_REGISTRO_CONFIGURACAO'] as $tabela) {
            $this->assertStringContainsString($tabela, $dominio);
        }

        foreach (['CA_REGISTRO_ELEICAO', 'CA_REGISTRO_ATENDIMENTO', 'CA_REGISTRO_OCORRENCIA', 'CA_REGISTRO_HISTORICO'] as $tabela) {
            $this->assertStringContainsString('CREATE TABLE '.$tabela, $eleicao);
        }

        $this->assertStringContainsString('UNIQUE (MACROPROJETO_TURNO_ID, NUM_INSCRICAO)', $eleicao);
        $this->assertStringContainsString('ON DELETE SET NULL', $eleicao);
        $this->assertStringNotContainsString('CPF_', $eleicao);
        $this->assertStringNotContainsString('NUM_CPF', $eleicao);

        $this->assertStringContainsString('PLANELEITO_ACESSIBILIDADE_GESTOR', $acl);
        $this->assertStringContainsString('PLANELEITO_ADMIN', $acl);
        $this->assertStringContainsString("'ignora_unidades_permitidas' => 1", $acl);
        $this->assertStringContainsString('operacoes-eleitorais.acessibilidade.registros.index', $acl);
        $this->assertStringContainsString('operacoes-eleitorais.acessibilidade.configuracao.update', $acl);
    }

    #[Test]
    public function constraints_das_novas_tabelas_respeitam_o_limite_do_oracle(): void
    {
        foreach (glob(database_path('migrations/2026_09_11_12*_ca_registro_*.php')) ?: [] as $arquivo) {
            $conteudo = (string) file_get_contents($arquivo);
            preg_match_all('/CONSTRAINT\s+([A-Z0-9_]+)/', $conteudo, $matches);

            foreach ($matches[1] as $nome) {
                $this->assertLessThanOrEqual(30, strlen($nome), basename($arquivo).': '.$nome);
            }
        }
    }

    private function migration(string $arquivo): string
    {
        $caminho = database_path('migrations/'.$arquivo);
        $this->assertFileExists($caminho);

        return (string) file_get_contents($caminho);
    }
}
```
</TESTS_UNIT_ACESSIBILIDADEELEITORALMIGRATIONSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AcessibilidadeEleitoralRegistroServiceTest.php`
## <TESTS_UNIT_ACESSIBILIDADEELEITORALREGISTROSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AcessibilidadeEleitoralRegistroServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AcessibilidadeEleitoralRegistroServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function salva_rascunho_parcial_sem_exigir_campos_finais(): void
public function envio_exige_campos_e_quantidades_completos(): void
public function total_positivo_exige_categoria_positiva_mas_nao_igualdade_da_soma(): void
public function ocorrencia_positiva_e_outros_atendimento_exigem_detalhes(): void
private function contexto(): array
private function dadosCompletos(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\AcessibilidadeEleitoral\AcessibilidadeEleitoralRegistroRepository;
use App\Services\AcessibilidadeEleitoral\AcessibilidadeEleitoralRegistroService;
use Illuminate\Validation\ValidationException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class AcessibilidadeEleitoralRegistroServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function salva_rascunho_parcial_sem_exigir_campos_finais(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralRegistroRepository::class);
        $repository->shouldReceive('salvar')->once()->with(
            $this->contexto(),
            Mockery::on(static fn (array $dados): bool => $dados['total_atendido'] === null),
            false,
            '127.0.0.1',
            'teste',
        )->andReturn(['id' => 5, 'status_codigo' => 'RASCUNHO', 'versao' => 1]);

        $resultado = (new AcessibilidadeEleitoralRegistroService($repository))->salvarRascunho(
            $this->contexto(),
            ['horario_inicial' => '07:00'],
            '127.0.0.1',
            'teste',
        );

        $this->assertSame('RASCUNHO', $resultado['status_codigo']);
    }

    #[Test]
    public function envio_exige_campos_e_quantidades_completos(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralRegistroRepository::class);
        $repository->shouldNotReceive('salvar');

        $this->expectException(ValidationException::class);
        (new AcessibilidadeEleitoralRegistroService($repository))->enviar(
            $this->contexto(),
            ['horario_inicial' => '07:00'],
            null,
            null,
        );
    }

    #[Test]
    public function total_positivo_exige_categoria_positiva_mas_nao_igualdade_da_soma(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralRegistroRepository::class);
        $repository->shouldReceive('salvar')->once()->andReturn([
            'id' => 5, 'status_codigo' => 'ENVIADO', 'versao' => 2,
        ]);
        $service = new AcessibilidadeEleitoralRegistroService($repository);

        $dados = $this->dadosCompletos();
        $dados['total_atendido'] = 8;
        $dados['atendimentos']['VISUAL']['quantidade'] = 1;
        $resultado = $service->enviar($this->contexto(), $dados, null, null);
        $this->assertSame('ENVIADO', $resultado['status_codigo']);

        $dados['atendimentos']['VISUAL']['quantidade'] = 0;
        $this->expectException(ValidationException::class);
        $service->enviar($this->contexto(), $dados, null, null);
    }

    #[Test]
    public function ocorrencia_positiva_e_outros_atendimento_exigem_detalhes(): void
    {
        $repository = Mockery::mock(AcessibilidadeEleitoralRegistroRepository::class);
        $repository->shouldNotReceive('salvar');
        $dados = $this->dadosCompletos();
        $dados['ocorrencias']['PORTA_ESTREITA']['quantidade'] = 1;

        try {
            (new AcessibilidadeEleitoralRegistroService($repository))->enviar($this->contexto(), $dados, null, null);
            $this->fail('A ocorrência positiva deveria exigir detalhes.');
        } catch (ValidationException $exception) {
            $this->assertArrayHasKey('ocorrencias.PORTA_ESTREITA.detalhes', $exception->errors());
        }

        $dados = $this->dadosCompletos();
        $dados['atendimentos']['OUTROS']['quantidade'] = 1;
        $this->expectException(ValidationException::class);
        (new AcessibilidadeEleitoralRegistroService($repository))->enviar($this->contexto(), $dados, null, null);
    }

    /** @return array<string, mixed> */
    private function contexto(): array
    {
        return [
            'coordenador_id' => 41,
            'macroprojeto_turno_id' => 7,
            'num_inscricao' => '000123456789',
            'nome_coordenador' => 'Pessoa Coordenadora',
            'origem_cadastro' => 'AVULSO',
            'num_zona' => '1',
            'municipio_nome' => 'RIO BRANCO',
            'local_nome' => 'ESCOLA TESTE',
            'local_codigo' => 'LOCAL-1',
            'data_eleicao' => '2026-10-04',
        ];
    }

    /** @return array<string, mixed> */
    private function dadosCompletos(): array
    {
        $atendimentos = [];
        foreach (['FISICA_MOBILIDADE', 'VISUAL', 'AUDITIVA', 'INTELECTUAL', 'TEA', 'OUTROS'] as $codigo) {
            $atendimentos[$codigo] = ['quantidade' => 0, 'detalhes' => null];
        }
        $ocorrencias = [];
        foreach (['SINALIZACAO_INADEQUADA', 'PORTA_ESTREITA', 'RAMPA_INADEQUADA', 'BANHEIRO_INACESSIVEL', 'PRIORIDADE_NAO_RESPEITADA', 'CONFLITO_CONSTRANGIMENTO', 'OUTROS'] as $codigo) {
            $ocorrencias[$codigo] = ['quantidade' => 0, 'detalhes' => null];
        }

        return [
            'versao' => 0,
            'horario_inicial' => '07:00',
            'horario_final' => '16:30',
            'total_atendido' => 0,
            'atendimentos' => $atendimentos,
            'ocorrencias' => $ocorrencias,
            'providencias' => null,
            'sugestoes' => null,
        ];
    }
}
```
</TESTS_UNIT_ACESSIBILIDADEELEITORALREGISTROSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AcessibilidadeEleitoralRequestsTest.php`
## <TESTS_UNIT_ACESSIBILIDADEELEITORALREQUESTSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AcessibilidadeEleitoralRequestsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AcessibilidadeEleitoralRequestsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function acesso_normaliza_titulo_data_e_exige_turnstile(): void
public function rascunho_aceita_campos_ausentes_mas_valida_o_que_foi_informado(): void
private function validator(string $requestClass, array $dados, string $metodo = 'POST'): LaravelValidator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\AcessibilidadeEleitoral\AcessibilidadeEleitoralAcessoRequest;
use App\Http\Requests\AcessibilidadeEleitoral\AcessibilidadeEleitoralRegistroRequest;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Validator as LaravelValidator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class AcessibilidadeEleitoralRequestsTest extends TestCase
{
    #[Test]
    public function acesso_normaliza_titulo_data_e_exige_turnstile(): void
    {
        $validator = $this->validator(AcessibilidadeEleitoralAcessoRequest::class, [
            'num_inscricao' => '123 456 789',
            'dt_nascimento' => '20/05/1990',
            'cf-turnstile-response' => 'token',
        ]);

        $this->assertFalse($validator->fails(), $validator->errors()->toJson());
        $this->assertSame('000123456789', $validator->validated()['num_inscricao']);
        $this->assertSame('1990-05-20', $validator->validated()['dt_nascimento']);

        $semDesafio = $this->validator(AcessibilidadeEleitoralAcessoRequest::class, [
            'num_inscricao' => '123456789', 'dt_nascimento' => '1990-05-20',
        ]);
        $this->assertTrue($semDesafio->errors()->has('cf-turnstile-response'));
    }

    #[Test]
    public function rascunho_aceita_campos_ausentes_mas_valida_o_que_foi_informado(): void
    {
        $parcial = $this->validator(AcessibilidadeEleitoralRegistroRequest::class, [
            'versao' => 0,
            'horario_inicial' => '07:00',
        ], 'PUT');
        $this->assertFalse($parcial->fails(), $parcial->errors()->toJson());

        $invalido = $this->validator(AcessibilidadeEleitoralRegistroRequest::class, [
            'versao' => 0,
            'total_atendido' => -1,
            'horario_inicial' => '18:00',
            'horario_final' => '07:00',
        ], 'PUT');
        $this->assertTrue($invalido->errors()->has('total_atendido'));
        $this->assertTrue($invalido->errors()->has('horario_final'));
    }

    /** @param class-string<FormRequest> $requestClass @param array<string, mixed> $dados */
    private function validator(string $requestClass, array $dados, string $metodo = 'POST'): LaravelValidator
    {
        $request = $requestClass::create('/teste', $metodo, $dados);
        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->invoke($request);
        $validator = Validator::make($request->all(), $request->rules(), $request->messages());
        if (method_exists($request, 'withValidator')) {
            $request->withValidator($validator);
        }

        return $validator;
    }
}
```
</TESTS_UNIT_ACESSIBILIDADEELEITORALREQUESTSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AcessibilidadeEleitoralSessionServiceTest.php`
## <TESTS_UNIT_ACESSIBILIDADEELEITORALSESSIONSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AcessibilidadeEleitoralSessionServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AcessibilidadeEleitoralSessionServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function sessao_termina_em_doze_horas_quando_a_janela_fica_aberta_por_mais_tempo(): void
public function sessao_termina_no_fechamento_quando_ele_ocorre_antes_de_doze_horas(): void
public function logout_remove_apenas_o_contexto_publico_e_preserva_a_sessao_interna(): void
private function requestComSessao(): Request
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\AcessibilidadeEleitoral\AcessibilidadeEleitoralSessionService;
use Carbon\CarbonImmutable;
use Illuminate\Http\Request;
use Illuminate\Session\ArraySessionHandler;
use Illuminate\Session\Store;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class AcessibilidadeEleitoralSessionServiceTest extends TestCase
{
    #[Test]
    public function sessao_termina_em_doze_horas_quando_a_janela_fica_aberta_por_mais_tempo(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-10-04 06:00:00', 'America/Rio_Branco'));
        $request = $this->requestComSessao();
        $service = new AcessibilidadeEleitoralSessionService;

        $service->iniciar($request, 41, 7, '000123456789', 'LOCAL-1', '2026-10-05 23:59:00');

        $this->assertSame(41, $service->coordenadorId($request));
        $this->assertSame(7, $service->turnoId($request));
        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-10-04 18:00:01', 'America/Rio_Branco'));
        $this->assertFalse($service->autenticado($request));

        CarbonImmutable::setTestNow();
    }

    #[Test]
    public function sessao_termina_no_fechamento_quando_ele_ocorre_antes_de_doze_horas(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-10-04 06:00:00', 'America/Rio_Branco'));
        $request = $this->requestComSessao();
        $service = new AcessibilidadeEleitoralSessionService;
        $service->iniciar($request, 41, 7, '000123456789', 'LOCAL-1', '2026-10-04 17:00:00');

        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-10-04 17:00:01', 'America/Rio_Branco'));
        $this->assertFalse($service->autenticado($request));

        CarbonImmutable::setTestNow();
    }

    #[Test]
    public function logout_remove_apenas_o_contexto_publico_e_preserva_a_sessao_interna(): void
    {
        $request = $this->requestComSessao();
        $request->session()->put('matchingGroups', ['PLANELEITO_ADMIN']);
        $service = new AcessibilidadeEleitoralSessionService;
        $service->iniciar($request, 41, 7, '000123456789', 'LOCAL-1', '2026-10-05 23:59:00');

        $service->encerrar($request);

        $this->assertNull($service->coordenadorId($request));
        $this->assertSame(['PLANELEITO_ADMIN'], $request->session()->get('matchingGroups'));
    }

    private function requestComSessao(): Request
    {
        $request = Request::create('/rotas-publicas/coordenador-acessibilidade/registro', 'GET');
        $request->setLaravelSession(new Store('array', new ArraySessionHandler(720)));

        return $request;
    }
}
```
</TESTS_UNIT_ACESSIBILIDADEELEITORALSESSIONSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AcessibilidadeEleitoralTurnstileServiceTest.php`
## <TESTS_UNIT_ACESSIBILIDADEELEITORALTURNSTILESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AcessibilidadeEleitoralTurnstileServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AcessibilidadeEleitoralTurnstileServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function falha_fechado_quando_acao_nao_corresponde_ao_fluxo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Acesso\TurnstileService;
use App\Services\AcessibilidadeEleitoral\AcessibilidadeEleitoralTurnstileService;
use Illuminate\Support\Facades\Http;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class AcessibilidadeEleitoralTurnstileServiceTest extends TestCase
{
    #[Test]
    public function falha_fechado_quando_acao_nao_corresponde_ao_fluxo(): void
    {
        config()->set('planeleito.acessibilidade_eleitoral.turnstile', [
            'site_key' => 'site-key-realista', 'secret_key' => 'segredo',
            'hostname' => 'planeleito.tre-ac.jus.br', 'timeout' => 3,
        ]);
        Http::fake(['challenges.cloudflare.com/*' => Http::response([
            'success' => true, 'action' => 'acao_incorreta', 'hostname' => 'planeleito.tre-ac.jus.br',
        ])]);

        $service = new AcessibilidadeEleitoralTurnstileService(new TurnstileService);
        $this->assertFalse($service->validar('token', '127.0.0.1'));
    }
}
```
</TESTS_UNIT_ACESSIBILIDADEELEITORALTURNSTILESERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/AcessibilidadeEleitoralContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_ACESSIBILIDADEELEITORALCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/AcessibilidadeEleitoralContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class AcessibilidadeEleitoralContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function persistencia_usa_auditoria_lock_versao_e_idempotencia(): void
public function relatorios_e_painel_forcam_estado_enviado_e_aplicam_escopo(): void
public function formulario_publico_nao_faz_autosave_nem_armazenamento_local_e_alerta_saida(): void
public function listagem_e_painel_oferecem_duas_colunas_modal_pdf_xlsx_e_graficos_locais(): void
public function acesso_publico_nao_possui_rate_limit_local_e_revalida_janela_e_atribuicao(): void
private function arquivo(string $caminho): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$inicio = strpos($rotas, "Route::prefix('/rotas-publicas/coordenador-acessibilidade')");
$fim = strpos($rotas, "Route::prefix('/operacoes-eleitorais/acessibilidade')", $inicio ?: 0);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class AcessibilidadeEleitoralContractTest extends TestCase
{
    #[Test]
    public function persistencia_usa_auditoria_lock_versao_e_idempotencia(): void
    {
        $repository = $this->arquivo('app/Repositories/AcessibilidadeEleitoral/AcessibilidadeEleitoralRegistroRepository.php');
        $this->assertStringContainsString('use AuditaDml', $repository);
        $this->assertStringContainsString('lockForUpdate()', $repository);
        $this->assertStringContainsString("->where('VERSAO', \$versaoAtual)", $repository);
        $this->assertStringContainsString('STATUS_ENVIADO', $repository);
        $this->assertStringContainsString('return $this->mapearCompleto($registro);', $repository);
        $this->assertStringContainsString("'CA_REGISTRO_HISTORICO'", $repository);

        $configuracao = $this->arquivo('app/Repositories/AcessibilidadeEleitoral/AcessibilidadeEleitoralConfiguracaoRepository.php');
        $this->assertStringContainsString("UPPER(TRIM(TIPO)) = 'ELEICAO'", $configuracao);
        $this->assertStringContainsString('lockForUpdate()', $configuracao);
        $this->assertStringContainsString('validarSobreposicaoPersistida', $configuracao);
    }

    #[Test]
    public function relatorios_e_painel_forcam_estado_enviado_e_aplicam_escopo(): void
    {
        $repository = $this->arquivo('app/Repositories/AcessibilidadeEleitoral/AcessibilidadeEleitoralConsultaRepository.php');
        $this->assertStringContainsString('STATUS_ENVIADO', $repository);
        $this->assertStringContainsString('$this->aplicarEscopo(', $repository);
        $this->assertStringContainsString('exportarEnviados', $repository);
        $this->assertStringContainsString('paginate($porPagina)', $repository);
        $this->assertStringContainsString('array_chunk($ids, 900)', $repository);
        $this->assertStringNotContainsString('ROWNUM', $repository);

        $controller = $this->arquivo('app/Http/Controllers/AcessibilidadeEleitoral/AcessibilidadeEleitoralAdminController.php');
        $this->assertStringContainsString('CamposPdfSelecionados::resolver', $controller);
        $this->assertStringContainsString('AcessibilidadeEleitoralRegistrosExport', $controller);
        $this->assertStringContainsString('autorizarRotaMacro', $controller);
        $this->assertStringContainsString('macroprojetoEleitoralExiste', $controller);
    }

    #[Test]
    public function formulario_publico_nao_faz_autosave_nem_armazenamento_local_e_alerta_saida(): void
    {
        $view = $this->arquivo('resources/views/acessibilidade-eleitoral/publico/registro.blade.php');
        $this->assertStringNotContainsString('localStorage', $view);
        $this->assertStringNotContainsString('sessionStorage', $view);
        $this->assertStringNotContainsString('setInterval', $view);
        $this->assertStringContainsString('beforeunload', $view);
        $this->assertStringContainsString("confirm('Enviar o registro definitivamente?", $view);
        $this->assertStringContainsString("confirm('Reabrir este registro?", $view);
        $this->assertStringNotContainsString('seção eleitoral', mb_strtolower($view, 'UTF-8'));
    }

    #[Test]
    public function listagem_e_painel_oferecem_duas_colunas_modal_pdf_xlsx_e_graficos_locais(): void
    {
        $lista = $this->arquivo('resources/views/acessibilidade-eleitoral/admin/index.blade.php');
        $this->assertStringContainsString('<th>Registro</th><th>Atendimento e ação</th>', $lista);
        $this->assertStringContainsString('modal-ca-pdf', $lista);
        $this->assertStringContainsString('registros.exportar-xlsx', $lista);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $lista);

        $painel = $this->arquivo('resources/views/acessibilidade-eleitoral/admin/painel.blade.php');
        $this->assertStringContainsString("asset('vendor/chartjs/chart.umd.min.js')", $painel);
        $this->assertStringContainsString('<table', $painel);
    }

    #[Test]
    public function acesso_publico_nao_possui_rate_limit_local_e_revalida_janela_e_atribuicao(): void
    {
        $rotas = $this->arquivo('routes/web.php');
        $inicio = strpos($rotas, "Route::prefix('/rotas-publicas/coordenador-acessibilidade')");
        $fim = strpos($rotas, "Route::prefix('/operacoes-eleitorais/acessibilidade')", $inicio ?: 0);
        $trecho = substr($rotas, (int) $inicio, (int) $fim - (int) $inicio);
        $this->assertStringNotContainsString('throttle:', $trecho);

        $service = $this->arquivo('app/Services/AcessibilidadeEleitoral/AcessibilidadeEleitoralAcessoService.php');
        $this->assertStringContainsString('buscarJanelaAbertaPorTurno', $service);
        $this->assertStringContainsString('buscarAtribuidoPublicoPorId', $service);
        $this->assertStringContainsString('local_codigo', $service);
    }

    private function arquivo(string $caminho): string
    {
        return (string) file_get_contents(dirname(__DIR__, 4).'/'.$caminho);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_ACESSIBILIDADEELEITORALCONTRACTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/CadastroEleitoralAgendamentoAdminRepositoryTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALAGENDAMENTOADMINREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/CadastroEleitoralAgendamentoAdminRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoAdminRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_salvar_funcionamento_criando_periodo_persiste_usuario_de_auditoria(): void
public function test_listagens_principais_do_agendamento_admin_nao_truncam_resultado_com_limit(): void
$this->assertStringContainsString('public function listarAgendamentos(array $filtros = []): array', $conteudo);
$this->assertStringContainsString('public function listarRelatorios(array $filtros = []): array', $conteudo);
$this->assertStringContainsString('public function listarRecepcao(array $filtros = []): array', $conteudo);
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoAdminRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralAgendamentoAdminRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);

        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')->zeroOrMoreTimes();
        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_salvar_funcionamento_criando_periodo_persiste_usuario_de_auditoria(): void
    {
        session([
            'user' => [
                'username' => 'teste_email',
                'name' => 'Teste Email',
            ],
        ]);

        DB::shouldReceive('transaction')
            ->twice()
            ->andReturnUsing(static function ($callback) {
                return $callback();
            });

        $builderConflito = Mockery::mock();
        $builderConflito->shouldReceive('where')->once()->with('id_unidade', 163)->andReturnSelf();
        $builderConflito->shouldReceive('whereRaw')->once()->with("TRUNC(data_funcionamento) = TO_DATE(?, 'YYYY-MM-DD')", ['2026-04-20'])->andReturnSelf();
        $builderConflito->shouldReceive('when')->once()->andReturnSelf();
        $builderConflito->shouldReceive('whereRaw')->once()->with('? < hora_fim', ['07:00'])->andReturnSelf();
        $builderConflito->shouldReceive('whereRaw')->once()->with('? > hora_inicio', ['14:00'])->andReturnSelf();
        $builderConflito->shouldReceive('exists')->once()->andReturnFalse();

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function ($payload) {
                return $payload['id_unidade'] === 163
                    && $payload['hora_inicio'] === '07:00'
                    && $payload['hora_fim'] === '14:00'
                    && $payload['usuario_criacao'] === 'teste_email'
                    && $payload['usuario_nome_criacao'] === 'Teste Email';
            }), 'id_funcionamento')
            ->andReturn(999);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_funcionamento', 999)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) ['id_funcionamento' => 999, 'id_unidade' => 163]);

        DB::shouldReceive('table')->once()->with('cad_funcionamento_unidade')->andReturn($builderConflito);
        DB::shouldReceive('table')->once()->with('cad_funcionamento_unidade')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('cad_funcionamento_unidade')->andReturn($builderDepois);

        $repository = new CadastroEleitoralAgendamentoAdminRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            app(\App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada::class),
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );

        $resultado = $repository->salvarFuncionamento([
            'id_unidade' => 163,
            'data_inicio' => '2026-04-20',
            'data_fim' => '2026-04-20',
            'hora_inicio' => '07:00',
            'hora_fim' => '14:00',
            'ativo' => 'S',
        ]);

        $this->assertSame('Período salvo com sucesso.', $resultado['mensagem']);
        $this->assertSame(999, $resultado['id_funcionamento']);
        $this->assertSame(1, $resultado['qtd_periodos']);
    }

    public function test_listagens_principais_do_agendamento_admin_nao_truncam_resultado_com_limit(): void
    {
        $conteudo = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralAgendamentoAdminRepository.php'));

        $this->assertIsString($conteudo);
        $this->assertStringNotContainsString('return $q->limit(200)->get()->map(static fn ($r) => (array) $r)->all();', $conteudo);
        $this->assertStringNotContainsString('return $q->limit(1000)->get()->map(static fn ($r) => (array) $r)->all();', $conteudo);
        $this->assertStringContainsString('public function listarAgendamentos(array $filtros = []): array', $conteudo);
        $this->assertStringContainsString('public function listarRelatorios(array $filtros = []): array', $conteudo);
        $this->assertStringContainsString('public function listarRecepcao(array $filtros = []): array', $conteudo);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALAGENDAMENTOADMINREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/CadastroEleitoralFilaCycleContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALFILACYCLECONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/CadastroEleitoralFilaCycleContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaCycleContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function repositorio_de_filas_usa_ciclo_na_duplicidade_e_na_ordenacao_da_chamada(): void
public function repositorio_de_filas_nao_reutiliza_registros_antigos_de_senha(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralFilaCycleContractTest extends TestCase
{
    #[Test]
    public function repositorio_de_filas_usa_ciclo_na_duplicidade_e_na_ordenacao_da_chamada(): void
    {
        $conteudo = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralFilaRepository.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("->where('ciclo_id', \$cicloResolvido)", $conteudo);
        $this->assertStringContainsString("'ciclo_id' => \$cicloResolvido", $conteudo);
        $this->assertStringContainsString("ORDER BY fp.peso DESC, fs.ciclo_id, fs.numero_senha, fs.dt_emissao", $conteudo);
    }

    #[Test]
    public function repositorio_de_filas_nao_reutiliza_registros_antigos_de_senha(): void
    {
        $conteudo = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralFilaRepository.php'));

        $this->assertIsString($conteudo);
        $this->assertStringNotContainsString('Senha existente nao encontrada.', $conteudo);
        $this->assertStringNotContainsString('ja_existia', $conteudo);
        $this->assertStringNotContainsString("->update([\n                        'id_servico' =>", $conteudo);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALFILACYCLECONTRACTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/CadastroEleitoralFilasContratoUiTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALFILASCONTRATOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/CadastroEleitoralFilasContratoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilasContratoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function controller_e_frontend_nao_referenciam_mais_contrato_de_idempotencia(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralFilasContratoUiTest extends TestCase
{
    #[Test]
    public function controller_e_frontend_nao_referenciam_mais_contrato_de_idempotencia(): void
    {
        $controller = file_get_contents(app_path('Http/Controllers/CadastroEleitoral/CadastroEleitoralFilasController.php'));
        $javascript = file_get_contents(public_path('js/cadastro-eleitoral-filas-triagem.js'));

        $this->assertIsString($controller);
        $this->assertIsString($javascript);
        $this->assertStringNotContainsString('ja_existia', $controller);
        $this->assertStringNotContainsString('já existente localizada', $controller);
        $this->assertStringNotContainsString('ja_existia', $javascript);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALFILASCONTRATOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/CadastroEleitoralUnidadeCapacidadesContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALUNIDADECAPACIDADESCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/CadastroEleitoralUnidadeCapacidadesContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralUnidadeCapacidadesContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function repositorios_filtram_unidades_pelas_flags_de_capacidade(): void
public function formulario_de_pesquisa_bloqueia_backend_para_unidade_sem_flag_habilitada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralUnidadeCapacidadesContractTest extends TestCase
{
    #[Test]
    public function repositorios_filtram_unidades_pelas_flags_de_capacidade(): void
    {
        $filas = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralFilaRepository.php'));
        $agendamentos = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralAgendamentoRepository.php'));
        $pesquisa = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralPesquisaSatisfacaoRepository.php'));

        $this->assertIsString($filas);
        $this->assertIsString($agendamentos);
        $this->assertIsString($pesquisa);
        $this->assertStringContainsString("->where('usa_filas', 'S')", $filas);
        $this->assertStringContainsString("->where('usa_agendamentos', 'S')", $agendamentos);
        $this->assertStringContainsString("->where('usa_pesquisa_satisfacao', 'S')", $pesquisa);
    }

    #[Test]
    public function formulario_de_pesquisa_bloqueia_backend_para_unidade_sem_flag_habilitada(): void
    {
        $controller = file_get_contents(app_path('Http/Controllers/CadastroEleitoral/CadastroEleitoralPesquisaSatisfacaoController.php'));
        $repository = file_get_contents(app_path('Repositories/CadastroEleitoral/CadastroEleitoralPesquisaSatisfacaoRepository.php'));

        $this->assertIsString($controller);
        $this->assertIsString($repository);
        $this->assertStringContainsString('unidadeHabilitadaParaPesquisa', $controller);
        $this->assertStringContainsString('ValidationException::withMessages', $controller);
        $this->assertStringContainsString('function unidadeHabilitadaParaPesquisa', $repository);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CADASTROELEITORALUNIDADECAPACIDADESCONTRACTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/CalendarioEleitoralAdminContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CALENDARIOELEITORALADMINCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/CalendarioEleitoralAdminContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class CalendarioEleitoralAdminContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_rotas_menu_e_acl_global_expoem_o_modulo_administrativo(): void
public function test_views_administrativas_contratam_responsividade_pdf_e_publicacao_em_lote(): void
public function test_repository_audita_dml_e_nao_descobre_contexto_http(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use Tests\TestCase;

class CalendarioEleitoralAdminContractTest extends TestCase
{
    public function test_rotas_menu_e_acl_global_expoem_o_modulo_administrativo(): void
    {
        $rotas = (string) file_get_contents(base_path('routes/web.php'));
        $menu = (string) file_get_contents(config_path('planeleito_menu.php'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/calendario-eleitoral-publico.md'));

        $this->assertStringContainsString('/rotas-publicas/calendario-eleitoral', $rotas);
        $this->assertStringContainsString('tabelas-auxiliares.calendario-eleitoral.eventos.index', $rotas);
        $this->assertStringContainsString("name('eventos.exportar-pdf')", $rotas);
        $this->assertStringContainsString("name('importacoes.previa')", $rotas);
        $this->assertStringContainsString("'label' => 'Calendário Eleitoral'", $menu);
        $this->assertStringContainsString('PLANELEITO_ADMIN', $contrato);
        $this->assertStringContainsString('wildcard global `*`', $contrato);
    }

    public function test_views_administrativas_contratam_responsividade_pdf_e_publicacao_em_lote(): void
    {
        $eventos = resource_path('views/tabelas-auxiliares/calendario-eleitoral/eventos/index.blade.php');
        $pleitos = resource_path('views/tabelas-auxiliares/calendario-eleitoral/pleitos/index.blade.php');
        $competencias = resource_path('views/tabelas-auxiliares/calendario-eleitoral/competencias/index.blade.php');

        foreach ([$eventos, $pleitos, $competencias] as $view) {
            $this->assertFileExists($view);
            $conteudo = (string) file_get_contents($view);
            $this->assertStringContainsString('table-responsive', $conteudo);
            $this->assertStringContainsString('Exportar para PDF', $conteudo);
            $this->assertStringContainsString("links('pagination::bootstrap-5')", $conteudo);
        }

        $conteudoEventos = (string) file_get_contents($eventos);
        $this->assertStringContainsString('publicacao-lote', $conteudoEventos);
        $this->assertStringContainsString('name="ids[]"', $conteudoEventos);
    }

    public function test_repository_audita_dml_e_nao_descobre_contexto_http(): void
    {
        $arquivo = app_path('Repositories/CalendarioEleitoral/CalendarioEleitoralRepository.php');
        $this->assertFileExists($arquivo);
        $conteudo = (string) file_get_contents($arquivo);

        $this->assertStringContainsString('use AuditaDml;', $conteudo);
        $this->assertStringNotContainsString('session(', $conteudo);
        $this->assertStringNotContainsString('request(', $conteudo);
        $this->assertStringNotContainsString('auth(', $conteudo);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CALENDARIOELEITORALADMINCONTRACTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralAdministracaoPaginationTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALADMINISTRACAOPAGINATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralAdministracaoPaginationTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class ColaboradorEleitoralAdministracaoPaginationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_paginacao_ajax_preserva_link_e_normaliza_protocolo_da_pagina_atual(): void
$this->assertStringContainsString('function ajustarEsquema(url)', $javascript);
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use Tests\TestCase;

class ColaboradorEleitoralAdministracaoPaginationTest extends TestCase
{
    public function test_paginacao_ajax_preserva_link_e_normaliza_protocolo_da_pagina_atual(): void
    {
        $javascript = (string) file_get_contents(
            public_path('js/colaboradores-eleitorais/administracao.js')
        );

        $this->assertStringContainsString('function ajustarEsquema(url)', $javascript);
        $this->assertStringContainsString('const destino = new URL(url, atual.origin);', $javascript);
        $this->assertStringContainsString('destino.protocol = atual.protocol;', $javascript);
        $this->assertStringContainsString(
            'const destino = ajustarEsquema(url || rotas.listar);',
            $javascript
        );
        $this->assertStringContainsString('const params = url ? {} : coletarFiltros();', $javascript);
        $this->assertStringContainsString("'#conteudo .pagination a'", $javascript);
        $this->assertStringContainsString('if (url) carregarLista(url);', $javascript);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALADMINISTRACAOPAGINATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralCandidaturasPaginationTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALCANDIDATURASPAGINATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralCandidaturasPaginationTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class ColaboradorEleitoralCandidaturasPaginationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_paginadores_ajax_preservam_o_link_e_normalizam_o_protocolo_da_pagina_atual(): void
$this->assertStringContainsString('function ajustarEsquema(url)', $javascript);
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use Tests\TestCase;

class ColaboradorEleitoralCandidaturasPaginationTest extends TestCase
{
    public function test_paginadores_ajax_preservam_o_link_e_normalizam_o_protocolo_da_pagina_atual(): void
    {
        $javascript = (string) file_get_contents(
            public_path('js/colaboradores-eleitorais/candidaturas.js')
        );

        $this->assertStringContainsString('function ajustarEsquema(url)', $javascript);
        $this->assertStringContainsString('const destino = new URL(url, atual.origin);', $javascript);
        $this->assertStringContainsString('destino.protocol = atual.protocol;', $javascript);
        $this->assertStringContainsString(
            'const destino = ajustarEsquema(url || rotas.processosListar);',
            $javascript
        );
        $this->assertStringContainsString(
            'const destino = ajustarEsquema(url || rotas.minhasListar);',
            $javascript
        );
        $this->assertStringContainsString("'#conteudoProcessos .pagination a'", $javascript);
        $this->assertStringContainsString('if (url) carregarProcessos(url);', $javascript);
        $this->assertStringContainsString("'#conteudoMinhasCandidaturas .pagination a'", $javascript);
        $this->assertStringContainsString('if (url) carregarMinhas(url);', $javascript);
        $this->assertStringContainsString("$('#conteudoProcessos').html(html);", $javascript);
        $this->assertStringContainsString("$('#conteudoMinhasCandidaturas').html(html);", $javascript);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALCANDIDATURASPAGINATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralControllerPermissoesTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALCONTROLLERPERMISSOESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralControllerPermissoesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralControllerPermissoesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringContainsString("DB::table('planeleito.vw_servidor')", $controller);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_form_bloqueia_quando_registro_esta_fora_do_escopo(): void
public function test_salvar_retorna_422_quando_unidade_gerente_nao_esta_no_escopo(): void
public function test_salvar_cria_registro_quando_unidade_e_subprojeto_estao_autorizados(): void
public function test_escopo_usuario_trata_escopo_irrestrito_como_admin(): void
public function test_colunas_exportacao_voluntarios_incluem_camisa_e_endereco_completo(): void
public function test_colunas_exportacao_mesarios_convocados_incluem_secao_funcao_e_vinculo_territorial(): void
public function test_normalizacao_do_xlsx_de_mesarios_remove_diacriticos_sem_alterar_os_demais_fluxos(): void
public function test_colunas_padrao_relatorio_deferidas_incluem_titulo_eleitoral(): void
public function test_normaliza_colunas_exportacao_relatorio_deferidas_aplica_whitelist_e_padrao(): void
public function test_pdf_relatorio_deferidas_renderiza_colunas_dinamicas_e_colspan_variavel(): void
public function test_titulo_eleitoral_do_relatorio_deferidas_prefere_vw_servidor(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ColaboradoresEleitorais\ColaboradorEleitoralController;
use App\Http\Requests\ColaboradoresEleitorais\ProcessoEleitoralRequest;
use App\Repositories\ColaboradoresEleitorais\Contracts\CandidaturaColaboradorRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ColaboradorEleitoralEscalaRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\EventoVoluntarioRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ProcessoEleitoralRepositoryInterface;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\ColaboradoresEleitorais\CandidaturaDecisaoService;
use App\Services\ColaboradoresEleitorais\ColaboradoresEleitoraisEscopoService;
use App\Services\EscopoUnidadeService;
use App\Support\EscopoUnidade;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Mockery;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class ColaboradorEleitoralControllerPermissoesTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_form_bloqueia_quando_registro_esta_fora_do_escopo(): void
    {
        $repository = Mockery::mock(ProcessoEleitoralRepositoryInterface::class);
        $repository->shouldReceive('buscar')
            ->once()
            ->with(7)
            ->andReturn((object) ['id' => 7]);
        $colaboradoresEscopo = Mockery::mock(ColaboradoresEleitoraisEscopoService::class);
        $colaboradoresEscopo->shouldReceive('processoEstaNoEscopo')
            ->once()
            ->with(7, [10], false)
            ->andReturnFalse();

        $controller = $this->novoController(
            repository: $repository,
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10])),
            colaboradoresEscopo: $colaboradoresEscopo
        );

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Ação de Trabalho fora do escopo permitido para este usuário.');

        $controller->form(7);
    }

    public function test_salvar_retorna_422_quando_unidade_gerente_nao_esta_no_escopo(): void
    {
        DB::shouldReceive('transaction')->never();

        $repository = Mockery::mock(ProcessoEleitoralRepositoryInterface::class);
        $colaboradoresEscopo = Mockery::mock(ColaboradoresEleitoraisEscopoService::class);
        $colaboradoresEscopo->shouldReceive('unidadeGerenteEstaNoEscopo')
            ->once()
            ->with(10, [20], false)
            ->andReturnFalse();

        $request = Mockery::mock(ProcessoEleitoralRequest::class);
        $request->shouldReceive('validated')
            ->once()
            ->andReturn([
                'NOME' => 'Processo',
                'UNIDADE_ID' => 10,
                'SUBPROJETO_ID' => 30,
            ]);

        $controller = $this->novoController(
            repository: $repository,
            escopo: $this->mockEscopo(EscopoUnidade::restrito([20])),
            colaboradoresEscopo: $colaboradoresEscopo
        );

        $response = $controller->salvar($request);

        $this->assertSame(422, $response->getStatusCode());
        $this->assertSame('Unidade gerente não autorizada para o escopo do usuário.', $response->getData(true)['mensagem']);
    }

    public function test_salvar_cria_registro_quando_unidade_e_subprojeto_estao_autorizados(): void
    {
        DB::shouldReceive('transaction')
            ->once()
            ->andReturnUsing(static function ($callback) {
                $callback();
                return null;
            });

        $repository = Mockery::mock(ProcessoEleitoralRepositoryInterface::class);
        $colaboradoresEscopo = Mockery::mock(ColaboradoresEleitoraisEscopoService::class);
        $colaboradoresEscopo->shouldReceive('unidadeGerenteEstaNoEscopo')
            ->once()
            ->with(10, [10], false)
            ->andReturnTrue();
        $colaboradoresEscopo->shouldReceive('subprojetoEstaNoEscopo')
            ->once()
            ->with(30, [10], false)
            ->andReturnTrue();
        $repository->shouldReceive('criar')
            ->once()
            ->with(Mockery::on(fn ($dados) => (bool) ($dados['ATIVO'] ?? false)));

        $request = Mockery::mock(ProcessoEleitoralRequest::class);
        $request->shouldReceive('validated')
            ->once()
            ->andReturn([
                'NOME' => 'Processo',
                'UNIDADE_ID' => 10,
                'SUBPROJETO_ID' => 30,
            ]);

        $controller = $this->novoController(
            repository: $repository,
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10])),
            colaboradoresEscopo: $colaboradoresEscopo
        );

        $response = $controller->salvar($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Ação de Trabalho criada com sucesso!', $response->getData(true)['mensagem']);
    }

    public function test_escopo_usuario_trata_escopo_irrestrito_como_admin(): void
    {
        $controller = $this->novoController(
            escopo: $this->mockEscopo(EscopoUnidade::irrestrito())
        );

        $resultado = $this->invocarMetodoPrivado($controller, 'escopoUsuario');

        $this->assertSame([true, null], $resultado);
    }

    public function test_colunas_exportacao_voluntarios_incluem_camisa_e_endereco_completo(): void
    {
        $controller = $this->novoController();

        $resultado = $this->invocarMetodoPrivado($controller, 'colunasExportacaoVoluntarios');

        $this->assertIsArray($resultado);
        $this->assertSame('Tamanho da Camisa', $resultado['tamanho_camisa'] ?? null);
        $this->assertSame('Endereco Completo', $resultado['endereco_completo'] ?? null);
    }

    public function test_colunas_exportacao_mesarios_convocados_incluem_secao_funcao_e_vinculo_territorial(): void
    {
        $controller = $this->novoController();

        $resultado = $this->invocarMetodoPrivado($controller, 'colunasExportacaoMesariosConvocados');
        $padrao = $this->invocarMetodoPrivado($controller, 'colunasExportacaoMesariosConvocadosPadrao');

        $this->assertIsArray($resultado);
        $this->assertSame('Secao', $resultado['num_secao'] ?? null);
        $this->assertSame('Funcao Eleitoral', $resultado['des_funcao_eleitoral'] ?? null);
        $this->assertSame(
            'Situação do vínculo territorial',
            $resultado['situacao_vinculo_territorial'] ?? null,
        );
        $this->assertContains('situacao_vinculo_territorial', $padrao);
    }

    public function test_normalizacao_do_xlsx_de_mesarios_remove_diacriticos_sem_alterar_os_demais_fluxos(): void
    {
        $controller = $this->novoController();
        $entrada = ' João Gonçalves &amp; Ñandú — 1º Mesário ';

        $resultadoMesarios = $this->invocarMetodoPrivado(
            $controller,
            'normalizarTextoExportacaoMesarios',
            [$entrada],
        );
        $resultadoGeral = $this->invocarMetodoPrivado(
            $controller,
            'normalizarTextoExportacao',
            [$entrada],
        );

        $this->assertSame('Joao Goncalves & Nandu - 1o Mesario', $resultadoMesarios);
        $this->assertSame('João Gonçalves & Ñandú — 1º Mesário', $resultadoGeral);
    }

    public function test_colunas_padrao_relatorio_deferidas_incluem_titulo_eleitoral(): void
    {
        $controller = $this->novoController();

        $resultado = $this->invocarMetodoPrivado($controller, 'colunasExportacaoRelatorioDeferidasPadrao');

        $this->assertContains('titulo_eleitoral', $resultado);
    }

    public function test_normaliza_colunas_exportacao_relatorio_deferidas_aplica_whitelist_e_padrao(): void
    {
        $controller = $this->novoController();

        $padrao = $this->invocarMetodoPrivado($controller, 'normalizarColunasExportacaoRelatorioDeferidas', [[]]);
        $selecionadas = $this->invocarMetodoPrivado($controller, 'normalizarColunasExportacaoRelatorioDeferidas', [[
            'nome_usuario',
            'campo_invalido',
            'titulo_eleitoral',
        ]]);

        $this->assertContains('titulo_eleitoral', $padrao);
        $this->assertSame(['nome_usuario', 'titulo_eleitoral'], $selecionadas);
    }

    public function test_pdf_relatorio_deferidas_renderiza_colunas_dinamicas_e_colspan_variavel(): void
    {
        $pdf = (string) file_get_contents(resource_path('views/colaboradores-eleitorais/relatorios/deferidas-pdf.blade.php'));

        $this->assertStringContainsString('$colunasSelecionadas', $pdf);
        $this->assertStringContainsString('$colunasDisponiveis', $pdf);
        $this->assertStringContainsString('colspan="{{ count($colunasSelecionadas) }}"', $pdf);
        $this->assertStringContainsString("@case('titulo_eleitoral')", $pdf);
    }

    public function test_titulo_eleitoral_do_relatorio_deferidas_prefere_vw_servidor(): void
    {
        $controller = (string) file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php'));

        $this->assertStringContainsString("DB::table('planeleito.vw_servidor')", $controller);
        $this->assertStringContainsString('num_tit_ele', $controller);
    }

    public function test_relatorio_deferidas_pdf_abre_modal_de_selecao_de_colunas(): void
    {
        $view = (string) file_get_contents(resource_path('views/colaboradores-eleitorais/relatorios.blade.php'));
        $js = (string) file_get_contents(public_path('js/colaboradores-eleitorais/relatorios.js'));

        $this->assertStringContainsString('id="btnPdfRelatorioDeferidas"', $view);
        $this->assertStringContainsString('data-bs-target="#modalExportarRelatorioDeferidas"', $view);
        $this->assertStringContainsString('data-tipo-exportacao="pdf"', $view);
        $this->assertStringContainsString('configurarModalExportacao', $js);
        $this->assertStringContainsString('rotas.pdfDeferidas', $js);
    }

    public function test_busca_titulo_eleitoral_na_api_servidor_envia_bearer_token_api_pessoa(): void
    {
        config(["services.api_pessoa.token" => "token-api-pessoa"]);

        Http::fake([
            "https://visao.tre-ac.jus.br/painel/view/api/servidor/index.php*" => Http::response([
                ["NUM_TIT_ELE" => "002266412453"],
            ]),
        ]);

        $controller = $this->novoController();

        $titulo = $this->invocarMetodoPrivado($controller, "buscarTituloEleitoralNaApiPorEmail", ["edcley@tre-ac.jus.br"]);

        $this->assertSame("002266412453", $titulo);
        Http::assertSent(static function ($request): bool {
            return $request->url() === "https://visao.tre-ac.jus.br/painel/view/api/servidor/index.php?e_mail=edcley%40tre-ac.jus.br"
                && $request->hasHeader("Authorization", "Bearer token-api-pessoa")
                && $request->hasHeader("Accept", "application/json");
        });
    }

    private function novoController(
        ?ProcessoEleitoralRepositoryInterface $repository = null,
        ?EscopoUnidadeService $escopo = null,
        ?ColaboradoresEleitoraisEscopoService $colaboradoresEscopo = null
    ): ColaboradorEleitoralController {
        return new ColaboradorEleitoralController(
            $repository ?? Mockery::mock(ProcessoEleitoralRepositoryInterface::class),
            Mockery::mock(CandidaturaColaboradorRepositoryInterface::class),
            Mockery::mock(ColaboradorEleitoralEscalaRepositoryInterface::class),
            $escopo ?? $this->mockEscopo(EscopoUnidade::restrito([10])),
            Mockery::mock(CandidaturaDecisaoService::class),
            $colaboradoresEscopo ?? Mockery::mock(ColaboradoresEleitoraisEscopoService::class),
            Mockery::mock(EventoVoluntarioRepositoryInterface::class),
            Mockery::mock(ZonaRepository::class)
        );
    }

    private function mockEscopo(EscopoUnidade $escopo): EscopoUnidadeService
    {
        $service = Mockery::mock(EscopoUnidadeService::class);
        $service->shouldReceive('escopoAtual')->andReturn($escopo);

        return $service;
    }

    /**
     * @param array<int, mixed> $args
     */
    private function invocarMetodoPrivado(object $instancia, string $metodo, array $args = []): mixed
    {
        $reflection = new \ReflectionMethod($instancia, $metodo);
        $reflection->setAccessible(true);

        return $reflection->invokeArgs($instancia, $args);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALCONTROLLERPERMISSOESTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralVoluntariosExternosControllerTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALVOLUNTARIOSEXTERNOSCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralVoluntariosExternosControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function listagem_permite_filtrar_apenas_voluntarios_selecionados_sem_escolher_acao_de_trabalho(): void
public function filtros_de_voluntarios_normalizam_multiplas_zonas_e_preservam_formato_legado(): void
public function fluxo_territorial_usa_zona_da_visao_eleitoral_que_tambem_fornece_o_municipio(): void
public function consulta_de_voluntarios_traz_local_de_voto_efetivo_com_alocacao_provisoria(): void
public function colunas_de_exportacao_de_voluntarios_incluem_local_de_voto_por_padrao(): void
public function colunas_de_exportacao_incluem_situacao_do_elo_por_padrao(): void
public function representacao_textual_do_local_de_voto_combina_nome_e_numero(): void
public function listagem_json_de_eventos_retorna_participantes_para_lazy_load(): void
public function busca_de_participantes_do_evento_exibe_o_nome_da_tabela_de_eleitor(): void
public function busca_de_participantes_por_usuario_restrito_filtra_zona_sem_consultar_origem_manual_na_view_externa(): void
public function colunas_padrao_do_pdf_de_eventos_incluem_participantes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ColaboradoresEleitorais\ColaboradorEleitoralController;
use App\Http\Requests\ColaboradoresEleitorais\VoluntariosExternosFiltroRequest;
use App\Repositories\ColaboradoresEleitorais\Contracts\CandidaturaColaboradorRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ColaboradorEleitoralEscalaRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\EventoVoluntarioRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ProcessoEleitoralRepositoryInterface;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\ColaboradoresEleitorais\CandidaturaDecisaoService;
use App\Services\ColaboradoresEleitorais\ColaboradoresEleitoraisEscopoService;
use App\Services\EscopoUnidadeService;
use App\Support\EscopoUnidade;
use Barryvdh\DomPDF\Facade\Pdf;
use Barryvdh\DomPDF\PDF as DomPdfWrapper;
use Dompdf\Canvas;
use Dompdf\FontMetrics;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use ReflectionMethod;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function listagem_permite_filtrar_apenas_voluntarios_selecionados_sem_escolher_acao_de_trabalho(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = VoluntariosExternosFiltroRequest::create('/colaboradores-eleitorais/externos/voluntarios?selecao=selecionados', 'GET');
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $voluntario = (object) [
            'id' => 10,
            'nome_civil' => 'VOLUNTARIO TESTE',
            'nome_social' => null,
            'profissao' => 'SERVIDOR',
            'num_cpf' => '12345678900',
            'num_inscricao' => '000111222333',
            'num_zona' => '1',
            'data_nasc' => '01/01/1990',
            'email' => 'voluntario@teste.gov.br',
            'telefone' => '(68) 99999-9999',
            'status' => 'ATIVO',
            'tamanho_camisa' => 'M',
            'endereco_completo' => 'Rua A',
            'perfil_codigo' => 'MES',
            'perfil_nome' => 'MESARIO',
            'experiencias_anteriores' => 'SIM',
            'autorizacao_disponibilidade' => 'SIM',
            'localidade' => 'RIO BRANCO',
            'cod_objeto_local_voto' => 'LOCAL-1',
            'qtd_rotas_alocadas' => 0,
            'rotas_alocadas' => null,
            'qtd_eventos' => 2,
        ];

        $paginator = new LengthAwarePaginator([$voluntario], 1, 20, 1, [
            'path' => $request->url(),
            'query' => $request->query(),
        ]);

        $consultaAlocacoes = Mockery::mock();
        $consultaAlocacoes->shouldReceive('join')->times(9)->andReturnSelf();
        $consultaAlocacoes->shouldReceive('selectRaw')->times(3)->andReturnSelf();
        $consultaAlocacoes->shouldReceive('groupByRaw')->times(3)->andReturnSelf();
        $consultaAlocacoes->shouldReceive('whereRaw')->twice()->andReturnSelf();

        $consultaDetalhesRotas = Mockery::mock();
        $consultaDetalhesRotas->shouldReceive('fromSub')->once()->with($consultaAlocacoes, 'AR')->andReturnSelf();
        $consultaDetalhesRotas->shouldReceive('leftJoinSub')->once()->with(
            $consultaAlocacoes,
            'ARV',
            Mockery::type(\Closure::class)
        )->andReturnSelf();
        $consultaDetalhesRotas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaDetalhesRotas->shouldReceive('get')->once()->andReturn(collect());

        $consultaPrincipal = Mockery::mock(\Illuminate\Database\Query\Builder::class);
        $consultaPrincipal->shouldReceive('join')->once()->andReturnSelf();
        $consultaPrincipal->shouldReceive('leftJoin')->times(4)->andReturnSelf();
        $consultaPrincipal->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaPrincipal->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaPrincipal->shouldReceive('leftJoinSub')->once()->andReturnSelf();
        $consultaPrincipal->shouldReceive('whereNotIn')->once()->andReturnSelf();
        $consultaPrincipal->shouldReceive('addSelect')->once()->andReturnSelf();
        $consultaPrincipal->shouldReceive('whereExists')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $consultaPrincipal->shouldReceive('paginate')
            ->once()
            ->with(20, ['*'], 'page', null, 1)
            ->andReturn($paginator);

        $consultaDashboard = Mockery::mock(\Illuminate\Database\Query\Builder::class);
        $consultaDashboard->shouldReceive('join')->once()->andReturnSelf();
        $consultaDashboard->shouldReceive('leftJoin')->never();
        $consultaDashboard->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaDashboard->shouldReceive('leftJoinSub')->once()->andReturnSelf();
        $consultaDashboard->shouldReceive('whereNotIn')->once()->andReturnSelf();
        $consultaDashboard->shouldReceive('whereExists')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $consultaDashboard->shouldReceive('groupByRaw')->once()->andReturnSelf();
        $consultaDashboard->shouldReceive('get')->once()->andReturn(collect([
            (object) ['dimensao' => 'total', 'rotulo' => null, 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'tamanho', 'rotulo' => 'M', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'zona', 'rotulo' => '1', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'municipio', 'rotulo' => 'RIO BRANCO', 'total' => 1, 'alocados' => 0],
        ]));

        $subqueryParticipantes = Mockery::mock();
        $subqueryParticipantes->shouldReceive('selectRaw')->once()->andReturnSelf();
        $subqueryParticipantes->shouldReceive('groupByRaw')->once()->andReturnSelf();

        $consultaSituacaoElo = Mockery::mock();
        $consultaSituacaoElo->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaSituacaoElo->shouldReceive('whereIn')->once()->andReturnSelf();
        $consultaSituacaoElo->shouldReceive('whereNotNull')->once()->andReturnSelf();

        $consultaSituacaoPriorizada = Mockery::mock();
        $consultaSituacaoPriorizada->shouldReceive('fromSub')
            ->once()
            ->with($consultaSituacaoElo, 'CME_RECONHECIDA')
            ->andReturnSelf();
        $consultaSituacaoPriorizada->shouldReceive('selectRaw')->once()->andReturnSelf();

        $consultaSituacaoAgregada = Mockery::mock();
        $consultaSituacaoAgregada->shouldReceive('fromSub')
            ->once()
            ->with($consultaSituacaoPriorizada, 'CME_PRIORIZADA')
            ->andReturnSelf();
        $consultaSituacaoAgregada->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaSituacaoAgregada->shouldReceive('whereColumn')->once()->andReturnSelf();
        $consultaSituacaoAgregada->shouldReceive('groupByRaw')->once()->andReturnSelf();
        $consultaSituacaoAgregada->shouldReceive('whereRaw')->once()->andReturnSelf();
        $consultaSituacaoAgregada->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'num_inscricao' => '000111222333',
                'situacao_mesario_elo' => 'Convocado',
                'funcoes_mesario_elo' => 'Presidente',
            ],
        ]));

        $consultaStatusPerfil = Mockery::mock();
        $consultaStatusPerfil->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaStatusPerfil->shouldReceive('groupByRaw')->once()->andReturnSelf();
        $consultaStatusPerfil->shouldReceive('get')->once()->andReturn(collect([
            (object) ['dimensao' => 'status', 'valor' => 'ATIVO'],
            (object) ['dimensao' => 'perfil', 'valor' => 'MESARIO'],
        ]));

        $consultaEscolaridades = Mockery::mock(\Illuminate\Database\Query\Builder::class);
        $consultaEscolaridades->shouldReceive('join')->once()->andReturnSelf();
        $consultaEscolaridades->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaEscolaridades->shouldReceive('whereNotNull')->once()->with('V.ESCOLARIDADE')->andReturnSelf();
        $consultaEscolaridades->shouldReceive('whereNotIn')->once()->andReturnSelf();
        $consultaEscolaridades->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaEscolaridades->shouldReceive('orderBy')->once()->with('escolaridade')->andReturnSelf();
        $consultaEscolaridades->shouldReceive('pluck')->once()->with('escolaridade')->andReturn(collect(['MÉDIO COMPLETO']));

        $consultaZonas = Mockery::mock();
        $consultaZonas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('whereNotNull')->once()->with('EV.NUM_ZONA')->andReturnSelf();
        $consultaZonas->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('orderBy')->once()->with('num_zona')->andReturnSelf();
        $consultaZonas->shouldReceive('pluck')->once()->with('num_zona')->andReturn(collect(['1']));

        $consultaMunicipios = Mockery::mock();
        $consultaMunicipios->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('whereNotNull')->once()->with('EV.NUM_ZONA')->andReturnSelf();
        $consultaMunicipios->shouldReceive('whereNotNull')->once()->with('EV.LOCALIDADE')->andReturnSelf();
        $consultaMunicipios->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('orderBy')->twice()->andReturnSelf();
        $consultaMunicipios->shouldReceive('get')->once()->andReturn(collect([
            (object) ['num_zona' => '1', 'localidade' => 'RIO BRANCO'],
        ]));

        $consultaLocaisVoto = Mockery::mock();
        $consultaLocaisVoto->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaLocaisVoto->shouldReceive('whereNotNull')->once()->with('lv.cod_objeto')->andReturnSelf();
        $consultaLocaisVoto->shouldReceive('orderByRaw')->times(4)->andReturnSelf();
        $consultaLocaisVoto->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'id' => 'LOCAL-1',
                'texto' => '1 - RIO BRANCO - ESCOLA TESTE (Local 100)',
            ],
        ]));

        DB::shouldReceive('table')->times(3)->with('EQUIPE as EQR')->andReturn($consultaAlocacoes);
        DB::shouldReceive('query')->times(3)->andReturn(
            $consultaDetalhesRotas,
            $consultaSituacaoPriorizada,
            $consultaSituacaoAgregada
        );
        DB::shouldReceive('table')
            ->twice()
            ->with('VW_VOLUNTARIO_PERFIL_EFETIVO as v')
            ->andReturn($consultaDashboard, $consultaPrincipal);
        DB::shouldReceive('table')->once()->with('planeleito.cad_convocacao_mesario_tse as CME')->andReturn($consultaSituacaoElo);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn($subqueryParticipantes);
        DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_PERFIL_EFETIVO as V')->andReturn($consultaStatusPerfil);
        DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_PERFIL_EFETIVO as V')->andReturn($consultaEscolaridades);
        DB::shouldReceive('table')->once()->with('planeleito.vw_eleitor_secao_zona_localidade as EV')->andReturn($consultaZonas);
        DB::shouldReceive('table')->once()->with('planeleito.vw_eleitor_secao_zona_localidade as EV')->andReturn($consultaMunicipios);
        DB::shouldReceive('table')->once()->with('planeleito.vw_locais_votacao_efetivos as lv')->andReturn($consultaLocaisVoto);
        DB::shouldReceive('raw')->andReturnUsing(static fn ($value) => $value);

        $controller = $this->novoControllerRestrito();

        $view = $controller->voluntariosExternos($request);

        $this->assertInstanceOf(View::class, $view);
        $this->assertSame('colaboradores-eleitorais.externos.voluntarios.index', $view->name());

        $dados = $view->getData();
        $this->assertSame($paginator, $dados['voluntarios']);
        $this->assertSame(1, $dados['voluntarios']->total());
        $this->assertSame(20, $dados['voluntarios']->perPage());
        $this->assertSame(1, $dados['voluntarios']->currentPage());
        $this->assertSame('selecionados', $dados['filtros']['selecao'] ?? null);
        $this->assertSame('nome', $dados['filtros']['modo_busca'] ?? null);
        $this->assertSame('', $dados['filtros']['alocacao_rota'] ?? null);
        $this->assertSame('', $dados['filtros']['cod_objeto_local_voto'] ?? null);
        $this->assertSame(['MÉDIO COMPLETO'], $dados['escolaridadesDisponiveis']->all());
        $this->assertSame('LOCAL-1', $dados['locaisVotoDisponiveis']->first()->id ?? null);
        $this->assertCount(1, $dados['voluntarios']->items());
        $this->assertSame(2, $dados['voluntarios']->items()[0]->qtd_eventos);
        $this->assertSame('0', $dados['voluntarios']->items()[0]->qtd_rotas_alocadas);
        $this->assertSame('0', $dados['voluntarios']->items()[0]->rota_contem_local_voto);
        $this->assertSame('Convocado', $dados['voluntarios']->items()[0]->situacao_mesario_elo);
        $this->assertSame('Presidente', $dados['voluntarios']->items()[0]->funcoes_mesario_elo);
        $this->assertSame(1, $dados['dashboardVoluntarios']['total_filtrado'] ?? null);
        $this->assertSame(0, $dados['dashboardVoluntarios']['alocados_em_rotas'] ?? null);
        $this->assertSame(1, $dados['dashboardVoluntarios']['nao_alocados'] ?? null);
        $this->assertSame([['label' => 'M', 'total' => 1]], $dados['dashboardVoluntarios']['camisas_por_tamanho'] ?? null);
    }

    #[Test]
    public function filtros_de_voluntarios_normalizam_multiplas_zonas_e_preservam_formato_legado(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'normalizarFiltrosVoluntariosExternos');
        $metodo->setAccessible(true);

        $requestMultiplas = Request::create('/colaboradores-eleitorais/externos/voluntarios', 'GET', [
            'zona' => ['2', '10', '2', ''],
        ]);
        $filtrosMultiplas = $metodo->invoke($controller, $requestMultiplas, []);

        $requestLegado = Request::create('/colaboradores-eleitorais/externos/voluntarios?zona=3', 'GET');
        $filtrosLegado = $metodo->invoke($controller, $requestLegado, []);

        $this->assertSame(['2', '10'], $filtrosMultiplas['zona'] ?? null);
        $this->assertSame(['3'], $filtrosLegado['zona'] ?? null);
    }

    #[Test]
    public function fluxo_territorial_usa_zona_da_visao_eleitoral_que_tambem_fornece_o_municipio(): void
    {
        $conteudo = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoConsultaQuery.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ev.num_zona,', $conteudo);
        $this->assertStringContainsString('TRIM(NVL(ev.num_zona', $conteudo);
        $this->assertDoesNotMatchRegularExpression('/(?<![Ee])\b[vV]\.num_zona/', $conteudo);
    }

    #[Test]
    public function consulta_de_voluntarios_traz_local_de_voto_efetivo_com_alocacao_provisoria(): void
    {
        $conteudo = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoConsultaQuery.php'));

        $this->assertIsString($conteudo);

        // joins eleitorais para alcancar o local efetivo de votacao do voluntario
        $this->assertStringContainsString("leftJoin('planeleito.eleitor as e'", $conteudo);
        $this->assertStringContainsString("leftJoin('planeleito.secoes as s'", $conteudo);
        $this->assertStringContainsString("leftJoin('planeleito.secao_alocacao_provisoria as sap_voto'", $conteudo);
        $this->assertStringContainsString("leftJoin(LocalVotacaoCatalogo::EFETIVOS.' as lv_voto'", $conteudo);
        $this->assertStringContainsString('s.cod_objeto = e.cod_objeto_secao', $conteudo);
        $this->assertStringContainsString('sap_voto.cod_objeto_secao = s.cod_objeto', $conteudo);
        $this->assertStringContainsString(
            'NVL(TRIM(sap_voto.cod_objeto_local_provisorio), TRIM(s.cod_objeto_local))',
            $conteudo
        );
        $this->assertStringContainsString('TRIM(lv_voto.cod_objeto) = {$localVotoEfetivo}', $conteudo);

        // nome, numero e codigo usam o mesmo local efetivo na consulta compartilhada
        $this->assertStringContainsString('lv_voto.nom_local) as nom_local_voto', $conteudo);
        $this->assertStringContainsString('TO_CHAR(lv_voto.num_local)) as num_local_voto', $conteudo);
        $this->assertStringContainsString('{$localVotoEfetivo} as cod_objeto_local_voto', $conteudo);
        $this->assertStringContainsString('TRIM(ARV.COD_OBJETO_LOCAL) = {$localVotoEfetivo}', $conteudo);

        // busca textual considera nome e numero do local de voto
        $this->assertStringContainsString("UPPER(NVL(lv_voto.nom_local, '')) LIKE", $conteudo);
        $this->assertStringContainsString('TRIM(TO_CHAR(lv_voto.num_local)) LIKE', $conteudo);
    }

    #[Test]
    public function colunas_de_exportacao_de_voluntarios_incluem_local_de_voto_por_padrao(): void
    {
        $controller = $this->novoControllerIrrestrito();

        $metodoDisponiveis = new ReflectionMethod($controller, 'colunasExportacaoVoluntarios');
        $metodoDisponiveis->setAccessible(true);
        $metodoPadrao = new ReflectionMethod($controller, 'colunasExportacaoVoluntariosPadrao');
        $metodoPadrao->setAccessible(true);

        $colunasDisponiveis = $metodoDisponiveis->invoke($controller);
        $colunasPadrao = $metodoPadrao->invoke($controller);

        $this->assertSame('Local de Votacao', $colunasDisponiveis['local_voto'] ?? null);
        $this->assertContains('local_voto', $colunasPadrao);
    }

    #[Test]
    public function colunas_de_exportacao_incluem_situacao_do_elo_por_padrao(): void
    {
        $controller = $this->novoControllerIrrestrito();

        $metodoDisponiveis = new ReflectionMethod($controller, 'colunasExportacaoVoluntarios');
        $metodoDisponiveis->setAccessible(true);
        $metodoPadrao = new ReflectionMethod($controller, 'colunasExportacaoVoluntariosPadrao');
        $metodoPadrao->setAccessible(true);

        $colunasDisponiveis = $metodoDisponiveis->invoke($controller);
        $colunasPadrao = $metodoPadrao->invoke($controller);

        $this->assertSame('Situação no ELO', $colunasDisponiveis['situacao_mesario_elo'] ?? null);
        $this->assertContains('situacao_mesario_elo', $colunasPadrao);
    }

    #[Test]
    public function representacao_textual_do_local_de_voto_combina_nome_e_numero(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'formatarLocalVotoExportacao');
        $metodo->setAccessible(true);

        $this->assertSame('ESCOLA TESTE (nº 42)', $metodo->invoke($controller, 'ESCOLA TESTE', '42'));
        $this->assertSame('ESCOLA TESTE', $metodo->invoke($controller, 'ESCOLA TESTE', ''));
        $this->assertSame('', $metodo->invoke($controller, '', ''));
    }

    #[Test]
    public function listagem_json_de_eventos_retorna_participantes_para_lazy_load(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios.eventos.listar'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/voluntarios/eventos/listar?modo=participantes&evento_id=55&zona_trabalho_id=1', 'GET', [
            'modo' => 'participantes',
            'evento_id' => 55,
            'zona_trabalho_id' => 1,
        ]);
        $request->headers->set('Accept', 'application/json');
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios.eventos.listar');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $consultaEventos = Mockery::mock();
        $consultaEventos->shouldReceive('join')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('orderByRaw')->twice()->andReturnSelf();
        $consultaEventos->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'id' => 55,
                'processo_eleitoral_id' => 321,
                'nome' => 'Treinamento Capital',
                'local' => 'SEDE',
                'atividade' => 'Treinamento',
                'status_codigo' => 'ATIVO',
                'processo_nome' => 'Ação Teste',
            ],
        ]));

        $consultaAgendas = Mockery::mock();
        $consultaAgendas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaAgendas->shouldReceive('whereIn')->once()->with('EA.EVENTO_ID', [55])->andReturnSelf();
        $consultaAgendas->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $consultaAgendas->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'evento_id' => 55,
                'dt_inicio' => '2026-06-10T08:00',
                'dt_fim' => '2026-06-10T10:00',
                'dt_inicio_formatado' => '10/06/2026 08:00',
                'dt_fim_formatado' => '10/06/2026 10:00',
            ],
        ]));

        $consultaParticipantes = Mockery::mock();
        $consultaParticipantes->shouldReceive('leftJoin')
            ->once()
            ->with('CAD_SUPERVISOR_PREDIO as CSP', Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consultaParticipantes->shouldReceive('leftJoin')->times(3)->andReturnSelf();
        $consultaParticipantes->shouldReceive('selectRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains(
                $sql,
                'NVL(EV.NOM_ELEITOR, NVL(V.NOME_SOCIAL, NVL(V.NOME_CIVIL, CSP.NOME_SUPERVISOR))) as nome_eleitor'
            )))
            ->andReturnSelf();
        $consultaParticipantes->shouldReceive('where')->once()->with('EVP.EVENTO_ID', 55)->andReturnSelf();
        $consultaParticipantes->shouldReceive('where')->once()->with('EVP.ZONA_TRABALHO_ID', 1)->andReturnSelf();
        $consultaParticipantes->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaParticipantes->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'nome_eleitor' => 'SUPERVISORA INTERNA',
                'num_inscricao' => '000111222333',
                'num_zona' => null,
                'zona_trabalho_id' => 1,
                'num_zona_trabalho' => '1',
                'descricao_zona_trabalho' => 'Primeira Zona',
                'perfil_nome' => '',
                'status' => '',
                'email' => '',
                'telefone' => '',
                'localidade' => '',
            ],
        ]));

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO as EV')->andReturn($consultaEventos);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_AGENDA as EA')->andReturn($consultaAgendas);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn($consultaParticipantes);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscar')->once()->with(1)->andReturn((object) ['id' => 1]);
        $controller = $this->novoControllerIrrestrito(null, [], $zonaRepository);

        $response = $controller->listarEventosVoluntariosExternos($request);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $dados = $response->getData(true);
        $this->assertCount(1, $dados['participantes'] ?? []);
        $this->assertSame('000111222333', $dados['participantes'][0]['num_inscricao'] ?? null);
        $this->assertSame('SUPERVISORA INTERNA', $dados['participantes'][0]['nome_exibicao'] ?? null);
        $this->assertSame('', $dados['participantes'][0]['zona_voto'] ?? null);
        $this->assertSame(1, $dados['participantes'][0]['zona_trabalho_id'] ?? null);
        $this->assertSame('1', $dados['participantes'][0]['zona_trabalho_numero'] ?? null);
    }

    #[Test]
    public function busca_de_participantes_do_evento_exibe_o_nome_da_tabela_de_eleitor(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = VoluntariosExternosFiltroRequest::create('/colaboradores-eleitorais/externos/voluntarios', 'GET', [
            'modo' => 'buscar-participantes-evento',
            'q' => 'Ana',
        ]);
        $request->headers->set('Accept', 'application/json');
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $consulta = Mockery::mock();
        $consulta->shouldReceive('join')->once()->andReturnSelf();
        $consulta->shouldReceive('selectRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains(
                $sql,
                'NVL(EV.NOM_ELEITOR, NVL(V.NOME_SOCIAL, V.NOME_CIVIL)) as nome_eleitor'
            )))
            ->andReturnSelf();
        $consulta->shouldReceive('where')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $consulta->shouldReceive('orderByRaw')
            ->once()
            ->with('UPPER(NVL(EV.NOM_ELEITOR, V.NUM_INSCRICAO))')
            ->andReturnSelf();
        $consulta->shouldReceive('limit')->once()->with(20)->andReturnSelf();
        $consulta->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'nome_eleitor' => 'ANA ELEITORAL',
                'nome_civil' => 'ANA VOLUNTÁRIA',
                'nome_social' => 'ANA SOCIAL',
                'num_inscricao' => '000111222333',
                'num_zona' => '9',
                'perfil_nome' => 'SUPORTE TÉCNICO',
                'status' => 'ATIVO',
                'telefone' => '(68) 99999-0001',
                'localidade' => 'RIO BRANCO',
            ],
        ]));

        DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_PERFIL_EFETIVO as V')->andReturn($consulta);

        $response = $this->novoControllerIrrestrito()->voluntariosExternos($request);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $dados = $response->getData(true);
        $this->assertSame('ANA ELEITORAL', $dados[0]['text'] ?? null);
        $this->assertSame('ANA ELEITORAL', $dados[0]['nome'] ?? null);
        $this->assertSame('9', $dados[0]['zona_voto'] ?? null);
        $this->assertNotSame('ANA VOLUNTÁRIA', $dados[0]['nome'] ?? null);
        $this->assertNotSame('ANA SOCIAL', $dados[0]['nome'] ?? null);
    }

    #[Test]
    public function busca_de_participantes_por_usuario_restrito_filtra_zona_sem_consultar_origem_manual_na_view_externa(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios'],
            'acesso_todas_zonas' => false,
            'cod_zonas_permitidas' => [3],
        ]);

        $request = VoluntariosExternosFiltroRequest::create('/colaboradores-eleitorais/externos/voluntarios', 'GET', [
            'modo' => 'buscar-participantes-evento',
            'q' => 'Ana',
        ]);
        $request->headers->set('Accept', 'application/json');
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $consultaZonas = Mockery::mock();
        $consultaZonas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('whereIn')->once()->with('id', [3])->andReturnSelf();
        $consultaZonas->shouldReceive('orWhereIn')->once()->with('num_zona', [3])->andReturnSelf();
        $consultaZonas->shouldReceive('pluck')->once()->with('num_zona')->andReturn(collect(['3']));

        $consulta = Mockery::mock();
        $consulta->shouldReceive('join')->once()->andReturnSelf();
        $consulta->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('where')
            ->once()
            ->with(Mockery::type(\Closure::class))
            ->ordered()
            ->andReturnSelf();
        $consulta->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('limit')->once()->with(20)->andReturnSelf();
        $consulta->shouldReceive('whereIn')
            ->once()
            ->with('zona_eleitoral_normalizada', ['3'])
            ->andReturnSelf();
        $consulta->shouldNotReceive('orWhere');
        $consulta->shouldNotReceive('orWhereRaw');
        $consulta->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'nome_eleitor' => 'ANA ELEITORAL',
                'num_inscricao' => '000111222333',
                'num_zona' => '3',
                'perfil_nome' => 'SUPORTE TÉCNICO',
                'status' => 'ATIVO',
                'telefone' => '(68) 99999-0001',
                'localidade' => 'SENA MADUREIRA',
            ],
        ]));

        DB::shouldReceive('table')->once()->with('zona')->andReturn($consultaZonas);
        DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_PERFIL_EFETIVO as V')->andReturn($consulta);
        DB::shouldReceive('raw')
            ->once()
            ->with("TRIM(NVL(EV.NUM_ZONA, ''))")
            ->andReturn('zona_eleitoral_normalizada');

        $response = $this->novoControllerIrrestrito()->voluntariosExternos($request);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $dados = $response->getData(true);
        $this->assertSame('ANA ELEITORAL', $dados[0]['nome'] ?? null);
        $this->assertSame('3', $dados[0]['zona_voto'] ?? null);
    }

    #[Test]
    public function colunas_padrao_do_pdf_de_eventos_incluem_participantes(): void
    {
        $controller = $this->novoControllerIrrestrito();

        $metodoDisponiveis = new ReflectionMethod($controller, 'colunasExportacaoEventosVoluntarios');
        $metodoDisponiveis->setAccessible(true);
        $metodoPadrao = new ReflectionMethod($controller, 'colunasPadraoExportacaoEventosVoluntarios');
        $metodoPadrao->setAccessible(true);

        $colunasDisponiveis = $metodoDisponiveis->invoke($controller);
        $colunasPadrao = $metodoPadrao->invoke($controller);

        $this->assertSame('Participantes', $colunasDisponiveis['participantes_resumo'] ?? null);
        $this->assertContains('participantes_resumo', $colunasPadrao);
    }

    #[Test]
    public function pdf_ordena_eventos_de_cada_acao_pela_primeira_agenda(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'ordenarEventosPdfPorPrimeiraAgenda');
        $metodo->setAccessible(true);

        $eventos = collect([
            $this->eventoParaOrdenacaoPdf(55, 321, 'Evento posterior', '2026-08-20T08:00'),
            $this->eventoParaOrdenacaoPdf(77, 321, 'Evento sem agenda', null),
            $this->eventoParaOrdenacaoPdf(67, 321, 'Evento próximo', '2026-08-10T08:00'),
            $this->eventoParaOrdenacaoPdf(66, 321, 'Evento próximo', '2026-08-10T08:00'),
            $this->eventoParaOrdenacaoPdf(80, 322, 'Outra ação', '2026-07-01T08:00'),
        ]);

        $ordenados = $metodo->invoke($controller, $eventos);

        $this->assertSame([66, 67, 55, 77, 80], $ordenados->pluck('id')->all());
    }

    #[Test]
    public function controller_entrega_pdf_inline_para_exibicao_na_nova_aba(): void
    {
        $conteudo = file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString(
            "->stream('relatorio-eventos-voluntarios-externos.pdf')",
            $conteudo
        );
    }

    #[Test]
    public function pdf_de_eventos_envia_zona_eleitoral_e_numera_cabecalho_e_rodape(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios.eventos.exportar.pdf'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/voluntarios/eventos/exportar-pdf', 'GET', [
            'colunas' => ['nome', 'agendas_resumo', 'participantes_resumo'],
            'processo_eleitoral_id' => 321,
            'evento_ids' => [55],
            'zona_trabalho_id' => 1,
        ]);
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios.eventos.exportar.pdf');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $consultaStatus = Mockery::mock();
        $consultaStatus->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaStatus->shouldReceive('orderBy')->once()->with('CODIGO')->andReturnSelf();
        $consultaStatus->shouldReceive('pluck')->once()->with('codigo')->andReturn(collect(['ATIVO', 'DESATIVO']));

        $consultaEventos = Mockery::mock();
        $consultaEventos->shouldReceive('join')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('orderByRaw')->twice()->andReturnSelf();
        $consultaEventos->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'id' => 55,
                'processo_eleitoral_id' => 321,
                'nome' => 'Treinamento Capital',
                'local' => 'SEDE',
                'atividade' => 'Treinamento',
                'status_codigo' => 'ATIVO',
                'processo_nome' => 'Ação Capital',
            ],
        ]));

        $consultaAgendas = Mockery::mock();
        $consultaAgendas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaAgendas->shouldReceive('whereIn')->once()->with('EA.EVENTO_ID', [55])->andReturnSelf();
        $consultaAgendas->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $consultaAgendas->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'evento_id' => 55,
                'dt_inicio' => '2026-08-10T08:00',
                'dt_fim' => '2026-08-11T18:00',
                'dt_inicio_formatado' => '10/08/2026 08:00',
                'dt_fim_formatado' => '11/08/2026 18:00',
            ],
        ]));

        $consultaTotais = Mockery::mock();
        $consultaTotais->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $consultaTotais->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaTotais->shouldReceive('whereIn')->once()->with('EVP.EVENTO_ID', [55])->andReturnSelf();
        $consultaTotais->shouldReceive('groupBy')->once()->with('EVP.EVENTO_ID')->andReturnSelf();
        $consultaTotais->shouldReceive('where')->once()->with('EVP.ZONA_TRABALHO_ID', 1)->andReturnSelf();
        $consultaTotais->shouldReceive('get')->once()->andReturn(collect([
            (object) ['evento_id' => 55, 'total_participantes' => 1],
        ]));

        $participante = (object) [
            'evento_id' => 55,
            'nome_eleitor' => 'SUPERVISORA INTERNA',
            'nome_exibicao' => 'SUPERVISORA INTERNA',
            'num_inscricao' => '000111222333',
            'num_zona' => null,
            'num_zona_trabalho' => '1',
        ];
        $consultaResumo = Mockery::mock();
        $consultaResumo->shouldReceive('leftJoin')
            ->once()
            ->with('CAD_SUPERVISOR_PREDIO as CSP', Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consultaResumo->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $consultaResumo->shouldReceive('selectRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains(
                $sql,
                'NVL(EV.NOM_ELEITOR, NVL(V.NOME_SOCIAL, NVL(V.NOME_CIVIL, CSP.NOME_SUPERVISOR))) as nome_eleitor'
            )))
            ->andReturnSelf();
        $consultaResumo->shouldReceive('whereIn')->once()->with('EVP.EVENTO_ID', [55])->andReturnSelf();
        $consultaResumo->shouldReceive('where')->once()->with('EVP.ZONA_TRABALHO_ID', 1)->andReturnSelf();
        $consultaResumo->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaResumo->shouldReceive('get')->once()->andReturn(collect([$participante]));

        $consultaDetalhes = Mockery::mock();
        $consultaDetalhes->shouldReceive('leftJoin')
            ->once()
            ->with('CAD_SUPERVISOR_PREDIO as CSP', Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consultaDetalhes->shouldReceive('leftJoin')->times(3)->andReturnSelf();
        $consultaDetalhes->shouldReceive('selectRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains(
                $sql,
                'NVL(EV.NOM_ELEITOR, NVL(V.NOME_SOCIAL, NVL(V.NOME_CIVIL, CSP.NOME_SUPERVISOR))) as nome_exibicao'
            )))
            ->andReturnSelf();
        $consultaDetalhes->shouldReceive('whereIn')->once()->with('EVP.EVENTO_ID', [55])->andReturnSelf();
        $consultaDetalhes->shouldReceive('where')->once()->with('EVP.ZONA_TRABALHO_ID', 1)->andReturnSelf();
        $consultaDetalhes->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaDetalhes->shouldReceive('get')->once()->andReturn(collect([$participante]));

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_STATUS')->andReturn($consultaStatus);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO as EV')->andReturn($consultaEventos);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_AGENDA as EA')->andReturn($consultaAgendas);
        DB::shouldReceive('table')->times(3)->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn(
            $consultaTotais,
            $consultaResumo,
            $consultaDetalhes
        );

        $canvas = Mockery::mock(Canvas::class);
        $canvas->shouldReceive('page_text')
            ->twice()
            ->with(
                Mockery::on(static fn ($valor): bool => is_numeric($valor)),
                Mockery::on(static fn ($valor): bool => is_numeric($valor)),
                'Página {PAGE_NUM} de {PAGE_COUNT}',
                '/tmp/dejavu-sans',
                8,
                [0.5, 0.5, 0.5]
            );

        $fontMetrics = Mockery::mock(FontMetrics::class);
        $fontMetrics->shouldReceive('getFont')->once()->with('DejaVu Sans')->andReturn('/tmp/dejavu-sans');

        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('render')->once();
        $pdf->shouldReceive('getFontMetrics')->once()->andReturn($fontMetrics);
        $pdf->shouldReceive('getCanvas')->once()->andReturn($canvas);
        $pdf->shouldReceive('download')
            ->once()
            ->with(Mockery::on(static fn (string $nome): bool => str_starts_with($nome, 'eventos-voluntarios-externos-')))
            ->andReturn(response('pdf'));

        Pdf::shouldReceive('loadView')->once()->with(
            'colaboradores-eleitorais.externos.voluntarios.eventos.pdf',
            Mockery::on(static function (array $dados): bool {
                return ($dados['participantesPorEvento'][55][0]['num_zona'] ?? null) === ''
                    && ($dados['participantesPorEvento'][55][0]['num_zona_trabalho'] ?? null) === '1'
                    && ($dados['participantesPorEvento'][55][0]['nome'] ?? null) === 'SUPERVISORA INTERNA'
                    && ($dados['eventos'][0]['agendas'][0]['dt_inicio_formatado'] ?? null) === '10/08/2026 08:00'
                    && ($dados['filtros']['evento_ids'] ?? null) === [55]
                    && ($dados['filtros']['zona_trabalho_id'] ?? null) === 1;
            })
        )->andReturn($pdf);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscar')->once()->with(1)->andReturn((object) ['id' => 1]);
        $controller = $this->novoControllerIrrestrito(
            null,
            [(object) ['id' => 321, 'nome' => 'Ação Capital']],
            $zonaRepository
        );
        $response = $controller->exportarEventosVoluntariosExternosPdf($request);

        $this->assertSame('pdf', $response->getContent());
    }

    #[Test]
    public function lista_de_presenca_usa_eventos_selecionados_participantes_visiveis_e_papel_retrato(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios.eventos.exportar.pdf'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/voluntarios/eventos/exportar-pdf', 'GET', [
            'documento' => 'lista_presenca',
            'processo_eleitoral_id' => 321,
            'evento_ids' => [55],
            'zona_trabalho_id' => 1,
        ]);
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios.eventos.exportar.pdf');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $consultaStatus = Mockery::mock();
        $consultaStatus->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaStatus->shouldReceive('orderBy')->once()->with('CODIGO')->andReturnSelf();
        $consultaStatus->shouldReceive('pluck')->once()->with('codigo')->andReturn(collect(['ATIVO', 'DESATIVO']));

        $consultaEventos = Mockery::mock();
        $consultaEventos->shouldReceive('join')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('orderByRaw')->twice()->andReturnSelf();
        $consultaEventos->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'id' => 55,
                'processo_eleitoral_id' => 321,
                'nome' => 'Capacitação Eleitoral',
                'local' => 'TRE-AC',
                'atividade' => 'Apoio eleitoral',
                'status_codigo' => 'ATIVO',
                'processo_nome' => 'Ação Capital',
            ],
        ]));

        $consultaAgendas = Mockery::mock();
        $consultaAgendas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaAgendas->shouldReceive('whereIn')->once()->with('EA.EVENTO_ID', [55])->andReturnSelf();
        $consultaAgendas->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $consultaAgendas->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'evento_id' => 55,
                'dt_inicio' => '2026-08-10T08:00',
                'dt_fim' => '2026-08-10T12:00',
                'dt_inicio_formatado' => '10/08/2026 08:00',
                'dt_fim_formatado' => '10/08/2026 12:00',
            ],
        ]));

        $consultaTotais = Mockery::mock();
        $consultaTotais->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $consultaTotais->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaTotais->shouldReceive('whereIn')->once()->with('EVP.EVENTO_ID', [55])->andReturnSelf();
        $consultaTotais->shouldReceive('groupBy')->once()->with('EVP.EVENTO_ID')->andReturnSelf();
        $consultaTotais->shouldReceive('where')->once()->with('EVP.ZONA_TRABALHO_ID', 1)->andReturnSelf();
        $consultaTotais->shouldReceive('get')->once()->andReturn(collect([
            (object) ['evento_id' => 55, 'total_participantes' => 1],
        ]));

        $participante = (object) [
            'evento_id' => 55,
            'nome_exibicao' => 'ÁLVARO TESTE',
            'num_inscricao' => '000111222333',
            'num_zona' => '9',
            'num_zona_trabalho' => '1',
        ];
        $consultaDetalhes = Mockery::mock();
        $consultaDetalhes->shouldReceive('leftJoin')
            ->once()
            ->with('CAD_SUPERVISOR_PREDIO as CSP', Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consultaDetalhes->shouldReceive('leftJoin')->times(3)->andReturnSelf();
        $consultaDetalhes->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaDetalhes->shouldReceive('whereIn')->once()->with('EVP.EVENTO_ID', [55])->andReturnSelf();
        $consultaDetalhes->shouldReceive('where')->once()->with('EVP.ZONA_TRABALHO_ID', 1)->andReturnSelf();
        $consultaDetalhes->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaDetalhes->shouldReceive('get')->once()->andReturn(collect([$participante]));

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_STATUS')->andReturn($consultaStatus);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO as EV')->andReturn($consultaEventos);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_AGENDA as EA')->andReturn($consultaAgendas);
        DB::shouldReceive('table')->times(2)->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn(
            $consultaTotais,
            $consultaDetalhes
        );

        $canvas = Mockery::mock(Canvas::class);
        $canvas->shouldReceive('page_text')
            ->once()
            ->with(250, 820, 'Página {PAGE_NUM} de {PAGE_COUNT}', '/tmp/dejavu-sans', 8, [0.5, 0.5, 0.5]);

        $fontMetrics = Mockery::mock(FontMetrics::class);
        $fontMetrics->shouldReceive('getFont')->once()->with('DejaVu Sans')->andReturn('/tmp/dejavu-sans');

        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('setPaper')->once()->with('a4', 'portrait')->andReturnSelf();
        $pdf->shouldReceive('render')->once();
        $pdf->shouldReceive('getFontMetrics')->once()->andReturn($fontMetrics);
        $pdf->shouldReceive('getCanvas')->once()->andReturn($canvas);
        $pdf->shouldReceive('download')
            ->once()
            ->with(Mockery::on(static fn (string $nome): bool => str_starts_with(
                $nome,
                'lista-presenca-eventos-voluntarios-externos-'
            )))
            ->andReturn(response('lista-presenca'));

        Pdf::shouldReceive('loadView')->once()->with(
            'colaboradores-eleitorais.externos.voluntarios.eventos.lista-presenca',
            Mockery::on(static function (array $dados): bool {
                return ($dados['eventos'][0]['id'] ?? null) === 55
                    && ($dados['participantesPorEvento'][55][0]['nome'] ?? null) === 'ÁLVARO TESTE'
                    && ($dados['participantesPorEvento'][55][0]['num_inscricao'] ?? null) === '000111222333'
                    && ($dados['linhasExtras'] ?? null) === 5;
            })
        )->andReturn($pdf);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscar')->once()->with(1)->andReturn((object) ['id' => 1]);
        $controller = $this->novoControllerIrrestrito(
            null,
            [(object) ['id' => 321, 'nome' => 'Ação Capital']],
            $zonaRepository
        );

        $response = $controller->exportarEventosVoluntariosExternosPdf($request);

        $this->assertSame('lista-presenca', $response->getContent());
    }

    #[Test]
    public function calendario_de_eventos_cria_uma_ocorrencia_por_agenda_com_detalhes_e_status(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'montarEventosCalendarioVoluntariosExternos');
        $metodo->setAccessible(true);

        $eventos = collect([
            [
                'id' => 55,
                'nome' => 'Plantão Capital',
                'processo_nome' => 'Ação Teste',
                'local' => 'SEDE',
                'atividade' => 'Suporte',
                'status_codigo' => 'ATIVO',
                'status_nome' => 'Ativo',
                'total_participantes' => 4,
                'agendas' => [
                    [
                        'dt_inicio' => '2026-06-10T08:00',
                        'dt_fim' => '2026-06-10T10:00',
                        'dt_inicio_formatado' => '10/06/2026 08:00',
                        'dt_fim_formatado' => '10/06/2026 10:00',
                    ],
                    [
                        'dt_inicio' => '2026-06-11T14:00',
                        'dt_fim' => '2026-06-11T18:00',
                        'dt_inicio_formatado' => '11/06/2026 14:00',
                        'dt_fim_formatado' => '11/06/2026 18:00',
                    ],
                ],
            ],
            [
                'id' => 77,
                'nome' => 'Evento Arquivado',
                'processo_nome' => 'Ação Interior',
                'local' => 'FÓRUM',
                'atividade' => 'Orientação',
                'status_codigo' => 'DESATIVO',
                'status_nome' => 'Desativado',
                'total_participantes' => 0,
                'agendas' => [[
                    'dt_inicio' => '2026-06-12T09:00',
                    'dt_fim' => '2026-06-12T11:00',
                    'dt_inicio_formatado' => '12/06/2026 09:00',
                    'dt_fim_formatado' => '12/06/2026 11:00',
                ]],
            ],
        ]);

        $ocorrencias = $metodo->invoke($controller, $eventos);

        $this->assertCount(3, $ocorrencias);
        $this->assertSame(
            ['evento-55-agenda-1', 'evento-55-agenda-2', 'evento-77-agenda-1'],
            array_column($ocorrencias, 'id')
        );
        $this->assertSame('2026-06-10T08:00', $ocorrencias[0]['start']);
        $this->assertSame('2026-06-10T10:00', $ocorrencias[0]['end']);
        $this->assertSame('#0d6efd', $ocorrencias[0]['backgroundColor']);
        $this->assertSame('#0a58ca', $ocorrencias[0]['borderColor']);
        $this->assertSame('[Desativado] Evento Arquivado', $ocorrencias[2]['title']);
        $this->assertSame('#6c757d', $ocorrencias[2]['backgroundColor']);
        $this->assertSame('#565e64', $ocorrencias[2]['borderColor']);

        $detalhes = $ocorrencias[0]['extendedProps'];
        $this->assertSame(55, $detalhes['evento_id']);
        $this->assertSame('Ação Teste', $detalhes['acao_trabalho']);
        $this->assertSame('SEDE', $detalhes['local']);
        $this->assertSame('Suporte', $detalhes['atividade']);
        $this->assertSame('ATIVO', $detalhes['status_codigo']);
        $this->assertSame('Ativo', $detalhes['status_nome']);
        $this->assertSame('10/06/2026 08:00 até 10/06/2026 10:00', $detalhes['periodo']);
        $this->assertSame(4, $detalhes['total_participantes']);
        $this->assertSame(
            route('colaboradores-eleitorais.externos.voluntarios.eventos.editar', ['id' => 55]),
            $detalhes['edit_url']
        );
        $this->assertArrayNotHasKey('participantes', $detalhes);
    }

    #[Test]
    public function filtro_de_zona_sem_eventos_marcados_mantem_eventos_visiveis_e_valida_o_catalogo(): void
    {
        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscar')->once()->with(44)->andReturn((object) ['id' => 44]);
        $controller = $this->novoControllerIrrestrito(null, [], $zonaRepository);
        $metodo = new ReflectionMethod($controller, 'resolverSelecaoFiltrosEventosVoluntarios');
        $metodo->setAccessible(true);
        $request = Request::create('/eventos', 'GET', ['zona_trabalho_id' => 44]);
        $eventosVisiveis = collect([
            ['id' => 10, 'processo_eleitoral_id' => 321],
            ['id' => 11, 'processo_eleitoral_id' => 442],
        ]);

        $resultado = $metodo->invoke($controller, $request, $eventosVisiveis, []);

        $this->assertSame([10, 11], array_column($resultado['eventos'], 'id'));
        $this->assertSame([], $resultado['evento_ids']);
        $this->assertSame(44, $resultado['zona_trabalho_id']);
    }

    #[Test]
    public function exclusao_de_evento_bloqueia_evento_ativo(): void
    {
        $request = $this->prepararRequestJsonExclusaoEvento();
        $this->mockBuscaEventoVisivelParaExclusao('ATIVO');

        $response = $this->novoControllerIrrestrito()->excluirEventoVoluntarioExterno($request, 55);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $this->assertSame(422, $response->getStatusCode());
        $this->assertStringContainsString('desativado', $response->getData(true)['mensagem'] ?? '');
    }

    #[Test]
    public function exclusao_de_evento_bloqueia_evento_desativado_com_participantes(): void
    {
        $request = $this->prepararRequestJsonExclusaoEvento();
        $this->mockBuscaEventoVisivelParaExclusao('DESATIVO');

        $consultaParticipantes = Mockery::mock();
        $consultaParticipantes->shouldReceive('where')->once()->with('EVENTO_ID', 55)->andReturnSelf();
        $consultaParticipantes->shouldReceive('exists')->once()->andReturnTrue();

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE')->andReturn($consultaParticipantes);

        $response = $this->novoControllerIrrestrito()->excluirEventoVoluntarioExterno($request, 55);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $this->assertSame(422, $response->getStatusCode());
        $this->assertStringContainsString('participantes', $response->getData(true)['mensagem'] ?? '');
    }

    #[Test]
    public function exclusao_de_evento_desativado_sem_participantes_remove_agendas_e_evento(): void
    {
        $request = $this->prepararRequestJsonExclusaoEvento();
        $this->mockBuscaEventoVisivelParaExclusao('DESATIVO');

        $consultaParticipantes = Mockery::mock();
        $consultaParticipantes->shouldReceive('where')->once()->with('EVENTO_ID', 55)->andReturnSelf();
        $consultaParticipantes->shouldReceive('exists')->once()->andReturnFalse();

        $eventoRepository = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $eventoRepository->shouldReceive('excluir')->once()->with(55);

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE')->andReturn($consultaParticipantes);

        $response = $this->novoControllerIrrestrito($eventoRepository)->excluirEventoVoluntarioExterno($request, 55);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Evento excluído com sucesso.', $response->getData(true)['mensagem'] ?? null);
    }

    #[Test]
    public function replicacao_de_participantes_copia_elegiveis_e_ignora_duplicados(): void
    {
        $this->mockParticipantesVisiveisOrigem([
            ['num_inscricao' => '000111222333', 'nome_civil' => 'ANA TESTE', 'zona_trabalho_id' => 1],
            ['num_inscricao' => '000111222444', 'nome_civil' => 'BRUNO TESTE', 'zona_trabalho_id' => 9],
        ]);

        $eventoRepository = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $eventoRepository->shouldReceive('replicarParticipantes')
            ->once()
            ->with(77, [
                ['num_inscricao' => '000111222333', 'zona_trabalho_id' => 1],
                ['num_inscricao' => '000111222444', 'zona_trabalho_id' => 9],
            ])
            ->andReturn([
                'inseridas' => ['000111222444'],
                'ja_existentes' => ['000111222333'],
                'conflitos' => [],
            ]);

        $controller = $this->novoControllerIrrestrito($eventoRepository);
        $metodo = new ReflectionMethod($controller, 'replicarParticipantesEntreEventosVoluntarios');
        $metodo->setAccessible(true);
        $resultado = $metodo->invoke(
            $controller,
            55,
            77,
            [['dt_inicio' => '2026-10-03T08:00', 'dt_fim' => '2026-10-03T18:00']],
            true,
            []
        );

        $this->assertSame(2, $resultado['total_origem'] ?? null);
        $this->assertSame(1, $resultado['total_replicados'] ?? null);
        $this->assertSame(1, $resultado['total_ja_existentes'] ?? null);
        $this->assertSame(0, $resultado['total_ignorados_conflito'] ?? null);
        $this->assertSame([], $resultado['conflitos'] ?? null);
    }

    #[Test]
    public function replicacao_de_participantes_e_parcial_quando_existe_conflito_de_agenda(): void
    {
        $this->mockParticipantesVisiveisOrigem([
            ['num_inscricao' => '000111222333', 'nome_civil' => 'ANA TESTE', 'zona_trabalho_id' => 1],
            ['num_inscricao' => '000111222444', 'nome_civil' => 'BRUNO TESTE', 'zona_trabalho_id' => 9],
        ]);

        $eventoRepository = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $eventoRepository->shouldReceive('replicarParticipantes')
            ->once()
            ->with(77, [
                ['num_inscricao' => '000111222333', 'zona_trabalho_id' => 1],
                ['num_inscricao' => '000111222444', 'zona_trabalho_id' => 9],
            ])
            ->andReturn([
                'inseridas' => ['000111222444'],
                'ja_existentes' => [],
                'conflitos' => [[
                    'num_inscricao' => '000111222333',
                    'mensagem' => 'Conflito de agenda.',
                ]],
            ]);

        $controller = $this->novoControllerIrrestrito($eventoRepository);
        $metodo = new ReflectionMethod($controller, 'replicarParticipantesEntreEventosVoluntarios');
        $metodo->setAccessible(true);
        $resultado = $metodo->invoke(
            $controller,
            55,
            77,
            [['dt_inicio' => '2026-10-03T08:00', 'dt_fim' => '2026-10-03T18:00']],
            true,
            []
        );

        $this->assertSame(2, $resultado['total_origem'] ?? null);
        $this->assertSame(1, $resultado['total_replicados'] ?? null);
        $this->assertSame(0, $resultado['total_ja_existentes'] ?? null);
        $this->assertSame(1, $resultado['total_ignorados_conflito'] ?? null);
        $this->assertCount(1, $resultado['conflitos'] ?? []);
        $this->assertSame('000111222333', $resultado['conflitos'][0]['num_inscricao'] ?? null);
    }

    #[Test]
    public function replicacao_bloqueia_origem_igual_ao_destino(): void
    {
        $request = $this->prepararRequestJsonReplicaEvento(55);

        $response = $this->novoControllerIrrestrito()->replicarParticipantesEventoVoluntarioExterno($request, 55);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $this->assertSame(422, $response->getStatusCode());
        $this->assertArrayHasKey('evento_destino_id', $response->getData(true)['errors'] ?? []);
    }

    #[Test]
    public function replicacao_bloqueia_origem_fora_do_escopo(): void
    {
        $request = $this->prepararRequestJsonReplicaEvento(77);
        $this->mockEventosVisiveisReplica([
            $this->eventoReplica(77, 'ATIVO'),
        ], [
            77 => [$this->agendaReplica()],
        ]);

        $response = $this->novoControllerIrrestrito()->replicarParticipantesEventoVoluntarioExterno($request, 55);

        $this->assertSame(404, $response->getStatusCode());
        $this->assertStringContainsString('origem', mb_strtolower($response->getData(true)['mensagem'] ?? ''));
    }

    #[Test]
    public function replicacao_bloqueia_destino_fora_do_escopo(): void
    {
        $request = $this->prepararRequestJsonReplicaEvento(77);
        $this->mockEventosVisiveisReplica([
            $this->eventoReplica(55, 'ATIVO'),
        ], [
            55 => [$this->agendaReplica()],
        ]);

        $response = $this->novoControllerIrrestrito()->replicarParticipantesEventoVoluntarioExterno($request, 55);

        $this->assertSame(404, $response->getStatusCode());
        $this->assertStringContainsString('destino', mb_strtolower($response->getData(true)['mensagem'] ?? ''));
    }

    #[Test]
    public function replicacao_bloqueia_destino_inativo(): void
    {
        $request = $this->prepararRequestJsonReplicaEvento(77);
        $this->mockEventosVisiveisReplica([
            $this->eventoReplica(55, 'DESATIVO'),
            $this->eventoReplica(77, 'DESATIVO'),
        ], [
            55 => [$this->agendaReplica()],
            77 => [$this->agendaReplica()],
        ]);

        $response = $this->novoControllerIrrestrito()->replicarParticipantesEventoVoluntarioExterno($request, 55);

        $this->assertSame(422, $response->getStatusCode());
        $this->assertStringContainsString('ativo', mb_strtolower($response->getData(true)['mensagem'] ?? ''));
    }

    #[Test]
    public function replicacao_bloqueia_origem_sem_participantes_visiveis(): void
    {
        $request = $this->prepararRequestJsonReplicaEvento(77);
        $this->mockEventosVisiveisReplica([
            $this->eventoReplica(55, 'DESATIVO'),
            $this->eventoReplica(77, 'ATIVO'),
        ], [
            55 => [$this->agendaReplica()],
            77 => [$this->agendaReplica()],
        ]);
        $this->mockParticipantesVisiveisOrigem([]);

        $response = $this->novoControllerIrrestrito()->replicarParticipantesEventoVoluntarioExterno($request, 55);

        $this->assertSame(422, $response->getStatusCode());
        $this->assertStringContainsString('participante', mb_strtolower($response->getData(true)['mensagem'] ?? ''));
    }

    #[Test]
    public function resumo_do_dashboard_de_voluntarios_agrupar_por_camisa_zona_e_municipio_com_nao_informado(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'resumirDashboardVoluntariosExternos');
        $metodo->setAccessible(true);

        // O dashboard e agregado diretamente no Oracle via GROUPING SETS; o metodo
        // apenas interpreta as linhas agregadas (dimensao/rotulo/total), sem hidratar
        // a base completa de voluntarios no PHP.
        $resultado = $metodo->invoke($controller, collect([
            (object) ['dimensao' => 'total', 'rotulo' => null, 'total' => 3, 'alocados' => 0],
            (object) ['dimensao' => 'tamanho', 'rotulo' => 'M', 'total' => 2, 'alocados' => 0],
            (object) ['dimensao' => 'tamanho', 'rotulo' => 'Nao informado', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'zona', 'rotulo' => '2', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'zona', 'rotulo' => '10', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'zona', 'rotulo' => 'Nao informado', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'municipio', 'rotulo' => 'RIO BRANCO', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'municipio', 'rotulo' => 'CRUZEIRO DO SUL', 'total' => 1, 'alocados' => 0],
            (object) ['dimensao' => 'municipio', 'rotulo' => 'Nao informado', 'total' => 1, 'alocados' => 0],
        ]));

        $this->assertSame(3, $resultado['total_filtrado'] ?? null);
        $this->assertSame([
            ['label' => 'M', 'total' => 2],
            ['label' => 'Nao informado', 'total' => 1],
        ], $resultado['camisas_por_tamanho'] ?? null);
        $this->assertSame([
            ['label' => '2', 'total' => 1],
            ['label' => '10', 'total' => 1],
            ['label' => 'Nao informado', 'total' => 1],
        ], $resultado['voluntarios_por_zona'] ?? null);
        $this->assertSame([
            ['label' => 'CRUZEIRO DO SUL', 'total' => 1],
            ['label' => 'RIO BRANCO', 'total' => 1],
            ['label' => 'Nao informado', 'total' => 1],
        ], $resultado['voluntarios_por_municipio'] ?? null);
    }

    #[Test]
    public function sincronizacao_de_participantes_do_evento_usa_alias_minusculo_para_inscricao_existente(): void
    {
        session()->put([
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $consultaEscopo = Mockery::mock();
        $consultaEscopo->shouldReceive('join')->once()->andReturnSelf();
        $consultaEscopo->shouldReceive('selectRaw')->once()->with('TRIM(v.num_inscricao) as num_inscricao')->andReturnSelf();
        $consultaEscopo->shouldReceive('whereIn')->once()->with('TRIM(v.num_inscricao)', ['000111222333'])->andReturnSelf();
        $consultaEscopo->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaEscopo->shouldReceive('pluck')->once()->with('num_inscricao')->andReturn(collect(['000111222333']));

        $consultaManualVinculado = Mockery::mock();
        $consultaManualVinculado->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $consultaManualVinculado->shouldReceive('selectRaw')
            ->once()
            ->with('TRIM(EVP.NUM_INSCRICAO) as num_inscricao')
            ->andReturnSelf();
        $consultaManualVinculado->shouldReceive('whereIn')->once()->andReturnSelf();
        $consultaManualVinculado->shouldReceive('where')->once()->with('EVP.EVENTO_ID', 55)->andReturnSelf();
        $consultaManualVinculado->shouldReceive('pluck')->once()->with('num_inscricao')->andReturn(collect());

        DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_PERFIL_EFETIVO as v')->andReturn($consultaEscopo);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn($consultaManualVinculado);
        DB::shouldReceive('raw')->zeroOrMoreTimes()->andReturnUsing(static fn ($value) => $value);

        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'sincronizarParticipantesEventoVoluntario');
        $metodo->setAccessible(true);

        $resultado = $metodo->invoke($controller, 55, [[
            'num_inscricao' => '000111222333',
            'nome_exibicao' => 'ANA TESTE',
            'resumo_exibicao' => 'Titulo 000111222333 · RIO BRANCO',
        ]], []);

        $this->assertSame([[
            'num_inscricao' => '000111222333',
            'zona_trabalho_id' => null,
        ]], $resultado);
    }

    #[Test]
    public function reidratacao_do_formulario_ignora_zona_de_voto_enviada_pelo_navegador(): void
    {
        $consulta = Mockery::mock();
        $consulta->shouldReceive('leftJoin')->once()->andReturnSelf();
        $consulta->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('whereIn')
            ->once()
            ->with('TRIM(V.NUM_INSCRICAO)', ['000111222333'])
            ->andReturnSelf();
        $consulta->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('where')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $consulta->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'nome_eleitor' => 'ANA ELEITORAL',
                'num_inscricao' => '000111222333',
                'num_zona' => '9',
                'telefone' => '(68) 99999-0001',
                'localidade' => 'RIO BRANCO',
            ],
        ]));

        DB::shouldReceive('table')
            ->once()
            ->with('VW_VOLUNTARIO_OPERACIONAL as V')
            ->andReturn($consulta);
        DB::shouldReceive('raw')->zeroOrMoreTimes()->andReturnUsing(static fn ($value) => $value);

        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'rehidratarParticipantesEventoFormulario');
        $metodo->setAccessible(true);

        $resultado = $metodo->invoke($controller, [[
            'num_inscricao' => '000111222333',
            'nome_exibicao' => 'NOME FORJADO',
            'zona_voto' => '99',
            'zona_trabalho_id' => 1,
        ]], true, []);

        $this->assertSame('ANA ELEITORAL', $resultado[0]['nome_exibicao'] ?? null);
        $this->assertSame('9', $resultado[0]['zona_voto'] ?? null);
        $this->assertSame(1, $resultado[0]['zona_trabalho_id'] ?? null);
    }

    #[Test]
    public function reidratacao_preserva_supervisor_ja_vinculado_ausente_da_view_generica(): void
    {
        $consultaGenerica = Mockery::mock();
        $consultaGenerica->shouldReceive('leftJoin')->once()->andReturnSelf();
        $consultaGenerica->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaGenerica->shouldReceive('whereIn')->once()->andReturnSelf();
        $consultaGenerica->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaGenerica->shouldReceive('where')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $consultaGenerica->shouldReceive('get')->once()->andReturn(collect());

        $consultaVinculado = Mockery::mock();
        $consultaVinculado->shouldReceive('leftJoin')
            ->once()
            ->with('CAD_SUPERVISOR_PREDIO as CSP', Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consultaVinculado->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $consultaVinculado->shouldReceive('selectRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains(
                $sql,
                'NVL(EV.NOM_ELEITOR, NVL(V.NOME_SOCIAL, NVL(V.NOME_CIVIL, CSP.NOME_SUPERVISOR))) as nome_eleitor'
            )))
            ->andReturnSelf();
        $consultaVinculado->shouldReceive('where')->once()->with('EVP.EVENTO_ID', 55)->andReturnSelf();
        $consultaVinculado->shouldReceive('whereIn')->once()->andReturnSelf();
        $consultaVinculado->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaVinculado->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'nome_eleitor' => 'SUPERVISORA INTERNA',
                'num_inscricao' => '000111222333',
                'num_zona' => null,
                'telefone' => '',
                'localidade' => '',
            ],
        ]));

        DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_OPERACIONAL as V')->andReturn($consultaGenerica);
        DB::shouldReceive('table')
            ->once()
            ->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')
            ->andReturn($consultaVinculado);
        DB::shouldReceive('raw')->zeroOrMoreTimes()->andReturnUsing(static fn ($value) => $value);

        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'rehidratarParticipantesEventoFormulario');
        $metodo->setAccessible(true);

        $resultado = $metodo->invoke($controller, [[
            'num_inscricao' => '000111222333',
            'zona_trabalho_id' => 82,
        ]], true, [], 55);

        $this->assertSame('SUPERVISORA INTERNA', $resultado[0]['nome_exibicao'] ?? null);
        $this->assertSame('000111222333', $resultado[0]['num_inscricao'] ?? null);
        $this->assertSame(82, $resultado[0]['zona_trabalho_id'] ?? null);
    }

    #[Test]
    public function sincronizacao_continua_rejeitando_participante_fora_do_escopo_territorial(): void
    {
        session()->put([
            'acesso_todas_zonas' => false,
            'cod_zonas_permitidas' => [],
        ]);

        $consulta = Mockery::mock();
        $consulta->shouldReceive('join')->once()->andReturnSelf();
        $consulta->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('whereIn')->once()->andReturnSelf();
        $consulta->shouldReceive('distinct')->once()->andReturnSelf();
        $consulta->shouldReceive('whereRaw')->once()->with('1 = 0')->andReturnSelf();
        $consulta->shouldReceive('pluck')->once()->with('num_inscricao')->andReturn(collect());

        $consultaManualVinculado = Mockery::mock();
        $consultaManualVinculado->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $consultaManualVinculado->shouldReceive('selectRaw')
            ->once()
            ->with('TRIM(EVP.NUM_INSCRICAO) as num_inscricao')
            ->andReturnSelf();
        $consultaManualVinculado->shouldReceive('whereIn')->once()->andReturnSelf();
        $consultaManualVinculado->shouldReceive('where')->once()->with('EVP.EVENTO_ID', 55)->andReturnSelf();
        $consultaManualVinculado->shouldReceive('where')
            ->once()
            ->with(Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consultaManualVinculado->shouldReceive('pluck')->once()->with('num_inscricao')->andReturn(collect());
        DB::shouldReceive('table')
            ->once()
            ->with('VW_VOLUNTARIO_PERFIL_EFETIVO as v')
            ->andReturn($consulta);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn($consultaManualVinculado);
        DB::shouldReceive('raw')->zeroOrMoreTimes()->andReturnUsing(static fn ($value) => $value);

        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'sincronizarParticipantesEventoVoluntario');
        $metodo->setAccessible(true);

        $this->expectException(\DomainException::class);
        $this->expectExceptionMessage('fora do escopo atual');

        $metodo->invoke($controller, 55, [[
            'num_inscricao' => '000111222333',
            'zona_trabalho_id' => 1,
        ]], []);
    }

    #[Test]
    public function filtro_de_alocacao_em_rota_normaliza_valores_oficiais(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'normalizarFiltrosVoluntariosExternos');
        $metodo->setAccessible(true);

        $alocados = Request::create('/colaboradores-eleitorais/externos/voluntarios?alocacao_rota=alocados', 'GET');
        $naoAlocados = Request::create('/colaboradores-eleitorais/externos/voluntarios?alocacao_rota=nao_alocados', 'GET');
        $invalido = Request::create('/colaboradores-eleitorais/externos/voluntarios?alocacao_rota=qualquer', 'GET');
        $vazio = Request::create('/colaboradores-eleitorais/externos/voluntarios', 'GET');

        $this->assertSame('alocados', $metodo->invoke($controller, $alocados, [])['alocacao_rota'] ?? null);
        $this->assertSame('nao_alocados', $metodo->invoke($controller, $naoAlocados, [])['alocacao_rota'] ?? null);
        $this->assertSame('', $metodo->invoke($controller, $invalido, [])['alocacao_rota'] ?? null);
        $this->assertSame('', $metodo->invoke($controller, $vazio, [])['alocacao_rota'] ?? null);
    }

    #[Test]
    public function filtro_da_situacao_do_elo_normaliza_somente_valores_oficiais(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'normalizarFiltrosVoluntariosExternos');
        $metodo->setAccessible(true);

        $convocados = Request::create('/colaboradores-eleitorais/externos/voluntarios?situacao_elo=convocados_atribuidos', 'GET');
        $naoConvocados = Request::create('/colaboradores-eleitorais/externos/voluntarios?situacao_elo=nao_convocados', 'GET');
        $invalido = Request::create('/colaboradores-eleitorais/externos/voluntarios?situacao_elo=qualquer', 'GET');
        $vazio = Request::create('/colaboradores-eleitorais/externos/voluntarios', 'GET');

        $this->assertSame('convocados_atribuidos', $metodo->invoke($controller, $convocados, [])['situacao_elo'] ?? null);
        $this->assertSame('nao_convocados', $metodo->invoke($controller, $naoConvocados, [])['situacao_elo'] ?? null);
        $this->assertSame('', $metodo->invoke($controller, $invalido, [])['situacao_elo'] ?? null);
        $this->assertSame('', $metodo->invoke($controller, $vazio, [])['situacao_elo'] ?? null);
    }

    #[Test]
    public function filtro_convocados_ou_atribuidos_exige_situacao_reconhecida_no_elo(): void
    {
        $query = Mockery::mock();
        $query->shouldReceive('whereNotNull')->once()->with('CMELO.SITUACAO_MESARIO_ELO')->andReturnSelf();

        \App\Support\ColaboradoresEleitorais\VoluntarioExternoConsultaQuery::aplicarFiltros(
            $query,
            ['situacao_elo' => 'convocados_atribuidos'],
            ['acesso_todas_zonas' => true, 'zonas_permitidas' => []],
            false
        );

        $this->assertTrue(true);
    }

    #[Test]
    public function filtro_nao_convocados_exige_ausencia_de_situacao_reconhecida_no_elo(): void
    {
        $query = Mockery::mock();
        $query->shouldReceive('whereNull')->once()->with('CMELO.SITUACAO_MESARIO_ELO')->andReturnSelf();

        \App\Support\ColaboradoresEleitorais\VoluntarioExternoConsultaQuery::aplicarFiltros(
            $query,
            ['situacao_elo' => 'nao_convocados'],
            ['acesso_todas_zonas' => true, 'zonas_permitidas' => []],
            false
        );

        $this->assertTrue(true);
    }

    #[Test]
    public function filtro_alocados_aplica_exists_de_rota(): void
    {
        $sql = \App\Support\ColaboradoresEleitorais\VoluntarioExternoConsultaQuery::criarPagina(
            ['alocacao_rota' => 'alocados'],
            ['acesso_todas_zonas' => true, 'zonas_permitidas' => []]
        )->toSql();

        $this->assertStringContainsString('exists (', mb_strtolower($sql, 'UTF-8'));
        $this->assertStringNotContainsString('NVL(AR.QTD_ROTAS', mb_strtoupper($sql, 'UTF-8'));
    }

    #[Test]
    public function filtro_nao_alocados_aplica_not_exists_de_rota(): void
    {
        $sql = \App\Support\ColaboradoresEleitorais\VoluntarioExternoConsultaQuery::criarPagina(
            ['alocacao_rota' => 'nao_alocados'],
            ['acesso_todas_zonas' => true, 'zonas_permitidas' => []]
        )->toSql();

        $this->assertStringContainsString('not exists (', mb_strtolower($sql, 'UTF-8'));
        $this->assertStringNotContainsString('NVL(AR.QTD_ROTAS', mb_strtoupper($sql, 'UTF-8'));
    }

    #[Test]
    public function dashboard_resume_alocados_e_nao_alocados_em_rotas(): void
    {
        $controller = $this->novoControllerIrrestrito();
        $metodo = new ReflectionMethod($controller, 'resumirDashboardVoluntariosExternos');
        $metodo->setAccessible(true);

        // Alocados/nao alocados vem da linha de total agregada pelo Oracle.
        $registros = collect([
            (object) ['dimensao' => 'total', 'rotulo' => null, 'total' => 3, 'alocados' => 2],
        ]);

        $resultado = $metodo->invoke($controller, $registros);

        $this->assertSame(3, $resultado['total_filtrado'] ?? null);
        $this->assertSame(2, $resultado['alocados_em_rotas'] ?? null);
        $this->assertSame(1, $resultado['nao_alocados'] ?? null);
    }

    #[Test]
    public function consulta_de_alocacao_identifica_rotas_que_contem_o_local_de_voto_do_voluntario(): void
    {
        $consulta = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoConsultaQuery.php'));
        $support = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoAlocacaoRotaQuery.php'));

        $this->assertIsString($consulta);
        $this->assertIsString($support);
        $this->assertStringContainsString('leftJoinSub($subconsultaRotasLocalVoto', $consulta);
        $this->assertStringContainsString('TRIM(ARV.COD_OBJETO_LOCAL) = {$localVotoEfetivo}', $consulta);
        $this->assertStringContainsString('rota_contem_local_voto', $consulta);
        $this->assertStringContainsString('rotas_com_local_voto', $consulta);
        $this->assertStringContainsString('ROTA_LOCAL as RLR', $support);
        $this->assertStringContainsString('TRIM(RLR.COD_OBJETO_LOCAL) AS COD_OBJETO_LOCAL', $support);
        $this->assertStringContainsString('ROTAS_COM_LOCAL_VOTO', $support);
    }

    #[Test]
    public function colunas_de_exportacao_de_voluntarios_incluem_indicador_de_rota_com_local_de_voto(): void
    {
        $controller = $this->novoControllerIrrestrito();

        $metodoDisponiveis = new ReflectionMethod($controller, 'colunasExportacaoVoluntarios');
        $metodoDisponiveis->setAccessible(true);

        $colunasDisponiveis = $metodoDisponiveis->invoke($controller);

        $this->assertSame('Rota inclui local de votacao', $colunasDisponiveis['rota_contem_local_voto'] ?? null);
        $this->assertSame('Rotas com local de votacao', $colunasDisponiveis['rotas_com_local_voto'] ?? null);
    }

    #[Test]
    public function listagem_pagina_antes_de_hidratar_rotas_e_elo_em_lote_sem_n_mais_um(): void
    {
        $controller = file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php'));
        $job = file_get_contents(app_path('Jobs/ColaboradoresEleitorais/GerarPdfVoluntariosExternosJob.php'));
        $consulta = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoConsultaQuery.php'));
        $support = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoAlocacaoRotaQuery.php'));
        $situacaoElo = file_get_contents(app_path('Support/ColaboradoresEleitorais/VoluntarioExternoSituacaoMesarioEloQuery.php'));

        $this->assertIsString($controller);
        $this->assertIsString($job);
        $this->assertIsString($consulta);
        $this->assertIsString($support);
        $this->assertIsString($situacaoElo);
        $this->assertStringContainsString('public static function criarPagina', $consulta);
        $this->assertStringContainsString('public static function carregarDetalhesPagina', $support);
        $this->assertStringContainsString('JSON_TABLE', $support);
        $this->assertStringContainsString('LISTAGG(', $support);
        $this->assertStringContainsString('public static function carregarDetalhesPagina', $situacaoElo);
        $this->assertStringContainsString('JSON_TABLE', $situacaoElo);
        $this->assertStringContainsString('setCollection(', $controller);
        $this->assertStringContainsString('VoluntarioExternoSituacaoMesarioEloQuery::carregarDetalhesPagina', $controller);
        $this->assertStringContainsString('VoluntarioExternoConsultaQuery::criar', $controller);
        $this->assertStringContainsString('VoluntarioExternoConsultaQuery::criar', $job);
        $this->assertSame(1, substr_count($support, 'DB::query()'));
    }

    #[Test]
    public function pdf_assincrono_reutiliza_consulta_compartilhada_da_listagem_e_zona_eleitoral(): void
    {
        $controller = file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php'));
        $job = file_get_contents(app_path('Jobs/ColaboradoresEleitorais/GerarPdfVoluntariosExternosJob.php'));
        $queryObject = app_path('Support/ColaboradoresEleitorais/VoluntarioExternoConsultaQuery.php');

        $this->assertIsString($controller);
        $this->assertIsString($job);
        $this->assertFileExists($queryObject);

        $query = file_get_contents($queryObject);
        $this->assertIsString($query);
        $this->assertStringContainsString('VoluntarioExternoConsultaQuery::criar', $controller);
        $this->assertStringContainsString('VoluntarioExternoConsultaQuery::criar', $job);
        $this->assertStringContainsString('ev.num_zona', $query);
        $this->assertStringContainsString('TRIM(NVL(ev.num_zona, '."''".'))', $query);
        $this->assertStringNotContainsString('v.num_zona, v.data_nasc', $job);
        $this->assertStringNotContainsString('NVL(v.num_zona', $job);
    }

    private function prepararRequestJsonExclusaoEvento(): Request
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios.eventos.excluir'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/voluntarios/eventos/55', 'DELETE');
        $request->headers->set('Accept', 'application/json');
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios.eventos.excluir');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        return $request;
    }

    private function prepararRequestJsonReplicaEvento(int $eventoDestinoId): Request
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.voluntarios.eventos.replicar-participantes'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create(
            '/colaboradores-eleitorais/externos/voluntarios/eventos/55/replicar-participantes',
            'POST',
            ['evento_destino_id' => $eventoDestinoId]
        );
        $request->headers->set('Accept', 'application/json');
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.voluntarios.eventos.replicar-participantes');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        return $request;
    }

    /**
     * @param  array<int, array{num_inscricao:string,nome_civil:string}>  $participantes
     */
    private function mockParticipantesVisiveisOrigem(array $participantes): void
    {
        session()->put([
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $consulta = Mockery::mock();
        $consulta->shouldReceive('leftJoin')
            ->once()
            ->with('CAD_SUPERVISOR_PREDIO as CSP', Mockery::type(\Closure::class))
            ->andReturnSelf();
        $consulta->shouldReceive('leftJoin')->times(3)->andReturnSelf();
        $consulta->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('where')->once()->with('EVP.EVENTO_ID', 55)->andReturnSelf();
        $consulta->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('get')->once()->andReturn(collect(array_map(
            static fn (array $participante) => (object) array_merge([
                'nome_social' => null,
                'num_zona' => '9',
                'perfil_nome' => 'APOIO',
                'status' => 'ATIVO',
                'email' => '',
                'telefone' => '',
                'localidade' => 'RIO BRANCO',
            ], $participante),
            $participantes
        )));

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')->andReturn($consulta);

        if ($participantes !== []) {
            $inscricoes = array_column($participantes, 'num_inscricao');
            $consultaPermitidas = Mockery::mock();
            $consultaPermitidas->shouldReceive('join')->once()->andReturnSelf();
            $consultaPermitidas->shouldReceive('selectRaw')->once()->andReturnSelf();
            $consultaPermitidas->shouldReceive('whereIn')->once()->andReturnSelf();
            $consultaPermitidas->shouldReceive('distinct')->once()->andReturnSelf();
            $consultaPermitidas->shouldReceive('pluck')->once()->with('num_inscricao')->andReturn(collect($inscricoes));
            DB::shouldReceive('table')->once()->with('VW_VOLUNTARIO_PERFIL_EFETIVO as v')->andReturn($consultaPermitidas);
            DB::shouldReceive('raw')->zeroOrMoreTimes()->andReturnUsing(static fn ($value) => $value);
        }
    }

    private function mockConsultaConflitoParticipante(?object $conflito)
    {
        $consulta = Mockery::mock();
        $consulta->shouldReceive('join')->times(3)->andReturnSelf();
        $consulta->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consulta->shouldReceive('whereRaw')->times(4)->andReturnSelf();
        $consulta->shouldReceive('where')->once()->with('EV.ID', '<>', 77)->andReturnSelf();
        $consulta->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $consulta->shouldReceive('first')->once()->andReturn($conflito);

        return $consulta;
    }

    /**
     * @param  array<int, object>  $eventos
     * @param  array<int, array<int, object>>  $agendasPorEvento
     */
    private function mockEventosVisiveisReplica(array $eventos, array $agendasPorEvento): void
    {
        $consultaEventos = Mockery::mock();
        $consultaEventos->shouldReceive('join')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('orderByRaw')->twice()->andReturnSelf();
        $consultaEventos->shouldReceive('get')->once()->andReturn(collect($eventos));

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO as EV')->andReturn($consultaEventos);

        if ($eventos === []) {
            return;
        }

        $eventoIds = array_map(static fn (object $evento): int => (int) $evento->id, $eventos);
        $agendas = [];
        foreach ($agendasPorEvento as $eventoId => $itens) {
            foreach ($itens as $agenda) {
                $agenda->evento_id = $eventoId;
                $agendas[] = $agenda;
            }
        }

        $consultaAgendas = Mockery::mock();
        $consultaAgendas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaAgendas->shouldReceive('whereIn')->once()->with('EA.EVENTO_ID', $eventoIds)->andReturnSelf();
        $consultaAgendas->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $consultaAgendas->shouldReceive('get')->once()->andReturn(collect($agendas));

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_AGENDA as EA')->andReturn($consultaAgendas);
    }

    private function eventoReplica(int $id, string $statusCodigo): object
    {
        return (object) [
            'id' => $id,
            'processo_eleitoral_id' => 321,
            'nome' => 'Evento '.$id,
            'local' => 'SEDE',
            'atividade' => 'Atividade',
            'status_codigo' => $statusCodigo,
            'processo_nome' => 'Ação Teste',
        ];
    }

    private function agendaReplica(): object
    {
        return (object) [
            'dt_inicio' => '2026-10-03T08:00',
            'dt_fim' => '2026-10-03T18:00',
            'dt_inicio_formatado' => '03/10/2026 08:00',
            'dt_fim_formatado' => '03/10/2026 18:00',
        ];
    }

    /** @return array<string, mixed> */
    private function eventoParaOrdenacaoPdf(int $id, int $processoId, string $nome, ?string $inicio): array
    {
        return [
            'id' => $id,
            'processo_eleitoral_id' => $processoId,
            'processo_nome' => 'Ação '.$processoId,
            'nome' => $nome,
            'agendas' => $inicio === null ? [] : [[
                'dt_inicio' => $inicio,
            ]],
        ];
    }

    private function mockBuscaEventoVisivelParaExclusao(string $statusCodigo): void
    {
        $consultaEventos = Mockery::mock();
        $consultaEventos->shouldReceive('join')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaEventos->shouldReceive('orderByRaw')->twice()->andReturnSelf();
        $consultaEventos->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'id' => 55,
                'processo_eleitoral_id' => 321,
                'nome' => 'Evento Teste',
                'local' => 'SEDE',
                'atividade' => 'Treinamento',
                'status_codigo' => $statusCodigo,
                'processo_nome' => 'Ação Teste',
            ],
        ]));

        $consultaAgendas = Mockery::mock();
        $consultaAgendas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaAgendas->shouldReceive('whereIn')->once()->with('EA.EVENTO_ID', [55])->andReturnSelf();
        $consultaAgendas->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $consultaAgendas->shouldReceive('get')->once()->andReturn(collect());

        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO as EV')->andReturn($consultaEventos);
        DB::shouldReceive('table')->once()->with('CE_EVENTO_VOLUNTARIO_AGENDA as EA')->andReturn($consultaAgendas);
    }

    private function novoControllerRestrito(?EventoVoluntarioRepositoryInterface $eventoRepository = null): ColaboradorEleitoralController
    {
        $escopoService = Mockery::mock(ColaboradoresEleitoraisEscopoService::class);
        $escopoService->shouldReceive('listarAcoesTrabalhoVisiveis')->once()->with([10])->andReturn([]);
        $escopoService->shouldReceive('usuarioEhPlaneleitoAdmin')->zeroOrMoreTimes()->andReturnFalse();

        return new ColaboradorEleitoralController(
            Mockery::mock(ProcessoEleitoralRepositoryInterface::class),
            Mockery::mock(CandidaturaColaboradorRepositoryInterface::class),
            Mockery::mock(ColaboradorEleitoralEscalaRepositoryInterface::class),
            $this->mockEscopo(EscopoUnidade::restrito([10])),
            Mockery::mock(CandidaturaDecisaoService::class),
            $escopoService,
            $eventoRepository ?? Mockery::mock(EventoVoluntarioRepositoryInterface::class),
            Mockery::mock(ZonaRepository::class)
        );
    }

    private function novoControllerIrrestrito(
        ?EventoVoluntarioRepositoryInterface $eventoRepository = null,
        array $acoesTrabalho = [],
        ?ZonaRepository $zonaRepository = null
    ): ColaboradorEleitoralController {
        $escopoService = Mockery::mock(ColaboradoresEleitoraisEscopoService::class);
        $escopoService->shouldReceive('listarAcoesTrabalhoVisiveis')->zeroOrMoreTimes()->with(null)->andReturn($acoesTrabalho);
        $escopoService->shouldReceive('usuarioEhPlaneleitoAdmin')->zeroOrMoreTimes()->andReturnFalse();

        return new ColaboradorEleitoralController(
            Mockery::mock(ProcessoEleitoralRepositoryInterface::class),
            Mockery::mock(CandidaturaColaboradorRepositoryInterface::class),
            Mockery::mock(ColaboradorEleitoralEscalaRepositoryInterface::class),
            $this->mockEscopo(EscopoUnidade::irrestrito()),
            Mockery::mock(CandidaturaDecisaoService::class),
            $escopoService,
            $eventoRepository ?? Mockery::mock(EventoVoluntarioRepositoryInterface::class),
            $zonaRepository ?? Mockery::mock(ZonaRepository::class)
        );
    }

    private function mockEscopo(EscopoUnidade $escopo): EscopoUnidadeService
    {
        $service = Mockery::mock(EscopoUnidadeService::class);
        $service->shouldReceive('escopoAtual')->andReturn($escopo);

        return $service;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALVOLUNTARIOSEXTERNOSCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralVoluntariosExternosEventosCrudUiTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSCRUDUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ColaboradorEleitoralVoluntariosExternosEventosCrudUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosEventosCrudUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listagem_de_eventos_tem_filtros_exportacao_pdf_e_olhinho_de_participantes(): void
public function listagem_de_eventos_alterna_lista_e_calendario_com_modal_de_detalhes(): void
public function controller_monta_calendario_com_a_colecao_filtrada_antes_da_paginacao(): void
public function formulario_de_evento_usa_lista_simples_de_participantes_sem_lazy_load_na_edicao(): void
public function controller_valida_zona_cadastrada_e_carrega_catalogo_completo_sem_escopo_do_operador(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosEventosCrudUiTest extends TestCase
{
    #[Test]
    public function listagem_de_eventos_tem_filtros_exportacao_pdf_e_olhinho_de_participantes(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/eventos/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Eventos de voluntários externos', $conteudo);
        $this->assertStringContainsString('name="q"', $conteudo);
        $this->assertStringContainsString('Plano de trabalho', $conteudo);
        $this->assertMatchesRegularExpression('/<select[^>]+name="evento_ids\[\]"[^>]+multiple/u', $conteudo);
        $this->assertStringContainsString('name="zona_trabalho_id"', $conteudo);
        $this->assertStringContainsString('Zona onde irá trabalhar', $conteudo);
        $this->assertMatchesRegularExpression(
            '/<select\s+id="filtroZonaTrabalhoEventoVoluntario"(?:(?!disabled).)*?>/su',
            $conteudo
        );
        $this->assertStringContainsString('@foreach($zonasTrabalhoFiltro as $zonaTrabalhoFiltro)', $conteudo);
        $this->assertStringContainsString('@json($eventosFiltroDisponiveis ?? [])', $conteudo);
        $this->assertStringContainsString("window.jQuery(eventosEl).select2", $conteudo);
        $this->assertStringContainsString("window.jQuery(zonaTrabalhoEl).select2", $conteudo);
        $this->assertStringContainsString('Exportar PDF', $conteudo);
        $this->assertStringContainsString('modalExportarPdfEventosVoluntarios', $conteudo);
        $this->assertStringContainsString('Lista de presença', $conteudo);
        $this->assertStringContainsString('name="documento"', $conteudo);
        $this->assertStringContainsString('value="lista_presenca"', $conteudo);
        $this->assertStringContainsString('formtarget="_blank"', $conteudo);
        $this->assertStringContainsString('id="btnListaPresencaEventosVoluntarios"', $conteudo);
        $this->assertStringContainsString('eventosSelecionados.length > 0', $conteudo);
        $this->assertStringContainsString(
            "window.jQuery(eventosEl).on('change.listaPresenca', atualizarListaPresenca)",
            $conteudo
        );
        $this->assertStringContainsString('Novo evento', $conteudo);
        $this->assertStringContainsString('fa-eye', $conteudo);
        $this->assertStringContainsString('data-evento-participantes-toggle', $conteudo);
        $this->assertStringContainsString('eventos.excluir', $conteudo);
        $this->assertStringContainsString('$evento[\'pode_excluir\']', $conteudo);
        $this->assertStringContainsString('@method(\'DELETE\')', $conteudo);
        $this->assertStringContainsString('fa-trash', $conteudo);
        $this->assertStringContainsString('modalReplicarParticipantesEventoVoluntario', $conteudo);
        $this->assertStringContainsString('data-evento-replicar-toggle', $conteudo);
        $this->assertStringContainsString('fa-copy', $conteudo);
        $this->assertStringContainsString('Replicar participantes', $conteudo);
        $this->assertStringContainsString('eventos.replicar-participantes', $conteudo);
        $this->assertStringContainsString('$eventosDestinoReplica', $conteudo);
        $this->assertStringContainsString('name="evento_ids[]"', $conteudo);
        $this->assertStringContainsString('name="zona_trabalho_id"', $conteudo);
    }

    #[Test]
    public function listagem_de_eventos_alterna_lista_e_calendario_com_modal_de_detalhes(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/eventos/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="btnEventosLista"', $conteudo);
        $this->assertStringContainsString('id="btnEventosCalendario"', $conteudo);
        $this->assertStringContainsString('id="eventosVisualizacaoLista" class="card shadow-sm"', $conteudo);
        $this->assertStringContainsString('id="eventosVisualizacaoCalendario" class="card shadow-sm d-none"', $conteudo);
        $this->assertStringContainsString('id="calendarioEventosVoluntarios"', $conteudo);
        $this->assertStringContainsString('Nenhuma agenda de evento encontrada com os filtros ativos.', $conteudo);
        $this->assertStringContainsString('vendor/fullcalendar/index.global.min.js', $conteudo);
        $this->assertStringContainsString('@json($eventosCalendario ?? [])', $conteudo);
        $this->assertStringContainsString("initialView: 'dayGridMonth'", $conteudo);
        $this->assertStringContainsString("locale: 'pt-br'", $conteudo);
        $this->assertStringContainsString('hour12: false', $conteudo);
        $this->assertStringContainsString('eventClick:', $conteudo);
        $this->assertStringContainsString('id="modalDetalhesEventoCalendario"', $conteudo);
        $this->assertStringContainsString('id="eventoCalendarioEditar"', $conteudo);
        $this->assertStringContainsString('Editar evento', $conteudo);
    }

    #[Test]
    public function controller_monta_calendario_com_a_colecao_filtrada_antes_da_paginacao(): void
    {
        $conteudo = file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php'));

        $this->assertIsString($conteudo);
        $trechoCalendario = '$eventosCalendario = $this->montarEventosCalendarioVoluntariosExternos($eventos);';
        $trechoPaginacao = '$eventosPaginados = $this->paginarColecaoValores($eventos, 15, $request);';
        $posicaoCalendario = strpos($conteudo, $trechoCalendario);
        $posicaoPaginacao = strpos($conteudo, $trechoPaginacao);

        $this->assertIsInt($posicaoCalendario);
        $this->assertIsInt($posicaoPaginacao);
        $this->assertLessThan($posicaoPaginacao, $posicaoCalendario);
        $this->assertStringContainsString("'eventosCalendario' => \$eventosCalendario", $conteudo);
    }

    #[Test]
    public function formulario_de_evento_usa_lista_simples_de_participantes_sem_lazy_load_na_edicao(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/eventos/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Voluntários do evento', $conteudo);
        $this->assertStringContainsString('Selecione o voluntário', $conteudo);
        $this->assertStringContainsString('Adicionar voluntário', $conteudo);
        $this->assertStringContainsString('data-participantes-lista', $conteudo);
        $this->assertStringContainsString('data-participantes-template', $conteudo);
        $this->assertStringContainsString('participanteVoluntarioSelect', $conteudo);
        $this->assertStringContainsString('Zona onde Vota', $conteudo);
        $this->assertStringContainsString('Zona onde irá trabalhar', $conteudo);
        $this->assertStringContainsString('name="participantes[{{ $index }}][zona_trabalho_id]"', $conteudo);
        $this->assertStringContainsString('name="participantes[__INDEX__][zona_trabalho_id]"', $conteudo);
        $this->assertStringContainsString('@foreach($zonasTrabalho as $zonaTrabalho)', $conteudo);
        $this->assertStringContainsString('data-participante-zona-voto', $conteudo);
        $this->assertStringNotContainsString('participantes_carregados', $conteudo);
        $this->assertStringNotContainsString('data-participantes-url', $conteudo);
        $this->assertStringNotContainsString('Carregando participantes vinculados', $conteudo);
        $this->assertStringContainsString('Cancelar', $conteudo);
        $this->assertStringContainsString('Salvar evento', $conteudo);
        $this->assertStringContainsString('formExcluirEventoVoluntario', $conteudo);
        $this->assertStringContainsString('$podeExcluirEvento', $conteudo);
        $this->assertStringContainsString('@method(\'DELETE\')', $conteudo);
        $this->assertGreaterThan(
            strpos($conteudo, 'Voluntários do evento'),
            strpos($conteudo, 'Salvar evento')
        );
    }

    #[Test]
    public function controller_valida_zona_cadastrada_e_carrega_catalogo_completo_sem_escopo_do_operador(): void
    {
        $conteudo = file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php'));

        $this->assertIsString($conteudo);
        $this->assertSame(
            2,
            substr_count(
                $conteudo,
                "'participantes.*.zona_trabalho_id' => ['nullable', 'integer', Rule::exists('ZONA', 'ID')]"
            )
        );
        $this->assertStringContainsString("'zonasTrabalho' => \$this->zonaRepository->listar()", $conteudo);
        $this->assertStringContainsString("'zonasTrabalhoFiltro' => \$this->zonaRepository->listar()", $conteudo);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSCRUDUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlCadastroEleitoralAgendamentoAdminRepositoryTest.php`
## <TESTS_UNIT_AUDITADMLCADASTROELEITORALAGENDAMENTOADMINREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlCadastroEleitoralAgendamentoAdminRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlCadastroEleitoralAgendamentoAdminRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_salvar_tipo_guiche_registra_auditoria_insert(): void
public function test_remover_guiche_registra_auditoria_dos_vinculos_e_do_guiche(): void
public function test_sincronizar_servicos_guiches_registra_delete_e_insert_reais(): void
public function test_atualizar_status_agendamento_registra_auditoria_update(): void
private function registrarRepositorioAuditoriaFalso(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoAdminRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class AuditaDmlCadastroEleitoralAgendamentoAdminRepositoryTest extends TestCase
{
    private array $auditPayloads = [];

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $this->registrarRepositorioAuditoriaFalso();
        session([
            'user' => [
                'username' => 'admin.agendamento',
                'name' => 'Admin Agendamento',
            ],
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_salvar_tipo_guiche_registra_auditoria_insert(): void
    {
        $builderDuplicado = Mockery::mock();
        $builderDuplicado->shouldReceive('whereRaw')->once()->with('UPPER(codigo) = ?', ['ATD'])->andReturnSelf();
        $builderDuplicado->shouldReceive('when')->once()->andReturnSelf();
        $builderDuplicado->shouldReceive('exists')->once()->andReturnFalse();

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['codigo'] === 'ATD'
                && $payload['nome'] === 'Atendimento'
                && $payload['usuario_criacao'] === 'admin.agendamento';
        }), 'id_tipo_guiche')->andReturn(21);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_tipo_guiche', 21)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_tipo_guiche' => 21,
            'codigo' => 'ATD',
            'nome' => 'Atendimento',
        ]);

        DB::shouldReceive('table')->once()->with('cad_tipo_guiche')->andReturn($builderDuplicado);
        DB::shouldReceive('table')->once()->with('cad_tipo_guiche')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('cad_tipo_guiche')->andReturn($builderDepois);

        $repository = new CadastroEleitoralAgendamentoAdminRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            app(\App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada::class),
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $id = $repository->salvarTipoGuiche([
            'codigo' => 'atd',
            'nome' => 'Atendimento',
            'ativo' => 'S',
        ]);

        $this->assertSame(21, $id);
        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('CAD_TIPO_GUICHE', $this->auditPayloads[0]['entidade']);
        $this->assertSame('21', $this->auditPayloads[0]['registro_id']);
    }

    public function test_remover_guiche_registra_auditoria_dos_vinculos_e_do_guiche(): void
    {
        $builderAgendamento = Mockery::mock();
        $builderAgendamento->shouldReceive('where')->once()->with('id_guiche', 5)->andReturnSelf();
        $builderAgendamento->shouldReceive('exists')->once()->andReturnFalse();

        $builderVinculosAntes = Mockery::mock();
        $builderVinculosAntes->shouldReceive('where')->once()->with('id_guiche', 5)->andReturnSelf();
        $builderVinculosAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderVinculosAntes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id_guiche' => 5, 'id_servico' => 9],
        ]));

        $builderGuicheAntes = Mockery::mock();
        $builderGuicheAntes->shouldReceive('where')->once()->with('id_guiche', 5)->andReturnSelf();
        $builderGuicheAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderGuicheAntes->shouldReceive('first')->once()->andReturn((object) [
            'id_guiche' => 5,
            'codigo' => 'G1',
        ]);

        $builderVinculosDelete = Mockery::mock();
        $builderVinculosDelete->shouldReceive('where')->once()->with('id_guiche', 5)->andReturnSelf();
        $builderVinculosDelete->shouldReceive('delete')->once()->andReturn(1);

        $builderGuicheDelete = Mockery::mock();
        $builderGuicheDelete->shouldReceive('where')->once()->with('id_guiche', 5)->andReturnSelf();
        $builderGuicheDelete->shouldReceive('delete')->once()->andReturn(1);

        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderAgendamento);
        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderVinculosAntes);
        DB::shouldReceive('table')->once()->with('cad_guiche')->andReturn($builderGuicheAntes);
        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderVinculosDelete);
        DB::shouldReceive('table')->once()->with('cad_guiche')->andReturn($builderGuicheDelete);

        $repository = new CadastroEleitoralAgendamentoAdminRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            app(\App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada::class),
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $repository->removerGuiche(5);

        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('CAD_SERVICO_GUICHE', $this->auditPayloads[0]['entidade']);
        $this->assertSame('DELETE', $this->auditPayloads[1]['acao']);
        $this->assertSame('CAD_GUICHE', $this->auditPayloads[1]['entidade']);
    }

    public function test_sincronizar_servicos_guiches_registra_delete_e_insert_reais(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('id_servico', 3)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id_servico' => 3, 'id_guiche' => 10],
        ]));

        $builderDelete = Mockery::mock();
        $builderDelete->shouldReceive('where')->once()->with('id_servico', 3)->andReturnSelf();
        $builderDelete->shouldReceive('delete')->once()->andReturn(1);

        $builderAntesInsert = Mockery::mock();
        $builderAntesInsert->shouldReceive('where')->once()->with('id_servico', 3)->andReturnSelf();
        $builderAntesInsert->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntesInsert->shouldReceive('get')->once()->andReturn(new Collection);

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insert')->once()->with([
            ['id_servico' => 3, 'id_guiche' => 11],
            ['id_servico' => 3, 'id_guiche' => 12],
        ])->andReturnTrue();

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_servico', 3)->andReturnSelf();
        $builderDepois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id_servico' => 3, 'id_guiche' => 11],
            (object) ['id_servico' => 3, 'id_guiche' => 12],
        ]));

        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderDelete);
        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderAntesInsert);
        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('cad_servico_guiche')->andReturn($builderDepois);

        $repository = new CadastroEleitoralAgendamentoAdminRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            app(\App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada::class),
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $repository->sincronizarServicosGuiches([3], [11, 12]);

        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('CAD_SERVICO_GUICHE', $this->auditPayloads[0]['entidade']);
        $this->assertSame('3', $this->auditPayloads[0]['registro_id']);
        $this->assertSame('INSERT', $this->auditPayloads[1]['acao']);
        $this->assertStringContainsString('12', (string) $this->auditPayloads[1]['dados_depois_json']);
    }

    public function test_atualizar_status_agendamento_registra_auditoria_update(): void
    {
        $builderExistencia = Mockery::mock();
        $builderExistencia->shouldReceive('where')->once()->with('id_agendamento', 9)->andReturnSelf();
        $builderExistencia->shouldReceive('first')->once()->andReturn((object) [
            'id_agendamento' => 9,
            'status' => 'AGENDADO',
        ]);

        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('id_agendamento', 9)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'id_agendamento' => 9,
            'status' => 'AGENDADO',
        ]);

        $builderUpdate = Mockery::mock();
        $builderUpdate->shouldReceive('where')->once()->with('id_agendamento', 9)->andReturnSelf();
        $builderUpdate->shouldReceive('update')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['status'] === 'ATENDIDO'
                && $payload['usuario_atualizacao'] === 'admin.agendamento';
        }))->andReturn(1);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_agendamento', 9)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_agendamento' => 9,
            'status' => 'ATENDIDO',
        ]);

        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderExistencia);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderUpdate);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderDepois);

        $repository = new CadastroEleitoralAgendamentoAdminRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            app(\App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada::class),
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $repository->atualizarStatusAgendamento(9, 'ATENDIDO');

        $this->assertSame('UPDATE', $this->auditPayloads[0]['acao']);
        $this->assertSame('CAD_AGENDAMENTO', $this->auditPayloads[0]['entidade']);
        $this->assertSame('9', $this->auditPayloads[0]['registro_id']);
    }

    private function registrarRepositorioAuditoriaFalso(): void
    {
        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (array $payload): void {
                $this->auditPayloads[] = $payload;
            });

        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }
}
```
</TESTS_UNIT_AUDITADMLCADASTROELEITORALAGENDAMENTOADMINREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlCadastroEleitoralOperacionalRepositoriesTest.php`
## <TESTS_UNIT_AUDITADMLCADASTROELEITORALOPERACIONALREPOSITORIESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlCadastroEleitoralOperacionalRepositoriesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlCadastroEleitoralOperacionalRepositoriesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_criar_agendamento_com_lookup_registra_auditoria_do_eleitor_e_do_agendamento(): void
public function test_atualizar_status_senha_registra_auditoria_da_senha_e_do_evento(): void
public function test_registrar_evento_painel_registra_auditoria_insert(): void
public function test_salvar_config_painel_registra_auditoria_insert(): void
private function registrarRepositorioAuditoriaFalso(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoRepository;
use App\Repositories\CadastroEleitoral\CadastroEleitoralFilaRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class AuditaDmlCadastroEleitoralOperacionalRepositoriesTest extends TestCase
{
    private array $auditPayloads = [];

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $this->registrarRepositorioAuditoriaFalso();
        session([
            'user' => [
                'username' => 'operador.sistema',
                'name' => 'Operador Sistema',
            ],
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_criar_agendamento_com_lookup_registra_auditoria_do_eleitor_e_do_agendamento(): void
    {
        $builderServico = Mockery::mock();
        $builderServico->shouldReceive('where')->once()->with('id_servico', 3)->andReturnSelf();
        $builderServico->shouldReceive('where')->once()->with('ativo', 'S')->andReturnSelf();
        $builderServico->shouldReceive('first')->once()->andReturn((object) ['duracao_minutos' => 20]);

        $builderCadEleitorInsert = Mockery::mock();
        $builderCadEleitorInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['nome'] === 'MARIA TESTE'
                && $payload['telefone'] === '68999990000'
                && $payload['usuario_criacao'] === 'operador.sistema';
        }), 'id_eleitor')->andReturn(91);

        $builderGuiches = Mockery::mock();
        $builderGuiches->shouldReceive('where')->once()->with('id_unidade', 10)->andReturnSelf();
        $builderGuiches->shouldReceive('where')->once()->with('ativo', 'S')->andReturnSelf();
        $builderGuiches->shouldReceive('orderBy')->once()->with('id_guiche')->andReturnSelf();
        $builderGuiches->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderGuiches->shouldReceive('get')->once()->with(['id_guiche'])->andReturn(new Collection([
            (object) ['id_guiche' => 7],
        ]));

        $builderOcupacao = Mockery::mock();
        $builderOcupacao->shouldReceive('where')->once()->with('id_guiche', 7)->andReturnSelf();
        $builderOcupacao->shouldReceive('whereIn')->once()->with('status', ['AGENDADO', 'ATENDIDO'])->andReturnSelf();
        $builderOcupacao->shouldReceive('whereRaw')->once()->with('? < dt_fim', ['2026-05-26 08:00:00'])->andReturnSelf();
        $builderOcupacao->shouldReceive('whereRaw')->once()->with('? > dt_inicio', ['2026-05-26 08:20:00'])->andReturnSelf();
        $builderOcupacao->shouldReceive('exists')->once()->andReturnFalse();

        $builderProtocolo = Mockery::mock();
        $builderProtocolo->shouldReceive('where')->once()->with('protocolo', Mockery::type('string'))->andReturnSelf();
        $builderProtocolo->shouldReceive('exists')->once()->andReturnFalse();

        $builderAgendamentoInsert = Mockery::mock();
        $builderAgendamentoInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['id_unidade'] === 10
                && $payload['id_guiche'] === 7
                && $payload['id_servico'] === 3
                && $payload['id_eleitor'] === 91
                && $payload['status'] === 'AGENDADO';
        }), 'id_agendamento')->andReturn(101);

        $builderCadEleitorDepois = Mockery::mock();
        $builderCadEleitorDepois->shouldReceive('where')->once()->with('id_eleitor', 91)->andReturnSelf();
        $builderCadEleitorDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_eleitor' => 91,
            'nome' => 'MARIA TESTE',
        ]);

        $builderAgendamentoDepois = Mockery::mock();
        $builderAgendamentoDepois->shouldReceive('where')->once()->with('id_agendamento', 101)->andReturnSelf();
        $builderAgendamentoDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_agendamento' => 101,
            'id_eleitor' => 91,
            'status' => 'AGENDADO',
        ]);

        DB::shouldReceive('table')->once()->with('cad_servico')->andReturn($builderServico);
        DB::shouldReceive('table')->once()->with('cad_eleitor')->andReturn($builderCadEleitorInsert);
        DB::shouldReceive('table')->once()->with('cad_guiche')->andReturn($builderGuiches);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderOcupacao);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderProtocolo);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderAgendamentoInsert);
        DB::shouldReceive('table')->once()->with('cad_eleitor')->andReturn($builderCadEleitorDepois);
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builderAgendamentoDepois);

        $repository = new CadastroEleitoralAgendamentoRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            app(\App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada::class),
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $resultado = $repository->criarAgendamentoComLookup([
            'id_unidade' => 10,
            'id_servico' => 3,
            'dt_inicio' => '2026-05-26 08:00:00',
            'nome' => 'MARIA TESTE',
            'telefone' => '68999990000',
            'email' => 'maria@teste.com',
        ]);

        $this->assertSame(101, $resultado['id_agendamento']);
        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('CAD_ELEITOR', $this->auditPayloads[0]['entidade']);
        $this->assertSame('CAD_AGENDAMENTO', $this->auditPayloads[1]['entidade']);
    }

    public function test_atualizar_status_senha_registra_auditoria_da_senha_e_do_evento(): void
    {
        $builderSenhaAtual = Mockery::mock();
        $builderSenhaAtual->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $builderSenhaAtual->shouldReceive('selectRaw')->once()->andReturnSelf();
        $builderSenhaAtual->shouldReceive('where')->once()->with('fs.id_fila_senha', 55)->andReturnSelf();
        $builderSenhaAtual->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_senha' => 55,
            'status' => 'CHAMADA',
            'sigla' => 'A',
            'numero_senha' => 12,
            'id_guiche' => 4,
            'id_servico' => 8,
        ]);

        $builderSenhaAntes = Mockery::mock();
        $builderSenhaAntes->shouldReceive('where')->once()->with('id_fila_senha', 55)->andReturnSelf();
        $builderSenhaAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderSenhaAntes->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_senha' => 55,
            'status' => 'CHAMADA',
        ]);

        $builderSenhaUpdate = Mockery::mock();
        $builderSenhaUpdate->shouldReceive('where')->once()->with('id_fila_senha', 55)->andReturnSelf();
        $builderSenhaUpdate->shouldReceive('update')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['status'] === 'EM_ATENDIMENTO'
                && $payload['usuario_atualizacao'] === 'operador.sistema';
        }))->andReturn(1);

        $builderSenhaDepois = Mockery::mock();
        $builderSenhaDepois->shouldReceive('where')->once()->with('id_fila_senha', 55)->andReturnSelf();
        $builderSenhaDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_senha' => 55,
            'status' => 'EM_ATENDIMENTO',
        ]);

        $builderEventoInsert = Mockery::mock();
        $builderEventoInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['id_fila_senha'] === 55
                && $payload['tipo_evento'] === 'INICIO'
                && $payload['status_anterior'] === 'CHAMADA'
                && $payload['status_novo'] === 'EM_ATENDIMENTO';
        }), 'id_fila_evento')->andReturn(501);

        $builderEventoDepois = Mockery::mock();
        $builderEventoDepois->shouldReceive('where')->once()->with('id_fila_evento', 501)->andReturnSelf();
        $builderEventoDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_evento' => 501,
            'id_fila_senha' => 55,
            'tipo_evento' => 'INICIO',
        ]);

        $builderSenhaFinal = Mockery::mock();
        $builderSenhaFinal->shouldReceive('leftJoin')->twice()->andReturnSelf();
        $builderSenhaFinal->shouldReceive('selectRaw')->once()->andReturnSelf();
        $builderSenhaFinal->shouldReceive('where')->once()->with('fs.id_fila_senha', 55)->andReturnSelf();
        $builderSenhaFinal->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_senha' => 55,
            'status' => 'EM_ATENDIMENTO',
            'sigla' => 'A',
            'numero_senha' => 12,
            'id_guiche' => 4,
            'id_servico' => 8,
        ]);

        DB::shouldReceive('table')->once()->with('cad_fila_senha as fs')->andReturn($builderSenhaAtual);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderSenhaAntes);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderSenhaUpdate);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderSenhaDepois);
        DB::shouldReceive('table')->once()->with('cad_fila_evento')->andReturn($builderEventoInsert);
        DB::shouldReceive('table')->once()->with('cad_fila_evento')->andReturn($builderEventoDepois);
        DB::shouldReceive('table')->once()->with('cad_fila_senha as fs')->andReturn($builderSenhaFinal);

        $repository = new CadastroEleitoralFilaRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            null,
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $resultado = $repository->atualizarStatusSenha(55, 'EM_ATENDIMENTO');

        $this->assertSame('EM_ATENDIMENTO', $resultado['status']);
        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('CAD_FILA_SENHA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('CAD_FILA_EVENTO', $this->auditPayloads[1]['entidade']);
    }

    public function test_registrar_evento_painel_registra_auditoria_insert(): void
    {
        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['id_unidade'] === 10
                && $payload['id_fila_senha'] === 55
                && $payload['mensagem'] === 'Guiche 4';
        }), 'id_painel_evento')->andReturn(701);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_painel_evento', 701)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_painel_evento' => 701,
            'id_unidade' => 10,
        ]);

        DB::shouldReceive('table')->once()->with('cad_fila_painel_evento')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('cad_fila_painel_evento')->andReturn($builderDepois);

        $repository = new CadastroEleitoralFilaRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            null,
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $id = $repository->registrarEventoPainel([
            'id_unidade' => 10,
            'id_fila_senha' => 55,
            'id_servico' => 8,
            'sigla' => 'A',
            'numero_senha' => 12,
            'mensagem' => 'Guiche 4',
            'local_tipo' => 'Guichê',
            'local_numero' => '4',
        ]);

        $this->assertSame(701, $id);
        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('CAD_FILA_PAINEL_EVENTO', $this->auditPayloads[0]['entidade']);
    }

    public function test_salvar_config_painel_registra_auditoria_insert(): void
    {
        $builderAtual = Mockery::mock();
        $builderAtual->shouldReceive('where')->once()->with('id_unidade', 10)->andReturnSelf();
        $builderAtual->shouldReceive('first')->once()->andReturn(null);

        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('id_unidade', 10)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('get')->once()->andReturn(new Collection);

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insert')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['id_unidade'] === 10
                && $payload['titulo_painel'] === 'Painel Central'
                && $payload['usuario_atualizacao'] === 'operador.sistema';
        }))->andReturnTrue();

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_unidade', 10)->andReturnSelf();
        $builderDepois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id_unidade' => 10, 'titulo_painel' => 'Painel Central'],
        ]));

        DB::shouldReceive('table')->once()->with('cad_fila_config_unidade')->andReturn($builderAtual);
        DB::shouldReceive('table')->once()->with('cad_fila_config_unidade')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('cad_fila_config_unidade')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('cad_fila_config_unidade')->andReturn($builderDepois);

        $repository = new CadastroEleitoralFilaRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            null,
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );
        $repository->salvarConfigPainel(10, ['titulo_painel' => 'Painel Central']);

        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('CAD_FILA_CONFIG_UNIDADE', $this->auditPayloads[0]['entidade']);
    }

    private function registrarRepositorioAuditoriaFalso(): void
    {
        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (array $payload): void {
                $this->auditPayloads[] = $payload;
            });

        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }
}
```
</TESTS_UNIT_AUDITADMLCADASTROELEITORALOPERACIONALREPOSITORIESTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlColaboradorEleitoralEscalaRepositoryTest.php`
## <TESTS_UNIT_AUDITADMLCOLABORADORELEITORALESCALAREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlColaboradorEleitoralEscalaRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlColaboradorEleitoralEscalaRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_criar_registra_auditoria_insert(): void
public function test_atualizar_registra_auditoria_update(): void
public function test_remover_registra_auditoria_delete(): void
public function test_selecionar_com_escalas_registra_inserts_apos_transacao(): void
public function test_remover_por_processo_e_inscricoes_registra_um_delete_coletivo(): void
private function registrarRepositorioAuditoriaFalso(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\ColaboradorEleitoralEscalaRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class AuditaDmlColaboradorEleitoralEscalaRepositoryTest extends TestCase
{
    private array $auditPayloads = [];

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $this->registrarRepositorioAuditoriaFalso();
        session([
            'user' => [
                'username' => 'gestor.escalas',
                'name' => 'Gestor Escalas',
            ],
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_criar_registra_auditoria_insert(): void
    {
        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['PROCESSO_ELEITORAL_ID'] === 7
                && $payload['NUM_INSCRICAO'] === '123'
                && $payload['HORA_INICIO'] === '08:00'
                && $payload['LOCAL'] === 'Cartório';
        }), 'id')->andReturn(44);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('ID', 44)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id' => 44,
            'processo_eleitoral_id' => 7,
        ]);

        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderDepois);

        $repository = new ColaboradorEleitoralEscalaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $id = $repository->criar(7, '123', [
            'data_convocacao' => '2026-05-27',
            'hora_inicio' => '08:00',
            'hora_fim' => '10:00',
            'local' => 'Cartório',
            'atividade' => 'Apoio',
        ]);

        $this->assertSame(44, $id);
        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('CE_SELECAO_ESCALA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('44', $this->auditPayloads[0]['registro_id']);
    }

    public function test_atualizar_registra_auditoria_update(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('ID', 44)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'id' => 44,
            'hora_inicio' => '08:00',
        ]);

        $builderUpdate = Mockery::mock();
        $builderUpdate->shouldReceive('where')->once()->with('ID', 44)->andReturnSelf();
        $builderUpdate->shouldReceive('update')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['HORA_INICIO'] === '09:00'
                && $payload['HORA_FIM'] === '11:00'
                && $payload['LOCAL'] === 'Fórum'
                && $payload['DT_ATUALIZACAO'] === 'SYSDATE';
        }))->andReturn(1);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('ID', 44)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id' => 44,
            'hora_inicio' => '09:00',
        ]);

        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderUpdate);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderDepois);

        $repository = new ColaboradorEleitoralEscalaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->atualizar(44, [
            'data_convocacao' => '2026-05-27',
            'hora_inicio' => '09:00',
            'hora_fim' => '11:00',
            'local' => 'Fórum',
            'atividade' => 'Recepção',
        ]);

        $this->assertSame('UPDATE', $this->auditPayloads[0]['acao']);
        $this->assertSame('CE_SELECAO_ESCALA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('44', $this->auditPayloads[0]['registro_id']);
    }

    public function test_remover_registra_auditoria_delete(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('ID', 44)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'id' => 44,
            'processo_eleitoral_id' => 7,
        ]);

        $builderDelete = Mockery::mock();
        $builderDelete->shouldReceive('where')->once()->with('ID', 44)->andReturnSelf();
        $builderDelete->shouldReceive('delete')->once()->andReturn(1);

        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderDelete);

        $repository = new ColaboradorEleitoralEscalaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->remover(44);

        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('CE_SELECAO_ESCALA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('44', $this->auditPayloads[0]['registro_id']);
    }

    public function test_selecionar_com_escalas_registra_inserts_apos_transacao(): void
    {
        $builderExists1 = Mockery::mock();
        $builderExists1->shouldReceive('where')->once()->with('PROCESSO_ELEITORAL_ID', 9)->andReturnSelf();
        $builderExists1->shouldReceive('whereRaw')->once()->with('TRIM(NUM_INSCRICAO) = ?', ['111'])->andReturnSelf();
        $builderExists1->shouldReceive('whereRaw')->once()->with("TO_CHAR(DATA_CONVOCACAO, 'YYYY-MM-DD') = ?", ['2026-05-28'])->andReturnSelf();
        $builderExists1->shouldReceive('whereRaw')->once()->with('HORA_INICIO < ?', ['10:00'])->andReturnSelf();
        $builderExists1->shouldReceive('whereRaw')->once()->with('HORA_FIM > ?', ['08:00'])->andReturnSelf();
        $builderExists1->shouldReceive('exists')->once()->andReturnFalse();

        $builderExists2 = Mockery::mock();
        $builderExists2->shouldReceive('where')->once()->with('PROCESSO_ELEITORAL_ID', 9)->andReturnSelf();
        $builderExists2->shouldReceive('whereRaw')->once()->with('TRIM(NUM_INSCRICAO) = ?', ['222'])->andReturnSelf();
        $builderExists2->shouldReceive('whereRaw')->once()->with("TO_CHAR(DATA_CONVOCACAO, 'YYYY-MM-DD') = ?", ['2026-05-28'])->andReturnSelf();
        $builderExists2->shouldReceive('whereRaw')->once()->with('HORA_INICIO < ?', ['10:00'])->andReturnSelf();
        $builderExists2->shouldReceive('whereRaw')->once()->with('HORA_FIM > ?', ['08:00'])->andReturnSelf();
        $builderExists2->shouldReceive('exists')->once()->andReturnFalse();

        $builderInsert1 = Mockery::mock();
        $builderInsert1->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['NUM_INSCRICAO'] === '111'
                && $payload['LOCAL'] === 'TRE';
        }), 'id')->andReturn(101);

        $builderInsert2 = Mockery::mock();
        $builderInsert2->shouldReceive('insertGetId')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['NUM_INSCRICAO'] === '222'
                && $payload['ATIVIDADE'] === 'Apoio externo';
        }), 'id')->andReturn(102);

        $builderDepois1 = Mockery::mock();
        $builderDepois1->shouldReceive('where')->once()->with('ID', 101)->andReturnSelf();
        $builderDepois1->shouldReceive('first')->once()->andReturn((object) ['id' => 101, 'num_inscricao' => '111']);

        $builderDepois2 = Mockery::mock();
        $builderDepois2->shouldReceive('where')->once()->with('ID', 102)->andReturnSelf();
        $builderDepois2->shouldReceive('first')->once()->andReturn((object) ['id' => 102, 'num_inscricao' => '222']);

        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderExists1);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderInsert1);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderDepois1);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderExists2);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderInsert2);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderDepois2);

        $repository = new ColaboradorEleitoralEscalaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->selecionarComEscalas(9, ['111', '222'], [[
            'data_convocacao' => '2026-05-28',
            'hora_inicio' => '08:00',
            'hora_fim' => '10:00',
            'local' => 'TRE',
            'atividade' => 'Apoio externo',
        ]]);

        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('101', $this->auditPayloads[0]['registro_id']);
        $this->assertSame('102', $this->auditPayloads[1]['registro_id']);
    }

    public function test_remover_por_processo_e_inscricoes_registra_um_delete_coletivo(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('PROCESSO_ELEITORAL_ID', 9)->andReturnSelf();
        $builderAntes->shouldReceive('whereIn')->once()->with('NUM_INSCRICAO', ['111', '222'])->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 201, 'num_inscricao' => '111'],
            (object) ['id' => 202, 'num_inscricao' => '222'],
        ]));

        $builderDelete = Mockery::mock();
        $builderDelete->shouldReceive('where')->once()->with('PROCESSO_ELEITORAL_ID', 9)->andReturnSelf();
        $builderDelete->shouldReceive('whereIn')->once()->with('NUM_INSCRICAO', ['111', '222'])->andReturnSelf();
        $builderDelete->shouldReceive('delete')->once()->andReturn(2);

        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('CE_SELECAO_ESCALA')->andReturn($builderDelete);

        $repository = new ColaboradorEleitoralEscalaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $removidos = $repository->removerPorProcessoEInscricoes(9, ['111', '222']);

        $this->assertSame(2, $removidos);
        $this->assertCount(1, $this->auditPayloads);
        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('9', $this->auditPayloads[0]['registro_id']);
        $this->assertStringContainsString('111', (string) $this->auditPayloads[0]['dados_antes_json']);
        $this->assertStringContainsString('222', (string) $this->auditPayloads[0]['dados_antes_json']);
    }

    private function registrarRepositorioAuditoriaFalso(): void
    {
        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (array $payload): void {
                $this->auditPayloads[] = $payload;
            });

        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }
}
```
</TESTS_UNIT_AUDITADMLCOLABORADORELEITORALESCALAREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoAdminCadastrosControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINCADASTROSCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoAdminCadastrosControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoAdminCadastrosControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_cadastros_retorna_html_renderizado_das_tabelas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralAgendamentoAdminController;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoAdminService;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralAgendamentoAdminCadastrosControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_cadastros_retorna_html_renderizado_das_tabelas(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('bootstrapCadastros')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [[
                    'id_unidade' => 4,
                    'nome' => 'SEDE DA 4a ZONA ELEITORAL',
                    'zona_eleitoral' => '4',
                    'ativo' => 'N',
                ]],
                'tipos_guiche' => [[
                    'id_tipo_guiche' => 1,
                    'codigo' => 'COMUM',
                    'nome' => 'Comum',
                ]],
                'guiches' => [[
                    'id_guiche' => 10,
                    'id_unidade' => 4,
                    'unidade_nome' => 'SEDE DA 4a ZONA ELEITORAL',
                    'codigo' => 'A1',
                    'tipo_nome' => 'Comum',
                ]],
                'servicos' => [[
                    'id_servico' => 7,
                    'codigo' => 'REVISAO',
                    'nome' => 'Revisao Biometrica',
                    'duracao_minutos' => 30,
                ]],
            ]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);
        $dados = $controller->bootstrapCadastros()->getData(true);

        $this->assertArrayHasKey('html_unidades', $dados);
        $this->assertArrayHasKey('html_tipos_guiche', $dados);
        $this->assertArrayHasKey('html_guiches', $dados);
        $this->assertArrayHasKey('html_servicos', $dados);
        $this->assertStringContainsString('SEDE DA 4a ZONA ELEITORAL', $dados['html_unidades']);
        $this->assertStringContainsString('Inativa', $dados['html_unidades']);
        $this->assertStringContainsString('Comum', $dados['html_tipos_guiche']);
        $this->assertStringContainsString('A1', $dados['html_guiches']);
        $this->assertStringContainsString('Revisao Biometrica', $dados['html_servicos']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINCADASTROSCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoAdminLeituraControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINLEITURACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoAdminLeituraControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoAdminLeituraControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_funcionamento_retorna_html_renderizado_da_tabela(): void
public function test_listar_funcionamentos_retorna_html_renderizado_da_tabela(): void
public function test_bootstrap_monitoramento_retorna_html_renderizado_da_tabela(): void
public function test_listar_agendamentos_retorna_html_renderizado_da_tabela(): void
public function test_listar_slots_retorna_html_renderizado_da_tabela(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralAgendamentoAdminController;
use App\Http\Requests\CadastroEleitoral\CadastroEleitoralAgendamentoAdminAgendamentoListRequest;
use App\Http\Requests\CadastroEleitoral\CadastroEleitoralAgendamentoAdminFuncionamentoListRequest;
use App\Http\Requests\CadastroEleitoral\CadastroEleitoralAgendamentoAdminSlotsListRequest;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoAdminService;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralAgendamentoAdminLeituraControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_funcionamento_retorna_html_renderizado_da_tabela(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('bootstrapFuncionamento')
            ->once()
            ->andReturn([
                'unidades' => [['id_unidade' => 4, 'nome' => 'SEDE DA 4a ZONA ELEITORAL', 'zona_eleitoral' => '4']],
                'funcionamentos' => [[
                    'id_funcionamento' => 99,
                    'unidade_nome' => 'SEDE DA 4a ZONA ELEITORAL',
                    'data_funcionamento' => '2026-04-20',
                    'data_funcionamento_fmt' => '20/04/2026',
                    'hora_inicio' => '07:00',
                    'hora_fim' => '14:00',
                ]],
            ]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);
        $dados = $controller->bootstrapFuncionamento()->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('20/04/2026', $dados['html']);
        $this->assertStringContainsString('js-edit-funcionamento', $dados['html']);
    }

    public function test_listar_funcionamentos_retorna_html_renderizado_da_tabela(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('listarFuncionamentos')
            ->once()
            ->with(['id_unidade' => 4])
            ->andReturn([[
                'id_funcionamento' => 99,
                'unidade_nome' => 'SEDE DA 4a ZONA ELEITORAL',
                'data_funcionamento' => '2026-04-20',
                'data_funcionamento_fmt' => '20/04/2026',
                'hora_inicio' => '07:00',
                'hora_fim' => '14:00',
            ]]);

        $request = Mockery::mock(CadastroEleitoralAgendamentoAdminFuncionamentoListRequest::class);
        $request->shouldReceive('validated')->once()->andReturn(['id_unidade' => 4]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);
        $dados = $controller->listarFuncionamentos($request)->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('SEDE DA 4a ZONA ELEITORAL', $dados['html']);
    }

    public function test_bootstrap_monitoramento_retorna_html_renderizado_da_tabela(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('bootstrapMonitoramento')
            ->once()
            ->andReturn([
                'unidades' => [['id_unidade' => 4, 'nome' => 'SEDE DA 4a ZONA ELEITORAL', 'zona_eleitoral' => '4']],
                'agendamentos' => [[
                    'id_agendamento' => 11,
                    'protocolo' => 'AG202604041938450577',
                    'cad_eleitor_nome' => 'EDCLEY DA SILVA FIRMINO',
                    'titulo_ou_cpf' => '002266412453',
                    'unidade_nome' => 'DETRAN',
                    'servico_nome' => 'Revisao Biometrica',
                    'dt_inicio_fmt' => '2026-04-05 07:00',
                    'status' => 'AGENDADO',
                ]],
            ]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);
        $dados = $controller->bootstrapMonitoramento()->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('AG202604041938450577', $dados['html']);
        $this->assertStringContainsString('2026-04-05 07:00', $dados['html']);
        $this->assertStringContainsString('js-status-ag', $dados['html']);
    }

    public function test_listar_agendamentos_retorna_html_renderizado_da_tabela(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('listarAgendamentos')
            ->once()
            ->with(['status' => 'ATENDIDO'])
            ->andReturn([[
                'id_agendamento' => 11,
                'protocolo' => 'AG202604041938450577',
                'cad_eleitor_nome' => 'EDCLEY DA SILVA FIRMINO',
                'titulo_ou_cpf' => '002266412453',
                'unidade_nome' => 'DETRAN',
                'servico_nome' => 'Revisao Biometrica',
                'dt_inicio_fmt' => '2026-04-05 07:00',
                'status' => 'ATENDIDO',
            ]]);

        $request = Mockery::mock(CadastroEleitoralAgendamentoAdminAgendamentoListRequest::class);
        $request->shouldReceive('validated')->once()->andReturn(['status' => 'ATENDIDO']);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);
        $dados = $controller->listarAgendamentos($request)->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('ATENDIDO', $dados['html']);
        $this->assertStringContainsString('2026-04-05 07:00', $dados['html']);
    }

    public function test_listar_slots_retorna_html_renderizado_da_tabela(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('listarSlots')
            ->once()
            ->with(['id_unidade' => 4])
            ->andReturn([[
                'data' => '2026-04-20',
                'dt_inicio_fmt' => '2026-04-20 07:00',
                'dt_fim_fmt' => '2026-04-20 07:30',
                'capacidade_total' => 3,
                'ocupados' => 1,
                'vagas_disponiveis' => 2,
            ]]);

        $request = Mockery::mock(CadastroEleitoralAgendamentoAdminSlotsListRequest::class);
        $request->shouldReceive('validated')->once()->andReturn(['id_unidade' => 4]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);
        $dados = $controller->listarSlots($request)->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('2026-04-20 07:00', $dados['html']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINLEITURACONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoAdminRecepcaoControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINRECEPCAOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoAdminRecepcaoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoAdminRecepcaoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_recepcao_retorna_html_renderizado_dos_cards(): void
public function test_listar_recepcao_retorna_html_renderizado_dos_cards(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralAgendamentoAdminController;
use App\Http\Requests\CadastroEleitoral\CadastroEleitoralAgendamentoAdminRecepcaoListRequest;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoAdminService;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralAgendamentoAdminRecepcaoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_recepcao_retorna_html_renderizado_dos_cards(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('bootstrapRecepcao')
            ->once()
            ->andReturn([
                'data_atendimento' => '2026-04-20',
                'unidades' => [
                    ['id_unidade' => 4, 'nome' => 'SEDE DA 4a ZONA ELEITORAL', 'zona_eleitoral' => '4'],
                ],
                'agendamentos' => [
                    [
                        'id_agendamento' => 11,
                        'cad_eleitor_nome' => 'EDCLEY DA SILVA FIRMINO',
                        'titulo_ou_cpf' => '002266412453',
                        'dt_inicio_fmt' => '2026-04-20 07:00',
                        'dt_fim_fmt' => '2026-04-20 07:30',
                        'servico_nome' => 'Revisao Biometrica',
                        'unidade_nome' => 'DETRAN',
                        'guiche_codigo' => 'A1',
                        'protocolo' => 'AG202604041938450577',
                        'status' => 'AGENDADO',
                    ],
                ],
            ]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);

        $response = $controller->bootstrapRecepcao();
        $dados = $response->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('EDCLEY DA SILVA FIRMINO', $dados['html']);
        $this->assertStringContainsString('js-checkin-rec', $dados['html']);
    }

    public function test_listar_recepcao_retorna_html_renderizado_dos_cards(): void
    {
        $service = Mockery::mock(CadastroEleitoralAgendamentoAdminService::class);
        $service->shouldReceive('listarRecepcao')
            ->once()
            ->with(['data' => '2026-04-20'])
            ->andReturn([
                [
                    'id_agendamento' => 11,
                    'cad_eleitor_nome' => 'EDCLEY DA SILVA FIRMINO',
                    'titulo_ou_cpf' => '002266412453',
                    'dt_inicio_fmt' => '2026-04-20 07:00',
                    'dt_fim_fmt' => '2026-04-20 07:30',
                    'servico_nome' => 'Revisao Biometrica',
                    'unidade_nome' => 'DETRAN',
                    'guiche_codigo' => 'A1',
                    'protocolo' => 'AG202604041938450577',
                    'status' => 'ATENDIDO',
                ],
            ]);

        $controller = new CadastroEleitoralAgendamentoAdminController($service);

        $request = Mockery::mock(CadastroEleitoralAgendamentoAdminRecepcaoListRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'data' => '2026-04-20',
        ]);

        $response = $controller->listarRecepcao($request);
        $dados = $response->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('Já atendido', $dados['html']);
        $this->assertStringContainsString('ATENDIDO', $dados['html']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINRECEPCAOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoAdminServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoAdminServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoAdminServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_cadastros_inclui_tipos_de_guiche(): void
public function test_salvar_tipo_guiche_delega_para_repositorio(): void
public function test_bootstrap_cadastros_aplica_escopo_territorial_a_municipios_unidades_e_guiches(): void
public function test_bootstrap_funcionamento_usa_escopo_operacional_de_agendamentos(): void
public function test_bootstrap_slots_aplica_escopo_territorial_a_unidades(): void
public function test_bootstrap_monitoramento_aplica_escopo_territorial_a_unidades_e_agendamentos(): void
public function test_bootstrap_recepcao_aplica_escopo_territorial_a_unidades_e_agendamentos(): void
public function test_listar_recepcao_sem_id_unidade_reaplica_escopo_territorial(): void
public function test_listar_agendamentos_sem_id_unidade_reaplica_escopo_territorial(): void
public function test_listar_relatorios_sem_id_unidade_usa_escopo_operacional_de_agendamentos(): void
public function test_listar_slots_autoriza_unidade_com_escopo_operacional_de_agendamentos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoAdminRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoAdminService;
use Mockery;
use PHPUnit\Framework\TestCase;

class CadastroEleitoralAgendamentoAdminServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_cadastros_inclui_tipos_de_guiche(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidades')->once()->andReturn([]);
        $repository->shouldReceive('listarTiposGuiche')->once()->with('S')->andReturn([
            ['id_tipo_guiche' => 1, 'codigo' => 'COMUM', 'nome' => 'Comum', 'ativo' => 'S'],
        ]);
        $repository->shouldReceive('listarGuiches')->once()->andReturn([]);
        $repository->shouldReceive('listarServicos')->once()->andReturn([]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository);

        $resultado = $service->bootstrapCadastros();

        $this->assertArrayHasKey('tipos_guiche', $resultado);
        $this->assertSame('COMUM', $resultado['tipos_guiche'][0]['codigo']);
    }

    public function test_salvar_tipo_guiche_delega_para_repositorio(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('salvarTipoGuiche')
            ->once()
            ->with(['codigo' => 'COMUM', 'nome' => 'Comum'], null)
            ->andReturn(10);

        $service = new CadastroEleitoralAgendamentoAdminService($repository);

        $id = $service->salvarTipoGuiche(['codigo' => 'COMUM', 'nome' => 'Comum']);

        $this->assertSame(10, $id);
    }

    public function test_bootstrap_cadastros_aplica_escopo_territorial_a_municipios_unidades_e_guiches(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
            ['cod_objeto_localidade' => '200', 'municipio' => 'Cruzeiro', 'zonas' => ['3'], 'zona_eleitoral' => '3'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
            ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
        ];
        $guiches = [
            ['id_guiche' => 1, 'id_unidade' => 10],
            ['id_guiche' => 2, 'id_unidade' => 20],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidades')->once()->andReturn($unidades);
        $repository->shouldReceive('listarTiposGuiche')->once()->with('S')->andReturn([]);
        $repository->shouldReceive('listarGuiches')->once()->andReturn($guiches);
        $repository->shouldReceive('listarServicos')->once()->andReturn([]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => [$municipios[0]],
                'unidades' => [$unidades[0]],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with($guiches, [10])
            ->andReturn([$guiches[0]]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->bootstrapCadastros();

        $this->assertSame(['100'], array_column($resultado['municipios'], 'cod_objeto_localidade'));
        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
        $this->assertSame([1], array_column($resultado['guiches'], 'id_guiche'));
    }

    public function test_bootstrap_funcionamento_usa_escopo_operacional_de_agendamentos(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
            ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
        ];
        $funcionamentos = [
            ['id_funcionamento' => 1, 'id_unidade' => 10],
            ['id_funcionamento' => 2, 'id_unidade' => 20],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarFuncionamentos')->once()->andReturn($funcionamentos);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => [$unidades[0]],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with($funcionamentos, [10])
            ->andReturn([$funcionamentos[0]]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->bootstrapFuncionamento();

        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
        $this->assertSame([1], array_column($resultado['funcionamentos'], 'id_funcionamento'));
    }

    public function test_bootstrap_slots_aplica_escopo_territorial_a_unidades(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
            ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
        ];
        $servicos = [
            ['id_servico' => 1, 'nome' => 'Revisao'],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarServicos')->once()->andReturn($servicos);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => [$unidades[0]],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->bootstrapSlots();

        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
        $this->assertSame($servicos, $resultado['servicos']);
    }

    public function test_bootstrap_monitoramento_aplica_escopo_territorial_a_unidades_e_agendamentos(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
            ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
        ];
        $agendamentos = [
            ['id_agendamento' => 1, 'id_unidade' => 10],
            ['id_agendamento' => 2, 'id_unidade' => 20],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarAgendamentos')->once()->with(['unidade_ids' => [10]])->andReturn([$agendamentos[0]]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => [$unidades[0]],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->bootstrapMonitoramento();

        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
        $this->assertSame([1], array_column($resultado['agendamentos'], 'id_agendamento'));
    }

    public function test_bootstrap_recepcao_aplica_escopo_territorial_a_unidades_e_agendamentos(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
            ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
        ];
        $recepcao = [
            ['id_agendamento' => 1, 'id_unidade' => 10],
            ['id_agendamento' => 2, 'id_unidade' => 20],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarRecepcao')->once()->with(Mockery::on(function (array $filtros): bool {
            return isset($filtros['data'])
                && preg_match('/^\d{4}-\d{2}-\d{2}$/', $filtros['data']) === 1
                && ($filtros['unidade_ids'] ?? null) === [10];
        }))->andReturn([$recepcao[0]]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => [$unidades[0]],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->bootstrapRecepcao();

        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
        $this->assertSame([1], array_column($resultado['agendamentos'], 'id_agendamento'));
        $this->assertMatchesRegularExpression('/^\d{4}-\d{2}-\d{2}$/', $resultado['data_atendimento']);
    }

    public function test_listar_recepcao_sem_id_unidade_reaplica_escopo_territorial(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];
        $recepcao = [
            ['id_agendamento' => 1, 'id_unidade' => 10],
            ['id_agendamento' => 2, 'id_unidade' => 20],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarRecepcao')->once()->with(Mockery::on(function (array $filtros): bool {
            return ($filtros['data'] ?? null) === '2026-04-20'
                && ($filtros['unidade_ids'] ?? null) === [10];
        }))->andReturn([$recepcao[0]]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->listarRecepcao(['data' => '2026-04-20']);

        $this->assertSame([1], array_column($resultado, 'id_agendamento'));
    }

    public function test_listar_agendamentos_sem_id_unidade_reaplica_escopo_territorial(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];
        $agendamentos = [
            ['id_agendamento' => 1, 'id_unidade' => 10],
            ['id_agendamento' => 2, 'id_unidade' => 20],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarAgendamentos')->once()->with([
            'status' => 'ATENDIDO',
            'unidade_ids' => [10],
        ])->andReturn([$agendamentos[0]]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->listarAgendamentos(['status' => 'ATENDIDO']);

        $this->assertSame([1], array_column($resultado, 'id_agendamento'));
    }

    public function test_listar_relatorios_sem_id_unidade_usa_escopo_operacional_de_agendamentos(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];
        $relatorios = [
            ['id_agendamento' => 1, 'id_unidade' => 10],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarRelatorios')->once()->with([
            'data_inicio' => '2026-05-01',
            'unidade_ids' => [10],
        ])->andReturn($relatorios);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->listarRelatorios(['data_inicio' => '2026-05-01']);

        $this->assertSame($relatorios, $resultado);
    }

    public function test_listar_slots_autoriza_unidade_com_escopo_operacional_de_agendamentos(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];
        $slots = [
            ['data' => '2026-05-20', 'vagas_disponiveis' => 2],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('listarSlots')->once()->with([
            'id_unidade' => 10,
            'servico_ids' => [3],
            'data_inicio' => '2026-05-20',
            'data_fim' => '2026-05-20',
        ])->andReturn($slots);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(10, [10]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $resultado = $service->listarSlots([
            'id_unidade' => 10,
            'id_servico' => 3,
            'data_inicio' => '2026-05-20',
            'data_fim' => '2026-05-20',
        ]);

        $this->assertSame($slots, $resultado);
    }

    public function test_salvar_funcionamento_autoriza_unidade_com_escopo_operacional_de_agendamentos(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];
        $dados = [
            'id_unidade' => 10,
            'data_inicio' => '2026-05-20',
            'data_fim' => '2026-05-20',
            'hora_inicio' => '08:00',
            'hora_fim' => '17:00',
        ];
        $salvo = ['id_funcionamento' => 77, 'id_unidade' => 10];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);
        $repository->shouldReceive('salvarFuncionamento')->once()->with($dados, null)->andReturn($salvo);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(10, [10]);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $this->assertSame($salvo, $service->salvarFuncionamento($dados));
    }

    public function test_confirmar_checkin_rejeita_agendamento_fora_do_escopo(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('buscarAgendamento')->once()->with(20)->andReturn([
            'id_agendamento' => 20,
            'id_unidade' => 99,
            'status' => 'AGENDADO',
        ]);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivasParaAgendamentos')->once()->andReturn($unidades);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [10])
            ->andThrow(new \RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->confirmarCheckin(20);
    }

    public function test_salvar_unidade_autoriza_municipio_e_unidade_no_escopo(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];
        $dados = [
            'id_unidade' => 10,
            'nome' => 'Central',
            'endereco' => 'Endereco',
            'cod_objeto_localidade' => '100',
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidades')->once()->andReturn($unidades);
        $repository->shouldReceive('salvarUnidade')->once()->with($dados, 10)->andReturn(10);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(10, [10]);
        $escopoService->shouldReceive('autorizarCodObjetoLocalidade')->once()->with('100', ['100']);

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $this->assertSame(10, $service->salvarUnidade($dados));
    }

    public function test_remover_guiche_rejeita_quando_unidade_do_guiche_esta_fora_do_escopo(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoAdminRepositoryInterface::class);
        $repository->shouldReceive('buscarGuiche')->once()->with(90)->andReturn([
            'id_guiche' => 90,
            'id_unidade' => 99,
        ]);
        $repository->shouldReceive('listarMunicipiosParaCombo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidades')->once()->with('S')->andReturn($unidades);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => $municipios,
                'unidades' => $unidades,
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [10])
            ->andThrow(new \RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralAgendamentoAdminService($repository, $escopoService);

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->removerGuiche(90);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoAdminUnidadeRequestTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINUNIDADEREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoAdminUnidadeRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoAdminUnidadeRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rules_expoem_flags_de_capacidade_da_unidade(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\CadastroEleitoral\CadastroEleitoralAgendamentoAdminUnidadeRequest;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentoAdminUnidadeRequestTest extends TestCase
{
    #[Test]
    public function rules_expoem_flags_de_capacidade_da_unidade(): void
    {
        $request = new CadastroEleitoralAgendamentoAdminUnidadeRequest();
        $rules = $request->rules();

        $this->assertArrayHasKey('usa_filas', $rules);
        $this->assertArrayHasKey('usa_pesquisa_satisfacao', $rules);
        $this->assertArrayHasKey('usa_agendamentos', $rules);
        $this->assertSame(['nullable', 'in:S,N'], $rules['usa_filas']);
        $this->assertSame(['nullable', 'in:S,N'], $rules['usa_pesquisa_satisfacao']);
        $this->assertSame(['nullable', 'in:S,N'], $rules['usa_agendamentos']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOADMINUNIDADEREQUESTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoConsultaCompartilhadaTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOCONSULTACOMPARTILHADATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoConsultaCompartilhadaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoConsultaCompartilhadaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_consumidores_publico_e_administrativo_usam_a_mesma_consulta_de_municipios(): void
public function test_periodos_de_funcionamento_preservam_consulta_e_formato(): void
public function test_disponibilidade_de_guiche_usa_a_mesma_regra_de_sobreposicao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoAdminRepository;
use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoConsultaCompartilhada;
use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoRepository;
use App\Services\Auditoria\AuditLogService;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralAgendamentoConsultaCompartilhadaTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_consumidores_publico_e_administrativo_usam_a_mesma_consulta_de_municipios(): void
    {
        $municipios = [[
            'cod_objeto_localidade' => '10',
            'municipio' => 'RIO BRANCO',
            'zonas' => ['1', '9'],
            'zona_eleitoral' => '1,9',
        ]];
        $consulta = Mockery::mock(CadastroEleitoralAgendamentoConsultaCompartilhada::class);
        $consulta->shouldReceive('listarMunicipios')->twice()->andReturn($municipios);

        $publico = new CadastroEleitoralAgendamentoRepository(app(AuditLogService::class), $consulta);
        $administrativo = new CadastroEleitoralAgendamentoAdminRepository(app(AuditLogService::class), $consulta);

        $this->assertSame($municipios, $publico->listarMunicipiosParaEscopo());
        $this->assertSame($municipios, $administrativo->listarMunicipiosParaCombo());
    }

    public function test_periodos_de_funcionamento_preservam_consulta_e_formato(): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('where')->once()->with('id_unidade', 7)->andReturnSelf();
        $builder->shouldReceive('whereRaw')->once()->with(
            "TRUNC(data_funcionamento) = TO_DATE(?, 'YYYY-MM-DD')",
            ['2026-07-27']
        )->andReturnSelf();
        $builder->shouldReceive('where')->once()->with('ativo', 'S')->andReturnSelf();
        $builder->shouldReceive('orderBy')->once()->with('hora_inicio')->andReturnSelf();
        $builder->shouldReceive('get')->once()->with(['hora_inicio', 'hora_fim'])->andReturn(collect([
            (object) ['hora_inicio' => '08:00', 'hora_fim' => '12:00'],
        ]));
        DB::shouldReceive('table')->once()->with('cad_funcionamento_unidade')->andReturn($builder);

        $resultado = (new CadastroEleitoralAgendamentoConsultaCompartilhada())->listarPeriodosFuncionamentoDia(
            7,
            Carbon::createFromFormat('Y-m-d', '2026-07-27')
        );

        $this->assertSame([['hora_inicio' => '08:00', 'hora_fim' => '12:00']], $resultado);
    }

    public function test_disponibilidade_de_guiche_usa_a_mesma_regra_de_sobreposicao(): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('where')->once()->with('id_guiche', 3)->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->with('status', ['AGENDADO', 'ATENDIDO'])->andReturnSelf();
        $builder->shouldReceive('whereRaw')->once()->with('? < dt_fim', ['2026-07-27 08:00:00'])->andReturnSelf();
        $builder->shouldReceive('whereRaw')->once()->with('? > dt_inicio', ['2026-07-27 08:30:00'])->andReturnSelf();
        $builder->shouldReceive('exists')->once()->andReturnFalse();
        DB::shouldReceive('table')->once()->with('cad_agendamento')->andReturn($builder);

        $disponivel = (new CadastroEleitoralAgendamentoConsultaCompartilhada())->guicheDisponivelNoPeriodo(
            3,
            Carbon::createFromFormat('Y-m-d H:i:s', '2026-07-27 08:00:00'),
            Carbon::createFromFormat('Y-m-d H:i:s', '2026-07-27 08:30:00')
        );

        $this->assertTrue($disponivel);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOCONSULTACOMPARTILHADATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_calendario_retorna_422_quando_unidade_esta_fora_do_escopo(): void
public function test_slots_retorna_422_quando_unidade_esta_fora_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralAgendamentoController;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoDisponibilidadeService;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoReservaService;
use Illuminate\Http\Request;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class CadastroEleitoralAgendamentoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_calendario_retorna_422_quando_unidade_esta_fora_do_escopo(): void
    {
        $disponibilidade = Mockery::mock(CadastroEleitoralAgendamentoDisponibilidadeService::class);
        $disponibilidade->shouldReceive('listarResumoMensal')
            ->once()
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $controller = new CadastroEleitoralAgendamentoController(
            $disponibilidade,
            Mockery::mock(CadastroEleitoralAgendamentoReservaService::class)
        );

        $response = $controller->calendario(new Request([
            'id_unidade' => 99,
            'id_servico' => 1,
            'mes' => '2026-04',
        ]));

        $this->assertSame(422, $response->getStatusCode());
    }

    public function test_slots_retorna_422_quando_unidade_esta_fora_do_escopo(): void
    {
        $disponibilidade = Mockery::mock(CadastroEleitoralAgendamentoDisponibilidadeService::class);
        $disponibilidade->shouldReceive('listarHorariosDisponiveis')
            ->once()
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $controller = new CadastroEleitoralAgendamentoController(
            $disponibilidade,
            Mockery::mock(CadastroEleitoralAgendamentoReservaService::class)
        );

        $response = $controller->slots(new Request([
            'id_unidade' => 99,
            'id_servico' => 1,
            'data' => '2026-04-04',
        ]));

        $this->assertSame(422, $response->getStatusCode());
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoDisponibilidadeServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTODISPONIBILIDADESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoDisponibilidadeServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoDisponibilidadeServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_listar_opcoes_filtra_unidades_pelo_escopo_territorial(): void
public function test_listar_resumo_mensal_rejeita_unidade_fora_do_escopo(): void
public function test_listar_slots_rejeita_unidade_fora_do_escopo(): void
public function test_listar_recentes_reaplica_escopo_territorial(): void
public function test_obter_impressao_rejeita_agendamento_fora_do_escopo(): void
public function test_consultar_eleitor_normaliza_numero_de_inscricao_com_zeros_a_esquerda_ate_12_digitos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoDisponibilidadeService;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use Mockery;
use PHPUnit\Framework\TestCase;
use RuntimeException;

class CadastroEleitoralAgendamentoDisponibilidadeServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_listar_opcoes_filtra_unidades_pelo_escopo_territorial(): void
    {
        $municipios = [
            ['cod_objeto_localidade' => '100', 'municipio' => 'RIO BRANCO', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
            ['cod_objeto_localidade' => '200', 'municipio' => 'CRUZEIRO', 'zonas' => ['3'], 'zona_eleitoral' => '3'],
        ];
        $unidades = [
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
            ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
        ];

        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn($municipios);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn($unidades);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->with($municipios, $unidades, null, null)
            ->andReturn([
                'municipios' => [$municipios[0]],
                'unidades' => [$unidades[0]],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);

        $service = new CadastroEleitoralAgendamentoDisponibilidadeService($repository, $escopoService);

        $resultado = $service->listarOpcoes();

        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
    }

    public function test_listar_resumo_mensal_rejeita_unidade_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([
            ['cod_objeto_localidade' => '100', 'municipio' => 'RIO BRANCO', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralAgendamentoDisponibilidadeService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->listarResumoMensal(99, 1, '2026-04');
    }

    public function test_listar_slots_rejeita_unidade_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([
            ['cod_objeto_localidade' => '100', 'municipio' => 'RIO BRANCO', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralAgendamentoDisponibilidadeService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->listarHorariosDisponiveis(99, 1, '2026-04-04');
    }

    public function test_listar_recentes_reaplica_escopo_territorial(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([
            ['cod_objeto_localidade' => '100', 'municipio' => 'RIO BRANCO', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ]);
        $repository->shouldReceive('listarRecentes')->once()->with(5, '')->andReturn([
            ['id_agendamento' => 1, 'id_unidade' => 10],
            ['id_agendamento' => 2, 'id_unidade' => 20],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with([
                ['id_agendamento' => 1, 'id_unidade' => 10],
                ['id_agendamento' => 2, 'id_unidade' => 20],
            ], [10])
            ->andReturn([
                ['id_agendamento' => 1, 'id_unidade' => 10],
            ]);

        $service = new CadastroEleitoralAgendamentoDisponibilidadeService($repository, $escopoService);

        $resultado = $service->listarRecentes(5, '');

        $this->assertSame([1], array_column($resultado, 'id_agendamento'));
    }

    public function test_obter_impressao_rejeita_agendamento_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('buscarAgendamento')->once()->with(50)->andReturn([
            'id_agendamento' => 50,
            'id_unidade' => 99,
            'status' => 'AGENDADO',
        ]);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([
            ['cod_objeto_localidade' => '100', 'municipio' => 'RIO BRANCO', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [],
                'codigos_objeto_localidade' => ['100'],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [10])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralAgendamentoDisponibilidadeService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->obterAgendamentoParaImpressao(50);
    }

    public function test_consultar_eleitor_normaliza_numero_de_inscricao_com_zeros_a_esquerda_ate_12_digitos(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('buscarEleitorOficialPorInscricao')
            ->once()
            ->with('000000000123')
            ->andReturn((object) [
                'num_inscricao' => '000000000123',
                'nome' => 'Eleitor Teste',
            ]);
        $repository->shouldNotReceive('buscarCadEleitorPorInscricao');

        $service = new CadastroEleitoralAgendamentoDisponibilidadeService($repository);

        $resultado = $service->consultarEleitor('123');

        $this->assertTrue($resultado['encontrado']);
        $this->assertSame('ELEITOR', $resultado['origem']);
        $this->assertSame('000000000123', $resultado['dados']->num_inscricao);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTODISPONIBILIDADESERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoEscopoServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOESCOPOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoEscopoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoEscopoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_aplicar_escopo_territorial_filtra_municipios_e_unidades_pelas_zonas_permitidas(): void
public function test_aplicar_escopo_territorial_nao_restringe_quando_ha_acesso_total(): void
public function test_filtrar_registros_por_unidade_restringe_registros_dependentes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use PHPUnit\Framework\TestCase;

class CadastroEleitoralAgendamentoEscopoServiceTest extends TestCase
{
    public function test_aplicar_escopo_territorial_filtra_municipios_e_unidades_pelas_zonas_permitidas(): void
    {
        $service = new CadastroEleitoralAgendamentoEscopoService();

        $resultado = $service->aplicarEscopoTerritorial(
            municipios: [
                ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1', '2'], 'zona_eleitoral' => '1,2'],
                ['cod_objeto_localidade' => '200', 'municipio' => 'Cruzeiro', 'zonas' => ['3'], 'zona_eleitoral' => '3'],
            ],
            unidades: [
                ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
                ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
            ],
            zonasPermitidas: [2]
        );

        $this->assertSame(['100'], array_column($resultado['municipios'], 'cod_objeto_localidade'));
        $this->assertSame([10], array_column($resultado['unidades'], 'id_unidade'));
        $this->assertSame(['100'], $resultado['codigos_objeto_localidade']);
        $this->assertSame([10], $resultado['unidade_ids']);
    }

    public function test_aplicar_escopo_territorial_nao_restringe_quando_ha_acesso_total(): void
    {
        $service = new CadastroEleitoralAgendamentoEscopoService();

        $resultado = $service->aplicarEscopoTerritorial(
            municipios: [
                ['cod_objeto_localidade' => '100', 'municipio' => 'Rio Branco', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
                ['cod_objeto_localidade' => '200', 'municipio' => 'Cruzeiro', 'zonas' => ['3'], 'zona_eleitoral' => '3'],
            ],
            unidades: [
                ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
                ['id_unidade' => 20, 'nome' => 'Interior', 'cod_objeto_localidade' => '200'],
            ],
            zonasPermitidas: [],
            acessoTodasZonas: true
        );

        $this->assertCount(2, $resultado['municipios']);
        $this->assertCount(2, $resultado['unidades']);
        $this->assertSame([10, 20], $resultado['unidade_ids']);
    }

    public function test_filtrar_registros_por_unidade_restringe_registros_dependentes(): void
    {
        $service = new CadastroEleitoralAgendamentoEscopoService();

        $resultado = $service->filtrarRegistrosPorUnidade(
            [
                ['id_guiche' => 1, 'id_unidade' => 10],
                ['id_guiche' => 2, 'id_unidade' => 20],
            ],
            [10]
        );

        $this->assertSame([1], array_column($resultado, 'id_guiche'));
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOESCOPOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoLegacyCleanupTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOLEGACYCLEANUPTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoLegacyCleanupTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoLegacyCleanupTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function arquivos_legados_do_agendamento_nao_devem_existir_no_fluxo_ativo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentoLegacyCleanupTest extends TestCase
{
    #[Test]
    public function arquivos_legados_do_agendamento_nao_devem_existir_no_fluxo_ativo(): void
    {
        $this->assertFileDoesNotExist(resource_path('views/cadastro_eleitoral/agendamentos_admin.blade.php'));
        $this->assertFileDoesNotExist(resource_path('views/cadastro_eleitoral/agendamentos_admin_bloqueios.blade.php'));
        $this->assertFileDoesNotExist(public_path('js/cadastro-eleitoral-agendamentos-admin.js'));
        $this->assertFileDoesNotExist(public_path('js/cadastro-eleitoral-agendamentos-admin-bloqueios.js'));
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOLEGACYCLEANUPTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoRecentesControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTORECENTESCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoRecentesControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoRecentesControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_listar_recentes_retorna_html_renderizado_da_tabela(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralAgendamentoController;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoDisponibilidadeService;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoReservaService;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralAgendamentoRecentesControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_listar_recentes_retorna_html_renderizado_da_tabela(): void
    {
        $disponibilidade = Mockery::mock(CadastroEleitoralAgendamentoDisponibilidadeService::class);
        $disponibilidade->shouldReceive('listarRecentes')
            ->once()
            ->with(20, 'EDCLEY')
            ->andReturn([[
                'id_agendamento' => 11,
                'nome' => 'EDCLEY DA SILVA FIRMINO',
                'num_inscricao' => '000000000123',
                'servico_nome' => 'Revisao Biometrica',
                'dt_inicio_fmt' => '2026-04-20 07:00',
            ]]);

        $controller = new CadastroEleitoralAgendamentoController(
            $disponibilidade,
            Mockery::mock(CadastroEleitoralAgendamentoReservaService::class)
        );

        $dados = $controller->listar(new Request([
            'limite' => 20,
            'nome' => 'EDCLEY',
        ]))->getData(true);

        $this->assertArrayHasKey('html', $dados);
        $this->assertStringContainsString('EDCLEY DA SILVA FIRMINO', $dados['html']);
        $this->assertStringContainsString('js-print-agendamento', $dados['html']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTORECENTESCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentoReservaServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTORESERVASERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentoReservaServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentoReservaServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_reservar_rejeita_unidade_fora_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoReservaService;
use Mockery;
use PHPUnit\Framework\TestCase;
use RuntimeException;

class CadastroEleitoralAgendamentoReservaServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_reservar_rejeita_unidade_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralAgendamentoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([
            ['cod_objeto_localidade' => '100', 'municipio' => 'RIO BRANCO', 'zonas' => ['1'], 'zona_eleitoral' => '1'],
        ]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central', 'cod_objeto_localidade' => '100'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralAgendamentoReservaService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->reservar([
            'id_unidade' => 99,
            'id_servico' => 1,
            'dt_inicio' => '2026-04-04 08:00:00',
        ]);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTORESERVASERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentosAdminCadastrosRenderUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINCADASTROSRENDERUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentosAdminCadastrosRenderUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentosAdminCadastrosRenderUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_de_cadastros_declara_partials_das_tabelas(): void
public function javascript_de_cadastros_consume_html_pronto_das_tabelas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentosAdminCadastrosRenderUiTest extends TestCase
{
    #[Test]
    public function view_de_cadastros_declara_partials_das_tabelas(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos_admin_cadastros.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_cadastros_unidades_rows', $conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_cadastros_tipos_guiche_rows', $conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_cadastros_guiches_rows', $conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_cadastros_servicos_rows', $conteudo);
    }

    #[Test]
    public function javascript_de_cadastros_consume_html_pronto_das_tabelas(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos-admin-cadastros.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("tbody.innerHTML = html;", $conteudo);
        $this->assertStringContainsString("ativo: document.getElementById('u_ativo').checked ? 'S' : 'N'", $conteudo);
        $this->assertStringContainsString("document.getElementById('u_ativo').checked = (u.ativo || 'S') === 'S';", $conteudo);
        $this->assertStringNotContainsString("state.unidades.map((u) => `", $conteudo);
        $this->assertStringNotContainsString("state.guiches.map((g) => `", $conteudo);
        $this->assertStringNotContainsString("state.tiposGuiche.map((t) => `", $conteudo);
        $this->assertStringNotContainsString("state.servicos.map((s) => `", $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINCADASTROSRENDERUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentosAdminCadastrosUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINCADASTROSUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentosAdminCadastrosUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentosAdminCadastrosUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function formulario_de_cadastros_usa_font_awesome_nos_botoes_primarios(): void
public function acoes_dinamicas_da_tabela_usa_font_awesome_nos_partials(): void
public function javascript_de_cadastros_envia_e_recarrega_flags_de_capacidade_da_unidade(): void
public function documentacao_registra_font_awesome_como_padrao_de_icones(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentosAdminCadastrosUiTest extends TestCase
{
    #[Test]
    public function formulario_de_cadastros_usa_font_awesome_nos_botoes_primarios(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos_admin_cadastros.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('fa-solid fa-eraser', $conteudo);
        $this->assertStringContainsString('fa-solid fa-floppy-disk', $conteudo);
        $this->assertStringContainsString('id="u_ativo"', $conteudo);
        $this->assertStringContainsString('Unidade ativa', $conteudo);
        $this->assertStringContainsString('id="u_usa_filas"', $conteudo);
        $this->assertStringContainsString('id="u_usa_pesquisa_satisfacao"', $conteudo);
        $this->assertStringContainsString('id="u_usa_agendamentos"', $conteudo);
        $this->assertStringContainsString('<th>Filas</th>', $conteudo);
        $this->assertStringContainsString('<th>Avaliação</th>', $conteudo);
        $this->assertStringContainsString('<th>Agendamentos</th>', $conteudo);
    }

    #[Test]
    public function acoes_dinamicas_da_tabela_usa_font_awesome_nos_partials(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/partials/agendamentos_admin_cadastros_unidades_rows.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('fa-solid fa-pen-to-square', $conteudo);
        $this->assertStringContainsString('fa-solid fa-trash', $conteudo);
        $this->assertStringContainsString('usa_filas', $conteudo);
        $this->assertStringContainsString('usa_pesquisa_satisfacao', $conteudo);
        $this->assertStringContainsString('usa_agendamentos', $conteudo);
    }

    #[Test]
    public function javascript_de_cadastros_envia_e_recarrega_flags_de_capacidade_da_unidade(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos-admin-cadastros.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('usa_filas:', $conteudo);
        $this->assertStringContainsString('usa_pesquisa_satisfacao:', $conteudo);
        $this->assertStringContainsString('usa_agendamentos:', $conteudo);
        $this->assertStringContainsString("document.getElementById('u_usa_filas').checked", $conteudo);
        $this->assertStringContainsString("document.getElementById('u_usa_pesquisa_satisfacao').checked", $conteudo);
        $this->assertStringContainsString("document.getElementById('u_usa_agendamentos').checked", $conteudo);
    }

    #[Test]
    public function documentacao_registra_font_awesome_como_padrao_de_icones(): void
    {
        $conteudo = file_get_contents(base_path('docs/contratos/frontend.md'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Font Awesome', $conteudo);
        $this->assertStringContainsString('preferencia', mb_strtolower($conteudo));
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINCADASTROSUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentosAdminLeituraUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINLEITURAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentosAdminLeituraUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentosAdminLeituraUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_de_funcionamento_declara_partial_da_tabela(): void
public function view_de_monitoramento_declara_partial_da_tabela(): void
public function view_de_slots_declara_partial_da_tabela(): void
public function javascript_de_funcionamento_consume_html_pronto(): void
public function javascript_de_monitoramento_consume_html_pronto(): void
public function javascript_de_slots_consume_html_pronto(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentosAdminLeituraUiTest extends TestCase
{
    #[Test]
    public function view_de_funcionamento_declara_partial_da_tabela(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos_admin_funcionamento.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_funcionamento_rows', $conteudo);
    }

    #[Test]
    public function view_de_monitoramento_declara_partial_da_tabela(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos_admin_monitoramento.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_monitoramento_rows', $conteudo);
        $this->assertStringContainsString('Agendado para', $conteudo);
    }

    #[Test]
    public function view_de_slots_declara_partial_da_tabela(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos_admin_slots.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_admin_slots_rows', $conteudo);
    }

    #[Test]
    public function javascript_de_funcionamento_consume_html_pronto(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos-admin-funcionamento.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("tbody.innerHTML = html;", $conteudo);
        $this->assertStringContainsString("unidadeSelect?.addEventListener('change'", $conteudo);
        $this->assertStringContainsString("url.searchParams.set('id_unidade', String(idUnidade));", $conteudo);
        $this->assertStringNotContainsString("state.funcionamentos.map((f) => `", $conteudo);
    }

    #[Test]
    public function javascript_de_monitoramento_consume_html_pronto(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos-admin-monitoramento.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("tbody.innerHTML = html;", $conteudo);
        $this->assertStringNotContainsString("state.agendamentos.map((a) => `", $conteudo);
    }

    #[Test]
    public function javascript_de_slots_consume_html_pronto(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos-admin-slots.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("tbody.innerHTML = html;", $conteudo);
        $this->assertStringNotContainsString("state.disponibilidade.map((item) => `", $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINLEITURAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentosAdminRecepcaoUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINRECEPCAOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentosAdminRecepcaoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentosAdminRecepcaoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_da_recepcao_declara_partial_blade_para_os_cards(): void
public function javascript_da_recepcao_consume_html_pronto_em_vez_de_montar_cards_por_template_string(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentosAdminRecepcaoUiTest extends TestCase
{
    #[Test]
    public function view_da_recepcao_declara_partial_blade_para_os_cards(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos_admin_recepcao.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("cadastro_eleitoral.partials.agendamentos_admin_recepcao_cards", $conteudo);
    }

    #[Test]
    public function javascript_da_recepcao_consume_html_pronto_em_vez_de_montar_cards_por_template_string(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos-admin-recepcao.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('root.innerHTML = html;', $conteudo);
        $this->assertStringNotContainsString('state.agendamentos.map((a) => `', $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSADMINRECEPCAOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralAgendamentosPublicoUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSPUBLICOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralAgendamentosPublicoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralAgendamentosPublicoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_publica_declara_partial_da_tabela_de_reimpressao(): void
public function javascript_publico_consume_html_pronto_da_tabela_de_reimpressao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralAgendamentosPublicoUiTest extends TestCase
{
    #[Test]
    public function view_publica_declara_partial_da_tabela_de_reimpressao(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/agendamentos.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('cadastro_eleitoral.partials.agendamentos_recentes_rows', $conteudo);
    }

    #[Test]
    public function javascript_publico_consume_html_pronto_da_tabela_de_reimpressao(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-agendamentos.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('elRecentesBody.innerHTML = payload.html || \'\';', $conteudo);
        $this->assertStringNotContainsString('elRecentesBody.innerHTML = rows.map((r) => `<tr>', $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALAGENDAMENTOSPUBLICOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_vagas_em_locais_renderiza_filtros_e_resultados(): void
public function test_vagas_em_locais_aplica_filtro_zero_vagas(): void
private function mockQuery(array $resultado)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Middleware\ConfigureUserSession;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class CadastroEleitoralControllerTest extends TestCase
{
    public function test_vagas_em_locais_renderiza_filtros_e_resultados(): void
    {
        $this->withoutMiddleware();

        $queryBase = $this->mockQuery([
            (object) [
                'num_zona' => 4,
                'nom_localidade' => 'RIO BRANCO',
                'nom_bairro' => 'CENTRO',
                'num_local' => 10,
                'nom_local' => 'ESCOLA TESTE',
                'qtd_secoes_local' => 2,
                'qtd_eleitores_aptos_local' => 380,
                'qtd_vagas_local' => 25,
                'secoes' => '001,002',
            ],
        ]);

        $queryZonas = $this->mockQuery([
            (object) ['num_zona' => 4],
        ]);

        $queryLocalidades = $this->mockQuery([
            (object) ['nom_localidade' => 'RIO BRANCO'],
        ]);

        $queryBairros = $this->mockQuery([
            (object) ['nom_bairro' => 'CENTRO'],
        ]);

        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryBase);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryZonas);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryLocalidades);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryBairros);

        $response = $this
            ->withSession(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0]])
            ->get('/cadastro-eleitoral/vagas-locais?zona=4&localidade=RIO%20BRANCO&bairro=CENTRO');

        $response->assertOk();
        $response->assertViewIs('cadastro_eleitoral.vagas');
        $response->assertViewHas('filtros', function (array $filtros): bool {
            return $filtros['zona'] === '4'
                && $filtros['localidade'] === 'RIO BRANCO'
                && $filtros['bairro'] === 'CENTRO';
        });
        $response->assertSee('ESCOLA TESTE');
        $response->assertSee('RIO BRANCO');
        $response->assertSee('380');
        $response->assertSee('2');
    }

    public function test_vagas_em_locais_aplica_filtro_zero_vagas(): void
    {
        $this->withoutMiddleware();

        $queryBase = $this->mockQuery([
            (object) [
                'num_zona' => 4,
                'nom_localidade' => 'RIO BRANCO',
                'nom_bairro' => 'CENTRO',
                'num_local' => 10,
                'nom_local' => 'ESCOLA TESTE',
                'qtd_secoes_local' => 2,
                'qtd_eleitores_aptos_local' => 380,
                'qtd_vagas_local' => 0,
                'secoes' => '001,002',
            ],
        ]);

        $queryZonas = $this->mockQuery([(object) ['num_zona' => 4]]);
        $queryLocalidades = $this->mockQuery([(object) ['nom_localidade' => 'RIO BRANCO']]);
        $queryBairros = $this->mockQuery([(object) ['nom_bairro' => 'CENTRO']]);

        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryBase);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryZonas);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryLocalidades);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_vagas')->andReturn($queryBairros);

        $response = $this
            ->withSession(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0]])
            ->get('/cadastro-eleitoral/vagas-locais?zero_vagas=1&localidade=RIO%20BRANCO');

        $response->assertOk();
        $response->assertViewHas('filtros', function (array $filtros): bool {
            return $filtros['zero_vagas'] === '1';
        });
        $response->assertSee('ESCOLA TESTE');
    }

    private function mockQuery(array $resultado)
    {
        $query = \Mockery::mock();
        $query->shouldReceive('whereRaw')->andReturnSelf();
        $query->shouldReceive('where')->andReturnSelf();
        $query->shouldReceive('whereNull')->andReturnSelf();
        $query->shouldReceive('whereNotNull')->andReturnSelf();
        $query->shouldReceive('whereIn')->andReturnSelf();
        $query->shouldReceive('select')->andReturnSelf();
        $query->shouldReceive('distinct')->andReturnSelf();
        $query->shouldReceive('orderBy')->andReturnSelf();
        $query->shouldReceive('get')->andReturn(collect($resultado));

        return $query;
    }
}
```
</TESTS_UNIT_CADASTROELEITORALCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaAtendimentoServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILAATENDIMENTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaAtendimentoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaAtendimentoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_reativar_aceita_cancelada_e_nao_compareceu(): void
public function test_reativar_rejeita_status_finalizada(): void
public function test_transferir_exige_atendimento_em_andamento_e_reemite_no_novo_servico(): void
public function test_transferir_rejeita_servico_destino_invalido(): void
public function test_transferir_rejeita_prioridade_destino_invalida(): void
public function test_nao_compareceu_so_e_permitido_quando_chamada(): void
public function test_rechamar_so_e_permitido_quando_chamada_ou_em_atendimento(): void
public function test_consultar_atual_por_guiche_rejeita_unidade_fora_do_escopo(): void
public function test_finalizar_rejeita_senha_fora_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaAtendimentoService;
use Mockery;
use PHPUnit\Framework\TestCase;
use RuntimeException;

class CadastroEleitoralFilaAtendimentoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_reativar_aceita_cancelada_e_nao_compareceu(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')->once()->with(10)->andReturn(['status' => 'CANCELADA', 'id_unidade' => 2]);
        $repository->shouldReceive('atualizarStatusSenha')->once()->with(10, 'EMITIDA')->andReturn(['status' => 'EMITIDA']);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);
        $resultado = $service->reativar(10);

        $this->assertSame('EMITIDA', $resultado['status']);
    }

    public function test_reativar_rejeita_status_finalizada(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')->once()->with(10)->andReturn(['status' => 'FINALIZADA', 'id_unidade' => 2]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('A senha so pode ser reativada quando estiver cancelada ou marcada como nao compareceu.');

        $service->reativar(10);
    }

    public function test_transferir_exige_atendimento_em_andamento_e_reemite_no_novo_servico(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')
            ->once()
            ->with(33)
            ->andReturn(['status' => 'EM_ATENDIMENTO', 'id_servico' => 2, 'id_unidade' => 2]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
            ['id_servico' => 5, 'nome' => 'Alistamento'],
        ]);
        $repository->shouldReceive('listarPrioridadesAtivas')->once()->andReturn([
            ['id_prioridade' => 1, 'nome' => 'Normal'],
        ]);
        $repository->shouldReceive('transferirSenha')
            ->once()
            ->with(33, 5, 1)
            ->andReturn(['status' => 'EMITIDA', 'id_servico' => 5]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);
        $resultado = $service->transferir(33, 5, 1);

        $this->assertSame('EMITIDA', $resultado['status']);
        $this->assertSame(5, $resultado['id_servico']);
    }


    public function test_transferir_rejeita_servico_destino_invalido(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')
            ->once()
            ->with(33)
            ->andReturn(['status' => 'EM_ATENDIMENTO', 'id_servico' => 2, 'id_unidade' => 2]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
            ['id_servico' => 5, 'nome' => 'Alistamento'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Serviço de destino inválido.');

        $service->transferir(33, 999, 1);
    }

    public function test_transferir_rejeita_prioridade_destino_invalida(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')
            ->once()
            ->with(33)
            ->andReturn(['status' => 'EM_ATENDIMENTO', 'id_servico' => 2, 'id_unidade' => 2]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
            ['id_servico' => 5, 'nome' => 'Alistamento'],
        ]);
        $repository->shouldReceive('listarPrioridadesAtivas')->once()->andReturn([
            ['id_prioridade' => 1, 'nome' => 'Normal'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Prioridade de destino inválida.');

        $service->transferir(33, 5, 999);
    }

    public function test_nao_compareceu_so_e_permitido_quando_chamada(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')->once()->with(20)->andReturn(['status' => 'EM_ATENDIMENTO', 'id_unidade' => 2]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('A senha precisa estar chamada para marcar nao comparecimento.');

        $service->naoCompareceu(20);
    }

    public function test_rechamar_so_e_permitido_quando_chamada_ou_em_atendimento(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')->once()->with(44)->andReturn([
            'id_fila_senha' => 44,
            'id_unidade' => 2,
            'id_servico' => 3,
            'sigla' => 'A',
            'numero_senha' => 1,
            'status' => 'CHAMADA',
            'id_guiche' => 1,
            'guiche_codigo' => 'A1',
            'peso_prioridade' => 0,
        ]);
        $repository->shouldReceive('atualizarStatusSenha')->once()->with(44, 'CHAMADA', Mockery::type('array'))->andReturn([
            'id_fila_senha' => 44,
            'status' => 'CHAMADA',
            'sigla' => 'A',
            'numero_senha' => 1,
        ]);
        $repository->shouldReceive('registrarEventoPainel')->once();

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')->once()->with(2, [2]);

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);
        $resultado = $service->rechamar(44);

        $this->assertSame('CHAMADA', $resultado['status']);
    }

    public function test_consultar_atual_por_guiche_rejeita_unidade_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [2])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->consultarAtualPorGuiche(99, 1);
    }

    public function test_finalizar_rejeita_senha_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarSenha')->once()->with(21)->andReturn([
            'id_fila_senha' => 21,
            'id_unidade' => 99,
            'status' => 'EM_ATENDIMENTO',
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')->once()->andReturn([
            'municipios' => [],
            'unidades' => [['id_unidade' => 2]],
            'codigos_objeto_localidade' => [],
            'unidade_ids' => [2],
        ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [2])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralFilaAtendimentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->finalizar(21);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILAATENDIMENTOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaChamadaServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILACHAMADASERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaChamadaServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaChamadaServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_chamar_proxima_publica_evento_de_painel(): void
public function test_bootstrap_filtra_guiches_pelo_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaChamadaService;
use Mockery;
use PHPUnit\Framework\TestCase;

class CadastroEleitoralFilaChamadaServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_chamar_proxima_publica_evento_de_painel(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('chamarProximaSenhaPorGuiche')
            ->once()
            ->with(10, 9, Mockery::on(function (array $dados): bool {
                return $dados['guiche_codigo'] === '04';
            }))
            ->andReturn([
                'id_fila_senha' => 5,
                'id_unidade' => 10,
                'id_servico' => 2,
                'id_prioridade' => 2,
                'numero_senha' => 15,
                'sigla' => 'P',
                'senha' => 'P015',
                'guiche_codigo' => '04',
                'peso_prioridade' => 100,
                'status' => 'CHAMADA',
            ]);
        $repository->shouldReceive('registrarEventoPainel')
            ->once()
            ->with(Mockery::on(function (array $evento): bool {
                return (int) $evento['id_unidade'] === 10
                    && (int) $evento['id_fila_senha'] === 5
                    && $evento['mensagem'] === 'Prioridade'
                    && $evento['local_tipo'] === 'Guichê'
                    && $evento['local_numero'] === '04';
            }));

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10]],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaChamadaService($repository, $escopoService);

        $resultado = $service->chamarProxima([
            'id_unidade' => 10,
            'id_guiche' => 9,
            'guiche_codigo' => '04',
        ]);

        $this->assertSame('CHAMADA', $resultado['status']);
    }

    public function test_bootstrap_filtra_guiches_pelo_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central'],
            ['id_unidade' => 99, 'nome' => 'Rio Branco'],
        ]);
        $repository->shouldReceive('listarGuichesAtivos')->once()->andReturn([
            ['id_guiche' => 1, 'id_unidade' => 10, 'codigo' => 'A1'],
            ['id_guiche' => 2, 'id_unidade' => 99, 'codigo' => 'RB1'],
        ]);
        $repository->shouldReceive('listarServicosElegiveisPorGuiche')->once()->andReturn([
            ['id_guiche' => 1, 'id_servico' => 3, 'nome' => 'Alistamento', 'flag_todos_guiches' => 'N'],
            ['id_guiche' => 2, 'id_servico' => 2, 'nome' => 'Transferencia', 'flag_todos_guiches' => 'N'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with([
                ['id_guiche' => 1, 'id_unidade' => 10, 'codigo' => 'A1'],
                ['id_guiche' => 2, 'id_unidade' => 99, 'codigo' => 'RB1'],
            ], [10])
            ->andReturn([
                ['id_guiche' => 1, 'id_unidade' => 10, 'codigo' => 'A1'],
            ]);

        $service = new CadastroEleitoralFilaChamadaService($repository, $escopoService);
        $resultado = $service->bootstrap();

        $this->assertCount(1, $resultado['guiches']);
        $this->assertSame('A1', $resultado['guiches'][0]['codigo']);
        $this->assertArrayHasKey(1, $resultado['servicos_elegiveis_por_guiche']);
        $this->assertArrayNotHasKey(2, $resultado['servicos_elegiveis_por_guiche']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILACHAMADASERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaCicloMigrationTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILACICLOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaCicloMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaCicloMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_ciclo_as_tabelas_da_fila_e_troca_unicidade(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralFilaCicloMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_ciclo_as_tabelas_da_fila_e_troca_unicidade(): void
    {
        $arquivo = database_path('migrations/2026_05_02_120100_add_ciclo_to_cad_fila_tables.php');
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('private function hasColumn', $conteudo);
        $this->assertStringContainsString('private function hasConstraint', $conteudo);
        $this->assertStringContainsString('private function hasIndex', $conteudo);
        $this->assertStringContainsString("ADD (ciclo_id_atual NUMBER DEFAULT 1 NOT NULL)", $conteudo);
        $this->assertStringContainsString("ADD (ciclo_aberto_em DATE DEFAULT SYSDATE NOT NULL)", $conteudo);
        $this->assertStringContainsString('ADD CONSTRAINT ck_cfctu_ciclo_id CHECK (ciclo_id_atual >= 1)', $conteudo);
        $this->assertStringContainsString("ADD (ciclo_id NUMBER DEFAULT 1 NOT NULL)", $conteudo);
        $this->assertStringContainsString('DENSE_RANK() OVER (', $conteudo);
        $this->assertStringContainsString('ORDER BY TRUNC(data_referencia)', $conteudo);
        $this->assertStringContainsString('ADD CONSTRAINT ck_cfs_ciclo_id CHECK (ciclo_id >= 1)', $conteudo);
        $this->assertStringContainsString("if (\$this->hasConstraint('cad_fila_senha', 'uk_cfs_unid_data_num'))", $conteudo);
        $this->assertStringContainsString('ultima_data_referencia', $conteudo);
        $this->assertStringContainsString('ultimo_numero_ultima_data', $conteudo);
        $this->assertStringContainsString('ADD CONSTRAINT uk_cfs_unid_ciclo_num UNIQUE (id_unidade, ciclo_id, numero_senha)', $conteudo);
        $this->assertStringContainsString('CREATE INDEX ix_cfs_unid_st_serv_cic_num ON cad_fila_senha (id_unidade, status, id_servico, ciclo_id, numero_senha)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE cad_fila_senha ADD CONSTRAINT uk_cfs_unid_data_num UNIQUE (id_unidade, data_referencia, numero_senha)', $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILACICLOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaCycleResolverTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILACYCLERESOLVERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaCycleResolverTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaCycleResolverTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function numero_manual_maior_permanece_no_ciclo_atual(): void
public function numero_manual_menor_abre_novo_ciclo(): void
public function proxima_automatica_abre_novo_ciclo_apos_999(): void
public function nova_data_ja_comeca_em_novo_ciclo_no_numero_001(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\CadastroEleitoral\CadastroEleitoralFilaCycleResolver;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralFilaCycleResolverTest extends TestCase
{
    #[Test]
    public function numero_manual_maior_permanece_no_ciclo_atual(): void
    {
        $resolver = new CadastroEleitoralFilaCycleResolver();

        $resultado = $resolver->resolverInformada(7, 895, 897, true);

        $this->assertSame(7, $resultado['ciclo_id']);
        $this->assertSame(897, $resultado['numero_senha']);
        $this->assertFalse($resultado['abriu_novo_ciclo']);
    }

    #[Test]
    public function numero_manual_menor_abre_novo_ciclo(): void
    {
        $resolver = new CadastroEleitoralFilaCycleResolver();

        $resultado = $resolver->resolverInformada(7, 897, 1, true);

        $this->assertSame(8, $resultado['ciclo_id']);
        $this->assertSame(1, $resultado['numero_senha']);
        $this->assertTrue($resultado['abriu_novo_ciclo']);
    }

    #[Test]
    public function proxima_automatica_abre_novo_ciclo_apos_999(): void
    {
        $resolver = new CadastroEleitoralFilaCycleResolver();

        $resultado = $resolver->resolverAutomatica(7, 999, true);

        $this->assertSame(8, $resultado['ciclo_id']);
        $this->assertSame(1, $resultado['numero_senha']);
        $this->assertTrue($resultado['abriu_novo_ciclo']);
    }

    #[Test]
    public function nova_data_ja_comeca_em_novo_ciclo_no_numero_001(): void
    {
        $resolver = new CadastroEleitoralFilaCycleResolver();

        $resultado = $resolver->resolverAutomatica(7, 542, false);

        $this->assertSame(8, $resultado['ciclo_id']);
        $this->assertSame(1, $resultado['numero_senha']);
        $this->assertTrue($resultado['abriu_novo_ciclo']);
        $this->assertSame(1, $resolver->preverProximoAutomatico(542, false));
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILACYCLERESOLVERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaEmissaoServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILAEMISSAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaEmissaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaEmissaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_emitir_rejeita_unidade_fora_do_escopo(): void
public function test_emitir_delega_ao_repositorio_com_prioridade_resolvida(): void
public function test_emitir_define_sigla_p_para_prioritaria(): void
public function test_bootstrap_informa_proxima_senha_automatica_por_unidade(): void
public function test_emitir_permite_numero_informado_e_define_modo_informada(): void
public function test_emitir_rejeita_numero_informado_fora_do_padrao(): void
public function test_emitir_rejeita_servico_invalido(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaEmissaoService;
use Mockery;
use PHPUnit\Framework\TestCase;
use RuntimeException;

class CadastroEleitoralFilaEmissaoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_emitir_rejeita_unidade_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->emitir([
            'id_unidade' => 99,
            'id_servico' => 1,
            'codigo_prioridade' => 'NORMAL',
        ]);
    }

    public function test_emitir_delega_ao_repositorio_com_prioridade_resolvida(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
        ]);
        $repository->shouldReceive('buscarPrioridadePorCodigo')->once()->with('NORMAL')->andReturn([
            'id_prioridade' => 1,
            'codigo' => 'NORMAL',
            'peso' => 0,
        ]);
        $repository->shouldReceive('emitirSenha')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return (int) $payload['id_unidade'] === 10
                    && (int) $payload['id_servico'] === 2
                    && (int) $payload['id_prioridade'] === 1
                    && $payload['sigla'] === 'C'
                    && $payload['modo_emissao'] === 'AUTOMATICA'
                    && $payload['origem'] === 'TRIAGEM';
            }))
            ->andReturn([
                'id_fila_senha' => 7,
                'senha' => 'C001',
                'status' => 'EMITIDA',
            ]);
        $repository->shouldReceive('buscarProximoNumeroAutomatico')->once()->with(10)->andReturn(2);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10]],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);

        $resultado = $service->emitir([
            'id_unidade' => 10,
            'id_servico' => 2,
            'codigo_prioridade' => 'NORMAL',
        ]);

        $this->assertSame('C001', $resultado['senha']);
        $this->assertSame('C002', $resultado['proxima_automatica']);
    }

    public function test_emitir_define_sigla_p_para_prioritaria(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
        ]);
        $repository->shouldReceive('buscarPrioridadePorCodigo')->once()->with('PRIORITARIA')->andReturn([
            'id_prioridade' => 2,
            'codigo' => 'PRIORITARIA',
            'peso' => 100,
        ]);
        $repository->shouldReceive('emitirSenha')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return (int) $payload['id_prioridade'] === 2
                    && $payload['sigla'] === 'P'
                    && $payload['modo_emissao'] === 'AUTOMATICA';
            }))
            ->andReturn([
                'id_fila_senha' => 8,
                'senha' => 'P001',
                'status' => 'EMITIDA',
            ]);
        $repository->shouldReceive('buscarProximoNumeroAutomatico')->once()->with(10)->andReturn(2);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10]],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);

        $resultado = $service->emitir([
            'id_unidade' => 10,
            'id_servico' => 2,
            'codigo_prioridade' => 'PRIORITARIA',
        ]);

        $this->assertSame('P001', $resultado['senha']);
        $this->assertSame('P002', $resultado['proxima_automatica']);
    }

    public function test_bootstrap_informa_proxima_senha_automatica_por_unidade(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central'],
        ]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([]);
        $repository->shouldReceive('listarPrioridadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('buscarProximoNumeroAutomatico')->once()->with(10)->andReturn(8);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);
        $resultado = $service->bootstrap();

        $this->assertSame('008', $resultado['proximos_numeros_automaticos'][10]);
    }

    public function test_emitir_permite_numero_informado_e_define_modo_informada(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
        ]);
        $repository->shouldReceive('buscarPrioridadePorCodigo')->once()->with('NORMAL')->andReturn([
            'id_prioridade' => 1,
            'codigo' => 'NORMAL',
            'peso' => 0,
        ]);
        $repository->shouldReceive('emitirSenha')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return (int) $payload['id_unidade'] === 10
                    && $payload['sigla'] === 'C'
                    && $payload['modo_emissao'] === 'INFORMADA'
                    && (int) $payload['numero_senha_informado'] === 15;
            }))
            ->andReturn([
                'id_fila_senha' => 9,
                'senha' => 'C015',
                'status' => 'EMITIDA',
                'modo_emissao' => 'INFORMADA',
            ]);
        $repository->shouldReceive('buscarProximoNumeroAutomatico')->once()->with(10)->andReturn(16);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10]],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);
        $resultado = $service->emitir([
            'id_unidade' => 10,
            'id_servico' => 2,
            'codigo_prioridade' => 'NORMAL',
            'numero_senha_informado' => '015',
        ]);

        $this->assertSame('C015', $resultado['senha']);
        $this->assertSame('C016', $resultado['proxima_automatica']);
    }

    public function test_emitir_rejeita_numero_informado_fora_do_padrao(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10]],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('A senha informada deve estar no formato 001 a 999.');

        $service->emitir([
            'id_unidade' => 10,
            'id_servico' => 2,
            'codigo_prioridade' => 'NORMAL',
            'numero_senha_informado' => '15',
        ]);
    }


    public function test_emitir_rejeita_servico_invalido(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([
            ['id_servico' => 2, 'nome' => 'Biometria'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10]],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaEmissaoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Serviço inválido.');

        $service->emitir([
            'id_unidade' => 10,
            'id_servico' => 999,
            'codigo_prioridade' => 'NORMAL',
        ]);
    }

}
```
</TESTS_UNIT_CADASTROELEITORALFILAEMISSAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaMonitoramentoServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILAMONITORAMENTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaMonitoramentoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaMonitoramentoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_retorna_senhas_filtradas_pelo_escopo(): void
public function test_listar_forca_filtro_do_dia_corrente(): void
public function test_listar_filtra_resultados_pelo_escopo_quando_consulta_todas_as_unidades(): void
public function test_listar_lanca_excecao_para_unidade_fora_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaMonitoramentoService;
use Mockery;
use PHPUnit\Framework\TestCase;
use RuntimeException;

class CadastroEleitoralFilaMonitoramentoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_retorna_senhas_filtradas_pelo_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central'],
        ]);
        $repository->shouldReceive('listarServicosAtivos')->once()->andReturn([]);
        $repository->shouldReceive('listarPrioridadesAtivas')->once()->andReturn([]);
        $repository->shouldReceive('listarSenhasMonitoramento')->once()->with(['somente_hoje' => true])->andReturn([
            ['id_unidade' => 10, 'senha' => 'A001'],
            ['id_unidade' => 99, 'senha' => 'A999'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with([
                ['id_unidade' => 10, 'senha' => 'A001'],
                ['id_unidade' => 99, 'senha' => 'A999'],
            ], [10])
            ->andReturn([
                ['id_unidade' => 10, 'senha' => 'A001'],
            ]);

        $service = new CadastroEleitoralFilaMonitoramentoService($repository, $escopoService);
        $resultado = $service->bootstrap();

        $this->assertCount(1, $resultado['senhas']);
        $this->assertSame('A001', $resultado['senhas'][0]['senha']);
    }

    public function test_listar_forca_filtro_do_dia_corrente(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 2, 'nome' => 'Detran'],
        ]);
        $repository->shouldReceive('listarSenhasMonitoramento')
            ->once()
            ->with([
                'id_unidade' => 2,
                'status' => 'EMITIDA',
                'somente_hoje' => true,
            ])
            ->andReturn([
                ['id_unidade' => 2, 'senha' => 'P004'],
            ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 2, 'nome' => 'Detran']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [2],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(2, [2]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with([
                ['id_unidade' => 2, 'senha' => 'P004'],
            ], [2])
            ->andReturn([
                ['id_unidade' => 2, 'senha' => 'P004'],
            ]);

        $service = new CadastroEleitoralFilaMonitoramentoService($repository, $escopoService);
        $resultado = $service->listar([
            'id_unidade' => 2,
            'status' => 'EMITIDA',
        ]);

        $this->assertSame('P004', $resultado[0]['senha']);
    }

    public function test_listar_filtra_resultados_pelo_escopo_quando_consulta_todas_as_unidades(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 2, 'nome' => 'Detran'],
            ['id_unidade' => 99, 'nome' => 'Rio Branco'],
        ]);
        $repository->shouldReceive('listarSenhasMonitoramento')
            ->once()
            ->with([
                'status' => 'EMITIDA',
                'somente_hoje' => true,
            ])
            ->andReturn([
                ['id_unidade' => 2, 'senha' => 'P004'],
                ['id_unidade' => 99, 'senha' => 'C999'],
            ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 2, 'nome' => 'Detran']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [2],
            ]);
        $escopoService->shouldReceive('filtrarRegistrosPorUnidade')
            ->once()
            ->with([
                ['id_unidade' => 2, 'senha' => 'P004'],
                ['id_unidade' => 99, 'senha' => 'C999'],
            ], [2])
            ->andReturn([
                ['id_unidade' => 2, 'senha' => 'P004'],
            ]);

        $service = new CadastroEleitoralFilaMonitoramentoService($repository, $escopoService);
        $resultado = $service->listar([
            'status' => 'EMITIDA',
        ]);

        $this->assertCount(1, $resultado);
        $this->assertSame('P004', $resultado[0]['senha']);
    }

    public function test_listar_lanca_excecao_para_unidade_fora_do_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 2, 'nome' => 'Detran'],
        ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 2, 'nome' => 'Detran']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [2],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(99, [2])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $service = new CadastroEleitoralFilaMonitoramentoService($repository, $escopoService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Unidade fora do escopo territorial do usuário.');

        $service->listar([
            'id_unidade' => 99,
            'status' => 'EMITIDA',
        ]);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILAMONITORAMENTOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaPainelServiceTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILAPAINELSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaPainelServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaPainelServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_retorna_chamada_atual_historico_e_config(): void
public function test_listar_eventos_novos_autoriza_unidade_no_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaPainelRepositoryInterface;
use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaPainelService;
use Mockery;
use PHPUnit\Framework\TestCase;

class CadastroEleitoralFilaPainelServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_retorna_chamada_atual_historico_e_config(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);

        $painelRepository = Mockery::mock(CadastroEleitoralFilaPainelRepositoryInterface::class);
        $painelRepository->shouldReceive('buscarConfigPainel')
            ->once()
            ->with(10)
            ->andReturn([
                'titulo_painel' => 'Chamadas',
                'qtde_historico' => 6,
                'audio_habilitado' => 'S',
                'voz_habilitada' => 'N',
            ]);
        $painelRepository->shouldReceive('buscarUltimoEvento')
            ->once()
            ->with(10)
            ->andReturn([
                'id_painel_evento' => 7,
                'senha' => 'A015',
                'local' => 'Guichê 04',
            ]);
        $painelRepository->shouldReceive('listarHistorico')
            ->once()
            ->with(10, 6)
            ->andReturn([
                ['id_painel_evento' => 6, 'senha' => 'A014', 'local' => 'Guichê 02'],
            ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaPainelService($repository, $painelRepository, $escopoService);

        $resultado = $service->bootstrap(10);

        $this->assertSame('Chamadas', $resultado['config']['titulo_painel']);
        $this->assertSame('A015', $resultado['atual']['senha']);
        $this->assertCount(1, $resultado['historico']);
    }

    public function test_listar_eventos_novos_autoriza_unidade_no_escopo(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([]);

        $painelRepository = Mockery::mock(CadastroEleitoralFilaPainelRepositoryInterface::class);
        $painelRepository->shouldReceive('listarEventosNovos')
            ->once()
            ->with(10, 7)
            ->andReturn([
                ['id_painel_evento' => 8, 'senha' => 'C004'],
            ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $service = new CadastroEleitoralFilaPainelService($repository, $painelRepository, $escopoService);
        $resultado = $service->listarEventosNovos(10, 7);

        $this->assertSame('C004', $resultado['eventos'][0]['senha']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILAPAINELSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilaRepositoryCycleTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILAREPOSITORYCYCLETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilaRepositoryCycleTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilaRepositoryCycleTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_emissao_manual_menor_abre_novo_ciclo_e_atualiza_contador(): void
public function test_emissao_manual_repetida_no_mesmo_ciclo_e_rejeitada(): void
public function test_emissao_automatica_apos_999_abre_novo_ciclo_com_001(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\CadastroEleitoralFilaRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class CadastroEleitoralFilaRepositoryCycleTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Carbon::setTestNow('2026-05-02 10:00:00');
        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);

        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')->zeroOrMoreTimes();
        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_emissao_manual_menor_abre_novo_ciclo_e_atualiza_contador(): void
    {
        session([
            'user' => [
                'username' => 'operador',
                'name' => 'Operador Fila',
            ],
        ]);

        DB::shouldReceive('transaction')
            ->times(4)
            ->andReturnUsing(static fn ($callback) => $callback());

        $builderContadorAntes = Mockery::mock();
        $builderContadorAntes->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderContadorAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderContadorAntes->shouldReceive('first')->once()->andReturn((object) [
            'id_unidade' => 84,
            'data_referencia' => '2026-05-02',
            'ultimo_numero' => 897,
            'ciclo_id_atual' => 4,
        ]);

        DB::shouldReceive('selectOne')
            ->once()
            ->withArgs(function (string $sql, array $params): bool {
                return str_contains($sql, 'FROM cad_fila_contador_unidade') && $params === [84];
            })
            ->andReturn((object) [
                'id_unidade' => 84,
                'data_referencia' => '2026-05-02',
                'ultimo_numero' => 897,
                'ciclo_id_atual' => 4,
                'ciclo_aberto_em' => '2026-05-02 08:00:00',
            ]);

        $builderDuplicidade = Mockery::mock();
        $builderDuplicidade->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderDuplicidade->shouldReceive('where')->once()->with('ciclo_id', 5)->andReturnSelf();
        $builderDuplicidade->shouldReceive('where')->once()->with('numero_senha', 1)->andReturnSelf();
        $builderDuplicidade->shouldReceive('exists')->once()->andReturnFalse();

        $builderContador = Mockery::mock();
        $builderContador->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderContador->shouldReceive('update')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['ultimo_numero'] === 1
                    && $payload['ciclo_id_atual'] === 5
                    && array_key_exists('ciclo_aberto_em', $payload)
                    && $payload['usuario_atualizacao'] === 'operador';
            }))
            ->andReturn(1);

        $builderInsertSenha = Mockery::mock();
        $builderInsertSenha->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['id_unidade'] === 84
                    && $payload['ciclo_id'] === 5
                    && $payload['numero_senha'] === 1
                    && $payload['modo_emissao'] === 'INFORMADA'
                    && $payload['nome_cliente'] === 'LAIS ESTELA';
            }), 'id_fila_senha')
            ->andReturn(2001);

        $builderEvento = Mockery::mock();
        $builderEvento->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['id_fila_senha'] === 2001
                    && $payload['tipo_evento'] === 'EMISSAO'
                    && $payload['status_novo'] === 'EMITIDA';
            }), 'id_fila_evento')
            ->andReturn(3001);

        $builderContadorDepois = Mockery::mock();
        $builderContadorDepois->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderContadorDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_unidade' => 84,
            'data_referencia' => '2026-05-02',
            'ultimo_numero' => 1,
            'ciclo_id_atual' => 5,
        ]);

        $builderSenhaDepois = Mockery::mock();
        $builderSenhaDepois->shouldReceive('where')->once()->with('id_fila_senha', 2001)->andReturnSelf();
        $builderSenhaDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_senha' => 2001,
            'id_unidade' => 84,
            'ciclo_id' => 5,
            'numero_senha' => 1,
            'status' => 'EMITIDA',
        ]);

        $builderEventoDepois = Mockery::mock();
        $builderEventoDepois->shouldReceive('where')->once()->with('id_fila_evento', 3001)->andReturnSelf();
        $builderEventoDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_evento' => 3001,
            'id_fila_senha' => 2001,
            'tipo_evento' => 'EMISSAO',
        ]);

        DB::shouldReceive('table')->once()->with('cad_fila_contador_unidade')->andReturn($builderContadorAntes);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderDuplicidade);
        DB::shouldReceive('table')->once()->with('cad_fila_contador_unidade')->andReturn($builderContador);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderInsertSenha);
        DB::shouldReceive('table')->once()->with('cad_fila_evento')->andReturn($builderEvento);
        DB::shouldReceive('table')->once()->with('cad_fila_contador_unidade')->andReturn($builderContadorDepois);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderSenhaDepois);
        DB::shouldReceive('table')->once()->with('cad_fila_evento')->andReturn($builderEventoDepois);

        $repository = new CadastroEleitoralFilaRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            null,
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );

        $resultado = $repository->emitirSenha([
            'id_unidade' => 84,
            'id_servico' => 1,
            'id_prioridade' => 1,
            'sigla' => 'C',
            'modo_emissao' => 'INFORMADA',
            'numero_senha_informado' => 1,
            'origem' => 'TRIAGEM',
            'nome_cliente' => 'LAIS ESTELA',
        ]);

        $this->assertSame(2001, $resultado['id_fila_senha']);
        $this->assertSame('C001', $resultado['senha']);
        $this->assertSame('EMITIDA', $resultado['status']);
        $this->assertSame('INFORMADA', $resultado['modo_emissao']);
        $this->assertArrayNotHasKey('ja_existia', $resultado);
    }

    public function test_emissao_manual_repetida_no_mesmo_ciclo_e_rejeitada(): void
    {
        DB::shouldReceive('transaction')
            ->once()
            ->andReturnUsing(static fn ($callback) => $callback());

        DB::shouldReceive('selectOne')
            ->once()
            ->andReturn((object) [
                'id_unidade' => 84,
                'data_referencia' => '2026-05-02',
                'ultimo_numero' => 20,
                'ciclo_id_atual' => 4,
                'ciclo_aberto_em' => '2026-05-02 08:00:00',
            ]);

        $builderDuplicidade = Mockery::mock();
        $builderDuplicidade->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderDuplicidade->shouldReceive('where')->once()->with('ciclo_id', 4)->andReturnSelf();
        $builderDuplicidade->shouldReceive('where')->once()->with('numero_senha', 20)->andReturnSelf();
        $builderDuplicidade->shouldReceive('exists')->once()->andReturnTrue();

        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderDuplicidade);

        $repository = new CadastroEleitoralFilaRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            null,
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('A senha informada já foi utilizada no ciclo atual.');

        $repository->emitirSenha([
            'id_unidade' => 84,
            'id_servico' => 1,
            'id_prioridade' => 1,
            'sigla' => 'C',
            'modo_emissao' => 'INFORMADA',
            'numero_senha_informado' => 20,
            'origem' => 'TRIAGEM',
        ]);
    }

    public function test_emissao_automatica_apos_999_abre_novo_ciclo_com_001(): void
    {
        DB::shouldReceive('transaction')
            ->times(4)
            ->andReturnUsing(static fn ($callback) => $callback());

        $builderContadorAntes = Mockery::mock();
        $builderContadorAntes->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderContadorAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderContadorAntes->shouldReceive('first')->once()->andReturn((object) [
            'id_unidade' => 84,
            'data_referencia' => '2026-05-02',
            'ultimo_numero' => 999,
            'ciclo_id_atual' => 4,
        ]);

        DB::shouldReceive('selectOne')
            ->once()
            ->andReturn((object) [
                'id_unidade' => 84,
                'data_referencia' => '2026-05-02',
                'ultimo_numero' => 999,
                'ciclo_id_atual' => 4,
                'ciclo_aberto_em' => '2026-05-02 08:00:00',
            ]);

        $builderDuplicidade = Mockery::mock();
        $builderDuplicidade->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderDuplicidade->shouldReceive('where')->once()->with('ciclo_id', 5)->andReturnSelf();
        $builderDuplicidade->shouldReceive('where')->once()->with('numero_senha', 1)->andReturnSelf();
        $builderDuplicidade->shouldReceive('exists')->once()->andReturnFalse();

        $builderContador = Mockery::mock();
        $builderContador->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderContador->shouldReceive('update')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['ultimo_numero'] === 1
                    && $payload['ciclo_id_atual'] === 5
                    && array_key_exists('ciclo_aberto_em', $payload);
            }))
            ->andReturn(1);

        $builderInsertSenha = Mockery::mock();
        $builderInsertSenha->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['ciclo_id'] === 5
                    && $payload['numero_senha'] === 1
                    && $payload['modo_emissao'] === 'AUTOMATICA';
            }), 'id_fila_senha')
            ->andReturn(2002);

        $builderEvento = Mockery::mock();
        $builderEvento->shouldReceive('insertGetId')->once()->andReturn(3002);

        $builderContadorDepois = Mockery::mock();
        $builderContadorDepois->shouldReceive('where')->once()->with('id_unidade', 84)->andReturnSelf();
        $builderContadorDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_unidade' => 84,
            'data_referencia' => '2026-05-02',
            'ultimo_numero' => 1,
            'ciclo_id_atual' => 5,
        ]);

        $builderSenhaDepois = Mockery::mock();
        $builderSenhaDepois->shouldReceive('where')->once()->with('id_fila_senha', 2002)->andReturnSelf();
        $builderSenhaDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_senha' => 2002,
            'id_unidade' => 84,
            'ciclo_id' => 5,
            'numero_senha' => 1,
            'status' => 'EMITIDA',
        ]);

        $builderEventoDepois = Mockery::mock();
        $builderEventoDepois->shouldReceive('where')->once()->with('id_fila_evento', 3002)->andReturnSelf();
        $builderEventoDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_fila_evento' => 3002,
            'id_fila_senha' => 2002,
            'tipo_evento' => 'EMISSAO',
        ]);

        DB::shouldReceive('table')->once()->with('cad_fila_contador_unidade')->andReturn($builderContadorAntes);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderDuplicidade);
        DB::shouldReceive('table')->once()->with('cad_fila_contador_unidade')->andReturn($builderContador);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderInsertSenha);
        DB::shouldReceive('table')->once()->with('cad_fila_evento')->andReturn($builderEvento);
        DB::shouldReceive('table')->once()->with('cad_fila_contador_unidade')->andReturn($builderContadorDepois);
        DB::shouldReceive('table')->once()->with('cad_fila_senha')->andReturn($builderSenhaDepois);
        DB::shouldReceive('table')->once()->with('cad_fila_evento')->andReturn($builderEventoDepois);

        $repository = new CadastroEleitoralFilaRepository(
            app(\App\Services\Auditoria\AuditLogService::class),
            null,
            ['login' => session('user.username'), 'nome' => session('user.name')]
        );

        $resultado = $repository->emitirSenha([
            'id_unidade' => 84,
            'id_servico' => 1,
            'id_prioridade' => 1,
            'sigla' => 'C',
            'modo_emissao' => 'AUTOMATICA',
            'origem' => 'TRIAGEM',
        ]);

        $this->assertSame(1, $resultado['numero_senha']);
        $this->assertSame('C001', $resultado['senha']);
        $this->assertSame('AUTOMATICA', $resultado['modo_emissao']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILAREPOSITORYCYCLETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilasAdminControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILASADMINCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilasAdminControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilasAdminControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_retorna_unidades_e_configuracao_da_unidade_informada(): void
public function test_salvar_config_retorna_422_quando_qtde_historico_e_invalida(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralFilasAdminController;
use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Services\CadastroEleitoral\CadastroEleitoralAgendamentoEscopoService;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class CadastroEleitoralFilasAdminControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_retorna_unidades_e_configuracao_da_unidade_informada(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipiosParaEscopo')->once()->andReturn([]);
        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 10, 'nome' => 'Central'],
        ]);
        $repository->shouldReceive('buscarConfigPainel')
            ->once()
            ->with(10)
            ->andReturn([
                'id_unidade' => 10,
                'titulo_painel' => 'Chamadas Central',
            ]);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);
        $escopoService->shouldReceive('aplicarEscopoTerritorial')
            ->once()
            ->andReturn([
                'municipios' => [],
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'codigos_objeto_localidade' => [],
                'unidade_ids' => [10],
            ]);
        $escopoService->shouldReceive('autorizarUnidadeId')
            ->once()
            ->with(10, [10]);

        $controller = new CadastroEleitoralFilasAdminController($repository, $escopoService);
        $response = $controller->bootstrap(new Request(['id_unidade' => 10]));

        $dados = $response->getData(true);
        $this->assertSame('Chamadas Central', $dados['config']['titulo_painel']);
    }


    public function test_salvar_config_retorna_422_quando_qtde_historico_e_invalida(): void
    {
        $repository = Mockery::mock(CadastroEleitoralFilaRepositoryInterface::class);

        $escopoService = Mockery::mock(CadastroEleitoralAgendamentoEscopoService::class);

        $controller = new CadastroEleitoralFilasAdminController($repository, $escopoService);
        $response = $controller->salvarConfig(new Request([
            'id_unidade' => 10,
            'qtde_historico' => 0,
        ]));

        $this->assertSame(422, $response->getStatusCode());
    }

}
```
</TESTS_UNIT_CADASTROELEITORALFILASADMINCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilasControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILASCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilasControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilasControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_emitir_retorna_422_quando_service_lanca_excecao_de_regra(): void
public function test_bootstrap_triagem_retorna_payload_do_service(): void
public function test_bootstrap_atendimento_retorna_payload_do_service(): void
public function test_bootstrap_monitoramento_retorna_html_renderizado(): void
public function test_view_monitoramento_declara_refresh_automatico_de_15_segundos(): void
public function test_listar_monitoramento_retorna_html_renderizado_com_itens_da_fila(): void
public function test_listar_monitoramento_retorna_422_quando_unidade_esta_fora_do_escopo(): void
public function test_estado_atendimento_retorna_payload_do_service(): void
public function test_estado_atendimento_retorna_422_quando_unidade_fora_do_escopo(): void
public function test_emitir_retorna_422_quando_id_servico_e_invalido(): void
public function test_transferir_retorna_422_quando_destino_e_invalido(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralFilasController;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaAtendimentoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaChamadaService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaEmissaoService;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaMonitoramentoService;
use Illuminate\Http\Request;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class CadastroEleitoralFilasControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_emitir_retorna_422_quando_service_lanca_excecao_de_regra(): void
    {
        $emissao = Mockery::mock(CadastroEleitoralFilaEmissaoService::class);
        $emissao->shouldReceive('emitir')
            ->once()
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $controller = new CadastroEleitoralFilasController(
            $emissao,
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->emitir(new Request([
            'id_unidade' => 99,
            'id_servico' => 1,
            'codigo_prioridade' => 'NORMAL',
        ]));

        $this->assertSame(422, $response->getStatusCode());
    }

    public function test_bootstrap_triagem_retorna_payload_do_service(): void
    {
        $emissao = Mockery::mock(CadastroEleitoralFilaEmissaoService::class);
        $emissao->shouldReceive('bootstrap')
            ->once()
            ->andReturn([
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'servicos' => [['id_servico' => 2, 'nome' => 'Biometria']],
                'prioridades' => [['codigo' => 'NORMAL']],
                'proximos_numeros_automaticos' => [10 => '005'],
            ]);

        $controller = new CadastroEleitoralFilasController(
            $emissao,
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->bootstrapTriagem();

        $this->assertSame('Central', $response->getData(true)['unidades'][0]['nome']);
        $this->assertSame('005', $response->getData(true)['proximos_numeros_automaticos'][10]);
    }

    public function test_bootstrap_atendimento_retorna_payload_do_service(): void
    {
        $chamada = Mockery::mock(CadastroEleitoralFilaChamadaService::class);
        $chamada->shouldReceive('bootstrap')
            ->once()
            ->andReturn([
                'unidades' => [['id_unidade' => 10, 'nome' => 'Central']],
                'guiches' => [['id_guiche' => 9, 'codigo' => '04']],
                'servicos_elegiveis_por_guiche' => [9 => [['id_servico' => 2, 'nome' => 'Biometria']]],
            ]);

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            $chamada,
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->bootstrapAtendimento();

        $dados = $response->getData(true);
        $this->assertSame('04', $dados['guiches'][0]['codigo']);
        $this->assertSame('Biometria', $dados['servicos_elegiveis_por_guiche'][9][0]['nome']);
    }

    public function test_bootstrap_monitoramento_retorna_html_renderizado(): void
    {
        $monitoramento = Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class);
        $monitoramento->shouldReceive('bootstrap')
            ->once()
            ->andReturn([
                'unidades' => [],
                'servicos' => [],
                'prioridades' => [],
                'senhas' => [
                    [
                        'id_fila_senha' => 5,
                        'senha' => 'A005',
                        'status' => 'EMITIDA',
                        'servico_nome' => 'Biometria',
                    ],
                ],
            ]);

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            $monitoramento
        );

        $response = $controller->bootstrapMonitoramento();

        $dados = $response->getData(true);
        $this->assertStringContainsString('A005', $dados['html']);
        $this->assertStringContainsString('filas-monitor-grid', $dados['html']);
    }

    public function test_view_monitoramento_declara_refresh_automatico_de_15_segundos(): void
    {
        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $html = $controller->monitoramento()->render();

        $this->assertStringContainsString('refreshMs: 15000', $html);
        $this->assertStringContainsString('cadastro-eleitoral-filas-monitoramento.js', $html);
    }

    public function test_listar_monitoramento_retorna_html_renderizado_com_itens_da_fila(): void
    {
        $monitoramento = Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class);
        $monitoramento->shouldReceive('listar')
            ->once()
            ->with(['id_unidade' => 2, 'status' => 'EMITIDA'])
            ->andReturn([
                [
                    'id_fila_senha' => 23,
                    'senha' => 'P004',
                    'status' => 'EMITIDA',
                    'servico_nome' => 'Revisao Biometrica',
                    'nome_cliente' => 'RENATA DA SILVA MELO',
                ],
                [
                    'id_fila_senha' => 22,
                    'senha' => 'C003',
                    'status' => 'FINALIZADA',
                    'servico_nome' => 'Alistamento',
                    'nome_cliente' => 'EDMUNDO SOUZA',
                ],
            ]);

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            $monitoramento
        );

        $response = $controller->listarMonitoramento(new Request([
            'id_unidade' => 2,
            'status' => 'EMITIDA',
        ]));

        $dados = $response->getData(true);
        $this->assertStringContainsString('P004', $dados['html']);
        $this->assertStringContainsString('RENATA DA SILVA MELO', $dados['html']);
        $this->assertStringContainsString('Revisao Biometrica', $dados['html']);
        $this->assertStringContainsString('Já atendidos hoje', $dados['html']);
        $this->assertStringContainsString('>1<', $dados['html']);
    }

    public function test_listar_monitoramento_retorna_422_quando_unidade_esta_fora_do_escopo(): void
    {
        $monitoramento = Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class);
        $monitoramento->shouldReceive('listar')
            ->once()
            ->with(['id_unidade' => 99, 'status' => 'EMITIDA'])
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            $monitoramento
        );

        $response = $controller->listarMonitoramento(new Request([
            'id_unidade' => 99,
            'status' => 'EMITIDA',
        ]));

        $this->assertSame(422, $response->getStatusCode());
        $this->assertSame(
            'Unidade fora do escopo territorial do usuário.',
            $response->getData(true)['mensagem']
        );
    }

    public function test_estado_atendimento_retorna_payload_do_service(): void
    {
        $atendimento = Mockery::mock(CadastroEleitoralFilaAtendimentoService::class);
        $atendimento->shouldReceive('consultarAtualPorGuiche')
            ->once()
            ->with(10, 9)
            ->andReturn([
                'atual' => ['id_fila_senha' => 5, 'senha' => 'A005', 'nome_cliente' => 'MARIA SILVA', 'status' => 'CHAMADA'],
            ]);

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            $atendimento,
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->estadoAtendimento(new Request(['id_unidade' => 10, 'id_guiche' => 9]));

        $this->assertSame('A005', $response->getData(true)['atual']['senha']);
        $this->assertSame('MARIA SILVA', $response->getData(true)['atual']['nome_cliente']);
    }

    public function test_estado_atendimento_retorna_422_quando_unidade_fora_do_escopo(): void
    {
        $atendimento = Mockery::mock(CadastroEleitoralFilaAtendimentoService::class);
        $atendimento->shouldReceive('consultarAtualPorGuiche')
            ->once()
            ->with(99, 9)
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            $atendimento,
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->estadoAtendimento(new Request(['id_unidade' => 99, 'id_guiche' => 9]));

        $this->assertSame(422, $response->getStatusCode());
        $this->assertSame('Unidade fora do escopo territorial do usuário.', $response->getData(true)['mensagem']);
    }


    public function test_emitir_retorna_422_quando_id_servico_e_invalido(): void
    {
        $emissao = Mockery::mock(CadastroEleitoralFilaEmissaoService::class);
        $emissao->shouldNotReceive('emitir');

        $controller = new CadastroEleitoralFilasController(
            $emissao,
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            Mockery::mock(CadastroEleitoralFilaAtendimentoService::class),
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->emitir(new Request([
            'id_unidade' => 10,
            'id_servico' => 'abc',
            'codigo_prioridade' => 'NORMAL',
        ]));

        $this->assertSame(422, $response->getStatusCode());
        $this->assertSame('Os dados informados são inválidos.', $response->getData(true)['mensagem']);
    }

    public function test_transferir_retorna_422_quando_destino_e_invalido(): void
    {
        $atendimento = Mockery::mock(CadastroEleitoralFilaAtendimentoService::class);
        $atendimento->shouldNotReceive('transferir');

        $controller = new CadastroEleitoralFilasController(
            Mockery::mock(CadastroEleitoralFilaEmissaoService::class),
            Mockery::mock(CadastroEleitoralFilaChamadaService::class),
            $atendimento,
            Mockery::mock(CadastroEleitoralFilaMonitoramentoService::class)
        );

        $response = $controller->transferir(new Request([
            'id_servico' => 'abc',
            'id_prioridade' => 1,
        ]), 33);

        $this->assertSame(422, $response->getStatusCode());
        $this->assertSame('Os dados informados são inválidos.', $response->getData(true)['mensagem']);
    }

}
```
</TESTS_UNIT_CADASTROELEITORALFILASCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilasPainelControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILASPAINELCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilasPainelControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilasPainelControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bootstrap_retorna_payload_do_service(): void
public function test_index_carrega_unidades_para_selecao_do_painel(): void
public function test_eventos_retorna_422_quando_unidade_esta_fora_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralFilasPainelController;
use App\Services\CadastroEleitoral\CadastroEleitoralFilaPainelService;
use Illuminate\Http\Request;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class CadastroEleitoralFilasPainelControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bootstrap_retorna_payload_do_service(): void
    {
        $service = Mockery::mock(CadastroEleitoralFilaPainelService::class);
        $service->shouldReceive('bootstrap')
            ->once()
            ->with(10)
            ->andReturn([
                'unidade' => ['id_unidade' => 10, 'nome' => 'Central'],
                'config' => ['titulo_painel' => 'Chamadas'],
                'atual' => ['senha' => 'A001'],
                'historico' => [],
            ]);

        $controller = new CadastroEleitoralFilasPainelController($service);
        $response = $controller->bootstrap(new Request(['id_unidade' => 10]));

        $this->assertSame('Chamadas', $response->getData(true)['config']['titulo_painel']);
    }

    public function test_index_carrega_unidades_para_selecao_do_painel(): void
    {
        $service = Mockery::mock(CadastroEleitoralFilaPainelService::class);
        $service->shouldReceive('listarUnidadesDisponiveis')
            ->once()
            ->andReturn([
                ['id_unidade' => 10, 'nome' => 'Central', 'zona_eleitoral' => '1'],
            ]);

        $controller = new CadastroEleitoralFilasPainelController($service);
        $response = $controller->index(new Request(['id_unidade' => 10]));

        $this->assertSame('cadastro_eleitoral.filas_painel', $response->name());
        $this->assertSame('Central', $response->getData()['unidades'][0]['nome']);
        $this->assertSame(10, $response->getData()['idUnidadeSelecionada']);
    }

    public function test_eventos_retorna_422_quando_unidade_esta_fora_do_escopo(): void
    {
        $service = Mockery::mock(CadastroEleitoralFilaPainelService::class);
        $service->shouldReceive('listarEventosNovos')
            ->once()
            ->with(99, 3)
            ->andThrow(new RuntimeException('Unidade fora do escopo territorial do usuário.'));

        $controller = new CadastroEleitoralFilasPainelController($service);
        $response = $controller->eventos(new Request(['id_unidade' => 99, 'ultimo_evento_id' => 3]));

        $this->assertSame(422, $response->getStatusCode());
        $this->assertSame('Unidade fora do escopo territorial do usuário.', $response->getData(true)['mensagem']);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILASPAINELCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralFilasPainelUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALFILASPAINELUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralFilasPainelUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralFilasPainelUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_do_painel_reserva_area_para_exibir_nome_da_unidade_selecionada(): void
public function javascript_do_painel_preenche_nome_da_unidade_recebido_no_bootstrap(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralFilasPainelUiTest extends TestCase
{
    #[Test]
    public function view_do_painel_reserva_area_para_exibir_nome_da_unidade_selecionada(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/filas_painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="painel-unidade"', $conteudo);
    }

    #[Test]
    public function javascript_do_painel_preenche_nome_da_unidade_recebido_no_bootstrap(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-filas-painel.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("const unidadeEl = document.getElementById('painel-unidade');", $conteudo);
        $this->assertStringContainsString("unidadeEl.textContent = data.unidade?.nome", $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALFILASPAINELUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralPesquisaSatisfacaoControllerTest.php`
## <TESTS_UNIT_CADASTROELEITORALPESQUISASATISFACAOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralPesquisaSatisfacaoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralPesquisaSatisfacaoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function painel_admin_inclui_resumo_por_unidade_na_view(): void
public function store_rejeita_resposta_para_unidade_sem_formulario_habilitado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\CadastroEleitoral\CadastroEleitoralPesquisaSatisfacaoController;
use App\Http\Requests\CadastroEleitoral\CadastroEleitoralPesquisaSatisfacaoStoreRequest;
use App\Repositories\CadastroEleitoral\CadastroEleitoralPesquisaSatisfacaoRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralPesquisaSatisfacaoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function painel_admin_inclui_resumo_por_unidade_na_view(): void
    {
        $repository = Mockery::mock(CadastroEleitoralPesquisaSatisfacaoRepository::class);
        $paginator = new LengthAwarePaginator([], 0, 15, 1, [
            'path' => '/cadastro-eleitoral/pesquisa-satisfacao/admin',
            'query' => [
                'id_unidade' => 0,
                'data_inicio' => '2026-04-01',
                'data_fim' => '2026-04-30',
            ],
        ]);

        $repository->shouldReceive('listarUnidadesAtivas')->once()->andReturn([
            ['id_unidade' => 1, 'nome' => 'Central'],
        ]);
        $repository->shouldReceive('resumirRespostas')->once()->andReturn([
            'total_respostas' => 3,
        ]);
        $repository->shouldReceive('resumirRespostasPorUnidade')->once()->andReturn([
            [
                'id_unidade' => 1,
                'unidade_nome' => 'Central',
                'total_respostas' => 3,
                'tempo_espera_otimo' => 2,
                'tempo_espera_bom' => 1,
                'tempo_espera_ruim' => 0,
                'atendimento_otimo' => 2,
                'atendimento_bom' => 1,
                'atendimento_ruim' => 0,
                'local_otimo' => 1,
                'local_bom' => 2,
                'local_ruim' => 0,
            ],
        ]);
        $repository->shouldReceive('listarRespostas')->once()->andReturn($paginator);

        $controller = new CadastroEleitoralPesquisaSatisfacaoController($repository);
        $response = $controller->adminIndex(new Request([
            'id_unidade' => 0,
            'data_inicio' => '2026-04-01',
            'data_fim' => '2026-04-30',
        ]));

        $dados = $response->getData();

        $this->assertArrayHasKey('resumoPorUnidade', $dados);
        $this->assertSame('Central', $dados['resumoPorUnidade'][0]['unidade_nome']);
        $this->assertSame(3, $dados['resumoPorUnidade'][0]['total_respostas']);
        $this->assertInstanceOf(LengthAwarePaginator::class, $dados['respostas']);
    }

    #[Test]
    public function store_rejeita_resposta_para_unidade_sem_formulario_habilitado(): void
    {
        $repository = Mockery::mock(CadastroEleitoralPesquisaSatisfacaoRepository::class);
        $repository->shouldReceive('unidadeHabilitadaParaPesquisa')
            ->once()
            ->with(9)
            ->andReturnFalse();
        $repository->shouldNotReceive('criarResposta');

        $request = Mockery::mock(CadastroEleitoralPesquisaSatisfacaoStoreRequest::class);
        $request->shouldReceive('validated')
            ->once()
            ->andReturn([
                'id_unidade' => 9,
                'avaliacao_tempo_espera' => 'OTIMO',
                'avaliacao_atendimento' => 'OTIMO',
                'avaliacao_local' => 'OTIMO',
            ]);

        $controller = new CadastroEleitoralPesquisaSatisfacaoController($repository);

        $this->expectException(ValidationException::class);

        $controller->store($request);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALPESQUISASATISFACAOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralPesquisaSatisfacaoUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALPESQUISASATISFACAOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralPesquisaSatisfacaoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralPesquisaSatisfacaoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function dashboard_admin_renderiza_um_card_para_cada_unidade_com_respostas(): void
public function pesquisa_publica_usa_vendor_sob_rotas_publicas_e_dashboard_usa_chart_local(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralPesquisaSatisfacaoUiTest extends TestCase
{
    #[Test]
    public function dashboard_admin_renderiza_um_card_para_cada_unidade_com_respostas(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/pesquisa_satisfacao_admin.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Resumo por unidade', $conteudo);
        $this->assertStringContainsString("@foreach (\$resumoPorUnidade as \$resumoUnidade)", $conteudo);
        $this->assertStringContainsString("\$resumoUnidade['unidade_nome']", $conteudo);
        $this->assertStringContainsString("\$resumoUnidade['total_respostas']", $conteudo);
        $this->assertStringContainsString("chartTempoEsperaUnidade{{ \$resumoUnidade['id_unidade'] }}", $conteudo);
        $this->assertStringContainsString("chartAtendimentoUnidade{{ \$resumoUnidade['id_unidade'] }}", $conteudo);
        $this->assertStringContainsString("chartLocalUnidade{{ \$resumoUnidade['id_unidade'] }}", $conteudo);
        $this->assertStringContainsString("Distribuição da avaliação do tempo de espera da unidade", $conteudo);
        $this->assertStringContainsString("{{ \$respostas->links('pagination::bootstrap-5') }}", $conteudo);
    }

    #[Test]
    public function pesquisa_publica_usa_vendor_sob_rotas_publicas_e_dashboard_usa_chart_local(): void
    {
        $form = file_get_contents(resource_path('views/cadastro_eleitoral/pesquisa_satisfacao.blade.php'));
        $sucesso = file_get_contents(resource_path('views/cadastro_eleitoral/pesquisa_satisfacao_sucesso.blade.php'));
        $admin = file_get_contents(resource_path('views/cadastro_eleitoral/pesquisa_satisfacao_admin.blade.php'));
        $dashboard = file_get_contents(resource_path('views/cadastro_eleitoral/dashboard.blade.php'));

        foreach ([$form, $sucesso] as $conteudo) {
            $this->assertIsString($conteudo);
            $this->assertStringContainsString("rotas-publicas/vendor/bootstrap/css/bootstrap.min.css", $conteudo);
            $this->assertStringNotContainsString("cdn.jsdelivr.net", $conteudo);
        }

        $this->assertStringContainsString("rotas-publicas/vendor/select2/css/select2.min.css", $form);
        $this->assertStringContainsString("rotas-publicas/vendor/jquery/jquery-3.7.1.min.js", $form);
        $this->assertStringContainsString("rotas-publicas/vendor/select2/js/select2.min.js", $form);
        $this->assertStringContainsString("asset('vendor/chartjs/chart.umd.min.js')", $admin);
        $this->assertStringContainsString("asset('vendor/chartjs/chart.umd.min.js')", $dashboard);
        $this->assertFileExists(public_path('vendor/chartjs/chart.umd.min.js'));
        $this->assertFileExists(public_path('rotas-publicas/vendor/chartjs/chart.umd.min.js'));
    }
}
```
</TESTS_UNIT_CADASTROELEITORALPESQUISASATISFACAOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralUnidadeCapacidadesMigrationTest.php`
## <TESTS_UNIT_CADASTROELEITORALUNIDADECAPACIDADESMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralUnidadeCapacidadesMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralUnidadeCapacidadesMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_flags_de_capacidade_na_cad_unidade(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralUnidadeCapacidadesMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_flags_de_capacidade_na_cad_unidade(): void
    {
        $arquivo = database_path('migrations/2026_05_02_120000_add_capacidade_flags_to_cad_unidade.php');
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("ADD (usa_filas CHAR(1 CHAR) DEFAULT 'S' NOT NULL)", $conteudo);
        $this->assertStringContainsString("ADD (usa_pesquisa_satisfacao CHAR(1 CHAR) DEFAULT 'S' NOT NULL)", $conteudo);
        $this->assertStringContainsString("ADD (usa_agendamentos CHAR(1 CHAR) DEFAULT 'S' NOT NULL)", $conteudo);
        $this->assertStringContainsString("ADD CONSTRAINT ck_cu_usa_filas CHECK (usa_filas IN ('S', 'N'))", $conteudo);
        $this->assertStringContainsString("ADD CONSTRAINT ck_cu_usa_pesq_sat CHECK (usa_pesquisa_satisfacao IN ('S', 'N'))", $conteudo);
        $this->assertStringContainsString("ADD CONSTRAINT ck_cu_usa_agend CHECK (usa_agendamentos IN ('S', 'N'))", $conteudo);
        $this->assertStringContainsString('ALTER TABLE cad_unidade DROP COLUMN usa_agendamentos', $conteudo);
        $this->assertStringContainsString('ALTER TABLE cad_unidade DROP COLUMN usa_pesquisa_satisfacao', $conteudo);
        $this->assertStringContainsString('ALTER TABLE cad_unidade DROP COLUMN usa_filas', $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALUNIDADECAPACIDADESMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroEleitoralVagasUiTest.php`
## <TESTS_UNIT_CADASTROELEITORALVAGASUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroEleitoralVagasUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroEleitoralVagasUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_vagas_em_locais_usa_tabela_de_coluna_unica_sem_numero_do_local(): void
public function tela_de_vagas_em_locais_usa_select2_no_filtro_de_bairro_sem_quebrar_a_cascata(): void
public function javascript_de_vagas_em_locais_inicializa_select2_e_sincroniza_o_filtro_de_bairro_na_cascata(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CadastroEleitoralVagasUiTest extends TestCase
{
    #[Test]
    public function tela_de_vagas_em_locais_usa_tabela_de_coluna_unica_sem_numero_do_local(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/vagas.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<th scope="col">Local</th>', $conteudo);
        $this->assertStringNotContainsString('<th scope="col">Zona</th>', $conteudo);
        $this->assertStringNotContainsString('<th scope="col">Nº Local</th>', $conteudo);
        $this->assertStringContainsString('vagas-local__linha', $conteudo);
        $this->assertStringContainsString('data-col="localidade"', $conteudo);
        $this->assertStringContainsString('data-col="secoes"', $conteudo);
        $this->assertStringContainsString('data-col="eleitores-aptos"', $conteudo);
        $this->assertStringContainsString('data-col="secoes-total"', $conteudo);
        $this->assertStringContainsString('vagas-local__metricas', $conteudo);
        $this->assertStringContainsString('vagas-local__badge--aptos', $conteudo);
        $this->assertStringContainsString('vagas-local__badge--secoes', $conteudo);
        $this->assertStringContainsString('vagas-local__badge--vagas', $conteudo);
        $this->assertStringContainsString('aptos', $conteudo);
        $this->assertStringContainsString('seções', $conteudo);
        $this->assertStringNotContainsString('vagas-local__metrica-secundaria', $conteudo);
        $this->assertStringContainsString('.vagas-local__badge--vagas {', $conteudo);
        $this->assertStringContainsString('background: #fef3c7;', $conteudo);
        $this->assertStringContainsString('color: #000000;', $conteudo);
        $this->assertStringContainsString('.vagas-local__badge--aptos {', $conteudo);
        $this->assertStringContainsString('background: #fce7f3;', $conteudo);
        $this->assertStringContainsString('.vagas-local__badge--secoes {', $conteudo);
        $this->assertStringContainsString('background: #e5e7eb;', $conteudo);
        $this->assertStringContainsString('color: #000000;', $conteudo);
        $this->assertStringContainsString('display: flex;', $conteudo);
        $this->assertStringContainsString('flex-wrap: wrap;', $conteudo);
        $this->assertStringNotContainsString('vagas-local__badge--ok', $conteudo);
        $this->assertStringNotContainsString('vagas-local__badge--zero', $conteudo);
    }

    #[Test]
    public function tela_de_vagas_em_locais_usa_select2_no_filtro_de_bairro_sem_quebrar_a_cascata(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/vagas.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<label for="filtroBairroSelect" class="form-label">Bairro</label>', $conteudo);
        $this->assertStringContainsString('id="filtroBairroSelect"', $conteudo);
        $this->assertStringContainsString('name="bairro"', $conteudo);
        $this->assertStringContainsString('class="form-select select2"', $conteudo);
        $this->assertStringContainsString('data-placeholder="{{ ($filtros[\'localidade\'] ?? \'\') === \'\' ? \'Selecione uma localidade primeiro\' : \'Todos\' }}"', $conteudo);
        $this->assertStringContainsString('{{ ($filtros[\'localidade\'] ?? \'\') === \'\' ? \'disabled\' : \'\' }}', $conteudo);
        $this->assertStringContainsString("<option value=\"\">{{ (\$filtros['localidade'] ?? '') === '' ? 'Selecione uma localidade primeiro' : 'Todos' }}</option>", $conteudo);
    }

    #[Test]
    public function javascript_de_vagas_em_locais_inicializa_select2_e_sincroniza_o_filtro_de_bairro_na_cascata(): void
    {
        $conteudo = file_get_contents(public_path('js/cadastro-eleitoral-vagas.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("const atualizarSelect2Bairro = () => {", $conteudo);
        $this->assertStringContainsString("if (!window.jQuery || !window.jQuery.fn || !window.jQuery.fn.select2 || !filtroBairroSelect) {", $conteudo);
        $this->assertStringContainsString("if (!window.jQuery(filtroBairroSelect).hasClass('select2-hidden-accessible')) {", $conteudo);
        $this->assertStringContainsString("placeholder: filtroBairroSelect.dataset.placeholder || 'Todos'", $conteudo);
        $this->assertStringContainsString("allowClear: true", $conteudo);
        $this->assertStringContainsString("window.jQuery(filtroBairroSelect).trigger('change.select2');", $conteudo);
        $this->assertStringContainsString("filtroBairroSelect.dataset.placeholder = !filtroLocalidadeSelect || filtroLocalidadeSelect.value === ''", $conteudo);
        $this->assertStringContainsString("atualizarSelect2Bairro();", $conteudo);
    }
}
```
</TESTS_UNIT_CADASTROELEITORALVAGASUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CalendarioEleitoralCargaOficialTest.php`
## <TESTS_UNIT_CALENDARIOELEITORALCARGAOFICIALTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CalendarioEleitoralCargaOficialTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CalendarioEleitoralCargaOficialTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_carga_versionada_contem_os_105_eventos_oficiais(): void
public function test_carga_preserva_periodos_e_os_seis_eventos_finais_ausentes_no_aplicativo_de_referencia(): void
public function test_migrations_do_modulo_sao_separadas_e_exclusivas(): void
private function possuiPeriodo(array $eventos, string $inicio, string $fim): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class CalendarioEleitoralCargaOficialTest extends TestCase
{
    private const MIGRATIONS = [
        '2026_08_02_100000_create_ele_cal_pleito_table.php',
        '2026_08_02_101000_create_ele_cal_competencia_table.php',
        '2026_08_02_102000_create_ele_cal_evento_table.php',
        '2026_08_02_103000_load_eleicoes_2026_calendario_eleitoral.php',
    ];

    public function test_carga_versionada_contem_os_105_eventos_oficiais(): void
    {
        $arquivo = database_path('data/calendario-eleitoral/eleicoes-2026.json');

        $this->assertFileExists($arquivo);
        $dados = json_decode((string) file_get_contents($arquivo), true, 512, JSON_THROW_ON_ERROR);
        $eventos = $dados['eventos'] ?? [];

        $this->assertSame(2026, $dados['pleito']['ano'] ?? null);
        $this->assertCount(105, $eventos);
        $this->assertCount(105, array_unique(array_column($eventos, 'codigo')));
        $this->assertSame('2026-04-06', $eventos[0]['data_inicio'] ?? null);
        $this->assertSame('2027-05-05', $eventos[104]['data_inicio'] ?? null);

        foreach ($eventos as $evento) {
            $this->assertNotSame('', trim((string) ($evento['codigo'] ?? '')));
            $this->assertNotSame('', trim((string) ($evento['competencia'] ?? '')));
            $this->assertNotSame('', trim((string) ($evento['evento'] ?? '')));
            $this->assertMatchesRegularExpression('/^\d{4}-\d{2}-\d{2}$/', (string) ($evento['data_inicio'] ?? ''));
        }
    }

    public function test_carga_preserva_periodos_e_os_seis_eventos_finais_ausentes_no_aplicativo_de_referencia(): void
    {
        $dados = json_decode(
            (string) file_get_contents(database_path('data/calendario-eleitoral/eleicoes-2026.json')),
            true,
            512,
            JSON_THROW_ON_ERROR
        );
        $eventos = $dados['eventos'];

        $this->assertTrue($this->possuiPeriodo($eventos, '2026-06-13', '2026-06-14'));
        $this->assertTrue($this->possuiPeriodo($eventos, '2026-12-19', '2026-12-20'));

        $finais = array_values(array_filter(
            $eventos,
            static fn (array $evento): bool => ($evento['ordem'] ?? 0) >= 100
        ));

        $this->assertCount(6, $finais);
        $this->assertSame(
            ['2027-03-01', '2027-03-01', '2027-03-03', '2027-04-30', '2027-05-04', '2027-05-05'],
            array_column($finais, 'data_inicio')
        );
    }

    public function test_migrations_do_modulo_sao_separadas_e_exclusivas(): void
    {
        foreach (self::MIGRATIONS as $migration) {
            $this->assertFileExists(database_path('migrations/'.$migration));
        }

        $evento = (string) file_get_contents(database_path('migrations/'.self::MIGRATIONS[2]));
        $carga = (string) file_get_contents(database_path('migrations/'.self::MIGRATIONS[3]));

        $this->assertStringContainsString('ELE_CAL_EVENTO', mb_strtoupper($evento));
        $this->assertStringContainsString('PLEITO_ID', mb_strtoupper($evento));
        $this->assertStringContainsString('COMPETENCIA_ID', mb_strtoupper($evento));
        $this->assertStringContainsString('eleicoes-2026.json', $carga);
    }

    /** @param array<int, array<string, mixed>> $eventos */
    private function possuiPeriodo(array $eventos, string $inicio, string $fim): bool
    {
        foreach ($eventos as $evento) {
            if (($evento['data_inicio'] ?? null) === $inicio && ($evento['data_fim'] ?? null) === $fim) {
                return true;
            }
        }

        return false;
    }
}
```
</TESTS_UNIT_CALENDARIOELEITORALCARGAOFICIALTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralDesistenciaControllerTest.php`
## <TESTS_UNIT_COLABORADORELEITORALDESISTENCIACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralDesistenciaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralDesistenciaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_solicitar_desistencia_deferida_retorna_sucesso(): void
public function test_gestor_registra_desistencia_repassando_usuario_e_escopo(): void
public function test_gestor_nao_registra_desistencia_fora_do_escopo_ou_de_status_invalido(): void
public function test_gestor_sem_usuario_identificado_nao_registra_desistencia(): void
public function test_aceitar_desistencia_repassa_escopo_da_unidade_deferidora(): void
public function test_rejeitar_desistencia_retorna_sucesso(): void
public function test_reverter_indeferimento_para_deferida_repassa_escopo_da_unidade_deferidora(): void
private function novoController(
private function mockEscopo(EscopoUnidade $escopo): EscopoUnidadeService
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ColaboradoresEleitorais\ColaboradorEleitoralController;
use App\Http\Requests\ColaboradoresEleitorais\DesistenciaCandidaturaRequest;
use App\Repositories\ColaboradoresEleitorais\Contracts\CandidaturaColaboradorRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ColaboradorEleitoralEscalaRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\EventoVoluntarioRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ProcessoEleitoralRepositoryInterface;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\ColaboradoresEleitorais\CandidaturaDecisaoService;
use App\Services\ColaboradoresEleitorais\ColaboradoresEleitoraisEscopoService;
use App\Services\EscopoUnidadeService;
use App\Support\EscopoUnidade;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class ColaboradorEleitoralDesistenciaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_solicitar_desistencia_deferida_retorna_sucesso(): void
    {
        session(['user.username' => 'servidor.teste']);

        $candidaturas = Mockery::mock(CandidaturaColaboradorRepositoryInterface::class);
        $candidaturas->shouldReceive('solicitarDesistenciaDeferida')
            ->once()
            ->with(9, 'servidor.teste', 'Motivo consistente para desistência.')
            ->andReturnTrue();

        $controller = $this->novoController(candidaturas: $candidaturas);
        $request = Mockery::mock(DesistenciaCandidaturaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'motivo' => 'Motivo consistente para desistência.',
        ]);

        $response = $controller->solicitarDesistenciaCandidatura($request, 9);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Solicitação de desistência registrada com sucesso.', $response->getData(true)['mensagem']);
    }

    public function test_gestor_registra_desistencia_repassando_usuario_e_escopo(): void
    {
        session(['user.username' => 'gestor.teste']);

        $decisao = Mockery::mock(CandidaturaDecisaoService::class);
        $decisao->shouldReceive('registrarDesistenciaPeloGestorComNotificacao')
            ->once()
            ->with(37, 'gestor.teste', 'Desistência confirmada pelo colaborador.', [10], false)
            ->andReturnTrue();

        $request = Mockery::mock(DesistenciaCandidaturaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'motivo' => 'Desistência confirmada pelo colaborador.',
        ]);

        $controller = $this->novoController(
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10])),
            decisao: $decisao
        );

        $response = $controller->registrarDesistenciaCandidaturaPeloGestor($request, 37);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Desistência registrada com sucesso.', $response->getData(true)['mensagem']);
    }

    public function test_gestor_nao_registra_desistencia_fora_do_escopo_ou_de_status_invalido(): void
    {
        session(['user.username' => 'gestor.teste']);

        $decisao = Mockery::mock(CandidaturaDecisaoService::class);
        $decisao->shouldReceive('registrarDesistenciaPeloGestorComNotificacao')
            ->once()
            ->with(38, 'gestor.teste', 'Desistência confirmada pelo colaborador.', [10], false)
            ->andReturnFalse();

        $request = Mockery::mock(DesistenciaCandidaturaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'motivo' => 'Desistência confirmada pelo colaborador.',
        ]);

        $controller = $this->novoController(
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10])),
            decisao: $decisao
        );

        $response = $controller->registrarDesistenciaCandidaturaPeloGestor($request, 38);

        $this->assertSame(404, $response->getStatusCode());
        $this->assertSame(
            'Candidatura não encontrada, não está deferida ou está fora do escopo.',
            $response->getData(true)['mensagem']
        );
    }

    public function test_gestor_sem_usuario_identificado_nao_registra_desistencia(): void
    {
        $decisao = Mockery::mock(CandidaturaDecisaoService::class);
        $decisao->shouldNotReceive('registrarDesistenciaPeloGestorComNotificacao');

        $request = Mockery::mock(DesistenciaCandidaturaRequest::class);
        $request->shouldNotReceive('validated');

        $controller = $this->novoController(decisao: $decisao);

        $response = $controller->registrarDesistenciaCandidaturaPeloGestor($request, 39);

        $this->assertSame(403, $response->getStatusCode());
        $this->assertSame(
            'Usuário não identificado para deferimento.',
            $response->getData(true)['mensagem']
        );
    }

    public function test_aceitar_desistencia_repassa_escopo_da_unidade_deferidora(): void
    {
        session(['user.username' => 'analista.deferidor']);

        $candidaturas = Mockery::mock(CandidaturaColaboradorRepositoryInterface::class);
        $candidaturas->shouldReceive('aceitarSolicitacaoDesistencia')
            ->once()
            ->with(15, 'analista.deferidor', [10], false)
            ->andReturnTrue();

        $controller = $this->novoController(
            candidaturas: $candidaturas,
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10]))
        );

        $response = $controller->aceitarDesistenciaCandidatura(15);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Solicitação de desistência aceita com sucesso.', $response->getData(true)['mensagem']);
    }

    public function test_rejeitar_desistencia_retorna_sucesso(): void
    {
        session(['user.username' => 'analista.deferidor']);

        $candidaturas = Mockery::mock(CandidaturaColaboradorRepositoryInterface::class);
        $candidaturas->shouldReceive('rejeitarSolicitacaoDesistencia')
            ->once()
            ->with(21, 'analista.deferidor', 'A unidade ainda necessita da colaboração deferida.', [10], false)
            ->andReturnTrue();

        $controller = $this->novoController(
            candidaturas: $candidaturas,
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10]))
        );

        $request = Request::create('/colaboradores-eleitorais/deferimento/21/rejeitar-desistencia', 'POST', [
            'motivo' => 'A unidade ainda necessita da colaboração deferida.',
        ]);

        $response = $controller->rejeitarDesistenciaCandidatura($request, 21);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Solicitação de desistência rejeitada com sucesso.', $response->getData(true)['mensagem']);
    }

    public function test_reverter_indeferimento_para_deferida_repassa_escopo_da_unidade_deferidora(): void
    {
        session(['user.username' => 'analista.deferidor']);

        $decisao = Mockery::mock(CandidaturaDecisaoService::class);
        $decisao->shouldReceive('reverterIndeferimentoParaDeferidaComNotificacao')
            ->once()
            ->with(31, 'analista.deferidor', [10], false)
            ->andReturnTrue();

        $controller = $this->novoController(
            escopo: $this->mockEscopo(EscopoUnidade::restrito([10])),
            decisao: $decisao
        );

        $response = $controller->reverterIndeferimentoParaDeferida(31);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('Candidatura revertida para deferida com sucesso.', $response->getData(true)['mensagem']);
    }

    private function novoController(
        ?CandidaturaColaboradorRepositoryInterface $candidaturas = null,
        ?EscopoUnidadeService $escopo = null,
        ?CandidaturaDecisaoService $decisao = null
    ): ColaboradorEleitoralController {
        return new ColaboradorEleitoralController(
            Mockery::mock(ProcessoEleitoralRepositoryInterface::class),
            $candidaturas ?? Mockery::mock(CandidaturaColaboradorRepositoryInterface::class),
            Mockery::mock(ColaboradorEleitoralEscalaRepositoryInterface::class),
            $escopo ?? $this->mockEscopo(EscopoUnidade::restrito([10])),
            $decisao ?? Mockery::mock(CandidaturaDecisaoService::class),
            Mockery::mock(ColaboradoresEleitoraisEscopoService::class),
            Mockery::mock(EventoVoluntarioRepositoryInterface::class),
            Mockery::mock(ZonaRepository::class),
        );
    }

    private function mockEscopo(EscopoUnidade $escopo): EscopoUnidadeService
    {
        $service = Mockery::mock(EscopoUnidadeService::class);
        $service->shouldReceive('escopoAtual')->andReturn($escopo);

        return $service;
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALDESISTENCIACONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralDesistenciaMigrationTest.php`
## <TESTS_UNIT_COLABORADORELEITORALDESISTENCIAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralDesistenciaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralDesistenciaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_campos_de_solicitacao_e_decisao_de_desistencia(): void
public function migration_expande_status_para_desistencia_solicitada(): void
public function migration_expande_tamanho_da_coluna_status_para_120_caracteres(): void
public function migration_vincula_rota_de_solicitar_desistencia_ao_grupo_de_inscricao(): void
public function migration_vincula_rotas_de_decisao_da_desistencia_aos_grupos_de_deferimento(): void
public function migration_vincula_rota_de_reversao_para_os_mesmos_grupos_de_deferimento(): void
public function migration_expande_notificacao_para_status_cancelada(): void
public function migration_vincula_desistencia_gestor_aos_grupos_de_deferimento(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralDesistenciaMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_campos_de_solicitacao_e_decisao_de_desistencia(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_04_28_130000_add_desistencia_fields_to_ce_candidatura_colaborador.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ADD MOTIVO_DESISTENCIA VARCHAR2(1000 CHAR)', $conteudo);
        $this->assertStringContainsString('ADD DT_SOLICITACAO_CANCELAMENTO DATE', $conteudo);
        $this->assertStringContainsString('ADD DECISAO_CANCELAMENTO_POR VARCHAR2(120 CHAR)', $conteudo);
        $this->assertStringContainsString('ADD DT_DECISAO_CANCELAMENTO DATE', $conteudo);
        $this->assertStringContainsString('ADD MOTIVO_REJEICAO_CANCELAMENTO VARCHAR2(1000 CHAR)', $conteudo);
    }

    #[Test]
    public function migration_expande_status_para_desistencia_solicitada(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_04_28_130100_expand_ce_candidatura_colaborador_status_for_desistencia.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'DESISTENCIA_SOLICITADA'", $conteudo);
        $this->assertStringContainsString('DROP CONSTRAINT CK_CE_CAND_COLAB_STATUS', $conteudo);
        $this->assertStringContainsString("SET STATUS = 'DEFERIDA'", $conteudo);
    }

    #[Test]
    public function migration_expande_tamanho_da_coluna_status_para_120_caracteres(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_05_25_120000_expand_ce_candidatura_colaborador_status_column_length.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('MODIFY (STATUS VARCHAR2(120 CHAR))', $conteudo);
        $this->assertStringContainsString('MODIFY (STATUS VARCHAR2(20 CHAR))', $conteudo);
    }

    #[Test]
    public function migration_vincula_rota_de_solicitar_desistencia_ao_grupo_de_inscricao(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_06_02_120000_grant_desistencia_route_to_colaborador_inscricao_group.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("private const GRUPO_NOME = 'PLANELEITO_COLABORADOR_INSCRICAO';", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'colaboradores-eleitorais.candidaturas.solicitar-desistencia'", $conteudo);
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
        $this->assertStringContainsString("'ativo' => 1", $conteudo);
        $this->assertStringContainsString("'ativo' => 0", $conteudo);
    }

    #[Test]
    public function migration_vincula_rotas_de_decisao_da_desistencia_aos_grupos_de_deferimento(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_06_02_141500_grant_desistencia_decision_routes_to_deferimento_groups.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'PLANELEITO_OPERADOR'", $conteudo);
        $this->assertStringContainsString("'PLANELEITO_COLABORADORES_ADMIN'", $conteudo);
        $this->assertStringContainsString("'PLANELEITO_COLABORADORES_CONSIDERA_TAREFA'", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'colaboradores-eleitorais.deferimento.aceitar-desistencia'", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'colaboradores-eleitorais.deferimento.rejeitar-desistencia'", $conteudo);
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
        $this->assertStringContainsString("'ativo' => 1", $conteudo);
        $this->assertStringContainsString("'ativo' => 0", $conteudo);
    }

    #[Test]
    public function migration_vincula_rota_de_reversao_para_os_mesmos_grupos_de_deferimento(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_06_18_000000_grant_reverter_deferimento_route_to_deferimento_groups.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'PLANELEITO_OPERADOR'", $conteudo);
        $this->assertStringContainsString("'PLANELEITO_COLABORADORES_ADMIN'", $conteudo);
        $this->assertStringContainsString("'PLANELEITO_COLABORADORES_CONSIDERA_TAREFA'", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'colaboradores-eleitorais.deferimento.reverter-para-deferida'", $conteudo);
        $this->assertStringContainsString("'rota_path' => 'colaboradores-eleitorais/deferimento/{id}/reverter-para-deferida'", $conteudo);
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
        $this->assertStringContainsString("'ativo' => 1", $conteudo);
        $this->assertStringContainsString("'ativo' => 0", $conteudo);
    }

    #[Test]
    public function migration_expande_notificacao_para_status_cancelada(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_08_06_130000_expand_ce_candidatura_notificacao_status_for_cancelada.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CK_CE_CAND_NOTIF_STATUS', $conteudo);
        $this->assertStringContainsString("'DEFERIDA', 'INDEFERIDA', 'CANCELADA'", $conteudo);
        $this->assertStringContainsString("WHERE STATUS_CANDIDATURA = 'CANCELADA'", $conteudo);
    }

    #[Test]
    public function migration_vincula_desistencia_gestor_aos_grupos_de_deferimento(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_08_06_131000_grant_desistencia_gestor_route_to_deferimento_groups.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'PLANELEITO_OPERADOR'", $conteudo);
        $this->assertStringContainsString("'PLANELEITO_COLABORADORES_ADMIN'", $conteudo);
        $this->assertStringContainsString("'PLANELEITO_COLABORADORES_CONSIDERA_TAREFA'", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'colaboradores-eleitorais.deferimento.registrar-desistencia'", $conteudo);
        $this->assertStringContainsString("'rota_path' => 'colaboradores-eleitorais/deferimento/{id}/registrar-desistencia'", $conteudo);
        $this->assertStringContainsString("'ativo' => 1", $conteudo);
        $this->assertStringContainsString("'ativo' => 0", $conteudo);
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALDESISTENCIAMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralDesistenciaUiTest.php`
## <TESTS_UNIT_COLABORADORELEITORALDESISTENCIAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralDesistenciaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralDesistenciaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function telas_de_candidatura_expoem_fluxo_de_solicitacao_de_desistencia(): void
public function telas_de_deferimento_expoem_acoes_para_decidir_solicitacao_de_desistencia(): void
public function telas_expoem_desistencia_direta_do_gestor_e_historico_cancelado(): void
public function telas_de_deferimento_expoem_acao_de_reanalise_de_indeferimento(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralDesistenciaUiTest extends TestCase
{
    #[Test]
    public function telas_de_candidatura_expoem_fluxo_de_solicitacao_de_desistencia(): void
    {
        $index = file_get_contents(resource_path('views/colaboradores-eleitorais/candidaturas/index.blade.php'));
        $minhas = file_get_contents(resource_path('views/colaboradores-eleitorais/candidaturas/minhas.blade.php'));
        $processos = file_get_contents(resource_path('views/colaboradores-eleitorais/candidaturas/processos.blade.php'));
        $js = file_get_contents(public_path('js/colaboradores-eleitorais/candidaturas.js'));

        $this->assertIsString($index);
        $this->assertIsString($minhas);
        $this->assertIsString($processos);
        $this->assertIsString($js);

        $this->assertStringContainsString('<option value="DESISTENCIA_SOLICITADA">Desistência solicitada</option>', $index);
        $this->assertStringContainsString('solicitarDesistenciaBase', $index);
        $this->assertStringContainsString('btn-solicitar-desistencia-candidatura', $minhas);
        $this->assertStringContainsString('DESISTÊNCIA SOLICITADA', $minhas);
        $this->assertStringContainsString('motivo_desistencia', $minhas);
        $this->assertStringContainsString('DESISTÊNCIA SOLICITADA', $processos);
        $this->assertStringContainsString("/solicitar-desistencia', {", $js);
    }

    #[Test]
    public function telas_de_deferimento_expoem_acoes_para_decidir_solicitacao_de_desistencia(): void
    {
        $index = file_get_contents(resource_path('views/colaboradores-eleitorais/deferimento/index.blade.php'));
        $lista = file_get_contents(resource_path('views/colaboradores-eleitorais/deferimento/lista.blade.php'));
        $js = file_get_contents(public_path('js/colaboradores-eleitorais/deferimento.js'));

        $this->assertIsString($index);
        $this->assertIsString($lista);
        $this->assertIsString($js);

        $this->assertStringContainsString('<option value="DESISTENCIA_SOLICITADA">Desistência solicitada</option>', $index);
        $this->assertStringContainsString('aceitarDesistenciaBase', $index);
        $this->assertStringContainsString('rejeitarDesistenciaBase', $index);
        $this->assertStringContainsString('btn-aceitar-desistencia', $lista);
        $this->assertStringContainsString('btn-rejeitar-desistencia', $lista);
        $this->assertStringContainsString('MOTIVO_REJEICAO_CANCELAMENTO', strtoupper($lista));
        $this->assertStringContainsString("/aceitar-desistencia', {", $js);
        $this->assertStringContainsString("/rejeitar-desistencia',", $js);
    }

    #[Test]
    public function telas_expoem_desistencia_direta_do_gestor_e_historico_cancelado(): void
    {
        $index = file_get_contents(resource_path('views/colaboradores-eleitorais/deferimento/index.blade.php'));
        $lista = file_get_contents(resource_path('views/colaboradores-eleitorais/deferimento/lista.blade.php'));
        $minhas = file_get_contents(resource_path('views/colaboradores-eleitorais/candidaturas/minhas.blade.php'));
        $js = file_get_contents(public_path('js/colaboradores-eleitorais/deferimento.js'));

        $this->assertIsString($index);
        $this->assertIsString($lista);
        $this->assertIsString($minhas);
        $this->assertIsString($js);

        $this->assertStringContainsString('<option value="CANCELADA">Cancelada</option>', $index);
        $this->assertStringContainsString('registrarDesistenciaBase', $index);
        $this->assertStringContainsString('btn-registrar-desistencia-gestor', $lista);
        $this->assertStringContainsString('DECISAO_CANCELAMENTO_POR', strtoupper($lista));
        $this->assertStringContainsString('DT_DECISAO_CANCELAMENTO', strtoupper($lista));
        $this->assertStringContainsString('MOTIVO_DESISTENCIA', strtoupper($minhas));
        $this->assertStringContainsString('DECISAO_CANCELAMENTO_POR', strtoupper($minhas));
        $this->assertStringContainsString("/registrar-desistencia',", $js);
    }

    #[Test]
    public function telas_de_deferimento_expoem_acao_de_reanalise_de_indeferimento(): void
    {
        $index = file_get_contents(resource_path('views/colaboradores-eleitorais/deferimento/index.blade.php'));
        $lista = file_get_contents(resource_path('views/colaboradores-eleitorais/deferimento/lista.blade.php'));
        $js = file_get_contents(public_path('js/colaboradores-eleitorais/deferimento.js'));

        $this->assertIsString($index);
        $this->assertIsString($lista);
        $this->assertIsString($js);

        $this->assertStringContainsString('reverterParaDeferidaBase', $index);
        $this->assertStringContainsString('btn-reverter-para-deferida', $lista);
        $this->assertStringContainsString("/reverter-para-deferida', {", $js);
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALDESISTENCIAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralSupervisoresPredioControllerTest.php`
## <TESTS_UNIT_COLABORADORELEITORALSUPERVISORESPREDIOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralSupervisoresPredioControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralSupervisoresPredioControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function listagem_de_supervisores_hidrata_respostas_do_questionario_e_dados_auxiliares_da_view(): void
public function consulta_parametrizada_de_local_com_mais_de_um_supervisor_aplica_filtro_e_preserva_selecao(): void
public function exportacao_pdf_reaplica_consulta_parametrizada_de_local_com_mais_de_um_supervisor(): void
public function consulta_parametrizada_de_locais_sem_supervisor_parte_dos_locais_de_votacao(): void
public function exportacao_pdf_usa_campos_explicitos_para_local_de_voto_e_atuacao(): void
private function novoController(): SupervisorPredioAdminController
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\SupervisoresPredio\SupervisorPredioAdminController;
use App\Repositories\SupervisoresPredio\CadastroSupervisorPredioRepository;
use App\Services\Auditoria\AuditLogService;
use Barryvdh\DomPDF\Facade\Pdf;
use Barryvdh\DomPDF\PDF as DomPdfWrapper;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralSupervisoresPredioControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function listagem_de_supervisores_hidrata_respostas_do_questionario_e_dados_auxiliares_da_view(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios', 'GET', [
            'dt_atualizacao_de' => '2026-05-01',
            'dt_atualizacao_ate' => '2026-05-31',
        ]);
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')
            ->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $supervisor = (object) [
            'id_supervisor_predio' => 63,
            'num_inscricao' => '002266412453',
            'nome' => 'EDCLEY DA SILVA FIRMINO',
            'num_cpf' => '43416160215',
            'email' => 'edcley.silva@gmail.com',
            'telefone' => '(68) 99212-7980',
            'possui_whatsapp' => 'SIM',
            'nivel_conhecimento_informatica' => 'AVANCADO',
            'nivel_escolaridade' => 'POS_GRADUACAO',
            'pix_cpf' => '434.161.602-15',
            'codigo_banco' => '104',
            'nome_banco' => 'CAIXA ECONOMICA FEDERAL',
            'agencia' => '3950',
            'conta' => '7872',
            'num_zona' => '9',
            'localidade' => 'RIO BRANCO',
            'nom_local' => 'ESCOLA JOSE SALES DE ARAUJO',
            'num_local' => '1260',
            'localidade_voto' => 'RIO BRANCO',
            'nom_local_voto' => 'ESCOLA FRANCISCO AUGUSTO BACURAU',
            'num_local_voto' => '1222',
            'dt_criacao_fmt' => '2026-05-15 17:12',
            'dt_atualizacao_fmt' => '2026-05-15 17:27',
            'origem_cadastro' => 'INTERNO',
            'origem_cadastro_label' => 'Interno',
        ];

        $paginator = new LengthAwarePaginator([$supervisor], 1, 20, 1, [
            'path' => $request->url(),
            'query' => $request->query(),
        ]);

        $consultaSupervisores = Mockery::mock();
        $consultaSupervisores->shouldReceive('join')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('leftJoin')->times(4)->andReturnSelf();
        $consultaSupervisores->shouldReceive('where')->once()->with('csp.ativo', 1)->andReturnSelf();
        $consultaSupervisores->shouldReceive('selectRaw')->once()->with(Mockery::on(static fn (string $sql): bool =>
            str_contains($sql, 'NVL(TRIM(csp.nome_supervisor), TRIM(e.nom_eleitor)) as nome')
            && str_contains($sql, 'NVL(TRIM(csp.cpf_supervisor), TRIM(e.num_cpf)) as num_cpf')
            && str_contains($sql, 'origem_cadastro_label')
        ))->andReturnSelf();
        $consultaSupervisores->shouldReceive('orderByRaw')->once()->with("UPPER(NVL(lv.nom_localidade, CHR(0))) , UPPER(NVL(lv.nom_local, CHR(0))) , UPPER(NVL(csp.nome_supervisor, NVL(e.nom_eleitor, csp.num_inscricao)))")->andReturnSelf();
        $consultaSupervisores->shouldReceive('whereRaw')->once()
            ->with("csp.dt_atualizacao >= TO_DATE(?, 'YYYY-MM-DD')", ['2026-05-01'])->andReturnSelf();
        $consultaSupervisores->shouldReceive('whereRaw')->once()
            ->with("csp.dt_atualizacao < TO_DATE(?, 'YYYY-MM-DD') + 1", ['2026-05-31'])->andReturnSelf();
        $consultaSupervisores->shouldReceive('paginate')->once()->with(20)->andReturn($paginator);

        $consultaRespostas = Mockery::mock();
        $consultaRespostas->shouldReceive('join')
            ->once()
            ->with('cad_supervisor_pergunta as p', 'p.id_supervisor_pergunta', '=', 'r.id_supervisor_pergunta')
            ->andReturnSelf();
        $consultaRespostas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaRespostas->shouldReceive('whereIn')->once()->with('r.id_supervisor_predio', [63])->andReturnSelf();
        $consultaRespostas->shouldReceive('orderBy')->once()->with('p.ordem')->andReturnSelf();
        $consultaRespostas->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'id_supervisor_predio' => 63,
                'codigo' => 'autoriza_email',
                'label' => 'Autorizo receber convocação por e-mail',
                'valor_resposta' => 'SIM',
                'ordem' => 1,
            ],
            (object) [
                'id_supervisor_predio' => 63,
                'codigo' => 'aceite_lgpd',
                'label' => 'Li e aceito os termos de uso e tratamento dos meus dados pessoais conforme descrito acima.',
                'valor_resposta' => 'SIM',
                'ordem' => 2,
            ],
        ]));

        $consultaZonas = Mockery::mock();
        $consultaZonas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('whereNotNull')->once()->with('lv.cod_objeto_zona')->andReturnSelf();
        $consultaZonas->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('pluck')->once()->with('num_zona')->andReturn(collect(['9']));

        $consultaMunicipios = Mockery::mock();
        $consultaMunicipios->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('whereNotNull')->once()->with('lv.cod_objeto_zona')->andReturnSelf();
        $consultaMunicipios->shouldReceive('whereNotNull')->once()->with('lv.nom_localidade')->andReturnSelf();
        $consultaMunicipios->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('orderBy')->once()->with('localidade')->andReturnSelf();
        $consultaMunicipios->shouldReceive('get')->once()->andReturn(collect([
            (object) ['num_zona' => '9', 'localidade' => 'RIO BRANCO'],
        ]));

        DB::shouldReceive('table')->once()->with('cad_supervisor_predio as csp')->andReturn($consultaSupervisores);
        DB::shouldReceive('table')->once()->with('cad_supervisor_resposta as r')->andReturn($consultaRespostas);
        DB::shouldReceive('table')
            ->twice()
            ->with('planeleito.vw_locais_votacao_efetivos as lv')
            ->andReturn($consultaZonas, $consultaMunicipios);

        $schema = Mockery::mock();
        $schema->shouldReceive('hasTable')->once()->with('cad_supervisor_resposta')->andReturnTrue();
        $schema->shouldReceive('hasTable')->once()->with('cad_supervisor_pergunta')->andReturnTrue();
        Schema::swap($schema);

        $controller = $this->novoController();

        $view = $controller->index($request);

        $this->assertInstanceOf(View::class, $view);
        $this->assertSame('colaboradores-eleitorais.externos.supervisores-predio.index', $view->name());

        $dados = $view->getData();
        $this->assertArrayHasKey('supervisores', $dados);
        $this->assertInstanceOf(LengthAwarePaginator::class, $dados['supervisores']);
        $this->assertCount(1, $dados['supervisores']->items());
        $this->assertSame('9', $dados['zonasDisponiveis']->all()[0] ?? null);
        $this->assertSame(['9' => ['RIO BRANCO']], $dados['municipiosPorZona']);
        $this->assertSame(['RIO BRANCO'], $dados['municipiosDisponiveis']->all());
        $this->assertSame([
            'q' => '',
            'zona' => '',
            'municipio' => '',
            'possui_whatsapp' => '',
            'local_coincide' => '',
            'dt_atualizacao_de' => '2026-05-01',
            'dt_atualizacao_ate' => '2026-05-31',
        ], $dados['filtros']);

        $item = $dados['supervisores']->items()[0];
        $this->assertSame('EDCLEY DA SILVA FIRMINO', $item->nome);
        $this->assertSame('ESCOLA JOSE SALES DE ARAUJO', $item->nom_local);
        $this->assertSame('ESCOLA FRANCISCO AUGUSTO BACURAU', $item->nom_local_voto);
        $this->assertSame('INTERNO', $item->origem_cadastro);
        $this->assertSame('Interno', $item->origem_cadastro_label);
        $this->assertSame([
            [
                'codigo' => 'autoriza_email',
                'label' => 'Autorizo receber convocação por e-mail',
                'valor_resposta' => 'SIM',
            ],
            [
                'codigo' => 'aceite_lgpd',
                'label' => 'Li e aceito os termos de uso e tratamento dos meus dados pessoais conforme descrito acima.',
                'valor_resposta' => 'SIM',
            ],
        ], $item->respostas_questionario);
    }

    #[Test]
    public function consulta_parametrizada_de_local_com_mais_de_um_supervisor_aplica_filtro_e_preserva_selecao(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios', 'GET', [
            'local_coincide' => 'mais_de_um_supervisor_local',
        ]);
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')
            ->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $paginator = new LengthAwarePaginator([], 0, 20, 1, [
            'path' => $request->url(),
            'query' => $request->query(),
        ]);

        $consultaSupervisores = Mockery::mock();
        $consultaSupervisores->shouldReceive('join')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('leftJoin')->times(4)->andReturnSelf();
        $consultaSupervisores->shouldReceive('where')->once()->with('csp.ativo', 1)->andReturnSelf();
        $consultaSupervisores->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('whereRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains($sql, 'COUNT(*) > 1')
                && str_contains($sql, 'cad_supervisor_predio')))
            ->andReturnSelf();
        $consultaSupervisores->shouldReceive('paginate')->once()->with(20)->andReturn($paginator);

        $consultaZonas = Mockery::mock();
        $consultaZonas->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('whereNotNull')->once()->with('lv.cod_objeto_zona')->andReturnSelf();
        $consultaZonas->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaZonas->shouldReceive('pluck')->once()->with('num_zona')->andReturn(collect(['9']));

        $consultaMunicipios = Mockery::mock();
        $consultaMunicipios->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('whereNotNull')->once()->with('lv.cod_objeto_zona')->andReturnSelf();
        $consultaMunicipios->shouldReceive('whereNotNull')->once()->with('lv.nom_localidade')->andReturnSelf();
        $consultaMunicipios->shouldReceive('distinct')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaMunicipios->shouldReceive('orderBy')->once()->with('localidade')->andReturnSelf();
        $consultaMunicipios->shouldReceive('get')->once()->andReturn(collect([
            (object) ['num_zona' => '9', 'localidade' => 'RIO BRANCO'],
        ]));

        DB::shouldReceive('table')->once()->with('cad_supervisor_predio as csp')->andReturn($consultaSupervisores);
        DB::shouldReceive('table')
            ->twice()
            ->with('planeleito.vw_locais_votacao_efetivos as lv')
            ->andReturn($consultaZonas, $consultaMunicipios);

        $schema = Mockery::mock();
        $schema->shouldReceive('hasTable')->once()->with('cad_supervisor_resposta')->andReturnFalse();
        Schema::swap($schema);

        $controller = $this->novoController();

        $view = $controller->index($request);

        $this->assertInstanceOf(View::class, $view);
        $dados = $view->getData();
        $this->assertSame('mais_de_um_supervisor_local', $dados['filtros']['local_coincide'] ?? null);
    }

    #[Test]
    public function exportacao_pdf_reaplica_consulta_parametrizada_de_local_com_mais_de_um_supervisor(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios.exportar-pdf'],
            'acesso_todas_zonas' => true,
            'cod_zonas_permitidas' => [],
        ]);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios/exportar-pdf', 'GET', [
            'local_coincide' => 'mais_de_um_supervisor_local',
            'dt_atualizacao_de' => '2026-05-01',
            'dt_atualizacao_ate' => '2026-05-31',
        ]);
        $rota = Mockery::mock();
        $rota->shouldReceive('getName')
            ->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.exportar-pdf');
        $request->setRouteResolver(static fn () => $rota);
        $this->app->instance('request', $request);

        $consultaSupervisores = Mockery::mock();
        $consultaSupervisores->shouldReceive('join')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('leftJoin')->times(4)->andReturnSelf();
        $consultaSupervisores->shouldReceive('where')->once()->with('csp.ativo', 1)->andReturnSelf();
        $consultaSupervisores->shouldReceive('selectRaw')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('orderByRaw')->once()->andReturnSelf();
        $consultaSupervisores->shouldReceive('whereRaw')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains($sql, 'COUNT(*) > 1')
                && str_contains($sql, 'cad_supervisor_predio')))
            ->andReturnSelf();
        $consultaSupervisores->shouldReceive('whereRaw')->once()
            ->with("csp.dt_atualizacao >= TO_DATE(?, 'YYYY-MM-DD')", ['2026-05-01'])->andReturnSelf();
        $consultaSupervisores->shouldReceive('whereRaw')->once()
            ->with("csp.dt_atualizacao < TO_DATE(?, 'YYYY-MM-DD') + 1", ['2026-05-31'])->andReturnSelf();
        $consultaSupervisores->shouldReceive('get')->once()->andReturn(collect());

        DB::shouldReceive('table')->once()->with('cad_supervisor_predio as csp')->andReturn($consultaSupervisores);

        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('setPaper')->once()->with('a4', 'landscape')->andReturnSelf();
        $pdf->shouldReceive('stream')->once()->with('supervisores-predio-voluntarios.pdf')->andReturn(response('pdf'));

        Pdf::shouldReceive('loadView')
            ->once()
            ->with('colaboradores-eleitorais.externos.supervisores-predio.pdf', Mockery::on(static fn (array $dados): bool =>
                ($dados['filtros']['local_coincide'] ?? null) === 'mais_de_um_supervisor_local'
                && ($dados['filtros']['dt_atualizacao_de'] ?? null) === '2026-05-01'
                && ($dados['filtros']['dt_atualizacao_ate'] ?? null) === '2026-05-31'
            ))
            ->andReturn($pdf);

        $controller = $this->novoController();

        $response = $controller->exportarPdf($request);

        $this->assertSame('pdf', $response->getContent());
    }

    #[Test]
    public function consulta_parametrizada_de_locais_sem_supervisor_parte_dos_locais_de_votacao(): void
    {
        $blade = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php'));

        $this->assertStringContainsString('Locais sem supervisor de prédio voluntário alocado', $blade);
    }

    #[Test]
    public function exportacao_pdf_usa_campos_explicitos_para_local_de_voto_e_atuacao(): void
    {
        $index = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php'));
        $pdf = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/pdf.blade.php'));

        $this->assertStringContainsString("'local_voto' => 'Vota no Local'", $index);
        $this->assertStringContainsString("'local_supervisor' => 'Supervisor no local'", $index);
        $this->assertStringNotContainsString("'local_votacao' => 'Local de votação'", $index);
        $this->assertStringContainsString("\$mostrar('local_voto')", $pdf);
        $this->assertStringContainsString("<th>Vota no Local</th>", $pdf);
        $this->assertStringContainsString("\$item->nom_local_voto", $pdf);
        $this->assertStringContainsString("\$mostrar('local_supervisor')", $pdf);
        $this->assertStringContainsString("<th>Supervisor no local</th>", $pdf);
        $this->assertStringContainsString("\$item->nom_local", $pdf);
        $this->assertStringNotContainsString("\$mostrar('local_votacao')", $pdf);
    }

    private function novoController(): SupervisorPredioAdminController
    {
        return new SupervisorPredioAdminController(new CadastroSupervisorPredioRepository(app(AuditLogService::class)));
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALSUPERVISORESPREDIOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralSupervisoresPredioEditarLocalControllerTest.php`
## <TESTS_UNIT_COLABORADORELEITORALSUPERVISORESPREDIOEDITARLOCALCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralSupervisoresPredioEditarLocalControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralSupervisoresPredioEditarLocalControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function formulario_de_edicao_carrega_supervisor_e_opcoes_de_local(): void
public function formulario_de_edicao_retorna_404_para_supervisor_fora_do_escopo_zonal(): void
public function atualizacao_de_local_chama_repositorio_auditado_e_redireciona_para_listagem(): void
public function atualizacao_de_local_retorna_404_para_supervisor_fora_do_escopo_zonal(): void
private function novoController(): SupervisorPredioAdminController
private function mockZonaPermitida(int $zonaId, string $numZona): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\SupervisoresPredio\SupervisorPredioAdminController;
use App\Repositories\SupervisoresPredio\CadastroSupervisorPredioRepository;
use App\Repositories\ColaboradoresEleitorais\Contracts\CandidaturaColaboradorRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ColaboradorEleitoralEscalaRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ProcessoEleitoralRepositoryInterface;
use App\Services\ColaboradoresEleitorais\CandidaturaDecisaoService;
use App\Services\ColaboradoresEleitorais\ColaboradoresEleitoraisEscopoService;
use App\Services\EscopoUnidadeService;
use App\Support\EscopoUnidade;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralSupervisoresPredioEditarLocalControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function formulario_de_edicao_carrega_supervisor_e_opcoes_de_local(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar-local'],
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $repository = Mockery::mock(CadastroSupervisorPredioRepository::class);
        $repository->shouldReceive('buscarSupervisorParaAlteracao')->once()->with(63, [], true)->andReturn((object) [
            'id_supervisor_predio' => 63,
            'nome' => 'EDCLEY DA SILVA FIRMINO',
            'num_inscricao' => '002266412453',
            'num_zona' => '9',
            'localidade' => 'RIO BRANCO',
            'nom_local' => 'ESCOLA JOSE SALES DE ARAUJO',
            'num_local' => '1260',
            'localidade_voto' => 'RIO BRANCO',
            'nom_local_voto' => 'ESCOLA FRANCISCO AUGUSTO BACURAU',
            'num_local_voto' => '1222',
            'cod_objeto_local_votacao' => '100',
        ]);
        $repository->shouldReceive('listarMunicipiosLocais')->once()->with([], true)->andReturn(['CRUZEIRO DO SUL', 'RIO BRANCO']);
        $repository->shouldReceive('listarLocaisPorMunicipio')->once()->with('RIO BRANCO', [], true)->andReturn([
            ['id' => '100', 'text' => '9 - RIO BRANCO - ESCOLA JOSE SALES DE ARAUJO (1260)'],
        ]);
        $this->app->instance(CadastroSupervisorPredioRepository::class, $repository);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios/63/editar-local', 'GET');
        $route = Mockery::mock();
        $route->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar-local');
        $request->setRouteResolver(static fn () => $route);
        $this->app->instance('request', $request);

        $controller = $this->novoController();
        $view = $controller->editarLocal($request, 63);

        $this->assertInstanceOf(View::class, $view);
        $this->assertSame('colaboradores-eleitorais.externos.supervisores-predio.editar-local', $view->name());
        $dados = $view->getData();
        $this->assertSame('EDCLEY DA SILVA FIRMINO', $dados['supervisor']->nome);
        $this->assertSame(['CRUZEIRO DO SUL', 'RIO BRANCO'], $dados['municipiosDisponiveis']);
        $this->assertSame([['id' => '100', 'text' => '9 - RIO BRANCO - ESCOLA JOSE SALES DE ARAUJO (1260)']], $dados['locaisDisponiveis']);
        $this->assertSame(['municipio' => 'RIO BRANCO'], $dados['filtros']);
        $this->assertArrayNotHasKey('zonasDisponiveis', $dados);
    }


    #[Test]
    public function formulario_de_edicao_retorna_404_para_supervisor_fora_do_escopo_zonal(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar-local'],
            'cod_zonas_permitidas' => [9],
            'acesso_todas_zonas' => false,
        ]);
        $this->mockZonaPermitida(9, '9');

        $repository = Mockery::mock(CadastroSupervisorPredioRepository::class);
        $repository->shouldReceive('buscarSupervisorParaAlteracao')->once()->with(63, ['9'], false)->andReturnNull();
        $repository->shouldNotReceive('listarMunicipiosLocais');
        $repository->shouldNotReceive('listarLocaisPorMunicipio');
        $this->app->instance(CadastroSupervisorPredioRepository::class, $repository);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios/63/editar-local', 'GET');
        $route = Mockery::mock();
        $route->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar-local');
        $request->setRouteResolver(static fn () => $route);
        $this->app->instance('request', $request);

        $this->expectException(\Symfony\Component\HttpKernel\Exception\NotFoundHttpException::class);

        $this->novoController()->editarLocal($request, 63);
    }

    #[Test]
    public function atualizacao_de_local_chama_repositorio_auditado_e_redireciona_para_listagem(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios.atualizar-local'],
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $repository = Mockery::mock(CadastroSupervisorPredioRepository::class);
        $repository->shouldReceive('buscarSupervisorParaAlteracao')->once()->with(63, [], true)->andReturn((object) [
            'id_supervisor_predio' => 63,
            'cod_objeto_local_votacao' => '100',
        ]);
        $repository->shouldReceive('buscarLocalVotacaoPorCodigoNoEscopo')->once()->with('200', [], true)->andReturn((object) [
            'id' => '200',
            'texto' => '9 - RIO BRANCO - ESCOLA NOVA (2000)',
        ]);
        $repository->shouldReceive('atualizarLocalAtuacao')->once()->with(63, '200')->andReturn(1);
        $this->app->instance(CadastroSupervisorPredioRepository::class, $repository);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios/63/atualizar-local', 'POST', [
            'cod_objeto_local_votacao' => '200',
        ]);
        $request->setLaravelSession($this->app['session.store']);
        $request->headers->set('referer', '/origem');
        $request->setUserResolver(fn () => null);
        $route = Mockery::mock();
        $route->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.atualizar-local');
        $request->setRouteResolver(static fn () => $route);
        $this->app->instance('request', $request);

        $controller = $this->novoController();
        $response = $controller->atualizarLocal($request, 63);

        $this->assertInstanceOf(RedirectResponse::class, $response);
        $this->assertSame(route('colaboradores-eleitorais.externos.supervisores-predio-voluntarios'), $response->getTargetUrl());
        $this->assertSame('Local de atuação do supervisor atualizado com sucesso.', session('status'));
    }


    #[Test]
    public function atualizacao_de_local_retorna_404_para_supervisor_fora_do_escopo_zonal(): void
    {
        session()->put([
            'rotas_permitidas' => ['colaboradores-eleitorais.externos.supervisores-predio-voluntarios.atualizar-local'],
            'cod_zonas_permitidas' => [9],
            'acesso_todas_zonas' => false,
        ]);
        $this->mockZonaPermitida(9, '9');

        $repository = Mockery::mock(CadastroSupervisorPredioRepository::class);
        $repository->shouldReceive('buscarSupervisorParaAlteracao')->once()->with(63, ['9'], false)->andReturnNull();
        $repository->shouldNotReceive('buscarLocalVotacaoPorCodigoNoEscopo');
        $repository->shouldNotReceive('atualizarLocalAtuacao');
        $this->app->instance(CadastroSupervisorPredioRepository::class, $repository);

        $request = Request::create('/colaboradores-eleitorais/externos/supervisores-predio-voluntarios/63/atualizar-local', 'POST', [
            'cod_objeto_local_votacao' => '200',
        ]);
        $request->setLaravelSession($this->app['session.store']);
        $route = Mockery::mock();
        $route->shouldReceive('getName')->andReturn('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.atualizar-local');
        $request->setRouteResolver(static fn () => $route);
        $this->app->instance('request', $request);

        $this->expectException(\Symfony\Component\HttpKernel\Exception\NotFoundHttpException::class);

        $this->novoController()->atualizarLocal($request, 63);
    }

    private function novoController(): SupervisorPredioAdminController
    {
        return new SupervisorPredioAdminController(app(CadastroSupervisorPredioRepository::class));
    }


    private function mockZonaPermitida(int $zonaId, string $numZona): void
    {
        $zonaBuilder = Mockery::mock();
        $zonaBuilder->shouldReceive('selectRaw')->once()->with('TO_CHAR(num_zona) as num_zona')->andReturnSelf();
        $zonaBuilder->shouldReceive('whereIn')->once()->with('id', [$zonaId])->andReturnSelf();
        $zonaBuilder->shouldReceive('orWhereIn')->once()->with('num_zona', [$zonaId])->andReturnSelf();
        $zonaBuilder->shouldReceive('pluck')->once()->with('num_zona')->andReturn(collect([$numZona]));

        DB::shouldReceive('table')->once()->with('zona')->andReturn($zonaBuilder);
    }

}
```
</TESTS_UNIT_COLABORADORELEITORALSUPERVISORESPREDIOEDITARLOCALCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralVoluntariosExternosEventosFiltrosTest.php`
## <TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSFILTROSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralVoluntariosExternosEventosFiltrosTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosEventosFiltrosTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function plano_sem_eventos_marcados_mantem_todos_os_eventos_visiveis_do_plano(): void
public function multiselect_mantem_apenas_os_eventos_marcados_do_plano(): void
public function evento_fora_do_plano_ou_da_colecao_autorizada_falha_fechado(): void
public function evento_marcado_sem_plano_falha_fechado(): void
public function zona_de_trabalho_e_aceita_mesmo_sem_eventos_marcados(): void
public function payloads_aninhados_de_eventos_falham_fechado_sem_normalizacao_parcial(): void
private function eventosVisiveis(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\ColaboradoresEleitorais\EventoVoluntarioFiltros;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosEventosFiltrosTest extends TestCase
{
    #[Test]
    public function plano_sem_eventos_marcados_mantem_todos_os_eventos_visiveis_do_plano(): void
    {
        $resultado = EventoVoluntarioFiltros::resolverEventos(
            $this->eventosVisiveis(),
            321,
            []
        );

        $this->assertFalse($resultado['invalido']);
        $this->assertSame([], $resultado['evento_ids']);
        $this->assertSame([10, 11], array_column($resultado['eventos'], 'id'));
    }

    #[Test]
    public function multiselect_mantem_apenas_os_eventos_marcados_do_plano(): void
    {
        $resultado = EventoVoluntarioFiltros::resolverEventos(
            $this->eventosVisiveis(),
            321,
            ['11', 10, '11', '']
        );

        $this->assertFalse($resultado['invalido']);
        $this->assertSame([11, 10], $resultado['evento_ids']);
        $this->assertSame([10, 11], array_column($resultado['eventos'], 'id'));
    }

    #[Test]
    public function evento_fora_do_plano_ou_da_colecao_autorizada_falha_fechado(): void
    {
        $foraDoPlano = EventoVoluntarioFiltros::resolverEventos(
            $this->eventosVisiveis(),
            321,
            [10, 20]
        );
        $foraDoEscopo = EventoVoluntarioFiltros::resolverEventos(
            $this->eventosVisiveis(),
            321,
            [999]
        );

        $this->assertTrue($foraDoPlano['invalido']);
        $this->assertSame([], $foraDoPlano['eventos']);
        $this->assertTrue($foraDoEscopo['invalido']);
        $this->assertSame([], $foraDoEscopo['eventos']);
    }

    #[Test]
    public function evento_marcado_sem_plano_falha_fechado(): void
    {
        $resultado = EventoVoluntarioFiltros::resolverEventos(
            $this->eventosVisiveis(),
            0,
            [10]
        );

        $this->assertTrue($resultado['invalido']);
        $this->assertSame([], $resultado['eventos']);
    }

    #[Test]
    public function zona_de_trabalho_e_aceita_mesmo_sem_eventos_marcados(): void
    {
        $this->assertNull(EventoVoluntarioFiltros::normalizarZonaTrabalho(''));
        $this->assertSame(44, EventoVoluntarioFiltros::normalizarZonaTrabalho('44'));
        $this->assertSame(0, EventoVoluntarioFiltros::normalizarZonaTrabalho('indevida'));
        $this->assertSame(0, EventoVoluntarioFiltros::normalizarZonaTrabalho(['44']));
    }

    #[Test]
    public function payloads_aninhados_de_eventos_falham_fechado_sem_normalizacao_parcial(): void
    {
        $resultado = EventoVoluntarioFiltros::resolverEventos(
            $this->eventosVisiveis(),
            321,
            [['10'], '11']
        );

        $this->assertTrue($resultado['invalido']);
        $this->assertSame([], $resultado['eventos']);
    }

    #[Test]
    private function eventosVisiveis(): array
    {
        return [
            ['id' => 10, 'processo_eleitoral_id' => 321, 'nome' => 'Evento A'],
            ['id' => 11, 'processo_eleitoral_id' => 321, 'nome' => 'Evento B'],
            ['id' => 20, 'processo_eleitoral_id' => 442, 'nome' => 'Evento C'],
        ];
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSFILTROSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralVoluntariosExternosEventosPdfViewTest.php`
## <TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSPDFVIEWTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralVoluntariosExternosEventosPdfViewTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosEventosPdfViewTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function pdf_agrupa_eventos_por_acao_e_organiza_agendas_e_participantes(): void
public function pdf_repete_o_cabecalho_das_colunas_antes_de_cada_evento(): void
public function pdf_oculta_detalhes_nao_selecionados(): void
public function pdf_pagina_a_lista_completa_de_151_participantes(): void
public function pdf_sem_eventos_mantem_a_mensagem_de_resultado_vazio(): void
private function evento(int $id, int $processoId, string $processoNome, string $nome): array
private function colunasDisponiveis(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Barryvdh\DomPDF\Facade\Pdf;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosEventosPdfViewTest extends TestCase
{
    #[Test]
    public function pdf_agrupa_eventos_por_acao_e_organiza_agendas_e_participantes(): void
    {
        $eventos = [
            $this->evento(55, 321, 'Ação Capital', 'Treinamento Capital'),
            $this->evento(77, 322, 'Ação Interior', 'Orientação Interior'),
        ];

        $html = view('colaboradores-eleitorais.externos.voluntarios.eventos.pdf', [
            'eventos' => $eventos,
            'colunasSelecionadas' => [
                'processo_nome',
                'nome',
                'status_nome',
                'local',
                'atividade',
                'qtd_agendas',
                'agendas_resumo',
                'total_participantes',
                'participantes_resumo',
            ],
            'colunasDisponiveis' => $this->colunasDisponiveis(),
            'participantesPorEvento' => [
                55 => [[
                    'nome' => 'ANA TESTE',
                    'num_inscricao' => '000111222333',
                    'num_zona' => '9',
                    'num_zona_trabalho' => '1',
                ]],
                77 => [[
                    'nome' => 'BRUNO TESTE',
                    'num_inscricao' => '000222333444',
                    'num_zona' => '',
                ]],
            ],
            'titulo' => 'Eventos de voluntários externos',
        ])->render();

        $this->assertSame(1, substr_count($html, 'data-acao-trabalho="321"'));
        $this->assertSame(1, substr_count($html, 'data-acao-trabalho="322"'));
        $this->assertStringContainsString('page-break-before: always', $html);

        $this->assertStringContainsString('Data inicial', $html);
        $this->assertStringContainsString('Data final', $html);
        $this->assertStringContainsString('Hora inicial', $html);
        $this->assertStringContainsString('Hora final', $html);
        $this->assertStringContainsString('Agendas — Treinamento Capital', $html);
        $this->assertLessThan(strpos($html, 'Data final'), strpos($html, 'Data inicial'));
        $this->assertLessThan(strpos($html, 'Hora inicial'), strpos($html, 'Data final'));
        $this->assertLessThan(strpos($html, 'Hora final'), strpos($html, 'Hora inicial'));

        $this->assertStringContainsString('10/08/2026', $html);
        $this->assertStringContainsString('11/08/2026', $html);
        $this->assertStringContainsString('08:00', $html);
        $this->assertStringContainsString('18:00', $html);
        $this->assertStringContainsString('Zona onde Vota', $html);
        $this->assertStringContainsString('Zona onde irá trabalhar', $html);
        $this->assertStringContainsString('>9<', $html);
        $this->assertStringContainsString('>1<', $html);
        $this->assertStringContainsString('>—<', $html);
    }

    #[Test]
    public function pdf_repete_o_cabecalho_das_colunas_antes_de_cada_evento(): void
    {
        $eventos = [
            $this->evento(55, 321, 'Suporte Técnico - Capital', 'Capacitação Logística'),
            $this->evento(56, 321, 'Suporte Técnico - Capital', 'Treinamento Operacional'),
        ];

        $html = view('colaboradores-eleitorais.externos.voluntarios.eventos.pdf', [
            'eventos' => $eventos,
            'colunasSelecionadas' => [
                'processo_nome',
                'nome',
                'status_nome',
                'local',
                'atividade',
                'agendas_resumo',
                'participantes_resumo',
            ],
            'colunasDisponiveis' => $this->colunasDisponiveis(),
            'participantesPorEvento' => [
                55 => [[
                    'nome' => 'ANA ELEITORAL',
                    'num_inscricao' => '000111222333',
                    'num_zona' => '9',
                ]],
                56 => [[
                    'nome' => 'BRUNO ELEITORAL',
                    'num_inscricao' => '000222333444',
                    'num_zona' => '1',
                ]],
            ],
            'titulo' => 'Eventos de voluntários externos',
        ])->render();

        $cabecalho = '<th>Evento</th>';
        $primeiroCabecalho = strpos($html, $cabecalho);
        $primeiroEvento = strpos($html, 'Capacitação Logística');
        $primeiraAgenda = strpos($html, 'Agendas — Capacitação Logística');
        $primeirosParticipantes = strpos($html, 'Participantes — Capacitação Logística');
        $segundoCabecalho = $primeiroCabecalho !== false
            ? strpos($html, $cabecalho, $primeiroCabecalho + strlen($cabecalho))
            : false;
        $separadorEventos = strpos($html, 'class="evento-separator"');
        $segundoEvento = strpos($html, 'Treinamento Operacional');

        $this->assertSame(2, substr_count($html, $cabecalho));
        $this->assertSame(1, substr_count($html, 'class="evento-separator"'));
        $this->assertStringContainsString('height: 10px;', $html);
        $this->assertNotFalse($primeiroCabecalho);
        $this->assertNotFalse($primeiroEvento);
        $this->assertNotFalse($primeiraAgenda);
        $this->assertNotFalse($primeirosParticipantes);
        $this->assertNotFalse($separadorEventos);
        $this->assertNotFalse($segundoCabecalho);
        $this->assertNotFalse($segundoEvento);
        $this->assertTrue(
            $primeiroCabecalho < $primeiroEvento
            && $primeiroEvento < $primeiraAgenda
            && $primeiraAgenda < $primeirosParticipantes
            && $primeirosParticipantes < $separadorEventos
            && $separadorEventos < $segundoCabecalho
            && $segundoCabecalho < $segundoEvento
        );
    }

    #[Test]
    public function pdf_oculta_detalhes_nao_selecionados(): void
    {
        $html = view('colaboradores-eleitorais.externos.voluntarios.eventos.pdf', [
            'eventos' => [$this->evento(55, 321, 'Ação Capital', 'Treinamento Capital')],
            'colunasSelecionadas' => ['processo_nome', 'nome'],
            'colunasDisponiveis' => $this->colunasDisponiveis(),
            'participantesPorEvento' => [
                55 => [[
                    'nome' => 'ANA TESTE',
                    'num_inscricao' => '000111222333',
                    'num_zona' => '9',
                ]],
            ],
            'titulo' => 'Eventos de voluntários externos',
        ])->render();

        $this->assertStringNotContainsString('Data inicial', $html);
        $this->assertStringNotContainsString('Título eleitoral', $html);
        $this->assertStringNotContainsString('ANA TESTE', $html);
    }

    #[Test]
    public function pdf_pagina_a_lista_completa_de_151_participantes(): void
    {
        $participantes = collect(range(1, 151))
            ->map(static fn (int $numero): array => [
                'nome' => sprintf('PARTICIPANTE TESTE %03d', $numero),
                'num_inscricao' => str_pad((string) $numero, 12, '0', STR_PAD_LEFT),
                'num_zona' => '1',
                'num_zona_trabalho' => '1',
            ])
            ->all();

        $pdf = Pdf::loadView('colaboradores-eleitorais.externos.voluntarios.eventos.pdf', [
            'eventos' => [$this->evento(55, 321, 'Acao Capital', 'Treinamento Capital')],
            'colunasSelecionadas' => [
                'nome',
                'status_nome',
                'local',
                'atividade',
                'agendas_resumo',
                'total_participantes',
                'participantes_resumo',
            ],
            'colunasDisponiveis' => $this->colunasDisponiveis(),
            'participantesPorEvento' => [55 => $participantes],
            'titulo' => 'Eventos de voluntarios externos',
        ]);

        $pdf->render();

        $this->assertGreaterThanOrEqual(
            4,
            $pdf->getDomPDF()->getCanvas()->get_page_count(),
            'A tabela de participantes foi cortada em vez de continuar nas paginas seguintes.'
        );
    }

    #[Test]
    public function pdf_sem_eventos_mantem_a_mensagem_de_resultado_vazio(): void
    {
        $html = view('colaboradores-eleitorais.externos.voluntarios.eventos.pdf', [
            'eventos' => [],
            'colunasSelecionadas' => ['processo_nome', 'nome'],
            'colunasDisponiveis' => $this->colunasDisponiveis(),
            'participantesPorEvento' => [],
            'titulo' => 'Eventos de voluntários externos',
        ])->render();

        $this->assertStringContainsString('Nenhum evento encontrado para os filtros informados.', $html);
        $this->assertStringNotContainsString('data-acao-trabalho=', $html);
    }

    /** @return array<string, mixed> */
    private function evento(int $id, int $processoId, string $processoNome, string $nome): array
    {
        return [
            'id' => $id,
            'processo_eleitoral_id' => $processoId,
            'processo_nome' => $processoNome,
            'nome' => $nome,
            'status_nome' => 'Ativo',
            'local' => 'SEDE',
            'atividade' => 'Treinamento',
            'qtd_agendas' => 1,
            'agendas_resumo' => ['10/08/2026 08:00 até 11/08/2026 18:00'],
            'agendas' => [[
                'dt_inicio_formatado' => '10/08/2026 08:00',
                'dt_fim_formatado' => '11/08/2026 18:00',
            ]],
            'total_participantes' => 1,
        ];
    }

    /** @return array<string, string> */
    private function colunasDisponiveis(): array
    {
        return [
            'processo_nome' => 'Ação de trabalho',
            'nome' => 'Evento',
            'status_nome' => 'Status',
            'local' => 'Local',
            'atividade' => 'Atividade',
            'qtd_agendas' => 'Quantidade de agendas',
            'agendas_resumo' => 'Agendas',
            'total_participantes' => 'Participantes',
            'participantes_resumo' => 'Participantes',
        ];
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSPDFVIEWTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralVoluntariosExternosEventosSchemaMigrationTest.php`
## <TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSSCHEMAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralVoluntariosExternosEventosSchemaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosEventosSchemaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migrations_criam_status_evento_evento_agenda_e_participante(): void
public function migration_adiciona_zona_de_trabalho_opcional_ao_participante(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosEventosSchemaMigrationTest extends TestCase
{
    #[Test]
    public function migrations_criam_status_evento_evento_agenda_e_participante(): void
    {
        $status = file_get_contents(database_path('migrations/2026_06_07_180000_create_ce_evento_voluntario_status_table.php'));
        $evento = file_get_contents(database_path('migrations/2026_06_07_181000_create_ce_evento_voluntario_table.php'));
        $agenda = file_get_contents(database_path('migrations/2026_06_07_182000_create_ce_evento_voluntario_agenda_table.php'));
        $participante = file_get_contents(database_path('migrations/2026_06_07_183000_create_ce_evento_voluntario_participante_table.php'));

        $this->assertIsString($status);
        $this->assertStringContainsString('CREATE TABLE CE_EVENTO_VOLUNTARIO_STATUS', $status);
        $this->assertStringContainsString("'ATIVO'", $status);
        $this->assertStringContainsString("'DESATIVO'", $status);

        $this->assertIsString($evento);
        $this->assertStringContainsString('CREATE TABLE CE_EVENTO_VOLUNTARIO', $evento);
        $this->assertStringContainsString('PROCESSO_ELEITORAL_ID', $evento);
        $this->assertStringContainsString('STATUS_CODIGO', $evento);
        $this->assertStringContainsString('FK_CE_EVT_VOL_PROCESSO', $evento);
        $this->assertStringContainsString('FK_CE_EVT_VOL_STATUS', $evento);

        $this->assertIsString($agenda);
        $this->assertStringContainsString('CREATE TABLE CE_EVENTO_VOLUNTARIO_AGENDA', $agenda);
        $this->assertStringContainsString('DT_INICIO', $agenda);
        $this->assertStringContainsString('DT_FIM', $agenda);
        $this->assertStringContainsString('CK_CE_EVT_VOL_AGE_PERIODO', $agenda);

        $this->assertIsString($participante);
        $this->assertStringContainsString('CREATE TABLE CE_EVENTO_VOLUNTARIO_PARTICIPANTE', $participante);
        $this->assertStringContainsString('NUM_INSCRICAO', $participante);
        $this->assertStringContainsString('UX_CE_EVT_VOL_PART_01', $participante);
    }

    #[Test]
    public function migration_adiciona_zona_de_trabalho_opcional_ao_participante(): void
    {
        $conteudo = file_get_contents(database_path(
            'migrations/2026_07_31_190000_add_zona_trabalho_to_ce_evento_voluntario_participante.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ZONA_TRABALHO_ID', $conteudo);
        $this->assertStringContainsString('FK_CE_EVT_VOL_PART_ZONA', $conteudo);
        $this->assertStringContainsString('IX_CE_EVT_VOL_PART_03', $conteudo);
        $this->assertStringContainsString('REFERENCES ZONA(ID)', $conteudo);
        $this->assertStringContainsString('DROP COLUMN ZONA_TRABALHO_ID', $conteudo);
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSEVENTOSSCHEMAMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralVoluntariosExternosMenuTest.php`
## <TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSMENUTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralVoluntariosExternosMenuTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosMenuTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_de_colaboradores_externos_possui_acesso_direto_a_eventos(): void
public function permissao_de_eventos_exibe_somente_o_item_direto_desse_fluxo(): void
public function catalogo_separa_o_caminho_de_eventos_do_caminho_de_voluntarios(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\MenuCatalogService;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosMenuTest extends TestCase
{
    #[Test]
    public function menu_de_colaboradores_externos_possui_acesso_direto_a_eventos(): void
    {
        $itens = collect(config('planeleito_menu.colaboradores_eleitorais.sections.externos.items'));
        $eventos = $itens->firstWhere(
            'route',
            'colaboradores-eleitorais.externos.voluntarios.eventos.index'
        );

        $this->assertIsArray($eventos);
        $this->assertSame('Eventos', $eventos['label']);
        $this->assertSame(
            ['colaboradores-eleitorais.externos.voluntarios.eventos.*'],
            $eventos['route_patterns']
        );
        $this->assertSame(
            'Colaboradores Eleitorais > Colaboradores Externos > Eventos',
            $eventos['menu_path']
        );
    }

    #[Test]
    public function permissao_de_eventos_exibe_somente_o_item_direto_desse_fluxo(): void
    {
        $menu = app(MenuCatalogService::class)->buildForLayout([
            'colaboradores-eleitorais.externos.voluntarios.eventos.index',
        ]);
        $externos = collect($menu['colaboradores_eleitorais']['secoes'])
            ->firstWhere('titulo', 'Colaboradores Externos');

        $this->assertIsArray($externos);
        $this->assertSame(['Eventos'], array_column($externos['itens'], 'label'));
        $this->assertSame(
            route('colaboradores-eleitorais.externos.voluntarios.eventos.index'),
            $externos['itens'][0]['href']
        );
    }

    #[Test]
    public function catalogo_separa_o_caminho_de_eventos_do_caminho_de_voluntarios(): void
    {
        $catalogo = app(MenuCatalogService::class);

        $this->assertSame(
            'Colaboradores Eleitorais > Colaboradores Externos > Eventos',
            $catalogo->menuPathForRoute('colaboradores-eleitorais.externos.voluntarios.eventos.index')
        );
        $this->assertSame(
            'Colaboradores Eleitorais > Colaboradores Externos > Eventos',
            $catalogo->menuPathForRoute('colaboradores-eleitorais.externos.voluntarios.eventos.editar')
        );
        $this->assertSame(
            'Colaboradores Eleitorais > Colaboradores Externos > Voluntários Externos',
            $catalogo->menuPathForRoute('colaboradores-eleitorais.externos.voluntarios')
        );

        foreach ([
            'colaboradores-eleitorais.externos.voluntarios.exportar',
            'colaboradores-eleitorais.externos.voluntarios.pdf.download',
            'colaboradores-eleitorais.externos.voluntarios.excluidos.exportar-pdf',
            'colaboradores-eleitorais.externos.voluntarios.confirmar-email',
            'colaboradores-eleitorais.externos.voluntarios.funcoes.inativar',
        ] as $rotaVoluntarios) {
            $this->assertSame(
                'Colaboradores Eleitorais > Colaboradores Externos > Voluntários Externos',
                $catalogo->menuPathForRoute($rotaVoluntarios),
                "A rota {$rotaVoluntarios} deve permanecer no menu de voluntários externos."
            );
        }
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSMENUTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ColaboradorEleitoralVoluntariosExternosUiTest.php`
## <TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ColaboradorEleitoralVoluntariosExternosUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ColaboradorEleitoralVoluntariosExternosUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_voluntarios_externos_exibe_fluxo_de_eventos_e_filtro_de_selecao(): void
public function tela_oferece_busca_nominal_inicial_e_busca_global_compativel(): void
public function tela_de_voluntarios_externos_exibe_local_de_voto_na_coluna_e_no_detalhe(): void
public function tela_exibe_filtro_e_alocacao_de_rota_na_coluna_e_no_detalhe(): void
public function tela_exibe_badges_amarelos_para_os_tres_status_do_elo_e_omite_quando_sem_situacao(): void
public function tela_exibe_filtro_da_situacao_do_elo_e_o_propaga_para_exportacoes(): void
public function modal_de_exportacao_seleciona_situacao_do_elo_por_padrao(): void
public function tela_exibe_relatorio_de_eventos_em_nova_aba_com_os_filtros_ativos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ColaboradorEleitoralVoluntariosExternosUiTest extends TestCase
{
    #[Test]
    public function tela_de_voluntarios_externos_exibe_fluxo_de_eventos_e_filtro_de_selecao(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="selecao"', $conteudo);
        $this->assertStringContainsString('Somente selecionados', $conteudo);
        preg_match('~<select[^>]+id="filtroZonaVoluntario"[^>]*>~', $conteudo, $matchZona);
        $selectZona = $matchZona[0] ?? '';
        $this->assertStringContainsString('name="zona[]"', $selectZona);
        $this->assertStringContainsString('multiple', $selectZona);
        $this->assertStringContainsString('class="form-select form-select-sm select2"', $selectZona);
        $this->assertStringContainsString('data-placeholder="Todas"', $selectZona);
        $this->assertStringNotContainsString('size="4"', $selectZona);
        $this->assertStringContainsString('closeOnSelect: false', $conteudo);
        $this->assertStringContainsString('Gerenciar eventos', $conteudo);
        $this->assertStringContainsString('Vincular selecionados ao evento', $conteudo);
        $this->assertStringContainsString('Desvincular selecionados do evento', $conteudo);
        $this->assertStringContainsString('modalVincularEventoVoluntario', $conteudo);
        $this->assertStringContainsString('Eventos vinculados', $conteudo);
        $this->assertStringContainsString('Resumo da filtragem', $conteudo);
        $this->assertStringContainsString('id="btnToggleResumoVoluntarios"', $conteudo);
        $this->assertStringContainsString('data-bs-toggle="collapse"', $conteudo);
        $this->assertStringContainsString('data-bs-target="#collapseResumoVoluntarios"', $conteudo);
        $this->assertStringContainsString('id="collapseResumoVoluntarios"', $conteudo);
        $this->assertStringContainsString('class="collapse show"', $conteudo);
        $this->assertStringContainsString('Recolher resumo', $conteudo);
        $this->assertStringContainsString('Expandir resumo', $conteudo);
        $this->assertStringContainsString('Camisas por tamanho', $conteudo);
        $this->assertStringContainsString('Voluntarios por zona', $conteudo);
        $this->assertStringContainsString('Voluntarios por municipio', $conteudo);
        $this->assertStringContainsString("\$itemResumo['label']", $conteudo);
        $this->assertStringContainsString('<strong>Tamanho da Camisa:</strong>', $conteudo);
    }

    #[Test]
    public function tela_oferece_busca_nominal_inicial_e_busca_global_compativel(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="modo_busca"', $conteudo);
        $this->assertStringContainsString('value="nome"', $conteudo);
        $this->assertStringContainsString('>Nome<', preg_replace('/\s+/', '', $conteudo));
        $this->assertStringContainsString('value="global"', $conteudo);
        $this->assertStringContainsString('>Global<', preg_replace('/\s+/', '', $conteudo));
    }

    #[Test]
    public function tela_de_voluntarios_externos_exibe_local_de_voto_na_coluna_e_no_detalhe(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);

        // coluna consolidada e detalhe expandido apresentam o local de voto
        $this->assertStringContainsString('Vota no local', $conteudo);
        $this->assertStringContainsString('$normalizarTexto($item->nom_local_voto', $conteudo);
        $this->assertStringContainsString('$item->num_local_voto', $conteudo);

        // campo disponivel no modal de exportacao, selecionado por padrao
        $this->assertStringContainsString("'local_voto' => 'Local de Votação'", $conteudo);
        $this->assertStringContainsString("'local_voto'", $conteudo);
    }

    #[Test]
    public function tela_exibe_filtro_e_alocacao_de_rota_na_coluna_e_no_detalhe(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);

        // filtro visual de alocacao em rota
        $this->assertStringContainsString('name="alocacao_rota"', $conteudo);
        $this->assertStringContainsString('Alocação em rota', $conteudo);
        $this->assertStringContainsString('value="alocados"', $conteudo);
        $this->assertStringContainsString('value="nao_alocados"', $conteudo);

        // alocacoes na coluna consolidada e no detalhe expandido
        $this->assertStringContainsString('rotas_alocadas', $conteudo);
        $this->assertStringContainsString('{{ $rota }}', $conteudo);
        $this->assertStringContainsString('Não alocado', $conteudo);
    }

    #[Test]
    public function tela_exibe_badges_amarelos_para_os_tres_status_do_elo_e_omite_quando_sem_situacao(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString(
            "\$situacaoMesarioElo = trim((string) (\$item->situacao_mesario_elo ?? ''));",
            $conteudo
        );
        $this->assertStringContainsString(
            "trim((string) (\$item->funcoes_mesario_elo ?? ''))",
            $conteudo
        );
        $this->assertStringContainsString("implode(' • ', \$funcoesMesarioElo)", $conteudo);
        $this->assertStringContainsString(
            '$hintFuncaoMesarioElo = $funcoesMesarioElo !== []',
            $conteudo
        );
        $this->assertStringContainsString("'Função não informada pelo ELO'", $conteudo);
        $this->assertStringContainsString("@if(\$situacaoMesarioElo !== '')", $conteudo);
        $this->assertStringContainsString('class="ms-2 badge text-bg-warning text-dark"', $conteudo);
        $this->assertStringContainsString('title="{{ $hintFuncaoMesarioElo }}"', $conteudo);
        $this->assertStringContainsString(
            'aria-label="{{ $situacaoMesarioElo }} na convocação de mesários do ELO. Função: {{ $hintFuncaoMesarioElo }}"',
            $conteudo
        );
        $this->assertStringContainsString('{{ $situacaoMesarioElo }}', $conteudo);
    }

    #[Test]
    public function tela_exibe_filtro_da_situacao_do_elo_e_o_propaga_para_exportacoes(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="situacao_elo"', $conteudo);
        $this->assertStringContainsString('Situação no ELO', $conteudo);
        $this->assertStringContainsString('value="convocados_atribuidos"', $conteudo);
        $this->assertStringContainsString('Convocado, atribuído ou nomeado', $conteudo);
        $this->assertStringContainsString('value="nao_convocados"', $conteudo);
        $this->assertStringContainsString('Sem situação reconhecida', $conteudo);
        $this->assertStringContainsString("situacao_elo: @json(\$filtros['situacao_elo'] ?? ''),", $conteudo);
    }

    #[Test]
    public function modal_de_exportacao_seleciona_situacao_do_elo_por_padrao(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'situacao_mesario_elo' => 'Situação no ELO'", $conteudo);
        $this->assertMatchesRegularExpression(
            "/\\\$colunasPadraoExportacao\\s*=\\s*\\[[^]]*'situacao_mesario_elo'/s",
            $conteudo
        );
    }

    #[Test]
    public function tela_exibe_relatorio_de_eventos_em_nova_aba_com_os_filtros_ativos(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Relatório de eventos', $conteudo);
        $this->assertStringContainsString('fa-file-pdf', $conteudo);
        $this->assertStringContainsString(
            "route('colaboradores-eleitorais.externos.voluntarios.relatorio-eventos.pdf', request()->query())",
            $conteudo
        );
        $this->assertStringContainsString('target="_blank"', $conteudo);
        $this->assertStringContainsString('rel="noopener"', $conteudo);
    }
}
```
</TESTS_UNIT_COLABORADORELEITORALVOLUNTARIOSEXTERNOSUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MacroprojetoPermissoesTest.php`
## <TESTS_UNIT_MACROPROJETOPERMISSOESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MacroprojetoPermissoesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MacroprojetoPermissoesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_usuario_nao_e_admin_do_macro_sem_macroprojeto_ativo(): void
public function test_autorizar_admin_bloqueia_quando_usuario_nao_pode_operar_macro(): void
public function test_listar_macroprojetos_administraveis_filtra_sessao_pela_permissao_de_operacao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Planejamento\MacroprojetoPermissoes;
use App\Services\PermissaoDominioService;
use Mockery;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class MacroprojetoPermissoesTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_usuario_nao_e_admin_do_macro_sem_macroprojeto_ativo(): void
    {
        $service = new MacroprojetoPermissoes(Mockery::mock(PermissaoDominioService::class));

        $this->assertFalse($service->usuarioEhAdminDoMacroprojeto());
    }

    public function test_autorizar_admin_bloqueia_quando_usuario_nao_pode_operar_macro(): void
    {
        session([
            'macroprojeto_ativo_id' => 7,
            'matchingGroups' => ['GRUPO_X'],
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(7, ['GRUPO_X'])
            ->andReturnFalse();

        $service = new MacroprojetoPermissoes($permissao);

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Operação permitida apenas para administradores do macroprojeto ativo.');

        $service->autorizarAdmin();
    }

    public function test_listar_macroprojetos_administraveis_filtra_sessao_pela_permissao_de_operacao(): void
    {
        session([
            'matchingGroups' => ['GRUPO_X'],
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro A'],
                ['id' => 8, 'nome' => 'Macro B'],
                ['id' => 0, 'nome' => 'Inválido'],
            ],
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')->once()->with(7, ['GRUPO_X'])->andReturnTrue();
        $permissao->shouldReceive('podeOperarMacro')->once()->with(8, ['GRUPO_X'])->andReturnFalse();

        $service = new MacroprojetoPermissoes($permissao);

        $resultado = $service->listarMacroprojetosAdministraveis();

        $this->assertCount(1, $resultado);
        $this->assertSame(7, $resultado[0]->id);
        $this->assertSame('Macro A', $resultado[0]->nome);
    }
}
```
</TESTS_UNIT_MACROPROJETOPERMISSOESTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MacroprojetoTurnoControllerTest.php`
## <TESTS_UNIT_MACROPROJETOTURNOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MacroprojetoTurnoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MacroprojetoTurnoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_turnos_ordenados(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
public function test_store_desativa_turnos_ativos_anteriores_quando_novo_turno_ativo_e_salvo(): void
public function test_store_forca_primeiro_turno_como_ativo_quando_macroprojeto_ainda_nao_tem_um_ativo(): void
public function test_update_desativa_outros_turnos_do_mesmo_macroprojeto_quando_registro_e_salvo_como_ativo(): void
public function test_destroy_bloqueia_exclusao_do_unico_turno_ativo_do_macroprojeto(): void
public function test_destroy_remove_registro_quando_ha_outro_turno_ativo_no_mesmo_macroprojeto(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Planejamento\MacroprojetoTurnoController;
use App\Http\Requests\Planejamento\MacroprojetoTurnoRequest;
use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class MacroprojetoTurnoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_turnos_ordenados(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'macroprojeto_nome' => 'Macro A', 'turno' => '1', 'descricao' => '1o turno', 'ativo' => 1]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/macroprojeto-turnos']
        );

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('listar')->once()->with(null, null, null)->andReturn($paginator);

        $controller = new MacroprojetoTurnoController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/macroprojeto-turnos', 'GET'));

        $this->assertSame('tabelas-auxiliares.macroprojeto-turnos.index', $response->name());
        $this->assertCount(1, $response->getData()['turnos']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        session([
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
            ],
        ]);

        $registro = (object) ['id' => 7, 'macroprojeto_id' => 7, 'turno' => '2', 'descricao' => '2o turno', 'ativo' => 1];
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscar')->once()->with(7)->andReturn($registro);

        $controller = Mockery::mock(MacroprojetoTurnoController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(7);

        $this->assertSame('tabelas-auxiliares.macroprojeto-turnos.form', $response->name());
        $this->assertSame($registro, $response->getData()['turnoRegistro']);
    }

    public function test_store_desativa_turnos_ativos_anteriores_quando_novo_turno_ativo_e_salvo(): void
    {
        $dados = [
            'macroprojeto_id' => 7,
            'turno' => '2',
            'descricao' => '2o turno',
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-25',
            'ativo' => true,
        ];

        $request = Mockery::mock(MacroprojetoTurnoRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dados);

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('desativarAtivosDoMacroprojeto')->once()->with(7);
        $repository->shouldReceive('criar')->once()->with($dados);

        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $controller = Mockery::mock(MacroprojetoTurnoController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->store($request);

        $this->assertSame(route('tabelas-auxiliares.macroprojeto-turnos.index'), $response->getTargetUrl());
        $this->assertSame('Turno do macroprojeto criado com sucesso!', session('status'));
    }

    public function test_store_forca_primeiro_turno_como_ativo_quando_macroprojeto_ainda_nao_tem_um_ativo(): void
    {
        $dadosValidados = [
            'macroprojeto_id' => 7,
            'turno' => '1',
            'descricao' => '1o turno',
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
            'ativo' => false,
        ];

        $request = Mockery::mock(MacroprojetoTurnoRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dadosValidados);

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('existeAtivoPorMacroprojeto')->once()->with(7)->andReturn(false);
        $repository->shouldReceive('criar')->once()->with([
            'macroprojeto_id' => 7,
            'turno' => '1',
            'descricao' => '1o turno',
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
            'ativo' => true,
        ]);

        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $controller = Mockery::mock(MacroprojetoTurnoController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->store($request);

        $this->assertSame(route('tabelas-auxiliares.macroprojeto-turnos.index'), $response->getTargetUrl());
    }

    public function test_update_desativa_outros_turnos_do_mesmo_macroprojeto_quando_registro_e_salvo_como_ativo(): void
    {
        $registro = (object) ['id' => 9, 'macroprojeto_id' => 7, 'turno' => '1', 'descricao' => '1o turno', 'ativo' => 0];
        $dados = [
            'macroprojeto_id' => 7,
            'turno' => '2',
            'descricao' => '2o turno',
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-25',
            'ativo' => true,
        ];

        $request = Mockery::mock(MacroprojetoTurnoRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dados);

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscar')->once()->with(9)->andReturn($registro);
        $repository->shouldReceive('desativarAtivosDoMacroprojeto')->once()->with(7, 9);
        $repository->shouldReceive('atualizar')->once()->with(9, $dados);

        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $controller = Mockery::mock(MacroprojetoTurnoController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->update($request, 9);

        $this->assertSame(route('tabelas-auxiliares.macroprojeto-turnos.index'), $response->getTargetUrl());
        $this->assertSame('Turno do macroprojeto atualizado com sucesso!', session('status'));
    }

    public function test_destroy_bloqueia_exclusao_do_unico_turno_ativo_do_macroprojeto(): void
    {
        $registro = (object) ['id' => 9, 'macroprojeto_id' => 7, 'ativo' => 1];

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscar')->once()->with(9)->andReturn($registro);
        $repository->shouldReceive('existeAtivoPorMacroprojeto')->once()->with(7, 9)->andReturn(false);
        $repository->shouldNotReceive('remover');

        $controller = Mockery::mock(MacroprojetoTurnoController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->destroy(Request::create('/tabelas-auxiliares/macroprojeto-turnos/9', 'DELETE'), 9);

        $this->assertSame(route('tabelas-auxiliares.macroprojeto-turnos.index'), $response->getTargetUrl());
        $this->assertSame('Não é permitido excluir o único turno ativo do macroprojeto.', session('errors')->first('turno'));
    }

    public function test_destroy_remove_registro_quando_ha_outro_turno_ativo_no_mesmo_macroprojeto(): void
    {
        $registro = (object) ['id' => 9, 'macroprojeto_id' => 7, 'ativo' => 1];

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscar')->once()->with(9)->andReturn($registro);
        $repository->shouldReceive('existeAtivoPorMacroprojeto')->once()->with(7, 9)->andReturn(true);
        $repository->shouldReceive('remover')->once()->with(9);

        $controller = Mockery::mock(MacroprojetoTurnoController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->destroy(Request::create('/tabelas-auxiliares/macroprojeto-turnos/9', 'DELETE'), 9);

        $this->assertSame(route('tabelas-auxiliares.macroprojeto-turnos.index'), $response->getTargetUrl());
        $this->assertSame('Turno do macroprojeto excluído com sucesso!', session('status'));
    }
}
```
</TESTS_UNIT_MACROPROJETOTURNOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MacroprojetoTurnoDataEleicaoServiceTest.php`
## <TESTS_UNIT_MACROPROJETOTURNODATAELEICAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MacroprojetoTurnoDataEleicaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MacroprojetoTurnoDataEleicaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_resolve_data_exata_do_turno_ativo(): void
public function test_falha_fechado_sem_contexto_turno_ou_data_valida(): void
public function test_resolve_data_do_turno_eleitoral_publico_sem_sessao(): void
public function test_data_eleitoral_publica_invalida_falha_fechada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use App\Services\Planejamento\MacroprojetoTurnoDataEleicaoService;
use Mockery;
use Tests\TestCase;

class MacroprojetoTurnoDataEleicaoServiceTest extends TestCase
{
    public function test_resolve_data_exata_do_turno_ativo(): void
    {
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(7)->andReturn([
            'dt_eleicao' => '2026-10-04',
        ]);

        $this->assertSame(
            '2026-10-04',
            (new MacroprojetoTurnoDataEleicaoService($repository))->resolver(7)
        );
    }

    public function test_falha_fechado_sem_contexto_turno_ou_data_valida(): void
    {
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(7)->andReturn([
            'dt_eleicao' => 'data-invalida',
        ]);

        $service = new MacroprojetoTurnoDataEleicaoService($repository);

        $this->assertNull($service->resolver(0));
        $this->assertNull($service->resolver(7));
    }

    public function test_resolve_data_do_turno_eleitoral_publico_sem_sessao(): void
    {
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoEleitoralPublico')->once()->andReturn([
            'dt_eleicao' => '2026-10-04',
        ]);

        $this->assertSame(
            '2026-10-04',
            (new MacroprojetoTurnoDataEleicaoService($repository))->resolverPublica()
        );
    }

    public function test_data_eleitoral_publica_invalida_falha_fechada(): void
    {
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoEleitoralPublico')->once()->andReturn([
            'dt_eleicao' => '2026-02-30',
        ]);

        $this->assertNull(
            (new MacroprojetoTurnoDataEleicaoService($repository))->resolverPublica()
        );
    }
}
```
</TESTS_UNIT_MACROPROJETOTURNODATAELEICAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MacroprojetoTurnoMigrationTest.php`
## <TESTS_UNIT_MACROPROJETOTURNOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MacroprojetoTurnoMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MacroprojetoTurnoMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_de_contexto_de_turno_por_macroprojeto_com_dois_turnos_e_unico_ativo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class MacroprojetoTurnoMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_de_contexto_de_turno_por_macroprojeto_com_dois_turnos_e_unico_ativo(): void
    {
        $arquivo = database_path('migrations/2026_06_20_230000_create_macroprojeto_turno_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('CREATE TABLE macroprojeto_turno', $conteudo);
        $this->assertStringContainsString('macroprojeto_id   NUMBER NOT NULL', $conteudo);
        $this->assertStringContainsString('turno             VARCHAR2(10 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('descricao         VARCHAR2(160 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('ativo             NUMBER(1) DEFAULT 0 NOT NULL', $conteudo);
        $this->assertStringContainsString('FOREIGN KEY (macroprojeto_id) REFERENCES macroprojeto (id)', $conteudo);
        $this->assertStringContainsString('CHECK (ativo IN (0, 1))', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_macroprojeto_turno_01 ON macroprojeto_turno (macroprojeto_id, UPPER(turno))', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_macroprojeto_turno_ativo_01 ON macroprojeto_turno (CASE WHEN ativo = 1 THEN macroprojeto_id END)', $conteudo);
        $this->assertStringContainsString("SELECT id, '1', '1o turno', 1, SYSDATE", $conteudo);
        $this->assertStringContainsString("SELECT id, '2', '2o turno', 0, SYSDATE", $conteudo);
        $this->assertStringContainsString('DROP TABLE macroprojeto_turno', $conteudo);
    }
}
```
</TESTS_UNIT_MACROPROJETOTURNOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MacroprojetoTurnoUiTest.php`
## <TESTS_UNIT_MACROPROJETOTURNOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MacroprojetoTurnoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MacroprojetoTurnoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_admin_global_expoe_item_de_turnos_por_macroprojeto_em_tabelas_auxiliares(): void
public function index_e_formulario_do_crud_expoem_macroprojeto_turno_descricao_e_ativo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class MacroprojetoTurnoUiTest extends TestCase
{
    #[Test]
    public function menu_admin_global_expoe_item_de_turnos_por_macroprojeto_em_tabelas_auxiliares(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Turnos por Macroprojeto'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.macroprojeto-turnos.index'", $conteudo);
        $this->assertStringContainsString("'route_patterns' => ['tabelas-auxiliares.macroprojeto-turnos.*']", $conteudo);
    }

    #[Test]
    public function index_e_formulario_do_crud_expoem_macroprojeto_turno_descricao_e_ativo(): void
    {
        $index = file_get_contents(resource_path('views/tabelas-auxiliares/macroprojeto-turnos/index.blade.php'));
        $form = file_get_contents(resource_path('views/tabelas-auxiliares/macroprojeto-turnos/form.blade.php'));

        $this->assertIsString($index);
        $this->assertIsString($form);

        $this->assertStringContainsString('Turnos por Macroprojeto', $index);
        $this->assertStringContainsString('Macroprojeto', $index);
        $this->assertStringContainsString('Turno', $index);
        $this->assertStringContainsString('Ativo', $index);
        $this->assertStringContainsString("route('tabelas-auxiliares.macroprojeto-turnos.form')", $index);

        $this->assertStringContainsString('macroprojeto_id', $form);
        $this->assertStringContainsString('turno', $form);
        $this->assertStringContainsString('descricao', $form);
        $this->assertStringContainsString('cod_pleito', $form);
        $this->assertStringContainsString('dt_eleicao', $form);
        $this->assertStringContainsString('ativo', $form);
    }
}
```
</TESTS_UNIT_MACROPROJETOTURNOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/PlanejamentoPermissoesTest.php`
## <TESTS_UNIT_PLANEJAMENTOPERMISSOESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/PlanejamentoPermissoesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class PlanejamentoPermissoesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_autorizar_admin_bloqueia_quando_usuario_nao_e_admin(): void
public function test_validar_permissao_tarefa_ignora_escopo_quando_unidades_permitidas_nao_e_array(): void
public function test_validar_permissao_tarefa_autoriza_quando_ha_intersecao_com_retorno_array(): void
public function test_validar_permissao_tarefa_autoriza_quando_unidade_informada_ja_esta_no_escopo(): void
public function test_validar_permissao_tarefa_bloqueia_quando_nao_ha_intersecao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Planejamento\PlanejamentoPermissoes;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class PlanejamentoPermissoesTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_autorizar_admin_bloqueia_quando_usuario_nao_e_admin(): void
    {
        session(['is_admin' => false]);

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Operação permitida apenas para administradores!');

        app(PlanejamentoPermissoes::class)->autorizarAdmin();
    }

    public function test_validar_permissao_tarefa_ignora_escopo_quando_unidades_permitidas_nao_e_array(): void
    {
        $executou = false;

        app(PlanejamentoPermissoes::class)->validarPermissaoTarefa(
            15,
            null,
            null,
            function () use (&$executou) {
                $executou = true;
                return 10;
            }
        );

        $this->assertFalse($executou);
    }

    public function test_validar_permissao_tarefa_autoriza_quando_ha_intersecao_com_retorno_array(): void
    {
        app(PlanejamentoPermissoes::class)->validarPermissaoTarefa(
            15,
            null,
            [20, 30],
            static fn () => [
                'tarefa_unidade_id' => 10,
                'subprojeto_unidade_id' => 20,
                'projeto_unidade_id' => 99,
            ]
        );

        $this->assertTrue(true);
    }

    public function test_validar_permissao_tarefa_autoriza_quando_unidade_informada_ja_esta_no_escopo(): void
    {
        app(PlanejamentoPermissoes::class)->validarPermissaoTarefa(
            15,
            55,
            [55],
            static fn () => null
        );

        $this->assertTrue(true);
    }

    public function test_validar_permissao_tarefa_bloqueia_quando_nao_ha_intersecao(): void
    {
        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Atividade não disponível para sua unidade.');

        app(PlanejamentoPermissoes::class)->validarPermissaoTarefa(
            15,
            null,
            [20, 30],
            static fn () => (object) [
                'unidade_id' => 99,
                'subprojeto_unidade_id' => 100,
            ]
        );
    }
}
```
</TESTS_UNIT_PLANEJAMENTOPERMISSOESTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ProcessoEleitoralRepositoryTest.php`
## <TESTS_UNIT_PROCESSOELEITORALREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ProcessoEleitoralRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ProcessoEleitoralRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_listar_unidades_por_escopo_delega_para_service(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\ProcessoEleitoralRepository;
use App\Services\ColaboradoresEleitorais\ColaboradoresEleitoraisEscopoService;
use Mockery;
use Tests\TestCase;

class ProcessoEleitoralRepositoryTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_listar_unidades_por_escopo_delega_para_service(): void
    {
        $escopo = Mockery::mock(ColaboradoresEleitoraisEscopoService::class);
        $escopo->shouldReceive('listarUnidadesGerentes')
            ->once()
            ->with([10], false)
            ->andReturn([(object) ['id' => 10]]);

        $repository = new ProcessoEleitoralRepository($escopo, app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertCount(1, $repository->listarUnidadesPorEscopo([10], false));
    }

}
```
</TESTS_UNIT_PROCESSOELEITORALREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ProjetoControllerPermissoesTest.php`
## <TESTS_UNIT_PROJETOCONTROLLERPERMISSOESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ProjetoControllerPermissoesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ProjetoControllerPermissoesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_listar_bloqueia_quando_nao_ha_macroprojeto_autorizado_para_a_rota(): void
public function test_listar_bloqueia_quando_macroprojeto_solicitado_nao_esta_autorizado(): void
public function test_listar_delega_para_repositorio_com_macroprojeto_e_unidades_do_escopo(): void
private function registrarRequestAtual(string $rota, array $query = []): Request
public function __construct(private readonly string $rota)
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Planejamento\ProjetoController;
use App\Repositories\Planejamento\Contracts\ProjetoRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\Planejamento\MacroprojetoPermissoes;
use App\Services\PermissaoDominioService;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class ProjetoControllerPermissoesTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_listar_bloqueia_quando_nao_ha_macroprojeto_autorizado_para_a_rota(): void
    {
        session([
            'matchingGroups' => ['GRUPO_X'],
            'macroprojeto_ativo_id' => 7,
        ]);

        $repository = Mockery::mock(ProjetoRepositoryInterface::class);
        $macroPermissoes = Mockery::mock(MacroprojetoPermissoes::class);
        $macroPermissoes->shouldReceive('listarMacroprojetosAdministraveis')
            ->once()
            ->andReturn([
                (object) ['id' => 7, 'nome' => 'Macro A'],
            ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeExecutar')
            ->once()
            ->with('planejamento.projetos.listar', 7, ['GRUPO_X'])
            ->andReturnFalse();

        $escopo = Mockery::mock(EscopoUnidadeService::class);

        $controller = new ProjetoController($repository, $macroPermissoes, $permissao, $escopo);
        $request = $this->registrarRequestAtual('planejamento.projetos.listar', ['busca' => 'abc']);

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Nenhum macroprojeto autorizado para este grupo.');

        $controller->listar($request);
    }

    public function test_listar_bloqueia_quando_macroprojeto_solicitado_nao_esta_autorizado(): void
    {
        session([
            'matchingGroups' => ['GRUPO_X'],
            'macroprojeto_ativo_id' => 7,
        ]);

        $repository = Mockery::mock(ProjetoRepositoryInterface::class);
        $macroPermissoes = Mockery::mock(MacroprojetoPermissoes::class);
        $macroPermissoes->shouldReceive('listarMacroprojetosAdministraveis')
            ->once()
            ->andReturn([
                (object) ['id' => 7, 'nome' => 'Macro A'],
            ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeExecutar')
            ->once()
            ->with('planejamento.projetos.listar', 7, ['GRUPO_X'])
            ->andReturnTrue();

        $escopo = Mockery::mock(EscopoUnidadeService::class);

        $controller = new ProjetoController($repository, $macroPermissoes, $permissao, $escopo);
        $request = $this->registrarRequestAtual('planejamento.projetos.listar', [
            'busca' => 'abc',
            'macroprojeto_id' => 99,
        ]);

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Macroprojeto não autorizado para este grupo.');

        $controller->listar($request);
    }

    public function test_listar_delega_para_repositorio_com_macroprojeto_e_unidades_do_escopo(): void
    {
        session([
            'matchingGroups' => ['GRUPO_X'],
            'macroprojeto_ativo_id' => 7,
        ]);

        $paginator = new LengthAwarePaginator([], 0, 10);

        $repository = Mockery::mock(ProjetoRepositoryInterface::class);
        $repository->shouldReceive('listarProjetos')
            ->once()
            ->with('abc', [10, 20], 10, 7)
            ->andReturn($paginator);

        $macroPermissoes = Mockery::mock(MacroprojetoPermissoes::class);
        $macroPermissoes->shouldReceive('listarMacroprojetosAdministraveis')
            ->once()
            ->andReturn([
                (object) ['id' => 7, 'nome' => 'Macro A'],
                (object) ['id' => 8, 'nome' => 'Macro B'],
            ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeExecutar')
            ->once()
            ->with('planejamento.projetos.listar', 7, ['GRUPO_X'])
            ->andReturnTrue();
        $permissao->shouldReceive('podeExecutar')
            ->once()
            ->with('planejamento.projetos.listar', 8, ['GRUPO_X'])
            ->andReturnFalse();

        $escopo = Mockery::mock(EscopoUnidadeService::class);
        $escopo->shouldReceive('unidadesParaConsultaAtual')
            ->once()
            ->andReturn([10, 20]);

        $controller = new ProjetoController($repository, $macroPermissoes, $permissao, $escopo);
        $request = $this->registrarRequestAtual('planejamento.projetos.listar', ['busca' => 'abc']);

        $response = $controller->listar($request);

        $this->assertSame('planejamento.projetos.lista', $response->name());
        $this->assertSame(7, $response->getData()['macroprojetoId']);
        $this->assertSame('abc', $response->getData()['busca']);
    }

    private function registrarRequestAtual(string $rota, array $query = []): Request
    {
        $request = Request::create('/teste', 'GET', $query);
        $request->setRouteResolver(static fn () => new class($rota) {
            public function __construct(private readonly string $rota)
            {
            }

            public function getName(): string
            {
                return $this->rota;
            }
        });

        $this->app->instance('request', $request);

        return $request;
    }
}
```
</TESTS_UNIT_PROJETOCONTROLLERPERMISSOESTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RequireMacroprojetoContextTest.php`
## <TESTS_UNIT_REQUIREMACROPROJETOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RequireMacroprojetoContextTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RequireMacroprojetoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_permite_fluxo_quando_macroprojeto_ativo_existe(): void
public function test_autoativa_macroprojeto_quando_ha_apenas_um_disponivel(): void
public function test_retorna_409_json_quando_macroprojeto_ativo_esta_ausente_e_ha_multiplos_macros(): void
public function test_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente_em_html(): void
public function test_permite_rota_de_selecao_sem_macroprojeto_ativo(): void
private function criarRequestComRota(string $nome, bool $json = false): Request
public function __construct(private readonly string $nome)
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Middleware\RequireMacroprojetoContext;
use Illuminate\Http\Request;
use Tests\TestCase;

class RequireMacroprojetoContextTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_permite_fluxo_quando_macroprojeto_ativo_existe(): void
    {
        session([
            'macroprojetos_disponiveis' => [
                ['id' => 15, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 20, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
            'macroprojeto_ativo_id' => 15,
        ]);

        $middleware = new RequireMacroprojetoContext();
        $request = $this->criarRequestComRota('planejamento.projetos.index');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
    }

    public function test_autoativa_macroprojeto_quando_ha_apenas_um_disponivel(): void
    {
        session([
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro Unico', 'grupo_admin' => 'GA'],
            ],
        ]);

        $middleware = new RequireMacroprojetoContext();
        $request = $this->criarRequestComRota('cadastro-eleitoral.agendamentos.index');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertSame(7, session('macroprojeto_ativo_id'));
        $this->assertSame('Macro Unico', session('macroprojeto_ativo_nome'));
    }

    public function test_retorna_409_json_quando_macroprojeto_ativo_esta_ausente_e_ha_multiplos_macros(): void
    {
        session([
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
        ]);

        $middleware = new RequireMacroprojetoContext();
        $request = $this->criarRequestComRota('planejamento.projetos.index', true);

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame(409, $response->getStatusCode());
        $this->assertSame('Selecione um macroprojeto para continuar.', $response->getData(true)['mensagem']);
    }

    public function test_redireciona_para_selecao_quando_macroprojeto_ativo_esta_ausente_em_html(): void
    {
        session([
            'macroprojetos_disponiveis' => [
                ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
                ['id' => 8, 'nome' => 'Macro B', 'grupo_admin' => 'GB'],
            ],
        ]);

        $middleware = new RequireMacroprojetoContext();
        $request = $this->criarRequestComRota('planejamento.projetos.index');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame(302, $response->getStatusCode());
        $this->assertStringContainsString('/planejamento/macroprojeto/selecionar', $response->headers->get('Location', ''));
    }

    public function test_permite_rota_de_selecao_sem_macroprojeto_ativo(): void
    {
        $middleware = new RequireMacroprojetoContext();
        $request = $this->criarRequestComRota('macroprojeto.contexto.selecionar');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
    }

    private function criarRequestComRota(string $nome, bool $json = false): Request
    {
        $server = $json ? ['HTTP_ACCEPT' => 'application/json', 'X-Requested-With' => 'XMLHttpRequest'] : [];
        $request = Request::create('/teste', 'GET', [], [], [], $server);
        $request->setRouteResolver(static fn () => new class($nome) {
            public function __construct(private readonly string $nome)
            {
            }

            public function getName(): string
            {
                return $this->nome;
            }
        });

        return $request;
    }
}
```
</TESTS_UNIT_REQUIREMACROPROJETOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RequireMacroprojetoTurnoContextTest.php`
## <TESTS_UNIT_REQUIREMACROPROJETOTURNOCONTEXTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RequireMacroprojetoTurnoContextTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RequireMacroprojetoTurnoContextTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_hidrata_sessao_quando_macroprojeto_tem_turno_ativo_configurado(): void
public function test_retorna_409_json_quando_macroprojeto_nao_tem_turno_ativo_configurado(): void
public function test_redireciona_em_html_quando_macroprojeto_nao_tem_turno_ativo_configurado(): void
public function test_nao_executa_para_rota_que_nao_exige_turno(): void
private function criarRequestComRota(string $nome, bool $json = false): Request
public function __construct(private readonly string $nome)
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Middleware\RequireMacroprojetoTurnoContext;
use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class RequireMacroprojetoTurnoContextTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_hidrata_sessao_quando_macroprojeto_tem_turno_ativo_configurado(): void
    {
        session([
            'macroprojeto_ativo_id' => 15,
        ]);

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(15)->andReturn([
            'id' => 102,
            'macroprojeto_id' => 15,
            'turno' => '2',
            'descricao' => '2o turno',
            'ativo' => 1,
        ]);

        $middleware = new RequireMacroprojetoTurnoContext($repository);
        $request = $this->criarRequestComRota('lda.monitoramento-lda.dados');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertSame('2', session('macroprojeto_ativo_turno'));
        $this->assertSame(102, session('macroprojeto_turno_ativo_id'));
        $this->assertSame('2o turno', session('macroprojeto_ativo_turno_descricao'));
    }

    public function test_retorna_409_json_quando_macroprojeto_nao_tem_turno_ativo_configurado(): void
    {
        session([
            'macroprojeto_ativo_id' => 7,
        ]);

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(7)->andReturn(null);

        $middleware = new RequireMacroprojetoTurnoContext($repository);
        $request = $this->criarRequestComRota('lda.monitoramento-lda.dados', true);

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame(409, $response->getStatusCode());
        $this->assertSame('Nenhum turno ativo configurado para o macroprojeto.', $response->getData(true)['mensagem']);
    }

    public function test_redireciona_em_html_quando_macroprojeto_nao_tem_turno_ativo_configurado(): void
    {
        session([
            'macroprojeto_ativo_id' => 7,
        ]);

        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(7)->andReturn(null);

        $middleware = new RequireMacroprojetoTurnoContext($repository);
        $request = $this->criarRequestComRota('lda.monitoramento-lda');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame(302, $response->getStatusCode());
        $this->assertStringContainsString('/planejamento/macroprojeto/selecionar', $response->headers->get('Location', ''));
    }

    public function test_nao_executa_para_rota_que_nao_exige_turno(): void
    {
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->never();

        $middleware = new RequireMacroprojetoTurnoContext($repository);
        $request = $this->criarRequestComRota('macroprojeto.contexto.selecionar');

        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
    }

    private function criarRequestComRota(string $nome, bool $json = false): Request
    {
        $server = $json ? ['HTTP_ACCEPT' => 'application/json', 'X-Requested-With' => 'XMLHttpRequest'] : [];
        $request = Request::create('/teste', 'GET', [], [], [], $server);
        $request->setRouteResolver(static fn () => new class($nome) {
            public function __construct(private readonly string $nome)
            {
            }

            public function getName(): string
            {
                return $this->nome;
            }
        });

        return $request;
    }
}
```
</TESTS_UNIT_REQUIREMACROPROJETOTURNOCONTEXTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Services/CalendarioEleitoralConsultaServiceTest.php`
## <TESTS_UNIT_SERVICES_CALENDARIOELEITORALCONSULTASERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Services/CalendarioEleitoralConsultaServiceTest.php`
- **Namespace Declaração:** `Tests\Unit\Services`
- **Entidade / Classe:** `class CalendarioEleitoralConsultaServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_formata_termino_exclusivo_sem_perder_periodo_inclusivo(): void
public function test_pleito_inexistente_ou_sem_publicacao_retorna_nao_encontrado(): void
public function test_pleito_ativo_sem_eventos_publicados_renderiza_estado_vazio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Services;

use App\Repositories\CalendarioEleitoral\CalendarioEleitoralRepository;
use App\Services\CalendarioEleitoral\CalendarioEleitoralConsultaService;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Mockery;
use Tests\TestCase;

class CalendarioEleitoralConsultaServiceTest extends TestCase
{
    public function test_formata_termino_exclusivo_sem_perder_periodo_inclusivo(): void
    {
        $repository = Mockery::mock(CalendarioEleitoralRepository::class);
        $repository->shouldReceive('listarPleitosPublicados')->once()->andReturn(collect([
            (object) ['id' => 1, 'ano' => 2026, 'titulo' => 'Eleições 2026', 'fonte_referencia' => 'Resolução', 'fonte_url' => 'https://example.test/fonte'],
        ]));
        $repository->shouldReceive('listarCompetenciasPublicadas')->with(1)->once()->andReturn(collect([
            (object) ['codigo' => 'TSE', 'nome' => 'TSE', 'cor' => '#1D4ED8', 'ordem' => 1],
        ]));
        $repository->shouldReceive('listarEventosPublicados')->with(1)->once()->andReturn(collect([
            (object) ['codigo' => 'EVT-1', 'descricao_oficial' => 'Evento', 'data_inicio' => '2026-06-13', 'data_fim' => '2026-06-14', 'competencia_codigo' => 'TSE', 'competencia_nome' => 'TSE', 'cor' => '#1D4ED8'],
        ]));

        $resultado = (new CalendarioEleitoralConsultaService($repository))->consultar(2026);

        $this->assertSame('2026-06-13', $resultado['eventos'][0]['start']);
        $this->assertSame('2026-06-15', $resultado['eventos'][0]['end']);
        $this->assertSame('13/06/2026 a 14/06/2026', $resultado['eventos'][0]['extendedProps']['periodo']);
    }

    public function test_pleito_inexistente_ou_sem_publicacao_retorna_nao_encontrado(): void
    {
        $repository = Mockery::mock(CalendarioEleitoralRepository::class);
        $repository->shouldReceive('listarPleitosPublicados')->once()->andReturn(collect());

        $this->expectException(ModelNotFoundException::class);
        (new CalendarioEleitoralConsultaService($repository))->consultar(2030);
    }

    public function test_pleito_ativo_sem_eventos_publicados_renderiza_estado_vazio(): void
    {
        $repository = Mockery::mock(CalendarioEleitoralRepository::class);
        $repository->shouldReceive('listarPleitosPublicados')->once()->andReturn(collect([
            (object) ['id' => 1, 'ano' => 2026, 'titulo' => 'Eleições 2026', 'fonte_referencia' => 'Resolução', 'fonte_url' => 'https://example.test/fonte'],
        ]));
        $repository->shouldReceive('listarCompetenciasPublicadas')->with(1)->once()->andReturn(collect());
        $repository->shouldReceive('listarEventosPublicados')->with(1)->once()->andReturn(collect());

        $resultado = (new CalendarioEleitoralConsultaService($repository))->consultar();

        $this->assertSame([], $resultado['eventos']);
        $this->assertSame([], $resultado['competencias']);
    }
}
```
</TESTS_UNIT_SERVICES_CALENDARIOELEITORALCONSULTASERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Services/CalendarioEleitoralImportacaoServiceTest.php`
## <TESTS_UNIT_SERVICES_CALENDARIOELEITORALIMPORTACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Services/CalendarioEleitoralImportacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit\Services`
- **Entidade / Classe:** `class CalendarioEleitoralImportacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_previa_valida_e_confirmacao_faz_upsert_vinculado_ao_usuario(): void
public function test_previa_com_erro_nao_emite_token_de_confirmacao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Services;

use App\Repositories\CalendarioEleitoral\CalendarioEleitoralRepository;
use App\Services\CalendarioEleitoral\CalendarioEleitoralImportacaoService;
use Illuminate\Http\UploadedFile;
use Mockery;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use Tests\TestCase;

class CalendarioEleitoralImportacaoServiceTest extends TestCase
{
    public function test_previa_valida_e_confirmacao_faz_upsert_vinculado_ao_usuario(): void
    {
        $arquivo = tempnam(sys_get_temp_dir(), 'calendario-xlsx-');
        $planilha = new Spreadsheet;
        $planilha->getActiveSheet()->fromArray([
            ['codigo', 'data_inicio', 'data_fim', 'competencia', 'evento', 'ordem'],
            ['EVT-001', '13/06/2026', '14/06/2026', 'TSE', 'Evento importado', 10],
        ]);
        (new Xlsx($planilha))->save($arquivo);
        $planilha->disconnectWorksheets();

        try {
            $repository = Mockery::mock(CalendarioEleitoralRepository::class);
            $repository->shouldReceive('listarCompetenciasAdministrativas')->once()->andReturn(collect([
                (object) ['id' => 9, 'codigo' => 'TSE', 'ativo' => 1],
            ]));
            $repository->shouldReceive('importarEventos')->once()->withArgs(function (int $pleitoId, array $eventos): bool {
                return $pleitoId === 1
                    && $eventos[0]['competencia_id'] === 9
                    && $eventos[0]['data_inicio'] === '2026-06-13'
                    && $eventos[0]['data_fim'] === '2026-06-14';
            })->andReturn(['criados' => 1, 'atualizados' => 0]);

            $service = new CalendarioEleitoralImportacaoService($repository);
            $previa = $service->criarPrevia(new UploadedFile($arquivo, 'eventos.xlsx', null, null, true), 1, 'admin');

            $this->assertSame([], $previa['erros']);
            $this->assertNotNull($previa['token']);
            $this->assertSame(['criados' => 1, 'atualizados' => 0], $service->confirmar($previa['token'], 'admin'));
        } finally {
            @unlink($arquivo);
        }
    }

    public function test_previa_com_erro_nao_emite_token_de_confirmacao(): void
    {
        $arquivo = tempnam(sys_get_temp_dir(), 'calendario-xlsx-');
        $planilha = new Spreadsheet;
        $planilha->getActiveSheet()->fromArray([
            ['codigo', 'data_inicio', 'data_fim', 'competencia', 'evento', 'ordem'],
            ['EVT-001', '14/06/2026', '13/06/2026', 'INEXISTENTE', '', 1],
        ]);
        (new Xlsx($planilha))->save($arquivo);
        $planilha->disconnectWorksheets();

        try {
            $repository = Mockery::mock(CalendarioEleitoralRepository::class);
            $repository->shouldReceive('listarCompetenciasAdministrativas')->once()->andReturn(collect());
            $previa = (new CalendarioEleitoralImportacaoService($repository))
                ->criarPrevia(new UploadedFile($arquivo, 'eventos.xlsx', null, null, true), 1, 'admin');

            $this->assertNull($previa['token']);
            $this->assertNotEmpty($previa['erros']);
        } finally {
            @unlink($arquivo);
        }
    }
}
```
</TESTS_UNIT_SERVICES_CALENDARIOELEITORALIMPORTACAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TituloEleitoralTest.php`
## <TESTS_UNIT_TITULOELEITORALTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TituloEleitoralTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TituloEleitoralTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function normaliza_titulo_digitado_para_doze_digitos(string $entrada, string $esperado): void
public static function titulosValidos(): array
public function rejeita_caracteres_indevidos_e_mais_de_doze_digitos(mixed $entrada): void
public static function titulosInvalidos(): array
public function preparacao_preserva_entrada_invalida_para_a_regra_rejeitar(): void
public function lista_representacoes_persistidas_canonica_e_legadas_sem_zeros_iniciais(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Validation\TituloEleitoral;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class TituloEleitoralTest extends TestCase
{
    #[Test]
    #[DataProvider('titulosValidos')]
    public function normaliza_titulo_digitado_para_doze_digitos(string $entrada, string $esperado): void
    {
        $this->assertTrue(TituloEleitoral::formatoPermitido($entrada));
        $this->assertTrue(TituloEleitoral::valido($entrada));
        $this->assertSame($esperado, TituloEleitoral::normalizar($entrada));
        $this->assertSame($esperado, TituloEleitoral::prepararEntrada($entrada));
    }

    /** @return array<string, array{string, string}> */
    public static function titulosValidos(): array
    {
        return [
            'com doze digitos' => ['123456789012', '123456789012'],
            'preenchido a esquerda' => ['123456789', '000123456789'],
            'pontuacao permitida' => ['1234 5678 9012', '123456789012'],
        ];
    }

    #[Test]
    #[DataProvider('titulosInvalidos')]
    public function rejeita_caracteres_indevidos_e_mais_de_doze_digitos(mixed $entrada): void
    {
        $this->assertFalse(TituloEleitoral::valido($entrada));
    }

    /** @return array<string, array{mixed}> */
    public static function titulosInvalidos(): array
    {
        return [
            'letras' => ['12345678901A'],
            'longo' => ['1234567890123'],
            'vazio' => [''],
            'nulo' => [null],
        ];
    }

    #[Test]
    public function preparacao_preserva_entrada_invalida_para_a_regra_rejeitar(): void
    {
        $this->assertSame('12345678901A', TituloEleitoral::prepararEntrada(' 12345678901A '));
        $this->assertNull(TituloEleitoral::normalizar('12345678901A'));
    }

    #[Test]
    public function lista_representacoes_persistidas_canonica_e_legadas_sem_zeros_iniciais(): void
    {
        $this->assertSame([
            '000123456789',
            '00123456789',
            '0123456789',
            '123456789',
        ], TituloEleitoral::representacoesPersistidasEquivalentes('123.456.789'));

        $this->assertSame(
            ['123456789012'],
            TituloEleitoral::representacoesPersistidasEquivalentes('123456789012')
        );
        $this->assertSame([], TituloEleitoral::representacoesPersistidasEquivalentes('invalido'));
    }
}
```
</TESTS_UNIT_TITULOELEITORALTEST_PHP>


