# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_disque_eleicao`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 55  
> **Tamanho do Arquivo:** 242 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Exports/DisqueEleicao/DisqueEleicaoRelatorioExport.php`
## <APP_EXPORTS_DISQUEELEICAO_DISQUEELEICAORELATORIOEXPORT_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Exports/DisqueEleicao/DisqueEleicaoRelatorioExport.php`
- **Namespace Declaração:** `App\Exports\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioExport implements WithMultipleSheets`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function sheets(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Exports\DisqueEleicao;

use Maatwebsite\Excel\Concerns\WithMultipleSheets;

class DisqueEleicaoRelatorioExport implements WithMultipleSheets
{
    /**
     * @param array<string, mixed> $consolidado
     * @param array<int, array<string, mixed>> $registros
     */
    public function __construct(
        private readonly array $consolidado,
        private readonly array $registros,
    ) {
    }

    public function sheets(): array
    {
        return [
            new DisqueEleicaoSheet('Resumo', [
                ['Indicador', 'Valor'],
                ['Total de atendimentos', (int) ($this->consolidado['total'] ?? 0)],
            ]),
            new DisqueEleicaoSheet('Assuntos', array_merge(
                [['Código', 'Assunto', 'Quantidade', 'Percentual']],
                array_map(static fn (array $item): array => [
                    $item['codigo'] ?? '',
                    $item['descricao'] ?? '',
                    (int) ($item['quantidade'] ?? 0),
                    (float) ($item['percentual'] ?? 0),
                ], (array) ($this->consolidado['assuntos'] ?? [])),
            )),
            new DisqueEleicaoSheet('Domicílios', array_merge(
                [['Código', 'Domicílio', 'Quantidade']],
                array_map(static fn (array $item): array => [
                    $item['codigo'] ?? '',
                    $item['descricao'] ?? '',
                    (int) ($item['quantidade'] ?? 0),
                ], (array) ($this->consolidado['domicilios'] ?? [])),
            )),
            new DisqueEleicaoSheet('Atendentes', array_merge(
                [['Login', 'Nome', 'Quantidade']],
                array_map(static fn (array $item): array => [
                    $item['login'] ?? '',
                    $item['nome'] ?? '',
                    (int) ($item['quantidade'] ?? 0),
                ], (array) ($this->consolidado['atendentes'] ?? [])),
            )),
            new DisqueEleicaoSheet('Períodos', array_merge(
                [['Tipo', 'Período', 'Quantidade']],
                array_map(static fn (array $item): array => [
                    $item['tipo'] ?? '',
                    $item['periodo'] ?? '',
                    (int) ($item['quantidade'] ?? 0),
                ], (array) ($this->consolidado['periodos'] ?? [])),
            )),
            new DisqueEleicaoSheet('Registros', array_merge(
                [['Data', 'Assunto', 'Complemento', 'Domicílio', 'Atendente', 'Login', 'Lote']],
                array_map(static fn (array $item): array => [
                    $item['data_atendimento'] ?? '',
                    $item['assunto'] ?? '',
                    $item['outros_complemento'] ?? '',
                    $item['domicilio'] ?? '',
                    $item['usuario_nome'] ?? '',
                    $item['usuario_login'] ?? '',
                    $item['lote_uuid'] ?? '',
                ], $this->registros),
            )),
        ];
    }
}
```
</APP_EXPORTS_DISQUEELEICAO_DISQUEELEICAORELATORIOEXPORT_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Exports/DisqueEleicao/DisqueEleicaoSheet.php`
## <APP_EXPORTS_DISQUEELEICAO_DISQUEELEICAOSHEET_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Exports/DisqueEleicao/DisqueEleicaoSheet.php`
- **Namespace Declaração:** `App\Exports\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoSheet implements FromArray, WithTitle`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function title(): string
public function array(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Exports\DisqueEleicao;

use App\Support\Exportacao\CelulaPlanilhaSegura;
use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithTitle;

class DisqueEleicaoSheet implements FromArray, WithTitle
{
    /** @param array<int, array<int, mixed>> $linhas */
    public function __construct(
        private readonly string $titulo,
        private readonly array $linhas,
    ) {
    }

    public function title(): string
    {
        return mb_substr($this->titulo, 0, 31, 'UTF-8');
    }

    public function array(): array
    {
        return array_map(static fn (array $linha): array => array_map(
            static fn (mixed $valor): mixed => is_string($valor) ? CelulaPlanilhaSegura::texto($valor) : $valor,
            $linha,
        ), $this->linhas);
    }
}
```
</APP_EXPORTS_DISQUEELEICAO_DISQUEELEICAOSHEET_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/DisqueEleicao/DisqueEleicaoAssuntoController.php`
## <APP_HTTP_CONTROLLERS_DISQUEELEICAO_DISQUEELEICAOASSUNTOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/DisqueEleicao/DisqueEleicaoAssuntoController.php`
- **Namespace Declaração:** `App\Http\Controllers\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoAssuntoController extends Controller`

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
public function store(DisqueEleicaoAssuntoRequest $request): RedirectResponse
public function update(DisqueEleicaoAssuntoRequest $request, int $id): RedirectResponse
public function destroy(int $id): RedirectResponse
public function exportarPdf(Request $request): Response
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\DisqueEleicao;

use App\Http\Controllers\Controller;
use App\Http\Requests\DisqueEleicao\DisqueEleicaoAssuntoRequest;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAssuntoRepositoryInterface;
use App\Services\DisqueEleicao\DisqueEleicaoAssuntoService;
use App\Support\Exportacao\CamposPdfSelecionados;
use Barryvdh\DomPDF\Facade\Pdf;
use DomainException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\View\View;

class DisqueEleicaoAssuntoController extends Controller
{
    private const CAMPOS_PDF = [
        'codigo' => 'Código',
        'descricao' => 'Descrição',
        'ordem' => 'Ordem',
        'status' => 'Status',
    ];

    private const CAMPOS_PDF_PADRAO = ['codigo', 'descricao', 'ordem', 'status'];

    public function __construct(
        private readonly DisqueEleicaoAssuntoRepositoryInterface $repository,
        private readonly DisqueEleicaoAssuntoService $service,
    ) {
    }

    public function index(Request $request): View
    {
        $this->autorizarAdmin();
        $busca = trim((string) $request->query('busca', ''));
        $assuntos = $this->repository->listar($busca !== '' ? $busca : null);
        $assuntos->appends($request->query());

        return view('tabelas-auxiliares.disque-eleicao-assuntos.index', [
            'assuntos' => $assuntos,
            'busca' => $busca,
            'camposPdf' => self::CAMPOS_PDF,
            'camposPdfPadrao' => self::CAMPOS_PDF_PADRAO,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $assunto = $id !== null ? $this->repository->buscar($id) : null;
        if ($id !== null && $assunto === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.disque-eleicao-assuntos.form', compact('assunto'));
    }

    public function store(DisqueEleicaoAssuntoRequest $request): RedirectResponse
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());
        return redirect()->route('tabelas-auxiliares.disque-eleicao-assuntos.index')
            ->with('status', 'Assunto criado com sucesso.');
    }

    public function update(DisqueEleicaoAssuntoRequest $request, int $id): RedirectResponse
    {
        $this->autorizarAdmin();
        if ($this->repository->buscar($id) === null) {
            abort(404);
        }
        $this->repository->atualizar($id, $request->validated());
        return redirect()->route('tabelas-auxiliares.disque-eleicao-assuntos.index')
            ->with('status', 'Assunto atualizado com sucesso.');
    }

    public function destroy(int $id): RedirectResponse
    {
        $this->autorizarAdmin();
        try {
            $resultado = $this->service->removerOuInativar($id);
        } catch (DomainException $exception) {
            return back()->withErrors(['assunto' => $exception->getMessage()]);
        }

        return redirect()->route('tabelas-auxiliares.disque-eleicao-assuntos.index')
            ->with('status', $resultado === 'inativado' ? 'Assunto em uso foi inativado.' : 'Assunto excluído com sucesso.');
    }

    public function exportarPdf(Request $request): Response
    {
        $this->autorizarAdmin();
        $busca = trim((string) $request->query('busca', ''));
        $campos = CamposPdfSelecionados::resolver($request->query('campos'), self::CAMPOS_PDF, self::CAMPOS_PDF_PADRAO);

        return Pdf::loadView('tabelas-auxiliares.disque-eleicao-assuntos.pdf', [
            'assuntos' => $this->repository->listarTodos($busca !== '' ? $busca : null),
            'campos' => $campos,
            'rotulos' => self::CAMPOS_PDF,
            'geradoEm' => now()->format('d/m/Y H:i'),
        ])->setPaper('a4', 'landscape')->download('disque-eleicao-assuntos.pdf');
    }
}
```
</APP_HTTP_CONTROLLERS_DISQUEELEICAO_DISQUEELEICAOASSUNTOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/DisqueEleicao/DisqueEleicaoController.php`
## <APP_HTTP_CONTROLLERS_DISQUEELEICAO_DISQUEELEICAOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/DisqueEleicao/DisqueEleicaoController.php`
- **Namespace Declaração:** `App\Http\Controllers\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoController extends Controller`

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
public function store(StoreDisqueEleicaoAtendimentoRequest $request): RedirectResponse
public function edit(int $id): View
public function update(UpdateDisqueEleicaoAtendimentoRequest $request, int $id): RedirectResponse
public function destroy(int $id): RedirectResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\DisqueEleicao;

use App\Http\Controllers\Controller;
use App\Http\Requests\DisqueEleicao\StoreDisqueEleicaoAtendimentoRequest;
use App\Http\Requests\DisqueEleicao\UpdateDisqueEleicaoAtendimentoRequest;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAtendimentoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoCatalogoRepositoryInterface;
use App\Services\DisqueEleicao\DisqueEleicaoAtendimentoService;
use App\Services\DisqueEleicao\DisqueEleicaoContextoSessao;
use App\Services\DisqueEleicao\DisqueEleicaoPermissaoService;
use DomainException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\View\View;

class DisqueEleicaoController extends Controller
{
    public function __construct(
        private readonly DisqueEleicaoCatalogoRepositoryInterface $catalogo,
        private readonly DisqueEleicaoAtendimentoRepositoryInterface $repository,
        private readonly DisqueEleicaoAtendimentoService $service,
        private readonly DisqueEleicaoContextoSessao $contextoSessao,
        private readonly DisqueEleicaoPermissaoService $permissoes,
    ) {
    }

    public function index(Request $request): View
    {
        $contexto = $this->contextoSessao->atual();
        $this->autorizarRotaMacro($contexto->macroprojetoId);
        $historico = $this->repository->listarHistorico([], $contexto->macroprojetoId, $contexto->turno);
        $historico->appends($request->query());

        return view('disque-eleicao.index', [
            'assuntos' => $this->catalogo->listarAssuntosAtivos(),
            'domicilios' => $this->catalogo->listarDomicilios(),
            'historico' => $historico,
            'loteUuid' => (string) Str::uuid(),
            'usuarioLogin' => $contexto->usuarioLogin,
            'grupos' => (array) session('matchingGroups', []),
            'permissoes' => $this->permissoes,
        ]);
    }

    public function store(StoreDisqueEleicaoAtendimentoRequest $request): RedirectResponse
    {
        $contexto = $this->contextoSessao->atual();
        $this->autorizarRotaMacro($contexto->macroprojetoId);

        try {
            $quantidade = $this->service->registrar($request->validated(), $contexto);
        } catch (DomainException $exception) {
            return back()->withErrors(['atendimento' => $exception->getMessage()])->withInput();
        }

        return redirect()->route('disque-eleicao.index')
            ->with('status', $quantidade.' atendimento(s) registrado(s) com sucesso.');
    }

    public function edit(int $id): View
    {
        $contexto = $this->contextoSessao->atual();
        $this->autorizarRotaMacro($contexto->macroprojetoId);
        $registro = $this->repository->buscarNoContexto($id, $contexto->macroprojetoId, $contexto->turno);
        if ($registro === null) {
            abort(404);
        }
        if (!$this->permissoes->podeAlterar(
            (string) ($registro['usuario_login'] ?? ''),
            $contexto->usuarioLogin,
            (array) session('matchingGroups', []),
        )) {
            abort(403, 'Você não pode alterar este atendimento.');
        }

        $assuntos = $this->catalogo->listarAssuntosAtivos();
        $assuntoAtualId = (int) ($registro['assunto_id'] ?? 0);
        if (!in_array($assuntoAtualId, array_column($assuntos, 'id'), true)) {
            array_unshift($assuntos, [
                'id' => $assuntoAtualId,
                'codigo' => (string) ($registro['assunto_codigo'] ?? ''),
                'descricao' => (string) ($registro['assunto_descricao'] ?? '').' (inativo)',
            ]);
        }

        return view('disque-eleicao.edit', [
            'registro' => $registro,
            'assuntos' => $assuntos,
            'domicilios' => $this->catalogo->listarDomicilios(),
        ]);
    }

    public function update(UpdateDisqueEleicaoAtendimentoRequest $request, int $id): RedirectResponse
    {
        $contexto = $this->contextoSessao->atual();
        $this->autorizarRotaMacro($contexto->macroprojetoId);

        try {
            $this->service->atualizar($id, $request->validated(), $contexto);
        } catch (DomainException $exception) {
            return back()->withErrors(['atendimento' => $exception->getMessage()])->withInput();
        }

        return redirect()->route('disque-eleicao.index')->with('status', 'Atendimento atualizado com sucesso.');
    }

    public function destroy(int $id): RedirectResponse
    {
        $contexto = $this->contextoSessao->atual();
        $this->autorizarRotaMacro($contexto->macroprojetoId);

        try {
            $this->service->excluir($id, $contexto);
        } catch (DomainException $exception) {
            return back()->withErrors(['atendimento' => $exception->getMessage()]);
        }

        return redirect()->route('disque-eleicao.index')->with('status', 'Atendimento excluído e auditado.');
    }
}
```
</APP_HTTP_CONTROLLERS_DISQUEELEICAO_DISQUEELEICAOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/DisqueEleicao/DisqueEleicaoRelatorioController.php`
## <APP_HTTP_CONTROLLERS_DISQUEELEICAO_DISQUEELEICAORELATORIOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/DisqueEleicao/DisqueEleicaoRelatorioController.php`
- **Namespace Declaração:** `App\Http\Controllers\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(DisqueEleicaoRelatorioRequest $request): View
public function pdf(DisqueEleicaoRelatorioRequest $request): Response
public function xlsx(DisqueEleicaoRelatorioRequest $request): BinaryFileResponse
private function contextoEFiltros(DisqueEleicaoRelatorioRequest $request): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\DisqueEleicao;

use App\Exports\DisqueEleicao\DisqueEleicaoRelatorioExport;
use App\Http\Controllers\Controller;
use App\Http\Requests\DisqueEleicao\DisqueEleicaoRelatorioRequest;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoCatalogoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoRelatorioRepositoryInterface;
use App\Services\DisqueEleicao\DisqueEleicaoContextoSessao;
use App\Services\DisqueEleicao\DisqueEleicaoRelatorioService;
use App\Support\Exportacao\CamposPdfSelecionados;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Response;
use Illuminate\View\View;
use Maatwebsite\Excel\Facades\Excel;
use Symfony\Component\HttpFoundation\BinaryFileResponse;

class DisqueEleicaoRelatorioController extends Controller
{
    private const CAMPOS_PDF = [
        'data_atendimento' => 'Data e hora',
        'assunto' => 'Assunto',
        'complemento' => 'Complemento',
        'domicilio' => 'Domicílio eleitoral',
        'atendente' => 'Atendente',
        'lote' => 'Lote',
    ];

    private const CAMPOS_PDF_PADRAO = ['data_atendimento', 'assunto', 'domicilio', 'atendente'];

    public function __construct(
        private readonly DisqueEleicaoRelatorioRepositoryInterface $repository,
        private readonly DisqueEleicaoCatalogoRepositoryInterface $catalogo,
        private readonly DisqueEleicaoRelatorioService $service,
        private readonly DisqueEleicaoContextoSessao $contextoSessao,
    ) {
    }

    public function index(DisqueEleicaoRelatorioRequest $request): View
    {
        [$contexto, $filtros] = $this->contextoEFiltros($request);
        $detalhes = $this->repository->listarDetalhes($filtros, $contexto->macroprojetoId, $contexto->turno);
        $detalhes->appends($request->query());

        return view('disque-eleicao.relatorios.index', [
            'consolidado' => $this->service->consolidar($filtros, $contexto->macroprojetoId, $contexto->turno),
            'detalhes' => $detalhes,
            'filtros' => $filtros,
            'assuntos' => $this->catalogo->listarAssuntosAtivos(),
            'domicilios' => $this->catalogo->listarDomicilios(),
            'camposPdf' => self::CAMPOS_PDF,
            'camposPdfPadrao' => self::CAMPOS_PDF_PADRAO,
        ]);
    }

    public function pdf(DisqueEleicaoRelatorioRequest $request): Response
    {
        [$contexto, $filtros] = $this->contextoEFiltros($request);
        $campos = CamposPdfSelecionados::resolver(
            $request->input('campos'),
            self::CAMPOS_PDF,
            self::CAMPOS_PDF_PADRAO,
        );

        return Pdf::loadView('disque-eleicao.relatorios.pdf', [
            'consolidado' => $this->service->consolidar($filtros, $contexto->macroprojetoId, $contexto->turno),
            'registros' => $this->repository->listarDetalhesParaExportacao($filtros, $contexto->macroprojetoId, $contexto->turno),
            'campos' => $campos,
            'rotulos' => self::CAMPOS_PDF,
            'filtros' => $filtros,
            'geradoEm' => now()->format('d/m/Y H:i'),
        ])->setPaper('a4', 'landscape')->download('disque-eleicao-relatorio.pdf');
    }

    public function xlsx(DisqueEleicaoRelatorioRequest $request): BinaryFileResponse
    {
        [$contexto, $filtros] = $this->contextoEFiltros($request);
        $consolidado = $this->service->consolidar($filtros, $contexto->macroprojetoId, $contexto->turno);
        $registros = $this->repository->listarDetalhesParaExportacao($filtros, $contexto->macroprojetoId, $contexto->turno);

        return Excel::download(new DisqueEleicaoRelatorioExport($consolidado, $registros), 'disque-eleicao-relatorio.xlsx');
    }

    /** @return array{0:\App\Services\DisqueEleicao\DisqueEleicaoContexto,1:array<string, mixed>} */
    private function contextoEFiltros(DisqueEleicaoRelatorioRequest $request): array
    {
        $contexto = $this->contextoSessao->atual();
        $this->autorizarRotaMacro($contexto->macroprojetoId);
        $filtros = $request->safe()->except('campos');

        return [$contexto, $filtros];
    }
}
```
</APP_HTTP_CONTROLLERS_DISQUEELEICAO_DISQUEELEICAORELATORIOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/DisqueEleicao/DisqueEleicaoAssuntoRequest.php`
## <APP_HTTP_REQUESTS_DISQUEELEICAO_DISQUEELEICAOASSUNTOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/DisqueEleicao/DisqueEleicaoAssuntoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoAssuntoRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rules(): array
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\DisqueEleicao;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class DisqueEleicaoAssuntoRequest extends CodigoDescricaoOrdemAtivoRequest
{
    /** @return array<string, mixed> */
    public function rules(): array
    {
        $regras = parent::rules();
        $regras['codigo'] = array_map(
            static fn (mixed $regra): mixed => $regra === 'max:20' ? 'max:40' : $regra,
            $regras['codigo'],
        );

        return $regras;
    }

    protected function tabela(): string
    {
        return 'disque_eleicao_assunto';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'do assunto', 'entidade' => 'um assunto'];
    }
}
```
</APP_HTTP_REQUESTS_DISQUEELEICAO_DISQUEELEICAOASSUNTOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/DisqueEleicao/DisqueEleicaoRelatorioRequest.php`
## <APP_HTTP_REQUESTS_DISQUEELEICAO_DISQUEELEICAORELATORIOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/DisqueEleicao/DisqueEleicaoRelatorioRequest.php`
- **Namespace Declaração:** `App\Http\Requests\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioRequest extends FormRequest`

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

namespace App\Http\Requests\DisqueEleicao;

use App\Services\DisqueEleicao\DisqueEleicaoPermissaoService;
use Illuminate\Foundation\Http\FormRequest;

class DisqueEleicaoRelatorioRequest extends FormRequest
{
    public function authorize(): bool
    {
        return app(DisqueEleicaoPermissaoService::class)->podeOperar((array) session('matchingGroups', []));
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'data_inicio' => ['nullable', 'date_format:Y-m-d'],
            'data_fim' => ['nullable', 'date_format:Y-m-d', 'after_or_equal:data_inicio'],
            'assunto_id' => ['nullable', 'integer', 'min:1'],
            'domicilio_codigo' => ['nullable', 'string', 'max:30'],
            'usuario_login' => ['nullable', 'string', 'max:160'],
            'campos' => ['nullable', 'array'],
            'campos.*' => ['string', 'max:40'],
        ];
    }

    protected function prepareForValidation(): void
    {
        foreach (['data_inicio', 'data_fim', 'domicilio_codigo', 'usuario_login'] as $campo) {
            if ($this->has($campo)) {
                $this->merge([$campo => trim((string) $this->input($campo, '')) ?: null]);
            }
        }
    }
}
```
</APP_HTTP_REQUESTS_DISQUEELEICAO_DISQUEELEICAORELATORIOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/DisqueEleicao/StoreDisqueEleicaoAtendimentoRequest.php`
## <APP_HTTP_REQUESTS_DISQUEELEICAO_STOREDISQUEELEICAOATENDIMENTOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/DisqueEleicao/StoreDisqueEleicaoAtendimentoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\DisqueEleicao`
- **Entidade / Classe:** `class StoreDisqueEleicaoAtendimentoRequest extends FormRequest`

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

namespace App\Http\Requests\DisqueEleicao;

use App\Services\DisqueEleicao\DisqueEleicaoPermissaoService;
use Illuminate\Foundation\Http\FormRequest;

class StoreDisqueEleicaoAtendimentoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return app(DisqueEleicaoPermissaoService::class)->podeOperar((array) session('matchingGroups', []));
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'lote_uuid' => ['required', 'uuid'],
            'assunto_ids' => ['required', 'array', 'min:1'],
            'assunto_ids.*' => ['required', 'integer', 'min:1', 'distinct:strict'],
            'domicilio_codigo' => ['required', 'string', 'max:30'],
            'outros_complemento' => ['nullable', 'string', 'max:300'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'lote_uuid' => mb_strtolower(trim((string) $this->input('lote_uuid', '')), 'UTF-8'),
            'domicilio_codigo' => trim((string) $this->input('domicilio_codigo', '')),
            'outros_complemento' => trim((string) $this->input('outros_complemento', '')),
        ]);
    }

    /** @return array<string, string> */
    public function messages(): array
    {
        return [
            'assunto_ids.required' => 'Selecione ao menos um assunto.',
            'assunto_ids.*.distinct' => 'Não repita o mesmo assunto.',
            'domicilio_codigo.required' => 'Informe o domicílio eleitoral.',
        ];
    }
}
```
</APP_HTTP_REQUESTS_DISQUEELEICAO_STOREDISQUEELEICAOATENDIMENTOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/DisqueEleicao/UpdateDisqueEleicaoAtendimentoRequest.php`
## <APP_HTTP_REQUESTS_DISQUEELEICAO_UPDATEDISQUEELEICAOATENDIMENTOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/DisqueEleicao/UpdateDisqueEleicaoAtendimentoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\DisqueEleicao`
- **Entidade / Classe:** `class UpdateDisqueEleicaoAtendimentoRequest extends FormRequest`

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

namespace App\Http\Requests\DisqueEleicao;

use App\Services\DisqueEleicao\DisqueEleicaoPermissaoService;
use Illuminate\Foundation\Http\FormRequest;

class UpdateDisqueEleicaoAtendimentoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return app(DisqueEleicaoPermissaoService::class)->podeOperar((array) session('matchingGroups', []));
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'assunto_id' => ['required', 'integer', 'min:1'],
            'domicilio_codigo' => ['required', 'string', 'max:30'],
            'outros_complemento' => ['nullable', 'string', 'max:300'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'domicilio_codigo' => trim((string) $this->input('domicilio_codigo', '')),
            'outros_complemento' => trim((string) $this->input('outros_complemento', '')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_DISQUEELEICAO_UPDATEDISQUEELEICAOATENDIMENTOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoLoteRequest.php`
## <APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZOLOTEREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Tarefas/TarefaSolicitacaoPrazoLoteRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Tarefas`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoLoteRequest extends TarefaSolicitacaoPrazoBaseRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rules(): array
protected function prepareForValidation(): void
public function messages(): array
public function withValidator(Validator $validator): void
private function normalizarListaIds(mixed $valor): array
private function normalizarListaTextos(mixed $valor, bool $maiusculo = false): array
private function normalizarFlag(mixed $valor): string
private function normalizarTextoLivre(mixed $valor): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\Tarefas;

use Illuminate\Validation\Validator;

class TarefaSolicitacaoPrazoLoteRequest extends TarefaSolicitacaoPrazoBaseRequest
{
    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'SELECIONAR_CONSULTA_COMPLETA' => ['nullable', 'in:0,1'],
            'TAREFA_IDS' => ['nullable', 'array'],
            'TAREFA_IDS.*' => ['integer', 'min:1'],
            'projeto_id' => ['nullable', 'array'],
            'projeto_id.*' => ['integer', 'min:1'],
            'subprojeto_id' => ['nullable', 'array'],
            'subprojeto_id.*' => ['integer', 'min:1'],
            'unidade_id' => ['nullable', 'array'],
            'unidade_id.*' => ['integer', 'min:1'],
            'categoria_id' => ['nullable', 'array'],
            'categoria_id.*' => ['integer', 'min:1'],
            'fase_id' => ['nullable', 'array'],
            'fase_id.*' => ['integer', 'min:1'],
            'status' => ['nullable', 'array'],
            'status.*' => ['string'],
            'busca_texto' => ['nullable', 'string', 'max:500'],
            'ordenar_prev_inicio' => ['nullable', 'in:0,1'],
            ...parent::rules(),
        ];
    }

    protected function prepareForValidation(): void
    {
        parent::prepareForValidation();

        $this->merge([
            'SELECIONAR_CONSULTA_COMPLETA' => $this->normalizarFlag($this->input('SELECIONAR_CONSULTA_COMPLETA')),
            'TAREFA_IDS' => $this->normalizarListaIds($this->input('TAREFA_IDS', [])),
            'projeto_id' => $this->normalizarListaIds($this->input('projeto_id', [])),
            'subprojeto_id' => $this->normalizarListaIds($this->input('subprojeto_id', [])),
            'unidade_id' => $this->normalizarListaIds($this->input('unidade_id', [])),
            'categoria_id' => $this->normalizarListaIds($this->input('categoria_id', [])),
            'fase_id' => $this->normalizarListaIds($this->input('fase_id', [])),
            'status' => $this->normalizarListaTextos($this->input('status', []), true),
            'busca_texto' => $this->normalizarTextoLivre($this->input('busca_texto')),
            'ordenar_prev_inicio' => $this->normalizarFlag($this->input('ordenar_prev_inicio')),
        ]);
    }

    /** @return array<string, string> */
    public function messages(): array
    {
        return [
            ...parent::messages(),
            'TAREFA_IDS.array' => 'A lista de atividades selecionadas é inválida.',
            'TAREFA_IDS.*.integer' => 'A lista de atividades selecionadas é inválida.',
            'TAREFA_IDS.*.min' => 'A lista de atividades selecionadas é inválida.',
        ];
    }

    public function withValidator(Validator $validator): void
    {
        parent::withValidator($validator);

        $validator->after(function (Validator $validator): void {
            $consultaCompleta = (string) $this->input('SELECIONAR_CONSULTA_COMPLETA', '0') === '1';
            $ids = $this->input('TAREFA_IDS', []);
            if (! $consultaCompleta && empty($ids)) {
                $validator->errors()->add(
                    'TAREFA_IDS',
                    'Selecione ao menos uma atividade para a solicitação em lote.'
                );
            }
        });
    }

    /** @return array<int, mixed> */
    private function normalizarListaIds(mixed $valor): array
    {
        return collect($valor ?? [])
            ->flatten()
            ->map(function (mixed $item): mixed {
                $texto = trim((string) $item);

                return ctype_digit($texto) ? (int) $texto : $item;
            })
            ->filter(fn (mixed $item): bool => $item !== null && $item !== '')
            ->values()
            ->all();
    }

    /** @return array<int, string> */
    private function normalizarListaTextos(mixed $valor, bool $maiusculo = false): array
    {
        return collect($valor ?? [])
            ->flatten()
            ->map(function (mixed $item) use ($maiusculo): ?string {
                $texto = trim((string) $item);
                if ($texto === '') {
                    return null;
                }

                return $maiusculo ? mb_strtoupper($texto, 'UTF-8') : $texto;
            })
            ->filter()
            ->unique()
            ->values()
            ->all();
    }

    private function normalizarFlag(mixed $valor): string
    {
        return (string) ((string) $valor === '1' ? '1' : '0');
    }

    private function normalizarTextoLivre(mixed $valor): string
    {
        return is_string($valor) ? trim($valor) : '';
    }
}
```
</APP_HTTP_REQUESTS_TAREFAS_TAREFASOLICITACAOPRAZOLOTEREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoAssuntoRepositoryInterface.php`
## <APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAOASSUNTOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoAssuntoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao\Contracts`
- **Entidade / Classe:** `interface DisqueEleicaoAssuntoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $porPagina = 15): LengthAwarePaginator;
public function listarTodos(?string $busca = null): array;
public function buscar(int $id): ?object;
public function criar(array $dados): int;
public function atualizar(int $id, array $dados): int;
public function inativar(int $id): int;
public function remover(int $id): int;
public function possuiAtendimentos(int $id): bool;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface DisqueEleicaoAssuntoRepositoryInterface
{
    public function listar(?string $busca = null, int $porPagina = 15): LengthAwarePaginator;

    /** @return array<int, object> */
    public function listarTodos(?string $busca = null): array;

    public function buscar(int $id): ?object;

    /** @param array<string, mixed> $dados */
    public function criar(array $dados): int;

    /** @param array<string, mixed> $dados */
    public function atualizar(int $id, array $dados): int;

    public function inativar(int $id): int;

    public function remover(int $id): int;

    public function possuiAtendimentos(int $id): bool;
}
```
</APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAOASSUNTOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoAtendimentoRepositoryInterface.php`
## <APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAOATENDIMENTOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoAtendimentoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao\Contracts`
- **Entidade / Classe:** `interface DisqueEleicaoAtendimentoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function loteJaRegistrado(string $loteUuid): bool;
public function assuntoJaExisteNoLote(string $loteUuid, int $assuntoId, int $ignorarId): bool;
public function criarLote(array $linhas): int;
public function buscarNoContexto(int $id, int $macroprojetoId, string $turno): ?array;
public function atualizarNoContexto(int $id, array $dados, int $macroprojetoId, string $turno): int;
public function removerNoContexto(int $id, int $macroprojetoId, string $turno): int;
public function listarHistorico(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 15): LengthAwarePaginator;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface DisqueEleicaoAtendimentoRepositoryInterface
{
    public function loteJaRegistrado(string $loteUuid): bool;

    public function assuntoJaExisteNoLote(string $loteUuid, int $assuntoId, int $ignorarId): bool;

    /** @param array<int, array<string, mixed>> $linhas */
    public function criarLote(array $linhas): int;

    /** @return array<string, mixed>|null */
    public function buscarNoContexto(int $id, int $macroprojetoId, string $turno): ?array;

    /** @param array<string, mixed> $dados */
    public function atualizarNoContexto(int $id, array $dados, int $macroprojetoId, string $turno): int;

    public function removerNoContexto(int $id, int $macroprojetoId, string $turno): int;

    /** @param array<string, mixed> $filtros */
    public function listarHistorico(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 15): LengthAwarePaginator;
}
```
</APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAOATENDIMENTOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoCatalogoRepositoryInterface.php`
## <APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAOCATALOGOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoCatalogoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao\Contracts`
- **Entidade / Classe:** `interface DisqueEleicaoCatalogoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarAssuntosAtivos(): array;
public function buscarAssuntosAtivosPorIds(array $ids): array;
public function listarDomicilios(): array;
public function buscarDomicilio(string $codigo): ?array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao\Contracts;

interface DisqueEleicaoCatalogoRepositoryInterface
{
    /** @return array<int, array{id:int,codigo:string,descricao:string}> */
    public function listarAssuntosAtivos(): array;

    /**
     * @param array<int, int> $ids
     * @return array<int, array{id:int,codigo:string,descricao:string}>
     */
    public function buscarAssuntosAtivosPorIds(array $ids): array;

    /** @return array<int, array{codigo:string,descricao:string}> */
    public function listarDomicilios(): array;

    /** @return array{codigo:string,descricao:string}|null */
    public function buscarDomicilio(string $codigo): ?array;
}
```
</APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAOCATALOGOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoRelatorioRepositoryInterface.php`
## <APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAORELATORIOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/Contracts/DisqueEleicaoRelatorioRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao\Contracts`
- **Entidade / Classe:** `interface DisqueEleicaoRelatorioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function consolidar(array $filtros, int $macroprojetoId, string $turno): array;
public function listarDetalhes(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 20): LengthAwarePaginator;
public function listarDetalhesParaExportacao(array $filtros, int $macroprojetoId, string $turno): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface DisqueEleicaoRelatorioRepositoryInterface
{
    /**
     * @param array<string, mixed> $filtros
     * @return array<string, mixed>
     */
    public function consolidar(array $filtros, int $macroprojetoId, string $turno): array;

    /** @param array<string, mixed> $filtros */
    public function listarDetalhes(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 20): LengthAwarePaginator;

    /**
     * @param array<string, mixed> $filtros
     * @return array<int, array<string, mixed>>
     */
    public function listarDetalhesParaExportacao(array $filtros, int $macroprojetoId, string $turno): array;
}
```
</APP_REPOSITORIES_DISQUEELEICAO_CONTRACTS_DISQUEELEICAORELATORIOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/DisqueEleicaoAssuntoRepository.php`
## <APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAOASSUNTOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/DisqueEleicaoAssuntoRepository.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoAssuntoRepository implements DisqueEleicaoAssuntoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('disque_eleicao_assunto')->where('id', $id)->first();
return DB::table('disque_eleicao_atendimento')->where('assunto_id', $id)->exists();
$query = DB::table('disque_eleicao_assunto')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $porPagina = 15): LengthAwarePaginator
public function listarTodos(?string $busca = null): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function inativar(int $id): int
public function remover(int $id): int
public function possuiAtendimentos(int $id): bool
private function consulta(?string $busca): Builder
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAssuntoRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;

class DisqueEleicaoAssuntoRepository implements DisqueEleicaoAssuntoRepositoryInterface
{
    use AuditaDml;

    public function listar(?string $busca = null, int $porPagina = 15): LengthAwarePaginator
    {
        return $this->consulta($busca)->orderBy('ordem')->orderBy('descricao')->paginate($porPagina);
    }

    public function listarTodos(?string $busca = null): array
    {
        return $this->consulta($busca)->orderBy('ordem')->orderBy('descricao')->get()->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('disque_eleicao_assunto')->where('id', $id)->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado('disque_eleicao_assunto', 'DISQUE_ELEICAO_ASSUNTO', [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'ativo' => !empty($dados['ativo']) ? 1 : 0,
            'dt_criacao' => DB::raw('SYSDATE'),
        ], 'id');
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('disque_eleicao_assunto', 'DISQUE_ELEICAO_ASSUNTO', 'id', $id, [
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'ativo' => !empty($dados['ativo']) ? 1 : 0,
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function inativar(int $id): int
    {
        return $this->atualizarAuditadoPorId('disque_eleicao_assunto', 'DISQUE_ELEICAO_ASSUNTO', 'id', $id, [
            'ativo' => 0,
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('disque_eleicao_assunto', 'DISQUE_ELEICAO_ASSUNTO', 'id', $id);
    }

    public function possuiAtendimentos(int $id): bool
    {
        return DB::table('disque_eleicao_atendimento')->where('assunto_id', $id)->exists();
    }

    private function consulta(?string $busca): Builder
    {
        $query = DB::table('disque_eleicao_assunto')
            ->selectRaw("id, codigo, descricao, ordem, ativo, TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') AS dt_criacao_fmt, TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') AS dt_atualizacao_fmt");
        if ($busca !== null && trim($busca) !== '') {
            $like = '%'.mb_strtoupper(trim($busca), 'UTF-8').'%';
            $query->where(static function (Builder $sub) use ($like): void {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query;
    }
}
```
</APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAOASSUNTOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/DisqueEleicaoAtendimentoRepository.php`
## <APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAOATENDIMENTOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/DisqueEleicaoAtendimentoRepository.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoAtendimentoRepository implements DisqueEleicaoAtendimentoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('disque_eleicao_atendimento')->where('lote_uuid', $loteUuid)->exists();
return DB::table('disque_eleicao_atendimento')
return DB::table('disque_eleicao_atendimento as a')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function loteJaRegistrado(string $loteUuid): bool
public function assuntoJaExisteNoLote(string $loteUuid, int $assuntoId, int $ignorarId): bool
public function criarLote(array $linhas): int
public function buscarNoContexto(int $id, int $macroprojetoId, string $turno): ?array
public function atualizarNoContexto(int $id, array $dados, int $macroprojetoId, string $turno): int
public function removerNoContexto(int $id, int $macroprojetoId, string $turno): int
public function listarHistorico(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 15): LengthAwarePaginator
private function consultaDetalhada(): Builder
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAtendimentoRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

class DisqueEleicaoAtendimentoRepository implements DisqueEleicaoAtendimentoRepositoryInterface
{
    use AuditaDml;

    public function loteJaRegistrado(string $loteUuid): bool
    {
        return DB::table('disque_eleicao_atendimento')->where('lote_uuid', $loteUuid)->exists();
    }

    public function assuntoJaExisteNoLote(string $loteUuid, int $assuntoId, int $ignorarId): bool
    {
        return DB::table('disque_eleicao_atendimento')
            ->where('lote_uuid', $loteUuid)
            ->where('assunto_id', $assuntoId)
            ->where('id', '<>', $ignorarId)
            ->exists();
    }

    public function criarLote(array $linhas): int
    {
        if ($linhas === []) {
            return 0;
        }

        $lotes = array_values(array_unique(array_map(
            static fn (array $linha): string => trim((string) ($linha['lote_uuid'] ?? '')),
            $linhas,
        )));
        if (count($lotes) !== 1 || $lotes[0] === '') {
            throw new InvalidArgumentException('O lote auditado deve possuir um único UUID.');
        }

        $dados = array_map(static fn (array $linha): array => $linha + [
            'dt_atendimento' => DB::raw('SYSDATE'),
        ], $linhas);
        $loteUuid = $lotes[0];
        $inseriu = $this->inserirLoteAuditado(
            'disque_eleicao_atendimento',
            'DISQUE_ELEICAO_ATENDIMENTO',
            $dados,
            $loteUuid,
            static fn (Builder $query): Builder => $query->where('lote_uuid', $loteUuid),
        );

        return $inseriu ? count($dados) : 0;
    }

    public function buscarNoContexto(int $id, int $macroprojetoId, string $turno): ?array
    {
        $item = $this->consultaDetalhada()
            ->where('a.id', $id)
            ->where('a.macroprojeto_id', $macroprojetoId)
            ->where('a.turno', (int) $turno)
            ->first();

        return $item !== null ? (array) $item : null;
    }

    public function atualizarNoContexto(int $id, array $dados, int $macroprojetoId, string $turno): int
    {
        $permitidos = array_flip([
            'assunto_id',
            'domicilio_codigo',
            'domicilio_descricao',
            'outros_complemento',
            'usuario_atualizacao',
        ]);
        $payload = array_intersect_key($dados, $permitidos) + ['dt_atualizacao' => DB::raw('SYSDATE')];
        $escopo = static fn (Builder $query): Builder => $query
            ->where('id', $id)
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('turno', (int) $turno);

        return $this->atualizarEscopoAuditado(
            'disque_eleicao_atendimento',
            'DISQUE_ELEICAO_ATENDIMENTO',
            $id,
            $escopo,
            $payload,
            ['id' => $id, 'macroprojeto_id' => $macroprojetoId, 'turno' => $turno],
        );
    }

    public function removerNoContexto(int $id, int $macroprojetoId, string $turno): int
    {
        $escopo = static fn (Builder $query): Builder => $query
            ->where('id', $id)
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('turno', (int) $turno);

        return $this->removerEscopoAuditado(
            'disque_eleicao_atendimento',
            'DISQUE_ELEICAO_ATENDIMENTO',
            $id,
            $escopo,
            ['id' => $id, 'macroprojeto_id' => $macroprojetoId, 'turno' => $turno],
        );
    }

    public function listarHistorico(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 15): LengthAwarePaginator
    {
        $query = $this->consultaDetalhada()
            ->where('a.macroprojeto_id', $macroprojetoId)
            ->where('a.turno', (int) $turno);

        if (isset($filtros['usuario_login']) && trim((string) $filtros['usuario_login']) !== '') {
            $query->where('a.usuario_login', trim((string) $filtros['usuario_login']));
        }

        return $query->orderByDesc('a.dt_atendimento')->orderByDesc('a.id')->paginate($porPagina);
    }

    private function consultaDetalhada(): Builder
    {
        return DB::table('disque_eleicao_atendimento as a')
            ->join('disque_eleicao_assunto as s', 's.id', '=', 'a.assunto_id')
            ->selectRaw(<<<'SQL'
a.id,
a.assunto_id,
s.codigo AS assunto_codigo,
s.descricao AS assunto_descricao,
a.domicilio_codigo,
a.domicilio_descricao,
a.macroprojeto_id,
a.turno,
a.lote_uuid,
a.outros_complemento,
a.usuario_login,
a.usuario_nome,
a.dt_atendimento,
TO_CHAR(a.dt_atendimento, 'DD/MM/YYYY HH24:MI') AS dt_atendimento_fmt,
a.usuario_atualizacao,
a.dt_atualizacao
SQL);
    }
}
```
</APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAOATENDIMENTOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/DisqueEleicaoCatalogoRepository.php`
## <APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAOCATALOGOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/DisqueEleicaoCatalogoRepository.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoCatalogoRepository implements DisqueEleicaoCatalogoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('disque_eleicao_assunto')
return DB::table('disque_eleicao_assunto')
$municipios = DB::table('municipio')
$extras = DB::table('disque_eleicao_domicilio_extra')
$item = DB::table('municipio')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarAssuntosAtivos(): array
public function buscarAssuntosAtivosPorIds(array $ids): array
public function listarDomicilios(): array
public function buscarDomicilio(string $codigo): ?array
private static function mapearDomicilio(object $item): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoCatalogoRepositoryInterface;
use Illuminate\Support\Facades\DB;

class DisqueEleicaoCatalogoRepository implements DisqueEleicaoCatalogoRepositoryInterface
{
    public function listarAssuntosAtivos(): array
    {
        return DB::table('disque_eleicao_assunto')
            ->where('ativo', 1)
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get(['id', 'codigo', 'descricao'])
            ->map(static fn (object $item): array => [
                'id' => (int) $item->id,
                'codigo' => (string) $item->codigo,
                'descricao' => (string) $item->descricao,
            ])
            ->all();
    }

    public function buscarAssuntosAtivosPorIds(array $ids): array
    {
        if ($ids === []) {
            return [];
        }

        return DB::table('disque_eleicao_assunto')
            ->where('ativo', 1)
            ->whereIn('id', array_values(array_unique(array_map('intval', $ids))))
            ->get(['id', 'codigo', 'descricao'])
            ->map(static fn (object $item): array => [
                'id' => (int) $item->id,
                'codigo' => (string) $item->codigo,
                'descricao' => (string) $item->descricao,
            ])
            ->all();
    }

    public function listarDomicilios(): array
    {
        $municipios = DB::table('municipio')
            ->whereNotNull('cod_objeto_localidade')
            ->whereNotNull('localidade')
            ->selectRaw('cod_objeto_localidade AS codigo, MAX(localidade) AS descricao')
            ->groupBy('cod_objeto_localidade')
            ->orderByRaw('MAX(localidade)')
            ->get()
            ->map(self::mapearDomicilio(...))
            ->all();

        $extras = DB::table('disque_eleicao_domicilio_extra')
            ->where('ativo', 1)
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get(['codigo', 'descricao'])
            ->map(self::mapearDomicilio(...))
            ->all();

        return array_merge($municipios, $extras);
    }

    public function buscarDomicilio(string $codigo): ?array
    {
        $item = DB::table('municipio')
            ->where('cod_objeto_localidade', trim($codigo))
            ->whereNotNull('localidade')
            ->selectRaw('cod_objeto_localidade AS codigo, MAX(localidade) AS descricao')
            ->groupBy('cod_objeto_localidade')
            ->first();

        if ($item !== null) {
            return self::mapearDomicilio($item);
        }

        $item = DB::table('disque_eleicao_domicilio_extra')
            ->where('codigo', trim($codigo))
            ->where('ativo', 1)
            ->first(['codigo', 'descricao']);

        return $item === null ? null : self::mapearDomicilio($item);
    }

    /** @return array{codigo:string,descricao:string} */
    private static function mapearDomicilio(object $item): array
    {
        return [
            'codigo' => trim((string) $item->codigo),
            'descricao' => trim((string) $item->descricao),
        ];
    }
}
```
</APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAOCATALOGOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/DisqueEleicao/DisqueEleicaoRelatorioRepository.php`
## <APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAORELATORIOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/DisqueEleicao/DisqueEleicaoRelatorioRepository.php`
- **Namespace Declaração:** `App\Repositories\DisqueEleicao`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioRepository implements DisqueEleicaoRelatorioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('disque_eleicao_atendimento as a')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function consolidar(array $filtros, int $macroprojetoId, string $turno): array
public function listarDetalhes(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 20): LengthAwarePaginator
public function listarDetalhesParaExportacao(array $filtros, int $macroprojetoId, string $turno): array
private function consultaDetalhes(array $filtros, int $macroprojetoId, string $turno): Builder
private function consultaFiltrada(array $filtros, int $macroprojetoId, string $turno): Builder
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\DisqueEleicao;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoRelatorioRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;

class DisqueEleicaoRelatorioRepository implements DisqueEleicaoRelatorioRepositoryInterface
{
    public function consolidar(array $filtros, int $macroprojetoId, string $turno): array
    {
        $base = $this->consultaFiltrada($filtros, $macroprojetoId, $turno);
        $total = (int) (clone $base)->count('a.id');

        $assuntos = (clone $base)
            ->selectRaw('s.codigo AS codigo, s.descricao AS descricao, COUNT(*) AS quantidade')
            ->groupBy('s.codigo', 's.descricao', 's.ordem')
            ->orderBy('s.ordem')
            ->get()
            ->map(static fn (object $item): array => [
                'codigo' => (string) $item->codigo,
                'descricao' => (string) $item->descricao,
                'quantidade' => (int) $item->quantidade,
            ])->all();

        $domicilios = (clone $base)
            ->selectRaw('a.domicilio_codigo AS codigo, a.domicilio_descricao AS descricao, COUNT(*) AS quantidade')
            ->groupBy('a.domicilio_codigo', 'a.domicilio_descricao')
            ->orderBy('a.domicilio_descricao')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();

        $atendentes = (clone $base)
            ->selectRaw('a.usuario_login AS login, MAX(a.usuario_nome) AS nome, COUNT(*) AS quantidade')
            ->groupBy('a.usuario_login')
            ->orderByRaw('MAX(a.usuario_nome)')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();

        $dias = (clone $base)
            ->selectRaw("'DIA' AS tipo, TO_CHAR(a.dt_atendimento, 'YYYY-MM-DD') AS periodo, COUNT(*) AS quantidade")
            ->groupByRaw("TO_CHAR(a.dt_atendimento, 'YYYY-MM-DD')")
            ->orderByRaw("TO_CHAR(a.dt_atendimento, 'YYYY-MM-DD')")
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();
        $horas = (clone $base)
            ->selectRaw("'HORA' AS tipo, TO_CHAR(a.dt_atendimento, 'HH24') || ':00' AS periodo, COUNT(*) AS quantidade")
            ->groupByRaw("TO_CHAR(a.dt_atendimento, 'HH24')")
            ->orderByRaw("TO_CHAR(a.dt_atendimento, 'HH24')")
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();

        return [
            'total' => $total,
            'assuntos' => $assuntos,
            'domicilios' => $domicilios,
            'atendentes' => $atendentes,
            'periodos' => array_merge($dias, $horas),
        ];
    }

