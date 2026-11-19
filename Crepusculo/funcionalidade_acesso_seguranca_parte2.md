# 📦 Documentação Consolidada do Sistema Crepúsculo (Parte 2)
## Funcionalidade: `funcionalidade_acesso_seguranca`
> **Volume Fracionado para Otimização de Leitura por IA**
> **Tamanho Máximo:** 1500 KB

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocaisDificilAcessoUiTest.php`
## <TESTS_UNIT_LOCAISDIFICILACESSOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocaisDificilAcessoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocaisDificilAcessoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_de_locais_dificil_acesso_usa_formulario_get_e_links_de_paginacao_no_blade(): void
$this->assertStringContainsString('function carregarMunicipios()', $conteudo);
public function tela_de_locais_dificil_acesso_renderiza_os_detalhes_do_local_direto_no_blade(): void
public function formulario_de_lda_exibe_campos_de_deslocamento_previsto_e_real(): void
public function formulario_de_lda_exibe_bloco_de_ativos_glpi_com_busca_e_lista_selecionada(): void
public function tela_de_locais_dificil_acesso_carrega_detalhes_no_mesmo_espaco_para_mesarios_e_recursos(): void
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

class LocaisDificilAcessoUiTest extends TestCase
{
    #[Test]
    public function tela_de_locais_dificil_acesso_usa_formulario_get_e_links_de_paginacao_no_blade(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/locais_dificil_acesso.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<th scope="col">Local</th>', $conteudo);
        $this->assertStringContainsString('<th scope="col">Ações</th>', $conteudo);
        $this->assertStringContainsString('method="GET"', $conteudo);
        $this->assertStringContainsString('data-url-municipios', $conteudo);
        $this->assertStringContainsString("route('lda.locais-votacao.municipios')", $conteudo);
        $this->assertStringContainsString('name="zona"', $conteudo);
        $this->assertStringContainsString('name="municipio"', $conteudo);
        $this->assertStringContainsString('id="filtroMunicipio"', $conteudo);
        $this->assertStringContainsString('name="busca"', $conteudo);
        $this->assertStringContainsString('name="internet"', $conteudo);
        $this->assertStringContainsString('name="recursos_escopo"', $conteudo);
        $this->assertStringContainsString('name="recursos_operador"', $conteudo);
        $this->assertStringContainsString('Consulta Parametrizada', $conteudo);
        $this->assertStringContainsString('name="recursos_valor"', $conteudo);
        $this->assertStringContainsString("var municipio = document.getElementById('filtroMunicipio');", $conteudo);
        $this->assertStringContainsString('function carregarMunicipios()', $conteudo);
        $this->assertStringContainsString("zona.addEventListener('change'", $conteudo);
        $this->assertStringContainsString('value="recursos_glpi"', $conteudo);
        $this->assertStringContainsString('Número de recursos alocados no LDA', $conteudo);
        $this->assertStringContainsString('Maior que', $conteudo);
        $this->assertStringContainsString('Menor que', $conteudo);
        $this->assertStringContainsString('Igual a', $conteudo);
        $this->assertStringContainsString("route('lda.locais-dificil-acesso.exportar', \$filtros)", $conteudo);
        $this->assertStringContainsString('Exportar Excel', $conteudo);
        $this->assertStringContainsString('Seções vinculadas', $conteudo);
        $this->assertStringContainsString('LDA por zona', $conteudo);
        $this->assertStringContainsString('LDA por município', $conteudo);
        $this->assertStringContainsString('Território selecionado', $conteudo);
        $this->assertStringContainsString('Município selecionado', $conteudo);
        $this->assertStringContainsString("{{ \$locais->links('pagination::bootstrap-5') }}", $conteudo);
        $this->assertStringNotContainsString('id="ldaPaginationWrapper"', $conteudo);
        $this->assertStringNotContainsString('Carregando locais…', $conteudo);
        $this->assertStringNotContainsString('id="ldaLoadingRow"', $conteudo);
    }

    #[Test]
    public function tela_de_locais_dificil_acesso_renderiza_os_detalhes_do_local_direto_no_blade(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/locais_dificil_acesso.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('@forelse($locais as $local)', $conteudo);
        $this->assertStringContainsString("{{ \$local['nome_local'] ?? '—' }}", $conteudo);
        $this->assertStringContainsString("Mesários convocados ({{ (int) (\$local['qtd_mesarios_convocados'] ?? 0) }})", $conteudo);
        $this->assertStringContainsString("Recursos alocados ({{ (int) (\$local['qtd_recursos_glpi'] ?? 0) }})", $conteudo);
        $this->assertStringContainsString('data-detalhe-group', $conteudo);
        $this->assertStringContainsString('data-detalhe-trigger', $conteudo);
        $this->assertStringContainsString('data-detalhe-tipo="mesarios"', $conteudo);
        $this->assertStringContainsString('data-detalhe-tipo="recursos"', $conteudo);
        $this->assertStringContainsString("data-detalhe-url=\"{{ route('lda.mesarios', \$local['id']) }}\"", $conteudo);
        $this->assertStringContainsString("data-detalhe-url=\"{{ route('lda.recursos', \$local['id']) }}\"", $conteudo);
        $this->assertStringContainsString("route('lda.form', \$local['id'])", $conteudo);
        $this->assertStringContainsString("route('lda.destroy', \$local['id'])", $conteudo);
    }

    #[Test]
    public function formulario_de_lda_exibe_campos_de_deslocamento_previsto_e_real(): void
    {
        $formulario = file_get_contents(resource_path('views/lda/form.blade.php'));
        $conteudo = file_get_contents(resource_path('views/lda/partials/deslocamento-local-votacao.blade.php'));

        $this->assertIsString($formulario);
        $this->assertIsString($conteudo);
        $this->assertStringContainsString("@include('lda.partials.deslocamento-local-votacao'", $formulario);
        $this->assertStringContainsString("'dt_saida_prevista' => 'Saída prevista'", $conteudo);
        $this->assertStringContainsString("'dt_chegada_prevista' => 'Chegada prevista'", $conteudo);
        $this->assertStringContainsString("'dt_saida_real' => 'Saída real'", $conteudo);
        $this->assertStringContainsString("'dt_chegada_real' => 'Chegada real'", $conteudo);
        $this->assertStringContainsString("'dt_saida_prevista_volta' => 'Saída prevista'", $conteudo);
        $this->assertStringContainsString("'dt_chegada_prevista_volta' => 'Chegada prevista'", $conteudo);
        $this->assertStringContainsString("'dt_saida_real_volta' => 'Saída real'", $conteudo);
        $this->assertStringContainsString("'dt_chegada_real_volta' => 'Chegada real'", $conteudo);
        $this->assertStringContainsString('name="{{ $campo }}"', $conteudo);
        $this->assertStringContainsString('name="observacao_deslocamento"', $conteudo);
        $this->assertStringContainsString("'Ida' => [", $conteudo);
        $this->assertStringContainsString("'Volta' => [", $conteudo);
    }

    #[Test]
    public function formulario_de_lda_exibe_bloco_de_ativos_glpi_com_busca_e_lista_selecionada(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Ativos operacionais', $conteudo);
        $this->assertStringContainsString('id="glpi_ativo_busca"', $conteudo);
        $this->assertStringContainsString("route('lda.ativos-glpi.buscar')", $conteudo);
        $this->assertStringContainsString('data-ativos-glpi-wrapper', $conteudo);
        $this->assertStringContainsString('data-ativos-glpi-template', $conteudo);
        $this->assertStringContainsString('data-ativo-glpi-remove', $conteudo);
        $this->assertStringContainsString('Nenhum ativo selecionado.', $conteudo);
    }

    #[Test]
    public function tela_de_locais_dificil_acesso_carrega_detalhes_no_mesmo_espaco_para_mesarios_e_recursos(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/locais_dificil_acesso.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("document.addEventListener('click', function (event)", $conteudo);
        $this->assertStringContainsString("var trigger = event.target.closest('[data-detalhe-trigger]');", $conteudo);
        $this->assertStringContainsString("var tipo = trigger.dataset.detalheTipo || '';", $conteudo);
        $this->assertStringContainsString('collapse.dataset.currentTipo = tipo;', $conteudo);
        $this->assertStringContainsString('cache[tipo] = payload;', $conteudo);
        $this->assertStringContainsString('Clique em um dos olhinhos para carregar mesários, recursos operacionais ou recursos logísticos.', $conteudo);
        $this->assertStringContainsString('Mesários convocados', $conteudo);
        $this->assertStringContainsString('Recursos alocados', $conteudo);
        $this->assertStringNotContainsString('window.LDARoutes', $conteudo);
        $this->assertStringNotContainsString("asset('js/lda-locais-dificil-acesso.js')", $conteudo);
    }
}
```
</TESTS_UNIT_LOCAISDIFICILACESSOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalDificilAcessoControllerEquipePersistenciaTest.php`
## <TESTS_UNIT_LOCALDIFICILACESSOCONTROLLEREQUIPEPERSISTENCIATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalDificilAcessoControllerEquipePersistenciaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalDificilAcessoControllerEquipePersistenciaTest extends TestCase`

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
public function test_form_redireciona_para_selecao_de_macroprojeto_quando_nao_houver_contexto_ativo(): void
public function test_store_retorna_409_json_quando_nao_houver_macroprojeto_ativo(): void
public function test_form_de_lda_carrega_mesarios_existentes_do_local_vinculado(): void
public function test_store_sincroniza_transmissoes_apos_criar_lda(): void
public function test_store_retorna_422_quando_recurso_glpi_ja_estiver_alocado_no_macroprojeto(): void
public function test_update_sincroniza_transmissoes_apos_atualizar_lda(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\LocalDificilAcessoController;
use App\Http\Requests\Lda\LocalDificilAcessoRequest;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\Lda\KitVinculoRepository;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoDeslocamentoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\Lda\GlpiApiService;
use App\Services\Lda\RecursoLogisticoLocalService;
use App\Services\Lda\TransmissaoPreferenciaService;
use App\Services\LocaisVotacao\TrajetoLocalVotacaoService;
use DomainException;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class LocalDificilAcessoControllerEquipePersistenciaTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        $kits = Mockery::mock(KitVinculoRepository::class)->shouldIgnoreMissing();
        $kits->shouldReceive('listarPorCodigo')->byDefault()->andReturn([]);
        $this->app->instance(KitVinculoRepository::class, $kits);
    }

    protected function tearDown(): void
    {
        @restore_error_handler();
        @restore_exception_handler();
        Mockery::close();
        parent::tearDown();
    }

    public function test_form_redireciona_para_selecao_de_macroprojeto_quando_nao_houver_contexto_ativo(): void
    {
        session()->forget('macroprojeto_ativo_id');

        $controller = new LocalDificilAcessoController(
            Mockery::mock(LocalDificilAcessoRepository::class),
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->form(8);

        $this->assertSame(302, $response->getStatusCode());
        $this->assertStringContainsString('/planejamento/macroprojeto/selecionar', $response->headers->get('Location', ''));
    }

    public function test_store_retorna_409_json_quando_nao_houver_macroprojeto_ativo(): void
    {
        session()->forget('macroprojeto_ativo_id');
        request()->headers->set('Accept', 'application/json');
        request()->headers->set('X-Requested-With', 'XMLHttpRequest');

        $request = Mockery::mock(LocalDificilAcessoRequest::class);
        $request->shouldReceive('expectsJson')->andReturn(true);
        $request->shouldReceive('ajax')->andReturn(true);

        $controller = new LocalDificilAcessoController(
            Mockery::mock(LocalDificilAcessoRepository::class),
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->store($request);

        $this->assertSame(409, $response->getStatusCode());
        $this->assertSame('Selecione um macroprojeto para continuar.', $response->getData(true)['mensagem']);
    }

    public function test_form_de_lda_carrega_mesarios_existentes_do_local_vinculado(): void
    {
        session([
            'macroprojeto_ativo_id' => 14,
            'macroprojeto_turno_ativo_id' => 501,
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('buscarDetalhes')->once()->with(8)->andReturn([
            'id' => 8,
            'nome_local' => 'LDA Teste',
            'zona_id' => 2,
            'num_zona' => 2,
            'municipio_id' => 16,
            'cod_objeto_local_votacao' => '123',
            'detalhamento_trajeto' => 'Percurso por via fluvial.',
        ]);
        $deslocamentoRepository = Mockery::mock(LocalVotacaoDeslocamentoRepository::class);
        $deslocamentoRepository->shouldReceive('buscarPorLocal')->once()->with('123', 501)->andReturn([
            'dt_saida_prevista' => '2026-09-15 08:00',
            'dt_chegada_prevista' => '2026-09-15 14:00',
            'dt_saida_real' => '2026-09-15 08:30',
            'dt_chegada_real' => null,
            'observacao_deslocamento' => 'Saída ajustada por clima.',
        ]);
        $this->app->instance(LocalVotacaoDeslocamentoRepository::class, $deslocamentoRepository);
        $localVotacaoRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacaoRepository->shouldReceive('buscarNoEscopo')->once()->with('123', [2], false)->andReturn((object) ['cod_objeto' => '123']);
        $this->app->instance(LocalVotacaoRepository::class, $localVotacaoRepository);
        $trajetoService = Mockery::mock(TrajetoLocalVotacaoService::class);
        $trajetoService->shouldReceive('buscarPorLocal')->once()->with('123', 14)->andReturn([
            [
                'ordem_preferencia' => 1,
                'descricao' => '',
                'trechos' => [[
                    'ordem' => 1,
                    'acesso_id' => 3,
                    'origem' => 'Rio Branco',
                    'destino' => 'Base A',
                    'distancia_km' => 18.7,
                    'tempo_deslocamento_horas' => 2.5,
                    'observacao' => 'Subida do rio',
                ]],
            ],
        ]);
        $this->app->instance(TrajetoLocalVotacaoService::class, $trajetoService);
        $recursoService = Mockery::mock(RecursoLogisticoLocalService::class);
        $recursoService->shouldReceive('buscarPorLocal')->once()->with('123', 14)->andReturn([
            [
                'recurso_opcao_id' => 2,
                'codigo' => 'URNAS',
                'nome' => 'URNAS',
                'quantidade' => 2,
                'peso_total_kg' => 24.5,
            ],
        ]);
        $recursoService->shouldReceive('opcoesAtivas')->once()->andReturn([
            ['id' => 2, 'codigo' => 'URNAS', 'nome' => 'URNAS', 'ordem' => 2],
        ]);
        $this->app->instance(RecursoLogisticoLocalService::class, $recursoService);
        $repository->shouldReceive('buscarAtivosGlpi')->once()->with(8, 14)->andReturn([
            [
                'ordem' => 1,
                'glpi_item_id' => 77,
                'glpi_itemtype' => 'Computer',
                'nome' => 'NOTEBOOK OPERACIONAL',
                'serial' => 'SER123',
                'otherserial' => 'PAT456',
                'status' => 'Operacional',
                'entidade_id' => 0,
                'entidade_nome' => 'TRE-AC',
            ],
        ]);
        $repository->shouldReceive('listarMesariosConvocadosPorCodigoLocal')->once()->with('123', [2], false)->andReturn([
            ['nom_eleitor' => 'Fulano', 'cargo_nome' => 'Presidente', 'num_secao' => '001'],
        ]);
        $repository->shouldReceive('buscarLocalVotacaoPorCodigo')->once()->with('123')->andReturn((object) [
            'id' => '123',
            'texto' => '2 - RIO BRANCO - LDA TESTE',
        ]);
        $repository->shouldReceive('carregarOpcoesFormulario')->once()->andReturn([
            'zonas' => collect([(object) ['ID' => 2, 'NUM_ZONA' => 2, 'DESCRICAO' => 'Segunda Zona']]),
            'municipios' => collect([(object) ['ID' => 16, 'ZONAID' => 2, 'LOCALIDADE' => 'RIO BRANCO']]),
            'internets' => collect([]),
            'energias' => collect([]),
            'acessos' => collect([(object) ['ID' => 3, 'DESCRICAO' => 'BARCO']]),
        ]);

        $transmissoes = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissoes->shouldReceive('prepararParaFormulario')->once()->with('123', [])->andReturn([]);
        $glpi = Mockery::mock(GlpiApiService::class);
        $glpi->shouldReceive('enabled')->once()->andReturnTrue();

        $controller = new LocalDificilAcessoController(
            $repository,
            $transmissoes,
            Mockery::mock(EquipeRepositoryInterface::class),
            $glpi,
        );
        $response = $controller->form(8);

        $this->assertSame('lda.form', $response->name());
        $this->assertCount(1, $response->getData()['equipeLda']);
        $this->assertSame('Percurso por via fluvial.', $response->getData()['local']->detalhamento_trajeto);
        $this->assertSame('2026-09-15 08:00', $response->getData()['dadosDeslocamento']['dt_saida_prevista']);
        $this->assertSame('Saída ajustada por clima.', $response->getData()['dadosDeslocamento']['observacao_deslocamento']);
        $this->assertSame('Rio Branco', $response->getData()['local']->trajetos[0]['trechos'][0]['origem']);
        $this->assertSame(77, $response->getData()['ativosGlpi'][0]['glpi_item_id']);
    }

    public function test_store_sincroniza_transmissoes_apos_criar_lda(): void
    {
        session([
            'macroprojeto_ativo_id' => 14,
            'macroprojeto_turno_ativo_id' => 501,
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
        ]);

        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(LocalDificilAcessoRequest::class);
        $request->shouldReceive('dadosSanitizados')->once()->andReturn([
            'nome_local' => 'LDA Teste',
            'comunidade' => 'Comunidade',
            'endereco' => 'Endereço',
            'telefone' => '',
            'latitude' => -9.97,
            'longitude' => -67.81,
            'internet_id' => 1,
            'zona_id' => 2,
            'municipio_id' => 16,
            'cod_objeto_local_votacao' => '123',
            'obs' => '',
            'detalhamento_trajeto' => 'Acesso por barco e trilha.',
            'aparelho_satelite' => '',
        ]);
        $request->shouldReceive('energias')->once()->andReturn([1, 2]);
        $request->shouldReceive('acessos')->once()->andReturn([3]);
        $request->shouldReceive('trajetosSanitizados')->once()->andReturn([
            [
                'ordem_preferencia' => 1,
                'descricao' => '',
                'trechos' => [[
                    'ordem' => 1,
                    'acesso_id' => 3,
                    'origem' => 'Rio Branco',
                    'destino' => 'Base A',
                    'distancia_km' => 18.7,
                    'tempo_deslocamento_horas' => 2.5,
                    'observacao' => 'Subida do rio',
                ]],
            ],
        ]);
        $request->shouldReceive('dadosDeslocamentoSanitizados')->once()->andReturn([
            'dt_saida_prevista' => '2026-09-15 08:00',
            'dt_chegada_prevista' => '2026-09-15 14:00',
            'dt_saida_real' => null,
            'dt_chegada_real' => null,
            'observacao_deslocamento' => 'Janela inicial.',
        ]);
        $request->shouldReceive('transmissoesPreferenciais')->once()->andReturn(['lt:10']);
        $request->shouldReceive('ativosGlpiSanitizados')->once()->andReturn([
            [
                'ordem' => 1,
                'glpi_item_id' => 77,
                'glpi_itemtype' => 'Computer',
                'nome' => 'NOTEBOOK OPERACIONAL',
                'serial' => 'SER123',
                'otherserial' => 'PAT456',
                'status' => 'Operacional',
                'entidade_id' => 0,
                'entidade_nome' => 'TRE-AC',
            ],
        ]);
        $request->shouldReceive('recursosLogisticosSanitizados')->once()->andReturn([
            [
                'recurso_opcao_id' => 2,
                'quantidade' => 2,
                'peso_total_kg' => 24.5,
            ],
        ]);
        $request->shouldReceive('kitsJecIds')->once()->andReturn([]);
        $request->shouldReceive('deveSincronizarKitsJec')->once()->andReturnFalse();

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('criar')->once()->with(Mockery::type('array'), [1, 2], [3])->andReturn(8);
        $deslocamentoRepository = Mockery::mock(LocalVotacaoDeslocamentoRepository::class);
        $deslocamentoRepository->shouldReceive('salvarPorLocal')->once()->with('123', 501, [
            'dt_saida_prevista' => '2026-09-15 08:00',
            'dt_chegada_prevista' => '2026-09-15 14:00',
            'dt_saida_real' => null,
            'dt_chegada_real' => null,
            'observacao_deslocamento' => 'Janela inicial.',
        ]);
        $this->app->instance(LocalVotacaoDeslocamentoRepository::class, $deslocamentoRepository);
        $localVotacaoRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacaoRepository->shouldReceive('buscarNoEscopo')->once()->with('123', [2], false)->andReturn((object) ['cod_objeto' => '123']);
        $this->app->instance(LocalVotacaoRepository::class, $localVotacaoRepository);
        $repository->shouldReceive('salvarAtivosGlpi')->once()->with(8, 14, [
            [
                'ordem' => 1,
                'glpi_item_id' => 77,
                'glpi_itemtype' => 'Computer',
                'nome' => 'NOTEBOOK OPERACIONAL',
                'serial' => 'SER123',
                'otherserial' => 'PAT456',
                'status' => 'Operacional',
                'entidade_id' => 0,
                'entidade_nome' => 'TRE-AC',
            ],
        ]);
        $trajetoService = Mockery::mock(TrajetoLocalVotacaoService::class);
        $trajetoService->shouldReceive('salvarPorLocal')->once()->with('123', 14, Mockery::type('array'), 8);
        $this->app->instance(TrajetoLocalVotacaoService::class, $trajetoService);
        $recursoService = Mockery::mock(RecursoLogisticoLocalService::class);
        $recursoService->shouldReceive('salvarPorLocal')->once()->with('123', 14, [
            [
                'recurso_opcao_id' => 2,
                'quantidade' => 2,
                'peso_total_kg' => 24.5,
            ],
        ]);
        $this->app->instance(RecursoLogisticoLocalService::class, $recursoService);

        $transmissoes = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissoes->shouldReceive('sincronizar')->once()->with('123', ['lt:10']);

        $controller = new LocalDificilAcessoController(
            $repository,
            $transmissoes,
            Mockery::mock(EquipeRepositoryInterface::class),
        );
        $response = $controller->store($request);

        $this->assertSame(302, $response->getStatusCode());
    }

    public function test_store_retorna_422_quando_recurso_glpi_ja_estiver_alocado_no_macroprojeto(): void
    {
        session([
            'macroprojeto_ativo_id' => 14,
            'macroprojeto_turno_ativo_id' => 501,
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
        ]);
        request()->headers->set('Accept', 'application/json');
        request()->headers->set('X-Requested-With', 'XMLHttpRequest');

        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(LocalDificilAcessoRequest::class);
        $request->shouldReceive('dadosSanitizados')->once()->andReturn([
            'nome_local' => 'LDA Teste',
            'comunidade' => 'Comunidade',
            'endereco' => 'Endereço',
            'telefone' => '',
            'latitude' => -9.97,
            'longitude' => -67.81,
            'internet_id' => 1,
            'zona_id' => 2,
            'municipio_id' => 16,
            'cod_objeto_local_votacao' => '123',
            'obs' => '',
            'detalhamento_trajeto' => '',
            'aparelho_satelite' => '',
        ]);
        $request->shouldReceive('energias')->once()->andReturn([]);
        $request->shouldReceive('acessos')->once()->andReturn([]);
        $request->shouldReceive('trajetosSanitizados')->once()->andReturn([]);
        $request->shouldReceive('dadosDeslocamentoSanitizados')->once()->andReturn([]);
        $request->shouldReceive('transmissoesPreferenciais')->once()->andReturn([]);
        $request->shouldReceive('ativosGlpiSanitizados')->once()->andReturn([
            [
                'ordem' => 1,
                'glpi_item_id' => 2017,
                'glpi_itemtype' => 'Computer',
                'nome' => 'RACE013230',
                'serial' => 'PE08XDP3',
                'otherserial' => 'PAT001',
                'status' => 'OPERACIONAL',
                'entidade_id' => 0,
                'entidade_nome' => 'TRE-AC',
            ],
        ]);
        $request->shouldReceive('recursosLogisticosSanitizados')->once()->andReturn([]);
        $request->shouldReceive('kitsJecIds')->once()->andReturn([]);
        $request->shouldReceive('deveSincronizarKitsJec')->once()->andReturnFalse();

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('criar')->once()->andReturn(8);
        $trajetoService = Mockery::mock(TrajetoLocalVotacaoService::class);
        $trajetoService->shouldReceive('salvarPorLocal')->once()->with('123', 14, [], 8);
        $this->app->instance(TrajetoLocalVotacaoService::class, $trajetoService);
        $recursoService = Mockery::mock(RecursoLogisticoLocalService::class);
        $recursoService->shouldReceive('salvarPorLocal')->once()->with('123', 14, []);
        $this->app->instance(RecursoLogisticoLocalService::class, $recursoService);
        $deslocamentoRepository = Mockery::mock(LocalVotacaoDeslocamentoRepository::class);
        $deslocamentoRepository->shouldReceive('salvarPorLocal')->once()->with('123', 501, []);
        $this->app->instance(LocalVotacaoDeslocamentoRepository::class, $deslocamentoRepository);
        $localVotacaoRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacaoRepository->shouldReceive('buscarNoEscopo')->once()->with('123', [2], false)->andReturn((object) ['cod_objeto' => '123']);
        $this->app->instance(LocalVotacaoRepository::class, $localVotacaoRepository);
        $repository->shouldReceive('salvarAtivosGlpi')->once()->with(8, 14, Mockery::type('array'))
            ->andThrow(new DomainException('O recurso RACE013230 já está alocado ao LDA BASE A neste macroprojeto.'));

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->store($request);

        $this->assertSame(422, $response->getStatusCode());
        $this->assertStringContainsString('RACE013230', $response->getData(true)['mensagem']);
    }

    public function test_update_sincroniza_transmissoes_apos_atualizar_lda(): void
    {
        session([
            'macroprojeto_ativo_id' => 14,
            'macroprojeto_turno_ativo_id' => 501,
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
        ]);

        DB::shouldReceive('transaction')->once()->andReturnUsing(fn ($callback) => $callback());

        $request = Mockery::mock(LocalDificilAcessoRequest::class);
        $request->shouldReceive('dadosSanitizados')->once()->andReturn([
            'nome_local' => 'LDA Teste',
            'comunidade' => 'Comunidade',
            'endereco' => 'Endereço',
            'telefone' => '',
            'latitude' => -9.97,
            'longitude' => -67.81,
            'internet_id' => 1,
            'zona_id' => 2,
            'municipio_id' => 16,
            'cod_objeto_local_votacao' => '123',
            'obs' => '',
            'detalhamento_trajeto' => 'Acesso por barco e trilha.',
            'aparelho_satelite' => '',
        ]);
        $request->shouldReceive('energias')->once()->andReturn([1, 2]);
        $request->shouldReceive('acessos')->once()->andReturn([3]);
        $request->shouldReceive('trajetosSanitizados')->once()->andReturn([
            [
                'ordem_preferencia' => 1,
                'descricao' => '',
                'trechos' => [[
                    'ordem' => 1,
                    'acesso_id' => 3,
                    'origem' => 'Rio Branco',
                    'destino' => 'Base A',
                    'distancia_km' => 18.7,
                    'tempo_deslocamento_horas' => 2.5,
                    'observacao' => 'Subida do rio',
                ]],
            ],
        ]);
        $request->shouldReceive('dadosDeslocamentoSanitizados')->once()->andReturn([
            'dt_saida_prevista' => '2026-09-15 08:00',
            'dt_chegada_prevista' => '2026-09-15 14:00',
            'dt_saida_real' => '2026-09-15 09:00',
            'dt_chegada_real' => null,
            'observacao_deslocamento' => 'Saída confirmada.',
        ]);
        $request->shouldReceive('transmissoesPreferenciais')->once()->andReturn(['lt:10']);
        $request->shouldReceive('ativosGlpiSanitizados')->once()->andReturn([
            [
                'ordem' => 1,
                'glpi_item_id' => 77,
                'glpi_itemtype' => 'Computer',
                'nome' => 'NOTEBOOK OPERACIONAL',
                'serial' => 'SER123',
                'otherserial' => 'PAT456',
                'status' => 'Operacional',
                'entidade_id' => 0,
                'entidade_nome' => 'TRE-AC',
            ],
        ]);
        $request->shouldReceive('recursosLogisticosSanitizados')->once()->andReturn([
            [
                'recurso_opcao_id' => 3,
                'quantidade' => 1,
                'peso_total_kg' => 3.75,
            ],
        ]);
        $request->shouldReceive('kitsJecIds')->once()->andReturn([]);
        $request->shouldReceive('deveSincronizarKitsJec')->once()->andReturnFalse();

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('buscarDetalhes')->once()->with(8)->andReturn([
            'id' => 8,
            'num_zona' => 2,
            'cod_objeto_local_votacao' => '123',
        ]);
        $repository->shouldReceive('atualizar')->once()->with(8, Mockery::type('array'), [1, 2], [3]);
        $deslocamentoRepository = Mockery::mock(LocalVotacaoDeslocamentoRepository::class);
        $deslocamentoRepository->shouldReceive('salvarPorLocal')->once()->with('123', 501, [
            'dt_saida_prevista' => '2026-09-15 08:00',
            'dt_chegada_prevista' => '2026-09-15 14:00',
            'dt_saida_real' => '2026-09-15 09:00',
            'dt_chegada_real' => null,
            'observacao_deslocamento' => 'Saída confirmada.',
        ]);
        $this->app->instance(LocalVotacaoDeslocamentoRepository::class, $deslocamentoRepository);
        $localVotacaoRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacaoRepository->shouldReceive('buscarNoEscopo')->once()->with('123', [2], false)->andReturn((object) ['cod_objeto' => '123']);
        $this->app->instance(LocalVotacaoRepository::class, $localVotacaoRepository);
        $repository->shouldReceive('salvarAtivosGlpi')->once()->with(8, 14, [
            [
                'ordem' => 1,
                'glpi_item_id' => 77,
                'glpi_itemtype' => 'Computer',
                'nome' => 'NOTEBOOK OPERACIONAL',
                'serial' => 'SER123',
                'otherserial' => 'PAT456',
                'status' => 'Operacional',
                'entidade_id' => 0,
                'entidade_nome' => 'TRE-AC',
            ],
        ]);
        $trajetoService = Mockery::mock(TrajetoLocalVotacaoService::class);
        $trajetoService->shouldReceive('salvarPorLocal')->once()->with('123', 14, Mockery::type('array'), 8);
        $this->app->instance(TrajetoLocalVotacaoService::class, $trajetoService);
        $recursoService = Mockery::mock(RecursoLogisticoLocalService::class);
        $recursoService->shouldReceive('salvarPorLocal')->once()->with('123', 14, [
            [
                'recurso_opcao_id' => 3,
                'quantidade' => 1,
                'peso_total_kg' => 3.75,
            ],
        ]);
        $this->app->instance(RecursoLogisticoLocalService::class, $recursoService);

        $transmissoes = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissoes->shouldReceive('sincronizar')->once()->with('123', ['lt:10']);

        $controller = new LocalDificilAcessoController(
            $repository,
            $transmissoes,
            Mockery::mock(EquipeRepositoryInterface::class),
        );
        $response = $controller->update($request, 8);

        $this->assertSame(302, $response->getStatusCode());
    }
}
```
</TESTS_UNIT_LOCALDIFICILACESSOCONTROLLEREQUIPEPERSISTENCIATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalDificilAcessoControllerListagemEquipeTest.php`
## <TESTS_UNIT_LOCALDIFICILACESSOCONTROLLERLISTAGEMEQUIPETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalDificilAcessoControllerListagemEquipeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalDificilAcessoControllerListagemEquipeTest extends TestCase`

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
public function test_view_carrega_locais_paginados_e_contagem_de_mesarios_na_pagina_atual(): void
public function test_view_encaminha_filtros_para_consulta_paginada_do_repositorio(): void
public function test_exportar_gera_excel_com_filtros_da_consulta(): void
public function test_mesarios_retorna_html_sob_demanda_para_um_lda(): void
public function test_recursos_retorna_html_sob_demanda_para_um_lda(): void
public function test_mesarios_sem_secao_permanecem_visiveis_no_endpoint_sob_demanda(): void
private function criarPaginator(array $itens, int $total, int $perPage = 10, int $currentPage = 1): LengthAwarePaginator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Exports\Lda\LdaLocaisDificilAcessoExport;
use App\Http\Controllers\Lda\LocalDificilAcessoController;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\Lda\KitVinculoRepository;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Services\Lda\KitVinculoService;
use App\Services\Lda\TransmissaoPreferenciaService;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Maatwebsite\Excel\Facades\Excel;
use Mockery;
use Tests\TestCase;

class LocalDificilAcessoControllerListagemEquipeTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        $kits = Mockery::mock(KitVinculoRepository::class)->shouldIgnoreMissing();
        $kits->shouldReceive('mapearPorCodigos')->byDefault()->andReturn([]);
        $this->app->instance(KitVinculoRepository::class, $kits);
    }

    protected function tearDown(): void
    {
        @restore_error_handler();
        @restore_exception_handler();
        Mockery::close();
        parent::tearDown();
    }

    public function test_view_carrega_locais_paginados_e_contagem_de_mesarios_na_pagina_atual(): void
    {
        session(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0], 'macroprojeto_ativo_id' => 14]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarZonas')->once()->andReturn(collect([
            (object) ['NUM_ZONA' => 2, 'DESCRICAO' => 'ZONA 2'],
        ]));
        $repository->shouldReceive('listarInternets')->once()->andReturn(collect([
            (object) ['ID' => 3, 'DESCRICAO' => 'SATELITAL'],
        ]));
        $repository->shouldReceive('listarMunicipios')->once()->with(null, [0], true)->andReturn(collect([
            (object) ['cod_objeto_localidade' => '16', 'nom_localidade' => 'RIO BRANCO'],
        ]));
        $repository->shouldReceive('listarPaginadoParaTabela')->once()->with(
            null,
            null,
            null,
            null,
            14,
            null,
            null,
            null,
            [0],
            true,
            10
        )->andReturn($this->criarPaginator([
            [
                'id' => 8,
                'nome_local' => 'LDA TESTE',
                'comunidade' => 'COMUNIDADE A',
                'endereco' => 'RAMAL 1',
                'telefone' => '68999999999',
                'internet_id' => 3,
                'internet' => 'SATELITAL',
                'num_zona' => 2,
                'localidade' => 'RIO BRANCO',
                'acesso' => 'BARCO',
                'energia' => 'GERADOR',
                'cod_objeto_local_votacao' => '123',
            ],
        ], 1, 10, 1));
        $repository->shouldReceive('contarMesariosConvocadosPorCodigosLocais')->once()->with(['123'])->andReturn(['123' => 7]);
        $repository->shouldReceive('contarAtivosGlpiPorLdaIds')->once()->with([8], 14)->andReturn([8 => 2]);
        $repository->shouldReceive('contarTotalTabelaPorZona')->once()->with(null, null, [0], true)->andReturn(1);
        $repository->shouldReceive('contarSecoesVinculadasTabelaPorZona')->once()->with(null, null, [0], true)->andReturn(4);
        $repository->shouldReceive('contarBgan')->once()->with(0, null)->andReturn([(object) ['total' => 1]]);
        $repository->shouldReceive('contarBganPorZona')->once()->with(null)->andReturn([(object) ['descricao' => 'ZONA 2', 'total' => 1]]);
        $repository->shouldReceive('resumirLdaPorZonaTabela')->once()->with(null, null, [0], true)->andReturn([(object) ['descricao' => 2, 'total' => 1]]);
        $repository->shouldReceive('resumirLdaPorMunicipioTabela')->once()->with(null, null, [0], true)->andReturn([(object) ['descricao' => 'RIO BRANCO', 'total' => 1]]);
        $repository->shouldReceive('contarInternetPorZona')->once()->with(0, null)->andReturn([(object) ['descricao' => 'SATELITAL', 'total' => 1]]);
        $repository->shouldReceive('resumoEnergia')->once()->with(0, null)->andReturn([(object) ['descricao' => 'GERADOR', 'total' => 1]]);
        $repository->shouldReceive('resumoTransporte')->once()->with(0, null)->andReturn([(object) ['descricao' => 'BARCO', 'total' => 1]]);
        $repository->shouldNotReceive('listarPorZona');
        $repository->shouldNotReceive('listarMesariosConvocadosPorCodigosLocais');

        $kits = Mockery::mock(KitVinculoRepository::class);
        $kits->shouldReceive('mapearPorCodigos')->once()->with(['123'])->andReturn(['123' => [55]]);
        $kitService = Mockery::mock(KitVinculoService::class);
        $kitService->shouldReceive('certificadosPorIds')->once()->with([55])->andReturn([55 => 'CERT-55']);

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            kitVinculoRepository: $kits,
            kitVinculoService: $kitService,
        );

        $response = $controller->view(Request::create('/lda/locais-dificil-acesso', 'GET', ['page' => '1']));

        $this->assertSame('lda.locais_dificil_acesso', $response->name());
        /** @var LengthAwarePaginator $locais */
        $locais = $response->getData()['locais'];
        $this->assertInstanceOf(LengthAwarePaginator::class, $locais);
        $this->assertSame(1, $locais->total());
        $item = $locais->items()[0];
        $this->assertSame('LDA TESTE', $item['nome_local']);
        $this->assertSame(7, $item['qtd_mesarios_convocados']);
        $this->assertSame(2, $item['qtd_recursos_glpi']);
        $this->assertSame(['CERT-55'], $item['kits_jec_certificados']);
        $this->assertArrayNotHasKey('equipe', $item);
        $this->assertArrayNotHasKey('equipe_html', $item);
        $this->assertSame('', $response->getData()['filtros']['zona']);
        $this->assertSame('', $response->getData()['filtros']['municipio']);
        $this->assertSame('', $response->getData()['filtros']['busca']);
        $this->assertSame('', $response->getData()['filtros']['internet']);
        $this->assertSame('', $response->getData()['filtros']['recursos_escopo']);
        $this->assertSame('', $response->getData()['filtros']['recursos_operador']);
        $this->assertSame('', $response->getData()['filtros']['recursos_valor']);
        $this->assertSame(1, $response->getData()['painel']['total_locais']);
        $this->assertSame(4, $response->getData()['painel']['total_secoes_vinculadas']);
        $this->assertSame(1, $response->getData()['painel']['bgan_total']);
        $this->assertSame([['descricao' => '2', 'total' => 1]], $response->getData()['painel']['lda_por_zona']);
        $this->assertSame([['descricao' => 'RIO BRANCO', 'total' => 1]], $response->getData()['painel']['lda_por_municipio']);
    }

    public function test_view_encaminha_filtros_para_consulta_paginada_do_repositorio(): void
    {
        session(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0], 'macroprojeto_ativo_id' => 14]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarZonas')->once()->andReturn(collect([
            (object) ['NUM_ZONA' => 4, 'DESCRICAO' => 'ZONA 4'],
        ]));
        $repository->shouldReceive('listarInternets')->once()->andReturn(collect([
            (object) ['ID' => 3, 'DESCRICAO' => 'SATELITAL'],
        ]));
        $repository->shouldReceive('listarMunicipios')->once()->with('4', [0], true)->andReturn(collect([
            (object) ['cod_objeto_localidade' => '16', 'nom_localidade' => 'MANOEL URBANO'],
        ]));
        $repository->shouldReceive('listarPaginadoParaTabela')->once()->with(
            4,
            '16',
            'buacu',
            3,
            14,
            'recursos_glpi',
            'maior',
            2,
            [0],
            true,
            10
        )->andReturn($this->criarPaginator([
            [
                'id' => 8,
                'nome_local' => 'POSTO BUAÇU',
                'comunidade' => 'ALDEIA',
                'endereco' => 'RIO',
                'internet_id' => 3,
                'internet' => 'SATELITAL',
                'num_zona' => 4,
                'localidade' => 'MANOEL URBANO',
                'acesso' => 'HELICÓPTERO',
                'energia' => 'GERADOR',
                'cod_objeto_local_votacao' => '123',
            ],
        ], 1, 10, 1));
        $repository->shouldReceive('contarMesariosConvocadosPorCodigosLocais')->once()->with(['123'])->andReturn(['123' => 3]);
        $repository->shouldReceive('contarAtivosGlpiPorLdaIds')->once()->with([8], 14)->andReturn([8 => 1]);
        $repository->shouldReceive('contarTotalTabelaPorZona')->once()->with(4, '16', [0], true)->andReturn(2);
        $repository->shouldReceive('contarSecoesVinculadasTabelaPorZona')->once()->with(4, '16', [0], true)->andReturn(9);
        $repository->shouldReceive('contarBgan')->once()->with(4, '16')->andReturn([(object) ['total' => 2]]);
        $repository->shouldReceive('contarBganPorZona')->once()->with('16')->andReturn([(object) ['descricao' => 'ZONA 4', 'total' => 2]]);
        $repository->shouldReceive('resumirLdaPorZonaTabela')->once()->with(4, '16', [0], true)->andReturn([(object) ['descricao' => 4, 'total' => 2]]);
        $repository->shouldReceive('resumirLdaPorMunicipioTabela')->once()->with(4, '16', [0], true)->andReturn([(object) ['descricao' => 'MANOEL URBANO', 'total' => 2]]);
        $repository->shouldReceive('contarInternetPorZona')->once()->with(4, '16')->andReturn([(object) ['descricao' => 'SATELITAL', 'total' => 2]]);
        $repository->shouldReceive('resumoEnergia')->once()->with(4, '16')->andReturn([(object) ['descricao' => 'GERADOR', 'total' => 2]]);
        $repository->shouldReceive('resumoTransporte')->once()->with(4, '16')->andReturn([(object) ['descricao' => 'HELICÓPTERO', 'total' => 2]]);
        $repository->shouldNotReceive('listarPorZona');

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->view(Request::create('/lda/locais-dificil-acesso', 'GET', [
            'zona' => '4',
            'municipio' => '16',
            'busca' => 'buacu',
            'internet' => '3',
            'recursos_escopo' => 'recursos_glpi',
            'recursos_operador' => 'maior',
            'recursos_valor' => '2',
        ]));

        $this->assertSame('lda.locais_dificil_acesso', $response->name());
        /** @var LengthAwarePaginator $locais */
        $locais = $response->getData()['locais'];
        $this->assertInstanceOf(LengthAwarePaginator::class, $locais);
        $this->assertSame(1, $locais->count());
        $this->assertSame(8, $locais->items()[0]['id']);
        $this->assertSame(3, $locais->items()[0]['qtd_mesarios_convocados']);
        $this->assertSame(1, $locais->items()[0]['qtd_recursos_glpi']);
        $this->assertSame('4', $response->getData()['filtros']['zona']);
        $this->assertSame('16', $response->getData()['filtros']['municipio']);
        $this->assertSame('buacu', $response->getData()['filtros']['busca']);
        $this->assertSame('3', $response->getData()['filtros']['internet']);
        $this->assertSame('recursos_glpi', $response->getData()['filtros']['recursos_escopo']);
        $this->assertSame('maior', $response->getData()['filtros']['recursos_operador']);
        $this->assertSame('2', $response->getData()['filtros']['recursos_valor']);
        $this->assertSame(2, $response->getData()['painel']['total_locais']);
        $this->assertSame(9, $response->getData()['painel']['total_secoes_vinculadas']);
        $this->assertSame(2, $response->getData()['painel']['bgan_total']);
        $this->assertSame([['descricao' => '4', 'total' => 2]], $response->getData()['painel']['lda_por_zona']);
        $this->assertSame([['descricao' => 'MANOEL URBANO', 'total' => 2]], $response->getData()['painel']['lda_por_municipio']);
    }

    public function test_exportar_gera_excel_com_filtros_da_consulta(): void
    {
        session(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0], 'macroprojeto_ativo_id' => 14]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarParaExportacaoTabela')->once()->with(
            4,
            '16',
            'buacu',
            3,
            14,
            'recursos_glpi',
            'igual',
            1,
            [0],
            true
        )->andReturn([
            [
                'nome_local' => 'POSTO BUAÇU',
                'comunidade' => 'ALDEIA',
                'localidade' => 'MANOEL URBANO',
                'num_zona' => 4,
                'endereco' => 'RIO',
                'internet' => 'SATELITAL',
                'acesso' => 'HELICÓPTERO',
                'energia' => 'GERADOR',
                'secoes' => '001, 002',
                'telefone' => '68999999999',
                'aparelho_satelite' => 'SIM',
            ],
        ]);

        Excel::shouldReceive('download')
            ->once()
            ->withArgs(function ($export, $filename) {
                if (! $export instanceof LdaLocaisDificilAcessoExport) {
                    return false;
                }

                return str_starts_with($filename, 'lda_locais_dificil_acesso_')
                    && str_ends_with($filename, '.xlsx')
                    && $export->array() === [
                        ['Local', 'Comunidade', 'Municipio', 'Zona', 'Endereco', 'Internet', 'Acesso', 'Energia', 'Secoes', 'Telefone', 'Aparelho Satelite'],
                        ['POSTO BUAÇU', 'ALDEIA', 'MANOEL URBANO', '4', 'RIO', 'SATELITAL', 'HELICÓPTERO', 'GERADOR', '001, 002', '68999999999', 'SIM'],
                    ];
            })
            ->andReturn('xlsx-response');

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->exportar(Request::create('/lda/locais-dificil-acesso/exportar', 'GET', [
            'zona' => '4',
            'municipio' => '16',
            'busca' => 'buacu',
            'internet' => '3',
            'recursos_escopo' => 'recursos_glpi',
            'recursos_operador' => 'igual',
            'recursos_valor' => '1',
        ]));

        $this->assertSame('xlsx-response', $response);
    }

    public function test_mesarios_retorna_html_sob_demanda_para_um_lda(): void
    {
        session(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0]]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('buscarDetalhes')->once()->with(8)->andReturn([
            'id' => 8,
            'num_zona' => 2,
            'cod_objeto_local_votacao' => '123',
        ]);
        $repository->shouldReceive('listarMesariosConvocadosPorCodigoLocal')->once()->with('123', [0], true)->andReturn([
            [
                'nom_eleitor' => 'FULANO',
                'cargo_nome' => 'PRESIDENTE',
                'num_inscricao' => '0001',
                'num_cpf' => '123',
                'num_secao' => '37',
                'situacao' => 'CONVOCADO',
                'telefone' => '68999990000',
            ],
        ]);
        $repository->shouldReceive('listarSecoesDoLocal')->once()->with('123', [0], true)->andReturn([
            ['num_secao' => '037', 'qtd_aptos' => 120],
            ['num_secao' => '038', 'qtd_aptos' => 98],
        ]);

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->mesarios(8);

        $this->assertSame(200, $response->getStatusCode());
        $payload = $response->getData(true);
        $this->assertSame(1, $payload['total']);
        $this->assertStringContainsString('FULANO', $payload['html']);
        $this->assertStringContainsString('PRESIDENTE', $payload['html']);
        $this->assertStringContainsString('037', $payload['html']);
        $this->assertStringContainsString('038', $payload['html']);
        $this->assertStringContainsString('Nenhum mesário alocado para esta seção.', $payload['html']);
    }

    public function test_recursos_retorna_html_sob_demanda_para_um_lda(): void
    {
        session(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0], 'macroprojeto_ativo_id' => 14]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('buscarDetalhes')->once()->with(8)->andReturn([
            'id' => 8,
            'num_zona' => 2,
            'cod_objeto_local_votacao' => '123',
        ]);
        $repository->shouldReceive('buscarAtivosGlpi')->once()->with(8, 14)->andReturn([
            [
                'glpi_item_id' => 2017,
                'glpi_itemtype' => 'Computer',
                'nome' => 'RACE013230',
                'serial' => 'PE08XDP3',
                'otherserial' => 'PAT001',
                'status' => 'OPERACIONAL',
                'entidade_nome' => 'TRE-AC',
            ],
        ]);

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->recursos(8);

        $this->assertSame(200, $response->getStatusCode());
        $payload = $response->getData(true);
        $this->assertSame(1, $payload['total']);
        $this->assertStringContainsString('RACE013230', $payload['html']);
        $this->assertStringContainsString('PAT001', $payload['html']);
        $this->assertStringContainsString('OPERACIONAL', $payload['html']);
    }

    public function test_mesarios_sem_secao_permanecem_visiveis_no_endpoint_sob_demanda(): void
    {
        session(['acesso_todas_zonas' => true, 'cod_zonas_permitidas' => [0]]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('buscarDetalhes')->once()->with(9)->andReturn([
            'id' => 9,
            'num_zona' => 2,
            'cod_objeto_local_votacao' => '456',
        ]);
        $repository->shouldReceive('listarMesariosConvocadosPorCodigoLocal')->once()->with('456', [0], true)->andReturn([
            [
                'nom_eleitor' => 'VILANI DE LIMA FERREIRA',
                'cargo_nome' => 'ADMINISTRADOR DE PRÉDIO',
                'num_inscricao' => '002496512488',
                'num_cpf' => '72726580297',
                'num_secao' => '',
                'situacao' => 'CONVOCADO',
                'telefone' => '5568999348865',
            ],
        ]);
        $repository->shouldReceive('listarSecoesDoLocal')->once()->with('456', [0], true)->andReturn([]);

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
        );

        $response = $controller->mesarios(9);

        $this->assertSame(200, $response->getStatusCode());
        $payload = $response->getData(true);
        $this->assertSame(1, $payload['total']);
        $this->assertStringContainsString('VILANI DE LIMA FERREIRA', $payload['html']);
        $this->assertStringContainsString('>—<', $payload['html']);
    }

    private function criarPaginator(array $itens, int $total, int $perPage = 10, int $currentPage = 1): LengthAwarePaginator
    {
        return new LengthAwarePaginator(
            collect($itens),
            $total,
            $perPage,
            $currentPage,
            [
                'path' => '/lda/locais-dificil-acesso',
                'query' => ['zona' => '0'],
            ]
        );
    }
}
```
</TESTS_UNIT_LOCALDIFICILACESSOCONTROLLERLISTAGEMEQUIPETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalDificilAcessoMapaKitOnlineControllerTest.php`
## <TESTS_UNIT_LOCALDIFICILACESSOMAPAKITONLINECONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalDificilAcessoMapaKitOnlineControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalDificilAcessoMapaKitOnlineControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function mapa_consulta_status_somente_para_ldas_no_escopo_e_nao_expoe_ids(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\LocalDificilAcessoController;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Services\Lda\LdaMapaKitOnlineService;
use App\Services\Lda\TransmissaoPreferenciaService;
use Illuminate\Http\Request;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalDificilAcessoMapaKitOnlineControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();

        parent::tearDown();
    }

    #[Test]
    public function mapa_consulta_status_somente_para_ldas_no_escopo_e_nao_expoe_ids(): void
    {
        session([
            'acesso_todas_zonas' => false,
            'cod_zonas_permitidas' => [2],
        ]);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarPorZona')->once()->with(2)->andReturn([
            (object) [
                'id' => 1,
                'num_zona' => 2,
                'nome_local' => 'LDA AUTORIZADO',
                'cod_objeto_local_votacao' => 'LV-2',
                'latitude' => -9.9,
                'longitude' => -67.8,
            ],
            (object) [
                'id' => 2,
                'num_zona' => 3,
                'nome_local' => 'LDA FORA DO ESCOPO',
                'cod_objeto_local_votacao' => 'LV-3',
                'latitude' => -8.9,
                'longitude' => -68.8,
            ],
        ]);

        $kitsOnline = Mockery::mock(LdaMapaKitOnlineService::class);
        $kitsOnline->shouldReceive('statusPorCodigos')
            ->once()
            ->with(['LV-2'])
            ->andReturn([
                'LV-2' => [
                    'estado' => 'online',
                    'total_vinculados' => 2,
                    'total_online' => 1,
                    'certificados_online' => ['CERT-ONLINE'],
                ],
            ]);

        $controller = new LocalDificilAcessoController(
            $repository,
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            ldaMapaKitOnlineService: $kitsOnline,
        );

        $response = $controller->mapaDados(Request::create('/lda/mapa/dados', 'GET'));
        $dados = $response->getData(true);

        $this->assertCount(1, $dados);
        $this->assertSame('LDA AUTORIZADO', $dados[0]['nome_local']);
        $this->assertSame([
            'estado' => 'online',
            'total_vinculados' => 2,
            'total_online' => 1,
            'certificados_online' => ['CERT-ONLINE'],
        ], $dados[0]['kits_jec']);
        $json = $response->getContent();
        $this->assertIsString($json);
        $this->assertStringNotContainsString('LV-3', $json);
        $this->assertStringNotContainsString('kit_id', $json);
        $this->assertStringNotContainsString('kits_jec_ids', $json);
    }
}
```
</TESTS_UNIT_LOCALDIFICILACESSOMAPAKITONLINECONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalDificilAcessoSincronizacaoRepositoryTest.php`
## <TESTS_UNIT_LOCALDIFICILACESSOSINCRONIZACAOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalDificilAcessoSincronizacaoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalDificilAcessoSincronizacaoRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function consultas_de_divergencia_usam_tabela_base_e_comparacao_nula_compativel_com_oracle(): void
public function valor_oficial_vazio_nao_e_persistido(): void
public function operacao_composta_propaga_falha_e_nao_executa_verificacao_fora_da_transacao(): void
public function divergencia_remanescente_faz_a_transacao_falhar(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class LocalDificilAcessoSincronizacaoRepositoryTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function consultas_de_divergencia_usam_tabela_base_e_comparacao_nula_compativel_com_oracle(): void
    {
        DB::shouldReceive('select')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool =>
                str_contains($sql, 'planeleito.local_votacao_st')
                && !str_contains($sql, 'planeleito.vw_locais_votacao_efetivos')
                && str_contains($sql, 'l.nome_local')
                && str_contains($sql, 'TRIM(lv.nom_local) IS NOT NULL')
                && str_contains($sql, 'NVL(TRIM(l.nome_local), CHR(0)) <> NVL(TRIM(lv.nom_local), CHR(0))')
                && !str_contains($sql, "<> ''")
            ))
            ->andReturn([]);
        DB::shouldReceive('select')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool =>
                str_contains($sql, 'planeleito.local_votacao_st')
                && !str_contains($sql, 'planeleito.vw_locais_votacao_efetivos')
                && str_contains($sql, 'l.endereco')
                && str_contains($sql, 'TRIM(lv.des_endereco) IS NOT NULL')
                && str_contains($sql, 'NVL(TRIM(l.endereco), CHR(0)) <> NVL(TRIM(lv.des_endereco), CHR(0))')
                && !str_contains($sql, "<> ''")
            ))
            ->andReturn([]);

        $repository = new LocalDificilAcessoRepository(Mockery::mock(AuditLogService::class));

        $this->assertSame([], $repository->listarDivergenciasNomeLocalVotacao());
        $this->assertSame([], $repository->listarDivergenciasEnderecoLocalVotacao());
    }

    #[Test]
    public function valor_oficial_vazio_nao_e_persistido(): void
    {
        DB::shouldReceive('select')->once()->andReturn([(object) [
            'id' => 57,
            'nome_oficial' => '   ',
        ]]);
        DB::shouldReceive('transaction')
            ->once()
            ->andReturnUsing(static fn (callable $executar): mixed => $executar());

        $repository = Mockery::mock(LocalDificilAcessoRepository::class, [
            Mockery::mock(AuditLogService::class),
        ])->makePartial()->shouldAllowMockingProtectedMethods();
        $repository->shouldNotReceive('atualizarAuditadoPorId');

        $this->assertSame(0, $repository->sincronizarNomesLocalVotacao());
    }

    #[Test]
    public function operacao_composta_propaga_falha_e_nao_executa_verificacao_fora_da_transacao(): void
    {
        DB::shouldReceive('transaction')
            ->once()
            ->andReturnUsing(static fn (callable $executar): mixed => $executar());

        $repository = Mockery::mock(LocalDificilAcessoRepository::class)->makePartial();
        $repository->shouldReceive('sincronizarNomesLocalVotacao')->once()->andReturn(1);
        $repository->shouldReceive('sincronizarEnderecosLocalVotacao')
            ->once()
            ->andThrow(new RuntimeException('falha auditada'));
        $repository->shouldNotReceive('listarDivergenciasNomeLocalVotacao');
        $repository->shouldNotReceive('listarDivergenciasEnderecoLocalVotacao');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('falha auditada');

        $repository->sincronizarDadosLocalVotacao();
    }

    #[Test]
    public function divergencia_remanescente_faz_a_transacao_falhar(): void
    {
        DB::shouldReceive('transaction')
            ->once()
            ->andReturnUsing(static fn (callable $executar): mixed => $executar());

        $repository = Mockery::mock(LocalDificilAcessoRepository::class)->makePartial();
        $repository->shouldReceive('sincronizarNomesLocalVotacao')->once()->andReturn(1);
        $repository->shouldReceive('sincronizarEnderecosLocalVotacao')->once()->andReturn(0);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([['id' => 57]]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('1 nome(s) e 0 endereco(s) divergente(s)');

        $repository->sincronizarDadosLocalVotacao();
    }
}
```
</TESTS_UNIT_LOCALDIFICILACESSOSINCRONIZACAOREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalTransmissaoConsolidadoAclMigrationTest.php`
## <TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalTransmissaoConsolidadoAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalTransmissaoConsolidadoAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
Schema::create('adm_acesso_rota', function (Blueprint $table): void {
Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
DB::table('adm_grupo_acesso')->insert(['id' => $indice + 1, 'nome' => $grupo, 'ativo' => 1]);
$rota = DB::table('adm_acesso_rota')->where('rota_nome', self::ROTA)->first();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function cadastra_pdf_e_dois_vinculos_nominais_exatos_de_forma_idempotente(): void
public function down_desativa_somente_a_rota_e_seus_vinculos(): void
private function migration(): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalTransmissaoConsolidadoAclMigrationTest extends TestCase
{
    private const ROTA = 'lda.local-transmissao.exportar-pdf';
    private const GRUPOS = ['PLANELEITO_TRANSMISSAO', 'PLANELEITO_TRANSMISSAO_ADMIN'];

    protected function setUp(): void
    {
        parent::setUp();
        Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
            $table->id();
            $table->string('nome');
            $table->boolean('ativo')->default(true);
        });
        Schema::create('adm_acesso_rota', function (Blueprint $table): void {
            $table->id();
            $table->string('rota_nome');
            $table->string('rota_path')->nullable();
            $table->string('menu_path')->nullable();
            $table->string('descricao')->nullable();
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });
        Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('acesso_rota_id');
            $table->unsignedBigInteger('grupo_acesso_id');
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });

        foreach ([...self::GRUPOS, 'GRUPO_NAO_AUTORIZADO'] as $indice => $grupo) {
            DB::table('adm_grupo_acesso')->insert(['id' => $indice + 1, 'nome' => $grupo, 'ativo' => 1]);
        }
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('adm_acesso_rota_grupo');
        Schema::dropIfExists('adm_acesso_rota');
        Schema::dropIfExists('adm_grupo_acesso');
        parent::tearDown();
    }

    #[Test]
    public function cadastra_pdf_e_dois_vinculos_nominais_exatos_de_forma_idempotente(): void
    {
        $migration = $this->migration();
        $migration->up();
        $migration->up();

        $rota = DB::table('adm_acesso_rota')->where('rota_nome', self::ROTA)->first();
        $this->assertNotNull($rota);
        $this->assertSame('lda/local-transmissao/exportar-pdf', $rota->rota_path);
        $this->assertSame(1, (int) $rota->ativo);
        $this->assertSame(1, DB::table('adm_acesso_rota')->where('rota_nome', self::ROTA)->count());

        $grupos = DB::table('adm_acesso_rota_grupo as arg')
            ->join('adm_grupo_acesso as aga', 'aga.id', '=', 'arg.grupo_acesso_id')
            ->where('arg.acesso_rota_id', $rota->id)
            ->where('arg.ativo', 1)
            ->orderBy('aga.nome')
            ->pluck('aga.nome')->all();
        $esperados = self::GRUPOS;
        sort($esperados);
        $this->assertSame($esperados, $grupos);
        $this->assertSame(2, DB::table('adm_acesso_rota_grupo')->where('acesso_rota_id', $rota->id)->count());
    }

    #[Test]
    public function down_desativa_somente_a_rota_e_seus_vinculos(): void
    {
        $migration = $this->migration();
        $migration->up();
        $rotaId = (int) DB::table('adm_acesso_rota')->where('rota_nome', self::ROTA)->value('id');

        $migration->down();

        $this->assertSame(0, (int) DB::table('adm_acesso_rota')->where('id', $rotaId)->value('ativo'));
        $this->assertSame(0, DB::table('adm_acesso_rota_grupo')
            ->where('acesso_rota_id', $rotaId)->where('ativo', 1)->count());
    }

    private function migration(): object
    {
        return require database_path('migrations/2026_08_26_120000_grant_local_transmissao_consolidado_acl.php');
    }
}
```
</TESTS_UNIT_LOCALTRANSMISSAOCONSOLIDADOACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoExportarXlsxAclMigrationTest.php`
## <TESTS_UNIT_LOCALVOTACAOEXPORTARXLSXACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoExportarXlsxAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoExportarXlsxAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rota_xlsx_existe_e_migration_replica_grupos_ativos_da_listagem(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$this->assertStringContainsString("Route::get('/exportar-xlsx'", $rotas);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalVotacaoExportarXlsxAclMigrationTest extends TestCase
{
    #[Test]
    public function rota_xlsx_existe_e_migration_replica_grupos_ativos_da_listagem(): void
    {
        $rotas = file_get_contents(base_path('routes/web.php'));
        $migration = database_path('migrations/2026_09_06_120000_grant_lda_locais_votacao_exportar_xlsx_acl.php');

        $this->assertIsString($rotas);
        $this->assertStringContainsString("Route::get('/exportar-xlsx'", $rotas);
        $this->assertStringContainsString("->name('exportar-xlsx')", $rotas);
        $this->assertFileExists($migration);

        $conteudo = file_get_contents($migration);
        $this->assertIsString($conteudo);
        $this->assertStringContainsString("SOURCE_ROUTE_NAME = 'lda.locais-votacao.index'", $conteudo);
        $this->assertStringContainsString("ROUTE_NAME = 'lda.locais-votacao.exportar-xlsx'", $conteudo);
        $this->assertStringContainsString("ROUTE_PATH = 'lda/locais-votacao/exportar-xlsx'", $conteudo);
        $this->assertStringContainsString("where('ar_origem.ativo', 1)", $conteudo);
        $this->assertStringContainsString("where('arg_origem.ativo', 1)", $conteudo);
        $this->assertStringContainsString("where('ag_origem.ativo', 1)", $conteudo);
    }
}
```
</TESTS_UNIT_LOCALVOTACAOEXPORTARXLSXACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatAclOcorrenciasPorRotaDadosMigrationTest.php`
## <TESTS_UNIT_NATACLOCORRENCIASPORROTADADOSMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatAclOcorrenciasPorRotaDadosMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatAclOcorrenciasPorRotaDadosMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_vincula_rota_de_dados_ao_grupo_nat_admin(): void
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

