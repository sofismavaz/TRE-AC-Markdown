# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_nat_ocorrencias`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 3  
> **Tamanho do Arquivo:** 25 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/ocorrencias/form.blade.php`
## <RESOURCES_VIEWS_NAT_OCORRENCIAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/ocorrencias/form.blade.php`
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
function resetSelect(select, placeholder) {
function preencherSelect(select, items, selectedValue = null, formatter = (item) => item.text) {
function atualizarAvisoRota(automatica) {
async function carregarSecoes(codObjetoLocal, selectedValue = null) {
async function carregarRotas(codObjetoLocal, selectedValue = null) {
async function aplicarLocal(local, preserveOldSelections = false) {
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
@extends($layout ?? 'layouts.app')

@section('titulo', 'NAT - Nova Ocorrência')

@section('conteudo')
    @php
        $routeNames = array_merge([
            'painel_index' => 'nat.rotas.index',
            'ocorrencia_store' => 'nat.ocorrencias.store',
            'ocorrencia_locais' => 'nat.ocorrencias.locais',
            'ocorrencia_secoes' => 'nat.ocorrencias.secoes',
            'ocorrencia_rotas_elegiveis' => 'nat.ocorrencias.rotas-elegiveis',
        ], $routeNames ?? []);
    @endphp

    @if (session('status'))
        <div class="alert alert-success small d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if (session('erro'))
        <div class="alert alert-danger small d-flex align-items-center gap-2">
            <i class="fa-solid fa-triangle-exclamation"></i>
            <span>{{ session('erro') }}</span>
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

    <div class="row justify-content-center">
        <div class="col-xl-10">
            <div class="card shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0 text-primary">
                        <i class="fa-solid fa-phone-volume me-2"></i> Abrir ocorrência
                    </h5>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route($routeNames['ocorrencia_store']) }}" class="row g-3" id="formNatOcorrencia">
                        @csrf
                        <input type="hidden" name="origem" value="{{ old('origem', $origem ?? '') }}">
                        <input type="hidden" name="back_url" value="{{ old('back_url', $backUrl ?? '') }}">

                        <div class="col-12">
                            <label for="localVotacaoSelect" class="form-label">Local de votação</label>
                            <select
                                id="localVotacaoSelect"
                                class="form-select select2"
                                data-placeholder="Digite zona, município, nome do local ou número do local"
                                data-url="{{ route($routeNames['ocorrencia_locais']) }}"
                            >
                                @if(old('cod_objeto_local_votacao', $localSelecionado->cod_objeto ?? ''))
                                    <option value="{{ old('cod_objeto_local_votacao', $localSelecionado->cod_objeto ?? '') }}" selected>
                                        {{ ($localSelecionado->cod_objeto_zona ?? 'S/ Zona') . ' - ' . ($localSelecionado->municipio_nome ?? $localSelecionado->nom_localidade ?? '') . ' - ' . ($localSelecionado->nom_local ?? '') . (!empty($localSelecionado->num_local) ? ' (Local ' . $localSelecionado->num_local . ')' : '') }}
                                    </option>
                                @endif
                            </select>
                            <input type="hidden" name="cod_objeto_local_votacao" id="codObjetoLocalVotacao" value="{{ old('cod_objeto_local_votacao', $localSelecionado->cod_objeto ?? '') }}">
                        </div>

                        <div class="col-md-4">
                            <label for="numSecao" class="form-label">Seção</label>
                            <select name="num_secao" id="numSecao" class="form-select" required>
                                <option value="">Selecione...</option>
                                @foreach($secoesIniciais as $secao)
                                    <option value="{{ $secao['id'] }}" @selected(old('num_secao') === $secao['id'])>{{ $secao['text'] }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label for="idTipoOcorrencia" class="form-label">Tipo de ocorrência</label>
                            <select name="id_tipo_ocorrencia" id="idTipoOcorrencia" class="form-select" required>
                                <option value="">Selecione...</option>
                                @foreach($tipos as $tipo)
                                    <option value="{{ $tipo['id_tipo_ocorrencia'] }}" @selected((string) old('id_tipo_ocorrencia') === (string) $tipo['id_tipo_ocorrencia'])>{{ $tipo['nome'] }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label for="rotaId" class="form-label">Rota responsável</label>
                            <select name="rota_id" id="rotaId" class="form-select">
                                <option value="">Selecione...</option>
                                @foreach(($rotasIniciais['rotas'] ?? []) as $rota)
                                    <option value="{{ $rota['id'] }}" @selected((string) old('rota_id') === (string) $rota['id'])>
                                        Rota #{{ $rota['numero'] }} - {{ $rota['descricao'] }}
                                    </option>
                                @endforeach
                            </select>
                            <div id="rotaHint" class="form-text">
                                A rota será preenchida automaticamente quando o local já possuir vínculo ativo.
                            </div>
                        </div>

                        <div class="col-12">
                            <div id="rotaAutomaticaAviso" class="alert alert-info small mb-0 {{ ($rotasIniciais['automatica'] ?? null) ? '' : 'd-none' }}">
                                @if($rotasIniciais['automatica'] ?? null)
                                    Atendimento atribuído automaticamente para a rota #{{ $rotasIniciais['automatica']['numero'] }} - {{ $rotasIniciais['automatica']['descricao'] }}.
                                @endif
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="descricaoProblema" class="form-label">Descrição do problema</label>
                            <textarea name="descricao_problema" id="descricaoProblema" rows="4" class="form-control" maxlength="2000" required>{{ old('descricao_problema') }}</textarea>
                        </div>

                        <div class="col-md-6">
                            <label for="nomeSolicitante" class="form-label">Solicitante</label>
                            <input type="text" name="nome_solicitante" id="nomeSolicitante" class="form-control" maxlength="160" value="{{ old('nome_solicitante') }}">
                        </div>

                        <div class="col-md-6">
                            <label for="telefoneSolicitante" class="form-label">Telefone</label>
                            <input type="text" name="telefone_solicitante" id="telefoneSolicitante" class="form-control" maxlength="40" value="{{ old('telefone_solicitante') }}">
                        </div>

                        <div class="col-12 d-flex justify-content-between">
                            <a href="{{ $backUrl ?? (($modoExterno ?? false) ? route($routeNames['painel_index']) : route('nat.ocorrencias.index')) }}" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i> Voltar
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-floppy-disk me-1"></i> Registrar ocorrência
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script>
        (function () {
            const localVotacaoSelect = $('#localVotacaoSelect');
            const codObjetoLocalInput = document.getElementById('codObjetoLocalVotacao');
            const secaoSelect = document.getElementById('numSecao');
            const rotaSelect = document.getElementById('rotaId');
            const rotaHint = document.getElementById('rotaHint');
            const rotaAutomaticaAviso = document.getElementById('rotaAutomaticaAviso');
            const oldSecao = @json(old('num_secao'));
            const oldRota = @json(old('rota_id'));
            const urls = {
                secoes: @json(route($routeNames['ocorrencia_secoes'])),
                rotas: @json(route($routeNames['ocorrencia_rotas_elegiveis'])),
            };

            function resetSelect(select, placeholder) {
                select.innerHTML = '';
                const option = document.createElement('option');
                option.value = '';
                option.textContent = placeholder;
                select.appendChild(option);
            }

            function preencherSelect(select, items, selectedValue = null, formatter = (item) => item.text) {
                items.forEach((item) => {
                    const option = document.createElement('option');
                    option.value = item.id;
                    option.textContent = formatter(item);
                    if (selectedValue !== null && String(selectedValue) === String(item.id)) {
                        option.selected = true;
                    }
                    select.appendChild(option);
                });
            }

            function atualizarAvisoRota(automatica) {
                if (!automatica) {
                    rotaAutomaticaAviso.classList.add('d-none');
                    rotaAutomaticaAviso.textContent = '';
                    rotaHint.textContent = 'Selecione manualmente uma rota da mesma zona e município quando não houver vínculo automático.';
                    rotaSelect.disabled = false;
                    return;
                }

                rotaAutomaticaAviso.classList.remove('d-none');
                rotaAutomaticaAviso.textContent = `Atendimento atribuído automaticamente para a rota #${automatica.numero} - ${automatica.descricao}.`;
                rotaHint.textContent = 'A rota foi definida automaticamente pelo vínculo do local.';
                rotaSelect.disabled = true;
            }

            async function carregarSecoes(codObjetoLocal, selectedValue = null) {
                resetSelect(secaoSelect, 'Selecione...');
                if (!codObjetoLocal) {
                    return;
                }

                const response = await fetch(`${urls.secoes}?cod_objeto_local_votacao=${encodeURIComponent(codObjetoLocal)}`);
                const secoes = await response.json();
                preencherSelect(secaoSelect, secoes, selectedValue);
            }

            async function carregarRotas(codObjetoLocal, selectedValue = null) {
                resetSelect(rotaSelect, 'Selecione...');
                atualizarAvisoRota(null);
                if (!codObjetoLocal) {
                    return;
                }

                const response = await fetch(`${urls.rotas}?cod_objeto_local_votacao=${encodeURIComponent(codObjetoLocal)}`);
                const payload = await response.json();

                if (payload.automatica) {
                    preencherSelect(rotaSelect, [{
                        id: payload.automatica.id,
                        text: `Rota #${payload.automatica.numero} - ${payload.automatica.descricao}`,
                    }], payload.automatica.id);
                    atualizarAvisoRota(payload.automatica);
                    return;
                }

                preencherSelect(rotaSelect, payload.rotas || [], selectedValue, (item) => `Rota #${item.numero} - ${item.descricao}`);
                atualizarAvisoRota(null);
            }

            async function aplicarLocal(local, preserveOldSelections = false) {
                codObjetoLocalInput.value = local.id || '';
                await carregarSecoes(local.id || '', preserveOldSelections ? oldSecao : null);
                await carregarRotas(local.id || '', preserveOldSelections ? oldRota : null);
            }

            if (localVotacaoSelect.length && $.fn.select2) {
                localVotacaoSelect.select2({
                    placeholder: localVotacaoSelect.data('placeholder') || 'Pesquise',
                    width: '100%',
                    allowClear: true,
                    minimumInputLength: 1,
                    language: {
                        inputTooShort: (args) => `Digite pelo menos ${args.minimum} caractere${args.minimum > 1 ? 's' : ''} para pesquisar.`,
                        searching: () => 'Buscando…',
                        noResults: () => 'Nenhum local encontrado.',
                    },
                    ajax: {
                        url: localVotacaoSelect.data('url'),
                        dataType: 'json',
                        delay: 250,
                        data: (params) => ({ q: params.term || '' }),
                        processResults: (data) => ({ results: data }),
                    },
                });

                localVotacaoSelect.on('select2:select', async function (event) {
                    const selecionado = event.params.data || {};
                    await aplicarLocal(selecionado);
                });

                localVotacaoSelect.on('select2:clear', async function () {
                    await aplicarLocal({ id: '', text: '' });
                });
            }

            if (codObjetoLocalInput.value) {
                aplicarLocal({
                    id: codObjetoLocalInput.value,
                    text: '',
                }, true);
            }
        })();
    </script>
@endpush
```
</RESOURCES_VIEWS_NAT_OCORRENCIAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/ocorrencias/index.blade.php`
## <RESOURCES_VIEWS_NAT_OCORRENCIAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/ocorrencias/index.blade.php`
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
@section('titulo', 'NAT - Ocorrências')
@section('conteudo')
@if (session('status'))<div class="alert alert-success d-flex align-items-center gap-2 small"><i class="fa-solid fa-circle-check"></i><span>{{ session('status') }}</span></div>@endif
<div class="card shadow-sm mb-3"><div class="card-body"><form method="GET" action="{{ route('nat.ocorrencias.index') }}" class="row g-3 align-items-end"><div class="col-md-4"><label for="busca" class="form-label">Buscar</label><input type="text" name="busca" id="busca" class="form-control" value="{{ $filtros['busca'] }}" placeholder="Local, município, tipo ou descrição"></div><div class="col-md-2"><label for="status" class="form-label">Status</label><select name="status" id="status" class="form-select">@include('nat.partials.status-filter-options', ['statusSelecionado' => $filtros['status']])</select></div><div class="col-md-3"><label for="tipo" class="form-label">Tipo</label><select name="tipo" id="tipo" class="form-select"><option value="">Todos</option>@foreach($tipos as $tipo)<option value="{{ $tipo['id_tipo_ocorrencia'] }}" @selected((string) $filtros['tipo'] === (string) $tipo['id_tipo_ocorrencia'])>{{ $tipo['nome'] }}</option>@endforeach</select></div><div class="col-md-1"><label for="secao" class="form-label">Seção</label><input type="text" name="secao" id="secao" class="form-control" value="{{ $filtros['secao'] }}"></div><div class="col-md-2 d-flex gap-2"><button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button><a class="btn btn-success flex-fill" href="{{ route('nat.ocorrencias.form', ['origem' => 'nat_ocorrencias_index', 'back_url' => request()->getRequestUri()]) }}"><i class="fa-solid fa-plus me-1"></i> Nova</a></div></form></div></div>
<div class="card shadow-sm">@include('nat.partials.ocorrencias-table', ['ocorrencias' => $ocorrencias, 'mostrarAcoesRota' => false]) @if($ocorrencias->hasPages())<div class="card-footer">{{ $ocorrencias->links('pagination::bootstrap-5') }}</div>@endif</div>
@endsection
```
</RESOURCES_VIEWS_NAT_OCORRENCIAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/ocorrencias/show.blade.php`
## <RESOURCES_VIEWS_NAT_OCORRENCIAS_SHOW_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/ocorrencias/show.blade.php`
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
@extends($layout ?? 'layouts.app')

@section('titulo', 'NAT - Detalhes da Ocorrência')

@section('conteudo')
    @php
        $routeNames = array_merge([
            'painel_index' => 'nat.rotas.index',
        ], $routeNames ?? []);

        $painelParams = ($modoExterno ?? false) === true
            ? ['aba' => 'ocorrencias']
            : ['rotas' => [$ocorrencia->rota_id], 'aba' => 'ocorrencias'];
    @endphp

    @if (session('status'))
        <div class="alert alert-success small d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if (session('erro'))
        <div class="alert alert-danger small d-flex align-items-center gap-2">
            <i class="fa-solid fa-triangle-exclamation"></i>
            <span>{{ session('erro') }}</span>
        </div>
    @endif

    <div class="row g-3">
        <div class="col-lg-7">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-primary"><i class="fa-solid fa-file-circle-exclamation me-2"></i>Ocorrência #{{ $ocorrencia->id_ocorrencia }}</h5>
                    @include('nat.partials.status-badge', ['codigo' => $ocorrencia->status_codigo, 'label' => $ocorrencia->status_nome])
                </div>
                <div class="card-body">
                    <div class="row g-3 small">
                        <div class="col-md-6">
                            <div class="text-uppercase text-muted mb-1">Tipo</div>
                            <div class="fw-semibold">{{ $ocorrencia->tipo_nome }}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="text-uppercase text-muted mb-1">Rota</div>
                            <div class="fw-semibold">Rota #{{ $ocorrencia->rota_numero }} - {{ $ocorrencia->rota_descricao }}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="text-uppercase text-muted mb-1">Local</div>
                            <div class="fw-semibold">{{ $ocorrencia->local_nome ?? 'Local não localizado' }}</div>
                            <div class="text-muted">Local {{ $ocorrencia->local_numero ?? '—' }} · Seção {{ $ocorrencia->num_secao }}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="text-uppercase text-muted mb-1">Abrangência</div>
                            <div class="fw-semibold">Zona {{ $ocorrencia->zona_numero ?? '—' }}</div>
                            <div class="text-muted">{{ $ocorrencia->municipio_nome ?? '—' }}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="text-uppercase text-muted mb-1">Solicitante</div>
                            <div class="fw-semibold">{{ $ocorrencia->nome_solicitante ?: 'Não informado' }}</div>
                            <div class="text-muted">{{ $ocorrencia->telefone_solicitante ?: 'Sem telefone' }}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="text-uppercase text-muted mb-1">Registro</div>
                            <div class="fw-semibold">{{ $ocorrencia->dt_abertura_fmt }}</div>
                            <div class="text-muted">Por {{ $ocorrencia->usuario_nome_criacao ?: $ocorrencia->usuario_criacao ?: '—' }}</div>
                        </div>
                        <div class="col-12">
                            <div class="text-uppercase text-muted mb-1">Problema relatado</div>
                            <div class="border rounded p-3 bg-light-subtle">{{ $ocorrencia->descricao_problema }}</div>
                        </div>
                        @if(!empty($ocorrencia->descricao_resolucao))
                            <div class="col-12">
                                <div class="text-uppercase text-muted mb-1">Resolução informada</div>
                                <div class="border rounded p-3 bg-success-subtle">{{ $ocorrencia->descricao_resolucao }}</div>
                            </div>
                        @endif
                    </div>
                </div>
                <div class="card-footer bg-white d-flex justify-content-between">
                    <a href="{{ $backUrl ?? (($modoExterno ?? false) ? route($routeNames['painel_index']) : route('nat.ocorrencias.index')) }}" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left me-1"></i> Voltar
                    </a>
                    <a href="{{ $origem === 'nat_rotas_painel' && $backUrl ? $backUrl : route($routeNames['painel_index'], $painelParams) }}" class="btn btn-outline-primary btn-sm">
                        <i class="fa-solid fa-route me-1"></i> Ir para painel da rota
                    </a>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-white">
                    <h5 class="mb-0 text-primary"><i class="fa-solid fa-clock-rotate-left me-2"></i>Histórico</h5>
                </div>
                <div class="card-body">
                    @if(empty($eventos))
                        <p class="text-muted small mb-0">Nenhum evento registrado.</p>
                    @else
                        <div class="timeline d-flex flex-column gap-3">
                            @foreach($eventos as $evento)
                                <div class="border-start border-3 ps-3">
                                    <div class="small text-muted">{{ $evento['dt_evento_fmt'] }} · {{ $evento['usuario_nome_criacao'] ?: $evento['usuario_criacao'] ?: 'Sistema' }}</div>
                                    <div class="fw-semibold">{{ $evento['descricao'] ?: $evento['tipo_evento'] }}</div>
                                    @if(!empty($evento['status_anterior_nome']) || !empty($evento['status_novo_nome']))
                                        <div class="small text-muted">{{ $evento['status_anterior_nome'] ?: '—' }} → {{ $evento['status_novo_nome'] ?: '—' }}</div>
                                    @endif
                                </div>
                            @endforeach
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_NAT_OCORRENCIAS_SHOW_BLADE_PHP>

