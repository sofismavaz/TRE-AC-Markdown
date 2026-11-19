# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_tests_unit_architecture`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 6  
> **Tamanho do Arquivo:** 36 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/ModuleNamespaceArchitectureTest.php`
## <TESTS_UNIT_ARCHITECTURE_MODULENAMESPACEARCHITECTURETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/ModuleNamespaceArchitectureTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture`
- **Entidade / Classe:** `class ModuleNamespaceArchitectureTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_classes_dos_modulos_migrados_nao_permanecem_na_raiz_das_camadas(): void
public function test_caminho_e_namespace_dos_modulos_migrados_sao_coerentes(string $modulo): void
public function test_aliases_de_classe_sao_proibidos_fora_da_janela_de_compatibilidade(): void
public static function modulosMigrados(): array
private function arquivoPertenceAoModulo(string $arquivo, string $modulo): bool
private function projectRoot(): string
private function appRoot(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture;

use FilesystemIterator;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use SplFileInfo;

class ModuleNamespaceArchitectureTest extends TestCase
{
    /** @var array<int, string> */
    private const MODULOS_MIGRADOS = [
        'Acesso',
        'AcessibilidadeEleitoral',
        'CalendarioEleitoral',
        'CadastroEleitoral',
        'Auditoria',
        'ColaboradoresEleitorais',
        'ConvocacaoSms',
        'Diarias',
        'DisqueEleicao',
        'ForcasSeguranca',
        'Gel',
        'Lda',
        'LocaisVotacao',
        'MesarioPublico',
        'Nat',
        'Planejamento',
        'Rcand',
        'Riscos',
        'Scde',
        'SeuVotoImporta',
        'SupervisoresPredio',
        'TabelasAuxiliares',
        'Tarefas',
        'Treinamentos',
    ];

    /**
     * A propriedade e semantica: prefixos cobrem o padrao nominal e arquivos
     * registram as excecoes cujo nome comeca por uma acao tecnica.
     *
     * @var array<string, array{prefixos: array<int, string>, arquivos: array<int, string>}>
     */
    private const PROPRIEDADE = [
        'Acesso' => [
            'prefixos' => ['Acesso'],
            'arquivos' => [],
        ],
        'AcessibilidadeEleitoral' => [
            'prefixos' => ['AcessibilidadeEleitoral'],
            'arquivos' => [],
        ],
        'Auditoria' => [
            'prefixos' => ['AuditLog'],
            'arquivos' => [],
        ],
        'CadastroEleitoral' => [
            'prefixos' => ['CadastroEleitoral'],
            'arquivos' => [],
        ],
        'CalendarioEleitoral' => [
            'prefixos' => ['CalendarioEleitoral'],
            'arquivos' => [],
        ],
        'ColaboradoresEleitorais' => [
            'prefixos' => [
                'Candidatura',
                'ColaboradorEleitoral',
                'ColaboradoresEleitorais',
                'CoordenadorAcessibilidade',
                'DesistenciaCandidatura',
                'EnviarEmailDecisaoCandidatura',
                'EventoVoluntario',
                'GerarPdfVoluntariosExternos',
                'InscricaoConflitoPeriodo',
                'MesarioConvocadoEfetivo',
                'MesarioFuncaoEleitoral',
                'MesariosConvocados',
                'ProcessoEleitoral',
                'RelatorioInscricoesDeferidas',
                'Voluntario',
                'VoluntariosExternos',
            ],
            'arquivos' => [],
        ],
        'ConvocacaoSms' => [
            'prefixos' => [
                'ConvocacaoSms',
                'EnviarConvocacaoSms',
                'Sms',
                'TextBeeSms',
                'ZenviaSms',
            ],
            'arquivos' => [],
        ],
        'Diarias' => [
            'prefixos' => [
                'ApiDiarias',
                'Diarias',
                'GeoNames',
                'MockDiarias',
            ],
            'arquivos' => [
                'BackfillDiariasProrrogacoesIntegraisCommand.php',
                'ExcluirDiariasSolicitacaoCorrecaoCommand.php',
            ],
        ],
        'DisqueEleicao' => [
            'prefixos' => ['DisqueEleicao'],
            'arquivos' => [
                'StoreDisqueEleicaoAtendimentoRequest.php',
                'UpdateDisqueEleicaoAtendimentoRequest.php',
            ],
        ],
        'ForcasSeguranca' => [
            'prefixos' => ['ForcasSeguranca'],
            'arquivos' => [
                'RedirectIfForcasSegurancaExternalAuthenticated.php',
                'RequireForcasSegurancaExternalSession.php',
            ],
        ],
        'Gel' => [
            'prefixos' => ['Gel'],
            'arquivos' => [],
        ],
        'Lda' => [
            'prefixos' => [
                'AbstractEquipeVinculo',
                'CargoEquipe',
                'Consolidacao',
                'Equipe',
                'GlpiApi',
                'Lda',
                'LocalDificilAcesso',
                'LocalTransmissao',
                'RecursoLogistico',
                'Rota',
                'SecaoFisicaLocal',
                'TransmissaoPreferencia',
                'UrnaContingencia',
                'VistoriaTransmissao',
                'VoluntarioRotaDistribuicao',
            ],
            'arquivos' => [
                'AtribuirUrnasContingenciaLdaCommand.php',
                'RedistribuirVoluntariosRotasSuporteCommand.php',
                'SincronizarEnderecosLdaLocalVotacaoCommand.php',
                'SincronizarNomesLdaLocalVotacaoCommand.php',
            ],
        ],
        'LocaisVotacao' => [
            'prefixos' => [
                'DashboardLocaisVotacao',
                'LocalDeVotacao',
                'LocalVotacao',
                'MrjApresentacao',
                'SecaoAlocacaoProvisoria',
                'SecaoAptosConsolidados',
                'TrajetoLocalVotacao',
            ],
            'arquivos' => [],
        ],
        'MesarioPublico' => [
            'prefixos' => [
                'MesarioAcessoPublico',
                'MesarioConvocacao',
                'MesarioMonitoramentoLocal',
                'MesarioOcorrenciaPublica',
                'MesarioPublico',
                'MesarioSituacao',
            ],
            'arquivos' => [
                'RedirectIfMesarioPublicAuthenticated.php',
                'RedirectMesarioLdaParaSituacao.php',
                'RequireMesarioLdaSituacao.php',
                'RequireMesarioPublicSession.php',
            ],
        ],
        'Nat' => [
            'prefixos' => ['Nat'],
            'arquivos' => [
                'RedirectIfNatExternalAuthenticated.php',
                'RequireNatExternalSession.php',
            ],
        ],
        'Planejamento' => [
            'prefixos' => [
                'GrupoUnidade',
                'Macroprojeto',
                'Planejamento',
                'Projeto',
                'Subprojeto',
            ],
            'arquivos' => [],
        ],
        'Rcand' => [
            'prefixos' => ['Rcand'],
            'arquivos' => [],
        ],
        'Riscos' => [
            'prefixos' => ['Risco'],
            'arquivos' => [
                'ImportarRiscosAnexo3683109Command.php',
            ],
        ],
        'Scde' => [
            'prefixos' => ['Scde'],
            'arquivos' => [],
        ],
        'SeuVotoImporta' => [
            'prefixos' => ['SeuVotoImporta', 'EnviarCodigoSeuVotoImporta'],
            'arquivos' => [
                'RequireSeuVotoImportaPublicSession.php',
            ],
        ],
        'SupervisoresPredio' => [
            'prefixos' => [
                'CadastroSupervisorPredio',
                'EnviarEmailCadastroSupervisorPredio',
                'SupervisorPredio',
            ],
            'arquivos' => [],
        ],
        'TabelasAuxiliares' => [
            'prefixos' => [
                'Energia',
                'Esfera',
                'Internet',
                'Municipio',
                'OpcaoBinaria',
                'Operadora',
                'Qualidade',
                'TipoSinal',
                'TipoTomada',
                'Zona',
            ],
            'arquivos' => [],
        ],
        'Tarefas' => [
            'prefixos' => [
                'CategoriaTarefa',
                'EnviarAlertaTarefas',
                'FaseTarefa',
                'Tarefa',
            ],
            'arquivos' => [
                'AgendarAlertaRequest.php',
                'NotificacaoAtrasoRequest.php',
            ],
        ],
        'Treinamentos' => [
            'prefixos' => ['Treinamento'],
            'arquivos' => [],
        ],
    ];

    /** @var array<int, string> */
    private const CAMADAS = [
        'Console/Commands',
        'Exceptions',
        'Exports',
        'Http/Controllers',
        'Http/Middleware',
        'Http/Requests',
        'Jobs',
        'Mail',
        'Presenters',
        'Repositories',
        'Services',
        'Support',
    ];

    /**
     * Aliases sao proibidos, exceto jobs temporarios nominalmente registrados
     * durante a janela de compatibilidade de filas.
     *
     * @var array<int, string>
     */
    private const ALIASES_TEMPORARIOS = [];

    public function test_classes_dos_modulos_migrados_nao_permanecem_na_raiz_das_camadas(): void
    {
        $violacoes = [];

        $raizesLegadas = array_merge(self::CAMADAS, [
            'Repositories/Contracts',
            'Repositories/Queries',
            'Support/Exportacao',
        ]);

        foreach ($raizesLegadas as $camada) {
            $diretorio = $this->appRoot().DIRECTORY_SEPARATOR.$camada;
            if (! is_dir($diretorio)) {
                continue;
            }

            foreach (new FilesystemIterator($diretorio, FilesystemIterator::SKIP_DOTS) as $arquivo) {
                if (! $arquivo->isFile() || $arquivo->getExtension() !== 'php') {
                    continue;
                }

                $caminhoRelativo = $camada.'/'.$arquivo->getFilename();
                if (in_array($caminhoRelativo, self::ALIASES_TEMPORARIOS, true)) {
                    continue;
                }

                foreach (self::MODULOS_MIGRADOS as $modulo) {
                    if ($this->arquivoPertenceAoModulo($arquivo->getFilename(), $modulo)) {
                        $camadaDestino = str_contains($camada, '/')
                            && in_array($camada, ['Repositories/Contracts', 'Repositories/Queries', 'Support/Exportacao'], true)
                                ? strstr($camada, '/', true)
                                : $camada;
                        $violacoes[] = $camada.'/'.$arquivo->getFilename()
                            .' deveria estar em '.$camadaDestino.'/'.$modulo;
                    }
                }
            }
        }

        sort($violacoes);
        $this->assertSame([], $violacoes, implode("\n", $violacoes));
    }

    #[DataProvider('modulosMigrados')]
    public function test_caminho_e_namespace_dos_modulos_migrados_sao_coerentes(string $modulo): void
    {
        $arquivosEncontrados = 0;
        $violacoes = [];

        foreach (self::CAMADAS as $camada) {
            $diretorio = $this->appRoot().DIRECTORY_SEPARATOR.$camada.DIRECTORY_SEPARATOR.$modulo;
            if (! is_dir($diretorio)) {
                continue;
            }

            $arquivos = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($diretorio, FilesystemIterator::SKIP_DOTS)
            );

            /** @var SplFileInfo $arquivo */
            foreach ($arquivos as $arquivo) {
                if ($arquivo->getExtension() !== 'php') {
                    continue;
                }

                $arquivosEncontrados++;
                $relativo = str_replace($this->appRoot().DIRECTORY_SEPARATOR, '', $arquivo->getPath());
                $namespaceEsperado = 'App\\'.str_replace(DIRECTORY_SEPARATOR, '\\', $relativo);
                $conteudo = (string) file_get_contents($arquivo->getPathname());

                if (preg_match('/^namespace\s+([^;]+);/m', $conteudo, $match) !== 1
                    || trim($match[1]) !== $namespaceEsperado) {
                    $violacoes[] = str_replace($this->projectRoot().DIRECTORY_SEPARATOR, '', $arquivo->getPathname())
                        .' deve declarar namespace '.$namespaceEsperado;
                }
            }
        }

        $this->assertGreaterThan(0, $arquivosEncontrados, 'Modulo migrado sem arquivos: '.$modulo);
        $this->assertSame([], $violacoes, implode("\n", $violacoes));
    }

    public function test_aliases_de_classe_sao_proibidos_fora_da_janela_de_compatibilidade(): void
    {
        $aliases = [];
        $arquivos = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($this->appRoot(), FilesystemIterator::SKIP_DOTS)
        );

        /** @var SplFileInfo $arquivo */
        foreach ($arquivos as $arquivo) {
            if ($arquivo->getExtension() !== 'php') {
                continue;
            }

            $conteudo = (string) file_get_contents($arquivo->getPathname());
            if (preg_match('/\bclass_alias\s*\(/', $conteudo) === 1) {
                $aliases[] = str_replace($this->appRoot().DIRECTORY_SEPARATOR, '', $arquivo->getPathname());
            }
        }

        sort($aliases);
        $esperados = self::ALIASES_TEMPORARIOS;
        sort($esperados);
        $this->assertSame($esperados, $aliases);
    }

    /** @return array<string, array{string}> */
    public static function modulosMigrados(): array
    {
        $casos = [];
        foreach (self::MODULOS_MIGRADOS as $modulo) {
            $casos[$modulo] = [$modulo];
        }

        return $casos;
    }

    private function arquivoPertenceAoModulo(string $arquivo, string $modulo): bool
    {
        $propriedade = self::PROPRIEDADE[$modulo];
        if (in_array($arquivo, $propriedade['arquivos'], true)) {
            return true;
        }

        foreach ($propriedade['prefixos'] as $prefixo) {
            if (str_starts_with($arquivo, $prefixo)) {
                return true;
            }
        }

        return false;
    }

    private function projectRoot(): string
    {
        return dirname(__DIR__, 3);
    }

    private function appRoot(): string
    {
        return $this->projectRoot().DIRECTORY_SEPARATOR.'app';
    }
}
```
</TESTS_UNIT_ARCHITECTURE_MODULENAMESPACEARCHITECTURETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/PhpMethodDuplicateArchitectureTest.php`
## <TESTS_UNIT_ARCHITECTURE_PHPMETHODDUPLICATEARCHITECTURETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/PhpMethodDuplicateArchitectureTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture`
- **Entidade / Classe:** `class PhpMethodDuplicateArchitectureTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aplicacao_nao_aumenta_grupos_de_metodos_duplicados(): void
private function json(string $path): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture;

use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;
use Tests\Support\PhpMethodDuplicateBaseline;
use Tests\Support\PhpMethodDuplicateDetector;

class PhpMethodDuplicateArchitectureTest extends TestCase
{
    #[Test]
    public function aplicacao_nao_aumenta_grupos_de_metodos_duplicados(): void
    {
        $root = dirname(__DIR__, 3);
        $baseline = $this->json($root.'/tests/Unit/Architecture/baselines/php-method-duplicates.json');
        $allowlist = $this->json($root.'/tests/Unit/Architecture/baselines/php-method-duplicate-allowlist.json');
        $minimumTokens = $baseline['minimum_tokens'] ?? null;

        $this->assertSame(60, $minimumTokens, 'O limite arquitetural de clones deve permanecer em 60 tokens.');

        $groups = (new PhpMethodDuplicateDetector)->scanDirectories([$root.'/app'], $minimumTokens);
        $violations = (new PhpMethodDuplicateBaseline)->violations($groups, $baseline, $allowlist);

        $this->assertSame([], $violations, implode(PHP_EOL, $violations));
    }

    /** @return array<string, mixed> */
    private function json(string $path): array
    {
        $contents = file_get_contents($path);
        $this->assertNotFalse($contents, "Nao foi possivel ler {$path}.");
        $decoded = json_decode($contents, true, flags: JSON_THROW_ON_ERROR);
        $this->assertIsArray($decoded);

        return $decoded;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_PHPMETHODDUPLICATEARCHITECTURETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/PhpMethodDuplicateDetectorTest.php`
