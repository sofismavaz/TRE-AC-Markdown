# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_nat_monitoramento`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 4 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/monitoramento/index.blade.php`
## <RESOURCES_VIEWS_NAT_MONITORAMENTO_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/monitoramento/index.blade.php`
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

@section('titulo', 'NAT - Monitoramento')

@section('conteudo')
    <div class="row g-3 mb-3">
        @foreach(['ATRIBUIDA' => 'Atribuídas', 'EM_ANDAMENTO' => 'Em andamento', 'FINALIZADA' => 'Finalizadas'] as $codigo => $titulo)
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        <div class="small text-uppercase text-muted mb-1">{{ $titulo }}</div>
                        <div class="display-6 fw-semibold">{{ $totaisStatus[$codigo]['total'] ?? 0 }}</div>
                    </div>
                </div>
            </div>
        @endforeach
    </div>

    <div class="card shadow-sm mb-3">
        <div class="card-body">
            <form method="GET" action="{{ route('nat.monitoramento.index') }}" class="row g-3 align-items-end">
                <div class="col-lg-3">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" name="busca" id="busca" class="form-control" value="{{ $filtros['busca'] }}" placeholder="Local, município ou descrição">
                </div>
                <div class="col-lg-2">
                    <label for="status" class="form-label">Status</label>
                    <select name="status" id="status" class="form-select">
                        @include('nat.partials.status-filter-options', ['statusSelecionado' => $filtros['status']])
                    </select>
                </div>
                <div class="col-lg-3">
                    <label for="tipo" class="form-label">Tipo</label>
                    <select name="tipo" id="tipo" class="form-select">
                        <option value="">Todos</option>
                        @foreach($tipos as $tipo)
                            <option value="{{ $tipo['id_tipo_ocorrencia'] }}" @selected((string) $filtros['tipo'] === (string) $tipo['id_tipo_ocorrencia'])>{{ $tipo['nome'] }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-lg-2">
                    <label for="rota_id" class="form-label">Rota</label>
                    <select name="rota_id" id="rota_id" class="form-select">
                        <option value="">Todas</option>
                        @foreach($rotas as $rota)
                            <option value="{{ $rota['id'] }}" @selected((string) $filtros['rota_id'] === (string) $rota['id'])>Rota #{{ $rota['numero'] }} - {{ $rota['descricao'] }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-lg-2 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('nat.monitoramento.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0 text-primary"><i class="fa-solid fa-chart-line me-2"></i>Painel geral</h5>
            <a href="{{ route('nat.rotas.index') }}" class="btn btn-outline-primary btn-sm">
                <i class="fa-solid fa-route me-1"></i> Painel da rota
            </a>
        </div>
        <div class="card-body p-0">
            @include('nat.partials.ocorrencias-table', ['ocorrencias' => $ocorrencias, 'mostrarAcoesRota' => false])
        </div>
        @if($ocorrencias->hasPages())
            <div class="card-footer">{{ $ocorrencias->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_NAT_MONITORAMENTO_INDEX_BLADE_PHP>

