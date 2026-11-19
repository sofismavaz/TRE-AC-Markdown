# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_gestao_tarefas_alertas`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 60  
> **Tamanho do Arquivo:** 365 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Tarefas/CategoriaTarefaController.php`
## <APP_HTTP_CONTROLLERS_TAREFAS_CATEGORIATAREFACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Tarefas/CategoriaTarefaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Tarefas`
- **Entidade / Classe:** `class CategoriaTarefaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly CategoriaTarefaRepositoryInterface $repository)
public function index()
public function listar(Request $request)
public function form($id = null)
public function salvar(CategoriaTarefaRequest $request): JsonResponse
public function alterarStatus($id): JsonResponse
public function deletar($id): JsonResponse
public function options(): JsonResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Tarefas;

use App\Http\Controllers\Controller;

use App\Http\Requests\Tarefas\CategoriaTarefaRequest;
use App\Repositories\Tarefas\Contracts\CategoriaTarefaRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CategoriaTarefaController extends Controller
{
    public function __construct(private readonly CategoriaTarefaRepositoryInterface $repository)
    {
    }

    public function index()
    {
        return view('planejamento.categorias.index');
    }

    public function listar(Request $request)
    {
        $busca = trim((string) $request->get('busca', ''));
        $ativo = $request->get('ativo');

        $categorias = $this->repository->listar($busca, $ativo);

        return view('planejamento.categorias.lista', [
            'categorias' => $categorias,
            'busca' => $busca,
            'ativo' => $ativo,
        ]);
    }

    public function form($id = null)
    {
        $categoria = $id ? $this->repository->buscar((int) $id) : null;

        return view('planejamento.categorias.form', compact('categoria'));
    }

    public function salvar(CategoriaTarefaRequest $request): JsonResponse
    {
        $dados = $request->validated();
        $dados['ATIVO'] = array_key_exists('ATIVO', $dados) ? (bool) $dados['ATIVO'] : true;

        DB::transaction(function () use ($dados) {
            if (!empty($dados['ID'])) {
                $this->repository->atualizar((int) $dados['ID'], $dados);
            } else {
                $this->repository->criar($dados);
            }
        });

        $mensagem = !empty($dados['ID'])
            ? 'Categoria atualizada com sucesso!'
            : 'Categoria criada com sucesso!';

        return response()->json(['mensagem' => $mensagem]);
    }

    public function alterarStatus($id): JsonResponse
    {
        $novoStatus = $this->repository->alterarStatus((int) $id);
        if ($novoStatus === null) {
            return response()->json(['mensagem' => 'Categoria não encontrada.'], 404);
        }

        $texto = $novoStatus === 'S' ? 'ativada' : 'desativada';
        return response()->json(['mensagem' => "Categoria {$texto} com sucesso!"]);
    }

    public function deletar($id): JsonResponse
    {
        if (empty($id)) {
            return response()->json(['mensagem' => 'Identificador da categoria não informado.'], 400);
        }

        try {
            DB::transaction(function () use ($id) {
                $this->repository->remover((int) $id);
            });

            return response()->json(['mensagem' => 'Categoria removida com sucesso!']);
        } catch (\Throwable $e) {
            $mensagem = 'Erro ao remover categoria: ' . $e->getMessage();
            return response()->json(['mensagem' => $mensagem], 500);
        }
    }

    public function options(): JsonResponse
    {
        return response()->json($this->repository->listarAtivas());
    }
}
```
</APP_HTTP_CONTROLLERS_TAREFAS_CATEGORIATAREFACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Tarefas/FaseTarefaController.php`
## <APP_HTTP_CONTROLLERS_TAREFAS_FASETAREFACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Tarefas/FaseTarefaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Tarefas`
- **Entidade / Classe:** `class FaseTarefaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly FaseTarefaRepositoryInterface $repository)
public function index()
public function listar(Request $request)
public function form($id = null)
public function salvar(FaseTarefaRequest $request)
public function alterarStatus($id)
public function deletar($id)
public function options()
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Tarefas;

use App\Http\Controllers\Controller;

use App\Http\Requests\Tarefas\FaseTarefaRequest;
use App\Repositories\Tarefas\Contracts\FaseTarefaRepositoryInterface;
use Illuminate\Http\Request;

class FaseTarefaController extends Controller
{
    public function __construct(private readonly FaseTarefaRepositoryInterface $repository)
    {
    }

    public function index()
    {
        return view('planejamento.fases.index');
    }

    public function listar(Request $request)
    {
        $busca = trim((string) $request->get('busca', ''));
        $ativo = $request->get('ativo');

        $fases = $this->repository->listar($busca, $ativo, 5);

        return view('planejamento.fases.lista', [
            'fases' => $fases,
            'busca' => $busca,
            'ativo' => $ativo,
        ]);
    }

    public function form($id = null)
    {
        $fase = $id ? $this->repository->buscar((int) $id) : null;

        return view('planejamento.fases.form', compact('fase'));
    }

    public function salvar(FaseTarefaRequest $request)
    {
        $dados = $request->validated();
        $ativo = array_key_exists('ATIVO', $dados) ? (bool) $dados['ATIVO'] : true;

        if (!empty($dados['ID'])) {
            $dados['ATIVO'] = $ativo;
            $this->repository->atualizar((int) $dados['ID'], $dados);

            return response()->json(['mensagem' => 'Fase atualizada com sucesso!']);
        }

        $dados['ATIVO'] = $ativo;
        $this->repository->criar($dados);

        return response()->json(['mensagem' => 'Fase criada com sucesso!']);
    }

    public function alterarStatus($id)
    {
        $novoStatus = $this->repository->alterarStatus((int) $id);
        if ($novoStatus === null) {
            return response()->json(['mensagem' => 'Fase não encontrada.'], 404);
        }

        $texto = $novoStatus === 'S' ? 'ativada' : 'desativada';
        return response()->json(['mensagem' => "Fase {$texto} com sucesso!"]);
    }

    public function deletar($id)
    {
        if (empty($id)) {
            return response()->json(['mensagem' => 'Identificador da fase não informado.'], 400);
        }

        try {
            $this->repository->remover((int) $id);
            return response()->json(['mensagem' => 'Fase removida com sucesso!']);
        } catch (\Throwable $e) {
            return response()->json(['mensagem' => 'Erro ao remover fase: ' . $e->getMessage()], 500);
        }
    }

    public function options()
    {
        return response()->json($this->repository->listarAtivas());
    }
}
```
</APP_HTTP_CONTROLLERS_TAREFAS_FASETAREFACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Tarefas/TarefaAlertaController.php`
## <APP_HTTP_CONTROLLERS_TAREFAS_TAREFAALERTACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Tarefas/TarefaAlertaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaController extends Controller`

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
public function preview(NotificacaoAtrasoRequest $request): JsonResponse
public function enviar(NotificacaoAtrasoRequest $request): JsonResponse
public function execucoesImediatas(Request $request)
private function buscarTarefas(array $dados): Collection
private function escopoAtual(): array
private function derivarTiposDestinatario(array $dados): array
private function extrairFiltros(array $dados): array
private function montarDestinatarios(Collection $tarefas, array $dados): array
private function registrarDestinatario(array &$destinatarios, array &$semEmail, ?array $unidade, string $origem, array $tarefa): void
private function resumirTarefa(array $tarefa): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Tarefas;

use App\Http\Controllers\Controller;