## <TESTS_UNIT_ARCHITECTURE_PHPMETHODDUPLICATEDETECTORTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/PhpMethodDuplicateDetectorTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture`
- **Entidade / Classe:** `class PhpMethodDuplicateDetectorTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function detecta_clones_normalizados_por_tokens_e_ignora_comentarios_e_nomes_de_variavel(): void
public function calcular(int $valor): int
public function calcular(int $entrada): int
public function ignora_closures_e_metodos_abaixo_do_limite(): void
public function um(): int { return 1; }
public function dois(): int { return 1; }
public function closure(): callable
public function baseline_rejeita_novo_grupo_nova_copia_e_divida_removida_sem_atualizacao(): void
public function allowlist_exige_metadados_e_correspondencia_exata_dos_simbolos(): void
private function php(string $conteudo): string
private function allowlistVazia(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture;

use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;
use Tests\Support\PhpMethodDuplicateBaseline;
use Tests\Support\PhpMethodDuplicateDetector;

class PhpMethodDuplicateDetectorTest extends TestCase
{
    /** @var list<string> */
    private array $temporarios = [];

    protected function tearDown(): void
    {
        foreach ($this->temporarios as $arquivo) {
            @unlink($arquivo);
        }

        parent::tearDown();
    }

    #[Test]
    public function detecta_clones_normalizados_por_tokens_e_ignora_comentarios_e_nomes_de_variavel(): void
    {
        $arquivoA = $this->php(<<<'PHP'
            <?php
            namespace Exemplo;
            final class Primeiro
            {
                public function calcular(int $valor): int
                {
                    // comentario que nao participa do clone
                    $total = $valor + 1;
                    $total = $total * 2;
                    $total = $total - 3;
                    return $total;
                }
            }
            PHP);
        $arquivoB = $this->php(<<<'PHP'
            <?php
            namespace Exemplo;
            final class Segundo
            {
                public function calcular(int $entrada): int
                {
                    $resultado = $entrada + 1;

                    $resultado = $resultado * 2;
                    $resultado = $resultado - 3;
                    return $resultado;
                }
            }
            PHP);

        $grupos = (new PhpMethodDuplicateDetector)->scanFiles([$arquivoA, $arquivoB], 8);

        $this->assertCount(1, $grupos);
        $grupo = array_values($grupos)[0];
        $this->assertSame(2, $grupo['copies']);
        $this->assertSame(
            ['Exemplo\\Primeiro::calcular', 'Exemplo\\Segundo::calcular'],
            array_column($grupo['methods'], 'symbol'),
        );
    }

    #[Test]
    public function ignora_closures_e_metodos_abaixo_do_limite(): void
    {
        $arquivo = $this->php(<<<'PHP'
            <?php
            final class Curto
            {
                public function um(): int { return 1; }
                public function dois(): int { return 1; }

                public function closure(): callable
                {
                    return function (int $valor): int {
                        $valor = $valor + 1;
                        $valor = $valor * 2;
                        return $valor;
                    };
                }
            }
            PHP);

        $grupos = (new PhpMethodDuplicateDetector)->scanFiles([$arquivo], 8);

        $this->assertSame([], $grupos);
    }

    #[Test]
    public function baseline_rejeita_novo_grupo_nova_copia_e_divida_removida_sem_atualizacao(): void
    {
        $grupo = [
            'hash' => str_repeat('a', 64),
            'token_count' => 80,
            'copies' => 2,
            'methods' => [
                ['symbol' => 'A::metodo', 'path' => 'app/A.php', 'line' => 10],
                ['symbol' => 'B::metodo', 'path' => 'app/B.php', 'line' => 10],
            ],
        ];
        $baseline = [
            'version' => 1,
            'minimum_tokens' => 60,
            'groups' => [],
        ];

        $comparador = new PhpMethodDuplicateBaseline;

        $this->assertNotEmpty($comparador->violations([$grupo['hash'] => $grupo], $baseline, $this->allowlistVazia()));

        $baseline['groups'][$grupo['hash']] = [
            'max_copies' => 2,
            'symbols' => ['A::metodo', 'B::metodo'],
        ];
        $this->assertSame([], $comparador->violations([$grupo['hash'] => $grupo], $baseline, $this->allowlistVazia()));

        $grupo['copies'] = 3;
        $grupo['methods'][] = ['symbol' => 'C::metodo', 'path' => 'app/C.php', 'line' => 10];
        $this->assertNotEmpty($comparador->violations([$grupo['hash'] => $grupo], $baseline, $this->allowlistVazia()));

        $this->assertNotEmpty($comparador->violations([], $baseline, $this->allowlistVazia()));
    }

    #[Test]
    public function allowlist_exige_metadados_e_correspondencia_exata_dos_simbolos(): void
    {
        $hash = str_repeat('b', 64);
        $grupo = [
            'hash' => $hash,
            'token_count' => 80,
            'copies' => 2,
            'methods' => [
                ['symbol' => 'A::metodo', 'path' => 'app/A.php', 'line' => 10],
                ['symbol' => 'B::metodo', 'path' => 'app/B.php', 'line' => 10],
            ],
        ];
        $allowlist = [
            'version' => 1,
            'entries' => [[
                'id' => 'clone-intencional',
                'hash' => $hash,
                'symbols' => ['A::metodo', 'B::metodo'],
                'justification' => '',
                'contract' => 'docs/contratos/exemplo.md',
                'owner' => 'Area funcional',
                'kind' => 'permanent',
            ]],
        ];

        $violacoes = (new PhpMethodDuplicateBaseline)->violations(
            [$hash => $grupo],
            ['version' => 1, 'minimum_tokens' => 60, 'groups' => []],
            $allowlist,
        );

        $this->assertNotEmpty($violacoes);
    }

    private function php(string $conteudo): string
    {
        $arquivo = tempnam(sys_get_temp_dir(), 'planeleito-clone-');
        $this->assertNotFalse($arquivo);
        file_put_contents($arquivo, $conteudo);
        $this->temporarios[] = $arquivo;

        return $arquivo;
    }

    /** @return array{version: int, entries: array<mixed>} */
    private function allowlistVazia(): array
    {
        return ['version' => 1, 'entries' => []];
    }
}
```
</TESTS_UNIT_ARCHITECTURE_PHPMETHODDUPLICATEDETECTORTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/PhpUnitEnvironmentIsolationTest.php`
## <TESTS_UNIT_ARCHITECTURE_PHPUNITENVIRONMENTISOLATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/PhpUnitEnvironmentIsolationTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture`
- **Entidade / Classe:** `class PhpUnitEnvironmentIsolationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_suites_usam_caches_e_log_exclusivos_de_teste(): void
public function test_scripts_de_teste_nao_limpam_caches_da_aplicacao(): void
private function assertEnvironmentVariables(string $arquivo, array $esperadas): void
private function basePath(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture;

use PHPUnit\Framework\TestCase;

class PhpUnitEnvironmentIsolationTest extends TestCase
{
    public function test_suites_usam_caches_e_log_exclusivos_de_teste(): void
    {
        $this->assertEnvironmentVariables('phpunit.xml', [
            'APP_CONFIG_CACHE' => 'bootstrap/cache/config-phpunit.php',
            'APP_ROUTES_CACHE' => 'bootstrap/cache/routes-phpunit.php',
            'LOG_CHANNEL' => 'null',
        ]);
        $this->assertEnvironmentVariables('phpunit.oracle-readonly.xml', [
            'APP_CONFIG_CACHE' => 'bootstrap/cache/config-oracle-readonly.php',
            'APP_ROUTES_CACHE' => 'bootstrap/cache/routes-oracle-readonly.php',
            'LOG_CHANNEL' => 'null',
        ]);
    }

    public function test_scripts_de_teste_nao_limpam_caches_da_aplicacao(): void
    {
        $composer = json_decode(
            (string) file_get_contents($this->basePath('composer.json')),
            true,
            flags: JSON_THROW_ON_ERROR,
        );

        foreach (['test', 'test:architecture', 'test:oracle-readonly'] as $script) {
            $comandos = implode("\n", $composer['scripts'][$script] ?? []);

            $this->assertStringNotContainsString('config:clear', $comandos, $script);
            $this->assertStringNotContainsString('route:clear', $comandos, $script);
        }
    }

    /**
     * @param  array<string, string>  $esperadas
     */
    private function assertEnvironmentVariables(string $arquivo, array $esperadas): void
    {
        $xml = simplexml_load_file($this->basePath($arquivo));
        $this->assertNotFalse($xml, $arquivo);

        $variaveis = [];
        foreach ($xml->php->env as $env) {
            $variaveis[(string) $env['name']] = [
                'value' => (string) $env['value'],
                'force' => (string) $env['force'],
            ];
        }

        foreach ($esperadas as $nome => $valor) {
            $this->assertSame($valor, $variaveis[$nome]['value'] ?? null, "{$arquivo}: {$nome}");
            $this->assertSame('true', $variaveis[$nome]['force'] ?? null, "{$arquivo}: {$nome} deve ser forçada");
        }
    }

    private function basePath(string $arquivo): string
    {
        return dirname(__DIR__, 3).'/'.$arquivo;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_PHPUNITENVIRONMENTISOLATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceInspectionLocationTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCEINSPECTIONLOCATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceInspectionLocationTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture`
