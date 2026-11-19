# 📦 Documentação Consolidada do Sistema Crepúsculo (Parte 2)
## Funcionalidade: `funcionalidade_lda_logistica_transmissao`
> **Volume Fracionado para Otimização de Leitura por IA**
> **Tamanho Máximo:** 1500 KB

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LdaTrajetoTrechoTempoHorasMigrationTest.php`
## <TESTS_UNIT_LDATRAJETOTRECHOTEMPOHORASMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LdaTrajetoTrechoTempoHorasMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LdaTrajetoTrechoTempoHorasMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_renomeia_coluna_de_tempo_do_trajeto_para_horas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LdaTrajetoTrechoTempoHorasMigrationTest extends TestCase
{
    #[Test]
    public function migration_renomeia_coluna_de_tempo_do_trajeto_para_horas(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_05_26_140000_rename_lda_trajeto_trecho_tempo_to_horas.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('RENAME COLUMN tempo_deslocamento_min TO tempo_deslocamento_horas', $conteudo);
        $this->assertStringContainsString('MODIFY (tempo_deslocamento_horas NUMBER(8,2))', $conteudo);
        $this->assertStringContainsString('tempo_deslocamento_horas >= 0', $conteudo);
    }
}
```
</TESTS_UNIT_LDATRAJETOTRECHOTEMPOHORASMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoConsolidadoControllerTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoConsolidadoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoConsolidadoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function index_repassa_filtros_e_escopo_e_pagina_em_vinte(): void
public function index_reidrata_em_lote_os_certificados_dos_kits_da_pagina(): void
public function pdf_remove_campos_forjados_e_exporta_resultado_completo_em_retrato(): void
public function etiquetas_a4260_reunem_certificados_e_preservam_todo_o_resultado_filtrado(): void
public function etiquetas_a4260_nao_consultam_kits_quando_certificado_esta_desmarcado(): void
private function request(array $query): Request
private function controller(
public function __construct() {}
public function loadView(string $view, array $data = [], array $mergeData = [], ?string $encoding = null): self
public function setPaper($paper, string $orientation = 'portrait'): self
public function download(string $filename = 'document.pdf'): \Illuminate\Http\Response
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\LocalTransmissaoController;
use App\Repositories\Lda\KitVinculoRepository;
use App\Repositories\Lda\LocalTransmissaoConsolidadoRepository;
use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Repositories\Lda\SecaoFisicaLocalRepository;
use App\Services\Lda\KitVinculoService;
use App\Services\Lda\LocalTransmissaoService;
use App\Support\Exportacao\EtiquetaLocalA4260PdfRenderer;
use Barryvdh\DomPDF\PDF as DomPdf;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoConsolidadoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function index_repassa_filtros_e_escopo_e_pagina_em_vinte(): void
    {
        session(['cod_zonas_permitidas' => [4, 7], 'acesso_todas_zonas' => false]);
        $paginador = new LengthAwarePaginator([], 0, 20, 1, ['path' => '/lda/local-transmissao']);
        $filtros = [
            'zona' => 4,
            'municipio' => '16',
            'tipos' => ['lda', 'polo_rota'],
            'busca' => 'Escola',
            'local_transmissao_ids' => [],
        ];

        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('paginar')->once()->with($filtros, [4, 7], false, 20)->andReturn($paginador);
        $consolidado->shouldReceive('listarZonas')->once()->with([4, 7], false)->andReturn(collect());
        $consolidado->shouldReceive('listarMunicipios')->once()->with(4, [4, 7], false)->andReturn(collect());
        $consolidado->shouldReceive('listarOpcoesLocaisTransmissao')->once()
            ->with(4, '16', [4, 7], false)->andReturn(collect());

        $response = $this->controller($consolidado)->index($this->request([
            'zona' => '4',
            'municipio' => '16',
            'tipos' => ['lda', 'polo_rota'],
            'busca' => 'Escola',
        ]));

        $this->assertSame('lda.local_transmissao', $response->name());
        $this->assertSame(20, $response->getData()['locais']->perPage());
        $this->assertSame($filtros, $response->getData()['filtros']);
    }

    #[Test]
    public function index_reidrata_em_lote_os_certificados_dos_kits_da_pagina(): void
    {
        session(['cod_zonas_permitidas' => [4], 'acesso_todas_zonas' => false]);
        $local = (object) [
            'local_transmissao_id' => 7,
            'cod_objeto_local_votacao' => 'LV-7',
        ];
        $paginador = new LengthAwarePaginator([$local], 1, 20, 1, ['path' => '/lda/local-transmissao']);
        $filtros = [
            'zona' => 4,
            'municipio' => null,
            'tipos' => [],
            'busca' => null,
            'local_transmissao_ids' => [],
        ];

        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('paginar')->once()->with($filtros, [4], false, 20)->andReturn($paginador);
        $consolidado->shouldReceive('listarZonas')->once()->with([4], false)->andReturn(collect());
        $consolidado->shouldReceive('listarMunicipios')->once()->with(4, [4], false)->andReturn(collect());
        $consolidado->shouldReceive('listarOpcoesLocaisTransmissao')->once()
            ->with(4, null, [4], false)->andReturn(collect());

        $kits = Mockery::mock(KitVinculoRepository::class);
        $kits->shouldReceive('mapearPorCodigos')->once()->with(['LV-7'])->andReturn(['LV-7' => [55, 56]]);
        $kits->shouldReceive('mapearPorLocaisTransmissaoManual')->once()->with([])->andReturn([]);
        $kitService = Mockery::mock(KitVinculoService::class);
        $kitService->shouldReceive('certificadosPorIds')->once()->with([55, 56])->andReturn([
            55 => 'CERT-55',
            56 => 'CERT-56',
        ]);

        $response = $this->controller($consolidado, $kits, $kitService)->index($this->request(['zona' => '4']));

        $item = $response->getData()['locais']->items()[0];
        $this->assertSame(['CERT-55', 'CERT-56'], $item->kits_jec_certificados);
    }

    #[Test]
    public function pdf_remove_campos_forjados_e_exporta_resultado_completo_em_retrato(): void
    {
        session(['cod_zonas_permitidas' => [4], 'acesso_todas_zonas' => false]);
        $locais = collect([(object) ['identidade' => 'LV:1', 'nome' => 'ESCOLA TESTE']]);
        $filtros = [
            'zona' => 4,
            'municipio' => null,
            'tipos' => [],
            'busca' => null,
            'local_transmissao_ids' => [],
        ];

        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('listarParaPdf')->once()->with($filtros, [4], false)->andReturn($locais);
        $pdf = new LocalTransmissaoConsolidadoFakePdf;
        $this->app->instance('dompdf.wrapper', $pdf);

        $response = $this->controller($consolidado)->exportarPdf($this->request([
            'zona' => '4',
            'campos' => [
                'nome',
                'rotas_polo',
                'rotas_faz_parte',
                'rotas_transmite_bu',
                'campo_forjado',
            ],
        ]));

        $this->assertSame('pdf', $response->getContent());
        $this->assertSame('lda.local_transmissao_pdf', $pdf->loadedView);
        $this->assertSame(
            ['nome', 'rotas_polo', 'rotas_faz_parte', 'rotas_transmite_bu'],
            $pdf->loadedData['camposSelecionados']
        );
        $this->assertSame($locais, $pdf->loadedData['locais']);
        $this->assertSame(['a4', 'portrait'], $pdf->paper);
        $this->assertSame('locais-transmissao.pdf', $pdf->downloadName);
    }

    #[Test]
    public function etiquetas_a4260_reunem_certificados_e_preservam_todo_o_resultado_filtrado(): void
    {
        session(['cod_zonas_permitidas' => [4], 'acesso_todas_zonas' => false]);
        $locais = collect([
            (object) [
                'identidade' => 'LV:1',
                'cod_objeto_local_votacao' => 'LV-1',
                'local_transmissao_id' => 10,
                'zona_num' => 4,
                'municipio' => 'RIO BRANCO',
                'nome' => 'ESCOLA TESTE',
                'endereco' => 'RUA TESTE, 10',
            ],
            (object) [
                'identidade' => 'LT:20',
                'cod_objeto_local_votacao' => null,
                'local_transmissao_id' => 20,
                'zona_num' => 4,
                'municipio' => 'RIO BRANCO',
                'nome' => 'LOCAL MANUAL',
                'endereco' => 'RUA TESTE, 20',
            ],
        ]);
        $filtros = [
            'zona' => 4,
            'municipio' => null,
            'tipos' => ['local_transmissao'],
            'busca' => null,
            'local_transmissao_ids' => [],
        ];

        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('listarParaPdf')->once()->with($filtros, [4], false)->andReturn($locais);
        $kits = Mockery::mock(KitVinculoRepository::class);
        $kits->shouldReceive('mapearPorCodigos')->once()->with(['LV-1'])->andReturn(['LV-1' => [55, 56]]);
        $kits->shouldReceive('mapearPorLocaisTransmissaoManual')->once()->with([20])->andReturn([]);
        $kitService = Mockery::mock(KitVinculoService::class);
        $kitService->shouldReceive('certificadosPorIds')->once()->with([55, 56])->andReturn([
            55 => 'CERT-55',
            56 => 'CERT-56',
        ]);
        $renderer = Mockery::mock(EtiquetaLocalA4260PdfRenderer::class);
        $renderer->shouldReceive('renderizar')->once()->with(
            Mockery::on(static function ($etiquetas): bool {
                return $etiquetas->count() === 2
                    && $etiquetas[0]->zona === '4'
                    && $etiquetas[0]->nomeLocal === 'ESCOLA TESTE'
                    && $etiquetas[0]->certificados === ['CERT-55', 'CERT-56']
                    && $etiquetas[1]->nomeLocal === 'LOCAL MANUAL'
                    && $etiquetas[1]->certificados === [];
            }),
            ['certificado_jeconnect', 'zona']
        )->andReturn('%PDF-a4260-lt');

        $response = $this->controller($consolidado, $kits, $kitService, $renderer)->exportarPdf($this->request([
            'modelo' => 'etiquetas_locais_a4260',
            'zona' => '4',
            'tipos' => ['local_transmissao'],
            'campos' => ['certificado_jeconnect', 'campo_forjado', 'zona'],
        ]));

        $this->assertSame('%PDF-a4260-lt', $response->getContent());
        $this->assertSame('application/pdf', $response->headers->get('Content-Type'));
        $this->assertSame(
            'inline; filename="etiquetas-locais-pimaco-a4260.pdf"',
            $response->headers->get('Content-Disposition')
        );
    }

    #[Test]
    public function etiquetas_a4260_nao_consultam_kits_quando_certificado_esta_desmarcado(): void
    {
        session(['cod_zonas_permitidas' => [4], 'acesso_todas_zonas' => false]);
        $locais = collect([(object) [
            'identidade' => 'LV:1',
            'cod_objeto_local_votacao' => 'LV-1',
            'local_transmissao_id' => 10,
            'zona_num' => 4,
            'municipio' => 'RIO BRANCO',
            'nome' => 'ESCOLA TESTE',
            'endereco' => 'RUA TESTE, 10',
        ]]);

        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('listarParaPdf')->once()->andReturn($locais);
        $kits = Mockery::mock(KitVinculoRepository::class);
        $kits->shouldNotReceive('mapearPorCodigos');
        $kits->shouldNotReceive('mapearPorLocaisTransmissaoManual');
        $kitService = Mockery::mock(KitVinculoService::class);
        $kitService->shouldNotReceive('certificadosPorIds');
        $renderer = Mockery::mock(EtiquetaLocalA4260PdfRenderer::class);
        $renderer->shouldReceive('renderizar')->once()->with(
            Mockery::on(static fn ($etiquetas): bool => $etiquetas->count() === 1),
            ['zona', 'endereco']
        )->andReturn('%PDF-a4260-lt');

        $response = $this->controller($consolidado, $kits, $kitService, $renderer)->exportarPdf($this->request([
            'modelo' => 'etiquetas_locais_a4260',
            'campos' => ['zona', 'endereco'],
        ]));

        $this->assertSame('%PDF-a4260-lt', $response->getContent());
    }

    private function request(array $query): Request
    {
        return Request::create('/lda/local-transmissao', 'GET', $query);
    }

    private function controller(
        LocalTransmissaoConsolidadoRepository $consolidado,
        ?KitVinculoRepository $kits = null,
        ?KitVinculoService $kitService = null,
        ?EtiquetaLocalA4260PdfRenderer $renderer = null,
    ): LocalTransmissaoController {
        if ($kits === null) {
            $kits = Mockery::mock(KitVinculoRepository::class);
            $kits->shouldReceive('mapearPorCodigos')->andReturn([]);
            $kits->shouldReceive('mapearPorLocaisTransmissaoManual')->andReturn([]);
        }

        return new LocalTransmissaoController(
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class),
            null,
            $consolidado,
            $kits,
            $kitService,
            $renderer,
        );
    }
}

class LocalTransmissaoConsolidadoFakePdf extends DomPdf
{
    public ?string $loadedView = null;

    public array $loadedData = [];

    public array $paper = [];

    public ?string $downloadName = null;

    public function __construct() {}

    public function loadView(string $view, array $data = [], array $mergeData = [], ?string $encoding = null): self
    {
        $this->loadedView = $view;
        $this->loadedData = $data;

        return $this;
    }

    public function setPaper($paper, string $orientation = 'portrait'): self
    {
        $this->paper = [(string) $paper, $orientation];

        return $this;
    }

