# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_seu_voto_importa_admin`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 4  
> **Tamanho do Arquivo:** 21 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/admin/configuracao.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_CONFIGURACAO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/admin/configuracao.blade.php`
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

@section('titulo', 'Configuração — Seu Voto Importa')

@section('conteudo')
@php
    $valorData = static function (?string $valor, string $formato): string {
        if (!$valor) return '';
        try { return \Carbon\CarbonImmutable::parse($valor)->format($formato); } catch (\Throwable) { return ''; }
    };
@endphp
<div class="d-flex justify-content-between align-items-start gap-2 mt-3 mb-3"><div><h1 class="h4 text-primary mb-1">Configuração — Seu Voto Importa</h1><p class="text-muted mb-0">Macroprojeto {{ $macroprojetoId }}. A janela permanece configurável até validação jurídica.</p></div><a class="btn btn-outline-secondary" href="{{ route('seu-voto-importa.admin.index') }}">Voltar</a></div>
@if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif
@if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<form class="card shadow-sm" method="POST" action="{{ route('seu-voto-importa.admin.config.update') }}">@csrf @method('PUT')<div class="card-body"><input type="hidden" name="macroprojeto_id" value="{{ $macroprojetoId }}"><div class="row g-3">
    <div class="col-md-6"><label class="form-label" for="dt_abertura">Abertura</label><input class="form-control" id="dt_abertura" name="dt_abertura" type="datetime-local" value="{{ old('dt_abertura', $valorData($configuracao['dt_abertura'] ?? null, 'Y-m-d\TH:i')) }}" required></div>
    <div class="col-md-6"><label class="form-label" for="dt_encerramento">Encerramento</label><input class="form-control" id="dt_encerramento" name="dt_encerramento" type="datetime-local" value="{{ old('dt_encerramento', $valorData($configuracao['dt_encerramento'] ?? null, 'Y-m-d\TH:i')) }}" required></div>
    <div class="col-md-6"><label class="form-label" for="dt_primeiro_turno">Data do primeiro turno</label><input class="form-control" id="dt_primeiro_turno" name="dt_primeiro_turno" type="date" value="{{ old('dt_primeiro_turno', $valorData($configuracao['dt_primeiro_turno'] ?? null, 'Y-m-d')) }}" required></div>
    <div class="col-md-6"><label class="form-label" for="dt_segundo_turno">Data do segundo turno</label><input class="form-control" id="dt_segundo_turno" name="dt_segundo_turno" type="date" value="{{ old('dt_segundo_turno', $valorData($configuracao['dt_segundo_turno'] ?? null, 'Y-m-d')) }}"></div>
    <div class="col-12"><div class="form-check"><input class="form-check-input" id="segundo_turno_confirmado" name="segundo_turno_confirmado" type="checkbox" value="1" @checked(old('segundo_turno_confirmado', $configuracao['segundo_turno_confirmado'] ?? false))><label class="form-check-label" for="segundo_turno_confirmado">Segundo turno confirmado — criar a operação somente para quem manifestou preferência</label></div></div>
    <div class="col-12"><label class="form-label" for="aviso_privacidade">Aviso de privacidade aprovado</label><textarea class="form-control" id="aviso_privacidade" name="aviso_privacidade" maxlength="10000" rows="8" required>{{ old('aviso_privacidade', $configuracao['aviso_privacidade'] ?? '') }}</textarea></div>
    <div class="col-12"><div class="form-check"><input class="form-check-input" id="ativo" name="ativo" type="checkbox" value="1" @checked(old('ativo', $configuracao['ativo'] ?? true))><label class="form-check-label" for="ativo">Configuração ativa</label></div></div>
</div></div><div class="card-footer d-flex justify-content-end"><button class="btn btn-primary" type="submit">Salvar configuração</button></div></form>
@endsection
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_CONFIGURACAO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/admin/index.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/admin/index.blade.php`
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

@section('titulo', 'Seu Voto Importa')