use App\Http\Requests\Tarefas\NotificacaoAtrasoRequest;
use App\Jobs\Tarefas\EnviarAlertaTarefasJob;
use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaAuditoriaRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Repositories\Tarefas\TarefaAlertaRepository;
use App\Services\EscopoUnidadeService;
use App\Support\Tarefas\TarefaAlertaExecucaoStatus;
use App\Support\Tarefas\TarefaStatus;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class TarefaAlertaController extends Controller
{
    public function __construct(
        private readonly TarefaAlertaRepository           $repository,
        private readonly TarefaAlertaExecucaoRepository   $execucaoRepo,
        private readonly TarefaAlertaAgendamentoRepository $agendamentoRepo,
        private readonly TarefaAlertaAuditoriaRepository  $auditoriaRepo,
        private readonly EscopoUnidadeService             $escopoUnidadeService
    ) {}

    public function index()
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        return view('planejamento.tarefas.alertas', [
            'statusDisponiveis' => TarefaStatus::OPCOES,
            'statusPadrao'      => TarefaStatus::ALERTA_PADRAO,
        ]);
    }

    public function preview(NotificacaoAtrasoRequest $request): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $dados   = $request->validated();
        $tarefas = $this->buscarTarefas($dados);

        if ($tarefas->isEmpty()) {
            return response()->json([
                'tarefas'      => [],
                'destinatarios' => [],
                'sem_email'    => [],
                'resumo'       => ['total_tarefas' => 0, 'total_destinatarios' => 0],
            ]);
        }

        [$destinatarios, $semEmail] = $this->montarDestinatarios($tarefas, $dados);

        return response()->json([
            'tarefas'      => $tarefas->values(),
            'destinatarios' => array_values($destinatarios),
            'sem_email'    => $semEmail,
            'resumo'       => [
                'total_tarefas'      => $tarefas->count(),
                'total_destinatarios' => count($destinatarios),
            ],
        ]);
    }

    /**
     * Dispara envio imediato via fila. HTTP confirma enfileiramento, não envio.
     */
    public function enviar(NotificacaoAtrasoRequest $request): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $dados    = $request->validated();
        $usuario  = session('user', []);
        $escopo   = $this->escopoAtual();

        $tiposDestinatario = $this->derivarTiposDestinatario($dados);

        $execucaoId = $this->execucaoRepo->criar([
            'agendamento_id'          => null,
            'origem'                  => 'imediato',
            'status'                  => TarefaAlertaExecucaoStatus::PENDENTE,
            'filtros_json'            => json_encode($this->extrairFiltros($dados)),
            'tipos_destinatario_json' => json_encode($tiposDestinatario),
            'escopo_json'             => json_encode($escopo),
            'assunto'                 => $dados['assunto'] ?? 'Alertas de tarefas atrasadas',
            'mensagem'                => $dados['mensagem'] ?? null,
            'solicitante_id'          => $usuario['id'] ?? null,
            'solicitante_username'    => $usuario['username'] ?? null,
            'solicitante_nome'        => $usuario['nome'] ?? ($usuario['username'] ?? null),
            'responsavel_username'    => $usuario['username'] ?? null,
            'responsavel_nome'        => $usuario['nome'] ?? ($usuario['username'] ?? null),
        ]);

        EnviarAlertaTarefasJob::dispatch($execucaoId);

        $this->auditoriaRepo->registrar(null, 'envio_imediato', [
            'id'       => $usuario['id'] ?? null,
            'username' => $usuario['username'] ?? null,
            'nome'     => $usuario['nome'] ?? null,
        ], [
            'valores_depois_json' => json_encode(['execucao_id' => $execucaoId, 'filtros' => $dados]),
            'escopo_depois_json'  => json_encode($escopo),
        ]);

        return response()->json([
            'mensagem'    => 'Envio enfileirado com sucesso. Acompanhe o resultado no histórico.',
            'execucao_id' => $execucaoId,
        ]);
    }

    public function execucoesImediatas(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $execucoes = $this->execucaoRepo->historicoImediato($this->macroprojetoAtivoIdSessao());
        foreach ($execucoes->items() as $execucao) {
            $execucao->detalhes = $this->execucaoRepo->detalhesDaExecucao((int) $execucao->id);
        }

        return view('planejamento.tarefas.execucoes-imediatas', [
            'execucoes'    => $execucoes,
            'statusLabels' => TarefaAlertaExecucaoStatus::LABELS,
        ]);
    }

    // ─── Helpers privados ────────────────────────────────────────────────────

    private function buscarTarefas(array $dados): Collection
    {
        return $this->repository->buscarTarefas(
            $dados,
            $this->escopoUnidadeService->unidadesParaConsultaAtual(),
            $this->macroprojetoAtivoIdSessao()
        );
    }

    private function escopoAtual(): array
    {
        return [
            'macroprojeto_id' => $this->macroprojetoAtivoIdSessao(),
            'aplica_escopo_unidade' => $this->escopoUnidadeService->aplicaEscopoAtual(),
            'unidades_permitidas_ids' => $this->escopoUnidadeService->unidadesParaConsultaAtual(),
            'is_admin' => session('is_admin', false),
            'ignora_unidades_na_rota' => session('ignora_unidades_na_rota', false),
            'rotas_ignora_unidades' => session('rotas_ignora_unidades', []),
            'expande_escopo_por_atividade' => session('expande_escopo_por_atividade', false),
            'cod_zonas_permitidas' => session('cod_zonas_permitidas', []),
            'acesso_todas_zonas' => session('acesso_todas_zonas', false),
        ];
    }

    private function derivarTiposDestinatario(array $dados): array
    {
        $tipos = [];
        if (!empty($dados['incluir_unidade_tarefa']))    $tipos[] = 'unidade_tarefa';
        if (!empty($dados['incluir_unidade_subprojeto'])) $tipos[] = 'unidade_subprojeto';
        if (!empty($dados['incluir_unidade_projeto']))   $tipos[] = 'unidade_projeto';
        return $tipos;
    }

    private function extrairFiltros(array $dados): array
    {
        return array_filter([
            'status'                  => $dados['status'] ?? null,
            'data_prevista_inicio_de' => $dados['data_prevista_inicio_de'] ?? null,
            'data_prevista_fim_ate'   => $dados['data_prevista_fim_ate'] ?? null,
            'projeto_id'              => $dados['projeto_id'] ?? null,
            'subprojeto_id'           => $dados['subprojeto_id'] ?? null,
            'unidade_id'              => $dados['unidade_id'] ?? null,
        ], fn ($v) => $v !== null && $v !== '' && $v !== []);
    }

    private function montarDestinatarios(Collection $tarefas, array $dados): array
    {
        $destinatarios = [];
        $semEmail      = [];

        foreach ($tarefas as $tarefa) {
            $resumo = $this->resumirTarefa($tarefa);

            if (!empty($dados['incluir_unidade_tarefa'])) {
                $this->registrarDestinatario($destinatarios, $semEmail, $tarefa['unidade_tarefa'], 'Unidade responsável pela tarefa', $resumo);
            }
            if (!empty($dados['incluir_unidade_subprojeto'])) {
                $this->registrarDestinatario($destinatarios, $semEmail, $tarefa['unidade_subprojeto'], 'Unidade do subprojeto', $resumo);
            }
            if (!empty($dados['incluir_unidade_projeto'])) {
                $this->registrarDestinatario($destinatarios, $semEmail, $tarefa['unidade_projeto'], 'Unidade do projeto', $resumo);
            }
        }

        foreach ($destinatarios as &$dest) {
            unset($dest['tarefas_keys']);
        }
        unset($dest);

        return [$destinatarios, $semEmail];
    }

    private function registrarDestinatario(array &$destinatarios, array &$semEmail, ?array $unidade, string $origem, array $tarefa): void
    {
        if ($unidade === null) {
            return;
        }

        $label = $unidade['label'] ?? 'Unidade sem descrição';

        $email = strtolower(trim((string) ($unidade['email'] ?? '')));
        if ($email === '') {
            $semEmail[] = ['origem' => $origem, 'unidade' => $label, 'tarefa' => $tarefa['nome']];
            return;
        }

        $chave = $email;

        if (!isset($destinatarios[$chave])) {
            $destinatarios[$chave] = [
                'email'       => $email,
                'origens'     => [$origem],
                'unidades'    => [$label],
                'tarefas'     => [],
                'tarefas_keys' => [],
            ];
        } else {
            if (!in_array($origem, $destinatarios[$chave]['origens'], true)) {
                $destinatarios[$chave]['origens'][] = $origem;
            }
            if (!in_array($label, $destinatarios[$chave]['unidades'], true)) {
                $destinatarios[$chave]['unidades'][] = $label;
            }
        }

        $key = 'id:' . ($tarefa['id'] ?? md5(json_encode($tarefa)));
        if (!isset($destinatarios[$chave]['tarefas_keys'][$key])) {
            $destinatarios[$chave]['tarefas'][] = $tarefa;
            $destinatarios[$chave]['tarefas_keys'][$key] = true;
        }
    }

    private function resumirTarefa(array $tarefa): array
    {
        return [
            'id'                 => $tarefa['id'],
            'nome'               => $tarefa['nome'],
            'unidade_responsavel' => $tarefa['unidade_tarefa']['label'] ?? '-',
            'status'             => $tarefa['status'],
            'projeto'            => $tarefa['projeto_nome'],
            'subprojeto'         => $tarefa['subprojeto_nome'],
            'data_prevista_fim'  => $tarefa['data_prevista_fim'],
            'data_prevista_inicio' => $tarefa['data_prevista_inicio'],
        ];
    }
}
```
</APP_HTTP_CONTROLLERS_TAREFAS_TAREFAALERTACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Tarefas/TarefaController.php`
## <APP_HTTP_CONTROLLERS_TAREFAS_TAREFACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Tarefas/TarefaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Tarefas`
- **Entidade / Classe:** `class TarefaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
private function macroprojetoAtivoId(): int
private function rotasPermitidasSessao(): array
private function usuarioTemAlgumaRota(array $rotas): bool
private function usuarioPodeGerirTarefaSemEscopoUnidade(): bool
private function usuarioPodeDecidirSolicitacaoPrazo(): bool
private function autorizarSolicitacaoPrazoLoteAdmin(): void
private function unidadesPermitidas(): ?array
private function autorizarTarefaParaNaoAdmin(int $tarefaId, ?int $unidadeId = null): void
private function buscarTarefaSimplesOu404(int $id): object
private function buscarTarefaFormularioOu404(int $id): object
public function __construct(
public function index()
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Tarefas;

use App\Http\Controllers\Controller;

use App\Http\Requests\Tarefas\TarefaFinalRequest;
use App\Http\Requests\Tarefas\TarefaInicioRequest;
use App\Http\Requests\Tarefas\TarefaAndamentoRequest;
use App\Http\Requests\Tarefas\TarefaRequest;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoLoteRequest;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoDecisaoRequest;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoRequest;
use App\Http\Requests\Tarefas\TarefaRestritaRequest;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\Planejamento\PlanejamentoPermissoes;
use App\Support\DateHelper;
use App\Support\Tarefas\TarefaStatus;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Collection;
use Illuminate\Support\Str;

class TarefaController extends Controller
{
    private function macroprojetoAtivoId(): int
    {
        return (int) session('macroprojeto_ativo_id', 0);
    }

    private function rotasPermitidasSessao(): array
    {
        return collect(session('rotas_permitidas', []))
            ->map(static fn ($rota) => mb_strtoupper(trim((string) $rota)))
            ->filter()
            ->values()
            ->all();
    }

    private function usuarioTemAlgumaRota(array $rotas): bool
    {
        $rotasPermitidas = $this->rotasPermitidasSessao();
        if (in_array('*', $rotasPermitidas, true)) {
            return true;
        }

        foreach ($rotas as $rota) {
            if (in_array(mb_strtoupper(trim($rota)), $rotasPermitidas, true)) {
                return true;
            }
        }

        return false;
    }

    private function usuarioPodeGerirTarefaSemEscopoUnidade(): bool
    {
        return $this->usuarioTemAlgumaRota([
            'TAREFAS.FORM',
            'TAREFAS.SALVAR',
        ]);
    }

    private function usuarioPodeDecidirSolicitacaoPrazo(): bool
    {
        return $this->usuarioTemAlgumaRota([
            'TAREFAS.SOLICITACOES.PRAZO.APROVAR',
            'TAREFAS.SOLICITACOES.PRAZO.REJEITAR',
        ]);
    }

    private function autorizarSolicitacaoPrazoLoteAdmin(): void
    {
        if ($this->usuarioPodeDecidirSolicitacaoPrazo()) {
            return;
        }

        abort(403);
    }

    private function unidadesPermitidas(): ?array
    {
        return $this->escopoUnidadeService->unidadesParaConsultaAtual();
    }

    private function autorizarTarefaParaNaoAdmin(int $tarefaId, ?int $unidadeId = null): void
    {
        if ($this->usuarioPodeGerirTarefaSemEscopoUnidade()) {
            return;
        }

        $this->permissoes->validarPermissaoTarefa(
            $tarefaId,
            $unidadeId,
            $this->unidadesPermitidas(),
            fn (int $id) => $this->repository->buscarEscopoUnidadesDaTarefa($id, $this->macroprojetoAtivoId())
        );
    }

    private function buscarTarefaSimplesOu404(int $id): object
    {
        $tarefa = $this->repository->buscarTarefaSimples($id, $this->macroprojetoAtivoId());
        if (!$tarefa) {
            abort(404);
        }

        return $tarefa;
    }

    private function buscarTarefaFormularioOu404(int $id): object
    {
        $tarefa = $this->repository->buscarTarefaFormulario($id, $this->macroprojetoAtivoId());
        if (!$tarefa) {
            abort(404);
        }

        return $tarefa;
    }

    public function __construct(
        private readonly TarefaRepositoryInterface $repository,
        private readonly PlanejamentoPermissoes $permissoes,
        private readonly EscopoUnidadeService $escopoUnidadeService
    )
    {
    }

    public function index()
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $projetos = $this->repository->listarProjetos($this->macroprojetoAtivoId());
        $unidades = $this->repository->listarUnidades();
        $categorias = $this->repository->listarCategoriasAtivas($this->macroprojetoAtivoId());
        $fases = $this->repository->listarFasesAtivas($this->macroprojetoAtivoId());
        $statuses = TarefaStatus::OPCOES;

        return view('planejamento.tarefas.index', compact('projetos', 'statuses', 'unidades', 'categorias', 'fases'));
    }

    public function consultaIndex()
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $projetos = $this->repository->listarProjetos($this->macroprojetoAtivoId());
        $unidades = $this->repository->listarUnidades();
        $categorias = $this->repository->listarCategoriasAtivas($this->macroprojetoAtivoId());
        $fases = $this->repository->listarFasesAtivas($this->macroprojetoAtivoId());
        $statuses = TarefaStatus::OPCOES;
        $somenteLeitura = true;
        $rotaIndex = route('tarefas.consulta.index');
        $rotaListar = route('tarefas.consulta.listar');

        return view('planejamento.tarefas.index', compact(
            'projetos',
            'statuses',
            'unidades',
            'categorias',
            'fases',
            'somenteLeitura',
            'rotaIndex',
            'rotaListar'
        ));
    }

    public function kanban(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $projetos = $this->repository->listarProjetos($this->macroprojetoAtivoId());
        $unidades = $this->repository->listarUnidades();
        $categorias = $this->repository->listarCategoriasAtivas($this->macroprojetoAtivoId());
        $fases = $this->repository->listarFasesAtivas($this->macroprojetoAtivoId());
        $statuses = TarefaStatus::OPCOES;

        $projetosSelecionados = collect($request->input('projeto_id', []))
            ->merge($request->input('projetos', []))
            ->flatten()
            ->filter(fn ($v) => $v !== null && $v !== '')
            ->map(fn ($v) => (int) $v)
            ->filter(fn ($v) => $v > 0)
            ->unique()
            ->values();

        $subprojetosSelecionados = collect($request->input('subprojeto_id', []))
            ->merge($request->input('subprojetos', []))
            ->flatten()
            ->filter(fn ($v) => $v !== null && $v !== '')
            ->map(fn ($v) => (int) $v)
            ->filter(fn ($v) => $v > 0)
            ->unique()
            ->values();

        $unidadesSelecionadas = collect($request->input('unidade_id', []))
            ->flatten()
            ->filter(fn ($v) => $v !== null && $v !== '')
            ->map(fn ($v) => (int) $v)
            ->filter(fn ($v) => $v > 0)
            ->unique()
            ->values();

        $categoriasSelecionadas = collect($request->input('categoria_id', []))
            ->flatten()
            ->filter(fn ($v) => $v !== null && $v !== '')
            ->map(fn ($v) => (int) $v)
            ->filter(fn ($v) => $v > 0)
            ->unique()
            ->values();

        $fasesSelecionadas = collect($request->input('fase_id', []))
            ->flatten()
            ->filter(fn ($v) => $v !== null && $v !== '')
            ->map(fn ($v) => (int) $v)
            ->filter(fn ($v) => $v > 0)
            ->unique()
            ->values();

        $statusesSelecionados = collect($request->input('status', []))
            ->flatten()
            ->map(fn ($valor) => is_string($valor) ? trim($valor) : '')
            ->filter(fn ($valor) => $valor !== '')
            ->unique()
            ->values();

        $buscaTexto = trim((string) $request->input('busca_texto', ''));
        $ordenarPrevInicio = (string) $request->input('ordenar_prev_inicio', '') === '1';

        $filtrosAplicados = $projetosSelecionados->isNotEmpty()
            || $subprojetosSelecionados->isNotEmpty()
            || $unidadesSelecionadas->isNotEmpty()
            || $categoriasSelecionadas->isNotEmpty()
            || $fasesSelecionadas->isNotEmpty()
            || $statusesSelecionados->isNotEmpty()
            || $buscaTexto !== '';

        $tarefas = $this->repository->buscarTarefasKanban([
            'aplicar' => $filtrosAplicados,
            'projetos' => $projetosSelecionados->all(),
            'subprojetos' => $subprojetosSelecionados->all(),
            'unidades' => $unidadesSelecionadas->all(),
            'categorias' => $categoriasSelecionadas->all(),
            'fases' => $fasesSelecionadas->all(),
            'statuses' => $statusesSelecionados->all(),
            'busca_texto' => $buscaTexto,
            'ordenar_prev_inicio' => $ordenarPrevInicio,
        ], $this->unidadesPermitidas(), $this->macroprojetoAtivoId());

        $colunas = [
            'a_iniciar' => collect(),
            'em_andamento' => collect(),
            'concluida' => collect(),
        ];

        foreach ($tarefas as $tarefa) {
            $temInicioReal = !empty($tarefa->data_real_inicio);
            $temFimReal = !empty($tarefa->data_real_fim);

            if ($temFimReal) {
                $colunas['concluida']->push($tarefa);
                continue;
            }

            if (!$temInicioReal) {
                $colunas['a_iniciar']->push($tarefa);
                continue;
            }

            $colunas['em_andamento']->push($tarefa);
        }

        if ($projetosSelecionados->isNotEmpty()) {
            $subprojetosFiltro = $this->repository->buscarSubprojetosPorProjetos($projetosSelecionados->all(), $this->macroprojetoAtivoId());
        } elseif ($subprojetosSelecionados->isNotEmpty()) {
            $subprojetosFiltro = $this->repository->buscarSubprojetosPorIds($subprojetosSelecionados->all(), $this->macroprojetoAtivoId());
        } else {
            $subprojetosFiltro = $this->repository->listarTodosSubprojetos($this->macroprojetoAtivoId());
        }

        return view('planejamento.tarefas.kanban', [
            'colunas' => $colunas,
            'projetos' => $projetos,
            'unidades' => $unidades,
            'categorias' => $categorias,
            'fases' => $fases,
            'projetosSelecionados' => $projetosSelecionados->all(),
            'subprojetosSelecionados' => $subprojetosSelecionados->all(),
            'unidadesSelecionadas' => $unidadesSelecionadas->all(),
            'categoriasSelecionadas' => $categoriasSelecionadas->all(),
            'fasesSelecionadas' => $fasesSelecionadas->all(),
            'subprojetosFiltro' => $subprojetosFiltro,
            'filtrosAplicados' => $filtrosAplicados,
            'statuses' => $statuses,
            'statusesSelecionados' => $statusesSelecionados->all(),
            'buscaTexto' => $buscaTexto,
            'ordenarPrevInicio' => $ordenarPrevInicio,
        ]);
    }

    public function listar(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $projetosSelecionados = collect(Arr::wrap($request->input('projeto_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $subprojetosSelecionados = collect(Arr::wrap($request->input('subprojeto_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $unidadesSelecionadas = collect(Arr::wrap($request->input('unidade_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $categoriasSelecionadas = collect(Arr::wrap($request->input('categoria_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $statusesSelecionados = collect(Arr::wrap($request->input('status')))
            ->flatten()
            ->map(fn ($valor) => is_string($valor) ? trim($valor) : '')
            ->filter(fn ($valor) => $valor !== '')
            ->unique()
            ->values();

        $fasesSelecionadas = collect(Arr::wrap($request->input('fase_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();
        $buscaTexto = trim((string) $request->input('busca_texto', ''));
        $ordenarPrevInicio = (string) $request->input('ordenar_prev_inicio', '') === '1';

        $unidadesPermitidas = $this->unidadesPermitidas();
        $tarefas = $this->repository->listarTarefasPaginadas([
            'projetos' => $projetosSelecionados->all(),
            'subprojetos' => $subprojetosSelecionados->all(),
            'statuses' => $statusesSelecionados->all(),
            'unidades' => $unidadesSelecionadas->all(),
            'categorias' => $categoriasSelecionadas->all(),
            'fases' => $fasesSelecionadas->all(),
            'busca_texto' => $buscaTexto,
            'ordenar_prev_inicio' => $ordenarPrevInicio,
        ], $unidadesPermitidas, $this->macroprojetoAtivoId(), 5);
        $somenteLeitura = false;
        $rotaIndex = route('tarefas.index');

        return view('planejamento.tarefas.lista', compact('tarefas', 'somenteLeitura', 'rotaIndex'));
    }

    public function consultaListar(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $projetosSelecionados = collect(Arr::wrap($request->input('projeto_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $subprojetosSelecionados = collect(Arr::wrap($request->input('subprojeto_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $unidadesSelecionadas = collect(Arr::wrap($request->input('unidade_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $categoriasSelecionadas = collect(Arr::wrap($request->input('categoria_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $statusesSelecionados = collect(Arr::wrap($request->input('status')))
            ->flatten()
            ->map(fn ($valor) => is_string($valor) ? trim($valor) : '')
            ->filter(fn ($valor) => $valor !== '')
            ->unique()
            ->values();

        $fasesSelecionadas = collect(Arr::wrap($request->input('fase_id')))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();
        $buscaTexto = trim((string) $request->input('busca_texto', ''));
        $ordenarPrevInicio = (string) $request->input('ordenar_prev_inicio', '') === '1';

        $unidadesPermitidas = $this->unidadesPermitidas();
        $tarefas = $this->repository->listarTarefasPaginadas([
            'projetos' => $projetosSelecionados->all(),
            'subprojetos' => $subprojetosSelecionados->all(),
            'statuses' => $statusesSelecionados->all(),
            'unidades' => $unidadesSelecionadas->all(),
            'categorias' => $categoriasSelecionadas->all(),
            'fases' => $fasesSelecionadas->all(),
            'busca_texto' => $buscaTexto,
            'ordenar_prev_inicio' => $ordenarPrevInicio,
        ], $unidadesPermitidas, $this->macroprojetoAtivoId(), 5);

        $somenteLeitura = true;
        $rotaIndex = route('tarefas.consulta.index');

        return view('planejamento.tarefas.lista', compact('tarefas', 'somenteLeitura', 'rotaIndex'));
    }

    public function gantt(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $filtros = $this->normalizarFiltrosGantt($request);
        $projetosSelecionados = $filtros['projetosSelecionados'];
        $subprojetosSelecionados = $filtros['subprojetosSelecionados'];
        $categoriasSelecionadas = $filtros['categoriasSelecionadas'];
        $fasesSelecionadas = $filtros['fasesSelecionadas'];
        $statusesSelecionados = $filtros['statusesSelecionados'];
        $unidadesSelecionadas = $filtros['unidadesSelecionadas'];
        $buscaTexto = $filtros['buscaTexto'];
        $ordenarPrevInicio = $filtros['ordenarPrevInicio'];
        $filtrosAplicados = $filtros['filtrosAplicados'];

        $unidadesPermitidas = $this->unidadesPermitidas();
        $tarefas = $this->repository->buscarTarefasGantt([
            'aplicar' => $filtrosAplicados,
            'projetos' => $projetosSelecionados->all(),
            'subprojetos' => $subprojetosSelecionados->all(),
            'categorias' => $categoriasSelecionadas->all(),
            'fases' => $fasesSelecionadas->all(),
            'statuses' => $statusesSelecionados->all(),
            'unidades' => $unidadesSelecionadas->all(),
            'busca_texto' => $buscaTexto,
            'ordenar_prev_inicio' => $ordenarPrevInicio,
        ], $unidadesPermitidas, $this->macroprojetoAtivoId());

        $listaProjetos = $this->repository->listarProjetosOrdenados($this->macroprojetoAtivoId());
        $categoriasLista = $this->repository->listarCategoriasAtivas($this->macroprojetoAtivoId());
        $fases = $this->repository->listarFasesAtivas($this->macroprojetoAtivoId());
        $statuses = TarefaStatus::OPCOES;
        $unidades = $this->repository->listarUnidades();

        if ($projetosSelecionados->isNotEmpty()) {
            $subprojetosFiltro = $this->repository->buscarSubprojetosPorProjetos($projetosSelecionados->all(), $this->macroprojetoAtivoId());
        } elseif ($subprojetosSelecionados->isNotEmpty()) {
            $subprojetosFiltro = $this->repository->buscarSubprojetosPorIds($subprojetosSelecionados->all(), $this->macroprojetoAtivoId());
        } else {
            $subprojetosFiltro = $this->repository->listarTodosSubprojetos($this->macroprojetoAtivoId());
        }

        return view('planejamento.tarefas.gantt', [
            'tarefas' => $tarefas,
            'projetosLista' => $listaProjetos,
            'subprojetosFiltro' => $subprojetosFiltro,
            'projetosSelecionados' => $projetosSelecionados->all(),
            'subprojetosSelecionados' => $subprojetosSelecionados->all(),
            'categoriasSelecionadas' => $categoriasSelecionadas->all(),
            'fasesSelecionadas' => $fasesSelecionadas->all(),
            'statusesSelecionados' => $statusesSelecionados->all(),
            'unidadesSelecionadas' => $unidadesSelecionadas->all(),
            'categoriasLista' => $categoriasLista,
            'fases' => $fases,
            'statuses' => $statuses,
            'unidades' => $unidades,
            'filtrosAplicados' => $filtrosAplicados,
            'buscaTexto' => $buscaTexto,
            'ordenarPrevInicio' => $ordenarPrevInicio,
        ]);
    }

    public function ganttPdf(Request $request)
    {
        @ini_set('memory_limit', '512M');
        @ini_set('max_execution_time', '180');
        @set_time_limit(180);

        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $filtros = $this->normalizarFiltrosGantt($request);
        $unidadesPermitidas = $this->unidadesPermitidas();

        $tarefas = $this->repository->buscarTarefasGantt([
            'aplicar' => $filtros['filtrosAplicados'],
            'projetos' => $filtros['projetosSelecionados']->all(),
            'subprojetos' => $filtros['subprojetosSelecionados']->all(),
            'categorias' => $filtros['categoriasSelecionadas']->all(),
            'fases' => $filtros['fasesSelecionadas']->all(),
            'statuses' => $filtros['statusesSelecionados']->all(),
            'unidades' => $filtros['unidadesSelecionadas']->all(),
            'busca_texto' => $filtros['buscaTexto'],
            'ordenar_prev_inicio' => $filtros['ordenarPrevInicio'],
        ], $unidadesPermitidas, $this->macroprojetoAtivoId());

        $pdf = Pdf::loadView('planejamento.tarefas.gantt-pdf', [
            'tarefas' => $tarefas,
            'projetosSelecionados' => $filtros['projetosSelecionados']->all(),
            'subprojetosSelecionados' => $filtros['subprojetosSelecionados']->all(),
            'unidadesSelecionadas' => $filtros['unidadesSelecionadas']->all(),
            'categoriasSelecionadas' => $filtros['categoriasSelecionadas']->all(),
            'fasesSelecionadas' => $filtros['fasesSelecionadas']->all(),
            'statusesSelecionados' => $filtros['statusesSelecionados']->all(),
            'buscaTexto' => $filtros['buscaTexto'],
            'ordenarPrevInicio' => $filtros['ordenarPrevInicio'],
            'filtrosAplicados' => $filtros['filtrosAplicados'],
            'geradoEm' => now()->format('d/m/Y H:i'),
        ])->setPaper('a4', 'landscape');

        return $pdf->download('gantt-atividades.pdf');
    }

    private function normalizarFiltrosGantt(Request $request): array
    {
        $projetosSelecionados = collect($request->input('projeto_id', []))
            ->merge($request->input('projetos', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        if ($projetosSelecionados->isEmpty() && $request->filled('projeto')) {
            $valor = $request->input('projeto');
            if (ctype_digit((string) $valor)) {
                $projetosSelecionados = collect([(int) $valor]);
            } else {
                $registro = $this->repository->buscarProjetoPorNome((string) $valor, $this->macroprojetoAtivoId());
                if ($registro) {
                    $projetosSelecionados = collect([(int) $registro->id]);
                }
            }
        }

        $subprojetosSelecionados = collect($request->input('subprojeto_id', []))
            ->merge($request->input('subprojetos', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        if ($subprojetosSelecionados->isEmpty() && $request->filled('subprojeto')) {
            $subprojetosSelecionados = collect([(int) $request->input('subprojeto')]);
        }

        $categoriasSelecionadas = collect($request->input('categoria_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $fasesSelecionadas = collect($request->input('fase_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $statusesSelecionados = collect($request->input('status', []))
            ->flatten()
            ->map(fn ($valor) => is_string($valor) ? trim($valor) : '')
            ->filter(fn ($valor) => $valor !== '')
            ->unique()
            ->values();

        $unidadesSelecionadas = collect($request->input('unidade_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $buscaTexto = trim((string) $request->input('busca_texto', ''));
        $ordenarPrevInicio = (string) $request->input('ordenar_prev_inicio', '') === '1';

        $filtrosAplicados = $projetosSelecionados->isNotEmpty()
            || $subprojetosSelecionados->isNotEmpty()
            || $categoriasSelecionadas->isNotEmpty()
            || $fasesSelecionadas->isNotEmpty()
            || $statusesSelecionados->isNotEmpty()
            || $unidadesSelecionadas->isNotEmpty()
            || $buscaTexto !== '';

        return compact(
            'projetosSelecionados',
            'subprojetosSelecionados',
            'categoriasSelecionadas',
            'fasesSelecionadas',
            'statusesSelecionados',
            'unidadesSelecionadas',
            'buscaTexto',
            'ordenarPrevInicio',
            'filtrosAplicados',
        );
    }

    public function form(Request $request, $id = null)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $id ? $this->repository->buscarTarefaFormulario((int) $id, $this->macroprojetoAtivoId()) : null;
        if ($id && !$tarefa) {
            abort(404);
        }

        $backUrl = $request->get('back') ?: route('tarefas.index');

        $categoriaAtualId = isset($tarefa?->categoria_id) ? (int) $tarefa->categoria_id : 0;
        $faseAtualId = isset($tarefa?->fase_id) ? (int) $tarefa->fase_id : 0;
        $projetos = $this->repository->listarProjetos($this->macroprojetoAtivoId());
        $unidades = $this->repository->listarUnidadesParaFormulario($this->macroprojetoAtivoId());
        $grupos = $this->repository->listarGrupos($this->macroprojetoAtivoId());
        $categorias = $this->repository->listarCategoriasComSelecionada($categoriaAtualId);
        $fases = $this->repository->listarFasesComSelecionada($faseAtualId);

        $categoriaContratacoesId = $this->obterCategoriaContratacoesId();
        $somenteCamposRestritos = false;
        $camposRestritosNaoAdmin = $this->permissoes->camposNaoAdminPermitidos();

        return view('planejamento.tarefas.form', compact(
            'tarefa',
            'projetos',
            'unidades',
            'grupos',
            'categorias',
            'fases',
            'backUrl',
            'categoriaContratacoesId',
            'somenteCamposRestritos',
            'camposRestritosNaoAdmin'
        ));
    }

    public function formRestrita(Request $request, int $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());

        $tarefa = $this->repository->buscarTarefaFormulario((int) $id, $this->macroprojetoAtivoId());
        if (!$tarefa) {
            abort(404);
        }

        $this->autorizarTarefaParaNaoAdmin(
            (int) $tarefa->id,
            isset($tarefa->unidade_id) ? (int) $tarefa->unidade_id : null
        );

        $backUrl = $request->get('back') ?: route('tarefas.index');
        $faseAtualId = isset($tarefa?->fase_id) ? (int) $tarefa->fase_id : 0;
        $fases = $this->repository->listarFasesComSelecionada($faseAtualId);

        $categoriaContratacoesId = $this->obterCategoriaContratacoesId();
        $somenteCamposRestritos = true;
        $camposRestritosNaoAdmin = $this->permissoes->camposNaoAdminPermitidos();
        $projetos = $unidades = $grupos = collect();
        $categorias = collect();

        return view('planejamento.tarefas.form', compact(
            'tarefa',
            'projetos',
            'unidades',
            'grupos',
            'categorias',
            'fases',
            'backUrl',
            'categoriaContratacoesId',
            'somenteCamposRestritos',
            'camposRestritosNaoAdmin'
        ));
    }

    public function salvarRestrita(TarefaRestritaRequest $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());

        return $this->salvarCamposRestritos($request->validated());
    }

    private function salvarCamposRestritos(array $dados)
    {
        $id = (int) ($dados['ID'] ?? 0);
        if ($id <= 0) {
            return response()->json(['mensagem' => 'Tarefa inválida.'], 422);
        }

        $this->autorizarTarefaParaNaoAdmin($id);
        $registroAtual = $this->repository->buscarRegistroAtual($id, $this->macroprojetoAtivoId());
        if (!$registroAtual) {
            return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
        }

        $camposPermitidos = $this->permissoes->camposNaoAdminPermitidos();
        $permiteDataInicio = in_array('DATA_REAL_INICIO', $camposPermitidos, true);
        $permiteDataFim = in_array('DATA_REAL_FIM', $camposPermitidos, true);
        $permiteFase = in_array('FASE_ID', $camposPermitidos, true);

        $dados['DATA_REAL_INICIO'] = $permiteDataInicio
            ? DateHelper::normalizarData($dados['DATA_REAL_INICIO'] ?? null)
            : null;
        $dados['DATA_REAL_FIM'] = $permiteDataFim
            ? DateHelper::normalizarData($dados['DATA_REAL_FIM'] ?? null)
            : null;
        $categoriaAtual = isset($registroAtual->categoria_id) ? (int) $registroAtual->categoria_id : null;
        $faseId = $permiteFase && isset($dados['FASE_ID']) ? (int) $dados['FASE_ID'] : null;

        if ($categoriaAtual !== $this->obterCategoriaContratacoesId()) {
            $faseId = null;
        }

        $dataRealInicioFinal = $permiteDataInicio
            ? $dados['DATA_REAL_INICIO']
            : DateHelper::normalizarData($registroAtual->data_real_inicio ?? null);
        $dataRealFimFinal = $permiteDataFim
            ? $dados['DATA_REAL_FIM']
            : DateHelper::normalizarData($registroAtual->data_real_fim ?? null);

        if ($dataRealFimFinal !== null && $dataRealInicioFinal === null) {
            return response()->json([
                'mensagem' => 'Informe a data real de início antes de preencher a data real de término.',
            ], 422);
        }

        $this->repository->atualizarCamposRestritos(
            $id,
            $dados['NR_PROCESSO_SEI'] ?? null,
            $dados['DATA_REAL_INICIO'],
            $dados['DATA_REAL_FIM'],
            $faseId
        );

        return response()->json(['mensagem' => 'Tarefa atualizada com sucesso!']);
    }

    public function iniciarForm(Request $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $backUrl = $request->get('back') ?: route('tarefas.index');

        return view('planejamento.tarefas.inicio', compact('tarefa', 'backUrl'));
    }

    public function iniciarSalvar(TarefaInicioRequest $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $dados = $request->validated();
        $dados['DATA_REAL_INICIO'] = DateHelper::normalizarData($dados['DATA_REAL_INICIO'] ?? null);

        $this->repository->atualizarInicioManual((int) $id, $dados['DATA_REAL_INICIO'], $dados['OBSERVACAO'] ?? null);

        return response()->json(['mensagem' => 'Tarefa iniciada com sucesso!']);
    }

    public function kanbanIniciar($id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->repository->buscarTarefaSimples((int) $id, $this->macroprojetoAtivoId());

        if (!$tarefa) {
            return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
        }

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        if (!empty($tarefa->data_real_inicio)) {
            return response()->json(['mensagem' => 'Esta tarefa já foi iniciada.'], 422);
        }

        $this->repository->marcarInicioAgora((int) $id);

        return response()->json(['mensagem' => 'Tarefa movida para em andamento!']);
    }

    public function kanbanReiniciar($id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->repository->buscarTarefaSimples((int) $id, $this->macroprojetoAtivoId());

        if (!$tarefa) {
            return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
        }

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        if (empty($tarefa->data_real_inicio)) {
            return response()->json(['mensagem' => 'Esta tarefa ainda não foi iniciada.'], 422);
        }

        if (!empty($tarefa->data_real_fim)) {
            return response()->json(['mensagem' => 'Reabra a tarefa concluída antes de movê-la para A iniciar.'], 422);
        }

        $this->repository->limparInicio((int) $id);

        return response()->json(['mensagem' => 'Tarefa retornou para a coluna A iniciar.']);
    }

    public function kanbanFinalizar($id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->repository->buscarTarefaSimples((int) $id, $this->macroprojetoAtivoId());

        if (!$tarefa) {
            return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
        }

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        if (!empty($tarefa->data_real_fim)) {
            return response()->json(['mensagem' => 'Esta tarefa já foi concluída.'], 422);
        }

        if (empty($tarefa->data_real_inicio)) {
            return response()->json(['mensagem' => 'A tarefa precisa ter data real de início antes de ser concluída.'], 422);
        }

        $this->repository->marcarFimAgora((int) $id);

        return response()->json(['mensagem' => 'Tarefa movida para Concluídas!']);
    }

    public function kanbanReabrir($id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->repository->buscarTarefaSimples((int) $id, $this->macroprojetoAtivoId());

        if (!$tarefa) {
            return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
        }

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        if (empty($tarefa->data_real_fim)) {
            return response()->json(['mensagem' => 'Esta tarefa ainda não está concluída.'], 422);
        }

        $this->repository->limparFim((int) $id);

        return response()->json(['mensagem' => 'Tarefa retornou para Em andamento.']);
    }

    public function finalizarForm(Request $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $backUrl = $request->get('back') ?: route('tarefas.index');

        return view('planejamento.tarefas.final', compact('tarefa', 'backUrl'));
    }

    public function finalizarSalvar(TarefaFinalRequest $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        if (empty($tarefa->data_real_inicio)) {
            return response()->json(['mensagem' => 'A tarefa precisa ter data real de início antes de ser finalizada.'], 422);
        }

        $dados = $request->validated();
        $dados['DATA_REAL_FIM'] = DateHelper::normalizarData($dados['DATA_REAL_FIM'] ?? null);

        $this->repository->atualizarFimManual((int) $id, $dados['DATA_REAL_FIM'], $dados['OBSERVACAO'] ?? null);

        return response()->json(['mensagem' => 'Tarefa finalizada com sucesso!']);
    }

    public function andamentos(Request $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $andamentos = $this->repository->listarAndamentos((int) $id);
        $backUrl = $request->get('back') ?: route('tarefas.index');

        return view('planejamento.tarefas.andamentos', compact('tarefa', 'andamentos', 'backUrl'));
    }

    public function salvarAndamento(TarefaAndamentoRequest $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $dados = $request->validated();
        $usuario = $this->resolverUsuarioAndamento();

        $this->repository->inserirAndamento(
            (int) $id,
            (string) $dados['DESCRICAO'],
            (string) ($dados['TIPO'] ?? 'ANDAMENTO'),
            $usuario ? (string) $usuario : null
        );

        $params = ['id' => (int) $id];
        if (!empty($dados['back'])) {
            $params['back'] = $dados['back'];
        }

        return redirect()->route('tarefas.andamentos', $params)
            ->with('sucesso', 'Andamento registrado com sucesso!');
    }

    public function painelSolicitacoesPrazo(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $perPage = 20;
        $statusFiltro = strtoupper(trim((string) $request->input('status', 'PENDENTE')));
        if (!in_array($statusFiltro, ['TODOS', 'PENDENTE', 'APROVADA', 'REJEITADA'], true)) {
            $statusFiltro = 'PENDENTE';
        }
        $tipoFiltro = strtoupper(trim((string) $request->input('tipo', 'TODOS')));
        if (!in_array($tipoFiltro, ['TODOS', 'ALTERACAO', 'EXCLUSAO'], true)) {
            $tipoFiltro = 'TODOS';
        }

        $projetoId = (int) $request->input('projeto_id', 0);
        $unidadeId = (int) $request->input('unidade_id', 0);
        $dataDe = $this->normalizarDataFiltro($request->input('data_solicitacao_de'));
        $dataAte = $this->normalizarDataFiltro($request->input('data_solicitacao_ate'));

        $filtros = [
            'status' => $statusFiltro === 'TODOS' ? null : $statusFiltro,
            'tipo' => $tipoFiltro === 'TODOS' ? null : $tipoFiltro,
            'projeto_id' => $projetoId > 0 ? $projetoId : null,
            'unidade_id' => $unidadeId > 0 ? $unidadeId : null,
            'data_solicitacao_de' => $dataDe,
            'data_solicitacao_ate' => $dataAte,
        ];

        $solicitacoes = $this->repository->listarSolicitacoesAlteracaoPrazoPainel($filtros, $this->macroprojetoAtivoId(), $perPage);

        $projetos = $this->repository->listarProjetos($this->macroprojetoAtivoId());
        $unidades = $this->repository->listarUnidades();
        $totais = collect($this->repository->contarSolicitacoesAlteracaoPrazoPainelPorStatus($filtros, $this->macroprojetoAtivoId()));

        return view('planejamento.tarefas.solicitacoes_prazo_painel', [
            'solicitacoes' => $solicitacoes,
            'projetos' => $projetos,
            'unidades' => $unidades,
            'statusFiltro' => $statusFiltro,
            'tipoFiltro' => $tipoFiltro,
            'projetoId' => $projetoId,
            'unidadeId' => $unidadeId,
            'dataSolicitacaoDe' => $dataDe,
            'dataSolicitacaoAte' => $dataAte,
            'totais' => $totais,
        ]);
    }

    public function solicitacoesPrazo(Request $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaFormularioOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $solicitacoes = $this->repository->listarSolicitacoesAlteracaoPrazo((int) $id);
        $unidades = $this->repository->listarUnidades();
        $backUrl = $request->get('back') ?: route('tarefas.index');
        $isAdmin = $this->usuarioPodeDecidirSolicitacaoPrazo();

        return view('planejamento.tarefas.solicitacoes_prazo', compact(
            'tarefa',
            'solicitacoes',
            'unidades',
            'backUrl',
            'isAdmin'
        ));
    }

    public function solicitacoesPrazoLote(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $this->autorizarSolicitacaoPrazoLoteAdmin();

        $filtrosConsulta = $this->normalizarFiltrosSolicitacaoPrazoLote($request->all());
        $tarefaIds = $this->resolverIdsSolicitacaoPrazoLote($request->all());
        $backUrl = $request->get('back') ?: route('tarefas.index');
        $selecionarConsultaCompleta = (string) $request->input('SELECIONAR_CONSULTA_COMPLETA', '0') === '1';

        if ($tarefaIds === []) {
            return redirect()->to($backUrl)
                ->with('erro', 'Selecione ao menos uma atividade para solicitar alteração em lote.');
        }

        $tarefas = collect($tarefaIds)
            ->map(fn (int $id) => $this->repository->buscarTarefaFormulario($id, $this->macroprojetoAtivoId()))
            ->filter()
            ->values()
            ->all();

        if ($tarefas === []) {
            return redirect()->to($backUrl)
                ->with('erro', 'Nenhuma atividade válida foi encontrada para a solicitação em lote.');
        }

        $unidades = $this->repository->listarUnidades();
        $permiteAlteracaoUnidadeLote = $this->permiteAlteracaoUnidadeEmLote($tarefas);

        $totalTarefasSelecionadas = count($tarefaIds);

        return view('planejamento.tarefas.solicitacoes_prazo_lote', compact(
            'tarefas',
            'unidades',
            'permiteAlteracaoUnidadeLote',
            'backUrl',
            'selecionarConsultaCompleta',
            'filtrosConsulta',
            'totalTarefasSelecionadas'
        ));
    }

    public function salvarSolicitacaoPrazo(TarefaSolicitacaoPrazoRequest $request, $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaFormularioOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $dados = $request->validated();
        $tipoSolicitacao = strtoupper((string) ($dados['TIPO_SOLICITACAO'] ?? 'ALTERACAO'));
        $novaDataInicio = $dados['DATA_PREVISTA_INICIO_NOVA'] ?? null;
        $novaDataFim = $dados['DATA_PREVISTA_FIM_NOVA'] ?? null;
        $novaUnidadeId = isset($dados['UNIDADE_ID_NOVA']) ? (int) $dados['UNIDADE_ID_NOVA'] : null;
        $novoNome = isset($dados['NOME_NOVO']) ? trim((string) $dados['NOME_NOVO']) : null;
        $novaDescricao = isset($dados['DESCRICAO_NOVA']) ? trim((string) $dados['DESCRICAO_NOVA']) : null;
        $dataInicioResultado = $novaDataInicio ?: ($tarefa->data_prevista_inicio ?? null);
        $dataFimResultado = $novaDataFim ?: ($tarefa->data_prevista_fim ?? null);

        if ($tipoSolicitacao === 'EXCLUSAO') {
            $novaDataInicio = null;
            $novaDataFim = null;
            $novaUnidadeId = null;
            $novoNome = null;
            $novaDescricao = null;
        }

        $houveAlteracaoDeDatas = $tipoSolicitacao === 'ALTERACAO' && (!empty($novaDataInicio) || !empty($novaDataFim));
        if ($houveAlteracaoDeDatas && !empty($dataInicioResultado) && !empty($dataFimResultado) && $dataFimResultado <= $dataInicioResultado) {
            $params = ['id' => (int) $id];
            if (!empty($dados['back'])) {
                $params['back'] = $dados['back'];
            }

            return redirect()->route('tarefas.solicitacoes.prazo', $params)
                ->withInput()
                ->withErrors([
                    'DATA_PREVISTA_FIM_NOVA' => 'A nova combinação de datas é inválida: a previsão de término deve ser posterior à de início.',
                ]);
        }

        if ($tipoSolicitacao === 'ALTERACAO' && !empty($novaDataInicio) && (string) $novaDataInicio === (string) ($tarefa->data_prevista_inicio ?? '')) {
            $params = ['id' => (int) $id];
            if (!empty($dados['back'])) {
                $params['back'] = $dados['back'];
            }

            return redirect()->route('tarefas.solicitacoes.prazo', $params)
                ->withInput()
                ->withErrors([
                    'DATA_PREVISTA_INICIO_NOVA' => 'A nova previsão de início deve ser diferente da data atual da tarefa.',
                ]);
        }

        if ($tipoSolicitacao === 'ALTERACAO' && !empty($novaDataFim) && (string) $novaDataFim === (string) ($tarefa->data_prevista_fim ?? '')) {
            $params = ['id' => (int) $id];
            if (!empty($dados['back'])) {
                $params['back'] = $dados['back'];
            }

            return redirect()->route('tarefas.solicitacoes.prazo', $params)
                ->withInput()
                ->withErrors([
                    'DATA_PREVISTA_FIM_NOVA' => 'A nova previsão de término deve ser diferente da data atual da tarefa.',
                ]);
        }

        if ($tipoSolicitacao === 'ALTERACAO' && !empty($novaUnidadeId) && (int) ($tarefa->unidade_id ?? 0) === $novaUnidadeId) {
            $params = ['id' => (int) $id];
            if (!empty($dados['back'])) {
                $params['back'] = $dados['back'];
            }

            return redirect()->route('tarefas.solicitacoes.prazo', $params)
                ->withInput()
                ->withErrors([
                    'UNIDADE_ID_NOVA' => 'A nova unidade responsável deve ser diferente da unidade atual.',
                ]);
        }

        if ($tipoSolicitacao === 'ALTERACAO' && !empty($novaUnidadeId)) {
            $unidadeExiste = collect($this->repository->listarUnidades())
                ->contains(fn ($unidade) => (int) ($unidade->id ?? 0) === $novaUnidadeId);
            if (!$unidadeExiste) {
                $params = ['id' => (int) $id];
                if (!empty($dados['back'])) {
                    $params['back'] = $dados['back'];
                }

                return redirect()->route('tarefas.solicitacoes.prazo', $params)
                    ->withInput()
                    ->withErrors([
                        'UNIDADE_ID_NOVA' => 'A nova unidade responsável informada é inválida.',
                    ]);
            }
        }

        if ($tipoSolicitacao === 'ALTERACAO' && !empty($novoNome) && $novoNome === trim((string) ($tarefa->nome ?? ''))) {
            $params = ['id' => (int) $id];
            if (!empty($dados['back'])) {
                $params['back'] = $dados['back'];
            }

            return redirect()->route('tarefas.solicitacoes.prazo', $params)
                ->withInput()
                ->withErrors([
                    'NOME_NOVO' => 'O novo nome da atividade deve ser diferente do nome atual.',
                ]);
        }

        if ($tipoSolicitacao === 'ALTERACAO' && !empty($novaDescricao) && $novaDescricao === trim((string) ($tarefa->descricao ?? ''))) {
            $params = ['id' => (int) $id];
            if (!empty($dados['back'])) {
                $params['back'] = $dados['back'];
            }

            return redirect()->route('tarefas.solicitacoes.prazo', $params)
                ->withInput()
                ->withErrors([
                    'DESCRICAO_NOVA' => 'A nova descrição da atividade deve ser diferente da descrição atual.',
                ]);
        }

        $this->repository->inserirSolicitacaoAlteracaoPrazo(
            (int) $id,
            $tipoSolicitacao,
            $novaDataInicio,
            $novaDataFim,
            $novaUnidadeId,
            $novoNome ?: null,
            $novaDescricao ?: null,
            (string) $dados['JUSTIFICATIVA'],
            $this->resolverUsuarioAndamento()
        );

        $params = ['id' => (int) $id];
        if (!empty($dados['back'])) {
            $params['back'] = $dados['back'];
        }

        return redirect()->route('tarefas.solicitacoes.prazo', $params)
            ->with('sucesso', 'Solicitação enviada para aprovação.');
    }

    public function salvarSolicitacaoPrazoLote(TarefaSolicitacaoPrazoLoteRequest $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $this->autorizarSolicitacaoPrazoLoteAdmin();

        $dados = $request->validated();
        $filtrosConsulta = $this->normalizarFiltrosSolicitacaoPrazoLote($dados);
        $tarefaIds = $this->resolverIdsSolicitacaoPrazoLote($dados);
        $params = $this->montarParametrosRetornoSolicitacaoPrazoLote($dados, $tarefaIds, $filtrosConsulta);

        if ($tarefaIds === []) {
            return redirect()->route('tarefas.solicitacoes.prazo.lote', $params)
                ->with('erro', 'Selecione ao menos uma atividade para solicitar alteração em lote.');
        }

        $unidades = $this->repository->listarUnidades();
        $tarefas = collect($tarefaIds)
            ->map(fn (int $tarefaId) => [
                'id' => $tarefaId,
                'tarefa' => $this->repository->buscarTarefaFormulario((int) $tarefaId, $this->macroprojetoAtivoId()),
            ])
            ->values();
        $permiteAlteracaoUnidadeLote = $this->permiteAlteracaoUnidadeEmLote(
            $tarefas->pluck('tarefa')->filter()
        );

        if (!empty($dados['UNIDADE_ID_NOVA']) && !$permiteAlteracaoUnidadeLote) {
            return redirect()->route('tarefas.solicitacoes.prazo.lote', $params)
                ->withInput()
                ->with('erro', 'A alteração de unidade em lote só é permitida quando todas as atividades selecionadas pertencem à mesma unidade atual.');
        }

        $sucessos = 0;
        $falhas = [];

        foreach ($tarefas as $item) {
            $tarefaId = (int) ($item['id'] ?? 0);
            $tarefa = $item['tarefa'] ?? null;
            if (!$tarefa) {
                $falhas[] = "Atividade #{$tarefaId}: atividade não encontrada.";
                continue;
            }

            $resultado = $this->validarSolicitacaoPrazoParaTarefa($tarefa, $dados, $unidades);
            if ($resultado['erro'] !== null) {
                $falhas[] = "Atividade #{$tarefaId}: {$resultado['erro']}";
                continue;
            }

            $this->repository->inserirSolicitacaoAlteracaoPrazo(
                (int) $tarefaId,
                $resultado['tipo_solicitacao'],
                $resultado['data_prevista_inicio_nova'],
                $resultado['data_prevista_fim_nova'],
                $resultado['unidade_id_nova'],
                $resultado['nome_novo'],
                $resultado['descricao_nova'],
                (string) $dados['JUSTIFICATIVA'],
                $this->resolverUsuarioAndamento()
            );

            $sucessos++;
        }

        $response = redirect()->route('tarefas.solicitacoes.prazo.lote', $params);

        if ($sucessos > 0) {
            $label = $sucessos === 1 ? 'solicitação enviada' : 'solicitações enviadas';
            $response->with('sucesso', "{$sucessos} {$label} para aprovação.");
        }

        if ($falhas !== []) {
            $response->with('falhas_lote_solicitacao_prazo', $falhas);
        }

        if ($sucessos === 0) {
            $response->with('erro', 'Nenhuma solicitação em lote pôde ser enviada.');
        }

        return $response;
    }

    public function aprovarSolicitacaoPrazo(Request $request, $id, $solicitacaoId)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $solicitacao = $this->repository->buscarSolicitacaoAlteracaoPrazo((int) $id, (int) $solicitacaoId);
        if (!$solicitacao) {
            abort(404);
        }

        if (($solicitacao->status ?? '') !== 'PENDENTE') {
            return back()->with('erro', 'Esta solicitação não está mais pendente.');
        }
        $tipoSolicitacao = strtoupper((string) ($solicitacao->tipo_solicitacao ?? 'ALTERACAO'));

        $this->repository->aprovarSolicitacaoAlteracaoPrazo(
            (int) $id,
            (int) $solicitacaoId,
            $this->resolverUsuarioAndamento()
        );

        $backUrl = $request->get('back');
        $origem = (string) $request->input('origem', '');
        $mensagemSucesso = $tipoSolicitacao === 'EXCLUSAO'
            ? 'Solicitação aprovada e tarefa excluída.'
            : 'Solicitação aprovada e tarefa atualizada.';
        if ($origem === 'painel' && is_string($backUrl) && trim($backUrl) !== '' && $this->isBackUrlInterna($backUrl)) {
            return redirect()->to($backUrl)
                ->with('sucesso', $mensagemSucesso);
        }

        if ($tipoSolicitacao === 'EXCLUSAO') {
            if (is_string($backUrl) && trim($backUrl) !== '' && $this->isBackUrlInterna($backUrl)) {
                return redirect()->to($backUrl)->with('sucesso', $mensagemSucesso);
            }

            return redirect()->route('tarefas.index')
                ->with('sucesso', $mensagemSucesso);
        }

        $params = ['id' => (int) $id];
        if (is_string($backUrl) && trim($backUrl) !== '') {
            $params['back'] = $backUrl;
        }

        return redirect()->route('tarefas.solicitacoes.prazo', $params)
            ->with('sucesso', $mensagemSucesso);
    }

    public function rejeitarSolicitacaoPrazo(TarefaSolicitacaoPrazoDecisaoRequest $request, $id, $solicitacaoId)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $solicitacao = $this->repository->buscarSolicitacaoAlteracaoPrazo((int) $id, (int) $solicitacaoId);
        if (!$solicitacao) {
            abort(404);
        }

        if (($solicitacao->status ?? '') !== 'PENDENTE') {
            return back()->with('erro', 'Esta solicitação não está mais pendente.');
        }

        $dados = $request->validated();
        $this->repository->rejeitarSolicitacaoAlteracaoPrazo(
            (int) $id,
            (int) $solicitacaoId,
            (string) $dados['MOTIVO_DECISAO'],
            $this->resolverUsuarioAndamento()
        );

        $origem = (string) $request->input('origem', '');
        $backUrl = (string) ($dados['back'] ?? '');
        if ($origem === 'painel' && $backUrl !== '' && $this->isBackUrlInterna($backUrl)) {
            return redirect()->to($backUrl)
                ->with('sucesso', 'Solicitação rejeitada.');
        }

        $params = ['id' => (int) $id];
        if (!empty($dados['back'])) {
            $params['back'] = $dados['back'];
        }

        return redirect()->route('tarefas.solicitacoes.prazo', $params)
            ->with('sucesso', 'Solicitação rejeitada.');
    }

    public function deletarAndamento(Request $request, $id, $andamentoId)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $this->repository->deletarAndamento((int) $id, (int) $andamentoId);

        $backUrl = $request->get('back');
        $params = ['id' => (int) $id];
        if (is_string($backUrl) && trim($backUrl) !== '') {
            $params['back'] = $backUrl;
        }

        return redirect()->route('tarefas.andamentos', $params)
            ->with('sucesso', 'Andamento excluído com sucesso!');
    }

    public function editarAndamento(Request $request, $id, $andamentoId)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $andamento = $this->repository->buscarAndamento((int) $id, (int) $andamentoId);
        if (!$andamento) {
            abort(404);
        }

        $backUrl = $request->get('back') ?: route('tarefas.index');

        return view('planejamento.tarefas.andamento_editar', compact('tarefa', 'andamento', 'backUrl'));
    }

    public function atualizarAndamento(TarefaAndamentoRequest $request, $id, $andamentoId)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $tarefa = $this->buscarTarefaSimplesOu404((int) $id);

        $this->autorizarTarefaParaNaoAdmin((int) $id);

        $andamento = $this->repository->buscarAndamento((int) $id, (int) $andamentoId);
        if (!$andamento) {
            abort(404);
        }

        $dados = $request->validated();
        $this->repository->atualizarAndamento(
            (int) $id,
            (int) $andamentoId,
            (string) $dados['DESCRICAO'],
            (string) ($dados['TIPO'] ?? 'ANDAMENTO')
        );

        $params = ['id' => (int) $id];
        if (!empty($dados['back'])) {
            $params['back'] = $dados['back'];
        }

        return redirect()->route('tarefas.andamentos', $params)
            ->with('sucesso', 'Andamento atualizado com sucesso!');
    }

    public function salvar(TarefaRequest $req)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());

        $d = $req->validated();
        $subprojetoId = (int) ($d['SUBPROJETO_ID'] ?? 0);
        $subprojetoValido = collect($this->repository->buscarSubprojetosPorIds([$subprojetoId], $this->macroprojetoAtivoId()))
            ->contains(fn ($item) => (int) ($item->id ?? 0) === $subprojetoId);

        if ($subprojetoId <= 0 || !$subprojetoValido) {
            return response()->json(['mensagem' => 'Subprojeto inválido para o macroprojeto ativo.'], 422);
        }

        $categoriaId = isset($d['CATEGORIA_ID']) ? (int) $d['CATEGORIA_ID'] : null;
        $nrProcessoSei = $d['NR_PROCESSO_SEI'] ?? null;
        $faseId = isset($d['FASE_ID']) ? (int) $d['FASE_ID'] : null;
        $categoriaContratacoesId = $this->obterCategoriaContratacoesId();

        if ($categoriaId !== $categoriaContratacoesId) {
            $faseId = null;
        }

        $d['DATA_PREVISTA_INICIO'] = DateHelper::normalizarData($d['DATA_PREVISTA_INICIO'] ?? null);
        $d['DATA_PREVISTA_FIM'] = DateHelper::normalizarData($d['DATA_PREVISTA_FIM'] ?? null);
        $d['DATA_REAL_INICIO'] = DateHelper::normalizarData($d['DATA_REAL_INICIO'] ?? null);
        $d['DATA_REAL_FIM'] = DateHelper::normalizarData($d['DATA_REAL_FIM'] ?? null);

        if ($d['DATA_REAL_FIM'] !== null && $d['DATA_REAL_INICIO'] === null) {
            return response()->json([
                'mensagem' => 'Informe a data real de início antes de preencher a data real de término.',
            ], 422);
        }

        $payloadBase = [
            'subprojeto_id' => $d['SUBPROJETO_ID'],
            'nome' => $d['NOME'],
            'descricao' => $d['DESCRICAO'],
            'dpi' => $d['DATA_PREVISTA_INICIO'],
            'dpf' => $d['DATA_PREVISTA_FIM'],
            'dri' => $d['DATA_REAL_INICIO'],
            'drf' => $d['DATA_REAL_FIM'],
            'grupo_unidade_id' => $d['GRUPO_UNIDADE_ID'] ?? null,
            'horas_extras' => $d['HORAS_EXTRAS'] ?? null,
            'pessoas_envolvidas' => $d['PESSOAS_ENVOLVIDAS'] ?? null,
            'categoria_id' => $categoriaId,
            'fase_id' => $faseId,
            'nr_processo_sei' => $nrProcessoSei,
        ];

        if (!empty($d['ID'])) {
            $registroAtual = $this->repository->buscarRegistroAtual((int) $d['ID'], $this->macroprojetoAtivoId());

            if (!$registroAtual) {
                return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
            }

            $loteIdAtual = isset($registroAtual->lote_id) ? (int) $registroAtual->lote_id : null;
            $grupoOriginal = isset($registroAtual->grupo_unidade_id) ? (int) $registroAtual->grupo_unidade_id : null;
            $subprojetoOriginal = isset($registroAtual->subprojeto_id) ? (int) $registroAtual->subprojeto_id : null;

            $aplicarLote = !empty($d['APLICAR_LOTE']);

            if ($aplicarLote && ($loteIdAtual || $grupoOriginal)) {
                if ($loteIdAtual) {
                    $this->repository->atualizarPorLote($loteIdAtual, $payloadBase);
                } else {
                    $this->repository->atualizarPorGrupo($grupoOriginal, $subprojetoOriginal, $payloadBase);
                }

                return response()->json(['mensagem' => 'Tarefas do grupo atualizadas com sucesso!']);
            }

            $unidadeId = $d['UNIDADE_ID'] ?? $this->repository->buscarUnidadeDaTarefa((int) $d['ID'], $this->macroprojetoAtivoId());

            $this->repository->atualizarTarefa((int) $d['ID'], $payloadBase + [
                'unidade_id' => $unidadeId,
            ]);

            return response()->json(['mensagem' => 'Tarefa atualizada com sucesso!']);
        }

        $grupoId = isset($d['GRUPO_UNIDADE_ID']) ? (int) $d['GRUPO_UNIDADE_ID'] : null;
        if ($grupoId <= 0) {
            $grupoId = null;
        }

        $unidades = $this->obterUnidadesParaCriacao($grupoId, $d['UNIDADES'] ?? []);

        if ($unidades->isEmpty()) {
            return response()->json(['mensagem' => 'Selecione ao menos uma unidade.'], 422);
        }

        try {
            $this->repository->criarTarefasParaUnidades($payloadBase, $unidades, $grupoId);
        } catch (\Throwable $e) {
            \Log::error('Erro ao criar tarefas', ['mensagem' => $e->getMessage(), 'payload' => $payloadBase]);
            return response()->json([
                'mensagem' => 'Erro ao criar tarefas: ' . $e->getMessage()
            ], 500);
        }

        $quantidade = $unidades->count();
        $texto = $quantidade > 1
            ? "{$quantidade} tarefas criadas com sucesso!"
            : 'Tarefa criada com sucesso!';

        return response()->json(['mensagem' => $texto]);
    }

    private function obterUnidadesParaCriacao(?int $grupoId, array $unidadesSelecionadas): Collection
    {
        if ($grupoId) {
            return $this->repository->listarUnidadesPorGrupo($grupoId)
                ->map(fn ($valor) => (int) $valor)
                ->filter(fn ($valor) => $valor > 0)
                ->unique()
                ->values();
        }

        return collect($unidadesSelecionadas)
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();
    }


    public function deletar($id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());

        $tarefa = $this->repository->buscarTarefaSimples((int) $id, $this->macroprojetoAtivoId());
        if (!$tarefa) {
            return response()->json(['mensagem' => 'Tarefa não encontrada.'], 404);
        }

        try {
            $this->repository->deletarTarefa((int) $id);
            return response()->json(['mensagem' => 'Tarefa excluída com sucesso!']);
        } catch (\Throwable $e) {
            return response()->json(['mensagem' => 'Erro ao excluir a tarefa: ' . $e->getMessage()], 500);
        }
    }

    // === Endpoints AJAX ===

    public function subprojetos(Request $req)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $termo = strtoupper($req->get('q', ''));
        $listaProjetos = collect($req->input('projetos', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->values()
            ->all();

        $projetoId = $req->get('projeto_id');

        $rows = $this->repository->buscarSubprojetosAjax($termo, $listaProjetos, $projetoId ? (int) $projetoId : null, $this->macroprojetoAtivoId());

        return response()->json($rows);
    }

    private function obterCategoriaContratacoesId(): int
    {
        return (int) config('planejamento.categoria_contratacoes_id', 2);
    }

    private function resolverUsuarioAndamento(): ?string
    {
        $usuarioSessao = session('user');

        if (is_string($usuarioSessao) && trim($usuarioSessao) !== '') {
            return trim($usuarioSessao);
        }

        if (is_array($usuarioSessao)) {
            $candidato = $usuarioSessao['username'] ?? $usuarioSessao['name'] ?? $usuarioSessao['user'] ?? null;
            if (is_string($candidato) && trim($candidato) !== '') {
                return trim($candidato);
            }
        }

        if (is_object($usuarioSessao)) {
            $candidato = $usuarioSessao->username ?? $usuarioSessao->name ?? $usuarioSessao->user ?? null;
            if (is_string($candidato) && trim($candidato) !== '') {
                return trim($candidato);
            }
        }

        $username = session('username');
        if (is_string($username) && trim($username) !== '') {
            return trim($username);
        }

        $authUserName = auth()->user()->name ?? null;
        if (is_string($authUserName) && trim($authUserName) !== '') {
            return trim($authUserName);
        }

        return null;
    }

    private function normalizarIdsSolicitacaoPrazoLote($ids): array
    {
        return collect(Arr::wrap($ids))
            ->flatten()
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn (int $valor) => $valor > 0)
            ->unique()
            ->values()
            ->all();
    }

    private function normalizarFiltrosSolicitacaoPrazoLote(array $dados): array
    {
        return [
            'projetos' => $this->normalizarIdsSolicitacaoPrazoLote($dados['projeto_id'] ?? []),
            'subprojetos' => $this->normalizarIdsSolicitacaoPrazoLote($dados['subprojeto_id'] ?? []),
            'statuses' => collect(Arr::wrap($dados['status'] ?? []))
                ->flatten()
                ->map(fn ($valor) => mb_strtoupper(trim((string) $valor)))
                ->filter(fn ($valor) => $valor !== '')
                ->unique()
                ->values()
                ->all(),
            'unidades' => $this->normalizarIdsSolicitacaoPrazoLote($dados['unidade_id'] ?? []),
            'categorias' => $this->normalizarIdsSolicitacaoPrazoLote($dados['categoria_id'] ?? []),
            'fases' => $this->normalizarIdsSolicitacaoPrazoLote($dados['fase_id'] ?? []),
            'busca_texto' => trim((string) ($dados['busca_texto'] ?? '')),
            'ordenar_prev_inicio' => (string) ($dados['ordenar_prev_inicio'] ?? '0') === '1',
        ];
    }

    private function resolverIdsSolicitacaoPrazoLote(array $dados): array
    {
        $selecionarConsultaCompleta = (string) ($dados['SELECIONAR_CONSULTA_COMPLETA'] ?? '0') === '1';
        if ($selecionarConsultaCompleta) {
            return $this->repository->listarIdsTarefas(
                $this->normalizarFiltrosSolicitacaoPrazoLote($dados),
                $this->unidadesPermitidas(),
                $this->macroprojetoAtivoId()
            );
        }

        return $this->normalizarIdsSolicitacaoPrazoLote($dados['TAREFA_IDS'] ?? []);
    }

    private function montarParametrosRetornoSolicitacaoPrazoLote(array $dados, array $tarefaIds, array $filtrosConsulta): array
    {
        $params = [];
        if ((string) ($dados['SELECIONAR_CONSULTA_COMPLETA'] ?? '0') === '1') {
            $params['SELECIONAR_CONSULTA_COMPLETA'] = 1;
            foreach ([
                'projetos' => 'projeto_id',
                'subprojetos' => 'subprojeto_id',
                'statuses' => 'status',
                'unidades' => 'unidade_id',
                'categorias' => 'categoria_id',
                'fases' => 'fase_id',
            ] as $origem => $destino) {
                if (!empty($filtrosConsulta[$origem])) {
                    $params[$destino] = $filtrosConsulta[$origem];
                }
            }
            if (($filtrosConsulta['busca_texto'] ?? '') !== '') {
                $params['busca_texto'] = $filtrosConsulta['busca_texto'];
            }
            if (!empty($filtrosConsulta['ordenar_prev_inicio'])) {
                $params['ordenar_prev_inicio'] = '1';
            }
        } else {
            $params['TAREFA_IDS'] = $tarefaIds;
        }

        if (!empty($dados['back'])) {
            $params['back'] = $dados['back'];
        }

        return $params;
    }

    private function validarSolicitacaoPrazoParaTarefa(object $tarefa, array $dados, array $unidadesDisponiveis = []): array
    {
        $tipoSolicitacao = strtoupper((string) ($dados['TIPO_SOLICITACAO'] ?? 'ALTERACAO'));
        $novaDataInicio = $dados['DATA_PREVISTA_INICIO_NOVA'] ?? null;
        $novaDataFim = $dados['DATA_PREVISTA_FIM_NOVA'] ?? null;
        $novaUnidadeId = isset($dados['UNIDADE_ID_NOVA']) ? (int) $dados['UNIDADE_ID_NOVA'] : null;
        $novoNome = isset($dados['NOME_NOVO']) ? trim((string) $dados['NOME_NOVO']) : null;
        $novaDescricao = isset($dados['DESCRICAO_NOVA']) ? trim((string) $dados['DESCRICAO_NOVA']) : null;
        $dataInicioResultado = $novaDataInicio ?: ($tarefa->data_prevista_inicio ?? null);
        $dataFimResultado = $novaDataFim ?: ($tarefa->data_prevista_fim ?? null);

        if ($tipoSolicitacao === 'EXCLUSAO') {
            return [
                'erro' => null,
                'tipo_solicitacao' => 'EXCLUSAO',
                'data_prevista_inicio_nova' => null,
                'data_prevista_fim_nova' => null,
                'unidade_id_nova' => null,
                'nome_novo' => null,
                'descricao_nova' => null,
            ];
        }

        $houveAlteracaoDeDatas = !empty($novaDataInicio) || !empty($novaDataFim);
        if ($houveAlteracaoDeDatas && !empty($dataInicioResultado) && !empty($dataFimResultado) && $dataFimResultado <= $dataInicioResultado) {
            return [
                'erro' => 'A nova combinação de datas é inválida: a previsão de término deve ser posterior à de início.',
            ];
        }

        if (!empty($novaDataInicio) && (string) $novaDataInicio === (string) ($tarefa->data_prevista_inicio ?? '')) {
            return [
                'erro' => 'A nova previsão de início deve ser diferente da data atual da tarefa.',
            ];
        }

        if (!empty($novaDataFim) && (string) $novaDataFim === (string) ($tarefa->data_prevista_fim ?? '')) {
            return [
                'erro' => 'A nova previsão de término deve ser diferente da data atual da tarefa.',
            ];
        }

        if (!empty($novaUnidadeId) && (int) ($tarefa->unidade_id ?? 0) === $novaUnidadeId) {
            return [
                'erro' => 'A nova unidade responsável deve ser diferente da unidade atual.',
            ];
        }

        if (!empty($novaUnidadeId)) {
            $unidadeExiste = collect($unidadesDisponiveis)
                ->contains(fn ($unidade) => (int) ($unidade->id ?? 0) === $novaUnidadeId);
            if (!$unidadeExiste) {
                return [
                    'erro' => 'A nova unidade responsável informada é inválida.',
                ];
            }
        }

        if (!empty($novoNome) && $novoNome === trim((string) ($tarefa->nome ?? ''))) {
            return [
                'erro' => 'O novo nome da atividade deve ser diferente do nome atual.',
            ];
        }

        if (!empty($novaDescricao) && $novaDescricao === trim((string) ($tarefa->descricao ?? ''))) {
            return [
                'erro' => 'A nova descrição da atividade deve ser diferente da descrição atual.',
            ];
        }

        return [
            'erro' => null,
            'tipo_solicitacao' => 'ALTERACAO',
            'data_prevista_inicio_nova' => $novaDataInicio,
            'data_prevista_fim_nova' => $novaDataFim,
            'unidade_id_nova' => $novaUnidadeId,
            'nome_novo' => $novoNome ?: null,
            'descricao_nova' => $novaDescricao ?: null,
        ];
    }

    private function permiteAlteracaoUnidadeEmLote(iterable $tarefas): bool
    {
        $unidadesOrigem = collect($tarefas)
            ->map(function ($tarefa) {
                if (!is_object($tarefa)) {
                    return '__SEM_UNIDADE__';
                }

                $unidadeId = $tarefa->unidade_id ?? null;
                if ($unidadeId === null || $unidadeId === '') {
                    return '__SEM_UNIDADE__';
                }

                return (string) (int) $unidadeId;
            })
            ->filter(static fn ($unidadeId) => $unidadeId !== null)
            ->unique()
            ->values();

        return $unidadesOrigem->count() <= 1;
    }

    private function normalizarDataFiltro($valor): ?string
    {
        if (!is_string($valor)) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        try {
            return Carbon::createFromFormat('Y-m-d', $valor)->format('Y-m-d');
        } catch (\Throwable) {
            return null;
        }
    }

    private function isBackUrlInterna(string $backUrl): bool
    {
        $url = trim($backUrl);
        if ($url === '') {
            return false;
        }

        if (Str::startsWith($url, ['/'])) {
            return true;
        }

        $appUrl = rtrim(url('/'), '/');
        return Str::startsWith($url, [$appUrl . '/']);
    }

    public function projetos(Request $req)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $termo = strtoupper($req->get('q', ''));
        $projetos = $this->repository->buscarProjetosAjax($termo, $this->macroprojetoAtivoId());

        return response()->json($projetos);
    }

    public function unidades(Request $req)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoId());
        $termo = strtoupper($req->get('q', ''));
        $unidades = $this->repository->buscarUnidadesAjax($termo);

        return response()->json($unidades);
    }

}
```
</APP_HTTP_CONTROLLERS_TAREFAS_TAREFACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Tarefas/TarefaMonitoramentoController.php`
## <APP_HTTP_CONTROLLERS_TAREFAS_TAREFAMONITORAMENTOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Tarefas/TarefaMonitoramentoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Tarefas`
- **Entidade / Classe:** `class TarefaMonitoramentoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function monitoramento(Request $request)
public function monitoramentoGeral(Request $request)
public function monitoramentoGeralPublico(Request $request): View
private function renderMonitoramento(
private function montarPainelMonitoramento(Collection $tarefas): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Tarefas;

use App\Http\Controllers\Controller;

use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Support\Tarefas\TarefaStatus;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Collection;
use Illuminate\View\View;

class TarefaMonitoramentoController extends Controller
{
    public function __construct(
        private readonly TarefaRepositoryInterface $repository,
        private readonly EscopoUnidadeService $escopoUnidadeService
    )
    {
    }

    public function monitoramento(Request $request)
    {
        return $this->renderMonitoramento($request, true, false, 'tarefas.monitoramento');
    }

    public function monitoramentoGeral(Request $request)
    {
        return $this->renderMonitoramento($request, false, true, 'tarefas.monitoramento.geral');
    }

    public function monitoramentoGeralPublico(Request $request): View
    {
        $macroprojetoId = $this->repository->buscarMacroprojetoAtivoPublico();
        abort_if(!$macroprojetoId, 404, 'Monitoramento público indisponível.');

        $dados = $this->montarPainelMonitoramento(
            $this->repository->buscarTarefasMonitoramentoPublico($macroprojetoId)
        );

        return view('planejamento.tarefas.monitoramento_publico', array_merge($dados, [
            'macroprojetoNome' => 'Eleições 2026',
            'semLinksAtividades' => true,
            'limparRouteName' => 'tarefas.monitoramento.geral.publico',
        ]));
    }

    private function renderMonitoramento(
        Request $request,
        bool $aplicarEscopoUnidades,
        bool $semLinksAtividades,
        string $limparRouteName
    ) {
        $routeName = (string) optional($request->route())->getName();
        $bypassRoutes = config('planeleito.auth.route_acl_bypass_routes', []);
        $isBypassRoute = in_array($routeName, $bypassRoutes, true);

        if (!$isBypassRoute) {
            $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());
        }

        $projetos = $this->repository->listarProjetos($this->macroprojetoAtivoIdSessao());
        $unidades = $this->repository->listarUnidades();
        $categorias = $this->repository->listarCategoriasAtivas($this->macroprojetoAtivoIdSessao());

        $projetosSelecionados = collect($request->input('projeto_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $subprojetosSelecionados = collect($request->input('subprojeto_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $unidadesSelecionadas = collect($request->input('unidade_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        $categoriasSelecionadas = collect($request->input('categoria_id', []))
            ->flatten()
            ->filter(fn ($valor) => $valor !== null && $valor !== '')
            ->map(fn ($valor) => (int) $valor)
            ->filter(fn ($valor) => $valor > 0)
            ->unique()
            ->values();

        if ($projetosSelecionados->isNotEmpty()) {
            $subprojetosFiltro = $this->repository->buscarSubprojetosPorProjetos($projetosSelecionados->all(), $this->macroprojetoAtivoIdSessao());
        } elseif ($subprojetosSelecionados->isNotEmpty()) {
            $subprojetosFiltro = $this->repository->buscarSubprojetosPorIds($subprojetosSelecionados->all(), $this->macroprojetoAtivoIdSessao());
        } else {
            $subprojetosFiltro = $this->repository->listarTodosSubprojetos($this->macroprojetoAtivoIdSessao());
        }

        $unidadesPermitidas = $aplicarEscopoUnidades
            ? $this->escopoUnidadeService->unidadesParaConsultaAtual()
            : null;
        $tarefas = $this->repository->buscarTarefasMonitoramento([
            'projetos' => $projetosSelecionados->all(),
            'subprojetos' => $subprojetosSelecionados->all(),
            'unidades' => $unidadesSelecionadas->all(),
            'categorias' => $categoriasSelecionadas->all(),
        ], $unidadesPermitidas, $this->macroprojetoAtivoIdSessao());

        $dados = $this->montarPainelMonitoramento($tarefas);

        return view('planejamento.tarefas.monitoramento', array_merge($dados, [
            'projetos' => $projetos,
            'subprojetosFiltro' => $subprojetosFiltro,
            'unidades' => $unidades,
            'categorias' => $categorias,
            'projetosSelecionados' => $projetosSelecionados->all(),
            'subprojetosSelecionados' => $subprojetosSelecionados->all(),
            'unidadesSelecionadas' => $unidadesSelecionadas->all(),
            'categoriasSelecionadas' => $categoriasSelecionadas->all(),
            'semLinksAtividades' => $semLinksAtividades,
            'limparRouteName' => $limparRouteName,
        ]));
    }

    /**
     * @return array<string, mixed>
     */
    private function montarPainelMonitoramento(Collection $tarefas): array
    {
        $total = $tarefas->count();

        $concluidas = $tarefas->filter(function ($tarefa) {
            $status = strtoupper((string) ($tarefa->status ?? ''));

            return !empty($tarefa->data_real_fim) || $status === 'CONCLUÍDA';
        })->count();

        $percentualConcluido = $total > 0 ? round(($concluidas / $total) * 100, 1) : 0.0;
        $ordemStatus = collect(TarefaStatus::OPCOES)->values()->flip();
        $statusDistribuicao = $tarefas
            ->groupBy(fn ($tarefa) => trim((string) ($tarefa->status ?? 'Sem status')))
            ->map(fn ($grupo) => $grupo->count())
            ->reject(fn ($quantidade, $status) => in_array(mb_strtoupper((string) $status), ['INDEFINIDO', 'EM ESPERA (CONTINGÊNCIA)'], true))
            ->sortBy(function ($quantidade, $status) use ($ordemStatus) {
                $indice = $ordemStatus->get($status, 999);

                return sprintf('%03d-%s', $indice, $status);
            })
            ->toArray();
        $statusCards = collect(TarefaStatus::OPCOES)
            ->reject(fn ($status) => mb_strtoupper((string) $status) === 'EM ESPERA (CONTINGÊNCIA)')
            ->map(fn ($status) => (object) [
                'status' => $status,
                'quantidade' => (int) Arr::get($statusDistribuicao, (string) $status, 0),
            ])
            ->values();

        $saudeProjetos = $tarefas
            ->groupBy(fn ($tarefa) => trim((string) ($tarefa->projeto_nome ?? 'Sem projeto')))
            ->map(function ($grupo, $nomeProjeto) {
                $totalProjeto = $grupo->count();
                $concluidasProjeto = $grupo->filter(fn ($tarefa) => strtoupper((string) ($tarefa->status ?? '')) === 'CONCLUÍDA' || !empty($tarefa->data_real_fim))->count();
                $atrasadasProjeto = $grupo->filter(fn ($tarefa) => str_contains(strtoupper((string) ($tarefa->status ?? '')), 'ATRASADA'))->count();

                $percentual = $totalProjeto > 0 ? round(($concluidasProjeto / $totalProjeto) * 100, 1) : 0.0;

                return (object) [
                    'projeto' => $nomeProjeto,
                    'total' => $totalProjeto,
                    'concluidas' => $concluidasProjeto,
                    'atrasadas' => $atrasadasProjeto,
                    'percentual_concluido' => $percentual,
                    'saude' => $atrasadasProjeto > 0 ? 'Crítica' : 'Estável',
                ];
            })
            ->sortBy('projeto')
            ->values();

        $saudeSubprojetos = $tarefas
            ->groupBy(fn ($tarefa) => ($tarefa->projeto_nome ?? 'Sem projeto') . '||' . ($tarefa->subprojeto_nome ?? 'Sem subprojeto'))
            ->map(function ($grupo, $chave) {
                [$nomeProjeto, $nomeSubprojeto] = array_pad(explode('||', (string) $chave, 2), 2, '—');
                $totalSub = $grupo->count();
                $concluidasSub = $grupo->filter(fn ($tarefa) => strtoupper((string) ($tarefa->status ?? '')) === 'CONCLUÍDA' || !empty($tarefa->data_real_fim))->count();
                $atrasadasSub = $grupo->filter(fn ($tarefa) => str_contains(strtoupper((string) ($tarefa->status ?? '')), 'ATRASADA'))->count();

                $percentual = $totalSub > 0 ? round(($concluidasSub / $totalSub) * 100, 1) : 0.0;

                return (object) [
                    'projeto' => $nomeProjeto ?: 'Sem projeto',
                    'subprojeto' => $nomeSubprojeto ?: 'Sem subprojeto',
                    'total' => $totalSub,
                    'concluidas' => $concluidasSub,
                    'atrasadas' => $atrasadasSub,
                    'percentual_concluido' => $percentual,
                    'saude' => $atrasadasSub > 0 ? 'Crítica' : 'Estável',
                ];
            })
            ->sortBy(fn ($linha) => mb_strtoupper($linha->projeto . '|' . $linha->subprojeto))
            ->values();

        return [
            'total' => $total,
            'percentualConcluido' => $percentualConcluido,
            'statusDistribuicao' => $statusDistribuicao,
            'statusCards' => $statusCards,
            'saudeProjetos' => $saudeProjetos,
            'saudeSubprojetos' => $saudeSubprojetos,
        ];
    }
}
```
</APP_HTTP_CONTROLLERS_TAREFAS_TAREFAMONITORAMENTOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/AgendarAlertaRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_AGENDARALERTAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/AgendarAlertaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class AgendarAlertaRequest extends FormRequest`

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
public function withValidator($validator): void
public function messages(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use App\Support\Tarefas\TarefaAlertaRecorrenciaTipo;
use App\Support\Tarefas\TarefaStatus;
use Carbon\Carbon;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class AgendarAlertaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nome'                      => ['required', 'string', 'max:255'],
            'status'                    => ['required', 'array', 'min:1'],
            'status.*'                  => ['string', Rule::in(TarefaStatus::OPCOES)],
            'data_prevista_inicio_de'   => ['nullable', 'date_format:Y-m-d'],
            'data_prevista_fim_ate'     => ['nullable', 'date_format:Y-m-d', 'after_or_equal:data_prevista_inicio_de'],
            'projeto_id'                => ['nullable', 'integer'],
            'subprojeto_id'             => ['nullable', 'array'],
            'subprojeto_id.*'           => ['integer'],
            'unidade_id'                => ['nullable', 'integer'],
            'incluir_unidade_tarefa'    => ['nullable', 'boolean'],
            'incluir_unidade_subprojeto' => ['nullable', 'boolean'],
            'incluir_unidade_projeto'   => ['nullable', 'boolean'],
            'assunto'                   => ['required', 'string', 'max:500'],
            'mensagem'                  => ['nullable', 'string'],
            'preview_confirmado'        => ['accepted'],
            'data_hora_envio_agendado'        => ['required', 'date_format:Y-m-d\TH:i', 'after:now'],
            'recorrente'                => ['nullable', 'boolean'],
            'recorrencia_tipo'          => [
                Rule::requiredIf(fn () => $this->boolean('recorrente')),
                'nullable',
                Rule::in(TarefaAlertaRecorrenciaTipo::TODOS),
            ],
            'recorrencia_dia'           => [
                Rule::requiredIf(fn () => $this->boolean('recorrente')),
                'nullable',
                'integer',
                $this->input('recorrencia_tipo') === TarefaAlertaRecorrenciaTipo::SEMANAL
                    ? 'min:0'
                    : 'min:1',
                $this->input('recorrencia_tipo') === TarefaAlertaRecorrenciaTipo::SEMANAL
                    ? 'max:6'
                    : 'max:31',
            ],
            'data_final'                => [
                Rule::requiredIf(fn () => $this->boolean('recorrente')),
                'nullable',
                'date_format:Y-m-d',
            ],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'recorrente'                => $this->boolean('recorrente'),
            'incluir_unidade_tarefa'    => $this->boolean('incluir_unidade_tarefa'),
            'incluir_unidade_subprojeto' => $this->boolean('incluir_unidade_subprojeto'),
            'incluir_unidade_projeto'   => $this->boolean('incluir_unidade_projeto'),
        ]);

        $subprojetos = $this->input('subprojeto_id', []);
        if (!is_array($subprojetos)) {
            $subprojetos = $subprojetos !== null && $subprojetos !== '' ? [$subprojetos] : [];
        }
        $this->merge(['subprojeto_id' => array_values(array_filter(
            array_map(static fn ($id) => is_numeric($id) ? (int) $id : null, $subprojetos),
            static fn ($id) => $id !== null && $id > 0
        ))]);
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {
            $tarefa    = $this->boolean('incluir_unidade_tarefa');
            $subprojeto = $this->boolean('incluir_unidade_subprojeto');
            $projeto   = $this->boolean('incluir_unidade_projeto');

            if (!$tarefa && !$subprojeto && !$projeto) {
                $validator->errors()->add('destinatarios', 'Selecione ao menos um tipo de destinatário.');
            }

            if ($this->boolean('recorrente') && $this->filled('data_final')) {
                $tipo = $this->input('recorrencia_tipo');
                $dia  = (int) $this->input('recorrencia_dia', 0);
                $base = Carbon::parse($this->input('data_hora_envio_agendado'), 'America/Rio_Branco');
                $fim  = Carbon::parse($this->input('data_final'), 'America/Rio_Branco');

                try {
                    $recorrencia = app(\App\Services\Tarefas\TarefaAlertaRecorrenciaService::class);

                    $primeira = match ($tipo) {
                        TarefaAlertaRecorrenciaTipo::SEMANAL => $recorrencia->primeiraOcorrenciaSemanal($base, $dia),
                        TarefaAlertaRecorrenciaTipo::MENSAL  => $recorrencia->primeiraOcorrenciaMensal($base, $dia),
                        default                              => $base,
                    };

                    if ($primeira->gt($fim->setTime(23, 59, 59))) {
                        $validator->errors()->add('data_final', 'A data final é anterior à primeira ocorrência ajustada (' . $primeira->format('d/m/Y') . ').');
                    }
                } catch (\Throwable) {
                    // recorrência_tipo ou dia inválidos são validados pelas regras básicas
                }
            }
        });
    }

    public function messages(): array
    {
        return [
            'nome.required'                 => 'Informe um nome para o agendamento.',
            'status.required'               => 'Selecione ao menos um status.',
            'status.*.in'                   => 'Status inválido.',
            'assunto.required'              => 'Informe o assunto do e-mail.',
            'data_hora_envio_agendado.required'   => 'Informe a data e hora do agendamento.',
            'data_hora_envio_agendado.after'      => 'A data e hora do agendamento devem ser futuras.',
            'recorrencia_tipo.required_if'  => 'Informe o tipo de recorrência.',
            'recorrencia_tipo.in'           => 'Tipo de recorrência inválido.',
            'recorrencia_dia.required_if'   => 'Informe o dia de recorrência.',
            'data_final.required_if'        => 'Agendamentos recorrentes exigem data final.',
        ];
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_AGENDARALERTAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/CategoriaTarefaRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_CATEGORIATAREFAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/CategoriaTarefaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class CategoriaTarefaRequest extends FormRequest`

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
public function messages(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CategoriaTarefaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $id = (int) $this->input('ID');

        return [
            'ID'        => ['nullable', 'integer'],
            'NOME'      => [
                'required',
                'string',
                'max:150',
                Rule::unique('CATEGORIA_TAREFA', 'NOME')->ignore($id, 'ID'),
            ],
            'DESCRICAO' => ['nullable', 'string', 'max:500'],
            'ATIVO'     => ['nullable', 'boolean'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $payload = [];
        if ($this->has('ATIVO')) {
            $payload['ATIVO'] = $this->boolean('ATIVO');
        }

        if (!empty($payload)) {
            $this->merge($payload);
        }
    }

    public function messages(): array
    {
        return [
            'NOME.required' => 'Informe o nome da categoria.',
            'NOME.unique'   => 'Já existe uma categoria com este nome.',
        ];
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_CATEGORIATAREFAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/FaseTarefaRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_FASETAREFAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/FaseTarefaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class FaseTarefaRequest extends FormRequest`

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
public function messages(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class FaseTarefaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $id = (int) $this->input('ID');

        return [
            'ID'        => ['nullable', 'integer'],
            'NOME'      => [
                'required',
                'string',
                'max:150',
                Rule::unique('FASE_TAREFA', 'NOME')->ignore($id, 'ID'),
            ],
            'DESCRICAO' => ['nullable', 'string', 'max:500'],
            'ATIVO'     => ['nullable', 'boolean'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $dados = [];
        if ($this->has('ATIVO')) {
            $dados['ATIVO'] = $this->boolean('ATIVO');
        }

        if ($dados) {
            $this->merge($dados);
        }
    }

    public function messages(): array
    {
        return [
            'NOME.required' => 'Informe o nome da fase.',
            'NOME.unique'   => 'Já existe uma fase com este nome.',
        ];
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_FASETAREFAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaAndamentoRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFAANDAMENTOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaAndamentoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaAndamentoRequest extends FormRequest`

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

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class TarefaAndamentoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'DESCRICAO' => ['required', 'string', 'max:2000'],
            'TIPO' => ['nullable', 'string', 'max:30', Rule::in(['ANDAMENTO', 'COMENTARIO', 'STATUS'])],
            'back' => ['nullable', 'string', 'max:1000'],
        ];
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFAANDAMENTOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaFinalRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFAFINALREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaFinalRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaFinalRequest extends FormRequest`

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
public function messages(): array
private function normalizarData(?string $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;

class TarefaFinalRequest extends FormRequest
{
    /**
     * Define se o usuário está autorizado a fazer esta requisição.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Retorna as regras de validação aplicáveis à requisição.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'DATA_REAL_INICIO'       => ['nullable', 'date_format:Y-m-d', 'required_with:DATA_REAL_FIM'],
            'DATA_REAL_FIM'          => ['required', 'date_format:Y-m-d'],
            'OBSERVACAO'             => ['nullable', 'string', 'max:200'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'DATA_REAL_INICIO' => $this->normalizarData($this->input('DATA_REAL_INICIO')),
            'DATA_REAL_FIM' => $this->normalizarData($this->input('DATA_REAL_FIM')),
        ]);
    }

    public function messages(): array
    {
        return [
            'DATA_REAL_FIM.required'    => 'Informe a data de término.',
            'DATA_REAL_INICIO.required_with' => 'Informe a data real de início antes de preencher a data real de término.',
            'DATA_REAL_INICIO.date_format' => 'A data de início deve estar no formato válido.',
            'DATA_REAL_FIM.date_format' => 'A data de término deve estar no formato válido.',
        ];
    }

    private function normalizarData(?string $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        $formatos = [
            'Y-m-d',
            'Y-m-d H:i',
            'Y-m-d H:i:s',
            'd/m/Y',
            'd/m/Y H:i',
            'd/m/Y H:i:s',
        ];

        $valor = str_replace('T', ' ', $valor);

        foreach ($formatos as $formato) {
            $data = \DateTime::createFromFormat($formato, $valor);
            if ($data instanceof \DateTime) {
                return $data->format('Y-m-d');
            }
        }

        return $valor;
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFAFINALREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaInicioRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFAINICIOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaInicioRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaInicioRequest extends FormRequest`

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
public function messages(): array
private function normalizarData(?string $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;

class TarefaInicioRequest extends FormRequest
{
    /**
     * Define se o usuário está autorizado a fazer esta requisição.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Retorna as regras de validação aplicáveis à requisição.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'DATA_REAL_INICIO'       => ['required', 'date_format:Y-m-d'],
            'OBSERVACAO'             => ['nullable', 'string', 'max:200'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'DATA_REAL_INICIO' => $this->normalizarData($this->input('DATA_REAL_INICIO')),
        ]);
    }

    public function messages(): array
    {
        return [
            'DATA_REAL_INICIO.required'    => 'Informe a data de início.',
            'DATA_REAL_INICIO.date_format' => 'A data de início deve estar no formato válido.',
        ];
    }

    private function normalizarData(?string $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        $formatos = [
            'Y-m-d',
            'Y-m-d H:i',
            'Y-m-d H:i:s',
            'd/m/Y',
            'd/m/Y H:i',
            'd/m/Y H:i:s',
        ];

        $valor = str_replace('T', ' ', $valor);

        foreach ($formatos as $formato) {
            $data = \DateTime::createFromFormat($formato, $valor);
            if ($data instanceof \DateTime) {
                return $data->format('Y-m-d');
            }
        }

        return $valor;
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFAINICIOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaRequest extends FormRequest`

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
public function messages(): array
private function normalizarData(?string $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;

class TarefaRequest extends FormRequest
{
    /**
     * Define se o usuário está autorizado a fazer esta requisição.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Retorna as regras de validação aplicáveis à requisição.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $isEdicao = !empty($this->input('ID'));
        $contratacoesCategoriaId = (int) config('planejamento.categoria_contratacoes_id', 2);

        $validarFase = function ($attribute, $value, $fail) use ($contratacoesCategoriaId) {
            $categoriaSelecionada = (int) $this->input('CATEGORIA_ID');
            if (!empty($value) && $categoriaSelecionada !== $contratacoesCategoriaId) {
                $fail('A fase só pode ser informada para atividades da categoria Contratações.');
            }
        };

        if ($isEdicao) {
            return [
                'ID'                     => ['nullable', 'integer'],
                'NOME'                   => ['required', 'string', 'max:500'],
                'DESCRICAO'              => ['nullable', 'string'],
                'SUBPROJETO_ID'          => ['required', 'integer'],
                'UNIDADE_ID'             => ['required_without:APLICAR_LOTE', 'nullable', 'integer'],
                'GRUPO_UNIDADE_ID'       => ['nullable', 'integer'],
                'LOTE_ID'                => ['nullable', 'integer'],
                'APLICAR_LOTE'           => ['nullable', 'boolean'],
                'UNIDADES'               => ['nullable', 'array'],
                'UNIDADES.*'             => ['integer'],
                'DATA_PREVISTA_INICIO'   => ['nullable', 'date_format:Y-m-d'],
                'DATA_PREVISTA_FIM'      => ['nullable', 'date_format:Y-m-d', 'after_or_equal:DATA_PREVISTA_INICIO'],
                'DATA_REAL_INICIO'       => ['nullable', 'date_format:Y-m-d', 'required_with:DATA_REAL_FIM'],
                'DATA_REAL_FIM'          => ['nullable', 'date_format:Y-m-d', 'after_or_equal:DATA_REAL_INICIO'],
                'HORAS_EXTRAS'           => ['nullable', 'numeric', 'min:0'],
                'PESSOAS_ENVOLVIDAS'     => ['nullable', 'integer', 'min:1'],
                'CATEGORIA_ID'           => ['nullable', 'integer'],
                'FASE_ID'                => ['nullable', 'integer', $validarFase],
                'NR_PROCESSO_SEI'        => ['nullable', 'string', 'max:40'],
            ];
        }

        return [
            'ID'                     => ['nullable', 'integer'],
            'NOME'                   => ['required', 'string', 'max:500'],
            'DESCRICAO'              => ['nullable', 'string'],
            'SUBPROJETO_ID'          => ['required', 'integer'],
            'UNIDADE_ID'             => ['nullable', 'integer'],
            'GRUPO_UNIDADE_ID'       => ['nullable', 'integer', 'required_without:UNIDADES'],
            'LOTE_ID'                => ['nullable', 'integer'],
            'UNIDADES'               => ['required_without:GRUPO_UNIDADE_ID', 'array', 'min:1'],
            'UNIDADES.*'             => ['integer'],
            'APLICAR_LOTE'           => ['nullable', 'boolean'],
            'DATA_PREVISTA_INICIO'   => ['nullable', 'date_format:Y-m-d'],
            'DATA_PREVISTA_FIM'      => ['nullable', 'date_format:Y-m-d', 'after_or_equal:DATA_PREVISTA_INICIO'],
            'DATA_REAL_INICIO'       => ['nullable', 'date_format:Y-m-d', 'required_with:DATA_REAL_FIM'],
            'DATA_REAL_FIM'          => ['nullable', 'date_format:Y-m-d', 'after_or_equal:DATA_REAL_INICIO'],
            'HORAS_EXTRAS'           => ['nullable', 'numeric', 'min:0'],
            'PESSOAS_ENVOLVIDAS'     => ['nullable', 'integer', 'min:1'],
            'CATEGORIA_ID'           => ['nullable', 'integer'],
            'FASE_ID'                => ['nullable', 'integer', $validarFase],
            'NR_PROCESSO_SEI'        => ['nullable', 'string', 'max:40'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'DATA_PREVISTA_INICIO' => $this->normalizarData($this->input('DATA_PREVISTA_INICIO')),
            'DATA_PREVISTA_FIM'    => $this->normalizarData($this->input('DATA_PREVISTA_FIM')),
            'DATA_REAL_INICIO'     => $this->normalizarData($this->input('DATA_REAL_INICIO')),
            'DATA_REAL_FIM'        => $this->normalizarData($this->input('DATA_REAL_FIM')),
            'APLICAR_LOTE'         => $this->boolean('APLICAR_LOTE'),
        ]);
    }

    public function messages(): array
    {
        return [
            'NOME.max'                         => 'O nome da atividade deve ter no máximo 500 caracteres.',
            'DATA_PREVISTA_FIM.after_or_equal' => 'Prev. de término não pode ser anterior à prev. de início.',
            'DATA_REAL_FIM.after_or_equal'     => 'Data real de término não pode ser anterior à real de início.',
            'DATA_REAL_INICIO.required_with'   => 'Informe a data real de início antes de preencher a data real de término.',
            'DATA_PREVISTA_INICIO.date_format' => 'Prev. de início está em formato inválido.',
            'DATA_PREVISTA_FIM.date_format'    => 'Prev. de término está em formato inválido.',
            'DATA_REAL_INICIO.date_format'     => 'Data real de início está em formato inválido.',
            'DATA_REAL_FIM.date_format'        => 'Data real de término está em formato inválido.',
            'GRUPO_UNIDADE_ID.required_without'=> 'Selecione um grupo ou informe as unidades.',
            'UNIDADES.required'                => 'Selecione ao menos uma unidade.',
            'UNIDADES.required_without'        => 'Selecione ao menos uma unidade quando não houver grupo.',
            'UNIDADES.array'                   => 'Unidades informadas são inválidas.',
            'UNIDADES.*.integer'               => 'Unidade selecionada inválida.',
            'UNIDADE_ID.required_without'      => 'Informe a unidade ou marque a atualização do lote.',
            'APLICAR_LOTE.boolean'             => 'Valor inválido para aplicar ao lote.',
        ];
    }

    private function normalizarData(?string $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        $formatos = [
            'Y-m-d',
            'Y-m-d H:i',
            'Y-m-d H:i:s',
            'd/m/Y',
            'd/m/Y H:i',
            'd/m/Y H:i:s',
        ];

        $valor = str_replace('T', ' ', $valor);

        foreach ($formatos as $formato) {
            $data = \DateTime::createFromFormat($formato, $valor);
            if ($data instanceof \DateTime) {
                return $data->format('Y-m-d');
            }
        }

        return $valor;
    }

}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaRestritaRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFARESTRITAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaRestritaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaRestritaRequest extends FormRequest`

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
public function messages(): array
private function normalizarData(?string $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;

class TarefaRestritaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $contratacoesCategoriaId = (int) config('planejamento.categoria_contratacoes_id', 2);

        $validarFase = function ($attribute, $value, $fail) use ($contratacoesCategoriaId) {
            $categoriaSelecionada = (int) $this->input('CATEGORIA_ID');
            if (!empty($value) && $categoriaSelecionada !== $contratacoesCategoriaId) {
                $fail('A fase só pode ser informada para atividades da categoria Contratações.');
            }
        };

        return [
            'ID' => ['required', 'integer'],
            'NR_PROCESSO_SEI' => ['nullable', 'string', 'max:40'],
            'DATA_REAL_INICIO' => ['nullable', 'date_format:Y-m-d', 'required_with:DATA_REAL_FIM'],
            'DATA_REAL_FIM' => ['nullable', 'date_format:Y-m-d', 'after_or_equal:DATA_REAL_INICIO'],
            'CATEGORIA_ID' => ['nullable', 'integer'],
            'FASE_ID' => ['nullable', 'integer', $validarFase],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'DATA_REAL_INICIO' => $this->normalizarData($this->input('DATA_REAL_INICIO')),
            'DATA_REAL_FIM' => $this->normalizarData($this->input('DATA_REAL_FIM')),
        ]);
    }

    public function messages(): array
    {
        return [
            'ID.required' => 'Atividade inválida.',
            'DATA_REAL_FIM.after_or_equal' => 'Data real de término não pode ser anterior à real de início.',
            'DATA_REAL_INICIO.required_with' => 'Informe a data real de início antes de preencher a data real de término.',
            'DATA_REAL_INICIO.date_format' => 'Data real de início está em formato inválido.',
            'DATA_REAL_FIM.date_format' => 'Data real de término está em formato inválido.',
        ];
    }

    private function normalizarData(?string $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        $formatos = [
            'Y-m-d',
            'Y-m-d H:i',
            'Y-m-d H:i:s',
            'd/m/Y',
            'd/m/Y H:i',
            'd/m/Y H:i:s',
        ];

        $valor = str_replace('T', ' ', $valor);

        foreach ($formatos as $formato) {
            $data = \DateTime::createFromFormat($formato, $valor);
            if ($data instanceof \DateTime) {
                return $data->format('Y-m-d');
            }
        }

        return $valor;
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFARESTRITAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoBaseRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZOBASEREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoBaseRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `abstract class TarefaSolicitacaoPrazoBaseRequest extends FormRequest`

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
public function messages(): array
public function withValidator(Validator $validator): void
protected function normalizarId(mixed $valor): mixed
protected function normalizarData(mixed $valor): mixed
protected function normalizarTexto(mixed $valor): mixed
protected function normalizarTipo(mixed $valor): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use App\Support\Validation\DataIso;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Validator;

abstract class TarefaSolicitacaoPrazoBaseRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'TIPO_SOLICITACAO' => ['required', 'string', 'in:ALTERACAO,EXCLUSAO'],
            'DATA_PREVISTA_INICIO_NOVA' => ['nullable', 'date_format:Y-m-d'],
            'DATA_PREVISTA_FIM_NOVA' => ['nullable', 'date_format:Y-m-d', 'after:DATA_PREVISTA_INICIO_NOVA'],
            'UNIDADE_ID_NOVA' => ['nullable', 'integer', 'min:1'],
            'NOME_NOVO' => ['nullable', 'string', 'min:3', 'max:500'],
            'DESCRICAO_NOVA' => ['nullable', 'string', 'min:5', 'max:4000'],
            'JUSTIFICATIVA' => ['required', 'string', 'min:10', 'max:2000'],
            'back' => ['nullable', 'string', 'max:2000'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'TIPO_SOLICITACAO' => $this->normalizarTipo($this->input('TIPO_SOLICITACAO')),
            'DATA_PREVISTA_INICIO_NOVA' => $this->normalizarData($this->input('DATA_PREVISTA_INICIO_NOVA')),
            'DATA_PREVISTA_FIM_NOVA' => $this->normalizarData($this->input('DATA_PREVISTA_FIM_NOVA')),
            'UNIDADE_ID_NOVA' => $this->normalizarId($this->input('UNIDADE_ID_NOVA')),
            'NOME_NOVO' => $this->normalizarTexto($this->input('NOME_NOVO')),
            'DESCRICAO_NOVA' => $this->normalizarTexto($this->input('DESCRICAO_NOVA')),
            'JUSTIFICATIVA' => is_string($this->input('JUSTIFICATIVA'))
                ? trim($this->input('JUSTIFICATIVA'))
                : $this->input('JUSTIFICATIVA'),
        ]);
    }

    /** @return array<string, string> */
    public function messages(): array
    {
        return [
            'TIPO_SOLICITACAO.required' => 'Informe o tipo da solicitação.',
            'TIPO_SOLICITACAO.in' => 'O tipo da solicitação informado é inválido.',
            'DATA_PREVISTA_INICIO_NOVA.date_format' => 'A nova previsão de início está em formato inválido.',
            'DATA_PREVISTA_FIM_NOVA.date_format' => 'A nova previsão de término está em formato inválido.',
            'DATA_PREVISTA_FIM_NOVA.after' => 'A nova previsão de término deve ser posterior à nova previsão de início.',
            'UNIDADE_ID_NOVA.integer' => 'A nova unidade responsável informada é inválida.',
            'UNIDADE_ID_NOVA.min' => 'A nova unidade responsável informada é inválida.',
            'NOME_NOVO.min' => 'O novo nome da atividade deve ter pelo menos 3 caracteres.',
            'NOME_NOVO.max' => 'O novo nome da atividade deve ter no máximo 500 caracteres.',
            'DESCRICAO_NOVA.min' => 'A nova descrição da atividade deve ter pelo menos 5 caracteres.',
            'DESCRICAO_NOVA.max' => 'A nova descrição da atividade deve ter no máximo 4000 caracteres.',
            'JUSTIFICATIVA.required' => 'Informe a justificativa da solicitação.',
            'JUSTIFICATIVA.min' => 'A justificativa deve ter pelo menos 10 caracteres.',
            'JUSTIFICATIVA.max' => 'A justificativa deve ter no máximo 2000 caracteres.',
        ];
    }

    public function withValidator(Validator $validator): void
    {
        $validator->after(function (Validator $validator): void {
            $tipo = strtoupper((string) $this->input('TIPO_SOLICITACAO', 'ALTERACAO'));
            $inicio = $this->input('DATA_PREVISTA_INICIO_NOVA');
            $fim = $this->input('DATA_PREVISTA_FIM_NOVA');
            $unidadeNova = $this->input('UNIDADE_ID_NOVA');
            $nomeNovo = $this->input('NOME_NOVO');
            $descricaoNova = $this->input('DESCRICAO_NOVA');

            if ($tipo === 'ALTERACAO' && empty($inicio) && empty($fim) && empty($unidadeNova) && empty($nomeNovo) && empty($descricaoNova)) {
                $validator->errors()->add(
                    'DATA_PREVISTA_INICIO_NOVA',
                    'Informe ao menos uma alteração (datas, unidade, nome ou descrição da atividade).'
                );
            }

            if ($tipo === 'EXCLUSAO' && (! empty($inicio) || ! empty($fim) || ! empty($unidadeNova) || ! empty($nomeNovo) || ! empty($descricaoNova))) {
                $validator->errors()->add(
                    'TIPO_SOLICITACAO',
                    'Para solicitação de exclusão, preencha apenas a justificativa.'
                );
            }
        });
    }

    protected function normalizarId(mixed $valor): mixed
    {
        if ($valor === null) {
            return null;
        }

        $texto = trim((string) $valor);
        if ($texto === '') {
            return null;
        }

        return ctype_digit($texto) ? (int) $texto : $texto;
    }

    protected function normalizarData(mixed $valor): mixed
    {
        if (! is_string($valor)) {
            return $valor === null ? null : $valor;
        }

        $texto = trim($valor);
        if ($texto === '') {
            return null;
        }

        return DataIso::data($texto)?->toDateString() ?? $texto;
    }

    protected function normalizarTexto(mixed $valor): mixed
    {
        if (! is_string($valor)) {
            return $valor === null ? null : $valor;
        }

        $texto = trim($valor);

        return $texto === '' ? null : $texto;
    }

    protected function normalizarTipo(mixed $valor): string
    {
        $texto = strtoupper(trim((string) $valor));

        return $texto === '' ? 'ALTERACAO' : $texto;
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZOBASEREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoDecisaoRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZODECISAOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoDecisaoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoDecisaoRequest extends FormRequest`

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
public function messages(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Foundation\Http\FormRequest;

class TarefaSolicitacaoPrazoDecisaoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'MOTIVO_DECISAO' => ['required', 'string', 'min:5', 'max:1000'],
            'back' => ['nullable', 'string', 'max:2000'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'MOTIVO_DECISAO' => is_string($this->input('MOTIVO_DECISAO')) ? trim($this->input('MOTIVO_DECISAO')) : $this->input('MOTIVO_DECISAO'),
        ]);
    }

    public function messages(): array
    {
        return [
            'MOTIVO_DECISAO.required' => 'Informe o motivo da rejeição.',
            'MOTIVO_DECISAO.min' => 'O motivo da rejeição deve ter pelo menos 5 caracteres.',
            'MOTIVO_DECISAO.max' => 'O motivo da rejeição deve ter no máximo 1000 caracteres.',
        ];
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZODECISAOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoRequest extends TarefaSolicitacaoPrazoBaseRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

class TarefaSolicitacaoPrazoRequest extends TarefaSolicitacaoPrazoBaseRequest
{
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Jobs/Tarefas/EnviarAlertaTarefasJob.php`
## <APP_JOBS_TAREFAS_ENVIARALERTATAREFASJOB_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Jobs/Tarefas/EnviarAlertaTarefasJob.php`
- **Namespace Declaração:** `App\Jobs\Tarefas`
- **Entidade / Classe:** `class EnviarAlertaTarefasJob implements ShouldQueue`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function handle(
private function processarExecucaoInicial(
private function processarReprocessamento(
private function buscarTarefasAtuais(object $execucao, TarefaAlertaQueryRepository $tarefaRepo): Collection
private function tiposDestinatario(object $execucao): array
private function enviarParaDestinatario(
private function avancarAgendamento(
private function montarDestinatarios(Collection $tarefas, array $tiposDestinatario): array
private function adicionarUnidade(array &$destinatarios, ?array $unidade, string $origem, array $tarefa): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Jobs\Tarefas;

use App\Mail\Tarefas\TarefasAtrasadasMail;
use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Repositories\Tarefas\TarefaAlertaRepository as TarefaAlertaQueryRepository;
use App\Services\Tarefas\TarefaAlertaAgendamentoService;
use App\Support\Tarefas\TarefaAlertaExecucaoStatus;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Throwable;

class EnviarAlertaTarefasJob implements ShouldQueue
{
    use Queueable;

    public int $tries = 1;

    public function __construct(
        private readonly int $execucaoId,
        public readonly bool $reprocessamento = false,
    ) {}

    public function handle(
        TarefaAlertaExecucaoRepository $execucaoRepo,
        TarefaAlertaAgendamentoRepository $agendamentoRepo,
        TarefaAlertaAgendamentoService $agendamentoService,
        TarefaAlertaQueryRepository $tarefaRepo,
    ): void {
        $execucao = $execucaoRepo->encontrar($this->execucaoId);
        if ($execucao === null) {
            Log::warning('EnviarAlertaTarefasJob: execução não encontrada.', ['id' => $this->execucaoId]);
            return;
        }

        if (!$execucaoRepo->marcarProcessandoSePendente($this->execucaoId)) {
            return;
        }

        try {
            if ($this->reprocessamento) {
                $this->processarReprocessamento(
                    $execucao,
                    $execucaoRepo,
                    $agendamentoRepo,
                    $agendamentoService,
                    $tarefaRepo
                );
                return;
            }

            $this->processarExecucaoInicial(
                $execucao,
                $execucaoRepo,
                $agendamentoRepo,
                $agendamentoService,
                $tarefaRepo
            );
        } catch (Throwable $e) {
            $execucaoRepo->atualizarStatus($this->execucaoId, TarefaAlertaExecucaoStatus::FALHA, [
                'data_hora_fim' => now(),
                'erros_json' => json_encode([$e->getMessage()]),
            ]);

            Log::error('EnviarAlertaTarefasJob falhou.', [
                'execucao_id' => $this->execucaoId,
                'erro' => $e->getMessage(),
            ]);

            throw $e;
        }
    }

    private function processarExecucaoInicial(
        object $execucao,
        TarefaAlertaExecucaoRepository $execucaoRepo,
        TarefaAlertaAgendamentoRepository $agendamentoRepo,
        TarefaAlertaAgendamentoService $agendamentoService,
        TarefaAlertaQueryRepository $tarefaRepo,
    ): void {
        $tarefas = $this->buscarTarefasAtuais($execucao, $tarefaRepo);
        $execucaoRepo->atualizarStatus($this->execucaoId, TarefaAlertaExecucaoStatus::PROCESSANDO, [
            'total_tarefas' => $tarefas->count(),
        ]);

        if ($tarefas->isEmpty()) {
            $execucaoRepo->atualizarStatus($this->execucaoId, TarefaAlertaExecucaoStatus::CONCLUIDA, [
                'data_hora_fim' => now(),
                'total_destinatarios' => 0,
                'total_sucessos' => 0,
                'total_falhas' => 0,
            ]);
            $this->avancarAgendamento($execucao, $agendamentoRepo, $agendamentoService, TarefaAlertaExecucaoStatus::CONCLUIDA);
            return;
        }

        foreach ($this->montarDestinatarios($tarefas, $this->tiposDestinatario($execucao)) as $email => $destinatario) {
            $destId = $execucaoRepo->criarDestinatario($this->execucaoId, [
                'email' => $email,
                'status' => 'pendente',
                'origens_json' => json_encode($destinatario['origens']),
                'unidades_json' => json_encode($destinatario['unidades']),
            ]);
            $execucaoRepo->criarTarefasDestinatario($destId, $destinatario['tarefas']);
            $this->enviarParaDestinatario($destId, $email, $destinatario, $execucao, $execucaoRepo);
        }

        $execucaoRepo->recalcularTotais($this->execucaoId);
        $status = $execucaoRepo->encontrar($this->execucaoId)?->status ?? TarefaAlertaExecucaoStatus::FALHA;
        $this->avancarAgendamento($execucao, $agendamentoRepo, $agendamentoService, $status);
    }

    private function processarReprocessamento(
        object $execucao,
        TarefaAlertaExecucaoRepository $execucaoRepo,
        TarefaAlertaAgendamentoRepository $agendamentoRepo,
        TarefaAlertaAgendamentoService $agendamentoService,
        TarefaAlertaQueryRepository $tarefaRepo,
    ): void {
        $falhos = $execucaoRepo->destinatariosComFalha($this->execucaoId);
        $tarefas = $this->buscarTarefasAtuais($execucao, $tarefaRepo);
        $atuais = $this->montarDestinatarios($tarefas, $this->tiposDestinatario($execucao));

        $execucaoRepo->atualizarStatus($this->execucaoId, TarefaAlertaExecucaoStatus::PROCESSANDO, [
            'total_tarefas' => $tarefas->count(),
        ]);

        foreach ($falhos as $falho) {
            $email = strtolower(trim((string) $falho->email));
            if (!isset($atuais[$email])) {
                continue;
            }

            $destinatario = $atuais[$email];
            $destId = (int) $falho->id;
            $execucaoRepo->excluirTarefasDestinatario($destId);
            $execucaoRepo->criarTarefasDestinatario($destId, $destinatario['tarefas']);
            $this->enviarParaDestinatario($destId, $email, $destinatario, $execucao, $execucaoRepo);
        }

        $execucaoRepo->recalcularTotais($this->execucaoId);
        $status = $execucaoRepo->encontrar($this->execucaoId)?->status ?? TarefaAlertaExecucaoStatus::FALHA;

        if ($status === TarefaAlertaExecucaoStatus::CONCLUIDA && $execucao->agendamento_id !== null) {
            $agendamento = $agendamentoRepo->encontrar((int) $execucao->agendamento_id);
            if ($agendamento !== null && !(bool) $agendamento->recorrente) {
                $agendamentoService->concluir((int) $agendamento->id);
            }
        }
    }

    private function buscarTarefasAtuais(object $execucao, TarefaAlertaQueryRepository $tarefaRepo): Collection
    {
        $filtros = json_decode($execucao->filtros_json ?? '{}', true) ?? [];
        $escopo = json_decode($execucao->escopo_json ?? '{}', true) ?? [];

        return $tarefaRepo->buscarTarefas(
            $filtros,
            is_array($escopo['unidades_permitidas_ids'] ?? null) ? $escopo['unidades_permitidas_ids'] : null,
            (int) ($escopo['macroprojeto_id'] ?? 0)
        );
    }

    private function tiposDestinatario(object $execucao): array
    {
        return json_decode($execucao->tipos_destinatario_json ?? '[]', true) ?? [];
    }

    private function enviarParaDestinatario(
        int $destId,
        string $email,
        array $destinatario,
        object $execucao,
        TarefaAlertaExecucaoRepository $execucaoRepo
    ): void {
        $numero = $execucaoRepo->proximoNumeroDeTentativa($destId);

        try {
            $mail = (new TarefasAtrasadasMail($destinatario, $execucao->mensagem))
                ->subject($execucao->assunto);
            Mail::to($email)->send($mail);

            $execucaoRepo->criarTentativa($destId, $numero, 'enviado', [
                'tarefas_json' => json_encode($destinatario['tarefas']),
            ]);
            $execucaoRepo->atualizarDestinatario($destId, [
                'status' => 'enviado',
                'tentativas' => $numero,
                'dt_ultimo_envio' => now(),
                'erro' => null,
            ]);
        } catch (Throwable $e) {
            $execucaoRepo->criarTentativa($destId, $numero, 'falha', [
                'erro' => $e->getMessage(),
                'tarefas_json' => json_encode($destinatario['tarefas']),
            ]);
            $execucaoRepo->atualizarDestinatario($destId, [
                'status' => 'falha',
                'tentativas' => $numero,
                'erro' => $e->getMessage(),
            ]);

            Log::warning('Falha ao enviar alerta para destinatário.', [
                'execucao_id' => $this->execucaoId,
                'email' => $email,
                'erro' => $e->getMessage(),
            ]);
        }
    }

    private function avancarAgendamento(
        object $execucao,
        TarefaAlertaAgendamentoRepository $agendamentoRepo,
        TarefaAlertaAgendamentoService $agendamentoService,
        string $execucaoStatus
    ): void {
        if ($execucao->agendamento_id === null || $execucao->origem !== 'agendado') {
            return;
        }

        $agendamento = $agendamentoRepo->encontrar((int) $execucao->agendamento_id);
        if ($agendamento !== null) {
            $agendamentoService->avancarProximaExecucao($agendamento, $execucaoStatus);
        }
    }

    private function montarDestinatarios(Collection $tarefas, array $tiposDestinatario): array
    {
        $destinatarios = [];
        foreach ($tarefas as $tarefa) {
            if (in_array('unidade_tarefa', $tiposDestinatario, true)) {
                $this->adicionarUnidade($destinatarios, $tarefa['unidade_tarefa'], 'Unidade responsável pela tarefa', $tarefa);
            }
            if (in_array('unidade_subprojeto', $tiposDestinatario, true)) {
                $this->adicionarUnidade($destinatarios, $tarefa['unidade_subprojeto'], 'Unidade do subprojeto', $tarefa);
            }
            if (in_array('unidade_projeto', $tiposDestinatario, true)) {
                $this->adicionarUnidade($destinatarios, $tarefa['unidade_projeto'], 'Unidade do projeto', $tarefa);
            }
        }

        return $destinatarios;
    }

    private function adicionarUnidade(array &$destinatarios, ?array $unidade, string $origem, array $tarefa): void
    {
        $email = strtolower(trim((string) ($unidade['email'] ?? '')));
        if ($email === '') {
            return;
        }

        if (!isset($destinatarios[$email])) {
            $destinatarios[$email] = [
                'email' => $email,
                'origens' => [$origem],
                'unidades' => [$unidade['label'] ?? ''],
                'tarefas' => [],
            ];
        }

        if (!in_array($origem, $destinatarios[$email]['origens'], true)) {
            $destinatarios[$email]['origens'][] = $origem;
        }
        $label = $unidade['label'] ?? '';
        if (!in_array($label, $destinatarios[$email]['unidades'], true)) {
            $destinatarios[$email]['unidades'][] = $label;
        }

        foreach ($destinatarios[$email]['tarefas'] as $existente) {
            if (($existente['id'] ?? null) === ($tarefa['id'] ?? null)) {
                return;
            }
        }
        $destinatarios[$email]['tarefas'][] = $tarefa;
    }
}
```
</APP_JOBS_TAREFAS_ENVIARALERTATAREFASJOB_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Mail/Tarefas/TarefasAtrasadasMail.php`
## <APP_MAIL_TAREFAS_TAREFASATRASADASMAIL_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Mail/Tarefas/TarefasAtrasadasMail.php`
- **Namespace Declaração:** `App\Mail\Tarefas`
- **Entidade / Classe:** `class TarefasAtrasadasMail extends Mailable`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(array $destinatario, ?string $mensagemPersonalizada)
public function build(): self
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Mail\Tarefas;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Collection;

class TarefasAtrasadasMail extends Mailable
{
    use Queueable, SerializesModels;

    public array $destinatario;
    public ?string $mensagemPersonalizada;
    public Collection $tarefas;

    public function __construct(array $destinatario, ?string $mensagemPersonalizada)
    {
        $this->destinatario = $destinatario;
        $this->mensagemPersonalizada = $mensagemPersonalizada;
        $this->tarefas = collect($destinatario['tarefas'] ?? []);
    }

    public function build(): self
    {
        return $this
            ->view('emails.tarefas_atrasadas')
            ->with([
                'destinatario' => $this->destinatario,
                'mensagemPersonalizada' => $this->mensagemPersonalizada,
                'tarefas' => $this->tarefas,
            ]);
    }
}
```
</APP_MAIL_TAREFAS_TAREFASATRASADASMAIL_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/CategoriaTarefaRepository.php`
## <APP_REPOSITORIES_TAREFAS_CATEGORIATAREFAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/CategoriaTarefaRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class CategoriaTarefaRepository implements CategoriaTarefaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('CATEGORIA_TAREFA as C')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, ?string $ativo = null): LengthAwarePaginator
public function buscar(int $id): ?object
public function atualizar(int $id, array $dados): void
public function criar(array $dados): void
public function alterarStatus(int $id): ?string
public function remover(int $id): void
public function listarAtivas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use App\Repositories\Tarefas\Contracts\CategoriaTarefaRepositoryInterface;

class CategoriaTarefaRepository implements CategoriaTarefaRepositoryInterface
{
    use AuditaDml;

    public function listar(?string $busca = null, ?string $ativo = null): LengthAwarePaginator
    {
        $query = DB::table('CATEGORIA_TAREFA as C')
            ->selectRaw("C.ID, C.NOME, C.DESCRICAO, C.ATIVO, TO_CHAR(C.DT_CRIACAO, 'DD/MM/YYYY HH24:MI') AS DT_CRIACAO, TO_CHAR(C.DT_ATUALIZACAO, 'DD/MM/YYYY HH24:MI') AS DT_ATUALIZACAO")
            ->orderBy('C.NOME');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->whereRaw('UPPER(C.NOME) LIKE ? OR UPPER(C.DESCRICAO) LIKE ?', [$like, $like]);
        }

        if ($ativo !== null && $ativo !== '') {
            $query->where('C.ATIVO', $ativo === 'S' ? 'S' : 'N');
        }

        return $query->paginate(10)->withQueryString();
    }

    public function buscar(int $id): ?object
    {
        return DB::selectOne(
            "SELECT ID, NOME, DESCRICAO, ATIVO FROM CATEGORIA_TAREFA WHERE ID = :id",
            ['id' => $id]
        ) ?: null;
    }

    public function atualizar(int $id, array $dados): void
    {
        $this->atualizarAuditadoPorId('CATEGORIA_TAREFA', 'CATEGORIA_TAREFA', 'ID', $id, [
            'NOME' => $dados['NOME'],
            'DESCRICAO' => $dados['DESCRICAO'] ?? null,
            'ATIVO' => $dados['ATIVO'] ? 'S' : 'N',
            'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
        ]);
    }

    public function criar(array $dados): void
    {
        $this->inserirAuditado('CATEGORIA_TAREFA', 'CATEGORIA_TAREFA', [
            'NOME' => $dados['NOME'],
            'DESCRICAO' => $dados['DESCRICAO'] ?? null,
            'ATIVO' => $dados['ATIVO'] ? 'S' : 'N',
            'DT_CRIACAO' => DB::raw('SYSDATE'),
        ], 'ID', 'ID');
    }

    public function alterarStatus(int $id): ?string
    {
        $registro = DB::selectOne("SELECT ATIVO FROM CATEGORIA_TAREFA WHERE ID = :id", ['id' => $id]);
        if (!$registro) {
            return null;
        }

        $novoStatus = ($registro->ativo ?? 'S') === 'S' ? 'N' : 'S';

        $this->atualizarAuditadoPorId('CATEGORIA_TAREFA', 'CATEGORIA_TAREFA', 'ID', $id, [
            'ATIVO' => $novoStatus,
            'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
        ]);

        return $novoStatus;
    }

    public function remover(int $id): void
    {
        $this->removerAuditadoPorId('CATEGORIA_TAREFA', 'CATEGORIA_TAREFA', 'ID', $id);
    }

    public function listarAtivas(): array
    {
        return DB::select(
            "SELECT ID AS id, NOME AS text FROM CATEGORIA_TAREFA WHERE ATIVO = 'S' ORDER BY NOME"
        );
    }
}
```
</APP_REPOSITORIES_TAREFAS_CATEGORIATAREFAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/CategoriaTarefaRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_CATEGORIATAREFAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/CategoriaTarefaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface CategoriaTarefaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, ?string $ativo = null): LengthAwarePaginator;
public function buscar(int $id): ?object;
public function atualizar(int $id, array $dados): void;
public function criar(array $dados): void;
public function alterarStatus(int $id): ?string;
public function remover(int $id): void;
public function listarAtivas(): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface CategoriaTarefaRepositoryInterface
{
    public function listar(?string $busca = null, ?string $ativo = null): LengthAwarePaginator;
    public function buscar(int $id): ?object;
    public function atualizar(int $id, array $dados): void;
    public function criar(array $dados): void;
    public function alterarStatus(int $id): ?string;
    public function remover(int $id): void;
    public function listarAtivas(): array;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_CATEGORIATAREFAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/FaseTarefaRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_FASETAREFAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/FaseTarefaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface FaseTarefaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(string $busca = '', ?string $ativo = null, int $perPage = 5): LengthAwarePaginator;
public function buscar(int $id): ?object;
public function criar(array $dados): void;
public function atualizar(int $id, array $dados): void;
public function alterarStatus(int $id): ?string;
public function remover(int $id): void;
public function listarAtivas(): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface FaseTarefaRepositoryInterface
{
    public function listar(string $busca = '', ?string $ativo = null, int $perPage = 5): LengthAwarePaginator;
    public function buscar(int $id): ?object;
    public function criar(array $dados): void;
    public function atualizar(int $id, array $dados): void;
    public function alterarStatus(int $id): ?string;
    public function remover(int $id): void;
    public function listarAtivas(): array;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_FASETAREFAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/TarefaAndamentoRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAANDAMENTOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/TarefaAndamentoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface TarefaAndamentoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarAndamentos(int $tarefaId): array;
public function buscarAndamento(int $tarefaId, int $andamentoId): ?object;
public function inserirAndamento(int $tarefaId, string $descricao, string $tipo = 'ANDAMENTO', ?string $usuario = null): void;
public function atualizarAndamento(int $tarefaId, int $andamentoId, string $descricao, string $tipo = 'ANDAMENTO'): void;
public function deletarAndamento(int $tarefaId, int $andamentoId): void;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

interface TarefaAndamentoRepositoryInterface
{
    public function listarAndamentos(int $tarefaId): array;
    public function buscarAndamento(int $tarefaId, int $andamentoId): ?object;
    public function inserirAndamento(int $tarefaId, string $descricao, string $tipo = 'ANDAMENTO', ?string $usuario = null): void;
    public function atualizarAndamento(int $tarefaId, int $andamentoId, string $descricao, string $tipo = 'ANDAMENTO'): void;
    public function deletarAndamento(int $tarefaId, int $andamentoId): void;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAANDAMENTOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/TarefaConsultaRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFACONSULTAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/TarefaConsultaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface TarefaConsultaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarTarefasKanban(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): Collection;
public function listarTarefasPaginadas(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId, int $perPage = 5): LengthAwarePaginator;
public function listarIdsTarefas(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): array;
public function buscarProjetoPorNome(string $nome, int $macroprojetoId): ?object;
public function buscarTarefasGantt(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): array;
public function listarProjetosOrdenados(int $macroprojetoId): array;
public function listarCategoriasGantt(): array;
public function buscarTarefaFormulario(int $id, int $macroprojetoId): ?object;
public function buscarTarefaSimples(int $id, int $macroprojetoId): ?object;
public function buscarSubprojetosAjax(string $termo, array $projetos, ?int $projetoId, int $macroprojetoId): array;
public function buscarProjetosAjax(string $termo, int $macroprojetoId): array;
public function buscarUnidadesAjax(string $termo): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;

interface TarefaConsultaRepositoryInterface
{
    public function buscarTarefasKanban(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): Collection;
    public function listarTarefasPaginadas(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId, int $perPage = 5): LengthAwarePaginator;
    public function listarIdsTarefas(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): array;
    public function buscarProjetoPorNome(string $nome, int $macroprojetoId): ?object;
    public function buscarTarefasGantt(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): array;
    public function listarProjetosOrdenados(int $macroprojetoId): array;
    public function listarCategoriasGantt(): array;
    public function buscarTarefaFormulario(int $id, int $macroprojetoId): ?object;
    public function buscarTarefaSimples(int $id, int $macroprojetoId): ?object;
    public function buscarSubprojetosAjax(string $termo, array $projetos, ?int $projetoId, int $macroprojetoId): array;
    public function buscarProjetosAjax(string $termo, int $macroprojetoId): array;
    public function buscarUnidadesAjax(string $termo): array;
    public function buscarUnidadeDaTarefa(int $id, int $macroprojetoId): ?int;
    public function buscarEscopoUnidadesDaTarefa(int $id, int $macroprojetoId): ?object;
    public function listarUnidadesPorGrupo(int $grupoId): Collection;
    public function buscarRegistroAtual(int $id, int $macroprojetoId): ?object;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFACONSULTAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/TarefaEscritaRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAESCRITAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/TarefaEscritaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface TarefaEscritaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function atualizarPorLote(int $loteId, array $payload): int;
public function atualizarPorGrupo(int $grupoId, int $subprojetoId, array $payload): int;
public function atualizarTarefa(int $id, array $payload): void;
public function atualizarCamposRestritos(int $id, ?string $nrProcessoSei, ?string $dataRealInicio, ?string $dataRealFim, ?int $faseId): void;
public function criarLote(): int;
public function inserirTarefa(array $dados): void;
public function deletarTarefa(int $id): void;
public function criarTarefasParaUnidades(array $dadosBase, Collection $unidades, ?int $grupoId): void;
public function atualizarInicioManual(int $id, ?string $data, ?string $observacao): void;
public function marcarInicioAgora(int $id): void;
public function limparInicio(int $id): void;
public function marcarFimAgora(int $id): void;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

use Illuminate\Support\Collection;

interface TarefaEscritaRepositoryInterface
{
    public function atualizarPorLote(int $loteId, array $payload): int;
    public function atualizarPorGrupo(int $grupoId, int $subprojetoId, array $payload): int;
    public function atualizarTarefa(int $id, array $payload): void;
    public function atualizarCamposRestritos(int $id, ?string $nrProcessoSei, ?string $dataRealInicio, ?string $dataRealFim, ?int $faseId): void;
    public function criarLote(): int;
    public function inserirTarefa(array $dados): void;
    public function deletarTarefa(int $id): void;
    public function criarTarefasParaUnidades(array $dadosBase, Collection $unidades, ?int $grupoId): void;
    public function atualizarInicioManual(int $id, ?string $data, ?string $observacao): void;
    public function marcarInicioAgora(int $id): void;
    public function limparInicio(int $id): void;
    public function marcarFimAgora(int $id): void;
    public function limparFim(int $id): void;
    public function atualizarFimManual(int $id, ?string $data, ?string $observacao): void;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAESCRITAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/TarefaReferenciaRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAREFERENCIAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/TarefaReferenciaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface TarefaReferenciaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarMacroprojetoAtivoPublico(): ?int;
public function listarProjetos(int $macroprojetoId): array;
public function listarUnidades(): array;
public function listarUnidadesParaFormulario(int $macroprojetoId): array;
public function listarCategoriasAtivas(int $macroprojetoId): array;
public function listarFasesAtivas(int $macroprojetoId): array;
public function listarCategoriasComSelecionada(?int $categoriaId): array;
public function listarFasesComSelecionada(?int $faseId): array;
public function listarGrupos(int $macroprojetoId): array;
public function buscarSubprojetosPorProjetos(array $projetosIds, int $macroprojetoId): array;
public function buscarSubprojetosPorIds(array $subprojetosIds, int $macroprojetoId): array;
public function listarTodosSubprojetos(int $macroprojetoId): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

use Illuminate\Support\Collection;

interface TarefaReferenciaRepositoryInterface
{
    public function buscarMacroprojetoAtivoPublico(): ?int;
    public function listarProjetos(int $macroprojetoId): array;
    public function listarUnidades(): array;
    public function listarUnidadesParaFormulario(int $macroprojetoId): array;
    public function listarCategoriasAtivas(int $macroprojetoId): array;
    public function listarFasesAtivas(int $macroprojetoId): array;
    public function listarCategoriasComSelecionada(?int $categoriaId): array;
    public function listarFasesComSelecionada(?int $faseId): array;
    public function listarGrupos(int $macroprojetoId): array;
    public function buscarSubprojetosPorProjetos(array $projetosIds, int $macroprojetoId): array;
    public function buscarSubprojetosPorIds(array $subprojetosIds, int $macroprojetoId): array;
    public function listarTodosSubprojetos(int $macroprojetoId): array;
    public function buscarTarefasMonitoramento(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): Collection;
    public function buscarTarefasMonitoramentoPublico(int $macroprojetoId): Collection;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAREFERENCIAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/TarefaRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/TarefaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface TarefaRepositoryInterface extends`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

/** @deprecated Injete somente as interfaces de responsabilidade usadas pelo consumidor. */
interface TarefaRepositoryInterface extends
    TarefaReferenciaRepositoryInterface,
    TarefaConsultaRepositoryInterface,
    TarefaAndamentoRepositoryInterface,
    TarefaSolicitacaoPrazoRepositoryInterface,
    TarefaEscritaRepositoryInterface
{
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/Contracts/TarefaSolicitacaoPrazoRepositoryInterface.php`
## <APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFASOLICITACAOPRAZOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/Contracts/TarefaSolicitacaoPrazoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\Tarefas\Contracts`
- **Entidade / Classe:** `interface TarefaSolicitacaoPrazoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarSolicitacoesAlteracaoPrazo(int $tarefaId): array;
public function listarSolicitacoesAlteracaoPrazoPainel(array $filtros, int $macroprojetoId, int $perPage = 20): LengthAwarePaginator;
public function contarSolicitacoesAlteracaoPrazoPainelPorStatus(array $filtros, int $macroprojetoId): array;
public function buscarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId): ?object;
public function inserirSolicitacaoAlteracaoPrazo(
public function aprovarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId, ?string $aprovador): void;
public function rejeitarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId, string $motivo, ?string $aprovador): void;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface TarefaSolicitacaoPrazoRepositoryInterface
{
    public function listarSolicitacoesAlteracaoPrazo(int $tarefaId): array;
    public function listarSolicitacoesAlteracaoPrazoPainel(array $filtros, int $macroprojetoId, int $perPage = 20): LengthAwarePaginator;
    public function contarSolicitacoesAlteracaoPrazoPainelPorStatus(array $filtros, int $macroprojetoId): array;
    public function buscarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId): ?object;
    public function inserirSolicitacaoAlteracaoPrazo(
        int $tarefaId,
        string $tipoSolicitacao,
        ?string $dataPrevistaInicio,
        ?string $dataPrevistaFim,
        ?int $unidadeIdNova,
        ?string $nomeNovo,
        ?string $descricaoNova,
        string $justificativa,
        ?string $solicitante
    ): void;
    public function aprovarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId, ?string $aprovador): void;
    public function rejeitarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId, string $motivo, ?string $aprovador): void;
}
```
</APP_REPOSITORIES_TAREFAS_CONTRACTS_TAREFASOLICITACAOPRAZOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/FaseTarefaRepository.php`
## <APP_REPOSITORIES_TAREFAS_FASETAREFAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/FaseTarefaRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class FaseTarefaRepository implements FaseTarefaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('FASE_TAREFA as F')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(string $busca = '', ?string $ativo = null, int $perPage = 5): LengthAwarePaginator
public function buscar(int $id): ?object
public function criar(array $dados): void
public function atualizar(int $id, array $dados): void
public function alterarStatus(int $id): ?string
public function remover(int $id): void
public function listarAtivas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use App\Repositories\Tarefas\Contracts\FaseTarefaRepositoryInterface;

class FaseTarefaRepository implements FaseTarefaRepositoryInterface
{
    use AuditaDml;

    public function listar(string $busca = '', ?string $ativo = null, int $perPage = 5): LengthAwarePaginator
    {
        $query = DB::table('FASE_TAREFA as F')
            ->selectRaw("F.ID, F.NOME, F.DESCRICAO, F.ATIVO, TO_CHAR(F.DT_CRIACAO, 'DD/MM/YYYY HH24:MI') AS DT_CRIACAO, TO_CHAR(F.DT_ATUALIZACAO, 'DD/MM/YYYY HH24:MI') AS DT_ATUALIZACAO")
            ->orderByDesc('F.ID');

        if ($busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->whereRaw('UPPER(F.NOME) LIKE ? OR UPPER(F.DESCRICAO) LIKE ?', [$like, $like]);
        }

        if ($ativo !== null && $ativo !== '') {
            $query->where('F.ATIVO', $ativo === 'S' ? 'S' : 'N');
        }

        return $query->paginate($perPage)->withQueryString();
    }

    public function buscar(int $id): ?object
    {
        return DB::selectOne(
            "SELECT ID, NOME, DESCRICAO, ATIVO FROM FASE_TAREFA WHERE ID = :id",
            ['id' => $id]
        ) ?: null;
    }

    public function criar(array $dados): void
    {
        $this->inserirAuditado('FASE_TAREFA', 'FASE_TAREFA', [
            'NOME' => $dados['NOME'],
            'DESCRICAO' => $dados['DESCRICAO'] ?? null,
            'ATIVO' => $dados['ATIVO'] ? 'S' : 'N',
            'DT_CRIACAO' => DB::raw('SYSDATE'),
        ], 'ID', 'ID');
    }

    public function atualizar(int $id, array $dados): void
    {
        $this->atualizarAuditadoPorId('FASE_TAREFA', 'FASE_TAREFA', 'ID', $id, [
            'NOME' => $dados['NOME'],
            'DESCRICAO' => $dados['DESCRICAO'] ?? null,
            'ATIVO' => $dados['ATIVO'] ? 'S' : 'N',
            'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
        ]);
    }

    public function alterarStatus(int $id): ?string
    {
        $registro = DB::selectOne("SELECT ATIVO FROM FASE_TAREFA WHERE ID = :id", ['id' => $id]);
        if (!$registro) {
            return null;
        }

        $novoStatus = ($registro->ativo ?? 'S') === 'S' ? 'N' : 'S';

        $this->atualizarAuditadoPorId('FASE_TAREFA', 'FASE_TAREFA', 'ID', $id, [
            'ATIVO' => $novoStatus,
            'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
        ]);

        return $novoStatus;
    }

    public function remover(int $id): void
    {
        $this->removerAuditadoPorId('FASE_TAREFA', 'FASE_TAREFA', 'ID', $id);
    }

    public function listarAtivas(): array
    {
        return DB::select("
            SELECT ID AS id, NOME AS text
            FROM FASE_TAREFA
            WHERE ATIVO = 'S'
            ORDER BY NOME
        ");
    }
}
```
</APP_REPOSITORIES_TAREFAS_FASETAREFAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/TarefaAlertaAuditoriaRepository.php`
## <APP_REPOSITORIES_TAREFAS_TAREFAALERTAAUDITORIAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/TarefaAlertaAuditoriaRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaAuditoriaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function registrar(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas;

use App\Repositories\Concerns\AuditaDml;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Support\Facades\DB;

class TarefaAlertaAuditoriaRepository
{
    use AuditaDml;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function registrar(
        ?int $agendamentoId,
        string $acao,
        array $operador,
        array $extras = []
    ): void {
        $this->inserirAuditado('tarefa_alerta_auditoria', 'TAREFA_ALERTA_AUDITORIA', array_merge([
            'agendamento_id'    => $agendamentoId,
            'acao'              => $acao,
            'operador_id'       => $operador['id'] ?? null,
            'operador_username' => $operador['username'] ?? null,
            'operador_nome'     => $operador['nome'] ?? null,
            'dt_acao'           => DB::raw('SYSDATE'),
        ], $extras), 'id', 'id');
    }
}
```
</APP_REPOSITORIES_TAREFAS_TAREFAALERTAAUDITORIAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/TarefaAlertaExecucaoRepository.php`
## <APP_REPOSITORIES_TAREFAS_TAREFAALERTAEXECUCAOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/TarefaAlertaExecucaoRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaExecucaoRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('tarefa_alerta_execucao')->where('id', $id)->first();
return DB::table('tarefa_alerta_execucao')
return DB::table('tarefa_alerta_execucao')
return DB::table('tarefa_alerta_execucao')
$destinatarios = DB::table('tarefa_alerta_execucao_destinatario')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function criar(array $dados): int
public function encontrar(int $id): ?object
public function encontrarOuFalhar(int $id): object
public function atualizarStatus(int $id, string $status, array $extras = []): void
public function marcarProcessandoSePendente(int $id): bool
public function encontrarPorIdempotencia(string $chave): ?object
public function historicoDoAgendamento(int $agendamentoId, int $porPagina = 20): \Illuminate\Pagination\LengthAwarePaginator
public function historicoImediato(int $macroprojetoId, int $porPagina = 20): \Illuminate\Pagination\LengthAwarePaginator
public function detalhesDaExecucao(int $execucaoId): array
public function criarDestinatario(int $execucaoId, array $dados): int
public function atualizarDestinatario(int $id, array $dados): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas;

use App\Repositories\Concerns\AuditaDml;
use App\Services\Auditoria\AuditLogService;
use App\Support\Tarefas\TarefaAlertaExecucaoStatus;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class TarefaAlertaExecucaoRepository
{
    use AuditaDml;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'tarefa_alerta_execucao',
            'TAREFA_ALERTA_EXECUCAO',
            $dados + ['dt_criacao' => DB::raw('SYSDATE')],
            'id',
            'id'
        );
    }

    public function encontrar(int $id): ?object
    {
        return DB::table('tarefa_alerta_execucao')->where('id', $id)->first();
    }

    public function encontrarOuFalhar(int $id): object
    {
        $execucao = $this->encontrar($id);
        if ($execucao === null) {
            throw new \App\Exceptions\RegistroNaoEncontradoException('Execução não encontrada.');
        }
        return $execucao;
    }

    public function atualizarStatus(int $id, string $status, array $extras = []): void
    {
        $this->atualizarAuditadoPorId(
            'tarefa_alerta_execucao',
            'TAREFA_ALERTA_EXECUCAO',
            'id',
            $id,
            array_merge(['status' => $status, 'dt_atualizacao' => DB::raw('SYSDATE')], $extras)
        );
    }

    public function marcarProcessandoSePendente(int $id): bool
    {
        return $this->atualizarEscopoAuditado(
            'tarefa_alerta_execucao',
            'TAREFA_ALERTA_EXECUCAO',
            $id,
            static fn ($query) => $query
                ->where('id', $id)
                ->where('status', TarefaAlertaExecucaoStatus::PENDENTE),
            [
                'status' => TarefaAlertaExecucaoStatus::PROCESSANDO,
                'data_hora_inicio' => DB::raw('SYSDATE'),
                'dt_atualizacao' => DB::raw('SYSDATE'),
            ],
            ['id' => $id, 'status' => TarefaAlertaExecucaoStatus::PENDENTE]
        ) === 1;
    }

    /**
     * Verifica idempotência: retorna a execução existente para a chave ou null.
     */
    public function encontrarPorIdempotencia(string $chave): ?object
    {
        return DB::table('tarefa_alerta_execucao')
            ->where('idempotencia_chave', $chave)
            ->first();
    }

    /**
     * Histórico paginado de um agendamento.
     */
    public function historicoDoAgendamento(int $agendamentoId, int $porPagina = 20): \Illuminate\Pagination\LengthAwarePaginator
    {
        return DB::table('tarefa_alerta_execucao')
            ->where('agendamento_id', $agendamentoId)
            ->orderByDesc('dt_criacao')
            ->paginate($porPagina);
    }

    /**
     * Histórico paginado de execuções imediatas/manuais de um macroprojeto (agendamento_id nulo).
     * Usa JSON_VALUE do Oracle para filtrar pelo escopo_json.macroprojeto_id.
     */
    public function historicoImediato(int $macroprojetoId, int $porPagina = 20): \Illuminate\Pagination\LengthAwarePaginator
    {
        return DB::table('tarefa_alerta_execucao')
            ->whereNull('agendamento_id')
            ->whereRaw("JSON_VALUE(escopo_json, '$.macroprojeto_id') = ?", [(string) $macroprojetoId])
            ->orderByDesc('dt_criacao')
            ->paginate($porPagina);
    }

    public function detalhesDaExecucao(int $execucaoId): array
    {
        $destinatarios = DB::table('tarefa_alerta_execucao_destinatario')
            ->where('execucao_id', $execucaoId)
            ->orderBy('email')
            ->get();

        return $destinatarios->map(function ($destinatario): array {
            $dados = (array) $destinatario;
            $dados['tarefas'] = DB::table('tarefa_alerta_execucao_dest_tarefa')
                ->where('destinatario_id', $destinatario->id)
                ->orderBy('tarefa_id')
                ->get()
                ->map(static fn ($tarefa): array => [
                    'id' => (int) $tarefa->tarefa_id,
                    'dados' => json_decode($tarefa->tarefa_json ?? '{}', true) ?? [],
                ])->all();
            $dados['tentativas_historico'] = DB::table('tarefa_alerta_execucao_tentativa')
                ->where('destinatario_id', $destinatario->id)
                ->orderBy('numero')
                ->get()
                ->map(static fn ($tentativa): array => (array) $tentativa)
                ->all();
            return $dados;
        })->all();
    }

    // ─── Destinatários ───────────────────────────────────────────────────────

    public function criarDestinatario(int $execucaoId, array $dados): int
    {
        return (int) $this->inserirAuditado(
            'tarefa_alerta_execucao_destinatario',
            'TAREFA_ALERTA_EXECUCAO_DESTINATARIO',
            array_merge(['execucao_id' => $execucaoId], $dados, ['dt_criacao' => DB::raw('SYSDATE')]),
            'id',
            'id'
        );
    }

    public function atualizarDestinatario(int $id, array $dados): void
    {
        $this->atualizarAuditadoPorId(
            'tarefa_alerta_execucao_destinatario',
            'TAREFA_ALERTA_EXECUCAO_DESTINATARIO',
            'id',
            $id,
            $dados + ['dt_atualizacao' => DB::raw('SYSDATE')]
        );
    }

    /**
     * @return Collection<int, object>
     */
    public function destinatariosDoExecucao(int $execucaoId): Collection
    {
        return collect(
            DB::table('tarefa_alerta_execucao_destinatario')
                ->where('execucao_id', $execucaoId)
                ->get()
        );
    }

    /**
     * @return Collection<int, object>
     */
    public function destinatariosComFalha(int $execucaoId): Collection
    {
        return collect(
            DB::table('tarefa_alerta_execucao_destinatario')
                ->where('execucao_id', $execucaoId)
                ->where('status', 'falha')
                ->get()
        );
    }

    /**
     * @return Collection<int, object>
     */
    public function destinatariosPendentes(int $execucaoId): Collection
    {
        return collect(
            DB::table('tarefa_alerta_execucao_destinatario')
                ->where('execucao_id', $execucaoId)
                ->where('status', 'pendente')
                ->get()
        );
    }

    /**
     * Retorna as tarefas de um destinatário já armazenadas na tabela de tarefas.
     *
     * @return array<int, array<string, mixed>>
     */
    public function tarefasDoDestinatario(int $destinatarioId): array
    {
        return DB::table('tarefa_alerta_execucao_dest_tarefa')
            ->where('destinatario_id', $destinatarioId)
            ->orderBy('tarefa_id')
            ->get()
            ->map(static fn ($row) => json_decode($row->tarefa_json ?? '{}', true) ?? [])
            ->filter()
            ->values()
            ->all();
    }

    /**
     * Redefine como pendente todos os destinatários com falha de uma execução (reprocessamento).
     */
    public function redefinirFalhasComoPendente(int $execucaoId): void
    {
        $this->atualizarEscopoAuditado(
            'tarefa_alerta_execucao_destinatario',
            'TAREFA_ALERTA_EXECUCAO_DESTINATARIO',
            $execucaoId,
            static fn ($query) => $query->where('execucao_id', $execucaoId)->where('status', 'falha'),
            ['status' => 'pendente', 'dt_atualizacao' => DB::raw('SYSDATE')],
            ['execucao_id' => $execucaoId, 'status' => 'falha']
        );
    }

    /**
     * Snapshot completo de todas execuções de um agendamento para auditoria de exclusão.
     * Inclui destinatários, tarefas associadas e tentativas.
     *
     * @return array<int, array<string, mixed>>
     */
    public function todasDoAgendamento(int $agendamentoId): array
    {
        $execucoes = DB::table('tarefa_alerta_execucao')
            ->where('agendamento_id', $agendamentoId)
            ->orderByDesc('dt_criacao')
            ->get();

        return $execucoes->map(function ($exec) {
            $execArray = (array) $exec;

            $destinatarios = DB::table('tarefa_alerta_execucao_destinatario')
                ->where('execucao_id', $exec->id)
                ->get();

            $execArray['destinatarios'] = $destinatarios->map(function ($dest) {
                $destArray = (array) $dest;

                $destArray['tarefas'] = DB::table('tarefa_alerta_execucao_dest_tarefa')
                    ->where('destinatario_id', $dest->id)
                    ->pluck('tarefa_json')
                    ->all();

                $destArray['tentativas'] = DB::table('tarefa_alerta_execucao_tentativa')
                    ->where('destinatario_id', $dest->id)
                    ->orderBy('numero')
                    ->get()
                    ->map(static fn ($t) => (array) $t)
                    ->all();

                return $destArray;
            })->all();

            return $execArray;
        })->all();
    }

    public function todasImediatas(int $macroprojetoId): array
    {
        $execucoes = DB::table('tarefa_alerta_execucao')
            ->whereNull('agendamento_id')
            ->whereRaw("JSON_VALUE(escopo_json, '$.macroprojeto_id') = ?", [(string) $macroprojetoId])
            ->orderByDesc('dt_criacao')
            ->get();

        return $execucoes->map(function ($exec): array {
            $execArray = (array) $exec;
            $destinatarios = DB::table('tarefa_alerta_execucao_destinatario')
                ->where('execucao_id', $exec->id)
                ->get();

            $execArray['destinatarios'] = $destinatarios->map(function ($dest): array {
                $destArray = (array) $dest;
                $destArray['tarefas'] = DB::table('tarefa_alerta_execucao_dest_tarefa')
                    ->where('destinatario_id', $dest->id)
                    ->pluck('tarefa_json')
                    ->all();
                $destArray['tentativas'] = DB::table('tarefa_alerta_execucao_tentativa')
                    ->where('destinatario_id', $dest->id)
                    ->orderBy('numero')
                    ->get()
                    ->map(static fn ($tentativa): array => (array) $tentativa)
                    ->all();
                return $destArray;
            })->all();

            return $execArray;
        })->all();
    }

    public function criarTarefasDestinatario(int $destinatarioId, array $tarefas): void
    {
        foreach ($tarefas as $tarefa) {
            $this->inserirAuditado('tarefa_alerta_execucao_dest_tarefa', 'TAREFA_ALERTA_EXECUCAO_DEST_TAREFA', [
                'destinatario_id' => $destinatarioId,
                'tarefa_id'       => $tarefa['id'],
                'tarefa_json'     => json_encode($tarefa),
            ], 'id', 'id');
        }
    }

    public function excluirTarefasDestinatario(int $destinatarioId): void
    {
        $this->removerEscopoAuditado(
            'tarefa_alerta_execucao_dest_tarefa',
            'TAREFA_ALERTA_EXECUCAO_DEST_TAREFA',
            $destinatarioId,
            static fn ($query) => $query->where('destinatario_id', $destinatarioId),
            ['destinatario_id' => $destinatarioId]
        );
    }

    // ─── Tentativas ──────────────────────────────────────────────────────────

    public function criarTentativa(int $destinatarioId, int $numero, string $status, array $extras = []): void
    {
        $this->inserirAuditado('tarefa_alerta_execucao_tentativa', 'TAREFA_ALERTA_EXECUCAO_TENTATIVA', array_merge([
            'destinatario_id' => $destinatarioId,
            'numero'          => $numero,
            'status'          => $status,
            'dt_tentativa'    => DB::raw('SYSDATE'),
        ], $extras), 'id', 'id');
    }

    public function proximoNumeroDeTentativa(int $destinatarioId): int
    {
        return 1 + (int) DB::table('tarefa_alerta_execucao_tentativa')
            ->where('destinatario_id', $destinatarioId)
            ->max('numero');
    }

    // ─── Totais ──────────────────────────────────────────────────────────────

    public function recalcularTotais(int $execucaoId): void
    {
        $totais = DB::table('tarefa_alerta_execucao_destinatario')
            ->where('execucao_id', $execucaoId)
            ->selectRaw("
                COUNT(*) AS total_destinatarios,
                SUM(CASE WHEN status = 'enviado' THEN 1 ELSE 0 END) AS total_sucessos,
                SUM(CASE WHEN status = 'falha'   THEN 1 ELSE 0 END) AS total_falhas
            ")
            ->first();

        $total = (int) ($totais->total_destinatarios ?? 0);
        $sucessos = (int) ($totais->total_sucessos ?? 0);
        $falhas = (int) ($totais->total_falhas ?? 0);

        $status = $this->derivarStatus($total, $sucessos, $falhas);

        $this->atualizarAuditadoPorId('tarefa_alerta_execucao', 'TAREFA_ALERTA_EXECUCAO', 'id', $execucaoId, [
            'total_destinatarios' => $total,
            'total_sucessos'      => $sucessos,
            'total_falhas'        => $falhas,
            'status'              => $status,
            'data_hora_fim'       => DB::raw('SYSDATE'),
            'dt_atualizacao'      => DB::raw('SYSDATE'),
        ]);
    }

    private function derivarStatus(int $total, int $sucessos, int $falhas): string
    {
        if ($total === 0 || ($total === $sucessos && $falhas === 0)) {
            return TarefaAlertaExecucaoStatus::CONCLUIDA;
        }

        if ($falhas === $total) {
            return TarefaAlertaExecucaoStatus::FALHA;
        }

        return TarefaAlertaExecucaoStatus::PARCIAL;
    }
}
```
</APP_REPOSITORIES_TAREFAS_TAREFAALERTAEXECUCAOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/TarefaAlertaRepository.php`
## <APP_REPOSITORIES_TAREFAS_TAREFAALERTAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/TarefaAlertaRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('VW_TAREFA_STATUS as V')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarTarefas(array $dados, ?array $unidadesPermitidas, int $macroprojetoId): Collection
private function mapearUnidade(?string $sigla, ?string $descricao, ?string $email): ?array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas;

use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class TarefaAlertaRepository
{
    public function buscarTarefas(array $dados, ?array $unidadesPermitidas, int $macroprojetoId): Collection
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return collect();
        }

        $query = DB::table('VW_TAREFA_STATUS as V')
            ->leftJoin('SUBPROJETO as S', 'S.ID', '=', 'V.SUBPROJETO_ID')
            ->leftJoin('PROJETO as P', 'P.ID', '=', 'S.PROJETO_ID')
            ->leftJoin('VW_UNIDADE as UT', 'UT.ID_UNIDADE', '=', 'V.UNIDADE_ID')
            ->leftJoin('VW_UNIDADE as US', 'US.ID_UNIDADE', '=', 'S.UNIDADE_ID')
            ->leftJoin('VW_UNIDADE as UP', 'UP.ID_UNIDADE', '=', 'P.UNIDADE_ID')
            ->selectRaw("
                V.ID,
                V.NOME,
                V.STATUS,
                V.SUBPROJETO_ID,
                V.SUBPROJETO_NOME,
                V.UNIDADE_SIGLA,
                TO_CHAR(V.DATA_PREVISTA_INICIO, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO,
                TO_CHAR(V.DATA_PREVISTA_FIM, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM,
                TO_CHAR(V.DATA_REAL_INICIO, 'DD/MM/YYYY') AS DATA_REAL_INICIO,
                TO_CHAR(V.DATA_REAL_FIM, 'DD/MM/YYYY') AS DATA_REAL_FIM,
                P.ID AS PROJETO_ID,
                P.NOME AS PROJETO_NOME,
                UT.SIGLA AS TAREFA_UNIDADE_SIGLA,
                UT.DESCRICAO AS TAREFA_UNIDADE_DESCRICAO,
                UT.EMAIL AS TAREFA_UNIDADE_EMAIL,
                US.SIGLA AS SUBPROJETO_UNIDADE_SIGLA,
                US.DESCRICAO AS SUBPROJETO_UNIDADE_DESCRICAO,
                US.EMAIL AS SUBPROJETO_UNIDADE_EMAIL,
                UP.SIGLA AS PROJETO_UNIDADE_SIGLA,
                UP.DESCRICAO AS PROJETO_UNIDADE_DESCRICAO,
                UP.EMAIL AS PROJETO_UNIDADE_EMAIL
            ");

        $query->where('P.MACROPROJETO_ID', $macroId);

        if (!empty($dados['status'])) {
            $query->whereIn('V.STATUS', $dados['status']);
        }

        if (!empty($dados['projeto_id'])) {
            $query->where('P.ID', (int) $dados['projeto_id']);
        }

        if (!empty($dados['subprojeto_id'])) {
            $subprojetos = collect((array) $dados['subprojeto_id'])
                ->map(static fn ($id) => is_numeric($id) ? (int) $id : null)
                ->filter(static fn ($id) => $id !== null && $id > 0)
                ->unique()
                ->values()
                ->all();

            if (!empty($subprojetos)) {
                $query->whereIn('V.SUBPROJETO_ID', $subprojetos);
            }
        }

        if (!empty($dados['unidade_id'])) {
            $query->where('V.UNIDADE_ID', (int) $dados['unidade_id']);
        }

        if (!empty($dados['data_prevista_inicio_de'])) {
            $query->whereRaw("V.DATA_PREVISTA_INICIO >= TO_DATE(?, 'YYYY-MM-DD')", [$dados['data_prevista_inicio_de']]);
        }

        if (!empty($dados['data_prevista_fim_ate'])) {
            $query->whereRaw("V.DATA_PREVISTA_FIM <= TO_DATE(?, 'YYYY-MM-DD')", [$dados['data_prevista_fim_ate']]);
        }

        if (is_array($unidadesPermitidas)) {
            if (empty($unidadesPermitidas)) {
                $query->whereRaw('1 = 0');
            } else {
                $query->where(function ($sub) use ($unidadesPermitidas) {
                    $sub->whereIn('V.UNIDADE_ID', $unidadesPermitidas)
                        ->orWhereIn('S.UNIDADE_ID', $unidadesPermitidas)
                        ->orWhereIn('P.UNIDADE_ID', $unidadesPermitidas);
                });
            }
        }

        return collect($query->orderBy('V.DATA_PREVISTA_FIM')->get())->map(function ($row) {
            return [
                'id' => (int) $row->id,
                'nome' => $row->nome,
                'status' => $row->status,
                'projeto_id' => $row->projeto_id ? (int) $row->projeto_id : null,
                'projeto_nome' => $row->projeto_nome,
                'subprojeto_id' => $row->subprojeto_id ? (int) $row->subprojeto_id : null,
                'subprojeto_nome' => $row->subprojeto_nome,
                'data_prevista_inicio' => $row->data_prevista_inicio,
                'data_prevista_fim' => $row->data_prevista_fim,
                'data_real_inicio' => $row->data_real_inicio,
                'data_real_fim' => $row->data_real_fim,
                'unidade_tarefa' => $this->mapearUnidade($row->tarefa_unidade_sigla, $row->tarefa_unidade_descricao, $row->tarefa_unidade_email),
                'unidade_subprojeto' => $this->mapearUnidade($row->subprojeto_unidade_sigla, $row->subprojeto_unidade_descricao, $row->subprojeto_unidade_email),
                'unidade_projeto' => $this->mapearUnidade($row->projeto_unidade_sigla, $row->projeto_unidade_descricao, $row->projeto_unidade_email),
            ];
        });
    }

    private function mapearUnidade(?string $sigla, ?string $descricao, ?string $email): ?array
    {
        if ($sigla === null && $descricao === null && $email === null) {
            return null;
        }

        $label = trim(($sigla ? $sigla : '') . ($descricao ? ' - ' . $descricao : ''));

        return [
            'sigla' => $sigla,
            'descricao' => $descricao,
            'label' => $label !== '' ? $label : null,
            'email' => $email,
        ];
    }
}
```
</APP_REPOSITORIES_TAREFAS_TAREFAALERTAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/TarefaRepository.php`
## <APP_REPOSITORIES_TAREFAS_TAREFAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/TarefaRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class TarefaRepository implements TarefaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$valor = DB::table('MACROPROJETO')
$query = DB::table('VW_TAREFA_STATUS as V')
$query = DB::table('VW_TAREFA_STATUS as V')
$query = DB::table('VW_TAREFA_STATUS as V')
$query = DB::table('TAREFA_SOLICITACAO_PRAZO as S')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarMacroprojetoAtivoPublico(): ?int
private function aplicarFiltroUnidades(Builder $query, ?array $unidadesPermitidas): void
public function listarProjetos(int $macroprojetoId): array
public function listarUnidades(): array
public function listarUnidadesParaFormulario(int $macroprojetoId): array
public function listarCategoriasAtivas(int $macroprojetoId): array
public function listarFasesAtivas(int $macroprojetoId): array
public function listarCategoriasComSelecionada(?int $categoriaId): array
public function listarFasesComSelecionada(?int $faseId): array
public function listarGrupos(int $macroprojetoId): array
public function buscarSubprojetosPorProjetos(array $projetosIds, int $macroprojetoId): array
public function buscarSubprojetosPorIds(array $subprojetosIds, int $macroprojetoId): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Tarefas;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class TarefaRepository implements TarefaRepositoryInterface
{
    use AuditaDml;

    public function buscarMacroprojetoAtivoPublico(): ?int
    {
        $valor = DB::table('MACROPROJETO')
            ->whereRaw("UPPER(NOME) = UPPER('Eleições 2026')")
            ->where('ATIVO', 'S')
            ->value('ID');

        return $valor !== null ? (int) $valor : null;
    }

    private function aplicarFiltroUnidades(Builder $query, ?array $unidadesPermitidas): void
    {
        if (! is_array($unidadesPermitidas)) {
            return;
        }

        if (empty($unidadesPermitidas)) {
            $query->whereRaw('1 = 0');

            return;
        }

        $query->where(function ($sub) use ($unidadesPermitidas) {
            $sub->whereIn('V.UNIDADE_ID', $unidadesPermitidas)
                ->orWhereIn('S.UNIDADE_ID', $unidadesPermitidas)
                ->orWhereIn('P.UNIDADE_ID', $unidadesPermitidas);
        });
    }

    public function listarProjetos(int $macroprojetoId): array
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        return DB::select('
            SELECT ID, NOME
            FROM PROJETO
            WHERE MACROPROJETO_ID = :macroprojeto_id
            ORDER BY NOME
        ', ['macroprojeto_id' => $macroId]);
    }

    public function listarUnidades(): array
    {
        return DB::select("SELECT ID_UNIDADE AS ID, SIGLA || ' - ' || DESCRICAO AS NOME FROM VW_UNIDADE ORDER BY SIGLA");
    }

    public function listarUnidadesParaFormulario(int $macroprojetoId): array
    {
        return DB::select("SELECT ID_UNIDADE AS ID, SIGLA || ' - ' || DESCRICAO AS SIGLA FROM VW_UNIDADE ORDER BY SIGLA");
    }

    public function listarCategoriasAtivas(int $macroprojetoId): array
    {
        return DB::select("SELECT ID, NOME FROM CATEGORIA_TAREFA WHERE ATIVO = 'S' ORDER BY NOME");
    }

    public function listarFasesAtivas(int $macroprojetoId): array
    {
        return DB::select("SELECT ID, NOME FROM FASE_TAREFA WHERE ATIVO = 'S' ORDER BY NOME");
    }

    public function listarCategoriasComSelecionada(?int $categoriaId): array
    {
        return DB::select("
            SELECT ID, NOME, ATIVO
            FROM CATEGORIA_TAREFA
            WHERE ATIVO = 'S' OR ID = :categoria_id
            ORDER BY NOME
        ", ['categoria_id' => $categoriaId ?? 0]);
    }

    public function listarFasesComSelecionada(?int $faseId): array
    {
        return DB::select("
            SELECT ID, NOME, ATIVO
            FROM FASE_TAREFA
            WHERE ATIVO = 'S' OR ID = :fase_id
            ORDER BY NOME
        ", ['fase_id' => $faseId ?? 0]);
    }

    public function listarGrupos(int $macroprojetoId): array
    {
        return DB::select('SELECT ID, NOME FROM GRUPO_UNIDADE ORDER BY NOME');
    }

    public function buscarSubprojetosPorProjetos(array $projetosIds, int $macroprojetoId): array
    {
        if (empty($projetosIds)) {
            return [];
        }

        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        $placeholders = implode(',', array_fill(0, count($projetosIds), '?'));
        $bindings = array_merge([$macroId], $projetosIds);

        return DB::select("
            SELECT ID, NOME
            FROM SUBPROJETO
            WHERE PROJETO_ID IN (
                SELECT ID
                FROM PROJETO
                WHERE MACROPROJETO_ID = ?
                  AND ID IN ($placeholders)
            )
            ORDER BY NOME
        ", $bindings);
    }

    public function buscarSubprojetosPorIds(array $subprojetosIds, int $macroprojetoId): array
    {
        if (empty($subprojetosIds)) {
            return [];
        }

        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        $placeholders = implode(',', array_fill(0, count($subprojetosIds), '?'));
        $bindings = array_merge([$macroId], $subprojetosIds);

        return DB::select("
            SELECT S.ID, S.NOME
            FROM SUBPROJETO S
                 INNER JOIN PROJETO P ON P.ID = S.PROJETO_ID
            WHERE P.MACROPROJETO_ID = ?
              AND S.ID IN ($placeholders)
            ORDER BY S.NOME
        ", $bindings);
    }

    public function listarTodosSubprojetos(int $macroprojetoId): array
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        return DB::select('
            SELECT S.ID, S.NOME
            FROM SUBPROJETO S
                 INNER JOIN PROJETO P ON P.ID = S.PROJETO_ID
            WHERE P.MACROPROJETO_ID = :macroprojeto_id
            ORDER BY S.NOME
        ', ['macroprojeto_id' => $macroId]);
    }

    public function buscarTarefasMonitoramento(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): Collection
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return collect();
        }

        return $this->buscarTarefasMonitoramentoPorMacroprojeto($macroId, $filtros, $unidadesPermitidas);
    }

    public function buscarTarefasMonitoramentoPublico(int $macroprojetoId): Collection
    {
        if ($macroprojetoId <= 0) {
            return collect();
        }

        return $this->buscarTarefasMonitoramentoPorMacroprojeto($macroprojetoId, [
            'projetos' => [],
            'subprojetos' => [],
            'unidades' => [],
            'categorias' => [],
        ], null);
    }

    private function buscarTarefasMonitoramentoPorMacroprojeto(int $macroId, array $filtros, ?array $unidadesPermitidas): Collection
    {
        if ($macroId <= 0) {
            return collect();
        }

        $query = DB::table('VW_TAREFA_STATUS as V')
            ->leftJoin('TAREFA as T', 'T.ID', '=', 'V.ID')
            ->leftJoin('SUBPROJETO as S', 'S.ID', '=', 'V.SUBPROJETO_ID')
            ->leftJoin('PROJETO as P', 'P.ID', '=', 'S.PROJETO_ID')
            ->selectRaw("
                V.ID,
                V.NOME,
                V.STATUS,
                V.SUBPROJETO_ID,
                V.SUBPROJETO_NOME,
                V.UNIDADE_ID,
                V.UNIDADE_SIGLA,
                P.ID AS PROJETO_ID,
                P.NOME AS PROJETO_NOME,
                TO_CHAR(V.DATA_PREVISTA_INICIO, 'YYYY-MM-DD') AS DATA_PREVISTA_INICIO,
                TO_CHAR(V.DATA_PREVISTA_FIM, 'YYYY-MM-DD') AS DATA_PREVISTA_FIM,
                TO_CHAR(V.DATA_REAL_INICIO, 'YYYY-MM-DD') AS DATA_REAL_INICIO,
                TO_CHAR(V.DATA_REAL_FIM, 'YYYY-MM-DD') AS DATA_REAL_FIM
            ")
            ->orderBy('P.NOME')
            ->orderBy('V.SUBPROJETO_NOME')
            ->orderBy('V.NOME');

        $query->where('P.MACROPROJETO_ID', $macroId);

        if (! empty($filtros['projetos'])) {
            $query->whereIn('S.PROJETO_ID', $filtros['projetos']);
        }

        if (! empty($filtros['subprojetos'])) {
            $query->whereIn('V.SUBPROJETO_ID', $filtros['subprojetos']);
        }

        if (! empty($filtros['unidades'])) {
            $query->whereIn('V.UNIDADE_ID', $filtros['unidades']);
        }

        if (! empty($filtros['categorias'])) {
            $query->whereIn('T.CATEGORIA_ID', $filtros['categorias']);
        }

        $this->aplicarFiltroUnidades($query, $unidadesPermitidas);

        return $query->get();
    }

    public function buscarTarefasKanban(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): Collection
    {
        if (! ($filtros['aplicar'] ?? false)) {
            return collect();
        }

        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return collect();
        }

        $query = DB::table('VW_TAREFA_STATUS as V')
            ->leftJoin('TAREFA as T', 'T.ID', '=', 'V.ID')
            ->leftJoin('SUBPROJETO as S', 'S.ID', '=', 'V.SUBPROJETO_ID')
            ->leftJoin('PROJETO as P', 'P.ID', '=', 'S.PROJETO_ID')
            ->leftJoin('CATEGORIA_TAREFA as CAT', 'CAT.ID', '=', 'T.CATEGORIA_ID')
            ->leftJoin('FASE_TAREFA as FT', 'FT.ID', '=', 'T.FASE_ID')
            ->selectRaw("
                V.ID,
                V.NOME,
                V.STATUS,
                V.SUBPROJETO_ID,
                V.SUBPROJETO_NOME,
                V.UNIDADE_ID,
                V.UNIDADE_SIGLA,
                V.UNIDADE_SIGLA AS UNIDADE,
                P.ID AS PROJETO_ID,
                P.NOME AS PROJETO_NOME,
                TO_CHAR(V.DT_CRIACAO, 'DD/MM/YYYY') AS DT_CRIACAO,
                TO_CHAR(V.DATA_PREVISTA_INICIO, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO,
                TO_CHAR(V.DATA_PREVISTA_FIM, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM,
                TO_CHAR(V.DATA_REAL_INICIO, 'DD/MM/YYYY') AS DATA_REAL_INICIO,
                TO_CHAR(V.DATA_REAL_FIM, 'DD/MM/YYYY') AS DATA_REAL_FIM,
                T.DESCRICAO,
                T.OBSERVACAO,
                T.HORAS_EXTRAS,
                T.PESSOAS_ENVOLVIDAS,
                CAT.NOME AS CATEGORIA_NOME,
                T.NR_PROCESSO_SEI,
                FT.NOME AS FASE_NOME,
                (
                    SELECT COUNT(*)
                    FROM TAREFA_ANDAMENTO A
                    WHERE A.TAREFA_ID = V.ID
                ) AS QTDE_ANDAMENTOS
            ")
            ->orderBy('V.DATA_PREVISTA_FIM')
            ->orderBy('V.ID');

        $query->where('P.MACROPROJETO_ID', $macroId);

        if (! empty($filtros['projetos'])) {
            $query->whereIn('S.PROJETO_ID', $filtros['projetos']);
        }

        if (! empty($filtros['subprojetos'])) {
            $query->whereIn('V.SUBPROJETO_ID', $filtros['subprojetos']);
        }

        if (! empty($filtros['unidades'])) {
            $query->whereIn('V.UNIDADE_ID', $filtros['unidades']);
        }

        if (! empty($filtros['categorias'])) {
            $query->whereIn('T.CATEGORIA_ID', $filtros['categorias']);
        }

        if (! empty($filtros['fases'])) {
            $query->whereIn('T.FASE_ID', $filtros['fases']);
        }

        if (! empty($filtros['statuses'])) {
            $query->whereIn('V.STATUS', $filtros['statuses']);
        }

        if (! empty($filtros['busca_texto'])) {
            $like = '%'.mb_strtoupper((string) $filtros['busca_texto'], 'UTF-8').'%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(T.DESCRICAO) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(V.NOME) LIKE ?', [$like]);
            });
        }

        if (! empty($filtros['ordenar_prev_inicio'])) {
            $query->reorder()
                ->orderByRaw('CASE WHEN V.DATA_PREVISTA_INICIO IS NULL THEN 1 ELSE 0 END')
                ->orderBy('V.DATA_PREVISTA_INICIO')
                ->orderByDesc('V.ID');
        }

        $this->aplicarFiltroUnidades($query, $unidadesPermitidas);

        return $query->get();
    }

    private function montarQueryTarefasListagem(array $filtros, int $macroprojetoId): Builder
    {
        $macroId = $macroprojetoId;

        $query = DB::table('VW_TAREFA_STATUS as V')
            ->leftJoin('TAREFA as TAR', 'TAR.ID', '=', 'V.ID')
            ->leftJoin('SUBPROJETO as S', 'S.ID', '=', 'V.SUBPROJETO_ID')
            ->leftJoin('PROJETO as P', 'P.ID', '=', 'S.PROJETO_ID')
            ->leftJoin('CATEGORIA_TAREFA as CAT', 'CAT.ID', '=', 'TAR.CATEGORIA_ID')
            ->leftJoin('FASE_TAREFA as FT', 'FT.ID', '=', 'TAR.FASE_ID');

        if ($macroId <= 0) {
            $query->whereRaw('1 = 0');
        } else {
            $query->where('P.MACROPROJETO_ID', $macroId);
        }

        if (! empty($filtros['projetos'])) {
            $query->whereIn('S.PROJETO_ID', $filtros['projetos']);
        }

        if (! empty($filtros['subprojetos'])) {
            $query->whereIn('V.SUBPROJETO_ID', $filtros['subprojetos']);
        }

        if (! empty($filtros['statuses'])) {
            $query->whereIn('V.STATUS', $filtros['statuses']);
        }

        if (! empty($filtros['unidades'])) {
            $query->whereIn('V.UNIDADE_ID', $filtros['unidades']);
        }

        if (! empty($filtros['categorias'])) {
            $query->whereIn('TAR.CATEGORIA_ID', $filtros['categorias']);
        }

        if (! empty($filtros['fases'])) {
            $query->whereIn('TAR.FASE_ID', $filtros['fases']);
        }

        $buscaTexto = trim((string) ($filtros['busca_texto'] ?? ''));
        if ($buscaTexto !== '') {
            $like = '%'.mb_strtoupper($buscaTexto, 'UTF-8').'%';
            $query->where(function ($subQuery) use ($like) {
                $subQuery->whereRaw('UPPER(V.NOME) LIKE ?', [$like])
                    ->orWhereRaw("UPPER(NVL(V.DESCRICAO, '')) LIKE ?", [$like]);
            });
        }

        return $query;
    }

    private function aplicarOrdenacaoTarefasListagem(Builder $query, array $filtros): void
    {
        if (! empty($filtros['ordenar_prev_inicio'])) {
            $query->orderByRaw('CASE WHEN V.DATA_PREVISTA_INICIO IS NULL THEN 1 ELSE 0 END')
                ->orderBy('V.DATA_PREVISTA_INICIO')
                ->orderByDesc('V.ID');
        } else {
            $query->orderByDesc('V.ID');
        }
    }

    public function listarTarefasPaginadas(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId, int $perPage = 5): LengthAwarePaginator
    {
        $query = $this->montarQueryTarefasListagem($filtros, $macroprojetoId)
            ->selectRaw("
                V.ID,
                S.PROJETO_ID,
                P.NOME AS PROJETO_NOME,
                V.SUBPROJETO_ID,
                V.SUBPROJETO_NOME,
                V.UNIDADE_ID,
                V.UNIDADE_SIGLA,
                V.NOME,
                V.DESCRICAO,
                TO_CHAR(V.DT_CRIACAO, 'DD/MM/YYYY') AS DT_CRIACAO,
                TO_CHAR(V.DATA_PREVISTA_INICIO, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO,
                TO_CHAR(V.DATA_PREVISTA_FIM, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM,
                TO_CHAR(V.DATA_REAL_INICIO, 'DD/MM/YYYY') AS DATA_REAL_INICIO,
                TO_CHAR(V.DATA_REAL_FIM, 'DD/MM/YYYY') AS DATA_REAL_FIM,
                V.STATUS,
                TAR.OBSERVACAO,
                TAR.HORAS_EXTRAS,
                TAR.PESSOAS_ENVOLVIDAS,
                CAT.NOME AS CATEGORIA_NOME,
                TAR.NR_PROCESSO_SEI,
                FT.NOME AS FASE_NOME
            ");

        $this->aplicarOrdenacaoTarefasListagem($query, $filtros);
        $this->aplicarFiltroUnidades($query, $unidadesPermitidas);

        return $query->paginate($perPage)->withQueryString();
    }

    public function listarIdsTarefas(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): array
    {
        $query = $this->montarQueryTarefasListagem($filtros, $macroprojetoId)
            ->selectRaw('V.ID AS ID');

        $this->aplicarOrdenacaoTarefasListagem($query, $filtros);
        $this->aplicarFiltroUnidades($query, $unidadesPermitidas);

        return collect($query->get())
            ->map(function ($row) {
                if (is_object($row)) {
                    return (int) ($row->ID ?? $row->id ?? 0);
                }

                return (int) $row;
            })
            ->filter(fn (int $valor) => $valor > 0)
            ->values()
            ->all();
    }

    public function buscarProjetoPorNome(string $nome, int $macroprojetoId): ?object
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return null;
        }

        return DB::selectOne('
            SELECT ID
            FROM PROJETO
            WHERE NOME = :nome
              AND MACROPROJETO_ID = :macroprojeto_id
        ', [
            'nome' => $nome,
            'macroprojeto_id' => $macroId,
        ]);
    }

    public function buscarTarefasGantt(array $filtros, ?array $unidadesPermitidas, int $macroprojetoId): array
    {
        if (! ($filtros['aplicar'] ?? false)) {
            return [];
        }

        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        $condicoes = [];
        $bindings = [$macroId];
        $condicoes[] = 'P.MACROPROJETO_ID = ?';

        if (! empty($filtros['projetos'])) {
            $placeholders = implode(',', array_fill(0, count($filtros['projetos']), '?'));
            $condicoes[] = "S.PROJETO_ID IN ($placeholders)";
            $bindings = array_merge($bindings, $filtros['projetos']);
        }

        if (! empty($filtros['subprojetos'])) {
            $placeholders = implode(',', array_fill(0, count($filtros['subprojetos']), '?'));
            $condicoes[] = "V.SUBPROJETO_ID IN ($placeholders)";
            $bindings = array_merge($bindings, $filtros['subprojetos']);
        }

        if (! empty($filtros['categorias'])) {
            $placeholders = implode(',', array_fill(0, count($filtros['categorias']), '?'));
            $condicoes[] = "T.CATEGORIA_ID IN ($placeholders)";
            $bindings = array_merge($bindings, $filtros['categorias']);
        }

        if (! empty($filtros['fases'])) {
            $placeholders = implode(',', array_fill(0, count($filtros['fases']), '?'));
            $condicoes[] = "T.FASE_ID IN ($placeholders)";
            $bindings = array_merge($bindings, $filtros['fases']);
        }

        if (! empty($filtros['statuses'])) {
            $placeholders = implode(',', array_fill(0, count($filtros['statuses']), '?'));
            $condicoes[] = "V.STATUS IN ($placeholders)";
            $bindings = array_merge($bindings, $filtros['statuses']);
        }

        if (! empty($filtros['unidades'])) {
            $placeholders = implode(',', array_fill(0, count($filtros['unidades']), '?'));
            $condicoes[] = "V.UNIDADE_ID IN ($placeholders)";
            $bindings = array_merge($bindings, $filtros['unidades']);
        }

        if (! empty($filtros['busca_texto'])) {
            $condicoes[] = '(UPPER(T.DESCRICAO) LIKE ? OR UPPER(V.NOME) LIKE ?)';
            $like = '%'.mb_strtoupper((string) $filtros['busca_texto'], 'UTF-8').'%';
            $bindings[] = $like;
            $bindings[] = $like;
        }

        if (is_array($unidadesPermitidas)) {
            if (empty($unidadesPermitidas)) {
                $condicoes[] = '1 = 0';
            } else {
                $placeholders = implode(',', array_fill(0, count($unidadesPermitidas), '?'));
                $condicoes[] = "(V.UNIDADE_ID IN ($placeholders) OR S.UNIDADE_ID IN ($placeholders) OR P.UNIDADE_ID IN ($placeholders))";
                $bindings = array_merge($bindings, $unidadesPermitidas, $unidadesPermitidas, $unidadesPermitidas);
            }
        }

        if (empty($condicoes)) {
            return [];
        }

        $whereSql = 'WHERE '.implode(' AND ', $condicoes);
        $orderBySql = ! empty($filtros['ordenar_prev_inicio'])
            ? 'ORDER BY V.DATA_PREVISTA_INICIO NULLS LAST, V.ID'
            : 'ORDER BY V.ID DESC';

        return DB::select("
            SELECT
                V.ID,
                V.NOME,
                V.PROJETO_NOME,
                V.SUBPROJETO_NOME,
                V.UNIDADE_SIGLA,
                US.SIGLA AS SUBPROJETO_UNIDADE_SIGLA,
                TO_CHAR(V.DATA_PREVISTA_INICIO, 'YYYY-MM-DD') AS DATA_PREVISTA_INICIO,
                TO_CHAR(V.DATA_PREVISTA_FIM, 'YYYY-MM-DD') AS DATA_PREVISTA_FIM,
                TO_CHAR(V.DATA_REAL_INICIO, 'YYYY-MM-DD') AS DATA_REAL_INICIO,
                TO_CHAR(V.DATA_REAL_FIM, 'YYYY-MM-DD') AS DATA_REAL_FIM,
                V.STATUS,
                T.HORAS_EXTRAS AS HORAS_EXTRAS,
                T.PESSOAS_ENVOLVIDAS AS PESSOAS_ENVOLVIDAS,
                CAT.NOME AS CATEGORIA_NOME
            FROM VW_TAREFA_STATUS V
                 LEFT JOIN TAREFA T ON T.ID = V.ID
                 LEFT JOIN SUBPROJETO S ON S.ID = V.SUBPROJETO_ID
                 LEFT JOIN PROJETO P ON P.ID = S.PROJETO_ID
                 LEFT JOIN VW_UNIDADE US ON US.ID_UNIDADE = S.UNIDADE_ID
                 LEFT JOIN CATEGORIA_TAREFA CAT ON CAT.ID = T.CATEGORIA_ID
            $whereSql
            $orderBySql
        ", $bindings);
    }

    public function listarProjetosOrdenados(int $macroprojetoId): array
    {
        return $this->listarProjetos($macroprojetoId);
    }

    public function listarCategoriasGantt(): array
    {
        return DB::select("
            SELECT ID, NOME
            FROM CATEGORIA_TAREFA
            WHERE ATIVO = 'S'
            ORDER BY NOME
        ");
    }

    public function buscarTarefaFormulario(int $id, int $macroprojetoId): ?object
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return null;
        }

        return DB::selectOne("
            SELECT T.ID,
                   T.NOME,
                   T.DESCRICAO,
                   TO_CHAR(T.DATA_PREVISTA_INICIO, 'YYYY-MM-DD') AS DATA_PREVISTA_INICIO,
                   TO_CHAR(T.DATA_PREVISTA_FIM, 'YYYY-MM-DD') AS DATA_PREVISTA_FIM,
                   TO_CHAR(T.DATA_REAL_INICIO, 'YYYY-MM-DD') AS DATA_REAL_INICIO,
                   TO_CHAR(T.DATA_REAL_FIM, 'YYYY-MM-DD') AS DATA_REAL_FIM,
                   T.SUBPROJETO_ID,
                   S.PROJETO_ID,
                   S.NOME AS SUBPROJETO_NOME,
                   T.UNIDADE_ID,
                   U.SIGLA AS UNIDADE_SIGLA,
                   T.GRUPO_UNIDADE_ID,
                   T.LOTE_ID,
                   T.HORAS_EXTRAS,
                   T.PESSOAS_ENVOLVIDAS,
                   T.CATEGORIA_ID,
                   T.NR_PROCESSO_SEI,
                   T.FASE_ID
            FROM TAREFA T
                 LEFT JOIN SUBPROJETO S ON T.SUBPROJETO_ID = S.ID
                 LEFT JOIN PROJETO P ON S.PROJETO_ID = P.ID
                 LEFT JOIN VW_UNIDADE U ON T.UNIDADE_ID = U.ID_UNIDADE
            WHERE T.ID = :id
              AND P.MACROPROJETO_ID = :macroprojeto_id
        ", [
            'id' => $id,
            'macroprojeto_id' => $macroId,
        ]);
    }

    public function buscarTarefaSimples(int $id, int $macroprojetoId): ?object
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return null;
        }

        return DB::selectOne("
            SELECT T.ID,
                   T.NOME,
                   T.DESCRICAO,
                   TO_CHAR(T.DATA_REAL_INICIO, 'YYYY-MM-DD') AS DATA_REAL_INICIO,
                   TO_CHAR(T.DATA_REAL_FIM, 'YYYY-MM-DD') AS DATA_REAL_FIM,
                   T.OBSERVACAO
            FROM TAREFA T
                 INNER JOIN SUBPROJETO S ON S.ID = T.SUBPROJETO_ID
                 INNER JOIN PROJETO P ON P.ID = S.PROJETO_ID
            WHERE T.ID = :id
              AND P.MACROPROJETO_ID = :macroprojeto_id
        ", [
            'id' => $id,
            'macroprojeto_id' => $macroId,
        ]);
    }

    public function listarAndamentos(int $tarefaId): array
    {
        return DB::select("
            SELECT A.ID,
                   A.DESCRICAO,
                   A.TIPO,
                   A.USUARIO,
                   TO_CHAR(A.DATA_REGISTRO, 'DD/MM/YYYY HH24:MI') AS DATA_REGISTRO
            FROM TAREFA_ANDAMENTO A
            WHERE A.TAREFA_ID = :tarefa_id
            ORDER BY A.DATA_REGISTRO DESC, A.ID DESC
        ", ['tarefa_id' => $tarefaId]);
    }

    public function listarSolicitacoesAlteracaoPrazo(int $tarefaId): array
    {
        return DB::select("
            SELECT S.ID,
                   S.TAREFA_ID,
                   NVL(S.TIPO_SOLICITACAO, 'ALTERACAO') AS TIPO_SOLICITACAO,
                   TO_CHAR(S.DATA_PREVISTA_INICIO_ATUAL, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO_ATUAL,
                   TO_CHAR(S.DATA_PREVISTA_FIM_ATUAL, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM_ATUAL,
                   TO_CHAR(S.DATA_PREVISTA_INICIO_NOVA, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO_NOVA,
                   TO_CHAR(S.DATA_PREVISTA_FIM_NOVA, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM_NOVA,
                   NVL(S.UNIDADE_ID_ATUAL, T.UNIDADE_ID) AS UNIDADE_ID_ATUAL,
                   UA.SIGLA AS UNIDADE_SIGLA_ATUAL,
                   S.UNIDADE_ID_NOVA,
                   UN.SIGLA AS UNIDADE_SIGLA_NOVA,
                   S.NOME_ATUAL,
                   S.NOME_NOVO,
                   S.DESCRICAO_ATUAL,
                   S.DESCRICAO_NOVA,
                   S.JUSTIFICATIVA,
                   S.STATUS,
                   S.SOLICITANTE,
                   S.APROVADOR,
                   S.MOTIVO_DECISAO,
                   TO_CHAR(S.DATA_SOLICITACAO, 'DD/MM/YYYY HH24:MI') AS DATA_SOLICITACAO,
                   TO_CHAR(S.DATA_DECISAO, 'DD/MM/YYYY HH24:MI') AS DATA_DECISAO
            FROM TAREFA_SOLICITACAO_PRAZO S
                 INNER JOIN TAREFA T ON T.ID = S.TAREFA_ID
                 LEFT JOIN VW_UNIDADE UA ON UA.ID_UNIDADE = NVL(S.UNIDADE_ID_ATUAL, T.UNIDADE_ID)
                 LEFT JOIN VW_UNIDADE UN ON UN.ID_UNIDADE = S.UNIDADE_ID_NOVA
            WHERE S.TAREFA_ID = :tarefa_id
            ORDER BY S.DATA_SOLICITACAO DESC, S.ID DESC
        ", ['tarefa_id' => $tarefaId]);
    }

    private function novaQuerySolicitacoesAlteracaoPrazoPainel(int $macroId, array $filtros): Builder
    {
        $query = DB::table('TAREFA_SOLICITACAO_PRAZO as S')
            ->join('TAREFA as T', 'T.ID', '=', 'S.TAREFA_ID')
            ->join('SUBPROJETO as SP', 'SP.ID', '=', 'T.SUBPROJETO_ID')
            ->join('PROJETO as P', 'P.ID', '=', 'SP.PROJETO_ID')
            ->leftJoin('VW_UNIDADE as U', 'U.ID_UNIDADE', '=', 'T.UNIDADE_ID')
            ->leftJoin('VW_UNIDADE as UA', 'UA.ID_UNIDADE', '=', DB::raw('NVL(S.UNIDADE_ID_ATUAL, T.UNIDADE_ID)'))
            ->leftJoin('VW_UNIDADE as UN', 'UN.ID_UNIDADE', '=', 'S.UNIDADE_ID_NOVA')
            ->where('P.MACROPROJETO_ID', $macroId);

        $status = strtoupper(trim((string) ($filtros['status'] ?? '')));
        if (in_array($status, ['PENDENTE', 'APROVADA', 'REJEITADA'], true)) {
            $query->where('S.STATUS', $status);
        }

        $tipo = strtoupper(trim((string) ($filtros['tipo'] ?? '')));
        if (in_array($tipo, ['ALTERACAO', 'EXCLUSAO'], true)) {
            $query->whereRaw("NVL(S.TIPO_SOLICITACAO, 'ALTERACAO') = ?", [$tipo]);
        }

        $projetoId = (int) ($filtros['projeto_id'] ?? 0);
        if ($projetoId > 0) {
            $query->where('P.ID', $projetoId);
        }

        $unidadeId = (int) ($filtros['unidade_id'] ?? 0);
        if ($unidadeId > 0) {
            $query->where('T.UNIDADE_ID', $unidadeId);
        }

        $dataSolicitacaoDe = (string) ($filtros['data_solicitacao_de'] ?? '');
        if ($dataSolicitacaoDe !== '') {
            $query->whereRaw("TRUNC(S.DATA_SOLICITACAO) >= TO_DATE(?, 'YYYY-MM-DD')", [$dataSolicitacaoDe]);
        }

        $dataSolicitacaoAte = (string) ($filtros['data_solicitacao_ate'] ?? '');
        if ($dataSolicitacaoAte !== '') {
            $query->whereRaw("TRUNC(S.DATA_SOLICITACAO) <= TO_DATE(?, 'YYYY-MM-DD')", [$dataSolicitacaoAte]);
        }

        return $query;
    }

    public function listarSolicitacoesAlteracaoPrazoPainel(array $filtros, int $macroprojetoId, int $perPage = 20): LengthAwarePaginator
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return new \Illuminate\Pagination\LengthAwarePaginator([], 0, $perPage);
        }

        $query = $this->novaQuerySolicitacoesAlteracaoPrazoPainel($macroId, $filtros)
            ->selectRaw("
                S.ID,
                S.TAREFA_ID,
                NVL(S.TIPO_SOLICITACAO, 'ALTERACAO') AS TIPO_SOLICITACAO,
                T.NOME AS TAREFA_NOME,
                P.ID AS PROJETO_ID,
                P.NOME AS PROJETO_NOME,
                U.SIGLA AS UNIDADE_SIGLA,
                TO_CHAR(S.DATA_PREVISTA_INICIO_ATUAL, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO_ATUAL,
                TO_CHAR(S.DATA_PREVISTA_FIM_ATUAL, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM_ATUAL,
                TO_CHAR(S.DATA_PREVISTA_INICIO_NOVA, 'DD/MM/YYYY') AS DATA_PREVISTA_INICIO_NOVA,
                TO_CHAR(S.DATA_PREVISTA_FIM_NOVA, 'DD/MM/YYYY') AS DATA_PREVISTA_FIM_NOVA,
                NVL(S.UNIDADE_ID_ATUAL, T.UNIDADE_ID) AS UNIDADE_ID_ATUAL,
                UA.SIGLA AS UNIDADE_SIGLA_ATUAL,
                S.UNIDADE_ID_NOVA,
                UN.SIGLA AS UNIDADE_SIGLA_NOVA,
                S.NOME_ATUAL,
                S.NOME_NOVO,
                S.DESCRICAO_ATUAL,
                S.DESCRICAO_NOVA,
                S.JUSTIFICATIVA,
                S.STATUS,
                S.SOLICITANTE,
                S.APROVADOR,
                S.MOTIVO_DECISAO,
                TO_CHAR(S.DATA_SOLICITACAO, 'DD/MM/YYYY HH24:MI') AS DATA_SOLICITACAO,
                TO_CHAR(S.DATA_DECISAO, 'DD/MM/YYYY HH24:MI') AS DATA_DECISAO
            ")
            ->orderByRaw("
                CASE S.STATUS
                    WHEN 'PENDENTE' THEN 0
                    WHEN 'APROVADA' THEN 1
                    WHEN 'REJEITADA' THEN 2
                    ELSE 9
                END
            ")
            ->orderByDesc('S.DATA_SOLICITACAO')
            ->orderByDesc('S.ID');

        return $query->paginate($perPage)->withQueryString();
    }

    public function contarSolicitacoesAlteracaoPrazoPainelPorStatus(array $filtros, int $macroprojetoId): array
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        return $this->novaQuerySolicitacoesAlteracaoPrazoPainel($macroId, $filtros)
            ->selectRaw("UPPER(NVL(S.STATUS, 'PENDENTE')) AS STATUS, COUNT(*) AS TOTAL")
            ->groupByRaw("UPPER(NVL(S.STATUS, 'PENDENTE'))")
            ->get()
            ->mapWithKeys(fn ($item) => [(string) $item->status => (int) $item->total])
            ->all();
    }

    public function buscarAndamento(int $tarefaId, int $andamentoId): ?object
    {
        return DB::selectOne("
            SELECT A.ID,
                   A.DESCRICAO,
                   A.TIPO,
                   A.USUARIO,
                   TO_CHAR(A.DATA_REGISTRO, 'DD/MM/YYYY HH24:MI') AS DATA_REGISTRO
            FROM TAREFA_ANDAMENTO A
            WHERE A.TAREFA_ID = :tarefa_id
              AND A.ID = :id
        ", [
            'tarefa_id' => $tarefaId,
            'id' => $andamentoId,
        ]);
    }

    public function buscarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId): ?object
    {
        return DB::selectOne("
            SELECT S.ID,
                   S.TAREFA_ID,
                   NVL(S.TIPO_SOLICITACAO, 'ALTERACAO') AS TIPO_SOLICITACAO,
                   TO_CHAR(S.DATA_PREVISTA_INICIO_ATUAL, 'YYYY-MM-DD') AS DATA_PREVISTA_INICIO_ATUAL,
                   TO_CHAR(S.DATA_PREVISTA_FIM_ATUAL, 'YYYY-MM-DD') AS DATA_PREVISTA_FIM_ATUAL,
                   TO_CHAR(S.DATA_PREVISTA_INICIO_NOVA, 'YYYY-MM-DD') AS DATA_PREVISTA_INICIO_NOVA,
                   TO_CHAR(S.DATA_PREVISTA_FIM_NOVA, 'YYYY-MM-DD') AS DATA_PREVISTA_FIM_NOVA,
                   S.UNIDADE_ID_ATUAL,
                   S.UNIDADE_ID_NOVA,
                   S.NOME_ATUAL,
                   S.NOME_NOVO,
                   S.DESCRICAO_ATUAL,
                   S.DESCRICAO_NOVA,
                   S.JUSTIFICATIVA,
                   S.STATUS,
                   S.SOLICITANTE,
                   S.APROVADOR,
                   S.MOTIVO_DECISAO
            FROM TAREFA_SOLICITACAO_PRAZO S
            WHERE S.TAREFA_ID = :tarefa_id
              AND S.ID = :id
        ", [
            'tarefa_id' => $tarefaId,
            'id' => $solicitacaoId,
        ]);
    }

    public function inserirAndamento(int $tarefaId, string $descricao, string $tipo = 'ANDAMENTO', ?string $usuario = null): void
    {
        $sql = '
            INSERT INTO TAREFA_ANDAMENTO (
                TAREFA_ID,
                DESCRICAO,
                TIPO,
                USUARIO,
                DATA_REGISTRO
            ) VALUES (
                :tarefa_id,
                :descricao,
                :tipo,
                :usuario,
                SYSDATE
            )
        ';
        $bindings = [
            'tarefa_id' => $tarefaId,
            'descricao' => $descricao,
            'tipo' => $tipo,
            'usuario' => $usuario,
        ];
        $this->inserirSqlAuditado(
            'TAREFA_ANDAMENTO',
            'TAREFA_ANDAMENTO',
            null,
            $sql,
            $bindings,
            static fn ($query) => $query->where('TAREFA_ID', $tarefaId)
        );
    }

    public function inserirSolicitacaoAlteracaoPrazo(
        int $tarefaId,
        string $tipoSolicitacao,
        ?string $dataPrevistaInicio,
        ?string $dataPrevistaFim,
        ?int $unidadeIdNova,
        ?string $nomeNovo,
        ?string $descricaoNova,
        string $justificativa,
        ?string $solicitante
    ): void {
        $sql = "
            INSERT INTO TAREFA_SOLICITACAO_PRAZO (
                TAREFA_ID,
                TIPO_SOLICITACAO,
                DATA_PREVISTA_INICIO_ATUAL,
                DATA_PREVISTA_FIM_ATUAL,
                DATA_PREVISTA_INICIO_NOVA,
                DATA_PREVISTA_FIM_NOVA,
                UNIDADE_ID_ATUAL,
                UNIDADE_ID_NOVA,
                NOME_ATUAL,
                NOME_NOVO,
                DESCRICAO_ATUAL,
                DESCRICAO_NOVA,
                JUSTIFICATIVA,
                STATUS,
                SOLICITANTE,
                DATA_SOLICITACAO
            )
            SELECT
                T.ID,
                :tipo_solicitacao,
                T.DATA_PREVISTA_INICIO,
                T.DATA_PREVISTA_FIM,
                TO_DATE(:data_inicio_nova, 'YYYY-MM-DD'),
                TO_DATE(:data_fim_nova, 'YYYY-MM-DD'),
                T.UNIDADE_ID,
                :unidade_id_nova,
                SUBSTR(T.NOME, 1, 500),
                :nome_novo,
                SUBSTR(T.DESCRICAO, 1, 4000),
                :descricao_nova,
                :justificativa,
                'PENDENTE',
                :solicitante,
                SYSDATE
            FROM TAREFA T
            WHERE T.ID = :tarefa_id
        ";
        $bindings = [
            'tarefa_id' => $tarefaId,
            'tipo_solicitacao' => strtoupper(trim($tipoSolicitacao)),
            'data_inicio_nova' => $dataPrevistaInicio,
            'data_fim_nova' => $dataPrevistaFim,
            'unidade_id_nova' => $unidadeIdNova,
            'nome_novo' => $nomeNovo,
            'descricao_nova' => $descricaoNova,
            'justificativa' => $justificativa,
            'solicitante' => $solicitante,
        ];
        $this->inserirSqlAuditado(
            'TAREFA_SOLICITACAO_PRAZO',
            'TAREFA_SOLICITACAO_PRAZO',
            null,
            $sql,
            $bindings,
            static fn ($query) => $query->where('TAREFA_ID', $tarefaId)
        );
    }

    public function atualizarAndamento(int $tarefaId, int $andamentoId, string $descricao, string $tipo = 'ANDAMENTO'): void
    {
        $sql = '
            UPDATE TAREFA_ANDAMENTO
            SET DESCRICAO = :descricao,
                TIPO = :tipo,
                DATA_ATUALIZACAO = SYSDATE
            WHERE ID = :id
              AND TAREFA_ID = :tarefa_id
        ';
        $bindings = [
            'descricao' => $descricao,
            'tipo' => $tipo,
            'id' => $andamentoId,
            'tarefa_id' => $tarefaId,
        ];
        $this->atualizarSqlAuditado(
            'TAREFA_ANDAMENTO',
            'TAREFA_ANDAMENTO',
            $andamentoId,
            $sql,
            $bindings,
            static fn ($query) => $query->where('ID', $andamentoId)->where('TAREFA_ID', $tarefaId)
        );
    }

    public function aprovarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId, ?string $aprovador): void
    {
        DB::transaction(function () use ($tarefaId, $solicitacaoId, $aprovador) {
            $solicitacao = DB::selectOne("
                SELECT ID,
                       NVL(TIPO_SOLICITACAO, 'ALTERACAO') AS TIPO_SOLICITACAO,
                       TO_CHAR(DATA_PREVISTA_INICIO_NOVA, 'YYYY-MM-DD') AS DATA_PREVISTA_INICIO_NOVA,
                       TO_CHAR(DATA_PREVISTA_FIM_NOVA, 'YYYY-MM-DD') AS DATA_PREVISTA_FIM_NOVA,
                       UNIDADE_ID_NOVA,
                       NOME_NOVO,
                       DESCRICAO_NOVA
                FROM TAREFA_SOLICITACAO_PRAZO
                WHERE ID = :id
                  AND TAREFA_ID = :tarefa_id
                  AND STATUS = 'PENDENTE'
            ", [
                'id' => $solicitacaoId,
                'tarefa_id' => $tarefaId,
            ]);

            if (! $solicitacao) {
                return;
            }

            $tipoSolicitacao = strtoupper((string) ($solicitacao->tipo_solicitacao ?? 'ALTERACAO'));

            $sqlSolic = "
                UPDATE TAREFA_SOLICITACAO_PRAZO
                SET STATUS = 'APROVADA',
                    APROVADOR = :aprovador,
                    DATA_DECISAO = SYSDATE,
                    MOTIVO_DECISAO = NULL
                WHERE ID = :id
                  AND TAREFA_ID = :tarefa_id
                  AND STATUS = 'PENDENTE'
            ";
            $bindSolic = [
                'aprovador' => $aprovador,
                'id' => $solicitacaoId,
                'tarefa_id' => $tarefaId,
            ];
            $this->atualizarSqlAuditado(
                'TAREFA_SOLICITACAO_PRAZO',
                'TAREFA_SOLICITACAO_PRAZO',
                $solicitacaoId,
                $sqlSolic,
                $bindSolic,
                static fn ($query) => $query
                    ->where('ID', $solicitacaoId)
                    ->where('TAREFA_ID', $tarefaId)
                    ->where('STATUS', 'PENDENTE'),
                static fn ($query) => $query->where('ID', $solicitacaoId)
            );

            if ($tipoSolicitacao === 'EXCLUSAO') {
                $this->deletarTarefa($tarefaId);

                return;
            }

            $sqlTarefa = "
                UPDATE TAREFA
                SET DATA_PREVISTA_INICIO = NVL(TO_DATE(:data_inicio, 'YYYY-MM-DD'), DATA_PREVISTA_INICIO),
                    DATA_PREVISTA_FIM = NVL(TO_DATE(:data_fim, 'YYYY-MM-DD'), DATA_PREVISTA_FIM),
                    UNIDADE_ID = NVL(:unidade_id_nova, UNIDADE_ID),
                    NOME = NVL(:nome_novo, NOME),
                    DESCRICAO = NVL(:descricao_nova, DESCRICAO)
                WHERE ID = :id
            ";
            $bindTarefa = [
                'data_inicio' => $solicitacao->data_prevista_inicio_nova,
                'data_fim' => $solicitacao->data_prevista_fim_nova,
                'unidade_id_nova' => $solicitacao->unidade_id_nova,
                'nome_novo' => $solicitacao->nome_novo,
                'descricao_nova' => $solicitacao->descricao_nova,
                'id' => $tarefaId,
            ];
            $this->atualizarSqlAuditado(
                'TAREFA',
                'TAREFA',
                $tarefaId,
                $sqlTarefa,
                $bindTarefa,
                static fn ($query) => $query->where('ID', $tarefaId)
            );
        });
    }

    public function rejeitarSolicitacaoAlteracaoPrazo(int $tarefaId, int $solicitacaoId, string $motivo, ?string $aprovador): void
    {
        $sql = "
            UPDATE TAREFA_SOLICITACAO_PRAZO
            SET STATUS = 'REJEITADA',
                APROVADOR = :aprovador,
                MOTIVO_DECISAO = :motivo,
                DATA_DECISAO = SYSDATE
            WHERE ID = :id
              AND TAREFA_ID = :tarefa_id
              AND STATUS = 'PENDENTE'
        ";
        $bindings = [
            'aprovador' => $aprovador,
            'motivo' => $motivo,
            'id' => $solicitacaoId,
            'tarefa_id' => $tarefaId,
        ];
        $this->atualizarSqlAuditado(
            'TAREFA_SOLICITACAO_PRAZO',
            'TAREFA_SOLICITACAO_PRAZO',
            $solicitacaoId,
            $sql,
            $bindings,
            static fn ($query) => $query
                ->where('ID', $solicitacaoId)
                ->where('TAREFA_ID', $tarefaId)
                ->where('STATUS', 'PENDENTE'),
            static fn ($query) => $query->where('ID', $solicitacaoId)
        );
    }

    public function deletarAndamento(int $tarefaId, int $andamentoId): void
    {
        $sql = '
            DELETE FROM TAREFA_ANDAMENTO
            WHERE ID = :id
              AND TAREFA_ID = :tarefa_id
        ';
        $bindings = [
            'id' => $andamentoId,
            'tarefa_id' => $tarefaId,
        ];
        $this->removerSqlAuditado(
            'TAREFA_ANDAMENTO',
            'TAREFA_ANDAMENTO',
            $andamentoId,
            $sql,
            $bindings,
            static fn ($query) => $query->where('ID', $andamentoId)->where('TAREFA_ID', $tarefaId)
        );
    }

    public function atualizarInicioManual(int $id, ?string $data, ?string $observacao): void
    {
        $sql = "
            UPDATE TAREFA SET
                DATA_REAL_INICIO = TO_DATE(:dri, 'YYYY-MM-DD'),
                OBSERVACAO = :obs
            WHERE ID = :id
        ";
        $bindings = [
            'dri' => $data,
            'obs' => $observacao,
            'id' => $id,
        ];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function marcarInicioAgora(int $id): void
    {
        $sql = 'UPDATE TAREFA SET DATA_REAL_INICIO = SYSDATE WHERE ID = :id';
        $bindings = ['id' => $id];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function limparInicio(int $id): void
    {
        $sql = 'UPDATE TAREFA SET DATA_REAL_INICIO = NULL WHERE ID = :id';
        $bindings = ['id' => $id];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function marcarFimAgora(int $id): void
    {
        $this->validarConclusaoRequerInicio($id);

        $sql = 'UPDATE TAREFA SET DATA_REAL_FIM = SYSDATE WHERE ID = :id';
        $bindings = ['id' => $id];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function limparFim(int $id): void
    {
        $sql = 'UPDATE TAREFA SET DATA_REAL_FIM = NULL WHERE ID = :id';
        $bindings = ['id' => $id];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function atualizarFimManual(int $id, ?string $data, ?string $observacao): void
    {
        if ($data !== null) {
            $this->validarConclusaoRequerInicio($id);
        }

        $sql = "
            UPDATE TAREFA SET
                DATA_REAL_FIM = TO_DATE(:drf, 'YYYY-MM-DD'),
                OBSERVACAO = :obs
            WHERE ID = :id
        ";
        $bindings = [
            'drf' => $data,
            'obs' => $observacao,
            'id' => $id,
        ];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function buscarRegistroAtual(int $id, int $macroprojetoId): ?object
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return null;
        }

        return DB::selectOne("
            SELECT T.LOTE_ID, T.GRUPO_UNIDADE_ID, T.SUBPROJETO_ID, T.CATEGORIA_ID,
                   TO_CHAR(T.DATA_REAL_INICIO, 'YYYY-MM-DD') AS DATA_REAL_INICIO,
                   TO_CHAR(T.DATA_REAL_FIM, 'YYYY-MM-DD') AS DATA_REAL_FIM
            FROM TAREFA T
                 INNER JOIN SUBPROJETO S ON S.ID = T.SUBPROJETO_ID
                 INNER JOIN PROJETO P ON P.ID = S.PROJETO_ID
            WHERE T.ID = :id
              AND P.MACROPROJETO_ID = :macroprojeto_id
        ", [
            'id' => $id,
            'macroprojeto_id' => $macroId,
        ]);
    }

    public function atualizarPorLote(int $loteId, array $payload): int
    {
        $this->validarPayloadDatasReais($payload);

        $sql = "
            UPDATE TAREFA SET
                SUBPROJETO_ID = :subprojeto_id,
                NOME          = :nome,
                DESCRICAO     = :descricao,
                DATA_PREVISTA_INICIO = TO_DATE(:dpi, 'YYYY-MM-DD'),
                DATA_PREVISTA_FIM    = TO_DATE(:dpf, 'YYYY-MM-DD'),
                DATA_REAL_INICIO     = TO_DATE(:dri, 'YYYY-MM-DD'),
                DATA_REAL_FIM        = TO_DATE(:drf, 'YYYY-MM-DD'),
                GRUPO_UNIDADE_ID     = :grupo_unidade_id,
                HORAS_EXTRAS         = :horas_extras,
                PESSOAS_ENVOLVIDAS   = :pessoas_envolvidas,
                CATEGORIA_ID         = :categoria_id,
                FASE_ID              = :fase_id,
                NR_PROCESSO_SEI      = :nr_processo_sei
            WHERE LOTE_ID = :lote_id
        ";
        $bindings = $payload + ['lote_id' => $loteId];

        return $this->atualizarSqlAuditado(
            'TAREFA',
            'TAREFA',
            'LOTE:'.$loteId,
            $sql,
            $bindings,
            static fn ($query) => $query->where('LOTE_ID', $loteId)
        );
    }

    public function atualizarPorGrupo(int $grupoId, int $subprojetoId, array $payload): int
    {
        $this->validarPayloadDatasReais($payload);

        $sql = "
            UPDATE TAREFA SET
                SUBPROJETO_ID = :subprojeto_id,
                NOME          = :nome,
                DESCRICAO     = :descricao,
                DATA_PREVISTA_INICIO = TO_DATE(:dpi, 'YYYY-MM-DD'),
                DATA_PREVISTA_FIM    = TO_DATE(:dpf, 'YYYY-MM-DD'),
                DATA_REAL_INICIO     = TO_DATE(:dri, 'YYYY-MM-DD'),
                DATA_REAL_FIM        = TO_DATE(:drf, 'YYYY-MM-DD'),
                GRUPO_UNIDADE_ID     = :grupo_unidade_id,
                HORAS_EXTRAS         = :horas_extras,
                PESSOAS_ENVOLVIDAS   = :pessoas_envolvidas,
                CATEGORIA_ID         = :categoria_id,
                FASE_ID              = :fase_id,
                NR_PROCESSO_SEI      = :nr_processo_sei
            WHERE GRUPO_UNIDADE_ID = :grupo_original
              AND SUBPROJETO_ID = :subprojeto_original
        ";
        $bindings = $payload + ['grupo_original' => $grupoId, 'subprojeto_original' => $subprojetoId];
        $subprojetoDepois = $payload['subprojeto_id'] ?? $subprojetoId;

        return $this->atualizarSqlAuditado(
            'TAREFA',
            'TAREFA',
            'GRUPO:'.$grupoId,
            $sql,
            $bindings,
            static fn ($query) => $query
                ->where('GRUPO_UNIDADE_ID', $grupoId)
                ->where('SUBPROJETO_ID', $subprojetoId),
            static fn ($query) => $query
                ->where('GRUPO_UNIDADE_ID', $grupoId)
                ->where('SUBPROJETO_ID', $subprojetoDepois)
        );
    }

    public function atualizarTarefa(int $id, array $payload): void
    {
        $this->validarPayloadDatasReais($payload);

        $sql = "
            UPDATE TAREFA SET
                SUBPROJETO_ID = :subprojeto_id,
                UNIDADE_ID    = :unidade_id,
                NOME          = :nome,
                DESCRICAO     = :descricao,
                DATA_PREVISTA_INICIO = TO_DATE(:dpi, 'YYYY-MM-DD'),
                DATA_PREVISTA_FIM    = TO_DATE(:dpf, 'YYYY-MM-DD'),
                DATA_REAL_INICIO     = TO_DATE(:dri, 'YYYY-MM-DD'),
                DATA_REAL_FIM        = TO_DATE(:drf, 'YYYY-MM-DD'),
                GRUPO_UNIDADE_ID     = :grupo_unidade_id,
                HORAS_EXTRAS         = :horas_extras,
                PESSOAS_ENVOLVIDAS   = :pessoas_envolvidas,
                CATEGORIA_ID         = :categoria_id,
                FASE_ID              = :fase_id,
                NR_PROCESSO_SEI      = :nr_processo_sei
            WHERE ID = :id
        ";
        $bindings = $payload + ['id' => $id];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function atualizarCamposRestritos(int $id, ?string $nrProcessoSei, ?string $dataRealInicio, ?string $dataRealFim, ?int $faseId): void
    {
        if ($dataRealFim !== null && $dataRealInicio === null) {
            throw new \RuntimeException('Informe a data real de início antes de preencher a data real de término.');
        }

        $sql = "
            UPDATE TAREFA SET
                NR_PROCESSO_SEI = :nr_processo_sei,
                DATA_REAL_INICIO = TO_DATE(:data_real_inicio, 'YYYY-MM-DD'),
                DATA_REAL_FIM = TO_DATE(:data_real_fim, 'YYYY-MM-DD'),
                FASE_ID = :fase_id
            WHERE ID = :id
        ";
        $bindings = [
            'nr_processo_sei' => $nrProcessoSei,
            'data_real_inicio' => $dataRealInicio,
            'data_real_fim' => $dataRealFim,
            'fase_id' => $faseId,
            'id' => $id,
        ];
        $this->atualizarSqlAuditado('TAREFA', 'TAREFA', $id, $sql, $bindings, static fn ($query) => $query->where('ID', $id));
    }

    public function buscarUnidadeDaTarefa(int $id, int $macroprojetoId): ?int
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return null;
        }

        $valor = DB::table('TAREFA as T')
            ->join('SUBPROJETO as S', 'S.ID', '=', 'T.SUBPROJETO_ID')
            ->join('PROJETO as P', 'P.ID', '=', 'S.PROJETO_ID')
            ->where('T.ID', $id)
            ->where('P.MACROPROJETO_ID', $macroId)
            ->value('T.UNIDADE_ID');

        return $valor !== null ? (int) $valor : null;
    }

    public function buscarEscopoUnidadesDaTarefa(int $id, int $macroprojetoId): ?object
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return null;
        }

        return DB::selectOne('
            SELECT
                T.UNIDADE_ID AS TAREFA_UNIDADE_ID,
                S.UNIDADE_ID AS SUBPROJETO_UNIDADE_ID,
                P.UNIDADE_ID AS PROJETO_UNIDADE_ID
            FROM TAREFA T
                 INNER JOIN SUBPROJETO S ON S.ID = T.SUBPROJETO_ID
                 INNER JOIN PROJETO P ON P.ID = S.PROJETO_ID
            WHERE T.ID = :id
              AND P.MACROPROJETO_ID = :macroprojeto_id
        ', [
            'id' => $id,
            'macroprojeto_id' => $macroId,
        ]);
    }

    private function validarPayloadDatasReais(array $payload): void
    {
        $dataRealInicio = $payload['dri'] ?? null;
        $dataRealFim = $payload['drf'] ?? null;

        if ($dataRealFim !== null && $dataRealInicio === null) {
            throw new \RuntimeException('Informe a data real de início antes de preencher a data real de término.');
        }
    }

    private function validarConclusaoRequerInicio(int $id): void
    {
        $registro = DB::table('TAREFA')
            ->select('DATA_REAL_INICIO')
            ->where('ID', $id)
            ->first();

        if (! $registro || empty($registro->data_real_inicio)) {
            throw new \RuntimeException('A tarefa precisa ter data real de início antes de ser concluída.');
        }
    }

    public function listarUnidadesPorGrupo(int $grupoId): Collection
    {
        return DB::table('GRUPO_UNIDADE_MEMBRO')
            ->where('GRUPO_ID', $grupoId)
            ->selectRaw('UNIDADE_ID AS unidade_id')
            ->pluck('unidade_id');
    }

    public function criarLote(): int
    {
        $registro = [
            'LOTE_UUID' => (string) Str::uuid(),
        ];

        return (int) $this->inserirAuditado('TAREFA_LOTE', 'TAREFA_LOTE', $registro, 'ID');
    }

    public function inserirTarefa(array $dados): void
    {
        $sql = "
            INSERT INTO TAREFA (
                SUBPROJETO_ID, UNIDADE_ID, NOME, DESCRICAO, DT_CRIACAO,
                DATA_PREVISTA_INICIO, DATA_PREVISTA_FIM, DATA_REAL_INICIO, DATA_REAL_FIM,
                GRUPO_UNIDADE_ID, LOTE_ID, HORAS_EXTRAS, PESSOAS_ENVOLVIDAS, CATEGORIA_ID, FASE_ID, NR_PROCESSO_SEI
            ) VALUES (
                :subprojeto_id, :unidade_id, :nome, :descricao, SYSDATE,
                TO_DATE(:dpi, 'YYYY-MM-DD'),
                TO_DATE(:dpf, 'YYYY-MM-DD'),
                TO_DATE(:dri, 'YYYY-MM-DD'),
                TO_DATE(:drf, 'YYYY-MM-DD'),
                :grupo_unidade_id,
                :lote_id,
                :horas_extras,
                :pessoas_envolvidas,
                :categoria_id,
                :fase_id,
                :nr_processo_sei
            )
        ";
        $subprojetoId = $dados['subprojeto_id'] ?? null;
        $unidadeId = $dados['unidade_id'] ?? null;
        $nome = $dados['nome'] ?? null;
        $this->inserirSqlAuditado(
            'TAREFA',
            'TAREFA',
            null,
            $sql,
            $dados,
            static fn ($query) => $query
                ->where('SUBPROJETO_ID', $subprojetoId)
                ->where('UNIDADE_ID', $unidadeId)
                ->where('NOME', $nome)
        );
    }

    public function deletarTarefa(int $id): void
    {
        $this->removerAuditadoPorId('TAREFA', 'TAREFA', 'ID', $id);
    }

    public function criarTarefasParaUnidades(array $dadosBase, Collection $unidades, ?int $grupoId): void
    {
        DB::transaction(function () use ($dadosBase, $unidades, $grupoId) {
            $loteId = null;
            if ($unidades->count() > 1 || $grupoId) {
                $loteId = $this->criarLote();
            }

            foreach ($unidades as $unidadeId) {
                $this->inserirTarefa(array_merge($dadosBase, [
                    'unidade_id' => $unidadeId,
                    'grupo_unidade_id' => $grupoId,
                    'lote_id' => $loteId,
                ]));
            }
        });
    }

    public function buscarSubprojetosAjax(string $termo, array $projetos, ?int $projetoId, int $macroprojetoId): array
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        $bindings = [$termo, $macroId];
        $filtros = [];

        if (! empty($projetos)) {
            $placeholders = implode(',', array_fill(0, count($projetos), '?'));
            $filtros[] = "S.PROJETO_ID IN ($placeholders)";
            $bindings = array_merge($bindings, $projetos);
        } elseif ($projetoId) {
            $filtros[] = 'S.PROJETO_ID = ?';
            $bindings[] = $projetoId;
        }

        $whereExtra = $filtros ? ' AND '.implode(' AND ', $filtros) : '';

        return DB::select("
            SELECT S.ID AS id, S.NOME AS text
            FROM SUBPROJETO S
                 INNER JOIN PROJETO P ON P.ID = S.PROJETO_ID
            WHERE (UPPER(S.NOME) LIKE '%' || ? || '%')
              AND P.MACROPROJETO_ID = ?
              $whereExtra
            ORDER BY S.NOME
        ", $bindings);
    }

    public function buscarProjetosAjax(string $termo, int $macroprojetoId): array
    {
        $macroId = $macroprojetoId;
        if ($macroId <= 0) {
            return [];
        }

        return DB::select("
            SELECT ID AS id,
                   NOME AS text
            FROM PROJETO
            WHERE UPPER(NOME) LIKE '%' || :termo || '%'
              AND MACROPROJETO_ID = :macroprojeto_id
            ORDER BY NOME
        ", [
            'termo' => $termo,
            'macroprojeto_id' => $macroId,
        ]);
    }

    public function buscarUnidadesAjax(string $termo): array
    {
        return DB::select("
            SELECT ID_UNIDADE AS id,
                   SIGLA || ' - ' || DESCRICAO AS text
            FROM VW_UNIDADE
            WHERE UPPER(SIGLA) LIKE '%' || :termo || '%'
               OR UPPER(DESCRICAO) LIKE '%' || :termo || '%'
            ORDER BY SIGLA
        ", ['termo' => $termo]);
    }
}
```
</APP_REPOSITORIES_TAREFAS_TAREFAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Tarefas/TarefaAlertaDuplicidadeService.php`
## <APP_SERVICES_TAREFAS_TAREFAALERTADUPLICIDADESERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Tarefas/TarefaAlertaDuplicidadeService.php`
- **Namespace Declaração:** `App\Services\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaDuplicidadeService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function validar(array $dados, array $escopo, ?int $excluirId = null): void
private function assinatura(array $configuracao, array $escopo): array
private function datasDaConfiguracao(array $configuracao): array
private function emailsDosDestinatarios(Collection $tarefas, array $tipos): array
private function decodificarArray(mixed $valor): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Tarefas;

use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaRepository;
use App\Support\Tarefas\TarefaAlertaRecorrenciaTipo;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use RuntimeException;

class TarefaAlertaDuplicidadeService
{
    public function __construct(
        private readonly TarefaAlertaAgendamentoRepository $agendamentoRepo,
        private readonly TarefaAlertaRepository $tarefaRepo,
        private readonly TarefaAlertaRecorrenciaService $recorrencia,
    ) {}

    public function validar(array $dados, array $escopo, ?int $excluirId = null): void
    {
        $macroprojetoId = (int) ($dados['macroprojeto_id'] ?? 0);
        $datasCandidatas = $this->datasDaConfiguracao($dados);
        $assinaturaCandidata = $this->assinatura($dados, $escopo);

        foreach ($this->agendamentoRepo->buscarAtivosDoMacro($macroprojetoId, $excluirId) as $existente) {
            if (array_intersect($datasCandidatas, $this->datasDaConfiguracao((array) $existente)) === []) {
                continue;
            }

            $escopoExistente = json_decode($existente->escopo_json ?? '{}', true) ?? [];
            if ($assinaturaCandidata === $this->assinatura((array) $existente, $escopoExistente)) {
                throw new RuntimeException(
                    'Já existe agendamento ativo que enviará as mesmas tarefas aos mesmos destinatários na mesma data.'
                );
            }
        }
    }

    private function assinatura(array $configuracao, array $escopo): array
    {
        $filtros = $this->decodificarArray($configuracao['filtros_json'] ?? []);
        $tipos = $this->decodificarArray($configuracao['tipos_destinatario_json'] ?? []);
        $macroprojetoId = (int) ($escopo['macroprojeto_id'] ?? $configuracao['macroprojeto_id'] ?? 0);
        $unidades = $escopo['unidades_permitidas_ids'] ?? null;
        $tarefas = $this->tarefaRepo->buscarTarefas($filtros, is_array($unidades) ? $unidades : null, $macroprojetoId);

        $ids = $tarefas->pluck('id')->map('intval')->unique()->sort()->values()->all();
        $emails = $this->emailsDosDestinatarios($tarefas, $tipos);

        return ['tarefas' => $ids, 'destinatarios' => $emails];
    }

    private function datasDaConfiguracao(array $configuracao): array
    {
        $dataHora = $configuracao['data_hora_agendado'] ?? $configuracao['data_hora_envio_agendado'] ?? null;
        if ($dataHora === null) {
            throw new RuntimeException('Configuração de agendamento sem data e hora.');
        }
        $base = Carbon::parse($dataHora, $this->recorrencia->timezone());
        if (empty($configuracao['recorrente'])) {
            return [$base->toDateString()];
        }

        $fim = Carbon::parse($configuracao['data_final'], $this->recorrencia->timezone());
        $dia = (int) ($configuracao['recorrencia_dia'] ?? 0);
        $ocorrencias = match ($configuracao['recorrencia_tipo'] ?? null) {
            TarefaAlertaRecorrenciaTipo::SEMANAL => $this->recorrencia->gerarOcorrenciasSemanal($base, $dia, $fim),
            TarefaAlertaRecorrenciaTipo::MENSAL => $this->recorrencia->gerarOcorrenciasMensal($base, $dia, $fim),
            default => [],
        };

        return array_values(array_unique(array_map(
            static fn (Carbon $data): string => $data->toDateString(),
            $ocorrencias
        )));
    }

    private function emailsDosDestinatarios(Collection $tarefas, array $tipos): array
    {
        $campos = array_filter([
            in_array('unidade_tarefa', $tipos, true) ? 'unidade_tarefa' : null,
            in_array('unidade_subprojeto', $tipos, true) ? 'unidade_subprojeto' : null,
            in_array('unidade_projeto', $tipos, true) ? 'unidade_projeto' : null,
        ]);
        $emails = [];

        foreach ($tarefas as $tarefa) {
            foreach ($campos as $campo) {
                $email = strtolower(trim((string) ($tarefa[$campo]['email'] ?? '')));
                if ($email !== '') {
                    $emails[$email] = true;
                }
            }
        }

        $resultado = array_keys($emails);
        sort($resultado);
        return $resultado;
    }

    private function decodificarArray(mixed $valor): array
    {
        if (is_array($valor)) {
            return $valor;
        }

        return json_decode((string) $valor, true) ?: [];
    }
}
```
</APP_SERVICES_TAREFAS_TAREFAALERTADUPLICIDADESERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Tarefas/TarefaAlertaRecorrenciaService.php`
## <APP_SERVICES_TAREFAS_TAREFAALERTARECORRENCIASERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Tarefas/TarefaAlertaRecorrenciaService.php`
- **Namespace Declaração:** `App\Services\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaRecorrenciaService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function timezone(): string
public function eDataHoraFutura(Carbon $dataHora): bool
public function primeiraOcorrenciaSemanal(Carbon $base, int $diaSemana): Carbon
public function proximaOcorrenciaSemanal(Carbon $atual): Carbon
public function gerarOcorrenciasSemanal(Carbon $base, int $diaSemana, Carbon $dataFinal): array
public function primeiraOcorrenciaMensal(Carbon $base, int $dia): Carbon
public function proximaOcorrenciaMensal(Carbon $atual, int $dia): Carbon
public function gerarOcorrenciasMensal(Carbon $base, int $dia, Carbon $dataFinal): array
private function ajustarDiaMensal(int $ano, int $mes, int $dia, string $hora): Carbon
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Tarefas;

use Carbon\Carbon;
use InvalidArgumentException;

class TarefaAlertaRecorrenciaService
{
    public function timezone(): string
    {
        return 'America/Rio_Branco';
    }

    public function eDataHoraFutura(Carbon $dataHora): bool
    {
        return $dataHora->gt(Carbon::now($this->timezone()));
    }

    // ─── Semanal ─────────────────────────────────────────────────────────────

    /**
     * Retorna a primeira ocorrência futura ou a própria data se o dia da semana coincide.
     * $diaSemana: 0=domingo … 6=sábado (Carbon::dayOfWeek)
     */
    public function primeiraOcorrenciaSemanal(Carbon $base, int $diaSemana): Carbon
    {
        $data = $base->copy()->setTimezone($this->timezone());
        $diff = ($diaSemana - $data->dayOfWeek + 7) % 7;
        return $data->addDays($diff);
    }

    public function proximaOcorrenciaSemanal(Carbon $atual): Carbon
    {
        return $atual->copy()->addWeek();
    }

    /**
     * @return Carbon[]
     */
    public function gerarOcorrenciasSemanal(Carbon $base, int $diaSemana, Carbon $dataFinal): array
    {
        $primeira = $this->primeiraOcorrenciaSemanal($base, $diaSemana);
        $fim = Carbon::parse($dataFinal->toDateString(), $this->timezone())
            ->setTime(23, 59, 59);

        if ($primeira->gt($fim)) {
            throw new InvalidArgumentException(
                'A data final é anterior à primeira ocorrência ajustada.'
            );
        }

        $ocorrencias = [];
        $atual = $primeira->copy();

        while ($atual->lte($fim)) {
            $ocorrencias[] = $atual->copy();
            $atual = $this->proximaOcorrenciaSemanal($atual);
        }

        return $ocorrencias;
    }

    // ─── Mensal ──────────────────────────────────────────────────────────────

    /**
     * Retorna a primeira ocorrência no mês atual (ou seguinte) para o dia configurado.
     * Para dias 29/30/31, usa o último dia do mês quando o mês não possui aquele dia.
     */
    public function primeiraOcorrenciaMensal(Carbon $base, int $dia): Carbon
    {
        $data = $base->copy()->setTimezone($this->timezone());

        $candidata = $this->ajustarDiaMensal($data->year, $data->month, $dia, $data->format('H:i:s'));

        if ($candidata->gte($data->copy()->startOfDay())) {
            return $candidata;
        }

        $proximo = $data->copy()->addMonthNoOverflow()->startOfMonth();
        return $this->ajustarDiaMensal($proximo->year, $proximo->month, $dia, $data->format('H:i:s'));
    }

    public function proximaOcorrenciaMensal(Carbon $atual, int $dia): Carbon
    {
        $proximo = $atual->copy()->addMonthNoOverflow()->startOfMonth();
        return $this->ajustarDiaMensal($proximo->year, $proximo->month, $dia, $atual->format('H:i:s'));
    }

    /**
     * @return Carbon[]
     */
    public function gerarOcorrenciasMensal(Carbon $base, int $dia, Carbon $dataFinal): array
    {
        $primeira = $this->primeiraOcorrenciaMensal($base, $dia);
        $fim = Carbon::parse($dataFinal->toDateString(), $this->timezone())
            ->setTime(23, 59, 59);

        if ($primeira->gt($fim)) {
            throw new InvalidArgumentException(
                'A data final é anterior à primeira ocorrência ajustada.'
            );
        }

        $ocorrencias = [];
        $atual = $primeira->copy();

        while ($atual->lte($fim)) {
            $ocorrencias[] = $atual->copy();
            $atual = $this->proximaOcorrenciaMensal($atual, $dia);
        }

        return $ocorrencias;
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private function ajustarDiaMensal(int $ano, int $mes, int $dia, string $hora): Carbon
    {
        $ultimoDia = Carbon::create($ano, $mes, 1, 0, 0, 0, $this->timezone())->daysInMonth;
        $diaEfetivo = min($dia, $ultimoDia);
        [$h, $m, $s] = array_map('intval', explode(':', $hora));
        return Carbon::create($ano, $mes, $diaEfetivo, $h, $m, $s, $this->timezone());
    }
}
```
</APP_SERVICES_TAREFAS_TAREFAALERTARECORRENCIASERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Tarefas/TarefaAlertaExecucaoStatus.php`
## <APP_SUPPORT_TAREFAS_TAREFAALERTAEXECUCAOSTATUS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Tarefas/TarefaAlertaExecucaoStatus.php`
- **Namespace Declaração:** `App\Support\Tarefas`
- **Entidade / Classe:** `final class TarefaAlertaExecucaoStatus`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function label(string $status): string
public static function podeReprocessar(string $status): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Tarefas;

final class TarefaAlertaExecucaoStatus
{
    public const PENDENTE     = 'pendente';
    public const PROCESSANDO  = 'processando';
    public const CONCLUIDA    = 'concluida';
    public const PARCIAL      = 'parcial';
    public const FALHA        = 'falha';

    public const TODOS = [
        self::PENDENTE,
        self::PROCESSANDO,
        self::CONCLUIDA,
        self::PARCIAL,
        self::FALHA,
    ];

    public const LABELS = [
        self::PENDENTE    => 'Pendente',
        self::PROCESSANDO => 'Processando',
        self::CONCLUIDA   => 'Concluída',
        self::PARCIAL     => 'Parcial',
        self::FALHA       => 'Falha',
    ];

    public static function label(string $status): string
    {
        return self::LABELS[$status] ?? $status;
    }

    public static function podeReprocessar(string $status): bool
    {
        return in_array($status, [self::PARCIAL, self::FALHA], true);
    }
}
```
</APP_SUPPORT_TAREFAS_TAREFAALERTAEXECUCAOSTATUS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Tarefas/TarefaAlertaRecorrenciaTipo.php`
## <APP_SUPPORT_TAREFAS_TAREFAALERTARECORRENCIATIPO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Tarefas/TarefaAlertaRecorrenciaTipo.php`
- **Namespace Declaração:** `App\Support\Tarefas`
- **Entidade / Classe:** `final class TarefaAlertaRecorrenciaTipo`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function label(string $tipo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Tarefas;

final class TarefaAlertaRecorrenciaTipo
{
    public const SEMANAL = 'semanal';
    public const MENSAL  = 'mensal';

    public const TODOS = [self::SEMANAL, self::MENSAL];

    public const LABELS = [
        self::SEMANAL => 'Semanal',
        self::MENSAL  => 'Mensal',
    ];

    public const DIAS_SEMANA = [
        0 => 'Domingo',
        1 => 'Segunda-feira',
        2 => 'Terça-feira',
        3 => 'Quarta-feira',
        4 => 'Quinta-feira',
        5 => 'Sexta-feira',
        6 => 'Sábado',
    ];

    public static function label(string $tipo): string
    {
        return self::LABELS[$tipo] ?? $tipo;
    }
}
```
</APP_SUPPORT_TAREFAS_TAREFAALERTARECORRENCIATIPO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Tarefas/TarefaStatus.php`
## <APP_SUPPORT_TAREFAS_TAREFASTATUS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Tarefas/TarefaStatus.php`
- **Namespace Declaração:** `App\Support\Tarefas`
- **Entidade / Classe:** `final class TarefaStatus`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Tarefas;

final class TarefaStatus
{
    public const OPCOES = [
        'A INICIAR',
        'EM ANDAMENTO (NO PRAZO)',
        'EM ANDAMENTO (ATRASADA)',
        'ATRASADA',
        'CONCLUÍDA',
        'EM ESPERA (CONTINGÊNCIA)',
    ];

    public const ALERTA_PADRAO = [
        'ATRASADA',
        'EM ANDAMENTO (ATRASADA)',
    ];
}
```
</APP_SUPPORT_TAREFAS_TAREFASTATUS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_02_12_100000_create_tarefa_andamento_table.php`
## <DATABASE_MIGRATIONS_2026_02_12_100000_CREATE_TAREFA_ANDAMENTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_02_12_100000_create_tarefa_andamento_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_andamento (
    id               NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tarefa_id        NUMBER           NOT NULL REFERENCES tarefa (id) ON DELETE CASCADE,
    descricao        VARCHAR2(2000)   NOT NULL,
    tipo             VARCHAR2(30)     DEFAULT 'ANDAMENTO' NOT NULL,
    usuario          VARCHAR2(120),
    data_registro    DATE             DEFAULT SYSDATE NOT NULL,
    data_atualizacao DATE
)
SQL
        );

        DB::statement("CREATE INDEX idx_tarefa_andamento_tarefa ON tarefa_andamento (tarefa_id)");
        DB::statement("CREATE INDEX idx_tarefa_andamento_data ON tarefa_andamento (data_registro)");
    }

    public function down(): void
    {
        DB::statement("DROP TABLE tarefa_andamento");
    }
};
```
</DATABASE_MIGRATIONS_2026_02_12_100000_CREATE_TAREFA_ANDAMENTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_02_13_140000_create_tarefa_solicitacao_prazo_table.php`
## <DATABASE_MIGRATIONS_2026_02_13_140000_CREATE_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_02_13_140000_create_tarefa_solicitacao_prazo_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_solicitacao_prazo (
    id                         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tarefa_id                   NUMBER           NOT NULL REFERENCES tarefa (id) ON DELETE CASCADE,
    data_prevista_inicio_atual  DATE,
    data_prevista_fim_atual     DATE,
    data_prevista_inicio_nova   DATE,
    data_prevista_fim_nova      DATE,
    justificativa               VARCHAR2(2000)   NOT NULL,
    status                      VARCHAR2(20)     DEFAULT 'PENDENTE' NOT NULL,
    solicitante                 VARCHAR2(120),
    aprovador                   VARCHAR2(120),
    motivo_decisao              VARCHAR2(1000),
    data_solicitacao            DATE             DEFAULT SYSDATE NOT NULL,
    data_decisao                DATE,
    CONSTRAINT chk_tarefa_solic_prazo_status CHECK (status IN ('PENDENTE', 'APROVADA', 'REJEITADA')),
    CONSTRAINT chk_tarefa_solic_prazo_datas CHECK (
        data_prevista_fim_nova IS NULL
        OR data_prevista_inicio_nova IS NULL
        OR data_prevista_fim_nova >= data_prevista_inicio_nova
    )
)
SQL
        );

        DB::statement('CREATE INDEX idx_tarefa_sol_prazo_tarefa ON tarefa_solicitacao_prazo (tarefa_id)');
        DB::statement('CREATE INDEX idx_tarefa_sol_prazo_status ON tarefa_solicitacao_prazo (status)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_solicitacao_prazo');
    }
};
```
</DATABASE_MIGRATIONS_2026_02_13_140000_CREATE_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_02_23_120000_add_unidade_to_tarefa_solicitacao_prazo_table.php`
## <DATABASE_MIGRATIONS_2026_02_23_120000_ADD_UNIDADE_TO_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_02_23_120000_add_unidade_to_tarefa_solicitacao_prazo_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo ADD (unidade_id_atual NUMBER, unidade_id_nova NUMBER)');
        DB::statement('CREATE INDEX idx_tarefa_sol_prazo_unid_nova ON tarefa_solicitacao_prazo (unidade_id_nova)');

        // Preserva o histórico atual vinculando a unidade da tarefa na data da migração.
        DB::statement("
            UPDATE tarefa_solicitacao_prazo s
               SET s.unidade_id_atual = (
                   SELECT t.unidade_id
                     FROM tarefa t
                    WHERE t.id = s.tarefa_id
               )
             WHERE s.unidade_id_atual IS NULL
        ");
    }

    public function down(): void
    {
        DB::statement('DROP INDEX idx_tarefa_sol_prazo_unid_nova');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN unidade_id_nova');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN unidade_id_atual');
    }
};
```
</DATABASE_MIGRATIONS_2026_02_23_120000_ADD_UNIDADE_TO_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_03_22_120000_add_texto_to_tarefa_solicitacao_prazo_table.php`
## <DATABASE_MIGRATIONS_2026_03_22_120000_ADD_TEXTO_TO_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_03_22_120000_add_texto_to_tarefa_solicitacao_prazo_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo ADD (nome_atual VARCHAR2(500), nome_novo VARCHAR2(500), descricao_atual VARCHAR2(4000), descricao_nova VARCHAR2(4000))');

        DB::statement("\n            UPDATE tarefa_solicitacao_prazo s\n               SET s.nome_atual = (\n                       SELECT SUBSTR(t.nome, 1, 500)\n                         FROM tarefa t\n                        WHERE t.id = s.tarefa_id\n                   ),\n                   s.descricao_atual = (\n                       SELECT SUBSTR(t.descricao, 1, 4000)\n                         FROM tarefa t\n                        WHERE t.id = s.tarefa_id\n                   )\n             WHERE s.nome_atual IS NULL\n                OR s.descricao_atual IS NULL\n        ");
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN descricao_nova');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN descricao_atual');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN nome_novo');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN nome_atual');
    }
};
```
</DATABASE_MIGRATIONS_2026_03_22_120000_ADD_TEXTO_TO_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_03_22_130000_add_tipo_to_tarefa_solicitacao_prazo_table.php`
## <DATABASE_MIGRATIONS_2026_03_22_130000_ADD_TIPO_TO_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_03_22_130000_add_tipo_to_tarefa_solicitacao_prazo_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement("ALTER TABLE tarefa_solicitacao_prazo ADD (tipo_solicitacao VARCHAR2(20) DEFAULT 'ALTERACAO' NOT NULL)");
        DB::statement("ALTER TABLE tarefa_solicitacao_prazo ADD CONSTRAINT chk_tarefa_sol_tipo CHECK (tipo_solicitacao IN ('ALTERACAO', 'EXCLUSAO'))");
        DB::statement("CREATE INDEX idx_tarefa_sol_prazo_tipo ON tarefa_solicitacao_prazo (tipo_solicitacao)");

        DB::statement("\n            UPDATE tarefa_solicitacao_prazo\n               SET tipo_solicitacao = 'ALTERACAO'\n             WHERE tipo_solicitacao IS NULL\n        ");
    }

    public function down(): void
    {
        DB::statement('DROP INDEX idx_tarefa_sol_prazo_tipo');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP CONSTRAINT chk_tarefa_sol_tipo');
        DB::statement('ALTER TABLE tarefa_solicitacao_prazo DROP COLUMN tipo_solicitacao');
    }
};
```
</DATABASE_MIGRATIONS_2026_03_22_130000_ADD_TIPO_TO_TAREFA_SOLICITACAO_PRAZO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100100_create_tarefa_alerta_execucao_table.php`
## <DATABASE_MIGRATIONS_2026_06_15_100100_CREATE_TAREFA_ALERTA_EXECUCAO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100100_create_tarefa_alerta_execucao_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_alerta_execucao (
    id                     NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    agendamento_id         NUMBER,
    origem                 VARCHAR2(30 CHAR)  DEFAULT 'imediato'  NOT NULL,
    status                 VARCHAR2(20 CHAR)  DEFAULT 'pendente'  NOT NULL,
    data_hora_prevista     DATE,
    data_hora_inicio       DATE,
    data_hora_fim          DATE,
    filtros_json           CLOB,
    escopo_json            CLOB,
    assunto                VARCHAR2(500 CHAR),
    mensagem               CLOB,
    total_tarefas          NUMBER DEFAULT 0  NOT NULL,
    total_destinatarios    NUMBER DEFAULT 0  NOT NULL,
    total_sucessos         NUMBER DEFAULT 0  NOT NULL,
    total_falhas           NUMBER DEFAULT 0  NOT NULL,
    erros_json             CLOB,
    solicitante_id         NUMBER,
    solicitante_username   VARCHAR2(100 CHAR),
    solicitante_nome       VARCHAR2(255 CHAR),
    responsavel_username   VARCHAR2(100 CHAR),
    responsavel_nome       VARCHAR2(255 CHAR),
    idempotencia_chave     VARCHAR2(100 CHAR),
    dt_criacao             DATE DEFAULT SYSDATE  NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT fk_tae_agendamento
        FOREIGN KEY (agendamento_id) REFERENCES tarefa_alerta_agendamento (id) ON DELETE CASCADE,
    CONSTRAINT ck_tae_status
        CHECK (status IN ('pendente','processando','concluida','parcial','falha')),
    CONSTRAINT ck_tae_origem
        CHECK (origem IN ('imediato','agendado','manual','reprocessamento'))
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX ux_tae_idempotencia ON tarefa_alerta_execucao (idempotencia_chave)');
        DB::statement('CREATE INDEX ix_tae_agendamento ON tarefa_alerta_execucao (agendamento_id, status)');
        DB::statement('CREATE INDEX ix_tae_status      ON tarefa_alerta_execucao (status, dt_criacao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_alerta_execucao');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100100_CREATE_TAREFA_ALERTA_EXECUCAO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100200_create_tarefa_alerta_execucao_destinatario_table.php`
## <DATABASE_MIGRATIONS_2026_06_15_100200_CREATE_TAREFA_ALERTA_EXECUCAO_DESTINATARIO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100200_create_tarefa_alerta_execucao_destinatario_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_alerta_execucao_destinatario (
    id             NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    execucao_id    NUMBER         NOT NULL,
    email          VARCHAR2(255 CHAR) NOT NULL,
    status         VARCHAR2(20 CHAR)  DEFAULT 'pendente' NOT NULL,
    tentativas     NUMBER         DEFAULT 0 NOT NULL,
    dt_ultimo_envio DATE,
    erro           CLOB,
    origens_json   CLOB,
    unidades_json  CLOB,
    dt_criacao     DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao DATE,
    CONSTRAINT fk_taed_execucao
        FOREIGN KEY (execucao_id) REFERENCES tarefa_alerta_execucao (id) ON DELETE CASCADE,
    CONSTRAINT ck_taed_status
        CHECK (status IN ('pendente','enviado','falha'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_taed_execucao ON tarefa_alerta_execucao_destinatario (execucao_id, status)');
        DB::statement('CREATE UNIQUE INDEX ux_taed_exec_email ON tarefa_alerta_execucao_destinatario (execucao_id, email)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_alerta_execucao_destinatario');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100200_CREATE_TAREFA_ALERTA_EXECUCAO_DESTINATARIO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100300_create_tarefa_alerta_execucao_destinatario_tarefa_table.php`
