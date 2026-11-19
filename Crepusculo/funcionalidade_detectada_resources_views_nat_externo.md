# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_nat_externo`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 3 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/nat/externo/validar.blade.php`
## <RESOURCES_VIEWS_NAT_EXTERNO_VALIDAR_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/nat/externo/validar.blade.php`
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
@extends('layouts.nat-externo-publico')

@section('titulo', 'NAT Externo - Validar Codigo')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success small">{{ session('status') }}</div>
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
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-white border-0 pt-4 px-4">
                    <h1 class="h4 mb-1 text-primary">Validar acesso externo</h1>
                    <p class="text-muted small mb-0">Confirme o codigo recebido por e-mail.</p>
                </div>
                <div class="card-body px-4 pb-4">
                    <p class="text-muted small">
                        @if ($email !== '')
                            Informe o codigo enviado para <strong>{{ $email }}</strong>.
                        @else
                            Informe o codigo recebido por e-mail.
                        @endif
                    </p>

                    <form method="POST" action="{{ route('nat.externo.acesso.validar.store') }}" class="row g-3">
                        @csrf
                        <input type="hidden" name="email" value="{{ old('email', $email) }}">

                        <div class="col-12">
                            <label for="codigo" class="form-label">Codigo</label>
                            <input
                                type="text"
                                name="codigo"
                                id="codigo"
                                class="form-control"
                                maxlength="6"
                                inputmode="numeric"
                                value="{{ old('codigo') }}"
                                required
                            >
                        </div>

                        <div class="col-12 d-flex justify-content-between">
                            <a href="{{ route('nat.externo.acesso.form', ['email' => $email]) }}" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i> Voltar
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fa-solid fa-key me-1"></i> Validar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_NAT_EXTERNO_VALIDAR_BLADE_PHP>