@section('conteudo')
<div class="d-flex flex-wrap justify-content-between align-items-start gap-2 mt-3 mb-3">
    <div><h1 class="h4 text-primary mb-1"><i class="fa-solid fa-universal-access me-2"></i>Seu Voto Importa</h1><p class="text-muted mb-0">Triagem das solicitações no escopo zonal autorizado.</p></div>
    <div class="d-flex flex-wrap gap-2">
        @if(session('is_admin') === true)<a class="btn btn-outline-primary" href="{{ route('seu-voto-importa.admin.config.edit') }}"><i class="fa-solid fa-gear me-1"></i>Configuração</a>@endif
        <button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#modalExportarSeuVoto"><i class="fa-solid fa-file-pdf me-1"></i>Exportar para PDF</button>
    </div>
</div>

@if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif

<form class="card shadow-sm mb-3" method="GET" action="{{ route('seu-voto-importa.admin.index') }}"><div class="card-body"><div class="row g-3 align-items-end">
    <div class="col-sm-6 col-lg-2"><label class="form-label" for="protocolo">Protocolo</label><input class="form-control form-control-sm" id="protocolo" name="protocolo" value="{{ $filtros['protocolo'] }}"></div>
    <div class="col-sm-6 col-lg-2"><label class="form-label" for="status">Estado</label><select class="form-select form-select-sm" id="status" name="status"><option value="">Todos</option>@foreach($statusSolicitacao as $codigo => $descricao)<option value="{{ $codigo }}" @selected($filtros['status'] === $codigo)>{{ $descricao }}</option>@endforeach</select></div>
    <div class="col-sm-6 col-lg-1"><label class="form-label" for="zona">Zona</label><input class="form-control form-control-sm" id="zona" name="zona" type="number" min="1" value="{{ $filtros['zona'] ?: '' }}"></div>
    <div class="col-sm-6 col-lg-3"><label class="form-label" for="municipio">Município</label><input class="form-control form-control-sm" id="municipio" name="municipio" value="{{ $filtros['municipio'] }}"></div>
    <div class="col-sm-6 col-lg-2"><label class="form-label" for="data_inicio">De</label><input class="form-control form-control-sm" id="data_inicio" name="data_inicio" type="date" value="{{ $filtros['data_inicio'] }}"></div>
    <div class="col-sm-6 col-lg-2"><label class="form-label" for="data_fim">Até</label><input class="form-control form-control-sm" id="data_fim" name="data_fim" type="date" value="{{ $filtros['data_fim'] }}"></div>
    <div class="col-12 d-flex justify-content-end gap-2"><a class="btn btn-outline-secondary btn-sm" href="{{ route('seu-voto-importa.admin.index') }}">Limpar</a><button class="btn btn-primary btn-sm" type="submit"><i class="fa-solid fa-filter me-1"></i>Filtrar</button></div>
</div></div></form>

<div class="table-responsive"><table class="table table-sm table-striped align-middle">
    <thead class="table-light"><tr><th>Solicitação</th><th>Ações</th></tr></thead>
    <tbody>@forelse($solicitacoes as $item)<tr>
        <td>
            <strong>Protocolo:</strong> {{ $item->protocolo }} <span class="badge text-bg-secondary ms-1">{{ $item->status_descricao }}</span><br>
            <strong>Eleitor:</strong> {{ $item->eleitor_nome }}<br>
            <strong>Zona:</strong> {{ $item->zona_numero }} <strong class="ms-2">Município:</strong> {{ $item->municipio_nome }}<br>
            <strong>Local:</strong> {{ $item->local_nome }}<br>
            <strong>Recebida em:</strong> {{ $item->dt_criacao }}
        </td>
        <td><a class="btn btn-sm btn-outline-primary" href="{{ route('seu-voto-importa.admin.show', $item->id) }}" title="Ver solicitação" aria-label="Ver solicitação {{ $item->protocolo }}"><i class="fa-solid fa-eye"></i></a></td>
    </tr>@empty<tr><td class="text-center text-muted py-4" colspan="2">Nenhuma solicitação encontrada.</td></tr>@endforelse</tbody>
</table></div>
@if($solicitacoes->hasPages())<div class="mt-3">{{ $solicitacoes->links('pagination::bootstrap-5') }}</div>@endif

