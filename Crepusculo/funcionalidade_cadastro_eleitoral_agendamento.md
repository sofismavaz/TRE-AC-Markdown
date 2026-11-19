# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_cadastro_eleitoral_agendamento`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 22  
> **Tamanho do Arquivo:** 136 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Tarefas/TarefaAlertaAgendamentoController.php`
## <APP_HTTP_CONTROLLERS_TAREFAS_TAREFAALERTAAGENDAMENTOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Tarefas/TarefaAlertaAgendamentoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaAgendamentoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$row = DB::table('projeto')->select('id', 'nome as text')->where('id', $projetoId)->first();
DB::table('subprojeto')->select('id', 'nome as text')->whereIn('id', $subIds)->get()->all()
$row = DB::table('vw_unidade')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request)
public function create()
public function store(AgendarAlertaRequest $request): RedirectResponse
public function show(int $id)
public function edit(int $id)
public function update(AgendarAlertaRequest $request, int $id): RedirectResponse
public function clone(int $id)
public function storeClone(AgendarAlertaRequest $request, int $id): RedirectResponse
public function ativar(int $id): JsonResponse
public function inativar(int $id): JsonResponse
public function executarAgora(int $id): JsonResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Tarefas;

use App\Http\Controllers\Controller;

use App\Http\Requests\Tarefas\AgendarAlertaRequest;
use App\Jobs\Tarefas\EnviarAlertaTarefasJob;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaAuditoriaRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Services\EscopoUnidadeService;
use App\Services\Tarefas\TarefaAlertaAgendamentoService;
use App\Support\Exportacao\CamposPdfSelecionados;
use App\Support\Tarefas\TarefaAlertaAgendamentoStatus;
use App\Support\Tarefas\TarefaAlertaExecucaoStatus;
use App\Support\Tarefas\TarefaAlertaRecorrenciaTipo;
use App\Support\Tarefas\TarefaStatus;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class TarefaAlertaAgendamentoController extends Controller
{
    private const CAMPOS_PDF_LISTAGEM = ['id', 'nome', 'status', 'recorrencia', 'proxima_execucao', 'data_final', 'criador', 'responsavel', 'ultima_execucao', 'assunto'];
    private const CAMPOS_PDF_HISTORICO = ['id', 'origem', 'status', 'prevista', 'inicio', 'fim', 'tarefas', 'destinatarios', 'sucessos', 'falhas', 'solicitante', 'erros', 'destinatarios_individuais'];
    public function __construct(
        private readonly TarefaAlertaAgendamentoRepository $agendamentoRepo,
        private readonly TarefaAlertaExecucaoRepository    $execucaoRepo,
        private readonly TarefaAlertaAuditoriaRepository   $auditoriaRepo,
        private readonly TarefaAlertaAgendamentoService    $service,
        private readonly EscopoUnidadeService              $escopoUnidadeService
    ) {}

    // ─── Listagem ────────────────────────────────────────────────────────────

    public function index(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $filtros = $request->only(['status', 'criador_username', 'responsavel_username', 'recorrente', 'data_de', 'data_ate']);

        $agendamentos = $this->agendamentoRepo->listar(
            $this->macroprojetoAtivoIdSessao(),
            $filtros
        );

        return view('planejamento.tarefas.agendamentos.index', [
            'agendamentos'      => $agendamentos,
            'filtros'           => $filtros,
            'statusDisponiveis' => TarefaAlertaAgendamentoStatus::LABELS,
        ]);
    }

    // ─── Criar ───────────────────────────────────────────────────────────────

    public function create()
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        return view('planejamento.tarefas.agendamentos.form', [
            'agendamento'       => null,
            'statusTarefa'      => TarefaStatus::OPCOES,
            'statusPadrao'      => TarefaStatus::ALERTA_PADRAO,
            'recorrenciaTipos'  => TarefaAlertaRecorrenciaTipo::LABELS,
            'diasSemana'        => TarefaAlertaRecorrenciaTipo::DIAS_SEMANA,
            'labelsIniciais'    => [],
        ]);
    }

    public function store(AgendarAlertaRequest $request): RedirectResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $dados   = $request->validated();
        $usuario = session('user', []);
        $escopo  = $this->escopoAtual();

        $dados['macroprojeto_id']         = $this->macroprojetoAtivoIdSessao();
        $dados['filtros_json']            = $this->montarFiltrosJson($dados);
        $dados['tipos_destinatario_json'] = $this->montarTiposDestinatarioJson($dados);

        try {
            $this->service->criar($dados, $this->operador($usuario), $escopo);
        } catch (\InvalidArgumentException|RuntimeException $e) {
            return back()->withErrors(['agendamento' => $e->getMessage()])->withInput();
        }

        return redirect()
            ->route('tarefas.alertas.agendamentos.index')
            ->with('sucesso', 'Agendamento criado com sucesso.');
    }

    // ─── Visualizar ──────────────────────────────────────────────────────────

    public function show(int $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        return view('planejamento.tarefas.agendamentos.show', [
            'agendamento'      => $agendamento,
            'statusLabels'     => TarefaAlertaAgendamentoStatus::LABELS,
            'recorrenciaTipos' => TarefaAlertaRecorrenciaTipo::LABELS,
            'diasSemana'       => TarefaAlertaRecorrenciaTipo::DIAS_SEMANA,
        ]);
    }

    // ─── Editar ──────────────────────────────────────────────────────────────

    public function edit(int $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        $filtros = json_decode($agendamento->filtros_json ?? '{}', true) ?? [];

        return view('planejamento.tarefas.agendamentos.form', [
            'agendamento'      => $agendamento,
            'statusTarefa'     => TarefaStatus::OPCOES,
            'statusPadrao'     => TarefaStatus::ALERTA_PADRAO,
            'recorrenciaTipos' => TarefaAlertaRecorrenciaTipo::LABELS,
            'diasSemana'       => TarefaAlertaRecorrenciaTipo::DIAS_SEMANA,
            'labelsIniciais'   => $this->labelsIniciais($filtros),
        ]);
    }

    public function update(AgendarAlertaRequest $request, int $id): RedirectResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        $dados   = $request->validated();
        $usuario = session('user', []);
        $escopo  = $this->escopoAtual();

        $dados['macroprojeto_id']         = $this->macroprojetoAtivoIdSessao();
        $dados['filtros_json']            = $this->montarFiltrosJson($dados);
        $dados['tipos_destinatario_json'] = $this->montarTiposDestinatarioJson($dados);

        try {
            $this->service->editar($id, $dados, $this->operador($usuario), $escopo);
        } catch (\InvalidArgumentException|RuntimeException $e) {
            return back()->withErrors(['agendamento' => $e->getMessage()])->withInput();
        }

        return redirect()
            ->route('tarefas.alertas.agendamentos.show', $id)
            ->with('sucesso', 'Agendamento atualizado com sucesso.');
    }

    // ─── Clonar ──────────────────────────────────────────────────────────────

    public function clone(int $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $origem = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($origem);

        $filtros = json_decode($origem->filtros_json ?? '{}', true) ?? [];

        return view('planejamento.tarefas.agendamentos.form', [
            'agendamento'      => null,
            'clone'            => $origem,
            'statusTarefa'     => TarefaStatus::OPCOES,
            'statusPadrao'     => TarefaStatus::ALERTA_PADRAO,
            'recorrenciaTipos' => TarefaAlertaRecorrenciaTipo::LABELS,
            'diasSemana'       => TarefaAlertaRecorrenciaTipo::DIAS_SEMANA,
            'labelsIniciais'   => $this->labelsIniciais($filtros),
        ]);
    }

    public function storeClone(AgendarAlertaRequest $request, int $id): RedirectResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $origem = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($origem);

        $dados   = $request->validated();
        $usuario = session('user', []);
        $escopo  = $this->escopoAtual();

        $dados['macroprojeto_id']         = $this->macroprojetoAtivoIdSessao();
        $dados['filtros_json']            = $this->montarFiltrosJson($dados);
        $dados['tipos_destinatario_json'] = $this->montarTiposDestinatarioJson($dados);

        try {
            $novoId = $this->service->clonar($id, $dados, $this->operador($usuario), $escopo);
        } catch (\InvalidArgumentException|RuntimeException $e) {
            return back()->withErrors(['agendamento' => $e->getMessage()])->withInput();
        }

        return redirect()
            ->route('tarefas.alertas.agendamentos.show', $novoId)
            ->with('sucesso', 'Agendamento clonado com sucesso.');
    }

    // ─── Ativar / Inativar ───────────────────────────────────────────────────

    public function ativar(int $id): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        try {
            $this->service->ativar($id, $this->operador(session('user', [])));
            return response()->json(['mensagem' => 'Agendamento reativado com sucesso.']);
        } catch (RuntimeException $e) {
            return response()->json(['mensagem' => $e->getMessage()], 422);
        }
    }

    public function inativar(int $id): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        try {
            $this->service->inativar($id, $this->operador(session('user', [])));
            return response()->json(['mensagem' => 'Agendamento inativado.']);
        } catch (RuntimeException $e) {
            return response()->json(['mensagem' => $e->getMessage()], 422);
        }
    }

    // ─── Executar agora ──────────────────────────────────────────────────────

    public function executarAgora(int $id): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        $usuario = session('user', []);

        $execucaoId = $this->execucaoRepo->criar([
            'agendamento_id'          => $id,
            'origem'                  => 'manual',
            'status'                  => TarefaAlertaExecucaoStatus::PENDENTE,
            'data_hora_prevista'      => now(),
            'filtros_json'            => $agendamento->filtros_json,
            'tipos_destinatario_json' => $agendamento->tipos_destinatario_json,
            'escopo_json'             => $agendamento->escopo_json,
            'assunto'                 => $agendamento->assunto,
            'mensagem'                => $agendamento->mensagem,
            'solicitante_id'          => $usuario['id'] ?? null,
            'solicitante_username'    => $usuario['username'] ?? null,
            'solicitante_nome'        => $usuario['nome'] ?? null,
            'responsavel_username'    => $agendamento->responsavel_username,
            'responsavel_nome'        => $agendamento->responsavel_nome,
        ]);

        EnviarAlertaTarefasJob::dispatch($execucaoId);

        $this->auditoriaRepo->registrar($id, 'executar_agora', $this->operador($usuario), [
            'valores_depois_json' => json_encode(['execucao_id' => $execucaoId]),
        ]);

        return response()->json([
            'mensagem'    => 'Execução enfileirada. Acompanhe no histórico.',
            'execucao_id' => $execucaoId,
        ]);
    }

    // ─── Reprocessar ─────────────────────────────────────────────────────────

    public function reprocessar(int $execucaoId): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $execucao = $this->execucaoRepo->encontrarOuFalhar($execucaoId);

        $this->validarMacroExecucao($execucao);

        if (!TarefaAlertaExecucaoStatus::podeReprocessar($execucao->status)) {
            return response()->json([
                'mensagem' => 'Apenas execuções com status parcial ou falha podem ser reprocessadas.',
            ], 422);
        }

        $usuario = session('user', []);

        $this->execucaoRepo->atualizarStatus($execucaoId, TarefaAlertaExecucaoStatus::PENDENTE);

        EnviarAlertaTarefasJob::dispatch($execucaoId, true);

        $this->auditoriaRepo->registrar(
            $execucao->agendamento_id ? (int) $execucao->agendamento_id : null,
            'reprocessamento',
            $this->operador($usuario),
            ['valores_depois_json' => json_encode(['execucao_id' => $execucaoId])]
        );

        return response()->json([
            'mensagem'    => 'Reprocessamento enfileirado. Acompanhe no histórico.',
            'execucao_id' => $execucaoId,
        ]);
    }

    // ─── Histórico ───────────────────────────────────────────────────────────

    public function historico(int $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        $execucoes = $this->execucaoRepo->historicoDoAgendamento($id);
        foreach ($execucoes->items() as $execucao) {
            $execucao->detalhes = $this->execucaoRepo->detalhesDaExecucao((int) $execucao->id);
        }

        return view('planejamento.tarefas.agendamentos.historico', [
            'agendamento' => $agendamento,
            'execucoes'   => $execucoes,
            'statusLabels' => TarefaAlertaExecucaoStatus::LABELS,
        ]);
    }

    // ─── Exportar PDF ────────────────────────────────────────────────────────

    public function exportarPdf(Request $request)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        if ($request->query('tipo') === 'imediato') {
            $campos = CamposPdfSelecionados::resolver(
                $request->query('campos'),
                self::CAMPOS_PDF_HISTORICO,
                self::CAMPOS_PDF_HISTORICO,
            );
            return Pdf::loadView('planejamento.tarefas.agendamentos.pdf-historico', [
                'agendamento' => (object) ['nome' => 'Envios imediatos'],
                'execucoes' => $this->execucaoRepo->todasImediatas($this->macroprojetoAtivoIdSessao()),
                'statusLabels' => TarefaAlertaExecucaoStatus::LABELS,
                'geradoEm' => now()->format('d/m/Y H:i'),
                'campos' => $campos,
            ])->setPaper('a4', 'landscape')->download('historico-envios-imediatos.pdf');
        }

        $filtros = $request->only(['status', 'criador_username', 'responsavel_username', 'recorrente', 'data_de', 'data_ate']);
        $campos = CamposPdfSelecionados::resolver(
            $request->query('campos'),
            self::CAMPOS_PDF_LISTAGEM,
            self::CAMPOS_PDF_LISTAGEM,
        );
        $agendamentos = $this->agendamentoRepo->listarTodos($this->macroprojetoAtivoIdSessao(), $filtros);

        return Pdf::loadView('planejamento.tarefas.agendamentos.pdf-listagem', [
            'agendamentos' => $agendamentos,
            'statusLabels' => TarefaAlertaAgendamentoStatus::LABELS,
            'geradoEm' => now()->format('d/m/Y H:i'),
            'campos' => $campos,
        ])->setPaper('a4', 'landscape')->download('agendamentos-alertas.pdf');
    }

    public function historicoExportarPdf(Request $request, int $id)
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());
        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);
        $campos = CamposPdfSelecionados::resolver(
            $request->query('campos'),
            self::CAMPOS_PDF_HISTORICO,
            self::CAMPOS_PDF_HISTORICO,
        );

        return Pdf::loadView('planejamento.tarefas.agendamentos.pdf-historico', [
            'agendamento' => $agendamento,
            'execucoes' => $this->execucaoRepo->todasDoAgendamento($id),
            'statusLabels' => TarefaAlertaExecucaoStatus::LABELS,
            'geradoEm' => now()->format('d/m/Y H:i'),
            'campos' => $campos,
        ])->setPaper('a4', 'landscape')->download('historico-agendamento-' . $id . '.pdf');
    }

    // ─── Excluir ─────────────────────────────────────────────────────────────

    public function destroy(int $id): JsonResponse
    {
        $this->autorizarRotaMacro($this->macroprojetoAtivoIdSessao());

        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);
        $this->garantirMesmoMacro($agendamento);

        $this->service->excluir($id, $this->operador(session('user', [])));

        return response()->json(['mensagem' => 'Agendamento e todo seu histórico foram removidos permanentemente.']);
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private function garantirMesmoMacro(object $agendamento): void
    {
        if ((int) $agendamento->macroprojeto_id !== $this->macroprojetoAtivoIdSessao()) {
            abort(403, 'Agendamento não pertence ao macroprojeto ativo.');
        }
    }

    private function validarMacroExecucao(object $execucao): void
    {
        $macroSessao = $this->macroprojetoAtivoIdSessao();

        if ($execucao->agendamento_id !== null) {
            $ag = $this->agendamentoRepo->encontrar((int) $execucao->agendamento_id);
            if ($ag !== null && (int) $ag->macroprojeto_id !== $macroSessao) {
                abort(403, 'Execução não pertence ao macroprojeto ativo.');
            }
            return;
        }

        $escopo = json_decode($execucao->escopo_json ?? '{}', true) ?? [];
        if (!empty($escopo['macroprojeto_id']) && (int) $escopo['macroprojeto_id'] !== $macroSessao) {
            abort(403, 'Execução não pertence ao macroprojeto ativo.');
        }
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

    private function montarFiltrosJson(array $dados): string
    {
        return json_encode(array_filter([
            'status'                  => $dados['status'] ?? null,
            'data_prevista_inicio_de' => $dados['data_prevista_inicio_de'] ?? null,
            'data_prevista_fim_ate'   => $dados['data_prevista_fim_ate'] ?? null,
            'projeto_id'              => $dados['projeto_id'] ?? null,
            'subprojeto_id'           => $dados['subprojeto_id'] ?? null,
            'unidade_id'              => $dados['unidade_id'] ?? null,
        ], static fn ($v) => $v !== null && $v !== '' && $v !== []));
    }

    private function montarTiposDestinatarioJson(array $dados): string
    {
        $tipos = [];
        if (!empty($dados['incluir_unidade_tarefa']))    $tipos[] = 'unidade_tarefa';
        if (!empty($dados['incluir_unidade_subprojeto'])) $tipos[] = 'unidade_subprojeto';
        if (!empty($dados['incluir_unidade_projeto']))   $tipos[] = 'unidade_projeto';
        return json_encode($tipos);
    }

    private function operador(array $usuario): array
    {
        return [
            'id'       => $usuario['id'] ?? null,
            'username' => $usuario['username'] ?? null,
            'nome'     => $usuario['nome'] ?? ($usuario['username'] ?? null),
        ];
    }

    /** Busca os labels ({id, text}) para os IDs salvos nos filtros, para pre-popular os Select2. */
    private function labelsIniciais(array $filtros): array
    {
        $labels = ['projeto' => null, 'subprojetos' => [], 'unidade' => null];

        $projetoId = isset($filtros['projeto_id']) ? (int) $filtros['projeto_id'] : 0;
        if ($projetoId > 0) {
            $row = DB::table('projeto')->select('id', 'nome as text')->where('id', $projetoId)->first();
            if ($row) {
                $labels['projeto'] = ['id' => (int) $row->id, 'text' => $row->text];
            }
        }

        $subIds = array_filter(array_map('intval', (array) ($filtros['subprojeto_id'] ?? [])));
        if (!empty($subIds)) {
            $labels['subprojetos'] = array_map(
                static fn ($r) => ['id' => (int) $r->id, 'text' => $r->text],
                DB::table('subprojeto')->select('id', 'nome as text')->whereIn('id', $subIds)->get()->all()
            );
        }

        $unidadeId = isset($filtros['unidade_id']) ? (int) $filtros['unidade_id'] : 0;
        if ($unidadeId > 0) {
            $row = DB::table('vw_unidade')
                ->selectRaw("ID_UNIDADE as id, SIGLA || ' - ' || DESCRICAO as text")
                ->where('id_unidade', $unidadeId)
                ->first();
            if ($row) {
                $labels['unidade'] = ['id' => (int) $row->id, 'text' => $row->text];
            }
        }

        return $labels;
    }
}
```
</APP_HTTP_CONTROLLERS_TAREFAS_TAREFAALERTAAGENDAMENTOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Tarefas/TarefaAlertaAgendamentoRepository.php`
## <APP_REPOSITORIES_TAREFAS_TAREFAALERTAAGENDAMENTOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Tarefas/TarefaAlertaAgendamentoRepository.php`
- **Namespace Declaração:** `App\Repositories\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaAgendamentoRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('tarefa_alerta_agendamento as a')
DB::table('tarefa_alerta_execucao as e')
return DB::table('tarefa_alerta_agendamento')->where('id', $id)->first();
DB::table('tarefa_alerta_agendamento')
$query = DB::table('tarefa_alerta_agendamento')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function listar(int $macroprojetoId, array $filtros = [], int $porPagina = 20): LengthAwarePaginator
public function listarTodos(int $macroprojetoId, array $filtros = []): Collection
private function consultaListagem(int $macroprojetoId, array $filtros): Builder
public function encontrar(int $id): ?object
public function encontrarOuFalhar(int $id): object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): void
public function excluir(int $id): void
public function buscarVencidos(): Collection
public function buscarAtivosDoMacro(int $macroprojetoId, ?int $excluirId = null): Collection
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
use App\Support\Tarefas\TarefaAlertaAgendamentoStatus;
use Illuminate\Database\Query\Builder;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class TarefaAlertaAgendamentoRepository
{
    use AuditaDml;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function listar(int $macroprojetoId, array $filtros = [], int $porPagina = 20): LengthAwarePaginator
    {
        return $this->consultaListagem($macroprojetoId, $filtros)->paginate($porPagina);
    }

    public function listarTodos(int $macroprojetoId, array $filtros = []): Collection
    {
        return collect($this->consultaListagem($macroprojetoId, $filtros)->get());
    }

    private function consultaListagem(int $macroprojetoId, array $filtros): Builder
    {
        $query = DB::table('tarefa_alerta_agendamento as a')
            ->select('a.*')
            ->selectSub(
                DB::table('tarefa_alerta_execucao as e')
                    ->selectRaw('MAX(e.dt_criacao)')
                    ->whereColumn('e.agendamento_id', 'a.id'),
                'ultima_execucao'
            )
            ->where('a.macroprojeto_id', $macroprojetoId)
            ->orderBy('a.proxima_execucao')
            ->orderByDesc('a.dt_criacao');

        if (!empty($filtros['status'])) {
            $query->whereIn('a.status', (array) $filtros['status']);
        }
        if (!empty($filtros['criador_username'])) {
            $query->whereRaw('UPPER(a.criador_username) = ?', [mb_strtoupper($filtros['criador_username'])]);
        }
        if (!empty($filtros['responsavel_username'])) {
            $query->whereRaw('UPPER(a.responsavel_username) = ?', [mb_strtoupper($filtros['responsavel_username'])]);
        }
        if (isset($filtros['recorrente']) && $filtros['recorrente'] !== '') {
            $query->where('a.recorrente', (int) $filtros['recorrente']);
        }
        if (!empty($filtros['data_de'])) {
            $query->whereRaw("a.data_hora_agendado >= TO_DATE(?, 'YYYY-MM-DD')", [$filtros['data_de']]);
        }
        if (!empty($filtros['data_ate'])) {
            $query->whereRaw("a.data_hora_agendado < TO_DATE(?, 'YYYY-MM-DD') + 1", [$filtros['data_ate']]);
        }

        return $query;
    }

    public function encontrar(int $id): ?object
    {
        return DB::table('tarefa_alerta_agendamento')->where('id', $id)->first();
    }

    public function encontrarOuFalhar(int $id): object
    {
        $registro = $this->encontrar($id);
        if ($registro === null) {
            throw new \App\Exceptions\RegistroNaoEncontradoException('Agendamento não encontrado.');
        }
        return $registro;
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'tarefa_alerta_agendamento',
            'TAREFA_ALERTA_AGENDAMENTO',
            $dados + ['dt_criacao' => DB::raw('SYSDATE')],
            'id',
            'id'
        );
    }

    public function atualizar(int $id, array $dados): void
    {
        $this->atualizarAuditadoPorId(
            'tarefa_alerta_agendamento',
            'TAREFA_ALERTA_AGENDAMENTO',
            'id',
            $id,
            $dados + ['dt_atualizacao' => DB::raw('SYSDATE')]
        );
    }

    public function excluir(int $id): void
    {
        $this->removerAuditadoPorId('tarefa_alerta_agendamento', 'TAREFA_ALERTA_AGENDAMENTO', 'id', $id);
    }

    public function buscarVencidos(): Collection
    {
        return collect(
            DB::table('tarefa_alerta_agendamento')
                ->where('status', TarefaAlertaAgendamentoStatus::ATIVO)
                ->whereRaw('proxima_execucao <= SYSDATE')
                ->whereNotNull('proxima_execucao')
                ->get()
        );
    }

    public function buscarAtivosDoMacro(int $macroprojetoId, ?int $excluirId = null): Collection
    {
        $query = DB::table('tarefa_alerta_agendamento')
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('status', TarefaAlertaAgendamentoStatus::ATIVO);

        if ($excluirId !== null) {
            $query->where('id', '!=', $excluirId);
        }

        return collect($query->get());
    }
}
```
</APP_REPOSITORIES_TAREFAS_TAREFAALERTAAGENDAMENTOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Tarefas/TarefaAlertaAgendamentoService.php`
## <APP_SERVICES_TAREFAS_TAREFAALERTAAGENDAMENTOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Tarefas/TarefaAlertaAgendamentoService.php`
- **Namespace Declaração:** `App\Services\Tarefas`
- **Entidade / Classe:** `class TarefaAlertaAgendamentoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function criar(array $dados, array $operador, array $escopoAtual): int
public function editar(int $id, array $dados, array $operador, array $escopoAtual): void
public function clonar(int $idOrigem, array $dadosNovos, array $operador, array $escopoAtual): int
public function ativar(int $id, array $operador): void
public function inativar(int $id, array $operador): void
public function concluir(int $id): void
public function avancarProximaExecucao(object $agendamento, string $execucaoStatus): void
public function excluir(int $id, array $operador): void
private function calcularPrimeiraOcorrencia(Carbon $base, array $dados): Carbon
private function validarDataFinal(Carbon $primeiraOcorrencia, array $dados): void
private function calcularProximaRecorrenciaApos(Carbon $atual, object $agendamento): ?Carbon
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Tarefas;

use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaAuditoriaRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Support\Tarefas\TarefaAlertaAgendamentoStatus;
use App\Support\Tarefas\TarefaAlertaExecucaoStatus;
use App\Support\Tarefas\TarefaAlertaRecorrenciaTipo;
use Carbon\Carbon;
use InvalidArgumentException;
use RuntimeException;

class TarefaAlertaAgendamentoService
{
    public function __construct(
        private readonly TarefaAlertaAgendamentoRepository $agendamentoRepo,
        private readonly TarefaAlertaAuditoriaRepository   $auditoriaRepo,
        private readonly TarefaAlertaRecorrenciaService    $recorrencia,
        private readonly TarefaAlertaExecucaoRepository    $execucaoRepo,
        private readonly TarefaAlertaDuplicidadeService    $duplicidade,
    ) {}

    // ─── Criar ───────────────────────────────────────────────────────────────

    public function criar(array $dados, array $operador, array $escopoAtual): int
    {
        $dataHora = $this->parsarDataHora($dados['data_hora_envio_agendado']);

        if (!$this->recorrencia->eDataHoraFutura($dataHora)) {
            throw new InvalidArgumentException('A data e hora do agendamento devem ser futuras.');
        }

        $primeiraOcorrencia = $this->calcularPrimeiraOcorrencia($dataHora, $dados);
        $this->validarDataFinal($primeiraOcorrencia, $dados);

        $registro = $this->montarRegistro($dados, $dataHora, $primeiraOcorrencia, $operador, $escopoAtual);
        $this->duplicidade->validar($registro, $escopoAtual);

        $id = $this->agendamentoRepo->criar($registro);

        $this->auditoriaRepo->registrar($id, 'criacao', $operador, [
            'valores_depois_json' => json_encode($registro),
            'escopo_depois_json'  => json_encode($escopoAtual),
        ]);

        return $id;
    }

    // ─── Editar ──────────────────────────────────────────────────────────────

    public function editar(int $id, array $dados, array $operador, array $escopoAtual): void
    {
        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);

        $dataHora = $this->parsarDataHora($dados['data_hora_envio_agendado']);

        if (!$this->recorrencia->eDataHoraFutura($dataHora)) {
            throw new InvalidArgumentException('A data e hora do agendamento devem ser futuras.');
        }

        $primeiraOcorrencia = $this->calcularPrimeiraOcorrencia($dataHora, $dados);
        $this->validarDataFinal($primeiraOcorrencia, $dados);

        $antes = (array) $agendamento;
        $registro = $this->montarRegistro($dados, $dataHora, $primeiraOcorrencia, $operador, $escopoAtual);

        // A autoria original permanece; o editor passa a ser o responsável atual.
        $registro['criador_id'] = $agendamento->criador_id;
        $registro['criador_username'] = $agendamento->criador_username;
        $registro['criador_nome'] = $agendamento->criador_nome;

        // Edição não reativa agendamento inativo ou concluído.
        $registro['status'] = $agendamento->status;

        $registro['responsavel_username'] = $operador['username'] ?? null;
        $registro['responsavel_nome']     = $operador['nome'] ?? null;

        $this->duplicidade->validar($registro, $escopoAtual, $id);

        $this->agendamentoRepo->atualizar($id, $registro);

        $this->auditoriaRepo->registrar($id, 'edicao', $operador, [
            'valores_antes_json'  => json_encode($antes),
            'valores_depois_json' => json_encode($registro),
            'escopo_antes_json'   => $agendamento->escopo_json,
            'escopo_depois_json'  => json_encode($escopoAtual),
        ]);
    }

    // ─── Clonar ──────────────────────────────────────────────────────────────

    public function clonar(int $idOrigem, array $dadosNovos, array $operador, array $escopoAtual): int
    {
        $origem = $this->agendamentoRepo->encontrarOuFalhar($idOrigem);

        $dadosMesclados = array_merge(
            [
                'filtros_json'            => $origem->filtros_json,
                'tipos_destinatario_json' => $origem->tipos_destinatario_json,
                'assunto'                 => $origem->assunto,
                'mensagem'                => $origem->mensagem,
                'recorrente'              => $origem->recorrente,
                'recorrencia_tipo'        => $origem->recorrencia_tipo,
                'recorrencia_dia'         => $origem->recorrencia_dia,
                'data_final'              => null,
                'nome'                    => $origem->nome . ' (clone)',
            ],
            $dadosNovos
        );

        $id = $this->criar($dadosMesclados, $operador, $escopoAtual);

        $this->auditoriaRepo->registrar($id, 'clonagem', $operador, [
            'valores_antes_json'  => json_encode(['origem_id' => $idOrigem]),
            'escopo_depois_json'  => json_encode($escopoAtual),
        ]);

        return $id;
    }

    // ─── Estados ─────────────────────────────────────────────────────────────

    public function ativar(int $id, array $operador): void
    {
        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);

        if (!TarefaAlertaAgendamentoStatus::podeReativar($agendamento->status)) {
            throw new RuntimeException('Apenas agendamentos inativos podem ser reativados.');
        }

        $proxima = $this->calcularProximaOcorrenciaAtivacao($agendamento);
        if ($proxima === null) {
            throw new RuntimeException('Não existe próxima ocorrência futura dentro da vigência do agendamento.');
        }

        $this->agendamentoRepo->atualizar($id, [
            'status'          => TarefaAlertaAgendamentoStatus::ATIVO,
            'proxima_execucao' => $proxima?->format('Y-m-d H:i:s'),
        ]);

        $this->auditoriaRepo->registrar($id, 'ativacao', $operador);
    }

    public function inativar(int $id, array $operador): void
    {
        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);

        if (!TarefaAlertaAgendamentoStatus::podeInativar($agendamento->status)) {
            throw new RuntimeException('Apenas agendamentos ativos podem ser inativados.');
        }

        $this->agendamentoRepo->atualizar($id, [
            'status' => TarefaAlertaAgendamentoStatus::INATIVO,
        ]);

        $this->auditoriaRepo->registrar($id, 'inativacao', $operador);
    }

    public function concluir(int $id): void
    {
        $this->agendamentoRepo->atualizar($id, [
            'status'           => TarefaAlertaAgendamentoStatus::CONCLUIDO,
            'proxima_execucao' => null,
        ]);
    }

    /**
     * Avança a proxima_execucao após uma ocorrência ser processada.
     * Agendamentos não-recorrentes só são concluídos quando a execução foi CONCLUIDA.
     * Se não houver próxima dentro da data_final, conclui o agendamento.
     */
    public function avancarProximaExecucao(object $agendamento, string $execucaoStatus): void
    {
        if (!(bool) $agendamento->recorrente) {
            if ($execucaoStatus === TarefaAlertaExecucaoStatus::CONCLUIDA) {
                $this->concluir((int) $agendamento->id);
            }
            return;
        }

        $atual = Carbon::parse($agendamento->proxima_execucao, $this->recorrencia->timezone());
        $proxima = $this->calcularProximaRecorrenciaApos($atual, $agendamento);

        if ($proxima === null) {
            $this->concluir((int) $agendamento->id);
            return;
        }

        $this->agendamentoRepo->atualizar((int) $agendamento->id, [
            'proxima_execucao' => $proxima->format('Y-m-d H:i:s'),
        ]);
    }

    // ─── Excluir ─────────────────────────────────────────────────────────────

    public function excluir(int $id, array $operador): void
    {
        $agendamento = $this->agendamentoRepo->encontrarOuFalhar($id);

        $execucoes = $this->execucaoRepo->todasDoAgendamento($id);
        $snapshot  = json_encode([
            'agendamento' => (array) $agendamento,
            'execucoes'   => $execucoes,
        ]);

        $this->auditoriaRepo->registrar(null, 'exclusao', $operador, [
            'valores_antes_json' => $snapshot,
            'escopo_antes_json'  => $agendamento->escopo_json,
            'snapshot_json'      => $snapshot,
        ]);

        // A FK com ON DELETE CASCADE remove execuções, destinatários, tentativas e tarefas.
        $this->agendamentoRepo->excluir($id);
    }

    // ─── Helpers de recorrência ───────────────────────────────────────────────

    private function calcularPrimeiraOcorrencia(Carbon $base, array $dados): Carbon
    {
        if (empty($dados['recorrente'])) {
            return $base;
        }

        $tipo = $dados['recorrencia_tipo'] ?? null;
        $dia  = (int) ($dados['recorrencia_dia'] ?? 0);

        return match ($tipo) {
            TarefaAlertaRecorrenciaTipo::SEMANAL => $this->recorrencia->primeiraOcorrenciaSemanal($base, $dia),
            TarefaAlertaRecorrenciaTipo::MENSAL  => $this->recorrencia->primeiraOcorrenciaMensal($base, $dia),
            default => $base,
        };
    }

    private function validarDataFinal(Carbon $primeiraOcorrencia, array $dados): void
    {
        if (empty($dados['recorrente'])) {
            return;
        }

        if (empty($dados['data_final'])) {
            throw new InvalidArgumentException('Agendamentos recorrentes exigem data final.');
        }

        $dataFinal = Carbon::parse($dados['data_final'], $this->recorrencia->timezone())
            ->setTime(23, 59, 59);

        if ($primeiraOcorrencia->gt($dataFinal)) {
            throw new InvalidArgumentException(
                'A data final é anterior à primeira ocorrência ajustada.'
            );
        }
    }

    private function calcularProximaRecorrenciaApos(Carbon $atual, object $agendamento): ?Carbon
    {
        $tipo = $agendamento->recorrencia_tipo;
        $dia  = (int) ($agendamento->recorrencia_dia ?? 0);

        $proxima = match ($tipo) {
            TarefaAlertaRecorrenciaTipo::SEMANAL => $this->recorrencia->proximaOcorrenciaSemanal($atual),
            TarefaAlertaRecorrenciaTipo::MENSAL  => $this->recorrencia->proximaOcorrenciaMensal($atual, $dia),
            default => null,
        };

        if ($proxima === null) {
            return null;
        }

        if (!empty($agendamento->data_final)) {
            $limite = Carbon::parse($agendamento->data_final, $this->recorrencia->timezone())->setTime(23, 59, 59);
            if ($proxima->gt($limite)) {
                return null;
            }
        }

        return $proxima;
    }

    private function calcularProximaOcorrenciaAtivacao(object $agendamento): ?Carbon
    {
        if (!(bool) $agendamento->recorrente) {
            $base = Carbon::parse($agendamento->data_hora_agendado, $this->recorrencia->timezone());
            return $this->recorrencia->eDataHoraFutura($base) ? $base : null;
        }

        $tipo = $agendamento->recorrencia_tipo;
        $dia  = (int) ($agendamento->recorrencia_dia ?? 0);
        $agora = Carbon::now($this->recorrencia->timezone());
        $horaOriginal = Carbon::parse($agendamento->data_hora_agendado, $this->recorrencia->timezone());
        $base = $agora->copy()->setTime($horaOriginal->hour, $horaOriginal->minute, $horaOriginal->second);

        $proxima = match ($tipo) {
            TarefaAlertaRecorrenciaTipo::SEMANAL => $this->recorrencia->primeiraOcorrenciaSemanal($base, $dia),
            TarefaAlertaRecorrenciaTipo::MENSAL  => $this->recorrencia->primeiraOcorrenciaMensal($base, $dia),
            default => null,
        };

        if ($proxima !== null && !$proxima->gt($agora)) {
            $proxima = match ($tipo) {
                TarefaAlertaRecorrenciaTipo::SEMANAL => $this->recorrencia->proximaOcorrenciaSemanal($proxima),
                TarefaAlertaRecorrenciaTipo::MENSAL => $this->recorrencia->proximaOcorrenciaMensal($proxima, $dia),
                default => null,
            };
        }

        if ($proxima === null) {
            return null;
        }

        if (!empty($agendamento->data_final)) {
            $limite = Carbon::parse($agendamento->data_final, $this->recorrencia->timezone())->setTime(23, 59, 59);
            if ($proxima->gt($limite)) {
                return null;
            }
        }

        return $proxima;
    }

    private function montarRegistro(
        array  $dados,
        Carbon $dataHora,
        Carbon $primeiraOcorrencia,
        array  $operador,
        array  $escopoAtual
    ): array {
        $recorrente = !empty($dados['recorrente']) ? 1 : 0;

        return [
            'macroprojeto_id'         => (int) ($dados['macroprojeto_id']),
            'nome'                    => $dados['nome'],
            'status'                  => TarefaAlertaAgendamentoStatus::ATIVO,
            'filtros_json'            => is_string($dados['filtros_json'] ?? null)
                ? $dados['filtros_json']
                : json_encode($dados['filtros'] ?? []),
            'tipos_destinatario_json' => is_string($dados['tipos_destinatario_json'] ?? null)
                ? $dados['tipos_destinatario_json']
                : json_encode($dados['tipos_destinatario'] ?? []),
            'assunto'                 => $dados['assunto'],
            'mensagem'                => $dados['mensagem'] ?? null,
            'data_hora_agendado'      => $dataHora->format('Y-m-d H:i:s'),
            'recorrente'              => $recorrente,
            'recorrencia_tipo'        => $recorrente ? ($dados['recorrencia_tipo'] ?? null) : null,
            'recorrencia_dia'         => $recorrente ? ((int) ($dados['recorrencia_dia'] ?? 0)) : null,
            'data_final'              => $recorrente ? ($dados['data_final'] ?? null) : null,
            'proxima_execucao'        => $primeiraOcorrencia->format('Y-m-d H:i:s'),
            'escopo_json'             => json_encode($escopoAtual),
            'criador_id'              => $operador['id'] ?? null,
            'criador_username'        => $operador['username'] ?? null,
            'criador_nome'            => $operador['nome'] ?? null,
            'responsavel_id'          => $operador['id'] ?? null,
            'responsavel_username'    => $operador['username'] ?? null,
            'responsavel_nome'        => $operador['nome'] ?? null,
        ];
    }

    private function parsarDataHora(string $valor): Carbon
    {
        return Carbon::parse($valor, $this->recorrencia->timezone());
    }
}
```
</APP_SERVICES_TAREFAS_TAREFAALERTAAGENDAMENTOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Tarefas/TarefaAlertaAgendamentoStatus.php`
## <APP_SUPPORT_TAREFAS_TAREFAALERTAAGENDAMENTOSTATUS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Tarefas/TarefaAlertaAgendamentoStatus.php`
- **Namespace Declaração:** `App\Support\Tarefas`
- **Entidade / Classe:** `final class TarefaAlertaAgendamentoStatus`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function label(string $status): string
public static function podeReativar(string $status): bool
public static function podeInativar(string $status): bool
public static function podeConcluir(string $status): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Tarefas;