## <DATABASE_MIGRATIONS_2026_06_15_100300_CREATE_TAREFA_ALERTA_EXECUCAO_DESTINATARIO_TAREFA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100300_create_tarefa_alerta_execucao_destinatario_tarefa_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_alerta_execucao_dest_tarefa (
    id               NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    destinatario_id  NUMBER NOT NULL,
    tarefa_id        NUMBER NOT NULL,
    tarefa_json      CLOB,
    CONSTRAINT fk_taedt_dest
        FOREIGN KEY (destinatario_id) REFERENCES tarefa_alerta_execucao_destinatario (id) ON DELETE CASCADE
)
SQL
        );

        DB::statement('CREATE INDEX ix_taedt_dest ON tarefa_alerta_execucao_dest_tarefa (destinatario_id)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_alerta_execucao_dest_tarefa');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100300_CREATE_TAREFA_ALERTA_EXECUCAO_DESTINATARIO_TAREFA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100400_create_tarefa_alerta_execucao_tentativa_table.php`
## <DATABASE_MIGRATIONS_2026_06_15_100400_CREATE_TAREFA_ALERTA_EXECUCAO_TENTATIVA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100400_create_tarefa_alerta_execucao_tentativa_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_alerta_execucao_tentativa (
    id               NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    destinatario_id  NUMBER NOT NULL,
    numero           NUMBER NOT NULL,
    status           VARCHAR2(20 CHAR) NOT NULL,
    dt_tentativa     DATE DEFAULT SYSDATE NOT NULL,
    erro             CLOB,
    tarefas_json     CLOB,
    CONSTRAINT fk_taet_dest
        FOREIGN KEY (destinatario_id) REFERENCES tarefa_alerta_execucao_destinatario (id) ON DELETE CASCADE,
    CONSTRAINT ck_taet_status
        CHECK (status IN ('enviado','falha'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_taet_dest ON tarefa_alerta_execucao_tentativa (destinatario_id, numero)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_alerta_execucao_tentativa');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100400_CREATE_TAREFA_ALERTA_EXECUCAO_TENTATIVA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100500_create_tarefa_alerta_auditoria_table.php`
