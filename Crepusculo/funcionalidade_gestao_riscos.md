# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_gestao_riscos`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 49  
> **Tamanho do Arquivo:** 381 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Console/Commands/Riscos/ImportarRiscosAnexo3683109Command.php`
## <APP_CONSOLE_COMMANDS_RISCOS_IMPORTARRISCOSANEXO3683109COMMAND_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Console/Commands/Riscos/ImportarRiscosAnexo3683109Command.php`
- **Namespace Declaração:** `App\Console\Commands\Riscos`
- **Entidade / Classe:** `class ImportarRiscosAnexo3683109Command extends Command`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$macroprojetoId = (int) DB::table('macroprojeto')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function handle(RiscoImportacaoService $service): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Console\Commands\Riscos;

use App\Services\Riscos\RiscoImportacaoService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Throwable;

class ImportarRiscosAnexo3683109Command extends Command
{
    protected $signature = 'riscos:importar-anexo-3683109
        {arquivo? : Caminho do .xlsx usado para criar a prévia}
        {--macroprojeto=Eleições 2026 : Nome exato do macroprojeto}
        {--lote= : ID de uma prévia persistida}
        {--aplicar : Aplica atomicamente o lote informado em --lote}';

    protected $description = 'Cria a prévia ou aplica um lote do Anexo 3683109 no ciclo de riscos.';

    public function handle(RiscoImportacaoService $service): int
    {
        $macroprojetoNome = trim((string) $this->option('macroprojeto'));
        $macroprojetoId = (int) DB::table('macroprojeto')
            ->whereRaw('UPPER(nome) = UPPER(?)', [$macroprojetoNome])
            ->value('id');
        if ($macroprojetoId <= 0) {
            $this->error("Macroprojeto não encontrado: {$macroprojetoNome}.");

            return self::FAILURE;
        }

        $usuario = 'CLI:'.(get_current_user() ?: 'planeleito');

        try {
            if ($this->option('aplicar')) {
                $loteId = (int) $this->option('lote');
                if ($loteId <= 0) {
                    $this->error('A aplicação exige uma prévia persistida informada em --lote.');

                    return self::FAILURE;
                }

                $resultado = $service->aplicar($loteId, $macroprojetoId, $usuario, null);
                $this->info(sprintf(
                    'Lote %d aplicado: %d risco(s).%s',
                    $resultado['lote_id'],
                    $resultado['aplicados'],
                    ($resultado['idempotente'] ?? false) ? ' Nenhum DML adicional foi necessário.' : ''
                ));

                return self::SUCCESS;
            }

            $arquivo = trim((string) $this->argument('arquivo'));
            if ($arquivo === '') {
                $this->error('Informe o arquivo .xlsx para criar a prévia.');

                return self::FAILURE;
            }

            $resultado = $service->previsualizar($arquivo, $macroprojetoId, $usuario, null);
            $this->table(
                ['Lote', 'Status', 'Itens', 'Erros', 'Avisos', 'Idempotente'],
                [[
                    $resultado['lote_id'],
                    $resultado['status'],
                    $resultado['total'],
                    $resultado['erros'],
                    $resultado['avisos'],
                    $resultado['idempotente'] ? 'Sim' : 'Não',
                ]]
            );

            if ($resultado['erros'] > 0) {
                $this->error('A prévia contém erros bloqueantes e não pode ser aplicada.');

                return self::FAILURE;
            }

            if ($resultado['status'] !== 'APLICADO') {
                $this->info('Prévia concluída. Revise o lote e aplique em outro comando com --lote e --aplicar.');
            }

            return self::SUCCESS;
        } catch (Throwable $e) {
            report($e);
            $this->error($e->getMessage());

            return self::FAILURE;
        }
    }
}
```
</APP_CONSOLE_COMMANDS_RISCOS_IMPORTARRISCOSANEXO3683109COMMAND_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Riscos/RiscoCicloController.php`
## <APP_HTTP_CONTROLLERS_RISCOS_RISCOCICLOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Riscos/RiscoCicloController.php`
- **Namespace Declaração:** `App\Http\Controllers\Riscos`
- **Entidade / Classe:** `class RiscoCicloController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function salvarControle(Request $request, int $risco)
public function arquivarControle(Request $request, int $risco, int $controle)
public function salvarTratamento(Request $request, int $risco)
public function arquivarTratamento(Request $request, int $risco, int $tratamento)
public function salvarContingencia(Request $request, int $risco)
public function arquivarContingencia(Request $request, int $risco, int $contingencia)
public function salvarMonitoramento(Request $request, int $risco)
public function salvarComunicacao(Request $request, int $risco)
private function salvarAcao(Request $request, int $risco, bool $tratamento)
private function executar(Request $request, callable $operacao)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Riscos;

use App\Http\Controllers\Controller;

use App\Repositories\Riscos\Contracts\RiscoCicloRepositoryInterface;
use App\Services\EscopoUnidadeService;
use Illuminate\Http\Request;

class RiscoCicloController extends Controller
{
    public function __construct(
        private readonly RiscoCicloRepositoryInterface $repository,
        private readonly EscopoUnidadeService $escopoService
    ) {}

    public function salvarControle(Request $request, int $risco)
    {
        $dados = $request->validate([
            'id' => ['nullable', 'integer', 'min:1'],
            'descricao' => ['required', 'string'],
            'classificacao_id' => ['nullable', 'integer', 'min:1'],
        ]);

        return $this->executar($request, fn (int $macro, ?array $unidades, string $usuario): int => $this->repository->salvarControle($risco, $dados, $macro, $unidades, $usuario)
        );
    }

    public function arquivarControle(Request $request, int $risco, int $controle)
    {
        return $this->executar($request, fn (int $macro, ?array $unidades, string $usuario): bool => $this->repository->arquivarControle($risco, $controle, $macro, $unidades, $usuario)
        );
    }

    public function salvarTratamento(Request $request, int $risco)
    {
        return $this->salvarAcao($request, $risco, true);
    }

    public function arquivarTratamento(Request $request, int $risco, int $tratamento)
    {
        return $this->executar($request, fn (int $macro, ?array $unidades, string $usuario): bool => $this->repository->arquivarTratamento($risco, $tratamento, $macro, $unidades, $usuario)
        );
    }

    public function salvarContingencia(Request $request, int $risco)
    {
        return $this->salvarAcao($request, $risco, false);
    }

    public function arquivarContingencia(Request $request, int $risco, int $contingencia)
    {
        return $this->executar($request, fn (int $macro, ?array $unidades, string $usuario): bool => $this->repository->arquivarContingencia($risco, $contingencia, $macro, $unidades, $usuario)
        );
    }

    public function salvarMonitoramento(Request $request, int $risco)
    {
        $dados = $request->validate([
            'data_monitoramento' => ['required', 'date_format:Y-m-d'],
            'status_risco_id' => ['nullable', 'integer', 'min:1'],
            'descricao' => ['required', 'string'],
            'resultado' => ['nullable', 'string'],
        ]);

        return $this->executar($request, fn (int $macro, ?array $unidades, string $usuario): int => $this->repository->registrarMonitoramento($risco, $dados, $macro, $unidades, $usuario)
        );
    }

    public function salvarComunicacao(Request $request, int $risco)
    {
        $dados = $request->validate([
            'data_comunicacao' => ['required', 'date_format:Y-m-d'],
            'tipo' => ['nullable', 'string', 'max:100'],
            'destinatarios' => ['nullable', 'string'],
            'descricao' => ['required', 'string'],
        ]);

        return $this->executar($request, fn (int $macro, ?array $unidades, string $usuario): int => $this->repository->registrarComunicacao($risco, $dados, $macro, $unidades, $usuario)
        );
    }

    private function salvarAcao(Request $request, int $risco, bool $tratamento)
    {
        $regras = [
            'id' => ['nullable', 'integer', 'min:1'],
            'status_id' => ['required', 'integer', 'min:1'],
            'descricao' => ['required', 'string'],
            'responsavel_ref' => ['sometimes', 'nullable', 'string', 'regex:/\A(?:UNIDADE|GRUPO):[1-9][0-9]*\z/'],
            'data_inicio' => ['nullable', 'date_format:Y-m-d'],
            'data_fim' => ['nullable', 'date_format:Y-m-d', 'after_or_equal:data_inicio'],
            'prazo_inicio_texto' => ['nullable', 'string', 'max:500'],
            'prazo_fim_texto' => ['nullable', 'string', 'max:500'],
            'tarefas_ids' => ['array'],
            'tarefas_ids.*' => ['integer', 'min:1'],
        ];
        $regras += $tratamento
            ? ['resposta_id' => ['nullable', 'integer', 'min:1']]
            : [
                'recursos_necessarios' => ['nullable', 'string'],
                'resultado_obtido' => ['nullable', 'string'],
                'observacoes' => ['nullable', 'string'],
            ];
        $dados = $request->validate($regras);
        $dados['responsavel_informado'] = $request->exists('responsavel_ref');
        $podeGerenciarGrupo = session('is_admin') === true;

        return $this->executar($request, function (int $macro, ?array $unidades, string $usuario) use (
            $risco,
            $dados,
            $tratamento,
            $podeGerenciarGrupo
        ): int {
            return $tratamento
                ? $this->repository->salvarTratamento(
                    $risco,
                    $dados,
                    $macro,
                    $unidades,
                    $usuario,
                    $podeGerenciarGrupo
                )
                : $this->repository->salvarContingencia(
                    $risco,
                    $dados,
                    $macro,
                    $unidades,
                    $usuario,
                    $podeGerenciarGrupo
                );
        });
    }

    private function executar(Request $request, callable $operacao)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $resultado = $operacao(
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            trim((string) session('user.username', 'SISTEMA')) ?: 'SISTEMA'
        );

        return response()->json(['mensagem' => 'Registro salvo com sucesso.', 'resultado' => $resultado]);
    }
}
```
</APP_HTTP_CONTROLLERS_RISCOS_RISCOCICLOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Riscos/RiscoContextoController.php`
## <APP_HTTP_CONTROLLERS_RISCOS_RISCOCONTEXTOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Riscos/RiscoContextoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Riscos`
- **Entidade / Classe:** `class RiscoContextoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index()
public function salvar(Request $request)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Riscos;

use App\Http\Controllers\Controller;

use App\Repositories\Riscos\Contracts\RiscoContextoRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use Illuminate\Http\Request;

class RiscoContextoController extends Controller
{
    public function __construct(
        private readonly RiscoContextoRepositoryInterface $repository,
        private readonly EscopoUnidadeService $escopoService
    ) {}

    public function index()
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $dados = $this->repository->buscar(
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual()
        );

        return view('planejamento.riscos.contexto', [
            'dados' => $dados,
            'podeEscrever' => app(PermissaoDominioService::class)->podeExecutar(
                'riscos.contexto.salvar',
                $macroprojetoId,
                (array) session('matchingGroups', [])
            ),
        ]);
    }

    public function salvar(Request $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $dados = $request->validate([
            'objeto' => ['nullable', 'string'],
            'area' => ['nullable', 'string'],
            'unidade' => ['nullable', 'string'],
            'principais_resultados' => ['nullable', 'string'],
            'macroprocesso' => ['nullable', 'string'],
            'objetivo' => ['nullable', 'string'],
            'leis_regulamentos' => ['nullable', 'string'],
            'recursos_tecnologicos' => ['nullable', 'string'],
            'swot' => ['array'],
            'swot.*.tipo_id' => ['required', 'integer', 'min:1'],
            'swot.*.ordem' => ['nullable', 'integer', 'min:0'],
            'swot.*.descricao' => ['nullable', 'string'],
        ]);
        $id = $this->repository->salvar(
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            $dados,
            trim((string) session('user.username', 'SISTEMA')) ?: 'SISTEMA'
        );

        return redirect()->route('riscos.contexto')->with('success', "Contexto {$id} salvo com sucesso.");
    }
}
```
</APP_HTTP_CONTROLLERS_RISCOS_RISCOCONTEXTOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Riscos/RiscoController.php`
## <APP_HTTP_CONTROLLERS_RISCOS_RISCOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Riscos/RiscoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Riscos`
- **Entidade / Classe:** `class RiscoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request)
public function listar(?Request $request = null)
public function detalhe(int $id)
public function form(?int $id = null)
public function salvar(RiscoRequest $request)
public function deletar(Request $request, int $id): JsonResponse|RedirectResponse
public function reativar(Request $request, int $id): JsonResponse|RedirectResponse
public function subprojetos(Request $request)
public function tarefas(Request $request)
public function exportarPdf(Request $request): Response
private function macroprojetoAtivoId(): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Riscos;

use App\Http\Controllers\Controller;
use App\Http\Requests\Riscos\RiscoRequest;
use App\Repositories\Riscos\Contracts\RiscoDominioRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use App\Services\Riscos\RiscoCalculoService;
use App\Support\Exportacao\CamposPdfSelecionados;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RiscoController extends Controller
{
    public const CAMPOS_PDF = [
        'codigo', 'titulo', 'projeto', 'unidade', 'probabilidade', 'impacto',
        'inerente', 'residual', 'resposta', 'status', 'pendencias',
    ];

    private EscopoUnidadeService $escopoService;

    private RiscoCalculoService $calculo;

    private RiscoDominioRepositoryInterface $dominioRepository;

    public function __construct(
        private readonly RiscoRepositoryInterface $repository,
        ?EscopoUnidadeService $escopoService = null,
        ?RiscoCalculoService $calculo = null,
        ?RiscoDominioRepositoryInterface $dominioRepository = null
    ) {
        $this->escopoService = $escopoService ?? app(EscopoUnidadeService::class);
        $this->calculo = $calculo ?? app(RiscoCalculoService::class);
        $this->dominioRepository = $dominioRepository ?? app(RiscoDominioRepositoryInterface::class);
    }

    public function index(Request $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $escopo = $this->escopoService->unidadesParaConsultaAtual();
        $filtros = $this->filtros($request);

        return view('planejamento.riscos.index', $this->permissoesListagem() + [
            'dominios' => $this->dominioRepository->listar(),
            'projetos' => $this->repository->listarProjetos($macroprojetoId, $escopo),
            'unidades' => $this->repository->listarUnidades($escopo),
            'riscos' => $this->repository->listarRiscos($macroprojetoId, $escopo, $filtros, 20),
            'podeImportar' => $this->podeExecutar('riscos.importacoes.index'),
            'filtros' => $filtros,
        ]);
    }

    public function listar(?Request $request = null)
    {
        $request ??= request();
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $riscos = $this->repository->listarRiscos(
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            $this->filtros($request),
            20
        );

        return view('planejamento.riscos.lista', $this->permissoesListagem() + [
            'riscos' => $riscos,
        ]);
    }

    public function detalhe(int $id)
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $escopo = $this->escopoService->unidadesParaConsultaAtual();
        $detalhe = $this->repository->buscarDetalhe(
            $id,
            $macroprojetoId,
            $escopo
        );
        abort_if($detalhe === null, 404);

        $acoes = collect([...$detalhe['tratamentos'], ...$detalhe['contingencias']]);
        $unidadesResponsaveisIds = $acoes->pluck('unidade_responsavel_id')
            ->filter()->map(static fn ($id): int => (int) $id)->unique()->values()->all();
        $gruposResponsaveisIds = $acoes->pluck('grupo_responsavel_id')
            ->filter()->map(static fn ($id): int => (int) $id)->unique()->values()->all();
        $podeGerenciarGrupo = session('is_admin') === true;

        return view('planejamento.riscos.detalhe', $detalhe + [
            'dominios' => $this->dominioRepository->listar(),
            'unidades' => $this->repository->listarUnidades($escopo, $unidadesResponsaveisIds),
            'gruposResponsaveis' => $this->repository->listarGruposResponsaveis(
                $podeGerenciarGrupo,
                $gruposResponsaveisIds
            ),
            'tarefasVinculaveis' => $this->formatarTarefas(
                $this->repository->listarTarefasVinculaveisAoRisco(
                    $id,
                    $macroprojetoId,
                    $escopo
                )
            ),
            'podeEscrever' => $this->podeExecutar('riscos.salvar') && (int) $detalhe['risco']->arquivado === 0,
            'podeGerenciarGrupo' => $podeGerenciarGrupo,
        ]);
    }

    public function form(?int $id = null)
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $escopo = $this->escopoService->unidadesParaConsultaAtual();
        $risco = null;
        $alvos = [];
        $impactos = ['unidades' => [], 'grupos' => []];
        if ($id) {
            $risco = $this->repository->buscarRisco($id, $macroprojetoId, $escopo);
            abort_if(! $risco, 404);
            abort_if((int) $risco->arquivado === 1, 409, 'Reative o risco antes de alterá-lo.');
            $alvos = $this->repository->buscarAlvos($id, $macroprojetoId, $escopo);
            $impactos = $this->repository->buscarImpactos($id, $macroprojetoId, $escopo);
        }

        $associacoes = [
            'projetos' => collect($alvos)->pluck('projeto_id')->filter()->map(static fn ($id): int => (int) $id)->unique()->values()->all(),
            'subprojetos' => collect($alvos)->pluck('subprojeto_id')->filter()->map(static fn ($id): int => (int) $id)->unique()->values()->all(),
            'tarefas_mitigacao' => collect($alvos)->filter(
                static fn ($alvo): bool => $alvo->tarefa_id !== null && $alvo->tipo !== 'CONTINGENCIA'
            )->pluck('tarefa_id')->map(static fn ($id): int => (int) $id)->unique()->values()->all(),
            'tarefas_contingencia' => collect($alvos)->filter(
                static fn ($alvo): bool => $alvo->tarefa_id !== null && $alvo->tipo === 'CONTINGENCIA'
            )->pluck('tarefa_id')->map(static fn ($id): int => (int) $id)->unique()->values()->all(),
        ];

        return view('planejamento.riscos.form', [
            'risco' => $risco,
            'dominios' => $this->dominioRepository->listar(),
            'projetos' => $this->repository->listarProjetos($macroprojetoId, $escopo),
            'unidades' => $this->repository->listarUnidades(
                $escopo,
                array_values(array_unique([...$impactos['unidades'], (int) ($risco->unidade_gestora_id ?? 0)]))
            ),
            'gruposUnidade' => $this->repository->listarGruposUnidade($escopo, $impactos['grupos']),
            'impactos' => $impactos,
            'associacoes' => $associacoes,
            'subprojetosSelecionados' => $this->formatarSubprojetos(
                $this->repository->buscarSubprojetosPorIds($associacoes['subprojetos'], $macroprojetoId, $escopo)
            ),
            'tarefasMitigacaoSelecionadas' => $this->formatarTarefas(
                $this->repository->buscarTarefasPorIds($associacoes['tarefas_mitigacao'], $macroprojetoId, $escopo)
            ),
            'tarefasContingenciaSelecionadas' => $this->formatarTarefas(
                $this->repository->buscarTarefasPorIds($associacoes['tarefas_contingencia'], $macroprojetoId, $escopo)
            ),
        ]);
    }

    public function salvar(RiscoRequest $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $escopo = $this->escopoService->unidadesParaConsultaAtual();
        $dados = $request->validated();
        $dominios = $this->dominioRepository->listar();

        $probabilidade = collect($dominios['probabilidades'])->firstWhere('id', $dados['PROBABILIDADE_ID']);
        $impacto = collect($dominios['impactos'])->firstWhere('id', $dados['IMPACTO_ID']);
        $status = collect($dominios['status_risco'])->firstWhere('id', $dados['STATUS_RISCO_ID']);
        $categoria = ! empty($dados['CATEGORIA_ID'])
            ? collect($dominios['categorias'])->firstWhere('id', $dados['CATEGORIA_ID'])
            : null;
        $resposta = ! empty($dados['RESPOSTA_ID'])
            ? collect($dominios['respostas'])->firstWhere('id', $dados['RESPOSTA_ID'])
            : null;
        $integridadeValida = empty($dados['RISCO_INTEGRIDADE_CODIGO']) || collect($dominios['opcoes_binarias'])
            ->contains(static fn (object $item): bool => $item->codigo === $dados['RISCO_INTEGRIDADE_CODIGO']);
        abort_if(
            ! $probabilidade || ! $impacto || ! $status
            || (! empty($dados['CATEGORIA_ID']) && ! $categoria)
            || (! empty($dados['RESPOSTA_ID']) && ! $resposta)
            || ! $integridadeValida,
            422,
            'Domínio de risco inválido.'
        );
        $inerente = $this->calculo->calcularInerente((int) $probabilidade->pontuacao, (int) $impacto->pontuacao);
        $nivel = collect($dominios['niveis'])->firstWhere('codigo', $inerente['nivel']);
        abort_if(! $nivel, 422, 'Nível de risco não configurado.');

        $projetos = $this->repository->buscarProjetosPorIds($dados['PROJETOS'], $macroprojetoId, $escopo);
        abort_if(count($projetos) !== count($dados['PROJETOS']), 422, 'Projeto fora do escopo efetivo.');
        $subprojetos = $this->repository->buscarSubprojetosPorIds($dados['SUBPROJETOS'], $macroprojetoId, $escopo);
        $tarefasMitigacao = $this->repository->buscarTarefasPorIds($dados['TAREFAS_MITIGACAO'], $macroprojetoId, $escopo);
        $tarefasContingencia = $this->repository->buscarTarefasPorIds($dados['TAREFAS_CONTINGENCIA'], $macroprojetoId, $escopo);
        abort_if(count($subprojetos) !== count($dados['SUBPROJETOS']), 422, 'Subprojeto fora do escopo efetivo.');
        abort_if(count($tarefasMitigacao) !== count($dados['TAREFAS_MITIGACAO']), 422, 'Tarefa de mitigação fora do escopo efetivo.');
        abort_if(count($tarefasContingencia) !== count($dados['TAREFAS_CONTINGENCIA']), 422, 'Tarefa de contingência fora do escopo efetivo.');

        $payload = $dados + [
            'PROBABILIDADE_CODIGO' => $probabilidade->codigo,
            'IMPACTO_CODIGO' => $impacto->codigo,
            'NIVEL_INERENTE_ID' => $nivel->id,
            'NIVEL_INERENTE_CODIGO' => $nivel->codigo,
            'VALOR_INERENTE' => $inerente['valor'],
            'STATUS_CODIGO' => $status->codigo,
        ];
        $id = $this->repository->salvarComposto(
            $payload,
            $this->montarAlvos($projetos, $subprojetos, $tarefasMitigacao, $tarefasContingencia),
            $macroprojetoId,
            $escopo,
            $this->usuario()
        );

        return response()->json(['mensagem' => 'Risco salvo com sucesso.', 'id' => $id]);
    }

    public function deletar(Request $request, int $id): JsonResponse|RedirectResponse
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $dados = $request->validate(['motivo' => ['required', 'string', 'max:1000']]);
        $ok = $this->repository->arquivar(
            $id,
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            $dados['motivo'],
            $this->usuario()
        );

        return $this->responderMutacao(
            $request,
            $ok,
            'Risco arquivado com sucesso.',
            'Risco não encontrado ou já arquivado.'
        );
    }

    public function reativar(Request $request, int $id): JsonResponse|RedirectResponse
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $ok = $this->repository->reativar(
            $id,
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            $this->usuario()
        );

        return $this->responderMutacao(
            $request,
            $ok,
            'Risco reativado com sucesso.',
            'Risco não encontrado ou já ativo.'
        );
    }

    public function subprojetos(Request $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $rows = $this->repository->buscarSubprojetosPorProjetos(
            $this->ids($request->input('projetos', [])),
            $this->ids($request->input('subprojetos', [])),
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual()
        );

        return response()->json(collect($this->formatarSubprojetos($rows))->map(
            static fn (array $item): array => ['id' => $item['id'], 'text' => $item['nome']]
        ));
    }

    public function tarefas(Request $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $rows = $this->repository->buscarTarefasPorSubprojetos(
            $this->ids($request->input('subprojetos', [])),
            $this->ids($request->input('tarefas', [])),
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual()
        );

        return response()->json(collect($this->formatarTarefas($rows))->map(
            static fn (array $item): array => ['id' => $item['id'], 'text' => $item['nome']]
        ));
    }

    public function exportarPdf(Request $request): Response
    {
        $macroprojetoId = $this->macroprojetoAtivoId();
        $this->autorizarRotaMacro($macroprojetoId);
        $campos = CamposPdfSelecionados::resolver(
            $request->input('campos', self::CAMPOS_PDF),
            self::CAMPOS_PDF,
            [],
        );
        abort_if($campos === [], 422, 'Selecione ao menos um campo para o PDF.');

        $riscos = $this->repository->listarParaExportacao(
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            $this->filtros($request)
        );

        return Pdf::loadView('planejamento.riscos.pdf', compact('riscos', 'campos'))
            ->setPaper('a4', 'landscape')
            ->download('riscos-'.now()->format('Ymd-His').'.pdf');
    }

    private function macroprojetoAtivoId(): int
    {
        return (int) session('macroprojeto_ativo_id', 0);
    }

    private function filtros(Request $request): array
    {
        $filtros = $request->only([
            'busca', 'projeto_id', 'unidade_id', 'nivel_inerente', 'nivel_residual',
            'resposta', 'status', 'pendencia', 'arquivado',
        ]);

        if (($filtros['status'] ?? '') === 'ARQUIVADO') {
            $filtros['arquivado'] = '1';
        }
        if (($filtros['arquivado'] ?? '0') === '1') {
            $filtros['status'] = '';
        }

        return $filtros;
    }

    private function podeExecutar(string $rota): bool
    {
        return app(PermissaoDominioService::class)->podeExecutar(
            $rota,
            $this->macroprojetoAtivoId(),
            (array) session('matchingGroups', [])
        );
    }

    /** @return array<string, bool> */
    private function permissoesListagem(): array
    {
        return [
            'podeEscrever' => $this->podeExecutar('riscos.salvar'),
            'podeArquivar' => $this->podeExecutar('riscos.deletar'),
            'podeReativar' => $this->podeExecutar('riscos.reativar'),
            'podeResolverPendencias' => $this->podeExecutar('riscos.pendencias.index')
                && $this->podeExecutar('riscos.pendencias.resolver'),
        ];
    }

    private function responderMutacao(
        Request $request,
        bool $ok,
        string $mensagemSucesso,
        string $mensagemErro
    ): JsonResponse|RedirectResponse {
        $mensagem = $ok ? $mensagemSucesso : $mensagemErro;

        if ($request->expectsJson() || $request->ajax()) {
            return response()->json(['mensagem' => $mensagem], $ok ? 200 : 404);
        }

        return redirect()->back()->with($ok ? 'success' : 'erro', $mensagem);
    }

    private function usuario(): string
    {
        return trim((string) session('user.username', session('username', 'SISTEMA'))) ?: 'SISTEMA';
    }

    private function ids(mixed $valores): array
    {
        return collect(is_array($valores) ? $valores : [$valores])
            ->map(static fn ($id): int => (int) $id)->filter()->unique()->values()->all();
    }

    private function formatarSubprojetos(array $rows): array
    {
        return collect($rows)->map(static fn (object $item): array => [
            'id' => (int) $item->id,
            'nome' => trim(($item->projeto ? $item->projeto.' – ' : '').$item->nome),
        ])->all();
    }

    private function formatarTarefas(array $rows): array
    {
        return collect($rows)->map(static fn (object $item): array => [
            'id' => (int) $item->id,
            'nome' => trim(($item->projeto ? $item->projeto.' » ' : '')
                .($item->subprojeto ? $item->subprojeto.' » ' : '').$item->nome),
        ])->all();
    }

    private function montarAlvos(array $projetos, array $subprojetos, array $tarefasMitigacao, array $tarefasContingencia): array
    {
        $alvos = [];
        foreach ($projetos as $item) {
            $alvos[] = ['projeto_id' => (int) $item->id, 'tipo' => 'MITIGACAO'];
        }
        foreach ($subprojetos as $item) {
            $alvos[] = ['subprojeto_id' => (int) $item->id, 'tipo' => 'MITIGACAO'];
        }
        foreach ($tarefasMitigacao as $item) {
            $alvos[] = ['tarefa_id' => (int) $item->id, 'tipo' => 'MITIGACAO'];
        }
        foreach ($tarefasContingencia as $item) {
            $alvos[] = ['tarefa_id' => (int) $item->id, 'tipo' => 'CONTINGENCIA'];
        }

        return $alvos;
    }
}
```
</APP_HTTP_CONTROLLERS_RISCOS_RISCOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Riscos/RiscoImportacaoController.php`
## <APP_HTTP_CONTROLLERS_RISCOS_RISCOIMPORTACAOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Riscos/RiscoImportacaoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Riscos`
- **Entidade / Classe:** `class RiscoImportacaoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request)
public function previa(Request $request)
public function aplicar(int $lote)
public function pendencias(RiscoPendenciaFiltroRequest $request)
public function resolver(Request $request, int $pendencia)
private function usuario(): string
private function decodificar(string $json): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Riscos;

use App\Http\Controllers\Controller;
use App\Http\Requests\Riscos\RiscoPendenciaFiltroRequest;
use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\Riscos\RiscoImportacaoService;
use Illuminate\Http\Request;

class RiscoImportacaoController extends Controller
{
    public function __construct(
        private readonly RiscoImportacaoRepositoryInterface $repository,
        private readonly RiscoImportacaoService $service,
        private readonly EscopoUnidadeService $escopoService
    ) {}

    public function index(Request $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $escopo = $this->escopoService->unidadesParaConsultaAtual();
        $usuario = $this->usuario();
        $lotes = $this->repository->listarLotes($macroprojetoId, $escopo, $usuario);
        $loteId = max(0, (int) $request->query('lote', 0));
        $loteSelecionado = collect($lotes)->first(
            static fn (object $lote): bool => (int) $lote->id === $loteId
        );
        $itens = [];
        $resumo = [];
        if ($loteSelecionado) {
            $resumo = $this->decodificar((string) $loteSelecionado->resumo);
            $itens = $this->repository->listarItensLote($loteId, $macroprojetoId, $escopo, $usuario);
            foreach ($itens as $item) {
                $item->mensagens_decodificadas = $this->decodificar((string) $item->mensagens);
            }
        }

        return view('planejamento.riscos.importacoes', [
            'lotes' => $lotes,
            'loteSelecionado' => $loteSelecionado,
            'itens' => $itens,
            'resumo' => $resumo,
        ]);
    }

    public function previa(Request $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $request->validate(['arquivo' => ['required', 'file', 'mimes:xlsx', 'max:20480']]);
        $resultado = $this->service->previsualizar(
            $request->file('arquivo')->getRealPath(),
            $macroprojetoId,
            $this->usuario(),
            $this->escopoService->unidadesParaConsultaAtual(),
            $request->file('arquivo')->getClientOriginalName()
        );

        return redirect()->route('riscos.importacoes.index', ['lote' => $resultado['lote_id']])->with('success', sprintf(
            'Prévia %d: %d itens, %d erros e %d avisos.',
            $resultado['lote_id'], $resultado['total'], $resultado['erros'], $resultado['avisos']
        ));
    }

    public function aplicar(int $lote)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $resultado = $this->service->aplicar(
            $lote,
            $macroprojetoId,
            $this->usuario(),
            $this->escopoService->unidadesParaConsultaAtual()
        );

        return redirect()->route('riscos.importacoes.index', ['lote' => $lote])->with('success', sprintf(
            'Lote %d aplicado: %d riscos.', $lote, $resultado['aplicados']
        ));
    }

    public function pendencias(RiscoPendenciaFiltroRequest $request)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $filtros = $request->validated();

        return view('planejamento.riscos.pendencias', [
            'pendencias' => $this->repository->listarPendencias(
                $macroprojetoId,
                $this->escopoService->unidadesParaConsultaAtual(),
                $filtros
            ),
            'filtros' => $filtros,
        ]);
    }

    public function resolver(Request $request, int $pendencia)
    {
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();
        $this->autorizarRotaMacro($macroprojetoId);
        $dados = $request->validate(['resolucao' => ['required', 'string']]);
        $ok = $this->repository->resolverPendencia(
            $pendencia,
            $macroprojetoId,
            $this->escopoService->unidadesParaConsultaAtual(),
            $dados['resolucao'],
            $this->usuario()
        );
        abort_if(! $ok, 404);

        return back()->with('success', 'Pendência resolvida com sucesso.');
    }

    private function usuario(): string
    {
        return trim((string) session('user.username', 'SISTEMA')) ?: 'SISTEMA';
    }

    /** @return array<string, mixed> */
    private function decodificar(string $json): array
    {
        if ($json === '') {
            return [];
        }

        $dados = json_decode($json, true);

        return is_array($dados) ? $dados : [];
    }
}
```
</APP_HTTP_CONTROLLERS_RISCOS_RISCOIMPORTACAOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Riscos/RiscoPendenciaFiltroRequest.php`
## <APP_HTTP_REQUESTS_RISCOS_RISCOPENDENCIAFILTROREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Riscos/RiscoPendenciaFiltroRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Riscos`
- **Entidade / Classe:** `class RiscoPendenciaFiltroRequest extends FormRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function authorize(): bool
public function rules(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Riscos;

use Illuminate\Foundation\Http\FormRequest;

class RiscoPendenciaFiltroRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, list<string>> */
    public function rules(): array
    {
        return [
            'risco_id' => ['nullable', 'integer', 'min:1'],
            'status' => ['nullable', 'string', 'in:ABERTA,RESOLVIDA'],
            'codigo' => ['nullable', 'string', 'max:100'],
        ];
    }
}
```
</APP_HTTP_REQUESTS_RISCOS_RISCOPENDENCIAFILTROREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Riscos/RiscoRequest.php`
## <APP_HTTP_REQUESTS_RISCOS_RISCOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Riscos/RiscoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Riscos`
- **Entidade / Classe:** `class RiscoRequest extends FormRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function authorize(): bool
public function rules(): array
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Riscos;

use Illuminate\Foundation\Http\FormRequest;

class RiscoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'ID' => ['nullable', 'integer', 'min:1'],
            'TITULO' => ['required', 'string', 'max:500'],
            'CAUSAS' => ['nullable', 'string'],
            'CONSEQUENCIAS' => ['nullable', 'string'],
            'AREA_IMPACTADA_ORIGINAL' => ['nullable', 'string', 'max:1000'],
            'PROBABILIDADE_ID' => ['required', 'integer', 'min:1'],
            'IMPACTO_ID' => ['required', 'integer', 'min:1'],
            'CATEGORIA_ID' => ['nullable', 'integer', 'min:1'],
            'RESPOSTA_ID' => ['nullable', 'integer', 'min:1'],
            'STATUS_RISCO_ID' => ['required', 'integer', 'min:1'],
            'RISCO_INTEGRIDADE_CODIGO' => ['nullable', 'string', 'max:20'],
            'UNIDADE_GESTORA_ID' => ['required', 'integer', 'min:1'],
            'UNIDADES_IMPACTADAS' => ['array'],
            'UNIDADES_IMPACTADAS.*' => ['integer', 'min:1'],
            'GRUPOS_IMPACTADOS' => ['array'],
            'GRUPOS_IMPACTADOS.*' => ['integer', 'min:1'],
            'PROJETOS' => ['required', 'array', 'min:1'],
            'PROJETOS.*' => ['integer', 'min:1'],
            'SUBPROJETOS' => ['array'],
            'SUBPROJETOS.*' => ['integer', 'min:1'],
            'TAREFAS_MITIGACAO' => ['array'],
            'TAREFAS_MITIGACAO.*' => ['integer', 'min:1'],
            'TAREFAS_CONTINGENCIA' => ['array'],
            'TAREFAS_CONTINGENCIA.*' => ['integer', 'min:1'],
        ];
    }

    protected function prepareForValidation(): void
    {
        foreach ([
            'ID', 'PROBABILIDADE_ID', 'IMPACTO_ID', 'CATEGORIA_ID',
            'RESPOSTA_ID', 'STATUS_RISCO_ID', 'UNIDADE_GESTORA_ID',
        ] as $campo) {
            $valor = $this->input($campo);
            $this->merge([$campo => $valor === null || $valor === '' ? null : (int) $valor]);
        }

        foreach ([
            'UNIDADES_IMPACTADAS', 'GRUPOS_IMPACTADOS', 'PROJETOS', 'SUBPROJETOS',
            'TAREFAS_MITIGACAO', 'TAREFAS_CONTINGENCIA',
        ] as $campo) {
            $valores = $this->input($campo, []);
            $valores = is_array($valores) ? $valores : [$valores];
            $this->merge([
                $campo => collect($valores)
                    ->filter(static fn ($valor): bool => $valor !== null && $valor !== '')
                    ->map('intval')
                    ->filter()
                    ->unique()
                    ->values()
                    ->all(),
            ]);
        }
    }
}
```
</APP_HTTP_REQUESTS_RISCOS_RISCOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/Contracts/RiscoCicloRepositoryInterface.php`
## <APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOCICLOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/Contracts/RiscoCicloRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Riscos\Contracts`
- **Entidade / Classe:** `interface RiscoCicloRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function salvarControle(int $riscoId, array $dados, int $macroprojetoId, ?array $unidades, string $usuario): int;
public function arquivarControle(int $riscoId, int $controleId, int $macroprojetoId, ?array $unidades, string $usuario): bool;
public function salvarTratamento(
public function arquivarTratamento(int $riscoId, int $tratamentoId, int $macroprojetoId, ?array $unidades, string $usuario): bool;
public function salvarContingencia(
public function arquivarContingencia(int $riscoId, int $contingenciaId, int $macroprojetoId, ?array $unidades, string $usuario): bool;
public function registrarMonitoramento(int $riscoId, array $dados, int $macroprojetoId, ?array $unidades, string $usuario): int;
public function registrarComunicacao(int $riscoId, array $dados, int $macroprojetoId, ?array $unidades, string $usuario): int;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos\Contracts;

interface RiscoCicloRepositoryInterface
{
    public function salvarControle(int $riscoId, array $dados, int $macroprojetoId, ?array $unidades, string $usuario): int;

    public function arquivarControle(int $riscoId, int $controleId, int $macroprojetoId, ?array $unidades, string $usuario): bool;

    public function salvarTratamento(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario,
        bool $podeGerenciarGrupo
    ): int;

    public function arquivarTratamento(int $riscoId, int $tratamentoId, int $macroprojetoId, ?array $unidades, string $usuario): bool;

    public function salvarContingencia(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario,
        bool $podeGerenciarGrupo
    ): int;

    public function arquivarContingencia(int $riscoId, int $contingenciaId, int $macroprojetoId, ?array $unidades, string $usuario): bool;

    public function registrarMonitoramento(int $riscoId, array $dados, int $macroprojetoId, ?array $unidades, string $usuario): int;

    public function registrarComunicacao(int $riscoId, array $dados, int $macroprojetoId, ?array $unidades, string $usuario): int;
}
```
</APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOCICLOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/Contracts/RiscoContextoRepositoryInterface.php`
## <APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOCONTEXTOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/Contracts/RiscoContextoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Riscos\Contracts`
- **Entidade / Classe:** `interface RiscoContextoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscar(int $macroprojetoId, ?array $unidadesPermitidas): ?array;
public function salvar(int $macroprojetoId, ?array $unidadesPermitidas, array $dados, string $usuario): int;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos\Contracts;

interface RiscoContextoRepositoryInterface
{
    public function buscar(int $macroprojetoId, ?array $unidadesPermitidas): ?array;

    public function salvar(int $macroprojetoId, ?array $unidadesPermitidas, array $dados, string $usuario): int;
}
```
</APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOCONTEXTOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/Contracts/RiscoDominioRepositoryInterface.php`
## <APP_REPOSITORIES_RISCOS_CONTRACTS_RISCODOMINIOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/Contracts/RiscoDominioRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Riscos\Contracts`
- **Entidade / Classe:** `interface RiscoDominioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos\Contracts;

interface RiscoDominioRepositoryInterface
{
    /** @return array<string, array<int, object>> */
    public function listar(): array;
}
```
</APP_REPOSITORIES_RISCOS_CONTRACTS_RISCODOMINIOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/Contracts/RiscoImportacaoRepositoryInterface.php`
## <APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOIMPORTACAOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/Contracts/RiscoImportacaoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Riscos\Contracts`
- **Entidade / Classe:** `interface RiscoImportacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarLotePorHash(int $macroprojetoId, string $hash): ?array;
public function carregarReferencias(int $macroprojetoId): array;
public function criarPrevia(
public function aplicar(
public function listarLotes(int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): array;
public function listarItensLote(
public function listarPendencias(
public function resolverPendencia(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos\Contracts;

interface RiscoImportacaoRepositoryInterface
{
    public function buscarLotePorHash(int $macroprojetoId, string $hash): ?array;

    /** @return array<string, mixed> */
    public function carregarReferencias(int $macroprojetoId): array;

    /**
     * @param  array<string, mixed>  $resumo
     * @param  array<int, array<string, mixed>>  $itens
     */
    public function criarPrevia(
        int $macroprojetoId,
        string $nomeArquivo,
        string $hash,
        array $resumo,
        array $itens,
        string $usuario
    ): int;

    /** @return array<string, mixed> */
    public function aplicar(
        int $loteId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): array;

    /** @return array<int, object> */
    public function listarLotes(int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): array;

    /** @return array<int, object> */
    public function listarItensLote(
        int $loteId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): array;

    /** @return array<int, object> */
    public function listarPendencias(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        array $filtros = []
    ): array;

    public function resolverPendencia(
        int $pendenciaId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $resolucao,
        string $usuario
    ): bool;
}
```
</APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOIMPORTACAOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/Contracts/RiscoRepositoryInterface.php`
## <APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/Contracts/RiscoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Riscos\Contracts`
- **Entidade / Classe:** `interface RiscoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarRiscos(
public function listarParaExportacao(
public function buscarRisco(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?object;
public function buscarDetalhe(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?array;
public function buscarAlvos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array;
public function listarProjetos(int $macroprojetoId, ?array $unidadesPermitidas): array;
public function buscarProjetosPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array;
public function listarUnidades(?array $unidadesPermitidas, array $incluirIds = []): array;
public function listarGruposUnidade(?array $unidadesPermitidas, array $incluirIds = []): array;
public function listarGruposResponsaveis(bool $podeAtribuirGrupo, array $incluirIds = []): array;
public function buscarImpactos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array;
public function buscarSubprojetosPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;

interface RiscoRepositoryInterface
{
    public function listarRiscos(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        array $filtros = [],
        int $porPagina = 20
    ): LengthAwarePaginator;

    public function listarParaExportacao(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        array $filtros = []
    ): Collection;

    public function buscarRisco(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?object;

    public function buscarDetalhe(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?array;

    public function buscarAlvos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array;

    public function listarProjetos(int $macroprojetoId, ?array $unidadesPermitidas): array;

    public function buscarProjetosPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array;

    public function listarUnidades(?array $unidadesPermitidas, array $incluirIds = []): array;

    public function listarGruposUnidade(?array $unidadesPermitidas, array $incluirIds = []): array;

    public function listarGruposResponsaveis(bool $podeAtribuirGrupo, array $incluirIds = []): array;

    /** @return array{unidades: array<int, int>, grupos: array<int, int>} */
    public function buscarImpactos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array;

    public function buscarSubprojetosPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array;

    public function buscarTarefasPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array;

    public function listarTarefasVinculaveisAoRisco(
        int $riscoId,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array;

    public function salvarComposto(
        array $dados,
        array $alvos,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): int;

    public function arquivar(
        int $id,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $motivo,
        string $usuario
    ): bool;

    public function reativar(int $id, int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): bool;

    public function buscarSubprojetosPorProjetos(
        array $projetos,
        array $subprojetos,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array;

    public function buscarTarefasPorSubprojetos(
        array $subprojetos,
        array $tarefas,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array;
}
```
</APP_REPOSITORIES_RISCOS_CONTRACTS_RISCOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/Queries/RiscoEscopoQuery.php`
## <APP_REPOSITORIES_RISCOS_QUERIES_RISCOESCOPOQUERY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/Queries/RiscoEscopoQuery.php`
- **Namespace Declaração:** `App\Repositories\Riscos\Queries`
- **Entidade / Classe:** `class RiscoEscopoQuery`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aplicar(Builder $query, ?array $unidadesPermitidas, string $aliasRisco = 'r'): void
private function adicionarAcoesResponsaveis(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos\Queries;

use Illuminate\Database\Query\Builder;

class RiscoEscopoQuery
{
    public function aplicar(Builder $query, ?array $unidadesPermitidas, string $aliasRisco = 'r'): void
    {
        if ($unidadesPermitidas === null) {
            return;
        }

        $unidades = array_values(array_unique(array_filter(
            array_map('intval', $unidadesPermitidas),
            static fn (int $id): bool => $id > 0
        )));
        if ($unidades === []) {
            $query->whereRaw('1 = 0');

            return;
        }

        $query->where(function (Builder $escopo) use ($unidades, $aliasRisco): void {
            $escopo->whereIn($aliasRisco.'.unidade_gestora_id', $unidades)
                ->orWhereExists(function (Builder $impactadas) use ($unidades, $aliasRisco): void {
                    $impactadas->selectRaw('1')
                        ->from('risco_unidade_impactada as rui')
                        ->whereColumn('rui.risco_id', $aliasRisco.'.id')
                        ->whereIn('rui.unidade_id', $unidades);
                });

            $this->adicionarAcoesResponsaveis($escopo, 'risco_tratamento', 'rt', $aliasRisco, $unidades);
            $this->adicionarAcoesResponsaveis($escopo, 'risco_contingencia', 'rc', $aliasRisco, $unidades);
        });
    }

    private function adicionarAcoesResponsaveis(
        Builder $escopo,
        string $tabela,
        string $aliasAcao,
        string $aliasRisco,
        array $unidades
    ): void {
        $escopo->orWhereExists(function (Builder $acoes) use (
            $tabela,
            $aliasAcao,
            $aliasRisco,
            $unidades
        ): void {
            $acoes->selectRaw('1')
                ->from($tabela.' as '.$aliasAcao)
                ->whereColumn($aliasAcao.'.risco_id', $aliasRisco.'.id')
                ->where($aliasAcao.'.ativo', 1)
                ->where(function (Builder $responsavel) use ($aliasAcao, $unidades): void {
                    $responsavel->whereIn($aliasAcao.'.unidade_responsavel_id', $unidades)
                        ->orWhereExists(function (Builder $membros) use ($aliasAcao, $unidades): void {
                            $membros->selectRaw('1')
                                ->from('grupo_unidade_membro as gum')
                                ->whereColumn('gum.grupo_id', $aliasAcao.'.grupo_responsavel_id')
                                ->whereIn('gum.unidade_id', $unidades);
                        });
                });
        });
    }
}
```
</APP_REPOSITORIES_RISCOS_QUERIES_RISCOESCOPOQUERY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/RiscoCicloRepository.php`
## <APP_REPOSITORIES_RISCOS_RISCOCICLOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/RiscoCicloRepository.php`
- **Namespace Declaração:** `App\Repositories\Riscos`
- **Entidade / Classe:** `class RiscoCicloRepository implements RiscoCicloRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$status = DB::table('risco_status')
$atual = DB::table(mb_strtolower($tabela))
$riscoInerente = (float) DB::table('risco')->where('id', $riscoId)->value('valor_inerente');
$controles = DB::table('risco_controle as rc')
$dados['NIVEL_RESIDUAL_ID'] = DB::table('risco_nivel')->where('codigo', $resultado['nivel'])->value('id');
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function salvarControle(
public function arquivarControle(
public function salvarTratamento(
public function arquivarTratamento(
public function salvarContingencia(
public function arquivarContingencia(
public function registrarMonitoramento(
public function registrarComunicacao(
private function salvarAcao(
private function arquivarAcao(
private function recalcularResidual(int $riscoId, string $usuario): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Riscos\Contracts\RiscoCicloRepositoryInterface;
use App\Repositories\Riscos\Queries\RiscoEscopoQuery;
use App\Services\Auditoria\AuditLogService;
use App\Services\Riscos\RiscoCalculoService;
use App\Services\Riscos\RiscoResponsavelService;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class RiscoCicloRepository implements RiscoCicloRepositoryInterface
{
    use AuditaDml;

    public function __construct(
        AuditLogService $auditLogService,
        private readonly RiscoCalculoService $calculo,
        private readonly RiscoEscopoQuery $escopoRisco,
        private readonly RiscoResponsavelService $responsavelService
    ) {
        $this->inicializarAuditoria($auditLogService);
    }

    public function salvarControle(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): int {
        return DB::transaction(function () use ($riscoId, $dados, $macroprojetoId, $unidades, $usuario): int {
            $this->autorizarRisco($riscoId, $macroprojetoId, $unidades);
            if (! empty($dados['classificacao_id'])
                && ! $this->dominioAtivo('risco_classificacao_controle', (int) $dados['classificacao_id'])) {
                throw new RuntimeException('Classificação de controle inválida.');
            }
            $id = (int) ($dados['id'] ?? 0);
            $registro = [
                'DESCRICAO' => $dados['descricao'],
                'CLASSIFICACAO_ID' => $dados['classificacao_id'] ?? null,
                'ATIVO' => 1,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ];
            if ($id > 0) {
                $this->autorizarFilho('risco_controle', $id, $riscoId);
                $this->atualizarAuditadoPorId('RISCO_CONTROLE', 'RISCO_CONTROLE', 'ID', $id, $registro);
            } else {
                $id = (int) $this->inserirAuditado('RISCO_CONTROLE', 'RISCO_CONTROLE', $registro + [
                    'RISCO_ID' => $riscoId,
                    'CODIGO_EXTERNO' => null,
                    'USUARIO_CRIACAO' => $usuario,
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ]);
            }
            $this->recalcularResidual($riscoId, $usuario);

            return $id;
        });
    }

    public function arquivarControle(
        int $riscoId,
        int $controleId,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): bool {
        return DB::transaction(function () use ($riscoId, $controleId, $macroprojetoId, $unidades, $usuario): bool {
            $this->autorizarRisco($riscoId, $macroprojetoId, $unidades);
            $this->autorizarFilho('risco_controle', $controleId, $riscoId);
            $this->atualizarAuditadoPorId('RISCO_CONTROLE', 'RISCO_CONTROLE', 'ID', $controleId, [
                'ATIVO' => 0,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);
            $this->recalcularResidual($riscoId, $usuario);

            return true;
        });
    }

    public function salvarTratamento(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario,
        bool $podeGerenciarGrupo
    ): int {
        return $this->salvarAcao(
            'RISCO_TRATAMENTO',
            $riscoId,
            $dados,
            $macroprojetoId,
            $unidades,
            $usuario,
            $podeGerenciarGrupo
        );
    }

    public function arquivarTratamento(
        int $riscoId,
        int $tratamentoId,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): bool {
        return $this->arquivarAcao('RISCO_TRATAMENTO', $riscoId, $tratamentoId, $macroprojetoId, $unidades, $usuario);
    }

    public function salvarContingencia(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario,
        bool $podeGerenciarGrupo
    ): int {
        return $this->salvarAcao(
            'RISCO_CONTINGENCIA',
            $riscoId,
            $dados,
            $macroprojetoId,
            $unidades,
            $usuario,
            $podeGerenciarGrupo
        );
    }

    public function arquivarContingencia(
        int $riscoId,
        int $contingenciaId,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): bool {
        return $this->arquivarAcao('RISCO_CONTINGENCIA', $riscoId, $contingenciaId, $macroprojetoId, $unidades, $usuario);
    }

    public function registrarMonitoramento(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): int {
        return DB::transaction(function () use ($riscoId, $dados, $macroprojetoId, $unidades, $usuario): int {
            $this->autorizarRisco($riscoId, $macroprojetoId, $unidades);
            $id = (int) $this->inserirAuditado('RISCO_MONITORAMENTO', 'RISCO_MONITORAMENTO', [
                'RISCO_ID' => $riscoId,
                'DATA_MONITORAMENTO' => Carbon::parse($dados['data_monitoramento'])->startOfDay(),
                'STATUS_RISCO_ID' => $dados['status_risco_id'] ?? null,
                'DESCRICAO' => $dados['descricao'],
                'RESULTADO' => $dados['resultado'] ?? null,
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
            if (! empty($dados['status_risco_id'])) {
                $status = DB::table('risco_status')
                    ->where('id', $dados['status_risco_id'])
                    ->where('ativo', 1)
                    ->where('codigo', '<>', 'ARQUIVADO')
                    ->first();
                if (! $status) {
                    throw new RuntimeException('Status de risco inválido.');
                }
                $this->atualizarAuditadoPorId('RISCO', 'RISCO', 'ID', $riscoId, [
                    'STATUS_RISCO_ID' => $status->id,
                    'STATUS' => $status->codigo,
                    'USUARIO_ATUALIZACAO' => $usuario,
                    'DATA_ATUALIZACAO' => DB::raw('SYSDATE'),
                ]);
            }

            return $id;
        });
    }

    public function registrarComunicacao(
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): int {
        return DB::transaction(function () use ($riscoId, $dados, $macroprojetoId, $unidades, $usuario): int {
            $this->autorizarRisco($riscoId, $macroprojetoId, $unidades);

            return (int) $this->inserirAuditado('RISCO_COMUNICACAO', 'RISCO_COMUNICACAO', [
                'RISCO_ID' => $riscoId,
                'DATA_COMUNICACAO' => Carbon::parse($dados['data_comunicacao'])->startOfDay(),
                'TIPO' => $dados['tipo'] ?? null,
                'DESTINATARIOS' => $dados['destinatarios'] ?? null,
                'DESCRICAO' => $dados['descricao'],
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        });
    }

    private function salvarAcao(
        string $tabela,
        int $riscoId,
        array $dados,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario,
        bool $podeGerenciarGrupo
    ): int {
        return DB::transaction(function () use (
            $tabela,
            $riscoId,
            $dados,
            $macroprojetoId,
            $unidades,
            $usuario,
            $podeGerenciarGrupo
        ): int {
            $this->autorizarRisco($riscoId, $macroprojetoId, $unidades);
            if (! $this->dominioAtivo('risco_acao_status', (int) $dados['status_id'])) {
                throw new RuntimeException('Status da ação inválido.');
            }
            if ($tabela === 'RISCO_TRATAMENTO' && ! empty($dados['resposta_id'])
                && ! $this->dominioAtivo('risco_resposta', (int) $dados['resposta_id'])) {
                throw new RuntimeException('Resposta ao risco inválida.');
            }
            $id = (int) ($dados['id'] ?? 0);
            $atual = null;
            if ($id > 0) {
                $this->autorizarFilho(mb_strtolower($tabela), $id, $riscoId);
                $atual = DB::table(mb_strtolower($tabela))
                    ->where('id', $id)
                    ->first(['unidade_responsavel_id', 'grupo_responsavel_id']);
            }
            $unidadeAtual = isset($atual->unidade_responsavel_id) ? (int) $atual->unidade_responsavel_id : null;
            $grupoAtual = isset($atual->grupo_responsavel_id) ? (int) $atual->grupo_responsavel_id : null;
            $responsavel = $this->responsavelService->normalizar(
                $dados['responsavel_ref'] ?? null,
                (bool) ($dados['responsavel_informado'] ?? false),
                $podeGerenciarGrupo,
                $unidadeAtual,
                $grupoAtual
            );
            $this->autorizarUnidadeOpcional(
                $responsavel['unidade_responsavel_id'],
                $unidades,
                $unidadeAtual
            );
            if ($responsavel['grupo_responsavel_id'] !== $grupoAtual) {
                $this->autorizarGrupoOpcional($responsavel['grupo_responsavel_id']);
            }
            $registro = [
                'STATUS_ID' => $dados['status_id'],
                'DESCRICAO' => $dados['descricao'],
                'UNIDADE_RESPONSAVEL_ID' => $responsavel['unidade_responsavel_id'],
                'GRUPO_RESPONSAVEL_ID' => $responsavel['grupo_responsavel_id'],
                'DATA_INICIO' => $this->data($dados['data_inicio'] ?? null),
                'DATA_FIM' => $this->data($dados['data_fim'] ?? null),
                'PRAZO_INICIO_TEXTO' => $dados['prazo_inicio_texto'] ?? null,
                'PRAZO_FIM_TEXTO' => $dados['prazo_fim_texto'] ?? null,
                'ATIVO' => 1,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ];
            if ($tabela === 'RISCO_TRATAMENTO') {
                $registro['RESPOSTA_ID'] = $dados['resposta_id'] ?? null;
            } else {
                $registro += [
                    'RECURSOS_NECESSARIOS' => $dados['recursos_necessarios'] ?? null,
                    'RESULTADO_OBTIDO' => $dados['resultado_obtido'] ?? null,
                    'OBSERVACOES' => $dados['observacoes'] ?? null,
                ];
            }

            if ($id > 0) {
                $this->atualizarAuditadoPorId($tabela, $tabela, 'ID', $id, $registro);
            } else {
                $novo = $registro + [
                    'RISCO_ID' => $riscoId,
                    'USUARIO_CRIACAO' => $usuario,
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ];
                if ($tabela === 'RISCO_TRATAMENTO') {
                    $novo['CODIGO_EXTERNO'] = null;
                }
                $id = (int) $this->inserirAuditado($tabela, $tabela, $novo);
            }

            $this->sincronizarTarefas($tabela, $id, $dados['tarefas_ids'] ?? [], $macroprojetoId, $unidades, $usuario);

            return $id;
        });
    }

    private function arquivarAcao(
        string $tabela,
        int $riscoId,
        int $id,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): bool {
        return DB::transaction(function () use ($tabela, $riscoId, $id, $macroprojetoId, $unidades, $usuario): bool {
            $this->autorizarRisco($riscoId, $macroprojetoId, $unidades);
            $this->autorizarFilho(mb_strtolower($tabela), $id, $riscoId);
            $this->atualizarAuditadoPorId($tabela, $tabela, 'ID', $id, [
                'ATIVO' => 0,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);

            return true;
        });
    }

    private function recalcularResidual(int $riscoId, string $usuario): void
    {
        $riscoInerente = (float) DB::table('risco')->where('id', $riscoId)->value('valor_inerente');
        $controles = DB::table('risco_controle as rc')
            ->leftJoin('risco_classificacao_controle as cc', 'cc.id', '=', 'rc.classificacao_id')
            ->where('rc.risco_id', $riscoId)
            ->where('rc.ativo', 1)
            ->pluck('cc.fator')
            ->map(static fn ($fator): ?float => $fator !== null ? (float) $fator : null)
            ->all();
        $resultado = $this->calculo->calcularResidual($riscoInerente, $controles);

        $dados = [
            'FATOR_CONTROLE_MEDIO' => $resultado['fator_medio'],
            'VALOR_RESIDUAL' => $resultado['valor'],
            'NIVEL_RESIDUAL_ID' => null,
            'APETITE_ID' => null,
            'USUARIO_ATUALIZACAO' => $usuario,
            'DATA_ATUALIZACAO' => DB::raw('SYSDATE'),
        ];
        if (! $resultado['pendente']) {
            $dados['NIVEL_RESIDUAL_ID'] = DB::table('risco_nivel')->where('codigo', $resultado['nivel'])->value('id');
            $dados['APETITE_ID'] = DB::table('risco_apetite')->where('codigo', $resultado['apetite'])->value('id');
        }
        $this->atualizarAuditadoPorId('RISCO', 'RISCO', 'ID', $riscoId, $dados);

        $pendencia = DB::table('risco_pendencia')
            ->where('risco_id', $riscoId)
            ->where('codigo', 'CONTROLE_SEM_CLASSIFICACAO')
            ->where('status', 'ABERTA')
            ->first();
        if ($resultado['pendente'] && ! $pendencia) {
            $this->inserirAuditado('RISCO_PENDENCIA', 'RISCO_PENDENCIA', [
                'RISCO_ID' => $riscoId,
                'CODIGO' => 'CONTROLE_SEM_CLASSIFICACAO',
                'DESCRICAO' => 'Classificação de controle ausente; risco residual indisponível.',
                'STATUS' => 'ABERTA',
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        } elseif (! $resultado['pendente'] && $pendencia) {
            $this->atualizarAuditadoPorId('RISCO_PENDENCIA', 'RISCO_PENDENCIA', 'ID', $pendencia->id, [
                'STATUS' => 'RESOLVIDA',
                'RESOLUCAO' => 'Resolvida automaticamente após classificação dos controles ativos.',
                'USUARIO_RESOLUCAO' => $usuario,
                'DT_RESOLUCAO' => DB::raw('SYSDATE'),
            ]);
        }
    }

    private function sincronizarTarefas(
        string $tabela,
        int $acaoId,
        array $tarefasIds,
        int $macroprojetoId,
        ?array $unidades,
        string $usuario
    ): void {
        $coluna = $tabela === 'RISCO_TRATAMENTO' ? 'TRATAMENTO_ID' : 'CONTINGENCIA_ID';
        $this->removerEscopoAuditado(
            'RISCO_ACAO_TAREFA',
            'RISCO_ACAO_TAREFA',
            $acaoId,
            static fn ($query) => $query->where($coluna, $acaoId),
            [$coluna => $acaoId]
        );

        foreach (array_values(array_unique(array_map('intval', $tarefasIds))) as $tarefaId) {
            $query = DB::table('tarefa as t')
                ->join('subprojeto as s', 's.id', '=', 't.subprojeto_id')
                ->join('projeto as p', 'p.id', '=', 's.projeto_id')
                ->where('t.id', $tarefaId)
                ->where('p.macroprojeto_id', $macroprojetoId);
            if ($unidades !== null) {
                $unidades === []
                    ? $query->whereRaw('1 = 0')
                    : $query->where(function (Builder $sub) use ($unidades): void {
                        $sub->whereIn('t.unidade_id', $unidades)
                            ->orWhereIn('s.unidade_id', $unidades)
                            ->orWhereIn('p.unidade_id', $unidades);
                    });
            }
            if (! $query->exists()) {
                throw new RuntimeException('Tarefa vinculada fora do macroprojeto ou escopo efetivo.');
            }
            $this->inserirAuditado('RISCO_ACAO_TAREFA', 'RISCO_ACAO_TAREFA', [
                $coluna => $acaoId,
                $coluna === 'TRATAMENTO_ID' ? 'CONTINGENCIA_ID' : 'TRATAMENTO_ID' => null,
                'TAREFA_ID' => $tarefaId,
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }
    }

    private function autorizarRisco(int $riscoId, int $macroprojetoId, ?array $unidades): void
    {
        $query = DB::table('risco as r')
            ->where('r.id', $riscoId)
            ->where('r.macroprojeto_id', $macroprojetoId)
            ->where('r.arquivado', 0);
        $this->escopoRisco->aplicar($query, $unidades);
        if (! $query->exists()) {
            throw new RuntimeException('Risco não encontrado no escopo efetivo.');
        }
    }

    private function autorizarFilho(string $tabela, int $id, int $riscoId): void
    {
        if (! DB::table($tabela)->where('id', $id)->where('risco_id', $riscoId)->exists()) {
            throw new RuntimeException('Registro filho não pertence ao risco informado.');
        }
    }

    private function data(?string $valor): ?Carbon
    {
        return $valor ? Carbon::createFromFormat('Y-m-d', $valor)->startOfDay() : null;
    }

    private function dominioAtivo(string $tabela, int $id): bool
    {
        return $id > 0 && DB::table($tabela)->where('id', $id)->where('ativo', 1)->exists();
    }

    private function autorizarUnidadeOpcional(
        mixed $unidadeId,
        ?array $unidades,
        ?int $unidadeAtual = null
    ): void {
        if ($unidadeId === null || $unidadeId === '') {
            return;
        }
        $id = (int) $unidadeId;
        if ($id <= 0
            || ! DB::table('vw_unidade')->where('id_unidade', $id)->exists()
            || ($id !== $unidadeAtual
                && $unidades !== null
                && ! in_array($id, array_map('intval', $unidades), true))) {
            throw new RuntimeException('Unidade responsável fora do escopo efetivo.');
        }
    }

    private function autorizarGrupoOpcional(?int $grupoId): void
    {
        if ($grupoId === null) {
            return;
        }

        $grupoValido = DB::table('grupo_unidade as gu')
            ->where('gu.id', $grupoId)
            ->whereExists(function (Builder $membros): void {
                $membros->selectRaw('1')
                    ->from('grupo_unidade_membro as gum')
                    ->whereColumn('gum.grupo_id', 'gu.id');
            })
            ->exists();
        if (! $grupoValido) {
            throw new RuntimeException('Grupo responsável inexistente ou sem membros.');
        }
    }
}
```
</APP_REPOSITORIES_RISCOS_RISCOCICLOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/RiscoContextoRepository.php`
## <APP_REPOSITORIES_RISCOS_RISCOCONTEXTOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/RiscoContextoRepository.php`
- **Namespace Declaração:** `App\Repositories\Riscos`
- **Entidade / Classe:** `class RiscoContextoRepository implements RiscoContextoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$tipos = DB::table('risco_swot_tipo')->where('ativo', 1)->orderBy('ordem')->get()->all();
$contexto = DB::table('risco_contexto')->where('macroprojeto_id', $macroprojetoId)->first();
'swot' => DB::table('risco_contexto_swot as rcs')
$contextoId = (int) DB::table('risco_contexto')->where('macroprojeto_id', $macroprojetoId)->value('id');
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function buscar(int $macroprojetoId, ?array $unidadesPermitidas): ?array
public function salvar(int $macroprojetoId, ?array $unidadesPermitidas, array $dados, string $usuario): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Riscos\Contracts\RiscoContextoRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class RiscoContextoRepository implements RiscoContextoRepositoryInterface
{
    use AuditaDml;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function buscar(int $macroprojetoId, ?array $unidadesPermitidas): ?array
    {
        $tipos = DB::table('risco_swot_tipo')->where('ativo', 1)->orderBy('ordem')->get()->all();
        if ($unidadesPermitidas === []) {
            return ['contexto' => null, 'swot' => [], 'tipos' => $tipos];
        }
        $contexto = DB::table('risco_contexto')->where('macroprojeto_id', $macroprojetoId)->first();
        if (! $contexto) {
            return ['contexto' => null, 'swot' => [], 'tipos' => $tipos];
        }

        return [
            'contexto' => $contexto,
            'swot' => DB::table('risco_contexto_swot as rcs')
                ->join('risco_swot_tipo as rst', 'rst.id', '=', 'rcs.tipo_id')
                ->where('rcs.contexto_id', $contexto->id)
                ->orderBy('rst.ordem')
                ->orderBy('rcs.ordem')
                ->get(['rcs.*', 'rst.codigo as tipo_codigo', 'rst.nome as tipo_nome'])
                ->all(),
            'tipos' => $tipos,
        ];
    }

    public function salvar(int $macroprojetoId, ?array $unidadesPermitidas, array $dados, string $usuario): int
    {
        if ($unidadesPermitidas === []) {
            throw new RuntimeException('O contexto não pode ser alterado sem unidade no escopo efetivo.');
        }

        return DB::transaction(function () use ($macroprojetoId, $dados, $usuario): int {
            $contextoId = (int) DB::table('risco_contexto')->where('macroprojeto_id', $macroprojetoId)->value('id');
            $registro = [
                'OBJETO' => $dados['objeto'] ?? null,
                'AREA' => $dados['area'] ?? null,
                'UNIDADE' => $dados['unidade'] ?? null,
                'PRINCIPAIS_RESULTADOS' => $dados['principais_resultados'] ?? null,
                'MACROPROCESSO' => $dados['macroprocesso'] ?? null,
                'OBJETIVO' => $dados['objetivo'] ?? null,
                'LEIS_REGULAMENTOS' => $dados['leis_regulamentos'] ?? null,
                'RECURSOS_TECNOLOGICOS' => $dados['recursos_tecnologicos'] ?? null,
            ];
            if ($contextoId > 0) {
                $this->atualizarAuditadoPorId('RISCO_CONTEXTO', 'RISCO_CONTEXTO', 'ID', $contextoId, $registro + [
                    'USUARIO_ATUALIZACAO' => $usuario,
                    'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
                ]);
                $this->removerEscopoAuditado(
                    'RISCO_CONTEXTO_SWOT',
                    'RISCO_CONTEXTO_SWOT',
                    $contextoId,
                    static fn ($query) => $query->where('CONTEXTO_ID', $contextoId),
                    ['contexto_id' => $contextoId]
                );
            } else {
                $contextoId = (int) $this->inserirAuditado('RISCO_CONTEXTO', 'RISCO_CONTEXTO', $registro + [
                    'MACROPROJETO_ID' => $macroprojetoId,
                    'USUARIO_CRIACAO' => $usuario,
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ]);
            }

            foreach ($dados['swot'] ?? [] as $item) {
                if (trim((string) ($item['descricao'] ?? '')) === '') {
                    continue;
                }
                $this->inserirAuditado('RISCO_CONTEXTO_SWOT', 'RISCO_CONTEXTO_SWOT', [
                    'CONTEXTO_ID' => $contextoId,
                    'TIPO_ID' => $item['tipo_id'],
                    'DESCRICAO' => $item['descricao'],
                    'ORDEM' => $item['ordem'] ?? 0,
                    'USUARIO_CRIACAO' => $usuario,
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ]);
            }

            return $contextoId;
        });
    }
}
```
</APP_REPOSITORIES_RISCOS_RISCOCONTEXTOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/RiscoDominioRepository.php`
## <APP_REPOSITORIES_RISCOS_RISCODOMINIOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/RiscoDominioRepository.php`
- **Namespace Declaração:** `App\Repositories\Riscos`
- **Entidade / Classe:** `class RiscoDominioRepository implements RiscoDominioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
'probabilidades' => DB::table('risco_probabilidade')->where('ativo', 1)->orderBy('ordem')->get()->all(),
'impactos' => DB::table('risco_impacto')->where('ativo', 1)->orderBy('ordem')->get()->all(),
'niveis' => DB::table('risco_nivel')->where('ativo', 1)->orderBy('ordem')->get()->all(),
'categorias' => DB::table('risco_categoria')->where('ativo', 1)->orderBy('ordem')->get()->all(),
'respostas' => DB::table('risco_resposta')->where('ativo', 1)->orderBy('ordem')->get()->all(),
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos;

use App\Repositories\Riscos\Contracts\RiscoDominioRepositoryInterface;
use Illuminate\Support\Facades\DB;

class RiscoDominioRepository implements RiscoDominioRepositoryInterface
{
    public function listar(): array
    {
        return [
            'probabilidades' => DB::table('risco_probabilidade')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'impactos' => DB::table('risco_impacto')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'niveis' => DB::table('risco_nivel')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'categorias' => DB::table('risco_categoria')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'respostas' => DB::table('risco_resposta')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'status_risco' => DB::table('risco_status')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'status_acao' => DB::table('risco_acao_status')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'classificacoes_controle' => DB::table('risco_classificacao_controle')->where('ativo', 1)->orderBy('ordem')->get()->all(),
            'opcoes_binarias' => DB::table('opcao_binaria')->orderBy('ordem')->get()->all(),
        ];
    }
}
```
</APP_REPOSITORIES_RISCOS_RISCODOMINIOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/RiscoImportacaoRepository.php`
## <APP_REPOSITORIES_RISCOS_RISCOIMPORTACAOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/RiscoImportacaoRepository.php`
- **Namespace Declaração:** `App\Repositories\Riscos`
- **Entidade / Classe:** `class RiscoImportacaoRepository implements RiscoImportacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$lote = DB::table('risco_importacao_lote')
$grupos = DB::table('grupo_unidade as g')
'unidades_ids' => DB::table('grupo_unidade_membro')
'projetos' => DB::table('projeto')
'classificacoes_controle' => DB::table('risco_classificacao_controle')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function buscarLotePorHash(int $macroprojetoId, string $hash): ?array
public function carregarReferencias(int $macroprojetoId): array
public function criarPrevia(
public function aplicar(
public function listarLotes(int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): array
public function listarItensLote(
private function consultaLotes(
public function listarPendencias(
public function resolverPendencia(
private function gravarContexto(int $macroprojetoId, array $contexto, string $usuario): void
private function gravarRisco(int $macroprojetoId, array $dados, string $usuario): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use App\Repositories\Riscos\Queries\RiscoEscopoQuery;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class RiscoImportacaoRepository implements RiscoImportacaoRepositoryInterface
{
    use AuditaDml;

    public function __construct(
        AuditLogService $auditLogService,
        private readonly RiscoEscopoQuery $escopoRisco
    ) {
        $this->inicializarAuditoria($auditLogService);
    }

    public function buscarLotePorHash(int $macroprojetoId, string $hash): ?array
    {
        $lote = DB::table('risco_importacao_lote')
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('hash_sha256', $hash)
            ->first();

        return $lote ? (array) $lote : null;
    }

    public function carregarReferencias(int $macroprojetoId): array
    {
        $grupos = DB::table('grupo_unidade as g')
            ->whereRaw('UPPER(g.nome) = ?', ['ZONAS'])
            ->get(['g.id', 'g.nome'])
            ->map(function (object $grupo): array {
                return [
                    'id' => (int) $grupo->id,
                    'nome' => $grupo->nome,
                    'unidades_ids' => DB::table('grupo_unidade_membro')
                        ->where('grupo_id', $grupo->id)
                        ->pluck('unidade_id')
                        ->map(static fn ($id): int => (int) $id)
                        ->all(),
                ];
            })
            ->all();

        return [
            'projetos' => DB::table('projeto')
                ->where('macroprojeto_id', $macroprojetoId)
                ->get(['id', 'nome', 'unidade_id'])
                ->map(static fn (object $item): array => (array) $item)
                ->all(),
            'probabilidades' => $this->dominioPor('risco_probabilidade', 'pontuacao'),
            'impactos' => $this->dominioPor('risco_impacto', 'pontuacao'),
            'niveis' => $this->dominioPor('risco_nivel', 'codigo'),
            'apetites' => $this->dominioPor('risco_apetite', 'codigo'),
            'categorias' => $this->dominioPor('risco_categoria', 'codigo'),
            'classificacoes_controle' => DB::table('risco_classificacao_controle')
                ->where('ativo', 1)
                ->get(['id', 'fator'])
                ->mapWithKeys(static fn (object $item): array => [
                    number_format((float) $item->fator, 6, '.', '') => (int) $item->id,
                ])
                ->all(),
            'respostas' => $this->dominioPor('risco_resposta', 'codigo'),
            'status_risco' => $this->dominioPor('risco_status', 'codigo'),
            'status_acao' => $this->dominioPor('risco_acao_status', 'codigo'),
            'tipos_swot' => $this->dominioPor('risco_swot_tipo', 'codigo'),
            'opcoes_binarias' => DB::table('opcao_binaria')->pluck('codigo', 'codigo')->all(),
            'unidades' => DB::table('vw_unidade')
                ->get(['id_unidade as id', 'sigla', 'descricao'])
                ->map(static fn (object $item): array => (array) $item)
                ->all(),
            'grupos' => $grupos,
            'codigos_existentes' => DB::table('risco')
                ->where('macroprojeto_id', $macroprojetoId)
                ->whereNotNull('codigo_externo')
                ->pluck('codigo_externo')
                ->all(),
        ];
    }

    public function criarPrevia(
        int $macroprojetoId,
        string $nomeArquivo,
        string $hash,
        array $resumo,
        array $itens,
        string $usuario
    ): int {
        return DB::transaction(function () use (
            $macroprojetoId,
            $nomeArquivo,
            $hash,
            $resumo,
            $itens,
            $usuario
        ): int {
            $loteId = (int) $this->inserirAuditado('RISCO_IMPORTACAO_LOTE', 'RISCO_IMPORTACAO_LOTE', [
                'MACROPROJETO_ID' => $macroprojetoId,
                'NOME_ARQUIVO' => $nomeArquivo,
                'HASH_SHA256' => $hash,
                'STATUS' => 'PREVIA',
                'TOTAL_ITENS' => count($itens),
                'TOTAL_ERROS' => array_sum(array_map(
                    static fn (array $item): int => count($item['mensagens']['erros']),
                    $itens
                )),
                'TOTAL_AVISOS' => array_sum(array_map(
                    static fn (array $item): int => count($item['mensagens']['pendencias']),
                    $itens
                )),
                'RESUMO' => $this->json($resumo),
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);

            foreach ($itens as $item) {
                $this->inserirAuditado('RISCO_IMPORTACAO_ITEM', 'RISCO_IMPORTACAO_ITEM', [
                    'LOTE_ID' => $loteId,
                    'CODIGO_EXTERNO' => $item['codigo_externo'],
                    'STATUS' => $item['status'],
                    'PAYLOAD_BRUTO' => $this->json($item['dados']),
                    'MENSAGENS' => $this->json($item['mensagens']),
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ]);
            }

            return $loteId;
        });
    }

    public function aplicar(
        int $loteId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): array {
        return DB::transaction(function () use ($loteId, $macroprojetoId, $unidadesPermitidas, $usuario): array {
            $lote = DB::table('risco_importacao_lote')
                ->where('id', $loteId)
                ->where('macroprojeto_id', $macroprojetoId)
                ->lockForUpdate()
                ->first();
            if (! $lote) {
                throw new RuntimeException('Lote de importação não encontrado no macroprojeto.');
            }
            if ($lote->status === 'APLICADO') {
                return ['lote_id' => $loteId, 'aplicados' => (int) $lote->total_itens, 'idempotente' => true];
            }
            if ((int) $lote->total_erros > 0) {
                throw new RuntimeException('O lote contém erros bloqueantes e não pode ser aplicado.');
            }

            $itens = DB::table('risco_importacao_item')
                ->where('lote_id', $loteId)
                ->orderBy('codigo_externo')
                ->lockForUpdate()
                ->get();
            if ($itens->count() !== (int) $lote->total_itens) {
                throw new RuntimeException('Quantidade de itens do lote diverge da prévia.');
            }

            foreach ($itens as $item) {
                $dados = $this->decodificar((string) $item->payload_bruto);
                $this->autorizarUnidade($dados['unidade_gestora_id'] ?? null, $unidadesPermitidas);
            }

            $this->atualizarAuditadoPorId('RISCO_IMPORTACAO_LOTE', 'RISCO_IMPORTACAO_LOTE', 'ID', $loteId, [
                'STATUS' => 'APLICANDO',
                'USUARIO_APLICACAO' => $usuario,
            ]);
            $resumo = $this->decodificar((string) $lote->resumo);
            $this->gravarContexto($macroprojetoId, $resumo['contexto'] ?? [], $usuario);

            $aplicados = 0;
            foreach ($itens as $item) {
                $dados = $this->decodificar((string) $item->payload_bruto);
                $riscoId = $this->gravarRisco($macroprojetoId, $dados, $usuario);
                $this->gravarFilhos($riscoId, $dados, $usuario, $loteId, (int) $item->id);

                $this->atualizarAuditadoPorId('RISCO_IMPORTACAO_ITEM', 'RISCO_IMPORTACAO_ITEM', 'ID', $item->id, [
                    'RISCO_ID' => $riscoId,
                    'STATUS' => 'APLICADO',
                    'DT_APLICACAO' => DB::raw('SYSDATE'),
                ]);
                $aplicados++;
            }

            $this->atualizarAuditadoPorId('RISCO_IMPORTACAO_LOTE', 'RISCO_IMPORTACAO_LOTE', 'ID', $loteId, [
                'STATUS' => 'APLICADO',
                'USUARIO_APLICACAO' => $usuario,
                'DT_APLICACAO' => DB::raw('SYSDATE'),
            ]);

            return ['lote_id' => $loteId, 'aplicados' => $aplicados, 'idempotente' => false];
        });
    }

    public function listarLotes(int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): array
    {
        return $this->consultaLotes($macroprojetoId, $unidadesPermitidas, $usuario)
            ->orderByDesc('ril.id')
            ->get('ril.*')
            ->all();
    }

    public function listarItensLote(
        int $loteId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): array {
        $lote = $this->consultaLotes($macroprojetoId, $unidadesPermitidas, $usuario)
            ->where('ril.id', $loteId)
            ->first('ril.*');
        if (! $lote) {
            return [];
        }

        $query = DB::table('risco_importacao_item as rii')
            ->where('rii.lote_id', $loteId)
            ->select('rii.*');

        if ($unidadesPermitidas !== null && $lote->status !== 'PREVIA') {
            if ($unidadesPermitidas === []) {
                $query->whereRaw('1 = 0');
            } else {
                $query->join('risco as r', 'r.id', '=', 'rii.risco_id')
                    ->where('r.macroprojeto_id', $macroprojetoId);
                $this->escopoRisco->aplicar($query, $unidadesPermitidas);
            }
        }

        return $query->orderBy('rii.codigo_externo')->get()->all();
    }

    private function consultaLotes(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): Builder {
        $query = DB::table('risco_importacao_lote as ril')
            ->where('ril.macroprojeto_id', $macroprojetoId);
        if ($unidadesPermitidas !== null) {
            if ($unidadesPermitidas === []) {
                $query->whereRaw('1 = 0');
            } else {
                $query->where(function (Builder $visivel) use ($unidadesPermitidas, $usuario): void {
                    $visivel->where(function (Builder $previaPropria) use ($usuario): void {
                        $previaPropria->where('ril.status', 'PREVIA')
                            ->where('ril.usuario_criacao', $usuario);
                    })
                        ->orWhereExists(function (Builder $item) use ($unidadesPermitidas): void {
                            $item->selectRaw('1')
                                ->from('risco_importacao_item as rii')
                                ->join('risco as r', 'r.id', '=', 'rii.risco_id')
                                ->whereColumn('rii.lote_id', 'ril.id');
                            $this->escopoRisco->aplicar($item, $unidadesPermitidas);
                        });
                });
            }
        }

        return $query;
    }

    public function listarPendencias(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        array $filtros = []
    ): array {
        $query = DB::table('risco_pendencia as rp')
            ->join('risco as r', 'r.id', '=', 'rp.risco_id')
            ->where('r.macroprojeto_id', $macroprojetoId)
            ->select('rp.*', 'r.codigo_externo', 'r.titulo');
        $this->escopoRisco->aplicar($query, $unidadesPermitidas);

        if (! empty($filtros['risco_id'])) {
            $query->where('rp.risco_id', (int) $filtros['risco_id']);
        }
        if (! empty($filtros['status'])) {
            $query->where('rp.status', $filtros['status']);
        }
        if (! empty($filtros['codigo'])) {
            $query->where('rp.codigo', $filtros['codigo']);
        }

        return $query->orderByDesc('rp.id')->get()->all();
    }

    public function resolverPendencia(
        int $pendenciaId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $resolucao,
        string $usuario
    ): bool {
        return DB::transaction(function () use (
            $pendenciaId,
            $macroprojetoId,
            $unidadesPermitidas,
            $resolucao,
            $usuario
        ): bool {
            $query = DB::table('risco_pendencia as rp')
                ->join('risco as r', 'r.id', '=', 'rp.risco_id')
                ->where('rp.id', $pendenciaId)
                ->where('r.macroprojeto_id', $macroprojetoId)
                ->where('rp.status', 'ABERTA')
                ->select('rp.id');
            $this->escopoRisco->aplicar($query, $unidadesPermitidas);
            if (! $query->lockForUpdate()->exists()) {
                return false;
            }

            $this->atualizarAuditadoPorId('RISCO_PENDENCIA', 'RISCO_PENDENCIA', 'ID', $pendenciaId, [
                'STATUS' => 'RESOLVIDA',
                'RESOLUCAO' => $resolucao,
                'USUARIO_RESOLUCAO' => $usuario,
                'DT_RESOLUCAO' => DB::raw('SYSDATE'),
            ]);

            return true;
        });
    }

    private function gravarContexto(int $macroprojetoId, array $contexto, string $usuario): void
    {
        $dados = [
            'OBJETO' => $contexto['objeto'] ?? null,
            'AREA' => $contexto['area'] ?? null,
            'UNIDADE' => $contexto['unidade'] ?? null,
            'PRINCIPAIS_RESULTADOS' => $contexto['principais_resultados'] ?? null,
            'MACROPROCESSO' => $contexto['macroprocesso'] ?? null,
            'OBJETIVO' => $contexto['objetivo'] ?? null,
            'LEIS_REGULAMENTOS' => $contexto['leis_regulamentos'] ?? null,
            'RECURSOS_TECNOLOGICOS' => $contexto['recursos_tecnologicos'] ?? null,
        ];
        $contextoId = (int) DB::table('risco_contexto')
            ->where('macroprojeto_id', $macroprojetoId)
            ->value('id');

        if ($contextoId > 0) {
            $this->atualizarAuditadoPorId('RISCO_CONTEXTO', 'RISCO_CONTEXTO', 'ID', $contextoId, $dados + [
                'USUARIO_ATUALIZACAO' => $usuario,
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);
            $this->removerEscopoAuditado(
                'RISCO_CONTEXTO_SWOT',
                'RISCO_CONTEXTO_SWOT',
                $contextoId,
                static fn ($query) => $query->where('CONTEXTO_ID', $contextoId),
                ['contexto_id' => $contextoId]
            );
        } else {
            $contextoId = (int) $this->inserirAuditado('RISCO_CONTEXTO', 'RISCO_CONTEXTO', $dados + [
                'MACROPROJETO_ID' => $macroprojetoId,
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }

        foreach ($contexto['swot'] ?? [] as $item) {
            $tipoId = (int) ($item['tipo_id'] ?? 0);
            if ($tipoId <= 0 && ! empty($item['tipo'])) {
                $tipoId = (int) DB::table('risco_swot_tipo')
                    ->where('codigo', $item['tipo'])
                    ->value('id');
            }
            if ($tipoId <= 0) {
                throw new RuntimeException('Tipo SWOT ausente ao aplicar o contexto.');
            }
            $this->inserirAuditado('RISCO_CONTEXTO_SWOT', 'RISCO_CONTEXTO_SWOT', [
                'CONTEXTO_ID' => $contextoId,
                'TIPO_ID' => $tipoId,
                'DESCRICAO' => $item['descricao'],
                'ORDEM' => $item['ordem'],
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }
    }

    private function gravarRisco(int $macroprojetoId, array $dados, string $usuario): int
    {
        if (DB::table('risco')->where('macroprojeto_id', $macroprojetoId)->where('codigo_externo', $dados['codigo'])->exists()) {
            throw new RuntimeException("Código {$dados['codigo']} já existe no macroprojeto.");
        }

        return (int) $this->inserirAuditado('RISCO', 'RISCO', [
            'TITULO' => $dados['titulo'],
            'DESCRICAO' => $dados['consequencias'],
            'PROBABILIDADE' => $dados['probabilidade_legacy'],
            'IMPACTO' => $dados['impacto_legacy'],
            'NIVEL' => $dados['nivel_inerente'],
            'STATUS' => 'ABERTO',
            'UNIDADE_ID' => $dados['unidade_gestora_id'],
            'DATA_REGISTRO' => DB::raw('SYSDATE'),
            'MACROPROJETO_ID' => $macroprojetoId,
            'CODIGO_EXTERNO' => $dados['codigo'],
            'ORIGEM' => 'IMPORTACAO',
            'CAUSAS' => $dados['causas'],
            'CONSEQUENCIAS' => $dados['consequencias'],
            'UNIDADE_GESTORA_ID' => $dados['unidade_gestora_id'],
            'AREA_IMPACTADA_ORIGINAL' => $dados['area_impactada_original'],
            'PROBABILIDADE_ID' => $dados['probabilidade_id'],
            'IMPACTO_ID' => $dados['impacto_id'],
            'NIVEL_INERENTE_ID' => $dados['nivel_inerente_id'],
            'NIVEL_RESIDUAL_ID' => $dados['nivel_residual_id'],
            'APETITE_ID' => $dados['apetite_id'],
            'CATEGORIA_ID' => $dados['categoria_id'],
            'RESPOSTA_ID' => $dados['resposta_id'],
            'STATUS_RISCO_ID' => $dados['status_risco_id'],
            'RISCO_INTEGRIDADE_CODIGO' => $dados['risco_integridade_codigo'],
            'VALOR_INERENTE' => $dados['valor_inerente'],
            'FATOR_CONTROLE_MEDIO' => $dados['fator_controle_medio'],
            'VALOR_RESIDUAL' => $dados['valor_residual'],
            'ARQUIVADO' => 0,
            'USUARIO_CRIACAO' => $usuario,
        ]);
    }

    private function gravarFilhos(
        int $riscoId,
        array $dados,
        string $usuario,
        int $loteId,
        int $itemId
    ): void {
        $this->inserirAuditado('RISCO_ALVO', 'RISCO_ALVO', [
            'RISCO_ID' => $riscoId,
            'PROJETO_ID' => $dados['projeto_id'],
            'SUBPROJETO_ID' => null,
            'TAREFA_ID' => null,
            'TIPO' => 'MITIGACAO',
        ]);

        foreach ($dados['unidades_impactadas_ids'] as $unidadeId) {
            $this->inserirAuditado('RISCO_UNIDADE_IMPACTADA', 'RISCO_UNIDADE_IMPACTADA', [
                'RISCO_ID' => $riscoId,
                'UNIDADE_ID' => $unidadeId,
                'ORIGEM' => 'IMPORTACAO',
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }
        foreach ($dados['grupos_impactados_ids'] as $grupoId) {
            $this->inserirAuditado('RISCO_GRUPO_IMPACTADO', 'RISCO_GRUPO_IMPACTADO', [
                'RISCO_ID' => $riscoId,
                'GRUPO_UNIDADE_ID' => $grupoId,
                'ORIGEM' => 'IMPORTACAO',
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }

        $controle = $dados['controle'];
        if (($controle['codigo'] ?? '') !== '' || ($controle['descricao'] ?? null) !== null) {
            $this->inserirAuditado('RISCO_CONTROLE', 'RISCO_CONTROLE', [
                'RISCO_ID' => $riscoId,
                'CODIGO_EXTERNO' => $controle['codigo'] ?: null,
                'DESCRICAO' => $controle['descricao'],
                'CLASSIFICACAO_ID' => $dados['classificacao_controle_id'],
                'ATIVO' => 1,
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }

        if (($dados['tratamento']['descricao'] ?? '') !== '') {
            $this->inserirAuditado('RISCO_TRATAMENTO', 'RISCO_TRATAMENTO', [
                'RISCO_ID' => $riscoId,
                'CODIGO_EXTERNO' => $dados['tratamento']['codigo'] ?: null,
                'RESPOSTA_ID' => $dados['resposta_id'],
                'STATUS_ID' => $dados['status_acao_id'],
                'DESCRICAO' => $dados['tratamento']['descricao'],
                'RESPONSAVEL_ORIGINAL' => $dados['tratamento']['responsavel_original'],
                'DATA_INICIO' => $this->data($dados['tratamento']['data_inicio']),
                'DATA_FIM' => $this->data($dados['tratamento']['data_fim']),
                'PRAZO_INICIO_TEXTO' => $dados['tratamento']['prazo_inicio_texto'],
                'PRAZO_FIM_TEXTO' => $dados['tratamento']['prazo_fim_texto'],
                'ATIVO' => 1,
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }

        if (($dados['contingencia']['descricao'] ?? '') !== '') {
            $this->inserirAuditado('RISCO_CONTINGENCIA', 'RISCO_CONTINGENCIA', [
                'RISCO_ID' => $riscoId,
                'STATUS_ID' => $dados['status_acao_id'],
                'DESCRICAO' => $dados['contingencia']['descricao'],
                'RESPONSAVEL_ORIGINAL' => $dados['contingencia']['responsavel_original'],
                'DATA_INICIO' => $this->data($dados['contingencia']['data_inicio']),
                'DATA_FIM' => $this->data($dados['contingencia']['data_fim']),
                'PRAZO_INICIO_TEXTO' => $dados['contingencia']['prazo_inicio_texto'],
                'PRAZO_FIM_TEXTO' => $dados['contingencia']['prazo_fim_texto'],
                'ATIVO' => 1,
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }

        foreach ($dados['pendencias'] as $codigo) {
            $this->inserirAuditado('RISCO_PENDENCIA', 'RISCO_PENDENCIA', [
                'LOTE_ID' => $loteId,
                'ITEM_ID' => $itemId,
                'RISCO_ID' => $riscoId,
                'CODIGO' => $codigo,
                'DESCRICAO' => $this->descricaoPendencia($codigo),
                'PAYLOAD_BRUTO' => $this->json([
                    'areas_nao_resolvidas' => $dados['areas_nao_resolvidas'] ?? [],
                    'tratamento' => $dados['tratamento'] ?? null,
                    'contingencia' => $dados['contingencia'] ?? null,
                ]),
                'STATUS' => 'ABERTA',
                'USUARIO_CRIACAO' => $usuario,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }
    }

    private function autorizarUnidade(mixed $unidadeId, ?array $unidadesPermitidas): void
    {
        if ($unidadesPermitidas !== null && ! in_array((int) $unidadeId, $unidadesPermitidas, true)) {
            throw new RuntimeException('O lote contém unidade gestora fora do escopo efetivo.');
        }
    }

    private function dominioPor(string $tabela, string $chave): array
    {
        return DB::table($tabela)
            ->where('ativo', 1)
            ->pluck('id', $chave)
            ->map(static fn ($id): int => (int) $id)
            ->all();
    }

    private function json(array $dados): string
    {
        return json_encode($dados, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR);
    }

    private function decodificar(string $json): array
    {
        return json_decode($json, true, 512, JSON_THROW_ON_ERROR);
    }

    private function data(?string $data): ?Carbon
    {
        return $data !== null ? Carbon::createFromFormat('Y-m-d', $data)->startOfDay() : null;
    }

    private function descricaoPendencia(string $codigo): string
    {
        return match ($codigo) {
            'CONTROLE_SEM_CLASSIFICACAO' => 'Classificação do controle ausente; risco residual indisponível.',
            'AREA_IMPACTADA_NAO_RESOLVIDA' => 'Área impactada original não pôde ser normalizada integralmente.',
            'CAUSAS_AUSENTES' => 'Causas não informadas na fonte.',
            'CONSEQUENCIAS_AUSENTES' => 'Consequências não informadas na fonte.',
            'CONTROLE_SEM_DESCRICAO' => 'Descrição do controle não informada na fonte.',
            'TRATAMENTO_SEM_DESCRICAO' => 'Ação de tratamento não informada na fonte.',
            'CONTINGENCIA_SEM_DESCRICAO' => 'Contingência não informada na fonte.',
            default => 'Dado importado requer revisão: '.$codigo.'.',
        };
    }
}
```
</APP_REPOSITORIES_RISCOS_RISCOIMPORTACAOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Riscos/RiscoRepository.php`
## <APP_REPOSITORIES_RISCOS_RISCOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Riscos/RiscoRepository.php`
- **Namespace Declaração:** `App\Repositories\Riscos`
- **Entidade / Classe:** `class RiscoRepository implements RiscoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('risco as r')
$tratamentos = DB::table('risco_tratamento as rt')
$contingencias = DB::table('risco_contingencia as rc')
'alvos' => DB::table('risco_alvo as ra')
'unidades_impactadas' => DB::table('risco_unidade_impactada as rui')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function listarRiscos(
public function listarParaExportacao(
public function buscarRisco(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?object
public function buscarDetalhe(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?array
public function buscarAlvos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array
public function listarProjetos(int $macroprojetoId, ?array $unidadesPermitidas): array
public function buscarProjetosPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array
public function listarUnidades(?array $unidadesPermitidas, array $incluirIds = []): array
public function listarGruposUnidade(?array $unidadesPermitidas, array $incluirIds = []): array
public function listarGruposResponsaveis(bool $podeAtribuirGrupo, array $incluirIds = []): array
public function buscarImpactos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Riscos;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use App\Repositories\Riscos\Queries\RiscoEscopoQuery;
use App\Services\Auditoria\AuditLogService;
use App\Support\Riscos\CodigoRiscoManual;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class RiscoRepository implements RiscoRepositoryInterface
{
    use AuditaDml;

    public function __construct(
        AuditLogService $auditLogService,
        private readonly RiscoEscopoQuery $escopoRisco
    ) {
        $this->inicializarAuditoria($auditLogService);
    }

    public function listarRiscos(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        array $filtros = [],
        int $porPagina = 20
    ): LengthAwarePaginator {
        return $this->consultaListagem($macroprojetoId, $unidadesPermitidas, $filtros)
            ->orderByDesc('r.id')
            ->paginate($porPagina)
            ->withQueryString();
    }

    public function listarParaExportacao(
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        array $filtros = []
    ): Collection {
        return $this->consultaListagem($macroprojetoId, $unidadesPermitidas, $filtros)
            ->orderBy('r.codigo_externo')
            ->orderBy('r.titulo')
            ->get();
    }

    public function buscarRisco(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?object
    {
        if ($id <= 0 || $macroprojetoId <= 0) {
            return null;
        }

        $query = DB::table('risco as r')
            ->leftJoin('vw_unidade as u', 'u.id_unidade', '=', 'r.unidade_gestora_id')
            ->leftJoin('risco_probabilidade as prob', 'prob.id', '=', 'r.probabilidade_id')
            ->leftJoin('risco_impacto as imp', 'imp.id', '=', 'r.impacto_id')
            ->leftJoin('risco_nivel as ni', 'ni.id', '=', 'r.nivel_inerente_id')
            ->leftJoin('risco_nivel as nr', 'nr.id', '=', 'r.nivel_residual_id')
            ->leftJoin('risco_apetite as ap', 'ap.id', '=', 'r.apetite_id')
            ->leftJoin('risco_categoria as cat', 'cat.id', '=', 'r.categoria_id')
            ->leftJoin('risco_resposta as resp', 'resp.id', '=', 'r.resposta_id')
            ->leftJoin('risco_status as rs', 'rs.id', '=', 'r.status_risco_id')
            ->where('r.id', $id)
            ->where('r.macroprojeto_id', $macroprojetoId)
            ->selectRaw(<<<'SQL'
r.*,
u.sigla AS unidade_sigla,
u.descricao AS unidade_nome,
prob.codigo AS probabilidade_codigo,
prob.nome AS probabilidade_nome,
prob.pontuacao AS probabilidade_pontos,
imp.codigo AS impacto_codigo,
imp.nome AS impacto_nome,
imp.pontuacao AS impacto_pontos,
ni.codigo AS nivel_inerente_codigo,
ni.nome AS nivel_inerente_nome,
ni.cor AS nivel_inerente_cor,
nr.codigo AS nivel_residual_codigo,
nr.nome AS nivel_residual_nome,
nr.cor AS nivel_residual_cor,
ap.codigo AS apetite_codigo,
ap.nome AS apetite_nome,
cat.nome AS categoria_nome,
resp.nome AS resposta_nome,
rs.codigo AS status_codigo,
rs.nome AS status_nome
SQL);
        $this->escopoRisco->aplicar($query, $unidadesPermitidas);

        return $query->first();
    }

    public function buscarDetalhe(int $id, int $macroprojetoId, ?array $unidadesPermitidas): ?array
    {
        $risco = $this->buscarRisco($id, $macroprojetoId, $unidadesPermitidas);
        if (! $risco) {
            return null;
        }

        $tratamentos = DB::table('risco_tratamento as rt')
            ->leftJoin('risco_resposta as rr', 'rr.id', '=', 'rt.resposta_id')
            ->leftJoin('risco_acao_status as ras', 'ras.id', '=', 'rt.status_id')
            ->leftJoin('vw_unidade as ur', 'ur.id_unidade', '=', 'rt.unidade_responsavel_id')
            ->leftJoin('grupo_unidade as gur', 'gur.id', '=', 'rt.grupo_responsavel_id')
            ->where('rt.risco_id', $id)
            ->orderByDesc('rt.ativo')
            ->orderBy('rt.id')
            ->select('rt.*', 'rr.nome as resposta_nome', 'ras.nome as status_nome', 'gur.nome as grupo_responsavel_nome')
            ->selectRaw("ur.sigla || ' - ' || ur.descricao AS unidade_responsavel_nome")
            ->get()
            ->all();
        $contingencias = DB::table('risco_contingencia as rc')
            ->leftJoin('risco_acao_status as ras', 'ras.id', '=', 'rc.status_id')
            ->leftJoin('vw_unidade as ur', 'ur.id_unidade', '=', 'rc.unidade_responsavel_id')
            ->leftJoin('grupo_unidade as gur', 'gur.id', '=', 'rc.grupo_responsavel_id')
            ->where('rc.risco_id', $id)
            ->orderByDesc('rc.ativo')
            ->orderBy('rc.id')
            ->select('rc.*', 'ras.nome as status_nome', 'gur.nome as grupo_responsavel_nome')
            ->selectRaw("ur.sigla || ' - ' || ur.descricao AS unidade_responsavel_nome")
            ->get()
            ->all();
        $this->anexarTarefasAcoes($tratamentos, 'tratamento_id');
        $this->anexarTarefasAcoes($contingencias, 'contingencia_id');

        return [
            'risco' => $risco,
            'alvos' => DB::table('risco_alvo as ra')
                ->leftJoin('projeto as p', 'p.id', '=', 'ra.projeto_id')
                ->leftJoin('subprojeto as s', 's.id', '=', 'ra.subprojeto_id')
                ->leftJoin('tarefa as t', 't.id', '=', 'ra.tarefa_id')
                ->where('ra.risco_id', $id)
                ->get(['ra.*', 'p.nome as projeto_nome', 's.nome as subprojeto_nome', 't.nome as tarefa_nome'])
                ->all(),
            'unidades_impactadas' => DB::table('risco_unidade_impactada as rui')
                ->leftJoin('vw_unidade as u', 'u.id_unidade', '=', 'rui.unidade_id')
                ->where('rui.risco_id', $id)
                ->orderBy('u.sigla')
                ->get(['rui.*', 'u.sigla', 'u.descricao'])
                ->all(),
            'grupos_impactados' => DB::table('risco_grupo_impactado as rgi')
                ->join('grupo_unidade as gu', 'gu.id', '=', 'rgi.grupo_unidade_id')
                ->where('rgi.risco_id', $id)
                ->get(['rgi.*', 'gu.nome'])
                ->all(),
            'controles' => DB::table('risco_controle as rc')
                ->leftJoin('risco_classificacao_controle as cc', 'cc.id', '=', 'rc.classificacao_id')
                ->where('rc.risco_id', $id)
                ->orderByDesc('rc.ativo')
                ->orderBy('rc.id')
                ->get(['rc.*', 'cc.codigo as classificacao_codigo', 'cc.nome as classificacao_nome', 'cc.fator'])
                ->all(),
            'tratamentos' => $tratamentos,
            'contingencias' => $contingencias,
            'monitoramentos' => DB::table('risco_monitoramento as rm')
                ->leftJoin('risco_status as rs', 'rs.id', '=', 'rm.status_risco_id')
                ->where('rm.risco_id', $id)
                ->orderByDesc('rm.data_monitoramento')
                ->orderByDesc('rm.id')
                ->get(['rm.*', 'rs.nome as status_nome'])
                ->all(),
            'comunicacoes' => DB::table('risco_comunicacao')
                ->where('risco_id', $id)
                ->orderByDesc('data_comunicacao')
                ->orderByDesc('id')
                ->get()
                ->all(),
            'pendencias' => DB::table('risco_pendencia')
                ->where('risco_id', $id)
                ->orderByRaw("CASE status WHEN 'ABERTA' THEN 0 ELSE 1 END")
                ->orderByDesc('id')
                ->get()
                ->all(),
        ];
    }

    public function buscarAlvos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array
    {
        if (! $this->buscarRisco($riscoId, $macroprojetoId, $unidadesPermitidas)) {
            return [];
        }

        return DB::table('risco_alvo')->where('risco_id', $riscoId)->get()->all();
    }

    public function listarProjetos(int $macroprojetoId, ?array $unidadesPermitidas): array
    {
        $query = DB::table('projeto as p')
            ->where('p.macroprojeto_id', $macroprojetoId)
            ->select('p.id', 'p.nome', 'p.unidade_id');
        $this->aplicarEscopoProjeto($query, $unidadesPermitidas);

        return $query->orderBy('p.nome')->get()->all();
    }

    public function buscarProjetosPorIds(array $ids, int $macroprojetoId, ?array $unidadesPermitidas): array
    {
        if ($ids === []) {
            return [];
        }
        $query = DB::table('projeto as p')
            ->where('p.macroprojeto_id', $macroprojetoId)
            ->whereIn('p.id', $this->ids($ids))
            ->select('p.id', 'p.nome', 'p.unidade_id');
        $this->aplicarEscopoProjeto($query, $unidadesPermitidas);

        return $query->orderBy('p.nome')->get()->all();
    }

    public function listarUnidades(?array $unidadesPermitidas, array $incluirIds = []): array
    {
        $query = DB::table('vw_unidade')->selectRaw("id_unidade AS id, sigla || ' - ' || descricao AS nome");
        if ($unidadesPermitidas !== null) {
            $idsVisiveis = array_values(array_unique([
                ...$this->ids($unidadesPermitidas),
                ...$this->ids($incluirIds),
            ]));
            $idsVisiveis === []
                ? $query->whereRaw('1 = 0')
                : $query->whereIn('id_unidade', $idsVisiveis);
        }

        return $query->orderBy('sigla')->get()->all();
    }

    public function listarGruposUnidade(?array $unidadesPermitidas, array $incluirIds = []): array
    {
        $grupos = DB::table('grupo_unidade')->orderBy('nome')->get(['id', 'nome'])->all();
        if ($unidadesPermitidas === null) {
            return $grupos;
        }

        $permitidas = $this->ids($unidadesPermitidas);
        $incluidos = $this->ids($incluirIds);

        return collect($grupos)->filter(function (object $grupo) use ($permitidas, $incluidos): bool {
            if (in_array((int) $grupo->id, $incluidos, true)) {
                return true;
            }
            $membros = DB::table('grupo_unidade_membro')
                ->where('grupo_id', $grupo->id)
                ->pluck('unidade_id')
                ->map(static fn ($id): int => (int) $id)
                ->unique()
                ->values()
                ->all();

            return $membros !== [] && array_diff($membros, $permitidas) === [];
        })->values()->all();
    }

    public function listarGruposResponsaveis(bool $podeAtribuirGrupo, array $incluirIds = []): array
    {
        $incluidos = $this->ids($incluirIds);
        $query = DB::table('grupo_unidade as gu')->select('gu.id', 'gu.nome');

        if ($podeAtribuirGrupo) {
            $query->where(function (Builder $grupos) use ($incluidos): void {
                $grupos->whereExists(function (Builder $membros): void {
                    $membros->selectRaw('1')
                        ->from('grupo_unidade_membro as gum')
                        ->whereColumn('gum.grupo_id', 'gu.id');
                });
                if ($incluidos !== []) {
                    $grupos->orWhereIn('gu.id', $incluidos);
                }
            });
        } elseif ($incluidos === []) {
            $query->whereRaw('1 = 0');
        } else {
            $query->whereIn('gu.id', $incluidos);
        }

        return $query->orderBy('gu.nome')->get()->all();
    }

    public function buscarImpactos(int $riscoId, int $macroprojetoId, ?array $unidadesPermitidas): array
    {
        if (! $this->buscarRisco($riscoId, $macroprojetoId, $unidadesPermitidas)) {
            return ['unidades' => [], 'grupos' => []];
        }

        return [
            'unidades' => DB::table('risco_unidade_impactada')
                ->where('risco_id', $riscoId)->pluck('unidade_id')->map(static fn ($id): int => (int) $id)->all(),
            'grupos' => DB::table('risco_grupo_impactado')
                ->where('risco_id', $riscoId)->pluck('grupo_unidade_id')->map(static fn ($id): int => (int) $id)->all(),
        ];
    }

    public function buscarSubprojetosPorIds(
        array $ids,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array {
        if ($ids === []) {
            return [];
        }
        $query = $this->consultaSubprojetos($macroprojetoId, $unidadesPermitidas)
            ->whereIn('s.id', $this->ids($ids));

        return $query->orderBy('p.nome')->orderBy('s.nome')->get()->all();
    }

    public function buscarTarefasPorIds(
        array $ids,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array {
        if ($ids === []) {
            return [];
        }
        $query = $this->consultaTarefas($macroprojetoId, $unidadesPermitidas)
            ->whereIn('t.id', $this->ids($ids));

        return $query->orderBy('p.nome')->orderBy('s.nome')->orderBy('t.nome')->get()->all();
    }

    public function listarTarefasVinculaveisAoRisco(
        int $riscoId,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array {
        if (! $this->buscarRisco($riscoId, $macroprojetoId, $unidadesPermitidas)) {
            return [];
        }
        $projetosIds = DB::table('risco_alvo as ra')
            ->leftJoin('subprojeto as s', 's.id', '=', 'ra.subprojeto_id')
            ->leftJoin('tarefa as ta', 'ta.id', '=', 'ra.tarefa_id')
            ->leftJoin('subprojeto as sta', 'sta.id', '=', 'ta.subprojeto_id')
            ->where('ra.risco_id', $riscoId)
            ->selectRaw('COALESCE(ra.projeto_id, s.projeto_id, sta.projeto_id) AS projeto_id')
            ->pluck('projeto_id')
            ->map(static fn ($id): int => (int) $id)
            ->filter()
            ->unique()
            ->values()
            ->all();
        if ($projetosIds === []) {
            return [];
        }

        return $this->consultaTarefas($macroprojetoId, $unidadesPermitidas)
            ->whereIn('p.id', $projetosIds)
            ->orderBy('p.nome')
            ->orderBy('s.nome')
            ->orderBy('t.nome')
            ->get()
            ->all();
    }

    public function salvarComposto(
        array $dados,
        array $alvos,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): int {
        return DB::transaction(function () use ($dados, $alvos, $macroprojetoId, $unidadesPermitidas, $usuario): int {
            $id = (int) ($dados['ID'] ?? 0);
            $unidadeId = (int) ($dados['UNIDADE_GESTORA_ID'] ?? 0);
            $riscoAtual = null;
            if ($id > 0) {
                $riscoAtual = $this->buscarRisco($id, $macroprojetoId, $unidadesPermitidas);
                if (! $riscoAtual) {
                    throw new RuntimeException('Risco não encontrado no escopo efetivo.');
                }
                if ((int) $riscoAtual->arquivado === 1) {
                    throw new RuntimeException('Reative o risco antes de alterá-lo.');
                }
                if ((int) $riscoAtual->unidade_gestora_id !== $unidadeId) {
                    $this->autorizarUnidade($unidadeId, $unidadesPermitidas);
                }
            } else {
                $this->autorizarUnidade($unidadeId, $unidadesPermitidas);
            }

            $registro = [
                'TITULO' => $dados['TITULO'],
                'DESCRICAO' => $dados['CONSEQUENCIAS'] ?? null,
                'PROBABILIDADE' => $dados['PROBABILIDADE_CODIGO'],
                'IMPACTO' => $dados['IMPACTO_CODIGO'],
                'NIVEL' => $dados['NIVEL_INERENTE_CODIGO'],
                'STATUS' => $dados['STATUS_CODIGO'],
                'UNIDADE_ID' => $dados['UNIDADE_GESTORA_ID'],
                'CAUSAS' => $dados['CAUSAS'] ?? null,
                'CONSEQUENCIAS' => $dados['CONSEQUENCIAS'] ?? null,
                'UNIDADE_GESTORA_ID' => $dados['UNIDADE_GESTORA_ID'],
                'AREA_IMPACTADA_ORIGINAL' => $dados['AREA_IMPACTADA_ORIGINAL'] ?? null,
                'PROBABILIDADE_ID' => $dados['PROBABILIDADE_ID'],
                'IMPACTO_ID' => $dados['IMPACTO_ID'],
                'NIVEL_INERENTE_ID' => $dados['NIVEL_INERENTE_ID'],
                'VALOR_INERENTE' => $dados['VALOR_INERENTE'],
                'CATEGORIA_ID' => $dados['CATEGORIA_ID'] ?? null,
                'RESPOSTA_ID' => $dados['RESPOSTA_ID'] ?? null,
                'STATUS_RISCO_ID' => $dados['STATUS_RISCO_ID'],
                'RISCO_INTEGRIDADE_CODIGO' => $dados['RISCO_INTEGRIDADE_CODIGO'] ?? null,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DATA_ATUALIZACAO' => DB::raw('SYSDATE'),
            ];

            if ($id > 0) {
                $this->atualizarAuditadoPorId('RISCO', 'RISCO', 'ID', $id, $registro);
                $this->removerEscopoAuditado(
                    'RISCO_ALVO',
                    'RISCO_ALVO',
                    $id,
                    static fn ($query) => $query->where('RISCO_ID', $id),
                    ['risco_id' => $id]
                );
            } else {
                $id = (int) $this->inserirAuditado('RISCO', 'RISCO', $registro + [
                    'MACROPROJETO_ID' => $macroprojetoId,
                    'CODIGO_EXTERNO' => CodigoRiscoManual::novo(),
                    'ORIGEM' => 'MANUAL',
                    'ARQUIVADO' => 0,
                    'USUARIO_CRIACAO' => $usuario,
                    'DATA_REGISTRO' => DB::raw('SYSDATE'),
                ]);
            }

            foreach ($alvos as $alvo) {
                $this->inserirAuditado('RISCO_ALVO', 'RISCO_ALVO', [
                    'RISCO_ID' => $id,
                    'PROJETO_ID' => $alvo['projeto_id'] ?? null,
                    'SUBPROJETO_ID' => $alvo['subprojeto_id'] ?? null,
                    'TAREFA_ID' => $alvo['tarefa_id'] ?? null,
                    'TIPO' => $alvo['tipo'] ?? 'MITIGACAO',
                ]);
            }
            $this->sincronizarImpactos($id, $dados, $unidadesPermitidas);

            return $id;
        });
    }

    public function arquivar(
        int $id,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $motivo,
        string $usuario
    ): bool {
        return DB::transaction(function () use ($id, $macroprojetoId, $unidadesPermitidas, $motivo, $usuario): bool {
            $risco = $this->buscarRisco($id, $macroprojetoId, $unidadesPermitidas);
            if (! $risco || (int) $risco->arquivado === 1) {
                return false;
            }
            $statusId = (int) DB::table('risco_status')->where('codigo', 'ARQUIVADO')->value('id');
            $this->atualizarAuditadoPorId('RISCO', 'RISCO', 'ID', $id, [
                'ARQUIVADO' => 1,
                'ARQUIVADO_EM' => DB::raw('SYSDATE'),
                'ARQUIVADO_POR' => $usuario,
                'MOTIVO_ARQUIVAMENTO' => $motivo,
                'STATUS' => 'ARQUIVADO',
                'STATUS_RISCO_ID' => $statusId,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DATA_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);

            return true;
        });
    }

    public function reativar(int $id, int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): bool
    {
        return DB::transaction(function () use ($id, $macroprojetoId, $unidadesPermitidas, $usuario): bool {
            $risco = $this->buscarRisco($id, $macroprojetoId, $unidadesPermitidas);
            if (! $risco || (int) $risco->arquivado !== 1) {
                return false;
            }
            $statusId = (int) DB::table('risco_status')->where('codigo', 'ABERTO')->value('id');
            $this->atualizarAuditadoPorId('RISCO', 'RISCO', 'ID', $id, [
                'ARQUIVADO' => 0,
                'ARQUIVADO_EM' => null,
                'ARQUIVADO_POR' => null,
                'MOTIVO_ARQUIVAMENTO' => null,
                'STATUS' => 'ABERTO',
                'STATUS_RISCO_ID' => $statusId,
                'USUARIO_ATUALIZACAO' => $usuario,
                'DATA_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);

            return true;
        });
    }

    public function buscarSubprojetosPorProjetos(
        array $projetos,
        array $subprojetos,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array {
        if ($projetos === [] && $subprojetos === []) {
            return [];
        }
        $query = $this->consultaSubprojetos($macroprojetoId, $unidadesPermitidas);
        $projetos !== []
            ? $query->whereIn('s.projeto_id', $this->ids($projetos))
            : $query->whereIn('s.id', $this->ids($subprojetos));

        return $query->orderBy('p.nome')->orderBy('s.nome')->get()->all();
    }

    public function buscarTarefasPorSubprojetos(
        array $subprojetos,
        array $tarefas,
        int $macroprojetoId,
        ?array $unidadesPermitidas
    ): array {
        if ($subprojetos === [] && $tarefas === []) {
            return [];
        }
        $query = $this->consultaTarefas($macroprojetoId, $unidadesPermitidas);
        $subprojetos !== []
            ? $query->whereIn('t.subprojeto_id', $this->ids($subprojetos))
            : $query->whereIn('t.id', $this->ids($tarefas));

        return $query->orderBy('p.nome')->orderBy('s.nome')->orderBy('t.nome')->get()->all();
    }

    private function consultaListagem(int $macroprojetoId, ?array $unidadesPermitidas, array $filtros): Builder
    {
        $query = DB::table('risco as r')
            ->leftJoin('vw_unidade as u', 'u.id_unidade', '=', 'r.unidade_gestora_id')
            ->leftJoin('risco_probabilidade as prob', 'prob.id', '=', 'r.probabilidade_id')
            ->leftJoin('risco_impacto as imp', 'imp.id', '=', 'r.impacto_id')
            ->leftJoin('risco_nivel as ni', 'ni.id', '=', 'r.nivel_inerente_id')
            ->leftJoin('risco_nivel as nr', 'nr.id', '=', 'r.nivel_residual_id')
            ->leftJoin('risco_resposta as resp', 'resp.id', '=', 'r.resposta_id')
            ->leftJoin('risco_status as rs', 'rs.id', '=', 'r.status_risco_id')
            ->where('r.macroprojeto_id', $macroprojetoId)
            ->selectRaw(<<<'SQL'
r.id, r.codigo_externo, r.titulo, r.origem, r.unidade_gestora_id,
r.valor_inerente, r.valor_residual, r.fator_controle_medio, r.arquivado,
r.data_registro, u.sigla AS unidade_sigla, u.descricao AS unidade_nome,
prob.nome AS probabilidade_nome, prob.pontuacao AS probabilidade_pontos,
imp.nome AS impacto_nome, imp.pontuacao AS impacto_pontos,
ni.codigo AS nivel_inerente_codigo, ni.nome AS nivel_inerente_nome, ni.cor AS nivel_inerente_cor,
nr.codigo AS nivel_residual_codigo, nr.nome AS nivel_residual_nome, nr.cor AS nivel_residual_cor,
resp.codigo AS resposta_codigo, resp.nome AS resposta_nome,
rs.codigo AS status_codigo, rs.nome AS status_nome,
(SELECT MIN(p.nome) FROM risco_alvo ra JOIN projeto p ON p.id = ra.projeto_id WHERE ra.risco_id = r.id) AS projeto_nome,
(SELECT MIN(p.id) FROM risco_alvo ra JOIN projeto p ON p.id = ra.projeto_id WHERE ra.risco_id = r.id) AS projeto_id,
(SELECT COUNT(*) FROM risco_pendencia rp WHERE rp.risco_id = r.id AND rp.status = 'ABERTA') AS pendencias_abertas
SQL);
        $this->escopoRisco->aplicar($query, $unidadesPermitidas);
        $this->aplicarFiltros($query, $filtros);

        return $query;
    }

    private function aplicarFiltros(Builder $query, array $filtros): void
    {
        $arquivado = (string) ($filtros['arquivado'] ?? '0');
        if ($arquivado !== 'todos') {
            $query->where('r.arquivado', $arquivado === '1' ? 1 : 0);
        }
        if (! empty($filtros['busca'])) {
            $busca = '%'.mb_strtoupper(trim((string) $filtros['busca'])).'%';
            $query->where(function (Builder $sub) use ($busca): void {
                $sub->whereRaw('UPPER(r.titulo) LIKE ?', [$busca])
                    ->orWhereRaw('UPPER(r.codigo_externo) LIKE ?', [$busca]);
            });
        }
        if (! empty($filtros['projeto_id'])) {
            $projetoId = (int) $filtros['projeto_id'];
            $query->whereExists(function (Builder $sub) use ($projetoId): void {
                $sub->selectRaw('1')->from('risco_alvo as raf')
                    ->whereColumn('raf.risco_id', 'r.id')->where('raf.projeto_id', $projetoId);
            });
        }
        if (! empty($filtros['unidade_id'])) {
            $unidadeId = (int) $filtros['unidade_id'];
            $this->escopoRisco->aplicar($query, [$unidadeId]);
        }
        foreach ([
            'nivel_inerente' => 'ni.codigo',
            'nivel_residual' => 'nr.codigo',
            'resposta' => 'resp.codigo',
            'status' => 'rs.codigo',
        ] as $filtro => $coluna) {
            if (! empty($filtros[$filtro])) {
                $query->where($coluna, $filtros[$filtro]);
            }
        }
        if (($filtros['pendencia'] ?? '') === '1') {
            $query->whereExists(function (Builder $sub): void {
                $sub->selectRaw('1')->from('risco_pendencia as rpf')
                    ->whereColumn('rpf.risco_id', 'r.id')->where('rpf.status', 'ABERTA');
            });
        } elseif (($filtros['pendencia'] ?? '') === '0') {
            $query->whereNotExists(function (Builder $sub): void {
                $sub->selectRaw('1')->from('risco_pendencia as rpf')
                    ->whereColumn('rpf.risco_id', 'r.id')->where('rpf.status', 'ABERTA');
            });
        }
    }

    private function aplicarEscopoProjeto(Builder $query, ?array $unidadesPermitidas): void
    {
        if ($unidadesPermitidas === null) {
            return;
        }
        if ($unidadesPermitidas === []) {
            $query->whereRaw('1 = 0');

            return;
        }
        $query->whereIn('p.unidade_id', $unidadesPermitidas);
    }

    private function consultaSubprojetos(int $macroprojetoId, ?array $unidadesPermitidas): Builder
    {
        $query = DB::table('subprojeto as s')
            ->join('projeto as p', 'p.id', '=', 's.projeto_id')
            ->where('p.macroprojeto_id', $macroprojetoId)
            ->select('s.id', 's.nome', 's.projeto_id', 's.unidade_id', 'p.nome as projeto');
        if ($unidadesPermitidas !== null) {
            $unidadesPermitidas === []
                ? $query->whereRaw('1 = 0')
                : $query->where(function (Builder $sub) use ($unidadesPermitidas): void {
                    $sub->whereIn('s.unidade_id', $unidadesPermitidas)
                        ->orWhereIn('p.unidade_id', $unidadesPermitidas);
                });
        }

        return $query;
    }

    private function consultaTarefas(int $macroprojetoId, ?array $unidadesPermitidas): Builder
    {
        $query = DB::table('tarefa as t')
            ->join('subprojeto as s', 's.id', '=', 't.subprojeto_id')
            ->join('projeto as p', 'p.id', '=', 's.projeto_id')
            ->where('p.macroprojeto_id', $macroprojetoId)
            ->select(
                't.id', 't.nome', 't.subprojeto_id', 't.unidade_id',
                's.nome as subprojeto', 's.projeto_id', 'p.nome as projeto'
            );
        if ($unidadesPermitidas !== null) {
            $unidadesPermitidas === []
                ? $query->whereRaw('1 = 0')
                : $query->where(function (Builder $sub) use ($unidadesPermitidas): void {
                    $sub->whereIn('t.unidade_id', $unidadesPermitidas)
                        ->orWhereIn('s.unidade_id', $unidadesPermitidas)
                        ->orWhereIn('p.unidade_id', $unidadesPermitidas);
                });
        }

        return $query;
    }

    private function autorizarUnidade(int $unidadeId, ?array $unidadesPermitidas): void
    {
        if ($unidadeId <= 0 || ($unidadesPermitidas !== null && ! in_array($unidadeId, $unidadesPermitidas, true))) {
            throw new RuntimeException('Unidade gestora fora do escopo efetivo.');
        }
    }

    /** @param array<int, object> $acoes */
    private function anexarTarefasAcoes(array $acoes, string $coluna): void
    {
        $ids = collect($acoes)->pluck('id')->map(static fn ($id): int => (int) $id)->filter()->all();
        $vinculos = $ids === [] ? collect() : DB::table('risco_acao_tarefa as rat')
            ->join('tarefa as t', 't.id', '=', 'rat.tarefa_id')
            ->whereIn('rat.'.$coluna, $ids)
            ->get(['rat.'.$coluna.' as acao_id', 't.id', 't.nome'])
            ->groupBy('acao_id');
        foreach ($acoes as $acao) {
            $acao->tarefas = ($vinculos[(int) $acao->id] ?? collect())->values()->all();
        }
    }

    private function sincronizarImpactos(int $riscoId, array $dados, ?array $unidadesPermitidas): void
    {
        $unidades = $this->ids($dados['UNIDADES_IMPACTADAS'] ?? []);
        $grupos = $this->ids($dados['GRUPOS_IMPACTADOS'] ?? []);
        $unidadesAnteriores = DB::table('risco_unidade_impactada')
            ->where('risco_id', $riscoId)->pluck('unidade_id')->map(static fn ($id): int => (int) $id)->all();
        $gruposAnteriores = DB::table('risco_grupo_impactado')
            ->where('risco_id', $riscoId)->pluck('grupo_unidade_id')->map(static fn ($id): int => (int) $id)->all();

        $membrosPorGrupo = [];
        foreach ($grupos as $grupoId) {
            if (! DB::table('grupo_unidade')->where('id', $grupoId)->exists()) {
                throw new RuntimeException('Grupo impactado inexistente.');
            }
            $membrosPorGrupo[$grupoId] = DB::table('grupo_unidade_membro')
                ->where('grupo_id', $grupoId)->pluck('unidade_id')
                ->map(static fn ($id): int => (int) $id)->unique()->values()->all();
        }

        if ($unidadesPermitidas !== null) {
            $novasUnidades = array_diff($unidades, $unidadesAnteriores);
            if (array_diff($novasUnidades, $unidadesPermitidas) !== []) {
                throw new RuntimeException('Unidade impactada fora do escopo efetivo.');
            }
            foreach (array_diff($grupos, $gruposAnteriores) as $grupoId) {
                if ($membrosPorGrupo[$grupoId] === []
                    || array_diff($membrosPorGrupo[$grupoId], $unidadesPermitidas) !== []) {
                    throw new RuntimeException('Grupo impactado fora do escopo efetivo.');
                }
            }
        }

        $this->removerEscopoAuditado(
            'RISCO_UNIDADE_IMPACTADA',
            'RISCO_UNIDADE_IMPACTADA',
            $riscoId,
            static fn ($query) => $query->where('RISCO_ID', $riscoId),
            ['risco_id' => $riscoId]
        );
        $this->removerEscopoAuditado(
            'RISCO_GRUPO_IMPACTADO',
            'RISCO_GRUPO_IMPACTADO',
            $riscoId,
            static fn ($query) => $query->where('RISCO_ID', $riscoId),
            ['risco_id' => $riscoId]
        );

        $origens = array_fill_keys($unidades, 'MANUAL');
        foreach ($membrosPorGrupo as $membros) {
            foreach ($membros as $unidadeId) {
                $origens[$unidadeId] ??= 'GRUPO';
            }
        }
        foreach ($origens as $unidadeId => $origem) {
            $this->inserirAuditado('RISCO_UNIDADE_IMPACTADA', 'RISCO_UNIDADE_IMPACTADA', [
                'RISCO_ID' => $riscoId,
                'UNIDADE_ID' => (int) $unidadeId,
                'ORIGEM' => $origem,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }
        foreach ($grupos as $grupoId) {
            $this->inserirAuditado('RISCO_GRUPO_IMPACTADO', 'RISCO_GRUPO_IMPACTADO', [
                'RISCO_ID' => $riscoId,
                'GRUPO_UNIDADE_ID' => $grupoId,
                'ORIGEM' => 'MANUAL',
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ]);
        }
    }

    private function ids(array $ids): array
    {
        return collect($ids)
            ->map(static fn ($id): int => (int) $id)
            ->filter()
            ->unique()
            ->values()
            ->all();
    }
}
```
</APP_REPOSITORIES_RISCOS_RISCOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Riscos/RiscoCalculoService.php`
## <APP_SERVICES_RISCOS_RISCOCALCULOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Riscos/RiscoCalculoService.php`
- **Namespace Declaração:** `App\Services\Riscos`
- **Entidade / Classe:** `class RiscoCalculoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function calcularInerente(int $probabilidade, int $impacto): array
public function calcularResidual(float $riscoInerente, array $fatoresControlesAtivos): array
public function classificarNivel(float $valor): string
public function apetitePorNivel(string $nivel): string
private function validarPontuacao(int $pontuacao, string $campo): void
private function residualPendente(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Riscos;

use InvalidArgumentException;

class RiscoCalculoService
{
    /**
     * @return array{valor: float, nivel: string}
     */
    public function calcularInerente(int $probabilidade, int $impacto): array
    {
        $this->validarPontuacao($probabilidade, 'probabilidade');
        $this->validarPontuacao($impacto, 'impacto');

        $valor = (float) ($probabilidade * $impacto);

        return [
            'valor' => $valor,
            'nivel' => $this->classificarNivel($valor),
        ];
    }

    /**
     * @param  array<int, float|null>  $fatoresControlesAtivos
     * @return array{
     *     fator_medio: float|null,
     *     valor: float|null,
     *     nivel: string|null,
     *     apetite: string|null,
     *     pendente: bool
     * }
     */
    public function calcularResidual(float $riscoInerente, array $fatoresControlesAtivos): array
    {
        if ($riscoInerente < 0) {
            throw new InvalidArgumentException('O risco inerente não pode ser negativo.');
        }

        if ($fatoresControlesAtivos === [] || in_array(null, $fatoresControlesAtivos, true)) {
            return $this->residualPendente();
        }

        foreach ($fatoresControlesAtivos as $fator) {
            if ($fator < 0.0 || $fator > 1.0) {
                throw new InvalidArgumentException('O fator do controle deve estar entre 0 e 1.');
            }
        }

        $fatorMedio = array_sum($fatoresControlesAtivos) / count($fatoresControlesAtivos);
        $valor = $riscoInerente * $fatorMedio;
        $nivel = $this->classificarNivel($valor);

        return [
            'fator_medio' => $fatorMedio,
            'valor' => $valor,
            'nivel' => $nivel,
            'apetite' => $this->apetitePorNivel($nivel),
            'pendente' => false,
        ];
    }

    public function classificarNivel(float $valor): string
    {
        if ($valor < 0) {
            throw new InvalidArgumentException('O valor do risco não pode ser negativo.');
        }

        return match (true) {
            $valor <= 1.0 => 'SEM_RISCO',
            $valor <= 2.0 => 'BAIXO',
            $valor <= 6.0 => 'MEDIO',
            $valor < 15.0 => 'ALTO',
            default => 'EXTREMO',
        };
    }

    public function apetitePorNivel(string $nivel): string
    {
        return match ($nivel) {
            'SEM_RISCO' => 'NAO_HA',
            'BAIXO' => 'OPORTUNIDADE',
            'MEDIO' => 'ACEITAVEL',
            'ALTO' => 'INACEITAVEL',
            'EXTREMO' => 'ABSOLUTAMENTE_INACEITAVEL',
            default => throw new InvalidArgumentException('Nível de risco inválido.'),
        };
    }

    private function validarPontuacao(int $pontuacao, string $campo): void
    {
        if ($pontuacao < 1 || $pontuacao > 5) {
            throw new InvalidArgumentException("A pontuação de {$campo} deve estar entre 1 e 5.");
        }
    }

    /**
     * @return array{fator_medio: null, valor: null, nivel: null, apetite: null, pendente: true}
     */
    private function residualPendente(): array
    {
        return [
            'fator_medio' => null,
            'valor' => null,
            'nivel' => null,
            'apetite' => null,
            'pendente' => true,
        ];
    }
}
```
</APP_SERVICES_RISCOS_RISCOCALCULOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Riscos/RiscoImportacaoService.php`
## <APP_SERVICES_RISCOS_RISCOIMPORTACAOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Riscos/RiscoImportacaoService.php`
- **Namespace Declaração:** `App\Services\Riscos`
- **Entidade / Classe:** `class RiscoImportacaoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function previsualizar(
public function aplicar(
private function indexarProjetos(array $projetos): array
private function normalizarRisco(
private function normalizarAreas(string $area, array $unidades, array $grupos): array
private function normalizarOpcaoBinaria(?string $valor, array $opcoes): ?string
private function normalizarContexto(array $contexto, array $referencias): array
private function distribuicao(array $itens, string $campo): array
private function codigo(string $valor): string
private function probabilidadeLegacy(int $pontos): string
private function impactoLegacy(int $pontos): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Riscos;

use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use Illuminate\Support\Str;
use RuntimeException;

class RiscoImportacaoService
{
    private const ALIASES_PROJETO = [
        'DIA_E' => 'GARANTIA_DIA_E',
        'ELEITOS' => 'ELEITOS_2026',
    ];

    public function __construct(
        private readonly RiscoImportacaoRepositoryInterface $repository,
        private readonly RiscoPlanilhaParser $parser = new RiscoPlanilhaParser
    ) {}

    /** @return array<string, mixed> */
    public function previsualizar(
        string $caminho,
        int $macroprojetoId,
        string $usuario,
        ?array $unidadesPermitidas = null,
        ?string $nomeArquivoOriginal = null
    ): array {
        if ($macroprojetoId <= 0) {
            throw new RuntimeException('Macroprojeto inválido para a importação de riscos.');
        }
        if ($unidadesPermitidas === []) {
            throw new RuntimeException('A importação exige ao menos uma unidade no escopo efetivo.');
        }

        $fonte = $this->parser->parse($caminho, $nomeArquivoOriginal);
        $existente = $this->repository->buscarLotePorHash($macroprojetoId, $fonte['hash']);
        if ($existente !== null) {
            return [
                'lote_id' => (int) $existente['id'],
                'status' => $existente['status'],
                'total' => (int) ($existente['total_itens'] ?? 0),
                'erros' => (int) ($existente['total_erros'] ?? 0),
                'avisos' => (int) ($existente['total_avisos'] ?? 0),
                'idempotente' => true,
            ];
        }

        $referencias = $this->repository->carregarReferencias($macroprojetoId);
        $projetos = $this->indexarProjetos($referencias['projetos'] ?? []);
        $itens = [];
        $totalErros = 0;
        $totalAvisos = 0;

        foreach ($fonte['riscos'] as $risco) {
            $normalizado = $this->normalizarRisco(
                $risco,
                $projetos,
                $referencias,
                $unidadesPermitidas
            );
            $totalErros += count($normalizado['erros']);
            $totalAvisos += count($normalizado['pendencias']);
            $itens[] = [
                'codigo_externo' => $normalizado['codigo'],
                'status' => $normalizado['erros'] !== []
                    ? 'ERRO'
                    : ($normalizado['pendencias'] !== [] ? 'AVISO' : 'VALIDO'),
                'dados' => $normalizado,
                'mensagens' => [
                    'erros' => $normalizado['erros'],
                    'pendencias' => $normalizado['pendencias'],
                ],
            ];
        }

        $resumo = [
            'contexto' => $this->normalizarContexto($fonte['contexto'], $referencias),
            'total' => count($itens),
            'erros' => $totalErros,
            'avisos' => $totalAvisos,
            'distribuicao_inerente' => $this->distribuicao($itens, 'nivel_inerente'),
            'distribuicao_residual' => $this->distribuicao($itens, 'nivel_residual'),
        ];
        $loteId = $this->repository->criarPrevia(
            $macroprojetoId,
            basename(trim((string) $nomeArquivoOriginal) !== '' ? $nomeArquivoOriginal : $caminho),
            $fonte['hash'],
            $resumo,
            $itens,
            $usuario
        );

        return [
            'lote_id' => $loteId,
            'status' => 'PREVIA',
            'total' => count($itens),
            'erros' => $totalErros,
            'avisos' => $totalAvisos,
            'idempotente' => false,
            'distribuicao_inerente' => $resumo['distribuicao_inerente'],
            'distribuicao_residual' => $resumo['distribuicao_residual'],
        ];
    }

    /** @return array<string, mixed> */
    public function aplicar(
        int $loteId,
        int $macroprojetoId,
        string $usuario,
        ?array $unidadesPermitidas = null
    ): array {
        return $this->repository->aplicar($loteId, $macroprojetoId, $unidadesPermitidas, $usuario);
    }

    /** @param array<int, mixed> $projetos */
    private function indexarProjetos(array $projetos): array
    {
        $indice = [];
        foreach ($projetos as $projeto) {
            $item = (array) $projeto;
            $indice[$this->codigo((string) ($item['nome'] ?? ''))] = [
                'id' => (int) ($item['id'] ?? 0),
                'nome' => (string) ($item['nome'] ?? ''),
                'unidade_id' => (int) ($item['unidade_id'] ?? 0),
            ];
        }

        return $indice;
    }

    /** @return array<string, mixed> */
    private function normalizarRisco(
        array $risco,
        array $projetos,
        array $referencias,
        ?array $unidadesPermitidas
    ): array {
        $erros = [];
        $pendencias = array_values(array_unique($risco['pendencias'] ?? []));
        $codigoProjetoFonte = $this->codigo((string) $risco['projeto']);
        $codigoProjeto = self::ALIASES_PROJETO[$codigoProjetoFonte] ?? $codigoProjetoFonte;
        $projeto = $projetos[$codigoProjeto] ?? null;

        if ($projeto === null || $projeto['id'] <= 0) {
            $erros[] = 'PROJETO_NAO_ENCONTRADO';
        } elseif ($projeto['unidade_id'] <= 0) {
            $erros[] = 'UNIDADE_GESTORA_AUSENTE';
        } elseif (is_array($unidadesPermitidas) && ! in_array($projeto['unidade_id'], $unidadesPermitidas, true)) {
            $erros[] = 'UNIDADE_GESTORA_FORA_ESCOPO';
        }

        if (in_array($risco['codigo'], $referencias['codigos_existentes'] ?? [], true)) {
            $erros[] = 'CODIGO_JA_EXISTENTE_NO_MACROPROJETO';
        }

        $probabilidadeId = $referencias['probabilidades'][(string) $risco['probabilidade_pontos']] ?? null;
        $impactoId = $referencias['impactos'][(string) $risco['impacto_pontos']] ?? null;
        $nivelInerenteId = $referencias['niveis'][$risco['nivel_inerente']] ?? null;
        $nivelResidualId = $risco['nivel_residual'] !== null
            ? ($referencias['niveis'][$risco['nivel_residual']] ?? null)
            : null;
        $apetiteId = $risco['apetite'] !== null
            ? ($referencias['apetites'][$risco['apetite']] ?? null)
            : null;
        $respostaCodigo = $this->codigo((string) ($risco['tratamento']['resposta'] ?? ''));
        $respostaId = $respostaCodigo !== '' ? ($referencias['respostas'][$respostaCodigo] ?? null) : null;
        $fatorChave = $risco['controle']['fator'] !== null
            ? number_format((float) $risco['controle']['fator'], 6, '.', '')
            : null;
        $classificacaoId = $fatorChave !== null
            ? ($referencias['classificacoes_controle'][$fatorChave] ?? null)
            : null;

        foreach ([
            'DOMINIO_PROBABILIDADE_AUSENTE' => $probabilidadeId,
            'DOMINIO_IMPACTO_AUSENTE' => $impactoId,
            'DOMINIO_NIVEL_INERENTE_AUSENTE' => $nivelInerenteId,
            'DOMINIO_STATUS_RISCO_AUSENTE' => $referencias['status_risco']['ABERTO'] ?? null,
            'DOMINIO_STATUS_ACAO_AUSENTE' => $referencias['status_acao']['NAO_INICIADA'] ?? null,
        ] as $erro => $id) {
            if ($id === null) {
                $erros[] = $erro;
            }
        }
        if ($risco['nivel_residual'] !== null && ($nivelResidualId === null || $apetiteId === null)) {
            $erros[] = 'DOMINIO_RESIDUAL_AUSENTE';
        }
        if ($fatorChave !== null && $classificacaoId === null) {
            $erros[] = 'DOMINIO_CLASSIFICACAO_CONTROLE_AUSENTE';
        }
        if ($respostaCodigo !== '' && $respostaId === null) {
            $erros[] = 'DOMINIO_RESPOSTA_AUSENTE';
        }

        if (($risco['causas'] ?? null) === null) {
            $pendencias[] = 'CAUSAS_AUSENTES';
        }
        if (($risco['consequencias'] ?? null) === null) {
            $pendencias[] = 'CONSEQUENCIAS_AUSENTES';
        }
        if (($risco['controle']['descricao'] ?? null) === null) {
            $pendencias[] = 'CONTROLE_SEM_DESCRICAO';
        }
        if (($risco['tratamento']['descricao'] ?? '') === '') {
            $pendencias[] = 'TRATAMENTO_SEM_DESCRICAO';
        }
        if (($risco['contingencia']['descricao'] ?? '') === '') {
            $pendencias[] = 'CONTINGENCIA_SEM_DESCRICAO';
        }

        $areas = $this->normalizarAreas(
            (string) ($risco['area_impactada_original'] ?? ''),
            $referencias['unidades'] ?? [],
            $referencias['grupos'] ?? []
        );
        if ($areas['nao_resolvidos'] !== []) {
            $pendencias[] = 'AREA_IMPACTADA_NAO_RESOLVIDA';
        }

        $integridadeCodigo = $this->normalizarOpcaoBinaria(
            $risco['risco_integridade'] ?? null,
            $referencias['opcoes_binarias'] ?? []
        );
        $categoriaCodigo = $this->codigo((string) ($risco['categoria'] ?? ''));

        return array_merge($risco, [
            'projeto_id' => $projeto['id'] ?? null,
            'projeto_nome_resolvido' => $projeto['nome'] ?? null,
            'unidade_gestora_id' => $projeto['unidade_id'] ?? null,
        ], [
            'probabilidade_id' => $probabilidadeId,
            'impacto_id' => $impactoId,
            'nivel_inerente_id' => $nivelInerenteId,
            'nivel_residual_id' => $nivelResidualId,
            'apetite_id' => $apetiteId,
            'categoria_id' => $categoriaCodigo !== '' ? ($referencias['categorias'][$categoriaCodigo] ?? null) : null,
            'resposta_id' => $respostaId,
            'status_risco_id' => $referencias['status_risco']['ABERTO'] ?? null,
            'status_acao_id' => $referencias['status_acao']['NAO_INICIADA'] ?? null,
            'classificacao_controle_id' => $classificacaoId,
            'risco_integridade_codigo' => $integridadeCodigo,
            'probabilidade_legacy' => $this->probabilidadeLegacy($risco['probabilidade_pontos']),
            'impacto_legacy' => $this->impactoLegacy($risco['impacto_pontos']),
            'unidades_impactadas_ids' => $areas['unidades_ids'],
            'grupos_impactados_ids' => $areas['grupos_ids'],
            'areas_nao_resolvidas' => $areas['nao_resolvidos'],
            'pendencias' => array_values(array_unique($pendencias)),
            'erros' => array_values(array_unique($erros)),
        ]);
    }

    /** @return array{unidades_ids: array<int, int>, grupos_ids: array<int, int>, nao_resolvidos: array<int, string>} */
    private function normalizarAreas(string $area, array $unidades, array $grupos): array
    {
        if (trim($area) === '') {
            return ['unidades_ids' => [], 'grupos_ids' => [], 'nao_resolvidos' => []];
        }

        $unidadesPorNome = [];
        foreach ($unidades as $unidade) {
            $item = (array) $unidade;
            $id = (int) ($item['id'] ?? 0);
            foreach ([$item['sigla'] ?? '', $item['descricao'] ?? ''] as $nome) {
                $codigo = $this->codigo((string) $nome);
                if ($codigo !== '' && $id > 0) {
                    $unidadesPorNome[$codigo] = $id;
                }
            }
        }

        $gruposPorNome = [];
        foreach ($grupos as $grupo) {
            $item = (array) $grupo;
            $codigo = $this->codigo((string) ($item['nome'] ?? ''));
            if ($codigo !== '') {
                $gruposPorNome[$codigo] = [
                    'id' => (int) ($item['id'] ?? 0),
                    'unidades_ids' => array_map('intval', $item['unidades_ids'] ?? []),
                ];
            }
        }

        $tokens = preg_split('/\s*(?:,|;|\/|\s+E\s+)\s*/iu', trim($area), -1, PREG_SPLIT_NO_EMPTY) ?: [];
        $idsUnidades = [];
        $idsGrupos = [];
        $naoResolvidos = [];
        foreach ($tokens as $token) {
            $codigo = $this->codigo($token);
            if (in_array($codigo, ['ZONA_ELEITORAL', 'ZONAS_ELEITORAIS', 'CARTORIOS_ELEITORAIS', 'ZE'], true)) {
                $codigo = 'ZONAS';
            }

            if (isset($unidadesPorNome[$codigo])) {
                $idsUnidades[] = $unidadesPorNome[$codigo];

                continue;
            }
            if (isset($gruposPorNome[$codigo]) && $gruposPorNome[$codigo]['id'] > 0) {
                $idsGrupos[] = $gruposPorNome[$codigo]['id'];
                $idsUnidades = [...$idsUnidades, ...$gruposPorNome[$codigo]['unidades_ids']];

                continue;
            }
            $naoResolvidos[] = trim($token);
        }

        return [
            'unidades_ids' => array_values(array_unique(array_filter($idsUnidades))),
            'grupos_ids' => array_values(array_unique($idsGrupos)),
            'nao_resolvidos' => array_values(array_unique(array_filter($naoResolvidos))),
        ];
    }

    private function normalizarOpcaoBinaria(?string $valor, array $opcoes): ?string
    {
        $codigo = $this->codigo((string) $valor);
        $codigo = match ($codigo) {
            'S', 'SIM' => 'SIM',
            'N', 'NAO' => 'NAO',
            default => '',
        };

        return $codigo !== '' && array_key_exists($codigo, $opcoes) ? $codigo : null;
    }

    private function normalizarContexto(array $contexto, array $referencias): array
    {
        $swot = $contexto['swot'] ?? [];
        foreach ($swot as &$item) {
            $item['tipo_id'] = $referencias['tipos_swot'][$item['tipo']] ?? null;
            if ($item['tipo_id'] === null) {
                throw new RuntimeException("Domínio SWOT ausente: {$item['tipo']}.");
            }
        }
        unset($item);
        $contexto['swot'] = $swot;

        return $contexto;
    }

    private function distribuicao(array $itens, string $campo): array
    {
        $resultado = [];
        foreach ($itens as $item) {
            $nivel = $item['dados'][$campo] ?? 'PENDENTE';
            $resultado[$nivel] = ($resultado[$nivel] ?? 0) + 1;
        }

        return $resultado;
    }

    private function codigo(string $valor): string
    {
        $ascii = Str::ascii(trim($valor));
        $codigo = preg_replace('/[^A-Za-z0-9]+/', '_', $ascii) ?? '';

        return trim(mb_strtoupper($codigo), '_');
    }

    private function probabilidadeLegacy(int $pontos): string
    {
        return [1 => 'RARA', 2 => 'IMPROVAVEL', 3 => 'POSSIVEL', 4 => 'PROVAVEL', 5 => 'QUASE_CERTO'][$pontos];
    }

    private function impactoLegacy(int $pontos): string
    {
        return [1 => 'INSIGNIFICANTE', 2 => 'PEQUENO', 3 => 'MODERADO', 4 => 'GRANDE', 5 => 'CATASTROFICO'][$pontos];
    }
}
```
</APP_SERVICES_RISCOS_RISCOIMPORTACAOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Riscos/RiscoPlanilhaParser.php`
## <APP_SERVICES_RISCOS_RISCOPLANILHAPARSER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Riscos/RiscoPlanilhaParser.php`
- **Namespace Declaração:** `App\Services\Riscos`
- **Entidade / Classe:** `class RiscoPlanilhaParser`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly RiscoCalculoService $calculo = new RiscoCalculoService) {}
public function parse(string $caminho, ?string $nomeArquivoOriginal = null): array
private function validarArquivo(string $caminho, ?string $nomeArquivoOriginal): void
private function validarEstrutura(Spreadsheet $planilha): array
private function indexarPorCodigo(Worksheet $aba, int $linhaInicial, string $coluna): array
private function lerRisco(
private function lerPeriodo(string $inicioBruto, string $fimBruto, string $tipo, array &$pendencias): array
private function normalizarData(string $valor, string $tipo, string $extremo, array &$pendencias): ?DateTimeImmutable
private function lerContexto(Worksheet $aba): array
private function linhaComoArray(Worksheet $aba, int $linha, int $ultimaColuna): array
private function texto(Worksheet $aba, string $coluna, int $linha): string
private function textoOuNulo(Worksheet $aba, string $coluna, int $linha): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Riscos;

use DateTimeImmutable;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use RuntimeException;
use Throwable;

class RiscoPlanilhaParser
{
    private const ABA_CONTEXTO = '1 - Estabelecimento do Contexto';

    private const ABA_IDENTIFICACAO = '2 - Identificação do Risco';

    private const ABA_AVALIACAO = '4 - Avaliação do Risco';

    private const ABA_ORIGINAL = '10 - Dados Originais PDF';

    private const ABA_COMPLEMENTOS = '11 - Complementos Planilha v2';

    public function __construct(private readonly RiscoCalculoService $calculo = new RiscoCalculoService) {}

    /**
     * @return array{hash: string, contexto: array<string, mixed>, riscos: array<string, array<string, mixed>>}
     */
    public function parse(string $caminho, ?string $nomeArquivoOriginal = null): array
    {
        $this->validarArquivo($caminho, $nomeArquivoOriginal);

        $planilha = IOFactory::load($caminho);
        try {
            $abas = $this->validarEstrutura($planilha);

            $identificacoes = $this->indexarPorCodigo($abas[self::ABA_IDENTIFICACAO], 3, 'A');
            $controles = $this->indexarPorCodigo($abas[self::ABA_AVALIACAO], 3, 'B');
            $complementos = $this->indexarPorCodigo($abas[self::ABA_COMPLEMENTOS], 5, 'A');
            $riscos = [];

            for ($linha = 3; $linha <= $abas[self::ABA_ORIGINAL]->getHighestDataRow(); $linha++) {
                $codigo = $this->texto($abas[self::ABA_ORIGINAL], 'A', $linha);
                if ($codigo === '') {
                    continue;
                }

                if (! preg_match('/^R\d{2,3}$/', $codigo)) {
                    throw new RuntimeException("Código de risco inválido na linha {$linha}: {$codigo}.");
                }

                if (isset($riscos[$codigo])) {
                    throw new RuntimeException("Código de risco duplicado na planilha: {$codigo}.");
                }

                $riscos[$codigo] = $this->lerRisco(
                    $abas[self::ABA_ORIGINAL],
                    $linha,
                    $identificacoes[$codigo] ?? null,
                    $controles[$codigo] ?? null,
                    $complementos[$codigo] ?? null
                );
            }

            if ($riscos === []) {
                throw new RuntimeException('A planilha não contém riscos importáveis.');
            }

            uksort($riscos, static fn (string $a, string $b): int => strnatcmp($a, $b));

            $resultado = [
                'hash' => hash_file('sha256', $caminho),
                'contexto' => $this->lerContexto($abas[self::ABA_CONTEXTO]),
                'riscos' => $riscos,
            ];
        } finally {
            $planilha->disconnectWorksheets();
        }

        return $resultado;
    }

    private function validarArquivo(string $caminho, ?string $nomeArquivoOriginal): void
    {
        if (! is_file($caminho) || ! is_readable($caminho)) {
            throw new RuntimeException('Arquivo de riscos não encontrado ou sem permissão de leitura.');
        }

        $nomeParaValidacao = trim((string) $nomeArquivoOriginal) !== '' ? $nomeArquivoOriginal : $caminho;
        if (mb_strtolower(pathinfo($nomeParaValidacao, PATHINFO_EXTENSION)) !== 'xlsx') {
            throw new RuntimeException('A importação aceita exclusivamente arquivos .xlsx.');
        }
    }

    /** @return array<string, Worksheet> */
    private function validarEstrutura(Spreadsheet $planilha): array
    {
        $abas = [];
        foreach ([
            self::ABA_CONTEXTO,
            self::ABA_IDENTIFICACAO,
            self::ABA_AVALIACAO,
            self::ABA_ORIGINAL,
            self::ABA_COMPLEMENTOS,
        ] as $nome) {
            $aba = $planilha->getSheetByName($nome);
            if (! $aba) {
                throw new RuntimeException("Aba obrigatória ausente: {$nome}.");
            }
            $abas[$nome] = $aba;
        }

        $cabecalhos = [
            [self::ABA_IDENTIFICACAO, 'A2', 'ID do risco'],
            [self::ABA_AVALIACAO, 'B2', 'ID Risco'],
            [self::ABA_ORIGINAL, 'A2', 'ID do Risco'],
            [self::ABA_ORIGINAL, 'U2', 'Data final da contingência'],
            [self::ABA_COMPLEMENTOS, 'A4', 'ID do Risco'],
            [self::ABA_COMPLEMENTOS, 'H4', 'Apetite a Risco'],
        ];

        foreach ($cabecalhos as [$nomeAba, $celula, $esperado]) {
            $encontrado = trim((string) $abas[$nomeAba]->getCell($celula)->getFormattedValue());
            if ($encontrado !== $esperado) {
                throw new RuntimeException(
                    "Cabeçalho incompatível em {$nomeAba}!{$celula}: esperado '{$esperado}'."
                );
            }
        }

        return $abas;
    }

    /** @return array<string, int> */
    private function indexarPorCodigo(Worksheet $aba, int $linhaInicial, string $coluna): array
    {
        $indice = [];
        for ($linha = $linhaInicial; $linha <= $aba->getHighestDataRow(); $linha++) {
            $codigo = $this->texto($aba, $coluna, $linha);
            if ($codigo === '') {
                continue;
            }
            if (isset($indice[$codigo])) {
                throw new RuntimeException("Código duplicado na aba {$aba->getTitle()}: {$codigo}.");
            }
            $indice[$codigo] = $linha;
        }

        return $indice;
    }

    /** @return array<string, mixed> */
    private function lerRisco(
        Worksheet $original,
        int $linha,
        ?int $linhaIdentificacao,
        ?int $linhaControle,
        ?int $linhaComplemento
    ): array {
        $codigo = $this->texto($original, 'A', $linha);
        if ($linhaIdentificacao === null || $linhaControle === null || $linhaComplemento === null) {
            throw new RuntimeException("O risco {$codigo} não possui correspondência em todas as abas obrigatórias.");
        }

        $planilha = $original->getParent();
        $identificacao = $planilha->getSheetByName(self::ABA_IDENTIFICACAO);
        $avaliacao = $planilha->getSheetByName(self::ABA_AVALIACAO);
        $complementos = $planilha->getSheetByName(self::ABA_COMPLEMENTOS);

        $probabilidade = (int) $this->texto($original, 'H', $linha);
        $impacto = (int) $this->texto($original, 'I', $linha);
        $inerente = $this->calculo->calcularInerente($probabilidade, $impacto);
        $fator = $this->numeroOuNulo($this->texto($complementos, 'E', $linhaComplemento));
        $residual = $this->calculo->calcularResidual($inerente['valor'], [$fator]);
        $pendencias = [];

        if ($residual['pendente']) {
            $pendencias[] = 'CONTROLE_SEM_CLASSIFICACAO';
        }

        $tratamento = $this->lerPeriodo(
            $this->texto($original, 'P', $linha),
            $this->texto($original, 'Q', $linha),
            'TRATAMENTO',
            $pendencias
        );
        $contingencia = $this->lerPeriodo(
            $this->texto($original, 'T', $linha),
            $this->texto($original, 'U', $linha),
            'CONTINGENCIA',
            $pendencias
        );

        $tratamento += [
            'codigo' => $this->texto($avaliacao, 'D', $linhaControle),
            'resposta' => $this->texto($original, 'M', $linha),
            'descricao' => $this->texto($original, 'N', $linha),
            'responsavel_original' => $this->texto($original, 'O', $linha),
        ];
        $contingencia += [
            'descricao' => $this->texto($original, 'R', $linha),
            'responsavel_original' => $this->texto($original, 'S', $linha),
        ];

        return [
            'codigo' => $codigo,
            'origem' => 'IMPORTACAO',
            'status' => 'ABERTO',
            'titulo' => $this->texto($original, 'C', $linha),
            'projeto' => $this->texto($original, 'D', $linha),
            'area_impactada_original' => $this->texto($original, 'E', $linha),
            'causas' => $this->textoOuNulo($original, 'F', $linha),
            'consequencias' => $this->textoOuNulo($original, 'G', $linha),
            'risco_integridade' => $this->textoOuNulo($identificacao, 'E', $linhaIdentificacao),
            'categoria' => $this->textoOuNulo($identificacao, 'F', $linhaIdentificacao),
            'probabilidade_pontos' => $probabilidade,
            'impacto_pontos' => $impacto,
            'valor_inerente' => $inerente['valor'],
            'nivel_inerente' => $inerente['nivel'],
            'controle' => [
                'codigo' => $this->texto($avaliacao, 'D', $linhaControle),
                'descricao' => $this->textoOuNulo($original, 'L', $linha),
                'classificacao' => $this->textoOuNulo($complementos, 'D', $linhaComplemento),
                'confianca_original' => $this->textoOuNulo($complementos, 'C', $linhaComplemento),
                'fator' => $fator,
                'ativo' => true,
            ],
            'fator_controle_medio' => $residual['fator_medio'],
            'valor_residual' => $residual['valor'],
            'nivel_residual' => $residual['nivel'],
            'apetite' => $residual['apetite'],
            'tratamento' => $tratamento,
            'contingencia' => $contingencia,
            'pendencias' => array_values(array_unique($pendencias)),
            'payload_bruto' => [
                'dados_originais' => $this->linhaComoArray($original, $linha, 21),
                'identificacao' => $this->linhaComoArray($identificacao, $linhaIdentificacao, 6),
                'avaliacao' => $this->linhaComoArray($avaliacao, $linhaControle, 7),
                'complementos_v2' => $this->linhaComoArray($complementos, $linhaComplemento, 10),
            ],
        ];
    }

    /**
     * @param  array<int, string>  $pendencias
     * @return array{data_inicio: string|null, data_fim: string|null, prazo_inicio_texto: string|null, prazo_fim_texto: string|null}
     */
    private function lerPeriodo(string $inicioBruto, string $fimBruto, string $tipo, array &$pendencias): array
    {
        $inicio = $this->normalizarData($inicioBruto, $tipo, 'INICIO', $pendencias);
        $fim = $this->normalizarData($fimBruto, $tipo, 'FIM', $pendencias);

        if ($inicio !== null && $fim !== null && $inicio > $fim) {
            $pendencias[] = "PERIODO_{$tipo}_INVERTIDO";
            $inicio = null;
            $fim = null;
        }

        return [
            'data_inicio' => $inicio?->format('Y-m-d'),
            'data_fim' => $fim?->format('Y-m-d'),
            'prazo_inicio_texto' => $inicioBruto !== '' ? $inicioBruto : null,
            'prazo_fim_texto' => $fimBruto !== '' ? $fimBruto : null,
        ];
    }

    /** @param array<int, string> $pendencias */
    private function normalizarData(string $valor, string $tipo, string $extremo, array &$pendencias): ?DateTimeImmutable
    {
        if ($valor === '') {
            return null;
        }

        $normalizado = mb_strtolower(trim($valor));
        if (in_array($normalizado, ['imediato', 'não há', 'nao ha', 'inaplicável', 'inaplicavel'], true)) {
            return null;
        }

        if (str_contains($valor, ';') || preg_match_all('/\d{2}\/\d{2}\/\d{4}/', $valor) > 1) {
            $pendencias[] = "DATA_{$tipo}_MULTIPLA";

            return null;
        }

        $data = DateTimeImmutable::createFromFormat('!d/m/Y', $valor);
        $erros = DateTimeImmutable::getLastErrors();
        if (! $data || ($erros !== false && ($erros['warning_count'] > 0 || $erros['error_count'] > 0))) {
            $pendencias[] = "DATA_{$tipo}_INVALIDA";

            return null;
        }

        return $data;
    }

    /** @return array<string, mixed> */
    private function lerContexto(Worksheet $aba): array
    {
        $campos = [
            'objeto' => 3,
            'area' => 4,
            'unidade' => 5,
            'principais_resultados' => 6,
            'macroprocesso' => 7,
            'objetivo' => 8,
            'leis_regulamentos' => 9,
            'recursos_tecnologicos' => 10,
        ];
        $contexto = [];
        foreach ($campos as $campo => $linha) {
            $contexto[$campo] = $this->texto($aba, 'B', $linha);
        }

        $swot = [];
        foreach ([
            'FORCA' => range(15, 18),
            'FRAQUEZA' => range(20, 23),
            'OPORTUNIDADE' => range(26, 29),
            'AMEACA' => range(31, 34),
        ] as $tipo => $linhas) {
            foreach ($linhas as $ordem => $linha) {
                $swot[] = [
                    'tipo' => $tipo,
                    'ordem' => $ordem + 1,
                    'descricao' => $this->texto($aba, 'B', $linha),
                ];
            }
        }
        $contexto['swot'] = $swot;

        return $contexto;
    }

    /** @return array<string, string|null> */
    private function linhaComoArray(Worksheet $aba, int $linha, int $ultimaColuna): array
    {
        $dados = [];
        for ($coluna = 1; $coluna <= $ultimaColuna; $coluna++) {
            $letra = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($coluna);
            $valor = $this->texto($aba, $letra, $linha);
            $dados[$letra] = $valor !== '' ? $valor : null;
        }

        return $dados;
    }

    private function texto(Worksheet $aba, string $coluna, int $linha): string
    {
        try {
            $valor = (string) $aba->getCell($coluna.$linha)->getFormattedValue();
        } catch (Throwable $e) {
            throw new RuntimeException(
                "Não foi possível ler {$aba->getTitle()}!{$coluna}{$linha}.",
                previous: $e
            );
        }

        return trim(preg_replace('/\R/u', "\n", $valor) ?? $valor);
    }

    private function textoOuNulo(Worksheet $aba, string $coluna, int $linha): ?string
    {
        $valor = $this->texto($aba, $coluna, $linha);

        return $valor !== '' ? $valor : null;
    }

    private function numeroOuNulo(string $valor): ?float
    {
        if ($valor === '') {
            return null;
        }

        $normalizado = str_replace(',', '.', $valor);

        return is_numeric($normalizado) ? (float) $normalizado : null;
    }
}
```
</APP_SERVICES_RISCOS_RISCOPLANILHAPARSER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Riscos/RiscoResponsavelService.php`
## <APP_SERVICES_RISCOS_RISCORESPONSAVELSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Riscos/RiscoResponsavelService.php`
- **Namespace Declaração:** `App\Services\Riscos`
- **Entidade / Classe:** `class RiscoResponsavelService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function normalizar(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Riscos;

use RuntimeException;

class RiscoResponsavelService
{
    /** @return array{unidade_responsavel_id: ?int, grupo_responsavel_id: ?int} */
    public function normalizar(
        ?string $referencia,
        bool $responsavelInformado,
        bool $podeGerenciarGrupo,
        ?int $unidadeAtual = null,
        ?int $grupoAtual = null
    ): array {
        if (! $responsavelInformado) {
            return [
                'unidade_responsavel_id' => $unidadeAtual,
                'grupo_responsavel_id' => $grupoAtual,
            ];
        }

        if ($grupoAtual !== null && ! $podeGerenciarGrupo) {
            throw new RuntimeException('Somente PLANELEITO_ADMIN pode alterar o grupo responsável.');
        }

        $referencia = trim((string) $referencia);
        if ($referencia === '') {
            return [
                'unidade_responsavel_id' => null,
                'grupo_responsavel_id' => null,
            ];
        }

        if (preg_match('/\A(UNIDADE|GRUPO):([1-9][0-9]*)\z/', $referencia, $partes) !== 1) {
            throw new RuntimeException('Responsável informado é inválido.');
        }

        $id = (int) $partes[2];
        if ($partes[1] === 'GRUPO') {
            if (! $podeGerenciarGrupo) {
                throw new RuntimeException('Somente PLANELEITO_ADMIN pode atribuir um grupo responsável.');
            }

            return [
                'unidade_responsavel_id' => null,
                'grupo_responsavel_id' => $id,
            ];
        }

        return [
            'unidade_responsavel_id' => $id,
            'grupo_responsavel_id' => null,
        ];
    }
}
```
</APP_SERVICES_RISCOS_RISCORESPONSAVELSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Riscos/CodigoRiscoManual.php`
## <APP_SUPPORT_RISCOS_CODIGORISCOMANUAL_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Riscos/CodigoRiscoManual.php`
- **Namespace Declaração:** `App\Support\Riscos`
- **Entidade / Classe:** `final class CodigoRiscoManual`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function novo(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Riscos;

final class CodigoRiscoManual
{
    public static function novo(): string
    {
        return 'M-'.strtoupper(bin2hex(random_bytes(9)));
    }
}
```
</APP_SUPPORT_RISCOS_CODIGORISCOMANUAL_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_25_120000_create_risco_dominios.php`
## <DATABASE_MIGRATIONS_2026_07_25_120000_CREATE_RISCO_DOMINIOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_25_120000_create_risco_dominios.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('risco_categoria')->insert($this->comDatas([
DB::table('risco_probabilidade')->insert($this->comDatas([
DB::table('risco_impacto')->insert($this->comDatas([
DB::table('risco_nivel')->insert($this->comDatas([
DB::table('risco_apetite')->insert($this->comDatas([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function semearDominios(): void
private function comDatas(array $linhas, mixed $agora): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE risco_categoria (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    descricao VARCHAR2(1000 CHAR),
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_categoria_codigo UNIQUE (codigo),
    CONSTRAINT ck_risco_categoria_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_probabilidade (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    pontuacao NUMBER(1) NOT NULL,
    descricao VARCHAR2(1000 CHAR),
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_prob_codigo UNIQUE (codigo),
    CONSTRAINT uk_risco_prob_pontos UNIQUE (pontuacao),
    CONSTRAINT ck_risco_prob_pontos CHECK (pontuacao BETWEEN 1 AND 5),
    CONSTRAINT ck_risco_prob_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_impacto (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    pontuacao NUMBER(1) NOT NULL,
    descricao VARCHAR2(1000 CHAR),
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_impacto_codigo UNIQUE (codigo),
    CONSTRAINT uk_risco_impacto_pontos UNIQUE (pontuacao),
    CONSTRAINT ck_risco_impacto_pontos CHECK (pontuacao BETWEEN 1 AND 5),
    CONSTRAINT ck_risco_impacto_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_nivel (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    valor_minimo NUMBER(8,4),
    valor_maximo NUMBER(8,4),
    cor VARCHAR2(20 CHAR),
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_nivel_codigo UNIQUE (codigo),
    CONSTRAINT ck_risco_nivel_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_apetite (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(50 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    nivel_codigo VARCHAR2(40 CHAR) NOT NULL,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_apetite_codigo UNIQUE (codigo),
    CONSTRAINT uk_risco_apetite_nivel UNIQUE (nivel_codigo),
    CONSTRAINT ck_risco_apetite_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_classificacao_controle (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(500 CHAR) NOT NULL,
    fator NUMBER(4,2) NOT NULL,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_clas_ctrl_codigo UNIQUE (codigo),
    CONSTRAINT uk_risco_clas_ctrl_fator UNIQUE (fator),
    CONSTRAINT ck_risco_clas_ctrl_fator CHECK (fator BETWEEN 0 AND 1),
    CONSTRAINT ck_risco_clas_ctrl_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_resposta (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_resposta_codigo UNIQUE (codigo),
    CONSTRAINT ck_risco_resposta_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_status (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    encerrado NUMBER(1) DEFAULT 0 NOT NULL,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_status_codigo UNIQUE (codigo),
    CONSTRAINT ck_risco_status_flags CHECK (encerrado IN (0, 1) AND ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_acao_status (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    finalizado NUMBER(1) DEFAULT 0 NOT NULL,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_acao_status_codigo UNIQUE (codigo),
    CONSTRAINT ck_risco_acao_status_flags CHECK (finalizado IN (0, 1) AND ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_swot_tipo (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo VARCHAR2(40 CHAR) NOT NULL,
    nome VARCHAR2(160 CHAR) NOT NULL,
    ambiente VARCHAR2(20 CHAR) NOT NULL,
    favoravel NUMBER(1) NOT NULL,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_swot_tipo_codigo UNIQUE (codigo),
    CONSTRAINT ck_risco_swot_ambiente CHECK (ambiente IN ('INTERNO', 'EXTERNO')),
    CONSTRAINT ck_risco_swot_flags CHECK (favoravel IN (0, 1) AND ativo IN (0, 1))
)
SQL);

        $this->semearDominios();
    }

    public function down(): void
    {
        foreach ([
            'risco_swot_tipo',
            'risco_acao_status',
            'risco_status',
            'risco_resposta',
            'risco_classificacao_controle',
            'risco_apetite',
            'risco_nivel',
            'risco_impacto',
            'risco_probabilidade',
            'risco_categoria',
        ] as $tabela) {
            DB::statement("DROP TABLE {$tabela}");
        }
    }

    private function semearDominios(): void
    {
        $agora = DB::raw('SYSDATE');

        DB::table('risco_categoria')->insert($this->comDatas([
            ['codigo' => 'ESTRATEGICO', 'nome' => 'Estratégico', 'ordem' => 1],
            ['codigo' => 'OPERACIONAL', 'nome' => 'Operacional', 'ordem' => 2],
            ['codigo' => 'ORCAMENTARIO', 'nome' => 'Orçamentário', 'ordem' => 3],
            ['codigo' => 'REPUTACAO', 'nome' => 'Reputação', 'ordem' => 4],
            ['codigo' => 'INTEGRIDADE', 'nome' => 'Integridade', 'ordem' => 5],
            ['codigo' => 'CONFORMIDADE', 'nome' => 'Conformidade', 'ordem' => 6],
        ], $agora));

        DB::table('risco_probabilidade')->insert($this->comDatas([
            ['codigo' => 'RARA', 'nome' => 'Rara', 'pontuacao' => 1, 'ordem' => 1],
            ['codigo' => 'IMPROVAVEL', 'nome' => 'Improvável', 'pontuacao' => 2, 'ordem' => 2],
            ['codigo' => 'POSSIVEL', 'nome' => 'Possível', 'pontuacao' => 3, 'ordem' => 3],
            ['codigo' => 'PROVAVEL', 'nome' => 'Provável', 'pontuacao' => 4, 'ordem' => 4],
            ['codigo' => 'QUASE_CERTO', 'nome' => 'Quase certo', 'pontuacao' => 5, 'ordem' => 5],
        ], $agora));

        DB::table('risco_impacto')->insert($this->comDatas([
            ['codigo' => 'INSIGNIFICANTE', 'nome' => 'Insignificante', 'pontuacao' => 1, 'ordem' => 1],
            ['codigo' => 'PEQUENO', 'nome' => 'Pequeno', 'pontuacao' => 2, 'ordem' => 2],
            ['codigo' => 'MODERADO', 'nome' => 'Moderado', 'pontuacao' => 3, 'ordem' => 3],
            ['codigo' => 'GRANDE', 'nome' => 'Grande', 'pontuacao' => 4, 'ordem' => 4],
            ['codigo' => 'CATASTROFICO', 'nome' => 'Catastrófico', 'pontuacao' => 5, 'ordem' => 5],
        ], $agora));

        DB::table('risco_nivel')->insert($this->comDatas([
            ['codigo' => 'SEM_RISCO', 'nome' => 'Não há risco', 'valor_minimo' => 0, 'valor_maximo' => 1, 'cor' => '#6c757d', 'ordem' => 1],
            ['codigo' => 'BAIXO', 'nome' => 'Baixo', 'valor_minimo' => 1.0001, 'valor_maximo' => 2, 'cor' => '#198754', 'ordem' => 2],
            ['codigo' => 'MEDIO', 'nome' => 'Médio', 'valor_minimo' => 2.0001, 'valor_maximo' => 6, 'cor' => '#ffc107', 'ordem' => 3],
            ['codigo' => 'ALTO', 'nome' => 'Alto', 'valor_minimo' => 6.0001, 'valor_maximo' => 14.9999, 'cor' => '#fd7e14', 'ordem' => 4],
            ['codigo' => 'EXTREMO', 'nome' => 'Extremo', 'valor_minimo' => 15, 'valor_maximo' => null, 'cor' => '#dc3545', 'ordem' => 5],
        ], $agora));

        DB::table('risco_apetite')->insert($this->comDatas([
            ['codigo' => 'NAO_HA', 'nome' => 'Não há', 'nivel_codigo' => 'SEM_RISCO', 'ordem' => 1],
            ['codigo' => 'OPORTUNIDADE', 'nome' => 'Oportunidade', 'nivel_codigo' => 'BAIXO', 'ordem' => 2],
            ['codigo' => 'ACEITAVEL', 'nome' => 'Aceitável', 'nivel_codigo' => 'MEDIO', 'ordem' => 3],
            ['codigo' => 'INACEITAVEL', 'nome' => 'Inaceitável', 'nivel_codigo' => 'ALTO', 'ordem' => 4],
            ['codigo' => 'ABSOLUTAMENTE_INACEITAVEL', 'nome' => 'Absolutamente inaceitável', 'nivel_codigo' => 'EXTREMO', 'ordem' => 5],
        ], $agora));

        DB::table('risco_classificacao_controle')->insert($this->comDatas([
            ['codigo' => 'INEXISTENTE', 'nome' => 'Não há controle', 'fator' => 1.00, 'ordem' => 1],
            ['codigo' => 'FRACO', 'nome' => 'Controle informal', 'fator' => 0.80, 'ordem' => 2],
            ['codigo' => 'MEDIANO', 'nome' => 'Controle não planejado', 'fator' => 0.60, 'ordem' => 3],
            ['codigo' => 'SATISFATORIO', 'nome' => 'Controle planejado e documentado', 'fator' => 0.40, 'ordem' => 4],
            ['codigo' => 'FORTE', 'nome' => 'Controle planejado, discutido, testado e documentado com correções ou aperfeiçoamentos planejados', 'fator' => 0.20, 'ordem' => 5],
        ], $agora));

        DB::table('risco_resposta')->insert($this->comDatas([
            ['codigo' => 'ACEITAR', 'nome' => 'Aceitar', 'ordem' => 1],
            ['codigo' => 'MITIGAR', 'nome' => 'Mitigar', 'ordem' => 2],
            ['codigo' => 'EVITAR', 'nome' => 'Evitar', 'ordem' => 3],
            ['codigo' => 'TRANSFERIR', 'nome' => 'Transferir', 'ordem' => 4],
            ['codigo' => 'ELIMINAR', 'nome' => 'Eliminar', 'ordem' => 5],
            ['codigo' => 'ALAVANCAR', 'nome' => 'Alavancar', 'ordem' => 6],
        ], $agora));

        DB::table('risco_status')->insert($this->comDatas([
            ['codigo' => 'ABERTO', 'nome' => 'Aberto', 'encerrado' => 0, 'ordem' => 1],
            ['codigo' => 'EM_TRATAMENTO', 'nome' => 'Em tratamento', 'encerrado' => 0, 'ordem' => 2],
            ['codigo' => 'MONITORAMENTO', 'nome' => 'Monitoramento', 'encerrado' => 0, 'ordem' => 3],
            ['codigo' => 'ENCERRADO', 'nome' => 'Encerrado', 'encerrado' => 1, 'ordem' => 4],
            ['codigo' => 'ARQUIVADO', 'nome' => 'Arquivado', 'encerrado' => 1, 'ordem' => 5],
        ], $agora));

        DB::table('risco_acao_status')->insert($this->comDatas([
            ['codigo' => 'NAO_INICIADA', 'nome' => 'Não iniciada', 'finalizado' => 0, 'ordem' => 1],
            ['codigo' => 'EM_ANDAMENTO', 'nome' => 'Em andamento', 'finalizado' => 0, 'ordem' => 2],
            ['codigo' => 'ATRASADA', 'nome' => 'Atrasada', 'finalizado' => 0, 'ordem' => 3],
            ['codigo' => 'CONCLUIDA', 'nome' => 'Concluída', 'finalizado' => 1, 'ordem' => 4],
            ['codigo' => 'CANCELADA', 'nome' => 'Cancelada', 'finalizado' => 1, 'ordem' => 5],
        ], $agora));

        DB::table('risco_swot_tipo')->insert($this->comDatas([
            ['codigo' => 'FORCA', 'nome' => 'Força', 'ambiente' => 'INTERNO', 'favoravel' => 1, 'ordem' => 1],
            ['codigo' => 'FRAQUEZA', 'nome' => 'Fraqueza', 'ambiente' => 'INTERNO', 'favoravel' => 0, 'ordem' => 2],
            ['codigo' => 'OPORTUNIDADE', 'nome' => 'Oportunidade', 'ambiente' => 'EXTERNO', 'favoravel' => 1, 'ordem' => 3],
            ['codigo' => 'AMEACA', 'nome' => 'Ameaça', 'ambiente' => 'EXTERNO', 'favoravel' => 0, 'ordem' => 4],
        ], $agora));
    }

    /** @param array<int, array<string, mixed>> $linhas */
    private function comDatas(array $linhas, mixed $agora): array
    {
        return array_map(static fn (array $linha): array => $linha + [
            'ativo' => 1,
            'dt_criacao' => $agora,
        ], $linhas);
    }
};
```
</DATABASE_MIGRATIONS_2026_07_25_120000_CREATE_RISCO_DOMINIOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_25_120100_extend_risco_ciclo.php`
## <DATABASE_MIGRATIONS_2026_07_25_120100_EXTEND_RISCO_CICLO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_25_120100_extend_risco_ciclo.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function migrarLegado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement('ALTER TABLE risco MODIFY (titulo VARCHAR2(500 CHAR))');
        DB::statement(<<<'SQL'
ALTER TABLE risco ADD (
    macroprojeto_id NUMBER,
    codigo_externo VARCHAR2(20 CHAR),
    origem VARCHAR2(20 CHAR) DEFAULT 'MANUAL' NOT NULL,
    causas CLOB,
    consequencias CLOB,
    unidade_gestora_id NUMBER,
    area_impactada_original VARCHAR2(1000 CHAR),
    probabilidade_id NUMBER,
    impacto_id NUMBER,
    nivel_inerente_id NUMBER,
    nivel_residual_id NUMBER,
    apetite_id NUMBER,
    categoria_id NUMBER,
    resposta_id NUMBER,
    status_risco_id NUMBER,
    risco_integridade_codigo VARCHAR2(20 CHAR),
    valor_inerente NUMBER(8,4),
    fator_controle_medio NUMBER(8,6),
    valor_residual NUMBER(8,4),
    arquivado NUMBER(1) DEFAULT 0 NOT NULL,
    arquivado_em DATE,
    arquivado_por VARCHAR2(160 CHAR),
    motivo_arquivamento VARCHAR2(1000 CHAR),
    usuario_criacao VARCHAR2(160 CHAR),
    usuario_atualizacao VARCHAR2(160 CHAR)
)
SQL);

        DB::statement('ALTER TABLE risco ADD CONSTRAINT uk_risco_macro_codigo UNIQUE (macroprojeto_id, codigo_externo)');
        DB::statement("ALTER TABLE risco ADD CONSTRAINT ck_risco_origem CHECK (origem IN ('MANUAL', 'IMPORTACAO'))");
        DB::statement('ALTER TABLE risco ADD CONSTRAINT ck_risco_arquivado CHECK (arquivado IN (0, 1))');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_macro FOREIGN KEY (macroprojeto_id) REFERENCES macroprojeto (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_prob FOREIGN KEY (probabilidade_id) REFERENCES risco_probabilidade (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_impacto FOREIGN KEY (impacto_id) REFERENCES risco_impacto (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_niv_iner FOREIGN KEY (nivel_inerente_id) REFERENCES risco_nivel (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_niv_res FOREIGN KEY (nivel_residual_id) REFERENCES risco_nivel (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_apetite FOREIGN KEY (apetite_id) REFERENCES risco_apetite (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_categoria FOREIGN KEY (categoria_id) REFERENCES risco_categoria (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_resposta FOREIGN KEY (resposta_id) REFERENCES risco_resposta (id)');
        DB::statement('ALTER TABLE risco ADD CONSTRAINT fk_risco_status FOREIGN KEY (status_risco_id) REFERENCES risco_status (id)');

        DB::statement('CREATE INDEX ix_risco_macro ON risco (macroprojeto_id)');
        DB::statement('CREATE INDEX ix_risco_unid_gest ON risco (unidade_gestora_id)');
        DB::statement('CREATE INDEX ix_risco_nivel_iner ON risco (nivel_inerente_id)');
        DB::statement('CREATE INDEX ix_risco_nivel_res ON risco (nivel_residual_id)');
        DB::statement('CREATE INDEX ix_risco_status_dom ON risco (status_risco_id)');

        $this->migrarLegado();
    }

    public function down(): void
    {
        foreach ([
            'ix_risco_status_dom',
            'ix_risco_nivel_res',
            'ix_risco_nivel_iner',
            'ix_risco_unid_gest',
            'ix_risco_macro',
        ] as $indice) {
            DB::statement("DROP INDEX {$indice}");
        }

        foreach ([
            'fk_risco_status',
            'fk_risco_resposta',
            'fk_risco_categoria',
            'fk_risco_apetite',
            'fk_risco_niv_res',
            'fk_risco_niv_iner',
            'fk_risco_impacto',
            'fk_risco_prob',
            'fk_risco_macro',
            'ck_risco_arquivado',
            'ck_risco_origem',
            'uk_risco_macro_codigo',
        ] as $restricao) {
            DB::statement("ALTER TABLE risco DROP CONSTRAINT {$restricao}");
        }

        DB::statement(<<<'SQL'
ALTER TABLE risco DROP (
    macroprojeto_id, codigo_externo, origem, causas, consequencias,
    unidade_gestora_id, area_impactada_original, probabilidade_id, impacto_id,
    nivel_inerente_id, nivel_residual_id, apetite_id, categoria_id, resposta_id,
    status_risco_id, risco_integridade_codigo, valor_inerente,
    fator_controle_medio, valor_residual, arquivado, arquivado_em,
    arquivado_por, motivo_arquivamento, usuario_criacao, usuario_atualizacao
)
SQL);
        DB::statement('ALTER TABLE risco MODIFY (titulo VARCHAR2(150 CHAR))');
    }

    private function migrarLegado(): void
    {
        DB::statement(<<<'SQL'
UPDATE risco r
SET r.macroprojeto_id = (
    SELECT MIN(COALESCE(p.macroprojeto_id, ps.macroprojeto_id, pt.macroprojeto_id))
    FROM risco_alvo ra
    LEFT JOIN projeto p ON p.id = ra.projeto_id
    LEFT JOIN subprojeto s ON s.id = ra.subprojeto_id
    LEFT JOIN projeto ps ON ps.id = s.projeto_id
    LEFT JOIN tarefa t ON t.id = ra.tarefa_id
    LEFT JOIN subprojeto st ON st.id = t.subprojeto_id
    LEFT JOIN projeto pt ON pt.id = st.projeto_id
    WHERE ra.risco_id = r.id
)
WHERE r.macroprojeto_id IS NULL
SQL);

        DB::statement(<<<'SQL'
UPDATE risco
SET origem = 'MANUAL',
    unidade_gestora_id = unidade_id,
    status_risco_id = (SELECT id FROM risco_status WHERE codigo = 'ABERTO'),
    usuario_criacao = 'MIGRACAO_RISCO_3683109'
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_07_25_120100_EXTEND_RISCO_CICLO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_25_120200_create_risco_ciclo_tables.php`
## <DATABASE_MIGRATIONS_2026_07_25_120200_CREATE_RISCO_CICLO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_25_120200_create_risco_ciclo_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE risco_contexto (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    macroprojeto_id NUMBER NOT NULL,
    objeto CLOB,
    area CLOB,
    unidade CLOB,
    principais_resultados CLOB,
    macroprocesso CLOB,
    objetivo CLOB,
    leis_regulamentos CLOB,
    recursos_tecnologicos CLOB,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_atualizacao VARCHAR2(160 CHAR),
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_contexto_macro UNIQUE (macroprojeto_id),
    CONSTRAINT fk_risco_contexto_macro FOREIGN KEY (macroprojeto_id) REFERENCES macroprojeto (id)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_contexto_swot (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    contexto_id NUMBER NOT NULL,
    tipo_id NUMBER NOT NULL,
    descricao CLOB NOT NULL,
    ordem NUMBER DEFAULT 0 NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_atualizacao VARCHAR2(160 CHAR),
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT fk_risco_ctx_swot_ctx FOREIGN KEY (contexto_id) REFERENCES risco_contexto (id),
    CONSTRAINT fk_risco_ctx_swot_tipo FOREIGN KEY (tipo_id) REFERENCES risco_swot_tipo (id)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_unidade_impactada (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    unidade_id NUMBER NOT NULL,
    origem VARCHAR2(20 CHAR) DEFAULT 'MANUAL' NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT uk_risco_unid_impact UNIQUE (risco_id, unidade_id),
    CONSTRAINT fk_risco_unid_impact FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT ck_risco_unid_origem CHECK (origem IN ('MANUAL', 'IMPORTACAO', 'GRUPO'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_grupo_impactado (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    grupo_unidade_id NUMBER NOT NULL,
    origem VARCHAR2(20 CHAR) DEFAULT 'MANUAL' NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT uk_risco_grupo_impact UNIQUE (risco_id, grupo_unidade_id),
    CONSTRAINT fk_risco_grupo_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT fk_risco_grupo_grupo FOREIGN KEY (grupo_unidade_id) REFERENCES grupo_unidade (id),
    CONSTRAINT ck_risco_grupo_origem CHECK (origem IN ('MANUAL', 'IMPORTACAO'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_controle (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    codigo_externo VARCHAR2(30 CHAR),
    descricao CLOB,
    classificacao_id NUMBER,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_atualizacao VARCHAR2(160 CHAR),
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_ctrl_codigo UNIQUE (risco_id, codigo_externo),
    CONSTRAINT fk_risco_ctrl_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT fk_risco_ctrl_class FOREIGN KEY (classificacao_id) REFERENCES risco_classificacao_controle (id),
    CONSTRAINT ck_risco_ctrl_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_tratamento (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    codigo_externo VARCHAR2(30 CHAR),
    resposta_id NUMBER,
    status_id NUMBER NOT NULL,
    descricao CLOB NOT NULL,
    responsavel_original VARCHAR2(1000 CHAR),
    unidade_responsavel_id NUMBER,
    data_inicio DATE,
    data_fim DATE,
    prazo_inicio_texto VARCHAR2(500 CHAR),
    prazo_fim_texto VARCHAR2(500 CHAR),
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_atualizacao VARCHAR2(160 CHAR),
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT uk_risco_trat_codigo UNIQUE (risco_id, codigo_externo),
    CONSTRAINT fk_risco_trat_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT fk_risco_trat_resp FOREIGN KEY (resposta_id) REFERENCES risco_resposta (id),
    CONSTRAINT fk_risco_trat_status FOREIGN KEY (status_id) REFERENCES risco_acao_status (id),
    CONSTRAINT ck_risco_trat_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_contingencia (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    status_id NUMBER NOT NULL,
    descricao CLOB NOT NULL,
    responsavel_original VARCHAR2(1000 CHAR),
    unidade_responsavel_id NUMBER,
    data_inicio DATE,
    data_fim DATE,
    prazo_inicio_texto VARCHAR2(500 CHAR),
    prazo_fim_texto VARCHAR2(500 CHAR),
    recursos_necessarios CLOB,
    resultado_obtido CLOB,
    observacoes CLOB,
    ativo NUMBER(1) DEFAULT 1 NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_atualizacao VARCHAR2(160 CHAR),
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT fk_risco_conting_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT fk_risco_conting_status FOREIGN KEY (status_id) REFERENCES risco_acao_status (id),
    CONSTRAINT ck_risco_conting_ativo CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_acao_tarefa (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tratamento_id NUMBER,
    contingencia_id NUMBER,
    tarefa_id NUMBER NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_risco_ac_tarefa_trat FOREIGN KEY (tratamento_id) REFERENCES risco_tratamento (id),
    CONSTRAINT fk_risco_ac_tarefa_cont FOREIGN KEY (contingencia_id) REFERENCES risco_contingencia (id),
    CONSTRAINT fk_risco_ac_tarefa_tar FOREIGN KEY (tarefa_id) REFERENCES tarefa (id),
    CONSTRAINT ck_risco_ac_tarefa_pai CHECK (
        (tratamento_id IS NOT NULL AND contingencia_id IS NULL)
        OR (tratamento_id IS NULL AND contingencia_id IS NOT NULL)
    )
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_monitoramento (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    data_monitoramento DATE NOT NULL,
    status_risco_id NUMBER,
    descricao CLOB NOT NULL,
    resultado CLOB,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_risco_monitor_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT fk_risco_monitor_status FOREIGN KEY (status_risco_id) REFERENCES risco_status (id)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_comunicacao (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    risco_id NUMBER NOT NULL,
    data_comunicacao DATE NOT NULL,
    tipo VARCHAR2(100 CHAR),
    destinatarios CLOB,
    descricao CLOB NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_risco_comun_risco FOREIGN KEY (risco_id) REFERENCES risco (id)
)
SQL);

        foreach ([
            'CREATE INDEX ix_risco_ctx_swot_ctx ON risco_contexto_swot (contexto_id)',
            'CREATE INDEX ix_risco_unid_unidade ON risco_unidade_impactada (unidade_id)',
            'CREATE INDEX ix_risco_grupo_grupo ON risco_grupo_impactado (grupo_unidade_id)',
            'CREATE INDEX ix_risco_ctrl_risco ON risco_controle (risco_id)',
            'CREATE INDEX ix_risco_trat_risco ON risco_tratamento (risco_id)',
            'CREATE INDEX ix_risco_conting_risco ON risco_contingencia (risco_id)',
            'CREATE INDEX ix_risco_actar_tarefa ON risco_acao_tarefa (tarefa_id)',
            'CREATE INDEX ix_risco_monitor_risco ON risco_monitoramento (risco_id)',
            'CREATE INDEX ix_risco_comun_risco ON risco_comunicacao (risco_id)',
        ] as $sql) {
            DB::statement($sql);
        }
    }

    public function down(): void
    {
        foreach ([
            'risco_comunicacao',
            'risco_monitoramento',
            'risco_acao_tarefa',
            'risco_contingencia',
            'risco_tratamento',
            'risco_controle',
            'risco_grupo_impactado',
            'risco_unidade_impactada',
            'risco_contexto_swot',
            'risco_contexto',
        ] as $tabela) {
            DB::statement("DROP TABLE {$tabela}");
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_07_25_120200_CREATE_RISCO_CICLO_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_25_120300_create_risco_importacao_tables.php`
## <DATABASE_MIGRATIONS_2026_07_25_120300_CREATE_RISCO_IMPORTACAO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_25_120300_create_risco_importacao_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE risco_importacao_lote (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    macroprojeto_id NUMBER NOT NULL,
    nome_arquivo VARCHAR2(500 CHAR) NOT NULL,
    hash_sha256 VARCHAR2(64 CHAR) NOT NULL,
    status VARCHAR2(30 CHAR) NOT NULL,
    total_itens NUMBER DEFAULT 0 NOT NULL,
    total_erros NUMBER DEFAULT 0 NOT NULL,
    total_avisos NUMBER DEFAULT 0 NOT NULL,
    resumo CLOB,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_aplicacao VARCHAR2(160 CHAR),
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_aplicacao DATE,
    CONSTRAINT uk_risco_imp_macro_hash UNIQUE (macroprojeto_id, hash_sha256),
    CONSTRAINT fk_risco_imp_lote_macro FOREIGN KEY (macroprojeto_id) REFERENCES macroprojeto (id),
    CONSTRAINT ck_risco_imp_lote_status CHECK (status IN ('PREVIA', 'APLICANDO', 'APLICADO', 'FALHA'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_importacao_item (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lote_id NUMBER NOT NULL,
    codigo_externo VARCHAR2(20 CHAR) NOT NULL,
    risco_id NUMBER,
    status VARCHAR2(30 CHAR) NOT NULL,
    payload_bruto CLOB NOT NULL,
    mensagens CLOB,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_aplicacao DATE,
    CONSTRAINT uk_risco_imp_item_codigo UNIQUE (lote_id, codigo_externo),
    CONSTRAINT fk_risco_imp_item_lote FOREIGN KEY (lote_id) REFERENCES risco_importacao_lote (id),
    CONSTRAINT fk_risco_imp_item_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT ck_risco_imp_item_status CHECK (status IN ('VALIDO', 'AVISO', 'ERRO', 'APLICADO'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE risco_pendencia (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lote_id NUMBER,
    item_id NUMBER,
    risco_id NUMBER NOT NULL,
    codigo VARCHAR2(80 CHAR) NOT NULL,
    descricao VARCHAR2(2000 CHAR) NOT NULL,
    payload_bruto CLOB,
    status VARCHAR2(30 CHAR) DEFAULT 'ABERTA' NOT NULL,
    usuario_criacao VARCHAR2(160 CHAR) NOT NULL,
    usuario_resolucao VARCHAR2(160 CHAR),
    resolucao CLOB,
    dt_criacao DATE DEFAULT SYSDATE NOT NULL,
    dt_resolucao DATE,
    CONSTRAINT fk_risco_pend_lote FOREIGN KEY (lote_id) REFERENCES risco_importacao_lote (id),
    CONSTRAINT fk_risco_pend_item FOREIGN KEY (item_id) REFERENCES risco_importacao_item (id),
    CONSTRAINT fk_risco_pend_risco FOREIGN KEY (risco_id) REFERENCES risco (id),
    CONSTRAINT ck_risco_pend_status CHECK (status IN ('ABERTA', 'RESOLVIDA', 'DESCARTADA'))
)
SQL);

        DB::statement('CREATE INDEX ix_risco_imp_item_risco ON risco_importacao_item (risco_id)');
        DB::statement('CREATE INDEX ix_risco_pend_risco ON risco_pendencia (risco_id, status)');
        DB::statement('CREATE INDEX ix_risco_pend_lote ON risco_pendencia (lote_id)');

        DB::statement(<<<'SQL'
INSERT INTO risco_pendencia (
    risco_id, codigo, descricao, status, usuario_criacao, dt_criacao
)
SELECT r.id,
       'RECLASSIFICAR_ESCALA_MANUAL',
       'Reclassificar probabilidade e impacto do risco manual para a escala oficial de 1 a 5.',
       'ABERTA',
       'MIGRACAO_RISCO_3683109',
       SYSDATE
FROM risco r
WHERE r.origem = 'MANUAL'
  AND NOT EXISTS (
      SELECT 1
      FROM risco_pendencia rp
      WHERE rp.risco_id = r.id
        AND rp.codigo = 'RECLASSIFICAR_ESCALA_MANUAL'
        AND rp.status = 'ABERTA'
  )
SQL);
    }

    public function down(): void
    {
        DB::statement('DROP TABLE risco_pendencia');
        DB::statement('DROP TABLE risco_importacao_item');
        DB::statement('DROP TABLE risco_importacao_lote');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_25_120300_CREATE_RISCO_IMPORTACAO_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_25_120600_link_risco_import_pending_items.php`
## <DATABASE_MIGRATIONS_2026_07_25_120600_LINK_RISCO_IMPORT_PENDING_ITEMS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_25_120600_link_risco_import_pending_items.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement(<<<'SQL'
UPDATE risco_pendencia rp
SET (rp.lote_id, rp.item_id) = (
    SELECT rii.lote_id, rii.id
    FROM risco_importacao_item rii
    WHERE rii.risco_id = rp.risco_id
)
WHERE rp.lote_id IS NULL
  AND rp.item_id IS NULL
  AND EXISTS (
      SELECT 1
      FROM risco r
      JOIN risco_importacao_item rii ON rii.risco_id = r.id
      WHERE r.id = rp.risco_id
        AND r.origem = 'IMPORTACAO'
  )
SQL);
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
UPDATE risco_pendencia rp
SET rp.lote_id = NULL,
    rp.item_id = NULL
WHERE EXISTS (
    SELECT 1
    FROM risco r
    WHERE r.id = rp.risco_id
      AND r.origem = 'IMPORTACAO'
)
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_07_25_120600_LINK_RISCO_IMPORT_PENDING_ITEMS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_25_120700_align_riscos_menu_path.php`
## <DATABASE_MIGRATIONS_2026_07_25_120700_ALIGN_RISCOS_MENU_PATH_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_25_120700_align_riscos_menu_path.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('adm_acesso_rota')
DB::table('adm_acesso_rota')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    private const MENU_ATUAL = 'Planejamento > Cadastros > Riscos';

    private const MENU_ANTERIOR = 'Planejamento > Riscos';

    public function up(): void
    {
        DB::transaction(function (): void {
            DB::table('adm_acesso_rota')
                ->where('rota_nome', 'like', 'riscos.%')
                ->update([
                    'menu_path' => self::MENU_ATUAL,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]);
        });
    }

    public function down(): void
    {
        DB::transaction(function (): void {
            DB::table('adm_acesso_rota')
                ->where('rota_nome', 'like', 'riscos.%')
                ->where('menu_path', self::MENU_ATUAL)
                ->update([
                    'menu_path' => self::MENU_ANTERIOR,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]);
        });
    }
};
```
</DATABASE_MIGRATIONS_2026_07_25_120700_ALIGN_RISCOS_MENU_PATH_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_26_120000_add_grupo_responsavel_to_risco_acoes.php`
## <DATABASE_MIGRATIONS_2026_07_26_120000_ADD_GRUPO_RESPONSAVEL_TO_RISCO_ACOES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_26_120000_add_grupo_responsavel_to_risco_acoes.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('user_tab_columns')
return DB::table('user_constraints')
return DB::table('user_indexes')->where('index_name', $indice)->exists();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function colunaExiste(string $tabela, string $coluna): bool
private function constraintExiste(string $tabela, string $constraint): bool
private function indiceExiste(string $indice): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /** @var array<string, array{fk: string, check: string, index: string}> */
    private const OBJETOS = [
        'RISCO_TRATAMENTO' => [
            'fk' => 'FK_RISCO_TRAT_GRUPO_RESP',
            'check' => 'CK_RISCO_TRAT_RESP_UNICO',
            'index' => 'IX_RISCO_TRAT_GRUPO_RESP',
        ],
        'RISCO_CONTINGENCIA' => [
            'fk' => 'FK_RISCO_CONT_GRUPO_RESP',
            'check' => 'CK_RISCO_CONT_RESP_UNICO',
            'index' => 'IX_RISCO_CONT_GRUPO_RESP',
        ],
    ];

    public function up(): void
    {
        foreach (self::OBJETOS as $tabela => $objetos) {
            if (! $this->colunaExiste($tabela, 'GRUPO_RESPONSAVEL_ID')) {
                DB::statement("ALTER TABLE {$tabela} ADD (GRUPO_RESPONSAVEL_ID NUMBER)");
            }
            if (! $this->constraintExiste($tabela, $objetos['fk'])) {
                DB::statement(
                    "ALTER TABLE {$tabela} ADD CONSTRAINT {$objetos['fk']} "
                    .'FOREIGN KEY (GRUPO_RESPONSAVEL_ID) REFERENCES GRUPO_UNIDADE (ID)'
                );
            }
            if (! $this->constraintExiste($tabela, $objetos['check'])) {
                DB::statement(
                    "ALTER TABLE {$tabela} ADD CONSTRAINT {$objetos['check']} "
                    .'CHECK (UNIDADE_RESPONSAVEL_ID IS NULL OR GRUPO_RESPONSAVEL_ID IS NULL)'
                );
            }
            if (! $this->indiceExiste($objetos['index'])) {
                DB::statement("CREATE INDEX {$objetos['index']} ON {$tabela} (GRUPO_RESPONSAVEL_ID)");
            }
        }
    }

    public function down(): void
    {
        foreach (array_reverse(self::OBJETOS, true) as $tabela => $objetos) {
            if ($this->indiceExiste($objetos['index'])) {
                DB::statement("DROP INDEX {$objetos['index']}");
            }
            if ($this->constraintExiste($tabela, $objetos['check'])) {
                DB::statement("ALTER TABLE {$tabela} DROP CONSTRAINT {$objetos['check']}");
            }
            if ($this->constraintExiste($tabela, $objetos['fk'])) {
                DB::statement("ALTER TABLE {$tabela} DROP CONSTRAINT {$objetos['fk']}");
            }
            if ($this->colunaExiste($tabela, 'GRUPO_RESPONSAVEL_ID')) {
                DB::statement("ALTER TABLE {$tabela} DROP COLUMN GRUPO_RESPONSAVEL_ID");
            }
        }
    }

    private function colunaExiste(string $tabela, string $coluna): bool
    {
        return DB::table('user_tab_columns')
            ->where('table_name', $tabela)
            ->where('column_name', $coluna)
            ->exists();
    }

    private function constraintExiste(string $tabela, string $constraint): bool
    {
        return DB::table('user_constraints')
            ->where('table_name', $tabela)
            ->where('constraint_name', $constraint)
            ->exists();
    }

    private function indiceExiste(string $indice): bool
    {
        return DB::table('user_indexes')->where('index_name', $indice)->exists();
    }
};
```
</DATABASE_MIGRATIONS_2026_07_26_120000_ADD_GRUPO_RESPONSAVEL_TO_RISCO_ACOES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/RiscoAnexo3683109AcceptanceTest.php`
## <TESTS_FEATURE_RISCOANEXO3683109ACCEPTANCETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/RiscoAnexo3683109AcceptanceTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class RiscoAnexo3683109AcceptanceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->macroprojetoId = (int) DB::table('macroprojeto')
$total = DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->count();
$manuais = DB::table('risco')
$this->assertSame(108, DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->where('origem', 'IMPORTACAO')->count());
$this->assertSame(108, DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->where('origem', 'IMPORTACAO')->distinct()->count('codigo_externo'));
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_carga_preserva_manual_e_reproduz_distribuicoes_oficiais(): void
public function test_contexto_projetos_pendencias_e_associacoes_estao_reconciliados(): void
public function test_acl_distingue_operador_e_planejamento_admin_no_macroprojeto(): void
public function test_repository_fecha_escopo_vazio_e_pagina_em_vinte(): void
public function test_repository_respeita_gestora_impactada_e_nega_acesso_cruzado_por_id(): void
public function test_repository_carrega_detalhe_filhos_e_tarefas_vinculaveis_no_macroprojeto(): void
public function test_repository_da_importacao_reaplica_escopo_ao_revisar_itens_aplicados(): void
public function test_gravacao_composta_reverte_risco_e_alvos_quando_um_filho_falha(): void
public function test_vinculo_de_tarefa_invalido_reverte_acao_e_auditoria(): void
public function test_falha_da_auditoria_reverte_controle_e_recalculo_residual(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoCicloRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use App\Repositories\Riscos\Queries\RiscoEscopoQuery;
use App\Repositories\Riscos\RiscoCicloRepository;
use App\Services\Auditoria\AuditLogService;
use App\Services\PermissaoDominioService;
use App\Services\Riscos\RiscoCalculoService;
use App\Services\Riscos\RiscoResponsavelService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;
use RuntimeException;
use Tests\TestCase;

class RiscoAnexo3683109AcceptanceTest extends TestCase
{
    private int $macroprojetoId;

    private string $conexaoOriginal;

    protected function setUp(): void
    {
        parent::setUp();
        $this->conexaoOriginal = (string) config('database.default');
        config(['database.default' => 'oracle']);
        DB::purge('oracle');
        $this->macroprojetoId = (int) DB::table('macroprojeto')
            ->where('nome', 'Eleições 2026')
            ->value('id');
        $this->assertGreaterThan(0, $this->macroprojetoId);
    }

    protected function tearDown(): void
    {
        DB::disconnect('oracle');
        config(['database.default' => $this->conexaoOriginal]);
        parent::tearDown();
    }

    public function test_carga_preserva_manual_e_reproduz_distribuicoes_oficiais(): void
    {
        $total = DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->count();
        $manuais = DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('origem', 'MANUAL')
            ->count();

        $this->assertGreaterThanOrEqual(1, $manuais);
        $this->assertSame(108 + $manuais, $total);
        $this->assertSame(108, DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->where('origem', 'IMPORTACAO')->count());
        $this->assertSame(108, DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->where('origem', 'IMPORTACAO')->distinct()->count('codigo_externo'));

        $this->assertSame([
            'ALTO' => 50,
            'BAIXO' => 3,
            'EXTREMO' => 17,
            'MEDIO' => 36,
            'SEM_RISCO' => 2,
        ], $this->distribuicao('nivel_inerente_id'));
        $this->assertSame([
            'ALTO' => 9,
            'BAIXO' => 26,
            'EXTREMO' => 1,
            'MEDIO' => 54,
            'SEM_RISCO' => 17,
        ], $this->distribuicao('nivel_residual_id'));
        $this->assertSame(1, DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('origem', 'IMPORTACAO')
            ->whereNull('nivel_residual_id')
            ->count());
        $this->assertSame('R98', DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('origem', 'IMPORTACAO')
            ->whereNull('nivel_residual_id')
            ->value('codigo_externo'));
    }

    public function test_contexto_projetos_pendencias_e_associacoes_estao_reconciliados(): void
    {
        $contextoId = (int) DB::table('risco_contexto')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->value('id');
        $this->assertGreaterThan(0, $contextoId);
        $this->assertSame(16, DB::table('risco_contexto_swot')->where('contexto_id', $contextoId)->count());
        $this->assertSame(7, DB::table('risco_alvo as ra')
            ->join('risco as r', 'r.id', '=', 'ra.risco_id')
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->where('r.origem', 'IMPORTACAO')
            ->distinct()
            ->count('ra.projeto_id'));
        $this->assertSame(46, DB::table('risco_pendencia as rp')
            ->join('risco as r', 'r.id', '=', 'rp.risco_id')
            ->where('r.origem', 'IMPORTACAO')
            ->whereNotNull('rp.lote_id')
            ->whereNotNull('rp.item_id')
            ->count());
        $this->assertSame(1, DB::table('risco_pendencia as rp')
            ->join('risco as r', 'r.id', '=', 'rp.risco_id')
            ->where('r.origem', 'MANUAL')
            ->where('rp.codigo', 'RECLASSIFICAR_ESCALA_MANUAL')
            ->whereNull('rp.lote_id')
            ->count());

        foreach ([
            'risco_alvo', 'risco_unidade_impactada', 'risco_grupo_impactado',
            'risco_controle', 'risco_tratamento', 'risco_contingencia',
            'risco_monitoramento', 'risco_comunicacao', 'risco_pendencia',
        ] as $tabela) {
            $orfaos = DB::table($tabela.' as filho')
                ->leftJoin('risco as r', 'r.id', '=', 'filho.risco_id')
                ->whereNull('r.id')
                ->count();
            $this->assertSame(0, $orfaos, "Há associação órfã em {$tabela}.");
        }
    }

    public function test_acl_distingue_operador_e_planejamento_admin_no_macroprojeto(): void
    {
        $permissao = app(PermissaoDominioService::class);

        $this->assertTrue($permissao->podeExecutar('riscos.listar', $this->macroprojetoId, ['PLANELEITO_OPERADOR']));
        $this->assertTrue($permissao->podeExecutar('riscos.detalhe', $this->macroprojetoId, ['PLANELEITO_OPERADOR']));
        $this->assertFalse($permissao->podeExecutar('riscos.salvar', $this->macroprojetoId, ['PLANELEITO_OPERADOR']));
        $this->assertFalse($permissao->podeExecutar('riscos.importacoes.aplicar', $this->macroprojetoId, ['PLANELEITO_OPERADOR']));

        $this->assertTrue($permissao->podeExecutar('riscos.listar', $this->macroprojetoId, ['PLANELEITO_PLANEJAMENTO_ADMIN']));
        $this->assertTrue($permissao->podeExecutar('riscos.salvar', $this->macroprojetoId, ['PLANELEITO_PLANEJAMENTO_ADMIN']));
        $this->assertTrue($permissao->podeExecutar('riscos.importacoes.aplicar', $this->macroprojetoId, ['PLANELEITO_PLANEJAMENTO_ADMIN']));
    }

    public function test_repository_fecha_escopo_vazio_e_pagina_em_vinte(): void
    {
        $repository = app(RiscoRepositoryInterface::class);
        $this->assertSame(0, $repository->listarRiscos($this->macroprojetoId, [], [], 20)->total());

        $pagina = $repository->listarRiscos($this->macroprojetoId, null, [], 20);
        $this->assertSame(20, $pagina->perPage());
        $this->assertSame(
            DB::table('risco')
                ->where('macroprojeto_id', $this->macroprojetoId)
                ->where('arquivado', 0)
                ->count(),
            $pagina->total()
        );
        $this->assertLessThanOrEqual(20, $pagina->count());

        $paginaComArquivados = $repository->listarRiscos(
            $this->macroprojetoId,
            null,
            ['arquivado' => 'todos'],
            20
        );
        $this->assertSame(
            DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->count(),
            $paginaComArquivados->total()
        );
    }

    public function test_repository_respeita_gestora_impactada_e_nega_acesso_cruzado_por_id(): void
    {
        $repository = app(RiscoRepositoryInterface::class);
        $impactado = DB::table('risco as r')
            ->join('risco_unidade_impactada as rui', 'rui.risco_id', '=', 'r.id')
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->where('r.origem', 'IMPORTACAO')
            ->whereColumn('rui.unidade_id', '<>', 'r.unidade_gestora_id')
            ->select('r.id', 'rui.unidade_id')
            ->first();
        $this->assertNotNull($impactado);

        $unidadeImpactada = (int) $impactado->unidade_id;
        $visiveis = $repository->listarParaExportacao(
            $this->macroprojetoId,
            [$unidadeImpactada],
            ['arquivado' => 'todos']
        );
        $this->assertTrue($visiveis->contains('id', (int) $impactado->id));
        foreach ($visiveis as $risco) {
            $this->assertTrue(
                (int) $risco->unidade_gestora_id === $unidadeImpactada
                || DB::table('risco_unidade_impactada')
                    ->where('risco_id', $risco->id)
                    ->where('unidade_id', $unidadeImpactada)
                    ->exists(),
                "O risco {$risco->id} ampliou o escopo da unidade impactada."
            );
        }
        $this->assertNotNull($repository->buscarRisco(
            (int) $impactado->id,
            $this->macroprojetoId,
            [$unidadeImpactada]
        ));

        $foraDoEscopo = DB::table('risco as r')
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->where('r.unidade_gestora_id', '<>', $unidadeImpactada)
            ->whereNotExists(function ($query) use ($unidadeImpactada): void {
                $query->selectRaw('1')
                    ->from('risco_unidade_impactada as rui')
                    ->whereColumn('rui.risco_id', 'r.id')
                    ->where('rui.unidade_id', $unidadeImpactada);
            })
            ->first(['r.id']);
        $this->assertNotNull($foraDoEscopo);
        $this->assertNull($repository->buscarRisco(
            (int) $foraDoEscopo->id,
            $this->macroprojetoId,
            [$unidadeImpactada]
        ));

        $gerido = DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('origem', 'IMPORTACAO')
            ->first(['id', 'unidade_gestora_id']);
        $this->assertNotNull($gerido);
        $this->assertNotNull($repository->buscarRisco(
            (int) $gerido->id,
            $this->macroprojetoId,
            [(int) $gerido->unidade_gestora_id]
        ));
    }

    public function test_repository_carrega_detalhe_filhos_e_tarefas_vinculaveis_no_macroprojeto(): void
    {
        $repository = app(RiscoRepositoryInterface::class);
        $riscoId = $this->riscoId('R01');
        $detalhe = $repository->buscarDetalhe($riscoId, $this->macroprojetoId, null);

        $this->assertNotNull($detalhe);
        $this->assertCount(1, $detalhe['alvos']);
        $this->assertCount(1, $detalhe['controles']);
        $this->assertCount(1, $detalhe['tratamentos']);
        $this->assertCount(1, $detalhe['contingencias']);

        $tarefas = $repository->listarTarefasVinculaveisAoRisco($riscoId, $this->macroprojetoId, null);
        $this->assertNotEmpty($tarefas);
        foreach ($tarefas as $tarefa) {
            $this->assertSame($this->macroprojetoId, (int) DB::table('projeto')->where('id', $tarefa->projeto_id)->value('macroprojeto_id'));
        }
    }

    public function test_repository_da_importacao_reaplica_escopo_ao_revisar_itens_aplicados(): void
    {
        $repository = app(RiscoImportacaoRepositoryInterface::class);
        $this->assertCount(108, $repository->listarItensLote(1, $this->macroprojetoId, null, 'TESTE_GLOBAL'));
        $this->assertSame([], $repository->listarItensLote(1, $this->macroprojetoId, [], 'TESTE_SEM_ESCOPO'));

        $impactado = DB::table('risco as r')
            ->join('risco_unidade_impactada as rui', 'rui.risco_id', '=', 'r.id')
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->whereColumn('rui.unidade_id', '<>', 'r.unidade_gestora_id')
            ->first(['rui.unidade_id']);
        $this->assertNotNull($impactado);
        $unidadeId = (int) $impactado->unidade_id;
        $itens = $repository->listarItensLote(1, $this->macroprojetoId, [$unidadeId], 'TESTE_ESCOPO');
        $this->assertNotEmpty($itens);

        foreach ($itens as $item) {
            $risco = DB::table('risco')->where('id', $item->risco_id)->first(['unidade_gestora_id']);
            $this->assertNotNull($risco);
            $this->assertTrue(
                (int) $risco->unidade_gestora_id === $unidadeId
                || DB::table('risco_unidade_impactada')
                    ->where('risco_id', $item->risco_id)
                    ->where('unidade_id', $unidadeId)
                    ->exists(),
                "O item {$item->id} ampliou o escopo da revisão da importação."
            );
        }

        $unidadeFora = DB::table('vw_unidade as u')
            ->whereNotExists(function ($query): void {
                $query->selectRaw('1')
                    ->from('risco as r')
                    ->where('r.macroprojeto_id', $this->macroprojetoId)
                    ->where(function ($escopo): void {
                        $escopo->whereColumn('r.unidade_gestora_id', 'u.id_unidade')
                            ->orWhereExists(function ($impactada): void {
                                $impactada->selectRaw('1')
                                    ->from('risco_unidade_impactada as rui')
                                    ->whereColumn('rui.risco_id', 'r.id')
                                    ->whereColumn('rui.unidade_id', 'u.id_unidade');
                            });
                    });
            })
            ->value('u.id_unidade');
        $this->assertNotNull($unidadeFora);
        $lotesFora = $repository->listarLotes(
            $this->macroprojetoId,
            [(int) $unidadeFora],
            'CLI:www-data'
        );
        $this->assertNotContains(1, collect($lotesFora)->pluck('id')->map(static fn ($id): int => (int) $id)->all());
    }

    public function test_gravacao_composta_reverte_risco_e_alvos_quando_um_filho_falha(): void
    {
        $repository = app(RiscoRepositoryInterface::class);
        $riscoId = (int) DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('codigo_externo', 'R01')
            ->value('id');
        $antes = $repository->buscarRisco($riscoId, $this->macroprojetoId, null);
        $impactos = $repository->buscarImpactos($riscoId, $this->macroprojetoId, null);
        $alvos = collect($repository->buscarAlvos($riscoId, $this->macroprojetoId, null))
            ->map(static fn (object $alvo): array => array_filter([
                'projeto_id' => $alvo->projeto_id,
                'subprojeto_id' => $alvo->subprojeto_id,
                'tarefa_id' => $alvo->tarefa_id,
                'tipo' => $alvo->tipo,
            ], static fn ($valor): bool => $valor !== null))
            ->all();
        $totalAlvos = count($alvos);

        try {
            $repository->salvarComposto([
                'ID' => $riscoId,
                'TITULO' => 'TÍTULO QUE DEVE SER REVERTIDO',
                'CAUSAS' => $antes->causas,
                'CONSEQUENCIAS' => $antes->consequencias,
                'AREA_IMPACTADA_ORIGINAL' => $antes->area_impactada_original,
                'PROBABILIDADE_ID' => (int) $antes->probabilidade_id,
                'PROBABILIDADE_CODIGO' => $antes->probabilidade_codigo,
                'IMPACTO_ID' => (int) $antes->impacto_id,
                'IMPACTO_CODIGO' => $antes->impacto_codigo,
                'NIVEL_INERENTE_ID' => (int) $antes->nivel_inerente_id,
                'NIVEL_INERENTE_CODIGO' => $antes->nivel_inerente_codigo,
                'VALOR_INERENTE' => (float) $antes->valor_inerente,
                'CATEGORIA_ID' => $antes->categoria_id,
                'RESPOSTA_ID' => $antes->resposta_id,
                'STATUS_RISCO_ID' => (int) $antes->status_risco_id,
                'STATUS_CODIGO' => $antes->status_codigo,
                'RISCO_INTEGRIDADE_CODIGO' => $antes->risco_integridade_codigo,
                'UNIDADE_GESTORA_ID' => (int) $antes->unidade_gestora_id,
                'UNIDADES_IMPACTADAS' => $impactos['unidades'],
                'GRUPOS_IMPACTADOS' => [...$impactos['grupos'], 999999999],
            ], $alvos, $this->macroprojetoId, null, 'TESTE_ROLLBACK_RISCO');
            $this->fail('A inclusão de grupo inexistente deveria falhar.');
        } catch (RuntimeException $e) {
            $this->assertSame('Grupo impactado inexistente.', $e->getMessage());
        }

        $this->assertSame($antes->titulo, DB::table('risco')->where('id', $riscoId)->value('titulo'));
        $this->assertSame($totalAlvos, DB::table('risco_alvo')->where('risco_id', $riscoId)->count());
        $this->assertFalse(DB::table('risco_grupo_impactado')
            ->where('risco_id', $riscoId)
            ->where('grupo_unidade_id', 999999999)
            ->exists());
    }

    public function test_vinculo_de_tarefa_invalido_reverte_acao_e_auditoria(): void
    {
        $repository = app(RiscoCicloRepositoryInterface::class);
        $riscoId = $this->riscoId('R01');
        $statusId = (int) DB::table('risco_acao_status')->where('ativo', 1)->value('id');
        $tratamentosAntes = DB::table('risco_tratamento')->where('risco_id', $riscoId)->count();
        $vinculosAntes = DB::table('risco_acao_tarefa')->count();
        $auditoriasAntes = DB::table('auditoria_acao')->count();

        try {
            $repository->salvarTratamento($riscoId, [
                'status_id' => $statusId,
                'descricao' => 'AÇÃO TRANSACIONAL QUE NÃO PODE PERSISTIR',
                'tarefas_ids' => [999999999],
            ], $this->macroprojetoId, null, 'TESTE_ROLLBACK_TAREFA', false);
            $this->fail('A tarefa inexistente deveria invalidar toda a ação.');
        } catch (RuntimeException $e) {
            $this->assertSame('Tarefa vinculada fora do macroprojeto ou escopo efetivo.', $e->getMessage());
        }

        $this->assertSame($tratamentosAntes, DB::table('risco_tratamento')->where('risco_id', $riscoId)->count());
        $this->assertSame($vinculosAntes, DB::table('risco_acao_tarefa')->count());
        $this->assertSame($auditoriasAntes, DB::table('auditoria_acao')->count());
    }

    public function test_falha_da_auditoria_reverte_controle_e_recalculo_residual(): void
    {
        $riscoId = $this->riscoId('R01');
        $classificacaoId = (int) DB::table('risco_classificacao_controle')->where('ativo', 1)->value('id');
        $controlesAntes = DB::table('risco_controle')->where('risco_id', $riscoId)->count();
        $riscoAntes = DB::table('risco')->where('id', $riscoId)->first([
            'valor_residual', 'nivel_residual_id', 'apetite_id', 'fator_controle_medio',
        ]);
        $pendenciasAntes = DB::table('risco_pendencia')->where('risco_id', $riscoId)->count();

        $auditRepository = \Mockery::mock(AuditLogRepositoryInterface::class);
        $auditRepository->shouldReceive('inserir')
            ->atLeast()
            ->once()
            ->andThrow(new RuntimeException('FALHA_AUDITORIA_TESTE'));
        $repository = new RiscoCicloRepository(
            new AuditLogService($auditRepository),
            app(RiscoCalculoService::class),
            app(RiscoEscopoQuery::class),
            app(RiscoResponsavelService::class)
        );

        try {
            $repository->salvarControle($riscoId, [
                'descricao' => 'CONTROLE QUE DEVE SER REVERTIDO',
                'classificacao_id' => $classificacaoId,
            ], $this->macroprojetoId, null, 'TESTE_ROLLBACK_AUDITORIA');
            $this->fail('A falha de auditoria deveria reverter a gravação.');
        } catch (RuntimeException $e) {
            $this->assertSame('FALHA_AUDITORIA_TESTE', $e->getMessage());
        }

        $this->assertSame($controlesAntes, DB::table('risco_controle')->where('risco_id', $riscoId)->count());
        $this->assertEquals($riscoAntes, DB::table('risco')->where('id', $riscoId)->first([
            'valor_residual', 'nivel_residual_id', 'apetite_id', 'fator_controle_medio',
        ]));
        $this->assertSame($pendenciasAntes, DB::table('risco_pendencia')->where('risco_id', $riscoId)->count());
    }

    public function test_falha_em_item_intermediario_reverte_importacao_contexto_e_itens(): void
    {
        $repository = app(RiscoImportacaoRepositoryInterface::class);
        $loteFonte = DB::table('risco_importacao_lote')->where('id', 1)->first();
        $itensFonte = DB::table('risco_importacao_item')
            ->where('lote_id', 1)
            ->whereIn('codigo_externo', ['R01', 'R02'])
            ->get()
            ->keyBy('codigo_externo');
        $this->assertNotNull($loteFonte);
        $this->assertCount(2, $itensFonte);

        $primeiro = json_decode((string) $itensFonte['R01']->payload_bruto, true, 512, JSON_THROW_ON_ERROR);
        $segundo = json_decode((string) $itensFonte['R02']->payload_bruto, true, 512, JSON_THROW_ON_ERROR);
        $primeiro['codigo'] = 'TST_RB_001';
        $segundo['codigo'] = 'R01';
        $hash = hash('sha256', __METHOD__.microtime(true));
        $riscosAntes = DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->count();
        $contextoId = (int) DB::table('risco_contexto')->where('macroprojeto_id', $this->macroprojetoId)->value('id');
        $swotAntes = DB::table('risco_contexto_swot')->where('contexto_id', $contextoId)->pluck('id')->all();

        DB::beginTransaction();
        try {
            $loteId = $repository->criarPrevia(
                $this->macroprojetoId,
                'teste-rollback-importacao.xlsx',
                $hash,
                json_decode((string) $loteFonte->resumo, true, 512, JSON_THROW_ON_ERROR),
                [
                    [
                        'codigo_externo' => 'A_TST_RB_001',
                        'status' => 'VALIDO',
                        'dados' => $primeiro,
                        'mensagens' => ['erros' => [], 'pendencias' => []],
                    ],
                    [
                        'codigo_externo' => 'Z_TST_RB_002',
                        'status' => 'VALIDO',
                        'dados' => $segundo,
                        'mensagens' => ['erros' => [], 'pendencias' => []],
                    ],
                ],
                'TESTE_ROLLBACK_IMPORTACAO'
            );

            try {
                $repository->aplicar($loteId, $this->macroprojetoId, null, 'TESTE_ROLLBACK_IMPORTACAO');
                $this->fail('O segundo item duplicado deveria invalidar todo o lote.');
            } catch (RuntimeException $e) {
                $this->assertSame('Código R01 já existe no macroprojeto.', $e->getMessage());
            }

            $this->assertSame($riscosAntes, DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->count());
            $this->assertFalse(DB::table('risco')->where('macroprojeto_id', $this->macroprojetoId)->where('codigo_externo', 'TST_RB_001')->exists());
            $this->assertSame('PREVIA', DB::table('risco_importacao_lote')->where('id', $loteId)->value('status'));
            $this->assertSame(0, DB::table('risco_importacao_item')->where('lote_id', $loteId)->whereNotNull('risco_id')->count());
            $this->assertSame($contextoId, (int) DB::table('risco_contexto')->where('macroprojeto_id', $this->macroprojetoId)->value('id'));
            $this->assertSame($swotAntes, DB::table('risco_contexto_swot')->where('contexto_id', $contextoId)->pluck('id')->all());
        } finally {
            DB::rollBack();
        }

        $this->assertFalse(DB::table('risco_importacao_lote')->where('hash_sha256', $hash)->exists());
    }

    public function test_arquivamento_e_reativacao_preservam_filhos_e_sao_reversiveis(): void
    {
        $repository = app(RiscoRepositoryInterface::class);
        $riscoId = $this->riscoId('R01');
        $filhosAntes = [
            'controles' => DB::table('risco_controle')->where('risco_id', $riscoId)->count(),
            'tratamentos' => DB::table('risco_tratamento')->where('risco_id', $riscoId)->count(),
            'contingencias' => DB::table('risco_contingencia')->where('risco_id', $riscoId)->count(),
        ];

        DB::beginTransaction();
        try {
            $this->assertTrue($repository->arquivar(
                $riscoId,
                $this->macroprojetoId,
                null,
                'Teste automatizado de reversibilidade',
                'TESTE_ARQUIVAMENTO'
            ));
            $this->assertSame(1, (int) DB::table('risco')->where('id', $riscoId)->value('arquivado'));
            $this->assertSame($filhosAntes, $this->contagensFilhos($riscoId));

            $this->assertTrue($repository->reativar(
                $riscoId,
                $this->macroprojetoId,
                null,
                'TESTE_REATIVACAO'
            ));
            $this->assertSame(0, (int) DB::table('risco')->where('id', $riscoId)->value('arquivado'));
            $this->assertSame('ABERTO', DB::table('risco')->where('id', $riscoId)->value('status'));
            $this->assertSame($filhosAntes, $this->contagensFilhos($riscoId));
        } finally {
            DB::rollBack();
        }

        $this->assertSame(0, (int) DB::table('risco')->where('id', $riscoId)->value('arquivado'));
    }

    public function test_pdf_real_reproduz_filtro_do_repository(): void
    {
        $repository = app(RiscoRepositoryInterface::class);
        $riscos = $repository->listarParaExportacao(
            $this->macroprojetoId,
            null,
            ['nivel_inerente' => 'EXTREMO']
        );
        $totalExtremosAtivos = DB::table('risco as r')
            ->join('risco_nivel as n', 'n.id', '=', 'r.nivel_inerente_id')
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->where('r.arquivado', 0)
            ->where('n.codigo', 'EXTREMO')
            ->count();
        $this->assertGreaterThan(0, $totalExtremosAtivos);
        $this->assertCount($totalExtremosAtivos, $riscos);
        $this->assertTrue($riscos->every(
            static fn (object $risco): bool => (int) $risco->arquivado === 0
                && $risco->nivel_inerente_codigo === 'EXTREMO'
        ));

        $conteudo = Pdf::loadView('planejamento.riscos.pdf', [
            'riscos' => $riscos,
            'campos' => ['codigo', 'titulo', 'unidade', 'inerente', 'residual'],
        ])->setPaper('a4', 'landscape')->output();

        $this->assertStringStartsWith('%PDF', $conteudo);
        $this->assertGreaterThan(1000, strlen($conteudo));
    }

    /** @return array<string, int> */
    private function distribuicao(string $colunaNivel): array
    {
        return DB::table('risco as r')
            ->join('risco_nivel as n', 'n.id', '=', 'r.'.$colunaNivel)
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->where('r.origem', 'IMPORTACAO')
            ->groupBy('n.codigo')
            ->orderBy('n.codigo')
            ->get(['n.codigo', DB::raw('COUNT(*) AS total')])
            ->mapWithKeys(static fn (object $item): array => [$item->codigo => (int) $item->total])
            ->all();
    }

    private function riscoId(string $codigo): int
    {
        $id = (int) DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('codigo_externo', $codigo)
            ->value('id');
        $this->assertGreaterThan(0, $id);

        return $id;
    }

    /** @return array<string, int> */
    private function contagensFilhos(int $riscoId): array
    {
        return [
            'controles' => DB::table('risco_controle')->where('risco_id', $riscoId)->count(),
            'tratamentos' => DB::table('risco_tratamento')->where('risco_id', $riscoId)->count(),
            'contingencias' => DB::table('risco_contingencia')->where('risco_id', $riscoId)->count(),
        ];
    }
}
```
</TESTS_FEATURE_RISCOANEXO3683109ACCEPTANCETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/RiscoResponsavelGrupoAcceptanceTest.php`
## <TESTS_FEATURE_RISCORESPONSAVELGRUPOACCEPTANCETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/RiscoResponsavelGrupoAcceptanceTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class RiscoResponsavelGrupoAcceptanceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->macroprojetoId = (int) DB::table('macroprojeto')
$impactosAntes = DB::table('risco_unidade_impactada')->where('risco_id', $riscoId)->count();
$acao = DB::table('risco_tratamento')->where('id', $acaoId)->first();
$this->assertSame($impactosAntes, DB::table('risco_unidade_impactada')->where('risco_id', $riscoId)->count());
DB::table('grupo_unidade_membro')->where('grupo_id', $grupoId)->where('unidade_id', $unidadeId)->delete();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_grupo_responsavel_concede_acesso_dinamico_e_arquivamento_revoga(): void
public function test_unidade_responsavel_concede_acesso_e_limpeza_revoga(): void
public function test_nao_admin_preserva_grupo_omitido_e_nao_pode_altera_lo(): void
public function test_catalogo_nao_oferece_grupo_vazio_mas_preserva_referencia_existente(): void
public function test_rejeita_grupo_vazio_sem_gravar_acao(): void
public function test_banco_impede_responsabilidade_dupla_e_exclusao_de_grupo_referenciado(): void
public function test_responsaveis_existentes_fora_do_catalogo_selecionavel_podem_ser_preservados(): void
public function test_escopo_dinamico_tambem_restringe_pendencias_e_itens_de_importacao(): void
private function riscoEUnidadeSemAcesso(?int $riscoId = null): array
private function criarGrupo(string $prefixo, ?int $unidadeId = null): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Repositories\Riscos\Contracts\RiscoCicloRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use RuntimeException;
use Tests\TestCase;

class RiscoResponsavelGrupoAcceptanceTest extends TestCase
{
    private int $macroprojetoId;

    private string $conexaoOriginal;

    protected function setUp(): void
    {
        parent::setUp();
        $this->conexaoOriginal = (string) config('database.default');
        config(['database.default' => 'oracle']);
        DB::purge('oracle');
        $this->macroprojetoId = (int) DB::table('macroprojeto')
            ->where('nome', 'Eleições 2026')
            ->value('id');
        $this->assertGreaterThan(0, $this->macroprojetoId);
        DB::beginTransaction();
    }

    protected function tearDown(): void
    {
        if (DB::transactionLevel() > 0) {
            DB::rollBack();
        }
        DB::disconnect('oracle');
        config(['database.default' => $this->conexaoOriginal]);
        parent::tearDown();
    }

    public function test_grupo_responsavel_concede_acesso_dinamico_e_arquivamento_revoga(): void
    {
        [$riscoId, $unidadeId] = $this->riscoEUnidadeSemAcesso();
        $grupoId = $this->criarGrupo('GRUPO DINÂMICO', $unidadeId);
        $impactosAntes = DB::table('risco_unidade_impactada')->where('risco_id', $riscoId)->count();

        $acaoId = $this->ciclo()->salvarTratamento($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Tratamento responsável pelo acesso dinâmico',
            'responsavel_ref' => 'GRUPO:'.$grupoId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_GRUPO_RESP', true);

        $acao = DB::table('risco_tratamento')->where('id', $acaoId)->first();
        $this->assertSame($grupoId, (int) $acao->grupo_responsavel_id);
        $this->assertNull($acao->unidade_responsavel_id);
        $this->assertSame($impactosAntes, DB::table('risco_unidade_impactada')->where('risco_id', $riscoId)->count());
        $this->assertNotNull($this->riscos()->buscarRisco($riscoId, $this->macroprojetoId, [$unidadeId]));
        $this->assertTrue($this->riscos()->listarParaExportacao(
            $this->macroprojetoId,
            [$unidadeId],
            ['arquivado' => 'todos', 'unidade_id' => $unidadeId]
        )->contains('id', $riscoId));

        DB::table('grupo_unidade_membro')->where('grupo_id', $grupoId)->where('unidade_id', $unidadeId)->delete();
        $this->assertNull($this->riscos()->buscarRisco($riscoId, $this->macroprojetoId, [$unidadeId]));

        DB::table('grupo_unidade_membro')->insert(['grupo_id' => $grupoId, 'unidade_id' => $unidadeId]);
        $this->assertTrue($this->ciclo()->arquivarTratamento(
            $riscoId,
            $acaoId,
            $this->macroprojetoId,
            [$unidadeId],
            'TESTE_ARQUIVA_GRUPO'
        ));
        $this->assertNull($this->riscos()->buscarRisco($riscoId, $this->macroprojetoId, [$unidadeId]));
    }

    public function test_unidade_responsavel_concede_acesso_e_limpeza_revoga(): void
    {
        [$riscoId, $unidadeId] = $this->riscoEUnidadeSemAcesso();

        $acaoId = $this->ciclo()->salvarContingencia($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Contingência com unidade responsável',
            'responsavel_ref' => 'UNIDADE:'.$unidadeId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_UNIDADE_RESP', false);

        $this->assertNotNull($this->riscos()->buscarRisco($riscoId, $this->macroprojetoId, [$unidadeId]));

        $this->ciclo()->salvarContingencia($riscoId, [
            'id' => $acaoId,
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Contingência sem responsável',
            'responsavel_ref' => '',
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, [$unidadeId], 'TESTE_LIMPA_RESP', false);

        $acao = DB::table('risco_contingencia')->where('id', $acaoId)->first();
        $this->assertNull($acao->unidade_responsavel_id);
        $this->assertNull($acao->grupo_responsavel_id);
        $this->assertNull($this->riscos()->buscarRisco($riscoId, $this->macroprojetoId, [$unidadeId]));
    }

    public function test_nao_admin_preserva_grupo_omitido_e_nao_pode_altera_lo(): void
    {
        [$riscoId, $unidadeId] = $this->riscoEUnidadeSemAcesso();
        $grupoId = $this->criarGrupo('GRUPO PROTEGIDO', $unidadeId);
        $acaoId = $this->ciclo()->salvarTratamento($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Tratamento protegido',
            'responsavel_ref' => 'GRUPO:'.$grupoId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_ADMIN_GLOBAL', true);

        $this->ciclo()->salvarTratamento($riscoId, [
            'id' => $acaoId,
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Tratamento alterado sem tocar no grupo',
            'responsavel_informado' => false,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, [$unidadeId], 'TESTE_ADMIN_ESCOPO', false);
        $this->assertSame($grupoId, (int) DB::table('risco_tratamento')->where('id', $acaoId)->value('grupo_responsavel_id'));

        try {
            $this->ciclo()->salvarTratamento($riscoId, [
                'id' => $acaoId,
                'status_id' => $this->statusAcaoId(),
                'descricao' => 'Tentativa adulterada',
                'responsavel_ref' => 'UNIDADE:'.$unidadeId,
                'responsavel_informado' => true,
                'tarefas_ids' => [],
            ], $this->macroprojetoId, [$unidadeId], 'TESTE_ADULTERADO', false);
            $this->fail('A alteração do grupo por usuário não global deveria falhar.');
        } catch (RuntimeException $e) {
            $this->assertSame('Somente PLANELEITO_ADMIN pode alterar o grupo responsável.', $e->getMessage());
        }

        $this->assertSame($grupoId, (int) DB::table('risco_tratamento')->where('id', $acaoId)->value('grupo_responsavel_id'));
    }

    public function test_catalogo_nao_oferece_grupo_vazio_mas_preserva_referencia_existente(): void
    {
        $grupoVazioId = $this->criarGrupo('GRUPO VAZIO');
        $grupoComMembroId = $this->criarGrupo('GRUPO PREENCHIDO', $this->unidadeQualquer());

        $selecionaveis = collect($this->riscos()->listarGruposResponsaveis(true));
        $this->assertFalse($selecionaveis->contains('id', $grupoVazioId));
        $this->assertTrue($selecionaveis->contains('id', $grupoComMembroId));

        $preservados = collect($this->riscos()->listarGruposResponsaveis(false, [$grupoVazioId]));
        $this->assertTrue($preservados->contains('id', $grupoVazioId));
        $this->assertFalse($preservados->contains('id', $grupoComMembroId));
    }

    public function test_rejeita_grupo_vazio_sem_gravar_acao(): void
    {
        [$riscoId] = $this->riscoEUnidadeSemAcesso();
        $grupoId = $this->criarGrupo('GRUPO VAZIO BLOQUEADO');
        $antes = DB::table('risco_tratamento')->where('risco_id', $riscoId)->count();

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Grupo responsável inexistente ou sem membros.');

        try {
            $this->ciclo()->salvarTratamento($riscoId, [
                'status_id' => $this->statusAcaoId(),
                'descricao' => 'Não deve persistir',
                'responsavel_ref' => 'GRUPO:'.$grupoId,
                'responsavel_informado' => true,
                'tarefas_ids' => [],
            ], $this->macroprojetoId, null, 'TESTE_GRUPO_VAZIO', true);
        } finally {
            $this->assertSame($antes, DB::table('risco_tratamento')->where('risco_id', $riscoId)->count());
        }
    }

    public function test_banco_impede_responsabilidade_dupla_e_exclusao_de_grupo_referenciado(): void
    {
        [$riscoId, $unidadeId] = $this->riscoEUnidadeSemAcesso();
        $grupoId = $this->criarGrupo('GRUPO COM INTEGRIDADE', $unidadeId);
        $acaoId = $this->ciclo()->salvarTratamento($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Tratamento protegido pelo banco',
            'responsavel_ref' => 'GRUPO:'.$grupoId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_INTEGRIDADE_RESP', true);

        try {
            DB::table('risco_tratamento')->where('id', $acaoId)->update([
                'unidade_responsavel_id' => $unidadeId,
            ]);
            $this->fail('O banco deveria impedir unidade e grupo simultâneos.');
        } catch (QueryException) {
            $this->assertNull(DB::table('risco_tratamento')->where('id', $acaoId)->value('unidade_responsavel_id'));
        }

        DB::table('grupo_unidade_membro')->where('grupo_id', $grupoId)->delete();
        try {
            DB::table('grupo_unidade')->where('id', $grupoId)->delete();
            $this->fail('O banco deveria impedir a exclusão de grupo ainda referenciado.');
        } catch (QueryException) {
            $this->assertTrue(DB::table('grupo_unidade')->where('id', $grupoId)->exists());
        }
    }

    public function test_responsaveis_existentes_fora_do_catalogo_selecionavel_podem_ser_preservados(): void
    {
        [$riscoId, $unidadeResponsavelId] = $this->riscoEUnidadeSemAcesso();
        $unidadeGestoraId = (int) DB::table('risco')->where('id', $riscoId)->value('unidade_gestora_id');
        $grupoId = $this->criarGrupo('GRUPO QUE FICARÁ VAZIO', $unidadeResponsavelId);
        $tratamentoId = $this->ciclo()->salvarTratamento($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Tratamento com grupo que ficará vazio',
            'responsavel_ref' => 'GRUPO:'.$grupoId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_RESP_PRESERVADO', true);
        DB::table('grupo_unidade_membro')->where('grupo_id', $grupoId)->delete();

        $this->ciclo()->salvarTratamento($riscoId, [
            'id' => $tratamentoId,
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Grupo vazio preservado em campo somente leitura',
            'responsavel_informado' => false,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, [$unidadeGestoraId], 'TESTE_PRESERVA_GRUPO_VAZIO', false);
        $this->assertSame($grupoId, (int) DB::table('risco_tratamento')->where('id', $tratamentoId)->value('grupo_responsavel_id'));

        $contingenciaId = $this->ciclo()->salvarContingencia($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Contingência com unidade fora do escopo da gestora',
            'responsavel_ref' => 'UNIDADE:'.$unidadeResponsavelId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_UNIDADE_FORA_ESCOPO', false);
        $this->ciclo()->salvarContingencia($riscoId, [
            'id' => $contingenciaId,
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Unidade oficial preservada',
            'responsavel_ref' => 'UNIDADE:'.$unidadeResponsavelId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, [$unidadeGestoraId], 'TESTE_PRESERVA_UNIDADE', false);
        $this->assertSame(
            $unidadeResponsavelId,
            (int) DB::table('risco_contingencia')->where('id', $contingenciaId)->value('unidade_responsavel_id')
        );
    }

    public function test_escopo_dinamico_tambem_restringe_pendencias_e_itens_de_importacao(): void
    {
        $itemImportado = DB::table('risco_importacao_item as rii')
            ->join('risco as r', 'r.id', '=', 'rii.risco_id')
            ->where('r.macroprojeto_id', $this->macroprojetoId)
            ->where('r.arquivado', 0)
            ->orderBy('r.id')
            ->first(['r.id as risco_id', 'rii.id as item_id', 'rii.lote_id']);
        $this->assertNotNull($itemImportado);
        $riscoId = (int) $itemImportado->risco_id;
        [$riscoId, $unidadeId] = $this->riscoEUnidadeSemAcesso($riscoId);
        DB::table('risco_pendencia')->insert([
            'lote_id' => (int) $itemImportado->lote_id,
            'item_id' => (int) $itemImportado->item_id,
            'risco_id' => $riscoId,
            'codigo' => 'TESTE_ESCOPO_IMPORTACAO',
            'descricao' => 'Pendência transitória para validar o escopo dinâmico da importação.',
            'status' => 'ABERTA',
            'usuario_criacao' => 'TESTE_ESCOPO_IMPORTACAO',
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
        $grupoId = $this->criarGrupo('GRUPO PARA IMPORTAÇÃO', $unidadeId);
        $this->ciclo()->salvarTratamento($riscoId, [
            'status_id' => $this->statusAcaoId(),
            'descricao' => 'Tratamento que concede escopo à importação',
            'responsavel_ref' => 'GRUPO:'.$grupoId,
            'responsavel_informado' => true,
            'tarefas_ids' => [],
        ], $this->macroprojetoId, null, 'TESTE_ESCOPO_IMPORTACAO', true);

        $importacao = app(RiscoImportacaoRepositoryInterface::class);
        $this->assertTrue(collect($importacao->listarPendencias(
            $this->macroprojetoId,
            [$unidadeId],
            ['status' => 'ABERTA']
        ))->contains('risco_id', $riscoId));
        $this->assertTrue(collect($importacao->listarItensLote(
            (int) $itemImportado->lote_id,
            $this->macroprojetoId,
            [$unidadeId],
            'TESTE_ESCOPO_IMPORTACAO'
        ))->contains('risco_id', $riscoId));

        DB::table('grupo_unidade_membro')->where('grupo_id', $grupoId)->delete();
        $this->assertFalse(collect($importacao->listarPendencias(
            $this->macroprojetoId,
            [$unidadeId],
            ['status' => 'ABERTA']
        ))->contains('risco_id', $riscoId));
        $this->assertFalse(collect($importacao->listarItensLote(
            (int) $itemImportado->lote_id,
            $this->macroprojetoId,
            [$unidadeId],
            'TESTE_ESCOPO_IMPORTACAO'
        ))->contains('risco_id', $riscoId));
    }

    /** @return array{0: int, 1: int} */
    private function riscoEUnidadeSemAcesso(?int $riscoId = null): array
    {
        $query = DB::table('risco')
            ->where('macroprojeto_id', $this->macroprojetoId)
            ->where('arquivado', 0);
        if ($riscoId !== null) {
            $query->where('id', $riscoId);
        }
        $risco = $query->orderBy('id')->first(['id', 'unidade_gestora_id']);
        $this->assertNotNull($risco);

        $bloqueadas = [(int) $risco->unidade_gestora_id];
        $bloqueadas = array_merge($bloqueadas, DB::table('risco_unidade_impactada')
            ->where('risco_id', $risco->id)->pluck('unidade_id')->map(static fn ($id): int => (int) $id)->all());
        foreach (['risco_tratamento', 'risco_contingencia'] as $tabela) {
            $bloqueadas = array_merge($bloqueadas, DB::table($tabela)
                ->where('risco_id', $risco->id)->where('ativo', 1)
                ->whereNotNull('unidade_responsavel_id')->pluck('unidade_responsavel_id')
                ->map(static fn ($id): int => (int) $id)->all());
            $grupos = DB::table($tabela)->where('risco_id', $risco->id)->where('ativo', 1)
                ->whereNotNull('grupo_responsavel_id')->pluck('grupo_responsavel_id')->all();
            if ($grupos !== []) {
                $bloqueadas = array_merge($bloqueadas, DB::table('grupo_unidade_membro')
                    ->whereIn('grupo_id', $grupos)->pluck('unidade_id')->map(static fn ($id): int => (int) $id)->all());
            }
        }

        $unidadeId = (int) DB::table('vw_unidade')
            ->whereNotIn('id_unidade', array_values(array_unique($bloqueadas)))
            ->orderBy('id_unidade')
            ->value('id_unidade');
        $this->assertGreaterThan(0, $unidadeId);
        $this->assertNull($this->riscos()->buscarRisco((int) $risco->id, $this->macroprojetoId, [$unidadeId]));

        return [(int) $risco->id, $unidadeId];
    }

    private function criarGrupo(string $prefixo, ?int $unidadeId = null): int
    {
        $grupoId = (int) DB::table('grupo_unidade')->insertGetId([
            'nome' => $prefixo.' '.uniqid('', true),
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
        if ($unidadeId !== null) {
            DB::table('grupo_unidade_membro')->insert(['grupo_id' => $grupoId, 'unidade_id' => $unidadeId]);
        }

        return $grupoId;
    }

    private function unidadeQualquer(): int
    {
        return (int) DB::table('vw_unidade')->orderBy('id_unidade')->value('id_unidade');
    }

    private function statusAcaoId(): int
    {
        return (int) DB::table('risco_acao_status')->where('ativo', 1)->orderBy('id')->value('id');
    }

    private function riscos(): RiscoRepositoryInterface
    {
        return app(RiscoRepositoryInterface::class);
    }

    private function ciclo(): RiscoCicloRepositoryInterface
    {
        return app(RiscoCicloRepositoryInterface::class);
    }
}
```
</TESTS_FEATURE_RISCORESPONSAVELGRUPOACCEPTANCETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/RiscoImportacaoServiceTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RISCOIMPORTACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/RiscoImportacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoImportacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_previa_resolve_projetos_por_nome_alias_e_unidade_sem_id_hardcoded(): void
public function test_previa_marca_area_ambigua_sem_criar_unidade_ou_ampliar_escopo(): void
public function test_mesmo_hash_aplicado_e_reconhecido_como_idempotente(): void
public function test_repository_aplica_lote_em_uma_unica_transacao_auditada(): void
public function test_upload_temporario_sem_extensao_preserva_nome_original_xlsx(): void
private function referencias(): array
private function idsPorChave(array $chaves): array
public function __construct(private readonly array $referencias) {}
public function buscarLotePorHash(int $macroprojetoId, string $hash): ?array
public function carregarReferencias(int $macroprojetoId): array
public function criarPrevia(
public function aplicar(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use App\Services\Riscos\RiscoImportacaoService;
use PHPUnit\Framework\TestCase;

class RiscoImportacaoServiceTest extends TestCase
{
    private const ARQUIVO = __DIR__.'/../../../../docs/planejamento/Anexo_3683109_Planilha_Preenchida_Enriquecida_v2.xlsx';

    public function test_previa_resolve_projetos_por_nome_alias_e_unidade_sem_id_hardcoded(): void
    {
        $repository = new RiscoImportacaoRepositoryFake($this->referencias());
        $resultado = (new RiscoImportacaoService($repository))->previsualizar(
            self::ARQUIVO,
            1,
            'TESTE'
        );

        $this->assertSame(44, $resultado['lote_id']);
        $this->assertSame(108, $resultado['total']);
        $this->assertSame(0, $resultado['erros']);
        $this->assertGreaterThan(0, $resultado['avisos']);
        $this->assertCount(108, $repository->itensCriados);

        $riscos = collect($repository->itensCriados)->keyBy('codigo_externo');
        $this->assertSame(221, $riscos['R25']['dados']['projeto_id']);
        $this->assertSame(2610, $riscos['R25']['dados']['unidade_gestora_id']);
        $this->assertSame(201, $riscos['R45']['dados']['projeto_id']);
        $this->assertSame(2010, $riscos['R45']['dados']['unidade_gestora_id']);
        $this->assertContains('DATA_TRATAMENTO_INVALIDA', $riscos['R45']['dados']['pendencias']);
    }

    public function test_previa_marca_area_ambigua_sem_criar_unidade_ou_ampliar_escopo(): void
    {
        $repository = new RiscoImportacaoRepositoryFake($this->referencias());
        (new RiscoImportacaoService($repository))->previsualizar(self::ARQUIVO, 1, 'TESTE');

        $r98 = collect($repository->itensCriados)->firstWhere('codigo_externo', 'R98')['dados'];

        $this->assertSame('Secretaria do Tribunal', $r98['area_impactada_original']);
        $this->assertSame([], $r98['unidades_impactadas_ids']);
        $this->assertSame([], $r98['grupos_impactados_ids']);
        $this->assertContains('AREA_IMPACTADA_NAO_RESOLVIDA', $r98['pendencias']);
    }

    public function test_mesmo_hash_aplicado_e_reconhecido_como_idempotente(): void
    {
        $repository = new RiscoImportacaoRepositoryFake($this->referencias());
        $repository->loteExistente = ['id' => 77, 'status' => 'APLICADO', 'total_itens' => 108];

        $resultado = (new RiscoImportacaoService($repository))->previsualizar(self::ARQUIVO, 1, 'TESTE');

        $this->assertTrue($resultado['idempotente']);
        $this->assertSame(77, $resultado['lote_id']);
        $this->assertSame([], $repository->itensCriados);
    }

    public function test_repository_aplica_lote_em_uma_unica_transacao_auditada(): void
    {
        $conteudo = file_get_contents(__DIR__.'/../../../../app/Repositories/Riscos/RiscoImportacaoRepository.php');

        $this->assertStringContainsString('DB::transaction', $conteudo);
        $this->assertStringContainsString('inserirAuditado', $conteudo);
        $this->assertStringContainsString('atualizarAuditadoPorId', $conteudo);
        $this->assertStringNotContainsString('session(', $conteudo);
    }

    public function test_upload_temporario_sem_extensao_preserva_nome_original_xlsx(): void
    {
        $temporario = tempnam(sys_get_temp_dir(), 'risco-upload-');
        copy(self::ARQUIVO, $temporario);

        try {
            $repository = new RiscoImportacaoRepositoryFake($this->referencias());
            (new RiscoImportacaoService($repository))->previsualizar(
                $temporario,
                1,
                'TESTE',
                null,
                'Anexo_3683109.xlsx'
            );

            $this->assertSame('Anexo_3683109.xlsx', $repository->nomeArquivoCriado);
        } finally {
            @unlink($temporario);
        }
    }

    private function referencias(): array
    {
        $projetos = [
            ['id' => 61, 'nome' => 'Apoio Administrativo', 'unidade_id' => 610],
            ['id' => 101, 'nome' => 'Colaboradores Eleitorais', 'unidade_id' => 1010],
            ['id' => 262, 'nome' => 'Eleitorado organizado', 'unidade_id' => 2620],
            ['id' => 201, 'nome' => 'Eleitos 2026', 'unidade_id' => 2010],
            ['id' => 221, 'nome' => 'Garantia DIA-E', 'unidade_id' => 2610],
            ['id' => 261, 'nome' => 'Governança Eleitoral', 'unidade_id' => 2610],
            ['id' => 121, 'nome' => 'Votação Eletrônica', 'unidade_id' => 1210],
        ];

        return [
            'projetos' => $projetos,
            'probabilidades' => $this->idsPorChave([1, 2, 3, 4, 5]),
            'impactos' => $this->idsPorChave([1, 2, 3, 4, 5]),
            'niveis' => $this->idsPorChave(['SEM_RISCO', 'BAIXO', 'MEDIO', 'ALTO', 'EXTREMO']),
            'apetites' => $this->idsPorChave(['NAO_HA', 'OPORTUNIDADE', 'ACEITAVEL', 'INACEITAVEL', 'ABSOLUTAMENTE_INACEITAVEL']),
            'classificacoes_controle' => [
                '1.000000' => 1,
                '0.800000' => 2,
                '0.600000' => 3,
                '0.400000' => 4,
                '0.200000' => 5,
            ],
            'respostas' => $this->idsPorChave(['ACEITAR', 'MITIGAR', 'EVITAR', 'TRANSFERIR', 'ELIMINAR', 'ALAVANCAR']),
            'status_risco' => ['ABERTO' => 1],
            'status_acao' => ['NAO_INICIADA' => 1],
            'tipos_swot' => $this->idsPorChave(['FORCA', 'FRAQUEZA', 'OPORTUNIDADE', 'AMEACA']),
            'opcoes_binarias' => ['SIM' => 'SIM', 'NAO' => 'NAO'],
            'unidades' => [
                ['id' => 11, 'sigla' => 'STI', 'descricao' => 'Secretaria de Tecnologia da Informação'],
                ['id' => 12, 'sigla' => 'VP', 'descricao' => 'Vice-Presidência'],
                ['id' => 13, 'sigla' => 'CTM', 'descricao' => 'Coordenadoria Técnica'],
            ],
            'grupos' => [
                ['id' => 1, 'nome' => 'ZONAS', 'unidades_ids' => [91, 92]],
            ],
            'codigos_existentes' => [],
        ];
    }

    private function idsPorChave(array $chaves): array
    {
        $resultado = [];
        foreach ($chaves as $indice => $chave) {
            $resultado[(string) $chave] = $indice + 1;
        }

        return $resultado;
    }
}

class RiscoImportacaoRepositoryFake implements RiscoImportacaoRepositoryInterface
{
    public ?array $loteExistente = null;

    public array $itensCriados = [];

    public ?string $nomeArquivoCriado = null;

    public function __construct(private readonly array $referencias) {}

    public function buscarLotePorHash(int $macroprojetoId, string $hash): ?array
    {
        return $this->loteExistente;
    }

    public function carregarReferencias(int $macroprojetoId): array
    {
        return $this->referencias;
    }

    public function criarPrevia(
        int $macroprojetoId,
        string $nomeArquivo,
        string $hash,
        array $resumo,
        array $itens,
        string $usuario
    ): int {
        $this->itensCriados = $itens;
        $this->nomeArquivoCriado = $nomeArquivo;

        return 44;
    }

    public function aplicar(
        int $loteId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): array {
        return ['lote_id' => $loteId, 'aplicados' => 108];
    }

    public function listarLotes(int $macroprojetoId, ?array $unidadesPermitidas, string $usuario): array
    {
        return [];
    }

    public function listarItensLote(
        int $loteId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $usuario
    ): array {
        return [];
    }

    public function listarPendencias(int $macroprojetoId, ?array $unidadesPermitidas, array $filtros = []): array
    {
        return [];
    }

    public function resolverPendencia(
        int $pendenciaId,
        int $macroprojetoId,
        ?array $unidadesPermitidas,
        string $resolucao,
        string $usuario
    ): bool {
        return true;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RISCOIMPORTACAOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/UrnaContingenciaUrbanaRepositoryTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_URNACONTINGENCIAURBANAREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/UrnaContingenciaUrbanaRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class UrnaContingenciaUrbanaRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function repository_audita_dml_e_nao_descobre_contexto_de_execucao(): void
$this->assertStringContainsString('public function buscarTerritorio(', $repository);
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

class UrnaContingenciaUrbanaRepositoryTest extends TestCase
{
    #[Test]
    public function repository_audita_dml_e_nao_descobre_contexto_de_execucao(): void
    {
        $repository = file_get_contents(app_path('Repositories/Lda/UrnaContingenciaUrbanaRepository.php'));

        $this->assertIsString($repository);
        $this->assertStringContainsString('use AuditaDml;', $repository);
        $this->assertStringContainsString('->paginate($porPagina)', $repository);
        $this->assertStringContainsString("->where('m.ZONAID', \$zonaId)", $repository);
        $this->assertStringContainsString("->where('u.municipio_id', \$municipioId)", $repository);
        $this->assertStringContainsString('public function buscarTerritorio(', $repository);
        $this->assertStringContainsString("->leftJoin('lda_urna_contingencia_urbana as u'", $repository);
        $this->assertStringContainsString("->where('z.NUM_ZONA', (int) \$zona)", $repository);
        $this->assertStringContainsString('TRIM(m.COD_OBJETO_LOCALIDADE) = ?', $repository);
        $this->assertStringContainsString('u.qtd_urna_auditoria', $repository);
        $this->assertSame(2, substr_count($repository, "'qtd_urna_auditoria' => (int) \$dados['qtd_urna_auditoria']"));
        $this->assertStringNotContainsString('session(', $repository);
        $this->assertStringNotContainsString('auth(', $repository);
        $this->assertStringNotContainsString('request(', $repository);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_URNACONTINGENCIAURBANAREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoArquivamentoControllerTest.php`
## <TESTS_UNIT_RISCOARQUIVAMENTOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoArquivamentoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoArquivamentoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_arquivamento_html_retorna_a_listagem_com_feedback_legivel(): void
public function test_arquivamento_ajax_preserva_resposta_json(): void
public function test_reativacao_html_retorna_com_feedback_legivel(): void
private function controllerComArquivamentoEsperado(): RiscoController
private function escopo(): EscopoUnidadeService
private function request(string $method, array $dados = [], array $servidor = []): Request
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Riscos\RiscoController;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class RiscoArquivamentoControllerTest extends TestCase
{
    private const MACRO_ID = 7;

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_arquivamento_html_retorna_a_listagem_com_feedback_legivel(): void
    {
        $request = $this->request('DELETE', ['motivo' => 'Período de ocorrência encerrado.']);
        $controller = $this->controllerComArquivamentoEsperado();

        $response = $controller->deletar($request, 81);

        $this->assertInstanceOf(RedirectResponse::class, $response);
        $this->assertSame('https://planeleito.test/riscos?pendencia=1', $response->getTargetUrl());
        $this->assertSame('Risco arquivado com sucesso.', session('success'));
        $this->assertNull(session('erro'));
    }

    public function test_arquivamento_ajax_preserva_resposta_json(): void
    {
        $request = $this->request(
            'DELETE',
            ['motivo' => 'Período de ocorrência encerrado.'],
            ['HTTP_ACCEPT' => 'application/json', 'HTTP_X_REQUESTED_WITH' => 'XMLHttpRequest']
        );
        $controller = $this->controllerComArquivamentoEsperado();

        $response = $controller->deletar($request, 81);

        $this->assertInstanceOf(JsonResponse::class, $response);
        $this->assertSame(200, $response->getStatusCode());
        $this->assertSame(['mensagem' => 'Risco arquivado com sucesso.'], $response->getData(true));
    }

    public function test_reativacao_html_retorna_com_feedback_legivel(): void
    {
        $request = $this->request('POST');
        $repository = Mockery::mock(RiscoRepositoryInterface::class);
        $repository->shouldReceive('reativar')
            ->once()
            ->with(81, self::MACRO_ID, [10], 'TESTE')
            ->andReturnTrue();

        $response = (new RiscoController($repository, $this->escopo()))->reativar($request, 81);

        $this->assertInstanceOf(RedirectResponse::class, $response);
        $this->assertSame('Risco reativado com sucesso.', session('success'));
    }

    private function controllerComArquivamentoEsperado(): RiscoController
    {
        $repository = Mockery::mock(RiscoRepositoryInterface::class);
        $repository->shouldReceive('arquivar')
            ->once()
            ->with(81, self::MACRO_ID, [10], 'Período de ocorrência encerrado.', 'TESTE')
            ->andReturnTrue();

        return new RiscoController($repository, $this->escopo());
    }

    private function escopo(): EscopoUnidadeService
    {
        $escopo = Mockery::mock(EscopoUnidadeService::class);
        $escopo->shouldReceive('unidadesParaConsultaAtual')->once()->andReturn([10]);

        return $escopo;
    }

    /** @param array<string, string> $servidor */
    private function request(string $method, array $dados = [], array $servidor = []): Request
    {
        session([
            'matchingGroups' => ['GRUPO_TESTE'],
            'macroprojeto_ativo_id' => self::MACRO_ID,
            'user.username' => 'TESTE',
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeExecutar')->andReturnTrue();
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $request = Request::create(
            '/riscos/deletar/81',
            $method,
            $dados,
            [],
            [],
            ['HTTP_REFERER' => 'https://planeleito.test/riscos?pendencia=1'] + $servidor
        );
        $request->setLaravelSession($this->app['session.store']);
        $request->setRouteResolver(static fn () => new class
        {
            public function getName(): string
            {
                return 'riscos.deletar';
            }
        });
        $this->app->instance('request', $request);

        return $request;
    }
}
```
</TESTS_UNIT_RISCOARQUIVAMENTOCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoCalculoServiceTest.php`
## <TESTS_UNIT_RISCOCALCULOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoCalculoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoCalculoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public static function limitesDeNivel(): array
public function test_classifica_todos_os_limites_oficiais(float $valor, string $nivel): void
public function test_calcula_risco_inerente_com_pontuacoes_de_um_a_cinco(): void
public function test_rejeita_pontuacao_fora_da_escala(): void
public function test_residual_usa_media_aritmetica_dos_controles_ativos(): void
public function test_residual_fica_indisponivel_quando_algum_controle_nao_tem_classificacao(): void
public function test_residual_fica_indisponivel_sem_controle_avaliado(): void
public static function apetites(): array
public function test_deriva_apetite_do_nivel_residual(string $nivel, string $apetite): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Riscos\RiscoCalculoService;
use InvalidArgumentException;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

class RiscoCalculoServiceTest extends TestCase
{
    private RiscoCalculoService $service;

    protected function setUp(): void
    {
        parent::setUp();
        $this->service = new RiscoCalculoService;
    }

    public static function limitesDeNivel(): array
    {
        return [
            'zero' => [0.0, 'SEM_RISCO'],
            'limite sem risco' => [1.0, 'SEM_RISCO'],
            'inicio baixo' => [1.01, 'BAIXO'],
            'limite baixo' => [2.0, 'BAIXO'],
            'inicio medio' => [2.01, 'MEDIO'],
            'limite medio' => [6.0, 'MEDIO'],
            'inicio alto' => [6.01, 'ALTO'],
            'limite alto aberto' => [14.99, 'ALTO'],
            'inicio extremo' => [15.0, 'EXTREMO'],
            'maximo inerente' => [25.0, 'EXTREMO'],
        ];
    }

    #[DataProvider('limitesDeNivel')]
    public function test_classifica_todos_os_limites_oficiais(float $valor, string $nivel): void
    {
        $this->assertSame($nivel, $this->service->classificarNivel($valor));
    }

    public function test_calcula_risco_inerente_com_pontuacoes_de_um_a_cinco(): void
    {
        $this->assertSame(
            ['valor' => 15.0, 'nivel' => 'EXTREMO'],
            $this->service->calcularInerente(3, 5)
        );
    }

    public function test_rejeita_pontuacao_fora_da_escala(): void
    {
        $this->expectException(InvalidArgumentException::class);
        $this->service->calcularInerente(0, 5);
    }

    public function test_residual_usa_media_aritmetica_dos_controles_ativos(): void
    {
        $resultado = $this->service->calcularResidual(20.0, [1.0, 0.8, 0.2]);

        $this->assertSame(2 / 3, $resultado['fator_medio']);
        $this->assertEqualsWithDelta(13.333333, $resultado['valor'], 0.000001);
        $this->assertSame('ALTO', $resultado['nivel']);
        $this->assertSame('INACEITAVEL', $resultado['apetite']);
        $this->assertFalse($resultado['pendente']);
    }

    public function test_residual_fica_indisponivel_quando_algum_controle_nao_tem_classificacao(): void
    {
        $this->assertSame(
            [
                'fator_medio' => null,
                'valor' => null,
                'nivel' => null,
                'apetite' => null,
                'pendente' => true,
            ],
            $this->service->calcularResidual(10.0, [0.4, null])
        );
    }

    public function test_residual_fica_indisponivel_sem_controle_avaliado(): void
    {
        $this->assertTrue($this->service->calcularResidual(10.0, [])['pendente']);
    }

    public static function apetites(): array
    {
        return [
            ['SEM_RISCO', 'NAO_HA'],
            ['BAIXO', 'OPORTUNIDADE'],
            ['MEDIO', 'ACEITAVEL'],
            ['ALTO', 'INACEITAVEL'],
            ['EXTREMO', 'ABSOLUTAMENTE_INACEITAVEL'],
        ];
    }

    #[DataProvider('apetites')]
    public function test_deriva_apetite_do_nivel_residual(string $nivel, string $apetite): void
    {
        $this->assertSame($apetite, $this->service->apetitePorNivel($nivel));
    }
}
```
</TESTS_UNIT_RISCOCALCULOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoCicloControllerResponsavelTest.php`
## <TESTS_UNIT_RISCOCICLOCONTROLLERRESPONSAVELTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoCicloControllerResponsavelTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoCicloControllerResponsavelTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_payload_tipado_ignora_ids_brutos_injetados_e_repassa_admin_explicitamente(): void
public function test_campo_omitido_e_marcado_para_preservacao_fora_do_admin_global(): void
public function test_referencia_malformada_retorna_erro_de_validacao(): void
private function prepararRequest(array $dados, bool $admin): Request
public function getName(): string
private function escopo(): EscopoUnidadeService
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Riscos\RiscoCicloController;
use App\Repositories\Riscos\Contracts\RiscoCicloRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Mockery;
use Tests\TestCase;

class RiscoCicloControllerResponsavelTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_payload_tipado_ignora_ids_brutos_injetados_e_repassa_admin_explicitamente(): void
    {
        $request = $this->prepararRequest([
            'status_id' => 1,
            'descricao' => 'Tratamento',
            'responsavel_ref' => 'GRUPO:20',
            'unidade_responsavel_id' => 999,
            'grupo_responsavel_id' => 999,
        ], true);
        $repository = Mockery::mock(RiscoCicloRepositoryInterface::class);
        $repository->shouldReceive('salvarTratamento')
            ->once()
            ->withArgs(function (
                int $riscoId,
                array $dados,
                int $macroprojetoId,
                ?array $unidades,
                string $usuario,
                bool $podeGerenciarGrupo
            ): bool {
                return $riscoId === 99
                    && $macroprojetoId === 7
                    && $unidades === [10]
                    && $usuario === 'TESTE'
                    && $podeGerenciarGrupo
                    && $dados['responsavel_ref'] === 'GRUPO:20'
                    && $dados['responsavel_informado'] === true
                    && ! array_key_exists('unidade_responsavel_id', $dados)
                    && ! array_key_exists('grupo_responsavel_id', $dados);
            })
            ->andReturn(123);

        $resposta = (new RiscoCicloController($repository, $this->escopo()))
            ->salvarTratamento($request, 99);

        $this->assertSame(123, $resposta->getData()->resultado);
    }

    public function test_campo_omitido_e_marcado_para_preservacao_fora_do_admin_global(): void
    {
        $request = $this->prepararRequest([
            'id' => 123,
            'status_id' => 1,
            'descricao' => 'Tratamento sem alterar o grupo',
        ], false);
        $repository = Mockery::mock(RiscoCicloRepositoryInterface::class);
        $repository->shouldReceive('salvarTratamento')
            ->once()
            ->withArgs(static fn (
                int $riscoId,
                array $dados,
                int $macroprojetoId,
                ?array $unidades,
                string $usuario,
                bool $podeGerenciarGrupo
            ): bool => $dados['responsavel_informado'] === false
                && ! array_key_exists('responsavel_ref', $dados)
                && $podeGerenciarGrupo === false)
            ->andReturn(123);

        $resposta = (new RiscoCicloController($repository, $this->escopo()))
            ->salvarTratamento($request, 99);

        $this->assertSame(123, $resposta->getData()->resultado);
    }

    public function test_referencia_malformada_retorna_erro_de_validacao(): void
    {
        $request = $this->prepararRequest([
            'status_id' => 1,
            'descricao' => 'Tratamento',
            'responsavel_ref' => 'GRUPO:0',
        ], true);
        $repository = Mockery::mock(RiscoCicloRepositoryInterface::class);
        $repository->shouldNotReceive('salvarTratamento');

        $this->expectException(ValidationException::class);

        (new RiscoCicloController($repository, $this->escopo()))
            ->salvarTratamento($request, 99);
    }

    private function prepararRequest(array $dados, bool $admin): Request
    {
        session([
            'macroprojeto_ativo_id' => 7,
            'matchingGroups' => $admin ? ['PLANELEITO_ADMIN'] : ['PLANELEITO_PLANEJAMENTO_ADMIN'],
            'is_admin' => $admin,
            'user' => ['username' => 'TESTE'],
        ]);
        $request = Request::create('/riscos/99/tratamentos', 'POST', $dados);
        $request->setRouteResolver(static fn () => new class
        {
            public function getName(): string
            {
                return 'riscos.tratamentos.salvar';
            }
        });
        $this->app->instance('request', $request);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeExecutar')->andReturnTrue();
        $this->app->instance(PermissaoDominioService::class, $permissao);

        return $request;
    }

    private function escopo(): EscopoUnidadeService
    {
        $escopo = Mockery::mock(EscopoUnidadeService::class);
        $escopo->shouldReceive('unidadesParaConsultaAtual')->andReturn([10]);

        return $escopo;
    }
}
```
</TESTS_UNIT_RISCOCICLOCONTROLLERRESPONSAVELTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoCicloMigrationsTest.php`
## <TESTS_UNIT_RISCOCICLOMIGRATIONSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoCicloMigrationsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoCicloMigrationsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_separa_as_alteracoes_em_migrations_exclusivas_com_rollback(): void
$this->assertStringContainsString('public function down(): void', file_get_contents($caminho));
public function test_cria_todos_os_dominios_persistentes(): void
public function test_evolui_risco_de_forma_aditiva_e_preserva_legado(): void
public function test_cria_estruturas_normalizadas_do_ciclo(): void
public function test_importacao_guarda_hash_payload_itens_e_pendencias(): void
public function test_acl_distingue_leitura_e_escrita_nos_grupos_definidos(): void
public function test_acl_vincula_planejamento_admin_ao_macro_sem_conceder_escopo_global(): void
public function test_rastreabilidade_vincula_pendencia_ao_lote_e_item_importados(): void
$this->assertStringContainsString('public function down(): void', $conteudo);
public function test_acl_usa_o_menu_path_consolidado_do_modulo(): void
public function test_adiciona_grupo_responsavel_com_integridade_e_rollback(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class RiscoCicloMigrationsTest extends TestCase
{
    private const MIGRACOES = [
        'dominios' => '2026_07_25_120000_create_risco_dominios.php',
        'risco' => '2026_07_25_120100_extend_risco_ciclo.php',
        'ciclo' => '2026_07_25_120200_create_risco_ciclo_tables.php',
        'importacao' => '2026_07_25_120300_create_risco_importacao_tables.php',
        'acl' => '2026_07_25_120400_grant_riscos_ciclo_routes.php',
        'acl_escopo' => '2026_07_25_120500_align_riscos_acl_scope.php',
        'rastreabilidade' => '2026_07_25_120600_link_risco_import_pending_items.php',
        'menu' => '2026_07_25_120700_align_riscos_menu_path.php',
        'responsavel_grupo' => '2026_07_26_120000_add_grupo_responsavel_to_risco_acoes.php',
    ];

    public function test_separa_as_alteracoes_em_migrations_exclusivas_com_rollback(): void
    {
        foreach (self::MIGRACOES as $arquivo) {
            $caminho = $this->caminho($arquivo);
            $this->assertFileExists($caminho);
            $this->assertStringContainsString('public function down(): void', file_get_contents($caminho));
        }
    }

    public function test_cria_todos_os_dominios_persistentes(): void
    {
        $conteudo = $this->conteudo('dominios');

        foreach ([
            'risco_categoria',
            'risco_probabilidade',
            'risco_impacto',
            'risco_nivel',
            'risco_apetite',
            'risco_classificacao_controle',
            'risco_resposta',
            'risco_status',
            'risco_acao_status',
            'risco_swot_tipo',
        ] as $tabela) {
            $this->assertStringContainsString('CREATE TABLE '.$tabela, $conteudo);
        }
    }

    public function test_evolui_risco_de_forma_aditiva_e_preserva_legado(): void
    {
        $conteudo = $this->conteudo('risco');

        foreach ([
            'macroprojeto_id',
            'codigo_externo',
            'origem',
            'causas CLOB',
            'consequencias CLOB',
            'unidade_gestora_id',
            'valor_inerente',
            'valor_residual',
            'arquivado_em',
            'motivo_arquivamento',
        ] as $trecho) {
            $this->assertStringContainsString($trecho, $conteudo);
        }

        $this->assertStringContainsString('UNIQUE (macroprojeto_id, codigo_externo)', $conteudo);
        $this->assertStringNotContainsString('DROP TABLE risco', $conteudo);
    }

    public function test_cria_estruturas_normalizadas_do_ciclo(): void
    {
        $conteudo = $this->conteudo('ciclo');

        foreach ([
            'risco_contexto',
            'risco_contexto_swot',
            'risco_unidade_impactada',
            'risco_grupo_impactado',
            'risco_controle',
            'risco_tratamento',
            'risco_contingencia',
            'risco_acao_tarefa',
            'risco_monitoramento',
            'risco_comunicacao',
        ] as $tabela) {
            $this->assertStringContainsString('CREATE TABLE '.$tabela, $conteudo);
        }
    }

    public function test_importacao_guarda_hash_payload_itens_e_pendencias(): void
    {
        $conteudo = $this->conteudo('importacao');

        foreach (['risco_importacao_lote', 'risco_importacao_item', 'risco_pendencia'] as $tabela) {
            $this->assertStringContainsString('CREATE TABLE '.$tabela, $conteudo);
        }

        $this->assertStringContainsString('hash_sha256', $conteudo);
        $this->assertStringContainsString('payload_bruto CLOB', $conteudo);
        $this->assertStringContainsString('RECLASSIFICAR_ESCALA_MANUAL', $conteudo);
    }

    public function test_acl_distingue_leitura_e_escrita_nos_grupos_definidos(): void
    {
        $conteudo = $this->conteudo('acl');

        $this->assertStringContainsString('PLANELEITO_OPERADOR', $conteudo);
        $this->assertStringContainsString('PLANELEITO_PLANEJAMENTO_ADMIN', $conteudo);
        $this->assertStringContainsString("'riscos.exportar-pdf'", $conteudo);
        $this->assertStringContainsString("'riscos.importacoes.aplicar'", $conteudo);
        $this->assertStringContainsString('DB::transaction', $conteudo);
    }

    public function test_acl_vincula_planejamento_admin_ao_macro_sem_conceder_escopo_global(): void
    {
        $conteudo = $this->conteudo('acl_escopo');

        $this->assertStringContainsString('PLANELEITO_PLANEJAMENTO_ADMIN', $conteudo);
        $this->assertStringContainsString('Eleições 2026', $conteudo);
        $this->assertStringContainsString('adm_grupo_macroprojeto', $conteudo);
        $this->assertStringContainsString("'escopo_global' => 0", $conteudo);
        $this->assertStringContainsString("'riscos.index' => 'riscos'", $conteudo);
        $this->assertStringNotContainsString("'escopo_global' => 1", $conteudo);
    }

    public function test_rastreabilidade_vincula_pendencia_ao_lote_e_item_importados(): void
    {
        $conteudo = $this->conteudo('rastreabilidade');

        $this->assertStringContainsString('risco_importacao_item', $conteudo);
        $this->assertStringContainsString('lote_id', $conteudo);
        $this->assertStringContainsString('item_id', $conteudo);
        $this->assertStringContainsString("r.origem = 'IMPORTACAO'", $conteudo);
        $this->assertStringContainsString('public function down(): void', $conteudo);
    }

    public function test_acl_usa_o_menu_path_consolidado_do_modulo(): void
    {
        $this->assertStringContainsString(
            'Planejamento > Cadastros > Riscos',
            $this->conteudo('menu')
        );
    }

    public function test_adiciona_grupo_responsavel_com_integridade_e_rollback(): void
    {
        $conteudo = $this->conteudo('responsavel_grupo');
        $conteudoMaiusculo = mb_strtoupper($conteudo);

        foreach (['RISCO_TRATAMENTO', 'RISCO_CONTINGENCIA'] as $tabela) {
            $this->assertStringContainsString("'{$tabela}' =>", $conteudo);
        }
        $this->assertStringContainsString('ADD (GRUPO_RESPONSAVEL_ID NUMBER)', $conteudoMaiusculo);
        $this->assertStringContainsString('REFERENCES GRUPO_UNIDADE (ID)', $conteudoMaiusculo);
        $this->assertStringContainsString('UNIDADE_RESPONSAVEL_ID IS NULL OR GRUPO_RESPONSAVEL_ID IS NULL', $conteudoMaiusculo);
        $this->assertStringContainsString('CREATE INDEX', $conteudoMaiusculo);
        $this->assertStringContainsString('public function down(): void', $conteudo);
        $this->assertStringNotContainsString('INSERT INTO', $conteudoMaiusculo);
        $this->assertStringNotContainsString('UPDATE ', $conteudoMaiusculo);
        $this->assertStringNotContainsString('DELETE FROM', $conteudoMaiusculo);
    }

    private function conteudo(string $chave): string
    {
        return file_get_contents($this->caminho(self::MIGRACOES[$chave]));
    }

    private function caminho(string $arquivo): string
    {
        return __DIR__.'/../../database/migrations/'.$arquivo;
    }
}
```
</TESTS_UNIT_RISCOCICLOMIGRATIONSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoCodigoManualTest.php`
## <TESTS_UNIT_RISCOCODIGOMANUALTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoCodigoManualTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoCodigoManualTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_gera_referencias_manuais_validas_e_nao_repetidas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Riscos\CodigoRiscoManual;
use PHPUnit\Framework\TestCase;

class RiscoCodigoManualTest extends TestCase
{
    public function test_gera_referencias_manuais_validas_e_nao_repetidas(): void
    {
        $codigos = array_map(
            static fn (): string => CodigoRiscoManual::novo(),
            range(1, 1024)
        );

        foreach ($codigos as $codigo) {
            $this->assertMatchesRegularExpression('/^M-[0-9A-F]{18}$/', $codigo);
            $this->assertSame(20, strlen($codigo));
        }

        $this->assertCount(count($codigos), array_unique($codigos));
    }
}
```
</TESTS_UNIT_RISCOCODIGOMANUALTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoControllerDesacoplamentoTest.php`
## <TESTS_UNIT_RISCOCONTROLLERDESACOPLAMENTOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoControllerDesacoplamentoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoControllerDesacoplamentoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_listar_passa_macroprojeto_da_sessao_para_o_repository(): void
public function test_index_entrega_listagem_paginada_com_filtros_e_escopo_atuais(): void
public function test_index_normaliza_filtros_de_status_e_arquivamento(
public static function filtrosArquivamentoProvider(): array
public function test_form_passa_macroprojeto_da_sessao_para_buscar_risco(): void
private function autorizarMacroAtivo(): void
private function registrarRequestAtual(string $rota, array $query = []): Request
public function __construct(private readonly string $rota) {}
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Riscos\RiscoController;
use App\Repositories\Riscos\Contracts\RiscoDominioRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use App\Services\Riscos\RiscoCalculoService;
use Illuminate\Contracts\View\View;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use PHPUnit\Framework\Attributes\DataProvider;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Tests\TestCase;

/**
 * Congela o contrato de desacoplamento (docs/contratos/repositories.md) para o
 * modulo de Riscos: o RiscoController deve resolver o macroprojeto ativo a
 * partir da sessao e repassa-lo EXPLICITAMENTE ao RiscoRepository, em vez de
 * o repository descobrir o contexto sozinho via session().
 *
 * Estes testes falham enquanto a assinatura do repository nao receber
 * $macroprojetoId por parametro.
 */
class RiscoControllerDesacoplamentoTest extends TestCase
{
    private const MACRO_ID = 7;

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_listar_passa_macroprojeto_da_sessao_para_o_repository(): void
    {
        $this->autorizarMacroAtivo();

        $repository = Mockery::mock(RiscoRepositoryInterface::class);
        $repository->shouldReceive('listarRiscos')
            ->once()
            ->with(self::MACRO_ID, null, [], 20)
            ->andReturn(new LengthAwarePaginator([], 0, 20));

        $this->registrarRequestAtual('planejamento.riscos.listar');

        $controller = new RiscoController($repository);
        $resposta = $controller->listar();

        // Alem de exigir listarRiscos($macroId) pelo mock, prova que o pipeline
        // do controller roda com a nova assinatura e produz a listagem esperada.
        $this->assertInstanceOf(View::class, $resposta);
        $this->assertSame('planejamento.riscos.lista', $resposta->name());
        $this->assertInstanceOf(LengthAwarePaginator::class, $resposta->getData()['riscos']);
        $this->assertTrue($resposta->getData()['riscos']->isEmpty());
    }

    public function test_index_entrega_listagem_paginada_com_filtros_e_escopo_atuais(): void
    {
        $this->autorizarMacroAtivo();

        $filtros = ['busca' => 'R01', 'arquivado' => '0'];
        $escopo = [10, 20];
        $paginador = new LengthAwarePaginator([], 0, 20);

        $repository = Mockery::mock(RiscoRepositoryInterface::class);
        $repository->shouldReceive('listarRiscos')
            ->once()
            ->with(self::MACRO_ID, $escopo, $filtros, 20)
            ->andReturn($paginador);
        $repository->shouldReceive('listarProjetos')
            ->once()
            ->with(self::MACRO_ID, $escopo)
            ->andReturn([]);
        $repository->shouldReceive('listarUnidades')
            ->once()
            ->with($escopo)
            ->andReturn([]);

        $escopoService = Mockery::mock(EscopoUnidadeService::class);
        $escopoService->shouldReceive('unidadesParaConsultaAtual')->once()->andReturn($escopo);

        $dominioRepository = Mockery::mock(RiscoDominioRepositoryInterface::class);
        $dominioRepository->shouldReceive('listar')->once()->andReturn([]);

        $request = $this->registrarRequestAtual('riscos.index', $filtros + ['page' => 2]);
        $controller = new RiscoController(
            $repository,
            $escopoService,
            Mockery::mock(RiscoCalculoService::class),
            $dominioRepository
        );

        $resposta = $controller->index($request);

        $this->assertInstanceOf(View::class, $resposta);
        $this->assertSame('planejamento.riscos.index', $resposta->name());
        $this->assertSame($paginador, $resposta->getData()['riscos']);
        $this->assertSame($filtros, $resposta->getData()['filtros']);
        $this->assertTrue($resposta->getData()['podeArquivar']);
        $this->assertTrue($resposta->getData()['podeReativar']);
        $this->assertTrue($resposta->getData()['podeResolverPendencias']);
    }

    /**
     * @param  array<string, string>  $entrada
     * @param  array<string, string>  $esperados
     */
    #[DataProvider('filtrosArquivamentoProvider')]
    public function test_index_normaliza_filtros_de_status_e_arquivamento(
        array $entrada,
        array $esperados
    ): void {
        $this->autorizarMacroAtivo();
        $paginador = new LengthAwarePaginator([], 0, 20);

        $repository = Mockery::mock(RiscoRepositoryInterface::class);
        $repository->shouldReceive('listarRiscos')
            ->once()
            ->with(self::MACRO_ID, null, $esperados, 20)
            ->andReturn($paginador);
        $repository->shouldReceive('listarProjetos')
            ->once()
            ->with(self::MACRO_ID, null)
            ->andReturn([]);
        $repository->shouldReceive('listarUnidades')
            ->once()
            ->with(null)
            ->andReturn([]);

        $escopoService = Mockery::mock(EscopoUnidadeService::class);
        $escopoService->shouldReceive('unidadesParaConsultaAtual')->once()->andReturnNull();

        $dominioRepository = Mockery::mock(RiscoDominioRepositoryInterface::class);
        $dominioRepository->shouldReceive('listar')->once()->andReturn([]);

        $request = $this->registrarRequestAtual('riscos.index', $entrada);
        $controller = new RiscoController(
            $repository,
            $escopoService,
            Mockery::mock(RiscoCalculoService::class),
            $dominioRepository
        );

        $resposta = $controller->index($request);

        $this->assertSame($esperados, $resposta->getData()['filtros']);
    }

    public static function filtrosArquivamentoProvider(): array
    {
        return [
            'status arquivado de URL antiga seleciona os arquivados' => [
                ['status' => 'ARQUIVADO', 'arquivado' => '0'],
                ['status' => '', 'arquivado' => '1'],
            ],
            'arquivados ignoram status operacional contraditorio' => [
                ['status' => 'EM_TRATAMENTO', 'arquivado' => '1'],
                ['status' => '', 'arquivado' => '1'],
            ],
            'status operacional de risco ativo permanece inalterado' => [
                ['status' => 'EM_TRATAMENTO', 'arquivado' => '0'],
                ['status' => 'EM_TRATAMENTO', 'arquivado' => '0'],
            ],
        ];
    }

    public function test_form_passa_macroprojeto_da_sessao_para_buscar_risco(): void
    {
        $this->autorizarMacroAtivo();

        $repository = Mockery::mock(RiscoRepositoryInterface::class);
        $repository->shouldReceive('buscarRisco')
            ->once()
            ->with(99, self::MACRO_ID, null)
            ->andReturnNull();

        $this->registrarRequestAtual('planejamento.riscos.form');

        $controller = new RiscoController($repository);

        // Com o risco inexistente, form() chama abort(404). O que este teste
        // congela e a chamada buscarRisco($id, $macroprojetoId) com o contexto
        // resolvido na sessao e repassado por parametro.
        $this->expectException(NotFoundHttpException::class);
        $controller->form(99);
    }

    private function autorizarMacroAtivo(): void
    {
        session([
            'matchingGroups' => ['GRUPO_X'],
            'macroprojeto_ativo_id' => self::MACRO_ID,
            'aplica_escopo_unidade' => false,
            'unidades_permitidas_ids' => [],
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeExecutar')->andReturnTrue();
        $permissao->shouldReceive('podeOperarMacro')->andReturnTrue();
        $this->app->instance(PermissaoDominioService::class, $permissao);
    }

    private function registrarRequestAtual(string $rota, array $query = []): Request
    {
        $request = Request::create('/teste', 'GET', $query);
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
}
```
</TESTS_UNIT_RISCOCONTROLLERDESACOPLAMENTOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoEscopoQueryTest.php`
## <TESTS_UNIT_RISCOESCOPOQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoEscopoQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoEscopoQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_escopo_inclui_gestora_impactada_unidade_e_grupo_responsaveis_ativos(): void
public function test_escopo_nulo_e_irrestrito_e_escopo_vazio_falha_fechado(): void
private function query(): Builder
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Riscos\Queries\RiscoEscopoQuery;
use Illuminate\Database\Query\Builder;
use Tests\TestCase;

class RiscoEscopoQueryTest extends TestCase
{
    public function test_escopo_inclui_gestora_impactada_unidade_e_grupo_responsaveis_ativos(): void
    {
        $query = $this->query();

        (new RiscoEscopoQuery)->aplicar($query, [10]);
        $sql = mb_strtolower($query->toSql());

        $this->assertStringContainsString('unidade_gestora_id', $sql);
        $this->assertStringContainsString('risco_unidade_impactada', $sql);
        $this->assertStringContainsString('risco_tratamento', $sql);
        $this->assertStringContainsString('risco_contingencia', $sql);
        $this->assertStringContainsString('grupo_unidade_membro', $sql);
        $this->assertGreaterThanOrEqual(2, substr_count($sql, 'ativo'));
    }

    public function test_escopo_nulo_e_irrestrito_e_escopo_vazio_falha_fechado(): void
    {
        $irrestrita = $this->query();
        (new RiscoEscopoQuery)->aplicar($irrestrita, null);
        $this->assertSame('select * from "risco" as "r"', $irrestrita->toSql());

        $vazia = $this->query();
        (new RiscoEscopoQuery)->aplicar($vazia, []);
        $this->assertStringContainsString('1 = 0', $vazia->toSql());
    }

    private function query(): Builder
    {
        return app('db')->query()->from('risco as r');
    }
}
```
</TESTS_UNIT_RISCOESCOPOQUERYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoPendenciaFiltroRequestTest.php`
## <TESTS_UNIT_RISCOPENDENCIAFILTROREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoPendenciaFiltroRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoPendenciaFiltroRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_aceita_risco_id_positivo_e_filtros_conhecidos(): void
public function test_rejeita_risco_id_invalido_e_status_desconhecido(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Riscos\RiscoPendenciaFiltroRequest;
use Illuminate\Support\Facades\Validator;
use Tests\TestCase;

class RiscoPendenciaFiltroRequestTest extends TestCase
{
    public function test_aceita_risco_id_positivo_e_filtros_conhecidos(): void
    {
        $request = new RiscoPendenciaFiltroRequest;
        $validator = Validator::make([
            'risco_id' => 81,
            'status' => 'ABERTA',
            'codigo' => 'PERIODO_TRATAMENTO_INVERTIDO',
        ], $request->rules());

        $this->assertTrue($validator->passes());
    }

    public function test_rejeita_risco_id_invalido_e_status_desconhecido(): void
    {
        $request = new RiscoPendenciaFiltroRequest;
        $validator = Validator::make([
            'risco_id' => 'abc',
            'status' => 'QUALQUER',
        ], $request->rules());

        $this->assertTrue($validator->fails());
        $this->assertArrayHasKey('risco_id', $validator->errors()->toArray());
        $this->assertArrayHasKey('status', $validator->errors()->toArray());
    }
}
```
</TESTS_UNIT_RISCOPENDENCIAFILTROREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoPlanilhaParserTest.php`
## <TESTS_UNIT_RISCOPLANILHAPARSERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoPlanilhaParserTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoPlanilhaParserTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
private function resultado(): array
public function test_ler_a_fonte_real_com_108_codigos_unicos_e_sete_projetos(): void
public function test_ler_contexto_e_os_16_itens_swot(): void
public function test_preserva_textos_longos_sem_truncar(): void
public function test_reproduz_as_distribuicoes_oficiais_da_fonte_v2(): void
public function test_marca_as_anomalias_de_datas_sem_inventar_valores(): void
public function test_preserva_prazos_textuais_de_contingencia(): void
public function test_r98_fica_sem_residual_e_com_pendencia(): void
private function contarNiveis(array $riscos, string $campo): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Riscos\RiscoPlanilhaParser;
use PHPUnit\Framework\TestCase;

class RiscoPlanilhaParserTest extends TestCase
{
    private const ARQUIVO = __DIR__.'/../../docs/planejamento/Anexo_3683109_Planilha_Preenchida_Enriquecida_v2.xlsx';

    private static ?array $resultado = null;

    private function resultado(): array
    {
        return self::$resultado ??= (new RiscoPlanilhaParser)->parse(self::ARQUIVO);
    }

    public function test_ler_a_fonte_real_com_108_codigos_unicos_e_sete_projetos(): void
    {
        $resultado = $this->resultado();
        $riscos = $resultado['riscos'];

        $this->assertCount(108, $riscos);
        $this->assertSame(array_keys($riscos), array_values(array_unique(array_keys($riscos))));
        $this->assertSame('R01', array_key_first($riscos));
        $this->assertSame('R108', array_key_last($riscos));
        $this->assertCount(7, array_unique(array_column($riscos, 'projeto')));
        $this->assertMatchesRegularExpression('/^[a-f0-9]{64}$/', $resultado['hash']);
    }

    public function test_ler_contexto_e_os_16_itens_swot(): void
    {
        $contexto = $this->resultado()['contexto'];

        $this->assertStringContainsString('Eleições 2026', $contexto['objeto']);
        $this->assertCount(16, $contexto['swot']);
        $this->assertSame(
            ['FORCA' => 4, 'FRAQUEZA' => 4, 'OPORTUNIDADE' => 4, 'AMEACA' => 4],
            array_count_values(array_column($contexto['swot'], 'tipo'))
        );
    }

    public function test_preserva_textos_longos_sem_truncar(): void
    {
        $riscos = $this->resultado()['riscos'];
        $maiorTitulo = max(array_map(static fn (array $risco): int => mb_strlen($risco['titulo']), $riscos));

        $this->assertGreaterThan(150, $maiorTitulo);
        $this->assertGreaterThan(1000, mb_strlen($riscos['R104']['tratamento']['descricao']));
        $this->assertArrayHasKey('payload_bruto', $riscos['R104']);
    }

    public function test_reproduz_as_distribuicoes_oficiais_da_fonte_v2(): void
    {
        $riscos = $this->resultado()['riscos'];

        $this->assertSame(
            ['SEM_RISCO' => 2, 'BAIXO' => 3, 'MEDIO' => 36, 'ALTO' => 50, 'EXTREMO' => 17],
            $this->contarNiveis($riscos, 'nivel_inerente')
        );
        $this->assertSame(
            ['SEM_RISCO' => 17, 'BAIXO' => 26, 'MEDIO' => 54, 'ALTO' => 9, 'EXTREMO' => 1, 'PENDENTE' => 1],
            $this->contarNiveis($riscos, 'nivel_residual')
        );
    }

    public function test_marca_as_anomalias_de_datas_sem_inventar_valores(): void
    {
        $riscos = $this->resultado()['riscos'];

        foreach (['R45', 'R55'] as $codigo) {
            $this->assertNull($riscos[$codigo]['tratamento']['data_inicio']);
            $this->assertSame('#######', $riscos[$codigo]['tratamento']['prazo_inicio_texto']);
            $this->assertContains('DATA_TRATAMENTO_INVALIDA', $riscos[$codigo]['pendencias']);
        }

        $this->assertNull($riscos['R33']['tratamento']['data_fim']);
        $this->assertSame('30/07/2026; 03/10/2026', $riscos['R33']['tratamento']['prazo_fim_texto']);
        $this->assertContains('DATA_TRATAMENTO_MULTIPLA', $riscos['R33']['pendencias']);

        $this->assertNull($riscos['R104']['tratamento']['data_inicio']);
        $this->assertNull($riscos['R104']['tratamento']['data_fim']);
        $this->assertContains('PERIODO_TRATAMENTO_INVERTIDO', $riscos['R104']['pendencias']);
    }

    public function test_preserva_prazos_textuais_de_contingencia(): void
    {
        $riscos = $this->resultado()['riscos'];
        $textuais = array_filter($riscos, static function (array $risco): bool {
            return in_array(
                mb_strtolower((string) $risco['contingencia']['prazo_inicio_texto']),
                ['imediato', 'não há', 'inaplicável'],
                true
            );
        });

        $this->assertNotEmpty($textuais);
        foreach ($textuais as $risco) {
            $this->assertNull($risco['contingencia']['data_inicio']);
        }
    }

    public function test_r98_fica_sem_residual_e_com_pendencia(): void
    {
        $risco = $this->resultado()['riscos']['R98'];

        $this->assertNull($risco['controle']['fator']);
        $this->assertNull($risco['valor_residual']);
        $this->assertNull($risco['nivel_residual']);
        $this->assertContains('CONTROLE_SEM_CLASSIFICACAO', $risco['pendencias']);
    }

    private function contarNiveis(array $riscos, string $campo): array
    {
        $ordem = ['SEM_RISCO', 'BAIXO', 'MEDIO', 'ALTO', 'EXTREMO', 'PENDENTE'];
        $contagens = array_fill_keys($ordem, 0);

        foreach ($riscos as $risco) {
            $contagens[$risco[$campo] ?? 'PENDENTE']++;
        }

        return array_filter($contagens, static fn (int $total): bool => $total > 0);
    }
}
```
</TESTS_UNIT_RISCOPLANILHAPARSERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RiscoResponsavelServiceTest.php`
## <TESTS_UNIT_RISCORESPONSAVELSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RiscoResponsavelServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoResponsavelServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_normaliza_unidade_e_grupo_com_exclusividade(): void
public function test_campo_omitido_preserva_responsavel_atual(): void
public function test_nao_admin_nao_pode_alterar_nem_remover_grupo_existente(): void
public function test_nao_admin_nao_pode_atribuir_grupo(): void
public function test_rejeita_referencia_malformada(string $referencia): void
public static function referenciasInvalidas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Riscos\RiscoResponsavelService;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use RuntimeException;

class RiscoResponsavelServiceTest extends TestCase
{
    private RiscoResponsavelService $service;

    protected function setUp(): void
    {
        parent::setUp();
        $this->service = new RiscoResponsavelService;
    }

    public function test_normaliza_unidade_e_grupo_com_exclusividade(): void
    {
        $this->assertSame([
            'unidade_responsavel_id' => 10,
            'grupo_responsavel_id' => null,
        ], $this->service->normalizar('UNIDADE:10', true, true));

        $this->assertSame([
            'unidade_responsavel_id' => null,
            'grupo_responsavel_id' => 20,
        ], $this->service->normalizar('GRUPO:20', true, true));
    }

    public function test_campo_omitido_preserva_responsavel_atual(): void
    {
        $this->assertSame([
            'unidade_responsavel_id' => null,
            'grupo_responsavel_id' => 20,
        ], $this->service->normalizar(null, false, false, null, 20));
    }

    public function test_nao_admin_nao_pode_alterar_nem_remover_grupo_existente(): void
    {
        foreach (['', 'UNIDADE:10', 'GRUPO:20'] as $referencia) {
            try {
                $this->service->normalizar($referencia, true, false, null, 20);
                $this->fail('A alteração do grupo deveria ter sido recusada.');
            } catch (RuntimeException $e) {
                $this->assertSame('Somente PLANELEITO_ADMIN pode alterar o grupo responsável.', $e->getMessage());
            }
        }
    }

    public function test_nao_admin_nao_pode_atribuir_grupo(): void
    {
        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Somente PLANELEITO_ADMIN pode atribuir um grupo responsável.');

        $this->service->normalizar('GRUPO:20', true, false);
    }

    #[DataProvider('referenciasInvalidas')]
    public function test_rejeita_referencia_malformada(string $referencia): void
    {
        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Responsável informado é inválido.');

        $this->service->normalizar($referencia, true, true);
    }

    public static function referenciasInvalidas(): array
    {
        return [
            ['UNIDADE:0'],
            ['GRUPO:-1'],
            ['PESSOA:10'],
            ['UNIDADE:10:20'],
            ['10'],
        ];
    }
}
```
</TESTS_UNIT_RISCORESPONSAVELSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaQueryTest.php`
## <TESTS_UNIT_URNACONTINGENCIAQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('lda_recurso_logistico_opcao', function (Blueprint $table): void {
Schema::create('lda_recurso_logistico_local', function (Blueprint $table): void {
Schema::create('ROTA_LOCAL', function (Blueprint $table): void {
DB::table('lda_recurso_logistico_opcao')->insert([
DB::table('lda_recurso_logistico_local')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_cobertura_inclui_recurso_direto_e_todos_os_membros_de_todas_as_rotas(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Lda\UrnaContingenciaQuery;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class UrnaContingenciaQueryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('lda_recurso_logistico_opcao', function (Blueprint $table): void {
            $table->integer('id')->primary();
            $table->string('codigo');
        });
        Schema::create('lda_recurso_logistico_local', function (Blueprint $table): void {
            $table->string('cod_objeto_local');
            $table->integer('macroprojeto_id');
            $table->integer('recurso_opcao_id');
            $table->integer('quantidade');
        });
        Schema::create('ROTA_LOCAL', function (Blueprint $table): void {
            $table->integer('rota_id');
            $table->string('cod_objeto_local');
        });
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('ROTA_LOCAL');
        Schema::dropIfExists('lda_recurso_logistico_local');
        Schema::dropIfExists('lda_recurso_logistico_opcao');

        parent::tearDown();
    }

    public function test_cobertura_inclui_recurso_direto_e_todos_os_membros_de_todas_as_rotas(): void
    {
        DB::table('lda_recurso_logistico_opcao')->insert([
            ['id' => 1, 'codigo' => 'URNAS'],
            ['id' => 2, 'codigo' => 'KIT_DE_CONTINGENCIA_DE_URNAS'],
            ['id' => 3, 'codigo' => 'URNA_SECAO'],
        ]);
        DB::table('lda_recurso_logistico_local')->insert([
            ['cod_objeto_local' => 'ORIGEM-URNAS', 'macroprojeto_id' => 1, 'recurso_opcao_id' => 1, 'quantidade' => 2],
            ['cod_objeto_local' => 'DIRETO-SEM-ROTA', 'macroprojeto_id' => 1, 'recurso_opcao_id' => 1, 'quantidade' => 1],
            ['cod_objeto_local' => 'OUTRO-MACRO', 'macroprojeto_id' => 2, 'recurso_opcao_id' => 1, 'quantidade' => 1],
            ['cod_objeto_local' => 'SOMENTE-KIT', 'macroprojeto_id' => 1, 'recurso_opcao_id' => 2, 'quantidade' => 1],
            ['cod_objeto_local' => 'SOMENTE-URNA-SECAO', 'macroprojeto_id' => 1, 'recurso_opcao_id' => 3, 'quantidade' => 1],
        ]);
        DB::table('ROTA_LOCAL')->insert([
            ['rota_id' => 10, 'cod_objeto_local' => 'ORIGEM-URNAS'],
            ['rota_id' => 10, 'cod_objeto_local' => 'URBANO-OUTRO-MUNICIPIO'],
            ['rota_id' => 10, 'cod_objeto_local' => 'LDA-OUTRO-MUNICIPIO'],
            ['rota_id' => 11, 'cod_objeto_local' => 'ORIGEM-URNAS'],
            ['rota_id' => 11, 'cod_objeto_local' => 'MEMBRO-SEGUNDA-ROTA'],
            ['rota_id' => 12, 'cod_objeto_local' => 'SEM-COBERTURA'],
            ['rota_id' => 12, 'cod_objeto_local' => 'SOMENTE-KIT'],
        ]);

        $cobertos = UrnaContingenciaQuery::locaisCobertos(1)
            ->pluck('cod_objeto_local')
            ->map(static fn ($codigo) => trim((string) $codigo))
            ->sort()
            ->values()
            ->all();

        $this->assertSame([
            'DIRETO-SEM-ROTA',
            'LDA-OUTRO-MUNICIPIO',
            'MEMBRO-SEGUNDA-ROTA',
            'ORIGEM-URNAS',
            'URBANO-OUTRO-MUNICIPIO',
        ], $cobertos);
    }
}
```
</TESTS_UNIT_URNACONTINGENCIAQUERYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaUrbanaControllerTest.php`
## <TESTS_UNIT_URNACONTINGENCIAURBANACONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaUrbanaControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaUrbanaControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_exige_admin_repassa_filtros_e_carrega_catalogos_oficiais(): void
public function test_nao_administrador_recebe_403_antes_de_consultar_dados(): void
public function test_store_persiste_dados_validados_e_redireciona(): void
public function test_update_e_destroy_retornam_404_para_registro_inexistente(): void
public function test_update_e_destroy_persistem_e_redirecionam_quando_registro_existe(): void
public function test_form_ajax_resolve_fallback_pelo_territorio_oficial_e_bloqueia_os_campos(): void
public function test_form_ajax_edita_registro_existente_sem_carregar_catalogos(): void
public function test_store_e_update_ajax_retornam_json_para_o_modal(): void
public function test_store_ajax_reidrata_territorio_assinado_e_ignora_ids_adulterados(): void
public function test_update_ajax_vincula_contexto_assinado_ao_registro_editado(): void
public function test_form_nao_administrador_retorna_403_sem_consultar_territorio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Lda\UrnaContingenciaUrbanaController;
use App\Http\Requests\Lda\UrnaContingenciaUrbanaRequest;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use App\Repositories\Lda\UrnaContingenciaUrbanaRepository;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use Barryvdh\DomPDF\Facade\Pdf;
use Barryvdh\DomPDF\PDF as DomPdfWrapper;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Crypt;
use Mockery;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class UrnaContingenciaUrbanaControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_exige_admin_repassa_filtros_e_carrega_catalogos_oficiais(): void
    {
        $paginador = new LengthAwarePaginator([], 0, 15, 1, [
            'path' => '/tabelas-auxiliares/urnas-contingencia-urbana',
        ]);
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('listar')->once()->with(4, 16)->andReturn($paginador);
        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldReceive('listar')->once()->andReturn(collect([(object) ['id' => 4]]));
        $municipios = Mockery::mock(MunicipioRepository::class);
        $municipios->shouldReceive('listarComZona')->once()->andReturn(collect([(object) ['id' => 16]]));

        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            $zonas,
            $municipios,
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->index(Request::create('/', 'GET', [
            'zona_id' => '4',
            'municipio_id' => '16',
        ]));

        $this->assertSame('tabelas-auxiliares.urnas-contingencia-urbana.index', $response->name());
        $this->assertSame(4, $response->getData()['zonaId']);
        $this->assertSame(16, $response->getData()['municipioId']);
        $this->assertSame(
            'Qtd. urnas de auditoria',
            $response->getData()['camposPdf']['qtd_urna_auditoria']
        );
    }

    public function test_nao_administrador_recebe_403_antes_de_consultar_dados(): void
    {
        session(['is_admin' => false]);
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldNotReceive('listar');

        try {
            $this->controller($repository)->index(Request::create('/', 'GET'));
            $this->fail('Era esperado HTTP 403 para usuario nao administrador.');
        } catch (HttpException $exception) {
            $this->assertSame(403, $exception->getStatusCode());
        }
    }

    public function test_store_persiste_dados_validados_e_redireciona(): void
    {
        $dados = [
            'zona_id' => 4,
            'municipio_id' => 16,
            'percentual' => '7.50',
            'qtd_urna_auditoria' => 3,
        ];
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('criar')->once()->with($dados)->andReturn(31);
        $request = Mockery::mock(UrnaContingenciaUrbanaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dados);
        $request->shouldReceive('input')->once()->with('territorio_token', '')->andReturn('');
        $request->shouldReceive('expectsJson')->once()->andReturnFalse();

        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->store($request);

        $this->assertSame(route('tabelas-auxiliares.urnas-contingencia-urbana.index'), $response->getTargetUrl());
    }

    public function test_update_e_destroy_retornam_404_para_registro_inexistente(): void
    {
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('buscar')->twice()->with(404)->andReturn(null);
        $request = Mockery::mock(UrnaContingenciaUrbanaRequest::class);

        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->twice();

        foreach (['update', 'destroy'] as $metodo) {
            try {
                $metodo === 'update'
                    ? $controller->update($request, 404)
                    : $controller->destroy(404);
                $this->fail('Era esperado HTTP 404 em '.$metodo);
            } catch (HttpException $exception) {
                $this->assertSame(404, $exception->getStatusCode());
            }
        }
    }

    public function test_update_e_destroy_persistem_e_redirecionam_quando_registro_existe(): void
    {
        $dados = [
            'zona_id' => 4,
            'municipio_id' => 16,
            'percentual' => '8.25',
            'qtd_urna_auditoria' => 4,
        ];
        $registro = (object) ['id' => 7, 'municipio_id' => 16, 'percentual' => 7.5];
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('buscar')->twice()->with(7)->andReturn($registro);
        $repository->shouldReceive('atualizar')->once()->with(7, $dados)->andReturn(1);
        $repository->shouldReceive('remover')->once()->with(7)->andReturn(1);
        $request = Mockery::mock(UrnaContingenciaUrbanaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn($dados);
        $request->shouldReceive('input')->once()->with('territorio_token', '')->andReturn('');
        $request->shouldReceive('expectsJson')->once()->andReturnFalse();

        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->twice();

        $update = $controller->update($request, 7);
        $destroy = $controller->destroy(7);

        $this->assertSame(route('tabelas-auxiliares.urnas-contingencia-urbana.index'), $update->getTargetUrl());
        $this->assertSame(route('tabelas-auxiliares.urnas-contingencia-urbana.index'), $destroy->getTargetUrl());
    }

    public function test_form_ajax_resolve_fallback_pelo_territorio_oficial_e_bloqueia_os_campos(): void
    {
        $territorio = (object) [
            'id' => null,
            'percentual' => null,
            'municipio_id' => 20,
            'zona_id' => 4,
            'municipio' => 'CRUZEIRO DO SUL',
            'municipio_codigo' => '20',
            'num_zona' => 4,
            'zona_descricao' => 'QUARTA ZONA',
        ];
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('buscarTerritorio')
            ->once()
            ->with('4', '20')
            ->andReturn($territorio);
        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldNotReceive('listar');
        $municipios = Mockery::mock(MunicipioRepository::class);
        $municipios->shouldNotReceive('listarComZona');
        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            $zonas,
            $municipios,
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $request = Request::create('/form', 'GET', ['zona' => '4', 'municipio' => '20']);
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');

        $response = $controller->form($request);

        $this->assertSame('tabelas-auxiliares.urnas-contingencia-urbana._form', $response->name());
        $this->assertTrue($response->getData()['bloquearTerritorio']);
        $this->assertTrue($response->getData()['modal']);
        $html = $response->render();
        $this->assertStringContainsString('value="15,00"', $html);
        $this->assertStringContainsString('name="zona_id"', $html);
        $this->assertStringContainsString('name="municipio_id"', $html);
        $this->assertStringContainsString('disabled', $html);
    }

    public function test_form_ajax_edita_registro_existente_sem_carregar_catalogos(): void
    {
        $registro = (object) [
            'id' => 7,
            'percentual' => 27.96,
            'municipio_id' => 20,
            'zona_id' => 4,
            'municipio' => 'CRUZEIRO DO SUL',
            'municipio_codigo' => '20',
            'num_zona' => 4,
            'zona_descricao' => 'QUARTA ZONA',
        ];
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(7)->andReturn($registro);
        $zonas = Mockery::mock(ZonaRepository::class);
        $zonas->shouldNotReceive('listar');
        $municipios = Mockery::mock(MunicipioRepository::class);
        $municipios->shouldNotReceive('listarComZona');
        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            $zonas,
            $municipios,
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();
        $request = Request::create('/form/7', 'GET');
        $request->headers->set('X-Requested-With', 'XMLHttpRequest');

        $response = $controller->form($request, 7);

        $this->assertSame('tabelas-auxiliares.urnas-contingencia-urbana._form', $response->name());
        $this->assertStringContainsString('value="27,96"', $response->render());
        $this->assertStringContainsString('value="PUT"', $response->render());
    }

    public function test_store_e_update_ajax_retornam_json_para_o_modal(): void
    {
        $dados = ['zona_id' => 4, 'municipio_id' => 20, 'percentual' => '27.96'];
        $registro = (object) ['id' => 7, 'municipio_id' => 20, 'percentual' => 15.0];
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('criar')->once()->with($dados)->andReturn(7);
        $repository->shouldReceive('buscar')->once()->with(7)->andReturn($registro);
        $repository->shouldReceive('atualizar')->once()->with(7, $dados)->andReturn(1);
        $storeRequest = Mockery::mock(UrnaContingenciaUrbanaRequest::class);
        $storeRequest->shouldReceive('validated')->once()->andReturn($dados);
        $storeRequest->shouldReceive('input')->once()->with('territorio_token', '')->andReturn('');
        $storeRequest->shouldReceive('expectsJson')->once()->andReturnTrue();
        $updateRequest = Mockery::mock(UrnaContingenciaUrbanaRequest::class);
        $updateRequest->shouldReceive('validated')->once()->andReturn($dados);
        $updateRequest->shouldReceive('input')->once()->with('territorio_token', '')->andReturn('');
        $updateRequest->shouldReceive('expectsJson')->once()->andReturnTrue();
        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->twice();

        $store = $controller->store($storeRequest);
        $update = $controller->update($updateRequest, 7);

        $this->assertSame(201, $store->status());
        $this->assertSame(7, $store->getData(true)['id']);
        $this->assertSame('Percentual criado com sucesso.', $store->getData(true)['message']);
        $this->assertSame(200, $update->status());
        $this->assertSame('Percentual atualizado com sucesso.', $update->getData(true)['message']);
    }

    public function test_store_ajax_reidrata_territorio_assinado_e_ignora_ids_adulterados(): void
    {
        $territorio = (object) [
            'id' => null,
            'municipio_id' => 20,
            'zona_id' => 4,
        ];
        $token = Crypt::encryptString((string) json_encode([
            'zona' => '4',
            'municipio' => '20',
            'registro_id' => null,
        ], JSON_THROW_ON_ERROR));
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('buscarTerritorio')
            ->once()
            ->with('4', '20')
            ->andReturn($territorio);
        $repository->shouldReceive('criar')
            ->once()
            ->with([
                'zona_id' => 4,
                'municipio_id' => 20,
                'percentual' => '27.96',
            ])
            ->andReturn(7);
        $request = Mockery::mock(UrnaContingenciaUrbanaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'zona_id' => 99,
            'municipio_id' => 999,
            'percentual' => '27.96',
        ]);
        $request->shouldReceive('input')
            ->once()
            ->with('territorio_token', '')
            ->andReturn($token);
        $request->shouldReceive('expectsJson')->once()->andReturnTrue();
        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->store($request);

        $this->assertSame(201, $response->status());
        $this->assertSame(7, $response->getData(true)['id']);
    }

    public function test_update_ajax_vincula_contexto_assinado_ao_registro_editado(): void
    {
        $territorio = (object) [
            'id' => 7,
            'municipio_id' => 20,
            'zona_id' => 4,
        ];
        $token = Crypt::encryptString((string) json_encode([
            'zona' => '4',
            'municipio' => '20',
            'registro_id' => 7,
        ], JSON_THROW_ON_ERROR));
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('buscar')->once()->with(7)->andReturn($territorio);
        $repository->shouldReceive('buscarTerritorio')
            ->once()
            ->with('4', '20')
            ->andReturn($territorio);
        $repository->shouldReceive('atualizar')
            ->once()
            ->with(7, [
                'zona_id' => 4,
                'municipio_id' => 20,
                'percentual' => '27.96',
            ])
            ->andReturn(1);
        $request = Mockery::mock(UrnaContingenciaUrbanaRequest::class);
        $request->shouldReceive('validated')->once()->andReturn([
            'zona_id' => 99,
            'municipio_id' => 999,
            'percentual' => '27.96',
        ]);
        $request->shouldReceive('input')
            ->once()
            ->with('territorio_token', '')
            ->andReturn($token);
        $request->shouldReceive('expectsJson')->once()->andReturnTrue();
        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->update($request, 7);

        $this->assertSame(200, $response->status());
        $this->assertSame(7, $response->getData(true)['id']);
    }

    public function test_form_nao_administrador_retorna_403_sem_consultar_territorio(): void
    {
        session(['is_admin' => false]);
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldNotReceive('buscarTerritorio');

        try {
            $this->controller($repository)->form(
                Request::create('/form', 'GET', ['zona' => '4', 'municipio' => '20'])
            );
            $this->fail('Era esperado HTTP 403 para usuario nao administrador.');
        } catch (HttpException $exception) {
            $this->assertSame(403, $exception->getStatusCode());
        }
    }

    public function test_store_ajax_invalido_retorna_422_com_erros_para_o_modal(): void
    {
        $this->withoutMiddleware();

        $response = $this
            ->withSession(['is_admin' => true])
            ->postJson(route('tabelas-auxiliares.urnas-contingencia-urbana.store'), []);

        $response
            ->assertStatus(422)
            ->assertJsonValidationErrors(['zona_id', 'municipio_id', 'percentual']);
    }

    public function test_pdf_aplica_whitelist_e_os_mesmos_filtros_da_tela(): void
    {
        $registros = collect([(object) ['municipio' => 'RIO BRANCO', 'percentual' => 7.5]]);
        $repository = Mockery::mock(UrnaContingenciaUrbanaRepository::class);
        $repository->shouldReceive('listarTodos')->once()->with(4, 16)->andReturn($registros);
        $pdf = Mockery::mock(DomPdfWrapper::class);
        $pdf->shouldReceive('setPaper')->once()->with('a4', 'landscape')->andReturnSelf();
        $pdf->shouldReceive('download')->once()->with('urnas-contingencia-urbana.pdf')->andReturn(response('pdf'));
        Pdf::shouldReceive('loadView')->once()->with(
            'tabelas-auxiliares.urnas-contingencia-urbana.pdf',
            Mockery::on(static fn (array $dados): bool => $dados['campos'] === ['percentual', 'zona']
                && $dados['registros']->count() === 1
            ),
        )->andReturn($pdf);

        $controller = Mockery::mock(UrnaContingenciaUrbanaController::class, [
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        ])->makePartial();
        $controller->shouldAllowMockingProtectedMethods();
        $controller->shouldReceive('autorizarAdmin')->once();

        $response = $controller->exportarPdf(Request::create('/', 'GET', [
            'zona_id' => '4',
            'municipio_id' => '16',
            'campos' => ['percentual', 'forjado', 'zona'],
        ]));

        $this->assertSame('pdf', $response->getContent());
    }

    private function controller(UrnaContingenciaUrbanaRepository $repository): UrnaContingenciaUrbanaController
    {
        return new UrnaContingenciaUrbanaController(
            $repository,
            Mockery::mock(ZonaRepository::class),
            Mockery::mock(MunicipioRepository::class),
        );
    }
}
```
</TESTS_UNIT_URNACONTINGENCIAURBANACONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaUrbanaMigrationTest.php`
## <TESTS_UNIT_URNACONTINGENCIAURBANAMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaUrbanaMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaUrbanaMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringNotContainsString('DB::table', $migration);
$this->assertStringNotContainsString('DB::table', $migration);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_cria_parametro_normalizado_com_integridade_no_oracle(): void
public function migration_adiciona_quantidade_inteira_de_urnas_de_auditoria_com_default_zero(): void
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

class UrnaContingenciaUrbanaMigrationTest extends TestCase
{
    private const MIGRATION_QTD_URNA_AUDITORIA =
        'migrations/2026_07_31_183200_add_qtd_urna_auditoria_to_lda_urna_contingencia_urbana.php';

    #[Test]
    public function migration_cria_parametro_normalizado_com_integridade_no_oracle(): void
    {
        $migration = file_get_contents(database_path(
            'migrations/2026_07_30_140000_create_lda_urna_contingencia_urbana_table.php'
        ));

        $this->assertIsString($migration);
        $ddl = preg_replace('/\s+/', ' ', $migration);
        $this->assertIsString($ddl);
        $this->assertStringContainsString('CREATE TABLE lda_urna_contingencia_urbana', $ddl);
        $this->assertStringContainsString('municipio_id', $ddl);
        $this->assertStringContainsString('percentual NUMBER(5,2) NOT NULL', $ddl);
        $this->assertStringContainsString('FOREIGN KEY (municipio_id) REFERENCES MUNICIPIO (ID)', $ddl);
        $this->assertStringContainsString('UNIQUE (municipio_id)', $ddl);
        $this->assertStringContainsString('percentual >= 0 AND percentual <= 100', $ddl);
        $this->assertStringNotContainsString('zona_id', mb_strtolower($migration, 'UTF-8'));
        $this->assertStringNotContainsString('macroprojeto_id', mb_strtolower($migration, 'UTF-8'));
        $this->assertStringNotContainsString('DB::table', $migration);
    }

    #[Test]
    public function migration_adiciona_quantidade_inteira_de_urnas_de_auditoria_com_default_zero(): void
    {
        $migration = file_get_contents(database_path(self::MIGRATION_QTD_URNA_AUDITORIA));

        $this->assertIsString($migration);
        $ddl = preg_replace('/\s+/', ' ', $migration);
        $this->assertIsString($ddl);
        $this->assertStringContainsString(
            'qtd_urna_auditoria NUMBER(10) DEFAULT 0 NOT NULL',
            $ddl
        );
        $this->assertStringContainsString(
            'CHECK (qtd_urna_auditoria >= 0)',
            $ddl
        );
        $this->assertStringContainsString(
            'DROP CONSTRAINT ck_lucu_qtd_urna_auditoria',
            $ddl
        );
        $this->assertStringContainsString('DROP (qtd_urna_auditoria)', $ddl);
        $this->assertStringNotContainsString('DB::table', $migration);
    }
}
```
</TESTS_UNIT_URNACONTINGENCIAURBANAMIGRATIONTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaUrbanaQueryTest.php`
## <TESTS_UNIT_URNACONTINGENCIAURBANAQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaUrbanaQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaUrbanaQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('ZONA', function (Blueprint $table): void {
Schema::create('MUNICIPIO', function (Blueprint $table): void {
Schema::create('lda_urna_contingencia_urbana', function (Blueprint $table): void {
DB::table('ZONA')->insert([
DB::table('MUNICIPIO')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_resolve_configuracao_pela_combinacao_de_zona_e_municipio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Lda\UrnaContingenciaUrbanaQuery;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class UrnaContingenciaUrbanaQueryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::create('ZONA', function (Blueprint $table): void {
            $table->integer('ID')->primary();
            $table->integer('NUM_ZONA');
        });
        Schema::create('MUNICIPIO', function (Blueprint $table): void {
            $table->integer('ID')->primary();
            $table->integer('ZONAID');
            $table->string('COD_OBJETO_LOCALIDADE');
        });
        Schema::create('lda_urna_contingencia_urbana', function (Blueprint $table): void {
            $table->integer('id')->primary();
            $table->integer('municipio_id');
            $table->decimal('percentual', 5, 2);
            $table->integer('qtd_urna_auditoria')->default(0);
        });

        DB::table('ZONA')->insert([
            ['ID' => 1, 'NUM_ZONA' => 1],
            ['ID' => 9, 'NUM_ZONA' => 9],
        ]);
        DB::table('MUNICIPIO')->insert([
            ['ID' => 50, 'ZONAID' => 1, 'COD_OBJETO_LOCALIDADE' => '16'],
            ['ID' => 52, 'ZONAID' => 9, 'COD_OBJETO_LOCALIDADE' => '16'],
        ]);
        DB::table('lda_urna_contingencia_urbana')->insert([
            ['id' => 7, 'municipio_id' => 50, 'percentual' => 26.54, 'qtd_urna_auditoria' => 12],
            ['id' => 8, 'municipio_id' => 52, 'percentual' => 0.00, 'qtd_urna_auditoria' => 4],
        ]);
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('lda_urna_contingencia_urbana');
        Schema::dropIfExists('MUNICIPIO');
        Schema::dropIfExists('ZONA');

        parent::tearDown();
    }

    public function test_resolve_configuracao_pela_combinacao_de_zona_e_municipio(): void
    {
        $configuracoes = UrnaContingenciaUrbanaQuery::configuracoesPorTerritorio()
            ->get()
            ->keyBy(static fn (object $item): string => trim((string) $item->zona).'|'.trim((string) $item->municipio_codigo)
            );

        $this->assertCount(2, $configuracoes);
        $this->assertSame(7, (int) $configuracoes['1|16']->id);
        $this->assertSame(26.54, (float) $configuracoes['1|16']->percentual);
        $this->assertSame(12, (int) $configuracoes['1|16']->qtd_urna_auditoria);
        $this->assertSame(8, (int) $configuracoes['9|16']->id);
        $this->assertSame(0.0, (float) $configuracoes['9|16']->percentual);
        $this->assertSame(4, (int) $configuracoes['9|16']->qtd_urna_auditoria);
    }
}
```
</TESTS_UNIT_URNACONTINGENCIAURBANAQUERYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/UrnaContingenciaUrbanaRequestTest.php`
## <TESTS_UNIT_URNACONTINGENCIAURBANAREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/UrnaContingenciaUrbanaRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class UrnaContingenciaUrbanaRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_apenas_administrador_e_autorizado(): void
public function test_normaliza_virgula_e_aceita_percentual_com_duas_casas(): void
public function test_assume_zero_quando_quantidade_de_urnas_de_auditoria_nao_e_informada(): void
public function test_aceita_quantidade_inteira_nao_negativa_de_urnas_de_auditoria(): void
public function test_rejeita_quantidade_de_urnas_de_auditoria_invalida(string $quantidade): void
public static function quantidadesUrnaAuditoriaInvalidas(): array
public function test_aceita_limites_inclusivos_e_ate_duas_casas(string $percentual): void
public static function percentuaisValidos(): array
public function test_rejeita_percentual_fora_da_faixa_ou_com_mais_de_duas_casas(string $percentual): void
public static function percentuaisInvalidos(): array
public function test_rejeita_municipio_que_nao_pertence_a_zona(): void
public function test_rejeita_percentual_duplicado_para_o_mesmo_municipio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Lda\UrnaContingenciaUrbanaRequest;
use Illuminate\Routing\Route;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\DatabasePresenceVerifierInterface;
use Illuminate\Validation\Validator as LaravelValidator;
use PHPUnit\Framework\Attributes\DataProvider;
use ReflectionMethod;
use Tests\TestCase;

class UrnaContingenciaUrbanaRequestTest extends TestCase
{
    public function test_apenas_administrador_e_autorizado(): void
    {
        session(['is_admin' => true]);
        $this->assertTrue(UrnaContingenciaUrbanaRequest::create('/', 'POST')->authorize());

        session(['is_admin' => false]);
        $this->assertFalse(UrnaContingenciaUrbanaRequest::create('/', 'POST')->authorize());
    }

    public function test_normaliza_virgula_e_aceita_percentual_com_duas_casas(): void
    {
        [$request, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => '7,50',
        ]);

        $this->assertSame('7.50', $request->input('percentual'));
        $this->assertFalse($validator->fails(), (string) $validator->errors());
    }

    public function test_assume_zero_quando_quantidade_de_urnas_de_auditoria_nao_e_informada(): void
    {
        [$request, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => '7,50',
        ]);

        $this->assertSame(0, $request->input('qtd_urna_auditoria'));
        $this->assertFalse($validator->fails(), (string) $validator->errors());
    }

    public function test_aceita_quantidade_inteira_nao_negativa_de_urnas_de_auditoria(): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => '7,50',
            'qtd_urna_auditoria' => '12',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors());
    }

    #[DataProvider('quantidadesUrnaAuditoriaInvalidas')]
    public function test_rejeita_quantidade_de_urnas_de_auditoria_invalida(string $quantidade): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => '7,50',
            'qtd_urna_auditoria' => $quantidade,
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('qtd_urna_auditoria'));
    }

    public static function quantidadesUrnaAuditoriaInvalidas(): array
    {
        return [
            'negativa' => ['-1'],
            'decimal' => ['1.5'],
            'texto' => ['dez'],
            'acima do number dez' => ['10000000000'],
        ];
    }

    #[DataProvider('percentuaisValidos')]
    public function test_aceita_limites_inclusivos_e_ate_duas_casas(string $percentual): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => $percentual,
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors());
    }

    public static function percentuaisValidos(): array
    {
        return [
            'zero' => ['0'],
            'cem' => ['100'],
            'uma casa' => ['7,5'],
        ];
    }

    #[DataProvider('percentuaisInvalidos')]
    public function test_rejeita_percentual_fora_da_faixa_ou_com_mais_de_duas_casas(string $percentual): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => $percentual,
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('percentual'));
    }

    public static function percentuaisInvalidos(): array
    {
        return [
            'negativo' => ['-0,01'],
            'maior que cem' => ['100,01'],
            'tres casas' => ['7,555'],
        ];
    }

    public function test_rejeita_municipio_que_nao_pertence_a_zona(): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '9',
            'municipio_id' => '16',
            'percentual' => '15',
        ]);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('municipio_id'));
    }

    public function test_rejeita_percentual_duplicado_para_o_mesmo_municipio(): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => '15',
        ], municipioDuplicado: true);

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('municipio_id'));
    }

    public function test_update_ignora_o_proprio_registro_na_regra_de_unicidade(): void
    {
        [, $validator] = $this->validar([
            'zona_id' => '4',
            'municipio_id' => '16',
            'percentual' => '15',
        ], municipioDuplicado: true, id: 31);

        $this->assertFalse($validator->fails(), (string) $validator->errors());
    }

    /** @return array{UrnaContingenciaUrbanaRequest, LaravelValidator} */
    private function validar(array $dados, bool $municipioDuplicado = false, ?int $id = null): array
    {
        $request = UrnaContingenciaUrbanaRequest::create($id === null ? '/' : '/'.$id, $id === null ? 'POST' : 'PUT', $dados);
        if ($id !== null) {
            $route = new Route('PUT', '/{id}', static fn () => null);
            $route->bind($request);
            $request->setRouteResolver(static fn () => $route);
        }
        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $validator = Validator::make($request->all(), $request->rules(), $request->messages());
        $validator->setPresenceVerifier(new class($municipioDuplicado) implements DatabasePresenceVerifierInterface
        {
            public function __construct(private readonly bool $municipioDuplicado) {}

            public function getCount($collection, $column, $value, $excludeId = null, $idColumn = null, array $extra = [])
            {
                if (mb_strtoupper((string) $collection, 'UTF-8') === 'ZONA') {
                    return in_array((int) $value, [4, 9], true) ? 1 : 0;
                }

                if (mb_strtoupper((string) $collection, 'UTF-8') === 'MUNICIPIO') {
                    return (int) $value === 16 && (int) ($extra['ZONAID'] ?? 0) === 4 ? 1 : 0;
                }

                if (mb_strtolower((string) $collection, 'UTF-8') === 'lda_urna_contingencia_urbana') {
                    return $this->municipioDuplicado && (int) $excludeId !== 31 ? 1 : 0;
                }

                return 0;
            }

            public function getMultiCount($collection, $column, array $values, array $extra = [])
            {
                return 0;
            }

            public function setConnection($connection): void {}
        });

        return [$request, $validator];
    }
}
```
</TESTS_UNIT_URNACONTINGENCIAURBANAREQUESTTEST_PHP>

