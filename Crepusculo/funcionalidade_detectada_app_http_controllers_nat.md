# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_controllers_nat`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 4  
> **Tamanho do Arquivo:** 32 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatMonitoramentoController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATMONITORAMENTOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatMonitoramentoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatMonitoramentoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request): View
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Nat;

use App\Http\Controllers\Controller;

use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use App\Services\Nat\NatEscopoService;
use Illuminate\Http\Request;
use Illuminate\View\View;

class NatMonitoramentoController extends Controller
{
    public function __construct(
        private readonly NatOcorrenciaRepository $repository,
        private readonly NatTipoOcorrenciaRepository $tipoRepository,
        private readonly NatEscopoService $escopoService,
    ) {
    }

    public function index(Request $request): View
    {
        $statusRaw = trim((string) $request->query('status', ''));
        $filtros = [
            'busca' => trim((string) $request->query('busca', '')),
            'status' => $statusRaw === 'TODOS' ? '' : $statusRaw,
            'tipo' => trim((string) $request->query('tipo', '')),
            'secao' => trim((string) $request->query('secao', '')),
            'rota_id' => trim((string) $request->query('rota_id', '')),
        ];

        $zonas = $this->escopoService->zonasPermitidas();
        $acessoTodas = $this->escopoService->acessoTodasZonas();

        return view('nat.monitoramento.index', [
            'ocorrencias' => $this->repository->listarPaginado($filtros, $zonas, $acessoTodas),
            'tipos' => $this->tipoRepository->listarAtivos(),
            'rotas' => $this->repository->listarRotasNoEscopo($zonas, $acessoTodas),
            'filtros' => $filtros,
            'totaisStatus' => $this->repository->contarPorStatus($filtros, $zonas, $acessoTodas),
        ]);
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATMONITORAMENTOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatOcorrenciaController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATOCORRENCIACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatOcorrenciaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatOcorrenciaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request): View
public function form(Request $request): View
public function store(NatAbrirOcorrenciaRequest $request): RedirectResponse
public function show(Request $request, int $id): View|JsonResponse
public function locais(Request $request): JsonResponse
public function secoes(Request $request): JsonResponse
public function rotasElegiveis(Request $request): JsonResponse
public function detalhesMapa(Request $request): JsonResponse
private function localEstaNoEscopo(object $local): bool
private function normalizarOrigem(string $origem): string
private function normalizarBackUrl(string $backUrl): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Nat;

use App\Http\Controllers\Controller;

use App\Http\Requests\Nat\NatAbrirOcorrenciaRequest;
use App\Repositories\Nat\NatLocalSecaoRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use App\Services\Nat\NatEscopoService;
use App\Services\Nat\NatOcorrenciaEventoService;
use App\Services\Nat\NatOcorrenciaService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\View as ViewFacade;
use Illuminate\View\View;
use RuntimeException;

class NatOcorrenciaController extends Controller
{
    public function __construct(
        private readonly NatOcorrenciaRepository $repository,
        private readonly NatTipoOcorrenciaRepository $tipoRepository,
        private readonly NatLocalSecaoRepository $localSecaoRepository,
        private readonly NatOcorrenciaService $service,
        private readonly NatOcorrenciaEventoService $eventoService,
        private readonly NatEscopoService $escopoService,
    ) {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));
        $statusRaw = trim((string) $request->query('status', 'NAO_FINALIZADA'));
        $status = $statusRaw === 'TODOS' ? '' : $statusRaw;
        $tipo = trim((string) $request->query('tipo', ''));
        $secao = trim((string) $request->query('secao', ''));

