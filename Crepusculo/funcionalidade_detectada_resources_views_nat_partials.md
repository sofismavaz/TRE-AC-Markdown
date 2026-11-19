# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_nat_partials`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 3  
> **Tamanho do Arquivo:** 13 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/partials/ocorrencias-table.blade.php`
## <RESOURCES_VIEWS_NAT_PARTIALS_OCORRENCIAS_TABLE_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/partials/ocorrencias-table.blade.php`
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
@php
    $routeNames = array_merge([
        'painel_index' => 'nat.rotas.index',
        'ocorrencia_show' => 'nat.ocorrencias.show',
        'ocorrencia_assumir' => 'nat.rotas.assumir',
        'ocorrencia_finalizar' => 'nat.rotas.finalizar',
    ], $routeNames ?? []);
@endphp

<div class="table-responsive">
    <table class="table table-striped table-hover align-middle mb-0">
        <thead class="table-light small text-uppercase">
        <tr>
            <th>Ocorrência</th>
            <th style="width: 22%">Ações</th>
        </tr>
        </thead>
        <tbody>
        @forelse($ocorrencias as $ocorrencia)
            <tr>
                <td>
                    <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                        <div class="fw-semibold">#{{ $ocorrencia->id_ocorrencia }} · {{ $ocorrencia->tipo_nome }}</div>
                        @include('nat.partials.status-badge', ['codigo' => $ocorrencia->status_codigo, 'label' => $ocorrencia->status_nome])
                    </div>
                    <div class="small"><span class="fw-semibold">Rota {{ $ocorrencia->rota_numero }}</span></div>
                    <div class="small text-muted">Zona {{ $ocorrencia->zona_numero ?? '—' }} · {{ $ocorrencia->municipio_nome ?? '—' }}</div>
                    <div class="small text-muted">{{ $ocorrencia->local_nome ?? 'Local não localizado' }} @if(!empty($ocorrencia->local_numero)) · Local {{ $ocorrencia->local_numero }} @endif · Seção {{ $ocorrencia->num_secao }}</div>
                    <div class="small mt-1">{{ $ocorrencia->descricao_problema }}</div>
                    <div class="small text-muted mt-1">Abertura: {{ $ocorrencia->dt_abertura_fmt }}</div>
                </td>
                <td>
                    <div class="d-flex flex-wrap gap-2">
                        <button
                            type="button"
                            class="btn btn-outline-primary btn-sm"
                            data-nat-ocorrencia-detalhes-botao
                            data-url="{{ route($routeNames['ocorrencia_show'], $ocorrencia->id_ocorrencia) }}"
                            data-ocorrencia-id="{{ $ocorrencia->id_ocorrencia }}"
                        >
                            <i class="fa-solid fa-eye me-1"></i> Detalhes
                        </button>
                        @if(($mostrarAcoesRota ?? false) === true)
                            @php($painelMapaParams = ($modoExterno ?? false) === true ? ['aba' => 'mapa'] : ['aba' => 'mapa', 'rotas' => [$ocorrencia->rota_id]])
                            <a class="btn btn-outline-danger btn-sm" href="{{ route($routeNames['painel_index'], $painelMapaParams) }}" title="Ver rota no mapa">
                                <i class="fa-solid fa-map-location-dot me-1"></i> Ver no mapa
                            </a>
                        @endif
                        @if(($mostrarAcoesRota ?? false) === true && $ocorrencia->status_codigo === 'ATRIBUIDA')
                            <form method="POST" action="{{ route($routeNames['ocorrencia_assumir'], $ocorrencia->id_ocorrencia) }}">
                                @csrf
                                <input type="hidden" name="rota_id" value="{{ $ocorrencia->rota_id }}">
                                <button class="btn btn-primary btn-sm"><i class="fa-solid fa-play me-1"></i> Assumir</button>
                            </form>
                        @endif
                    </div>
                    @if(($mostrarAcoesRota ?? false) === true && $ocorrencia->status_codigo === 'EM_ANDAMENTO')
                        @php($modalFinalizarId = 'nat-ocorrencia-finalizar-' . $ocorrencia->id_ocorrencia)
                        <button
                            type="button"
                            class="btn btn-success btn-sm mt-2"
                            data-bs-toggle="modal"
                            data-bs-target="#{{ $modalFinalizarId }}"
                        >
                            <i class="fa-solid fa-circle-check me-1"></i> Finalizar
                        </button>
                    @endif
                </td>
            </tr>
        @empty
            <tr><td colspan="2" class="text-center text-muted py-4">Nenhuma ocorrência encontrada.</td></tr>
        @endforelse
        </tbody>
    </table>
</div>

<div class="modal fade" id="natOcorrenciaDetalhesModal" tabindex="-1" aria-labelledby="natOcorrenciaDetalhesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="natOcorrenciaDetalhesModalLabel">Detalhes da ocorrência</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
            </div>
            <div class="modal-body" id="natOcorrenciaDetalhesModalBody">
                <div class="text-muted small">Selecione uma ocorrência para carregar os detalhes.</div>
            </div>
        </div>
    </div>
</div>