<div class="modal fade" id="modalExportarSeuVoto" tabindex="-1" aria-labelledby="modalExportarSeuVotoLabel" aria-hidden="true"><div class="modal-dialog modal-lg"><form class="modal-content" method="GET" action="{{ route('seu-voto-importa.admin.exportar-pdf') }}" target="_blank">
    @foreach($filtros as $campo => $valor)@if($campo !== 'macroprojeto_id')<input type="hidden" name="{{ $campo }}" value="{{ $valor }}">@endif @endforeach
    <div class="modal-header"><h2 class="modal-title fs-5" id="modalExportarSeuVotoLabel">Campos do PDF</h2><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button></div>
    <div class="modal-body"><p class="small text-muted">O PDF reaplica os mesmos filtros e o mesmo escopo. Título, e-mail e telefone não vêm selecionados.</p><div class="row g-2">@foreach($camposPdf as $campo => $rotulo)<div class="col-md-6 form-check"><input class="form-check-input" id="sviPdf{{ $campo }}" name="campos[]" type="checkbox" value="{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="sviPdf{{ $campo }}">{{ $rotulo }}</label></div>@endforeach</div></div>
    <div class="modal-footer"><button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit"><i class="fa-solid fa-file-pdf me-1"></i>Gerar PDF</button></div>
</form></div></div>
@endsection
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/admin/pdf.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/admin/pdf.blade.php`
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
<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><style>body{font-family:DejaVu Sans,sans-serif;font-size:9px;color:#222}h1{font-size:15px;margin:0 0 4px}p{margin:0 0 10px;color:#555}table{width:100%;border-collapse:collapse}th,td{border:1px solid #bbb;padding:4px;vertical-align:top}th{background:#eee;text-align:left}</style></head><body>
<h1>Seu Voto Importa — solicitações</h1><p>Gerado em {{ $geradoEm }}. Resultado integral dos filtros e do escopo autorizado.</p>
<table><thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead><tbody>
@forelse($solicitacoes as $item)<tr>@foreach($campos as $campo)<td>@switch($campo)
@case('protocolo'){{ $item->protocolo }}@break @case('status'){{ $item->status_descricao }}@break @case('nome'){{ $item->eleitor_nome }}@break @case('titulo'){{ $item->num_inscricao }}@break @case('zona'){{ $item->zona_numero }}@break @case('municipio'){{ $item->municipio_nome }}@break @case('local'){{ $item->local_nome }}@break @case('email'){{ $item->eleitor_email }}@break @case('telefone'){{ $item->eleitor_telefone }}@break @case('recebida_em'){{ $item->dt_criacao }}@break @endswitch</td>@endforeach</tr>@empty<tr><td colspan="{{ max(1, count($campos)) }}">Nenhuma solicitação encontrada.</td></tr>@endforelse
</tbody></table></body></html>
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/admin/show.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_SHOW_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/admin/show.blade.php`
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

@section('titulo', 'Solicitação Seu Voto Importa')

@section('conteudo')
@php($s = (object) $solicitacao)
<div class="d-flex flex-wrap justify-content-between align-items-start gap-2 mt-3 mb-3"><div><h1 class="h4 text-primary mb-1">Solicitação {{ $s->protocolo }}</h1><p class="text-muted mb-0">Zona {{ $s->zona_numero }} — {{ $s->municipio_nome }}</p></div><a class="btn btn-outline-secondary" href="{{ route('seu-voto-importa.admin.index') }}"><i class="fa-solid fa-arrow-left me-1"></i>Voltar</a></div>
@if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif
@if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif

