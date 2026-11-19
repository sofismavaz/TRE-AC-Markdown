# 📦 Documentação Consolidada do Sistema Crepúsculo (Parte 4)
## Funcionalidade: `funcionalidade_diarias_passagens`
> **Volume Fracionado para Otimização de Leitura por IA**
> **Tamanho Máximo:** 1500 KB

---

---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasSolicitacaoServiceTest.php`
## <TESTS_UNIT_DIARIASSOLICITACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasSolicitacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasSolicitacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
private function cidadesRepositoryMock(): \Mockery\MockInterface
protected function tearDown(): void
public function test_criar_solicitacao_normaliza_usuario_e_beneficiarios_para_o_repository(): void
public function test_solicitar_valida_conflito_antes_de_criar_o_rascunho(): void
public function test_salvar_rascunho_nao_reserva_periodo_do_beneficiario(): void
public function test_solicitar_edicao_valida_conflito_antes_de_atualizar_o_rascunho(): void
public function test_criar_solicitacao_persiste_multiplos_trechos_informados_no_formulario(): void
public function test_criar_solicitacao_persiste_pergunta_de_carro_proprio_e_beneficiario_combustivel(): void
public function test_criar_solicitacao_detecta_viagem_internacional_pela_cidade_do_trecho(): void
public function test_criar_solicitacao_normaliza_adicionais_por_beneficiario_e_dia(): void
public function test_criar_solicitacao_usa_flag_auxilio_tre_reidratada_e_ignora_campos_forjados_no_post(): void
public function test_salvar_rascunho_permite_flag_auxilio_tre_ausente_para_vinculo_alvo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Diarias\Contracts\DiariasAuditoriaSensivelRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasCidadeRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasSolicitacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasTransporteTerrestreRepositoryInterface;
use App\Services\Diarias\Contracts\DiariasPessoaGatewayInterface;
use App\Services\Diarias\DiariasConflitoViagemException;
use App\Services\Diarias\DiariasConflitoViagemService;
use App\Services\Diarias\DiariasSeiService;
use App\Services\Diarias\DiariasSolicitacaoService;
use App\Services\Diarias\DiariasUnidadeSeiService;
use App\Services\Diarias\DiariasUsuario;
use Illuminate\Support\Facades\Http;
use Illuminate\Validation\ValidationException;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class DiariasSolicitacaoServiceTest extends TestCase
{
    private function cidadesRepositoryMock(): \Mockery\MockInterface
    {
        $cidades = Mockery::mock(DiariasCidadeRepositoryInterface::class);
        $cidades->shouldReceive('buscarPorIds')
            ->byDefault()
            ->andReturnUsing(fn (array $ids) => collect($ids)->map(fn ($id) => (object) [
                'id' => (int) $id,
                'nome' => 'Cidade '.$id,
                'uf' => 'AC',
                'pais' => 'BRASIL',
            ]));

        return $cidades;
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_criar_solicitacao_normaliza_usuario_e_beneficiarios_para_o_repository(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $auditoria = Mockery::mock(DiariasAuditoriaSensivelRepositoryInterface::class);

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $gateway->shouldReceive('buscarPorCpf')
            ->once()
            ->with('12345678901')
            ->andReturn([
                'cpf' => '12345678901',
                'matricula' => '309-1570',
                'nome' => 'Ana Silva',
                'email' => 'ana.silva@tre-ac.jus.br',
                'lotacao' => 'FIN',
                'lotacao_id' => '264',
                'lotacao_descricao' => 'Secretaria de Finanças',
                'lotacao_agrupadora_id' => '329',
                'lotacao_agrupadora_sigla' => 'SAOF',
                'lotacao_agrupadora_descricao' => 'Secretaria de Administração, Orçamento e Finanças',
                'cargo_codigo' => '16',
                'cargo' => 'Analista',
                'funcao_codigo' => 'CJ-3',
                'funcao_tipo' => 'CJ',
                'funcao' => 'Servidor',
                'valor_auxilio_alimentacao' => 1860.51,
                'tipo_auxilio_alimentacao' => 'M',
                'valor_auxilio_transporte' => 44.0,
                'tipo_auxilio_transporte' => 'M',
                'titulo_eleitoral' => '002266412453',
                'telefone_celular' => '(68) 99999-0000',
                'ramal' => '4424',
                'banco' => '104',
                'agencia' => '3950',
                'conta' => '998214578-4',
                'tipo_conta' => 'CORRENTE',
                'pix' => 'ana.silva@tre-ac.jus.br',
                'tipo_vinculo' => 'servidor',
                'ativo' => true,
                'titular' => true,
                'situacao_unidade' => 'ATIVO',
                'perfis' => ['DEFERIDOR'],
                'zona' => '1',
                'fonte' => 'visao-pessoa-api',
                'atualizado_em' => '2026-06-26T12:00:00+00:00',
            ]);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais, array $trechos): bool {
                return $solicitacao['usuario_criacao'] === 'edcley'
                    && $solicitacao['requerente_username'] === 'edcley'
                    && $solicitacao['status'] === 'RASCUNHO'
                    && $solicitacao['cidade_origem_id'] === 10
                    && $solicitacao['cidade_destino_id'] === 20
                    && $solicitacao['justificativa_fim_semana_feriado'] === 'Atividade institucional abrange fim de semana.'
                    && $solicitacao['justificativa_pernoite'] === 'A agenda exige permanência no destino.'
                    && ! array_key_exists('cidade_origem', $solicitacao)
                    && ! array_key_exists('cidade_destino', $solicitacao)
                    && $beneficiarios[0]['cpf'] === '12345678901'
                    && $beneficiarios[0]['nome'] === 'Ana Silva'
                    && $beneficiarios[0]['matricula'] === '309-1570'
                    && $beneficiarios[0]['lotacao_id'] === '264'
                    && $beneficiarios[0]['lotacao_descricao'] === 'Secretaria de Finanças'
                    && $beneficiarios[0]['lotacao_agrupadora_id'] === '329'
                    && $beneficiarios[0]['lotacao_agrupadora_sigla'] === 'SAOF'
                    && $beneficiarios[0]['lotacao_agrupadora_descricao'] === 'Secretaria de Administração, Orçamento e Finanças'
                    && $beneficiarios[0]['cargo_codigo'] === '16'
                    && $beneficiarios[0]['funcao_codigo'] === 'CJ-3'
                    && $beneficiarios[0]['valor_auxilio_alimentacao'] === 1860.51
                    && $beneficiarios[0]['tipo_auxilio_alimentacao'] === 'M'
                    && $beneficiarios[0]['titulo_eleitoral'] === '002266412453'
                    && $beneficiarios[0]['telefone_celular'] === '(68) 99999-0000'
                    && $beneficiarios[0]['ramal'] === '4424'
                    && $beneficiarios[0]['tipo_conta'] === 'CORRENTE'
                    && $beneficiarios[0]['pix'] === 'ana.silva@tre-ac.jus.br'
                    && $beneficiarios[0]['tipo_vinculo'] === 'SERVIDOR'
                    && $beneficiarios[0]['ativo'] === 1
                    && $beneficiarios[0]['titular'] === 1
                    && $beneficiarios[0]['situacao_unidade'] === 'ATIVO'
                    && $beneficiarios[0]['zona'] === '1'
                    && $beneficiarios[0]['pessoa_api_fonte'] === 'visao-pessoa-api'
                    && $beneficiarios[0]['pessoa_api_atualizado_em'] === '2026-06-26T12:00:00+00:00'
                    && $beneficiarios[0]['pessoa_api_perfis_json'] === '["DEFERIDOR"]'
                    && str_contains($beneficiarios[0]['pessoa_api_snapshot_json'], '"tipo_vinculo":"servidor"')
                    && str_contains($beneficiarios[0]['pessoa_api_snapshot_json'], '"lotacao_agrupadora_sigla":"SAOF"')
                    && count($adicionais) === 3
                    && array_column($adicionais, 'data_dia') === ['2026-07-10', '2026-07-11', '2026-07-12']
                    && array_column($adicionais, 'pernoite') === ['SIM', 'SIM', 'NAO']
                    && $trechos[0]['cidade_origem_id'] === 10
                    && $trechos[0]['cidade_destino_id'] === 20
                    && $trechos[0]['data_partida'] === '2026-07-10'
                    && $trechos[0]['data_chegada'] === '2026-07-12'
                    && $trechos[0]['usuario_criacao'] === 'edcley';
            })
            ->andReturn(77);

        $auditoria->shouldReceive('registrar')
            ->once()
            ->withArgs(static fn (array $evento): bool => $evento['tipo_evento'] === 'SOLICITACAO_CRIADA'
                && $evento['dados_depois']['justificativa_pernoite'] === 'A agenda exige permanência no destino.');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, $auditoria);

        $id = $service->criar([
            'motivo' => 'Reunião de alinhamento',
            'observacoes' => null,
            'justificativa_fim_semana_feriado' => 'Atividade institucional abrange fim de semana.',
            'justificativa_pernoite' => 'A agenda exige permanência no destino.',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01'],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-12',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_solicitar_valida_conflito_antes_de_criar_o_rascunho(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $conflitos = Mockery::mock(DiariasConflitoViagemService::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $conflitos->shouldReceive('validarProposta')
            ->once()
            ->withArgs(static function (array $beneficiarios, array $trechos, ?int $ignorar, bool $bloquear): bool {
                return $beneficiarios[0]['cpf'] === '12345678901'
                    && $trechos[0]['data_partida'] === '2026-07-10'
                    && $trechos[0]['data_chegada'] === '2026-07-10'
                    && $ignorar === null
                    && $bloquear === false;
            })
            ->andThrow(new DiariasConflitoViagemException(collect([(object) [
                'cpf' => '12345678901',
                'beneficiario_nome' => 'Ana Silva',
                'solicitacao_id' => 99,
                'data_inicio' => '2026-07-10',
                'data_fim' => '2026-07-11',
                'roteiro' => 'Rio Branco/AC -> Brasília/DF',
            ]])));
        $repository->shouldNotReceive('criar');

        $service = new DiariasSolicitacaoService(
            $repository,
            $cidades,
            $gateway,
            $transportes,
            conflitos: $conflitos,
        );

        $this->expectException(DiariasConflitoViagemException::class);
        $service->criar($this->dadosBasicos(['acao' => 'solicitar']), $this->usuario());
    }

    public function test_salvar_rascunho_nao_reserva_periodo_do_beneficiario(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $conflitos = Mockery::mock(DiariasConflitoViagemService::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $conflitos->shouldNotReceive('validarProposta');
        $repository->shouldReceive('criar')->once()->andReturn(77);

        $service = new DiariasSolicitacaoService(
            $repository,
            $cidades,
            $gateway,
            $transportes,
            conflitos: $conflitos,
        );

        $this->assertSame(77, $service->criar($this->dadosBasicos(['acao' => 'rascunho']), $this->usuario()));
    }

    public function test_solicitar_edicao_valida_conflito_antes_de_atualizar_o_rascunho(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $conflitos = Mockery::mock(DiariasConflitoViagemService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida());
        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $conflitos->shouldReceive('validarProposta')
            ->once()
            ->withArgs(static fn (array $beneficiarios, array $trechos, ?int $ignorar, bool $bloquear): bool => $beneficiarios[0]['cpf'] === '12345678901'
                && $trechos[0]['data_partida'] === '2026-07-10'
                && $ignorar === 77
                && $bloquear === false)
            ->andThrow(new DiariasConflitoViagemException(collect([(object) [
                'cpf' => '12345678901',
                'beneficiario_nome' => 'Ana Silva',
                'solicitacao_id' => 99,
                'data_inicio' => '2026-07-10',
                'data_fim' => '2026-07-11',
            ]])));
        $repository->shouldNotReceive('atualizarRascunho');

        $service = new DiariasSolicitacaoService(
            $repository,
            $cidades,
            $gateway,
            $transportes,
            conflitos: $conflitos,
        );

        $this->expectException(DiariasConflitoViagemException::class);
        $service->atualizarRascunho(77, $this->dadosBasicos(['acao' => 'solicitar']), $this->usuario());
    }

    public function test_criar_solicitacao_persiste_multiplos_trechos_informados_no_formulario(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20, 30, 40])
            ->andReturn(true);

        $gateway->shouldReceive('buscarPorCpf')
            ->once()
            ->with('12345678901')
            ->andReturn([
                'cpf' => '12345678901',
                'nome' => 'Ana Silva',
                'email' => 'ana.silva@tre-ac.jus.br',
                'lotacao' => 'FIN',
                'cargo' => 'Analista',
                'funcao' => 'Servidor',
            ]);

        $trechosCriados = [];

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais, array $trechos) use (&$trechosCriados): bool {
                $trechosCriados = $trechos;

                return $solicitacao['cidade_origem_id'] === 10
                    && $solicitacao['cidade_destino_id'] === 40
                    && $solicitacao['data_partida'] === '2026-07-10'
                    && $solicitacao['data_retorno'] === '2026-07-13'
                    && count($beneficiarios) === 1
                    && count($adicionais) === 4;
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Viagem com pernoite em mais de uma cidade',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01'],
            ],
            'trechos' => [
                [
                    'cidade_origem_id' => '10',
                    'cidade_destino_id' => '20',
                    'data_partida' => '2026-07-10',
                    'data_chegada' => '2026-07-10',
                    'modal_codigo' => 'TERRESTRE',
                    'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
                ],
                [
                    'cidade_origem_id' => '20',
                    'cidade_destino_id' => '30',
                    'data_partida' => '2026-07-11',
                    'data_chegada' => '2026-07-12',
                    'modal_codigo' => 'AEREO',
                ],
                [
                    'cidade_origem_id' => '30',
                    'cidade_destino_id' => '40',
                    'data_partida' => '2026-07-13',
                    'data_chegada' => '2026-07-13',
                    'modal_codigo' => 'TERRESTRE',
                    'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
                ],
            ],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
        $this->assertSame([10, 20, 30], array_column($trechosCriados, 'cidade_origem_id'));
        $this->assertSame([20, 30, 40], array_column($trechosCriados, 'cidade_destino_id'));
        $this->assertSame(['2026-07-10', '2026-07-11', '2026-07-13'], array_column($trechosCriados, 'data_partida'));
        $this->assertSame(['2026-07-10', '2026-07-12', '2026-07-13'], array_column($trechosCriados, 'data_chegada'));
        $this->assertSame(['TERRESTRE', 'AEREO', 'TERRESTRE'], array_column($trechosCriados, 'modal_codigo'));
    }

    public function test_criar_solicitacao_persiste_pergunta_de_carro_proprio_e_beneficiario_combustivel(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $pessoas = [
            '12345678901' => ['cpf' => '12345678901', 'nome' => 'Ana Silva', 'email' => 'ana@tre-ac.jus.br', 'lotacao' => 'STI'],
            '98765432100' => ['cpf' => '98765432100', 'nome' => 'Bruno Lima', 'email' => 'bruno@tre-ac.jus.br', 'lotacao' => 'DG'],
        ];

        $gateway->shouldReceive('buscarPorCpf')
            ->twice()
            ->andReturnUsing(fn (string $cpf): ?array => $pessoas[$cpf] ?? null);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais, array $trechos): bool {
                $trecho = $trechos[0];
                $cpfs = json_decode((string) $trecho['beneficiarios_combustivel_json'], true);

                return $solicitacao['motivo'] === 'Viagem terrestre com carro próprio'
                    && $trecho['modal_codigo'] === 'TERRESTRE'
                    && $trecho['transporte_terrestre_codigo'] === 'PROPRIO'
                    && $trecho['necessita_motorista'] === 0
                    && $cpfs === ['98765432100']
                    && $trecho['informacoes_complementares'] === 'Saída após expediente.';
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Viagem terrestre com carro próprio',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01'],
                ['cpf' => '987.654.321-00'],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'PROPRIO',
                'beneficiarios_combustivel' => ['987.654.321-00'],
                'informacoes_complementares' => 'Saída após expediente.',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_criar_solicitacao_detecta_viagem_internacional_pela_cidade_do_trecho(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 90])
            ->andReturn(true);
        $cidades->shouldReceive('buscarPorIds')
            ->once()
            ->with([10, 90])
            ->andReturn(collect([
                (object) ['id' => 10, 'nome' => 'Rio Branco', 'uf' => 'AC', 'pais' => 'BRASIL'],
                (object) ['id' => 90, 'nome' => 'New York', 'uf' => null, 'pais' => 'United States'],
            ]));

        $gateway->shouldReceive('buscarPorCpf')
            ->once()
            ->with('11122233344')
            ->andReturn([
                'id' => 'pessoa-api-77',
                'cpf' => '11122233344',
                'nome' => 'Maria Externa',
                'email' => 'maria.externa@example.org',
                'lotacao' => 'Órgão parceiro',
                'cargo' => 'Consultora',
                'funcao' => 'Colaboradora eventual',
                'tipo_vinculo' => 'externo',
                'orgao_origem' => 'Órgão parceiro',
                'fonte' => 'visao-pessoa-api',
                'atualizado_em' => '2026-06-28T12:00:00+00:00',
            ]);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais): bool {
                $viagem = $solicitacao['viagem_internacional_dados'] ?? [];

                return $solicitacao['viagem_internacional'] === 1
                    && $solicitacao['substituicao_funcional'] === 'SIM'
                    && $solicitacao['substituto_cpf'] === '52998224725'
                    && $solicitacao['substituto_nome'] === 'João Substituto'
                    && $solicitacao['cargo_substituido'] === 'Diretor da unidade'
                    && $solicitacao['periodo_substituicao_inicio'] === '2026-08-03'
                    && $solicitacao['periodo_substituicao_fim'] === '2026-08-05'
                    && $beneficiarios[0]['tipo_colaborador'] === 'COLABORADOR_EVENTUAL'
                    && $beneficiarios[0]['colaborador_externo'] === 1
                    && $beneficiarios[0]['pessoa_api_id'] === 'pessoa-api-77'
                    && $beneficiarios[0]['orgao_origem'] === 'Órgão parceiro'
                    && $beneficiarios[0]['funcao_equivalente_codigo'] === 'CJ-3'
                    && $beneficiarios[0]['atividade_equivalente'] === 'Apoio técnico em missão internacional'
                    && $beneficiarios[0]['declara_auxilio_alimentacao'] === 'SIM'
                    && $beneficiarios[0]['valor_auxilio_alimentacao_declarado'] === 35.5
                    && $beneficiarios[0]['valor_auxilio_alimentacao'] === 35.5
                    && $beneficiarios[0]['tipo_auxilio_alimentacao'] === 'D'
                    && $beneficiarios[0]['declara_auxilio_transporte'] === 'SIM'
                    && $beneficiarios[0]['valor_auxilio_transporte_declarado'] === 12.25
                    && $beneficiarios[0]['valor_auxilio_transporte'] === 12.25
                    && $beneficiarios[0]['tipo_auxilio_transporte'] === 'D'
                    && count($adicionais) === 3
                    && $viagem['pais_codigo'] === null
                    && $viagem['pais_nome'] === 'United States'
                    && $viagem['moeda_codigo'] === 'USD'
                    && $viagem['recebimento_moeda_nacional'] === 0
                    && $viagem['taxa_cambio'] === null
                    && $viagem['taxa_cambio_data'] === null
                    && $viagem['taxa_cambio_fonte'] === null
                    && $viagem['ordem_bancaria_data'] === null
                    && $viagem['relatorio_missao_prazo'] === '2026-09-04';
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Missão internacional',
            'substituicao_funcional' => '1',
            'substituto_cpf' => '529.982.247-25',
            'substituto_nome' => 'João Substituto',
            'cargo_substituido' => 'Diretor da unidade',
            'ato_substituicao' => 'Portaria 10/2026',
            'periodo_substituicao_inicio' => '2026-08-03',
            'periodo_substituicao_fim' => '2026-08-05',
            'beneficiarios' => [[
                'cpf' => '111.222.333-44',
                'tipo_colaborador' => 'colaborador_eventual',
                'funcao_equivalente_codigo' => 'cj-3',
                'atividade_equivalente' => 'Apoio técnico em missão internacional',
                'declara_auxilio_alimentacao' => '1',
                'valor_auxilio_alimentacao_declarado' => '35,50',
                'declara_auxilio_transporte' => '1',
                'valor_auxilio_transporte_declarado' => '12,25',
            ]],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '90',
                'data_partida' => '2026-08-03',
                'data_chegada' => '2026-08-05',
                'modal_codigo' => 'AEREO',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_criar_solicitacao_normaliza_adicionais_por_beneficiario_e_dia(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $gateway->shouldReceive('buscarPorCpf')
            ->once()
            ->with('12345678901')
            ->andReturn([
                'cpf' => '12345678901',
                'nome' => 'Ana Silva',
                'email' => 'ana.silva@tre-ac.jus.br',
                'lotacao' => 'FIN',
                'cargo' => 'Analista',
                'funcao' => 'Servidor',
            ]);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais): bool {
                return $beneficiarios[0]['acompanha_juiz'] === 'SIM'
                    && count($adicionais) === 2
                    && $adicionais[0]['beneficiario_cpf'] === '12345678901'
                    && $adicionais[0]['data_dia'] === '2026-07-10'
                    && $adicionais[0]['acompanha_juiz'] === 'SIM'
                    && $adicionais[0]['pernoite'] === 'NAO'
                    && $adicionais[0]['pousada'] === 'SIM'
                    && $adicionais[0]['hospedagem_publica'] === 'SIM'
                    && $adicionais[0]['origem'] === 'AVANCADO'
                    && $adicionais[1]['data_dia'] === '2026-07-11'
                    && $adicionais[1]['pernoite'] === 'NAO'
                    && $adicionais[1]['hospedagem_publica'] === 'NAO';
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Reunião de alinhamento',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01'],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-11',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
            'adicionais' => [
                [
                    'beneficiario_cpf' => '123.456.789-01',
                    'data' => '2026-07-10',
                    'acompanha_juiz' => '1',
                    'pernoite' => '0',
                    'pousada' => '1',
                    'hospedagem_publica' => '1',
                    'origem' => 'AVANCADO',
                ],
            ],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_criar_solicitacao_usa_flag_auxilio_tre_reidratada_e_ignora_campos_forjados_no_post(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $gateway->shouldReceive('buscarPorCpf')
            ->once()
            ->with('12345678901')
            ->andReturn([
                'cpf' => '12345678901',
                'nome' => 'Ana Silva',
                'email' => 'ana.silva@tre-ac.jus.br',
                'lotacao' => 'FIN',
                'cargo' => 'Analista',
                'funcao' => 'Servidor',
                'tipo_vinculo' => 'REQUISITADO',
                'recebe_auxilio_alimentacao_tre' => 'SIM',
            ]);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais): bool {
                return $beneficiarios[0]['tipo_vinculo'] === 'REQUISITADO'
                    && $beneficiarios[0]['tipo_colaborador'] === null
                    && $beneficiarios[0]['recebe_auxilio_alimentacao_tre'] === 'SIM'
                    && $beneficiarios[0]['recebe_auxilio_alimentacao_orgao_origem'] === null
                    && $beneficiarios[0]['valor_auxilio_alimentacao'] === null
                    && $beneficiarios[0]['tipo_auxilio_alimentacao'] === null
                    && str_contains($beneficiarios[0]['pessoa_api_snapshot_json'], '"recebe_auxilio_alimentacao_tre":"SIM"');
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Viagem de servidor requisitado',
            'beneficiarios' => [[
                'cpf' => '123.456.789-01',
                'tipo_colaborador' => 'COLABORADOR',
                'recebe_auxilio_alimentacao_tre' => 'NAO',
                'recebe_auxilio_alimentacao_orgao_origem' => 'SIM',
                'recebe_auxilio_alimentacao' => '1',
                'valor_auxilio_alimentacao_declarado' => '1.00',
            ]],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_salvar_rascunho_permite_flag_auxilio_tre_ausente_para_vinculo_alvo(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $gateway->shouldReceive('buscarPorCpf')
            ->once()
            ->with('12345678901')
            ->andReturn([
                'cpf' => '12345678901',
                'nome' => 'Ana Silva',
                'tipo_vinculo' => 'CEDIDO',
                'recebe_auxilio_alimentacao_tre' => null,
            ]);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(static fn (array $solicitacao, array $beneficiarios): bool => $beneficiarios[0]['tipo_vinculo'] === 'CEDIDO'
                && $beneficiarios[0]['recebe_auxilio_alimentacao_tre'] === null)
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Viagem de servidor cedido',
            'beneficiarios' => [[
                'cpf' => '123.456.789-01',
            ]],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_solicitar_rejeita_flag_auxilio_tre_ausente_para_vinculo_alvo(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn([
            'cpf' => '12345678901',
            'nome' => 'Ana Silva',
            'tipo_vinculo' => 'NOMEADO',
            'recebe_auxilio_alimentacao_tre' => null,
        ]);
        $repository->shouldNotReceive('criar');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        try {
            $service->criar($this->dadosBasicos(['acao' => 'solicitar']), $this->usuario());
            $this->fail('O envio deveria falhar sem a flag de auxílio-alimentação do TRE.');
        } catch (ValidationException $exception) {
            $this->assertArrayHasKey('beneficiarios.0.recebe_auxilio_alimentacao_tre', $exception->errors());
        }
    }

    public function test_salvar_rascunho_permite_auxilio_origem_ausente_para_requisitado_sem_auxilio_tre(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn(
            $this->pessoaBasica([
                'tipo_vinculo' => 'REQUISITADO',
                'recebe_auxilio_alimentacao_tre' => 'NAO',
            ]),
        );
        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(static fn (array $solicitacao, array $beneficiarios): bool => $beneficiarios[0]['recebe_auxilio_alimentacao_orgao_origem'] === null
                && $beneficiarios[0]['valor_auxilio_alimentacao_declarado'] === null
                && $beneficiarios[0]['valor_auxilio_alimentacao'] === null)
            ->andReturn(77);

        $id = (new DiariasSolicitacaoService($repository, $cidades, $gateway, $this->transportesTerrestres()))
            ->criar($this->dadosBasicos(), $this->usuario());

        $this->assertSame(77, $id);
    }

    public function test_solicitar_exige_resposta_auxilio_origem_para_cedido_sem_auxilio_tre(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn(
            $this->pessoaBasica([
                'tipo_vinculo' => 'CEDIDO',
                'recebe_auxilio_alimentacao_tre' => 'NAO',
            ]),
        );
        $repository->shouldNotReceive('criar');

        try {
            (new DiariasSolicitacaoService($repository, $cidades, $gateway, $this->transportesTerrestres()))
                ->criar($this->dadosBasicos(['acao' => 'solicitar']), $this->usuario());
            $this->fail('O envio deveria exigir a declaração de auxílio do órgão de origem.');
        } catch (ValidationException $exception) {
            $this->assertArrayHasKey('beneficiarios.0.recebe_auxilio_alimentacao_orgao_origem', $exception->errors());
        }
    }

    public function test_solicitar_exige_valor_mensal_quando_auxilio_origem_for_sim(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn(
            $this->pessoaBasica([
                'tipo_vinculo' => 'REQUISITADO',
                'recebe_auxilio_alimentacao_tre' => 'NAO',
            ]),
        );
        $repository->shouldNotReceive('criar');

        try {
            (new DiariasSolicitacaoService($repository, $cidades, $gateway, $this->transportesTerrestres()))
                ->criar($this->dadosBasicos([
                    'acao' => 'solicitar',
                    'beneficiarios' => [[
                        'cpf' => '123.456.789-01',
                        'recebe_auxilio_alimentacao_orgao_origem' => 'SIM',
                    ]],
                ]), $this->usuario());
            $this->fail('O envio deveria exigir o valor mensal do auxílio do órgão de origem.');
        } catch (ValidationException $exception) {
            $this->assertArrayHasKey('beneficiarios.0.valor_auxilio_alimentacao_declarado', $exception->errors());
        }
    }

    public function test_rascunho_persiste_auxilio_origem_mensal_para_requisitado(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn(
            $this->pessoaBasica([
                'tipo_vinculo' => 'REQUISITADO',
                'recebe_auxilio_alimentacao_tre' => 'NAO',
            ]),
        );
        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(static fn (array $solicitacao, array $beneficiarios): bool => $beneficiarios[0]['recebe_auxilio_alimentacao_orgao_origem'] === 'SIM'
                && $beneficiarios[0]['valor_auxilio_alimentacao_declarado'] === 2200.0
                && $beneficiarios[0]['valor_auxilio_alimentacao'] === 2200.0
                && $beneficiarios[0]['tipo_auxilio_alimentacao'] === 'M')
            ->andReturn(77);

        $id = (new DiariasSolicitacaoService($repository, $cidades, $gateway, $this->transportesTerrestres()))
            ->criar($this->dadosBasicos([
                'beneficiarios' => [[
                    'cpf' => '123.456.789-01',
                    'recebe_auxilio_alimentacao_orgao_origem' => 'SIM',
                    'valor_auxilio_alimentacao_declarado' => '2.200,00',
                ]],
            ]), $this->usuario());

        $this->assertSame(77, $id);
    }

    public function test_criar_solicitacao_persiste_equipe_de_trabalho_e_justificativa_auxilio_curto(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $pessoas = [
            '12345678901' => [
                'cpf' => '12345678901',
                'nome' => 'Ana Silva',
                'funcao_codigo' => 'CJ-3',
                'tipo_vinculo' => 'SERVIDOR',
            ],
            '98765432100' => [
                'cpf' => '98765432100',
                'nome' => 'Bruno Lima',
                'funcao_codigo' => 'CJ-1',
                'tipo_vinculo' => 'REQUISITADO',
                'recebe_auxilio_alimentacao_tre' => 'NAO',
            ],
        ];

        $gateway->shouldReceive('buscarPorCpf')
            ->twice()
            ->andReturnUsing(fn (string $cpf): ?array => $pessoas[$cpf] ?? null);

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao, array $beneficiarios, array $adicionais): bool {
                return $solicitacao['equipe_trabalho_ato'] === '1234567'
                    && $beneficiarios[0]['equipe_trabalho'] === 'SIM'
                    && $beneficiarios[1]['equipe_trabalho'] === 'NAO'
                    && $beneficiarios[1]['tipo_vinculo'] === 'REQUISITADO'
                    && $beneficiarios[1]['recebe_auxilio_alimentacao_tre'] === 'NAO'
                    && $beneficiarios[1]['valor_auxilio_alimentacao'] === null
                    && $beneficiarios[1]['justificativa_auxilio_alimentacao_curto'] === 'Requisitado em atividade essencial fora da sede.';
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $id = $service->criar([
            'motivo' => 'Equipe de trabalho em atividade institucional',
            'equipe_trabalho_ato' => '1234567',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01', 'equipe_trabalho' => '1'],
                [
                    'cpf' => '987.654.321-00',
                    'recebe_auxilio_alimentacao' => '1',
                    'valor_auxilio_alimentacao' => '1860.51',
                    'justificativa_auxilio_alimentacao_curto' => 'Requisitado em atividade essencial fora da sede.',
                ],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));

        $this->assertSame(77, $id);
    }

    public function test_solicitar_rejeita_equipe_de_trabalho_sem_documento_autorizador(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 20])
            ->andReturn(true);

        $pessoas = [
            '12345678901' => $this->pessoaBasica(),
            '98765432100' => $this->pessoaBasica([
                'cpf' => '98765432100',
                'nome' => 'Bruno Lima',
            ]),
        ];
        $gateway->shouldReceive('buscarPorCpf')
            ->twice()
            ->andReturnUsing(fn (string $cpf): ?array => $pessoas[$cpf] ?? null);

        $repository->shouldNotReceive('criar');
        $repository->shouldNotReceive('criarTrechoBase');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $this->expectException(ValidationException::class);

        $service->criar([
            'acao' => 'solicitar',
            'motivo' => 'Equipe de trabalho sem ato',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01', 'equipe_trabalho' => '1'],
                ['cpf' => '987.654.321-00', 'equipe_trabalho' => '1'],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));
    }

    public function test_solicitar_rejeita_equipe_de_trabalho_com_apenas_um_integrante(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $repository->shouldNotReceive('criar');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        try {
            $service->criar($this->dadosBasicos([
                'acao' => 'solicitar',
                'equipe_trabalho_ato' => '0000764',
                'equipe_trabalho_ato_id_protocolo' => '973',
                'beneficiarios' => [[
                    'cpf' => '123.456.789-01',
                    'equipe_trabalho' => 'SIM',
                ]],
            ]), $this->usuario());
            $this->fail('A solicitacao deveria exigir ao menos dois integrantes na equipe.');
        } catch (ValidationException $exception) {
            $this->assertArrayHasKey('beneficiarios', $exception->errors());
            $this->assertStringContainsString('ao menos dois integrantes', $exception->errors()['beneficiarios'][0]);
        }
    }

    public function test_rejeita_cpf_duplicado_em_blocos_de_beneficiarios_distintos(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $repository->shouldNotReceive('criar');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        try {
            $service->criar($this->dadosBasicos([
                'beneficiarios' => [
                    ['cpf' => '123.456.789-01', 'equipe_trabalho' => 'NAO'],
                    ['cpf' => '12345678901', 'equipe_trabalho' => 'SIM'],
                ],
            ]), $this->usuario());
            $this->fail('A solicitacao deveria rejeitar CPF duplicado entre os blocos.');
        } catch (ValidationException $exception) {
            $this->assertArrayHasKey('beneficiarios.1.cpf', $exception->errors());
            $this->assertStringContainsString('já foi adicionado', $exception->errors()['beneficiarios.1.cpf'][0]);
        }
    }

    public function test_criar_solicitacao_rejeita_cidade_inexistente(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();

        $cidades->shouldReceive('idsExistem')
            ->once()
            ->with([10, 999])
            ->andReturn(false);

        $repository->shouldNotReceive('criar');
        $repository->shouldNotReceive('criarTrechoBase');
        $gateway->shouldNotReceive('buscarPorCpf');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes);

        $this->expectException(ValidationException::class);

        $service->criar([
            'motivo' => 'Reunião de alinhamento',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01'],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '999',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        ));
    }

    public function test_criar_solicitacao_gerando_sei_persiste_rascunho_sem_chamar_sei(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());

        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao): bool {
                return $solicitacao['status'] === 'RASCUNHO'
                    && $solicitacao['sei_procedimento_id'] === null
                    && $solicitacao['sei_procedimento'] === null
                    && $solicitacao['sei_resumo_documento_id'] === null
                    && $solicitacao['sei_resumo_documento_formatado'] === null
                    && $solicitacao['sei_resumo_documento_link'] === null;
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $id = $service->criar($this->dadosBasicos([
            'motivo' => 'Resumo operacional',
            'processo_sei_modo' => 'GERAR',
        ]), $this->usuario());

        $this->assertSame(77, $id);
    }

    public function test_tentar_integracao_sei_gera_processo_inclui_resumo_e_atualiza_retorno(): void
    {
        $this->fakeApiUnidadesSei([
            ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')
            ->once()
            ->with(77)
            ->andReturn($this->solicitacaoPersistida(['motivo' => 'Resumo operacional']));
        $repository->shouldReceive('beneficiarios')->once()->with(77)->andReturn($this->beneficiariosPersistidos());
        $repository->shouldReceive('adicionais')->once()->with(77)->andReturn($this->adicionaisPersistidos());
        $repository->shouldReceive('trechos')->once()->with(77)->andReturn($this->trechosPersistidos());

        $sei->shouldReceive('gerarProcessoDiaria')
            ->once()
            ->withArgs(fn (array $dados, DiariasUsuario $usuario, string $idUnidadeSei): bool => $dados['motivo'] === 'Resumo operacional'
                && $dados['beneficiarios'][0]['cpf'] === '12345678901'
                && $dados['trechos'][0]['cidade_origem_busca'] === 'Cidade 10/AC'
                && $usuario->username === 'edcley'
                && $idUnidadeSei === '288')
            ->andReturn([
                'id_procedimento' => '1210000000774',
                'procedimento_formatado' => '0000121-77.2026.6.24.8000',
                'link_acesso' => 'https://sei.example/processo',
            ]);

        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->ordered()
            ->withArgs(function (int $id, array $dadosSei, string $usuario): bool {
                return $id === 77
                    && $dadosSei['sei_procedimento_id'] === '1210000000774'
                    && $dadosSei['sei_procedimento'] === '0000121-77.2026.6.24.8000'
                    && $dadosSei['sei_resumo_documento_id'] === null
                    && $usuario === 'edcley';
            });

        $sei->shouldReceive('incluirResumoSolicitacao')
            ->once()
            ->withArgs(function (
                string $idProcedimento,
                string $procedimentoFormatado,
                array $solicitacao,
                array $beneficiarios,
                array $adicionais,
                array $trechos,
                ?array $viagemInternacional,
                DiariasUsuario $usuario,
                string $idUnidadeSei
            ): bool {
                return $idProcedimento === '1210000000774'
                    && $procedimentoFormatado === '0000121-77.2026.6.24.8000'
                    && $solicitacao['motivo'] === 'Resumo operacional'
                    && $solicitacao['sei_procedimento_id'] === '1210000000774'
                    && $beneficiarios[0]['cpf'] === '12345678901'
                    && $adicionais !== []
                    && $trechos[0]['cidade_origem_texto'] === 'Cidade 10/AC'
                    && $trechos[0]['cidade_destino_texto'] === 'Cidade 20/AC'
                    && $viagemInternacional === null
                    && $usuario->username === 'edcley'
                    && $idUnidadeSei === '288';
            })
            ->andReturn([
                'id_documento' => '1140000000872',
                'documento_formatado' => '0003934',
                'link_acesso' => 'https://sei.example/documento',
            ]);

        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->ordered()
            ->withArgs(function (int $id, array $dadosSei, string $usuario): bool {
                return $id === 77
                    && $dadosSei['sei_resumo_documento_id'] === '1140000000872'
                    && $dadosSei['sei_resumo_documento_formatado'] === '0003934'
                    && $dadosSei['sei_resumo_documento_link'] === 'https://sei.example/documento'
                    && $usuario === 'edcley';
            })
            ->andReturn(1);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR', '288');

        $this->assertTrue($resultado['completa']);
        $this->assertNull($resultado['mensagem']);
        Http::assertNotSent(static fn ($request): bool => str_contains($request->url(), '/procedimento-unidades/'));
    }

    public function test_tentar_integracao_sei_para_gerar_processo_exige_unidade_sei_transitoria(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida());
        $repository->shouldNotReceive('beneficiarios');
        $repository->shouldNotReceive('adicionais');
        $repository->shouldNotReceive('trechos');
        $repository->shouldNotReceive('atualizarDadosSei');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('unidade SEI', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_para_gerar_processo_bloqueia_unidade_fora_do_usuario(): void
    {
        $this->fakeApiUnidadesSei([
            ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida());
        $repository->shouldNotReceive('beneficiarios');
        $repository->shouldNotReceive('adicionais');
        $repository->shouldNotReceive('trechos');
        $repository->shouldNotReceive('atualizarDadosSei');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR', '999');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('unidade SEI selecionada', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_com_falha_no_gerar_processo_mantem_rascunho_sem_dados_sei(): void
    {
        $this->fakeApiUnidadesSei([
            ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida());
        $repository->shouldReceive('beneficiarios')->once()->with(77)->andReturn($this->beneficiariosPersistidos());
        $repository->shouldReceive('adicionais')->once()->with(77)->andReturn($this->adicionaisPersistidos());
        $repository->shouldReceive('trechos')->once()->with(77)->andReturn($this->trechosPersistidos());
        $sei->shouldReceive('gerarProcessoDiaria')->once()->andThrow(new RuntimeException('SEI recusou a geração do processo.'));
        $sei->shouldNotReceive('incluirResumoSolicitacao');
        $repository->shouldNotReceive('atualizarDadosSei');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR', '288');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('SEI recusou a geração', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_com_falha_no_resumo_salva_processo_e_mantem_documento_pendente(): void
    {
        $this->fakeApiUnidadesSei([
            ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida());
        $repository->shouldReceive('beneficiarios')->once()->with(77)->andReturn($this->beneficiariosPersistidos());
        $repository->shouldReceive('adicionais')->once()->with(77)->andReturn($this->adicionaisPersistidos());
        $repository->shouldReceive('trechos')->once()->with(77)->andReturn($this->trechosPersistidos());
        $sei->shouldReceive('gerarProcessoDiaria')->once()->andReturn([
            'id_procedimento' => '1210000000774',
            'procedimento_formatado' => '0000121-77.2026.6.24.8000',
            'link_acesso' => 'https://sei.example/processo',
        ]);
        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->withArgs(function (int $id, array $dadosSei): bool {
                return $id === 77
                    && $dadosSei['sei_procedimento_id'] === '1210000000774'
                    && $dadosSei['sei_procedimento'] === '0000121-77.2026.6.24.8000'
                    && $dadosSei['sei_resumo_documento_id'] === null;
            });
        $sei->shouldReceive('incluirResumoSolicitacao')
            ->once()
            ->andThrow(new RuntimeException('SEI recusou a inclusão do resumo.'));

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR', '288');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('resumo', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_reusa_procedimento_existente_e_inclui_apenas_documento(): void
    {
        $this->fakeApiUnidadesSei([
            ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')
            ->once()
            ->with(77)
            ->andReturn($this->solicitacaoPersistida([
                'sei_procedimento_id' => '1210000000774',
                'sei_procedimento' => '0000121-77.2026.6.24.8000',
            ]));
        $repository->shouldReceive('beneficiarios')->once()->with(77)->andReturn($this->beneficiariosPersistidos());
        $repository->shouldReceive('adicionais')->once()->with(77)->andReturn($this->adicionaisPersistidos());
        $repository->shouldReceive('trechos')->once()->with(77)->andReturn($this->trechosPersistidos());
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldReceive('incluirResumoSolicitacao')
            ->once()
            ->withArgs(function (
                string $idProcedimento,
                string $procedimentoFormatado,
                array $solicitacao,
                array $beneficiarios,
                array $adicionais,
                array $trechos,
                ?array $viagemInternacional,
                DiariasUsuario $usuario,
                string $idUnidadeSei
            ): bool {
                return $idProcedimento === '1210000000774'
                    && $procedimentoFormatado === '0000121-77.2026.6.24.8000'
                    && $usuario->username === 'edcley'
                    && $idUnidadeSei === '288';
            })
            ->andReturn([
                'id_documento' => '1140000000872',
                'documento_formatado' => '0003934',
                'link_acesso' => 'https://sei.example/documento',
            ]);
        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->withArgs(function (int $id, array $dadosSei): bool {
                return $id === 77
                    && ! array_key_exists('sei_procedimento', $dadosSei)
                    && $dadosSei['sei_resumo_documento_id'] === '1140000000872';
            });

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR', '288');

        $this->assertTrue($resultado['completa']);
        Http::assertSent(static fn ($request): bool => str_contains($request->url(), '/procedimento-unidades/index.php'));
    }

    public function test_tentar_integracao_sei_bloqueia_processo_existente_sem_unidade_aberta_acessivel(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);
        $unidades = Mockery::mock(DiariasUnidadeSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida([
            'sei_procedimento_id' => '923063',
            'sei_procedimento' => '0001469-96.2026.6.01.8000',
        ]));
        $repository->shouldNotReceive('beneficiarios');
        $repository->shouldNotReceive('adicionais');
        $repository->shouldNotReceive('trechos');
        $repository->shouldNotReceive('atualizarDadosSei');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');
        $unidades->shouldReceive('validarParaProcesso')
            ->once()
            ->withArgs(fn (DiariasUsuario $usuario, string $protocolo, string $id): bool => $usuario->username === 'edcley'
                && $protocolo === '0001469-96.2026.6.01.8000'
                && $id === '288')
            ->andThrow(new RuntimeException('O processo SEI não está aberto em nenhuma unidade acessível ao usuário.'));

        $service = new DiariasSolicitacaoService(
            $repository,
            $cidades,
            $gateway,
            $transportes,
            null,
            $sei,
            null,
            $unidades,
        );

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'INFORMAR', '288');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('não está aberto', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_retentativa_com_procedimento_existente_exige_unidade_novamente(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')
            ->once()
            ->with(77)
            ->andReturn($this->solicitacaoPersistida([
                'sei_procedimento_id' => '1210000000774',
                'sei_procedimento' => '0000121-77.2026.6.24.8000',
                'sei_resumo_documento_formatado' => null,
            ]));
        $repository->shouldNotReceive('beneficiarios');
        $repository->shouldNotReceive('adicionais');
        $repository->shouldNotReceive('trechos');
        $repository->shouldNotReceive('atualizarDadosSei');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('unidade SEI', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_processo_manual_resolve_id_e_inclui_resumo(): void
    {
        $this->fakeApiProtocolosEUnidadesSei(
            [
                ['IDPROCEDIMENTO' => '923065', 'PROTOCOLO_FORMATADO' => '0000999-11.2026.6.24.8000'],
            ],
            [
                ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
            ],
        );

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')
            ->once()
            ->with(77)
            ->andReturn($this->solicitacaoPersistida([
                'sei_procedimento_id' => null,
                'sei_procedimento' => '0000999-11.2026.6.24.8000',
            ]));
        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->ordered()
            ->withArgs(function (int $id, array $dadosSei, string $usuario): bool {
                return $id === 77
                    && $dadosSei['sei_procedimento_id'] === '923065'
                    && ! array_key_exists('sei_procedimento', $dadosSei)
                    && $usuario === 'edcley';
            });
        $repository->shouldReceive('beneficiarios')->once()->with(77)->andReturn($this->beneficiariosPersistidos());
        $repository->shouldReceive('adicionais')->once()->with(77)->andReturn($this->adicionaisPersistidos());
        $repository->shouldReceive('trechos')->once()->with(77)->andReturn($this->trechosPersistidos());
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldReceive('incluirResumoSolicitacao')
            ->once()
            ->withArgs(function (
                string $idProcedimento,
                string $procedimentoFormatado,
                array $solicitacao,
                array $beneficiarios,
                array $adicionais,
                array $trechos,
                ?array $viagemInternacional,
                DiariasUsuario $usuario,
                string $idUnidadeSei
            ): bool {
                return $idProcedimento === '923065'
                    && $procedimentoFormatado === '0000999-11.2026.6.24.8000'
                    && $solicitacao['sei_procedimento_id'] === '923065'
                    && $usuario->username === 'edcley'
                    && $idUnidadeSei === '288';
            })
            ->andReturn([
                'id_documento' => '1140000000872',
                'documento_formatado' => '0003934',
                'link_acesso' => 'https://sei.example/documento',
            ]);
        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->ordered()
            ->withArgs(function (int $id, array $dadosSei): bool {
                return $id === 77
                    && $dadosSei['sei_resumo_documento_id'] === '1140000000872'
                    && $dadosSei['sei_resumo_documento_formatado'] === '0003934';
            });

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'INFORMAR', '288');

        $this->assertTrue($resultado['completa']);
        $this->assertNull($resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_processo_manual_exige_unidade_para_incluir_resumo(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')
            ->once()
            ->with(77)
            ->andReturn($this->solicitacaoPersistida([
                'sei_procedimento_id' => '923065',
                'sei_procedimento' => '0000999-11.2026.6.24.8000',
                'sei_resumo_documento_formatado' => null,
            ]));
        $repository->shouldNotReceive('beneficiarios');
        $repository->shouldNotReceive('adicionais');
        $repository->shouldNotReceive('trechos');
        $repository->shouldNotReceive('atualizarDadosSei');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'INFORMAR');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('unidade SEI', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_processo_manual_sem_id_bloqueia_envio_quando_api_nao_resolve(): void
    {
        $this->fakeApiProtocolosEUnidadesSei(
            [
                ['IDPROCEDIMENTO' => '923065', 'PROTOCOLO_FORMATADO' => '0000999-11.2026.6.24.8000'],
                ['IDPROCEDIMENTO' => '923066', 'PROTOCOLO_FORMATADO' => '0000999-12.2026.6.24.8000'],
            ],
            [
                ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
            ],
        );

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')
            ->once()
            ->with(77)
            ->andReturn($this->solicitacaoPersistida([
                'sei_procedimento_id' => null,
                'sei_procedimento' => '0000999',
            ]));
        $repository->shouldNotReceive('beneficiarios');
        $repository->shouldNotReceive('adicionais');
        $repository->shouldNotReceive('trechos');
        $repository->shouldNotReceive('atualizarDadosSei');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'INFORMAR', '288');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('IdProcedimento', (string) $resultado['mensagem']);
    }

    public function test_tentar_integracao_sei_sem_id_procedimento_salva_numero_e_bloqueia_envio(): void
    {
        $this->fakeApiUnidadesSei([
            ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida());
        $repository->shouldReceive('beneficiarios')->once()->with(77)->andReturn($this->beneficiariosPersistidos());
        $repository->shouldReceive('adicionais')->once()->with(77)->andReturn($this->adicionaisPersistidos());
        $repository->shouldReceive('trechos')->once()->with(77)->andReturn($this->trechosPersistidos());
        $sei->shouldReceive('gerarProcessoDiaria')->once()->andReturn([
            'id_procedimento' => null,
            'procedimento_formatado' => '0000121-77.2026.6.24.8000',
            'link_acesso' => 'https://sei.example/processo',
        ]);
        $sei->shouldNotReceive('incluirResumoSolicitacao');
        $repository->shouldReceive('atualizarDadosSei')
            ->once()
            ->withArgs(function (int $id, array $dadosSei): bool {
                return $id === 77
                    && $dadosSei['sei_procedimento_id'] === null
                    && $dadosSei['sei_procedimento'] === '0000121-77.2026.6.24.8000'
                    && $dadosSei['sei_resumo_documento_id'] === null;
            });

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $resultado = $service->tentarIntegracaoSei(77, $this->usuario(), 'GERAR', '288');

        $this->assertFalse($resultado['completa']);
        $this->assertStringContainsString('IdProcedimento', (string) $resultado['mensagem']);
    }

    public function test_criar_solicitacao_com_dados_internos_invalidos_nao_chama_sei(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 999])->andReturn(false);
        $gateway->shouldNotReceive('buscarPorCpf');
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');
        $repository->shouldNotReceive('criar');

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $this->expectException(ValidationException::class);

        $service->criar($this->dadosBasicos([
            'processo_sei_modo' => 'GERAR',
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '999',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ]), $this->usuario());
    }

    public function test_criar_solicitacao_com_sei_informado_persiste_id_procedimento_resolvido(): void
    {
        $this->fakeApiProtocoloSei([
            ['IDPROCEDIMENTO' => '923065', 'PROTOCOLO_FORMATADO' => '0000999-11.2026.6.24.8000'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $repository->shouldReceive('criar')
            ->once()
            ->withArgs(function (array $solicitacao): bool {
                return $solicitacao['sei_procedimento'] === '0000999-11.2026.6.24.8000'
                    && $solicitacao['sei_procedimento_id'] === '923065'
                    && $solicitacao['sei_resumo_documento_id'] === null
                    && $solicitacao['sei_resumo_documento_formatado'] === null
                    && $solicitacao['sei_resumo_documento_link'] === null;
            })
            ->andReturn(77);

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $id = $service->criar($this->dadosBasicos([
            'processo_sei_modo' => 'INFORMAR',
            'sei_procedimento' => '0000999-11.2026.6.24.8000',
            'sei_procedimento_id' => 'valor-da-tela-nao-e-fonte-de-verdade',
        ]), $this->usuario());

        $this->assertSame(77, $id);
    }

    public function test_atualizar_rascunho_com_sei_existente_nao_regenera_processo_nem_resumo(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn((object) [
            'id' => 77,
            'status' => 'RASCUNHO',
            'sei_procedimento_id' => '1210000000774',
            'sei_procedimento' => '0000121-77.2026.6.24.8000',
            'sei_resumo_documento_id' => '1140000000872',
            'sei_resumo_documento_formatado' => '0003934',
            'sei_resumo_documento_link' => 'https://sei.example/documento',
        ]);
        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $repository->shouldReceive('atualizarRascunho')
            ->once()
            ->withArgs(function (int $id, array $solicitacao): bool {
                return $id === 77
                    && $solicitacao['sei_procedimento_id'] === '1210000000774'
                    && $solicitacao['sei_procedimento'] === '0000121-77.2026.6.24.8000'
                    && $solicitacao['sei_resumo_documento_id'] === '1140000000872'
                    && $solicitacao['sei_resumo_documento_formatado'] === '0003934'
                    && $solicitacao['sei_resumo_documento_link'] === 'https://sei.example/documento';
            });

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $service->atualizarRascunho(77, $this->dadosBasicos(['processo_sei_modo' => 'GERAR']), $this->usuario());

        $this->assertTrue(true);
    }

    public function test_atualizar_rascunho_substitui_processo_manual_sem_resumo_por_novo_processo_informado(): void
    {
        $this->fakeApiProtocoloSei([
            ['IDPROCEDIMENTO' => '923065', 'PROTOCOLO_FORMATADO' => '0000999-11.2026.6.24.8000'],
        ]);

        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida([
            'sei_procedimento_id' => '111111',
            'sei_procedimento' => '0001476-88.2026.6.01.8000',
        ]));
        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $repository->shouldReceive('atualizarRascunho')
            ->once()
            ->withArgs(function (int $id, array $solicitacao): bool {
                return $id === 77
                    && $solicitacao['sei_procedimento'] === '0000999-11.2026.6.24.8000'
                    && $solicitacao['sei_procedimento_id'] === '923065'
                    && $solicitacao['sei_resumo_documento_id'] === null
                    && $solicitacao['sei_resumo_documento_formatado'] === null
                    && $solicitacao['sei_resumo_documento_link'] === null;
            });

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $service->atualizarRascunho(77, $this->dadosBasicos([
            'processo_sei_modo' => 'INFORMAR',
            'sei_procedimento' => '0000999-11.2026.6.24.8000',
        ]), $this->usuario());

        $this->assertTrue(true);
    }

    public function test_atualizar_rascunho_mantem_processo_pendente_de_resumo_quando_nao_ha_novo_processo_manual(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $cidades = $this->cidadesRepositoryMock();
        $gateway = Mockery::mock(DiariasPessoaGatewayInterface::class);
        $transportes = $this->transportesTerrestres();
        $sei = Mockery::mock(DiariasSeiService::class);

        $repository->shouldReceive('buscar')->once()->with(77)->andReturn($this->solicitacaoPersistida([
            'sei_procedimento_id' => '1210000000774',
            'sei_procedimento' => '0000121-77.2026.6.24.8000',
        ]));
        $cidades->shouldReceive('idsExistem')->once()->with([10, 20])->andReturn(true);
        $gateway->shouldReceive('buscarPorCpf')->once()->with('12345678901')->andReturn($this->pessoaBasica());
        $sei->shouldNotReceive('gerarProcessoDiaria');
        $sei->shouldNotReceive('incluirResumoSolicitacao');

        $repository->shouldReceive('atualizarRascunho')
            ->once()
            ->withArgs(function (int $id, array $solicitacao): bool {
                return $id === 77
                    && $solicitacao['sei_procedimento'] === '0000121-77.2026.6.24.8000'
                    && $solicitacao['sei_procedimento_id'] === '1210000000774';
            });

        $service = new DiariasSolicitacaoService($repository, $cidades, $gateway, $transportes, null, $sei);

        $service->atualizarRascunho(77, $this->dadosBasicos(['processo_sei_modo' => 'GERAR']), $this->usuario());

        $this->assertTrue(true);
    }

    public function test_excluir_rascunho_delega_exclusao_local_ao_repository(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $repository->shouldReceive('buscar')->once()->with(77)->andReturn((object) [
            'id' => 77,
            'status' => 'RASCUNHO',
            'sei_procedimento' => '0000121-77.2026.6.24.8000',
        ]);
        $repository->shouldReceive('excluirRascunho')->once()->with(77);

        $service = new DiariasSolicitacaoService(
            $repository,
            Mockery::mock(DiariasCidadeRepositoryInterface::class),
            Mockery::mock(DiariasPessoaGatewayInterface::class),
            Mockery::mock(DiariasTransporteTerrestreRepositoryInterface::class),
        );

        $service->excluirRascunho(77, new DiariasUsuario('admin', grupos: ['PLANELEITO_ADMIN']));

        $this->assertTrue(true);
    }

    public function test_excluir_rascunho_rejeita_solicitacao_em_outro_status(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $repository->shouldReceive('buscar')->once()->with(77)->andReturn((object) [
            'id' => 77,
            'status' => 'SOLICITADA',
        ]);
        $repository->shouldNotReceive('excluirRascunho');

        $service = new DiariasSolicitacaoService(
            $repository,
            Mockery::mock(DiariasCidadeRepositoryInterface::class),
            Mockery::mock(DiariasPessoaGatewayInterface::class),
            Mockery::mock(DiariasTransporteTerrestreRepositoryInterface::class),
        );

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Somente solicitações em rascunho podem ser excluídas.');

        $service->excluirRascunho(77, new DiariasUsuario('admin', grupos: ['PLANELEITO_ADMIN']));
    }

    public function test_excluir_rascunho_rejeita_solicitacao_inexistente(): void
    {
        $repository = Mockery::mock(DiariasSolicitacaoRepositoryInterface::class);
        $repository->shouldReceive('buscar')->once()->with(77)->andReturnNull();
        $repository->shouldNotReceive('excluirRascunho');

        $service = new DiariasSolicitacaoService(
            $repository,
            Mockery::mock(DiariasCidadeRepositoryInterface::class),
            Mockery::mock(DiariasPessoaGatewayInterface::class),
            Mockery::mock(DiariasTransporteTerrestreRepositoryInterface::class),
        );

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Solicitação de diária não encontrada.');

        $service->excluirRascunho(77, new DiariasUsuario('admin', grupos: ['PLANELEITO_ADMIN']));
    }

    private function fakeApiProtocoloSei(array $payload): void
    {
        config([
            'planeleito.diarias.pessoa_api_url' => 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php',
            'planeleito.diarias.pessoa_api_token' => 'token-de-teste',
            'planeleito.diarias.pessoa_api_connect_timeout' => 3,
            'planeleito.diarias.pessoa_api_timeout' => 5,
        ]);

        Http::fake([
            'https://visao.tre-ac.jus.br/painel/view/api/protocolo/index.php*' => Http::response($payload),
        ]);
    }

    private function fakeApiUnidadesSei(array $payload, ?array $unidadesProcesso = null): void
    {
        config([
            'planeleito.diarias.pessoa_api_url' => 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php',
            'planeleito.diarias.pessoa_api_token' => 'token-de-teste',
            'planeleito.diarias.pessoa_api_connect_timeout' => 3,
            'planeleito.diarias.pessoa_api_timeout' => 5,
        ]);

        $unidadesProcesso ??= collect($payload)
            ->map(static fn (array $unidade): array => [
                'id_unidade' => $unidade['ID_UNIDADE'] ?? $unidade['id_unidade'] ?? null,
                'sigla' => $unidade['SIGLA'] ?? $unidade['sigla'] ?? null,
                'total_atividades_abertas' => 1,
            ])
            ->values()
            ->all();

        Http::fake([
            'https://visao.tre-ac.jus.br/painel/view/api/usuario-sei/index.php*' => Http::response($payload),
            'https://visao.tre-ac.jus.br/painel/view/api/procedimento-unidades/index.php*' => Http::response([
                'encontrado' => true,
                'aberto' => $unidadesProcesso !== [],
                'unidades' => $unidadesProcesso,
            ]),
        ]);
    }

    private function fakeApiProtocolosEUnidadesSei(array $protocolos, array $unidades): void
    {
        config([
            'planeleito.diarias.pessoa_api_url' => 'https://visao.tre-ac.jus.br/painel/view/api/pessoa/index.php',
            'planeleito.diarias.pessoa_api_token' => 'token-de-teste',
            'planeleito.diarias.pessoa_api_connect_timeout' => 3,
            'planeleito.diarias.pessoa_api_timeout' => 5,
        ]);

        Http::fake([
            'https://visao.tre-ac.jus.br/painel/view/api/protocolo/index.php*' => Http::response($protocolos),
            'https://visao.tre-ac.jus.br/painel/view/api/usuario-sei/index.php*' => Http::response($unidades),
            'https://visao.tre-ac.jus.br/painel/view/api/procedimento-unidades/index.php*' => Http::response([
                'encontrado' => true,
                'aberto' => $unidades !== [],
                'unidades' => collect($unidades)
                    ->map(static fn (array $unidade): array => [
                        'id_unidade' => $unidade['ID_UNIDADE'] ?? $unidade['id_unidade'] ?? null,
                        'sigla' => $unidade['SIGLA'] ?? $unidade['sigla'] ?? null,
                        'total_atividades_abertas' => 1,
                    ])
                    ->values()
                    ->all(),
            ]),
        ]);
    }

    private function transportesTerrestres(): DiariasTransporteTerrestreRepositoryInterface
    {
        $transportes = Mockery::mock(DiariasTransporteTerrestreRepositoryInterface::class);
        $transportes->shouldReceive('buscarAtivo')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (string $codigo): ?object {
                return match ($codigo) {
                    'PROPRIO' => (object) [
                        'codigo' => 'PROPRIO',
                        'gera_combustivel' => 1,
                        'exige_beneficiario_combustivel' => 1,
                        'necessita_motorista' => 0,
                    ],
                    'OFICIAL_COM_MOTORISTA' => (object) [
                        'codigo' => 'OFICIAL_COM_MOTORISTA',
                        'gera_combustivel' => 0,
                        'exige_beneficiario_combustivel' => 0,
                        'necessita_motorista' => 1,
                    ],
                    'OFICIAL_SEM_MOTORISTA' => (object) [
                        'codigo' => 'OFICIAL_SEM_MOTORISTA',
                        'gera_combustivel' => 0,
                        'exige_beneficiario_combustivel' => 0,
                        'necessita_motorista' => 0,
                    ],
                    default => null,
                };
            });

        return $transportes;
    }

    private function dadosBasicos(array $sobrescrever = []): array
    {
        return array_replace_recursive([
            'motivo' => 'Reunião de alinhamento',
            'processo_sei_modo' => 'GERAR',
            'beneficiarios' => [
                ['cpf' => '123.456.789-01'],
            ],
            'trechos' => [[
                'cidade_origem_id' => '10',
                'cidade_destino_id' => '20',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ]],
        ], $sobrescrever);
    }

    private function pessoaBasica(array $sobrescrever = []): array
    {
        return array_replace([
            'cpf' => '12345678901',
            'nome' => 'Ana Silva',
            'email' => 'ana.silva@tre-ac.jus.br',
            'lotacao' => 'FIN',
            'cargo' => 'Analista',
            'funcao' => 'Servidor',
        ], $sobrescrever);
    }

    private function solicitacaoPersistida(array $sobrescrever = []): object
    {
        return (object) array_replace([
            'id' => 77,
            'status' => 'RASCUNHO',
            'requerente_username' => 'edcley',
            'requerente_nome' => 'Edcley Firmino',
            'requerente_email' => 'edcley@tre-ac.jus.br',
            'cidade_origem_id' => 10,
            'cidade_destino_id' => 20,
            'cidade_origem' => 'Cidade 10/AC',
            'cidade_destino' => 'Cidade 20/AC',
            'data_partida' => '2026-07-10',
            'data_retorno' => '2026-07-10',
            'sei_procedimento_id' => null,
            'sei_procedimento' => null,
            'sei_resumo_documento_id' => null,
            'sei_resumo_documento_formatado' => null,
            'sei_resumo_documento_link' => null,
            'motivo' => 'Reunião de alinhamento',
            'observacoes' => null,
            'equipe_trabalho_ato' => null,
            'justificativa_10_dias' => null,
            'justificativa_fim_semana_feriado' => null,
            'justificativa_pernoite' => null,
            'substituicao_funcional' => 'NAO',
            'viagem_internacional' => 0,
            'pais_codigo' => null,
            'pais_nome' => null,
            'moeda_codigo' => null,
            'relatorio_missao_prazo' => null,
        ], $sobrescrever);
    }

    private function beneficiariosPersistidos()
    {
        return collect([
            (object) $this->pessoaBasica([
                'lotacao_descricao' => 'Secretaria de Finanças',
            ]),
        ]);
    }

    private function adicionaisPersistidos()
    {
        return collect([
            (object) [
                'beneficiario_cpf' => '12345678901',
                'beneficiario_nome' => 'Ana Silva',
                'data_dia' => '2026-07-10',
                'acompanha_juiz' => 'NAO',
                'pernoite' => 'NAO',
                'pousada' => 'NAO',
                'hospedagem_publica' => 'NAO',
                'origem' => 'BASICO',
            ],
        ]);
    }

    private function trechosPersistidos()
    {
        return collect([
            (object) [
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 20,
                'cidade_origem_busca' => 'Cidade 10/AC',
                'cidade_destino_busca' => 'Cidade 20/AC',
                'data_partida' => '2026-07-10',
                'data_chegada' => '2026-07-10',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            ],
        ]);
    }

    private function usuario(): DiariasUsuario
    {
        return new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        );
    }
}
```
</TESTS_UNIT_DIARIASSOLICITACAOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasSolicitacaoWizardValidacaoTest.php`
## <TESTS_UNIT_DIARIASSOLICITACAOWIZARDVALIDACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasSolicitacaoWizardValidacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasSolicitacaoWizardValidacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_navegacao_futura_passa_pela_barreira_progressiva_e_retorno_permanece_livre(): void
public function test_etapas_validam_autocompletes_condicionais_datas_transporte_e_complementos(): void
public function test_erro_backend_por_campo_ou_colecao_reabre_a_etapa_correta(): void
public function test_submit_final_usa_um_clique_e_bloqueia_novas_ativacoes_ate_concluir(): void
public function test_pernoite_automatico_usa_decisao_do_backend_e_preserva_linhas_avancadas(): void
public function test_justificativa_auxilio_curto_so_aparece_apos_classificacao_e_preserva_o_texto(): void
public function test_formulario_pergunta_auxilio_do_orgao_de_origem_com_checkbox_e_exibe_valor_quando_marcado(): void
public function test_formulario_permite_remover_o_ultimo_beneficiario_e_adicionar_novamente(): void
public function test_escopos_contraste_e_foco_inicial_seguem_o_estado_do_formulario(): void
public function test_contrato_e_plano_versionam_a_validacao_progressiva_sem_nova_persistencia(): void
private function formSource(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class DiariasSolicitacaoWizardValidacaoTest extends TestCase
{
    public function test_navegacao_futura_passa_pela_barreira_progressiva_e_retorno_permanece_livre(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString('data-wizard-validation-alert', $view);
        $this->assertStringContainsString("erro.campo?.scrollIntoView?.({ behavior: 'smooth', block: 'center' })", $view);
        $this->assertStringContainsString('const validarEtapaWizard = async', $view);
        $this->assertStringContainsString('const navegarParaEtapaWizard = async', $view);
        $this->assertStringContainsString('const validarTodasEtapasWizard = async', $view);
        $this->assertStringContainsString('await validarEtapaWizard(indice)', $view);
        $this->assertStringContainsString("tab?.addEventListener('click', async", $view);
        $this->assertStringContainsString("botaoWizardProximo?.addEventListener('click', async", $view);
        $this->assertStringContainsString("botaoWizardAnterior?.addEventListener('click', () => mostrarEtapaWizard", $view);
        $this->assertStringContainsString('botaoWizardAnterior.disabled = ocupada || indiceWizardAtual === 0;', $view);
        $this->assertStringContainsString('tab.disabled = ocupada;', $view);
        $this->assertStringNotContainsString("tab?.addEventListener('click', () => mostrarEtapaWizard", $view);
        $this->assertStringNotContainsString("botaoWizardProximo?.addEventListener('click', () => mostrarEtapaWizard", $view);
    }

    public function test_etapas_validam_autocompletes_condicionais_datas_transporte_e_complementos(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString('Selecione o beneficiário na lista de resultados.', $view);
        $this->assertStringContainsString('O beneficiário já foi adicionado.', $view);
        $this->assertStringContainsString('Selecione a origem na lista de cidades.', $view);
        $this->assertStringContainsString('Origem e destino devem ser diferentes.', $view);
        $this->assertStringContainsString('A chegada não pode ser anterior à partida.', $view);
        $this->assertStringContainsString('Informe o beneficiário do adicional de combustível.', $view);
        $this->assertStringContainsString('Não foi possível validar a regra do trecho. Tente novamente.', $view);
        $this->assertStringContainsString('if (!regraTrechoEndpoint) {', $view);
        $this->assertStringContainsString('Trecho limítrofe exige pernoite fora da sede.', $view);
        $this->assertStringContainsString('const { inicio, fim } = periodoBrutoInformado();', $view);
        $this->assertStringContainsString('O período da viagem não pode ultrapassar 370 dias.', $view);
        $this->assertStringContainsString('Escolha uma opção para cada adicional aplicável.', $view);
        $this->assertStringContainsString('Os adicionais não correspondem aos beneficiários e dias da viagem.', $view);
        $this->assertStringContainsString('O fim da substituição não pode ser anterior ao início.', $view);
        $this->assertStringContainsString("formularioDiarias?.addEventListener('submit', async", $view);
        $this->assertStringContainsString('if (navegacaoWizardEmAndamento) {', $view);
    }

    public function test_erro_backend_por_campo_ou_colecao_reabre_a_etapa_correta(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString('const etapaPorCampoErro = (campo)', $view);
        $this->assertStringContainsString("campoNormalizado === 'beneficiarios' || campoNormalizado.startsWith('beneficiarios.')", $view);
        $this->assertStringContainsString("campoNormalizado === 'trechos' || campoNormalizado.startsWith('trechos.')", $view);
        $this->assertStringContainsString("campoNormalizado === 'adicionais'", $view);
        $this->assertStringContainsString("campoNormalizado.startsWith('adicionais.')", $view);
        $this->assertStringContainsString("campoNormalizado === 'adicionais_basico'", $view);
        $this->assertStringContainsString('const etapasComErro = new Set(camposErroWizard.map(etapaPorCampoErro).filter(Boolean));', $view);
        $this->assertStringContainsString('const etapaComErro = etapasWizard.find((etapa) => etapasComErro.has(etapa))', $view);
    }

    public function test_submit_final_usa_um_clique_e_bloqueia_novas_ativacoes_ate_concluir(): void
    {
        $view = $this->formSource();
        $unidadeSei = (string) file_get_contents(
            resource_path('views/diarias/solicitacoes/partials/unidade-sei-modal.blade.php')
        );

        $this->assertStringContainsString('let submitWizardEmAndamento = false;', $view);
        $this->assertStringContainsString('const definirSubmitWizardOcupado = (ocupado, submitter = null)', $view);
        $this->assertStringContainsString('botao.disabled = ocupado;', $view);
        $this->assertStringContainsString("botao.setAttribute('aria-busy', ocupado ? 'true' : 'false');", $view);
        $this->assertStringContainsString('if (submitWizardEmAndamento || navegacaoWizardEmAndamento) {', $view);
        $this->assertStringContainsString('window.diariasValidarUnidadeSeiSubmit?.(formularioDiarias, submitter)', $view);
        $this->assertStringContainsString('const submeterFormularioDiarias = async (acaoSubmitWizard, submitter)', $view);
        $this->assertStringContainsString('await submeterFormularioDiarias(acaoSubmitWizard, submitter);', $view);
        $this->assertStringContainsString("await submeterFormularioDiarias('rascunho', botaoSalvarRascunhoVoltar);", $view);
        $this->assertStringContainsString("campoAcaoSubmit.name = 'acao';", $view);
        $this->assertStringContainsString('campoAcaoSubmit.value = acaoSubmitWizard;', $view);
        $this->assertStringContainsString('HTMLFormElement.prototype.submit.call(formularioDiarias);', $view);
        $this->assertSame(1, substr_count($view, 'HTMLFormElement.prototype.submit.call(formularioDiarias);'));
        $this->assertStringNotContainsString('sem passar pela validacao completa', $view);
        $this->assertStringNotContainsString('formularioDiarias.requestSubmit(', $view);
        $this->assertStringContainsString('window.diariasValidarUnidadeSeiSubmit = validarUnidadeSeiSubmit;', $unidadeSei);
    }

    public function test_pernoite_automatico_usa_decisao_do_backend_e_preserva_linhas_avancadas(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString('name="justificativa_pernoite"', $view);
        $this->assertStringContainsString('data-justificativa-pernoite-wrapper', $view);
        $this->assertStringContainsString('data-pernoite-basico-automatico', $view);
        $this->assertStringContainsString('regra.deslocamento_curto', $view);
        $this->assertStringContainsString('row.dataset.deslocamentoCurto', $view);
        $this->assertStringContainsString('let pernoiteBasicoAlteradoPeloUsuario', $view);
        $this->assertStringContainsString('atualizarPernoiteAutomatico = () =>', $view);
        $this->assertStringContainsString('renderizarAdicionaisBeneficiarios(true);', $view);
        $this->assertStringContainsString("estadoPersistido.origem !== 'AVANCADO'", $view);
    }

    public function test_justificativa_auxilio_curto_so_aparece_apos_classificacao_e_preserva_o_texto(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString('data-justificativas-auxilio-curto-wrapper hidden', $view);
        $this->assertStringContainsString("row.dataset.regraTrechoValidada === '1'", $view);
        $this->assertStringContainsString('row.dataset.distanciaMinimaKm', $view);
        $this->assertStringContainsString('distancia <= distanciaMinima', $view);
        $this->assertStringContainsString("normalizarVinculoBeneficiario(tipoVinculo) === 'REQUISITADO'", $view);
        $this->assertStringContainsString("flagAuxilioTre?.value === 'NAO'", $view);
        $this->assertStringContainsString('const exibir = todosTrechosAteDistanciaMinima() && elegiveis.length > 0;', $view);
        $this->assertStringContainsString('justificativasAuxilioCurtoWrapper.hidden = !exibir;', $view);
        $this->assertStringContainsString('`Justificativa do auxílio-alimentação em deslocamento de até 60 km — ${nome}`', $view);
        $this->assertStringContainsString('valorPersistido.value = textarea.value;', $view);
        $this->assertStringNotContainsString("valorPersistido.value = '';", $view);
    }

    public function test_formulario_pergunta_auxilio_do_orgao_de_origem_com_checkbox_e_exibe_valor_quando_marcado(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString('data-auxilio-orgao-origem-wrapper', $view);
        $this->assertStringContainsString('Recebe auxílio-alimentação do órgão de origem', $view);
        $this->assertStringContainsString('name="beneficiarios[{{ $indice }}][recebe_auxilio_alimentacao_orgao_origem]"', $view);
        $this->assertStringContainsString('data-beneficiario-recebe-auxilio-origem-nao', $view);
        $this->assertStringContainsString('type="checkbox"', $view);
        $this->assertStringContainsString('value="{{ $binarioSim }}"', $view);
        $this->assertStringContainsString('resposta.checked', $view);
        $this->assertStringContainsString('const exibeValor = visivel && resposta.checked;', $view);
        $this->assertStringContainsString('data-valor-auxilio-orgao-origem-wrapper', $view);
        $this->assertStringNotContainsString('<select name="beneficiarios[{{ $indice }}][recebe_auxilio_alimentacao_orgao_origem]"', $view);
        $this->assertStringNotContainsString('@foreach ($opcoesBinarias as $opcaoBinaria)', $view);
        $this->assertStringNotContainsString('data-beneficiario-auxilio-tre-wrapper', $view);
    }

    public function test_formulario_permite_remover_o_ultimo_beneficiario_e_adicionar_novamente(): void
    {
        $view = $this->formSource();

        $this->assertStringNotContainsString('@disabled($beneficiariosOld->count() === 1)', $view);
        $this->assertStringContainsString("const beneficiarioRowModelo = tbody?.querySelector('[data-beneficiario-row]')?.cloneNode(true);", $view);
        $this->assertStringContainsString('const origem = linhasBeneficiarios()[0] || beneficiarioRowModelo;', $view);
        $this->assertStringContainsString("button.closest('[data-beneficiario-row]')?.remove();", $view);
        $this->assertStringNotContainsString('if (linhasBeneficiarios().length > 1) {', $view);
        $this->assertStringNotContainsString('const atualizarBotoesRemocaoBeneficiarios = () =>', $view);
        $this->assertStringContainsString('Informe ao menos um beneficiário.', $view);
    }

    public function test_escopos_contraste_e_foco_inicial_seguem_o_estado_do_formulario(): void
    {
        $view = $this->formSource();

        $this->assertStringContainsString("MUNDO: ['AC', 'BR']", $view);
        $this->assertStringContainsString("AC: ['BR', 'MUNDO']", $view);
        $this->assertStringContainsString("BR: ['MUNDO']", $view);
        $this->assertStringContainsString('const aplicarCascataEscopoCidade', $view);
        $this->assertStringNotContainsString("LDA: ['AC'", $view);
        $this->assertStringContainsString('diarias-adicionais-tabela', $view);
        $this->assertStringContainsString('.diarias-adicionais-tabela .form-check-input:not(:disabled):not(:checked)', $view);
        $this->assertStringContainsString('@if (!$modoEdicao && !$errors->any() && $indice === 0) autofocus @endif', $view);
        $this->assertStringNotContainsString("document.querySelector('[data-diarias-pessoa-autocomplete]')?.focus();", $view);
    }

    public function test_contrato_e_plano_versionam_a_validacao_progressiva_sem_nova_persistencia(): void
    {
        $contrato = (string) file_get_contents(base_path('docs/contratos/diarias.md'));
        $plano = (string) file_get_contents(base_path('docs/planejamento/diarias-solicitacao-wizard-validacao-etapas.md'));
        $planoSubmit = (string) file_get_contents(base_path('docs/planejamento/diarias-solicitacao-submit-unico.md'));

        $this->assertStringContainsString('o wizard da solicitacao deve seguir a ordem', $contrato);
        $this->assertStringContainsString('falha ao consultar a', $contrato);
        $this->assertStringContainsString('regra do trecho deve bloquear o avanco', $contrato);
        $this->assertStringContainsString('Status: concluido com ressalvas de ambiente e baseline', $plano);
        $this->assertStringContainsString('Nao criar rota, ACL, migration, DDL ou DML.', $plano);
        $this->assertStringContainsString('unica ativacao do usuario', $contrato);
        $this->assertStringContainsString('Status: concluido com ressalva de ambiente', $planoSubmit);
        $this->assertStringContainsString('submissao definitiva unica', $planoSubmit);
    }

    private function formSource(): string
    {
        return (string) file_get_contents(resource_path('views/diarias/solicitacoes/form.blade.php'));
    }
}
```
</TESTS_UNIT_DIARIASSOLICITACAOWIZARDVALIDACAOTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasTrechoServiceSetranRefazerTest.php`
## <TESTS_UNIT_DIARIASTRECHOSERVICESETRANREFAZERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasTrechoServiceSetranRefazerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasTrechoServiceSetranRefazerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_cotacao_pode_ser_regravada_em_transporte_sem_reaprovar_cotacao(): void
public function test_criar_base_operacional_bloqueia_quando_base_ja_existe(): void
public function test_criar_base_operacional_insere_apenas_quando_nao_ha_base(): void
public function test_alterar_datas_na_setran_nao_exige_justificativa_e_limpa_confirmacao(): void
public function test_alterar_datas_na_setran_bloqueia_conflito_antes_de_gravar(): void
public function test_subdividir_bloqueia_conflito_antes_de_substituir_o_trecho_pai(): void
public function test_preparar_trecho_edita_trecho_existente_e_limpa_confirmacao_quando_muda_preparo(): void
public function test_confirmar_trecho_ja_confirmado_sobrescreve_com_auditoria(): void
public function test_confirmacao_do_wizard_atualiza_preparacao_datas_e_modal_na_mesma_transacao_logica(): void
public function test_finalizar_transporte_setran_exige_todos_trechos_confirmados_e_avanca_fluxo(): void
public function test_finalizar_transporte_setran_bloqueia_conflito_antes_de_avancar_o_fluxo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Diarias\Contracts\DiariasAuditoriaSensivelRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasTrechoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasTransporteTerrestreRepositoryInterface;
use App\Repositories\Diarias\DiariasDominioRepository;
use App\Services\Diarias\DiariasConflitoViagemService;
use App\Services\Diarias\DiariasTrechoService;
use App\Services\Diarias\DiariasUsuario;
use App\Services\Diarias\DiariasWorkflowService;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class DiariasTrechoServiceSetranRefazerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_cotacao_pode_ser_regravada_em_transporte_sem_reaprovar_cotacao(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $usuario = $this->usuario();

        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN')
            ->andReturn((object) ['id' => 10, 'tipo_etapa' => 'TRANSPORTE']);
        $trechos->shouldReceive('trechosEfetivos')
            ->once()
            ->with(77)
            ->andReturn(new Collection([
                (object) [
                    'id' => 501,
                    'solicitacao_id' => 77,
                    'modal_codigo' => 'TERRESTRE',
                    'transporte_terrestre_codigo' => 'PROPRIO',
                    'cotacao_passagem_valor' => 900.0,
                ],
            ]));
        $trechos->shouldReceive('registrarCotacaoPassagem')
            ->once()
            ->with(501, [
                'cotacao_passagem_regular' => 'SIM',
                'cotacao_passagem_valor' => 1250.0,
                'cotacao_passagem_observacao' => 'Cotação refeita pela SETRAN.',
            ], 'edcley')
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'PROPRIO',
                'cotacao_passagem_regular' => 'SIM',
                'cotacao_passagem_valor' => 1250.0,
                'cotacao_passagem_observacao' => 'Cotação refeita pela SETRAN.',
            ]);
        $trechos->shouldReceive('limparDadosPosterioresSetran')
            ->once()
            ->with(77, 'edcley');
        $trechos->shouldNotReceive('todosTrechosPropriosCotados');
        $workflow->shouldNotReceive('aprovarEtapaAtual');

        (new DiariasTrechoService($trechos, $workflow, null, $this->dominios()))->registrarCotacoesPassagem(77, [
            501 => [
                'cotacao_passagem_regular' => '1',
                'cotacao_passagem_valor' => '1250,00',
                'cotacao_passagem_observacao' => 'Cotação refeita pela SETRAN.',
            ],
        ], $usuario);

        $this->assertTrue(true);
    }

    public function test_criar_base_operacional_bloqueia_quando_base_ja_existe(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $usuario = $this->usuario();

        $solicitacao = (object) [
            'id' => 77,
            'cidade_origem_id' => 10,
            'cidade_destino_id' => 20,
            'data_partida' => '2026-09-15',
            'data_retorno' => '2026-09-17',
        ];

        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10, 'tipo_etapa' => 'TRANSPORTE']);
        $trechos->shouldReceive('trechosEfetivos')
            ->once()
            ->with(77)
            ->andReturn(new Collection([
                (object) [
                    'id' => 501,
                    'solicitacao_id' => 77,
                    'cidade_origem_id' => 10,
                    'cidade_destino_id' => 30,
                    'data_partida_confirmada' => '2026-09-16',
                    'confirmado_em' => '2026-09-10',
                ],
            ]));
        $trechos->shouldNotReceive('substituirBaseOperacional');
        $trechos->shouldNotReceive('criarBaseOperacional');

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('A base operacional já existe. Edite os trechos existentes em Transporte/Revisão final.');

        (new DiariasTrechoService($trechos, $workflow, null, $this->dominios()))
            ->criarBaseOperacional(77, $solicitacao, $usuario);
    }

    public function test_criar_base_operacional_insere_apenas_quando_nao_ha_base(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $usuario = $this->usuario();

        $solicitacao = (object) [
            'id' => 77,
            'cidade_origem_id' => 10,
            'cidade_destino_id' => 20,
            'data_partida' => '2026-09-15',
            'data_retorno' => '2026-09-17',
        ];

        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10, 'tipo_etapa' => 'TRANSPORTE']);
        $trechos->shouldReceive('trechosEfetivos')
            ->once()
            ->with(77)
            ->andReturn(new Collection());
        $trechos->shouldReceive('criarBaseOperacional')
            ->once()
            ->with(77, [
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 20,
                'data_partida' => '2026-09-15',
                'data_chegada' => '2026-09-17',
            ], 'edcley')
            ->andReturn((object) ['id' => 777]);

        $novo = (new DiariasTrechoService($trechos, $workflow, null, $this->dominios()))
            ->criarBaseOperacional(77, $solicitacao, $usuario);

        $this->assertSame(777, (int) $novo->id);
    }

    public function test_alterar_datas_na_setran_nao_exige_justificativa_e_limpa_confirmacao(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $usuario = $this->usuario();

        $trechos->shouldReceive('buscar')
            ->once()
            ->with(501)
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'data_partida' => '2026-09-15',
                'data_chegada' => '2026-09-16',
                'data_partida_confirmada' => '2026-09-15',
                'data_chegada_confirmada' => '2026-09-16',
                'confirmado_em' => '2026-09-12',
            ]);
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $trechos->shouldReceive('registrarConfirmacaoDatas')
            ->once()
            ->with(501, [
                'data_partida_confirmada' => '2026-09-16',
                'data_chegada_confirmada' => '2026-09-17',
            ], 'edcley', true)
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'data_partida_confirmada' => '2026-09-16',
                'data_chegada_confirmada' => '2026-09-17',
                'confirmado_em' => null,
            ]);

        (new DiariasTrechoService($trechos, $workflow, null, $this->dominios()))->confirmarDatas(501, [
            'data_partida_confirmada' => '2026-09-16',
            'data_chegada_confirmada' => '2026-09-17',
        ], $usuario);

        $this->assertTrue(true);
    }

    public function test_alterar_datas_na_setran_bloqueia_conflito_antes_de_gravar(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $conflitos = Mockery::mock(DiariasConflitoViagemService::class);
        $usuario = $this->usuario();
        $original = (object) [
            'id' => 501,
            'solicitacao_id' => 77,
            'data_partida' => '2026-09-15',
            'data_chegada' => '2026-09-16',
            'data_partida_confirmada' => '2026-09-15',
            'data_chegada_confirmada' => '2026-09-16',
        ];

        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn (callable $callback) => $callback());
        $trechos->shouldReceive('buscar')->once()->with(501)->andReturn($original);
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $trechos->shouldReceive('trechosEfetivos')->once()->with(77)->andReturn(collect([
            $original,
            (object) [
                'id' => 502,
                'solicitacao_id' => 77,
                'data_partida' => '2026-09-18',
                'data_chegada' => '2026-09-20',
            ],
        ]));
        $conflitos->shouldReceive('bloquearBeneficiariosDaSolicitacao')->once()->with(77);
        $conflitos->shouldReceive('validarTrechosDaSolicitacao')
            ->once()
            ->withArgs(static function (int $solicitacaoId, Collection $propostos, bool $bloquear): bool {
                $alterado = $propostos->firstWhere('id', 501);

                return $solicitacaoId === 77
                    && ! $bloquear
                    && $alterado->data_partida_confirmada === '2026-09-16'
                    && $alterado->data_chegada_confirmada === '2026-09-17'
                    && $propostos->contains('id', 502);
            })
            ->andThrow(new RuntimeException('Conflito de viagem.'));
        $trechos->shouldNotReceive('registrarConfirmacaoDatas');

        $service = new DiariasTrechoService(
            $trechos,
            $workflow,
            null,
            $this->dominios(),
            null,
            $conflitos,
        );

        $this->expectExceptionMessage('Conflito de viagem.');
        $service->confirmarDatas(501, [
            'data_partida_confirmada' => '2026-09-16',
            'data_chegada_confirmada' => '2026-09-17',
        ], $usuario);
    }

    public function test_subdividir_bloqueia_conflito_antes_de_substituir_o_trecho_pai(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $conflitos = Mockery::mock(DiariasConflitoViagemService::class);
        $usuario = $this->usuario();
        $pai = (object) [
            'id' => 501,
            'solicitacao_id' => 77,
            'trecho_pai_id' => null,
            'data_partida' => '2026-09-15',
            'data_chegada' => '2026-09-20',
        ];

        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn (callable $callback) => $callback());
        $trechos->shouldReceive('buscar')->once()->with(501)->andReturn($pai);
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $conflitos->shouldReceive('bloquearBeneficiariosDaSolicitacao')->once()->with(77);
        $trechos->shouldReceive('trechosEfetivos')->once()->with(77)->andReturn(collect([
            $pai,
            (object) [
                'id' => 502,
                'solicitacao_id' => 77,
                'data_partida' => '2026-09-21',
                'data_chegada' => '2026-09-22',
            ],
        ]));
        $conflitos->shouldReceive('validarTrechosDaSolicitacao')
            ->once()
            ->withArgs(static function (int $solicitacaoId, Collection $propostos, bool $bloquear): bool {
                return $solicitacaoId === 77
                    && ! $bloquear
                    && ! $propostos->contains('id', 501)
                    && $propostos->contains('id', 502)
                    && $propostos->contains('data_partida', '2026-09-16')
                    && $propostos->contains('data_chegada', '2026-09-20');
            })
            ->andThrow(new RuntimeException('Conflito de viagem.'));
        $trechos->shouldNotReceive('subdividir');

        $service = new DiariasTrechoService($trechos, $workflow, null, $this->dominios(), null, $conflitos);

        $this->expectExceptionMessage('Conflito de viagem.');
        $service->subdividir(501, [
            ['data_partida' => '2026-09-16', 'data_chegada' => '2026-09-17', 'modal_codigo' => 'TERRESTRE'],
            ['data_partida' => '2026-09-18', 'data_chegada' => '2026-09-20', 'modal_codigo' => 'TERRESTRE'],
        ], $usuario);
    }

    public function test_preparar_trecho_edita_trecho_existente_e_limpa_confirmacao_quando_muda_preparo(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $transportes = Mockery::mock(DiariasTransporteTerrestreRepositoryInterface::class);
        $usuario = $this->usuario();

        $trechos->shouldReceive('buscar')
            ->once()
            ->with(501)
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 20,
                'data_partida' => '2026-09-15',
                'data_chegada' => '2026-09-16',
                'modal_codigo' => 'AEREO',
                'transporte_terrestre_codigo' => null,
                'confirmado_em' => '2026-09-12',
            ]);
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $transportes->shouldReceive('buscarAtivo')
            ->once()
            ->with('OFICIAL_COM_MOTORISTA')
            ->andReturn((object) [
                'codigo' => 'OFICIAL_COM_MOTORISTA',
                'necessita_motorista' => 1,
            ]);
        $trechos->shouldReceive('atualizarPreparacao')
            ->once()
            ->with(501, [
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 30,
                'data_partida' => '2026-09-17',
                'data_chegada' => '2026-09-17',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_COM_MOTORISTA',
                'necessita_motorista' => 1,
                'beneficiarios_combustivel_json' => null,
                'informacoes_complementares' => 'Ajuste operacional SETRAN.',
            ], 'edcley', true)
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 30,
                'data_partida' => '2026-09-17',
                'data_chegada' => '2026-09-17',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_COM_MOTORISTA',
                'necessita_motorista' => 1,
                'confirmado_em' => null,
            ]);

        (new DiariasTrechoService($trechos, $workflow, null, $this->dominios(), $transportes))->prepararTrecho(501, [
            'cidade_origem_id' => 10,
            'cidade_destino_id' => 30,
            'data_partida' => '2026-09-17',
            'data_chegada' => '2026-09-17',
            'modal_codigo' => 'TERRESTRE',
            'transporte_terrestre_codigo' => 'OFICIAL_COM_MOTORISTA',
            'informacoes_complementares' => 'Ajuste operacional SETRAN.',
        ], $usuario);

        $this->assertTrue(true);
    }

    public function test_confirmar_trecho_ja_confirmado_sobrescreve_com_auditoria(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $auditoria = Mockery::mock(DiariasAuditoriaSensivelRepositoryInterface::class);
        $usuario = $this->usuario();

        $trechos->shouldReceive('buscar')
            ->once()
            ->with(501)
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'PROPRIO',
                'confirmado_em' => '2026-09-12',
                'codigo_reserva' => 'ANTIGA',
            ]);
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $trechos->shouldReceive('confirmar')
            ->once()
            ->withArgs(static function (int $trechoId, array $dados, string $username): bool {
                return $trechoId === 501
                    && $username === 'edcley'
                    && $dados['codigo_reserva'] === 'NOVA';
            })
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'PROPRIO',
                'confirmado_em' => '2026-09-13',
                'codigo_reserva' => 'NOVA',
            ]);
        $auditoria->shouldReceive('registrar')
            ->once()
            ->with(Mockery::on(static function (array $payload): bool {
                return $payload['tipo_evento'] === 'TRECHO_CONFIRMADO_SETRAN'
                    && $payload['dados_antes']['codigo_reserva'] === 'ANTIGA'
                    && $payload['dados_depois']['codigo_reserva'] === 'NOVA';
            }));
        $trechos->shouldNotReceive('todosEfetivosConfirmados');
        $workflow->shouldNotReceive('aprovarEtapaAtual');

        (new DiariasTrechoService($trechos, $workflow, $auditoria, $this->dominios()))->confirmar(501, [
            'modal_codigo' => 'TERRESTRE',
            'transporte_terrestre_codigo' => 'PROPRIO',
            'codigo_reserva' => 'NOVA',
        ], $usuario, false);

        $this->assertTrue(true);
    }

    public function test_confirmacao_do_wizard_atualiza_preparacao_datas_e_modal_na_mesma_transacao_logica(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $transportes = Mockery::mock(DiariasTransporteTerrestreRepositoryInterface::class);
        $usuario = $this->usuario();
        $original = (object) [
            'id' => 501,
            'solicitacao_id' => 77,
            'cidade_origem_id' => 10,
            'cidade_destino_id' => 20,
            'data_partida' => '2026-09-15',
            'data_chegada' => '2026-09-16',
            'data_partida_confirmada' => '2026-09-15',
            'data_chegada_confirmada' => '2026-09-16',
            'modal_codigo' => 'AEREO',
            'transporte_terrestre_codigo' => null,
            'confirmado_em' => '2026-09-12',
        ];
        $preparado = (object) [
            'id' => 501,
            'solicitacao_id' => 77,
            'cidade_origem_id' => 10,
            'cidade_destino_id' => 30,
            'data_partida' => '2026-09-17',
            'data_chegada' => '2026-09-18',
            'data_partida_confirmada' => null,
            'data_chegada_confirmada' => null,
            'modal_codigo' => 'TERRESTRE',
            'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
            'necessita_motorista' => 0,
            'confirmado_em' => null,
        ];
        $comDatas = clone $preparado;
        $comDatas->data_partida_confirmada = '2026-09-17';
        $comDatas->data_chegada_confirmada = '2026-09-18';

        DB::shouldReceive('transaction')
            ->once()
            ->andReturnUsing(static fn (callable $operacao): mixed => $operacao());
        $trechos->shouldReceive('buscar')->once()->with(501)->andReturn($original);
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $transportes->shouldReceive('buscarAtivo')
            ->once()
            ->with('OFICIAL_SEM_MOTORISTA')
            ->andReturn((object) ['codigo' => 'OFICIAL_SEM_MOTORISTA', 'necessita_motorista' => 0, 'gera_combustivel' => 0]);
        $trechos->shouldReceive('atualizarPreparacao')
            ->once()
            ->withArgs(static fn (int $id, array $dados, string $username, bool $limpar): bool => $id === 501
                && $username === 'edcley'
                && ! $limpar
                && $dados['cidade_destino_id'] === 30
                && $dados['modal_codigo'] === 'TERRESTRE'
                && $dados['transporte_terrestre_codigo'] === 'OFICIAL_SEM_MOTORISTA')
            ->andReturn($preparado);
        $trechos->shouldReceive('registrarConfirmacaoDatas')
            ->once()
            ->with(501, [
                'data_partida_confirmada' => '2026-09-17',
                'data_chegada_confirmada' => '2026-09-18',
            ], 'edcley', true)
            ->andReturn($comDatas);
        $trechos->shouldReceive('confirmar')
            ->once()
            ->withArgs(static fn (int $id, array $dados, string $username): bool => $id === 501
                && $username === 'edcley'
                && $dados['modal_codigo'] === 'TERRESTRE'
                && $dados['transporte_terrestre_codigo'] === 'OFICIAL_SEM_MOTORISTA'
                && $dados['codigo_reserva'] === 'NOVA')
            ->andReturn((object) [
                'id' => 501,
                'solicitacao_id' => 77,
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
                'codigo_reserva' => 'NOVA',
                'confirmado_em' => '2026-09-13',
            ]);
        $workflow->shouldNotReceive('aprovarEtapaAtual');

        $confirmado = (new DiariasTrechoService($trechos, $workflow, null, $this->dominios(), $transportes))
            ->confirmarNoWizard(77, 501, [
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 30,
                'data_partida' => '2026-09-17',
                'data_chegada' => '2026-09-18',
                'data_partida_confirmada' => '2026-09-17',
                'data_chegada_confirmada' => '2026-09-18',
                'modal_codigo' => 'TERRESTRE',
                'transporte_terrestre_codigo' => 'OFICIAL_SEM_MOTORISTA',
                'informacoes_complementares' => 'Ajuste operacional.',
                'codigo_reserva' => 'NOVA',
            ], $usuario);

        $this->assertSame('NOVA', $confirmado->codigo_reserva);
    }

    public function test_finalizar_transporte_setran_exige_todos_trechos_confirmados_e_avanca_fluxo(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $usuario = $this->usuario();

        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10, 'tipo_etapa' => 'TRANSPORTE']);
        $trechos->shouldReceive('todosEfetivosConfirmados')
            ->once()
            ->with(77)
            ->andReturn(true);
        $workflow->shouldReceive('aprovarEtapaAtual')
            ->once()
            ->with(77, $usuario, 'Todos os trechos foram confirmados pelo SETRAN.', 'SETRAN');

        (new DiariasTrechoService($trechos, $workflow, null, $this->dominios()))
            ->finalizarTransporteSetran(77, $usuario);

        $this->assertTrue(true);
    }

    public function test_finalizar_transporte_setran_bloqueia_conflito_antes_de_avancar_o_fluxo(): void
    {
        $trechos = Mockery::mock(DiariasTrechoRepositoryInterface::class);
        $workflow = Mockery::mock(DiariasWorkflowService::class);
        $conflitos = Mockery::mock(DiariasConflitoViagemService::class);
        $usuario = $this->usuario();

        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn (callable $callback) => $callback());
        $workflow->shouldReceive('validarPodeAtuarNaEtapa')
            ->once()
            ->with(77, $usuario, 'SETRAN', 'TRANSPORTE')
            ->andReturn((object) ['id' => 10]);
        $conflitos->shouldReceive('validarSolicitacaoPersistida')
            ->once()
            ->with(77, true)
            ->andThrow(new RuntimeException('Conflito de viagem.'));
        $trechos->shouldNotReceive('todosEfetivosConfirmados');
        $workflow->shouldNotReceive('aprovarEtapaAtual');

        $service = new DiariasTrechoService($trechos, $workflow, null, $this->dominios(), null, $conflitos);

        $this->expectExceptionMessage('Conflito de viagem.');
        $service->finalizarTransporteSetran(77, $usuario);
    }

    private function usuario(): DiariasUsuario
    {
        return new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley',
            lotacao: 'SETRAN',
            perfis: ['SETRAN'],
        );
    }

    private function dominios(): DiariasDominioRepository
    {
        return Mockery::mock(DiariasDominioRepository::class);
    }
}
```
</TESTS_UNIT_DIARIASTRECHOSERVICESETRANREFAZERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasUnidadeContextoServiceTest.php`
## <TESTS_UNIT_DIARIASUNIDADECONTEXTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasUnidadeContextoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasUnidadeContextoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_primeiro_envio_congela_confirmadora_definida_pela_beneficiaria(): void
public function test_origem_gapres_do_solicitante_nao_substitui_agrupadora_da_beneficiaria(): void
public function test_beneficiario_especial_forca_presi_mesmo_com_agrupadoras_mistas(): void
public function test_envio_reidrata_api_e_nao_usa_agrupadora_antiga_do_rascunho(): void
public function test_agrupadoras_validas_diferentes_sao_congeladas_e_retornadas_para_o_fluxo(): void
public function test_sem_agrupadora_valida_bloqueia_antes_do_congelamento(): void
public function test_contexto_incompleto_do_solicitante_falha_antes_de_consultar_beneficiarios(): void
public function test_alteracao_recalcula_e_congela_novo_grupo_confirmador(): void
private function service(
private function mapeamento(int $mapeamentoId, int $id, string $sigla): object
private function usuario(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Diarias\Contracts\DiariasConfirmadoraRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasFluxoRepositoryInterface;
use App\Services\Diarias\Contracts\DiariasPessoaGatewayInterface;
use App\Services\Diarias\DiariasAutorizacaoService;
use App\Services\Diarias\DiariasConfirmadoraResolver;
use App\Services\Diarias\DiariasUnidadeContextoService;
use App\Services\Diarias\DiariasUsuario;
use Illuminate\Support\Collection;
use Illuminate\Validation\ValidationException;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class DiariasUnidadeContextoServiceTest extends TestCase
{
    public function test_primeiro_envio_congela_confirmadora_definida_pela_beneficiaria(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('origemProrrogacaoParaCongelamento')->once()->with(77)->andReturnNull();
        $fluxo->shouldReceive('congelarContextoUnidade')->once()->with(77, [
            'unidade_origem_id' => 264,
            'unidade_origem_sigla' => 'STI',
            'unidade_origem_descricao' => 'SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO',
            'unidade_confirmadora_id' => 155,
            'unidade_confirmadora_sigla' => 'PRESI',
            'unidade_confirmadora_descricao' => 'PRESIDÊNCIA',
            'unidade_confirmadora_mapeamento_id' => 1,
            'unidade_confirmadora_grupo_nome' => 'PLANELEITO_DIARIAS_CONFIRMADOR_PRESI',
        ], 'maria');

        $confirmadoras = $this->service($fluxo, [[
            'nome' => 'LUCIANA DE ARRUDA MACEDO SANTOS',
            'lotacao_agrupadora_id' => '155',
            'lotacao_agrupadora_sigla' => 'PRESI',
            'tipo_vinculo' => 'SERVIDOR',
            'funcao_codigo' => 'CJ-3',
        ]])->congelarPrimeiroEnvio(77, $this->usuario());

        $this->assertSame('PRESI', $confirmadoras[0]['sigla']);
        $this->assertSame([1], $confirmadoras[0]['beneficiarios_ids']);
    }

    public function test_origem_gapres_do_solicitante_nao_substitui_agrupadora_da_beneficiaria(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('origemProrrogacaoParaCongelamento')->once()->with(77)->andReturnNull();
        $fluxo->shouldReceive('congelarContextoUnidade')->once()->withArgs(
            static fn (int $id, array $contexto, string $usuario): bool => $id === 77
                && $contexto['unidade_origem_sigla'] === 'GAPRES'
                && $contexto['unidade_confirmadora_sigla'] === 'DG'
                && $contexto['unidade_confirmadora_grupo_nome'] === 'PLANELEITO_DIARIAS_CONFIRMADOR_DG'
                && $usuario === 'ellen',
        );

        $this->service($fluxo, [[
            'lotacao_agrupadora_id' => '157',
            'lotacao_agrupadora_sigla' => 'DG',
            'tipo_vinculo' => 'SERVIDOR',
        ]])->congelarPrimeiroEnvio(77, $this->usuario(
            username: 'ellen',
            lotacaoId: '283',
            lotacao: 'GAPRES',
            lotacaoDescricao: 'GABINETE DA PRESIDÊNCIA',
        ));
    }

    public function test_beneficiario_especial_forca_presi_mesmo_com_agrupadoras_mistas(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('origemProrrogacaoParaCongelamento')->once()->andReturnNull();
        $fluxo->shouldReceive('congelarContextoUnidade')->once()->withArgs(
            static fn (int $id, array $contexto): bool => $id === 77
                && $contexto['unidade_confirmadora_sigla'] === 'PRESI',
        );

        $this->service($fluxo, [
            ['lotacao_agrupadora_id' => '157', 'lotacao_agrupadora_sigla' => 'DG', 'tipo_vinculo' => 'MAGISTRADO'],
            ['lotacao_agrupadora_id' => '264', 'lotacao_agrupadora_sigla' => 'STI', 'tipo_vinculo' => 'SERVIDOR'],
        ])->congelarPrimeiroEnvio(77, $this->usuario());
    }

    public function test_envio_reidrata_api_e_nao_usa_agrupadora_antiga_do_rascunho(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('origemProrrogacaoParaCongelamento')->once()->andReturnNull();
        $fluxo->shouldReceive('congelarContextoUnidade')->once()->withArgs(
            static fn (int $id, array $contexto): bool => $id === 77
                && $contexto['unidade_confirmadora_sigla'] === 'PRESI',
        );

        $this->service(
            $fluxo,
            [['lotacao_agrupadora_id' => '157', 'lotacao_agrupadora_sigla' => 'DG']],
            [['lotacao_agrupadora_id' => '155', 'lotacao_agrupadora_sigla' => 'PRESI']],
        )->congelarPrimeiroEnvio(77, $this->usuario());
    }

    public function test_agrupadoras_validas_diferentes_sao_congeladas_e_retornadas_para_o_fluxo(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('origemProrrogacaoParaCongelamento')->once()->andReturnNull();
        $fluxo->shouldReceive('congelarContextoUnidade')->once()->withArgs(
            static fn (int $id, array $contexto): bool => $id === 77
                && $contexto['unidade_confirmadora_sigla'] === 'DG',
        );

        $confirmadoras = $this->service($fluxo, [
            ['lotacao_agrupadora_id' => '157', 'lotacao_agrupadora_sigla' => 'DG'],
            ['lotacao_agrupadora_id' => '264', 'lotacao_agrupadora_sigla' => 'STI'],
        ])->congelarPrimeiroEnvio(77, $this->usuario());

        $this->assertSame(['DG', 'STI'], array_column($confirmadoras, 'sigla'));
        $this->assertSame([1], $confirmadoras[0]['beneficiarios_ids']);
        $this->assertSame([2], $confirmadoras[1]['beneficiarios_ids']);
    }

    public function test_sem_agrupadora_valida_bloqueia_antes_do_congelamento(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('origemProrrogacaoParaCongelamento')->once()->andReturnNull();
        $fluxo->shouldNotReceive('congelarContextoUnidade');

        $this->expectException(ValidationException::class);
        $this->expectExceptionMessage('não possui unidade confirmadora ativa');

        $this->service($fluxo, [[
            'lotacao_agrupadora_id' => null,
            'lotacao_agrupadora_sigla' => null,
        ]])->congelarPrimeiroEnvio(77, $this->usuario());
    }

    public function test_contexto_incompleto_do_solicitante_falha_antes_de_consultar_beneficiarios(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldNotReceive('origemProrrogacaoParaCongelamento');
        $fluxo->shouldNotReceive('congelarContextoUnidade');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('contexto organizacional');

        $this->service($fluxo, [])->congelarPrimeiroEnvio(
            77,
            $this->usuario(agrupadoraSigla: null),
        );
    }

    public function test_alteracao_recalcula_e_congela_novo_grupo_confirmador(): void
    {
        $fluxo = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $fluxo->shouldReceive('atualizarUnidadeConfirmadora')->once()->with(77, [
            'unidade_confirmadora_id' => 264,
            'unidade_confirmadora_sigla' => 'STI',
            'unidade_confirmadora_descricao' => 'STI',
            'unidade_confirmadora_mapeamento_id' => 3,
            'unidade_confirmadora_grupo_nome' => 'PLANELEITO_DIARIAS_CONFIRMADOR_STI',
        ], 'maria');

        $confirmadoras = $this->service($fluxo, [[
            'lotacao_agrupadora_id' => '264',
            'lotacao_agrupadora_sigla' => 'STI',
        ]])->recalcularConfirmadoraAlteracao(77, $this->usuario());

        $this->assertSame('STI', $confirmadoras[0]['sigla']);
    }

    private function service(
        DiariasFluxoRepositoryInterface $fluxo,
        array $beneficiarios,
        ?array $beneficiariosApi = null,
    ): DiariasUnidadeContextoService {
        $beneficiarios = array_map(static fn (array $item, int $indice): array => [
            'id' => $indice + 1,
            'cpf' => str_pad((string) ($indice + 1), 11, '0', STR_PAD_LEFT),
        ] + $item, $beneficiarios, array_keys($beneficiarios));
        $beneficiariosApi = array_values($beneficiariosApi ?? $beneficiarios);
        $confirmadoras = Mockery::mock(DiariasConfirmadoraRepositoryInterface::class);
        $confirmadoras->shouldReceive('beneficiariosRevisaoAtual')
            ->byDefault()
            ->with(77)
            ->andReturn(new Collection(array_map(static fn (array $item): object => (object) $item, $beneficiarios)));
        $confirmadoras->shouldReceive('atualizarSnapshotRoteamentoBeneficiario')->byDefault();
        $confirmadoras->shouldReceive('listarAtivos')->byDefault()->andReturn(new Collection([
            $this->mapeamento(1, 155, 'PRESI'),
            $this->mapeamento(2, 157, 'DG'),
            $this->mapeamento(3, 264, 'STI'),
            $this->mapeamento(4, 317, 'VICE-CRE'),
        ]));
        $pessoas = Mockery::mock(DiariasPessoaGatewayInterface::class);
        foreach ($beneficiarios as $indice => $beneficiario) {
            $pessoas->shouldReceive('buscarPorCpf')
                ->byDefault()
                ->with($beneficiario['cpf'])
                ->andReturn($beneficiariosApi[$indice] + [
                    'id' => $beneficiario['id'],
                    'cpf' => $beneficiario['cpf'],
                ]);
        }

        return new DiariasUnidadeContextoService(
            $fluxo,
            new DiariasAutorizacaoService,
            $confirmadoras,
            new DiariasConfirmadoraResolver($confirmadoras),
            $pessoas,
        );
    }

    private function mapeamento(int $mapeamentoId, int $id, string $sigla): object
    {
        return (object) [
            'mapeamento_id' => $mapeamentoId,
            'agrupadora_id' => $id,
            'agrupadora_sigla' => $sigla,
            'agrupadora_descricao' => $sigla === 'PRESI' ? 'PRESIDÊNCIA' : $sigla,
            'grupo_nome' => 'PLANELEITO_DIARIAS_CONFIRMADOR_'.str_replace('-', '_', $sigla),
        ];
    }

    private function usuario(
        string $username = 'maria',
        string $lotacaoId = '264',
        string $lotacao = 'STI',
        string $lotacaoDescricao = 'SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO',
        string $agrupadoraId = '317',
        ?string $agrupadoraSigla = 'VICE-CRE',
    ): DiariasUsuario {
        return new DiariasUsuario(
            username: $username,
            grupos: ['PLANELEITO_DIARIAS_SOLICITANTE'],
            lotacao: $lotacao,
            lotacaoDescricao: $lotacaoDescricao,
            lotacaoId: $lotacaoId,
            lotacaoAgrupadoraId: $agrupadoraId,
            lotacaoAgrupadoraSigla: $agrupadoraSigla,
            lotacaoAgrupadoraDescricao: 'VICE-PRESIDÊNCIA E CORREGEDORIA',
        );
    }
}
```
</TESTS_UNIT_DIARIASUNIDADECONTEXTOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasUnidadeSeiServiceTest.php`
## <TESTS_UNIT_DIARIASUNIDADESEISERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasUnidadeSeiServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasUnidadeSeiServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_valida_unidade_retornada_pela_api_do_usuario(): void
public function test_bloqueia_unidade_ausente_sem_consultar_api(): void
public function test_bloqueia_unidade_fora_da_lista_do_usuario(): void
public function test_lista_somente_unidades_do_usuario_onde_processo_esta_aberto(): void
public function test_bloqueia_processo_sem_unidade_aberta_acessivel_ao_usuario(): void
public function test_bloqueia_unidade_manipulada_em_processo_existente(): void
public function test_bloqueia_processo_fechado(): void
public function test_propaga_indisponibilidade_da_api_de_unidades_do_usuario(): void
public function test_propaga_indisponibilidade_da_api_de_unidades_do_processo(): void
private function usuario(): DiariasUsuario
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Diarias\DiariasPessoaApiClient;
use App\Services\Diarias\DiariasApiExternaIndisponivelException;
use App\Services\Diarias\DiariasUnidadeSeiService;
use App\Services\Diarias\DiariasUsuario;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class DiariasUnidadeSeiServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_valida_unidade_retornada_pela_api_do_usuario(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')
            ->once()
            ->with('edcley')
            ->andReturn([
                ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - Gestão de Tecnologia'],
            ]);

        $idUnidade = (new DiariasUnidadeSeiService($client))->validarParaGeracao($this->usuario(), '288');

        $this->assertSame('288', $idUnidade);
    }

    public function test_bloqueia_unidade_ausente_sem_consultar_api(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldNotReceive('consultarUnidadesSei');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('unidade SEI');

        (new DiariasUnidadeSeiService($client))->validarParaGeracao($this->usuario(), '');
    }

    public function test_bloqueia_unidade_fora_da_lista_do_usuario(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')
            ->once()
            ->with('edcley')
            ->andReturn([
                ['ID_UNIDADE' => '288', 'SIGLA' => 'GSTI'],
            ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('unidade SEI selecionada');

        (new DiariasUnidadeSeiService($client))->validarParaGeracao($this->usuario(), '999');
    }

    public function test_lista_somente_unidades_do_usuario_onde_processo_esta_aberto(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')->once()->with('edcley')->andReturn([
            ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
            ['id' => '110000950', 'sigla' => 'CGOVTIC', 'text' => 'CGOVTIC - 110000950'],
        ]);
        $client->shouldReceive('consultarUnidadesProcedimentoSei')
            ->once()
            ->with('0001469-96.2026.6.01.8000')
            ->andReturn([
                'encontrado' => true,
                'aberto' => true,
                'unidades' => [
                    ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
                    ['id' => '110000978', 'sigla' => 'Z-ARQUIVO-GAPRES', 'text' => 'Z-ARQUIVO-GAPRES - 110000978'],
                ],
            ]);

        $resultado = (new DiariasUnidadeSeiService($client))->listarParaProcesso(
            $this->usuario(),
            '0001469-96.2026.6.01.8000'
        );

        $this->assertSame([
            ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
        ], $resultado);
    }

    public function test_bloqueia_processo_sem_unidade_aberta_acessivel_ao_usuario(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')->once()->andReturn([
            ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
        ]);
        $client->shouldReceive('consultarUnidadesProcedimentoSei')->once()->andReturn([
            'encontrado' => true,
            'aberto' => true,
            'unidades' => [
                ['id' => '110000978', 'sigla' => 'Z-ARQUIVO-GAPRES', 'text' => 'Z-ARQUIVO-GAPRES - 110000978'],
            ],
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('não está aberto em nenhuma unidade acessível ao usuário');

        (new DiariasUnidadeSeiService($client))->listarParaProcesso(
            $this->usuario(),
            '0000763-50.2025.6.01.8000'
        );
    }

    public function test_bloqueia_unidade_manipulada_em_processo_existente(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')->once()->andReturn([
            ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
            ['id' => '110000950', 'sigla' => 'CGOVTIC', 'text' => 'CGOVTIC - 110000950'],
        ]);
        $client->shouldReceive('consultarUnidadesProcedimentoSei')->once()->andReturn([
            'encontrado' => true,
            'aberto' => true,
            'unidades' => [
                ['id' => 288, 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
            ],
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('unidade SEI selecionada');

        (new DiariasUnidadeSeiService($client))->validarParaProcesso(
            $this->usuario(),
            '0001469-96.2026.6.01.8000',
            '110000950'
        );
    }

    public function test_bloqueia_processo_fechado(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')->once()->andReturn([
            ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
        ]);
        $client->shouldReceive('consultarUnidadesProcedimentoSei')->once()->andReturn([
            'encontrado' => true,
            'aberto' => false,
            'unidades' => [],
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('não está aberto em nenhuma unidade');

        (new DiariasUnidadeSeiService($client))->listarParaProcesso(
            $this->usuario(),
            '0001469-96.2026.6.01.8000'
        );
    }

    public function test_propaga_indisponibilidade_da_api_de_unidades_do_usuario(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')->once()->andThrow(
            new DiariasApiExternaIndisponivelException('API do usuário indisponível.')
        );
        $client->shouldNotReceive('consultarUnidadesProcedimentoSei');

        $this->expectException(DiariasApiExternaIndisponivelException::class);

        (new DiariasUnidadeSeiService($client))->listarParaProcesso(
            $this->usuario(),
            '0001469-96.2026.6.01.8000'
        );
    }

    public function test_propaga_indisponibilidade_da_api_de_unidades_do_processo(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('consultarUnidadesSei')->once()->andReturn([
            ['id' => '288', 'sigla' => 'GSTI', 'text' => 'GSTI - 288'],
        ]);
        $client->shouldReceive('consultarUnidadesProcedimentoSei')->once()->andThrow(
            new DiariasApiExternaIndisponivelException('API do processo indisponível.')
        );

        $this->expectException(DiariasApiExternaIndisponivelException::class);

        (new DiariasUnidadeSeiService($client))->listarParaProcesso(
            $this->usuario(),
            '0001469-96.2026.6.01.8000'
        );
    }

    private function usuario(): DiariasUsuario
    {
        return new DiariasUsuario(
            username: 'edcley',
            nome: 'Edcley Firmino',
            email: 'edcley@tre-ac.jus.br',
            grupos: ['PLANELEITO_ADMIN'],
        );
    }
}
```
</TESTS_UNIT_DIARIASUNIDADESEISERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasUsuarioLogadoApiTest.php`
## <TESTS_UNIT_DIARIASUSUARIOLOGADOAPITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasUsuarioLogadoApiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasUsuarioLogadoApiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_retorna_somente_correspondencia_exata_case_insensitive(): void
public function test_falha_fechada_quando_api_retorna_email_exato_ambiguo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Diarias\DiariasPessoaApiClient;
use App\Services\Diarias\DiariasUsuarioLogadoApi;
use Mockery;
use Tests\TestCase;

class DiariasUsuarioLogadoApiTest extends TestCase
{
    public function test_retorna_somente_correspondencia_exata_case_insensitive(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('buscar')
            ->once()
            ->with(['email' => 'veronica@tre-ac.jus.br'])
            ->andReturn([
                ['email' => 'outra-veronica@tre-ac.jus.br', 'lotacao_id' => '157'],
                ['email' => 'VERONICA@TRE-AC.JUS.BR', 'lotacao_id' => '283'],
            ]);

        $resultado = (new DiariasUsuarioLogadoApi($client))->buscarPorEmail(' Veronica@TRE-AC.JUS.BR ');

        $this->assertSame('283', $resultado['lotacao_id'] ?? null);
    }

    public function test_falha_fechada_quando_api_retorna_email_exato_ambiguo(): void
    {
        $client = Mockery::mock(DiariasPessoaApiClient::class);
        $client->shouldReceive('buscar')
            ->once()
            ->with(['email' => 'veronica@tre-ac.jus.br'])
            ->andReturn([
                ['email' => 'veronica@tre-ac.jus.br', 'cpf' => '11111111111'],
                ['email' => 'VERONICA@TRE-AC.JUS.BR', 'cpf' => '22222222222'],
            ]);

        $this->assertNull(
            (new DiariasUsuarioLogadoApi($client))->buscarPorEmail('veronica@tre-ac.jus.br')
        );
    }
}
```
</TESTS_UNIT_DIARIASUSUARIOLOGADOAPITEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasValorTransporteTest.php`
## <TESTS_UNIT_DIARIASVALORTRANSPORTETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasValorTransporteTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasValorTransporteTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_conversoes_compartilhadas_preservam_texto_numero_booleano_e_data(): void
public function test_identificacao_de_transporte_proprio_e_oficial_e_centralizada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Diarias\DiariasTransporte;
use App\Support\Diarias\DiariasValor;
use Tests\TestCase;

class DiariasValorTransporteTest extends TestCase
{
    public function test_conversoes_compartilhadas_preservam_texto_numero_booleano_e_data(): void
    {
        $this->assertNull(DiariasValor::textoOuNull('  '));
        $this->assertSame('Texto', DiariasValor::textoOuNull(' Texto '));
        $this->assertSame('TEXTO', DiariasValor::textoMaiusculoOuNull(' Texto '));
        $this->assertSame(1234.56, DiariasValor::numeroOuNull('1.234,56'));
        $this->assertSame(1234.56, DiariasValor::numeroOuNull('1234,56'));
        $this->assertNull(DiariasValor::numeroOuNull('informe'));
        $this->assertSame(1, DiariasValor::booleanoComoInt('SIM'));
        $this->assertSame(0, DiariasValor::booleanoComoInt('não'));
        $this->assertNull(DiariasValor::booleanoOuNullComoInt(''));
        $this->assertSame('2026-07-27', DiariasValor::dataIsoOuNull('2026-07-27')?->format('Y-m-d'));
        $this->assertNull(DiariasValor::dataIsoOuNull('27/07/2026'));
    }

    public function test_identificacao_de_transporte_proprio_e_oficial_e_centralizada(): void
    {
        $proprio = (object) ['modal_codigo' => ' terrestre ', 'transporte_terrestre_codigo' => ' proprio '];
        $oficial = (object) ['modal_codigo' => 'TERRESTRE', 'transporte_terrestre_codigo' => 'OFICIAL_COM_MOTORISTA'];
        $aereo = (object) ['modal_codigo' => 'AEREO', 'transporte_terrestre_codigo' => null];

        $this->assertTrue(DiariasTransporte::trechoVeiculoProprio($proprio));
        $this->assertTrue(DiariasTransporte::proprioOuOficial($proprio));
        $this->assertTrue(DiariasTransporte::proprioOuOficial($oficial));
        $this->assertFalse(DiariasTransporte::trechoVeiculoProprio($oficial));
        $this->assertFalse(DiariasTransporte::proprioOuOficial($aereo));
    }
}
```
</TESTS_UNIT_DIARIASVALORTRANSPORTETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DiariasWorkflowAutheliaTest.php`
## <TESTS_UNIT_DIARIASWORKFLOWAUTHELIATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DiariasWorkflowAutheliaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DiariasWorkflowAutheliaTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_workflow_nao_usa_perfis_titularidade_ou_lotacao_da_api_para_autorizar(): void
public function test_fila_de_aprovacao_repassa_uniao_dos_setores_e_grupos_congelados_ao_repository(): void
public function test_fila_de_aprovacao_do_administrador_sem_grupo_funcional_fica_vazia(): void
public function test_exportacao_de_aprovacoes_do_administrador_sem_grupo_funcional_fica_vazia(): void
public function test_validacao_backend_recusa_administrador_sem_grupo_da_etapa(): void
public function test_administrador_so_atua_como_spef_quando_possui_o_grupo_funcional(): void
public function test_etapa_unidade_exige_o_grupo_congelado_na_revisao(): void
private function workflow(?DiariasFluxoRepositoryInterface $repository = null): DiariasWorkflowService
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Diarias\Contracts\DiariasFluxoRepositoryInterface;
use App\Services\Diarias\DiariasAutorizacaoService;
use App\Services\Diarias\DiariasLegadoService;
use App\Services\Diarias\DiariasUsuario;
use App\Services\Diarias\DiariasWorkflowService;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class DiariasWorkflowAutheliaTest extends TestCase
{
    public function test_workflow_nao_usa_perfis_titularidade_ou_lotacao_da_api_para_autorizar(): void
    {
        $workflow = $this->workflow();
        $usuario = new DiariasUsuario(
            username: 'api',
            lotacao: 'SAOF',
            perfis: ['DEFERIDOR', 'FINANCEIRO', 'SETRAN'],
            titular: true,
        );

        foreach (['UNIDADE', 'DG', 'PRESIDENCIA', 'SETRAN', 'FIN', 'PAGAMENTO'] as $setor) {
            $this->assertFalse($workflow->usuarioPodeAtuarNaEtapa((object) [
                'setor_codigo' => $setor,
                'unidade_confirmadora_sigla' => 'SAOF',
            ], $usuario));
        }
        $this->assertFalse($workflow->usuarioPodeAtuarComoSpef($usuario));
    }

    public function test_fila_de_aprovacao_repassa_uniao_dos_setores_e_grupos_congelados_ao_repository(): void
    {
        $repository = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $repository->shouldReceive('listarPendenciasAprovacao')
            ->once()
            ->with(
                ['status' => 'SOLICITADA'],
                ['DG'],
                ['PLANELEITO_DIARIAS_CONFIRMADOR_VICE_CRE'],
                20,
            )
            ->andReturn(new LengthAwarePaginator([], 0, 20));

        $usuario = new DiariasUsuario(
            username: 'multi',
            grupos: ['PLANELEITO_DIARIAS_DEFERIDORA', 'PLANELEITO_DIARIAS_CONFIRMADOR_VICE_CRE'],
        );

        $this->workflow($repository)->pendenciasAprovacaoPara($usuario, ['status' => 'SOLICITADA'], 20);
    }

    public function test_fila_de_aprovacao_do_administrador_sem_grupo_funcional_fica_vazia(): void
    {
        $repository = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $repository->shouldReceive('listarPendenciasAprovacao')
            ->once()
            ->with(
                [],
                Mockery::on(static fn (mixed $setores): bool => $setores === []),
                Mockery::on(static fn (mixed $grupos): bool => $grupos === []),
                10,
            )
            ->andReturn(new LengthAwarePaginator([], 0, 10));

        $this->workflow($repository)->pendenciasAprovacaoPara(
            new DiariasUsuario(username: 'admin', grupos: ['PLANELEITO_ADMIN']),
        );
    }

    public function test_exportacao_de_aprovacoes_do_administrador_sem_grupo_funcional_fica_vazia(): void
    {
        $repository = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $repository->shouldReceive('listarPendenciasAprovacaoParaExportacao')
            ->once()
            ->with(
                [],
                Mockery::on(static fn (mixed $setores): bool => $setores === []),
                Mockery::on(static fn (mixed $grupos): bool => $grupos === []),
            )
            ->andReturn(new Collection);

        $this->workflow($repository)->pendenciasAprovacaoParaExportacao(
            new DiariasUsuario(username: 'admin', grupos: ['PLANELEITO_ADMIN']),
        );
    }

    public function test_validacao_backend_recusa_administrador_sem_grupo_da_etapa(): void
    {
        $repository = Mockery::mock(DiariasFluxoRepositoryInterface::class);
        $repository->shouldReceive('etapaAtual')->once()->with(91)->andReturn((object) [
            'setor_codigo' => 'PRESIDENCIA',
            'tipo_etapa' => 'APROVACAO',
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('permissão funcional');

        $this->workflow($repository)->validarPodeAtuarNaEtapa(
            91,
            new DiariasUsuario(username: 'admin', grupos: ['PLANELEITO_ADMIN']),
            'PRESIDENCIA',
            'APROVACAO',
        );
    }

    public function test_administrador_so_atua_como_spef_quando_possui_o_grupo_funcional(): void
    {
        $workflow = $this->workflow();

        $this->assertFalse($workflow->usuarioPodeAtuarComoSpef(
            new DiariasUsuario(username: 'admin', grupos: ['PLANELEITO_ADMIN']),
        ));
        $this->assertTrue($workflow->usuarioPodeAtuarComoSpef(
            new DiariasUsuario(username: 'admin', grupos: ['PLANELEITO_ADMIN', 'PLANELEITO_DIARIAS_SPEF']),
        ));
    }

    public function test_etapa_unidade_exige_o_grupo_congelado_na_revisao(): void
    {
        $workflow = $this->workflow();

        $this->assertTrue($workflow->usuarioPodeAtuarNaEtapa(
            (object) [
                'setor_codigo' => 'UNIDADE',
                'unidade_confirmadora_sigla' => 'VICE-CRE',
                'unidade_confirmadora_grupo_nome' => 'PLANELEITO_DIARIAS_CONFIRMADOR_VICE_CRE',
            ],
            new DiariasUsuario(username: 'vice', grupos: ['PLANELEITO_DIARIAS_CONFIRMADOR_VICE_CRE']),
        ));
        $this->assertFalse($workflow->usuarioPodeAtuarNaEtapa(
            (object) [
                'setor_codigo' => 'UNIDADE',
                'unidade_confirmadora_sigla' => 'VICE-CRE',
                'unidade_confirmadora_grupo_nome' => 'PLANELEITO_DIARIAS_CONFIRMADOR_DG',
            ],
            new DiariasUsuario(username: 'vice', grupos: ['PLANELEITO_DIARIAS_CONFIRMADOR_VICE_CRE']),
        ));
    }

    private function workflow(?DiariasFluxoRepositoryInterface $repository = null): DiariasWorkflowService
    {
        return new DiariasWorkflowService(
            $repository ?? Mockery::mock(DiariasFluxoRepositoryInterface::class),
            Mockery::mock(DiariasLegadoService::class),
            autorizacao: new DiariasAutorizacaoService,
        );
    }
}
```
</TESTS_UNIT_DIARIASWORKFLOWAUTHELIATEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/GelTempoDeslocamentoMigrationTest.php`
## <TESTS_UNIT_GELTEMPODESLOCAMENTOMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/GelTempoDeslocamentoMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GelTempoDeslocamentoMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_migration_cria_tabela_historica_de_tempo_de_deslocamento_gel_sem_fk_fisica(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class GelTempoDeslocamentoMigrationTest extends TestCase
{
    public function test_migration_cria_tabela_historica_de_tempo_de_deslocamento_gel_sem_fk_fisica(): void
    {
        $path = database_path("migrations/2026_07_14_120000_create_gel_tempo_deslocamento_table.php");

        $this->assertFileExists($path);
        $conteudo = file_get_contents($path);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString("CREATE TABLE gel_tempo_deslocamento", $conteudo);
        $this->assertStringContainsString("cod_objeto_local VARCHAR2(18 CHAR) NOT NULL", $conteudo);
        $this->assertStringContainsString("cod_vistoria NUMBER(19,0) NOT NULL", $conteudo);
        $this->assertStringContainsString("cod_question_vistoria NUMBER(19,0) NOT NULL", $conteudo);
        $this->assertStringContainsString("tempo_deslocamento_horas NUMBER(8,2)", $conteudo);
        $this->assertStringContainsString("classificacao VARCHAR2(30 CHAR) NOT NULL", $conteudo);
        $this->assertStringContainsString("criterio_analise VARCHAR2(30 CHAR) NOT NULL", $conteudo);
        $this->assertStringContainsString("CREATE UNIQUE INDEX ux_gel_tempo_desloc_01 ON gel_tempo_deslocamento (cod_objeto_local, cod_vistoria, cod_question_vistoria)", $conteudo);
        $this->assertStringContainsString("ck_gel_tempo_desloc_class", $conteudo);
        $this->assertStringContainsString("ATE_1H", $conteudo);
        $this->assertStringContainsString("MAIS_1H", $conteudo);
        $this->assertStringContainsString("SEM_INFO_APROVEITAVEL", $conteudo);
        $this->assertStringContainsString("ck_gel_tempo_desloc_criterio", $conteudo);
        $this->assertStringContainsString("EXTRAIDO", $conteudo);
        $this->assertStringContainsString("SOMADO", $conteudo);
        $this->assertStringContainsString("MANUAL", $conteudo);
        $this->assertStringContainsString("NAO_APROVEITAVEL", $conteudo);
        $this->assertStringContainsString("ck_gel_tempo_desloc_coerencia", $conteudo);
        $this->assertStringNotContainsString("FOREIGN KEY", strtoupper($conteudo));
    }
}
```
</TESTS_UNIT_GELTEMPODESLOCAMENTOMIGRATIONTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/GelTempoDeslocamentoServiceTest.php`
## <TESTS_UNIT_GELTEMPODESLOCAMENTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/GelTempoDeslocamentoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GelTempoDeslocamentoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function parser_extrai_minutos_horas_numericas_extenso_e_soma_etapas(): void
public function parser_mantem_sem_info_quando_texto_nao_tem_tempo_aproveitavel(): void
public function analise_efetiva_prefere_principal_e_usa_fallback_quando_principal_nao_aproveita(): void
public function analise_efetiva_nao_cria_registro_quando_nao_ha_pergunta_principal(): void
public function analise_efetiva_grava_sem_info_da_principal_quando_nenhuma_fonte_tem_tempo(): void
private function registro(string $fonte, int $questao, string $resposta): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Gel\GelTempoDeslocamentoService;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class GelTempoDeslocamentoServiceTest extends TestCase
{
    #[Test]
    public function parser_extrai_minutos_horas_numericas_extenso_e_soma_etapas(): void
    {
        $service = new GelTempoDeslocamentoService();

        $this->assertSame(0.25, $service->analisarResposta('15 minutos')['tempo_deslocamento_horas']);
        $this->assertSame(0.17, $service->analisarResposta('10m')['tempo_deslocamento_horas']);
        $this->assertSame(6.0, $service->analisarResposta('Em media de 6h')['tempo_deslocamento_horas']);
        $this->assertSame(2.0, $service->analisarResposta('cerca de duas horas em estrada de terra')['tempo_deslocamento_horas']);

        $analise = $service->analisarResposta('1h de carro e 30 minutos de barco');
        $this->assertSame(1.5, $analise['tempo_deslocamento_horas']);
        $this->assertSame('MAIS_1H', $analise['classificacao']);
        $this->assertSame('SOMADO', $analise['criterio_analise']);
    }

    #[Test]
    public function parser_mantem_sem_info_quando_texto_nao_tem_tempo_aproveitavel(): void
    {
        $service = new GelTempoDeslocamentoService();

        $analise = $service->analisarResposta('Asfalto e estrada de terra');

        $this->assertNull($analise['tempo_deslocamento_horas']);
        $this->assertSame('SEM_INFO_APROVEITAVEL', $analise['classificacao']);
        $this->assertSame('NAO_APROVEITAVEL', $analise['criterio_analise']);
    }

    #[Test]
    public function analise_efetiva_prefere_principal_e_usa_fallback_quando_principal_nao_aproveita(): void
    {
        $service = new GelTempoDeslocamentoService();

        $principalAproveitavel = $this->registro('PRINCIPAL', 100, '45 minutos');
        $fallbackAproveitavel = $this->registro('FALLBACK', 90, 'duas horas de viagem');

        $analise = $service->resolverAnaliseEfetiva($principalAproveitavel, $fallbackAproveitavel);
        $this->assertSame(100, $analise['cod_question_vistoria']);
        $this->assertSame('PRINCIPAL', $analise['fonte_analise']);
        $this->assertSame('ATE_1H', $analise['classificacao']);

        $principalSemInfo = $this->registro('PRINCIPAL', 101, 'Nao se aplica');
        $analiseFallback = $service->resolverAnaliseEfetiva($principalSemInfo, $fallbackAproveitavel);
        $this->assertSame(90, $analiseFallback['cod_question_vistoria']);
        $this->assertSame('FALLBACK', $analiseFallback['fonte_analise']);
        $this->assertSame('MAIS_1H', $analiseFallback['classificacao']);
    }


    #[Test]
    public function analise_efetiva_nao_cria_registro_quando_nao_ha_pergunta_principal(): void
    {
        $service = new GelTempoDeslocamentoService();

        $this->assertNull($service->resolverAnaliseEfetiva(
            null,
            $this->registro('FALLBACK', 90, 'duas horas de viagem')
        ));
    }

    #[Test]
    public function analise_efetiva_grava_sem_info_da_principal_quando_nenhuma_fonte_tem_tempo(): void
    {
        $service = new GelTempoDeslocamentoService();

        $analise = $service->resolverAnaliseEfetiva(
            $this->registro('PRINCIPAL', 100, 'Nao se aplica'),
            $this->registro('FALLBACK', 90, 'Asfalto')
        );

        $this->assertSame(100, $analise['cod_question_vistoria']);
        $this->assertSame('PRINCIPAL', $analise['fonte_analise']);
        $this->assertSame('SEM_INFO_APROVEITAVEL', $analise['classificacao']);
        $this->assertSame('NAO_APROVEITAVEL', $analise['criterio_analise']);
    }

    /**
     * @return array<string, mixed>
     */
    private function registro(string $fonte, int $questao, string $resposta): array
    {
        return [
            'fonte' => $fonte,
            'cod_objeto_local' => '123',
            'cod_vistoria' => 456,
            'cod_question_vistoria' => $questao,
            'dat_vistoria' => '2026-07-14 10:00:00',
            'resposta' => $resposta,
        ];
    }
}
```
</TESTS_UNIT_GELTEMPODESLOCAMENTOSERVICETEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoDeslocamentoControllerTest.php`
## <TESTS_UNIT_LOCALVOTACAODESLOCAMENTOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoDeslocamentoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoDeslocamentoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_update_salva_deslocamento_no_turno_ativo_na_mesma_transacao_composta(): void
private function request(): LocalVotacaoUpdateRequest
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
use App\Repositories\LocaisVotacao\LocalVotacaoDeslocamentoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoOperacionalRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\LocaisVotacao\LocalVotacaoZonaRuralRepository;
use App\Services\Lda\RecursoLogisticoLocalService;
use App\Services\LocaisVotacao\TrajetoLocalVotacaoService;
use App\Services\Lda\TransmissaoPreferenciaService;
use Mockery;
use Tests\TestCase;

class LocalVotacaoDeslocamentoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_update_salva_deslocamento_no_turno_ativo_na_mesma_transacao_composta(): void
    {
        session([
            'macroprojeto_ativo_id' => 14,
            'macroprojeto_turno_ativo_id' => 501,
            'cod_zonas_permitidas' => [4],
            'acesso_todas_zonas' => false,
        ]);

        $repository = Mockery::mock(LocalVotacaoRepository::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with('LV-10', [4], false)->andReturn((object) ['cod_objeto' => 'LV-10']);
        $repository->shouldReceive('atualizarCoordenadas')->once()->with('LV-10', null, null);

        $transmissao = Mockery::mock(TransmissaoPreferenciaService::class);
        $transmissao->shouldReceive('sincronizar')->once()->with('LV-10', []);
        $trajeto = Mockery::mock(TrajetoLocalVotacaoService::class);
        $trajeto->shouldReceive('salvarPorLocal')->once()->with('LV-10', 14, []);
        $recursos = Mockery::mock(RecursoLogisticoLocalService::class);
        $recursos->shouldReceive('salvarPorLocal')->once()->with('LV-10', 14, []);
        $operacional = Mockery::mock(LocalVotacaoOperacionalRepository::class);
        $operacional->shouldReceive('salvarDiaInstalacaoUrnasPorLocal')->once()->with('LV-10', 14, null);
        $zonaRural = Mockery::mock(LocalVotacaoZonaRuralRepository::class);
        $zonaRural->shouldNotReceive('sincronizarMarcacao');
        $deslocamento = Mockery::mock(LocalVotacaoDeslocamentoRepository::class);
        $deslocamento->shouldReceive('salvarPorLocal')->once()->with('LV-10', 501, [
            'dt_saida_prevista' => '2026-10-02 08:00:00',
            'dt_chegada_prevista' => '2026-10-02 12:00:00',
            'dt_saida_real' => null,
            'dt_chegada_real' => null,
            'dt_saida_prevista_volta' => '2026-10-03 16:00:00',
            'dt_chegada_prevista_volta' => '2026-10-03 22:00:00',
            'dt_saida_real_volta' => null,
            'dt_chegada_real_volta' => null,
            'observacao_deslocamento' => 'Janela operacional',
        ]);

        $controller = new LocalVotacaoCrudController(
            repository: $repository,
            localDificilAcessoRepository: Mockery::mock(LocalDificilAcessoRepository::class),
            transmissaoPreferenciaService: $transmissao,
            gelRespostaRepository: Mockery::mock(GelRespostaRepository::class),
            recursoLogisticoLocalService: $recursos,
            localVotacaoOperacionalRepository: $operacional,
            localVotacaoZonaRuralRepository: $zonaRural,
            trajetoLocalVotacaoService: $trajeto,
            localVotacaoDeslocamentoRepository: $deslocamento,
        );

        $response = $controller->update($this->request(), 'LV-10');

        $this->assertTrue($response->isRedirect(route('lda.locais-votacao.index')));
    }

    private function request(): LocalVotacaoUpdateRequest
    {
        $request = LocalVotacaoUpdateRequest::create('/lda/locais-votacao/LV-10', 'PUT', [
            'dt_saida_prevista' => '2026-10-02T08:00',
            'dt_chegada_prevista' => '2026-10-02T12:00',
            'dt_saida_prevista_volta' => '2026-10-03T16:00',
            'dt_chegada_prevista_volta' => '2026-10-03T22:00',
            'observacao_deslocamento' => ' Janela operacional ',
        ]);
        $request->setContainer($this->app);
        $request->setRedirector($this->app['redirect']);
        $request->validateResolved();

        return $request;
    }
}
```
</TESTS_UNIT_LOCALVOTACAODESLOCAMENTOCONTROLLERTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LocalVotacaoDeslocamentoRepositoryTest.php`
## <TESTS_UNIT_LOCALVOTACAODESLOCAMENTOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LocalVotacaoDeslocamentoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LocalVotacaoDeslocamentoRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('local_votacao_deslocamento', function ($table): void {
$this->assertSame(1, DB::table('local_votacao_deslocamento')->count());
$this->assertSame(0, DB::table('local_votacao_deslocamento')->count());
$this->assertSame(1, DB::table('local_votacao_deslocamento')->count());
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function inserir(array $payload): void
public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
protected function agoraBanco(): mixed
public function test_salva_atualiza_e_remove_com_auditoria_pela_chave_local_turno(): void
public function test_persiste_somente_volta_e_rejeita_volta_anterior_a_ida(): void
public function test_payload_vazio_ausente_nao_gera_dml_e_turnos_ficam_isolados(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Repositories\LocaisVotacao\LocalVotacaoDeslocamentoRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class LocalVotacaoDeslocamentoRepositoryTest extends TestCase
{
    private object $auditRepository;

    private LocalVotacaoDeslocamentoRepository $repository;

    protected function setUp(): void
    {
        parent::setUp();

        Schema::dropIfExists('local_votacao_deslocamento');
        Schema::create('local_votacao_deslocamento', function ($table): void {
            $table->increments('id');
            $table->string('cod_objeto_local', 18);
            $table->integer('macroprojeto_turno_id');
            $table->dateTime('dt_saida_prevista')->nullable();
            $table->dateTime('dt_chegada_prevista')->nullable();
            $table->dateTime('dt_saida_real')->nullable();
            $table->dateTime('dt_chegada_real')->nullable();
            $table->dateTime('dt_saida_prevista_volta')->nullable();
            $table->dateTime('dt_chegada_prevista_volta')->nullable();
            $table->dateTime('dt_saida_real_volta')->nullable();
            $table->dateTime('dt_chegada_real_volta')->nullable();
            $table->text('observacao_deslocamento')->nullable();
            $table->dateTime('dt_criacao');
            $table->dateTime('dt_atualizacao')->nullable();
            $table->unique(['cod_objeto_local', 'macroprojeto_turno_id']);
        });

        $this->auditRepository = new class implements AuditLogRepositoryInterface
        {
            public array $eventos = [];

            public function inserir(array $payload): void
            {
                $this->eventos[] = $payload;
            }

            public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
            {
                throw new \RuntimeException('Operacao nao usada neste teste.');
            }
        };

        $this->repository = new class(new AuditLogService($this->auditRepository)) extends LocalVotacaoDeslocamentoRepository
        {
            protected function agoraBanco(): mixed
            {
                return '2026-08-06 12:00:00';
            }
        };
    }

    public function test_salva_atualiza_e_remove_com_auditoria_pela_chave_local_turno(): void
    {
        $this->repository->salvarPorLocal(' LV-10 ', 501, [
            'dt_saida_prevista' => '2026-10-02 08:00:00',
            'dt_chegada_prevista' => '2026-10-02 12:00:00',
            'dt_saida_prevista_volta' => '2026-10-03 16:00:00',
            'dt_chegada_prevista_volta' => '2026-10-03 22:00:00',
            'observacao_deslocamento' => 'Janela inicial',
        ]);

        $this->assertSame(1, DB::table('local_votacao_deslocamento')->count());
        $this->assertSame('INSERT', $this->auditRepository->eventos[0]['acao']);

        $this->repository->salvarPorLocal('LV-10', 501, [
            'dt_saida_prevista' => '2026-10-02 08:30:00',
            'dt_chegada_prevista' => '2026-10-02 12:00:00',
            'dt_saida_real' => '2026-10-02 08:35:00',
            'dt_saida_prevista_volta' => '2026-10-03 16:30:00',
            'dt_chegada_prevista_volta' => '2026-10-03 22:00:00',
            'dt_saida_real_volta' => '2026-10-03 16:40:00',
            'dt_chegada_real_volta' => '2026-10-03 22:20:00',
            'observacao_deslocamento' => 'Saida confirmada',
        ]);

        $registro = $this->repository->buscarPorLocal('LV-10', 501);
        $this->assertSame('2026-10-02 08:30', $registro['dt_saida_prevista']);
        $this->assertSame('2026-10-03 22:20', $registro['dt_chegada_real_volta']);
        $this->assertSame('Saida confirmada', $registro['observacao_deslocamento']);
        $this->assertSame('UPDATE', $this->auditRepository->eventos[1]['acao']);

        $this->repository->salvarPorLocal('LV-10', 501, []);

        $this->assertSame(0, DB::table('local_votacao_deslocamento')->count());
        $this->assertSame('DELETE', $this->auditRepository->eventos[2]['acao']);
    }

    public function test_persiste_somente_volta_e_rejeita_volta_anterior_a_ida(): void
    {
        $this->repository->salvarPorLocal('LV-30', 501, [
            'dt_saida_prevista_volta' => '2026-10-03 16:00:00',
            'dt_chegada_prevista_volta' => '2026-10-03 22:00:00',
        ]);

        $registro = $this->repository->buscarPorLocal('LV-30', 501);
        $this->assertSame('2026-10-03 16:00', $registro['dt_saida_prevista_volta']);
        $this->assertSame(1, DB::table('local_votacao_deslocamento')->count());

        $this->expectException(\InvalidArgumentException::class);
        $this->repository->salvarPorLocal('LV-31', 501, [
            'dt_chegada_prevista' => '2026-10-03 16:00:00',
            'dt_saida_prevista_volta' => '2026-10-03 15:59:00',
        ]);
    }

    public function test_payload_vazio_ausente_nao_gera_dml_e_turnos_ficam_isolados(): void
    {
        $this->repository->salvarPorLocal('LV-20', 501, []);
        $this->assertSame([], $this->auditRepository->eventos);

        $this->repository->salvarPorLocal('LV-20', 501, ['observacao_deslocamento' => 'Primeiro turno']);
        $this->repository->salvarPorLocal('LV-20', 502, ['observacao_deslocamento' => 'Segundo turno']);
        $this->repository->salvarPorLocal('LV-21', 501, ['observacao_deslocamento' => 'Outro local']);

        $this->assertSame('Primeiro turno', $this->repository->buscarPorLocal('LV-20', 501)['observacao_deslocamento']);
        $this->assertSame('Segundo turno', $this->repository->buscarPorLocal('LV-20', 502)['observacao_deslocamento']);
        $this->assertSame(
            ['LV-20', 'LV-21'],
            array_keys($this->repository->listarPorLocais(['LV-20', 'LV-21'], 501))
        );
    }
}
```
</TESTS_UNIT_LOCALVOTACAODESLOCAMENTOREPOSITORYTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/StoreDiariasSolicitacaoPernoiteRequestTest.php`
## <TESTS_UNIT_STOREDIARIASSOLICITACAOPERNOITEREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/StoreDiariasSolicitacaoPernoiteRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class StoreDiariasSolicitacaoPernoiteRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_exige_justificativa_com_pernoite_basico_em_trecho_no_limite_configurado(): void
public function test_exige_justificativa_quando_pernoite_esta_apenas_na_diaria_individual(): void
public function test_permite_pernoite_curto_quando_ha_justificativa(): void
public function test_nao_exige_justificativa_quando_algum_trecho_e_longo_ou_desconhecido(): void
public function test_limitrofe_e_curto_mesmo_sem_distancia(): void
public function test_configuracao_de_distancia_indisponivel_bloqueia_o_payload(): void
public function test_reaproveita_a_regra_para_pares_repetidos_na_mesma_validacao(): void
private function validatorPara(
private function validatorComDependencias(
private function dadosPernoite(string $pernoite): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Exceptions\Diarias\DiariasConfiguracaoException;
use App\Http\Requests\Diarias\StoreDiariasSolicitacaoRequest;
use App\Repositories\Diarias\Contracts\DiariasCidadeRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasParametrosCalculoProviderInterface;
use Illuminate\Support\Facades\Validator;
use Mockery;
use Tests\TestCase;

class StoreDiariasSolicitacaoPernoiteRequestTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();

        parent::tearDown();
    }

    public function test_exige_justificativa_com_pernoite_basico_em_trecho_no_limite_configurado(): void
    {
        $validator = $this->validatorPara(
            dados: $this->dadosPernoite('SIM'),
            regras: [[10, 20, 60.0, false]],
            limiteKm: 60.0,
        );

        $this->assertTrue($validator->fails());
        $this->assertSame(
            'Informe a justificativa para solicitar pernoite em deslocamento curto.',
            $validator->errors()->first('justificativa_pernoite'),
        );
    }

    public function test_exige_justificativa_quando_pernoite_esta_apenas_na_diaria_individual(): void
    {
        $dados = $this->dadosPernoite('NAO');
        $dados['adicionais'] = [[
            'beneficiario_cpf' => '12345678901',
            'data' => '2026-08-10',
            'pernoite' => 'SIM',
        ]];

        $validator = $this->validatorPara($dados, [[10, 20, 45.0, false]]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_pernoite'));
    }

    public function test_permite_pernoite_curto_quando_ha_justificativa(): void
    {
        $dados = $this->dadosPernoite('SIM');
        $dados['justificativa_pernoite'] = 'A agenda institucional exige permanência no destino.';

        $validator = $this->validatorPara($dados, [[10, 20, 45.0, false]]);

        $validator->fails();
        $this->assertFalse($validator->errors()->has('justificativa_pernoite'));
    }

    public function test_nao_exige_justificativa_quando_algum_trecho_e_longo_ou_desconhecido(): void
    {
        $dados = $this->dadosPernoite('SIM');
        $dados['trechos'][] = [
            'cidade_origem_id' => 20,
            'cidade_destino_id' => 30,
        ];

        $validatorLongo = $this->validatorPara($dados, [
            [10, 20, 45.0, false],
            [20, 30, 61.0, false],
        ]);
        $validatorDesconhecido = $this->validatorPara($dados, [
            [10, 20, 45.0, false],
            [20, 30, null, false],
        ]);

        $validatorLongo->fails();
        $validatorDesconhecido->fails();
        $this->assertFalse($validatorLongo->errors()->has('justificativa_pernoite'));
        $this->assertFalse($validatorDesconhecido->errors()->has('justificativa_pernoite'));
    }

    public function test_limitrofe_e_curto_mesmo_sem_distancia(): void
    {
        $validator = $this->validatorPara(
            $this->dadosPernoite('SIM'),
            [[10, 20, null, true]],
        );

        $validator->fails();
        $this->assertTrue($validator->errors()->has('justificativa_pernoite'));
    }

    public function test_configuracao_de_distancia_indisponivel_bloqueia_o_payload(): void
    {
        $cidades = Mockery::mock(DiariasCidadeRepositoryInterface::class);
        $parametros = Mockery::mock(DiariasParametrosCalculoProviderInterface::class);
        $parametros->shouldReceive('distanciaMinimaKm')
            ->once()
            ->andThrow(new DiariasConfiguracaoException('Parâmetro DISTANCIA_MINIMA_KM ausente ou inválido.'));

        $validator = $this->validatorComDependencias($this->dadosPernoite('SIM'), $cidades, $parametros);

        $validator->fails();
        $this->assertTrue($validator->errors()->has('trechos'));
        $this->assertSame(
            'Não foi possível validar a distância dos trechos. Tente novamente ou contate o suporte.',
            $validator->errors()->first('trechos'),
        );
    }

    public function test_reaproveita_a_regra_para_pares_repetidos_na_mesma_validacao(): void
    {
        $dados = $this->dadosPernoite('SIM');
        $dados['trechos'][] = [
            'cidade_origem_id' => 20,
            'cidade_destino_id' => 10,
        ];

        $validator = $this->validatorPara(
            $dados,
            [[10, 20, 45.0, false]],
            consultasEsperadas: 1,
        );

        $validator->fails();
        $this->assertTrue($validator->errors()->has('justificativa_pernoite'));
    }

    /**
     * @param  array<string, mixed>  $dados
     * @param  array<int, array{int, int, ?float, bool}>  $regras
     */
    private function validatorPara(
        array $dados,
        array $regras,
        float $limiteKm = 60.0,
        ?int $consultasEsperadas = null,
    ): \Illuminate\Validation\Validator {
        $cidades = Mockery::mock(DiariasCidadeRepositoryInterface::class);
        $parametros = Mockery::mock(DiariasParametrosCalculoProviderInterface::class);
        $parametros->shouldReceive('distanciaMinimaKm')->once()->andReturn($limiteKm);

        $mapa = [];
        foreach ($regras as [$origem, $destino, $distancia, $limitrofe]) {
            $mapa[min($origem, $destino).':'.max($origem, $destino)] = (object) [
                'distancia_km' => $distancia,
                'limitrofe' => $limitrofe ? 1 : 0,
            ];
        }

        $cidades->shouldReceive('regraTrecho')
            ->times($consultasEsperadas ?? count($mapa))
            ->andReturnUsing(static function (int $origem, int $destino) use ($mapa): ?object {
                return $mapa[min($origem, $destino).':'.max($origem, $destino)] ?? null;
            });

        return $this->validatorComDependencias($dados, $cidades, $parametros);
    }

    /** @param array<string, mixed> $dados */
    private function validatorComDependencias(
        array $dados,
        DiariasCidadeRepositoryInterface $cidades,
        DiariasParametrosCalculoProviderInterface $parametros,
    ): \Illuminate\Validation\Validator {
        $request = StoreDiariasSolicitacaoRequest::create('/diarias/solicitacoes', 'POST', $dados);
        $request->rules($cidades, $parametros);
        $validator = Validator::make($request->all(), []);
        $request->withValidator($validator);

        return $validator;
    }

    /** @return array<string, mixed> */
    private function dadosPernoite(string $pernoite): array
    {
        return [
            'adicionais_basico' => ['pernoite' => $pernoite],
            'justificativa_pernoite' => '',
            'trechos' => [[
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 20,
            ]],
        ];
    }
}
```
</TESTS_UNIT_STOREDIARIASSOLICITACAOPERNOITEREQUESTTEST_PHP>



