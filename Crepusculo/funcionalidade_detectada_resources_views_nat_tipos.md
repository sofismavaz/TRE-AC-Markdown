# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_nat_tipos`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 6 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/tipos/form.blade.php`
## <RESOURCES_VIEWS_NAT_TIPOS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/tipos/form.blade.php`
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
@section('titulo', 'NAT - Tipo de Ocorrência')
@section('conteudo')
@if ($errors->any())<div class="alert alert-warning small"><ul class="mb-0 ps-3">@foreach ($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<div class="card shadow-sm"><div class="card-body"><h5 class="text-primary mb-3"><i class="fa-solid fa-screwdriver-wrench me-2"></i>{{ isset($tipo) ? 'Editar tipo de ocorrência' : 'Novo tipo de ocorrência' }}</h5><form method="POST" action="{{ isset($tipo) ? route('tabelas-auxiliares.nat-tipos-ocorrencia.update', $tipo->id_tipo_ocorrencia) : route('tabelas-auxiliares.nat-tipos-ocorrencia.store') }}" class="row g-3">@csrf @if(isset($tipo)) @method('PUT') @endif<div class="col-md-8"><label for="nome" class="form-label">Nome</label><input type="text" name="nome" id="nome" class="form-control" value="{{ old('nome', $tipo->nome ?? '') }}" required maxlength="120"></div><div class="col-md-4"><label for="ordem" class="form-label">Ordem</label><input type="number" name="ordem" id="ordem" class="form-control" value="{{ old('ordem', $tipo->ordem ?? 0) }}" min="0"></div><div class="col-12"><label for="descricao" class="form-label">Descrição</label><textarea name="descricao" id="descricao" rows="4" class="form-control" maxlength="500">{{ old('descricao', $tipo->descricao ?? '') }}</textarea></div><div class="col-12"><div class="form-check"><input type="checkbox" name="ativo" id="ativo" class="form-check-input" value="1" @checked(old('ativo', ($tipo->ativo ?? 'S') === 'S'))><label for="ativo" class="form-check-label">Tipo ativo</label></div></div><div class="col-12 d-flex gap-2"><button class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-1"></i> Salvar</button><a class="btn btn-outline-secondary" href="{{ route('tabelas-auxiliares.nat-tipos-ocorrencia.index') }}">Voltar</a></div></form></div></div>
@endsection
```
</RESOURCES_VIEWS_NAT_TIPOS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/tipos/index.blade.php`
## <RESOURCES_VIEWS_NAT_TIPOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/tipos/index.blade.php`
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
@section('titulo', 'NAT - Tipos de Ocorrência')
@section('conteudo')
@if (session('status'))<div class="alert alert-success d-flex align-items-center gap-2 small"><i class="fa-solid fa-circle-check"></i><span>{{ session('status') }}</span></div>@endif
@if ($errors->any())<div class="alert alert-warning small"><ul class="mb-0 ps-3">@foreach ($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<div class="card shadow-sm mb-3"><div class="card-body"><form method="GET" action="{{ route('tabelas-auxiliares.nat-tipos-ocorrencia.index') }}" class="row g-3 align-items-end"><div class="col-md-5"><label for="busca" class="form-label">Buscar</label><input type="text" id="busca" name="busca" value="{{ $busca }}" class="form-control" placeholder="Nome ou descrição"></div><div class="col-md-3"><label for="ativo" class="form-label">Status</label><select name="ativo" id="ativo" class="form-select"><option value="">Todos</option><option value="S" @selected($ativo === 'S')>Ativos</option><option value="N" @selected($ativo === 'N')>Inativos</option></select></div><div class="col-md-2"><button class="btn btn-primary w-100"><i class="fa-solid fa-filter me-1"></i> Filtrar</button></div><div class="col-md-2"><a class="btn btn-success w-100" href="{{ route('tabelas-auxiliares.nat-tipos-ocorrencia.form') }}"><i class="fa-solid fa-plus me-1"></i> Novo</a></div></form></div></div>
<div class="card shadow-sm"><div class="table-responsive"><table class="table table-striped table-hover align-middle mb-0"><thead class="table-light small text-uppercase"><tr><th style="width: 10%">Ordem</th><th>Nome</th><th>Descrição</th><th style="width: 12%">Status</th><th style="width: 16%" class="text-center">Ações</th></tr></thead><tbody>@forelse($tipos as $tipo)<tr><td>{{ $tipo->ordem }}</td><td>{{ $tipo->nome }}</td><td>{{ $tipo->descricao ?: '—' }}</td><td><span class="badge {{ ($tipo->ativo ?? 'N') === 'S' ? 'text-bg-success' : 'text-bg-secondary' }}">{{ ($tipo->ativo ?? 'N') === 'S' ? 'Ativo' : 'Inativo' }}</span></td><td class="text-center"><div class="btn-group btn-group-sm"><a class="btn btn-outline-secondary" href="{{ route('tabelas-auxiliares.nat-tipos-ocorrencia.form', $tipo->id_tipo_ocorrencia) }}"><i class="fa-solid fa-pen-to-square"></i></a><form method="POST" action="{{ route('tabelas-auxiliares.nat-tipos-ocorrencia.destroy', $tipo->id_tipo_ocorrencia) }}" onsubmit="return confirm('Confirma a exclusão deste tipo?');">@csrf @method('DELETE')<button class="btn btn-outline-danger"><i class="fa-solid fa-trash"></i></button></form></div></td></tr>@empty<tr><td colspan="5" class="text-center text-muted py-4">Nenhum tipo de ocorrência cadastrado.</td></tr>@endforelse</tbody></table></div>@if($tipos->hasPages())<div class="card-footer">{{ $tipos->links('pagination::bootstrap-5') }}</div>@endif</div>
@endsection
```
</RESOURCES_VIEWS_NAT_TIPOS_INDEX_BLADE_PHP>