- **Entidade / Classe:** `class SourceInspectionLocationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_inspecoes_de_codigo_da_aplicacao_ficam_restritas_a_suite_arquitetural(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture;

use FilesystemIterator;
use PHPUnit\Framework\TestCase;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use SplFileInfo;

class SourceInspectionLocationTest extends TestCase
{
    public function test_inspecoes_de_codigo_da_aplicacao_ficam_restritas_a_suite_arquitetural(): void
    {
        $unitRoot = dirname(__DIR__);
        $architectureRoot = __DIR__ . DIRECTORY_SEPARATOR;
        $violacoes = [];
        $arquivos = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($unitRoot, FilesystemIterator::SKIP_DOTS)
        );

        /** @var SplFileInfo $arquivo */
        foreach ($arquivos as $arquivo) {
            $caminho = $arquivo->getPathname();
            if ($arquivo->getExtension() !== 'php' || str_starts_with($caminho, $architectureRoot)) {
                continue;
            }

            $conteudo = (string) file_get_contents($caminho);
            if (str_contains($conteudo, 'app_path(') || preg_match('/__DIR__[^;\n]*\/app\//', $conteudo) === 1) {
                $violacoes[] = str_replace(base_path() . DIRECTORY_SEPARATOR, '', $caminho);
            }
        }

        sort($violacoes);
        $this->assertSame([], $violacoes, 'Testes comuns nao podem inspecionar arquivos de app/: ' . implode(', ', $violacoes));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCEINSPECTIONLOCATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/ValidationDuplicationGuardrailTest.php`