---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/StoreDiariasSolicitacaoRequestTest.php`
## <TESTS_UNIT_STOREDIARIASSOLICITACAOREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/StoreDiariasSolicitacaoRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class StoreDiariasSolicitacaoRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_exige_justificativa_quando_primeira_partida_tem_menos_de_quinze_dias(): void
public function test_nao_exige_justificativa_quando_primeira_partida_tem_quinze_dias(): void
public function test_antecedencia_minima_usa_parametro_ativo_de_diarias(): void
public function test_mensagem_de_antecedencia_usa_parametro_normativo(): void
public function test_passagem_aerea_de_iniciativa_regional_exige_motivo_quando_partida_tem_menos_de_dez_dias(): void
public function test_regra_de_dez_dias_nao_bloqueia_trecho_nao_aereo_quando_antecedencia_geral_esta_atendida(): void
public function test_exige_justificativa_quando_afastamento_inicia_em_sexta_feira(): void
public function test_exige_justificativa_quando_periodo_contem_fim_de_semana(): void
public function test_permite_periodo_com_fim_de_semana_quando_ha_justificativa(): void
public function test_exige_justificativa_quando_periodo_contem_feriado_ativo(): void
public function test_nao_exige_justificativa_quando_periodo_nao_contem_sexta_fim_de_semana_ou_feriado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Diarias\StoreDiariasSolicitacaoRequest;
use App\Repositories\Diarias\Contracts\DiariasCidadeRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasParametrosCalculoProviderInterface;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Mockery;
use Tests\TestCase;

class StoreDiariasSolicitacaoRequestTest extends TestCase
{
    protected function tearDown(): void
    {
        CarbonImmutable::setTestNow();
        Mockery::close();

        parent::tearDown();
    }

    public function test_exige_justificativa_quando_primeira_partida_tem_menos_de_quinze_dias(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 6, 26, 8, 0, 0, config('app.timezone')));

        $validator = $this->validatorPara([
            'justificativa_10_dias' => '',
            'trechos' => [
                ['data_partida' => '2026-07-10'],
            ],
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_10_dias'));
    }

    public function test_nao_exige_justificativa_quando_primeira_partida_tem_quinze_dias(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 6, 26, 8, 0, 0, config('app.timezone')));

        $validator = $this->validatorPara([
            'justificativa_10_dias' => '',
            'trechos' => [
                ['data_partida' => '2026-07-11'],
            ],
        ]);

        $this->assertFalse($validator->fails());
    }

    public function test_antecedencia_minima_usa_parametro_ativo_de_diarias(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 6, 26, 8, 0, 0, config('app.timezone')));

        $validator = $this->validatorPara([
            'justificativa_10_dias' => '',
            'trechos' => [
                ['data_partida' => '2026-07-11'],
            ],
        ], antecedenciaMinimaDias: 20);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_10_dias'));
    }

    public function test_mensagem_de_antecedencia_usa_parametro_normativo(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 6, 26, 8, 0, 0, config('app.timezone')));

        $validator = $this->validatorPara([
            'justificativa_10_dias' => '',
            'trechos' => [
                ['data_partida' => '2026-07-11'],
            ],
        ], antecedenciaMinimaDias: 20);

        $this->assertTrue($validator->fails());
        $this->assertSame(
            'Informe o motivo da antecedência inferior ao mínimo normativo de 20 dias.',
            $validator->errors()->first('justificativa_10_dias')
        );
    }

    public function test_passagem_aerea_de_iniciativa_regional_exige_motivo_quando_partida_tem_menos_de_dez_dias(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 6, 29, 8, 0, 0, config('app.timezone')));

        $validator = $this->validatorPara([
            'justificativa_10_dias' => '',
            'trechos' => [[
                'data_partida' => '2026-07-07',
                'modal_codigo' => 'AEREO',
            ]],
        ], antecedenciaMinimaDias: 7);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_10_dias'));
        $this->assertSame(
            'Informe o motivo da antecedência inferior a 10 dias para passagem aérea de iniciativa do Regional.',
            $validator->errors()->first('justificativa_10_dias')
        );
    }

    public function test_regra_de_dez_dias_nao_bloqueia_trecho_nao_aereo_quando_antecedencia_geral_esta_atendida(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 6, 29, 8, 0, 0, config('app.timezone')));

        $validator = $this->validatorPara([
            'justificativa_10_dias' => '',
            'trechos' => [[
                'data_partida' => '2026-07-07',
                'modal_codigo' => 'TERRESTRE',
            ]],
        ], antecedenciaMinimaDias: 7);

        $this->assertFalse($validator->fails());
    }

    public function test_exige_justificativa_quando_afastamento_inicia_em_sexta_feira(): void
    {
        $validator = $this->validatorPara([
            'justificativa_fim_semana_feriado' => '',
            'trechos' => [[
                'data_partida' => '2026-08-07',
                'data_chegada' => '2026-08-07',
            ]],
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_fim_semana_feriado'));
    }

    public function test_exige_justificativa_quando_periodo_contem_fim_de_semana(): void
    {
        $validator = $this->validatorPara([
            'justificativa_fim_semana_feriado' => '',
            'trechos' => [[
                'data_partida' => '2026-08-06',
                'data_chegada' => '2026-08-10',
            ]],
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_fim_semana_feriado'));
    }

    public function test_permite_periodo_com_fim_de_semana_quando_ha_justificativa(): void
    {
        $validator = $this->validatorPara([
            'justificativa_10_dias' => 'Agenda institucional exige deslocamento com antecedência reduzida.',
            'justificativa_fim_semana_feriado' => 'Agenda institucional exige deslocamento no fim de semana.',
            'trechos' => [[
                'data_partida' => '2026-08-06',
                'data_chegada' => '2026-08-10',
            ]],
        ]);

        $this->assertFalse($validator->fails());
    }

    public function test_exige_justificativa_quando_periodo_contem_feriado_ativo(): void
    {
        $this->mockarFeriadoAtivo('2026-08-11', '2026-08-11', true);

        $validator = $this->validatorPara([
            'justificativa_fim_semana_feriado' => '',
            'trechos' => [[
                'data_partida' => '2026-08-11',
                'data_chegada' => '2026-08-11',
            ]],
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('justificativa_fim_semana_feriado'));
    }

    public function test_nao_exige_justificativa_quando_periodo_nao_contem_sexta_fim_de_semana_ou_feriado(): void
    {
        CarbonImmutable::setTestNow(CarbonImmutable::create(2026, 7, 27, 8, 0, 0, config('app.timezone')));

        $this->mockarFeriadoAtivo('2026-08-11', '2026-08-11', false);

        $validator = $this->validatorPara([
            'justificativa_fim_semana_feriado' => '',
            'trechos' => [[
                'data_partida' => '2026-08-11',
                'data_chegada' => '2026-08-11',
            ]],
        ]);

        $this->assertFalse($validator->fails());
    }

    public function test_bloqueia_trecho_limitrofe_sem_pernoite(): void
    {
        $validator = $this->validatorPara([
            'justificativa_fim_semana_feriado' => 'Atividade em fim de semana.',
            'trechos' => [[
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 20,
                'data_partida' => '2026-08-08',
                'data_chegada' => '2026-08-08',
            ]],
        ], regraTrecho: (object) ['distancia_km' => null, 'limitrofe' => 1]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('trechos.0.cidade_destino_id'));
    }

    public function test_permite_trecho_limitrofe_quando_ha_pernoite(): void
    {
        $validator = $this->validatorPara([
            'justificativa_10_dias' => 'Agenda institucional exige deslocamento com antecedência reduzida.',
            'justificativa_fim_semana_feriado' => 'Atividade em fim de semana.',
            'trechos' => [[
                'cidade_origem_id' => 10,
                'cidade_destino_id' => 20,
                'data_partida' => '2026-08-08',
                'data_chegada' => '2026-08-09',
            ]],
        ], regraTrecho: (object) ['distancia_km' => null, 'limitrofe' => 1]);

        $this->assertFalse($validator->fails());
    }

    /**
     * @param  array<string, mixed>  $dados
     */
    private function validatorPara(
        array $dados,
        int $antecedenciaMinimaDias = 15,
        ?object $regraTrecho = null,
    ): \Illuminate\Validation\Validator {
        $this->mockarParametroAntecedencia($antecedenciaMinimaDias);

        $request = StoreDiariasSolicitacaoRequest::create('/diarias/solicitacoes', 'POST', $dados);
        $cidades = Mockery::mock(DiariasCidadeRepositoryInterface::class);
        $parametros = Mockery::mock(DiariasParametrosCalculoProviderInterface::class);
        if ($regraTrecho !== null) {
            $cidades->shouldReceive('regraTrecho')->once()->with(10, 20)->andReturn($regraTrecho);
            $parametros->shouldReceive('distanciaMinimaKm')->once()->andReturn(60.0);
        }
        $request->rules($cidades, $parametros);
        $validator = Validator::make($request->all(), []);

        $request->withValidator($validator);

        return $validator;
    }

    private function mockarParametroAntecedencia(int $dias): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('whereRaw')
            ->once()
            ->with("UPPER(codigo) = 'ANTECEDENCIA_MINIMA_DIAS'")
            ->andReturnSelf();
        $builder->shouldReceive('where')
            ->once()
            ->with('ativo', 1)
            ->andReturnSelf();
        $builder->shouldReceive('value')
            ->once()
            ->with('valor')
            ->andReturn((string) $dias);

        DB::shouldReceive('table')
            ->once()
            ->with('diarias_parametro')
            ->andReturn($builder);
    }

    private function mockarFeriadoAtivo(string $inicio, string $fim, bool $existe): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('where')->once()->with('ativo', 1)->andReturnSelf();
        $builder->shouldReceive('whereRaw')
            ->once()
            ->with("TRUNC(data_feriado) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')", [$inicio, $fim])
            ->andReturnSelf();
        $builder->shouldReceive('exists')->once()->andReturn($existe);

        DB::shouldReceive('table')
            ->once()
            ->with('diarias_feriado')
            ->andReturn($builder);
    }
}
```
</TESTS_UNIT_STOREDIARIASSOLICITACAOREQUESTTEST_PHP>