    public function download(string $filename = 'document.pdf'): \Illuminate\Http\Response
    {
        $this->downloadName = $filename;

        return response('pdf');
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoConsolidadoRequestTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoConsolidadoRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoConsolidadoRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function normaliza_filtros_e_combina_tipos_validos(): void
public function rejeita_zona_textual_tipo_forjado_e_lista_escalar(): void
public function rejeita_municipio_e_busca_em_formato_estruturado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Lda\LocalTransmissaoConsolidadoRequest;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use ReflectionMethod;
use Tests\TestCase;

class LocalTransmissaoConsolidadoRequestTest extends TestCase
{
    #[Test]
    public function normaliza_filtros_e_combina_tipos_validos(): void
    {
        $request = LocalTransmissaoConsolidadoRequest::create('/', 'GET', [
            'zona' => ' 004 ',
            'municipio' => ' 16 ',
            'tipos' => ['lda', 'polo_rota', 'lda'],
            'busca' => '  Escola Esperança  ',
            'local_transmissao_ids' => ['20', '10', '20'],
        ]);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $this->assertFalse(Validator::make($request->all(), $request->rules())->fails());
        $this->assertSame('4', $request->input('zona'));
        $this->assertSame('16', $request->input('municipio'));
        $this->assertSame(['lda', 'polo_rota'], $request->input('tipos'));
        $this->assertSame('Escola Esperança', $request->input('busca'));
        $this->assertSame([20, 10], $request->input('local_transmissao_ids'));
    }

    #[Test]
    public function rejeita_zona_textual_tipo_forjado_e_lista_escalar(): void
    {
        $request = LocalTransmissaoConsolidadoRequest::create('/', 'GET', [
            'zona' => 'zona quatro',
            'tipos' => ['lda', 'administrador'],
            'local_transmissao_ids' => '10',
        ]);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $validator = Validator::make($request->all(), $request->rules());
        $this->assertTrue($validator->fails());
        $this->assertArrayHasKey('zona', $validator->errors()->toArray());
        $this->assertArrayHasKey('tipos.1', $validator->errors()->toArray());
        $this->assertArrayHasKey('local_transmissao_ids', $validator->errors()->toArray());
    }

    #[Test]
    public function rejeita_municipio_e_busca_em_formato_estruturado(): void
    {
        $request = LocalTransmissaoConsolidadoRequest::create('/', 'GET', [
            'municipio' => ['16'],
            'busca' => ['ESCOLA'],
        ]);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $erros = Validator::make($request->all(), $request->rules())->errors()->toArray();
        $this->assertArrayHasKey('municipio', $erros);
        $this->assertArrayHasKey('busca', $erros);
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOREQUESTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoConsolidadoUiTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoConsolidadoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoConsolidadoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listagem_atual_concentra_dados_e_nao_oferece_conversao_individual_de_lda(): void
public function listagem_oferece_modal_de_campos_e_pdf_preserva_filtros(): void
public function listagem_oferece_etiquetas_a4260_com_pre_selecao_e_filtros_ativos(): void
public function listagem_renderiza_as_tres_relacoes_de_rota_em_campos_independentes(): void
public function pdf_renderiza_as_tres_relacoes_de_rota_em_campos_independentes(): void
public function rota_pdf_esta_registrada_e_nao_existe_tela_consolidada_paralela(): void
private function localComRelacoesDeRota(): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$this->assertStringContainsString("Route::has('lda.local-transmissao.exportar-pdf')", $conteudo);
$rotas = collect(\Illuminate\Support\Facades\Route::getRoutes()->getRoutesByName());
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Exportacao\EtiquetaLocalA4260Campos;
use Illuminate\Pagination\LengthAwarePaginator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoConsolidadoUiTest extends TestCase
{
    #[Test]
    public function listagem_atual_concentra_dados_e_nao_oferece_conversao_individual_de_lda(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="tipos[]"', $conteudo);
        $this->assertStringContainsString('name="busca"', $conteudo);
        $this->assertStringContainsString('Local de transmissão', $conteudo);
        $this->assertStringContainsString('LDA', $conteudo);
        $this->assertStringContainsString('Polo de rota', $conteudo);
        $this->assertStringContainsString('$item->endereco', $conteudo);
        $this->assertStringContainsString('Não informado', $conteudo);
        $this->assertStringContainsString('$item->rotas_polo', $conteudo);
        $this->assertStringContainsString('$item->rotas_faz_parte', $conteudo);
        $this->assertStringContainsString('$item->rotas_transmite_bu', $conteudo);
        $this->assertStringNotContainsString("route('lda.local-transmissao.store')", $conteudo);
        $this->assertStringNotContainsString('Converter em local de transmissão', $conteudo);
        $this->assertStringNotContainsString('name="local_transmissao_e_local_votacao" value="1"', $conteudo);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $conteudo);
    }

    #[Test]
    public function listagem_oferece_modal_de_campos_e_pdf_preserva_filtros(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao.blade.php'));
        $pdf = resource_path('views/lda/local_transmissao_pdf.blade.php');

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("Route::has('lda.local-transmissao.exportar-pdf')", $conteudo);
        $this->assertStringContainsString('modalExportarPdfLocaisTransmissao', $conteudo);
        $this->assertStringContainsString('name="campos[]"', $conteudo);
        $this->assertStringContainsString("route('lda.local-transmissao.exportar-pdf')", $conteudo);
        $this->assertStringContainsString('@foreach($camposPdf as $campo => $label)', $conteudo);
        $this->assertStringContainsString('value="{{ $campo }}"', $conteudo);

        $this->assertFileExists($pdf);
        $conteudoPdf = file_get_contents($pdf);
        $this->assertIsString($conteudoPdf);
        $this->assertStringContainsString('camposSelecionados', $conteudoPdf);
        $this->assertStringContainsString('Não informado', $conteudoPdf);
        $this->assertStringContainsString("'rotas_polo' =>", $conteudoPdf);
        $this->assertStringContainsString("'rotas_faz_parte' =>", $conteudoPdf);
        $this->assertStringContainsString("'rotas_transmite_bu' =>", $conteudoPdf);
        $this->assertStringContainsString('É polo da:', $conteudoPdf);
        $this->assertStringContainsString('Faz parte da:', $conteudoPdf);
        $this->assertStringContainsString('Transmite BU de:', $conteudoPdf);
    }

    #[Test]
    public function listagem_oferece_etiquetas_a4260_com_pre_selecao_e_filtros_ativos(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Etiquetas de locais — Pimaco A4260', $conteudo);
        $this->assertStringContainsString('data-export-format="a4260"', $conteudo);
        $this->assertStringContainsString('data-export-fields="a4260"', $conteudo);
        $this->assertStringContainsString('name="modelo"', $conteudo);
        $this->assertStringContainsString('etiquetas_locais_a4260', $conteudo);
        $this->assertStringContainsString('EtiquetaLocalA4260Campos::disponiveis()', $conteudo);
        $this->assertStringContainsString('EtiquetaLocalA4260Campos::padrao()', $conteudo);
        $this->assertSame(
            ['zona', 'municipio', 'endereco', 'certificado_jeconnect'],
            EtiquetaLocalA4260Campos::padrao()
        );
    }

    #[Test]
    public function listagem_renderiza_as_tres_relacoes_de_rota_em_campos_independentes(): void
    {
        $locais = new LengthAwarePaginator([$this->localComRelacoesDeRota()], 1, 20, 1, [
            'path' => '/lda/local-transmissao',
        ]);

        $html = view('lda.local_transmissao', [
            'locais' => $locais,
            'locaisTransmissaoOpcoes' => collect(),
            'zonas' => collect(),
            'municipios' => collect(),
            'filtros' => [
                'zona' => null,
                'municipio' => null,
                'tipos' => [],
                'busca' => null,
                'local_transmissao_ids' => [],
            ],
            'camposPdf' => [],
            'camposPdfPadrao' => [],
        ])->render();

        $this->assertStringContainsString('É polo da:', $html);
        $this->assertStringContainsString('Faz parte da:', $html);
        $this->assertStringContainsString('Transmite BU de:', $html);
        $this->assertStringContainsString('Rota 3', $html);
        $this->assertStringContainsString('Rota 7', $html);
        $this->assertStringContainsString('Rota 12', $html);
    }

    #[Test]
    public function pdf_renderiza_as_tres_relacoes_de_rota_em_campos_independentes(): void
    {
        $html = view('lda.local_transmissao_pdf', [
            'locais' => collect([$this->localComRelacoesDeRota()]),
            'camposSelecionados' => [
                'rotas_polo',
                'rotas_faz_parte',
                'rotas_transmite_bu',
            ],
            'geradoEm' => '28/08/2026 12:00',
        ])->render();

        $this->assertMatchesRegularExpression('/É polo da:<\/span>\s*Rota 3/', $html);
        $this->assertMatchesRegularExpression('/Faz parte da:<\/span>\s*Rota 7/', $html);
        $this->assertMatchesRegularExpression('/Transmite BU de:<\/span>\s*Rota 7; Rota 12/', $html);
    }

    #[Test]
    public function rota_pdf_esta_registrada_e_nao_existe_tela_consolidada_paralela(): void
    {
        $rotas = collect(\Illuminate\Support\Facades\Route::getRoutes()->getRoutesByName());

        $this->assertTrue($rotas->has('lda.local-transmissao.exportar-pdf'));
        $this->assertFalse($rotas->has('lda.local-transmissao.consolidado'));
    }

    private function localComRelacoesDeRota(): object
    {
        return (object) [
            'nome' => 'ESCOLA MODELO',
            'zona_num' => 1,
            'municipio' => 'RIO BRANCO',
            'endereco' => 'RUA TESTE',
            'eh_local_transmissao' => true,
            'eh_lda' => false,
            'eh_polo_rota' => true,
            'local_transmissao_id' => 10,
            'rotas_polo' => ['Rota 3'],
            'rotas_faz_parte' => ['Rota 7'],
            'rotas_transmite_bu' => ['Rota 7', 'Rota 12'],
        ];
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoControllerTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_define_paginacao_de_vinte_itens_no_controller(): void
public function test_index_filtra_multiplos_lts_no_escopo_antes_da_paginacao(): void
public function test_buscar_locais_votacao_repassa_contexto_do_formulario_ao_repository(): void
public function test_buscar_locais_votacao_tambem_aceita_locais_selecionados_em_array(): void
public function test_buscar_locais_votacao_sem_contexto_preserva_uso_compartilhado_do_formulario_lda(): void
public function test_buscar_origens_retorna_metadados_oficiais_no_escopo(): void
public function test_buscar_locais_para_lda_inclui_secoes_fisicas_calculadas_em_lote(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\LocalTransmissaoController;
use App\Repositories\Lda\LocalTransmissaoConsolidadoRepository;
use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoDeslocamentoRepository;
use App\Repositories\Lda\SecaoFisicaLocalRepository;
use App\Services\Lda\LocalTransmissaoService;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class LocalTransmissaoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_define_paginacao_de_vinte_itens_no_controller(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => true,
        ]);

        $paginator = new LengthAwarePaginator([], 0, 20, 1, [
            'path' => '/lda/local-transmissao',
            'pageName' => 'page',
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('listarZonas')->once()->with([4], true)->andReturn(collect());
        $consolidado->shouldReceive('listarMunicipios')->once()->with(null, [4], true)->andReturn(collect());
        $consolidado->shouldReceive('listarOpcoesLocaisTransmissao')->once()
            ->with(null, null, [4], true)->andReturn(collect());
        $consolidado->shouldReceive('paginar')->once()->with([
            'zona' => null,
            'municipio' => null,
            'tipos' => [],
            'busca' => null,
            'local_transmissao_ids' => [],
        ], [4], true, 20)->andReturn($paginator);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class),
            null,
            $consolidado,
        );

        $response = $controller->index(Request::create('/lda/local-transmissao', 'GET'));

        $this->assertInstanceOf(LengthAwarePaginator::class, $response->getData()['locais']);
        $this->assertSame(20, $response->getData()['locais']->perPage());
    }

    public function test_index_filtra_multiplos_lts_no_escopo_antes_da_paginacao(): void
    {
        session([
            'cod_zonas_permitidas' => [9],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $opcoes = collect([
            (object) ['id' => 303, 'nome' => 'ESCOLA NOVA ESPERANCA', 'num_zona' => 9, 'cod_objeto_localidade' => '16'],
            (object) ['id' => 333, 'nome' => 'ESCOLA ALTO ALEGRE II', 'num_zona' => 9, 'cod_objeto_localidade' => '16'],
            (object) ['id' => 400, 'nome' => 'ESCOLA NAO SELECIONADA', 'num_zona' => 9, 'cod_objeto_localidade' => '16'],
        ]);
        $paginador = new LengthAwarePaginator($opcoes->take(2), 2, 20, 1, [
            'path' => '/lda/local-transmissao',
            'query' => ['local_transmissao_ids' => [303, 333]],
        ]);
        $consolidado = Mockery::mock(LocalTransmissaoConsolidadoRepository::class);
        $consolidado->shouldReceive('listarZonas')->once()->with([9], false)->andReturn(collect([
            (object) ['num_zona' => 9],
        ]));
        $consolidado->shouldReceive('listarMunicipios')->once()->with(null, [9], false)->andReturn(collect([
            (object) ['cod_objeto_localidade' => '16', 'localidade' => 'RIO BRANCO'],
        ]));
        $consolidado->shouldReceive('listarOpcoesLocaisTransmissao')->once()
            ->with(null, null, [9], false)->andReturn($opcoes);
        $consolidado->shouldReceive('paginar')->once()->with([
            'zona' => null,
            'municipio' => null,
            'tipos' => [],
            'busca' => null,
            'local_transmissao_ids' => [303, 333],
        ], [9], false, 20)->andReturn($paginador);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class),
            null,
            $consolidado,
        );

        $response = $controller->index(Request::create('/lda/local-transmissao', 'GET', [
            'local_transmissao_ids' => ['303', '333', '355', '303', 'abc', '0'],
        ]));

        $dados = $response->getData();
        $this->assertSame([303, 333], $dados['locais']->getCollection()->pluck('id')->all());
        $this->assertSame([303, 333, 400], collect($dados['locaisTransmissaoOpcoes'])->pluck('id')->all());
        $this->assertSame([303, 333], $dados['filtros']['local_transmissao_ids']);
        $this->assertStringContainsString(
            'local_transmissao_ids%5B0%5D=303',
            $dados['locais']->url(2)
        );
    }

    public function test_buscar_locais_votacao_repassa_contexto_do_formulario_ao_repository(): void
    {
        session([
            'cod_zonas_permitidas' => [3, 7],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarLocaisVotacaoDisponiveis')
            ->once()
            ->with('ESCOLA', 12, 3, false, true, [3, 7], false, true, ['LV-99', 'LV-100'])
            ->andReturn([
                (object) [
                    'id' => 'LV-10',
                    'texto' => '3 - RIO BRANCO - ESCOLA TESTE (Local 10)',
                    'nome_local' => 'ESCOLA TESTE',
                    'endereco' => 'RUA TESTE',
                    'zona_num' => 3,
                    'preferencias_total' => 1,
                    'preferencias_resumo' => '1ª Local antigo',
                    'ordem_sugerida' => 2,
                    'ordem_preferencia_atual' => null,
                ],
            ]);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class)
        );
        $response = $controller->buscarLocaisVotacao(Request::create('/lda/local-transmissao/locais', 'GET', [
            'q' => 'escola',
            'local_transmissao_id' => '12',
            'zona_num' => '3',
            'permitir_zona_diferente' => '0',
            'incluir_preferencias_existentes' => '1',
            'contexto_local_transmissao' => '1',
            'locais_selecionados' => 'LV-99,,LV-100,LV-99',
        ]));

        $this->assertSame([
            [
                'id' => 'LV-10',
                'text' => '3 - RIO BRANCO - ESCOLA TESTE (Local 10)',
                'nome_local' => 'ESCOLA TESTE',
                'endereco' => 'RUA TESTE',
                'zona_num' => 3,
                'preferencias_total' => 1,
                'preferencias_resumo' => '1ª Local antigo',
                'ordem_sugerida' => 2,
                'ordem_preferencia_atual' => null,
            ],
        ], $response->getData(true));
    }

    public function test_buscar_locais_votacao_tambem_aceita_locais_selecionados_em_array(): void
    {
        session([
            'cod_zonas_permitidas' => [3, 7],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarLocaisVotacaoDisponiveis')
            ->once()
            ->with('ESCOLA', 12, 3, false, true, [3, 7], false, true, ['LV-99', 'LV-100'])
            ->andReturn([]);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class)
        );
        $response = $controller->buscarLocaisVotacao(Request::create('/lda/local-transmissao/locais', 'GET', [
            'q' => 'escola',
            'local_transmissao_id' => '12',
            'zona_num' => '3',
            'permitir_zona_diferente' => '0',
            'incluir_preferencias_existentes' => '1',
            'contexto_local_transmissao' => '1',
            'locais_selecionados' => ['LV-99', '', 'LV-100', 'LV-99'],
        ]));

        $this->assertSame([], $response->getData(true));
    }

    public function test_buscar_locais_votacao_sem_contexto_preserva_uso_compartilhado_do_formulario_lda(): void
    {
        session([
            'cod_zonas_permitidas' => [3, 7],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarLocaisVotacaoDisponiveis')
            ->once()
            ->with('ESCOLA', null, null, true, true, [3, 7], false, false, [])
            ->andReturn([]);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class)
        );
        $response = $controller->buscarLocaisVotacao(Request::create('/lda/local-transmissao/locais', 'GET', [
            'q' => 'escola',
            'locais_selecionados' => ['LV-99'],
        ]));

        $this->assertSame([], $response->getData(true));
    }

    public function test_buscar_origens_retorna_metadados_oficiais_no_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [3, 7],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('pesquisarOrigensLocaisVotacao')
            ->once()
            ->with('ESCOLA', [3, 7], false)
            ->andReturn([
                (object) [
                    'id' => 'LV-10',
                    'texto' => '3 - RIO BRANCO - ESCOLA TESTE (Local 10)',
                    'nom_local' => 'ESCOLA TESTE',
                    'num_local' => 10,
                    'zona_num' => 3,
                    'cod_objeto_localidade' => 'LOC-1',
                    'nom_localidade' => 'RIO BRANCO',
                    'cod_objeto_bairro' => 'BAI-1',
                    'nom_bairro' => 'CENTRO',
                    'des_endereco' => 'RUA TESTE',
                    'num_latitude' => -9.9,
                    'num_longitude' => -67.8,
                ],
            ]);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            Mockery::mock(SecaoFisicaLocalRepository::class)
        );
        $response = $controller->buscarLocaisVotacao(Request::create(
            '/lda/local-transmissao/locais',
            'GET',
            ['q' => 'escola', 'finalidade' => 'origem']
        ));

        $this->assertSame('LV-10', $response->getData(true)[0]['id']);
        $this->assertSame('ESCOLA TESTE', $response->getData(true)[0]['nome']);
        $this->assertSame('CENTRO', $response->getData(true)[0]['bairro']);
        $this->assertSame('RUA TESTE', $response->getData(true)[0]['endereco']);
    }

    public function test_buscar_locais_para_lda_inclui_secoes_fisicas_calculadas_em_lote(): void
    {
        session([
            'cod_zonas_permitidas' => [3],
            'acesso_todas_zonas' => false,
            'macroprojeto_turno_ativo_id' => 501,
        ]);

        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarLocaisVotacaoDisponiveis')
            ->once()
            ->andReturn([
                (object) [
                    'id' => 'LV-10',
                    'texto' => '3 - RIO BRANCO - ESCOLA TESTE (Local 10)',
                    'nome_local' => 'ESCOLA TESTE',
                    'endereco' => 'RUA TESTE',
                    'zona_num' => 3,
                ],
                (object) [
                    'id' => 'LV-11',
                    'texto' => '3 - RIO BRANCO - ESCOLA VAZIA (Local 11)',
                    'nome_local' => 'ESCOLA VAZIA',
                    'endereco' => 'RUA DOIS',
                    'zona_num' => 3,
                ],
            ]);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);
        $secaoRepository->shouldReceive('quantidadesPorLocais')
            ->once()
            ->with(['LV-10', 'LV-11'])
            ->andReturn(['LV-10' => 4, 'LV-11' => 0]);
        $deslocamentoRepository = Mockery::mock(LocalVotacaoDeslocamentoRepository::class);
        $deslocamentoRepository->shouldReceive('listarPorLocais')
            ->once()
            ->with(['LV-10', 'LV-11'], 501)
            ->andReturn([
                'LV-10' => [
                    'dt_saida_prevista' => '2026-10-02 08:00',
                    'dt_saida_prevista_volta' => '2026-10-03 16:00',
                    'dt_chegada_prevista_volta' => '2026-10-03 22:00',
                    'observacao_deslocamento' => 'Janela confirmada.',
                ],
            ]);

        $controller = new LocalTransmissaoController(
            $repository,
            Mockery::mock(LocalTransmissaoService::class),
            $secaoRepository,
            $deslocamentoRepository
        );
        $response = $controller->buscarLocaisVotacao(Request::create(
            '/lda/local-transmissao/locais',
            'GET',
            ['q' => 'escola', 'finalidade' => 'lda']
        ));

        $this->assertSame(4, $response->getData(true)[0]['secoes_fisicas']);
        $this->assertSame(0, $response->getData(true)[1]['secoes_fisicas']);
        $this->assertSame('2026-10-02 08:00', $response->getData(true)[0]['dt_saida_prevista']);
        $this->assertSame('2026-10-03 16:00', $response->getData(true)[0]['dt_saida_prevista_volta']);
        $this->assertSame('2026-10-03 22:00', $response->getData(true)[0]['dt_chegada_prevista_volta']);
        $this->assertSame('Janela confirmada.', $response->getData(true)[0]['observacao_deslocamento']);
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoDerivacaoTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAODERIVACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoDerivacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoDerivacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_request_exige_origem_no_modo_derivado_e_campos_no_modo_manual(): void
public function test_payload_derivado_nao_aceita_campos_manuais_como_fonte(): void
public function test_endereco_manual_e_normalizado_e_limitado_a_quatrocentos_caracteres(): void
public function test_formulario_expoe_checkbox_seletor_de_origem_e_rotulos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Lda\LocalTransmissaoRequest;
use Illuminate\Support\Facades\Validator;
use ReflectionMethod;
use Tests\TestCase;

class LocalTransmissaoDerivacaoTest extends TestCase
{
    public function test_request_exige_origem_no_modo_derivado_e_campos_no_modo_manual(): void
    {
        $requestDerivado = LocalTransmissaoRequest::create('/', 'POST', [
            'local_transmissao_e_local_votacao' => '1',
        ]);
        $requestDerivado->setContainer($this->app);
        $errosDerivado = Validator::make(
            $requestDerivado->all(),
            $requestDerivado->rules()
        )->errors();

        $this->assertTrue($errosDerivado->has('cod_objeto_local_votacao'));
        $this->assertFalse($errosDerivado->has('nome'));
        $this->assertFalse($errosDerivado->has('zona_num'));

        $requestManual = LocalTransmissaoRequest::create('/', 'POST', [
            'local_transmissao_e_local_votacao' => '0',
        ]);
        $requestManual->setContainer($this->app);
        $errosManual = Validator::make(
            $requestManual->all(),
            $requestManual->rules()
        )->errors();

        $this->assertFalse($errosManual->has('cod_objeto_local_votacao'));
        $this->assertTrue($errosManual->has('nome'));
        $this->assertTrue($errosManual->has('zona_num'));
        $this->assertTrue($errosManual->has('cod_objeto_localidade'));
        $this->assertTrue($errosManual->has('cod_objeto_bairro'));
        $this->assertTrue($errosManual->has('endereco'));
    }

    public function test_payload_derivado_nao_aceita_campos_manuais_como_fonte(): void
    {
        $request = LocalTransmissaoRequest::create('/', 'POST', [
            'local_transmissao_e_local_votacao' => '1',
            'cod_objeto_local_votacao' => 'LV-1',
            'nome' => 'NOME FORJADO',
            'zona_num' => '999',
            'cod_objeto_localidade' => 'LOC-FORJADA',
            'cod_objeto_bairro' => 'BAIRRO-FORJADO',
            'endereco' => 'ENDERECO FORJADO',
            'num_latitude' => '999',
            'num_longitude' => '-999',
        ]);
        $request->setContainer($this->app);

        $validator = Validator::make($request->all(), $request->rules());
        $this->assertFalse($validator->fails());
        $request->setValidator($validator);
        $dados = $request->dadosSanitizados();

        $this->assertTrue($dados['local_transmissao_e_local_votacao']);
        $this->assertSame('LV-1', $dados['cod_objeto_local_votacao']);
        $this->assertArrayNotHasKey('nome', $dados);
        $this->assertArrayNotHasKey('zona_num', $dados);
        $this->assertArrayNotHasKey('cod_objeto_localidade', $dados);
        $this->assertArrayNotHasKey('cod_objeto_bairro', $dados);
        $this->assertArrayNotHasKey('endereco', $dados);
        $this->assertArrayNotHasKey('num_latitude', $dados);
        $this->assertArrayNotHasKey('num_longitude', $dados);
    }

    public function test_endereco_manual_e_normalizado_e_limitado_a_quatrocentos_caracteres(): void
    {
        $request = LocalTransmissaoRequest::create('/', 'POST', [
            'local_transmissao_e_local_votacao' => '0',
            'nome' => 'POSTO MANUAL',
            'zona_num' => '4',
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'endereco' => '  RUA TESTE, 100  ',
        ]);
        $request->setContainer($this->app);
        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $validator = Validator::make($request->all(), $request->rules());
        $this->assertFalse($validator->fails());
        $request->setValidator($validator);
        $this->assertSame('RUA TESTE, 100', $request->dadosSanitizados()['endereco']);

        $requestLongo = LocalTransmissaoRequest::create('/', 'POST', [
            'local_transmissao_e_local_votacao' => '0',
            'nome' => 'POSTO MANUAL',
            'zona_num' => '4',
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'endereco' => str_repeat('A', 401),
        ]);
        $requestLongo->setContainer($this->app);

        $erros = Validator::make($requestLongo->all(), $requestLongo->rules())->errors();
        $this->assertTrue($erros->has('endereco'));

        $requestVazio = LocalTransmissaoRequest::create('/', 'POST', [
            'local_transmissao_e_local_votacao' => '0',
            'nome' => 'POSTO MANUAL',
            'zona_num' => '4',
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'endereco' => '   ',
        ]);
        $requestVazio->setContainer($this->app);
        (new ReflectionMethod($requestVazio, 'prepareForValidation'))->invoke($requestVazio);

        $erros = Validator::make($requestVazio->all(), $requestVazio->rules())->errors();
        $this->assertTrue($erros->has('endereco'));
    }

    public function test_formulario_expoe_checkbox_seletor_de_origem_e_rotulos(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao_form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Local de transmissão é um local de votação?', $conteudo);
        $this->assertStringContainsString('name="local_transmissao_e_local_votacao"', $conteudo);
        $this->assertStringContainsString('name="cod_objeto_local_votacao"', $conteudo);
        $this->assertStringContainsString('data-finalidade="origem"', $conteudo);
        $this->assertStringContainsString('id="dadosOrigemLocalVotacao"', $conteudo);
        $this->assertStringContainsString('data-campo-origem="nome"', $conteudo);
        $this->assertStringContainsString('data-campo-origem="endereco"', $conteudo);
        $this->assertStringContainsString('name="endereco"', $conteudo);
        $this->assertStringContainsString('maxlength="400"', $conteudo);
        $this->assertStringContainsString("\$origemSelecionada->des_endereco ?? ''", $conteudo);
        $this->assertStringContainsString('data-campo-origem="coordenadas"', $conteudo);
        $this->assertStringContainsString('finalidade: origemSelect.data(\'finalidade\')', $conteudo);
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAODERIVACAOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoEnderecoMigrationTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOENDERECOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoEnderecoMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoEnderecoMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_endereco_anulavel_na_tabela_e_na_view_sem_dml(): void
public function rollback_recusa_perda_de_enderecos_e_restaura_a_view_anterior(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoEnderecoMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_endereco_anulavel_na_tabela_e_na_view_sem_dml(): void
    {
        $arquivo = database_path(
            'migrations/2026_08_27_120000_add_endereco_to_local_transmissao.php'
        );

        $this->assertFileExists($arquivo);
        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);
        $sql = strtoupper($conteudo);

        $this->assertStringContainsString(
            'ALTER TABLE PLANELEITO.LOCAL_TRANSMISSAO ADD (ENDERECO VARCHAR2(400 CHAR))',
            $sql
        );
        $this->assertStringContainsString('VW_LOCAIS_TRANSMISSAO_EFETIVOS', $sql);
        $this->assertGreaterThanOrEqual(1, substr_count($sql, 'LT.ENDERECO'));
        $this->assertStringNotContainsString('ENDERECO VARCHAR2(400 CHAR) NOT NULL', $sql);
        $this->assertStringNotContainsString('INSERT INTO', $sql);
        $this->assertStringNotContainsString('UPDATE PLANELEITO.LOCAL_TRANSMISSAO', $sql);
        $this->assertStringNotContainsString('DELETE FROM', $sql);
    }

    #[Test]
    public function rollback_recusa_perda_de_enderecos_e_restaura_a_view_anterior(): void
    {
        $arquivo = database_path(
            'migrations/2026_08_27_120000_add_endereco_to_local_transmissao.php'
        );
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("->whereNotNull('endereco')->exists()", $conteudo);
        $this->assertStringContainsString('throw new RuntimeException(', $conteudo);
        $this->assertStringContainsString(
            'ALTER TABLE planeleito.local_transmissao DROP COLUMN endereco',
            $conteudo
        );
        $this->assertSame(2, substr_count($conteudo, 'CREATE OR REPLACE FORCE VIEW'));
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOENDERECOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoLdaCommandTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOLDACOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoLdaCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoLdaCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function comando_executa_dry_run_por_padrao_e_aceita_filtro_de_zona(): void
public function comando_rejeita_zona_invalida_sem_consultar_dados(): void
public function comando_aplica_a_geracao_somente_com_execute_explicito(): void
private function itemPlano(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoLdaCommandTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function comando_executa_dry_run_por_padrao_e_aceita_filtro_de_zona(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('planejarLocaisTransmissaoPropriosDosLdas')
            ->once()
            ->with(4)
            ->andReturn([
                $this->itemPlano('CRIAR', null, 0, 1),
                $this->itemPlano('ATUALIZAR', 91, 2, 0),
            ]);
        $repository->shouldNotReceive('gerarLocaisTransmissaoPropriosDosLdas');
        $this->app->instance(LocalVotacaoRepository::class, $repository);

        $this->artisan('lda:gerar-locais-transmissao-dos-ldas', ['--zona' => '4'])
            ->expectsOutput('Dry-run concluido. 2 LDA(s) processavel(is): 1 LT(s) a criar e 1 a atualizar.')
            ->expectsOutput('Reconciliacao prevista: 2 duplicidade(s) LDA/LT e 1 referencia(s) LDA isolada(s) serao canonizadas.')
            ->expectsOutput('Nenhum DML executado. Reexecute com --execute somente apos autorizacao explicita.')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_rejeita_zona_invalida_sem_consultar_dados(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldNotReceive('planejarLocaisTransmissaoPropriosDosLdas');
        $repository->shouldNotReceive('gerarLocaisTransmissaoPropriosDosLdas');
        $this->app->instance(LocalVotacaoRepository::class, $repository);

        $this->artisan('lda:gerar-locais-transmissao-dos-ldas', ['--zona' => 'quatro'])
            ->expectsOutput('A opcao --zona deve ser um inteiro positivo.')
            ->assertExitCode(2);
    }

    #[Test]
    public function comando_aplica_a_geracao_somente_com_execute_explicito(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('planejarLocaisTransmissaoPropriosDosLdas')
            ->once()
            ->with(null)
            ->andReturn([$this->itemPlano('CRIAR', null)]);
        $repository->shouldReceive('gerarLocaisTransmissaoPropriosDosLdas')
            ->once()
            ->with(null)
            ->andReturn([
                'ldas_processados' => 1,
                'locais_transmissao_criados' => 1,
                'locais_transmissao_reutilizados' => 0,
                'preferencias_atualizadas' => 1,
                'locais_reconciliados' => 2,
                'duplicidades_removidas' => 1,
                'referencias_substituidas' => 1,
            ]);
        $this->app->instance(LocalVotacaoRepository::class, $repository);

        $this->artisan('lda:gerar-locais-transmissao-dos-ldas', ['--execute' => true])
            ->expectsOutput('Aplicacao concluida. 1 LDA(s) processado(s), 1 LT(s) criado(s), 0 atualizado(s) e 1 preferencia(s) priorizada(s).')
            ->expectsOutput('Reconciliacao aplicada em 2 local(is): 1 duplicidade(s) removida(s) e 1 referencia(s) substituida(s).')
            ->assertExitCode(0);
    }

    /** @return array<string, mixed> */
    private function itemPlano(
        string $acao,
        ?int $localTransmissaoId,
        int $duplicidadesPrevistas = 0,
        int $substituicoesPrevistas = 0
    ): array
    {
        return [
            'cod_objeto' => 'LV-1',
            'nome' => 'ESCOLA TESTE',
            'zona_num' => 4,
            'municipio' => 'MARECHAL THAUMATURGO',
            'local_transmissao_id' => $localTransmissaoId,
            'duplicidades_previstas' => $duplicidadesPrevistas,
            'substituicoes_previstas' => $substituicoesPrevistas,
            'acao' => $acao,
        ];
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOLDACOMMANDTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoPoloCommandTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOPOLOCOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoPoloCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoPoloCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function comando_executa_dry_run_por_padrao_e_deduplica_os_polos_no_repository(): void
public function comando_rejeita_zona_invalida_sem_consultar_dados(): void
public function comando_aplica_a_geracao_somente_com_execute_explicito(): void
public function comando_informa_migration_pendente_sem_expor_excecao(): void
private function itemPlano(string $acao, ?int $localTransmissaoId): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\Lda\RotaTransmissaoService;
use DomainException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoPoloCommandTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function comando_executa_dry_run_por_padrao_e_deduplica_os_polos_no_repository(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('planejarLocaisTransmissaoPropriosDosPolos')
            ->once()
            ->with(1)
            ->andReturn([
                $this->itemPlano('CRIAR', null),
                $this->itemPlano('ATUALIZAR', 91),
            ]);
        $repository->shouldNotReceive('gerarLocaisTransmissaoPropriosDosPolos');
        $this->app->instance(LocalVotacaoRepository::class, $repository);
        $rotas = Mockery::mock(RotaTransmissaoService::class);
        $rotas->shouldReceive('planejarReconciliacao')->once()->with(1)->andReturn([
            'rotas' => 2,
            'membros' => 10,
            'com_lt_proprio' => 6,
            'proprio_igual_polo' => 2,
        ]);
        $rotas->shouldNotReceive('reconciliarRotas');
        $this->app->instance(RotaTransmissaoService::class, $rotas);

        $this->artisan('lda:gerar-locais-transmissao-dos-polos', ['--zona' => '1'])
            ->expectsOutput('Dry-run concluido. 2 polo(s) de rota processavel(is): 1 LT(s) a criar e 1 a atualizar.')
            ->expectsOutput('Responsabilidade prevista: 2 rota(s), 10 membro(s), 6 com LT próprio e 2 em que próprio e polo coincidem.')
            ->expectsOutput('Nenhum DML executado. Reexecute com --execute somente apos autorizacao explicita.')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_rejeita_zona_invalida_sem_consultar_dados(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldNotReceive('planejarLocaisTransmissaoPropriosDosPolos');
        $repository->shouldNotReceive('gerarLocaisTransmissaoPropriosDosPolos');
        $this->app->instance(LocalVotacaoRepository::class, $repository);
        $rotas = Mockery::mock(RotaTransmissaoService::class);
        $rotas->shouldNotReceive('planejarReconciliacao');
        $rotas->shouldNotReceive('reconciliarRotas');
        $this->app->instance(RotaTransmissaoService::class, $rotas);

        $this->artisan('lda:gerar-locais-transmissao-dos-polos', ['--zona' => 'um'])
            ->expectsOutput('A opcao --zona deve ser um inteiro positivo.')
            ->assertExitCode(2);
    }

    #[Test]
    public function comando_aplica_a_geracao_somente_com_execute_explicito(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('planejarLocaisTransmissaoPropriosDosPolos')
            ->once()
            ->with(null)
            ->andReturn([$this->itemPlano('CRIAR', null)]);
        $repository->shouldReceive('gerarLocaisTransmissaoPropriosDosPolos')
            ->once()
            ->with(null)
            ->andReturn([
                'polos_processados' => 1,
                'locais_transmissao_criados' => 1,
                'locais_transmissao_reutilizados' => 0,
                'preferencias_atualizadas' => 1,
        ]);
        $this->app->instance(LocalVotacaoRepository::class, $repository);
        $rotas = Mockery::mock(RotaTransmissaoService::class);
        $rotas->shouldNotReceive('planejarReconciliacao');
        $rotas->shouldReceive('garantirEstruturaDisponivel')->once();
        $rotas->shouldReceive('reconciliarRotas')->once()->with(null)->andReturn([
            'rotas_reconciliadas' => 1,
            'membros_processados' => 3,
            'vinculos_aplicados' => 2,
            'proprios_iguais_ao_polo' => 1,
        ]);
        $this->app->instance(RotaTransmissaoService::class, $rotas);

        $this->artisan('lda:gerar-locais-transmissao-dos-polos', ['--execute' => true])
            ->expectsOutput('Aplicacao concluida. 1 polo(s) de rota processado(s), 1 LT(s) criado(s), 0 atualizado(s) e 1 preferencia(s) priorizada(s).')
            ->expectsOutput('Responsabilidade aplicada: 1 rota(s), 3 membro(s), 2 vínculo(s) de polo e 1 coincidência(s) entre próprio e polo.')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_informa_migration_pendente_sem_expor_excecao(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('planejarLocaisTransmissaoPropriosDosPolos')
            ->once()
            ->with(null)
            ->andReturn([$this->itemPlano('ATUALIZAR', 91)]);
        $repository->shouldNotReceive('gerarLocaisTransmissaoPropriosDosPolos');
        $this->app->instance(LocalVotacaoRepository::class, $repository);
        $rotas = Mockery::mock(RotaTransmissaoService::class);
        $rotas->shouldReceive('garantirEstruturaDisponivel')
            ->once()
            ->andThrow(new DomainException('Execute a migration de rastreio antes da reconciliacao.'));
        $rotas->shouldNotReceive('reconciliarRotas');
        $this->app->instance(RotaTransmissaoService::class, $rotas);

        $this->artisan('lda:gerar-locais-transmissao-dos-polos', ['--execute' => true])
            ->expectsOutput('Execute a migration de rastreio antes da reconciliacao.')
            ->assertExitCode(1);
    }

    /** @return array<string, mixed> */
    private function itemPlano(string $acao, ?int $localTransmissaoId): array
    {
        return [
            'cod_objeto' => 'LV-POLO-1',
            'nome' => 'ESCOLA POLO',
            'zona_num' => 1,
            'municipio' => 'PORTO ACRE',
            'local_transmissao_id' => $localTransmissaoId,
            'acao' => $acao,
        ];
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOPOLOCOMMANDTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoPreferenciasAtomicidadeTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOPREFERENCIASATOMICIDADETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoPreferenciasAtomicidadeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoPreferenciasAtomicidadeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('planeleito.vw_locais_transmissao_efetivos')->insert([['id' => 1], ['id' => 2]]);
DB::table('planeleito.tbtransmissaovotacao')->insert([
DB::table('planeleito.tbtransmissaovotacao')
DB::table('planeleito.tbtransmissaovotacao')
DB::table('planeleito.tbtransmissaovotacao')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_falha_na_auditoria_da_reinsercao_reverte_remocao_das_preferencias(): void
public function test_promove_local_para_primeira_preferencia_dentro_do_dominio_number_3(): void
public function test_falha_fisica_da_reinsercao_reverte_remocao_das_preferencias(): void
private function auditRepositoryQueFalhaNoInsert(): AuditLogRepositoryInterface
public function inserir(array $payload): void
public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
private function auditRepositorySemFalha(): AuditLogRepositoryInterface
public function inserir(array $payload): void {}
public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use ReflectionClass;
use RuntimeException;
use Tests\TestCase;

class LocalTransmissaoPreferenciasAtomicidadeTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        DB::statement("ATTACH DATABASE ':memory:' AS planeleito");
        DB::statement('CREATE TABLE planeleito.tbtransmissaovotacao (
            cod_objeto_local TEXT NOT NULL,
            local_transmissao_id INTEGER,
            lda_id INTEGER,
            ordem_preferencia INTEGER NOT NULL CHECK (
                ordem_preferencia BETWEEN 1 AND 999
            ),
            UNIQUE (cod_objeto_local, ordem_preferencia)
        )');
        DB::statement('CREATE TABLE planeleito.vw_locais_transmissao_efetivos (id INTEGER PRIMARY KEY)');

        DB::table('planeleito.vw_locais_transmissao_efetivos')->insert([['id' => 1], ['id' => 2]]);
        DB::table('planeleito.tbtransmissaovotacao')->insert([
            ['cod_objeto_local' => 'LV-1', 'local_transmissao_id' => 1, 'lda_id' => null, 'ordem_preferencia' => 1],
            ['cod_objeto_local' => 'LV-1', 'local_transmissao_id' => 2, 'lda_id' => null, 'ordem_preferencia' => 2],
        ]);

        $reflexao = new ReflectionClass(LocalTransmissaoRepository::class);
        foreach (['ldaIdDisponivel', 'ordemPreferenciaDisponivel'] as $propriedadeNome) {
            $propriedade = $reflexao->getProperty($propriedadeNome);
            $propriedade->setValue(null, true);
        }
    }

    public function test_falha_na_auditoria_da_reinsercao_reverte_remocao_das_preferencias(): void
    {
        $repository = new LocalTransmissaoRepository(new AuditLogService($this->auditRepositoryQueFalhaNoInsert()));

        try {
            $repository->definirLocalTransmissaoComoPrimeiraPreferencia(2, 'LV-1');
            $this->fail('A auditoria do insert deveria falhar.');
        } catch (RuntimeException $exception) {
            $this->assertSame('falha controlada na auditoria do lote', $exception->getMessage());
        }

        $this->assertSame(
            [
                ['local_transmissao_id' => 1, 'ordem_preferencia' => 1],
                ['local_transmissao_id' => 2, 'ordem_preferencia' => 2],
            ],
            DB::table('planeleito.tbtransmissaovotacao')
                ->where('cod_objeto_local', 'LV-1')
                ->orderBy('ordem_preferencia')
                ->get(['local_transmissao_id', 'ordem_preferencia'])
                ->map(static fn ($item): array => (array) $item)
                ->all()
        );
    }

    public function test_promove_local_para_primeira_preferencia_dentro_do_dominio_number_3(): void
    {
        $repository = new LocalTransmissaoRepository(new AuditLogService($this->auditRepositorySemFalha()));

        $repository->definirLocalTransmissaoComoPrimeiraPreferencia(2, 'LV-1');

        $this->assertSame(
            [
                ['local_transmissao_id' => 2, 'ordem_preferencia' => 1],
                ['local_transmissao_id' => 1, 'ordem_preferencia' => 2],
            ],
            DB::table('planeleito.tbtransmissaovotacao')
                ->where('cod_objeto_local', 'LV-1')
                ->orderBy('ordem_preferencia')
                ->get(['local_transmissao_id', 'ordem_preferencia'])
                ->map(static fn ($item): array => (array) $item)
                ->all()
        );
    }

    public function test_falha_fisica_da_reinsercao_reverte_remocao_das_preferencias(): void
    {
        DB::unprepared(<<<'SQL'
CREATE TRIGGER planeleito.falhar_reinsercao_preferencia
BEFORE INSERT ON tbtransmissaovotacao
BEGIN
    SELECT RAISE(ABORT, 'falha controlada da reinsercao');
END
SQL);

        $repository = new LocalTransmissaoRepository(new AuditLogService($this->auditRepositorySemFalha()));

        try {
            $repository->definirLocalTransmissaoComoPrimeiraPreferencia(2, 'LV-1');
            $this->fail('O gatilho deveria impedir a reinsercao.');
        } catch (\Throwable $exception) {
            $this->assertStringContainsString('falha controlada da reinsercao', $exception->getMessage());
        }

        $this->assertSame(
            [
                ['local_transmissao_id' => 1, 'ordem_preferencia' => 1],
                ['local_transmissao_id' => 2, 'ordem_preferencia' => 2],
            ],
            DB::table('planeleito.tbtransmissaovotacao')
                ->where('cod_objeto_local', 'LV-1')
                ->orderBy('ordem_preferencia')
                ->get(['local_transmissao_id', 'ordem_preferencia'])
                ->map(static fn ($item): array => (array) $item)
                ->all()
        );
    }

    private function auditRepositoryQueFalhaNoInsert(): AuditLogRepositoryInterface
    {
        return new class implements AuditLogRepositoryInterface
        {
            public function inserir(array $payload): void
            {
                if (($payload['acao'] ?? null) === 'INSERT') {
                    throw new RuntimeException('falha controlada na auditoria do lote');
                }
            }

            public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
            {
                throw new RuntimeException('Nao utilizado neste teste.');
            }
        };
    }

    private function auditRepositorySemFalha(): AuditLogRepositoryInterface
    {
        return new class implements AuditLogRepositoryInterface
        {
            public function inserir(array $payload): void {}

            public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
            {
                throw new RuntimeException('Nao utilizado neste teste.');
            }
        };
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOPREFERENCIASATOMICIDADETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoServiceTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_criacao_derivada_usa_dados_oficiais_e_define_preferencia_propria(): void
public function test_conversao_para_manual_remove_preferencia_propria_e_preserva_outros_locais(): void
public function test_conversao_manual_para_origem_define_dados_oficiais_e_preferencia_propria(): void
public function test_troca_de_origem_remove_preferencia_antiga_e_preserva_outros_destinos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Services\Lda\LocalTransmissaoService;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class LocalTransmissaoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_criacao_derivada_usa_dados_oficiais_e_define_preferencia_propria(): void
    {
        $origem = (object) [
            'id' => 'LV-1',
            'nom_local' => 'ESCOLA OFICIAL',
            'zona_num' => 4,
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'num_latitude' => -9.9,
            'num_longitude' => -67.8,
        ];
        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarOrigemLocalVotacaoNoEscopo')
            ->once()->with('LV-1', [4], false)->andReturn($origem);
        $repository->shouldReceive('origemVinculadaAOutroLocal')
            ->once()->with('LV-1', null)->andReturnFalse();
        $repository->shouldReceive('criar')->once()->with([
            'nome' => 'ESCOLA OFICIAL',
            'zona_num' => 4,
            'num_latitude' => -9.9,
            'num_longitude' => -67.8,
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'endereco' => null,
            'cod_objeto_local_votacao' => 'LV-1',
        ])->andReturn(90);
        $repository->shouldReceive('sincronizarLocaisVotacaoOrdenados')
            ->once()->with(90, [
                ['codigo' => 'LV-1', 'ordem' => null],
                ['codigo' => 'LV-2', 'ordem' => null],
            ]);
        $repository->shouldReceive('definirLocalTransmissaoComoPrimeiraPreferencia')
            ->once()->with(90, 'LV-1');
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $service = new LocalTransmissaoService($repository);
        $id = $service->criar([
            'local_transmissao_e_local_votacao' => true,
            'cod_objeto_local_votacao' => 'LV-1',
        ], [
            ['codigo' => 'LV-2', 'ordem' => null],
        ], [4], false);

        $this->assertSame(90, $id);
    }

    public function test_conversao_para_manual_remove_preferencia_propria_e_preserva_outros_locais(): void
    {
        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('atualizar')->once()->with(90, [
            'nome' => 'POSTO MANUAL',
            'zona_num' => 4,
            'num_latitude' => null,
            'num_longitude' => null,
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'endereco' => 'RUA MANUAL, 100',
            'cod_objeto_local_votacao' => null,
        ]);
        $repository->shouldReceive('removerPreferenciaPropria')
            ->once()->with(90, 'LV-ANTIGO');
        $repository->shouldReceive('sincronizarLocaisVotacaoOrdenados')
            ->once()->with(90, [
                ['codigo' => 'LV-2', 'ordem' => null],
            ]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $service = new LocalTransmissaoService($repository);
        $service->atualizar((object) [
            'id' => 90,
            'cod_objeto_local_votacao' => 'LV-ANTIGO',
        ], [
            'local_transmissao_e_local_votacao' => false,
            'cod_objeto_local_votacao' => null,
            'nome' => 'POSTO MANUAL',
            'zona_num' => 4,
            'num_latitude' => null,
            'num_longitude' => null,
            'cod_objeto_localidade' => 'LOC-1',
            'cod_objeto_bairro' => 'BAI-1',
            'endereco' => 'RUA MANUAL, 100',
        ], [
            ['codigo' => 'LV-ANTIGO', 'ordem' => null],
            ['codigo' => 'LV-2', 'ordem' => null],
        ], [4], false);

        $this->addToAssertionCount(1);
    }

    public function test_conversao_manual_para_origem_define_dados_oficiais_e_preferencia_propria(): void
    {
        $origem = (object) [
            'nom_local' => 'ESCOLA NOVA',
            'zona_num' => 7,
            'cod_objeto_localidade' => 'LOC-7',
            'cod_objeto_bairro' => 'BAI-7',
            'num_latitude' => -9.7,
            'num_longitude' => -67.7,
        ];
        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarOrigemLocalVotacaoNoEscopo')
            ->once()->with('LV-NOVA', [7], false)->andReturn($origem);
        $repository->shouldReceive('origemVinculadaAOutroLocal')
            ->once()->with('LV-NOVA', 90)->andReturnFalse();
        $repository->shouldReceive('atualizar')->once()->with(90, [
            'nome' => 'ESCOLA NOVA',
            'zona_num' => 7,
            'num_latitude' => -9.7,
            'num_longitude' => -67.7,
            'cod_objeto_localidade' => 'LOC-7',
            'cod_objeto_bairro' => 'BAI-7',
            'endereco' => null,
            'cod_objeto_local_votacao' => 'LV-NOVA',
        ]);
        $repository->shouldReceive('sincronizarLocaisVotacaoOrdenados')
            ->once()->with(90, [
                ['codigo' => 'LV-NOVA', 'ordem' => null],
                ['codigo' => 'LV-2', 'ordem' => null],
            ]);
        $repository->shouldReceive('definirLocalTransmissaoComoPrimeiraPreferencia')
            ->once()->with(90, 'LV-NOVA');
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $service = new LocalTransmissaoService($repository);
        $service->atualizar((object) [
            'id' => 90,
            'cod_objeto_local_votacao' => null,
        ], [
            'local_transmissao_e_local_votacao' => true,
            'cod_objeto_local_votacao' => 'LV-NOVA',
        ], [
            ['codigo' => 'LV-2', 'ordem' => null],
        ], [7], false);

        $this->addToAssertionCount(1);
    }

    public function test_troca_de_origem_remove_preferencia_antiga_e_preserva_outros_destinos(): void
    {
        $origem = (object) [
            'nom_local' => 'ESCOLA B',
            'zona_num' => 4,
            'cod_objeto_localidade' => 'LOC-4',
            'cod_objeto_bairro' => 'BAI-4',
            'num_latitude' => null,
            'num_longitude' => null,
        ];
        $repository = Mockery::mock(LocalTransmissaoRepository::class);
        $repository->shouldReceive('buscarOrigemLocalVotacaoNoEscopo')
            ->once()->with('LV-B', [4], false)->andReturn($origem);
        $repository->shouldReceive('origemVinculadaAOutroLocal')
            ->once()->with('LV-B', 90)->andReturnFalse();
        $repository->shouldReceive('atualizar')->once();
        $repository->shouldReceive('removerPreferenciaPropria')
            ->once()->with(90, 'LV-A');
        $repository->shouldReceive('sincronizarLocaisVotacaoOrdenados')
            ->once()->with(90, [
                ['codigo' => 'LV-B', 'ordem' => null],
                ['codigo' => 'LV-2', 'ordem' => null],
            ]);
        $repository->shouldReceive('definirLocalTransmissaoComoPrimeiraPreferencia')
            ->once()->with(90, 'LV-B');
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());

        $service = new LocalTransmissaoService($repository);
        $service->atualizar((object) [
            'id' => 90,
            'cod_objeto_local_votacao' => 'LV-A',
        ], [
            'local_transmissao_e_local_votacao' => true,
            'cod_objeto_local_votacao' => 'LV-B',
        ], [
            ['codigo' => 'LV-A', 'ordem' => null],
            ['codigo' => 'LV-2', 'ordem' => null],
        ], [4], false);

        $this->addToAssertionCount(1);
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoUiTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_locais_de_transmissao_usa_tabela_de_coluna_unica_responsiva(): void
public function listagem_filtra_lts_com_select2_multiselect_antes_da_paginacao(): void
public function formulario_de_local_transmissao_expoe_zona_e_excecoes_controladas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoUiTest extends TestCase
{
    #[Test]
    public function tela_de_locais_de_transmissao_usa_tabela_de_coluna_unica_responsiva(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<th scope="col">Local</th>', $conteudo);
        $this->assertStringContainsString('<th scope="col">Ações</th>', $conteudo);
        $this->assertStringContainsString('fa-layer-group fa-fw"></i> Zona', $conteudo);
        $this->assertStringContainsString('fa-map-location-dot fa-fw', $conteudo);
        $this->assertStringContainsString('$item->municipio', $conteudo);
        $this->assertStringContainsString('$item->endereco', $conteudo);
        $this->assertStringContainsString('$item->rotas_polo', $conteudo);
        $this->assertStringContainsString('$item->rotas_faz_parte', $conteudo);
        $this->assertStringContainsString('$item->rotas_transmite_bu', $conteudo);
        $this->assertStringContainsString('É polo da:', $conteudo);
        $this->assertStringContainsString('Faz parte da:', $conteudo);
        $this->assertStringContainsString('Transmite BU de:', $conteudo);
        $this->assertStringContainsString('Local de transmissão', $conteudo);
        $this->assertStringContainsString('Polo de rota', $conteudo);
        $this->assertStringContainsString('aria-label="Editar local de transmissão"', $conteudo);
        $this->assertStringContainsString('aria-label="Excluir local de transmissão"', $conteudo);
        $this->assertStringContainsString('{{ $locais->links(\'pagination::bootstrap-5\') }}', $conteudo);
        $this->assertStringNotContainsString('@push(\'styles\')', $conteudo);
    }

    #[Test]
    public function listagem_filtra_lts_com_select2_multiselect_antes_da_paginacao(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="local_transmissao_ids[]"', $conteudo);
        $this->assertStringContainsString('id="filtroLocaisTransmissao"', $conteudo);
        $this->assertStringContainsString('class="form-select form-select-sm select2"', $conteudo);
        $this->assertStringContainsString('multiple', $conteudo);
        $this->assertStringContainsString('$locaisTransmissaoOpcoes', $conteudo);
        $this->assertStringContainsString('Aplicar filtros', $conteudo);
        $this->assertStringContainsString('filtroLocaisTransmissao.select2({', $conteudo);
        $this->assertStringNotContainsString('type="text" id="filtroLocais"', $conteudo);
        $this->assertStringNotContainsString("querySelectorAll('#listaLocais tr[data-busca]')", $conteudo);
        $this->assertStringNotContainsString('data-busca=', $conteudo);
    }

    #[Test]
    public function formulario_de_local_transmissao_expoe_zona_e_excecoes_controladas(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/local_transmissao_form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="zona_num"', $conteudo);
        $this->assertStringContainsString('name="endereco"', $conteudo);
        $this->assertStringContainsString('maxlength="400"', $conteudo);
        $this->assertStringContainsString('[name="endereco"]', $conteudo);
        $this->assertStringContainsString('Permitir zona diferente do local de transmissão', $conteudo);
        $this->assertStringContainsString('name="permitir_zona_diferente"', $conteudo);
        $this->assertStringContainsString('Incluir locais que já possuem local de transmissão/LDA', $conteudo);
        $this->assertStringContainsString('name="incluir_preferencias_existentes"', $conteudo);
        $this->assertStringContainsString('id="locaisVotacaoAdicionar"', $conteudo);
        $this->assertStringContainsString('<i class="fa-solid fa-plus"></i> Adicionar', $conteudo);
        $this->assertStringContainsString('id="locaisPreferenciasHidden"', $conteudo);
        $this->assertStringContainsString('class="list-group mt-2"', $conteudo);
        $this->assertStringContainsString("input.name = 'locais_votacao[]';", $conteudo);
        $this->assertStringContainsString('id="locaisPreferenciasFiltro"', $conteudo);
        $this->assertStringContainsString('filtrarLocaisSelecionados', $conteudo);
        $this->assertStringContainsString("type: 'POST'", $conteudo);
        $this->assertStringContainsString("locais_selecionados: locaisSelecionados.join(',')", $conteudo);
        $this->assertStringNotContainsString('locais_selecionados: locaisSelecionados,', $conteudo);
        $this->assertStringContainsString("'data-preferencia-informativa': true", $conteudo);
        $this->assertStringContainsString('`${ordemValor}ª preferência`', $conteudo);
        $this->assertStringNotContainsString("'data-preferencia-readonly': true", $conteudo);
        $this->assertStringNotContainsString('readonly: true', $conteudo);
        $this->assertStringNotContainsString('ordens_preferencia', $conteudo);
        $this->assertStringNotContainsString('<label class="form-label small text-muted mb-1">Preferência</label>', $conteudo);
        $this->assertStringNotContainsString('<label class="form-label small text-muted mb-1">Ordem</label>', $conteudo);
        $this->assertStringContainsString('btnAdicionarLocal.on(\'click\'', $conteudo);
        $this->assertStringContainsString('fa-solid fa-trash', $conteudo);
        $this->assertStringNotContainsString('id="locaisVotacaoSelect" name="locais_votacao[]"', $conteudo);
        $this->assertStringNotContainsString('id="locaisVotacaoSelect" name="locais_votacao[]" class="form-select select2" multiple', $conteudo);
        $this->assertStringContainsString('contexto_local_transmissao: 1', $conteudo);
        $this->assertStringContainsString("'via_rota' => trim", $conteudo);
        $this->assertStringContainsString('item.vinculo_rota_obrigatorio', $conteudo);
        $this->assertStringContainsString("'Vínculo obrigatório herdado da rota'", $conteudo);
        $this->assertStringContainsString('text-bg-info mt-1', $conteudo);
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoZonaMigrationTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOZONAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoZonaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoZonaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_zona_obrigatoria_em_local_transmissao_com_backfill(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoZonaMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_zona_obrigatoria_em_local_transmissao_com_backfill(): void
    {
        $arquivo = database_path('migrations/2026_07_12_120000_add_zona_num_to_local_transmissao.php');
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ALTER TABLE planeleito.local_transmissao ADD (zona_num NUMBER(3))', $conteudo);
        $this->assertStringContainsString('planeleito.local_votacao_st', $conteudo);
        $this->assertStringContainsString('cod_objeto_local_votacao', $conteudo);
        $this->assertStringContainsString('cod_objeto_localidade', $conteudo);
        $this->assertStringContainsString('ALTER TABLE planeleito.local_transmissao MODIFY (zona_num NUMBER(3) NOT NULL)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE planeleito.local_transmissao DROP COLUMN zona_num', $conteudo);
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOZONAMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MonitoramentoLdaUiTest.php`
## <TESTS_UNIT_MONITORAMENTOLDAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MonitoramentoLdaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MonitoramentoLdaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_monitoramento_lda_usa_nova_tabela_de_situacao_consolidada(): void
public function javascript_renderiza_colunas_dinamicas_datas_operacionais_e_polling_do_monitoramento_lda(): void
public function javascript_persiste_filtros_navegaveis_sem_persistir_turno(): void
public function tela_de_monitoramento_lda_nao_expoe_turno_como_filtro_editavel(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class MonitoramentoLdaUiTest extends TestCase
{
    #[Test]
    public function tela_de_monitoramento_lda_usa_nova_tabela_de_situacao_consolidada(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/monitoramento.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<tr id="monitoramentoTabelaHeaderRow">', $conteudo);
        $this->assertStringContainsString('<th class="text-center" style="width: 80px;">Zona</th>', $conteudo);
        $this->assertStringContainsString('<th>LDA</th>', $conteudo);
        $this->assertStringContainsString('<th class="text-center" style="width: 160px;">Última atualização</th>', $conteudo);
        $this->assertStringContainsString('<th class="text-center" style="width: 120px;">Mensageria</th>', $conteudo);

        $this->assertStringNotContainsString('<th>Local</th>', $conteudo);
        $this->assertStringNotContainsString('id="ldaMonitoramentoSecao"', $conteudo);
        $this->assertStringContainsString('id="ldaMonitoramentoBusca"', $conteudo);
        $this->assertStringContainsString('id="monitoramentoTabelaBody"', $conteudo);
        $this->assertStringContainsString('<template id="monitoramentoRowTemplate">', $conteudo);
    }

    #[Test]
    public function javascript_renderiza_colunas_dinamicas_datas_operacionais_e_polling_do_monitoramento_lda(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-monitoramento.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("const zonaSelect = document.getElementById('ldaMonitoramentoZona');", $conteudo);
        $this->assertStringContainsString("const municipioSelect = document.getElementById('ldaMonitoramentoMunicipio');", $conteudo);
        $this->assertStringContainsString("const buscaInput = document.getElementById('ldaMonitoramentoBusca');", $conteudo);
        $this->assertStringContainsString("const headerRow = document.getElementById('monitoramentoTabelaHeaderRow');", $conteudo);
        $this->assertStringContainsString("const renderizarCabecalhosTabela = () => {", $conteudo);
        $this->assertStringContainsString("td.className = 'situacao-celula'", $conteudo);
        $this->assertStringContainsString("classList.add('situacao-marcado')", $conteudo);
        $this->assertStringContainsString("classList.add('situacao-nao-marcado')", $conteudo);
        $this->assertStringContainsString('escapeHtml(item.nome_local)', $conteudo);
        $this->assertStringContainsString('mensageria_url', $conteudo);
        $this->assertStringContainsString('item.dt_saida_real_fmt', $conteudo);
        $this->assertStringContainsString('sit.data_fmt', $conteudo);
        $this->assertStringContainsString('const AudioContextCtor = window.AudioContext || window.webkitAudioContext;', $conteudo);
        $this->assertStringContainsString('window.setInterval(() => {', $conteudo);
    }

    #[Test]
    public function javascript_persiste_filtros_navegaveis_sem_persistir_turno(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-monitoramento.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('new URLSearchParams(window.location.search ||', $conteudo);
        $this->assertStringContainsString("params.get('zona')", $conteudo);
        $this->assertStringContainsString("params.getAll('municipios[]')", $conteudo);
        $this->assertStringContainsString("params.get('busca')", $conteudo);
        $this->assertStringContainsString('window.history.replaceState', $conteudo);
        $this->assertStringContainsString("params.set('zona',", $conteudo);
        $this->assertStringContainsString("params.append('municipios[]',", $conteudo);
        $this->assertStringContainsString("params.set('busca',", $conteudo);
        $this->assertStringContainsString("params.delete('turno')", $conteudo);
        $this->assertStringContainsString('atualizarUrlFiltros', $conteudo);
        $this->assertStringContainsString('aplicarFiltrosIniciaisUrl', $conteudo);
        $this->assertStringNotContainsString("url.searchParams.set('turno'", $conteudo);
    }

    #[Test]
    public function tela_de_monitoramento_lda_nao_expoe_turno_como_filtro_editavel(): void
    {
        $view = file_get_contents(resource_path('views/lda/monitoramento.blade.php'));
        $javascript = file_get_contents(public_path('js/lda-monitoramento.js'));

        $this->assertIsString($view);
        $this->assertIsString($javascript);
        $this->assertStringNotContainsString('id="ldaMonitoramentoTurno"', $view);
        $this->assertStringNotContainsString('for="ldaMonitoramentoTurno"', $view);
        $this->assertStringNotContainsString('Turno</label>', $view);
        $this->assertStringNotContainsString('ldaMonitoramentoTurno', $javascript);
        $this->assertStringNotContainsString('turnoSelect', $javascript);
    }

}
```
</TESTS_UNIT_MONITORAMENTOLDAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatLdaMensagensUiTest.php`
## <TESTS_UNIT_NATLDAMENSAGENSUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatLdaMensagensUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatLdaMensagensUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_do_painel_dedicado_lda_preserva_back_url_e_rotulo_de_origem(): void
public function partial_de_mensagens_lda_preserva_back_url_no_arquivamento_e_estado_vazio_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatLdaMensagensUiTest extends TestCase
{
    #[Test]
    public function view_do_painel_dedicado_lda_preserva_back_url_e_rotulo_de_origem(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/lda/mensagens.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('href="{{ $backUrl ?? route(\'nat.ocorrencias-por-rota.index\') }}"', $conteudo);
        $this->assertStringContainsString('Voltar para Monitoramento LDA', $conteudo);
        $this->assertStringContainsString('\'backUrl\' => $backUrl ?? null', $conteudo);
    }

    #[Test]
    public function partial_de_mensagens_lda_preserva_back_url_no_arquivamento_e_estado_vazio_do_escopo(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/rotas/partials/mensagens.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<input type="hidden" name="back_url" value="{{ $backUrl }}">', $conteudo);
        $this->assertStringContainsString('Nenhuma conversa arquivada encontrada para o seu escopo territorial.', $conteudo);
        $this->assertStringContainsString('Nenhuma conversa ativa encontrada para o seu escopo territorial no momento.', $conteudo);
    }
}
```
</TESTS_UNIT_NATLDAMENSAGENSUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatOcorrenciasPorRotaControllerTest.php`
## <TESTS_UNIT_NATOCORRENCIASPORROTACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatOcorrenciasPorRotaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatOcorrenciasPorRotaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function index_monta_painel_com_uniao_de_ocorrencias_e_mensagens_nao_lidas_sem_duplicar_rota(): void
public function dados_retorna_json_com_html_dos_cards(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Nat\NatOcorrenciasPorRotaController;
use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Nat\NatRotaMensagemRepository;
use App\Services\Nat\NatEscopoService;
use Illuminate\Http\Request;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatOcorrenciasPorRotaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function index_monta_painel_com_uniao_de_ocorrencias_e_mensagens_nao_lidas_sem_duplicar_rota(): void
    {
        session(['macroprojeto_ativo_id' => 12]);

        $repository = Mockery::mock(NatOcorrenciaRepository::class);
        $repository->shouldReceive('contarNaoFinalizadasPorRota')
            ->once()
            ->with([4], false)
            ->andReturn([
                [
                    'rota_id' => 39,
                    'rota_numero' => 902,
                    'rota_descricao' => 'Rota 902',
                    'total' => 3,
                    'atribuidas' => 2,
                    'em_andamento' => 1,
                ],
            ]);

        $mensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $mensagemRepository->shouldReceive('cardsRotaComNaoLidas')
            ->once()
            ->with(12, [4], false, 'nat.teste')
            ->andReturn([
                [
                    'rota_id' => 39,
                    'rota_numero' => 902,
                    'rota_descricao' => 'Rota 902',
                    'nao_lidas' => 5,
                ],
                [
                    'rota_id' => 40,
                    'rota_numero' => 903,
                    'rota_descricao' => 'Rota 903',
                    'nao_lidas' => 2,
                ],
            ]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->once()->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->once()->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);

        $ldaMensagemRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        $ldaMensagemRepository->shouldReceive('cardsLdaComNaoLidas')
            ->once()
            ->with(12, [4], false, 'nat.teste')
            ->andReturn([]);

        $controller = new NatOcorrenciasPorRotaController($repository, $mensagemRepository, $ldaMensagemRepository, $escopo);

        $response = $controller->index(Request::create('/nat/ocorrencias-por-rota', 'GET'));

        $this->assertSame('nat.ocorrencias-por-rota', $response->name());
        $this->assertSame('NAT - Ocorrências por Rota', $response->getData()['titulo'] ?? null);
        $cards = collect($response->getData()['cards'])->keyBy('rota_id');
        $this->assertCount(2, $cards);
        $this->assertSame(3, $cards[39]['total']);
        $this->assertSame(5, $cards[39]['mensagens_nao_lidas']);
        $this->assertSame(0, $cards[40]['total']);
        $this->assertSame(0, $cards[40]['atribuidas']);
        $this->assertSame(0, $cards[40]['em_andamento']);
        $this->assertSame(2, $cards[40]['mensagens_nao_lidas']);
    }

    #[Test]
    public function dados_retorna_json_com_html_dos_cards(): void
    {
        session(['macroprojeto_ativo_id' => 12]);

        $repository = Mockery::mock(NatOcorrenciaRepository::class);
        $repository->shouldReceive('contarNaoFinalizadasPorRota')
            ->once()
            ->with([4], false)
            ->andReturn([]);

        $mensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $mensagemRepository->shouldReceive('cardsRotaComNaoLidas')
            ->once()
            ->with(12, [4], false, 'nat.teste')
            ->andReturn([
                [
                    'rota_id' => 40,
                    'rota_numero' => 903,
                    'rota_descricao' => 'Rota somente com mensagem',
                    'nao_lidas' => 4,
                ],
            ]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->once()->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->once()->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);

        $ldaMensagemRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        $ldaMensagemRepository->shouldReceive('cardsLdaComNaoLidas')
            ->once()
            ->with(12, [4], false, 'nat.teste')
            ->andReturn([]);

        $controller = new NatOcorrenciasPorRotaController($repository, $mensagemRepository, $ldaMensagemRepository, $escopo);

        $response = $controller->dados(Request::create('/nat/ocorrencias-por-rota/dados', 'GET'));

        $this->assertSame(200, $response->getStatusCode());
        $payload = json_decode($response->getContent(), true);
        $this->assertArrayHasKey('html', $payload);
        $this->assertIsString($payload['html']);
        $this->assertStringContainsString('Rota 903', $payload['html']);
        $this->assertStringContainsString('Msgs não lidas', $payload['html']);
        $this->assertStringContainsString('Rota somente com mensagem', $payload['html']);
    }
}
```
</TESTS_UNIT_NATOCORRENCIASPORROTACONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatOcorrenciasPorRotaUiTest.php`
## <TESTS_UNIT_NATOCORRENCIASPORROTAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatOcorrenciasPorRotaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatOcorrenciasPorRotaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_dia_e_nat_expoe_item_de_ocorrencias_por_rota(): void
public function partial_renderiza_grid_de_cards_de_rotas_com_totais_e_estado_vazio(): void
public function view_configura_polling_com_data_url_e_refresh_ms(): void
public function js_de_polling_atualiza_grid_com_html_do_endpoint(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatOcorrenciasPorRotaUiTest extends TestCase
{
    #[Test]
    public function menu_dia_e_nat_expoe_item_de_ocorrencias_por_rota(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Ocorrências por Rota'", $conteudo);
        $this->assertStringContainsString("'route' => 'nat.ocorrencias-por-rota.index'", $conteudo);
        $this->assertStringContainsString("'nat.lda.mensagens.*'", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Dia-E > NAT > Ocorrências por Rota'", $conteudo);
    }

    #[Test]
    public function partial_renderiza_grid_de_cards_de_rotas_com_totais_e_estado_vazio(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/partials/ocorrencias-por-rota-grid.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('$cards', $conteudo);
        $this->assertStringContainsString('Nenhuma rota com ocorrências não finalizadas ou mensagens não lidas no momento.', $conteudo);
        $this->assertStringContainsString('Atribuídas', $conteudo);
        $this->assertStringContainsString('Em andamento', $conteudo);
        $this->assertStringContainsString('mensagens_nao_lidas', $conteudo);
        $this->assertStringContainsString('Msgs não lidas', $conteudo);
        $this->assertStringContainsString("route('nat.rotas.index'", $conteudo);
        $this->assertStringContainsString("route('nat.lda.mensagens.index'", $conteudo);
    }

    #[Test]
    public function view_configura_polling_com_data_url_e_refresh_ms(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/ocorrencias-por-rota.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('natOcorrenciasPorRotaGrid', $conteudo);
        $this->assertStringContainsString('data-url=', $conteudo);
        $this->assertStringContainsString('data-refresh-ms=', $conteudo);
        $this->assertStringContainsString("route('nat.ocorrencias-por-rota.dados')", $conteudo);
        $this->assertStringContainsString('nat-ocorrencias-por-rota.js', $conteudo);
    }

    #[Test]
    public function js_de_polling_atualiza_grid_com_html_do_endpoint(): void
    {
        $conteudo = file_get_contents(public_path('js/nat-ocorrencias-por-rota.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('natOcorrenciasPorRotaGrid', $conteudo);
        $this->assertStringContainsString('dataset.url', $conteudo);
        $this->assertStringContainsString('dataset.refreshMs', $conteudo);
        $this->assertStringContainsString('setInterval', $conteudo);
        $this->assertStringContainsString('payload.html', $conteudo);
    }
}
```
</TESTS_UNIT_NATOCORRENCIASPORROTAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatRotaPainelMapaUiTest.php`
## <TESTS_UNIT_NATROTAPAINELMAPAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatRotaPainelMapaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatRotaPainelMapaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function painel_nat_usa_rota_interna_para_carregar_dados_do_mapa(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatRotaPainelMapaUiTest extends TestCase
{
    #[Test]
    public function painel_nat_usa_rota_interna_para_carregar_dados_do_mapa(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/rotas/painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'painel_mapa_dados' => 'nat.rotas.mapa-dados'", $conteudo);
        $this->assertStringNotContainsString("'painel_mapa_dados' => 'lda.rotas.mapa-dados'", $conteudo);
        $this->assertStringContainsString("'mapaDados' => route(", $conteudo);
    }
}
```
</TESTS_UNIT_NATROTAPAINELMAPAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatRotaPainelScopeControllerTest.php`
## <TESTS_UNIT_NATROTAPAINELSCOPECONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatRotaPainelScopeControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatRotaPainelScopeControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_monitoramento_dados_interno_repassa_escopo_ao_repositorio_de_rotas(): void
public function test_mapa_dados_interno_repassa_escopo_ao_repositorio_de_rotas(): void
public function test_mapa_dados_externo_repassa_escopo_ao_repositorio_de_rotas(): void
public function test_monitoramento_dados_interno_anexa_contagem_de_mesarios_na_listagem(): void
public function test_monitoramento_mesarios_externo_retorna_mesarios_do_local_sob_demanda_em_rota_publica(): void
public function test_index_mensagens_exige_selecao_explicita_de_rota_quando_usuario_tem_multiplas_rotas_no_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Nat\NatRotaPainelController;
use App\Http\Controllers\Nat\NatRotaPainelExternoController;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Lda\RotaRepository;
use App\Services\Nat\NatEscopoService;
use App\Services\Nat\NatExternoSessionService;
use App\Services\Nat\NatMonitoramentoMesariosService;
use App\Services\Nat\NatOcorrenciaBadgeService;
use App\Services\Nat\NatOcorrenciaService;
use App\Services\Nat\NatRotaMensagemService;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class NatRotaPainelScopeControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_monitoramento_dados_interno_repassa_escopo_ao_repositorio_de_rotas(): void
    {
        $natRepository = Mockery::mock(NatOcorrenciaRepository::class);
        $natRepository->shouldReceive('listarRotasNoEscopo')
            ->once()
            ->with([4], false)
            ->andReturn([
                ['id' => 9, 'numero' => 101],
            ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('monitoramentoLocaisPorRotasNoEscopo')
            ->once()
            ->with([9], [4], false)
            ->andReturn([]);

        $localDificilAcessoRepository = Mockery::mock(LocalDificilAcessoRepository::class);
        $localDificilAcessoRepository->shouldReceive('contarMesariosConvocadosPorCodigosLocais')
            ->once()
            ->with([])
            ->andReturn([]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->times(2)->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->times(2)->andReturn(false);

        $controller = new NatRotaPainelController(
            $natRepository,
            $rotaRepository,
            Mockery::mock(NatOcorrenciaService::class),
            Mockery::mock(NatOcorrenciaBadgeService::class),
            $escopo,
            Mockery::mock(NatRotaMensagemService::class),
            new NatMonitoramentoMesariosService($localDificilAcessoRepository),
        );

        $response = $controller->monitoramentoDados(Request::create('/nat/rotas/monitoramento/dados', 'GET'));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_mapa_dados_interno_repassa_escopo_ao_repositorio_de_rotas(): void
    {
        $natRepository = Mockery::mock(NatOcorrenciaRepository::class);
        $natRepository->shouldReceive('listarRotasNoEscopo')
            ->once()
            ->with([4], false)
            ->andReturn([
                ['id' => 9, 'numero' => 101],
            ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('rotasComLocaisNoEscopo')
            ->once()
            ->with([9], [4], false)
            ->andReturn([]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->times(2)->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->times(2)->andReturn(false);

        $controller = new NatRotaPainelController(
            $natRepository,
            $rotaRepository,
            Mockery::mock(NatOcorrenciaService::class),
            Mockery::mock(NatOcorrenciaBadgeService::class),
            $escopo,
            Mockery::mock(NatRotaMensagemService::class),
            new NatMonitoramentoMesariosService(Mockery::mock(LocalDificilAcessoRepository::class)),
        );

        $response = $controller->mapaDados(Request::create('/nat/rotas/painel/mapa/dados', 'GET'));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_mapa_dados_externo_repassa_escopo_ao_repositorio_de_rotas(): void
    {
        $request = Request::create('/rotas-publicas/mapa/dados', 'GET');

        $natRepository = Mockery::mock(NatOcorrenciaRepository::class);
        $natRepository->shouldReceive('listarRotasNoEscopo')
            ->once()
            ->with([4], false)
            ->andReturn([
                ['id' => 9, 'numero' => 101],
            ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('rotasComLocaisNoEscopo')
            ->once()
            ->with([9], [4], false)
            ->andReturn([]);

        $externalSession = Mockery::mock(NatExternoSessionService::class);
        $externalSession->shouldReceive('rotasIds')->once()->with($request)->andReturn([9]);
        $externalSession->shouldReceive('zonas')->twice()->with($request)->andReturn([4]);

        $controller = new NatRotaPainelExternoController(
            $natRepository,
            $rotaRepository,
            Mockery::mock(NatOcorrenciaService::class),
            Mockery::mock(NatOcorrenciaBadgeService::class),
            $externalSession,
            Mockery::mock(NatRotaMensagemService::class),
            new NatMonitoramentoMesariosService(Mockery::mock(LocalDificilAcessoRepository::class)),
        );

        $response = $controller->mapaDados($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_monitoramento_dados_interno_anexa_contagem_de_mesarios_na_listagem(): void
    {
        $natRepository = Mockery::mock(NatOcorrenciaRepository::class);
        $natRepository->shouldReceive('listarRotasNoEscopo')
            ->once()
            ->with([4], false)
            ->andReturn([
                ['id' => 9, 'numero' => 101],
            ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('monitoramentoLocaisPorRotasNoEscopo')
            ->once()
            ->with([9], [4], false)
            ->andReturn([
                [
                    'rota_id' => 9,
                    'rota_numero' => 101,
                    'local_id' => '123',
                    'zona' => '4',
                    'municipio' => 'RIO BRANCO',
                    'local' => 'ESCOLA TESTE',
                    'secoes' => '001, 002',
                ],
            ]);

        $localDificilAcessoRepository = Mockery::mock(LocalDificilAcessoRepository::class);
        $localDificilAcessoRepository->shouldReceive('contarMesariosConvocadosPorCodigosLocais')
            ->once()
            ->with(['123'])
            ->andReturn(['123' => 5]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->times(2)->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->times(2)->andReturn(false);

        $controller = new NatRotaPainelController(
            $natRepository,
            $rotaRepository,
            Mockery::mock(NatOcorrenciaService::class),
            Mockery::mock(NatOcorrenciaBadgeService::class),
            $escopo,
            Mockery::mock(NatRotaMensagemService::class),
            new NatMonitoramentoMesariosService($localDificilAcessoRepository),
        );

        $response = $controller->monitoramentoDados(Request::create('/nat/rotas/monitoramento/dados', 'GET'));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame(5, $response->getData(true)[0]['qtd_mesarios_convocados'] ?? null);
    }

    public function test_monitoramento_mesarios_externo_retorna_mesarios_do_local_sob_demanda_em_rota_publica(): void
    {
        $request = Request::create('/rotas-publicas/nat/painel/monitoramento/mesarios', 'GET', [
            'local_id' => '123',
        ]);

        $natRepository = Mockery::mock(NatOcorrenciaRepository::class);
        $natRepository->shouldReceive('listarRotasNoEscopo')
            ->once()
            ->with([4], false)
            ->andReturn([
                ['id' => 9, 'numero' => 101],
            ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('monitoramentoLocaisPorRotasNoEscopo')
            ->once()
            ->with([9], [4], false)
            ->andReturn([
                [
                    'rota_id' => 9,
                    'rota_numero' => 101,
                    'local_id' => '123',
                    'zona' => '4',
                    'municipio' => 'RIO BRANCO',
                    'local' => 'ESCOLA TESTE',
                    'secoes' => '001, 002',
                ],
            ]);

        $localDificilAcessoRepository = Mockery::mock(LocalDificilAcessoRepository::class);
        $localDificilAcessoRepository->shouldReceive('listarMesariosConvocadosPorCodigoLocal')
            ->once()
            ->with('123')
            ->andReturn([
                [
                    'nom_eleitor' => 'JOAO TESTE',
                    'cargo_nome' => 'PRESIDENTE',
                    'telefone' => '99999-0000',
                ],
            ]);

        $externalSession = Mockery::mock(NatExternoSessionService::class);
        $externalSession->shouldReceive('rotasIds')->once()->with($request)->andReturn([9]);
        $externalSession->shouldReceive('zonas')->twice()->with($request)->andReturn([4]);

        $controller = new NatRotaPainelExternoController(
            $natRepository,
            $rotaRepository,
            Mockery::mock(NatOcorrenciaService::class),
            Mockery::mock(NatOcorrenciaBadgeService::class),
            $externalSession,
            Mockery::mock(NatRotaMensagemService::class),
            new NatMonitoramentoMesariosService($localDificilAcessoRepository),
        );

        $response = $controller->monitoramentoMesarios($request);

        $this->assertSame(200, $response->getStatusCode());
        $payload = $response->getData(true);
        $this->assertSame(1, $payload['total'] ?? null);
        $this->assertStringContainsString('JOAO TESTE', $payload['html'] ?? '');
        $this->assertStringContainsString('PRESIDENTE', $payload['html'] ?? '');
        $this->assertStringContainsString('99999-0000', $payload['html'] ?? '');
    }

    public function test_index_mensagens_exige_selecao_explicita_de_rota_quando_usuario_tem_multiplas_rotas_no_escopo(): void
    {
        $natRepository = Mockery::mock(NatOcorrenciaRepository::class);
        $natRepository->shouldReceive('listarRotasNoEscopo')
            ->once()
            ->with([4], false)
            ->andReturn([
                ['id' => 9, 'numero' => 101],
                ['id' => 10, 'numero' => 102],
            ]);

        $mensagemService = Mockery::mock(NatRotaMensagemService::class);
        $mensagemService->shouldNotReceive('montarPainel');
        $mensagemService->shouldReceive('resumo')
            ->once()
            ->with(
                Mockery::on(static fn (array $rotas): bool => count($rotas) === 2
                    && (int) ($rotas[0]['id'] ?? 0) === 9
                    && (int) ($rotas[1]['id'] ?? 0) === 10),
                12,
                ['login' => 'nat.teste', 'nome' => 'NAT Teste'],
                null,
                [4],
                false
            )
            ->andReturn(['total_nao_lidas' => 0]);

        $badgeService = Mockery::mock(NatOcorrenciaBadgeService::class);
        $badgeService->shouldReceive('resumo')
            ->once()
            ->with(
                Mockery::on(static fn (array $rotas): bool => count($rotas) === 2
                    && (int) ($rotas[0]['id'] ?? 0) === 9
                    && (int) ($rotas[1]['id'] ?? 0) === 10),
                [4],
                false,
                Mockery::type(Request::class)
            )
            ->andReturn(['total_abertas' => 0, 'total_novas' => 0]);

        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->times(3)->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->times(3)->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);

        $controller = new NatRotaPainelController(
            $natRepository,
            Mockery::mock(RotaRepository::class),
            Mockery::mock(NatOcorrenciaService::class),
            $badgeService,
            $escopo,
            $mensagemService,
            new NatMonitoramentoMesariosService(Mockery::mock(LocalDificilAcessoRepository::class)),
        );

        session(['macroprojeto_ativo_id' => 12]);

        $response = $controller->index(Request::create('/nat/rotas', 'GET', ['aba' => 'mensagens']));

        $this->assertSame('nat.rotas.painel', $response->name());
        $mensagensPainel = $response->getData()['mensagensPainel'] ?? [];
        $this->assertFalse($mensagensPainel['habilitado'] ?? true);
        $this->assertSame('Selecione uma ou mais rotas no filtro acima para visualizar e enviar mensagens.', $mensagensPainel['motivo'] ?? null);
    }
}
```
</TESTS_UNIT_NATROTAPAINELSCOPECONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatRotasMapaRetornoUiTest.php`
## <TESTS_UNIT_NATROTASMAPARETORNOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatRotasMapaRetornoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatRotasMapaRetornoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function partial_do_mapa_nat_expoe_botao_de_home_ao_lado_do_atualizar_na_legenda(): void
public function css_compartilhado_define_estilo_compacto_do_botao_de_home_no_mapa_nat(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatRotasMapaRetornoUiTest extends TestCase
{
    #[Test]
    public function partial_do_mapa_nat_expoe_botao_de_home_ao_lado_do_atualizar_na_legenda(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/rotas/partials/mapa.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="rotaMapaVoltarPainel"', $conteudo);
        $this->assertStringContainsString('rota-mapa-retorno', $conteudo);
        $this->assertStringContainsString('route($routeNames[\'painel_index\'], $painelRetornoParams)', $conteudo);
        $this->assertStringContainsString("'aba' => 'ocorrencias'", $conteudo);
        $this->assertStringContainsString('fa-house', $conteudo);
        $this->assertStringContainsString('title="Voltar ao painel"', $conteudo);
        $this->assertStringContainsString('aria-label="Voltar ao painel"', $conteudo);
        $this->assertStringNotContainsString('<span>Voltar ao painel</span>', $conteudo);
        $this->assertStringContainsString('rotaMapaRefresh', $conteudo);
    }

    #[Test]
    public function css_compartilhado_define_estilo_compacto_do_botao_de_home_no_mapa_nat(): void
    {
        foreach ([
            public_path('css/lda-mapa.css'),
            public_path('rotas-publicas/css/lda-mapa.css'),
        ] as $arquivo) {
            $conteudo = file_get_contents($arquivo);

            $this->assertIsString($conteudo);
            $this->assertStringContainsString('.rota-mapa-retorno {', $conteudo);
            $this->assertStringContainsString('display: inline-flex;', $conteudo);
            $this->assertStringContainsString('width: 2rem;', $conteudo);
            $this->assertStringContainsString('height: 2rem;', $conteudo);
            $this->assertStringContainsString('padding: 0;', $conteudo);
            $this->assertStringContainsString('margin-bottom: 0;', $conteudo);
        }
    }
}
```
</TESTS_UNIT_NATROTASMAPARETORNOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaDashboardServiceTest.php`
## <TESTS_UNIT_NATVISTORIADASHBOARDSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaDashboardServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `final class NatVistoriaDashboardServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function agrupa_rotas_locais_e_secoes_e_calcula_resumo_da_ultima_situacao(): void
public function municipios_deduplica_zonas_pelo_codigo_canonico_da_localidade(): void
public function rotas_do_municipio_sao_deduplicadas_ordenadas_e_rotuladas(): void
public function rota_selecionada_restringe_a_consulta_dentro_do_municipio(): void
public function rota_que_nao_pertence_ao_municipio_falha_fechado_sem_consultar_secoes(): void
public function municipio_fora_do_escopo_falha_fechado_sem_consultar_secoes(): void
private function secao(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Nat\Contracts\NatVistoriaSecaoRepositoryInterface;
use App\Services\Nat\NatVistoriaDashboardService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

final class NatVistoriaDashboardServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function agrupa_rotas_locais_e_secoes_e_calcula_resumo_da_ultima_situacao(): void
    {
        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipios')
            ->once()
            ->with([10, 2], [4], false)
            ->andReturn([
                ['municipio_id' => '16', 'municipio_nome' => 'RIO BRANCO'],
            ]);
        $repository->shouldReceive('listarRotasPorMunicipio')
            ->once()
            ->with([10, 2], [4], false, '16')
            ->andReturn([
                ['rota_id' => 10, 'rota_numero' => '10', 'rota_descricao' => 'Rota 10'],
                ['rota_id' => 2, 'rota_numero' => '2', 'rota_descricao' => 'Rota 2'],
            ]);
        $repository->shouldReceive('listarTodos')
            ->once()
            ->with([10, 2], 7, [4], false, ['municipio_id' => '16'])
            ->andReturn([
                $this->secao(10, '10', 'LOCAL-B', '200', '9', 'COM_PENDENCIA', 509),
                $this->secao(2, '2', 'LOCAL-A', '100', '10', 'NAO_VISTORIADA'),
                $this->secao(2, '2', 'LOCAL-A', '100', '2', 'CONFORME', 502),
                $this->secao(2, '2', 'LOCAL-C', '150', '3', 'CONFORME', 503),
                $this->secao(10, '10', 'LOCAL-B', '200', '1', 'NAO_VISTORIADA'),
            ]);

        $resultado = (new NatVistoriaDashboardService($repository))->carregar(
            [10, 2],
            7,
            [4],
            false,
            '16',
        );

        $this->assertNotNull($resultado);
        $this->assertSame('16', $resultado['municipio']['id']);
        $this->assertSame('RIO BRANCO', $resultado['municipio']['nome']);
        $this->assertNull($resultado['rota_selecionada_id']);
        $this->assertSame([2, 10], array_column($resultado['rotas_disponiveis'], 'id'));
        $this->assertSame([
            'total' => 5,
            'vistoriadas' => 3,
            'conformes' => 2,
            'nao_conformes' => 1,
            'nao_vistoriadas' => 2,
            'percentual_vistoriado' => 60.0,
        ], $resultado['resumo']);

        $this->assertSame([2, 10], array_column($resultado['rotas'], 'id'));
        $this->assertSame(['100', '150'], array_column($resultado['rotas'][0]['locais'], 'numero'));
        $this->assertSame(
            ['2', '10'],
            array_column($resultado['rotas'][0]['locais'][0]['secoes'], 'numero'),
        );
        $this->assertSame(3, $resultado['rotas'][0]['resumo']['total']);
        $this->assertSame(2, $resultado['rotas'][0]['resumo']['vistoriadas']);
        $this->assertSame(66.7, $resultado['rotas'][0]['resumo']['percentual_vistoriado']);
        $this->assertSame(509, $resultado['rotas'][1]['locais'][0]['secoes'][1]['vistoria_id']);
    }

    #[Test]
    public function municipios_deduplica_zonas_pelo_codigo_canonico_da_localidade(): void
    {
        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipios')
            ->once()
            ->with([2, 10], [1, 9], false)
            ->andReturn([
                ['municipio_id' => '16', 'municipio_nome' => 'RIO BRANCO'],
                ['municipio_id' => '16', 'municipio_nome' => 'RIO BRANCO'],
                ['municipio_id' => '22', 'municipio_nome' => 'SENA MADUREIRA'],
            ]);

        $resultado = (new NatVistoriaDashboardService($repository))->municipios([2, 10], [1, 9], false);

        $this->assertSame([
            ['id' => '16', 'nome' => 'RIO BRANCO'],
            ['id' => '22', 'nome' => 'SENA MADUREIRA'],
        ], $resultado);
    }

    #[Test]
    public function rotas_do_municipio_sao_deduplicadas_ordenadas_e_rotuladas(): void
    {
        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $repository->shouldReceive('listarRotasPorMunicipio')
            ->once()
            ->with([2, 10], [1, 9], false, '16')
            ->andReturn([
                ['rota_id' => 10, 'rota_numero' => '10', 'rota_descricao' => 'CENTRO'],
                ['rota_id' => 2, 'rota_numero' => '2', 'rota_descricao' => 'Rota 2'],
                ['rota_id' => 2, 'rota_numero' => '2', 'rota_descricao' => 'Rota 2'],
                ['rota_id' => 0, 'rota_numero' => '0', 'rota_descricao' => 'INVÁLIDA'],
            ]);

        $resultado = (new NatVistoriaDashboardService($repository))->rotas(
            [2, 10],
            [1, 9],
            false,
            '16',
        );

        $this->assertSame([
            ['id' => 2, 'numero' => '2', 'descricao' => 'Rota 2', 'rotulo' => 'Rota 2'],
            ['id' => 10, 'numero' => '10', 'descricao' => 'CENTRO', 'rotulo' => 'Rota 10 — CENTRO'],
        ], $resultado);
    }

    #[Test]
    public function rota_selecionada_restringe_a_consulta_dentro_do_municipio(): void
    {
        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipios')->once()->andReturn([
            ['municipio_id' => '16', 'municipio_nome' => 'RIO BRANCO'],
        ]);
        $repository->shouldReceive('listarRotasPorMunicipio')->once()->andReturn([
            ['rota_id' => 2, 'rota_numero' => '2', 'rota_descricao' => 'Rota 2'],
            ['rota_id' => 10, 'rota_numero' => '10', 'rota_descricao' => 'CENTRO'],
        ]);
        $repository->shouldReceive('listarTodos')
            ->once()
            ->with([2, 10], 7, [4], false, ['municipio_id' => '16', 'rota_id' => 10])
            ->andReturn([
                $this->secao(10, '10', 'LOCAL-B', '200', '9', 'CONFORME', 509),
            ]);

        $resultado = (new NatVistoriaDashboardService($repository))->carregar(
            [2, 10],
            7,
            [4],
            false,
            '16',
            10,
        );

        $this->assertNotNull($resultado);
        $this->assertSame(10, $resultado['rota_selecionada_id']);
        $this->assertSame([10], array_column($resultado['rotas'], 'id'));
    }

    #[Test]
    public function rota_que_nao_pertence_ao_municipio_falha_fechado_sem_consultar_secoes(): void
    {
        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipios')->once()->andReturn([
            ['municipio_id' => '16', 'municipio_nome' => 'RIO BRANCO'],
        ]);
        $repository->shouldReceive('listarRotasPorMunicipio')->once()->andReturn([
            ['rota_id' => 2, 'rota_numero' => '2', 'rota_descricao' => 'Rota 2'],
        ]);
        $repository->shouldNotReceive('listarTodos');

        $resultado = (new NatVistoriaDashboardService($repository))->carregar(
            [2, 10],
            7,
            [4],
            false,
            '16',
            10,
        );

        $this->assertNull($resultado);
    }

    #[Test]
    public function municipio_fora_do_escopo_falha_fechado_sem_consultar_secoes(): void
    {
        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $repository->shouldReceive('listarMunicipios')
            ->once()
            ->with([2], [4], false)
            ->andReturn([
                ['municipio_id' => '16', 'municipio_nome' => 'RIO BRANCO'],
            ]);
        $repository->shouldNotReceive('listarTodos');

        $resultado = (new NatVistoriaDashboardService($repository))->carregar(
            [2],
            7,
            [4],
            false,
            '99',
        );

        $this->assertNull($resultado);
    }

    /** @return array<string, mixed> */
    private function secao(
        int $rotaId,
        string $rotaNumero,
        string $localNome,
        string $localNumero,
        string $numero,
        string $situacao,
        ?int $vistoriaId = null,
    ): array {
        return [
            'rota_id' => $rotaId,
            'rota_numero' => $rotaNumero,
            'rota_descricao' => 'Rota '.$rotaNumero,
            'zona_numero' => 4,
            'municipio_id' => '16',
            'municipio_nome' => 'RIO BRANCO',
            'cod_objeto_local' => $localNome,
            'local_numero' => $localNumero,
            'local_nome' => $localNome,
            'cod_objeto_secao' => 'SECAO-'.$rotaId.'-'.$numero,
            'num_secao' => $numero,
            'secao_rotulo' => 'Seção '.$numero,
            'situacao' => $situacao,
            'vistoria_id' => $vistoriaId,
            'dt_vistoria_fmt' => $vistoriaId !== null ? '31/08/2026 10:00' : null,
        ];
    }
}
```
</TESTS_UNIT_NATVISTORIADASHBOARDSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaDashboardUiTest.php`
## <TESTS_UNIT_NATVISTORIADASHBOARDUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaDashboardUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `final class NatVistoriaDashboardUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function fragmento_exibe_cards_filtros_locais_e_estados_visuais_acessiveis(): void
public function tela_e_javascript_encadeiam_municipio_e_rota_e_persistem_ambos_no_polling(): void
public function menu_dia_e_nat_expoe_dashboard_das_vistorias_de_instalacao_das_urnas(): void
private function secao(string $numero, string $situacao, ?int $vistoriaId = null): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

final class NatVistoriaDashboardUiTest extends TestCase
{
    #[Test]
    public function fragmento_exibe_cards_filtros_locais_e_estados_visuais_acessiveis(): void
    {
        $html = view('nat.vistorias.partials.dashboard-conteudo', [
            'dashboard' => [
                'municipio' => ['id' => 16, 'nome' => 'RIO BRANCO'],
                'resumo' => [
                    'total' => 3,
                    'vistoriadas' => 2,
                    'conformes' => 1,
                    'nao_conformes' => 1,
                    'nao_vistoriadas' => 1,
                    'percentual_vistoriado' => 66.7,
                ],
                'rotas' => [[
                    'id' => 39,
                    'numero' => '901',
                    'descricao' => 'Rota 901',
                    'zona_numero' => 4,
                    'resumo' => [
                        'total' => 3,
                        'vistoriadas' => 2,
                        'conformes' => 1,
                        'nao_conformes' => 1,
                        'nao_vistoriadas' => 1,
                        'percentual_vistoriado' => 66.7,
                    ],
                    'locais' => [[
                        'codigo' => 'LOCAL-1',
                        'numero' => '1201',
                        'nome' => 'ESCOLA TESTE',
                        'secoes' => [
                            $this->secao('88', 'NAO_VISTORIADA'),
                            $this->secao('102', 'CONFORME', 502),
                            $this->secao('103', 'COM_PENDENCIA', 503),
                        ],
                    ]],
                ]],
            ],
        ])->render();

        $this->assertStringContainsString('Todas as seções', $html);
        $this->assertStringContainsString('Vistoriadas', $html);
        $this->assertStringContainsString('Conformes', $html);
        $this->assertStringContainsString('Não conformes', $html);
        $this->assertStringContainsString('Não vistoriadas', $html);
        $this->assertStringContainsString('66,7%', $html);
        foreach (['TODAS', 'VISTORIADAS', 'CONFORME', 'COM_PENDENCIA', 'NAO_VISTORIADA'] as $filtro) {
            $this->assertStringContainsString('data-dashboard-filter="'.$filtro.'"', $html);
        }
        $this->assertStringContainsString('aria-pressed="true"', $html);
        $this->assertStringContainsString('aria-pressed="false"', $html);
        $this->assertStringNotContainsString('<div class="text-muted small">Progresso</div>', $html);
        $this->assertStringContainsString('Rota 901', $html);
        $this->assertStringContainsString('data-dashboard-rota', $html);
        $this->assertStringContainsString('data-dashboard-local', $html);
        $this->assertStringContainsString('data-dashboard-secao', $html);
        $this->assertStringContainsString('data-situacao="NAO_VISTORIADA"', $html);
        $this->assertStringContainsString('data-situacao="CONFORME"', $html);
        $this->assertStringContainsString('data-situacao="COM_PENDENCIA"', $html);
        $this->assertStringContainsString('data-dashboard-sem-resultados', $html);
        $this->assertStringContainsString('<h3 class="h6 mb-1">ESCOLA TESTE</h3>', $html);
        $this->assertStringNotContainsString('Local 1201', $html);
        $this->assertStringNotContainsString('seção(ões)', $html);
        $this->assertStringContainsString('bg-secondary', $html);
        $this->assertStringContainsString('bg-success', $html);
        $this->assertStringContainsString('bg-danger', $html);
        $this->assertStringContainsString('Seção 088: Não vistoriada', $html);
        $this->assertStringContainsString('Seção 102: Conforme', $html);
        $this->assertStringContainsString('Seção 103: Não conforme', $html);
        $this->assertStringContainsString('<span>088</span>', $html);
        $this->assertStringNotContainsString('fa-clock', $html);
        $this->assertStringNotContainsString('fa-circle-check', $html);
        $this->assertStringNotContainsString('fa-triangle-exclamation', $html);
        $this->assertStringNotContainsString('088 · Não vistoriada', $html);
        $this->assertStringNotContainsString('102 · Conforme', $html);
        $this->assertStringNotContainsString('103 · Não conforme', $html);
        $this->assertStringContainsString(route('nat.rotas.vistorias.historico', 502), $html);
        $this->assertStringContainsString('aria-valuenow="66.7"', $html);
    }

    #[Test]
    public function tela_e_javascript_encadeiam_municipio_e_rota_e_persistem_ambos_no_polling(): void
    {
        $view = file_get_contents(resource_path('views/nat/vistorias/dashboard.blade.php'));
        $script = file_get_contents(public_path('js/nat-vistoria-dashboard.js'));

        $this->assertIsString($view);
        $this->assertStringContainsString('natVistoriaDashboardMunicipio', $view);
        $this->assertStringContainsString('natVistoriaDashboardRota', $view);
        $this->assertStringContainsString('name="rota_id"', $view);
        $this->assertStringContainsString('Todas as rotas', $view);
        $this->assertStringContainsString('@disabled($municipioSelecionadoId === null)', $view);
        $this->assertStringContainsString('natVistoriaDashboardConteudo', $view);
        $this->assertStringContainsString('data-refresh-ms="30000"', $view);
        $this->assertStringContainsString("route('nat.vistorias.dashboard.dados')", $view);
        $this->assertStringContainsString('Não vistoriada', $view);
        $this->assertStringContainsString('Conforme', $view);
        $this->assertStringContainsString('Não conforme', $view);

        $this->assertIsString($script);
        $this->assertStringContainsString("searchParams.set('municipio_id'", $script);
        $this->assertStringContainsString("searchParams.delete('municipio_id')", $script);
        $this->assertStringContainsString("searchParams.set('rota_id'", $script);
        $this->assertStringContainsString("searchParams.delete('rota_id')", $script);
        $this->assertStringContainsString("searchParams.delete('turno')", $script);
        $this->assertStringContainsString('history.replaceState', $script);
        $this->assertStringContainsString('payload.html', $script);
        $this->assertStringContainsString('payload.rotas', $script);
        $this->assertStringContainsString('atualizarRotas', $script);
        $this->assertStringContainsString("url.searchParams.set('rota_id'", $script);
        $this->assertStringContainsString("rotaSelect.addEventListener('change'", $script);
        $this->assertStringContainsString('setInterval', $script);
        $this->assertStringContainsString('dataset.refreshMs', $script);
        $this->assertStringContainsString("let filtroSituacaoAtual = 'TODAS'", $script);
        $this->assertStringContainsString('aplicarFiltroSituacao', $script);
        $this->assertStringContainsString("'[data-dashboard-secao]'", $script);
        $this->assertStringContainsString("'[data-dashboard-local]'", $script);
        $this->assertStringContainsString("'[data-dashboard-rota]'", $script);
        $this->assertStringContainsString("'[data-dashboard-filter]'", $script);
        $this->assertStringContainsString("filtroSituacaoAtual = 'TODAS'", $script);
        $this->assertStringContainsString("filtroSituacaoAtual === 'VISTORIADAS'", $script);
        $this->assertStringContainsString("situacao === 'CONFORME' || situacao === 'COM_PENDENCIA'", $script);
        $this->assertStringContainsString('conteudo.addEventListener', $script);
        $this->assertStringNotContainsString('sessionStorage', $script);
        $this->assertStringNotContainsString('localStorage', $script);
    }

    #[Test]
    public function menu_dia_e_nat_expoe_dashboard_das_vistorias_de_instalacao_das_urnas(): void
    {
        $menu = collect(config('planeleito_menu.dia_e.sections.NAT'));
        $item = $menu->firstWhere('route', 'nat.vistorias.dashboard.index');

        $this->assertIsArray($item);
        $this->assertSame('Dashboard das vistorias de instalação das urnas', $item['label']);
        $this->assertSame('Dia-E > NAT > Dashboard das vistorias de instalação das urnas', $item['menu_path']);
        $this->assertContains('nat.vistorias.dashboard.*', $item['route_patterns']);
    }

    /** @return array<string, mixed> */
    private function secao(string $numero, string $situacao, ?int $vistoriaId = null): array
    {
        return [
            'numero' => $numero,
            'rotulo' => 'Seção '.$numero,
            'situacao' => $situacao,
            'vistoria_id' => $vistoriaId,
            'dt_vistoria_fmt' => $vistoriaId !== null ? '31/08/2026 10:00' : null,
        ];
    }
}
```
</TESTS_UNIT_NATVISTORIADASHBOARDUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaControllerEquipePersistenciaTest.php`
## <TESTS_UNIT_ROTACONTROLLEREQUIPEPERSISTENCIATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaControllerEquipePersistenciaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaControllerEquipePersistenciaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_store_sincroniza_equipe_apos_criar_rota(): void
public function test_update_sincroniza_equipe_apos_atualizar_rota(): void
public function test_destroy_remove_efeitos_de_transmissao_antes_da_rota_na_mesma_transacao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Http\Requests\Lda\RotaRequest;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use App\Services\Lda\RotaTransmissaoService;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class RotaControllerEquipePersistenciaTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_store_sincroniza_equipe_apos_criar_rota(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 101,
            'DESCRICAO' => 'Rota teste',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => '10',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
            'PERMITIR_BUSCA_ELEITORES_CONVOCADOS_QUALQUER_FUNCAO' => '1',
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['10', '20']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([
            [
                'NUM_INSCRICAO' => '000000000123',
                'CARGO_ID' => '5',
                'COD_OBJETO_LOCAL_RESPONSAVEL' => '20',
            ],
        ]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['10', '20'], 2, [0], true)->andReturn(['10', '20']);
        $rotas->shouldReceive('criar')->once()->with([
            'numero' => 101,
            'descricao' => 'Rota teste',
            'zona_id' => 2,
            'municipio_id' => 16,
            'polo_tipo' => 'LOCAL_VOTACAO',
            'polo_local_votacao_cod_objeto' => '10',
            'polo_local_transmissao_id' => null,
        ])->andReturn(77);
        $rotas->shouldReceive('sincronizarLocais')->once()->with(77, ['10', '20']);

        $locais = Mockery::mock(LocalVotacaoRepository::class);
        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldReceive('buscar')->once()->with(2)->andReturn((object) [
            'id' => 2,
            'num_zona' => 5,
        ]);
        $municipios = Mockery::mock(MunicipioRepository::class);
        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')
            ->once()
            ->with(77, [
                [
                    'NUM_INSCRICAO' => '000000000123',
                    'CARGO_ID' => '5',
                    'COD_OBJETO_LOCAL_RESPONSAVEL' => '20',
                ],
            ], [
                'codigos_locais_da_rota' => ['10', '20'],
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'permitir_busca_eleitores_convocados_qualquer_funcao' => true,
                'zonas_ids_permitidas' => [],
                'zona_numero_da_rota' => '5',
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
                'aplicar_politica_voluntarios_manuais' => true,
                'incluir_voluntarios_manuais' => false,
            ]);

        $transmissao = Mockery::mock(RotaTransmissaoService::class);
        $transmissao->shouldReceive('aplicarEfeitosDaRota')->once()->with(77);

        $controller = new RotaController($rotas, $locais, $zonas, $municipios, $cargos, $equipes, $service, $transmissao);
        $response = $controller->store($request);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }

    public function test_update_sincroniza_equipe_apos_atualizar_rota(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 101,
            'DESCRICAO' => 'Rota teste',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => '10',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['10']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([
            [
                'NUM_INSCRICAO' => '000000000123',
                'CARGO_ID' => '5',
                'COD_OBJETO_LOCAL_RESPONSAVEL' => '10',
            ],
        ]);
        $request->shouldReceive('query')->andReturn(null);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(77, [0], true)->andReturn((object) ['id' => 77]);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['10'], 2, [0], true)->andReturn(['10']);
        $rotas->shouldReceive('atualizar')->once()->with(77, [
            'numero' => 101,
            'descricao' => 'Rota teste',
            'zona_id' => 2,
            'municipio_id' => 16,
            'polo_tipo' => 'LOCAL_VOTACAO',
            'polo_local_votacao_cod_objeto' => '10',
            'polo_local_transmissao_id' => null,
        ]);
        $rotas->shouldReceive('sincronizarLocais')->once()->with(77, ['10']);

        $locais = Mockery::mock(LocalVotacaoRepository::class);
        $zonas = Mockery::mock(ZonaRepository::class);
        $municipios = Mockery::mock(MunicipioRepository::class);
        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')
            ->once()
            ->with(77, [
                [
                    'NUM_INSCRICAO' => '000000000123',
                    'CARGO_ID' => '5',
                    'COD_OBJETO_LOCAL_RESPONSAVEL' => '10',
                ],
            ], [
                'codigos_locais_da_rota' => ['10'],
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'permitir_busca_eleitores_convocados_qualquer_funcao' => false,
                'zonas_ids_permitidas' => [],
                'zona_numero_da_rota' => null,
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
                'aplicar_politica_voluntarios_manuais' => true,
                'incluir_voluntarios_manuais' => false,
            ]);

        $transmissao = Mockery::mock(RotaTransmissaoService::class);
        $transmissao->shouldReceive('removerEfeitosDaRota')->once()->with(77);
        $transmissao->shouldReceive('aplicarEfeitosDaRota')->once()->with(77);

        $controller = new RotaController($rotas, $locais, $zonas, $municipios, $cargos, $equipes, $service, $transmissao);
        $response = $controller->update($request, 77);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }

    public function test_destroy_remove_efeitos_de_transmissao_antes_da_rota_na_mesma_transacao(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(
            static fn (callable $callback): mixed => $callback()
        );

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(77, [4], false)
            ->andReturn((object) ['id' => 77]);
        $rotas->shouldReceive('deletar')->once()->with(77);
        $transmissao = Mockery::mock(RotaTransmissaoService::class);
        $transmissao->shouldReceive('removerEfeitosDaRota')->once()->with(77);

        $controller = new RotaController(
            $rotas,
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
            $transmissao
        );

        $response = $controller->destroy(77);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }
}
```
</TESTS_UNIT_ROTACONTROLLEREQUIPEPERSISTENCIATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaConvocadosBuscaControllerTest.php`
## <TESTS_UNIT_ROTACONVOCADOSBUSCACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaConvocadosBuscaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaConvocadosBuscaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
private function makeController(mixed $equipes): RotaController
public function test_buscar_convocados_retorna_opcoes_por_nome(): void
public function test_buscar_convocados_repassa_zona_id_ao_repositorio(): void
public function test_buscar_convocados_ignora_municipio_id_ao_repositorio(): void
public function test_buscar_convocados_repassa_apenas_zona_quando_municipio_tambem_vem_na_requisicao(): void
public function test_buscar_convocados_ignora_zona_id_nao_numerico(): void
public function test_buscar_convocados_retorna_vazio_quando_zona_esta_fora_do_escopo(): void
public function test_buscar_convocados_retorna_colaborador_interno_deferido_das_acoes_321_e_342(): void
public function test_buscar_convocados_com_checkbox_abre_zona_da_rota_mas_mantem_escopo_do_usuario(): void
public function test_buscar_convocados_com_checkbox_retorna_vazio_sem_zonas_permitidas(): void
public function test_buscar_convocados_deriva_inclusao_de_manual_do_grupo_admin(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class RotaConvocadosBuscaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    private function makeController(mixed $equipes): RotaController
    {
        return new RotaController(
            Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );
    }

    public function test_buscar_convocados_retorna_opcoes_por_nome(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('FUL', 3, [321, 342], [], true)
            ->andReturn([
                (object) [
                    'num_inscricao' => '000000000123',
                    'nom_eleitor' => 'Fulano da Silva',
                    'telefone' => '68999998888',
                    'num_zona' => '1',
                    'nom_localidade' => 'RIO BRANCO',
                ],
            ]);

        $controller = $this->makeController($equipes);
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'ful', 'zona_id' => '3']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
        $payload = $response->getData(true);
        $this->assertSame([[
            'id' => '000000000123',
            'text' => 'Fulano da Silva (68999998888 · Título 000000000123) · Zona 1 · RIO BRANCO',
            'nome' => 'Fulano da Silva',
            'telefone' => '68999998888',
        ]], $payload);
    }

    public function test_buscar_convocados_repassa_zona_id_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('FUL', 3, [321, 342], [], true)
            ->andReturn([]);

        $controller = $this->makeController($equipes);
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'ful', 'zona_id' => '3']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
    }

    public function test_buscar_convocados_ignora_municipio_id_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('FUL', null, [321, 342], [], false)
            ->andReturn([]);

        $controller = $this->makeController($equipes);
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'ful', 'municipio_id' => '7']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
    }

    public function test_buscar_convocados_repassa_apenas_zona_quando_municipio_tambem_vem_na_requisicao(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('FUL', 3, [321, 342], [], true)
            ->andReturn([]);

        $controller = $this->makeController($equipes);
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'ful', 'zona_id' => '3', 'municipio_id' => '7']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
    }

    public function test_buscar_convocados_ignora_zona_id_nao_numerico(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('FUL', null, [321, 342], [], false)
            ->andReturn([]);

        $controller = $this->makeController($equipes);
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'ful', 'zona_id' => 'abc']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
    }

    public function test_buscar_convocados_retorna_vazio_quando_zona_esta_fora_do_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldNotReceive('buscarConvocadosPorNome');

        $controller = new RotaController(
            Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            tap(Mockery::mock(ZonaRepository::class), function ($zonas) {
                $zonas->shouldReceive('buscarPorNumero')->once()->andReturn(collect([
                    (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
                ]));
            }),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'ful', 'zona_id' => '9']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_buscar_convocados_retorna_colaborador_interno_deferido_das_acoes_321_e_342(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('AIE', null, [321, 342], [], false)
            ->andReturn([
                (object) [
                    'num_inscricao' => '002832012410',
                    'nom_eleitor' => 'Aieza dos Santos Bandeira',
                    'telefone' => null,
                    'num_zona' => null,
                    'nom_localidade' => null,
                    'fonte_elegibilidade' => 'colaborador_interno_deferido',
                ],
            ]);

        $controller = $this->makeController($equipes);
        $request = Request::create('/lda/rotas/convocados', 'GET', ['q' => 'aie']);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([[
            'id' => '002832012410',
            'text' => 'Aieza dos Santos Bandeira (002832012410)',
            'nome' => 'Aieza dos Santos Bandeira',
            'telefone' => null,
        ]], $response->getData(true));
    }

    public function test_buscar_convocados_com_checkbox_abre_zona_da_rota_mas_mantem_escopo_do_usuario(): void
    {
        session([
            'cod_zonas_permitidas' => [1, 2],
            'acesso_todas_zonas' => false,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('FUL', null, [321, 342], [44, 55], false)
            ->andReturn([]);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn(collect([
            (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
            (object) ['id' => 55, 'num_zona' => 2, 'descricao' => 'Segunda zona'],
        ]));

        $controller = new RotaController(
            Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );

        $request = Request::create('/lda/rotas/convocados', 'GET', [
            'q' => 'ful',
            'zona_id' => '44',
            'permitir_busca_voluntarios_outras_zonas' => '1',
        ]);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
    }

    public function test_buscar_convocados_com_checkbox_retorna_vazio_sem_zonas_permitidas(): void
    {
        session([
            'cod_zonas_permitidas' => [],
            'acesso_todas_zonas' => false,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldNotReceive('buscarConvocadosPorNome');

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldNotReceive('buscarPorNumero');

        $controller = new RotaController(
            Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );

        $request = Request::create('/lda/rotas/convocados', 'GET', [
            'q' => 'ful',
            'permitir_busca_voluntarios_outras_zonas' => '1',
        ]);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_buscar_convocados_deriva_inclusao_de_manual_do_grupo_admin(): void
    {
        session([
            'cod_zonas_permitidas' => [],
            'acesso_todas_zonas' => false,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('MAR', null, [321, 342], [], false, true)
            ->andReturn([(object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Maria Manual',
                'telefone' => '68999998888',
                'num_zona' => null,
                'nom_localidade' => null,
            ]]);

        $request = Request::create('/lda/rotas/convocados', 'GET', [
            'q' => 'mar',
            'permitir_busca_voluntarios_outras_zonas' => '1',
        ]);
        $response = $this->makeController($equipes)->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame('000000000123', $response->getData(true)[0]['id']);
    }

    public function test_buscar_convocados_repassa_flag_e_contexto_zonal_e_exibe_funcoes_efetivas(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('buscarConvocadosPorNome')
            ->once()
            ->with('MAR', 3, [321, 342], [], true, false, [
                'incluir_convocacoes_efetivas' => true,
                'zona_numero_da_rota' => '5',
                'permitir_busca_voluntarios_outras_zonas' => false,
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
            ])
            ->andReturn([(object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Maria Convocada',
                'telefone' => '68999998888',
                'num_zona' => '5',
                'nom_localidade' => 'RIO BRANCO',
                'funcoes_efetivas' => ['1º Mesário', 'Presidente'],
            ]]);

        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldReceive('buscar')->once()->with(3)->andReturn((object) [
            'id' => 3,
            'num_zona' => 5,
        ]);

        $controller = new RotaController(
            Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            $zonas,
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );
        $request = Request::create('/lda/rotas/convocados', 'GET', [
            'q' => 'mar',
            'zona_id' => '3',
            'permitir_busca_eleitores_convocados_qualquer_funcao' => '1',
        ]);

        $response = $controller->buscarConvocados($request);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame(
            'Maria Convocada (68999998888 · Título 000000000123) · Zona 5 · RIO BRANCO · Funções: 1º Mesário, Presidente',
            $response->getData(true)[0]['text']
        );
    }
}
```
</TESTS_UNIT_ROTACONVOCADOSBUSCACONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaEquipeFormControllerTest.php`
## <TESTS_UNIT_ROTAEQUIPEFORMCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaEquipeFormControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaEquipeFormControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_form_de_rota_carrega_equipe_existente_e_cargos_disponiveis(): void
public function test_form_respeita_old_input_sem_locais_e_preserva_local_responsavel_da_equipe(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Mockery;
use Tests\TestCase;

class RotaEquipeFormControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_form_de_rota_carrega_equipe_existente_e_cargos_disponiveis(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);

        $rota = (object) ['id' => 9, 'numero' => 101, 'descricao' => 'Rota teste', 'zona_id' => 2, 'municipio_id' => 16];
        $locaisSelecionados = [['id' => '1', 'text' => 'Local 1']];
        $equipe = [[
            'num_inscricao' => '000000000123',
            'cargo_id' => 5,
            'cargo_nome' => 'Motorista',
            'nom_eleitor' => 'Fulano da Silva',
        ]];
        $cargos = [
            (object) ['id' => 5, 'text' => 'Motorista'],
            (object) ['id' => 6, 'text' => 'Apoio'],
        ];
        $zonas = collect([(object) ['id' => 2, 'num_zona' => 2, 'descricao' => 'Segunda Zona']]);
        $municipios = collect([(object) ['id' => 16, 'zona_id' => 2, 'localidade' => 'RIO BRANCO', 'cod_objeto_localidade' => '100']]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(9, [0], true)->andReturn($rota);
        $rotas->shouldReceive('listarLocaisVinculadosNoEscopo')->once()->with(9, [0], true)->andReturn($locaisSelecionados);
        $rotas->shouldReceive('listarLocaisTransmissaoPoloNoEscopo')->once()->with([0], true)->andReturn([]);

        $locais = Mockery::mock(LocalVotacaoRepository::class);
        $zonasRepository = Mockery::mock(ZonaRepository::class);
        $zonasRepository->shouldReceive('listar')->once()->andReturn($zonas);
        $municipiosRepository = Mockery::mock(MunicipioRepository::class);
        $municipiosRepository->shouldReceive('listarComZona')->once()->andReturn($municipios);
        $cargosEquipe = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargosEquipe->shouldReceive('listarAtivos')->once()->andReturn($cargos);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('listarPorRota')->once()->with(9)->andReturn($equipe);
        $service = Mockery::mock(RotaEquipeService::class);

        $controller = new RotaController($rotas, $locais, $zonasRepository, $municipiosRepository, $cargosEquipe, $equipes, $service);
        $response = $controller->form(\Illuminate\Http\Request::create('/lda/rotas/form/9', 'GET'), 9);

        $this->assertSame('lda.rotas.form', $response->name());
        $this->assertSame($equipe, $response->getData()['equipeRota']);
        $this->assertSame($cargos, $response->getData()['cargosEquipe']);
        $this->assertSame($locaisSelecionados, $response->getData()['locaisSelecionados']);
        $this->assertEquals($zonas, $response->getData()['zonas']);
        $this->assertEquals($municipios, $response->getData()['municipios']);
    }

    public function test_form_respeita_old_input_sem_locais_e_preserva_local_responsavel_da_equipe(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
        ]);
        session()->flashInput([
            'NUMERO' => '101',
            'EQUIPE' => [[
                'NUM_INSCRICAO' => '000000000123',
                'CARGO_ID' => '5',
                'NOME_EXIBICAO' => 'Fulano da Silva',
                'COD_OBJETO_LOCAL_RESPONSAVEL' => 'LOCAL-10',
            ]],
        ]);

        $rota = (object) ['id' => 9, 'numero' => 101, 'descricao' => 'Rota teste', 'zona_id' => 2, 'municipio_id' => 16];

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(9, [0], true)->andReturn($rota);
        $rotas->shouldReceive('listarLocaisVinculadosNoEscopo')->once()->with(9, [0], true)->andReturn([
            ['id' => 'LOCAL-10', 'text' => 'Local anterior'],
        ]);
        $rotas->shouldNotReceive('buscarLocaisPorIdsNoEscopo');
        $rotas->shouldReceive('listarLocaisTransmissaoPoloNoEscopo')->once()->with([0], true)->andReturn([]);

        $zonasRepository = Mockery::mock(ZonaRepository::class);
        $zonasRepository->shouldReceive('listar')->once()->andReturn(collect());
        $municipiosRepository = Mockery::mock(MunicipioRepository::class);
        $municipiosRepository->shouldReceive('listarComZona')->once()->andReturn(collect());
        $cargosEquipe = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargosEquipe->shouldReceive('listarAtivos')->once()->andReturn([]);
        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('listarPorRota')->once()->with(9)->andReturn([]);

        $controller = new RotaController(
            $rotas,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonasRepository,
            $municipiosRepository,
            $cargosEquipe,
            $equipes,
            Mockery::mock(RotaEquipeService::class)
        );

        $response = $controller->form(\Illuminate\Http\Request::create('/lda/rotas/form/9', 'GET'), 9);
        $dados = $response->getData();

        $this->assertSame([], $dados['locaisSelecionados']);
        $this->assertSame('LOCAL-10', $dados['equipeRota'][0]['cod_objeto_local_responsavel']);
        $this->assertSame('Fulano da Silva', $dados['equipeRota'][0]['nom_eleitor']);
    }
}
```
</TESTS_UNIT_ROTAEQUIPEFORMCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaEquipeFormUiTest.php`
## <TESTS_UNIT_ROTAEQUIPEFORMUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaEquipeFormUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaEquipeFormUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function formulario_de_rota_expoe_bloco_de_equipe_da_rota(): void
public function select2_de_convocados_envia_apenas_zona_id_na_busca(): void
public function checkbox_de_convocados_em_qualquer_funcao_inicia_desmarcado(): void
public function formulario_controla_vinculo_opcional_de_integrante_com_local_da_rota(): void
public function formulario_controla_polo_local_votacao_fora_dos_locais_por_checkbox(): void
public function checkbox_renderiza_estado_coerente_com_locais_e_equipe_carregados(): void
public function checkbox_de_polo_compartilhado_abre_marcado_quando_polo_esta_fora_dos_locais(): void
public function checkbox_de_polo_compartilhado_inicia_oculto_sem_tipo_de_polo_selecionado(): void
private function renderizarFormulario(array $locais, array $equipe): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Support\ViewErrorBag;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaEquipeFormUiTest extends TestCase
{
    #[Test]
    public function formulario_de_rota_expoe_bloco_de_equipe_da_rota(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="campoZona"', $conteudo);
        $this->assertStringContainsString('name="ZONA_ID"', $conteudo);
        $this->assertStringContainsString('id="campoMunicipio"', $conteudo);
        $this->assertStringContainsString('name="MUNICIPIO_ID"', $conteudo);
        $this->assertStringContainsString('data-zona-id="{{ $municipio->zona_id }}"', $conteudo);
        $this->assertStringContainsString('Base operacional da rota', $conteudo);
        $this->assertStringContainsString('name="POLO_TIPO"', $conteudo);
        $this->assertStringContainsString('name="POLO_LOCAL_VOTACAO_COD_OBJETO"', $conteudo);
        $this->assertStringContainsString('name="POLO_LOCAL_TRANSMISSAO_ID"', $conteudo);
        $this->assertStringContainsString('LOCAL_VOTACAO', $conteudo);
        $this->assertStringContainsString('LOCAL_TRANSMISSAO', $conteudo);
        $this->assertStringContainsString('Equipe da rota', $conteudo);
        $this->assertStringContainsString('id="equipeRotaFieldset"', $conteudo);
        $this->assertStringContainsString('id="equipeConvocadoSelect"', $conteudo);
        $this->assertStringContainsString('id="equipeCargoSelect"', $conteudo);
        $this->assertStringContainsString('id="permitirBuscaVoluntariosOutrasZonas"', $conteudo);
        $this->assertStringContainsString('name="PERMITIR_BUSCA_VOLUNTARIOS_OUTRAS_ZONAS"', $conteudo);
        $this->assertStringContainsString('Permitir buscar voluntários de outras zonas', $conteudo);
        $this->assertStringContainsString('id="permitirBuscaEleitoresConvocadosQualquerFuncao"', $conteudo);
        $this->assertStringContainsString('name="PERMITIR_BUSCA_ELEITORES_CONVOCADOS_QUALQUER_FUNCAO"', $conteudo);
        $this->assertStringContainsString('Incluir eleitores convocados em qualquer função', $conteudo);
        $this->assertStringContainsString('data-convocados-url="{{ route(\'lda.rotas.convocados\') }}"', $conteudo);
        $this->assertStringContainsString("zona_id: document.getElementById('campoZona')?.value || ''", $conteudo);
        $this->assertStringContainsString('minimumInputLength: 3', $conteudo);
        $this->assertStringContainsString('Digite pelo menos 3 caracteres para pesquisar por nome.', $conteudo);
        $this->assertStringContainsString('data-equipe-lista', $conteudo);
        $this->assertStringContainsString('name="EQUIPE[__INDEX__][CARGO_ID]"', $conteudo);
        $this->assertStringContainsString('data-equipe-cargo-select', $conteudo);
        $this->assertStringContainsString('data-equipe-template', $conteudo);
        $this->assertStringContainsString('Adicionar integrante', $conteudo);
        $this->assertStringNotContainsString('Observação', $conteudo);
        $this->assertStringNotContainsString('name="EQUIPE[__INDEX__][OBSERVACAO]"', $conteudo);
        $this->assertStringNotContainsString('Nome selecionado', $conteudo);
    }

    #[Test]
    public function select2_de_convocados_envia_apenas_zona_id_na_busca(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/form.blade.php'));

        $this->assertIsString($conteudo);

        $this->assertSame(
            3,
            substr_count($conteudo, "zona_id: document.getElementById('campoZona')?.value || ''"),
            "zona_id deve estar presente nos blocos AJAX de locais, polo compartilhado e convocados"
        );
        $this->assertStringNotContainsString(
            "municipio_id: document.getElementById('campoMunicipio')?.value || ''",
            $conteudo,
            'municipio_id não deve limitar locais, polos ou convocados no formulário'
        );
        $this->assertStringContainsString(
            "permitir_busca_voluntarios_outras_zonas: permitirBuscaVoluntariosOutrasZonas?.checked ? 1 : ''",
            $conteudo
        );
        $this->assertStringContainsString(
            "permitir_busca_eleitores_convocados_qualquer_funcao: permitirBuscaEleitoresConvocadosQualquerFuncao?.checked ? 1 : ''",
            $conteudo
        );
        $this->assertStringContainsString("permitirBuscaVoluntariosOutrasZonas?.addEventListener('change'", $conteudo);
        $this->assertStringContainsString("permitirBuscaEleitoresConvocadosQualquerFuncao?.addEventListener('change'", $conteudo);
        $this->assertStringContainsString("convocadoSelect.val(null).trigger('change')", $conteudo);
    }

    #[Test]
    public function checkbox_de_convocados_em_qualquer_funcao_inicia_desmarcado(): void
    {
        $html = $this->renderizarFormulario([], []);

        $this->assertMatchesRegularExpression(
            '/<input[^>]+id="permitirBuscaEleitoresConvocadosQualquerFuncao"[^>]+name="PERMITIR_BUSCA_ELEITORES_CONVOCADOS_QUALQUER_FUNCAO"/u',
            $html
        );
        $this->assertDoesNotMatchRegularExpression(
            '/<input[^>]+id="permitirBuscaEleitoresConvocadosQualquerFuncao"[^>]+checked/u',
            $html
        );
    }

    #[Test]
    public function formulario_controla_vinculo_opcional_de_integrante_com_local_da_rota(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="permitirVinculoLocalIntegrante"', $conteudo);
        $this->assertStringContainsString('Permitir vincular integrante a um local', $conteudo);
        $this->assertStringContainsString('@checked($vincularIntegranteLocal)', $conteudo);
        $this->assertStringContainsString('id="equipeLocalResponsavelSelect"', $conteudo);
        $this->assertStringContainsString('Local responsável', $conteudo);
        $this->assertStringContainsString('Sem local específico', $conteudo);
        $this->assertStringContainsString('name="EQUIPE[__INDEX__][COD_OBJETO_LOCAL_RESPONSAVEL]"', $conteudo);
        $this->assertStringContainsString('data-equipe-local-wrapper', $conteudo);
        $this->assertStringContainsString('data-equipe-local-select', $conteudo);
        $this->assertStringContainsString('@error("EQUIPE.$index.COD_OBJETO_LOCAL_RESPONSAVEL")', $conteudo);
        $this->assertStringContainsString('sincronizarLocaisResponsaveis', $conteudo);
        $this->assertStringContainsString('limparLocaisResponsaveis', $conteudo);
        $this->assertStringNotContainsString('name="PERMITIR_VINCULO_LOCAL_INTEGRANTE"', $conteudo);
    }

    #[Test]
    public function formulario_controla_polo_local_votacao_fora_dos_locais_por_checkbox(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="permitirPoloLocalVotacaoForaLocais"', $conteudo);
        $this->assertStringContainsString('name="PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS"', $conteudo);
        $this->assertStringContainsString('Permitir polo fora dos locais da rota', $conteudo);
        $this->assertStringContainsString('Polo fora dos locais da rota', $conteudo);
        $this->assertStringContainsString('data-polo-compartilhado-wrapper', $conteudo);
        $this->assertStringContainsString('data-polo-compartilhado-badge', $conteudo);
        $this->assertStringContainsString("contexto: 'polo_local_votacao'", $conteudo);
        $this->assertStringContainsString("permitir_polo_local_votacao_fora_locais: permitirPoloLocalVotacaoForaLocais?.checked ? 1 : ''", $conteudo);
    }

    #[Test]
    public function checkbox_renderiza_estado_coerente_com_locais_e_equipe_carregados(): void
    {
        $htmlSemLocais = $this->renderizarFormulario([], []);
        $this->assertMatchesRegularExpression(
            '/<input[^>]+id="permitirVinculoLocalIntegrante"[^>]+disabled/u',
            $htmlSemLocais
        );
        $this->assertDoesNotMatchRegularExpression(
            '/<input[^>]+id="permitirVinculoLocalIntegrante"[^>]+checked/u',
            $htmlSemLocais
        );

        $htmlComResponsavel = $this->renderizarFormulario(
            [['id' => 'LOCAL-10', 'text' => '5 - Rio Branco - Escola Exemplo (Local 10)']],
            [[
                'num_inscricao' => '000000000123',
                'cargo_id' => 5,
                'nom_eleitor' => 'Maria Teste',
                'cod_objeto_local_responsavel' => 'LOCAL-10',
                'local_responsavel_texto' => '5 - Rio Branco - Escola Exemplo (Local 10)',
            ]]
        );

        $this->assertMatchesRegularExpression(
            '/<input[^>]+id="permitirVinculoLocalIntegrante"[^>]+checked/u',
            $htmlComResponsavel
        );
        $this->assertStringContainsString('<option value="LOCAL-10" selected>', $htmlComResponsavel);
    }

    #[Test]
    public function checkbox_de_polo_compartilhado_abre_marcado_quando_polo_esta_fora_dos_locais(): void
    {
        $html = view('lda.rotas.form', [
            'rota' => (object) [
                'id' => 77,
                'numero' => 12,
                'descricao' => 'Rota teste',
                'zona_id' => 2,
                'municipio_id' => 16,
                'polo_tipo' => 'LOCAL_VOTACAO',
                'polo_local_votacao_cod_objeto' => 'LV99',
                'polo_local_votacao_fora_locais' => 1,
            ],
            'locaisSelecionados' => [
                ['id' => 'LV10', 'text' => '1 - Rio Branco - Escola Vinculada (Local 10)'],
            ],
            'poloLocalVotacaoSelecionado' => [
                'id' => 'LV99',
                'text' => '1 - Rio Branco - Escola Polo (Local 99)',
            ],
            'locaisTransmissaoPolo' => [],
            'zonas' => collect(),
            'municipios' => collect(),
            'cargosEquipe' => [],
            'equipeRota' => [],
            'filtrosListagem' => [],
            'errors' => new ViewErrorBag(),
        ])->render();

        $this->assertMatchesRegularExpression(
            '/<input[^>]+id="permitirPoloLocalVotacaoForaLocais"[^>]+checked/u',
            $html
        );
        $this->assertStringContainsString('<option value="LV99" selected>', $html);
        $this->assertStringContainsString('Polo fora dos locais da rota', $html);
        $this->assertDoesNotMatchRegularExpression(
            '/<div class="[^"]*\bd-none\b[^"]*" data-polo-compartilhado-wrapper>/u',
            $html
        );
    }

    #[Test]
    public function checkbox_de_polo_compartilhado_inicia_oculto_sem_tipo_de_polo_selecionado(): void
    {
        $html = $this->renderizarFormulario([], []);

        $this->assertMatchesRegularExpression(
            '/<div class="[^"]*\bd-none\b[^"]*" data-polo-compartilhado-wrapper>/u',
            $html
        );
        $this->assertMatchesRegularExpression(
            '/<input[^>]+id="permitirPoloLocalVotacaoForaLocais"[^>]+disabled/u',
            $html
        );
    }

    private function renderizarFormulario(array $locais, array $equipe): string
    {
        return view('lda.rotas.form', [
            'rota' => null,
            'locaisSelecionados' => $locais,
            'locaisTransmissaoPolo' => [],
            'zonas' => collect(),
            'municipios' => collect(),
            'cargosEquipe' => [],
            'equipeRota' => $equipe,
            'filtrosListagem' => [],
            'errors' => new ViewErrorBag(),
        ])->render();
    }
}
```
</TESTS_UNIT_ROTAEQUIPEFORMUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaEquipeIndexUiTest.php`
## <TESTS_UNIT_ROTAEQUIPEINDEXUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaEquipeIndexUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaEquipeIndexUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_rotas_exibe_secao_de_equipe_por_rota(): void
public function tela_de_rotas_exibe_nome_e_cargo_dos_integrantes(): void
public function tela_de_rotas_tem_atalho_para_adicionar_integrantes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaEquipeIndexUiTest extends TestCase
{
    #[Test]
    public function tela_de_rotas_exibe_secao_de_equipe_por_rota(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertStringContainsString(
            'Equipe',
            $conteudo,
            'A listagem de rotas deve exibir a equipe de cada rota.'
        );

        $this->assertStringContainsString(
            '$equipesPorRota',
            $conteudo,
            'A view deve consumir a variável $equipesPorRota.'
        );
    }

    #[Test]
    public function tela_de_rotas_exibe_nome_e_cargo_dos_integrantes(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertStringContainsString(
            'nom_eleitor',
            $conteudo,
            'A view deve exibir o nome do integrante da equipe.'
        );

        $this->assertStringContainsString(
            'cargo_nome',
            $conteudo,
            'A view deve exibir o cargo do integrante da equipe.'
        );

        $this->assertStringContainsString('local_responsavel_texto', $conteudo);
        $this->assertStringContainsString('Local responsável:', $conteudo);
    }

    #[Test]
    public function tela_de_rotas_tem_atalho_para_adicionar_integrantes(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertStringContainsString('fa-user-plus', $conteudo);
        $this->assertStringContainsString('title="Adicionar integrantes"', $conteudo);
        $this->assertStringContainsString('#equipeRotaFieldset', $conteudo);
        $this->assertStringContainsString(
            "route('lda.rotas.form', ['id' => \$rota->id] + \$filtrosListagem) }}#equipeRotaFieldset",
            $conteudo,
            'O atalho deve levar ao bloco de equipe preservando os filtros da listagem.'
        );
    }
}
```
</TESTS_UNIT_ROTAEQUIPEINDEXUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaEquipeJsonControllerTest.php`
## <TESTS_UNIT_ROTAEQUIPEJSONCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaEquipeJsonControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaEquipeJsonControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_equipe_retorna_json_da_rota(): void
public function test_equipe_retorna_404_quando_rota_nao_existe_ou_nao_esta_no_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Mockery;
use Tests\TestCase;

class RotaEquipeJsonControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_equipe_retorna_json_da_rota(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(9, [1], false)->andReturn((object) ['id' => 9]);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('listarPorRota')->once()->with(9)->andReturn([
            ['nom_eleitor' => 'FULANO', 'cargo_nome' => 'Motorista'],
        ]);

        $controller = new RotaController(
            $rotas,
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->equipe(9);

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([['nom_eleitor' => 'FULANO', 'cargo_nome' => 'Motorista']], $response->getData(true));
    }

    public function test_equipe_retorna_404_quando_rota_nao_existe_ou_nao_esta_no_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(9, [1], false)->andReturn(null);

        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldNotReceive('listarPorRota');

        $controller = new RotaController(
            $rotas,
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes,
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->equipe(9);

        $this->assertSame(404, $response->getStatusCode());
        $this->assertSame(['mensagem' => 'Rota não encontrada.'], $response->getData(true));
    }
}
```
</TESTS_UNIT_ROTAEQUIPEJSONCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaEquipeServiceTest.php`
## <TESTS_UNIT_ROTAEQUIPESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaEquipeServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaEquipeServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_contrato_registra_bloqueio_global_de_voluntario_em_rotas(): void
public function test_sincronizar_rejeita_numero_de_inscricao_duplicado_na_mesma_rota(): void
public function test_sincronizar_rejeita_convocado_inexistente(): void
public function test_sincronizar_rejeita_integrante_ja_alocado_em_outra_rota(): void
public function test_sincronizar_permite_manter_integrante_na_propria_rota(): void
public function test_sincronizar_persiste_equipe_normalizada(): void
public function test_sincronizar_permite_colaborador_interno_deferido_das_acoes_321_e_342_ausente_em_convocados(): void
public function test_sincronizar_rejeita_voluntario_externo_de_outra_zona_sem_checkbox(): void
public function test_sincronizar_aceita_voluntario_externo_de_outra_zona_permitida_com_checkbox(): void
public function test_sincronizar_rejeita_voluntario_externo_fora_da_acl_mesmo_com_checkbox(): void
public function test_sincronizar_preserva_colaborador_interno_deferido_sem_filtro_zonal(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Services\Lda\RotaEquipeService;
use Illuminate\Validation\ValidationException;
use Mockery;
use Tests\TestCase;

class RotaEquipeServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_contrato_registra_bloqueio_global_de_voluntario_em_rotas(): void
    {
        $conteudo = file_get_contents(base_path('docs/contratos/rota-equipe-integracao.md'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('um voluntario pode estar em no maximo uma rota operacional', $conteudo);
        $this->assertStringContainsString('CASE WHEN rota_id IS NOT NULL THEN TRIM(num_inscricao) END', $conteudo);
        $this->assertStringContainsString('Permitir buscar voluntarios de outras zonas', $conteudo);
        $this->assertStringContainsString('limitada ao escopo territorial efetivo', $conteudo);
    }

    public function test_sincronizar_rejeita_numero_de_inscricao_duplicado_na_mesma_rota(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        $this->expectException(ValidationException::class);

        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
            ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
        ]);
    }

    public function test_sincronizar_rejeita_convocado_inexistente(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnFalse();
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        $this->expectException(ValidationException::class);

        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
        ]);
    }

    public function test_sincronizar_rejeita_integrante_ja_alocado_em_outra_rota(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['000000000123'], 12)
            ->andReturn([[
                'num_inscricao' => '000000000123',
                'rota_id' => 44,
                'rota_numero' => 101,
            ]]);
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        try {
            $service->sincronizar(12, [
                ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
            ]);
            $this->fail('A validacao deveria bloquear voluntario ja alocado em outra rota.');
        } catch (ValidationException $e) {
            $this->assertSame(
                ['O voluntario 000000000123 ja esta alocado na rota 101.'],
                $e->errors()['EQUIPE'] ?? []
            );
        }
    }

    public function test_sincronizar_permite_manter_integrante_na_propria_rota(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['000000000123'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '000000000123',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => null,
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
        ]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_persiste_equipe_normalizada(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['000000000123'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '000000000123',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => null,
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => ' 000000000123 ', 'CARGO_ID' => '5'],
            ['NUM_INSCRICAO' => '', 'CARGO_ID' => ''],
        ]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_permite_colaborador_interno_deferido_das_acoes_321_e_342_ausente_em_convocados(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('002832012410', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['002832012410'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '002832012410',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => null,
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => '002832012410', 'CARGO_ID' => 5],
        ]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_rejeita_voluntario_externo_de_outra_zona_sem_checkbox(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()
            ->with(['000000000123'], [321, 342])
            ->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'voluntario_externo',
                'zona_id' => 7,
            ]]);
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        try {
            $service->sincronizar(12, [
                ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
            ], [
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'zonas_ids_permitidas' => [2, 7],
                'acesso_todas_zonas' => false,
            ]);
            $this->fail('A validacao deveria rejeitar voluntario externo de outra zona sem checkbox.');
        } catch (ValidationException $e) {
            $this->assertSame(
                ['O voluntario informado pertence a outra zona. Marque a opcao para buscar voluntarios de outras zonas.'],
                $e->errors()['EQUIPE.0.NUM_INSCRICAO'] ?? []
            );
        }
    }

    public function test_sincronizar_aceita_voluntario_externo_de_outra_zona_permitida_com_checkbox(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()
            ->with(['000000000123'], [321, 342])
            ->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'voluntario_externo',
                'zona_id' => 7,
            ]]);
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['000000000123'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '000000000123',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => null,
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);
        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
        ], [
            'zona_id_da_rota' => 2,
            'permitir_busca_voluntarios_outras_zonas' => true,
            'zonas_ids_permitidas' => [2, 7],
            'acesso_todas_zonas' => false,
        ]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_rejeita_voluntario_externo_fora_da_acl_mesmo_com_checkbox(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()
            ->with(['000000000123'], [321, 342])
            ->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'voluntario_externo',
                'zona_id' => 9,
            ]]);
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        try {
            $service->sincronizar(12, [
                ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
            ], [
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => true,
                'zonas_ids_permitidas' => [2, 7],
                'acesso_todas_zonas' => false,
            ]);
            $this->fail('A validacao deveria rejeitar voluntario externo fora do escopo territorial.');
        } catch (ValidationException $e) {
            $this->assertSame(
                ['O voluntario informado esta fora do escopo territorial permitido.'],
                $e->errors()['EQUIPE.0.NUM_INSCRICAO'] ?? []
            );
        }
    }

    public function test_sincronizar_preserva_colaborador_interno_deferido_sem_filtro_zonal(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('002832012410', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()
            ->with(['002832012410'], [321, 342])
            ->andReturn([[
                'num_inscricao' => '002832012410',
                'fonte_elegibilidade' => 'colaborador_interno_deferido',
                'zona_id' => null,
            ]]);
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['002832012410'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '002832012410',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => null,
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);
        $service->sincronizar(12, [
            ['NUM_INSCRICAO' => '002832012410', 'CARGO_ID' => 5],
        ], [
            'zona_id_da_rota' => 2,
            'permitir_busca_voluntarios_outras_zonas' => false,
            'zonas_ids_permitidas' => [2],
            'acesso_todas_zonas' => false,
        ]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_persiste_local_responsavel_valido_normalizado(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['000000000123'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '000000000123',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => 'LOCAL-10',
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);
        $service->sincronizar(12, [[
            'NUM_INSCRICAO' => '000000000123',
            'CARGO_ID' => 5,
            'COD_OBJETO_LOCAL_RESPONSAVEL' => ' LOCAL-10 ',
        ]], ['codigos_locais_da_rota' => ['LOCAL-10', 'LOCAL-20']]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_rejeita_local_responsavel_fora_da_rota(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342])
            ->andReturnTrue();
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);

        try {
            $service->sincronizar(12, [[
                'NUM_INSCRICAO' => '000000000123',
                'CARGO_ID' => 5,
                'COD_OBJETO_LOCAL_RESPONSAVEL' => 'LOCAL-99',
            ]], ['codigos_locais_da_rota' => ['LOCAL-10']]);
            $this->fail('A validacao deveria rejeitar local responsavel fora da rota.');
        } catch (ValidationException $e) {
            $this->assertSame(
                ['O local responsável informado deve estar vinculado à rota.'],
                $e->errors()['EQUIPE.0.COD_OBJETO_LOCAL_RESPONSAVEL'] ?? []
            );
        }
    }

    public function test_sincronizar_permite_mesmo_local_para_integrantes_diferentes(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()->with('000000000123', [321, 342])->andReturnTrue();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()->with('000000000456', [321, 342])->andReturnTrue();
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()
            ->with(['000000000123', '000000000456'], 12)
            ->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')
            ->once()
            ->with('ROTA', 12, [[
                'num_inscricao' => '000000000123',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => 'LOCAL-10',
            ], [
                'num_inscricao' => '000000000456',
                'cargo_id' => 5,
                'observacao' => null,
                'cod_objeto_local_responsavel' => 'LOCAL-10',
            ]]);

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->twice()->with(5)->andReturn((object) ['id' => 5]);

        $service = new RotaEquipeService($equipes, $cargos);
        $service->sincronizar(12, [[
            'NUM_INSCRICAO' => '000000000123',
            'CARGO_ID' => 5,
            'COD_OBJETO_LOCAL_RESPONSAVEL' => 'LOCAL-10',
        ], [
            'NUM_INSCRICAO' => '000000000456',
            'CARGO_ID' => 5,
            'COD_OBJETO_LOCAL_RESPONSAVEL' => 'LOCAL-10',
        ]], ['codigos_locais_da_rota' => ['LOCAL-10']]);

        $this->assertTrue(true);
    }

    public function test_sincronizar_rejeita_supervisor_de_predio_ativo(): void
    {
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldNotReceive('integranteRotaExistePorInscricao');
        $equipes->shouldReceive('listarSupervisoresPredioAtivosPorInscricoes')
            ->once()
            ->with(['000000000123'])
            ->andReturn(['000000000123']);
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldNotReceive('buscar');

        $service = new RotaEquipeService($equipes, $cargos);

        try {
            $service->sincronizar(12, [
                ['NUM_INSCRICAO' => '000000000123', 'CARGO_ID' => 5],
            ]);
            $this->fail('A validacao deveria rejeitar supervisor de predio ativo.');
        } catch (ValidationException $e) {
            $this->assertSame(
                ['O voluntario informado esta alocado como supervisor de predio e nao pode integrar equipe de rota.'],
                $e->errors()['EQUIPE.0.NUM_INSCRICAO'] ?? []
            );
        }
    }

    public function test_sincronizar_rejeita_nova_inclusao_exclusiva_da_convocacao_efetiva_sem_flag(): void
    {
        $contexto = $this->contextoConvocacoesEfetivas(false);
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()
            ->with('000000000123', [321, 342], false, 12, [
                'incluir_convocacoes_efetivas' => false,
                'zona_numero_da_rota' => '5',
                'permitir_busca_voluntarios_outras_zonas' => false,
                'zonas_numeros_permitidas' => ['5'],
                'acesso_todas_zonas' => false,
            ])
            ->andReturnFalse();
        $equipes->shouldNotReceive('listarIntegrantesRotaPorInscricoes');
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $service = new RotaEquipeService($equipes, $this->mockCargo());

        $this->expectException(ValidationException::class);
        $service->sincronizar(12, [[
            'NUM_INSCRICAO' => '000000000123',
            'CARGO_ID' => 5,
        ]], $contexto);
    }

    public function test_sincronizar_aceita_convocacao_efetiva_no_territorio_quando_flag_esta_marcada(): void
    {
        $contexto = $this->contextoConvocacoesEfetivas(true);
        $contextoRepository = [
            'incluir_convocacoes_efetivas' => true,
            'zona_numero_da_rota' => '5',
            'permitir_busca_voluntarios_outras_zonas' => false,
            'zonas_numeros_permitidas' => ['5'],
            'acesso_todas_zonas' => false,
        ];
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()->with('000000000123', [321, 342], false, 12, $contextoRepository)->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()->with(['000000000123'], [321, 342], false, 12, $contextoRepository)->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'convocacao_eleitoral_efetiva',
                'zona_id' => null,
                'zonas_numeros_convocacao_efetiva' => ['5'],
            ]]);
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()->with(['000000000123'], 12)->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')->once();

        $service = new RotaEquipeService($equipes, $this->mockCargo());
        $service->sincronizar(12, [[
            'NUM_INSCRICAO' => '000000000123',
            'CARGO_ID' => 5,
        ]], $contexto);

        $this->assertTrue(true);
    }

    public function test_sincronizar_permite_manter_vinculo_existente_da_convocacao_sem_remarcar_flag(): void
    {
        $contexto = $this->contextoConvocacoesEfetivas(false);
        $contextoRepository = [
            'incluir_convocacoes_efetivas' => false,
            'zona_numero_da_rota' => '5',
            'permitir_busca_voluntarios_outras_zonas' => false,
            'zonas_numeros_permitidas' => ['5'],
            'acesso_todas_zonas' => false,
        ];
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()->with('000000000123', [321, 342], false, 12, $contextoRepository)->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()->with(['000000000123'], [321, 342], false, 12, $contextoRepository)->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'vinculo_rota_existente',
                'zona_id' => null,
            ]]);
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()->with(['000000000123'], 12)->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')->once();

        $service = new RotaEquipeService($equipes, $this->mockCargo());
        $service->sincronizar(12, [[
            'NUM_INSCRICAO' => '000000000123',
            'CARGO_ID' => 5,
        ]], $contexto);

        $this->assertTrue(true);
    }

    public function test_sincronizar_aceita_convocacao_efetiva_de_outra_zona_autorizada(): void
    {
        $contexto = $this->contextoConvocacoesEfetivas(true);
        $contexto['permitir_busca_voluntarios_outras_zonas'] = true;
        $contexto['zonas_numeros_permitidas'] = ['5', '7'];
        $contextoRepository = [
            'incluir_convocacoes_efetivas' => true,
            'zona_numero_da_rota' => '5',
            'permitir_busca_voluntarios_outras_zonas' => true,
            'zonas_numeros_permitidas' => ['5', '7'],
            'acesso_todas_zonas' => false,
        ];
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()->with('000000000123', [321, 342], false, 12, $contextoRepository)->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()->with(['000000000123'], [321, 342], false, 12, $contextoRepository)->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'convocacao_eleitoral_efetiva',
                'zona_id' => null,
                'zonas_numeros_convocacao_efetiva' => ['7'],
            ]]);
        $equipes->shouldReceive('listarAlocacoesRotasPorInscricoes')
            ->once()->with(['000000000123'], 12)->andReturn([]);
        $equipes->shouldReceive('sincronizarPorVinculo')->once();

        $service = new RotaEquipeService($equipes, $this->mockCargo());
        $service->sincronizar(12, [[
            'NUM_INSCRICAO' => '000000000123',
            'CARGO_ID' => 5,
        ]], $contexto);

        $this->assertTrue(true);
    }

    public function test_sincronizar_rejeita_convocacao_efetiva_de_outra_zona_fora_da_acl(): void
    {
        $contexto = $this->contextoConvocacoesEfetivas(true);
        $contexto['permitir_busca_voluntarios_outras_zonas'] = true;
        $contextoRepository = [
            'incluir_convocacoes_efetivas' => true,
            'zona_numero_da_rota' => '5',
            'permitir_busca_voluntarios_outras_zonas' => true,
            'zonas_numeros_permitidas' => ['5'],
            'acesso_todas_zonas' => false,
        ];
        $equipes = $this->mockEquipeRepository();
        $equipes->shouldReceive('integranteRotaExistePorInscricao')
            ->once()->with('000000000123', [321, 342], false, 12, $contextoRepository)->andReturnTrue();
        $equipes->shouldReceive('listarIntegrantesRotaPorInscricoes')
            ->once()->with(['000000000123'], [321, 342], false, 12, $contextoRepository)->andReturn([[
                'num_inscricao' => '000000000123',
                'fonte_elegibilidade' => 'convocacao_eleitoral_efetiva',
                'zona_id' => null,
                'zonas_numeros_convocacao_efetiva' => ['7'],
            ]]);
        $equipes->shouldNotReceive('listarAlocacoesRotasPorInscricoes');
        $equipes->shouldNotReceive('sincronizarPorVinculo');

        $service = new RotaEquipeService($equipes, $this->mockCargo());

        try {
            $service->sincronizar(12, [[
                'NUM_INSCRICAO' => '000000000123',
                'CARGO_ID' => 5,
            ]], $contexto);
            $this->fail('A validacao deveria rejeitar a nomeacao fora da ACL territorial.');
        } catch (ValidationException $e) {
            $this->assertSame(
                ['O eleitor convocado informado esta fora do escopo territorial permitido.'],
                $e->errors()['EQUIPE.0.NUM_INSCRICAO'] ?? []
            );
        }
    }

    private function contextoConvocacoesEfetivas(bool $permitir): array
    {
        return [
            'zona_id_da_rota' => 2,
            'zona_numero_da_rota' => '5',
            'permitir_busca_voluntarios_outras_zonas' => false,
            'zonas_ids_permitidas' => [2],
            'zonas_numeros_permitidas' => ['5'],
            'acesso_todas_zonas' => false,
            'aplicar_politica_voluntarios_manuais' => true,
            'incluir_voluntarios_manuais' => false,
            'permitir_busca_eleitores_convocados_qualquer_funcao' => $permitir,
        ];
    }

    private function mockCargo(): CargoEquipeRepositoryInterface
    {
        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('buscar')->once()->with(5)->andReturn((object) ['id' => 5]);

        return $cargos;
    }

    private function mockEquipeRepository(): EquipeRepositoryInterface
    {
        $repository = Mockery::mock(EquipeRepositoryInterface::class);
        $repository->shouldReceive('listarSupervisoresPredioAtivosPorInscricoes')
            ->byDefault()
            ->andReturn([]);

        return $repository;
    }
}
```
</TESTS_UNIT_ROTAEQUIPESERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaExportarPdfTest.php`
## <TESTS_UNIT_ROTAEXPORTARPDFTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaExportarPdfTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaExportarPdfTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function rota_exportar_pdf_esta_registrada(): void
public function controller_tem_metodo_exportar_pdf(): void
public function repository_tem_metodo_listar_sem_paginacao(): void
public function view_pdf_existe_e_tem_estrutura_de_campos_selecionaveis(): void
public function view_pdf_renderiza_secoes_em_linha_unica(): void
public function view_pdf_respeita_campos_selecionados(): void
public function view_pdf_exibe_local_responsavel_quando_equipe_esta_selecionada(): void
public function view_pdf_sinaliza_polo_local_votacao_fora_dos_locais_da_rota(): void
public function exportar_pdf_filtra_campos_permitidos_e_evita_consultas_nao_selecionadas(): void
public function view_index_tem_modal_de_pre_selecao_de_campos_pdf(): void
private function controller(?RotaRepository $rotas = null): RotaController
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
collect(\Illuminate\Support\Facades\Route::getRoutes()->getRoutesByName())
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaExportarPdfTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function rota_exportar_pdf_esta_registrada(): void
    {
        $this->assertTrue(
            collect(\Illuminate\Support\Facades\Route::getRoutes()->getRoutesByName())
                ->has('lda.rotas.exportar-pdf')
        );
    }

    #[Test]
    public function controller_tem_metodo_exportar_pdf(): void
    {
        $this->assertTrue(
            method_exists(\App\Http\Controllers\Lda\RotaController::class, 'exportarPdf')
        );
    }

    #[Test]
    public function repository_tem_metodo_listar_sem_paginacao(): void
    {
        $this->assertTrue(
            method_exists(\App\Repositories\Lda\RotaRepository::class, 'listarSemPaginacao')
        );
    }

    #[Test]
    public function view_pdf_existe_e_tem_estrutura_de_campos_selecionaveis(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/pdf.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Rotas', $conteudo);
        $this->assertStringContainsString('camposSelecionados', $conteudo);
        $this->assertStringContainsString('Local de Votação', $conteudo);
        $this->assertStringContainsString('polo', $conteudo);
        $this->assertStringContainsString('Polo', $conteudo);
        $this->assertStringContainsString('Seções', $conteudo);
        $this->assertStringContainsString('equipesPorRota', $conteudo);
        $this->assertStringContainsString('num_secao', $conteudo);
        $this->assertStringContainsString('qtd_aptos', $conteudo);
        $this->assertStringContainsString('apt.', $conteudo);
    }

    #[Test]
    public function view_pdf_renderiza_secoes_em_linha_unica(): void
    {
        $compiledPath = sys_get_temp_dir() . '/planeleito-view-cache';
        if (!is_dir($compiledPath)) {
            mkdir($compiledPath, 0777, true);
        }
        config(['view.compiled' => $compiledPath]);

        $html = view('lda.rotas.pdf', [
            'rotas' => collect([(object) [
                'id' => 1,
                'numero' => 12,
                'descricao' => 'Rota teste',
                'municipio' => 'Rio Branco',
                'zona' => '5',
                'total_locais' => 1,
                'total_secoes' => 2,
                'polo_label' => 'Local de Votação · Escola Exemplo',
            ]]),
            'locaisPorRota' => [
                1 => [[
                    'texto' => 'Escola Exemplo',
                    'endereco' => 'Avenida Ceará, 1234',
                    'secoes' => [
                        ['num_secao' => '005', 'qtd_aptos' => 316],
                        ['num_secao' => '008', 'qtd_aptos' => 314],
                    ],
                ]],
            ],
            'equipesPorRota' => [],
            'geradoEm' => '03/06/2026 12:00',
        ])->render();

        $this->assertStringContainsString('005 (apt. 316) · 008 (apt. 314)', $html);
        $this->assertStringContainsString('Endereço:', $html);
        $this->assertStringContainsString('Avenida Ceará, 1234', $html);
    }

    #[Test]
    public function view_pdf_respeita_campos_selecionados(): void
    {
        $compiledPath = sys_get_temp_dir() . '/planeleito-view-cache';
        if (!is_dir($compiledPath)) {
            mkdir($compiledPath, 0777, true);
        }
        config(['view.compiled' => $compiledPath]);

        $html = view('lda.rotas.pdf', [
            'rotas' => collect([(object) [
                'id' => 1,
                'numero' => 12,
                'descricao' => 'Rota teste',
                'municipio' => 'Rio Branco',
                'zona' => '5',
                'total_locais' => 1,
                'total_secoes' => 2,
                'polo_label' => 'Local de Votação · Escola Exemplo',
            ]]),
            'locaisPorRota' => [
                1 => [[
                    'texto' => 'Escola Exemplo',
                    'endereco' => 'Avenida Ceará, 1234',
                    'secoes' => [
                        ['num_secao' => '005', 'qtd_aptos' => 316],
                    ],
                ]],
            ],
            'equipesPorRota' => [
                1 => [[
                    'nom_eleitor' => 'Maria Teste',
                    'cargo_nome' => 'Técnico de UMS',
                    'telefone' => '9999-9999',
                ]],
            ],
            'camposSelecionados' => ['numero'],
            'camposPdf' => ['numero' => 'Número'],
            'geradoEm' => '03/06/2026 12:00',
        ])->render();

        $this->assertStringContainsString('Rota 12', $html);
        $this->assertStringNotContainsString('Rota teste', $html);
        $this->assertStringNotContainsString('Escola Exemplo', $html);
        $this->assertStringNotContainsString('Avenida Ceará, 1234', $html);
        $this->assertStringNotContainsString('Maria Teste', $html);
    }

    #[Test]
    public function view_pdf_exibe_local_responsavel_quando_equipe_esta_selecionada(): void
    {
        $compiledPath = sys_get_temp_dir() . '/planeleito-view-cache';
        if (!is_dir($compiledPath)) {
            mkdir($compiledPath, 0777, true);
        }
        config(['view.compiled' => $compiledPath]);

        $html = view('lda.rotas.pdf', [
            'rotas' => collect([(object) ['id' => 1]]),
            'locaisPorRota' => [],
            'equipesPorRota' => [
                1 => [[
                    'nom_eleitor' => 'Maria Teste',
                    'cargo_nome' => 'Técnico de UMS',
                    'telefone' => null,
                    'local_responsavel_texto' => '5 - Rio Branco - Escola Exemplo (Local 10)',
                ]],
            ],
            'camposSelecionados' => ['equipe'],
            'camposPdf' => ['equipe' => 'Equipe'],
            'geradoEm' => '19/07/2026 12:00',
        ])->render();

        $this->assertStringContainsString('Maria Teste', $html);
        $this->assertStringContainsString('Local responsável:', $html);
        $this->assertStringContainsString('5 - Rio Branco - Escola Exemplo (Local 10)', $html);
    }

    #[Test]
    public function view_pdf_sinaliza_polo_local_votacao_fora_dos_locais_da_rota(): void
    {
        $compiledPath = sys_get_temp_dir() . '/planeleito-view-cache';
        if (!is_dir($compiledPath)) {
            mkdir($compiledPath, 0777, true);
        }
        config(['view.compiled' => $compiledPath]);

        $html = view('lda.rotas.pdf', [
            'rotas' => collect([(object) [
                'id' => 1,
                'numero' => 12,
                'descricao' => 'Rota teste',
                'municipio' => 'Rio Branco',
                'zona' => '5',
                'polo_label' => 'Local de Votação · Escola Polo',
                'polo_local_votacao_fora_locais' => 1,
                'total_locais' => 1,
                'total_secoes' => 2,
            ]]),
            'locaisPorRota' => [],
            'equipesPorRota' => [],
            'camposSelecionados' => ['numero', 'polo'],
            'camposPdf' => ['numero' => 'Número', 'polo' => 'Polo'],
            'geradoEm' => '19/07/2026 12:00',
        ])->render();

        $this->assertStringContainsString('Polo: Local de Votação · Escola Polo', $html);
        $this->assertStringContainsString('Polo fora dos locais da rota', $html);
    }

    #[Test]
    public function exportar_pdf_filtra_campos_permitidos_e_evita_consultas_nao_selecionadas(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $rotasCollection = collect([(object) [
            'id' => 1,
            'numero' => 12,
            'descricao' => 'Rota teste',
            'municipio' => 'Rio Branco',
            'zona' => '5',
            'total_locais' => 1,
            'total_secoes' => 2,
        ]]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarSemPaginacaoNoEscopo')
            ->once()
            ->with([], [0], true)
            ->andReturn($rotasCollection);
        $rotas->shouldReceive('listarLocaisVinculadosDetalheNoEscopo')->never();
        $rotas->shouldReceive('listarEquipePorRotas')->never();

        $pdf = new RotaExportarPdfFakePdf();
        $this->app->instance('dompdf.wrapper', $pdf);

        $response = $this->controller($rotas)->exportarPdf(
            Request::create('/lda/rotas/exportar-pdf', 'GET', ['campos' => ['numero', 'indevido']])
        );

        $this->assertSame('pdf', $response->getContent());
        $this->assertSame('lda.rotas.pdf', $pdf->loadedView);
        $this->assertSame(['numero'], $pdf->loadedData['camposSelecionados']);
        $this->assertSame([], $pdf->loadedData['locaisPorRota']);
        $this->assertSame([], $pdf->loadedData['equipesPorRota']);
        $this->assertArrayHasKey('numero', $pdf->loadedData['camposPdf']);
        $this->assertSame(['a4', 'landscape'], $pdf->paper);
        $this->assertSame('rotas.pdf', $pdf->downloadName);
    }

    #[Test]
    public function view_index_tem_modal_de_pre_selecao_de_campos_pdf(): void
    {
        $compiledPath = sys_get_temp_dir() . '/planeleito-view-cache';
        if (!is_dir($compiledPath)) {
            mkdir($compiledPath, 0777, true);
        }
        config(['view.compiled' => $compiledPath]);

        $html = view('lda.rotas.index', [
            'rotas' => new LengthAwarePaginator([], 0, 10),
            'busca' => '',
            'zonaIdFiltro' => null,
            'municipioIdFiltro' => null,
            'bairroFiltro' => '',
            'equipesPorRota' => [],
            'zonas' => collect(),
            'municipios' => collect(),
            'filtrosListagem' => [],
            'camposPdf' => [
                'numero' => 'Número',
                'descricao' => 'Descrição',
                'municipio' => 'Município',
                'zona' => 'Zona',
                'total_locais' => 'Quantidade de locais',
                'total_secoes' => 'Quantidade de seções',
                'equipe' => 'Equipe',
                'locais' => 'Locais de votação',
                'secoes' => 'Seções',
                'polo' => 'Polo',
            ],
            'camposPdfPadrao' => ['numero', 'descricao', 'municipio', 'zona', 'polo', 'total_locais', 'total_secoes', 'equipe', 'locais', 'secoes'],
        ])->render();

        $this->assertStringContainsString('lda/rotas/exportar-pdf', $html);
        $this->assertStringContainsString('fa-file-pdf', $html);
        $this->assertStringContainsString('modalExportarPdfRotas', $html);
        $this->assertStringContainsString('name="campos[]"', $html);
        $this->assertStringContainsString('value="numero"', $html);
        $this->assertStringContainsString('value="equipe"', $html);
        $this->assertStringContainsString('value="locais"', $html);
        $this->assertStringContainsString('value="secoes"', $html);
        $this->assertStringContainsString('value="polo"', $html);
        $this->assertStringContainsString('pdfHiddenBusca', $html);
        $this->assertStringContainsString('pdfHiddenZonaId', $html);
        $this->assertStringContainsString('pdfHiddenMunicipioId', $html);
        $this->assertStringContainsString('pdfHiddenBairro', $html);
        $this->assertStringContainsString('pdfHiddenIntegranteNumInscricao', $html);
        $this->assertStringContainsString('pdfHiddenPolo', $html);
        $this->assertStringContainsString('pdfHiddenLocalVotacaoCodObjeto', $html);
        $this->assertStringContainsString('pdfHiddenSecao', $html);
        $this->assertStringContainsString('btnPdfRotasSelecionarTodos', $html);
        $this->assertStringContainsString('btnPdfRotasRestaurarPadrao', $html);
    }

    private function controller(?RotaRepository $rotas = null): RotaController
    {
        return new RotaController(
            $rotas ?? Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );
    }
}
class RotaExportarPdfFakePdf extends \Barryvdh\DomPDF\PDF
{
    public ?string $loadedView = null;