<div class="row g-3">
<div class="col-xl-7">
    <section class="card shadow-sm mb-3"><div class="card-header"><strong>Eleitor e votação</strong></div><div class="card-body row g-2">
        <div class="col-md-8"><strong>Nome:</strong> {{ $s->eleitor_nome }}</div><div class="col-md-4"><strong>Título:</strong> {{ $s->num_inscricao }}</div>
        <div class="col-md-4"><strong>Nascimento:</strong> {{ $s->dt_nascimento }}</div><div class="col-md-2"><strong>Idade:</strong> {{ $s->idade }}</div><div class="col-md-3"><strong>Zona:</strong> {{ $s->zona_numero }}</div><div class="col-md-3"><strong>Seção:</strong> {{ $s->secao_numero }}</div>
        <div class="col-12"><strong>Local efetivo:</strong> {{ $s->local_nome }} — {{ $s->local_endereco ?: 'sem endereço cadastrado' }}</div>
        @if($s->eleitor_email)<div class="col-md-6"><strong>E-mail legado:</strong> {{ $s->eleitor_email }}</div>@endif<div class="col-md-6"><strong>Telefone:</strong> {{ $s->eleitor_telefone }}</div>
    </div></section>

    <section class="card shadow-sm mb-3"><div class="card-header"><strong>Solicitante e embarque</strong></div><div class="card-body">
        <p><strong>Tipo:</strong> {{ $s->solicitante_tipo_codigo }}@if($s->solicitante_nome) — {{ $s->solicitante_nome }} / {{ $s->solicitante_titulo }} / {{ $s->solicitante_telefone }}@endif</p>
        <p><strong>Endereço informado:</strong> {{ $s->endereco_logradouro }}, {{ $s->endereco_numero }} — {{ $s->endereco_bairro }}, {{ $s->endereco_municipio }}.<br><strong>Referência:</strong> {{ $s->endereco_referencia ?: '-' }}</p>
        <p class="mb-0"><strong>Veículo chega ao endereço:</strong> {{ $s->veiculo_acessa_codigo }}
            @if($s->end_alt_logradouro)<br><strong>Alternativo:</strong> {{ $s->end_alt_logradouro }}, {{ $s->end_alt_numero }} — {{ $s->end_alt_bairro }}, RIO BRANCO. Referência: {{ $s->end_alt_referencia }}
            @elseif($s->endereco_alternativo)<br><strong>Alternativo legado:</strong> {{ $s->endereco_alternativo }}@endif
        </p>
    </div></section>

    <section class="card shadow-sm mb-3"><div class="card-header"><strong>Condição e apoio</strong></div><div class="card-body">
        <p><strong>Condições:</strong> {{ collect($condicoes)->pluck('descricao')->join(', ') ?: '-' }}@if($s->condicao_descricao)<br>{{ $s->condicao_descricao }}@endif</p>
        <p><strong>Equipamentos:</strong> {{ collect($equipamentos)->pluck('descricao')->join(', ') ?: '-' }}@if($s->equipamento_outro)<br>{{ $s->equipamento_outro }}@endif</p>
        @if($s->autodeclaracao_texto)<p><strong>Autodeclaração:</strong> {{ $s->autodeclaracao_texto }}</p>@endif
        <p><strong>Impacto:</strong> {{ $s->impacto_codigo }}@if($s->impacto_descricao)<br>{{ $s->impacto_descricao }}@endif<br><strong>Transporte público acessível:</strong> {{ $s->transporte_publico_codigo }}</p>
        <p><strong>Acompanhante:</strong> {{ $s->acompanhante_codigo }}@if($s->acompanhante_nome) — {{ $s->acompanhante_nome }} / {{ $s->acompanhante_telefone }}@endif</p>
        <p class="mb-0"><strong>Segundo turno:</strong> {{ $s->segundo_turno_codigo }} · <strong>Observações:</strong> {{ $s->observacoes ?: '-' }}</p>
    </div></section>

    <section class="card shadow-sm mb-3"><div class="card-header"><strong>Anexos privados</strong></div><div class="card-body"><div class="list-group list-group-flush">@forelse($anexos as $anexo)<div class="list-group-item px-0 d-flex flex-wrap justify-content-between gap-2"><span>{{ $anexo->categoria }} — {{ $anexo->nome_original }} <span class="badge text-bg-secondary">{{ $anexo->scan_status }}</span></span>@if(in_array($anexo->scan_status, ['PENDENTE', 'LIMPO'], true))<a class="btn btn-sm btn-outline-primary" href="{{ route('seu-voto-importa.admin.anexo.download', [$s->id, $anexo->id]) }}"><i class="fa-solid fa-download me-1"></i>Baixar</a>@endif</div>@empty<p class="text-muted mb-0">Nenhum anexo.</p>@endforelse</div></div></section>
