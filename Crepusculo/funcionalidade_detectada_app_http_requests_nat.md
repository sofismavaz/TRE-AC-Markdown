# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_requests_nat`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 5  
> **Tamanho do Arquivo:** 7 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Nat/NatAbrirOcorrenciaRequest.php`
## <APP_HTTP_REQUESTS_NAT_NATABRIROCORRENCIAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Nat/NatAbrirOcorrenciaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Nat`
- **Entidade / Classe:** `class NatAbrirOcorrenciaRequest extends FormRequest`

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
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Nat;

use App\Rules\TelefoneRule;
use App\Support\Validation\TelefoneBrasileiro;
use Illuminate\Foundation\Http\FormRequest;

class NatAbrirOcorrenciaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'origem' => ['nullable', 'string', 'max:100'],
            'back_url' => ['nullable', 'string', 'max:2048'],
            'cod_objeto_local_votacao' => ['required', 'string', 'max:18'],
            'num_secao' => ['required', 'string', 'max:20'],
            'id_tipo_ocorrencia' => ['required', 'integer', 'min:1'],
            'rota_id' => ['nullable', 'integer', 'min:1'],
            'descricao_problema' => ['required', 'string', 'max:2000'],
            'nome_solicitante' => ['nullable', 'string', 'max:160'],
            'telefone_solicitante' => ['nullable', new TelefoneRule()],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'telefone_solicitante' => TelefoneBrasileiro::prepararEntrada($this->input('telefone_solicitante')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_NAT_NATABRIROCORRENCIAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Nat/NatAtualizarStatusRequest.php`
## <APP_HTTP_REQUESTS_NAT_NATATUALIZARSTATUSREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Nat/NatAtualizarStatusRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Nat`
- **Entidade / Classe:** `class NatAtualizarStatusRequest extends FormRequest`

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

namespace App\Http\Requests\Nat;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class NatAtualizarStatusRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status_destino' => ['required', 'string', Rule::in(['EM_ANDAMENTO', 'FINALIZADA'])],
            'descricao_resolucao' => ['nullable', 'string', 'max:2000'],
            'rota_id' => ['nullable', 'integer', 'min:1'],
        ];
    }
}
```
</APP_HTTP_REQUESTS_NAT_NATATUALIZARSTATUSREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Nat/NatExternoEnviarCodigoRequest.php`
## <APP_HTTP_REQUESTS_NAT_NATEXTERNOENVIARCODIGOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Nat/NatExternoEnviarCodigoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Nat`
- **Entidade / Classe:** `class NatExternoEnviarCodigoRequest extends FormRequest`

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

namespace App\Http\Requests\Nat;

use Illuminate\Foundation\Http\FormRequest;

class NatExternoEnviarCodigoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'email' => ['required', 'email:rfc', 'max:255'],
        ];
    }
}
```
</APP_HTTP_REQUESTS_NAT_NATEXTERNOENVIARCODIGOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Nat/NatExternoValidarCodigoRequest.php`
## <APP_HTTP_REQUESTS_NAT_NATEXTERNOVALIDARCODIGOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Nat/NatExternoValidarCodigoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Nat`
- **Entidade / Classe:** `class NatExternoValidarCodigoRequest extends FormRequest`

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

namespace App\Http\Requests\Nat;

use Illuminate\Foundation\Http\FormRequest;

class NatExternoValidarCodigoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'email' => ['required', 'email:rfc', 'max:255'],
            'codigo' => ['required', 'string', 'size:6'],
        ];
    }
}
```
</APP_HTTP_REQUESTS_NAT_NATEXTERNOVALIDARCODIGOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Nat/NatTipoOcorrenciaRequest.php`
## <APP_HTTP_REQUESTS_NAT_NATTIPOOCORRENCIAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Nat/NatTipoOcorrenciaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Nat`
- **Entidade / Classe:** `class NatTipoOcorrenciaRequest extends FormRequest`

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
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Nat;

use Illuminate\Foundation\Http\FormRequest;

class NatTipoOcorrenciaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nome' => ['required', 'string', 'max:120'],
            'descricao' => ['nullable', 'string', 'max:500'],
            'ordem' => ['nullable', 'integer', 'min:0'],
            'ativo' => ['nullable', 'boolean'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'ordem' => $this->filled('ordem') ? (int) $this->input('ordem') : 0,
            'ativo' => $this->has('ativo') ? $this->boolean('ativo') : true,
        ]);
    }
}
```
</APP_HTTP_REQUESTS_NAT_NATTIPOOCORRENCIAREQUEST_PHP>

