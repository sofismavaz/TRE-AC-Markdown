# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_nat_ocorrencias_partials`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 8 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/ocorrencias/partials/detalhes-lazy.blade.php`
## <RESOURCES_VIEWS_NAT_OCORRENCIAS_PARTIALS_DETALHES_LAZY_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/ocorrencias/partials/detalhes-lazy.blade.php`
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
<div class="p-3 bg-light border-top">
    <div class="row g-3">
        <div class="col-lg-7">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h6 class="mb-0 text-primary"><i class="fa-solid fa-file-circle-exclamation me-2"></i>Detalhes complementares</h6>
                    @include('nat.partials.status-badge', ['codigo' => $ocorrencia->status_codigo, 'label' => $ocorrencia->status_nome])
                </div>
                <div class="card-body">
                    <div class="row g-3 small">
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
                        @if(!empty($ocorrencia->descricao_resolucao))
                            <div class="col-12">
                                <div class="text-uppercase text-muted mb-1">Resolução informada</div>
                                <div class="border rounded p-3 bg-success-subtle">{{ $ocorrencia->descricao_resolucao }}</div>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-white">
                    <h6 class="mb-0 text-primary"><i class="fa-solid fa-clock-rotate-left me-2"></i>Histórico</h6>
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
</div>
```
</RESOURCES_VIEWS_NAT_OCORRENCIAS_PARTIALS_DETALHES_LAZY_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/ocorrencias/partials/mapa-detalhes-modal.blade.php`
## <RESOURCES_VIEWS_NAT_OCORRENCIAS_PARTIALS_MAPA_DETALHES_MODAL_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/ocorrencias/partials/mapa-detalhes-modal.blade.php`
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
        'ocorrencia_assumir' => 'nat.rotas.assumir',
        'ocorrencia_finalizar' => 'nat.rotas.finalizar',
    ], $routeNames ?? []);
@endphp

@if(empty($ocorrencias))
    <div class="alert alert-secondary mb-0 small">Nenhuma ocorrência NAT não finalizada encontrada para este local nesta rota.</div>
@else
    <div class="d-flex flex-column gap-3">
        @foreach($ocorrencias as $ocorrencia)
            <div class="card shadow-sm" data-nat-mapa-local data-local-id="{{ $codObjetoLocalVotacao }}">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <div>
                        <div class="fw-semibold">Ocorrência #{{ $ocorrencia['id_ocorrencia'] }} · {{ $ocorrencia['tipo_nome'] }}</div>
                        <div class="small text-muted">Local {{ $ocorrencia['local_numero'] ?? '—' }} · Seção {{ $ocorrencia['num_secao'] }}</div>
                    </div>
                    @include('nat.partials.status-badge', ['codigo' => $ocorrencia['status_codigo'], 'label' => $ocorrencia['status_nome']])
                </div>
                <div class="card-body">
                    <div class="small text-muted mb-2">Abertura: {{ $ocorrencia['dt_abertura_fmt'] }} · {{ $ocorrencia['municipio_nome'] ?? '—' }} · Zona {{ $ocorrencia['zona_numero'] ?? '—' }}</div>
                    <div class="border rounded p-3 bg-light-subtle small">{{ $ocorrencia['descricao_problema'] }}</div>

                    @if(($ocorrencia['status_codigo'] ?? '') === 'ATRIBUIDA')
                        <form method="POST" action="{{ route($routeNames['ocorrencia_assumir'], $ocorrencia['id_ocorrencia']) }}" class="mt-3" data-nat-mapa-action-form>
                            @csrf
                            <input type="hidden" name="rota_id" value="{{ $ocorrencia['rota_id'] }}">
                            <button class="btn btn-primary btn-sm">
                                <i class="fa-solid fa-play me-1"></i> Assumir ocorrência
                            </button>
                        </form>
                    @endif

                    @if(($ocorrencia['status_codigo'] ?? '') === 'EM_ANDAMENTO')
                        <form method="POST" action="{{ route($routeNames['ocorrencia_finalizar'], $ocorrencia['id_ocorrencia']) }}" class="mt-3" data-nat-mapa-action-form>
                            @csrf
                            <input type="hidden" name="status_destino" value="FINALIZADA">
                            <input type="hidden" name="rota_id" value="{{ $ocorrencia['rota_id'] }}">
                            <label for="nat_mapa_resolucao_{{ $ocorrencia['id_ocorrencia'] }}" class="form-label small fw-semibold">Descreva a solução</label>
                            <textarea id="nat_mapa_resolucao_{{ $ocorrencia['id_ocorrencia'] }}" name="descricao_resolucao" class="form-control form-control-sm" rows="4" placeholder="Descreva a resolução da ocorrência" required></textarea>
                            <div class="d-flex justify-content-end mt-2">
                                <button class="btn btn-success btn-sm">
                                    <i class="fa-solid fa-circle-check me-1"></i> Finalizar ocorrência
                                </button>
                            </div>
                        </form>
                    @endif
                </div>
            </div>
        @endforeach
    </div>
@endif
```
</RESOURCES_VIEWS_NAT_OCORRENCIAS_PARTIALS_MAPA_DETALHES_MODAL_BLADE_PHP>