@foreach($ocorrencias as $ocorrencia)
    @if(($mostrarAcoesRota ?? false) === true && $ocorrencia->status_codigo === 'EM_ANDAMENTO')
        @php($modalFinalizarId = 'nat-ocorrencia-finalizar-' . $ocorrencia->id_ocorrencia)
        <div class="modal fade" id="{{ $modalFinalizarId }}" tabindex="-1" aria-labelledby="{{ $modalFinalizarId }}-label" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <form method="POST" action="{{ route($routeNames['ocorrencia_finalizar'], $ocorrencia->id_ocorrencia) }}">
                        @csrf
                        <input type="hidden" name="status_destino" value="FINALIZADA">
                        <input type="hidden" name="rota_id" value="{{ $ocorrencia->rota_id }}">

                        <div class="modal-header">
                            <h5 class="modal-title" id="{{ $modalFinalizarId }}-label">Finalizar ocorrência #{{ $ocorrencia->id_ocorrencia }}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                        </div>

                        <div class="modal-body">
                            <div class="small text-muted mb-3">
                                {{ $ocorrencia->local_nome ?? 'Local não localizado' }}
                                @if(!empty($ocorrencia->local_numero)) · Local {{ $ocorrencia->local_numero }} @endif
                                · Seção {{ $ocorrencia->num_secao }}
                            </div>
                            <label for="descricao_resolucao_{{ $ocorrencia->id_ocorrencia }}" class="form-label">Descreva a solução</label>
                            <textarea
                                id="descricao_resolucao_{{ $ocorrencia->id_ocorrencia }}"
                                name="descricao_resolucao"
                                class="form-control"
                                rows="6"
                                placeholder="Descreva a resolução da ocorrência"
                                required
                            ></textarea>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button class="btn btn-success"><i class="fa-solid fa-circle-check me-1"></i> Confirmar finalização</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    @endif
@endforeach

@once
    @push('scripts')
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var modalElement = document.getElementById('natOcorrenciaDetalhesModal');
                var modalBody = document.getElementById('natOcorrenciaDetalhesModalBody');
                var modalTitle = document.getElementById('natOcorrenciaDetalhesModalLabel');

                document.addEventListener('click', function (event) {
                    var button = event.target.closest('[data-nat-ocorrencia-detalhes-botao]');
                    if (!button || !modalElement || !modalBody || !window.bootstrap || !window.bootstrap.Modal) {
                        return;
                    }

                    var url = button.dataset.url || '';
                    if (!url) {
                        return;
                    }

                    event.preventDefault();
                    if (modalTitle) {
                        var ocorrenciaId = button.dataset.ocorrenciaId || '';
                        modalTitle.textContent = ocorrenciaId ? 'Detalhes da ocorrência #' + ocorrenciaId : 'Detalhes da ocorrência';
                    }

                    modalBody.innerHTML = '<div class="text-muted small">Carregando detalhes da ocorrência…</div>';
                    window.bootstrap.Modal.getOrCreateInstance(modalElement).show();

                    fetch(url, {
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest',
                            'Accept': 'application/json'
                        }
                    })
                        .then(function (response) {
                            if (!response.ok) {
                                throw new Error('Falha ao carregar detalhes.');
                            }
                            return response.json();
                        })
                        .then(function (payload) {
                            modalBody.innerHTML = payload.html || '<div class="alert alert-warning py-2 px-3 mb-0 small">Detalhes não disponíveis para esta ocorrência.</div>';
                        })
                        .catch(function () {
                            modalBody.innerHTML = '<div class="alert alert-danger py-2 px-3 mb-0 small">Não foi possível carregar os detalhes da ocorrência.</div>';
                        });
                });
            });
        </script>
    @endpush
@endonce
```
</RESOURCES_VIEWS_NAT_PARTIALS_OCORRENCIAS_TABLE_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/partials/status-badge.blade.php`
## <RESOURCES_VIEWS_NAT_PARTIALS_STATUS_BADGE_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/partials/status-badge.blade.php`
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
@php
    $codigo = strtoupper((string) ($codigo ?? ''));
    $classes = match ($codigo) {
        'ATRIBUIDA' => 'text-bg-primary',
        'EM_ANDAMENTO' => 'text-bg-warning',
        'FINALIZADA' => 'text-bg-success',
        default => 'text-bg-secondary',
    };
@endphp

<span class="badge {{ $classes }}">{{ $label ?? $codigo }}</span>
```
</RESOURCES_VIEWS_NAT_PARTIALS_STATUS_BADGE_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/partials/status-filter-options.blade.php`
## <RESOURCES_VIEWS_NAT_PARTIALS_STATUS_FILTER_OPTIONS_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/partials/status-filter-options.blade.php`
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
@php
    $statusSelecionado = (string) ($statusSelecionado ?? '');
    $exibirOpcaoTodos = ($exibirOpcaoTodos ?? true) === true;
@endphp

@if($exibirOpcaoTodos)
    <option value="TODOS" @selected($statusSelecionado === '')>Todos</option>
@endif
<option value="NAO_FINALIZADA" @selected($statusSelecionado === 'NAO_FINALIZADA')>Não finalizadas</option>
<option value="ATRIBUIDA" @selected($statusSelecionado === 'ATRIBUIDA')>Atribuída</option>
<option value="EM_ANDAMENTO" @selected($statusSelecionado === 'EM_ANDAMENTO')>Em andamento</option>
<option value="FINALIZADA" @selected($statusSelecionado === 'FINALIZADA')>Finalizada</option>
```
</RESOURCES_VIEWS_NAT_PARTIALS_STATUS_FILTER_OPTIONS_BLADE_PHP>