class NatAclOcorrenciasPorRotaDadosMigrationTest extends TestCase
{
    #[Test]
    public function migration_vincula_rota_de_dados_ao_grupo_nat_admin(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_06_03_090000_grant_nat_ocorrencias_por_rota_dados_to_nat_admin_group.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("private const GRUPO_NOME = 'PLANELEITO_NAT_ADMIN';", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'nat.ocorrencias-por-rota.dados'", $conteudo);
        $this->assertStringContainsString("'rota_path' => 'nat/ocorrencias-por-rota/dados'", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Dia-E > NAT > Ocorrências por Rota'", $conteudo);
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
    }
}
```
</TESTS_UNIT_NATACLOCORRENCIASPORROTADADOSMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatAclOcorrenciasPorRotaMigrationTest.php`
## <TESTS_UNIT_NATACLOCORRENCIASPORROTAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatAclOcorrenciasPorRotaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatAclOcorrenciasPorRotaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_vincula_rota_de_ocorrencias_por_rota_ao_grupo_nat_admin(): void
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

class NatAclOcorrenciasPorRotaMigrationTest extends TestCase
{
    #[Test]
    public function migration_vincula_rota_de_ocorrencias_por_rota_ao_grupo_nat_admin(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_06_02_210000_grant_nat_ocorrencias_por_rota_to_nat_admin_group.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("private const GRUPO_NOME = 'PLANELEITO_NAT_ADMIN';", $conteudo);
        $this->assertStringContainsString("'rota_nome' => 'nat.ocorrencias-por-rota.index'", $conteudo);
        $this->assertStringContainsString("'rota_path' => 'nat/ocorrencias-por-rota'", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Dia-E > NAT > Ocorrências por Rota'", $conteudo);
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
    }
}
```
</TESTS_UNIT_NATACLOCORRENCIASPORROTAMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatExternoAuthServiceTest.php`
## <TESTS_UNIT_NATEXTERNOAUTHSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatExternoAuthServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatExternoAuthServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_validacao_com_codigo_invalido_incrementa_tentativas_sem_bloquear_desafio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Nat\NatExternoRepository;
use App\Services\Nat\NatExternoAuthService;
use App\Services\Nat\NatExternoSessionService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Mockery;
use Tests\TestCase;
use RuntimeException;

class NatExternoAuthServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_validacao_com_codigo_invalido_incrementa_tentativas_sem_bloquear_desafio(): void
    {
        $request = Request::create('/rotas-publicas/nat/validar', 'POST');

        $repository = Mockery::mock(NatExternoRepository::class);
        $repository->shouldReceive('buscarConfiguracaoAtiva')
            ->once()
            ->andReturn(['macroprojeto_id' => 7]);
        $repository->shouldReceive('buscarIntegrantePorEmail')
            ->once()
            ->with('integrante@example.com')
            ->andReturn([
                'email' => 'integrante@example.com',
                'integrante_referencia' => '123456',
                'rotas' => [['id' => 10, 'numero' => 902]],
                'rotas_ids' => [10],
                'zonas' => [4],
            ]);
        $repository->shouldReceive('buscarDesafioValidoPorEmail')
            ->once()
            ->with('integrante@example.com')
            ->andReturn((object) [
                'id' => 15,
                'codigo_hash' => Hash::make('654321'),
            ]);
        $repository->shouldReceive('incrementarTentativas')
            ->once()
            ->with(15)
            ->andReturn(5);
        $repository->shouldReceive('registrarEvento')
            ->once()
            ->with(Mockery::on(static function (array $dados): bool {
                return ($dados['tipo_evento'] ?? null) === 'LOGIN_FALHA'
                    && ($dados['email'] ?? null) === 'integrante@example.com'
                    && str_contains((string) ($dados['payload_json'] ?? ''), 'CODIGO_INVALIDO')
                    && str_contains((string) ($dados['payload_json'] ?? ''), '"tentativas":5');
            }));

        $sessionService = Mockery::mock(NatExternoSessionService::class);

        $service = new NatExternoAuthService($repository, $sessionService);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Codigo invalido ou expirado.');

        $service->validarCodigo('integrante@example.com', '123456', $request);
    }
}
```
</TESTS_UNIT_NATEXTERNOAUTHSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaDashboardAclMigrationTest.php`
## <TESTS_UNIT_NATVISTORIADASHBOARDACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaDashboardAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `final class NatVistoriaDashboardAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
Schema::create('adm_acesso_rota', function (Blueprint $table): void {
Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
DB::table('adm_grupo_acesso')->insert([
DB::table('adm_acesso_rota')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_migration_cadastra_duas_rotas_idempotentes_e_acl_efetiva_dos_grupos_nat(): void
public function test_down_desativa_somente_as_rotas_e_vinculos_do_dashboard(): void
private function migration(): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Acesso\AcessoRotaPermissaoService;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

final class NatVistoriaDashboardAclMigrationTest extends TestCase
{
    /** @var array<int, string> */
    private const ROTAS = [
        'nat.vistorias.dashboard.index',
        'nat.vistorias.dashboard.dados',
    ];

    /** @var array<int, string> */
    private const GRUPOS_NAT = [
        'PLANELEITO_NAT_ADMIN',
        'PLANELEITO_NAT_OPERADOR',
    ];

    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
            $table->id();
            $table->string('nome')->unique();
            $table->boolean('ativo')->default(true);
        });
        Schema::create('adm_acesso_rota', function (Blueprint $table): void {
            $table->id();
            $table->string('rota_nome')->unique();
            $table->string('rota_path')->nullable();
            $table->string('menu_path')->nullable();
            $table->string('descricao')->nullable();
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });
        Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('acesso_rota_id');
            $table->unsignedBigInteger('grupo_acesso_id');
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
            $table->unique(['acesso_rota_id', 'grupo_acesso_id']);
        });

        foreach ([...self::GRUPOS_NAT, 'PLANELEITO_ADMIN', 'SEM_ACESSO_NAT'] as $indice => $grupo) {
            DB::table('adm_grupo_acesso')->insert([
                'id' => $indice + 1,
                'nome' => $grupo,
                'ativo' => 1,
            ]);
        }

        DB::table('adm_acesso_rota')->insert([
            'id' => 90,
            'rota_nome' => '*',
            'ativo' => 1,
        ]);
        DB::table('adm_acesso_rota_grupo')->insert([
            'acesso_rota_id' => 90,
            'grupo_acesso_id' => 3,
            'ativo' => 1,
        ]);
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('adm_acesso_rota_grupo');
        Schema::dropIfExists('adm_acesso_rota');
        Schema::dropIfExists('adm_grupo_acesso');
        parent::tearDown();
    }

    public function test_migration_cadastra_duas_rotas_idempotentes_e_acl_efetiva_dos_grupos_nat(): void
    {
        $migration = $this->migration();
        $migration->up();
        $migration->up();

        $permissoes = app(AcessoRotaPermissaoService::class);
        foreach (self::ROTAS as $rotaNome) {
            $rota = DB::table('adm_acesso_rota')->where('rota_nome', $rotaNome)->first();
            $this->assertNotNull($rota);
            $this->assertSame(1, (int) $rota->ativo);
            $this->assertSame(1, DB::table('adm_acesso_rota')->where('rota_nome', $rotaNome)->count());

            $grupos = DB::table('adm_acesso_rota_grupo as arg')
                ->join('adm_grupo_acesso as aga', 'aga.id', '=', 'arg.grupo_acesso_id')
                ->where('arg.acesso_rota_id', $rota->id)
                ->where('arg.ativo', 1)
                ->orderBy('aga.nome')
                ->pluck('aga.nome')
                ->all();
            $esperados = self::GRUPOS_NAT;
            sort($esperados);
            $this->assertSame($esperados, $grupos);

            $this->assertTrue($permissoes->podeAcessarRota($rotaNome, ['PLANELEITO_NAT_ADMIN']));
            $this->assertTrue($permissoes->podeAcessarRota($rotaNome, ['PLANELEITO_NAT_OPERADOR']));
            $this->assertTrue($permissoes->podeAcessarRota($rotaNome, ['PLANELEITO_ADMIN']));
            $this->assertFalse($permissoes->podeAcessarRota($rotaNome, ['SEM_ACESSO_NAT']));
        }
    }

    public function test_down_desativa_somente_as_rotas_e_vinculos_do_dashboard(): void
    {
        $migration = $this->migration();
        $migration->up();
        $migration->down();

        $rotaIds = DB::table('adm_acesso_rota')->whereIn('rota_nome', self::ROTAS)->pluck('id')->all();
        $this->assertCount(2, $rotaIds);
        $this->assertSame(0, DB::table('adm_acesso_rota')->whereIn('id', $rotaIds)->where('ativo', 1)->count());
        $this->assertSame(0, DB::table('adm_acesso_rota_grupo')->whereIn('acesso_rota_id', $rotaIds)->where('ativo', 1)->count());
        $this->assertSame(1, (int) DB::table('adm_acesso_rota')->where('id', 90)->value('ativo'));
        $this->assertSame(1, (int) DB::table('adm_acesso_rota_grupo')->where('acesso_rota_id', 90)->value('ativo'));
    }

    private function migration(): object
    {
        return require database_path(
            'migrations/2026_08_31_120000_grant_nat_vistoria_urnas_dashboard_acl.php'
        );
    }
}
```
</TESTS_UNIT_NATVISTORIADASHBOARDACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaSecaoServiceTokenTest.php`
## <TESTS_UNIT_NATVISTORIASECAOSERVICETOKENTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaSecaoServiceTokenTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatVistoriaSecaoServiceTokenTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function listagem_gera_token_curto_e_formulario_reidrata_secao_do_escopo_atual(): void
private function secao(int $rotaId, string $local, string $secao, string $rotulo): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Nat\Contracts\NatVistoriaSecaoPerguntaRepositoryInterface;
use App\Repositories\Nat\Contracts\NatVistoriaSecaoRepositoryInterface;
use App\Repositories\Nat\NatExternoRepository;
use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use App\Repositories\TabelasAuxiliares\OpcaoBinariaRepository;
use App\Services\Nat\NatExternoSessionService;
use App\Services\Nat\NatVistoriaSecaoCatalogo;
use App\Services\Nat\NatVistoriaSecaoService;
use App\Services\Nat\NatVistoriaSecaoTokenService;
use Illuminate\Http\Request;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatVistoriaSecaoServiceTokenTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function listagem_gera_token_curto_e_formulario_reidrata_secao_do_escopo_atual(): void
    {
        $request = Request::create('/rotas-publicas/nat/painel', 'GET');
        $secaoEsperada = $this->secao(9, 'LOCAL-1', 'SECAO-2', 'Seção 002');
        $secaoOutra = $this->secao(9, 'LOCAL-1', 'SECAO-3', 'Seção 003');
        $secoes = [$secaoOutra, $secaoEsperada];
        $integrante = [
            'email' => 'integrante@example.com',
            'nome' => 'Integrante NAT',
            'integrante_referencia' => 'INT-1',
            'rotas_ids' => [9],
            'zonas' => [4],
        ];

        $repository = Mockery::mock(NatVistoriaSecaoRepositoryInterface::class);
        $perguntas = Mockery::mock(NatVistoriaSecaoPerguntaRepositoryInterface::class);
        $opcoes = Mockery::mock(OpcaoBinariaRepository::class);
        $turnos = Mockery::mock(MacroprojetoTurnoRepository::class);
        $externo = Mockery::mock(NatExternoRepository::class);
        $sessao = Mockery::mock(NatExternoSessionService::class);

        $sessao->shouldReceive('macroprojetoId')->twice()->with($request)->andReturn(41);
        $sessao->shouldReceive('zonas')->twice()->with($request)->andReturn([4]);
        $sessao->shouldReceive('email')->once()->with($request)->andReturn($integrante['email']);
        $sessao->shouldReceive('atualizarIdentidade')->once()->with($request, $integrante);
        $turnos->shouldReceive('buscarAtivoPorMacroprojeto')->twice()->with(41)->andReturn([
            'id' => 77,
            'macroprojeto_id' => 41,
            'ativo' => 1,
        ]);
        $externo->shouldReceive('buscarIntegrantePorEmail')->once()->with($integrante['email'])->andReturn($integrante);
        $repository->shouldReceive('listarTodos')->twice()->with([9], 77, [4], false)->andReturn($secoes);

        $catalogoPerguntas = [[
            'id' => 1,
            'codigo' => 'INSTALADA',
            'texto' => 'A urna está instalada?',
            'ordem' => 1,
        ]];
        $perguntas->shouldReceive('listarAtivas')->once()->andReturn($catalogoPerguntas);
        $opcoes->shouldReceive('ativasOrdenadas')->once()->andReturn([(object) [
            'codigo' => 'SIM',
            'descricao' => 'Sim',
        ]]);

        $service = new NatVistoriaSecaoService(
            $repository,
            $perguntas,
            $opcoes,
            new NatVistoriaSecaoCatalogo(),
            new NatVistoriaSecaoTokenService(),
            $turnos,
            $externo,
            $sessao,
        );

        $listagem = $service->listarExterno($request, [9]);
        $token = (string) $listagem[1]['token_vistoria'];

        $this->assertMatchesRegularExpression('/^[A-Za-z0-9_-]{43}$/', $token);
        $this->assertNotSame($listagem[0]['token_vistoria'], $token);

        $formulario = $service->prepararFormularioExterno($request, $token);

        $this->assertSame($secaoEsperada, $formulario['secao']);
        $this->assertSame($catalogoPerguntas, $formulario['perguntas']);
    }

