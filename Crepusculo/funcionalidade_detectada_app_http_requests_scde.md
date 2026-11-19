# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_requests_scde`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 3 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Scde/ScdeConfiguracaoFiltroRequest.php`
## <APP_HTTP_REQUESTS_SCDE_SCDECONFIGURACAOFILTROREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Scde/ScdeConfiguracaoFiltroRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Scde`
- **Entidade / Classe:** `class ScdeConfiguracaoFiltroRequest extends FormRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function authorize(): bool
public function rules(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Scde;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ScdeConfiguracaoFiltroRequest extends FormRequest
{
    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    /** @return array<string, list<mixed>> */
    public function rules(): array
    {
        return [
            'cod_pleito' => ['nullable', 'integer', 'min:1'],
            'cod_eleicao' => ['nullable', 'integer', 'min:1'],
            'ativo' => ['nullable', Rule::in(['0', '1', 0, 1])],
            'campos' => ['sometimes', 'array'],
            'campos.*' => ['string'],
        ];
    }
}
```
</APP_HTTP_REQUESTS_SCDE_SCDECONFIGURACAOFILTROREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Scde/ScdeConfiguracaoRequest.php`
## <APP_HTTP_REQUESTS_SCDE_SCDECONFIGURACAOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Scde/ScdeConfiguracaoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Scde`
- **Entidade / Classe:** `class ScdeConfiguracaoRequest extends FormRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function authorize(): bool
protected function prepareForValidation(): void
public function rules(): array
public function attributes(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Scde;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ScdeConfiguracaoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'cod_pleito' => trim((string) $this->input('cod_pleito', '')),
            'cod_eleicao' => trim((string) $this->input('cod_eleicao', '')),
        ]);
    }

    /** @return array<string, list<string>> */
    public function rules(): array
    {
        return [
            'cod_pleito' => [
                'required',
                'integer',
                'min:1',
                'max:999999999999999999',
                Rule::unique('SCDE_CONFIGURACAO', 'COD_PLEITO')
                    ->where(fn ($query) => $query->where('COD_ELEICAO', $this->input('cod_eleicao')))
                    ->ignore((int) $this->route('id', 0)),
            ],
            'cod_eleicao' => ['required', 'integer', 'min:1', 'max:999999999999999999'],
        ];
    }

    /** @return array<string, string> */
    public function attributes(): array
    {
        return [
            'cod_pleito' => 'código do pleito',
            'cod_eleicao' => 'código da eleição',
        ];
    }
}
```
</APP_HTTP_REQUESTS_SCDE_SCDECONFIGURACAOREQUEST_PHP>

