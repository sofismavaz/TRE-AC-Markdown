# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_tests_support`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 17 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Support/PhpMethodDuplicateBaseline.php`
## <TESTS_SUPPORT_PHPMETHODDUPLICATEBASELINE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Support/PhpMethodDuplicateBaseline.php`
- **Namespace Declaração:** `Tests\Support`
- **Entidade / Classe:** `final class PhpMethodDuplicateBaseline`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function violations(array $groups, array $baseline, array $allowlist): array
private function validateAllowlist(array $groups, array $allowlist, array &$violations): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Support;

use DateTimeImmutable;

final class PhpMethodDuplicateBaseline
{
    /**
     * @param  array<string, array{hash: string, token_count: int, copies: int, methods: list<array{symbol: string, path: string, line: int}>}>  $groups
     * @param  array<string, mixed>  $baseline
     * @param  array<string, mixed>  $allowlist
     * @return list<string>
     */
    public function violations(array $groups, array $baseline, array $allowlist): array
    {
        $violations = [];
        $allowedHashes = $this->validateAllowlist($groups, $allowlist, $violations);

        if (($baseline['version'] ?? null) !== 1 || ! is_array($baseline['groups'] ?? null)) {
            $violations[] = 'Baseline de duplicacoes ausente ou com formato invalido.';

            return $violations;
        }

        $current = array_diff_key($groups, array_flip($allowedHashes));
        /** @var array<string, mixed> $expected */
        $expected = $baseline['groups'];

        foreach ($current as $hash => $group) {
            if (! isset($expected[$hash]) || ! is_array($expected[$hash])) {
                $violations[] = sprintf(
                    'Novo grupo de clone %s (%s).',
                    $hash,
                    implode(', ', array_column($group['methods'], 'symbol')),
                );
                continue;
            }

            $symbols = array_column($group['methods'], 'symbol');
            sort($symbols);
            $expectedSymbols = $expected[$hash]['symbols'] ?? [];
            if (is_array($expectedSymbols)) {
                sort($expectedSymbols);
            }

            if (($expected[$hash]['max_copies'] ?? null) !== $group['copies'] || $expectedSymbols !== $symbols) {
                $violations[] = sprintf(
                    'Grupo %s mudou de copias ou simbolos; atualize o baseline somente se a divida diminuiu.',
                    $hash,
                );
            }
        }

        foreach ($expected as $hash => $_group) {
            if (! isset($current[$hash])) {
                $violations[] = sprintf(
                    'Grupo %s desapareceu; remova-o do baseline no mesmo commit da reducao.',
                    $hash,
                );
            }
        }

        return $violations;
    }