## <DATABASE_MIGRATIONS_2026_06_15_100500_CREATE_TAREFA_ALERTA_AUDITORIA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100500_create_tarefa_alerta_auditoria_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE tarefa_alerta_auditoria (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    agendamento_id      NUMBER,
    acao                VARCHAR2(50 CHAR) NOT NULL,
    operador_id         NUMBER,
    operador_username   VARCHAR2(100 CHAR),
    operador_nome       VARCHAR2(255 CHAR),
    valores_antes_json  CLOB,
    valores_depois_json CLOB,
    escopo_antes_json   CLOB,
    escopo_depois_json  CLOB,
    snapshot_json       CLOB,
    dt_acao             DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT ck_taua_acao CHECK (acao IN (
        'criacao','edicao','ativacao','inativacao','clonagem',
        'envio_imediato','executar_agora','reprocessamento','exclusao'
    ))
)
SQL
        );

        DB::statement('CREATE INDEX ix_taua_agendamento ON tarefa_alerta_auditoria (agendamento_id, dt_acao)');
        DB::statement('CREATE INDEX ix_taua_acao        ON tarefa_alerta_auditoria (acao, dt_acao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_alerta_auditoria');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100500_CREATE_TAREFA_ALERTA_AUDITORIA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100700_add_tipos_destinatario_json_to_tarefa_alerta_execucao.php`
## <DATABASE_MIGRATIONS_2026_06_15_100700_ADD_TIPOS_DESTINATARIO_JSON_TO_TAREFA_ALERTA_EXECUCAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100700_add_tipos_destinatario_json_to_tarefa_alerta_execucao.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement('ALTER TABLE tarefa_alerta_execucao ADD tipos_destinatario_json CLOB');
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE tarefa_alerta_execucao DROP COLUMN tipos_destinatario_json');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100700_ADD_TIPOS_DESTINATARIO_JSON_TO_TAREFA_ALERTA_EXECUCAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_14_190000_expand_tarefa_nome_to_500_chars.php`
## <DATABASE_MIGRATIONS_2026_08_14_190000_EXPAND_TAREFA_NOME_TO_500_CHARS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_14_190000_expand_tarefa_nome_to_500_chars.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

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