        return view('nat.ocorrencias.index', [
            'ocorrencias' => $this->repository->listarPaginado([
                'busca' => $busca,
                'status' => $status,
                'tipo' => $tipo,
                'secao' => $secao,
            ], $this->escopoService->zonasPermitidas(), $this->escopoService->acessoTodasZonas()),
            'tipos' => $this->tipoRepository->listarAtivos(),
            'filtros' => compact('busca', 'status', 'tipo', 'secao'),
        ]);
    }

    public function form(Request $request): View
    {
        $codObjetoLocal = trim((string) session()->getOldInput('cod_objeto_local_votacao', ''));
        $localSelecionado = null;
        $secoesIniciais = [];
        $rotasIniciais = ['automatica' => null, 'rotas' => []];
        $origem = $this->normalizarOrigem((string) $request->query('origem', session()->getOldInput('origem', '')));
        $backUrl = $this->normalizarBackUrl((string) $request->query('back_url', session()->getOldInput('back_url', '')));

        if ($codObjetoLocal !== '') {
            $localSelecionado = $this->localSecaoRepository->buscarLocal($codObjetoLocal);
            if ($localSelecionado !== null && $this->localEstaNoEscopo($localSelecionado)) {
                $secoesIniciais = $this->localSecaoRepository->listarSecoesPorLocal($codObjetoLocal);
                $rotaAutomatica = $this->localSecaoRepository->buscarRotaAutomaticaPorLocal($codObjetoLocal);
                $rotasIniciais = [
                    'automatica' => $rotaAutomatica ? (array) $rotaAutomatica : null,
                    'rotas' => $this->localSecaoRepository->listarRotasElegiveisPorLocal($codObjetoLocal),
                ];
            } else {
                $localSelecionado = null;
            }
        }

        return view('nat.ocorrencias.form', [
            'tipos' => $this->tipoRepository->listarAtivos(),
            'localSelecionado' => $localSelecionado,
            'secoesIniciais' => $secoesIniciais,
            'rotasIniciais' => $rotasIniciais,
            'origem' => $origem,
            'backUrl' => $backUrl,
        ]);
    }

    public function store(NatAbrirOcorrenciaRequest $request): RedirectResponse
    {
        $dados = $request->validated();
        $origem = $this->normalizarOrigem((string) ($dados['origem'] ?? ''));
        $backUrl = $this->normalizarBackUrl((string) ($dados['back_url'] ?? ''));

        unset($dados['origem'], $dados['back_url']);

        try {
            $id = $this->service->abrir($dados);
        } catch (RuntimeException $exception) {
            return back()->withInput()->withErrors(['ocorrencia' => $exception->getMessage()]);
        }

        $parametrosRedirecionamento = ['id' => $id];
        if ($origem !== '') {
            $parametrosRedirecionamento['origem'] = $origem;
        }
        if ($backUrl !== null) {
            $parametrosRedirecionamento['back_url'] = $backUrl;
        }

        return redirect()
            ->route('nat.ocorrencias.show', $parametrosRedirecionamento)
            ->with('status', 'Ocorrência registrada com sucesso.');
    }

    public function show(Request $request, int $id): View|JsonResponse
    {
        $ocorrencia = $this->repository->buscar(
            $id,
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas()
        );

        if ($ocorrencia === null) {
            abort(404);
        }

        $eventos = $this->eventoService->listarPorOcorrencia($id);

        if ($request->ajax()) {
            return response()->json([
                'html' => ViewFacade::make('nat.ocorrencias.partials.detalhes-lazy', [
                    'ocorrencia' => $ocorrencia,
                    'eventos' => $eventos,
                ])->render(),
            ]);
        }

        $backUrl = $this->normalizarBackUrl((string) $request->query('back_url', ''));
        $origem = $this->normalizarOrigem((string) $request->query('origem', ''));

        return view('nat.ocorrencias.show', [
            'ocorrencia' => $ocorrencia,
            'eventos' => $eventos,
            'origem' => $origem,
            'backUrl' => $backUrl,
        ]);
    }

    public function locais(Request $request): JsonResponse
    {
        return response()->json($this->localSecaoRepository->pesquisarLocais(
            trim((string) $request->query('q', '')),
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas()
        ));
    }

    public function secoes(Request $request): JsonResponse
    {
        $codObjetoLocal = trim((string) $request->query('cod_objeto_local_votacao', ''));
        if ($codObjetoLocal === '') {
            return response()->json([]);
        }

        $local = $this->localSecaoRepository->buscarLocal($codObjetoLocal);
        if ($local === null || !$this->localEstaNoEscopo($local)) {
            return response()->json([]);
        }

        return response()->json($this->localSecaoRepository->listarSecoesPorLocal($codObjetoLocal));
    }

    public function rotasElegiveis(Request $request): JsonResponse
    {
        $codObjetoLocal = trim((string) $request->query('cod_objeto_local_votacao', ''));
        if ($codObjetoLocal === '') {
            return response()->json(['automatica' => null, 'rotas' => []]);
        }

        $local = $this->localSecaoRepository->buscarLocal($codObjetoLocal);
        if ($local === null || !$this->localEstaNoEscopo($local)) {
            return response()->json(['automatica' => null, 'rotas' => []]);
        }

        $automatica = $this->localSecaoRepository->buscarRotaAutomaticaPorLocal($codObjetoLocal);

        return response()->json([
            'automatica' => $automatica ? (array) $automatica : null,
            'rotas' => $this->localSecaoRepository->listarRotasElegiveisPorLocal($codObjetoLocal),
        ]);
    }

    public function detalhesMapa(Request $request): JsonResponse
    {
        $codObjetoLocal = trim((string) $request->query('cod_objeto_local_votacao', ''));
        $rotaId = (int) $request->query('rota_id', 0);

        if ($codObjetoLocal === '' || $rotaId <= 0) {
            return response()->json([
                'html' => '<div class="alert alert-warning mb-0 small">Local ou rota não informados.</div>',
            ], 422);
        }

        $ocorrencias = $this->repository->listarAtivasPorLocalERota(
            $codObjetoLocal,
            $rotaId,
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas()
        );

        return response()->json([
            'html' => ViewFacade::make('nat.ocorrencias.partials.mapa-detalhes-modal', [
                'ocorrencias' => $ocorrencias,
                'rotaId' => $rotaId,
                'codObjetoLocalVotacao' => $codObjetoLocal,
            ])->render(),
            'total' => count($ocorrencias),
        ]);
    }

    private function localEstaNoEscopo(object $local): bool
    {
        if ($this->escopoService->acessoTodasZonas()) {
            return true;
        }

        return in_array((int) ($local->zona_numero ?? 0), $this->escopoService->zonasPermitidas(), true);
    }

    private function normalizarOrigem(string $origem): string
    {
        return trim($origem);
    }

    private function normalizarBackUrl(string $backUrl): ?string
    {
        $url = trim($backUrl);
        if ($url === '') {
            return null;
        }

        if (Str::startsWith($url, ['/'])) {
            return $url;
        }

        $host = (string) parse_url($url, PHP_URL_HOST);
        if ($host === '') {
            return null;
        }

        $hostAtual = (string) parse_url(url('/'), PHP_URL_HOST);
        if ($hostAtual !== '' && strcasecmp($host, $hostAtual) === 0) {
            $path = (string) parse_url($url, PHP_URL_PATH);
            $query = (string) parse_url($url, PHP_URL_QUERY);

            if ($path === '') {
                $path = '/';
            }

            return $query !== '' ? $path . '?' . $query : $path;
        }

        return null;
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATOCORRENCIACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatOcorrenciaExternaController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATOCORRENCIAEXTERNACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatOcorrenciaExternaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatOcorrenciaExternaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function form(Request $request): View|RedirectResponse
public function store(NatAbrirOcorrenciaRequest $request): RedirectResponse
public function show(Request $request, int $id): View|JsonResponse
public function locais(Request $request): JsonResponse
public function secoes(Request $request): JsonResponse
public function rotasElegiveis(Request $request): JsonResponse
public function detalhesMapa(Request $request): JsonResponse
public function assumir(Request $request, int $id): RedirectResponse|JsonResponse
public function finalizar(NatAtualizarStatusRequest $request, int $id): RedirectResponse|JsonResponse
private function routeNames(): array
private function erroAcao(Request $request, string $mensagem): RedirectResponse|JsonResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Nat;

use App\Http\Controllers\Controller;

use App\Http\Requests\Nat\NatAbrirOcorrenciaRequest;
use App\Http\Requests\Nat\NatAtualizarStatusRequest;
use App\Repositories\Nat\NatExternoRepository;
use App\Repositories\Nat\NatLocalSecaoRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use App\Services\Nat\NatExternoSessionService;
use App\Services\Nat\NatOcorrenciaEventoService;
use App\Services\Nat\NatOcorrenciaService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\View as ViewFacade;
use Illuminate\Support\Str;
use Illuminate\View\View;
use RuntimeException;

class NatOcorrenciaExternaController extends Controller
{
    public function __construct(
        private readonly NatOcorrenciaRepository $repository,
        private readonly NatTipoOcorrenciaRepository $tipoRepository,
        private readonly NatLocalSecaoRepository $localSecaoRepository,
        private readonly NatExternoRepository $externoRepository,
        private readonly NatOcorrenciaService $service,
        private readonly NatOcorrenciaEventoService $eventoService,
        private readonly NatExternoSessionService $externalSession,
    ) {
    }

    public function form(Request $request): View|RedirectResponse
    {
        if (!$this->operacaoHabilitada('permite_abertura_ocorrencia')) {
            return redirect()
                ->route('nat.externo.painel.index')
                ->with('erro', 'A abertura de ocorrencias no NAT externo nao esta habilitada no momento.');
        }

        $codObjetoLocal = trim((string) session()->getOldInput('cod_objeto_local_votacao', ''));
        $localSelecionado = null;
        $secoesIniciais = [];
        $rotasIniciais = ['automatica' => null, 'rotas' => []];
        $origem = $this->normalizarOrigem((string) $request->query('origem', session()->getOldInput('origem', '')));
        $backUrl = $this->normalizarBackUrl((string) $request->query('back_url', session()->getOldInput('back_url', '')));

        if ($codObjetoLocal !== '' && $this->externoRepository->localPertenceAoConjuntoRotas($codObjetoLocal, $this->externalSession->rotasIds($request))) {
            $localSelecionado = $this->localSecaoRepository->buscarLocal($codObjetoLocal);
            $secoesIniciais = $this->localSecaoRepository->listarSecoesPorLocal($codObjetoLocal);
            $rotasIniciais = [
                'automatica' => $this->externoRepository->buscarRotaAutomaticaPorLocalNoConjunto($codObjetoLocal, $this->externalSession->rotasIds($request)),
                'rotas' => $this->externoRepository->listarRotasElegiveisPorLocalNoConjunto($codObjetoLocal, $this->externalSession->rotasIds($request)),
            ];
        }

        return view('nat.ocorrencias.form', [
            'tipos' => $this->tipoRepository->listarAtivos(),
            'localSelecionado' => $localSelecionado,
            'secoesIniciais' => $secoesIniciais,
            'rotasIniciais' => $rotasIniciais,
            'origem' => $origem,
            'backUrl' => $backUrl,
            'routeNames' => $this->routeNames(),
            'layout' => 'layouts.nat-externo-publico',
            'modoExterno' => true,
        ]);
    }

    public function store(NatAbrirOcorrenciaRequest $request): RedirectResponse
    {
        if (!$this->operacaoHabilitada('permite_abertura_ocorrencia')) {
            return back()->withInput()->withErrors([
                'ocorrencia' => 'A abertura de ocorrencias no NAT externo nao esta habilitada no momento.',
            ]);
        }

        $dados = $request->validated();
        $origem = $this->normalizarOrigem((string) ($dados['origem'] ?? ''));
        $backUrl = $this->normalizarBackUrl((string) ($dados['back_url'] ?? ''));
        unset($dados['origem'], $dados['back_url']);

        if (!$this->externoRepository->localPertenceAoConjuntoRotas((string) $dados['cod_objeto_local_votacao'], $this->externalSession->rotasIds($request))) {
            return back()->withInput()->withErrors(['cod_objeto_local_votacao' => 'O local informado nao pertence a uma rota autorizada na sua sessao externa.']);
        }

        if (!empty($dados['rota_id']) && !$this->externalSession->rotaPermitida($request, (int) $dados['rota_id'])) {
            return back()->withInput()->withErrors(['rota_id' => 'A rota informada nao pertence ao conjunto autorizado na sua sessao externa.']);
        }

        try {
            $id = $this->service->abrir($dados);
        } catch (RuntimeException $exception) {
            return back()->withInput()->withErrors(['ocorrencia' => $exception->getMessage()]);
        }

        $parametros = ['id' => $id];
        if ($origem !== '') {
            $parametros['origem'] = $origem;
        }
        if ($backUrl !== null) {
            $parametros['back_url'] = $backUrl;
        }

        return redirect()
            ->route('nat.externo.ocorrencias.show', $parametros)
            ->with('status', 'Ocorrencia registrada com sucesso.');
    }

    public function show(Request $request, int $id): View|JsonResponse
    {
        $ocorrencia = $this->repository->buscar($id, $this->externalSession->zonas($request), false);
        if ($ocorrencia === null || !$this->externalSession->rotaPermitida($request, (int) $ocorrencia->rota_id)) {
            abort(404);
        }

        $eventos = $this->eventoService->listarPorOcorrencia($id);

        if ($request->ajax()) {
            return response()->json([
                'html' => ViewFacade::make('nat.ocorrencias.partials.detalhes-lazy', [
                    'ocorrencia' => $ocorrencia,
                    'eventos' => $eventos,
                ])->render(),
            ]);
        }

        $backUrl = $this->normalizarBackUrl((string) $request->query('back_url', ''));
        $origem = $this->normalizarOrigem((string) $request->query('origem', ''));

        return view('nat.ocorrencias.show', [
            'ocorrencia' => $ocorrencia,
            'eventos' => $eventos,
            'origem' => $origem,
            'backUrl' => $backUrl,
            'routeNames' => $this->routeNames(),
            'layout' => 'layouts.nat-externo-publico',
            'modoExterno' => true,
        ]);
    }

    public function locais(Request $request): JsonResponse
    {
        return response()->json(
            $this->externoRepository->pesquisarLocaisPorRotas(
                trim((string) $request->query('q', '')),
                $this->externalSession->rotasIds($request)
            )
        );
    }

    public function secoes(Request $request): JsonResponse
    {
        $codObjetoLocal = trim((string) $request->query('cod_objeto_local_votacao', ''));
        if ($codObjetoLocal === '' || !$this->externoRepository->localPertenceAoConjuntoRotas($codObjetoLocal, $this->externalSession->rotasIds($request))) {
            return response()->json([]);
        }

        return response()->json($this->localSecaoRepository->listarSecoesPorLocal($codObjetoLocal));
    }

    public function rotasElegiveis(Request $request): JsonResponse
    {
        $codObjetoLocal = trim((string) $request->query('cod_objeto_local_votacao', ''));
        if ($codObjetoLocal === '' || !$this->externoRepository->localPertenceAoConjuntoRotas($codObjetoLocal, $this->externalSession->rotasIds($request))) {
            return response()->json(['automatica' => null, 'rotas' => []]);
        }

        return response()->json([
            'automatica' => $this->externoRepository->buscarRotaAutomaticaPorLocalNoConjunto($codObjetoLocal, $this->externalSession->rotasIds($request)),
            'rotas' => $this->externoRepository->listarRotasElegiveisPorLocalNoConjunto($codObjetoLocal, $this->externalSession->rotasIds($request)),
        ]);
    }

    public function detalhesMapa(Request $request): JsonResponse
    {
        $codObjetoLocal = trim((string) $request->query('cod_objeto_local_votacao', ''));
        $rotaId = (int) $request->query('rota_id', 0);
        if ($codObjetoLocal === '' || $rotaId <= 0 || !$this->externalSession->rotaPermitida($request, $rotaId)) {
            return response()->json([
                'html' => '<div class="alert alert-warning mb-0 small">Local ou rota nao informados.</div>',
            ], 422);
        }

        $ocorrencias = $this->repository->listarAtivasPorLocalERota($codObjetoLocal, $rotaId, $this->externalSession->zonas($request), false);

        return response()->json([
            'html' => ViewFacade::make('nat.ocorrencias.partials.mapa-detalhes-modal', [
                'ocorrencias' => $ocorrencias,
                'rotaId' => $rotaId,
                'codObjetoLocalVotacao' => $codObjetoLocal,
                'routeNames' => $this->routeNames(),
                'modoExterno' => true,
            ])->render(),
            'total' => count($ocorrencias),
        ]);
    }

    public function assumir(Request $request, int $id): RedirectResponse|JsonResponse
    {
        if (!$this->operacaoHabilitada('permite_assumir_ocorrencia')) {
            return $this->erroAcao($request, 'A acao de assumir ocorrencias no NAT externo nao esta habilitada no momento.');
        }

        $rotaId = (int) $request->input('rota_id', 0);
        if ($rotaId <= 0 || !$this->externalSession->rotaPermitida($request, $rotaId)) {
            return $this->erroAcao($request, 'A ocorrencia nao pertence a uma rota autorizada na sua sessao externa.');
        }

        try {
            $this->service->iniciarAtendimento($id, $rotaId);
        } catch (RuntimeException $exception) {
            return $this->erroAcao($request, $exception->getMessage());
        }

        if ($request->ajax()) {
            return response()->json(['mensagem' => 'Ocorrencia colocada em andamento.']);
        }

        return back()->with('status', 'Ocorrencia colocada em andamento.');
    }

    public function finalizar(NatAtualizarStatusRequest $request, int $id): RedirectResponse|JsonResponse
    {
        if (!$this->operacaoHabilitada('permite_finalizar_ocorrencia')) {
            return $this->erroAcao($request, 'A acao de finalizar ocorrencias no NAT externo nao esta habilitada no momento.');
        }

        $rotaId = (int) $request->input('rota_id', 0);
        if ($rotaId <= 0 || !$this->externalSession->rotaPermitida($request, $rotaId)) {
            return $this->erroAcao($request, 'A ocorrencia nao pertence a uma rota autorizada na sua sessao externa.');
        }

        try {
            $this->service->finalizar($id, (string) $request->input('descricao_resolucao', ''), $rotaId);
        } catch (RuntimeException $exception) {
            return $this->erroAcao($request, $exception->getMessage());
        }

        if ($request->ajax()) {
            return response()->json(['mensagem' => 'Ocorrencia finalizada com sucesso.']);
        }

        return back()->with('status', 'Ocorrencia finalizada com sucesso.');
    }

    private function routeNames(): array
    {
        return [
            'painel_index' => 'nat.externo.painel.index',
            'painel_dados' => 'nat.externo.painel.dados',
            'painel_monitoramento_dados' => 'nat.externo.painel.monitoramento-dados',
            'painel_mapa_dados' => 'nat.externo.painel.mapa-dados',
            'ocorrencia_form' => 'nat.externo.ocorrencias.form',
            'ocorrencia_store' => 'nat.externo.ocorrencias.store',
            'ocorrencia_show' => 'nat.externo.ocorrencias.show',
            'ocorrencia_locais' => 'nat.externo.ocorrencias.locais',
            'ocorrencia_secoes' => 'nat.externo.ocorrencias.secoes',
            'ocorrencia_rotas_elegiveis' => 'nat.externo.ocorrencias.rotas-elegiveis',
            'ocorrencia_mapa_detalhes' => 'nat.externo.ocorrencias.mapa-detalhes',
            'ocorrencia_assumir' => 'nat.externo.ocorrencias.assumir',
            'ocorrencia_finalizar' => 'nat.externo.ocorrencias.finalizar',
            'logout' => 'nat.externo.logout',
        ];
    }

    private function erroAcao(Request $request, string $mensagem): RedirectResponse|JsonResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem], 422);
        }

        return back()->with('erro', $mensagem);
    }

    private function normalizarOrigem(string $origem): string
    {
        return trim($origem);
    }

    private function normalizarBackUrl(string $backUrl): ?string
    {
        $url = trim($backUrl);
        if ($url === '') {
            return null;
        }

        if (Str::startsWith($url, ['/'])) {
            return $url;
        }

        $host = (string) parse_url($url, PHP_URL_HOST);
        if ($host === '') {
            return null;
        }

        $hostAtual = (string) parse_url(url('/'), PHP_URL_HOST);
        if ($hostAtual !== '' && strcasecmp($host, $hostAtual) === 0) {
            $path = (string) parse_url($url, PHP_URL_PATH);
            $query = (string) parse_url($url, PHP_URL_QUERY);

            if ($path === '') {
                $path = '/';
            }

            return $query !== '' ? $path . '?' . $query : $path;
        }

        return null;
    }

    private function operacaoHabilitada(string $campo): bool
    {
        $config = $this->externoRepository->buscarConfiguracaoAtiva();
        if ($config === null) {
            return false;
        }

        return ($config[$campo] ?? 'N') === 'S';
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATOCORRENCIAEXTERNACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatTipoOcorrenciaController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATTIPOOCORRENCIACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatTipoOcorrenciaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatTipoOcorrenciaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request): View
public function form(?int $id = null): View
public function store(NatTipoOcorrenciaRequest $request): RedirectResponse
public function update(NatTipoOcorrenciaRequest $request, int $id): RedirectResponse
public function destroy(Request $request, int $id): RedirectResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Nat;