    /**
     * @param  array<string, array{hash: string, token_count: int, copies: int, methods: list<array{symbol: string, path: string, line: int}>}>  $groups
     * @param  array<string, mixed>  $allowlist
     * @param  list<string>  $violations
     * @return list<string>
     */
    private function validateAllowlist(array $groups, array $allowlist, array &$violations): array
    {
        if (($allowlist['version'] ?? null) !== 1 || ! is_array($allowlist['entries'] ?? null)) {
            $violations[] = 'Allowlist de duplicacoes ausente ou com formato invalido.';

            return [];
        }

        $allowedHashes = [];

        foreach ($allowlist['entries'] as $position => $entry) {
            if (! is_array($entry)) {
                $violations[] = "Entrada {$position} da allowlist deve ser um objeto.";
                continue;
            }

            $requiredText = ['id', 'hash', 'justification', 'contract', 'owner', 'kind'];
            foreach ($requiredText as $field) {
                if (! is_string($entry[$field] ?? null) || trim($entry[$field]) === '') {
                    $violations[] = "Entrada {$position} da allowlist exige {$field}.";
                }
            }

            $hash = is_string($entry['hash'] ?? null) ? $entry['hash'] : '';
            $symbols = $entry['symbols'] ?? null;
            if (! preg_match('/^[a-f0-9]{64}$/', $hash)) {
                $violations[] = "Entrada {$position} da allowlist possui hash invalido.";
                continue;
            }
            if (! is_array($symbols) || count($symbols) < 2 || array_filter($symbols, 'is_string') !== $symbols) {
                $violations[] = "Entrada {$position} da allowlist exige ao menos dois simbolos.";
                continue;
            }
            if (! in_array($entry['kind'] ?? null, ['permanent', 'temporary'], true)) {
                $violations[] = "Entrada {$position} da allowlist possui kind invalido.";
            }
            if (($entry['kind'] ?? null) === 'temporary') {
                $expires = $entry['expires_on'] ?? null;
                $date = is_string($expires) ? DateTimeImmutable::createFromFormat('!Y-m-d', $expires) : false;
                if ($date === false || $date->format('Y-m-d') !== $expires) {
                    $violations[] = "Entrada {$position} temporaria exige expires_on em Y-m-d.";
                } elseif ($date < new DateTimeImmutable('today')) {
                    $violations[] = "Entrada {$position} temporaria esta expirada.";
                }
            }

            if (! isset($groups[$hash])) {
                $violations[] = "Entrada {$position} da allowlist nao corresponde a clone atual.";
                continue;
            }

            $currentSymbols = array_column($groups[$hash]['methods'], 'symbol');
            sort($currentSymbols);
            sort($symbols);
            if ($currentSymbols !== $symbols) {
                $violations[] = "Entrada {$position} da allowlist nao corresponde exatamente aos simbolos atuais.";
                continue;
            }

            $allowedHashes[] = $hash;
        }

        return $allowedHashes;
    }
}
```
</TESTS_SUPPORT_PHPMETHODDUPLICATEBASELINE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Support/PhpMethodDuplicateDetector.php`
## <TESTS_SUPPORT_PHPMETHODDUPLICATEDETECTOR_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Support/PhpMethodDuplicateDetector.php`
- **Namespace Declaração:** `Tests\Support`
- **Entidade / Classe:** `final class PhpMethodDuplicateDetector`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function scanDirectories(array $directories, int $minimumTokens = 60): array
public function scanFiles(array $files, int $minimumTokens = 60): array
private function extractMethods(string $source, string $file): array
private function readNamespace(array $tokens, int $start): string
private function nextMeaningfulTokenIndex(array $tokens, int $start): ?int
private function findBodyStart(array $tokens, int $start): ?int
private function findMatchingBrace(array $tokens, int $start): ?int
private function normalizeBody(array $tokens): array
private function displayPath(string $file): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Support;

use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use SplFileInfo;

final class PhpMethodDuplicateDetector
{
    /**
     * @param  list<string>  $directories
     * @return array<string, array{hash: string, token_count: int, copies: int, methods: list<array{symbol: string, path: string, line: int}>}>
     */
    public function scanDirectories(array $directories, int $minimumTokens = 60): array
    {
        $files = [];

        foreach ($directories as $directory) {
            if (! is_dir($directory)) {
                continue;
            }

            $iterator = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($directory, RecursiveDirectoryIterator::SKIP_DOTS),
            );

            /** @var SplFileInfo $file */
            foreach ($iterator as $file) {
                if ($file->isFile() && strtolower($file->getExtension()) === 'php') {
                    $files[] = $file->getPathname();
                }
            }
        }

        sort($files);

