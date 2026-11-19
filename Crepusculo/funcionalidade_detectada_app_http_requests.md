# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_requests`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 3 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/CodigoDescricaoOrdemAtivoRequest.php`
## <APP_HTTP_REQUESTS_CODIGODESCRICAOORDEMATIVOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/CodigoDescricaoOrdemAtivoRequest.php`
- **Namespace Declaração:** `App\Http\Requests`
- **Entidade / Classe:** `abstract class CodigoDescricaoOrdemAtivoRequest extends FormRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
abstract protected function tabela(): string;
abstract protected function contextoMensagens(): array;
public function authorize(): bool
public function rules(): array
protected function prepareForValidation(): void
public function messages(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

abstract class CodigoDescricaoOrdemAtivoRequest extends FormRequest
{
    abstract protected function tabela(): string;

    /** @return array{complemento:string, entidade:string} */
    abstract protected function contextoMensagens(): array;

    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        $id = (int) ($this->route('id') ?? 0);
        $tabela = $this->tabela();

        return [
            'codigo' => [
                'required',
                'string',
                'max:20',
                'regex:/^[A-Z0-9_]+$/',
                Rule::unique($tabela, 'codigo')->ignore($id, 'id'),
            ],
            'descricao' => [
                'required',
                'string',
                'max:160',
                Rule::unique($tabela, 'descricao')->ignore($id, 'id'),
            ],
            'ordem' => ['required', 'integer', 'min:0'],
            'ativo' => ['nullable', 'boolean'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $dados = [
            'codigo' => mb_strtoupper(trim((string) $this->input('codigo', '')), 'UTF-8'),
            'descricao' => trim((string) $this->input('descricao', '')),
            'ordem' => (int) $this->input('ordem', 0),
        ];
        if ($this->has('ativo')) {
            $dados['ativo'] = $this->boolean('ativo');
        }

        $this->merge($dados);
    }

    /** @return array<string, string> */
    public function messages(): array
    {
        $contexto = $this->contextoMensagens();

        return [
            'codigo.required' => 'Informe o código estável '.$contexto['complemento'].'.',
            'codigo.regex' => 'O código deve conter apenas letras maiúsculas, números e underline.',
            'codigo.unique' => 'Já existe '.$contexto['entidade'].' com este código.',
            'descricao.required' => 'Informe a descrição '.$contexto['complemento'].'.',
            'descricao.unique' => 'Já existe '.$contexto['entidade'].' com esta descrição.',
            'ordem.required' => 'Informe a ordem '.$contexto['complemento'].'.',
        ];
    }
}
```
</APP_HTTP_REQUESTS_CODIGODESCRICAOORDEMATIVOREQUEST_PHP>