    /** @var array<string, mixed> */
    public array $loadedData = [];

    /** @var array<int, string> */
    public array $paper = [];

    public ?string $downloadName = null;

    public function __construct()
    {
    }

    public function loadView(string $view, array $data = [], array $mergeData = [], ?string $encoding = null): self
    {
        $this->loadedView = $view;
        $this->loadedData = $data;

        return $this;
    }

    public function setPaper($paper, string $orientation = 'portrait'): self
    {
        $this->paper = [(string) $paper, $orientation];

        return $this;
    }

    public function download(string $filename = 'document.pdf'): \Illuminate\Http\Response
    {
        $this->downloadName = $filename;

        return response('pdf');
    }
}
```
</TESTS_UNIT_ROTAEXPORTARPDFTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaFiltrosAbrangentesControllerTest.php`
## <TESTS_UNIT_ROTAFILTROSABRANGENTESCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaFiltrosAbrangentesControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaFiltrosAbrangentesControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function listagem_e_pdf_recebem_exatamente_o_mesmo_array_normalizado(): void
private function controller(RotaRepository $repository): RotaController
public function __construct()
public function loadView(string $view, array $data = [], array $mergeData = [], ?string $encoding = null): self
public function setPaper($paper, string $orientation = 'portrait'): self
public function download(string $filename = 'document.pdf'): \Illuminate\Http\Response
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Barryvdh\DomPDF\PDF;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaFiltrosAbrangentesControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function listagem_e_pdf_recebem_exatamente_o_mesmo_array_normalizado(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $entrada = [
            'busca' => ' centro ',
            'zona_id' => '2',
            'municipio_id' => '16',
            'bairro' => ' CENTRO ',
            'integrante_num_inscricao' => ' 000000000123 ',
            'polo' => 'local_votacao:LV99',
            'local_votacao_cod_objeto' => ' LV77 ',
            'secao' => '5',
            'sem_integrantes' => '1',
            'com_local_zona_rural' => '1',
            'com_local_lda' => 'true',
        ];
        $normalizados = [
            'busca' => 'centro',
            'zona_id' => 2,
            'municipio_id' => 16,
            'bairro' => 'CENTRO',
            'integrante_num_inscricao' => '000000000123',
            'polo' => 'LOCAL_VOTACAO:LV99',
            'local_votacao_cod_objeto' => 'LV77',
            'secao' => '005',
            'sem_integrantes' => 1,
            'com_local_zona_rural' => 1,
            'com_local_lda' => 1,
        ];
        $filtrosContagem = $normalizados;
        unset($filtrosContagem['sem_integrantes']);

        $paginator = new LengthAwarePaginator([], 0, 10);
        $repositoryIndex = Mockery::mock(RotaRepository::class);
        $repositoryIndex->shouldReceive('listarNoEscopo')->once()->with($normalizados, [0], true)->andReturn($paginator);
        $repositoryIndex->shouldReceive('listarEquipePorRotas')->once()->with([])->andReturn([]);
        $repositoryIndex->shouldReceive('resolverRotulosFiltrosNoEscopo')
            ->once()->with($normalizados, [0], true)->andReturn([]);
        $repositoryIndex->shouldReceive('contarSemIntegrantesNoEscopo')
            ->once()->with($filtrosContagem, [0], true)->andReturn(7);

        $dados = $this->controller($repositoryIndex)->index(Request::create('/lda/rotas', 'GET', $entrada))->getData();
        $this->assertSame($normalizados, $dados['filtrosListagem']);
        $this->assertSame(7, $dados['totalRotasSemIntegrantes']);

        $repositoryPdf = Mockery::mock(RotaRepository::class);
        $repositoryPdf->shouldReceive('listarSemPaginacaoNoEscopo')->once()->with($normalizados, [0], true)->andReturn(collect());
        $repositoryPdf->shouldReceive('listarEquipePorRotas')->never();

        $pdf = new RotaFiltrosAbrangentesFakePdf();
        $this->app->instance('dompdf.wrapper', $pdf);
        $this->controller($repositoryPdf)->exportarPdf(Request::create('/lda/rotas/exportar-pdf', 'GET', $entrada + [
            'campos' => ['numero'],
        ]));

        $this->assertSame('lda.rotas.pdf', $pdf->loadedView);
    }

    private function controller(RotaRepository $repository): RotaController
    {
        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldReceive('listar')->zeroOrMoreTimes()->andReturn(collect());
        $municipios = Mockery::mock(MunicipioRepository::class);
        $municipios->shouldReceive('listarComZona')->zeroOrMoreTimes()->andReturn(collect());

        return new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonas,
            $municipios,
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );
    }
}