final class TarefaAlertaAgendamentoStatus
{
    public const ATIVO = 'ativo';
    public const INATIVO = 'inativo';
    public const CONCLUIDO = 'concluido';

    public const TODOS = [self::ATIVO, self::INATIVO, self::CONCLUIDO];

    public const LABELS = [
        self::ATIVO    => 'Ativo',
        self::INATIVO  => 'Inativo',
        self::CONCLUIDO => 'Concluído',
    ];

    public static function label(string $status): string
    {
        return self::LABELS[$status] ?? $status;
    }

    public static function podeReativar(string $status): bool
    {
        return $status === self::INATIVO;
    }

    public static function podeInativar(string $status): bool
    {
        return $status === self::ATIVO;
    }

    public static function podeConcluir(string $status): bool
    {
        return $status === self::ATIVO;
    }
}
```
</APP_SUPPORT_TAREFAS_TAREFAALERTAAGENDAMENTOSTATUS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_160000_create_cad_agendamento_nucleo_tables.php`
## <DATABASE_MIGRATIONS_2026_04_02_160000_CREATE_CAD_AGENDAMENTO_NUCLEO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_160000_create_cad_agendamento_nucleo_tables.php`
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
CREATE TABLE cad_unidade (
    id_unidade             NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome                   VARCHAR2(120 CHAR) NOT NULL,
    zona_eleitoral         VARCHAR2(20 CHAR)  NOT NULL,
    endereco               VARCHAR2(200 CHAR) NOT NULL,
    cod_objeto_localidade  VARCHAR2(30 CHAR)  NOT NULL,
    hora_abertura          VARCHAR2(5 CHAR)   NOT NULL,
    hora_fechamento        VARCHAR2(5 CHAR)   NOT NULL,
    intervalo_inicio       VARCHAR2(5 CHAR),
    intervalo_fim          VARCHAR2(5 CHAR),
    ativo                  CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT ck_cu_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_cu_cod_obj_loc ON cad_unidade (cod_objeto_localidade)');

        DB::statement(<<<'SQL'
CREATE TABLE cad_regra_unidade (
    id_unidade             NUMBER NOT NULL,
    tolerancia_atraso_min  NUMBER(3) DEFAULT 10 NOT NULL,
    cancel_min_antes       NUMBER(4) DEFAULT 120 NOT NULL,
    perc_reserva_prior     NUMBER(5,2) DEFAULT 0 NOT NULL,
    encaixe_manual         CHAR(1 CHAR) DEFAULT 'N' NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT pk_cad_reg_unid PRIMARY KEY (id_unidade),
    CONSTRAINT fk_cru_unidade FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT ck_cru_tol CHECK (tolerancia_atraso_min >= 0),
    CONSTRAINT ck_cru_canc CHECK (cancel_min_antes >= 0),
    CONSTRAINT ck_cru_perc CHECK (perc_reserva_prior BETWEEN 0 AND 100),
    CONSTRAINT ck_cru_enc CHECK (encaixe_manual IN ('S','N'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_guiche (
    id_guiche              NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade             NUMBER NOT NULL,
    codigo                 VARCHAR2(20 CHAR) NOT NULL,
    tipo                   VARCHAR2(20 CHAR) NOT NULL,
    ativo                  CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT fk_cg_unidade FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT uk_cg_unid_cod UNIQUE (id_unidade, codigo),
    CONSTRAINT ck_cg_tipo CHECK (tipo IN ('COMUM','BIOMETRICO')),
    CONSTRAINT ck_cg_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_servico (
    id_servico             NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo                 VARCHAR2(40 CHAR) NOT NULL,
    nome                   VARCHAR2(120 CHAR) NOT NULL,
    duracao_minutos        NUMBER(4) NOT NULL,
    exige_biometria        CHAR(1 CHAR) DEFAULT 'N' NOT NULL,
    ativo                  CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT uk_cs_codigo UNIQUE (codigo),
    CONSTRAINT ck_cs_dur CHECK (duracao_minutos > 0),
    CONSTRAINT ck_cs_bio CHECK (exige_biometria IN ('S','N')),
    CONSTRAINT ck_cs_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_documento (
    id_documento           NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo                 VARCHAR2(40 CHAR) NOT NULL,
    nome                   VARCHAR2(120 CHAR) NOT NULL,
    ativo                  CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    CONSTRAINT uk_cd_codigo UNIQUE (codigo),
    CONSTRAINT ck_cd_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_servico_documento (
    id_servico             NUMBER NOT NULL,
    id_documento           NUMBER NOT NULL,
    obrigatorio            CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_cad_srv_doc PRIMARY KEY (id_servico, id_documento),
    CONSTRAINT fk_csd_serv FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico),
    CONSTRAINT fk_csd_doc FOREIGN KEY (id_documento) REFERENCES cad_documento (id_documento),
    CONSTRAINT ck_csd_obr CHECK (obrigatorio IN ('S','N'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_servico_guiche (
    id_servico             NUMBER NOT NULL,
    id_guiche              NUMBER NOT NULL,
    CONSTRAINT pk_cad_srv_gui PRIMARY KEY (id_servico, id_guiche),
    CONSTRAINT fk_csg_serv FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico),
    CONSTRAINT fk_csg_gui FOREIGN KEY (id_guiche) REFERENCES cad_guiche (id_guiche)
)
SQL
        );
    }

    public function down(): void
    {
        DB::statement('DROP TABLE cad_servico_guiche');
        DB::statement('DROP TABLE cad_servico_documento');
        DB::statement('DROP TABLE cad_documento');
        DB::statement('DROP TABLE cad_servico');
        DB::statement('DROP TABLE cad_guiche');
        DB::statement('DROP TABLE cad_regra_unidade');
        DB::statement('DROP INDEX ix_cu_cod_obj_loc');
        DB::statement('DROP TABLE cad_unidade');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_160000_CREATE_CAD_AGENDAMENTO_NUCLEO_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_160100_create_cad_agendamento_operacao_tables.php`
## <DATABASE_MIGRATIONS_2026_04_02_160100_CREATE_CAD_AGENDAMENTO_OPERACAO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_160100_create_cad_agendamento_operacao_tables.php`
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
CREATE TABLE cad_eleitor (
    id_eleitor             NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    cpf                    VARCHAR2(11 CHAR) NOT NULL,
    nome                   VARCHAR2(160 CHAR) NOT NULL,
    dt_nascimento          DATE NOT NULL,
    telefone               VARCHAR2(20 CHAR),
    email                  VARCHAR2(120 CHAR),
    titulo_eleitor         VARCHAR2(20 CHAR),
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT uk_ce_cpf UNIQUE (cpf)
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_bloqueio_agenda (
    id_bloqueio            NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade             NUMBER NOT NULL,
    id_guiche              NUMBER,
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE NOT NULL,
    tipo                   VARCHAR2(30 CHAR) NOT NULL,
    motivo                 VARCHAR2(300 CHAR),
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_cba_unid FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT fk_cba_gui FOREIGN KEY (id_guiche) REFERENCES cad_guiche (id_guiche),
    CONSTRAINT ck_cba_tipo CHECK (tipo IN ('MANUTENCAO','PERIODO_ELEITORAL','FERIADO','OUTRO')),
    CONSTRAINT ck_cba_per CHECK (dt_fim > dt_inicio)
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_slot_agenda (
    id_slot                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade             NUMBER NOT NULL,
    id_guiche              NUMBER NOT NULL,
    id_servico             NUMBER NOT NULL,
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE NOT NULL,
    status                 VARCHAR2(20 CHAR) NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT fk_csa_unid FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT fk_csa_gui FOREIGN KEY (id_guiche) REFERENCES cad_guiche (id_guiche),
    CONSTRAINT fk_csa_serv FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico),
    CONSTRAINT ck_csa_per CHECK (dt_fim > dt_inicio),
    CONSTRAINT ck_csa_status CHECK (status IN ('DISPONIVEL','RESERVADO','BLOQUEADO'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_agendamento (
    id_agendamento         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_slot                NUMBER NOT NULL,
    id_eleitor             NUMBER NOT NULL,
    protocolo              VARCHAR2(30 CHAR) NOT NULL,
    status                 VARCHAR2(20 CHAR) NOT NULL,
    origem                 VARCHAR2(10 CHAR) NOT NULL,
    motivo_cancelamento    VARCHAR2(300 CHAR),
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT fk_cag_slot FOREIGN KEY (id_slot) REFERENCES cad_slot_agenda (id_slot),
    CONSTRAINT fk_cag_eleitor FOREIGN KEY (id_eleitor) REFERENCES cad_eleitor (id_eleitor),
    CONSTRAINT uk_cag_slot UNIQUE (id_slot),
    CONSTRAINT uk_cag_prot UNIQUE (protocolo),
    CONSTRAINT ck_cag_status CHECK (status IN ('AGENDADO','CONFIRMADO','CHECKIN','CONCLUIDO','CANCELADO','NO_SHOW')),
    CONSTRAINT ck_cag_origem CHECK (origem IN ('WEB','BALCAO','ADMIN'))
)
SQL
        );

        DB::statement(<<<'SQL'
CREATE TABLE cad_restricao_serv_periodo (
    id_restricao           NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_servico             NUMBER NOT NULL,
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE NOT NULL,
    motivo                 VARCHAR2(300 CHAR),
    ativo                  CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao             DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao         DATE,
    CONSTRAINT fk_crsp_serv FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico),
    CONSTRAINT ck_crsp_per CHECK (dt_fim > dt_inicio),
    CONSTRAINT ck_crsp_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_csa_unid_data_st ON cad_slot_agenda (id_unidade, dt_inicio, status)');
        DB::statement('CREATE INDEX ix_csa_serv_data_st ON cad_slot_agenda (id_servico, dt_inicio, status)');
        DB::statement('CREATE INDEX ix_cag_eleitor_data ON cad_agendamento (id_eleitor, dt_criacao)');
        DB::statement('CREATE INDEX ix_cag_status_data ON cad_agendamento (status, dt_criacao)');
        DB::statement('CREATE INDEX ix_cba_unid_periodo ON cad_bloqueio_agenda (id_unidade, dt_inicio, dt_fim)');
        DB::statement('CREATE INDEX ix_crsp_serv_period ON cad_restricao_serv_periodo (id_servico, dt_inicio, dt_fim)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_crsp_serv_period');
        DB::statement('DROP INDEX ix_cba_unid_periodo');
        DB::statement('DROP INDEX ix_cag_status_data');
        DB::statement('DROP INDEX ix_cag_eleitor_data');
        DB::statement('DROP INDEX ix_csa_serv_data_st');
        DB::statement('DROP INDEX ix_csa_unid_data_st');

        DB::statement('DROP TABLE cad_restricao_serv_periodo');
        DB::statement('DROP TABLE cad_agendamento');
        DB::statement('DROP TABLE cad_slot_agenda');
        DB::statement('DROP TABLE cad_bloqueio_agenda');
        DB::statement('DROP TABLE cad_eleitor');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_160100_CREATE_CAD_AGENDAMENTO_OPERACAO_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_160200_create_cad_agendamento_triggers_and_seed.php`
## <DATABASE_MIGRATIONS_2026_04_02_160200_CREATE_CAD_AGENDAMENTO_TRIGGERS_AND_SEED_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_160200_create_cad_agendamento_triggers_and_seed.php`
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
CREATE OR REPLACE TRIGGER tr_csa_valid_ref
BEFORE INSERT OR UPDATE OF id_unidade, id_guiche, id_servico, dt_inicio, dt_fim, status
ON cad_slot_agenda
FOR EACH ROW
DECLARE
  v_unid_guiche cad_guiche.id_unidade%TYPE;
  v_exige_bio   cad_servico.exige_biometria%TYPE;
  v_tipo_guiche cad_guiche.tipo%TYPE;
  v_mapeado     NUMBER;
BEGIN
  SELECT id_unidade, tipo
    INTO v_unid_guiche, v_tipo_guiche
    FROM cad_guiche
   WHERE id_guiche = :NEW.id_guiche;

  IF v_unid_guiche <> :NEW.id_unidade THEN
    RAISE_APPLICATION_ERROR(-20011, 'Guiche nao pertence a unidade informada.');
  END IF;

  SELECT COUNT(*)
    INTO v_mapeado
    FROM cad_servico_guiche
   WHERE id_servico = :NEW.id_servico
     AND id_guiche = :NEW.id_guiche;

  IF v_mapeado = 0 THEN
    RAISE_APPLICATION_ERROR(-20012, 'Servico nao habilitado para este guiche.');
  END IF;

  SELECT exige_biometria
    INTO v_exige_bio
    FROM cad_servico
   WHERE id_servico = :NEW.id_servico;

  IF v_exige_bio = 'S' AND v_tipo_guiche <> 'BIOMETRICO' THEN
    RAISE_APPLICATION_ERROR(-20013, 'Servico exige guiche BIOMETRICO.');
  END IF;
END;
SQL
        );

        DB::statement(<<<'SQL'
CREATE OR REPLACE TRIGGER tr_csa_no_overlap
FOR INSERT OR UPDATE OF id_guiche, dt_inicio, dt_fim ON cad_slot_agenda
COMPOUND TRIGGER

  TYPE t_row IS RECORD (
    id_slot    cad_slot_agenda.id_slot%TYPE,
    id_guiche  cad_slot_agenda.id_guiche%TYPE,
    dt_inicio  cad_slot_agenda.dt_inicio%TYPE,
    dt_fim     cad_slot_agenda.dt_fim%TYPE
  );

  TYPE t_tab IS TABLE OF t_row INDEX BY PLS_INTEGER;
  g_rows t_tab;
  g_idx  PLS_INTEGER := 0;

AFTER EACH ROW IS
BEGIN
  g_idx := g_idx + 1;
  g_rows(g_idx).id_slot   := :NEW.id_slot;
  g_rows(g_idx).id_guiche := :NEW.id_guiche;
  g_rows(g_idx).dt_inicio := :NEW.dt_inicio;
  g_rows(g_idx).dt_fim    := :NEW.dt_fim;
END AFTER EACH ROW;

AFTER STATEMENT IS
  v_cnt NUMBER;
BEGIN
  FOR i IN 1 .. g_idx LOOP
    SELECT COUNT(*)
      INTO v_cnt
      FROM cad_slot_agenda s
     WHERE s.id_guiche = g_rows(i).id_guiche
       AND s.id_slot <> g_rows(i).id_slot
       AND g_rows(i).dt_inicio < s.dt_fim
       AND g_rows(i).dt_fim    > s.dt_inicio;

    IF v_cnt > 0 THEN
      RAISE_APPLICATION_ERROR(-20021, 'Sobreposicao de slots no mesmo guiche.');
    END IF;
  END LOOP;
END AFTER STATEMENT;

END tr_csa_no_overlap;
SQL
        );

        DB::statement(<<<'SQL'
MERGE INTO cad_servico s
USING (
  SELECT 'ALISTAMENTO' codigo, 'Alistamento' nome, 25 duracao, 'S' bio FROM dual
  UNION ALL
  SELECT 'REVISAO_BIOMETRICA', 'Revisao Biometrica', 20, 'S' FROM dual
  UNION ALL
  SELECT 'TRANSFERENCIA', 'Transferencia de Domicilio Eleitoral', 30, 'S' FROM dual
) x
ON (s.codigo = x.codigo)
WHEN NOT MATCHED THEN
  INSERT (codigo, nome, duracao_minutos, exige_biometria, ativo, dt_criacao)
  VALUES (x.codigo, x.nome, x.duracao, x.bio, 'S', SYSDATE)
SQL
        );

        DB::statement(<<<'SQL'
MERGE INTO cad_documento d
USING (
  SELECT 'CPF' codigo, 'CPF' nome FROM dual
  UNION ALL
  SELECT 'DOC_FOTO', 'Documento oficial com foto' FROM dual
  UNION ALL
  SELECT 'COMPROV_RESIDENCIA', 'Comprovante de residencia' FROM dual
  UNION ALL
  SELECT 'TITULO_ELEITOR', 'Titulo eleitoral' FROM dual
) x
ON (d.codigo = x.codigo)
WHEN NOT MATCHED THEN
  INSERT (codigo, nome, ativo)
  VALUES (x.codigo, x.nome, 'S')
SQL
        );
    }

    public function down(): void
    {
        DB::statement("DELETE FROM cad_documento WHERE codigo IN ('CPF', 'DOC_FOTO', 'COMPROV_RESIDENCIA', 'TITULO_ELEITOR')");
        DB::statement("DELETE FROM cad_servico WHERE codigo IN ('ALISTAMENTO', 'REVISAO_BIOMETRICA', 'TRANSFERENCIA')");

        DB::statement('DROP TRIGGER tr_csa_no_overlap');
        DB::statement('DROP TRIGGER tr_csa_valid_ref');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_160200_CREATE_CAD_AGENDAMENTO_TRIGGERS_AND_SEED_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_171000_align_agendamento_with_eleitor_lookup_flow.php`
## <DATABASE_MIGRATIONS_2026_04_02_171000_ALIGN_AGENDAMENTO_WITH_ELEITOR_LOOKUP_FLOW_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_171000_align_agendamento_with_eleitor_lookup_flow.php`
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
private function dropConstraintIfExists(string $tableName, string $constraintName): void
private function dropIndexIfExists(string $indexName): void
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
        DB::statement("ALTER TABLE cad_agendamento ADD (num_inscricao VARCHAR2(20 CHAR))");
        DB::statement('CREATE INDEX ix_cag_num_inscricao ON cad_agendamento (num_inscricao)');

        // id_eleitor permanece como vínculo com CAD_ELEITOR (fallback local), mas passa a ser opcional.
        DB::statement('ALTER TABLE cad_agendamento MODIFY (id_eleitor NULL)');

        DB::statement(<<<'SQL'
ALTER TABLE cad_agendamento ADD CONSTRAINT ck_cag_vinculo_origem
CHECK (num_inscricao IS NOT NULL OR id_eleitor IS NOT NULL)
SQL
        );

        // CAD_ELEITOR passa a suportar cadastro mínimo.
        DB::statement("ALTER TABLE cad_eleitor ADD (num_inscricao VARCHAR2(20 CHAR))");
        DB::statement('CREATE INDEX ix_ce_num_inscricao ON cad_eleitor (num_inscricao)');

        DB::statement('ALTER TABLE cad_eleitor MODIFY (cpf NULL)');
        DB::statement('ALTER TABLE cad_eleitor MODIFY (nome NULL)');
        DB::statement('ALTER TABLE cad_eleitor MODIFY (dt_nascimento NULL)');
    }

    public function down(): void
    {
        $this->dropConstraintIfExists('CAD_AGENDAMENTO', 'CK_CAG_VINCULO_ORIGEM');

        $this->dropIndexIfExists('IX_CAG_NUM_INSCRICAO');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN num_inscricao');

        $this->dropIndexIfExists('IX_CE_NUM_INSCRICAO');
        DB::statement('ALTER TABLE cad_eleitor DROP COLUMN num_inscricao');

        // Reversão de obrigatoriedade (pode falhar se houver dados nulos criados após esta migration).
        DB::statement('ALTER TABLE cad_eleitor MODIFY (cpf NOT NULL)');
        DB::statement('ALTER TABLE cad_eleitor MODIFY (nome NOT NULL)');
        DB::statement('ALTER TABLE cad_eleitor MODIFY (dt_nascimento NOT NULL)');

        DB::statement('ALTER TABLE cad_agendamento MODIFY (id_eleitor NOT NULL)');
    }

    private function dropConstraintIfExists(string $tableName, string $constraintName): void
    {
        DB::statement(<<<SQL
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE {$tableName} DROP CONSTRAINT {$constraintName}';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2443 THEN
            RAISE;
        END IF;
END;
SQL);
    }

    private function dropIndexIfExists(string $indexName): void
    {
        DB::statement(<<<SQL
BEGIN
    EXECUTE IMMEDIATE 'DROP INDEX {$indexName}';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1418 THEN
            RAISE;
        END IF;
END;
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_171000_ALIGN_AGENDAMENTO_WITH_ELEITOR_LOOKUP_FLOW_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_02_210000_align_agendamento_without_slots.php`
## <DATABASE_MIGRATIONS_2026_04_02_210000_ALIGN_AGENDAMENTO_WITHOUT_SLOTS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_02_210000_align_agendamento_without_slots.php`
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
        DB::statement('ALTER TABLE cad_agendamento ADD (id_unidade NUMBER)');
        DB::statement('ALTER TABLE cad_agendamento ADD (id_guiche NUMBER)');
        DB::statement('ALTER TABLE cad_agendamento ADD (id_servico NUMBER)');
        DB::statement('ALTER TABLE cad_agendamento ADD (dt_inicio DATE)');
        DB::statement('ALTER TABLE cad_agendamento ADD (dt_fim DATE)');

        DB::statement(<<<'SQL'
UPDATE cad_agendamento a
   SET (id_unidade, id_guiche, id_servico, dt_inicio, dt_fim) = (
       SELECT s.id_unidade, s.id_guiche, s.id_servico, s.dt_inicio, s.dt_fim
         FROM cad_slot_agenda s
        WHERE s.id_slot = a.id_slot
   )
 WHERE a.id_slot IS NOT NULL
SQL
        );

        DB::statement('ALTER TABLE cad_agendamento MODIFY (id_slot NULL)');
        DB::statement('ALTER TABLE cad_agendamento ADD CONSTRAINT fk_cag_unid FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade)');
        DB::statement('ALTER TABLE cad_agendamento ADD CONSTRAINT fk_cag_gui FOREIGN KEY (id_guiche) REFERENCES cad_guiche (id_guiche)');
        DB::statement('ALTER TABLE cad_agendamento ADD CONSTRAINT fk_cag_serv FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico)');
        DB::statement('ALTER TABLE cad_agendamento ADD CONSTRAINT ck_cag_periodo CHECK (dt_fim > dt_inicio)');

        DB::statement('CREATE INDEX ix_cag_guiche_periodo ON cad_agendamento (id_guiche, dt_inicio, dt_fim)');
        DB::statement('CREATE INDEX ix_cag_unidade_periodo ON cad_agendamento (id_unidade, dt_inicio)');
        DB::statement('CREATE INDEX ix_cag_servico_periodo ON cad_agendamento (id_servico, dt_inicio)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_cag_servico_periodo');
        DB::statement('DROP INDEX ix_cag_unidade_periodo');
        DB::statement('DROP INDEX ix_cag_guiche_periodo');
        DB::statement('ALTER TABLE cad_agendamento DROP CONSTRAINT ck_cag_periodo');
        DB::statement('ALTER TABLE cad_agendamento DROP CONSTRAINT fk_cag_serv');
        DB::statement('ALTER TABLE cad_agendamento DROP CONSTRAINT fk_cag_gui');
        DB::statement('ALTER TABLE cad_agendamento DROP CONSTRAINT fk_cag_unid');
        DB::statement('ALTER TABLE cad_agendamento MODIFY (id_slot NOT NULL)');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN dt_fim');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN dt_inicio');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN id_servico');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN id_guiche');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN id_unidade');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_02_210000_ALIGN_AGENDAMENTO_WITHOUT_SLOTS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_03_140000_add_contato_to_cad_agendamento.php`
## <DATABASE_MIGRATIONS_2026_04_03_140000_ADD_CONTATO_TO_CAD_AGENDAMENTO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_03_140000_add_contato_to_cad_agendamento.php`
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
        DB::statement("ALTER TABLE cad_agendamento ADD (telefone_contato VARCHAR2(20 CHAR))");
        DB::statement("ALTER TABLE cad_agendamento ADD (email_contato VARCHAR2(120 CHAR))");
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN email_contato');
        DB::statement('ALTER TABLE cad_agendamento DROP COLUMN telefone_contato');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_03_140000_ADD_CONTATO_TO_CAD_AGENDAMENTO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_04_120000_simplify_cad_agendamento_statuses.php`
## <DATABASE_MIGRATIONS_2026_04_04_120000_SIMPLIFY_CAD_AGENDAMENTO_STATUSES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_04_120000_simplify_cad_agendamento_statuses.php`
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
        DB::statement("
            ALTER TABLE cad_agendamento
            DROP CONSTRAINT ck_cag_status
        ");

        DB::statement("
            UPDATE cad_agendamento
               SET status = 'ATENDIDO'
             WHERE status IN ('CONFIRMADO', 'CHECKIN', 'CONCLUIDO')
        ");

        DB::statement("
            ALTER TABLE cad_agendamento
            ADD CONSTRAINT ck_cag_status
            CHECK (status IN ('AGENDADO','ATENDIDO'))
        ");
    }

    public function down(): void
    {
        DB::statement("
            ALTER TABLE cad_agendamento
            DROP CONSTRAINT ck_cag_status
        ");

        DB::statement("
            ALTER TABLE cad_agendamento
            ADD CONSTRAINT ck_cag_status
            CHECK (status IN ('AGENDADO','CONFIRMADO','CHECKIN','CONCLUIDO','CANCELADO','NO_SHOW'))
        ");
    }
};
```
</DATABASE_MIGRATIONS_2026_04_04_120000_SIMPLIFY_CAD_AGENDAMENTO_STATUSES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_04_130000_create_cad_tipo_guiche_table_and_refactor_cad_guiche.php`
## <DATABASE_MIGRATIONS_2026_04_04_130000_CREATE_CAD_TIPO_GUICHE_TABLE_AND_REFACTOR_CAD_GUICHE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_04_130000_create_cad_tipo_guiche_table_and_refactor_cad_guiche.php`
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
CREATE TABLE cad_tipo_guiche (
    id_tipo_guiche           NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo                   VARCHAR2(30 CHAR) NOT NULL,
    nome                     VARCHAR2(120 CHAR) NOT NULL,
    ativo                    CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao               DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao           DATE,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    CONSTRAINT uk_ctg_codigo UNIQUE (codigo),
    CONSTRAINT ck_ctg_ativo CHECK (ativo IN ('S','N'))
)
SQL
        );

        DB::statement(<<<'SQL'
MERGE INTO cad_tipo_guiche t
USING (
  SELECT 'COMUM' AS codigo, 'Comum' AS nome FROM dual
  UNION ALL
  SELECT 'BIOMETRICO' AS codigo, 'Biométrico' AS nome FROM dual
) src
ON (t.codigo = src.codigo)
WHEN NOT MATCHED THEN
  INSERT (codigo, nome, ativo, dt_criacao)
  VALUES (src.codigo, src.nome, 'S', SYSDATE)
SQL
        );

        DB::statement('ALTER TABLE cad_guiche ADD (id_tipo_guiche NUMBER)');

        DB::statement(<<<'SQL'
UPDATE cad_guiche g
   SET id_tipo_guiche = (
       SELECT t.id_tipo_guiche
         FROM cad_tipo_guiche t
        WHERE t.codigo = g.tipo
   )
 WHERE g.tipo IS NOT NULL
SQL
        );

        DB::statement('ALTER TABLE cad_guiche MODIFY (id_tipo_guiche NOT NULL)');
        DB::statement('ALTER TABLE cad_guiche ADD CONSTRAINT fk_cg_tipo_guiche FOREIGN KEY (id_tipo_guiche) REFERENCES cad_tipo_guiche (id_tipo_guiche)');
        DB::statement('CREATE INDEX ix_cg_tipo_guiche ON cad_guiche (id_tipo_guiche)');

        DB::statement(<<<'SQL'
CREATE OR REPLACE TRIGGER tr_csa_valid_ref
BEFORE INSERT OR UPDATE OF id_unidade, id_guiche, id_servico, dt_inicio, dt_fim, status
ON cad_slot_agenda
FOR EACH ROW
DECLARE
  v_unid_guiche cad_guiche.id_unidade%TYPE;
  v_exige_bio   cad_servico.exige_biometria%TYPE;
  v_tipo_guiche cad_tipo_guiche.codigo%TYPE;
  v_mapeado     NUMBER;
BEGIN
  SELECT g.id_unidade, tg.codigo
    INTO v_unid_guiche, v_tipo_guiche
    FROM cad_guiche g
    JOIN cad_tipo_guiche tg ON tg.id_tipo_guiche = g.id_tipo_guiche
   WHERE g.id_guiche = :NEW.id_guiche;

  IF v_unid_guiche <> :NEW.id_unidade THEN
    RAISE_APPLICATION_ERROR(-20011, 'Guiche nao pertence a unidade informada.');
  END IF;

  SELECT COUNT(*)
    INTO v_mapeado
    FROM cad_servico_guiche
   WHERE id_servico = :NEW.id_servico
     AND id_guiche = :NEW.id_guiche;

  IF v_mapeado = 0 THEN
    RAISE_APPLICATION_ERROR(-20012, 'Servico nao habilitado para este guiche.');
  END IF;

  SELECT exige_biometria
    INTO v_exige_bio
    FROM cad_servico
   WHERE id_servico = :NEW.id_servico;

  IF v_exige_bio = 'S' AND v_tipo_guiche <> 'BIOMETRICO' THEN
    RAISE_APPLICATION_ERROR(-20013, 'Servico exige guiche BIOMETRICO.');
  END IF;
END;
SQL
        );

        DB::statement('ALTER TABLE cad_guiche DROP CONSTRAINT ck_cg_tipo');
        DB::statement('ALTER TABLE cad_guiche DROP COLUMN tipo');
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE cad_guiche ADD (tipo VARCHAR2(20 CHAR))');

        DB::statement(<<<'SQL'
UPDATE cad_guiche g
   SET tipo = (
       SELECT tg.codigo
         FROM cad_tipo_guiche tg
        WHERE tg.id_tipo_guiche = g.id_tipo_guiche
   )
 WHERE g.id_tipo_guiche IS NOT NULL
SQL
        );

        DB::statement("ALTER TABLE cad_guiche MODIFY (tipo NOT NULL)");
        DB::statement("ALTER TABLE cad_guiche ADD CONSTRAINT ck_cg_tipo CHECK (tipo IN ('COMUM','BIOMETRICO'))");

        DB::statement(<<<'SQL'
CREATE OR REPLACE TRIGGER tr_csa_valid_ref
BEFORE INSERT OR UPDATE OF id_unidade, id_guiche, id_servico, dt_inicio, dt_fim, status
ON cad_slot_agenda
FOR EACH ROW
DECLARE
  v_unid_guiche cad_guiche.id_unidade%TYPE;
  v_exige_bio   cad_servico.exige_biometria%TYPE;
  v_tipo_guiche cad_guiche.tipo%TYPE;
  v_mapeado     NUMBER;
BEGIN
  SELECT id_unidade, tipo
    INTO v_unid_guiche, v_tipo_guiche
    FROM cad_guiche
   WHERE id_guiche = :NEW.id_guiche;

  IF v_unid_guiche <> :NEW.id_unidade THEN
    RAISE_APPLICATION_ERROR(-20011, 'Guiche nao pertence a unidade informada.');
  END IF;

  SELECT COUNT(*)
    INTO v_mapeado
    FROM cad_servico_guiche
   WHERE id_servico = :NEW.id_servico
     AND id_guiche = :NEW.id_guiche;

  IF v_mapeado = 0 THEN
    RAISE_APPLICATION_ERROR(-20012, 'Servico nao habilitado para este guiche.');
  END IF;

  SELECT exige_biometria
    INTO v_exige_bio
    FROM cad_servico
   WHERE id_servico = :NEW.id_servico;

  IF v_exige_bio = 'S' AND v_tipo_guiche <> 'BIOMETRICO' THEN
    RAISE_APPLICATION_ERROR(-20013, 'Servico exige guiche BIOMETRICO.');
  END IF;
END;
SQL
        );

        DB::statement('DROP INDEX ix_cg_tipo_guiche');
        DB::statement('ALTER TABLE cad_guiche DROP CONSTRAINT fk_cg_tipo_guiche');
        DB::statement('ALTER TABLE cad_guiche DROP COLUMN id_tipo_guiche');
        DB::statement('DROP TABLE cad_tipo_guiche');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_04_130000_CREATE_CAD_TIPO_GUICHE_TABLE_AND_REFACTOR_CAD_GUICHE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_05_120000_create_cad_fila_nucleo_tables.php`
## <DATABASE_MIGRATIONS_2026_04_05_120000_CREATE_CAD_FILA_NUCLEO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_05_120000_create_cad_fila_nucleo_tables.php`
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
CREATE TABLE cad_fila_prioridade (
    id_prioridade            NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo                   VARCHAR2(30 CHAR) NOT NULL,
    nome                     VARCHAR2(120 CHAR) NOT NULL,
    peso                     NUMBER(4) NOT NULL,
    ativo                    CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao               DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao           DATE,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    CONSTRAINT uk_cfp_codigo UNIQUE (codigo),
    CONSTRAINT ck_cfp_peso CHECK (peso >= 0),
    CONSTRAINT ck_cfp_ativo CHECK (ativo IN ('S','N'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE cad_fila_config_unidade (
    id_unidade               NUMBER PRIMARY KEY,
    titulo_painel            VARCHAR2(160 CHAR),
    subtitulo_painel         VARCHAR2(200 CHAR),
    qtde_historico           NUMBER(2) DEFAULT 6 NOT NULL,
    audio_habilitado         CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    voz_habilitada           CHAR(1 CHAR) DEFAULT 'N' NOT NULL,
    mensagem_rodape          VARCHAR2(300 CHAR),
    local_tipo_padrao        VARCHAR2(30 CHAR) DEFAULT 'Guichê' NOT NULL,
    dt_atualizacao           DATE DEFAULT SYSDATE NOT NULL,
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    CONSTRAINT fk_cfcu_unidade FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT ck_cfcu_hist CHECK (qtde_historico BETWEEN 1 AND 15),
    CONSTRAINT ck_cfcu_audio CHECK (audio_habilitado IN ('S','N')),
    CONSTRAINT ck_cfcu_voz CHECK (voz_habilitada IN ('S','N'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE cad_fila_contador_unidade (
    id_unidade               NUMBER PRIMARY KEY,
    data_referencia          DATE NOT NULL,
    ultimo_numero            NUMBER(6) DEFAULT 0 NOT NULL,
    dt_atualizacao           DATE DEFAULT SYSDATE NOT NULL,
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    CONSTRAINT fk_cfctu_unidade FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT ck_cfctu_num CHECK (ultimo_numero >= 0)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE cad_fila_senha (
    id_fila_senha            NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade               NUMBER NOT NULL,
    id_servico               NUMBER NOT NULL,
    id_prioridade            NUMBER NOT NULL,
    id_guiche                NUMBER,
    data_referencia          DATE NOT NULL,
    numero_senha             NUMBER(6) NOT NULL,
    sigla                    VARCHAR2(10 CHAR) NOT NULL,
    status                   VARCHAR2(30 CHAR) NOT NULL,
    origem                   VARCHAR2(20 CHAR) NOT NULL,
    nome_cliente             VARCHAR2(160 CHAR),
    ident_cliente            VARCHAR2(40 CHAR),
    num_inscricao            VARCHAR2(20 CHAR),
    usuario_atendimento      VARCHAR2(120 CHAR),
    usuario_nome_atendimento VARCHAR2(160 CHAR),
    dt_emissao               DATE DEFAULT SYSDATE NOT NULL,
    dt_chamada               DATE,
    dt_inicio                DATE,
    dt_fim                   DATE,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    usuario_atualizacao      VARCHAR2(120 CHAR),
    usuario_nome_atualizacao VARCHAR2(160 CHAR),
    dt_atualizacao           DATE,
    CONSTRAINT fk_cfs_unidade FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT fk_cfs_servico FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico),
    CONSTRAINT fk_cfs_prioridade FOREIGN KEY (id_prioridade) REFERENCES cad_fila_prioridade (id_prioridade),
    CONSTRAINT fk_cfs_guiche FOREIGN KEY (id_guiche) REFERENCES cad_guiche (id_guiche),
    CONSTRAINT uk_cfs_unid_data_num UNIQUE (id_unidade, data_referencia, numero_senha),
    CONSTRAINT ck_cfs_num CHECK (numero_senha > 0),
    CONSTRAINT ck_cfs_status CHECK (status IN ('EMITIDA','CHAMADA','EM_ATENDIMENTO','FINALIZADA','NAO_COMPARECEU','CANCELADA','TRANSFERIDA')),
    CONSTRAINT ck_cfs_origem CHECK (origem IN ('TRIAGEM','AGENDAMENTO','RECEPCAO','ADMIN'))
)
SQL);

        DB::statement('CREATE INDEX ix_cfs_unid_status_emissao ON cad_fila_senha (id_unidade, status, dt_emissao)');
        DB::statement('CREATE INDEX ix_cfs_unid_serv_status ON cad_fila_senha (id_unidade, id_servico, status)');
        DB::statement('CREATE INDEX ix_cfs_num_inscricao ON cad_fila_senha (num_inscricao)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_cfs_num_inscricao');
        DB::statement('DROP INDEX ix_cfs_unid_serv_status');
        DB::statement('DROP INDEX ix_cfs_unid_status_emissao');
        DB::statement('DROP TABLE cad_fila_senha');
        DB::statement('DROP TABLE cad_fila_contador_unidade');
        DB::statement('DROP TABLE cad_fila_config_unidade');
        DB::statement('DROP TABLE cad_fila_prioridade');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_05_120000_CREATE_CAD_FILA_NUCLEO_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_05_120100_create_cad_fila_operacao_tables.php`
## <DATABASE_MIGRATIONS_2026_04_05_120100_CREATE_CAD_FILA_OPERACAO_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_05_120100_create_cad_fila_operacao_tables.php`
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
CREATE TABLE cad_fila_evento (
    id_fila_evento           NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_fila_senha            NUMBER NOT NULL,
    tipo_evento              VARCHAR2(30 CHAR) NOT NULL,
    status_anterior          VARCHAR2(30 CHAR),
    status_novo              VARCHAR2(30 CHAR),
    payload_json             CLOB,
    dt_evento                DATE DEFAULT SYSDATE NOT NULL,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    CONSTRAINT fk_cfe_senha FOREIGN KEY (id_fila_senha) REFERENCES cad_fila_senha (id_fila_senha),
    CONSTRAINT ck_cfe_tipo CHECK (tipo_evento IN ('EMISSAO','CHAMADA','INICIO','FINALIZACAO','NAO_COMPARECEU','CANCELAMENTO','REATIVACAO','TRANSFERENCIA','PRIORIZACAO'))
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE cad_fila_painel_evento (
    id_painel_evento         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_unidade               NUMBER NOT NULL,
    id_fila_senha            NUMBER NOT NULL,
    id_servico               NUMBER NOT NULL,
    sigla                    VARCHAR2(10 CHAR) NOT NULL,
    numero_senha             NUMBER(6) NOT NULL,
    mensagem                 VARCHAR2(30 CHAR) NOT NULL,
    local_tipo               VARCHAR2(30 CHAR) NOT NULL,
    local_numero             VARCHAR2(20 CHAR) NOT NULL,
    dt_evento                DATE DEFAULT SYSDATE NOT NULL,
    usuario_criacao          VARCHAR2(120 CHAR),
    usuario_nome_criacao     VARCHAR2(160 CHAR),
    CONSTRAINT fk_cfpe_unidade FOREIGN KEY (id_unidade) REFERENCES cad_unidade (id_unidade),
    CONSTRAINT fk_cfpe_senha FOREIGN KEY (id_fila_senha) REFERENCES cad_fila_senha (id_fila_senha),
    CONSTRAINT fk_cfpe_servico FOREIGN KEY (id_servico) REFERENCES cad_servico (id_servico),
    CONSTRAINT ck_cfpe_msg CHECK (mensagem IN ('Atendimento','Prioridade'))
)
SQL);

        DB::statement('CREATE INDEX ix_cfe_senha_data ON cad_fila_evento (id_fila_senha, dt_evento)');
        DB::statement('CREATE INDEX ix_cfpe_unid_evento ON cad_fila_painel_evento (id_unidade, id_painel_evento)');
        DB::statement('CREATE INDEX ix_cfpe_unid_data ON cad_fila_painel_evento (id_unidade, dt_evento)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_cfpe_unid_data');
        DB::statement('DROP INDEX ix_cfpe_unid_evento');
        DB::statement('DROP INDEX ix_cfe_senha_data');
        DB::statement('DROP TABLE cad_fila_painel_evento');
        DB::statement('DROP TABLE cad_fila_evento');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_05_120100_CREATE_CAD_FILA_OPERACAO_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_05_120200_seed_cad_fila_prioridades.php`
## <DATABASE_MIGRATIONS_2026_04_05_120200_SEED_CAD_FILA_PRIORIDADES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_05_120200_seed_cad_fila_prioridades.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('cad_fila_prioridade')
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
MERGE INTO cad_fila_prioridade t
USING (
  SELECT 'NORMAL' AS codigo, 'Normal' AS nome, 0 AS peso FROM dual
  UNION ALL
  SELECT 'PRIORITARIA' AS codigo, 'Prioritária' AS nome, 100 AS peso FROM dual
) src
ON (t.codigo = src.codigo)
WHEN NOT MATCHED THEN
  INSERT (codigo, nome, peso, ativo, dt_criacao)
  VALUES (src.codigo, src.nome, src.peso, 'S', SYSDATE)
WHEN MATCHED THEN
  UPDATE SET
    t.nome = src.nome,
    t.peso = src.peso,
    t.ativo = 'S',
    t.dt_atualizacao = SYSDATE
SQL);
    }

    public function down(): void
    {
        DB::table('cad_fila_prioridade')
            ->whereIn('codigo', ['NORMAL', 'PRIORITARIA'])
            ->delete();
    }
};
```
</DATABASE_MIGRATIONS_2026_04_05_120200_SEED_CAD_FILA_PRIORIDADES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_05_130000_add_modo_emissao_to_cad_fila_senha.php`
## <DATABASE_MIGRATIONS_2026_04_05_130000_ADD_MODO_EMISSAO_TO_CAD_FILA_SENHA_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_05_130000_add_modo_emissao_to_cad_fila_senha.php`
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
ALTER TABLE cad_fila_senha
ADD modo_emissao VARCHAR2(20 CHAR) DEFAULT 'AUTOMATICA' NOT NULL
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE cad_fila_senha
ADD CONSTRAINT ck_cfs_modo_emissao CHECK (modo_emissao IN ('AUTOMATICA', 'INFORMADA'))
SQL);
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE cad_fila_senha DROP CONSTRAINT ck_cfs_modo_emissao');
        DB::statement('ALTER TABLE cad_fila_senha DROP COLUMN modo_emissao');
    }
};
```
</DATABASE_MIGRATIONS_2026_04_05_130000_ADD_MODO_EMISSAO_TO_CAD_FILA_SENHA_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_20_135638_grant_vagas_access_to_fechamento_atendimento_group.php`
## <DATABASE_MIGRATIONS_2026_04_20_135638_GRANT_VAGAS_ACCESS_TO_FECHAMENTO_ATENDIMENTO_GROUP_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_20_135638_grant_vagas_access_to_fechamento_atendimento_group.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration {`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$grupoId = DB::table('adm_grupo_acesso')
DB::table('adm_grupo_acesso')
$rotaId = DB::table('adm_acesso_rota')
DB::table('adm_acesso_rota')
DB::table('adm_acesso_rota')->insert([
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
    private const GRUPO_NOME = 'PLANELEITO_FECHAMENTO_ATENDIMENTO';

    /**
     * @var array<int, array{rota_nome:string,rota_path:string,menu_path:string,descricao:string}>
     */
    private array $rotas = [
        [
            'rota_nome' => 'cadastro-eleitoral.vagas',
            'rota_path' => 'cadastro-eleitoral/vagas',
            'menu_path' => 'Fechamento do Cadastro > Vagas > Vagas em Locais de Votação',
            'descricao' => 'Endpoint JSON da listagem de vagas em locais de votação.',
        ],
        [
            'rota_nome' => 'cadastro-eleitoral.vagas-locais',
            'rota_path' => 'cadastro-eleitoral/vagas-locais',
            'menu_path' => 'Fechamento do Cadastro > Vagas > Vagas em Locais de Votação',
            'descricao' => 'Tela de vagas em locais de votação.',
        ],
        [
            'rota_nome' => 'cadastro-eleitoral.vagas-locais.localidades',
            'rota_path' => 'cadastro-eleitoral/vagas-locais/localidades',
            'menu_path' => 'Fechamento do Cadastro > Vagas > Vagas em Locais de Votação',
            'descricao' => 'Endpoint de filtro de localidades da tela de vagas.',
        ],
        [
            'rota_nome' => 'cadastro-eleitoral.vagas-locais.bairros',
            'rota_path' => 'cadastro-eleitoral/vagas-locais/bairros',
            'menu_path' => 'Fechamento do Cadastro > Vagas > Vagas em Locais de Votação',
            'descricao' => 'Endpoint de filtro de bairros da tela de vagas.',
        ],
    ];

    public function up(): void
    {
        DB::transaction(function () {
            $grupoId = DB::table('adm_grupo_acesso')
                ->whereRaw('UPPER(nome) = ?', [self::GRUPO_NOME])
                ->value('id');

            if (!$grupoId) {
                return;
            }

            DB::table('adm_grupo_acesso')
                ->where('id', $grupoId)
                ->update([
                    'ignora_unidades_permitidas' => 1,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]);

            foreach ($this->rotas as $rota) {
                $rotaId = DB::table('adm_acesso_rota')
                    ->whereRaw('UPPER(rota_nome) = ?', [mb_strtoupper($rota['rota_nome'])])
                    ->value('id');

                if ($rotaId) {
                    DB::table('adm_acesso_rota')
                        ->where('id', $rotaId)
                        ->update([
                            'rota_path' => $rota['rota_path'],
                            'menu_path' => $rota['menu_path'],
                            'descricao' => $rota['descricao'],
                            'ativo' => 1,
                            'dt_atualizacao' => DB::raw('SYSDATE'),
                        ]);
                } else {
                    DB::table('adm_acesso_rota')->insert([
                        'rota_nome' => $rota['rota_nome'],
                        'rota_path' => $rota['rota_path'],
                        'menu_path' => $rota['menu_path'],
                        'descricao' => $rota['descricao'],
                        'ativo' => 1,
                        'dt_criacao' => DB::raw('SYSDATE'),
                    ]);

                    $rotaId = DB::table('adm_acesso_rota')
                        ->whereRaw('UPPER(rota_nome) = ?', [mb_strtoupper($rota['rota_nome'])])
                        ->value('id');
                }

                $vinculoId = DB::table('adm_acesso_rota_grupo')
                    ->where('grupo_acesso_id', $grupoId)
                    ->where('acesso_rota_id', $rotaId)
                    ->value('id');

                if ($vinculoId) {
                    DB::table('adm_acesso_rota_grupo')
                        ->where('id', $vinculoId)
                        ->update([
                            'ativo' => 1,
                            'dt_atualizacao' => DB::raw('SYSDATE'),
                        ]);
                    continue;
                }

                DB::table('adm_acesso_rota_grupo')->insert([
                    'acesso_rota_id' => $rotaId,
                    'grupo_acesso_id' => $grupoId,
                    'ativo' => 1,
                    'dt_criacao' => DB::raw('SYSDATE'),
                ]);
            }
        });
    }

    public function down(): void
    {
        DB::transaction(function () {
            $grupoId = DB::table('adm_grupo_acesso')
                ->whereRaw('UPPER(nome) = ?', [self::GRUPO_NOME])
                ->value('id');

            if (!$grupoId) {
                return;
            }

            DB::table('adm_grupo_acesso')
                ->where('id', $grupoId)
                ->update([
                    'ignora_unidades_permitidas' => 0,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]);

            $rotaIds = DB::table('adm_acesso_rota')
                ->whereIn('rota_nome', array_column($this->rotas, 'rota_nome'))
                ->pluck('id')
                ->all();

            if (empty($rotaIds)) {
                return;
            }

            DB::table('adm_acesso_rota_grupo')
                ->where('grupo_acesso_id', $grupoId)
                ->whereIn('acesso_rota_id', $rotaIds)
                ->update([
                    'ativo' => 0,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]);
        });
    }
};
```
</DATABASE_MIGRATIONS_2026_04_20_135638_GRANT_VAGAS_ACCESS_TO_FECHAMENTO_ATENDIMENTO_GROUP_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_02_120100_add_ciclo_to_cad_fila_tables.php`
## <DATABASE_MIGRATIONS_2026_05_02_120100_ADD_CICLO_TO_CAD_FILA_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_02_120100_add_ciclo_to_cad_fila_tables.php`
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
private function hasColumn(string $table, string $column): bool
private function hasConstraint(string $table, string $constraint): bool
private function hasIndex(string $index): bool
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
    private function hasColumn(string $table, string $column): bool
    {
        $row = DB::selectOne(
            "SELECT COUNT(*) AS qtd
               FROM user_tab_cols
              WHERE table_name = ?
                AND column_name = ?",
            [strtoupper($table), strtoupper($column)]
        );

        return ((int) ($row->qtd ?? 0)) > 0;
    }

    private function hasConstraint(string $table, string $constraint): bool
    {
        $row = DB::selectOne(
            "SELECT COUNT(*) AS qtd
               FROM user_constraints
              WHERE table_name = ?
                AND constraint_name = ?",
            [strtoupper($table), strtoupper($constraint)]
        );

        return ((int) ($row->qtd ?? 0)) > 0;
    }

    private function hasIndex(string $index): bool
    {
        $row = DB::selectOne(
            "SELECT COUNT(*) AS qtd
               FROM user_indexes
              WHERE index_name = ?",
            [strtoupper($index)]
        );

        return ((int) ($row->qtd ?? 0)) > 0;
    }

    public function up(): void
    {
        if (!$this->hasColumn('cad_fila_contador_unidade', 'ciclo_id_atual')) {
            DB::statement(<<<'SQL'
ALTER TABLE cad_fila_contador_unidade
ADD (ciclo_id_atual NUMBER DEFAULT 1 NOT NULL)
SQL);
        }

        if (!$this->hasColumn('cad_fila_contador_unidade', 'ciclo_aberto_em')) {
            DB::statement(<<<'SQL'
ALTER TABLE cad_fila_contador_unidade
ADD (ciclo_aberto_em DATE DEFAULT SYSDATE NOT NULL)
SQL);
        }

        if (!$this->hasConstraint('cad_fila_contador_unidade', 'ck_cfctu_ciclo_id')) {
            DB::statement(<<<'SQL'
ALTER TABLE cad_fila_contador_unidade
ADD CONSTRAINT ck_cfctu_ciclo_id CHECK (ciclo_id_atual >= 1)
SQL);
        }

        if (!$this->hasColumn('cad_fila_senha', 'ciclo_id')) {
            DB::statement(<<<'SQL'
ALTER TABLE cad_fila_senha
ADD (ciclo_id NUMBER DEFAULT 1 NOT NULL)
SQL);
        }

        DB::statement(<<<'SQL'
MERGE INTO cad_fila_senha fs
USING (
    SELECT id_fila_senha,
           DENSE_RANK() OVER (
               PARTITION BY id_unidade
               ORDER BY TRUNC(data_referencia)
           ) AS ciclo_id_calculado
      FROM cad_fila_senha
) ciclos
   ON (fs.id_fila_senha = ciclos.id_fila_senha)
WHEN MATCHED THEN
    UPDATE
       SET fs.ciclo_id = ciclos.ciclo_id_calculado
SQL);

        if (!$this->hasConstraint('cad_fila_senha', 'ck_cfs_ciclo_id')) {
            DB::statement(<<<'SQL'
ALTER TABLE cad_fila_senha
ADD CONSTRAINT ck_cfs_ciclo_id CHECK (ciclo_id >= 1)
SQL);
        }

        if ($this->hasConstraint('cad_fila_senha', 'uk_cfs_unid_data_num')) {
            DB::statement('ALTER TABLE cad_fila_senha DROP CONSTRAINT uk_cfs_unid_data_num');
        }

        DB::statement(<<<'SQL'
MERGE INTO cad_fila_contador_unidade c
USING (
    SELECT id_unidade,
           MAX(ciclo_id) AS ciclo_id_atual,
           MAX(TRUNC(data_referencia)) AS ultima_data_referencia,
           MAX(numero_senha) KEEP (
               DENSE_RANK LAST ORDER BY TRUNC(data_referencia)
           ) AS ultimo_numero_ultima_data
      FROM cad_fila_senha
     GROUP BY id_unidade
) fs
   ON (c.id_unidade = fs.id_unidade)
WHEN MATCHED THEN
    UPDATE
       SET c.data_referencia = fs.ultima_data_referencia,
           c.ultimo_numero = fs.ultimo_numero_ultima_data,
           c.ciclo_id_atual = fs.ciclo_id_atual,
           c.ciclo_aberto_em = fs.ultima_data_referencia
SQL);

        if (!$this->hasConstraint('cad_fila_senha', 'uk_cfs_unid_ciclo_num')) {
            DB::statement(<<<'SQL'
ALTER TABLE cad_fila_senha
ADD CONSTRAINT uk_cfs_unid_ciclo_num UNIQUE (id_unidade, ciclo_id, numero_senha)
SQL);
        }

        if (!$this->hasIndex('ix_cfs_unid_st_serv_cic_num')) {
            DB::statement('CREATE INDEX ix_cfs_unid_st_serv_cic_num ON cad_fila_senha (id_unidade, status, id_servico, ciclo_id, numero_senha)');
        }
    }

    public function down(): void
    {
        if ($this->hasIndex('ix_cfs_unid_st_serv_cic_num')) {
            DB::statement('DROP INDEX ix_cfs_unid_st_serv_cic_num');
        }

        if ($this->hasConstraint('cad_fila_senha', 'uk_cfs_unid_ciclo_num')) {
            DB::statement('ALTER TABLE cad_fila_senha DROP CONSTRAINT uk_cfs_unid_ciclo_num');
        }
        if (!$this->hasConstraint('cad_fila_senha', 'uk_cfs_unid_data_num')) {
            DB::statement('ALTER TABLE cad_fila_senha ADD CONSTRAINT uk_cfs_unid_data_num UNIQUE (id_unidade, data_referencia, numero_senha)');
        }

        if ($this->hasConstraint('cad_fila_senha', 'ck_cfs_ciclo_id')) {
            DB::statement('ALTER TABLE cad_fila_senha DROP CONSTRAINT ck_cfs_ciclo_id');
        }
        if ($this->hasColumn('cad_fila_senha', 'ciclo_id')) {
            DB::statement('ALTER TABLE cad_fila_senha DROP COLUMN ciclo_id');
        }

        if ($this->hasConstraint('cad_fila_contador_unidade', 'ck_cfctu_ciclo_id')) {
            DB::statement('ALTER TABLE cad_fila_contador_unidade DROP CONSTRAINT ck_cfctu_ciclo_id');
        }
        if ($this->hasColumn('cad_fila_contador_unidade', 'ciclo_aberto_em')) {
            DB::statement('ALTER TABLE cad_fila_contador_unidade DROP COLUMN ciclo_aberto_em');
        }
        if ($this->hasColumn('cad_fila_contador_unidade', 'ciclo_id_atual')) {
            DB::statement('ALTER TABLE cad_fila_contador_unidade DROP COLUMN ciclo_id_atual');
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_05_02_120100_ADD_CICLO_TO_CAD_FILA_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_15_100000_create_tarefa_alerta_agendamento_table.php`
## <DATABASE_MIGRATIONS_2026_06_15_100000_CREATE_TAREFA_ALERTA_AGENDAMENTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_15_100000_create_tarefa_alerta_agendamento_table.php`
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
CREATE TABLE tarefa_alerta_agendamento (
    id                        NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    macroprojeto_id           NUMBER                              NOT NULL,
    nome                      VARCHAR2(255 CHAR)                  NOT NULL,
    status                    VARCHAR2(20 CHAR)  DEFAULT 'ativo'  NOT NULL,
    filtros_json              CLOB,
    tipos_destinatario_json   CLOB,
    assunto                   VARCHAR2(500 CHAR)                  NOT NULL,
    mensagem                  CLOB,
    data_hora_agendado        DATE                               NOT NULL,
    recorrente                NUMBER(1)          DEFAULT 0        NOT NULL,
    recorrencia_tipo          VARCHAR2(20 CHAR),
    recorrencia_dia           NUMBER,
    data_final                DATE,
    proxima_execucao          DATE,
    escopo_json               CLOB,
    criador_id                NUMBER,
    criador_username          VARCHAR2(100 CHAR),
    criador_nome              VARCHAR2(255 CHAR),
    responsavel_id            NUMBER,
    responsavel_username      VARCHAR2(100 CHAR),
    responsavel_nome          VARCHAR2(255 CHAR),
    dt_criacao                DATE DEFAULT SYSDATE               NOT NULL,
    dt_atualizacao            DATE,
    CONSTRAINT ck_taa_status       CHECK (status IN ('ativo','inativo','concluido')),
    CONSTRAINT ck_taa_recorrente   CHECK (recorrente IN (0, 1)),
    CONSTRAINT ck_taa_rectype      CHECK (recorrencia_tipo IS NULL OR recorrencia_tipo IN ('semanal','mensal'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_taa_macro    ON tarefa_alerta_agendamento (macroprojeto_id, status)');
        DB::statement('CREATE INDEX ix_taa_prox_exec ON tarefa_alerta_agendamento (proxima_execucao, status)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE tarefa_alerta_agendamento');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_15_100000_CREATE_TAREFA_ALERTA_AGENDAMENTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EleitorConvocadoEfetivoEquipeQueryTest.php`
## <TESTS_UNIT_ELEITORCONVOCADOEFETIVOEQUIPEQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EleitorConvocadoEfetivoEquipeQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EleitorConvocadoEfetivoEquipeQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function linhas_aceitam_qualquer_funcao_nao_vazia_e_falham_fechado_sem_territorio(): void
public function agrupamento_deduplica_titulo_e_reune_funcoes_distintas_ordenadas(): void
public function identidade_unica_por_titulo_expoe_email_nome_e_telefone(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\Queries\EleitorConvocadoEfetivoEquipeQuery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class EleitorConvocadoEfetivoEquipeQueryTest extends TestCase
{
    #[Test]
    public function linhas_aceitam_qualquer_funcao_nao_vazia_e_falham_fechado_sem_territorio(): void
    {
        $query = EleitorConvocadoEfetivoEquipeQuery::linhas(
            busca: 'MARIA',
            zonaNumero: '5',
            zonasNumerosPermitidas: ['5'],
            acessoTodasZonas: false,
        );
        $sql = mb_strtoupper($query->toSql(), 'UTF-8');

        $this->assertStringContainsString('TRIM(C.DES_FUNCAO_ELEITORAL) IS NOT NULL', $sql);
        $this->assertStringContainsString("TRIM(C.DES_FUNCAO_ELEITORAL) <> ''", $sql);
        $this->assertStringContainsString(
            'NVL(TRIM(LV_EFETIVO.COD_OBJETO_ZONA), TRIM(C.NUM_ZONA)) IS NOT NULL',
            $sql,
        );
        $this->assertStringNotContainsString('UPPER(TRIM(C.DES_FUNCAO_ELEITORAL)) IN', $sql);
    }

    #[Test]
    public function agrupamento_deduplica_titulo_e_reune_funcoes_distintas_ordenadas(): void
    {
        $resultado = EleitorConvocadoEfetivoEquipeQuery::agruparLinhas([
            (object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Maria Exemplo',
                'telefone' => '68999990000',
                'num_zona' => '5',
                'nom_localidade' => 'RIO BRANCO',
                'des_funcao_eleitoral' => 'Presidente',
            ],
            (object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Maria Exemplo',
                'telefone' => null,
                'num_zona' => '5',
                'nom_localidade' => 'RIO BRANCO',
                'des_funcao_eleitoral' => '1º Mesário',
            ],
            (object) [
                'num_inscricao' => '000000000123',
                'nom_eleitor' => 'Maria Exemplo',
                'des_funcao_eleitoral' => 'PRESIDENTE',
            ],
        ]);

        $this->assertCount(1, $resultado);
        $this->assertSame('Maria Exemplo', $resultado[0]->nom_eleitor);
        $this->assertSame('68999990000', $resultado[0]->telefone);
        $this->assertSame(['1º Mesário', 'Presidente'], $resultado[0]->funcoes_efetivas);
        $this->assertSame('convocacao_eleitoral_efetiva', $resultado[0]->fonte_elegibilidade);
    }

    #[Test]
    public function identidade_unica_por_titulo_expoe_email_nome_e_telefone(): void
    {
        $sql = mb_strtoupper(EleitorConvocadoEfetivoEquipeQuery::identidades()->toSql(), 'UTF-8');

        $this->assertStringContainsString('GROUP BY TRIM(NUM_INSCRICAO)', $sql);
        $this->assertStringContainsString('MAX(TRIM(EMAIL)) AS EMAIL', $sql);
        $this->assertStringContainsString('MAX(TRIM(NOM_ELEITOR)) AS NOM_ELEITOR', $sql);
        $this->assertStringContainsString('MAX(TRIM(TELEFONE)) AS TELEFONE', $sql);
    }
}
```
</TESTS_UNIT_ELEITORCONVOCADOEFETIVOEQUIPEQUERYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaAlertaAgendamentoControllerTest.php`
## <TESTS_UNIT_TAREFAALERTAAGENDAMENTOCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaAlertaAgendamentoControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaAlertaAgendamentoControllerTest extends TestCase`

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
public function test_index_responde_200_e_repassa_macroprojeto_ao_repository(): void
public function test_create_retorna_200_com_view_de_formulario(): void
public function test_store_chama_service_criar_e_redireciona(): void
public function test_show_retorna_200_com_view_de_detalhe(): void
public function test_show_retorna_403_quando_macroprojeto_diferente(): void
public function test_destroy_chama_service_excluir_e_retorna_json(): void
public function test_ativar_chama_service_e_retorna_json(): void
public function test_inativar_chama_service_e_retorna_json(): void
public function test_executar_agora_retorna_json_com_execucao_id(): void
public function test_reprocessar_retorna_422_quando_execucao_nao_pode_ser_reprocessada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Tarefas\TarefaAlertaAgendamentoController;
use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaAuditoriaRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use App\Services\Tarefas\TarefaAlertaAgendamentoService;
use App\Support\Tarefas\TarefaAlertaAgendamentoStatus;
use App\Support\Tarefas\TarefaAlertaExecucaoStatus;
use App\Jobs\Tarefas\EnviarAlertaTarefasJob;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Queue;
use Mockery;
use Tests\TestCase;

class TarefaAlertaAgendamentoControllerTest extends TestCase
{
    private const MACRO_ID = 7;
    private const USUARIO  = 'admin.alerta';

    /** @var \Mockery\MockInterface&TarefaAlertaAgendamentoRepository */
    private TarefaAlertaAgendamentoRepository $agendamentoRepo;

    /** @var \Mockery\MockInterface&TarefaAlertaExecucaoRepository */
    private TarefaAlertaExecucaoRepository $execucaoRepo;

    /** @var \Mockery\MockInterface&TarefaAlertaAgendamentoService */
    private TarefaAlertaAgendamentoService $service;

    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([ConfigureUserSession::class, AuthorizeRouteAccess::class]);

        $this->agendamentoRepo = Mockery::mock(TarefaAlertaAgendamentoRepository::class);
        $this->execucaoRepo    = Mockery::mock(TarefaAlertaExecucaoRepository::class);
        $this->service         = Mockery::mock(TarefaAlertaAgendamentoService::class);

        $auditoriaRepo = Mockery::mock(TarefaAlertaAuditoriaRepository::class);
        $auditoriaRepo->shouldReceive('registrar')->andReturn(null)->byDefault();

        $escopoService = Mockery::mock(EscopoUnidadeService::class);
        $escopoService->shouldReceive('unidadesParaConsultaAtual')->andReturn(null)->byDefault();
        $escopoService->shouldReceive('aplicaEscopoAtual')->andReturn(false)->byDefault();

        $permissoes = Mockery::mock(PermissaoDominioService::class);
        $permissoes->shouldReceive('podeExecutar')->andReturn(true)->byDefault();
        $permissoes->shouldReceive('podeOperarMacro')->andReturn(true)->byDefault();

        $this->app->instance(TarefaAlertaAgendamentoRepository::class, $this->agendamentoRepo);
        $this->app->instance(TarefaAlertaExecucaoRepository::class, $this->execucaoRepo);
        $this->app->instance(TarefaAlertaAgendamentoService::class, $this->service);
        $this->app->instance(TarefaAlertaAuditoriaRepository::class, $auditoriaRepo);
        $this->app->instance(EscopoUnidadeService::class, $escopoService);
        $this->app->instance(PermissaoDominioService::class, $permissoes);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    // ─── TDD 1: index responde 200 com macroprojeto correto ──────────────────

    public function test_index_responde_200_e_repassa_macroprojeto_ao_repository(): void
    {
        $this->agendamentoRepo
            ->shouldReceive('listar')
            ->once()
            ->withArgs(fn ($id) => $id === self::MACRO_ID)
            ->andReturn($this->paginadorVazio());

        $response = $this->comSessao()->get(route('tarefas.alertas.agendamentos.index'));

        $response->assertOk();
        $response->assertViewIs('planejamento.tarefas.agendamentos.index');
    }

    // ─── TDD 2: create abre formulário vazio ─────────────────────────────────

    public function test_create_retorna_200_com_view_de_formulario(): void
    {
        $response = $this->comSessao()->get(route('tarefas.alertas.agendamentos.create'));

        $response->assertOk();
        $response->assertViewIs('planejamento.tarefas.agendamentos.form');
        $response->assertViewHas('agendamento', null);
    }

    // ─── TDD 3: store chama service.criar e redireciona ──────────────────────

    public function test_store_chama_service_criar_e_redireciona(): void
    {
        $this->service
            ->shouldReceive('criar')
            ->once()
            ->andReturn(99);

        $response = $this->comSessao()->post(
            route('tarefas.alertas.agendamentos.store'),
            $this->payloadValido()
        );

        $response->assertRedirect(route('tarefas.alertas.agendamentos.index'));
    }

    // ─── TDD 4: show responde 200 com agendamento do macroprojeto ativo ──────

    public function test_show_retorna_200_com_view_de_detalhe(): void
    {
        $agendamento = $this->agendamentoFake(1);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(1)->andReturn($agendamento);

        $response = $this->comSessao()->get(route('tarefas.alertas.agendamentos.show', 1));

        $response->assertOk();
        $response->assertViewIs('planejamento.tarefas.agendamentos.show');
    }

    // ─── TDD 5: show rejeita agendamento de outro macroprojeto ───────────────

    public function test_show_retorna_403_quando_macroprojeto_diferente(): void
    {
        $agendamento = $this->agendamentoFake(1, macroId: 999);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(1)->andReturn($agendamento);

        $response = $this->comSessao()->get(route('tarefas.alertas.agendamentos.show', 1));

        $response->assertForbidden();
    }

    // ─── TDD 6: destroy chama service.excluir e retorna JSON ────────────────

    public function test_destroy_chama_service_excluir_e_retorna_json(): void
    {
        $agendamento = $this->agendamentoFake(5);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(5)->andReturn($agendamento);
        $this->service->shouldReceive('excluir')->once()->with(5, Mockery::any());

        $response = $this->comSessao()->delete(route('tarefas.alertas.agendamentos.destroy', 5));

        $response->assertOk();
        $response->assertJsonStructure(['mensagem']);
    }

    // ─── TDD 7: ativar chama service.ativar e retorna JSON ───────────────────

    public function test_ativar_chama_service_e_retorna_json(): void
    {
        $agendamento = $this->agendamentoFake(3, status: TarefaAlertaAgendamentoStatus::INATIVO);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(3)->andReturn($agendamento);
        $this->service->shouldReceive('ativar')->once()->with(3, Mockery::any());

        $response = $this->comSessao()->post(route('tarefas.alertas.agendamentos.ativar', 3));

        $response->assertOk();
        $response->assertJsonStructure(['mensagem']);
    }

    // ─── TDD 8: inativar chama service.inativar e retorna JSON ───────────────

    public function test_inativar_chama_service_e_retorna_json(): void
    {
        $agendamento = $this->agendamentoFake(4);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(4)->andReturn($agendamento);
        $this->service->shouldReceive('inativar')->once()->with(4, Mockery::any());

        $response = $this->comSessao()->post(route('tarefas.alertas.agendamentos.inativar', 4));

        $response->assertOk();
        $response->assertJsonStructure(['mensagem']);
    }

    // ─── TDD 9: executarAgora cria execução e enfileira job ──────────────────

    public function test_executar_agora_retorna_json_com_execucao_id(): void
    {
        Queue::fake();

        $agendamento = $this->agendamentoFake(2);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(2)->andReturn($agendamento);
        $this->execucaoRepo->shouldReceive('criar')->once()->andReturn(55);

        $response = $this->comSessao()->post(route('tarefas.alertas.agendamentos.executar-agora', 2));

        $response->assertOk();
        $response->assertJsonFragment(['execucao_id' => 55]);
        Queue::assertPushed(EnviarAlertaTarefasJob::class);
    }

    // ─── TDD 10: reprocessar rejeita execução com status concluida ───────────

    public function test_reprocessar_retorna_422_quando_execucao_nao_pode_ser_reprocessada(): void
    {
        $execucao = (object) [
            'id'             => 10,
            'status'         => TarefaAlertaExecucaoStatus::CONCLUIDA,
            'agendamento_id' => null,
        ];

        $this->execucaoRepo->shouldReceive('encontrarOuFalhar')->with(10)->andReturn($execucao);

        $response = $this->comSessao()->post(route('tarefas.alertas.agendamentos.reprocessar', 10));

        $response->assertStatus(422);
    }

    public function test_reprocessar_reenfileira_execucao_original_com_modo_reprocessamento(): void
    {
        Queue::fake();
        $execucao = (object) ['id' => 12, 'status' => TarefaAlertaExecucaoStatus::FALHA, 'agendamento_id' => 6];
        $agendamento = $this->agendamentoFake(6);
        $this->execucaoRepo->shouldReceive('encontrarOuFalhar')->with(12)->andReturn($execucao);
        $this->agendamentoRepo->shouldReceive('encontrar')->with(6)->andReturn($agendamento);
        $this->execucaoRepo->shouldReceive('atualizarStatus')->once()->with(12, TarefaAlertaExecucaoStatus::PENDENTE);

        $response = $this->comSessao()->post(route('tarefas.alertas.agendamentos.reprocessar', 12));

        $response->assertOk();
        Queue::assertPushed(EnviarAlertaTarefasJob::class, fn ($job) => $job->reprocessamento === true);
    }

    // ─── TDD 11: historico retorna view com paginador ────────────────────────

    public function test_historico_retorna_200_com_view_de_historico(): void
    {
        $agendamento = $this->agendamentoFake(6);

        $this->agendamentoRepo->shouldReceive('encontrarOuFalhar')->with(6)->andReturn($agendamento);
        $this->execucaoRepo->shouldReceive('historicoDoAgendamento')->with(6)->andReturn($this->paginadorVazio());

        $response = $this->comSessao()->get(route('tarefas.alertas.agendamentos.historico', 6));

        $response->assertOk();
        $response->assertViewIs('planejamento.tarefas.agendamentos.historico');
    }

    // ─── Helpers ─────────────────────────────────────────────────────────────

    private function comSessao(): static
    {
        return $this->withSession([
            'macroprojeto_ativo_id'      => self::MACRO_ID,
            'user'                        => ['username' => self::USUARIO, 'nome' => 'Admin'],
            'macroprojetos_disponiveis'   => [['id' => self::MACRO_ID, 'nome' => 'Macro Teste']],
            'matchingGroups'              => ['PLANELEITO_ADMIN'],
            'aplica_escopo_unidade'       => false,
            'acesso_todas_zonas'          => true,
        ]);
    }

    private function agendamentoFake(int $id, int $macroId = self::MACRO_ID, string $status = TarefaAlertaAgendamentoStatus::ATIVO): object
    {
        return (object) [
            'id'                       => $id,
            'macroprojeto_id'          => $macroId,
            'nome'                     => 'Agendamento Teste',
            'status'                   => $status,
            'filtros_json'             => '{}',
            'tipos_destinatario_json'  => '["unidade_tarefa"]',
            'escopo_json'              => '{}',
            'assunto'                  => 'Alerta Teste',
            'mensagem'                 => null,
            'recorrente'               => 0,
            'recorrencia_tipo'         => null,
            'recorrencia_dia'          => null,
            'data_final'               => null,
            'proxima_execucao'         => now()->addDay()->toDateTimeString(),
            'data_hora_agendado'       => now()->addDay()->toDateTimeString(),
            'criador_username'         => self::USUARIO,
            'responsavel_username'     => self::USUARIO,
            'responsavel_nome'         => 'Admin',
            'dt_criacao'               => now()->toDateTimeString(),
            'dt_atualizacao'           => null,
        ];
    }

    private function payloadValido(): array
    {
        return [
            'nome'                      => 'Agendamento TDD',
            'status'                    => ['ATRASADA'],
            'assunto'                   => 'Alertas de teste',
            'data_hora_envio_agendado'        => now()->addDay()->format('Y-m-d\\TH:i'),
            'incluir_unidade_tarefa'    => '1',
            'recorrente'                => '0',
            'preview_confirmado'        => '1',
        ];
    }

    private function paginadorVazio(): LengthAwarePaginator
    {
        return new LengthAwarePaginator([], 0, 20, 1, ['path' => url('/')]);
    }
}
```
</TESTS_UNIT_TAREFAALERTAAGENDAMENTOCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaAlertaAgendamentoServiceTest.php`
## <TESTS_UNIT_TAREFAALERTAAGENDAMENTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaAlertaAgendamentoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaAlertaAgendamentoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_reativacao_recorrente_preserva_hora_configurada_e_escolhe_data_futura(): void
public function test_edicao_preserva_criador_original_e_atualiza_responsavel(): void
private function service(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Tarefas\TarefaAlertaAgendamentoRepository;
use App\Repositories\Tarefas\TarefaAlertaAuditoriaRepository;
use App\Repositories\Tarefas\TarefaAlertaExecucaoRepository;
use App\Services\Tarefas\TarefaAlertaAgendamentoService;
use App\Services\Tarefas\TarefaAlertaDuplicidadeService;
use App\Services\Tarefas\TarefaAlertaRecorrenciaService;
use Carbon\Carbon;
use Mockery;
use ReflectionMethod;
use Tests\TestCase;

class TarefaAlertaAgendamentoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Carbon::setTestNow();
        Mockery::close();
        parent::tearDown();
    }

    public function test_reativacao_recorrente_preserva_hora_configurada_e_escolhe_data_futura(): void
    {
        Carbon::setTestNow(Carbon::parse('2026-06-15 15:00:00', 'America/Rio_Branco'));
        $service = $this->service();
        $agendamento = (object) [
            'recorrente' => 1,
            'recorrencia_tipo' => 'semanal',
            'recorrencia_dia' => 1,
            'data_hora_agendado' => '2026-06-01 09:30:00',
            'data_final' => '2026-07-31',
        ];

        $metodo = new ReflectionMethod($service, 'calcularProximaOcorrenciaAtivacao');
        $metodo->setAccessible(true);
        $proxima = $metodo->invoke($service, $agendamento);

        $this->assertSame('2026-06-22 09:30:00', $proxima?->format('Y-m-d H:i:s'));
    }

    public function test_edicao_preserva_criador_original_e_atualiza_responsavel(): void
    {
        Carbon::setTestNow(Carbon::parse('2026-06-15 08:00:00', 'America/Rio_Branco'));
        $agendamentoRepo = Mockery::mock(TarefaAlertaAgendamentoRepository::class);
        $auditoriaRepo = Mockery::mock(TarefaAlertaAuditoriaRepository::class);
        $duplicidade = Mockery::mock(TarefaAlertaDuplicidadeService::class);
        $existente = (object) [
            'id' => 9, 'status' => 'ativo', 'criador_id' => 1,
            'criador_username' => 'criador', 'criador_nome' => 'Criador Original',
            'escopo_json' => '{}',
        ];
        $agendamentoRepo->shouldReceive('encontrarOuFalhar')->once()->with(9)->andReturn($existente);
        $duplicidade->shouldReceive('validar')->once();
        $agendamentoRepo->shouldReceive('atualizar')->once()->with(9, Mockery::on(
            static fn (array $registro): bool => $registro['criador_id'] === 1
                && $registro['criador_username'] === 'criador'
                && $registro['responsavel_id'] === 2
                && $registro['responsavel_username'] === 'editor'
        ));
        $auditoriaRepo->shouldReceive('registrar')->once();
        $service = $this->service($agendamentoRepo, $auditoriaRepo, $duplicidade);

        $service->editar(9, [
            'macroprojeto_id' => 7,
            'nome' => 'Editado',
            'filtros_json' => '{}',
            'tipos_destinatario_json' => '["unidade_tarefa"]',
            'assunto' => 'Assunto',
            'mensagem' => null,
            'data_hora_envio_agendado' => '2026-06-16 10:00:00',
            'recorrente' => false,
        ], ['id' => 2, 'username' => 'editor', 'nome' => 'Editor'], ['macroprojeto_id' => 7]);

        $this->assertTrue(true);
    }

    private function service(
        ?TarefaAlertaAgendamentoRepository $agendamentoRepo = null,
        ?TarefaAlertaAuditoriaRepository $auditoriaRepo = null,
        ?TarefaAlertaDuplicidadeService $duplicidade = null,
    ): TarefaAlertaAgendamentoService {
        return new TarefaAlertaAgendamentoService(
            $agendamentoRepo ?? Mockery::mock(TarefaAlertaAgendamentoRepository::class),
            $auditoriaRepo ?? Mockery::mock(TarefaAlertaAuditoriaRepository::class),
            new TarefaAlertaRecorrenciaService(),
            Mockery::mock(TarefaAlertaExecucaoRepository::class),
            $duplicidade ?? Mockery::mock(TarefaAlertaDuplicidadeService::class),
        );
    }
}
```
</TESTS_UNIT_TAREFAALERTAAGENDAMENTOSERVICETEST_PHP>

