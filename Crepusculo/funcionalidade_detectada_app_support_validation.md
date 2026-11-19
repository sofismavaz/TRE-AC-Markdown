# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_support_validation`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 5 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Validation/Cpf.php`
## <APP_SUPPORT_VALIDATION_CPF_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Validation/Cpf.php`
- **Namespace Declaração:** `App\Support\Validation`
- **Entidade / Classe:** `final class Cpf`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function mascarar(mixed $valor): string
public static function normalizar(mixed $valor): ?string
public static function formatoPermitido(mixed $valor): bool
public static function prepararEntrada(mixed $valor): mixed
public static function valido(mixed $valor): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Validation;

final class Cpf
{
    public static function mascarar(mixed $valor): string
    {
        $cpf = self::normalizar($valor);
        if ($cpf === null || strlen($cpf) !== 11) {
            return 'CPF indisponível';
        }

        return '***.***.***-'.substr($cpf, -2);
    }

    public static function normalizar(mixed $valor): ?string
    {
        if (! self::formatoPermitido($valor)) {
            return null;
        }

        $digitos = preg_replace('/\D/', '', trim((string) $valor)) ?? '';

        return $digitos === '' ? null : $digitos;
    }

    public static function formatoPermitido(mixed $valor): bool
    {
        if (! is_string($valor) && ! is_numeric($valor)) {
            return false;
        }

        $texto = trim((string) $valor);

        return preg_match('/^(?:\d{11}|\d{3}\.\d{3}\.\d{3}-\d{2})$/', $texto) === 1;
    }

    public static function prepararEntrada(mixed $valor): mixed
    {
        if ($valor === null) {
            return null;
        }

        if (! is_string($valor) && ! is_numeric($valor)) {
            return $valor;
        }

        return self::normalizar($valor) ?? trim((string) $valor);
    }

    public static function valido(mixed $valor): bool
    {
        $cpf = self::normalizar($valor);
        if ($cpf === null || preg_match('/^(\d)\1{10}$/', $cpf) === 1) {
            return false;
        }

        for ($tamanhoBase = 9; $tamanhoBase <= 10; $tamanhoBase++) {
            $soma = 0;
            for ($indice = 0; $indice < $tamanhoBase; $indice++) {
                $soma += ((int) $cpf[$indice]) * (($tamanhoBase + 1) - $indice);
            }

            $resto = ($soma * 10) % 11;
            $digito = $resto === 10 ? 0 : $resto;
            if ($digito !== (int) $cpf[$tamanhoBase]) {
                return false;
            }
        }

        return true;
    }
}
```
</APP_SUPPORT_VALIDATION_CPF_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Validation/DataIso.php`
## <APP_SUPPORT_VALIDATION_DATAISO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Validation/DataIso.php`
- **Namespace Declaração:** `App\Support\Validation`
- **Entidade / Classe:** `final class DataIso`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function data(mixed $valor): ?CarbonImmutable
public static function dataHoraLocal(mixed $valor): ?CarbonImmutable
public static function normalizarDataHoraLocal(mixed $valor): ?string
private static function interpretar(mixed $valor, string $formato, string $comparacao): ?CarbonImmutable
private static function texto(mixed $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Validation;

use Carbon\CarbonImmutable;
use Throwable;

final class DataIso
{
    public static function data(mixed $valor): ?CarbonImmutable
    {
        return self::interpretar($valor, '!Y-m-d', 'Y-m-d');
    }

    public static function dataHoraLocal(mixed $valor): ?CarbonImmutable
    {
        $texto = self::texto($valor);
        if ($texto === null) {
            return null;
        }

        $formato = strlen($texto) === 16 ? '!Y-m-d\TH:i' : '!Y-m-d\TH:i:s';
        $comparacao = strlen($texto) === 16 ? 'Y-m-d\TH:i' : 'Y-m-d\TH:i:s';

        return self::interpretar($texto, $formato, $comparacao);
    }

    public static function normalizarDataHoraLocal(mixed $valor): ?string
    {
        return self::dataHoraLocal($valor)?->format('Y-m-d H:i:s');
    }

    private static function interpretar(mixed $valor, string $formato, string $comparacao): ?CarbonImmutable
    {
        $texto = self::texto($valor);
        if ($texto === null) {
            return null;
        }

        try {
            $data = CarbonImmutable::createFromFormat($formato, $texto);

            return $data instanceof CarbonImmutable && $data->format($comparacao) === $texto
                ? $data
                : null;
        } catch (Throwable) {
            return null;
        }
    }

    private static function texto(mixed $valor): ?string
    {
        if (! is_string($valor) && ! is_numeric($valor)) {
            return null;
        }

        $texto = trim((string) $valor);

        return $texto === '' ? null : $texto;
    }
}
```
</APP_SUPPORT_VALIDATION_DATAISO_PHP>

