# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_controllers_scde`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 7 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Scde/ScdeConfiguracaoController.php`
## <APP_HTTP_CONTROLLERS_SCDE_SCDECONFIGURACAOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Scde/ScdeConfiguracaoController.php`
- **Namespace Declaração:** `App\Http\Controllers\Scde`
- **Entidade / Classe:** `class ScdeConfiguracaoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(ScdeConfiguracaoFiltroRequest $request): View
public function form(?int $id = null): View|RedirectResponse
public function store(ScdeConfiguracaoRequest $request): RedirectResponse
public function update(ScdeConfiguracaoRequest $request, int $id): RedirectResponse
public function destroy(int $id): RedirectResponse
public function ativar(int $id): RedirectResponse
public function desativar(int $id): RedirectResponse
public function status(): JsonResponse
public function exportarPdf(ScdeConfiguracaoFiltroRequest $request): Response
private function filtros(ScdeConfiguracaoFiltroRequest $request): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Scde;

use App\Http\Controllers\Controller;
use App\Http\Requests\Scde\ScdeConfiguracaoFiltroRequest;
use App\Http\Requests\Scde\ScdeConfiguracaoRequest;
use App\Repositories\Scde\ScdeConfiguracaoRepository;
use App\Services\Scde\ScdeConfiguracaoService;
use App\Services\Scde\ScdeStatusService;
use App\Support\Exportacao\CamposPdfSelecionados;
use Barryvdh\DomPDF\Facade\Pdf;
use DomainException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\View\View;

class ScdeConfiguracaoController extends Controller
{
    private const CAMPOS_PDF = [
        'contexto' => 'Pleito / eleição',
        'status' => 'Status',
        'ativacao' => 'Ativação',
        'ultima_tentativa' => 'Última tentativa',
        'ultimo_sucesso' => 'Último sucesso',
        'ultimo_erro' => 'Último erro',
        'duracao' => 'Duração',
        'totais' => 'Totais',
    ];

    private const CAMPOS_PDF_PADRAO = [
        'contexto', 'status', 'ultima_tentativa', 'ultimo_sucesso', 'ultimo_erro', 'totais',
    ];

    public function __construct(
        private readonly ScdeConfiguracaoRepository $repository,
        private readonly ScdeConfiguracaoService $service,
        private readonly ScdeStatusService $statusService,
    ) {
    }

    public function index(ScdeConfiguracaoFiltroRequest $request): View
    {
        $this->autorizarAdmin();
        [$codPleito, $codEleicao, $ativo] = $this->filtros($request);
        $configuracoes = $this->repository->listar($codPleito, $codEleicao, $ativo);
        $configuracoes->appends($request->query());

        return view('administracao-global.scde.index', [
            'configuracoes' => $configuracoes,
            'filtros' => $request->validated(),
            'statusScde' => $this->statusService->atual(),
            'camposPdf' => self::CAMPOS_PDF,
            'camposPdfPadrao' => self::CAMPOS_PDF_PADRAO,
        ]);
    }

    public function form(?int $id = null): View|RedirectResponse
    {
        $this->autorizarAdmin();
        $configuracao = $id === null ? null : $this->repository->buscar($id);
        if ($id !== null && $configuracao === null) {
            abort(404);
        }
        if ($configuracao !== null && (int) $configuracao['ativo'] === 1) {
            return redirect()->route('administracao-global.scde.index')
                ->withErrors(['scde' => 'Desative a configuração antes de editá-la.']);
        }

        return view('administracao-global.scde.form', compact('configuracao'));
    }

    public function store(ScdeConfiguracaoRequest $request): RedirectResponse
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()->route('administracao-global.scde.index')
            ->with('status', 'Configuração SCDE criada. Ative-a para iniciar no próximo ciclo do scheduler.');
    }

    public function update(ScdeConfiguracaoRequest $request, int $id): RedirectResponse
    {
        $this->autorizarAdmin();
        try {
            $this->repository->atualizar($id, $request->validated());
        } catch (DomainException $exception) {
            return back()->withInput()->withErrors(['scde' => $exception->getMessage()]);
        }

        return redirect()->route('administracao-global.scde.index')->with('status', 'Configuração SCDE atualizada.');
    }

    public function destroy(int $id): RedirectResponse
    {
        $this->autorizarAdmin();
        try {
            $this->repository->excluir($id);
        } catch (DomainException $exception) {
            return back()->withErrors(['scde' => $exception->getMessage()]);
        }

        return redirect()->route('administracao-global.scde.index')->with('status', 'Configuração SCDE excluída.');
    }

    public function ativar(int $id): RedirectResponse
    {
        $this->autorizarAdmin();
        try {
            $this->service->ativar($id);
        } catch (DomainException $exception) {
            return back()->withErrors(['scde' => $exception->getMessage()]);
        }

        return back()->with('status', 'Sincronização ativada. A primeira execução ocorrerá em até 60 segundos.');
    }

    public function desativar(int $id): RedirectResponse
    {
        $this->autorizarAdmin();
        try {
            $this->service->desativar($id);
        } catch (DomainException $exception) {
            return back()->withErrors(['scde' => $exception->getMessage()]);
        }

        return back()->with('status', 'Sincronização desativada. O último snapshot foi preservado.');
    }

    public function status(): JsonResponse
    {
        $this->autorizarAdmin();
        return response()->json(['status' => $this->statusService->atual()]);
    }

    public function exportarPdf(ScdeConfiguracaoFiltroRequest $request): Response
    {
        $this->autorizarAdmin();
        [$codPleito, $codEleicao, $ativo] = $this->filtros($request);
        $campos = CamposPdfSelecionados::resolver(
            $request->query('campos'),
            self::CAMPOS_PDF,
            self::CAMPOS_PDF_PADRAO,
        );

        return Pdf::loadView('administracao-global.scde.pdf', [
            'configuracoes' => $this->repository->listarTodos($codPleito, $codEleicao, $ativo),
            'campos' => $campos,
            'rotulos' => self::CAMPOS_PDF,
            'geradoEm' => now()->format('d/m/Y H:i'),
        ])->setPaper('a4', 'landscape')->download('configuracoes-scde.pdf');
    }

    /** @return array{?int,?int,?bool} */
    private function filtros(ScdeConfiguracaoFiltroRequest $request): array
    {
        $dados = $request->validated();

        return [
            isset($dados['cod_pleito']) ? (int) $dados['cod_pleito'] : null,
            isset($dados['cod_eleicao']) ? (int) $dados['cod_eleicao'] : null,
            array_key_exists('ativo', $dados) && $dados['ativo'] !== null && $dados['ativo'] !== ''
                ? (bool) (int) $dados['ativo']
                : null,
        ];
    }
}
```
</APP_HTTP_CONTROLLERS_SCDE_SCDECONFIGURACAOCONTROLLER_PHP>