    public function listarDetalhes(array $filtros, int $macroprojetoId, string $turno, int $porPagina = 20): LengthAwarePaginator
    {
        return $this->consultaDetalhes($filtros, $macroprojetoId, $turno)
            ->orderByDesc('a.dt_atendimento')
            ->orderByDesc('a.id')
            ->paginate($porPagina);
    }

    public function listarDetalhesParaExportacao(array $filtros, int $macroprojetoId, string $turno): array
    {
        return $this->consultaDetalhes($filtros, $macroprojetoId, $turno)
            ->orderBy('a.dt_atendimento')
            ->orderBy('a.id')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();
    }

    private function consultaDetalhes(array $filtros, int $macroprojetoId, string $turno): Builder
    {
        return $this->consultaFiltrada($filtros, $macroprojetoId, $turno)
            ->selectRaw(<<<'SQL'
a.id,
TO_CHAR(a.dt_atendimento, 'DD/MM/YYYY HH24:MI') AS data_atendimento,
s.codigo AS assunto_codigo,
s.descricao AS assunto,
a.outros_complemento,
a.domicilio_codigo,
a.domicilio_descricao AS domicilio,
a.usuario_login,
a.usuario_nome,
a.lote_uuid
SQL);
    }

    private function consultaFiltrada(array $filtros, int $macroprojetoId, string $turno): Builder
    {
        $query = DB::table('disque_eleicao_atendimento as a')
            ->join('disque_eleicao_assunto as s', 's.id', '=', 'a.assunto_id')
            ->where('a.macroprojeto_id', $macroprojetoId)
            ->where('a.turno', (int) $turno);

        $inicio = trim((string) ($filtros['data_inicio'] ?? ''));
        if ($inicio !== '') {
            $query->whereRaw("a.dt_atendimento >= TO_DATE(?, 'YYYY-MM-DD')", [$inicio]);
        }
        $fim = trim((string) ($filtros['data_fim'] ?? ''));
        if ($fim !== '') {
            $query->whereRaw("a.dt_atendimento < TO_DATE(?, 'YYYY-MM-DD') + 1", [$fim]);
        }
        $assuntoId = (int) ($filtros['assunto_id'] ?? 0);
        if ($assuntoId > 0) {
            $query->where('a.assunto_id', $assuntoId);
        }
        $domicilio = trim((string) ($filtros['domicilio_codigo'] ?? ''));
        if ($domicilio !== '') {
            $query->where('a.domicilio_codigo', $domicilio);
        }
        $atendente = trim((string) ($filtros['usuario_login'] ?? ''));
        if ($atendente !== '') {
            $query->where('a.usuario_login', $atendente);
        }

        return $query;
    }
}
```
</APP_REPOSITORIES_DISQUEELEICAO_DISQUEELEICAORELATORIOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Rules/TelefoneRule.php`
## <APP_RULES_TELEFONERULE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Rules/TelefoneRule.php`
- **Namespace Declaração:** `App\Rules`
- **Entidade / Classe:** `class TelefoneRule implements ValidationRule`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function validate(string $attribute, mixed $value, Closure $fail): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Rules;

use App\Support\Validation\TelefoneBrasileiro;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class TelefoneRule implements ValidationRule
{
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($value !== null && $value !== '' && ! TelefoneBrasileiro::valido($value)) {
            $fail('Telefone inválido.');
        }
    }
}
```
</APP_RULES_TELEFONERULE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/DisqueEleicao/DisqueEleicaoAssuntoService.php`
## <APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOASSUNTOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/DisqueEleicao/DisqueEleicaoAssuntoService.php`
- **Namespace Declaração:** `App\Services\DisqueEleicao`
- **Entidade / Classe:** `final class DisqueEleicaoAssuntoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly DisqueEleicaoAssuntoRepositoryInterface $repository)
public function removerOuInativar(int $id): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\DisqueEleicao;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAssuntoRepositoryInterface;
use DomainException;

final class DisqueEleicaoAssuntoService
{
    public function __construct(private readonly DisqueEleicaoAssuntoRepositoryInterface $repository)
    {
    }

    public function removerOuInativar(int $id): string
    {
        $assunto = $this->repository->buscar($id);
        if ($assunto === null) {
            throw new DomainException('Assunto não encontrado.');
        }

        if (mb_strtoupper(trim((string) $assunto->codigo), 'UTF-8') === 'OUTROS') {
            throw new DomainException('OUTROS é um assunto reservado e não pode ser removido.');
        }

        if ($this->repository->possuiAtendimentos($id)) {
            $this->repository->inativar($id);
            return 'inativado';
        }

        $this->repository->remover($id);
        return 'removido';
    }
}
```
</APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOASSUNTOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/DisqueEleicao/DisqueEleicaoAtendimentoService.php`
## <APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOATENDIMENTOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/DisqueEleicao/DisqueEleicaoAtendimentoService.php`
- **Namespace Declaração:** `App\Services\DisqueEleicao`
- **Entidade / Classe:** `final class DisqueEleicaoAtendimentoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function registrar(array $dados, DisqueEleicaoContexto $contexto): int
public function excluir(int $id, DisqueEleicaoContexto $contexto): int
public function atualizar(int $id, array $dados, DisqueEleicaoContexto $contexto): int
private function obterRegistroEditavel(int $id, DisqueEleicaoContexto $contexto): array
private function validarContexto(DisqueEleicaoContexto $contexto): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\DisqueEleicao;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAtendimentoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoCatalogoRepositoryInterface;
use DomainException;

final class DisqueEleicaoAtendimentoService
{
    public function __construct(
        private readonly DisqueEleicaoCatalogoRepositoryInterface $catalogo,
        private readonly DisqueEleicaoAtendimentoRepositoryInterface $repository,
    ) {
    }

    /** @param array<string, mixed> $dados */
    public function registrar(array $dados, DisqueEleicaoContexto $contexto): int
    {
        $ids = array_values(array_map('intval', (array) ($dados['assunto_ids'] ?? [])));
        if ($ids === [] || in_array(0, $ids, true)) {
            throw new DomainException('Selecione ao menos um assunto válido.');
        }

        if (count($ids) !== count(array_unique($ids))) {
            throw new DomainException('Assuntos duplicados não são permitidos no mesmo atendimento.');
        }

        $this->validarContexto($contexto);
        $loteUuid = mb_strtolower(trim((string) ($dados['lote_uuid'] ?? '')), 'UTF-8');
        if (!preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/', $loteUuid)) {
            throw new DomainException('Identificador de lote inválido.');
        }

        if ($this->repository->loteJaRegistrado($loteUuid)) {
            throw new DomainException('Este atendimento já foi registrado.');
        }

        $assuntos = $this->catalogo->buscarAssuntosAtivosPorIds($ids);
        $porId = [];
        foreach ($assuntos as $assunto) {
            $porId[(int) $assunto['id']] = $assunto;
        }
        if (count($porId) !== count($ids)) {
            throw new DomainException('Um ou mais assuntos não existem ou estão inativos.');
        }

        $domicilioCodigo = trim((string) ($dados['domicilio_codigo'] ?? ''));
        $domicilio = $this->catalogo->buscarDomicilio($domicilioCodigo);
        if ($domicilio === null) {
            throw new DomainException('Domicílio eleitoral inválido.');
        }

        $complemento = trim((string) ($dados['outros_complemento'] ?? ''));
        if (mb_strlen($complemento, 'UTF-8') > 300) {
            throw new DomainException('O complemento de Outros deve ter no máximo 300 caracteres.');
        }

        $linhas = [];
        foreach ($ids as $id) {
            $assunto = $porId[$id];
            $ehOutros = mb_strtoupper((string) $assunto['codigo'], 'UTF-8') === 'OUTROS';
            if ($ehOutros && $complemento === '') {
                throw new DomainException('Informe o complemento do assunto Outros.');
            }

            $linhas[] = [
                'assunto_id' => $id,
                'domicilio_codigo' => (string) $domicilio['codigo'],
                'domicilio_descricao' => (string) $domicilio['descricao'],
                'macroprojeto_id' => $contexto->macroprojetoId,
                'turno' => $contexto->turno,
                'lote_uuid' => $loteUuid,
                'outros_complemento' => $ehOutros ? $complemento : null,
                'usuario_login' => trim($contexto->usuarioLogin),
                'usuario_nome' => trim($contexto->usuarioNome),
            ];
        }

        return $this->repository->criarLote($linhas);
    }

    public function excluir(int $id, DisqueEleicaoContexto $contexto): int
    {
        $this->obterRegistroEditavel($id, $contexto);

        return $this->repository->removerNoContexto(
            $id,
            $contexto->macroprojetoId,
            $contexto->turno,
        );
    }

    /** @param array<string, mixed> $dados */
    public function atualizar(int $id, array $dados, DisqueEleicaoContexto $contexto): int
    {
        $registro = $this->obterRegistroEditavel($id, $contexto);
        $assuntoId = (int) ($dados['assunto_id'] ?? 0);
        $assuntos = $assuntoId > 0 ? $this->catalogo->buscarAssuntosAtivosPorIds([$assuntoId]) : [];
        $assunto = count($assuntos) === 1 && (int) $assuntos[0]['id'] === $assuntoId
            ? $assuntos[0]
            : null;
        if ($assunto === null && (int) ($registro['assunto_id'] ?? 0) === $assuntoId) {
            $codigoAtual = trim((string) ($registro['assunto_codigo'] ?? ''));
            if ($codigoAtual !== '') {
                $assunto = [
                    'id' => $assuntoId,
                    'codigo' => $codigoAtual,
                    'descricao' => (string) ($registro['assunto_descricao'] ?? ''),
                ];
            }
        }
        if ($assunto === null) {
            throw new DomainException('Assunto inexistente ou inativo.');
        }

        $domicilio = $this->catalogo->buscarDomicilio(trim((string) ($dados['domicilio_codigo'] ?? '')));
        if ($domicilio === null) {
            throw new DomainException('Domicílio eleitoral inválido.');
        }

        $loteUuid = trim((string) ($registro['lote_uuid'] ?? ''));
        if ($this->repository->assuntoJaExisteNoLote($loteUuid, $assuntoId, $id)) {
            throw new DomainException('O assunto já existe neste lote de atendimento.');
        }

        $ehOutros = mb_strtoupper((string) $assunto['codigo'], 'UTF-8') === 'OUTROS';
        $complemento = trim((string) ($dados['outros_complemento'] ?? ''));
        if ($ehOutros && $complemento === '') {
            throw new DomainException('Informe o complemento do assunto Outros.');
        }
        if (mb_strlen($complemento, 'UTF-8') > 300) {
            throw new DomainException('O complemento de Outros deve ter no máximo 300 caracteres.');
        }

        return $this->repository->atualizarNoContexto($id, [
            'assunto_id' => $assuntoId,
            'domicilio_codigo' => (string) $domicilio['codigo'],
            'domicilio_descricao' => (string) $domicilio['descricao'],
            'outros_complemento' => $ehOutros ? $complemento : null,
            'usuario_atualizacao' => trim($contexto->usuarioLogin),
        ], $contexto->macroprojetoId, $contexto->turno);
    }

    /** @return array<string, mixed> */
    private function obterRegistroEditavel(int $id, DisqueEleicaoContexto $contexto): array
    {
        $this->validarContexto($contexto);
        $registro = $this->repository->buscarNoContexto($id, $contexto->macroprojetoId, $contexto->turno);
        if ($registro === null) {
            throw new DomainException('Atendimento não encontrado no contexto ativo.');
        }

        $proprietario = trim((string) ($registro['usuario_login'] ?? ''));
        $mesmoUsuario = mb_strtoupper($proprietario, 'UTF-8')
            === mb_strtoupper(trim($contexto->usuarioLogin), 'UTF-8');
        if (!$contexto->gestor && !$mesmoUsuario) {
            throw new DomainException('O atendente não pode alterar registros de outro usuário.');
        }

        return $registro;
    }

    private function validarContexto(DisqueEleicaoContexto $contexto): void
    {
        if ($contexto->macroprojetoId <= 0 || !in_array($contexto->turno, ['1', '2'], true)) {
            throw new DomainException('Contexto de macroprojeto e turno inválido.');
        }

        if (trim($contexto->usuarioLogin) === '') {
            throw new DomainException('Usuário autenticado inválido.');
        }
    }
}
```
</APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOATENDIMENTOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/DisqueEleicao/DisqueEleicaoContexto.php`
## <APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOCONTEXTO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/DisqueEleicao/DisqueEleicaoContexto.php`
- **Namespace Declaração:** `App\Services\DisqueEleicao`
- **Entidade / Classe:** `final readonly class DisqueEleicaoContexto`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\DisqueEleicao;

final readonly class DisqueEleicaoContexto
{
    public function __construct(
        public int $macroprojetoId,
        public string $turno,
        public string $usuarioLogin,
        public string $usuarioNome,
        public bool $gestor,
    ) {
    }
}
```
</APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOCONTEXTO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/DisqueEleicao/DisqueEleicaoContextoSessao.php`
## <APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOCONTEXTOSESSAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/DisqueEleicao/DisqueEleicaoContextoSessao.php`
- **Namespace Declaração:** `App\Services\DisqueEleicao`
- **Entidade / Classe:** `final class DisqueEleicaoContextoSessao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly DisqueEleicaoPermissaoService $permissoes) {}
public function atual(): DisqueEleicaoContexto
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\DisqueEleicao;

use DomainException;
use Illuminate\Auth\Access\AuthorizationException;

final class DisqueEleicaoContextoSessao
{
    public function __construct(private readonly DisqueEleicaoPermissaoService $permissoes) {}

    public function atual(): DisqueEleicaoContexto
    {
        $macroprojetoId = (int) session('macroprojeto_ativo_id', 0);
        $turno = trim((string) session('macroprojeto_ativo_turno', ''));
        $login = trim((string) session('user.username', ''));
        $nome = trim((string) session('user.name', $login));
        $grupos = (array) session('matchingGroups', []);

        if ($macroprojetoId <= 0 || ! in_array($turno, ['1', '2'], true) || $login === '') {
            throw new DomainException('Contexto ativo do Disque Eleição não está disponível.');
        }
        if (! $this->permissoes->podeOperar($grupos)) {
            throw new AuthorizationException('Usuário sem perfil operacional do Disque Eleição.');
        }

        return new DisqueEleicaoContexto(
            $macroprojetoId,
            $turno,
            $login,
            $nome !== '' ? $nome : $login,
            $this->permissoes->ehGestor($grupos),
        );
    }
}
```
</APP_SERVICES_DISQUEELEICAO_DISQUEELEICAOCONTEXTOSESSAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/DisqueEleicao/DisqueEleicaoRelatorioService.php`
## <APP_SERVICES_DISQUEELEICAO_DISQUEELEICAORELATORIOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/DisqueEleicao/DisqueEleicaoRelatorioService.php`
- **Namespace Declaração:** `App\Services\DisqueEleicao`
- **Entidade / Classe:** `final class DisqueEleicaoRelatorioService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly DisqueEleicaoRelatorioRepositoryInterface $repository)
public function consolidar(array $filtros, int $macroprojetoId, string $turno): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\DisqueEleicao;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoRelatorioRepositoryInterface;

final class DisqueEleicaoRelatorioService
{
    public function __construct(private readonly DisqueEleicaoRelatorioRepositoryInterface $repository)
    {
    }

    /**
     * @param array<string, mixed> $filtros
     * @return array<string, mixed>
     */
    public function consolidar(array $filtros, int $macroprojetoId, string $turno): array
    {
        $resultado = $this->repository->consolidar($filtros, $macroprojetoId, $turno);
        $total = max(0, (int) ($resultado['total'] ?? 0));
        $assuntos = [];

        foreach ((array) ($resultado['assuntos'] ?? []) as $assunto) {
            $quantidade = max(0, (int) ($assunto['quantidade'] ?? 0));
            $assunto['quantidade'] = $quantidade;
            $assunto['percentual'] = $total > 0 ? round(($quantidade / $total) * 100, 2) : 0.0;
            $assuntos[] = $assunto;
        }

        if ($total > 0 && $assuntos !== []) {
            $ultimo = array_key_last($assuntos);
            $soma = array_sum(array_column($assuntos, 'percentual'));
            $assuntos[$ultimo]['percentual'] = round(
                (float) $assuntos[$ultimo]['percentual'] + (100.0 - $soma),
                2,
            );
        }

        $resultado['total'] = $total;
        $resultado['assuntos'] = $assuntos;

        return $resultado;
    }
}
```
</APP_SERVICES_DISQUEELEICAO_DISQUEELEICAORELATORIOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Validation/TelefoneBrasileiro.php`
## <APP_SUPPORT_VALIDATION_TELEFONEBRASILEIRO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Validation/TelefoneBrasileiro.php`
- **Namespace Declaração:** `App\Support\Validation`
- **Entidade / Classe:** `final class TelefoneBrasileiro`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function normalizar(mixed $valor): ?string
public static function formatoPermitido(mixed $valor): bool
public static function prepararEntrada(mixed $valor): mixed
public static function valido(mixed $valor): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Validation;

final class TelefoneBrasileiro
{
    public static function normalizar(mixed $valor): ?string
    {
        if (! self::formatoPermitido($valor)) {
            return null;
        }

        $digitos = preg_replace('/\D/', '', trim((string) $valor)) ?? '';

        return $digitos === '' ? null : $digitos;
    }

    public static function formatoPermitido(mixed $valor): bool
    {
        if (! is_string($valor) && ! is_numeric($valor)) {
            return false;
        }

        $texto = trim((string) $valor);

        return preg_match('/^(?:\d{10,11}|\(\d{2}\)\s?\d{4,5}-?\d{4}|\d{2}\s?\d{4,5}-\d{4})$/', $texto) === 1;
    }

    public static function prepararEntrada(mixed $valor): mixed
    {
        if ($valor === null) {
            return null;
        }

        if (! is_string($valor) && ! is_numeric($valor)) {
            return $valor;
        }

        return self::normalizar($valor) ?? trim((string) $valor);
    }

    public static function valido(mixed $valor): bool
    {
        $telefone = self::normalizar($valor);
        if ($telefone === null) {
            return false;
        }

        if (strlen($telefone) === 10) {
            return preg_match('/^[1-9]{2}[2-5][0-9]{7}$/', $telefone) === 1;
        }

        return strlen($telefone) === 11
            && preg_match('/^[1-9]{2}9[6-9][0-9]{7}$/', $telefone) === 1;
    }
}
```
</APP_SUPPORT_VALIDATION_TELEFONEBRASILEIRO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_04_13_000200_add_telefone_to_vw_convocados.php`
## <DATABASE_MIGRATIONS_2026_04_13_000200_ADD_TELEFONE_TO_VW_CONVOCADOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_04_13_000200_add_telefone_to_vw_convocados.php`
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
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc AS dat_nasc,
    v.num_inscricao,
    v.num_cpf,
    v.telefone,
    v.num_zona,
    ev.localidade AS nom_localidade
FROM ac_pessoa.vw_voluntario_perfil v
LEFT JOIN planeleito.vw_eleitor_secao_zona_localidade ev
    ON TRIM(ev.num_inscricao) = TRIM(v.num_inscricao)
SQL
        );
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
CREATE OR REPLACE VIEW planeleito.vw_convocados AS
SELECT
    NVL(v.nome_civil, v.nome_social) AS nom_eleitor,
    v.data_nasc AS dat_nasc,
    v.num_inscricao,
    v.num_cpf,
    v.num_zona,
    ev.localidade AS nom_localidade
FROM ac_pessoa.vw_voluntario_perfil v
LEFT JOIN planeleito.vw_eleitor_secao_zona_localidade ev
    ON TRIM(ev.num_inscricao) = TRIM(v.num_inscricao)