return new class extends Migration {
    public function up(): void
    {
        DB::statement(
            'ALTER TABLE tarefa_solicitacao_prazo MODIFY (nome_atual VARCHAR2(500 CHAR), nome_novo VARCHAR2(500 CHAR))'
        );
        DB::statement('ALTER TABLE tarefa MODIFY (nome VARCHAR2(500 CHAR))');
    }

    public function down(): void
    {
        $tarefasIncompativeis = DB::selectOne(
            'SELECT COUNT(*) AS total FROM tarefa WHERE LENGTH(nome) > 150'
        );

        if ((int) ($tarefasIncompativeis->total ?? 0) > 0) {
            throw new RuntimeException(
                'Rollback bloqueado: existem tarefas com nome acima de 150 caracteres.'
            );
        }

        $snapshotsIncompativeis = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
FROM tarefa_solicitacao_prazo
WHERE LENGTHB(nome_atual) > 500
   OR LENGTHB(nome_novo) > 500
SQL);

        if ((int) ($snapshotsIncompativeis->total ?? 0) > 0) {
            throw new RuntimeException(
                'Rollback bloqueado: existem snapshots de nome acima de 500 bytes.'
            );
        }

        DB::statement('ALTER TABLE tarefa MODIFY (nome VARCHAR2(150 CHAR))');
        DB::statement(
            'ALTER TABLE tarefa_solicitacao_prazo MODIFY (nome_atual VARCHAR2(500 BYTE), nome_novo VARCHAR2(500 BYTE))'
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_08_14_190000_EXPAND_TAREFA_NOME_TO_500_CHARS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/emails/tarefas_atrasadas.blade.php`
## <RESOURCES_VIEWS_EMAILS_TAREFAS_ATRASADAS_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/emails/tarefas_atrasadas.blade.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** ``

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php

```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Alerta de Tarefas Atrasadas</title>
    <style>
        body { font-family: Arial, sans-serif; font-size: 14px; color: #333; }
        table { border-collapse: collapse; width: 100%; margin-top: 12px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
    </style>
</head>
<body>
@if (!empty($mensagemPersonalizada))
    <p>{!! nl2br(e($mensagemPersonalizada)) !!}</p>
@else
    <p>Prezados(as),</p>
    <p>As atividades abaixo estão em atraso e necessitam de providências.</p>
@endif

<p>
    <strong>Destinatário:</strong>
    {{ implode(' / ', array_filter($destinatario['unidades'] ?? [])) }}<br>
    <strong>Contexto:</strong> {{ implode(' / ', $destinatario['origens'] ?? []) }}
</p>

<table>
    <thead>
        <tr>
            <th>Tarefa</th>
            <th>Unidade responsável</th>
            <th>Projeto</th>
            <th>Subprojeto</th>
            <th>Status</th>
            <th>Prev. Início</th>
            <th>Prev. Fim</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($tarefas as $tarefa)
            <tr>
                <td>{{ $tarefa['nome'] }}</td>
                <td>{{ $tarefa['unidade_responsavel'] ?? '-' }}</td>
                <td>{{ $tarefa['projeto'] ?? '-' }}</td>
                <td>{{ $tarefa['subprojeto'] ?? '-' }}</td>
                <td>{{ $tarefa['status'] }}</td>
                <td>{{ $tarefa['data_prevista_inicio'] ?? '-' }}</td>
                <td>{{ $tarefa['data_prevista_fim'] ?? '-' }}</td>
            </tr>
        @endforeach
    </tbody>
</table>

<p>Cordialmente,<br>Equipe Planejamento</p>
</body>
</html>
```
</RESOURCES_VIEWS_EMAILS_TAREFAS_ATRASADAS_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EnviarAlertaTarefasJobTest.php`
## <TESTS_UNIT_ENVIARALERTATAREFASJOBTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EnviarAlertaTarefasJobTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EnviarAlertaTarefasJobTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_job_usa_somente_o_fqcn_canonico_modular(): void
public function test_nao_processa_quando_execucao_nao_for_adquirida_atomicamente(): void
protected function tearDown(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Jobs\Tarefas\EnviarAlertaTarefasJob;
use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Repositories\Tarefas\TarefaAlertaRepository;
use App\Services\Tarefas\TarefaAlertaAgendamentoService;
use Mockery;
use Tests\TestCase;

class EnviarAlertaTarefasJobTest extends TestCase
{
    public function test_job_usa_somente_o_fqcn_canonico_modular(): void
    {
        $this->assertSame('App\\Jobs\\Tarefas\\EnviarAlertaTarefasJob', EnviarAlertaTarefasJob::class);
        $this->assertFalse(class_exists('App\\Jobs\\EnviarAlertaTarefasJob'));
    }

    public function test_nao_processa_quando_execucao_nao_for_adquirida_atomicamente(): void
    {
        $execucoes = Mockery::mock(TarefaAlertaExecucaoRepository::class);
        $agendamentos = Mockery::mock(TarefaAlertaAgendamentoRepository::class);
        $service = Mockery::mock(TarefaAlertaAgendamentoService::class);
        $tarefas = Mockery::mock(TarefaAlertaRepository::class);
        $execucoes->shouldReceive('encontrar')->once()->with(55)->andReturn((object) ['id' => 55, 'status' => 'pendente']);
        $execucoes->shouldReceive('marcarProcessandoSePendente')->once()->with(55)->andReturnFalse();
        $tarefas->shouldNotReceive('buscarTarefas');

        (new EnviarAlertaTarefasJob(55))->handle($execucoes, $agendamentos, $service, $tarefas);
        $this->assertTrue(true);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }
}
```
</TESTS_UNIT_ENVIARALERTATAREFASJOBTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaAlertaDuplicidadeServiceTest.php`
## <TESTS_UNIT_TAREFAALERTADUPLICIDADESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaAlertaDuplicidadeServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaAlertaDuplicidadeServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_rejeita_mesma_data_com_mesmas_tarefas_e_destinatarios(): void
public function test_permite_coincidencia_parcial_de_tarefas(): void
protected function tearDown(): void
private function candidato(string $dataHora): array
private function agendamentoExistente(string $dataHora): object
private function escopo(): array
private function tarefas(array $ids): Collection
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaRepository;
use App\Services\Tarefas\TarefaAlertaDuplicidadeService;
use App\Services\Tarefas\TarefaAlertaRecorrenciaService;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class TarefaAlertaDuplicidadeServiceTest extends TestCase
{
    public function test_rejeita_mesma_data_com_mesmas_tarefas_e_destinatarios(): void
    {
        Carbon::setTestNow(Carbon::parse('2026-06-15 08:00:00', 'America/Rio_Branco'));
        $agendamentos = Mockery::mock(TarefaAlertaAgendamentoRepository::class);
        $tarefas = Mockery::mock(TarefaAlertaRepository::class);
        $agendamentos->shouldReceive('buscarAtivosDoMacro')->once()->with(7, null)->andReturn(collect([
            $this->agendamentoExistente('2026-06-20 10:00:00'),
        ]));
        $tarefas->shouldReceive('buscarTarefas')->twice()->andReturn($this->tarefas([10, 20]));

        $service = new TarefaAlertaDuplicidadeService($agendamentos, $tarefas, new TarefaAlertaRecorrenciaService());
        $this->expectException(RuntimeException::class);
        $service->validar($this->candidato('2026-06-20 15:00:00'), $this->escopo(), null);
    }

    public function test_permite_coincidencia_parcial_de_tarefas(): void
    {
        Carbon::setTestNow(Carbon::parse('2026-06-15 08:00:00', 'America/Rio_Branco'));
        $agendamentos = Mockery::mock(TarefaAlertaAgendamentoRepository::class);
        $tarefas = Mockery::mock(TarefaAlertaRepository::class);
        $agendamentos->shouldReceive('buscarAtivosDoMacro')->once()->andReturn(collect([
            $this->agendamentoExistente('2026-06-20 10:00:00'),
        ]));
        $tarefas->shouldReceive('buscarTarefas')->once()->andReturn($this->tarefas([10, 20]));
        $tarefas->shouldReceive('buscarTarefas')->once()->andReturn($this->tarefas([10]));

        $service = new TarefaAlertaDuplicidadeService($agendamentos, $tarefas, new TarefaAlertaRecorrenciaService());
        $service->validar($this->candidato('2026-06-20 15:00:00'), $this->escopo(), null);
        $this->assertTrue(true);
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        Mockery::close();
        parent::tearDown();
    }

    private function candidato(string $dataHora): array
    {
        return [
            'macroprojeto_id' => 7,
            'data_hora_envio_agendado' => $dataHora,
            'recorrente' => false,
            'filtros_json' => json_encode(['status' => ['ATRASADA']]),
            'tipos_destinatario_json' => json_encode(['unidade_tarefa']),
        ];
    }

    private function agendamentoExistente(string $dataHora): object
    {
        return (object) array_merge($this->candidato($dataHora), [
            'id' => 99,
            'data_final' => null,
            'recorrencia_tipo' => null,
            'recorrencia_dia' => null,
            'escopo_json' => json_encode($this->escopo()),
        ]);
    }

    private function escopo(): array
    {
        return ['macroprojeto_id' => 7, 'unidades_permitidas_ids' => null];
    }

    private function tarefas(array $ids): Collection
    {
        return collect(array_map(static fn (int $id) => [
            'id' => $id,
            'unidade_tarefa' => ['email' => ' unidade@tre-ac.jus.br ', 'label' => 'UNIDADE'],
            'unidade_subprojeto' => null,
            'unidade_projeto' => null,
        ], $ids));
    }
}
```
</TESTS_UNIT_TAREFAALERTADUPLICIDADESERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaAlertaInsertIdRepositoryTest.php`
## <TESTS_UNIT_TAREFAALERTAINSERTIDREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaAlertaInsertIdRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaAlertaInsertIdRepositoryTest extends TestCase`

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
public function test_execucao_repository_usa_insert_get_id_ao_criar_execucao(): void
public function test_execucao_repository_usa_insert_get_id_ao_criar_destinatario(): void
public function test_agendamento_repository_usa_insert_get_id_ao_criar_agendamento(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class TarefaAlertaInsertIdRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $auditRepository = Mockery::mock(AuditLogRepositoryInterface::class);
        $auditRepository->shouldReceive('inserir')->zeroOrMoreTimes();
        $this->app->instance(AuditLogRepositoryInterface::class, $auditRepository);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_execucao_repository_usa_insert_get_id_ao_criar_execucao(): void
    {
        $builder = Mockery::mock();

        DB::shouldReceive('raw')->once()->with('SYSDATE')->andReturn('SYSDATE');
        $depois = Mockery::mock();
        $depois->shouldReceive('where')->once()->with('id', 123)->andReturnSelf();
        $depois->shouldReceive('first')->once()->andReturn((object) ['id' => 123, 'assunto' => 'Assunto']);
        DB::shouldReceive('table')->once()->with('tarefa_alerta_execucao')->andReturn($builder);
        DB::shouldReceive('table')->once()->with('tarefa_alerta_execucao')->andReturn($depois);

        $builder->shouldReceive('insertGetId')
            ->once()
            ->with(
                Mockery::on(static fn (array $payload): bool => ($payload['assunto'] ?? null) === 'Assunto' && array_key_exists('dt_criacao', $payload)),
                'id'
            )
            ->andReturn(123);

        $repository = new TarefaAlertaExecucaoRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $id = $repository->criar([
            'origem' => 'manual',
            'status' => 'pendente',
            'assunto' => 'Assunto',
        ]);

        $this->assertSame(123, $id);
    }

    public function test_execucao_repository_usa_insert_get_id_ao_criar_destinatario(): void
    {
        $builder = Mockery::mock();

        DB::shouldReceive('raw')->once()->with('SYSDATE')->andReturn('SYSDATE');
        $depois = Mockery::mock();
        $depois->shouldReceive('where')->once()->with('id', 456)->andReturnSelf();
        $depois->shouldReceive('first')->once()->andReturn((object) ['id' => 456, 'execucao_id' => 7]);
        DB::shouldReceive('table')->once()->with('tarefa_alerta_execucao_destinatario')->andReturn($builder);
        DB::shouldReceive('table')->once()->with('tarefa_alerta_execucao_destinatario')->andReturn($depois);

        $builder->shouldReceive('insertGetId')
            ->once()
            ->with(
                Mockery::on(static fn (array $payload): bool => ($payload['execucao_id'] ?? null) === 7 && ($payload['email'] ?? null) === 'destino@tre-ac.jus.br' && array_key_exists('dt_criacao', $payload)),
                'id'
            )
            ->andReturn(456);

        $repository = new TarefaAlertaExecucaoRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $id = $repository->criarDestinatario(7, [
            'email' => 'destino@tre-ac.jus.br',
            'status' => 'pendente',
        ]);

        $this->assertSame(456, $id);
    }

    public function test_agendamento_repository_usa_insert_get_id_ao_criar_agendamento(): void
    {
        $builder = Mockery::mock();

        DB::shouldReceive('raw')->once()->with('SYSDATE')->andReturn('SYSDATE');
        $depois = Mockery::mock();
        $depois->shouldReceive('where')->once()->with('id', 789)->andReturnSelf();
        $depois->shouldReceive('first')->once()->andReturn((object) ['id' => 789, 'nome' => 'Agendamento de teste']);
        DB::shouldReceive('table')->once()->with('tarefa_alerta_agendamento')->andReturn($builder);
        DB::shouldReceive('table')->once()->with('tarefa_alerta_agendamento')->andReturn($depois);

        $builder->shouldReceive('insertGetId')
            ->once()
            ->with(
                Mockery::on(static fn (array $payload): bool => ($payload['nome'] ?? null) === 'Agendamento de teste' && array_key_exists('dt_criacao', $payload)),
                'id'
            )
            ->andReturn(789);

        $repository = new TarefaAlertaAgendamentoRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $id = $repository->criar([
            'macroprojeto_id' => 1,
            'nome' => 'Agendamento de teste',
            'status' => 'ativo',
        ]);

        $this->assertSame(789, $id);
    }
}
```
</TESTS_UNIT_TAREFAALERTAINSERTIDREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaAlertaRecorrenciaServiceTest.php`
## <TESTS_UNIT_TAREFAALERTARECORRENCIASERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaAlertaRecorrenciaServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaAlertaRecorrenciaServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_timezone_padrao_e_america_rio_branco(): void
public function test_semanal_mantem_data_quando_dia_coincide(): void
public function test_semanal_avanca_para_proximo_dia_quando_nao_coincide(): void
public function test_semanal_avanca_para_semana_seguinte_quando_dia_ja_passou(): void
public function test_semanal_mantem_hora_da_base(): void
public function test_semanal_proxima_e_sete_dias_depois(): void
public function test_semanal_gera_ocorrencias_ate_data_final_inclusiva(): void
public function test_semanal_data_final_inclusiva_na_ultima_ocorrencia(): void
public function test_mensal_mantem_data_quando_dia_coincide(): void
public function test_mensal_avanca_dentro_do_mes_quando_dia_ainda_nao_chegou(): void
public function test_mensal_avanca_para_proximo_mes_quando_dia_ja_passou(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Tarefas\TarefaAlertaRecorrenciaService;
use App\Support\Tarefas\TarefaAlertaRecorrenciaTipo;
use Carbon\Carbon;
use Tests\TestCase;

class TarefaAlertaRecorrenciaServiceTest extends TestCase
{
    private TarefaAlertaRecorrenciaService $service;

    protected function setUp(): void
    {
        parent::setUp();
        $this->service = new TarefaAlertaRecorrenciaService();
    }

    // ─── Timezone ───────────────────────────────────────────────────────────

    public function test_timezone_padrao_e_america_rio_branco(): void
    {
        $tz = $this->service->timezone();
        $this->assertSame('America/Rio_Branco', $tz);
    }

    // ─── Semanal: primeira ocorrência ────────────────────────────────────────

    public function test_semanal_mantem_data_quando_dia_coincide(): void
    {
        // 2026-06-15 é segunda (dayOfWeek=1)
        $base = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaSemanal($base, 1);

        $this->assertSame('2026-06-15', $primeira->toDateString());
    }

    public function test_semanal_avanca_para_proximo_dia_quando_nao_coincide(): void
    {
        // 2026-06-15 é segunda (1); configurado para quinta (4)
        $base = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaSemanal($base, 4);

        $this->assertSame('2026-06-18', $primeira->toDateString());
    }

    public function test_semanal_avanca_para_semana_seguinte_quando_dia_ja_passou(): void
    {
        // 2026-06-15 é segunda (1); configurado para domingo (0)
        $base = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaSemanal($base, 0);

        $this->assertSame('2026-06-21', $primeira->toDateString());
    }

    public function test_semanal_mantem_hora_da_base(): void
    {
        $base = Carbon::parse('2026-06-15 14:30:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaSemanal($base, 1);

        $this->assertSame('14:30:00', $primeira->format('H:i:s'));
    }

    // ─── Semanal: próximas ocorrências ───────────────────────────────────────

    public function test_semanal_proxima_e_sete_dias_depois(): void
    {
        $atual = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $proxima = $this->service->proximaOcorrenciaSemanal($atual);

        $this->assertSame('2026-06-22', $proxima->toDateString());
    }

    public function test_semanal_gera_ocorrencias_ate_data_final_inclusiva(): void
    {
        $inicio = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco'); // segunda
        $fim    = Carbon::parse('2026-06-29', 'America/Rio_Branco');

        $ocorrencias = $this->service->gerarOcorrenciasSemanal($inicio, 1, $fim);

        $this->assertCount(3, $ocorrencias);
        $this->assertSame('2026-06-15', $ocorrencias[0]->toDateString());
        $this->assertSame('2026-06-22', $ocorrencias[1]->toDateString());
        $this->assertSame('2026-06-29', $ocorrencias[2]->toDateString());
    }

    public function test_semanal_data_final_inclusiva_na_ultima_ocorrencia(): void
    {
        // data final = exatamente o dia de uma ocorrência deve incluí-la
        $inicio = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $fim    = Carbon::parse('2026-06-22', 'America/Rio_Branco');

        $ocorrencias = $this->service->gerarOcorrenciasSemanal($inicio, 1, $fim);

        $this->assertCount(2, $ocorrencias);
        $this->assertSame('2026-06-22', $ocorrencias[1]->toDateString());
    }

    // ─── Mensal: primeira ocorrência ─────────────────────────────────────────

    public function test_mensal_mantem_data_quando_dia_coincide(): void
    {
        // 2026-06-15, dia 15 configurado
        $base = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 15);

        $this->assertSame('2026-06-15', $primeira->toDateString());
    }

    public function test_mensal_avanca_dentro_do_mes_quando_dia_ainda_nao_chegou(): void
    {
        // 2026-06-10, dia 20 configurado
        $base = Carbon::parse('2026-06-10 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 20);

        $this->assertSame('2026-06-20', $primeira->toDateString());
    }

    public function test_mensal_avanca_para_proximo_mes_quando_dia_ja_passou(): void
    {
        // 2026-06-20, dia 10 configurado
        $base = Carbon::parse('2026-06-20 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 10);

        $this->assertSame('2026-07-10', $primeira->toDateString());
    }

    public function test_mensal_mantem_hora_da_base(): void
    {
        $base = Carbon::parse('2026-06-15 08:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 15);

        $this->assertSame('08:00:00', $primeira->format('H:i:s'));
    }

    // ─── Mensal: dias 29, 30, 31 ─────────────────────────────────────────────

    public function test_mensal_dia_31_em_fevereiro_usa_ultimo_dia(): void
    {
        // fevereiro 2026 tem 28 dias
        $base = Carbon::parse('2026-02-01 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 31);

        $this->assertSame('2026-02-28', $primeira->toDateString());
    }

    public function test_mensal_dia_31_em_abril_usa_ultimo_dia(): void
    {
        // abril tem 30 dias
        $base = Carbon::parse('2026-04-01 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 31);

        $this->assertSame('2026-04-30', $primeira->toDateString());
    }

    public function test_mensal_dia_29_em_fevereiro_nao_bissexto_usa_ultimo_dia(): void
    {
        $base = Carbon::parse('2026-02-01 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 29);

        $this->assertSame('2026-02-28', $primeira->toDateString());
    }

    public function test_mensal_dia_29_em_mes_com_29_dias_mantém_dia(): void
    {
        // fevereiro 2028 é bissexto
        $base = Carbon::parse('2028-02-01 09:00:00', 'America/Rio_Branco');
        $primeira = $this->service->primeiraOcorrenciaMensal($base, 29);

        $this->assertSame('2028-02-29', $primeira->toDateString());
    }

    // ─── Mensal: próximas ocorrências ────────────────────────────────────────

    public function test_mensal_proxima_e_mesmo_dia_do_mes_seguinte(): void
    {
        $atual = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $proxima = $this->service->proximaOcorrenciaMensal($atual, 15);

        $this->assertSame('2026-07-15', $proxima->toDateString());
    }

    public function test_mensal_dia_31_proxima_em_mes_sem_31_usa_ultimo_dia(): void
    {
        $atual = Carbon::parse('2026-05-31 09:00:00', 'America/Rio_Branco');
        $proxima = $this->service->proximaOcorrenciaMensal($atual, 31);

        // junho tem 30 dias
        $this->assertSame('2026-06-30', $proxima->toDateString());
    }

    public function test_mensal_gera_ocorrencias_ate_data_final_inclusiva(): void
    {
        $inicio = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $fim    = Carbon::parse('2026-08-15', 'America/Rio_Branco');

        $ocorrencias = $this->service->gerarOcorrenciasMensal($inicio, 15, $fim);

        $this->assertCount(3, $ocorrencias);
        $this->assertSame('2026-06-15', $ocorrencias[0]->toDateString());
        $this->assertSame('2026-07-15', $ocorrencias[1]->toDateString());
        $this->assertSame('2026-08-15', $ocorrencias[2]->toDateString());
    }

    public function test_mensal_data_final_inclusiva(): void
    {
        $inicio = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco');
        $fim    = Carbon::parse('2026-07-15', 'America/Rio_Branco');

        $ocorrencias = $this->service->gerarOcorrenciasMensal($inicio, 15, $fim);

        $this->assertCount(2, $ocorrencias);
        $this->assertSame('2026-07-15', $ocorrencias[1]->toDateString());
    }

    // ─── Validação de data final ──────────────────────────────────────────────

    public function test_semanal_rejeita_data_final_anterior_a_primeira_ocorrencia(): void
    {
        $this->expectException(\InvalidArgumentException::class);

        $inicio = Carbon::parse('2026-06-15 09:00:00', 'America/Rio_Branco'); // segunda (1)
        // data configurada = quinta (4) → primeira = 2026-06-18
        // data final = 2026-06-17 é anterior → deve rejeitar
        $fim = Carbon::parse('2026-06-17', 'America/Rio_Branco');

        $this->service->gerarOcorrenciasSemanal($inicio, 4, $fim);
    }

    public function test_mensal_rejeita_data_final_anterior_a_primeira_ocorrencia(): void
    {
        $this->expectException(\InvalidArgumentException::class);

        // base = 2026-06-20; dia 10 → primeira = 2026-07-10
        $inicio = Carbon::parse('2026-06-20 09:00:00', 'America/Rio_Branco');
        $fim    = Carbon::parse('2026-07-09', 'America/Rio_Branco');

        $this->service->gerarOcorrenciasMensal($inicio, 10, $fim);
    }

    // ─── Datas passadas detectadas como datas futuras ────────────────────────

    public function test_data_hora_futura_retorna_true_quando_no_futuro(): void
    {
        $futura = Carbon::now('America/Rio_Branco')->addHour();
        $this->assertTrue($this->service->eDataHoraFutura($futura));
    }

    public function test_data_hora_futura_retorna_false_quando_no_passado(): void
    {
        $passada = Carbon::now('America/Rio_Branco')->subMinute();
        $this->assertFalse($this->service->eDataHoraFutura($passada));
    }
}
```
</TESTS_UNIT_TAREFAALERTARECORRENCIASERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaAlertaRepositoryHttpDesacoplamentoTest.php`
## <TESTS_UNIT_TAREFAALERTAREPOSITORYHTTPDESACOPLAMENTOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaAlertaRepositoryHttpDesacoplamentoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaAlertaRepositoryHttpDesacoplamentoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
* Mocka DB::table(tabela)->where(...)->first() retornando null, simulando
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_execucao_inexistente_nao_lanca_excecao_http(): void
public function test_agendamento_inexistente_nao_lanca_excecao_http(): void
private function mockarPrimeiroNulo(string $tabela): void
private function assertNaoHttp(callable $acao): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use Illuminate\Support\Facades\DB;
use Mockery;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Tests\TestCase;

/**
 * Congela o desacoplamento de HTTP nos repositories de alertas
 * (docs/contratos/repositories.md §37, §182: "repository nao conhece HTTP").
 *
 * encontrarOuFalhar() hoje chama abort(404), acoplando a camada de dados ao
 * Symfony HTTP. O comportamento desejado e lancar excecao de DOMINIO quando o
 * registro nao existe; o controller traduz para 404. Estes testes falham
 * enquanto o repository lancar uma excecao HTTP.
 */
class TarefaAlertaRepositoryHttpDesacoplamentoTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_execucao_inexistente_nao_lanca_excecao_http(): void
    {
        $this->mockarPrimeiroNulo('tarefa_alerta_execucao');

        $repository = new TarefaAlertaExecucaoRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertNaoHttp(fn () => $repository->encontrarOuFalhar(999));
    }

    public function test_agendamento_inexistente_nao_lanca_excecao_http(): void
    {
        $this->mockarPrimeiroNulo('tarefa_alerta_agendamento');

        $repository = new TarefaAlertaAgendamentoRepository(app(\App\Services\Auditoria\AuditLogService::class));

        $this->assertNaoHttp(fn () => $repository->encontrarOuFalhar(999));
    }

    /**
     * Mocka DB::table(tabela)->where(...)->first() retornando null, simulando
     * registro inexistente sem tocar no Oracle.
     */
    private function mockarPrimeiroNulo(string $tabela): void
    {
        $builder = Mockery::mock();
        $builder->shouldReceive('where')->andReturnSelf();
        $builder->shouldReceive('first')->andReturnNull();

        DB::shouldReceive('table')->with($tabela)->andReturn($builder);
    }

    /**
     * O registro nao existe, entao encontrarOuFalhar() deve lancar. O que este
     * teste congela e que a excecao NAO seja do tipo HTTP — deve ser de dominio.
     */
    private function assertNaoHttp(callable $acao): void
    {
        try {
            $acao();
            $this->fail('encontrarOuFalhar() deveria lancar para registro inexistente.');
        } catch (NotFoundHttpException $e) {
            $this->fail('Repository lancou excecao HTTP (abort/404); esperado excecao de dominio.');
        } catch (\Throwable $e) {
            $this->assertNotInstanceOf(NotFoundHttpException::class, $e);
        }
    }
}
```
</TESTS_UNIT_TAREFAALERTAREPOSITORYHTTPDESACOPLAMENTOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaControllerDesacoplamentoTest.php`
## <TESTS_UNIT_TAREFACONTROLLERDESACOPLAMENTOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaControllerDesacoplamentoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaControllerDesacoplamentoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_index_passa_macroprojeto_da_sessao_para_o_repository(): void
private function autorizarMacroAtivo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Tarefas\TarefaController;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\Planejamento\PlanejamentoPermissoes;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

/**
 * Congela o contrato de desacoplamento (docs/contratos/repositories.md) para o
 * modulo de Tarefas: o TarefaController deve resolver o macroprojeto ativo a
 * partir da sessao e repassa-lo EXPLICITAMENTE ao TarefaRepository.
 */
class TarefaControllerDesacoplamentoTest extends TestCase
{
    private const MACRO_ID = 7;

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_index_passa_macroprojeto_da_sessao_para_o_repository(): void
    {
        $this->autorizarMacroAtivo();

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('listarProjetos')
            ->once()
            ->with(self::MACRO_ID)
            ->andReturn([]);
        $repository->shouldReceive('listarUnidades')
            ->once()
            ->andReturn([]);
        $repository->shouldReceive('listarCategoriasAtivas')
            ->once()
            ->andReturn([]);
        $repository->shouldReceive('listarFasesAtivas')
            ->once()
            ->andReturn([]);

        $permissoes = Mockery::mock(PlanejamentoPermissoes::class);
        $escopo = Mockery::mock(EscopoUnidadeService::class);

        $controller = new TarefaController($repository, $permissoes, $escopo);
        $controller->index();

        $this->assertTrue(true);
    }

    private function autorizarMacroAtivo(): void
    {
        session([
            'matchingGroups' => ['GRUPO_X'],
            'macroprojeto_ativo_id' => self::MACRO_ID,
            'rotas_permitidas' => ['TAREFAS.FORM', 'TAREFAS.SALVAR'],
        ]);

        $permissaoService = Mockery::mock(\App\Services\PermissaoDominioService::class);
        $permissaoService->shouldReceive('podeExecutar')->andReturnTrue();
        $permissaoService->shouldReceive('podeOperarMacro')->andReturnTrue();
        $this->app->instance(\App\Services\PermissaoDominioService::class, $permissaoService);
    }
}
```
</TESTS_UNIT_TAREFACONTROLLERDESACOPLAMENTOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaControllerPermissoesTest.php`
## <TESTS_UNIT_TAREFACONTROLLERPERMISSOESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaControllerPermissoesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaControllerPermissoesTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_usuario_pode_gerir_tarefa_sem_escopo_unidade_quando_tem_rota_de_formulario(): void
public function test_usuario_pode_decidir_solicitacao_prazo_quando_tem_rota_de_aprovacao(): void
public function test_autorizar_tarefa_para_nao_admin_nao_delega_quando_usuario_tem_bypass_por_rota(): void
public function test_autorizar_tarefa_para_nao_admin_delega_para_service_com_escopo_e_callback_do_repositorio(): void
public function test_painel_de_solicitacoes_de_prazo_usa_paginacao_de_vinte_itens(): void
private function novoController(): TarefaController
private function invocarMetodoPrivado(object $instancia, string $metodo, array $args = []): mixed
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Tarefas\TarefaController;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use App\Services\Planejamento\PlanejamentoPermissoes;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class TarefaControllerPermissoesTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_usuario_pode_gerir_tarefa_sem_escopo_unidade_quando_tem_rota_de_formulario(): void
    {
        session([
            'rotas_permitidas' => ['tarefas.form'],
        ]);

        $controller = $this->novoController();

        $this->assertTrue($this->invocarMetodoPrivado($controller, 'usuarioPodeGerirTarefaSemEscopoUnidade'));
    }

    public function test_usuario_pode_decidir_solicitacao_prazo_quando_tem_rota_de_aprovacao(): void
    {
        session([
            'rotas_permitidas' => ['tarefas.solicitacoes.prazo.aprovar'],
        ]);

        $controller = $this->novoController();

        $this->assertTrue($this->invocarMetodoPrivado($controller, 'usuarioPodeDecidirSolicitacaoPrazo'));
    }

    public function test_autorizar_tarefa_para_nao_admin_nao_delega_quando_usuario_tem_bypass_por_rota(): void
    {
        session([
            'rotas_permitidas' => ['tarefas.salvar'],
        ]);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $permissoes = Mockery::mock(PlanejamentoPermissoes::class);
        $permissoes->shouldNotReceive('validarPermissaoTarefa');
        $escopo = Mockery::mock(EscopoUnidadeService::class);

        $controller = new TarefaController($repository, $permissoes, $escopo);

        $this->invocarMetodoPrivado($controller, 'autorizarTarefaParaNaoAdmin', [7, 10]);

        $this->assertTrue(true);
    }

    public function test_autorizar_tarefa_para_nao_admin_delega_para_service_com_escopo_e_callback_do_repositorio(): void
    {
        session([
            'rotas_permitidas' => ['tarefas.index'],
        ]);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('buscarEscopoUnidadesDaTarefa')
            ->once()
            ->with(7, Mockery::any())
            ->andReturn((object) ['unidade_id' => 20]);

        $permissoes = Mockery::mock(PlanejamentoPermissoes::class);
        $permissoes->shouldReceive('validarPermissaoTarefa')
            ->once()
            ->withArgs(function ($tarefaId, $unidadeId, $unidades, $buscar) {
                if ($tarefaId !== 7 || $unidadeId !== 10 || $unidades !== [20, 30] || !is_callable($buscar)) {
                    return false;
                }

                $resultado = $buscar(7);

                return is_object($resultado) && (int) $resultado->unidade_id === 20;
            });

        $escopo = Mockery::mock(EscopoUnidadeService::class);
        $escopo->shouldReceive('unidadesParaConsultaAtual')
            ->once()
            ->andReturn([20, 30]);

        $controller = new TarefaController($repository, $permissoes, $escopo);

        $this->invocarMetodoPrivado($controller, 'autorizarTarefaParaNaoAdmin', [7, 10]);

        $this->assertTrue(true);
    }

    public function test_painel_de_solicitacoes_de_prazo_usa_paginacao_de_vinte_itens(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(1, ['PLANELEITO_ADMIN'])
            ->andReturn(true);
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $paginator = new LengthAwarePaginator([], 0, 20, 1, [
            'path' => '/tarefas/solicitacoes-prazo',
        ]);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('listarSolicitacoesAlteracaoPrazoPainel')
            ->once()
            ->with([
                'status' => 'PENDENTE',
                'tipo' => null,
                'projeto_id' => null,
                'unidade_id' => null,
                'data_solicitacao_de' => null,
                'data_solicitacao_ate' => null,
            ], 1, 20)
            ->andReturn($paginator);
        $repository->shouldReceive('listarProjetos')->once()->with(1)->andReturn([]);
        $repository->shouldReceive('listarUnidades')->once()->andReturn([]);
        $repository->shouldReceive('contarSolicitacoesAlteracaoPrazoPainelPorStatus')
            ->once()
            ->with([
                'status' => 'PENDENTE',
                'tipo' => null,
                'projeto_id' => null,
                'unidade_id' => null,
                'data_solicitacao_de' => null,
                'data_solicitacao_ate' => null,
            ], 1)
            ->andReturn([]);

        $controller = new TarefaController(
            $repository,
            Mockery::mock(PlanejamentoPermissoes::class),
            Mockery::mock(EscopoUnidadeService::class)
        );

        $request = Request::create('/tarefas/solicitacoes-prazo', 'GET');
        $this->app->instance('request', $request);

        $response = $controller->painelSolicitacoesPrazo($request);

        $this->assertSame('planejamento.tarefas.solicitacoes_prazo_painel', $response->name());
        $this->assertSame($paginator, $response->getData()['solicitacoes']);
    }

    private function novoController(): TarefaController
    {
        return new TarefaController(
            Mockery::mock(TarefaRepositoryInterface::class),
            Mockery::mock(PlanejamentoPermissoes::class),
            Mockery::mock(EscopoUnidadeService::class)
        );
    }

    /**
     * @param array<int, mixed> $args
     */
    private function invocarMetodoPrivado(object $instancia, string $metodo, array $args = []): mixed
    {
        $reflection = new \ReflectionMethod($instancia, $metodo);
        $reflection->setAccessible(true);

        return $reflection->invokeArgs($instancia, $args);
    }
}
```
</TESTS_UNIT_TAREFACONTROLLERPERMISSOESTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaMonitoramentoControllerTest.php`
## <TESTS_UNIT_TAREFAMONITORAMENTOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaMonitoramentoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaMonitoramentoControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_monitoramento_geral_publico_renderiza_view_dedicada_com_resumo_agregado(): void
public function getName(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Tarefas\TarefaMonitoramentoController;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Services\EscopoUnidadeService;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Mockery;
use Tests\TestCase;

class TarefaMonitoramentoControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_monitoramento_geral_publico_renderiza_view_dedicada_com_resumo_agregado(): void
    {
        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('buscarMacroprojetoAtivoPublico')
            ->once()
            ->andReturn(9);
        $repository->shouldReceive('buscarTarefasMonitoramentoPublico')
            ->once()
            ->with(9)
            ->andReturn(new Collection([
                (object) [
                    'status' => 'CONCLUÍDA',
                    'data_real_fim' => '2026-04-20',
                    'projeto_nome' => 'Projeto A',
                    'subprojeto_nome' => 'Sub A',
                ],
                (object) [
                    'status' => 'ATRASADA',
                    'data_real_fim' => null,
                    'projeto_nome' => 'Projeto A',
                    'subprojeto_nome' => 'Sub B',
                ],
            ]));

        $escopo = Mockery::mock(EscopoUnidadeService::class);
        $escopo->shouldNotReceive('unidadesParaConsultaAtual');

        $controller = new TarefaMonitoramentoController($repository, $escopo);

        $request = Request::create('/tarefas/monitoramento/geral/publico', 'GET');
        $request->setRouteResolver(static fn () => new class {
            public function getName(): string
            {
                return 'tarefas.monitoramento.geral.publico';
            }
        });
        $this->app->instance('request', $request);

        $response = $controller->monitoramentoGeralPublico($request);
        $dados = $response->getData();

        $this->assertSame('planejamento.tarefas.monitoramento_publico', $response->name());
        $this->assertSame('Eleições 2026', $dados['macroprojetoNome']);
        $this->assertSame(2, $dados['total']);
        $this->assertSame(50.0, $dados['percentualConcluido']);
        $this->assertTrue($dados['semLinksAtividades']);
        $this->assertSame('tarefas.monitoramento.geral.publico', $dados['limparRouteName']);
        $this->assertCount(1, $dados['saudeProjetos']);
        $this->assertCount(2, $dados['saudeSubprojetos']);
    }
}
```
</TESTS_UNIT_TAREFAMONITORAMENTOCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaNomeLimiteTest.php`
## <TESTS_UNIT_TAREFANOMELIMITETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaNomeLimiteTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaNomeLimiteTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function cadastro_e_solicitacoes_aceitam_500_caracteres_e_rejeitam_501(): void
public function formularios_declaram_o_mesmo_limite_de_500_caracteres(): void
public function migration_alinha_destino_e_snapshots_com_semantica_de_caracteres(): void
private function requestsComNome(string $nome): array
private function validator(string $requestClass, array $payload): \Illuminate\Validation\Validator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Tarefas\TarefaRequest;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoLoteRequest;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoRequest;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class TarefaNomeLimiteTest extends TestCase
{
    private const MIGRATION = 'database/migrations/2026_08_14_190000_expand_tarefa_nome_to_500_chars.php';

    #[Test]
    public function cadastro_e_solicitacoes_aceitam_500_caracteres_e_rejeitam_501(): void
    {
        $nome500 = str_repeat('á', 500);
        $nome501 = $nome500.'á';

        foreach ($this->requestsComNome($nome500) as [$requestClass, $payload]) {
            $validator = $this->validator($requestClass, $payload);

            $this->assertFalse(
                $validator->fails(),
                $requestClass.': '.$validator->errors()->first()
            );
        }

        foreach ($this->requestsComNome($nome501) as [$requestClass, $payload]) {
            $validator = $this->validator($requestClass, $payload);
            $campo = $requestClass === TarefaRequest::class ? 'NOME' : 'NOME_NOVO';

            $this->assertTrue($validator->fails(), $requestClass);
            $this->assertTrue($validator->errors()->has($campo), $requestClass);
        }
    }

    #[Test]
    public function formularios_declaram_o_mesmo_limite_de_500_caracteres(): void
    {
        $formularios = [
            ['resources/views/planejamento/tarefas/form.blade.php', 'NOME'],
            ['resources/views/planejamento/tarefas/solicitacoes_prazo.blade.php', 'NOME_NOVO'],
            ['resources/views/planejamento/tarefas/solicitacoes_prazo_lote.blade.php', 'NOME_NOVO'],
        ];

        foreach ($formularios as [$arquivo, $campo]) {
            $source = (string) file_get_contents(base_path($arquivo));

            $this->assertMatchesRegularExpression(
                '/name="'.preg_quote($campo, '/').'"[^>]*maxlength="500"/s',
                $source,
                $arquivo
            );
        }
    }

    #[Test]
    public function migration_alinha_destino_e_snapshots_com_semantica_de_caracteres(): void
    {
        $path = base_path(self::MIGRATION);
        $this->assertFileExists($path);

        $source = is_file($path) ? (string) file_get_contents($path) : '';

        $this->assertStringContainsString(
            'ALTER TABLE tarefa MODIFY (nome VARCHAR2(500 CHAR))',
            $source
        );
        $this->assertStringContainsString(
            'ALTER TABLE tarefa_solicitacao_prazo MODIFY (nome_atual VARCHAR2(500 CHAR), nome_novo VARCHAR2(500 CHAR))',
            $source
        );
        $this->assertStringContainsString('WHERE LENGTH(nome) > 150', $source);
        $this->assertStringContainsString('VARCHAR2(150 CHAR)', $source);
        $this->assertStringContainsString('VARCHAR2(500 BYTE)', $source);
    }

    /**
     * @return array<int, array{class-string<FormRequest>, array<string, mixed>}>
     */
    private function requestsComNome(string $nome): array
    {
        return [
            [TarefaRequest::class, [
                'ID' => 441,
                'NOME' => $nome,
                'SUBPROJETO_ID' => 1,
                'UNIDADE_ID' => 1,
            ]],
            [TarefaSolicitacaoPrazoRequest::class, [
                'TIPO_SOLICITACAO' => 'ALTERACAO',
                'NOME_NOVO' => $nome,
                'JUSTIFICATIVA' => 'Justificativa suficientemente detalhada.',
            ]],
            [TarefaSolicitacaoPrazoLoteRequest::class, [
                'TAREFA_IDS' => [441],
                'TIPO_SOLICITACAO' => 'ALTERACAO',
                'NOME_NOVO' => $nome,
                'JUSTIFICATIVA' => 'Justificativa suficientemente detalhada.',
            ]],
        ];
    }

    /**
     * @param class-string<FormRequest> $requestClass
     * @param array<string, mixed> $payload
     */
    private function validator(string $requestClass, array $payload): \Illuminate\Validation\Validator
    {
        $request = $requestClass::create('/tarefas', 'POST', $payload);
        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->invoke($request);
        $validator = Validator::make($request->all(), $request->rules(), $request->messages());

        if (method_exists($request, 'withValidator')) {
            $request->withValidator($validator);
        }

        return $validator;
    }
}
```
</TESTS_UNIT_TAREFANOMELIMITETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaSolicitacaoPrazoBaseRequestTest.php`
## <TESTS_UNIT_TAREFASOLICITACAOPRAZOBASEREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaSolicitacaoPrazoBaseRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoBaseRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function individual_e_lote_aplicam_os_mesmos_erros_aos_campos_comuns(): void
public function ambos_rejeitam_data_ambigua_em_vez_de_converte_la(): void
private function validator(string $requestClass, array $payload): LaravelValidator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoLoteRequest;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoRequest;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Validator as LaravelValidator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class TarefaSolicitacaoPrazoBaseRequestTest extends TestCase
{
    #[Test]
    public function individual_e_lote_aplicam_os_mesmos_erros_aos_campos_comuns(): void
    {
        $payload = [
            'TIPO_SOLICITACAO' => 'ALTERACAO',
            'DATA_PREVISTA_INICIO_NOVA' => '2026-08-10',
            'DATA_PREVISTA_FIM_NOVA' => '2026-08-09',
            'NOME_NOVO' => 'x',
            'JUSTIFICATIVA' => 'curta',
        ];

        $individual = $this->validator(TarefaSolicitacaoPrazoRequest::class, $payload);
        $lote = $this->validator(TarefaSolicitacaoPrazoLoteRequest::class, $payload + [
            'SELECIONAR_CONSULTA_COMPLETA' => '1',
        ]);

        foreach (['DATA_PREVISTA_FIM_NOVA', 'NOME_NOVO', 'JUSTIFICATIVA'] as $campo) {
            $this->assertSame($individual->errors()->get($campo), $lote->errors()->get($campo));
        }
    }

    #[Test]
    public function ambos_rejeitam_data_ambigua_em_vez_de_converte_la(): void
    {
        $payload = [
            'TIPO_SOLICITACAO' => 'ALTERACAO',
            'DATA_PREVISTA_INICIO_NOVA' => '10/08/2026',
            'JUSTIFICATIVA' => 'Justificativa suficientemente detalhada.',
        ];

        $individual = $this->validator(TarefaSolicitacaoPrazoRequest::class, $payload);
        $lote = $this->validator(TarefaSolicitacaoPrazoLoteRequest::class, $payload + [
            'SELECIONAR_CONSULTA_COMPLETA' => '1',
        ]);

        $this->assertTrue($individual->errors()->has('DATA_PREVISTA_INICIO_NOVA'));
        $this->assertTrue($lote->errors()->has('DATA_PREVISTA_INICIO_NOVA'));
    }

    /**
     * @param class-string<FormRequest> $requestClass
     * @param array<string, mixed> $payload
     */
    private function validator(string $requestClass, array $payload): LaravelValidator
    {
        $request = $requestClass::create('/tarefas/solicitacao-prazo', 'POST', $payload);
        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->invoke($request);
        $validator = Validator::make($request->all(), $request->rules(), $request->messages());
        $request->withValidator($validator);

        return $validator;
    }
}
```
</TESTS_UNIT_TAREFASOLICITACAOPRAZOBASEREQUESTTEST_PHP>

