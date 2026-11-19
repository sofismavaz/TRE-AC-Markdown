# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_tests_unit`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 69  
> **Tamanho do Arquivo:** 292 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AddCodigoOpcaoBinariaMigrationTest.php`
## <TESTS_UNIT_ADDCODIGOOPCAOBINARIAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AddCodigoOpcaoBinariaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AddCodigoOpcaoBinariaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_codigo_estavel_com_indice_unico_a_opcao_binaria(): void
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

class AddCodigoOpcaoBinariaMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_codigo_estavel_com_indice_unico_a_opcao_binaria(): void
    {
        $arquivo = database_path('migrations/2026_06_20_120000_add_codigo_to_opcao_binaria_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('ALTER TABLE opcao_binaria ADD (codigo VARCHAR2(20 CHAR))', $conteudo);
        $this->assertStringContainsString('MODIFY (codigo VARCHAR2(20 CHAR) NOT NULL)', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_ob_codigo ON opcao_binaria (UPPER(codigo))', $conteudo);
        $this->assertStringContainsString("THEN 'SIM'", $conteudo);
        $this->assertStringContainsString("THEN 'NAO'", $conteudo);
        $this->assertStringContainsString('DROP COLUMN codigo', $conteudo);
    }
}
```
</TESTS_UNIT_ADDCODIGOOPCAOBINARIAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Bootstrap5PaginationGuardrailTest.php`
## <TESTS_UNIT_BOOTSTRAP5PAGINATIONGUARDRAILTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Bootstrap5PaginationGuardrailTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class Bootstrap5PaginationGuardrailTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_listagem_de_riscos_renderiza_paginacao_bootstrap_5(): void
public function test_views_blade_nao_podem_renderizar_paginador_sem_template_bootstrap_5(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Illuminate\Pagination\LengthAwarePaginator;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use Tests\TestCase;

class Bootstrap5PaginationGuardrailTest extends TestCase
{
    public function test_listagem_de_riscos_renderiza_paginacao_bootstrap_5(): void
    {
        $risco = (object) [
            'id' => 1,
            'arquivado' => 0,
            'codigo_externo' => 'R01',
            'titulo' => 'Risco usado no teste de paginação',
            'pendencias_abertas' => 0,
            'projeto_nome' => 'Eleições 2026',
            'unidade_sigla' => 'TESTE',
            'probabilidade_pontos' => 3,
            'impacto_pontos' => 4,
            'nivel_inerente_cor' => '#dc3545',
            'nivel_inerente_nome' => 'Alto',
            'nivel_residual_codigo' => 'MEDIO',
            'nivel_residual_cor' => '#ffc107',
            'nivel_residual_nome' => 'Médio',
            'valor_residual' => 6,
            'status_nome' => 'Aberto',
            'status_codigo' => 'ABERTO',
        ];
        $paginador = new LengthAwarePaginator(
            [$risco],
            21,
            20,
            1,
            ['path' => '/riscos']
        );

        $html = view('planejamento.riscos.lista', [
            'riscos' => $paginador,
            'podeEscrever' => false,
            'podeArquivar' => false,
            'podeReativar' => false,
            'podeResolverPendencias' => false,
        ])->render();

        $this->assertStringContainsString('<ul class="pagination">', $html);
        $this->assertStringNotContainsString('<svg', $html);
    }

    public function test_views_blade_nao_podem_renderizar_paginador_sem_template_bootstrap_5(): void
    {
        $violacoes = [];
        $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator(
            resource_path('views'),
            RecursiveDirectoryIterator::SKIP_DOTS
        ));

        foreach ($iterator as $arquivo) {
            if (! $arquivo->isFile() || ! str_ends_with($arquivo->getFilename(), '.blade.php')) {
                continue;
            }

            $conteudo = file_get_contents($arquivo->getPathname());
            if (! is_string($conteudo)) {
                continue;
            }

            preg_match_all('/->links\s*\((.*?)\)/s', $conteudo, $chamadas, PREG_SET_ORDER | PREG_OFFSET_CAPTURE);
            foreach ($chamadas as $chamada) {
                $argumentos = trim($chamada[1][0]);
                if (preg_match('/^[\'\"]pagination::bootstrap-5[\'\"](?:\s*,|\s*$)/', $argumentos) === 1) {
                    continue;
                }

                $linha = substr_count(substr($conteudo, 0, $chamada[0][1]), "\n") + 1;
                $violacoes[] = str_replace(base_path().DIRECTORY_SEPARATOR, '', $arquivo->getPathname()).':'.$linha;
            }
        }

        $this->assertSame([], $violacoes, "Paginadores Blade sem o template Bootstrap 5 explícito:\n".implode("\n", $violacoes));

        $contrato = file_get_contents(base_path('docs/contratos/frontend.md'));
        $this->assertIsString($contrato);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $contrato);
        $this->assertStringContainsString('Bootstrap5PaginationGuardrailTest', $contrato);
    }
}
```
</TESTS_UNIT_BOOTSTRAP5PAGINATIONGUARDRAILTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CamposPdfSelecionadosTest.php`
## <TESTS_UNIT_CAMPOSPDFSELECIONADOSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CamposPdfSelecionadosTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CamposPdfSelecionadosTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function preserva_ordem_remove_duplicatas_e_aplica_whitelist(): void
public function usa_padrao_para_entrada_nao_array_ou_sem_campos_validos(): void
public function tambem_aceita_lista_de_chaves_permitidas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Exportacao\CamposPdfSelecionados;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class CamposPdfSelecionadosTest extends TestCase
{
    private const PERMITIDOS = [
        'nome' => 'Nome',
        'status' => 'Status',
        'zona' => 'Zona',
    ];

    private const PADRAO = ['nome', 'status'];

    #[Test]
    public function preserva_ordem_remove_duplicatas_e_aplica_whitelist(): void
    {
        $this->assertSame(
            ['zona', 'nome'],
            CamposPdfSelecionados::resolver(
                ['zona', 'injetado', 'nome', 'zona', 10, null],
                self::PERMITIDOS,
                self::PADRAO,
            ),
        );
    }

    #[Test]
    public function usa_padrao_para_entrada_nao_array_ou_sem_campos_validos(): void
    {
        $this->assertSame(self::PADRAO, CamposPdfSelecionados::resolver('nome', self::PERMITIDOS, self::PADRAO));
        $this->assertSame(self::PADRAO, CamposPdfSelecionados::resolver(['injetado', 10], self::PERMITIDOS, self::PADRAO));
        $this->assertSame(self::PADRAO, CamposPdfSelecionados::resolver(null, self::PERMITIDOS, self::PADRAO));
    }

    #[Test]
    public function tambem_aceita_lista_de_chaves_permitidas(): void
    {
        $this->assertSame(
            ['status', 'nome'],
            CamposPdfSelecionados::resolver(['status', 'nome'], ['nome', 'status'], ['nome']),
        );
    }
}
```
</TESTS_UNIT_CAMPOSPDFSELECIONADOSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CargosEquipeControllerTest.php`
## <TESTS_UNIT_CARGOSEQUIPECONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CargosEquipeControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CargosEquipeControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_gerenciar_retorna_view_com_cargos(): void
public function test_form_retorna_view_com_cargo_quando_id_for_informado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\CargoEquipeController;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class CargosEquipeControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_gerenciar_retorna_view_com_cargos(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'nome' => 'Motorista']],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/cargos-equipe']
        );

        $repository = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $repository->shouldReceive('listar')
            ->once()
            ->with(null, null)
            ->andReturn($paginator);

        $controller = new CargoEquipeController($repository);
        $response = $controller->gerenciar();

        $this->assertSame('tabelas-auxiliares.cargos-equipe.index', $response->name());
        $this->assertCount(1, $response->getData()['cargos']);
    }

    public function test_form_retorna_view_com_cargo_quando_id_for_informado(): void
    {
        $cargo = (object) ['id' => 7, 'nome' => 'Motorista', 'descricao' => 'Conduz a equipe', 'ativo' => 'S'];
        $repository = Mockery::mock(CargoEquipeRepositoryInterface::class);
        $repository->shouldReceive('buscar')->once()->with(7)->andReturn($cargo);

        $controller = Mockery::mock(CargoEquipeController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(7);

        $this->assertSame('tabelas-auxiliares.cargos-equipe.form', $response->name());
        $this->assertSame($cargo, $response->getData()['cargo']);
    }
}
```
</TESTS_UNIT_CARGOSEQUIPECONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CargosEquipeUiTest.php`
## <TESTS_UNIT_CARGOSEQUIPEUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CargosEquipeUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CargosEquipeUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function index_de_cargos_equipe_fica_em_tabelas_auxiliares_com_tabela_direta(): void
public function formulario_de_cargos_equipe_usa_padrao_de_tabelas_auxiliares(): void
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

class CargosEquipeUiTest extends TestCase
{
    #[Test]
    public function index_de_cargos_equipe_fica_em_tabelas_auxiliares_com_tabela_direta(): void
    {
        $conteudo = file_get_contents(resource_path('views/tabelas-auxiliares/cargos-equipe/index.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Cargos da Equipe', $conteudo);
        $this->assertStringContainsString("route('tabelas-auxiliares.cargos-equipe.form')", $conteudo);
        $this->assertStringContainsString('<th style="width: 10%">ID</th>', $conteudo);
        $this->assertStringContainsString('<th>Nome</th>', $conteudo);
        $this->assertStringContainsString('<th>Descrição</th>', $conteudo);
        $this->assertStringContainsString('<th style="width: 15%">Status</th>', $conteudo);
        $this->assertStringContainsString('<th style="width: 15%" class="text-center">Ações</th>', $conteudo);
        $this->assertStringNotContainsString("window.rotas = {", $conteudo);
    }

    #[Test]
    public function formulario_de_cargos_equipe_usa_padrao_de_tabelas_auxiliares(): void
    {
        $conteudo = file_get_contents(resource_path('views/tabelas-auxiliares/cargos-equipe/form.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('name="nome"', $conteudo);
        $this->assertStringContainsString('name="descricao"', $conteudo);
        $this->assertStringContainsString('name="ativo"', $conteudo);
        $this->assertStringContainsString("route('tabelas-auxiliares.cargos-equipe.index')", $conteudo);
        $this->assertStringContainsString("route('tabelas-auxiliares.cargos-equipe.store')", $conteudo);
        $this->assertStringContainsString("route('tabelas-auxiliares.cargos-equipe.update', \$cargo->id)", $conteudo);
        $this->assertStringNotContainsString('formCargoEquipe', $conteudo);
    }
}
```
</TESTS_UNIT_CARGOSEQUIPEUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CelulaPlanilhaSeguraTest.php`
## <TESTS_UNIT_CELULAPLANILHASEGURATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CelulaPlanilhaSeguraTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CelulaPlanilhaSeguraTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_neutraliza_prefixos_interpretados_como_formula(): void
public function test_preserva_texto_comum_e_espacos_iniciais(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Exportacao\CelulaPlanilhaSegura;
use PHPUnit\Framework\TestCase;

class CelulaPlanilhaSeguraTest extends TestCase
{
    public function test_neutraliza_prefixos_interpretados_como_formula(): void
    {
        foreach (['=SOMA(A1:A2)', '+1+1', '-2+3', '@IMPORTXML(A1)'] as $valor) {
            $this->assertSame("'".$valor, CelulaPlanilhaSegura::texto($valor));
        }
    }

    public function test_preserva_texto_comum_e_espacos_iniciais(): void
    {
        $this->assertSame('Atendimento eleitoral', CelulaPlanilhaSegura::texto('Atendimento eleitoral'));
        $this->assertSame(" '=ainda texto", CelulaPlanilhaSegura::texto(" '=ainda texto"));
    }
}
```
</TESTS_UNIT_CELULAPLANILHASEGURATEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CodigoDescricaoOrdemAtivoRequestTest.php`
## <TESTS_UNIT_CODIGODESCRICAOORDEMATIVOREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CodigoDescricaoOrdemAtivoRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CodigoDescricaoOrdemAtivoRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function requests_auxiliares_normalizam_campos_comuns_e_rejeitam_codigo_invalido(string $requestClass): void
public static function requestsAuxiliares(): array
private function request(string $requestClass, array $payload): FormRequest
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\TabelasAuxiliares\EsferaRequest;
use App\Http\Requests\DisqueEleicao\DisqueEleicaoAssuntoRequest;
use App\Http\Requests\TabelasAuxiliares\OpcaoBinariaRequest;
use App\Http\Requests\TabelasAuxiliares\OperadoraRequest;
use App\Http\Requests\TabelasAuxiliares\QualidadeRequest;
use App\Http\Requests\TabelasAuxiliares\TipoSinalRequest;
use App\Http\Requests\TabelasAuxiliares\TipoTomadaRequest;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Unique;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CodigoDescricaoOrdemAtivoRequestTest extends TestCase
{
    #[Test]
    #[DataProvider('requestsAuxiliares')]
    public function requests_auxiliares_normalizam_campos_comuns_e_rejeitam_codigo_invalido(string $requestClass): void
    {
        $request = $this->request($requestClass, [
            'codigo' => ' codigo-invalido ',
            'descricao' => ' Descrição ',
            'ordem' => '7',
            'ativo' => '1',
        ]);
        $regrasCodigo = array_values(array_filter(
            $request->rules()['codigo'],
            static fn (mixed $regra): bool => ! $regra instanceof Unique,
        ));
        $validator = Validator::make($request->only('codigo'), ['codigo' => $regrasCodigo], $request->messages());

        $this->assertTrue($validator->errors()->has('codigo'));
        $this->assertSame('CODIGO-INVALIDO', $request->input('codigo'));
        $this->assertSame('Descrição', $request->input('descricao'));
        $this->assertSame(7, $request->input('ordem'));
        $this->assertTrue($request->input('ativo'));
    }

    /** @return array<string, array{class-string<FormRequest>}> */
    public static function requestsAuxiliares(): array
    {
        return [
            'qualidade' => [QualidadeRequest::class],
            'tipo de tomada' => [TipoTomadaRequest::class],
            'esfera' => [EsferaRequest::class],
            'operadora' => [OperadoraRequest::class],
            'tipo de sinal' => [TipoSinalRequest::class],
            'opcao binaria' => [OpcaoBinariaRequest::class],
            'assunto do disque eleicao' => [DisqueEleicaoAssuntoRequest::class],
        ];
    }

    /**
     * @param class-string<FormRequest> $requestClass
     * @param array<string, mixed> $payload
     */
    private function request(string $requestClass, array $payload): FormRequest
    {
        session(['is_admin' => true]);
        $request = $requestClass::create('/tabelas-auxiliares', 'POST', $payload);
        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->invoke($request);

        return $request;
    }
}
```
</TESTS_UNIT_CODIGODESCRICAOORDEMATIVOREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConfigureUserSessionTest.php`
## <TESTS_UNIT_CONFIGUREUSERSESSIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConfigureUserSessionTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConfigureUserSessionTest extends TestCase`

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
public function test_handle_monta_contexto_base_para_usuario_nao_admin(): void
public function test_handle_monta_contexto_admin_global(): void
public function test_handle_permite_diarias_sem_macroprojeto_disponivel_quando_usuario_e_valido(): void
public function test_handle_enriquece_sessao_diarias_usuario_com_api_por_email_autenticado(): void
public function test_handle_nao_enriquece_sessao_diarias_quando_modulo_desativado(): void
public function test_handle_mantem_consulta_disponivel_sem_contexto_quando_api_pessoa_falha(): void
public function test_handle_retorna_403_quando_usuario_nao_tem_grupos_validos(): void
public function test_handle_permita_rota_bypass_sem_usuario(): void
public function test_handle_permite_monitoramento_geral_publico_sem_usuario(): void
public function test_handle_rota_publica_por_prefixo_nao_consulta_usuario_ou_acl(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Middleware\ConfigureUserSession;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Mockery;
use Symfony\Component\HttpFoundation\Response;
use Tests\TestCase;

class ConfigureUserSessionTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        config(['planeleito.diarias.enabled' => false]);
        config(['planeleito.diarias.pessoa_api_url' => null]);
        config(['planeleito.diarias.pessoa_api_token' => null]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_handle_monta_contexto_base_para_usuario_nao_admin(): void
    {
        $this->mockBootstrapGroups(
            gruposUnidade: ['1ZONA', '2ZONA'],
            gruposAcesso: ['GRUPO_TESTE']
        );

        $this->mockAclAdminCount(0);
        $this->mockRotasPermitidas(['cadastro-eleitoral.agendamentos.index', 'planejamento.projetos.listar']);
        $this->mockRotasIgnoraUnidades([]);
        $this->mockExpansaoEscopoPorAtividade(true);
        $this->mockMapeamentoUnidades([
            (object) ['id_unidade' => 10, 'sigla' => '1ZONA'],
            (object) ['id_unidade' => 20, 'sigla' => 'GRUPO_TESTE'],
        ]);
        $this->mockMapeamentoZonas([
            (object) ['sigla' => '1ZONA', 'cod_objeto_zona' => '1'],
            (object) ['sigla' => 'GRUPO_TESTE', 'cod_objeto_zona' => '9'],
        ]);
        $this->mockMacroprojetos([
            (object) ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
        ]);

        $request = $this->criarRequest(
            rota: 'cadastro-eleitoral.agendamentos.index',
            username: 'teste_usuario',
            groups: '1ZONA,GRUPO_TESTE',
            name: 'Usuário Teste',
            email: 'teste@example.com'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertSame('teste_usuario', session('user.username'));
        $this->assertSame(['1ZONA', 'GRUPO_TESTE'], session('matchingGroups'));
        $this->assertFalse(session('is_admin'));
        $this->assertSame(
            ['CADASTRO-ELEITORAL.AGENDAMENTOS.INDEX', 'PLANEJAMENTO.PROJETOS.LISTAR'],
            session('rotas_permitidas')
        );
        $this->assertSame([], session('rotas_ignora_unidades'));
        $this->assertTrue(session('expande_escopo_por_atividade'));
        $this->assertTrue(session('aplica_escopo_unidade'));
        $this->assertSame([10, 20], session('unidades_permitidas_ids'));
        $this->assertSame([1, 9], session('cod_zonas_permitidas'));
        $this->assertFalse(session('acesso_todas_zonas'));
        $this->assertSame([['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA']], session('macroprojetos_disponiveis'));
        $this->assertSame(7, session('macroprojeto_ativo_id'));
        $this->assertSame('Macro A', session('macroprojeto_ativo_nome'));
    }

    public function test_handle_monta_contexto_admin_global(): void
    {
        $this->mockBootstrapGroups(
            gruposUnidade: ['PLANELEITO_ADMIN'],
            gruposAcesso: ['PLANELEITO_ADMIN']
        );

        $this->mockAclAdminCount(1);
        $this->mockRotasPermitidas(['*']);
        $this->mockRotasIgnoraUnidades(['*']);
        $this->mockExpansaoEscopoPorAtividade(false);
        $this->mockMapeamentoZonas([
            (object) ['sigla' => 'PLANELEITO_ADMIN', 'cod_objeto_zona' => '0'],
        ]);
        $this->mockMacroprojetos([
            (object) ['id' => 9, 'nome' => 'Macro Global', 'grupo_admin' => 'ADMIN'],
        ]);

        $request = $this->criarRequest(
            rota: 'planejamento.projetos.listar',
            username: 'admin_user',
            groups: 'PLANELEITO_ADMIN'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertTrue(session('is_admin'));
        $this->assertSame(['PLANELEITO_ADMIN'], session('matchingGroups'));
        $this->assertSame(['*'], session('rotas_permitidas'));
        $this->assertSame(['*'], session('rotas_ignora_unidades'));
        $this->assertFalse(session('aplica_escopo_unidade'));
        $this->assertSame([], session('unidades_permitidas_ids'));
        $this->assertSame([0], session('cod_zonas_permitidas'));
        $this->assertTrue(session('acesso_todas_zonas'));
        $this->assertSame(9, session('macroprojeto_ativo_id'));
    }

    public function test_handle_permite_diarias_sem_macroprojeto_disponivel_quando_usuario_e_valido(): void
    {
        config([
            'planeleito.diarias.enabled' => true,
            'planeleito.auth.macro_context_bypass_route_patterns' => ['diarias.*'],
        ]);

        $this->mockBootstrapGroups(
            gruposUnidade: ['PLANELEITO_ADMIN'],
            gruposAcesso: ['PLANELEITO_ADMIN']
        );

        $this->mockAclAdminCount(1);
        $this->mockRotasPermitidas(['*']);
        $this->mockRotasIgnoraUnidades(['*']);
        $this->mockExpansaoEscopoPorAtividade(false);
        $this->mockMapeamentoZonas([
            (object) ['sigla' => 'PLANELEITO_ADMIN', 'cod_objeto_zona' => '0'],
        ]);
        $this->mockMacroprojetos([]);

        $request = $this->criarRequest(
            rota: 'diarias.solicitacoes.index',
            username: 'admin_user',
            groups: 'PLANELEITO_ADMIN'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertTrue(session('is_admin'));
        $this->assertSame([], session('macroprojetos_disponiveis'));
        $this->assertNull(session('macroprojeto_ativo_id'));
        $this->assertNull(session('macroprojeto_ativo_nome'));
    }

    public function test_handle_enriquece_sessao_diarias_usuario_com_api_por_email_autenticado(): void
    {
        config([
            'planeleito.diarias.enabled' => true,
            'planeleito.auth.macro_context_bypass_route_patterns' => ['diarias.*'],
            'planeleito.diarias.pessoa_api_url' => 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php',
            'planeleito.diarias.pessoa_api_token' => 'token-de-teste',
        ]);

        Http::fake([
            'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php*' => Http::response([
                [
                    'cpf' => '111.222.333-44',
                    'nome' => 'PESSOA RETORNADA POR APROXIMAÇÃO',
                    'email' => 'outro-edcley@tre-ac.jus.br',
                    'lotacao' => '157',
                    'lotacao_sigla' => 'DG',
                    'lotacao_agrupadora' => '157',
                    'lotacao_agrupadora_sigla' => 'DG',
                ],
                [
                    'cpf' => '434.161.602-15',
                    'matricula' => '309-1570',
                    'nome' => 'EDCLEY DA SILVA FIRMINO',
                    'email' => 'EDCLEY@TRE-AC.JUS.BR',
                    'lotacao' => '264',
                    'lotacao_sigla' => 'STI',
                    'lotacao_descricao' => 'SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO',
                    'lotacao_agrupadora' => '155',
                    'lotacao_agrupadora_sigla' => 'STI',
                    'lotacao_agrupadora_descricao' => 'SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO',
                    'cargo_codigo' => '16',
                    'cargo' => 'TÉCNICO JUDICIÁRIO',
                    'funcao_codigo' => 'CJ-3',
                    'funcao' => 'SECRETÁRIO',
                    'titulo' => '002266412453',
                    'telefone_celular' => '(68)9212-7980',
                    'ramal' => '4424',
                    'banco' => '104',
                    'agencia' => '3950',
                    'conta' => '998214578-4',
                    'tipo_conta' => 'CORRENTE',
                    'pix' => null,
                    'tipo_vinculo' => 'SERVIDOR',
                    'ativo' => true,
                    'perfis' => ['DEFERIDOR', 'FINANCEIRO'],
                ],
            ]),
        ]);

        $this->mockBootstrapGroups(
            gruposUnidade: ['PLANELEITO_ADMIN'],
            gruposAcesso: ['PLANELEITO_ADMIN']
        );

        $this->mockAclAdminCount(1);
        $this->mockRotasPermitidas(['*']);
        $this->mockRotasIgnoraUnidades(['*']);
        $this->mockExpansaoEscopoPorAtividade(false);
        $this->mockMapeamentoZonas([
            (object) ['sigla' => 'PLANELEITO_ADMIN', 'cod_objeto_zona' => '0'],
        ]);
        $this->mockMacroprojetos([]);

        $request = $this->criarRequest(
            rota: 'diarias.solicitacoes.index',
            username: 'edcley',
            groups: 'PLANELEITO_ADMIN',
            name: 'Edcley da Silva Firmino',
            email: 'edcley@tre-ac.jus.br'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertSame('edcley', session('user.username'));
        $this->assertSame(['PLANELEITO_ADMIN'], session('matchingGroups'));
        $this->assertSame('43416160215', session('diarias_usuario.cpf'));
        $this->assertSame('309-1570', session('diarias_usuario.matricula'));
        $this->assertSame('STI', session('diarias_usuario.lotacao'));
        $this->assertSame('264', session('diarias_usuario.lotacao_id'));
        $this->assertSame('SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO', session('diarias_usuario.lotacao_descricao'));
        $this->assertSame('155', session('diarias_usuario.lotacao_agrupadora_id'));
        $this->assertSame('STI', session('diarias_usuario.lotacao_agrupadora_sigla'));
        $this->assertSame('SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO', session('diarias_usuario.lotacao_agrupadora_descricao'));
        $this->assertSame('16', session('diarias_usuario.cargo_codigo'));
        $this->assertSame('TÉCNICO JUDICIÁRIO', session('diarias_usuario.cargo'));
        $this->assertSame('CJ-3', session('diarias_usuario.funcao_codigo'));
        $this->assertSame('SECRETÁRIO', session('diarias_usuario.funcao'));
        $this->assertSame('002266412453', session('diarias_usuario.titulo_eleitoral'));
        $this->assertSame('(68)9212-7980', session('diarias_usuario.telefone_celular'));
        $this->assertSame('4424', session('diarias_usuario.ramal'));
        $this->assertSame('104', session('diarias_usuario.banco'));
        $this->assertSame('3950', session('diarias_usuario.agencia'));
        $this->assertSame('998214578-4', session('diarias_usuario.conta'));
        $this->assertSame('CORRENTE', session('diarias_usuario.tipo_conta'));
        $this->assertNull(session('diarias_usuario.pix'));
        $this->assertSame('SERVIDOR', session('diarias_usuario.tipo_vinculo'));
        $this->assertTrue(session('diarias_usuario.ativo'));
        $this->assertSame(['DEFERIDOR', 'FINANCEIRO'], session('diarias_usuario.perfis'));

        Http::assertSent(static fn ($request): bool => $request->url() === 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php?email=edcley%40tre-ac.jus.br'
            && $request->hasHeader('Authorization', 'Bearer token-de-teste'));
    }

    public function test_handle_nao_enriquece_sessao_diarias_quando_modulo_desativado(): void
    {
        config([
            'planeleito.diarias.enabled' => false,
            'planeleito.auth.macro_context_bypass_route_patterns' => ['diarias.*'],
            'planeleito.diarias.pessoa_api_url' => 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php',
            'planeleito.diarias.pessoa_api_token' => 'token-de-teste',
        ]);

        Http::fake();

        $this->mockBootstrapGroups(
            gruposUnidade: ['PLANELEITO_ADMIN'],
            gruposAcesso: ['PLANELEITO_ADMIN']
        );

        $this->mockAclAdminCount(1);
        $this->mockRotasPermitidas(['*']);
        $this->mockRotasIgnoraUnidades(['*']);
        $this->mockExpansaoEscopoPorAtividade(false);
        $this->mockMapeamentoZonas([
            (object) ['sigla' => 'PLANELEITO_ADMIN', 'cod_objeto_zona' => '0'],
        ]);
        $this->mockMacroprojetos([]);

        $request = $this->criarRequest(
            rota: 'diarias.solicitacoes.index',
            username: 'edcley',
            groups: 'PLANELEITO_ADMIN',
            name: 'Edcley da Silva Firmino',
            email: 'edcley@tre-ac.jus.br'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertFalse(session()->has('diarias_usuario'));
        Http::assertNothingSent();
    }

    public function test_handle_mantem_consulta_disponivel_sem_contexto_quando_api_pessoa_falha(): void
    {
        config([
            'planeleito.diarias.enabled' => true,
            'planeleito.auth.macro_context_bypass_route_patterns' => ['diarias.*'],
            'planeleito.diarias.pessoa_api_url' => 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php',
            'planeleito.diarias.pessoa_api_token' => 'token-de-teste',
        ]);

        Http::fake([
            'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php*' => Http::response([], 503),
        ]);

        $this->mockBootstrapGroups(
            gruposUnidade: ['PLANELEITO_DIARIAS_SOLICITANTE'],
            gruposAcesso: ['PLANELEITO_DIARIAS_SOLICITANTE']
        );
        $this->mockAclAdminCount(0);
        $this->mockRotasPermitidas(['diarias.consulta-solicitacoes.index']);
        $this->mockRotasIgnoraUnidades(['diarias.consulta-solicitacoes.index']);
        $this->mockExpansaoEscopoPorAtividade(false);
        $this->mockMapeamentoUnidades([]);
        $this->mockMapeamentoZonas([]);
        $this->mockMacroprojetos([
            (object) ['id' => 1, 'nome' => 'Diárias'],
        ]);

        session(['diarias_usuario' => ['lotacao_id' => 'antiga']]);

        $request = $this->criarRequest(
            rota: 'diarias.consulta-solicitacoes.index',
            username: 'solicitante',
            groups: 'PLANELEITO_DIARIAS_SOLICITANTE',
            email: 'solicitante@tre-ac.jus.br'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertFalse(session()->has('diarias_usuario'));
    }

    public function test_handle_retorna_403_quando_usuario_nao_tem_grupos_validos(): void
    {
        $this->mockBootstrapGroups(
            gruposUnidade: ['1ZONA'],
            gruposAcesso: ['GRUPO_VALIDO']
        );

        $request = $this->criarRequest(
            rota: 'planejamento.projetos.listar',
            username: 'sem_grupo',
            groups: 'GRUPO_INVALIDO'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertInstanceOf(Response::class, $response);
        $this->assertSame(403, $response->getStatusCode());
        $this->assertSame('Sessão expirada ou acesso não autorizado.', $response->getContent());
    }

    public function test_handle_permita_rota_bypass_sem_usuario(): void
    {
        $request = $this->criarRequest(
            rota: 'home',
            username: '',
            groups: ''
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
    }

    public function test_handle_permite_monitoramento_geral_publico_sem_usuario(): void
    {
        $request = $this->criarRequest(
            rota: 'tarefas.monitoramento.geral.publico',
            username: '',
            groups: ''
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
    }

    public function test_handle_rota_publica_por_prefixo_nao_consulta_usuario_ou_acl(): void
    {
        $request = $this->criarRequest(
            rota: 'calendario-eleitoral.publico.index',
            username: 'usuario-remoto',
            groups: 'PLANELEITO_ADMIN',
            path: '/rotas-publicas/calendario-eleitoral'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertFalse(session()->has('user'));
    }

    public function test_handle_bloqueia_monitoramento_geral_sem_usuario(): void
    {
        $request = $this->criarRequest(
            rota: 'tarefas.monitoramento.geral',
            username: '',
            groups: ''
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertInstanceOf(Response::class, $response);
        $this->assertSame(403, $response->getStatusCode());
        $this->assertSame('Sessão expirada ou acesso não autorizado.', $response->getContent());
    }

    public function test_handle_bloqueia_tarefas_subprojetos_sem_usuario(): void
    {
        $request = $this->criarRequest(
            rota: 'tarefas.subprojetos',
            username: '',
            groups: ''
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertInstanceOf(Response::class, $response);
        $this->assertSame(403, $response->getStatusCode());
        $this->assertSame('Sessão expirada ou acesso não autorizado.', $response->getContent());
    }

    public function test_handle_em_ambiente_local_usa_headers_do_authelia(): void
    {
        $this->app['env'] = 'local';
        config([
            'planeleito.auth.local_user' => 'usuario_env',
            'planeleito.auth.local_groups' => 'GRUPO_ENV',
        ]);

        $this->mockBootstrapGroups(
            gruposUnidade: ['1ZONA'],
            gruposAcesso: ['GRUPO_TESTE']
        );

        $this->mockAclAdminCount(0);
        $this->mockRotasPermitidas(['planejamento.projetos.listar']);
        $this->mockRotasIgnoraUnidades([]);
        $this->mockExpansaoEscopoPorAtividade(false);
        $this->mockMapeamentoUnidades([
            (object) ['id_unidade' => 10, 'sigla' => '1ZONA'],
        ]);
        $this->mockMapeamentoZonas([
            (object) ['sigla' => '1ZONA', 'cod_objeto_zona' => '1'],
        ]);
        $this->mockMacroprojetos([
            (object) ['id' => 7, 'nome' => 'Macro A', 'grupo_admin' => 'GA'],
        ]);

        $request = $this->criarRequest(
            rota: 'planejamento.projetos.listar',
            username: 'usuario_authelia',
            groups: '1ZONA,GRUPO_TESTE',
            name: 'Usuario Authelia',
            email: 'authelia@example.test'
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertSame('ok', $response->getContent());
        $this->assertSame('usuario_authelia', session('user.username'));
        $this->assertSame(['1ZONA', 'GRUPO_TESTE'], session('matchingGroups'));
        $this->assertSame(7, session('macroprojeto_ativo_id'));
    }

    public function test_handle_em_ambiente_local_nao_usa_fallback_de_usuario_env(): void
    {
        $this->app['env'] = 'local';
        config([
            'planeleito.auth.local_user' => 'usuario_env',
            'planeleito.auth.local_groups' => 'GRUPO_TESTE',
        ]);

        $request = $this->criarRequest(
            rota: 'planejamento.projetos.listar',
            username: '',
            groups: ''
        );

        $middleware = new ConfigureUserSession;
        $response = $middleware->handle($request, static fn () => response('ok'));

        $this->assertInstanceOf(Response::class, $response);
        $this->assertSame(403, $response->getStatusCode());
        $this->assertSame('Sessão expirada ou acesso não autorizado.', $response->getContent());
    }

    private function criarRequest(
        string $rota,
        string $username,
        string $groups,
        string $name = '',
        string $email = '',
        string $path = '/teste'
    ): Request {
        $request = Request::create($path, 'GET', [], [], [], [
            'HTTP_REMOTE_USER' => $username,
            'HTTP_REMOTE_GROUPS' => $groups,
            'HTTP_REMOTE_NAME' => $name,
            'HTTP_REMOTE_EMAIL' => $email,
        ]);
        $request->setLaravelSession($this->app['session.store']);

        $request->setRouteResolver(static fn () => new class($rota)
        {
            public function __construct(private readonly string $rota) {}

            public function getName(): string
            {
                return $this->rota;
            }
        });

        $this->app->instance('request', $request);

        return $request;
    }

    private function mockBootstrapGroups(array $gruposUnidade, array $gruposAcesso): void
    {
        $builderUnidades = Mockery::mock();
        $builderUnidades->shouldReceive('select')->once()->with('SIGLA')->andReturnSelf();
        $builderUnidades->shouldReceive('pluck')->once()->with('sigla')->andReturn(collect($gruposUnidade));

        $builderAcesso = Mockery::mock();
        $builderAcesso->shouldReceive('where')->once()->with('ativo', 1)->andReturnSelf();
        $builderAcesso->shouldReceive('select')->once()->with('nome')->andReturnSelf();
        $builderAcesso->shouldReceive('pluck')->once()->with('nome')->andReturn(collect($gruposAcesso));

        DB::shouldReceive('table')->once()->with('VW_UNIDADE')->andReturn($builderUnidades);
        DB::shouldReceive('table')->once()->with('adm_grupo_acesso')->andReturn($builderAcesso);
    }

    private function mockAclAdminCount(int $count): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('join')->times(2)->andReturnSelf();
        $builder->shouldReceive('where')->times(4)->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->andReturnSelf();
        $builder->shouldReceive('count')->once()->andReturn($count);

        DB::shouldReceive('table')->once()->with('adm_acesso_rota_grupo as arg')->andReturn($builder);
    }

    private function mockRotasPermitidas(array $rotas): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('join')->times(2)->andReturnSelf();
        $builder->shouldReceive('where')->times(3)->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->andReturnSelf();
        $builder->shouldReceive('pluck')->once()->with('ar.rota_nome')->andReturn(collect($rotas));

        DB::shouldReceive('table')->once()->with('adm_acesso_rota_grupo as arg')->andReturn($builder);
    }

    private function mockRotasIgnoraUnidades(array $rotas): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('join')->times(2)->andReturnSelf();
        $builder->shouldReceive('where')->times(3)->andReturnSelf();
        $builder->shouldReceive('whereRaw')
            ->once()
            ->with('NVL(arg.ignora_unidades_permitidas, ga.ignora_unidades_permitidas) = 1')
            ->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->andReturnSelf();
        $builder->shouldReceive('pluck')->once()->with('ar.rota_nome')->andReturn(collect($rotas));

        DB::shouldReceive('table')->once()->with('adm_acesso_rota_grupo as arg')->andReturn($builder);
    }

    private function mockExpansaoEscopoPorAtividade(bool $ativo): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('where')->times(2)->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->andReturnSelf();
        $builder->shouldReceive('count')->once()->andReturn($ativo ? 1 : 0);

        DB::shouldReceive('table')->once()->with('adm_grupo_acesso as ga')->andReturn($builder);
    }

    /**
     * @param  array<int, object>  $rows
     */
    private function mockMapeamentoUnidades(array $rows): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('select')->once()->with(['ID_UNIDADE', 'SIGLA'])->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->andReturnSelf();
        $builder->shouldReceive('get')->once()->andReturn(new Collection($rows));

        DB::shouldReceive('table')->once()->with('VW_UNIDADE')->andReturn($builder);
    }

    /**
     * @param  array<int, object>  $rows
     */
    private function mockMapeamentoZonas(array $rows): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('select')->once()->with(['SIGLA', 'COD_OBJETO_ZONA'])->andReturnSelf();
        $builder->shouldReceive('whereIn')->once()->andReturnSelf();
        $builder->shouldReceive('get')->once()->andReturn(new Collection($rows));

        DB::shouldReceive('table')->once()->with('VW_UNIDADE')->andReturn($builder);
    }

    /**
     * @param  array<int, object>  $rows
     */
    private function mockMacroprojetos(array $rows): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('select')->once()->with('ID', 'NOME', 'GRUPO_ADMIN')->andReturnSelf();
        $builder->shouldReceive('where')->once()->with('ATIVO', 'S')->andReturnSelf();
        $builder->shouldReceive('orderBy')->once()->with('NOME')->andReturnSelf();
        $builder->shouldReceive('where')->once()->withArgs(function ($closure) {
            $sub = Mockery::mock();
            $sub->shouldReceive('whereExists')->andReturnSelf();
            $sub->shouldReceive('orWhereExists')->andReturnSelf();
            $closure($sub);

            return true;
        })->andReturnSelf();
        $builder->shouldReceive('get')->once()->andReturn(new Collection($rows));

        DB::shouldReceive('table')->once()->with('MACROPROJETO')->andReturn($builder);
    }
}
```
</TESTS_UNIT_CONFIGUREUSERSESSIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConsolidacaoControllerTest.php`
## <TESTS_UNIT_CONSOLIDACAOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConsolidacaoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConsolidacaoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_locais_transmissao_repassa_escopo_zonal_aos_repositorios(): void
public function test_locais_transmissao_nao_desvia_para_mapa_por_query_string(): void
public function test_mapa_locais_votacao_repassa_filtros_e_escopo_ao_repositorio(): void
public function test_mapa_locais_votacao_aceita_filtro_direcionado_por_codigo_do_local(): void
public function test_mapa_locais_votacao_expoe_locais_sem_coordenadas_para_o_modal(): void
public function test_autogeracao_transmissao_repassa_escopo_zonal_ao_repositorio(): void
public function test_busca_rotas_repassa_escopo_zonal_ao_repositorio(): void
public function test_vincular_rota_repassa_escopo_zonal_ao_repositorio(): void
public function test_vincular_local_transmissao_rejeita_local_votacao_fora_do_escopo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\ConsolidacaoController;
use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\Lda\RotaRepository;
use App\Services\Lda\RotaTransmissaoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mockery;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Tests\TestCase;

class ConsolidacaoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_locais_transmissao_repassa_escopo_zonal_aos_repositorios(): void
    {
        session([
            'cod_zonas_permitidas' => [4, 9],
            'acesso_todas_zonas' => false,
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('listarNomesLocaisOficiais')->zeroOrMoreTimes()->andReturn(collect());
        $localVotacao->shouldReceive('locaisSemTransmissaoTotalPorMunicipioComRotas')
            ->once()
            ->with([4, 9], false)
            ->andReturn([]);
        $localVotacao->shouldReceive('locaisSemRotaTotalPorMunicipioComRotas')
            ->once()
            ->with([4, 9], false)
            ->andReturn([]);

        $controller = new ConsolidacaoController(
            $localVotacao,
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(RotaRepository::class)
        );

        $response = $controller->locaisTransmissao(new Request());

        $this->assertSame('lda.consolidacao.locais-transmissao', $response->name());
    }

    public function test_locais_transmissao_nao_desvia_para_mapa_por_query_string(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('listarNomesLocaisOficiais')->zeroOrMoreTimes()->andReturn(collect());
        $localVotacao->shouldReceive('locaisSemTransmissaoTotalPorMunicipioComRotas')
            ->once()
            ->with([4], false)
            ->andReturn([]);
        $localVotacao->shouldReceive('locaisSemRotaTotalPorMunicipioComRotas')
            ->once()
            ->with([4], false)
            ->andReturn([]);
        $controller = new ConsolidacaoController(
            $localVotacao,
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(RotaRepository::class)
        );
        $response = $controller->locaisTransmissao(new Request([
            'visualizacao' => 'mapa',
        ]));
        $this->assertSame('lda.consolidacao.locais-transmissao', $response->name());
    }

    public function test_mapa_locais_votacao_repassa_filtros_e_escopo_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 77,
        ]);

        $zonas = collect([
            (object) ['cod_objeto_zona' => '4'],
        ]);
        $municipios = collect([
            (object) ['cod_objeto_localidade' => '16', 'nom_localidade' => 'RIO BRANCO'],
        ]);
        $bairros = collect([
            (object) ['cod_objeto_bairro' => '100', 'nom_bairro' => 'CENTRO'],
            (object) ['cod_objeto_bairro' => '101', 'nom_bairro' => 'AEROPORTO'],
        ]);
        $locais = collect([
            (object) [
                'cod_objeto' => 'LV-1',
                'cod_objeto_zona' => '4',
                'cod_objeto_localidade' => '16',
                'nom_localidade' => 'RIO BRANCO',
                'cod_objeto_bairro' => '100',
                'nom_bairro' => 'CENTRO',
                'nom_local' => 'ESCOLA TESTE',
                'des_endereco' => 'RUA 1',
                'secoes' => '001, 002',
                'num_latitude' => null,
                'num_longitude' => null,
                'lda_latitude' => '-9.97499',
                'lda_longitude' => '-67.82430',
                'possui_lda' => 1,
            ],
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('listarNomesLocaisOficiais')->zeroOrMoreTimes()->andReturn(collect());
        $localVotacao->shouldReceive('listarZonas')
            ->once()
            ->with([4], false)
            ->andReturn($zonas);
        $localVotacao->shouldReceive('listarMunicipios')
            ->once()
            ->with('4', [4], false)
            ->andReturn($municipios);
        $localVotacao->shouldReceive('listarBairros')
            ->once()
            ->with('16', [4], false)
            ->andReturn($bairros);
        $localVotacao->shouldReceive('listarTodos')
            ->once()
            ->with('4', '16', ['100', '101'], ['ESCOLA'], 'RUA', '12', false, false, 'mesarios_convocados', 'maior', 5, [4], false, true, 'mais_1h', 77, null, false, 'SABADO', true, 'urbana')
            ->andReturn($locais);

        $controller = new ConsolidacaoController(
            $localVotacao,
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(RotaRepository::class)
        );

        $response = $controller->mapaLocaisVotacao(new Request([
            'zona' => '4',
            'municipio' => '16',
            'bairro' => ['100', '101', '100', 'fora'],
            'nome_local' => 'ESCOLA',
            'endereco' => 'RUA',
            'secao' => '12',
            'excluir_lda' => '1',
            'sem_secao' => '1',
            'tempo_deslocamento' => 'mais_1h',
            'dia_instalacao_urnas' => 'SABADO',
            'somente_secoes_parametro' => '1',
            'eleitores_escopo' => 'mesarios_convocados',
            'eleitores_operador' => 'maior',
            'eleitores_valor' => '5',
            'area_local' => 'urbana',
        ]));

        $this->assertSame('lda.consolidacao.mapa-locais-votacao', $response->name());
        $this->assertSame('mapa', $response->getData()['visualizacaoAtiva']);
        $this->assertSame(['100', '101'], $response->getData()['filtros']['bairro']);
        $this->assertSame(['ESCOLA'], $response->getData()['filtros']['nome_local']);
        $this->assertSame('1', $response->getData()['filtros']['sem_secao']);
        $this->assertSame('1', $response->getData()['filtros']['excluir_lda']);
        $this->assertSame('mais_1h', $response->getData()['filtros']['tempo_deslocamento']);
        $this->assertSame('SABADO', $response->getData()['filtros']['dia_instalacao_urnas']);
        $this->assertSame('urbana', $response->getData()['filtros']['area_local']);
        $this->assertCount(1, $response->getData()['locaisMapa']);
        $this->assertSame('LV-1', $response->getData()['locaisMapa'][0]['codigo']);
        $this->assertSame(-9.97499, $response->getData()['locaisMapa'][0]['latitude']);
        $this->assertSame(-67.8243, $response->getData()['locaisMapa'][0]['longitude']);
        $this->assertSame(0, $response->getData()['resumoMapa']['sem_coordenadas']);
    }



    public function test_mapa_locais_votacao_aceita_filtro_direcionado_por_codigo_do_local(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $locais = collect([
            (object) [
                'cod_objeto' => 'LV-42',
                'cod_objeto_zona' => '4',
                'nom_localidade' => 'RIO BRANCO',
                'nom_bairro' => 'CENTRO',
                'nom_local' => 'ESCOLA DIRECIONADA',
                'des_endereco' => 'RUA 42',
                'secoes' => '001',
                'num_latitude' => '-9.97499',
                'num_longitude' => '-67.82430',
                'possui_lda' => 0,
            ],
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('listarNomesLocaisOficiais')->zeroOrMoreTimes()->andReturn(collect());
        $localVotacao->shouldReceive('listarZonas')
            ->once()
            ->with([4], false)
            ->andReturn(collect([(object) ['cod_objeto_zona' => '4']]));
        $localVotacao->shouldReceive('listarMunicipios')
            ->once()
            ->with(null, [4], false)
            ->andReturn(collect());
        $localVotacao->shouldReceive('listarTodos')
            ->once()
            ->with(null, null, null, null, null, null, false, false, null, null, null, [4], false, false, null, null, 'LV-42', false, null, false, null)
            ->andReturn($locais);

        $controller = new ConsolidacaoController(
            $localVotacao,
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(RotaRepository::class)
        );

        $response = $controller->mapaLocaisVotacao(new Request([
            'cod_objeto_local' => ' LV-42 ',
            'area_local' => 'invalida',
        ]));

        $dados = $response->getData();

        $this->assertSame('LV-42', $dados['filtros']['cod_objeto_local']);
        $this->assertSame('', $dados['filtros']['area_local']);
        $this->assertCount(1, $dados['locaisMapa']);
        $this->assertSame('LV-42', $dados['locaisMapa'][0]['codigo']);
    }

    public function test_mapa_locais_votacao_expoe_locais_sem_coordenadas_para_o_modal(): void
    {
        session([
            "cod_zonas_permitidas" => [],
            "acesso_todas_zonas" => true,
        ]);

        $locais = collect([
            (object) [
                "cod_objeto" => "LV-PLOTADO",
                "cod_objeto_zona" => "4",
                "nom_localidade" => "RIO BRANCO",
                "nom_bairro" => "CENTRO",
                "nom_local" => "ESCOLA COM COORDENADA",
                "des_endereco" => "RUA 1",
                "secoes" => "001, 002",
                "num_latitude" => "-9.97499",
                "num_longitude" => "-67.82430",
                "possui_lda" => 0,
            ],
            (object) [
                "cod_objeto" => "LV-SEM",
                "cod_objeto_zona" => "5",
                "nom_localidade" => "CRUZEIRO DO SUL",
                "nom_bairro" => "CENTRO",
                "nom_local" => "ESCOLA SEM COORDENADA",
                "des_endereco" => "RUA 2",
                "secoes" => "010",
                "num_latitude" => null,
                "num_longitude" => "",
                "possui_lda" => 1,
            ],
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('listarNomesLocaisOficiais')->zeroOrMoreTimes()->andReturn(collect());
        $localVotacao->shouldReceive("listarZonas")
            ->once()
            ->with([], true)
            ->andReturn(collect());
        $localVotacao->shouldReceive("listarMunicipios")
            ->once()
            ->with(null, [], true)
            ->andReturn(collect());
        $localVotacao->shouldReceive("listarTodos")
            ->once()
            ->with(null, null, null, null, null, null, false, false, null, null, null, [], true, false, null, null, null, false, null, false, 'rural')
            ->andReturn($locais);

        $controller = new ConsolidacaoController(
            $localVotacao,
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(RotaRepository::class)
        );

        $response = $controller->mapaLocaisVotacao(new Request(['somente_zona_rural' => '1']));
        $dados = $response->getData();

        $this->assertSame('rural', $dados['filtros']['area_local']);
        $this->assertCount(1, $dados["locaisMapa"]);
        $this->assertSame("LV-PLOTADO", $dados["locaisMapa"][0]["codigo"]);
        $this->assertSame(1, $dados["resumoMapa"]["sem_coordenadas"]);
        $this->assertCount(1, $dados["locaisSemCoordenadas"]);
        $this->assertSame("LV-SEM", $dados["locaisSemCoordenadas"][0]["codigo"]);
        $this->assertSame("5", $dados["locaisSemCoordenadas"][0]["zona"]);
        $this->assertSame("ESCOLA SEM COORDENADA", $dados["locaisSemCoordenadas"][0]["nome"]);
        $this->assertSame(["010"], $dados["locaisSemCoordenadas"][0]["secoes"]);
    }

    public function test_autogeracao_transmissao_repassa_escopo_zonal_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('listarNomesLocaisOficiais')->zeroOrMoreTimes()->andReturn(collect());
        $localVotacao->shouldReceive('listarMunicipios')
            ->once()
            ->with(null, [4], false)
            ->andReturn(collect());

        $controller = new ConsolidacaoController(
            $localVotacao,
            Mockery::mock(LocalTransmissaoRepository::class),
            Mockery::mock(RotaRepository::class)
        );

        $response = $controller->autogeracaoTransmissao();

        $this->assertSame('lda.consolidacao.autogeracao-transmissao', $response->name());
    }

    public function test_busca_rotas_repassa_escopo_zonal_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('pesquisarRotasPorMunicipioZonaNoEscopo')
            ->once()
            ->with('Rio Branco', '4', [4], false)
            ->andReturn([]);

        $controller = new ConsolidacaoController(
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(LocalTransmissaoRepository::class),
            $rotaRepository
        );

        $response = $controller->buscarRotas(new Request([
            'municipio' => 'Rio Branco',
            'zona' => '4',
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame([], $response->getData(true));
    }

    public function test_vincular_rota_repassa_escopo_zonal_ao_repositorio(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $rotaRepository = Mockery::mock(RotaRepository::class);
        $rotaRepository->shouldReceive('vincularLocaisPorMunicipioZonaNoEscopo')
            ->once()
            ->with(10, ['ABC001'], 'Rio Branco', '4', [4], false)
            ->andReturn(['vinculados' => 1, 'ignorados' => 0]);
        DB::shouldReceive('transaction')->once()->andReturnUsing(
            static fn (callable $callback): mixed => $callback()
        );
        $transmissao = Mockery::mock(RotaTransmissaoService::class);
        $transmissao->shouldReceive('aplicarEfeitosDaRota')->once()->with(10);

        $controller = new ConsolidacaoController(
            Mockery::mock(LocalVotacaoRepository::class),
            Mockery::mock(LocalTransmissaoRepository::class),
            $rotaRepository,
            $transmissao
        );

        $response = $controller->vincularRota(new Request([
            'cod_objeto_local' => ['ABC001'],
            'rota_id' => 10,
            'municipio' => 'Rio Branco',
            'zona' => '4',
        ]));

        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame(1, $response->getData(true)['resultado']['vinculados']);
    }

    public function test_vincular_local_transmissao_rejeita_local_votacao_fora_do_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $localVotacao = Mockery::mock(LocalVotacaoRepository::class);
        $localVotacao->shouldReceive('buscarNoEscopo')
            ->once()
            ->with('LV-FORA', [4], false)
            ->andReturnNull();

        $localTransmissao = Mockery::mock(LocalTransmissaoRepository::class);
        $localTransmissao->shouldReceive('encontrar')
            ->once()
            ->with(10)
            ->andReturn((object) ['id' => 10, 'zona_num' => 4]);
        $localTransmissao->shouldNotReceive('vincularLocaisVotacao');

        $controller = new ConsolidacaoController(
            $localVotacao,
            $localTransmissao,
            Mockery::mock(RotaRepository::class)
        );

        $this->expectException(NotFoundHttpException::class);
        $controller->vincularLocal(new Request([
            'cod_objeto_local' => ['LV-FORA'],
            'local_transmissao_id' => 10,
        ]));
    }
}
```
</TESTS_UNIT_CONSOLIDACAOCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CpfTest.php`
## <TESTS_UNIT_CPFTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CpfTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CpfTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aceita_cpf_digitado_valido_e_normaliza_para_onze_digitos(string $entrada): void
public static function cpfsValidos(): array
public function rejeita_cpf_digitado_invalido(mixed $entrada): void
public static function cpfsInvalidos(): array
public function preparacao_nao_remove_caracteres_invalidos_antes_da_regra(): void
public function mascara_cpf_sem_expor_os_nove_primeiros_digitos(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Validation\Cpf;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class CpfTest extends TestCase
{
    #[Test]
    #[DataProvider('cpfsValidos')]
    public function aceita_cpf_digitado_valido_e_normaliza_para_onze_digitos(string $entrada): void
    {
        $this->assertTrue(Cpf::formatoPermitido($entrada));
        $this->assertTrue(Cpf::valido($entrada));
        $this->assertSame('52998224725', Cpf::normalizar($entrada));
        $this->assertSame('52998224725', Cpf::prepararEntrada($entrada));
    }

    /** @return array<string, array{string}> */
    public static function cpfsValidos(): array
    {
        return [
            'somente digitos' => ['52998224725'],
            'mascara brasileira' => ['529.982.247-25'],
            'espacos externos' => [' 529.982.247-25 '],
        ];
    }

    #[Test]
    #[DataProvider('cpfsInvalidos')]
    public function rejeita_cpf_digitado_invalido(mixed $entrada): void
    {
        $this->assertFalse(Cpf::valido($entrada));
    }

    /** @return array<string, array{mixed}> */
    public static function cpfsInvalidos(): array
    {
        return [
            'checksum' => ['52998224724'],
            'repetido' => ['11111111111'],
            'curto' => ['5299822472'],
            'letras' => ['529x98224725'],
            'pontuacao imprevista' => ['529/982/247-25'],
            'vazio' => [''],
            'nulo' => [null],
            'array' => [[]],
        ];
    }

    #[Test]
    public function preparacao_nao_remove_caracteres_invalidos_antes_da_regra(): void
    {
        $this->assertSame('529x98224725', Cpf::prepararEntrada(' 529x98224725 '));
        $this->assertNull(Cpf::normalizar('529x98224725'));
        $this->assertNull(Cpf::prepararEntrada(null));
    }

    #[Test]
    public function mascara_cpf_sem_expor_os_nove_primeiros_digitos(): void
    {
        $this->assertSame('***.***.***-25', Cpf::mascarar('529.982.247-25'));
        $this->assertSame('CPF indisponível', Cpf::mascarar(null));
    }
}
```
</TESTS_UNIT_CPFTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DashboardXssTest.php`
## <TESTS_UNIT_DASHBOARDXSSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DashboardXssTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DashboardXssTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function dashboard_usa_diretiva_json_segura_para_embutir_payload_no_javascript(): void
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

class DashboardXssTest extends TestCase
{
    #[Test]
    public function dashboard_usa_diretiva_json_segura_para_embutir_payload_no_javascript(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/dashboard.blade.php'));

        $this->assertStringNotContainsString(
            '{!! json_encode($dashboardPayload)',
            $conteudo,
            'json_encode sem flags de escaping é vetor de XSS — use @json() no lugar.'
        );

        $this->assertStringContainsString(
            '@json($dashboardPayload)',
            $conteudo,
            'O payload deve ser embutido via @json(), que aplica JSON_HEX_TAG e demais flags de segurança.'
        );
    }
}
```
</TESTS_UNIT_DASHBOARDXSSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DataIsoTest.php`
## <TESTS_UNIT_DATAISOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DataIsoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DataIsoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function interpreta_data_iso_estrita(): void
public function interpreta_formatos_datetime_local_usados(string $entrada, string $esperado): void
public static function datasHoraLocaisValidas(): array
public function rejeita_data_hora_ambigua_ou_inexistente(mixed $entrada): void
public static function datasHoraLocaisInvalidas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Validation\DataIso;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class DataIsoTest extends TestCase
{
    #[Test]
    public function interpreta_data_iso_estrita(): void
    {
        $data = DataIso::data('2024-02-29');

        $this->assertSame('2024-02-29', $data?->toDateString());
        $this->assertNull(DataIso::data('2023-02-29'));
        $this->assertNull(DataIso::data('29/02/2024'));
        $this->assertNull(DataIso::data('2024-2-9'));
    }

    #[Test]
    #[DataProvider('datasHoraLocaisValidas')]
    public function interpreta_formatos_datetime_local_usados(string $entrada, string $esperado): void
    {
        $this->assertSame($esperado, DataIso::dataHoraLocal($entrada)?->format('Y-m-d H:i:s'));
        $this->assertSame($esperado, DataIso::normalizarDataHoraLocal($entrada));
    }

    /** @return array<string, array{string, string}> */
    public static function datasHoraLocaisValidas(): array
    {
        return [
            'minutos' => ['2026-07-26T14:35', '2026-07-26 14:35:00'],
            'segundos' => ['2026-07-26T14:35:59', '2026-07-26 14:35:59'],
        ];
    }

    #[Test]
    #[DataProvider('datasHoraLocaisInvalidas')]
    public function rejeita_data_hora_ambigua_ou_inexistente(mixed $entrada): void
    {
        $this->assertNull(DataIso::dataHoraLocal($entrada));
    }

    /** @return array<string, array{mixed}> */
    public static function datasHoraLocaisInvalidas(): array
    {
        return [
            'sem t' => ['2026-07-26 14:35'],
            'ambigua' => ['26/07/2026 14:35'],
            'hora inexistente' => ['2026-07-26T25:00'],
            'vazio' => [''],
            'nulo' => [null],
        ];
    }
}
```
</TESTS_UNIT_DATAISOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EquipeGeneralizacaoMigrationsTest.php`
## <TESTS_UNIT_EQUIPEGENERALIZACAOMIGRATIONSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EquipeGeneralizacaoMigrationsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EquipeGeneralizacaoMigrationsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringContainsString("DB::table('EQUIPE')", $conteudo);
$this->assertStringContainsString("DB::table('EQUIPE_VINCULO')->insert([", $conteudo);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_de_vinculo_de_equipe_para_multiplos_contextos(): void
public function migration_generaliza_tabela_de_integrantes_sem_quebrar_o_legado_de_rotas(): void
$this->assertStringContainsString('private function columnExists(string $table, string $column): bool', $conteudo);
$this->assertStringContainsString('private function indexExists(string $index): bool', $conteudo);
$this->assertStringContainsString('private function constraintExists(string $constraint): bool', $conteudo);
public function migration_incremental_bloqueia_voluntario_em_mais_de_uma_rota(): void
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

class EquipeGeneralizacaoMigrationsTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_de_vinculo_de_equipe_para_multiplos_contextos(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_04_26_120000_create_equipe_vinculo_table.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE TABLE equipe_vinculo (', $conteudo);
        $this->assertStringContainsString('tipo_vinculo   VARCHAR2(40 CHAR)                       NOT NULL,', $conteudo);
        $this->assertStringContainsString('vinculo_id     NUMBER                                  NOT NULL,', $conteudo);
        $this->assertStringContainsString("CHECK (tipo_vinculo IN ('ROTA', 'LDA', 'LOCAL_TRANSMISSAO'))", $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_equipe_vinculo_01 ON equipe_vinculo (tipo_vinculo, vinculo_id)', $conteudo);
        $this->assertStringContainsString('DROP TABLE equipe_vinculo', $conteudo);
    }

    #[Test]
    public function migration_generaliza_tabela_de_integrantes_sem_quebrar_o_legado_de_rotas(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_04_26_120100_generalize_equipe_table.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('ALTER TABLE equipe MODIFY (rota_id NUMBER)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE equipe ADD (equipe_vinculo_id NUMBER)', $conteudo);
        $this->assertStringContainsString("if (!\$this->columnExists('EQUIPE', 'EQUIPE_VINCULO_ID'))", $conteudo);
        $this->assertStringContainsString("DB::table('EQUIPE')", $conteudo);
        $this->assertStringContainsString("DB::table('EQUIPE_VINCULO')->insert([", $conteudo);
        $this->assertStringContainsString("'TIPO_VINCULO' => 'ROTA'", $conteudo);
        $this->assertStringContainsString('UPDATE equipe e', $conteudo);
        $this->assertStringContainsString('AND e.equipe_vinculo_id IS NULL', $conteudo);
        $this->assertStringContainsString('ALTER TABLE equipe MODIFY (equipe_vinculo_id NUMBER NOT NULL)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE equipe ADD CONSTRAINT fk_equipe_vinculo', $conteudo);
        $this->assertStringContainsString('FOREIGN KEY (equipe_vinculo_id) REFERENCES equipe_vinculo(id) ON DELETE CASCADE', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_equipe_02 ON equipe (equipe_vinculo_id, num_inscricao)', $conteudo);
        $this->assertStringContainsString('CREATE INDEX ix_equipe_04 ON equipe (equipe_vinculo_id)', $conteudo);
        $this->assertStringContainsString('private function columnExists(string $table, string $column): bool', $conteudo);
        $this->assertStringContainsString('private function indexExists(string $index): bool', $conteudo);
        $this->assertStringContainsString('private function constraintExists(string $constraint): bool', $conteudo);
    }

    #[Test]
    public function migration_incremental_bloqueia_voluntario_em_mais_de_uma_rota(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_07_02_130300_add_unique_voluntario_rota_to_equipe.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_equipe_rota_inscricao_global', $conteudo);
        $this->assertStringContainsString('CASE WHEN rota_id IS NOT NULL THEN TRIM(num_inscricao) END', $conteudo);
        $this->assertStringContainsString('HAVING COUNT(DISTINCT e.rota_id) > 1', $conteudo);
        $this->assertStringContainsString('Voluntarios alocados em mais de uma rota', $conteudo);
        $this->assertStringContainsString('DROP INDEX ux_equipe_rota_inscricao_global', $conteudo);
    }
}
```
</TESTS_UNIT_EQUIPEGENERALIZACAOMIGRATIONSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EquipeRepositoryVinculoIdTest.php`
## <TESTS_UNIT_EQUIPEREPOSITORYVINCULOIDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EquipeRepositoryVinculoIdTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EquipeRepositoryVinculoIdTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_busca_vinculo_existente_aceita_id_minusculo_do_oracle(): void
public function test_listar_por_rota_resolve_nome_de_colaborador_interno_deferido_das_acoes_321_e_342(): void
public function test_listar_por_vinculos_da_listagem_resolve_nome_de_colaborador_interno_deferido_das_acoes_321_e_342(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\EquipeRepository;
use App\Repositories\ColaboradoresEleitorais\Queries\EleitorConvocadoEfetivoEquipeQuery;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class EquipeRepositoryVinculoIdTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_busca_vinculo_existente_aceita_id_minusculo_do_oracle(): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('select')->once()->with('ID')->andReturnSelf();
        $builder->shouldReceive('where')->once()->with('TIPO_VINCULO', 'ROTA')->andReturnSelf();
        $builder->shouldReceive('where')->once()->with('VINCULO_ID', 21)->andReturnSelf();
        $builder->shouldReceive('first')->once()->andReturn((object) ['id' => '7']);

        DB::shouldReceive('table')->once()->with('EQUIPE_VINCULO')->andReturn($builder);

        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $reflection = new \ReflectionMethod($repository, 'buscarOuCriarEquipeVinculoId');
        $reflection->setAccessible(true);

        $resultado = $reflection->invoke($repository, 'ROTA', 21);

        $this->assertSame(7, $resultado);
    }

    public function test_listar_por_rota_resolve_nome_de_colaborador_interno_deferido_das_acoes_321_e_342(): void
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
                        && str_contains($sql, 'ci.PROCESSO_ELEITORAL_ID IN (:processo_colaboradores_deferidos_id_0,:processo_colaboradores_deferidos_id_1)')
                        && str_contains($sql, 'convocacao_efetiva.nom_eleitor')
                        && str_contains($sql, 'convocacao_efetiva.telefone')
                        && str_contains($sql, 'LEFT JOIN CE_VOLUNTARIO_MANUAL vm')
                        && str_contains($sql, 'e.cod_objeto_local_responsavel')
                        && str_contains($sql, 'LEFT JOIN planeleito.vw_locais_votacao_efetivos lv_responsavel')
                        && str_contains($sql, 'AS local_responsavel_texto')
                        && str_contains($sql, "AND ev.tipo_vinculo = 'ROTA'");
                }),
                [
                    'processo_colaboradores_deferidos_id_0' => 321,
                    'processo_colaboradores_deferidos_id_1' => 342,
                    'tipo_vinculo' => 'ROTA',
                    'vinculo_id' => 9,
                ]
            )
            ->andReturn([(object) [
                'id' => 33,
                'rota_id' => 9,
                'tipo_vinculo' => 'ROTA',
                'vinculo_id' => 9,
                'cargo_id' => 5,
                'num_inscricao' => '002832012410',
                'observacao' => null,
                'cod_objeto_local_responsavel' => 'LOCAL-10',
                'local_responsavel_texto' => '5 - Rio Branco - Escola Exemplo (Local 10)',
                'cargo_nome' => 'Gerente de UMS',
                'nom_eleitor' => 'Aieza dos Santos Bandeira',
                'dat_nasc' => null,
                'num_cpf' => null,
                'telefone' => null,
                'num_zona' => null,
                'nom_localidade' => null,
            ]]);

        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $resultado = $repository->listarPorRota(9);

        $this->assertSame('Aieza dos Santos Bandeira', $resultado[0]['nom_eleitor']);
        $this->assertSame('002832012410', $resultado[0]['num_inscricao']);
        $this->assertSame('LOCAL-10', $resultado[0]['cod_objeto_local_responsavel']);
        $this->assertSame('5 - Rio Branco - Escola Exemplo (Local 10)', $resultado[0]['local_responsavel_texto']);
    }

    public function test_listar_por_vinculos_da_listagem_resolve_nome_de_colaborador_interno_deferido_das_acoes_321_e_342(): void
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
                        && str_contains($sql, 'LEFT JOIN CE_VOLUNTARIO_MANUAL vm')
                        && str_contains($sql, "AND ev.tipo_vinculo = 'ROTA'")
                        && str_contains($sql, 'ev.vinculo_id IN (?,?)');
                }),
                [321, 342, 'ROTA', 9, 10]
            )
            ->andReturn([(object) [
                'vinculo_id' => 9,
                'cargo_nome' => 'Gerente de UMS',
                'nom_eleitor' => 'Aieza dos Santos Bandeira',
                'telefone' => null,
            ]]);

        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $resultado = $repository->listarPorVinculos('ROTA', [9, 10]);

        $this->assertSame('Aieza dos Santos Bandeira', $resultado[9][0]['nom_eleitor']);
        $this->assertSame('Gerente de UMS', $resultado[9][0]['cargo_nome']);
    }
}
```
</TESTS_UNIT_EQUIPEREPOSITORYVINCULOIDTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EscopoUnidadeServiceTest.php`
## <TESTS_UNIT_ESCOPOUNIDADESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EscopoUnidadeServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EscopoUnidadeServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_escopo_atual_e_irrestrito_para_admin(): void
public function test_escopo_atual_e_irrestrito_quando_rota_ignora_unidades(): void
public function test_escopo_por_rota_restringe_e_normaliza_ids_de_unidade(): void
public function test_escopo_por_rota_lanca_excecao_quando_contrato_da_sessao_esta_invalido(): void
private function registrarRotaAtual(string $nome): void
public function __construct(private readonly string $nome)
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\EscopoUnidadeService;
use Illuminate\Http\Request;
use RuntimeException;
use Tests\TestCase;

class EscopoUnidadeServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_escopo_atual_e_irrestrito_para_admin(): void
    {
        $this->registrarRotaAtual('planejamento.projetos.listar');
        session([
            'is_admin' => true,
            'aplica_escopo_unidade' => true,
            'unidades_permitidas_ids' => [10, 20],
        ]);

        $escopo = app(EscopoUnidadeService::class)->escopoAtual();

        $this->assertTrue($escopo->isIrrestrito());
        $this->assertSame([], $escopo->unidades);
    }

    public function test_escopo_atual_e_irrestrito_quando_rota_ignora_unidades(): void
    {
        $this->registrarRotaAtual('tarefas.form');
        session([
            'is_admin' => false,
            'ignora_unidades_na_rota' => true,
            'aplica_escopo_unidade' => true,
            'unidades_permitidas_ids' => [10, 20],
        ]);

        $escopo = app(EscopoUnidadeService::class)->escopoAtual();

        $this->assertTrue($escopo->isIrrestrito());
        $this->assertSame([], $escopo->unidades);
    }

    public function test_escopo_por_rota_restringe_e_normaliza_ids_de_unidade(): void
    {
        session([
            'is_admin' => false,
            'ignora_unidades_na_rota' => false,
            'aplica_escopo_unidade' => true,
            'unidades_permitidas_ids' => ['10', '20', '20', 'abc', 0, -1],
        ]);

        $escopo = app(EscopoUnidadeService::class)->escopoPorRota('planejamento.projetos.listar');

        $this->assertTrue($escopo->aplicaEscopo);
        $this->assertSame([10, 20], $escopo->unidades);
        $this->assertSame([10, 20], app(EscopoUnidadeService::class)->unidadesParaConsultaAtual());
    }

    public function test_escopo_por_rota_lanca_excecao_quando_contrato_da_sessao_esta_invalido(): void
    {
        session([
            'user' => ['username' => 'teste'],
            'is_admin' => false,
            'ignora_unidades_na_rota' => false,
            'aplica_escopo_unidade' => 'S',
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Contrato de escopo de unidade inválido');

        app(EscopoUnidadeService::class)->escopoPorRota('planejamento.projetos.listar');
    }

    private function registrarRotaAtual(string $nome): void
    {
        $request = Request::create('/teste', 'GET');
        $request->setRouteResolver(static fn () => new class($nome) {
            public function __construct(private readonly string $nome)
            {
            }

            public function getName(): string
            {
                return $this->nome;
            }
        });

        $this->app->instance('request', $request);
    }
}
```
</TESTS_UNIT_ESCOPOUNIDADESERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EscopoZonalTest.php`
## <TESTS_UNIT_ESCOPOZONALTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EscopoZonalTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EscopoZonalTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function normaliza_zonas_numericas_na_ordem_e_remove_invalidas_e_duplicadas(): void
public function zona_zero_ou_flag_explicita_representam_acesso_global(): void
public function ausencia_de_zonas_sem_acesso_global_falha_fechado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Access\EscopoZonal;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class EscopoZonalTest extends TestCase
{
    #[Test]
    public function normaliza_zonas_numericas_na_ordem_e_remove_invalidas_e_duplicadas(): void
    {
        $escopo = EscopoZonal::from(['9', 4, '9', -1, 'x', null], false);

        $this->assertSame([9, 4], $escopo->zonas());
        $this->assertFalse($escopo->acessoTodas());
        $this->assertFalse($escopo->semAcesso());
        $this->assertTrue($escopo->permite(9));
        $this->assertFalse($escopo->permite(3));
    }

    #[Test]
    public function zona_zero_ou_flag_explicita_representam_acesso_global(): void
    {
        $porZona = EscopoZonal::from([0], false);
        $porFlag = EscopoZonal::from([], true);

        $this->assertTrue($porZona->acessoTodas());
        $this->assertTrue($porZona->permite(99));
        $this->assertTrue($porFlag->acessoTodas());
        $this->assertTrue($porFlag->permite(99));
    }

    #[Test]
    public function ausencia_de_zonas_sem_acesso_global_falha_fechado(): void
    {
        $escopo = EscopoZonal::from([], false);

        $this->assertTrue($escopo->semAcesso());
        $this->assertFalse($escopo->permite(1));
    }
}
```
</TESTS_UNIT_ESCOPOZONALTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EsferaControllerTest.php`
## <TESTS_UNIT_ESFERACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EsferaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EsferaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_esferas_ordenadas(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\TabelasAuxiliares\EsferaController;
use App\Repositories\TabelasAuxiliares\EsferaRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class EsferaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_esferas_ordenadas(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'codigo' => 'FEDERAL', 'descricao' => 'Federal', 'ordem' => 1]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/esferas']
        );

        $repository = Mockery::mock(EsferaRepository::class);
        $repository->shouldReceive('listar')->once()->with(null)->andReturn($paginator);

        $controller = new EsferaController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/esferas', 'GET'));

        $this->assertSame('tabelas-auxiliares.esferas.index', $response->name());
        $this->assertCount(1, $response->getData()['esferas']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        $registro = (object) ['id' => 2, 'codigo' => 'ESTADUAL', 'descricao' => 'Estadual', 'ordem' => 2];
        $repository = Mockery::mock(EsferaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(2)->andReturn($registro);

        $controller = Mockery::mock(EsferaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(2);

        $this->assertSame('tabelas-auxiliares.esferas.form', $response->name());
        $this->assertSame($registro, $response->getData()['esfera']);
    }
}
```
</TESTS_UNIT_ESFERACONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EsferaMigrationTest.php`
## <TESTS_UNIT_ESFERAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EsferaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EsferaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_esfera_com_codigo_descricao_ordem_e_semente(): void
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

class EsferaMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_esfera_com_codigo_descricao_ordem_e_semente(): void
    {
        $arquivo = database_path('migrations/2026_06_20_180000_create_esfera_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        // Tabela criada com as colunas do padrão auxiliar.
        $this->assertStringContainsString('CREATE TABLE esfera', $conteudo);
        $this->assertStringContainsString('codigo', $conteudo);
        $this->assertStringContainsString('descricao', $conteudo);
        $this->assertStringContainsString('ordem', $conteudo);
        $this->assertStringContainsString('dt_criacao', $conteudo);
        $this->assertStringContainsString('dt_atualizacao', $conteudo);

        // Unique index no código (upper).
        $this->assertStringContainsString('ux_esfera_codigo', $conteudo);
        $this->assertStringContainsString('UPPER(codigo)', $conteudo);

        // Semente com as quatro esferas.
        $this->assertStringContainsString("'FEDERAL'", $conteudo);
        $this->assertStringContainsString("'ESTADUAL'", $conteudo);
        $this->assertStringContainsString("'MUNICIPAL'", $conteudo);
        $this->assertStringContainsString("'PARTICULAR'", $conteudo);
    }
}
```
</TESTS_UNIT_ESFERAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EtiquetaLocalA4260CamposTest.php`
## <TESTS_UNIT_ETIQUETALOCALA4260CAMPOSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EtiquetaLocalA4260CamposTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EtiquetaLocalA4260CamposTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function oferece_whitelist_e_pre_selecao_solicitada_para_a_etiqueta(): void
public function apresenta_dois_certificados_na_mesma_etiqueta_e_respeita_os_campos_selecionados(): void
public function distingue_local_sem_certificado_de_dependencia_indisponivel(): void
private function etiqueta(?array $certificados): EtiquetaLocalA4260Pdf
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Exportacao\EtiquetaLocalA4260Campos;
use App\Support\Exportacao\EtiquetaLocalA4260Pdf;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class EtiquetaLocalA4260CamposTest extends TestCase
{
    #[Test]
    public function oferece_whitelist_e_pre_selecao_solicitada_para_a_etiqueta(): void
    {
        $this->assertSame([
            'zona' => 'Zona',
            'municipio' => 'Município',
            'nome_local' => 'Local de votação',
            'endereco' => 'Endereço',
            'certificado_jeconnect' => 'Certificado JECONNECT',
        ], EtiquetaLocalA4260Campos::disponiveis());
        $this->assertSame(
            ['zona', 'municipio', 'endereco', 'certificado_jeconnect'],
            EtiquetaLocalA4260Campos::padrao()
        );
    }

    #[Test]
    public function apresenta_dois_certificados_na_mesma_etiqueta_e_respeita_os_campos_selecionados(): void
    {
        $etiqueta = $this->etiqueta(['CERT-10', ' CERT-20 ']);

        $this->assertSame([
            ['rotulo' => 'Zona', 'valor' => '9ª Zona'],
            ['rotulo' => 'Município', 'valor' => 'RIO BRANCO'],
            ['rotulo' => 'Endereço', 'valor' => 'RUA RUI BARBOSA, 285'],
            ['rotulo' => 'Certificado JECONNECT', 'valor' => 'CERT-10 | CERT-20'],
        ], EtiquetaLocalA4260Campos::linhas(
            $etiqueta,
            ['zona', 'municipio', 'endereco', 'certificado_jeconnect']
        ));
    }

    #[Test]
    public function distingue_local_sem_certificado_de_dependencia_indisponivel(): void
    {
        $this->assertSame(
            'Sem certificado',
            EtiquetaLocalA4260Campos::linhas(
                $this->etiqueta([]),
                ['certificado_jeconnect']
            )[0]['valor']
        );
        $this->assertSame(
            'Certificado indisponível',
            EtiquetaLocalA4260Campos::linhas(
                $this->etiqueta(null),
                ['certificado_jeconnect']
            )[0]['valor']
        );
    }

    /** @param list<string>|null $certificados */
    private function etiqueta(?array $certificados): EtiquetaLocalA4260Pdf
    {
        return new EtiquetaLocalA4260Pdf(
            codObjetoLocal: 'LOCAL-1',
            zona: '9',
            municipio: 'RIO BRANCO',
            nomeLocal: 'PREFEITURA MUNICIPAL DE RIO BRANCO',
            endereco: 'RUA RUI BARBOSA, 285',
            certificados: $certificados,
        );
    }
}
```
</TESTS_UNIT_ETIQUETALOCALA4260CAMPOSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EtiquetaLocalA4260PdfRendererTest.php`
## <TESTS_UNIT_ETIQUETALOCALA4260PDFRENDERERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EtiquetaLocalA4260PdfRendererTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EtiquetaLocalA4260PdfRendererTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function distribui_vinte_e_uma_etiquetas_por_pagina_a4_em_retrato(): void
private function etiquetas(int $quantidade): \Illuminate\Support\Collection
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Exportacao\EtiquetaLocalA4260Pdf;
use App\Support\Exportacao\EtiquetaLocalA4260PdfRenderer;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class EtiquetaLocalA4260PdfRendererTest extends TestCase
{
    #[Test]
    public function distribui_vinte_e_uma_etiquetas_por_pagina_a4_em_retrato(): void
    {
        $renderer = new EtiquetaLocalA4260PdfRenderer;

        $pdfComUmaFolha = $renderer->renderizar(
            $this->etiquetas(21),
            ['zona', 'municipio', 'endereco', 'certificado_jeconnect']
        );
        $pdfComDuasFolhas = $renderer->renderizar(
            $this->etiquetas(22),
            ['zona', 'municipio', 'endereco', 'certificado_jeconnect']
        );

        $this->assertStringStartsWith('%PDF', $pdfComUmaFolha);
        $this->assertSame(1, preg_match_all('/\/Type\s*\/Page\b/', $pdfComUmaFolha));
        $this->assertSame(2, preg_match_all('/\/Type\s*\/Page\b/', $pdfComDuasFolhas));
        $this->assertMatchesRegularExpression(
            '/\/MediaBox\s*\[\s*0(?:\.0+)?\s+0(?:\.0+)?\s+595\.\d+\s+841\.\d+\s*\]/',
            $pdfComUmaFolha
        );
    }

    /** @return \Illuminate\Support\Collection<int, EtiquetaLocalA4260Pdf> */
    private function etiquetas(int $quantidade): \Illuminate\Support\Collection
    {
        return collect(range(1, $quantidade))->map(static fn (int $indice): EtiquetaLocalA4260Pdf => new EtiquetaLocalA4260Pdf(
            codObjetoLocal: 'LOCAL-'.$indice,
            zona: '9',
            municipio: 'RIO BRANCO',
            nomeLocal: 'ESCOLA MODELO '.$indice,
            endereco: 'RUA RUI BARBOSA, '.$indice,
            certificados: ['CERT-'.$indice],
        ));
    }
}
```
</TESTS_UNIT_ETIQUETALOCALA4260PDFRENDERERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ExampleTest.php`
## <TESTS_UNIT_EXAMPLETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ExampleTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ExampleTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_that_true_is_true(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function test_that_true_is_true(): void
    {
        $this->assertTrue(true);
    }
}
```
</TESTS_UNIT_EXAMPLETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/GlpiApiServiceTest.php`
## <TESTS_UNIT_GLPIAPISERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/GlpiApiServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GlpiApiServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function busca_computadores_troca_perfil_ativo_e_normaliza_resultados(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Lda\GlpiApiService;
use Illuminate\Support\Facades\Http;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class GlpiApiServiceTest extends TestCase
{
    #[Test]
    public function busca_computadores_troca_perfil_ativo_e_normaliza_resultados(): void
    {
        config()->set('services.glpi.base_url', 'http://glpi.local/apirest.php');
        config()->set('services.glpi.app_token', 'app-token');
        config()->set('services.glpi.user_token', 'user-token');
        config()->set('services.glpi.profile_name', 'Super-Admin');

        Http::fake([
            'http://glpi.local/apirest.php/initSession*' => Http::response([
                'session_token' => 'sess-1',
            ]),
            'http://glpi.local/apirest.php/getActiveProfile' => Http::response([
                'active_profile' => [
                    'id' => 1,
                    'name' => 'Self-Service',
                ],
            ]),
            'http://glpi.local/apirest.php/getMyProfiles' => Http::response([
                ['id' => 4, 'name' => 'Super-Admin'],
            ]),
            'http://glpi.local/apirest.php/changeActiveProfile*' => Http::response([
                'id' => 4,
                'name' => 'Super-Admin',
            ]),
            'http://glpi.local/apirest.php/listSearchOptions/Computer' => Http::response([
                '2' => ['field' => 'id'],
                '1' => ['field' => 'name'],
                '40' => ['field' => 'serial'],
                '41' => ['field' => 'otherserial'],
                '31' => ['field' => 'states_id'],
                '80' => ['field' => 'entities_id'],
            ]),
            'http://glpi.local/apirest.php/search/Computer*' => Http::response([
                'data' => [[
                    '2' => 77,
                    '1' => 'NOTEBOOK OPERACIONAL',
                    '40' => 'SER123',
                    '41' => 'PAT456',
                    '31' => 'Operacional',
                    '80' => 'TRE-AC',
                ]],
            ]),
            'http://glpi.local/apirest.php/killSession' => Http::response([
                'message' => 'ok',
            ]),
        ]);

        $service = new GlpiApiService();
        $resultados = $service->searchComputers('NOTEBOOK', 10);

        $this->assertCount(1, $resultados);
        $this->assertSame(77, $resultados[0]['glpi_item_id']);
        $this->assertSame('Computer', $resultados[0]['glpi_itemtype']);
        $this->assertSame('NOTEBOOK OPERACIONAL', $resultados[0]['nome']);
        $this->assertSame('SER123', $resultados[0]['serial']);
        $this->assertSame('PAT456', $resultados[0]['otherserial']);
        $this->assertSame('Operacional', $resultados[0]['status']);

        Http::assertSent(function ($request) {
            return $request->url() === 'http://glpi.local/apirest.php/changeActiveProfile?session_write=true'
                && $request['profiles_id'] === 4;
        });
    }
}
```
</TESTS_UNIT_GLPIAPISERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LayoutLocalEnvironmentMenuThemeTest.php`
## <TESTS_UNIT_LAYOUTLOCALENVIRONMENTMENUTHEMETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LayoutLocalEnvironmentMenuThemeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LayoutLocalEnvironmentMenuThemeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_menu_usa_success_em_ambiente_local_e_primary_nos_demais(): void
public function test_rodape_nao_exibe_perfis_de_diarias_da_sessao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class LayoutLocalEnvironmentMenuThemeTest extends TestCase
{
    public function test_menu_usa_success_em_ambiente_local_e_primary_nos_demais(): void
    {
        $layout = file_get_contents(resource_path('views/layouts/app.blade.php'));

        $this->assertIsString($layout);
        $this->assertStringContainsString('@php' . PHP_EOL . '        $isLocalEnvironment = app()->environment(\'local\');', $layout);
        $this->assertStringContainsString("\$isLocalEnvironment ? 'success' : 'primary'", $layout);
        $this->assertStringContainsString('@endphp', $layout);
        $this->assertStringContainsString('bg-{{ $menuThemeColor }}', $layout);
        $this->assertStringContainsString('navbar-brand-group', $layout);
        $this->assertStringContainsString('@if($isLocalEnvironment)', $layout);
        $this->assertStringContainsString('text-bg-warning', $layout);
        $this->assertStringContainsString('Homologação', $layout);
        $this->assertStringNotContainsString('navbar navbar-expand-lg navbar-dark bg-primary mb-3', $layout);
        $this->assertStringNotContainsString("\$isLocalEnvironment ? 'danger' : 'primary'", $layout);
    }

    public function test_rodape_nao_exibe_perfis_de_diarias_da_sessao(): void
    {
        $layout = file_get_contents(resource_path('views/layouts/app.blade.php'));

        $this->assertIsString($layout);
        $this->assertStringNotContainsString("session('diarias_usuario.perfis', [])", $layout);
        $this->assertStringNotContainsString('Perfis Diárias:', $layout);
    }
}
```
</TESTS_UNIT_LAYOUTLOCALENVIRONMENTMENUTHEMETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LayoutStyleStacksTest.php`
## <TESTS_UNIT_LAYOUTSTYLESTACKSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LayoutStyleStacksTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LayoutStyleStacksTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function layout_principal_renderiza_as_duas_convencoes_de_stack_de_estilo(): void
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

class LayoutStyleStacksTest extends TestCase
{
    #[Test]
    public function layout_principal_renderiza_as_duas_convencoes_de_stack_de_estilo(): void
    {
        $conteudo = file_get_contents(resource_path('views/layouts/app.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("@stack('estilos')", $conteudo);
        $this->assertStringContainsString("@stack('styles')", $conteudo);
    }
}
```
</TESTS_UNIT_LAYOUTSTYLESTACKSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LoggingRetentionConfigurationTest.php`
## <TESTS_UNIT_LOGGINGRETENTIONCONFIGURATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LoggingRetentionConfigurationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LoggingRetentionConfigurationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_stack_padrao_usa_log_diario_com_retencao_de_trinta_dias(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class LoggingRetentionConfigurationTest extends TestCase
{
    public function test_stack_padrao_usa_log_diario_com_retencao_de_trinta_dias(): void
    {
        $this->assertSame(['daily'], config('logging.channels.stack.channels'));
        $this->assertSame('daily', config('logging.channels.daily.driver'));
        $this->assertSame(30, config('logging.channels.daily.days'));
    }
}
```
</TESTS_UNIT_LOGGINGRETENTIONCONFIGURATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MensageriaPersistenciaTecnicaTest.php`
## <TESTS_UNIT_MENSAGERIAPERSISTENCIATECNICATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MensageriaPersistenciaTecnicaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MensageriaPersistenciaTecnicaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('nat_rota_conversa', function ($table): void {
Schema::create('nat_rota_mensagem', function ($table): void {
Schema::create('nat_rota_mensagem_leitura', function ($table): void {
$this->assertSame(0, DB::table('nat_rota_conversa')->count());
$this->assertSame(0, DB::table('nat_rota_mensagem')->count());
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_repositories_de_mensageria_nao_dependem_de_auditoria_funcional(): void
public function test_falha_da_mensagem_reverte_criacao_da_conversa_de_rota_sem_auditoria(): void
public function test_falha_da_mensagem_reverte_criacao_da_conversa_lda_sem_auditoria(): void
public function test_falha_da_mensagem_reverte_atualizacao_da_conversa_existente(): void
private function repository(string $classe): object
public function __construct(private array &$auditorias) {}
public function inserir(array $payload): void
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
use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Repositories\Nat\NatRotaMensagemRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use ReflectionClass;
use RuntimeException;
use Tests\TestCase;

class MensageriaPersistenciaTecnicaTest extends TestCase
{
    /** @var array<int, array<string, mixed>> */
    private array $auditorias = [];

    protected function setUp(): void
    {
        parent::setUp();

        Schema::dropIfExists('nat_rota_mensagem_leitura');
        Schema::dropIfExists('nat_rota_mensagem');
        Schema::dropIfExists('nat_rota_conversa');

        Schema::create('nat_rota_conversa', function ($table): void {
            $table->increments('id');
            $table->integer('macroprojeto_id');
            $table->string('escopo_tipo');
            $table->integer('rota_id')->nullable();
            $table->integer('lda_id')->nullable();
            $table->string('turno')->nullable();
            $table->dateTime('arquivada_em')->nullable();
            $table->dateTime('dt_criacao')->nullable();
            $table->dateTime('dt_atualizacao')->nullable();
        });
        Schema::create('nat_rota_mensagem', function ($table): void {
            $table->increments('id');
            $table->integer('conversa_id');
            $table->integer('macroprojeto_id');
            $table->integer('rota_id')->nullable();
            $table->string('origem');
            $table->text('mensagem');
            $table->integer('ocorrencia_id')->nullable();
            $table->string('broadcast_lote_id')->nullable();
            $table->string('usuario_login')->nullable();
            $table->string('usuario_nome')->nullable();
            $table->dateTime('dt_criacao')->nullable();
        });
        Schema::create('nat_rota_mensagem_leitura', function ($table): void {
            $table->increments('id');
            $table->integer('mensagem_id');
            $table->integer('rota_id')->nullable();
            $table->string('usuario_login');
            $table->string('usuario_nome')->nullable();
            $table->dateTime('dt_leitura')->nullable();
        });

        DB::unprepared(<<<'SQL'
CREATE TRIGGER falhar_insert_mensagem
BEFORE INSERT ON nat_rota_mensagem
BEGIN
    SELECT RAISE(ABORT, 'falha controlada da mensagem');
END
SQL);
    }

    public function test_repositories_de_mensageria_nao_dependem_de_auditoria_funcional(): void
    {
        foreach ([NatRotaMensagemRepository::class, LdaConversaMensagemRepository::class] as $classe) {
            $reflexao = new ReflectionClass($classe);
            $this->assertFalse(in_array('App\Repositories\Concerns\AuditaDml', $reflexao->getTraitNames(), true));
            $this->assertSame(0, $reflexao->getConstructor()?->getNumberOfRequiredParameters() ?? 0);
        }
    }

    public function test_falha_da_mensagem_reverte_criacao_da_conversa_de_rota_sem_auditoria(): void
    {
        $repository = $this->repository(NatRotaMensagemRepository::class);

        try {
            $repository->registrarMensagem([
                'macroprojeto_id' => 10,
                'rota_id' => 20,
                'origem' => 'NAT',
                'mensagem' => 'Teste',
                'usuario_login' => 'usuario',
                'usuario_nome' => 'Usuario',
            ]);
            $this->fail('O gatilho deveria impedir a mensagem.');
        } catch (\Throwable $exception) {
            $this->assertStringContainsString('falha controlada da mensagem', $exception->getMessage());
        }

        $this->assertSame(0, DB::table('nat_rota_conversa')->count());
        $this->assertSame(0, DB::table('nat_rota_mensagem')->count());
        $this->assertSame([], $this->auditorias);
    }

    public function test_falha_da_mensagem_reverte_criacao_da_conversa_lda_sem_auditoria(): void
    {
        $repository = $this->repository(LdaConversaMensagemRepository::class);

        try {
            $repository->registrarMensagem([
                'macroprojeto_id' => 10,
                'turno' => '1',
                'lda_id' => 30,
                'origem' => 'ROTA',
                'mensagem' => 'Teste',
                'usuario_login' => 'usuario',
                'usuario_nome' => 'Usuario',
            ]);
            $this->fail('O gatilho deveria impedir a mensagem.');
        } catch (\Throwable $exception) {
            $this->assertStringContainsString('falha controlada da mensagem', $exception->getMessage());
        }

        $this->assertSame(0, DB::table('nat_rota_conversa')->count());
        $this->assertSame(0, DB::table('nat_rota_mensagem')->count());
        $this->assertSame([], $this->auditorias);
    }

    public function test_falha_da_mensagem_reverte_atualizacao_da_conversa_existente(): void
    {
        $conversaId = DB::table('nat_rota_conversa')->insertGetId([
            'macroprojeto_id' => 10,
            'escopo_tipo' => 'ROTA',
            'rota_id' => 20,
            'lda_id' => null,
            'turno' => null,
            'arquivada_em' => null,
            'dt_criacao' => '2026-01-01 10:00:00',
            'dt_atualizacao' => '2026-01-01 10:00:00',
        ]);
        $repository = $this->repository(NatRotaMensagemRepository::class);

        try {
            $repository->registrarMensagem([
                'macroprojeto_id' => 10,
                'rota_id' => 20,
                'origem' => 'NAT',
                'mensagem' => 'Teste',
                'usuario_login' => 'usuario',
                'usuario_nome' => 'Usuario',
            ]);
            $this->fail('O gatilho deveria impedir a mensagem.');
        } catch (\Throwable $exception) {
            $this->assertStringContainsString('falha controlada da mensagem', $exception->getMessage());
        }

        $conversa = DB::table('nat_rota_conversa')->where('id', $conversaId)->first();
        $this->assertNotNull($conversa);
        $this->assertSame('2026-01-01 10:00:00', $conversa->dt_atualizacao);
        $this->assertSame(0, DB::table('nat_rota_mensagem')->count());
        $this->assertSame([], $this->auditorias);
    }

    /** @template T of object
     * @param  class-string<T>  $classe
     * @return T
     */
    private function repository(string $classe): object
    {
        $reflexao = new ReflectionClass($classe);
        if (($reflexao->getConstructor()?->getNumberOfRequiredParameters() ?? 0) === 0) {
            return $reflexao->newInstance();
        }

        $auditRepository = new class($this->auditorias) implements AuditLogRepositoryInterface
        {
            public function __construct(private array &$auditorias) {}

            public function inserir(array $payload): void
            {
                $this->auditorias[] = $payload;
            }

            public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
            {
                throw new RuntimeException('Nao utilizado neste teste.');
            }
        };

        return $reflexao->newInstance(new AuditLogService($auditRepository));
    }
}
```
</TESTS_UNIT_MENSAGERIAPERSISTENCIATECNICATEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MonitoramentoGeralUiTest.php`
## <TESTS_UNIT_MONITORAMENTOGERALUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MonitoramentoGeralUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MonitoramentoGeralUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function tela_expoe_seletor_unico_de_agrupamento(): void
public function javascript_do_monitoramento_geral_suporta_agrupamento_por_rota(): void
$this->assertStringContainsString('function criarCardGrupo(', $conteudo);
$this->assertStringContainsString('function aplicarFiltrosComQuebraPorRota(', $conteudo);
$this->assertStringContainsString('function aplicarFiltrosComQuebraPorMunicipio(', $conteudo);
$this->assertStringContainsString('function aplicarFiltrosComQuebraPorLocalTransmissao(', $conteudo);
$this->assertStringContainsString('function atualizarResumoVisualRotas()', $conteudo);
$this->assertStringContainsString('function resumoSelecaoMunicipios()', $conteudo);
$this->assertStringContainsString('function atualizarResumoVisualMunicipios()', $conteudo);
$this->assertStringContainsString('async function mostrarEquipeRota(rotaId, rotaTitulo)', $conteudo);
$this->assertStringContainsString('function atualizarResumoVisualSelect(select, resumoTexto, summaryClass)', $conteudo);
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

class MonitoramentoGeralUiTest extends TestCase
{
    #[Test]
    public function tela_expoe_seletor_unico_de_agrupamento(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/monitoramento-geral.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="monitoramentoAgrupamento"', $conteudo);
        $this->assertStringContainsString('Agrupar por', $conteudo);
        $this->assertStringContainsString('<option value="zona" selected>Zona</option>', $conteudo);
        $this->assertStringContainsString('<option value="rota">Rota</option>', $conteudo);
        $this->assertStringContainsString('<option value="municipio">Município</option>', $conteudo);
        $this->assertStringContainsString('<option value="local_transmissao">Local de transmissão</option>', $conteudo);
        $this->assertStringContainsString('id="monitoramentoCardsPorLinha"', $conteudo);
        $this->assertStringContainsString('Cards por linha', $conteudo);
        $this->assertStringContainsString('data-select-all-municipios', $conteudo);
        $this->assertStringContainsString('data-clear-municipios', $conteudo);
        $this->assertStringContainsString('data-select-all-rotas', $conteudo);
        $this->assertStringContainsString('data-clear-rotas', $conteudo);
        $this->assertStringContainsString('id="monitoramentoEquipeModal"', $conteudo);
        $this->assertStringContainsString("rotaEquipe: '{{ route('lda.rotas.equipe', ['id' => '__ID__']) }}'", $conteudo);
        $this->assertStringContainsString("asset('css/lda-monitoramento-geral.css') }}?v={{ filemtime(public_path('css/lda-monitoramento-geral.css')) }}", $conteudo);
        $this->assertStringContainsString("asset('js/lda-monitoramento-geral.js') }}?v={{ filemtime(public_path('js/lda-monitoramento-geral.js')) }}", $conteudo);
    }

    #[Test]
    public function javascript_do_monitoramento_geral_suporta_agrupamento_por_rota(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-monitoramento-geral.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("const agrupamento = document.getElementById('monitoramentoAgrupamento');", $conteudo);
        $this->assertStringContainsString("const cardsPorLinha = document.getElementById('monitoramentoCardsPorLinha');", $conteudo);
        $this->assertStringContainsString("const botaoSelecionarTodosMunicipios = document.querySelector('[data-select-all-municipios]');", $conteudo);
        $this->assertStringContainsString("const botaoLimparMunicipios = document.querySelector('[data-clear-municipios]');", $conteudo);
        $this->assertStringContainsString("const botaoSelecionarTodasRotas = document.querySelector('[data-select-all-rotas]');", $conteudo);
        $this->assertStringContainsString("const botaoLimparRotas = document.querySelector('[data-clear-rotas]');", $conteudo);
        $this->assertStringContainsString('function criarCardGrupo(', $conteudo);
        $this->assertStringContainsString('function aplicarFiltrosComQuebraPorRota(', $conteudo);
        $this->assertStringContainsString('function aplicarFiltrosComQuebraPorMunicipio(', $conteudo);
        $this->assertStringContainsString('function aplicarFiltrosComQuebraPorLocalTransmissao(', $conteudo);
        $this->assertStringContainsString('function atualizarResumoVisualRotas()', $conteudo);
        $this->assertStringContainsString('function resumoSelecaoMunicipios()', $conteudo);
        $this->assertStringContainsString('function atualizarResumoVisualMunicipios()', $conteudo);
        $this->assertStringContainsString('async function mostrarEquipeRota(rotaId, rotaTitulo)', $conteudo);
        $this->assertStringContainsString('zona_numero: zona.num_zona,', $conteudo);
        $this->assertStringContainsString('const contextoZona = {', $conteudo);
        $this->assertStringContainsString("botaoEquipe.title = 'Listar equipe da rota';", $conteudo);
        $this->assertStringContainsString("mostrarEquipeRota(rotaId, tituloTexto)", $conteudo);
        $this->assertStringContainsString('.forEach(([grupoRotaId, grupo]) => {', $conteudo);
        $this->assertStringContainsString('Number(grupoRotaId)', $conteudo);
        $this->assertStringContainsString('grid.style.gridTemplateColumns = `repeat(${quantidade}, minmax(0, 1fr))`;', $conteudo);
        $this->assertStringContainsString('return `${quantidade} rotas selecionadas`;', $conteudo);
        $this->assertStringContainsString('return `${quantidade} municípios selecionados`;', $conteudo);
        $this->assertStringContainsString('function atualizarResumoVisualSelect(select, resumoTexto, summaryClass)', $conteudo);
        $this->assertStringContainsString('atualizarResumoVisualSelect(filtroMunicipio, resumoSelecaoMunicipios, \'monitoramento-municipios-summary-active\');', $conteudo);
        $this->assertStringContainsString('atualizarResumoVisualSelect(filtroRota, resumoSelecaoRotas, \'monitoramento-rotas-summary-active\');', $conteudo);
        $this->assertStringContainsString("botaoSelecionarTodosMunicipios.addEventListener('click'", $conteudo);
        $this->assertStringContainsString("botaoLimparMunicipios.addEventListener('click'", $conteudo);
        $this->assertStringContainsString("botaoSelecionarTodasRotas.addEventListener('click'", $conteudo);
        $this->assertStringContainsString("botaoLimparRotas.addEventListener('click'", $conteudo);
        $this->assertStringContainsString('Selecione ao menos uma rota para quebrar o monitoramento.', $conteudo);
        $this->assertStringContainsString("if (agrupamento?.value === 'rota') {", $conteudo);
        $this->assertStringContainsString("if (agrupamento?.value === 'municipio') {", $conteudo);
        $this->assertStringContainsString("if (agrupamento?.value === 'local_transmissao') {", $conteudo);
        $this->assertStringContainsString('Sem local de transmissão', $conteudo);
        $this->assertStringContainsString('__LDA__', $conteudo);
        $this->assertStringContainsString("titulo: 'LDA'", $conteudo);
        $this->assertStringContainsString('local.lda_id !== null', $conteudo);
        $this->assertStringContainsString("agrupamento.addEventListener('change', aplicarFiltros);", $conteudo);
        $this->assertStringContainsString("cardsPorLinha.addEventListener('change', atualizarGradeCards);", $conteudo);
    }
}
```
</TESTS_UNIT_MONITORAMENTOGERALUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MonitoramentoMapaDashboardFiltrosTest.php`
## <TESTS_UNIT_MONITORAMENTOMAPADASHBOARDFILTROSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MonitoramentoMapaDashboardFiltrosTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MonitoramentoMapaDashboardFiltrosTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_do_dashboard_expoe_filtros_de_secoes_e_exclusao_de_lda(): void
public function javascript_do_dashboard_envia_filtros_ao_endpoint_de_dados(): void
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

class MonitoramentoMapaDashboardFiltrosTest extends TestCase
{
    #[Test]
    public function view_do_dashboard_expoe_filtros_de_secoes_e_exclusao_de_lda(): void
    {
        $conteudo = file_get_contents(resource_path('views/cadastro_eleitoral/monitoramento-mapa-dashboard.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="filtroDashboardSomenteComSecoes"', $conteudo);
        $this->assertStringContainsString('name="somente_com_secoes"', $conteudo);
        $this->assertStringContainsString('Mostrar somente locais com seções', $conteudo);
        $this->assertStringContainsString('id="filtroDashboardExcluirLda"', $conteudo);
        $this->assertStringContainsString('name="excluir_lda"', $conteudo);
        $this->assertStringContainsString('Excluir LDA', $conteudo);
        $this->assertStringContainsString('id="btnAplicarFiltrosDashboard"', $conteudo);
        $this->assertStringContainsString('Aplicar filtros', $conteudo);
    }

    #[Test]
    public function javascript_do_dashboard_envia_filtros_ao_endpoint_de_dados(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-monitoramento-dashboard.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("document.getElementById('filtroDashboardSomenteComSecoes')", $conteudo);
        $this->assertStringContainsString("document.getElementById('filtroDashboardExcluirLda')", $conteudo);
        $this->assertStringContainsString("url.searchParams.set('somente_com_secoes', '1')", $conteudo);
        $this->assertStringContainsString("url.searchParams.set('excluir_lda', '1')", $conteudo);
        $this->assertStringContainsString("document.getElementById('btnAplicarFiltrosDashboard')", $conteudo);
        $this->assertStringContainsString("btnAplicarFiltros.addEventListener('click', carregarDashboard)", $conteudo);
        $this->assertStringNotContainsString("filtroSomenteComSecoes.addEventListener('change', carregarDashboard)", $conteudo);
        $this->assertStringNotContainsString("filtroExcluirLda.addEventListener('change', carregarDashboard)", $conteudo);
    }
}
```
</TESTS_UNIT_MONITORAMENTOMAPADASHBOARDFILTROSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MonitoramentoMapaLegendaToggleTest.php`
## <TESTS_UNIT_MONITORAMENTOMAPALEGENDATOGGLETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MonitoramentoMapaLegendaToggleTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MonitoramentoMapaLegendaToggleTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_do_monitoramento_mapa_expoe_toggle_da_legenda(): void
public function css_compartilhado_define_estado_recolhido_da_legenda_classica(): void
public function js_do_monitoramento_mapa_controla_o_toggle_da_legenda(): void
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

class MonitoramentoMapaLegendaToggleTest extends TestCase
{
    #[Test]
    public function view_do_monitoramento_mapa_expoe_toggle_da_legenda(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/monitoramento-mapa.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('id="monitoramentoMapaLegenda"', $conteudo);
        $this->assertStringContainsString('id="monitoramentoMapaLegendaToggle"', $conteudo);
        $this->assertStringContainsString('id="monitoramentoMapaLegendaConteudo"', $conteudo);
        $this->assertStringNotContainsString('id="monitoramentoMapaLegendaLista"', $conteudo);
    }

    #[Test]
    public function css_compartilhado_define_estado_recolhido_da_legenda_classica(): void
    {
        $conteudo = file_get_contents(public_path('css/lda-mapa.css'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('.lda-mapa-legenda-toggle {', $conteudo);
        $this->assertStringContainsString('.lda-mapa-legenda-list.is-collapsed .legend-body {', $conteudo);
    }

    #[Test]
    public function js_do_monitoramento_mapa_controla_o_toggle_da_legenda(): void
    {
        $conteudo = file_get_contents(public_path('js/lda-monitoramento-mapa.js'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("document.getElementById('monitoramentoMapaLegenda')", $conteudo);
        $this->assertStringContainsString("document.getElementById('monitoramentoMapaLegendaToggle')", $conteudo);
        $this->assertStringContainsString("document.getElementById('monitoramentoMapaLegendaConteudo')", $conteudo);
        $this->assertStringNotContainsString("document.getElementById('monitoramentoMapaLegendaLista')", $conteudo);
        $this->assertStringContainsString("legendaElement.classList.toggle('is-collapsed')", $conteudo);
    }
}
```
</TESTS_UNIT_MONITORAMENTOMAPALEGENDATOGGLETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MrjApresentacaoTest.php`
## <TESTS_UNIT_MRJAPRESENTACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MrjApresentacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MrjApresentacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_normaliza_tipos_oficiais_e_tipo_desconhecido(): void
public function test_formata_badge_pdf_e_tooltip_sem_confundir_mrj_com_secao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\LocaisVotacao\MrjApresentacao;
use Tests\TestCase;

class MrjApresentacaoTest extends TestCase
{
    public function test_normaliza_tipos_oficiais_e_tipo_desconhecido(): void
    {
        $this->assertSame('Convencional', MrjApresentacao::tipo(1));
        $this->assertSame('Preso provisório', MrjApresentacao::tipo(2));
        $this->assertSame('Sem urna', MrjApresentacao::tipo(3));
        $this->assertSame('Tipo desconhecido', MrjApresentacao::tipo(9));
        $this->assertSame('Tipo não informado', MrjApresentacao::tipo(null));
    }

    public function test_formata_badge_pdf_e_tooltip_sem_confundir_mrj_com_secao(): void
    {
        $mrj = (object) [
            'num_mesa' => 904,
            'tip_mrj' => 3,
            'dat_eleicao' => '2026-10-04 00:00:00',
        ];

        $this->assertSame('MRJ 904', MrjApresentacao::badge($mrj));
        $this->assertSame('MRJ 904 — Sem urna', MrjApresentacao::textoPdf($mrj));
        $this->assertSame(
            'Mesa Receptora de Justificativa 904 · Sem urna · 04/10/2026',
            MrjApresentacao::tooltip($mrj)
        );
    }
}
```
</TESTS_UNIT_MRJAPRESENTACAOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MrjControllerContainerTest.php`
## <TESTS_UNIT_MRJCONTROLLERCONTAINERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MrjControllerContainerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MrjControllerContainerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_container_injeta_resolvedor_de_data_nos_tres_consumidores_de_mrj(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\LocaisVotacao\DashboardLocaisVotacaoController;
use App\Http\Controllers\ForcasSeguranca\ForcasSegurancaLocalVotacaoController;
use App\Http\Controllers\LocaisVotacao\LocalVotacaoCrudController;
use App\Services\Planejamento\MacroprojetoTurnoDataEleicaoService;
use ReflectionProperty;
use Tests\TestCase;

class MrjControllerContainerTest extends TestCase
{
    public function test_container_injeta_resolvedor_de_data_nos_tres_consumidores_de_mrj(): void
    {
        foreach ([
            LocalVotacaoCrudController::class,
            DashboardLocaisVotacaoController::class,
            ForcasSegurancaLocalVotacaoController::class,
        ] as $classe) {
            $controller = $this->app->make($classe);
            $propriedade = new ReflectionProperty($classe, 'macroprojetoTurnoDataEleicaoService');

            $this->assertInstanceOf(
                MacroprojetoTurnoDataEleicaoService::class,
                $propriedade->getValue($controller),
                $classe
            );
        }
    }
}
```
</TESTS_UNIT_MRJCONTROLLERCONTAINERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/MrjMigrationContractTest.php`
## <TESTS_UNIT_MRJMIGRATIONCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/MrjMigrationContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class MrjMigrationContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_migration_cria_snapshot_staging_chave_e_indice_de_consulta(): void
public function test_migration_acl_vincula_rota_mrj_exclusivamente_ao_planeleito_admin(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class MrjMigrationContractTest extends TestCase
{
    public function test_migration_cria_snapshot_staging_chave_e_indice_de_consulta(): void
    {
        $migration = (string) file_get_contents(database_path('migrations/2026_08_05_120000_create_mrj_sync_tables.php'));
        $sql = mb_strtolower($migration);

        $this->assertStringContainsString('create table mrj_sync_stage', $sql);
        $this->assertStringContainsString('create table mrj', $sql);
        $this->assertStringContainsString('constraint pk_mrj primary key (cod_objeto)', $sql);
        $this->assertStringContainsString('create index ix_mrj_local_eleicao_pub', $sql);
        $this->assertStringContainsString('(cod_objeto_local_votacao, dat_eleicao, ind_publico)', $sql);
        $this->assertStringNotContainsString('foreign key', $sql);

        foreach (['cod_objeto', 'num_mesa', 'cod_objeto_zona', 'num_zona', 'cod_objeto_municipio',
            'cod_objeto_dat_eleicao', 'dat_eleicao', 'tip_mrj', 'ind_publico',
            'cod_objeto_local_votacao', 'nom_local', 'des_endereco', 'des_observacao', 'dat_criacao'] as $coluna) {
            $this->assertStringContainsString($coluna, $sql);
        }
    }

    public function test_migration_acl_vincula_rota_mrj_exclusivamente_ao_planeleito_admin(): void
    {
        $migration = (string) file_get_contents(database_path('migrations/2026_08_05_121000_register_mrj_sync_acl.php'));

        $this->assertStringContainsString("private const GRUPO_NOME = 'PLANELEITO_ADMIN'", $migration);
        $this->assertStringContainsString("private const ROTA_NOME = 'administracao-global.sync-local-votacao.mrj.executar'", $migration);
        $this->assertStringContainsString("private const ROTA_PATH = 'sincronizacao/local-votacao/mrj/executar'", $migration);
        $this->assertStringNotContainsString('adm_grupo_acesso\')->insert', $migration);
    }
}
```
</TESTS_UNIT_MRJMIGRATIONCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatConversaPolimorficaMigrationTest.php`
## <TESTS_UNIT_NATCONVERSAPOLIMORFICAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatConversaPolimorficaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatConversaPolimorficaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_generaliza_conversa_para_escopo_polimorfico_com_arco_exclusivo(): void
public function migration_cria_trigger_de_bloqueio_de_escrita_em_conversa_arquivada(): void
public function migration_torna_rota_id_nullable_nas_tabelas_de_mensagem_e_leitura(): void
public function migrations_do_fluxo_sao_separadas_por_alteracao(): void
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

class NatConversaPolimorficaMigrationTest extends TestCase
{
    #[Test]
    public function migration_generaliza_conversa_para_escopo_polimorfico_com_arco_exclusivo(): void
    {
        $arquivo = database_path('migrations/2026_06_19_130000_generalize_nat_rota_conversa_escopo_polimorfico.php');
        $this->assertFileExists($arquivo);
        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('ADD (escopo_tipo VARCHAR2(4 CHAR), lda_id NUMBER, turno VARCHAR2(2 CHAR))', $conteudo);
        $this->assertStringContainsString("SET escopo_tipo = 'ROTA' WHERE escopo_tipo IS NULL", $conteudo);
        $this->assertStringContainsString('MODIFY (rota_id NUMBER NULL)', $conteudo);

        $this->assertStringContainsString('fk_nat_conv_lda FOREIGN KEY (lda_id) REFERENCES lda (id)', $conteudo);
        $this->assertStringContainsString("chk_nat_conv_escopo_tipo CHECK (escopo_tipo IN ('ROTA', 'LDA'))", $conteudo);
        $this->assertStringContainsString('chk_nat_conv_arco', $conteudo);
        $this->assertStringContainsString('chk_nat_conv_turno', $conteudo);

        $this->assertStringContainsString('CREATE UNIQUE INDEX uk_nat_conv_ativa_escopo', $conteudo);
        $this->assertStringContainsString('NVL(rota_id, lda_id)', $conteudo);
        $this->assertStringNotContainsString('ADD (escopo_id', $conteudo);

        $this->assertStringContainsString('uk_nat_rota_conversa_ativa', $conteudo);
        $this->assertStringContainsString('DROP (escopo_tipo, lda_id, turno)', $conteudo);
    }

    #[Test]
    public function migration_cria_trigger_de_bloqueio_de_escrita_em_conversa_arquivada(): void
    {
        $arquivo = database_path('migrations/2026_06_19_140000_create_trigger_bloqueio_escrita_conversa_arquivada.php');
        $this->assertFileExists($arquivo);
        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('CREATE OR REPLACE TRIGGER trg_nat_msg_block_arquivada', $conteudo);
        $this->assertStringContainsString('BEFORE INSERT ON nat_rota_mensagem', $conteudo);
        $this->assertStringContainsString('arquivada_em', $conteudo);
        $this->assertStringContainsString('RAISE_APPLICATION_ERROR', $conteudo);
        $this->assertStringContainsString('DROP TRIGGER trg_nat_msg_block_arquivada', $conteudo);
    }

    #[Test]
    public function migration_torna_rota_id_nullable_nas_tabelas_de_mensagem_e_leitura(): void
    {
        $arquivo = database_path('migrations/2026_06_19_150000_make_rota_id_nullable_on_nat_rota_mensagem.php');
        $this->assertFileExists($arquivo);
        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('ALTER TABLE nat_rota_mensagem MODIFY (rota_id NUMBER NULL)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE nat_rota_mensagem_leitura MODIFY (rota_id NUMBER NULL)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE nat_rota_mensagem_leitura MODIFY (rota_id NUMBER NOT NULL)', $conteudo);
        $this->assertStringContainsString('ALTER TABLE nat_rota_mensagem MODIFY (rota_id NUMBER NOT NULL)', $conteudo);
    }

    #[Test]
    public function migrations_do_fluxo_sao_separadas_por_alteracao(): void
    {
        $dir = database_path('migrations');

        $this->assertFileExists($dir . '/2026_06_19_120000_create_lda_situacao_mesario_table.php');
        $this->assertFileExists($dir . '/2026_06_19_130000_generalize_nat_rota_conversa_escopo_polimorfico.php');
        $this->assertFileExists($dir . '/2026_06_19_140000_create_trigger_bloqueio_escrita_conversa_arquivada.php');
        $this->assertFileExists($dir . '/2026_06_19_150000_make_rota_id_nullable_on_nat_rota_mensagem.php');

        $fases = file_get_contents($dir . '/2026_06_19_120000_create_lda_situacao_mesario_table.php');
        $this->assertStringNotContainsString('nat_rota_conversa', $fases);

        $trigger = file_get_contents($dir . '/2026_06_19_140000_create_trigger_bloqueio_escrita_conversa_arquivada.php');
        $this->assertStringNotContainsString('CREATE TABLE', $trigger);
        $this->assertStringNotContainsString('ALTER TABLE', $trigger);

        $nullable = file_get_contents($dir . '/2026_06_19_150000_make_rota_id_nullable_on_nat_rota_mensagem.php');
        $this->assertStringNotContainsString('CREATE TABLE', $nullable);
        $this->assertStringNotContainsString('CREATE TRIGGER', $nullable);
    }
}
```
</TESTS_UNIT_NATCONVERSAPOLIMORFICAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatExternoLayoutUiTest.php`
## <TESTS_UNIT_NATEXTERNOLAYOUTUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatExternoLayoutUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatExternoLayoutUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function layout_externo_do_nat_usa_barra_superior_compacta_com_nome_truncavel(): void
public function layout_externo_do_nat_mostra_rotas_no_titulo_superior_quando_disponiveis(): void
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

class NatExternoLayoutUiTest extends TestCase
{
    #[Test]
    public function layout_externo_do_nat_usa_barra_superior_compacta_com_nome_truncavel(): void
    {
        $conteudo = file_get_contents(resource_path('views/layouts/nat-externo-publico.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('.nat-ext-brandcopy', $conteudo);
        $this->assertStringContainsString('.nat-ext-logout', $conteudo);
        $this->assertStringContainsString('text-overflow: ellipsis;', $conteudo);
        $this->assertStringContainsString('@@media (max-width: 575.98px)', $conteudo);
        $this->assertStringContainsString('font-size: 0.78rem;', $conteudo);
    }

    #[Test]
    public function layout_externo_do_nat_mostra_rotas_no_titulo_superior_quando_disponiveis(): void
    {
        $conteudo = file_get_contents(resource_path('views/layouts/nat-externo-publico.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('topoRotasLabel', $conteudo);
        $this->assertStringContainsString('NAT -', $conteudo);
    }
}
```
</TESTS_UNIT_NATEXTERNOLAYOUTUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatOcorrenciaBadgeServiceTest.php`
## <TESTS_UNIT_NATOCORRENCIABADGESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatOcorrenciaBadgeServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatOcorrenciaBadgeServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_resumo_exibe_total_aberto_e_total_novo_para_notificacao(): void
public function test_marcar_visualizadas_atualiza_marco_por_rota_sem_reduzir_valor_existente(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Services\Nat\NatOcorrenciaBadgeService;
use Illuminate\Http\Request;
use Illuminate\Session\ArraySessionHandler;
use Illuminate\Session\Store;
use Mockery;
use PHPUnit\Framework\TestCase;

class NatOcorrenciaBadgeServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_resumo_exibe_total_aberto_e_total_novo_para_notificacao(): void
    {
        $request = Request::create('/nat/rotas/painel');
        $request->setLaravelSession(new Store('testing', new ArraySessionHandler(120)));
        $request->session()->put('nat_ocorrencias_visualizadas_por_rota', [
            39 => 400,
            40 => 250,
        ]);

        $repository = Mockery::mock(NatOcorrenciaRepository::class);
        $repository->shouldReceive('contarNaoFinalizadasPorRotas')
            ->once()
            ->with([39, 40], [9], false)
            ->andReturn(7);
        $repository->shouldReceive('contarNovasNaoFinalizadasPorRotas')
            ->once()
            ->with([39, 40], [39 => 400, 40 => 250], [9], false)
            ->andReturn(3);

        $service = new NatOcorrenciaBadgeService($repository);

        $resumo = $service->resumo(
            [['id' => 39], ['id' => 40]],
            [9],
            false,
            $request
        );

        $this->assertSame([
            'total_abertas' => 7,
            'total_novas' => 3,
        ], $resumo);
    }

    public function test_marcar_visualizadas_atualiza_marco_por_rota_sem_reduzir_valor_existente(): void
    {
        $request = Request::create('/nat/rotas/painel?aba=ocorrencias');
        $request->setLaravelSession(new Store('testing', new ArraySessionHandler(120)));
        $request->session()->put('nat_ocorrencias_visualizadas_por_rota', [
            39 => 500,
            40 => 250,
        ]);

        $repository = Mockery::mock(NatOcorrenciaRepository::class);
        $repository->shouldReceive('maiorNaoFinalizadaPorRotas')
            ->once()
            ->with([39, 40], [9], false)
            ->andReturn([
                39 => 450,
                40 => 300,
            ]);

        $service = new NatOcorrenciaBadgeService($repository);

        $service->marcarVisualizadas(
            [['id' => 39], ['id' => 40]],
            [9],
            false,
            $request
        );

        $this->assertSame([
            39 => 500,
            40 => 300,
        ], $request->session()->get('nat_ocorrencias_visualizadas_por_rota'));
    }
}
```
</TESTS_UNIT_NATOCORRENCIABADGESERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatOcorrenciaBadgeUiTest.php`
## <TESTS_UNIT_NATOCORRENCIABADGEUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatOcorrenciaBadgeUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatOcorrenciaBadgeUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function painel_tem_badge_de_ocorrencias_abertas_no_botao_ocorrencias(): void
public function javascript_exibe_ocorrencias_abertas_e_toca_som_apenas_para_novas(): void
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

class NatOcorrenciaBadgeUiTest extends TestCase
{
    #[Test]
    public function painel_tem_badge_de_ocorrencias_abertas_no_botao_ocorrencias(): void
    {
        $conteudo = file_get_contents(resource_path('views/nat/rotas/painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('natOcorrenciasBadge', $conteudo);
        $this->assertStringContainsString('ocorrenciasResumo', $conteudo);
        $this->assertStringContainsString('ocorrenciasResumo: ', $conteudo);
        $this->assertStringContainsString("['total_abertas']", $conteudo);
        $this->assertStringContainsString('data-total-abertas', $conteudo);
        $this->assertStringContainsString('data-total-novas', $conteudo);
        $this->assertStringNotContainsString('small fw-semibold text-muted', $conteudo);
    }

    #[Test]
    public function javascript_exibe_ocorrencias_abertas_e_toca_som_apenas_para_novas(): void
    {
        foreach ([
            public_path('js/nat-rotas-painel.js'),
            public_path('rotas-publicas/js/nat-rotas-painel.js'),
        ] as $arquivo) {
            $conteudo = file_get_contents($arquivo);

            $this->assertIsString($conteudo);
            $this->assertStringContainsString('atualizarResumoOcorrencias', $conteudo);
            $this->assertStringContainsString('natOcorrenciasBadge', $conteudo);
            $this->assertStringContainsString('totalAbertasOcorrenciasAtual', $conteudo);
            $this->assertStringContainsString('totalNovasOcorrenciasAtual', $conteudo);
            $this->assertStringContainsString('const totalAbertas = Number(payload.total_abertas || 0);', $conteudo);
            $this->assertStringContainsString('const totalNovas = Number(payload.total_novas || 0);', $conteudo);
            $this->assertStringContainsString("if (abaAtual !== 'ocorrencias' && totalNovas > totalNovasOcorrenciasAtual)", $conteudo);
            $this->assertStringContainsString('atualizarBadgeOcorrencias(totalAbertas, totalNovas);', $conteudo);
            $this->assertStringNotContainsString("atualizarBadgeOcorrencias(abaAtual === 'ocorrencias' ? 0 : novoTotal);", $conteudo);
        }
    }
}
```
</TESTS_UNIT_NATOCORRENCIABADGEUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/OpcaoBinariaControllerTest.php`
## <TESTS_UNIT_OPCAOBINARIACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/OpcaoBinariaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class OpcaoBinariaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_opcoes_ordenadas(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\TabelasAuxiliares\OpcaoBinariaController;
use App\Repositories\TabelasAuxiliares\OpcaoBinariaRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class OpcaoBinariaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_opcoes_ordenadas(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'codigo' => 'SIM', 'descricao' => 'Sim', 'ordem' => 10]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/opcoes-binarias']
        );

        $repository = Mockery::mock(OpcaoBinariaRepository::class);
        $repository->shouldReceive('listar')->once()->with(null)->andReturn($paginator);

        $controller = new OpcaoBinariaController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/opcoes-binarias', 'GET'));

        $this->assertSame('tabelas-auxiliares.opcoes-binarias.index', $response->name());
        $this->assertCount(1, $response->getData()['opcoes']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        $registro = (object) ['id' => 7, 'codigo' => 'NAO', 'descricao' => 'Não', 'ordem' => 20];
        $repository = Mockery::mock(OpcaoBinariaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(7)->andReturn($registro);

        $controller = Mockery::mock(OpcaoBinariaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(7);

        $this->assertSame('tabelas-auxiliares.opcoes-binarias.form', $response->name());
        $this->assertSame($registro, $response->getData()['opcao']);
    }
}
```
</TESTS_UNIT_OPCAOBINARIACONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/OpcaoBinariaMigrationTest.php`
## <TESTS_UNIT_OPCAOBINARIAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/OpcaoBinariaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class OpcaoBinariaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_auxiliar_de_opcao_binaria_com_id_descricao_e_ordem(): void
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

class OpcaoBinariaMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_auxiliar_de_opcao_binaria_com_id_descricao_e_ordem(): void
    {
        $arquivo = database_path('migrations/2026_06_20_110000_create_opcao_binaria_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('CREATE TABLE opcao_binaria', $conteudo);
        $this->assertStringContainsString('id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY', $conteudo);
        $this->assertStringContainsString('descricao         VARCHAR2(160 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('ordem             NUMBER DEFAULT 0 NOT NULL', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_ob_descricao ON opcao_binaria (UPPER(descricao))', $conteudo);
        $this->assertStringContainsString('DROP TABLE opcao_binaria', $conteudo);
    }
}
```
</TESTS_UNIT_OPCAOBINARIAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/OpcaoBinariaUiTest.php`
## <TESTS_UNIT_OPCAOBINARIAUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/OpcaoBinariaUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class OpcaoBinariaUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_admin_global_expoe_item_de_opcao_binaria_em_tabelas_auxiliares(): void
public function index_e_formulario_do_crud_de_opcao_binaria_expoem_campos_de_dominio(): void
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

class OpcaoBinariaUiTest extends TestCase
{
    #[Test]
    public function menu_admin_global_expoe_item_de_opcao_binaria_em_tabelas_auxiliares(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Opção Binária'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.opcoes-binarias.index'", $conteudo);
        $this->assertStringContainsString("'route_patterns' => ['tabelas-auxiliares.opcoes-binarias.*']", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Administração Global > Tabelas Auxiliares > Opção Binária'", $conteudo);
    }

    #[Test]
    public function index_e_formulario_do_crud_de_opcao_binaria_expoem_campos_de_dominio(): void
    {
        $index = file_get_contents(resource_path('views/tabelas-auxiliares/opcoes-binarias/index.blade.php'));
        $form = file_get_contents(resource_path('views/tabelas-auxiliares/opcoes-binarias/form.blade.php'));

        $this->assertIsString($index);
        $this->assertIsString($form);

        $this->assertStringContainsString('Opção Binária', $index);
        $this->assertStringContainsString('Descrição', $index);
        $this->assertStringContainsString('Código', $index);
        $this->assertStringContainsString('Ordem', $index);
        $this->assertStringContainsString("route('tabelas-auxiliares.opcoes-binarias.form')", $index);

        $this->assertStringContainsString('codigo', $form);
        $this->assertStringContainsString('descricao', $form);
        $this->assertStringContainsString('ordem', $form);
    }
}
```
</TESTS_UNIT_OPCAOBINARIAUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/OperadoraControllerTest.php`
## <TESTS_UNIT_OPERADORACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/OperadoraControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class OperadoraControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_operadoras_ordenadas(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\TabelasAuxiliares\OperadoraController;
use App\Repositories\TabelasAuxiliares\OperadoraRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class OperadoraControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_operadoras_ordenadas(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'codigo' => 'VIVO', 'descricao' => 'Vivo', 'ordem' => 1]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/operadoras']
        );

        $repository = Mockery::mock(OperadoraRepository::class);
        $repository->shouldReceive('listar')->once()->with(null)->andReturn($paginator);

        $controller = new OperadoraController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/operadoras', 'GET'));

        $this->assertSame('tabelas-auxiliares.operadoras.index', $response->name());
        $this->assertCount(1, $response->getData()['operadoras']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        $registro = (object) ['id' => 2, 'codigo' => 'CLARO', 'descricao' => 'Claro', 'ordem' => 2];
        $repository = Mockery::mock(OperadoraRepository::class);
        $repository->shouldReceive('buscar')->once()->with(2)->andReturn($registro);

        $controller = Mockery::mock(OperadoraController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(2);

        $this->assertSame('tabelas-auxiliares.operadoras.form', $response->name());
        $this->assertSame($registro, $response->getData()['operadora']);
    }
}
```
</TESTS_UNIT_OPERADORACONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/OperadoraMigrationTest.php`
## <TESTS_UNIT_OPERADORAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/OperadoraMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class OperadoraMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_operadora_com_codigo_descricao_ordem_e_semente(): void
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

class OperadoraMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_operadora_com_codigo_descricao_ordem_e_semente(): void
    {
        $arquivo = database_path('migrations/2026_06_20_150000_create_operadora_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('CREATE TABLE operadora', $conteudo);
        $this->assertStringContainsString('codigo            VARCHAR2(20 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('descricao         VARCHAR2(160 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('ordem             NUMBER DEFAULT 0 NOT NULL', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_operadora_codigo ON operadora (UPPER(codigo))', $conteudo);
        $this->assertStringContainsString('DROP TABLE operadora', $conteudo);

        foreach (['VIVO', 'CLARO', 'TIM'] as $codigo) {
            $this->assertStringContainsString("'codigo' => '{$codigo}'", $conteudo);
        }
    }
}
```
</TESTS_UNIT_OPERADORAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/OperadoraTipoSinalUiTest.php`
## <TESTS_UNIT_OPERADORATIPOSINALUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/OperadoraTipoSinalUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class OperadoraTipoSinalUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_admin_global_expoe_itens_de_operadora_e_tipo_sinal(): void
public function formularios_dos_cruds_expoem_campos_de_dominio(): void
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

class OperadoraTipoSinalUiTest extends TestCase
{
    #[Test]
    public function menu_admin_global_expoe_itens_de_operadora_e_tipo_sinal(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);

        $this->assertStringContainsString("'label' => 'Operadora'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.operadoras.index'", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Administração Global > Tabelas Auxiliares > Operadora'", $conteudo);

        $this->assertStringContainsString("'label' => 'Tipo de Sinal'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.tipos-sinal.index'", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Administração Global > Tabelas Auxiliares > Tipo de Sinal'", $conteudo);
    }

    #[Test]
    public function formularios_dos_cruds_expoem_campos_de_dominio(): void
    {
        $operadora = file_get_contents(resource_path('views/tabelas-auxiliares/operadoras/form.blade.php'));
        $tipoSinal = file_get_contents(resource_path('views/tabelas-auxiliares/tipos-sinal/form.blade.php'));

        foreach ([$operadora, $tipoSinal] as $form) {
            $this->assertIsString($form);
            $this->assertStringContainsString('codigo', $form);
            $this->assertStringContainsString('descricao', $form);
            $this->assertStringContainsString('ordem', $form);
        }
    }
}
```
</TESTS_UNIT_OPERADORATIPOSINALUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/QualidadeControllerTest.php`
## <TESTS_UNIT_QUALIDADECONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/QualidadeControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class QualidadeControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_qualidades_ordenadas(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\TabelasAuxiliares\QualidadeController;
use App\Repositories\TabelasAuxiliares\QualidadeRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class QualidadeControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_qualidades_ordenadas(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'codigo' => 'OTIMA', 'descricao' => 'Ótima', 'ordem' => 1]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/qualidades']
        );

        $repository = Mockery::mock(QualidadeRepository::class);
        $repository->shouldReceive('listar')->once()->with(null)->andReturn($paginator);

        $controller = new QualidadeController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/qualidades', 'GET'));

        $this->assertSame('tabelas-auxiliares.qualidades.index', $response->name());
        $this->assertCount(1, $response->getData()['qualidades']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        $registro = (object) ['id' => 4, 'codigo' => 'RUIM', 'descricao' => 'Ruim', 'ordem' => 4];
        $repository = Mockery::mock(QualidadeRepository::class);
        $repository->shouldReceive('buscar')->once()->with(4)->andReturn($registro);

        $controller = Mockery::mock(QualidadeController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(4);

        $this->assertSame('tabelas-auxiliares.qualidades.form', $response->name());
        $this->assertSame($registro, $response->getData()['qualidade']);
    }
}
```
</TESTS_UNIT_QUALIDADECONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/QualidadeMigrationTest.php`
## <TESTS_UNIT_QUALIDADEMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/QualidadeMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class QualidadeMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_qualidade_com_codigo_descricao_ordem_e_semente(): void
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

class QualidadeMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_qualidade_com_codigo_descricao_ordem_e_semente(): void
    {
        $arquivo = database_path('migrations/2026_06_20_140000_create_qualidade_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('CREATE TABLE qualidade', $conteudo);
        $this->assertStringContainsString('id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY', $conteudo);
        $this->assertStringContainsString('codigo            VARCHAR2(20 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('descricao         VARCHAR2(160 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('ordem             NUMBER DEFAULT 0 NOT NULL', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_qualidade_codigo ON qualidade (UPPER(codigo))', $conteudo);
        $this->assertStringContainsString('DROP TABLE qualidade', $conteudo);

        // Semente canonica do dominio.
        foreach (['OTIMA', 'BOA', 'REGULAR', 'RUIM', 'INEXISTENTE'] as $codigo) {
            $this->assertStringContainsString("'codigo' => '{$codigo}'", $conteudo);
        }
    }
}
```
</TESTS_UNIT_QUALIDADEMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/QualidadeUiTest.php`
## <TESTS_UNIT_QUALIDADEUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/QualidadeUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class QualidadeUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_admin_global_expoe_item_de_qualidade_em_tabelas_auxiliares(): void
public function index_e_formulario_do_crud_de_qualidade_expoem_campos_de_dominio(): void
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

class QualidadeUiTest extends TestCase
{
    #[Test]
    public function menu_admin_global_expoe_item_de_qualidade_em_tabelas_auxiliares(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Qualidade'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.qualidades.index'", $conteudo);
        $this->assertStringContainsString("'route_patterns' => ['tabelas-auxiliares.qualidades.*']", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Administração Global > Tabelas Auxiliares > Qualidade'", $conteudo);
    }

    #[Test]
    public function index_e_formulario_do_crud_de_qualidade_expoem_campos_de_dominio(): void
    {
        $index = file_get_contents(resource_path('views/tabelas-auxiliares/qualidades/index.blade.php'));
        $form = file_get_contents(resource_path('views/tabelas-auxiliares/qualidades/form.blade.php'));

        $this->assertIsString($index);
        $this->assertIsString($form);

        $this->assertStringContainsString('Qualidade', $index);
        $this->assertStringContainsString('Código', $index);
        $this->assertStringContainsString('Ordem', $index);
        $this->assertStringContainsString("route('tabelas-auxiliares.qualidades.form')", $index);

        $this->assertStringContainsString('codigo', $form);
        $this->assertStringContainsString('descricao', $form);
        $this->assertStringContainsString('ordem', $form);
    }
}
```
</TESTS_UNIT_QUALIDADEUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/QueryResultLimitGuardrailTest.php`
## <TESTS_UNIT_QUERYRESULTLIMITGUARDRAILTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/QueryResultLimitGuardrailTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class QueryResultLimitGuardrailTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_limites_de_resultado_exigem_contrato_e_excecao_documentada(): void
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
use Tests\TestCase;

class QueryResultLimitGuardrailTest extends TestCase
{
    public function test_limites_de_resultado_exigem_contrato_e_excecao_documentada(): void
    {
        $agents = file_get_contents(base_path('AGENTS.md'));

        $this->assertIsString($agents);
        $this->assertStringContainsString('## Diretriz de limites de resultado', $agents);
        $this->assertStringContainsString('Nao adicionar `limit`, `take`, `ROWNUM`, `FETCH FIRST` ou corte equivalente', $agents);
        $this->assertStringContainsString('paginacao explicita', $agents);
        $this->assertStringContainsString('autocomplete ou busca incremental, como `Select2`', $agents);
        $this->assertStringContainsString('processamento operacional em lote', $agents);
        $this->assertStringContainsString('perguntar explicitamente ao usuario antes de criar o limite', $agents);

        $excecoes = [
            ['arquivo' => 'routes/console.php', 'padrao' => '/\$query->limit\(\$limit\)->get\(\)/', 'quantidade' => 1, 'justificativa' => 'Lote configuravel de reprocessamento operacional.'],
            ['arquivo' => 'app/Http/Controllers/ColaboradoresEleitorais/ColaboradorEleitoralController.php', 'padrao' => '/->limit\(20\)/', 'quantidade' => 1, 'justificativa' => 'Busca incremental de participantes via Select2.'],
            ['arquivo' => 'app/Repositories/Lda/LocalDificilAcessoRepository.php', 'padrao' => '/FETCH FIRST 1 ROWS ONLY/', 'quantidade' => 1, 'justificativa' => 'Consulta de existencia de conflito.'],
            ['arquivo' => 'app/Repositories/Lda/LocalDificilAcessoRepository.php', 'padrao' => '/AND ROWNUM <= 50/', 'quantidade' => 1, 'justificativa' => 'Busca incremental de locais.'],
            ['arquivo' => 'app/Repositories/Nat/NatLocalSecaoRepository.php', 'padrao' => '/->limit\(\$limite\)->get\(\)/', 'quantidade' => 1, 'justificativa' => 'Autocomplete de locais.'],
            ['arquivo' => 'app/Repositories/SupervisoresPredio/CadastroSupervisorPredioRepository.php', 'padrao' => '/AND ROWNUM <= 50/', 'quantidade' => 1, 'justificativa' => 'Autocomplete publico de locais.'],
            ['arquivo' => 'app/Repositories/ColaboradoresEleitorais/CoordenadorAcessibilidadeRepository.php', 'padrao' => '/AND ROWNUM <= 50/', 'quantidade' => 1, 'justificativa' => 'Autocomplete administrativo de locais de atuacao.'],
            ['arquivo' => 'app/Repositories/SupervisoresPredio/CadastroSupervisorPredioRepository.php', 'padrao' => '/->limit\(50\)->get\(\)->map\(static fn \(\$item\) => \[/', 'quantidade' => 1, 'justificativa' => 'Autocomplete de bancos.'],
            ['arquivo' => 'app/Repositories/CadastroEleitoral/CadastroEleitoralFilaPainelRepository.php', 'padrao' => '/->limit\(max\(1, \$limite\)\)/', 'quantidade' => 1, 'justificativa' => 'Historico visual com quantidade configurada.'],
            ['arquivo' => 'app/Repositories/Lda/LocalTransmissaoRepository.php', 'padrao' => '/AND ROWNUM <= 50/', 'quantidade' => 2, 'justificativa' => 'Buscas incrementais de bairro e local.'],
            ['arquivo' => 'app/Repositories/CadastroEleitoral/CadastroEleitoralAgendamentoRepository.php', 'padrao' => '/->limit\(\$limite\)/', 'quantidade' => 1, 'justificativa' => 'Consulta explicitamente contratada como registros recentes.'],
            ['arquivo' => 'app/Services/SupervisoresPredio/CadastroSupervisorPredioComunicadoService.php', 'padrao' => '/WHERE ROWNUM <= :limit/', 'quantidade' => 2, 'justificativa' => 'Lotes de enfileiramento e reprocessamento de comunicados.'],
            ['arquivo' => 'app/Repositories/Lda/RotaRepository.php', 'padrao' => '/ROWNUM <= 50/', 'quantidade' => 1, 'justificativa' => 'Busca incremental para vinculacao de local e selecao de polo compartilhado.'],
            ['arquivo' => 'app/Repositories/Lda/RotaRepository.php', 'padrao' => '/->limit\(self::LIMITE_AUTOCOMPLETE\)/', 'quantidade' => 1, 'justificativa' => 'Autocompletes dos filtros da listagem de rotas, limitados a opcoes usadas em rotas visiveis.'],
            ['arquivo' => 'app/Repositories/Lda/VistoriaTransmissaoRepository.php', 'padrao' => '/AND ROWNUM <= 50/', 'quantidade' => 1, 'justificativa' => 'Busca incremental de locais.'],
            ['arquivo' => 'app/Repositories/Nat/NatExternoRepository.php', 'padrao' => '/->limit\(\$limite\)->get\(\)/', 'quantidade' => 1, 'justificativa' => 'Autocomplete externo com escopo de rota.'],
            ['arquivo' => 'app/Repositories/Diarias/DiariasCidadeRepository.php', 'padrao' => '/->limit\(\$limite\)/', 'quantidade' => 1, 'justificativa' => 'Autocomplete incremental de cidades do mundo para origem e destino de Diarias.'],
            ['arquivo' => 'app/Http/Controllers/Diarias/DiariasPainelController.php', 'padrao' => '/->limit\(15\)/', 'quantidade' => 1, 'justificativa' => 'Resumo visual de movimentacoes recentes no painel gerencial de Diarias.'],
            ['arquivo' => 'app/Repositories/Diarias/DiariasAuditoriaSensivelRepository.php', 'padrao' => '/->limit\(max\(1, \$limite\)\)/', 'quantidade' => 1, 'justificativa' => 'Resumo visual de auditoria sensivel recente no painel COCIN de Diarias.'],
        ];

        $ocorrencias = array_fill(0, count($excecoes), 0);
        $naoPermitidas = [];
        $padraoLimite = '/->(?:limit|take)\s*\(|ROWNUM\s*(?:<=|<)|FETCH\s+FIRST|\bLIMIT\s+(?:\d+|:[A-Za-z_][A-Za-z0-9_]*|\?)/i';

        foreach (['app', 'routes'] as $diretorio) {
            $iterator = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator(base_path($diretorio), RecursiveDirectoryIterator::SKIP_DOTS)
            );

            foreach ($iterator as $arquivo) {
                if (! $arquivo->isFile() || $arquivo->getExtension() !== 'php') {
                    continue;
                }

                $caminho = str_replace(base_path().DIRECTORY_SEPARATOR, '', $arquivo->getPathname());
                $linhas = file($arquivo->getPathname());

                foreach ($linhas ?: [] as $numero => $linha) {
                    if (! preg_match($padraoLimite, $linha)) {
                        continue;
                    }

                    $permitida = false;

                    foreach ($excecoes as $indice => $excecao) {
                        if ($excecao['arquivo'] === $caminho && preg_match($excecao['padrao'], $linha)) {
                            $ocorrencias[$indice]++;
                            $permitida = true;
                            break;
                        }
                    }

                    if (! $permitida) {
                        $naoPermitidas[] = $caminho.':'.($numero + 1).' '.trim($linha);
                    }
                }
            }
        }

        $this->assertSame([], $naoPermitidas, "Limites de resultado sem excecao documentada:\n".implode("\n", $naoPermitidas));

        foreach ($excecoes as $indice => $excecao) {
            $this->assertNotSame('', trim($excecao['justificativa']));
            $this->assertSame(
                $excecao['quantidade'],
                $ocorrencias[$indice],
                $excecao['arquivo'].' nao corresponde mais a excecao documentada: '.$excecao['justificativa']
            );
        }
    }
}
```
</TESTS_UNIT_QUERYRESULTLIMITGUARDRAILTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RecursoLogisticoLazyLoadTest.php`
## <TESTS_UNIT_RECURSOLOGISTICOLAZYLOADTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RecursoLogisticoLazyLoadTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RecursoLogisticoLazyLoadTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function listagens_exibem_olhinho_de_recursos_logisticos_no_painel_compartilhado(): void
public function endpoint_retorna_recursos_do_local_no_macroprojeto_e_soma_as_quantidades(): void
public function endpoint_nao_consulta_recursos_quando_local_esta_fora_do_escopo(): void
public function endpoint_exige_macroprojeto_ativo_antes_de_consultar_recursos(): void
public function rota_e_migration_acl_registram_o_endpoint_para_os_tres_grupos_autorizados(): void
private function controller(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
"Route::get('/{codObjeto}/recursos-logisticos'",
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\LocaisVotacao\LocalVotacaoCrudController;
use App\Repositories\Gel\GelRespostaRepository;
use App\Repositories\Lda\LocalDificilAcessoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Services\Lda\RecursoLogisticoLocalService;
use App\Services\Lda\TransmissaoPreferenciaService;
use Illuminate\Http\JsonResponse;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RecursoLogisticoLazyLoadTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function listagens_exibem_olhinho_de_recursos_logisticos_no_painel_compartilhado(): void
    {
        $localVotacaoIndex = file_get_contents(resource_path('views/lda/locais-votacao/index.blade.php'));
        $localVotacao = file_get_contents(resource_path('views/lda/partials/locais-votacao-tabela.blade.php'));
        $lda = file_get_contents(resource_path('views/lda/locais_dificil_acesso.blade.php'));

        $this->assertIsString($localVotacaoIndex);
        $this->assertIsString($localVotacao);
        $this->assertIsString($lda);
        $this->assertStringContainsString("@include('lda.partials.locais-votacao-tabela'", $localVotacaoIndex);

        foreach ([$localVotacao, $lda] as $view) {
            $this->assertStringContainsString('data-detalhe-tipo="recursos-logisticos"', $view);
            $this->assertStringContainsString('data-recursos-logisticos-label', $view);
            $this->assertStringContainsString('Carregando recursos logísticos…', $view);
            $this->assertStringContainsString('fa-solid fa-eye', $view);
        }

        $this->assertStringContainsString(
            "route('lda.locais-votacao.recursos-logisticos', \$local->cod_objeto)",
            $localVotacao
        );
        $this->assertStringContainsString(
            "route('lda.locais-votacao.recursos-logisticos', \$local['cod_objeto_local_votacao'])",
            $lda
        );
        $this->assertStringContainsString(
            'Clique em um dos olhinhos para carregar mesários, recursos logísticos ou respostas GEL.',
            $localVotacao
        );
        $this->assertStringContainsString(
            'Clique em um dos olhinhos para carregar mesários, recursos operacionais ou recursos logísticos.',
            $lda
        );
    }

    #[Test]
    public function endpoint_retorna_recursos_do_local_no_macroprojeto_e_soma_as_quantidades(): void
    {
        session([
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 14,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')
            ->once()
            ->with('LV001', [2], false)
            ->andReturn((object) ['cod_objeto' => 'LV001']);

        $service = Mockery::mock(RecursoLogisticoLocalService::class);
        $service->shouldReceive('buscarPorLocal')
            ->once()
            ->with('LV001', 14)
            ->andReturn([
                [
                    'codigo' => 'BATERIAS',
                    'nome' => 'BATERIAS',
                    'quantidade' => 1,
                    'peso_unitario_kg' => 1,
                    'peso_total_kg' => 1,
                ],
                [
                    'codigo' => 'URNA_SECAO',
                    'nome' => 'URNAS DE SEÇÃO',
                    'quantidade' => 2,
                    'peso_unitario_kg' => 10,
                    'peso_total_kg' => 20,
                    'calculado' => true,
                ],
            ]);

        $response = $this->controller($repository, $service)->recursosLogisticos('LV001');

        $this->assertInstanceOf(JsonResponse::class, $response);
        $this->assertSame(200, $response->getStatusCode());
        $payload = $response->getData(true);
        $this->assertSame(3, $payload['total']);
        $this->assertStringContainsString('BATERIAS', $payload['html']);
        $this->assertStringContainsString('URNAS DE SEÇÃO', $payload['html']);
        $this->assertStringContainsString('Calculado', $payload['html']);
        $this->assertStringNotContainsString('<input', $payload['html']);
    }

    #[Test]
    public function endpoint_nao_consulta_recursos_quando_local_esta_fora_do_escopo(): void
    {
        session([
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
            'macroprojeto_ativo_id' => 14,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')
            ->once()
            ->with('LV999', [2], false)
            ->andReturnNull();

        $service = Mockery::mock(RecursoLogisticoLocalService::class);
        $service->shouldNotReceive('buscarPorLocal');

        $response = $this->controller($repository, $service)->recursosLogisticos('LV999');

        $this->assertSame(404, $response->getStatusCode());
    }

    #[Test]
    public function endpoint_exige_macroprojeto_ativo_antes_de_consultar_recursos(): void
    {
        session([
            'cod_zonas_permitidas' => [0],
            'acesso_todas_zonas' => true,
            'macroprojeto_ativo_id' => null,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')
            ->once()
            ->with('LV001', [0], true)
            ->andReturn((object) ['cod_objeto' => 'LV001']);

        $service = Mockery::mock(RecursoLogisticoLocalService::class);
        $service->shouldNotReceive('buscarPorLocal');

        $response = $this->controller($repository, $service)->recursosLogisticos('LV001');

        $this->assertSame(409, $response->getStatusCode());
    }

    #[Test]
    public function rota_e_migration_acl_registram_o_endpoint_para_os_tres_grupos_autorizados(): void
    {
        $rotas = file_get_contents(base_path('routes/web.php'));
        $migration = file_get_contents(database_path(
            'migrations/2026_07_25_130000_grant_lda_recursos_logisticos_lazy_load_acl.php'
        ));

        $this->assertIsString($rotas);
        $this->assertIsString($migration);
        $this->assertStringContainsString(
            "Route::get('/{codObjeto}/recursos-logisticos'",
            $rotas
        );
        $this->assertStringContainsString("->name('recursos-logisticos')", $rotas);
        $this->assertStringContainsString('DB::transaction', $migration);
        $this->assertStringContainsString('lda.locais-votacao.recursos-logisticos', $migration);
        foreach ([
            'PLANELEITO_TRANSMISSAO',
            'PLANELEITO_TRANSMISSAO_ADMIN',
            'PLANELEITO_TRANSMISSAO_CONSULTA',
        ] as $grupo) {
            $this->assertStringContainsString($grupo, $migration);
        }
        $this->assertStringNotContainsString('Schema::', $migration);
    }

    private function controller(
        LocalVotacaoRepository $repository,
        RecursoLogisticoLocalService $service
    ): LocalVotacaoCrudController {
        return new LocalVotacaoCrudController(
            $repository,
            Mockery::mock(LocalDificilAcessoRepository::class),
            Mockery::mock(TransmissaoPreferenciaService::class),
            Mockery::mock(GelRespostaRepository::class),
            null,
            $service
        );
    }
}
```
</TESTS_UNIT_RECURSOLOGISTICOLAZYLOADTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RecursosFuncionaisDocumentationTest.php`
## <TESTS_UNIT_RECURSOSFUNCIONAISDOCUMENTATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RecursosFuncionaisDocumentationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RecursosFuncionaisDocumentationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_indice_relaciona_todos_os_modulos_e_documentos_iniciais(): void
public function test_documentos_cobrem_os_caminhos_de_menu_dos_modulos_iniciais(): void
public function test_identificadores_sao_unicos_e_usam_o_prefixo_do_modulo(): void
public function test_casos_de_uso_possuem_identificadores_unicos_e_estrutura_minima(): void
public function test_todos_os_recursos_funcionais_estao_cobertos_por_caso_de_uso(): void
public function test_catalogo_e_modulos_apontam_para_os_casos_de_uso(): void
public function test_diarias_registra_a_sequencia_operacional_completa(): void
public function test_links_locais_dos_documentos_apontam_para_arquivos_existentes(): void
private function caminhosMenu(array $configuracao): array
private function conteudoDocumento(string $arquivo): string
private function diretorioCatalogo(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class RecursosFuncionaisDocumentationTest extends TestCase
{
    private const DOCUMENTOS_MODULOS = [
        'planejamento' => 'planejamento.md',
        'dia_e' => 'dia-e.md',
        'diarias' => 'diarias.md',
        'transmissao_dados' => 'transmissao-dados.md',
    ];

    private const DOCUMENTOS_CASOS_USO = [
        'planejamento.md' => 'casos-de-uso/planejamento.md',
        'dia-e.md' => 'casos-de-uso/dia-e.md',
        'diarias.md' => 'casos-de-uso/diarias.md',
        'transmissao-dados.md' => 'casos-de-uso/transmissao-dados.md',
    ];

    public function test_indice_relaciona_todos_os_modulos_e_documentos_iniciais(): void
    {
        $indice = $this->conteudoDocumento('README.md');

        foreach ((array) config('planeleito_menu') as $modulo) {
            $this->assertStringContainsString((string) $modulo['label'], $indice);
        }

        foreach (self::DOCUMENTOS_MODULOS as $arquivo) {
            $this->assertFileExists($this->diretorioCatalogo().'/'.$arquivo);
            $this->assertStringContainsString('('.$arquivo.')', $indice);
        }

        $this->assertStringContainsString(
            'docs/recursos-funcionais/README.md',
            (string) file_get_contents(base_path('README.md'))
        );
    }

    public function test_documentos_cobrem_os_caminhos_de_menu_dos_modulos_iniciais(): void
    {
        foreach (self::DOCUMENTOS_MODULOS as $chaveModulo => $arquivo) {
            $conteudo = $this->conteudoDocumento($arquivo);

            foreach ($this->caminhosMenu((array) config('planeleito_menu.'.$chaveModulo)) as $caminho) {
                $this->assertStringContainsString($caminho, $conteudo, $arquivo.' não documenta '.$caminho);
            }
        }
    }

    public function test_identificadores_sao_unicos_e_usam_o_prefixo_do_modulo(): void
    {
        $identificadores = [];
        $prefixos = [
            'planejamento.md' => 'PLAN',
            'dia-e.md' => 'DIAE',
            'diarias.md' => 'DIAR',
            'transmissao-dados.md' => 'TRAN',
        ];

        foreach ($prefixos as $arquivo => $prefixo) {
            preg_match_all('/\bRF-'.$prefixo.'-\d{3}\b/u', $this->conteudoDocumento($arquivo), $encontrados);
            $this->assertNotEmpty($encontrados[0], $arquivo.' não possui recursos funcionais identificados.');
            array_push($identificadores, ...$encontrados[0]);
        }

        $this->assertSame(
            count($identificadores),
            count(array_unique($identificadores)),
            'Os identificadores de recursos funcionais devem ser únicos e aparecer uma única vez.'
        );
    }

    public function test_casos_de_uso_possuem_identificadores_unicos_e_estrutura_minima(): void
    {
        $identificadores = [];
        $prefixos = [
            'casos-de-uso/planejamento.md' => 'PLAN',
            'casos-de-uso/dia-e.md' => 'DIAE',
            'casos-de-uso/diarias.md' => 'DIAR',
            'casos-de-uso/transmissao-dados.md' => 'TRAN',
        ];

        foreach ($prefixos as $arquivo => $prefixo) {
            $conteudo = $this->conteudoDocumento($arquivo);
            preg_match_all('/^## (UC-'.$prefixo.'-\d{3})\b.*?(?=^## UC-|\z)/msu', $conteudo, $casos, PREG_SET_ORDER);
            $this->assertNotEmpty($casos, $arquivo.' não possui casos de uso identificados.');

            foreach ($casos as $caso) {
                $identificadores[] = $caso[1];
                foreach ([
                    '**Recursos relacionados:**',
                    '**Ator principal:**',
                    '**Pré-condições:**',
                    '**Gatilho:**',
                    '**Fluxo principal:**',
                    '**Exceções e alternativas:**',
                    '**Pós-condições:**',
                ] as $campo) {
                    $this->assertStringContainsString($campo, $caso[0], $caso[1].' não possui o campo '.$campo);
                }
            }
        }

        $this->assertSame(count($identificadores), count(array_unique($identificadores)), 'IDs UC devem ser únicos.');
    }

    public function test_todos_os_recursos_funcionais_estao_cobertos_por_caso_de_uso(): void
    {
        foreach (self::DOCUMENTOS_CASOS_USO as $documentoModulo => $documentoCasos) {
            preg_match_all('/\bRF-(?:PLAN|DIAE|DIAR|TRAN)-\d{3}\b/u', $this->conteudoDocumento($documentoModulo), $recursos);
            $casos = $this->conteudoDocumento($documentoCasos);

            foreach (array_unique($recursos[0]) as $recurso) {
                $this->assertStringContainsString($recurso, $casos, $recurso.' não está coberto por caso de uso.');
            }
        }
    }

    public function test_catalogo_e_modulos_apontam_para_os_casos_de_uso(): void
    {
        $indice = $this->conteudoDocumento('README.md');

        foreach (self::DOCUMENTOS_CASOS_USO as $documentoModulo => $documentoCasos) {
            $this->assertFileExists($this->diretorioCatalogo().'/'.$documentoCasos);
            $this->assertStringContainsString('('.$documentoCasos.')', $indice);
            $this->assertStringContainsString(
                '(casos-de-uso/'.basename($documentoCasos).')',
                $this->conteudoDocumento($documentoModulo)
            );
        }
    }

    public function test_diarias_registra_a_sequencia_operacional_completa(): void
    {
        $this->assertStringContainsString(
            'Solicitação → Aprovações → SETRAN → FIN/SPEF → Pagamento → Publicação DJE → Comprovação',
            $this->conteudoDocumento('diarias.md')
        );
    }

    public function test_links_locais_dos_documentos_apontam_para_arquivos_existentes(): void
    {
        $arquivos = array_merge(
            ['README.md'],
            array_values(self::DOCUMENTOS_MODULOS),
            array_values(self::DOCUMENTOS_CASOS_USO)
        );

        foreach ($arquivos as $arquivo) {
            $caminho = $this->diretorioCatalogo().'/'.$arquivo;
            preg_match_all('/\[[^\]]+\]\(([^)]+)\)/u', $this->conteudoDocumento($arquivo), $links);

            foreach ($links[1] as $link) {
                $destino = explode('#', $link, 2)[0];
                if ($destino === '' || str_starts_with($destino, 'http') || str_starts_with($destino, 'mailto:')) {
                    continue;
                }

                $this->assertFileExists(
                    dirname($caminho).'/'.$destino,
                    $arquivo.' referencia arquivo local inexistente: '.$destino
                );
            }
        }
    }

    /**
     * @return array<int, string>
     */
    private function caminhosMenu(array $configuracao): array
    {
        $caminhos = [];
        array_walk_recursive($configuracao, function (mixed $valor, string $chave) use (&$caminhos): void {
            if ($chave === 'menu_path' && is_string($valor)) {
                $caminhos[] = $valor;
            }
        });

        return array_values(array_unique($caminhos));
    }

    private function conteudoDocumento(string $arquivo): string
    {
        $caminho = $this->diretorioCatalogo().'/'.$arquivo;
        $this->assertFileExists($caminho);

        return (string) file_get_contents($caminho);
    }

    private function diretorioCatalogo(): string
    {
        return base_path('docs/recursos-funcionais');
    }
}
```
</TESTS_UNIT_RECURSOSFUNCIONAISDOCUMENTATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RepositoriesDesacoplamentoContractTest.php`
## <TESTS_UNIT_REPOSITORIESDESACOPLAMENTOCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RepositoriesDesacoplamentoContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RepositoriesDesacoplamentoContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_repositories_nao_descobrem_contexto_sozinhos(): void
private function padroesProibidos(): array
private function arquivosPhp(string $diretorio): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

/**
 * Teste arquitetural do contrato docs/contratos/repositories.md.
 *
 * Um repository nao deve descobrir contexto de execucao por conta propria:
 * proibido ler session(), auth() ou depender de Request/request() dentro de
 * app/Repositories. Contexto deve chegar por parametro vindo de controller/service.
 *
 * Conforme o contrato (secao "Limites de resultado" e "teste arquitetural"),
 * qualquer excecao precisa ser documentada e adicionada explicitamente a
 * $permitidos abaixo, com justificativa.
 */
class RepositoriesDesacoplamentoContractTest extends TestCase
{
    /**
     * Lista de permissoes (allowlist). Deve permanecer VAZIA.
     * Cada entrada e um arquivo de repository ainda nao migrado e e divida
     * tecnica explicita a ser eliminada, nao um padrao aceitavel.
     */
    private const PERMITIDOS = [];

    public function test_repositories_nao_descobrem_contexto_sozinhos(): void
    {
        $base = base_path('app/Repositories');
        $arquivos = $this->arquivosPhp($base);

        $violacoes = [];

        foreach ($arquivos as $arquivo) {
            $relativo = str_replace($base . DIRECTORY_SEPARATOR, '', $arquivo);

            if (in_array($relativo, self::PERMITIDOS, true)) {
                continue;
            }

            $conteudo = file_get_contents($arquivo);

            foreach ($this->padroesProibidos() as $rotulo => $regex) {
                if (preg_match($regex, $conteudo)) {
                    $violacoes[] = "{$relativo}: {$rotulo}";
                }
            }
        }

        $this->assertSame(
            [],
            $violacoes,
            "Repositories descumprindo o contrato de desacoplamento (devem receber contexto por parametro):\n"
            . implode("\n", $violacoes)
        );
    }

    /**
     * @return array<string,string>
     */
    private function padroesProibidos(): array
    {
        return [
            // Helpers globais.
            'usa session()' => '/\bsession\s*\(/',
            'usa auth()' => '/\bauth\s*\(/',
            'usa request()' => '/\brequest\s*\(/',
            // Facades (mesmo contexto, outra sintaxe — nao deixar evadir a trava).
            'usa facade Session::' => '/\bSession\s*::/',
            'usa facade Auth::' => '/\bAuth\s*::/',
            'usa facade Request::' => '/\bRequest\s*::/',
            // Resolucao via container.
            'resolve contexto via app()' => "/app\\s*\\(\\s*['\"](session|auth|request)['\"]/",
            // Dependencia de Request: import ou type-hint em assinatura.
            'depende de Request' => '/Illuminate\\\\Http\\\\Request/',
            'recebe Request por parametro' => '/\bRequest\s+\$/',
            // Evasao por referencia textual: chamar 'session' como string/callable
            // dinamico ($s = 'session'; $s(...)) ou function_exists('session') burla
            // a deteccao das chamadas diretas. Repository nao tem motivo legitimo
            // para nomear session/auth/request como literal — documente excecao em
            // PERMITIDOS se algum dia houver.
            'referencia textual a session/auth/request' => "/['\"](session|auth|request)['\"]/",
            // Acoplamento com HTTP (repositories.md §37, §182: "repository nao
            // conhece HTTP"). Decisao de resposta (404, redirect, view, json)
            // pertence ao controller; o repository lanca excecao de dominio ou
            // retorna null.
            'usa abort() (decisao HTTP no repository)' => '/\babort\s*\(/',
            'usa redirect() (resposta HTTP no repository)' => '/\bredirect\s*\(/',
            'usa response() (resposta HTTP no repository)' => '/\bresponse\s*\(/',
            'usa view() (composicao de resposta no repository)' => '/\bview\s*\(/',
        ];
    }

    /**
     * @return array<int,string>
     */
    private function arquivosPhp(string $diretorio): array
    {
        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($diretorio, \FilesystemIterator::SKIP_DOTS)
        );

        $arquivos = [];
        foreach ($iterator as $item) {
            if ($item->isFile() && $item->getExtension() === 'php') {
                $arquivos[] = $item->getPathname();
            }
        }

        sort($arquivos);

        return $arquivos;
    }
}
```
</TESTS_UNIT_REPOSITORIESDESACOPLAMENTOCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RepositoriesEscopoFailOpenTest.php`
## <TESTS_UNIT_REPOSITORIESESCOPOFAILOPENTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RepositoriesEscopoFailOpenTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RepositoriesEscopoFailOpenTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_nenhum_repository_usa_default_de_escopo_permissivo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

/**
 * Guarda contra escopo "fail-open" nos repositories.
 *
 * Diretriz de ACL (AGENTS.md §90-91; repositories.md regra de contexto
 * explicito): o repository nao deve ampliar escopo por conta propria, e uma
 * rota secundaria nao pode enxergar mais dados que a principal.
 *
 * Um parametro de escopo com default permissivo — `bool $isAdmin = true` — faz
 * o repository conceder acesso total quando o chamador esquece de informar o
 * contexto. O default seguro e restritivo (false) ou parametro obrigatorio.
 *
 * NOTA: esta regra encoda a recomendacao da reanalise; ao flexibiliza-la,
 * documente a excecao no contrato e em PERMITIDOS, e audite os chamadores.
 */
class RepositoriesEscopoFailOpenTest extends TestCase
{
    /** @var array<int,string> arquivos com excecao documentada (manter vazio) */
    private const PERMITIDOS = [];

    public function test_nenhum_repository_usa_default_de_escopo_permissivo(): void
    {
        $base = base_path('app/Repositories');
        $violacoes = [];

        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($base, \FilesystemIterator::SKIP_DOTS)
        );

        foreach ($iterator as $item) {
            if (!$item->isFile() || $item->getExtension() !== 'php') {
                continue;
            }

            $relativo = str_replace($base . DIRECTORY_SEPARATOR, '', $item->getPathname());
            if (in_array($relativo, self::PERMITIDOS, true)) {
                continue;
            }

            $conteudo = file_get_contents($item->getPathname());

            // Default permissivo de escopo: $isAdmin = true / $admin = true /
            // $acessoTodasZonas = true / $aplicaEscopo = false como parametro.
            if (preg_match('/\$(isAdmin|admin|acessoTodasZonas)\s*=\s*true/i', $conteudo, $m)) {
                $violacoes[] = "{$relativo}: parametro de escopo fail-open ({$m[0]})";
            }
        }

        $this->assertSame(
            [],
            $violacoes,
            "Repositories com default de escopo permissivo (fail-open):\n" . implode("\n", $violacoes)
        );
    }
}
```
</TESTS_UNIT_REPOSITORIESESCOPOFAILOPENTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RepositoriesFronteirasArquiteturaisTest.php`
## <TESTS_UNIT_REPOSITORIESFRONTEIRASARQUITETURAISTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RepositoriesFronteirasArquiteturaisTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RepositoriesFronteirasArquiteturaisTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_repositories_nao_usam_service_locator(): void
public function test_repositories_nao_recebem_contexto_por_resolver_tardio(): void
public function test_repositories_nao_descobrem_catalogo_de_rotas(): void
public function test_repositories_nao_dependem_de_services_de_politica_funcional(): void
public function test_contratos_de_repository_nao_expoem_politica_de_autorizacao(): void
public function test_interfaces_de_repository_tem_no_maximo_vinte_metodos(): void
private function arquivosComPadrao(string $diretorio, string $padrao): array
private function arquivosPhp(string $diretorio): array
private function classeDoArquivo(string $arquivo): string
private function mensagem(string $regra, array $violacoes): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use ReflectionClass;
use Tests\TestCase;

/**
 * Travas estruturais de docs/contratos/repositories.md.
 *
 * Nao adicionar allowlist para manter divida conhecida. Cada falha deve ser
 * eliminada pela extracao da responsabilidade para controller/service ou pela
 * divisao do contrato de repository.
 */
class RepositoriesFronteirasArquiteturaisTest extends TestCase
{
    public function test_repositories_nao_usam_service_locator(): void
    {
        $violacoes = $this->arquivosComPadrao(
            base_path('app/Repositories'),
            '/\b(?:app|resolve)\s*\(/',
        );

        $this->assertSame([], $violacoes, $this->mensagem('service locator app()/resolve()', $violacoes));
    }

    public function test_repositories_nao_recebem_contexto_por_resolver_tardio(): void
    {
        $violacoes = $this->arquivosComPadrao(
            base_path('app/Repositories'),
            '/(?:set[A-Za-z0-9_]*Resolver\s*\(|(?:Closure|callable)\s+\$[A-Za-z0-9_]*(?:Contexto|Usuario|Auditoria)[A-Za-z0-9_]*)/i',
        );

        $this->assertSame([], $violacoes, $this->mensagem('contexto por Closure/callable/resolver mutavel', $violacoes));
    }

    public function test_repositories_nao_descobrem_catalogo_de_rotas(): void
    {
        $violacoes = $this->arquivosComPadrao(
            base_path('app/Repositories'),
            '/(?:Illuminate\\\\Support\\\\Facades\\\\Route|\bRoute\s*::\s*getRoutes\s*\()/',
        );

        $this->assertSame([], $violacoes, $this->mensagem('descoberta do catalogo de rotas', $violacoes));
    }

    public function test_repositories_nao_dependem_de_services_de_politica_funcional(): void
    {
        $violacoes = $this->arquivosComPadrao(
            base_path('app/Repositories'),
            '/use\s+App\\\\Services\\\\[A-Za-z0-9_]*(?:Permissao|Conflito|Decisao|Transicao)[A-Za-z0-9_]*Service\s*;/',
        );

        $this->assertSame([], $violacoes, $this->mensagem('service de permissao/conflito/decisao/transicao', $violacoes));
    }

    public function test_contratos_de_repository_nao_expoem_politica_de_autorizacao(): void
    {
        $violacoes = $this->arquivosComPadrao(
            base_path('app/Repositories/Contracts'),
            '/public\s+function\s+[A-Za-z0-9_]*(?:EstaNoEscopo|PodeGerenciar|TemPermissao|PodeAcessar)\s*\(/i',
        );

        $this->assertSame([], $violacoes, $this->mensagem('metodo de politica de autorizacao', $violacoes));
    }

    public function test_interfaces_de_repository_tem_no_maximo_vinte_metodos(): void
    {
        $violacoes = [];

        foreach ($this->arquivosPhp(base_path('app/Repositories/Contracts')) as $arquivo) {
            require_once $arquivo;
            $classe = $this->classeDoArquivo($arquivo);
            $reflection = new ReflectionClass($classe);
            $quantidade = count(array_filter(
                $reflection->getMethods(),
                static fn (\ReflectionMethod $method): bool => $method->getDeclaringClass()->getName() === $classe,
            ));

            if ($quantidade > 20) {
                $violacoes[] = basename($arquivo) . ": {$quantidade} metodos";
            }
        }

        sort($violacoes);

        $this->assertSame([], $violacoes, $this->mensagem('interface com mais de 20 metodos', $violacoes));
    }

    /** @return array<int, string> */
    private function arquivosComPadrao(string $diretorio, string $padrao): array
    {
        $violacoes = [];

        foreach ($this->arquivosPhp($diretorio) as $arquivo) {
            $conteudo = file_get_contents($arquivo);
            if ($conteudo !== false && preg_match($padrao, $conteudo) === 1) {
                $violacoes[] = str_replace(base_path() . DIRECTORY_SEPARATOR, '', $arquivo);
            }
        }

        sort($violacoes);

        return $violacoes;
    }

    /** @return array<int, string> */
    private function arquivosPhp(string $diretorio): array
    {
        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator($diretorio, \FilesystemIterator::SKIP_DOTS),
        );
        $arquivos = [];

        foreach ($iterator as $item) {
            if ($item->isFile() && $item->getExtension() === 'php') {
                $arquivos[] = $item->getPathname();
            }
        }

        sort($arquivos);

        return $arquivos;
    }

    private function classeDoArquivo(string $arquivo): string
    {
        return 'App\\Repositories\\Contracts\\' . pathinfo($arquivo, PATHINFO_FILENAME);
    }

    /** @param array<int, string> $violacoes */
    private function mensagem(string $regra, array $violacoes): string
    {
        return "Repositories violando {$regra}:\n" . implode("\n", $violacoes);
    }
}
```
</TESTS_UNIT_REPOSITORIESFRONTEIRASARQUITETURAISTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RestoreManifestContractTest.php`
## <TESTS_UNIT_RESTOREMANIFESTCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RestoreManifestContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RestoreManifestContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function todas_as_tabelas_observadas_estao_classificadas_uma_unica_vez(): void
public function tabelas_sincronizadas_nao_entram_em_seeders_versionados_nem_carga_privada(): void
public function arquivos_de_referencia_existem_para_todas_as_tabelas_de_referencia(): void
public function dados_de_referencia_nao_versionam_colunas_de_usuario_operacional(): void
public function carga_real_privada_tem_caminho_ignorado_pelo_git(): void
public function diretorio_de_carga_real_privada_usa_configuracao_cacheavel(): void
public function database_seeder_nao_executa_carga_real_privada_por_padrao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\DatabaseRestore\RestoreTableManifest;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class RestoreManifestContractTest extends TestCase
{
    #[Test]
    public function todas_as_tabelas_observadas_estao_classificadas_uma_unica_vez(): void
    {
        $todas = RestoreTableManifest::allTables();
        $classificadas = array_merge(
            RestoreTableManifest::referenceTables(),
            RestoreTableManifest::privateDataTables(),
            RestoreTableManifest::syncTables(),
            RestoreTableManifest::ignoredTables(),
        );

        sort($todas);
        sort($classificadas);

        $this->assertCount(178, $todas);
        $this->assertSame($todas, $classificadas);
        $this->assertSameSize($classificadas, array_unique($classificadas));
        $this->assertContains('adm_acesso_rota', RestoreTableManifest::referenceTables());
        $this->assertContains('macroprojeto_turno', RestoreTableManifest::referenceTables());
        $this->assertContains('disque_eleicao_assunto', RestoreTableManifest::referenceTables());
        $this->assertContains('disque_eleicao_domicilio_extra', RestoreTableManifest::referenceTables());
        $this->assertContains('ce_sms_envio_status', RestoreTableManifest::referenceTables());
        $this->assertContains('nat_vistoria_secao_pergunta', RestoreTableManifest::referenceTables());
        $this->assertContains('svi_solicitacao_status', RestoreTableManifest::referenceTables());
        $this->assertContains('ca_registro_status', RestoreTableManifest::referenceTables());
        $this->assertContains('ca_atendimento_tipo', RestoreTableManifest::referenceTables());
        $this->assertContains('ca_ocorrencia_tipo', RestoreTableManifest::referenceTables());
        $this->assertContains('zona', RestoreTableManifest::referenceTables());
        $this->assertContains('cad_unidade', RestoreTableManifest::referenceTables());
        $this->assertContains('auditoria_acao', RestoreTableManifest::privateDataTables());
        $this->assertContains('cad_eleitor', RestoreTableManifest::privateDataTables());
        $this->assertContains('ce_voluntario_exclusao', RestoreTableManifest::privateDataTables());
        $this->assertContains('disque_eleicao_atendimento', RestoreTableManifest::privateDataTables());
        $this->assertContains('ce_sms_modelo', RestoreTableManifest::privateDataTables());
        $this->assertContains('ce_sms_envio', RestoreTableManifest::privateDataTables());
        $this->assertContains('ce_sms_telefone_manual', RestoreTableManifest::privateDataTables());
        $this->assertContains('nat_vistoria_secao', RestoreTableManifest::privateDataTables());
        $this->assertContains('nat_vistoria_secao_resposta', RestoreTableManifest::privateDataTables());
        $this->assertContains('svi_solicitacao', RestoreTableManifest::privateDataTables());
        $this->assertContains('svi_acesso_desafio', RestoreTableManifest::privateDataTables());
        $this->assertContains('rota_transmissao_vinculo', RestoreTableManifest::privateDataTables());
        $this->assertContains('scde_configuracao', RestoreTableManifest::privateDataTables());
        $this->assertContains('ca_registro_configuracao', RestoreTableManifest::privateDataTables());
        $this->assertContains('ca_registro_eleicao', RestoreTableManifest::privateDataTables());
        $this->assertContains('ca_registro_atendimento', RestoreTableManifest::privateDataTables());
        $this->assertContains('ca_registro_ocorrencia', RestoreTableManifest::privateDataTables());
        $this->assertContains('ca_registro_historico', RestoreTableManifest::privateDataTables());
        $this->assertLessThan(
            array_search('ca_registro_eleicao', RestoreTableManifest::privateDataTables(), true),
            array_search('ca_registro_configuracao', RestoreTableManifest::privateDataTables(), true),
        );
        foreach ([
            'ca_registro_status',
            'ca_atendimento_tipo',
            'ca_ocorrencia_tipo',
            'ca_registro_configuracao',
            'ca_registro_eleicao',
            'ca_registro_atendimento',
            'ca_registro_ocorrencia',
            'ca_registro_historico',
        ] as $tabelaAcessibilidade) {
            $this->assertNotEmpty(RestoreTableManifest::primaryKeyFor($tabelaAcessibilidade));
            $this->assertArrayHasKey($tabelaAcessibilidade, RestoreTableManifest::sourceRowCounts());
        }
        $this->assertSame(2, RestoreTableManifest::sourceRowCountFor('ca_registro_status'));
        $this->assertSame(6, RestoreTableManifest::sourceRowCountFor('ca_atendimento_tipo'));
        $this->assertSame(7, RestoreTableManifest::sourceRowCountFor('ca_ocorrencia_tipo'));
        $this->assertSame(['id'], RestoreTableManifest::primaryKeyFor('rota_transmissao_vinculo'));
        $this->assertSame(0, RestoreTableManifest::sourceRowCountFor('rota_transmissao_vinculo'));
        $this->assertContains('lda_trajeto', RestoreTableManifest::privateDataTables());
        $this->assertContains('local_votacao_deslocamento', RestoreTableManifest::privateDataTables());
        $this->assertLessThan(
            array_search('lda_trajeto_trecho', RestoreTableManifest::privateDataTables(), true),
            array_search('lda_trajeto', RestoreTableManifest::privateDataTables(), true)
        );
        $this->assertSame(['id'], RestoreTableManifest::primaryKeyFor('lda_trajeto'));
        $this->assertArrayHasKey('lda_trajeto', RestoreTableManifest::sourceRowCounts());
        $this->assertSame(['id'], RestoreTableManifest::primaryKeyFor('local_votacao_deslocamento'));
        $this->assertSame(6, RestoreTableManifest::sourceRowCountFor('local_votacao_deslocamento'));
        $this->assertSame(['id'], RestoreTableManifest::primaryKeyFor('ce_sms_telefone_manual'));
        $this->assertContains('eleitor', RestoreTableManifest::syncTables());
        $this->assertContains('local_votacao_st', RestoreTableManifest::syncTables());
        $this->assertContains('mrj', RestoreTableManifest::syncTables());
        $this->assertContains('mrj_sync_stage', RestoreTableManifest::ignoredTables());
        $this->assertSame(['cod_objeto'], RestoreTableManifest::primaryKeyFor('mrj'));
        $this->assertContains('treinamento_tse_turma', RestoreTableManifest::syncTables());
        $this->assertContains('treinamento_tse_convocado', RestoreTableManifest::syncTables());
        $this->assertContains('rcand_partido', RestoreTableManifest::syncTables());
        $this->assertContains('rcand_cand_proc_partido', RestoreTableManifest::syncTables());
        $this->assertContains('rcand_cw_pedido_partido', RestoreTableManifest::syncTables());
        $this->assertContains('jecmon_kit_online', RestoreTableManifest::syncTables());
        $this->assertContains('jecmon_kit_online_sync', RestoreTableManifest::syncTables());
        $this->assertContains('scde_secao_situacao', RestoreTableManifest::syncTables());
        $this->assertSame(['id'], RestoreTableManifest::primaryKeyFor('scde_configuracao'));
        $this->assertSame(
            ['cod_pleito', 'cod_eleicao', 'sg_ue_uf', 'nr_zona', 'nr_secao', 'cd_tipo_cargo_pergunta'],
            RestoreTableManifest::primaryKeyFor('scde_secao_situacao'),
        );
        $this->assertSame(0, RestoreTableManifest::sourceRowCountFor('scde_configuracao'));
        $this->assertSame(0, RestoreTableManifest::sourceRowCountFor('scde_secao_situacao'));
        $this->assertSame(
            ['codigo_processo_eleitoral', 'kit_id'],
            RestoreTableManifest::primaryKeyFor('jecmon_kit_online'),
        );
        $this->assertSame(
            ['codigo_processo_eleitoral'],
            RestoreTableManifest::primaryKeyFor('jecmon_kit_online_sync'),
        );
        $this->assertSame(7, RestoreTableManifest::sourceRowCounts()['treinamento_tse_turma']);
        $this->assertSame(41, RestoreTableManifest::sourceRowCounts()['treinamento_tse_convocado']);
        $this->assertSame(0, RestoreTableManifest::sourceRowCounts()['rcand_partido']);
        $this->assertSame(0, RestoreTableManifest::sourceRowCounts()['rcand_cand_proc_partido']);
        $this->assertSame(0, RestoreTableManifest::sourceRowCounts()['rcand_cw_pedido_partido']);
    }

    #[Test]
    public function tabelas_sincronizadas_nao_entram_em_seeders_versionados_nem_carga_privada(): void
    {
        foreach (RestoreTableManifest::syncTables() as $table) {
            $this->assertNotContains($table, RestoreTableManifest::referenceTables(), $table);
            $this->assertNotContains($table, RestoreTableManifest::privateDataTables(), $table);
        }
    }

    #[Test]
    public function arquivos_de_referencia_existem_para_todas_as_tabelas_de_referencia(): void
    {
        foreach (RestoreTableManifest::referenceTables() as $table) {
            $path = RestoreTableManifest::referenceDataPath($table);

            $this->assertFileExists($path, $table);
            $payload = json_decode((string) file_get_contents($path), true, flags: JSON_THROW_ON_ERROR);
            $this->assertIsArray($payload, $table);
        }
    }

    #[Test]
    public function dados_de_referencia_nao_versionam_colunas_de_usuario_operacional(): void
    {
        $colunasBloqueadas = [
            'usuario_criacao',
            'usuario_nome_criacao',
            'usuario_atualizacao',
            'usuario_nome_atualizacao',
        ];

        foreach (RestoreTableManifest::referenceTables() as $table) {
            $payload = json_decode(
                (string) file_get_contents(RestoreTableManifest::referenceDataPath($table)),
                true,
                flags: JSON_THROW_ON_ERROR,
            );

            foreach ($payload as $row) {
                foreach ($colunasBloqueadas as $coluna) {
                    $this->assertArrayNotHasKey($coluna, $row, $table);
                }
            }
        }
    }

    #[Test]
    public function carga_real_privada_tem_caminho_ignorado_pelo_git(): void
    {
        $gitignore = (string) file_get_contents(base_path('.gitignore'));

        $this->assertStringContainsString('/storage/app/restore/private/', $gitignore);
        $this->assertStringContainsString('/storage/app/restore/private-manifest.json', $gitignore);
    }

    #[Test]
    public function diretorio_de_carga_real_privada_usa_configuracao_cacheavel(): void
    {
        config(['planeleito.restore.private_data_path' => '/tmp/planeleito-restore-private']);

        $this->assertSame('/tmp/planeleito-restore-private', RestoreTableManifest::privateDataDirectory());
        $this->assertSame(
            '/tmp/planeleito-restore-private/cad_eleitor.jsonl',
            RestoreTableManifest::privateDataPath('cad_eleitor')
        );
    }

    #[Test]
    public function database_seeder_nao_executa_carga_real_privada_por_padrao(): void
    {
        $databaseSeeder = (string) file_get_contents(database_path('seeders/DatabaseSeeder.php'));
        $homologacaoSeeder = (string) file_get_contents(database_path('seeders/RestoreHomologacaoSeeder.php'));

        $this->assertStringContainsString('RestoreReferenceDataSeeder::class', $databaseSeeder);
        $this->assertStringNotContainsString('RestorePrivateDataSeeder::class', $databaseSeeder);
        $this->assertStringContainsString('RestorePrivateDataSeeder::class', $homologacaoSeeder);
    }
}
```
</TESTS_UNIT_RESTOREMANIFESTCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RestoreSeedersContractTest.php`
## <TESTS_UNIT_RESTORESEEDERSCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RestoreSeedersContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RestoreSeedersContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringNotContainsString("db::table('{$tabela}'", $conteudo, basename($arquivo));
$this->assertStringNotContainsString("db::table(\"{$tabela}\"", $conteudo, basename($arquivo));
$this->assertStringContainsString("DB::table('{$tabela}')", $conteudo);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function database_seeder_chama_apenas_seeders_permanentes_de_parametrizacao(): void
public function seeders_permanentes_nao_populam_tabelas_sincronizadas(): void
public function dominio_auxiliar_seeder_declara_dominios_estaveis_sem_dados_pessoais(): void
public function cadastro_eleitoral_parametro_seeder_declara_prioridades_e_tipos_de_guiche(): void
public function nat_status_ocorrencia_seeder_e_idempotente_por_codigo(): void
private function seederFiles(): array
private function readFile(string $arquivo): string
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

class RestoreSeedersContractTest extends TestCase
{
    #[Test]
    public function database_seeder_chama_apenas_seeders_permanentes_de_parametrizacao(): void
    {
        $conteudo = $this->readFile(database_path('seeders/DatabaseSeeder.php'));

        $this->assertStringContainsString('RestoreReferenceDataSeeder::class', $conteudo);
        $this->assertStringContainsString('DominioAuxiliarSeeder::class', $conteudo);
        $this->assertStringContainsString('CadastroEleitoralParametroSeeder::class', $conteudo);
        $this->assertStringContainsString('NatStatusOcorrenciaSeeder::class', $conteudo);
        $this->assertStringContainsString('LdaSituacaoOpcaoSeeder::class', $conteudo);
        $this->assertStringNotContainsString('RestorePrivateDataSeeder::class', $conteudo);
        $this->assertStringNotContainsString('User::factory', $conteudo);
        $this->assertStringNotContainsString('test@example.com', $conteudo);
    }

    #[Test]
    public function seeders_permanentes_nao_populam_tabelas_sincronizadas(): void
    {
        $tabelasSincronizadas = [
            'local_votacao_st',
            'secoes',
            'secoes_agregadas',
            'secao_alocacao_provisoria',
            'bairro',
            'eleitor',
            'local_votacao_vagas',
            'cad_convocacao_mesario_tse',
            'treinamento_tse_turma',
            'treinamento_tse_convocado',
        ];

        foreach ($this->seederFiles() as $arquivo) {
            $conteudo = mb_strtolower($this->readFile($arquivo));

            foreach ($tabelasSincronizadas as $tabela) {
                $this->assertStringNotContainsString("db::table('{$tabela}'", $conteudo, basename($arquivo));
                $this->assertStringNotContainsString("db::table(\"{$tabela}\"", $conteudo, basename($arquivo));
            }
        }
    }

    #[Test]
    public function dominio_auxiliar_seeder_declara_dominios_estaveis_sem_dados_pessoais(): void
    {
        $conteudo = $this->readFile(database_path('seeders/DominioAuxiliarSeeder.php'));

        foreach (['opcao_binaria', 'qualidade', 'operadora', 'tipo_sinal', 'tipo_tomada', 'esfera'] as $tabela) {
            $this->assertStringContainsString("'table' => '{$tabela}'", $conteudo);
        }

        foreach (['SIM', 'NAO', 'OTIMA', 'VIVO', '3G', '3PINOS_NBR', 'FEDERAL'] as $codigo) {
            $this->assertStringContainsString("'{$codigo}'", $conteudo);
        }

        foreach (['cpf', 'num_inscricao', 'email', 'telefone', 'nom_eleitor'] as $termoSensivel) {
            $this->assertStringNotContainsString($termoSensivel, mb_strtolower($conteudo));
        }
    }

    #[Test]
    public function cadastro_eleitoral_parametro_seeder_declara_prioridades_e_tipos_de_guiche(): void
    {
        $conteudo = $this->readFile(database_path('seeders/CadastroEleitoralParametroSeeder.php'));

        foreach (['cad_tipo_guiche', 'cad_fila_prioridade'] as $tabela) {
            $this->assertStringContainsString("DB::table('{$tabela}')", $conteudo);
        }

        foreach (['COMUM', 'BIOMETRICO', 'NORMAL', 'PRIORITARIA'] as $codigo) {
            $this->assertStringContainsString("'codigo' => '{$codigo}'", $conteudo);
        }

        $this->assertStringContainsString('dt_atualizacao', $conteudo);
    }

    #[Test]
    public function nat_status_ocorrencia_seeder_e_idempotente_por_codigo(): void
    {
        $conteudo = $this->readFile(database_path('seeders/NatStatusOcorrenciaSeeder.php'));

        foreach (['ATRIBUIDA', 'EM_ANDAMENTO', 'FINALIZADA'] as $codigo) {
            $this->assertStringContainsString("'codigo' => '{$codigo}'", $conteudo);
        }

        $this->assertStringContainsString("whereRaw('UPPER(codigo) = ?'", $conteudo);
        $this->assertStringContainsString('dt_atualizacao', $conteudo);
    }

    /**
     * @return array<int, string>
     */
    private function seederFiles(): array
    {
        $arquivos = glob(database_path('seeders/*.php'));

        $this->assertIsArray($arquivos);

        return $arquivos;
    }

    private function readFile(string $arquivo): string
    {
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);

        return $conteudo;
    }
}
```
</TESTS_UNIT_RESTORESEEDERSCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeClientTest.php`
## <TESTS_UNIT_SCDECLIENTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeClientTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeClientTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function consulta_endpoint_analitico_com_url_header_e_protecoes_corretos(): void
public function segredo_ausente_host_invalido_ou_tls_desabilitado_falham_antes_da_rede(): void
public function status_http_invalido_ou_json_nao_vetorial_falha_sem_retry(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Scde\ScdeClient;
use Illuminate\Support\Facades\Http;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class ScdeClientTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config([
            'services.scde.base_url' => 'https://scde-apis.tse.jus.br',
            'services.scde.api_token' => 'token-de-teste',
            'services.scde.verify_tls' => true,
            'services.scde.connect_timeout' => 3,
            'services.scde.timeout' => 15,
        ]);
    }

    #[Test]
    public function consulta_endpoint_analitico_com_url_header_e_protecoes_corretos(): void
    {
        Http::fake([
            'https://scde-apis.tse.jus.br/*' => Http::response([['nrZona' => 1]], 200),
        ]);

        $resultado = (new ScdeClient)->consultarSituacaoSecao(9306, 12454, 'AC', 1);

        $this->assertSame([['nrZona' => 1]], $resultado);
        Http::assertSent(static function ($request): bool {
            return $request->url() === 'https://scde-apis.tse.jus.br/servicos-acompanhamento/rest/v1/situacao-secao-completo-analitico/9306/12454/AC/1'
                && $request->hasHeader('API-Authorization', 'token-de-teste')
                && ! $request->hasHeader('Authorization');
        });

    }

    #[Test]
    public function segredo_ausente_host_invalido_ou_tls_desabilitado_falham_antes_da_rede(): void
    {
        Http::fake();

        $cenarios = [
            ['services.scde.api_token' => ''],
            ['services.scde.base_url' => 'https://scde.example.org'],
            ['services.scde.base_url' => 'http://scde-apis.tse.jus.br'],
            ['services.scde.base_url' => 'https://scde-apis.tse.jus.br/servicos-acompanhamento/rest/v1/app/info'],
            ['services.scde.verify_tls' => false],
        ];

        foreach ($cenarios as $configuracao) {
            config([
                'services.scde.base_url' => 'https://scde-apis.tse.jus.br',
                'services.scde.api_token' => 'token-de-teste',
                'services.scde.verify_tls' => true,
            ]);
            config($configuracao);

            try {
                (new ScdeClient)->consultarSituacaoSecao(9306, 12454, 'AC', 1);
                $this->fail('A configuracao insegura deveria ser recusada.');
            } catch (RuntimeException $exception) {
                $this->assertStringNotContainsString('token-de-teste', $exception->getMessage());
            }
        }

        Http::assertNothingSent();
    }

    #[Test]
    public function status_http_invalido_ou_json_nao_vetorial_falha_sem_retry(): void
    {
        foreach ([
            Http::response([], 403),
            Http::response([], 404),
            Http::response([], 503),
            Http::response('{invalido', 200, ['Content-Type' => 'application/json']),
            Http::response(['dados' => []], 200),
        ] as $resposta) {
            Http::fake(['*' => $resposta]);

            try {
                (new ScdeClient)->consultarSituacaoSecao(9306, 12454, 'AC', 1);
                $this->fail('A resposta remota invalida deveria interromper a consulta.');
            } catch (RuntimeException $exception) {
                $this->assertStringContainsString('SCDE', $exception->getMessage());
            }

            Http::assertSentCount(1);
        }
    }
}
```
</TESTS_UNIT_SCDECLIENTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeConfiguracaoRepositoryTest.php`
## <TESTS_UNIT_SCDECONFIGURACAOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeConfiguracaoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeConfiguracaoRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function ativar_outra_configuracao_desativa_a_anterior_na_mesma_transacao_auditada(): void
public function __construct() {}
protected function atualizarAuditadoPorId(
public function configuracao_ativa_nao_pode_ser_editada_nem_excluida(string $metodo, string $mensagem): void
public static function mutacoesBloqueadas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Scde\ScdeConfiguracaoRepository;
use App\Services\Auditoria\AuditLogService;
use DomainException;
use Illuminate\Database\Query\Builder;
use Illuminate\Database\Query\Expression;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ScdeConfiguracaoRepositoryTest extends TestCase
{
    #[Test]
    public function ativar_outra_configuracao_desativa_a_anterior_na_mesma_transacao_auditada(): void
    {
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn (callable $callback): mixed => $callback());
        DB::shouldReceive('raw')->times(3)->with('SYSTIMESTAMP')->andReturn(new Expression('SYSTIMESTAMP'));
        $query = Mockery::mock(Builder::class);
        $query->shouldReceive('orderBy')->once()->with('id')->andReturnSelf();
        $query->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $query->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 7, 'cod_pleito' => 3220, 'cod_eleicao' => 6259, 'ativo' => 1],
            (object) ['id' => 8, 'cod_pleito' => 9306, 'cod_eleicao' => 12454, 'ativo' => 0],
        ]));
        DB::shouldReceive('table')->once()->with('scde_configuracao')->andReturn($query);

        $repository = new class extends ScdeConfiguracaoRepository
        {
            /** @var list<array{id:int,dados:array<string,mixed>}> */
            public array $atualizacoes = [];

            public function __construct() {}

            protected function atualizarAuditadoPorId(
                string $tabela,
                string $entidade,
                string $colunaId,
                mixed $id,
                array $dados,
            ): int {
                $this->atualizacoes[] = ['id' => (int) $id, 'dados' => $dados];
                return 1;
            }
        };

        $this->assertSame(2, $repository->ativar(8));
        $this->assertSame([7, 8], array_column($repository->atualizacoes, 'id'));
        $this->assertSame(0, $repository->atualizacoes[0]['dados']['ativo']);
        $this->assertSame(1, $repository->atualizacoes[1]['dados']['ativo']);
    }

    #[Test]
    #[DataProvider('mutacoesBloqueadas')]
    public function configuracao_ativa_nao_pode_ser_editada_nem_excluida(string $metodo, string $mensagem): void
    {
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $query = Mockery::mock(Builder::class);
        $query->shouldReceive('where')->once()->with('id', 7)->andReturnSelf();
        $query->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $query->shouldReceive('first')->once()->andReturn((object) [
            'id' => 7, 'cod_pleito' => 9306, 'cod_eleicao' => 12454, 'ativo' => 1,
        ]);
        DB::shouldReceive('table')->once()->with('scde_configuracao')->andReturn($query);

        $repository = new ScdeConfiguracaoRepository(Mockery::mock(AuditLogService::class));
        $this->expectException(DomainException::class);
        $this->expectExceptionMessage($mensagem);
        if ($metodo === 'atualizar') {
            $repository->atualizar(7, ['cod_pleito' => 1, 'cod_eleicao' => 2]);
        } else {
            $repository->excluir(7);
        }
    }

    /** @return array<string, array{string,string}> */
    public static function mutacoesBloqueadas(): array
    {
        return [
            'edicao' => ['atualizar', 'ativa nao pode ser editada'],
            'exclusao' => ['excluir', 'ativa nao pode ser excluida'],
        ];
    }
}
```
</TESTS_UNIT_SCDECONFIGURACAOREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeConfiguracaoServiceTest.php`
## <TESTS_UNIT_SCDECONFIGURACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeConfiguracaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeConfiguracaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function ativacao_exige_feature_flag_e_configuracao_segura(): void
public function ativacao_valida_o_ambiente_antes_da_troca_atomica(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Scde\ScdeConfiguracaoRepository;
use App\Services\Scde\ScdeClient;
use App\Services\Scde\ScdeConfiguracaoService;
use DomainException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ScdeConfiguracaoServiceTest extends TestCase
{
    #[Test]
    public function ativacao_exige_feature_flag_e_configuracao_segura(): void
    {
        $repository = Mockery::mock(ScdeConfiguracaoRepository::class);
        $client = Mockery::mock(ScdeClient::class);
        $repository->shouldReceive('ativar')->never();
        $client->shouldReceive('validarConfiguracao')->never();
        config(['services.scde.sync_enabled' => false]);

        $this->expectException(DomainException::class);
        (new ScdeConfiguracaoService($repository, $client))->ativar(7);
    }

    #[Test]
    public function ativacao_valida_o_ambiente_antes_da_troca_atomica(): void
    {
        $repository = Mockery::mock(ScdeConfiguracaoRepository::class);
        $client = Mockery::mock(ScdeClient::class);
        config(['services.scde.sync_enabled' => true]);
        $client->shouldReceive('validarConfiguracao')->once();
        $repository->shouldReceive('ativar')->once()->with(7)->andReturn(2);

        $this->assertSame(2, (new ScdeConfiguracaoService($repository, $client))->ativar(7));
    }
}
```
</TESTS_UNIT_SCDECONFIGURACAOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ScdeStatusServiceTest.php`
## <TESTS_UNIT_SCDESTATUSSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ScdeStatusServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ScdeStatusServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function informa_sucesso_com_totais_sem_expor_configuracao_de_rede(): void
public function falha_da_configuracao_de_ambiente_e_sanitizada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Scde\ScdeConfiguracaoRepository;
use App\Services\Scde\ScdeClient;
use App\Services\Scde\ScdeStatusService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class ScdeStatusServiceTest extends TestCase
{
    #[Test]
    public function informa_sucesso_com_totais_sem_expor_configuracao_de_rede(): void
    {
        config(['services.scde.sync_enabled' => true]);
        $repository = Mockery::mock(ScdeConfiguracaoRepository::class);
        $client = Mockery::mock(ScdeClient::class);
        $client->shouldReceive('validarConfiguracao')->once();
        $repository->shouldReceive('buscarAtiva')->once()->andReturn([
            'id' => 7,
            'cod_pleito' => 9306,
            'cod_eleicao' => 12454,
            'dt_ultima_tentativa' => '2026-09-09 08:00:00',
            'dt_ultimo_sucesso' => '2026-09-09 08:00:10',
            'dt_ultimo_erro' => '2026-09-08 08:00:10',
            'ds_ultimo_erro' => 'Falha anterior segura.',
            'duracao_ultima_ms' => 10000,
            'qtd_zonas' => 9,
            'qtd_secoes' => 2380,
            'qtd_registros' => 4760,
        ]);

        $status = (new ScdeStatusService($repository, $client))->atual();

        $this->assertSame('sucesso', $status['estado']);
        $this->assertSame(4760, $status['qtd_registros']);
        $this->assertArrayNotHasKey('api_token', $status);
        $this->assertArrayNotHasKey('base_url', $status);
    }

    #[Test]
    public function falha_da_configuracao_de_ambiente_e_sanitizada(): void
    {
        config(['services.scde.sync_enabled' => true]);
        $repository = Mockery::mock(ScdeConfiguracaoRepository::class);
        $client = Mockery::mock(ScdeClient::class);
        $client->shouldReceive('validarConfiguracao')->once()->andThrow(new RuntimeException('token-secreto'));
        $repository->shouldReceive('buscarAtiva')->never();

        $status = (new ScdeStatusService($repository, $client))->atual();

        $this->assertSame('indisponivel', $status['estado']);
        $this->assertStringNotContainsString('token-secreto', json_encode($status, JSON_THROW_ON_ERROR));
    }
}
```
</TESTS_UNIT_SCDESTATUSSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SessionsUsernameIndexMigrationTest.php`
## <TESTS_UNIT_SESSIONSUSERNAMEINDEXMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SessionsUsernameIndexMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SessionsUsernameIndexMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_indice_para_username_em_sessions_sem_repetir_quando_ja_existir(): void
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

class SessionsUsernameIndexMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_indice_para_username_em_sessions_sem_repetir_quando_ja_existir(): void
    {
        $conteudo = file_get_contents(database_path('migrations/2026_06_18_130000_add_sessions_username_index.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("Schema::hasTable('sessions')", $conteudo);
        $this->assertStringContainsString("Schema::hasColumn('sessions', 'username')", $conteudo);
        $this->assertStringContainsString("private const INDEX_NAME = 'IX_SESSIONS_USERNAME';", $conteudo);
        $this->assertStringContainsString('FROM user_ind_columns', $conteudo);
        $this->assertStringContainsString('AND column_name = :column_name', $conteudo);
        $this->assertStringContainsString("DB::statement('CREATE INDEX ' . self::INDEX_NAME . ' ON sessions (username)');", $conteudo);
        $this->assertStringContainsString("DB::statement('DROP INDEX ' . self::INDEX_NAME);", $conteudo);
    }
}
```
</TESTS_UNIT_SESSIONSUSERNAMEINDEXMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SolicitacoesPrazoPainelUiTest.php`
## <TESTS_UNIT_SOLICITACOESPRAZOPAINELUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SolicitacoesPrazoPainelUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SolicitacoesPrazoPainelUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function painel_de_solicitacoes_de_prazo_usa_cards_responsivos_em_vez_de_tabela_principal(): void
public function painel_de_solicitacoes_de_prazo_preserva_botoes_de_aprovacao_e_rejeicao(): void
public function painel_de_solicitacoes_de_prazo_exibe_rotulos_explicitos_nos_campos_de_leitura(): void
public function painel_de_solicitacoes_de_prazo_reforca_visualmente_a_separacao_de_cada_pedido(): void
public function painel_de_solicitacoes_de_prazo_renderiza_links_de_paginacao_no_padrao_bootstrap_5(): void
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

class SolicitacoesPrazoPainelUiTest extends TestCase
{
    #[Test]
    public function painel_de_solicitacoes_de_prazo_usa_cards_responsivos_em_vez_de_tabela_principal(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/solicitacoes_prazo_painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('solicitacao-prazo-card', $conteudo);
        $this->assertStringNotContainsString('<table class="table table-sm table-striped align-middle mb-0">', $conteudo);
    }

    #[Test]
    public function painel_de_solicitacoes_de_prazo_preserva_botoes_de_aprovacao_e_rejeicao(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/solicitacoes_prazo_painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('js-abrir-rejeicao', $conteudo);
        $this->assertStringContainsString('btn btn-sm btn-success', $conteudo);
        $this->assertStringContainsString('btn btn-sm btn-danger', $conteudo);
    }

    #[Test]
    public function painel_de_solicitacoes_de_prazo_exibe_rotulos_explicitos_nos_campos_de_leitura(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/solicitacoes_prazo_painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Data da solicitação', $conteudo);
        $this->assertStringContainsString('Período atual', $conteudo);
        $this->assertStringContainsString('Período proposto', $conteudo);
        $this->assertStringContainsString('Unidade atual', $conteudo);
        $this->assertStringContainsString('Unidade proposta', $conteudo);
        $this->assertStringContainsString('Descrição atual', $conteudo);
        $this->assertStringContainsString('Descrição proposta', $conteudo);
    }

    #[Test]
    public function painel_de_solicitacoes_de_prazo_reforca_visualmente_a_separacao_de_cada_pedido(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/solicitacoes_prazo_painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('solicitacao-prazo-card__header', $conteudo);
        $this->assertStringContainsString('solicitacao-prazo-card__footer', $conteudo);
        $this->assertStringContainsString('box-shadow: 0 18px 40px -28px', $conteudo);
        $this->assertStringContainsString('padding: 1.25rem 1.35rem;', $conteudo);
    }

    #[Test]
    public function painel_de_solicitacoes_de_prazo_renderiza_links_de_paginacao_no_padrao_bootstrap_5(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/solicitacoes_prazo_painel.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $conteudo);
    }
}
```
</TESTS_UNIT_SOLICITACOESPRAZOPAINELUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TipoSinalControllerTest.php`
## <TESTS_UNIT_TIPOSINALCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TipoSinalControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TipoSinalControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_tipos_sinal_ordenados(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\TabelasAuxiliares\TipoSinalController;
use App\Repositories\TabelasAuxiliares\TipoSinalRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class TipoSinalControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_tipos_sinal_ordenados(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'codigo' => '4G', 'descricao' => '4G', 'ordem' => 2]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/tipos-sinal']
        );

        $repository = Mockery::mock(TipoSinalRepository::class);
        $repository->shouldReceive('listar')->once()->with(null)->andReturn($paginator);

        $controller = new TipoSinalController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/tipos-sinal', 'GET'));

        $this->assertSame('tabelas-auxiliares.tipos-sinal.index', $response->name());
        $this->assertCount(1, $response->getData()['tiposSinal']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        $registro = (object) ['id' => 3, 'codigo' => '5G', 'descricao' => '5G', 'ordem' => 3];
        $repository = Mockery::mock(TipoSinalRepository::class);
        $repository->shouldReceive('buscar')->once()->with(3)->andReturn($registro);

        $controller = Mockery::mock(TipoSinalController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(3);

        $this->assertSame('tabelas-auxiliares.tipos-sinal.form', $response->name());
        $this->assertSame($registro, $response->getData()['tipoSinal']);
    }
}
```
</TESTS_UNIT_TIPOSINALCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TipoSinalMigrationTest.php`
## <TESTS_UNIT_TIPOSINALMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TipoSinalMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TipoSinalMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_tipo_sinal_com_codigo_descricao_ordem_e_semente(): void
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

class TipoSinalMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_tipo_sinal_com_codigo_descricao_ordem_e_semente(): void
    {
        $arquivo = database_path('migrations/2026_06_20_160000_create_tipo_sinal_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('CREATE TABLE tipo_sinal', $conteudo);
        $this->assertStringContainsString('codigo            VARCHAR2(20 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('descricao         VARCHAR2(160 CHAR) NOT NULL', $conteudo);
        $this->assertStringContainsString('ordem             NUMBER DEFAULT 0 NOT NULL', $conteudo);
        $this->assertStringContainsString('CREATE UNIQUE INDEX ux_tipo_sinal_codigo ON tipo_sinal (UPPER(codigo))', $conteudo);
        $this->assertStringContainsString('DROP TABLE tipo_sinal', $conteudo);

        foreach (['3G', '4G', '5G'] as $codigo) {
            $this->assertStringContainsString("'codigo' => '{$codigo}'", $conteudo);
        }
    }
}
```
</TESTS_UNIT_TIPOSINALMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TipoTomadaControllerTest.php`
## <TESTS_UNIT_TIPOTOMADACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TipoTomadaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TipoTomadaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_retorna_view_com_tipos_tomada_ordenados(): void
public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
public function test_store_cria_tipo_tomada_e_redireciona_com_status(): void
public function test_update_retorna_404_quando_registro_nao_existe(): void
public function test_update_persiste_alteracoes_quando_registro_existe(): void
public function test_destroy_remove_registro_e_redireciona_com_status(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\TabelasAuxiliares\TipoTomadaController;
use App\Http\Requests\TabelasAuxiliares\TipoTomadaRequest;
use App\Repositories\TabelasAuxiliares\TipoTomadaRepository;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use Tests\TestCase;

class TipoTomadaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_retorna_view_com_tipos_tomada_ordenados(): void
    {
        $paginator = new LengthAwarePaginator(
            [(object) ['id' => 1, 'codigo' => '3PINOS_NBR', 'descricao' => '3 pinos (NBR)', 'ordem' => 1]],
            1,
            10,
            1,
            ['path' => '/tabelas-auxiliares/tipos-tomada']
        );

        $repository = Mockery::mock(TipoTomadaRepository::class);
        $repository->shouldReceive('listar')->once()->with(null)->andReturn($paginator);

        $controller = new TipoTomadaController($repository);
        $response = $controller->index(Request::create('/tabelas-auxiliares/tipos-tomada', 'GET'));

        $this->assertSame('tabelas-auxiliares.tipos-tomada.index', $response->name());
        $this->assertCount(1, $response->getData()['tiposTomada']);
    }

    public function test_form_retorna_view_com_registro_quando_id_for_informado(): void
    {
        $registro = (object) ['id' => 2, 'codigo' => '2PINOS_REDONDOS', 'descricao' => '2 pinos redondos', 'ordem' => 2];
        $repository = Mockery::mock(TipoTomadaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(2)->andReturn($registro);

        $controller = Mockery::mock(TipoTomadaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $response = $controller->form(2);

        $this->assertSame('tabelas-auxiliares.tipos-tomada.form', $response->name());
        $this->assertSame($registro, $response->getData()['tipoTomada']);
    }

    public function test_store_cria_tipo_tomada_e_redireciona_com_status(): void
    {
        $dados = [
            'codigo' => '2PINOS_CHATOS',
            'descricao' => '2 pinos chatos',
            'ordem' => 3,
        ];

        $request = Mockery::mock(TipoTomadaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dados);

        $repository = Mockery::mock(TipoTomadaRepository::class);
        $repository->shouldReceive('criar')->once()->with($dados);

        $controller = Mockery::mock(TipoTomadaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->store($request);

        $this->assertSame(route('tabelas-auxiliares.tipos-tomada.index'), $response->getTargetUrl());
        $this->assertSame('Tipo de tomada criado com sucesso!', session('status'));
    }

    public function test_update_retorna_404_quando_registro_nao_existe(): void
    {
        $request = Mockery::mock(TipoTomadaRequest::class);
        $request->shouldReceive('validated')->never();

        $repository = Mockery::mock(TipoTomadaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(9)->andReturn(null);
        $repository->shouldNotReceive('atualizar');

        $controller = Mockery::mock(TipoTomadaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $this->expectException(\Symfony\Component\HttpKernel\Exception\NotFoundHttpException::class);
        $controller->update($request, 9);
    }

    public function test_update_persiste_alteracoes_quando_registro_existe(): void
    {
        $dados = [
            'codigo' => '2PINOS_REDONDOS',
            'descricao' => '2 pinos redondos',
            'ordem' => 4,
        ];

        $request = Mockery::mock(TipoTomadaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dados);

        $repository = Mockery::mock(TipoTomadaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(9)->andReturn((object) ['id' => 9]);
        $repository->shouldReceive('atualizar')->once()->with(9, $dados);

        $controller = Mockery::mock(TipoTomadaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->update($request, 9);

        $this->assertSame(route('tabelas-auxiliares.tipos-tomada.index'), $response->getTargetUrl());
        $this->assertSame('Tipo de tomada atualizado com sucesso!', session('status'));
    }

    public function test_destroy_remove_registro_e_redireciona_com_status(): void
    {
        $repository = Mockery::mock(TipoTomadaRepository::class);
        $repository->shouldReceive('remover')->once()->with(9);

        $controller = Mockery::mock(TipoTomadaController::class, [$repository])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->destroy(Request::create('/tabelas-auxiliares/tipos-tomada/9', 'DELETE'), 9);

        $this->assertSame(route('tabelas-auxiliares.tipos-tomada.index'), $response->getTargetUrl());
        $this->assertSame('Tipo de tomada excluído com sucesso!', session('status'));
    }
}
```
</TESTS_UNIT_TIPOTOMADACONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TipoTomadaMigrationTest.php`
## <TESTS_UNIT_TIPOTOMADAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TipoTomadaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TipoTomadaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_tabela_tipo_tomada_com_codigo_descricao_ordem_e_semente(): void
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

class TipoTomadaMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_tabela_tipo_tomada_com_codigo_descricao_ordem_e_semente(): void
    {
        $arquivo = database_path('migrations/2026_06_20_200000_create_tipo_tomada_table.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);
        $this->assertIsString($conteudo);

        // Estrutura básica da tabela auxiliar
        $this->assertStringContainsString('CREATE TABLE tipo_tomada', $conteudo);
        $this->assertStringContainsString('codigo', $conteudo);
        $this->assertStringContainsString('descricao', $conteudo);
        $this->assertStringContainsString('ordem', $conteudo);
        $this->assertStringContainsString('dt_criacao', $conteudo);
        $this->assertStringContainsString('dt_atualizacao', $conteudo);

        // Unique index no código (upper)
        $this->assertStringContainsString('ux_tipo_tomada_codigo', $conteudo);
        $this->assertStringContainsString('UPPER(codigo)', $conteudo);

        // Semente inicial com os quatro tipos padrão
        $this->assertStringContainsString("'3PINOS_CHATOS'", $conteudo);
        $this->assertStringContainsString("'3PINOS_NBR'", $conteudo);
        $this->assertStringContainsString("'2PINOS_CHATOS'", $conteudo);
        $this->assertStringContainsString("'2PINOS_REDONDOS'", $conteudo);
    }
}
```
</TESTS_UNIT_TIPOTOMADAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ValidacoesEntradaRequestTest.php`
## <TESTS_UNIT_VALIDACOESENTRADAREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ValidacoesEntradaRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ValidacoesEntradaRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function agendamento_canonicaliza_cpf_e_telefone_digitados(): void
public function agendamento_rejeita_data_ambigua_e_cpf_com_caracteres_indevidos(): void
public function ocorrencias_publicas_e_nat_usam_a_mesma_matriz_de_telefone(): void
public function lda_rejeita_o_mesmo_prefixo_de_celular_invalido(): void
public function forcas_de_seguranca_normaliza_titulo_e_telefone_digitados(): void
private function validator(string $requestClass, array $dados): LaravelValidator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\CadastroEleitoral\CadastroEleitoralAgendamentoStoreRequest;
use App\Http\Requests\ForcasSeguranca\SolicitarAcessoRequest;
use App\Http\Requests\Lda\LocalDificilAcessoRequest;
use App\Http\Requests\MesarioPublico\MesarioPublicoOcorrenciaRequest;
use App\Http\Requests\Nat\NatAbrirOcorrenciaRequest;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Validator as LaravelValidator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ValidacoesEntradaRequestTest extends TestCase
{
    #[Test]
    public function agendamento_canonicaliza_cpf_e_telefone_digitados(): void
    {
        $validator = $this->validator(CadastroEleitoralAgendamentoStoreRequest::class, [
            'id_unidade' => 1,
            'id_servico' => 2,
            'dt_inicio' => '2026-07-26 14:30:00',
            'cpf' => '529.982.247-25',
            'telefone' => '(68) 96999-8888',
            'dt_nascimento' => '1990-05-20',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
        $this->assertSame('52998224725', $validator->validated()['cpf']);
        $this->assertSame('68969998888', $validator->validated()['telefone']);
    }

    #[Test]
    public function agendamento_rejeita_data_ambigua_e_cpf_com_caracteres_indevidos(): void
    {
        $validator = $this->validator(CadastroEleitoralAgendamentoStoreRequest::class, [
            'id_unidade' => 1,
            'id_servico' => 2,
            'dt_inicio' => '2026-07-26 14:30:00',
            'cpf' => '529x98224725',
            'dt_nascimento' => '20/05/1990',
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('cpf'));
        $this->assertTrue($validator->errors()->has('dt_nascimento'));
    }

    #[Test]
    public function ocorrencias_publicas_e_nat_usam_a_mesma_matriz_de_telefone(): void
    {
        $mesario = $this->validator(MesarioPublicoOcorrenciaRequest::class, [
            'telefone_solicitante' => '(68) 96999-8888',
            'id_tipo_ocorrencia' => 1,
            'descricao_problema' => 'Sem acesso ao local.',
        ]);
        $nat = $this->validator(NatAbrirOcorrenciaRequest::class, [
            'cod_objeto_local_votacao' => '100',
            'num_secao' => '10',
            'id_tipo_ocorrencia' => 1,
            'descricao_problema' => 'Sem acesso ao local.',
            'telefone_solicitante' => '(68) 96999-8888',
        ]);

        $this->assertFalse($mesario->fails(), (string) $mesario->errors()->first());
        $this->assertFalse($nat->fails(), (string) $nat->errors()->first());
        $this->assertSame('68969998888', $mesario->validated()['telefone_solicitante']);
        $this->assertSame('68969998888', $nat->validated()['telefone_solicitante']);
    }

    #[Test]
    public function lda_rejeita_o_mesmo_prefixo_de_celular_invalido(): void
    {
        $validator = $this->validator(LocalDificilAcessoRequest::class, [
            'telefone' => '68959998888',
        ]);

        $this->assertTrue($validator->errors()->has('telefone'));
    }

    #[Test]
    public function forcas_de_seguranca_normaliza_titulo_e_telefone_digitados(): void
    {
        $validator = $this->validator(SolicitarAcessoRequest::class, [
            'titulo_eleitoral' => '123 456 789',
            'nome' => 'Representante',
            'email' => 'representante@example.com',
            'telefone' => '(68) 3333-4444',
            'orgao' => 'Órgão de segurança',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
        $this->assertSame('000123456789', $validator->validated()['titulo_eleitoral']);
        $this->assertSame('6833334444', $validator->validated()['telefone']);
    }

    /**
     * @param class-string<FormRequest> $requestClass
     * @param array<string, mixed> $dados
     */
    private function validator(string $requestClass, array $dados): LaravelValidator
    {
        $request = $requestClass::create('/teste-validacao', 'POST', $dados);
        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->invoke($request);

        return Validator::make($request->all(), $request->rules(), $request->messages());
    }
}
```
</TESTS_UNIT_VALIDACOESENTRADAREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VwConvocadosMigrationTest.php`
## <TESTS_UNIT_VWCONVOCADOSMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VwConvocadosMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VwConvocadosMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_view_planeleito_vw_convocados_com_campos_esperados(): void
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

class VwConvocadosMigrationTest extends TestCase
{
    #[Test]
    public function migration_cria_view_planeleito_vw_convocados_com_campos_esperados(): void
    {
        $arquivo = database_path('migrations/2026_04_12_225602_create_vw_convocados.php');
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE OR REPLACE VIEW planeleito.vw_convocados AS', $conteudo);
        $this->assertStringContainsString('nom_eleitor,', $conteudo);
        $this->assertStringContainsString('dat_nasc,', $conteudo);
        $this->assertStringContainsString('num_inscricao,', $conteudo);
        $this->assertStringContainsString('num_cpf,', $conteudo);
        $this->assertStringContainsString('num_zona,', $conteudo);
        $this->assertStringContainsString('nom_localidade', $conteudo);
        $this->assertStringContainsString('FROM planeleito.eleitor', $conteudo);
        $this->assertStringContainsString('DROP VIEW planeleito.vw_convocados', $conteudo);
    }
}
```
</TESTS_UNIT_VWCONVOCADOSMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VwUnidadeConvertedEmailMigrationTest.php`
## <TESTS_UNIT_VWUNIDADECONVERTEDEMAILMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VwUnidadeConvertedEmailMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VwUnidadeConvertedEmailMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_incremental_usa_email_da_conversao_e_preserva_email_da_cocre(): void
$up = strstr($conteudo, 'public function down(): void', true);
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

class VwUnidadeConvertedEmailMigrationTest extends TestCase
{
    #[Test]
    public function migration_incremental_usa_email_da_conversao_e_preserva_email_da_cocre(): void
    {
        $arquivo = database_path('migrations/2026_08_10_125000_map_converted_emails_in_vw_unidade.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);

        $up = strstr($conteudo, 'public function down(): void', true);

        $this->assertIsString($up);
        $this->assertStringContainsString("WHEN SIGLA_NORMALIZADA = 'COCRE' THEN 'COCRE'", $up);
        $this->assertStringContainsString("WHEN SIGLA_NORMALIZADA = 'DG' THEN 'GADG'", $up);
        $this->assertStringContainsString("WHEN SIGLA_NORMALIZADA = 'PRESI' THEN 'GAPRES'", $up);
        $this->assertStringContainsString("WHEN SIGLA_NORMALIZADA = 'SAOF' THEN 'GASAOF'", $up);
        $this->assertStringContainsString("WHEN SIGLA_NORMALIZADA = 'SEJUD' THEN 'GAJUD'", $up);
        $this->assertStringContainsString("WHEN SIGLA_NORMALIZADA = 'STI' THEN 'GSTI'", $up);
        $this->assertStringContainsString('END AS SIGLA_EMAIL', $up);
        $this->assertStringContainsString('FROM SIPTSE.UNIDADE UNIDADE_REFERENCIA_EMAIL', $up);
        $this->assertStringContainsString('INNER JOIN SEITSE.EMAIL_UNIDADE EMAIL_REFERENCIA', $up);
        $this->assertStringContainsString('UNIDADE_REFERENCIA_EMAIL.SIGLA = U.SIGLA_EMAIL', $up);
    }
}
```
</TESTS_UNIT_VWUNIDADECONVERTEDEMAILMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VwUnidadePresiTitularMappingMigrationTest.php`
## <TESTS_UNIT_VWUNIDADEPRESITITULARMAPPINGMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VwUnidadePresiTitularMappingMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VwUnidadePresiTitularMappingMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_incremental_mapeia_presi_para_gapres_sem_liberar_todas_as_unidades_sem_email(): void
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

class VwUnidadePresiTitularMappingMigrationTest extends TestCase
{
    #[Test]
    public function migration_incremental_mapeia_presi_para_gapres_sem_liberar_todas_as_unidades_sem_email(): void
    {
        $arquivo = database_path('migrations/2026_08_10_124000_map_presi_to_gapres_in_vw_unidade.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertSame(
            1,
            substr_count($conteudo, "WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'PRESI' THEN 'GAPRES'")
        );
        $this->assertSame(
            2,
            substr_count($conteudo, "WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'DG' THEN 'GADG'")
        );
        $this->assertSame(1, substr_count($conteudo, 'LEFT JOIN SEITSE.EMAIL_UNIDADE EU'));
        $this->assertSame(1, substr_count($conteudo, 'INNER JOIN SEITSE.EMAIL_UNIDADE EU'));
        $this->assertStringContainsString(
            "AND (EU.ID_UNIDADE IS NOT NULL OR U.SIGLA = 'PRESI')",
            $conteudo
        );
    }
}
```
</TESTS_UNIT_VWUNIDADEPRESITITULARMAPPINGMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VwUnidadeTitularMappingMigrationTest.php`
## <TESTS_UNIT_VWUNIDADETITULARMAPPINGMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VwUnidadeTitularMappingMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VwUnidadeTitularMappingMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_incremental_mapeia_dg_para_gadg_e_preserva_aliases_atuais(): void
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

class VwUnidadeTitularMappingMigrationTest extends TestCase
{
    #[Test]
    public function migration_incremental_mapeia_dg_para_gadg_e_preserva_aliases_atuais(): void
    {
        $arquivo = database_path('migrations/2026_08_10_123000_map_dg_to_gadg_in_vw_unidade.php');

        $this->assertFileExists($arquivo);

        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE OR REPLACE FORCE EDITIONABLE VIEW "VW_UNIDADE"', $conteudo);
        $this->assertSame(
            1,
            substr_count($conteudo, "WHEN REPLACE(U.SIGLA, 'ª ZE', 'ZONA') = 'DG' THEN 'GADG'")
        );

        foreach ([
            "'COCRE' THEN 'VICE-CRE'",
            "'STI' THEN 'GSTI'",
            "'SAOF' THEN 'GASAOF'",
            "'SEJUD' THEN 'GAJUD'",
        ] as $aliasExistente) {
            $this->assertSame(2, substr_count($conteudo, $aliasExistente));
        }
    }
}
```
</TESTS_UNIT_VWUNIDADETITULARMAPPINGMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/WrittenPlanningGuardrailTest.php`
## <TESTS_UNIT_WRITTENPLANNINGGUARDRAILTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/WrittenPlanningGuardrailTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class WrittenPlanningGuardrailTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_agents_e_contrato_xp_exigem_planejamento_escrito_versionado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class WrittenPlanningGuardrailTest extends TestCase
{
    public function test_agents_e_contrato_xp_exigem_planejamento_escrito_versionado(): void
    {
        $agents = file_get_contents(base_path('AGENTS.md'));
        $contrato = file_get_contents(base_path('docs/contratos/xp-programming-ai.md'));

        $this->assertIsString($agents);
        $this->assertIsString($contrato);

        $this->assertStringContainsString('## Diretriz de planejamento escrito', $agents);
        $this->assertStringContainsString('plano escrito versionado', $agents);
        $this->assertStringContainsString('memoria ou plano apenas no chat', $agents);
        $this->assertStringContainsString('docs/planejamento/<tema>.md', $agents);
        $this->assertStringContainsString('docs/contratos', $agents);

        $this->assertStringContainsString('## Planejamento escrito obrigatorio', $contrato);
        $this->assertStringContainsString('arquivo versionado no repositorio', $contrato);
        $this->assertStringContainsString('conversa, memoria ou plano apenas no chat nao substituem o registro escrito', $contrato);
        $this->assertStringContainsString('docs/planejamento/<tema>.md', $contrato);
        $this->assertStringContainsString('so entao seguir para `TDD` e implementacao', $contrato);
    }
}
```
</TESTS_UNIT_WRITTENPLANNINGGUARDRAILTEST_PHP>