SQL
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_04_13_000200_ADD_TELEFONE_TO_VW_CONVOCADOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_28_100000_create_disque_eleicao_assunto_table.php`
## <DATABASE_MIGRATIONS_2026_07_28_100000_CREATE_DISQUE_ELEICAO_ASSUNTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_28_100000_create_disque_eleicao_assunto_table.php`
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
CREATE TABLE disque_eleicao_assunto (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(40 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER(5) DEFAULT 0 NOT NULL,
    ativo             NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE,
    CONSTRAINT CK_DE_ASSUNTO_ATIVO CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement('CREATE UNIQUE INDEX UX_DE_ASSUNTO_CODIGO ON disque_eleicao_assunto (UPPER(codigo))');
        DB::statement('CREATE UNIQUE INDEX UX_DE_ASSUNTO_DESC ON disque_eleicao_assunto (UPPER(descricao))');
        DB::statement('CREATE INDEX IX_DE_ASSUNTO_ORDEM ON disque_eleicao_assunto (ativo, ordem, descricao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE disque_eleicao_assunto CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_28_100000_CREATE_DISQUE_ELEICAO_ASSUNTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_28_101000_create_disque_eleicao_atendimento_table.php`
## <DATABASE_MIGRATIONS_2026_07_28_101000_CREATE_DISQUE_ELEICAO_ATENDIMENTO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_28_101000_create_disque_eleicao_atendimento_table.php`
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
CREATE TABLE disque_eleicao_atendimento (
    id                     NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    assunto_id             NUMBER NOT NULL,
    domicilio_codigo       VARCHAR2(30 CHAR) NOT NULL,
    domicilio_descricao    VARCHAR2(160 CHAR) NOT NULL,
    macroprojeto_id        NUMBER NOT NULL,
    turno                  NUMBER(1) NOT NULL,
    lote_uuid              VARCHAR2(36 CHAR) NOT NULL,
    outros_complemento     VARCHAR2(300 CHAR),
    usuario_login          VARCHAR2(160 CHAR) NOT NULL,
    usuario_nome           VARCHAR2(200 CHAR) NOT NULL,
    dt_atendimento         DATE DEFAULT SYSDATE NOT NULL,
    usuario_atualizacao    VARCHAR2(160 CHAR),
    dt_atualizacao         DATE,
    CONSTRAINT FK_DE_ATEND_ASSUNTO FOREIGN KEY (assunto_id)
        REFERENCES disque_eleicao_assunto (id),
    CONSTRAINT FK_DE_ATEND_MACRO FOREIGN KEY (macroprojeto_id)
        REFERENCES macroprojeto (id),
    CONSTRAINT CK_DE_ATEND_TURNO CHECK (turno IN (1, 2)),
    CONSTRAINT CK_DE_ATEND_UUID CHECK (
        REGEXP_LIKE(lote_uuid, '^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$')
    )
)
SQL);

        DB::statement('CREATE UNIQUE INDEX UX_DE_ATEND_LOTE_ASSUNTO ON disque_eleicao_atendimento (lote_uuid, assunto_id)');
        DB::statement('CREATE INDEX IX_DE_ATEND_CONTEXTO_DATA ON disque_eleicao_atendimento (macroprojeto_id, turno, dt_atendimento)');
        DB::statement('CREATE INDEX IX_DE_ATEND_ASSUNTO ON disque_eleicao_atendimento (macroprojeto_id, turno, assunto_id)');
        DB::statement('CREATE INDEX IX_DE_ATEND_DOMICILIO ON disque_eleicao_atendimento (macroprojeto_id, turno, domicilio_codigo)');
        DB::statement('CREATE INDEX IX_DE_ATEND_USUARIO ON disque_eleicao_atendimento (macroprojeto_id, turno, usuario_login)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE disque_eleicao_atendimento CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_28_101000_CREATE_DISQUE_ELEICAO_ATENDIMENTO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_04_120000_create_ce_wa_telefone_manual_table.php`
## <DATABASE_MIGRATIONS_2026_08_04_120000_CREATE_CE_WA_TELEFONE_MANUAL_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_04_120000_create_ce_wa_telefone_manual_table.php`
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
CREATE TABLE ce_wa_telefone_manual (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    num_inscricao       VARCHAR2(20 CHAR) NOT NULL,
    telefone_nacional   VARCHAR2(11 CHAR) NOT NULL,
    usuario_login       VARCHAR2(120 CHAR) NOT NULL,
    usuario_nome        VARCHAR2(200 CHAR) NOT NULL,
    dt_criacao          DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao      DATE,
    CONSTRAINT ck_ce_wa_tel_man_cel CHECK (
        REGEXP_LIKE(telefone_nacional, '^[1-9]{2}9[6-9][0-9]{7}$')
    )
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_wa_tel_man_ins ON ce_wa_telefone_manual (num_inscricao)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE ce_wa_telefone_manual');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_04_120000_CREATE_CE_WA_TELEFONE_MANUAL_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_21_120000_create_disque_eleicao_domicilio_extra_table.php`
## <DATABASE_MIGRATIONS_2026_08_21_120000_CREATE_DISQUE_ELEICAO_DOMICILIO_EXTRA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_21_120000_create_disque_eleicao_domicilio_extra_table.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$referencias = DB::table('disque_eleicao_atendimento')
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
    private const CODIGOS = [
        'ESPECIAL_NAO_IDENTIFICADO',
        'ESPECIAL_OUTRO_ESTADO',
    ];

    public function up(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE disque_eleicao_domicilio_extra (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo            VARCHAR2(30 CHAR) NOT NULL,
    descricao         VARCHAR2(160 CHAR) NOT NULL,
    ordem             NUMBER(5) DEFAULT 0 NOT NULL,
    ativo             NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao    DATE,
    CONSTRAINT CK_DE_DOM_EXTRA_ATIVO CHECK (ativo IN (0, 1))
)
SQL);

        DB::statement('CREATE UNIQUE INDEX UX_DE_DOM_EXTRA_CODIGO ON disque_eleicao_domicilio_extra (UPPER(codigo))');
        DB::statement('CREATE UNIQUE INDEX UX_DE_DOM_EXTRA_DESC ON disque_eleicao_domicilio_extra (UPPER(descricao))');
        DB::statement('CREATE INDEX IX_DE_DOM_EXTRA_ORDEM ON disque_eleicao_domicilio_extra (ativo, ordem, descricao)');
    }

    public function down(): void
    {
        $referencias = DB::table('disque_eleicao_atendimento')
            ->whereIn('domicilio_codigo', self::CODIGOS)
            ->count();

        if ($referencias > 0) {
            throw new RuntimeException('Rollback recusado: existem atendimentos vinculados a domicílios extras.');
        }

        DB::statement('DROP TABLE disque_eleicao_domicilio_extra CASCADE CONSTRAINTS');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_21_120000_CREATE_DISQUE_ELEICAO_DOMICILIO_EXTRA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_21_121000_evolve_disque_eleicao_catalogs.php`
## <DATABASE_MIGRATIONS_2026_08_21_121000_EVOLVE_DISQUE_ELEICAO_CATALOGS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_21_121000_evolve_disque_eleicao_catalogs.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('disque_eleicao_assunto')
$assuntoReferenciado = DB::table('disque_eleicao_atendimento as atendimento')
$domicilioReferenciado = DB::table('disque_eleicao_atendimento')
DB::table('disque_eleicao_assunto')->where('codigo', self::ASSUNTO_NOVO)->delete();
DB::table('disque_eleicao_assunto')->where('codigo', 'PROPAGANDA_ELEITORAL')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function upsertDomicilioExtra(string $codigo, string $descricao, int $ordem): void
private function upsertAssuntoNovo(): void
private function atualizarOrdemAssunto(string $codigo, int $ordem): void
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
    private const ASSUNTO_NOVO = 'ORIENTACOES_ILICITOS_ELEITORAIS';

    private const ASSUNTOS_LEGADOS = [
        'PROPAGANDA_ELEITORAL',
        'CRIME_ELEITORAL',
    ];

    private const DOMICILIOS_EXTRAS = [
        'ESPECIAL_NAO_IDENTIFICADO',
        'ESPECIAL_OUTRO_ESTADO',
    ];

    public function up(): void
    {
        DB::transaction(function (): void {
            $this->upsertDomicilioExtra('ESPECIAL_NAO_IDENTIFICADO', 'Não identificado', 1);
            $this->upsertDomicilioExtra('ESPECIAL_OUTRO_ESTADO', 'Outro Estado', 2);

            DB::table('disque_eleicao_assunto')
                ->whereIn('codigo', self::ASSUNTOS_LEGADOS)
                ->update(['ativo' => 0, 'dt_atualizacao' => DB::raw('SYSDATE')]);

            $this->upsertAssuntoNovo();
            $this->atualizarOrdemAssunto('JUSTIFICATIVA_ELEITORAL', 13);
            $this->atualizarOrdemAssunto('CONTATOS_JUSTICA_ELEITORAL', 14);
            $this->atualizarOrdemAssunto('OUTROS', 15);
        });
    }

    public function down(): void
    {
        DB::transaction(function (): void {
            $assuntoReferenciado = DB::table('disque_eleicao_atendimento as atendimento')
                ->join('disque_eleicao_assunto as assunto', 'assunto.id', '=', 'atendimento.assunto_id')
                ->where('assunto.codigo', self::ASSUNTO_NOVO)
                ->exists();
            if ($assuntoReferenciado) {
                throw new RuntimeException('Rollback recusado: existem atendimentos vinculados ao assunto de ilícitos eleitorais.');
            }

            $domicilioReferenciado = DB::table('disque_eleicao_atendimento')
                ->whereIn('domicilio_codigo', self::DOMICILIOS_EXTRAS)
                ->exists();
            if ($domicilioReferenciado) {
                throw new RuntimeException('Rollback recusado: existem atendimentos vinculados a domicílios extras.');
            }

            DB::table('disque_eleicao_assunto')->where('codigo', self::ASSUNTO_NOVO)->delete();
            DB::table('disque_eleicao_assunto')->where('codigo', 'PROPAGANDA_ELEITORAL')
                ->update(['ordem' => 12, 'ativo' => 1, 'dt_atualizacao' => DB::raw('SYSDATE')]);
            DB::table('disque_eleicao_assunto')->where('codigo', 'CRIME_ELEITORAL')
                ->update(['ordem' => 13, 'ativo' => 1, 'dt_atualizacao' => DB::raw('SYSDATE')]);
            $this->atualizarOrdemAssunto('JUSTIFICATIVA_ELEITORAL', 14);
            $this->atualizarOrdemAssunto('CONTATOS_JUSTICA_ELEITORAL', 15);
            $this->atualizarOrdemAssunto('OUTROS', 16);
            DB::table('disque_eleicao_domicilio_extra')->whereIn('codigo', self::DOMICILIOS_EXTRAS)->delete();
        });
    }

    private function upsertDomicilioExtra(string $codigo, string $descricao, int $ordem): void
    {
        $id = (int) DB::table('disque_eleicao_domicilio_extra')
            ->whereRaw('UPPER(codigo) = ?', [$codigo])
            ->value('id');
        $dados = [
            'descricao' => $descricao,
            'ordem' => $ordem,
            'ativo' => 1,
        ];

        if ($id > 0) {
            DB::table('disque_eleicao_domicilio_extra')->where('id', $id)
                ->update($dados + ['dt_atualizacao' => DB::raw('SYSDATE')]);

            return;
        }

        DB::table('disque_eleicao_domicilio_extra')->insert($dados + [
            'codigo' => $codigo,
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
    }

    private function upsertAssuntoNovo(): void
    {
        $id = (int) DB::table('disque_eleicao_assunto')
            ->whereRaw('UPPER(codigo) = ?', [self::ASSUNTO_NOVO])
            ->value('id');
        $dados = [
            'descricao' => 'Orientações sobre ilícitos eleitorais',
            'ordem' => 12,
            'ativo' => 1,
        ];

        if ($id > 0) {
            DB::table('disque_eleicao_assunto')->where('id', $id)
                ->update($dados + ['dt_atualizacao' => DB::raw('SYSDATE')]);

            return;
        }

        DB::table('disque_eleicao_assunto')->insert($dados + [
            'codigo' => self::ASSUNTO_NOVO,
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
    }

    private function atualizarOrdemAssunto(string $codigo, int $ordem): void
    {
        DB::table('disque_eleicao_assunto')
            ->where('codigo', $codigo)
            ->update(['ordem' => $ordem, 'dt_atualizacao' => DB::raw('SYSDATE')]);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_21_121000_EVOLVE_DISQUE_ELEICAO_CATALOGS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/seeders/DisqueEleicaoSeeder.php`
## <DATABASE_SEEDERS_DISQUEELEICAOSEEDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/seeders/DisqueEleicaoSeeder.php`
- **Namespace Declaração:** `Database\Seeders`
- **Entidade / Classe:** `class DisqueEleicaoSeeder extends Seeder`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$macroprojetoId = (int) DB::table('macroprojeto')
$id = (int) DB::table('disque_eleicao_assunto')
DB::table('disque_eleicao_assunto')->where('id', $id)
DB::table('disque_eleicao_assunto')->insert($dados + [
$id = (int) DB::table('disque_eleicao_domicilio_extra')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function run(): void
private function seedAssuntos(): void
private function upsertAssunto(array $assunto, int $ordem, int $ativo): void
private function seedDomiciliosExtras(): void
private function assuntos(): array
private function assuntosLegados(): array
private function domiciliosExtras(): array
private function rotasOperacionais(): array
private function rotasAdmin(): array
private function upsertGrupo(string $nome, string $descricao): int
private function grupoId(string $nome): int
private function upsertGrupoMacroprojeto(int $grupoId, int $macroprojetoId): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class DisqueEleicaoSeeder extends Seeder
{
    private const GRUPO_ATENDENTE = 'PLANELEITO_DISQUE_ELEICAO_ATENDENTE';

    private const GRUPO_GESTOR = 'PLANELEITO_DISQUE_ELEICAO_GESTOR';

    public function run(): void
    {
        DB::transaction(function (): void {
            $this->seedAssuntos();
            $this->seedDomiciliosExtras();
            $macroprojetoId = (int) DB::table('macroprojeto')
                ->whereRaw('UPPER(nome) = ?', ['ELEIÇÕES 2026'])
                ->value('id');
            if ($macroprojetoId <= 0) {
                throw new RuntimeException('Macroprojeto Eleições 2026 não encontrado para o Disque Eleição.');
            }

            $atendenteId = $this->upsertGrupo(self::GRUPO_ATENDENTE, 'Atendente do Disque Eleição');
            $gestorId = $this->upsertGrupo(self::GRUPO_GESTOR, 'Gestor do Disque Eleição');
            $adminId = $this->grupoId('PLANELEITO_ADMIN');
            $this->upsertGrupoMacroprojeto($atendenteId, $macroprojetoId);
            $this->upsertGrupoMacroprojeto($gestorId, $macroprojetoId);

            foreach ($this->rotasOperacionais() as $nome => $meta) {
                $rotaId = $this->upsertRota($nome, $meta);
                $this->upsertVinculo($rotaId, $atendenteId);
                $this->upsertVinculo($rotaId, $gestorId);
            }

            foreach ($this->rotasAdmin() as $nome => $meta) {
                $this->upsertVinculo($this->upsertRota($nome, $meta), $adminId);
            }
        });
    }

    private function seedAssuntos(): void
    {
        foreach ($this->assuntos() as $ordem => $assunto) {
            $this->upsertAssunto($assunto, $ordem + 1, 1);
        }

        foreach ($this->assuntosLegados() as $assunto) {
            $this->upsertAssunto($assunto, $assunto['ordem'], 0);
        }
    }

    /** @param array{codigo:string,descricao:string} $assunto */
    private function upsertAssunto(array $assunto, int $ordem, int $ativo): void
    {
        $id = (int) DB::table('disque_eleicao_assunto')
            ->whereRaw('UPPER(codigo) = ?', [$assunto['codigo']])
            ->value('id');
        $dados = [
            'descricao' => $assunto['descricao'],
            'ordem' => $ordem,
            'ativo' => $ativo,
        ];

        if ($id > 0) {
            DB::table('disque_eleicao_assunto')->where('id', $id)
                ->update($dados + ['dt_atualizacao' => DB::raw('SYSDATE')]);

            return;
        }

        DB::table('disque_eleicao_assunto')->insert($dados + [
            'codigo' => $assunto['codigo'],
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
    }

    private function seedDomiciliosExtras(): void
    {
        foreach ($this->domiciliosExtras() as $ordem => $domicilio) {
            $id = (int) DB::table('disque_eleicao_domicilio_extra')
                ->whereRaw('UPPER(codigo) = ?', [$domicilio['codigo']])
                ->value('id');
            $dados = [
                'descricao' => $domicilio['descricao'],
                'ordem' => $ordem + 1,
                'ativo' => 1,
            ];

            if ($id > 0) {
                DB::table('disque_eleicao_domicilio_extra')->where('id', $id)
                    ->update($dados + ['dt_atualizacao' => DB::raw('SYSDATE')]);

                continue;
            }

            DB::table('disque_eleicao_domicilio_extra')->insert($dados + [
                'codigo' => $domicilio['codigo'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ]);
        }
    }

    /** @return array<int, array{codigo:string,descricao:string}> */
    private function assuntos(): array
    {
        return [
            ['codigo' => 'LOCAL_VOTACAO', 'descricao' => 'Local de votação'],
            ['codigo' => 'HORARIO_VOTACAO', 'descricao' => 'Horário de votação'],
            ['codigo' => 'DOCUMENTOS_VOTACAO', 'descricao' => 'Documentos para votação'],
            ['codigo' => 'SITUACAO_ELEITORAL', 'descricao' => 'Situação eleitoral'],
            ['codigo' => 'NUMERO_INSCRICAO_ELEITORAL', 'descricao' => 'Número da inscrição eleitoral'],
            ['codigo' => 'LISTA_CANDIDATOS', 'descricao' => 'Lista de candidatos'],
            ['codigo' => 'NOME_AUSENTE_CADERNO_VOTACAO', 'descricao' => 'Ausência do nome do eleitor no caderno de votação'],
            ['codigo' => 'MESARIOS_ALV', 'descricao' => 'Mesários e Auxiliares de Local de Votação (ALV)'],
            ['codigo' => 'E_TITULO', 'descricao' => 'Aplicativo e-Título'],
            ['codigo' => 'TRANSPORTE_ELEITORES', 'descricao' => 'Transporte de eleitores'],
            ['codigo' => 'LEI_SECA', 'descricao' => 'Lei Seca'],
            ['codigo' => 'ORIENTACOES_ILICITOS_ELEITORAIS', 'descricao' => 'Orientações sobre ilícitos eleitorais'],
            ['codigo' => 'JUSTIFICATIVA_ELEITORAL', 'descricao' => 'Justificativa eleitoral'],
            ['codigo' => 'CONTATOS_JUSTICA_ELEITORAL', 'descricao' => 'Contatos com a Justiça Eleitoral'],
            ['codigo' => 'OUTROS', 'descricao' => 'Outros'],
        ];
    }

    /** @return array<int, array{codigo:string,descricao:string,ordem:int}> */
    private function assuntosLegados(): array
    {
        return [
            ['codigo' => 'PROPAGANDA_ELEITORAL', 'descricao' => 'Propaganda eleitoral', 'ordem' => 12],
            ['codigo' => 'CRIME_ELEITORAL', 'descricao' => 'Crime eleitoral', 'ordem' => 13],
        ];
    }

    /** @return array<int, array{codigo:string,descricao:string}> */
    private function domiciliosExtras(): array
    {
        return [
            ['codigo' => 'ESPECIAL_NAO_IDENTIFICADO', 'descricao' => 'Não identificado'],
            ['codigo' => 'ESPECIAL_OUTRO_ESTADO', 'descricao' => 'Outro Estado'],
        ];
    }

    /** @return array<string, array{path:string,menu:string,descricao:string}> */
    private function rotasOperacionais(): array
    {
        return [
            'disque-eleicao.index' => ['path' => 'disque-eleicao', 'menu' => 'Dia-E > Disque Eleição', 'descricao' => 'Registro e histórico de atendimentos do Disque Eleição.'],
            'disque-eleicao.store' => ['path' => 'disque-eleicao/atendimentos', 'menu' => 'Dia-E > Disque Eleição', 'descricao' => 'Criação de atendimentos do Disque Eleição.'],
            'disque-eleicao.edit' => ['path' => 'disque-eleicao/atendimentos/{id}/editar', 'menu' => 'Dia-E > Disque Eleição', 'descricao' => 'Edição de atendimento do Disque Eleição.'],
            'disque-eleicao.update' => ['path' => 'disque-eleicao/atendimentos/{id}', 'menu' => 'Dia-E > Disque Eleição', 'descricao' => 'Atualização de atendimento do Disque Eleição.'],
            'disque-eleicao.destroy' => ['path' => 'disque-eleicao/atendimentos/{id}', 'menu' => 'Dia-E > Disque Eleição', 'descricao' => 'Exclusão auditada de atendimento do Disque Eleição.'],
            'disque-eleicao.relatorios.index' => ['path' => 'disque-eleicao/relatorios', 'menu' => 'Dia-E > Disque Eleição > Relatórios', 'descricao' => 'Relatórios estaduais do Disque Eleição.'],
            'disque-eleicao.relatorios.pdf' => ['path' => 'disque-eleicao/relatorios/pdf', 'menu' => 'Dia-E > Disque Eleição > Relatórios', 'descricao' => 'Exportação PDF dos relatórios do Disque Eleição.'],
            'disque-eleicao.relatorios.xlsx' => ['path' => 'disque-eleicao/relatorios/xlsx', 'menu' => 'Dia-E > Disque Eleição > Relatórios', 'descricao' => 'Exportação XLSX dos relatórios do Disque Eleição.'],
        ];
    }

    /** @return array<string, array{path:string,menu:string,descricao:string}> */
    private function rotasAdmin(): array
    {
        $menu = 'Administração Global > Tabelas Auxiliares > Assuntos do Disque Eleição';

        return [
            'tabelas-auxiliares.disque-eleicao-assuntos.index' => ['path' => 'tabelas-auxiliares/disque-eleicao-assuntos', 'menu' => $menu, 'descricao' => 'Listagem administrativa de assuntos do Disque Eleição.'],
            'tabelas-auxiliares.disque-eleicao-assuntos.form' => ['path' => 'tabelas-auxiliares/disque-eleicao-assuntos/form/{id?}', 'menu' => $menu, 'descricao' => 'Formulário de assunto do Disque Eleição.'],
            'tabelas-auxiliares.disque-eleicao-assuntos.store' => ['path' => 'tabelas-auxiliares/disque-eleicao-assuntos', 'menu' => $menu, 'descricao' => 'Criação de assunto do Disque Eleição.'],
            'tabelas-auxiliares.disque-eleicao-assuntos.update' => ['path' => 'tabelas-auxiliares/disque-eleicao-assuntos/{id}', 'menu' => $menu, 'descricao' => 'Atualização de assunto do Disque Eleição.'],
            'tabelas-auxiliares.disque-eleicao-assuntos.destroy' => ['path' => 'tabelas-auxiliares/disque-eleicao-assuntos/{id}', 'menu' => $menu, 'descricao' => 'Exclusão segura de assunto do Disque Eleição.'],
            'tabelas-auxiliares.disque-eleicao-assuntos.exportar-pdf' => ['path' => 'tabelas-auxiliares/disque-eleicao-assuntos/exportar-pdf', 'menu' => $menu, 'descricao' => 'Exportação PDF dos assuntos do Disque Eleição.'],
        ];
    }

    private function upsertGrupo(string $nome, string $descricao): int
    {
        $id = (int) DB::table('adm_grupo_acesso')->whereRaw('UPPER(nome) = ?', [$nome])->value('id');
        $dados = ['descricao' => $descricao, 'ativo' => 1, 'ignora_unidades_permitidas' => 1, 'expande_escopo_por_atividade' => 0];
        if ($id > 0) {
            DB::table('adm_grupo_acesso')->where('id', $id)->update($dados + ['dt_atualizacao' => DB::raw('SYSDATE')]);

            return $id;
        }
        DB::table('adm_grupo_acesso')->insert($dados + ['nome' => $nome, 'dt_criacao' => DB::raw('SYSDATE')]);

        return $this->grupoId($nome);
    }

    private function grupoId(string $nome): int
    {
        $id = (int) DB::table('adm_grupo_acesso')->whereRaw('UPPER(nome) = ?', [$nome])->where('ativo', 1)->value('id');
        if ($id <= 0) {
            throw new RuntimeException('Grupo ativo não encontrado: '.$nome);
        }

        return $id;
    }

    private function upsertGrupoMacroprojeto(int $grupoId, int $macroprojetoId): void
    {
        $id = (int) DB::table('adm_grupo_macroprojeto')->where('grupo_acesso_id', $grupoId)
            ->where('macroprojeto_id', $macroprojetoId)->where('escopo_global', 0)->value('id');
        if ($id > 0) {
            DB::table('adm_grupo_macroprojeto')->where('id', $id)
                ->update(['ativo' => 1, 'dt_atualizacao' => DB::raw('SYSDATE')]);

            return;
        }
        DB::table('adm_grupo_macroprojeto')->insert([
            'grupo_acesso_id' => $grupoId,
            'macroprojeto_id' => $macroprojetoId,
            'escopo_global' => 0,
            'ativo' => 1,
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
    }

    /** @param array{path:string,menu:string,descricao:string} $meta */
    private function upsertRota(string $nome, array $meta): int
    {
        $id = (int) DB::table('adm_acesso_rota')->whereRaw('UPPER(rota_nome) = ?', [mb_strtoupper($nome, 'UTF-8')])->value('id');
        $dados = ['rota_path' => $meta['path'], 'menu_path' => $meta['menu'], 'descricao' => $meta['descricao'], 'ativo' => 1];
        if ($id > 0) {
            DB::table('adm_acesso_rota')->where('id', $id)->update($dados + ['dt_atualizacao' => DB::raw('SYSDATE')]);

            return $id;
        }
        DB::table('adm_acesso_rota')->insert($dados + ['rota_nome' => $nome, 'dt_criacao' => DB::raw('SYSDATE')]);

        return (int) DB::table('adm_acesso_rota')->whereRaw('UPPER(rota_nome) = ?', [mb_strtoupper($nome, 'UTF-8')])->value('id');
    }

    private function upsertVinculo(int $rotaId, int $grupoId): void
    {
        $id = (int) DB::table('adm_acesso_rota_grupo')->where('acesso_rota_id', $rotaId)->where('grupo_acesso_id', $grupoId)->value('id');
        if ($id > 0) {
            DB::table('adm_acesso_rota_grupo')->where('id', $id)->update(['ativo' => 1, 'dt_atualizacao' => DB::raw('SYSDATE')]);

            return;
        }
        DB::table('adm_acesso_rota_grupo')->insert([
            'acesso_rota_id' => $rotaId,
            'grupo_acesso_id' => $grupoId,
            'ativo' => 1,
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
    }
}
```
</DATABASE_SEEDERS_DISQUEELEICAOSEEDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/disque-eleicao/edit.blade.php`
## <RESOURCES_VIEWS_DISQUE_ELEICAO_EDIT_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/disque-eleicao/edit.blade.php`
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
@extends('layouts.app')

@section('titulo', 'Editar atendimento — Disque Eleição')

@section('conteudo')
<div class="container py-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0">Editar atendimento</h1>
        <a class="btn btn-outline-secondary" href="{{ route('disque-eleicao.index') }}">Voltar</a>
    </div>
    @if($errors->any())
        <div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>
    @endif
    <div class="card shadow-sm">
        <div class="card-body">
            <form method="POST" action="{{ route('disque-eleicao.update', $registro['id']) }}">
                @csrf @method('PUT')
                <div class="mb-3">
                    <label class="form-label" for="assunto_id">Assunto</label>
                    <select class="form-select" id="assunto_id" name="assunto_id" required>
                        @foreach($assuntos as $assunto)
                            <option value="{{ $assunto['id'] }}" data-codigo="{{ $assunto['codigo'] }}"
                                @selected((int) old('assunto_id', $registro['assunto_id']) === $assunto['id'])>
                                {{ $assunto['descricao'] }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="domicilio_codigo">Domicílio eleitoral</label>
                    <select class="form-select" id="domicilio_codigo" name="domicilio_codigo" required>
                        @foreach($domicilios as $domicilio)
                            <option value="{{ $domicilio['codigo'] }}" @selected(old('domicilio_codigo', $registro['domicilio_codigo']) === $domicilio['codigo'])>
                                {{ $domicilio['descricao'] }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3" id="grupo-outros-edicao">
                    <label class="form-label" for="outros_complemento">Complemento de Outros</label>
                    <input class="form-control" id="outros_complemento" name="outros_complemento" maxlength="300"
                           value="{{ old('outros_complemento', $registro['outros_complemento']) }}">
                </div>
                <button class="btn btn-primary" type="submit"><i class="fa-solid fa-floppy-disk me-1"></i> Salvar</button>
            </form>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function () {
    const assunto = document.getElementById('assunto_id');
    const grupo = document.getElementById('grupo-outros-edicao');
    const complemento = document.getElementById('outros_complemento');
    const atualizar = function () {
        const opcao = assunto.options[assunto.selectedIndex];
        const visivel = opcao && opcao.dataset.codigo === 'OUTROS';
        grupo.hidden = !visivel;
        complemento.required = Boolean(visivel);
    };
    assunto.addEventListener('change', atualizar);
    atualizar();
});
</script>
@endpush
```
</RESOURCES_VIEWS_DISQUE_ELEICAO_EDIT_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/disque-eleicao/index.blade.php`
## <RESOURCES_VIEWS_DISQUE_ELEICAO_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/disque-eleicao/index.blade.php`
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
@extends('layouts.app')

@section('titulo', 'Disque Eleição')

@section('conteudo')
<div class="container-fluid py-3">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <div>
            <h1 class="h3 mb-1">Disque Eleição</h1>
            <p class="text-muted mb-0">Registro de atendimentos eleitorais.</p>
        </div>
        <a class="btn btn-outline-primary" href="{{ route('disque-eleicao.relatorios.index') }}">
            <i class="fa-solid fa-chart-column me-1"></i> Relatórios
        </a>
    </div>

    @if(session('status'))
        <div class="alert alert-success">{{ session('status') }}</div>
    @endif
    @if($errors->any())
        <div class="alert alert-danger">
            <ul class="mb-0">
                @foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm mb-4">
        <div class="card-header"><strong>Novo atendimento</strong></div>
        <div class="card-body">
            <div class="alert alert-info py-2">
                Cada assunto selecionado será contabilizado como um atendimento independente.
            </div>
            <form method="POST" action="{{ route('disque-eleicao.store') }}" id="form-disque-eleicao">
                @csrf
                <input type="hidden" name="lote_uuid" value="{{ old('lote_uuid', $loteUuid) }}">

                <fieldset class="mb-3">
                    <legend class="form-label fw-semibold">Assuntos</legend>
                    <div class="row g-2">
                        @foreach($assuntos as $assunto)
                            <div class="col-sm-6 col-xl-4">
                                <div class="form-check border rounded p-2 ps-5 h-100">
                                    <input class="form-check-input assunto-check" type="checkbox"
                                           name="assunto_ids[]" value="{{ $assunto['id'] }}"
                                           data-codigo="{{ $assunto['codigo'] }}"
                                           id="assunto-{{ $assunto['id'] }}"
                                           @checked(in_array($assunto['id'], array_map('intval', old('assunto_ids', [])), true))>
                                    <label class="form-check-label" for="assunto-{{ $assunto['id'] }}">
                                        {{ $assunto['descricao'] }}
                                    </label>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </fieldset>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="domicilio_codigo">Domicílio eleitoral</label>
                        <select class="form-select" id="domicilio_codigo" name="domicilio_codigo" required>
                            <option value="">Selecione</option>
                            @foreach($domicilios as $domicilio)
                                <option value="{{ $domicilio['codigo'] }}" @selected(old('domicilio_codigo') === $domicilio['codigo'])>
                                    {{ $domicilio['descricao'] }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-6" id="grupo-outros" hidden>
                        <label class="form-label" for="outros_complemento">Complemento de Outros</label>
                        <input class="form-control" id="outros_complemento" name="outros_complemento"
                               maxlength="300" value="{{ old('outros_complemento') }}">
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-3">
                    <button class="btn btn-primary" type="submit">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Registrar atendimento(s)
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-header"><strong>Atendimentos do turno ativo</strong></div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-sm table-striped align-middle mb-0">
                    <thead><tr><th>Atendimento</th><th class="text-end">Ações</th></tr></thead>
                    <tbody>
                    @forelse($historico as $item)
                        <tr>
                            <td>
                                <strong>Data:</strong> {{ $item->dt_atendimento_fmt }}<br>
                                <strong>Assunto:</strong> {{ $item->assunto_descricao }}
                                @if($item->outros_complemento)<br><strong>Complemento:</strong> {{ $item->outros_complemento }}@endif
                                <br><strong>Domicílio:</strong> {{ $item->domicilio_descricao }}
                                <br><strong>Atendente:</strong> {{ $item->usuario_nome }} ({{ $item->usuario_login }})
                            </td>
                            <td class="text-end text-nowrap">
                                @if($permissoes->podeAlterar((string) $item->usuario_login, $usuarioLogin, $grupos))
                                    <a class="btn btn-sm btn-outline-primary" href="{{ route('disque-eleicao.edit', $item->id) }}"
                                       title="Editar" aria-label="Editar atendimento">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>
                                    <form class="d-inline" method="POST" action="{{ route('disque-eleicao.destroy', $item->id) }}"
                                          onsubmit="return confirm('Excluir este atendimento? A exclusão será auditada.');">
                                        @csrf @method('DELETE')
                                        <button class="btn btn-sm btn-outline-danger" type="submit" title="Excluir" aria-label="Excluir atendimento">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                @endif
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="2" class="text-center text-muted py-4">Nenhum atendimento registrado neste turno.</td></tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($historico->hasPages())
            <div class="card-footer">{{ $historico->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
</div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function () {
    const outros = document.querySelector('.assunto-check[data-codigo="OUTROS"]');
    const grupo = document.getElementById('grupo-outros');
    const complemento = document.getElementById('outros_complemento');
    const atualizar = function () {
        const visivel = outros && outros.checked;
        grupo.hidden = !visivel;
        complemento.required = Boolean(visivel);
    };
    if (outros) {
        outros.addEventListener('change', atualizar);
    }
    atualizar();
});
</script>
@endpush
```
</RESOURCES_VIEWS_DISQUE_ELEICAO_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/disque-eleicao/relatorios/index.blade.php`
## <RESOURCES_VIEWS_DISQUE_ELEICAO_RELATORIOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/disque-eleicao/relatorios/index.blade.php`
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
@extends('layouts.app')

@section('titulo', 'Relatórios — Disque Eleição')

@section('conteudo')
<div class="container-fluid py-3">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <h1 class="h3 mb-0">Relatórios do Disque Eleição</h1>
        <a class="btn btn-outline-secondary" href="{{ route('disque-eleicao.index') }}">Voltar ao registro</a>
    </div>

    <form method="GET" class="card card-body shadow-sm mb-3">
        <div class="row g-2">
            <div class="col-md-2"><label class="form-label">Data inicial</label><input class="form-control" type="date" name="data_inicio" value="{{ $filtros['data_inicio'] ?? '' }}"></div>
            <div class="col-md-2"><label class="form-label">Data final</label><input class="form-control" type="date" name="data_fim" value="{{ $filtros['data_fim'] ?? '' }}"></div>
            <div class="col-md-3"><label class="form-label">Assunto</label><select class="form-select" name="assunto_id"><option value="">Todos</option>@foreach($assuntos as $assunto)<option value="{{ $assunto['id'] }}" @selected((int)($filtros['assunto_id'] ?? 0) === $assunto['id'])>{{ $assunto['descricao'] }}</option>@endforeach</select></div>
            <div class="col-md-3"><label class="form-label">Domicílio</label><select class="form-select" name="domicilio_codigo"><option value="">Todos</option>@foreach($domicilios as $domicilio)<option value="{{ $domicilio['codigo'] }}" @selected(($filtros['domicilio_codigo'] ?? '') === $domicilio['codigo'])>{{ $domicilio['descricao'] }}</option>@endforeach</select></div>
            <div class="col-md-2"><label class="form-label">Login do atendente</label><input class="form-control" name="usuario_login" maxlength="160" value="{{ $filtros['usuario_login'] ?? '' }}"></div>
        </div>
        <div class="d-flex flex-wrap gap-2 justify-content-end mt-3">
            <button class="btn btn-primary" type="submit"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
            <button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#modal-exportar-pdf"><i class="fa-solid fa-file-pdf me-1"></i> Exportar PDF</button>
            <a class="btn btn-outline-success" href="{{ route('disque-eleicao.relatorios.xlsx', $filtros) }}"><i class="fa-solid fa-file-excel me-1"></i> Exportar XLSX</a>
        </div>
    </form>

    <div class="row g-3 mb-3">
        <div class="col-sm-6 col-lg-3"><div class="card shadow-sm h-100"><div class="card-body"><div class="text-muted">Total de atendimentos</div><div class="display-6">{{ $consolidado['total'] }}</div></div></div></div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-lg-6">
            <div class="card shadow-sm h-100"><div class="card-header"><strong>Por assunto</strong></div><div class="table-responsive"><table class="table table-sm mb-0"><thead><tr><th>Assunto</th><th class="text-end">Qtd.</th><th class="text-end">%</th></tr></thead><tbody>@forelse($consolidado['assuntos'] as $item)<tr><td>{{ $item['descricao'] }}</td><td class="text-end">{{ $item['quantidade'] }}</td><td class="text-end">{{ number_format($item['percentual'], 2, ',', '.') }}%</td></tr>@empty<tr><td colspan="3" class="text-center text-muted">Sem dados.</td></tr>@endforelse</tbody></table></div></div>
        </div>
        <div class="col-lg-6">
            <div class="card shadow-sm h-100"><div class="card-header"><strong>Por domicílio</strong></div><div class="table-responsive"><table class="table table-sm mb-0"><thead><tr><th>Domicílio</th><th class="text-end">Qtd.</th></tr></thead><tbody>@forelse($consolidado['domicilios'] as $item)<tr><td>{{ $item['descricao'] }}</td><td class="text-end">{{ $item['quantidade'] }}</td></tr>@empty<tr><td colspan="2" class="text-center text-muted">Sem dados.</td></tr>@endforelse</tbody></table></div></div>
        </div>
        <div class="col-lg-6">
            <div class="card shadow-sm h-100"><div class="card-header"><strong>Por atendente</strong></div><div class="table-responsive"><table class="table table-sm mb-0"><thead><tr><th>Atendente</th><th class="text-end">Qtd.</th></tr></thead><tbody>@forelse($consolidado['atendentes'] as $item)<tr><td>{{ $item['nome'] }} ({{ $item['login'] }})</td><td class="text-end">{{ $item['quantidade'] }}</td></tr>@empty<tr><td colspan="2" class="text-center text-muted">Sem dados.</td></tr>@endforelse</tbody></table></div></div>
        </div>
        <div class="col-lg-6">
            <div class="card shadow-sm h-100"><div class="card-header"><strong>Por período</strong></div><div class="table-responsive"><table class="table table-sm mb-0"><thead><tr><th>Tipo</th><th>Período</th><th class="text-end">Qtd.</th></tr></thead><tbody>@forelse($consolidado['periodos'] as $item)<tr><td>{{ $item['tipo'] }}</td><td>{{ $item['periodo'] }}</td><td class="text-end">{{ $item['quantidade'] }}</td></tr>@empty<tr><td colspan="3" class="text-center text-muted">Sem dados.</td></tr>@endforelse</tbody></table></div></div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-header"><strong>Registros</strong></div>
        <div class="table-responsive"><table class="table table-sm table-striped align-middle mb-0"><thead><tr><th>Atendimento</th></tr></thead><tbody>@forelse($detalhes as $item)<tr><td><strong>Data:</strong> {{ $item->data_atendimento }}<br><strong>Assunto:</strong> {{ $item->assunto }}@if($item->outros_complemento)<br><strong>Complemento:</strong> {{ $item->outros_complemento }}@endif<br><strong>Domicílio:</strong> {{ $item->domicilio }}<br><strong>Atendente:</strong> {{ $item->usuario_nome }} ({{ $item->usuario_login }})</td></tr>@empty<tr><td class="text-center text-muted">Sem registros para os filtros.</td></tr>@endforelse</tbody></table></div>
        @if($detalhes->hasPages())<div class="card-footer">{{ $detalhes->links('pagination::bootstrap-5') }}</div>@endif
    </div>
</div>

<div class="modal fade" id="modal-exportar-pdf" tabindex="-1" aria-labelledby="modal-exportar-pdf-label" aria-hidden="true">
    <div class="modal-dialog"><form class="modal-content" method="GET" action="{{ route('disque-eleicao.relatorios.pdf') }}" target="_blank">
        <div class="modal-header"><h2 class="modal-title h5" id="modal-exportar-pdf-label">Exportar para PDF</h2><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button></div>
        <div class="modal-body">
            @foreach($filtros as $nome => $valor)@if($valor !== null && $valor !== '')<input type="hidden" name="{{ $nome }}" value="{{ $valor }}">@endif @endforeach
            @foreach($camposPdf as $campo => $rotulo)
                <div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="campo-pdf-{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="campo-pdf-{{ $campo }}">{{ $rotulo }}</label></div>
            @endforeach
        </div>
        <div class="modal-footer"><button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit">Gerar PDF</button></div>
    </form></div>
</div>
@endsection
```
</RESOURCES_VIEWS_DISQUE_ELEICAO_RELATORIOS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/disque-eleicao/relatorios/pdf.blade.php`
## <RESOURCES_VIEWS_DISQUE_ELEICAO_RELATORIOS_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/disque-eleicao/relatorios/pdf.blade.php`
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
<!doctype html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <style>
        body{font-family:DejaVu Sans,sans-serif;font-size:9px;color:#222}
        h1,h2{margin:0 0 8px}
        table{width:100%;border-collapse:collapse;margin-bottom:14px}
        th,td{border:1px solid #bbb;padding:4px;text-align:left}
        th{background:#eee}
        .numero{text-align:right}
        .muted{color:#666}
    </style>
</head>
<body>
<h1>Relatório do Disque Eleição</h1>
<p class="muted">Gerado em {{ $geradoEm }}</p>

<h2>Resumo</h2>
<p><strong>Total de atendimentos:</strong> {{ $consolidado['total'] }}</p>

<h2>Por assunto</h2>
<table>
    <thead><tr><th>Assunto</th><th>Quantidade</th><th>Percentual</th></tr></thead>
    <tbody>
    @forelse($consolidado['assuntos'] as $item)
        <tr>
            <td>{{ $item['descricao'] }}</td>
            <td class="numero">{{ $item['quantidade'] }}</td>
            <td class="numero">{{ number_format($item['percentual'], 2, ',', '.') }}%</td>
        </tr>
    @empty
        <tr><td colspan="3" class="muted">Sem dados.</td></tr>
    @endforelse
    </tbody>
</table>

<h2>Por domicílio</h2>
<table>
    <thead><tr><th>Domicílio eleitoral</th><th>Quantidade</th></tr></thead>
    <tbody>
    @forelse($consolidado['domicilios'] as $item)
        <tr><td>{{ $item['descricao'] }}</td><td class="numero">{{ $item['quantidade'] }}</td></tr>
    @empty
        <tr><td colspan="2" class="muted">Sem dados.</td></tr>
    @endforelse
    </tbody>
</table>

<h2>Por atendente</h2>
<table>
    <thead><tr><th>Atendente</th><th>Quantidade</th></tr></thead>
    <tbody>
    @forelse($consolidado['atendentes'] as $item)
        <tr>
            <td>{{ $item['nome'] }} ({{ $item['login'] }})</td>
            <td class="numero">{{ $item['quantidade'] }}</td>
        </tr>
    @empty
        <tr><td colspan="2" class="muted">Sem dados.</td></tr>
    @endforelse
    </tbody>
</table>

<h2>Por período</h2>
<table>
    <thead><tr><th>Tipo</th><th>Período</th><th>Quantidade</th></tr></thead>
    <tbody>
    @forelse($consolidado['periodos'] as $item)
        <tr>
            <td>{{ $item['tipo'] }}</td>
            <td>{{ $item['periodo'] }}</td>
            <td class="numero">{{ $item['quantidade'] }}</td>
        </tr>
    @empty
        <tr><td colspan="3" class="muted">Sem dados.</td></tr>
    @endforelse
    </tbody>
</table>

<h2>Registros</h2>
<table>
    <thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead>
    <tbody>
    @forelse($registros as $item)
        <tr>
        @foreach($campos as $campo)
            <td>
                @switch($campo)
                    @case('data_atendimento'){{ $item['data_atendimento'] }}@break
                    @case('assunto'){{ $item['assunto'] }}@break
                    @case('complemento'){{ $item['outros_complemento'] ?: '-' }}@break
                    @case('domicilio'){{ $item['domicilio'] }}@break
                    @case('atendente'){{ $item['usuario_nome'] }} ({{ $item['usuario_login'] }})@break
                    @case('lote'){{ $item['lote_uuid'] }}@break
                @endswitch
            </td>
        @endforeach
        </tr>
    @empty
        <tr><td colspan="{{ count($campos) }}" class="muted">Sem registros.</td></tr>
    @endforelse
    </tbody>
</table>
</body>
</html>
```
</RESOURCES_VIEWS_DISQUE_ELEICAO_RELATORIOS_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/disque-eleicao-assuntos/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_DISQUE_ELEICAO_ASSUNTOS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/disque-eleicao-assuntos/form.blade.php`
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
@extends('layouts.app')

@section('titulo', ($assunto ? 'Editar' : 'Novo').' assunto do Disque Eleição')

@section('conteudo')
<div class="container py-3"><div class="d-flex justify-content-between align-items-center mb-3"><h1 class="h3 mb-0">{{ $assunto ? 'Editar' : 'Novo' }} assunto</h1><a class="btn btn-outline-secondary" href="{{ route('tabelas-auxiliares.disque-eleicao-assuntos.index') }}">Voltar</a></div>
@if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<div class="card shadow-sm"><div class="card-body"><form method="POST" action="{{ $assunto ? route('tabelas-auxiliares.disque-eleicao-assuntos.update', $assunto->id) : route('tabelas-auxiliares.disque-eleicao-assuntos.store') }}">@csrf @if($assunto)@method('PUT')@endif
<div class="row g-3"><div class="col-md-5"><label class="form-label" for="codigo">Código estável</label><input class="form-control" id="codigo" name="codigo" maxlength="40" value="{{ old('codigo', $assunto->codigo ?? '') }}" @readonly($assunto !== null) required></div><div class="col-md-7"><label class="form-label" for="descricao">Descrição</label><input class="form-control" id="descricao" name="descricao" maxlength="160" value="{{ old('descricao', $assunto->descricao ?? '') }}" required></div><div class="col-md-3"><label class="form-label" for="ordem">Ordem</label><input class="form-control" id="ordem" type="number" min="0" name="ordem" value="{{ old('ordem', $assunto->ordem ?? 0) }}" required></div><div class="col-md-3 d-flex align-items-end"><input type="hidden" name="ativo" value="0"><div class="form-check mb-2"><input class="form-check-input" id="ativo" type="checkbox" name="ativo" value="1" @checked((int)old('ativo', $assunto->ativo ?? 1) === 1)><label class="form-check-label" for="ativo">Ativo</label></div></div></div>
<button class="btn btn-primary mt-3" type="submit"><i class="fa-solid fa-floppy-disk me-1"></i> Salvar</button></form></div></div></div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_DISQUE_ELEICAO_ASSUNTOS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/disque-eleicao-assuntos/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_DISQUE_ELEICAO_ASSUNTOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/disque-eleicao-assuntos/index.blade.php`
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
@extends('layouts.app')

@section('titulo', 'Assuntos do Disque Eleição')

@section('conteudo')
<div class="container-fluid py-3">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3"><h1 class="h3 mb-0">Assuntos do Disque Eleição</h1><a class="btn btn-primary" href="{{ route('tabelas-auxiliares.disque-eleicao-assuntos.form') }}"><i class="fa-solid fa-plus me-1"></i> Novo assunto</a></div>
    @if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif
    @if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
    <form class="row g-2 mb-3" method="GET"><div class="col-md-8"><label class="form-label" for="busca">Busca</label><input class="form-control" id="busca" name="busca" value="{{ $busca }}"></div><div class="col-md-4 d-flex align-items-end gap-2"><button class="btn btn-primary" type="submit">Filtrar</button><button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#modal-exportar-assuntos-pdf"><i class="fa-solid fa-file-pdf me-1"></i> Exportar PDF</button></div></form>
    <div class="table-responsive"><table class="table table-sm table-striped align-middle"><thead><tr><th>Assunto</th><th>Ações</th></tr></thead><tbody>@forelse($assuntos as $assunto)<tr><td><strong>Código:</strong> {{ $assunto->codigo }}<br><strong>Descrição:</strong> {{ $assunto->descricao }}<br><strong>Ordem:</strong> {{ $assunto->ordem }}<br><strong>Status:</strong> {{ (int)$assunto->ativo === 1 ? 'Ativo' : 'Inativo' }}</td><td class="text-nowrap"><a class="btn btn-sm btn-outline-primary" href="{{ route('tabelas-auxiliares.disque-eleicao-assuntos.form', $assunto->id) }}" title="Editar" aria-label="Editar"><i class="fa-solid fa-pen"></i></a><form class="d-inline" method="POST" action="{{ route('tabelas-auxiliares.disque-eleicao-assuntos.destroy', $assunto->id) }}" onsubmit="return confirm('Excluir ou inativar este assunto?');">@csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger" type="submit" title="Excluir ou inativar" aria-label="Excluir ou inativar"><i class="fa-solid fa-trash"></i></button></form></td></tr>@empty<tr><td colspan="2" class="text-center text-muted">Nenhum assunto encontrado.</td></tr>@endforelse</tbody></table></div>
    @if($assuntos->hasPages()){{ $assuntos->links('pagination::bootstrap-5') }}@endif
</div>
<div class="modal fade" id="modal-exportar-assuntos-pdf" tabindex="-1" aria-labelledby="modal-exportar-assuntos-pdf-label" aria-hidden="true"><div class="modal-dialog"><form class="modal-content" method="GET" action="{{ route('tabelas-auxiliares.disque-eleicao-assuntos.exportar-pdf') }}" target="_blank"><div class="modal-header"><h2 class="modal-title h5" id="modal-exportar-assuntos-pdf-label">Exportar para PDF</h2><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button></div><div class="modal-body"><input type="hidden" name="busca" value="{{ $busca }}">@foreach($camposPdf as $campo => $rotulo)<div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="assunto-campo-{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="assunto-campo-{{ $campo }}">{{ $rotulo }}</label></div>@endforeach</div><div class="modal-footer"><button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit">Gerar PDF</button></div></form></div></div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_DISQUE_ELEICAO_ASSUNTOS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/disque-eleicao-assuntos/pdf.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_DISQUE_ELEICAO_ASSUNTOS_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/disque-eleicao-assuntos/pdf.blade.php`
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
<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><style>body{font-family:DejaVu Sans,sans-serif;font-size:10px}table{width:100%;border-collapse:collapse}th,td{border:1px solid #bbb;padding:5px}th{background:#eee}</style></head><body><h1>Assuntos do Disque Eleição</h1><p>Gerado em {{ $geradoEm }}</p><table><thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead><tbody>@foreach($assuntos as $assunto)<tr>@foreach($campos as $campo)<td>@switch($campo)@case('codigo'){{ $assunto->codigo }}@break @case('descricao'){{ $assunto->descricao }}@break @case('ordem'){{ $assunto->ordem }}@break @case('status'){{ (int)$assunto->ativo === 1 ? 'Ativo' : 'Inativo' }}@break @endswitch</td>@endforeach</tr>@endforeach</tbody></table></body></html>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_DISQUE_ELEICAO_ASSUNTOS_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/DisqueEleicaoModuloTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_DISQUEELEICAOMODULOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/DisqueEleicaoModuloTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class DisqueEleicaoModuloTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_migrations_criam_dominio_atendimento_constraints_e_acl(): void
public function test_rotas_menu_e_contexto_de_turno_cobrem_todo_o_modulo(): void
public function test_repositories_recebem_contexto_explicito_e_auditam_todo_dml(): void
public function test_restore_e_seeders_classificam_assunto_e_atendimento(): void
public function test_telas_sao_responsivas_paginadas_e_exportam_com_selecao_de_campos(): void
private function ler(string $arquivo): string
private function caminho(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use PHPUnit\Framework\TestCase;

class DisqueEleicaoModuloTest extends TestCase
{
    public function test_migrations_criam_dominio_atendimento_constraints_e_acl(): void
    {
        $assunto = $this->ler('database/migrations/2026_07_28_100000_create_disque_eleicao_assunto_table.php');
        $atendimento = $this->ler('database/migrations/2026_07_28_101000_create_disque_eleicao_atendimento_table.php');
        $acl = $this->ler('database/migrations/2026_07_28_102000_create_disque_eleicao_acl.php');
        $domicilioExtra = $this->ler('database/migrations/2026_08_21_120000_create_disque_eleicao_domicilio_extra_table.php');
        $evolucaoCatalogos = $this->ler('database/migrations/2026_08_21_121000_evolve_disque_eleicao_catalogs.php');

        $this->assertStringContainsString('CREATE TABLE disque_eleicao_assunto', $assunto);
        $this->assertStringContainsString('UX_DE_ASSUNTO_CODIGO', $assunto);
        $this->assertStringContainsString('CK_DE_ASSUNTO_ATIVO', $assunto);
        $this->assertStringContainsString('CREATE TABLE disque_eleicao_atendimento', $atendimento);
        $this->assertStringContainsString('FK_DE_ATEND_ASSUNTO', $atendimento);
        $this->assertStringContainsString('FK_DE_ATEND_MACRO', $atendimento);
        $this->assertStringContainsString('CK_DE_ATEND_TURNO', $atendimento);
        $this->assertStringContainsString('UX_DE_ATEND_LOTE_ASSUNTO', $atendimento);
        $this->assertStringContainsString('PLANELEITO_DISQUE_ELEICAO_ATENDENTE', $acl);
        $this->assertStringContainsString('PLANELEITO_DISQUE_ELEICAO_GESTOR', $acl);
        $this->assertStringContainsString('ignora_unidades_permitidas', $acl);
        $this->assertStringContainsString('CREATE TABLE disque_eleicao_domicilio_extra', $domicilioExtra);
        $this->assertStringContainsString('CK_DE_DOM_EXTRA_ATIVO', $domicilioExtra);
        $this->assertStringContainsString('ESPECIAL_NAO_IDENTIFICADO', $evolucaoCatalogos);
        $this->assertStringContainsString('ESPECIAL_OUTRO_ESTADO', $evolucaoCatalogos);
        $this->assertStringContainsString('ORIENTACOES_ILICITOS_ELEITORAIS', $evolucaoCatalogos);
        $this->assertStringContainsString('PROPAGANDA_ELEITORAL', $evolucaoCatalogos);
        $this->assertStringContainsString('CRIME_ELEITORAL', $evolucaoCatalogos);
    }

    public function test_rotas_menu_e_contexto_de_turno_cobrem_todo_o_modulo(): void
    {
        $rotas = $this->ler('routes/web.php');
        foreach ([
            "name('disque-eleicao.index')",
            "name('disque-eleicao.store')",
            "name('disque-eleicao.edit')",
            "name('disque-eleicao.update')",
            "name('disque-eleicao.destroy')",
            "name('disque-eleicao.relatorios.index')",
            "name('disque-eleicao.relatorios.pdf')",
            "name('disque-eleicao.relatorios.xlsx')",
            "name('disque-eleicao-assuntos.index')",
            "name('disque-eleicao-assuntos.exportar-pdf')",
        ] as $rota) {
            $this->assertStringContainsString($rota, $rotas, $rota);
        }

        $menu = $this->ler('config/planeleito_menu.php');
        $this->assertStringContainsString("'route' => 'disque-eleicao.index'", $menu);
        $this->assertStringContainsString("'route_patterns' => ['disque-eleicao.*']", $menu);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.disque-eleicao-assuntos.index'", $menu);

        $config = $this->ler('config/planeleito.php');
        foreach ([
            "'disque-eleicao.index'",
            "'disque-eleicao.store'",
            "'disque-eleicao.edit'",
            "'disque-eleicao.update'",
            "'disque-eleicao.destroy'",
            "'disque-eleicao.relatorios.index'",
            "'disque-eleicao.relatorios.pdf'",
            "'disque-eleicao.relatorios.xlsx'",
        ] as $rota) {
            $this->assertStringContainsString($rota, $config, $rota);
        }
    }

    public function test_repositories_recebem_contexto_explicito_e_auditam_todo_dml(): void
    {
        $atendimento = $this->ler('app/Repositories/DisqueEleicao/DisqueEleicaoAtendimentoRepository.php');
        $assunto = $this->ler('app/Repositories/DisqueEleicao/DisqueEleicaoAssuntoRepository.php');

        $this->assertStringContainsString('use AuditaDml;', $atendimento);
        $this->assertStringContainsString('inserirLoteAuditado', $atendimento);
        $this->assertStringContainsString('atualizarEscopoAuditado', $atendimento);
        $this->assertStringContainsString('removerEscopoAuditado', $atendimento);
        $this->assertStringNotContainsString('session(', $atendimento);
        $this->assertStringNotContainsString('auth(', $atendimento);
        $this->assertStringContainsString('use AuditaDml;', $assunto);
        $this->assertStringNotContainsString('session(', $assunto);
    }

    public function test_restore_e_seeders_classificam_assunto_e_atendimento(): void
    {
        $manifesto = $this->ler('app/Support/DatabaseRestore/RestoreTableManifest.php');
        $seeder = $this->ler('database/seeders/DisqueEleicaoSeeder.php');
        $databaseSeeder = $this->ler('database/seeders/DatabaseSeeder.php');

        $this->assertGreaterThanOrEqual(3, substr_count($manifesto, "'disque_eleicao_assunto'"));
        $this->assertGreaterThanOrEqual(3, substr_count($manifesto, "'disque_eleicao_atendimento'"));
        $this->assertGreaterThanOrEqual(3, substr_count($manifesto, "'disque_eleicao_domicilio_extra'"));
        $this->assertStringContainsString("'OUTROS'", $seeder);
        $this->assertStringContainsString("'ORIENTACOES_ILICITOS_ELEITORAIS'", $seeder);
        $this->assertStringContainsString("'ESPECIAL_NAO_IDENTIFICADO'", $seeder);
        $this->assertStringContainsString("'ESPECIAL_OUTRO_ESTADO'", $seeder);
        $this->assertStringContainsString('PLANELEITO_DISQUE_ELEICAO_ATENDENTE', $seeder);
        $this->assertStringContainsString('PLANELEITO_DISQUE_ELEICAO_GESTOR', $seeder);
        $this->assertStringContainsString('DisqueEleicaoSeeder::class', $databaseSeeder);
        $this->assertFileExists($this->caminho('database/seeders/data/restore-reference/disque_eleicao_assunto.json'));
        $this->assertFileExists($this->caminho('database/seeders/data/restore-reference/disque_eleicao_domicilio_extra.json'));
    }

    public function test_telas_sao_responsivas_paginadas_e_exportam_com_selecao_de_campos(): void
    {
        $operacional = $this->ler('resources/views/disque-eleicao/index.blade.php');
        $relatorios = $this->ler('resources/views/disque-eleicao/relatorios/index.blade.php');
        $assuntos = $this->ler('resources/views/tabelas-auxiliares/disque-eleicao-assuntos/index.blade.php');

        $this->assertStringContainsString('name="assunto_ids[]"', $operacional);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $operacional);
        $this->assertStringContainsString('modal-exportar-pdf', $relatorios);
        $this->assertStringContainsString('name="campos[]"', $relatorios);
        $this->assertStringContainsString('Exportar XLSX', $relatorios);
        $this->assertStringContainsString('table table-sm table-striped align-middle', $assuntos);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $assuntos);
        $this->assertStringContainsString('modal-exportar-assuntos-pdf', $assuntos);
    }

    private function ler(string $arquivo): string
    {
        $caminho = $this->caminho($arquivo);
        $this->assertFileExists($caminho, $arquivo);

        return (string) file_get_contents($caminho);
    }

    private function caminho(string $arquivo): string
    {
        return dirname(__DIR__, 4).'/'.$arquivo;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_DISQUEELEICAOMODULOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/RiscoCicloModuloTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RISCOCICLOMODULOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/RiscoCicloModuloTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RiscoCicloModuloTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringNotContainsString("DB::table('auditoria_acao')", $repository);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_repository_aplica_macro_escopo_vazio_gestora_e_impactada_e_paginacao(): void
public function test_gravacoes_compostas_arquivamento_e_reativacao_sao_transacionais_e_auditados(): void
public function test_cadastro_mantem_impactos_e_ciclo_bloqueia_risco_arquivado(): void
public function test_dominios_possuem_repository_coeso_separado_do_cadastro(): void
public function test_ids_nao_usam_intval_com_chave_da_collection_como_base_numerica(): void
public function test_detalhe_separa_pendencias_e_nao_recompoe_auditoria_dml_local(): void
public function test_responsavel_original_nao_e_aceito_no_payload_nem_atualizado_pelo_ciclo(): void
public function test_detalhe_carrega_unidade_responsavel_oficial_para_acoes(): void
public function test_rotas_cobrem_detalhe_ciclo_contexto_importacao_pendencias_e_pdf(): void
public function test_pdf_valida_campos_e_reutiliza_filtros_e_escopo_no_backend(): void
public function test_listagem_responsiva_tem_filtros_modal_pdf_e_acoes_condicionais(): void
public function test_pendencias_validam_e_aplicam_filtro_do_risco_sem_descobrir_contexto(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class RiscoCicloModuloTest extends TestCase
{
    public function test_repository_aplica_macro_escopo_vazio_gestora_e_impactada_e_paginacao(): void
    {
        $conteudo = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoRepository.php');
        $importacao = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoImportacaoRepository.php');
        $escopo = file_get_contents($this->raiz().'/app/Repositories/Riscos/Queries/RiscoEscopoQuery.php');

        $this->assertStringContainsString("where('r.macroprojeto_id', \$macroprojetoId)", $conteudo);
        $this->assertStringContainsString('escopoRisco->aplicar', $conteudo);
        $this->assertStringContainsString('escopoRisco->aplicar', $importacao);
        $this->assertStringContainsString("whereRaw('1 = 0')", $escopo);
        $this->assertStringContainsString(".unidade_gestora_id', \$unidades)", $escopo);
        $this->assertStringContainsString("from('risco_unidade_impactada as rui')", $escopo);
        $this->assertStringContainsString("from('grupo_unidade_membro as gum')", $escopo);
        $this->assertStringContainsString('paginate($porPagina)', $conteudo);
        $this->assertStringNotContainsString('session(', $conteudo);
        $this->assertStringNotContainsString('session(', $importacao);
        $this->assertStringNotContainsString('session(', $escopo);
    }

    public function test_gravacoes_compostas_arquivamento_e_reativacao_sao_transacionais_e_auditados(): void
    {
        $conteudo = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoRepository.php');

        $this->assertGreaterThanOrEqual(3, substr_count($conteudo, 'DB::transaction'));
        $this->assertStringContainsString('inserirAuditado', $conteudo);
        $this->assertStringContainsString('atualizarAuditadoPorId', $conteudo);
        $this->assertStringNotContainsString('DELETE FROM RISCO WHERE', $conteudo);
    }

    public function test_cadastro_mantem_impactos_e_ciclo_bloqueia_risco_arquivado(): void
    {
        $cadastro = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoRepository.php');
        $ciclo = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoCicloRepository.php');
        $form = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/form.blade.php');

        $this->assertStringContainsString('RISCO_UNIDADE_IMPACTADA', $cadastro);
        $this->assertStringContainsString('RISCO_GRUPO_IMPACTADO', $cadastro);
        $this->assertStringContainsString("where('r.arquivado', 0)", $ciclo);
        $this->assertStringContainsString('name="UNIDADES_IMPACTADAS[]"', $form);
        $this->assertStringContainsString('name="GRUPOS_IMPACTADOS[]"', $form);
    }

    public function test_dominios_possuem_repository_coeso_separado_do_cadastro(): void
    {
        $interface = file_get_contents($this->raiz().'/app/Repositories/Riscos/Contracts/RiscoDominioRepositoryInterface.php');
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoDominioRepository.php');
        $cadastro = file_get_contents($this->raiz().'/app/Repositories/Riscos/Contracts/RiscoRepositoryInterface.php');

        $this->assertStringContainsString('interface RiscoDominioRepositoryInterface', $interface);
        $this->assertStringContainsString('class RiscoDominioRepository', $repository);
        $this->assertStringNotContainsString('listarDominios', $cadastro);
    }

    public function test_ids_nao_usam_intval_com_chave_da_collection_como_base_numerica(): void
    {
        foreach ([
            'app/Repositories/Riscos/RiscoRepository.php',
            'app/Http/Controllers/Riscos/RiscoController.php',
            'resources/views/planejamento/riscos/_form_tratamento.blade.php',
            'resources/views/planejamento/riscos/_form_contingencia.blade.php',
        ] as $arquivo) {
            $conteudo = file_get_contents($this->raiz().'/'.$arquivo);
            $this->assertStringNotContainsString("map('intval')", $conteudo, $arquivo);
        }
    }

    public function test_detalhe_separa_pendencias_e_nao_recompoe_auditoria_dml_local(): void
    {
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoRepository.php');
        $detalhe = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/detalhe.blade.php');

        $this->assertStringNotContainsString('buscarAuditoriaRisco', $repository);
        $this->assertStringNotContainsString("DB::table('auditoria_acao')", $repository);
        $this->assertStringNotContainsString("'auditoria' =>", $repository);
        $this->assertStringContainsString("'pendencias'=>'Pendências'", $detalhe);
        $this->assertStringContainsString('id="tab-pendencias"', $detalhe);
        $this->assertStringNotContainsString("'auditoria'=>'Auditoria'", $detalhe);
        $this->assertStringNotContainsString('Auditoria DML', $detalhe);
    }

    public function test_responsavel_original_nao_e_aceito_no_payload_nem_atualizado_pelo_ciclo(): void
    {
        $controller = file_get_contents($this->raiz().'/app/Http/Controllers/Riscos/RiscoCicloController.php');
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoCicloRepository.php');

        $this->assertStringNotContainsString("'responsavel_original' =>", $controller);
        $this->assertStringNotContainsString("\$dados['responsavel_original']", $repository);
        $this->assertStringNotContainsString("'RESPONSAVEL_ORIGINAL' =>", $repository);
    }

    public function test_detalhe_carrega_unidade_responsavel_oficial_para_acoes(): void
    {
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoRepository.php');

        $this->assertGreaterThanOrEqual(2, substr_count($repository, "leftJoin('vw_unidade as ur'"));
        $this->assertStringContainsString('unidade_responsavel_nome', $repository);
    }

    public function test_rotas_cobrem_detalhe_ciclo_contexto_importacao_pendencias_e_pdf(): void
    {
        $conteudo = file_get_contents($this->raiz().'/routes/web.php');

        foreach ([
            "name('riscos.detalhe')",
            "name('riscos.reativar')",
            "name('riscos.contexto')",
            "name('riscos.controles.salvar')",
            "name('riscos.tratamentos.salvar')",
            "name('riscos.contingencias.salvar')",
            "name('riscos.monitoramentos.salvar')",
            "name('riscos.comunicacoes.salvar')",
            "name('riscos.importacoes.index')",
            "name('riscos.pendencias.index')",
            "name('riscos.exportar-pdf')",
        ] as $rota) {
            $this->assertStringContainsString($rota, $conteudo);
        }
    }

    public function test_pdf_valida_campos_e_reutiliza_filtros_e_escopo_no_backend(): void
    {
        $conteudo = file_get_contents($this->raiz().'/app/Http/Controllers/Riscos/RiscoController.php');

        $this->assertStringContainsString('CAMPOS_PDF', $conteudo);
        $this->assertStringContainsString('CamposPdfSelecionados::resolver', $conteudo);
        $this->assertStringContainsString('listarParaExportacao', $conteudo);
        $this->assertStringContainsString('unidadesParaConsultaAtual', $conteudo);
    }

    public function test_listagem_responsiva_tem_filtros_modal_pdf_e_acoes_condicionais(): void
    {
        $index = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/index.blade.php');
        $lista = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/lista.blade.php');
        $javascript = file_get_contents($this->raiz().'/public/js/planejamento/riscos.js');

        $this->assertStringContainsString('modalExportarRiscos', $index);
        $this->assertStringContainsString('name="nivel_residual"', $index);
        $this->assertStringContainsString('name="pendencia"', $index);
        $this->assertStringContainsString('Status do ciclo', $index);
        $this->assertStringContainsString("@continue(\$status->codigo === 'ARQUIVADO')", $index);
        $this->assertStringContainsString('table-responsive', $lista);
        $this->assertStringContainsString('class="d-inline js-arquivar-form"', $lista);
        $this->assertStringContainsString("route('riscos.deletar', \$risco->id)", $lista);
        $this->assertStringContainsString("route('riscos.reativar', \$risco->id)", $lista);
        $this->assertStringContainsString(
            "route('riscos.pendencias.index', ['risco_id' => \$risco->id, 'status' => 'ABERTA'])",
            $lista
        );
        $this->assertStringContainsString('$podeArquivar', $lista);
        $this->assertStringContainsString('$podeReativar', $lista);
        $this->assertStringContainsString('$podeResolverPendencias', $lista);
        $this->assertStringContainsString("route('riscos.detalhe'", $lista);
        $this->assertStringContainsString('form.submit()', $javascript);
        $this->assertStringNotContainsString('window.alert(r.mensagem)', $javascript);
        $this->assertStringNotContainsString("deletar: @json(route('riscos.deletar'", $index);
    }

    public function test_pendencias_validam_e_aplicam_filtro_do_risco_sem_descobrir_contexto(): void
    {
        $controller = file_get_contents($this->raiz().'/app/Http/Controllers/Riscos/RiscoImportacaoController.php');
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoImportacaoRepository.php');
        $view = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/pendencias.blade.php');

        $this->assertStringContainsString('RiscoPendenciaFiltroRequest $request', $controller);
        $this->assertStringContainsString('$request->validated()', $controller);
        $this->assertStringContainsString("! empty(\$filtros['risco_id'])", $repository);
        $this->assertStringContainsString("where('rp.risco_id', (int) \$filtros['risco_id'])", $repository);
        $this->assertStringNotContainsString('session(', $repository);
        $this->assertStringContainsString("session('success')", $view);
        $this->assertStringContainsString('$errors->first()', $view);
    }

    public function test_listagem_principal_e_paginacao_nao_dependem_de_ajax(): void
    {
        $index = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/index.blade.php');
        $javascript = file_get_contents($this->raiz().'/public/js/planejamento/riscos.js');

        $this->assertStringContainsString('method="GET"', $index);
        $this->assertStringContainsString("action=\"{{ route('riscos.index') }}\"", $index);
        $this->assertStringContainsString("@include('planejamento.riscos.lista'", $index);
        $this->assertStringContainsString("filemtime(public_path('js/planejamento/riscos.js'))", $index);
        $this->assertStringNotContainsString('function carregarLista', $javascript);
        $this->assertStringNotContainsString('#conteudoRiscos .pagination a', $javascript);
    }

    public function test_cadastro_manual_gera_codigo_no_backend_antes_da_inclusao(): void
    {
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoRepository.php');

        $this->assertStringContainsString(
            "'CODIGO_EXTERNO' => CodigoRiscoManual::novo()",
            $repository
        );
    }

    public function test_previa_administrativa_exibe_resumo_e_mensagens_antes_da_aplicacao(): void
    {
        $controller = file_get_contents($this->raiz().'/app/Http/Controllers/Riscos/RiscoImportacaoController.php');
        $repository = file_get_contents($this->raiz().'/app/Repositories/Riscos/RiscoImportacaoRepository.php');
        $view = file_get_contents($this->raiz().'/resources/views/planejamento/riscos/importacoes.blade.php');

        $this->assertStringContainsString('listarItensLote', $controller);
        $this->assertStringContainsString('listarItensLote', $repository);
        $this->assertStringContainsString('distribuicao_inerente', $view);
        $this->assertStringContainsString('distribuicao_residual', $view);
        $this->assertStringContainsString('mensagens_decodificadas', $view);
        $this->assertStringContainsString("route('riscos.importacoes.index', ['lote'", $view);
    }

    private function raiz(): string
    {
        return dirname(__DIR__, 4);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RISCOCICLOMODULOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/RotaEquipeTelefoneTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_ROTAEQUIPETELEFONETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/RotaEquipeTelefoneTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RotaEquipeTelefoneTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_exibe_telefone_dos_integrantes_da_equipe(): void
public function repository_inclui_telefone_no_retorno_de_listar_equipe_por_rotas(): void
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

class RotaEquipeTelefoneTest extends TestCase
{
    #[Test]
    public function view_exibe_telefone_dos_integrantes_da_equipe(): void
    {
        $conteudo = file_get_contents(resource_path('views/lda/rotas/index.blade.php'));

        $this->assertStringContainsString(
            'telefone',
            $conteudo,
            'A view deve exibir o telefone do integrante da equipe.'
        );
    }

    #[Test]
    public function repository_inclui_telefone_no_retorno_de_listar_equipe_por_rotas(): void
    {
        $conteudo = file_get_contents(app_path('Repositories/Lda/RotaRepository.php'));

        $this->assertStringContainsString(
            'v.telefone',
            $conteudo,
            'listarEquipePorRotas deve selecionar o campo telefone da view vw_convocados.'
        );
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_ROTAEQUIPETELEFONETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoAssuntoServiceTest.php`
## <TESTS_UNIT_DISQUEELEICAOASSUNTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoAssuntoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoAssuntoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_outros_nao_pode_ser_removido(): void
public function test_assunto_referenciado_e_inativado_em_vez_de_excluido(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAssuntoRepositoryInterface;
use App\Services\DisqueEleicao\DisqueEleicaoAssuntoService;
use DomainException;
use Mockery;
use Tests\TestCase;

class DisqueEleicaoAssuntoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_outros_nao_pode_ser_removido(): void
    {
        $repository = Mockery::mock(DisqueEleicaoAssuntoRepositoryInterface::class);
        $repository->shouldReceive('buscar')->once()->with(16)->andReturn((object) ['id' => 16, 'codigo' => 'OUTROS']);
        $repository->shouldNotReceive('remover');
        $repository->shouldNotReceive('inativar');

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('reservado');

        (new DisqueEleicaoAssuntoService($repository))->removerOuInativar(16);
    }

    public function test_assunto_referenciado_e_inativado_em_vez_de_excluido(): void
    {
        $repository = Mockery::mock(DisqueEleicaoAssuntoRepositoryInterface::class);
        $repository->shouldReceive('buscar')->once()->with(4)->andReturn((object) ['id' => 4, 'codigo' => 'SITUACAO_ELEITORAL']);
        $repository->shouldReceive('possuiAtendimentos')->once()->with(4)->andReturnTrue();
        $repository->shouldReceive('inativar')->once()->with(4)->andReturn(1);
        $repository->shouldNotReceive('remover');

        $resultado = (new DisqueEleicaoAssuntoService($repository))->removerOuInativar(4);

        $this->assertSame('inativado', $resultado);
    }
}
```
</TESTS_UNIT_DISQUEELEICAOASSUNTOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoAtendimentoServiceTest.php`
## <TESTS_UNIT_DISQUEELEICAOATENDIMENTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoAtendimentoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoAtendimentoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_tres_assuntos_geram_tres_atendimentos_no_mesmo_lote(): void
public function test_assunto_repetido_e_rejeitado_sem_persistencia(): void
public function test_outros_sem_complemento_e_rejeitado(): void
public function test_lote_repetido_e_rejeitado_antes_de_consultar_catalogos(): void
public function test_assunto_inativo_e_rejeitado_sem_persistencia(): void
public function test_domicilio_invalido_e_rejeitado_sem_persistencia(): void
public function test_atendente_nao_exclui_registro_de_outro_usuario(): void
public function test_gestor_exclui_registro_de_outro_usuario_no_mesmo_contexto(): void
public function test_id_de_outro_contexto_nao_pode_ser_excluido(): void
public function test_atendente_atualiza_apenas_campos_editaveis_do_registro_proprio(): void
public function test_edicao_preserva_assunto_atual_inativado_sem_permitir_novo_vinculo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAtendimentoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoCatalogoRepositoryInterface;
use App\Services\DisqueEleicao\DisqueEleicaoAtendimentoService;
use App\Services\DisqueEleicao\DisqueEleicaoContexto;
use DomainException;
use Mockery;
use Tests\TestCase;

class DisqueEleicaoAtendimentoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_tres_assuntos_geram_tres_atendimentos_no_mesmo_lote(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldReceive('buscarAssuntosAtivosPorIds')
            ->once()
            ->with([1, 2, 16])
            ->andReturn([
                ['id' => 1, 'codigo' => 'LOCAL_VOTACAO', 'descricao' => 'Local de votação'],
                ['id' => 2, 'codigo' => 'HORARIO_VOTACAO', 'descricao' => 'Horário de votação'],
                ['id' => 16, 'codigo' => 'OUTROS', 'descricao' => 'Outros'],
            ]);
        $catalogo->shouldReceive('buscarDomicilio')
            ->once()
            ->with('16')
            ->andReturn(['codigo' => '16', 'descricao' => 'RIO BRANCO']);

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('loteJaRegistrado')->once()->with(self::LOTE_UUID)->andReturnFalse();
        $repository->shouldReceive('criarLote')
            ->once()
            ->with(Mockery::on(function (array $linhas): bool {
                $this->assertCount(3, $linhas);
                $this->assertSame([1, 2, 16], array_column($linhas, 'assunto_id'));
                $this->assertSame([self::LOTE_UUID], array_values(array_unique(array_column($linhas, 'lote_uuid'))));
                $this->assertSame(['16'], array_values(array_unique(array_column($linhas, 'domicilio_codigo'))));
                $this->assertSame([7], array_values(array_unique(array_column($linhas, 'macroprojeto_id'))));
                $this->assertSame(['2'], array_values(array_unique(array_column($linhas, 'turno'))));
                $this->assertSame(['ana'], array_values(array_unique(array_column($linhas, 'usuario_login'))));
                $this->assertNull($linhas[0]['outros_complemento']);
                $this->assertSame('Atendimento não classificado', $linhas[2]['outros_complemento']);

                return true;
            }))
            ->andReturn(3);

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);
        $quantidade = $service->registrar([
            'lote_uuid' => self::LOTE_UUID,
            'assunto_ids' => [1, 2, 16],
            'domicilio_codigo' => '16',
            'outros_complemento' => ' Atendimento não classificado ',
        ], new DisqueEleicaoContexto(7, '2', 'ana', 'Ana Atendente', false));

        $this->assertSame(3, $quantidade);
    }

    public function test_assunto_repetido_e_rejeitado_sem_persistencia(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldNotReceive('criarLote');

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('Assuntos duplicados');

        $service->registrar([
            'lote_uuid' => self::LOTE_UUID,
            'assunto_ids' => [1, 1],
            'domicilio_codigo' => '16',
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false));
    }

    public function test_outros_sem_complemento_e_rejeitado(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldReceive('buscarAssuntosAtivosPorIds')
            ->once()
            ->with([16])
            ->andReturn([['id' => 16, 'codigo' => 'OUTROS', 'descricao' => 'Outros']]);
        $catalogo->shouldReceive('buscarDomicilio')
            ->once()
            ->with('16')
            ->andReturn(['codigo' => '16', 'descricao' => 'RIO BRANCO']);

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('loteJaRegistrado')->once()->with(self::LOTE_UUID)->andReturnFalse();
        $repository->shouldNotReceive('criarLote');

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('complemento');

        $service->registrar([
            'lote_uuid' => self::LOTE_UUID,
            'assunto_ids' => [16],
            'domicilio_codigo' => '16',
            'outros_complemento' => '   ',
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false));
    }

    public function test_lote_repetido_e_rejeitado_antes_de_consultar_catalogos(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldNotReceive('buscarAssuntosAtivosPorIds');
        $catalogo->shouldNotReceive('buscarDomicilio');

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('loteJaRegistrado')->once()->with(self::LOTE_UUID)->andReturnTrue();
        $repository->shouldNotReceive('criarLote');

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('já foi registrado');

        (new DisqueEleicaoAtendimentoService($catalogo, $repository))->registrar([
            'lote_uuid' => self::LOTE_UUID,
            'assunto_ids' => [1],
            'domicilio_codigo' => '16',
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false));
    }

    public function test_assunto_inativo_e_rejeitado_sem_persistencia(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldReceive('buscarAssuntosAtivosPorIds')->once()->with([99])->andReturn([]);
        $catalogo->shouldNotReceive('buscarDomicilio');

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('loteJaRegistrado')->once()->with(self::LOTE_UUID)->andReturnFalse();
        $repository->shouldNotReceive('criarLote');

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('inativos');

        (new DisqueEleicaoAtendimentoService($catalogo, $repository))->registrar([
            'lote_uuid' => self::LOTE_UUID,
            'assunto_ids' => [99],
            'domicilio_codigo' => '16',
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false));
    }

    public function test_domicilio_invalido_e_rejeitado_sem_persistencia(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldReceive('buscarAssuntosAtivosPorIds')->once()->with([1])->andReturn([
            ['id' => 1, 'codigo' => 'LOCAL_VOTACAO', 'descricao' => 'Local de votação'],
        ]);
        $catalogo->shouldReceive('buscarDomicilio')->once()->with('999')->andReturnNull();

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('loteJaRegistrado')->once()->with(self::LOTE_UUID)->andReturnFalse();
        $repository->shouldNotReceive('criarLote');

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('Domicílio eleitoral inválido');

        (new DisqueEleicaoAtendimentoService($catalogo, $repository))->registrar([
            'lote_uuid' => self::LOTE_UUID,
            'assunto_ids' => [1],
            'domicilio_codigo' => '999',
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false));
    }

    public function test_atendente_nao_exclui_registro_de_outro_usuario(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoContexto')->once()->with(90, 7, '1')->andReturn([
            'id' => 90,
            'usuario_login' => 'bruno',
        ]);
        $repository->shouldNotReceive('removerNoContexto');

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('não pode alterar');

        $service->excluir(
            90,
            new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false),
        );
    }

    public function test_gestor_exclui_registro_de_outro_usuario_no_mesmo_contexto(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoContexto')->once()->with(90, 7, '1')->andReturn([
            'id' => 90,
            'usuario_login' => 'bruno',
        ]);
        $repository->shouldReceive('removerNoContexto')->once()->with(90, 7, '1')->andReturn(1);

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);

        $this->assertSame(1, $service->excluir(
            90,
            new DisqueEleicaoContexto(7, '1', 'ana', 'Ana Gestora', true),
        ));
    }

    public function test_id_de_outro_contexto_nao_pode_ser_excluido(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoContexto')->once()->with(90, 7, '2')->andReturnNull();
        $repository->shouldNotReceive('removerNoContexto');

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('não encontrado no contexto ativo');

        (new DisqueEleicaoAtendimentoService($catalogo, $repository))->excluir(
            90,
            new DisqueEleicaoContexto(7, '2', 'gestora', 'Gestora', true),
        );
    }

    public function test_atendente_atualiza_apenas_campos_editaveis_do_registro_proprio(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldReceive('buscarAssuntosAtivosPorIds')->once()->with([2])->andReturn([
            ['id' => 2, 'codigo' => 'HORARIO_VOTACAO', 'descricao' => 'Horário de votação'],
        ]);
        $catalogo->shouldReceive('buscarDomicilio')->once()->with('16')->andReturn([
            'codigo' => '16',
            'descricao' => 'RIO BRANCO',
        ]);

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoContexto')->once()->with(90, 7, '1')->andReturn([
            'id' => 90,
            'usuario_login' => 'ana',
            'lote_uuid' => self::LOTE_UUID,
        ]);
        $repository->shouldReceive('assuntoJaExisteNoLote')
            ->once()->with(self::LOTE_UUID, 2, 90)->andReturnFalse();
        $repository->shouldReceive('atualizarNoContexto')
            ->once()
            ->with(90, [
                'assunto_id' => 2,
                'domicilio_codigo' => '16',
                'domicilio_descricao' => 'RIO BRANCO',
                'outros_complemento' => null,
                'usuario_atualizacao' => 'ana',
            ], 7, '1')
            ->andReturn(1);

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);
        $this->assertSame(1, $service->atualizar(90, [
            'assunto_id' => 2,
            'domicilio_codigo' => '16',
            'outros_complemento' => 'ignorado',
            'usuario_login' => 'forjado',
            'macroprojeto_id' => 999,
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false)));
    }

    public function test_edicao_preserva_assunto_atual_inativado_sem_permitir_novo_vinculo(): void
    {
        $catalogo = Mockery::mock(DisqueEleicaoCatalogoRepositoryInterface::class);
        $catalogo->shouldReceive('buscarAssuntosAtivosPorIds')->once()->with([99])->andReturn([]);
        $catalogo->shouldReceive('buscarDomicilio')->once()->with('16')->andReturn([
            'codigo' => '16',
            'descricao' => 'RIO BRANCO',
        ]);

        $repository = Mockery::mock(DisqueEleicaoAtendimentoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoContexto')->once()->with(90, 7, '1')->andReturn([
            'id' => 90,
            'assunto_id' => 99,
            'assunto_codigo' => 'ASSUNTO_INATIVO',
            'assunto_descricao' => 'Assunto inativo',
            'usuario_login' => 'ana',
            'lote_uuid' => self::LOTE_UUID,
        ]);
        $repository->shouldReceive('assuntoJaExisteNoLote')
            ->once()->with(self::LOTE_UUID, 99, 90)->andReturnFalse();
        $repository->shouldReceive('atualizarNoContexto')
            ->once()
            ->with(90, [
                'assunto_id' => 99,
                'domicilio_codigo' => '16',
                'domicilio_descricao' => 'RIO BRANCO',
                'outros_complemento' => null,
                'usuario_atualizacao' => 'ana',
            ], 7, '1')
            ->andReturn(1);

        $service = new DisqueEleicaoAtendimentoService($catalogo, $repository);

        $this->assertSame(1, $service->atualizar(90, [
            'assunto_id' => 99,
            'domicilio_codigo' => '16',
        ], new DisqueEleicaoContexto(7, '1', 'ana', 'Ana', false)));
    }

    private const LOTE_UUID = '550e8400-e29b-41d4-a716-446655440000';
}
```
</TESTS_UNIT_DISQUEELEICAOATENDIMENTOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoCatalogoRepositoryTest.php`
## <TESTS_UNIT_DISQUEELEICAOCATALOGOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoCatalogoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoCatalogoRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('municipio', function (Blueprint $table): void {
Schema::create('disque_eleicao_domicilio_extra', function (Blueprint $table): void {
DB::table('municipio')->insert([
DB::table('municipio')->insert([
DB::table('disque_eleicao_domicilio_extra')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function test_catalogo_agrupa_as_duas_zonas_de_rio_branco_em_um_domicilio(): void
public function test_catalogo_acrescenta_as_opcoes_especiais_ativas_ao_final(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\DisqueEleicao\DisqueEleicaoCatalogoRepository;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class DisqueEleicaoCatalogoRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        Schema::create('municipio', function (Blueprint $table): void {
            $table->id();
            $table->string('cod_objeto_localidade', 30);
            $table->string('localidade', 160);
        });
        Schema::create('disque_eleicao_domicilio_extra', function (Blueprint $table): void {
            $table->id();
            $table->string('codigo', 30);
            $table->string('descricao', 160);
            $table->unsignedInteger('ordem');
            $table->boolean('ativo');
        });

        foreach (range(1, 22) as $codigo) {
            DB::table('municipio')->insert([
                'cod_objeto_localidade' => (string) $codigo,
                'localidade' => $codigo === 16 ? 'RIO BRANCO' : 'MUNICÍPIO '.$codigo,
            ]);
        }
        DB::table('municipio')->insert([
            'cod_objeto_localidade' => '16',
            'localidade' => 'RIO BRANCO',
        ]);
        DB::table('disque_eleicao_domicilio_extra')->insert([
            [
                'codigo' => 'ESPECIAL_NAO_IDENTIFICADO',
                'descricao' => 'Não identificado',
                'ordem' => 1,
                'ativo' => 1,
            ],
            [
                'codigo' => 'ESPECIAL_OUTRO_ESTADO',
                'descricao' => 'Outro Estado',
                'ordem' => 2,
                'ativo' => 1,
            ],
            [
                'codigo' => 'ESPECIAL_INATIVO',
                'descricao' => 'Opção inativa',
                'ordem' => 3,
                'ativo' => 0,
            ],
        ]);
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('disque_eleicao_domicilio_extra');
        Schema::dropIfExists('municipio');
        parent::tearDown();
    }

    public function test_catalogo_agrupa_as_duas_zonas_de_rio_branco_em_um_domicilio(): void
    {
        $domicilios = (new DisqueEleicaoCatalogoRepository)->listarDomicilios();

        $this->assertCount(24, $domicilios);
        $this->assertCount(1, array_filter(
            $domicilios,
            static fn (array $item): bool => $item['descricao'] === 'RIO BRANCO',
        ));
    }

    public function test_catalogo_acrescenta_as_opcoes_especiais_ativas_ao_final(): void
    {
        $repository = new DisqueEleicaoCatalogoRepository;
        $domicilios = $repository->listarDomicilios();

        $this->assertSame([
            ['codigo' => 'ESPECIAL_NAO_IDENTIFICADO', 'descricao' => 'Não identificado'],
            ['codigo' => 'ESPECIAL_OUTRO_ESTADO', 'descricao' => 'Outro Estado'],
        ], array_slice($domicilios, -2));
        $this->assertSame(
            ['codigo' => 'ESPECIAL_NAO_IDENTIFICADO', 'descricao' => 'Não identificado'],
            $repository->buscarDomicilio(' ESPECIAL_NAO_IDENTIFICADO '),
        );
        $this->assertSame(
            ['codigo' => 'ESPECIAL_OUTRO_ESTADO', 'descricao' => 'Outro Estado'],
            $repository->buscarDomicilio('ESPECIAL_OUTRO_ESTADO'),
        );
        $this->assertNull($repository->buscarDomicilio('ESPECIAL_INATIVO'));
    }
}
```
</TESTS_UNIT_DISQUEELEICAOCATALOGOREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoContextoSessaoTest.php`
## <TESTS_UNIT_DISQUEELEICAOCONTEXTOSESSAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoContextoSessaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoContextoSessaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_resolve_identidade_macroprojeto_turno_e_perfil_gestor_da_sessao(): void
public function test_resolve_planeleito_admin_como_gestor_operacional(): void
public function test_rejeita_usuario_sem_perfil_global_ou_operacional(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\DisqueEleicao\DisqueEleicaoContextoSessao;
use App\Services\DisqueEleicao\DisqueEleicaoPermissaoService;
use Illuminate\Auth\Access\AuthorizationException;
use Tests\TestCase;

class DisqueEleicaoContextoSessaoTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        parent::tearDown();
    }

    public function test_resolve_identidade_macroprojeto_turno_e_perfil_gestor_da_sessao(): void
    {
        session([
            'macroprojeto_ativo_id' => 7,
            'macroprojeto_ativo_turno' => '2',
            'user' => ['username' => 'gestora', 'name' => 'Gestora Eleitoral'],
            'matchingGroups' => [DisqueEleicaoPermissaoService::GRUPO_GESTOR],
        ]);

        $contexto = (new DisqueEleicaoContextoSessao(new DisqueEleicaoPermissaoService))->atual();

        $this->assertSame(7, $contexto->macroprojetoId);
        $this->assertSame('2', $contexto->turno);
        $this->assertSame('gestora', $contexto->usuarioLogin);
        $this->assertSame('Gestora Eleitoral', $contexto->usuarioNome);
        $this->assertTrue($contexto->gestor);
    }

    public function test_resolve_planeleito_admin_como_gestor_operacional(): void
    {
        session([
            'macroprojeto_ativo_id' => 7,
            'macroprojeto_ativo_turno' => '1',
            'user' => ['username' => 'admin', 'name' => 'Admin'],
            'matchingGroups' => ['PLANELEITO_ADMIN'],
        ]);

        $contexto = (new DisqueEleicaoContextoSessao(new DisqueEleicaoPermissaoService))->atual();

        $this->assertSame('admin', $contexto->usuarioLogin);
        $this->assertTrue($contexto->gestor);
    }

    public function test_rejeita_usuario_sem_perfil_global_ou_operacional(): void
    {
        session([
            'macroprojeto_ativo_id' => 7,
            'macroprojeto_ativo_turno' => '1',
            'user' => ['username' => 'externo', 'name' => 'Externo'],
            'matchingGroups' => ['PLANELEITO_OUTRO_MODULO'],
        ]);

        $this->expectException(AuthorizationException::class);
        $this->expectExceptionMessage('sem perfil operacional');

        (new DisqueEleicaoContextoSessao(new DisqueEleicaoPermissaoService))->atual();
    }
}
```
</TESTS_UNIT_DISQUEELEICAOCONTEXTOSESSAOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoRelatorioExportTest.php`
## <TESTS_UNIT_DISQUEELEICAORELATORIOEXPORTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoRelatorioExportTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioExportTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_exportacao_cria_seis_planilhas_e_neutraliza_texto_perigoso(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Exports\DisqueEleicao\DisqueEleicaoRelatorioExport;
use App\Exports\DisqueEleicao\DisqueEleicaoSheet;
use PHPUnit\Framework\TestCase;

class DisqueEleicaoRelatorioExportTest extends TestCase
{
    public function test_exportacao_cria_seis_planilhas_e_neutraliza_texto_perigoso(): void
    {
        $exportacao = new DisqueEleicaoRelatorioExport([
            'total' => 1,
            'assuntos' => [[
                'codigo' => 'OUTROS',
                'descricao' => '=HIPERLINK("https://exemplo.invalid")',
                'quantidade' => 1,
                'percentual' => 100.0,
            ]],
            'domicilios' => [],
            'atendentes' => [],
            'periodos' => [],
        ], [[
            'data_atendimento' => '28/07/2026 10:00',
            'assunto' => 'Outros',
            'outros_complemento' => '+COMANDO()',
            'domicilio' => 'Rio Branco',
            'usuario_nome' => 'Atendente',
            'usuario_login' => 'atendente',
            'lote_uuid' => '550e8400-e29b-41d4-a716-446655440000',
        ]]);

        $planilhas = $exportacao->sheets();

        $this->assertCount(6, $planilhas);
        $this->assertSame(
            ['Resumo', 'Assuntos', 'Domicílios', 'Atendentes', 'Períodos', 'Registros'],
            array_map(static fn (DisqueEleicaoSheet $planilha): string => $planilha->title(), $planilhas),
        );
        $this->assertSame("'=HIPERLINK(\"https://exemplo.invalid\")", $planilhas[1]->array()[1][1]);
        $this->assertSame("'+COMANDO()", $planilhas[5]->array()[1][2]);
    }
}
```
</TESTS_UNIT_DISQUEELEICAORELATORIOEXPORTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoRelatorioPdfViewTest.php`
## <TESTS_UNIT_DISQUEELEICAORELATORIOPDFVIEWTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoRelatorioPdfViewTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioPdfViewTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_pdf_renderiza_todos_os_consolidados_gerenciais(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class DisqueEleicaoRelatorioPdfViewTest extends TestCase
{
    public function test_pdf_renderiza_todos_os_consolidados_gerenciais(): void
    {
        $html = view('disque-eleicao.relatorios.pdf', [
            'consolidado' => [
                'total' => 3,
                'assuntos' => [[
                    'descricao' => 'Local de votação',
                    'quantidade' => 2,
                    'percentual' => 66.67,
                ]],
                'domicilios' => [[
                    'descricao' => 'Rio Branco',
                    'quantidade' => 3,
                ]],
                'atendentes' => [[
                    'nome' => 'Ana Atendente',
                    'login' => 'ana',
                    'quantidade' => 3,
                ]],
                'periodos' => [[
                    'tipo' => 'DIA',
                    'periodo' => '2026-07-28',
                    'quantidade' => 3,
                ]],
            ],
            'registros' => [],
            'campos' => ['assunto'],
            'rotulos' => ['assunto' => 'Assunto'],
            'filtros' => [],
            'geradoEm' => '28/07/2026 10:00',
        ])->render();

        $this->assertStringContainsString('Por domicílio', $html);
        $this->assertStringContainsString('Rio Branco', $html);
        $this->assertStringContainsString('Por atendente', $html);
        $this->assertStringContainsString('Ana Atendente', $html);
        $this->assertStringContainsString('Por período', $html);
        $this->assertStringContainsString('2026-07-28', $html);
    }
}
```
</TESTS_UNIT_DISQUEELEICAORELATORIOPDFVIEWTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoRelatorioServiceTest.php`
## <TESTS_UNIT_DISQUEELEICAORELATORIOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoRelatorioServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoRelatorioServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_percentuais_usam_o_total_de_registros_individualizados(): void
public function test_arredondamento_preserva_soma_exata_de_cem_por_cento(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoRelatorioRepositoryInterface;
use App\Services\DisqueEleicao\DisqueEleicaoRelatorioService;
use Mockery;
use Tests\TestCase;

class DisqueEleicaoRelatorioServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_percentuais_usam_o_total_de_registros_individualizados(): void
    {
        $filtros = ['data_inicio' => '2026-10-01', 'data_fim' => '2026-10-05'];
        $repository = Mockery::mock(DisqueEleicaoRelatorioRepositoryInterface::class);
        $repository->shouldReceive('consolidar')
            ->once()
            ->with($filtros, 1, '1')
            ->andReturn([
                'total' => 4,
                'assuntos' => [
                    ['codigo' => 'LOCAL_VOTACAO', 'descricao' => 'Local de votação', 'quantidade' => 3],
                    ['codigo' => 'OUTROS', 'descricao' => 'Outros', 'quantidade' => 1],
                ],
                'domicilios' => [],
                'atendentes' => [],
                'periodos' => [],
            ]);

        $resultado = (new DisqueEleicaoRelatorioService($repository))->consolidar($filtros, 1, '1');

        $this->assertSame(75.0, $resultado['assuntos'][0]['percentual']);
        $this->assertSame(25.0, $resultado['assuntos'][1]['percentual']);
        $this->assertSame(100.0, array_sum(array_column($resultado['assuntos'], 'percentual')));
    }

    public function test_arredondamento_preserva_soma_exata_de_cem_por_cento(): void
    {
        $repository = Mockery::mock(DisqueEleicaoRelatorioRepositoryInterface::class);
        $repository->shouldReceive('consolidar')->once()->andReturn([
            'total' => 3,
            'assuntos' => [
                ['codigo' => 'A', 'descricao' => 'A', 'quantidade' => 1],
                ['codigo' => 'B', 'descricao' => 'B', 'quantidade' => 1],
                ['codigo' => 'C', 'descricao' => 'C', 'quantidade' => 1],
            ],
        ]);

        $resultado = (new DisqueEleicaoRelatorioService($repository))->consolidar([], 1, '1');

        $this->assertSame(100.0, array_sum(array_column($resultado['assuntos'], 'percentual')));
    }
}
```
</TESTS_UNIT_DISQUEELEICAORELATORIOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DisqueEleicaoRequestsTest.php`
## <TESTS_UNIT_DISQUEELEICAOREQUESTSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DisqueEleicaoRequestsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DisqueEleicaoRequestsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_formularios_operacionais_autorizam_planeleito_admin(): void
public function test_registro_rejeita_assunto_duplicado(): void
public function test_registro_nao_limita_quantidade_de_assuntos_do_catalogo_administravel(): void
public function test_relatorio_rejeita_periodo_invertido(): void
public function test_codigo_oficial_longo_do_assunto_e_aceito(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\DisqueEleicao\DisqueEleicaoAssuntoRequest;
use App\Http\Requests\DisqueEleicao\DisqueEleicaoRelatorioRequest;
use App\Http\Requests\DisqueEleicao\StoreDisqueEleicaoAtendimentoRequest;
use App\Http\Requests\DisqueEleicao\UpdateDisqueEleicaoAtendimentoRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Unique;
use Tests\TestCase;

class DisqueEleicaoRequestsTest extends TestCase
{
    public function test_formularios_operacionais_autorizam_planeleito_admin(): void
    {
        session(['matchingGroups' => ['PLANELEITO_ADMIN']]);

        $this->assertTrue(StoreDisqueEleicaoAtendimentoRequest::create('/disque-eleicao', 'POST')->authorize());
        $this->assertTrue(UpdateDisqueEleicaoAtendimentoRequest::create('/disque-eleicao/1', 'PUT')->authorize());
        $this->assertTrue(DisqueEleicaoRelatorioRequest::create('/disque-eleicao/relatorios', 'GET')->authorize());
    }

    public function test_registro_rejeita_assunto_duplicado(): void
    {
        $request = StoreDisqueEleicaoAtendimentoRequest::create('/disque-eleicao', 'POST', [
            'lote_uuid' => '550e8400-e29b-41d4-a716-446655440000',
            'assunto_ids' => [1, 1],
            'domicilio_codigo' => '16',
        ]);

        $validator = Validator::make($request->all(), $request->rules());

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('assunto_ids.0') || $validator->errors()->has('assunto_ids.1'));
    }

    public function test_registro_nao_limita_quantidade_de_assuntos_do_catalogo_administravel(): void
    {
        $request = StoreDisqueEleicaoAtendimentoRequest::create('/disque-eleicao', 'POST', [
            'lote_uuid' => '550e8400-e29b-41d4-a716-446655440000',
            'assunto_ids' => range(1, 17),
            'domicilio_codigo' => '16',
        ]);

        $validator = Validator::make($request->all(), $request->rules());

        $this->assertFalse($validator->errors()->has('assunto_ids'));
    }

    public function test_relatorio_rejeita_periodo_invertido(): void
    {
        $request = DisqueEleicaoRelatorioRequest::create('/disque-eleicao/relatorios', 'GET', [
            'data_inicio' => '2026-10-10',
            'data_fim' => '2026-10-01',
        ]);

        $validator = Validator::make($request->all(), $request->rules());

        $this->assertTrue($validator->fails());
        $this->assertTrue($validator->errors()->has('data_fim'));
    }

    public function test_codigo_oficial_longo_do_assunto_e_aceito(): void
    {
        $request = DisqueEleicaoAssuntoRequest::create('/tabelas-auxiliares/disque-eleicao-assuntos', 'POST');
        $regras = array_values(array_filter(
            $request->rules()['codigo'],
            static fn (mixed $regra): bool => ! $regra instanceof Unique,
        ));

        $validator = Validator::make(['codigo' => 'NUMERO_INSCRICAO_ELEITORAL'], ['codigo' => $regras]);

        $this->assertFalse($validator->fails());
    }
}
```
</TESTS_UNIT_DISQUEELEICAOREQUESTSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaSolicitacaoPrazoLoteControllerTest.php`
## <TESTS_UNIT_TAREFASOLICITACAOPRAZOLOTECONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaSolicitacaoPrazoLoteControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoLoteControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_formulario_de_lote_exige_permissao_admin_de_decisao(): void
public function test_salvamento_em_lote_pode_resolver_todas_as_atividades_da_consulta_filtrada(): void
public function test_salvamento_em_lote_cria_solicitacoes_validas_e_resume_falhas_individuais(): void
public function test_formulario_de_lote_indica_quando_alteracao_de_unidade_deve_ser_bloqueada_por_heterogeneidade(): void
public function test_salvamento_em_lote_bloqueia_alteracao_de_unidade_quando_ha_heterogeneidade_de_unidade_origem(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\Tarefas\TarefaController;
use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoLoteRequest;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Services\EscopoUnidadeService;
use App\Services\PermissaoDominioService;
use App\Services\Planejamento\PlanejamentoPermissoes;
use Illuminate\Http\Request;
use Mockery;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

class TarefaSolicitacaoPrazoLoteControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_formulario_de_lote_exige_permissao_admin_de_decisao(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'rotas_permitidas' => ['tarefas.index'],
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(1, ['PLANELEITO_ADMIN'])
            ->andReturn(true);
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $controller = new TarefaController(
            Mockery::mock(TarefaRepositoryInterface::class),
            Mockery::mock(PlanejamentoPermissoes::class),
            Mockery::mock(EscopoUnidadeService::class)
        );

        $request = Request::create('/tarefas/solicitacoes-prazo/lote', 'GET', [
            'TAREFA_IDS' => [10, 20],
        ]);

        try {
            $controller->solicitacoesPrazoLote($request);
            $this->fail('Era esperada uma exceção 403.');
        } catch (HttpException $e) {
            $this->assertSame(403, $e->getStatusCode());
        }
    }


    public function test_salvamento_em_lote_pode_resolver_todas_as_atividades_da_consulta_filtrada(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'rotas_permitidas' => ['tarefas.solicitacoes.prazo.aprovar'],
            'user' => 'admin.teste',
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(1, ['PLANELEITO_ADMIN'])
            ->andReturn(true);
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $request = Mockery::mock(TarefaSolicitacaoPrazoLoteRequest::class);
        $request->shouldReceive('validated')
            ->once()
            ->andReturn([
                'SELECIONAR_CONSULTA_COMPLETA' => '1',
                'status' => ['EM ANDAMENTO'],
                'TIPO_SOLICITACAO' => 'ALTERACAO',
                'DESCRICAO_NOVA' => 'Descricao ajustada em lote.',
                'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
                'back' => route('tarefas.index'),
            ]);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('listarIdsTarefas')
            ->once()
            ->with([
                'projetos' => [],
                'subprojetos' => [],
                'statuses' => ['EM ANDAMENTO'],
                'unidades' => [],
                'categorias' => [],
                'fases' => [],
                'busca_texto' => '',
                'ordenar_prev_inicio' => false,
            ], null, 1)
            ->andReturn([31, 32]);
        $repository->shouldReceive('listarUnidades')->once()->andReturn([]);
        $repository->shouldReceive('buscarTarefaFormulario')->once()->with(31, 1)->andReturn((object) [
            'id' => 31,
            'nome' => 'Atividade A',
            'descricao' => 'Descricao A',
            'data_prevista_inicio' => '2026-05-10',
            'data_prevista_fim' => '2026-05-20',
            'unidade_id' => 1,
        ]);
        $repository->shouldReceive('buscarTarefaFormulario')->once()->with(32, 1)->andReturn((object) [
            'id' => 32,
            'nome' => 'Atividade B',
            'descricao' => 'Descricao B',
            'data_prevista_inicio' => '2026-05-10',
            'data_prevista_fim' => '2026-05-20',
            'unidade_id' => 1,
        ]);
        $repository->shouldReceive('inserirSolicitacaoAlteracaoPrazo')->twice();

        $escopo = Mockery::mock(EscopoUnidadeService::class);
        $escopo->shouldReceive('unidadesParaConsultaAtual')->once()->andReturn(null);

        $controller = new TarefaController(
            $repository,
            Mockery::mock(PlanejamentoPermissoes::class),
            $escopo
        );

        $response = $controller->salvarSolicitacaoPrazoLote($request);

        $this->assertSame('2 solicitações enviadas para aprovação.', session('sucesso'));
        $this->assertStringContainsString('SELECIONAR_CONSULTA_COMPLETA=1', $response->getTargetUrl());
    }

    public function test_salvamento_em_lote_cria_solicitacoes_validas_e_resume_falhas_individuais(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'rotas_permitidas' => ['tarefas.solicitacoes.prazo.aprovar'],
            'user' => 'admin.teste',
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(1, ['PLANELEITO_ADMIN'])
            ->andReturn(true);
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $request = Mockery::mock(TarefaSolicitacaoPrazoLoteRequest::class);
        $request->shouldReceive('validated')
            ->once()
            ->andReturn([
                'TAREFA_IDS' => [10, 20],
                'TIPO_SOLICITACAO' => 'ALTERACAO',
                'NOME_NOVO' => 'Novo nome em lote',
                'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
                'back' => route('tarefas.index'),
            ]);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('buscarTarefaFormulario')
            ->once()
            ->with(10, 1)
            ->andReturn((object) [
                'id' => 10,
                'nome' => 'Atividade antiga',
                'descricao' => 'Descricao antiga',
                'data_prevista_inicio' => '2026-05-10',
                'data_prevista_fim' => '2026-05-20',
                'unidade_id' => 1,
            ]);
        $repository->shouldReceive('buscarTarefaFormulario')
            ->once()
            ->with(20, 1)
            ->andReturn((object) [
                'id' => 20,
                'nome' => 'Novo nome em lote',
                'descricao' => 'Descricao antiga',
                'data_prevista_inicio' => '2026-05-10',
                'data_prevista_fim' => '2026-05-20',
                'unidade_id' => 1,
            ]);
        $repository->shouldReceive('listarUnidades')
            ->once()
            ->andReturn([]);
        $repository->shouldReceive('inserirSolicitacaoAlteracaoPrazo')
            ->once()
            ->with(
                10,
                'ALTERACAO',
                null,
                null,
                null,
                'Novo nome em lote',
                null,
                'Justificativa detalhada para o pedido em lote.',
                'admin.teste'
            );

        $controller = new TarefaController(
            $repository,
            Mockery::mock(PlanejamentoPermissoes::class),
            Mockery::mock(EscopoUnidadeService::class)
        );

        $response = $controller->salvarSolicitacaoPrazoLote($request);

        $this->assertSame(route('tarefas.solicitacoes.prazo.lote', [
            'TAREFA_IDS' => [10, 20],
            'back' => route('tarefas.index'),
        ]), $response->getTargetUrl());
        $this->assertSame('1 solicitação enviada para aprovação.', session('sucesso'));
        $this->assertSame([
            'Atividade #20: O novo nome da atividade deve ser diferente do nome atual.',
        ], session('falhas_lote_solicitacao_prazo'));
    }

    public function test_formulario_de_lote_indica_quando_alteracao_de_unidade_deve_ser_bloqueada_por_heterogeneidade(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'rotas_permitidas' => ['tarefas.solicitacoes.prazo.aprovar'],
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(1, ['PLANELEITO_ADMIN'])
            ->andReturn(true);
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('buscarTarefaFormulario')->once()->with(10, 1)->andReturn((object) [
            'id' => 10,
            'nome' => 'Atividade A',
            'unidade_id' => 1,
            'unidade_sigla' => 'UNI-A',
        ]);
        $repository->shouldReceive('buscarTarefaFormulario')->once()->with(20, 1)->andReturn((object) [
            'id' => 20,
            'nome' => 'Atividade B',
            'unidade_id' => 2,
            'unidade_sigla' => 'UNI-B',
        ]);
        $repository->shouldReceive('listarUnidades')->once()->andReturn([]);

        $controller = new TarefaController(
            $repository,
            Mockery::mock(PlanejamentoPermissoes::class),
            Mockery::mock(EscopoUnidadeService::class)
        );

        $response = $controller->solicitacoesPrazoLote(Request::create('/tarefas/solicitacoes-prazo/lote', 'GET', [
            'TAREFA_IDS' => [10, 20],
            'back' => route('tarefas.index'),
        ]));

        $this->assertFalse($response->getData()['permiteAlteracaoUnidadeLote']);
    }

    public function test_salvamento_em_lote_bloqueia_alteracao_de_unidade_quando_ha_heterogeneidade_de_unidade_origem(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'rotas_permitidas' => ['tarefas.solicitacoes.prazo.aprovar'],
            'user' => 'admin.teste',
        ]);

        $permissao = Mockery::mock(PermissaoDominioService::class);
        $permissao->shouldReceive('podeOperarMacro')
            ->once()
            ->with(1, ['PLANELEITO_ADMIN'])
            ->andReturn(true);
        $this->app->instance(PermissaoDominioService::class, $permissao);

        $request = Mockery::mock(TarefaSolicitacaoPrazoLoteRequest::class);
        $request->shouldReceive('validated')
            ->once()
            ->andReturn([
                'TAREFA_IDS' => [10, 20],
                'TIPO_SOLICITACAO' => 'ALTERACAO',
                'UNIDADE_ID_NOVA' => 3,
                'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
                'back' => route('tarefas.index'),
            ]);

        $repository = Mockery::mock(TarefaRepositoryInterface::class);
        $repository->shouldReceive('listarUnidades')->once()->andReturn([
            (object) ['id' => 3, 'nome' => 'Nova unidade'],
        ]);
        $repository->shouldReceive('buscarTarefaFormulario')->once()->with(10, 1)->andReturn((object) [
            'id' => 10,
            'nome' => 'Atividade A',
            'descricao' => 'Descricao A',
            'data_prevista_inicio' => '2026-05-10',
            'data_prevista_fim' => '2026-05-20',
            'unidade_id' => 1,
        ]);
        $repository->shouldReceive('buscarTarefaFormulario')->once()->with(20, 1)->andReturn((object) [
            'id' => 20,
            'nome' => 'Atividade B',
            'descricao' => 'Descricao B',
            'data_prevista_inicio' => '2026-05-10',
            'data_prevista_fim' => '2026-05-20',
            'unidade_id' => 2,
        ]);
        $repository->shouldNotReceive('inserirSolicitacaoAlteracaoPrazo');

        $controller = new TarefaController(
            $repository,
            Mockery::mock(PlanejamentoPermissoes::class),
            Mockery::mock(EscopoUnidadeService::class)
        );

        $response = $controller->salvarSolicitacaoPrazoLote($request);

        $this->assertSame(route('tarefas.solicitacoes.prazo.lote', [
            'TAREFA_IDS' => [10, 20],
            'back' => route('tarefas.index'),
        ]), $response->getTargetUrl());
        $this->assertSame('A alteração de unidade em lote só é permitida quando todas as atividades selecionadas pertencem à mesma unidade atual.', session('erro'));
    }
}
```
</TESTS_UNIT_TAREFASOLICITACAOPRAZOLOTECONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaSolicitacaoPrazoLoteRequestTest.php`
## <TESTS_UNIT_TAREFASOLICITACAOPRAZOLOTEREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaSolicitacaoPrazoLoteRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoLoteRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function request_de_lote_aceita_alteracao_com_ids_e_uma_mudanca_real(): void
public function request_de_lote_aceita_modo_de_consulta_completa_sem_ids_explicitos(): void
public function request_de_lote_exige_ao_menos_uma_alteracao_quando_tipo_e_alteracao(): void
public function request_de_lote_impede_preenchimento_de_campos_de_alteracao_quando_tipo_e_exclusao(): void
private function makeValidator(array $dados): \Illuminate\Validation\Validator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\Tarefas\TarefaSolicitacaoPrazoLoteRequest;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class TarefaSolicitacaoPrazoLoteRequestTest extends TestCase
{
    #[Test]
    public function request_de_lote_aceita_alteracao_com_ids_e_uma_mudanca_real(): void
    {
        $validator = $this->makeValidator([
            'TAREFA_IDS' => ['10', '20'],
            'TIPO_SOLICITACAO' => 'alteracao',
            'NOME_NOVO' => '  Novo nome em lote  ',
            'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
    }


    #[Test]
    public function request_de_lote_aceita_modo_de_consulta_completa_sem_ids_explicitos(): void
    {
        $validator = $this->makeValidator([
            'SELECIONAR_CONSULTA_COMPLETA' => '1',
            'status' => ['EM ANDAMENTO'],
            'TIPO_SOLICITACAO' => 'ALTERACAO',
            'DESCRICAO_NOVA' => 'Descricao ajustada em lote.',
            'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
    }

    #[Test]
    public function request_de_lote_exige_ao_menos_uma_alteracao_quando_tipo_e_alteracao(): void
    {
        $validator = $this->makeValidator([
            'TAREFA_IDS' => [10, 20],
            'TIPO_SOLICITACAO' => 'ALTERACAO',
            'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
        ]);

        $this->assertTrue($validator->fails());
        $this->assertSame(
            'Informe ao menos uma alteração (datas, unidade, nome ou descrição da atividade).',
            $validator->errors()->first('DATA_PREVISTA_INICIO_NOVA')
        );
    }

    #[Test]
    public function request_de_lote_impede_preenchimento_de_campos_de_alteracao_quando_tipo_e_exclusao(): void
    {
        $validator = $this->makeValidator([
            'TAREFA_IDS' => [10, 20],
            'TIPO_SOLICITACAO' => 'EXCLUSAO',
            'NOME_NOVO' => 'Novo nome em lote',
            'JUSTIFICATIVA' => 'Justificativa detalhada para o pedido em lote.',
        ]);

        $this->assertTrue($validator->fails());
        $this->assertSame(
            'Para solicitação de exclusão, preencha apenas a justificativa.',
            $validator->errors()->first('TIPO_SOLICITACAO')
        );
    }

    /**
     * @param array<string, mixed> $dados
     */
    private function makeValidator(array $dados): \Illuminate\Validation\Validator
    {
        $request = TarefaSolicitacaoPrazoLoteRequest::create('/tarefas/solicitacoes-prazo/lote', 'POST', $dados);

        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->setAccessible(true);
        $prepare->invoke($request);

        $validator = Validator::make($request->all(), $request->rules(), $request->messages());
        $request->withValidator($validator);

        return $validator;
    }
}
```
</TESTS_UNIT_TAREFASOLICITACAOPRAZOLOTEREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaSolicitacaoPrazoLoteUiTest.php`
## <TESTS_UNIT_TAREFASOLICITACAOPRAZOLOTEUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaSolicitacaoPrazoLoteUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaSolicitacaoPrazoLoteUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function lista_de_tarefas_expone_controles_de_selecao_e_acao_em_lote_para_solicitacoes(): void
public function formulario_de_solicitacao_em_lote_reaproveita_todos_os_campos_do_fluxo_individual(): void
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

class TarefaSolicitacaoPrazoLoteUiTest extends TestCase
{
    #[Test]
    public function lista_de_tarefas_expone_controles_de_selecao_e_acao_em_lote_para_solicitacoes(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/lista.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("name=\"TAREFA_IDS[]\"", $conteudo);
        $this->assertStringContainsString("route('tarefas.solicitacoes.prazo.lote')", $conteudo);
        $this->assertStringContainsString('Solicitar alteração em lote', $conteudo);
        $this->assertStringContainsString('SELECIONAR_CONSULTA_COMPLETA', $conteudo);
        $this->assertStringNotContainsString('js-selecionar-todas-tarefas-lote', $conteudo);
        $this->assertStringContainsString('js-selecionar-consulta-completa-lote', $conteudo);
        $this->assertStringContainsString('toda a consulta filtrada', $conteudo);
        $this->assertStringContainsString('aria-label="Selecionar toda a consulta filtrada"', $conteudo);
    }

    #[Test]
    public function formulario_de_solicitacao_em_lote_reaproveita_todos_os_campos_do_fluxo_individual(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/solicitacoes_prazo_lote.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('Solicitações de Alteração em Lote', $conteudo);
        $this->assertStringContainsString('name="TIPO_SOLICITACAO"', $conteudo);
        $this->assertStringContainsString('name="DATA_PREVISTA_INICIO_NOVA"', $conteudo);
        $this->assertStringContainsString('name="DATA_PREVISTA_FIM_NOVA"', $conteudo);
        $this->assertStringContainsString('name="UNIDADE_ID_NOVA"', $conteudo);
        $this->assertStringContainsString('name="NOME_NOVO"', $conteudo);
        $this->assertStringContainsString('name="DESCRICAO_NOVA"', $conteudo);
        $this->assertStringContainsString('name="JUSTIFICATIVA"', $conteudo);
        $this->assertStringContainsString("route('tarefas.solicitacoes.prazo.lote.salvar')", $conteudo);
        $this->assertStringContainsString('$permiteAlteracaoUnidadeLote', $conteudo);
        $this->assertStringContainsString('{{ !$permiteAlteracaoUnidadeLote ? \'disabled\' : \'\' }}', $conteudo);
        $this->assertStringContainsString('A alteração de unidade em lote só fica disponível quando todas as atividades selecionadas pertencem à mesma unidade atual.', $conteudo);
    }
}
```
</TESTS_UNIT_TAREFASOLICITACAOPRAZOLOTEUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TelefoneBrasileiroTest.php`
## <TESTS_UNIT_TELEFONEBRASILEIROTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TelefoneBrasileiroTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TelefoneBrasileiroTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aceita_e_normaliza_telefones_brasileiros_digitados(string $entrada, string $esperado): void
public static function telefonesValidos(): array
public function rejeita_telefones_fora_da_matriz_brasileira(mixed $entrada): void
public static function telefonesInvalidos(): array
public function preparacao_preserva_formato_invalido_para_a_regra_rejeitar(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\Validation\TelefoneBrasileiro;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class TelefoneBrasileiroTest extends TestCase
{
    #[Test]
    #[DataProvider('telefonesValidos')]
    public function aceita_e_normaliza_telefones_brasileiros_digitados(string $entrada, string $esperado): void
    {
        $this->assertTrue(TelefoneBrasileiro::formatoPermitido($entrada));
        $this->assertTrue(TelefoneBrasileiro::valido($entrada));
        $this->assertSame($esperado, TelefoneBrasileiro::normalizar($entrada));
        $this->assertSame($esperado, TelefoneBrasileiro::prepararEntrada($entrada));
    }

    /** @return array<string, array{string, string}> */
    public static function telefonesValidos(): array
    {
        return [
            'celular' => ['68969998888', '68969998888'],
            'celular mascarado' => ['(68) 96999-8888', '68969998888'],
            'fixo' => ['6833334444', '6833334444'],
            'fixo mascarado' => ['(68) 3333-4444', '6833334444'],
        ];
    }

    #[Test]
    #[DataProvider('telefonesInvalidos')]
    public function rejeita_telefones_fora_da_matriz_brasileira(mixed $entrada): void
    {
        $this->assertFalse(TelefoneBrasileiro::valido($entrada));
    }

    /** @return array<string, array{mixed}> */
    public static function telefonesInvalidos(): array
    {
        return [
            'celular com prefixo invalido' => ['68959998888'],
            'fixo com inicial invalida' => ['6863334444'],
            'ddd zero' => ['0033334444'],
            'internacional' => ['+5568969998888'],
            'letras' => ['68abc969998888'],
            'vazio' => [''],
            'nulo' => [null],
        ];
    }

    #[Test]
    public function preparacao_preserva_formato_invalido_para_a_regra_rejeitar(): void
    {
        $this->assertSame('+5568969998888', TelefoneBrasileiro::prepararEntrada(' +5568969998888 '));
        $this->assertNull(TelefoneBrasileiro::normalizar('+5568969998888'));
    }
}
```
</TESTS_UNIT_TELEFONEBRASILEIROTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/VwConvocadosTelefoneMigrationTest.php`
## <TESTS_UNIT_VWCONVOCADOSTELEFONEMIGRATIONTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/VwConvocadosTelefoneMigrationTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VwConvocadosTelefoneMigrationTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migration_adiciona_telefone_na_vw_convocados(): void
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

class VwConvocadosTelefoneMigrationTest extends TestCase
{
    #[Test]
    public function migration_adiciona_telefone_na_vw_convocados(): void
    {
        $arquivo = database_path('migrations/2026_04_13_000200_add_telefone_to_vw_convocados.php');
        $conteudo = file_get_contents($arquivo);

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('CREATE OR REPLACE VIEW planeleito.vw_convocados AS', $conteudo);
        $this->assertStringContainsString('v.telefone', $conteudo);
        $this->assertStringContainsString('FROM ac_pessoa.vw_voluntario_perfil v', $conteudo);
        $this->assertStringContainsString('ev.localidade AS nom_localidade', $conteudo);
    }
}
```
</TESTS_UNIT_VWCONVOCADOSTELEFONEMIGRATIONTEST_PHP>