</div>

<div class="col-xl-5">
    <section class="card shadow-sm mb-3"><div class="card-header"><strong>Estado da solicitação</strong></div><div class="card-body"><form method="POST" action="{{ route('seu-voto-importa.admin.status.update', $s->id) }}">@csrf @method('PUT')
        <label class="form-label" for="status_codigo">Novo estado</label><select class="form-select mb-3" id="status_codigo" name="status_codigo" required>@foreach($statusSolicitacao as $codigo => $descricao)<option value="{{ $codigo }}" @selected($s->status_codigo === $codigo)>{{ $descricao }}</option>@endforeach</select>
        <label class="form-label" for="mensagem_publica">Mensagem pública</label><textarea class="form-control mb-3" id="mensagem_publica" name="mensagem_publica" maxlength="2000" rows="4">{{ old('mensagem_publica', $s->mensagem_publica) }}</textarea>
        <button class="btn btn-primary" type="submit">Atualizar estado</button>
    </form></div></section>

    @foreach($turnos as $turno)<section class="card shadow-sm mb-3"><div class="card-header"><strong>{{ $turno->numero_turno }}º turno</strong></div><div class="card-body"><form method="POST" action="{{ route('seu-voto-importa.admin.turno.update', [$s->id, $turno->numero_turno]) }}">@csrf @method('PUT')
        <label class="form-label" for="turno{{ $turno->numero_turno }}Status">Estado logístico</label><select class="form-select mb-2" id="turno{{ $turno->numero_turno }}Status" name="status_codigo" required>@foreach($statusTurno as $codigo => $descricao)<option value="{{ $codigo }}" @selected($turno->status_codigo === $codigo)>{{ $descricao }}</option>@endforeach</select>
        <div class="row g-2"><div class="col-7"><label class="form-label" for="turno{{ $turno->numero_turno }}Data">Data</label><input class="form-control" id="turno{{ $turno->numero_turno }}Data" name="data_votacao" type="date" value="{{ $turno->data_votacao }}" required></div><div class="col-5"><label class="form-label" for="turno{{ $turno->numero_turno }}Hora">Horário</label><input class="form-control" id="turno{{ $turno->numero_turno }}Hora" name="horario_previsto" type="time" value="{{ $turno->horario_previsto }}"></div></div>
        <label class="form-label mt-2" for="turno{{ $turno->numero_turno }}Ponto">Ponto de embarque</label><textarea class="form-control" id="turno{{ $turno->numero_turno }}Ponto" name="ponto_embarque" maxlength="1000" rows="2">{{ $turno->ponto_embarque }}</textarea>
        <label class="form-label mt-2" for="turno{{ $turno->numero_turno }}Obs">Observação pública</label><textarea class="form-control mb-3" id="turno{{ $turno->numero_turno }}Obs" name="observacao_publica" maxlength="2000" rows="2">{{ $turno->observacao_publica }}</textarea>
        <button class="btn btn-primary" type="submit">Salvar logística</button>
    </form></div></section>@endforeach

    <section class="card shadow-sm mb-3"><div class="card-header"><strong>Histórico</strong></div><div class="card-body"><ul class="list-unstyled mb-0">@forelse($historico as $evento)<li class="border-bottom pb-2 mb-2"><strong>{{ $evento->tipo_evento }}</strong><br><span class="small text-muted">{{ $evento->dt_evento }} · {{ $evento->usuario ?: 'sistema' }}</span>@if($evento->status_novo)<br>{{ $evento->status_anterior ?: '-' }} → {{ $evento->status_novo }}@endif</li>@empty<li class="text-muted">Sem eventos.</li>@endforelse</ul></div></section>
</div></div>
@endsection
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_ADMIN_SHOW_BLADE_PHP>

