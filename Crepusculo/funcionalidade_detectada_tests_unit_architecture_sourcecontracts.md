# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_tests_unit_architecture_sourcecontracts`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 5  
> **Tamanho do Arquivo:** 33 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ArquivosMultiplosUiTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_ARQUIVOSMULTIPLOSUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ArquivosMultiplosUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ArquivosMultiplosUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_uploads_multiplos_usam_componente_compartilhado(): void
public function test_componente_expoe_tabela_acessivel_e_carrega_comportamento_compartilhado(): void
public function test_script_acumula_e_remove_arquivos_no_filelist_real(): void
public function test_nenhuma_view_mantem_input_multiplo_direto_fora_do_componente(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use SplFileInfo;
use Tests\TestCase;

class ArquivosMultiplosUiTest extends TestCase
{
    public function test_uploads_multiplos_usam_componente_compartilhado(): void
    {
        $usosEsperados = [
            'diarias/solicitacoes/comprovacao.blade.php' => 'name="comprovantes_embarque_jpeg[]"',
            'diarias/setran/index.blade.php' => 'name="reservas_pdf[{{ $trechoReserva->id }}][]"',
            'diarias/solicitacoes/prorrogacao-show.blade.php' => 'name="reservas_pdf[{{ $trecho->id }}][]"',
            'diarias/pagamentos/index.blade.php' => 'name="comprovantes_pagamento[{{ $selecionado->id }}][]"',
        ];

        foreach ($usosEsperados as $arquivo => $nomeCampo) {
            $conteudo = (string) file_get_contents(resource_path('views/'.$arquivo));

            $this->assertStringContainsString('<x-arquivos-multiplos', $conteudo, $arquivo);
            $this->assertStringContainsString($nomeCampo, $conteudo, $arquivo);
        }

        $pagamentos = (string) file_get_contents(resource_path('views/diarias/pagamentos/index.blade.php'));
        $this->assertStringContainsString('name="comprovantes_pagamento[{{ $item->id }}][]"', $pagamentos);
    }

    public function test_componente_expoe_tabela_acessivel_e_carrega_comportamento_compartilhado(): void
    {
        $componente = resource_path('views/components/arquivos-multiplos.blade.php');

        $this->assertFileExists($componente);

        $conteudo = (string) file_get_contents($componente);
        $this->assertStringContainsString('data-arquivos-multiplos', $conteudo);
        $this->assertStringContainsString('data-arquivos-multiplos-input', $conteudo);
        $this->assertStringContainsString('data-arquivos-multiplos-tabela', $conteudo);
        $this->assertStringContainsString('aria-live="polite"', $conteudo);
        $this->assertStringContainsString('Arquivo', $conteudo);
        $this->assertStringContainsString('Tamanho', $conteudo);
        $this->assertStringContainsString('Ações', $conteudo);
        $this->assertStringContainsString("asset('js/shared/arquivos-multiplos.js')", $conteudo);
    }

    public function test_script_acumula_e_remove_arquivos_no_filelist_real(): void
    {
        $script = public_path('js/shared/arquivos-multiplos.js');

        $this->assertFileExists($script);

        $conteudo = (string) file_get_contents($script);
        $this->assertStringContainsString('new DataTransfer()', $conteudo);
        $this->assertStringContainsString('input.files = transferencia.files', $conteudo);
        $this->assertStringContainsString('data-arquivo-remover', $conteudo);
        $this->assertStringContainsString("addEventListener('reset'", $conteudo);
        $this->assertStringContainsString('aria-label', $conteudo);
    }

    public function test_nenhuma_view_mantem_input_multiplo_direto_fora_do_componente(): void
    {
        $diretos = [];
        $diretorio = new RecursiveIteratorIterator(new RecursiveDirectoryIterator(resource_path('views')));

        /** @var SplFileInfo $arquivo */
        foreach ($diretorio as $arquivo) {
            if (! $arquivo->isFile() || $arquivo->getExtension() !== 'php') {
                continue;
            }

            $caminho = $arquivo->getPathname();
            if (str_ends_with($caminho, '/components/arquivos-multiplos.blade.php')) {
                continue;
            }

            $conteudo = str_replace('->', '__OPERADOR_OBJETO__', (string) file_get_contents($caminho));
            if (preg_match('/<input\b(?=[^>]*\btype\s*=\s*["\']file["\'])(?=[^>]*\bmultiple\b)[^>]*>/is', $conteudo) === 1) {
                $diretos[] = str_replace(resource_path('views').'/', '', $caminho);
            }
        }

        $this->assertSame([], $diretos, 'Inputs multiplos diretos: '.implode(', ', $diretos));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_ARQUIVOSMULTIPLOSUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/EquipeBuscaConvocadosFiltroTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_EQUIPEBUSCACONVOCADOSFILTROTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/EquipeBuscaConvocadosFiltroTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EquipeBuscaConvocadosFiltroTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscar_convocados_aceita_zona_id_processo_interno_e_escopo_opcionais(): void
public function buscar_convocados_retorna_vazio_para_termo_curto_independente_dos_filtros(): void
public function buscar_convocados_inclui_colaboradores_internos_deferidos_das_acoes_321_e_342_por_email_e_titulo_sem_filtro_zonal(): void
public function buscar_convocados_aplica_escopo_de_zonas_permitidas_quando_zona_da_rota_eh_aberta(): void
public function deduplicacao_do_autocomplete_preserva_fonte_interna_quando_titulo_existe_nas_duas_fontes(): void
public function deduplicacao_preserva_identidade_vigente_e_agrega_funcoes_efetivas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\EquipeRepository;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class EquipeBuscaConvocadosFiltroTest extends TestCase
{
    #[Test]
    public function buscar_convocados_aceita_zona_id_processo_interno_e_escopo_opcionais(): void
    {
        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertTrue(
            method_exists($repository, 'buscarConvocadosPorNome'),
            'Método buscarConvocadosPorNome deve existir.'
        );

        $reflection = new \ReflectionMethod($repository, 'buscarConvocadosPorNome');
        $params = $reflection->getParameters();

        $this->assertCount(7, $params, 'Deve incluir os contextos explícitos para manuais e convocações efetivas.');

        $this->assertTrue($params[1]->isOptional(), '$zonaId deve ser opcional.');
        $this->assertNull($params[1]->getDefaultValue(), '$zonaId deve ter default null.');
        $this->assertTrue($params[2]->isOptional(), '$processosColaboradoresDeferidosIds deve ser opcional.');
        $this->assertNull($params[2]->getDefaultValue(), '$processosColaboradoresDeferidosIds deve ter default null.');
        $this->assertTrue($params[3]->isOptional(), '$zonasPermitidasIds deve ser opcional.');
        $this->assertNull($params[3]->getDefaultValue(), '$zonasPermitidasIds deve ter default null.');
        $this->assertTrue($params[4]->isOptional(), '$acessoTodasZonas deve ser opcional.');
        $this->assertFalse($params[4]->getDefaultValue(), '$acessoTodasZonas deve ter default false.');
        $this->assertTrue($params[5]->isOptional(), '$incluirVoluntariosManuais deve ser opcional.');
        $this->assertFalse($params[5]->getDefaultValue(), '$incluirVoluntariosManuais deve falhar fechado.');
        $this->assertTrue($params[6]->isOptional(), '$contextoConvocacoesEfetivas deve ser opcional.');
        $this->assertSame([], $params[6]->getDefaultValue(), '$contextoConvocacoesEfetivas deve falhar fechado.');
    }

    #[Test]
    public function buscar_convocados_retorna_vazio_para_termo_curto_independente_dos_filtros(): void
    {
        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertSame([], $repository->buscarConvocadosPorNome('AB', 1));
        $this->assertSame([], $repository->buscarConvocadosPorNome('', 1));
        $this->assertSame([], $repository->buscarConvocadosPorNome('  ', 1));
    }

    #[Test]
    public function buscar_convocados_inclui_colaboradores_internos_deferidos_das_acoes_321_e_342_por_email_e_titulo_sem_filtro_zonal(): void
    {
        $conteudo = file_get_contents(app_path('Repositories/Lda/EquipeRepository.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('processosColaboradoresDeferidosIds', $conteudo);
        $this->assertStringContainsString('CE_CANDIDATURA_COLABORADOR as c', $conteudo);
        $this->assertStringContainsString('planeleito.vw_servidor as vs', $conteudo);
        $this->assertStringContainsString('LOWER(TRIM(vs.E_MAIL)) = LOWER(TRIM(c.EMAIL_USUARIO))', $conteudo);
        $this->assertStringContainsString('vs.NUM_TIT_ELE', $conteudo);
        $this->assertStringContainsString('c.STATUS', $conteudo);
        $this->assertStringContainsString('DEFERIDA', $conteudo);
        $this->assertStringContainsString('c.PROCESSO_ELEITORAL_ID', $conteudo);

        $inicio = strpos($conteudo, 'private function buscarColaboradoresInternosDeferidosPorNome');
        $this->assertNotFalse($inicio, 'Metodo da fonte interna nao encontrado.');
        $fim = strpos($conteudo, 'private function deduplicarIntegrantesPreferindoFonteInterna', (int) $inicio);
        $this->assertNotFalse($fim, 'Fim esperado da fonte interna nao encontrado.');
        $metodo = substr($conteudo, (int) $inicio, (int) $fim - (int) $inicio);

        $this->assertStringNotContainsString('zona_id', $metodo);
        $this->assertStringNotContainsString('NUM_ZONA', $metodo);
        $this->assertStringContainsString("whereIn('c.PROCESSO_ELEITORAL_ID'", $metodo);
    }

    #[Test]
    public function buscar_convocados_aplica_escopo_de_zonas_permitidas_quando_zona_da_rota_eh_aberta(): void
    {
        $conteudo = file_get_contents(app_path('Repositories/Lda/EquipeRepository.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('$zonasPermitidasIds', $conteudo);
        $this->assertStringContainsString('$acessoTodasZonas', $conteudo);
        $this->assertStringContainsString('whereIn(\'zona_id\', $zonasPermitidasIds)', $conteudo);
    }

    #[Test]
    public function deduplicacao_do_autocomplete_preserva_fonte_interna_quando_titulo_existe_nas_duas_fontes(): void
    {
        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $metodo = new \ReflectionMethod($repository, 'deduplicarIntegrantesPreferindoFonteInterna');
        $metodo->setAccessible(true);

        $resultado = $metodo->invoke($repository, [
            (object) [
                'num_inscricao' => '002832012410',
                'nom_eleitor' => 'AIEZA EXTERNA',
                'fonte_elegibilidade' => 'voluntario_externo',
            ],
            (object) [
                'num_inscricao' => '002832012410',
                'nom_eleitor' => 'AIEZA INTERNA',
                'fonte_elegibilidade' => 'colaborador_interno_deferido',
            ],
        ]);

        $this->assertCount(1, $resultado);
        $this->assertSame('AIEZA INTERNA', $resultado[0]->nom_eleitor);
        $this->assertSame('colaborador_interno_deferido', $resultado[0]->fonte_elegibilidade);
    }

    #[Test]
    public function deduplicacao_preserva_identidade_vigente_e_agrega_funcoes_efetivas(): void
    {
        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $metodo = new \ReflectionMethod($repository, 'deduplicarIntegrantesPreferindoFonteInterna');
        $metodo->setAccessible(true);

        $resultado = $metodo->invoke($repository, [
            (object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Nome da fonte vigente',
                'fonte_elegibilidade' => 'voluntario_externo',
            ],
            (object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Nome da convocacao',
                'fonte_elegibilidade' => 'convocacao_eleitoral_efetiva',
                'funcoes_efetivas' => ['Presidente', '1º Mesário'],
            ],
        ]);

        $this->assertCount(1, $resultado);
        $this->assertSame('Nome da fonte vigente', $resultado[0]->nom_eleitor);
        $this->assertSame(['1º Mesário', 'Presidente'], $resultado[0]->funcoes_efetivas);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_EQUIPEBUSCACONVOCADOSFILTROTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ExternalRuntimeAssetsGuardrailTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_EXTERNALRUNTIMEASSETSGUARDRAILTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ExternalRuntimeAssetsGuardrailTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ExternalRuntimeAssetsGuardrailTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function codigo_de_runtime_nao_referencia_cdn_publica(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use Tests\TestCase;

class ExternalRuntimeAssetsGuardrailTest extends TestCase
{
    #[Test]
    public function codigo_de_runtime_nao_referencia_cdn_publica(): void
    {
        $diretorios = [
            app_path(),
            resource_path('views'),
            public_path('js'),
            public_path('rotas-publicas/js'),
        ];
        $dominiosProibidos = [
            'cdn.jsdelivr.net',
            'unpkg.com',
            'cdnjs.cloudflare.com',
            'fonts.bunny.net',
            'fonts.googleapis.com',
            'fonts.gstatic.com',
        ];
        $violacoes = [];

        foreach ($diretorios as $diretorio) {
            $arquivos = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($diretorio));

            foreach ($arquivos as $arquivo) {
                if (!$arquivo->isFile() || !preg_match('/\.(?:php|js|css)$/', $arquivo->getFilename())) {
                    continue;
                }

                $conteudo = file_get_contents($arquivo->getPathname());

                foreach ($dominiosProibidos as $dominio) {
                    if (is_string($conteudo) && str_contains($conteudo, $dominio)) {
                        $violacoes[] = $arquivo->getPathname() . ': ' . $dominio;
                    }
                }
            }
        }

        $this->assertSame([], $violacoes, "CDN pública encontrada no código de runtime:\n" . implode("\n", $violacoes));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_EXTERNALRUNTIMEASSETSGUARDRAILTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/RecursoLogisticoLocalSourceTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RECURSOLOGISTICOLOCALSOURCETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/RecursoLogisticoLocalSourceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RecursoLogisticoLocalSourceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function contratos_registram_recursos_logisticos_compartilhados_por_local_e_macroprojeto(): void
public function repository_e_service_salvam_e_buscam_recursos_por_local_de_votacao(): void
$this->assertStringContainsString('public function salvarPorLocal(string $codObjetoLocal, int $macroprojetoId, array $recursos): void', $repository);
$this->assertStringContainsString('public function buscarPorLocal(string $codObjetoLocal, int $macroprojetoId): array', $repository);
public function service_recalcula_peso_total_pelo_peso_unitario_do_catalogo_antes_de_salvar(): void
public function requests_validam_e_sanitizam_apenas_id_e_quantidade_dos_recursos_logisticos(): void
public function formularios_lda_e_local_de_votacao_exibem_resumo_dinamico_de_recursos(): void
public function controllers_carregam_e_salvam_recursos_no_mesmo_contexto_do_trajeto(): void
$inicio = strpos($repository, 'public function remover(int $id): void');
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Lda\LocalDificilAcessoRequest;
use App\Http\Requests\LocaisVotacao\LocalVotacaoUpdateRequest;
use App\Repositories\Lda\LdaRecursoLogisticoOpcaoRepository;
use App\Repositories\Lda\RecursoLogisticoLocalRepository;
use App\Repositories\Lda\SecaoFisicaLocalRepository;
use App\Services\Lda\RecursoLogisticoLocalService;
use Illuminate\Contracts\Validation\Validator as ValidatorContract;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RecursoLogisticoLocalSourceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function contratos_registram_recursos_logisticos_compartilhados_por_local_e_macroprojeto(): void
    {
        foreach ([
            base_path('docs/contratos/lda-locais-votacao.md'),
            base_path('docs/contratos/lda-locais-dificil-acesso.md'),
            base_path('docs/contratos/lda-recursos-logisticos.md'),
        ] as $path) {
            $conteudo = file_get_contents($path);
            $this->assertIsString($conteudo);
            $this->assertStringContainsString('Recursos logisticos', $conteudo);
            $this->assertStringContainsString('cod_objeto_local + macroprojeto_id', $conteudo);
            $this->assertStringContainsString('peso_total_kg', $conteudo);
            $this->assertStringContainsString('peso_unitario_kg', $conteudo);
            $this->assertStringContainsString('calculado', $conteudo);
            $this->assertStringContainsString('planeleito_admin', mb_strtolower($conteudo, 'UTF-8'));
        }
    }

    #[Test]
    public function repository_e_service_salvam_e_buscam_recursos_por_local_de_votacao(): void
    {
        $repository = file_get_contents(app_path('Repositories/Lda/RecursoLogisticoLocalRepository.php'));
        $service = file_get_contents(app_path('Services/Lda/RecursoLogisticoLocalService.php'));
        $opcaoRepository = file_get_contents(app_path('Repositories/Lda/LdaRecursoLogisticoOpcaoRepository.php'));

        $this->assertIsString($repository);
        $this->assertIsString($service);
        $this->assertIsString($opcaoRepository);
        $this->assertStringContainsString('class RecursoLogisticoLocalRepository', $repository);
        $this->assertStringContainsString('public function salvarPorLocal(string $codObjetoLocal, int $macroprojetoId, array $recursos): void', $repository);
        $this->assertStringContainsString('public function buscarPorLocal(string $codObjetoLocal, int $macroprojetoId): array', $repository);
        $this->assertStringContainsString('$this->removerEscopoAuditado(', $repository);
        $this->assertStringContainsString('$this->inserirAuditado(', $repository);
        $this->assertStringContainsString('LDA_RECURSO_LOGISTICO_LOCAL', $repository);
        $this->assertStringContainsString('o.peso_unitario_kg', $repository);
        $this->assertStringContainsString('peso_unitario_kg', $opcaoRepository);
        $this->assertStringContainsString('class RecursoLogisticoLocalService', $service);
        $this->assertStringContainsString('opcoesAtivas', $service);
        $this->assertStringContainsString('salvarPorLocal', $service);
        $this->assertStringContainsString('buscarPorLocal', $service);
    }

    #[Test]
    public function service_recalcula_peso_total_pelo_peso_unitario_do_catalogo_antes_de_salvar(): void
    {
        $opcaoRepository = Mockery::mock(LdaRecursoLogisticoOpcaoRepository::class);
        $localRepository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);

        $opcaoRepository->shouldReceive('listarAtivasOrdenadas')
            ->once()
            ->andReturn([
                (object) ['id' => 10, 'peso_unitario_kg' => '2.500'],
                (object) ['id' => 11, 'peso_unitario_kg' => 0],
            ]);

        $localRepository->shouldReceive('salvarPorLocal')
            ->once()
            ->with('LV001', 7, Mockery::on(static function (array $recursos): bool {
                return count($recursos) === 2
                    && $recursos[0]['recurso_opcao_id'] === 10
                    && $recursos[0]['quantidade'] === 3
                    && abs($recursos[0]['peso_total_kg'] - 7.5) < 0.001
                    && $recursos[1]['recurso_opcao_id'] === 11
                    && $recursos[1]['quantidade'] === 4
                    && abs($recursos[1]['peso_total_kg'] - 0.0) < 0.001;
            }));

        $service = new RecursoLogisticoLocalService($opcaoRepository, $localRepository, $secaoRepository);
        $service->salvarPorLocal('LV001', 7, [
            ['recurso_opcao_id' => 10, 'quantidade' => 3],
            ['recurso_opcao_id' => 11, 'quantidade' => 4, 'peso_total_kg' => 999],
        ]);

        $this->addToAssertionCount(1);
    }

    #[Test]
    public function requests_validam_e_sanitizam_apenas_id_e_quantidade_dos_recursos_logisticos(): void
    {
        foreach ([new LocalDificilAcessoRequest, new LocalVotacaoUpdateRequest] as $request) {
            $rules = $request->rules();
            $this->assertArrayHasKey('recursos_logisticos', $rules);
            $this->assertArrayHasKey('recursos_logisticos.*.recurso_opcao_id', $rules);
            $this->assertSame(['required', 'integer', 'min:1'], $rules['recursos_logisticos.*.quantidade']);
            $this->assertArrayNotHasKey('recursos_logisticos.*.peso_total_kg', $rules);

            $validator = Mockery::mock(ValidatorContract::class);
            $validator->shouldReceive('validated')->once()->andReturn([
                'recursos_logisticos' => [[
                    'recurso_opcao_id' => 10,
                    'quantidade' => 7,
                    'peso_total_kg' => 999,
                ]],
            ]);
            $request->setValidator($validator);

            $this->assertSame([[
                'recurso_opcao_id' => 10,
                'quantidade' => 7,
            ]], $request->recursosLogisticosSanitizados());
        }

        $opcaoRequest = file_get_contents(app_path('Http/Requests/Lda/LdaRecursoLogisticoOpcaoRequest.php'));
        $this->assertIsString($opcaoRequest);
        $this->assertStringContainsString("'peso_unitario_kg' => ['required', 'numeric', 'min:0']", $opcaoRequest);
    }

    #[Test]
    public function formularios_lda_e_local_de_votacao_exibem_resumo_dinamico_de_recursos(): void
    {
        foreach ([
            file_get_contents(resource_path('views/lda/form.blade.php')),
            file_get_contents(resource_path('views/lda/locais-votacao/form.blade.php')),
        ] as $blade) {
            $this->assertIsString($blade);
            $this->assertStringContainsString("@include('lda.partials.recursos-logisticos'", $blade);
        }

        $partial = file_get_contents(resource_path('views/lda/partials/recursos-logisticos.blade.php'));
        $this->assertIsString($partial);
        $this->assertStringContainsString('Recursos logísticos', $partial);
        $this->assertStringContainsString('recursos_logisticos', $partial);
        $this->assertStringContainsString('data-recursos-quantidade-total', $partial);
        $this->assertStringContainsString('data-recursos-peso-total', $partial);
        $this->assertStringContainsString('atualizarResumoRecursosLogisticos', $partial);
        $this->assertStringContainsString('data-recurso-row', $partial);
        $this->assertStringContainsString('data-recurso-calculado', $partial);
        $this->assertStringContainsString('data-recurso-quantidade-calculada', $partial);
        $this->assertStringContainsString('recursos-logisticos:urna-secao-atualizada', $partial);
        $this->assertStringContainsString('data-recurso-peso-unitario', $partial);
        $this->assertStringContainsString('calcularPesoTotalRecurso', $partial);
        $this->assertStringNotContainsString('name="recursos_logisticos[__INDEX__][peso_total_kg]"', $partial);
        $this->assertStringNotContainsString('name="recursos_logisticos[{{ $index }}][peso_total_kg]"', $partial);
        $this->assertStringNotContainsString('__PESO_TOTAL__', $partial);
        $this->assertStringNotContainsString('data-recurso-peso-novo', $partial);
    }

    #[Test]
    public function controllers_carregam_e_salvam_recursos_no_mesmo_contexto_do_trajeto(): void
    {
        $lda = file_get_contents(app_path('Http/Controllers/Lda/LocalDificilAcessoController.php'));
        $local = file_get_contents(app_path('Http/Controllers/LocaisVotacao/LocalVotacaoCrudController.php'));

        foreach ([$lda, $local] as $controller) {
            $this->assertIsString($controller);
            $this->assertStringContainsString('use App\Services\Lda\RecursoLogisticoLocalService;', $controller);
            $this->assertStringContainsString('recursoLogisticoLocalService()->opcoesAtivas()', $controller);
            $this->assertStringContainsString('recursoLogisticoLocalService()->buscarPorLocal', $controller);
            $this->assertStringContainsString('recursoLogisticoLocalService()->salvarPorLocal', $controller);
            $this->assertStringContainsString('recursosLogisticosSanitizados()', $controller);
        }

        $repository = file_get_contents(app_path('Repositories/Lda/LocalDificilAcessoRepository.php'));
        $inicio = strpos($repository, 'public function remover(int $id): void');
        $fim = strpos($repository, 'public function salvarTrajetoTrechos', $inicio);
        $metodoRemover = substr($repository, $inicio, $fim - $inicio);
        $this->assertStringNotContainsString('lda_recurso_logistico_local', $metodoRemover);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RECURSOLOGISTICOLOCALSOURCETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ScdeIntegrationContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SCDEINTEGRATIONCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ScdeIntegrationContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class ScdeIntegrationContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function cliente_desabilita_redirects_e_mantem_validacao_tls(): void
public function migration_materializa_as_duas_responsabilidades_sem_executar_truncate(): void
public function repository_promove_snapshot_em_transacao_com_json_table_e_lotes_de_25(): void
public function crud_usa_auditoria_e_bloqueia_edicao_ou_exclusao_ativa(): void
public function todas_as_rotas_sao_nominais_e_vinculadas_somente_ao_planeleito_admin(): void
public function interface_tem_tabela_responsiva_polling_de_status_e_modal_pdf(): void
public function comando_e_scheduler_usam_as_quatro_protecoes_planejadas(): void
private function source(string $relative): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ScdeIntegrationContractTest extends TestCase
{
    #[Test]
    public function cliente_desabilita_redirects_e_mantem_validacao_tls(): void
    {
        $source = $this->source('app/Services/Scde/ScdeClient.php');

        $this->assertStringContainsString("'allow_redirects' => false", $source);
        $this->assertStringContainsString("'verify' => true", $source);
    }

    #[Test]
    public function migration_materializa_as_duas_responsabilidades_sem_executar_truncate(): void
    {
        $source = $this->source('database/migrations/2026_09_08_120000_create_scde_situacao_secao_tables.php');

        $this->assertStringContainsString('CREATE TABLE scde_configuracao', $source);
        $this->assertStringContainsString('CREATE TABLE scde_secao_situacao', $source);
        $this->assertStringContainsString('CASE WHEN ativo = 1 THEN 1 END', $source);
        $this->assertStringContainsString('sg_ue_mun VARCHAR2', $source);
        $this->assertStringContainsString('dt_sincronizacao TIMESTAMP(6)', $source);
        $this->assertStringNotContainsString('TRUNCATE', mb_strtoupper($source));
    }

    #[Test]
    public function repository_promove_snapshot_em_transacao_com_json_table_e_lotes_de_25(): void
    {
        $source = $this->source('app/Repositories/Scde/ScdeSituacaoSecaoRepository.php');

        $this->assertStringContainsString('private const TAMANHO_LOTE = 25;', $source);
        $this->assertStringContainsString('DB::transaction', $source);
        $this->assertStringContainsString('lockForUpdate()', $source);
        $this->assertStringContainsString('DELETE FROM scde_secao_situacao', $source);
        $this->assertStringContainsString('JSON_TABLE', $source);
        $this->assertStringContainsString('A contagem persistida', $source);
    }

    #[Test]
    public function crud_usa_auditoria_e_bloqueia_edicao_ou_exclusao_ativa(): void
    {
        $source = $this->source('app/Repositories/Scde/ScdeConfiguracaoRepository.php');

        $this->assertStringContainsString('use AuditaDml;', $source);
        $this->assertStringContainsString('inserirAuditado', $source);
        $this->assertStringContainsString('atualizarAuditadoPorId', $source);
        $this->assertStringContainsString('removerAuditadoPorId', $source);
        $this->assertStringContainsString('Configuracao SCDE ativa nao pode ser editada.', $source);
        $this->assertStringContainsString('Configuracao SCDE ativa nao pode ser excluida.', $source);
    }

    #[Test]
    public function todas_as_rotas_sao_nominais_e_vinculadas_somente_ao_planeleito_admin(): void
    {
        $routes = $this->source('routes/web.php');
        $migration = $this->source('database/migrations/2026_09_08_121000_grant_scde_routes_acl.php');

        foreach (['index', 'form', 'store', 'update', 'destroy', 'ativar', 'desativar', 'status', 'exportar-pdf'] as $acao) {
            $this->assertStringContainsString("administracao-global.scde.{$acao}", $routes);
            $this->assertStringContainsString("administracao-global.scde.{$acao}", $migration);
        }
        $this->assertStringContainsString("private const GRUPO = 'PLANELEITO_ADMIN';", $migration);

        $controller = $this->source('app/Http/Controllers/Scde/ScdeConfiguracaoController.php');
        $this->assertSame(9, substr_count($controller, '$this->autorizarAdmin();'));
    }

    #[Test]
    public function interface_tem_tabela_responsiva_polling_de_status_e_modal_pdf(): void
    {
        $view = $this->source('resources/views/administracao-global/scde/index.blade.php');
        $script = $this->source('public/js/administracao-global/scde.js');

        $this->assertStringContainsString('table-responsive', $view);
        $this->assertStringContainsString('modalScdePdf', $view);
        $this->assertStringContainsString('campos[]', $view);
        $this->assertStringContainsString('data-scde-status-url', $view);
        $this->assertStringContainsString('setInterval', $script);
        $this->assertStringNotContainsString('http://', $script);
        $this->assertStringNotContainsString('https://', $script);
    }

    #[Test]
    public function comando_e_scheduler_usam_as_quatro_protecoes_planejadas(): void
    {
        $source = $this->source('routes/console.php');

        $this->assertStringContainsString("Artisan::command('sync:scde:situacao-secao", $source);
        $this->assertStringContainsString("Schedule::command('sync:scde:situacao-secao')", $source);
        $this->assertStringContainsString('->everyMinute()', $source);
        $this->assertStringContainsString('->withoutOverlapping()', $source);
        $this->assertStringContainsString('->onOneServer()', $source);
        $this->assertStringContainsString('->runInBackground()', $source);
    }

    private function source(string $relative): string
    {
        $path = base_path($relative);
        $this->assertFileExists($path);

        return (string) file_get_contents($path);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SCDEINTEGRATIONCONTRACTTEST_PHP>