        return $this->scanFiles($files, $minimumTokens);
    }

    /**
     * @param  list<string>  $files
     * @return array<string, array{hash: string, token_count: int, copies: int, methods: list<array{symbol: string, path: string, line: int}>}>
     */
    public function scanFiles(array $files, int $minimumTokens = 60): array
    {
        $byHash = [];

        foreach ($files as $file) {
            if (! is_file($file)) {
                continue;
            }

            $source = file_get_contents($file);
            if ($source === false) {
                continue;
            }

            foreach ($this->extractMethods($source, $file) as $method) {
                if ($method['token_count'] < $minimumTokens) {
                    continue;
                }

                $hash = $method['hash'];
                $byHash[$hash] ??= [
                    'hash' => $hash,
                    'token_count' => $method['token_count'],
                    'copies' => 0,
                    'methods' => [],
                ];
                $byHash[$hash]['copies']++;
                $byHash[$hash]['methods'][] = [
                    'symbol' => $method['symbol'],
                    'path' => $method['path'],
                    'line' => $method['line'],
                ];
            }
        }

        $groups = array_filter(
            $byHash,
            static fn (array $group): bool => $group['copies'] >= 2,
        );

        foreach ($groups as &$group) {
            usort(
                $group['methods'],
                static fn (array $left, array $right): int => [$left['symbol'], $left['path'], $left['line']]
                    <=> [$right['symbol'], $right['path'], $right['line']],
            );
        }
        unset($group);

        ksort($groups);

        return $groups;
    }

    /**
     * @return list<array{hash: string, token_count: int, symbol: string, path: string, line: int}>
     */
    private function extractMethods(string $source, string $file): array
    {
        $tokens = token_get_all($source);
        $namespace = '';
        $braceDepth = 0;
        $pendingClass = null;
        $classStack = [];
        $methods = [];
        $count = count($tokens);

        for ($index = 0; $index < $count; $index++) {
            $token = $tokens[$index];

            if (is_array($token) && $token[0] === T_NAMESPACE) {
                $namespace = $this->readNamespace($tokens, $index + 1);
                continue;
            }

            if (is_array($token) && in_array($token[0], [T_CLASS, T_TRAIT, T_INTERFACE, T_ENUM], true)) {
                $nameIndex = $this->nextMeaningfulTokenIndex($tokens, $index + 1);
                if ($nameIndex !== null && is_array($tokens[$nameIndex]) && $tokens[$nameIndex][0] === T_STRING) {
                    $pendingClass = $tokens[$nameIndex][1];
                }
                continue;
            }

            if ($token === '{') {
                $braceDepth++;
                if ($pendingClass !== null) {
                    $classStack[] = ['name' => $pendingClass, 'depth' => $braceDepth];
                    $pendingClass = null;
                }
                continue;
            }

            if ($token === '}') {
                $last = array_key_last($classStack);
                if ($last !== null && $classStack[$last]['depth'] === $braceDepth) {
                    array_pop($classStack);
                }
                $braceDepth--;
                continue;
            }

            if (! is_array($token) || $token[0] !== T_FUNCTION || $classStack === []) {
                continue;
            }

            $nameIndex = $this->nextMeaningfulTokenIndex($tokens, $index + 1);
            if ($nameIndex !== null && $tokens[$nameIndex] === '&') {
                $nameIndex = $this->nextMeaningfulTokenIndex($tokens, $nameIndex + 1);
            }

            if ($nameIndex === null || ! is_array($tokens[$nameIndex]) || $tokens[$nameIndex][0] !== T_STRING) {
                continue;
            }

            $bodyStart = $this->findBodyStart($tokens, $nameIndex + 1);
            if ($bodyStart === null || $tokens[$bodyStart] !== '{') {
                continue;
            }

            $bodyEnd = $this->findMatchingBrace($tokens, $bodyStart);
            if ($bodyEnd === null) {
                continue;
            }

            $normalized = $this->normalizeBody(array_slice($tokens, $bodyStart + 1, $bodyEnd - $bodyStart - 1));
            $class = $classStack[array_key_last($classStack)]['name'];
            $qualifiedClass = ltrim($namespace.'\\'.$class, '\\');

            $methods[] = [
                'hash' => hash('sha256', implode("\x1f", $normalized)),
                'token_count' => count($normalized),
                'symbol' => $qualifiedClass.'::'.$tokens[$nameIndex][1],
                'path' => $this->displayPath($file),
                'line' => $token[2],
            ];

            $index = $bodyEnd;
        }

        return $methods;
    }

    /** @param array<int, array{0: int, 1: string, 2: int}|string> $tokens */
    private function readNamespace(array $tokens, int $start): string
    {
        $namespace = '';

        for ($index = $start, $count = count($tokens); $index < $count; $index++) {
            $token = $tokens[$index];
            if ($token === ';' || $token === '{') {
                break;
            }
            if (is_array($token) && in_array($token[0], [T_STRING, T_NAME_QUALIFIED, T_NS_SEPARATOR], true)) {
                $namespace .= $token[1];
            }
        }

        return trim($namespace, '\\');
    }

    /**
     * @param  array<int, array{0: int, 1: string, 2: int}|string>  $tokens
     */
    private function nextMeaningfulTokenIndex(array $tokens, int $start): ?int
    {
        for ($index = $start, $count = count($tokens); $index < $count; $index++) {
            $token = $tokens[$index];
            if (! is_array($token) || ! in_array($token[0], [T_WHITESPACE, T_COMMENT, T_DOC_COMMENT], true)) {
                return $index;
            }
        }

        return null;
    }

    /**
     * @param  array<int, array{0: int, 1: string, 2: int}|string>  $tokens
     */
    private function findBodyStart(array $tokens, int $start): ?int
    {
        for ($index = $start, $count = count($tokens); $index < $count; $index++) {
            if ($tokens[$index] === '{' || $tokens[$index] === ';') {
                return $index;
            }
        }

        return null;
    }

    /**
     * @param  array<int, array{0: int, 1: string, 2: int}|string>  $tokens
     */
    private function findMatchingBrace(array $tokens, int $start): ?int
    {
        $depth = 0;

        for ($index = $start, $count = count($tokens); $index < $count; $index++) {
            if ($tokens[$index] === '{') {
                $depth++;
            } elseif ($tokens[$index] === '}') {
                $depth--;
                if ($depth === 0) {
                    return $index;
                }
            }
        }

        return null;
    }

    /**
     * @param  array<int, array{0: int, 1: string, 2: int}|string>  $tokens
     * @return list<string>
     */
    private function normalizeBody(array $tokens): array
    {
        $normalized = [];
        $variables = [];

        foreach ($tokens as $token) {
            if (is_array($token)) {
                [$id, $text] = $token;
                if (in_array($id, [T_WHITESPACE, T_COMMENT, T_DOC_COMMENT], true)) {
                    continue;
                }

                if ($id === T_VARIABLE) {
                    if ($text === '$this' || str_starts_with($text, '$_')) {
                        $value = strtolower($text);
                    } else {
                        $variables[$text] ??= '$v'.(count($variables) + 1);
                        $value = $variables[$text];
                    }
                    $normalized[] = token_name($id).':'.$value;
                    continue;
                }

                if (in_array($id, [T_STRING, T_NAME_QUALIFIED, T_NAME_FULLY_QUALIFIED, T_NAME_RELATIVE], true)) {
                    $normalized[] = token_name($id).':'.strtolower($text);
                    continue;
                }

                if (in_array($id, [T_LNUMBER, T_DNUMBER, T_CONSTANT_ENCAPSED_STRING, T_ENCAPSED_AND_WHITESPACE], true)) {
                    $normalized[] = token_name($id).':'.$text;
                    continue;
                }

                $normalized[] = token_name($id);
                continue;
            }

            $normalized[] = $token;
        }

        return $normalized;
    }

    private function displayPath(string $file): string
    {
        $real = realpath($file) ?: $file;
        $root = rtrim((string) getcwd(), DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR;

        return str_starts_with($real, $root) ? substr($real, strlen($root)) : $real;
    }
}
```
</TESTS_SUPPORT_PHPMETHODDUPLICATEDETECTOR_PHP>