use App\Http\Controllers\Controller;

use App\Http\Requests\Nat\NatTipoOcorrenciaRequest;
use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use App\Services\Nat\NatTipoOcorrenciaService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use RuntimeException;

class NatTipoOcorrenciaController extends Controller
{
    public function __construct(
        private readonly NatTipoOcorrenciaRepository $repository,
        private readonly NatTipoOcorrenciaService $service,
    ) {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));
        $ativo = trim((string) $request->query('ativo', ''));

        return view('nat.tipos.index', [
            'tipos' => $this->repository->listar($busca !== '' ? $busca : null, $ativo !== '' ? $ativo : null),
            'busca' => $busca,
            'ativo' => $ativo,
        ]);
    }

    public function form(?int $id = null): View
    {
        $tipo = $id !== null ? $this->repository->buscar($id) : null;
        if ($id !== null && $tipo === null) {
            abort(404);
        }

        return view('nat.tipos.form', compact('tipo'));
    }

    public function store(NatTipoOcorrenciaRequest $request): RedirectResponse
    {
        try {
            $this->service->criar($request->validated());
        } catch (RuntimeException $exception) {
            return back()->withInput()->withErrors(['nome' => $exception->getMessage()]);
        }

        return redirect()->route('tabelas-auxiliares.nat-tipos-ocorrencia.index')->with('status', 'Tipo de ocorrência criado com sucesso.');
    }

    public function update(NatTipoOcorrenciaRequest $request, int $id): RedirectResponse
    {
        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        try {
            $this->service->atualizar($id, $request->validated());
        } catch (RuntimeException $exception) {
            return back()->withInput()->withErrors(['nome' => $exception->getMessage()]);
        }

        return redirect()->route('tabelas-auxiliares.nat-tipos-ocorrencia.index')->with('status', 'Tipo de ocorrência atualizado com sucesso.');
    }

    public function destroy(Request $request, int $id): RedirectResponse
    {
        $this->repository->remover($id);

        return redirect()->route('tabelas-auxiliares.nat-tipos-ocorrencia.index')->with('status', 'Tipo de ocorrência excluído com sucesso.');
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATTIPOOCORRENCIACONTROLLER_PHP>

