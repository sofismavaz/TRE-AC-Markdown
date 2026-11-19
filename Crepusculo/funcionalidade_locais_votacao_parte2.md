# 📦 Documentação Consolidada do Sistema Crepúsculo (Parte 2)
## Funcionalidade: `funcionalidade_locais_votacao`
> **Volume Fracionado para Otimização de Leitura por IA**
> **Tamanho Máximo:** 1500 KB

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CadastroSupervisorPredioUiTest.php`
## <TESTS_UNIT_CADASTROSUPERVISORPREDIOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CadastroSupervisorPredioUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CadastroSupervisorPredioUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_publica_usa_fieldsets_para_dividir_os_grupos_do_formulario(): void
public function view_publica_inicializa_select2_para_locais_e_bancos(): void
public function view_de_supervisores_voluntarios_exibe_detalhes_em_linha_colapsavel_com_icone_de_olho(): void
public function views_publicas_do_supervisor_usam_apenas_vendor_sob_rotas_publicas(): void
#[Test] public function view_publica_trata_localidade_apenas_como_informativa(): void { $conteudo = file_get_contents(resource_path('views/cadastro_supervisor_predio/form.blade.php')); $this->assertIsString($conteudo); $this->assertStringContainsString('Localidade do título eleitoral:', $conteudo); $this->assertStringNotContainsString('Localidade autorizada:', $conteudo); }
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

class CadastroSupervisorPredioUiTest extends TestCase
{
    #[Test]
    public function view_publica_usa_fieldsets_para_dividir_os_grupos_do_formulario(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_supervisor_predio/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<fieldset', $conteudo);
        $this->assertStringContainsString('Identificação do Supervisor de Prédio', $conteudo);
        $this->assertStringContainsString('Local de Votação onde Exercerá a função de Supervisor de Prédio', $conteudo);
        $this->assertStringContainsString('Dados Bancários e Pix', $conteudo);
        $this->assertStringContainsString('Autorizações e Disponibilidade', $conteudo);
        $this->assertStringContainsString('Termos de Uso de Dados e Privacidade (LGPD)', $conteudo);
    }

    #[Test]
    public function view_publica_inicializa_select2_para_locais_e_bancos(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_supervisor_predio/form.blade.php'));
        $script = file_get_contents(public_path('rotas-publicas/js/cadastro-supervisor-predio-form.js'));
        $css = file_get_contents(public_path('rotas-publicas/css/cadastro-supervisor-predio.css'));

        $this->assertIsString($conteudo);
        $this->assertIsString($script);
        $this->assertIsString($css);
        $this->assertStringContainsString("route('cadastro-supervisor-predio.locais')", $conteudo);
        $this->assertStringContainsString("route('cadastro-supervisor-predio.bancos')", $conteudo);
        $this->assertStringContainsString("rotas-publicas/js/cadastro-supervisor-predio-form.js", $conteudo);
        $this->assertStringContainsString("rotas-publicas/css/cadastro-supervisor-predio.css", $conteudo);
        $this->assertStringContainsString("select2({", $script);
        $this->assertStringContainsString(".card-shell", $css);
    }

    #[Test]
    public function view_de_supervisores_voluntarios_exibe_detalhes_em_linha_colapsavel_com_icone_de_olho(): void
    {
        $conteudo = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Supervisores de Prédio Voluntários', $conteudo);
        $this->assertStringContainsString('fa-solid fa-eye', $conteudo);
        $this->assertStringContainsString('data-bs-toggle="collapse"', $conteudo);
        $this->assertStringContainsString('Autorizações e disponibilidade', $conteudo);
        $this->assertStringContainsString('colspan="2"', $conteudo);
    }

    #[Test]
    public function views_publicas_do_supervisor_usam_apenas_vendor_sob_rotas_publicas(): void
    {
        foreach (['form', 'sucesso'] as $view) {
            $conteudo = file_get_contents(resource_path("views/cadastro_supervisor_predio/{$view}.blade.php"));

            $this->assertIsString($conteudo);
            $this->assertStringContainsString("rotas-publicas/vendor/bootstrap/css/bootstrap.min.css", $conteudo);
            $this->assertStringNotContainsString("cdn.jsdelivr.net", $conteudo);
        }

        $form = file_get_contents(resource_path('views/cadastro_supervisor_predio/form.blade.php'));
        $this->assertStringContainsString("rotas-publicas/vendor/select2/css/select2.min.css", $form);
        $this->assertStringContainsString("rotas-publicas/vendor/jquery/jquery-3.7.1.min.js", $form);
        $this->assertStringContainsString("rotas-publicas/vendor/select2/js/select2.min.js", $form);
        $this->assertStringNotContainsString("asset('vendor/", $form);
    }
    #[Test] public function view_publica_trata_localidade_apenas_como_informativa(): void { $conteudo = file_get_contents(resource_path('views/cadastro_supervisor_predio/form.blade.php')); $this->assertIsString($conteudo); $this->assertStringContainsString('Localidade do título eleitoral:', $conteudo); $this->assertStringNotContainsString('Localidade autorizada:', $conteudo); }
}
```
</TESTS_UNIT_CADASTROSUPERVISORPREDIOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConsolidacaoMapaLocaisMenuTest.php`
## <TESTS_UNIT_CONSOLIDACAOMAPALOCAISMENUTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConsolidacaoMapaLocaisMenuTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConsolidacaoMapaLocaisMenuTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function configuracao_de_menu_expoe_mapa_de_locais_de_votacao_na_consolidacao(): void
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

class ConsolidacaoMapaLocaisMenuTest extends TestCase
{
    #[Test]
    public function configuracao_de_menu_expoe_mapa_de_locais_de_votacao_na_consolidacao(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Mapa de Locais de Votação'", $conteudo);
        $this->assertStringContainsString("'route' => 'lda.consolidacao.mapa-locais-votacao'", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Transmissão de Dados > Consolidação > Mapa de Locais de Votação'", $conteudo);
        $this->assertStringContainsString("'route_patterns' => ['lda.consolidacao.mapa-locais-votacao']", $conteudo);
        $this->assertStringNotContainsString("'url' => '/lda/consolidacao/locais-transmissao?visualizacao=mapa'", $conteudo);
    }
}
```
</TESTS_UNIT_CONSOLIDACAOMAPALOCAISMENUTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConsolidacaoMapaLocaisUiTest.php`
## <TESTS_UNIT_CONSOLIDACAOMAPALOCAISUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConsolidacaoMapaLocaisUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConsolidacaoMapaLocaisUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_do_mapa_de_locais_oferece_os_filtros_previstos_no_contrato_sem_lista_lateral(): void
public function multiselect_de_nomes_permanece_editavel_sem_colapso_quantitativo_e_asset_e_versionado(): void
public function javascript_compartilhado_assume_os_filtros_e_o_mapa_mantem_apenas_o_comportamento_cartografico(): void
$this->assertStringNotContainsString('function atualizarSelect2Bairro()', $conteudo);
$this->assertStringNotContainsString('function atualizarConsultaParametrizada()', $conteudo);
$this->assertStringContainsString('function atualizarSelect2Bairro()', $compartilhado);
$this->assertStringContainsString('function atualizarConsultaParametrizada()', $compartilhado);
$this->assertStringContainsString('function corDoMarcadorPorZona(zona) {', $conteudo);
$this->assertStringContainsString('function criarIconeLocal(local) {', $conteudo);
public function css_compartilhado_define_area_do_novo_mapa_e_estilo_do_marcador_zonal(): void
public function filtros_do_mapa_podem_ser_recolhidos_por_seta(): void
$this->assertStringContainsString('function alternarFiltros()', $javascript);
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

class ConsolidacaoMapaLocaisUiTest extends TestCase
{
    #[Test]
    public function tela_do_mapa_de_locais_oferece_os_filtros_previstos_no_contrato_sem_lista_lateral(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("route('lda.consolidacao.locais-transmissao')", $conteudo);
        $this->assertStringContainsString("route('lda.consolidacao.mapa-locais-votacao')", $conteudo);
        $this->assertStringContainsString('class="card shadow-sm mb-3 locais-votacao-filtros-card"', $conteudo);
        $this->assertStringContainsString('class="d-flex flex-wrap align-items-center gap-2 mapa-filtros-resumo"', $conteudo);
        $this->assertStringContainsString('class="badge text-bg-light border mapa-resumo-badge"', $conteudo);
        $this->assertStringContainsString('id="filtrosLocaisVotacao"', $conteudo);
        $this->assertStringContainsString('class="row g-3 align-items-end locais-votacao-filtros-form"', $conteudo);
        $this->assertStringContainsString('data-url-municipios="{{ route(\'lda.locais-votacao.municipios\') }}"', $conteudo);
        $this->assertStringContainsString('data-url-bairros="{{ route(\'lda.locais-votacao.bairros\') }}"', $conteudo);
        $this->assertStringNotContainsString('name="visualizacao" value="mapa"', $conteudo);
        $this->assertStringContainsString('<label for="filtroZona" class="form-label">Zona</label>', $conteudo);
        $this->assertStringContainsString('<label for="filtroMunicipio" class="form-label">Município</label>', $conteudo);
        $this->assertStringContainsString('<label for="filtroBairro" class="form-label">Bairro</label>', $conteudo);
        $this->assertStringContainsString('name="bairro[]"', $conteudo);
        $this->assertStringContainsString('class="form-select select2"', $conteudo);
        $this->assertStringContainsString('data-placeholder="Selecione um município primeiro"', $conteudo);
        $this->assertStringContainsString('<label for="filtroNomeLocal" class="form-label">Nome do local</label>', $conteudo);
        $this->assertStringContainsString('name="nome_local[]"', $conteudo);
        $this->assertStringContainsString('multiple', $conteudo);
        $this->assertStringContainsString('nomesLocaisOpcoes', $conteudo);
        $this->assertStringContainsString('<label for="filtroEndereco" class="form-label">Endereço</label>', $conteudo);
        $this->assertStringContainsString('<label for="filtroSecao" class="form-label">Seção</label>', $conteudo);
        $this->assertStringContainsString('id="filtroTempoDeslocamento"', $conteudo);
        $this->assertStringContainsString('id="filtroDiaInstalacaoUrnas"', $conteudo);
        $this->assertStringContainsString('id="filtroSomenteLda"', $conteudo);
        $this->assertStringContainsString('id="filtroExcluirLda"', $conteudo);
        $this->assertStringContainsString('id="filtroComSecao"', $conteudo);
        $this->assertStringContainsString('id="filtroSemSecao"', $conteudo);
        $this->assertStringContainsString('id="filtroSomenteSecoesParametro"', $conteudo);
        $this->assertSame(3, substr_count($this->renderFiltrosMapa(), 'name="area_local"'));
        $this->assertStringContainsString('id="filtroAreaLocalTodos"', $conteudo);
        $this->assertStringContainsString('id="filtroAreaLocalUrbana"', $conteudo);
        $this->assertStringContainsString('id="filtroAreaLocalRural"', $conteudo);
        $this->assertStringContainsString('value="urbana"', $conteudo);
        $this->assertStringContainsString('value="rural"', $conteudo);
        $this->assertStringContainsString('<legend class="float-none w-auto px-2 mb-0 fs-6">Consulta Parametrizada</legend>', $conteudo);
        $this->assertStringContainsString('id="filtroEleitoresEscopo"', $conteudo);
        $this->assertStringContainsString('name="eleitores_escopo"', $conteudo);
        $this->assertStringContainsString('Número de mesários convocados no local de votação', $conteudo);
        $this->assertStringContainsString('Lista de Locais de Votação sem Coordenadas capturadas', $conteudo);
        $this->assertStringContainsString('id="filtroEleitoresOperador"', $conteudo);
        $this->assertStringContainsString('id="filtroEleitoresValor"', $conteudo);
        $this->assertStringContainsString('id="consolidacaoMapaLocaisVotacao"', $conteudo);
        $this->assertStringNotContainsString('display-6 fw-bold', $conteudo);
        $this->assertStringNotContainsString('consolidacaoMapaLegenda', $conteudo);
    }

    #[Test]
    public function multiselect_de_nomes_permanece_editavel_sem_colapso_quantitativo_e_asset_e_versionado(): void
    {
        $view = file_get_contents(resource_path('views/lda/consolidacao/mapa-locais-votacao.blade.php'));
        $javascriptPath = public_path('js/lda-locais-votacao-filtros.js');
        $cssPath = public_path('css/lda-locais-votacao-filtros.css');

        $this->assertIsString($view);
        $this->assertFileExists($javascriptPath);
        $this->assertFileExists($cssPath);
        $javascript = file_get_contents($javascriptPath);
        $css = file_get_contents($cssPath);
        $this->assertIsString($javascript);
        $this->assertIsString($css);
        $this->assertStringContainsString("asset('js/lda-consolidacao-mapa-locais-votacao.js') }}?v={{ filemtime(public_path('js/lda-consolidacao-mapa-locais-votacao.js')) }}", $view);
        $this->assertStringContainsString("asset('js/lda-locais-votacao-filtros.js') }}?v={{ filemtime(public_path('js/lda-locais-votacao-filtros.js')) }}", $view);
        $this->assertStringContainsString('closeOnSelect: false', $javascript);
        $this->assertStringNotContainsString('locais-votacao-nomes-summary-active', $javascript);
        $this->assertStringNotContainsString('locais-votacao-nomes-summary-active', $css);
        $this->assertStringNotContainsString('select2-selection__choice--summary', $javascript);
        $this->assertStringNotContainsString('select2-selection__choice--summary', $css);
        $this->assertStringNotContainsString("select.on('select2:open.locaisVotacaoNomes'", $javascript);
        $this->assertStringNotContainsString("select.on('select2:close.locaisVotacaoNomes'", $javascript);
    }

    #[Test]
    public function javascript_compartilhado_assume_os_filtros_e_o_mapa_mantem_apenas_o_comportamento_cartografico(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-consolidacao-mapa-locais-votacao.js'));
        $compartilhado = file_get_contents(public_path('js/lda-locais-votacao-filtros.js'));

        $this->assertIsString($conteudo);
        $this->assertIsString($compartilhado);
        $this->assertStringContainsString('const payload = window.LDAConsolidacaoMapa || {};', $conteudo);
        $this->assertStringNotContainsString("document.getElementById('filtroZona", $conteudo);
        $this->assertStringNotContainsString('function atualizarSelect2Bairro()', $conteudo);
        $this->assertStringNotContainsString('function atualizarConsultaParametrizada()', $conteudo);
        $this->assertStringContainsString("document.querySelector('[data-locais-votacao-filtros]')", $compartilhado);
        $this->assertStringContainsString("document.getElementById('filtroZona')", $compartilhado);
        $this->assertStringContainsString('function atualizarSelect2Bairro()', $compartilhado);
        $this->assertStringContainsString('function atualizarConsultaParametrizada()', $compartilhado);
        $this->assertStringContainsString('fetch(urlMunicipios + (params.toString()', $compartilhado);
        $this->assertStringContainsString("fetch(urlBairros + '?' + params.toString()", $compartilhado);
        $this->assertStringContainsString('const coresZonaEleitoral = Object.freeze({', $conteudo);
        $this->assertStringContainsString('"1": "#2E7D32"', $conteudo);
        $this->assertStringContainsString('"2": "#F9A825"', $conteudo);
        $this->assertStringContainsString('"3": "#6A1B9A"', $conteudo);
        $this->assertStringContainsString('"4": "#795548"', $conteudo);
        $this->assertStringContainsString('"5": "#827717"', $conteudo);
        $this->assertStringContainsString('"6": "#EF6C00"', $conteudo);
        $this->assertStringContainsString('"7": "#455A64"', $conteudo);
        $this->assertStringContainsString('"8": "#8E24AA"', $conteudo);
        $this->assertStringContainsString('"9": "#689F38"', $conteudo);
        $this->assertStringContainsString('"10": "#C0A000"', $conteudo);
        $this->assertStringContainsString('const corZonaEleitoralFallback = "#616161";', $conteudo);
        $this->assertStringContainsString('function corDoMarcadorPorZona(zona) {', $conteudo);
        $this->assertStringContainsString('const numeroZona = Number.parseInt(String(zona ?? "").replace(/\D+/g, ""), 10);', $conteudo);
        $this->assertStringContainsString('return coresZonaEleitoral[String(numeroZona)] || corZonaEleitoralFallback;', $conteudo);
        $this->assertStringContainsString('function criarIconeLocal(local) {', $conteudo);
        $this->assertStringContainsString('const zonaLabel = String(local.zona || "?").trim() || "?";', $conteudo);
        $this->assertStringContainsString('const corMarcador = corDoMarcadorPorZona(local.zona);', $conteudo);
        $this->assertStringContainsString('style="background:${corMarcador}"', $conteudo);
        $this->assertStringContainsString('className: "rota-marker rota-marker--zona"', $conteudo);
        $this->assertStringContainsString('rota-marker-pin rota-marker-pin--zona', $conteudo);
        $this->assertStringNotContainsString('background:#6b7280', $conteudo);
        $this->assertStringContainsString('const marker = L.marker([latitude, longitude], { icon: criarIconeLocal(local) }).addTo(mapa);', $conteudo);
        $this->assertStringContainsString('mapa.fitBounds(bounds.pad(0.15));', $conteudo);
    }

    #[Test]
    public function css_compartilhado_define_area_do_novo_mapa_e_estilo_do_marcador_zonal(): void
    {
        $conteudo = file_get_contents(public_path('css/lda-mapa.css'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('#consolidacaoMapaLocaisVotacao {', $conteudo);
        $this->assertStringContainsString('.rota-marker--zona {', $conteudo);
        $this->assertStringContainsString('.rota-marker-pin--zona {', $conteudo);
    }

    #[Test]
    public function filtros_do_mapa_podem_ser_recolhidos_por_seta(): void
    {
        $view = file_get_contents(resource_path("views/lda/consolidacao/mapa-locais-votacao.blade.php"));
        $partial = file_get_contents(resource_path('views/lda/partials/locais-votacao-filtros.blade.php'));
        $javascript = file_get_contents(public_path('js/lda-locais-votacao-filtros.js'));
        $css = file_get_contents(public_path('css/lda-locais-votacao-filtros.css'));

        $this->assertIsString($view);
        $this->assertIsString($partial);
        $this->assertStringContainsString('data-locais-votacao-filtros-toggle', $partial);
        $this->assertStringContainsString('aria-controls="locaisVotacaoFiltrosConteudo"', $partial);
        $this->assertStringContainsString('id="locaisVotacaoFiltrosConteudo"', $partial);
        $this->assertStringContainsString('data-locais-votacao-filtros-conteudo', $partial);
        $this->assertStringContainsString('fa-solid fa-chevron-up', $partial);
        $this->assertStringContainsString('function alternarFiltros()', $javascript);
        $this->assertStringContainsString("aria-expanded", $javascript);
        $this->assertStringContainsString("new CustomEvent('locais-votacao:filtros-alternados')", $javascript);
        $this->assertStringContainsString("locais-votacao:filtros-alternados", file_get_contents(public_path('js/lda-consolidacao-mapa-locais-votacao.js')));
        $this->assertStringContainsString('.locais-votacao-filtros-card.is-collapsed', $css);
    }

    #[Test]
    public function badge_sem_coordenadas_abre_modal_com_locais_do_backend(): void
    {
        $view = file_get_contents(resource_path("views/lda/consolidacao/mapa-locais-votacao.blade.php"));

        $this->assertIsString($view);
        $this->assertStringContainsString("data-bs-toggle=\"modal\"", $view);
        $this->assertStringContainsString("data-bs-target=\"#modalMapaLocaisSemCoordenadas\"", $view);
        $this->assertStringContainsString("id=\"modalMapaLocaisSemCoordenadas\"", $view);
        $this->assertStringContainsString("modal-dialog modal-xl modal-dialog-scrollable", $view);
        $this->assertStringContainsString("@forelse((\$locaisSemCoordenadas ?? []) as \$localSemCoordenadas)", $view);
        $this->assertStringContainsString("data_get(\$localSemCoordenadas, \"zona\", \"\")", $view);
        $this->assertStringContainsString("data_get(\$localSemCoordenadas, \"nome\", \"\")", $view);
        $this->assertStringContainsString("Nenhum local sem coordenadas no filtro atual.", $view);
    }

    private function conteudoTelaComFiltros(): string
    {
        $view = file_get_contents(resource_path('views/lda/consolidacao/mapa-locais-votacao.blade.php'));
        $partialPath = resource_path('views/lda/partials/locais-votacao-filtros.blade.php');
        $partial = is_file($partialPath) ? file_get_contents($partialPath) : '';
        $renderizado = is_file($partialPath) ? $this->renderFiltrosMapa() : '';

        return (is_string($view) ? $view : '')
            ."\n".(is_string($partial) ? $partial : '')
            ."\n".$renderizado;
    }

    private function renderFiltrosMapa(): string
    {
        return view('lda.partials.locais-votacao-filtros', [
            'acaoFiltros' => '/lda/consolidacao/mapa-locais-votacao',
            'limparFiltrosUrl' => '/lda/consolidacao/mapa-locais-votacao',
            'camposOcultosFiltros' => ['cod_objeto_local' => 'LV-1'],
            'filtros' => [
                'municipio' => '',
                'bairro' => [],
                'nome_local' => [],
                'area_local' => '',
            ],
            'zonas' => collect(),
            'municipios' => collect(),
            'bairros' => collect(),
            'nomesLocaisOpcoes' => collect(),
        ])->render();
    }
}
```
</TESTS_UNIT_CONSOLIDACAOMAPALOCAISUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DashboardLocaisVotacaoControllerTest.php`
## <TESTS_UNIT_DASHBOARDLOCAISVOTACAOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DashboardLocaisVotacaoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DashboardLocaisVotacaoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_repassa_acl_macroprojeto_e_expoe_resumo_completo(): void
public function test_index_filtra_resumo_totais_e_quadro_por_territorio_autorizado(): void
public function test_drilldown_de_total_urnas_aceita_zona_sem_municipio_e_repassa_acl(): void
public function test_administrador_recebe_link_e_modal_para_editar_percentual_configurado(): void
public function test_drilldown_ajax_mapeia_indicador_pagina_dez_e_repassa_acl(): void
public function test_drilldown_do_total_usa_todo_o_escopo_da_acl_sem_zona_ou_municipio(): void
public function test_drilldown_de_urnas_rurais_repassa_linha_macroprojeto_e_acl(): void
public function test_drilldown_de_urnas_lda_repassa_linha_macroprojeto_e_acl(): void
public function test_drilldown_das_necessidades_calculadas_repassa_contribuintes_e_acl(): void
public function test_drilldown_dos_totais_de_urnas_repassa_composicao_linha_macroprojeto_e_acl(): void
public function test_pdf_resumo_usa_mesmo_escopo_e_formato_a3_paisagem(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\LocaisVotacao\DashboardLocaisVotacaoController;
use App\Http\Requests\LocaisVotacao\DashboardLocaisVotacaoPdfRequest;
use App\Http\Requests\LocaisVotacao\DashboardLocaisVotacaoRequest;
use App\Repositories\LocaisVotacao\DashboardLocaisVotacaoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\LocaisVotacao\DashboardLocaisVotacaoService;
use App\Services\LocaisVotacao\LocalVotacaoListagemService;
use App\Services\LocaisVotacao\LocalVotacaoPdfDadosService;
use App\Support\LocaisVotacao\DashboardLocaisVotacaoFiltro;
use Barryvdh\DomPDF\Facade\Pdf;
use Barryvdh\DomPDF\PDF as DomPdfWrapper;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class DashboardLocaisVotacaoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_repassa_acl_macroprojeto_e_expoe_resumo_completo(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
            'is_admin' => false,
        ]);

        $fatos = collect([
            (object) [
                'zona' => '4',
                'municipio_codigo' => '16',
                'municipio' => 'RIO BRANCO',
                'tip_local' => 1,
                'secoes_fisicas' => 2,
                'secoes_agregadas' => 1,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
        ]);

        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldReceive('listarFatos')->once()->with([4, 9], false, 31)->andReturn($fatos);

        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldNotReceive('listarDashboard');
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);

        $response = $this->controller($dashboardRepository, $localRepository, $listagemService)
            ->index($this->request([]));

        $this->assertSame('lda.consolidacao.dashboard-locais-votacao', $response->name());
        $this->assertSame(3, $response->getData()['resumo']->first()['secoes_totais']);
        $this->assertSame(1, $response->getData()['totais']['locais_convencionais']);
        $this->assertSame(3, $response->getData()['totais']['secoes_totais']);
        $this->assertSame(1, $response->getData()['resumo']->first()['urnas_contingencia_urbana']);
        $this->assertSame([
            ['zona' => '4', 'urnas_total' => 3],
        ], $response->getData()['resumoPorZona']->all());
        $this->assertNull($response->getData()['locais']);
        $this->assertFalse($response->getData()['podeEditarPercentualContingencia']);
        $html = $response->render();
        $this->assertStringContainsString('15,00% (padrão)', $html);
        $this->assertStringNotContainsString('data-percentual-contingencia-link', $html);
        $this->assertStringContainsString('RIO BRANCO', $html);
        $this->assertStringContainsString('Resumo do Total de Urnas por Zona', $html);
        $this->assertStringContainsString('Total geral', $html);
    }

    public function test_index_filtra_resumo_totais_e_quadro_por_territorio_autorizado(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
            'is_admin' => false,
        ]);

        $fatos = collect([
            (object) [
                'zona' => '4',
                'municipio_codigo' => '16',
                'municipio' => 'RIO BRANCO',
                'tip_local' => 1,
                'secoes_fisicas' => 2,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
            (object) [
                'zona' => '4',
                'municipio_codigo' => '17',
                'municipio' => 'BUJARI',
                'tip_local' => 1,
                'secoes_fisicas' => 3,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
            (object) [
                'zona' => '9',
                'municipio_codigo' => '20',
                'municipio' => 'SENA MADUREIRA',
                'tip_local' => 1,
                'secoes_fisicas' => 4,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
        ]);

        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldReceive('listarFatos')->once()->with([4, 9], false, 31)->andReturn($fatos);
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldNotReceive('listarDashboard');

        $response = $this->controller(
            $dashboardRepository,
            $localRepository,
            Mockery::mock(LocalVotacaoListagemService::class)
        )->index($this->request([
            'filtro_zona' => '4',
            'filtro_municipio' => '17',
        ]));

        $dados = $response->getData();
        $this->assertCount(1, $dados['resumo']);
        $this->assertSame('BUJARI', $dados['resumo']->first()['municipio']);
        $this->assertSame(3, $dados['totais']['secoes_fisicas']);
        $this->assertSame([['zona' => '4', 'urnas_total' => 4]], $dados['resumoPorZona']->all());
        $this->assertSame('4', $dados['filtroZonaSelecionado']);
        $this->assertSame('17', $dados['filtroMunicipioSelecionado']);
        $this->assertSame('BUJARI', $dados['filtroMunicipioNome']);
        $this->assertSame(['4', '9'], $dados['zonasFiltro']->all());
        $this->assertSame(['17', '16'], $dados['municipiosFiltro']->pluck('codigo')->all());

        $html = $response->render();
        $this->assertStringContainsString('name="filtro_zona"', $html);
        $this->assertStringContainsString('name="filtro_municipio"', $html);
        $this->assertStringContainsString('filtro_zona=4', $html);
        $this->assertStringContainsString('filtro_municipio=17', $html);
        $this->assertStringContainsString(e(route(
            'lda.consolidacao.dashboard-locais-votacao',
            [
                'filtro_zona' => '4',
                'filtro_municipio' => '17',
                'indicador' => 'locais_convencionais',
                'zona' => '4',
                'municipio' => '17',
            ]
        )), $html);
        $this->assertStringNotContainsString('SENA MADUREIRA', $html);
    }

    public function test_drilldown_de_total_urnas_aceita_zona_sem_municipio_e_repassa_acl(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([], 0, 10, 1, [
            'path' => '/lda/consolidacao/dashboard-locais-votacao',
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                    && $filtro->municipio === null
                    && $filtro->composicaoUrnas === 'total'
                ),
                [4],
                false,
                31,
                10
            )
            ->andReturn($paginador);
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->once()->with($paginador)->andReturn([]);

        $request = $this->request([
            'zona' => '4',
            'indicador' => 'urnas_total',
        ]);
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');
        $response = $this->controller($dashboardRepository, $localRepository, $listagemService)
            ->index($request);

        $this->assertSame('Total Urnas · locais relacionados · Zona 4', $response->getData(true)['titulo']);
    }

    public function test_administrador_recebe_link_e_modal_para_editar_percentual_configurado(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 5],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
            'is_admin' => true,
        ]);

        $fatos = collect([
            (object) [
                'zona' => '4',
                'municipio_codigo' => '16',
                'municipio' => 'RIO BRANCO',
                'tip_local' => 1,
                'secoes_fisicas' => 10,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
                'percentual_urnas_contingencia' => 26.54,
                'percentual_urnas_contingencia_id' => 9,
                'qtd_urna_auditoria' => 12,
            ],
            (object) [
                'zona' => '5',
                'municipio_codigo' => '20',
                'municipio' => 'TARAUACA',
                'tip_local' => 1,
                'secoes_fisicas' => 10,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldReceive('listarFatos')->once()->with([4, 5], false, 31)->andReturn($fatos);
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldNotReceive('listarDashboard');

        $response = $this->controller(
            $dashboardRepository,
            $localRepository,
            Mockery::mock(LocalVotacaoListagemService::class)
        )->index($this->request([]));

        $this->assertTrue($response->getData()['podeEditarPercentualContingencia']);
        $this->assertSame(12, $response->getData()['resumo']->first()['urnas_auditoria']);
        $this->assertSame(25, $response->getData()['resumo']->first()['urnas_total']);
        $html = $response->render();
        $this->assertStringContainsString('26,54%', $html);
        $this->assertStringContainsString('15,00% (padrão)', $html);
        $this->assertStringContainsString('data-percentual-contingencia-link', $html);
        $this->assertStringContainsString('<th scope="col">Auditoria</th>', $html);
        $this->assertStringContainsString(
            route('tabelas-auxiliares.urnas-contingencia-urbana.form', 9),
            $html
        );
        $this->assertStringContainsString(
            e(route('tabelas-auxiliares.urnas-contingencia-urbana.form', [
                'zona' => '5',
                'municipio' => '20',
            ])),
            $html
        );
        $this->assertStringContainsString('modalPercentualContingencia', $html);
    }

    public function test_drilldown_ajax_mapeia_indicador_pagina_dez_e_repassa_acl(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([(object) [
            'cod_objeto' => 'LOCAL-1',
            'cod_objeto_zona' => '4',
            'nom_localidade' => 'RIO BRANCO',
            'num_local' => '1010',
            'nom_local' => 'ESCOLA TESTE',
            'qtd_mesarios_convocados' => 0,
        ]], 11, 10, 2, ['path' => '/lda/consolidacao/dashboard-locais-votacao']);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');

        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                    && $filtro->municipio === '16'
                    && $filtro->areaLocal === 'rural'
                    && $filtro->excluirLda
                ),
                [4],
                false,
                31,
                10
            )
            ->andReturn($paginador);

        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->once()->with($paginador)->andReturn([]);

        $request = $this->request([
            'filtro_zona' => '4',
            'filtro_municipio' => '16',
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'locais_rurais_sem_lda',
            'page' => 2,
        ]);
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');

        $response = $this->controller($dashboardRepository, $localRepository, $listagemService)->index($request);

        $this->assertSame(200, $response->status());
        $this->assertStringContainsString('Locais rurais sem LDA', (string) $response->getData(true)['titulo']);
        $this->assertArrayHasKey('html', $response->getData(true));
        $this->assertStringContainsString('filtro_zona=4', $response->getData(true)['html']);
        $this->assertStringContainsString('filtro_municipio=16', $response->getData(true)['html']);
    }

    public function test_drilldown_do_total_usa_todo_o_escopo_da_acl_sem_zona_ou_municipio(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([], 0, 10, 1, [
            'path' => '/lda/consolidacao/dashboard-locais-votacao',
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === ''
                    && $filtro->municipio === null
                    && $filtro->movimentacaoSecoes === 'alocacao_provisoria'
                ),
                [4, 9],
                false,
                31,
                10
            )
            ->andReturn($paginador);
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->once()->with($paginador)->andReturn([]);

        $request = $this->request([
            'indicador' => 'locais_alocacao_provisoria',
        ]);
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');

        $response = $this->controller($dashboardRepository, $localRepository, $listagemService)->index($request);

        $this->assertSame(200, $response->status());
        $this->assertStringContainsString('alocação provisória', (string) $response->getData(true)['titulo']);
    }

    public function test_drilldown_de_urnas_rurais_repassa_linha_macroprojeto_e_acl(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([], 0, 10, 1, [
            'path' => '/lda/consolidacao/dashboard-locais-votacao',
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                    && $filtro->municipio === '16'
                    && $filtro->urnasContingenciaZonaRural
                ),
                [4, 9],
                false,
                31,
                10
            )
            ->andReturn($paginador);
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->once()->with($paginador)->andReturn([]);

        $request = $this->request([
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'urnas_contingencia_zona_rural',
        ]);
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');

        $response = $this->controller($dashboardRepository, $localRepository, $listagemService)->index($request);

        $this->assertSame(200, $response->status());
        $this->assertStringContainsString('Urnas de contingência rural sem LDA', (string) $response->getData(true)['titulo']);
    }

    public function test_drilldown_de_urnas_lda_repassa_linha_macroprojeto_e_acl(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([], 0, 10, 1, [
            'path' => '/lda/consolidacao/dashboard-locais-votacao',
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                    && $filtro->municipio === '16'
                    && $filtro->urnasContingenciaLda
                ),
                [4, 9],
                false,
                31,
                10
            )
            ->andReturn($paginador);
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->once()->with($paginador)->andReturn([]);

        $request = $this->request([
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'urnas_contingencia_lda',
        ]);
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');

        $response = $this->controller($dashboardRepository, $localRepository, $listagemService)->index($request);

        $this->assertSame(200, $response->status());
        $this->assertStringContainsString('Urnas de contingência LDA', (string) $response->getData(true)['titulo']);
    }

    public function test_drilldown_das_necessidades_calculadas_repassa_contribuintes_e_acl(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([], 0, 10, 1, [
            'path' => '/lda/consolidacao/dashboard-locais-votacao',
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                    && $filtro->municipio === '16'
                    && $filtro->areaLocal === 'urbana'
                    && $filtro->somenteComSecoes
                    && ! $filtro->semCoberturaUrnasContingencia
                ),
                [4, 9],
                false,
                31,
                10
            )
            ->andReturn($paginador);
        $localRepository->shouldReceive('listarDashboard')
            ->once()
            ->with(
                Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                    && $filtro->municipio === '16'
                    && $filtro->areaLocal === 'rural'
                    && $filtro->excluirLda
                    && $filtro->somenteComSecoes
                    && $filtro->semCoberturaUrnasContingencia
                ),
                [4, 9],
                false,
                31,
                10
            )
            ->andReturn($paginador);
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->twice()->with($paginador)->andReturn([]);

        $urbana = $this->request([
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'urnas_contingencia_urbana',
        ]);
        $urbana->headers->set('X-Requested-With', 'XMLHttpRequest');
        $rural = $this->request([
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'urnas_contingencia_rural_sem_cobertura',
        ]);
        $rural->headers->set('X-Requested-With', 'XMLHttpRequest');

        $responseUrbana = $this->controller($dashboardRepository, $localRepository, $listagemService)->index($urbana);
        $responseRural = $this->controller($dashboardRepository, $localRepository, $listagemService)->index($rural);

        $this->assertSame(200, $responseUrbana->status());
        $this->assertSame(200, $responseRural->status());
        $this->assertStringContainsString('UC URBANA', (string) $responseUrbana->getData(true)['titulo']);
        $this->assertStringContainsString('UC RURAL SC', (string) $responseRural->getData(true)['titulo']);
    }

    public function test_drilldown_dos_totais_de_urnas_repassa_composicao_linha_macroprojeto_e_acl(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $paginador = new LengthAwarePaginator([], 0, 10, 1, [
            'path' => '/lda/consolidacao/dashboard-locais-votacao',
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        foreach (['contingencia', 'total'] as $composicao) {
            $localRepository->shouldReceive('listarDashboard')
                ->once()
                ->with(
                    Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4'
                        && $filtro->municipio === '16'
                        && $filtro->composicaoUrnas === $composicao
                    ),
                    [4, 9],
                    false,
                    31,
                    10
                )
                ->andReturn($paginador);
        }
        $listagemService = Mockery::mock(LocalVotacaoListagemService::class);
        $listagemService->shouldReceive('preparar')->twice()->with($paginador)->andReturn([]);

        foreach ([
            'urnas_contingencia_total' => 'Total Contingência',
            'urnas_total' => 'Total Urnas',
        ] as $indicador => $titulo) {
            $request = $this->request([
                'zona' => '4',
                'municipio' => '16',
                'indicador' => $indicador,
            ]);
            $request->headers->set('X-Requested-With', 'XMLHttpRequest');

            $response = $this->controller(
                $dashboardRepository,
                $localRepository,
                $listagemService
            )->index($request);

            $this->assertSame(200, $response->status());
            $this->assertStringContainsString($titulo, (string) $response->getData(true)['titulo']);
        }
    }

    public function test_pdf_resumo_usa_mesmo_escopo_e_formato_a3_paisagem(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $fatos = collect([
            (object) [
                'zona' => '4',
                'municipio_codigo' => '16',
                'municipio' => 'RIO BRANCO',
                'tip_local' => 1,
                'secoes_fisicas' => 2,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
            (object) [
                'zona' => '4',
                'municipio_codigo' => '17',
                'municipio' => 'BUJARI',
                'tip_local' => 1,
                'secoes_fisicas' => 3,
                'secoes_agregadas' => 0,
                'possui_lda' => 0,
                'zona_rural' => 0,
                'tempo_classificacao' => 'ATE_1H',
            ],
        ]);
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldReceive('listarFatos')->once()->with([4], false, 31)->andReturn($fatos);
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldNotReceive('listarTodosDashboard');
        $pdfDados = Mockery::mock(LocalVotacaoPdfDadosService::class);

        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('setPaper')->once()->with('a3', 'landscape')->andReturnSelf();
        $pdf->shouldReceive('stream')->once()->with('dashboard-locais-votacao-resumo.pdf')->andReturn(response('pdf-resumo'));
        Pdf::shouldReceive('loadView')
            ->once()
            ->with('lda.consolidacao.dashboard-locais-votacao-pdf', Mockery::on(
                static fn (array $dados): bool => $dados['campos'] === ['zona', 'municipio']
                    && $dados['resumo']->count() === 1
                    && $dados['resumo']->first()['municipio_codigo'] === '16'
                    && $dados['totais']['secoes_fisicas'] === 2
                    && $dados['filtrosAtivos'] === [
                        'Zona' => '4',
                        'Município' => 'RIO BRANCO',
                    ]
            ))
            ->andReturn($pdf);

        $controller = new DashboardLocaisVotacaoController(
            $dashboardRepository,
            $localRepository,
            new DashboardLocaisVotacaoService,
            Mockery::mock(LocalVotacaoListagemService::class),
            $pdfDados
        );

        $response = $controller->exportarPdf($this->pdfRequest([
            'modo' => 'resumo',
            'campos' => ['zona', 'municipio'],
            'filtro_zona' => '4',
            'filtro_municipio' => '16',
        ]));

        $this->assertSame('pdf-resumo', $response->getContent());
    }

    public function test_pdf_detalhe_reaplica_indicador_acl_e_formato_a4_paisagem(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $locais = collect();
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarTodosDashboard')->once()->with(
            Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === '4' && $filtro->municipio === '16' && $filtro->somenteLda
            ),
            [4],
            false,
            31
        )->andReturn($locais);

        $pdfDados = Mockery::mock(LocalVotacaoPdfDadosService::class);
        $pdfDados->shouldReceive('preparar')->once()->with($locais, [4], false)->andReturn([
            'locais' => $locais,
            'mesariosPorLocal' => [],
            'secoesPorLocal' => [],
        ]);

        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('setPaper')->once()->with('a4', 'landscape')->andReturnSelf();
        $pdf->shouldReceive('stream')->once()->with('dashboard-locais-votacao-detalhamento.pdf')->andReturn(response('pdf-detalhe'));
        Pdf::shouldReceive('loadView')
            ->once()
            ->with('lda.locais-votacao.pdf', Mockery::on(static fn (array $dados): bool => $dados['campos'] === ['zona']
                && $dados['mostrarResumo'] === false
                && $dados['titulo'] === 'Locais LDA'
            ))
            ->andReturn($pdf);

        $controller = new DashboardLocaisVotacaoController(
            $dashboardRepository,
            $localRepository,
            new DashboardLocaisVotacaoService,
            Mockery::mock(LocalVotacaoListagemService::class),
            $pdfDados
        );

        $response = $controller->exportarPdf($this->pdfRequest([
            'modo' => 'detalhe',
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'locais_lda',
            'campos' => ['zona'],
        ]));

        $this->assertSame('pdf-detalhe', $response->getContent());
    }

    public function test_pdf_detalhe_do_total_reaplica_acl_sem_filtro_territorial(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 31,
        ]);

        $locais = collect();
        $dashboardRepository = Mockery::mock(DashboardLocaisVotacaoRepository::class);
        $dashboardRepository->shouldNotReceive('listarFatos');
        $localRepository = Mockery::mock(LocalVotacaoRepository::class);
        $localRepository->shouldReceive('listarTodosDashboard')->once()->with(
            Mockery::on(static fn (DashboardLocaisVotacaoFiltro $filtro): bool => $filtro->zona === ''
                && $filtro->municipio === null
                && $filtro->urnasContingenciaZonaRural
            ),
            [4, 9],
            false,
            31
        )->andReturn($locais);

        $pdfDados = Mockery::mock(LocalVotacaoPdfDadosService::class);
        $pdfDados->shouldReceive('preparar')->once()->with($locais, [4, 9], false)->andReturn([
            'locais' => $locais,
            'mesariosPorLocal' => [],
            'secoesPorLocal' => [],
        ]);
        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('setPaper')->once()->with('a4', 'landscape')->andReturnSelf();
        $pdf->shouldReceive('stream')->once()->with('dashboard-locais-votacao-detalhamento.pdf')->andReturn(response('pdf-total'));
        Pdf::shouldReceive('loadView')
            ->once()
            ->with('lda.locais-votacao.pdf', Mockery::on(static fn (array $dados): bool => $dados['filtros']['zona'] === ''
                && $dados['titulo'] === 'Urnas de contingência rural sem LDA'
            ))
            ->andReturn($pdf);

        $controller = new DashboardLocaisVotacaoController(
            $dashboardRepository,
            $localRepository,
            new DashboardLocaisVotacaoService,
            Mockery::mock(LocalVotacaoListagemService::class),
            $pdfDados
        );

        $response = $controller->exportarPdf($this->pdfRequest([
            'modo' => 'detalhe',
            'indicador' => 'urnas_contingencia_zona_rural',
            'campos' => ['zona'],
        ]));

        $this->assertSame('pdf-total', $response->getContent());
    }

    private function controller(
        DashboardLocaisVotacaoRepository $dashboardRepository,
        LocalVotacaoRepository $localRepository,
        LocalVotacaoListagemService $listagemService
    ): DashboardLocaisVotacaoController {
        return new DashboardLocaisVotacaoController(
            $dashboardRepository,
            $localRepository,
            new DashboardLocaisVotacaoService,
            $listagemService,
            Mockery::mock(\App\Services\LocaisVotacao\LocalVotacaoPdfDadosService::class)
        );
    }

    /** @param array<string, mixed> $query */
    private function request(array $query): DashboardLocaisVotacaoRequest
    {
        $request = DashboardLocaisVotacaoRequest::create('/lda/consolidacao/dashboard-locais-votacao', 'GET', $query);
        $request->setContainer($this->app);
        $request->setRedirector($this->app->make('redirect'));
        $request->validateResolved();

        return $request;
    }

    /** @param array<string, mixed> $query */
    private function pdfRequest(array $query): DashboardLocaisVotacaoPdfRequest
    {
        $request = DashboardLocaisVotacaoPdfRequest::create('/lda/consolidacao/dashboard-locais-votacao/exportar-pdf', 'GET', $query);
        $request->setContainer($this->app);
        $request->setRedirector($this->app->make('redirect'));
        $request->validateResolved();

        return $request;
    }
}
```
</TESTS_UNIT_DASHBOARDLOCAISVOTACAOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DashboardLocaisVotacaoIdentidadesQueryTest.php`
## <TESTS_UNIT_DASHBOARDLOCAISVOTACAOIDENTIDADESQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DashboardLocaisVotacaoIdentidadesQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DashboardLocaisVotacaoIdentidadesQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('dashboard_identidades_teste', function (Blueprint $table): void {
DB::table('dashboard_identidades_teste')->insert([
return DB::table('dashboard_identidades_teste')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_une_conjuntos_de_contingencia_e_total_de_urnas_sem_duplicidade(): void
private function consulta(string $conjunto): \Illuminate\Database\Query\Builder
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\DashboardLocaisVotacaoIdentidadesQuery;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class DashboardLocaisVotacaoIdentidadesQueryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('dashboard_identidades_teste', function (Blueprint $table): void {
            $table->string('cod_objeto');
            $table->string('conjunto');
        });

        DB::table('dashboard_identidades_teste')->insert([
            ['cod_objeto' => 'ORIGEM-RURAL', 'conjunto' => 'ROTAS'],
            ['cod_objeto' => 'MEMBRO-OUTRO-MUNICIPIO', 'conjunto' => 'ROTAS'],
            ['cod_objeto' => 'COMPARTILHADO', 'conjunto' => 'ROTAS'],
            ['cod_objeto' => 'COMPARTILHADO', 'conjunto' => 'URBANA'],
            ['cod_objeto' => 'URBANO', 'conjunto' => 'URBANA'],
            ['cod_objeto' => 'RURAL-SC', 'conjunto' => 'RURAL_SC'],
            ['cod_objeto' => 'URBANO', 'conjunto' => 'FISICAS'],
            ['cod_objeto' => 'SOMENTE-FISICAS', 'conjunto' => 'FISICAS'],
        ]);
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('dashboard_identidades_teste');

        parent::tearDown();
    }

    public function test_une_conjuntos_de_contingencia_e_total_de_urnas_sem_duplicidade(): void
    {
        $rotas = $this->consulta('ROTAS');
        $urbana = $this->consulta('URBANA');
        $ruralSemCobertura = $this->consulta('RURAL_SC');

        $contingencia = DashboardLocaisVotacaoIdentidadesQuery::unir([
            $rotas,
            $urbana,
            $ruralSemCobertura,
        ])->pluck('cod_objeto')->sort()->values()->all();

        $totalUrnas = DashboardLocaisVotacaoIdentidadesQuery::unir([
            $this->consulta('ROTAS'),
            $this->consulta('URBANA'),
            $this->consulta('RURAL_SC'),
            $this->consulta('FISICAS'),
        ])->pluck('cod_objeto')->sort()->values()->all();

        $this->assertSame([
            'COMPARTILHADO',
            'MEMBRO-OUTRO-MUNICIPIO',
            'ORIGEM-RURAL',
            'RURAL-SC',
            'URBANO',
        ], $contingencia);
        $this->assertSame([
            'COMPARTILHADO',
            'MEMBRO-OUTRO-MUNICIPIO',
            'ORIGEM-RURAL',
            'RURAL-SC',
            'SOMENTE-FISICAS',
            'URBANO',
        ], $totalUrnas);
    }

    private function consulta(string $conjunto): \Illuminate\Database\Query\Builder
    {
        return DB::table('dashboard_identidades_teste')
            ->where('conjunto', $conjunto)
            ->select('cod_objeto');
    }
}
```
</TESTS_UNIT_DASHBOARDLOCAISVOTACAOIDENTIDADESQUERYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DashboardLocaisVotacaoPdfViewTest.php`
## <TESTS_UNIT_DASHBOARDLOCAISVOTACAOPDFVIEWTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DashboardLocaisVotacaoPdfViewTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DashboardLocaisVotacaoPdfViewTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_formata_percentual_aplicado_configurado_e_padrao_sem_totaliza_lo(): void
public function test_exibe_e_totaliza_urnas_de_auditoria(): void
public function test_identifica_filtros_territoriais_ativos_no_cabecalho(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class DashboardLocaisVotacaoPdfViewTest extends TestCase
{
    public function test_formata_percentual_aplicado_configurado_e_padrao_sem_totaliza_lo(): void
    {
        $resumo = collect([
            [
                'zona' => '4',
                'municipio' => 'RIO BRANCO',
                'percentual_urnas_contingencia' => 26.54,
                'percentual_urnas_contingencia_padrao' => false,
            ],
            [
                'zona' => '5',
                'municipio' => 'TARAUACA',
                'percentual_urnas_contingencia' => 15.0,
                'percentual_urnas_contingencia_padrao' => true,
            ],
        ]);

        $html = view('lda.consolidacao.dashboard-locais-votacao-pdf', [
            'resumo' => $resumo,
            'totais' => [],
            'campos' => ['zona', 'municipio', 'percentual_urnas_contingencia'],
            'rotulos' => [
                'zona' => 'Zona',
                'municipio' => 'Município',
                'percentual_urnas_contingencia' => 'Percentual aplicado',
            ],
            'geradoEm' => '31/07/2026 12:00',
        ])->render();

        $this->assertStringContainsString('26,54%', $html);
        $this->assertStringContainsString('15,00% (padrão)', $html);
        $this->assertStringContainsString('Total geral', $html);
        $this->assertSame(1, substr_count($html, '26,54%'));
        $this->assertSame(1, substr_count($html, '15,00% (padrão)'));
    }

    public function test_exibe_e_totaliza_urnas_de_auditoria(): void
    {
        $html = view('lda.consolidacao.dashboard-locais-votacao-pdf', [
            'resumo' => collect([
                ['zona' => '1', 'municipio' => 'RIO BRANCO', 'urnas_auditoria' => 12],
                ['zona' => '4', 'municipio' => 'CRUZEIRO DO SUL', 'urnas_auditoria' => 4],
            ]),
            'totais' => ['urnas_auditoria' => 16],
            'campos' => ['zona', 'municipio', 'urnas_auditoria'],
            'rotulos' => [
                'zona' => 'Zona',
                'municipio' => 'Município',
                'urnas_auditoria' => 'Urnas de auditoria',
            ],
            'geradoEm' => '31/07/2026 12:00',
        ])->render();

        $this->assertStringContainsString('Urnas de auditoria', $html);
        $this->assertMatchesRegularExpression('/<td[^>]*>\s*12\s*<\/td>/', $html);
        $this->assertMatchesRegularExpression('/<td[^>]*>\s*4\s*<\/td>/', $html);
        $this->assertMatchesRegularExpression('/<td[^>]*>\s*16\s*<\/td>/', $html);
    }

    public function test_identifica_filtros_territoriais_ativos_no_cabecalho(): void
    {
        $html = view('lda.consolidacao.dashboard-locais-votacao-pdf', [
            'resumo' => collect(),
            'totais' => [],
            'campos' => ['zona', 'municipio'],
            'rotulos' => ['zona' => 'Zona', 'municipio' => 'Município'],
            'filtrosAtivos' => [
                'Zona' => '4',
                'Município' => 'RIO BRANCO',
            ],
            'geradoEm' => '02/09/2026 12:00',
        ])->render();

        $this->assertStringContainsString('Zona: 4', $html);
        $this->assertStringContainsString('Município: RIO BRANCO', $html);
    }
}
```
</TESTS_UNIT_DASHBOARDLOCAISVOTACAOPDFVIEWTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DashboardLocaisVotacaoRequestTest.php`
## <TESTS_UNIT_DASHBOARDLOCAISVOTACAOREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DashboardLocaisVotacaoRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DashboardLocaisVotacaoRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_aceita_drilldown_valido_e_rejeita_indicador_forjado(): void
public function test_valida_filtros_territoriais_do_resumo_e_rejeita_municipio_sem_zona(): void
public function test_pdf_aceita_somente_modos_e_campos_de_array_esperados(): void
public function test_aceita_metrica_total_sem_zona_e_preserva_travas_territoriais(): void
public function test_aceita_todos_os_indicadores_totalizaveis_por_zona_sem_municipio(): void
public function test_pdf_resumo_disponibiliza_e_preseleciona_locais_sem_secoes(): void
public function test_pdf_resumo_disponibiliza_e_preseleciona_alocacao_provisoria(): void
public function test_pdf_resumo_disponibiliza_e_preseleciona_urnas_de_contingencia_por_categoria(): void
public function test_pdf_detalhado_aceita_metrica_total_sem_zona(): void
private function falhaValidacao(DashboardLocaisVotacaoRequest $request, array $dados): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\LocaisVotacao\DashboardLocaisVotacaoPdfRequest;
use App\Http\Requests\LocaisVotacao\DashboardLocaisVotacaoRequest;
use App\Support\LocaisVotacao\DashboardLocaisVotacaoIndicador;
use App\Support\LocaisVotacao\Exportacao\LocalVotacaoCamposPdf;
use Illuminate\Support\Facades\Validator;
use Tests\TestCase;

class DashboardLocaisVotacaoRequestTest extends TestCase
{
    public function test_aceita_drilldown_valido_e_rejeita_indicador_forjado(): void
    {
        $request = new DashboardLocaisVotacaoRequest;

        $valido = Validator::make([
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'locais_rurais_sem_lda',
            'page' => '2',
        ], $request->rules());
        $invalido = Validator::make([
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'sql_livre',
        ], $request->rules());

        $this->assertFalse($valido->fails());
        $this->assertTrue($invalido->fails());
    }

    public function test_valida_filtros_territoriais_do_resumo_e_rejeita_municipio_sem_zona(): void
    {
        $request = new DashboardLocaisVotacaoRequest;

        $this->assertFalse($this->falhaValidacao($request, [
            'filtro_zona' => '4',
        ]));
        $this->assertFalse($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'filtro_zona' => '4',
            'filtro_municipio' => '16',
        ]));
        $this->assertTrue($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'filtro_municipio' => '16',
        ]));
        $this->assertTrue($this->falhaValidacao(new DashboardLocaisVotacaoPdfRequest, [
            'modo' => 'resumo',
            'filtro_municipio' => '16',
        ]));
        $this->assertTrue($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'filtro_zona' => '0',
        ]));
        $this->assertTrue($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'filtro_zona' => 'zona-livre',
        ]));
    }

    public function test_pdf_aceita_somente_modos_e_campos_de_array_esperados(): void
    {
        $request = new DashboardLocaisVotacaoPdfRequest;

        $this->assertFalse(Validator::make([
            'modo' => 'detalhe',
            'zona' => '4',
            'municipio' => '16',
            'indicador' => 'locais_urbanos',
            'campos' => ['zona', 'municipio'],
        ], $request->rules())->fails());

        $this->assertTrue(Validator::make([
            'modo' => 'planilha',
            'campos' => 'zona',
        ], $request->rules())->fails());
    }

    public function test_aceita_metrica_total_sem_zona_e_preserva_travas_territoriais(): void
    {
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::LOCAIS_CONVENCIONAIS,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::LOCAIS_SEM_SECOES,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::LOCAIS_ALOCACAO_PROVISORIA,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_ZONA_RURAL,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_LDA,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_URBANA,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_RURAL_SEM_COBERTURA,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_TOTAL,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertContains(
            DashboardLocaisVotacaoIndicador::URNAS_TOTAL,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertNotContains(
            DashboardLocaisVotacaoIndicador::ZONA,
            DashboardLocaisVotacaoIndicador::totalizaveis()
        );
        $this->assertFalse($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'indicador' => DashboardLocaisVotacaoIndicador::LOCAIS_RURAIS,
        ]));
        $this->assertTrue($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'indicador' => DashboardLocaisVotacaoIndicador::ZONA,
        ]));
        $this->assertTrue($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
            'municipio' => '16',
            'indicador' => DashboardLocaisVotacaoIndicador::LOCAIS_RURAIS,
        ]));
    }

    public function test_aceita_todos_os_indicadores_totalizaveis_por_zona_sem_municipio(): void
    {
        foreach (DashboardLocaisVotacaoIndicador::totalizaveis() as $indicador) {
            $this->assertTrue(
                DashboardLocaisVotacaoIndicador::permiteEscopoZonaSemMunicipio($indicador),
                $indicador
            );
            $this->assertFalse($this->falhaValidacao(new DashboardLocaisVotacaoRequest, [
                'zona' => '4',
                'indicador' => $indicador,
            ]), $indicador);
            $this->assertFalse($this->falhaValidacao(new DashboardLocaisVotacaoPdfRequest, [
                'modo' => 'detalhe',
                'zona' => '4',
                'indicador' => $indicador,
                'campos' => ['zona', 'municipio'],
            ]), $indicador);
        }
    }

    public function test_pdf_resumo_disponibiliza_e_preseleciona_locais_sem_secoes(): void
    {
        $this->assertSame(
            'Locais sem seções',
            LocalVotacaoCamposPdf::resumoDisponiveis()['locais_sem_secoes']
        );
        $this->assertContains('locais_sem_secoes', LocalVotacaoCamposPdf::resumoPadrao());
    }

    public function test_pdf_resumo_disponibiliza_e_preseleciona_alocacao_provisoria(): void
    {
        $disponiveis = LocalVotacaoCamposPdf::resumoDisponiveis();

        $this->assertSame(
            'Locais de destino com alocação provisória',
            $disponiveis['locais_alocacao_provisoria']
        );
        $this->assertSame(
            'Seções físicas em alocação provisória',
            $disponiveis['secoes_fisicas_alocacao_provisoria']
        );
        $this->assertContains('locais_alocacao_provisoria', LocalVotacaoCamposPdf::resumoPadrao());
        $this->assertContains('secoes_fisicas_alocacao_provisoria', LocalVotacaoCamposPdf::resumoPadrao());
    }

    public function test_pdf_resumo_disponibiliza_e_preseleciona_urnas_de_contingencia_por_categoria(): void
    {
        $this->assertSame(
            'UC RURAL',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_contingencia_zona_rural']
        );
        $this->assertSame(
            'UC LDA',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_contingencia_lda']
        );
        $this->assertSame(
            'Percentual aplicado',
            LocalVotacaoCamposPdf::resumoDisponiveis()['percentual_urnas_contingencia']
        );
        $this->assertSame(
            'UC URBANA',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_contingencia_urbana']
        );
        $this->assertSame(
            'UC RURAL SC',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_contingencia_rural_sem_cobertura']
        );
        $this->assertSame(
            'Total Contingência',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_contingencia_total']
        );
        $this->assertSame(
            'Urnas de auditoria',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_auditoria']
        );
        $this->assertSame(
            'Total Urnas',
            LocalVotacaoCamposPdf::resumoDisponiveis()['urnas_total']
        );
        $this->assertContains(
            'urnas_contingencia_zona_rural',
            LocalVotacaoCamposPdf::resumoPadrao()
        );
        $this->assertContains(
            'urnas_contingencia_lda',
            LocalVotacaoCamposPdf::resumoPadrao()
        );
        $this->assertContains(
            'percentual_urnas_contingencia',
            LocalVotacaoCamposPdf::resumoPadrao()
        );
        $this->assertContains(
            'urnas_contingencia_urbana',
            LocalVotacaoCamposPdf::resumoPadrao()
        );
        $this->assertContains(
            'urnas_contingencia_rural_sem_cobertura',
            LocalVotacaoCamposPdf::resumoPadrao()
        );
        $this->assertContains('urnas_contingencia_total', LocalVotacaoCamposPdf::resumoPadrao());
        $this->assertContains('urnas_auditoria', LocalVotacaoCamposPdf::resumoPadrao());
        $this->assertContains('urnas_total', LocalVotacaoCamposPdf::resumoPadrao());
    }

    public function test_pdf_detalhado_aceita_metrica_total_sem_zona(): void
    {
        foreach ([
            DashboardLocaisVotacaoIndicador::TEMPO_ATE_1H,
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_URBANA,
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_RURAL_SEM_COBERTURA,
            DashboardLocaisVotacaoIndicador::URNAS_CONTINGENCIA_TOTAL,
            DashboardLocaisVotacaoIndicador::URNAS_TOTAL,
        ] as $indicador) {
            $this->assertFalse($this->falhaValidacao(new DashboardLocaisVotacaoPdfRequest, [
                'modo' => 'detalhe',
                'indicador' => $indicador,
                'campos' => ['zona', 'municipio'],
            ]), $indicador);
        }
    }

    /** @param array<string, mixed> $dados */
    private function falhaValidacao(DashboardLocaisVotacaoRequest $request, array $dados): bool
    {
        $request->merge($dados);
        $validator = Validator::make($dados, $request->rules());
        $request->withValidator($validator);

        return $validator->fails();
    }
}
```
</TESTS_UNIT_DASHBOARDLOCAISVOTACAOREQUESTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DashboardLocaisVotacaoServiceTest.php`
## <TESTS_UNIT_DASHBOARDLOCAISVOTACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DashboardLocaisVotacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DashboardLocaisVotacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_agrupa_metricas_por_zona_e_municipio_com_as_definicoes_canonicas(): void
public function test_filtra_resumo_por_zona_e_municipio_sem_ampliar_combinacao_inexistente(): void
public function test_tempo_exatamente_uma_hora_pertence_ao_grupo_ate_uma_hora(): void
public function test_calcula_necessidade_de_urnas_apos_somar_a_linha_e_arredonda_para_cima(): void
public function test_aplica_percentual_configurado_nas_duas_necessidades_e_totais_de_cruzeiro_do_sul(): void
public function test_usa_quinze_por_cento_como_padrao_quando_cadastro_esta_ausente(): void
public function test_percentual_zero_configurado_e_valido_e_nao_aciona_fallback(): void
public function test_atribui_urnas_de_auditoria_uma_vez_por_linha_e_soma_ao_total_de_urnas(): void
public function test_necessidade_calculada_fica_zero_sem_secoes_e_total_soma_inteiros_das_linhas(): void
public function test_totaliza_todas_as_metricas_aditivas_do_resumo(): void
public function test_resume_total_de_urnas_por_zona_somando_as_linhas_e_ordenando_numericamente(): void
public function test_mapeia_cada_indicador_para_o_filtro_canonico(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\LocaisVotacao\DashboardLocaisVotacaoService;
use App\Support\LocaisVotacao\LocalVotacaoTempoDeslocamentoQuery;
use Illuminate\Support\Collection;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

class DashboardLocaisVotacaoServiceTest extends TestCase
{
    public function test_agrupa_metricas_por_zona_e_municipio_com_as_definicoes_canonicas(): void
    {
        $fatos = collect([
            $this->fato('LV-1', '4', '16', 'RIO BRANCO', 1, 2, 1, false, false, 'ATE_1H', 2, 7),
            $this->fato('LV-2', '4', '16', 'RIO BRANCO', 3, 0, 0, true, true, 'MAIS_1H', 0, 4),
            $this->fato('LV-3', '4', '16', 'RIO BRANCO', 1, 1, 0, false, true, 'SEM_INFO_APROVEITAVEL', 0, 2),
            $this->fato('LV-4', '5', '20', 'CRUZEIRO DO SUL', 1, 1, 2, false, false, 'ATE_1H', 1, 5),
        ]);

        $linhas = (new DashboardLocaisVotacaoService)->resumir($fatos);

        $this->assertInstanceOf(Collection::class, $linhas);
        $this->assertCount(2, $linhas);

        $rioBranco = $linhas->firstWhere('municipio_codigo', '16');
        $this->assertSame('4', $rioBranco['zona']);
        $this->assertSame(2, $rioBranco['locais_convencionais']);
        $this->assertSame(1, $rioBranco['locais_preso_provisorio']);
        $this->assertSame(2, $rioBranco['locais_com_secoes']);
        $this->assertSame(1, $rioBranco['locais_sem_secoes']);
        $this->assertSame(1, $rioBranco['locais_alocacao_provisoria']);
        $this->assertSame(2, $rioBranco['secoes_fisicas_alocacao_provisoria']);
        $this->assertSame(3, $rioBranco['secoes_fisicas']);
        $this->assertSame(1, $rioBranco['secoes_agregadas']);
        $this->assertSame(4, $rioBranco['secoes_totais']);
        $this->assertSame(1, $rioBranco['locais_urbanos']);
        $this->assertSame(2, $rioBranco['secoes_fisicas_urbanas']);
        $this->assertSame(2, $rioBranco['locais_rurais']);
        $this->assertSame(1, $rioBranco['secoes_fisicas_rurais']);
        $this->assertSame(1, $rioBranco['locais_rurais_sem_lda']);
        $this->assertSame(1, $rioBranco['secoes_fisicas_rurais_sem_lda']);
        $this->assertSame(1, $rioBranco['locais_lda']);
        $this->assertSame(0, $rioBranco['secoes_fisicas_lda']);
        $this->assertSame(1, $rioBranco['tempo_ate_1h']);
        $this->assertSame(1, $rioBranco['tempo_mais_1h']);
        $this->assertSame(1, $rioBranco['tempo_sem_info']);
        $this->assertSame(2, $rioBranco['urnas_contingencia_zona_rural']);
        $this->assertSame(4, $rioBranco['urnas_contingencia_lda']);
        $this->assertSame(1, $rioBranco['urnas_contingencia_urbana']);
        $this->assertSame(1, $rioBranco['urnas_contingencia_rural_sem_cobertura']);
        $this->assertSame(8, $rioBranco['urnas_contingencia_total']);
        $this->assertSame(11, $rioBranco['urnas_total']);
        $this->assertSame(
            $rioBranco['urnas_contingencia_zona_rural']
                + $rioBranco['urnas_contingencia_lda']
                + $rioBranco['urnas_contingencia_urbana']
                + $rioBranco['urnas_contingencia_rural_sem_cobertura'],
            $rioBranco['urnas_contingencia_total']
        );
        $this->assertSame(
            $rioBranco['secoes_fisicas'] + $rioBranco['urnas_contingencia_total'],
            $rioBranco['urnas_total']
        );
        $this->assertSame(
            6,
            $rioBranco['urnas_contingencia_zona_rural'] + $rioBranco['urnas_contingencia_lda']
        );
        $this->assertSame(
            $rioBranco['secoes_fisicas'] + $rioBranco['secoes_agregadas'],
            $rioBranco['secoes_totais']
        );
        $this->assertLessThanOrEqual($rioBranco['locais_rurais'], $rioBranco['locais_rurais_sem_lda']);
    }

    public function test_filtra_resumo_por_zona_e_municipio_sem_ampliar_combinacao_inexistente(): void
    {
        $service = new DashboardLocaisVotacaoService;
        $resumo = $service->resumir(collect([
            $this->fato('LV-1', '4', '16', 'RIO BRANCO', 1, 2, 0, false, false, 'ATE_1H'),
            $this->fato('LV-2', '4', '17', 'BUJARI', 1, 3, 0, false, false, 'ATE_1H'),
            $this->fato('LV-3', '9', '20', 'SENA MADUREIRA', 1, 4, 0, false, false, 'ATE_1H'),
        ]));

        $this->assertCount(3, $service->filtrarPorTerritorio($resumo, ''));

        $zona = $service->filtrarPorTerritorio($resumo, '4');
        $this->assertCount(2, $zona);
        $this->assertSame(5, $service->totalizar($zona)['secoes_fisicas']);
        $this->assertSame(['4'], $service->resumirTotalUrnasPorZona($zona)->pluck('zona')->all());

        $municipio = $service->filtrarPorTerritorio($resumo, '4', '17');
        $this->assertCount(1, $municipio);
        $this->assertSame('BUJARI', $municipio->first()['municipio']);
        $this->assertTrue($service->filtrarPorTerritorio($resumo, '4', '20')->isEmpty());
        $this->assertTrue($service->filtrarPorTerritorio($resumo, '', '16')->isEmpty());
    }

    public function test_tempo_exatamente_uma_hora_pertence_ao_grupo_ate_uma_hora(): void
    {
        $this->assertSame('ATE_1H', LocalVotacaoTempoDeslocamentoQuery::classificar(1.0, 'MAIS_1H'));
        $this->assertSame('MAIS_1H', LocalVotacaoTempoDeslocamentoQuery::classificar(1.01, 'ATE_1H'));
        $this->assertSame('ATE_1H', LocalVotacaoTempoDeslocamentoQuery::classificar(null, 'ATE_1H'));
        $this->assertSame('SEM_INFO_APROVEITAVEL', LocalVotacaoTempoDeslocamentoQuery::classificar(null, null));
    }

    public function test_calcula_necessidade_de_urnas_apos_somar_a_linha_e_arredonda_para_cima(): void
    {
        $linha = (new DashboardLocaisVotacaoService)->resumir(collect([
            $this->fato('U-1', '4', '16', 'RIO BRANCO', 1, 10, 0, false, false, 'ATE_1H'),
            $this->fato('U-2', '4', '16', 'RIO BRANCO', 1, 9, 0, true, false, 'ATE_1H', 0, 0, true),
            $this->fato('U-3', '4', '16', 'RIO BRANCO', 1, 1, 0, false, false, 'ATE_1H'),
            $this->fato('R-1', '4', '16', 'RIO BRANCO', 1, 10, 0, false, true, 'ATE_1H'),
            $this->fato('R-2', '4', '16', 'RIO BRANCO', 1, 10, 0, false, true, 'ATE_1H'),
            $this->fato('R-COBERTO', '4', '16', 'RIO BRANCO', 1, 20, 0, false, true, 'ATE_1H', 0, 0, true),
            $this->fato('R-LDA', '4', '16', 'RIO BRANCO', 1, 20, 0, true, true, 'ATE_1H'),
        ]))->first();

        $this->assertSame(20, $linha['secoes_fisicas_urbanas']);
        $this->assertSame(3, $linha['urnas_contingencia_urbana']);
        $this->assertSame(3, $linha['urnas_contingencia_rural_sem_cobertura']);
    }

    public function test_aplica_percentual_configurado_nas_duas_necessidades_e_totais_de_cruzeiro_do_sul(): void
    {
        $linha = (new DashboardLocaisVotacaoService)->resumir(collect([
            $this->fato(
                'U-1',
                '4',
                '20',
                'CRUZEIRO DO SUL',
                1,
                186,
                0,
                false,
                false,
                'ATE_1H',
                percentualUrnasContingencia: 27.96,
                percentualUrnasContingenciaId: 31
            ),
            $this->fato(
                'R-SC',
                '4',
                '20',
                'CRUZEIRO DO SUL',
                1,
                7,
                0,
                false,
                true,
                'ATE_1H',
                percentualUrnasContingencia: 27.96,
                percentualUrnasContingenciaId: 31
            ),
            $this->fato(
                'R-URNAS',
                '4',
                '20',
                'CRUZEIRO DO SUL',
                1,
                0,
                0,
                false,
                true,
                'ATE_1H',
                urnasContingencia: 5,
                possuiCoberturaUrnasContingencia: true,
                percentualUrnasContingencia: 27.96,
                percentualUrnasContingenciaId: 31
            ),
            $this->fato(
                'R-LDA',
                '4',
                '20',
                'CRUZEIRO DO SUL',
                1,
                0,
                0,
                true,
                true,
                'ATE_1H',
                urnasContingencia: 17,
                percentualUrnasContingencia: 27.96,
                percentualUrnasContingenciaId: 31
            ),
        ]))->first();

        $this->assertSame(27.96, $linha['percentual_urnas_contingencia']);
        $this->assertFalse($linha['percentual_urnas_contingencia_padrao']);
        $this->assertSame(31, $linha['percentual_urnas_contingencia_id']);
        $this->assertSame(53, $linha['urnas_contingencia_urbana']);
        $this->assertSame(2, $linha['urnas_contingencia_rural_sem_cobertura']);
        $this->assertSame(77, $linha['urnas_contingencia_total']);
        $this->assertSame(270, $linha['urnas_total']);
    }

    public function test_usa_quinze_por_cento_como_padrao_quando_cadastro_esta_ausente(): void
    {
        $linha = (new DashboardLocaisVotacaoService)->resumir(collect([
            $this->fato('U-1', '4', '16', 'RIO BRANCO', 1, 20, 0, false, false, 'ATE_1H'),
            $this->fato('R-1', '4', '16', 'RIO BRANCO', 1, 7, 0, false, true, 'ATE_1H'),
        ]))->first();

        $this->assertSame(15.0, $linha['percentual_urnas_contingencia']);
        $this->assertTrue($linha['percentual_urnas_contingencia_padrao']);
        $this->assertNull($linha['percentual_urnas_contingencia_id']);
        $this->assertSame(3, $linha['urnas_contingencia_urbana']);
        $this->assertSame(2, $linha['urnas_contingencia_rural_sem_cobertura']);
    }

    public function test_percentual_zero_configurado_e_valido_e_nao_aciona_fallback(): void
    {
        $linha = (new DashboardLocaisVotacaoService)->resumir(collect([
            $this->fato(
                'U-1',
                '4',
                '16',
                'RIO BRANCO',
                1,
                20,
                0,
                false,
                false,
                'ATE_1H',
                percentualUrnasContingencia: 0.0,
                percentualUrnasContingenciaId: 7
            ),
            $this->fato(
                'R-1',
                '4',
                '16',
                'RIO BRANCO',
                1,
                20,
                0,
                false,
                true,
                'ATE_1H',
                percentualUrnasContingencia: 0.0,
                percentualUrnasContingenciaId: 7
            ),
        ]))->first();

        $this->assertSame(0.0, $linha['percentual_urnas_contingencia']);
        $this->assertFalse($linha['percentual_urnas_contingencia_padrao']);
        $this->assertSame(7, $linha['percentual_urnas_contingencia_id']);
        $this->assertSame(0, $linha['urnas_contingencia_urbana']);
        $this->assertSame(0, $linha['urnas_contingencia_rural_sem_cobertura']);
    }

    public function test_atribui_urnas_de_auditoria_uma_vez_por_linha_e_soma_ao_total_de_urnas(): void
    {
        $service = new DashboardLocaisVotacaoService;
        $resumo = $service->resumir(collect([
            $this->fato('RB-1', '1', '16', 'RIO BRANCO', 1, 10, 0, false, false, 'ATE_1H', urnasAuditoria: 12),
            $this->fato('RB-2', '1', '16', 'RIO BRANCO', 1, 10, 0, false, false, 'ATE_1H', urnasAuditoria: 12),
            $this->fato('CZ-1', '4', '20', 'CRUZEIRO DO SUL', 1, 5, 0, false, false, 'ATE_1H', urnasAuditoria: 4),
        ]));

        $rioBranco = $resumo->firstWhere('municipio_codigo', '16');
        $cruzeiro = $resumo->firstWhere('municipio_codigo', '20');
        $totais = $service->totalizar($resumo);

        $this->assertSame(12, $rioBranco['urnas_auditoria']);
        $this->assertSame(4, $cruzeiro['urnas_auditoria']);
        $this->assertSame(3, $rioBranco['urnas_contingencia_total']);
        $this->assertSame(35, $rioBranco['urnas_total']);
        $this->assertSame(
            $rioBranco['secoes_fisicas']
                + $rioBranco['urnas_contingencia_total']
                + $rioBranco['urnas_auditoria'],
            $rioBranco['urnas_total']
        );
        $this->assertSame(16, $totais['urnas_auditoria']);
        $this->assertSame(45, $totais['urnas_total']);
    }

    public function test_necessidade_calculada_fica_zero_sem_secoes_e_total_soma_inteiros_das_linhas(): void
    {
        $service = new DashboardLocaisVotacaoService;
        $resumo = $service->resumir(collect([
            $this->fato('U-1', '4', '16', 'RIO BRANCO', 1, 1, 0, false, false, 'ATE_1H'),
            $this->fato('U-2', '5', '20', 'CRUZEIRO DO SUL', 1, 1, 0, false, false, 'ATE_1H'),
            $this->fato('R-ZERO', '6', '21', 'TARAUACA', 3, 0, 0, false, true, 'ATE_1H'),
        ]));

        $tarauaca = $resumo->firstWhere('municipio_codigo', '21');
        $totais = $service->totalizar($resumo);

        $this->assertSame(0, $tarauaca['urnas_contingencia_urbana']);
        $this->assertSame(0, $tarauaca['urnas_contingencia_rural_sem_cobertura']);
        $this->assertSame(0, $tarauaca['urnas_contingencia_total']);
        $this->assertSame(0, $tarauaca['urnas_total']);
        $this->assertSame(2, $totais['urnas_contingencia_urbana']);
        $this->assertSame(0, $totais['urnas_contingencia_rural_sem_cobertura']);
        $this->assertSame(2, $totais['urnas_contingencia_total']);
        $this->assertSame(4, $totais['urnas_total']);
    }

    public function test_totaliza_todas_as_metricas_aditivas_do_resumo(): void
    {
        $service = new DashboardLocaisVotacaoService;
        $resumo = $service->resumir(collect([
            $this->fato('LV-1', '4', '16', 'RIO BRANCO', 1, 2, 1, false, false, 'ATE_1H', 2, 7),
            $this->fato('LV-2', '4', '16', 'RIO BRANCO', 3, 0, 0, true, true, 'MAIS_1H', 0, 4),
            $this->fato('LV-3', '4', '16', 'RIO BRANCO', 1, 1, 0, false, true, 'SEM_INFO_APROVEITAVEL', 0, 2),
            $this->fato('LV-4', '5', '20', 'CRUZEIRO DO SUL', 1, 1, 2, false, false, 'ATE_1H', 1, 5),
        ]));

        $totais = $service->totalizar($resumo);

        $this->assertSame(3, $totais['locais_convencionais']);
        $this->assertSame(1, $totais['locais_preso_provisorio']);
        $this->assertSame(3, $totais['locais_com_secoes']);
        $this->assertSame(1, $totais['locais_sem_secoes']);
        $this->assertSame(2, $totais['locais_alocacao_provisoria']);
        $this->assertSame(3, $totais['secoes_fisicas_alocacao_provisoria']);
        $this->assertSame(4, $totais['secoes_fisicas']);
        $this->assertSame(3, $totais['secoes_agregadas']);
        $this->assertSame(7, $totais['secoes_totais']);
        $this->assertSame(2, $totais['locais_urbanos']);
        $this->assertSame(3, $totais['secoes_fisicas_urbanas']);
        $this->assertSame(2, $totais['locais_rurais']);
        $this->assertSame(1, $totais['secoes_fisicas_rurais']);
        $this->assertSame(1, $totais['locais_rurais_sem_lda']);
        $this->assertSame(1, $totais['secoes_fisicas_rurais_sem_lda']);
        $this->assertSame(1, $totais['locais_lda']);
        $this->assertSame(0, $totais['secoes_fisicas_lda']);
        $this->assertSame(2, $totais['tempo_ate_1h']);
        $this->assertSame(1, $totais['tempo_mais_1h']);
        $this->assertSame(1, $totais['tempo_sem_info']);
        $this->assertSame(2, $totais['urnas_contingencia_zona_rural']);
        $this->assertSame(4, $totais['urnas_contingencia_lda']);
        $this->assertSame(2, $totais['urnas_contingencia_urbana']);
        $this->assertSame(1, $totais['urnas_contingencia_rural_sem_cobertura']);
        $this->assertSame(9, $totais['urnas_contingencia_total']);
        $this->assertSame(13, $totais['urnas_total']);
        $this->assertSame(
            6,
            $totais['urnas_contingencia_zona_rural'] + $totais['urnas_contingencia_lda']
        );
        $this->assertSame(
            $totais['secoes_fisicas'] + $totais['secoes_agregadas'],
            $totais['secoes_totais']
        );
    }

    public function test_resume_total_de_urnas_por_zona_somando_as_linhas_e_ordenando_numericamente(): void
    {
        $service = new DashboardLocaisVotacaoService;
        $resumo = $service->resumir(collect([
            $this->fato('Z10-1', '10', '30', 'BRASILEIA', 1, 10, 0, false, false, 'ATE_1H', urnasAuditoria: 1),
            $this->fato('Z2-1', '2', '16', 'RIO BRANCO', 1, 10, 0, false, false, 'ATE_1H', urnasAuditoria: 2),
            $this->fato('Z2-2', '2', '17', 'BUJARI', 1, 5, 0, false, false, 'ATE_1H'),
        ]));

        $porZona = $service->resumirTotalUrnasPorZona($resumo);

        $this->assertSame([
            ['zona' => '2', 'urnas_total' => 20],
            ['zona' => '10', 'urnas_total' => 13],
        ], $porZona->all());
        $this->assertSame(
            $service->totalizar($resumo)['urnas_total'],
            $porZona->sum('urnas_total')
        );
    }

    #[DataProvider('indicadoresProvider')]
    public function test_mapeia_cada_indicador_para_o_filtro_canonico(
        string $indicador,
        array $esperado
    ): void {
        $filtro = (new DashboardLocaisVotacaoService)->criarFiltroDetalhamento(
            $indicador,
            '4',
            '16'
        );

        foreach ($esperado as $propriedade => $valor) {
            $this->assertSame($valor, $filtro->{$propriedade}, $indicador.':'.$propriedade);
        }
    }

    public static function indicadoresProvider(): array
    {
        return [
            'zona' => ['zona', ['zona' => '4', 'municipio' => null]],
            'municipio' => ['municipio', ['zona' => '4', 'municipio' => '16']],
            'convencionais' => ['locais_convencionais', ['tipoLocal' => 1]],
            'preso provisorio' => ['locais_preso_provisorio', ['tipoLocal' => 3]],
            'locais com secoes' => ['locais_com_secoes', ['somenteComSecoes' => true]],
            'locais sem secoes' => ['locais_sem_secoes', ['somenteSemSecoes' => true]],
            'alocacao provisoria' => ['locais_alocacao_provisoria', ['movimentacaoSecoes' => 'alocacao_provisoria']],
            'secoes totais' => ['secoes_totais', ['somenteComSecoes' => true]],
            'secoes fisicas' => ['secoes_fisicas', ['somenteComSecoes' => true]],
            'secoes agregadas' => ['secoes_agregadas', ['movimentacaoSecoes' => 'agregadas']],
            'urbanos' => ['locais_urbanos', ['areaLocal' => 'urbana']],
            'rurais' => ['locais_rurais', ['areaLocal' => 'rural']],
            'rurais sem lda' => ['locais_rurais_sem_lda', ['areaLocal' => 'rural', 'excluirLda' => true]],
            'lda' => ['locais_lda', ['somenteLda' => true]],
            'ate uma hora' => ['tempo_ate_1h', ['tempoDeslocamento' => 'ate_1h']],
            'mais de uma hora' => ['tempo_mais_1h', ['tempoDeslocamento' => 'mais_1h']],
            'sem informacao' => ['tempo_sem_info', ['tempoDeslocamento' => 'sem_info_aproveitavel']],
            'urnas de contingencia em zona rural' => ['urnas_contingencia_zona_rural', ['urnasContingenciaZonaRural' => true]],
            'urnas de contingencia lda' => ['urnas_contingencia_lda', ['urnasContingenciaLda' => true]],
            'necessidade de urnas urbana' => [
                'urnas_contingencia_urbana',
                ['areaLocal' => 'urbana', 'somenteComSecoes' => true],
            ],
            'necessidade de urnas rural sem cobertura' => [
                'urnas_contingencia_rural_sem_cobertura',
                [
                    'areaLocal' => 'rural',
                    'excluirLda' => true,
                    'somenteComSecoes' => true,
                    'semCoberturaUrnasContingencia' => true,
                ],
            ],
            'total de urnas de contingencia' => [
                'urnas_contingencia_total',
                ['composicaoUrnas' => 'contingencia'],
            ],
            'total de urnas' => [
                'urnas_total',
                ['composicaoUrnas' => 'total'],
            ],
        ];
    }

    private function fato(
        string $codigo,
        string $zona,
        string $municipioCodigo,
        string $municipio,
        int $tipoLocal,
        int $secoesFisicas,
        int $secoesAgregadas,
        bool $possuiLda,
        bool $zonaRural,
        string $tempo,
        int $secoesFisicasAlocacaoProvisoria = 0,
        int $urnasContingencia = 0,
        bool $possuiCoberturaUrnasContingencia = false,
        ?float $percentualUrnasContingencia = null,
        ?int $percentualUrnasContingenciaId = null,
        int $urnasAuditoria = 0
    ): object {
        return (object) [
            'cod_objeto' => $codigo,
            'zona' => $zona,
            'municipio_codigo' => $municipioCodigo,
            'municipio' => $municipio,
            'tip_local' => $tipoLocal,
            'secoes_fisicas' => $secoesFisicas,
            'secoes_agregadas' => $secoesAgregadas,
            'secoes_fisicas_alocacao_provisoria' => $secoesFisicasAlocacaoProvisoria,
            'possui_lda' => $possuiLda ? 1 : 0,
            'zona_rural' => $zonaRural ? 1 : 0,
            'tempo_classificacao' => $tempo,
            'urnas_contingencia' => $urnasContingencia,
            'possui_cobertura_urnas_contingencia' => $possuiCoberturaUrnasContingencia ? 1 : 0,
            'percentual_urnas_contingencia' => $percentualUrnasContingencia,
            'percentual_urnas_contingencia_id' => $percentualUrnasContingenciaId,
            'qtd_urna_auditoria' => $urnasAuditoria,
        ];
    }
}
```
</TESTS_UNIT_DASHBOARDLOCAISVOTACAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EnviarEmailCadastroSupervisorPredioComunicadoJobTest.php`
## <TESTS_UNIT_ENVIAREMAILCADASTROSUPERVISORPREDIOCOMUNICADOJOBTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EnviarEmailCadastroSupervisorPredioComunicadoJobTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EnviarEmailCadastroSupervisorPredioComunicadoJobTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function job_envia_email_e_marca_notificacao_como_enviada(): void
public function job_registra_falha_quando_email_destino_nao_existe(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Jobs\SupervisoresPredio\EnviarEmailCadastroSupervisorPredioComunicadoJob;
use App\Mail\SupervisoresPredio\CadastroSupervisorPredioComunicadoMail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class EnviarEmailCadastroSupervisorPredioComunicadoJobTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function job_envia_email_e_marca_notificacao_como_enviada(): void
    {
        Mail::fake();

        DB::shouldReceive('selectOne')
            ->once()
            ->andReturn((object) [
                'id_notificacao' => 55,
                'id_supervisor_predio' => 361,
                'codigo_notificacao' => 'ESCLARECIMENTO_LOCAL_ATUACAO',
                'email_destino' => 'ac-barros@hotmail.com',
                'assunto' => 'Esclarecimento e confirmação do local informado no cadastro de Supervisor(a) de Prédio - TRE/AC',
                'enviado' => 0,
                'payload_json' => json_encode([
                    'nome' => 'ANA CAROLINA FERREIRA DE BARROS',
                    'local' => 'ESCOLA DOUTOR JOAO AGUIAR',
                    'localidade' => 'RIO BRANCO',
                ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
            ]);

        DB::shouldReceive('update')
            ->once()
            ->with(
                Mockery::on(static fn (string $sql): bool => str_contains($sql, 'SET ENVIADO = 1')),
                Mockery::on(static fn (array $bindings): bool => ($bindings['id'] ?? null) === 55)
            )
            ->andReturn(1);

        $job = new EnviarEmailCadastroSupervisorPredioComunicadoJob(55);
        $job->handle();

        Mail::assertSent(CadastroSupervisorPredioComunicadoMail::class, static function (CadastroSupervisorPredioComunicadoMail $mail): bool {
            return $mail->hasTo('ac-barros@hotmail.com')
                && ($mail->payload['nome'] ?? null) === 'ANA CAROLINA FERREIRA DE BARROS';
        });
    }

    #[Test]
    public function job_registra_falha_quando_email_destino_nao_existe(): void
    {
        Mail::fake();

        DB::shouldReceive('selectOne')
            ->once()
            ->andReturn((object) [
                'id_notificacao' => 55,
                'email_destino' => '',
                'enviado' => 0,
                'payload_json' => '{}',
            ]);

        DB::shouldReceive('update')
            ->once()
            ->with(
                Mockery::on(static fn (string $sql): bool => str_contains($sql, 'ERRO_ULTIMO_ENVIO')),
                Mockery::on(static fn (array $bindings): bool => ($bindings['id'] ?? null) === 55
                    && str_contains((string) ($bindings['erro'] ?? ''), 'destinatário'))
            )
            ->andReturn(1);

        $job = new EnviarEmailCadastroSupervisorPredioComunicadoJob(55);
        $job->handle();

        Mail::assertNothingSent();
    }
}
```
</TESTS_UNIT_ENVIAREMAILCADASTROSUPERVISORPREDIOCOMUNICADOJOBTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EtiquetaSecaoApresentacaoTest.php`
## <TESTS_UNIT_ETIQUETASECAOAPRESENTACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EtiquetaSecaoApresentacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EtiquetaSecaoApresentacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function resolve_os_simbolos_da_matriz_operacional(): void
public function forma_payload_do_qr_com_zona_original_e_secao_em_quatro_posicoes(): void
public function normaliza_todas_as_rotas_em_ordem_sem_truncar_a_segunda(): void
public function rotula_area_rural_com_lda_somente_quando_os_dois_indicadores_estao_presentes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\Exportacao\EtiquetaSecaoApresentacao;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class EtiquetaSecaoApresentacaoTest extends TestCase
{
    #[Test]
    public function resolve_os_simbolos_da_matriz_operacional(): void
    {
        $esperados = [
            1 => 'AC', 2 => 'AB', 3 => 'BR', 4 => 'BJ', 5 => 'CP', 6 => 'CZ',
            7 => 'EP', 8 => 'FJ', 9 => 'JD', 10 => 'ML', 11 => 'MU', 12 => 'MT',
            13 => 'CS', 14 => 'TO', 15 => 'WA', 16 => 'RB', 17 => 'RA', 18 => 'ST',
            19 => 'SM', 20 => 'SG', 21 => 'TK', 22 => 'XA',
        ];

        foreach ($esperados as $codigo => $simbolo) {
            $this->assertSame($simbolo, EtiquetaSecaoApresentacao::simboloMunicipio($codigo));
        }

        $this->assertSame('—', EtiquetaSecaoApresentacao::simboloMunicipio('999'));
    }

    #[Test]
    public function forma_payload_do_qr_com_zona_original_e_secao_em_quatro_posicoes(): void
    {
        $this->assertSame('00020022', EtiquetaSecaoApresentacao::payloadQr('2', '022'));
        $this->assertSame('00120188', EtiquetaSecaoApresentacao::payloadQr('12', '188'));
        $this->assertSame('QRCODE,L', EtiquetaSecaoApresentacao::tipoQr());
    }

    #[Test]
    public function normaliza_todas_as_rotas_em_ordem_sem_truncar_a_segunda(): void
    {
        $this->assertSame(
            ['R101', 'R912'],
            EtiquetaSecaoApresentacao::rotas(' R101 | R912 | R101 ')
        );
        $this->assertSame([], EtiquetaSecaoApresentacao::rotas(null));
    }

    #[Test]
    public function rotula_area_rural_com_lda_somente_quando_os_dois_indicadores_estao_presentes(): void
    {
        $this->assertSame('URBANA', EtiquetaSecaoApresentacao::rotuloArea('urbana', false));
        $this->assertSame('URBANA', EtiquetaSecaoApresentacao::rotuloArea('urbana', true));
        $this->assertSame('RURAL', EtiquetaSecaoApresentacao::rotuloArea('rural', false));
        $this->assertSame('RURAL LDA', EtiquetaSecaoApresentacao::rotuloArea('rural', true));
    }
}
```
</TESTS_UNIT_ETIQUETASECAOAPRESENTACAOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EtiquetaSecaoPdfRendererTest.php`
## <TESTS_UNIT_ETIQUETASECAOPDFRENDERERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EtiquetaSecaoPdfRendererTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EtiquetaSecaoPdfRendererTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function renderiza_uma_pagina_a5_paisagem_por_etiqueta_com_conteudo_operacional(): void
public function renderiza_o_simbolo_de_area_rural_sem_invalidar_o_pdf(): void
private function etiqueta(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\Exportacao\EtiquetaSecaoPdf;
use App\Support\LocaisVotacao\Exportacao\EtiquetaSecaoPdfRenderer;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class EtiquetaSecaoPdfRendererTest extends TestCase
{
    #[Test]
    public function renderiza_uma_pagina_a5_paisagem_por_etiqueta_com_conteudo_operacional(): void
    {
        $etiquetas = collect([
            $this->etiqueta('22', '00020022'),
            $this->etiqueta('28', '00020028'),
        ]);
        $pdf = (new EtiquetaSecaoPdfRenderer)->renderizar($etiquetas, 2026);

        $this->assertStringStartsWith('%PDF', $pdf);
        $this->assertSame(2, preg_match_all('/\/Type\s*\/Page\b/', $pdf));
        $this->assertMatchesRegularExpression(
            '/\/MediaBox\s*\[\s*0(?:\.0+)?\s+0(?:\.0+)?\s+595\.\d+\s+419\.\d+\s*\]/',
            $pdf
        );
        $this->assertStringContainsString('/BaseFont /Helvetica ', $pdf);
        $this->assertStringContainsString('/BaseFont /Helvetica-Bold ', $pdf);
        $this->assertStringNotContainsString('DejaVuSans', $pdf);
    }

    #[Test]
    public function renderiza_o_simbolo_de_area_rural_sem_invalidar_o_pdf(): void
    {
        $etiqueta = $this->etiqueta('31', '00020031', 'rural', true);

        $pdf = (new EtiquetaSecaoPdfRenderer)->renderizar(collect([$etiqueta]), 2026);

        $this->assertStringStartsWith('%PDF', $pdf);
        $this->assertSame(1, preg_match_all('/\/Type\s*\/Page\b/', $pdf));
    }

    private function etiqueta(
        string $secao,
        string $payload,
        string $area = 'urbana',
        bool $possuiLda = false
    ): EtiquetaSecaoPdf {
        return new EtiquetaSecaoPdf(
            codObjetoSecao: 'SECAO-'.$secao,
            codObjetoLocal: 'LOCAL-1',
            zonaLocal: '2',
            municipio: 'XAPURI',
            simboloMunicipio: 'XA',
            numLocal: '110',
            nomeLocal: 'NÚCLEO DA UFAC',
            endereco: 'RUA CORONEL BRANDÃO, 392',
            bairro: 'CENTRO',
            areaLocal: $area,
            possuiLda: $possuiLda,
            numSecaoExibicao: $secao,
            secoesAgregadas: '024, 110',
            rotas: ['R101', 'R912'],
            qrPayload: $payload,
        );
    }
}
```
</TESTS_UNIT_ETIQUETASECAOPDFRENDERERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LdaLocalVotacaoRelatorioServiceTest.php`
## <TESTS_UNIT_LDALOCALVOTACAORELATORIOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LdaLocalVotacaoRelatorioServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LdaLocalVotacaoRelatorioServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function grava_relatorios_de_nome_e_endereco_nos_formatos_existentes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Lda\LdaLocalVotacaoRelatorioService;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LdaLocalVotacaoRelatorioServiceTest extends TestCase
{
    /** @var list<string> */
    private array $arquivos = [];

    private ?string $diretorio = null;

    protected function tearDown(): void
    {
        foreach ($this->arquivos as $arquivo) {
            if (is_file($arquivo)) {
                unlink($arquivo);
            }
        }

        if ($this->diretorio !== null && is_dir($this->diretorio)) {
            rmdir($this->diretorio);
        }

        parent::tearDown();
    }

    #[Test]
    public function grava_relatorios_de_nome_e_endereco_nos_formatos_existentes(): void
    {
        $this->diretorio = sys_get_temp_dir() . '/planeleito-lda-relatorio-' . bin2hex(random_bytes(8));
        $service = new LdaLocalVotacaoRelatorioService($this->diretorio);

        $arquivoNomes = $service->salvarNomes([[
            'id' => 57,
            'zona' => '5',
            'municipio' => 'TARAUACA',
            'cod_objeto_local_votacao' => 'LOCAL-57',
            'nome_lda' => 'NOME ANTERIOR',
            'nome_oficial' => 'NOME OFICIAL',
            'secoes' => '101',
        ]]);
        $arquivoEnderecos = $service->salvarEnderecos([[
            'id' => 57,
            'zona' => '5',
            'municipio' => 'TARAUACA',
            'cod_objeto_local_votacao' => 'LOCAL-57',
            'nome_local' => 'NOME OFICIAL',
            'endereco_lda' => 'ENDERECO ANTERIOR',
            'endereco_oficial' => 'ENDERECO OFICIAL',
            'secoes' => '101',
        ]]);
        $this->arquivos = [$arquivoNomes, $arquivoEnderecos];

        $this->assertFileExists($arquivoNomes);
        $this->assertFileExists($arquivoEnderecos);
        $this->assertSame(
            'lda_id,zona,municipio,cod_objeto_local_votacao,nome_lda,nome_oficial,secoes',
            trim((string) strtok((string) file_get_contents($arquivoNomes), "\n"))
        );
        $this->assertSame(
            'lda_id,zona,municipio,cod_objeto_local_votacao,nome_local,endereco_lda,endereco_oficial,secoes',
            trim((string) strtok((string) file_get_contents($arquivoEnderecos), "\n"))
        );
        $this->assertStringContainsString('NOME OFICIAL', (string) file_get_contents($arquivoNomes));
        $this->assertStringContainsString('ENDERECO OFICIAL', (string) file_get_contents($arquivoEnderecos));
    }
}
```
</TESTS_UNIT_LDALOCALVOTACAORELATORIOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LdaLocalVotacaoSyncServiceTest.php`
## <TESTS_UNIT_LDALOCALVOTACAOSYNCSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LdaLocalVotacaoSyncServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LdaLocalVotacaoSyncServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function execucao_sem_divergencias_e_idempotente(): void
public function gera_relatorios_antes_de_sincronizar_nome_e_endereco(): void
public function sincroniza_apenas_nome_quando_so_nome_diverge(): void
public function sincroniza_apenas_endereco_quando_so_endereco_diverge(): void
public function falha_de_relatorio_impede_qualquer_dml(): void
public function falha_da_persistencia_auditada_e_propagada(): void
private function divergenciaNome(int $id): array
private function divergenciaEndereco(int $id): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Services\Lda\LdaLocalVotacaoRelatorioService;
use App\Services\Lda\LdaLocalVotacaoSyncService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class LdaLocalVotacaoSyncServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function execucao_sem_divergencias_e_idempotente(): void
    {
        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([]);
        $repository->shouldNotReceive('sincronizarDadosLocalVotacao');

        $relatorios = Mockery::mock(LdaLocalVotacaoRelatorioService::class);
        $relatorios->shouldNotReceive('salvarNomes');
        $relatorios->shouldNotReceive('salvarEnderecos');

        $resultado = (new LdaLocalVotacaoSyncService($repository, $relatorios))->sincronizar();

        $this->assertSame([
            'dblink' => '',
            'origem_total' => 0,
            'destino_total' => 0,
            'ldas_total' => 0,
            'nomes_atualizados' => 0,
            'enderecos_atualizados' => 0,
            'relatorios_gerados' => 0,
        ], $resultado);
    }

    #[Test]
    public function gera_relatorios_antes_de_sincronizar_nome_e_endereco(): void
    {
        $nome = $this->divergenciaNome(57);
        $endereco = $this->divergenciaEndereco(57);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([$nome]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([$endereco]);
        $repository->shouldReceive('sincronizarDadosLocalVotacao')->once()->andReturn([
            'nomes_atualizados' => 1,
            'enderecos_atualizados' => 1,
        ]);

        $relatorios = Mockery::mock(LdaLocalVotacaoRelatorioService::class);
        $relatorios->shouldReceive('salvarNomes')->once()->with([$nome])->andReturn('/tmp/nomes.csv');
        $relatorios->shouldReceive('salvarEnderecos')->once()->with([$endereco])->andReturn('/tmp/enderecos.csv');

        $resultado = (new LdaLocalVotacaoSyncService($repository, $relatorios))->sincronizar();

        $this->assertSame(2, $resultado['origem_total']);
        $this->assertSame(2, $resultado['destino_total']);
        $this->assertSame(1, $resultado['ldas_total']);
        $this->assertSame(1, $resultado['nomes_atualizados']);
        $this->assertSame(1, $resultado['enderecos_atualizados']);
        $this->assertSame(2, $resultado['relatorios_gerados']);
    }

    #[Test]
    public function sincroniza_apenas_nome_quando_so_nome_diverge(): void
    {
        $nome = $this->divergenciaNome(58);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([$nome]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([]);
        $repository->shouldReceive('sincronizarDadosLocalVotacao')->once()->andReturn([
            'nomes_atualizados' => 1,
            'enderecos_atualizados' => 0,
        ]);

        $relatorios = Mockery::mock(LdaLocalVotacaoRelatorioService::class);
        $relatorios->shouldReceive('salvarNomes')->once()->with([$nome])->andReturn('/tmp/nomes.csv');
        $relatorios->shouldNotReceive('salvarEnderecos');

        $resultado = (new LdaLocalVotacaoSyncService($repository, $relatorios))->sincronizar();

        $this->assertSame(1, $resultado['origem_total']);
        $this->assertSame(1, $resultado['destino_total']);
        $this->assertSame(1, $resultado['ldas_total']);
        $this->assertSame(1, $resultado['nomes_atualizados']);
        $this->assertSame(0, $resultado['enderecos_atualizados']);
        $this->assertSame(1, $resultado['relatorios_gerados']);
    }

    #[Test]
    public function sincroniza_apenas_endereco_quando_so_endereco_diverge(): void
    {
        $endereco = $this->divergenciaEndereco(59);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([$endereco]);
        $repository->shouldReceive('sincronizarDadosLocalVotacao')->once()->andReturn([
            'nomes_atualizados' => 0,
            'enderecos_atualizados' => 1,
        ]);

        $relatorios = Mockery::mock(LdaLocalVotacaoRelatorioService::class);
        $relatorios->shouldNotReceive('salvarNomes');
        $relatorios->shouldReceive('salvarEnderecos')->once()->with([$endereco])->andReturn('/tmp/enderecos.csv');

        $resultado = (new LdaLocalVotacaoSyncService($repository, $relatorios))->sincronizar();

        $this->assertSame(1, $resultado['origem_total']);
        $this->assertSame(1, $resultado['destino_total']);
        $this->assertSame(1, $resultado['ldas_total']);
        $this->assertSame(0, $resultado['nomes_atualizados']);
        $this->assertSame(1, $resultado['enderecos_atualizados']);
        $this->assertSame(1, $resultado['relatorios_gerados']);
    }

    #[Test]
    public function falha_de_relatorio_impede_qualquer_dml(): void
    {
        $nome = $this->divergenciaNome(62);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([$nome]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([]);
        $repository->shouldNotReceive('sincronizarDadosLocalVotacao');

        $relatorios = Mockery::mock(LdaLocalVotacaoRelatorioService::class);
        $relatorios->shouldReceive('salvarNomes')->once()->andThrow(new RuntimeException('falha no relatorio'));
        $relatorios->shouldNotReceive('salvarEnderecos');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('falha no relatorio');

        (new LdaLocalVotacaoSyncService($repository, $relatorios))->sincronizar();
    }

    #[Test]
    public function falha_da_persistencia_auditada_e_propagada(): void
    {
        $nome = $this->divergenciaNome(64);

        $repository = Mockery::mock(LocalDificilAcessoRepository::class);
        $repository->shouldReceive('listarDivergenciasNomeLocalVotacao')->once()->andReturn([$nome]);
        $repository->shouldReceive('listarDivergenciasEnderecoLocalVotacao')->once()->andReturn([]);
        $repository->shouldReceive('sincronizarDadosLocalVotacao')
            ->once()
            ->andThrow(new RuntimeException('rollback da auditoria'));

        $relatorios = Mockery::mock(LdaLocalVotacaoRelatorioService::class);
        $relatorios->shouldReceive('salvarNomes')->once()->with([$nome])->andReturn('/tmp/nomes.csv');
        $relatorios->shouldNotReceive('salvarEnderecos');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('rollback da auditoria');

        (new LdaLocalVotacaoSyncService($repository, $relatorios))->sincronizar();
    }

    /** @return array<string, string|int> */
    private function divergenciaNome(int $id): array
    {
        return [
            'id' => $id,
            'zona' => '5',
            'municipio' => 'TARAUACA',
            'cod_objeto_local_votacao' => 'LOCAL-' . $id,
            'nome_lda' => 'NOME ANTERIOR',
            'nome_oficial' => 'NOME OFICIAL',
            'secoes' => '101',
        ];
    }

    /** @return array<string, string|int> */
    private function divergenciaEndereco(int $id): array
    {
        return [
            'id' => $id,
            'zona' => '5',
            'municipio' => 'TARAUACA',
            'cod_objeto_local_votacao' => 'LOCAL-' . $id,
            'nome_local' => 'NOME OFICIAL',
            'endereco_lda' => 'ENDERECO ANTERIOR',
            'endereco_oficial' => 'ENDERECO OFICIAL',
            'secoes' => '101',
        ];
    }
}
```
</TESTS_UNIT_LDALOCALVOTACAOSYNCSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LdaTrajetoTrechoLocalVotacaoMigrationTest.php`
## <TESTS_UNIT_LDATRAJETOTRECHOLOCALVOTACAOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LdaTrajetoTrechoLocalVotacaoMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LdaTrajetoTrechoLocalVotacaoMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_generaliza_trechos_por_local_de_votacao_sem_fk_fisica(): void
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

class LdaTrajetoTrechoLocalVotacaoMigrationTest extends TestCase
{
    #[Test]
    public function migration_generaliza_trechos_por_local_de_votacao_sem_fk_fisica(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_07_02_120000_generalize_lda_trajeto_trecho_by_local_votacao.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ALTER TABLE lda_trajeto_trecho ADD (cod_objeto_local', $conteudo);
        $this->assertStringContainsString('UPDATE lda_trajeto_trecho t', $conteudo);
        $this->assertStringContainsString('l.cod_objeto_local_votacao', $conteudo);
        $this->assertStringContainsString('ALTER TABLE lda_trajeto_trecho MODIFY (lda_id NULL)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE lda_trajeto_trecho MODIFY (cod_objeto_local NOT NULL)', $conteudo);
        $this->assertStringContainsString('DROP INDEX ux_lda_trajeto_trecho_01', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_lda_trajeto_trecho_01 ON lda_trajeto_trecho (cod_objeto_local, macroprojeto_id, ordem)', $conteudo);
        $this->assertStringNotContainsString('FOREIGN KEY (cod_objeto_local)', $conteudo);
        $this->assertStringNotContainsString('REFERENCES LOCAL_VOTACAO_ST', $conteudo);
    }
}
```
</TESTS_UNIT_LDATRAJETOTRECHOLOCALVOTACAOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalDeVotacaoRepositoryTest.php`
## <TESTS_UNIT_LOCALDEVOTACAOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalDeVotacaoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalDeVotacaoRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_monitoramento_geral_retorna_vazio_quando_nao_ha_zonas_e_nao_ha_acesso_total(): void
public function test_monitoramento_mapa_retorna_vazio_quando_nao_ha_zonas_e_nao_ha_acesso_total(): void
public function test_monitoramento_mapa_dashboard_conta_locais_a_partir_do_catalogo_efetivo(): void
public function test_monitoramento_mapa_dashboard_filtra_locais_com_secoes_e_exclui_lda(): void
public function test_monitoramento_geral_expoe_lda_para_agrupamento(): void
public function test_monitoramento_geral_dados_preserva_lda_id_e_tipo_transmissao(): void
private function definirOrdemPreferenciaDisponivel(?bool $valor): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\LocaisVotacao\LocalDeVotacaoController;
use App\Repositories\LocaisVotacao\LocalDeVotacaoRepository;
use Illuminate\Support\Facades\DB;
use Mockery;
use ReflectionProperty;
use Tests\TestCase;

class LocalDeVotacaoRepositoryTest extends TestCase
{
    protected function tearDown(): void
    {
        $this->definirOrdemPreferenciaDisponivel(null);
        Mockery::close();
        parent::tearDown();
    }

    public function test_monitoramento_geral_retorna_vazio_quando_nao_ha_zonas_e_nao_ha_acesso_total(): void
    {
        $repository = new LocalDeVotacaoRepository();

        $this->assertSame([], $repository->monitoramentoGeral([], false));
    }

    public function test_monitoramento_mapa_retorna_vazio_quando_nao_ha_zonas_e_nao_ha_acesso_total(): void
    {
        $repository = new LocalDeVotacaoRepository();

        $this->assertSame([], $repository->monitoramentoMapa([], false));
    }

    public function test_monitoramento_mapa_dashboard_conta_locais_a_partir_do_catalogo_efetivo(): void
    {
        DB::shouldReceive('select')
            ->once()
            ->withArgs(function (string $sql, array $bindings): bool {
                $this->assertStringContainsString('FROM planeleito.vw_locais_votacao_efetivos lv', $sql);
                $this->assertStringContainsString('LEFT JOIN planeleito.vw_secoes_agregadas ws ON ws.cod_objeto_local = lv.cod_objeto', $sql);
                $this->assertStringContainsString('COUNT(DISTINCT lv.cod_objeto) AS locais_total', $sql);
                $this->assertSame([], $bindings);

                return true;
            })
            ->andReturn([]);

        $repository = new LocalDeVotacaoRepository();

        $this->assertSame([], $repository->monitoramentoMapaDashboard(null, true));
    }

    public function test_monitoramento_mapa_dashboard_filtra_locais_com_secoes_e_exclui_lda(): void
    {
        DB::shouldReceive('select')
            ->once()
            ->withArgs(function (string $sql, array $bindings): bool {
                $this->assertStringContainsString('ws.cod_objeto_local IS NOT NULL', $sql);
                $this->assertStringContainsString('NOT EXISTS', $sql);
                $this->assertStringContainsString('FROM planeleito.tbtransmissaovotacao tv_lda', $sql);
                $this->assertStringContainsString('tv_lda.cod_objeto_local = lv.cod_objeto', $sql);
                $this->assertStringContainsString('tv_lda.lda_id IS NOT NULL', $sql);
                $this->assertSame([], $bindings);

                return true;
            })
            ->andReturn([]);

        $repository = new LocalDeVotacaoRepository();

        $this->assertSame([], $repository->monitoramentoMapaDashboard(null, true, true, true));
    }

    public function test_monitoramento_geral_expoe_lda_para_agrupamento(): void
    {
        $this->definirOrdemPreferenciaDisponivel(true);

        DB::shouldReceive('select')
            ->once()
            ->withArgs(function (string $sql, array $bindings): bool {
                $this->assertStringContainsString('ltv.lda_id AS lda_id', $sql);
                $this->assertStringContainsString("WHEN ltv.local_transmissao_id IS NOT NULL THEN 'LOCAL_TRANSMISSAO'", $sql);
                $this->assertStringContainsString("WHEN ltv.lda_id IS NOT NULL THEN 'LDA'", $sql);
                $this->assertStringContainsString('END AS transmissao_tipo', $sql);
                $this->assertSame([], $bindings);

                return true;
            })
            ->andReturn([]);

        $repository = new LocalDeVotacaoRepository();

        $this->assertSame([], $repository->monitoramentoGeral(null, true));
    }

    public function test_monitoramento_geral_dados_preserva_lda_id_e_tipo_transmissao(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalDeVotacaoRepository::class);
        $repository->shouldReceive('monitoramentoGeral')
            ->once()
            ->with([4], false)
            ->andReturn([
                (object) [
                    'id' => 1,
                    'num_zona' => 4,
                    'descricao' => '4ª Zona Eleitoral',
                    'num_local' => '1001',
                    'nom_local' => 'ESCOLA LDA',
                    'nom_localidade' => 'RIO BRANCO',
                    'cod_objeto_localidade' => '001',
                    'endereco' => 'RUA A',
                    'secao_label' => '1 seção',
                    'rota_id' => null,
                    'rota_numero' => null,
                    'rota_descricao' => null,
                    'local_transmissao_id' => null,
                    'local_transmissao_nome' => 'LDA TESTE',
                    'lda_id' => 55,
                    'transmissao_tipo' => 'LDA',
                ],
                (object) [
                    'id' => 1,
                    'num_zona' => 4,
                    'descricao' => '4ª Zona Eleitoral',
                    'num_local' => '1002',
                    'nom_local' => 'ESCOLA SEM TRANSMISSAO',
                    'nom_localidade' => 'RIO BRANCO',
                    'cod_objeto_localidade' => '001',
                    'endereco' => 'RUA B',
                    'secao_label' => '2 seções',
                    'rota_id' => null,
                    'rota_numero' => null,
                    'rota_descricao' => null,
                    'local_transmissao_id' => null,
                    'local_transmissao_nome' => null,
                    'lda_id' => null,
                    'transmissao_tipo' => null,
                ],
            ]);

        $response = (new LocalDeVotacaoController($repository))->monitoramentoGeralDados();
        $dados = $response->getData(true);

        $this->assertSame(55, $dados[0]['locais'][0]['lda_id']);
        $this->assertSame('LDA', $dados[0]['locais'][0]['transmissao_tipo']);
        $this->assertNull($dados[0]['locais'][1]['lda_id']);
        $this->assertNull($dados[0]['locais'][1]['transmissao_tipo']);
    }

    private function definirOrdemPreferenciaDisponivel(?bool $valor): void
    {
        $propriedade = new ReflectionProperty(LocalDeVotacaoRepository::class, 'ordemPreferenciaDisponivel');
        $propriedade->setAccessible(true);
        $propriedade->setValue(null, $valor);
    }
}
```
</TESTS_UNIT_LOCALDEVOTACAOREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoAreaQueryTest.php`
## <TESTS_UNIT_LOCALVOTACAOAREAQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoAreaQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoAreaQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_classifica_area_com_marcacao_manual_prevalecendo_sobre_bairro(
public static function classificacoesEfetivas(): array
public function test_expressoes_sql_usam_a_mesma_marcacao_positiva_e_fallback_do_bairro(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\LocalVotacaoAreaQuery;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

class LocalVotacaoAreaQueryTest extends TestCase
{
    #[DataProvider('classificacoesEfetivas')]
    public function test_classifica_area_com_marcacao_manual_prevalecendo_sobre_bairro(
        bool $manual,
        ?string $bairro,
        string $esperado
    ): void {
        $this->assertSame($esperado, LocalVotacaoAreaQuery::classificar($manual, $bairro));
    }

    public static function classificacoesEfetivas(): array
    {
        return [
            'manual com bairro urbano' => [true, 'CENTRO', 'rural'],
            'manual sem bairro' => [true, null, 'rural'],
            'automatico com bairro rural' => [false, 'Projeto Zona Rural', 'rural'],
            'automatico com bairro urbano' => [false, 'BOSQUE', 'urbana'],
            'automatico sem bairro' => [false, null, 'urbana'],
        ];
    }

    public function test_expressoes_sql_usam_a_mesma_marcacao_positiva_e_fallback_do_bairro(): void
    {
        $rural = LocalVotacaoAreaQuery::expressaoRural('lv.cod_objeto', 'b.nom_bairro');
        $urbana = LocalVotacaoAreaQuery::expressaoUrbana('lv.cod_objeto', 'b.nom_bairro');

        $this->assertStringContainsString('EXISTS', $rural);
        $this->assertStringContainsString('local_votacao_zona_rural', $rural);
        $this->assertStringContainsString("UPPER(NVL(b.nom_bairro, '')) LIKE ?", $rural);
        $this->assertStringContainsString('NOT EXISTS', $urbana);
        $this->assertStringContainsString("UPPER(NVL(b.nom_bairro, '')) NOT LIKE ?", $urbana);
        $this->assertSame(['%ZONA RURAL%'], LocalVotacaoAreaQuery::bindings());
    }
}
```
</TESTS_UNIT_LOCALVOTACAOAREAQUERYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoEtiquetaA4260ServiceTest.php`
## <TESTS_UNIT_LOCALVOTACAOETIQUETAA4260SERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoEtiquetaA4260ServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoEtiquetaA4260ServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function gera_uma_etiqueta_por_local_e_reune_todos_os_certificados(): void
public function nao_consulta_vinculos_nem_api_quando_certificado_nao_foi_selecionado(): void
public function preserva_todos_os_locais_quando_a_consulta_remota_falha(): void
private function local(string $codigo, string $numero): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\KitVinculoRepository;
use App\Services\Lda\KitVinculoService;
use App\Services\LocaisVotacao\LocalVotacaoEtiquetaA4260Service;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalVotacaoEtiquetaA4260ServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function gera_uma_etiqueta_por_local_e_reune_todos_os_certificados(): void
    {
        $vinculos = Mockery::mock(KitVinculoRepository::class);
        $vinculos->shouldReceive('mapearPorCodigos')->once()->with(['LOCAL-1', 'LOCAL-2'])->andReturn([
            'LOCAL-1' => [10, 20],
        ]);
        $kits = Mockery::mock(KitVinculoService::class);
        $kits->shouldReceive('certificadosPorIds')->once()->with([10, 20])->andReturn([
            10 => 'CERT-10',
            20 => 'CERT-20',
        ]);

        $etiquetas = (new LocalVotacaoEtiquetaA4260Service($vinculos, $kits))->preparar(
            collect([
                $this->local('LOCAL-1', '101'),
                $this->local('LOCAL-2', '102'),
            ]),
            true
        );

        $this->assertCount(2, $etiquetas);
        $this->assertSame('LOCAL-1', $etiquetas[0]->codObjetoLocal);
        $this->assertSame(['CERT-10', 'CERT-20'], $etiquetas[0]->certificados);
        $this->assertSame('LOCAL-2', $etiquetas[1]->codObjetoLocal);
        $this->assertSame([], $etiquetas[1]->certificados);
    }

    #[Test]
    public function nao_consulta_vinculos_nem_api_quando_certificado_nao_foi_selecionado(): void
    {
        $vinculos = Mockery::mock(KitVinculoRepository::class);
        $vinculos->shouldNotReceive('mapearPorCodigos');
        $kits = Mockery::mock(KitVinculoService::class);
        $kits->shouldNotReceive('certificadosPorIds');

        $etiquetas = (new LocalVotacaoEtiquetaA4260Service($vinculos, $kits))->preparar(
            collect([$this->local('LOCAL-1', '101')]),
            false
        );

        $this->assertCount(1, $etiquetas);
        $this->assertSame([], $etiquetas[0]->certificados);
    }

    #[Test]
    public function preserva_todos_os_locais_quando_a_consulta_remota_falha(): void
    {
        $vinculos = Mockery::mock(KitVinculoRepository::class);
        $vinculos->shouldReceive('mapearPorCodigos')->once()->andReturn([
            'LOCAL-1' => [10],
        ]);
        $kits = Mockery::mock(KitVinculoService::class);
        $kits->shouldReceive('certificadosPorIds')->once()->with([10])->andReturn(null);

        $etiquetas = (new LocalVotacaoEtiquetaA4260Service($vinculos, $kits))->preparar(
            collect([
                $this->local('LOCAL-1', '101'),
                $this->local('LOCAL-2', '102'),
            ]),
            true
        );

        $this->assertCount(2, $etiquetas);
        $this->assertNull($etiquetas[0]->certificados);
        $this->assertSame([], $etiquetas[1]->certificados);
    }

    private function local(string $codigo, string $numero): object
    {
        return (object) [
            'cod_objeto' => $codigo,
            'cod_objeto_zona' => '9',
            'nom_localidade' => 'RIO BRANCO',
            'num_local' => $numero,
            'nom_local' => 'ESCOLA '.$numero,
            'des_endereco' => 'RUA '.$numero,
        ];
    }
}
```
</TESTS_UNIT_LOCALVOTACAOETIQUETAA4260SERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoEtiquetaPdfServiceTest.php`
## <TESTS_UNIT_LOCALVOTACAOETIQUETAPDFSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoEtiquetaPdfServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoEtiquetaPdfServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function prepara_etiqueta_canonica_com_destino_efetivo_qr_original_agregadas_e_duas_rotas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\LocaisVotacao\LocalVotacaoEtiquetaPdfService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalVotacaoEtiquetaPdfServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function prepara_etiqueta_canonica_com_destino_efetivo_qr_original_agregadas_e_duas_rotas(): void
    {
        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('listarEtiquetasSecoesDoLocais')
            ->once()
            ->with(['LOCAL-DESTINO'], [9], false)
            ->andReturn(collect([
                (object) [
                    'cod_objeto_secao' => 'SECAO-22',
                    'cod_objeto_zona_origem' => '2',
                    'num_secao' => '022',
                    'somente_agregadas' => '024,110',
                    'cod_objeto_local' => 'LOCAL-DESTINO',
                    'cod_objeto_zona' => '9',
                    'cod_objeto_localidade' => '16',
                    'nom_localidade' => 'RIO BRANCO',
                    'num_local' => '1090',
                    'nom_local' => 'PREFEITURA MUNICIPAL DE RIO BRANCO',
                    'des_endereco' => 'RUA RUI BARBOSA, 285',
                    'nom_bairro' => 'CENTRO',
                    'area_local_efetiva' => 'rural',
                    'possui_lda' => 1,
                    'rota_codigos' => 'R101|R912',
                ],
            ]));

        $service = new LocalVotacaoEtiquetaPdfService($repository);
        $etiquetas = $service->preparar(
            collect([(object) ['cod_objeto' => 'LOCAL-DESTINO']]),
            [9],
            false
        );

        $this->assertCount(1, $etiquetas);
        $etiqueta = $etiquetas->first();
        $this->assertSame('9', $etiqueta->zonaLocal);
        $this->assertSame('RIO BRANCO', $etiqueta->municipio);
        $this->assertSame('RB', $etiqueta->simboloMunicipio);
        $this->assertTrue($etiqueta->possuiLda);
        $this->assertSame('22', $etiqueta->numSecaoExibicao);
        $this->assertSame('024, 110', $etiqueta->secoesAgregadas);
        $this->assertSame(['R101', 'R912'], $etiqueta->rotas);
        $this->assertSame('00020022', $etiqueta->qrPayload);
    }
}
```
</TESTS_UNIT_LOCALVOTACAOETIQUETAPDFSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoInternoExportTest.php`
## <TESTS_UNIT_LOCALVOTACAOINTERNOEXPORTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoInternoExportTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoInternoExportTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function exporta_somente_colunas_selecionadas_na_ordem_e_protege_textos(): void
public function configuracao_pre_seleciona_colunas_principais_e_deixa_coordenadas_opcionais(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Exports\LocaisVotacao\LocalVotacaoInternoExport;
use App\Support\LocaisVotacao\Exportacao\LocalVotacaoCamposXlsx;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalVotacaoInternoExportTest extends TestCase
{
    #[Test]
    public function exporta_somente_colunas_selecionadas_na_ordem_e_protege_textos(): void
    {
        $export = new LocalVotacaoInternoExport(collect([
            (object) [
                'cod_objeto_zona' => '001',
                'num_local' => '010',
                'nom_local' => '=ESCOLA CENTRAL',
                'rota_label' => null,
                'mrjs' => [(object) ['num_mesa' => 904, 'tip_mrj' => 3]],
                'qtd_mesarios_convocados' => 4,
                'num_latitude' => '-9.97499',
            ],
        ]), [
            'zona',
            'numero_local',
            'nome_local',
            'rota',
            'mrj',
            'qtd_mesarios_local',
            'latitude',
        ]);

        $this->assertSame([
            [
                'Zona eleitoral',
                'Número do local',
                'Local de votação',
                'Rota',
                'Mesas Receptoras de Justificativa (MRJ)',
                'Total de mesários convocados',
                'Latitude',
            ],
            [
                '001',
                '010',
                "'=ESCOLA CENTRAL",
                'Sem rota',
                'MRJ 904 — Sem urna',
                4,
                -9.97499,
            ],
        ], $export->array());
    }

    #[Test]
    public function configuracao_pre_seleciona_colunas_principais_e_deixa_coordenadas_opcionais(): void
    {
        $padrao = LocalVotacaoCamposXlsx::padrao();

        foreach (['zona', 'municipio', 'numero_local', 'nome_local', 'bairro', 'endereco', 'area', 'lda', 'secoes_lista'] as $campo) {
            $this->assertContains($campo, $padrao);
        }

        $this->assertNotContains('latitude', $padrao);
        $this->assertNotContains('longitude', $padrao);
        $this->assertSame(
            LocalVotacaoCamposXlsx::permitidos(),
            collect(LocalVotacaoCamposXlsx::grupos())
                ->flatMap(static fn (array $campos): array => array_keys($campos))
                ->values()
                ->all()
        );
    }
}
```
</TESTS_UNIT_LOCALVOTACAOINTERNOEXPORTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoLocaisUiTest.php`
## <TESTS_UNIT_LOCALVOTACAOLOCAISUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoLocaisUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoLocaisUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function pdf_e_xlsx_compartilham_modal_com_pre_selecao_e_filtros_ativos(): void
public function tela_oferece_botao_font_awesome_para_etiquetas_a5_com_os_filtros_aplicados(): void
public function tela_oferece_etiquetas_a4260_com_pre_selecao_e_filtros_ativos(): void
public function listagem_e_mapa_reutilizam_o_mesmo_card_integral_sem_ramificacao_de_contexto(): void
public function tela_de_locais_exibe_rota_vinculada_e_estado_sem_rota(): void
public function modal_e_pdf_oferecem_rota_como_campo_opcional(): void
public function tela_de_locais_de_votacao_usa_tabela_de_coluna_unica_responsiva(): void
public function partial_compartilhada_exibe_lda_sim_apenas_para_local_de_dificil_acesso(): void
public function tela_de_locais_de_votacao_usa_select2_no_filtro_de_bairro_sem_quebrar_a_cascata(): void
public function tela_de_locais_usa_multiselect_sem_colapso_de_nomes_oficiais_e_preserva_o_pdf(): void
public function multiselects_vazios_mantem_altura_compacta_sem_impedir_crescimento_das_escolhas(): void
public function javascript_compartilhado_inicializa_select2_e_sincroniza_o_bairro_na_cascata(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Exportacao\EtiquetaLocalA4260Campos;
use App\Support\LocaisVotacao\Exportacao\LocalVotacaoCamposPdf;
use App\Support\LocaisVotacao\Exportacao\LocalVotacaoCamposXlsx;
use Illuminate\Pagination\LengthAwarePaginator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class LocalVotacaoLocaisUiTest extends TestCase
{
    #[Test]
    public function pdf_e_xlsx_compartilham_modal_com_pre_selecao_e_filtros_ativos(): void
    {
        $index = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));

        $this->assertIsString($index);
        $this->assertStringContainsString('Exportar para PDF', $index);
        $this->assertStringContainsString('Exportar XLSX', $index);
        $this->assertStringContainsString("route('lda.locais-votacao.exportar-xlsx')", $index);
        $this->assertStringContainsString('data-export-format="pdf"', $index);
        $this->assertStringContainsString('data-export-format="xlsx"', $index);
        $this->assertSame(3, substr_count($index, 'data-bs-target="#modalExportarLocais"'));
        $this->assertSame(1, substr_count($index, 'id="modalExportarLocais"'));
        $this->assertStringContainsString('data-export-hidden-bairros', $index);
        $this->assertStringContainsString('data-export-hidden-nomes-locais', $index);
        $this->assertStringContainsString('LocalVotacaoCamposXlsx::grupos()', $index);
        $this->assertStringContainsString('LocalVotacaoCamposXlsx::padrao()', $index);
        $this->assertContains('nome_local', LocalVotacaoCamposXlsx::padrao());
    }

    #[Test]
    public function tela_oferece_botao_font_awesome_para_etiquetas_a5_com_os_filtros_aplicados(): void
    {
        $index = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));

        $this->assertIsString($index);
        $this->assertStringContainsString('Etiquetas de seções — A5', $index);
        $this->assertStringContainsString('fa-solid fa-tags', $index);
        $this->assertStringContainsString("'modelo' => 'etiquetas_secoes_a5'", $index);
        $this->assertStringContainsString('array_merge($filtros', $index);
        $this->assertStringContainsString('target="_blank"', $index);
    }

    #[Test]
    public function tela_oferece_etiquetas_a4260_com_pre_selecao_e_filtros_ativos(): void
    {
        $index = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));

        $this->assertIsString($index);
        $this->assertStringContainsString('Etiquetas de locais — Pimaco A4260', $index);
        $this->assertStringContainsString('data-export-format="a4260"', $index);
        $this->assertStringContainsString('data-export-fields="a4260"', $index);
        $this->assertStringContainsString("'etiquetas_locais_a4260'", $index);
        $this->assertStringContainsString('EtiquetaLocalA4260Campos::disponiveis()', $index);
        $this->assertStringContainsString('EtiquetaLocalA4260Campos::padrao()', $index);
        $this->assertSame(
            ['zona', 'municipio', 'endereco', 'certificado_jeconnect'],
            EtiquetaLocalA4260Campos::padrao()
        );
    }

    #[Test]
    public function listagem_e_mapa_reutilizam_o_mesmo_card_integral_sem_ramificacao_de_contexto(): void
    {
        $listagem = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $mapa = file_get_contents(resource_path('views/lda/consolidacao/mapa-locais-votacao.blade.php'));
        $partial = resource_path('views/lda/partials/locais-votacao-filtros.blade.php');

        $this->assertIsString($listagem);
        $this->assertIsString($mapa);
        $this->assertFileExists($partial);
        $this->assertStringContainsString("@include('lda.partials.locais-votacao-filtros'", $listagem);
        $this->assertStringContainsString("@include('lda.partials.locais-votacao-filtros'", $mapa);
        $this->assertSame(1, substr_count($listagem, "@include('lda.partials.locais-votacao-filtros'"));
        $this->assertSame(1, substr_count($mapa, "@include('lda.partials.locais-votacao-filtros'"));

        $conteudoPartial = file_get_contents($partial);
        $this->assertIsString($conteudoPartial);
        $this->assertStringContainsString('class="card shadow-sm mb-3 locais-votacao-filtros-card"', $conteudoPartial);
        $this->assertStringContainsString('id="filtrosLocaisVotacao"', $conteudoPartial);
        $this->assertStringContainsString('data-locais-votacao-filtros', $conteudoPartial);
        $this->assertStringContainsString('data-locais-votacao-filtros-toggle', $conteudoPartial);
        $this->assertStringContainsString('data-locais-votacao-filtros-conteudo', $conteudoPartial);
        $this->assertStringContainsString('Aplicar filtros', $conteudoPartial);
        $this->assertStringContainsString('Limpar filtros', $conteudoPartial);
        $this->assertStringNotContainsString('$contextoFiltros', $conteudoPartial);
        $this->assertStringNotContainsString('$filtrosMapa', $conteudoPartial);
        $this->assertStringNotContainsString('id="filtrosLocaisVotacao"', $listagem);
        $this->assertStringNotContainsString('id="formMapaLocaisVotacao"', $mapa);
        $this->assertStringNotContainsString('mapa-filtros-card', $mapa);
    }

    #[Test]
    public function tela_de_locais_exibe_rota_vinculada_e_estado_sem_rota(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Rota:', $conteudo);
        $this->assertStringContainsString('$local->rota_label', $conteudo);
        $this->assertStringContainsString("'Sem rota'", $conteudo);
    }

    #[Test]
    public function modal_e_pdf_oferecem_rota_como_campo_opcional(): void
    {
        $index = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $pdf = file_get_contents(resource_path('views/lda/locais-votacao/pdf.blade.php'));
        $camposPdf = LocalVotacaoCamposPdf::gruposDetalhe();

        $this->assertIsString($index);
        $this->assertIsString($pdf);
        $this->assertSame('Rota', $camposPdf['local']['rota']);
        $this->assertNotContains('rota', LocalVotacaoCamposPdf::detalhePadrao());
        $this->assertStringContainsString("\$mostrar('rota')", $pdf);
        $this->assertStringContainsString('$local->rota_label', $pdf);
        $this->assertStringContainsString("'Sem rota'", $pdf);
    }

    #[Test]
    public function tela_de_locais_de_votacao_usa_tabela_de_coluna_unica_responsiva(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<th scope="col">Local</th>', $conteudo);
        $this->assertStringContainsString('<th scope="col">Ações</th>', $conteudo);
        $this->assertStringContainsString('fa-layer-group', $conteudo);
        $this->assertStringContainsString('fa-map-location-dot', $conteudo);
        $this->assertStringContainsString('fa-map-pin', $conteudo);
        $this->assertStringContainsString('fa-road', $conteudo);
        $this->assertStringContainsString('fa-list-ol', $conteudo);
        $this->assertStringContainsString('fa-users', $conteudo);
        $this->assertStringContainsString('fa-location-crosshairs', $conteudo);
        $this->assertStringContainsString('aria-label="Editar local"', $conteudo);
        $this->assertStringContainsString('title="Editar local"', $conteudo);
        $this->assertStringNotContainsString('locais-votacao__badge', $conteudo);
        $this->assertStringNotContainsString('@push(\'styles\')', $conteudo);
    }

    #[Test]
    public function partial_compartilhada_exibe_lda_sim_apenas_para_local_de_dificil_acesso(): void
    {
        $locais = new LengthAwarePaginator([
            (object) [
                'cod_objeto' => 'LDA-1',
                'num_local' => '101',
                'nom_local' => 'Local de dificil acesso',
                'cod_objeto_zona' => '1',
                'nom_localidade' => 'Municipio LDA',
                'nom_bairro' => 'Bairro LDA',
                'possui_lda' => 1,
            ],
            (object) [
                'cod_objeto' => 'COMUM-1',
                'num_local' => '102',
                'nom_local' => 'Local comum',
                'cod_objeto_zona' => '1',
                'nom_localidade' => 'Municipio comum',
                'nom_bairro' => 'Bairro comum',
                'possui_lda' => 0,
            ],
        ], 2, 20, 1, ['path' => '/lda/locais-votacao']);

        $html = view('lda.partials.locais-votacao-tabela', [
            'locais' => $locais,
        ])->render();

        $posicaoBairroLda = strpos($html, 'Bairro LDA');
        $posicaoIndicacaoLda = strpos($html, 'LDA: SIM');
        $posicaoBairroComum = strpos($html, 'Bairro comum');

        $this->assertNotFalse($posicaoBairroLda);
        $this->assertNotFalse($posicaoIndicacaoLda);
        $this->assertNotFalse($posicaoBairroComum);
        $this->assertSame(1, substr_count($html, 'LDA: SIM'));
        $this->assertGreaterThan($posicaoBairroLda, $posicaoIndicacaoLda);
        $this->assertLessThan($posicaoBairroComum, $posicaoIndicacaoLda);
        $this->assertStringNotContainsString('LDA: NÃO', $html);
    }

    #[Test]
    public function tela_de_locais_de_votacao_usa_select2_no_filtro_de_bairro_sem_quebrar_a_cascata(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<label for="filtroBairro" class="form-label">Bairro</label>', $conteudo);
        $this->assertStringContainsString('id="filtroBairro"', $conteudo);
        $this->assertStringContainsString('name="bairro[]"', $conteudo);
        $this->assertStringContainsString('multiple', $conteudo);
        $this->assertStringContainsString('class="form-select select2"', $conteudo);
        $this->assertStringContainsString('in_array($valorBairro, $bairrosSelecionados, true)', $conteudo);
        $this->assertStringContainsString('data-placeholder="{{ $municipioSelecionadoId === \'\' ? \'Selecione um município primeiro\' : \'Todos\' }}"', $conteudo);
        $this->assertStringContainsString("{{ \$municipioSelecionadoId === '' ? 'disabled' : '' }}", $conteudo);
    }

    #[Test]
    public function tela_de_locais_usa_multiselect_sem_colapso_de_nomes_oficiais_e_preserva_o_pdf(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();
        $view = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $javascriptPath = public_path('js/lda-locais-votacao-filtros.js');
        $cssPath = public_path('css/lda-locais-votacao-filtros.css');

        $this->assertIsString($view);
        $this->assertFileExists($javascriptPath);
        $this->assertFileExists($cssPath);
        $javascript = file_get_contents($javascriptPath);
        $css = file_get_contents($cssPath);
        $this->assertIsString($javascript);
        $this->assertIsString($css);
        $this->assertStringContainsString('name="nome_local[]"', $conteudo);
        $this->assertStringContainsString('data-nomes-locais-multiselect', $conteudo);
        $this->assertStringContainsString('multiple', $conteudo);
        $this->assertStringContainsString('nomesLocaisOpcoes', $conteudo);
        $this->assertStringNotContainsString('name="nome_local" class="form-control"', $conteudo);
        $this->assertStringContainsString("asset('js/lda-locais-votacao-filtros.js')", $view);
        $this->assertStringContainsString("asset('css/lda-locais-votacao-filtros.css')", $view);
        $this->assertStringContainsString('closeOnSelect: false', $javascript);
        $this->assertStringNotContainsString('locais-votacao-nomes-summary-active', $javascript);
        $this->assertStringNotContainsString('locais-votacao-nomes-summary-active', $css);
        $this->assertStringNotContainsString('select2-selection__choice--summary', $javascript);
        $this->assertStringNotContainsString('select2-selection__choice--summary', $css);
        $this->assertStringNotContainsString("select.on('select2:open.locaisVotacaoNomes'", $javascript);
        $this->assertStringNotContainsString("select.on('select2:close.locaisVotacaoNomes'", $javascript);
        $this->assertDoesNotMatchRegularExpression(
            '/\.select2-search--inline\s*\{[^}]*display:\s*none/s',
            $css
        );
        $this->assertStringContainsString('data-pdf-hidden-nomes-locais', $view);
        $this->assertStringContainsString("['nome_local[]', '[data-pdf-hidden-nomes-locais]']", $view);
        $this->assertStringContainsString('input.name = configuracao[0];', $view);
    }

    #[Test]
    public function multiselects_vazios_mantem_altura_compacta_sem_impedir_crescimento_das_escolhas(): void
    {
        $css = file_get_contents(public_path('css/lda-locais-votacao-filtros.css'));

        $this->assertIsString($css);
        $this->assertMatchesRegularExpression(
            '/\.locais-votacao-filtros-form \.select2-container \.select2-selection--multiple\s*\{[^}]*min-height:\s*38px;/s',
            $css
        );
        $this->assertDoesNotMatchRegularExpression(
            '/\.locais-votacao-filtros-form \.select2-selection--multiple \.select2-selection__rendered\s*\{[^}]*(?:min-height|display:\s*flex)/s',
            $css
        );
    }

    #[Test]
    public function javascript_compartilhado_inicializa_select2_e_sincroniza_o_bairro_na_cascata(): void
    {
        $view = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $conteudo = file_get_contents(public_path('js/lda-locais-votacao-filtros.js'));

        $this->assertIsString($view);
        $this->assertIsString($conteudo);
        $this->assertStringContainsString("asset('js/lda-locais-votacao-filtros.js')", $view);
        $this->assertStringNotContainsString('function atualizarSelect2Bairro()', $view);
        $this->assertStringContainsString('function atualizarSelect2Bairro()', $conteudo);
        $this->assertStringContainsString("document.getElementById('filtroBairro')", $conteudo);
        $this->assertStringContainsString("placeholder: bairro.dataset.placeholder || 'Todos'", $conteudo);
        $this->assertStringContainsString('allowClear: true', $conteudo);
        $this->assertStringContainsString('closeOnSelect: false', $conteudo);
        $this->assertStringContainsString("bairro.dataset.placeholder = municipio.value === ''", $conteudo);
        $this->assertStringContainsString("window.jQuery(bairro).trigger('change.select2');", $conteudo);
        $this->assertStringContainsString('atualizarSelect2Bairro();', $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_oferece_consulta_parametrizada_por_mesarios_convocados(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<legend class="float-none w-auto px-2 mb-0 fs-6">Consulta Parametrizada</legend>', $conteudo);
        $this->assertStringContainsString('<option value="mesarios_convocados"', $conteudo);
        $this->assertStringContainsString('Número de mesários convocados no local de votação', $conteudo);
        $this->assertStringContainsString('<option value="sem_coordenadas_capturadas"', $conteudo);
        $this->assertStringContainsString('Lista de Locais de Votação sem Coordenadas capturadas', $conteudo);
    }

    #[Test]
    public function javascript_da_consulta_parametrizada_desabilita_comparacao_e_quantidade_para_locais_sem_coordenadas(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-locais-votacao-filtros.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("const referenciasSemComparacao = ['sem_coordenadas_capturadas'];", $conteudo);
        $this->assertStringContainsString('function atualizarConsultaParametrizada()', $conteudo);
        $this->assertStringContainsString('comparacao.disabled = semComparacao;', $conteudo);
        $this->assertStringContainsString('quantidade.disabled = semComparacao;', $conteudo);
        $this->assertStringContainsString("referencia.addEventListener('change', atualizarConsultaParametrizada);", $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_carrega_mesarios_no_painel_compartilhado_do_local(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('data-detalhe-group', $conteudo);
        $this->assertStringContainsString('data-detalhe-trigger', $conteudo);
        $this->assertStringContainsString('data-detalhe-tipo="mesarios"', $conteudo);
        $this->assertStringContainsString("data-detalhe-url=\"{{ route('lda.locais-votacao.mesarios', \$local->cod_objeto) }}", $conteudo);
        $this->assertStringContainsString('data-detalhe-label-selector="[data-mesarios-label]"', $conteudo);
        $this->assertStringContainsString('Mesários convocados ({{ (int) ($local->qtd_mesarios_convocados ?? 0) }})', $conteudo);
        $this->assertStringContainsString("{{ number_format((int) (\$local->qtd_secoes_local ?? 0), 0, ',', '.') }} seções", $conteudo);
        $this->assertStringContainsString('Clique em um dos olhinhos para carregar mesários, recursos logísticos ou respostas GEL.', $conteudo);
        $this->assertStringContainsString("document.addEventListener('click', function (event)", $conteudo);
        $this->assertStringContainsString("var trigger = event.target.closest('[data-detalhe-trigger]');", $conteudo);
        $this->assertStringContainsString('cache[tipo] = payload;', $conteudo);
        $this->assertStringContainsString("label.textContent = labelPrefix + ' (' + Number(payload.total || 0) + ')';", $conteudo);
        $this->assertStringNotContainsString('data-mesarios-collapse', $conteudo);
        $this->assertStringNotContainsString("@include('lda.partials.mesarios-convocados'", $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_carrega_respostas_gel_no_mesmo_painel_compartilhado_do_local(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('$categoriasGelPorLocal', $conteudo);
        $this->assertStringContainsString('data-gel-label', $conteudo);
        $this->assertStringContainsString('data-gel-url', $conteudo);
        $this->assertStringContainsString('data-detalhe-tipo="gel-{{ $codCategoriaVistoria }}"', $conteudo);
        $this->assertStringContainsString('data-detalhe-target="#{{ $collapseDetalhesId }}"', $conteudo);
        $this->assertStringContainsString('data-detalhe-label-selector="#{{ $labelGelId }}"', $conteudo);
        $this->assertStringContainsString('lda.locais-votacao.gel-respostas', $conteudo);
        $this->assertStringContainsString('title="Mostrar respostas GEL da categoria', $conteudo);
        $this->assertStringContainsString('data-detalhe-loading="Carregando respostas GEL…"', $conteudo);
        $this->assertStringContainsString('Clique em um dos olhinhos para carregar mesários, recursos logísticos ou respostas GEL.', $conteudo);
        $this->assertStringNotContainsString('data-gel-collapse', $conteudo);
        $this->assertStringNotContainsString("@include('lda.partials.gel-respostas-categoria'", $conteudo);
    }

    #[Test]
    public function partial_de_respostas_gel_exibe_questao_e_resposta_sem_coluna_tipo(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/partials/gel-respostas-categoria.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('<th>Questão</th>', $conteudo);
        $this->assertStringContainsString('<th>Resposta</th>', $conteudo);
        $this->assertStringNotContainsString('<th style="width: 140px;">Tipo</th>', $conteudo);
        $this->assertStringNotContainsString("data_get(\$respostaGel, 'tipo_questao')", $conteudo);
    }

    #[Test]
    public function card_de_locais_exibe_resumo_lda_zona_urbana_e_zona_rural_nas_duas_listagens(): void
    {
        $interna = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $externa = file_get_contents(resource_path('views/forcas-seguranca/publico/locais-votacao.blade.php'));

        $this->assertIsString($interna);
        $this->assertIsString($externa);

        foreach ([$interna, $externa] as $conteudo) {
            $this->assertStringContainsString('>LOCAIS<', $conteudo);
            $this->assertStringNotContainsString('>Locais de difícil acesso<', $conteudo);
            $this->assertStringContainsString("\$resumo['secoes_lda']", $conteudo);
            $this->assertStringContainsString("\$resumo['locais_zona_urbana']", $conteudo);
            $this->assertStringContainsString("\$resumo['secoes_zona_urbana']", $conteudo);
            $this->assertStringContainsString("\$resumo['locais_zona_rural']", $conteudo);
            $this->assertStringContainsString("\$resumo['secoes_zona_rural']", $conteudo);
        }

        $this->assertStringContainsString('(LDA) Locais/Seções :', $interna);
        $this->assertStringContainsString('(URBANO) Locais/Seções:', $interna);
        $this->assertStringContainsString('(RURAL) Locais/Seções:', $interna);

        $this->assertStringContainsString('LDA/Seções em LDA:', $externa);
        $this->assertStringContainsString('Locais em Zona Urbana/Seções em zona Urbana:', $externa);
        $this->assertStringContainsString('Locais em Zona Rural/Seções em zona Rural:', $externa);
    }

    #[Test]
    public function card_de_locais_exibe_secoes_rurais_alocadas_em_local_urbano_nas_duas_listagens(): void
    {
        $interna = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $externa = file_get_contents(resource_path('views/forcas-seguranca/publico/locais-votacao.blade.php'));

        $this->assertIsString($interna);
        $this->assertIsString($externa);

        foreach ([$interna, $externa] as $conteudo) {
            $this->assertStringContainsString("\$resumo['secoes_rurais_alocadas_local_urbano']", $conteudo);
        }

        $this->assertStringContainsString('Seções Rurais Aloc. Local Urbano:', $interna);
        $this->assertStringContainsString('Seções Rurais alocadas em Local Urbano:', $externa);
    }

    #[Test]
    public function card_de_locais_filtrados_exibe_totalizacao_por_tipo_nas_duas_listagens(): void
    {
        $interna = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $externa = file_get_contents(resource_path('views/forcas-seguranca/publico/locais-votacao.blade.php'));

        $this->assertIsString($interna);
        $this->assertIsString($externa);

        foreach ([$interna, $externa] as $conteudo) {
            $this->assertStringContainsString('Por tipo de local', $conteudo);
            $this->assertStringContainsString("\$resumo['locais_por_tipo']", $conteudo);
        }
    }

    #[Test]
    public function filtro_de_locais_sem_secoes_e_mutuamente_exclusivo_e_preservado_no_pdf(): void
    {
        $interna = $this->conteudoTelaComFiltros();
        $externa = file_get_contents(resource_path('views/forcas-seguranca/publico/locais-votacao.blade.php'));

        $this->assertIsString($interna);
        $this->assertIsString($externa);

        foreach ([$interna, $externa] as $conteudo) {
            $this->assertStringContainsString('name="sem_secao"', $conteudo);
            $this->assertStringContainsString('Somente locais sem seções', $conteudo);
            $this->assertStringContainsString('id="pdfHiddenSemSecao"', $conteudo);
            $this->assertStringContainsString('somenteComSecoes.checked = false;', $conteudo);
            $this->assertStringContainsString('somenteSemSecoes.checked = false;', $conteudo);
        }
    }

    #[Test]
    public function tela_de_locais_de_votacao_oferece_consulta_parametrizada_por_quantidade_de_secoes_no_local(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('value="secoes_local"', $conteudo);
        $this->assertStringContainsString('Número de seções no local de votação', $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_exibe_card_de_tempo_de_deslocamento_filtrado(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('$resumoTempoDeslocamento', $conteudo);
        $this->assertStringContainsString('Tempo de deslocamento', $conteudo);
        $this->assertStringNotContainsString('Tempo de deslocamento GEL', $conteudo);
        $this->assertStringContainsString('Até 1h', $conteudo);
        $this->assertStringContainsString('Mais de 1h', $conteudo);
        $this->assertStringContainsString('Sem informação aproveitável', $conteudo);
        $this->assertStringNotContainsString('Zona selecionada', $conteudo);
        $this->assertStringContainsString('tempo_deslocamento_pendente', $conteudo);
        $this->assertStringContainsString('text-bg-warning', $conteudo);
        $this->assertStringContainsString('Pendente distância', $conteudo);
        $this->assertStringContainsString('tempo_deslocamento_classificacao', $conteudo);
        $this->assertStringContainsString('MAIS_1H', $conteudo);
        $this->assertStringContainsString('fa-triangle-exclamation', $conteudo);
        $this->assertStringContainsString('background-color: #fd7e14', $conteudo);
        $this->assertStringContainsString('Mais de 1h', $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_tem_filtros_avancados_de_lda_e_tempo(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="filtroExcluirLda"', $conteudo);
        $this->assertStringContainsString('name="excluir_lda"', $conteudo);
        $this->assertStringContainsString('Excluir LDA', $conteudo);
        $this->assertStringContainsString('id="filtroTempoDeslocamento"', $conteudo);
        $this->assertStringContainsString('name="tempo_deslocamento"', $conteudo);
        $this->assertStringContainsString('value="ate_1h"', $conteudo);
        $this->assertStringContainsString('value="mais_1h"', $conteudo);
        $this->assertStringContainsString('value="sem_info_aproveitavel"', $conteudo);
        $this->assertStringContainsString('function atualizarExclusividadeLda()', $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_exibe_tempo_de_deslocamento_logo_apos_bairro(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Tempo de Deslocamento:', $conteudo);
        $this->assertStringContainsString('tempo_deslocamento_descricao', $conteudo);
        $this->assertStringContainsString('{{ $local->tempo_deslocamento_descricao ?? \'Sem informação aproveitável\' }}', $conteudo);
        $this->assertStringNotContainsString('$tempoDeslocamentoLabel', $conteudo);
        $this->assertLessThan(
            strpos($conteudo, 'fa-road fa-fw'),
            strpos($conteudo, 'Tempo de Deslocamento:'),
            'Tempo de Deslocamento deve aparecer antes do endereco, logo apos o bairro.'
        );
    }

    #[Test]
    public function listagem_exibe_todas_as_alternativas_de_deslocamento_em_ordem(): void
    {
        $locais = new LengthAwarePaginator([
            (object) [
                'cod_objeto' => 'LV-1',
                'num_local' => '101',
                'nom_local' => 'Escola da Floresta',
                'cod_objeto_zona' => '1',
                'nom_localidade' => 'Rio Branco',
                'nom_bairro' => 'Centro',
                'trajetos_deslocamento' => [
                    [
                        'ordem_preferencia' => 1,
                        'principal' => true,
                        'descricao' => 'Via fluvial',
                        'tempo_descricao' => '30min (Crepúsculo)',
                        'transportes_descricao' => 'BARCO',
                    ],
                    [
                        'ordem_preferencia' => 2,
                        'principal' => false,
                        'descricao' => 'Alternativa aérea',
                        'tempo_descricao' => '2h (Crepúsculo)',
                        'transportes_descricao' => 'HELICÓPTERO',
                    ],
                    [
                        'ordem_preferencia' => 3,
                        'principal' => false,
                        'descricao' => '',
                        'tempo_descricao' => 'Sem tempo informado (Crepúsculo)',
                        'transportes_descricao' => 'CARRO',
                    ],
                ],
            ],
        ], 1, 10, 1, ['path' => '/lda/locais-votacao']);

        $html = view('lda.partials.locais-votacao-tabela', compact('locais'))->render();

        $this->assertStringContainsString('1ª (principal)', $html);
        $this->assertStringContainsString('Via fluvial', $html);
        $this->assertStringContainsString('30min (Crepúsculo)', $html);
        $this->assertStringContainsString('BARCO', $html);
        $this->assertStringContainsString('2ª', $html);
        $this->assertStringContainsString('2h (Crepúsculo)', $html);
        $this->assertStringContainsString('HELICÓPTERO', $html);
        $this->assertStringContainsString('3ª', $html);
        $this->assertStringContainsString('Sem tempo informado (Crepúsculo)', $html);
        $this->assertLessThan(strpos($html, '2ª'), strpos($html, '1ª (principal)'));
        $this->assertLessThan(strpos($html, '3ª'), strpos($html, '2ª'));
    }

    #[Test]
    public function pdf_de_locais_de_votacao_exibe_descricao_concreta_do_tempo_de_deslocamento(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/locais-votacao/pdf.blade.php'))
            ."\n".file_get_contents(resource_path('views/lda/partials/tempo-deslocamento.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Tempo de Deslocamento:', $conteudo);
        $this->assertStringContainsString('tempo_deslocamento_descricao', $conteudo);
        $this->assertStringContainsString('trajetos_deslocamento', $conteudo);
        $this->assertStringContainsString('ordem_preferencia', $conteudo);
        $this->assertStringContainsString('transportes_descricao', $conteudo);
        $this->assertStringContainsString('{{ $local->tempo_deslocamento_descricao ?? \'Sem informação aproveitável\' }}', $conteudo);
        $this->assertStringNotContainsString('$tempoDeslocamentoLabel', $conteudo);
    }

    #[Test]
    public function modal_pdf_preserva_bairros_multiplos_e_filtros_avancados(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('data-pdf-hidden-bairros', $conteudo);
        $this->assertStringContainsString('name="excluir_lda" value="{{ $filtros[\'excluir_lda\'] ?? \'\' }}"', $conteudo);
        $this->assertStringContainsString('name="tempo_deslocamento" value="{{ $filtros[\'tempo_deslocamento\'] ?? \'\' }}"', $conteudo);
        $this->assertStringContainsString('name="area_local" value="{{ $filtros[\'area_local\'] ?? \'\' }}"', $conteudo);
        $this->assertStringContainsString("['bairro[]', '[data-pdf-hidden-bairros]']", $conteudo);
        $this->assertStringContainsString("form.querySelectorAll('[name=\"' + configuracao[0] + '\"] option:checked')", $conteudo);
        $this->assertStringContainsString("form.querySelector('[name=\"' + par[0] + '\"]:checked')", $conteudo);
    }

    #[Test]
    public function tela_de_locais_de_votacao_usa_area_local_canonica_e_preserva_no_pdf(): void
    {
        $conteudo = $this->conteudoTelaComFiltros();

        $this->assertIsString($conteudo);
        $this->assertSame(3, substr_count($this->renderFiltros(), 'name="area_local"'));
        $this->assertStringContainsString('id="filtroAreaLocalTodos"', $conteudo);
        $this->assertStringContainsString('id="filtroAreaLocalUrbana"', $conteudo);
        $this->assertStringContainsString('id="filtroAreaLocalRural"', $conteudo);
        $this->assertStringContainsString('Somente zona urbana', $conteudo);
        $this->assertStringContainsString('Somente zona rural', $conteudo);
        $this->assertStringNotContainsString('id="filtroSomenteZonaRural"', $conteudo);
        $this->assertStringContainsString('id="pdfHiddenAreaLocal"', $conteudo);
        $this->assertStringContainsString("['area_local', 'pdfHiddenAreaLocal']", $conteudo);
    }

    #[Test]
    public function tela_exibe_acao_para_abrir_resultado_completo_no_mapa_na_mesma_aba(): void
    {
        $view = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $partial = file_get_contents(resource_path('views/lda/partials/locais-votacao-filtros.blade.php'));

        $this->assertIsString($view);
        $this->assertIsString($partial);
        $this->assertSame(1, preg_match('/<a\\b(?=[^>]*data-ver-resultado-mapa)[^>]*>/s', $view, $acao));
        $this->assertStringContainsString("route('lda.consolidacao.mapa-locais-votacao', \$filtrosMapaResultado)", $acao[0]);
        $this->assertStringContainsString('btn btn-outline-primary btn-sm', $acao[0]);
        $this->assertStringNotContainsString('target=', $acao[0]);
        $this->assertStringContainsString('Ver resultado no mapa', $view);
        $this->assertStringContainsString('class="d-flex flex-wrap justify-content-end gap-2 mb-3"', $view);
        $this->assertStringNotContainsString('data-ver-resultado-mapa', $partial);
    }

    #[Test]
    public function tela_de_locais_de_votacao_exibe_ver_no_mapa_apenas_com_coordenadas_efetivas(): void
    {
        $conteudo = $this->conteudoListagemCompartilhada();

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('$latitudeMapaLocal', $conteudo);
        $this->assertStringContainsString('$longitudeMapaLocal', $conteudo);
        $this->assertStringContainsString('$possuiCoordenadasMapaLocal', $conteudo);
        $this->assertStringContainsString('$coordenadasLdaValidas', $conteudo);
        $this->assertStringContainsString('$coordenadasStValidas', $conteudo);
        $this->assertStringContainsString("is_numeric(str_replace(',', '.', \$latitudeLdaLocal))", $conteudo);
        $this->assertStringContainsString("is_numeric(str_replace(',', '.', \$longitudeStLocal))", $conteudo);
        $this->assertStringContainsString('@if($possuiCoordenadasMapaLocal)', $conteudo);
        $this->assertStringContainsString("route('lda.consolidacao.mapa-locais-votacao', ['cod_objeto_local' => \$codigoLocal, 'nome_local' => [trim((string) (\$local->nom_local ?? ''))]])", $conteudo);
        $this->assertStringContainsString('Ver no Mapa', $conteudo);
        $this->assertStringContainsString('aria-label="Ver local no mapa"', $conteudo);
        $this->assertStringContainsString('title="Ver no Mapa"', $conteudo);
        $this->assertStringContainsString('fa-map-location-dot', $conteudo);
    }

    private function conteudoTelaComFiltros(): string
    {
        $view = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $partialPath = resource_path('views/lda/partials/locais-votacao-filtros.blade.php');
        $partial = is_file($partialPath) ? file_get_contents($partialPath) : '';
        $javascriptPath = public_path('js/lda-locais-votacao-filtros.js');
        $javascript = is_file($javascriptPath) ? file_get_contents($javascriptPath) : '';
        $renderizado = is_file($partialPath) ? $this->renderFiltros() : '';

        return (is_string($view) ? $view : '')
            ."\n".(is_string($partial) ? $partial : '')
            ."\n".$renderizado
            ."\n".(is_string($javascript) ? $javascript : '');
    }

    private function conteudoListagemCompartilhada(): string
    {
        $arquivos = [
            resource_path('views/lda/locais-votacao/index.blade.php'),
            resource_path('views/lda/partials/locais-votacao-tabela.blade.php'),
            resource_path('views/lda/partials/tempo-deslocamento.blade.php'),
            public_path('js/lda-locais-votacao-detalhes.js'),
        ];

        return collect($arquivos)
            ->map(static fn (string $arquivo): string => (string) file_get_contents($arquivo))
            ->implode("\n");
    }

    private function renderFiltros(): string
    {
        return view('lda.partials.locais-votacao-filtros', [
            'acaoFiltros' => '/lda/locais-votacao',
            'limparFiltrosUrl' => '/lda/locais-votacao',
            'filtros' => [
                'municipio' => '',
                'bairro' => [],
                'nome_local' => [],
                'area_local' => '',
            ],
            'zonas' => collect(),
            'municipios' => collect(),
            'bairros' => collect(),
            'nomesLocaisOpcoes' => collect(),
        ])->render();
    }
}
```
</TESTS_UNIT_LOCALVOTACAOLOCAISUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoPublicoExportTest.php`
## <TESTS_UNIT_LOCALVOTACAOPUBLICOEXPORTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoPublicoExportTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoPublicoExportTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_mapeia_area_coordenadas_marcacoes_e_protege_celulas_textuais(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Exports\LocaisVotacao\LocalVotacaoPublicoExport;
use Tests\TestCase;

class LocalVotacaoPublicoExportTest extends TestCase
{
    public function test_mapeia_area_coordenadas_marcacoes_e_protege_celulas_textuais(): void
    {
        $export = new LocalVotacaoPublicoExport(collect([
            (object) [
                'cod_objeto' => 'NAO-EXPORTAR',
                'cod_objeto_zona' => '001',
                'num_local' => '010',
                'nom_localidade' => '@RIO BRANCO',
                'nom_local' => '=ESCOLA A',
                'des_endereco' => '+RUA EXEMPLO',
                'area_local_efetiva' => 'rural',
                'num_latitude' => '-9.97499000',
                'num_longitude' => '-67.82430000',
                'secoes' => '-001 - apt - 120',
                'possui_alocacao_provisoria' => 1,
                'possui_secoes_agregadas' => 0,
                'mrjs' => [(object) ['num_mesa' => 904, 'tip_mrj' => 3]],
            ],
            (object) [
                'cod_objeto_zona' => '009',
                'nom_localidade' => 'SENA MADUREIRA',
                'nom_local' => 'ESCOLA B',
                'des_endereco' => 'RUA SEM NÚMERO',
                'area_local_efetiva' => 'urbana',
                'num_latitude' => null,
                'num_longitude' => '',
                'secoes' => '010 - apt - 200',
                'possui_alocacao_provisoria' => 0,
                'possui_secoes_agregadas' => 1,
                'mrjs' => [],
            ],
        ]));

        $this->assertSame([
            [
                'Zona',
                'Município',
                'Local de votação',
                'Endereço',
                'Área',
                'Latitude',
                'Longitude',
                'Seções',
                'Alocação provisória',
                'Seção agregada',
                'MRJ',
            ],
            [
                '001',
                "'@RIO BRANCO",
                "'=ESCOLA A",
                "'+RUA EXEMPLO",
                'Zona rural',
                -9.97499,
                -67.8243,
                "'-001 - apt - 120",
                'Sim',
                'Não',
                'MRJ 904 — Sem urna',
            ],
            [
                '009',
                'SENA MADUREIRA',
                'ESCOLA B',
                'RUA SEM NÚMERO',
                'Zona urbana',
                '',
                '',
                '010 - apt - 200',
                'Não',
                'Sim',
                '',
            ],
        ], $export->array());
    }
}
```
</TESTS_UNIT_LOCALVOTACAOPUBLICOEXPORTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoSequencialCommandTest.php`
## <TESTS_UNIT_LOCALVOTACAOSEQUENCIALCOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoSequencialCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoSequencialCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_sequencial_executa_ldas_depois_do_catalogo_e_rcand_ao_final(): void
public function test_falha_em_ldas_continua_as_demais_etapas_e_finaliza_com_erro(): void
public function test_falha_em_etapa_rcand_atualiza_status_agregado_e_interrompe_sequencial(): void
public function __construct(array &$ordem)
public function sincronizarLocalVotacaoSt(): array
public function sincronizarSecoes(): array
public function sincronizarMrj(): array
public function sincronizarSecoesAgregadas(): array
public function sincronizarSecaoAlocacaoProvisoria(): array
public function sincronizarBairros(): array
public function sincronizarEleitor(): array
public function sincronizarVagas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Lda\LdaLocalVotacaoSyncService;
use App\Services\LocaisVotacao\LocalVotacaoSyncService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use App\Services\Rcand\RcandSyncService;
use App\Services\Treinamentos\TreinamentoTseSyncService;
use RuntimeException;
use Tests\TestCase;
use Throwable;

class LocalVotacaoSequencialCommandTest extends TestCase
{
    public function test_sequencial_executa_ldas_depois_do_catalogo_e_rcand_ao_final(): void
    {
        $ordem = [];
        $status = new LocalVotacaoSequencialStatusFake();

        $this->app->instance(LocalVotacaoSyncService::class, new LocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(LdaLocalVotacaoSyncService::class, new LdaLocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(TreinamentoTseSyncService::class, new TreinamentoTseSequencialServiceFake($ordem));
        $this->app->instance(RcandSyncService::class, new RcandLocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->artisan('sync:local-votacao:sequencial')->assertExitCode(0);

        $this->assertSame(['local_votacao_st', 'mrj', 'ldas', 'secoes'], array_slice($ordem, 0, 4));
        $this->assertSame(
            ['rcand_pje', 'rcand_cand', 'rcand_candexweb', 'rcand_consolidado'],
            array_slice($ordem, -4)
        );
        $this->assertContains('sequencial', array_column($status->sucessos, 'etapa'));
        $this->assertContains('rcand_sequencial', array_column($status->sucessos, 'etapa'));
        $this->assertContains('ldas', array_column($status->sucessos, 'etapa'));
        $this->assertSame([], $status->erros);
    }

    public function test_falha_em_ldas_continua_as_demais_etapas_e_finaliza_com_erro(): void
    {
        $ordem = [];
        $status = new LocalVotacaoSequencialStatusFake();

        $this->app->instance(LocalVotacaoSyncService::class, new LocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(
            LdaLocalVotacaoSyncService::class,
            new LdaLocalVotacaoSequencialServiceFake($ordem, new RuntimeException('LDA indisponivel'))
        );
        $this->app->instance(TreinamentoTseSyncService::class, new TreinamentoTseSequencialServiceFake($ordem));
        $this->app->instance(RcandSyncService::class, new RcandLocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->artisan('sync:local-votacao:sequencial')->assertExitCode(1);

        $this->assertSame(['local_votacao_st', 'mrj', 'ldas', 'secoes'], array_slice($ordem, 0, 4));
        $this->assertContains('treinamento_tse', $ordem);
        $this->assertSame(
            ['rcand_pje', 'rcand_cand', 'rcand_candexweb', 'rcand_consolidado'],
            array_slice($ordem, -4)
        );
        $this->assertContains('ldas', array_column($status->erros, 'etapa'));
        $this->assertContains('sequencial', array_column($status->erros, 'etapa'));
        $this->assertContains('rcand_sequencial', array_column($status->sucessos, 'etapa'));
        $this->assertNotContains('sequencial', array_column($status->sucessos, 'etapa'));
    }

    public function test_falha_em_etapa_rcand_atualiza_status_agregado_e_interrompe_sequencial(): void
    {
        $ordem = [];
        $status = new LocalVotacaoSequencialStatusFake();

        $this->app->instance(LocalVotacaoSyncService::class, new LocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(LdaLocalVotacaoSyncService::class, new LdaLocalVotacaoSequencialServiceFake($ordem));
        $this->app->instance(TreinamentoTseSyncService::class, new TreinamentoTseSequencialServiceFake($ordem));
        $this->app->instance(
            RcandSyncService::class,
            new RcandLocalVotacaoSequencialServiceFake($ordem, 'rcand_cand')
        );
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->artisan('sync:local-votacao:sequencial')->assertExitCode(1);

        $this->assertContains('rcand_cand', array_column($status->erros, 'etapa'));
        $this->assertContains('rcand_sequencial', array_column($status->erros, 'etapa'));
        $this->assertContains('sequencial', array_column($status->erros, 'etapa'));
        $this->assertNotContains('rcand_sequencial', array_column($status->sucessos, 'etapa'));
        $this->assertNotContains('rcand_candexweb', $ordem);
    }
}

class LocalVotacaoSequencialServiceFake extends LocalVotacaoSyncService
{
    /** @var list<string> */
    private array $ordem;

    /** @param list<string> $ordem */
    public function __construct(array &$ordem)
    {
        $this->ordem =& $ordem;
    }

    public function sincronizarLocalVotacaoSt(): array
    {
        return $this->resultado('local_votacao_st');
    }

    public function sincronizarSecoes(): array
    {
        return $this->resultado('secoes');
    }

    public function sincronizarMrj(): array
    {
        return $this->resultado('mrj');
    }

    public function sincronizarSecoesAgregadas(): array
    {
        return $this->resultado('secoes_agregadas');
    }

    public function sincronizarSecaoAlocacaoProvisoria(): array
    {
        return $this->resultado('secao_alocacao_provisoria');
    }

    public function sincronizarBairros(): array
    {
        return $this->resultado('bairros');
    }

    public function sincronizarEleitor(): array
    {
        return $this->resultado('eleitor');
    }

    public function sincronizarVagas(): array
    {
        return $this->resultado('local_votacao_vagas');
    }

    public function sincronizarConvocacaoMesario(): array
    {
        return $this->resultado('convocacao_mesario');
    }

    /** @return array{dblink:string,origem_total:int,destino_total:int} */
    private function resultado(string $etapa): array
    {
        $this->ordem[] = $etapa;

        return ['dblink' => 'fake', 'origem_total' => 1, 'destino_total' => 1];
    }
}

class LdaLocalVotacaoSequencialServiceFake extends LdaLocalVotacaoSyncService
{
    /** @var list<string> */
    private array $ordem;

    /** @param list<string> $ordem */
    public function __construct(array &$ordem, private ?Throwable $erro = null)
    {
        $this->ordem =& $ordem;
    }

    public function sincronizar(): array
    {
        $this->ordem[] = 'ldas';

        if ($this->erro !== null) {
            throw $this->erro;
        }

        return [
            'dblink' => '',
            'origem_total' => 2,
            'destino_total' => 2,
            'ldas_total' => 1,
            'nomes_atualizados' => 1,
            'enderecos_atualizados' => 1,
            'relatorios_gerados' => 2,
        ];
    }
}

class TreinamentoTseSequencialServiceFake extends TreinamentoTseSyncService
{
    /** @var list<string> */
    private array $ordem;

    /** @param list<string> $ordem */
    public function __construct(array &$ordem)
    {
        $this->ordem =& $ordem;
    }

    public function sincronizar(): array
    {
        $this->ordem[] = 'treinamento_tse';

        return ['dblink' => 'fake', 'origem_total' => 1, 'destino_total' => 1, 'turmas_total' => 1];
    }
}

class RcandLocalVotacaoSequencialServiceFake extends RcandSyncService
{
    /** @var list<string> */
    private array $ordem;

    /** @param list<string> $ordem */
    public function __construct(array &$ordem, private ?string $etapaComErro = null)
    {
        $this->ordem =& $ordem;
    }

    public function sincronizarPje(): array
    {
        return $this->resultado('rcand_pje');
    }

    public function sincronizarCand(): array
    {
        return $this->resultado('rcand_cand');
    }

    public function sincronizarCandexweb(): array
    {
        return $this->resultado('rcand_candexweb');
    }

    public function sincronizarConsolidado(): array
    {
        return $this->resultado('rcand_consolidado');
    }

    /** @return array{dblink:string,origem_total:int,destino_total:int} */
    private function resultado(string $etapa): array
    {
        $this->ordem[] = $etapa;

        if ($this->etapaComErro === $etapa) {
            throw new RuntimeException("Falha simulada em {$etapa}");
        }

        return ['dblink' => 'fake', 'origem_total' => 1, 'destino_total' => 1];
    }
}

class LocalVotacaoSequencialStatusFake extends LocalVotacaoSyncStatusService
{
    /** @var list<array{etapa:string,resultado:array<string,mixed>}> */
    public array $sucessos = [];

    /** @var list<array{etapa:string,erro:Throwable|string}> */
    public array $erros = [];

    public function registrarSucesso(string $rotina, array $resultado = [], array $meta = []): void
    {
        $this->sucessos[] = [
            'etapa' => (string) ($meta['etapa'] ?? $rotina),
            'resultado' => $resultado,
        ];
    }

    public function registrarErro(string $rotina, Throwable|string $erro, array $meta = []): void
    {
        $this->erros[] = [
            'etapa' => (string) ($meta['etapa'] ?? $rotina),
            'erro' => $erro,
        ];
    }
}
```
</TESTS_UNIT_LOCALVOTACAOSEQUENCIALCOMMANDTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoSyncServiceTest.php`
## <TESTS_UNIT_LOCALVOTACAOSYNCSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoSyncServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoSyncServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_sql_de_mrj_carrega_historico_completo_do_ac_no_staging(): void
public function test_metadados_de_mrj_validam_tabela_e_view_remotas(): void
public function test_sql_de_promocao_mrj_substitui_snapshot_sem_truncate_na_tabela_definitiva(): void
public function test_montar_sql_insercao_vagas_reaproveita_sql_do_dblink_sem_inferencias_locais(): void
public function test_montar_sql_insercao_local_votacao_st_inclui_campos_novos_da_sincronizacao(): void
public function test_montar_sql_insercao_secoes_inclui_campos_novos_da_sincronizacao(): void
public function test_montar_sql_insercao_convocacao_mesario_usa_aliases_de_situacao_da_view_atual(): void
public function test_montar_sql_insercao_convocacao_mesario_preserva_colunas_antigas_quando_presentes(): void
public function test_montar_sql_insercao_convocacao_mesario_rejeita_situacao_sem_coluna_e_sem_alias(): void
public function test_tela_sincronizacao_convocacao_mesario_indica_substituicao_apos_validacao(): void
public function test_montar_sql_insercao_convocacao_mesario_substitui_todos_os_campos_opcionais_ausentes_da_view(): void
public function test_montar_sql_insercao_convocacao_mesario_lista_todos_os_campos_obrigatorios_ausentes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\LocaisVotacao\LocalVotacaoSyncService;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class LocalVotacaoSyncServiceTest extends TestCase
{
    public function test_sql_de_mrj_carrega_historico_completo_do_ac_no_staging(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlInsercaoMrjStage('CAD_TSE.WORLD');

        $this->assertStringContainsString('INSERT INTO planeleito.mrj_sync_stage', $sql);
        $this->assertStringContainsString('FROM mrj@CAD_TSE.WORLD m', $sql);
        $this->assertStringContainsString('INNER JOIN vw_mrj@CAD_TSE.WORLD v ON v.cod_objeto_mrj = m.cod_objeto', $sql);
        $this->assertStringContainsString("WHERE v.sgl_uf = 'AC'", $sql);
        $this->assertStringContainsString('m.cod_objeto_local_votacao', $sql);
        $this->assertStringContainsString('m.tip_mrj', $sql);
        $this->assertStringContainsString('m.ind_publico', $sql);
        $this->assertStringNotContainsString('ROWNUM', strtoupper($sql));
        $this->assertStringNotContainsString('FETCH FIRST', strtoupper($sql));
        $this->assertStringNotContainsString('DAT_ELEICAO =', strtoupper($sql));
    }

    public function test_metadados_de_mrj_validam_tabela_e_view_remotas(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlConsultaColunasMrj('CAD_TSE.WORLD');

        $this->assertStringContainsString('FROM all_tab_columns@CAD_TSE.WORLD', $sql);
        $this->assertStringContainsString("table_name IN ('MRJ', 'VW_MRJ')", $sql);
        $this->assertStringContainsString('table_name', $sql);
        $this->assertStringContainsString('column_name', $sql);
    }

    public function test_sql_de_promocao_mrj_substitui_snapshot_sem_truncate_na_tabela_definitiva(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlPromocaoMrj();

        $this->assertStringContainsString('INSERT INTO planeleito.mrj', $sql);
        $this->assertStringContainsString('FROM planeleito.mrj_sync_stage', $sql);
        $this->assertStringNotContainsString('TRUNCATE TABLE planeleito.mrj', $sql);
    }

    public function test_montar_sql_insercao_vagas_reaproveita_sql_do_dblink_sem_inferencias_locais(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlInsercaoVagas('CAD_TSE.WORLD');

        $this->assertStringContainsString('INSERT INTO planeleito.local_votacao_vagas', $sql);
        $this->assertStringContainsString('FROM local_votacao@CAD_TSE.WORLD lv', $sql);
        $this->assertStringContainsString('INNER JOIN bairro@CAD_TSE.WORLD b ON b.cod_objeto = lv.cod_objeto_bairro', $sql);
        $this->assertStringContainsString('INNER JOIN secao@CAD_TSE.WORLD s ON s.cod_objeto_local = lv.cod_objeto', $sql);
        $this->assertStringContainsString('INNER JOIN zona@CAD_TSE.WORLD z ON z.cod_objeto = lv.cod_objeto_zona', $sql);
        $this->assertStringContainsString('INNER JOIN localidade@CAD_TSE.WORLD m ON lv.cod_objeto_localidade = m.cod_objeto', $sql);
        $this->assertStringContainsString('WHERE lv.situacao IN (1, 5)', $sql);
        $this->assertStringContainsString("AND lv.sgl_uf = 'AC'", $sql);
        $this->assertStringContainsString('AND lv.tip_local = 1', $sql);
        $this->assertStringContainsString('-- AND s.cod_objeto NOT IN (', $sql);
        $this->assertStringContainsString('--       FROM secao_agregada@CAD_TSE.WORLD', $sql);
        $this->assertStringContainsString('lv.qtd_eleitores_secao - s.qtd_vagas_reservadas - s.qtd_aptos - s.qtd_suspensos', $sql);
        $this->assertStringContainsString('lv.qtd_secoes_previstas - COUNT(*)', $sql);
        $this->assertStringContainsString('qtd_eleitores_aptos_local', $sql);
        $this->assertStringContainsString('qtd_secoes_local', $sql);
        $this->assertStringContainsString('SUM(s.qtd_aptos) AS qtd_eleitores_aptos_local', $sql);
        $this->assertStringContainsString('COUNT(*) AS qtd_secoes_local', $sql);
    }

    public function test_montar_sql_insercao_local_votacao_st_inclui_campos_novos_da_sincronizacao(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlInsercaoLocalVotacaoSt('CAD_TSE.WORLD');

        $this->assertStringContainsString('situacao', $sql);
        $this->assertStringContainsString('qtd_secoes_previstas', $sql);
        $this->assertStringContainsString('qtd_eleitores_secao', $sql);
        $this->assertStringContainsString('lv.situacao', $sql);
        $this->assertStringContainsString('lv.qtd_secoes_previstas', $sql);
        $this->assertStringContainsString('lv.qtd_eleitores_secao', $sql);
        $this->assertStringContainsString('FROM local_votacao@CAD_TSE.WORLD lv', $sql);
        $this->assertStringContainsString('-- AND lv.tip_local = 1', $sql);
        $this->assertDoesNotMatchRegularExpression('/^\s+AND lv\.tip_local = 1/m', $sql);

        $sqlContagem = $service->montarSqlContagemLocalVotacaoSt('CAD_TSE.WORLD');
        $this->assertStringContainsString('-- AND lv.tip_local = 1', $sqlContagem);
        $this->assertDoesNotMatchRegularExpression('/^\s+AND lv\.tip_local = 1/m', $sqlContagem);
    }

    public function test_montar_sql_insercao_secoes_inclui_campos_novos_da_sincronizacao(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlInsercaoSecoes('CAD_TSE.WORLD');

        $this->assertStringContainsString('cod_objeto_uf', $sql);
        $this->assertStringContainsString('situacao', $sql);
        $this->assertStringContainsString('qtd_vagas_reservadas', $sql);
        $this->assertStringContainsString('qtd_suspensos', $sql);
        $this->assertStringContainsString('secao.cod_objeto_uf', $sql);
        $this->assertStringContainsString('secao.qtd_vagas_reservadas', $sql);
        $this->assertStringContainsString('secao.qtd_suspensos', $sql);
        $this->assertStringContainsString('FROM secao@CAD_TSE.WORLD secao', $sql);
    }

    public function test_montar_sql_insercao_convocacao_mesario_usa_aliases_de_situacao_da_view_atual(): void
    {
        $service = new LocalVotacaoSyncService();
        $colunasOrigem = array_values(array_diff(
            LocalVotacaoSyncService::colunasEsperadasConvocacaoMesario(),
            ['ind_situacao_pe', 'des_ind_situacao_pe']
        ));
        $colunasOrigem[] = 'ind_situacao_convocacao';
        $colunasOrigem[] = 'des_situacao_convocacao';

        $sql = $service->montarSqlInsercaoConvocacaoMesario('CAD_TSE.WORLD', $colunasOrigem);
        $selectSql = substr($sql, strpos($sql, 'SELECT'), strpos($sql, 'FROM vw_convocacao_mesario') - strpos($sql, 'SELECT'));

        $this->assertStringContainsString('ind_situacao_convocacao AS ind_situacao_pe', $selectSql);
        $this->assertStringContainsString('des_situacao_convocacao AS des_ind_situacao_pe', $selectSql);
        $this->assertStringNotContainsString("\n                ind_situacao_pe,\n", $selectSql);
        $this->assertStringNotContainsString("\n                des_ind_situacao_pe,\n", $selectSql);
    }

    public function test_montar_sql_insercao_convocacao_mesario_preserva_colunas_antigas_quando_presentes(): void
    {
        $service = new LocalVotacaoSyncService();
        $colunasOrigem = LocalVotacaoSyncService::colunasEsperadasConvocacaoMesario();
        $colunasOrigem[] = 'ind_situacao_convocacao';
        $colunasOrigem[] = 'des_situacao_convocacao';

        $sql = $service->montarSqlInsercaoConvocacaoMesario('CAD_TSE.WORLD', $colunasOrigem);
        $selectSql = substr($sql, strpos($sql, 'SELECT'), strpos($sql, 'FROM vw_convocacao_mesario') - strpos($sql, 'SELECT'));

        $this->assertStringContainsString("\n                ind_situacao_pe,\n", $selectSql);
        $this->assertStringContainsString("\n                des_ind_situacao_pe,\n", $selectSql);
        $this->assertStringNotContainsString('ind_situacao_convocacao AS ind_situacao_pe', $selectSql);
        $this->assertStringNotContainsString('des_situacao_convocacao AS des_ind_situacao_pe', $selectSql);
    }

    public function test_montar_sql_insercao_convocacao_mesario_rejeita_situacao_sem_coluna_e_sem_alias(): void
    {
        $service = new LocalVotacaoSyncService();
        $colunasOrigem = array_values(array_diff(
            LocalVotacaoSyncService::colunasEsperadasConvocacaoMesario(),
            ['ind_situacao_pe', 'des_ind_situacao_pe', 'dat_alteracao_endereco', 'dat_alteracao_contato']
        ));

        try {
            $service->montarSqlInsercaoConvocacaoMesario('CAD_TSE.WORLD', $colunasOrigem);
            $this->fail('A sincronizacao deveria rejeitar situacao sem coluna local e sem alias.');
        } catch (\RuntimeException $e) {
            $mensagem = $e->getMessage();
        }

        $this->assertStringContainsString('IND_SITUACAO_PE', $mensagem);
        $this->assertStringContainsString('DES_IND_SITUACAO_PE', $mensagem);
        $this->assertStringNotContainsString('DAT_ALTERACAO_ENDERECO', $mensagem);
        $this->assertStringNotContainsString('DAT_ALTERACAO_CONTATO', $mensagem);
    }

    public function test_tela_sincronizacao_convocacao_mesario_indica_substituicao_apos_validacao(): void
    {
        $view = file_get_contents(resource_path('views/administracao-global/sincronizacao-local-votacao/index.blade.php'));

        $this->assertStringContainsString('Tabela substituida apos validacao da origem: <code>PLANELEITO.CAD_CONVOCACAO_MESARIO_TSE</code>', $view);
        $this->assertStringNotContainsString('Tabela truncada: <code>PLANELEITO.CAD_CONVOCACAO_MESARIO_TSE</code>', $view);
    }

    public function test_montar_sql_insercao_convocacao_mesario_substitui_todos_os_campos_opcionais_ausentes_da_view(): void
    {
        $service = new LocalVotacaoSyncService();
        $colunasOrigem = array_values(array_diff(
            LocalVotacaoSyncService::colunasEsperadasConvocacaoMesario(),
            ['dat_alteracao_endereco', 'dat_alteracao_contato']
        ));

        $sql = $service->montarSqlInsercaoConvocacaoMesario('CAD_TSE.WORLD', $colunasOrigem);

        $selectSql = substr($sql, strpos($sql, 'SELECT'), strpos($sql, 'FROM vw_convocacao_mesario') - strpos($sql, 'SELECT'));

        $this->assertStringContainsString('INSERT INTO planeleito.cad_convocacao_mesario_tse', $sql);
        $this->assertStringContainsString('FROM vw_convocacao_mesario@CAD_TSE.WORLD', $sql);
        $this->assertStringContainsString('dat_alteracao,', $selectSql);
        $this->assertStringContainsString('CAST(NULL AS DATE) AS dat_alteracao_endereco', $selectSql);
        $this->assertStringContainsString('CAST(NULL AS DATE) AS dat_alteracao_contato', $selectSql);
        $this->assertStringNotContainsString("\n                dat_alteracao_endereco,\n", $selectSql);
        $this->assertStringNotContainsString("\n                dat_alteracao_contato\n", $selectSql);
    }

    public function test_montar_sql_insercao_convocacao_mesario_lista_todos_os_campos_obrigatorios_ausentes(): void
    {
        $service = new LocalVotacaoSyncService();
        $colunasOrigem = array_values(array_diff(
            LocalVotacaoSyncService::colunasEsperadasConvocacaoMesario(),
            ['num_cpf', 'des_email', 'dat_alteracao_endereco', 'dat_alteracao_contato']
        ));

        try {
            $service->montarSqlInsercaoConvocacaoMesario('CAD_TSE.WORLD', $colunasOrigem);
            $this->fail('A sincronizacao deveria rejeitar colunas obrigatorias ausentes.');
        } catch (\RuntimeException $e) {
            $mensagem = $e->getMessage();
        }

        $this->assertStringContainsString('NUM_CPF', $mensagem);
        $this->assertStringContainsString('DES_EMAIL', $mensagem);
        $this->assertStringNotContainsString('DAT_ALTERACAO_ENDERECO', $mensagem);
        $this->assertStringNotContainsString('DAT_ALTERACAO_CONTATO', $mensagem);
    }

    public function test_sincronizar_convocacao_mesario_valida_colunas_antes_de_truncar(): void
    {
        config(['planeleito.sync.convocacao_mesario_dblink' => 'CAD_TSE.WORLD']);
        $colunasOrigem = array_values(array_diff(
            LocalVotacaoSyncService::colunasEsperadasConvocacaoMesario(),
            ['num_cpf']
        ));
        $linhasMetadados = array_map(
            static fn (string $coluna): object => (object) ['COLUMN_NAME' => strtoupper($coluna)],
            $colunasOrigem
        );

        DB::shouldReceive('select')
            ->once()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains($sql, 'all_tab_columns@CAD_TSE.WORLD')))
            ->andReturn($linhasMetadados);
        DB::shouldReceive('statement')->never();

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('NUM_CPF');

        (new LocalVotacaoSyncService())->sincronizarConvocacaoMesario();
    }

    public function test_montar_sql_consulta_colunas_convocacao_mesario_usa_metadados_do_dblink(): void
    {
        $service = new LocalVotacaoSyncService();

        $sql = $service->montarSqlConsultaColunasConvocacaoMesario('CAD_TSE.WORLD');

        $this->assertStringContainsString('FROM all_tab_columns@CAD_TSE.WORLD', $sql);
        $this->assertStringContainsString("table_name = 'VW_CONVOCACAO_MESARIO'", $sql);
        $this->assertStringContainsString('LOWER(column_name) AS column_name', $sql);
    }
}
```
</TESTS_UNIT_LOCALVOTACAOSYNCSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoSyncStatusServiceTest.php`
## <TESTS_UNIT_LOCALVOTACAOSYNCSTATUSSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoSyncStatusServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoSyncStatusServiceTest extends TestCase`

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
public function test_erro_sequencial_resolvido_por_sucesso_posterior_da_etapa_nao_aparece_como_erro_pendente(): void
public function test_erro_sequencial_permanece_quando_etapa_falhada_nao_tem_sucesso_posterior(): void
public function test_treinamento_tse_aparece_no_monitor_com_as_contagens_da_carga(): void
public function test_mrj_aparece_no_monitor_com_as_contagens_do_snapshot(): void
public function test_ldas_aparecem_no_monitor_com_as_contagens_da_reconciliacao(): void
public function test_sucesso_posterior_dos_ldas_resolve_erro_agregado_do_sequencial(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\Cache;
use Tests\TestCase;

class LocalVotacaoSyncStatusServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Cache::flush();
        CarbonImmutable::setTestNow(null);
    }

    protected function tearDown(): void
    {
        CarbonImmutable::setTestNow(null);
        Cache::flush();

        parent::tearDown();
    }

    public function test_erro_sequencial_resolvido_por_sucesso_posterior_da_etapa_nao_aparece_como_erro_pendente(): void
    {
        $service = new LocalVotacaoSyncStatusService();

        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-06-24 01:00:00'));
        $service->registrarErro(
            'sync:local-votacao:sequencial',
            'Falha na etapa convocacao_mesario: ORA-00904',
            ['etapa' => 'sequencial', 'origem' => 'artisan']
        );

        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-06-24 01:10:00'));
        $service->registrarSucesso(
            'sync:convocacao-mesario',
            ['dblink' => 'CAD_TSE.WORLD', 'origem_total' => 10, 'destino_total' => 10],
            ['etapa' => 'convocacao_mesario', 'origem' => 'artisan']
        );

        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        $this->assertSame('resolvido', $registros['sequencial']['status']);
        $this->assertNull($registros['sequencial']['mensagem']);
        $this->assertSame('24/06/2026 01:10:00', $registros['sequencial']['executado_em_formatado']);
        $this->assertSame('sucesso', $registros['convocacao_mesario']['status']);
    }

    public function test_erro_sequencial_permanece_quando_etapa_falhada_nao_tem_sucesso_posterior(): void
    {
        $service = new LocalVotacaoSyncStatusService();

        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-06-24 01:00:00'));
        $service->registrarErro(
            'sync:local-votacao:sequencial',
            'ORA-00904',
            ['etapa' => 'convocacao_mesario', 'origem' => 'artisan']
        );
        $service->registrarErro(
            'sync:local-votacao:sequencial',
            'Falha na etapa convocacao_mesario: ORA-00904',
            ['etapa' => 'sequencial', 'origem' => 'artisan']
        );

        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        $this->assertSame('erro', $registros['sequencial']['status']);
        $this->assertSame('Falha na etapa convocacao_mesario: ORA-00904', $registros['sequencial']['mensagem']);
    }

    public function test_treinamento_tse_aparece_no_monitor_com_as_contagens_da_carga(): void
    {
        $service = new LocalVotacaoSyncStatusService();
        $service->registrarSucesso(
            'sync:treinamento-tse',
            ['dblink' => 'cad_tse', 'origem_total' => 41, 'destino_total' => 41],
            ['etapa' => 'treinamento_tse', 'origem' => 'artisan']
        );

        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        $this->assertSame('Turmas de treinamento ELO', $registros['treinamento_tse']['label']);
        $this->assertSame('sucesso', $registros['treinamento_tse']['status']);
        $this->assertSame(41, $registros['treinamento_tse']['resultado']['origem_total']);
        $this->assertSame(41, $registros['treinamento_tse']['resultado']['destino_total']);
    }

    public function test_mrj_aparece_no_monitor_com_as_contagens_do_snapshot(): void
    {
        $service = new LocalVotacaoSyncStatusService();
        $service->registrarSucesso(
            'sync:mrj',
            ['dblink' => 'cad_tse', 'origem_total' => 22, 'destino_total' => 22],
            ['etapa' => 'mrj', 'origem' => 'artisan']
        );

        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        $this->assertSame('Mesas Receptoras de Justificativa (MRJ)', $registros['mrj']['label']);
        $this->assertSame('sucesso', $registros['mrj']['status']);
        $this->assertSame(22, $registros['mrj']['resultado']['origem_total']);
        $this->assertSame(22, $registros['mrj']['resultado']['destino_total']);
    }

    public function test_ldas_aparecem_no_monitor_com_as_contagens_da_reconciliacao(): void
    {
        $service = new LocalVotacaoSyncStatusService();
        $service->registrarSucesso(
            'sync:ldas',
            [
                'origem_total' => 3,
                'destino_total' => 3,
                'ldas_total' => 2,
                'nomes_atualizados' => 2,
                'enderecos_atualizados' => 1,
                'relatorios_gerados' => 2,
            ],
            ['etapa' => 'ldas', 'origem' => 'artisan']
        );

        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        $this->assertSame('LDAs', $registros['ldas']['label']);
        $this->assertSame('sucesso', $registros['ldas']['status']);
        $this->assertSame(3, $registros['ldas']['resultado']['origem_total']);
        $this->assertSame(3, $registros['ldas']['resultado']['destino_total']);
    }

    public function test_sucesso_posterior_dos_ldas_resolve_erro_agregado_do_sequencial(): void
    {
        $service = new LocalVotacaoSyncStatusService();

        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-07-28 01:00:00'));
        $service->registrarErro(
            'sync:local-votacao:sequencial',
            'Falha na etapa ldas: auditoria indisponivel',
            ['etapa' => 'sequencial', 'origem' => 'artisan']
        );

        CarbonImmutable::setTestNow(CarbonImmutable::parse('2026-07-28 01:10:00'));
        $service->registrarSucesso(
            'sync:ldas',
            ['origem_total' => 3, 'destino_total' => 3],
            ['etapa' => 'ldas', 'origem' => 'artisan']
        );

        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        $this->assertSame('resolvido', $registros['sequencial']['status']);
        $this->assertNull($registros['sequencial']['mensagem']);
        $this->assertSame('sucesso', $registros['ldas']['status']);
    }
}
```
</TESTS_UNIT_LOCALVOTACAOSYNCSTATUSSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoSyncUiTest.php`
## <TESTS_UNIT_LOCALVOTACAOSYNCUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoSyncUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoSyncUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_tela_manual_oferece_sincronizacao_isolada_de_mrj(): void
public function test_tela_manual_informa_reconciliacao_e_renderiza_contagens_de_lda(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class LocalVotacaoSyncUiTest extends TestCase
{
    public function test_tela_manual_oferece_sincronizacao_isolada_de_mrj(): void
    {
        $blade = (string) file_get_contents(resource_path('views/administracao-global/sincronizacao-local-votacao/index.blade.php'));
        $javascript = (string) file_get_contents(public_path('js/administracao-global/sync-local-votacao.js'));
        $rotas = (string) file_get_contents(base_path('routes/web.php'));

        $this->assertStringContainsString('Mesas Receptoras de Justificativa (MRJ)', $blade);
        $this->assertStringContainsString('data-sync-action="mrj"', $blade);
        $this->assertStringContainsString("'mrj'", $javascript);
        $this->assertStringContainsString('/sincronizacao/local-votacao/mrj/executar', $rotas);
        $this->assertStringContainsString('administracao-global.sync-local-votacao.mrj.executar', $rotas);
    }

    public function test_tela_manual_informa_reconciliacao_e_renderiza_contagens_de_lda(): void
    {
        $blade = (string) file_get_contents(resource_path('views/administracao-global/sincronizacao-local-votacao/index.blade.php'));
        $javascript = (string) file_get_contents(public_path('js/administracao-global/sync-local-votacao.js'));

        $this->assertStringContainsString('os snapshots de nome e endereço dos LDAs são reconciliados', $blade);
        $this->assertStringContainsString('const ldas = r.ldas || null;', $javascript);
        $this->assertStringContainsString('ldas.ldas_total', $javascript);
        $this->assertStringContainsString('ldas.nomes_atualizados', $javascript);
        $this->assertStringContainsString('ldas.enderecos_atualizados', $javascript);
        $this->assertStringContainsString('local_votacao_st e reconciliar os LDAs', $javascript);
    }
}
```
</TESTS_UNIT_LOCALVOTACAOSYNCUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoTransmissaoZonaTest.php`
## <TESTS_UNIT_LOCALVOTACAOTRANSMISSAOZONATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoTransmissaoZonaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoTransmissaoZonaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_endpoint_deriva_zona_do_local_autorizado_e_ignora_municipio(): void
public function test_endpoint_retorna_vazio_sem_local_de_votacao_autorizado(): void
public function test_repository_filtra_lt_e_lda_pela_zona_sem_restringir_municipio(): void
public function test_componente_envia_codigo_do_local_sem_parametro_municipal(): void
public function test_componente_renderiza_multiplos_marcadores_e_protege_preferencias_fixas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\LocaisVotacao\LocalVotacaoCrudController;
use App\Repositories\Gel\GelRespostaRepository;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\Lda\TransmissaoPreferenciaService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class LocalVotacaoTransmissaoZonaTest extends TestCase
{
    protected function tearDown(): void
    {
        $reflexao = new \ReflectionClass(LocalVotacaoRepository::class);
        $propriedade = $reflexao->getProperty('ldaIdDisponivel');
        $propriedade->setAccessible(true);
        $propriedade->setValue(null, null);

        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_endpoint_deriva_zona_do_local_autorizado_e_ignora_municipio(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')
            ->once()
            ->with('LV-123', [4, 9], false)
            ->andReturn((object) [
                'cod_objeto' => 'LV-123',
                'cod_objeto_zona' => '004',
            ]);

        $preferencias = Mockery::mock(TransmissaoPreferenciaService::class);
        $preferencias->shouldReceive('pesquisar')
            ->once()
            ->with('radio', 4)
            ->andReturn([
                ['id' => 'lt:7', 'text' => 'Posto remoto', 'municipio' => 'SENA MADUREIRA'],
            ]);

        $controller = new LocalVotacaoCrudController(
            $repository,
            Mockery::mock(LocalDificilAcessoRepository::class),
            $preferencias,
            Mockery::mock(GelRespostaRepository::class)->shouldIgnoreMissing()
        );

        $response = $controller->locaisTransmissao(new Request([
            'q' => 'radio',
            'cod_objeto_local' => 'LV-123',
            'municipio' => 'RIO BRANCO',
        ]));

        $this->assertSame('SENA MADUREIRA', $response->getData(true)[0]['municipio']);
    }

    public function test_endpoint_retorna_vazio_sem_local_de_votacao_autorizado(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')
            ->once()
            ->with('LV-999', [4], false)
            ->andReturn(null);

        $preferencias = Mockery::mock(TransmissaoPreferenciaService::class);
        $preferencias->shouldNotReceive('pesquisar');

        $controller = new LocalVotacaoCrudController(
            $repository,
            Mockery::mock(LocalDificilAcessoRepository::class),
            $preferencias,
            Mockery::mock(GelRespostaRepository::class)->shouldIgnoreMissing()
        );

        $response = $controller->locaisTransmissao(new Request([
            'q' => 'radio',
            'cod_objeto_local' => 'LV-999',
        ]));

        $this->assertSame([], $response->getData(true));
    }

    public function test_repository_filtra_lt_e_lda_pela_zona_sem_restringir_municipio(): void
    {
        $reflexao = new \ReflectionClass(LocalVotacaoRepository::class);
        $propriedade = $reflexao->getProperty('ldaIdDisponivel');
        $propriedade->setAccessible(true);
        $propriedade->setValue(null, true);

        DB::shouldReceive('select')
            ->once()
            ->with(
                Mockery::on(static function (string $sql): bool {
                    return str_contains($sql, 'lt.zona_num = :zona')
                        && str_contains($sql, 'JOIN zona z_lda ON z_lda.id = l.zona_id')
                        && str_contains($sql, 'z_lda.num_zona = :zona')
                        && !str_contains($sql, ':municipio');
                }),
                Mockery::on(static function (array $bindings): bool {
                    return ($bindings['zona'] ?? null) === 4
                        && !array_key_exists('municipio', $bindings);
                })
            )
            ->andReturn([]);

        $repository = new LocalVotacaoRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertSame([], $repository->pesquisarOpcoesTransmissao('radio', 4));
    }

    public function test_componente_envia_codigo_do_local_sem_parametro_municipal(): void
    {
        $formulario = file_get_contents(resource_path('views/lda/locais-votacao/form.blade.php'));
        $componente = file_get_contents(resource_path('views/lda/partials/transmissao-preferencias.blade.php'));

        $this->assertIsString($formulario);
        $this->assertIsString($componente);
        $this->assertStringContainsString("'codObjetoLocalPreferencias' => \$local->cod_objeto", $formulario);
        $this->assertStringNotContainsString("'municipioPreferencias'", $formulario);
        $this->assertStringContainsString('data-cod-objeto-local', $componente);
        $this->assertStringContainsString('cod_objeto_local:', $componente);
        $this->assertStringNotContainsString('data-municipio', $componente);
        $this->assertStringNotContainsString("municipio: select.data('municipio')", $componente);
    }

    public function test_componente_renderiza_multiplos_marcadores_e_protege_preferencias_fixas(): void
    {
        $componente = file_get_contents(resource_path('views/lda/partials/transmissao-preferencias.blade.php'));

        $this->assertIsString($componente);
        $this->assertStringContainsString('item.marcadores.forEach', $componente);
        $this->assertStringContainsString("marcadores: Array.isArray(item.marcadores)", $componente);
        $this->assertStringContainsString('preferencias[indiceDestino].fixa', $componente);
        $this->assertStringContainsString('btnRemover.disabled = Boolean(item.fixa)', $componente);
        $this->assertStringContainsString("fixaSpan.textContent = item.rotulo_fixo || item.via_rota || 'Próprio'", $componente);
    }
}
```
</TESTS_UNIT_LOCALVOTACAOTRANSMISSAOZONATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoZonaRuralControllerTest.php`
## <TESTS_UNIT_LOCALVOTACAOZONARURALCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoZonaRuralControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoZonaRuralControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_update_revalida_escopo_e_persiste_marcacao_informada(): void
public function test_update_sem_campo_legado_nao_altera_marcacao(): void
public function test_update_fora_do_escopo_retorna_404_sem_qualquer_escrita(): void
public function test_edit_fora_do_escopo_retorna_404_sem_carregar_marcacao(): void
private function controller(
private function request(array $dados): LocalVotacaoUpdateRequest
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\LocaisVotacao\LocalVotacaoCrudController;
use App\Http\Requests\LocaisVotacao\LocalVotacaoUpdateRequest;
use App\Repositories\Gel\GelRespostaRepository;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoZonaRuralRepository;
use App\Services\Lda\TransmissaoPreferenciaService;
use Mockery;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Tests\TestCase;

class LocalVotacaoZonaRuralControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_update_revalida_escopo_e_persiste_marcacao_informada(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 0,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with('LV-1', [4], false)->andReturn((object) [
            'cod_objeto' => 'LV-1',
        ]);
        $repository->shouldReceive('atualizarCoordenadas')->once()->with('LV-1', null, null);

        $transmissao = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissao->shouldReceive('sincronizar')->once()->with('LV-1', []);

        $marcacao = Mockery::mock(LocalVotacaoZonaRuralRepository::class);
        $marcacao->shouldReceive('sincronizarMarcacao')->once()->with('LV-1', true);

        $controller = $this->controller($repository, $transmissao, $marcacao);
        $response = $controller->update($this->request(['zona_rural_manual' => '1']), 'LV-1');

        $this->assertTrue($response->isRedirect(route('lda.locais-votacao.index')));
    }

    public function test_update_sem_campo_legado_nao_altera_marcacao(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 0,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with('LV-1', [4], false)->andReturn((object) [
            'cod_objeto' => 'LV-1',
        ]);
        $repository->shouldReceive('atualizarCoordenadas')->once()->with('LV-1', null, null);

        $transmissao = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissao->shouldReceive('sincronizar')->once()->with('LV-1', []);

        $marcacao = Mockery::mock(LocalVotacaoZonaRuralRepository::class);
        $marcacao->shouldNotReceive('sincronizarMarcacao');

        $this->controller($repository, $transmissao, $marcacao)
            ->update($this->request([]), 'LV-1');

        $this->addToAssertionCount(1);
    }

    public function test_update_fora_do_escopo_retorna_404_sem_qualquer_escrita(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with('LV-9', [4], false)->andReturnNull();
        $repository->shouldNotReceive('atualizarCoordenadas');

        $transmissao = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissao->shouldNotReceive('sincronizar');

        $marcacao = Mockery::mock(LocalVotacaoZonaRuralRepository::class);
        $marcacao->shouldNotReceive('sincronizarMarcacao');

        $this->expectException(NotFoundHttpException::class);
        $this->controller($repository, $transmissao, $marcacao)
            ->update($this->request(['zona_rural_manual' => '1']), 'LV-9');
    }

    public function test_edit_fora_do_escopo_retorna_404_sem_carregar_marcacao(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with('LV-9', [4], false)->andReturnNull();

        $transmissao = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissao->shouldNotReceive('prepararParaFormulario');

        $marcacao = Mockery::mock(LocalVotacaoZonaRuralRepository::class);
        $marcacao->shouldNotReceive('estaMarcado');

        $this->expectException(NotFoundHttpException::class);
        $this->controller($repository, $transmissao, $marcacao)->edit('LV-9');
    }

    private function controller(
        LocalVotacaoRepository $repository,
        TransmissaoPreferenciaService $transmissao,
        LocalVotacaoZonaRuralRepository $marcacao
    ): LocalVotacaoCrudController {
        return new LocalVotacaoCrudController(
            $repository,
            Mockery::mock(LocalDificilAcessoRepository::class),
            $transmissao,
            Mockery::mock(GelRespostaRepository::class),
            null,
            null,
            null,
            $marcacao
        );
    }

    private function request(array $dados): LocalVotacaoUpdateRequest
    {
        $request = LocalVotacaoUpdateRequest::create('/lda/locais-votacao/LV-1', 'PUT', $dados);
        $request->setContainer($this->app);
        $request->setRedirector($this->app['redirect']);
        $request->validateResolved();

        return $request;
    }
}
```
</TESTS_UNIT_LOCALVOTACAOZONARURALCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoZonaRuralRepositoryTest.php`
## <TESTS_UNIT_LOCALVOTACAOZONARURALREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoZonaRuralRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoZonaRuralRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_marcar_insere_uma_vez_e_repetir_nao_produz_novo_dml(): void
public function test_desmarcar_remove_uma_vez_e_repetir_nao_produz_novo_dml(): void
public function test_codigo_vazio_e_rejeitado_antes_de_consultar_ou_gravar(): void
public function __construct(array $registros = [])
protected function buscarMarcacao(string $codObjetoLocal): ?array
protected function inserirAuditado(
protected function removerAuditadoPorId(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\LocaisVotacao\LocalVotacaoZonaRuralRepository;
use InvalidArgumentException;
use Tests\TestCase;

class LocalVotacaoZonaRuralRepositoryTest extends TestCase
{
    public function test_marcar_insere_uma_vez_e_repetir_nao_produz_novo_dml(): void
    {
        $repository = new LocalVotacaoZonaRuralRepositoryFake;

        $repository->sincronizarMarcacao(' LV-1 ', true);
        $repository->sincronizarMarcacao('LV-1', true);

        $this->assertSame([['acao' => 'insert', 'codigo' => 'LV-1']], $repository->dml);
    }

    public function test_desmarcar_remove_uma_vez_e_repetir_nao_produz_novo_dml(): void
    {
        $repository = new LocalVotacaoZonaRuralRepositoryFake(['LV-1' => 91]);

        $repository->sincronizarMarcacao('LV-1', false);
        $repository->sincronizarMarcacao('LV-1', false);

        $this->assertSame([['acao' => 'delete', 'id' => 91]], $repository->dml);
    }

    public function test_codigo_vazio_e_rejeitado_antes_de_consultar_ou_gravar(): void
    {
        $repository = new LocalVotacaoZonaRuralRepositoryFake;

        $this->expectException(InvalidArgumentException::class);
        $repository->sincronizarMarcacao('  ', true);
    }
}

class LocalVotacaoZonaRuralRepositoryFake extends LocalVotacaoZonaRuralRepository
{
    /** @var array<string, int> */
    private array $registros;

    /** @var array<int, array<string, int|string>> */
    public array $dml = [];

    /** @param array<string, int> $registros */
    public function __construct(array $registros = [])
    {
        $this->registros = $registros;
    }

    protected function buscarMarcacao(string $codObjetoLocal): ?array
    {
        $id = $this->registros[$codObjetoLocal] ?? null;

        return $id !== null ? ['id' => $id, 'cod_objeto_local' => $codObjetoLocal] : null;
    }

    protected function inserirAuditado(
        string $tabela,
        string $entidade,
        array $dados,
        string $colunaId = 'ID',
        ?string $sequencia = null
    ): int {
        $codigo = (string) $dados['cod_objeto_local'];
        $this->registros[$codigo] = count($this->registros) + 1;
        $this->dml[] = ['acao' => 'insert', 'codigo' => $codigo];

        return $this->registros[$codigo];
    }

    protected function removerAuditadoPorId(
        string $tabela,
        string $entidade,
        string $colunaId,
        mixed $id
    ): int {
        foreach ($this->registros as $codigo => $registroId) {
            if ($registroId === $id) {
                unset($this->registros[$codigo]);
                break;
            }
        }
        $this->dml[] = ['acao' => 'delete', 'id' => (int) $id];

        return 1;
    }
}
```
</TESTS_UNIT_LOCALVOTACAOZONARURALREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoZonaRuralRequestTest.php`
## <TESTS_UNIT_LOCALVOTACAOZONARURALREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoZonaRuralRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoZonaRuralRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_payload_aceita_zero_um_e_preserva_ausencia_como_nao_alterar(): void
public function test_payload_rejeita_valor_fora_do_dominio_booleano(): void
private function validar(array $dados): LocalVotacaoUpdateRequest
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\LocaisVotacao\LocalVotacaoUpdateRequest;
use Illuminate\Validation\ValidationException;
use Tests\TestCase;

class LocalVotacaoZonaRuralRequestTest extends TestCase
{
    public function test_payload_aceita_zero_um_e_preserva_ausencia_como_nao_alterar(): void
    {
        $this->assertTrue($this->validar(['zona_rural_manual' => '1'])->zonaRuralManualSanitizada());
        $this->assertFalse($this->validar(['zona_rural_manual' => '0'])->zonaRuralManualSanitizada());
        $this->assertNull($this->validar([])->zonaRuralManualSanitizada());
    }

    public function test_payload_rejeita_valor_fora_do_dominio_booleano(): void
    {
        $this->expectException(ValidationException::class);
        $this->validar(['zona_rural_manual' => 'rural']);
    }

    private function validar(array $dados): LocalVotacaoUpdateRequest
    {
        $request = LocalVotacaoUpdateRequest::create('/lda/locais-votacao/LV-1', 'PUT', $dados);
        $request->setContainer($this->app);
        $request->setRedirector($this->app['redirect']);
        $request->validateResolved();

        return $request;
    }
}
```
</TESTS_UNIT_LOCALVOTACAOZONARURALREQUESTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MrjLocalVotacaoUiTest.php`
## <TESTS_UNIT_MRJLOCALVOTACAOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MrjLocalVotacaoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MrjLocalVotacaoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_partial_renderiza_badge_e_tooltip_com_tipo_e_data(): void
public function test_campo_mrj_e_compartilhado_e_marcado_por_padrao_nos_pdfs_detalhados(): void
public function test_badges_e_texto_pdf_aparecem_nas_telas_interna_e_externa(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\Exportacao\LocalVotacaoCamposPdf;
use Tests\TestCase;

class MrjLocalVotacaoUiTest extends TestCase
{
    public function test_partial_renderiza_badge_e_tooltip_com_tipo_e_data(): void
    {
        $html = view('lda.partials.mrj-badges', [
            'mrjs' => [(object) [
                'num_mesa' => 904,
                'tip_mrj' => 3,
                'dat_eleicao' => '2026-10-04',
            ]],
        ])->render();

        $this->assertStringContainsString('MRJ 904', $html);
        $this->assertStringContainsString('Mesa Receptora de Justificativa 904 · Sem urna · 04/10/2026', $html);
        $this->assertStringNotContainsString('Seção 904', $html);
    }

    public function test_campo_mrj_e_compartilhado_e_marcado_por_padrao_nos_pdfs_detalhados(): void
    {
        $this->assertContains('mrj', LocalVotacaoCamposPdf::detalhePermitidos());
        $this->assertContains('mrj', LocalVotacaoCamposPdf::detalhePadrao());
        $this->assertSame(
            'Mesas Receptoras de Justificativa (MRJ)',
            LocalVotacaoCamposPdf::gruposDetalhe()['local']['mrj']
        );
        $this->assertArrayNotHasKey('mrj', LocalVotacaoCamposPdf::resumoDisponiveis());
    }

    public function test_badges_e_texto_pdf_aparecem_nas_telas_interna_e_externa(): void
    {
        $tabelaInterna = (string) file_get_contents(resource_path('views/lda/partials/locais-votacao-tabela.blade.php'));
        $telaExterna = (string) file_get_contents(resource_path('views/forcas-seguranca/publico/locais-votacao.blade.php'));
        $pdfInterno = (string) file_get_contents(resource_path('views/lda/locais-votacao/pdf.blade.php'));
        $pdfExterno = (string) file_get_contents(resource_path('views/forcas-seguranca/publico/locais-votacao-pdf.blade.php'));

        $this->assertStringContainsString("@include('lda.partials.mrj-badges'", $tabelaInterna);
        $this->assertStringContainsString("@include('lda.partials.mrj-badges'", $telaExterna);
        $this->assertStringContainsString("\$mostrar('mrj')", $pdfInterno);
        $this->assertStringContainsString('MrjApresentacao::textoPdf', $pdfInterno);
        $this->assertStringContainsString("\$mostrar('mrj')", $pdfExterno);
        $this->assertStringContainsString('MrjApresentacao::textoPdf', $pdfExterno);
    }

}
```
</TESTS_UNIT_MRJLOCALVOTACAOUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaSecaoAgrupamentoLocalUiTest.php`
## <TESTS_UNIT_NATVISTORIASECAOAGRUPAMENTOLOCALUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaSecaoAgrupamentoLocalUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `final class NatVistoriaSecaoAgrupamentoLocalUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function painel_externo_agrupa_secoes_em_um_fieldset_por_local(): void
private function secao(
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

final class NatVistoriaSecaoAgrupamentoLocalUiTest extends TestCase
{
    #[Test]
    public function painel_externo_agrupa_secoes_em_um_fieldset_por_local(): void
    {
        $html = view('nat.rotas.partials.vistorias', [
            'modoExterno' => true,
            'turno' => ['id' => 1],
            'vistorias' => [
                $this->secao('LOCAL-1', '1201', 'ESCOLA HENRIQUE LIMA', '087', 'NAO_VISTORIADA'),
                $this->secao('LOCAL-1', '1201', 'ESCOLA HENRIQUE LIMA', '088', 'CONFORME', 501),
                $this->secao('LOCAL-2', '1589', 'ESCOLA JUVENAL ANTUNES', '089', 'COM_PENDENCIA', 502),
            ],
            'filtros' => [],
            'routeNames' => ['vistoria_form' => 'nat.externo.vistorias.form'],
        ])->render();

        $this->assertSame(2, substr_count($html, '<fieldset'));
        $this->assertSame(2, substr_count($html, '<legend'));
        $this->assertStringContainsString('Rota 901 · Local 1201 — ESCOLA HENRIQUE LIMA', $html);
        $this->assertStringContainsString('Rota 901 · Local 1589 — ESCOLA JUVENAL ANTUNES', $html);
        $this->assertStringContainsString('btn btn-danger w-100', $html);
        $this->assertStringContainsString('btn btn-success w-100', $html);
        $this->assertSame(2, substr_count($html, 'btn btn-success w-100'));
        $this->assertStringContainsString('>Seção 087</a>', $html);
        $this->assertStringContainsString('>Seção 088</a>', $html);
        $this->assertStringContainsString('>Seção 089</a>', $html);
        $this->assertStringContainsString('>Com pendência</span>', $html);
        $this->assertStringNotContainsString('>Vistoriar seção</a>', $html);
        $this->assertStringNotContainsString('>Realizar nova vistoria</a>', $html);
    }

    /** @return array<string, mixed> */
    private function secao(
        string $localId,
        string $localNumero,
        string $localNome,
        string $numero,
        string $situacao,
        ?int $vistoriaId = null,
    ): array
    {
        return [
            'rota_id' => 901,
            'rota_numero' => 901,
            'zona_numero' => 9,
            'municipio_nome' => 'RIO BRANCO',
            'cod_objeto_local' => $localId,
            'local_numero' => $localNumero,
            'local_nome' => $localNome,
            'secao_rotulo' => 'Seção '.$numero,
            'situacao' => $situacao,
            'dt_vistoria_fmt' => null,
            'autor_nome' => null,
            'vistoria_id' => $vistoriaId,
            'token_vistoria' => 'token-'.$numero,
        ];
    }
}
```
</TESTS_UNIT_NATVISTORIASECAOAGRUPAMENTOLOCALUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaSecaoCatalogoTest.php`
## <TESTS_UNIT_NATVISTORIASECAOCATALOGOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaSecaoCatalogoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatVistoriaSecaoCatalogoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function prepara_snapshot_com_todas_as_respostas_do_catalogo_ativo(): void
public function rejeita_catalogo_desatualizado_resposta_ausente_extra_ou_fora_do_dominio(): void
public function fingerprint_muda_quando_texto_ordem_ou_conjunto_mudam(): void
private function perguntas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Nat\NatVistoriaSecaoCatalogo;
use DomainException;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatVistoriaSecaoCatalogoTest extends TestCase
{
    private NatVistoriaSecaoCatalogo $catalogo;

    protected function setUp(): void
    {
        parent::setUp();
        $this->catalogo = new NatVistoriaSecaoCatalogo();
    }

    #[Test]
    public function prepara_snapshot_com_todas_as_respostas_do_catalogo_ativo(): void
    {
        $perguntas = $this->perguntas();
        $fingerprint = $this->catalogo->fingerprint($perguntas);

        $respostas = $this->catalogo->prepararRespostas(
            $perguntas,
            $fingerprint,
            [10 => 'SIM', 20 => 'NAO'],
            ['SIM', 'NAO'],
        );

        $this->assertSame([
            [
                'pergunta_id' => 10,
                'pergunta_codigo' => 'CONDICOES_SEGURAS',
                'pergunta_texto' => 'Há condições seguras?',
                'pergunta_ordem' => 1,
                'resposta_codigo' => 'SIM',
            ],
            [
                'pergunta_id' => 20,
                'pergunta_codigo' => 'LACRES_INTEGROS',
                'pergunta_texto' => 'Os lacres estão íntegros?',
                'pergunta_ordem' => 2,
                'resposta_codigo' => 'NAO',
            ],
        ], $respostas);
        $this->assertSame('COM_PENDENCIA', $this->catalogo->resolverSituacao($respostas));
        $this->assertSame('CONFORME', $this->catalogo->resolverSituacao([
            ['resposta_codigo' => 'SIM'],
            ['resposta_codigo' => 'SIM'],
        ]));
        $this->assertSame('NAO_VISTORIADA', $this->catalogo->resolverSituacao(null));
    }

    #[Test]
    public function rejeita_catalogo_desatualizado_resposta_ausente_extra_ou_fora_do_dominio(): void
    {
        $perguntas = $this->perguntas();
        $fingerprint = $this->catalogo->fingerprint($perguntas);

        foreach ([
            ['fingerprint-invalido', [10 => 'SIM', 20 => 'NAO'], ['SIM', 'NAO']],
            [$fingerprint, [10 => 'SIM'], ['SIM', 'NAO']],
            [$fingerprint, [10 => 'SIM', 20 => 'NAO', 30 => 'SIM'], ['SIM', 'NAO']],
            [$fingerprint, [10 => 'SIM', 20 => 'TALVEZ'], ['SIM', 'NAO']],
        ] as [$fingerprintInformado, $respostas, $codigos]) {
            try {
                $this->catalogo->prepararRespostas($perguntas, $fingerprintInformado, $respostas, $codigos);
                $this->fail('A entrada inválida deveria ser rejeitada.');
            } catch (DomainException) {
                $this->addToAssertionCount(1);
            }
        }
    }

    #[Test]
    public function fingerprint_muda_quando_texto_ordem_ou_conjunto_mudam(): void
    {
        $original = $this->catalogo->fingerprint($this->perguntas());

        $alterada = $this->perguntas();
        $alterada[0]['texto'] = 'Texto alterado';
        $this->assertNotSame($original, $this->catalogo->fingerprint($alterada));

        $alterada = $this->perguntas();
        $alterada[0]['ordem'] = 3;
        $this->assertNotSame($original, $this->catalogo->fingerprint($alterada));

        $alterada = $this->perguntas();
        array_pop($alterada);
        $this->assertNotSame($original, $this->catalogo->fingerprint($alterada));
    }

    /** @return array<int, array{id:int,codigo:string,texto:string,ordem:int}> */
    private function perguntas(): array
    {
        return [
            ['id' => 10, 'codigo' => 'CONDICOES_SEGURAS', 'texto' => 'Há condições seguras?', 'ordem' => 1],
            ['id' => 20, 'codigo' => 'LACRES_INTEGROS', 'texto' => 'Os lacres estão íntegros?', 'ordem' => 2],
        ];
    }
}
```
</TESTS_UNIT_NATVISTORIASECAOCATALOGOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatVistoriaSecaoFiltrosTest.php`
## <TESTS_UNIT_NATVISTORIASECAOFILTROSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatVistoriaSecaoFiltrosTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatVistoriaSecaoFiltrosTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function municipio_ausente_ou_invalido_nao_cria_filtro_implicito(): void
public function municipio_positivo_e_preservado_como_identificador_inteiro(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Nat\NatVistoriaSecaoFiltros;
use Illuminate\Http\Request;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class NatVistoriaSecaoFiltrosTest extends TestCase
{
    #[Test]
    public function municipio_ausente_ou_invalido_nao_cria_filtro_implicito(): void
    {
        foreach ([null, '', '0', '-1', 'municipio-invalido'] as $valor) {
            $parametros = $valor === null ? [] : ['vistoria_municipio_id' => $valor];

            $filtros = NatVistoriaSecaoFiltros::fromRequest(Request::create('/', 'GET', $parametros));

            $this->assertNull($filtros['municipio_id']);
        }
    }

    #[Test]
    public function municipio_positivo_e_preservado_como_identificador_inteiro(): void
    {
        $request = Request::create('/', 'GET', ['vistoria_municipio_id' => ' 16 ']);

        $filtros = NatVistoriaSecaoFiltros::fromRequest($request);

        $this->assertSame(16, $filtros['municipio_id']);
    }
}
```
</TESTS_UNIT_NATVISTORIASECAOFILTROSTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RecursoLogisticoUrnaSecaoCalculadaTest.php`
## <TESTS_UNIT_RECURSOLOGISTICOURNASECAOCALCULADATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RecursoLogisticoUrnaSecaoCalculadaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RecursoLogisticoUrnaSecaoCalculadaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function repository_conta_distintamente_as_secoes_fisicas_da_view_no_local_efetivo(): void
public function repository_conta_em_lote_e_completa_locais_sem_secoes_com_zero(): void
public function service_remove_urna_secao_do_seletor_manual(): void
public function service_substitui_vinculo_legado_por_urna_secao_calculada_inclusive_com_zero(): void
public function service_recalcula_peso_total_na_leitura_com_o_peso_unitario_vigente(): void
public function service_omite_urna_secao_calculada_quando_opcao_estiver_inativa(): void
public function service_descarta_payload_adulterado_de_urna_secao_antes_de_persistir(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LdaRecursoLogisticoOpcaoRepository;
use App\Repositories\Lda\RecursoLogisticoLocalRepository;
use App\Repositories\Lda\SecaoFisicaLocalRepository;
use App\Services\Lda\RecursoLogisticoLocalService;
use App\Support\Lda\RecursoLogistico;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RecursoLogisticoUrnaSecaoCalculadaTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function repository_conta_distintamente_as_secoes_fisicas_da_view_no_local_efetivo(): void
    {
        DB::shouldReceive('selectOne')
            ->once()
            ->with(
                Mockery::on(static fn (string $sql): bool => str_contains($sql, 'COUNT(DISTINCT ws.cod_objeto)')
                    && str_contains($sql, 'planeleito.vw_secoes_agregadas')
                    && str_contains($sql, 'ws.cod_objeto_local = :cod_objeto_local')),
                ['cod_objeto_local' => 'LV001']
            )
            ->andReturn((object) ['quantidade' => 3]);

        $repository = new SecaoFisicaLocalRepository;

        $this->assertSame(3, $repository->quantidadePorLocal(' LV001 '));
        $this->assertSame(0, $repository->quantidadePorLocal(''));
    }

    #[Test]
    public function repository_conta_em_lote_e_completa_locais_sem_secoes_com_zero(): void
    {
        DB::shouldReceive('select')
            ->once()
            ->with(
                Mockery::on(static fn (string $sql): bool => str_contains($sql, 'COUNT(DISTINCT ws.cod_objeto)')
                    && str_contains($sql, 'GROUP BY ws.cod_objeto_local')),
                Mockery::on(static fn (array $bindings): bool => array_values($bindings) === ['LV001', 'LV002'])
            )
            ->andReturn([
                (object) ['cod_objeto_local' => 'LV001', 'quantidade' => 2],
            ]);

        $repository = new SecaoFisicaLocalRepository;

        $this->assertSame([
            'LV001' => 2,
            'LV002' => 0,
        ], $repository->quantidadesPorLocais([' LV001 ', 'LV002', 'LV001', '']));
    }

    #[Test]
    public function service_remove_urna_secao_do_seletor_manual(): void
    {
        $opcaoRepository = Mockery::mock(LdaRecursoLogisticoOpcaoRepository::class);
        $localRepository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);

        $opcaoRepository->shouldReceive('listarAtivasOrdenadas')->once()->andReturn([
            (object) ['id' => 41, 'codigo' => RecursoLogistico::CODIGO_URNA_SECAO],
            (object) ['id' => 10, 'codigo' => 'BATERIAS'],
        ]);

        $service = new RecursoLogisticoLocalService($opcaoRepository, $localRepository, $secaoRepository);

        $this->assertSame([10], array_map(
            static fn (object $opcao): int => (int) $opcao->id,
            $service->opcoesAtivas()
        ));
    }

    #[Test]
    public function service_substitui_vinculo_legado_por_urna_secao_calculada_inclusive_com_zero(): void
    {
        $opcaoRepository = Mockery::mock(LdaRecursoLogisticoOpcaoRepository::class);
        $localRepository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);

        $localRepository->shouldReceive('buscarPorLocal')->once()->with('LV001', 7)->andReturn([
            ['recurso_opcao_id' => 10, 'codigo' => 'BATERIAS', 'nome' => 'Baterias', 'ordem' => 10, 'quantidade' => 2, 'peso_unitario_kg' => 1, 'peso_total_kg' => 2],
            ['recurso_opcao_id' => 41, 'codigo' => RecursoLogistico::CODIGO_URNA_SECAO, 'nome' => 'Legado', 'ordem' => 21, 'quantidade' => 99, 'peso_unitario_kg' => 10, 'peso_total_kg' => 990],
        ]);
        $opcaoRepository->shouldReceive('buscarAtivaPorCodigo')
            ->once()
            ->with(RecursoLogistico::CODIGO_URNA_SECAO)
            ->andReturn((object) [
                'id' => 41,
                'codigo' => RecursoLogistico::CODIGO_URNA_SECAO,
                'nome' => 'URNAS DE SEÇÃO',
                'ordem' => 21,
                'peso_unitario_kg' => 10,
                'ativo' => 1,
            ]);
        $secaoRepository->shouldReceive('quantidadePorLocal')->once()->with('LV001')->andReturn(0);

        $service = new RecursoLogisticoLocalService($opcaoRepository, $localRepository, $secaoRepository);
        $resultado = $service->buscarPorLocal('LV001', 7);

        $this->assertCount(2, $resultado);
        $this->assertSame('BATERIAS', $resultado[0]['codigo']);
        $this->assertSame(RecursoLogistico::CODIGO_URNA_SECAO, $resultado[1]['codigo']);
        $this->assertSame(0, $resultado[1]['quantidade']);
        $this->assertSame(0.0, $resultado[1]['peso_total_kg']);
        $this->assertTrue($resultado[1]['calculado']);
    }

    #[Test]
    public function service_recalcula_peso_total_na_leitura_com_o_peso_unitario_vigente(): void
    {
        $opcaoRepository = Mockery::mock(LdaRecursoLogisticoOpcaoRepository::class);
        $localRepository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);

        $localRepository->shouldReceive('buscarPorLocal')->once()->with('LV001', 7)->andReturn([
            ['recurso_opcao_id' => 10, 'codigo' => 'URNAS', 'nome' => 'Urnas', 'ordem' => 20, 'quantidade' => 7, 'peso_unitario_kg' => 10, 'peso_total_kg' => 49],
            ['recurso_opcao_id' => 11, 'codigo' => 'BATERIAS', 'nome' => 'Baterias', 'ordem' => 10, 'quantidade' => 3, 'peso_unitario_kg' => 2.345, 'peso_total_kg' => 999],
            ['recurso_opcao_id' => 12, 'codigo' => 'STARLINK', 'nome' => 'Starlink', 'ordem' => 30, 'quantidade' => 4, 'peso_unitario_kg' => 0, 'peso_total_kg' => 8],
        ]);
        $opcaoRepository->shouldReceive('buscarAtivaPorCodigo')
            ->once()
            ->with(RecursoLogistico::CODIGO_URNA_SECAO)
            ->andReturnNull();
        $secaoRepository->shouldNotReceive('quantidadePorLocal');

        $service = new RecursoLogisticoLocalService($opcaoRepository, $localRepository, $secaoRepository);
        $resultado = $service->buscarPorLocal('LV001', 7);

        $this->assertSame('BATERIAS', $resultado[0]['codigo']);
        $this->assertEqualsWithDelta(7.035, $resultado[0]['peso_total_kg'], 0.0001);
        $this->assertSame('URNAS', $resultado[1]['codigo']);
        $this->assertSame(70.0, $resultado[1]['peso_total_kg']);
        $this->assertSame('STARLINK', $resultado[2]['codigo']);
        $this->assertSame(0.0, $resultado[2]['peso_total_kg']);
    }

    #[Test]
    public function service_omite_urna_secao_calculada_quando_opcao_estiver_inativa(): void
    {
        $opcaoRepository = Mockery::mock(LdaRecursoLogisticoOpcaoRepository::class);
        $localRepository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);

        $localRepository->shouldReceive('buscarPorLocal')->once()->with('LV001', 7)->andReturn([]);
        $opcaoRepository->shouldReceive('buscarAtivaPorCodigo')
            ->once()
            ->with(RecursoLogistico::CODIGO_URNA_SECAO)
            ->andReturnNull();
        $secaoRepository->shouldNotReceive('quantidadePorLocal');

        $service = new RecursoLogisticoLocalService($opcaoRepository, $localRepository, $secaoRepository);

        $this->assertSame([], $service->buscarPorLocal('LV001', 7));
    }

    #[Test]
    public function service_descarta_payload_adulterado_de_urna_secao_antes_de_persistir(): void
    {
        $opcaoRepository = Mockery::mock(LdaRecursoLogisticoOpcaoRepository::class);
        $localRepository = Mockery::mock(RecursoLogisticoLocalRepository::class);
        $secaoRepository = Mockery::mock(SecaoFisicaLocalRepository::class);

        $opcaoRepository->shouldReceive('listarAtivasOrdenadas')->once()->andReturn([
            (object) ['id' => 41, 'codigo' => RecursoLogistico::CODIGO_URNA_SECAO, 'peso_unitario_kg' => 10],
            (object) ['id' => 10, 'codigo' => 'BATERIAS', 'peso_unitario_kg' => 1.5],
        ]);
        $localRepository->shouldReceive('salvarPorLocal')
            ->once()
            ->with('LV001', 7, [[
                'recurso_opcao_id' => 10,
                'quantidade' => 2,
                'peso_total_kg' => 3.0,
            ]]);

        $service = new RecursoLogisticoLocalService($opcaoRepository, $localRepository, $secaoRepository);
        $service->salvarPorLocal('LV001', 7, [
            ['recurso_opcao_id' => 41, 'quantidade' => 999, 'peso_total_kg' => 9990],
            ['recurso_opcao_id' => 10, 'quantidade' => 2, 'peso_total_kg' => 0],
        ]);

        $this->addToAssertionCount(1);
    }
}
```
</TESTS_UNIT_RECURSOLOGISTICOURNASECAOCALCULADATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaLocaisVinculadosControllerTest.php`
## <TESTS_UNIT_ROTALOCAISVINCULADOSCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaLocaisVinculadosControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaLocaisVinculadosControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
private function makeController(RotaRepository $repository): RotaController
public function locais_vinculados_retorna_json_com_html_e_total(): void
public function locais_vinculados_exibe_agregadas_somente_no_rotulo_da_agregadora(): void
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
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaLocaisVinculadosControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    private function makeController(RotaRepository $repository): RotaController
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

    #[Test]
    public function locais_vinculados_retorna_json_com_html_e_total(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('listarLocaisVinculadosDetalheNoEscopo')
            ->once()
            ->with(42, [1], false)
            ->andReturn([
                [
                    'cod_objeto_local' => 'ABC001',
                    'texto' => 'Zona 1 - Rio Branco - Escola X (Local 1)',
                    'endereco' => 'Rua das Acácias, 100',
                    'secoes' => [['num_secao' => '001', 'qtd_aptos' => 150], ['num_secao' => '002', 'qtd_aptos' => 200]],
                ],
                [
                    'cod_objeto_local' => 'ABC002',
                    'texto' => 'Zona 1 - Rio Branco - Escola Y (Local 2)',
                    'endereco' => '',
                    'secoes' => [['num_secao' => '003', 'qtd_aptos' => 180]],
                ],
            ]);

        $response = $this->makeController($repository)->locaisVinculados(42);

        $this->assertSame(200, $response->getStatusCode());
        $payload = json_decode($response->getContent(), true);
        $this->assertArrayHasKey('html', $payload);
        $this->assertArrayHasKey('total', $payload);
        $this->assertSame(2, $payload['total']);
        $this->assertIsString($payload['html']);
        $this->assertStringContainsString('Endereço:', $payload['html']);
        $this->assertStringContainsString('Rua das Acácias, 100', $payload['html']);
        $this->assertStringContainsString('>—</span>', $payload['html']);
    }

    #[Test]
    public function locais_vinculados_exibe_agregadas_somente_no_rotulo_da_agregadora(): void
    {
        session([
            'cod_zonas_permitidas' => [1],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(RotaRepository::class);
        $repository->shouldReceive('listarLocaisVinculadosDetalheNoEscopo')
            ->once()
            ->with(21, [1], false)
            ->andReturn([[
                'cod_objeto_local' => '228',
                'texto' => '1 - Rio Branco - SEHURB (Local 1589)',
                'endereco' => 'Via Chico Mendes, 805',
                'secoes' => [['num_secao' => '178(179)', 'qtd_aptos' => 339]],
            ]]);

        $response = $this->makeController($repository)->locaisVinculados(21);
        $payload = json_decode($response->getContent(), true);

        $this->assertSame(1, $payload['total']);
        $this->assertStringContainsString('178(179) - apt 339', $payload['html']);
        $this->assertStringNotContainsString('179 - apt', $payload['html']);
    }
}
```
</TESTS_UNIT_ROTALOCAISVINCULADOSCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RotaRepositoryLocaisPoloTest.php`
## <TESTS_UNIT_ROTAREPOSITORYLOCAISPOLOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RotaRepositoryLocaisPoloTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaRepositoryLocaisPoloTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function buscar_locais_disponiveis_mantem_bloqueio_de_locais_ja_vinculados_a_outra_rota(): void
public function buscar_locais_de_polo_compartilhado_nao_filtra_rota_local(): void
public function buscar_locais_de_polo_compartilhado_retorna_vazio_quando_zona_esta_fora_do_escopo(): void
private function mockarIdsZonasPermitidas(array $ids): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\RotaRepository;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RotaRepositoryLocaisPoloTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function buscar_locais_disponiveis_mantem_bloqueio_de_locais_ja_vinculados_a_outra_rota(): void
    {
        DB::shouldReceive('select')
            ->once()
            ->with(
                Mockery::on(static fn (string $sql): bool => str_contains($sql, 'NOT EXISTS')
                    && str_contains($sql, 'ROTA_LOCAL')
                    && str_contains($sql, 'rl.rota_id <> ?')),
                Mockery::on(static fn (array $bindings): bool => $bindings === [
                    2,
                    '%ESCOLA%',
                    '%ESCOLA%',
                    '%ESCOLA%',
                    '%ESCOLA%',
                    77,
                ])
            )
            ->andReturn([]);

        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertSame([], $repository->buscarLocaisDisponiveis('escola', 2, 77));
    }

    #[Test]
    public function buscar_locais_de_polo_compartilhado_nao_filtra_rota_local(): void
    {
        $this->mockarIdsZonasPermitidas([44]);

        DB::shouldReceive('select')
            ->once()
            ->with(
                Mockery::on(static fn (string $sql): bool => !str_contains($sql, 'NOT EXISTS')
                    && !str_contains($sql, 'ROTA_LOCAL')
                    && str_contains($sql, 'ROWNUM <= 50')),
                Mockery::on(static fn (array $bindings): bool => $bindings === [
                    44,
                    '%ESCOLA%',
                    '%ESCOLA%',
                    '%ESCOLA%',
                    '%ESCOLA%',
                ])
            )
            ->andReturn([(object) ['id' => 'LV99', 'texto' => '1 - Rio Branco - Escola Polo (Local 99)']]);

        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $resultado = $repository->buscarLocaisPoloVotacaoNoEscopo('escola', 44, [1], false);

        $this->assertSame('LV99', $resultado[0]->id);
    }

    #[Test]
    public function buscar_locais_de_polo_compartilhado_retorna_vazio_quando_zona_esta_fora_do_escopo(): void
    {
        $this->mockarIdsZonasPermitidas([44]);
        DB::shouldReceive('select')->never();

        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertSame(
            [],
            $repository->buscarLocaisPoloVotacaoNoEscopo('escola', 99, [1], false)
        );
    }

    /**
     * @param array<int, int> $ids
     */
    private function mockarIdsZonasPermitidas(array $ids): void
    {
        $query = Mockery::mock();
        DB::shouldReceive('table')->once()->with('ZONA')->andReturn($query);
        $query->shouldReceive('selectRaw')->once()->with('ID as id')->andReturnSelf();
        $query->shouldReceive('whereIn')->once()->with('NUM_ZONA', [1])->andReturnSelf();
        $query->shouldReceive('pluck')->once()->with('id')->andReturn(collect($ids));
    }
}
```
</TESTS_UNIT_ROTAREPOSITORYLOCAISPOLOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeSituacaoSecaoNormalizerTest.php`
## <TESTS_UNIT_SCDESITUACAOSECAONORMALIZERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeSituacaoSecaoNormalizerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeSituacaoSecaoNormalizerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function materializa_os_49_campos_e_preserva_municipio_e_datas_como_texto(): void
public function rejeita_contexto_divergente_e_chave_duplicada(): void
public function rejeita_texto_acima_do_limite_persistivel(): void
private function registro(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Scde\ScdeSituacaoSecaoNormalizer;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class ScdeSituacaoSecaoNormalizerTest extends TestCase
{
    #[Test]
    public function materializa_os_49_campos_e_preserva_municipio_e_datas_como_texto(): void
    {
        $registro = (new ScdeSituacaoSecaoNormalizer)->normalizarLote(
            [$this->registro()],
            9306,
            12454,
            'AC',
            1,
        )[0];

        $this->assertCount(49, $registro);
        $this->assertSame('00100', $registro['sg_ue_mun']);
        $this->assertSame('2026-10-04T17:00:00-05:00', $registro['dt_encerramento_urna']);
        $this->assertSame(9306, $registro['cod_pleito']);
        $this->assertSame(12454, $registro['cod_eleicao']);
        $this->assertSame(1, $registro['nr_zona']);
        $this->assertSame(2, $registro['nr_secao']);
        $this->assertSame(13, $registro['cd_tipo_cargo_pergunta']);
    }

    #[Test]
    public function rejeita_contexto_divergente_e_chave_duplicada(): void
    {
        $normalizer = new ScdeSituacaoSecaoNormalizer;

        foreach ([
            array_replace($this->registro(), ['cdPleito' => 999]),
            array_replace($this->registro(), ['cdEleicao' => 999]),
            array_replace($this->registro(), ['sgUeUf' => 'RO']),
            array_replace($this->registro(), ['nrZona' => 2]),
        ] as $registro) {
            try {
                $normalizer->normalizarLote([$registro], 9306, 12454, 'AC', 1);
                $this->fail('O contexto divergente deveria ser recusado.');
            } catch (RuntimeException $exception) {
                $this->assertStringContainsString('contexto', mb_strtolower($exception->getMessage()));
            }
        }

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('duplicada');
        $normalizer->normalizarLote([$this->registro(), $this->registro()], 9306, 12454, 'AC', 1);
    }

    #[Test]
    public function rejeita_texto_acima_do_limite_persistivel(): void
    {
        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('limite');

        (new ScdeSituacaoSecaoNormalizer)->normalizarLote([
            array_replace($this->registro(), ['dsMotivo' => str_repeat('x', 1001)]),
        ], 9306, 12454, 'AC', 1);
    }

    /** @return array<string, mixed> */
    private function registro(): array
    {
        return [
            'cdPleito' => 9306,
            'cdEleicao' => 12454,
            'cdTipoCargoPergunta' => 13,
            'sgUeUf' => 'AC',
            'sgUeMun' => '00100',
            'nmUe' => 'RIO BRANCO',
            'nrZona' => 1,
            'nrSecao' => 2,
            'nrLocal' => 3,
            'nmLocal' => 'ESCOLA TESTE',
            'dsEndereco' => 'RUA TESTE',
            'stEspecial' => 'N',
            'stAudio' => 'S',
            'cdTipoCorrespondenciaUrna' => 4,
            'nmTipoCorrespondenciaUrna' => 'CORRESPONDENTE',
            'stCorrespEsperada' => 'S',
            'stCorrespEfetivada' => 'S',
            'stCorrespEspIgualEfetiv' => 'S',
            'tpSituacaoRecebimento' => 'RECEBIDA',
            'dsSituacaoRecebimento' => 'Recebida',
            'tpSituacaoTotalizacao' => 'TOTALIZADA',
            'dsSituacaoTotalizacao' => 'Totalizada',
            'stSecaoPendente' => 'N',
            'qtBuRecebido' => 1,
            'qtRejeicao' => 0,
            'qtBuPendente' => 0,
            'qtAptos' => 500,
            'qtComparecimento' => 400,
            'qtAbstencao' => 100,
            'qtEleitoresBioLibCodigo' => 25,
            'dt1TotParcial' => null,
            'dtUltTotParcialSecao' => null,
            'dtBuRecebido' => '2026-10-04T18:00:00-05:00',
            'dtAberturaUrna' => '2026-10-04T08:00:00-05:00',
            'dtEncerramentoUrna' => '2026-10-04T17:00:00-05:00',
            'dtEmisaoBu' => '2026-10-04T17:01:00-05:00',
            'dtGeracaoArquivo' => '2026-10-04T17:02:00-05:00',
            'nrDifGerArqBuSeg' => 60,
            'cdOriVotos' => 1,
            'nmOriVotos' => 'URNA',
            'cdTipoArquivo' => 2,
            'nmTipoArquivo' => 'BU',
            'cdTipoSistemaApuracao' => 3,
            'nmTipoSistemaApuracao' => 'SISTEMA',
            'nrJuntaApuradora' => 4,
            'nrTurmaApuradora' => 5,
            'cdTipoUrna' => 6,
            'nmTipoUrna' => 'UE',
            'dsMotivo' => 'Sem pendencia',
        ];
    }
}
```
</TESTS_UNIT_SCDESITUACAOSECAONORMALIZERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeSituacaoSecaoRepositoryTest.php`
## <TESTS_UNIT_SCDESITUACAOSECAOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeSituacaoSecaoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeSituacaoSecaoRepositoryTest extends TestCase`

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
public function publica_em_lotes_de_vinte_e_cinco_apos_revalidar_a_configuracao_ativa(): void
public function troca_da_configuracao_ativa_interrompe_antes_do_delete(): void
public function contagem_divergente_impede_atualizacao_de_sucesso_e_reverte_a_transacao_real(): void
private function queriesConfiguracao(): array
private function registro(int $secao): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Scde\ScdeSituacaoSecaoRepository;
use Carbon\CarbonImmutable;
use Illuminate\Database\Query\Builder;
use Illuminate\Database\Query\Expression;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class ScdeSituacaoSecaoRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        CarbonImmutable::setTestNow('2026-09-08 18:00:00 UTC');
        DB::shouldReceive('transaction')->byDefault()->andReturnUsing(static fn (callable $callback): mixed => $callback());
        DB::shouldReceive('raw')->byDefault()->with('SYSTIMESTAMP')->andReturn(new Expression('SYSTIMESTAMP'));
    }

    protected function tearDown(): void
    {
        CarbonImmutable::setTestNow();
        parent::tearDown();
    }

    #[Test]
    public function publica_em_lotes_de_vinte_e_cinco_apos_revalidar_a_configuracao_ativa(): void
    {
        [$consulta, $atualizacao] = $this->queriesConfiguracao();
        DB::shouldReceive('table')->twice()->with('scde_configuracao')->andReturn($consulta, $atualizacao);
        DB::shouldReceive('delete')->once()->with('DELETE FROM scde_secao_situacao')->andReturn(10);
        $lotes = [];
        DB::shouldReceive('affectingStatement')->twice()->andReturnUsing(
            static function (string $sql, array $bindings) use (&$lotes): int {
                $lotes[] = compact('sql', 'bindings');
                return 1;
            },
        );
        DB::shouldReceive('selectOne')->once()->andReturn((object) ['total' => 26]);

        $registros = array_map(fn (int $secao): array => $this->registro($secao), range(1, 26));
        $total = (new ScdeSituacaoSecaoRepository)->publicar(7, 9306, 12454, $registros, 9, 26, 1234);

        $this->assertSame(26, $total);
        $this->assertCount(25, json_decode($lotes[0]['bindings'][0], true, flags: JSON_THROW_ON_ERROR));
        $this->assertCount(1, json_decode($lotes[1]['bindings'][0], true, flags: JSON_THROW_ON_ERROR));
        $this->assertStringContainsString('JSON_TABLE', $lotes[0]['sql']);
    }

    #[Test]
    public function troca_da_configuracao_ativa_interrompe_antes_do_delete(): void
    {
        $consulta = Mockery::mock(Builder::class);
        $consulta->shouldReceive('where')->once()->with('id', 7)->andReturnSelf();
        $consulta->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $consulta->shouldReceive('first')->once()->andReturn((object) [
            'id' => 7, 'cod_pleito' => 9306, 'cod_eleicao' => 12454, 'ativo' => 0,
        ]);
        DB::shouldReceive('table')->once()->with('scde_configuracao')->andReturn($consulta);
        DB::shouldReceive('delete')->never();
        DB::shouldReceive('affectingStatement')->never();

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('mudou durante a coleta');
        (new ScdeSituacaoSecaoRepository)->publicar(7, 9306, 12454, [$this->registro(1)], 9, 1, 10);
    }

    #[Test]
    public function contagem_divergente_impede_atualizacao_de_sucesso_e_reverte_a_transacao_real(): void
    {
        $consulta = Mockery::mock(Builder::class);
        $consulta->shouldReceive('where')->once()->with('id', 7)->andReturnSelf();
        $consulta->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $consulta->shouldReceive('first')->once()->andReturn((object) [
            'id' => 7, 'cod_pleito' => 9306, 'cod_eleicao' => 12454, 'ativo' => 1,
        ]);
        DB::shouldReceive('table')->once()->with('scde_configuracao')->andReturn($consulta);
        DB::shouldReceive('delete')->once()->andReturn(10);
        DB::shouldReceive('affectingStatement')->once()->andReturn(1);
        DB::shouldReceive('selectOne')->once()->andReturn((object) ['total' => 0]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('contagem persistida');
        (new ScdeSituacaoSecaoRepository)->publicar(7, 9306, 12454, [$this->registro(1)], 9, 1, 10);
    }

    /** @return array{Builder,Builder} */
    private function queriesConfiguracao(): array
    {
        $consulta = Mockery::mock(Builder::class);
        $consulta->shouldReceive('where')->once()->with('id', 7)->andReturnSelf();
        $consulta->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $consulta->shouldReceive('first')->once()->andReturn((object) [
            'id' => 7, 'cod_pleito' => 9306, 'cod_eleicao' => 12454, 'ativo' => 1,
        ]);

        $atualizacao = Mockery::mock(Builder::class);
        $atualizacao->shouldReceive('where')->once()->with('id', 7)->andReturnSelf();
        $atualizacao->shouldReceive('update')->once()->with(Mockery::on(static fn (array $dados): bool =>
            $dados['qtd_zonas'] === 9 && $dados['qtd_secoes'] === 26 && $dados['qtd_registros'] === 26
        ))->andReturn(1);

        return [$consulta, $atualizacao];
    }

    /** @return array<string, int|string|null> */
    private function registro(int $secao): array
    {
        return [
            'cod_pleito' => 9306,
            'cod_eleicao' => 12454,
            'cd_tipo_cargo_pergunta' => 13,
            'sg_ue_uf' => 'AC',
            'sg_ue_mun' => '00100',
            'nr_zona' => 1,
            'nr_secao' => $secao,
        ];
    }
}
```
</TESTS_UNIT_SCDESITUACAOSECAOREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeSituacaoSecaoSyncCommandTest.php`
## <TESTS_UNIT_SCDESITUACAOSECAOSYNCCOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeSituacaoSecaoSyncCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeSituacaoSecaoSyncCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function comando_exibe_totais_da_carga_concluida(): void
public function comando_nao_expoe_a_mensagem_original_quando_falha(): void
public function __construct(private array $resultado, private ?Throwable $erro = null) {}
public function sincronizar(bool $forcar = false): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Scde\ScdeSituacaoSecaoSyncService;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;
use Throwable;

class ScdeSituacaoSecaoSyncCommandTest extends TestCase
{
    #[Test]
    public function comando_exibe_totais_da_carga_concluida(): void
    {
        $this->app->instance(ScdeSituacaoSecaoSyncService::class, new ScdeSituacaoSecaoSyncServiceFake([
            'executado' => true,
            'qtd_zonas' => 9,
            'qtd_secoes' => 2380,
            'qtd_registros' => 4760,
        ]));

        $this->artisan('sync:scde:situacao-secao')
            ->expectsOutput('SCDE sincronizado: 9 zona(s), 2380 seção(ões) e 4760 registro(s).')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_nao_expoe_a_mensagem_original_quando_falha(): void
    {
        $this->app->instance(
            ScdeSituacaoSecaoSyncService::class,
            new ScdeSituacaoSecaoSyncServiceFake([], new RuntimeException('API-Authorization: segredo')),
        );

        $this->artisan('sync:scde:situacao-secao')
            ->expectsOutput('Não foi possível sincronizar a situação das seções do SCDE.')
            ->doesntExpectOutput('API-Authorization: segredo')
            ->assertExitCode(1);
    }
}

class ScdeSituacaoSecaoSyncServiceFake extends ScdeSituacaoSecaoSyncService
{
    /** @param array<string, int|bool|string> $resultado */
    public function __construct(private array $resultado, private ?Throwable $erro = null) {}

    public function sincronizar(bool $forcar = false): array
    {
        if ($this->erro !== null) {
            throw $this->erro;
        }

        return $this->resultado;
    }
}
```
</TESTS_UNIT_SCDESITUACAOSECAOSYNCCOMMANDTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeSituacaoSecaoSyncServiceTest.php`
## <TESTS_UNIT_SCDESITUACAOSECAOSYNCSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeSituacaoSecaoSyncServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeSituacaoSecaoSyncServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function consulta_as_nove_zonas_sequencialmente_e_publica_apenas_o_conjunto_completo(): void
public function falha_de_uma_zona_nao_faz_retry_nem_publica_e_registra_erro_sanitizado(): void
public function recusa_zero_no_mesmo_contexto_e_aceita_em_contexto_novo(): void
public function lock_compartilhado_impede_sobreposicao(): void
private function dependencias(): array
private function configuracao(): array
private function normalizado(int $zona): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Scde\ScdeConfiguracaoRepository;
use App\Repositories\Scde\ScdeSituacaoSecaoRepository;
use App\Services\Scde\ScdeClient;
use App\Services\Scde\ScdeSituacaoSecaoNormalizer;
use App\Services\Scde\ScdeSituacaoSecaoSyncService;
use Illuminate\Support\Facades\Cache;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class ScdeSituacaoSecaoSyncServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Cache::flush();
        config(['services.scde.sync_enabled' => true]);
    }

    #[Test]
    public function consulta_as_nove_zonas_sequencialmente_e_publica_apenas_o_conjunto_completo(): void
    {
        [$client, $normalizer, $configuracoes, $snapshot] = $this->dependencias();
        $configuracoes->shouldReceive('buscarAtiva')->once()->andReturn($this->configuracao());
        $snapshot->shouldReceive('registrarTentativa')->once()->with(7);
        $snapshot->shouldReceive('listarZonas')->once()->andReturn(range(1, 9));
        foreach (range(1, 9) as $zona) {
            $client->shouldReceive('consultarSituacaoSecao')->once()->ordered()
                ->with(9306, 12454, 'AC', $zona)->andReturn([['zona' => $zona]]);
            $normalizer->shouldReceive('normalizarLote')->once()->ordered()
                ->with([['zona' => $zona]], 9306, 12454, 'AC', $zona)
                ->andReturn([$this->normalizado($zona)]);
        }
        $snapshot->shouldReceive('publicar')->once()->with(
            7,
            9306,
            12454,
            Mockery::on(static fn (array $linhas): bool => count($linhas) === 9),
            9,
            9,
            Mockery::type('int'),
        )->andReturn(9);

        $resultado = (new ScdeSituacaoSecaoSyncService(
            $client,
            $normalizer,
            $configuracoes,
            $snapshot,
        ))->sincronizar();

        $this->assertSame(9, $resultado['qtd_zonas']);
        $this->assertSame(9, $resultado['qtd_secoes']);
        $this->assertSame(9, $resultado['qtd_registros']);
    }

    #[Test]
    public function falha_de_uma_zona_nao_faz_retry_nem_publica_e_registra_erro_sanitizado(): void
    {
        [$client, $normalizer, $configuracoes, $snapshot] = $this->dependencias();
        $configuracoes->shouldReceive('buscarAtiva')->once()->andReturn($this->configuracao());
        $snapshot->shouldReceive('registrarTentativa')->once()->with(7);
        $snapshot->shouldReceive('listarZonas')->once()->andReturn(range(1, 9));
        $client->shouldReceive('consultarSituacaoSecao')->once()->ordered()
            ->with(9306, 12454, 'AC', 1)->andReturn([['zona' => 1]]);
        $normalizer->shouldReceive('normalizarLote')->once()->ordered()
            ->andReturn([$this->normalizado(1)]);
        $client->shouldReceive('consultarSituacaoSecao')->once()->ordered()
            ->with(9306, 12454, 'AC', 2)->andThrow(new RuntimeException('driver com token-de-teste'));
        $snapshot->shouldReceive('publicar')->never();
        $snapshot->shouldReceive('registrarErro')->once()->with(
            7,
            'Falha ao consultar ou validar os dados do SCDE.',
            Mockery::type('int'),
        );

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('driver com token-de-teste');

        (new ScdeSituacaoSecaoSyncService($client, $normalizer, $configuracoes, $snapshot))->sincronizar();
    }

    #[Test]
    public function recusa_zero_no_mesmo_contexto_e_aceita_em_contexto_novo(): void
    {
        foreach ([
            [['cod_pleito' => 9306, 'cod_eleicao' => 12454, 'qtd_registros' => 10], false],
            [['cod_pleito' => 3220, 'cod_eleicao' => 6259, 'qtd_registros' => 10], true],
            [null, true],
        ] as [$contextoAtual, $permitido]) {
            Cache::flush();
            [$client, $normalizer, $configuracoes, $snapshot] = $this->dependencias();
            $configuracoes->shouldReceive('buscarAtiva')->once()->andReturn($this->configuracao());
            $snapshot->shouldReceive('registrarTentativa')->once()->with(7);
            $snapshot->shouldReceive('listarZonas')->once()->andReturn(range(1, 9));
            foreach (range(1, 9) as $zona) {
                $client->shouldReceive('consultarSituacaoSecao')->once()->with(9306, 12454, 'AC', $zona)->andReturn([]);
                $normalizer->shouldReceive('normalizarLote')->once()->with([], 9306, 12454, 'AC', $zona)->andReturn([]);
            }
            $snapshot->shouldReceive('contextoAtual')->once()->andReturn($contextoAtual);

            if ($permitido) {
                $snapshot->shouldReceive('publicar')->once()->andReturn(0);
                $resultado = (new ScdeSituacaoSecaoSyncService($client, $normalizer, $configuracoes, $snapshot))->sincronizar();
                $this->assertSame(0, $resultado['qtd_registros']);
            } else {
                $snapshot->shouldReceive('publicar')->never();
                $snapshot->shouldReceive('registrarErro')->once();
                try {
                    (new ScdeSituacaoSecaoSyncService($client, $normalizer, $configuracoes, $snapshot))->sincronizar();
                    $this->fail('A transicao inesperada para zero deveria falhar.');
                } catch (RuntimeException $exception) {
                    $this->assertStringContainsString('vazia', $exception->getMessage());
                }
            }
        }
    }

    #[Test]
    public function lock_compartilhado_impede_sobreposicao(): void
    {
        $lock = Cache::lock('scde:situacao-secao:sync', 300);
        $this->assertTrue($lock->get());

        try {
            [$client, $normalizer, $configuracoes, $snapshot] = $this->dependencias();
            $configuracoes->shouldReceive('buscarAtiva')->never();
            $client->shouldReceive('consultarSituacaoSecao')->never();

            $resultado = (new ScdeSituacaoSecaoSyncService(
                $client,
                $normalizer,
                $configuracoes,
                $snapshot,
            ))->sincronizar();

            $this->assertSame('sobreposicao', $resultado['motivo']);
        } finally {
            $lock->release();
        }
    }

    /** @return array{ScdeClient,ScdeSituacaoSecaoNormalizer,ScdeConfiguracaoRepository,ScdeSituacaoSecaoRepository} */
    private function dependencias(): array
    {
        return [
            Mockery::mock(ScdeClient::class),
            Mockery::mock(ScdeSituacaoSecaoNormalizer::class),
            Mockery::mock(ScdeConfiguracaoRepository::class),
            Mockery::mock(ScdeSituacaoSecaoRepository::class),
        ];
    }

    /** @return array<string, int> */
    private function configuracao(): array
    {
        return ['id' => 7, 'cod_pleito' => 9306, 'cod_eleicao' => 12454, 'ativo' => 1];
    }

    /** @return array<string, int|string|null> */
    private function normalizado(int $zona): array
    {
        return [
            'cod_pleito' => 9306,
            'cod_eleicao' => 12454,
            'sg_ue_uf' => 'AC',
            'nr_zona' => $zona,
            'nr_secao' => $zona,
            'cd_tipo_cargo_pergunta' => 13,
        ];
    }
}
```
</TESTS_UNIT_SCDESITUACAOSECAOSYNCSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisorPredioExclusaoControllerTest.php`
## <TESTS_UNIT_SUPERVISORPREDIOEXCLUSAOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisorPredioExclusaoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisorPredioExclusaoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function encerramento_inativa_supervisor_publico_ou_interno_encontrado_no_escopo(): void
public function encerramento_retorna_404_para_supervisor_fora_do_escopo_zonal(): void
public function encerramento_e_bloqueado_sem_acl_nominal(): void
private function mockZonaPermitida(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\VoluntarioFuncaoInativacaoRepository;
use App\Services\ColaboradoresEleitorais\VoluntarioFuncaoInativacaoService;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SupervisorPredioExclusaoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function encerramento_inativa_supervisor_publico_ou_interno_encontrado_no_escopo(): void
    {
        $this->withoutMiddleware();
        $repository = Mockery::mock(VoluntarioFuncaoInativacaoRepository::class);
        $service = Mockery::mock(VoluntarioFuncaoInativacaoService::class);
        $service->shouldReceive('inativar')->once()->with(
            'SUPERVISOR_PREDIO',
            63,
            'ENCERRAMENTO_FUNCAO',
            'Encerramento administrativo',
            'operador',
            'Operador Teste',
            [],
            true
        )->andReturn((object) ['id' => 91]);
        $this->app->instance(VoluntarioFuncaoInativacaoRepository::class, $repository);
        $this->app->instance(VoluntarioFuncaoInativacaoService::class, $service);

        $response = $this->withSession([
            'rotas_permitidas' => ['*'],
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
            'user' => ['username' => 'operador', 'name' => 'Operador Teste'],
        ])->delete(route('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.destroy', ['id' => 63]), [
            'finalidade' => 'ENCERRAMENTO_FUNCAO',
            'motivo' => 'Encerramento administrativo',
        ]);

        $response->assertRedirect();
        $response->assertSessionHas('status');
    }

    #[Test]
    public function encerramento_retorna_404_para_supervisor_fora_do_escopo_zonal(): void
    {
        $this->withoutMiddleware();
        $this->mockZonaPermitida();
        $repository = Mockery::mock(VoluntarioFuncaoInativacaoRepository::class);
        $service = Mockery::mock(VoluntarioFuncaoInativacaoService::class);
        $service->shouldReceive('inativar')
            ->once()
            ->andThrow((new ModelNotFoundException())->setModel('SUPERVISOR_PREDIO', [63]));
        $this->app->instance(VoluntarioFuncaoInativacaoRepository::class, $repository);
        $this->app->instance(VoluntarioFuncaoInativacaoService::class, $service);

        $response = $this->withSession([
            'rotas_permitidas' => ['*'],
            'cod_zonas_permitidas' => [9],
            'acesso_todas_zonas' => false,
            'user' => ['username' => 'operador', 'name' => 'Operador Teste'],
        ])->delete(route('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.destroy', ['id' => 63]), [
            'finalidade' => 'ENCERRAMENTO_FUNCAO',
            'motivo' => 'Encerramento administrativo',
        ]);

        $response->assertNotFound();
    }

    #[Test]
    public function encerramento_e_bloqueado_sem_acl_nominal(): void
    {
        $this->withoutMiddleware();
        $repository = Mockery::mock(VoluntarioFuncaoInativacaoRepository::class);
        $service = Mockery::mock(VoluntarioFuncaoInativacaoService::class);
        $service->shouldNotReceive('inativar');
        $this->app->instance(VoluntarioFuncaoInativacaoRepository::class, $repository);
        $this->app->instance(VoluntarioFuncaoInativacaoService::class, $service);

        $response = $this->withSession([
            'rotas_permitidas' => [],
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
            'user' => ['username' => 'operador', 'name' => 'Operador Teste'],
        ])->delete(route('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.destroy', ['id' => 63]), [
            'finalidade' => 'ENCERRAMENTO_FUNCAO',
            'motivo' => 'Encerramento administrativo',
        ]);

        $response->assertForbidden();
    }

    private function mockZonaPermitida(): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('selectRaw')->once()->with('TO_CHAR(num_zona) as num_zona')->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->with('id', [9])->andReturnSelf();
        $builder->shouldReceive('orWhereIn')->once()->with('num_zona', [9])->andReturnSelf();
        $builder->shouldReceive('pluck')->once()->with('num_zona')->andReturn(collect(['9']));
        DB::shouldReceive('table')->once()->with('zona')->andReturn($builder);
    }
}
```
</TESTS_UNIT_SUPERVISORPREDIOEXCLUSAOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisorPredioRotaExclusividadeMigrationTest.php`
## <TESTS_UNIT_SUPERVISORPREDIOROTAEXCLUSIVIDADEMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisorPredioRotaExclusividadeMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisorPredioRotaExclusividadeMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function limpeza_e_restrita_a_supervisor_ativo_em_equipe_de_rota_e_possui_snapshot(): void
public function banco_bloqueia_a_exclusividade_nos_dois_sentidos(): void
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

class SupervisorPredioRotaExclusividadeMigrationTest extends TestCase
{
    #[Test]
    public function limpeza_e_restrita_a_supervisor_ativo_em_equipe_de_rota_e_possui_snapshot(): void
    {
        $conteudo = file_get_contents(base_path(
            'database/migrations/2026_07_28_140000_remove_supervisores_predio_ativos_das_equipes_rota.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("ev.TIPO_VINCULO = 'ROTA'", $conteudo);
        $this->assertStringContainsString('csp.ATIVO = 1', $conteudo);
        $this->assertStringContainsString('TRIM(csp.NUM_INSCRICAO) = TRIM(e.NUM_INSCRICAO)', $conteudo);
        $this->assertStringContainsString('AUDITORIA_ACAO', $conteudo);
        $this->assertStringContainsString('DADOS_ANTES_JSON', $conteudo);
        $this->assertStringContainsString('restaurar', $conteudo);
    }

    #[Test]
    public function banco_bloqueia_a_exclusividade_nos_dois_sentidos(): void
    {
        $conteudo = file_get_contents(base_path(
            'database/migrations/2026_07_28_140100_create_supervisor_predio_rota_exclusivity_triggers.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE OR REPLACE TRIGGER TRG_EQUIPE_BLOQ_SUP_PREDIO', $conteudo);
        $this->assertStringContainsString('CREATE OR REPLACE TRIGGER TRG_CSP_BLOQ_EQUIPE_ROTA', $conteudo);
        $this->assertStringContainsString('RAISE_APPLICATION_ERROR(-20061', $conteudo);
        $this->assertStringContainsString('RAISE_APPLICATION_ERROR(-20062', $conteudo);
        $this->assertStringContainsString('DROP TRIGGER TRG_EQUIPE_BLOQ_SUP_PREDIO', $conteudo);
        $this->assertStringContainsString('DROP TRIGGER TRG_CSP_BLOQ_EQUIPE_ROTA', $conteudo);
    }
}
```
</TESTS_UNIT_SUPERVISORPREDIOROTAEXCLUSIVIDADEMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisorPredioRotaExclusividadeQueryTest.php`
## <TESTS_UNIT_SUPERVISORPREDIOROTAEXCLUSIVIDADEQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisorPredioRotaExclusividadeQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisorPredioRotaExclusividadeQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('CAD_SUPERVISOR_PREDIO', function (Blueprint $table): void {
Schema::create('EQUIPE_VINCULO', function (Blueprint $table): void {
Schema::create('EQUIPE', function (Blueprint $table): void {
Schema::create('CANDIDATOS', function (Blueprint $table): void {
DB::table('CAD_SUPERVISOR_PREDIO')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function identifica_apenas_supervisores_ativos_entre_os_titulos_informados(): void
public function exclusao_da_consulta_oculta_ativo_e_preserva_inativo(): void
public function detecta_somente_alocacao_operacional_em_rota(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\SupervisoresPredio\SupervisorPredioRotaExclusividadeQuery;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SupervisorPredioRotaExclusividadeQueryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('CAD_SUPERVISOR_PREDIO', function (Blueprint $table): void {
            $table->increments('ID_SUPERVISOR_PREDIO');
            $table->string('NUM_INSCRICAO');
            $table->integer('ATIVO');
        });
        Schema::create('EQUIPE_VINCULO', function (Blueprint $table): void {
            $table->increments('ID');
            $table->string('TIPO_VINCULO');
            $table->integer('VINCULO_ID');
        });
        Schema::create('EQUIPE', function (Blueprint $table): void {
            $table->increments('ID');
            $table->integer('ROTA_ID')->nullable();
            $table->integer('EQUIPE_VINCULO_ID');
            $table->string('NUM_INSCRICAO');
        });
        Schema::create('CANDIDATOS', function (Blueprint $table): void {
            $table->increments('ID');
            $table->string('NUM_INSCRICAO');
        });
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('CANDIDATOS');
        Schema::dropIfExists('EQUIPE');
        Schema::dropIfExists('EQUIPE_VINCULO');
        Schema::dropIfExists('CAD_SUPERVISOR_PREDIO');

        parent::tearDown();
    }

    #[Test]
    public function identifica_apenas_supervisores_ativos_entre_os_titulos_informados(): void
    {
        DB::table('CAD_SUPERVISOR_PREDIO')->insert([
            ['NUM_INSCRICAO' => ' 000000000123 ', 'ATIVO' => 1],
            ['NUM_INSCRICAO' => '000000000456', 'ATIVO' => 0],
        ]);

        $resultado = SupervisorPredioRotaExclusividadeQuery::listarSupervisoresAtivos([
            '000000000123',
            '000000000456',
            '',
        ]);

        $this->assertSame(['000000000123'], $resultado);
    }

    #[Test]
    public function exclusao_da_consulta_oculta_ativo_e_preserva_inativo(): void
    {
        DB::table('CAD_SUPERVISOR_PREDIO')->insert([
            ['NUM_INSCRICAO' => '000000000123', 'ATIVO' => 1],
            ['NUM_INSCRICAO' => '000000000456', 'ATIVO' => 0],
        ]);
        DB::table('CANDIDATOS')->insert([
            ['NUM_INSCRICAO' => '000000000123'],
            ['NUM_INSCRICAO' => '000000000456'],
            ['NUM_INSCRICAO' => '000000000789'],
        ]);

        $query = SupervisorPredioRotaExclusividadeQuery::excluirSupervisoresAtivos(
            DB::table('CANDIDATOS as c'),
            'c.NUM_INSCRICAO'
        );

        $this->assertSame(
            ['000000000456', '000000000789'],
            $query->orderBy('c.NUM_INSCRICAO')->pluck('c.NUM_INSCRICAO')->all()
        );
    }

    #[Test]
    public function detecta_somente_alocacao_operacional_em_rota(): void
    {
        DB::table('EQUIPE_VINCULO')->insert([
            ['ID' => 1, 'TIPO_VINCULO' => 'ROTA', 'VINCULO_ID' => 10],
            ['ID' => 2, 'TIPO_VINCULO' => 'LDA', 'VINCULO_ID' => 20],
        ]);
        DB::table('EQUIPE')->insert([
            ['ROTA_ID' => 10, 'EQUIPE_VINCULO_ID' => 1, 'NUM_INSCRICAO' => '000000000123'],
            ['ROTA_ID' => null, 'EQUIPE_VINCULO_ID' => 2, 'NUM_INSCRICAO' => '000000000456'],
        ]);

        $this->assertTrue(SupervisorPredioRotaExclusividadeQuery::tituloAlocadoEmRota('000000000123'));
        $this->assertFalse(SupervisorPredioRotaExclusividadeQuery::tituloAlocadoEmRota('000000000456'));
    }
}
```
</TESTS_UNIT_SUPERVISORPREDIOROTAEXCLUSIVIDADEQUERYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisoresPredioEditarLocalUiTest.php`
## <TESTS_UNIT_SUPERVISORESPREDIOEDITARLOCALUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisoresPredioEditarLocalUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisoresPredioEditarLocalUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listagem_exibe_acao_de_alterar_local_de_atuacao_quando_autorizada(): void
public function listagem_exibe_consulta_parametrizada_com_opcao_de_local_com_mais_de_um_supervisor(): void
public function formulario_admin_de_edicao_exibe_resumo_e_campos_de_selecao_do_novo_local(): void
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

class SupervisoresPredioEditarLocalUiTest extends TestCase
{
    #[Test]
    public function listagem_exibe_acao_de_alterar_local_de_atuacao_quando_autorizada(): void
    {
        $blade = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php'));

        $this->assertIsString($blade);
        $this->assertStringContainsString('Alterar local de atuação', $blade);
        $this->assertStringContainsString('colaboradores-eleitorais.externos.supervisores-predio-voluntarios.editar-local', $blade);
    }

    #[Test]
    public function listagem_exibe_consulta_parametrizada_com_opcao_de_local_com_mais_de_um_supervisor(): void
    {
        $blade = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php'));

        $this->assertIsString($blade);
        $this->assertStringContainsString('Consulta parametrizada', $blade);
        $this->assertStringContainsString('name="local_coincide"', $blade);
        $this->assertStringContainsString('value="mais_de_um_supervisor_local"', $blade);
        $this->assertStringContainsString('Local de atuação com mais de um supervisor alocado', $blade);
        $this->assertStringContainsString('value="sem_supervisor_local"', $blade);
        $this->assertStringContainsString('Locais sem supervisor de prédio voluntário alocado', $blade);
    }

    #[Test]
    public function formulario_admin_de_edicao_exibe_resumo_e_campos_de_selecao_do_novo_local(): void
    {
        $blade = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/editar-local.blade.php'));

        $this->assertIsString($blade);
        $this->assertStringContainsString('Alterar local de atuação do Supervisor de Prédio', $blade);
        $this->assertStringContainsString('Supervisor no local', $blade);
        $this->assertStringContainsString('Vota no local', $blade);
        $this->assertStringContainsString('name="municipio"', $blade);
        $this->assertStringContainsString('name="cod_objeto_local_votacao"', $blade);
        $this->assertStringContainsString('id="filtroMunicipioLocalSupervisor" name="municipio" class="form-select select2"', $blade);
        $this->assertStringContainsString('id="campoLocalAtuacaoSupervisor" name="cod_objeto_local_votacao" class="form-select select2"', $blade);
        $this->assertStringContainsString('select2({', $blade);
        $this->assertStringContainsString("filtroMunicipio.addEventListener('change'", $blade);
        $this->assertStringContainsString('filtroMunicipio.form.submit();', $blade);
        $this->assertStringNotContainsString('name="zona"', $blade);
        $this->assertStringNotContainsString('Carregar locais', $blade);
    }
}
```
</TESTS_UNIT_SUPERVISORESPREDIOEDITARLOCALUITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SupervisoresPredioTabelaResponsivaTest.php`
## <TESTS_UNIT_SUPERVISORESPREDIOTABELARESPONSIVATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SupervisoresPredioTabelaResponsivaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SupervisoresPredioTabelaResponsivaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function tabela_tem_apenas_colunas_supervisor_e_acoes(): void
public function coluna_principal_usa_layout_de_linha_com_row_g2(): void
public function coluna_principal_exibe_campos_com_icones_fa(): void
public function coluna_principal_exibe_tanto_local_de_atuacao_quanto_local_onde_vota(): void
public function coluna_principal_nao_usa_br_para_separar_campos(): void
public function botao_detalhes_possui_title_e_aria_label(): void
public function collapse_de_respostas_esta_dentro_da_coluna_principal(): void
public function filtros_expoem_data_de_atualizacao_e_a_preservam_na_exportacao(): void
private function extrairTdPrincipal(): string
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

class SupervisoresPredioTabelaResponsivaTest extends TestCase
{
    private string $blade;

    protected function setUp(): void
    {
        parent::setUp();
        $this->blade = file_get_contents(
            resource_path('views/colaboradores-eleitorais/externos/supervisores-predio/index.blade.php')
        );
    }

    #[Test]
    public function tabela_tem_apenas_colunas_supervisor_e_acoes(): void
    {
        $this->assertStringContainsString('<th scope="col">Supervisor</th>', $this->blade);
        $this->assertStringContainsString('<th scope="col">Ações</th>', $this->blade);

        $this->assertStringNotContainsString('<th>Local de votação</th>', $this->blade);
        $this->assertStringNotContainsString('<th>Contato</th>', $this->blade);
        $this->assertStringNotContainsString('<th>Banco</th>', $this->blade);
        $this->assertStringNotContainsString('<th>Cadastro</th>', $this->blade);
    }

    #[Test]
    public function coluna_principal_usa_layout_de_linha_com_row_g2(): void
    {
        $this->assertStringContainsString('div class="row g-2', $this->blade);
    }

    #[Test]
    public function coluna_principal_exibe_campos_com_icones_fa(): void
    {
        $this->assertStringContainsString('fa-user', $this->blade);
        $this->assertStringContainsString('fa-id-card', $this->blade);
        $this->assertStringContainsString('fa-layer-group', $this->blade);
        $this->assertStringContainsString('fa-school', $this->blade);
        $this->assertStringContainsString('fa-map-location-dot', $this->blade);
        $this->assertStringContainsString('fa-envelope', $this->blade);
        $this->assertStringContainsString('fa-phone', $this->blade);
    }

    #[Test]
    public function coluna_principal_exibe_tanto_local_de_atuacao_quanto_local_onde_vota(): void
    {
        $this->assertStringContainsString('Supervisor no local', $this->blade);
        $this->assertStringContainsString('Vota no local', $this->blade);
    }

    #[Test]
    public function coluna_principal_nao_usa_br_para_separar_campos(): void
    {
        $tdPrincipal = $this->extrairTdPrincipal();
        $this->assertStringNotContainsString('<br>', $tdPrincipal);
    }

    #[Test]
    public function botao_detalhes_possui_title_e_aria_label(): void
    {
        $this->assertStringContainsString('fa-eye', $this->blade);
        $this->assertStringContainsString('title="Mostrar autorizações e disponibilidade"', $this->blade);
        $this->assertStringContainsString('aria-label="Mostrar autorizações e disponibilidade"', $this->blade);
    }

    #[Test]
    public function collapse_de_respostas_esta_dentro_da_coluna_principal(): void
    {
        $this->assertStringContainsString('Autorizações e disponibilidade', $this->blade);
        $this->assertStringContainsString('data-bs-toggle="collapse"', $this->blade);
        $this->assertStringContainsString('colspan="2"', $this->blade);
    }

    #[Test]
    public function filtros_expoem_data_de_atualizacao_e_a_preservam_na_exportacao(): void
    {
        $this->assertStringContainsString("Data de atualização", $this->blade);
        $this->assertStringContainsString('type="date"', $this->blade);
        $this->assertStringContainsString('name="dt_atualizacao_de"', $this->blade);
        $this->assertStringContainsString('name="dt_atualizacao_ate"', $this->blade);
        $this->assertStringContainsString('id="pdfSpHiddenDtAtualizacaoDe"', $this->blade);
        $this->assertStringContainsString('id="pdfSpHiddenDtAtualizacaoAte"', $this->blade);

    }

    private function extrairTdPrincipal(): string
    {
        if (preg_match('/<td>\s*<div class="row g-2.*?<\/td>/s', $this->blade, $m)) {
            return $m[0];
        }
        return $this->blade;
    }
}
```
</TESTS_UNIT_SUPERVISORESPREDIOTABELARESPONSIVATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TbTransmissaoVotacaoPreferenciasMigrationTest.php`
## <TESTS_UNIT_TBTRANSMISSAOVOTACAOPREFERENCIASMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TbTransmissaoVotacaoPreferenciasMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TbTransmissaoVotacaoPreferenciasMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringNotContainsString('DB::table(', $conteudo);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_remove_indice_que_bloqueia_multiplos_locais_transmissao_sem_alterar_dados(): void
public function indice_unificado_preservado_impede_destino_duplicado_sem_bloquear_destinos_distintos(): void
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

class TbTransmissaoVotacaoPreferenciasMigrationTest extends TestCase
{
    #[Test]
    public function migration_remove_indice_que_bloqueia_multiplos_locais_transmissao_sem_alterar_dados(): void
    {
        $arquivo = database_path('migrations/2026_07_21_130000_drop_legacy_tbtransmissaovotacao_local_lda_index.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString(
            "private const LEGACY_INDEX = 'UX_TBTRANSMISSAOVOTACAO_LOCAL_LDA';",
            $conteudo
        );
        $this->assertStringContainsString('DROP INDEX planeleito.', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX planeleito.', $conteudo);
        $this->assertStringContainsString('(cod_objeto_local, lda_id)', $conteudo);
        $this->assertStringContainsString('FROM user_indexes', $conteudo);
        $this->assertStringNotContainsString('DB::table(', $conteudo);
        $this->assertDoesNotMatchRegularExpression('/\b(?:INSERT|UPDATE|DELETE|MERGE)\b/i', $conteudo);
    }

    #[Test]
    public function indice_unificado_preservado_impede_destino_duplicado_sem_bloquear_destinos_distintos(): void
    {
        $conteudo = file_get_contents(database_path(
            'migrations/2026_03_18_140000_fix_tbtransmissaovotacao_local_transmissao_unique_index.php'
        ));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString(
            '(cod_objeto_local, local_transmissao_id, lda_id)',
            $conteudo
        );
    }
}
```
</TESTS_UNIT_TBTRANSMISSAOVOTACAOPREFERENCIASMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TrajetoLocalVotacaoApresentacaoTest.php`
## <TESTS_UNIT_TRAJETOLOCALVOTACAOAPRESENTACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TrajetoLocalVotacaoApresentacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TrajetoLocalVotacaoApresentacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function resume_todas_as_alternativas_sem_somar_tempos_ou_repetir_transportes(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\TrajetoLocalVotacaoApresentacao;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class TrajetoLocalVotacaoApresentacaoTest extends TestCase
{
    #[Test]
    public function resume_todas_as_alternativas_sem_somar_tempos_ou_repetir_transportes(): void
    {
        $resumos = TrajetoLocalVotacaoApresentacao::resumirPorLocal([
            (object) [
                'cod_objeto_local' => ' LV-1 ',
                'trajeto_id' => 10,
                'ordem_preferencia' => 1,
                'descricao' => 'Via fluvial',
                'ordem_trecho' => 1,
                'acesso_id' => 3,
                'acesso_descricao' => 'BARCO',
                'tempo_deslocamento_horas' => 0.25,
            ],
            (object) [
                'cod_objeto_local' => 'LV-1',
                'trajeto_id' => 10,
                'ordem_preferencia' => 1,
                'descricao' => 'Via fluvial',
                'ordem_trecho' => 2,
                'acesso_id' => 3,
                'acesso_descricao' => 'BARCO',
                'tempo_deslocamento_horas' => 0.25,
            ],
            (object) [
                'cod_objeto_local' => 'LV-1',
                'trajeto_id' => 20,
                'ordem_preferencia' => 2,
                'descricao' => 'Alternativa aerea',
                'ordem_trecho' => 1,
                'acesso_id' => 4,
                'acesso_descricao' => 'HELICOPTERO',
                'tempo_deslocamento_horas' => 2,
            ],
            (object) [
                'cod_objeto_local' => 'LV-1',
                'trajeto_id' => 30,
                'ordem_preferencia' => 3,
                'descricao' => null,
                'ordem_trecho' => 1,
                'acesso_id' => 2,
                'acesso_descricao' => 'CARRO',
                'tempo_deslocamento_horas' => null,
            ],
        ]);

        $this->assertArrayHasKey('LV-1', $resumos);
        $this->assertCount(3, $resumos['LV-1']);
        $this->assertSame([
            'ordem_preferencia' => 1,
            'principal' => true,
            'descricao' => 'Via fluvial',
            'tempo_horas' => 0.5,
            'tempo_descricao' => '30min (Crepúsculo)',
            'transportes' => ['BARCO'],
            'transportes_descricao' => 'BARCO',
        ], $resumos['LV-1'][0]);
        $this->assertSame('2h (Crepúsculo)', $resumos['LV-1'][1]['tempo_descricao']);
        $this->assertSame(['HELICOPTERO'], $resumos['LV-1'][1]['transportes']);
        $this->assertSame('Sem tempo informado (Crepúsculo)', $resumos['LV-1'][2]['tempo_descricao']);
    }
}
```
</TESTS_UNIT_TRAJETOLOCALVOTACAOAPRESENTACAOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TrajetoLocalVotacaoPayloadTest.php`
## <TESTS_UNIT_TRAJETOLOCALVOTACAOPAYLOADTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TrajetoLocalVotacaoPayloadTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TrajetoLocalVotacaoPayloadTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('acesso', static function (Blueprint $table): void {
\DB::table('acesso')->insert($acesso);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function normaliza_alternativas_e_deriva_ordens_sem_bloquear_transporte_repetido(): void
public function converte_payload_legado_em_uma_alternativa_principal(): void
public function rejeita_alternativa_sem_trecho_acesso_inexistente_e_valores_negativos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\TrajetoLocalVotacaoPayload;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class TrajetoLocalVotacaoPayloadTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('acesso', static function (Blueprint $table): void {
            $table->unsignedBigInteger('id')->primary();
            $table->string('descricao');
        });

        foreach ([
            ['id' => 2, 'descricao' => 'BARCO'],
            ['id' => 3, 'descricao' => 'CARRO 4x4'],
            ['id' => 4, 'descricao' => 'HELICOPTERO'],
        ] as $acesso) {

            \DB::table('acesso')->insert($acesso);
        }
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('acesso');

        parent::tearDown();
    }

    #[Test]
    public function normaliza_alternativas_e_deriva_ordens_sem_bloquear_transporte_repetido(): void
    {
        $entrada = TrajetoLocalVotacaoPayload::normalizarEntrada([
            [
                'descricao' => '  Via fluvial  ',
                'trechos' => [
                    ['acesso_id' => '3', 'origem' => ' Sede ', 'destino' => ' Porto ', 'distancia_km' => '10,5', 'tempo_deslocamento_horas' => '0,5'],
                    ['acesso_id' => '2', 'origem' => ' Porto ', 'destino' => ' Escola ', 'distancia_km' => '30', 'tempo_deslocamento_horas' => '2'],
                    ['acesso_id' => '3', 'origem' => ' Escola ', 'destino' => ' Anexo '],
                ],
            ],
            [
                'descricao' => ' Via aerea ',
                'trechos' => [
                    ['acesso_id' => '4', 'origem' => ' Sede ', 'destino' => ' Escola ', 'tempo_deslocamento_horas' => '1'],
                ],
            ],
        ]);

        $validator = Validator::make(['trajetos' => $entrada], TrajetoLocalVotacaoPayload::regras());

        $this->assertFalse($validator->fails(), $validator->errors()->toJson());
        $trajetos = TrajetoLocalVotacaoPayload::sanitizar($validator->validated()['trajetos']);
        $this->assertSame('Via fluvial', $trajetos[0]['descricao']);
        $this->assertSame([1, 2], array_column($trajetos, 'ordem_preferencia'));
        $this->assertSame([1, 2, 3], array_column($trajetos[0]['trechos'], 'ordem'));
        $this->assertSame([3, 2, 3], array_column($trajetos[0]['trechos'], 'acesso_id'));
        $this->assertSame(10.5, $trajetos[0]['trechos'][0]['distancia_km']);
        $this->assertSame(0.5, $trajetos[0]['trechos'][0]['tempo_deslocamento_horas']);
        $this->assertSame([3, 2], TrajetoLocalVotacaoPayload::acessosPrincipais($trajetos));
    }

    #[Test]
    public function converte_payload_legado_em_uma_alternativa_principal(): void
    {
        $entrada = TrajetoLocalVotacaoPayload::normalizarEntrada(null, [
            ['acesso_id' => '2', 'origem' => 'Porto', 'destino' => 'Escola'],
        ]);

        $this->assertCount(1, $entrada);
        $this->assertSame('', $entrada[0]['descricao']);
        $this->assertSame('2', $entrada[0]['trechos'][0]['acesso_id']);
    }

    #[Test]
    public function rejeita_alternativa_sem_trecho_acesso_inexistente_e_valores_negativos(): void
    {
        $validator = Validator::make([
            'trajetos' => [
                ['descricao' => 'Vazia', 'trechos' => []],
                ['descricao' => 'Invalida', 'trechos' => [[
                    'acesso_id' => 999,
                    'distancia_km' => -1,
                    'tempo_deslocamento_horas' => -0.5,
                ]]],
            ],
        ], TrajetoLocalVotacaoPayload::regras());

        $this->assertTrue($validator->errors()->has('trajetos.0.trechos'));
        $this->assertTrue($validator->errors()->has('trajetos.1.trechos.0.acesso_id'));
        $this->assertTrue($validator->errors()->has('trajetos.1.trechos.0.distancia_km'));
        $this->assertTrue($validator->errors()->has('trajetos.1.trechos.0.tempo_deslocamento_horas'));
    }
}
```
</TESTS_UNIT_TRAJETOLOCALVOTACAOPAYLOADTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TrajetoLocalVotacaoServiceTest.php`
## <TESTS_UNIT_TRAJETOLOCALVOTACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TrajetoLocalVotacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TrajetoLocalVotacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_salva_agregado_e_sincroniza_cada_lda_com_transportes_da_alternativa_principal(): void
public function test_busca_converte_resumo_legado_em_alternativa_transitoria_quando_nao_ha_agregado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Repositories\LocaisVotacao\TrajetoLocalVotacaoRepository;
use App\Services\LocaisVotacao\TrajetoLocalVotacaoService;
use Mockery;
use Tests\TestCase;

class TrajetoLocalVotacaoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_salva_agregado_e_sincroniza_cada_lda_com_transportes_da_alternativa_principal(): void
    {
        $trajetos = [
            [
                'ordem_preferencia' => 1,
                'descricao' => 'Fluvial',
                'trechos' => [
                    ['ordem' => 1, 'acesso_id' => 2],
                    ['ordem' => 2, 'acesso_id' => 3],
                    ['ordem' => 3, 'acesso_id' => 2],
                ],
            ],
            [
                'ordem_preferencia' => 2,
                'descricao' => 'Aérea',
                'trechos' => [['ordem' => 1, 'acesso_id' => 4]],
            ],
        ];

        $repository = Mockery::mock(TrajetoLocalVotacaoRepository::class);
        $repository->shouldReceive('salvarPorLocal')
            ->once()
            ->with('LV-1', 7, $trajetos, null);

        $ldaRepository = Mockery::mock(LocalDificilAcessoRepository::class);
        $ldaRepository->shouldReceive('buscarIdsPorCodigoLocalVotacao')
            ->once()
            ->with('LV-1')
            ->andReturn([10, 11]);
        $ldaRepository->shouldReceive('sincronizarAcessosDoLda')->once()->with(10, [2, 3]);
        $ldaRepository->shouldReceive('sincronizarAcessosDoLda')->once()->with(11, [2, 3]);

        (new TrajetoLocalVotacaoService($repository, $ldaRepository))
            ->salvarPorLocal(' LV-1 ', 7, $trajetos);

        $this->addToAssertionCount(1);
    }

    public function test_busca_converte_resumo_legado_em_alternativa_transitoria_quando_nao_ha_agregado(): void
    {
        $repository = Mockery::mock(TrajetoLocalVotacaoRepository::class);
        $repository->shouldReceive('buscarPorLocal')->once()->with('LV-2', 7)->andReturn([]);

        $ldaRepository = Mockery::mock(LocalDificilAcessoRepository::class);
        $ldaRepository->shouldReceive('buscarAcessosPorCodigoLocalVotacao')
            ->once()
            ->with('LV-2')
            ->andReturn([3, 2]);

        $resultado = (new TrajetoLocalVotacaoService($repository, $ldaRepository))
            ->buscarPorLocal('LV-2', 7);

        $this->assertSame(1, $resultado[0]['ordem_preferencia']);
        $this->assertSame('', $resultado[0]['descricao']);
        $this->assertSame([3, 2], array_column($resultado[0]['trechos'], 'acesso_id'));
        $this->assertSame([1, 2], array_column($resultado[0]['trechos'], 'ordem'));
    }
}
```
</TESTS_UNIT_TRAJETOLOCALVOTACAOSERVICETEST_PHP>