    /** @return array<string,mixed> */
    private function secao(int $rotaId, string $local, string $secao, string $rotulo): array
    {
        return [
            'rota_id' => $rotaId,
            'rota_numero' => '1',
            'rota_descricao' => 'Rota UMS',
            'zona_id' => 4,
            'zona_numero' => '4',
            'municipio_id' => 1,
            'municipio_nome' => 'Rio Branco',
            'cod_objeto_local' => $local,
            'local_numero' => '10',
            'local_nome' => 'Escola Exemplo',
            'cod_objeto_secao' => $secao,
            'num_secao' => substr($rotulo, -3),
            'secao_rotulo' => $rotulo,
            'vistoria_id' => null,
            'dt_vistoria_fmt' => null,
            'autor_nome' => null,
            'autor_email' => null,
            'situacao' => 'NAO_VISTORIADA',
        ];
    }
}
```
</TESTS_UNIT_NATVISTORIASECAOSERVICETOKENTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaSecaoTokenServiceTest.php`
## <TESTS_UNIT_NATVISTORIASECAOTOKENSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaSecaoTokenServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatVistoriaSecaoTokenServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function token_opaco_e_curto_vincula_turno_rota_local_e_secao_e_rejeita_adulteracao(): void
public function gravacao_aceita_somente_token_curto_no_formato_base64url(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Nat\NatVistoriaSecaoStoreRequest;
use App\Services\Nat\NatVistoriaSecaoTokenService;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatVistoriaSecaoTokenServiceTest extends TestCase
{
    #[Test]
    public function token_opaco_e_curto_vincula_turno_rota_local_e_secao_e_rejeita_adulteracao(): void
    {
        $service = new NatVistoriaSecaoTokenService();
        $token = $service->criar(7, 9, 'LOCAL-1', 'SECAO-2');

        $this->assertStringNotContainsString('LOCAL-1', $token);
        $this->assertMatchesRegularExpression('/^[A-Za-z0-9_-]{43}$/', $token);
        $this->assertTrue($service->corresponde($token, 7, 9, 'LOCAL-1', 'SECAO-2'));
        $this->assertFalse($service->corresponde($token, 8, 9, 'LOCAL-1', 'SECAO-2'));
        $this->assertFalse($service->corresponde($token, 7, 10, 'LOCAL-1', 'SECAO-2'));
        $this->assertFalse($service->corresponde($token, 7, 9, 'LOCAL-2', 'SECAO-2'));
        $this->assertFalse($service->corresponde($token, 7, 9, 'LOCAL-1', 'SECAO-3'));
        $ultimoCaractereAlternativo = $token[42] === 'A' ? 'B' : 'A';
        $this->assertFalse($service->corresponde(substr($token, 0, 42).$ultimoCaractereAlternativo, 7, 9, 'LOCAL-1', 'SECAO-2'));
        $this->assertFalse($service->corresponde($token.'A', 7, 9, 'LOCAL-1', 'SECAO-2'));
    }

    #[Test]
    public function gravacao_aceita_somente_token_curto_no_formato_base64url(): void
    {
        $request = new NatVistoriaSecaoStoreRequest();
        $dados = [
            'token' => str_repeat('A', 43),
            'catalogo_fingerprint' => str_repeat('b', 64),
            'chave_idempotencia' => '4b5dd098-8b1d-4df4-a7ea-18d5b9f0e34d',
            'respostas' => [1 => 'SIM'],
        ];

        $this->assertTrue(Validator::make($dados, $request->rules())->passes());

        $dados['token'] = str_repeat('A', 44);
        $this->assertFalse(Validator::make($dados, $request->rules())->passes());

        $dados['token'] = str_repeat('A', 42).'.';
        $this->assertFalse(Validator::make($dados, $request->rules())->passes());
    }
}
```
</TESTS_UNIT_NATVISTORIASECAOTOKENSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/PermissaoDominioServiceTest.php`
## <TESTS_UNIT_PERMISSAODOMINIOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/PermissaoDominioServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class PermissaoDominioServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_pode_acessar_rota_delega_para_service_de_acl(): void
public function test_pode_executar_sem_macroprojeto_delega_para_acl_de_rota(): void
public function test_pode_executar_rejeita_rota_vazia_sem_consultar_banco(): void
public function test_pode_operar_macro_rejeita_macro_invalido_ou_lista_vazia_sem_consultar_banco(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Acesso\AcessoRotaPermissaoService;
use App\Services\PermissaoDominioService;
use Mockery;
use Tests\TestCase;

class PermissaoDominioServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_pode_acessar_rota_delega_para_service_de_acl(): void
    {
        $acl = Mockery::mock(AcessoRotaPermissaoService::class);
        $acl->shouldReceive('podeAcessarRota')
            ->once()
            ->with('rota.protegida', ['GRUPO_X'])
            ->andReturnTrue();

        $service = new PermissaoDominioService($acl);

        $this->assertTrue($service->podeAcessarRota('rota.protegida', ['GRUPO_X']));
    }

    public function test_pode_executar_sem_macroprojeto_delega_para_acl_de_rota(): void
    {
        $acl = Mockery::mock(AcessoRotaPermissaoService::class);
        $acl->shouldReceive('podeAcessarRota')
            ->once()
            ->with('rota.protegida', ['GRUPO_X'])
            ->andReturnTrue();

        $service = new PermissaoDominioService($acl);

        $this->assertTrue($service->podeExecutar('rota.protegida', null, ['GRUPO_X']));
    }

    public function test_pode_executar_rejeita_rota_vazia_sem_consultar_banco(): void
    {
        $acl = Mockery::mock(AcessoRotaPermissaoService::class);
        $acl->shouldNotReceive('podeAcessarRota');

        $service = new PermissaoDominioService($acl);

        $this->assertFalse($service->podeExecutar('   ', null, ['GRUPO_X']));
    }

    public function test_pode_operar_macro_rejeita_macro_invalido_ou_lista_vazia_sem_consultar_banco(): void
    {
        $acl = Mockery::mock(AcessoRotaPermissaoService::class);
        $service = new PermissaoDominioService($acl);

        $this->assertFalse($service->podeOperarMacro(0, ['GRUPO_X']));
        $this->assertFalse($service->podeOperarMacro(7, []));
    }
}
```
</TESTS_UNIT_PERMISSAODOMINIOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaAclScopeControllerTest.php`
## <TESTS_UNIT_ROTAACLSCOPECONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaAclScopeControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaAclScopeControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_store_bloqueia_criacao_em_zona_fora_do_escopo(): void
public function test_buscar_locais_retorna_vazio_quando_zona_esta_fora_do_escopo(): void
public function test_buscar_locais_aceita_zona_id_interna_quando_numero_da_zona_esta_no_escopo(): void
public function test_buscar_locais_de_polo_compartilhado_nao_usa_bloqueio_de_rota_local(): void
public function test_mapa_dados_repassa_escopo_ao_repositorio(): void
public function test_monitoramento_dados_repassa_escopo_ao_repositorio(): void
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
use Illuminate\Http\Request;
use Mockery;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class RotaAclScopeControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_store_bloqueia_criacao_em_zona_fora_do_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $request = Mockery::mock(RotaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'NUMERO' => 101,
            'DESCRICAO' => 'Rota teste',
            'ZONA_ID' => 9,
            'MUNICIPIO_ID' => 16,
        ]);
        $request->shouldNotReceive('input');

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn(collect([
            (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
        ]));

        $controller = new RotaController(
            Mockery::mock(RotaRepository::class),
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $this->expectException(HttpException::class);
        $this->expectExceptionMessage('Zona fora do escopo permitido para a rota.');

        $controller->store($request);
    }

    public function test_buscar_locais_retorna_vazio_quando_zona_esta_fora_do_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldNotReceive('buscarLocaisDisponiveisNoEscopo');

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn(collect([
            (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
        ]));

        $controller = new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->buscarLocais(Request::create('/lda/rotas/locais', 'GET', [
            'q' => 'escola',
            'zona_id' => '9',
            'municipio_id' => '16',
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }


    public function test_buscar_locais_aceita_zona_id_interna_quando_numero_da_zona_esta_no_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('buscarLocaisDisponiveisNoEscopo')
            ->once()
            ->with('escola', 44, null, [1], false)
            ->andReturn([]);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn(collect([
            (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
        ]));

        $municipioRepository = Mockery::mock(MunicipioRepository::class);
        $municipioRepository->shouldNotReceive('buscar');

        $controller = new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            $municipioRepository,
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->buscarLocais(Request::create('/lda/rotas/locais', 'GET', [
            'q' => 'escola',
            'zona_id' => '44',
            'municipio_id' => '16',
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_buscar_locais_de_polo_compartilhado_nao_usa_bloqueio_de_rota_local(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('buscarLocaisDisponiveisNoEscopo')->never();
        $repository->shouldReceive('buscarLocaisPoloVotacaoNoEscopo')
            ->once()
            ->with('escola', 44, [1], false)
            ->andReturn([
                (object) ['id' => 'LV99', 'texto' => '1 - Rio Branco - Escola Polo (Local 99)'],
            ]);

        $zonaRepository = Mockery::mock(ZonaRepository::class);
        $zonaRepository->shouldReceive('buscarPorNumero')->once()->andReturn(collect([
            (object) ['id' => 44, 'num_zona' => 1, 'descricao' => 'Primeira zona'],
        ]));

        $municipioRepository = Mockery::mock(MunicipioRepository::class);
        $municipioRepository->shouldNotReceive('buscar');

        $controller = new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            $zonaRepository,
            $municipioRepository,
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->buscarLocais(Request::create('/lda/rotas/locais', 'GET', [
            'q' => 'escola',
            'zona_id' => '44',
            'municipio_id' => '16',
            'contexto' => 'polo_local_votacao',
            'permitir_polo_local_votacao_fora_locais' => '1',
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([
            ['id' => 'LV99', 'text' => '1 - Rio Branco - Escola Polo (Local 99)'],
        ], $response->getData(true));
    }

    public function test_mapa_dados_repassa_escopo_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('rotasComLocaisNoEscopo')
            ->once()
            ->with([7, 9], [1], false)
            ->andReturn([]);

        $controller = new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->mapaDados(Request::create('/lda/rotas/mapa/dados', 'GET', [
            'rotas' => ['7', '9'],
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_monitoramento_dados_repassa_escopo_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('monitoramentoLocaisPorRotasNoEscopo')
            ->once()
            ->with([7, 9], [1], false)
            ->andReturn([]);

        $controller = new RotaController(
            $repository,
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
            Mockery::mock(CargoEquipeRepositoryInterface::class),
            Mockery::mock(EquipeRepositoryInterface::class),
            Mockery::mock(RotaEquipeService::class),
        );

        $response = $controller->monitoramentoDados(Request::create('/lda/rotas/monitoramento/dados', 'GET', [
            'rotas' => ['7', '9'],
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }
}
```
</TESTS_UNIT_ROTAACLSCOPECONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeConfiguracaoControllerAuthorizationTest.php`
## <TESTS_UNIT_SCDECONFIGURACAOCONTROLLERAUTHORIZATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeConfiguracaoControllerAuthorizationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeConfiguracaoControllerAuthorizationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function status_tambem_nega_acesso_sem_autorizacao_administrativa(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Scde\ScdeConfiguracaoController;
use App\Repositories\Scde\ScdeConfiguracaoRepository;
use App\Services\Scde\ScdeConfiguracaoService;
use App\Services\Scde\ScdeStatusService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class ScdeConfiguracaoControllerAuthorizationTest extends TestCase
{
    #[Test]
    public function status_tambem_nega_acesso_sem_autorizacao_administrativa(): void
    {
        session(['is_admin' => false]);
        $controller = new ScdeConfiguracaoController(
            Mockery::mock(ScdeConfiguracaoRepository::class),
            Mockery::mock(ScdeConfiguracaoService::class),
            Mockery::mock(ScdeStatusService::class),
        );

        try {
            $controller->status();
            $this->fail('A rota de status deveria exigir autorização administrativa.');
        } catch (HttpException $exception) {
            $this->assertSame(403, $exception->getStatusCode());
        }
    }
}
```
</TESTS_UNIT_SCDECONFIGURACAOCONTROLLERAUTHORIZATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaAcessoServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAACESSOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaAcessoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaAcessoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function protocolo_valido_inicia_sessao_restrita_a_solicitacao(): void
public function protocolo_inexistente_ou_malformado_nao_inicia_sessao(): void
private function requestComSessao(): Request
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaAcessoService;
use App\Services\SeuVotoImporta\SeuVotoImportaSessionService;
use Illuminate\Http\Request;
use Illuminate\Session\ArraySessionHandler;
use Illuminate\Session\Store;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaAcessoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function protocolo_valido_inicia_sessao_restrita_a_solicitacao(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarIdPorProtocolo')->once()
            ->with('SVI-2026-ABCDEF123456')
            ->andReturn(7);
        $request = $this->requestComSessao();

        $autenticado = (new SeuVotoImportaAcessoService(
            $repository,
            new SeuVotoImportaSessionService,
        ))->entrar('svi-2026-abcdef123456', $request);

        $this->assertTrue($autenticado);
        $this->assertSame(7, (new SeuVotoImportaSessionService)->solicitacaoId($request));
    }

    #[Test]
    public function protocolo_inexistente_ou_malformado_nao_inicia_sessao(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarIdPorProtocolo')->once()
            ->with('SVI-2026-000000000000')
            ->andReturnNull();
        $service = new SeuVotoImportaAcessoService($repository, new SeuVotoImportaSessionService);

        $this->assertFalse($service->entrar('SVI-2026-000000000000', $this->requestComSessao()));
        $this->assertFalse($service->entrar('protocolo-inválido', $this->requestComSessao()));
    }

    private function requestComSessao(): Request
    {
        $request = Request::create('/rotas-publicas/seu-voto-importa/acesso', 'POST');
        $request->setLaravelSession(new Store('array', new ArraySessionHandler(120)));

        return $request;
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAACESSOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisorPredioAdminRoutesTest.php`
## <TESTS_UNIT_SUPERVISORPREDIOADMINROUTESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisorPredioAdminRoutesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisorPredioAdminRoutesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_rotas_existentes_preservam_metodo_uri_nome_e_usam_controller_administrativo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$this->assertInstanceOf(Route::class, $rota, $nome);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\SupervisoresPredio\SupervisorPredioAdminController;
use Illuminate\Routing\Route;
use Tests\TestCase;

class SupervisorPredioAdminRoutesTest extends TestCase
{
    public function test_rotas_existentes_preservam_metodo_uri_nome_e_usam_controller_administrativo(): void
    {
        $esperadas = [
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios', 'index'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.novo' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/novo', 'create'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.store' => ['POST', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios', 'store'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.locais' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/locais', 'locais'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.bancos' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/bancos', 'bancos'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/{id}/editar-cadastro', 'edit'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.update' => ['PUT', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/{id}/atualizar-cadastro', 'update'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar-local' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/{id}/editar-local', 'editarLocal'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.atualizar-local' => ['POST', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/{id}/atualizar-local', 'atualizarLocal'],
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.exportar-pdf' => ['GET', 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/exportar-pdf', 'exportarPdf'],
        ];

        foreach ($esperadas as $nome => [$metodo, $uri, $acao]) {
            $rota = app('router')->getRoutes()->getByName($nome);

            $this->assertInstanceOf(Route::class, $rota, $nome);
            $this->assertContains($metodo, $rota->methods(), $nome);
            $this->assertSame($uri, $rota->uri(), $nome);
            $this->assertSame(SupervisorPredioAdminController::class . '@' . $acao, $rota->getActionName(), $nome);
        }

        $exportacao = app('router')->getRoutes()->getByName(
            'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.exportar-pdf'
        );
        $this->assertContains('macroprojeto.contexto', $exportacao->gatherMiddleware());
    }
}
```
</TESTS_UNIT_SUPERVISORPREDIOADMINROUTESTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisoresPredioExportarPdfAclMigrationTest.php`
## <TESTS_UNIT_SUPERVISORESPREDIOEXPORTARPDFACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisoresPredioExportarPdfAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisoresPredioExportarPdfAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_vincula_rota_exportar_pdf_supervisores_predio_ao_grupo_colaboradores_admin(): void
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

class SupervisoresPredioExportarPdfAclMigrationTest extends TestCase
{
    #[Test]
    public function migration_vincula_rota_exportar_pdf_supervisores_predio_ao_grupo_colaboradores_admin(): void
    {
        $conteudo = file_get_contents(database_path(
            'migrations/2026_06_03_120000_grant_supervisores_predio_exportar_pdf_to_colaboradores_admin_group.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("private const GRUPO_NOME = 'PLANELEITO_COLABORADORES_ADMIN';", $conteudo);
        $this->assertStringContainsString(
            "'rota_nome' => 'colaboradores-eleitorais.externos.supervisores-predio-voluntarios.exportar-pdf'",
            $conteudo
        );
        $this->assertStringContainsString(
            "'rota_path' => 'colaboradores-eleitorais/externos/supervisores-predio-voluntarios/exportar-pdf'",
            $conteudo
        );
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
    }
}
```
</TESTS_UNIT_SUPERVISORESPREDIOEXPORTARPDFACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsConsultaClientTest.php`
## <TESTS_UNIT_TEXTBEESMSCONSULTACLIENTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsConsultaClientTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsConsultaClientTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_consulta_saida_por_janela_com_a_mesma_credencial_e_aparelho(): void
public function test_percorre_todas_as_paginas_de_respostas_usando_cursor(): void
public function test_falha_http_ou_payload_invalido_nao_e_tratado_como_lista_vazia(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\TextBeeSmsConsultaClient;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use RuntimeException;
use Tests\TestCase;

class TextBeeSmsConsultaClientTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'chave-secreta',
            'device_id' => 'device-123',
            'connect_timeout' => 2,
            'timeout' => 5,
        ]);
    }

    public function test_consulta_saida_por_janela_com_a_mesma_credencial_e_aparelho(): void
    {
        Http::fake(['*' => Http::response([
            'data' => [[
                '_id' => 'sms-1',
                'smsBatch' => 'batch-1',
                'status' => 'delivered',
            ]],
            'meta' => ['hasMore' => false, 'nextCursor' => null],
        ])]);

        $mensagens = app(TextBeeSmsConsultaClient::class)->listarEnviadasDesde('2026-08-16T20:43:06Z');

        $this->assertSame('sms-1', $mensagens[0]['_id']);
        Http::assertSent(static function (Request $request): bool {
            parse_str((string) parse_url($request->url(), PHP_URL_QUERY), $query);

            return $request->hasHeader('x-api-key', 'chave-secreta')
                && str_starts_with($request->url(), 'https://api.textbee.dev/api/v1/gateway/messages?')
                && ($query['direction'] ?? null) === 'sent'
                && ($query['deviceIds'] ?? null) === 'device-123'
                && ($query['from'] ?? null) === '2026-08-16T20:43:06Z'
                && ($query['order'] ?? null) === 'asc'
                && (int) ($query['limit'] ?? 0) === 100;
        });
    }

    public function test_percorre_todas_as_paginas_de_respostas_usando_cursor(): void
    {
        Http::fakeSequence()
            ->push([
                'data' => [['_id' => 'recebida-1']],
                'meta' => ['hasMore' => true, 'nextCursor' => 'cursor-1'],
            ])
            ->push([
                'data' => [['_id' => 'recebida-2']],
                'meta' => ['hasMore' => false, 'nextCursor' => null],
            ]);

        $mensagens = app(TextBeeSmsConsultaClient::class)->listarRecebidasDesde('2026-08-16T00:00:00Z');

        $this->assertSame(['recebida-1', 'recebida-2'], array_column($mensagens, '_id'));
        $requisicoes = Http::recorded();
        $this->assertCount(2, $requisicoes);
        parse_str((string) parse_url($requisicoes[0][0]->url(), PHP_URL_QUERY), $primeira);
        parse_str((string) parse_url($requisicoes[1][0]->url(), PHP_URL_QUERY), $segunda);
        $this->assertSame('received', $primeira['direction'] ?? null);
        $this->assertSame('2026-08-16T00:00:00Z', $primeira['from'] ?? null);
        $this->assertSame('cursor-1', $segunda['cursor'] ?? null);
    }

    public function test_falha_http_ou_payload_invalido_nao_e_tratado_como_lista_vazia(): void
    {
        Http::fakeSequence()
            ->push([], 429)
            ->push(['data' => 'invalido', 'meta' => []]);

        try {
            app(TextBeeSmsConsultaClient::class)->listarEnviadasDesde('2026-08-16T20:43:06Z');
            $this->fail('A falha HTTP deveria interromper a consulta.');
        } catch (RuntimeException) {
            $this->assertTrue(true);
        }

        $this->expectException(RuntimeException::class);
        app(TextBeeSmsConsultaClient::class)->listarEnviadasDesde('2026-08-16T20:43:06Z');
    }
}
```
</TESTS_UNIT_TEXTBEESMSCONSULTACLIENTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaUrbanaRoutesUiTest.php`
## <TESTS_UNIT_URNACONTINGENCIAURBANAROUTESUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaUrbanaRoutesUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaUrbanaRoutesUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function crud_expoe_rotas_internas_com_metodos_esperados(): void
public function menu_e_views_seguem_o_contrato_administrativo_responsivo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$rota = Route::getRoutes()->getByName($nome);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\Route;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class UrnaContingenciaUrbanaRoutesUiTest extends TestCase
{
    #[Test]
    public function crud_expoe_rotas_internas_com_metodos_esperados(): void
    {
        $esperadas = [
            'tabelas-auxiliares.urnas-contingencia-urbana.index' => 'GET',
            'tabelas-auxiliares.urnas-contingencia-urbana.exportar-pdf' => 'GET',
            'tabelas-auxiliares.urnas-contingencia-urbana.form' => 'GET',
            'tabelas-auxiliares.urnas-contingencia-urbana.store' => 'POST',
            'tabelas-auxiliares.urnas-contingencia-urbana.update' => 'PUT',
            'tabelas-auxiliares.urnas-contingencia-urbana.destroy' => 'DELETE',
        ];

        foreach ($esperadas as $nome => $metodo) {
            $rota = Route::getRoutes()->getByName($nome);
            $this->assertNotNull($rota, $nome);
            $this->assertContains($metodo, $rota->methods(), $nome);
        }
    }

    #[Test]
    public function menu_e_views_seguem_o_contrato_administrativo_responsivo(): void
    {
        $menu = file_get_contents(config_path('planeleito_menu.php'));
        $index = file_get_contents(resource_path('views/tabelas-auxiliares/urnas-contingencia-urbana/index.blade.php'));
        $form = file_get_contents(resource_path('views/tabelas-auxiliares/urnas-contingencia-urbana/form.blade.php'));
        $formCampos = file_get_contents(resource_path('views/tabelas-auxiliares/urnas-contingencia-urbana/_form.blade.php'));
        $pdf = file_get_contents(resource_path('views/tabelas-auxiliares/urnas-contingencia-urbana/pdf.blade.php'));
        $script = file_get_contents(resource_path('views/tabelas-auxiliares/urnas-contingencia-urbana/_municipios-script.blade.php'));

        $this->assertIsString($menu);
        $this->assertIsString($index);
        $this->assertIsString($form);
        $this->assertIsString($formCampos);
        $this->assertIsString($pdf);
        $this->assertIsString($script);
        $this->assertStringContainsString("'label' => 'Percentuais de urnas de contingência'", $menu);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.urnas-contingencia-urbana.index'", $menu);
        $this->assertStringContainsString('table table-sm table-striped align-middle', $index);
        $this->assertStringContainsString('<th>Configuração</th>', $index);
        $this->assertStringContainsString('<th>Ações</th>', $index);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $index);
        $this->assertStringContainsString('Exportar para PDF', $index);
        $this->assertStringContainsString('name="campos[]"', $index);
        $this->assertStringContainsString('Percentuais de urnas de contingência', $index);
        $this->assertStringContainsString('urnas-contingencia-urbana._form', $form);
        $this->assertStringContainsString('data-zona-id', $formCampos);
        $this->assertStringContainsString('name="zona_id"', $formCampos);
        $this->assertStringContainsString('name="municipio_id"', $formCampos);
        $this->assertStringContainsString('name="percentual"', $formCampos);
        $this->assertStringContainsString('name="qtd_urna_auditoria"', $formCampos);
        $this->assertStringContainsString('Qtd. urnas de auditoria', $formCampos);
        $this->assertStringContainsString('Qtd. urnas de auditoria', $index);
        $this->assertStringContainsString("@case('qtd_urna_auditoria')", $pdf);
        $this->assertStringContainsString('$bloquearTerritorio', $formCampos);
        $this->assertStringContainsString('@foreach($campos as $campo)', $pdf);

        foreach ([$index, $form, $formCampos, $pdf, $script] as $view) {
            $this->assertNotSame('', Blade::compileString($view));
        }
    }
}
```
</TESTS_UNIT_URNACONTINGENCIAURBANAROUTESUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaOperadorAclMigrationTest.php`
## <TESTS_UNIT_VISTORIAOPERADORACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaOperadorAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaOperadorAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('macroprojeto', function (Blueprint $table): void {
Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
Schema::create('adm_acesso_rota', function (Blueprint $table): void {
Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
Schema::create('adm_grupo_macroprojeto', function (Blueprint $table): void {
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function cria_o_perfil_operacional_com_macroprojeto_e_as_oito_rotas_sem_wildcard(): void
public function down_desativa_somente_o_perfil_dedicado_e_seus_vinculos(): void
public function reativa_o_mesmo_perfil_e_seus_vinculos_apos_rollback(): void
private function migration(): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VistoriaOperadorAclMigrationTest extends TestCase
{
    private const GRUPO = 'PLANELEITO_VISTORIA_OPERADOR';

    /** @var array<int, string> */
    private const ROTAS = [
        'lda.vistoria-transmissao',
        'lda.vistoria-transmissao.form',
        'lda.vistoria-transmissao.store',
        'lda.vistoria-transmissao.update',
        'lda.vistoria-transmissao.destroy',
        'lda.vistoria-transmissao.zonas',
        'lda.vistoria-transmissao.municipios',
        'lda.vistoria-transmissao.locais',
    ];

    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('macroprojeto', function (Blueprint $table): void {
            $table->unsignedBigInteger('id')->primary();
            $table->string('nome');
            $table->string('ativo', 1);
        });

        Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
            $table->id();
            $table->string('nome');
            $table->string('descricao')->nullable();
            $table->boolean('ativo')->default(true);
            $table->boolean('ignora_unidades_permitidas')->default(false);
            $table->boolean('expande_escopo_por_atividade')->default(false);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });

        Schema::create('adm_acesso_rota', function (Blueprint $table): void {
            $table->unsignedBigInteger('id')->primary();
            $table->string('rota_nome');
            $table->boolean('ativo')->default(true);
        });

        Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('acesso_rota_id');
            $table->unsignedBigInteger('grupo_acesso_id');
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });

        Schema::create('adm_grupo_macroprojeto', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('grupo_acesso_id');
            $table->unsignedBigInteger('macroprojeto_id')->nullable();
            $table->boolean('escopo_global')->default(false);
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });

        DB::table('macroprojeto')->insert([
            'id' => 1,
            'nome' => 'Eleições 2026',
            'ativo' => 'S',
        ]);

        foreach (self::ROTAS as $indice => $rota) {
            DB::table('adm_acesso_rota')->insert([
                'id' => $indice + 1,
                'rota_nome' => $rota,
                'ativo' => 1,
            ]);
        }

        DB::table('adm_acesso_rota')->insert([
            'id' => 99,
            'rota_nome' => '*',
            'ativo' => 1,
        ]);

        DB::table('adm_grupo_acesso')->insert([
            'id' => 100,
            'nome' => 'GRUPO_EXISTENTE',
            'descricao' => 'Controle para garantir rollback restrito.',
            'ativo' => 1,
            'ignora_unidades_permitidas' => 0,
            'expande_escopo_por_atividade' => 0,
        ]);

        DB::table('adm_acesso_rota_grupo')->insert([
            'acesso_rota_id' => 1,
            'grupo_acesso_id' => 100,
            'ativo' => 1,
        ]);
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('adm_grupo_macroprojeto');
        Schema::dropIfExists('adm_acesso_rota_grupo');
        Schema::dropIfExists('adm_acesso_rota');
        Schema::dropIfExists('adm_grupo_acesso');
        Schema::dropIfExists('macroprojeto');

        parent::tearDown();
    }

    #[Test]
    public function cria_o_perfil_operacional_com_macroprojeto_e_as_oito_rotas_sem_wildcard(): void
    {
        $migration = $this->migration();

        $migration->up();
        $migration->up();

        $grupo = DB::table('adm_grupo_acesso')
            ->where('nome', self::GRUPO)
            ->first();

        $this->assertNotNull($grupo);
        $this->assertSame(1, (int) $grupo->ativo);
        $this->assertSame(0, (int) $grupo->ignora_unidades_permitidas);
        $this->assertSame(0, (int) $grupo->expande_escopo_por_atividade);
        $this->assertSame(1, DB::table('adm_grupo_acesso')->where('nome', self::GRUPO)->count());

        $this->assertSame(1, DB::table('adm_grupo_macroprojeto')
            ->where('grupo_acesso_id', $grupo->id)
            ->where('macroprojeto_id', 1)
            ->where('escopo_global', 0)
            ->where('ativo', 1)
            ->count());

        $rotasAtivas = DB::table('adm_acesso_rota_grupo as arg')
            ->join('adm_acesso_rota as ar', 'ar.id', '=', 'arg.acesso_rota_id')
            ->where('arg.grupo_acesso_id', $grupo->id)
            ->where('arg.ativo', 1)
            ->orderBy('ar.rota_nome')
            ->pluck('ar.rota_nome')
            ->all();

        $esperadas = self::ROTAS;
        sort($esperadas);
        $this->assertSame($esperadas, $rotasAtivas);
        $this->assertNotContains('*', $rotasAtivas);
        $this->assertSame(8, DB::table('adm_acesso_rota_grupo')
            ->where('grupo_acesso_id', $grupo->id)
            ->count());
    }

    #[Test]
    public function down_desativa_somente_o_perfil_dedicado_e_seus_vinculos(): void
    {
        $migration = $this->migration();
        $migration->up();

        $grupoId = (int) DB::table('adm_grupo_acesso')
            ->where('nome', self::GRUPO)
            ->value('id');

        $migration->down();

        $this->assertSame(0, (int) DB::table('adm_grupo_acesso')
            ->where('id', $grupoId)
            ->value('ativo'));
        $this->assertSame(0, DB::table('adm_acesso_rota_grupo')
            ->where('grupo_acesso_id', $grupoId)
            ->where('ativo', 1)
            ->count());
        $this->assertSame(0, DB::table('adm_grupo_macroprojeto')
            ->where('grupo_acesso_id', $grupoId)
            ->where('ativo', 1)
            ->count());

        $this->assertSame(1, (int) DB::table('adm_grupo_acesso')
            ->where('id', 100)
            ->value('ativo'));
        $this->assertSame(1, DB::table('adm_acesso_rota_grupo')
            ->where('grupo_acesso_id', 100)
            ->where('ativo', 1)
            ->count());
    }

    #[Test]
    public function reativa_o_mesmo_perfil_e_seus_vinculos_apos_rollback(): void
    {
        $migration = $this->migration();
        $migration->up();

        $grupoId = (int) DB::table('adm_grupo_acesso')
            ->where('nome', self::GRUPO)
            ->value('id');

        $migration->down();
        $migration->up();

        $this->assertSame($grupoId, (int) DB::table('adm_grupo_acesso')
            ->where('nome', self::GRUPO)
            ->value('id'));
        $this->assertSame(1, (int) DB::table('adm_grupo_acesso')
            ->where('id', $grupoId)
            ->value('ativo'));
        $this->assertSame(8, DB::table('adm_acesso_rota_grupo')
            ->where('grupo_acesso_id', $grupoId)
            ->where('ativo', 1)
            ->count());
        $this->assertSame(1, DB::table('adm_grupo_macroprojeto')
            ->where('grupo_acesso_id', $grupoId)
            ->where('macroprojeto_id', 1)
            ->where('ativo', 1)
            ->count());
    }

    private function migration(): object
    {
        $arquivo = database_path(
            'migrations/2026_08_04_122000_create_vistoria_operador_acl.php'
        );

        $this->assertFileExists($arquivo);

        return require $arquivo;
    }
}
```
</TESTS_UNIT_VISTORIAOPERADORACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VistoriaTransmissaoDashboardAclMigrationTest.php`
## <TESTS_UNIT_VISTORIATRANSMISSAODASHBOARDACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VistoriaTransmissaoDashboardAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VistoriaTransmissaoDashboardAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
Schema::create('adm_acesso_rota', function (Blueprint $table): void {
Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
DB::table('adm_grupo_acesso')->insert([
DB::table('adm_acesso_rota')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_cria_rota_e_vincula_somente_os_tres_grupos_de_vistoria(): void
public function test_down_desativa_somente_a_rota_e_os_vinculos_do_dashboard(): void
private function migration(): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class VistoriaTransmissaoDashboardAclMigrationTest extends TestCase
{
    private const ROTA = 'lda.vistoria-transmissao.dashboard';

    /** @var array<int, string> */
    private const GRUPOS = [
        'PLANELEITO_TRANSMISSAO_ADMIN',
        'PLANELEITO_TRANSMISSAO',
        'PLANELEITO_VISTORIA_OPERADOR',
    ];

    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('adm_grupo_acesso', function (Blueprint $table): void {
            $table->id();
            $table->string('nome');
            $table->boolean('ativo')->default(true);
        });
        Schema::create('adm_acesso_rota', function (Blueprint $table): void {
            $table->id();
            $table->string('rota_nome');
            $table->string('rota_path')->nullable();
            $table->string('menu_path')->nullable();
            $table->string('descricao')->nullable();
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });
        Schema::create('adm_acesso_rota_grupo', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('acesso_rota_id');
            $table->unsignedBigInteger('grupo_acesso_id');
            $table->boolean('ativo')->default(true);
            $table->timestamp('dt_criacao')->nullable();
            $table->timestamp('dt_atualizacao')->nullable();
        });

        foreach (self::GRUPOS as $indice => $grupo) {
            DB::table('adm_grupo_acesso')->insert([
                'id' => $indice + 1,
                'nome' => $grupo,
                'ativo' => 1,
            ]);
        }

        DB::table('adm_acesso_rota')->insert([
            'id' => 99,
            'rota_nome' => 'rota.controle',
            'ativo' => 1,
        ]);
        DB::table('adm_acesso_rota_grupo')->insert([
            'acesso_rota_id' => 99,
            'grupo_acesso_id' => 1,
            'ativo' => 1,
        ]);
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('adm_acesso_rota_grupo');
        Schema::dropIfExists('adm_acesso_rota');
        Schema::dropIfExists('adm_grupo_acesso');

        parent::tearDown();
    }

    public function test_cria_rota_e_vincula_somente_os_tres_grupos_de_vistoria(): void
    {
        $migration = $this->migration();

        $migration->up();
        $migration->up();

        $rota = DB::table('adm_acesso_rota')->where('rota_nome', self::ROTA)->first();
        $this->assertNotNull($rota);
        $this->assertSame(1, (int) $rota->ativo);
        $this->assertSame('lda/vistoria-transmissao/dashboard', $rota->rota_path);
        $this->assertSame(1, DB::table('adm_acesso_rota')->where('rota_nome', self::ROTA)->count());

        $grupos = DB::table('adm_acesso_rota_grupo as arg')
            ->join('adm_grupo_acesso as aga', 'aga.id', '=', 'arg.grupo_acesso_id')
            ->where('arg.acesso_rota_id', $rota->id)
            ->where('arg.ativo', 1)
            ->orderBy('aga.nome')
            ->pluck('aga.nome')
            ->all();

        $esperados = self::GRUPOS;
        sort($esperados);
        $this->assertSame($esperados, $grupos);
        $this->assertSame(3, DB::table('adm_acesso_rota_grupo')
            ->where('acesso_rota_id', $rota->id)
            ->count());
    }

    public function test_down_desativa_somente_a_rota_e_os_vinculos_do_dashboard(): void
    {
        $migration = $this->migration();
        $migration->up();

        $rotaId = (int) DB::table('adm_acesso_rota')
            ->where('rota_nome', self::ROTA)
            ->value('id');

        $migration->down();

        $this->assertSame(0, (int) DB::table('adm_acesso_rota')
            ->where('id', $rotaId)
            ->value('ativo'));
        $this->assertSame(0, DB::table('adm_acesso_rota_grupo')
            ->where('acesso_rota_id', $rotaId)
            ->where('ativo', 1)
            ->count());
        $this->assertSame(1, (int) DB::table('adm_acesso_rota')
            ->where('id', 99)
            ->value('ativo'));
        $this->assertSame(1, (int) DB::table('adm_acesso_rota_grupo')
            ->where('acesso_rota_id', 99)
            ->value('ativo'));
    }

    private function migration(): object
    {
        return require database_path(
            'migrations/2026_08_12_140000_grant_vistoria_transmissao_dashboard_acl.php'
        );
    }
}
```
</TESTS_UNIT_VISTORIATRANSMISSAODASHBOARDACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VoluntarioFuncaoInativacaoRoutesUiTest.php`
## <TESTS_UNIT_VOLUNTARIOFUNCAOINATIVACAOROUTESUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VoluntarioFuncaoInativacaoRoutesUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VoluntarioFuncaoInativacaoRoutesUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rotas_de_funcoes_inativas_tem_metodos_corretos_e_independem_de_macroprojeto(): void
public function telas_ativas_oferecem_encerramento_e_tela_unica_oferece_restauracao_e_pdf(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$rota = Route::getRoutes()->getByName($nome);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Support\Facades\Route;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VoluntarioFuncaoInativacaoRoutesUiTest extends TestCase
{
    #[Test]
    public function rotas_de_funcoes_inativas_tem_metodos_corretos_e_independem_de_macroprojeto(): void
    {
        $esperadas = [
            'colaboradores-eleitorais.externos.voluntarios.funcoes-inativas' => 'GET',
            'colaboradores-eleitorais.externos.voluntarios.funcoes-inativas.exportar-pdf' => 'GET',
            'colaboradores-eleitorais.externos.voluntarios.funcoes.inativar' => 'DELETE',
            'colaboradores-eleitorais.externos.voluntarios.funcoes-inativas.restaurar' => 'POST',
        ];

        foreach ($esperadas as $nome => $metodo) {
            $rota = Route::getRoutes()->getByName($nome);

            $this->assertNotNull($rota, $nome);
            $this->assertContains($metodo, $rota->methods());
            $this->assertNotContains('macroprojeto.contexto', $rota->gatherMiddleware());
        }
    }

    #[Test]
    public function telas_ativas_oferecem_encerramento_e_tela_unica_oferece_restauracao_e_pdf(): void
    {
        $supervisores = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php'));
        $coordenadores = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/coordenadores-acessibilidade/index.blade.php'));
        $inativas = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/funcoes-inativas/index.blade.php'));

        $this->assertIsString($supervisores);
        $this->assertStringContainsString('Encerrar função', $supervisores);
        $this->assertStringContainsString('PREPARAR_EXCLUSAO_GLOBAL', $supervisores);
        $this->assertStringNotContainsString('Excluir cadastro</span>', $supervisores);

        $this->assertIsString($coordenadores);
        $this->assertStringContainsString('Encerrar função', $coordenadores);
        $this->assertStringContainsString('PREPARAR_EXCLUSAO_GLOBAL', $coordenadores);
        $this->assertStringContainsString('$item->eh_voluntario', $coordenadores);
        $this->assertStringContainsString('Excluir cadastro', $coordenadores);

        $this->assertIsString($inativas);
        $this->assertStringContainsString('<th scope="col">Função inativa</th>', $inativas);
        $this->assertStringContainsString('<th scope="col">Ações</th>', $inativas);
        $this->assertStringContainsString('modalRestaurarFuncao', $inativas);
        $this->assertStringContainsString('funcoes-inativas.exportar-pdf', $inativas);
        $this->assertStringContainsString('campos[]', $inativas);
        $this->assertStringContainsString('btn-excluir-voluntario-global', $inativas);
        $this->assertStringContainsString('modalExcluirVoluntarioGlobal', $inativas);
        $this->assertStringContainsString(
            'colaboradores-eleitorais.externos.voluntarios.excluir',
            $inativas
        );
    }
}
```
</TESTS_UNIT_VOLUNTARIOFUNCAOINATIVACAOROUTESUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VoluntarioManualRoutesUiTest.php`
## <TESTS_UNIT_VOLUNTARIOMANUALROUTESUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VoluntarioManualRoutesUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VoluntarioManualRoutesUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function registra_as_oito_rotas_nominais_com_macroprojeto(): void
public function listagem_e_responsiva_paginada_e_exporta_pdf_por_modal(): void
public function formulario_expoe_apenas_os_dados_cadastrais_aprovados_e_titulo_imutavel(): void
public function menu_possui_entrada_propria_para_catalogo_manual(): void
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

class VoluntarioManualRoutesUiTest extends TestCase
{
    #[Test]
    public function registra_as_oito_rotas_nominais_com_macroprojeto(): void
    {
        $esperadas = [
            'index' => ['GET', 'colaboradores-eleitorais/externos/voluntarios-manuais'],
            'create' => ['GET', 'colaboradores-eleitorais/externos/voluntarios-manuais/novo'],
            'store' => ['POST', 'colaboradores-eleitorais/externos/voluntarios-manuais'],
            'edit' => ['GET', 'colaboradores-eleitorais/externos/voluntarios-manuais/{id}/editar'],
            'update' => ['PUT', 'colaboradores-eleitorais/externos/voluntarios-manuais/{id}'],
            'destroy' => ['DELETE', 'colaboradores-eleitorais/externos/voluntarios-manuais/{id}'],
            'restore' => ['POST', 'colaboradores-eleitorais/externos/voluntarios-manuais/{id}/restaurar'],
            'exportar-pdf' => ['GET', 'colaboradores-eleitorais/externos/voluntarios-manuais/exportar-pdf'],
        ];

        foreach ($esperadas as $acao => [$metodo, $uri]) {
            $nome = 'colaboradores-eleitorais.externos.voluntarios-manuais.'.$acao;
            $rota = collect(app('router')->getRoutes()->getRoutes())
                ->first(static fn ($rota) => $rota->getName() === $nome);

            $this->assertNotNull($rota, "Rota ausente: {$nome}");
            $this->assertContains($metodo, $rota->methods());
            $this->assertSame($uri, $rota->uri());
            $this->assertContains('macroprojeto.contexto', $rota->gatherMiddleware());
        }
    }

    #[Test]
    public function listagem_e_responsiva_paginada_e_exporta_pdf_por_modal(): void
    {
        $conteudo = file_get_contents(resource_path(
            'views/colaboradores-eleitorais/externos/voluntarios-manuais/index.blade.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Voluntários manuais', $conteudo);
        $this->assertStringContainsString('table-responsive', $conteudo);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $conteudo);
        $this->assertStringContainsString('modalExportarPdfVoluntariosManuais', $conteudo);
        $this->assertStringContainsString('name="campos[]"', $conteudo);
        $this->assertStringContainsString('conflito', $conteudo);
        $this->assertStringContainsString('Origem', $conteudo);
    }

    #[Test]
    public function formulario_expoe_apenas_os_dados_cadastrais_aprovados_e_titulo_imutavel(): void
    {
        $conteudo = file_get_contents(resource_path(
            'views/colaboradores-eleitorais/externos/voluntarios-manuais/form.blade.php'
        ));

        $this->assertIsString($conteudo);
        foreach ([
            'nome_civil', 'nome_social', 'num_inscricao', 'telefone', 'num_cpf',
            'profissao', 'data_nasc', 'email', 'tamanho_camisa', 'escolaridade',
            'endereco_completo',
        ] as $campo) {
            $this->assertStringContainsString($campo, $conteudo);
        }
        $this->assertStringContainsString('disabled', $conteudo);
        $this->assertStringNotContainsString('num_zona', $conteudo);
        $this->assertStringNotContainsString('dados_bancarios', $conteudo);
        $this->assertStringNotContainsString('experiencias_anteriores', $conteudo);
        $this->assertStringNotContainsString('autorizacao_disponibilidade', $conteudo);
    }

    #[Test]
    public function menu_possui_entrada_propria_para_catalogo_manual(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Voluntários Manuais'", $conteudo);
        $this->assertStringContainsString("'route' => 'colaboradores-eleitorais.externos.voluntarios-manuais.index'", $conteudo);
    }
}
```
</TESTS_UNIT_VOLUNTARIOMANUALROUTESUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VoluntariosExternosExportarPdfAclMigrationTest.php`
## <TESTS_UNIT_VOLUNTARIOSEXTERNOSEXPORTARPDFACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VoluntariosExternosExportarPdfAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VoluntariosExternosExportarPdfAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_vincula_rota_exportar_pdf_voluntarios_aos_tres_grupos(): void
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

class VoluntariosExternosExportarPdfAclMigrationTest extends TestCase
{
    #[Test]
    public function migration_vincula_rota_exportar_pdf_voluntarios_aos_tres_grupos(): void
    {
        $conteudo = file_get_contents(database_path(
            'migrations/2026_06_03_130000_grant_voluntarios_externos_exportar_pdf_to_grupos.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_ADMIN', $conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_CONSIDERA_TAREFA', $conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_EXTERNOS', $conteudo);
        $this->assertStringContainsString(
            "'rota_nome' => 'colaboradores-eleitorais.externos.voluntarios.exportar-pdf'",
            $conteudo
        );
        $this->assertStringContainsString(
            "'rota_path' => 'colaboradores-eleitorais/externos/voluntarios/exportar-pdf'",
            $conteudo
        );
        $this->assertStringContainsString("where('grupo_acesso_id', \$grupoId)", $conteudo);
        $this->assertStringContainsString("where('acesso_rota_id', \$rotaId)", $conteudo);
    }
}
```
</TESTS_UNIT_VOLUNTARIOSEXTERNOSEXPORTARPDFACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VoluntariosExternosPdfAsyncAclMigrationTest.php`
## <TESTS_UNIT_VOLUNTARIOSEXTERNOSPDFASYNCACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VoluntariosExternosPdfAsyncAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VoluntariosExternosPdfAsyncAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_registra_tres_rotas_async_para_os_tres_grupos(): void
public function job_gerar_pdf_voluntarios_existe_e_implementa_should_queue(): void
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

class VoluntariosExternosPdfAsyncAclMigrationTest extends TestCase
{
    #[Test]
    public function migration_registra_tres_rotas_async_para_os_tres_grupos(): void
    {
        $conteudo = file_get_contents(database_path(
            'migrations/2026_06_03_140000_grant_voluntarios_externos_pdf_async_to_grupos.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_ADMIN', $conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_CONSIDERA_TAREFA', $conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_EXTERNOS', $conteudo);
        $this->assertStringContainsString('colaboradores-eleitorais.externos.voluntarios.pdf.solicitar', $conteudo);
        $this->assertStringContainsString('colaboradores-eleitorais.externos.voluntarios.pdf.status', $conteudo);
        $this->assertStringContainsString('colaboradores-eleitorais.externos.voluntarios.pdf.download', $conteudo);
    }

    #[Test]
    public function job_gerar_pdf_voluntarios_existe_e_implementa_should_queue(): void
    {
        $this->assertTrue(class_exists(\App\Jobs\ColaboradoresEleitorais\GerarPdfVoluntariosExternosJob::class));
        $this->assertContains(
            \Illuminate\Contracts\Queue\ShouldQueue::class,
            class_implements(\App\Jobs\ColaboradoresEleitorais\GerarPdfVoluntariosExternosJob::class) ?: []
        );
    }
}
```
</TESTS_UNIT_VOLUNTARIOSEXTERNOSPDFASYNCACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VoluntariosExternosRelatorioEventosAclMigrationTest.php`
## <TESTS_UNIT_VOLUNTARIOSEXTERNOSRELATORIOEVENTOSACLMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VoluntariosExternosRelatorioEventosAclMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VoluntariosExternosRelatorioEventosAclMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_vincula_relatorio_aos_tres_grupos_do_fluxo(): void
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

class VoluntariosExternosRelatorioEventosAclMigrationTest extends TestCase
{
    #[Test]
    public function migration_vincula_relatorio_aos_tres_grupos_do_fluxo(): void
    {
        $arquivo = database_path('migrations/2026_08_06_120000_grant_relatorio_eventos_voluntarios_externos_acl.php');

        $this->assertFileExists($arquivo);
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_ADMIN', $conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_CONSIDERA_TAREFA', $conteudo);
        $this->assertStringContainsString('PLANELEITO_COLABORADORES_EXTERNOS', $conteudo);
        $this->assertStringContainsString(
            'colaboradores-eleitorais.externos.voluntarios.relatorio-eventos.pdf',
            $conteudo
        );
        $this->assertStringContainsString(
            'colaboradores-eleitorais/externos/voluntarios/relatorio-eventos.pdf',
            $conteudo
        );
    }
}
```
</TESTS_UNIT_VOLUNTARIOSEXTERNOSRELATORIOEVENTOSACLMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VwConvocadosFromVoluntarioPerfilMigrationTest.php`
## <TESTS_UNIT_VWCONVOCADOSFROMVOLUNTARIOPERFILMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VwConvocadosFromVoluntarioPerfilMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VwConvocadosFromVoluntarioPerfilMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_redefine_vw_convocados_a_partir_de_vw_voluntario_perfil(): void
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

class VwConvocadosFromVoluntarioPerfilMigrationTest extends TestCase
{
    #[Test]
    public function migration_redefine_vw_convocados_a_partir_de_vw_voluntario_perfil(): void
    {
        $arquivo = database_path('migrations/2026_04_13_000100_update_vw_convocados_from_voluntario_perfil.php');
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE OR REPLACE VIEW planeleito.vw_convocados AS', $conteudo);
        $this->assertStringContainsString('NVL(v.nome_civil, v.nome_social) AS nom_eleitor', $conteudo);
        $this->assertStringContainsString('v.data_nasc AS dat_nasc', $conteudo);
        $this->assertStringContainsString('v.num_inscricao', $conteudo);
        $this->assertStringContainsString('v.num_cpf', $conteudo);
        $this->assertStringContainsString('v.num_zona', $conteudo);
        $this->assertStringContainsString('ev.localidade AS nom_localidade', $conteudo);
        $this->assertStringContainsString('FROM ac_pessoa.vw_voluntario_perfil v', $conteudo);
        $this->assertStringContainsString('LEFT JOIN planeleito.vw_eleitor_secao_zona_localidade ev', $conteudo);
        $this->assertStringContainsString("TRIM(ev.num_inscricao) = TRIM(v.num_inscricao)", $conteudo);
    }
}
```
</TESTS_UNIT_VWCONVOCADOSFROMVOLUNTARIOPERFILMIGRATIONTEST_PHP>


