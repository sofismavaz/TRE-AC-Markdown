# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_tests_feature`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 5 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/ExampleTest.php`
## <TESTS_FEATURE_EXAMPLETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/ExampleTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class ExampleTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_the_application_returns_a_successful_response(): void
private function dadosCalendario(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

// use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Services\CalendarioEleitoral\CalendarioEleitoralConsultaService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    public function test_the_application_returns_a_successful_response(): void
    {
        $this->withoutMiddleware();
        $this->mock(CalendarioEleitoralConsultaService::class)
            ->shouldReceive('consultar')->once()->with(null)->andReturn($this->dadosCalendario());
        $this->mock(LocalVotacaoSyncStatusService::class)
            ->shouldReceive('obterRegistrosMonitorados')->once()->andReturn([]);

        $response = $this->get('/');

        $response->assertStatus(200);
    }

    /** @return array<string, mixed> */
    private function dadosCalendario(): array
    {
        return [
            'pleito' => [
                'id' => 1,
                'ano' => 2026,
                'titulo' => 'Eleições 2026',
                'fonte_referencia' => 'Resolução TSE nº 23.750/2026',
                'fonte_url' => 'https://example.test/calendario',
            ],
            'pleitos' => [['ano' => 2026, 'titulo' => 'Eleições 2026']],
            'competencias' => [],
            'eventos' => [],
        ];
    }
}
```
</TESTS_FEATURE_EXAMPLETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/MonitoramentoMapaDashboardDadosFiltrosTest.php`
## <TESTS_FEATURE_MONITORAMENTOMAPADASHBOARDDADOSFILTROSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/MonitoramentoMapaDashboardDadosFiltrosTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class MonitoramentoMapaDashboardDadosFiltrosTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_endpoint_de_dados_repassa_filtros_de_secoes_e_exclusao_de_lda_ao_repository(): void
public function test_repository_exclui_marcacao_manual_e_fallback_rural_do_dashboard(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Repositories\LocaisVotacao\LocalDeVotacaoRepository;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class MonitoramentoMapaDashboardDadosFiltrosTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_endpoint_de_dados_repassa_filtros_de_secoes_e_exclusao_de_lda_ao_repository(): void
    {
        $this->withoutMiddleware();

        $repository = Mockery::mock(LocalDeVotacaoRepository::class);
        $repository->shouldReceive('monitoramentoMapaDashboard')
            ->once()
            ->with([4, 7], false, true, true, true)
            ->andReturn([
                (object) [
                    'MUNICIPIO' => 'RIO BRANCO',
                    'SECOES_TOTAL' => 2,
                    'LOCAIS_TOTAL' => 1,
                ],
            ]);

        $this->app->instance(LocalDeVotacaoRepository::class, $repository);

        $response = $this
            ->withSession(['acesso_todas_zonas' => false, 'cod_zonas_permitidas' => [4, 7]])
            ->getJson('/cadastro-eleitoral/monitoramento-mapa/dashboard/dados?somente_com_secoes=1&excluir_lda=1&excluir_zona_rural=1');

        $response->assertOk();
        $response->assertJson([
            [
                'municipio' => 'RIO BRANCO',
                'secoes_total' => 2,
                'locais_total' => 1,
            ],
        ]);
    }

    public function test_repository_exclui_marcacao_manual_e_fallback_rural_do_dashboard(): void
    {
        DB::shouldReceive('select')
            ->once()
            ->with(
                Mockery::on(static function (string $sql): bool {
                    $sql = strtolower($sql);

                    return str_contains($sql, 'left join planeleito.bairro b')
                        && str_contains($sql, 'not exists')
                        && str_contains($sql, 'local_votacao_zona_rural')
                        && str_contains($sql, "upper(nvl(b.nom_bairro, '')) not like :zona_rural_bairro");
                }),
                ['zona_rural_bairro' => '%ZONA RURAL%']
            )
            ->andReturn([]);

        $resultado = (new LocalDeVotacaoRepository())->monitoramentoMapaDashboard(
            null,
            true,
            false,
            false,
            true
        );

        $this->assertSame([], $resultado);
    }
}
```
</TESTS_FEATURE_MONITORAMENTOMAPADASHBOARDDADOSFILTROSTEST_PHP>