class RotaFiltrosAbrangentesFakePdf extends PDF
{
    public ?string $loadedView = null;

    public function __construct()
    {
    }

    public function loadView(string $view, array $data = [], array $mergeData = [], ?string $encoding = null): self
    {
        $this->loadedView = $view;

        return $this;
    }

    public function setPaper($paper, string $orientation = 'portrait'): self
    {
        return $this;
    }

    public function download(string $filename = 'document.pdf'): \Illuminate\Http\Response
    {
        return response('pdf');
    }
}
```
</TESTS_UNIT_ROTAFILTROSABRANGENTESCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaFiltrosAbrangentesEndpointsTest.php`
## <TESTS_UNIT_ROTAFILTROSABRANGENTESENDPOINTSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaFiltrosAbrangentesEndpointsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaFiltrosAbrangentesEndpointsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function contexto_de_integrante_retorna_apenas_opcoes_usadas_em_rotas_visiveis(): void
public function contextos_de_local_e_polo_mantem_o_json_select2_existente(): void
public function contexto_vazio_repassa_acl_restritiva_sem_ampliar_escopo(): void
private function controller(RotaRepository $repository): RotaController
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Illuminate\Http\Request;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaFiltrosAbrangentesEndpointsTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function contexto_de_integrante_retorna_apenas_opcoes_usadas_em_rotas_visiveis(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('buscarIntegrantesFiltroNoEscopo')
            ->once()->with('FUL', 44, 16, [0], true)
            ->andReturn([(object) ['id' => '000000000123', 'texto' => 'Fulano (Título 000000000123)']]);

        $response = $this->controller($repository)->buscarConvocados(Request::create('/lda/rotas/convocados', 'GET', [
            'contexto' => 'filtro_listagem_integrante',
            'q' => 'ful',
            'zona_id' => '44',
            'municipio_id' => '16',
        ]));

        $this->assertSame([
            ['id' => '000000000123', 'text' => 'Fulano (Título 000000000123)'],
        ], $response->getData(true));
    }

    #[Test]
    public function contextos_de_local_e_polo_mantem_o_json_select2_existente(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('buscarLocaisFiltroNoEscopo')
            ->once()->with('escola', 44, 16, [0], true)
            ->andReturn([(object) ['id' => 'LV77', 'texto' => 'Zona 1 - Escola 77']]);
        $repository->shouldReceive('buscarPolosFiltroNoEscopo')
            ->once()->with('posto', 44, 16, [0], true)
            ->andReturn([(object) ['id' => 'LOCAL_TRANSMISSAO:8', 'texto' => 'Local de Transmissão · Posto 8']]);

        $controller = $this->controller($repository);
        $local = $controller->buscarLocais(Request::create('/lda/rotas/locais', 'GET', [
            'contexto' => 'filtro_listagem_local',
            'q' => 'escola',
            'zona_id' => '44',
            'municipio_id' => '16',
        ]));
        $polo = $controller->buscarLocais(Request::create('/lda/rotas/locais', 'GET', [
            'contexto' => 'filtro_listagem_polo',
            'q' => 'posto',
            'zona_id' => '44',
            'municipio_id' => '16',
        ]));

        $this->assertSame([['id' => 'LV77', 'text' => 'Zona 1 - Escola 77']], $local->getData(true));
        $this->assertSame([[
            'id' => 'LOCAL_TRANSMISSAO:8',
            'text' => 'Local de Transmissão · Posto 8',
        ]], $polo->getData(true));
    }

    #[Test]
    public function contexto_vazio_repassa_acl_restritiva_sem_ampliar_escopo(): void
    {
        session(['cod_zonas_permitidas' => [], 'acesso_todas_zonas' => false]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('buscarLocaisFiltroNoEscopo')
            ->once()->with('', null, null, [], false)->andReturn([]);

        $response = $this->controller($repository)->buscarLocais(Request::create('/lda/rotas/locais', 'GET', [
            'contexto' => 'filtro_listagem_local',
        ]));

        $this->assertSame([], $response->getData(true));
    }

    private function controller(RotaRepository $repository): RotaController
    {
        return new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );
    }
}
```
</TESTS_UNIT_ROTAFILTROSABRANGENTESENDPOINTSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaIndexControllerEquipeTest.php`
## <TESTS_UNIT_ROTAINDEXCONTROLLEREQUIPETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaIndexControllerEquipeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaIndexControllerEquipeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function index_filtra_zonas_e_municipios_da_view_por_numero_da_zona_da_sessao(): void
public function index_passa_equipes_por_rota_para_a_view(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaIndexControllerEquipeTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }


    #[Test]
    public function index_filtra_zonas_e_municipios_da_view_por_numero_da_zona_da_sessao(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $paginatorFake = new LengthAwarePaginator([], 0, 10, 1, ['path' => '/lda/rotas']);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('listarNoEscopo')
            ->once()
            ->with([], [1], false)
            ->andReturn($paginatorFake);
        $rotaRepository->shouldReceive('listarEquipePorRotas')
            ->once()
            ->with([])
            ->andReturn([]);
        $rotaRepository->shouldReceive('contarSemIntegrantesNoEscopo')
            ->once()
            ->with([], [1], false)
            ->andReturn(0);

        $zonas = collect([
            (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
            (object) ['id' => 82, 'num_zona' => 9, 'descricao' => 'Nona zona'],
        ]);
        $municipios = collect([
            (object) ['id' => 16, 'zona_id' => 44, 'num_zona' => 1, 'localidade' => 'RIO BRANCO', 'cod_objeto_localidade' => '100'],
            (object) ['id' => 99, 'zona_id' => 82, 'num_zona' => 9, 'localidade' => 'CRUZEIRO DO SUL', 'cod_objeto_localidade' => '200'],
        ]);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('listar')->once()->andReturn($zonas);
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn($zonas);

        $municipioRepository = Mockery::mock(MunicipioRepository::class);
        $municipioRepository->shouldReceive('listarComZona')->once()->andReturn($municipios);

        $controller = new RotaController(
            $rotaRepository,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            $municipioRepository,
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->index(Request::create('/lda/rotas', 'GET'));
        $dados = $response->getData();

        $this->assertCount(1, $dados['zonas']);
        $this->assertSame(44, $dados['zonas']->first()->id);
        $this->assertCount(1, $dados['municipios']);
        $this->assertSame(16, $dados['municipios']->first()->id);
    }
    #[Test]
    public function index_passa_equipes_por_rota_para_a_view(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $rotaFake = (object) [
            'id' => 1,
            'numero' => 101,
            'descricao' => 'Rota Teste',
            'municipio' => 'Rio Branco',
            'zona' => '1',
            'total_locais' => 3,
            'total_secoes' => 10,
            'dt_criacao' => '01/01/2026 08:00',
        ];

        $paginatorFake = new LengthAwarePaginator(
            [$rotaFake], 1, 10, 1, ['path' => '/lda/rotas']
        );

        $equipesFake = [
            1 => [
                ['nom_eleitor' => 'JOÃO SILVA', 'cargo_nome' => 'Motorista'],
                ['nom_eleitor' => 'MARIA SOUZA', 'cargo_nome' => 'Escrutinadora'],
            ],
        ];

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('listarNoEscopo')
            ->once()
            ->with([], [1], false)
            ->andReturn($paginatorFake);
        $rotaRepository->shouldReceive('listarEquipePorRotas')
            ->once()
            ->with([1])
            ->andReturn($equipesFake);
        $rotaRepository->shouldReceive('contarSemIntegrantesNoEscopo')
            ->once()
            ->with([], [1], false)
            ->andReturn(0);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('listar')->once()->andReturn(collect());
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn(collect());

        $municipioRepository = Mockery::mock(MunicipioRepository::class);
        $municipioRepository->shouldReceive('listarComZona')->once()->andReturn(collect());

        $controller = new RotaController(
            $rotaRepository,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            $municipioRepository,
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $request = Request::create('/lda/rotas', 'GET');
        $response = $controller->index($request);

        $dados = $response->getData();
        $this->assertArrayHasKey('equipesPorRota', $dados);
        $this->assertSame($equipesFake, $dados['equipesPorRota']);
    }
}
```
</TESTS_UNIT_ROTAINDEXCONTROLLEREQUIPETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaListagemEstadoEdicaoTest.php`
## <TESTS_UNIT_ROTALISTAGEMESTADOEDICAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaListagemEstadoEdicaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaListagemEstadoEdicaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function index_expoe_estado_da_listagem_para_a_view(): void
public function form_normaliza_e_expoe_estado_da_listagem_descartando_desconhecidos(): void
public function update_redireciona_para_listagem_filtrada_e_paginada(): void
public function blade_index_transporta_estado_no_link_editar(): void
public function blade_form_transporta_estado_no_voltar_e_na_acao(): void
private function controller(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Http\Requests\Lda\RotaRequest;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use App\Services\Lda\RotaTransmissaoService;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaListagemEstadoEdicaoTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function index_expoe_estado_da_listagem_para_a_view(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $paginator = new LengthAwarePaginator([], 0, 10, 2, ['path' => '/lda/rotas']);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarNoEscopo')->once()->andReturn($paginator);
        $rotas->shouldReceive('listarEquipePorRotas')->once()->andReturn([]);
        $rotas->shouldReceive('contarSemIntegrantesNoEscopo')->once()->andReturn(4);

        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldReceive('listar')->once()->andReturn(collect());
        $municipios = Mockery::mock(MunicipioRepository::class);
        $municipios->shouldReceive('listarComZona')->once()->andReturn(collect());

        $controller = $this->controller($rotas, $zonas, $municipios);

        $request = Request::create('/lda/rotas', 'GET', [
            'busca' => 'centro',
            'zona_id' => '2',
            'municipio_id' => '16',
            'bairro' => 'CENTRO',
            'integrante_num_inscricao' => '000000000123',
            'polo' => 'LOCAL_VOTACAO:LV99',
            'local_votacao_cod_objeto' => 'LV77',
            'secao' => '5',
            'sem_integrantes' => '1',
            'com_local_zona_rural' => '1',
            'com_local_lda' => 'true',
            'page' => '3',
            'desconhecido' => 'x',
        ]);

        $rotas->shouldReceive('resolverRotulosFiltrosNoEscopo')->once()->andReturn([]);

        $dados = $controller->index($request)->getData();

        $this->assertSame([
            'busca' => 'centro',
            'zona_id' => 2,
            'municipio_id' => 16,
            'bairro' => 'CENTRO',
            'integrante_num_inscricao' => '000000000123',
            'polo' => 'LOCAL_VOTACAO:LV99',
            'local_votacao_cod_objeto' => 'LV77',
            'secao' => '005',
            'sem_integrantes' => 1,
            'com_local_zona_rural' => 1,
            'com_local_lda' => 1,
            'page' => 3,
        ], $dados['filtrosListagem']);
    }

    #[Test]
    public function form_normaliza_e_expoe_estado_da_listagem_descartando_desconhecidos(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(9, [0], true)->andReturn((object) [
            'id' => 9, 'numero' => 1, 'descricao' => 'R', 'zona_id' => 2, 'municipio_id' => 16,
        ]);
        $rotas->shouldReceive('listarLocaisVinculadosNoEscopo')->once()->andReturn([]);
        $rotas->shouldReceive('listarLocaisTransmissaoPoloNoEscopo')->once()->with([0], true)->andReturn([]);

        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldReceive('listar')->once()->andReturn(collect());
        $municipios = Mockery::mock(MunicipioRepository::class);
        $municipios->shouldReceive('listarComZona')->once()->andReturn(collect());
        $cargos = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $cargos->shouldReceive('listarAtivos')->once()->andReturn([]);
        $equipes = Mockery::mock(EquipeRepositoryInterface::class);
        $equipes->shouldReceive('listarPorRota')->once()->with(9)->andReturn([]);

        $controller = $this->controller($rotas, $zonas, $municipios, $cargos, $equipes);

        $request = Request::create('/lda/rotas/form/9', 'GET', [
            'busca' => 'centro',
            'zona_id' => '2',
            'municipio_id' => '16.5',
            'bairro' => '',
            'integrante_num_inscricao' => '000000000123',
            'polo' => 'LOCAL_TRANSMISSAO:8',
            'local_votacao_cod_objeto' => 'LV77',
            'secao' => '12',
            'sem_integrantes' => '1',
            'com_local_zona_rural' => '1',
            'com_local_lda' => 'true',
            'page' => '3.5',
            'desconhecido' => 'x',
        ]);

        $dados = $controller->form($request, 9)->getData();

        $this->assertSame([
            'busca' => 'centro',
            'zona_id' => 2,
            'integrante_num_inscricao' => '000000000123',
            'polo' => 'LOCAL_TRANSMISSAO:8',
            'local_votacao_cod_objeto' => 'LV77',
            'secao' => '012',
            'sem_integrantes' => 1,
            'com_local_zona_rural' => 1,
            'com_local_lda' => 1,
        ], $dados['filtrosListagem']);
    }

    #[Test]
    public function update_redireciona_para_listagem_filtrada_e_paginada(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 101,
            'DESCRICAO' => 'Rota teste',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => 'LV10',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([]);
        $request->shouldReceive('query')->with('busca', '')->andReturn('centro');
        $request->shouldReceive('query')->with('bairro', '')->andReturn('');
        $request->shouldReceive('query')->with('zona_id')->andReturn('2');
        $request->shouldReceive('query')->with('municipio_id')->andReturn(null);
        $request->shouldReceive('query')->with('integrante_num_inscricao', '')->andReturn('000000000123');
        $request->shouldReceive('query')->with('polo')->andReturn('LOCAL_VOTACAO:LV99');
        $request->shouldReceive('query')->with('local_votacao_cod_objeto', '')->andReturn('LV77');
        $request->shouldReceive('query')->with('secao')->andReturn('5');
        $request->shouldReceive('query')->with('sem_integrantes')->andReturn('1');
        $request->shouldReceive('query')->with('com_local_zona_rural')->andReturn('1');
        $request->shouldReceive('query')->with('com_local_lda')->andReturn('true');
        $request->shouldReceive('query')->with('page')->andReturn('3');

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(77, [0], true)->andReturn((object) ['id' => 77]);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldReceive('atualizar')->once()->with(77, Mockery::on(fn (array $dados): bool => $dados['polo_tipo'] === 'LOCAL_VOTACAO' && $dados['polo_local_votacao_cod_objeto'] === 'LV10'));
        $rotas->shouldReceive('sincronizarLocais')->once()->with(77, ['LV10']);

        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')->once()->with(77, [], [
            'codigos_locais_da_rota' => ['LV10'],
            'zona_id_da_rota' => 2,
            'permitir_busca_voluntarios_outras_zonas' => false,
            'permitir_busca_eleitores_convocados_qualquer_funcao' => false,
            'zonas_ids_permitidas' => [],
            'zona_numero_da_rota' => null,
            'zonas_numeros_permitidas' => [],
            'acesso_todas_zonas' => true,
            'aplicar_politica_voluntarios_manuais' => true,
            'incluir_voluntarios_manuais' => false,
        ]);

        $controller = $this->controller($rotas, service: $service);

        $response = $controller->update($request, 77);

        $this->assertSame(
            route('lda.rotas.index', [
                'busca' => 'centro',
                'zona_id' => 2,
                'integrante_num_inscricao' => '000000000123',
                'polo' => 'LOCAL_VOTACAO:LV99',
                'local_votacao_cod_objeto' => 'LV77',
                'secao' => '005',
                'sem_integrantes' => 1,
                'com_local_zona_rural' => 1,
                'com_local_lda' => 1,
                'page' => 3,
            ]),
            $response->getTargetUrl()
        );
    }

    #[Test]
    public function blade_index_transporta_estado_no_link_editar(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertStringContainsString(
            "route('lda.rotas.form', ['id' => \$rota->id] + \$filtrosListagem)",
            $conteudo,
            'O link Editar deve transportar o estado da listagem.'
        );
    }

    #[Test]
    public function blade_form_transporta_estado_no_voltar_e_na_acao(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/form.blade.php'));

        $this->assertStringContainsString(
            "route('lda.rotas.index', \$filtrosListagem)",
            $conteudo,
            'O botao Voltar deve manter filtros e pagina.'
        );
        $this->assertStringContainsString(
            "route('lda.rotas.update', ['id' => \$rota->id] + \$filtrosListagem)",
            $conteudo,
            'A acao do formulario deve reenviar o estado da listagem no PUT.'
        );
    }

    private function controller(
        ?RotaRepository $rotas = null,
        ?ZonaRepository $zonas = null,
        ?MunicipioRepository $municipios = null,
        ?CargoEquipeRepositoryInterface $cargos = null,
        ?EquipeRepositoryInterface $equipes = null,
        ?RotaEquipeService $service = null,
    ): RotaController {
        return new RotaController(
            $rotas ?? Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            $zonas ?? Mockery::mock(ZonaRepository::class),
            $municipios ?? Mockery::mock(MunicipioRepository::class),
            $cargos ?? Mockery::mock(CargoEquipeRepositoryInterface::class),
            $equipes ?? Mockery::mock(EquipeRepositoryInterface::class),
            $service ?? Mockery::mock(RotaEquipeService::class),
            Mockery::mock(RotaTransmissaoService::class)->shouldIgnoreMissing(),
        );
    }
}
```
</TESTS_UNIT_ROTALISTAGEMESTADOEDICAOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaPoloControllerTest.php`
## <TESTS_UNIT_ROTAPOLOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaPoloControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaPoloControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function store_persiste_polo_local_de_votacao_vinculado_a_rota(): void
public function store_bloqueia_polo_local_de_votacao_que_nao_esta_na_rota(): void
public function store_aceita_polo_local_de_votacao_fora_dos_locais_quando_checkbox_autoriza(): void
public function store_bloqueia_polo_local_de_votacao_fora_do_territorio_mesmo_com_checkbox(): void
public function store_persiste_polo_local_de_transmissao_no_mesmo_territorio(): void
public function update_preserva_polo_local_de_votacao_fora_dos_locais_quando_checkbox_autoriza(): void
public function store_bloqueia_polo_local_de_transmissao_fora_do_territorio(): void
private function controller(?RotaRepository $rotas = null, ?RotaEquipeService $service = null): RotaController
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\RotaController;
use App\Http\Requests\Lda\RotaRequest;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\RotaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use App\Services\Lda\RotaEquipeService;
use App\Services\Lda\RotaTransmissaoService;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class RotaPoloControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function store_persiste_polo_local_de_votacao_vinculado_a_rota(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 101,
            'DESCRICAO' => 'Rota teste',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => 'LV10',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10', 'LV20']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10', 'LV20'], 2, [0], true)->andReturn(['LV10', 'LV20']);
        $rotas->shouldReceive('criar')->once()->with([
            'numero' => 101,
            'descricao' => 'Rota teste',
            'zona_id' => 2,
            'municipio_id' => 16,
            'polo_tipo' => 'LOCAL_VOTACAO',
            'polo_local_votacao_cod_objeto' => 'LV10',
            'polo_local_transmissao_id' => null,
        ])->andReturn(77);
        $rotas->shouldReceive('sincronizarLocais')->once()->with(77, ['LV10', 'LV20']);

        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')
            ->once()
            ->with(77, [], [
                'codigos_locais_da_rota' => ['LV10', 'LV20'],
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'permitir_busca_eleitores_convocados_qualquer_funcao' => false,
                'zonas_ids_permitidas' => [],
                'zona_numero_da_rota' => null,
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
                'aplicar_politica_voluntarios_manuais' => true,
                'incluir_voluntarios_manuais' => false,
            ]);

        $response = $this->controller($rotas, service: $service)->store($request);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }

    #[Test]
    public function store_bloqueia_polo_local_de_votacao_que_nao_esta_na_rota(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 101,
            'DESCRICAO' => 'Rota teste',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => 'FORA',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);
        $request->shouldNotReceive('input')->with('EQUIPE', []);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldNotReceive('criar');

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('O polo Local de Votação deve estar entre os locais vinculados da rota.');

        $this->controller($rotas)->store($request);
    }

    #[Test]
    public function store_aceita_polo_local_de_votacao_fora_dos_locais_quando_checkbox_autoriza(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 103,
            'DESCRICAO' => 'Rota com polo compartilhado',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => 'LV99',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
            'PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS' => '1',
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV99'], 2, [0], true)->andReturn(['LV99']);
        $rotas->shouldReceive('criar')->once()->with(Mockery::on(fn (array $dados): bool => $dados['polo_tipo'] === 'LOCAL_VOTACAO'
            && $dados['polo_local_votacao_cod_objeto'] === 'LV99'
            && !array_key_exists('PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS', $dados)))->andReturn(79);
        $rotas->shouldReceive('sincronizarLocais')->once()->with(79, ['LV10']);

        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')
            ->once()
            ->with(79, [], [
                'codigos_locais_da_rota' => ['LV10'],
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'permitir_busca_eleitores_convocados_qualquer_funcao' => false,
                'zonas_ids_permitidas' => [],
                'zona_numero_da_rota' => null,
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
                'aplicar_politica_voluntarios_manuais' => true,
                'incluir_voluntarios_manuais' => false,
            ]);

        $response = $this->controller($rotas, service: $service)->store($request);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }

    #[Test]
    public function store_bloqueia_polo_local_de_votacao_fora_do_territorio_mesmo_com_checkbox(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 103,
            'DESCRICAO' => 'Rota com polo invalido',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => 'LV99',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
            'PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS' => '1',
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV99'], 2, [0], true)->andReturn([]);
        $rotas->shouldNotReceive('criar');

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('O polo Local de Votação deve pertencer ao mesmo território da rota e ao seu escopo.');

        $this->controller($rotas)->store($request);
    }

    #[Test]
    public function store_persiste_polo_local_de_transmissao_no_mesmo_territorio(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 102,
            'DESCRICAO' => 'Rota LT',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_TRANSMISSAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => null,
            'POLO_LOCAL_TRANSMISSAO_ID' => 55,
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([]);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldReceive('localTransmissaoElegivelParaPoloNoEscopo')->once()->with(55, 2, [0], true)->andReturn(true);
        $rotas->shouldReceive('criar')->once()->with(Mockery::on(fn (array $dados): bool => $dados['polo_tipo'] === 'LOCAL_TRANSMISSAO' && $dados['polo_local_transmissao_id'] === 55))->andReturn(78);
        $rotas->shouldReceive('sincronizarLocais')->once()->with(78, ['LV10']);

        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')
            ->once()
            ->with(78, [], [
                'codigos_locais_da_rota' => ['LV10'],
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'permitir_busca_eleitores_convocados_qualquer_funcao' => false,
                'zonas_ids_permitidas' => [],
                'zona_numero_da_rota' => null,
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
                'aplicar_politica_voluntarios_manuais' => true,
                'incluir_voluntarios_manuais' => false,
            ]);

        $response = $this->controller($rotas, service: $service)->store($request);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }

    #[Test]
    public function update_preserva_polo_local_de_votacao_fora_dos_locais_quando_checkbox_autoriza(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 104,
            'DESCRICAO' => 'Rota editada',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_VOTACAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => 'LV99',
            'POLO_LOCAL_TRANSMISSAO_ID' => null,
            'PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS' => '1',
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);
        $request->shouldReceive('input')->once()->with('EQUIPE', [])->andReturn([]);
        $request->shouldReceive('query')->andReturn(null);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('buscarNoEscopo')->once()->with(80, [0], true)->andReturn((object) ['id' => 80]);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV99'], 2, [0], true)->andReturn(['LV99']);
        $rotas->shouldReceive('atualizar')->once()->with(80, Mockery::on(fn (array $dados): bool => $dados['polo_tipo'] === 'LOCAL_VOTACAO'
            && $dados['polo_local_votacao_cod_objeto'] === 'LV99'
            && !array_key_exists('PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS', $dados)));
        $rotas->shouldReceive('sincronizarLocais')->once()->with(80, ['LV10']);

        $service = Mockery::mock(RotaEquipeService::class);
        $service->shouldReceive('sincronizar')
            ->once()
            ->with(80, [], [
                'codigos_locais_da_rota' => ['LV10'],
                'zona_id_da_rota' => 2,
                'permitir_busca_voluntarios_outras_zonas' => false,
                'permitir_busca_eleitores_convocados_qualquer_funcao' => false,
                'zonas_ids_permitidas' => [],
                'zona_numero_da_rota' => null,
                'zonas_numeros_permitidas' => [],
                'acesso_todas_zonas' => true,
                'aplicar_politica_voluntarios_manuais' => true,
                'incluir_voluntarios_manuais' => false,
            ]);

        $response = $this->controller($rotas, service: $service)->update($request, 80);

        $this->assertSame(route('lda.rotas.index'), $response->getTargetUrl());
    }

    #[Test]
    public function store_bloqueia_polo_local_de_transmissao_fora_do_territorio(): void
    {
        session(['cod_zonas_permitidas' => [0], 'acesso_todas_zonas' => true]);

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 102,
            'DESCRICAO' => 'Rota LT',
            'ZONA_ID' => 2,
            'MUNICIPIO_ID' => 16,
            'POLO_TIPO' => 'LOCAL_TRANSMISSAO',
            'POLO_LOCAL_VOTACAO_COD_OBJETO' => null,
            'POLO_LOCAL_TRANSMISSAO_ID' => 55,
        ]);
        $request->shouldReceive('input')->once()->with('LOCAIS', [])->andReturn(['LV10']);

        $rotas = Mockery::mock(RotaRepository::class);
        $rotas->shouldReceive('listarCodigosLocaisValidosNoEscopo')->once()->with(['LV10'], 2, [0], true)->andReturn(['LV10']);
        $rotas->shouldReceive('localTransmissaoElegivelParaPoloNoEscopo')->once()->with(55, 2, [0], true)->andReturn(false);
        $rotas->shouldNotReceive('criar');

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('O polo Local de Transmissão deve pertencer ao mesmo território da rota e ao seu escopo.');

        $this->controller($rotas)->store($request);
    }

    private function controller(?RotaRepository $rotas = null, ?RotaEquipeService $service = null): RotaController
    {
        return new RotaController(
            $rotas ?? Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            $service ?? Mockery::mock(RotaEquipeService::class),
            Mockery::mock(RotaTransmissaoService::class)->shouldIgnoreMissing(),
        );
    }
}
```
</TESTS_UNIT_ROTAPOLOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaPoloMigrationTest.php`
## <TESTS_UNIT_ROTAPOLOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaPoloMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaPoloMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_polo_operacional_na_tabela_rota(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaPoloMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_polo_operacional_na_tabela_rota(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_07_13_120000_add_polo_to_rota_table.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('POLO_TIPO VARCHAR2(30 CHAR)', $conteudo);
        $this->assertStringContainsString('POLO_LOCAL_VOTACAO_COD_OBJETO VARCHAR2(18 CHAR)', $conteudo);
        $this->assertStringContainsString('POLO_LOCAL_TRANSMISSAO_ID NUMBER(19)', $conteudo);
        $this->assertStringContainsString("POLO_TIPO IS NULL OR POLO_TIPO IN ('LOCAL_VOTACAO', 'LOCAL_TRANSMISSAO')", $conteudo);
        $this->assertStringContainsString('CONSTRAINT fk_rota_polo_lt', $conteudo);
        $this->assertStringContainsString('FOREIGN KEY (POLO_LOCAL_TRANSMISSAO_ID) REFERENCES LOCAL_TRANSMISSAO(ID)', $conteudo);
    }
}
```
</TESTS_UNIT_ROTAPOLOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaRepositoryFiltrosTest.php`
## <TESTS_UNIT_ROTAREPOSITORYFILTROSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaRepositoryFiltrosTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaRepositoryFiltrosTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar_aceita_array_unico_de_filtros(): void
public function listar_aceita_array_de_filtros_vazio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\RotaRepository;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaRepositoryFiltrosTest extends TestCase
{
    #[Test]
    public function listar_aceita_array_unico_de_filtros(): void
    {
        $reflection = new \ReflectionMethod(RotaRepository::class, 'listar');
        $params = $reflection->getParameters();

        $this->assertSame('filtros', $params[0]->getName());
        $this->assertSame('array', (string) $params[0]->getType());
    }

    #[Test]
    public function listar_aceita_array_de_filtros_vazio(): void
    {
        $reflection = new \ReflectionMethod(RotaRepository::class, 'listar');
        $filtros = $reflection->getParameters()[0];

        $this->assertTrue($filtros->isOptional());
        $this->assertSame([], $filtros->getDefaultValue());
    }
}
```
</TESTS_UNIT_ROTAREPOSITORYFILTROSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaRepositoryListarEquipeTest.php`
## <TESTS_UNIT_ROTAREPOSITORYLISTAREQUIPETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaRepositoryListarEquipeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaRepositoryListarEquipeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function listar_equipe_por_rotas_retorna_array_vazio_quando_sem_ids(): void
public function listar_equipe_por_rotas_existe_e_retorna_array(): void
public function listar_equipe_por_rotas_resolve_nome_de_colaborador_interno_deferido_das_acoes_321_e_342(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\RotaRepository;
use App\Repositories\ColaboradoresEleitorais\Queries\EleitorConvocadoEfetivoEquipeQuery;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaRepositoryListarEquipeTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function listar_equipe_por_rotas_retorna_array_vazio_quando_sem_ids(): void
    {
        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $resultado = $repository->listarEquipePorRotas([]);

        $this->assertSame([], $resultado);
    }

    #[Test]
    public function listar_equipe_por_rotas_existe_e_retorna_array(): void
    {
        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));

        // Verifica apenas que o método existe e aceita array de inteiros
        $this->assertTrue(method_exists($repository, 'listarEquipePorRotas'));

        // Caso trivial sem banco: lista vazia de IDs retorna array vazio
        $resultado = $repository->listarEquipePorRotas([]);
        $this->assertIsArray($resultado);
        $this->assertEmpty($resultado);
    }

    #[Test]
    public function listar_equipe_por_rotas_resolve_nome_de_colaborador_interno_deferido_das_acoes_321_e_342(): void
    {
        EleitorConvocadoEfetivoEquipeQuery::sqlIdentidades();
        DB::shouldReceive('select')
            ->once()
            ->with(
                Mockery::on(static function (string $sql): bool {
                    return str_contains($sql, 'CE_CANDIDATURA_COLABORADOR ci')
                        && str_contains($sql, 'cad_convocacao_mesario_tse')
                        && str_contains($sql, 'planeleito.vw_servidor vs')
                        && str_contains($sql, 'LOWER(TRIM(vs.E_MAIL)) = LOWER(TRIM(ci.EMAIL_USUARIO))')
                        && str_contains($sql, 'ci.PROCESSO_ELEITORAL_ID IN (?,?)')
                        && str_contains($sql, 'convocacao_efetiva.nom_eleitor')
                        && str_contains($sql, 'convocacao_efetiva.telefone')
                        && str_contains($sql, 'e.cod_objeto_local_responsavel')
                        && str_contains($sql, 'LEFT JOIN planeleito.vw_locais_votacao_efetivos lv_responsavel')
                        && str_contains($sql, 'AS local_responsavel_texto')
                        && str_contains($sql, 'e.rota_id IN (?,?)');
                }),
                [321, 342, 110, 111]
            )
            ->andReturn([(object) [
                'rota_id' => 110,
                'num_inscricao' => '002832012410',
                'cargo_nome' => 'Gerente de UMS',
                'nom_eleitor' => 'Aieza dos Santos Bandeira',
                'telefone' => null,
                'cod_objeto_local_responsavel' => 'LOCAL-10',
                'local_responsavel_texto' => '5 - Rio Branco - Escola Exemplo (Local 10)',
            ]]);

        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $resultado = $repository->listarEquipePorRotas([110, 111]);

        $this->assertSame('Aieza dos Santos Bandeira', $resultado[110][0]['nom_eleitor']);
        $this->assertSame('Gerente de UMS', $resultado[110][0]['cargo_nome']);
        $this->assertSame('LOCAL-10', $resultado[110][0]['cod_objeto_local_responsavel']);
        $this->assertSame('5 - Rio Branco - Escola Exemplo (Local 10)', $resultado[110][0]['local_responsavel_texto']);
    }
}
```
</TESTS_UNIT_ROTAREPOSITORYLISTAREQUIPETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaRequestLocalResponsavelTest.php`
## <TESTS_UNIT_ROTAREQUESTLOCALRESPONSAVELTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaRequestLocalResponsavelTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaRequestLocalResponsavelTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function request_aceita_local_responsavel_opcional_com_codigo_de_ate_18_caracteres(): void
public function request_aceita_checkbox_de_polo_local_votacao_fora_dos_locais_sem_persistencia(): void
public function request_valida_autorizacao_transitoria_de_convocados_em_qualquer_funcao_como_booleano(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Lda\RotaRequest;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaRequestLocalResponsavelTest extends TestCase
{
    #[Test]
    public function request_aceita_local_responsavel_opcional_com_codigo_de_ate_18_caracteres(): void
    {
        $regras = (new RotaRequest)->rules();

        $this->assertArrayHasKey('EQUIPE.*.COD_OBJETO_LOCAL_RESPONSAVEL', $regras);
        $this->assertSame(
            ['nullable', 'string', 'max:18'],
            $regras['EQUIPE.*.COD_OBJETO_LOCAL_RESPONSAVEL']
        );
    }

    #[Test]
    public function request_aceita_checkbox_de_polo_local_votacao_fora_dos_locais_sem_persistencia(): void
    {
        $regras = (new RotaRequest)->rules();

        $this->assertArrayHasKey('PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS', $regras);
        $this->assertSame(
            ['nullable', 'boolean'],
            $regras['PERMITIR_POLO_LOCAL_VOTACAO_FORA_LOCAIS']
        );
    }

    #[Test]
    public function request_valida_autorizacao_transitoria_de_convocados_em_qualquer_funcao_como_booleano(): void
    {
        $regras = (new RotaRequest)->rules();

        $this->assertArrayHasKey('PERMITIR_BUSCA_ELEITORES_CONVOCADOS_QUALQUER_FUNCAO', $regras);
        $this->assertSame(
            ['nullable', 'boolean'],
            $regras['PERMITIR_BUSCA_ELEITORES_CONVOCADOS_QUALQUER_FUNCAO']
        );
    }
}
```
</TESTS_UNIT_ROTAREQUESTLOCALRESPONSAVELTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaTransmissaoMigrationsTest.php`
## <TESTS_UNIT_ROTATRANSMISSAOMIGRATIONSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaTransmissaoMigrationsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaTransmissaoMigrationsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringContainsString("DB::table('ROTA_TRANSMISSAO_VINCULO')->count()", $conteudo);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_impede_o_mesmo_local_em_duas_rotas_sem_corrigir_dados_silenciosamente(): void
public function migration_cria_rastreio_do_polo_com_ordem_anterior_e_rollback_protegido(): void
private function migration(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaTransmissaoMigrationsTest extends TestCase
{
    #[Test]
    public function migration_impede_o_mesmo_local_em_duas_rotas_sem_corrigir_dados_silenciosamente(): void
    {
        $conteudo = $this->migration('2026_08_26_130000_enforce_rota_local_single_route.php');

        $this->assertStringContainsString('GROUP BY COD_OBJETO_LOCAL', $conteudo);
        $this->assertStringContainsString('HAVING COUNT(DISTINCT ROTA_ID) > 1', $conteudo);
        $this->assertStringContainsString('UK_ROTA_LOCAL_LOCAL', $conteudo);
        $this->assertStringContainsString('UNIQUE (COD_OBJETO_LOCAL)', $conteudo);
        $this->assertStringNotContainsString('DELETE FROM ROTA_LOCAL', strtoupper($conteudo));
    }

    #[Test]
    public function migration_cria_rastreio_do_polo_com_ordem_anterior_e_rollback_protegido(): void
    {
        $conteudo = $this->migration('2026_08_26_131000_create_rota_transmissao_vinculo_table.php');

        foreach ([
            'CREATE TABLE ROTA_TRANSMISSAO_VINCULO',
            'ROTA_ID',
            'COD_OBJETO_LOCAL',
            'LOCAL_TRANSMISSAO_ID',
            'ORDEM_ANTERIOR NUMBER(3)',
            'UK_RTV_ROTA_LOCAL',
            'FK_RTV_ROTA_LOCAL',
            'FK_RTV_LT',
        ] as $trecho) {
            $this->assertStringContainsString($trecho, $conteudo);
        }

        $this->assertStringContainsString("DB::table('ROTA_TRANSMISSAO_VINCULO')->count()", $conteudo);
        $this->assertStringContainsString('rollback', strtolower($conteudo));
    }

    private function migration(string $arquivo): string
    {
        $conteudo = file_get_contents(database_path('migrations/' . $arquivo));
        $this->assertIsString($conteudo);

        return $conteudo;
    }
}
```
</TESTS_UNIT_ROTATRANSMISSAOMIGRATIONSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaTransmissaoServiceTest.php`
## <TESTS_UNIT_ROTATRANSMISSAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaTransmissaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaTransmissaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function aplica_proprio_primeiro_polo_distinto_segundo_e_rastreia_ordem_anterior(): void
public function remove_efeito_restaurando_ordem_manual_ou_excluindo_inclusao_da_rota(): void
public function crud_permanece_compativel_enquanto_a_migration_de_rastreio_esta_pendente(): void
public function reconciliacao_dml_recusa_execucao_sem_a_migration_de_rastreio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Repositories\Lda\RotaTransmissaoRepository;
use App\Services\Lda\RotaTransmissaoService;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use DomainException;
use Tests\TestCase;

class RotaTransmissaoServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        DB::shouldReceive('transaction')
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function aplica_proprio_primeiro_polo_distinto_segundo_e_rastreia_ordem_anterior(): void
    {
        $rotas = Mockery::mock(RotaTransmissaoRepository::class);
        $locais = Mockery::mock(LocalTransmissaoRepository::class);
        $rotas->shouldReceive('estruturaDisponivel')->once()->andReturnTrue();

        $rotas->shouldReceive('buscarContexto')->once()->with(12)->andReturn((object) [
            'rota_id' => 12,
            'numero' => 124,
            'descricao' => 'Rota 124',
            'local_transmissao_polo_id' => 30,
        ]);
        $rotas->shouldReceive('listarMembros')->once()->with(12)->andReturn(collect([
            (object) ['cod_objeto_local' => 'LV-1', 'local_transmissao_proprio_id' => 20],
            (object) ['cod_objeto_local' => 'LV-2', 'local_transmissao_proprio_id' => 30],
            (object) ['cod_objeto_local' => 'LV-3', 'local_transmissao_proprio_id' => null],
        ]));
        $rotas->shouldReceive('possuiVinculo')->times(2)->andReturnFalse();

        $locais->shouldReceive('buscarOrdemPreferencia')->once()->with(30, 'LV-1')->andReturn(3);
        $locais->shouldReceive('definirLocalTransmissaoComoPrimeiraPreferencia')->once()->with(20, 'LV-1');
        $locais->shouldReceive('definirOrdemPreferencia')->once()->with(30, 'LV-1', 2);
        $rotas->shouldReceive('registrarVinculo')->once()->with([
            'rota_id' => 12,
            'cod_objeto_local' => 'LV-1',
            'local_transmissao_id' => 30,
            'ordem_anterior' => 3,
        ]);

        $locais->shouldReceive('definirLocalTransmissaoComoPrimeiraPreferencia')->once()->with(30, 'LV-2');

        $locais->shouldReceive('buscarOrdemPreferencia')->once()->with(30, 'LV-3')->andReturn(null);
        $locais->shouldReceive('definirOrdemPreferencia')->once()->with(30, 'LV-3', 1);
        $rotas->shouldReceive('registrarVinculo')->once()->with([
            'rota_id' => 12,
            'cod_objeto_local' => 'LV-3',
            'local_transmissao_id' => 30,
            'ordem_anterior' => null,
        ]);

        $resultado = (new RotaTransmissaoService($rotas, $locais))->aplicarEfeitosDaRota(12);

        $this->assertSame([
            'membros_processados' => 3,
            'vinculos_aplicados' => 2,
            'proprios_iguais_ao_polo' => 1,
        ], $resultado);
    }

    #[Test]
    public function remove_efeito_restaurando_ordem_manual_ou_excluindo_inclusao_da_rota(): void
    {
        $rotas = Mockery::mock(RotaTransmissaoRepository::class);
        $locais = Mockery::mock(LocalTransmissaoRepository::class);
        $rotas->shouldReceive('estruturaDisponivel')->once()->andReturnTrue();
        $rotas->shouldReceive('listarVinculos')->once()->with(12)->andReturn(collect([
            (object) [
                'id' => 1,
                'cod_objeto_local' => 'LV-1',
                'local_transmissao_id' => 30,
                'ordem_anterior' => 3,
            ],
            (object) [
                'id' => 2,
                'cod_objeto_local' => 'LV-3',
                'local_transmissao_id' => 30,
                'ordem_anterior' => null,
            ],
        ]));

        $locais->shouldReceive('definirOrdemPreferencia')->once()->with(30, 'LV-1', 3);
        $locais->shouldReceive('removerPreferenciaPropria')->once()->with(30, 'LV-3');
        $rotas->shouldReceive('removerVinculo')->once()->with(1);
        $rotas->shouldReceive('removerVinculo')->once()->with(2);

        $this->assertSame(
            2,
            (new RotaTransmissaoService($rotas, $locais))->removerEfeitosDaRota(12)
        );
    }

    #[Test]
    public function crud_permanece_compativel_enquanto_a_migration_de_rastreio_esta_pendente(): void
    {
        $rotas = Mockery::mock(RotaTransmissaoRepository::class);
        $locais = Mockery::mock(LocalTransmissaoRepository::class);
        $rotas->shouldReceive('estruturaDisponivel')->twice()->andReturnFalse();
        $rotas->shouldNotReceive('buscarContexto');
        $rotas->shouldNotReceive('listarVinculos');

        $service = new RotaTransmissaoService($rotas, $locais);

        $this->assertSame([
            'membros_processados' => 0,
            'vinculos_aplicados' => 0,
            'proprios_iguais_ao_polo' => 0,
        ], $service->aplicarEfeitosDaRota(12));
        $this->assertSame(0, $service->removerEfeitosDaRota(12));
    }

    #[Test]
    public function reconciliacao_dml_recusa_execucao_sem_a_migration_de_rastreio(): void
    {
        $rotas = Mockery::mock(RotaTransmissaoRepository::class);
        $locais = Mockery::mock(LocalTransmissaoRepository::class);
        $rotas->shouldReceive('estruturaDisponivel')->once()->andReturnFalse();

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('migration');

        (new RotaTransmissaoService($rotas, $locais))->reconciliarRotas();
    }
}
```
</TESTS_UNIT_ROTATRANSMISSAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaZonaMunicipioMigrationTest.php`
## <TESTS_UNIT_ROTAZONAMUNICIPIOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaZonaMunicipioMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaZonaMunicipioMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_zona_e_municipio_na_tabela_rota(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaZonaMunicipioMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_zona_e_municipio_na_tabela_rota(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_04_13_010000_add_zona_e_municipio_to_rota_table.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ALTER TABLE ROTA ADD (', $conteudo);
        $this->assertStringContainsString('ZONA_ID NUMBER(19)', $conteudo);
        $this->assertStringContainsString('MUNICIPIO_ID NUMBER(19)', $conteudo);
        $this->assertStringContainsString('CONSTRAINT fk_rota_zona', $conteudo);
        $this->assertStringContainsString('FOREIGN KEY (ZONA_ID) REFERENCES ZONA(ID)', $conteudo);
        $this->assertStringContainsString('CONSTRAINT fk_rota_municipio', $conteudo);
        $this->assertStringContainsString('FOREIGN KEY (MUNICIPIO_ID) REFERENCES MUNICIPIO(ID)', $conteudo);
    }
}
```
</TESTS_UNIT_ROTAZONAMUNICIPIOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotasIndexFiltrosUiTest.php`
## <TESTS_UNIT_ROTASINDEXFILTROSUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotasIndexFiltrosUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotasIndexFiltrosUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function view_tem_select_de_zona(): void
public function view_tem_select_de_municipio_cascadeado_por_zona(): void
public function view_tem_select_de_bairro_com_ajax(): void
public function view_tem_sete_filtros_avancados_e_abre_secao_quando_algum_esta_ativo(): void
public function select2_avancados_usam_contextos_especificos_e_limpeza_territorial(): void
public function filtros_avancados_usam_tema_disponivel_e_dimensoes_dos_controles_bootstrap(): void
public function acoes_dos_filtros_formam_grupo_compacto_e_responsivo(): void
public function modal_pdf_replica_os_sete_filtros_avancados(): void
public function view_renderizada_abre_filtros_avancados_e_preserva_rotulos_selecionados(): void
public function view_tem_botao_olhinho_com_lazy_load_por_linha(): void
public function view_tem_js_de_lazy_load_para_locais(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotasIndexFiltrosUiTest extends TestCase
{
    private string $conteudo;

    protected function setUp(): void
    {
        parent::setUp();
        $this->conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));
    }

    #[Test]
    public function view_tem_select_de_zona(): void
    {
        $this->assertStringContainsString('filtroRotaZona', $this->conteudo);
        $this->assertStringContainsString('name="zona_id"', $this->conteudo);
        $this->assertStringContainsString('$zonas', $this->conteudo);
    }

    #[Test]
    public function view_tem_select_de_municipio_cascadeado_por_zona(): void
    {
        $this->assertStringContainsString('filtroRotaMunicipio', $this->conteudo);
        $this->assertStringContainsString('name="municipio_id"', $this->conteudo);
        $this->assertStringContainsString('$municipios', $this->conteudo);
    }

    #[Test]
    public function view_tem_select_de_bairro_com_ajax(): void
    {
        $this->assertStringContainsString('filtroRotaBairro', $this->conteudo);
        $this->assertStringContainsString('name="bairro"', $this->conteudo);
        $this->assertStringContainsString('lda.locais-votacao.bairros', $this->conteudo);
    }

    #[Test]
    public function view_tem_sete_filtros_avancados_e_abre_secao_quando_algum_esta_ativo(): void
    {
        $this->assertStringContainsString('id="filtrosAvancadosRotas"', $this->conteudo);
        $this->assertStringContainsString('Filtros avançados', $this->conteudo);
        $this->assertStringContainsString('name="integrante_num_inscricao"', $this->conteudo);
        $this->assertStringContainsString('name="polo"', $this->conteudo);
        $this->assertStringContainsString('name="local_votacao_cod_objeto"', $this->conteudo);
        $this->assertStringContainsString('name="secao"', $this->conteudo);
        $this->assertStringContainsString('name="sem_integrantes"', $this->conteudo);
        $this->assertStringContainsString('name="com_local_zona_rural"', $this->conteudo);
        $this->assertStringContainsString('name="com_local_lda"', $this->conteudo);
        $this->assertStringContainsString('$totalRotasSemIntegrantes', $this->conteudo);
        $this->assertStringContainsString('$filtrosAvancadosAtivos', $this->conteudo);
        $this->assertStringContainsString("'show'", $this->conteudo);
    }

    #[Test]
    public function select2_avancados_usam_contextos_especificos_e_limpeza_territorial(): void
    {
        $this->assertStringContainsString("urlConvocados, 'filtro_listagem_integrante'", $this->conteudo);
        $this->assertStringContainsString("urlLocais, 'filtro_listagem_polo'", $this->conteudo);
        $this->assertStringContainsString("urlLocais, 'filtro_listagem_local'", $this->conteudo);
        $this->assertStringContainsString('limparFiltrosTerritoriais', $this->conteudo);
        $this->assertStringContainsString("select2('data')", $this->conteudo);
    }

    #[Test]
    public function filtros_avancados_usam_tema_disponivel_e_dimensoes_dos_controles_bootstrap(): void
    {
        $this->assertStringNotContainsString("theme: 'bootstrap-5'", $this->conteudo);
        $this->assertStringContainsString('filtros-rotas-avancados', $this->conteudo);
        $this->assertStringContainsString('.filtros-rotas-avancados .select2-container', $this->conteudo);
        $this->assertStringContainsString('.select2-selection--single', $this->conteudo);
        $this->assertStringContainsString('min-height: 38px', $this->conteudo);
        $this->assertStringContainsString('text-overflow: ellipsis', $this->conteudo);
    }

    #[Test]
    public function acoes_dos_filtros_formam_grupo_compacto_e_responsivo(): void
    {
        $this->assertStringContainsString('id="filtrosRotasAcoes"', $this->conteudo);
        $this->assertStringContainsString('d-grid d-sm-flex', $this->conteudo);
        $this->assertStringNotContainsString('btn btn-primary w-100', $this->conteudo);
        $this->assertStringNotContainsString('btn btn-outline-secondary w-100', $this->conteudo);
    }

    #[Test]
    public function modal_pdf_replica_os_sete_filtros_avancados(): void
    {
        $this->assertStringContainsString('pdfHiddenIntegranteNumInscricao', $this->conteudo);
        $this->assertStringContainsString('pdfHiddenPolo', $this->conteudo);
        $this->assertStringContainsString('pdfHiddenLocalVotacaoCodObjeto', $this->conteudo);
        $this->assertStringContainsString('pdfHiddenSecao', $this->conteudo);
        $this->assertStringContainsString('pdfHiddenSemIntegrantes', $this->conteudo);
        $this->assertStringContainsString('pdfHiddenComLocalZonaRural', $this->conteudo);
        $this->assertStringContainsString('pdfHiddenComLocalLda', $this->conteudo);
    }

    #[Test]
    public function view_renderizada_abre_filtros_avancados_e_preserva_rotulos_selecionados(): void
    {
        $html = view('lda.rotas.index', [
            'rotas' => new \Illuminate\Pagination\LengthAwarePaginator([], 0, 10),
            'busca' => '',
            'zonaIdFiltro' => 44,
            'municipioIdFiltro' => 16,
            'bairroFiltro' => '',
            'integranteFiltro' => '000000000123',
            'poloFiltro' => 'LOCAL_VOTACAO:LV99',
            'localVotacaoFiltro' => 'LV77',
            'secaoFiltro' => '005',
            'semIntegrantesFiltro' => true,
            'comLocalZonaRuralFiltro' => true,
            'comLocalLdaFiltro' => true,
            'totalRotasSemIntegrantes' => 7,
            'rotulosFiltrosSelecionados' => [
                'integrante_num_inscricao' => ['id' => '000000000123', 'text' => 'Fulano (Título 000000000123)'],
                'polo' => ['id' => 'LOCAL_VOTACAO:LV99', 'text' => 'Local de Votação · Escola Polo'],
                'local_votacao_cod_objeto' => ['id' => 'LV77', 'text' => 'Zona 1 - Escola 77'],
            ],
            'equipesPorRota' => [],
            'zonas' => collect(),
            'municipios' => collect(),
            'filtrosListagem' => [],
        ])->render();

        $this->assertMatchesRegularExpression('/class="[^"]*\bcollapse\b[^"]*\bshow\b[^"]*"\s+id="filtrosAvancadosRotas"/', $html);
        $this->assertStringContainsString('Fulano (Título 000000000123)', $html);
        $this->assertStringContainsString('Local de Votação · Escola Polo', $html);
        $this->assertStringContainsString('Zona 1 - Escola 77', $html);
        $this->assertStringContainsString('value="005"', $html);
        $this->assertMatchesRegularExpression('/name="sem_integrantes"[^>]*checked/', $html);
        $this->assertMatchesRegularExpression('/name="com_local_zona_rural"[^>]*checked/', $html);
        $this->assertMatchesRegularExpression('/name="com_local_lda"[^>]*checked/', $html);
        $this->assertStringContainsString('>7</span>', $html);
    }

    #[Test]
    public function view_tem_botao_olhinho_com_lazy_load_por_linha(): void
    {
        $this->assertStringContainsString('data-locais-collapse', $this->conteudo);
        $this->assertStringContainsString('data-locais-url', $this->conteudo);
        $this->assertStringContainsString('lda.rotas.locais-vinculados', $this->conteudo);
        $this->assertStringContainsString('data-loaded="false"', $this->conteudo);
        $this->assertStringContainsString('fa-eye', $this->conteudo);
    }

    #[Test]
    public function view_tem_js_de_lazy_load_para_locais(): void
    {
        $this->assertStringContainsString('data-locais-collapse', $this->conteudo);
        $this->assertStringContainsString('show.bs.collapse', $this->conteudo);
        $this->assertStringContainsString('data-locais-url', $this->conteudo);
        $this->assertStringContainsString("payload.html", $this->conteudo);
    }
}
```
</TESTS_UNIT_ROTASINDEXFILTROSUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotasIndexResponsividadeTest.php`
## <TESTS_UNIT_ROTASINDEXRESPONSIVIDADETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotasIndexResponsividadeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotasIndexResponsividadeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function layout_usa_grid_responsivo_dentro_de_cada_linha(): void
public function numero_e_descricao_estao_no_mesmo_bloco_de_cabecalho(): void
public function stats_municipio_zona_locais_secoes_estao_agrupados(): void
public function layout_nao_usa_br_para_separar_campos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotasIndexResponsividadeTest extends TestCase
{
    private string $conteudo;

    protected function setUp(): void
    {
        parent::setUp();
        $this->conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));
    }

    #[Test]
    public function layout_usa_grid_responsivo_dentro_de_cada_linha(): void
    {
        $this->assertStringContainsString('col-md-', $this->conteudo);
    }

    #[Test]
    public function numero_e_descricao_estao_no_mesmo_bloco_de_cabecalho(): void
    {
        $this->assertMatchesRegularExpression(
            '/\$rota->numero.{0,200}\$rota->descricao/s',
            $this->conteudo,
            'Número e descrição devem aparecer juntos no cabeçalho da linha.'
        );
    }

    #[Test]
    public function stats_municipio_zona_locais_secoes_estao_agrupados(): void
    {
        $this->assertStringContainsString('$rota->municipio', $this->conteudo);
        $this->assertStringContainsString('$rota->zona', $this->conteudo);
        $this->assertStringContainsString('$rota->total_locais', $this->conteudo);
        $this->assertStringContainsString('$rota->total_secoes', $this->conteudo);
    }

    #[Test]
    public function layout_nao_usa_br_para_separar_campos(): void
    {
        $this->assertStringNotContainsString(
            '<br>',
            $this->conteudo,
            'Campos não devem ser separados com <br> — usar grid Bootstrap.'
        );
    }
}
```
</TESTS_UNIT_ROTASINDEXRESPONSIVIDADETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotasIndexSemDataCriacaoTest.php`
## <TESTS_UNIT_ROTASINDEXSEMDATACRIACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotasIndexSemDataCriacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotasIndexSemDataCriacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_rotas_nao_exibe_data_de_criacao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotasIndexSemDataCriacaoTest extends TestCase
{
    #[Test]
    public function tela_de_rotas_nao_exibe_data_de_criacao(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertStringNotContainsString(
            '$rota->dt_criacao',
            $conteudo,
            'A data de criação não deve ser exibida na listagem de rotas.'
        );
    }
}
```
</TESTS_UNIT_ROTASINDEXSEMDATACRIACAOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotasIndexUiTest.php`
## <TESTS_UNIT_ROTASINDEXUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotasIndexUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotasIndexUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_rotas_usa_tabela_simples_no_padrao_de_planejamento(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotasIndexUiTest extends TestCase
{
    #[Test]
    public function tela_de_rotas_usa_tabela_simples_no_padrao_de_planejamento(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<th>Rota</th>', $conteudo);
        $this->assertStringContainsString('<th>Ações</th>', $conteudo);
        $this->assertStringContainsString('$rota->numero', $conteudo);
        $this->assertStringContainsString('$rota->descricao', $conteudo);
        $this->assertStringContainsString('$rota->municipio', $conteudo);
        $this->assertStringContainsString('$rota->zona', $conteudo);
        $this->assertStringContainsString('$rota->total_locais', $conteudo);
        $this->assertStringContainsString('$rota->total_secoes', $conteudo);
        $this->assertStringContainsString('$rota->polo_label', $conteudo);
        $this->assertStringContainsString('$rota->polo_local_votacao_fora_locais', $conteudo);
        $this->assertStringContainsString('Polo fora dos locais da rota', $conteudo);
        $this->assertStringContainsString('Base operacional', $conteudo);
        $this->assertStringContainsString('col-md-', $conteudo);
        $this->assertStringNotContainsString('<br>', $conteudo);
        $this->assertStringContainsString("title=\"Editar rota\"", $conteudo);
        $this->assertStringContainsString("title=\"Excluir rota\"", $conteudo);
        $this->assertStringContainsString("{{ \$rotas->links('pagination::bootstrap-5') }}", $conteudo);
    }
}
```
</TESTS_UNIT_ROTASINDEXUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotasMapaLegendaTest.php`
## <TESTS_UNIT_ROTASMAPALEGENDATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotasMapaLegendaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotasMapaLegendaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_do_mapa_de_rotas_usa_legenda_estatica_sem_painel_de_lista(): void
public function css_do_mapa_de_rotas_define_estilos_da_legenda_compacta(): void
public function js_do_mapa_de_rotas_nao_depende_de_painel_lateral_para_funcionar(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotasMapaLegendaTest extends TestCase
{
    #[Test]
    public function view_do_mapa_de_rotas_usa_legenda_estatica_sem_painel_de_lista(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/mapa.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="rotaMapaLegendaToggle"', $conteudo);
        $this->assertStringContainsString('id="rotaMapaLegendaConteudo"', $conteudo);
        $this->assertStringContainsString('rota-mapa-legenda', $conteudo);
        $this->assertStringContainsString('Problemas', $conteudo);
        $this->assertStringContainsString('Conectado', $conteudo);
        $this->assertStringContainsString('Não conectado', $conteudo);
        $this->assertStringContainsString('fa-triangle-exclamation', $conteudo);
        $this->assertStringContainsString('fa-wifi', $conteudo);
        $this->assertStringContainsString('fa-circle-xmark', $conteudo);
        $this->assertStringNotContainsString('id="rotaMapaPainel"', $conteudo);
        $this->assertStringNotContainsString('id="rotaMapaLista"', $conteudo);
        $this->assertStringNotContainsString('id="rotaMapaPainelToggle"', $conteudo);
        $this->assertStringNotContainsString('id="rotaMapaStatus"', $conteudo);
    }

    #[Test]
    public function css_do_mapa_de_rotas_define_estilos_da_legenda_compacta(): void
    {
        $conteudo = file_get_contents(public_path('css/lda-mapa.css'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('.rota-mapa-legenda {', $conteudo);
        $this->assertStringContainsString('.rota-mapa-legenda.is-collapsed .rota-mapa-legenda-conteudo {', $conteudo);
        $this->assertStringContainsString('.rota-mapa-legenda-item {', $conteudo);
        $this->assertStringContainsString('.rota-mapa-legenda-icone--problema', $conteudo);
        $this->assertStringContainsString('.rota-mapa-legenda-icone--conectado', $conteudo);
        $this->assertStringContainsString('.rota-mapa-legenda-icone--nao-conectado', $conteudo);
        $this->assertStringContainsString('top: 7.2rem;', $conteudo);
        $this->assertStringContainsString('left: 0.75rem;', $conteudo);
    }

    #[Test]
    public function js_do_mapa_de_rotas_nao_depende_de_painel_lateral_para_funcionar(): void
    {
        $conteudo = file_get_contents(public_path('js/rotas-mapa.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("document.getElementById('rotaMapaLegendaToggle')", $conteudo);
        $this->assertStringContainsString("document.getElementById('rotaMapaLegenda')", $conteudo);
        $this->assertStringContainsString("legendaElement.classList.toggle('is-collapsed')", $conteudo);
        $this->assertStringNotContainsString("document.getElementById('rotaMapaLista')", $conteudo);
        $this->assertStringNotContainsString("document.getElementById('rotaMapaPainel')", $conteudo);
        $this->assertStringNotContainsString("document.getElementById('rotaMapaPainelToggle')", $conteudo);
        $this->assertStringNotContainsString("document.getElementById('rotaMapaPainelFechar')", $conteudo);
        $this->assertStringNotContainsString('limparLista(', $conteudo);
    }
}
```
</TESTS_UNIT_ROTASMAPALEGENDATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TransmissaoPreferenciaCanonicaServiceTest.php`
## <TESTS_UNIT_TRANSMISSAOPREFERENCIACANONICASERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TransmissaoPreferenciaCanonicaServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TransmissaoPreferenciaCanonicaServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function lista_lda_convertido_uma_vez_com_marcadores_de_transmissao_e_lda(): void
public function normaliza_payload_lda_convertido_antes_de_persistir(): void
public function repository_resolve_mapeamento_somente_no_catalogo_lt_efetivo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\Lda\TransmissaoPreferenciaService;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class TransmissaoPreferenciaCanonicaServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function lista_lda_convertido_uma_vez_com_marcadores_de_transmissao_e_lda(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('listarTransmissoesPreferenciais')
            ->once()
            ->with('LV-BOACU')
            ->andReturn(new Collection([(object) [
                'chave' => 'lt:9',
                'tipo' => 'LOCAL_TRANSMISSAO',
                'nome' => 'POSTO DE SAUDE (ALDEIA BOACU)',
                'municipio' => 'MANOEL URBANO',
                'ordem_preferencia' => 1,
                'fixa' => 1,
                'origem_lda' => 1,
            ]]));

        $resultado = (new TransmissaoPreferenciaService($repository))->listar('LV-BOACU');

        $this->assertCount(1, $resultado);
        $this->assertSame('lt:9', $resultado[0]['id']);
        $this->assertSame(['Transmissão', 'LDA'], $resultado[0]['marcadores']);
    }

    #[Test]
    public function normaliza_payload_lda_convertido_antes_de_persistir(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('normalizarChavesTransmissao')
            ->once()
            ->with(['lda:22', 'lt:9', 'lda:94'])
            ->andReturn(['lt:9', 'lda:94']);
        $repository->shouldReceive('sincronizarTransmissoesPreferenciais')
            ->once()
            ->with('LV-1', ['lt:9', 'lda:94']);

        (new TransmissaoPreferenciaService($repository))->sincronizar(
            'LV-1',
            ['lda:22', 'lt:9', 'lda:94']
        );

        $this->addToAssertionCount(1);
    }

    #[Test]
    public function repository_resolve_mapeamento_somente_no_catalogo_lt_efetivo(): void
    {
        $query = Mockery::mock();
        $query->shouldReceive('join')->once()->with(
            'planeleito.vw_locais_transmissao_efetivos as lt',
            'lt.cod_objeto_local_votacao',
            '=',
            'l.cod_objeto_local_votacao'
        )->andReturnSelf();
        $query->shouldReceive('whereIn')->once()->with('l.id', [22, 94])->andReturnSelf();
        $query->shouldReceive('select')->once()->with(
            'l.id as lda_id',
            'lt.id as local_transmissao_id'
        )->andReturnSelf();
        $query->shouldReceive('get')->once()->andReturn(collect([
            (object) ['lda_id' => 22, 'local_transmissao_id' => 9],
        ]));
        DB::shouldReceive('table')->once()->with('lda as l')->andReturn($query);

        $repository = new LocalVotacaoRepository(
            app(\App\Services\Auditoria\AuditLogService::class)
        );

        $this->assertSame(
            ['lt:9', 'lda:94'],
            $repository->normalizarChavesTransmissao(['lda:22', 'lt:9', 'lda:94'])
        );
    }
}
```
</TESTS_UNIT_TRANSMISSAOPREFERENCIACANONICASERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaLdaCommandTest.php`
## <TESTS_UNIT_URNACONTINGENCIALDACOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaLdaCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaLdaCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function comando_executa_dry_run_por_padrao_sem_persistir(): void
public function comando_rejeita_contexto_nao_informado(): void
public function comando_persiste_somente_com_execute_explicito(): void
private function itemPlano(string $acao): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Lda\UrnaContingenciaLdaMunicipioService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class UrnaContingenciaLdaCommandTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function comando_executa_dry_run_por_padrao_sem_persistir(): void
    {
        $service = Mockery::mock(UrnaContingenciaLdaMunicipioService::class);
        $service->shouldReceive('planejar')
            ->once()
            ->with(1, 10)
            ->andReturn([$this->itemPlano('INSERIR')]);
        $service->shouldNotReceive('aplicar');
        $this->app->instance(UrnaContingenciaLdaMunicipioService::class, $service);

        $this->artisan('lda:atribuir-urnas-contingencia', [
            '--macroprojeto-id' => '1',
            '--municipio-id' => '10',
        ])
            ->expectsOutput('Dry-run concluido. 1 LDA(s) avaliado(s); 2 urna(s) calculada(s).')
            ->expectsOutput('Nenhum DML executado. Reexecute com --execute somente apos autorizacao explicita.')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_rejeita_contexto_nao_informado(): void
    {
        $service = Mockery::mock(UrnaContingenciaLdaMunicipioService::class);
        $service->shouldNotReceive('planejar');
        $service->shouldNotReceive('aplicar');
        $this->app->instance(UrnaContingenciaLdaMunicipioService::class, $service);

        $this->artisan('lda:atribuir-urnas-contingencia')
            ->expectsOutput('Informe --macroprojeto-id e --municipio-id como inteiros positivos.')
            ->assertExitCode(2);
    }

    #[Test]
    public function comando_persiste_somente_com_execute_explicito(): void
    {
        $service = Mockery::mock(UrnaContingenciaLdaMunicipioService::class);
        $service->shouldReceive('planejar')
            ->once()
            ->with(1, 10)
            ->andReturn([$this->itemPlano('ATUALIZAR')]);
        $service->shouldReceive('aplicar')
            ->once()
            ->with(1, 10)
            ->andReturn([
                'alterados' => 1,
                'inseridos' => 0,
                'atualizados' => 1,
                'ignorados' => 0,
            ]);
        $this->app->instance(UrnaContingenciaLdaMunicipioService::class, $service);

        $this->artisan('lda:atribuir-urnas-contingencia', [
            '--macroprojeto-id' => '1',
            '--municipio-id' => '10',
            '--execute' => true,
        ])
            ->expectsOutput('Aplicacao concluida. 1 registro(s) alterado(s): 0 inserido(s) e 1 atualizado(s).')
            ->assertExitCode(0);
    }

    /** @return array<string, mixed> */
    private function itemPlano(string $acao): array
    {
        return [
            'lda_id' => 43,
            'local' => 'ESCOLA ALFREDO SALES',
            'cod_objeto_local' => 'LOCAL-1',
            'secoes_fisicas' => 2,
            'quantidade_atual' => null,
            'quantidade_calculada' => 2,
            'acao' => $acao,
        ];
    }
}
```
</TESTS_UNIT_URNACONTINGENCIALDACOMMANDTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaLdaMunicipioServiceTest.php`
## <TESTS_UNIT_URNACONTINGENCIALDAMUNICIPIOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaLdaMunicipioServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaLdaMunicipioServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function planeja_quantidade_por_secao_fisica_com_reserva_minima_de_duas(): void
public function aplicar_persiste_somente_itens_elegiveis_e_divergentes(): void
private function lda(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\RecursoLogisticoLocalRepository;
use App\Services\Lda\UrnaContingenciaLdaMunicipioService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class UrnaContingenciaLdaMunicipioServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function planeja_quantidade_por_secao_fisica_com_reserva_minima_de_duas(): void
    {
        $repository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $repository->shouldReceive('listarLdasParaAtribuicaoUrnas')
            ->once()
            ->with(1, 10)
            ->andReturn([
                $this->lda('SEM SECOES', 'LOCAL-0', 0, null),
                $this->lda('UMA SECAO', 'LOCAL-1', 1, null),
                $this->lda('DUAS SECOES', 'LOCAL-2', 2, 2),
                $this->lda('TRES SECOES', 'LOCAL-3', 3, 1),
            ]);

        $service = new UrnaContingenciaLdaMunicipioService($repository);
        $plano = $service->planejar(1, 10);

        $this->assertSame('SEM_SECOES', $plano[0]['acao']);
        $this->assertNull($plano[0]['quantidade_calculada']);
        $this->assertSame('INSERIR', $plano[1]['acao']);
        $this->assertSame(2, $plano[1]['quantidade_calculada']);
        $this->assertSame('INALTERADO', $plano[2]['acao']);
        $this->assertSame(2, $plano[2]['quantidade_calculada']);
        $this->assertSame('ATUALIZAR', $plano[3]['acao']);
        $this->assertSame(3, $plano[3]['quantidade_calculada']);
    }

    #[Test]
    public function aplicar_persiste_somente_itens_elegiveis_e_divergentes(): void
    {
        $repository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $repository->shouldReceive('listarLdasParaAtribuicaoUrnas')
            ->once()
            ->with(1, 10)
            ->andReturn([
                $this->lda('SEM SECOES', 'LOCAL-0', 0, null),
                $this->lda('JA CORRETO', 'LOCAL-1', 1, 2),
                $this->lda('NOVO', 'LOCAL-2', 2, null),
                $this->lda('DIVERGENTE', 'LOCAL-3', 3, 1),
            ]);
        $repository->shouldReceive('sincronizarUrnasContingencia')
            ->once()
            ->with('LOCAL-2', 1, 2)
            ->andReturn('INSERIDO');
        $repository->shouldReceive('sincronizarUrnasContingencia')
            ->once()
            ->with('LOCAL-3', 1, 3)
            ->andReturn('ATUALIZADO');

        $service = new UrnaContingenciaLdaMunicipioService($repository);
        $resultado = $service->aplicar(1, 10);

        $this->assertSame(2, $resultado['alterados']);
        $this->assertSame(1, $resultado['inseridos']);
        $this->assertSame(1, $resultado['atualizados']);
        $this->assertSame(2, $resultado['ignorados']);
    }

    /** @return array<string, mixed> */
    private function lda(
        string $local,
        string $codigo,
        int $secoesFisicas,
        ?int $quantidadeAtual
    ): array {
        return [
            'lda_id' => 1,
            'local' => $local,
            'cod_objeto_local' => $codigo,
            'secoes_fisicas' => $secoesFisicas,
            'quantidade_atual' => $quantidadeAtual,
        ];
    }
}
```
</TESTS_UNIT_URNACONTINGENCIALDAMUNICIPIOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoDashboardRepositoryTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAODASHBOARDREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoDashboardRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoDashboardRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('planeleito.vw_locais_votacao_efetivos')->insert([
DB::table('MUNICIPIO')->insert([
DB::table('lda_vistoria_transmissao')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_resume_somente_macroprojeto_e_zonas_autorizadas_sem_truncar_grupos(): void
public function test_aplica_zona_e_municipio_sobre_o_escopo_autorizado(): void
private function vistoria(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\VistoriaTransmissaoRepository;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class VistoriaTransmissaoDashboardRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        DB::statement("ATTACH DATABASE ':memory:' AS planeleito");
        DB::statement(<<<'SQL'
CREATE TABLE planeleito.vw_locais_votacao_efetivos (
    cod_objeto VARCHAR(18) PRIMARY KEY,
    nom_local VARCHAR(200)
)
SQL);
        DB::statement(<<<'SQL'
CREATE TABLE MUNICIPIO (
    cod_objeto_localidade VARCHAR(18),
    localidade VARCHAR(200)
)
SQL);
        DB::statement(<<<'SQL'
CREATE TABLE lda_vistoria_transmissao (
    id INTEGER PRIMARY KEY,
    macroprojeto_id INTEGER NOT NULL,
    local_votacao_cod VARCHAR(18),
    zona_num INTEGER,
    municipio_cod VARCHAR(18),
    situacao_geral VARCHAR(30),
    tem_sala_transmissao VARCHAR(3),
    qualidade_energia VARCHAR(20),
    tem_internet VARCHAR(3),
    conectou_vpn VARCHAR(3),
    internet_movel_contingencia VARCHAR(3)
)
SQL);

        DB::table('planeleito.vw_locais_votacao_efetivos')->insert([
            ['cod_objeto' => 'L1', 'nom_local' => 'Escola Um'],
            ['cod_objeto' => 'L2', 'nom_local' => 'Escola Dois'],
            ['cod_objeto' => 'L3', 'nom_local' => 'Escola Três'],
        ]);
        DB::table('MUNICIPIO')->insert([
            ['cod_objeto_localidade' => 'M1', 'localidade' => 'RIO BRANCO'],
            ['cod_objeto_localidade' => 'M2', 'localidade' => 'CRUZEIRO DO SUL'],
            ['cod_objeto_localidade' => 'M3', 'localidade' => 'SENA MADUREIRA'],
        ]);
        DB::table('lda_vistoria_transmissao')->insert([
            $this->vistoria(1, 44, 'L1', 3, 'M1', 'APTO', 'SIM', 'OTIMA', 'SIM', 'SIM', 'NAO'),
            $this->vistoria(2, 44, 'L1', 3, 'M1', 'APTO_COM_RESSALVAS', 'SIM', 'REGULAR', 'SIM', 'NAO', 'SIM'),
            $this->vistoria(3, 44, 'L2', 7, 'M2', 'INAPTO', 'NAO', 'BOA', 'NAO', 'NAO', 'SIM'),
            $this->vistoria(4, 44, 'L3', 9, 'M3', 'APTO', 'SIM', 'OTIMA', 'SIM', 'SIM', 'SIM'),
            $this->vistoria(5, 99, 'L2', 7, 'M2', 'APTO', 'SIM', 'OTIMA', 'SIM', 'SIM', 'SIM'),
        ]);
    }

    protected function tearDown(): void
    {
        DB::statement('DROP TABLE IF EXISTS lda_vistoria_transmissao');
        DB::statement('DROP TABLE IF EXISTS MUNICIPIO');
        DB::statement('DROP TABLE IF EXISTS planeleito.vw_locais_votacao_efetivos');
        DB::statement('DETACH DATABASE planeleito');

        parent::tearDown();
    }

    public function test_resume_somente_macroprojeto_e_zonas_autorizadas_sem_truncar_grupos(): void
    {
        $dashboard = app(VistoriaTransmissaoRepository::class)
            ->resumirDashboard(44, [3, 7], false);

        $this->assertSame([
            'vistorias' => 3,
            'locais' => 2,
            'aptos' => 1,
            'ressalvas' => 1,
            'inaptos' => 1,
        ], $dashboard['totais']);
        $this->assertSame([
            ['zona' => 3, 'total' => 2],
            ['zona' => 7, 'total' => 1],
        ], $dashboard['porZona']);
        $this->assertSame([
            ['municipio' => 'RIO BRANCO', 'total' => 2],
            ['municipio' => 'CRUZEIRO DO SUL', 'total' => 1],
        ], $dashboard['porMunicipio']);
        $this->assertSame([
            'sala_transmissao' => 2,
            'energia_adequada' => 2,
            'internet' => 2,
            'vpn' => 1,
            'contingencia_movel' => 2,
        ], $dashboard['cobertura']);
    }

    public function test_aplica_zona_e_municipio_sobre_o_escopo_autorizado(): void
    {
        $dashboard = app(VistoriaTransmissaoRepository::class)
            ->resumirDashboard(44, [3, 7], false, 7, 'M2');

        $this->assertSame(1, $dashboard['totais']['vistorias']);
        $this->assertSame(1, $dashboard['totais']['inaptos']);
        $this->assertSame([['zona' => 7, 'total' => 1]], $dashboard['porZona']);
        $this->assertSame(
            [['municipio' => 'CRUZEIRO DO SUL', 'total' => 1]],
            $dashboard['porMunicipio']
        );
    }

    /** @return array<string, int|string> */
    private function vistoria(
        int $id,
        int $macroprojetoId,
        string $local,
        int $zona,
        string $municipio,
        string $situacao,
        string $sala,
        string $energia,
        string $internet,
        string $vpn,
        string $contingencia
    ): array {
        return [
            'id' => $id,
            'macroprojeto_id' => $macroprojetoId,
            'local_votacao_cod' => $local,
            'zona_num' => $zona,
            'municipio_cod' => $municipio,
            'situacao_geral' => $situacao,
            'tem_sala_transmissao' => $sala,
            'qualidade_energia' => $energia,
            'tem_internet' => $internet,
            'conectou_vpn' => $vpn,
            'internet_movel_contingencia' => $contingencia,
        ];
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAODASHBOARDREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoDashboardUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAODASHBOARDUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoDashboardUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoDashboardUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_listagem_oferece_botao_sem_embutir_o_dashboard(): void
public function test_dashboard_tem_filtros_indicadores_graficos_e_retorno_a_listagem(): void
public function test_filtro_territorial_compartilhado_preserva_cascata_e_auto_envio_da_listagem(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class VistoriaTransmissaoDashboardUiTest extends TestCase
{
    public function test_listagem_oferece_botao_sem_embutir_o_dashboard(): void
    {
        $listagem = file_get_contents(resource_path('views/lda/vistoria_transmissao/index.blade.php'));

        $this->assertStringContainsString("route('lda.vistoria-transmissao.dashboard')", $listagem);
        $this->assertStringContainsString('Abrir dashboard', $listagem);
        $this->assertStringNotContainsString('chartVistoriasSituacao', $listagem);
    }

    public function test_dashboard_tem_filtros_indicadores_graficos_e_retorno_a_listagem(): void
    {
        $dashboard = file_get_contents(resource_path('views/lda/vistoria_transmissao/dashboard.blade.php'));

        $this->assertStringContainsString('Dashboard de vistorias', $dashboard);
        $this->assertStringContainsString("route('lda.vistoria-transmissao')", $dashboard);
        $this->assertStringContainsString('data-vistoria-filtros-form', $dashboard);
        $this->assertStringContainsString('chartVistoriasSituacao', $dashboard);
        $this->assertStringContainsString('chartVistoriasZona', $dashboard);
        $this->assertStringContainsString('chartVistoriasMunicipio', $dashboard);
        $this->assertStringContainsString("asset('vendor/chartjs/chart.umd.min.js')", $dashboard);
        $this->assertStringContainsString("asset('js/lda-vistoria-transmissao-dashboard.js')", $dashboard);
    }

    public function test_filtro_territorial_compartilhado_preserva_cascata_e_auto_envio_da_listagem(): void
    {
        $filtros = file_get_contents(public_path('js/lda-vistoria-transmissao-filtros.js'));

        $this->assertStringContainsString("municipioOculto.value = '';", $filtros);
        $this->assertStringContainsString('zona: zona.value', $filtros);
        $this->assertStringContainsString(
            "formulario.hasAttribute('data-vistoria-filtros-auto-submit-municipio')",
            $filtros
        );
        $this->assertStringContainsString('formulario.submit();', $filtros);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAODASHBOARDUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoEsferaUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOESFERAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoEsferaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoEsferaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function select_de_esfera_renderiza_da_fonte_central_sem_hardcode(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoEsferaUiTest extends TestCase
{
    #[Test]
    public function select_de_esfera_renderiza_da_fonte_central_sem_hardcode(): void
    {
        $form = file_get_contents(resource_path('views/lda/vistoria_transmissao/form.blade.php'));

        $this->assertIsString($form);

        // Itera a fonte central $esferas.
        $this->assertStringContainsString('@foreach($esferas as $esf)', $form);
        $this->assertStringContainsString('value="{{ $esf->codigo }}"', $form);

        // Não pode mais conter as opções literais hardcoded.
        $this->assertStringNotContainsString("'FEDERAL' => 'Federal'", $form);
        $this->assertStringNotContainsString("'ESTADUAL' => 'Estadual'", $form);
        $this->assertStringNotContainsString("'MUNICIPAL' => 'Municipal'", $form);
        $this->assertStringNotContainsString("'PARTICULAR' => 'Particular'", $form);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOESFERAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoInternetUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOINTERNETUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoInternetUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoInternetUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function select_de_tipo_internet_renderiza_da_fonte_central_sem_hardcode(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoInternetUiTest extends TestCase
{
    #[Test]
    public function select_de_tipo_internet_renderiza_da_fonte_central_sem_hardcode(): void
    {
        $form = file_get_contents(resource_path('views/lda/vistoria_transmissao/form.blade.php'));

        $this->assertIsString($form);

        // Itera a fonte central $internets.
        $this->assertStringContainsString('@foreach($internets as $int)', $form);
        $this->assertStringContainsString('value="{{ $int->id }}"', $form);

        // Não pode mais conter as opções literais hardcoded antigas.
        $this->assertStringNotContainsString("'FIBRA' => 'Fibra'", $form);
        $this->assertStringNotContainsString("'STARLINK' => 'Starlink'", $form);
        $this->assertStringNotContainsString("'ADSL' => 'ADSL'", $form);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOINTERNETUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoOpcaoBinariaMigrationTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOOPCAOBINARIAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoOpcaoBinariaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoOpcaoBinariaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_converte_campos_binarios_e_ternarios_para_codigo_textual(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoOpcaoBinariaMigrationTest extends TestCase
{
    #[Test]
    public function migration_converte_campos_binarios_e_ternarios_para_codigo_textual(): void
    {
        $arquivo = database_path('migrations/2026_06_20_130000_convert_vistoria_transmissao_campos_para_opcao_binaria.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        // Limpa dados de teste antes de alterar tipo (tela ainda nao em producao).
        $this->assertStringContainsString('DELETE FROM lda_vistoria_transmissao', $conteudo);

        // Remove os CHECKs hardcoded dos antigos ternarios.
        $this->assertStringContainsString('DROP CONSTRAINT chk_lvt_abre_fora', $conteudo);
        $this->assertStringContainsString('DROP CONSTRAINT chk_lvt_link_orgao', $conteudo);

        // Converte colunas binarias NUMBER(1) e os antigos ternarios para texto (codigo).
        foreach ([
            'tem_estacionamento', 'vaga_equipe_tecnica', 'tem_controle_acesso',
            'tem_sala_transmissao', 'sala_tem_chave', 'local_seguro_equipamentos',
            'tem_tomada_proxima', 'tomadas_bom_estado', 'tem_nobreak',
            'tem_internet', 'internet_cabeada', 'internet_wifi',
            'conectou_vpn', 'tem_sinal_celular', 'internet_movel_contingencia',
            'abre_fora_horario', 'link_proprio_orgao',
        ] as $coluna) {
            $this->assertMatchesRegularExpression(
                '/' . preg_quote($coluna, '/') . '\s+VARCHAR2\(20 CHAR\)/',
                $conteudo
            );
        }
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOOPCAOBINARIAMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoOpcaoBinariaUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOOPCAOBINARIAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoOpcaoBinariaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoOpcaoBinariaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function partial_sim_nao_renderiza_a_partir_da_fonte_central_sem_hardcode(): void
public function form_remove_ternarios_e_logica_condicional_usa_codigo_afirmativo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoOpcaoBinariaUiTest extends TestCase
{
    #[Test]
    public function partial_sim_nao_renderiza_a_partir_da_fonte_central_sem_hardcode(): void
    {
        $partial = file_get_contents(resource_path('views/lda/vistoria_transmissao/partials/sim-nao.blade.php'));

        $this->assertIsString($partial);

        // Renderiza iterando a fonte central, usando codigo como value e descricao como rotulo.
        $this->assertStringContainsString('$opcoesBinarias', $partial);
        $this->assertStringContainsString('value="{{ $opcao->codigo }}"', $partial);
        $this->assertStringContainsString('$opcao->descricao', $partial);
        $this->assertStringContainsString('data-afirmativo', $partial);

        // Não pode mais conter os rótulos/valores binários hardcoded.
        $this->assertStringNotContainsString('value="1"', $partial);
        $this->assertStringNotContainsString('value="0"', $partial);
    }

    #[Test]
    public function form_remove_ternarios_e_logica_condicional_usa_codigo_afirmativo(): void
    {
        $partial = file_get_contents(resource_path('views/lda/vistoria_transmissao/partials/sim-nao.blade.php'));
        $form = file_get_contents(resource_path('views/lda/vistoria_transmissao/form.blade.php'));

        $this->assertIsString($partial);
        $this->assertIsString($form);

        // Os antigos ternários viraram binários (não há mais Parcial / Não sabe).
        $this->assertStringNotContainsString('PARCIAL', $form);
        $this->assertStringNotContainsString('NAO_SABE', $form);

        // abre_fora_horario e link_proprio_orgao passam pelo partial de opção binária.
        $this->assertStringContainsString("'campo' => 'abre_fora_horario'", $form);
        $this->assertStringContainsString("'campo' => 'link_proprio_orgao'", $form);

        // JS condicional usa o atributo data-afirmativo com o código configurado, não sentinela 1/0.
        $this->assertStringContainsString('data-afirmativo="{{ $codigoAfirmativo }}"', $partial);
        $this->assertStringContainsString('selecionado.value === selecionado.dataset.afirmativo', $form);
        $this->assertStringNotContainsString('data-afirmativo="1"', $partial);
        $this->assertStringNotContainsString('[value="1"]', $form);

        // Condições server-side comparam com o código afirmativo.
        $this->assertStringContainsString('!== $codigoAfirmativo', $form);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOOPCAOBINARIAUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoQualidadeUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOQUALIDADEUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoQualidadeUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoQualidadeUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function selects_de_qualidade_renderizam_da_fonte_central_sem_hardcode(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoQualidadeUiTest extends TestCase
{
    #[Test]
    public function selects_de_qualidade_renderizam_da_fonte_central_sem_hardcode(): void
    {
        $form = file_get_contents(resource_path('views/lda/vistoria_transmissao/form.blade.php'));

        $this->assertIsString($form);

        // Os sete campos de qualidade iteram a fonte central $qualidades.
        $this->assertStringContainsString('@foreach($qualidades as $q)', $form);
        $this->assertStringContainsString('value="{{ $q->codigo }}"', $form);

        // Não pode mais conter as listas literais de qualidade (feminino e masculino).
        $this->assertStringNotContainsString("'OTIMA' => 'Ótima'", $form);
        $this->assertStringNotContainsString("'OTIMO' => 'Ótimo'", $form);
        $this->assertStringNotContainsString("'INEXISTENTE' => 'Inexistente'", $form);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOQUALIDADEUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoSinalUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOSINALUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoSinalUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoSinalUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function formulario_consume_fontes_centrais_de_operadora_e_tipo_sinal_sem_hardcode(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoSinalUiTest extends TestCase
{
    #[Test]
    public function formulario_consume_fontes_centrais_de_operadora_e_tipo_sinal_sem_hardcode(): void
    {
        $form = file_get_contents(resource_path('views/lda/vistoria_transmissao/form.blade.php'));

        $this->assertIsString($form);

        $this->assertStringContainsString('@foreach($operadoras as $operadora)', $form);
        $this->assertStringContainsString('name="operadoras[]"', $form);
        $this->assertStringContainsString('name="tipo_sinal[{{ $codigoOperadora }}]"', $form);
        $this->assertStringContainsString('@foreach($tiposSinal as $tipo)', $form);

        $this->assertStringNotContainsString("['vivo' => 'Vivo', 'claro' => 'Claro', 'tim' => 'Tim']", $form);
        $this->assertStringNotContainsString("@foreach(['3G', '4G', '5G'] as \$tipo)", $form);
        $this->assertStringNotContainsString('name="tipo_sinal_vivo"', $form);
        $this->assertStringNotContainsString('name="tipo_sinal_claro"', $form);
        $this->assertStringNotContainsString('name="tipo_sinal_tim"', $form);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOSINALUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoSinalVinculoMigrationTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOSINALVINCULOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoSinalVinculoMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoSinalVinculoMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_vinculo_de_sinal_e_remove_colunas_por_operadora(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoSinalVinculoMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_vinculo_de_sinal_e_remove_colunas_por_operadora(): void
    {
        $arquivo = database_path('migrations/2026_06_20_170000_create_vistoria_transmissao_sinal_vinculo.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        // Tabela de vínculo.
        $this->assertStringContainsString('CREATE TABLE lda_vistoria_transmissao_sinal', $conteudo);
        $this->assertStringContainsString('vistoria_id', $conteudo);
        $this->assertStringContainsString('operadora_codigo', $conteudo);
        $this->assertStringContainsString('tipo_sinal_codigo', $conteudo);
        $this->assertStringContainsString('qualidade_codigo', $conteudo);
        $this->assertStringContainsString('REFERENCES lda_vistoria_transmissao (id)', $conteudo);
        $this->assertStringContainsString('ON DELETE CASCADE', $conteudo);
        $this->assertStringContainsString('ux_lvts_vistoria_operadora', $conteudo);

        // Remoção dos CHECKs por operadora (gerados em loop por $op) e das colunas.
        $this->assertStringContainsString('DROP CONSTRAINT chk_vt_ts_', $conteudo);
        $this->assertStringContainsString('DROP CONSTRAINT chk_vt_qs_', $conteudo);
        $this->assertStringContainsString('tipo_sinal_vivo', $conteudo);
        $this->assertStringContainsString('qualidade_sinal_tim', $conteudo);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOSINALVINCULOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoTipoTomadaUiTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAOTIPOTOMADAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoTipoTomadaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoTipoTomadaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function select_de_tipo_tomada_renderiza_da_fonte_central_sem_hardcode(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaTransmissaoTipoTomadaUiTest extends TestCase
{
    #[Test]
    public function select_de_tipo_tomada_renderiza_da_fonte_central_sem_hardcode(): void
    {
        $form = file_get_contents(resource_path('views/lda/vistoria_transmissao/form.blade.php'));

        $this->assertIsString($form);

        // Itera a fonte central $tiposTomada.
        $this->assertStringContainsString('@foreach($tiposTomada as $t)', $form);
        $this->assertStringContainsString('value="{{ $t->codigo }}"', $form);

        // Não pode mais conter as opções literais hardcoded antigas.
        $this->assertStringNotContainsString("'3PINOS_CHATOS' => '3 pinos chatos", $form);
        $this->assertStringNotContainsString("'3PINOS_NBR' => '3 pinos (NBR)'", $form);
        $this->assertStringNotContainsString("'2PINOS_CHATOS' => '2 pinos chatos'", $form);
        $this->assertStringNotContainsString("'2PINOS_REDONDOS' => '2 pinos redondos'", $form);
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAOTIPOTOMADAUITEST_PHP>


