# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_support_access`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 2 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Access/EscopoZonal.php`
## <APP_SUPPORT_ACCESS_ESCOPOZONAL_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Access/EscopoZonal.php`
- **Namespace Declaração:** `App\Support\Access`
- **Entidade / Classe:** `final readonly class EscopoZonal`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
private function __construct(
public static function from(array $zonas, bool $acessoTodas): self
public function zonas(): array
public function acessoTodas(): bool
public function semAcesso(): bool
public function permite(int $zona): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Access;

final readonly class EscopoZonal
{
    /** @param list<int> $zonas */
    private function __construct(
        private array $zonas,
        private bool $acessoTodas,
    ) {}

    /** @param array<mixed> $zonas */
    public static function from(array $zonas, bool $acessoTodas): self
    {
        $normalizadas = [];

        foreach ($zonas as $zona) {
            if (! is_numeric($zona)) {
                continue;
            }

            $numero = (int) $zona;
            if ($numero < 0 || in_array($numero, $normalizadas, true)) {
                continue;
            }

            $normalizadas[] = $numero;
        }

        return new self(
            $normalizadas,
            $acessoTodas || in_array(0, $normalizadas, true),
        );
    }

    /** @return list<int> */
    public function zonas(): array
    {
        return $this->zonas;
    }

    public function acessoTodas(): bool
    {
        return $this->acessoTodas;
    }

    public function semAcesso(): bool
    {
        return ! $this->acessoTodas && $this->zonas === [];
    }

    public function permite(int $zona): bool
    {
        return $this->acessoTodas || in_array($zona, $this->zonas, true);
    }
}
```
</APP_SUPPORT_ACCESS_ESCOPOZONAL_PHP>

