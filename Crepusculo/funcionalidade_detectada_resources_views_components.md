# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_resources_views_components`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 2 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `resources/views/components/arquivos-multiplos.blade.php`
## <RESOURCES_VIEWS_COMPONENTS_ARQUIVOS_MULTIPLOS_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/components/arquivos-multiplos.blade.php`
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
@props([
    'id',
    'name',
    'accept' => null,
    'required' => false,
    'compacto' => false,
])

<div data-arquivos-multiplos>
    <input
        id="{{ $id }}"
        type="file"
        name="{{ $name }}"
        class="form-control{{ $compacto ? ' form-control-sm' : '' }}"
        @if ($accept !== null && $accept !== '') accept="{{ $accept }}" @endif
        multiple
        @required($required)
        data-arquivos-multiplos-input
    >
    <div class="table-responsive border rounded mt-2 d-none" data-arquivos-multiplos-tabela>
        <table class="table table-sm align-middle mb-0">
            <caption class="visually-hidden">Arquivos selecionados para envio</caption>
            <thead class="table-light">
                <tr>
                    <th scope="col">Arquivo</th>
                    <th scope="col" class="text-nowrap">Tamanho</th>
                    <th scope="col" class="text-end">Ações</th>
                </tr>
            </thead>
            <tbody data-arquivos-multiplos-corpo></tbody>
        </table>
    </div>
    <div class="form-text" aria-live="polite" data-arquivos-multiplos-resumo>
        Nenhum arquivo selecionado. Use o campo acima para adicionar arquivos.
    </div>
</div>

@once
    @push('scripts')
        <script src="{{ asset('js/shared/arquivos-multiplos.js') }}?v={{ @filemtime(public_path('js/shared/arquivos-multiplos.js')) }}"></script>
    @endpush
@endonce
```
</RESOURCES_VIEWS_COMPONENTS_ARQUIVOS_MULTIPLOS_BLADE_PHP>

