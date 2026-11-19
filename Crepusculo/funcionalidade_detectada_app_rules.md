# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_rules`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 4  
> **Tamanho do Arquivo:** 5 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Rules/CoordinateRule.php`
## <APP_RULES_COORDINATERULE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Rules/CoordinateRule.php`
- **Namespace Declaração:** `App\Rules`
- **Entidade / Classe:** `abstract class CoordinateRule implements ValidationRule`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(string $campo, float $min, float $max, int $minLength = 5)
public function validate(string $attribute, mixed $value, Closure $fail): void
private function mensagem(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

abstract class CoordinateRule implements ValidationRule
{
    protected string $campo;
    protected float $min;
    protected float $max;
    protected int $minLength;

    public function __construct(string $campo, float $min, float $max, int $minLength = 5)
    {
        $this->campo = $campo;
        $this->min = $min;
        $this->max = $max;
        $this->minLength = $minLength;
    }

    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($value === null) {
            return;
        }

        $texto = trim((string) $value);
        if ($texto === '') {
            return;
        }

        if (!is_numeric($texto)) {
            $fail($this->mensagem());
            return;
        }

        $numero = (float) $texto;
        if ($numero < $this->min || $numero > $this->max) {
            $fail($this->mensagem());
            return;
        }

        if (strlen($texto) < $this->minLength) {
            $fail($this->mensagem());
        }
    }

    private function mensagem(): string
    {
        return sprintf('Informe uma %s válida.', $this->campo);
    }
}
```
</APP_RULES_COORDINATERULE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Rules/CpfRule.php`
## <APP_RULES_CPFRULE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Rules/CpfRule.php`
- **Namespace Declaração:** `App\Rules`
- **Entidade / Classe:** `class CpfRule implements ValidationRule`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function validate(string $attribute, mixed $value, Closure $fail): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Rules;

use App\Support\Validation\Cpf;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class CpfRule implements ValidationRule
{
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($value !== null && $value !== '' && ! Cpf::valido($value)) {
            $fail('CPF inválido.');
        }
    }
}
```
</APP_RULES_CPFRULE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Rules/LatitudeRule.php`
## <APP_RULES_LATITUDERULE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Rules/LatitudeRule.php`
- **Namespace Declaração:** `App\Rules`
- **Entidade / Classe:** `class LatitudeRule extends CoordinateRule`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct()
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Rules;

class LatitudeRule extends CoordinateRule
{
    public function __construct()
    {
        parent::__construct('latitude', -90, 90);
    }
}
```
</APP_RULES_LATITUDERULE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Rules/LongitudeRule.php`
## <APP_RULES_LONGITUDERULE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Rules/LongitudeRule.php`
- **Namespace Declaração:** `App\Rules`
- **Entidade / Classe:** `class LongitudeRule extends CoordinateRule`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct()
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Rules;

class LongitudeRule extends CoordinateRule
{
    public function __construct()
    {
        parent::__construct('longitude', -180, 180);
    }
}
```
</APP_RULES_LONGITUDERULE_PHP>