## <TESTS_UNIT_ARCHITECTURE_VALIDATIONDUPLICATIONGUARDRAILTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/ValidationDuplicationGuardrailTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture`
- **Entidade / Classe:** `class ValidationDuplicationGuardrailTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function algoritmo_de_cpf_existe_somente_no_componente_central(): void
public function regex_de_telefone_existe_somente_no_componente_central(): void
public function toda_leitura_de_campos_pdf_em_controller_usa_o_seletor_central(): void
public function detector_reconhece_seletor_pdf_renomeado_inline_e_centralizado(): void
private function camposSelecionados(Request $request): array
public function regras_de_cotacao_setran_ficam_no_form_request_compartilhado(): void
private function arquivosComPadroes(array $padroes, array $permitidos): array
private function controllersComLeituraCamposSemSeletorCentral(): array
private function possuiLeituraCamposSemSeletorCentral(string $source): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture;

use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;

class ValidationDuplicationGuardrailTest extends TestCase
{
    #[Test]
    public function algoritmo_de_cpf_existe_somente_no_componente_central(): void
    {
        $violacoes = $this->arquivosComPadroes([
            '/digitosVerificadoresValidos/',
            '/tamanhoBase/',
            '/resto\s*=.*%\s*11/',
        ], ['app/Support/Validation/Cpf.php']);

        $this->assertSame([], $violacoes, 'Algoritmo de CPF duplicado em: '.implode(', ', $violacoes));
    }

    #[Test]
    public function regex_de_telefone_existe_somente_no_componente_central(): void
    {
        $violacoes = $this->arquivosComPadroes([
            '/\\\[1-9\\\]\{2\}\\\[2-5\\\]/',
            '/9\\\[6-9\\\]\\\[0-9\\\]\{7\}/',
        ], ['app/Support/Validation/TelefoneBrasileiro.php']);

        $this->assertSame([], $violacoes, 'Regex de telefone duplicada em: '.implode(', ', $violacoes));
    }

    #[Test]
    public function toda_leitura_de_campos_pdf_em_controller_usa_o_seletor_central(): void
    {
        $violacoes = $this->controllersComLeituraCamposSemSeletorCentral();

        $this->assertSame([], $violacoes, 'Seletor PDF local duplicado em: '.implode(', ', $violacoes));
    }

    #[Test]
    public function detector_reconhece_seletor_pdf_renomeado_inline_e_centralizado(): void
    {
        $this->assertTrue($this->possuiLeituraCamposSemSeletorCentral(<<<'PHP'
            private function camposSelecionados(Request $request): array
            {
                return array_intersect($request->query('campos'), $this->camposPermitidos());
            }
            PHP));
        $this->assertTrue($this->possuiLeituraCamposSemSeletorCentral(
            '$campos = array_values(array_intersect($request->input("campos"), $permitidos));',
        ));
        $this->assertFalse($this->possuiLeituraCamposSemSeletorCentral(
            '$campos = CamposPdfSelecionados::resolver($request->query("campos"), $permitidos, $padrao);',
        ));
    }

    #[Test]
    public function regras_de_cotacao_setran_ficam_no_form_request_compartilhado(): void
    {
        $violacoes = $this->arquivosComPadroes([
            "/['\"]cotacoes\.\*\.cotacao_passagem_regular['\"]\s*=>/",
        ], ['app/Http/Requests/Diarias/DiariasCotacaoRequest.php']);

        $this->assertSame([], $violacoes, 'Regra de cotação SETRAN duplicada em: '.implode(', ', $violacoes));
    }

    /**
     * @param array<int, string> $padroes
     * @param array<int, string> $permitidos
     * @return array<int, string>
     */
    private function arquivosComPadroes(array $padroes, array $permitidos): array
    {
        $root = dirname(__DIR__, 3);
        $violacoes = [];
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($root.'/app', RecursiveDirectoryIterator::SKIP_DOTS),
        );

        foreach ($iterator as $file) {
            if (! $file->isFile() || $file->getExtension() !== 'php') {
                continue;
            }

            $relativo = str_replace($root.'/', '', $file->getPathname());
            if (in_array($relativo, $permitidos, true)) {
                continue;
            }

            $source = file_get_contents($file->getPathname());
            if ($source === false) {
                continue;
            }

            foreach ($padroes as $padrao) {
                if (preg_match($padrao, $source) === 1) {
                    $violacoes[] = $relativo;
                    break;
                }
            }
        }

        sort($violacoes);

        return $violacoes;
    }

    /** @return array<int, string> */
    private function controllersComLeituraCamposSemSeletorCentral(): array
    {
        $root = dirname(__DIR__, 3);
        $violacoes = [];
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($root.'/app/Http/Controllers', RecursiveDirectoryIterator::SKIP_DOTS),
        );

        foreach ($iterator as $file) {
            if (! $file->isFile() || $file->getExtension() !== 'php') {
                continue;
            }

            $source = file_get_contents($file->getPathname());
            if ($source === false) {
                continue;
            }

            if ($this->possuiLeituraCamposSemSeletorCentral($source)) {
                $violacoes[] = str_replace($root.'/', '', $file->getPathname());
            }
        }

        sort($violacoes);

        return $violacoes;
    }

    private function possuiLeituraCamposSemSeletorCentral(string $source): bool
    {
        $leituras = preg_match_all('/->(?:query|input|get)\s*\(\s*[\'\"]campos[\'\"]/', $source);
        $seletoresCentrais = preg_match_all(
            '/CamposPdfSelecionados::resolver\s*\(\s*\$[A-Za-z_][A-Za-z0-9_]*->(?:query|input|get)\s*\(\s*[\'\"]campos[\'\"]/',
            $source,
        );

        return $leituras > $seletoresCentrais;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_VALIDATIONDUPLICATIONGUARDRAILTEST_PHP>

