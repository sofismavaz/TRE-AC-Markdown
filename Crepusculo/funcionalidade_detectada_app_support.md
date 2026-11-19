# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_support`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 3 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Support/DateHelper.php`
## <APP_SUPPORT_DATEHELPER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/DateHelper.php`
- **Namespace Declaração:** `App\Support`
- **Entidade / Classe:** `class DateHelper`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function normalizarDataHora(?string $valor): ?string
public static function normalizarData(?string $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support;

class DateHelper
{
    public static function normalizarDataHora(?string $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        $valor = str_replace(' ', 'T', $valor);

        if (strpos($valor, 'T') === false) {
            $valor .= 'T00:00';
        } else {
            $time = substr($valor, strpos($valor, 'T') + 1);
            if (strpos($time, ':') === false) {
                $valor .= ':00';
            }
        }

        return $valor;
    }

    public static function normalizarData(?string $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        $valor = str_replace('T', ' ', $valor);

        $formatos = [
            'Y-m-d',
            'Y-m-d H:i',
            'Y-m-d H:i:s',
            'd/m/Y',
            'd/m/Y H:i',
            'd/m/Y H:i:s',
        ];

        foreach ($formatos as $formato) {
            $data = \DateTime::createFromFormat($formato, $valor);
            if ($data instanceof \DateTime) {
                return $data->format('Y-m-d');
            }
        }

        return $valor;
    }
}
```
</APP_SUPPORT_DATEHELPER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/EscopoUnidade.php`
## <APP_SUPPORT_ESCOPOUNIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/EscopoUnidade.php`
- **Namespace Declaração:** `App\Support`
- **Entidade / Classe:** `class EscopoUnidade`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public static function irrestrito(): self
public static function restrito(array $unidades): self
public function isIrrestrito(): bool
public function isBloqueado(): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support;

class EscopoUnidade
{
    /**
     * @param array<int> $unidades
     */
    public function __construct(
        public readonly bool $aplicaEscopo,
        public readonly array $unidades
    ) {
    }

    public static function irrestrito(): self
    {
        return new self(false, []);
    }

    /**
     * @param array<int> $unidades
     */
    public static function restrito(array $unidades): self
    {
        return new self(true, $unidades);
    }

    public function isIrrestrito(): bool
    {
        return !$this->aplicaEscopo;
    }

    public function isBloqueado(): bool
    {
        return $this->aplicaEscopo && empty($this->unidades);
    }
}
```
</APP_SUPPORT_ESCOPOUNIDADE_PHP>

