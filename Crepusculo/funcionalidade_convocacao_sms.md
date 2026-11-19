# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_convocacao_sms`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 117  
> **Tamanho do Arquivo:** 751 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsController.php`
## <APP_HTTP_CONTROLLERS_CONVOCACAOSMS_CONVOCACAOSMSCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsController.php`
- **Namespace Declaração:** `App\Http\Controllers\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(ConvocacaoSmsFiltroRequest $request): View
public function enviar(ConvocacaoSmsEnvioRequest $request): RedirectResponse
public function atualizarTelefone(
public function pdf(ConvocacaoSmsFiltroRequest $request): Response
private function filtros(array $dados): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ConvocacaoSms;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsEnvioRequest;
use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsFiltroRequest;
use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsTelefoneManualRequest;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoSessao;
use App\Services\ConvocacaoSms\ConvocacaoSmsLoteService;
use App\Services\ConvocacaoSms\ConvocacaoSmsTelefoneManualService;
use App\Services\ConvocacaoSms\SmsDisponibilidade;
use App\Support\ColaboradoresEleitorais\MesarioFuncaoEleitoralCatalogo;
use App\Support\Exportacao\CamposPdfSelecionados;
use Barryvdh\DomPDF\Facade\Pdf;
use DomainException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\View\View;

final class ConvocacaoSmsController extends Controller
{
    private const CAMPOS_PDF = [
        'nome' => 'Nome', 'num_inscricao' => 'Inscrição', 'zona' => 'Zona',
        'municipio' => 'Município', 'telefone_nacional' => 'Celular',
        'telefone_diagnostico' => 'Diagnóstico do telefone',
        'resumo_convocacoes' => 'Nomeações e datas de convocação',
        'situacao_local' => 'Localização da nomeação',
        'confirmacao_elo_resumo' => 'Confirmação no ELO',
        'secoes' => 'Seções', 'funcoes' => 'Funções', 'situacao_comunicacao' => 'Comunicação',
    ];

    private const CAMPOS_PDF_PADRAO = [
        'nome', 'zona', 'municipio', 'telefone_nacional', 'telefone_diagnostico',
        'resumo_convocacoes', 'situacao_local', 'confirmacao_elo_resumo', 'situacao_comunicacao',
    ];

    public function __construct(
        private readonly ConvocacaoSmsContextoSessao $contextos,
        private readonly ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
        private readonly ConvocacaoSmsModeloRepositoryInterface $modelos,
        private readonly ConvocacaoSmsLoteService $lotes,
        private readonly SmsDisponibilidade $disponibilidade,
        private readonly ConvocacaoSmsTelefoneManualService $telefonesManuais,
    ) {}

    public function index(ConvocacaoSmsFiltroRequest $request): View
    {
        $contexto = $this->contextos->atual();
        $filtros = $this->filtros($request->validated());
        $zona = (string) ($filtros['zona'] ?? '');
        $itens = $this->destinatarios->listar($filtros, $contexto, route('colaboradores-eleitorais.convocacoes-sms.index'), 50);
        $itens->appends($request->query());

        return view('colaboradores-eleitorais.convocacoes-sms.index', [
            'destinatarios' => $itens,
            'territorios' => $this->destinatarios->listarTerritorios($contexto),
            'turmasTreinamento' => $this->destinatarios->listarTurmasTreinamento($contexto, $zona !== '' ? $zona : null),
            'modelos' => $zona !== '' ? $this->modelos->listarConfiguracoesParaExportacao(['zona' => $zona, 'situacao' => 'ATIVO'], $contexto) : [],
            'filtros' => $filtros,
            'funcoes' => MesarioFuncaoEleitoralCatalogo::todas(),
            'contexto' => $contexto,
            'integracao' => $this->disponibilidade->diagnostico(),
            'camposPdf' => self::CAMPOS_PDF,
            'camposPdfPadrao' => self::CAMPOS_PDF_PADRAO,
        ]);
    }

    public function enviar(ConvocacaoSmsEnvioRequest $request): RedirectResponse
    {
        try {
            $resultado = $this->lotes->criar($request->validated(), $this->contextos->atual());
        } catch (DomainException $exception) {
            return back()->withInput()->withErrors(['envio' => $exception->getMessage()]);
        }

        $mensagem = $resultado['duplicado']
            ? 'Esta solicitação já havia sido processada; nenhum envio foi duplicado.'
            : sprintf('Lote criado: %d enfileirado(s) e %d ignorado(s).', $resultado['enfileirados'], $resultado['ignorados']);

        return redirect()->route('colaboradores-eleitorais.convocacoes-sms.historico.index')
            ->with('status', $mensagem);
    }

    public function atualizarTelefone(
        ConvocacaoSmsTelefoneManualRequest $request,
        string $numInscricao,
    ): RedirectResponse {
        try {
            $resultado = $this->telefonesManuais->processar(
                $numInscricao,
                $request->validated(),
                $this->contextos->atual(),
            );
        } catch (DomainException $exception) {
            return back()->withInput()->withErrors(['telefone' => $exception->getMessage()]);
        }

        $mensagem = match ([$resultado['acao'], $resultado['alterado']]) {
            ['RESTAURAR', true] => 'Telefone restaurado para o valor da carga sincronizada.',
            ['RESTAURAR', false] => 'O nomeado já utiliza o telefone da carga sincronizada.',
            ['SALVAR', true] => 'Telefone do nomeado alterado manualmente.',
            default => 'O telefone manual informado já estava salvo.',
        };

        return back()->with('status', $mensagem);
    }

    public function pdf(ConvocacaoSmsFiltroRequest $request): Response
    {
        $contexto = $this->contextos->atual();
        $filtros = $this->filtros($request->validated());
        $campos = CamposPdfSelecionados::resolver($request->query('campos'), self::CAMPOS_PDF, self::CAMPOS_PDF_PADRAO);

        return Pdf::loadView('colaboradores-eleitorais.convocacoes-sms.pdf', [
            'titulo' => 'Nomeados elegíveis para SMS',
            'itens' => $this->destinatarios->listarParaExportacao($filtros, $contexto),
            'campos' => $campos,
            'rotulos' => self::CAMPOS_PDF,
            'geradoEm' => now()->format('d/m/Y H:i'),
            'contexto' => $contexto,
        ])->setPaper('a4', 'landscape')->download('nomeados-sms.pdf');
    }

    /** @param array<string, mixed> $dados @return array<string, mixed> */
    private function filtros(array $dados): array
    {
        return array_intersect_key($dados, array_flip(['q', 'zona', 'municipio', 'funcao', 'turma_id', 'situacao', 'confirmacao_elo']));
    }
}
```
</APP_HTTP_CONTROLLERS_CONVOCACAOSMS_CONVOCACAOSMSCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsDashboardController.php`
## <APP_HTTP_CONTROLLERS_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsDashboardController.php`
- **Namespace Declaração:** `App\Http\Controllers\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsDashboardController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(ConvocacaoSmsDashboardRequest $request): View
public function elegibilidade(ConvocacaoSmsDashboardRequest $request): JsonResponse
private function filtros(array $dados): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ConvocacaoSms;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsDashboardRequest;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoSessao;
use App\Services\ConvocacaoSms\ConvocacaoSmsDashboardService;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;
use Illuminate\View\View;
use Throwable;

final class ConvocacaoSmsDashboardController extends Controller
{
    public function __construct(
        private readonly ConvocacaoSmsContextoSessao $contextos,
        private readonly ConvocacaoSmsDashboardService $dashboard,
        private readonly ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
    ) {}

    public function index(ConvocacaoSmsDashboardRequest $request): View
    {
        $contexto = $this->contextos->atual();
        $filtros = $this->filtros($request->validated());
        $dados = $this->dashboard->carregar($filtros, $contexto);

        return view('colaboradores-eleitorais.convocacoes-sms.dashboard', [
            'contexto' => $contexto,
            'filtros' => $filtros,
            'territorios' => $this->destinatarios->listarTerritorios($contexto),
        ] + $dados);
    }

    public function elegibilidade(ConvocacaoSmsDashboardRequest $request): JsonResponse
    {
        try {
            return response()->json($this->dashboard->elegibilidade(
                $this->filtros($request->validated()),
                $this->contextos->atual(),
            ));
        } catch (AuthorizationException $exception) {
            throw $exception;
        } catch (Throwable $exception) {
            report($exception);

            return response()->json([
                'message' => 'Não foi possível atualizar o resumo de confirmação.',
            ], 503);
        }
    }

    /** @param array<string, mixed> $dados @return array<string, mixed> */
    private function filtros(array $dados): array
    {
        return array_intersect_key($dados, array_flip(['zona', 'data_inicial', 'data_final']));
    }
}
```
</APP_HTTP_CONTROLLERS_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsHistoricoController.php`
## <APP_HTTP_CONTROLLERS_CONVOCACAOSMS_CONVOCACAOSMSHISTORICOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsHistoricoController.php`
- **Namespace Declaração:** `App\Http\Controllers\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsHistoricoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(ConvocacaoSmsFiltroRequest $request): View
public function show(int $envio): View
public function pdf(ConvocacaoSmsFiltroRequest $request): Response
public function reenviar(int $envio): RedirectResponse
private function filtros(array $dados): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ConvocacaoSms;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsFiltroRequest;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRespostaRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoSessao;
use App\Services\ConvocacaoSms\ConvocacaoSmsReenvioService;
use App\Support\Exportacao\CamposPdfSelecionados;
use Barryvdh\DomPDF\Facade\Pdf;
use DomainException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\View\View;

final class ConvocacaoSmsHistoricoController extends Controller
{
    private const CAMPOS_PDF = [
        'nome' => 'Nome', 'num_inscricao' => 'Inscrição', 'num_zona' => 'Zona',
        'municipio' => 'Município', 'modelo_nome' => 'Modelo', 'status_codigo' => 'Situação',
        'usuario_nome' => 'Operador', 'dt_criacao_fmt' => 'Criado em', 'dt_aceite_fmt' => 'Aceito em',
        'provedor_resumo' => 'Provedor e identificadores', 'respostas_sms' => 'Respostas SMS',
    ];

    private const CAMPOS_PDF_PADRAO = ['nome', 'num_zona', 'municipio', 'modelo_nome', 'status_codigo', 'usuario_nome', 'dt_criacao_fmt'];

    public function __construct(
        private readonly ConvocacaoSmsContextoSessao $contextos,
        private readonly ConvocacaoSmsEnvioRepositoryInterface $envios,
        private readonly ConvocacaoSmsRespostaRepositoryInterface $respostas,
        private readonly ConvocacaoSmsReenvioService $reenvios,
    ) {}

    public function index(ConvocacaoSmsFiltroRequest $request): View
    {
        $contexto = $this->contextos->atual();
        $filtros = $this->filtros($request->validated());
        $itens = $this->envios->listarHistorico($filtros, $contexto, route('colaboradores-eleitorais.convocacoes-sms.historico.index'));
        $itens->appends($request->query());

        return view('colaboradores-eleitorais.convocacoes-sms.historico', [
            'envios' => $itens,
            'filtros' => $filtros,
            'contexto' => $contexto,
            'camposPdf' => self::CAMPOS_PDF,
            'camposPdfPadrao' => self::CAMPOS_PDF_PADRAO,
        ]);
    }

    public function show(int $envio): View
    {
        $contexto = $this->contextos->atual();
        $item = $this->envios->buscarDetalhe($envio, $contexto);
        if ($item === null) {
            abort(404);
        }
        $item['respostas'] = $this->respostas->listarPorEnvioIds([(int) $item['id']])[(int) $item['id']] ?? [];

        return view('colaboradores-eleitorais.convocacoes-sms.detalhe', compact('item', 'contexto'));
    }

    public function pdf(ConvocacaoSmsFiltroRequest $request): Response
    {
        $contexto = $this->contextos->atual();
        $filtros = $this->filtros($request->validated());
        $campos = CamposPdfSelecionados::resolver($request->query('campos'), self::CAMPOS_PDF, self::CAMPOS_PDF_PADRAO);

        $itens = $this->envios->listarHistoricoParaExportacao($filtros, $contexto);
        $respostas = $this->respostas->listarPorEnvioIds(array_map(static fn (array $item): int => (int) $item['id'], $itens));
        foreach ($itens as &$item) {
            $item['provedor_resumo'] = implode(' · ', array_filter([
                (string) ($item['provider_codigo'] ?? ''),
                ($item['provider_batch_id'] ?? null) ? 'Lote: '.$item['provider_batch_id'] : null,
                ($item['provider_message_id'] ?? null) ? 'Mensagem: '.$item['provider_message_id'] : null,
            ]));
            $item['respostas_sms'] = implode("\n", array_map(
                static fn (array $resposta): string => ($resposta['dt_recebimento_fmt'] ?? '—').' — '.($resposta['mensagem_texto'] ?? ''),
                $respostas[(int) $item['id']] ?? [],
            ));
        }
        unset($item);

        return Pdf::loadView('colaboradores-eleitorais.convocacoes-sms.pdf', [
            'titulo' => 'Histórico de convocações por SMS',
            'itens' => $itens,
            'campos' => $campos,
            'rotulos' => self::CAMPOS_PDF,
            'geradoEm' => now()->format('d/m/Y H:i'),
            'contexto' => $contexto,
        ])->setPaper('a4', 'landscape')->download('historico-convocacoes-sms.pdf');
    }

    public function reenviar(int $envio): RedirectResponse
    {
        $contexto = $this->contextos->atual();
        try {
            $this->reenvios->reenviar($envio, $contexto);
        } catch (DomainException $exception) {
            return back()->withErrors(['reenvio' => $exception->getMessage()]);
        }

        return back()->with('status', 'Reenvio administrativo enfileirado com uma única tentativa.');
    }

    /** @param array<string, mixed> $dados @return array<string, mixed> */
    private function filtros(array $dados): array
    {
        return array_intersect_key($dados, array_flip(['q', 'zona', 'situacao']));
    }
}
```
</APP_HTTP_CONTROLLERS_CONVOCACAOSMS_CONVOCACAOSMSHISTORICOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ConvocacaoSms/TextBeeSmsWebhookController.php`
## <APP_HTTP_CONTROLLERS_CONVOCACAOSMS_TEXTBEESMSWEBHOOKCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ConvocacaoSms/TextBeeSmsWebhookController.php`
- **Namespace Declaração:** `App\Http\Controllers\ConvocacaoSms`
- **Entidade / Classe:** `final class TextBeeSmsWebhookController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function receber(Request $request): JsonResponse
private function schemaValido(array $evento): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ConvocacaoSms;

use App\Http\Controllers\Controller;
use App\Services\ConvocacaoSms\TextBeeSmsWebhookAutenticacao;
use App\Services\ConvocacaoSms\TextBeeSmsWebhookService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use JsonException;
use Throwable;

final class TextBeeSmsWebhookController extends Controller
{
    private const TAMANHO_MAXIMO = 65536;

    public function __construct(
        private readonly TextBeeSmsWebhookAutenticacao $autenticacao,
        private readonly TextBeeSmsWebhookService $service,
    ) {}

    public function receber(Request $request): JsonResponse
    {
        $corpo = $request->getContent();
        if (! $this->autenticacao->assinaturaValida($corpo, $request->header('X-Signature'))) {
            return response()->json(['message' => 'Não autorizado.'], 401);
        }
        if (strlen($corpo) > self::TAMANHO_MAXIMO) {
            return response()->json(['message' => 'Corpo da requisição excede 64 KiB.'], 413);
        }

        try {
            $evento = json_decode($corpo, true, 64, JSON_THROW_ON_ERROR);
        } catch (JsonException) {
            return response()->json(['message' => 'JSON inválido.'], 400);
        }
        if (! is_array($evento) || array_is_list($evento) || ! $this->schemaValido($evento)) {
            return response()->json(['message' => 'Estrutura do evento inválida.'], 422);
        }

        try {
            return response()->json($this->service->processar($evento));
        } catch (Throwable $exception) {
            Log::error('Falha temporária ao persistir webhook SMS TextBee.', [
                'exception_class' => $exception::class,
            ]);

            return response()->json(['message' => 'Falha temporária.'], 503);
        }
    }

    /** @param array<string, mixed> $evento */
    private function schemaValido(array $evento): bool
    {
        $tipo = mb_strtoupper(trim((string) ($evento['webhookEvent'] ?? '')), 'UTF-8');
        if (! in_array($tipo, ['MESSAGE_SENT', 'MESSAGE_DELIVERED', 'MESSAGE_FAILED', 'MESSAGE_RECEIVED'], true)
            || trim((string) ($evento['smsId'] ?? '')) === ''
            || trim((string) ($evento['deviceId'] ?? '')) === '') {
            return false;
        }
        if ($tipo === 'MESSAGE_RECEIVED') {
            return trim((string) ($evento['sender'] ?? '')) !== ''
                && trim((string) ($evento['message'] ?? '')) !== ''
                && trim((string) ($evento['receivedAt'] ?? '')) !== '';
        }

        return trim((string) ($evento['smsBatchId'] ?? '')) !== ''
            && trim((string) ($evento['recipient'] ?? '')) !== '';
    }
}
```
</APP_HTTP_CONTROLLERS_CONVOCACAOSMS_TEXTBEESMSWEBHOOKCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ConvocacaoSms/ZenviaSmsWebhookController.php`
## <APP_HTTP_CONTROLLERS_CONVOCACAOSMS_ZENVIASMSWEBHOOKCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ConvocacaoSms/ZenviaSmsWebhookController.php`
- **Namespace Declaração:** `App\Http\Controllers\ConvocacaoSms`
- **Entidade / Classe:** `final class ZenviaSmsWebhookController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function receber(Request $request): JsonResponse
private function schemaSmsValido(array $evento): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ConvocacaoSms;

use App\Http\Controllers\Controller;
use App\Services\ConvocacaoSms\ZenviaSmsWebhookAutenticacao;
use App\Services\ConvocacaoSms\ZenviaSmsWebhookService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use JsonException;
use Throwable;

final class ZenviaSmsWebhookController extends Controller
{
    private const TAMANHO_MAXIMO = 65536;

    public function __construct(
        private readonly ZenviaSmsWebhookAutenticacao $autenticacao,
        private readonly ZenviaSmsWebhookService $service,
    ) {}

    public function receber(Request $request): JsonResponse
    {
        if (! config('planeleito.sms_zenvia.legacy_webhook_enabled', true)) {
            return response()->json(['message' => 'Webhook legado desativado.'], 410);
        }
        if (! $this->autenticacao->tokenValido($request->header('X-Planeleito-Webhook-Token'))) {
            return response()->json(['message' => 'Não autorizado.'], 401);
        }

        $corpo = $request->getContent();
        if (strlen($corpo) > self::TAMANHO_MAXIMO) {
            return response()->json(['message' => 'Corpo da requisição excede 64 KiB.'], 413);
        }

        try {
            $evento = json_decode($corpo, true, 64, JSON_THROW_ON_ERROR);
        } catch (JsonException) {
            return response()->json(['message' => 'JSON inválido.'], 400);
        }
        if (! is_array($evento) || array_is_list($evento)) {
            return response()->json(['message' => 'Estrutura do evento inválida.'], 422);
        }

        if (mb_strtoupper(trim((string) ($evento['type'] ?? '')), 'UTF-8') === 'MESSAGE_STATUS'
            && mb_strtoupper(trim((string) ($evento['channel'] ?? '')), 'UTF-8') === 'SMS'
            && ! $this->schemaSmsValido($evento)) {
            return response()->json(['message' => 'Estrutura MESSAGE_STATUS inválida.'], 422);
        }

        try {
            return response()->json($this->service->processar($evento));
        } catch (Throwable $exception) {
            Log::error('Falha temporária ao persistir webhook de status SMS Zenvia.', [
                'exception_class' => $exception::class,
            ]);

            return response()->json(['message' => 'Falha temporária.'], 503);
        }
    }

    /** @param array<string, mixed> $evento */
    private function schemaSmsValido(array $evento): bool
    {
        $mensagem = is_array($evento['message'] ?? null) ? $evento['message'] : [];
        $status = is_array($evento['messageStatus'] ?? null) ? $evento['messageStatus'] : [];

        return trim((string) ($evento['id'] ?? '')) !== ''
            && trim((string) ($mensagem['id'] ?? $evento['messageId'] ?? '')) !== ''
            && trim((string) ($status['code'] ?? '')) !== '';
    }
}
```
</APP_HTTP_CONTROLLERS_CONVOCACAOSMS_ZENVIASMSWEBHOOKCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatLdaMensagemController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATLDAMENSAGEMCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatLdaMensagemController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatLdaMensagemController extends Controller`

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
public function dados(Request $request): JsonResponse
public function historico(Request $request): JsonResponse
public function resumo(Request $request): JsonResponse
public function enviar(Request $request): JsonResponse|RedirectResponse
public function arquivar(Request $request): JsonResponse|RedirectResponse
private function montarPayload(array $conversa, bool $mostrarArquivadas): array
private function respostaPainel(array $payload, bool $mostrarArquivadas, bool $incluirLista): array
private function mostrarArquivadas(Request $request): bool
private function conversaAtiva(Request $request): ?int
private function conversaLdaAtiva(Request $request, bool $mostrarArquivadas): ?array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Nat;

use App\Http\Controllers\Controller;

use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Services\Nat\NatEscopoService;
use App\Services\Nat\NatRotaMensagemService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\View as ViewFacade;
use Illuminate\View\View;
use RuntimeException;

class NatLdaMensagemController extends Controller
{
    public function __construct(
        private readonly NatEscopoService $escopoService,
        private readonly NatRotaMensagemService $mensagemService,
        private readonly LdaConversaMensagemRepository $ldaMensagemRepository,
    ) {
    }

    public function index(Request $request): View
    {
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $conversa = $this->conversaLdaAtiva($request, $mostrarArquivadas);

        if ($conversa === null) {
            $conversa = $this->primeiraConversaLdaNoEscopo($mostrarArquivadas);
        }

        if ($conversa === null) {
            $payload = $this->montarPayloadVazio($mostrarArquivadas);
        } else {
            $payload = $this->montarPayload($conversa, $mostrarArquivadas);
        }

        if (($payload['escopo_ativo_tipo'] ?? null) !== 'LDA') {
            abort(404, 'Conversa LDA nao encontrada no escopo informado.');
        }

        $backUrl = trim((string) $request->query('back_url', ''));

        return view('nat.lda.mensagens', [
            'mensagensPainel' => $payload,
            'mensagensResumo' => $mostrarArquivadas
                ? $this->resumoDoPayload($payload)
                : $this->mensagemService->resumo(
                    [],
                    $this->macroprojetoAtivoIdSessao(),
                    $this->escopoService->usuarioAuditoria(),
                    $conversa ? (int) $conversa['conversa_id'] : null,
                    $this->escopoService->zonasPermitidas(),
                    $this->escopoService->acessoTodasZonas(),
                ),
            'mostrarArquivadas' => $mostrarArquivadas,
            'backUrl' => $backUrl !== '' ? $backUrl : null,
        ]);
    }

    public function dados(Request $request): JsonResponse
    {
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $conversa = $this->conversaLdaAtiva($request, $mostrarArquivadas);

        if ($conversa === null) {
            $conversa = $this->primeiraConversaLdaNoEscopo($mostrarArquivadas);
        }

        if ($conversa === null) {
            return response()->json($this->respostaPainel(
                $this->montarPayloadVazio($mostrarArquivadas),
                $mostrarArquivadas,
                true,
            ));
        }

        return response()->json($this->respostaPainel(
            $this->montarPayload($conversa, $mostrarArquivadas),
            $mostrarArquivadas,
            true,
        ));
    }

    public function historico(Request $request): JsonResponse
    {
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $conversa = $this->conversaLdaAtiva($request, $mostrarArquivadas);

        if ($conversa === null) {
            $conversa = $this->primeiraConversaLdaNoEscopo($mostrarArquivadas);
        }

        if ($conversa === null) {
            return response()->json($this->respostaPainel(
                $this->montarPayloadVazio($mostrarArquivadas),
                $mostrarArquivadas,
                false,
            ));
        }

        return response()->json($this->respostaPainel(
            $this->montarPayload($conversa, $mostrarArquivadas),
            $mostrarArquivadas,
            false,
        ));
    }

    public function resumo(Request $request): JsonResponse
    {
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $conversa = $this->conversaLdaAtiva($request, $mostrarArquivadas);

        if ($conversa === null) {
            $conversa = $this->primeiraConversaLdaNoEscopo($mostrarArquivadas);
        }

        if ($conversa === null) {
            return response()->json($this->resumoDoPayload($this->montarPayloadVazio($mostrarArquivadas)));
        }

        if ($mostrarArquivadas) {
            return response()->json($this->resumoDoPayload($this->montarPayload($conversa, true)));
        }

        return response()->json(
            $this->mensagemService->resumo(
                [],
                $this->macroprojetoAtivoIdSessao(),
                $this->escopoService->usuarioAuditoria(),
                (int) $conversa['conversa_id'],
                $this->escopoService->zonasPermitidas(),
                $this->escopoService->acessoTodasZonas(),
            )
        );
    }

    public function enviar(Request $request): JsonResponse|RedirectResponse
    {
        $dados = $request->validate([
            'mensagem' => ['required', 'string', 'max:4000'],
            'conversa_id' => ['required', 'integer', 'min:1'],
        ]);

        $conversa = $this->conversaLdaAtiva($request, false);
        if ($conversa === null) {
            return $this->responderErro($request, 'A conversa informada nao pertence ao escopo autorizado.');
        }

        try {
            $this->ldaMensagemRepository->registrarMensagemNatNaConversa(
                (int) $conversa['conversa_id'],
                $this->macroprojetoAtivoIdSessao(),
                $this->escopoService->zonasPermitidas(),
                $this->escopoService->acessoTodasZonas(),
                $this->escopoService->usuarioAuditoria(),
                (string) $dados['mensagem'],
            );
        } catch (RuntimeException $exception) {
            return $this->responderErro($request, $exception->getMessage());
        }

        return $this->responderSucesso($request, 'Mensagem enviada com sucesso.');
    }

    public function arquivar(Request $request): JsonResponse|RedirectResponse
    {
        $request->validate([
            'conversa_id' => ['required', 'integer', 'min:1'],
        ]);

        $conversa = $this->conversaLdaAtiva($request, false);
        if ($conversa === null) {
            return $this->responderErro($request, 'A conversa informada nao pertence ao escopo autorizado.');
        }

        try {
            $this->ldaMensagemRepository->arquivarConversaPorIdNoEscopo(
                (int) $conversa['conversa_id'],
                $this->macroprojetoAtivoIdSessao(),
                $this->escopoService->zonasPermitidas(),
                $this->escopoService->acessoTodasZonas(),
            );
        } catch (RuntimeException $exception) {
            return $this->responderErro($request, $exception->getMessage());
        }

        if ($request->ajax()) {
            return response()->json(['mensagem' => 'Conversa atualizada com sucesso.']);
        }

        $backUrl = trim((string) $request->input('back_url', ''));
        $params = [
            'conversa_id' => (int) $conversa['conversa_id'],
            'mostrar_arquivadas' => 1,
        ];
        if ($backUrl !== '') {
            $params['back_url'] = $backUrl;
        }

        return redirect()
            ->route('nat.lda.mensagens.index', $params)
            ->with('status', 'Conversa atualizada com sucesso.');
    }

    private function montarPayload(array $conversa, bool $mostrarArquivadas): array
    {
        return $this->mensagemService->montarPainel(
            [],
            $this->macroprojetoAtivoIdSessao(),
            $this->escopoService->usuarioAuditoria(),
            (int) $conversa['conversa_id'],
            $mostrarArquivadas,
            false,
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas(),
        );
    }

    private function respostaPainel(array $payload, bool $mostrarArquivadas, bool $incluirLista): array
    {
        $temListaLateral = count($payload['conversas'] ?? []) > 1;
        $temAlvoArquivavel = !empty($payload['lda_ativa_id']);

        $resposta = [
            'historico_html' => ViewFacade::make('nat.rotas.partials.mensagens-historico-bloco', [
                'mensagensPainel' => $payload,
            ])->render(),
            'total_nao_lidas' => $payload['total_nao_lidas'],
            'ultima_mensagem_id' => $payload['ultima_mensagem_id'],
            'ultima_leitura_id' => $payload['ultima_leitura_id'] ?? null,
            'rota_ativa_id' => null,
            'lda_ativa_id' => $payload['lda_ativa_id'] ?? null,
            'escopo_ativo_tipo' => 'LDA',
            'conversa_ativa_id' => $payload['conversa_ativa_id'],
            'nova_conversa' => false,
            'mostrar_arquivadas' => $mostrarArquivadas,
            'permite_composer' => (bool) ($payload['permite_composer'] ?? false),
            'permite_nova_conversa' => false,
            'tem_lista_lateral' => $temListaLateral,
            'arquivar_disponivel' => !$mostrarArquivadas && !empty($payload['conversa_ativa_id']) && $temAlvoArquivavel,
        ];

        if ($incluirLista) {
            $resposta['lista_html'] = ViewFacade::make('nat.rotas.partials.mensagens-lista', [
                'mensagensPainel' => $payload,
            ])->render();
        }

        return $resposta;
    }

    private function mostrarArquivadas(Request $request): bool
    {
        return $request->boolean('mostrar_arquivadas', $request->boolean('mensagens_arquivadas'));
    }

    private function conversaAtiva(Request $request): ?int
    {
        $conversaId = (int) $request->query('conversa_id', $request->input('conversa_id', 0));

        return $conversaId > 0 ? $conversaId : null;
    }

    private function conversaLdaAtiva(Request $request, bool $mostrarArquivadas): ?array
    {
        $conversaId = $this->conversaAtiva($request);
        if ($conversaId === null) {
            return null;
        }

        $usuario = $this->escopoService->usuarioAuditoria();

        return $this->ldaMensagemRepository->buscarConversaPorIdNoEscopo(
            $conversaId,
            $this->macroprojetoAtivoIdSessao(),
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas(),
            $usuario['login'] ?? null,
            $mostrarArquivadas,
        );
    }

    private function primeiraConversaLdaNoEscopo(bool $mostrarArquivadas): ?array
    {
        $usuario = $this->escopoService->usuarioAuditoria();
        $turno = $this->macroprojetoAtivoTurnoSessao();

        return $this->ldaMensagemRepository->primeiraConversaNoEscopo(
            $this->macroprojetoAtivoIdSessao(),
            $turno,
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas(),
            $usuario['login'] ?? null,
            $mostrarArquivadas,
        );
    }

    private function montarPayloadVazio(bool $mostrarArquivadas): array
    {
        return [
            'habilitado' => true,
            'motivo' => null,
            'conversas' => [],
            'mensagens' => [],
            'rota_ativa_id' => null,
            'lda_ativa_id' => null,
            'escopo_ativo_tipo' => 'LDA',
            'conversa_ativa_id' => null,
            'permite_composer' => false,
            'permite_nova_conversa' => false,
            'mostrar_arquivadas' => $mostrarArquivadas,
            'nova_conversa' => false,
            'total_nao_lidas' => 0,
            'ultima_mensagem_id' => null,
            'ultima_leitura_id' => null,
        ];
    }

    private function resumoDoPayload(array $payload): array
    {
        return [
            'total_nao_lidas' => (int) ($payload['total_nao_lidas'] ?? 0),
            'ultima_mensagem_id' => $payload['ultima_mensagem_id'] ?? null,
            'ultima_leitura_id' => $payload['ultima_leitura_id'] ?? null,
            'conversa_ativa_id' => $payload['conversa_ativa_id'] ?? null,
        ];
    }

    private function responderErro(Request $request, string $mensagem): JsonResponse|RedirectResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem], 422);
        }

        return back()->withInput()->with('erro', $mensagem);
    }

    private function responderSucesso(Request $request, string $mensagem): JsonResponse|RedirectResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem]);
        }

        return back()->with('status', $mensagem);
    }

    public function garantir(Request $request): RedirectResponse
    {
        $ldaId = (int) $request->query('lda_id');
        $turno = $this->macroprojetoAtivoTurnoSessao();
        $macroprojetoId = $this->macroprojetoAtivoIdSessao();

        if ($turno === '') {
            abort(409, 'Nenhum turno ativo configurado para o macroprojeto.');
        }

        if ($ldaId <= 0) {
            abort(400, 'Local inválido.');
        }

        if (!$this->ldaMensagemRepository->ldaPertenceAoEscopo($ldaId, $this->escopoService->zonasPermitidas(), $this->escopoService->acessoTodasZonas())) {
            abort(403, 'Acesso não autorizado para o local informado.');
        }

        $conversaId = $this->ldaMensagemRepository->garantirConversaAtiva($macroprojetoId, $turno, $ldaId);

        $backUrl = trim((string) $request->query('back_url', ''));
        $params = ['conversa_id' => $conversaId];
        if ($backUrl !== '') {
            $params['back_url'] = $backUrl;
        }

        return redirect()->route('nat.lda.mensagens.index', $params);
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATLDAMENSAGEMCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatRotaMensagemController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATROTAMENSAGEMCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatRotaMensagemController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatRotaMensagemController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function dados(Request $request): JsonResponse
public function historico(Request $request): JsonResponse
public function resumo(Request $request): JsonResponse
public function enviar(Request $request): JsonResponse|RedirectResponse
public function arquivar(Request $request): JsonResponse|RedirectResponse
private function responderErro(Request $request, string $mensagem): JsonResponse|RedirectResponse
private function responderSucesso(Request $request, string $mensagem): JsonResponse|RedirectResponse
private function respostaPainel(array $payload, bool $mostrarArquivadas, bool $incluirLista): array
private function montarPayload(Request $request, array $rotas, bool $mostrarArquivadas): array
private function rotasDisponiveis(): array
private function rotasMensagensDisponiveis(Request $request): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Nat;

use App\Http\Controllers\Controller;

use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Services\Nat\NatEscopoService;
use App\Services\Nat\NatRotaMensagemService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\View as ViewFacade;
use RuntimeException;

class NatRotaMensagemController extends Controller
{
    public function __construct(
        private readonly NatOcorrenciaRepository $ocorrenciaRepository,
        private readonly NatEscopoService $escopoService,
        private readonly NatRotaMensagemService $mensagemService,
        private readonly LdaConversaMensagemRepository $ldaMensagemRepository,
    ) {
    }

    public function dados(Request $request): JsonResponse
    {
        $rotas = $this->rotasMensagensDisponiveis($request);
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $payload = $this->montarPayload($request, $rotas, $mostrarArquivadas);

        return response()->json($this->respostaPainel($payload, $mostrarArquivadas, true));
    }

    public function historico(Request $request): JsonResponse
    {
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $payload = $this->montarPayload($request, $this->rotasMensagensDisponiveis($request), $mostrarArquivadas);

        return response()->json($this->respostaPainel($payload, $mostrarArquivadas, false));
    }

    public function resumo(Request $request): JsonResponse
    {
        return response()->json(
            $this->mensagemService->resumo(
                $this->rotasMensagensDisponiveis($request),
                $this->macroprojetoAtivoIdSessao(),
                $this->escopoService->usuarioAuditoria(),
                $this->conversaAtiva($request),
                $this->escopoService->zonasPermitidas(),
                $this->escopoService->acessoTodasZonas(),
            )
        );
    }

    public function enviar(Request $request): JsonResponse|RedirectResponse
    {
        $dados = $request->validate([
            'mensagem' => ['required', 'string', 'max:4000'],
            'rota_ids' => ['nullable', 'array'],
            'rota_ids.*' => ['integer', 'min:1'],
            'conversa_id' => ['nullable', 'integer', 'min:1'],
            'nova_conversa' => ['nullable', 'boolean'],
        ]);

        $conversaLda = $this->conversaLdaAtiva($request, false);

        try {
            if ($conversaLda !== null) {
                $this->ldaMensagemRepository->registrarMensagemNatNaConversa(
                    (int) $conversaLda['conversa_id'],
                    $this->macroprojetoAtivoIdSessao(),
                    $this->escopoService->zonasPermitidas(),
                    $this->escopoService->acessoTodasZonas(),
                    $this->escopoService->usuarioAuditoria(),
                    (string) $dados['mensagem'],
                );

                return $this->responderSucesso($request, 'Mensagem enviada com sucesso.');
            }

            $request->validate([
                'rota_ids' => ['required', 'array', 'min:1'],
                'rota_ids.*' => ['integer', 'min:1'],
            ]);

            $this->mensagemService->enviar(
                $this->rotasMensagensDisponiveis($request),
                $this->macroprojetoAtivoIdSessao(),
                $this->escopoService->usuarioAuditoria(),
                'NAT',
                $dados['rota_ids'] ?? [],
                (string) $dados['mensagem'],
                (bool) ($dados['nova_conversa'] ?? false),
            );
        } catch (RuntimeException $exception) {
            return $this->responderErro($request, $exception->getMessage());
        }

        return $this->responderSucesso($request, 'Mensagem enviada com sucesso.');
    }

    public function arquivar(Request $request): JsonResponse|RedirectResponse
    {
        $dados = $request->validate([
            'rota_id' => ['nullable', 'integer', 'min:1'],
            'conversa_id' => ['nullable', 'integer', 'min:1'],
            'arquivar' => ['nullable', 'boolean'],
        ]);

        $conversaLda = $this->conversaLdaAtiva($request, false);

        try {
            if ($conversaLda !== null) {
                $this->ldaMensagemRepository->arquivarConversaPorIdNoEscopo(
                    (int) $conversaLda['conversa_id'],
                    $this->macroprojetoAtivoIdSessao(),
                    $this->escopoService->zonasPermitidas(),
                    $this->escopoService->acessoTodasZonas(),
                );

                return $this->responderSucesso($request, 'Conversa atualizada com sucesso.');
            }

            $request->validate([
                'rota_id' => ['required', 'integer', 'min:1'],
            ]);

            $this->mensagemService->arquivar(
                $this->rotasMensagensDisponiveis($request),
                $this->macroprojetoAtivoIdSessao(),
                (int) $dados['rota_id'],
                (bool) ($dados['arquivar'] ?? true)
            );
        } catch (RuntimeException $exception) {
            return $this->responderErro($request, $exception->getMessage());
        }

        return $this->responderSucesso($request, 'Conversa atualizada com sucesso.');
    }

    private function responderErro(Request $request, string $mensagem): JsonResponse|RedirectResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem], 422);
        }

        return back()->withInput()->with('erro', $mensagem);
    }

    private function responderSucesso(Request $request, string $mensagem): JsonResponse|RedirectResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem]);
        }

        return back()->with('status', $mensagem);
    }

    private function respostaPainel(array $payload, bool $mostrarArquivadas, bool $incluirLista): array
    {
        $temListaLateral = count($payload['conversas'] ?? []) > 1;
        $escopoAtivoTipo = (string) ($payload['escopo_ativo_tipo'] ?? 'ROTA');
        $temAlvoArquivavel = $escopoAtivoTipo === 'LDA'
            ? !empty($payload['lda_ativa_id'])
            : !empty($payload['rota_ativa_id']);

        $resposta = [
            'historico_html' => ViewFacade::make('nat.rotas.partials.mensagens-historico-bloco', [
                'mensagensPainel' => $payload,
            ])->render(),
            'total_nao_lidas' => $payload['total_nao_lidas'],
            'ultima_mensagem_id' => $payload['ultima_mensagem_id'],
            'ultima_leitura_id' => $payload['ultima_leitura_id'] ?? null,
            'rota_ativa_id' => $payload['rota_ativa_id'],
            'lda_ativa_id' => $payload['lda_ativa_id'] ?? null,
            'escopo_ativo_tipo' => $escopoAtivoTipo,
            'conversa_ativa_id' => $payload['conversa_ativa_id'],
            'nova_conversa' => (bool) ($payload['nova_conversa'] ?? false),
            'mostrar_arquivadas' => $mostrarArquivadas,
            'permite_composer' => (bool) ($payload['permite_composer'] ?? false),
            'permite_nova_conversa' => (bool) ($payload['permite_nova_conversa'] ?? true),
            'tem_lista_lateral' => $temListaLateral,
            'arquivar_disponivel' => !$mostrarArquivadas && !($payload['nova_conversa'] ?? false) && !empty($payload['conversa_ativa_id']) && $temAlvoArquivavel,
        ];

        if ($incluirLista) {
            $resposta['lista_html'] = ViewFacade::make('nat.rotas.partials.mensagens-lista', [
                'mensagensPainel' => $payload,
            ])->render();
        }

        return $resposta;
    }

    private function montarPayload(Request $request, array $rotas, bool $mostrarArquivadas): array
    {
        return $this->mensagemService->montarPainel(
            $rotas,
            $this->macroprojetoAtivoIdSessao(),
            $this->escopoService->usuarioAuditoria(),
            $this->conversaAtiva($request),
            $mostrarArquivadas,
            $this->novaConversa($request),
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas(),
        );
    }

    private function rotasDisponiveis(): array
    {
        return $this->ocorrenciaRepository->listarRotasNoEscopo(
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas()
        );
    }

    private function rotasMensagensDisponiveis(Request $request): array
    {
        $rotas = $this->rotasDisponiveis();
        $selecionadas = $this->rotasSelecionadasNoFiltro($request, $rotas);

        if ($selecionadas === []) {
            return $rotas;
        }

        return array_values(array_filter($rotas, static fn (array $rota) => in_array((int) ($rota['id'] ?? 0), $selecionadas, true)));
    }

    private function rotasSelecionadasNoFiltro(Request $request, array $rotas): array
    {
        $valores = $request->query('rotas', []);
        if (!is_array($valores)) {
            $valores = [$valores];
        }

        $idsDisponiveis = array_map(static fn (array $rota) => (int) ($rota['id'] ?? 0), $rotas);

        return array_values(array_filter(array_unique(array_map('intval', $valores)), static function (int $valor) use ($idsDisponiveis) {
            return $valor > 0 && in_array($valor, $idsDisponiveis, true);
        }));
    }

    private function conversaAtiva(Request $request): ?int
    {
        $conversaId = (int) $request->query('conversa_id', $request->input('conversa_id', 0));
        return $conversaId > 0 ? (int) $conversaId : null;
    }

    private function conversaLdaAtiva(Request $request, bool $mostrarArquivadas): ?array
    {
        $conversaId = $this->conversaAtiva($request);
        if ($conversaId === null) {
            return null;
        }

        return $this->ldaMensagemRepository->buscarConversaPorIdNoEscopo(
            $conversaId,
            $this->macroprojetoAtivoIdSessao(),
            $this->escopoService->zonasPermitidas(),
            $this->escopoService->acessoTodasZonas(),
            $this->escopoService->usuarioAuditoria()['login'] ?? null,
            $mostrarArquivadas,
        );
    }

    private function mostrarArquivadas(Request $request): bool
    {
        return (string) $request->query('mostrar_arquivadas', $request->query('mensagens_arquivadas', '0')) === '1';
    }

    private function novaConversa(Request $request): bool
    {
        return (string) $request->query('nova_conversa', $request->input('nova_conversa', '0')) === '1';
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATROTAMENSAGEMCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Nat/NatRotaMensagemExternaController.php`
## <APP_HTTP_CONTROLLERS_NAT_NATROTAMENSAGEMEXTERNACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Nat/NatRotaMensagemExternaController.php`
- **Namespace Declaração:** `App\Http\Controllers\Nat`
- **Entidade / Classe:** `class NatRotaMensagemExternaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function dados(Request $request): JsonResponse
public function historico(Request $request): JsonResponse
public function resumo(Request $request): JsonResponse
public function enviar(Request $request): JsonResponse|RedirectResponse
public function arquivar(Request $request): JsonResponse|RedirectResponse
private function responderErro(Request $request, string $mensagem): JsonResponse|RedirectResponse
private function responderSucesso(Request $request, string $mensagem): JsonResponse|RedirectResponse
private function respostaPainel(array $payload, bool $mostrarArquivadas, bool $incluirLista): array
private function montarPayload(Request $request, array $rotas, bool $mostrarArquivadas): array
private function rotasDisponiveis(Request $request): array
private function usuarioAuditoria(): array
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
use App\Services\Nat\NatExternoSessionService;
use App\Services\Nat\NatRotaMensagemService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\View as ViewFacade;
use RuntimeException;

class NatRotaMensagemExternaController extends Controller
{
    public function __construct(
        private readonly NatOcorrenciaRepository $ocorrenciaRepository,
        private readonly NatExternoSessionService $externalSession,
        private readonly NatRotaMensagemService $mensagemService,
    ) {
    }

    public function dados(Request $request): JsonResponse
    {
        $rotas = $this->rotasDisponiveis($request);
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $payload = $this->montarPayload($request, $rotas, $mostrarArquivadas);

        return response()->json($this->respostaPainel($payload, $mostrarArquivadas, true));
    }

    public function historico(Request $request): JsonResponse
    {
        $mostrarArquivadas = $this->mostrarArquivadas($request);
        $payload = $this->montarPayload($request, $this->rotasDisponiveis($request), $mostrarArquivadas);

        return response()->json($this->respostaPainel($payload, $mostrarArquivadas, false));
    }

    public function resumo(Request $request): JsonResponse
    {
        return response()->json(
            $this->mensagemService->resumo(
                $this->rotasDisponiveis($request),
                (int) $this->externalSession->macroprojetoId($request),
                $this->usuarioAuditoria()
            )
        );
    }

    public function enviar(Request $request): JsonResponse|RedirectResponse
    {
        $dados = $request->validate([
            'mensagem' => ['required', 'string', 'max:4000'],
            'rota_ids' => ['required', 'array', 'min:1'],
            'rota_ids.*' => ['integer', 'min:1'],
            'nova_conversa' => ['nullable', 'boolean'],
        ]);

        try {
            $this->mensagemService->enviar(
                $this->rotasDisponiveis($request),
                (int) $this->externalSession->macroprojetoId($request),
                $this->usuarioAuditoria(),
                'ROTA',
                $dados['rota_ids'],
                (string) $dados['mensagem'],
                (bool) ($dados['nova_conversa'] ?? false),
            );
        } catch (RuntimeException $exception) {
            return $this->responderErro($request, $exception->getMessage());
        }

        return $this->responderSucesso($request, 'Mensagem enviada com sucesso.');
    }

    public function arquivar(Request $request): JsonResponse|RedirectResponse
    {
        $dados = $request->validate([
            'rota_id' => ['required', 'integer', 'min:1'],
            'arquivar' => ['nullable', 'boolean'],
        ]);

        try {
            $this->mensagemService->arquivar(
                $this->rotasDisponiveis($request),
                (int) $this->externalSession->macroprojetoId($request),
                (int) $dados['rota_id'],
                (bool) ($dados['arquivar'] ?? true)
            );
        } catch (RuntimeException $exception) {
            return $this->responderErro($request, $exception->getMessage());
        }

        return $this->responderSucesso($request, 'Conversa atualizada com sucesso.');
    }

    private function responderErro(Request $request, string $mensagem): JsonResponse|RedirectResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem], 422);
        }

        return back()->withInput()->with('erro', $mensagem);
    }

    private function responderSucesso(Request $request, string $mensagem): JsonResponse|RedirectResponse
    {
        if ($request->ajax()) {
            return response()->json(['mensagem' => $mensagem]);
        }

        return back()->with('status', $mensagem);
    }

    private function respostaPainel(array $payload, bool $mostrarArquivadas, bool $incluirLista): array
    {
        $temListaLateral = count($payload['conversas'] ?? []) > 1;

        $resposta = [
            'historico_html' => ViewFacade::make('nat.rotas.partials.mensagens-historico-bloco', [
                'mensagensPainel' => $payload,
            ])->render(),
            'total_nao_lidas' => $payload['total_nao_lidas'],
            'ultima_mensagem_id' => $payload['ultima_mensagem_id'],
            'ultima_leitura_id' => $payload['ultima_leitura_id'] ?? null,
            'rota_ativa_id' => $payload['rota_ativa_id'],
            'conversa_ativa_id' => $payload['conversa_ativa_id'],
            'nova_conversa' => (bool) ($payload['nova_conversa'] ?? false),
            'mostrar_arquivadas' => $mostrarArquivadas,
            'permite_composer' => (bool) ($payload['permite_composer'] ?? false),
            'tem_lista_lateral' => $temListaLateral,
            'arquivar_disponivel' => !$mostrarArquivadas && !($payload['nova_conversa'] ?? false) && !empty($payload['conversa_ativa_id']) && !empty($payload['rota_ativa_id']),
        ];

        if ($incluirLista) {
            $resposta['lista_html'] = ViewFacade::make('nat.rotas.partials.mensagens-lista', [
                'mensagensPainel' => $payload,
            ])->render();
        }

        return $resposta;
    }

    private function montarPayload(Request $request, array $rotas, bool $mostrarArquivadas): array
    {
        return $this->mensagemService->montarPainel(
            $rotas,
            (int) $this->externalSession->macroprojetoId($request),
            $this->usuarioAuditoria(),
            $this->conversaAtiva($request),
            $mostrarArquivadas,
            $this->novaConversa($request)
        );
    }

    private function rotasDisponiveis(Request $request): array
    {
        $permitidas = $this->externalSession->rotasIds($request);
        if ($permitidas === []) {
            return [];
        }

        return collect($this->ocorrenciaRepository->listarRotasNoEscopo($this->externalSession->zonas($request), false))
            ->filter(static fn (array $rota) => in_array((int) ($rota['id'] ?? 0), $permitidas, true))
            ->values()
            ->all();
    }

    private function usuarioAuditoria(): array
    {
        return [
            'login' => trim((string) session('user.username', '')) ?: null,
            'nome' => trim((string) session('user.name', '')) ?: null,
        ];
    }

    private function conversaAtiva(Request $request): ?int
    {
        $conversaId = (int) $request->query('conversa_id', $request->input('conversa_id', 0));
        return $conversaId > 0 ? $conversaId : null;
    }

    private function mostrarArquivadas(Request $request): bool
    {
        return (string) $request->query('mostrar_arquivadas', $request->query('mensagens_arquivadas', '0')) === '1';
    }

    private function novaConversa(Request $request): bool
    {
        return (string) $request->query('nova_conversa', $request->input('nova_conversa', '0')) === '1';
    }
}
```
</APP_HTTP_CONTROLLERS_NAT_NATROTAMENSAGEMEXTERNACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsDashboardRequest.php`
## <APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsDashboardRequest.php`
- **Namespace Declaração:** `App\Http\Requests\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsDashboardRequest extends FormRequest`

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

namespace App\Http\Requests\ConvocacaoSms;

use Illuminate\Foundation\Http\FormRequest;

final class ConvocacaoSmsDashboardRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'zona' => ['nullable', 'regex:/^\d{1,10}$/'],
            'data_inicial' => ['nullable', 'date_format:Y-m-d'],
            'data_final' => ['nullable', 'date_format:Y-m-d', 'after_or_equal:data_inicial'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $zona = trim((string) $this->input('zona', ''));
        $dataInicial = trim((string) $this->input('data_inicial', ''));
        $dataFinal = trim((string) $this->input('data_final', ''));

        $this->merge([
            'zona' => $zona === ''
                ? null
                : (preg_match('/^\d{1,10}$/', $zona) === 1 ? (string) ((int) $zona) : $zona),
            'data_inicial' => $dataInicial !== '' ? $dataInicial : null,
            'data_final' => $dataFinal !== '' ? $dataFinal : null,
        ]);
    }
}
```
</APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsEnvioRequest.php`
## <APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSENVIOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsEnvioRequest.php`
- **Namespace Declaração:** `App\Http\Requests\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsEnvioRequest extends FormRequest`

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

namespace App\Http\Requests\ConvocacaoSms;

use Illuminate\Foundation\Http\FormRequest;

final class ConvocacaoSmsEnvioRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'request_uuid' => ['required', 'uuid'],
            'modelo_id' => ['required', 'integer', 'min:1'],
            'zona' => ['required', 'regex:/^\d{1,10}$/'],
            'num_inscricoes' => ['required', 'array', 'min:1', 'max:50'],
            'num_inscricoes.*' => ['required', 'string', 'regex:/^\d{1,20}$/', 'distinct'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $inscricoes = is_array($this->input('num_inscricoes'))
            ? array_map(static fn (mixed $valor): string => trim((string) $valor), $this->input('num_inscricoes'))
            : $this->input('num_inscricoes');
        $zona = trim((string) $this->input('zona', ''));
        $this->merge([
            'request_uuid' => mb_strtolower(trim((string) $this->input('request_uuid', '')), 'UTF-8'),
            'zona' => $zona !== '' ? (string) ((int) $zona) : null,
            'num_inscricoes' => $inscricoes,
        ]);
    }
}
```
</APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSENVIOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsFiltroRequest.php`
## <APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSFILTROREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsFiltroRequest.php`
- **Namespace Declaração:** `App\Http\Requests\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsFiltroRequest extends FormRequest`

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

namespace App\Http\Requests\ConvocacaoSms;

use App\Support\ColaboradoresEleitorais\MesarioFuncaoEleitoralCatalogo;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

final class ConvocacaoSmsFiltroRequest extends FormRequest
{
    private const SITUACOES = [
        'A_COMUNICAR', 'SEM_CELULAR_VALIDO', 'PENDENTE', 'PROCESSANDO', 'JA_COMUNICADO',
        'REJEITADO', 'INDETERMINADO', 'ACEITO', 'ENVIADO', 'ENTREGUE',
        'NAO_ENTREGUE', 'CANCELADO_ANTES_ENVIO', 'ATIVO', 'INATIVO',
    ];

    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'q' => ['nullable', 'string', 'max:160'],
            'zona' => ['nullable', 'regex:/^\d{1,10}$/'],
            'municipio' => ['nullable', 'string', 'max:160'],
            'funcao' => ['nullable', Rule::in(MesarioFuncaoEleitoralCatalogo::todas())],
            'turma_id' => ['nullable', 'integer', 'min:1'],
            'situacao' => ['nullable', Rule::in(self::SITUACOES)],
            'confirmacao_elo' => ['nullable', Rule::in(['CONFIRMADO', 'NAO_CONFIRMADO'])],
            'campos' => ['nullable', 'array', 'max:20'],
            'campos.*' => ['string', 'max:40'],
            'page' => ['nullable', 'integer', 'min:1'],
            'editar' => ['nullable', 'integer', 'min:1'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $zona = trim((string) $this->input('zona', ''));
        $this->merge([
            'q' => trim((string) $this->input('q', '')),
            'zona' => $zona !== '' ? (string) ((int) $zona) : null,
            'municipio' => trim((string) $this->input('municipio', '')),
            'funcao' => trim((string) $this->input('funcao', '')) ?: null,
            'turma_id' => trim((string) $this->input('turma_id', '')) ?: null,
            'situacao' => mb_strtoupper(trim((string) $this->input('situacao', '')), 'UTF-8') ?: null,
            'confirmacao_elo' => mb_strtoupper(trim((string) $this->input('confirmacao_elo', '')), 'UTF-8') ?: null,
        ]);
    }
}
```
</APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSFILTROREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsTelefoneManualRequest.php`
## <APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSTELEFONEMANUALREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/ConvocacaoSms/ConvocacaoSmsTelefoneManualRequest.php`
- **Namespace Declaração:** `App\Http\Requests\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsTelefoneManualRequest extends FormRequest`

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

namespace App\Http\Requests\ConvocacaoSms;

use App\Rules\TelefoneRule;
use App\Support\Validation\TelefoneBrasileiro;
use Illuminate\Foundation\Http\FormRequest;

final class ConvocacaoSmsTelefoneManualRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'acao' => ['required', 'in:SALVAR,RESTAURAR'],
            'zona' => ['required', 'regex:/^\d{1,10}$/'],
            'telefone' => ['nullable', 'required_if:acao,SALVAR', 'digits:11', new TelefoneRule],
        ];
    }

    protected function prepareForValidation(): void
    {
        $zona = trim((string) $this->input('zona', ''));
        $this->merge([
            'acao' => mb_strtoupper(trim((string) $this->input('acao', '')), 'UTF-8'),
            'zona' => $zona !== '' && preg_match('/^\d+$/', $zona) === 1 ? (string) ((int) $zona) : $zona,
            'telefone' => TelefoneBrasileiro::prepararEntrada($this->input('telefone')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_CONVOCACAOSMS_CONVOCACAOSMSTELEFONEMANUALREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Jobs/ConvocacaoSms/EnviarConvocacaoSmsJob.php`
## <APP_JOBS_CONVOCACAOSMS_ENVIARCONVOCACAOSMSJOB_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Jobs/ConvocacaoSms/EnviarConvocacaoSmsJob.php`
- **Namespace Declaração:** `App\Jobs\ConvocacaoSms`
- **Entidade / Classe:** `final class EnviarConvocacaoSmsJob implements ShouldQueue`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(public readonly int $envioId)
public function handle(ConvocacaoSmsProcessamentoService $service): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Jobs\ConvocacaoSms;

use App\Services\ConvocacaoSms\ConvocacaoSmsProcessamentoService;
use App\Services\ConvocacaoSms\TextBeeSmsCadenciaIndisponivelException;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

final class EnviarConvocacaoSmsJob implements ShouldQueue
{
    use Queueable;

    public int $tries = 1;

    public function __construct(public readonly int $envioId)
    {
        $this->onConnection('database');
        $this->onQueue('convocacoes-sms');
    }

    public function handle(ConvocacaoSmsProcessamentoService $service): void
    {
        try {
            $adiarSegundos = $service->processar($this->envioId);
        } catch (TextBeeSmsCadenciaIndisponivelException) {
            self::dispatch($this->envioId)->delay(5);

            return;
        }

        if ($adiarSegundos > 0) {
            self::dispatch($this->envioId)->delay($adiarSegundos);
        }
    }
}
```
</APP_JOBS_CONVOCACAOSMS_ENVIARCONVOCACAOSMSJOB_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsDashboardRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSDASHBOARDREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsDashboardRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsDashboardRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function resumoPopulacao(ConvocacaoSmsContexto $contexto, string $zona): array;
public function resumoEnvios(ConvocacaoSmsContexto $contexto, array $filtros): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;

interface ConvocacaoSmsDashboardRepositoryInterface
{
    /** @return array{pessoas_nomeadas:int,confirmacoes_convoca_mais:int,nao_confirmados_convoca_mais:int} */
    public function resumoPopulacao(ConvocacaoSmsContexto $contexto, string $zona): array;

    /**
     * @param  array{zona?:string,data_inicial?:string,data_final?:string}  $filtros
     * @return array{
     *     enviados:int,
     *     entregues:int,
     *     nao_entregues:int,
     *     confirmados_ja_comunicados:int,
     *     confirmados_ja_comunicados_titulo_net:int,
     *     confirmados_ja_comunicados_presencial:int,
     *     por_situacao:array<int, array{codigo:string,rotulo:string,total:int}>,
     *     evolucao_diaria:array<int, array{data:string,enviados:int,entregues:int,nao_entregues:int}>,
     *     por_zona:array<int, array{zona:string,entregues:int,nao_entregues:int}>
     * }
     */
    public function resumoEnvios(ConvocacaoSmsContexto $contexto, array $filtros): array;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSDASHBOARDREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsDestinatarioRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSDESTINATARIOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsDestinatarioRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsDestinatarioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(array $filtros, ConvocacaoSmsContexto $contexto, string $paginacaoPath, int $porPagina = 50): LengthAwarePaginator;
public function buscarPorInscricoes(array $inscricoes, string $zona, ConvocacaoSmsContexto $contexto): array;
public function listarParaExportacao(array $filtros, ConvocacaoSmsContexto $contexto): array;
public function listarTerritorios(ConvocacaoSmsContexto $contexto): array;
public function listarTurmasTreinamento(ConvocacaoSmsContexto $contexto, ?string $zona = null): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface ConvocacaoSmsDestinatarioRepositoryInterface
{
    /** @param array<string, mixed> $filtros */
    public function listar(array $filtros, ConvocacaoSmsContexto $contexto, string $paginacaoPath, int $porPagina = 50): LengthAwarePaginator;

    /**
     * @param  array<int, string>  $inscricoes
     * @return array<string, array<string, mixed>>
     */
    public function buscarPorInscricoes(array $inscricoes, string $zona, ConvocacaoSmsContexto $contexto): array;

    /** @param array<string, mixed> $filtros @return array<int, array<string, mixed>> */
    public function listarParaExportacao(array $filtros, ConvocacaoSmsContexto $contexto): array;

    /** @return array{zonas:array<int, string>,municipios:array<int, array{zona:string,municipio:string}>} */
    public function listarTerritorios(ConvocacaoSmsContexto $contexto): array;

    /**
     * @return array<int, array{
     *     id:int,
     *     nom_turma:string,
     *     num_turma:int,
     *     num_zona:int,
     *     dat_hora_inicio_treinamento:mixed,
     *     dat_hora_fim_treinamento:mixed
     * }>
     */
    public function listarTurmasTreinamento(ConvocacaoSmsContexto $contexto, ?string $zona = null): array;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSDESTINATARIOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsEnvioRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSENVIOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsEnvioRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsEnvioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarLotePorUuid(string $uuid, int $macroprojetoTurnoId): ?array;
public function criarLote(array $dados): int;
public function removerLoteVazio(int $id): bool;
public function registrarItemLote(array $dados): int;
public function reservarEnvio(array $dados): ?int;
public function atualizarTotaisLote(int $loteId, int $selecionados, int $enfileirados, int $ignorados): void;
public function buscarEnvio(int $id): ?array;
public function reivindicarProcessamento(int $id): bool;
public function cancelarAntesEnvio(int $id, string $codigo, string $detalhe): void;
public function registrarAceite(int $id, string $provedor, string $providerBatchId, ?string $deviceId, ?int $simSubscriptionId): void;
public function registrarRejeicao(int $id, ?string $codigo, ?string $detalhe): void;
public function registrarIndeterminado(int $id, string $codigo, string $detalhe): void;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface ConvocacaoSmsEnvioRepositoryInterface
{
    /** @return array<string, mixed>|null */
    public function buscarLotePorUuid(string $uuid, int $macroprojetoTurnoId): ?array;

    /** @param array<string, mixed> $dados */
    public function criarLote(array $dados): int;

    public function removerLoteVazio(int $id): bool;

    /** @param array<string, mixed> $dados */
    public function registrarItemLote(array $dados): int;

    /** @param array<string, mixed> $dados */
    public function reservarEnvio(array $dados): ?int;

    public function atualizarTotaisLote(int $loteId, int $selecionados, int $enfileirados, int $ignorados): void;

    /** @return array<string, mixed>|null */
    public function buscarEnvio(int $id): ?array;

    public function reivindicarProcessamento(int $id): bool;

    public function cancelarAntesEnvio(int $id, string $codigo, string $detalhe): void;

    public function registrarAceite(int $id, string $provedor, string $providerBatchId, ?string $deviceId, ?int $simSubscriptionId): void;

    public function registrarRejeicao(int $id, ?string $codigo, ?string $detalhe): void;

    public function registrarIndeterminado(int $id, string $codigo, string $detalhe): void;

    public function prepararReenvio(int $id, ConvocacaoSmsContexto $contexto): bool;

    /** @return array<string, mixed>|null */
    public function buscarPorMensagemProvedor(string $provedor, string $providerMessageId): ?array;

    /** @return array<string, mixed>|null */
    public function buscarPorLoteProvedor(string $provedor, string $providerBatchId): ?array;

    public function aplicarEventoProvedor(int $id, string $provedor, string $eventoId, ?string $providerMessageId, string $statusAnterior, string $statusNovo, string $statusProvedor, ?string $erroCodigo, ?string $erroDetalhe, ?int $timestamp): bool;

    /** @param array<string, mixed> $filtros */
    public function listarHistorico(array $filtros, ConvocacaoSmsContexto $contexto, string $path, int $porPagina = 50): LengthAwarePaginator;

    /** @param array<string, mixed> $filtros @return array<int, array<string, mixed>> */
    public function listarHistoricoParaExportacao(array $filtros, ConvocacaoSmsContexto $contexto): array;

    /** @return array<string, mixed>|null */
    public function buscarDetalhe(int $id, ConvocacaoSmsContexto $contexto): ?array;

    public function marcarProcessamentosExpirados(int $minutos): int;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSENVIOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsProcessamentoRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSPROCESSAMENTOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsProcessamentoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsProcessamentoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarEnvio(int $id): ?array;
public function reivindicarProcessamento(int $id): bool;
public function restaurarPendenteForaJanela(int $id): bool;
public function cancelarAntesEnvio(int $id, string $codigo, string $detalhe): void;
public function registrarAceite(int $id, string $provedor, string $providerBatchId, ?string $deviceId, ?int $simSubscriptionId): void;
public function registrarRejeicao(int $id, ?string $codigo, ?string $detalhe): void;
public function registrarIndeterminado(int $id, string $codigo, string $detalhe): void;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

interface ConvocacaoSmsProcessamentoRepositoryInterface
{
    /** @return array<string, mixed>|null */
    public function buscarEnvio(int $id): ?array;

    public function reivindicarProcessamento(int $id): bool;

    public function restaurarPendenteForaJanela(int $id): bool;

    public function cancelarAntesEnvio(int $id, string $codigo, string $detalhe): void;

    public function registrarAceite(int $id, string $provedor, string $providerBatchId, ?string $deviceId, ?int $simSubscriptionId): void;

    public function registrarRejeicao(int $id, ?string $codigo, ?string $detalhe): void;

    public function registrarIndeterminado(int $id, string $codigo, string $detalhe): void;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSPROCESSAMENTOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsRecuperacaoRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSRECUPERACAOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsRecuperacaoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsRecuperacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarFalhasLimiteTextBee(int $maxTentativas): array;
public function prepararReenvioFalhaLimiteTextBee(int $id, int $maxTentativas): bool;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

interface ConvocacaoSmsRecuperacaoRepositoryInterface
{
    /** @return array<int, array<string, mixed>> */
    public function listarFalhasLimiteTextBee(int $maxTentativas): array;

    public function prepararReenvioFalhaLimiteTextBee(int $id, int $maxTentativas): bool;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSRECUPERACAOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsRespostaRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSRESPOSTAREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsRespostaRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsRespostaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarEnviosAnterioresCompativeis(string $telefoneE164, string $deviceId, int $timestamp): array;
public function registrarRecebida(array $dados): bool;
public function listarPorEnvioIds(array $enviosIds): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

interface ConvocacaoSmsRespostaRepositoryInterface
{
    /** @return array<int, array<string, mixed>> */
    public function buscarEnviosAnterioresCompativeis(string $telefoneE164, string $deviceId, int $timestamp): array;

    /** @param array<string, mixed> $dados */
    public function registrarRecebida(array $dados): bool;

    /** @param array<int, int> $enviosIds @return array<int, array<int, array<string, mixed>>> */
    public function listarPorEnvioIds(array $enviosIds): array;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSRESPOSTAREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsSincronizacaoRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSSINCRONIZACAOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsSincronizacaoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsSincronizacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarTextBeePendentesSincronizacao(): array;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

interface ConvocacaoSmsSincronizacaoRepositoryInterface
{
    /** @return array<int, array<string, mixed>> */
    public function listarTextBeePendentesSincronizacao(): array;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSSINCRONIZACAOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsTelefoneManualRepositoryInterface.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSTELEFONEMANUALREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsTelefoneManualRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface ConvocacaoSmsTelefoneManualRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function salvar(
public function remover(string $numInscricao): bool;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Contracts;

interface ConvocacaoSmsTelefoneManualRepositoryInterface
{
    public function salvar(
        string $numInscricao,
        string $telefoneNacional,
        string $usuarioLogin,
        string $usuarioNome,
    ): bool;

    public function remover(string $numInscricao): bool;
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONTRACTS_CONVOCACAOSMSTELEFONEMANUALREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/ConvocacaoSmsDashboardRepository.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/ConvocacaoSmsDashboardRepository.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsDashboardRepository implements ConvocacaoSmsDashboardRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('ce_sms_envio as e')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function resumoPopulacao(ConvocacaoSmsContexto $contexto, string $zona): array
public function resumoEnvios(ConvocacaoSmsContexto $contexto, array $filtros): array
private function pessoasPopulacaoQuery(ConvocacaoSmsContexto $contexto, string $zona): Builder
private function pessoasPopulacaoBaseQuery(ConvocacaoSmsContexto $contexto, string $zona): Builder
private function pessoasPopulacaoCanonicaQuery(Builder $base): Builder
private function resumoConfirmadosJaComunicados(ConvocacaoSmsContexto $contexto, string $zona): object
private function enviosQuery(ConvocacaoSmsContexto $contexto, array $filtros): Builder
private function agruparSituacoes(
private function resumoEntregasInferidas(ConvocacaoSmsContexto $contexto, array $filtros): array
private function aplicarEntregasInferidasNaEvolucao(array $evolucao, array $entregasInferidas): array
private function aplicarEntregasInferidasPorZona(array $porZona, array $entregasInferidas): array
private function zonaPermitida(string $zona, ConvocacaoSmsContexto $contexto): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms;

use App\Repositories\ColaboradoresEleitorais\Queries\MesarioConvocadoEfetivoQuery;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDashboardRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Support\ConvocacaoSms\ConvocacaoSmsStatus;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

final class ConvocacaoSmsDashboardRepository implements ConvocacaoSmsDashboardRepositoryInterface
{
    /** @var array<string, string> */
    private const SITUACOES_GRAFICO = [
        'AGUARDANDO' => 'Aguardando envio',
        'EM_TRANSITO' => 'Em trânsito',
        'ENTREGUE' => 'Entregues',
        'NAO_ENTREGUE' => 'Não entregues',
        'FALHA_ANTES_ACEITE' => 'Falha antes do aceite',
        'CANCELADO' => 'Cancelados',
    ];

    public function resumoPopulacao(ConvocacaoSmsContexto $contexto, string $zona): array
    {
        $resumo = DB::query()
            ->fromSub($this->pessoasPopulacaoQuery($contexto, $zona), 'sms_dashboard_pessoas')
            ->selectRaw(<<<'SQL'
COUNT(*) AS pessoas_nomeadas,
NVL(SUM(confirmado_elo), 0) AS confirmacoes_convoca_mais,
COUNT(*) - NVL(SUM(confirmado_elo), 0) AS nao_confirmados_convoca_mais
SQL)
            ->first();

        return [
            'pessoas_nomeadas' => (int) ($resumo->pessoas_nomeadas ?? 0),
            'confirmacoes_convoca_mais' => (int) ($resumo->confirmacoes_convoca_mais ?? 0),
            'nao_confirmados_convoca_mais' => (int) ($resumo->nao_confirmados_convoca_mais ?? 0),
        ];
    }

    public function resumoEnvios(ConvocacaoSmsContexto $contexto, array $filtros): array
    {
        $base = $this->enviosQuery($contexto, $filtros);
        $entregasInferidas = $this->resumoEntregasInferidas($contexto, $filtros);
        $totalEntregasInferidas = array_sum(array_column($entregasInferidas, 'total'));
        $totalNaoEntregasInferidas = array_sum(array_column(array_filter(
            $entregasInferidas,
            static fn (array $item): bool => $item['status_codigo'] === 'NAO_ENTREGUE',
        ), 'total'));
        $totais = (clone $base)
            ->selectRaw(<<<'SQL'
NVL(SUM(CASE
    WHEN e.status_codigo IN ('ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE') THEN 1 ELSE 0
END), 0) AS enviados,
NVL(SUM(CASE WHEN e.status_codigo = 'ENTREGUE' THEN 1 ELSE 0 END), 0) AS entregues,
NVL(SUM(CASE WHEN e.status_codigo = 'NAO_ENTREGUE' THEN 1 ELSE 0 END), 0) AS nao_entregues
SQL)->first();
        $confirmadosJaComunicados = $this->resumoConfirmadosJaComunicados(
            $contexto,
            (string) ($filtros['zona'] ?? ''),
        );

        $situacoes = (clone $base)
            ->select(['e.status_codigo'])
            ->selectRaw('COUNT(*) AS total')
            ->groupBy('e.status_codigo')
            ->get();
        $evolucao = (clone $base)
            ->selectRaw(<<<'SQL'
TO_CHAR(TRUNC(e.dt_criacao), 'YYYY-MM-DD') AS data,
NVL(SUM(CASE
    WHEN e.status_codigo IN ('ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE') THEN 1 ELSE 0
END), 0) AS enviados,
NVL(SUM(CASE WHEN e.status_codigo = 'ENTREGUE' THEN 1 ELSE 0 END), 0) AS entregues,
NVL(SUM(CASE WHEN e.status_codigo = 'NAO_ENTREGUE' THEN 1 ELSE 0 END), 0) AS nao_entregues
SQL)
            ->groupByRaw('TRUNC(e.dt_criacao)')
            ->orderByRaw('TRUNC(e.dt_criacao)')
            ->get()
            ->map(static fn (object $item): array => [
                'data' => trim((string) ($item->data ?? '')),
                'enviados' => (int) ($item->enviados ?? 0),
                'entregues' => (int) ($item->entregues ?? 0),
                'nao_entregues' => (int) ($item->nao_entregues ?? 0),
            ])->all();
        $evolucao = $this->aplicarEntregasInferidasNaEvolucao($evolucao, $entregasInferidas);
        $porZona = (clone $base)
            ->selectRaw(<<<'SQL'
TRIM(e.num_zona) AS zona,
NVL(SUM(CASE WHEN e.status_codigo = 'ENTREGUE' THEN 1 ELSE 0 END), 0) AS entregues,
NVL(SUM(CASE WHEN e.status_codigo = 'NAO_ENTREGUE' THEN 1 ELSE 0 END), 0) AS nao_entregues
SQL)
            ->groupByRaw('TRIM(e.num_zona)')
            ->orderByRaw("TO_NUMBER(REGEXP_REPLACE(TRIM(e.num_zona), '[^0-9]', '')) NULLS LAST")
            ->get()
            ->map(static fn (object $item): array => [
                'zona' => trim((string) ($item->zona ?? '')),
                'entregues' => (int) ($item->entregues ?? 0),
                'nao_entregues' => (int) ($item->nao_entregues ?? 0),
            ])->all();
        $porZona = $this->aplicarEntregasInferidasPorZona($porZona, $entregasInferidas);

        return [
            'enviados' => (int) ($totais->enviados ?? 0),
            'entregues' => (int) ($totais->entregues ?? 0) + $totalEntregasInferidas,
            'nao_entregues' => max(
                0,
                (int) ($totais->nao_entregues ?? 0) - $totalNaoEntregasInferidas,
            ),
            'confirmados_ja_comunicados' => (int) ($confirmadosJaComunicados->total ?? 0),
            'confirmados_ja_comunicados_titulo_net' => (int) ($confirmadosJaComunicados->titulo_net ?? 0),
            'confirmados_ja_comunicados_presencial' => (int) ($confirmadosJaComunicados->presencial ?? 0),
            'por_situacao' => $this->agruparSituacoes(
                $situacoes,
                $totalEntregasInferidas,
                $totalNaoEntregasInferidas,
            ),
            'evolucao_diaria' => $evolucao,
            'por_zona' => $porZona,
        ];
    }

    private function pessoasPopulacaoQuery(ConvocacaoSmsContexto $contexto, string $zona): Builder
    {
        return $this->pessoasPopulacaoCanonicaQuery(
            $this->pessoasPopulacaoBaseQuery($contexto, $zona),
        );
    }

    private function pessoasPopulacaoBaseQuery(ConvocacaoSmsContexto $contexto, string $zona): Builder
    {
        $zona = trim($zona);

        return MesarioConvocadoEfetivoQuery::criar(
            '',
            $zona,
            '',
            $contexto->acessoTodasZonas,
            $contexto->zonasPermitidas,
            $zona !== '' && ! $this->zonaPermitida($zona, $contexto),
            somenteNomeados: true,
            codPleito: $contexto->codPleito,
            dataEleicao: $contexto->dataEleicao,
            incluirPerfil: false,
            buscaSomenteNomeOuInscricao: true,
            incluirSemLocal: true,
        )
            ->whereNotNull('c.num_inscricao')
            ->addSelect([
                DB::raw('UPPER(TRIM(c.des_ind_confirmou_presenca)) AS resposta_elo'),
                DB::raw('UPPER(TRIM(c.des_tip_origem_resposta_conv)) AS origem_resposta_elo'),
                DB::raw('c.dat_resposta_convocacao AS data_resposta_elo_ordenacao'),
                DB::raw('c.id_convocacao_mesario_tse AS resposta_elo_id'),
            ]);
    }

    private function pessoasPopulacaoCanonicaQuery(Builder $base): Builder
    {
        $canonicas = DB::query()
            ->fromSub($base, 'sms_dashboard_populacao_base')
            ->select(['num_zona', 'num_inscricao'])
            ->selectRaw(<<<'SQL'
MAX(CASE WHEN resposta_elo = 'SIM' THEN 1 ELSE 0 END) OVER (
    PARTITION BY num_zona, num_inscricao
) AS confirmado_elo,
FIRST_VALUE(origem_resposta_elo) OVER (
    PARTITION BY num_zona, num_inscricao
    ORDER BY CASE WHEN resposta_elo = 'SIM' THEN 0 ELSE 1 END,
        data_resposta_elo_ordenacao DESC NULLS LAST,
        resposta_elo_id DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS origem_confirmacao_elo
SQL);

        return DB::query()
            ->fromSub($canonicas, 'sms_dashboard_populacao_canonica')
            ->select(['num_zona', 'num_inscricao', 'confirmado_elo', 'origem_confirmacao_elo'])
            ->distinct();
    }

    private function resumoConfirmadosJaComunicados(ConvocacaoSmsContexto $contexto, string $zona): object
    {
        $base = $this->pessoasPopulacaoBaseQuery($contexto, $zona)
            ->leftJoin('ce_sms_envio as sms_envio_atual', function ($join) use ($contexto): void {
                $join->whereRaw('TRIM(sms_envio_atual.num_inscricao) = TRIM(c.num_inscricao)')
                    ->where('sms_envio_atual.macroprojeto_turno_id', $contexto->macroprojetoTurnoId)
                    ->where('sms_envio_atual.status_codigo', '<>', 'CANCELADO_ANTES_ENVIO')
                    ->whereRaw(<<<'SQL'
sms_envio_atual.id = (
    SELECT MAX(sms_envio_recente.id)
      FROM ce_sms_envio sms_envio_recente
     WHERE TRIM(sms_envio_recente.num_inscricao) = TRIM(c.num_inscricao)
       AND sms_envio_recente.macroprojeto_turno_id = sms_envio_atual.macroprojeto_turno_id
       AND sms_envio_recente.status_codigo <> 'CANCELADO_ANTES_ENVIO'
)
SQL);
            })
            ->whereIn('sms_envio_atual.status_codigo', ConvocacaoSmsStatus::JA_COMUNICADOS);
        $confirmados = $this->pessoasPopulacaoCanonicaQuery($base)
            ->where('confirmado_elo', 1)
            ->select(['num_zona', 'num_inscricao', 'origem_confirmacao_elo']);

        return DB::query()
            ->fromSub($confirmados, 'sms_dashboard_confirmados')
            ->selectRaw(<<<'SQL'
COUNT(*) AS total,
NVL(SUM(CASE
    WHEN origem_confirmacao_elo IN ('TITULONET', 'TITULO NET', 'TÍTULO NET') THEN 1 ELSE 0
END), 0) AS titulo_net,
NVL(SUM(CASE WHEN origem_confirmacao_elo = 'PRESENCIAL' THEN 1 ELSE 0 END), 0) AS presencial
SQL)
            ->first() ?? (object) ['total' => 0, 'titulo_net' => 0, 'presencial' => 0];
    }

    /** @param array{zona?:string,data_inicial?:string,data_final?:string} $filtros */
    private function enviosQuery(ConvocacaoSmsContexto $contexto, array $filtros): Builder
    {
        $zona = trim((string) ($filtros['zona'] ?? ''));
        $query = DB::table('ce_sms_envio as e')
            ->join('ce_sms_lote as l', 'l.id', '=', 'e.lote_id')
            ->where('e.macroprojeto_turno_id', $contexto->macroprojetoTurnoId);
        if ($zona !== '') {
            $this->zonaPermitida($zona, $contexto)
                ? $query->where('e.num_zona', $zona)
                : $query->whereRaw('1 = 0');
        } elseif (! $contexto->acessoTodasZonas) {
            $contexto->zonasPermitidas === []
                ? $query->whereRaw('1 = 0')
                : $query->whereIn('e.num_zona', $contexto->zonasPermitidas);
        }
        if (! $contexto->gestor && ! $contexto->administrador) {
            $query->whereRaw('UPPER(l.usuario_login) = ?', [
                mb_strtoupper($contexto->usuarioLogin, 'UTF-8'),
            ]);
        }

        $dataInicial = trim((string) ($filtros['data_inicial'] ?? ''));
        if ($dataInicial !== '') {
            $query->where('e.dt_criacao', '>=', Carbon::createFromFormat('!Y-m-d', $dataInicial));
        }
        $dataFinal = trim((string) ($filtros['data_final'] ?? ''));
        if ($dataFinal !== '') {
            $query->where('e.dt_criacao', '<', Carbon::createFromFormat('!Y-m-d', $dataFinal)->addDay());
        }

        return $query;
    }

    /** @param iterable<int, object> $situacoes @return array<int, array{codigo:string,rotulo:string,total:int}> */
    private function agruparSituacoes(
        iterable $situacoes,
        int $entregasInferidas = 0,
        int $naoEntregasInferidas = 0,
    ): array {
        $totais = array_fill_keys(array_keys(self::SITUACOES_GRAFICO), 0);
        foreach ($situacoes as $situacao) {
            $codigo = match (mb_strtoupper(trim((string) ($situacao->status_codigo ?? '')), 'UTF-8')) {
                'PENDENTE', 'PROCESSANDO' => 'AGUARDANDO',
                'ACEITO', 'ENVIADO' => 'EM_TRANSITO',
                'ENTREGUE' => 'ENTREGUE',
                'NAO_ENTREGUE' => 'NAO_ENTREGUE',
                'REJEITADO', 'INDETERMINADO' => 'FALHA_ANTES_ACEITE',
                'CANCELADO_ANTES_ENVIO' => 'CANCELADO',
                default => null,
            };
            if ($codigo !== null) {
                $totais[$codigo] += (int) ($situacao->total ?? 0);
            }
        }
        $totais['EM_TRANSITO'] = max(
            0,
            $totais['EM_TRANSITO'] - ($entregasInferidas - $naoEntregasInferidas),
        );
        $totais['NAO_ENTREGUE'] = max(0, $totais['NAO_ENTREGUE'] - $naoEntregasInferidas);
        $totais['ENTREGUE'] += $entregasInferidas;

        $resultado = [];
        foreach (self::SITUACOES_GRAFICO as $codigo => $rotulo) {
            $resultado[] = ['codigo' => $codigo, 'rotulo' => $rotulo, 'total' => $totais[$codigo]];
        }

        return $resultado;
    }

    /**
     * @param  array{zona?:string,data_inicial?:string,data_final?:string}  $filtros
     * @return array<int, array{data:string,zona:string,status_codigo:string,total:int}>
     */
    private function resumoEntregasInferidas(ConvocacaoSmsContexto $contexto, array $filtros): array
    {
        $zona = trim((string) ($filtros['zona'] ?? ''));

        return $this->enviosQuery($contexto, $filtros)
            ->joinSub($this->pessoasPopulacaoQuery($contexto, $zona), 'sms_dashboard_confirmacao', function ($join): void {
                $join->whereRaw('TRIM(sms_dashboard_confirmacao.num_inscricao) = TRIM(e.num_inscricao)')
                    ->whereRaw('TRIM(sms_dashboard_confirmacao.num_zona) = TRIM(e.num_zona)');
            })
            ->whereIn('e.status_codigo', ['ENVIADO', 'NAO_ENTREGUE'])
            ->where('sms_dashboard_confirmacao.confirmado_elo', 1)
            ->selectRaw("TO_CHAR(TRUNC(e.dt_criacao), 'YYYY-MM-DD') AS data")
            ->selectRaw('TRIM(e.num_zona) AS zona')
            ->selectRaw('UPPER(TRIM(e.status_codigo)) AS status_codigo')
            ->selectRaw('COUNT(*) AS total')
            ->groupByRaw('TRUNC(e.dt_criacao), TRIM(e.num_zona), UPPER(TRIM(e.status_codigo))')
            ->get()
            ->map(static fn (object $item): array => [
                'data' => trim((string) ($item->data ?? '')),
                'zona' => trim((string) ($item->zona ?? '')),
                'status_codigo' => trim((string) ($item->status_codigo ?? '')),
                'total' => (int) ($item->total ?? 0),
            ])->all();
    }

    /**
     * @param  array<int, array{data:string,enviados:int,entregues:int,nao_entregues:int}>  $evolucao
     * @param  array<int, array{data:string,zona:string,status_codigo:string,total:int}>  $entregasInferidas
     * @return array<int, array{data:string,enviados:int,entregues:int,nao_entregues:int}>
     */
    private function aplicarEntregasInferidasNaEvolucao(array $evolucao, array $entregasInferidas): array
    {
        $porData = [];
        foreach ($entregasInferidas as $item) {
            $porData[$item['data']] ??= ['entregues' => 0, 'nao_entregues' => 0];
            $porData[$item['data']]['entregues'] += $item['total'];
            if ($item['status_codigo'] === 'NAO_ENTREGUE') {
                $porData[$item['data']]['nao_entregues'] += $item['total'];
            }
        }
        foreach ($evolucao as &$item) {
            $inferidas = $porData[$item['data']] ?? ['entregues' => 0, 'nao_entregues' => 0];
            $item['entregues'] += $inferidas['entregues'];
            $item['nao_entregues'] = max(0, $item['nao_entregues'] - $inferidas['nao_entregues']);
        }
        unset($item);

        return $evolucao;
    }

    /**
     * @param  array<int, array{zona:string,entregues:int,nao_entregues:int}>  $porZona
     * @param  array<int, array{data:string,zona:string,status_codigo:string,total:int}>  $entregasInferidas
     * @return array<int, array{zona:string,entregues:int,nao_entregues:int}>
     */
    private function aplicarEntregasInferidasPorZona(array $porZona, array $entregasInferidas): array
    {
        $inferidasPorZona = [];
        foreach ($entregasInferidas as $item) {
            $inferidasPorZona[$item['zona']] ??= ['entregues' => 0, 'nao_entregues' => 0];
            $inferidasPorZona[$item['zona']]['entregues'] += $item['total'];
            if ($item['status_codigo'] === 'NAO_ENTREGUE') {
                $inferidasPorZona[$item['zona']]['nao_entregues'] += $item['total'];
            }
        }
        foreach ($porZona as &$item) {
            $inferidas = $inferidasPorZona[$item['zona']] ?? ['entregues' => 0, 'nao_entregues' => 0];
            $item['entregues'] += $inferidas['entregues'];
            $item['nao_entregues'] = max(0, $item['nao_entregues'] - $inferidas['nao_entregues']);
        }
        unset($item);

        return $porZona;
    }

    private function zonaPermitida(string $zona, ConvocacaoSmsContexto $contexto): bool
    {
        return $contexto->acessoTodasZonas || in_array(trim($zona), $contexto->zonasPermitidas, true);
    }
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/ConvocacaoSmsDestinatarioRepository.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSDESTINATARIOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/ConvocacaoSmsDestinatarioRepository.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsDestinatarioRepository implements ConvocacaoSmsDestinatarioRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table(LocalVotacaoCatalogo::EFETIVOS)
$query = DB::table('VW_VOLUNTARIO_PERFIL_EFETIVO as v')
$modelos = DB::table('ce_sms_envio as sms_historico')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function listar(array $filtros, ConvocacaoSmsContexto $contexto, string $paginacaoPath, int $porPagina = 50): LengthAwarePaginator
public function buscarPorInscricoes(array $inscricoes, string $zona, ConvocacaoSmsContexto $contexto): array
public function listarParaExportacao(array $filtros, ConvocacaoSmsContexto $contexto): array
public function listarTerritorios(ConvocacaoSmsContexto $contexto): array
public function listarTurmasTreinamento(ConvocacaoSmsContexto $contexto, ?string $zona = null): array
private function itensFiltrados(array $filtros, ConvocacaoSmsContexto $contexto): array
private function linhasQuery(
private function listarPorSituacaoTelefone(
private function aplicarFiltroSituacaoBanco(Builder $query, string $situacao): void
private function contarDestinatarios(
private function aplicarPerfis(iterable $linhas, array $perfis): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms;

use App\Repositories\ColaboradoresEleitorais\Queries\MesarioConvocadoEfetivoQuery;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Queries\ConvocacaoSmsDestinatarioPaginadoQuery;
use App\Repositories\ConvocacaoSms\Queries\ConvocacaoSmsTurmaTreinamentoQuery;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Services\ConvocacaoSms\ConvocacaoSmsDestinatarioAgrupador;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\ConvocacaoSmsTelefone;
use App\Support\LocaisVotacao\LocalVotacaoCatalogo;
use App\Support\Treinamentos\EscopoZonalTurmaTse;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Pagination\LengthAwarePaginator as Paginator;
use Illuminate\Support\Facades\DB;

final class ConvocacaoSmsDestinatarioRepository implements ConvocacaoSmsDestinatarioRepositoryInterface
{
    public function __construct(
        private readonly ConvocacaoSmsDestinatarioAgrupador $agrupador,
        private readonly ConvocacaoSmsTelefone $telefones,
        private readonly ConvocacaoSmsStatusService $status,
        private readonly EscopoZonalTurmaTse $escopoZonalTurma,
    ) {}

    public function listar(array $filtros, ConvocacaoSmsContexto $contexto, string $paginacaoPath, int $porPagina = 50): LengthAwarePaginator
    {
        $pagina = max(1, Paginator::resolveCurrentPage());
        $porPagina = max(1, min(50, $porPagina));
        $situacao = $this->situacaoFiltro($filtros);
        if ($this->situacaoDependeDoTelefone($situacao)) {
            return $this->listarPorSituacaoTelefone(
                $filtros,
                $contexto,
                $paginacaoPath,
                $pagina,
                $porPagina,
                $situacao,
            );
        }

        $base = $this->linhasQuery($filtros, $contexto, false, true)
            ->whereNotNull('c.num_inscricao');
        $this->aplicarFiltroSituacaoBanco($base, $situacao);
        $confirmacaoElo = $this->confirmacaoEloFiltro($filtros);

        $inicio = (($pagina - 1) * $porPagina) + 1;
        $fim = $pagina * $porPagina;
        $linhas = ConvocacaoSmsDestinatarioPaginadoQuery::criar(
            clone $base,
            $inicio,
            $fim,
            $confirmacaoElo,
            $situacao,
        )->get();
        $total = $linhas->isNotEmpty()
            ? (int) ($linhas->first()->destinatarios_total ?? 0)
            : $this->contarDestinatarios($base, $confirmacaoElo, $situacao);
        $perfis = $this->buscarPerfis($linhas->pluck('num_inscricao')->all());
        $itens = $this->completarItensContexto(
            $this->agrupador->agrupar($this->aplicarPerfis($linhas, $perfis)),
            $contexto,
        );

        return new Paginator($itens, $total, $porPagina, $pagina, [
            'path' => $paginacaoPath,
            'pageName' => 'page',
        ]);
    }

    public function buscarPorInscricoes(array $inscricoes, string $zona, ConvocacaoSmsContexto $contexto): array
    {
        $normalizadas = collect($inscricoes)
            ->map(static fn (mixed $valor): string => trim((string) $valor))
            ->filter()
            ->unique()
            ->values()
            ->all();
        if ($normalizadas === [] || count($normalizadas) > 50 || ! $this->zonaPermitida($zona, $contexto)) {
            return [];
        }

        $query = $this->linhasQuery(['zona' => $zona], $contexto)
            ->whereIn(DB::raw('TRIM(c.num_inscricao)'), $normalizadas);
        $itens = $this->completarItensContexto(
            $this->agrupador->agrupar($query->get()),
            $contexto,
        );

        $porInscricao = [];
        foreach ($itens as $item) {
            $porInscricao[(string) $item['num_inscricao']] = $item;
        }

        return $porInscricao;
    }

    public function listarParaExportacao(array $filtros, ConvocacaoSmsContexto $contexto): array
    {
        return $this->itensFiltrados($filtros, $contexto);
    }

    public function listarTerritorios(ConvocacaoSmsContexto $contexto): array
    {
        $query = DB::table(LocalVotacaoCatalogo::EFETIVOS)
            ->selectRaw(<<<'SQL'
TRIM(cod_objeto_zona) AS zona,
TRIM(nom_localidade) AS municipio,
TO_NUMBER(REGEXP_REPLACE(TRIM(cod_objeto_zona), '[^0-9]', '')) AS zona_ordem,
UPPER(TRIM(nom_localidade)) AS municipio_ordem
SQL)
            ->whereNotNull('cod_objeto_zona')
            ->whereNotNull('nom_localidade')
            ->distinct();
        if (! $contexto->acessoTodasZonas) {
            if ($contexto->zonasPermitidas === []) {
                return ['zonas' => [], 'municipios' => []];
            }
            $query->whereIn(DB::raw('TRIM(cod_objeto_zona)'), $contexto->zonasPermitidas);
        }

        $linhas = $query
            ->orderBy('zona_ordem')
            ->orderBy('municipio_ordem')
            ->get();

        return [
            'zonas' => $linhas->pluck('zona')->map(static fn ($zona): string => trim((string) $zona))->filter()->unique()->values()->all(),
            'municipios' => $linhas->map(static fn ($item): array => [
                'zona' => trim((string) ($item->zona ?? '')),
                'municipio' => trim((string) ($item->municipio ?? '')),
            ])->filter(static fn (array $item): bool => $item['zona'] !== '' && $item['municipio'] !== '')->values()->all(),
        ];
    }

    public function listarTurmasTreinamento(ConvocacaoSmsContexto $contexto, ?string $zona = null): array
    {
        $zonasEfetivas = $this->zonasEfetivasTurma($contexto, $zona);

        return ConvocacaoSmsTurmaTreinamentoQuery::catalogo(
            $contexto->macroprojetoId,
            $zonasEfetivas,
        )->get()->map(static fn (object $turma): array => [
            'id' => (int) $turma->id,
            'nom_turma' => trim((string) $turma->nom_turma),
            'num_turma' => (int) $turma->num_turma,
            'num_zona' => (int) $turma->num_zona,
            'dat_hora_inicio_treinamento' => $turma->dat_hora_inicio_treinamento,
            'dat_hora_fim_treinamento' => $turma->dat_hora_fim_treinamento,
        ])->all();
    }

    /** @param array<string, mixed> $filtros @return array<int, array<string, mixed>> */
    private function itensFiltrados(array $filtros, ConvocacaoSmsContexto $contexto): array
    {
        $itens = $this->completarItensContexto(
            $this->agrupador->agrupar($this->linhasQuery($filtros, $contexto, true, true)->get()),
            $contexto,
            false,
        );
        $situacao = mb_strtoupper(trim((string) ($filtros['situacao'] ?? '')), 'UTF-8');
        if ($situacao !== '') {
            $itens = array_values(array_filter(
                $itens,
                fn (array $item): bool => $this->status->correspondeFiltroDestinatario(
                    $situacao,
                    (string) ($item['status_codigo'] ?? ''),
                    (string) ($item['situacao_comunicacao'] ?? ''),
                    ($item['confirmacao_elo_codigo'] ?? '') === 'CONFIRMADO',
                ),
            ));
        }
        $confirmacaoElo = $this->confirmacaoEloFiltro($filtros);
        if ($confirmacaoElo !== '') {
            $itens = array_values(array_filter(
                $itens,
                static fn (array $item): bool => ($item['confirmacao_elo_filtro'] ?? '') === $confirmacaoElo,
            ));
        }

        usort($itens, static fn (array $a, array $b): int => strnatcasecmp(
            implode('|', [(string) $a['zona'], (string) $a['municipio'], (string) $a['nome'], (string) $a['num_inscricao']]),
            implode('|', [(string) $b['zona'], (string) $b['municipio'], (string) $b['nome'], (string) $b['num_inscricao']]),
        ));

        return $itens;
    }

    /** @param array<string, mixed> $filtros */
    private function linhasQuery(
        array $filtros,
        ConvocacaoSmsContexto $contexto,
        bool $incluirPerfil = true,
        bool $buscaSomenteNomeOuInscricao = false,
    ): Builder {
        $zona = trim((string) ($filtros['zona'] ?? ''));
        $zonaInvalida = $zona !== '' && ! $this->zonaPermitida($zona, $contexto);
        $query = MesarioConvocadoEfetivoQuery::criar(
            trim((string) ($filtros['q'] ?? '')),
            $zona,
            trim((string) ($filtros['municipio'] ?? '')),
            $contexto->acessoTodasZonas,
            $contexto->zonasPermitidas,
            $zonaInvalida,
            somenteNomeados: true,
            codPleito: $contexto->codPleito,
            dataEleicao: $contexto->dataEleicao,
            funcao: trim((string) ($filtros['funcao'] ?? '')),
            incluirPerfil: $incluirPerfil,
            buscaSomenteNomeOuInscricao: $buscaSomenteNomeOuInscricao,
            incluirSemLocal: true,
        );
        $turmaId = (int) ($filtros['turma_id'] ?? 0);
        if ($turmaId > 0) {
            ConvocacaoSmsTurmaTreinamentoQuery::aplicarFiltro(
                $query,
                $turmaId,
                $contexto->macroprojetoId,
                $this->zonasEfetivasTurma($contexto, $zona),
            );
        }

        $query->leftJoin('ce_sms_telefone_manual as sms_telefone_manual', function ($join): void {
            $join->whereRaw('TRIM(sms_telefone_manual.num_inscricao) = TRIM(c.num_inscricao)');
        })->addSelect([
            'sms_telefone_manual.telefone_nacional as telefone_manual',
            'c.tip_tel_eleitor as tip_tel_eleitor',
            'c.tip_tel_eleitor2 as tip_tel_eleitor2',
            'c.tip_telefone as tip_telefone',
            'c.tip_telefone_comercial as tip_telefone_comercial',
        ]);
        $query->addSelect([
            DB::raw('UPPER(TRIM(c.des_ind_confirmou_presenca)) AS resposta_elo'),
            DB::raw('UPPER(TRIM(c.des_tip_origem_resposta_conv)) AS origem_resposta_elo'),
            DB::raw("TO_CHAR(c.dat_convocacao, 'YYYY-MM-DD HH24:MI:SS') AS data_convocacao_elo"),
            DB::raw("TO_CHAR(c.dat_resposta_convocacao, 'YYYY-MM-DD HH24:MI:SS') AS data_resposta_elo"),
        ]);

        $query->leftJoin('ce_sms_envio as sms_envio', function ($join) use ($contexto): void {
            $join->whereRaw('TRIM(sms_envio.num_inscricao) = TRIM(c.num_inscricao)')
                ->where('sms_envio.macroprojeto_turno_id', $contexto->macroprojetoTurnoId)
                ->where('sms_envio.status_codigo', '<>', 'CANCELADO_ANTES_ENVIO')
                ->whereRaw(<<<'SQL'
sms_envio.id = (
    SELECT MAX(sms_envio_recente.id)
      FROM ce_sms_envio sms_envio_recente
     WHERE TRIM(sms_envio_recente.num_inscricao) = TRIM(c.num_inscricao)
       AND sms_envio_recente.macroprojeto_turno_id = sms_envio.macroprojeto_turno_id
       AND sms_envio_recente.status_codigo <> 'CANCELADO_ANTES_ENVIO'
)
SQL);
        })->addSelect([
            'sms_envio.id as envio_id',
            'sms_envio.status_codigo as status_codigo',
        ]);

        return $query;
    }

    /** @param array<string, mixed> $filtros */
    private function listarPorSituacaoTelefone(
        array $filtros,
        ConvocacaoSmsContexto $contexto,
        string $paginacaoPath,
        int $pagina,
        int $porPagina,
        string $situacao,
    ): LengthAwarePaginator {
        $query = $this->linhasQuery($filtros, $contexto, false, true)
            ->whereNotNull('c.num_inscricao')
            ->whereNull('sms_envio.status_codigo')
            ->select([])
            ->selectRaw(<<<'SQL'
NVL(TRIM(lv_efetivo.cod_objeto_zona), TRIM(c.num_zona)) AS num_zona,
NVL(TRIM(lv_efetivo.nom_localidade), TRIM(c.nom_localidade)) AS nom_localidade,
TRIM(e.nom_eleitor) AS nom_eleitor,
TRIM(c.num_inscricao) AS num_inscricao,
TRIM(c.des_ind_situacao_pe) AS des_ind_situacao_pe,
TRIM(c.num_tel_eleitor) AS num_tel_eleitor,
TRIM(c.num_tel_eleitor_2) AS num_tel_eleitor_2,
TRIM(c.num_telefone) AS num_telefone,
TRIM(c.num_telefone_comercial) AS num_telefone_comercial,
c.tip_tel_eleitor AS tip_tel_eleitor,
c.tip_tel_eleitor2 AS tip_tel_eleitor2,
c.tip_telefone AS tip_telefone,
c.tip_telefone_comercial AS tip_telefone_comercial,
sms_telefone_manual.telefone_nacional AS telefone_manual,
CAST(NULL AS VARCHAR2(40)) AS telefone_perfil,
UPPER(TRIM(c.des_ind_confirmou_presenca)) AS resposta_elo,
UPPER(TRIM(c.des_tip_origem_resposta_conv)) AS origem_resposta_elo,
TO_CHAR(c.dat_convocacao, 'YYYY-MM-DD HH24:MI:SS') AS data_convocacao_elo,
TO_CHAR(c.dat_resposta_convocacao, 'YYYY-MM-DD HH24:MI:SS') AS data_resposta_elo
SQL)
            ->orderByRaw("TO_NUMBER(REGEXP_REPLACE(NVL(TRIM(lv_efetivo.cod_objeto_zona), TRIM(c.num_zona)), '[^0-9]', '')) NULLS LAST")
            ->orderByRaw("UPPER(NVL(NVL(TRIM(lv_efetivo.nom_localidade), TRIM(c.nom_localidade)), ''))")
            ->orderByRaw('UPPER(NVL(e.nom_eleitor, c.num_inscricao))')
            ->orderByRaw('TRIM(c.num_inscricao)');

        $linhas = $query->get()->map(static fn (object $linha): array => (array) $linha)->all();
        $classificacoes = [];
        foreach ($linhas as $linha) {
            $chave = $this->chaveDestinatario($linha);
            if ($chave === null) {
                continue;
            }
            $classificacoes[$chave] ??= [
                'num_zona' => trim((string) $linha['num_zona']),
                'num_inscricao' => trim((string) $linha['num_inscricao']),
                'possui_celular' => false,
                'confirmado_elo' => false,
            ];
            if ($this->telefones->selecionar($linha) !== null) {
                $classificacoes[$chave]['possui_celular'] = true;
            }
            if (mb_strtoupper(trim((string) ($linha['resposta_elo'] ?? '')), 'UTF-8') === 'SIM') {
                $classificacoes[$chave]['confirmado_elo'] = true;
            }
        }

        $inscricoesSemCelular = array_values(array_unique(array_column(array_filter(
            $classificacoes,
            static fn (array $item): bool => ! $item['possui_celular'],
        ), 'num_inscricao')));
        $perfisClassificacao = $this->buscarPerfis($inscricoesSemCelular);
        foreach ($classificacoes as &$classificacao) {
            if ($classificacao['possui_celular']) {
                continue;
            }
            $perfil = $perfisClassificacao[$classificacao['num_inscricao']] ?? [];
            $classificacao['possui_celular'] = $this->telefones->selecionar($perfil) !== null;
        }
        unset($classificacao);

        $esperaCelular = $situacao === 'A_COMUNICAR';
        $confirmacaoElo = $this->confirmacaoEloFiltro($filtros);
        $elegiveis = array_values(array_filter(
            $classificacoes,
            static fn (array $item): bool => $item['possui_celular'] === $esperaCelular
                && ($confirmacaoElo === '' || $item['confirmado_elo'] === ($confirmacaoElo === 'CONFIRMADO')),
        ));
        $total = count($elegiveis);
        $paginaChaves = array_slice($elegiveis, ($pagina - 1) * $porPagina, $porPagina);
        if ($paginaChaves === []) {
            return new Paginator([], $total, $porPagina, $pagina, [
                'path' => $paginacaoPath,
                'pageName' => 'page',
            ]);
        }

        $detalhes = $this->linhasQuery($filtros, $contexto, false, true)
            ->whereNull('sms_envio.status_codigo');
        $this->aplicarFiltroPares(
            $detalhes,
            $paginaChaves,
            trim((string) ($filtros['zona'] ?? '')),
        );
        $linhasPagina = $detalhes->get();
        $inscricoesPagina = array_column($paginaChaves, 'num_inscricao');
        $perfisPagina = $this->buscarPerfis($inscricoesPagina);
        $itensPorChave = [];
        $itensComContexto = $this->completarItensContexto(
            $this->agrupador->agrupar($this->aplicarPerfis($linhasPagina, $perfisPagina)),
            $contexto,
        );
        foreach ($itensComContexto as $item) {
            $itensPorChave[$item['zona'].'|'.$item['num_inscricao']] = $item;
        }
        $itens = array_values(array_filter(array_map(
            static fn (array $item): ?array => $itensPorChave[$item['num_zona'].'|'.$item['num_inscricao']] ?? null,
            $paginaChaves,
        )));

        return new Paginator($itens, $total, $porPagina, $pagina, [
            'path' => $paginacaoPath,
            'pageName' => 'page',
        ]);
    }

    private function aplicarFiltroSituacaoBanco(Builder $query, string $situacao): void
    {
        if ($situacao === '') {
            return;
        }
        if ($situacao === 'JA_COMUNICADO') {
            $query->whereIn('sms_envio.status_codigo', $this->status->statusJaComunicados());

            return;
        }
        if ($this->status->filtroDestinatarioDependeConfirmacaoElo($situacao)) {
            return;
        }
        if (in_array($situacao, $this->status->statusDestinatarioFiltraveisExatos(), true)) {
            $query->where('sms_envio.status_codigo', $situacao);

            return;
        }

        $query->whereRaw('1 = 0');
    }

    private function contarDestinatarios(
        Builder $base,
        string $confirmacaoElo = '',
        string $situacao = '',
    ): int {
        $filtradas = ConvocacaoSmsDestinatarioPaginadoQuery::filtrarPorPessoa(
            clone $base,
            $confirmacaoElo,
            $situacao,
        );
        $identidades = DB::query()
            ->fromSub($filtradas, 'sms_contagem_canonica')
            ->select(['num_zona', 'num_inscricao'])
            ->distinct();

        return DB::query()->fromSub($identidades, 'sms_identidades')->count();
    }

    /**
     * @param  iterable<int, object|array<string, mixed>>  $linhas
     * @param  array<string, array<string, mixed>>  $perfis
     * @return array<int, array<string, mixed>>
     */
    private function aplicarPerfis(iterable $linhas, array $perfis): array
    {
        $resultado = [];
        foreach ($linhas as $linhaOriginal) {
            $linha = (array) $linhaOriginal;
            $inscricao = trim((string) ($linha['num_inscricao'] ?? ''));
            $perfil = $perfis[$inscricao] ?? [];
            $linha['telefone_perfil'] = $perfil['telefone_perfil'] ?? null;
            $linha['num_cpf'] = $perfil['num_cpf'] ?? ($linha['num_cpf'] ?? null);
            $linha['tamanho_camisa'] = $perfil['tamanho_camisa'] ?? null;
            $resultado[] = $linha;
        }

        return $resultado;
    }

    /** @param array<int, mixed> $inscricoes @return array<string, array<string, mixed>> */
    private function buscarPerfis(array $inscricoes): array
    {
        $normalizadas = collect($inscricoes)
            ->map(static fn (mixed $valor): string => trim((string) $valor))
            ->filter()
            ->unique()
            ->values()
            ->all();
        if ($normalizadas === []) {
            return [];
        }

        $query = DB::table('VW_VOLUNTARIO_PERFIL_EFETIVO as v')
            ->selectRaw(<<<'SQL'
TRIM(v.num_inscricao) AS num_inscricao,
TRIM(v.num_cpf) AS num_cpf,
TRIM(v.telefone) AS telefone_perfil,
TRIM(v.tamanho_camisa) AS tamanho_camisa
SQL)
            ->where(function (Builder $filtro) use ($normalizadas): void {
                foreach (array_chunk($normalizadas, 900) as $indice => $lote) {
                    $metodo = $indice === 0 ? 'whereIn' : 'orWhereIn';
                    $filtro->{$metodo}(DB::raw('TRIM(v.num_inscricao)'), $lote);
                }
            });

        $perfis = [];
        foreach ($query->get() as $perfilOriginal) {
            $perfil = (array) $perfilOriginal;
            $inscricao = trim((string) ($perfil['num_inscricao'] ?? ''));
            if ($inscricao !== '') {
                $perfis[$inscricao] = $perfil;
            }
        }

        return $perfis;
    }

    /** @param array<int, array{num_zona:string,num_inscricao:string,possui_celular:bool}> $pares */
    private function aplicarFiltroPares(Builder $query, array $pares, string $zonaFiltro): void
    {
        $porZona = [];
        foreach ($pares as $par) {
            $porZona[$par['num_zona']][] = $par['num_inscricao'];
        }
        if (count($porZona) === 1 && isset($porZona[$zonaFiltro])) {
            $query->whereIn(DB::raw('TRIM(c.num_inscricao)'), $porZona[$zonaFiltro]);

            return;
        }

        $query->where(function (Builder $filtro) use ($porZona): void {
            foreach ($porZona as $zona => $inscricoes) {
                $filtro->orWhere(function (Builder $item) use ($zona, $inscricoes): void {
                    $item->whereRaw('TRIM(lv_efetivo.cod_objeto_zona) = ?', [$zona])
                        ->whereIn(DB::raw('TRIM(c.num_inscricao)'), $inscricoes);
                });
            }
        });
    }

    /** @param array<string, mixed> $linha */
    private function chaveDestinatario(array $linha): ?string
    {
        $zona = trim((string) ($linha['num_zona'] ?? ''));
        $inscricao = trim((string) ($linha['num_inscricao'] ?? ''));

        return $zona !== '' && $inscricao !== '' ? $zona.'|'.$inscricao : null;
    }

    /** @param array<string, mixed> $filtros */
    private function situacaoFiltro(array $filtros): string
    {
        return mb_strtoupper(trim((string) ($filtros['situacao'] ?? '')), 'UTF-8');
    }

    /** @param array<string, mixed> $filtros */
    private function confirmacaoEloFiltro(array $filtros): string
    {
        $confirmacao = mb_strtoupper(trim((string) ($filtros['confirmacao_elo'] ?? '')), 'UTF-8');

        return in_array($confirmacao, ['CONFIRMADO', 'NAO_CONFIRMADO'], true) ? $confirmacao : '';
    }

    private function situacaoDependeDoTelefone(string $situacao): bool
    {
        return in_array($situacao, ['A_COMUNICAR', 'SEM_CELULAR_VALIDO'], true);
    }

    private function zonaPermitida(string $zona, ConvocacaoSmsContexto $contexto): bool
    {
        $normalizada = trim($zona);

        return $normalizada !== ''
            && ($contexto->acessoTodasZonas || in_array($normalizada, $contexto->zonasPermitidas, true));
    }

    /** @return list<int>|null */
    private function zonasEfetivasTurma(ConvocacaoSmsContexto $contexto, ?string $zona): ?array
    {
        $zona = trim((string) $zona);
        if ($zona !== '' && (! ctype_digit($zona) || (int) $zona <= 0)) {
            return [];
        }

        return $this->escopoZonalTurma->resolver(
            $contexto->zonasPermitidas,
            $contexto->acessoTodasZonas,
            $zona !== '' ? (int) $zona : null,
        );
    }

    /**
     * @param  array<int, array<string, mixed>>  $itens
     * @return array<int, array<string, mixed>>
     */
    private function completarItensContexto(
        array $itens,
        ConvocacaoSmsContexto $contexto,
        bool $incluirModelosJaUtilizados = true,
    ): array {
        $modelosJaUtilizados = $incluirModelosJaUtilizados
            ? $this->buscarModelosJaUtilizados(array_column($itens, 'num_inscricao'), $contexto)
            : [];

        return array_map(
            fn (array $item): array => $this->completarContexto(
                $item,
                $contexto,
                $modelosJaUtilizados,
                $incluirModelosJaUtilizados,
            ),
            $itens,
        );
    }

    /**
     * @param  array<int, mixed>  $inscricoes
     * @return array<string, array<int, true>>
     */
    private function buscarModelosJaUtilizados(array $inscricoes, ConvocacaoSmsContexto $contexto): array
    {
        $normalizadas = collect($inscricoes)
            ->map(static fn (mixed $valor): string => trim((string) $valor))
            ->filter()
            ->unique()
            ->values()
            ->all();
        if ($normalizadas === []) {
            return [];
        }

        $resultado = [];
        foreach (array_chunk($normalizadas, 900) as $lote) {
            $modelos = DB::table('ce_sms_envio as sms_historico')
                ->selectRaw('TRIM(sms_historico.num_inscricao) AS num_inscricao, sms_historico.modelo_id')
                ->where('sms_historico.macroprojeto_turno_id', $contexto->macroprojetoTurnoId)
                ->where('sms_historico.status_codigo', '<>', 'CANCELADO_ANTES_ENVIO')
                ->whereIn(DB::raw('TRIM(sms_historico.num_inscricao)'), $lote)
                ->distinct()
                ->get();

            foreach ($modelos as $modeloOriginal) {
                $modelo = (array) $modeloOriginal;
                $inscricao = trim((string) ($modelo['num_inscricao'] ?? ''));
                $modeloId = (int) ($modelo['modelo_id'] ?? 0);
                if ($inscricao !== '' && $modeloId > 0) {
                    $resultado[$inscricao][$modeloId] = true;
                }
            }
        }

        return $resultado;
    }

    /**
     * @param  array<string, mixed>  $item
     * @param  array<string, array<int, true>>  $modelosJaUtilizados
     * @return array<string, mixed>
     */
    private function completarContexto(
        array $item,
        ConvocacaoSmsContexto $contexto,
        array $modelosJaUtilizados,
        bool $incluirModelosJaUtilizados,
    ): array {
        $inscricao = trim((string) ($item['num_inscricao'] ?? ''));
        $item['turno'] = $contexto->turno;
        $item['cod_pleito'] = $contexto->codPleito;
        $item['data_eleicao'] = $contexto->dataEleicao;
        if ($incluirModelosJaUtilizados) {
            $ids = array_map('intval', array_keys($modelosJaUtilizados[$inscricao] ?? []));
            sort($ids, SORT_NUMERIC);
            $item['modelos_ja_utilizados'] = $ids;
        }
        $item['selecionavel'] = $this->status->podeSelecionarParaEnvio(
            (string) ($item['situacao_comunicacao'] ?? ''),
            false,
        ) && trim((string) ($item['telefone_e164'] ?? '')) !== '';

        return $item;
    }
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSDESTINATARIOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/ConvocacaoSmsEnvioRepository.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSENVIOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/ConvocacaoSmsEnvioRepository.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsEnvioRepository implements ConvocacaoSmsEnvioRepositoryInterface, ConvocacaoSmsProcessamentoRepositoryInterface, ConvocacaoSmsRecuperacaoRepositoryInterface, ConvocacaoSmsSincronizacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$item = DB::table('ce_sms_lote')
$lote = DB::table('ce_sms_lote')->where('id', $id)->lockForUpdate()->first();
|| DB::table('ce_sms_lote_item')->where('lote_id', $id)->exists()
|| DB::table('ce_sms_envio')->where('lote_id', $id)->exists()) {
$item = DB::table('ce_sms_envio as e')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function buscarLotePorUuid(string $uuid, int $macroprojetoTurnoId): ?array
public function criarLote(array $dados): int
public function removerLoteVazio(int $id): bool
public function registrarItemLote(array $dados): int
public function reservarEnvio(array $dados): ?int
public function atualizarTotaisLote(int $loteId, int $selecionados, int $enfileirados, int $ignorados): void
public function buscarEnvio(int $id): ?array
public function reivindicarProcessamento(int $id): bool
public function restaurarPendenteForaJanela(int $id): bool
public function cancelarAntesEnvio(int $id, string $codigo, string $detalhe): void
public function registrarAceite(int $id, string $provedor, string $providerBatchId, ?string $deviceId, ?int $simSubscriptionId): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsProcessamentoRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRecuperacaoRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsSincronizacaoRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Services\ConvocacaoSms\ConvocacaoSmsLoteDuplicadoException;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use PDOException;

final class ConvocacaoSmsEnvioRepository implements ConvocacaoSmsEnvioRepositoryInterface, ConvocacaoSmsProcessamentoRepositoryInterface, ConvocacaoSmsRecuperacaoRepositoryInterface, ConvocacaoSmsSincronizacaoRepositoryInterface
{
    use AuditaDml;

    public function __construct(
        AuditLogService $auditLogService,
        private readonly ConvocacaoSmsStatusService $statusService,
    ) {
        $this->inicializarAuditoria($auditLogService);
    }

    public function buscarLotePorUuid(string $uuid, int $macroprojetoTurnoId): ?array
    {
        $item = DB::table('ce_sms_lote')
            ->where('request_uuid', mb_strtolower(trim($uuid), 'UTF-8'))
            ->where('macroprojeto_turno_id', $macroprojetoTurnoId)
            ->first();

        return $item !== null ? (array) $item : null;
    }

    public function criarLote(array $dados): int
    {
        try {
            return $this->inserirAuditado('ce_sms_lote', 'CE_SMS_LOTE', [
                'request_uuid' => mb_strtolower(trim((string) $dados['request_uuid']), 'UTF-8'),
                'macroprojeto_turno_id' => (int) $dados['macroprojeto_turno_id'],
                'modelo_id' => (int) $dados['modelo_id'],
                'num_zona' => trim((string) $dados['num_zona']),
                'usuario_login' => trim((string) $dados['usuario_login']),
                'usuario_nome' => trim((string) $dados['usuario_nome']),
                'total_selecionados' => 0,
                'total_enfileirados' => 0,
                'total_ignorados' => 0,
                'dt_criacao' => DB::raw('SYSDATE'),
            ], 'id');
        } catch (PDOException $exception) {
            $mensagem = mb_strtoupper($exception->getMessage(), 'UTF-8');
            if (str_contains($mensagem, 'ORA-00001') && str_contains($mensagem, 'UX_CE_SMS_LOTE_UUID')) {
                throw new ConvocacaoSmsLoteDuplicadoException(previous: $exception);
            }

            throw $exception;
        }
    }

    public function removerLoteVazio(int $id): bool
    {
        if ($id <= 0) {
            return false;
        }

        return DB::transaction(function () use ($id): bool {
            $lote = DB::table('ce_sms_lote')->where('id', $id)->lockForUpdate()->first();
            if ($lote === null
                || (int) $lote->total_selecionados !== 0
                || (int) $lote->total_enfileirados !== 0
                || (int) $lote->total_ignorados !== 0
                || DB::table('ce_sms_lote_item')->where('lote_id', $id)->exists()
                || DB::table('ce_sms_envio')->where('lote_id', $id)->exists()) {
                return false;
            }

            $afetados = $this->removerEscopoAuditado('ce_sms_lote', 'CE_SMS_LOTE', $id,
                static fn (Builder $query): Builder => $query
                    ->where('id', $id)
                    ->where('total_selecionados', 0)
                    ->where('total_enfileirados', 0)
                    ->where('total_ignorados', 0),
                ['id' => $id, 'condicao' => 'lote_vazio_sem_filhos'],
            );

            return $afetados === 1;
        });
    }

    public function registrarItemLote(array $dados): int
    {
        return $this->inserirAuditado('ce_sms_lote_item', 'CE_SMS_LOTE_ITEM', [
            'lote_id' => (int) $dados['lote_id'],
            'envio_id' => isset($dados['envio_id']) ? (int) $dados['envio_id'] : null,
            'num_inscricao' => trim((string) $dados['num_inscricao']),
            'enfileirado' => ! empty($dados['enfileirado']) ? 1 : 0,
            'motivo_codigo' => $this->textoOuNulo($dados['motivo_codigo'] ?? null, 80),
            'motivo_detalhe' => $this->textoOuNulo($dados['motivo_detalhe'] ?? null, 500),
            'dt_criacao' => DB::raw('SYSDATE'),
        ], 'id');
    }

    public function reservarEnvio(array $dados): ?int
    {
        try {
            return DB::transaction(function () use ($dados): int {
                $id = $this->inserirAuditado('ce_sms_envio', 'CE_SMS_ENVIO', [
                    'lote_id' => (int) $dados['lote_id'],
                    'modelo_id' => (int) $dados['modelo_id'],
                    'macroprojeto_turno_id' => (int) $dados['macroprojeto_turno_id'],
                    'num_inscricao' => trim((string) $dados['num_inscricao']),
                    'cod_pleito' => trim((string) $dados['cod_pleito']),
                    'dt_eleicao' => Carbon::createFromFormat('Y-m-d', (string) $dados['dt_eleicao'])->startOfDay(),
                    'num_zona' => trim((string) $dados['num_zona']),
                    'municipio' => $this->textoOuNulo($dados['municipio'] ?? null, 160),
                    'nome' => trim((string) $dados['nome']),
                    'telefone_e164' => trim((string) $dados['telefone_e164']),
                    'telefone_fonte' => trim((string) $dados['telefone_fonte']),
                    'sender' => trim((string) $dados['sender']),
                    'provider_codigo' => mb_strtoupper(trim((string) ($dados['provider_codigo'] ?? 'TEXTBEE')), 'UTF-8'),
                    'provider_device_id' => $this->textoOuNulo($dados['provider_device_id'] ?? null, 255),
                    'provider_sim_subscription_id' => isset($dados['provider_sim_subscription_id']) ? (int) $dados['provider_sim_subscription_id'] : null,
                    'atribuicoes_json' => (string) $dados['atribuicoes_json'],
                    'mensagem_texto' => (string) $dados['mensagem_texto'],
                    'encoding' => trim((string) $dados['encoding']),
                    'segmentos' => (int) $dados['segmentos'],
                    'external_id' => trim((string) $dados['external_id']),
                    'payload_hash' => trim((string) $dados['payload_hash']),
                    'status_codigo' => 'PENDENTE',
                    'tentativas' => 0,
                    'dt_criacao' => DB::raw('SYSDATE'),
                ], 'id');
                $this->registrarEventoInterno($id, null, 'PENDENTE', 'reserva');

                return $id;
            });
        } catch (PDOException $exception) {
            if ($this->ehConflitoReservaAtiva($exception)) {
                return null;
            }

            throw $exception;
        }
    }

    public function atualizarTotaisLote(int $loteId, int $selecionados, int $enfileirados, int $ignorados): void
    {
        $this->atualizarAuditadoPorId('ce_sms_lote', 'CE_SMS_LOTE', 'id', $loteId, [
            'total_selecionados' => max(0, $selecionados),
            'total_enfileirados' => max(0, $enfileirados),
            'total_ignorados' => max(0, $ignorados),
        ]);
    }

    public function buscarEnvio(int $id): ?array
    {
        $item = DB::table('ce_sms_envio as e')
            ->join('ce_sms_lote as l', 'l.id', '=', 'e.lote_id')
            ->join('macroprojeto_turno as mt', 'mt.id', '=', 'e.macroprojeto_turno_id')
            ->selectRaw(<<<'SQL'
e.*,
l.usuario_login,
l.usuario_nome,
mt.macroprojeto_id,
mt.turno,
TO_CHAR(e.dt_eleicao, 'YYYY-MM-DD') AS dt_eleicao_iso
SQL)
            ->where('e.id', $id)
            ->first();

        return $item !== null ? (array) $item : null;
    }

    public function reivindicarProcessamento(int $id): bool
    {
        return DB::transaction(function () use ($id): bool {
            $afetados = $this->atualizarEscopoAuditado(
                'ce_sms_envio',
                'CE_SMS_ENVIO',
                $id,
                static fn (Builder $query): Builder => $query->where('id', $id)->where('status_codigo', 'PENDENTE'),
                [
                    'status_codigo' => 'PROCESSANDO',
                    'tentativas' => DB::raw('tentativas + 1'),
                    'dt_processamento' => DB::raw('SYSDATE'),
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                    'erro_codigo' => null,
                    'erro_detalhe' => null,
                ],
                ['id' => $id, 'status_anterior' => 'PENDENTE'],
            );
            if ($afetados > 0) {
                $this->registrarEventoInterno($id, 'PENDENTE', 'PROCESSANDO', 'worker_claim');
            }

            return $afetados > 0;
        });
    }

    public function restaurarPendenteForaJanela(int $id): bool
    {
        return DB::transaction(function () use ($id): bool {
            $afetados = $this->atualizarEscopoAuditado(
                'ce_sms_envio',
                'CE_SMS_ENVIO',
                $id,
                static fn (Builder $query): Builder => $query
                    ->where('id', $id)
                    ->where('status_codigo', 'PROCESSANDO'),
                [
                    'status_codigo' => 'PENDENTE',
                    'tentativas' => DB::raw('GREATEST(tentativas - 1, 0)'),
                    'dt_processamento' => null,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ],
                ['id' => $id, 'status_anterior' => 'PROCESSANDO', 'motivo' => 'FORA_JANELA_ENVIO'],
            );
            if ($afetados > 0) {
                $this->registrarEventoInterno($id, 'PROCESSANDO', 'PENDENTE', 'adiado_fora_janela');
            }

            return $afetados === 1;
        });
    }

    public function cancelarAntesEnvio(int $id, string $codigo, string $detalhe): void
    {
        $this->transicionarProcessamento(
            $id,
            'CANCELADO_ANTES_ENVIO',
            $this->textoOuNulo($codigo, 80),
            $this->textoOuNulo($detalhe, 1000),
            [],
        );
    }

    public function registrarAceite(int $id, string $provedor, string $providerBatchId, ?string $deviceId, ?int $simSubscriptionId): void
    {
        $this->transicionarProcessamento($id, 'ACEITO', null, null, [
            'provider_codigo' => mb_strtoupper(trim($provedor), 'UTF-8'),
            'provider_batch_id' => trim($providerBatchId),
            'provider_device_id' => $this->textoOuNulo($deviceId, 255),
            'provider_sim_subscription_id' => $simSubscriptionId,
            'dt_aceite' => DB::raw('SYSDATE'),
        ]);
    }

    public function registrarRejeicao(int $id, ?string $codigo, ?string $detalhe): void
    {
        $this->transicionarProcessamento(
            $id,
            'REJEITADO',
            $this->textoOuNulo($codigo, 80),
            $this->textoOuNulo($detalhe, 1000),
            [],
        );
    }

    public function registrarIndeterminado(int $id, string $codigo, string $detalhe): void
    {
        $this->transicionarProcessamento(
            $id,
            'INDETERMINADO',
            $this->textoOuNulo($codigo, 80),
            $this->textoOuNulo($detalhe, 1000),
            [],
        );
    }

    public function prepararReenvio(int $id, ConvocacaoSmsContexto $contexto): bool
    {
        if (! $contexto->administrador) {
            return false;
        }

        return DB::transaction(function () use ($id, $contexto): bool {
            $escopo = function (Builder $query) use ($id, $contexto): Builder {
                $query->where('id', $id)
                    ->where('macroprojeto_turno_id', $contexto->macroprojetoTurnoId)
                    ->where('status_codigo', 'REJEITADO');
                if (! $contexto->acessoTodasZonas) {
                    $contexto->zonasPermitidas === []
                        ? $query->whereRaw('1 = 0')
                        : $query->whereIn('num_zona', $contexto->zonasPermitidas);
                }

                return $query;
            };
            $sim = config('planeleito.sms_textbee.sim_subscription_id');
            $afetados = $this->atualizarEscopoAuditado('ce_sms_envio', 'CE_SMS_ENVIO', $id, $escopo, [
                'status_codigo' => 'PENDENTE',
                'provider_codigo' => 'TEXTBEE',
                'provider_batch_id' => null,
                'provider_message_id' => null,
                'provider_device_id' => trim((string) config('planeleito.sms_textbee.device_id', '')),
                'provider_sim_subscription_id' => $sim !== null && trim((string) $sim) !== '' ? (int) $sim : null,
                'sender' => mb_substr('TEXTBEE:'.trim((string) config('planeleito.sms_textbee.device_id', '')).':'.($sim !== null && trim((string) $sim) !== '' ? (string) (int) $sim : 'DEFAULT'), 0, 100),
                'erro_codigo' => null,
                'erro_detalhe' => null,
                'dt_processamento' => null,
                'dt_atualizacao' => DB::raw('SYSDATE'),
            ], ['id' => $id, 'status_anterior' => 'REJEITADO']);
            if ($afetados > 0) {
                $this->registrarEventoInterno($id, 'REJEITADO', 'PENDENTE', 'reenvio_admin');
            }

            return $afetados > 0;
        });
    }

    public function buscarPorMensagemProvedor(string $provedor, string $providerMessageId): ?array
    {
        $item = DB::table('ce_sms_envio')
            ->where('provider_codigo', mb_strtoupper(trim($provedor), 'UTF-8'))
            ->where('provider_message_id', trim($providerMessageId))
            ->first();

        return $item !== null ? (array) $item : null;
    }

    public function buscarPorLoteProvedor(string $provedor, string $providerBatchId): ?array
    {
        $item = DB::table('ce_sms_envio')
            ->where('provider_codigo', mb_strtoupper(trim($provedor), 'UTF-8'))
            ->where('provider_batch_id', trim($providerBatchId))
            ->first();

        return $item !== null ? (array) $item : null;
    }

    public function listarTextBeePendentesSincronizacao(): array
    {
        return DB::table('ce_sms_envio')
            ->select([
                'id',
                'status_codigo',
                'provider_batch_id',
                'provider_device_id',
                'telefone_e164',
                'dt_criacao',
            ])
            ->where('provider_codigo', 'TEXTBEE')
            ->whereIn('status_codigo', ['ACEITO', 'ENVIADO'])
            ->whereNotNull('provider_batch_id')
            ->orderBy('id')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();
    }

    public function listarFalhasLimiteTextBee(int $maxTentativas): array
    {
        return DB::table('ce_sms_envio as e')
            ->join('ce_sms_lote as l', 'l.id', '=', 'e.lote_id')
            ->join('macroprojeto_turno as mt', 'mt.id', '=', 'e.macroprojeto_turno_id')
            ->selectRaw(<<<'SQL'
e.*,
l.usuario_login,
l.usuario_nome,
mt.macroprojeto_id,
mt.turno,
TO_CHAR(e.dt_eleicao, 'YYYY-MM-DD') AS dt_eleicao_iso
SQL)
            ->where('e.provider_codigo', 'TEXTBEE')
            ->where('e.status_codigo', 'NAO_ENTREGUE')
            ->where('e.erro_codigo', '5')
            ->where('e.tentativas', '<', max(1, $maxTentativas))
            ->whereExists(static function (Builder $query): void {
                $query->selectRaw('1')
                    ->from('ce_sms_envio_evento as limite')
                    ->whereColumn('limite.envio_id', 'e.id')
                    ->where('limite.provider_codigo', 'TEXTBEE')
                    ->where('limite.status_provedor', 'MESSAGE_FAILED')
                    ->where('limite.erro_codigo', '5');
            })
            ->orderBy('e.id')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();
    }

    public function prepararReenvioFalhaLimiteTextBee(int $id, int $maxTentativas): bool
    {
        return DB::transaction(function () use ($id, $maxTentativas): bool {
            $escopo = static function (Builder $query) use ($id, $maxTentativas): Builder {
                return $query->where('id', $id)
                    ->where('provider_codigo', 'TEXTBEE')
                    ->where('status_codigo', 'NAO_ENTREGUE')
                    ->where('erro_codigo', '5')
                    ->where('tentativas', '<', max(1, $maxTentativas))
                    ->whereExists(static function (Builder $evento): void {
                        $evento->selectRaw('1')
                            ->from('ce_sms_envio_evento as limite')
                            ->whereColumn('limite.envio_id', 'ce_sms_envio.id')
                            ->where('limite.provider_codigo', 'TEXTBEE')
                            ->where('limite.status_provedor', 'MESSAGE_FAILED')
                            ->where('limite.erro_codigo', '5');
                    });
            };
            $afetados = $this->atualizarEscopoAuditado('ce_sms_envio', 'CE_SMS_ENVIO', $id, $escopo, [
                'status_codigo' => 'PENDENTE',
                'provider_batch_id' => null,
                'provider_message_id' => null,
                'erro_codigo' => null,
                'erro_detalhe' => null,
                'dt_processamento' => null,
                'dt_aceite' => null,
                'dt_ultimo_evento' => null,
                'dt_atualizacao' => DB::raw('SYSDATE'),
            ], [
                'id' => $id,
                'status_anterior' => 'NAO_ENTREGUE',
                'motivo' => 'TEXTBEE_ANDROID_LIMIT_5',
            ]);
            if ($afetados > 0) {
                $this->registrarEventoInterno($id, 'NAO_ENTREGUE', 'PENDENTE', 'recuperacao_limite_android');
            }

            return $afetados === 1;
        });
    }

    public function aplicarEventoProvedor(int $id, string $provedor, string $eventoId, ?string $providerMessageId, string $statusAnterior, string $statusNovo, string $statusProvedor, ?string $erroCodigo, ?string $erroDetalhe, ?int $timestamp): bool
    {
        $provedor = mb_strtoupper(trim($provedor), 'UTF-8');
        try {
            return DB::transaction(function () use ($id, $provedor, $eventoId, $providerMessageId, $statusAnterior, $statusNovo, $statusProvedor, $erroCodigo, $erroDetalhe, $timestamp): bool {
                if (DB::table('ce_sms_envio_evento')->where('provider_codigo', $provedor)->where('provider_event_id', $eventoId)->exists()) {
                    return false;
                }

                $atual = DB::table('ce_sms_envio')->where('id', $id)->lockForUpdate()->first();
                if ($atual === null) {
                    return false;
                }
                $statusEfetivoAnterior = trim((string) ($atual->status_codigo ?? $statusAnterior));
                $statusEfetivoNovo = $statusEfetivoAnterior === $statusAnterior
                    ? $statusNovo
                    : $this->statusService->aplicarEventoProvedor($statusEfetivoAnterior, $provedor, $statusProvedor);
                if ($statusEfetivoNovo === null) {
                    return false;
                }

                $this->inserirAuditado('ce_sms_envio_evento', 'CE_SMS_ENVIO_EVENTO', [
                    'envio_id' => $id,
                    'provider_codigo' => $provedor,
                    'provider_event_id' => $eventoId,
                    'status_anterior' => $statusEfetivoAnterior,
                    'status_novo' => $statusEfetivoNovo,
                    'status_provedor' => mb_substr(mb_strtoupper(trim($statusProvedor), 'UTF-8'), 0, 40),
                    'erro_codigo' => $this->textoOuNulo($erroCodigo, 80),
                    'erro_detalhe' => $this->textoOuNulo($erroDetalhe, 1000),
                    'dt_evento_provedor' => $timestamp !== null ? Carbon::createFromTimestampUTC($timestamp) : null,
                    'dt_criacao' => DB::raw('SYSDATE'),
                ], 'id');

                if ($statusEfetivoNovo !== $statusEfetivoAnterior) {
                    $dados = [
                        'status_codigo' => $statusEfetivoNovo,
                        'dt_ultimo_evento' => DB::raw('SYSDATE'),
                        'dt_atualizacao' => DB::raw('SYSDATE'),
                    ];
                    if ($providerMessageId !== null && trim($providerMessageId) !== '') {
                        $dados['provider_message_id'] = trim($providerMessageId);
                    }
                    if ($statusEfetivoNovo === 'NAO_ENTREGUE') {
                        $dados['erro_codigo'] = $this->textoOuNulo($erroCodigo, 80);
                        $dados['erro_detalhe'] = $this->textoOuNulo($erroDetalhe, 1000);
                    }
                    $this->atualizarAuditadoPorId('ce_sms_envio', 'CE_SMS_ENVIO', 'id', $id, $dados);
                }

                return true;
            });
        } catch (PDOException $exception) {
            if (str_contains(mb_strtoupper($exception->getMessage(), 'UTF-8'), 'UX_CE_SMS_EVENTO_')) {
                return false;
            }

            throw $exception;
        }
    }

    public function listarHistorico(array $filtros, ConvocacaoSmsContexto $contexto, string $path, int $porPagina = 50): LengthAwarePaginator
    {
        return $this->historicoQuery($filtros, $contexto)
            ->orderByDesc('e.dt_criacao')
            ->paginate(max(1, min(50, $porPagina)), ['*'], 'page')
            ->withPath($path);
    }

    public function listarHistoricoParaExportacao(array $filtros, ConvocacaoSmsContexto $contexto): array
    {
        return $this->historicoQuery($filtros, $contexto)
            ->orderByDesc('e.dt_criacao')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();
    }

    public function buscarDetalhe(int $id, ConvocacaoSmsContexto $contexto): ?array
    {
        $item = $this->historicoQuery([], $contexto)->where('e.id', $id)->first();
        if ($item === null) {
            return null;
        }

        $dados = (array) $item;
        $dados['eventos'] = DB::table('ce_sms_envio_evento')
            ->selectRaw("id, provider_codigo, status_anterior, status_novo, status_provedor, erro_codigo, erro_detalhe, TO_CHAR(dt_evento_provedor, 'DD/MM/YYYY HH24:MI:SS') AS dt_evento_provedor_fmt, TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI:SS') AS dt_criacao_fmt")
            ->where('envio_id', $id)
            ->orderBy('id')
            ->get()
            ->map(static fn (object $evento): array => (array) $evento)
            ->all();

        return $dados;
    }

    public function marcarProcessamentosExpirados(int $minutos): int
    {
        $minutos = max(1, $minutos);
        $ids = DB::table('ce_sms_envio')
            ->where('status_codigo', 'PROCESSANDO')
            ->whereRaw('dt_processamento < SYSDATE - (? / 1440)', [$minutos])
            ->orderBy('id')
            ->pluck('id')
            ->map(static fn ($id): int => (int) $id)
            ->all();
        $afetados = 0;
        foreach ($ids as $id) {
            $antes = DB::table('ce_sms_envio')->where('id', $id)->value('status_codigo');
            $this->registrarIndeterminado(
                $id,
                'PROCESSAMENTO_ABANDONADO',
                'O processamento permaneceu sem conclusão além da janela operacional.',
            );
            $depois = DB::table('ce_sms_envio')->where('id', $id)->value('status_codigo');
            $afetados += $antes !== $depois && $depois === 'INDETERMINADO' ? 1 : 0;
        }

        return $afetados;
    }

    /** @param array<string, mixed> $metadadosProvedor */
    private function transicionarProcessamento(int $id, string $statusNovo, ?string $codigo, ?string $detalhe, array $metadadosProvedor): void
    {
        DB::transaction(function () use ($id, $statusNovo, $codigo, $detalhe, $metadadosProvedor): void {
            $dados = array_merge([
                'status_codigo' => $statusNovo,
                'erro_codigo' => $codigo,
                'erro_detalhe' => $detalhe,
                'dt_atualizacao' => DB::raw('SYSDATE'),
            ], $metadadosProvedor);
            $afetados = $this->atualizarEscopoAuditado(
                'ce_sms_envio',
                'CE_SMS_ENVIO',
                $id,
                static fn (Builder $query): Builder => $query->where('id', $id)->where('status_codigo', 'PROCESSANDO'),
                $dados,
                ['id' => $id, 'status_anterior' => 'PROCESSANDO'],
            );
            if ($afetados > 0) {
                $this->registrarEventoInterno($id, 'PROCESSANDO', $statusNovo, mb_strtolower($statusNovo, 'UTF-8'));
            }
        });
    }

    private function registrarEventoInterno(int $envioId, ?string $anterior, string $novo, string $origem): void
    {
        $this->inserirAuditado('ce_sms_envio_evento', 'CE_SMS_ENVIO_EVENTO', [
            'envio_id' => $envioId,
            'provider_codigo' => 'INTERNAL',
            'provider_event_id' => 'internal:'.Str::uuid()->toString(),
            'status_anterior' => $anterior,
            'status_novo' => $novo,
            'status_provedor' => mb_substr('INTERNAL:'.mb_strtoupper($origem, 'UTF-8'), 0, 40),
            'dt_criacao' => DB::raw('SYSDATE'),
        ], 'id');
    }

    /** @param array<string, mixed> $filtros */
    private function historicoQuery(array $filtros, ConvocacaoSmsContexto $contexto): Builder
    {
        $query = DB::table('ce_sms_envio as e')
            ->join('ce_sms_lote as l', 'l.id', '=', 'e.lote_id')
            ->join('ce_sms_modelo as m', 'm.id', '=', 'e.modelo_id')
            ->selectRaw(<<<'SQL'
e.id,
e.lote_id,
e.modelo_id,
e.num_inscricao,
e.num_zona,
e.municipio,
e.nome,
e.telefone_e164,
e.telefone_fonte,
e.sender,
e.atribuicoes_json,
e.mensagem_texto,
e.encoding,
e.segmentos,
e.external_id,
e.status_codigo,
e.provider_codigo,
e.provider_batch_id,
e.provider_message_id,
e.provider_device_id,
e.provider_sim_subscription_id,
e.tentativas,
e.erro_codigo,
e.erro_detalhe,
l.request_uuid,
l.usuario_login,
l.usuario_nome,
m.nome_exibicao AS modelo_nome,
TO_CHAR(e.dt_eleicao, 'DD/MM/YYYY') AS dt_eleicao_fmt,
TO_CHAR(e.dt_criacao, 'DD/MM/YYYY HH24:MI') AS dt_criacao_fmt,
TO_CHAR(e.dt_processamento, 'DD/MM/YYYY HH24:MI') AS dt_processamento_fmt,
TO_CHAR(e.dt_aceite, 'DD/MM/YYYY HH24:MI') AS dt_aceite_fmt,
TO_CHAR(e.dt_ultimo_evento, 'DD/MM/YYYY HH24:MI') AS dt_ultimo_evento_fmt,
(SELECT COUNT(*) FROM ce_sms_resposta r WHERE r.envio_id = e.id) AS respostas_quantidade,
(SELECT TO_CHAR(MAX(r.dt_recebimento), 'DD/MM/YYYY HH24:MI') FROM ce_sms_resposta r WHERE r.envio_id = e.id) AS ultima_resposta_fmt
SQL)
            ->where('e.macroprojeto_turno_id', $contexto->macroprojetoTurnoId);

        if (! $contexto->acessoTodasZonas) {
            $contexto->zonasPermitidas === []
                ? $query->whereRaw('1 = 0')
                : $query->whereIn('e.num_zona', $contexto->zonasPermitidas);
        }
        if (! $contexto->gestor && ! $contexto->administrador) {
            $query->whereRaw('UPPER(l.usuario_login) = ?', [mb_strtoupper($contexto->usuarioLogin, 'UTF-8')]);
        }
        $zona = trim((string) ($filtros['zona'] ?? ''));
        if ($zona !== '') {
            $query->where('e.num_zona', $zona);
        }
        $status = mb_strtoupper(trim((string) ($filtros['situacao'] ?? '')), 'UTF-8');
        if ($status !== '') {
            $query->where('e.status_codigo', $status);
        }
        $busca = trim((string) ($filtros['q'] ?? ''));
        if ($busca !== '') {
            $like = '%'.mb_strtoupper($busca, 'UTF-8').'%';
            $query->where(function (Builder $sub) use ($like): void {
                $sub->whereRaw('UPPER(e.nome) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(e.num_inscricao) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(e.municipio) LIKE ?', [$like]);
            });
        }

        return $query;
    }

    private function ehConflitoReservaAtiva(PDOException $exception): bool
    {
        $mensagem = mb_strtoupper($exception->getMessage(), 'UTF-8');

        return str_contains($mensagem, 'ORA-00001')
            && (str_contains($mensagem, 'UX_CE_SMS_ENVIO_ATIVO')
                || str_contains($mensagem, 'UX_CE_SMS_ENVIO_MODELO')
                || str_contains($mensagem, 'UX_CE_SMS_ENVIO_DESTINO'));
    }

    private function textoOuNulo(mixed $valor, int $limite): ?string
    {
        $texto = trim((string) $valor);

        return $texto !== '' ? mb_substr($texto, 0, $limite) : null;
    }
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSENVIOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/ConvocacaoSmsRespostaRepository.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSRESPOSTAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/ConvocacaoSmsRespostaRepository.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsRespostaRepository implements ConvocacaoSmsRespostaRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('ce_sms_envio')
if (DB::table('ce_sms_resposta')->where('provider_codigo', $provider)
return DB::table('ce_sms_resposta')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function buscarEnviosAnterioresCompativeis(string $telefoneE164, string $deviceId, int $timestamp): array
public function registrarRecebida(array $dados): bool
public function listarPorEnvioIds(array $enviosIds): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRespostaRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Database\QueryException;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

final class ConvocacaoSmsRespostaRepository implements ConvocacaoSmsRespostaRepositoryInterface
{
    use AuditaDml;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function buscarEnviosAnterioresCompativeis(string $telefoneE164, string $deviceId, int $timestamp): array
    {
        return DB::table('ce_sms_envio')
            ->select(['id', 'num_zona', 'num_inscricao'])
            ->where('provider_codigo', 'TEXTBEE')
            ->whereIn('status_codigo', ['ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'])
            ->where('telefone_e164', preg_replace('/\D+/', '', $telefoneE164) ?? '')
            ->where('provider_device_id', trim($deviceId))
            ->where('dt_criacao', '<=', Carbon::createFromTimestampUTC($timestamp))
            ->orderByDesc('dt_criacao')
            ->orderByDesc('id')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->all();
    }

    public function registrarRecebida(array $dados): bool
    {
        $provider = mb_strtoupper(trim((string) ($dados['provider_codigo'] ?? '')), 'UTF-8');
        $eventoId = trim((string) ($dados['provider_event_id'] ?? ''));
        $mensagemId = trim((string) ($dados['provider_message_id'] ?? ''));
        if (DB::table('ce_sms_resposta')->where('provider_codigo', $provider)
            ->where(function ($query) use ($eventoId, $mensagemId): void {
                $query->where('provider_event_id', $eventoId)->orWhere('provider_message_id', $mensagemId);
            })->exists()) {
            return false;
        }

        try {
            $this->inserirAuditado('ce_sms_resposta', 'CE_SMS_RESPOSTA', [
                'provider_codigo' => $provider,
                'provider_event_id' => $eventoId,
                'provider_message_id' => $mensagemId,
                'provider_device_id' => trim((string) ($dados['provider_device_id'] ?? '')),
                'envio_id' => isset($dados['envio_id']) ? (int) $dados['envio_id'] : null,
                'telefone_e164' => preg_replace('/\D+/', '', (string) ($dados['telefone_e164'] ?? '')),
                'mensagem_texto' => (string) ($dados['mensagem_texto'] ?? ''),
                'vinculo_codigo' => mb_strtoupper(trim((string) ($dados['vinculo_codigo'] ?? 'SEM_ENVIO')), 'UTF-8'),
                'dt_recebimento' => Carbon::createFromTimestampUTC((int) $dados['timestamp']),
                'dt_criacao' => DB::raw('SYSDATE'),
            ], 'id');

            return true;
        } catch (QueryException $exception) {
            if (str_contains(mb_strtoupper($exception->getMessage(), 'UTF-8'), 'UX_CE_SMS_RESP_')) {
                return false;
            }

            throw $exception;
        }
    }

    public function listarPorEnvioIds(array $enviosIds): array
    {
        if ($enviosIds === []) {
            return [];
        }

        return DB::table('ce_sms_resposta')
            ->selectRaw("id, envio_id, telefone_e164, mensagem_texto, vinculo_codigo, TO_CHAR(dt_recebimento, 'DD/MM/YYYY HH24:MI') AS dt_recebimento_fmt")
            ->whereIn('envio_id', array_values(array_unique(array_map('intval', $enviosIds))))
            ->orderByDesc('dt_recebimento')
            ->get()
            ->map(static fn (object $item): array => (array) $item)
            ->groupBy(static fn (array $item): int => (int) $item['envio_id'])
            ->map(static fn ($itens): array => $itens->values()->all())
            ->all();
    }
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSRESPOSTAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/ConvocacaoSmsTelefoneManualRepository.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSTELEFONEMANUALREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/ConvocacaoSmsTelefoneManualRepository.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsTelefoneManualRepository implements ConvocacaoSmsTelefoneManualRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$registro = DB::table(self::TABELA)
$registro = DB::table(self::TABELA)
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function salvar(
public function remover(string $numInscricao): bool
private function salvarEmTransacao(
private function violacaoUnicidade(QueryException $exception): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsTelefoneManualRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;

final class ConvocacaoSmsTelefoneManualRepository implements ConvocacaoSmsTelefoneManualRepositoryInterface
{
    use AuditaDml;

    private const TABELA = 'ce_sms_telefone_manual';

    private const ENTIDADE = 'ConvocacaoSmsTelefoneManual';

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function salvar(
        string $numInscricao,
        string $telefoneNacional,
        string $usuarioLogin,
        string $usuarioNome,
    ): bool {
        try {
            return $this->salvarEmTransacao($numInscricao, $telefoneNacional, $usuarioLogin, $usuarioNome);
        } catch (QueryException $exception) {
            if (! $this->violacaoUnicidade($exception)) {
                throw $exception;
            }

            return $this->salvarEmTransacao($numInscricao, $telefoneNacional, $usuarioLogin, $usuarioNome);
        }
    }

    public function remover(string $numInscricao): bool
    {
        return DB::transaction(function () use ($numInscricao): bool {
            $registro = DB::table(self::TABELA)
                ->where('num_inscricao', $numInscricao)
                ->lockForUpdate()
                ->first();
            if ($registro === null) {
                return false;
            }

            return $this->removerAuditadoPorId(
                self::TABELA,
                self::ENTIDADE,
                'id',
                (int) $registro->id,
            ) > 0;
        });
    }

    private function salvarEmTransacao(
        string $numInscricao,
        string $telefoneNacional,
        string $usuarioLogin,
        string $usuarioNome,
    ): bool {
        return DB::transaction(function () use ($numInscricao, $telefoneNacional, $usuarioLogin, $usuarioNome): bool {
            $registro = DB::table(self::TABELA)
                ->where('num_inscricao', $numInscricao)
                ->lockForUpdate()
                ->first();
            if ($registro !== null) {
                if (trim((string) $registro->telefone_nacional) === $telefoneNacional) {
                    return false;
                }

                return $this->atualizarAuditadoPorId(self::TABELA, self::ENTIDADE, 'id', (int) $registro->id, [
                    'telefone_nacional' => $telefoneNacional,
                    'usuario_login' => $usuarioLogin,
                    'usuario_nome' => $usuarioNome,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]) > 0;
            }

            return $this->inserirAuditado(self::TABELA, self::ENTIDADE, [
                'num_inscricao' => $numInscricao,
                'telefone_nacional' => $telefoneNacional,
                'usuario_login' => $usuarioLogin,
                'usuario_nome' => $usuarioNome,
                'dt_criacao' => DB::raw('SYSDATE'),
            ]) > 0;
        });
    }

    private function violacaoUnicidade(QueryException $exception): bool
    {
        return str_contains(mb_strtoupper($exception->getMessage(), 'UTF-8'), 'ORA-00001');
    }
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_CONVOCACAOSMSTELEFONEMANUALREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ConvocacaoSms/Queries/ConvocacaoSmsDestinatarioPaginadoQuery.php`
## <APP_REPOSITORIES_CONVOCACAOSMS_QUERIES_CONVOCACAOSMSDESTINATARIOPAGINADOQUERY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ConvocacaoSms/Queries/ConvocacaoSmsDestinatarioPaginadoQuery.php`
- **Namespace Declaração:** `App\Repositories\ConvocacaoSms\Queries`
- **Entidade / Classe:** `final class ConvocacaoSmsDestinatarioPaginadoQuery`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function criar(
public static function filtrarPorPessoa(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ConvocacaoSms\Queries;

use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;

final class ConvocacaoSmsDestinatarioPaginadoQuery
{
    private const STATUS_EFETIVO_SQL = <<<'SQL'
CASE WHEN status_codigo IN ('ENVIADO', 'NAO_ENTREGUE') AND confirmado_elo = 1 THEN 'ENTREGUE' ELSE status_codigo END
SQL;

    public static function criar(
        Builder $base,
        int $inicio,
        int $fim,
        string $confirmacaoElo = '',
        string $situacao = '',
    ): Builder {
        $filtradas = self::filtrarPorPessoa($base, $confirmacaoElo, $situacao);

        $ranqueadas = DB::query()
            ->fromSub($filtradas, 'sms_canonica')
            ->select('sms_canonica.*')
            ->selectRaw(<<<'SQL'
DENSE_RANK() OVER (
    ORDER BY
        TO_NUMBER(REGEXP_REPLACE(num_zona, '[^0-9]', '')) NULLS LAST,
        municipio_ordem,
        nome_ordem,
        num_inscricao
) AS destinatario_rank
SQL);

        $totalizadas = DB::query()
            ->fromSub($ranqueadas, 'sms_ranqueada')
            ->select('sms_ranqueada.*')
            ->selectRaw('MAX(destinatario_rank) OVER () AS destinatarios_total');

        return DB::query()
            ->fromSub($totalizadas, 'sms_totalizada')
            ->whereBetween('destinatario_rank', [$inicio, $fim])
            ->orderBy('destinatario_rank')
            ->orderByRaw("TO_NUMBER(REGEXP_REPLACE(num_local, '[^0-9]', '')) NULLS LAST")
            ->orderByRaw("TO_NUMBER(REGEXP_REPLACE(num_secao, '[^0-9]', '')) NULLS LAST")
            ->orderByRaw('UPPER(des_funcao_eleitoral)');
    }

    public static function filtrarPorPessoa(
        Builder $base,
        string $confirmacaoElo = '',
        string $situacao = '',
    ): Builder {
        $canonicas = DB::query()
            ->fromSub($base, 'sms_base')
            ->select('sms_base.*')
            ->selectRaw(<<<'SQL'
MIN(UPPER(NVL(nom_localidade, ''))) OVER (
    PARTITION BY num_zona, num_inscricao
) AS municipio_ordem,
MIN(UPPER(NVL(nom_eleitor, num_inscricao))) OVER (
    PARTITION BY num_zona, num_inscricao
) AS nome_ordem,
MAX(CASE WHEN UPPER(TRIM(resposta_elo)) = 'SIM' THEN 1 ELSE 0 END) OVER (
    PARTITION BY num_zona, num_inscricao
) AS confirmado_elo
SQL);

        $confirmacaoElo = mb_strtoupper(trim($confirmacaoElo), 'UTF-8');
        $situacao = mb_strtoupper(trim($situacao), 'UTF-8');
        $filtraConfirmacao = in_array($confirmacaoElo, ['CONFIRMADO', 'NAO_CONFIRMADO'], true);
        $filtraStatusEfetivo = in_array($situacao, ['ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'], true);
        if (! $filtraConfirmacao && ! $filtraStatusEfetivo) {
            return $canonicas;
        }

        $filtradas = DB::query()
            ->fromSub($canonicas, 'sms_confirmacao')
            ->select('sms_confirmacao.*')
            ->selectRaw(self::STATUS_EFETIVO_SQL.' AS status_codigo_efetivo');

        if ($filtraConfirmacao) {
            $filtradas->where('confirmado_elo', $confirmacaoElo === 'CONFIRMADO' ? 1 : 0);
        }
        if ($filtraStatusEfetivo) {
            $filtradas->whereRaw(self::STATUS_EFETIVO_SQL.' = ?', [$situacao]);
        }

        return $filtradas;
    }
}
```
</APP_REPOSITORIES_CONVOCACAOSMS_QUERIES_CONVOCACAOSMSDESTINATARIOPAGINADOQUERY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Lda/LdaConversaMensagemRepository.php`
## <APP_REPOSITORIES_LDA_LDACONVERSAMENSAGEMREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Lda/LdaConversaMensagemRepository.php`
- **Namespace Declaração:** `App\Repositories\Lda`
- **Entidade / Classe:** `class LdaConversaMensagemRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$valor = DB::table('nat_rota_conversa')
DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
return (int) DB::table('nat_rota_mensagem')->insertGetId([
DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
$existe = DB::table('nat_rota_conversa')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function idConversaAtiva(int $macroprojetoId, string $turno, int $ldaId): ?int
public function registrarMensagem(array $dados): int
public function registrarMensagemNatNaConversa(
public function arquivarConversaPorIdNoEscopo(int $conversaId, int $macroprojetoId, array $zonasPermitidas, bool $acessoTodasZonas): void
public function arquivarConversaMesario(int $conversaId, int $macroprojetoId, int $ldaId): void
public function buscarConversaPorIdNoEscopo(
public function primeiraConversaNoEscopo(
public function cardsLdaComNaoLidas(
public function ldaPertenceAoEscopo(int $ldaId, array $zonasPermitidas, bool $acessoTodasZonas): bool
public function garantirConversaAtiva(int $macroprojetoId, string $turno, int $ldaId): int
private function agora(): Expression
private function normalizarZonas(array $zonas): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Lda;

use Illuminate\Contracts\Database\Query\Expression;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use RuntimeException;

/**
 * Mensageria do escopo LDA sobre a conversa polimorfica (escopo_tipo = 'LDA').
 * Identidade do canal ativo: (macroprojeto_id, turno, lda_id). Sem rota.
 * `origem` reusa a semantica de direcao: 'ROTA' = lado campo (mesario), 'NAT' = central.
 * Contrato: docs/contratos/mesario-publico-situacao.md
 */
class LdaConversaMensagemRepository
{
    public const ORIGEM_MESARIO = 'ROTA';

    public const ORIGEM_NAT = 'NAT';

    public function idConversaAtiva(int $macroprojetoId, string $turno, int $ldaId): ?int
    {
        if ($macroprojetoId <= 0 || trim($turno) === '' || $ldaId <= 0) {
            return null;
        }

        $valor = DB::table('nat_rota_conversa')
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('escopo_tipo', 'LDA')
            ->where('turno', trim($turno))
            ->where('lda_id', $ldaId)
            ->whereNull('arquivada_em')
            ->orderByDesc('id')
            ->value('id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    public function registrarMensagem(array $dados): int
    {
        return DB::transaction(function () use ($dados): int {
            $macroprojetoId = (int) $dados['macroprojeto_id'];
            $turno = trim((string) $dados['turno']);
            $ldaId = (int) $dados['lda_id'];

            $conversaId = $this->garantirConversaAtiva($macroprojetoId, $turno, $ldaId);

            DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
                'arquivada_em' => null,
                'dt_atualizacao' => $this->agora(),
            ]);

            return (int) DB::table('nat_rota_mensagem')->insertGetId([
                'conversa_id' => $conversaId,
                'macroprojeto_id' => $macroprojetoId,
                'rota_id' => null,
                'origem' => (string) $dados['origem'],
                'mensagem' => trim((string) $dados['mensagem']),
                'ocorrencia_id' => null,
                'broadcast_lote_id' => null,
                'usuario_login' => $dados['usuario_login'] ?? null,
                'usuario_nome' => $dados['usuario_nome'] ?? null,
                'dt_criacao' => $this->agora(),
            ], 'id');
        });
    }

    public function registrarMensagemNatNaConversa(
        int $conversaId,
        int $macroprojetoId,
        array $zonasPermitidas,
        bool $acessoTodasZonas,
        array $usuario,
        string $mensagem
    ): int {
        $conversa = $this->buscarConversaPorIdNoEscopo(
            $conversaId,
            $macroprojetoId,
            $zonasPermitidas,
            $acessoTodasZonas,
            $usuario['login'] ?? null,
            false
        );

        if ($conversa === null) {
            throw new RuntimeException('A conversa informada nao pertence ao escopo autorizado.');
        }

        $mensagem = trim($mensagem);
        if ($mensagem === '') {
            throw new RuntimeException('Informe a mensagem antes de enviar.');
        }

        return $this->registrarMensagem([
            'macroprojeto_id' => $macroprojetoId,
            'turno' => (string) ($conversa['turno'] ?? ''),
            'lda_id' => (int) ($conversa['lda_id'] ?? 0),
            'origem' => self::ORIGEM_NAT,
            'mensagem' => $mensagem,
            'usuario_login' => $usuario['login'] ?? null,
            'usuario_nome' => $usuario['nome'] ?? null,
        ]);
    }

    public function arquivarConversaPorIdNoEscopo(int $conversaId, int $macroprojetoId, array $zonasPermitidas, bool $acessoTodasZonas): void
    {
        $conversa = $this->buscarConversaPorIdNoEscopo(
            $conversaId,
            $macroprojetoId,
            $zonasPermitidas,
            $acessoTodasZonas,
            null,
            false
        );

        if ($conversa === null) {
            throw new RuntimeException('A conversa informada nao pertence ao escopo autorizado.');
        }

        DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
            'arquivada_em' => $this->agora(),
            'dt_atualizacao' => $this->agora(),
        ]);
    }

    public function arquivarConversaMesario(int $conversaId, int $macroprojetoId, int $ldaId): void
    {
        if ($conversaId <= 0 || $macroprojetoId <= 0 || $ldaId <= 0) {
            throw new RuntimeException('Parametros invalidos para arquivar a conversa.');
        }

        $existe = DB::table('nat_rota_conversa')
            ->where('id', $conversaId)
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('lda_id', $ldaId)
            ->where('escopo_tipo', 'LDA')
            ->whereNull('arquivada_em')
            ->exists();

        if (! $existe) {
            throw new RuntimeException('A conversa informada nao pertence ao seu local de votacao ou ja esta arquivada.');
        }

        DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
            'arquivada_em' => $this->agora(),
            'dt_atualizacao' => $this->agora(),
        ]);
    }

    public function buscarConversaPorIdNoEscopo(
        int $conversaId,
        int $macroprojetoId,
        array $zonasPermitidas,
        bool $acessoTodasZonas,
        ?string $usuarioLogin,
        bool $arquivada = false
    ): ?array {
        $usuario = $this->normalizarUsuario($usuarioLogin);
        if ($conversaId <= 0 || $macroprojetoId <= 0) {
            return null;
        }

        $zonas = $this->normalizarZonas($zonasPermitidas);
        if (! $acessoTodasZonas && $zonas === []) {
            return null;
        }

        $query = DB::table('nat_rota_conversa as c')
            ->join('lda as l', 'l.id', '=', 'c.lda_id')
            ->leftJoin('zona as z', 'z.id', '=', 'l.zona_id')
            ->where('c.id', $conversaId)
            ->where('c.escopo_tipo', 'LDA')
            ->where('c.macroprojeto_id', $macroprojetoId);

        if ($arquivada) {
            $query->whereNotNull('c.arquivada_em');
        } else {
            $query->whereNull('c.arquivada_em');
        }

        if (! $acessoTodasZonas) {
            $query->whereIn('z.num_zona', $zonas);
        }

        $query->selectRaw(" c.id as conversa_id, 
                            c.lda_id, c.turno,  
                            l.nome_local as lda_nome,  
                            z.num_zona as zona_numero,
                            TO_CHAR(c.dt_atualizacao, 'DD/MM HH24:MI') as conversa_data_fmt,
                            (SELECT MAX(m1.id)
                            FROM nat_rota_mensagem m1
                            WHERE m1.conversa_id = c.id) as ultima_mensagem_id,
                            (SELECT DBMS_LOB.SUBSTR(m4.mensagem, 120, 1)
                            FROM nat_rota_mensagem m4
                             WHERE m4.id = (SELECT MAX(m5.id) FROM nat_rota_mensagem m5 
                             WHERE m5.conversa_id = c.id)) as ultima_mensagem_resumo,
                                         (SELECT TO_CHAR(MAX(m6.dt_criacao), 'DD/MM HH24:MI')
                                          FROM nat_rota_mensagem m6
                                          WHERE m6.conversa_id = c.id) as ultima_data_fmt  ");

        if ($usuario !== null) {
            $query->selectRaw(
                "(SELECT COUNT(*)
                    FROM nat_rota_mensagem mu
                   WHERE mu.conversa_id = c.id
                     AND UPPER(NVL(TRIM(mu.usuario_login), '#')) <> ?
                     AND NOT EXISTS (
                        SELECT 1
                          FROM nat_rota_mensagem_leitura lu
                         WHERE lu.mensagem_id = mu.id
                           AND UPPER(TRIM(lu.usuario_login)) = ?
                     )) as nao_lidas",
                [$usuario, $usuario]
            );
        } else {
            $query->selectRaw('0 as nao_lidas');
        }

        $item = $query->first();
        if ($item === null) {
            return null;
        }

        return [
            'escopo_tipo' => 'LDA',
            'rota_id' => null,
            'rota_numero' => null,
            'rota_descricao' => '',
            'lda_id' => (int) $item->lda_id,
            'lda_nome' => (string) ($item->lda_nome ?? ''),
            'turno' => trim((string) ($item->turno ?? '')),
            'zona_numero' => isset($item->zona_numero) ? (int) $item->zona_numero : null,
            'conversa_id' => (int) $item->conversa_id,
            'arquivada' => $arquivada,
            'arquivada_em_fmt' => null,
            'conversa_data_fmt' => $item->conversa_data_fmt ? (string) $item->conversa_data_fmt : null,
            'ultima_mensagem_id' => isset($item->ultima_mensagem_id) ? (int) $item->ultima_mensagem_id : null,
            'ultima_mensagem_resumo' => trim((string) ($item->ultima_mensagem_resumo ?? '')),
            'ultima_data_fmt' => $item->ultima_data_fmt ? (string) $item->ultima_data_fmt : null,
            'nao_lidas' => (int) ($item->nao_lidas ?? 0),
        ];
    }

    public function primeiraConversaNoEscopo(
        int $macroprojetoId,
        string $turno,
        array $zonasPermitidas,
        bool $acessoTodasZonas,
        ?string $usuarioLogin,
        bool $arquivada = false
    ): ?array {
        $usuario = $this->normalizarUsuario($usuarioLogin);
        if ($macroprojetoId <= 0 || trim($turno) === '') {
            return null;
        }

        $zonas = $this->normalizarZonas($zonasPermitidas);
        if (! $acessoTodasZonas && $zonas === []) {
            return null;
        }

        $query = DB::table('nat_rota_conversa as c')
            ->join('lda as l', 'l.id', '=', 'c.lda_id')
            ->leftJoin('zona as z', 'z.id', '=', 'l.zona_id')
            ->where('c.escopo_tipo', 'LDA')
            ->where('c.turno', trim($turno))
            ->where('c.macroprojeto_id', $macroprojetoId);

        if ($arquivada) {
            $query->whereNotNull('c.arquivada_em');
        } else {
            $query->whereNull('c.arquivada_em');
        }

        if (! $acessoTodasZonas) {
            $query->whereIn('z.num_zona', $zonas);
        }

        $query->orderByDesc('c.dt_atualizacao');

        $query->selectRaw("
            c.id as conversa_id,
            c.lda_id,
            c.turno,
            l.nome_local as lda_nome,
            z.num_zona as zona_numero,
            TO_CHAR(c.dt_atualizacao, 'DD/MM HH24:MI') as conversa_data_fmt,
            (SELECT MAX(m1.id)
               FROM nat_rota_mensagem m1
              WHERE m1.conversa_id = c.id) as ultima_mensagem_id,
            (SELECT DBMS_LOB.SUBSTR(m4.mensagem, 120, 1)
               FROM nat_rota_mensagem m4
              WHERE m4.id = (SELECT MAX(m5.id) FROM nat_rota_mensagem m5 WHERE m5.conversa_id = c.id)) as ultima_mensagem_resumo,
            (SELECT TO_CHAR(MAX(m6.dt_criacao), 'DD/MM HH24:MI')
               FROM nat_rota_mensagem m6
              WHERE m6.conversa_id = c.id) as ultima_data_fmt
        ");

        if ($usuario !== null) {
            $query->selectRaw(
                "(SELECT COUNT(*)
                    FROM nat_rota_mensagem mu
                   WHERE mu.conversa_id = c.id
                     AND UPPER(NVL(TRIM(mu.usuario_login), '#')) <> ?
                     AND NOT EXISTS (
                        SELECT 1
                          FROM nat_rota_mensagem_leitura lu
                         WHERE lu.mensagem_id = mu.id
                           AND UPPER(TRIM(lu.usuario_login)) = ?
                     )) as nao_lidas",
                [$usuario, $usuario]
            );
        } else {
            $query->selectRaw('0 as nao_lidas');
        }

        $item = $query->first();
        if ($item === null) {
            return null;
        }

        return [
            'escopo_tipo' => 'LDA',
            'rota_id' => null,
            'rota_numero' => null,
            'rota_descricao' => '',
            'lda_id' => (int) $item->lda_id,
            'lda_nome' => (string) ($item->lda_nome ?? ''),
            'turno' => trim((string) ($item->turno ?? '')),
            'zona_numero' => isset($item->zona_numero) ? (int) $item->zona_numero : null,
            'conversa_id' => (int) $item->conversa_id,
            'arquivada' => $arquivada,
            'arquivada_em_fmt' => null,
            'conversa_data_fmt' => $item->conversa_data_fmt ? (string) $item->conversa_data_fmt : null,
            'ultima_mensagem_id' => isset($item->ultima_mensagem_id) ? (int) $item->ultima_mensagem_id : null,
            'ultima_mensagem_resumo' => trim((string) ($item->ultima_mensagem_resumo ?? '')),
            'ultima_data_fmt' => $item->ultima_data_fmt ? (string) $item->ultima_data_fmt : null,
            'nao_lidas' => (int) ($item->nao_lidas ?? 0),
        ];
    }

    /**
     * Card por LDA com mensagens nao lidas, no escopo do operador (zonas + macroprojeto + turno).
     * Um registro por LDA com nao lidas; nunca consolidado, nunca por rota_id.
     */
    public function cardsLdaComNaoLidas(
        int $macroprojetoId,
        array $zonasPermitidas,
        bool $acessoTodasZonas,
        ?string $usuarioLogin,
        ?string $turno = null
    ): array {
        $usuario = $this->normalizarUsuario($usuarioLogin);
        if ($macroprojetoId <= 0 || $usuario === null) {
            return [];
        }

        $zonas = $this->normalizarZonas($zonasPermitidas);
        if (! $acessoTodasZonas && $zonas === []) {
            return [];
        }

        $query = DB::table('nat_rota_conversa as c')
            ->join('lda as l', 'l.id', '=', 'c.lda_id')
            ->leftJoin('zona as z', 'z.id', '=', 'l.zona_id')
            ->where('c.escopo_tipo', 'LDA')
            ->where('c.macroprojeto_id', $macroprojetoId)
            ->whereNull('c.arquivada_em');

        if ($turno !== null && trim($turno) !== '') {
            $query->where('c.turno', trim($turno));
        }

        if (! $acessoTodasZonas) {
            $query->whereIn('z.num_zona', $zonas);
        }

        return $query
            ->selectRaw(
                "c.lda_id,
                 c.id as conversa_id,
                 l.nome_local as lda_nome,
                 z.num_zona as zona_numero,
                 (SELECT COUNT(*)
                    FROM nat_rota_mensagem mu
                   WHERE mu.conversa_id = c.id
                     AND UPPER(NVL(TRIM(mu.usuario_login), '#')) <> ?
                     AND NOT EXISTS (
                        SELECT 1 FROM nat_rota_mensagem_leitura lu
                         WHERE lu.mensagem_id = mu.id
                           AND UPPER(TRIM(lu.usuario_login)) = ?
                     )) as nao_lidas",
                [$usuario, $usuario]
            )
            ->get()
            ->map(static fn ($item) => [
                'lda_id' => (int) $item->lda_id,
                'conversa_id' => (int) $item->conversa_id,
                'lda_nome' => (string) ($item->lda_nome ?? ''),
                'zona_numero' => isset($item->zona_numero) ? (int) $item->zona_numero : null,
                'nao_lidas' => (int) ($item->nao_lidas ?? 0),
            ])
            ->filter(static fn (array $card) => $card['nao_lidas'] > 0)
            ->values()
            ->all();
    }

    public function ldaPertenceAoEscopo(int $ldaId, array $zonasPermitidas, bool $acessoTodasZonas): bool
    {
        if ($ldaId <= 0) {
            return false;
        }
        if ($acessoTodasZonas) {
            return DB::table('lda')->where('id', $ldaId)->exists();
        }

        $zonas = $this->normalizarZonas($zonasPermitidas);
        if ($zonas === []) {
            return false;
        }

        return DB::table('lda as l')
            ->join('zona as z', 'z.id', '=', 'l.zona_id')
            ->where('l.id', $ldaId)
            ->whereIn('z.num_zona', $zonas)
            ->exists();
    }

    public function garantirConversaAtiva(int $macroprojetoId, string $turno, int $ldaId): int
    {
        $existente = $this->idConversaAtiva($macroprojetoId, $turno, $ldaId);
        if ($existente !== null) {
            return $existente;
        }

        try {
            DB::table('nat_rota_conversa')->insert([
                'macroprojeto_id' => $macroprojetoId,
                'escopo_tipo' => 'LDA',
                'lda_id' => $ldaId,
                'rota_id' => null,
                'turno' => $turno,
                'arquivada_em' => null,
                'dt_criacao' => $this->agora(),
                'dt_atualizacao' => $this->agora(),
            ]);
        } catch (QueryException $e) {
            if (! str_contains($e->getMessage(), 'ORA-00001')) {
                throw $e;
            }
        }

        $id = $this->idConversaAtiva($macroprojetoId, $turno, $ldaId);
        if ($id === null) {
            throw new RuntimeException(
                "Nao foi possivel garantir conversa LDA para macroprojeto {$macroprojetoId} / turno {$turno} / lda {$ldaId}."
            );
        }

        return $id;
    }

    private function agora(): Expression
    {
        return DB::raw(DB::connection()->getDriverName() === 'sqlite' ? 'CURRENT_TIMESTAMP' : 'SYSDATE');
    }

    private function normalizarZonas(array $zonas): array
    {
        return collect($zonas)
            ->map(static fn ($v) => is_numeric($v) ? (int) $v : null)
            ->filter(static fn ($v) => is_int($v))
            ->unique()
            ->values()
            ->all();
    }

    private function normalizarUsuario(?string $usuarioLogin): ?string
    {
        $usuarioLogin = trim((string) $usuarioLogin);

        return $usuarioLogin === '' ? null : mb_strtoupper($usuarioLogin, 'UTF-8');
    }
}
```
</APP_REPOSITORIES_LDA_LDACONVERSAMENSAGEMREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Nat/NatRotaMensagemRepository.php`
## <APP_REPOSITORIES_NAT_NATROTAMENSAGEMREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Nat/NatRotaMensagemRepository.php`
- **Namespace Declaração:** `App\Repositories\Nat`
- **Entidade / Classe:** `class NatRotaMensagemRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('nat_rota_mensagem as m')
DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
return (int) DB::table('nat_rota_mensagem')->insertGetId([
DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
return (int) DB::table('nat_rota_mensagem as m')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarConversasPorRotas(array $rotaIds, int $macroprojetoId, ?string $usuarioLogin, bool $arquivadas = false): array
public function listarMensagensDaConversa(int $conversaId): array
public function registrarMensagem(array $dados): int
public function arquivarConversaAtiva(int $macroprojetoId, int $rotaId): void
public function marcarConversaComoLida(int $conversaId, string $usuarioLogin, ?string $usuarioNome): int
public function contarNaoLidas(array $rotaIds, int $macroprojetoId, ?string $usuarioLogin): int
public function ultimaMensagemIdNoEscopo(array $rotaIds, int $macroprojetoId): ?int
public function ultimaLeituraIdNoEscopo(array $rotaIds, int $macroprojetoId): ?int
public function maxConversaAtivaIdNoEscopo(array $rotaIds, int $macroprojetoId): ?int
public function contarNaoLidasPorConversaIds(array $conversaIds, ?string $usuarioLogin): int
public function ultimaMensagemIdPorConversaIds(array $conversaIds): ?int
public function ultimaLeituraIdPorConversaIds(array $conversaIds): ?int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Nat;

use App\Support\Access\EscopoZonal;
use Illuminate\Contracts\Database\Query\Expression;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class NatRotaMensagemRepository
{
    public function listarConversasPorRotas(array $rotaIds, int $macroprojetoId, ?string $usuarioLogin, bool $arquivadas = false): array
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($macroprojetoId <= 0 || $rotaIds === []) {
            return [];
        }

        return $arquivadas
            ? $this->listarConversasArquivadas($rotaIds, $macroprojetoId)
            : $this->listarConversasAtivas($rotaIds, $macroprojetoId, $usuarioLogin);
    }

    public function listarMensagensDaConversa(int $conversaId): array
    {
        if ($conversaId <= 0) {
            return [];
        }

        return DB::table('nat_rota_mensagem as m')
            ->where('m.conversa_id', $conversaId)
            ->selectRaw("
                m.id,
                m.conversa_id,
                m.rota_id,
                m.origem,
                DBMS_LOB.SUBSTR(m.mensagem, 4000, 1) as mensagem,
                m.ocorrencia_id,
                m.broadcast_lote_id,
                m.usuario_login,
                m.usuario_nome,
                TO_CHAR(m.dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                (SELECT COUNT(*) FROM nat_rota_mensagem_leitura l1 WHERE l1.mensagem_id = m.id) as leitores_total,
                (SELECT LISTAGG(NVL(TRIM(l2.usuario_nome), TRIM(l2.usuario_login)), ', ') WITHIN GROUP (ORDER BY NVL(TRIM(l2.usuario_nome), TRIM(l2.usuario_login)))
                   FROM nat_rota_mensagem_leitura l2
                  WHERE l2.mensagem_id = m.id) as leitores_label
            ")
            ->orderBy('m.id')
            ->get()
            ->map(function ($item) {
                return [
                    'id' => (int) $item->id,
                    'conversa_id' => (int) $item->conversa_id,
                    'rota_id' => (int) $item->rota_id,
                    'origem' => (string) $item->origem,
                    'mensagem' => (string) ($item->mensagem ?? ''),
                    'ocorrencia_id' => isset($item->ocorrencia_id) ? (int) $item->ocorrencia_id : null,
                    'broadcast_lote_id' => $item->broadcast_lote_id ? (string) $item->broadcast_lote_id : null,
                    'usuario_login' => trim((string) ($item->usuario_login ?? '')) ?: null,
                    'usuario_nome' => trim((string) ($item->usuario_nome ?? '')) ?: null,
                    'dt_criacao_fmt' => (string) $item->dt_criacao_fmt,
                    'leitores_total' => (int) ($item->leitores_total ?? 0),
                    'leitores_label' => trim((string) ($item->leitores_label ?? '')) ?: null,
                ];
            })
            ->all();
    }

    public function registrarMensagem(array $dados): int
    {
        return DB::transaction(function () use ($dados): int {
            $conversaId = $this->garantirConversaAtiva(
                (int) $dados['macroprojeto_id'],
                (int) $dados['rota_id']
            );

            DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
                'arquivada_em' => null,
                'dt_atualizacao' => $this->agora(),
            ]);

            return (int) DB::table('nat_rota_mensagem')->insertGetId([
                'conversa_id' => $conversaId,
                'macroprojeto_id' => (int) $dados['macroprojeto_id'],
                'rota_id' => (int) $dados['rota_id'],
                'origem' => (string) $dados['origem'],
                'mensagem' => trim((string) $dados['mensagem']),
                'ocorrencia_id' => $dados['ocorrencia_id'] ?? null,
                'broadcast_lote_id' => $dados['broadcast_lote_id'] ?? null,
                'usuario_login' => $dados['usuario_login'] ?? null,
                'usuario_nome' => $dados['usuario_nome'] ?? null,
                'dt_criacao' => $this->agora(),
            ], 'id');
        });
    }

    public function arquivarConversaAtiva(int $macroprojetoId, int $rotaId): void
    {
        $conversaId = $this->buscarIdConversa($macroprojetoId, $rotaId, false);
        if ($conversaId === null) {
            return;
        }

        DB::table('nat_rota_conversa')->where('id', $conversaId)->update([
            'arquivada_em' => $this->agora(),
            'dt_atualizacao' => $this->agora(),
        ]);
    }

    public function marcarConversaComoLida(int $conversaId, string $usuarioLogin, ?string $usuarioNome): int
    {
        $usuarioNormalizado = $this->normalizarUsuario($usuarioLogin);
        if ($conversaId <= 0 || $usuarioNormalizado === null) {
            return 0;
        }

        $sql = <<<'SQL'
INSERT INTO nat_rota_mensagem_leitura (mensagem_id, rota_id, usuario_login, usuario_nome, dt_leitura)
SELECT m.id, m.rota_id, :usuario_login, :usuario_nome, SYSDATE
  FROM nat_rota_mensagem m
 WHERE m.conversa_id = :conversa_id
   AND UPPER(NVL(TRIM(m.usuario_login), '#')) <> :usuario_norm_msg
   AND NOT EXISTS (
       SELECT 1
         FROM nat_rota_mensagem_leitura l
        WHERE l.mensagem_id = m.id
          AND UPPER(TRIM(l.usuario_login)) = :usuario_norm_lido
   )
SQL;
        $bindings = [
            'usuario_login' => trim($usuarioLogin),
            'usuario_nome' => $usuarioNome,
            'conversa_id' => $conversaId,
            'usuario_norm_msg' => $usuarioNormalizado,
            'usuario_norm_lido' => $usuarioNormalizado,
        ];

        return DB::affectingStatement($sql, $bindings);
    }

    public function contarNaoLidas(array $rotaIds, int $macroprojetoId, ?string $usuarioLogin): int
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        $usuarioNormalizado = $this->normalizarUsuario($usuarioLogin);
        if ($macroprojetoId <= 0 || $rotaIds === [] || $usuarioNormalizado === null) {
            return 0;
        }

        return (int) DB::table('nat_rota_mensagem as m')
            ->join('nat_rota_conversa as c', 'c.id', '=', 'm.conversa_id')
            ->where('c.macroprojeto_id', $macroprojetoId)
            ->whereIn('c.rota_id', $rotaIds)
            ->whereNull('c.arquivada_em')
            ->whereRaw("UPPER(NVL(TRIM(m.usuario_login), '#')) <> ?", [$usuarioNormalizado])
            ->whereNotExists(function ($sub) use ($usuarioNormalizado) {
                $sub->selectRaw('1')
                    ->from('nat_rota_mensagem_leitura as l')
                    ->whereColumn('l.mensagem_id', 'm.id')
                    ->whereRaw('UPPER(TRIM(l.usuario_login)) = ?', [$usuarioNormalizado]);
            })
            ->count();
    }

    public function ultimaMensagemIdNoEscopo(array $rotaIds, int $macroprojetoId): ?int
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($macroprojetoId <= 0 || $rotaIds === []) {
            return null;
        }

        $valor = DB::table('nat_rota_mensagem as m')
            ->join('nat_rota_conversa as c', 'c.id', '=', 'm.conversa_id')
            ->where('c.macroprojeto_id', $macroprojetoId)
            ->whereIn('c.rota_id', $rotaIds)
            ->whereNull('c.arquivada_em')
            ->max('m.id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    public function ultimaLeituraIdNoEscopo(array $rotaIds, int $macroprojetoId): ?int
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($macroprojetoId <= 0 || $rotaIds === []) {
            return null;
        }

        $valor = DB::table('nat_rota_mensagem_leitura as l')
            ->join('nat_rota_mensagem as m', 'm.id', '=', 'l.mensagem_id')
            ->join('nat_rota_conversa as c', 'c.id', '=', 'm.conversa_id')
            ->where('c.macroprojeto_id', $macroprojetoId)
            ->whereIn('c.rota_id', $rotaIds)
            ->whereNull('c.arquivada_em')
            ->max('l.id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    public function maxConversaAtivaIdNoEscopo(array $rotaIds, int $macroprojetoId): ?int
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($macroprojetoId <= 0 || $rotaIds === []) {
            return null;
        }

        $valor = DB::table('nat_rota_conversa')
            ->where('macroprojeto_id', $macroprojetoId)
            ->whereIn('rota_id', $rotaIds)
            ->whereNull('arquivada_em')
            ->max('id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    public function contarNaoLidasPorConversaIds(array $conversaIds, ?string $usuarioLogin): int
    {
        $conversaIds = $this->normalizarIds($conversaIds);
        $usuarioNormalizado = $this->normalizarUsuario($usuarioLogin);
        if ($conversaIds === [] || $usuarioNormalizado === null) {
            return 0;
        }

        return (int) DB::table('nat_rota_mensagem as m')
            ->whereIn('m.conversa_id', $conversaIds)
            ->whereRaw("UPPER(NVL(TRIM(m.usuario_login), '#')) <> ?", [$usuarioNormalizado])
            ->whereNotExists(function ($sub) use ($usuarioNormalizado) {
                $sub->selectRaw('1')
                    ->from('nat_rota_mensagem_leitura as l')
                    ->whereColumn('l.mensagem_id', 'm.id')
                    ->whereRaw('UPPER(TRIM(l.usuario_login)) = ?', [$usuarioNormalizado]);
            })
            ->count();
    }

    public function ultimaMensagemIdPorConversaIds(array $conversaIds): ?int
    {
        $conversaIds = $this->normalizarIds($conversaIds);
        if ($conversaIds === []) {
            return null;
        }

        $valor = DB::table('nat_rota_mensagem')
            ->whereIn('conversa_id', $conversaIds)
            ->max('id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    public function ultimaLeituraIdPorConversaIds(array $conversaIds): ?int
    {
        $conversaIds = $this->normalizarIds($conversaIds);
        if ($conversaIds === []) {
            return null;
        }

        $valor = DB::table('nat_rota_mensagem_leitura as l')
            ->join('nat_rota_mensagem as m', 'm.id', '=', 'l.mensagem_id')
            ->whereIn('m.conversa_id', $conversaIds)
            ->max('l.id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    public function ocorrenciaPertenceRota(int $ocorrenciaId, int $rotaId): bool
    {
        return DB::table('nat_ocorrencia')
            ->where('id_ocorrencia', $ocorrenciaId)
            ->where('rota_id', $rotaId)
            ->exists();
    }

    public function conversaAtivaArquivavel(int $macroprojetoId, int $rotaId): bool
    {
        return $this->buscarIdConversa($macroprojetoId, $rotaId, false) !== null;
    }

    public function cardsRotaComNaoLidas(
        int $macroprojetoId,
        array $zonasPermitidas,
        bool $acessoTodasZonas,
        ?string $usuarioLogin
    ): array {
        $usuarioNormalizado = $this->normalizarUsuario($usuarioLogin);
        $escopo = EscopoZonal::from($zonasPermitidas, $acessoTodasZonas);

        if ($macroprojetoId <= 0 || $usuarioNormalizado === null || $escopo->semAcesso()) {
            return [];
        }

        $query = DB::table('nat_rota_conversa as c')
            ->join('rota as r', 'r.id', '=', 'c.rota_id')
            ->leftJoin('zona as z', 'z.id', '=', 'r.zona_id')
            ->join('nat_rota_mensagem as m', 'm.conversa_id', '=', 'c.id')
            ->where('c.escopo_tipo', 'ROTA')
            ->where('c.macroprojeto_id', $macroprojetoId)
            ->whereNull('c.arquivada_em')
            ->whereRaw("UPPER(COALESCE(TRIM(m.usuario_login), '#')) <> ?", [$usuarioNormalizado])
            ->whereNotExists(function ($sub) use ($usuarioNormalizado) {
                $sub->selectRaw('1')
                    ->from('nat_rota_mensagem_leitura as l')
                    ->whereColumn('l.mensagem_id', 'm.id')
                    ->whereRaw('UPPER(TRIM(l.usuario_login)) = ?', [$usuarioNormalizado]);
            });

        if (! $escopo->acessoTodas()) {
            $query->whereIn('z.num_zona', $escopo->zonas());
        }

        return $query
            ->selectRaw('c.rota_id, r.numero as rota_numero, r.descricao as rota_descricao, COUNT(*) as nao_lidas')
            ->groupBy('c.rota_id', 'r.numero', 'r.descricao')
            ->orderBy('r.numero')
            ->get()
            ->map(static fn ($item) => [
                'rota_id' => (int) $item->rota_id,
                'rota_numero' => (int) ($item->rota_numero ?? 0),
                'rota_descricao' => (string) ($item->rota_descricao ?? ''),
                'nao_lidas' => (int) ($item->nao_lidas ?? 0),
            ])
            ->all();
    }

    private function listarConversasAtivas(array $rotaIds, int $macroprojetoId, ?string $usuarioLogin): array
    {
        $usuarioNormalizado = $this->normalizarUsuario($usuarioLogin);
        $macroprojetoId = (int) $macroprojetoId;
        $subquery = "(SELECT MAX(c2.id) FROM nat_rota_conversa c2 WHERE c2.macroprojeto_id = {$macroprojetoId} AND c2.rota_id = r.id AND c2.arquivada_em IS NULL)";

        $query = DB::table('rota as r')
            ->leftJoin('nat_rota_conversa as nc', function ($join) use ($subquery) {
                $join->on('nc.id', '=', DB::raw($subquery));
            })
            ->whereIn('r.id', $rotaIds)
            ->selectRaw("
                r.id as rota_id,
                r.numero as rota_numero,
                r.descricao as rota_descricao,
                nc.id as conversa_id,
                TO_CHAR(nc.dt_atualizacao, 'DD/MM HH24:MI') as conversa_data_fmt,
                (SELECT MAX(m1.id)
                   FROM nat_rota_mensagem m1
                  WHERE m1.conversa_id = nc.id) as ultima_mensagem_id,
                (SELECT DBMS_LOB.SUBSTR(m4.mensagem, 120, 1)
                   FROM nat_rota_mensagem m4
                  WHERE m4.id = (SELECT MAX(m5.id) FROM nat_rota_mensagem m5 WHERE m5.conversa_id = nc.id)) as ultima_mensagem_resumo,
                (SELECT TO_CHAR(MAX(m6.dt_criacao), 'DD/MM HH24:MI')
                   FROM nat_rota_mensagem m6
                  WHERE m6.conversa_id = nc.id) as ultima_data_fmt
            ");

        if ($usuarioNormalizado !== null) {
            $query->selectRaw(
                "(SELECT COUNT(*)
                    FROM nat_rota_mensagem mu
                   WHERE mu.conversa_id = nc.id
                     AND UPPER(NVL(TRIM(mu.usuario_login), '#')) <> ?
                     AND NOT EXISTS (
                        SELECT 1
                          FROM nat_rota_mensagem_leitura lu
                         WHERE lu.mensagem_id = mu.id
                           AND UPPER(TRIM(lu.usuario_login)) = ?
                     )) as nao_lidas",
                [$usuarioNormalizado, $usuarioNormalizado]
            );
        } else {
            $query->selectRaw('0 as nao_lidas');
        }

        return $query
            ->orderByRaw('CASE WHEN nc.id IS NULL THEN 1 ELSE 0 END')
            ->orderByRaw('NVL((SELECT MAX(m7.dt_criacao) FROM nat_rota_mensagem m7 WHERE m7.conversa_id = nc.id), nc.dt_atualizacao) DESC NULLS LAST')
            ->orderBy('r.numero')
            ->get()
            ->map(fn ($item) => $this->mapearConversa($item, false))
            ->all();
    }

    private function listarConversasArquivadas(array $rotaIds, int $macroprojetoId): array
    {
        return DB::table('nat_rota_conversa as nc')
            ->join('rota as r', 'r.id', '=', 'nc.rota_id')
            ->where('nc.macroprojeto_id', $macroprojetoId)
            ->whereIn('nc.rota_id', $rotaIds)
            ->whereNotNull('nc.arquivada_em')
            ->selectRaw("
                r.id as rota_id,
                r.numero as rota_numero,
                r.descricao as rota_descricao,
                nc.id as conversa_id,
                TO_CHAR(nc.arquivada_em, 'DD/MM/YYYY HH24:MI') as arquivada_em_fmt,
                TO_CHAR(nc.dt_atualizacao, 'DD/MM HH24:MI') as conversa_data_fmt,
                (SELECT MAX(m1.id)
                   FROM nat_rota_mensagem m1
                  WHERE m1.conversa_id = nc.id) as ultima_mensagem_id,
                (SELECT DBMS_LOB.SUBSTR(m4.mensagem, 120, 1)
                   FROM nat_rota_mensagem m4
                  WHERE m4.id = (SELECT MAX(m5.id) FROM nat_rota_mensagem m5 WHERE m5.conversa_id = nc.id)) as ultima_mensagem_resumo,
                (SELECT TO_CHAR(MAX(m6.dt_criacao), 'DD/MM HH24:MI')
                   FROM nat_rota_mensagem m6
                  WHERE m6.conversa_id = nc.id) as ultima_data_fmt,
                0 as nao_lidas
            ")
            ->orderByDesc('nc.id')
            ->get()
            ->map(fn ($item) => $this->mapearConversa($item, true))
            ->all();
    }

    private function mapearConversa(object $item, bool $arquivada): array
    {
        return [
            'rota_id' => (int) $item->rota_id,
            'rota_numero' => (int) ($item->rota_numero ?? 0),
            'rota_descricao' => (string) ($item->rota_descricao ?? ''),
            'conversa_id' => isset($item->conversa_id) ? (int) $item->conversa_id : null,
            'arquivada' => $arquivada,
            'arquivada_em_fmt' => $item->arquivada_em_fmt ?? null,
            'conversa_data_fmt' => $item->conversa_data_fmt ? (string) $item->conversa_data_fmt : null,
            'ultima_mensagem_id' => isset($item->ultima_mensagem_id) ? (int) $item->ultima_mensagem_id : null,
            'ultima_mensagem_resumo' => trim((string) ($item->ultima_mensagem_resumo ?? '')),
            'ultima_data_fmt' => $item->ultima_data_fmt ? (string) $item->ultima_data_fmt : null,
            'nao_lidas' => (int) ($item->nao_lidas ?? 0),
        ];
    }

    private function garantirConversaAtiva(int $macroprojetoId, int $rotaId): int
    {
        $existente = $this->buscarIdConversa($macroprojetoId, $rotaId, false);
        if ($existente !== null) {
            return $existente;
        }

        try {
            DB::table('nat_rota_conversa')->insert([
                'macroprojeto_id' => $macroprojetoId,
                'escopo_tipo' => 'ROTA',
                'rota_id' => $rotaId,
                'arquivada_em' => null,
                'dt_criacao' => $this->agora(),
                'dt_atualizacao' => $this->agora(),
            ]);
        } catch (QueryException $e) {
            if (! str_contains($e->getMessage(), 'ORA-00001')) {
                throw $e;
            }

            // Corrida: outro processo criou a conversa ativa entre o check e o insert.
            // O índice único funcional garantiu que não há duplicata — basta re-buscar.
        }

        $id = (int) DB::table('nat_rota_conversa')
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('rota_id', $rotaId)
            ->whereNull('arquivada_em')
            ->orderByDesc('id')
            ->value('id');

        if ($id <= 0) {
            throw new RuntimeException(
                "Não foi possível garantir conversa ativa para macroprojeto {$macroprojetoId} / rota {$rotaId}."
            );
        }

        return $id;
    }

    private function buscarIdConversa(int $macroprojetoId, int $rotaId, ?bool $arquivada = null): ?int
    {
        $query = DB::table('nat_rota_conversa')
            ->where('macroprojeto_id', $macroprojetoId)
            ->where('rota_id', $rotaId);

        if ($arquivada === true) {
            $query->whereNotNull('arquivada_em');
        } elseif ($arquivada === false) {
            $query->whereNull('arquivada_em');
        }

        $valor = $query->orderByDesc('id')->value('id');

        return is_numeric($valor) ? (int) $valor : null;
    }

    private function agora(): Expression
    {
        return DB::raw(DB::connection()->getDriverName() === 'sqlite' ? 'CURRENT_TIMESTAMP' : 'SYSDATE');
    }

    private function normalizarIds(array $rotaIds): array
    {
        return collect($rotaIds)
            ->map(static fn ($valor) => is_array($valor) ? ($valor['id'] ?? null) : $valor)
            ->map(static fn ($valor) => is_numeric($valor) ? (int) $valor : null)
            ->filter(static fn ($valor) => is_int($valor) && $valor > 0)
            ->unique()
            ->values()
            ->all();
    }

    private function normalizarUsuario(?string $usuarioLogin): ?string
    {
        $usuarioLogin = trim((string) $usuarioLogin);
        if ($usuarioLogin === '') {
            return null;
        }

        return mb_strtoupper($usuarioLogin, 'UTF-8');
    }
}
```
</APP_REPOSITORIES_NAT_NATROTAMENSAGEMREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/Contracts/SmsGatewayInterface.php`
## <APP_SERVICES_CONVOCACAOSMS_CONTRACTS_SMSGATEWAYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/Contracts/SmsGatewayInterface.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms\Contracts`
- **Entidade / Classe:** `interface SmsGatewayInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function enviar(string $destino, string $texto, string $externalId): SmsEnvioResultado;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms\Contracts;

use App\Services\ConvocacaoSms\SmsEnvioResultado;

interface SmsGatewayInterface
{
    public function enviar(string $destino, string $texto, string $externalId): SmsEnvioResultado;
}
```
</APP_SERVICES_CONVOCACAOSMS_CONTRACTS_SMSGATEWAYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsContexto.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSCONTEXTO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsContexto.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsContexto`

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

namespace App\Services\ConvocacaoSms;

final readonly class ConvocacaoSmsContexto
{
    /** @param array<int, string> $zonasPermitidas */
    public function __construct(
        public int $macroprojetoId,
        public int $macroprojetoTurnoId,
        public string $turno,
        public string $codPleito,
        public string $dataEleicao,
        public string $usuarioLogin,
        public string $usuarioNome,
        public bool $gestor,
        public bool $administrador,
        public array $zonasPermitidas,
        public bool $acessoTodasZonas,
        public bool $podeAlterarTelefone = false,
    ) {}
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSCONTEXTO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsContextoDoEnvio.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSCONTEXTODOENVIO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsContextoDoEnvio.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsContextoDoEnvio`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function criar(array $envio): ConvocacaoSmsContexto
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

final class ConvocacaoSmsContextoDoEnvio
{
    /** @param array<string, mixed> $envio */
    public function criar(array $envio): ConvocacaoSmsContexto
    {
        $zona = trim((string) ($envio['num_zona'] ?? ''));

        return new ConvocacaoSmsContexto(
            (int) ($envio['macroprojeto_id'] ?? 0),
            (int) ($envio['macroprojeto_turno_id'] ?? 0),
            trim((string) ($envio['turno'] ?? '')),
            trim((string) ($envio['cod_pleito'] ?? '')),
            trim((string) ($envio['dt_eleicao_iso'] ?? '')),
            trim((string) ($envio['usuario_login'] ?? 'worker')),
            trim((string) ($envio['usuario_nome'] ?? 'Worker de convocação')),
            false,
            false,
            $zona !== '' ? [$zona] : [],
            false,
        );
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSCONTEXTODOENVIO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsContextoSessao.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSCONTEXTOSESSAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsContextoSessao.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsContextoSessao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function atual(): ConvocacaoSmsContexto
private function dataValida(string $data): bool
private function normalizarZonas(array $zonas): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use DomainException;
use Illuminate\Auth\Access\AuthorizationException;

final readonly class ConvocacaoSmsContextoSessao
{
    public function __construct(
        private MacroprojetoTurnoRepository $turnos,
        private ConvocacaoSmsPermissaoService $permissoes,
    ) {}

    public function atual(): ConvocacaoSmsContexto
    {
        $macroprojetoId = (int) session('macroprojeto_ativo_id', 0);
        $usuarioLogin = trim((string) session('user.username', ''));
        $usuarioNome = trim((string) session('user.name', $usuarioLogin));
        $grupos = (array) session('matchingGroups', []);

        if ($macroprojetoId <= 0 || $usuarioLogin === '') {
            throw new DomainException('Contexto ativo da convocação por SMS não está disponível.');
        }
        if (! $this->permissoes->podeOperar($grupos)) {
            throw new AuthorizationException('Usuário sem perfil de convocação por SMS.');
        }

        $turno = $this->turnos->buscarAtivoPorMacroprojeto($macroprojetoId);
        $turnoId = (int) ($turno['id'] ?? 0);
        $numeroTurno = trim((string) ($turno['turno'] ?? ''));
        $codPleito = trim((string) ($turno['cod_pleito'] ?? ''));
        $dataEleicao = trim((string) ($turno['dt_eleicao'] ?? ''));
        if ($turnoId <= 0 || ! in_array($numeroTurno, ['1', '2'], true)) {
            throw new DomainException('Nenhum turno ativo válido está configurado para o macroprojeto.');
        }
        if ($codPleito === '' || ! $this->dataValida($dataEleicao)) {
            throw new DomainException('O turno ativo precisa de pleito e data da eleição configurados.');
        }

        $administrador = $this->permissoes->podeReenviarRejeitado($grupos);

        return new ConvocacaoSmsContexto(
            $macroprojetoId,
            $turnoId,
            $numeroTurno,
            $codPleito,
            $dataEleicao,
            $usuarioLogin,
            $usuarioNome !== '' ? $usuarioNome : $usuarioLogin,
            $this->permissoes->podeConsultarHistoricoGeral($grupos),
            $administrador,
            $this->normalizarZonas((array) session('cod_zonas_permitidas', [])),
            $administrador || session('acesso_todas_zonas') === true,
            $this->permissoes->podeAlterarTelefone($grupos),
        );
    }

    private function dataValida(string $data): bool
    {
        $objeto = \DateTimeImmutable::createFromFormat('!Y-m-d', $data);

        return $objeto !== false && $objeto->format('Y-m-d') === $data;
    }

    /**
     * @param  array<int, mixed>  $zonas
     * @return array<int, string>
     */
    private function normalizarZonas(array $zonas): array
    {
        return collect($zonas)
            ->map(static fn (mixed $zona): string => trim((string) $zona))
            ->filter(static fn (string $zona): bool => preg_match('/^\d+$/', $zona) === 1)
            ->map(static fn (string $zona): string => (string) ((int) $zona))
            ->unique()
            ->values()
            ->all();
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSCONTEXTOSESSAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsDashboardService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsDashboardService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsDashboardService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private ConvocacaoSmsDashboardRepositoryInterface $dashboard) {}
public function carregar(array $filtros, ConvocacaoSmsContexto $contexto): array
public function elegibilidade(array $filtros, ConvocacaoSmsContexto $contexto): array
private function normalizarFiltros(array $filtros, ConvocacaoSmsContexto $contexto): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDashboardRepositoryInterface;
use Illuminate\Auth\Access\AuthorizationException;

final readonly class ConvocacaoSmsDashboardService
{
    public function __construct(private ConvocacaoSmsDashboardRepositoryInterface $dashboard) {}

    /** @param array<string, mixed> $filtros @return array<string, mixed> */
    public function carregar(array $filtros, ConvocacaoSmsContexto $contexto): array
    {
        $filtros = $this->normalizarFiltros($filtros, $contexto);
        $zona = (string) ($filtros['zona'] ?? '');

        return array_merge(
            $this->dashboard->resumoPopulacao($contexto, $zona),
            $this->dashboard->resumoEnvios($contexto, $filtros),
        );
    }

    /**
     * @param  array<string, mixed>  $filtros
     * @return array{nao_confirmados_convoca_mais:int,atualizado_em:string}
     */
    public function elegibilidade(array $filtros, ConvocacaoSmsContexto $contexto): array
    {
        $filtros = $this->normalizarFiltros($filtros, $contexto);
        $zona = (string) ($filtros['zona'] ?? '');
        $resumo = $this->dashboard->resumoPopulacao($contexto, $zona);

        return [
            'nao_confirmados_convoca_mais' => $resumo['nao_confirmados_convoca_mais'],
            'atualizado_em' => now()->toIso8601String(),
        ];
    }

    /** @param array<string, mixed> $filtros @return array<string, string> */
    private function normalizarFiltros(array $filtros, ConvocacaoSmsContexto $contexto): array
    {
        $normalizados = [];
        $zona = trim((string) ($filtros['zona'] ?? ''));
        if ($zona !== '') {
            if (! $contexto->acessoTodasZonas && ! in_array($zona, $contexto->zonasPermitidas, true)) {
                throw new AuthorizationException('Zona fora do escopo autorizado para o dashboard SMS.');
            }
            $normalizados['zona'] = $zona;
        }
        foreach (['data_inicial', 'data_final'] as $campo) {
            $valor = trim((string) ($filtros[$campo] ?? ''));
            if ($valor !== '') {
                $normalizados[$campo] = $valor;
            }
        }

        return $normalizados;
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSDASHBOARDSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsDestinatarioAgrupador.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSDESTINATARIOAGRUPADOR_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsDestinatarioAgrupador.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsDestinatarioAgrupador`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function agrupar(iterable $linhas): array
private function resumirAtribuicao(array $atribuicao): string
private function camposLocalizacaoIndisponiveis(array $grupo, array $atribuicoes): array
private function valoresUnicos(array $atribuicoes, string $campo): array
private function completarConfirmacaoElo(array &$grupo): void
private function formatarOrigemElo(mixed $origem): ?string
private function formatarDataElo(mixed $data): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

final readonly class ConvocacaoSmsDestinatarioAgrupador
{
    public function __construct(
        private ConvocacaoSmsTelefone $telefones,
        private ConvocacaoSmsStatusService $status,
    ) {}

    /**
     * @param  iterable<int, object|array<string, mixed>>  $linhas
     * @return array<int, array<string, mixed>>
     */
    public function agrupar(iterable $linhas): array
    {
        $grupos = [];

        foreach ($linhas as $linhaOriginal) {
            $linha = (array) $linhaOriginal;
            if (mb_strtoupper(trim((string) ($linha['des_ind_situacao_pe'] ?? '')), 'UTF-8') !== 'NOMEADO') {
                continue;
            }

            $inscricao = trim((string) ($linha['num_inscricao'] ?? ''));
            $zona = trim((string) ($linha['num_zona'] ?? ''));
            if ($inscricao === '' || $zona === '') {
                continue;
            }

            $chave = $zona.'|'.$inscricao;
            if (! isset($grupos[$chave])) {
                $grupos[$chave] = [
                    'num_inscricao' => $inscricao,
                    'zona' => $zona,
                    'municipio' => trim((string) ($linha['nom_localidade'] ?? '')),
                    'nome' => trim((string) ($linha['nom_eleitor'] ?? '')) ?: $inscricao,
                    'cod_pleito' => trim((string) ($linha['cod_pleito'] ?? '')),
                    'data_eleicao' => trim((string) ($linha['data_eleicao'] ?? '')),
                    'status_codigo' => trim((string) ($linha['status_codigo'] ?? '')),
                    'envio_id' => ($linha['envio_id'] ?? null) !== null ? (int) $linha['envio_id'] : null,
                    'telefone' => null,
                    '_telefone_ordem' => PHP_INT_MAX,
                    'telefone_carga' => null,
                    '_telefone_carga_ordem' => PHP_INT_MAX,
                    '_telefone_diagnostico_codigo' => 'SEM_TELEFONE_INFORMADO',
                    '_telefone_diagnostico_ordem' => 0,
                    '_atribuicoes' => [],
                    '_respostas_elo' => [],
                ];
            }

            $avaliacaoTelefone = $this->telefones->avaliar($linha);
            $telefone = $avaliacaoTelefone['telefone'];
            $ordemTelefone = $this->telefones->ordemDaFonte($telefone['fonte'] ?? null);
            if ($telefone !== null && $ordemTelefone < $grupos[$chave]['_telefone_ordem']) {
                $grupos[$chave]['telefone'] = $telefone;
                $grupos[$chave]['_telefone_ordem'] = $ordemTelefone;
            }
            if ($telefone === null) {
                $ordemDiagnostico = $this->telefones->ordemDoDiagnostico($avaliacaoTelefone['diagnostico_codigo']);
                if ($ordemDiagnostico > $grupos[$chave]['_telefone_diagnostico_ordem']) {
                    $grupos[$chave]['_telefone_diagnostico_codigo'] = $avaliacaoTelefone['diagnostico_codigo'];
                    $grupos[$chave]['_telefone_diagnostico_ordem'] = $ordemDiagnostico;
                }
            }

            $telefoneCarga = $this->telefones->selecionarCarga($linha);
            $ordemCarga = $this->telefones->ordemDaFonte($telefoneCarga['fonte'] ?? null);
            if ($telefoneCarga !== null && $ordemCarga < $grupos[$chave]['_telefone_carga_ordem']) {
                $grupos[$chave]['telefone_carga'] = $telefoneCarga;
                $grupos[$chave]['_telefone_carga_ordem'] = $ordemCarga;
            }

            $atribuicao = [
                'numero_local' => trim((string) ($linha['num_local'] ?? '')),
                'local_votacao' => trim((string) ($linha['nom_local'] ?? '')),
                'secao' => trim((string) ($linha['num_secao'] ?? '')),
                'funcao' => trim((string) ($linha['des_funcao_eleitoral'] ?? '')),
                'alocacao_provisoria' => (int) ($linha['alocacao_provisoria'] ?? 0) === 1,
                'data_convocacao_elo' => $this->formatarDataElo($linha['data_convocacao_elo'] ?? null),
            ];
            $atribuicao['nomeacao_sem_local'] = (
                $atribuicao['numero_local'] === '' && $atribuicao['local_votacao'] === ''
            ) || $atribuicao['secao'] === '';
            $chaveAtribuicao = implode('|', $atribuicao);
            $grupos[$chave]['_atribuicoes'][$chaveAtribuicao] = $atribuicao;
            $grupos[$chave]['_respostas_elo'][] = [
                'resposta' => mb_strtoupper(trim((string) ($linha['resposta_elo'] ?? '')), 'UTF-8'),
                'origem' => trim((string) ($linha['origem_resposta_elo'] ?? '')),
                'data' => trim((string) ($linha['data_resposta_elo'] ?? '')),
            ];
        }

        $resultado = [];
        foreach ($grupos as $grupo) {
            $atribuicoes = array_values($grupo['_atribuicoes']);
            usort($atribuicoes, static function (array $a, array $b): int {
                return strnatcasecmp(
                    implode('|', [$a['numero_local'], $a['secao'], $a['funcao']]),
                    implode('|', [$b['numero_local'], $b['secao'], $b['funcao']]),
                );
            });

            $grupo['atribuicoes'] = $atribuicoes;
            $grupo['secoes'] = $this->valoresUnicos($atribuicoes, 'secao');
            $grupo['funcoes'] = $this->valoresUnicos($atribuicoes, 'funcao');
            $grupo['numeros_locais'] = $this->valoresUnicos($atribuicoes, 'numero_local');
            $grupo['locais_votacao'] = $this->valoresUnicos($atribuicoes, 'local_votacao');
            $grupo['numero_local'] = implode(', ', $grupo['numeros_locais']);
            $grupo['local_votacao'] = implode(', ', $grupo['locais_votacao']);
            $grupo['possui_local_votacao'] = $grupo['numero_local'] !== '' || $grupo['local_votacao'] !== '';
            $grupo['nomeacao_sem_local'] = collect($atribuicoes)->contains(
                static fn (array $item): bool => $item['nomeacao_sem_local'],
            );
            $grupo['campos_localizacao_indisponiveis'] = $this->camposLocalizacaoIndisponiveis(
                $grupo,
                $atribuicoes,
            );
            $grupo['situacao_local'] = $grupo['nomeacao_sem_local']
                ? 'Sem local ou seção informado no CONVOCA +'
                : null;
            $grupo['resumo_convocacoes'] = implode("\n", array_map(
                fn (array $item): string => $this->resumirAtribuicao($item),
                $atribuicoes,
            ));
            $this->completarConfirmacaoElo($grupo);
            $confirmadoElo = $grupo['confirmacao_elo_codigo'] === 'CONFIRMADO';
            $grupo['status_codigo_efetivo'] = $this->status->statusEfetivoEntrega(
                (string) $grupo['status_codigo'],
                $confirmadoElo,
            );
            $grupo['entrega_inferida_convoca_mais'] = $this->status->entregaInferidaConvocaMais(
                (string) $grupo['status_codigo'],
                $confirmadoElo,
            );
            $grupo['telefone_e164'] = $grupo['telefone']['e164'] ?? null;
            $grupo['telefone_nacional'] = $grupo['telefone']['nacional'] ?? null;
            $grupo['telefone_fonte'] = $grupo['telefone']['fonte'] ?? null;
            $grupo['telefone_normalizacao_codigo'] = $grupo['telefone']['normalizacao_codigo'] ?? null;
            $grupo['telefone_normalizacao'] = $grupo['telefone']['normalizacao_rotulo'] ?? null;
            $grupo['telefone_manual_ativo'] = $grupo['telefone_fonte'] === 'telefone_manual';
            $grupo['telefone_carga_nacional'] = $grupo['telefone_carga']['nacional'] ?? null;
            $grupo['telefone_diagnostico_codigo'] = $grupo['telefone'] !== null
                ? ($grupo['telefone_normalizacao_codigo'] ?? 'VALIDO_SEM_NORMALIZACAO')
                : $grupo['_telefone_diagnostico_codigo'];
            $grupo['telefone_diagnostico'] = $grupo['telefone'] !== null
                ? ($grupo['telefone_normalizacao'] ?? 'Telefone válido sem normalização')
                : $this->telefones->rotuloDoDiagnostico($grupo['_telefone_diagnostico_codigo']);
            $grupo['situacao_comunicacao'] = $this->status->situacaoComunicacao(
                (string) $grupo['status_codigo'],
                $grupo['telefone_e164'] !== null,
            );
            $grupo['selecionavel'] = $this->status->podeSelecionarParaEnvio(
                (string) $grupo['situacao_comunicacao'],
                false,
            );

            unset(
                $grupo['_telefone_ordem'],
                $grupo['_telefone_carga_ordem'],
                $grupo['_telefone_diagnostico_codigo'],
                $grupo['_telefone_diagnostico_ordem'],
                $grupo['_atribuicoes'],
                $grupo['_respostas_elo'],
                $grupo['telefone'],
                $grupo['telefone_carga'],
            );
            $resultado[] = $grupo;
        }

        return $resultado;
    }

    /** @param array<string, mixed> $atribuicao */
    private function resumirAtribuicao(array $atribuicao): string
    {
        $partes = [];
        $numeroLocal = trim((string) ($atribuicao['numero_local'] ?? ''));
        $local = trim((string) ($atribuicao['local_votacao'] ?? ''));
        if ($numeroLocal !== '' || $local !== '') {
            $partes[] = match (true) {
                $numeroLocal !== '' && $local !== '' => "Local {$numeroLocal} - {$local}",
                $numeroLocal !== '' => "Local {$numeroLocal}",
                default => "Local {$local}",
            };
        }
        $secao = trim((string) ($atribuicao['secao'] ?? ''));
        if ($secao !== '') {
            $partes[] = "Seção {$secao}";
        }
        $funcao = trim((string) ($atribuicao['funcao'] ?? ''));
        if ($funcao !== '') {
            $partes[] = $funcao;
        }
        $data = trim((string) ($atribuicao['data_convocacao_elo'] ?? ''));
        $partes[] = $data !== '' ? "Convocado em {$data}" : 'Convocação sem data informada';

        return implode(' · ', $partes);
    }

    /**
     * @param  array<string, mixed>  $grupo
     * @param  array<int, array<string, mixed>>  $atribuicoes
     * @return array<int, string>
     */
    private function camposLocalizacaoIndisponiveis(array $grupo, array $atribuicoes): array
    {
        $indisponiveis = [];
        if (trim((string) ($grupo['municipio'] ?? '')) === '') {
            $indisponiveis[] = 'MUNICIPIO';
        }
        foreach ([
            'numero_local' => 'NUMERO_LOCAL',
            'local_votacao' => 'LOCAL_VOTACAO',
            'secao' => 'SECOES',
        ] as $campo => $placeholder) {
            if (collect($atribuicoes)->contains(
                static fn (array $item): bool => trim((string) ($item[$campo] ?? '')) === '',
            )) {
                $indisponiveis[] = $placeholder;
            }
        }

        return $indisponiveis;
    }

    /** @param array<int, array<string, mixed>> $atribuicoes */
    private function valoresUnicos(array $atribuicoes, string $campo): array
    {
        $valores = array_values(array_unique(array_filter(array_map(
            static fn (array $item): string => trim((string) ($item[$campo] ?? '')),
            $atribuicoes,
        ), static fn (string $valor): bool => $valor !== '')));
        sort($valores, SORT_NATURAL | SORT_FLAG_CASE);

        return $valores;
    }

    /** @param array<string, mixed> $grupo */
    private function completarConfirmacaoElo(array &$grupo): void
    {
        $respostas = $grupo['_respostas_elo'];
        $compativeis = array_values(array_filter(
            $respostas,
            static fn (array $resposta): bool => $resposta['resposta'] === 'SIM',
        ));

        if ($compativeis !== []) {
            $codigo = 'CONFIRMADO';
            $rotulo = 'Confirmado';
            $filtro = 'CONFIRMADO';
        } else {
            $compativeis = array_values(array_filter(
                $respostas,
                static fn (array $resposta): bool => $resposta['resposta'] === 'NAO',
            ));
            $codigo = $compativeis !== [] ? 'NAO_CONFIRMOU' : 'AGUARDANDO';
            $rotulo = $compativeis !== [] ? 'Não confirmou' : 'Aguardando resposta';
            $filtro = 'NAO_CONFIRMADO';
        }

        usort(
            $compativeis,
            static fn (array $a, array $b): int => strcmp((string) $b['data'], (string) $a['data']),
        );
        $maisRecente = $compativeis[0] ?? [];
        $origem = $this->formatarOrigemElo($maisRecente['origem'] ?? null);
        $data = $this->formatarDataElo($maisRecente['data'] ?? null);
        $detalhes = array_values(array_filter([
            $rotulo,
            $origem,
            $data !== null ? 'Respondido em '.$data : null,
        ]));

        $grupo['confirmacao_elo_codigo'] = $codigo;
        $grupo['confirmacao_elo'] = $rotulo;
        $grupo['confirmacao_elo_filtro'] = $filtro;
        $grupo['origem_resposta_elo'] = $origem;
        $grupo['data_resposta_elo'] = $data;
        $grupo['confirmacao_elo_resumo'] = implode(' · ', $detalhes);
    }

    private function formatarOrigemElo(mixed $origem): ?string
    {
        $valor = trim((string) $origem);
        if ($valor === '') {
            return null;
        }

        return match (mb_strtoupper($valor, 'UTF-8')) {
            'TITULONET', 'TITULO NET', 'TÍTULO NET' => 'Título Net',
            'PRESENCIAL' => 'Presencial',
            default => $valor,
        };
    }

    private function formatarDataElo(mixed $data): ?string
    {
        $valor = trim((string) $data);
        if ($valor === '') {
            return null;
        }

        $dataElo = \DateTimeImmutable::createFromFormat('!Y-m-d H:i:s', $valor);

        return $dataElo !== false ? $dataElo->format('d/m/Y H:i') : null;
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSDESTINATARIOAGRUPADOR_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsJanelaConfiguracaoInvalidaException.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSJANELACONFIGURACAOINVALIDAEXCEPTION_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsJanelaConfiguracaoInvalidaException.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsJanelaConfiguracaoInvalidaException extends RuntimeException {}`

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

namespace App\Services\ConvocacaoSms;

use RuntimeException;

final class ConvocacaoSmsJanelaConfiguracaoInvalidaException extends RuntimeException {}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSJANELACONFIGURACAOINVALIDAEXCEPTION_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsJanelaEnvio.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSJANELAENVIO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsJanelaEnvio.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsJanelaEnvio`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function segundosAteAbertura(?CarbonInterface $instante = null): int
private function minutos(string $chave): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use Carbon\CarbonImmutable;
use Carbon\CarbonInterface;
use DateTimeZone;
use Throwable;

final class ConvocacaoSmsJanelaEnvio
{
    public const RETENTATIVA_CONFIGURACAO_INVALIDA_SEGUNDOS = 300;

    public function segundosAteAbertura(?CarbonInterface $instante = null): int
    {
        try {
            $timezone = new DateTimeZone(trim((string) config('app.timezone')));
            $agora = $instante === null
                ? CarbonImmutable::now($timezone)
                : CarbonImmutable::instance($instante)->setTimezone($timezone);
            $inicioMinutos = $this->minutos('planeleito.convocacao_sms.sending_start');
            $fimMinutos = $this->minutos('planeleito.convocacao_sms.sending_end');
        } catch (ConvocacaoSmsJanelaConfiguracaoInvalidaException $exception) {
            throw $exception;
        } catch (Throwable $exception) {
            throw new ConvocacaoSmsJanelaConfiguracaoInvalidaException(
                'O fuso da janela de envio SMS é inválido.',
                previous: $exception,
            );
        }

        if ($inicioMinutos >= $fimMinutos) {
            throw new ConvocacaoSmsJanelaConfiguracaoInvalidaException(
                'O início da janela de envio SMS deve ser anterior ao fim.',
            );
        }

        $inicioHoje = $agora->startOfDay()->addMinutes($inicioMinutos);
        $fimHoje = $agora->startOfDay()->addMinutes($fimMinutos);
        if ($agora->gte($inicioHoje) && $agora->lt($fimHoje)) {
            return 0;
        }

        $proximaAbertura = $agora->lt($inicioHoje) ? $inicioHoje : $inicioHoje->addDay();

        return max(1, $proximaAbertura->getTimestamp() - $agora->getTimestamp());
    }

    private function minutos(string $chave): int
    {
        $horario = trim((string) config($chave));
        if (preg_match('/\A([01]\d|2[0-3]):([0-5]\d)\z/', $horario, $partes) !== 1) {
            throw new ConvocacaoSmsJanelaConfiguracaoInvalidaException(
                'A janela de envio SMS deve usar o formato HH:MM.',
            );
        }

        return ((int) $partes[1] * 60) + (int) $partes[2];
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSJANELAENVIO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsLoteDuplicadoException.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSLOTEDUPLICADOEXCEPTION_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsLoteDuplicadoException.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsLoteDuplicadoException extends RuntimeException {}`

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

namespace App\Services\ConvocacaoSms;

use RuntimeException;

final class ConvocacaoSmsLoteDuplicadoException extends RuntimeException {}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSLOTEDUPLICADOEXCEPTION_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsLoteService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSLOTESERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsLoteService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsLoteService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function criar(array $dados, ConvocacaoSmsContexto $contexto): array
private function validarEntrada(string $uuid, int $modeloId, string $zona, array $inscricoes, ConvocacaoSmsContexto $contexto): void
private function origemTecnicaTextBee(): string
private function prepararSnapshot(array $destinatario, ConvocacaoSmsContexto $contexto): array
private function json(array $dados): string
private function resultadoExistente(array $lote): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use DomainException;
use Illuminate\Support\Str;

final readonly class ConvocacaoSmsLoteService
{
    /** @var array<int, string> */
    private const CAMPOS_INCOMPATIVEIS_SEM_LOCAL = [
        'MUNICIPIO',
        'NUMERO_LOCAL',
        'LOCAL_VOTACAO',
        'SECOES',
    ];

    public function __construct(
        private ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
        private ConvocacaoSmsModeloRepositoryInterface $modelos,
        private ConvocacaoSmsEnvioRepositoryInterface $envios,
        private ConvocacaoSmsMensagem $mensagem,
        private ConvocacaoSmsTransacao $transacao,
        private ConvocacaoSmsStatusService $status,
        private ?SmsDisponibilidade $disponibilidade = null,
    ) {}

    /**
     * @param  array<string, mixed>  $dados
     * @return array{lote_id:int,selecionados:int,enfileirados:int,ignorados:int,duplicado:bool}
     */
    public function criar(array $dados, ConvocacaoSmsContexto $contexto): array
    {
        $uuid = mb_strtolower(trim((string) ($dados['request_uuid'] ?? '')), 'UTF-8');
        $modeloId = (int) ($dados['modelo_id'] ?? 0);
        $zona = trim((string) ($dados['zona'] ?? ''));
        $inscricoes = array_values(array_unique(array_filter(array_map(
            static fn (mixed $valor): string => trim((string) $valor),
            is_array($dados['num_inscricoes'] ?? null) ? $dados['num_inscricoes'] : [],
        ), static fn (string $valor): bool => $valor !== '')));

        $this->validarEntrada($uuid, $modeloId, $zona, $inscricoes, $contexto);
        $this->disponibilidade?->exigir();

        $existente = $this->envios->buscarLotePorUuid($uuid, $contexto->macroprojetoTurnoId);
        if ($existente !== null) {
            return $this->resultadoExistente($existente);
        }

        $modelo = $this->modelos->buscarConfiguracaoAtiva($modeloId, $zona, $contexto);
        if ($modelo === null) {
            throw new DomainException('O modelo não está ativo para a zona e o turno selecionados.');
        }

        $encontrados = $this->destinatarios->buscarPorInscricoes($inscricoes, $zona, $contexto);
        $executar = function () use ($uuid, $modeloId, $zona, $inscricoes, $modelo, $encontrados, $contexto): array {
            $loteId = $this->envios->criarLote([
                'request_uuid' => $uuid,
                'macroprojeto_turno_id' => $contexto->macroprojetoTurnoId,
                'modelo_id' => $modeloId,
                'num_zona' => $zona,
                'usuario_login' => $contexto->usuarioLogin,
                'usuario_nome' => $contexto->usuarioNome,
            ]);
            $enviosIds = [];
            $ignorados = 0;

            foreach ($inscricoes as $inscricao) {
                $destinatario = $encontrados[$inscricao] ?? null;
                $modelosJaUtilizados = array_values(array_filter(array_map(
                    static fn (mixed $id): int => (int) $id,
                    (array) ($destinatario['modelos_ja_utilizados'] ?? []),
                ), static fn (int $id): bool => $id > 0));
                $modeloJaUtilizado = in_array($modeloId, $modelosJaUtilizados, true);
                if ($destinatario === null || ($destinatario['selecionavel'] ?? false) !== true
                    || trim((string) ($destinatario['telefone_e164'] ?? '')) === ''
                    || ! $this->status->podeSelecionarParaEnvio(
                        (string) ($destinatario['situacao_comunicacao'] ?? ''),
                        $modeloJaUtilizado,
                    )) {
                    $this->envios->registrarItemLote([
                        'lote_id' => $loteId,
                        'envio_id' => null,
                        'num_inscricao' => $inscricao,
                        'enfileirado' => 0,
                        'motivo_codigo' => match (true) {
                            $modeloJaUtilizado => 'MODELO_JA_UTILIZADO',
                            default => 'DESTINATARIO_NAO_ELEGIVEL',
                        },
                        'motivo_detalhe' => match (true) {
                            $modeloJaUtilizado => 'O modelo selecionado já foi utilizado para esta inscrição e turno.',
                            default => 'A inscrição não está elegível no contexto efetivo no momento da reserva.',
                        },
                    ]);
                    $ignorados++;

                    continue;
                }

                $snapshot = $this->prepararSnapshot($destinatario, $contexto);
                $textoModelo = (string) ($modelo['texto_modelo'] ?? '');
                $camposIncompativeis = array_values(array_intersect(
                    self::CAMPOS_INCOMPATIVEIS_SEM_LOCAL,
                    $this->mensagem->camposUtilizados($textoModelo),
                    (array) ($destinatario['campos_localizacao_indisponiveis'] ?? self::CAMPOS_INCOMPATIVEIS_SEM_LOCAL),
                ));
                if (($destinatario['nomeacao_sem_local'] ?? false) === true && $camposIncompativeis !== []) {
                    $this->envios->registrarItemLote([
                        'lote_id' => $loteId,
                        'envio_id' => null,
                        'num_inscricao' => $inscricao,
                        'enfileirado' => 0,
                        'motivo_codigo' => 'MODELO_INCOMPATIVEL_SEM_LOCAL',
                        'motivo_detalhe' => 'O modelo exige campo(s) indisponível(is) para a nomeação sem local: '
                            .implode(', ', $camposIncompativeis).'.',
                    ]);
                    $ignorados++;

                    continue;
                }

                try {
                    $mensagem = $this->mensagem->renderizar($textoModelo, $snapshot);
                } catch (DomainException $exception) {
                    $this->envios->registrarItemLote([
                        'lote_id' => $loteId,
                        'envio_id' => null,
                        'num_inscricao' => $inscricao,
                        'enfileirado' => 0,
                        'motivo_codigo' => 'MENSAGEM_INVALIDA',
                        'motivo_detalhe' => $exception->getMessage(),
                    ]);
                    $ignorados++;

                    continue;
                }
                $atribuicoesJson = $this->json($destinatario['atribuicoes'] ?? []);
                $externalId = Str::uuid()->toString();
                $payloadHash = hash('sha256', $this->json([
                    'destino' => $destinatario['telefone_e164'] ?? '',
                    'external_id' => $externalId,
                    'texto' => $mensagem->texto,
                    'encoding' => $mensagem->encoding,
                ]));

                $envioId = $this->envios->reservarEnvio([
                    'lote_id' => $loteId,
                    'modelo_id' => $modeloId,
                    'macroprojeto_turno_id' => $contexto->macroprojetoTurnoId,
                    'num_inscricao' => $inscricao,
                    'cod_pleito' => $contexto->codPleito,
                    'dt_eleicao' => $contexto->dataEleicao,
                    'num_zona' => $zona,
                    'municipio' => (string) ($destinatario['municipio'] ?? ''),
                    'nome' => (string) ($destinatario['nome'] ?? ''),
                    'telefone_e164' => (string) ($destinatario['telefone_e164'] ?? ''),
                    'telefone_fonte' => (string) ($destinatario['telefone_fonte'] ?? ''),
                    'sender' => $this->origemTecnicaTextBee(),
                    'provider_codigo' => 'TEXTBEE',
                    'provider_device_id' => trim((string) config('planeleito.sms_textbee.device_id', '')),
                    'provider_sim_subscription_id' => (($sim = config('planeleito.sms_textbee.sim_subscription_id')) !== null && trim((string) $sim) !== '') ? (int) $sim : null,
                    'atribuicoes_json' => $atribuicoesJson,
                    'mensagem_texto' => $mensagem->texto,
                    'encoding' => $mensagem->encoding,
                    'segmentos' => $mensagem->segmentos,
                    'external_id' => $externalId,
                    'payload_hash' => $payloadHash,
                    'status_codigo' => 'PENDENTE',
                ]);

                if ($envioId === null) {
                    $this->envios->registrarItemLote([
                        'lote_id' => $loteId,
                        'envio_id' => null,
                        'num_inscricao' => $inscricao,
                        'enfileirado' => 0,
                        'motivo_codigo' => 'JA_RESERVADO',
                        'motivo_detalhe' => 'Já existe convocação que mantém a trava para esta inscrição e turno.',
                    ]);
                    $ignorados++;

                    continue;
                }

                $this->envios->registrarItemLote([
                    'lote_id' => $loteId,
                    'envio_id' => $envioId,
                    'num_inscricao' => $inscricao,
                    'enfileirado' => 1,
                    'motivo_codigo' => null,
                    'motivo_detalhe' => null,
                ]);
                $enviosIds[] = $envioId;
            }

            $enfileirados = count($enviosIds);
            $this->envios->atualizarTotaisLote($loteId, count($inscricoes), $enfileirados, $ignorados);

            foreach ($enviosIds as $envioId) {
                EnviarConvocacaoSmsJob::dispatch($envioId)->afterCommit();
            }

            return [
                'lote_id' => $loteId,
                'selecionados' => count($inscricoes),
                'enfileirados' => $enfileirados,
                'ignorados' => $ignorados,
                'duplicado' => false,
            ];
        };

        try {
            return $this->transacao->executar($executar);
        } catch (ConvocacaoSmsLoteDuplicadoException $exception) {
            $vencedor = $this->envios->buscarLotePorUuid($uuid, $contexto->macroprojetoTurnoId);
            if ($vencedor === null) {
                throw $exception;
            }

            return $this->resultadoExistente($vencedor);
        }
    }

    /** @param array<int, string> $inscricoes */
    private function validarEntrada(string $uuid, int $modeloId, string $zona, array $inscricoes, ConvocacaoSmsContexto $contexto): void
    {
        if (! Str::isUuid($uuid)) {
            throw new DomainException('Identificador idempotente inválido.');
        }
        if ($modeloId <= 0 || $zona === '') {
            throw new DomainException('Modelo e zona são obrigatórios.');
        }
        if ($inscricoes === [] || count($inscricoes) > 50) {
            throw new DomainException('Selecione entre 1 e 50 inscrições da página atual.');
        }
        if (! $contexto->acessoTodasZonas && ! in_array($zona, $contexto->zonasPermitidas, true)) {
            throw new DomainException('Zona fora do escopo permitido.');
        }
    }

    private function origemTecnicaTextBee(): string
    {
        $deviceId = trim((string) config('planeleito.sms_textbee.device_id', ''));
        $sim = config('planeleito.sms_textbee.sim_subscription_id');

        return mb_substr('TEXTBEE:'.$deviceId.':'.($sim !== null && trim((string) $sim) !== '' ? (string) (int) $sim : 'DEFAULT'), 0, 100);
    }

    /** @param array<string, mixed> $destinatario @return array<string, mixed> */
    private function prepararSnapshot(array $destinatario, ConvocacaoSmsContexto $contexto): array
    {
        $atribuicoes = (array) ($destinatario['atribuicoes'] ?? []);
        $secoes = (array) ($destinatario['secoes'] ?? array_column($atribuicoes, 'secao'));
        $funcoes = (array) ($destinatario['funcoes'] ?? array_column($atribuicoes, 'funcao'));

        return array_merge($destinatario, [
            'data_eleicao' => $contexto->dataEleicao,
            'turno' => $contexto->turno,
            'secoes' => implode(', ', array_values(array_unique(array_filter($secoes)))),
            'funcoes' => implode(', ', array_values(array_unique(array_filter($funcoes)))),
        ]);
    }

    /** @param array<mixed> $dados */
    private function json(array $dados): string
    {
        return json_encode($dados, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR);
    }

    /** @param array<string, mixed> $lote @return array{lote_id:int,selecionados:int,enfileirados:int,ignorados:int,duplicado:bool} */
    private function resultadoExistente(array $lote): array
    {
        return [
            'lote_id' => (int) ($lote['id'] ?? 0),
            'selecionados' => (int) ($lote['total_selecionados'] ?? 0),
            'enfileirados' => (int) ($lote['total_enfileirados'] ?? 0),
            'ignorados' => (int) ($lote['total_ignorados'] ?? 0),
            'duplicado' => true,
        ];
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSLOTESERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsMensagem.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSMENSAGEM_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsMensagem.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsMensagem`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function camposPermitidos(): array
public static function normalizarTexto(string $texto): string
public function camposUtilizados(string $modelo): array
public function renderizar(string $modelo, array $destinatario): ConvocacaoSmsMensagemResultado
public function validarModelo(string $modelo): string
public function analisar(string $texto): ConvocacaoSmsMensagemResultado
private function encodingEUnidades(string $texto): array
private function segmentos(string $encoding, int $unidades): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use DomainException;

final class ConvocacaoSmsMensagem
{
    public const LIMITE_CARACTERES = 500;

    /** @var array<string, string> */
    private const CAMPOS = [
        'NOME' => 'nome',
        'ZONA' => 'zona',
        'MUNICIPIO' => 'municipio',
        'NUMERO_LOCAL' => 'numero_local',
        'LOCAL_VOTACAO' => 'local_votacao',
        'SECOES' => 'secoes',
        'FUNCOES' => 'funcoes',
        'DATA_ELEICAO' => 'data_eleicao',
        'TURNO' => 'turno',
        'RESUMO_CONVOCACOES' => 'resumo_convocacoes',
    ];

    private const GSM_7_BASICO = '@£$¥èéùìòÇØøÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !"#¤%&\'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà';

    private const GSM_7_ESTENDIDO = '^{}\\[~]|€';

    /** @return array<string, string> */
    public static function camposPermitidos(): array
    {
        return self::CAMPOS;
    }

    public static function normalizarTexto(string $texto): string
    {
        return trim((string) preg_replace('/\s+/u', ' ', $texto));
    }

    /** @return array<int, string> */
    public function camposUtilizados(string $modelo): array
    {
        preg_match_all('/\{\{\s*([A-Z_]+)\s*\}\}/u', $modelo, $correspondencias);

        return array_values(array_unique(array_map(
            static fn (string $campo): string => mb_strtoupper($campo, 'UTF-8'),
            $correspondencias[1],
        )));
    }

    /** @param array<string, mixed> $destinatario */
    public function renderizar(string $modelo, array $destinatario): ConvocacaoSmsMensagemResultado
    {
        $texto = preg_replace_callback('/\{\{\s*([A-Z_]+)\s*\}\}/u', function (array $match) use ($destinatario): string {
            $codigo = mb_strtoupper((string) $match[1], 'UTF-8');
            if (! isset(self::CAMPOS[$codigo])) {
                throw new DomainException('Campo de modelo não permitido: '.$codigo.'.');
            }

            $valor = trim((string) ($destinatario[self::CAMPOS[$codigo]] ?? ''));
            if ($valor === '') {
                throw new DomainException('O campo '.$codigo.' não possui valor para o destinatário.');
            }

            return $valor;
        }, $modelo);

        if (! is_string($texto)) {
            throw new DomainException('Não foi possível renderizar o modelo de SMS.');
        }
        if (preg_match('/\{\{.*?\}\}/u', $texto) === 1) {
            throw new DomainException('Campo de modelo não permitido.');
        }

        return $this->analisar($texto);
    }

    public function validarModelo(string $modelo): string
    {
        $normalizado = self::normalizarTexto($modelo);
        $valores = array_fill_keys(array_values(self::CAMPOS), 'X');
        $this->renderizar($normalizado, $valores);

        return $normalizado;
    }

    public function analisar(string $texto): ConvocacaoSmsMensagemResultado
    {
        $normalizado = self::normalizarTexto($texto);
        if (! str_starts_with($normalizado, 'TRE-AC:')) {
            throw new DomainException('A mensagem deve iniciar com TRE-AC:.');
        }
        if (mb_strlen($normalizado, 'UTF-8') > self::LIMITE_CARACTERES) {
            throw new DomainException('A mensagem não pode ultrapassar '.self::LIMITE_CARACTERES.' caracteres.');
        }

        [$encoding, $unidades] = $this->encodingEUnidades($normalizado);
        $segmentos = $this->segmentos($encoding, $unidades);

        return new ConvocacaoSmsMensagemResultado($normalizado, $encoding, $unidades, $segmentos);
    }

    /** @return array{string, int} */
    private function encodingEUnidades(string $texto): array
    {
        $unidades = 0;
        foreach (mb_str_split($texto) as $caractere) {
            if ($caractere === "\n" || $caractere === "\r" || mb_strpos(self::GSM_7_BASICO, $caractere, 0, 'UTF-8') !== false) {
                $unidades++;

                continue;
            }
            if (mb_strpos(self::GSM_7_ESTENDIDO, $caractere, 0, 'UTF-8') !== false) {
                $unidades += 2;

                continue;
            }

            $ucs2 = mb_convert_encoding($texto, 'UTF-16BE', 'UTF-8');

            return ['UCS-2', intdiv(strlen($ucs2), 2)];
        }

        return ['GSM-7', $unidades];
    }

    private function segmentos(string $encoding, int $unidades): int
    {
        if ($unidades === 0) {
            return 1;
        }
        $limiteUnico = $encoding === 'GSM-7' ? 160 : 70;
        $limiteMultiplo = $encoding === 'GSM-7' ? 152 : 66;

        return $unidades <= $limiteUnico ? 1 : (int) ceil($unidades / $limiteMultiplo);
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSMENSAGEM_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsMensagemResultado.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSMENSAGEMRESULTADO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsMensagemResultado.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsMensagemResultado`

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

namespace App\Services\ConvocacaoSms;

final readonly class ConvocacaoSmsMensagemResultado
{
    public function __construct(
        public string $texto,
        public string $encoding,
        public int $unidades,
        public int $segmentos,
    ) {}
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSMENSAGEMRESULTADO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsProcessamentoService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSPROCESSAMENTOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsProcessamentoService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsProcessamentoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function processar(int $envioId): int
private function processarNaJanela(int $envioId, array $envio, int &$adiarSegundos): bool
private function sanitizar(?string $valor, int $limite): ?string
private function adiamentoDaJanela(): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsProcessamentoRepositoryInterface;
use App\Services\ConvocacaoSms\Contracts\SmsGatewayInterface;
use RuntimeException;
use Throwable;

final readonly class ConvocacaoSmsProcessamentoService
{
    public function __construct(
        private ConvocacaoSmsProcessamentoRepositoryInterface $envios,
        private ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
        private ConvocacaoSmsModeloRepositoryInterface $modelos,
        private SmsGatewayInterface $gateway,
        private SmsDisponibilidade $disponibilidade,
        private TextBeeSmsCadencia $cadencia,
        private ConvocacaoSmsContextoDoEnvio $contextoDoEnvio,
        private ConvocacaoSmsJanelaEnvio $janelaEnvio,
    ) {}

    public function processar(int $envioId): int
    {
        $envio = $this->envios->buscarEnvio($envioId);
        if ($envio === null) {
            return 0;
        }

        $adiarSegundos = $this->adiamentoDaJanela();
        if ($adiarSegundos > 0) {
            return $adiarSegundos;
        }

        $deviceId = trim((string) ($envio['provider_device_id'] ?? config('planeleito.sms_textbee.device_id', '')));
        $simSubscriptionId = isset($envio['provider_sim_subscription_id'])
            ? (int) $envio['provider_sim_subscription_id']
            : null;
        $pausa = $this->cadencia->segundosDePausa($deviceId, $simSubscriptionId);
        if ($pausa > 0) {
            return $pausa;
        }

        $this->cadencia->executar(
            $deviceId,
            $simSubscriptionId,
            (int) ($envio['segmentos'] ?? 1),
            function () use ($envioId, $envio, &$adiarSegundos): bool {
                $adiarSegundos = $this->adiamentoDaJanela();
                if ($adiarSegundos > 0) {
                    return false;
                }

                return $this->processarNaJanela($envioId, $envio, $adiarSegundos);
            },
        );

        return $adiarSegundos;
    }

    /** @param array<string, mixed> $envio */
    private function processarNaJanela(int $envioId, array $envio, int &$adiarSegundos): bool
    {
        if (! $this->envios->reivindicarProcessamento($envioId)) {
            return false;
        }

        if (! $this->disponibilidade->diagnostico()['disponivel']) {
            $this->envios->cancelarAntesEnvio(
                $envioId,
                'INTEGRACAO_INDISPONIVEL',
                'A integração SMS estava desabilitada ou incompleta antes da chamada externa.',
            );

            return false;
        }

        $contexto = $this->contextoDoEnvio->criar($envio);
        $inscricao = trim((string) ($envio['num_inscricao'] ?? ''));
        $zona = trim((string) ($envio['num_zona'] ?? ''));
        $atuais = $this->destinatarios->buscarPorInscricoes([$inscricao], $zona, $contexto);
        $destinatario = $atuais[$inscricao] ?? null;
        if ($destinatario === null) {
            $this->envios->cancelarAntesEnvio(
                $envioId,
                'DESTINATARIO_NAO_NOMEADO',
                'A inscrição deixou de possuir nomeação efetiva para o pleito, a data e o turno associados.',
            );

            return false;
        }

        $telefoneAtual = trim((string) ($destinatario['telefone_e164'] ?? ''));
        if ($telefoneAtual === '' || $telefoneAtual !== trim((string) ($envio['telefone_e164'] ?? ''))) {
            $this->envios->cancelarAntesEnvio(
                $envioId,
                'TELEFONE_ALTERADO_OU_INVALIDO',
                'O celular efetivo deixou de ser válido ou foi alterado após a reserva.',
            );

            return false;
        }

        $modelo = $this->modelos->buscarConfiguracaoAtiva((int) ($envio['modelo_id'] ?? 0), $zona, $contexto);
        if ($modelo === null) {
            $this->envios->cancelarAntesEnvio(
                $envioId,
                'MODELO_INDISPONIVEL',
                'O modelo deixou de estar aprovado e ativo para a zona e o turno antes da chamada.',
            );

            return false;
        }

        $texto = trim((string) ($envio['mensagem_texto'] ?? ''));
        $externalId = trim((string) ($envio['external_id'] ?? ''));
        if ($texto === '' || $externalId === '') {
            $this->envios->cancelarAntesEnvio(
                $envioId,
                'SNAPSHOT_INVALIDO',
                'O snapshot da mensagem não pôde ser reconstruído antes da chamada.',
            );

            return false;
        }

        $adiarSegundos = $this->adiamentoDaJanela();
        if ($adiarSegundos > 0) {
            if (! $this->envios->restaurarPendenteForaJanela($envioId)) {
                throw new RuntimeException('Não foi possível restaurar o SMS adiado pela janela operacional.');
            }

            return false;
        }

        try {
            $resultado = $this->gateway->enviar($telefoneAtual, $texto, $externalId);

            if ($resultado->aceito && trim((string) $resultado->idLote) !== '') {
                $sim = config('planeleito.sms_textbee.sim_subscription_id');
                $this->envios->registrarAceite(
                    $envioId,
                    'TEXTBEE',
                    trim((string) $resultado->idLote),
                    trim((string) config('planeleito.sms_textbee.device_id', '')),
                    $sim !== null && trim((string) $sim) !== '' ? (int) $sim : null,
                );

                return true;
            }

            if ($resultado->rejeicaoExplicita) {
                $this->envios->registrarRejeicao(
                    $envioId,
                    $this->sanitizar($resultado->codigoErro, 80),
                    $this->sanitizar($resultado->mensagemErro, 1000),
                );

                return true;
            }

            $this->envios->registrarIndeterminado(
                $envioId,
                'RESPOSTA_ILEGIVEL',
                'O provedor SMS não devolveu um aceite com identificador nem uma rejeição estruturada.',
            );

            return true;
        } catch (Throwable) {
            $this->envios->registrarIndeterminado(
                $envioId,
                'RESULTADO_AMBIGUO',
                'A chamada ao provedor SMS foi iniciada, mas não houve confirmação legível do resultado.',
            );

            return true;
        }
    }

    private function sanitizar(?string $valor, int $limite): ?string
    {
        $limpo = trim((string) $valor);
        if ($limpo === '') {
            return null;
        }
        $limpo = preg_replace('/(access[_ -]?token|token|secret|authorization)\s*[:=]\s*[^\s,;]+/iu', '$1=[redigido]', $limpo) ?? '';

        return mb_substr($limpo, 0, $limite);
    }

    private function adiamentoDaJanela(): int
    {
        try {
            return $this->janelaEnvio->segundosAteAbertura();
        } catch (ConvocacaoSmsJanelaConfiguracaoInvalidaException $exception) {
            report($exception);

            return ConvocacaoSmsJanelaEnvio::RETENTATIVA_CONFIGURACAO_INVALIDA_SEGUNDOS;
        }
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSPROCESSAMENTOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsRecuperacaoLimiteService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSRECUPERACAOLIMITESERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsRecuperacaoLimiteService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsRecuperacaoLimiteService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function recuperar(bool $executar): array
private function confirmado(array $destinatario): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRecuperacaoRepositoryInterface;

final readonly class ConvocacaoSmsRecuperacaoLimiteService
{
    public function __construct(
        private ConvocacaoSmsRecuperacaoRepositoryInterface $recuperacao,
        private ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
        private ConvocacaoSmsModeloRepositoryInterface $modelos,
        private ConvocacaoSmsStatusService $status,
        private SmsDisponibilidade $disponibilidade,
        private ConvocacaoSmsContextoDoEnvio $contextoDoEnvio,
    ) {}

    /** @return array{encontrados:int,elegiveis:int,reenfileirados:int,ignorados:int} */
    public function recuperar(bool $executar): array
    {
        $maxTentativas = max(2, (int) config('planeleito.sms_textbee.limit_max_attempts', 2));
        $envios = $this->recuperacao->listarFalhasLimiteTextBee($maxTentativas);
        $resultado = [
            'encontrados' => count($envios),
            'elegiveis' => 0,
            'reenfileirados' => 0,
            'ignorados' => 0,
        ];
        if ($executar && $envios !== []) {
            $this->disponibilidade->exigir();
        }

        foreach ($envios as $envio) {
            $contexto = $this->contextoDoEnvio->criar($envio);
            $inscricao = trim((string) ($envio['num_inscricao'] ?? ''));
            $zona = trim((string) ($envio['num_zona'] ?? ''));
            $atuais = $this->destinatarios->buscarPorInscricoes([$inscricao], $zona, $contexto);
            $destinatario = $atuais[$inscricao] ?? null;
            if ($destinatario === null
                || $this->confirmado($destinatario)
                || trim((string) ($destinatario['telefone_e164'] ?? '')) !== trim((string) ($envio['telefone_e164'] ?? ''))
                || $this->modelos->buscarConfiguracaoAtiva((int) ($envio['modelo_id'] ?? 0), $zona, $contexto) === null) {
                $resultado['ignorados']++;

                continue;
            }

            $resultado['elegiveis']++;
            if (! $executar) {
                continue;
            }
            $envioId = (int) ($envio['id'] ?? 0);
            if (! $this->recuperacao->prepararReenvioFalhaLimiteTextBee($envioId, $maxTentativas)) {
                $resultado['ignorados']++;

                continue;
            }

            EnviarConvocacaoSmsJob::dispatch($envioId)->afterCommit();
            $resultado['reenfileirados']++;
        }

        return $resultado;
    }

    /** @param array<string, mixed> $destinatario */
    private function confirmado(array $destinatario): bool
    {
        return (bool) ($destinatario['confirmacao_elo_bloqueia_envio'] ?? false)
            || $this->status->confirmacaoEloBloqueiaEnvio(
                (string) ($destinatario['confirmacao_elo_codigo'] ?? ''),
            );
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSRECUPERACAOLIMITESERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsReenvioService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSREENVIOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsReenvioService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsReenvioService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function reenviar(int $envioId, ConvocacaoSmsContexto $contexto): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use DomainException;
use Illuminate\Auth\Access\AuthorizationException;

final readonly class ConvocacaoSmsReenvioService
{
    public function __construct(
        private ConvocacaoSmsEnvioRepositoryInterface $envios,
        private ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
        private ConvocacaoSmsStatusService $status,
        private SmsDisponibilidade $disponibilidade,
    ) {}

    /**
     * @throws AuthorizationException
     * @throws DomainException
     */
    public function reenviar(int $envioId, ConvocacaoSmsContexto $contexto): void
    {
        if (! $contexto->administrador) {
            throw new AuthorizationException('Somente administradores podem reenviar uma rejeição explícita.');
        }

        $envio = $this->envios->buscarDetalhe($envioId, $contexto);
        if ($envio === null || trim((string) ($envio['status_codigo'] ?? '')) !== 'REJEITADO') {
            throw new AuthorizationException('O envio rejeitado não está disponível no escopo atual.');
        }

        $inscricao = trim((string) ($envio['num_inscricao'] ?? ''));
        $zona = trim((string) ($envio['num_zona'] ?? ''));
        $atuais = $this->destinatarios->buscarPorInscricoes([$inscricao], $zona, $contexto);
        $destinatario = $atuais[$inscricao] ?? null;
        if ($destinatario === null) {
            throw new DomainException('A inscrição deixou de possuir nomeação efetiva no contexto atual.');
        }
        if ((bool) ($destinatario['confirmacao_elo_bloqueia_envio'] ?? false)
            || $this->status->confirmacaoEloBloqueiaEnvio(
                (string) ($destinatario['confirmacao_elo_codigo'] ?? ''),
            )) {
            throw new DomainException('A presença já está confirmada no ELO; o reenvio foi bloqueado.');
        }

        $this->disponibilidade->exigir();
        if (! $this->envios->prepararReenvio($envioId, $contexto)) {
            throw new AuthorizationException('O envio rejeitado não está mais disponível para reenvio.');
        }

        EnviarConvocacaoSmsJob::dispatch($envioId)->afterCommit();
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSREENVIOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsStatusService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSSTATUSSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsStatusService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsStatusService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aplicarEventoZenvia(string $atual, string $statusZenvia): ?string
public function aplicarEventoProvedor(string $atual, string $provedor, string $statusProvedor): ?string
public function ehJaComunicado(string $status): bool
public function statusJaComunicados(): array
public function statusDestinatarioFiltraveisExatos(): array
public function correspondeFiltroDestinatario(
public function statusEfetivoEntrega(string $statusPersistido, bool $confirmadoElo): string
public function entregaInferidaConvocaMais(string $statusPersistido, bool $confirmadoElo): bool
public function filtroDestinatarioDependeConfirmacaoElo(string $filtro): bool
public function situacaoComunicacao(string $status, bool $possuiCelular): string
public function podeSelecionarParaEnvio(
public function confirmacaoEloBloqueiaEnvio(string $codigo): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Support\ConvocacaoSms\ConvocacaoSmsStatus;

final class ConvocacaoSmsStatusService
{
    /** @var array<int, string> */
    private const SITUACOES_SELECIONAVEIS = [
        'A_COMUNICAR',
        'JA_COMUNICADO',
        'PENDENTE',
        'PROCESSANDO',
        'REJEITADO',
        'INDETERMINADO',
    ];

    /** @var array<string, int> */
    private const PROGRESSAO = [
        'ACEITO' => 10,
        'ENVIADO' => 20,
        'ENTREGUE' => 30,
    ];

    public function aplicarEventoZenvia(string $atual, string $statusZenvia): ?string
    {
        return $this->aplicarEventoProvedor($atual, 'ZENVIA', $statusZenvia);
    }

    public function aplicarEventoProvedor(string $atual, string $provedor, string $statusProvedor): ?string
    {
        $atual = mb_strtoupper(trim($atual), 'UTF-8');
        $provedor = mb_strtoupper(trim($provedor), 'UTF-8');
        $statusProvedor = mb_strtoupper(trim($statusProvedor), 'UTF-8');
        $novo = match ($provedor.'|'.$statusProvedor) {
            'ZENVIA|SENT', 'TEXTBEE|MESSAGE_SENT' => 'ENVIADO',
            'ZENVIA|DELIVERED', 'TEXTBEE|MESSAGE_DELIVERED' => 'ENTREGUE',
            'ZENVIA|REJECTED', 'ZENVIA|NOT_DELIVERED', 'TEXTBEE|MESSAGE_FAILED' => 'NAO_ENTREGUE',
            default => null,
        };
        if ($novo === null) {
            return null;
        }
        if ($atual === 'ENTREGUE') {
            return 'ENTREGUE';
        }
        if ($atual === 'NAO_ENTREGUE') {
            return 'NAO_ENTREGUE';
        }
        if ($novo === 'NAO_ENTREGUE') {
            return $novo;
        }
        if (self::PROGRESSAO[$novo] < (self::PROGRESSAO[$atual] ?? 0)) {
            return $atual;
        }

        return $novo;
    }

    public function ehJaComunicado(string $status): bool
    {
        return in_array($status, ConvocacaoSmsStatus::JA_COMUNICADOS, true);
    }

    /** @return array<int, string> */
    public function statusJaComunicados(): array
    {
        return ConvocacaoSmsStatus::JA_COMUNICADOS;
    }

    /** @return array<int, string> */
    public function statusDestinatarioFiltraveisExatos(): array
    {
        return ConvocacaoSmsStatus::DESTINATARIO_FILTRAVEIS_EXATOS;
    }

    public function correspondeFiltroDestinatario(
        string $filtro,
        string $statusPersistido,
        string $situacaoComunicacao,
        bool $confirmadoElo = false,
    ): bool {
        $normalizado = $this->normalizar($filtro);
        if ($normalizado === '') {
            return true;
        }
        if (in_array($normalizado, $this->statusDestinatarioFiltraveisExatos(), true)) {
            return $this->statusEfetivoEntrega($statusPersistido, $confirmadoElo) === $normalizado;
        }

        return $this->normalizar($situacaoComunicacao) === $normalizado;
    }

    public function statusEfetivoEntrega(string $statusPersistido, bool $confirmadoElo): string
    {
        $normalizado = $this->normalizar($statusPersistido);

        return $this->entregaInferidaConvocaMais($normalizado, $confirmadoElo)
            ? 'ENTREGUE'
            : $normalizado;
    }

    public function entregaInferidaConvocaMais(string $statusPersistido, bool $confirmadoElo): bool
    {
        return $confirmadoElo && in_array(
            $this->normalizar($statusPersistido),
            ['ENVIADO', 'NAO_ENTREGUE'],
            true,
        );
    }

    public function filtroDestinatarioDependeConfirmacaoElo(string $filtro): bool
    {
        return in_array($this->normalizar($filtro), ['ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'], true);
    }

    public function situacaoComunicacao(string $status, bool $possuiCelular): string
    {
        $normalizado = mb_strtoupper(trim($status), 'UTF-8');
        if ($normalizado !== '') {
            return $this->ehJaComunicado($normalizado) ? 'JA_COMUNICADO' : $normalizado;
        }

        return $possuiCelular ? 'A_COMUNICAR' : 'SEM_CELULAR_VALIDO';
    }

    public function podeSelecionarParaEnvio(
        string $situacao,
        bool $modeloJaUtilizado,
    ): bool {
        $normalizada = $this->normalizar($situacao);

        return ! $modeloJaUtilizado
            && in_array($normalizada, self::SITUACOES_SELECIONAVEIS, true);
    }

    public function confirmacaoEloBloqueiaEnvio(string $codigo): bool
    {
        return $this->normalizar($codigo) === 'CONFIRMADO';
    }

    public function podeAlterarTelefoneAntesEnvio(string $situacao, bool $gestor): bool
    {
        $normalizada = $this->normalizar($situacao);

        return in_array($normalizada, ['A_COMUNICAR', 'SEM_CELULAR_VALIDO'], true)
            || ($gestor && $normalizada === 'JA_COMUNICADO');
    }

    public function podeReenviar(string $status, bool $administrador): bool
    {
        return $administrador && $status === 'REJEITADO';
    }

    private function normalizar(string $status): string
    {
        return mb_strtoupper(trim($status), 'UTF-8');
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSSTATUSSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsTelefone.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSTELEFONE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsTelefone.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsTelefone`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function selecionar(array $fontes): ?array
public function selecionarCarga(array $fontes): ?array
public function avaliar(array $fontes): array
public function ordemDaFonte(?string $fonte): int
public function ordemDoDiagnostico(string $codigo): int
public function rotuloDoDiagnostico(string $codigo): string
private function avaliarPorPrioridade(array $fontes, array $prioridade): array
private function avaliarFonte(string $fonte, array $fontes): array
private function avaliarTelefoneManual(string $fonte, mixed $valor): array
private function prepararDigitos(mixed $valor): ?array
private function celularValido(string $nacional): bool
private function criarTelefone(string $fonte, string $nacional, array $transformacoes): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Support\Validation\TelefoneBrasileiro;

final class ConvocacaoSmsTelefone
{
    /** @var array<int, string> */
    private const PRIORIDADE = [
        'telefone_manual',
        'telefone_perfil',
        'num_tel_eleitor',
        'num_tel_eleitor_2',
        'num_telefone',
        'num_telefone_comercial',
    ];

    /** @var array<int, string> */
    private const PRIORIDADE_CARGA = [
        'telefone_perfil',
        'num_tel_eleitor',
        'num_tel_eleitor_2',
        'num_telefone',
        'num_telefone_comercial',
    ];

    /** @var array<string, string> */
    private const TIPO_POR_FONTE = [
        'num_tel_eleitor' => 'tip_tel_eleitor',
        'num_tel_eleitor_2' => 'tip_tel_eleitor2',
        'num_telefone' => 'tip_telefone',
        'num_telefone_comercial' => 'tip_telefone_comercial',
    ];

    /** @var array<string, string> */
    private const ROTULOS_DIAGNOSTICO = [
        'SEM_TELEFONE_INFORMADO' => 'Sem telefone informado',
        'SOMENTE_TELEFONE_FIXO' => 'Somente telefone fixo',
        'NUMERO_LOCAL_NAO_NORMALIZAVEL' => 'Número local sem DDD não normalizável',
        'FORMATO_LEGADO_INVALIDO' => 'Telefone legado não normalizável',
        'FORMATO_INVALIDO' => 'Telefone informado em formato inválido',
    ];

    /** @var array<string, int> */
    private const ORDEM_DIAGNOSTICO = [
        'SEM_TELEFONE_INFORMADO' => 0,
        'SOMENTE_TELEFONE_FIXO' => 1,
        'FORMATO_LEGADO_INVALIDO' => 2,
        'NUMERO_LOCAL_NAO_NORMALIZAVEL' => 3,
        'FORMATO_INVALIDO' => 4,
    ];

    /** @var array<string, string> */
    private const ROTULOS_NORMALIZACAO = [
        'PREFIXO_55_REMOVIDO' => 'prefixo 55 removido',
        'PREFIXO_0_REMOVIDO' => 'prefixo 0 removido',
        'DDD_68_INFERIDO' => 'DDD 68 inferido',
        'NONO_DIGITO_INFERIDO' => 'nono dígito inferido',
    ];

    /**
     * @param  array<string, mixed>  $fontes
     * @return array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}|null
     */
    public function selecionar(array $fontes): ?array
    {
        return $this->avaliar($fontes)['telefone'];
    }

    /**
     * @param  array<string, mixed>  $fontes
     * @return array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}|null
     */
    public function selecionarCarga(array $fontes): ?array
    {
        return $this->avaliarPorPrioridade($fontes, self::PRIORIDADE_CARGA)['telefone'];
    }

    /**
     * @param  array<string, mixed>  $fontes
     * @return array{
     *     telefone:array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}|null,
     *     diagnostico_codigo:string,
     *     diagnostico_rotulo:string
     * }
     */
    public function avaliar(array $fontes): array
    {
        return $this->avaliarPorPrioridade($fontes, self::PRIORIDADE);
    }

    public function ordemDaFonte(?string $fonte): int
    {
        $ordem = array_search($fonte, self::PRIORIDADE, true);

        return $ordem === false ? PHP_INT_MAX : $ordem;
    }

    public function ordemDoDiagnostico(string $codigo): int
    {
        return self::ORDEM_DIAGNOSTICO[$codigo] ?? PHP_INT_MAX;
    }

    public function rotuloDoDiagnostico(string $codigo): string
    {
        return self::ROTULOS_DIAGNOSTICO[$codigo] ?? self::ROTULOS_DIAGNOSTICO['FORMATO_INVALIDO'];
    }

    /**
     * @param  array<string, mixed>  $fontes
     * @param  array<int, string>  $prioridade
     * @return array{
     *     telefone:array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}|null,
     *     diagnostico_codigo:string,
     *     diagnostico_rotulo:string
     * }
     */
    private function avaliarPorPrioridade(array $fontes, array $prioridade): array
    {
        $diagnostico = 'SEM_TELEFONE_INFORMADO';

        foreach ($prioridade as $fonte) {
            $avaliacao = $this->avaliarFonte($fonte, $fontes);
            if ($avaliacao['telefone'] !== null) {
                return [
                    'telefone' => $avaliacao['telefone'],
                    'diagnostico_codigo' => $avaliacao['telefone']['normalizacao_codigo'] ?? 'VALIDO_SEM_NORMALIZACAO',
                    'diagnostico_rotulo' => $avaliacao['telefone']['normalizacao_rotulo'] ?? 'Telefone válido sem normalização',
                ];
            }

            if ($this->ordemDoDiagnostico($avaliacao['diagnostico_codigo']) > $this->ordemDoDiagnostico($diagnostico)) {
                $diagnostico = $avaliacao['diagnostico_codigo'];
            }
        }

        return [
            'telefone' => null,
            'diagnostico_codigo' => $diagnostico,
            'diagnostico_rotulo' => $this->rotuloDoDiagnostico($diagnostico),
        ];
    }

    /**
     * @param  array<string, mixed>  $fontes
     * @return array{
     *     telefone:array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}|null,
     *     diagnostico_codigo:string
     * }
     */
    private function avaliarFonte(string $fonte, array $fontes): array
    {
        $valor = $fontes[$fonte] ?? null;
        if ($this->vazio($valor)) {
            return ['telefone' => null, 'diagnostico_codigo' => 'SEM_TELEFONE_INFORMADO'];
        }

        $campoTipo = self::TIPO_POR_FONTE[$fonte] ?? null;
        $tipo = $campoTipo !== null ? trim((string) ($fontes[$campoTipo] ?? '')) : '';
        if ($tipo === '1') {
            return ['telefone' => null, 'diagnostico_codigo' => 'SOMENTE_TELEFONE_FIXO'];
        }
        if ($tipo !== '' && $tipo !== '2') {
            return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_INVALIDO'];
        }

        if ($fonte === 'telefone_manual') {
            return $this->avaliarTelefoneManual($fonte, $valor);
        }

        $preparado = $this->prepararDigitos($valor);
        if ($preparado === null) {
            return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_INVALIDO'];
        }

        [$digitos, $possuiSinalMais] = $preparado;
        $transformacoes = [];

        if (in_array(strlen($digitos), [12, 13], true) && str_starts_with($digitos, '55')) {
            $digitos = substr($digitos, 2);
            $transformacoes[] = 'PREFIXO_55_REMOVIDO';
        } elseif ($possuiSinalMais) {
            return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_INVALIDO'];
        }

        if (strlen($digitos) === 12 && str_starts_with($digitos, '0')) {
            $semPrefixo = substr($digitos, 1);
            if ($this->celularValido($semPrefixo)) {
                $transformacoes[] = 'PREFIXO_0_REMOVIDO';

                return ['telefone' => $this->criarTelefone($fonte, $semPrefixo, $transformacoes), 'diagnostico_codigo' => ''];
            }
        }

        if ($this->celularValido($digitos)) {
            return ['telefone' => $this->criarTelefone($fonte, $digitos, $transformacoes), 'diagnostico_codigo' => ''];
        }

        if (strlen($digitos) === 10 && TelefoneBrasileiro::valido($digitos)) {
            return ['telefone' => null, 'diagnostico_codigo' => 'SOMENTE_TELEFONE_FIXO'];
        }

        if (strlen($digitos) === 8 && in_array($digitos[0], ['2', '3', '4', '5'], true)) {
            return ['telefone' => null, 'diagnostico_codigo' => 'SOMENTE_TELEFONE_FIXO'];
        }

        if (strlen($digitos) === 9) {
            $nacional = '68'.$digitos;
            if ($this->celularValido($nacional)) {
                $transformacoes[] = 'DDD_68_INFERIDO';

                return ['telefone' => $this->criarTelefone($fonte, $nacional, $transformacoes), 'diagnostico_codigo' => ''];
            }

            return ['telefone' => null, 'diagnostico_codigo' => 'NUMERO_LOCAL_NAO_NORMALIZAVEL'];
        }

        if (strlen($digitos) === 8) {
            $nacional = '689'.$digitos;
            if ($this->celularValido($nacional)) {
                $transformacoes[] = 'DDD_68_INFERIDO';
                $transformacoes[] = 'NONO_DIGITO_INFERIDO';

                return ['telefone' => $this->criarTelefone($fonte, $nacional, $transformacoes), 'diagnostico_codigo' => ''];
            }

            return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_LEGADO_INVALIDO'];
        }

        if (strlen($digitos) === 10) {
            $nacional = substr($digitos, 0, 2).'9'.substr($digitos, 2);
            if ($this->celularValido($nacional)) {
                $transformacoes[] = 'NONO_DIGITO_INFERIDO';

                return ['telefone' => $this->criarTelefone($fonte, $nacional, $transformacoes), 'diagnostico_codigo' => ''];
            }

            return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_LEGADO_INVALIDO'];
        }

        return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_INVALIDO'];
    }

    /**
     * @return array{
     *     telefone:array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}|null,
     *     diagnostico_codigo:string
     * }
     */
    private function avaliarTelefoneManual(string $fonte, mixed $valor): array
    {
        $nacional = TelefoneBrasileiro::normalizar($valor);
        if ($nacional !== null && $this->celularValido($nacional)) {
            return ['telefone' => $this->criarTelefone($fonte, $nacional, []), 'diagnostico_codigo' => ''];
        }
        if ($nacional !== null && strlen($nacional) === 10 && TelefoneBrasileiro::valido($nacional)) {
            return ['telefone' => null, 'diagnostico_codigo' => 'SOMENTE_TELEFONE_FIXO'];
        }

        return ['telefone' => null, 'diagnostico_codigo' => 'FORMATO_INVALIDO'];
    }

    /** @return array{string, bool}|null */
    private function prepararDigitos(mixed $valor): ?array
    {
        if (! is_string($valor) && ! is_numeric($valor)) {
            return null;
        }

        $compacto = str_replace(
            [' ', "\t", "\r", "\n", '(', ')', '-', '.'],
            '',
            trim((string) $valor),
        );
        $possuiSinalMais = str_starts_with($compacto, '+');
        if ($possuiSinalMais) {
            $compacto = substr($compacto, 1);
        }

        if ($compacto === '' || ! ctype_digit($compacto)) {
            return null;
        }

        return [$compacto, $possuiSinalMais];
    }

    private function celularValido(string $nacional): bool
    {
        return strlen($nacional) === 11 && TelefoneBrasileiro::valido($nacional);
    }

    /**
     * @param  array<int, string>  $transformacoes
     * @return array{fonte:string,nacional:string,e164:string,normalizacao_codigo:?string,normalizacao_rotulo:?string}
     */
    private function criarTelefone(string $fonte, string $nacional, array $transformacoes): array
    {
        $codigo = $transformacoes !== [] ? implode('+', $transformacoes) : null;
        $rotulos = array_map(
            static fn (string $transformacao): string => self::ROTULOS_NORMALIZACAO[$transformacao],
            $transformacoes,
        );

        return [
            'fonte' => $fonte,
            'nacional' => $nacional,
            'e164' => '55'.$nacional,
            'normalizacao_codigo' => $codigo,
            'normalizacao_rotulo' => $rotulos !== [] ? ucfirst(implode(' e ', $rotulos)) : null,
        ];
    }

    private function vazio(mixed $valor): bool
    {
        return $valor === null || ((is_string($valor) || is_numeric($valor)) && trim((string) $valor) === '');
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSTELEFONE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsTelefoneManualService.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSTELEFONEMANUALSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsTelefoneManualService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ConvocacaoSmsTelefoneManualService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function processar(string $numInscricao, array $dados, ConvocacaoSmsContexto $contexto): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsTelefoneManualRepositoryInterface;
use App\Support\Validation\TelefoneBrasileiro;
use DomainException;
use Illuminate\Auth\Access\AuthorizationException;

final readonly class ConvocacaoSmsTelefoneManualService
{
    public function __construct(
        private ConvocacaoSmsDestinatarioRepositoryInterface $destinatarios,
        private ConvocacaoSmsTelefoneManualRepositoryInterface $telefones,
        private ConvocacaoSmsStatusService $status,
    ) {}

    /**
     * @param  array<string, mixed>  $dados
     * @return array{acao:string,alterado:bool}
     */
    public function processar(string $numInscricao, array $dados, ConvocacaoSmsContexto $contexto): array
    {
        if (! $contexto->podeAlterarTelefone) {
            throw new AuthorizationException('Usuário sem permissão para alterar telefone de nomeado.');
        }

        $inscricao = trim($numInscricao);
        $zonaInformada = trim((string) ($dados['zona'] ?? ''));
        $zona = preg_match('/^\d{1,10}$/', $zonaInformada) === 1 ? (string) ((int) $zonaInformada) : '';
        if (preg_match('/^\d{1,20}$/', $inscricao) !== 1 || $zona === '') {
            throw new DomainException('Inscrição ou zona inválida para alteração do telefone.');
        }

        $encontrados = array_values($this->destinatarios->buscarPorInscricoes([$inscricao], $zona, $contexto));
        $destinatario = $encontrados[0] ?? null;
        if ($destinatario === null) {
            throw new DomainException('A nomeação não foi encontrada no turno, pleito, zona e escopo ativos.');
        }
        if (! $this->status->podeAlterarTelefoneAntesEnvio(
            (string) ($destinatario['situacao_comunicacao'] ?? ''),
            $contexto->gestor,
        )) {
            throw new DomainException('O telefone só pode ser alterado antes da reserva ou, pelo gestor, antes de um novo envio.');
        }

        $acao = mb_strtoupper(trim((string) ($dados['acao'] ?? '')), 'UTF-8');
        if ($acao === 'RESTAURAR') {
            return ['acao' => 'RESTAURAR', 'alterado' => $this->telefones->remover($inscricao)];
        }
        if ($acao !== 'SALVAR') {
            throw new DomainException('Ação inválida para alteração do telefone.');
        }

        $telefone = TelefoneBrasileiro::normalizar($dados['telefone'] ?? null);
        if ($telefone === null || strlen($telefone) !== 11 || ! TelefoneBrasileiro::valido($telefone)) {
            throw new DomainException('Informe um celular nacional válido.');
        }
        if ($telefone === (string) ($destinatario['telefone_carga_nacional'] ?? '')) {
            return ['acao' => 'RESTAURAR', 'alterado' => $this->telefones->remover($inscricao)];
        }

        return [
            'acao' => 'SALVAR',
            'alterado' => $this->telefones->salvar(
                $inscricao,
                $telefone,
                $contexto->usuarioLogin,
                $contexto->usuarioNome,
            ),
        ];
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSTELEFONEMANUALSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ConvocacaoSmsTransacao.php`
## <APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSTRANSACAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ConvocacaoSmsTransacao.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsTransacao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function executar(callable $operacao): mixed
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use Illuminate\Support\Facades\DB;

final class ConvocacaoSmsTransacao
{
    /**
     * @template T
     *
     * @param  callable(): T  $operacao
     * @return T
     */
    public function executar(callable $operacao): mixed
    {
        return DB::transaction($operacao);
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_CONVOCACAOSMSTRANSACAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/SmsDisponibilidade.php`
## <APP_SERVICES_CONVOCACAOSMS_SMSDISPONIBILIDADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/SmsDisponibilidade.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class SmsDisponibilidade`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly TextBeeSmsConfiguracao $configuracao) {}
public function diagnostico(): array
public function exigir(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use DomainException;

final class SmsDisponibilidade
{
    public function __construct(private readonly TextBeeSmsConfiguracao $configuracao) {}

    /** @return array{disponivel:bool,motivos:array<int, string>} */
    public function diagnostico(): array
    {
        $config = (array) config('planeleito.sms_textbee', []);
        $motivos = [];
        try {
            $this->configuracao->obrigatoria();
        } catch (DomainException) {
            $motivos[] = 'A integração SMS está desabilitada ou incompleta neste ambiente.';
        }
        if (! ($config['worker_enabled'] ?? false)) {
            $motivos[] = 'O worker de convocação por SMS não está habilitado neste ambiente.';
        }
        if (! ($config['sync_enabled'] ?? false)) {
            $motivos[] = 'A sincronização de resultados SMS não está habilitada neste ambiente.';
        }

        return ['disponivel' => $motivos === [], 'motivos' => array_values(array_unique($motivos))];
    }

    public function exigir(): void
    {
        $diagnostico = $this->diagnostico();
        if (! $diagnostico['disponivel']) {
            throw new DomainException(implode(' ', $diagnostico['motivos']));
        }
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_SMSDISPONIBILIDADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/SmsEnvioResultado.php`
## <APP_SERVICES_CONVOCACAOSMS_SMSENVIORESULTADO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/SmsEnvioResultado.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class SmsEnvioResultado`

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

namespace App\Services\ConvocacaoSms;

final readonly class SmsEnvioResultado
{
    public function __construct(
        public bool $aceito,
        public ?string $idLote,
        public bool $rejeicaoExplicita,
        public ?string $codigoErro = null,
        public ?string $mensagemErro = null,
    ) {}
}
```
</APP_SERVICES_CONVOCACAOSMS_SMSENVIORESULTADO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsCadencia.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCADENCIA_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsCadencia.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class TextBeeSmsCadencia`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private CacheRepository $cache) {}
public function executar(string $deviceId, ?int $simSubscriptionId, int $segmentos, Closure $operacao): bool
public function intervaloSegundos(int $segmentos): int
public function pausarPorLimite(string $deviceId, ?int $simSubscriptionId, ?int $segundos = null): void
public function segundosDePausa(string $deviceId, ?int $simSubscriptionId): int
private function identidade(string $deviceId, ?int $simSubscriptionId): string
private function chaveProximoEnvio(string $identidade): string
private function chavePausa(string $identidade): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use Closure;
use Illuminate\Contracts\Cache\LockProvider;
use Illuminate\Contracts\Cache\LockTimeoutException;
use Illuminate\Contracts\Cache\Repository as CacheRepository;
use Illuminate\Support\Sleep;

final readonly class TextBeeSmsCadencia
{
    public function __construct(private CacheRepository $cache) {}

    /** @param Closure(): bool $operacao */
    public function executar(string $deviceId, ?int $simSubscriptionId, int $segmentos, Closure $operacao): bool
    {
        $store = $this->cache->getStore();
        if (! $store instanceof LockProvider) {
            throw new TextBeeSmsCadenciaIndisponivelException('O cache ativo não oferece lock para a cadência SMS.');
        }

        $identidade = $this->identidade($deviceId, $simSubscriptionId);
        $lock = $store->lock('planeleito:sms:textbee:cadencia:lock:'.$identidade, 120);

        try {
            return (bool) $lock->block(60, function () use ($identidade, $segmentos, $operacao): bool {
                $agora = now()->timestamp;
                $proximo = (int) $this->cache->get($this->chaveProximoEnvio($identidade), 0);
                $espera = max(0, $proximo - $agora);
                if ($espera > 0) {
                    Sleep::sleep($espera);
                }

                $chamadaExterna = (bool) $operacao();
                if ($chamadaExterna) {
                    $this->cache->forever(
                        $this->chaveProximoEnvio($identidade),
                        now()->timestamp + $this->intervaloSegundos($segmentos),
                    );
                }

                return $chamadaExterna;
            });
        } catch (LockTimeoutException $exception) {
            throw new TextBeeSmsCadenciaIndisponivelException(
                'Não foi possível adquirir a cadência exclusiva do aparelho SMS.',
                previous: $exception,
            );
        }
    }

    public function intervaloSegundos(int $segmentos): int
    {
        $minimo = max(1, (int) config('planeleito.sms_textbee.min_interval_seconds', 15));
        $porSegmento = max(1, (int) config('planeleito.sms_textbee.seconds_per_segment', 3));

        return max($minimo, max(1, $segmentos) * $porSegmento);
    }

    public function pausarPorLimite(string $deviceId, ?int $simSubscriptionId, ?int $segundos = null): void
    {
        $segundos = max(1, $segundos ?? (int) config('planeleito.sms_textbee.limit_cooldown_seconds', 900));
        $chave = $this->chavePausa($this->identidade($deviceId, $simSubscriptionId));
        $atual = (int) $this->cache->get($chave, 0);
        $ate = max($atual, now()->timestamp + $segundos);

        $this->cache->put($chave, $ate, max(60, $ate - now()->timestamp + 60));
    }

    public function segundosDePausa(string $deviceId, ?int $simSubscriptionId): int
    {
        $ate = (int) $this->cache->get(
            $this->chavePausa($this->identidade($deviceId, $simSubscriptionId)),
            0,
        );

        return max(0, $ate - now()->timestamp);
    }

    private function identidade(string $deviceId, ?int $simSubscriptionId): string
    {
        $deviceId = trim($deviceId);
        if ($deviceId === '') {
            throw new TextBeeSmsCadenciaIndisponivelException('O aparelho SMS não foi informado para a cadência.');
        }

        return hash('sha256', $deviceId.'|'.($simSubscriptionId ?? 'DEFAULT'));
    }

    private function chaveProximoEnvio(string $identidade): string
    {
        return 'planeleito:sms:textbee:cadencia:proximo:'.$identidade;
    }

    private function chavePausa(string $identidade): string
    {
        return 'planeleito:sms:textbee:cadencia:pausa:'.$identidade;
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCADENCIA_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsCadenciaIndisponivelException.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCADENCIAINDISPONIVELEXCEPTION_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsCadenciaIndisponivelException.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class TextBeeSmsCadenciaIndisponivelException extends RuntimeException {}`

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

namespace App\Services\ConvocacaoSms;

use RuntimeException;

final class TextBeeSmsCadenciaIndisponivelException extends RuntimeException {}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCADENCIAINDISPONIVELEXCEPTION_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsClient.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCLIENT_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsClient.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class TextBeeSmsClient implements SmsGatewayInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly TextBeeSmsConfiguracao $configuracao) {}
public function enviar(string $destino, string $texto, string $externalId): SmsEnvioResultado
private function request(array $config): PendingRequest
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Services\ConvocacaoSms\Contracts\SmsGatewayInterface;
use Illuminate\Http\Client\PendingRequest;
use Illuminate\Support\Facades\Http;
use RuntimeException;

final class TextBeeSmsClient implements SmsGatewayInterface
{
    public function __construct(private readonly TextBeeSmsConfiguracao $configuracao) {}

    public function enviar(string $destino, string $texto, string $externalId): SmsEnvioResultado
    {
        $config = $this->configuracao->obrigatoria();
        $payload = [
            'deviceId' => (string) $config['device_id'],
            'recipients' => ['+'.ltrim(trim($destino), '+')],
            'message' => $texto,
        ];
        if (($config['sim_subscription_id'] ?? null) !== null && trim((string) $config['sim_subscription_id']) !== '') {
            $payload['simSubscriptionId'] = (int) $config['sim_subscription_id'];
        }

        $resposta = $this->request($config)->post(
            rtrim((string) $config['base_url'], '/').'/api/v1/gateway/send-sms',
            $payload,
        );
        if ($resposta->serverError()) {
            throw new RuntimeException('O provedor SMS retornou erro temporário.');
        }

        $idLote = trim((string) ($resposta->json('data.smsBatchId') ?? $resposta->json('smsBatchId') ?? ''));
        if ($resposta->successful() && $idLote !== '') {
            return new SmsEnvioResultado(true, $idLote, false);
        }
        if ($resposta->successful()) {
            throw new RuntimeException('O provedor SMS aceitou a chamada sem devolver o identificador do lote.');
        }

        $codigo = trim((string) ($resposta->json('error.code') ?? $resposta->json('code') ?? $resposta->status()));
        $mensagem = trim((string) ($resposta->json('error.message') ?? $resposta->json('message') ?? ''));

        return new SmsEnvioResultado(
            false,
            null,
            $resposta->clientError(),
            $codigo !== '' ? $codigo : null,
            $mensagem !== '' ? $mensagem : null,
        );
    }

    /** @param array<string, mixed> $config */
    private function request(array $config): PendingRequest
    {
        return Http::acceptJson()
            ->asJson()
            ->withHeaders(['x-api-key' => (string) $config['api_key']])
            ->connectTimeout(max(1, (int) ($config['connect_timeout'] ?? 3)))
            ->timeout(max(1, (int) ($config['timeout'] ?? 8)));
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCLIENT_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsConfiguracao.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCONFIGURACAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsConfiguracao.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final class TextBeeSmsConfiguracao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function obrigatoria(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use DomainException;

final class TextBeeSmsConfiguracao
{
    /** @return array<string, mixed> */
    public function obrigatoria(): array
    {
        $config = (array) config('planeleito.sms_textbee', []);
        if (! ($config['enabled'] ?? false)) {
            throw new DomainException('A integração SMS não está configurada.');
        }
        foreach (['base_url', 'api_key', 'device_id'] as $campo) {
            if (trim((string) ($config[$campo] ?? '')) === '') {
                throw new DomainException('A integração SMS não está configurada.');
            }
        }
        if (! str_starts_with(mb_strtolower((string) $config['base_url'], 'UTF-8'), 'https://')) {
            throw new DomainException('A URL da integração SMS deve usar HTTPS.');
        }

        return $config;
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSCONFIGURACAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsSincronizacaoService.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSSINCRONIZACAOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsSincronizacaoService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `class TextBeeSmsSincronizacaoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function sincronizar(): array
public static function checkpointKey(string $deviceId): string
private function sincronizarEnvio(array $envio, array $indice): int
private function indexarMensagens(array $mensagens): array
private function inicioConsultaEnvios(array $pendentes): string
private function chaveMensagem(string $batchId, string $deviceId, string $telefone): string
private function aplicarStatus(array $mensagem, string $batchId, string $deviceId): int
private function eventoRecebido(array $mensagem, string $deviceId): array
private function eventoId(string $smsId, string $status, string $data): string
private function instanteCanonico(string $valor): string
private function telefone(string $valor): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsSincronizacaoRepositoryInterface;
use Illuminate\Contracts\Cache\Repository as CacheRepository;
use Illuminate\Support\Carbon;
use RuntimeException;
use Throwable;

class TextBeeSmsSincronizacaoService
{
    public function __construct(
        private readonly TextBeeSmsConsultaClient $consulta,
        private readonly ConvocacaoSmsSincronizacaoRepositoryInterface $envios,
        private readonly TextBeeSmsWebhookService $eventos,
        private readonly CacheRepository $cache,
    ) {}

    /**
     * @return array{
     *   habilitado:bool,
     *   envios_consultados:int,
     *   eventos_aplicados:int,
     *   respostas_consultadas:int,
     *   respostas_aplicadas:int
     * }
     */
    public function sincronizar(): array
    {
        $resultado = [
            'habilitado' => (bool) config('planeleito.sms_textbee.sync_enabled', false),
            'envios_consultados' => 0,
            'eventos_aplicados' => 0,
            'respostas_consultadas' => 0,
            'respostas_aplicadas' => 0,
        ];
        if (! $resultado['habilitado']) {
            return $resultado;
        }

        $config = (array) config('planeleito.sms_textbee', []);
        $deviceId = trim((string) ($config['device_id'] ?? ''));
        if ($deviceId === '') {
            throw new RuntimeException('O aparelho TextBee não está configurado para sincronização.');
        }

        $pendentes = $this->envios->listarTextBeePendentesSincronizacao();
        $resultado['envios_consultados'] = count($pendentes);
        if ($pendentes !== []) {
            $mensagens = $this->consulta->listarEnviadasDesde($this->inicioConsultaEnvios($pendentes));
            $indice = $this->indexarMensagens($mensagens);
            foreach ($pendentes as $envio) {
                $resultado['eventos_aplicados'] += $this->sincronizarEnvio($envio, $indice);
            }
        }

        $chaveCheckpoint = self::checkpointKey($deviceId);
        $inicial = $this->instanteCanonico((string) ($config['sync_initial_from'] ?? ''));
        $desde = $this->instanteCanonico((string) $this->cache->get($chaveCheckpoint, $inicial));
        $recebidas = $this->consulta->listarRecebidasDesde($desde);
        $resultado['respostas_consultadas'] = count($recebidas);
        $maiorCriacao = null;
        foreach ($recebidas as $mensagem) {
            [$evento, $criadoEm] = $this->eventoRecebido($mensagem, $deviceId);
            $processado = $this->eventos->processar($evento);
            $resultado['respostas_aplicadas'] += (int) $processado['aplicados'];
            if ($maiorCriacao === null || strcmp($criadoEm, $maiorCriacao) > 0) {
                $maiorCriacao = $criadoEm;
            }
        }
        if ($maiorCriacao !== null) {
            $this->cache->forever($chaveCheckpoint, $maiorCriacao);
        }

        return $resultado;
    }

    public static function checkpointKey(string $deviceId): string
    {
        return 'planeleito:sms:textbee:recebidas:'.hash('sha256', trim($deviceId));
    }

    /**
     * @param  array<string, mixed>  $envio
     * @param  array<string, array<int, array<string, mixed>>>  $indice
     */
    private function sincronizarEnvio(array $envio, array $indice): int
    {
        $batchId = trim((string) ($envio['provider_batch_id'] ?? ''));
        $deviceId = trim((string) ($envio['provider_device_id'] ?? ''));
        $telefone = $this->telefone((string) ($envio['telefone_e164'] ?? ''));
        if ($batchId === '' || $deviceId === '' || $telefone === '') {
            throw new RuntimeException('Um envio TextBee pendente possui metadados incompletos.');
        }

        $compativeis = $indice[$this->chaveMensagem($batchId, $deviceId, $telefone)] ?? [];
        if ($compativeis === []) {
            return 0;
        }
        if (count($compativeis) !== 1) {
            throw new RuntimeException('O lote TextBee retornou mais de uma mensagem para o mesmo destinatário.');
        }

        return $this->aplicarStatus($compativeis[0], $batchId, $deviceId);
    }

    /**
     * @param  array<int, array<string, mixed>>  $mensagens
     * @return array<string, array<int, array<string, mixed>>>
     */
    private function indexarMensagens(array $mensagens): array
    {
        $indice = [];
        foreach ($mensagens as $mensagem) {
            $batchId = trim((string) ($mensagem['smsBatch'] ?? $mensagem['smsBatchId'] ?? ''));
            $deviceId = trim((string) data_get($mensagem, 'device._id', $mensagem['deviceId'] ?? ''));
            $telefone = $this->telefone((string) ($mensagem['recipient'] ?? ''));
            if ($batchId === '' || $deviceId === '' || $telefone === '') {
                continue;
            }
            $indice[$this->chaveMensagem($batchId, $deviceId, $telefone)][] = $mensagem;
        }

        return $indice;
    }

    /** @param array<int, array<string, mixed>> $pendentes */
    private function inicioConsultaEnvios(array $pendentes): string
    {
        $timezone = (string) config('app.timezone', 'UTC');
        $maisAntigo = null;
        foreach ($pendentes as $envio) {
            $valor = trim((string) ($envio['dt_criacao'] ?? ''));
            if ($valor === '') {
                throw new RuntimeException('Um envio TextBee pendente não possui data de criação.');
            }
            try {
                $instante = Carbon::parse($valor, $timezone);
            } catch (Throwable) {
                throw new RuntimeException('Um envio TextBee pendente possui data de criação inválida.');
            }
            if ($maisAntigo === null || $instante->lessThan($maisAntigo)) {
                $maisAntigo = $instante;
            }
        }
        if ($maisAntigo === null) {
            throw new RuntimeException('Não foi possível determinar o início da consulta TextBee.');
        }

        return $maisAntigo->copy()->subMinutes(5)->utc()->format('Y-m-d\TH:i:s\Z');
    }

    private function chaveMensagem(string $batchId, string $deviceId, string $telefone): string
    {
        return implode('|', [$batchId, $deviceId, $telefone]);
    }

    /** @param array<string, mixed> $mensagem */
    private function aplicarStatus(array $mensagem, string $batchId, string $deviceId): int
    {
        $smsId = trim((string) ($mensagem['_id'] ?? $mensagem['smsId'] ?? ''));
        if ($smsId === '') {
            throw new RuntimeException('A mensagem TextBee consultada não possui identificador.');
        }
        $status = mb_strtolower(trim((string) ($mensagem['status'] ?? '')), 'UTF-8');
        $base = [
            'smsId' => $smsId,
            'smsBatchId' => $batchId,
            'deviceId' => $deviceId,
            'recipient' => (string) ($mensagem['recipient'] ?? ''),
        ];
        $aplicados = 0;
        $sentAt = trim((string) ($mensagem['sentAt'] ?? ''));
        if ($sentAt !== '' && in_array($status, ['sent', 'delivered', 'failed'], true)) {
            $resultado = $this->eventos->processar($base + [
                'webhookEvent' => 'MESSAGE_SENT',
                'idempotencyKey' => $this->eventoId($smsId, 'sent', $sentAt),
                'sentAt' => $sentAt,
            ]);
            $aplicados += (int) $resultado['aplicados'];
        }

        $campoData = match ($status) {
            'delivered' => 'deliveredAt',
            'failed' => 'failedAt',
            default => null,
        };
        $tipoEvento = match ($status) {
            'sent' => $sentAt === '' ? 'MESSAGE_SENT' : null,
            'delivered' => 'MESSAGE_DELIVERED',
            'failed' => 'MESSAGE_FAILED',
            default => null,
        };
        if ($tipoEvento === null) {
            return $aplicados;
        }

        $dataEvento = trim((string) ($campoData !== null ? ($mensagem[$campoData] ?? '') : ''));
        if ($dataEvento === '') {
            $dataEvento = trim((string) ($mensagem['updatedAt'] ?? $mensagem['createdAt'] ?? ''));
        }
        $erro = is_array($mensagem['error'] ?? null) ? $mensagem['error'] : [];
        $payload = $base + [
            'webhookEvent' => $tipoEvento,
            'idempotencyKey' => $this->eventoId($smsId, $status, $dataEvento),
            $campoData ?? 'sentAt' => $dataEvento,
            'errorCode' => (string) ($mensagem['errorCode'] ?? $erro['code'] ?? ''),
            'errorMessage' => (string) ($mensagem['errorMessage'] ?? $erro['message'] ?? ''),
            'status' => $status,
        ];
        $resultado = $this->eventos->processar($payload);

        return $aplicados + (int) $resultado['aplicados'];
    }

    /** @param array<string, mixed> $mensagem @return array{array<string, mixed>, string} */
    private function eventoRecebido(array $mensagem, string $deviceId): array
    {
        $smsId = trim((string) ($mensagem['_id'] ?? $mensagem['smsId'] ?? ''));
        $deviceMensagem = trim((string) data_get($mensagem, 'device._id', $mensagem['deviceId'] ?? ''));
        $sender = trim((string) ($mensagem['sender'] ?? ''));
        $texto = (string) ($mensagem['message'] ?? '');
        $recebidoEm = trim((string) ($mensagem['receivedAt'] ?? ''));
        $criadoEm = $this->instanteCanonico((string) ($mensagem['createdAt'] ?? ''));
        if ($smsId === '' || $sender === '' || trim($texto) === '' || $recebidoEm === ''
            || ! hash_equals($deviceId, $deviceMensagem)) {
            throw new RuntimeException('A API TextBee retornou uma mensagem recebida inválida.');
        }

        return [[
            'webhookEvent' => 'MESSAGE_RECEIVED',
            'smsId' => $smsId,
            'deviceId' => $deviceMensagem,
            'sender' => $sender,
            'message' => $texto,
            'receivedAt' => $recebidoEm,
        ], $criadoEm];
    }

    private function eventoId(string $smsId, string $status, string $data): string
    {
        return 'textbee:poll:'.hash('sha256', implode('|', [$smsId, $status, $data]));
    }

    private function instanteCanonico(string $valor): string
    {
        if (trim($valor) === '') {
            throw new RuntimeException('A data inicial da sincronização TextBee não está configurada.');
        }
        try {
            return Carbon::parse($valor)->utc()->format('Y-m-d\TH:i:s\Z');
        } catch (Throwable) {
            throw new RuntimeException('A data da sincronização TextBee é inválida.');
        }
    }

    private function telefone(string $valor): string
    {
        return preg_replace('/\D+/', '', $valor) ?? '';
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSSINCRONIZACAOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsWebhookAutenticacao.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSWEBHOOKAUTENTICACAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsWebhookAutenticacao.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class TextBeeSmsWebhookAutenticacao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private string $segredo) {}
public function assinaturaValida(string $corpoBruto, ?string $recebida): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

final readonly class TextBeeSmsWebhookAutenticacao
{
    public function __construct(private string $segredo) {}

    public function assinaturaValida(string $corpoBruto, ?string $recebida): bool
    {
        if ($this->segredo === '' || ! is_string($recebida) || $recebida === '') {
            return false;
        }

        return hash_equals(hash_hmac('sha256', $corpoBruto, $this->segredo), mb_strtolower(trim($recebida), 'UTF-8'));
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSWEBHOOKAUTENTICACAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/TextBeeSmsWebhookService.php`
## <APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSWEBHOOKSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/TextBeeSmsWebhookService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `class TextBeeSmsWebhookService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function processar(array $evento): array
private function processarStatus(array $evento, string $tipo): bool
private function processarResposta(array $evento): bool
private function eventoId(array $evento, string $tipo): string
private function erro(array $evento): array
private function timestampEvento(array $evento, string $tipo): string
private function timestamp(string $valor): ?int
private function telefone(string $valor): string
private function sanitizar(string $valor, int $limite): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRespostaRepositoryInterface;
use Illuminate\Support\Carbon;
use Throwable;

class TextBeeSmsWebhookService
{
    public function __construct(
        private readonly ConvocacaoSmsEnvioRepositoryInterface $envios,
        private readonly ConvocacaoSmsRespostaRepositoryInterface $respostas,
        private readonly ConvocacaoSmsStatusService $statusService,
        private readonly TextBeeSmsCadencia $cadencia,
    ) {}

    /** @param array<string, mixed> $evento @return array{recebidos:int,aplicados:int,ignorados:int} */
    public function processar(array $evento): array
    {
        $resultado = ['recebidos' => 1, 'aplicados' => 0, 'ignorados' => 0];
        $tipo = mb_strtoupper(trim((string) ($evento['webhookEvent'] ?? '')), 'UTF-8');
        $aplicado = $tipo === 'MESSAGE_RECEIVED'
            ? $this->processarResposta($evento)
            : $this->processarStatus($evento, $tipo);
        $resultado[$aplicado ? 'aplicados' : 'ignorados']++;

        return $resultado;
    }

    /** @param array<string, mixed> $evento */
    private function processarStatus(array $evento, string $tipo): bool
    {
        if (! in_array($tipo, ['MESSAGE_SENT', 'MESSAGE_DELIVERED', 'MESSAGE_FAILED'], true)) {
            return false;
        }
        $batchId = trim((string) ($evento['smsBatchId'] ?? ''));
        $smsId = trim((string) ($evento['smsId'] ?? ''));
        $envio = $this->envios->buscarPorLoteProvedor('TEXTBEE', $batchId);
        if ($envio === null
            || ! hash_equals(trim((string) ($envio['provider_device_id'] ?? '')), trim((string) ($evento['deviceId'] ?? '')))
            || ! hash_equals($this->telefone((string) ($envio['telefone_e164'] ?? '')), $this->telefone((string) ($evento['recipient'] ?? '')))) {
            return false;
        }

        $novo = $this->statusService->aplicarEventoProvedor((string) ($envio['status_codigo'] ?? ''), 'TEXTBEE', $tipo);
        if ($novo === null) {
            return false;
        }
        $eventoId = $this->eventoId($evento, $tipo);
        [$codigo, $detalhe] = $this->erro($evento);

        $aplicado = $this->envios->aplicarEventoProvedor(
            (int) $envio['id'],
            'TEXTBEE',
            $eventoId,
            $smsId,
            (string) $envio['status_codigo'],
            $novo,
            $tipo,
            $codigo,
            $detalhe,
            $this->timestamp($this->timestampEvento($evento, $tipo)),
        );
        if ($aplicado && $tipo === 'MESSAGE_FAILED' && $codigo === '5') {
            $sim = isset($envio['provider_sim_subscription_id'])
                ? (int) $envio['provider_sim_subscription_id']
                : null;
            $this->cadencia->pausarPorLimite((string) $envio['provider_device_id'], $sim);
        }

        return $aplicado;
    }

    /** @param array<string, mixed> $evento */
    private function processarResposta(array $evento): bool
    {
        $telefone = $this->telefone((string) ($evento['sender'] ?? ''));
        $deviceId = trim((string) ($evento['deviceId'] ?? ''));
        $timestamp = $this->timestamp((string) ($evento['receivedAt'] ?? ''));
        if ($telefone === '' || $deviceId === '' || $timestamp === null) {
            return false;
        }

        $candidatos = $this->respostas->buscarEnviosAnterioresCompativeis($telefone, $deviceId, $timestamp);
        $identidades = [];
        foreach ($candidatos as $candidato) {
            $identidades[trim((string) ($candidato['num_zona'] ?? '')).'|'.trim((string) ($candidato['num_inscricao'] ?? ''))] = true;
        }
        $vinculo = match (count($identidades)) {
            0 => 'SEM_ENVIO',
            1 => 'VINCULADA',
            default => 'AMBIGUA',
        };
        $envioId = $vinculo === 'VINCULADA' ? (int) ($candidatos[0]['id'] ?? 0) : 0;

        return $this->respostas->registrarRecebida([
            'provider_codigo' => 'TEXTBEE',
            'provider_event_id' => $this->eventoId($evento, 'MESSAGE_RECEIVED'),
            'provider_message_id' => trim((string) ($evento['smsId'] ?? '')),
            'provider_device_id' => $deviceId,
            'envio_id' => $envioId > 0 ? $envioId : null,
            'telefone_e164' => $telefone,
            'mensagem_texto' => mb_substr((string) ($evento['message'] ?? ''), 0, 4000, 'UTF-8'),
            'vinculo_codigo' => $vinculo,
            'timestamp' => $timestamp,
        ]);
    }

    /** @param array<string, mixed> $evento */
    private function eventoId(array $evento, string $tipo): string
    {
        $id = trim((string) ($evento['idempotencyKey'] ?? ''));
        if ($id !== '') {
            return mb_substr($id, 0, 255, 'UTF-8');
        }

        return 'textbee:'.hash('sha256', implode('|', [
            $tipo,
            (string) ($evento['smsId'] ?? ''),
            (string) ($evento['smsBatchId'] ?? ''),
            $this->timestampEvento($evento, $tipo),
        ]));
    }

    /** @param array<string, mixed> $evento @return array{?string, ?string} */
    private function erro(array $evento): array
    {
        $erro = is_array($evento['error'] ?? null) ? $evento['error'] : [];
        $codigo = $this->sanitizar((string) ($evento['errorCode'] ?? $erro['code'] ?? ''), 80);
        $detalhe = $this->sanitizar((string) ($evento['errorMessage'] ?? $erro['message'] ?? $evento['status'] ?? ''), 1000);

        return [$codigo, $detalhe];
    }

    /** @param array<string, mixed> $evento */
    private function timestampEvento(array $evento, string $tipo): string
    {
        $campo = match ($tipo) {
            'MESSAGE_SENT' => 'sentAt',
            'MESSAGE_DELIVERED' => 'deliveredAt',
            'MESSAGE_FAILED' => 'failedAt',
            default => 'receivedAt',
        };

        return (string) ($evento[$campo] ?? $evento['timestamp'] ?? '');
    }

    private function timestamp(string $valor): ?int
    {
        if (trim($valor) === '') {
            return null;
        }
        try {
            return Carbon::parse($valor)->timestamp;
        } catch (Throwable) {
            return null;
        }
    }

    private function telefone(string $valor): string
    {
        return preg_replace('/\D+/', '', $valor) ?? '';
    }

    private function sanitizar(string $valor, int $limite): ?string
    {
        $limpo = trim($valor);
        if ($limpo === '') {
            return null;
        }
        $limpo = preg_replace('/(access[_ -]?token|token|secret|authorization|api[_ -]?key)\s*[:=]\s*[^\s,;]+/iu', '$1=[redigido]', $limpo) ?? '';

        return mb_substr($limpo, 0, $limite, 'UTF-8');
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_TEXTBEESMSWEBHOOKSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ZenviaSmsWebhookAutenticacao.php`
## <APP_SERVICES_CONVOCACAOSMS_ZENVIASMSWEBHOOKAUTENTICACAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ZenviaSmsWebhookAutenticacao.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ZenviaSmsWebhookAutenticacao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private string $segredo) {}
public function tokenValido(?string $recebido): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

final readonly class ZenviaSmsWebhookAutenticacao
{
    public function __construct(private string $segredo) {}

    public function tokenValido(?string $recebido): bool
    {
        return $this->segredo !== ''
            && is_string($recebido)
            && $recebido !== ''
            && hash_equals($this->segredo, $recebido);
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_ZENVIASMSWEBHOOKAUTENTICACAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ConvocacaoSms/ZenviaSmsWebhookService.php`
## <APP_SERVICES_CONVOCACAOSMS_ZENVIASMSWEBHOOKSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ConvocacaoSms/ZenviaSmsWebhookService.php`
- **Namespace Declaração:** `App\Services\ConvocacaoSms`
- **Entidade / Classe:** `final readonly class ZenviaSmsWebhookService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function processar(array $evento): array
private function causa(array $status): array
private function timestamp(string $valor): ?int
private function sanitizar(string $valor, int $limite): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use Illuminate\Support\Carbon;
use Throwable;

final readonly class ZenviaSmsWebhookService
{
    public function __construct(
        private ConvocacaoSmsEnvioRepositoryInterface $envios,
        private ConvocacaoSmsStatusService $statusService,
    ) {}

    /** @param array<string, mixed> $evento @return array{recebidos:int,aplicados:int,ignorados:int} */
    public function processar(array $evento): array
    {
        $resultado = ['recebidos' => 1, 'aplicados' => 0, 'ignorados' => 0];
        if (mb_strtoupper(trim((string) ($evento['type'] ?? '')), 'UTF-8') !== 'MESSAGE_STATUS'
            || mb_strtoupper(trim((string) ($evento['channel'] ?? '')), 'UTF-8') !== 'SMS') {
            $resultado['ignorados']++;

            return $resultado;
        }

        $eventoId = mb_substr(trim((string) ($evento['id'] ?? '')), 0, 100, 'UTF-8');
        $mensagem = is_array($evento['message'] ?? null) ? $evento['message'] : [];
        $status = is_array($evento['messageStatus'] ?? null) ? $evento['messageStatus'] : [];
        $providerMessageId = trim((string) ($mensagem['id'] ?? $evento['messageId'] ?? ''));
        $codigo = mb_strtoupper(trim((string) ($status['code'] ?? '')), 'UTF-8');
        if ($eventoId === '' || $providerMessageId === '' || $codigo === '') {
            $resultado['ignorados']++;

            return $resultado;
        }
        if (! in_array($codigo, ['SENT', 'DELIVERED', 'REJECTED', 'NOT_DELIVERED'], true)) {
            $resultado['ignorados']++;

            return $resultado;
        }

        $envio = $this->envios->buscarPorMensagemProvedor('ZENVIA', $providerMessageId);
        $novo = $this->statusService->aplicarEventoZenvia((string) ($envio['status_codigo'] ?? ''), $codigo);
        $externalId = trim((string) ($mensagem['externalId'] ?? ''));
        if ($envio === null || $novo === null
            || ($externalId !== '' && ! hash_equals((string) ($envio['external_id'] ?? ''), $externalId))) {
            $resultado['ignorados']++;

            return $resultado;
        }

        [$erroCodigo, $erroDetalhe] = $this->causa($status);
        $timestamp = $this->timestamp((string) ($status['timestamp'] ?? $evento['timestamp'] ?? ''));
        if ($this->envios->aplicarEventoProvedor(
            (int) $envio['id'],
            'ZENVIA',
            $eventoId,
            $providerMessageId,
            (string) $envio['status_codigo'],
            $novo,
            $codigo,
            $erroCodigo,
            $erroDetalhe,
            $timestamp,
        )) {
            $resultado['aplicados']++;
        } else {
            $resultado['ignorados']++;
        }

        return $resultado;
    }

    /** @param array<string, mixed> $status @return array{?string, ?string} */
    private function causa(array $status): array
    {
        $causa = is_array($status['causes'][0] ?? null) ? $status['causes'][0] : [];
        $codigo = $this->sanitizar((string) ($causa['channelErrorCode'] ?? $causa['code'] ?? ''), 80);
        $partes = array_values(array_filter([
            trim((string) ($causa['reason'] ?? '')),
            trim((string) ($causa['details'] ?? '')),
        ], static fn (string $parte): bool => $parte !== ''));
        $detalhe = $this->sanitizar(
            $partes !== [] ? implode(' — ', $partes) : (string) ($causa['description'] ?? $status['description'] ?? ''),
            1000,
        );

        return [$codigo, $detalhe];
    }

    private function timestamp(string $valor): ?int
    {
        if (trim($valor) === '') {
            return null;
        }
        try {
            return Carbon::parse($valor)->timestamp;
        } catch (Throwable) {
            return null;
        }
    }

    private function sanitizar(string $valor, int $limite): ?string
    {
        $limpo = trim($valor);
        if ($limpo === '') {
            return null;
        }
        $limpo = preg_replace('/(access[_ -]?token|token|secret|authorization)\s*[:=]\s*[^\s,;]+/iu', '$1=[redigido]', $limpo) ?? '';

        return mb_substr($limpo, 0, $limite, 'UTF-8');
    }
}
```
</APP_SERVICES_CONVOCACAOSMS_ZENVIASMSWEBHOOKSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatRotaMensagemService.php`
## <APP_SERVICES_NAT_NATROTAMENSAGEMSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatRotaMensagemService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatRotaMensagemService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function montarPainel(
public function resumo(
public function enviar(array $rotasDisponiveis, int $macroprojetoId, array $usuario, string $origem, array $rotaIdsDestino, string $mensagem, bool $novaConversa = false, ?int $ocorrenciaId = null): void
public function arquivar(array $rotasDisponiveis, int $macroprojetoId, int $rotaId, bool $arquivar): void
private function montarPainelLdaAtivo(array $conversa, array $usuario, bool $mostrarArquivadas): array
private function resolverConversaLdaAtiva(
private function normalizarRotas(array $rotas): array
private function normalizarIds(array $ids): array
private function normalizarUsuario(array $usuario): array
private function resolverConversaAtiva(array $conversas, ?int $conversaAtivaId, bool $mostrarArquivadas, bool $novaConversa): ?array
private function adicionarMetadadosMensagem(array $mensagens, array $usuario): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Repositories\Nat\NatRotaMensagemRepository;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use RuntimeException;

class NatRotaMensagemService
{
    public function __construct(
        private readonly NatRotaMensagemRepository $repository,
        private readonly LdaConversaMensagemRepository $ldaRepository,
    ) {
    }

    public function montarPainel(
        array $rotas,
        int $macroprojetoId,
        array $usuario,
        ?int $conversaAtivaId,
        bool $mostrarArquivadas = false,
        bool $novaConversa = false,
        array $zonasPermitidas = [],
        bool $acessoTodasZonas = false,
    ): array {
        $rotas = $this->normalizarRotas($rotas);
        $rotaIds = array_values(array_map(static fn (array $rota) => (int) $rota['id'], $rotas));
        $usuario = $this->normalizarUsuario($usuario);

        if ($macroprojetoId <= 0) {
            return [
                'habilitado' => false,
                'motivo' => 'Selecione um macroprojeto ativo para acessar as mensagens da rota.',
                'conversas' => [],
                'mensagens' => [],
                'rota_ativa_id' => null,
                'lda_ativa_id' => null,
                'escopo_ativo_tipo' => null,
                'conversa_ativa_id' => null,
                'permite_composer' => false,
                'permite_nova_conversa' => false,
                'mostrar_arquivadas' => false,
                'nova_conversa' => false,
                'total_nao_lidas' => 0,
                'ultima_mensagem_id' => null,
                'ultima_leitura_id' => null,
            ];
        }

        $conversaLdaAtiva = $this->resolverConversaLdaAtiva(
            $macroprojetoId,
            $conversaAtivaId,
            $zonasPermitidas,
            $acessoTodasZonas,
            $usuario['login'],
            $mostrarArquivadas,
        );

        if ($conversaLdaAtiva !== null) {
            return $this->montarPainelLdaAtivo($conversaLdaAtiva, $usuario, $mostrarArquivadas);
        }

        $conversas = $this->repository->listarConversasPorRotas($rotaIds, $macroprojetoId, $usuario['login'], $mostrarArquivadas);
        $conversaAtiva = $this->resolverConversaAtiva($conversas, $conversaAtivaId, $mostrarArquivadas, $novaConversa);

        if ($conversaAtiva !== null && !$mostrarArquivadas && !$novaConversa && $usuario['login'] !== null) {
            $this->repository->marcarConversaComoLida((int) ($conversaAtiva['conversa_id'] ?? 0), $usuario['login'], $usuario['nome']);
            $conversas = $this->repository->listarConversasPorRotas($rotaIds, $macroprojetoId, $usuario['login'], false);
            $conversaAtiva = $this->resolverConversaAtiva($conversas, $conversaAtivaId, false, false);
        }

        $mensagens = $conversaAtiva !== null && !$novaConversa
            ? $this->adicionarMetadadosMensagem(
                $this->repository->listarMensagensDaConversa((int) ($conversaAtiva['conversa_id'] ?? 0)),
                $usuario
            )
            : [];

        $rotaAtivaId = $conversaAtiva['rota_id'] ?? null;
        if ($rotaAtivaId === null && count($rotas) === 1) {
            $rotaAtivaId = (int) ($rotas[0]['id'] ?? 0) ?: null;
        }

        return [
            'habilitado' => true,
            'motivo' => null,
            'conversas' => $conversas,
            'mensagens' => $mensagens,
            'rota_ativa_id' => $rotaAtivaId,
            'lda_ativa_id' => null,
            'escopo_ativo_tipo' => 'ROTA',
            'conversa_ativa_id' => $conversaAtiva['conversa_id'] ?? null,
            'permite_composer' => !$mostrarArquivadas && ($novaConversa || $conversaAtiva !== null),
            'permite_nova_conversa' => true,
            'mostrar_arquivadas' => $mostrarArquivadas,
            'nova_conversa' => $novaConversa,
            'total_nao_lidas' => array_sum(array_map(static fn (array $conversa) => (int) ($conversa['nao_lidas'] ?? 0), $conversas)),
            'ultima_mensagem_id' => $this->maiorUltimaMensagemId($conversas),
            'ultima_leitura_id' => $this->repository->ultimaLeituraIdNoEscopo($rotaIds, $macroprojetoId),
        ];
    }

    public function resumo(
        array $rotas,
        int $macroprojetoId,
        array $usuario,
        ?int $conversaAtivaId = null,
        array $zonasPermitidas = [],
        bool $acessoTodasZonas = false,
    ): array {
        $rotaIds = array_values(array_map(static fn (array $rota) => (int) ($rota['id'] ?? 0), $this->normalizarRotas($rotas)));
        $usuario = $this->normalizarUsuario($usuario);

        if ($macroprojetoId <= 0) {
            return [
                'total_nao_lidas' => 0,
                'ultima_mensagem_id' => null,
                'ultima_leitura_id' => null,
                'conversa_ativa_id' => null,
            ];
        }

        $conversaLdaAtiva = $this->resolverConversaLdaAtiva(
            $macroprojetoId,
            $conversaAtivaId,
            $zonasPermitidas,
            $acessoTodasZonas,
            $usuario['login'],
            false,
        );

        if ($conversaLdaAtiva !== null) {
            $conversaIds = [(int) $conversaLdaAtiva['conversa_id']];

            return [
                'total_nao_lidas' => $this->repository->contarNaoLidasPorConversaIds($conversaIds, $usuario['login']),
                'ultima_mensagem_id' => $this->repository->ultimaMensagemIdPorConversaIds($conversaIds),
                'ultima_leitura_id' => $this->repository->ultimaLeituraIdPorConversaIds($conversaIds),
                'conversa_ativa_id' => (int) $conversaLdaAtiva['conversa_id'],
            ];
        }

        if ($rotaIds === []) {
            return [
                'total_nao_lidas' => 0,
                'ultima_mensagem_id' => null,
                'ultima_leitura_id' => null,
                'conversa_ativa_id' => null,
            ];
        }

        return [
            'total_nao_lidas' => $this->repository->contarNaoLidas($rotaIds, $macroprojetoId, $usuario['login']),
            'ultima_mensagem_id' => $this->repository->ultimaMensagemIdNoEscopo($rotaIds, $macroprojetoId),
            'ultima_leitura_id' => $this->repository->ultimaLeituraIdNoEscopo($rotaIds, $macroprojetoId),
            'conversa_ativa_id' => $this->repository->maxConversaAtivaIdNoEscopo($rotaIds, $macroprojetoId),
        ];
    }

    public function enviar(array $rotasDisponiveis, int $macroprojetoId, array $usuario, string $origem, array $rotaIdsDestino, string $mensagem, bool $novaConversa = false, ?int $ocorrenciaId = null): void
    {
        $rotasDisponiveis = $this->normalizarRotas($rotasDisponiveis);
        $rotaIdsPermitidos = array_values(array_map(static fn (array $rota) => (int) $rota['id'], $rotasDisponiveis));
        $rotaIdsDestino = array_values(array_intersect($this->normalizarIds($rotaIdsDestino), $rotaIdsPermitidos));
        $usuario = $this->normalizarUsuario($usuario);
        $mensagem = trim($mensagem);
        $origem = mb_strtoupper(trim($origem), 'UTF-8');

        if ($macroprojetoId <= 0) {
            throw new RuntimeException('Macroprojeto ativo nao informado para o envio da mensagem.');
        }
        if ($rotaIdsDestino === []) {
            throw new RuntimeException('Selecione ao menos uma rota para enviar a mensagem.');
        }
        if ($mensagem === '') {
            throw new RuntimeException('Informe a mensagem antes de enviar.');
        }
        if (!in_array($origem, ['NAT', 'ROTA'], true)) {
            throw new RuntimeException('Origem da mensagem invalida.');
        }
        if ($ocorrenciaId !== null) {
            if (count($rotaIdsDestino) !== 1) {
                throw new RuntimeException('Mensagens vinculadas a ocorrencia nao podem ser enviadas em broadcast.');
            }
            if (!$this->repository->ocorrenciaPertenceRota($ocorrenciaId, $rotaIdsDestino[0])) {
                throw new RuntimeException('A ocorrencia informada nao pertence a rota selecionada.');
            }
        }

        $broadcastLoteId = count($rotaIdsDestino) > 1 ? (string) Str::uuid() : null;

        DB::transaction(function () use ($macroprojetoId, $rotaIdsDestino, $origem, $mensagem, $ocorrenciaId, $broadcastLoteId, $usuario, $novaConversa) {
            if ($novaConversa) {
                foreach ($rotaIdsDestino as $rotaId) {
                    $this->repository->arquivarConversaAtiva($macroprojetoId, $rotaId);
                }
            }

            foreach ($rotaIdsDestino as $rotaId) {
                $this->repository->registrarMensagem([
                    'macroprojeto_id' => $macroprojetoId,
                    'rota_id' => $rotaId,
                    'origem' => $origem,
                    'mensagem' => $mensagem,
                    'ocorrencia_id' => $ocorrenciaId,
                    'broadcast_lote_id' => $broadcastLoteId,
                    'usuario_login' => $usuario['login'],
                    'usuario_nome' => $usuario['nome'],
                ]);
            }
        });
    }

    public function arquivar(array $rotasDisponiveis, int $macroprojetoId, int $rotaId, bool $arquivar): void
    {
        $rotaIdsPermitidos = array_values(array_map(static fn (array $rota) => (int) ($rota['id'] ?? 0), $this->normalizarRotas($rotasDisponiveis)));
        if ($macroprojetoId <= 0 || !in_array($rotaId, $rotaIdsPermitidos, true)) {
            throw new RuntimeException('A conversa informada nao pertence ao escopo autorizado.');
        }

        if ($arquivar) {
            $this->repository->arquivarConversaAtiva($macroprojetoId, $rotaId);
        }
    }

    private function montarPainelLdaAtivo(array $conversa, array $usuario, bool $mostrarArquivadas): array
    {
        if (!$mostrarArquivadas && $usuario['login'] !== null) {
            $this->repository->marcarConversaComoLida((int) ($conversa['conversa_id'] ?? 0), $usuario['login'], $usuario['nome']);
            $conversa['nao_lidas'] = 0;
        }

        $mensagens = $this->adicionarMetadadosMensagem(
            $this->repository->listarMensagensDaConversa((int) ($conversa['conversa_id'] ?? 0)),
            $usuario
        );

        return [
            'habilitado' => true,
            'motivo' => null,
            'conversas' => [$conversa],
            'mensagens' => $mensagens,
            'rota_ativa_id' => null,
            'lda_ativa_id' => $conversa['lda_id'] ?? null,
            'escopo_ativo_tipo' => 'LDA',
            'conversa_ativa_id' => $conversa['conversa_id'] ?? null,
            'permite_composer' => !$mostrarArquivadas,
            'permite_nova_conversa' => false,
            'mostrar_arquivadas' => $mostrarArquivadas,
            'nova_conversa' => false,
            'total_nao_lidas' => (int) ($conversa['nao_lidas'] ?? 0),
            'ultima_mensagem_id' => $conversa['ultima_mensagem_id'] ?? null,
            'ultima_leitura_id' => $this->repository->ultimaLeituraIdPorConversaIds([(int) ($conversa['conversa_id'] ?? 0)]),
        ];
    }

    private function resolverConversaLdaAtiva(
        int $macroprojetoId,
        ?int $conversaAtivaId,
        array $zonasPermitidas,
        bool $acessoTodasZonas,
        ?string $usuarioLogin,
        bool $mostrarArquivadas,
    ): ?array {
        if ($conversaAtivaId === null) {
            return null;
        }

        return $this->ldaRepository->buscarConversaPorIdNoEscopo(
            $conversaAtivaId,
            $macroprojetoId,
            $zonasPermitidas,
            $acessoTodasZonas,
            $usuarioLogin,
            $mostrarArquivadas,
        );
    }

    private function normalizarRotas(array $rotas): array
    {
        return collect($rotas)
            ->map(static function ($rota) {
                if (!is_array($rota)) {
                    return null;
                }

                return [
                    'id' => (int) ($rota['id'] ?? 0),
                    'numero' => (int) ($rota['numero'] ?? 0),
                    'descricao' => (string) ($rota['descricao'] ?? ''),
                ];
            })
            ->filter(static fn ($rota) => is_array($rota) && (int) ($rota['id'] ?? 0) > 0)
            ->values()
            ->all();
    }

    private function normalizarIds(array $ids): array
    {
        return collect($ids)
            ->map(static fn ($valor) => is_numeric($valor) ? (int) $valor : null)
            ->filter(static fn ($valor) => is_int($valor) && $valor > 0)
            ->unique()
            ->values()
            ->all();
    }

    private function normalizarUsuario(array $usuario): array
    {
        $login = trim((string) ($usuario['login'] ?? ''));
        $nome = trim((string) ($usuario['nome'] ?? ''));

        return [
            'login' => $login !== '' ? $login : null,
            'nome' => $nome !== '' ? $nome : null,
        ];
    }

    private function resolverConversaAtiva(array $conversas, ?int $conversaAtivaId, bool $mostrarArquivadas, bool $novaConversa): ?array
    {
        if ($novaConversa) {
            return null;
        }

        if ($conversaAtivaId !== null) {
            foreach ($conversas as $conversa) {
                if ((int) ($conversa['conversa_id'] ?? 0) === $conversaAtivaId) {
                    return $conversa;
                }
            }
        }

        $conversasComId = array_values(array_filter($conversas, static fn (array $conversa) => (int) ($conversa['conversa_id'] ?? 0) > 0));
        if (count($conversasComId) === 1) {
            return $conversasComId[0];
        }

        if ($mostrarArquivadas && count($conversas) === 1) {
            return $conversas[0];
        }

        return null;
    }

    private function adicionarMetadadosMensagem(array $mensagens, array $usuario): array
    {
        $loginNormalizado = $usuario['login'] !== null ? mb_strtoupper($usuario['login'], 'UTF-8') : null;

        return array_map(static function (array $mensagem) use ($loginNormalizado) {
            $mensagem['propria'] = $loginNormalizado !== null
                && mb_strtoupper(trim((string) ($mensagem['usuario_login'] ?? '')), 'UTF-8') === $loginNormalizado;

            return $mensagem;
        }, $mensagens);
    }

    private function maiorUltimaMensagemId(array $conversas): ?int
    {
        $ids = array_values(array_filter(
            array_map(static fn (array $conversa) => $conversa['ultima_mensagem_id'] ?? null, $conversas),
            static fn ($valor) => is_int($valor) && $valor > 0
        ));

        return $ids === [] ? null : max($ids);
    }
}
```
</APP_SERVICES_NAT_NATROTAMENSAGEMSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/ConvocacaoSms/ConvocacaoSmsStatus.php`
## <APP_SUPPORT_CONVOCACAOSMS_CONVOCACAOSMSSTATUS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/ConvocacaoSms/ConvocacaoSmsStatus.php`
- **Namespace Declaração:** `App\Support\ConvocacaoSms`
- **Entidade / Classe:** `final class ConvocacaoSmsStatus`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
private function __construct() {}
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\ConvocacaoSms;

final class ConvocacaoSmsStatus
{
    /** @var array<int, string> */
    public const JA_COMUNICADOS = ['ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'];

    /** @var array<int, string> */
    public const DESTINATARIO_FILTRAVEIS_EXATOS = [
        'PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO',
        ...self::JA_COMUNICADOS,
    ];

    private function __construct() {}
}
```
</APP_SUPPORT_CONVOCACAOSMS_CONVOCACAOSMSSTATUS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_31_161000_create_nat_rota_mensagem_table.php`
## <DATABASE_MIGRATIONS_2026_05_31_161000_CREATE_NAT_ROTA_MENSAGEM_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_31_161000_create_nat_rota_mensagem_table.php`
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
CREATE TABLE nat_rota_mensagem (
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    conversa_id       NUMBER NOT NULL,
    macroprojeto_id   NUMBER NOT NULL,
    rota_id           NUMBER NOT NULL,
    origem            VARCHAR2(10 CHAR) NOT NULL,
    mensagem          CLOB NOT NULL,
    ocorrencia_id     NUMBER,
    broadcast_lote_id VARCHAR2(36 CHAR),
    usuario_login     VARCHAR2(255 CHAR),
    usuario_nome      VARCHAR2(255 CHAR),
    dt_criacao        DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_nat_rota_msg_conversa
        FOREIGN KEY (conversa_id) REFERENCES nat_rota_conversa(id),
    CONSTRAINT fk_nat_rota_msg_macro
        FOREIGN KEY (macroprojeto_id) REFERENCES macroprojeto(id),
    CONSTRAINT fk_nat_rota_msg_rota
        FOREIGN KEY (rota_id) REFERENCES rota(id),
    CONSTRAINT fk_nat_rota_msg_ocorrencia
        FOREIGN KEY (ocorrencia_id) REFERENCES nat_ocorrencia(id_ocorrencia),
    CONSTRAINT chk_nat_rota_msg_origem
        CHECK (origem IN ('NAT', 'ROTA'))
)
SQL
        );

        DB::statement('CREATE INDEX ix_nat_rota_mensagem_01 ON nat_rota_mensagem (conversa_id)');
        DB::statement('CREATE INDEX ix_nat_rota_mensagem_02 ON nat_rota_mensagem (macroprojeto_id, rota_id)');
        DB::statement('CREATE INDEX ix_nat_rota_mensagem_03 ON nat_rota_mensagem (broadcast_lote_id)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE nat_rota_mensagem');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_31_161000_CREATE_NAT_ROTA_MENSAGEM_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_31_162000_create_nat_rota_mensagem_leitura_table.php`
## <DATABASE_MIGRATIONS_2026_05_31_162000_CREATE_NAT_ROTA_MENSAGEM_LEITURA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_31_162000_create_nat_rota_mensagem_leitura_table.php`
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
CREATE TABLE nat_rota_mensagem_leitura (
    id            NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    mensagem_id   NUMBER NOT NULL,
    rota_id       NUMBER NOT NULL,
    usuario_login VARCHAR2(255 CHAR) NOT NULL,
    usuario_nome  VARCHAR2(255 CHAR),
    dt_leitura    DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_nat_rota_msg_ler_msg
        FOREIGN KEY (mensagem_id) REFERENCES nat_rota_mensagem(id),
    CONSTRAINT fk_nat_rota_msg_ler_rota
        FOREIGN KEY (rota_id) REFERENCES rota(id)
)
SQL
        );

        DB::statement('CREATE UNIQUE INDEX uk_nat_rota_msg_ler_01 ON nat_rota_mensagem_leitura (mensagem_id, usuario_login)');
        DB::statement('CREATE INDEX ix_nat_rota_msg_ler_01 ON nat_rota_mensagem_leitura (rota_id)');
    }

    public function down(): void
    {
        DB::statement('DROP TABLE nat_rota_mensagem_leitura');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_31_162000_CREATE_NAT_ROTA_MENSAGEM_LEITURA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_19_150000_make_rota_id_nullable_on_nat_rota_mensagem.php`
## <DATABASE_MIGRATIONS_2026_06_19_150000_MAKE_ROTA_ID_NULLABLE_ON_NAT_ROTA_MENSAGEM_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_19_150000_make_rota_id_nullable_on_nat_rota_mensagem.php`
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

/**
 * Mensagens e leituras passam a referenciar a conversa (conversa_id) como chave de escopo.
 * O rota_id denormalizado deixa de ser obrigatorio: conversas de LDA nao tem rota.
 * Contrato: docs/contratos/mesario-publico-situacao.md
 */
return new class extends Migration {
    public function up(): void
    {
        DB::statement('ALTER TABLE nat_rota_mensagem MODIFY (rota_id NUMBER NULL)');
        DB::statement('ALTER TABLE nat_rota_mensagem_leitura MODIFY (rota_id NUMBER NULL)');
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE nat_rota_mensagem_leitura MODIFY (rota_id NUMBER NOT NULL)');
        DB::statement('ALTER TABLE nat_rota_mensagem MODIFY (rota_id NUMBER NOT NULL)');
    }
};
```
</DATABASE_MIGRATIONS_2026_06_19_150000_MAKE_ROTA_ID_NULLABLE_ON_NAT_ROTA_MENSAGEM_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_03_110000_grant_convocacao_whatsapp_operador_to_colaboradores_externos.php`
## <DATABASE_MIGRATIONS_2026_08_03_110000_GRANT_CONVOCACAO_WHATSAPP_OPERADOR_TO_COLABORADORES_EXTERNOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_03_110000_grant_convocacao_whatsapp_operador_to_colaboradores_externos.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$grupoId = (int) DB::table('adm_grupo_acesso')
$rotaIds = DB::table('adm_acesso_rota')
DB::table('adm_acesso_rota_grupo')
$grupoId = (int) DB::table('adm_grupo_acesso')
$rotaId = (int) DB::table('adm_acesso_rota')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function grupoAtivoId(): int
private function rotaAtivaId(string $rotaNome): int
private function upsertVinculo(int $rotaId, int $grupoId): void
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
    private const GRUPO_NOME = 'PLANELEITO_COLABORADORES_EXTERNOS';

    /** @var array<int, string> */
    private const ROTAS = [
        'colaboradores-eleitorais.convocacoes-whatsapp.index',
        'colaboradores-eleitorais.convocacoes-whatsapp.destinatarios.pdf',
        'colaboradores-eleitorais.convocacoes-whatsapp.envios.store',
        'colaboradores-eleitorais.convocacoes-whatsapp.historico.index',
        'colaboradores-eleitorais.convocacoes-whatsapp.historico.show',
        'colaboradores-eleitorais.convocacoes-whatsapp.historico.pdf',
    ];

    public function up(): void
    {
        DB::transaction(function (): void {
            $grupoId = $this->grupoAtivoId();

            foreach (self::ROTAS as $rotaNome) {
                $this->upsertVinculo($this->rotaAtivaId($rotaNome), $grupoId);
            }
        });
    }

    public function down(): void
    {
        DB::transaction(function (): void {
            $grupoId = (int) DB::table('adm_grupo_acesso')
                ->whereRaw('UPPER(nome) = ?', [self::GRUPO_NOME])
                ->value('id');
            if ($grupoId <= 0) {
                return;
            }

            $rotaIds = DB::table('adm_acesso_rota')
                ->whereIn('rota_nome', self::ROTAS)
                ->pluck('id')
                ->all();
            if ($rotaIds === []) {
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

    private function grupoAtivoId(): int
    {
        $grupoId = (int) DB::table('adm_grupo_acesso')
            ->whereRaw('UPPER(nome) = ?', [self::GRUPO_NOME])
            ->where('ativo', 1)
            ->value('id');
        if ($grupoId <= 0) {
            throw new RuntimeException('Grupo ativo não encontrado: '.self::GRUPO_NOME);
        }

        return $grupoId;
    }

    private function rotaAtivaId(string $rotaNome): int
    {
        $rotaId = (int) DB::table('adm_acesso_rota')
            ->whereRaw('UPPER(rota_nome) = ?', [mb_strtoupper($rotaNome, 'UTF-8')])
            ->where('ativo', 1)
            ->value('id');
        if ($rotaId <= 0) {
            throw new RuntimeException('Rota ativa não encontrada: '.$rotaNome);
        }

        return $rotaId;
    }

    private function upsertVinculo(int $rotaId, int $grupoId): void
    {
        $vinculoId = (int) DB::table('adm_acesso_rota_grupo')
            ->where('grupo_acesso_id', $grupoId)
            ->where('acesso_rota_id', $rotaId)
            ->value('id');

        if ($vinculoId > 0) {
            DB::table('adm_acesso_rota_grupo')
                ->where('id', $vinculoId)
                ->update([
                    'ativo' => 1,
                    'dt_atualizacao' => DB::raw('SYSDATE'),
                ]);

            return;
        }

        DB::table('adm_acesso_rota_grupo')->insert([
            'acesso_rota_id' => $rotaId,
            'grupo_acesso_id' => $grupoId,
            'ativo' => 1,
            'dt_criacao' => DB::raw('SYSDATE'),
        ]);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_03_110000_GRANT_CONVOCACAO_WHATSAPP_OPERADOR_TO_COLABORADORES_EXTERNOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_14_210000_replace_ce_wa_with_ce_sms_tables.php`
## <DATABASE_MIGRATIONS_2026_08_14_210000_REPLACE_CE_WA_WITH_CE_SMS_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_14_210000_replace_ce_wa_with_ce_sms_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$quantidade = (int) DB::table($tabela)->count();
$jobs = (int) DB::table('jobs')
$falhos = (int) DB::table('failed_jobs')
$atuais = DB::table($tabela)
DB::table($tabela)->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function validarLegadoVazio(): void
private function validarDominiosLegadosCanonicos(): void
private function criarDominios(): void
private function criarModelos(): void
private function criarEntregas(): void
private function criarTelefoneManual(): void
private function removerLegado(): void
private function removerSms(): void
private function inserirDominio(string $tabela, array $itens): void
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
    /** @var array<int, string> */
    private const TABELAS_LEGADAS_OPERACIONAIS = [
        'ce_wa_modelo_meta',
        'ce_wa_modelo',
        'ce_wa_modelo_parametro',
        'ce_wa_lote',
        'ce_wa_lote_item',
        'ce_wa_envio',
        'ce_wa_envio_evento',
        'ce_wa_telefone_manual',
    ];

    /** @var array<string, array<int, string>> */
    private const DOMINIOS_LEGADOS_CANONICOS = [
        'ce_wa_campo_variavel' => [
            'NOME', 'ZONA', 'MUNICIPIO', 'NUMERO_LOCAL', 'LOCAL_VOTACAO',
            'SECOES', 'FUNCOES', 'DATA_ELEICAO', 'TURNO', 'RESUMO_CONVOCACOES',
        ],
        'ce_wa_modelo_situacao' => [
            'ATIVO', 'INATIVO', 'REQUER_REVALIDACAO', 'INDISPONIVEL_META',
        ],
        'ce_wa_envio_status' => [
            'PENDENTE', 'PROCESSANDO', 'CANCELADO_ANTES_ENVIO', 'REJEITADO',
            'INDETERMINADO', 'ACEITO', 'ENVIADO', 'ENTREGUE', 'LIDO', 'FALHA_APOS_ACEITE',
        ],
    ];

    public function up(): void
    {
        $this->validarLegadoVazio();
        $this->criarDominios();
        $this->criarModelos();
        $this->criarEntregas();
        $this->criarTelefoneManual();
        $this->removerLegado();
    }

    public function down(): void
    {
        $this->removerSms();

        (require database_path('migrations/2026_07_29_101000_create_ce_wa_domain_tables.php'))->up();
        (require database_path('migrations/2026_07_29_102000_create_ce_wa_model_tables.php'))->up();
        (require database_path('migrations/2026_07_29_103000_create_ce_wa_delivery_tables.php'))->up();
        (require database_path('migrations/2026_08_04_120000_create_ce_wa_telefone_manual_table.php'))->up();
    }

    private function validarLegadoVazio(): void
    {
        foreach (self::TABELAS_LEGADAS_OPERACIONAIS as $tabela) {
            $quantidade = (int) DB::table($tabela)->count();
            if ($quantidade > 0) {
                throw new RuntimeException("A migration SMS exige {$tabela} vazia; encontrados {$quantidade} registro(s).");
            }
        }
        $this->validarDominiosLegadosCanonicos();

        $jobs = (int) DB::table('jobs')
            ->where(function ($query): void {
                $query->where('queue', 'convocacoes-whatsapp')
                    ->orWhereRaw("DBMS_LOB.INSTR(payload, 'ConvocacaoWhatsapp') > 0");
            })->count();
        $falhos = (int) DB::table('failed_jobs')
            ->whereRaw("DBMS_LOB.INSTR(payload, 'ConvocacaoWhatsapp') > 0")
            ->count();
        if ($jobs > 0 || $falhos > 0) {
            throw new RuntimeException("A migration SMS exige filas legadas vazias; jobs={$jobs}, failed_jobs={$falhos}.");
        }
    }

    private function validarDominiosLegadosCanonicos(): void
    {
        foreach (self::DOMINIOS_LEGADOS_CANONICOS as $tabela => $esperados) {
            $atuais = DB::table($tabela)
                ->orderBy('codigo')
                ->pluck('codigo')
                ->map(static fn (mixed $codigo): string => mb_strtoupper(trim((string) $codigo), 'UTF-8'))
                ->all();
            sort($atuais);
            sort($esperados);
            if ($atuais !== $esperados) {
                throw new RuntimeException("A migration SMS encontrou domínio legado não canônico em {$tabela}.");
            }
        }
    }

    private function criarDominios(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_campo_variavel (
    codigo          VARCHAR2(40 CHAR) PRIMARY KEY,
    descricao       VARCHAR2(160 CHAR) NOT NULL,
    ordem           NUMBER(4) NOT NULL,
    ativo           NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao  DATE,
    CONSTRAINT ck_ce_sms_campo_ativo CHECK (ativo IN (0, 1))
)
SQL);
        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_modelo_situacao (
    codigo          VARCHAR2(30 CHAR) PRIMARY KEY,
    descricao       VARCHAR2(160 CHAR) NOT NULL,
    ordem           NUMBER(4) NOT NULL,
    ativo           NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao  DATE,
    CONSTRAINT ck_ce_sms_mod_sit_ativo CHECK (ativo IN (0, 1))
)
SQL);
        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_envio_status (
    codigo          VARCHAR2(30 CHAR) PRIMARY KEY,
    descricao       VARCHAR2(160 CHAR) NOT NULL,
    ordem           NUMBER(4) NOT NULL,
    ativo           NUMBER(1) DEFAULT 1 NOT NULL,
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao  DATE,
    CONSTRAINT ck_ce_sms_env_st_ativo CHECK (ativo IN (0, 1))
)
SQL);

        $this->inserirDominio('ce_sms_campo_variavel', [
            ['NOME', 'Nome', 10],
            ['ZONA', 'Zona', 20],
            ['MUNICIPIO', 'Município', 30],
            ['NUMERO_LOCAL', 'Número do local', 40],
            ['LOCAL_VOTACAO', 'Local de votação', 50],
            ['SECOES', 'Seções', 60],
            ['FUNCOES', 'Funções', 70],
            ['DATA_ELEICAO', 'Data da eleição', 80],
            ['TURNO', 'Turno', 90],
            ['RESUMO_CONVOCACOES', 'Resumo das convocações', 100],
        ]);
        $this->inserirDominio('ce_sms_modelo_situacao', [
            ['ATIVO', 'Ativo', 10],
            ['INATIVO', 'Inativo', 20],
        ]);
        $this->inserirDominio('ce_sms_envio_status', [
            ['PENDENTE', 'Pendente', 10],
            ['PROCESSANDO', 'Processando', 20],
            ['CANCELADO_ANTES_ENVIO', 'Cancelado antes do envio', 30],
            ['REJEITADO', 'Rejeitado antes do aceite', 40],
            ['INDETERMINADO', 'Resultado indeterminado', 50],
            ['ACEITO', 'Aceito pela Zenvia', 60],
            ['ENVIADO', 'Enviado', 70],
            ['ENTREGUE', 'Entregue', 80],
            ['NAO_ENTREGUE', 'Não entregue', 90],
        ]);
    }

    private function criarModelos(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_modelo (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    macroprojeto_turno_id   NUMBER NOT NULL,
    num_zona                VARCHAR2(10 CHAR) NOT NULL,
    nome_exibicao           VARCHAR2(160 CHAR) NOT NULL,
    texto_modelo            CLOB NOT NULL,
    situacao_codigo         VARCHAR2(30 CHAR) NOT NULL,
    usuario_criacao         VARCHAR2(120 CHAR),
    usuario_atualizacao     VARCHAR2(120 CHAR),
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao          DATE,
    CONSTRAINT fk_ce_sms_mod_turno FOREIGN KEY (macroprojeto_turno_id) REFERENCES macroprojeto_turno (id),
    CONSTRAINT fk_ce_sms_mod_sit FOREIGN KEY (situacao_codigo) REFERENCES ce_sms_modelo_situacao (codigo)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_modelo_01 ON ce_sms_modelo (macroprojeto_turno_id, num_zona, nome_exibicao)');
        DB::statement('CREATE INDEX ix_ce_sms_modelo_01 ON ce_sms_modelo (macroprojeto_turno_id, num_zona, situacao_codigo)');
    }

    private function criarEntregas(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_lote (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    request_uuid            VARCHAR2(36 CHAR) NOT NULL,
    macroprojeto_turno_id   NUMBER NOT NULL,
    modelo_id               NUMBER NOT NULL,
    num_zona                VARCHAR2(10 CHAR) NOT NULL,
    usuario_login           VARCHAR2(120 CHAR) NOT NULL,
    usuario_nome            VARCHAR2(200 CHAR) NOT NULL,
    total_selecionados      NUMBER DEFAULT 0 NOT NULL,
    total_enfileirados      NUMBER DEFAULT 0 NOT NULL,
    total_ignorados         NUMBER DEFAULT 0 NOT NULL,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_sms_lote_turno FOREIGN KEY (macroprojeto_turno_id) REFERENCES macroprojeto_turno (id),
    CONSTRAINT fk_ce_sms_lote_mod FOREIGN KEY (modelo_id) REFERENCES ce_sms_modelo (id)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_lote_uuid ON ce_sms_lote (request_uuid)');
        DB::statement('CREATE INDEX ix_ce_sms_lote_01 ON ce_sms_lote (macroprojeto_turno_id, num_zona, dt_criacao)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_envio (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lote_id                 NUMBER NOT NULL,
    modelo_id               NUMBER NOT NULL,
    macroprojeto_turno_id   NUMBER NOT NULL,
    num_inscricao           VARCHAR2(20 CHAR) NOT NULL,
    cod_pleito              VARCHAR2(30 CHAR) NOT NULL,
    dt_eleicao              DATE NOT NULL,
    num_zona                VARCHAR2(10 CHAR) NOT NULL,
    municipio               VARCHAR2(160 CHAR) NOT NULL,
    nome                    VARCHAR2(300 CHAR) NOT NULL,
    telefone_e164           VARCHAR2(20 CHAR) NOT NULL,
    telefone_fonte          VARCHAR2(40 CHAR) NOT NULL,
    sender                  VARCHAR2(100 CHAR) NOT NULL,
    atribuicoes_json        CLOB NOT NULL,
    mensagem_texto          CLOB NOT NULL,
    encoding                VARCHAR2(10 CHAR) NOT NULL,
    segmentos               NUMBER(1) NOT NULL,
    external_id             VARCHAR2(36 CHAR) NOT NULL,
    payload_hash            VARCHAR2(64 CHAR) NOT NULL,
    status_codigo           VARCHAR2(30 CHAR) NOT NULL,
    provider_message_id     VARCHAR2(255 CHAR),
    tentativas              NUMBER DEFAULT 0 NOT NULL,
    erro_codigo             VARCHAR2(80 CHAR),
    erro_detalhe            VARCHAR2(1000 CHAR),
    dt_processamento        DATE,
    dt_aceite               DATE,
    dt_ultimo_evento        DATE,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao          DATE,
    CONSTRAINT fk_ce_sms_env_lote FOREIGN KEY (lote_id) REFERENCES ce_sms_lote (id),
    CONSTRAINT fk_ce_sms_env_mod FOREIGN KEY (modelo_id) REFERENCES ce_sms_modelo (id),
    CONSTRAINT fk_ce_sms_env_turno FOREIGN KEY (macroprojeto_turno_id) REFERENCES macroprojeto_turno (id),
    CONSTRAINT fk_ce_sms_env_status FOREIGN KEY (status_codigo) REFERENCES ce_sms_envio_status (codigo),
    CONSTRAINT ck_ce_sms_env_enc CHECK (encoding IN ('GSM-7', 'UCS-2')),
    CONSTRAINT ck_ce_sms_env_seg CHECK (segmentos BETWEEN 1 AND 3)
)
SQL);
        DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_ativo ON ce_sms_envio (
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN num_inscricao END
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_envio_ext ON ce_sms_envio (external_id)');
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_envio_provider ON ce_sms_envio (provider_message_id)');
        DB::statement('CREATE INDEX ix_ce_sms_envio_01 ON ce_sms_envio (macroprojeto_turno_id, num_zona, status_codigo)');
        DB::statement('CREATE INDEX ix_ce_sms_envio_02 ON ce_sms_envio (lote_id)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_lote_item (
    id              NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lote_id         NUMBER NOT NULL,
    envio_id        NUMBER,
    num_inscricao   VARCHAR2(20 CHAR) NOT NULL,
    enfileirado     NUMBER(1) DEFAULT 0 NOT NULL,
    motivo_codigo   VARCHAR2(80 CHAR),
    motivo_detalhe  VARCHAR2(500 CHAR),
    dt_criacao      DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_sms_item_lote FOREIGN KEY (lote_id) REFERENCES ce_sms_lote (id),
    CONSTRAINT fk_ce_sms_item_env FOREIGN KEY (envio_id) REFERENCES ce_sms_envio (id),
    CONSTRAINT ck_ce_sms_item_enq CHECK (enfileirado IN (0, 1))
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_lote_item_01 ON ce_sms_lote_item (lote_id, num_inscricao)');
        DB::statement('CREATE INDEX ix_ce_sms_lote_item_01 ON ce_sms_lote_item (envio_id)');

        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_envio_evento (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    envio_id                NUMBER NOT NULL,
    provider_event_id       VARCHAR2(100 CHAR) NOT NULL,
    status_anterior         VARCHAR2(30 CHAR),
    status_novo             VARCHAR2(30 CHAR) NOT NULL,
    status_provedor         VARCHAR2(40 CHAR),
    erro_codigo             VARCHAR2(80 CHAR),
    erro_detalhe            VARCHAR2(1000 CHAR),
    dt_evento_provedor      DATE,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_sms_evt_env FOREIGN KEY (envio_id) REFERENCES ce_sms_envio (id),
    CONSTRAINT fk_ce_sms_evt_ant FOREIGN KEY (status_anterior) REFERENCES ce_sms_envio_status (codigo),
    CONSTRAINT fk_ce_sms_evt_novo FOREIGN KEY (status_novo) REFERENCES ce_sms_envio_status (codigo)
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_evento_id ON ce_sms_envio_evento (provider_event_id)');
        DB::statement('CREATE INDEX ix_ce_sms_evento_01 ON ce_sms_envio_evento (envio_id, dt_criacao)');
    }

    private function criarTelefoneManual(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE ce_sms_telefone_manual (
    id                  NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    num_inscricao       VARCHAR2(20 CHAR) NOT NULL,
    telefone_nacional   VARCHAR2(11 CHAR) NOT NULL,
    usuario_login       VARCHAR2(120 CHAR) NOT NULL,
    usuario_nome        VARCHAR2(200 CHAR) NOT NULL,
    dt_criacao          DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao      DATE,
    CONSTRAINT ck_ce_sms_tel_cel CHECK (REGEXP_LIKE(telefone_nacional, '^[1-9]{2}9[6-9][0-9]{7}$'))
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_tel_ins ON ce_sms_telefone_manual (num_inscricao)');
    }

    private function removerLegado(): void
    {
        foreach (['ce_wa_envio_evento', 'ce_wa_lote_item', 'ce_wa_envio', 'ce_wa_lote', 'ce_wa_modelo_parametro', 'ce_wa_modelo', 'ce_wa_modelo_meta', 'ce_wa_telefone_manual', 'ce_wa_envio_status', 'ce_wa_modelo_situacao', 'ce_wa_campo_variavel'] as $tabela) {
            DB::statement('DROP TABLE '.$tabela);
        }
    }

    private function removerSms(): void
    {
        foreach (['ce_sms_envio_evento', 'ce_sms_lote_item', 'ce_sms_envio', 'ce_sms_lote', 'ce_sms_modelo', 'ce_sms_telefone_manual', 'ce_sms_envio_status', 'ce_sms_modelo_situacao', 'ce_sms_campo_variavel'] as $tabela) {
            DB::statement('DROP TABLE '.$tabela);
        }
    }

    /** @param array<int, array{0:string,1:string,2:int}> $itens */
    private function inserirDominio(string $tabela, array $itens): void
    {
        foreach ($itens as [$codigo, $descricao, $ordem]) {
            DB::table($tabela)->insert([
                'codigo' => $codigo,
                'descricao' => $descricao,
                'ordem' => $ordem,
                'ativo' => 1,
                'dt_criacao' => DB::raw('SYSDATE'),
            ]);
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_08_14_210000_REPLACE_CE_WA_WITH_CE_SMS_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_14_233500_expand_ce_sms_segment_constraint.php`
## <DATABASE_MIGRATIONS_2026_08_14_233500_EXPAND_CE_SMS_SEGMENT_CONSTRAINT_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_14_233500_expand_ce_sms_segment_constraint.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$invalidos = (int) DB::table('ce_sms_envio')
$incompativeis = (int) DB::table('ce_sms_envio')
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
        $invalidos = (int) DB::table('ce_sms_envio')
            ->where(static function ($query): void {
                $query->where('segmentos', '<', 1)
                    ->orWhere('segmentos', '>', 16);
            })
            ->count();
        if ($invalidos > 0) {
            throw new RuntimeException("A expansão de segmentos encontrou {$invalidos} envio(s) fora do intervalo 1..16.");
        }

        DB::statement('ALTER TABLE ce_sms_envio DROP CONSTRAINT ck_ce_sms_env_seg');
        DB::statement(<<<'SQL'
ALTER TABLE ce_sms_envio
ADD CONSTRAINT ck_ce_sms_env_seg CHECK (segmentos BETWEEN 1 AND 16)
ENABLE VALIDATE
SQL);
    }

    public function down(): void
    {
        $incompativeis = (int) DB::table('ce_sms_envio')
            ->where('segmentos', '>', 3)
            ->count();
        if ($incompativeis > 0) {
            throw new RuntimeException("O rollback para três segmentos exige zero envios acima do limite; encontrados {$incompativeis}.");
        }

        DB::statement('ALTER TABLE ce_sms_envio DROP CONSTRAINT ck_ce_sms_env_seg');
        DB::statement(<<<'SQL'
ALTER TABLE ce_sms_envio
ADD CONSTRAINT ck_ce_sms_env_seg CHECK (segmentos BETWEEN 1 AND 3)
ENABLE VALIDATE
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_14_233500_EXPAND_CE_SMS_SEGMENT_CONSTRAINT_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_15_120000_allow_sms_resend_after_communication.php`
## <DATABASE_MIGRATIONS_2026_08_15_120000_ALLOW_SMS_RESEND_AFTER_COMMUNICATION_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_15_120000_allow_sms_resend_after_communication.php`
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
        $duplicidades = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
  FROM (
        SELECT macroprojeto_turno_id, num_inscricao
          FROM ce_sms_envio
         WHERE status_codigo IN ('PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO')
         GROUP BY macroprojeto_turno_id, num_inscricao
        HAVING COUNT(*) > 1
  )
SQL);
        $total = (int) ($duplicidades->total ?? 0);
        if ($total > 0) {
            throw new RuntimeException("A nova trava de envios encontrou {$total} destinatário(s) com estados bloqueadores duplicados.");
        }

        DB::statement('DROP INDEX ux_ce_sms_envio_ativo');
        DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_ativo ON ce_sms_envio (
    CASE WHEN status_codigo IN ('PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO') THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo IN ('PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO') THEN num_inscricao END
)
SQL);
    }

    public function down(): void
    {
        $duplicidades = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
  FROM (
        SELECT macroprojeto_turno_id, num_inscricao
          FROM ce_sms_envio
         WHERE status_codigo <> 'CANCELADO_ANTES_ENVIO'
         GROUP BY macroprojeto_turno_id, num_inscricao
        HAVING COUNT(*) > 1
  )
SQL);
        $total = (int) ($duplicidades->total ?? 0);
        if ($total > 0) {
            throw new RuntimeException("O rollback da trava de envios exige zero históricos não cancelados duplicados; encontrados {$total}.");
        }

        DB::statement('DROP INDEX ux_ce_sms_envio_ativo');
        DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_ativo ON ce_sms_envio (
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN num_inscricao END
)
SQL);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_15_120000_ALLOW_SMS_RESEND_AFTER_COMMUNICATION_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_15_130000_prevent_duplicate_sms_destination.php`
## <DATABASE_MIGRATIONS_2026_08_15_130000_PREVENT_DUPLICATE_SMS_DESTINATION_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_15_130000_prevent_duplicate_sms_destination.php`
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
        $duplicidades = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
  FROM (
        SELECT macroprojeto_turno_id, num_inscricao, telefone_e164
          FROM ce_sms_envio
         WHERE status_codigo <> 'CANCELADO_ANTES_ENVIO'
         GROUP BY macroprojeto_turno_id, num_inscricao, telefone_e164
        HAVING COUNT(*) > 1
  )
SQL);
        $total = (int) ($duplicidades->total ?? 0);
        if ($total > 0) {
            throw new RuntimeException("A trava por destino encontrou {$total} telefone(s) já reutilizado(s) para a mesma inscrição e turno.");
        }

        DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_destino ON ce_sms_envio (
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN num_inscricao END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN telefone_e164 END
)
SQL);
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ux_ce_sms_envio_destino');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_15_130000_PREVENT_DUPLICATE_SMS_DESTINATION_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_16_120000_add_provider_metadata_to_ce_sms.php`
## <DATABASE_MIGRATIONS_2026_08_16_120000_ADD_PROVIDER_METADATA_TO_CE_SMS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_16_120000_add_provider_metadata_to_ce_sms.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('ce_sms_envio_status')->where('codigo', 'ACEITO')->update([
return DB::table('user_tab_columns')->where('table_name', $tabela)->where('column_name', $coluna)->exists();
return DB::table('user_tab_columns')->where('table_name', $tabela)->where('column_name', $coluna)->value('nullable') === 'N';
if (DB::table('user_indexes')->where('index_name', $indice)->exists()) {
$textBeeEnvios = (int) DB::table('ce_sms_envio')->where('provider_codigo', 'TEXTBEE')->count();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
private function colunaExiste(string $tabela, string $coluna): bool
private function colunaObrigatoria(string $tabela, string $coluna): bool
private function removerIndiceSeExistir(string $indice): void
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
        if (! $this->colunaExiste('CE_SMS_ENVIO', 'PROVIDER_CODIGO')) {
            DB::statement('ALTER TABLE ce_sms_envio ADD (provider_codigo VARCHAR2(30 CHAR), provider_batch_id VARCHAR2(255 CHAR), provider_device_id VARCHAR2(255 CHAR), provider_sim_subscription_id NUMBER)');
        }
        DB::statement("UPDATE ce_sms_envio SET provider_codigo = 'ZENVIA'");
        if (! $this->colunaObrigatoria('CE_SMS_ENVIO', 'PROVIDER_CODIGO')) {
            DB::statement('ALTER TABLE ce_sms_envio MODIFY (provider_codigo NOT NULL)');
        }

        if (! $this->colunaExiste('CE_SMS_ENVIO_EVENTO', 'PROVIDER_CODIGO')) {
            DB::statement('ALTER TABLE ce_sms_envio_evento ADD (provider_codigo VARCHAR2(30 CHAR))');
        }
        DB::statement("UPDATE ce_sms_envio_evento SET provider_codigo = CASE WHEN provider_event_id LIKE 'internal:%' THEN 'INTERNAL' ELSE 'ZENVIA' END");
        if (! $this->colunaObrigatoria('CE_SMS_ENVIO_EVENTO', 'PROVIDER_CODIGO')) {
            DB::statement('ALTER TABLE ce_sms_envio_evento MODIFY (provider_codigo NOT NULL)');
        }

        foreach (['UX_CE_SMS_ENVIO_PROVIDER', 'UX_CE_SMS_EVENTO_ID', 'UX_CE_SMS_ENVIO_PROV_MSG', 'UX_CE_SMS_ENVIO_PROV_BATCH', 'UX_CE_SMS_EVENTO_PROV_ID'] as $indice) {
            $this->removerIndiceSeExistir($indice);
        }
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_envio_prov_msg ON ce_sms_envio (CASE WHEN provider_message_id IS NOT NULL THEN provider_codigo END, provider_message_id)');
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_envio_prov_batch ON ce_sms_envio (CASE WHEN provider_batch_id IS NOT NULL THEN provider_codigo END, provider_batch_id)');
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_evento_prov_id ON ce_sms_envio_evento (provider_codigo, provider_event_id)');
        DB::table('ce_sms_envio_status')->where('codigo', 'ACEITO')->update([
            'descricao' => 'Aceito pelo provedor SMS',
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    private function colunaExiste(string $tabela, string $coluna): bool
    {
        return DB::table('user_tab_columns')->where('table_name', $tabela)->where('column_name', $coluna)->exists();
    }

    private function colunaObrigatoria(string $tabela, string $coluna): bool
    {
        return DB::table('user_tab_columns')->where('table_name', $tabela)->where('column_name', $coluna)->value('nullable') === 'N';
    }

    private function removerIndiceSeExistir(string $indice): void
    {
        if (DB::table('user_indexes')->where('index_name', $indice)->exists()) {
            DB::statement('DROP INDEX '.mb_strtolower($indice, 'UTF-8'));
        }
    }

    public function down(): void
    {
        $textBeeEnvios = (int) DB::table('ce_sms_envio')->where('provider_codigo', 'TEXTBEE')->count();
        $textBeeEventos = (int) DB::table('ce_sms_envio_evento')->where('provider_codigo', 'TEXTBEE')->count();
        $metadadosNovos = (int) DB::table('ce_sms_envio')
            ->where(function ($query): void {
                $query->whereNotNull('provider_batch_id')
                    ->orWhereNotNull('provider_device_id')
                    ->orWhereNotNull('provider_sim_subscription_id');
            })->count();
        if ($textBeeEnvios > 0 || $textBeeEventos > 0 || $metadadosNovos > 0) {
            throw new RuntimeException("ROLLBACK recusado: há dados TextBee ou metadados do provedor (envios={$textBeeEnvios}, eventos={$textBeeEventos}, metadados={$metadadosNovos}).");
        }

        DB::statement('DROP INDEX ux_ce_sms_evento_prov_id');
        DB::statement('DROP INDEX ux_ce_sms_envio_prov_batch');
        DB::statement('DROP INDEX ux_ce_sms_envio_prov_msg');
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_envio_provider ON ce_sms_envio (provider_message_id)');
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_evento_id ON ce_sms_envio_evento (provider_event_id)');
        DB::statement('ALTER TABLE ce_sms_envio_evento DROP COLUMN provider_codigo');
        DB::statement('ALTER TABLE ce_sms_envio DROP (provider_codigo, provider_batch_id, provider_device_id, provider_sim_subscription_id)');
        DB::table('ce_sms_envio_status')->where('codigo', 'ACEITO')->update([
            'descricao' => 'Aceito pela Zenvia',
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }
};
```
</DATABASE_MIGRATIONS_2026_08_16_120000_ADD_PROVIDER_METADATA_TO_CE_SMS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_16_121000_create_ce_sms_resposta.php`
## <DATABASE_MIGRATIONS_2026_08_16_121000_CREATE_CE_SMS_RESPOSTA_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_16_121000_create_ce_sms_resposta.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$quantidade = (int) DB::table('ce_sms_resposta')->count();
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
CREATE TABLE ce_sms_resposta (
    id                      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    provider_codigo         VARCHAR2(30 CHAR) NOT NULL,
    provider_event_id       VARCHAR2(255 CHAR) NOT NULL,
    provider_message_id     VARCHAR2(255 CHAR) NOT NULL,
    provider_device_id      VARCHAR2(255 CHAR) NOT NULL,
    envio_id                NUMBER,
    telefone_e164           VARCHAR2(20 CHAR) NOT NULL,
    mensagem_texto          CLOB NOT NULL,
    vinculo_codigo          VARCHAR2(20 CHAR) NOT NULL,
    dt_recebimento          DATE NOT NULL,
    dt_criacao              DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_ce_sms_resp_envio FOREIGN KEY (envio_id) REFERENCES ce_sms_envio (id),
    CONSTRAINT ck_ce_sms_resp_vinc CHECK (vinculo_codigo IN ('VINCULADA', 'AMBIGUA', 'SEM_ENVIO'))
)
SQL);
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_resp_evento ON ce_sms_resposta (provider_codigo, provider_event_id)');
        DB::statement('CREATE UNIQUE INDEX ux_ce_sms_resp_msg ON ce_sms_resposta (provider_codigo, provider_message_id)');
        DB::statement('CREATE INDEX ix_ce_sms_resp_envio ON ce_sms_resposta (envio_id, dt_recebimento)');
        DB::statement('CREATE INDEX ix_ce_sms_resp_tel_dt ON ce_sms_resposta (telefone_e164, dt_recebimento)');
    }

    public function down(): void
    {
        $quantidade = (int) DB::table('ce_sms_resposta')->count();
        if ($quantidade > 0) {
            throw new RuntimeException("ROLLBACK recusado: CE_SMS_RESPOSTA possui {$quantidade} resposta(s).");
        }

        DB::statement('DROP TABLE ce_sms_resposta CASCADE CONSTRAINTS PURGE');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_16_121000_CREATE_CE_SMS_RESPOSTA_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_18_010000_allow_null_municipio_on_ce_sms_envio.php`
## <DATABASE_MIGRATIONS_2026_08_18_010000_ALLOW_NULL_MUNICIPIO_ON_CE_SMS_ENVIO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_18_010000_allow_null_municipio_on_ce_sms_envio.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$nulos = (int) DB::table('ce_sms_envio')->whereNull('municipio')->count();
$nullable = DB::table('user_tab_columns')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function nullableMunicipio(): ?string
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
        $nullable = $this->nullableMunicipio();
        if ($nullable === null) {
            throw new RuntimeException('CE_SMS_ENVIO.MUNICIPIO não foi encontrada para alteração de nulabilidade.');
        }

        if ($nullable === 'N') {
            DB::statement('ALTER TABLE ce_sms_envio MODIFY (municipio NULL)');
        }
    }

    public function down(): void
    {
        $nulos = (int) DB::table('ce_sms_envio')->whereNull('municipio')->count();
        if ($nulos > 0) {
            throw new RuntimeException("ROLLBACK recusado: há {$nulos} envio(s) SMS sem município persistido.");
        }

        $nullable = $this->nullableMunicipio();
        if ($nullable === null) {
            throw new RuntimeException('CE_SMS_ENVIO.MUNICIPIO não foi encontrada para restaurar NOT NULL.');
        }

        if ($nullable === 'Y') {
            DB::statement('ALTER TABLE ce_sms_envio MODIFY (municipio NOT NULL)');
        }
    }

    private function nullableMunicipio(): ?string
    {
        $nullable = DB::table('user_tab_columns')
            ->where('table_name', 'CE_SMS_ENVIO')
            ->where('column_name', 'MUNICIPIO')
            ->value('nullable');

        return is_string($nullable) ? mb_strtoupper(trim($nullable), 'UTF-8') : null;
    }
};
```
</DATABASE_MIGRATIONS_2026_08_18_010000_ALLOW_NULL_MUNICIPIO_ON_CE_SMS_ENVIO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_28_120000_enforce_sms_model_once_per_recipient.php`
## <DATABASE_MIGRATIONS_2026_08_28_120000_ENFORCE_SMS_MODEL_ONCE_PER_RECIPIENT_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_28_120000_enforce_sms_model_once_per_recipient.php`
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
    private const TABELA = 'CE_SMS_ENVIO';

    private const COLUNA_UNICIDADE = 'IND_UNICIDADE_MODELO';

    private const CHECK_UNICIDADE = 'CK_CE_SMS_ENV_MODELO_UNICO';

    private const INDICE_MODELO = 'UX_CE_SMS_ENVIO_MODELO';

    private const INDICE_DESTINO = 'UX_CE_SMS_ENVIO_DESTINO';

    public function up(): void
    {
        if (! $this->colunaExiste(self::TABELA, self::COLUNA_UNICIDADE)) {
            DB::statement(<<<'SQL'
ALTER TABLE ce_sms_envio ADD (ind_unicidade_modelo NUMBER(1) DEFAULT 1 NOT NULL)
SQL);
        }

        if (! $this->indiceExiste(self::INDICE_MODELO)) {
            DB::statement(<<<'SQL'
UPDATE ce_sms_envio
   SET ind_unicidade_modelo = 1
SQL);
            DB::statement(<<<'SQL'
UPDATE ce_sms_envio envio
   SET envio.ind_unicidade_modelo = 0
 WHERE envio.id IN (
       SELECT id
         FROM (
               SELECT id,
                      ROW_NUMBER() OVER (
                          PARTITION BY macroprojeto_turno_id, num_inscricao, modelo_id
                          ORDER BY id
                      ) AS ordem_modelo
                 FROM ce_sms_envio
                WHERE status_codigo <> 'CANCELADO_ANTES_ENVIO'
         ) historico
        WHERE historico.ordem_modelo > 1
 )
SQL);
        }

        if (! $this->constraintExiste(self::TABELA, self::CHECK_UNICIDADE)) {
            DB::statement(<<<'SQL'
ALTER TABLE ce_sms_envio ADD CONSTRAINT ck_ce_sms_env_modelo_unico
CHECK (ind_unicidade_modelo IN (0, 1))
SQL);
        }

        $inconsistencias = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
  FROM (
        SELECT macroprojeto_turno_id, num_inscricao, modelo_id
          FROM ce_sms_envio
         WHERE status_codigo <> 'CANCELADO_ANTES_ENVIO'
         GROUP BY macroprojeto_turno_id, num_inscricao, modelo_id
        HAVING SUM(CASE WHEN ind_unicidade_modelo = 1 THEN 1 ELSE 0 END) <> 1
  )
SQL);
        $total = (int) ($inconsistencias->total ?? 0);
        if ($total > 0) {
            throw new RuntimeException("A trava por modelo encontrou {$total} grupo(s) sem um histórico canônico único.");
        }

        if (! $this->indiceExiste(self::INDICE_MODELO)) {
            DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_modelo ON ce_sms_envio (
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' AND ind_unicidade_modelo = 1 THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' AND ind_unicidade_modelo = 1 THEN num_inscricao END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' AND ind_unicidade_modelo = 1 THEN modelo_id END
)
SQL);
        }

        if ($this->indiceExiste(self::INDICE_DESTINO)) {
            DB::statement('DROP INDEX ux_ce_sms_envio_destino');
        }
    }

    public function down(): void
    {
        $duplicidades = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
  FROM (
        SELECT macroprojeto_turno_id, num_inscricao, telefone_e164
          FROM ce_sms_envio
         WHERE status_codigo <> 'CANCELADO_ANTES_ENVIO'
         GROUP BY macroprojeto_turno_id, num_inscricao, telefone_e164
        HAVING COUNT(*) > 1
  )
SQL);
        $total = (int) ($duplicidades->total ?? 0);
        if ($total > 0) {
            throw new RuntimeException("O rollback da trava por modelo exige zero destinos duplicados; encontrados {$total}.");
        }

        if (! $this->indiceExiste(self::INDICE_DESTINO)) {
            DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_destino ON ce_sms_envio (
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN num_inscricao END,
    CASE WHEN status_codigo <> 'CANCELADO_ANTES_ENVIO' THEN telefone_e164 END
)
SQL);
        }

        if ($this->indiceExiste(self::INDICE_MODELO)) {
            DB::statement('DROP INDEX ux_ce_sms_envio_modelo');
        }
        if ($this->constraintExiste(self::TABELA, self::CHECK_UNICIDADE)) {
            DB::statement('ALTER TABLE ce_sms_envio DROP CONSTRAINT ck_ce_sms_env_modelo_unico');
        }
        if ($this->colunaExiste(self::TABELA, self::COLUNA_UNICIDADE)) {
            DB::statement('ALTER TABLE ce_sms_envio DROP COLUMN ind_unicidade_modelo');
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
</DATABASE_MIGRATIONS_2026_08_28_120000_ENFORCE_SMS_MODEL_ONCE_PER_RECIPIENT_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_31_220000_allow_concurrent_sms_models.php`
## <DATABASE_MIGRATIONS_2026_08_31_220000_ALLOW_CONCURRENT_SMS_MODELS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_31_220000_allow_concurrent_sms_models.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$indiceModelo = DB::table('user_indexes')
return DB::table('user_indexes')->where('index_name', $indice)->exists();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
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
    private const INDICE_ATIVO = 'UX_CE_SMS_ENVIO_ATIVO';

    private const INDICE_MODELO = 'UX_CE_SMS_ENVIO_MODELO';

    public function up(): void
    {
        $indiceModelo = DB::table('user_indexes')
            ->select(['index_name', 'status'])
            ->where('index_name', self::INDICE_MODELO)
            ->first();
        if ($indiceModelo === null || mb_strtoupper(trim((string) $indiceModelo->status), 'UTF-8') !== 'VALID') {
            throw new RuntimeException('UX_CE_SMS_ENVIO_MODELO deve existir e estar válido antes de remover a trava global.');
        }

        if ($this->indiceExiste(self::INDICE_ATIVO)) {
            DB::statement('DROP INDEX ux_ce_sms_envio_ativo');
        }
    }

    public function down(): void
    {
        if ($this->indiceExiste(self::INDICE_ATIVO)) {
            return;
        }

        $duplicidades = DB::selectOne(<<<'SQL'
SELECT COUNT(*) AS total
  FROM (
        SELECT macroprojeto_turno_id, num_inscricao
          FROM ce_sms_envio
         WHERE status_codigo IN ('PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO')
         GROUP BY macroprojeto_turno_id, num_inscricao
        HAVING COUNT(*) > 1
  )
SQL);
        $total = (int) ($duplicidades->total ?? 0);
        if ($total > 0) {
            throw new RuntimeException("O rollback da trava global encontrou {$total} destinatário(s) com mais de um modelo em estado aberto.");
        }

        DB::statement(<<<'SQL'
CREATE UNIQUE INDEX ux_ce_sms_envio_ativo ON ce_sms_envio (
    CASE WHEN status_codigo IN ('PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO') THEN macroprojeto_turno_id END,
    CASE WHEN status_codigo IN ('PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO') THEN num_inscricao END
)
SQL);
    }

    private function indiceExiste(string $indice): bool
    {
        return DB::table('user_indexes')->where('index_name', $indice)->exists();
    }
};
```
</DATABASE_MIGRATIONS_2026_08_31_220000_ALLOW_CONCURRENT_SMS_MODELS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/convocacoes-sms/_navegacao.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS__NAVEGACAO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/convocacoes-sms/_navegacao.blade.php`
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
<nav aria-label="Navegação da convocação por SMS">
    <div class="d-flex flex-wrap gap-0" role="group" aria-label="Opções da convocação por SMS">
        @php
            $paginasSms = [
                ['rota' => 'colaboradores-eleitorais.convocacoes-sms.index', 'padrao' => 'colaboradores-eleitorais.convocacoes-sms.index', 'rotulo' => 'Destinatários'],
                ['rota' => 'colaboradores-eleitorais.convocacoes-sms.historico.index', 'padrao' => 'colaboradores-eleitorais.convocacoes-sms.historico.*', 'rotulo' => 'Histórico'],
            ];
            if ($contexto->gestor ?? false) {
                $paginasSms[] = ['rota' => 'colaboradores-eleitorais.convocacoes-sms.modelos.index', 'padrao' => 'colaboradores-eleitorais.convocacoes-sms.modelos.*', 'rotulo' => 'Modelos'];
            }
            $paginasSms[] = ['rota' => 'colaboradores-eleitorais.convocacoes-sms.dashboard', 'padrao' => 'colaboradores-eleitorais.convocacoes-sms.dashboard', 'rotulo' => 'Dashboard'];
        @endphp
        @foreach($paginasSms as $paginaSms)
            @php $paginaSmsAtiva = request()->routeIs($paginaSms['padrao']); @endphp
            <a
                class="btn {{ $paginaSmsAtiva ? 'btn-primary' : 'btn-outline-primary' }}"
                href="{{ route($paginaSms['rota']) }}"
                @if($paginaSmsAtiva) aria-current="page" @endif
            >{{ $paginaSms['rotulo'] }}</a>
        @endforeach
    </div>
</nav>
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS__NAVEGACAO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/convocacoes-sms/dashboard.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_DASHBOARD_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/convocacoes-sms/dashboard.blade.php`
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

@section('titulo', 'Dashboard da convocação por SMS')

@section('conteudo')
<div class="container-fluid py-3">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <div>
            <h1 class="h3 mb-1">Dashboard da convocação por SMS</h1>
            <p class="text-muted mb-0">Funil eleitoral atual e acompanhamento dos envios por SMS.</p>
        </div>
        @include('colaboradores-eleitorais.convocacoes-sms._navegacao')
    </div>

    <form method="GET" class="card card-body mb-3">
        <div class="row g-2 align-items-end">
            <div class="col-sm-4 col-lg-2">
                <label class="form-label" for="dashboard-sms-zona">Zona</label>
                <select class="form-select" id="dashboard-sms-zona" name="zona">
                    <option value="">Todas as permitidas</option>
                    @foreach($territorios['zonas'] ?? [] as $zona)
                        <option value="{{ $zona }}" @selected(($filtros['zona'] ?? '') === (string) $zona)>{{ $zona }}ª ZE</option>
                    @endforeach
                </select>
            </div>
            <div class="col-sm-4 col-lg-2">
                <label class="form-label" for="dashboard-sms-data-inicial">Data inicial</label>
                <input class="form-control" id="dashboard-sms-data-inicial" name="data_inicial" type="date" value="{{ $filtros['data_inicial'] ?? '' }}">
            </div>
            <div class="col-sm-4 col-lg-2">
                <label class="form-label" for="dashboard-sms-data-final">Data final</label>
                <input class="form-control" id="dashboard-sms-data-final" name="data_final" type="date" value="{{ $filtros['data_final'] ?? '' }}">
            </div>
            <div class="col-lg-4 d-flex flex-wrap gap-2">
                <button class="btn btn-primary" type="submit"><i class="fa-solid fa-filter"></i> Filtrar</button>
                <a class="btn btn-outline-secondary" href="{{ route('colaboradores-eleitorais.convocacoes-sms.dashboard') }}">Limpar</a>
            </div>
        </div>
        <p class="form-text mb-0 mt-2">O período filtra somente os indicadores operacionais de envio. O funil eleitoral e os cartões de já comunicados representam a fotografia atual do CONVOCA + no turno ativo.</p>
    </form>

    <div class="row g-3 mb-3">
        @foreach([
            ['Pessoas nomeadas', $pessoas_nomeadas, 'fa-users', 'primary'],
            ['Confirmações no CONVOCA +', $confirmacoes_convoca_mais, 'fa-circle-check', 'success'],
            ['Ainda não confirmados no CONVOCA +', $nao_confirmados_convoca_mais, 'fa-clock', 'warning'],
            ['Enviados', $enviados, 'fa-paper-plane', 'primary'],
            ['Entregues', $entregues, 'fa-check-double', 'success'],
            ['Não entregues', $nao_entregues, 'fa-triangle-exclamation', 'danger'],
            ['Confirmados no CONVOCA + após comunicação por SMS', $confirmados_ja_comunicados, 'fa-link', 'info'],
        ] as [$rotulo, $valor, $icone, $cor])
            <div class="col-sm-6 col-xl-3">
                <div class="card h-100 border-{{ $cor }}">
                    <div class="card-body">
                        <div class="d-flex justify-content-between gap-2"><span class="text-muted">{{ $rotulo }}</span><i class="fa-solid {{ $icone }} text-{{ $cor }}" aria-hidden="true"></i></div>
                        <strong class="display-6">{{ number_format($valor, 0, ',', '.') }}</strong>
                    </div>
                </div>
            </div>
        @endforeach
        <div class="col-sm-6 col-xl-3">
            <section class="card h-100 border-info" aria-labelledby="dashboard-confirmados-sms-origem">
                <div class="card-body">
                    <div class="d-flex justify-content-between gap-2 mb-2">
                        <span class="text-muted" id="dashboard-confirmados-sms-origem">Confirmação no convoca + que receberam SMS por tipo</span>
                        <i class="fa-solid fa-chart-pie text-info" aria-hidden="true"></i>
                    </div>
                    <div class="row g-2">
                        <div class="col-6 border-end">
                            <small class="text-muted d-block">Título Net</small>
                            <strong class="h3 mb-0">{{ number_format($confirmados_ja_comunicados_titulo_net, 0, ',', '.') }}</strong>
                        </div>
                        <div class="col-6">
                            <small class="text-muted d-block">Presencial</small>
                            <strong class="h3 mb-0">{{ number_format($confirmados_ja_comunicados_presencial, 0, ',', '.') }}</strong>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-4">
            <section class="card h-100">
                <div class="card-header fw-semibold">Distribuição dos envios por situação</div>
                <div class="card-body"><canvas id="grafico-situacoes" aria-label="Distribuição dos envios por situação"></canvas><p class="text-muted text-center d-none" id="grafico-situacoes-vazio">Nenhum envio no período.</p></div>
            </section>
        </div>
        <div class="col-lg-8">
            <section class="card h-100">
                <div class="card-header fw-semibold">Evolução diária</div>
                <div class="card-body"><canvas id="grafico-evolucao" aria-label="Evolução diária dos envios e entregas"></canvas><p class="text-muted text-center d-none" id="grafico-evolucao-vazio">Nenhum envio no período.</p></div>
            </section>
        </div>
        <div class="col-12">
            <section class="card">
                <div class="card-header fw-semibold">Envios e resultados por zona</div>
                <div class="card-body"><canvas id="grafico-zonas" aria-label="Envios e resultados por zona"></canvas><p class="text-muted text-center d-none" id="grafico-zonas-vazio">Nenhum envio no período.</p></div>
            </section>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="{{ asset('vendor/chartjs/chart.umd.min.js') }}"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
    const situacoes = @json($por_situacao);
    const evolucao = @json($evolucao_diaria);
    const zonas = @json($por_zona);
    const cores = ['#6c757d', '#0dcaf0', '#198754', '#dc3545', '#fd7e14', '#adb5bd'];
    const renderizar = (canvasId, vazioId, configuracao, possuiDados) => {
        const canvas = document.getElementById(canvasId);
        const vazio = document.getElementById(vazioId);
        if (!possuiDados) { canvas.classList.add('d-none'); vazio.classList.remove('d-none'); return; }
        new Chart(canvas, configuracao);
    };

    renderizar('grafico-situacoes', 'grafico-situacoes-vazio', {
        type: 'doughnut',
        data: { labels: situacoes.map(item => item.rotulo), datasets: [{ data: situacoes.map(item => item.total), backgroundColor: cores }] },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom' } } },
    }, situacoes.some(item => item.total > 0));
    renderizar('grafico-evolucao', 'grafico-evolucao-vazio', {
        type: 'line',
        data: { labels: evolucao.map(item => item.data.split('-').reverse().join('/')), datasets: [
            { label: 'Enviados', data: evolucao.map(item => item.enviados), borderColor: '#0d6efd', backgroundColor: '#0d6efd' },
            { label: 'Entregues', data: evolucao.map(item => item.entregues), borderColor: '#198754', backgroundColor: '#198754' },
            { label: 'Não entregues', data: evolucao.map(item => item.nao_entregues), borderColor: '#dc3545', backgroundColor: '#dc3545' },
        ] },
        options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true, ticks: { precision: 0 } } } },
    }, evolucao.some(item => item.enviados > 0 || item.entregues > 0 || item.nao_entregues > 0));
    renderizar('grafico-zonas', 'grafico-zonas-vazio', {
        type: 'bar',
        data: { labels: zonas.map(item => `${item.zona}ª ZE`), datasets: [
            { label: 'Entregues', data: zonas.map(item => item.entregues), backgroundColor: '#198754' },
            { label: 'Não entregues', data: zonas.map(item => item.nao_entregues), backgroundColor: '#dc3545' },
        ] },
        options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true, ticks: { precision: 0 } } } },
    }, zonas.some(item => item.entregues > 0 || item.nao_entregues > 0));

});
</script>
@endpush
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_DASHBOARD_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/convocacoes-sms/detalhe.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_DETALHE_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/convocacoes-sms/detalhe.blade.php`
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
@section('titulo', 'Detalhe da convocação por SMS')
@section('conteudo')
@php
    $atribuicoes = json_decode((string)($item['atribuicoes_json'] ?? '[]'), true) ?: [];
    $telefone = (string)($item['telefone_e164'] ?? '');
    $telefoneMascarado = strlen($telefone) > 6 ? substr($telefone, 0, 4).'*****'.substr($telefone, -2) : '—';
@endphp
<div class="container py-3">
    <div class="d-flex justify-content-between align-items-center gap-2 mb-3"><h1 class="h3 mb-0">Detalhe da convocação</h1><a class="btn btn-outline-secondary" href="{{ route('colaboradores-eleitorais.convocacoes-sms.historico.index') }}">Voltar</a></div>
    @if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif @if($errors->any())<div class="alert alert-danger">{{ $errors->first() }}</div>@endif
    <div class="row g-3"><div class="col-lg-7"><div class="card h-100"><div class="card-header fw-semibold">Envio</div><div class="card-body"><dl class="row mb-0"><dt class="col-sm-4">Pessoa</dt><dd class="col-sm-8">{{ $item['nome'] }} · {{ $item['num_inscricao'] }}</dd><dt class="col-sm-4">Zona / município</dt><dd class="col-sm-8">{{ $item['num_zona'] }}ª ZE · {{ $item['municipio'] }}</dd><dt class="col-sm-4">Telefone utilizado</dt><dd class="col-sm-8">{{ $telefoneMascarado }} ({{ str_replace('_', ' ', $item['telefone_fonte']) }})</dd><dt class="col-sm-4">Modelo</dt><dd class="col-sm-8">{{ $item['modelo_nome'] }}</dd><dt class="col-sm-4">Mensagem</dt><dd class="col-sm-8 text-break">{{ $item['mensagem_texto'] }}</dd><dt class="col-sm-4">Codificação</dt><dd class="col-sm-8">{{ $item['encoding'] }} · {{ $item['segmentos'] }} segmento(s)</dd><dt class="col-sm-4">Situação</dt><dd class="col-sm-8">{{ str_replace('_', ' ', $item['status_codigo']) }}</dd><dt class="col-sm-4">Provedor</dt><dd class="col-sm-8">{{ $item['provider_codigo'] ?: '—' }}</dd><dt class="col-sm-4">ID do lote</dt><dd class="col-sm-8 text-break">{{ $item['provider_batch_id'] ?: '—' }}</dd><dt class="col-sm-4">ID da mensagem</dt><dd class="col-sm-8 text-break">{{ $item['provider_message_id'] ?: '—' }}</dd><dt class="col-sm-4">Erro sanitizado</dt><dd class="col-sm-8">{{ $item['erro_codigo'] ?: '—' }} @if($item['erro_detalhe'])— {{ $item['erro_detalhe'] }}@endif</dd></dl></div></div></div><div class="col-lg-5"><div class="card h-100"><div class="card-header fw-semibold">Convocações consolidadas</div><ul class="list-group list-group-flush">@forelse($atribuicoes as $atribuicao)<li class="list-group-item"><strong>{{ $atribuicao['funcao'] ?? 'Função não informada' }}</strong><br>Local {{ $atribuicao['numero_local'] ?? '—' }} · {{ $atribuicao['local_votacao'] ?? '—' }}<br>Seção {{ $atribuicao['secao'] ?? '—' }}</li>@empty<li class="list-group-item text-muted">Snapshot indisponível.</li>@endforelse</ul></div></div></div>
    <h2 class="h5 mt-4">Respostas recebidas</h2><div class="table-responsive border rounded"><table class="table table-sm mb-0"><thead><tr><th>Recebida em</th><th>Telefone</th><th>Mensagem</th></tr></thead><tbody>@forelse($item['respostas'] as $resposta)<tr><td>{{ $resposta['dt_recebimento_fmt'] }}</td><td>{{ $resposta['telefone_e164'] }}</td><td class="text-break">{{ $resposta['mensagem_texto'] }}</td></tr>@empty<tr><td colspan="3" class="text-center text-muted">Nenhuma resposta vinculada.</td></tr>@endforelse</tbody></table></div>
    <h2 class="h5 mt-4">Transições</h2><div class="table-responsive border rounded"><table class="table table-sm mb-0"><thead><tr><th>Registrada em</th><th>Provedor em</th><th>Anterior</th><th>Nova</th><th>Provedor / origem</th><th>Erro</th></tr></thead><tbody>@foreach($item['eventos'] as $evento)<tr><td>{{ $evento['dt_criacao_fmt'] }}</td><td>{{ $evento['dt_evento_provedor_fmt'] ?: '—' }}</td><td>{{ $evento['status_anterior'] ?: '—' }}</td><td>{{ $evento['status_novo'] }}</td><td>{{ $evento['provider_codigo'] }} · {{ $evento['status_provedor'] ?: '—' }}</td><td>{{ $evento['erro_codigo'] ?: '—' }} @if($evento['erro_detalhe'])— {{ $evento['erro_detalhe'] }}@endif</td></tr>@endforeach</tbody></table></div>
    @if($contexto->administrador && ($item['status_codigo'] ?? '') === 'REJEITADO')<form class="mt-3" method="POST" action="{{ route('colaboradores-eleitorais.convocacoes-sms.envios.reenviar', $item['id']) }}" onsubmit="return confirm('Confirmar reenvio administrativo?');">@csrf<button class="btn btn-warning" type="submit"><i class="fa-solid fa-rotate-right me-1"></i> Reenviar rejeição explícita</button></form>@endif
</div>
@endsection
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_DETALHE_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/convocacoes-sms/historico.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_HISTORICO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/convocacoes-sms/historico.blade.php`
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
@section('titulo', 'Histórico de convocações por SMS')
@section('conteudo')
<div class="container-fluid py-3">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3"><div><h1 class="h3 mb-1">Histórico de convocações</h1><p class="text-muted mb-0">{{ $contexto->gestor ? 'Histórico das zonas permitidas.' : 'Somente lotes criados por você.' }}</p></div>@include('colaboradores-eleitorais.convocacoes-sms._navegacao')</div>
    @if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif @if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
    <form method="GET" class="card card-body mb-3"><div class="row g-2"><div class="col-lg-4"><label class="form-label" for="hist-q">Nome, inscrição ou município</label><input id="hist-q" class="form-control" name="q" value="{{ $filtros['q'] ?? '' }}"></div><div class="col-sm-4 col-lg-2"><label class="form-label" for="hist-zona">Zona</label><input id="hist-zona" class="form-control" name="zona" inputmode="numeric" value="{{ $filtros['zona'] ?? '' }}"></div><div class="col-sm-8 col-lg-3"><label class="form-label" for="hist-status">Situação</label><select id="hist-status" class="form-select" name="situacao"><option value="">Todas</option>@foreach(['PENDENTE','PROCESSANDO','ACEITO','ENVIADO','ENTREGUE','NAO_ENTREGUE','REJEITADO','INDETERMINADO','CANCELADO_ANTES_ENVIO'] as $status)<option value="{{ $status }}" @selected(($filtros['situacao'] ?? '') === $status)>{{ str_replace('_', ' ', $status) }}</option>@endforeach</select></div><div class="col-lg-3 d-flex align-items-end gap-2"><button class="btn btn-primary">Filtrar</button><a class="btn btn-outline-secondary" href="{{ route('colaboradores-eleitorais.convocacoes-sms.historico.index') }}">Limpar</a><button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#modal-hist-pdf"><i class="fa-solid fa-file-pdf"></i> PDF</button></div></div></form>
    <div class="table-responsive border rounded"><table class="table table-striped align-middle mb-0"><thead class="table-light"><tr><th>Convocado</th><th>Zona / município</th><th>Modelo</th><th>Situação</th><th>Respostas</th><th>Operador</th><th>Datas</th><th>Ações</th></tr></thead><tbody>@forelse($envios as $item)<tr><td><strong>{{ $item->nome }}</strong><br><span class="text-muted">{{ $item->num_inscricao }}</span></td><td>{{ $item->num_zona }}ª ZE<br>{{ $item->municipio }}</td><td>{{ $item->modelo_nome }}<br><small class="text-muted">{{ $item->encoding }} · {{ $item->segmentos }} segmento(s)</small></td><td><span class="badge {{ in_array($item->status_codigo, ['ACEITO','ENVIADO','ENTREGUE'], true) ? 'text-bg-success' : (in_array($item->status_codigo, ['REJEITADO','NAO_ENTREGUE'], true) ? 'text-bg-danger' : 'text-bg-secondary') }}">{{ str_replace('_', ' ', $item->status_codigo) }}</span>@if($item->erro_codigo)<br><small class="text-danger">{{ $item->erro_codigo }}</small>@endif</td><td>{{ (int)$item->respostas_quantidade }}@if($item->ultima_resposta_fmt)<br><small class="text-muted">Última: {{ $item->ultima_resposta_fmt }}</small>@endif</td><td>{{ $item->usuario_nome }}</td><td>Criado: {{ $item->dt_criacao_fmt }}@if($item->dt_aceite_fmt)<br>Aceite: {{ $item->dt_aceite_fmt }}@endif</td><td class="text-nowrap"><a class="btn btn-sm btn-outline-primary" href="{{ route('colaboradores-eleitorais.convocacoes-sms.historico.show', $item->id) }}" aria-label="Ver detalhe"><i class="fa-solid fa-eye"></i></a>@if($contexto->administrador && $item->status_codigo === 'REJEITADO')<form class="d-inline" method="POST" action="{{ route('colaboradores-eleitorais.convocacoes-sms.envios.reenviar', $item->id) }}" onsubmit="return confirm('Reenviar esta rejeição explícita?');">@csrf<button class="btn btn-sm btn-outline-warning" type="submit" aria-label="Reenviar rejeição"><i class="fa-solid fa-rotate-right"></i></button></form>@endif</td></tr>@empty<tr><td colspan="8" class="text-center text-muted py-4">Nenhum envio encontrado.</td></tr>@endforelse</tbody></table></div>
    <div class="d-flex flex-wrap justify-content-between align-items-center mt-3"><span class="text-muted">{{ $envios->total() }} registro(s).</span>@if($envios->hasPages()){{ $envios->links('pagination::bootstrap-5') }}@endif</div>
</div>
<div class="modal fade" id="modal-hist-pdf" tabindex="-1" aria-labelledby="modal-hist-pdf-label" aria-hidden="true"><div class="modal-dialog"><form class="modal-content" method="GET" action="{{ route('colaboradores-eleitorais.convocacoes-sms.historico.pdf') }}" target="_blank"><div class="modal-header"><h2 class="modal-title h5" id="modal-hist-pdf-label">Campos do PDF do histórico</h2><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button></div><div class="modal-body">@foreach(['q','zona','situacao'] as $filtro)<input type="hidden" name="{{ $filtro }}" value="{{ $filtros[$filtro] ?? '' }}">@endforeach @foreach($camposPdf as $campo => $rotulo)<div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="hist-pdf-{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="hist-pdf-{{ $campo }}">{{ $rotulo }}</label></div>@endforeach</div><div class="modal-footer"><button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit">Gerar PDF</button></div></form></div></div>
@endsection
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_HISTORICO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php`
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

@section('titulo', 'Convocação por SMS')

@section('conteudo')
@php
    $statusRotulos = [
        'A_COMUNICAR' => 'A comunicar', 'SEM_CELULAR_VALIDO' => 'Sem celular válido',
        'PENDENTE' => 'Pendente', 'PROCESSANDO' => 'Processando', 'JA_COMUNICADO' => 'Já comunicado',
        'REJEITADO' => 'Rejeitado', 'INDETERMINADO' => 'Indeterminado',
        'NAO_ENTREGUE' => 'Não entregue', 'ENTREGUE' => 'Entregue', 'ENVIADO' => 'Enviado',
    ];
    $zonaSelecionada = (string)($filtros['zona'] ?? '');
    $turmaSelecionada = (string)($filtros['turma_id'] ?? '');
    $turmaSelecionadaDisponivel = collect($turmasTreinamento)->contains(fn($turma) => (string)$turma['id'] === $turmaSelecionada);
    $municipiosZona = collect($territorios['municipios'] ?? [])->when($zonaSelecionada !== '', fn($c) => $c->where('zona', $zonaSelecionada))->pluck('municipio')->unique()->sort()->values();
@endphp
<div class="container-fluid py-3">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <div><h1 class="h3 mb-1">Convocação por SMS</h1><p class="text-muted mb-0">Somente registros efetivos com situação <strong>NOMEADO</strong> no pleito {{ $contexto->codPleito }}.</p></div>
        @include('colaboradores-eleitorais.convocacoes-sms._navegacao')
    </div>

    @if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif
    @if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
    @unless($integracao['disponivel'])
        <div class="alert alert-warning"><strong>Envio desabilitado.</strong> {{ implode(' ', $integracao['motivos']) }} A listagem e o histórico permanecem disponíveis.</div>
    @endunless

    <form method="GET" class="card card-body mb-3">
        <div class="row g-2">
            <div class="col-lg-2"><label for="sms-q" class="form-label">Nome ou inscrição</label><input id="sms-q" class="form-control" name="q" value="{{ $filtros['q'] ?? '' }}" maxlength="160"></div>
            <div class="col-sm-4 col-lg-1"><label for="sms-zona" class="form-label">Zona</label><select id="sms-zona" class="form-select" name="zona"><option value="">Selecione</option>@foreach($territorios['zonas'] ?? [] as $zona)<option value="{{ $zona }}" @selected($zonaSelecionada === (string)$zona)>{{ $zona }}ª ZE</option>@endforeach</select></div>
            <div class="col-sm-8 col-lg-2"><label for="sms-municipio" class="form-label">Município</label><select id="sms-municipio" class="form-select" name="municipio"><option value="">Todos</option>@foreach($municipiosZona as $municipio)<option value="{{ $municipio }}" @selected(($filtros['municipio'] ?? '') === $municipio)>{{ $municipio }}</option>@endforeach</select></div>
            <div class="col-lg-2"><label for="sms-funcao" class="form-label">Função eleitoral</label><select id="sms-funcao" class="form-select" name="funcao"><option value="">Todas</option>@foreach($funcoes as $funcao)<option value="{{ $funcao }}" @selected(($filtros['funcao'] ?? '') === $funcao)>{{ $funcao }}</option>@endforeach</select></div>
            <div class="col-lg-3">
                <label for="sms-turma" class="form-label">Turma de treinamento</label>
                <select id="sms-turma" class="form-select" name="turma_id">
                    <option value="">Todas as turmas</option>
                    @if($turmaSelecionada !== '' && !$turmaSelecionadaDisponivel)<option value="{{ $turmaSelecionada }}" selected>Turma indisponível no escopo atual</option>@endif
                    @foreach($turmasTreinamento as $turma)
                        @php
                            $inicioTurma = !empty($turma['dat_hora_inicio_treinamento']) ? \Illuminate\Support\Carbon::parse($turma['dat_hora_inicio_treinamento'])->format('d/m/Y H:i') : 'Data não informada';
                            $zonaTurma = str_pad((string)$turma['num_zona'], 3, '0', STR_PAD_LEFT);
                        @endphp
                        <option value="{{ $turma['id'] }}" @selected($turmaSelecionada === (string)$turma['id'])>{{ $turma['nom_turma'] }} (nº {{ $turma['num_turma'] }}) · Zona {{ $zonaTurma }} · {{ $inicioTurma }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-lg-2"><label for="sms-situacao" class="form-label">Comunicação</label><select id="sms-situacao" class="form-select" name="situacao"><option value="">Todas</option>@foreach($statusRotulos as $codigo => $rotulo)<option value="{{ $codigo }}" @selected(($filtros['situacao'] ?? '') === $codigo)>{{ $rotulo }}</option>@endforeach</select></div>
            <div class="col-lg-2"><label for="sms-confirmacao-elo" class="form-label">Confirmação no ELO</label><select id="sms-confirmacao-elo" class="form-select" name="confirmacao_elo"><option value="">Todos</option><option value="CONFIRMADO" @selected(($filtros['confirmacao_elo'] ?? '') === 'CONFIRMADO')>Confirmados</option><option value="NAO_CONFIRMADO" @selected(($filtros['confirmacao_elo'] ?? '') === 'NAO_CONFIRMADO')>Não confirmados</option></select></div>
            <div class="col-lg-1 d-flex align-items-end gap-2"><button class="btn btn-primary" type="submit">Filtrar</button><a class="btn btn-outline-secondary" href="{{ route('colaboradores-eleitorais.convocacoes-sms.index') }}">Limpar</a></div>
        </div>
    </form>

    @if($zonaSelecionada === '')<div class="alert alert-info">Selecione uma zona para habilitar a seleção e o envio. A listagem sem zona é apenas consultiva.</div>@endif

    <form method="POST" action="{{ route('colaboradores-eleitorais.convocacoes-sms.envios.store') }}" id="form-envio-sms">
        @csrf
        <input type="hidden" name="request_uuid" value="{{ old('request_uuid', (string) Illuminate\Support\Str::uuid()) }}">
        <input type="hidden" name="zona" value="{{ $zonaSelecionada }}">
        <div class="d-flex flex-wrap align-items-end gap-2 mb-2">
            <div class="flex-grow-1" style="min-width: 16rem"><label for="sms-modelo" class="form-label">Modelo de SMS configurado para a zona</label><select id="sms-modelo" class="form-select" name="modelo_id" @disabled($zonaSelecionada === '' || !$integracao['disponivel'])><option value="">Selecione</option>@foreach($modelos as $modelo)<option value="{{ $modelo['id'] }}" @selected((string)old('modelo_id') === (string)$modelo['id'])>{{ $modelo['nome_exibicao'] }}</option>@endforeach</select><div class="form-text">Para nomeações sem local, use modelo sem Município, Número do local, Local de votação ou Seções.</div></div>
            <button type="submit" id="btn-enviar-sms" class="btn btn-success" disabled><i class="fa-solid fa-comment me-1"></i> Enviar convocação <span id="total-sms" class="badge text-bg-light">0</span></button>
            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal-sms-pdf"><i class="fa-solid fa-file-pdf me-1"></i> Exportar para PDF</button>
        </div>

        <div class="table-responsive border rounded">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light"><tr><th class="text-center"><input id="selecionar-pagina-sms" class="form-check-input" type="checkbox" aria-label="Selecionar elegíveis desta página" disabled></th><th>Nomeado</th><th>Nomeações consolidadas</th><th>Celular</th><th>Confirmação no ELO</th><th>Comunicação</th></tr></thead>
                <tbody>
                @forelse($destinatarios as $item)
                    @php
                        $selecionavelBase = $zonaSelecionada !== '' && ($item['selecionavel'] ?? false) && $integracao['disponivel'];
                        $situacao = $item['situacao_comunicacao'] ?? '';
                        $podeEditarTelefone = $contexto->podeAlterarTelefone && (
                            in_array($situacao, ['A_COMUNICAR', 'SEM_CELULAR_VALIDO'], true)
                            || ($contexto->gestor && $situacao === 'JA_COMUNICADO')
                        );
                    @endphp
                    <tr>
                        <td class="text-center"><input class="form-check-input selecao-sms" type="checkbox" name="num_inscricoes[]" value="{{ $item['num_inscricao'] }}" data-selecionavel-base="{{ $selecionavelBase ? '1' : '0' }}" data-modelos-usados='@json(array_values($item['modelos_ja_utilizados'] ?? []))' disabled aria-label="Selecionar {{ $item['nome'] }}"></td>
                        <td><strong>{{ $item['nome'] }}</strong><br><span class="text-muted">Inscrição {{ $item['num_inscricao'] }} · {{ $item['zona'] }}ª ZE · {{ $item['municipio'] ?: 'Município não informado' }}</span></td>
                        <td><ul class="list-unstyled mb-0">@foreach($item['atribuicoes'] as $atribuicao)<li class="mb-1"><span class="fw-semibold">{{ $atribuicao['funcao'] ?: 'Função não informada' }}</span>@unless($atribuicao['nomeacao_sem_local'] ?? false) · Local {{ $atribuicao['numero_local'] ?: '—' }} · Seção {{ $atribuicao['secao'] ?: '—' }}@endunless<br>@if($atribuicao['nomeacao_sem_local'] ?? false)<small class="text-warning">Sem local ou seção informado no CONVOCA +</small><br>@endif<small class="text-muted">{{ ($atribuicao['data_convocacao_elo'] ?? null) ? 'Convocado em '.$atribuicao['data_convocacao_elo'] : 'Convocação sem data informada' }}</small></li>@endforeach</ul></td>
                        <td>
                            <div class="d-flex align-items-start gap-2">
                                <div>
                                    {{ $item['telefone_nacional'] ?: '—' }}
                                    @if($item['telefone_manual_ativo'] ?? false)
                                        <br><span class="badge text-bg-warning">Alterado manualmente</span>
                                    @elseif($item['telefone_fonte'])
                                        <br><small class="text-muted">{{ str_replace('_', ' ', $item['telefone_fonte']) }}</small>
                                    @endif
                                    @if($item['telefone_normalizacao'] ?? null)
                                        <br><small class="text-primary">{{ $item['telefone_normalizacao'] }}</small>
                                    @elseif(!($item['telefone_nacional'] ?? null) && ($item['telefone_diagnostico'] ?? null))
                                        <br><small class="text-danger">{{ $item['telefone_diagnostico'] }}</small>
                                    @endif
                                </div>
                                @if($podeEditarTelefone)
                                    <button class="btn btn-sm btn-outline-primary js-editar-telefone-sms" type="button"
                                        data-bs-toggle="modal" data-bs-target="#modal-sms-telefone"
                                        data-action="{{ route('colaboradores-eleitorais.convocacoes-sms.destinatarios.telefone.update', $item['num_inscricao']) }}"
                                        data-nome="{{ $item['nome'] }}" data-inscricao="{{ $item['num_inscricao'] }}"
                                        data-zona="{{ $item['zona'] }}" data-telefone="{{ $item['telefone_nacional'] ?? '' }}"
                                        data-telefone-carga="{{ $item['telefone_carga_nacional'] ?? '' }}"
                                        data-manual="{{ ($item['telefone_manual_ativo'] ?? false) ? '1' : '0' }}"
                                        aria-label="Alterar celular de {{ $item['nome'] }}"><i class="fa-solid fa-pen"></i></button>
                                @endif
                            </div>
                        </td>
                        <td>
                            @php $confirmacaoElo = $item['confirmacao_elo_codigo'] ?? 'AGUARDANDO'; @endphp
                            <span class="badge {{ $confirmacaoElo === 'CONFIRMADO' ? 'text-bg-success' : ($confirmacaoElo === 'NAO_CONFIRMOU' ? 'text-bg-danger' : 'text-bg-secondary') }}">{{ $item['confirmacao_elo'] ?? 'Aguardando resposta' }}</span>
                            @if($item['origem_resposta_elo'] ?? null)<br><small class="text-muted">{{ $item['origem_resposta_elo'] }}</small>@endif
                            @if($item['data_resposta_elo'] ?? null)<br><small class="text-muted">Respondido em {{ $item['data_resposta_elo'] }}</small>@endif
                        </td>
                        <td>
                            <span class="badge {{ $situacao === 'A_COMUNICAR' ? 'text-bg-success' : ($situacao === 'REJEITADO' ? 'text-bg-danger' : 'text-bg-secondary') }}">{{ $statusRotulos[$situacao] ?? str_replace('_', ' ', $situacao) }}</span>
                            @if($item['entrega_inferida_convoca_mais'] ?? false)
                                <br><small class="text-success">Entrega considerada pelo CONVOCA +</small>
                            @endif
                            @if($selecionavelBase)<br><small class="disponibilidade-modelo-sms text-muted" aria-live="polite">Selecione um modelo para verificar a disponibilidade.</small>@endif
                        </td>
                    </tr>
                @empty<tr><td colspan="6" class="text-center text-muted py-4">Nenhum nomeado encontrado com os filtros informados.</td></tr>@endforelse
                </tbody>
            </table>
        </div>
    </form>
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mt-3"><span class="text-muted">{{ $destinatarios->total() }} pessoa(s), 50 por página.</span>@if($destinatarios->hasPages()){{ $destinatarios->links('pagination::bootstrap-5') }}@endif</div>
</div>

@if($contexto->podeAlterarTelefone)
<div class="modal fade" id="modal-sms-telefone" tabindex="-1" aria-labelledby="modal-sms-telefone-label" aria-hidden="true">
    <div class="modal-dialog">
        <form class="modal-content" id="form-sms-telefone" method="POST">
            @csrf
            @method('PUT')
            <div class="modal-header"><h2 class="modal-title h5" id="modal-sms-telefone-label">Alterar celular do nomeado</h2><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button></div>
            <div class="modal-body">
                <p class="mb-3"><strong id="sms-telefone-nome"></strong><br><span class="text-muted" id="sms-telefone-inscricao"></span></p>
                <input type="hidden" name="acao" id="sms-telefone-acao" value="SALVAR">
                <input type="hidden" name="zona" id="sms-telefone-zona">
                <label class="form-label" for="sms-telefone-celular">Celular nacional</label>
                <input class="form-control" id="sms-telefone-celular" name="telefone" type="tel" inputmode="tel" maxlength="16" autocomplete="tel-national" placeholder="(68) 96999-8888">
                <div class="form-text" id="sms-telefone-carga"></div>
                <div class="alert alert-warning mt-3 mb-0">A alteração será aplicada às futuras convocações desta inscrição. Envios já reservados não serão modificados.</div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary me-auto" id="btn-sms-restaurar-telefone" type="button">Usar telefone da carga</button>
                <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button>
                <button class="btn btn-primary" type="submit">Salvar telefone</button>
            </div>
        </form>
    </div>
</div>
@endif

<div class="modal fade" id="modal-sms-pdf" tabindex="-1" aria-labelledby="modal-sms-pdf-label" aria-hidden="true"><div class="modal-dialog"><form class="modal-content" method="GET" action="{{ route('colaboradores-eleitorais.convocacoes-sms.destinatarios.pdf') }}" target="_blank"><div class="modal-header"><h2 class="modal-title h5" id="modal-sms-pdf-label">Campos do PDF de destinatários</h2><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button></div><div class="modal-body">@foreach(['q','zona','municipio','funcao','turma_id','situacao','confirmacao_elo'] as $filtro)<input type="hidden" name="{{ $filtro }}" value="{{ $filtros[$filtro] ?? '' }}">@endforeach @foreach($camposPdf as $campo => $rotulo)<div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="sms-pdf-{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="sms-pdf-{{ $campo }}">{{ $rotulo }}</label></div>@endforeach</div><div class="modal-footer"><button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit">Gerar PDF</button></div></form></div></div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', () => {
    const itens = [...document.querySelectorAll('.selecao-sms')];
    const todos = document.getElementById('selecionar-pagina-sms');
    const botao = document.getElementById('btn-enviar-sms');
    const modelo = document.getElementById('sms-modelo');
    const total = document.getElementById('total-sms');
    const modelosUsados = item => {
        try { return JSON.parse(item.dataset.modelosUsados || '[]').map(Number); }
        catch (erro) { return []; }
    };
    const atualizar = () => {
        const habilitados = itens.filter(item => !item.disabled);
        const marcados = habilitados.filter(item => item.checked);
        total.textContent = marcados.length;
        botao.disabled = marcados.length === 0 || !modelo || modelo.value === '';
        if (todos) {
            todos.disabled = habilitados.length === 0;
            todos.checked = habilitados.length > 0 && marcados.length === habilitados.length;
            todos.indeterminate = marcados.length > 0 && marcados.length < habilitados.length;
        }
    };
    const aplicarModelo = limparSelecao => {
        const modeloId = Number(modelo?.value || 0);
        itens.forEach(item => {
            if (limparSelecao) item.checked = false;
            const base = item.dataset.selecionavelBase === '1';
            const utilizado = modeloId > 0 && modelosUsados(item).includes(modeloId);
            item.disabled = modeloId <= 0 || !base || utilizado;
            if (item.disabled) item.checked = false;
            const aviso = item.closest('tr')?.querySelector('.disponibilidade-modelo-sms');
            if (!aviso) return;
            aviso.textContent = modeloId <= 0
                ? 'Selecione um modelo para verificar a disponibilidade.'
                : (utilizado ? 'Este modelo já foi enviado.' : 'Envio disponível para este modelo.');
            aviso.className = `disponibilidade-modelo-sms ${utilizado ? 'text-warning' : (modeloId > 0 ? 'text-primary' : 'text-muted')}`;
        });
        atualizar();
    };
    todos?.addEventListener('change', () => { itens.filter(item => !item.disabled).forEach(item => item.checked = todos.checked); atualizar(); });
    itens.forEach(item => item.addEventListener('change', atualizar));
    modelo?.addEventListener('change', () => aplicarModelo(true));
    document.getElementById('form-envio-sms')?.addEventListener('submit', () => { botao.disabled = true; botao.textContent = 'Enfileirando…'; });
    document.getElementById('modal-sms-telefone')?.addEventListener('show.bs.modal', event => {
        const origem = event.relatedTarget;
        const form = document.getElementById('form-sms-telefone');
        if (!origem || !form) return;
        form.action = origem.dataset.action;
        document.getElementById('sms-telefone-acao').value = 'SALVAR';
        document.getElementById('sms-telefone-nome').textContent = origem.dataset.nome;
        document.getElementById('sms-telefone-inscricao').textContent = `Inscrição ${origem.dataset.inscricao} · ${origem.dataset.zona}ª ZE`;
        document.getElementById('sms-telefone-zona').value = origem.dataset.zona;
        document.getElementById('sms-telefone-celular').value = origem.dataset.telefone;
        document.getElementById('sms-telefone-carga').textContent = origem.dataset.telefoneCarga ? `Telefone da carga: ${origem.dataset.telefoneCarga}` : 'A carga não possui celular válido.';
        document.getElementById('btn-sms-restaurar-telefone').classList.toggle('d-none', origem.dataset.manual !== '1');
    });
    document.getElementById('btn-sms-restaurar-telefone')?.addEventListener('click', () => {
        const form = document.getElementById('form-sms-telefone');
        if (!form || !window.confirm('Restaurar o telefone informado pela carga sincronizada?')) return;
        document.getElementById('sms-telefone-acao').value = 'RESTAURAR';
        form.requestSubmit();
    });
    aplicarModelo(false);
});
</script>
@endpush
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/convocacoes-sms/pdf.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/convocacoes-sms/pdf.blade.php`
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
<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><style>body{font-family:DejaVu Sans,sans-serif;font-size:9px;color:#222}h1{font-size:16px;margin:0 0 4px}.meta{color:#555;margin-bottom:12px}table{width:100%;border-collapse:collapse}th,td{border:1px solid #bbb;padding:4px;vertical-align:top}td{white-space:pre-line}th{background:#eee;text-align:left}tr:nth-child(even){background:#fafafa}</style></head><body><h1>{{ $titulo }}</h1><div class="meta">Pleito {{ $contexto->codPleito }} · {{ $contexto->turno }}º turno · eleição {{ \Illuminate\Support\Carbon::parse($contexto->dataEleicao)->format('d/m/Y') }} · gerado em {{ $geradoEm }}</div><table><thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead><tbody>@forelse($itens as $itemOriginal)@php $item=(array)$itemOriginal; @endphp<tr>@foreach($campos as $campo)@php $valor=$item[$campo] ?? null; if(is_array($valor)){$valor=implode(', ', array_map(fn($v)=>is_scalar($v)?(string)$v:'', $valor));} @endphp<td>{{ $valor !== null && $valor !== '' ? str_replace('_', ' ', (string)$valor) : '—' }}</td>@endforeach</tr>@empty<tr><td colspan="{{ count($campos) }}">Nenhum registro encontrado.</td></tr>@endforelse</tbody></table></body></html>
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_CONVOCACOES_SMS_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/NatRotaPainelLdaMensagemTest.php`
## <TESTS_FEATURE_NATROTAPAINELLDAMENSAGEMTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/NatRotaPainelLdaMensagemTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class NatRotaPainelLdaMensagemTest extends TestCase`

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
public function test_painel_dedicado_abre_a_conversa_lda_a_partir_da_conversa_id(): void
public function test_nat_pode_enviar_resposta_para_conversa_lda_ativa_pelo_painel_dedicado(): void
public function test_painel_dedicado_carrega_primeira_conversa_quando_conversa_id_nao_encontrado_ou_invalido(): void
public function test_painel_dedicado_renderiza_estado_vazio_quando_nao_ha_nenhuma_conversa(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Feature;

use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use App\Http\Middleware\RequireMacroprojetoContext;
use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Repositories\Nat\NatRotaMensagemRepository;
use App\Services\Nat\NatEscopoService;
use App\Services\Nat\NatRotaMensagemService;
use Mockery;
use Tests\TestCase;

class NatRotaPainelLdaMensagemTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
            RequireMacroprojetoContext::class,
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_painel_dedicado_abre_a_conversa_lda_a_partir_da_conversa_id(): void
    {
        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->atLeast()->once()->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->atLeast()->once()->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->atLeast()->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);
        $this->app->instance(NatEscopoService::class, $escopo);

        $natMensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $natMensagemRepository->shouldReceive('marcarConversaComoLida')
            ->once()
            ->with(91, 'nat.teste', 'NAT Teste');
        $natMensagemRepository->shouldReceive('listarMensagensDaConversa')
            ->once()
            ->with(91)
            ->andReturn([
                [
                    'id' => 700,
                    'conversa_id' => 91,
                    'rota_id' => null,
                    'origem' => 'ROTA',
                    'mensagem' => 'Precisamos de apoio no LDA.',
                    'usuario_login' => 'mesario_publico:000123456789',
                    'usuario_nome' => 'Mesario LDA',
                    'dt_criacao_fmt' => '19/06/2026 10:00',
                ],
            ]);
        $natMensagemRepository->shouldReceive('contarNaoLidasPorConversaIds')
            ->once()
            ->with([91], 'nat.teste')
            ->andReturn(1);
        $natMensagemRepository->shouldReceive('ultimaMensagemIdPorConversaIds')
            ->once()
            ->with([91])
            ->andReturn(700);
        $natMensagemRepository->shouldReceive('ultimaLeituraIdPorConversaIds')
            ->twice()
            ->with([91])
            ->andReturn(51);
        $this->app->instance(NatRotaMensagemRepository::class, $natMensagemRepository);

        $ldaMensagemRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        $ldaMensagemRepository->shouldReceive('buscarConversaPorIdNoEscopo')
            ->times(3)
            ->andReturn([
                'escopo_tipo' => 'LDA',
                'lda_id' => 55,
                'lda_nome' => 'SERINGAL ALPHA',
                'zona_numero' => 4,
                'turno' => '1',
                'conversa_id' => 91,
                'conversa_data_fmt' => '19/06 10:00',
                'ultima_mensagem_id' => 700,
                'ultima_mensagem_resumo' => 'Precisamos de apoio no LDA.',
                'ultima_data_fmt' => '19/06 10:00',
                'nao_lidas' => 1,
                'arquivada' => false,
            ]);
        $this->app->instance(LdaConversaMensagemRepository::class, $ldaMensagemRepository);

        $mensagemService = new NatRotaMensagemService($natMensagemRepository, $ldaMensagemRepository);
        $this->app->instance(NatRotaMensagemService::class, $mensagemService);

        $response = $this
            ->withSession([
                'user' => ['username' => 'nat.teste'],
                'macroprojeto_ativo_id' => 12,
            ])
            ->get(route('nat.lda.mensagens.index', [
                'conversa_id' => 91,
            ]));

        $response->assertOk();
        $response->assertSee('Mensageria LDA', false);
        $response->assertSee('LDA SERINGAL ALPHA', false);
        $response->assertSee('Precisamos de apoio no LDA.', false);
        $response->assertSee('Digite a mensagem para o LDA.', false);
        $response->assertDontSee('Rotas operacionais', false);
    }

    public function test_nat_pode_enviar_resposta_para_conversa_lda_ativa_pelo_painel_dedicado(): void
    {
        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->atLeast()->once()->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->atLeast()->once()->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->atLeast()->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);
        $this->app->instance(NatEscopoService::class, $escopo);

        $natMensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $this->app->instance(NatRotaMensagemRepository::class, $natMensagemRepository);

        $mensagemService = Mockery::mock(NatRotaMensagemService::class);
        $mensagemService->shouldNotReceive('enviar');
        $this->app->instance(NatRotaMensagemService::class, $mensagemService);

        $ldaMensagemRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        $ldaMensagemRepository->shouldReceive('buscarConversaPorIdNoEscopo')
            ->once()
            ->with(91, 12, [4], false, 'nat.teste', false)
            ->andReturn([
                'escopo_tipo' => 'LDA',
                'lda_id' => 55,
                'lda_nome' => 'SERINGAL ALPHA',
                'turno' => '1',
                'conversa_id' => 91,
            ]);
        $ldaMensagemRepository->shouldReceive('registrarMensagemNatNaConversa')
            ->once()
            ->with(91, 12, [4], false, [
                'login' => 'nat.teste',
                'nome' => 'NAT Teste',
            ], 'Resposta do NAT')
            ->andReturn(801);
        $this->app->instance(LdaConversaMensagemRepository::class, $ldaMensagemRepository);

        $response = $this
            ->withSession([
                'user' => ['username' => 'nat.teste'],
                'macroprojeto_ativo_id' => 12,
            ])
            ->withHeaders([
                'X-Requested-With' => 'XMLHttpRequest',
            ])
            ->postJson(route('nat.lda.mensagens.enviar'), [
                'conversa_id' => 91,
                'mensagem' => 'Resposta do NAT',
            ]);

        $response->assertOk();
        $response->assertJson(['mensagem' => 'Mensagem enviada com sucesso.']);
    }

    public function test_painel_dedicado_carrega_primeira_conversa_quando_conversa_id_nao_encontrado_ou_invalido(): void
    {
        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->atLeast()->once()->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->atLeast()->once()->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->atLeast()->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);
        $this->app->instance(NatEscopoService::class, $escopo);

        $natMensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $natMensagemRepository->shouldReceive('marcarConversaComoLida')
            ->once()
            ->with(91, 'nat.teste', 'NAT Teste');
        $natMensagemRepository->shouldReceive('listarMensagensDaConversa')
            ->once()
            ->with(91)
            ->andReturn([
                [
                    'id' => 700,
                    'conversa_id' => 91,
                    'rota_id' => null,
                    'origem' => 'ROTA',
                    'mensagem' => 'Precisamos de apoio no LDA.',
                    'usuario_login' => 'mesario_publico:000123456789',
                    'usuario_nome' => 'Mesario LDA',
                    'dt_criacao_fmt' => '19/06/2026 10:00',
                ],
            ]);
        $natMensagemRepository->shouldReceive('contarNaoLidasPorConversaIds')
            ->once()
            ->with([91], 'nat.teste')
            ->andReturn(1);
        $natMensagemRepository->shouldReceive('ultimaMensagemIdPorConversaIds')
            ->once()
            ->with([91])
            ->andReturn(700);
        $natMensagemRepository->shouldReceive('ultimaLeituraIdPorConversaIds')
            ->twice()
            ->with([91])
            ->andReturn(51);
        $this->app->instance(NatRotaMensagemRepository::class, $natMensagemRepository);

        $ldaMensagemRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        // Primeiro tenta buscar a conversa 99 (inválida/inexistente no estado ativo)
        $ldaMensagemRepository->shouldReceive('buscarConversaPorIdNoEscopo')
            ->once()
            ->with(99, 12, [4], false, 'nat.teste', false)
            ->andReturn(null);

        // Depois tenta buscar a primeira conversa no escopo (retorna a 91)
        $ldaMensagemRepository->shouldReceive('primeiraConversaNoEscopo')
            ->once()
            ->with(12, '1', [4], false, 'nat.teste', false)
            ->andReturn([
                'escopo_tipo' => 'LDA',
                'lda_id' => 55,
                'lda_nome' => 'SERINGAL ALPHA',
                'zona_numero' => 4,
                'turno' => '1',
                'conversa_id' => 91,
                'conversa_data_fmt' => '19/06 10:00',
                'ultima_mensagem_id' => 700,
                'ultima_mensagem_resumo' => 'Precisamos de apoio no LDA.',
                'ultima_data_fmt' => '19/06 10:00',
                'nao_lidas' => 1,
                'arquivada' => false,
            ]);

        // E monta o painel para a conversa 91
        $ldaMensagemRepository->shouldReceive('buscarConversaPorIdNoEscopo')
            ->times(2)
            ->with(91, 12, [4], false, 'nat.teste', false)
            ->andReturn([
                'escopo_tipo' => 'LDA',
                'lda_id' => 55,
                'lda_nome' => 'SERINGAL ALPHA',
                'zona_numero' => 4,
                'turno' => '1',
                'conversa_id' => 91,
                'conversa_data_fmt' => '19/06 10:00',
                'ultima_mensagem_id' => 700,
                'ultima_mensagem_resumo' => 'Precisamos de apoio no LDA.',
                'ultima_data_fmt' => '19/06 10:00',
                'nao_lidas' => 1,
                'arquivada' => false,
            ]);

        $this->app->instance(LdaConversaMensagemRepository::class, $ldaMensagemRepository);

        $mensagemService = new NatRotaMensagemService($natMensagemRepository, $ldaMensagemRepository);
        $this->app->instance(NatRotaMensagemService::class, $mensagemService);

        $response = $this
            ->withSession([
                'user' => ['username' => 'nat.teste'],
                'macroprojeto_ativo_id' => 12,
                'macroprojeto_ativo_turno' => '1',
            ])
            ->get(route('nat.lda.mensagens.index', [
                'conversa_id' => 99,
                'mostrar_arquivadas' => 0,
            ]));

        $response->assertOk();
        $response->assertSee('Mensageria LDA', false);
        $response->assertSee('LDA SERINGAL ALPHA', false);
    }

    public function test_painel_dedicado_renderiza_estado_vazio_quando_nao_ha_nenhuma_conversa(): void
    {
        $escopo = Mockery::mock(NatEscopoService::class);
        $escopo->shouldReceive('zonasPermitidas')->atLeast()->once()->andReturn([4]);
        $escopo->shouldReceive('acessoTodasZonas')->atLeast()->once()->andReturn(false);
        $escopo->shouldReceive('usuarioAuditoria')->atLeast()->once()->andReturn(['login' => 'nat.teste', 'nome' => 'NAT Teste']);
        $this->app->instance(NatEscopoService::class, $escopo);

        $natMensagemRepository = Mockery::mock(NatRotaMensagemRepository::class);
        $this->app->instance(NatRotaMensagemRepository::class, $natMensagemRepository);

        $ldaMensagemRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        $ldaMensagemRepository->shouldReceive('buscarConversaPorIdNoEscopo')
            ->once()
            ->with(99, 12, [4], false, 'nat.teste', false)
            ->andReturn(null);
        $ldaMensagemRepository->shouldReceive('primeiraConversaNoEscopo')
            ->once()
            ->with(12, '1', [4], false, 'nat.teste', false)
            ->andReturn(null);
        $this->app->instance(LdaConversaMensagemRepository::class, $ldaMensagemRepository);

        $mensagemService = new NatRotaMensagemService($natMensagemRepository, $ldaMensagemRepository);
        $this->app->instance(NatRotaMensagemService::class, $mensagemService);

        $response = $this
            ->withSession([
                'user' => ['username' => 'nat.teste'],
                'macroprojeto_ativo_id' => 12,
                'macroprojeto_ativo_turno' => '1',
            ])
            ->get(route('nat.lda.mensagens.index', [
                'conversa_id' => 99,
                'mostrar_arquivadas' => 0,
            ]));

        $response->assertOk();
        $response->assertSee('Mensageria LDA', false);
        $response->assertSee('Nenhuma conversa ativa encontrada para o seu escopo territorial no momento.', false);
    }
}
```
</TESTS_FEATURE_NATROTAPAINELLDAMENSAGEMTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ConvocacaoSmsDashboardContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CONVOCACAOSMSDASHBOARDCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ConvocacaoSmsDashboardContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class ConvocacaoSmsDashboardContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_rotas_dashboard_exigem_turno_e_usam_controller_proprio(): void
public function test_navegacao_compartilhada_preserva_ordem_visibilidade_e_estado_ativo(): void
public function test_dashboard_exibe_oito_cartoes_e_tres_graficos_sem_classificacao_telefonica_assincrona(): void
public function test_repository_reutiliza_snapshot_local_e_separa_fotografia_de_comunicados_dos_indicadores_operacionais(): void
public function test_migration_vincula_as_duas_rotas_aos_cinco_grupos(): void
private function ler(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$this->assertStringContainsString("Route::get('/dashboard'", $rotas);
$this->assertStringContainsString("Route::get('/dashboard/elegibilidade'", $rotas);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use Tests\TestCase;

class ConvocacaoSmsDashboardContractTest extends TestCase
{
    public function test_rotas_dashboard_exigem_turno_e_usam_controller_proprio(): void
    {
        $rotas = $this->ler('routes/web.php');
        $config = $this->ler('config/planeleito.php');

        $this->assertStringContainsString("Route::get('/dashboard'", $rotas);
        $this->assertStringContainsString("Route::get('/dashboard/elegibilidade'", $rotas);
        $this->assertStringContainsString('ConvocacaoSmsDashboardController::class', $rotas);
        $this->assertStringContainsString("'colaboradores-eleitorais.convocacoes-sms.dashboard'", $config);
        $this->assertStringContainsString("'colaboradores-eleitorais.convocacoes-sms.dashboard.elegibilidade'", $config);
    }

    public function test_navegacao_compartilhada_preserva_ordem_visibilidade_e_estado_ativo(): void
    {
        $parcial = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/_navegacao.blade.php');
        $posDestinatarios = strpos($parcial, 'Destinatários');
        $posHistorico = strpos($parcial, 'Histórico');
        $posModelos = strpos($parcial, 'Modelos');
        $posDashboard = strpos($parcial, 'Dashboard');

        $this->assertNotFalse($posDestinatarios);
        $this->assertGreaterThan($posDestinatarios, $posHistorico);
        $this->assertGreaterThan($posHistorico, $posModelos);
        $this->assertGreaterThan($posModelos, $posDashboard);
        $this->assertStringContainsString('$contexto->gestor', $parcial);
        $this->assertStringContainsString('request()->routeIs(', $parcial);
        $this->assertStringContainsString('aria-current="page"', $parcial);
        $this->assertStringContainsString('flex-wrap', $parcial);

        foreach (['index.blade.php', 'historico.blade.php', 'modelos.blade.php', 'dashboard.blade.php'] as $arquivo) {
            $this->assertStringContainsString('convocacoes-sms._navegacao', $this->ler(
                'resources/views/colaboradores-eleitorais/convocacoes-sms/'.$arquivo,
            ));
        }
    }

    public function test_dashboard_exibe_oito_cartoes_e_tres_graficos_sem_classificacao_telefonica_assincrona(): void
    {
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/dashboard.blade.php');

        foreach ([
            'Pessoas nomeadas', 'Confirmações no CONVOCA +', 'Ainda não confirmados no CONVOCA +',
            'Enviados', 'Entregues', 'Não entregues', 'Confirmados no CONVOCA + após comunicação por SMS',
            'Confirmação no convoca + que receberam SMS por tipo', 'Título Net', 'Presencial',
        ] as $rotulo) {
            $this->assertStringContainsString($rotulo, $view);
        }
        foreach ([
            'Disponíveis para primeiro SMS', 'Não confirmados sem celular válido',
            'Reservas de SMS', 'Segmentos enviados', 'Tentar novamente', 'atualizado_em',
            'dashboard-elegibilidade',
        ] as $rotuloRemovido) {
            $this->assertStringNotContainsString($rotuloRemovido, $view);
        }
        foreach (['grafico-situacoes', 'grafico-evolucao', 'grafico-zonas'] as $id) {
            $this->assertStringContainsString($id, $view);
        }
        $this->assertStringContainsString("asset('vendor/chartjs/chart.umd.min.js')", $view);
        $this->assertStringNotContainsString('cdn.', mb_strtolower($view));
        $this->assertStringNotContainsString("label: 'Reservas'", $view);
        $this->assertStringContainsString("label: 'Enviados'", $view);
        $this->assertStringContainsString('item.enviados', $view);
        $this->assertStringContainsString('O período filtra somente os indicadores operacionais de envio', $view);
    }

    public function test_repository_reutiliza_snapshot_local_e_separa_fotografia_de_comunicados_dos_indicadores_operacionais(): void
    {
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsDashboardRepository.php');
        $status = $this->ler('app/Support/ConvocacaoSms/ConvocacaoSmsStatus.php');

        $this->assertStringContainsString('MesarioConvocadoEfetivoQuery::criar', $repository);
        $this->assertStringContainsString('confirmacoes_convoca_mais', $repository);
        $this->assertStringContainsString('nao_confirmados_convoca_mais', $repository);
        $this->assertStringContainsString('confirmados_ja_comunicados', $repository);
        $this->assertStringContainsString('confirmados_ja_comunicados_titulo_net', $repository);
        $this->assertStringContainsString('confirmados_ja_comunicados_presencial', $repository);
        $this->assertStringContainsString(
            "e.status_codigo IN ('ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE')",
            $repository,
        );
        $this->assertStringContainsString('sms_dashboard_confirmacao', $repository);
        $this->assertStringContainsString('resumoEntregasInferidas', $repository);
        $this->assertStringContainsString(
            "->whereIn('e.status_codigo', ['ENVIADO', 'NAO_ENTREGUE'])",
            $repository,
        );
        $this->assertStringContainsString("->where('sms_dashboard_confirmacao.confirmado_elo', 1)", $repository);
        $this->assertStringContainsString('totalNaoEntregasInferidas', $repository);
        $this->assertStringContainsString('aplicarEntregasInferidasNaEvolucao', $repository);
        $this->assertStringContainsString('aplicarEntregasInferidasPorZona', $repository);
        $this->assertStringContainsString("\$totais['ENTREGUE'] += \$entregasInferidas", $repository);
        $this->assertStringContainsString('AS enviados', $repository);
        $this->assertStringContainsString("'enviados' => (int) (\$totais->enviados ?? 0)", $repository);
        $this->assertStringNotContainsString("\$item['enviados'] = max", $repository);
        $this->assertStringContainsString('origem_confirmacao_elo', $repository);
        $this->assertStringContainsString('ConvocacaoSmsStatus::JA_COMUNICADOS', $repository);
        $this->assertStringContainsString('MAX(sms_envio_recente.id)', $repository);
        $this->assertStringContainsString("status_codigo <> 'CANCELADO_ANTES_ENVIO'", $repository);
        foreach (['ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'] as $comunicado) {
            $this->assertStringContainsString("'{$comunicado}'", $status);
        }
        $this->assertStringNotContainsString('reservas_sms', $repository);
        $this->assertStringNotContainsString('segmentos_enviados', $repository);
        $this->assertStringContainsString('l.usuario_login', $repository);
        $this->assertStringContainsString('addDay()', $repository);
        $this->assertStringNotContainsString('@CAD_', mb_strtoupper($repository, 'UTF-8'));
        $this->assertStringNotContainsString('DBLINK', mb_strtoupper($repository, 'UTF-8'));
    }

    public function test_migration_vincula_as_duas_rotas_aos_cinco_grupos(): void
    {
        $migration = $this->ler('database/migrations/2026_08_15_150000_grant_convocacao_sms_dashboard_acl.php');

        foreach ([
            'PLANELEITO_CONVOCACAO_OPERADOR', 'PLANELEITO_CONVOCACAO_GESTOR', 'PLANELEITO_ADMIN',
            'PLANELEITO_COLABORADORES_ADMIN', 'PLANELEITO_COLABORADORES_EXTERNOS',
        ] as $grupo) {
            $this->assertStringContainsString($grupo, $migration);
        }
        foreach ([
            'colaboradores-eleitorais.convocacoes-sms.dashboard',
            'colaboradores-eleitorais.convocacoes-sms.dashboard.elegibilidade',
        ] as $rota) {
            $this->assertStringContainsString($rota, $migration);
        }
    }

    private function ler(string $arquivo): string
    {
        return (string) file_get_contents(base_path($arquivo));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CONVOCACAOSMSDASHBOARDCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ConvocacaoSmsTelefoneManualContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CONVOCACAOSMSTELEFONEMANUALCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ConvocacaoSmsTelefoneManualContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class ConvocacaoSmsTelefoneManualContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rota_put_modal_e_identificacao_manual_estao_declarados(): void
public function repository_manual_usa_auditoria_e_destinatarios_fazem_join_logico(): void
public function sincronizacao_noturna_nao_menciona_tabela_manual(): void
private function ler(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$this->assertStringContainsString("Route::put('/destinatarios/{num_inscricao}/telefone'", $rotas);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ConvocacaoSmsTelefoneManualContractTest extends TestCase
{
    #[Test]
    public function rota_put_modal_e_identificacao_manual_estao_declarados(): void
    {
        $rotas = $this->ler('routes/web.php');
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');

        $this->assertStringContainsString("Route::put('/destinatarios/{num_inscricao}/telefone'", $rotas);
        $this->assertStringContainsString("->name('destinatarios.telefone.update')", $rotas);
        $this->assertStringContainsString('modal-sms-telefone', $view);
        $this->assertStringContainsString('Alterado manualmente', $view);
        $this->assertStringContainsString('RESTAURAR', $view);
    }

    #[Test]
    public function repository_manual_usa_auditoria_e_destinatarios_fazem_join_logico(): void
    {
        $manual = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsTelefoneManualRepository.php');
        $destinatarios = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsDestinatarioRepository.php');

        $this->assertStringContainsString('use AuditaDml;', $manual);
        $this->assertStringContainsString('inserirAuditado(', $manual);
        $this->assertStringContainsString('atualizarAuditadoPorId(', $manual);
        $this->assertStringContainsString('removerAuditadoPorId(', $manual);
        $this->assertStringContainsString("leftJoin('ce_sms_telefone_manual as sms_telefone_manual'", $destinatarios);
        $this->assertStringContainsString('sms_telefone_manual.telefone_nacional as telefone_manual', $destinatarios);
    }

    #[Test]
    public function sincronizacao_noturna_nao_menciona_tabela_manual(): void
    {
        $sincronizacao = $this->ler('app/Services/LocaisVotacao/LocalVotacaoSyncService.php').' '.$this->ler('routes/console.php');

        $this->assertStringNotContainsString('ce_sms_telefone_manual', mb_strtolower($sincronizacao));
    }

    private function ler(string $arquivo): string
    {
        return (string) file_get_contents(base_path($arquivo));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CONVOCACAOSMSTELEFONEMANUALCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/ConvocacaoSmsTextBeeContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CONVOCACAOSMSTEXTBEECONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/ConvocacaoSmsTextBeeContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class ConvocacaoSmsTextBeeContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringContainsString("DB::table('ce_sms_lote_item')->where('lote_id', \$id)->exists()", $repository);
$this->assertStringContainsString("DB::table('ce_sms_envio')->where('lote_id', \$id)->exists()", $repository);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_rotas_sms_webhook_bypass_csrf_e_redirecionamento_estao_declarados(): void
public function test_config_container_menu_e_fila_usam_textbee_no_fluxo_novo(): void
public function test_fila_respeita_janela_diaria_e_restaura_tentativa_nao_consumida(): void
$this->assertStringContainsString('public function restaurarPendenteForaJanela(int $id): bool', $repository);
public function test_views_sms_nao_expoem_wamid_nem_controles_meta(): void
public function test_leitura_do_envio_usa_alias_exclusivo_para_data_eleitoral_no_oracle(): void
public function test_limpeza_corretiva_remove_somente_lote_vazio_com_auditoria(): void
$this->assertStringContainsString('public function removerLoteVazio(int $id): bool', $repository);
public function test_destinatarios_filtram_funcao_preservam_pdf_e_usam_envio_mais_recente(): void
public function test_destinatarios_filtram_integrantes_da_turma_e_preservam_pdf_e_escopo(): void
public function test_interface_habilita_novo_modelo_para_perfis_operacionais_e_preserva_restauracao(): void
public function test_interface_e_reserva_explicam_bloqueio_do_modelo_ja_utilizado(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$this->assertStringContainsString("Route::prefix('convocacoes-sms')", $rotas);
$this->assertStringContainsString("Route::redirect('/convocacoes-whatsapp'", $rotas);
$this->assertStringContainsString("Route::post('/rotas-publicas/integracoes/zenvia/sms/webhook'", $rotas);
$this->assertStringContainsString("Route::post('/rotas-publicas/integracoes/textbee/sms/webhook'", $rotas);
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use Tests\TestCase;

class ConvocacaoSmsTextBeeContractTest extends TestCase
{
    public function test_rotas_sms_webhook_bypass_csrf_e_redirecionamento_estao_declarados(): void
    {
        $rotas = $this->ler('routes/web.php');
        $config = $this->ler('config/planeleito.php');
        $bootstrap = $this->ler('bootstrap/app.php');

        $this->assertStringContainsString("Route::prefix('convocacoes-sms')", $rotas);
        $this->assertStringContainsString("Route::redirect('/convocacoes-whatsapp'", $rotas);
        $this->assertStringContainsString("Route::post('/rotas-publicas/integracoes/zenvia/sms/webhook'", $rotas);
        $this->assertStringContainsString('integracoes.zenvia.sms.webhook.receber', $rotas);
        $this->assertStringContainsString("Route::post('/rotas-publicas/integracoes/textbee/sms/webhook'", $rotas);
        $this->assertStringContainsString('integracoes.textbee.sms.webhook.receber', $rotas);
        $this->assertStringNotContainsString('integracoes.meta.whatsapp.webhook', $rotas);
        $this->assertSame(1, substr_count($bootstrap, "'rotas-publicas/integracoes/zenvia/sms/webhook'"));
        $this->assertSame(1, substr_count($bootstrap, "'rotas-publicas/integracoes/textbee/sms/webhook'"));
        $this->assertStringNotContainsString("'rotas-publicas/integracoes/meta/whatsapp/webhook'", $bootstrap);
        $this->assertGreaterThanOrEqual(3, substr_count($config, "'integracoes.zenvia.sms.webhook.receber'"));
        $this->assertGreaterThanOrEqual(3, substr_count($config, "'integracoes.textbee.sms.webhook.receber'"));
        $this->assertStringContainsString("'colaboradores-eleitorais.convocacoes-sms.index'", $config);
    }

    public function test_config_container_menu_e_fila_usam_textbee_no_fluxo_novo(): void
    {
        $config = $this->ler('config/planeleito.php');
        $provider = $this->ler('app/Providers/AppServiceProvider.php');
        $menu = $this->ler('config/planeleito_menu.php');
        $console = $this->ler('routes/console.php');

        $this->assertStringContainsString("'sms_textbee' => [", $config);
        $this->assertStringContainsString('SmsGatewayInterface::class', $provider);
        $this->assertStringContainsString('TextBeeSmsClient::class', $provider);
        $this->assertStringContainsString('ZenviaSmsWebhookAutenticacao::class', $provider);
        $this->assertStringContainsString('TextBeeSmsWebhookAutenticacao::class', $provider);
        $this->assertStringContainsString("'label' => 'Convocação por SMS'", $menu);
        $this->assertStringNotContainsString('WhatsApp', $menu);
        $this->assertStringContainsString('convocacoes-sms:marcar-abandonados', $console);
        $this->assertStringContainsString('convocacoes-sms:sincronizar-textbee', $console);
        $this->assertStringContainsString('->everyMinute()', $console);
        $this->assertStringContainsString('->onOneServer()', $console);
        $this->assertStringContainsString("'sync_enabled'", $config);
        $this->assertStringContainsString("'sync_initial_from'", $config);
        $this->assertStringContainsString("'convocacoes-sms'", $this->ler('app/Jobs/ConvocacaoSms/EnviarConvocacaoSmsJob.php'));

        $worker = $this->ler('deploy/systemd/planeleito-sms-queue.service');
        $this->assertStringContainsString('--queue=convocacoes-sms', $worker);
        $this->assertStringContainsString('--tries=1', $worker);
        $this->assertStringContainsString('--max-time=3600', $worker);
        $this->assertStringNotContainsString('Zenvia Queue Worker', $worker);
    }

    public function test_fila_respeita_janela_diaria_e_restaura_tentativa_nao_consumida(): void
    {
        $config = $this->ler('config/planeleito.php');
        $contrato = $this->ler('app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsProcessamentoRepositoryInterface.php');
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsEnvioRepository.php');

        $this->assertStringContainsString("'sending_start'", $config);
        $this->assertStringContainsString("'sending_end'", $config);
        $this->assertStringContainsString('restaurarPendenteForaJanela(int $id): bool', $contrato);
        $this->assertStringContainsString('public function restaurarPendenteForaJanela(int $id): bool', $repository);
        $this->assertStringContainsString("atualizarEscopoAuditado('ce_sms_envio', 'CE_SMS_ENVIO'", $repository);
        $this->assertStringContainsString('GREATEST(tentativas - 1, 0)', $repository);
        $this->assertStringContainsString("'dt_processamento' => null", $repository);
    }

    public function test_views_sms_nao_expoem_wamid_nem_controles_meta(): void
    {
        $conteudo = '';
        foreach (['index.blade.php', 'historico.blade.php', 'detalhe.blade.php', 'modelos.blade.php'] as $arquivo) {
            $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/'.$arquivo);
            $conteudo .= $view;
            $this->assertStringContainsString('convocacoes-sms', $view);
        }

        $this->assertStringNotContainsString('wamid', mb_strtolower($conteudo));
        $this->assertStringNotContainsString('Sincronizar Meta', $conteudo);
        $this->assertStringNotContainsString('smsrning', $conteudo);
        $this->assertStringNotContainsString('ID Zenvia', $conteudo);
        $this->assertStringContainsString('alert-warning', $conteudo);
        $this->assertStringContainsString('text-bg-warning', $conteudo);
        $this->assertStringContainsString('{{ $limiteCaracteres }} caracteres', $conteudo);
        $this->assertStringNotContainsString('três segmentos', $conteudo);

        $request = $this->ler('app/Http/Requests/ConvocacaoSms/ConvocacaoSmsModeloRequest.php');
        $controller = $this->ler('app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsModeloController.php');
        $this->assertStringContainsString('ConvocacaoSmsMensagem::LIMITE_CARACTERES', $request);
        $this->assertStringContainsString('ConvocacaoSmsMensagem::LIMITE_CARACTERES', $controller);
    }

    public function test_leitura_do_envio_usa_alias_exclusivo_para_data_eleitoral_no_oracle(): void
    {
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsEnvioRepository.php');

        $this->assertStringContainsString(
            "TO_CHAR(e.dt_eleicao, 'YYYY-MM-DD') AS dt_eleicao_iso",
            $repository,
        );
        $this->assertStringNotContainsString(
            "TO_CHAR(e.dt_eleicao, 'YYYY-MM-DD') AS dt_eleicao\n",
            $repository,
        );
    }

    public function test_limpeza_corretiva_remove_somente_lote_vazio_com_auditoria(): void
    {
        $contrato = $this->ler('app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsEnvioRepositoryInterface.php');
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsEnvioRepository.php');

        $this->assertStringContainsString('removerLoteVazio(int $id): bool', $contrato);
        $this->assertStringContainsString('public function removerLoteVazio(int $id): bool', $repository);
        $this->assertStringContainsString("removerEscopoAuditado('ce_sms_lote', 'CE_SMS_LOTE'", $repository);
        $this->assertStringContainsString("DB::table('ce_sms_lote_item')->where('lote_id', \$id)->exists()", $repository);
        $this->assertStringContainsString("DB::table('ce_sms_envio')->where('lote_id', \$id)->exists()", $repository);
    }

    public function test_destinatarios_filtram_funcao_preservam_pdf_e_usam_envio_mais_recente(): void
    {
        $request = $this->ler('app/Http/Requests/ConvocacaoSms/ConvocacaoSmsFiltroRequest.php');
        $controller = $this->ler('app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsController.php');
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsDestinatarioRepository.php');
        $paginacao = $this->ler('app/Repositories/ConvocacaoSms/Queries/ConvocacaoSmsDestinatarioPaginadoQuery.php');
        $agrupador = $this->ler('app/Services/ConvocacaoSms/ConvocacaoSmsDestinatarioAgrupador.php');
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');

        $this->assertStringContainsString('MesarioFuncaoEleitoralCatalogo::todas()', $request);
        $this->assertStringContainsString("'funcoes' => MesarioFuncaoEleitoralCatalogo::todas()", $controller);
        $this->assertStringContainsString("'funcao'", $controller);
        $this->assertStringContainsString("funcao: trim((string) (\$filtros['funcao'] ?? ''))", $repository);
        $this->assertStringContainsString('SELECT MAX(sms_envio_recente.id)', $repository);
        $this->assertStringContainsString('$this->status->statusDestinatarioFiltraveisExatos()', $repository);
        $this->assertStringContainsString('$this->status->correspondeFiltroDestinatario(', $repository);
        $this->assertStringContainsString('status_codigo_efetivo', $paginacao);
        $this->assertStringContainsString('status_codigo_efetivo', $agrupador);
        $this->assertStringContainsString('Entrega considerada pelo CONVOCA +', $view);
        $this->assertStringContainsString('name="funcao"', $view);
        $this->assertStringContainsString("['q','zona','municipio','funcao','turma_id','situacao','confirmacao_elo']", $view);
    }

    public function test_destinatarios_filtram_integrantes_da_turma_e_preservam_pdf_e_escopo(): void
    {
        $request = $this->ler('app/Http/Requests/ConvocacaoSms/ConvocacaoSmsFiltroRequest.php');
        $controller = $this->ler('app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsController.php');
        $contrato = $this->ler('app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsDestinatarioRepositoryInterface.php');
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsDestinatarioRepository.php');
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');

        $this->assertStringContainsString("'turma_id' => ['nullable', 'integer', 'min:1']", $request);
        $this->assertStringContainsString('listarTurmasTreinamento', $contrato);
        $this->assertStringContainsString("'turmasTreinamento' =>", $controller);
        $this->assertStringContainsString("'turma_id'", $controller);
        $this->assertStringContainsString('ConvocacaoSmsTurmaTreinamentoQuery::aplicarFiltro(', $repository);
        $this->assertStringContainsString('name="turma_id"', $view);
        $this->assertStringContainsString('Turma de treinamento', $view);
        $this->assertStringContainsString("['q','zona','municipio','funcao','turma_id','situacao','confirmacao_elo']", $view);
    }

    public function test_interface_habilita_novo_modelo_para_perfis_operacionais_e_preserva_restauracao(): void
    {
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');

        $this->assertStringContainsString('data-modelos-usados', $view);
        $this->assertStringContainsString('Envio disponível para este modelo', $view);
        $this->assertStringContainsString("\$contexto->gestor && \$situacao === 'JA_COMUNICADO'", $view);
        $this->assertStringContainsString('Usar telefone da carga', $view);
    }

    public function test_interface_e_reserva_explicam_bloqueio_do_modelo_ja_utilizado(): void
    {
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');
        $modelos = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/modelos.blade.php');
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsEnvioRepository.php');

        $this->assertStringContainsString('modelos_ja_utilizados', $view);
        $this->assertStringContainsString('Este modelo já foi enviado', $view);
        $this->assertStringContainsString('editar o texto não libera', $modelos);
        $this->assertStringContainsString('UX_CE_SMS_ENVIO_MODELO', $repository);
    }

    public function test_interface_expoe_confirmacao_do_elo_e_preserva_filtro_no_pdf(): void
    {
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');
        $controller = $this->ler('app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsController.php');

        $this->assertStringContainsString('name="confirmacao_elo"', $view);
        $this->assertStringContainsString('Confirmação no ELO', $view);
        $this->assertStringContainsString('Convocado em', $view);
        $this->assertStringContainsString("['q','zona','municipio','funcao','turma_id','situacao','confirmacao_elo']", $view);
        $this->assertStringContainsString("'resumo_convocacoes' => 'Nomeações e datas de convocação'", $controller);
        $this->assertStringContainsString("'confirmacao_elo_resumo' => 'Confirmação no ELO'", $controller);
    }

    public function test_interface_mantem_confirmacao_visivel_sem_bloquear_modelo_novo(): void
    {
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');

        $this->assertStringNotContainsString('confirmacao_elo_bloqueia_envio', $view);
        $this->assertStringNotContainsString('envio indisponível, convocação já confirmada no CONVOCA +', $view);
        $this->assertStringContainsString('$statusRotulos[$situacao]', $view);
    }

    public function test_sms_inclui_nomeacoes_sem_local_com_aviso_e_reidratacao_canonica(): void
    {
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsDestinatarioRepository.php');
        $dashboard = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsDashboardRepository.php');
        $view = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/index.blade.php');

        $this->assertStringContainsString('incluirSemLocal: true', $repository);
        $this->assertStringContainsString('incluirSemLocal: true', $dashboard);
        $this->assertStringContainsString(
            "REGEXP_REPLACE(NVL(TRIM(lv_efetivo.cod_objeto_zona), TRIM(c.num_zona)), '[^0-9]', '')",
            $repository,
        );
        $this->assertStringContainsString('nomeacao_sem_local', $view);
        $this->assertStringContainsString('Sem local ou seção informado no CONVOCA +', $view);
        $controller = $this->ler('app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsController.php');
        $this->assertStringContainsString("'situacao_local' => 'Localização da nomeação'", $controller);
    }

    public function test_respostas_textbee_vinculadas_sao_exibidas_e_as_sem_vinculo_ficam_somente_na_auditoria(): void
    {
        $repository = $this->ler('app/Repositories/ConvocacaoSms/ConvocacaoSmsRespostaRepository.php');
        $contrato = $this->ler('app/Repositories/ConvocacaoSms/Contracts/ConvocacaoSmsRespostaRepositoryInterface.php');
        $controller = $this->ler('app/Http/Controllers/ConvocacaoSms/ConvocacaoSmsHistoricoController.php');
        $historico = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/historico.blade.php');
        $detalhe = $this->ler('resources/views/colaboradores-eleitorais/convocacoes-sms/detalhe.blade.php');

        $this->assertStringContainsString('use AuditaDml;', $repository);
        $this->assertStringContainsString("inserirAuditado('ce_sms_resposta', 'CE_SMS_RESPOSTA'", $repository);
        $this->assertStringContainsString("'respostas_sms' => 'Respostas SMS'", $controller);
        $this->assertStringContainsString('Respostas recebidas', $detalhe);
        $this->assertStringContainsString('ID do lote', $detalhe);
        $this->assertStringContainsString('ID da mensagem', $detalhe);
        $this->assertStringNotContainsString('Respostas sem vínculo automático', $historico);
        $this->assertStringNotContainsString('respostasNaoVinculadas', $historico);
        $this->assertStringNotContainsString('respostasNaoVinculadas', $controller);
        $this->assertStringNotContainsString('listarNaoVinculadas', $controller);
        $this->assertStringNotContainsString('listarNaoVinculadas', $contrato);
        $this->assertStringNotContainsString('listarNaoVinculadas', $repository);
    }

    private function ler(string $arquivo): string
    {
        return (string) file_get_contents(base_path($arquivo));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_CONVOCACAOSMSTEXTBEECONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsContextoSessaoTest.php`
## <TESTS_UNIT_CONVOCACAOSMSCONTEXTOSESSAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsContextoSessaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsContextoSessaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_resolve_contexto_com_pleito_data_usuario_papel_e_zonas(): void
public function test_falha_fechado_quando_turno_ativo_nao_tem_pleito_e_data(): void
public function test_colaborador_externo_resolve_como_operador_no_escopo_zonal_da_sessao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoSessao;
use App\Services\ConvocacaoSms\ConvocacaoSmsPermissaoService;
use DomainException;
use Mockery;
use Tests\TestCase;

class ConvocacaoSmsContextoSessaoTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_resolve_contexto_com_pleito_data_usuario_papel_e_zonas(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'user' => ['username' => 'operador', 'name' => 'Operador Um'],
            'matchingGroups' => ['PLANELEITO_CONVOCACAO_GESTOR', '1ZONA'],
            'cod_zonas_permitidas' => [1, '2', 'invalida'],
            'acesso_todas_zonas' => false,
        ]);
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(1)->andReturn([
            'id' => 9,
            'macroprojeto_id' => 1,
            'turno' => '1',
            'descricao' => '1º turno',
            'ativo' => 1,
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
        ]);

        $contexto = (new ConvocacaoSmsContextoSessao(
            $repository,
            new ConvocacaoSmsPermissaoService,
        ))->atual();

        $this->assertSame(9, $contexto->macroprojetoTurnoId);
        $this->assertSame('3220', $contexto->codPleito);
        $this->assertSame('2026-10-04', $contexto->dataEleicao);
        $this->assertSame(['1', '2'], $contexto->zonasPermitidas);
        $this->assertTrue($contexto->gestor);
        $this->assertFalse($contexto->administrador);
        $this->assertTrue($contexto->podeAlterarTelefone);
    }

    public function test_falha_fechado_quando_turno_ativo_nao_tem_pleito_e_data(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'user' => ['username' => 'operador', 'name' => 'Operador'],
            'matchingGroups' => ['PLANELEITO_CONVOCACAO_OPERADOR'],
        ]);
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->andReturn([
            'id' => 9,
            'macroprojeto_id' => 1,
            'turno' => '1',
            'descricao' => '1º turno',
            'ativo' => 1,
            'cod_pleito' => null,
            'dt_eleicao' => null,
        ]);

        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('pleito e data');

        (new ConvocacaoSmsContextoSessao(
            $repository,
            new ConvocacaoSmsPermissaoService,
        ))->atual();
    }

    public function test_colaborador_externo_resolve_como_operador_no_escopo_zonal_da_sessao(): void
    {
        session([
            'macroprojeto_ativo_id' => 1,
            'user' => ['username' => 'externo', 'name' => 'Colaborador Externo'],
            'matchingGroups' => ['PLANELEITO_COLABORADORES_EXTERNOS'],
            'cod_zonas_permitidas' => ['3'],
            'acesso_todas_zonas' => false,
        ]);
        $repository = Mockery::mock(MacroprojetoTurnoRepository::class);
        $repository->shouldReceive('buscarAtivoPorMacroprojeto')->once()->with(1)->andReturn([
            'id' => 9,
            'macroprojeto_id' => 1,
            'turno' => '1',
            'descricao' => '1º turno',
            'ativo' => 1,
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
        ]);

        $contexto = (new ConvocacaoSmsContextoSessao(
            $repository,
            new ConvocacaoSmsPermissaoService,
        ))->atual();

        $this->assertSame(['3'], $contexto->zonasPermitidas);
        $this->assertFalse($contexto->acessoTodasZonas);
        $this->assertFalse($contexto->gestor);
        $this->assertFalse($contexto->administrador);
        $this->assertFalse($contexto->podeAlterarTelefone);
        $this->assertSame('externo', $contexto->usuarioLogin);
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSCONTEXTOSESSAOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsDashboardControllerTest.php`
## <TESTS_UNIT_CONVOCACAOSMSDASHBOARDCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsDashboardControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsDashboardControllerTest extends TestCase`

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
public function test_endpoint_retorna_payload_contratado(): void
public function test_falha_do_resumo_retorna_503_sem_bloquear_o_html_inicial(): void
private function controller(ConvocacaoSmsDashboardRepositoryInterface $dashboard): ConvocacaoSmsDashboardController
private function request(array $dados): ConvocacaoSmsDashboardRequest
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ConvocacaoSms\ConvocacaoSmsDashboardController;
use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsDashboardRequest;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDashboardRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\Planejamento\MacroprojetoTurnoRepository;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoSessao;
use App\Services\ConvocacaoSms\ConvocacaoSmsDashboardService;
use App\Services\ConvocacaoSms\ConvocacaoSmsPermissaoService;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class ConvocacaoSmsDashboardControllerTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        session([
            'macroprojeto_ativo_id' => 1,
            'user.username' => 'operador',
            'user.name' => 'Operador',
            'matchingGroups' => ['PLANELEITO_CONVOCACAO_OPERADOR'],
            'cod_zonas_permitidas' => ['3'],
            'acesso_todas_zonas' => false,
        ]);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_endpoint_retorna_payload_contratado(): void
    {
        $dashboard = Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class);
        $dashboard->shouldReceive('resumoPopulacao')->once()->andReturn([
            'pessoas_nomeadas' => 10,
            'confirmacoes_convoca_mais' => 4,
            'nao_confirmados_convoca_mais' => 6,
        ]);

        $response = $this->controller($dashboard)->elegibilidade($this->request(['zona' => '3']));

        $this->assertSame(200, $response->status());
        $this->assertSame(6, $response->getData(true)['nao_confirmados_convoca_mais']);
        $this->assertArrayHasKey('atualizado_em', $response->getData(true));
    }

    public function test_falha_do_resumo_retorna_503_sem_bloquear_o_html_inicial(): void
    {
        $dashboard = Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class);
        $dashboard->shouldReceive('resumoPopulacao')->once()->andThrow(new RuntimeException('Oracle indisponível'));

        $response = $this->controller($dashboard)->elegibilidade($this->request([]));

        $this->assertSame(503, $response->status());
        $this->assertSame(
            'Não foi possível atualizar o resumo de confirmação.',
            $response->getData(true)['message'],
        );
    }

    private function controller(ConvocacaoSmsDashboardRepositoryInterface $dashboard): ConvocacaoSmsDashboardController
    {
        $turnos = Mockery::mock(MacroprojetoTurnoRepository::class);
        $turnos->shouldReceive('buscarAtivoPorMacroprojeto')->andReturn([
            'id' => 1,
            'macroprojeto_id' => 1,
            'turno' => '1',
            'descricao' => 'Primeiro turno',
            'ativo' => 1,
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
        ]);
        $contextos = new ConvocacaoSmsContextoSessao($turnos, new ConvocacaoSmsPermissaoService);
        $service = new ConvocacaoSmsDashboardService($dashboard);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);

        return new ConvocacaoSmsDashboardController($contextos, $service, $destinatarios);
    }

    /** @param array<string, mixed> $dados */
    private function request(array $dados): ConvocacaoSmsDashboardRequest
    {
        $request = ConvocacaoSmsDashboardRequest::create('/dashboard/elegibilidade', 'GET', $dados);
        $request->setContainer($this->app);
        $request->setRedirector($this->app->make('redirect'));
        $request->validateResolved();

        return $request;
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSDASHBOARDCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsDashboardRequestTest.php`
## <TESTS_UNIT_CONVOCACAOSMSDASHBOARDREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsDashboardRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsDashboardRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aceita_periodo_inclusivo_e_rejeita_intervalo_invertido(): void
public function normaliza_zona_e_datas_vazias_sem_aceitar_formato_livre(): void
public function rejeita_zona_textual_sem_converte_la_para_zero(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsDashboardRequest;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use ReflectionMethod;
use Tests\TestCase;

class ConvocacaoSmsDashboardRequestTest extends TestCase
{
    #[Test]
    public function aceita_periodo_inclusivo_e_rejeita_intervalo_invertido(): void
    {
        $regras = (new ConvocacaoSmsDashboardRequest)->rules();

        $this->assertFalse(Validator::make([
            'data_inicial' => '2026-08-01',
            'data_final' => '2026-08-01',
        ], $regras)->fails());
        $this->assertTrue(Validator::make([
            'data_inicial' => '2026-08-02',
            'data_final' => '2026-08-01',
        ], $regras)->fails());
    }

    #[Test]
    public function normaliza_zona_e_datas_vazias_sem_aceitar_formato_livre(): void
    {
        $request = ConvocacaoSmsDashboardRequest::create('/', 'GET', [
            'zona' => ' 003 ',
            'data_inicial' => ' ',
            'data_final' => '15/08/2026',
        ]);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $this->assertSame('3', $request->input('zona'));
        $this->assertNull($request->input('data_inicial'));
        $this->assertTrue(Validator::make($request->all(), $request->rules())->fails());
    }

    #[Test]
    public function rejeita_zona_textual_sem_converte_la_para_zero(): void
    {
        $request = ConvocacaoSmsDashboardRequest::create('/', 'GET', ['zona' => 'zona três']);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $this->assertSame('zona três', $request->input('zona'));
        $this->assertTrue(Validator::make($request->all(), $request->rules())->fails());
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSDASHBOARDREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsDashboardServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSDASHBOARDSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsDashboardServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsDashboardServiceTest extends TestCase`

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
public function carrega_populacao_e_envios_com_filtros_validados(): void
public function recusa_zona_fora_do_escopo_antes_de_consultar_o_oracle(): void
public function rota_auxiliar_retorna_apenas_o_resumo_leve_de_nao_confirmados(): void
public function rota_auxiliar_nao_carrega_envios_nem_destinatarios_detalhados(): void
private function service(?ConvocacaoSmsDashboardRepositoryInterface $dashboard = null): ConvocacaoSmsDashboardService
private function contexto(int $turnoId = 10, array $zonas = ['3'], bool $gestor = false): ConvocacaoSmsContexto
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDashboardRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Services\ConvocacaoSms\ConvocacaoSmsDashboardService;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Support\Carbon;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ConvocacaoSmsDashboardServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        Carbon::setTestNow('2026-08-15 10:00:00');
    }

    protected function tearDown(): void
    {
        Carbon::setTestNow();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function carrega_populacao_e_envios_com_filtros_validados(): void
    {
        $contexto = $this->contexto(zonas: ['3', '4'], gestor: true);
        $filtros = ['zona' => '3', 'data_inicial' => '2026-08-01', 'data_final' => '2026-08-15'];
        $dashboard = Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class);
        $dashboard->shouldReceive('resumoPopulacao')->once()->with($contexto, '3')->andReturn([
            'pessoas_nomeadas' => 100,
            'confirmacoes_convoca_mais' => 40,
            'nao_confirmados_convoca_mais' => 60,
        ]);
        $dashboard->shouldReceive('resumoEnvios')->once()->with($contexto, $filtros)->andReturn([
            'enviados' => 8,
            'entregues' => 15,
            'nao_entregues' => 2,
            'confirmados_ja_comunicados' => 9,
            'confirmados_ja_comunicados_titulo_net' => 6,
            'confirmados_ja_comunicados_presencial' => 3,
            'por_situacao' => [],
            'evolucao_diaria' => [],
            'por_zona' => [],
        ]);

        $resultado = $this->service($dashboard)->carregar($filtros, $contexto);

        $this->assertSame(100, $resultado['pessoas_nomeadas']);
        $this->assertSame(40, $resultado['confirmacoes_convoca_mais']);
        $this->assertSame(60, $resultado['nao_confirmados_convoca_mais']);
        $this->assertSame(8, $resultado['enviados']);
        $this->assertSame(9, $resultado['confirmados_ja_comunicados']);
        $this->assertSame(6, $resultado['confirmados_ja_comunicados_titulo_net']);
        $this->assertSame(3, $resultado['confirmados_ja_comunicados_presencial']);
        $this->assertArrayNotHasKey('segmentos_enviados', $resultado);
    }

    #[Test]
    public function recusa_zona_fora_do_escopo_antes_de_consultar_o_oracle(): void
    {
        $dashboard = Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class);
        $dashboard->shouldNotReceive('resumoPopulacao');
        $dashboard->shouldNotReceive('resumoEnvios');

        $this->expectException(AuthorizationException::class);

        $this->service($dashboard)->carregar(['zona' => '9'], $this->contexto(zonas: ['3']));
    }

    #[Test]
    public function rota_auxiliar_retorna_apenas_o_resumo_leve_de_nao_confirmados(): void
    {
        $contexto = $this->contexto(zonas: ['3']);
        $dashboard = Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class);
        $dashboard->shouldReceive('resumoPopulacao')->once()->with($contexto, '3')->andReturn([
            'pessoas_nomeadas' => 100,
            'confirmacoes_convoca_mais' => 40,
            'nao_confirmados_convoca_mais' => 60,
        ]);

        $resultado = $this->service($dashboard)->elegibilidade(['zona' => '3'], $contexto);

        $this->assertSame(60, $resultado['nao_confirmados_convoca_mais']);
        $this->assertSame('2026-08-15T10:00:00-05:00', $resultado['atualizado_em']);
    }

    #[Test]
    public function rota_auxiliar_nao_carrega_envios_nem_destinatarios_detalhados(): void
    {
        $contexto = $this->contexto();
        $dashboard = Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class);
        $dashboard->shouldReceive('resumoPopulacao')->once()->with($contexto, '')->andReturn([
            'pessoas_nomeadas' => 10,
            'confirmacoes_convoca_mais' => 4,
            'nao_confirmados_convoca_mais' => 6,
        ]);
        $dashboard->shouldNotReceive('resumoEnvios');

        $resultado = $this->service($dashboard)->elegibilidade([], $contexto);

        $this->assertSame(6, $resultado['nao_confirmados_convoca_mais']);
    }

    private function service(?ConvocacaoSmsDashboardRepositoryInterface $dashboard = null): ConvocacaoSmsDashboardService
    {
        return new ConvocacaoSmsDashboardService(
            $dashboard ?? Mockery::mock(ConvocacaoSmsDashboardRepositoryInterface::class),
        );
    }

    /** @param array<int, string> $zonas */
    private function contexto(int $turnoId = 10, array $zonas = ['3'], bool $gestor = false): ConvocacaoSmsContexto
    {
        return new ConvocacaoSmsContexto(
            1,
            $turnoId,
            '1',
            '406',
            '2026-10-04',
            'operador',
            'Operador',
            $gestor,
            false,
            $zonas,
            false,
        );
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSDASHBOARDSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsDashboardViewTest.php`
## <TESTS_UNIT_CONVOCACAOSMSDASHBOARDVIEWTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsDashboardViewTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsDashboardViewTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_renderiza_estado_com_dados_e_oculta_modelos_do_operador(): void
public function test_gestor_visualiza_modelos_e_graficos_recebem_estado_vazio(): void
private function renderizar(ConvocacaoSmsContexto $contexto, array $situacoes): string
private function contexto(bool $gestor): ConvocacaoSmsContexto
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use Illuminate\Support\ViewErrorBag;
use Tests\TestCase;

class ConvocacaoSmsDashboardViewTest extends TestCase
{
    public function test_renderiza_estado_com_dados_e_oculta_modelos_do_operador(): void
    {
        $html = $this->renderizar($this->contexto(false), [
            ['codigo' => 'ENTREGUE', 'rotulo' => 'Entregues', 'total' => 4],
        ]);

        $this->assertStringContainsString('Dashboard da convocação por SMS', $html);
        $this->assertStringContainsString('4ª ZE', $html);
        $this->assertStringContainsString('grafico-situacoes', $html);
        $this->assertStringContainsString('Ainda não confirmados no CONVOCA +', $html);
        $this->assertStringContainsString('Enviados', $html);
        $this->assertStringContainsString('Confirmados no CONVOCA + após comunicação por SMS', $html);
        $this->assertStringContainsString('Confirmação no convoca + que receberam SMS por tipo', $html);
        $this->assertStringContainsString('Título Net', $html);
        $this->assertStringContainsString('Presencial', $html);
        $this->assertStringContainsString('>2<', str_replace(["\n", "\r", ' '], '', $html));
        $this->assertStringNotContainsString('dashboard\\/elegibilidade', $html);
        $this->assertStringNotContainsString('Reservas de SMS', $html);
        $this->assertStringNotContainsString('Segmentos enviados', $html);
        $this->assertStringContainsString("label: 'Enviados'", $html);
        $this->assertStringContainsString('item.enviados', $html);
        $this->assertStringContainsString('Dashboard</a>', $html);
        $this->assertStringNotContainsString('Modelos</a>', $html);
    }

    public function test_gestor_visualiza_modelos_e_graficos_recebem_estado_vazio(): void
    {
        $html = $this->renderizar($this->contexto(true), []);

        $this->assertStringContainsString('Modelos</a>', $html);
        $this->assertStringContainsString('Nenhum envio no período.', $html);
        $this->assertStringContainsString("asset('vendor/chartjs/chart.umd.min.js')", file_get_contents(
            resource_path('views/colaboradores-eleitorais/convocacoes-sms/dashboard.blade.php'),
        ));
    }

    /** @param array<int, array{codigo:string,rotulo:string,total:int}> $situacoes */
    private function renderizar(ConvocacaoSmsContexto $contexto, array $situacoes): string
    {
        return view('colaboradores-eleitorais.convocacoes-sms.dashboard', [
            'contexto' => $contexto,
            'filtros' => ['zona' => '4'],
            'territorios' => ['zonas' => ['4'], 'municipios' => []],
            'pessoas_nomeadas' => 10,
            'confirmacoes_convoca_mais' => 3,
            'nao_confirmados_convoca_mais' => 7,
            'enviados' => 6,
            'entregues' => 4,
            'nao_entregues' => 1,
            'confirmados_ja_comunicados' => 2,
            'confirmados_ja_comunicados_titulo_net' => 1,
            'confirmados_ja_comunicados_presencial' => 1,
            'por_situacao' => $situacoes,
            'evolucao_diaria' => [],
            'por_zona' => [],
            'errors' => new ViewErrorBag,
        ])->render();
    }

    private function contexto(bool $gestor): ConvocacaoSmsContexto
    {
        return new ConvocacaoSmsContexto(
            1, 1, '1', '3220', '2026-10-04', 'teste', 'Teste',
            $gestor, false, ['4'], false,
        );
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSDASHBOARDVIEWTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsDestinatarioAgrupadorTest.php`
## <TESTS_UNIT_CONVOCACAOSMSDESTINATARIOAGRUPADORTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsDestinatarioAgrupadorTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsDestinatarioAgrupadorTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_consolida_atribuicoes_por_inscricao_e_zona_em_uma_pessoa(): void
public function test_descarta_convocado_e_atribuido_mesmo_se_injetados_fora_da_query(): void
public function test_sem_celular_valido_e_visivel_mas_nao_selecionavel(): void
public function test_expoe_normalizacao_do_telefone_efetivamente_escolhido(): void
public function test_consolidacao_preserva_diagnostico_quando_todas_as_fontes_sao_invalidas(): void
public function test_sms_aceito_aparece_como_ja_comunicado_e_elegivel_para_outro_modelo(): void
public function test_sms_pendente_continua_elegivel_para_outro_modelo(): void
public function test_sms_enviado_confirmado_e_exposto_como_entregue_sem_perder_status_tecnico(): void
public function test_sms_nao_entregue_confirmado_e_exposto_como_entregue_sem_perder_status_tecnico(): void
public function test_consolida_confirmacao_do_elo_com_precedencia_e_datas_por_nomeacao(): void
public function test_confirmacao_presencial_tambem_permite_modelo_novo(): void
public function test_distingue_resposta_negativa_de_ausencia_de_resposta_sem_alterar_selecao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ConvocacaoSmsDestinatarioAgrupador;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\ConvocacaoSmsTelefone;
use Tests\TestCase;

class ConvocacaoSmsDestinatarioAgrupadorTest extends TestCase
{
    public function test_consolida_atribuicoes_por_inscricao_e_zona_em_uma_pessoa(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([
            (object) [
                'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
                'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
                'num_secao' => '001', 'des_funcao_eleitoral' => 'Presidente',
                'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
                'status_codigo' => null, 'envio_id' => null,
            ],
            (object) [
                'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
                'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
                'num_secao' => '002', 'des_funcao_eleitoral' => 'Mesário',
                'des_ind_situacao_pe' => ' nomeado ', 'telefone_perfil' => '(68) 99999-1111',
                'status_codigo' => null, 'envio_id' => null,
            ],
        ]);

        $this->assertCount(1, $itens);
        $this->assertSame('A_COMUNICAR', $itens[0]['situacao_comunicacao']);
        $this->assertSame('5568999991111', $itens[0]['telefone_e164']);
        $this->assertSame('Telefone válido sem normalização', $itens[0]['telefone_diagnostico']);
        $this->assertSame(['001', '002'], $itens[0]['secoes']);
        $this->assertCount(2, $itens[0]['atribuicoes']);
    }

    public function test_descarta_convocado_e_atribuido_mesmo_se_injetados_fora_da_query(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([
            (object) [
                'num_inscricao' => '123',
                'num_zona' => '1',
                'des_ind_situacao_pe' => 'CONVOCADO',
            ],
            (object) [
                'num_inscricao' => '456',
                'num_zona' => '1',
                'des_ind_situacao_pe' => 'ATRIBUIDO',
            ],
        ]);

        $this->assertSame([], $itens);
    }

    public function test_expõe_telefone_manual_efetivo_e_o_fallback_da_carga(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_manual' => '68969998888',
            'telefone_perfil' => '(68) 99999-1111', 'status_codigo' => null, 'envio_id' => null,
        ]]);

        $this->assertSame('68969998888', $itens[0]['telefone_nacional']);
        $this->assertSame('telefone_manual', $itens[0]['telefone_fonte']);
        $this->assertTrue($itens[0]['telefone_manual_ativo']);
        $this->assertSame('68999991111', $itens[0]['telefone_carga_nacional']);
    }

    public function test_sem_celular_valido_e_visivel_mas_nao_selecionavel(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 3222-1111',
            'status_codigo' => null, 'envio_id' => null,
        ]]);

        $this->assertSame('SEM_CELULAR_VALIDO', $itens[0]['situacao_comunicacao']);
        $this->assertFalse($itens[0]['selecionavel']);
        $this->assertSame('SOMENTE_TELEFONE_FIXO', $itens[0]['telefone_diagnostico_codigo']);
        $this->assertSame('Somente telefone fixo', $itens[0]['telefone_diagnostico']);
    }

    public function test_expoe_normalizacao_do_telefone_efetivamente_escolhido(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '+55 68 6999-8888',
            'status_codigo' => null, 'envio_id' => null,
        ]]);

        $this->assertSame('68969998888', $itens[0]['telefone_nacional']);
        $this->assertSame(
            'PREFIXO_55_REMOVIDO+NONO_DIGITO_INFERIDO',
            $itens[0]['telefone_normalizacao_codigo'],
        );
        $this->assertSame(
            'Prefixo 55 removido e nono dígito inferido',
            $itens[0]['telefone_normalizacao'],
        );
        $this->assertSame($itens[0]['telefone_normalizacao'], $itens[0]['telefone_diagnostico']);
    }

    public function test_consolidacao_preserva_diagnostico_quando_todas_as_fontes_sao_invalidas(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([
            (object) [
                'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
                'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
                'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 3222-1111',
                'status_codigo' => null, 'envio_id' => null,
            ],
            (object) [
                'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
                'num_secao' => '002', 'des_funcao_eleitoral' => 'Presidente',
                'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '12345-6789',
                'status_codigo' => null, 'envio_id' => null,
            ],
        ]);

        $this->assertCount(1, $itens);
        $this->assertSame('SEM_CELULAR_VALIDO', $itens[0]['situacao_comunicacao']);
        $this->assertSame('NUMERO_LOCAL_NAO_NORMALIZAVEL', $itens[0]['telefone_diagnostico_codigo']);
        $this->assertSame('Número local sem DDD não normalizável', $itens[0]['telefone_diagnostico']);
    }

    public function test_sms_aceito_aparece_como_ja_comunicado_e_elegivel_para_outro_modelo(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
            'status_codigo' => 'ACEITO', 'envio_id' => 77,
        ]]);

        $this->assertSame('JA_COMUNICADO', $itens[0]['situacao_comunicacao']);
        $this->assertTrue($itens[0]['selecionavel']);
        $this->assertSame(77, $itens[0]['envio_id']);
    }

    public function test_sms_pendente_continua_elegivel_para_outro_modelo(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
            'status_codigo' => 'PENDENTE', 'envio_id' => 78,
        ]]);

        $this->assertSame('PENDENTE', $itens[0]['situacao_comunicacao']);
        $this->assertTrue($itens[0]['selecionavel']);
        $this->assertSame(78, $itens[0]['envio_id']);
    }

    public function test_sms_enviado_confirmado_e_exposto_como_entregue_sem_perder_status_tecnico(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
            'status_codigo' => 'ENVIADO', 'envio_id' => 77,
            'resposta_elo' => 'SIM', 'origem_resposta_elo' => 'TITULONET',
        ]]);

        $this->assertSame('ENVIADO', $itens[0]['status_codigo']);
        $this->assertSame('ENTREGUE', $itens[0]['status_codigo_efetivo']);
        $this->assertTrue($itens[0]['entrega_inferida_convoca_mais']);
        $this->assertSame('JA_COMUNICADO', $itens[0]['situacao_comunicacao']);
    }

    public function test_sms_nao_entregue_confirmado_e_exposto_como_entregue_sem_perder_status_tecnico(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
            'status_codigo' => 'NAO_ENTREGUE', 'envio_id' => 77,
            'resposta_elo' => 'SIM', 'origem_resposta_elo' => 'PRESENCIAL',
        ]]);

        $this->assertSame('NAO_ENTREGUE', $itens[0]['status_codigo']);
        $this->assertSame('ENTREGUE', $itens[0]['status_codigo_efetivo']);
        $this->assertTrue($itens[0]['entrega_inferida_convoca_mais']);
        $this->assertSame('JA_COMUNICADO', $itens[0]['situacao_comunicacao']);
    }

    public function test_consolida_confirmacao_do_elo_com_precedencia_e_datas_por_nomeacao(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([
            (object) [
                'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
                'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
                'num_secao' => '001', 'des_funcao_eleitoral' => 'Presidente',
                'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
                'resposta_elo' => 'NAO', 'origem_resposta_elo' => 'PRESENCIAL',
                'data_convocacao_elo' => '2026-04-14 15:04:26',
                'data_resposta_elo' => '2026-04-20 10:00:00',
            ],
            (object) [
                'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
                'nom_localidade' => 'Rio Branco', 'num_local' => '10', 'nom_local' => 'Escola A',
                'num_secao' => '002', 'des_funcao_eleitoral' => 'Mesário',
                'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
                'resposta_elo' => 'SIM', 'origem_resposta_elo' => 'TITULONET',
                'data_convocacao_elo' => '2026-05-02 09:30:00',
                'data_resposta_elo' => '2026-05-03 11:45:00',
            ],
        ]);

        $this->assertCount(1, $itens);
        $this->assertSame('CONFIRMADO', $itens[0]['confirmacao_elo_codigo']);
        $this->assertSame('Confirmado', $itens[0]['confirmacao_elo']);
        $this->assertSame('Título Net', $itens[0]['origem_resposta_elo']);
        $this->assertSame('03/05/2026 11:45', $itens[0]['data_resposta_elo']);
        $this->assertSame(
            ['14/04/2026 15:04', '02/05/2026 09:30'],
            array_column($itens[0]['atribuicoes'], 'data_convocacao_elo'),
        );
        $this->assertStringContainsString('Convocado em 14/04/2026 15:04', $itens[0]['resumo_convocacoes']);
        $this->assertStringContainsString('Título Net', $itens[0]['confirmacao_elo_resumo']);
        $this->assertArrayNotHasKey('confirmacao_elo_bloqueia_envio', $itens[0]);
        $this->assertTrue($itens[0]['selecionavel']);
    }

    public function test_confirmacao_presencial_tambem_permite_modelo_novo(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '123', 'num_zona' => '1', 'nom_eleitor' => 'Maria',
            'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
            'resposta_elo' => 'SIM', 'origem_resposta_elo' => 'PRESENCIAL',
        ]]);

        $this->assertSame('CONFIRMADO', $itens[0]['confirmacao_elo_codigo']);
        $this->assertSame('Presencial', $itens[0]['origem_resposta_elo']);
        $this->assertArrayNotHasKey('confirmacao_elo_bloqueia_envio', $itens[0]);
        $this->assertTrue($itens[0]['selecionavel']);
    }

    public function test_distingue_resposta_negativa_de_ausencia_de_resposta_sem_alterar_selecao(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );
        $base = [
            'num_zona' => '1', 'nom_localidade' => 'Rio Branco', 'num_local' => '10',
            'nom_local' => 'Escola A', 'num_secao' => '001', 'des_funcao_eleitoral' => 'Mesário',
            'des_ind_situacao_pe' => 'NOMEADO', 'telefone_perfil' => '(68) 99999-1111',
        ];

        $itens = $agrupador->agrupar([
            (object) ($base + [
                'num_inscricao' => '123', 'nom_eleitor' => 'Maria', 'resposta_elo' => 'NAO',
                'origem_resposta_elo' => 'PRESENCIAL', 'data_resposta_elo' => '2026-05-03 11:45:00',
            ]),
            (object) ($base + [
                'num_inscricao' => '456', 'nom_eleitor' => 'João', 'resposta_elo' => null,
            ]),
        ]);

        $this->assertSame('NAO_CONFIRMOU', $itens[0]['confirmacao_elo_codigo']);
        $this->assertSame('Não confirmou', $itens[0]['confirmacao_elo']);
        $this->assertSame('AGUARDANDO', $itens[1]['confirmacao_elo_codigo']);
        $this->assertSame('Aguardando resposta', $itens[1]['confirmacao_elo']);
        $this->assertArrayNotHasKey('confirmacao_elo_bloqueia_envio', $itens[0]);
        $this->assertArrayNotHasKey('confirmacao_elo_bloqueia_envio', $itens[1]);
        $this->assertTrue($itens[0]['selecionavel']);
        $this->assertTrue($itens[1]['selecionavel']);
    }

    public function test_nomeacao_sem_local_permanece_selecionavel_e_resume_funcao_sem_dados_ficticios(): void
    {
        $agrupador = new ConvocacaoSmsDestinatarioAgrupador(
            new ConvocacaoSmsTelefone,
            new ConvocacaoSmsStatusService,
        );

        $itens = $agrupador->agrupar([(object) [
            'num_inscricao' => '004118932461',
            'num_zona' => '1',
            'nom_eleitor' => 'Eleitor de auditoria',
            'nom_localidade' => null,
            'num_local' => null,
            'nom_local' => null,
            'num_secao' => null,
            'des_funcao_eleitoral' => 'Auxiliar de Auditoria',
            'des_ind_situacao_pe' => 'NOMEADO',
            'telefone_perfil' => '68992056667',
            'data_convocacao_elo' => '2026-07-23 10:26:43',
        ]]);

        $this->assertCount(1, $itens);
        $this->assertSame('1', $itens[0]['zona']);
        $this->assertSame('', $itens[0]['municipio']);
        $this->assertTrue($itens[0]['nomeacao_sem_local']);
        $this->assertFalse($itens[0]['possui_local_votacao']);
        $this->assertSame(
            ['MUNICIPIO', 'NUMERO_LOCAL', 'LOCAL_VOTACAO', 'SECOES'],
            $itens[0]['campos_localizacao_indisponiveis'],
        );
        $this->assertSame('Auxiliar de Auditoria · Convocado em 23/07/2026 10:26', $itens[0]['resumo_convocacoes']);
        $this->assertStringNotContainsString('Local —', $itens[0]['resumo_convocacoes']);
        $this->assertSame('A_COMUNICAR', $itens[0]['situacao_comunicacao']);
        $this->assertTrue($itens[0]['selecionavel']);
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSDESTINATARIOAGRUPADORTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsDestinatarioPaginadoQueryTest.php`
## <TESTS_UNIT_CONVOCACAOSMSDESTINATARIOPAGINADOQUERYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsDestinatarioPaginadoQueryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsDestinatarioPaginadoQueryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$base = DB::table('origem')->select([
$base = DB::table('origem')->select([
$base = DB::table('origem')->select([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_ranqueia_por_pessoa_preserva_linhas_e_calcula_total_exato(): void
public function test_filtra_confirmacao_por_pessoa_antes_do_ranqueamento(): void
public function test_filtra_status_efetivo_antes_do_ranqueamento_e_do_total(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\Queries\ConvocacaoSmsDestinatarioPaginadoQuery;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class ConvocacaoSmsDestinatarioPaginadoQueryTest extends TestCase
{
    public function test_ranqueia_por_pessoa_preserva_linhas_e_calcula_total_exato(): void
    {
        $base = DB::table('origem')->select([
            'num_zona',
            'nom_localidade',
            'nom_eleitor',
            'num_inscricao',
            'num_secao',
            'resposta_elo',
        ]);

        $query = ConvocacaoSmsDestinatarioPaginadoQuery::criar($base, 51, 100);
        $sql = mb_strtoupper($query->toSql(), 'UTF-8');

        $this->assertStringContainsString('DENSE_RANK() OVER', $sql);
        $this->assertStringContainsString('PARTITION BY NUM_ZONA, NUM_INSCRICAO', $sql);
        $this->assertStringContainsString('MAX(DESTINATARIO_RANK) OVER () AS DESTINATARIOS_TOTAL', $sql);
        $this->assertStringContainsString('"DESTINATARIO_RANK" BETWEEN ? AND ?', $sql);
        $this->assertSame([51, 100], $query->getBindings());
    }

    public function test_filtra_confirmacao_por_pessoa_antes_do_ranqueamento(): void
    {
        $base = DB::table('origem')->select([
            'num_zona', 'nom_localidade', 'nom_eleitor', 'num_inscricao', 'num_secao', 'resposta_elo',
        ]);

        $confirmados = ConvocacaoSmsDestinatarioPaginadoQuery::criar($base, 1, 50, 'CONFIRMADO');
        $naoConfirmados = ConvocacaoSmsDestinatarioPaginadoQuery::criar($base, 1, 50, 'NAO_CONFIRMADO');
        $sql = mb_strtoupper($confirmados->toSql(), 'UTF-8');
        $sqlSemAliasExplicito = str_replace(' AS "', ' "', $sql);

        $this->assertStringContainsString("MAX(CASE WHEN UPPER(TRIM(RESPOSTA_ELO)) = 'SIM' THEN 1 ELSE 0 END) OVER", $sql);
        $this->assertStringContainsString('PARTITION BY NUM_ZONA, NUM_INSCRICAO', $sql);
        $this->assertGreaterThan(strpos($sql, 'DENSE_RANK() OVER'), strpos($sql, '"CONFIRMADO_ELO" = ?'));
        $this->assertStringContainsString(
            '"SMS_CONFIRMACAO" WHERE "CONFIRMADO_ELO" = ?) "SMS_CANONICA"',
            $sqlSemAliasExplicito,
        );
        $this->assertSame([1, 1, 50], $confirmados->getBindings());
        $this->assertSame([0, 1, 50], $naoConfirmados->getBindings());
    }

    public function test_filtra_status_efetivo_antes_do_ranqueamento_e_do_total(): void
    {
        $base = DB::table('origem')->select([
            'num_zona', 'nom_localidade', 'nom_eleitor', 'num_inscricao', 'num_secao',
            'resposta_elo', 'status_codigo',
        ]);

        $entregues = ConvocacaoSmsDestinatarioPaginadoQuery::criar($base, 1, 50, '', 'ENTREGUE');
        $enviados = ConvocacaoSmsDestinatarioPaginadoQuery::criar($base, 1, 50, '', 'ENVIADO');
        $naoEntregues = ConvocacaoSmsDestinatarioPaginadoQuery::criar($base, 1, 50, '', 'NAO_ENTREGUE');
        $sql = mb_strtoupper($entregues->toSql(), 'UTF-8');

        $this->assertStringContainsString(
            "CASE WHEN STATUS_CODIGO IN ('ENVIADO', 'NAO_ENTREGUE') AND CONFIRMADO_ELO = 1 THEN 'ENTREGUE' ELSE STATUS_CODIGO END",
            $sql,
        );
        $this->assertGreaterThan(strpos($sql, 'DENSE_RANK() OVER'), strpos($sql, 'STATUS_CODIGO_EFETIVO'));
        $this->assertSame(['ENTREGUE', 1, 50], $entregues->getBindings());
        $this->assertSame(['ENVIADO', 1, 50], $enviados->getBindings());
        $this->assertSame(['NAO_ENTREGUE', 1, 50], $naoEntregues->getBindings());
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSDESTINATARIOPAGINADOQUERYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsEnvioRepositoryTest.php`
## <TESTS_UNIT_CONVOCACAOSMSENVIOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsEnvioRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsEnvioRepositoryTest extends TestCase`

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
public function test_reserva_persiste_municipio_ausente_como_nulo(): void
public function test_reserva_limita_municipio_presente_a_160_caracteres(): void
public function test_colisao_crua_do_driver_oracle_e_tratada_como_reserva_indisponivel(): void
public function test_erro_oracle_desconhecido_continua_sendo_propagado(): void
private function prepararPersistencia(?string $municipioEsperado): void
private function dados(array $sobrescritas = []): array
private function repository(): ConvocacaoSmsEnvioRepository
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Repositories\ConvocacaoSms\ConvocacaoSmsEnvioRepository;
use App\Services\Auditoria\AuditLogService;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use Illuminate\Support\Facades\DB;
use Mockery;
use Mockery\MockInterface;
use Tests\TestCase;
use Yajra\Pdo\Oci8\Exceptions\Oci8Exception;

class ConvocacaoSmsEnvioRepositoryTest extends TestCase
{
    private MockInterface $auditoria;

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->byDefault()->andReturnUsing(static fn (mixed $valor): mixed => $valor);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());

        $this->auditoria = Mockery::mock(AuditLogRepositoryInterface::class);
        $this->app->instance(AuditLogRepositoryInterface::class, $this->auditoria);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_reserva_persiste_municipio_ausente_como_nulo(): void
    {
        $this->prepararPersistencia(null);

        $id = $this->repository()->reservarEnvio($this->dados(['municipio' => '   ']));

        $this->assertSame(15, $id);
    }

    public function test_reserva_limita_municipio_presente_a_160_caracteres(): void
    {
        $municipio = str_repeat('A', 170);
        $this->prepararPersistencia(str_repeat('A', 160));

        $id = $this->repository()->reservarEnvio($this->dados(['municipio' => $municipio]));

        $this->assertSame(15, $id);
    }

    public function test_colisao_crua_do_driver_oracle_e_tratada_como_reserva_indisponivel(): void
    {
        $envioInsert = Mockery::mock();
        $envioInsert->shouldReceive('insertGetId')
            ->once()
            ->andThrow(new Oci8Exception(<<<'ERRO'
Error Code    : 1
Error Message : ORA-00001: unique constraint (PLANELEITO.UX_CE_SMS_ENVIO_DESTINO) violated
ERRO));
        DB::shouldReceive('table')->once()->with('ce_sms_envio')->andReturn($envioInsert);

        $this->assertNull($this->repository()->reservarEnvio($this->dados()));
    }

    public function test_erro_oracle_desconhecido_continua_sendo_propagado(): void
    {
        $envioInsert = Mockery::mock();
        $envioInsert->shouldReceive('insertGetId')
            ->once()
            ->andThrow(new Oci8Exception(<<<'ERRO'
Error Code    : 942
Error Message : ORA-00942: table or view does not exist
ERRO));
        DB::shouldReceive('table')->once()->with('ce_sms_envio')->andReturn($envioInsert);

        $this->expectException(Oci8Exception::class);

        $this->repository()->reservarEnvio($this->dados());
    }

    private function prepararPersistencia(?string $municipioEsperado): void
    {
        $this->auditoria->shouldReceive('inserir')->twice();
        $envioInsert = Mockery::mock();
        $envioInsert->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(
                static fn (array $dados): bool => array_key_exists('municipio', $dados)
                    && $dados['municipio'] === $municipioEsperado,
            ))
            ->andReturn(15);

        $envioDepois = Mockery::mock();
        $envioDepois->shouldReceive('where')->once()->with('id', 15)->andReturnSelf();
        $envioDepois->shouldReceive('first')->once()->andReturn((object) [
            'id' => 15,
            'municipio' => $municipioEsperado,
            'status_codigo' => 'PENDENTE',
        ]);

        $eventoInsert = Mockery::mock();
        $eventoInsert->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(
                static fn (array $dados): bool => $dados['envio_id'] === 15
                    && $dados['status_novo'] === 'PENDENTE',
            ))
            ->andReturn(91);

        $eventoDepois = Mockery::mock();
        $eventoDepois->shouldReceive('where')->once()->with('id', 91)->andReturnSelf();
        $eventoDepois->shouldReceive('first')->once()->andReturn((object) [
            'id' => 91,
            'envio_id' => 15,
            'status_novo' => 'PENDENTE',
        ]);

        DB::shouldReceive('table')->with('ce_sms_envio')->twice()->andReturn($envioInsert, $envioDepois);
        DB::shouldReceive('table')->with('ce_sms_envio_evento')->twice()->andReturn($eventoInsert, $eventoDepois);
    }

    /** @param array<string, mixed> $sobrescritas */
    private function dados(array $sobrescritas = []): array
    {
        return array_replace([
            'lote_id' => 10,
            'modelo_id' => 20,
            'macroprojeto_turno_id' => 30,
            'num_inscricao' => '004118932461',
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
            'num_zona' => '1',
            'municipio' => '',
            'nome' => 'Eleitor sem local',
            'telefone_e164' => '5568999999999',
            'telefone_fonte' => 'telefone_perfil',
            'sender' => 'device-1',
            'provider_codigo' => 'TEXTBEE',
            'provider_device_id' => 'device-1',
            'provider_sim_subscription_id' => null,
            'atribuicoes_json' => '[]',
            'mensagem_texto' => 'TRE-AC: mensagem de teste.',
            'encoding' => 'GSM-7',
            'segmentos' => 1,
            'external_id' => '123e4567-e89b-42d3-a456-426614174099',
            'payload_hash' => str_repeat('a', 64),
        ], $sobrescritas);
    }

    private function repository(): ConvocacaoSmsEnvioRepository
    {
        return new ConvocacaoSmsEnvioRepository(
            app(AuditLogService::class),
            new ConvocacaoSmsStatusService,
        );
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSENVIOREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsFiltroRequestTest.php`
## <TESTS_UNIT_CONVOCACAOSMSFILTROREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsFiltroRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsFiltroRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aceita_funcao_do_catalogo_eleitoral(): void
public function rejeita_funcao_que_nao_pertence_ao_catalogo(): void
public function aceita_somente_os_filtros_binarios_de_confirmacao_do_elo(): void
public function normaliza_confirmacao_do_elo_para_o_codigo_canonico(): void
public function aceita_somente_identificador_positivo_de_turma_de_treinamento(): void
public function normaliza_espacos_do_identificador_da_turma_sem_confiar_no_frontend(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsFiltroRequest;
use Illuminate\Support\Facades\Validator;
use PHPUnit\Framework\Attributes\Test;
use ReflectionMethod;
use Tests\TestCase;

class ConvocacaoSmsFiltroRequestTest extends TestCase
{
    #[Test]
    public function aceita_funcao_do_catalogo_eleitoral(): void
    {
        $validator = Validator::make([
            'funcao' => 'Presidente',
        ], (new ConvocacaoSmsFiltroRequest)->rules());

        $this->assertFalse($validator->fails(), $validator->errors()->first());
    }

    #[Test]
    public function rejeita_funcao_que_nao_pertence_ao_catalogo(): void
    {
        $validator = Validator::make([
            'funcao' => 'Função forjada',
        ], (new ConvocacaoSmsFiltroRequest)->rules());

        $this->assertTrue($validator->fails());
        $this->assertArrayHasKey('funcao', $validator->errors()->toArray());
    }

    #[Test]
    public function aceita_somente_os_filtros_binarios_de_confirmacao_do_elo(): void
    {
        $regras = (new ConvocacaoSmsFiltroRequest)->rules();

        foreach (['CONFIRMADO', 'NAO_CONFIRMADO', null] as $valor) {
            $this->assertFalse(Validator::make(['confirmacao_elo' => $valor], $regras)->fails());
        }
        $this->assertTrue(Validator::make(['confirmacao_elo' => 'AGUARDANDO'], $regras)->fails());
    }

    #[Test]
    public function normaliza_confirmacao_do_elo_para_o_codigo_canonico(): void
    {
        $request = ConvocacaoSmsFiltroRequest::create('/', 'GET', [
            'confirmacao_elo' => ' nao_confirmado ',
        ]);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $this->assertSame('NAO_CONFIRMADO', $request->input('confirmacao_elo'));
    }

    #[Test]
    public function aceita_somente_identificador_positivo_de_turma_de_treinamento(): void
    {
        $regras = (new ConvocacaoSmsFiltroRequest)->rules();

        $this->assertArrayHasKey('turma_id', $regras);
        $this->assertFalse(Validator::make(['turma_id' => '42'], $regras)->fails());
        $this->assertTrue(Validator::make(['turma_id' => '0'], $regras)->fails());
        $this->assertTrue(Validator::make(['turma_id' => 'turma-forjada'], $regras)->fails());
    }

    #[Test]
    public function normaliza_espacos_do_identificador_da_turma_sem_confiar_no_frontend(): void
    {
        $request = ConvocacaoSmsFiltroRequest::create('/', 'GET', [
            'turma_id' => ' 42 ',
        ]);

        (new ReflectionMethod($request, 'prepareForValidation'))->invoke($request);

        $this->assertSame('42', $request->input('turma_id'));
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSFILTROREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsJanelaEnvioTest.php`
## <TESTS_UNIT_CONVOCACAOSMSJANELAENVIOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsJanelaEnvioTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsJanelaEnvioTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_calcula_a_proxima_abertura_no_fuso_da_aplicacao(string $instante, int $espera): void
public static function limitesDaJanela(): array
public function test_converte_o_instante_recebido_para_o_fuso_da_aplicacao(): void
public function test_configuracao_invalida_falha_fechada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ConvocacaoSmsJanelaConfiguracaoInvalidaException;
use App\Services\ConvocacaoSms\ConvocacaoSmsJanelaEnvio;
use Carbon\CarbonImmutable;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

class ConvocacaoSmsJanelaEnvioTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('app.timezone', 'America/Rio_Branco');
        config()->set('planeleito.convocacao_sms.sending_start', '07:00');
        config()->set('planeleito.convocacao_sms.sending_end', '18:00');
    }

    #[DataProvider('limitesDaJanela')]
    public function test_calcula_a_proxima_abertura_no_fuso_da_aplicacao(string $instante, int $espera): void
    {
        $agora = CarbonImmutable::parse($instante, 'America/Rio_Branco');

        $this->assertSame($espera, (new ConvocacaoSmsJanelaEnvio)->segundosAteAbertura($agora));
    }

    /** @return array<string, array{string, int}> */
    public static function limitesDaJanela(): array
    {
        return [
            'segunda antes da abertura' => ['2026-08-17 06:59:59', 1],
            'segunda na abertura' => ['2026-08-17 07:00:00', 0],
            'segunda antes do fechamento' => ['2026-08-17 17:59:59', 0],
            'segunda no fechamento' => ['2026-08-17 18:00:00', 46_800],
            'sabado aberto' => ['2026-08-15 12:00:00', 0],
            'domingo fechado' => ['2026-08-16 23:00:00', 28_800],
        ];
    }

    public function test_converte_o_instante_recebido_para_o_fuso_da_aplicacao(): void
    {
        $meioDiaUtc = CarbonImmutable::parse('2026-08-17 12:00:00', 'UTC');

        $this->assertSame(0, (new ConvocacaoSmsJanelaEnvio)->segundosAteAbertura($meioDiaUtc));
    }

    public function test_configuracao_invalida_falha_fechada(): void
    {
        config()->set('planeleito.convocacao_sms.sending_start', '7h');

        $this->expectException(ConvocacaoSmsJanelaConfiguracaoInvalidaException::class);

        (new ConvocacaoSmsJanelaEnvio)->segundosAteAbertura(
            CarbonImmutable::parse('2026-08-17 12:00:00', 'America/Rio_Branco'),
        );
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSJANELAENVIOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsLoteServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSLOTESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsLoteServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsLoteServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_container_injeta_transacao_composta_obrigatoria(): void
public function test_cria_lote_parcial_grava_snapshot_do_sms_e_enfileira_job(): void
public function test_uuid_repetido_retorna_lote_existente_sem_novo_envio(): void
public function test_corrida_de_uuid_rebusca_lote_que_venceu_a_concorrencia(): void
public function test_operador_cria_novo_envio_para_comunicado_com_modelo_ainda_nao_usado(): void
public function test_operador_cria_novo_envio_quando_outro_modelo_esta_pendente(): void
public function test_operador_nao_reserva_modelo_ja_utilizado_por_payload_reidratado(): void
public function test_gestor_nao_reserva_novo_envio_sem_celular_atual_valido(): void
public function test_mesmo_modelo_continua_bloqueado_apos_troca_de_telefone(): void
public function test_confirmado_no_elo_recebe_modelo_ainda_nao_utilizado(): void
public function test_modelo_que_exige_local_recusa_nomeacao_sem_local_com_motivo_proprio(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Services\ConvocacaoSms\ConvocacaoSmsLoteDuplicadoException;
use App\Services\ConvocacaoSms\ConvocacaoSmsLoteService;
use App\Services\ConvocacaoSms\ConvocacaoSmsMensagem;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\ConvocacaoSmsTelefone;
use App\Services\ConvocacaoSms\ConvocacaoSmsTransacao;
use Illuminate\Support\Facades\Queue;
use Mockery;
use Tests\TestCase;

class ConvocacaoSmsLoteServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_container_injeta_transacao_composta_obrigatoria(): void
    {
        $service = app(ConvocacaoSmsLoteService::class);
        $propriedade = new \ReflectionProperty($service, 'transacao');

        $this->assertInstanceOf(ConvocacaoSmsTransacao::class, $propriedade->getValue($service));
    }

    public function test_cria_lote_parcial_grava_snapshot_do_sms_e_enfileira_job(): void
    {
        Queue::fake();
        config()->set('planeleito.sms_textbee.device_id', 'device-1');
        config()->set('planeleito.sms_textbee.sim_subscription_id', 2);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $contexto = $this->contexto();
        $telefone = (new ConvocacaoSmsTelefone)->selecionar([
            'telefone_perfil' => '+55 68 6999-8888',
        ]);

        $this->assertSame('5568969998888', $telefone['e164'] ?? null);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->with(3, '1', $contexto)->andReturn([
            'id' => 3,
            'texto_modelo' => 'TRE-AC: Olá {{NOME}}. Seções: {{SECOES}}.',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'zona' => '1', 'municipio' => 'Rio Branco', 'nome' => 'Maria',
                'telefone_e164' => $telefone['e164'], 'telefone_fonte' => $telefone['fonte'],
                'atribuicoes' => [['secao' => '001', 'funcao' => 'Mesário']],
                'situacao_comunicacao' => 'A_COMUNICAR', 'selecionavel' => true,
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(5);
        $envios->shouldReceive('reservarEnvio')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['num_inscricao'] === '111'
                && $dados['status_codigo'] === 'PENDENTE'
                && $dados['telefone_e164'] === '5568969998888'
                && $dados['telefone_fonte'] === 'telefone_perfil'
                && $dados['sender'] === 'TEXTBEE:device-1:2'
                && $dados['provider_codigo'] === 'TEXTBEE'
                && $dados['provider_device_id'] === 'device-1'
                && $dados['provider_sim_subscription_id'] === 2
                && $dados['mensagem_texto'] === 'TRE-AC: Olá Maria. Seções: 001.'
                && $dados['encoding'] === 'UCS-2'
                && $dados['segmentos'] === 1
                && preg_match('/^[0-9a-f-]{36}$/', $dados['external_id']) === 1
                && strlen($dados['payload_hash']) === 64,
        ))->andReturn(10);
        $envios->shouldReceive('registrarItemLote')->twice()->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(5, 2, 1, 1);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174000',
            'modelo_id' => 3,
            'zona' => '1',
            'num_inscricoes' => ['111', '222'],
        ], $contexto);

        $this->assertSame(['lote_id' => 5, 'selecionados' => 2, 'enfileirados' => 1, 'ignorados' => 1, 'duplicado' => false], $resultado);
        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 10);
    }

    public function test_uuid_repetido_retorna_lote_existente_sem_novo_envio(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturn([
            'id' => 5, 'total_selecionados' => 2, 'total_enfileirados' => 1, 'total_ignorados' => 1,
        ]);
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174000',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111', '222'],
        ], $this->contexto());

        $this->assertTrue($resultado['duplicado']);
        Queue::assertNothingPushed();
    }

    public function test_corrida_de_uuid_rebusca_lote_que_venceu_a_concorrencia(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $envios->shouldReceive('buscarLotePorUuid')->twice()->andReturn(
            null,
            ['id' => 8, 'total_selecionados' => 1, 'total_enfileirados' => 1, 'total_ignorados' => 0],
        );
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'texto_modelo' => 'TRE-AC: Olá {{NOME}}.',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'nome' => 'Maria', 'selecionavel' => true,
                'situacao_comunicacao' => 'A_COMUNICAR',
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andThrow(new ConvocacaoSmsLoteDuplicadoException);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174000',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $this->contexto());

        $this->assertSame(8, $resultado['lote_id']);
        $this->assertTrue($resultado['duplicado']);
        Queue::assertNothingPushed();
    }

    public function test_operador_cria_novo_envio_para_comunicado_com_modelo_ainda_nao_usado(): void
    {
        Queue::fake();
        config()->set('planeleito.sms_textbee.device_id', 'device-1');
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $contexto = $this->contexto(false);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'texto_modelo' => 'TRE-AC: Nova convocação de {{NOME}}.',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'zona' => '1', 'municipio' => 'Rio Branco',
                'nome' => 'Maria', 'telefone_e164' => '5568999991111',
                'telefone_fonte' => 'telefone_perfil', 'atribuicoes' => [],
                'situacao_comunicacao' => 'JA_COMUNICADO', 'selecionavel' => true,
                'modelos_ja_utilizados' => [2],
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(6);
        $envios->shouldReceive('reservarEnvio')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['num_inscricao'] === '111'
                && $dados['status_codigo'] === 'PENDENTE',
        ))->andReturn(12);
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === 12 && $dados['enfileirado'] === 1,
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(6, 1, 1, 0);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174001',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $contexto);

        $this->assertSame(1, $resultado['enfileirados']);
        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 12);
    }

    public function test_operador_cria_novo_envio_quando_outro_modelo_esta_pendente(): void
    {
        Queue::fake();
        config()->set('planeleito.sms_textbee.device_id', 'device-1');
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $contexto = $this->contexto(false);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'texto_modelo' => 'TRE-AC: Lembrete para {{NOME}}.',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'zona' => '1', 'municipio' => 'Rio Branco',
                'nome' => 'Maria', 'telefone_e164' => '5568999991111',
                'telefone_fonte' => 'telefone_perfil', 'atribuicoes' => [],
                'situacao_comunicacao' => 'PENDENTE', 'selecionavel' => true,
                'modelos_ja_utilizados' => [2],
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(16);
        $envios->shouldReceive('reservarEnvio')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['modelo_id'] === 3
                && $dados['num_inscricao'] === '111',
        ))->andReturn(21);
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === 21 && $dados['enfileirado'] === 1,
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(16, 1, 1, 0);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174010',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $contexto);

        $this->assertSame(1, $resultado['enfileirados']);
        $this->assertSame(0, $resultado['ignorados']);
        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 21);
    }

    public function test_operador_nao_reserva_modelo_ja_utilizado_por_payload_reidratado(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn(['texto_modelo' => 'TRE-AC: {{NOME}}.']);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'nome' => 'Maria', 'situacao_comunicacao' => 'JA_COMUNICADO',
                'telefone_e164' => '5568999991111', 'telefone_fonte' => 'telefone_perfil',
                'atribuicoes' => [], 'selecionavel' => true, 'modelos_ja_utilizados' => [3],
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(7);
        $envios->shouldNotReceive('reservarEnvio');
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['motivo_codigo'] === 'MODELO_JA_UTILIZADO'
                && str_contains($dados['motivo_detalhe'], 'modelo selecionado'),
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(7, 1, 0, 1);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174002',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $this->contexto(false));

        $this->assertSame(0, $resultado['enfileirados']);
        $this->assertSame(1, $resultado['ignorados']);
        Queue::assertNothingPushed();
    }

    public function test_gestor_nao_reserva_novo_envio_sem_celular_atual_valido(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn(['texto_modelo' => 'TRE-AC: {{NOME}}.']);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'nome' => 'Maria', 'telefone_e164' => null,
                'situacao_comunicacao' => 'JA_COMUNICADO', 'selecionavel' => true,
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(8);
        $envios->shouldNotReceive('reservarEnvio');
        $envios->shouldReceive('registrarItemLote')->once()->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(8, 1, 0, 1);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174003',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $this->contexto(true));

        $this->assertSame(0, $resultado['enfileirados']);
        Queue::assertNothingPushed();
    }

    public function test_mesmo_modelo_continua_bloqueado_apos_troca_de_telefone(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn(['texto_modelo' => 'TRE-AC: {{NOME}}.']);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'nome' => 'Maria',
                'telefone_e164' => '5568999991111', 'telefone_fonte' => 'telefone_manual',
                'atribuicoes' => [],
                'situacao_comunicacao' => 'JA_COMUNICADO', 'selecionavel' => true,
                'modelos_ja_utilizados' => [3],
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(9);
        $envios->shouldNotReceive('reservarEnvio');
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['motivo_codigo'] === 'MODELO_JA_UTILIZADO',
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(9, 1, 0, 1);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174004',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $this->contexto(true));

        $this->assertSame(0, $resultado['enfileirados']);
        $this->assertSame(1, $resultado['ignorados']);
        Queue::assertNothingPushed();
    }

    public function test_confirmado_no_elo_recebe_modelo_ainda_nao_utilizado(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn(['texto_modelo' => 'TRE-AC: {{NOME}}.']);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111', 'nome' => 'Maria',
                'telefone_e164' => '5568999991111', 'telefone_fonte' => 'telefone_perfil',
                'atribuicoes' => [],
                'situacao_comunicacao' => 'A_COMUNICAR', 'selecionavel' => true,
                'confirmacao_elo_codigo' => 'CONFIRMADO',
                'confirmacao_elo_bloqueia_envio' => true,
                'modelos_ja_utilizados' => [2],
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(10);
        $envios->shouldReceive('reservarEnvio')->once()->andReturn(13);
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === 13
                && $dados['enfileirado'] === 1,
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(10, 1, 1, 0);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174005',
            'modelo_id' => 3, 'zona' => '1', 'num_inscricoes' => ['111'],
        ], $this->contexto(true));

        $this->assertSame(1, $resultado['enfileirados']);
        $this->assertSame(0, $resultado['ignorados']);
        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 13);
    }

    public function test_modelo_que_exige_local_recusa_nomeacao_sem_local_com_motivo_proprio(): void
    {
        Queue::fake();
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'texto_modelo' => 'TRE-AC: {{NOME}}, compareca ao local {{LOCAL_VOTACAO}}.',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '004118932461' => [
                'num_inscricao' => '004118932461',
                'zona' => '1',
                'municipio' => '',
                'nome' => 'Eleitor de auditoria',
                'telefone_e164' => '5568992056667',
                'telefone_fonte' => 'telefone_perfil',
                'atribuicoes' => [[
                    'numero_local' => '', 'local_votacao' => '', 'secao' => '',
                    'funcao' => 'Auxiliar de Auditoria',
                ]],
                'local_votacao' => '',
                'possui_local_votacao' => false,
                'nomeacao_sem_local' => true,
                'situacao_comunicacao' => 'A_COMUNICAR',
                'selecionavel' => true,
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(11);
        $envios->shouldNotReceive('reservarEnvio');
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['motivo_codigo'] === 'MODELO_INCOMPATIVEL_SEM_LOCAL'
                && str_contains($dados['motivo_detalhe'], 'LOCAL_VOTACAO'),
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(11, 1, 0, 1);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174006',
            'modelo_id' => 3,
            'zona' => '1',
            'num_inscricoes' => ['004118932461'],
        ], $this->contexto());

        $this->assertSame(0, $resultado['enfileirados']);
        $this->assertSame(1, $resultado['ignorados']);
        Queue::assertNothingPushed();
    }

    public function test_modelo_baseado_em_funcao_reserva_nomeacao_sem_local(): void
    {
        Queue::fake();
        config()->set('planeleito.sms_textbee.device_id', 'device-1');
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);

        $envios->shouldReceive('buscarLotePorUuid')->once()->andReturnNull();
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'texto_modelo' => 'TRE-AC: {{NOME}}, sua função é {{FUNCOES}}.',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '004118932461' => [
                'num_inscricao' => '004118932461',
                'zona' => '1',
                'municipio' => '',
                'nome' => 'Eleitor de auditoria',
                'telefone_e164' => '5568992056667',
                'telefone_fonte' => 'telefone_perfil',
                'atribuicoes' => [[
                    'numero_local' => '', 'local_votacao' => '', 'secao' => '',
                    'funcao' => 'Auxiliar de Auditoria',
                ]],
                'funcoes' => ['Auxiliar de Auditoria'],
                'nomeacao_sem_local' => true,
                'situacao_comunicacao' => 'A_COMUNICAR',
                'selecionavel' => true,
            ],
        ]);
        $envios->shouldReceive('criarLote')->once()->andReturn(12);
        $envios->shouldReceive('reservarEnvio')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['mensagem_texto']
                === 'TRE-AC: Eleitor de auditoria, sua função é Auxiliar de Auditoria.',
        ))->andReturn(15);
        $envios->shouldReceive('registrarItemLote')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === 15 && $dados['enfileirado'] === 1,
        ))->andReturn(1);
        $envios->shouldReceive('atualizarTotaisLote')->once()->with(12, 1, 1, 0);

        $resultado = (new ConvocacaoSmsLoteService(
            $destinatarios,
            $modelos,
            $envios,
            new ConvocacaoSmsMensagem,
            new ConvocacaoSmsTransacao,
            new ConvocacaoSmsStatusService,
        ))->criar([
            'request_uuid' => '123e4567-e89b-42d3-a456-426614174007',
            'modelo_id' => 3,
            'zona' => '1',
            'num_inscricoes' => ['004118932461'],
        ], $this->contexto());

        $this->assertSame(1, $resultado['enfileirados']);
        $this->assertSame(0, $resultado['ignorados']);
        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 15);
    }

    private function contexto(bool $gestor = false): ConvocacaoSmsContexto
    {
        return new ConvocacaoSmsContexto(1, 9, '1', '3220', '2026-10-04', 'operador', 'Operador', $gestor, false, ['1'], false);
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSLOTESERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsMensagemTest.php`
## <TESTS_UNIT_CONVOCACAOSMSMENSAGEMTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsMensagemTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsMensagemTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_renderiza_campos_normaliza_espacos_e_calcula_gsm_7(): void
public function test_usa_ucs_2_quando_ha_caractere_fora_do_gsm_7(): void
public function test_caractere_estendido_gsm_conta_duas_unidades(): void
public function test_aceita_500_caracteres_e_preserva_segmentos_reais_por_encoding(): void
public function test_recusa_501_caracteres_sem_truncar(): void
public function test_recusa_prefixo_ausente_ou_campo_desconhecido(
public static function mensagensInvalidas(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ConvocacaoSmsMensagem;
use DomainException;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

class ConvocacaoSmsMensagemTest extends TestCase
{
    public function test_renderiza_campos_normaliza_espacos_e_calcula_gsm_7(): void
    {
        $resultado = (new ConvocacaoSmsMensagem)->renderizar(
            "TRE-AC:  Ola {{NOME}}\nZona {{ZONA}}",
            ['nome' => 'Maria', 'zona' => '1'],
        );

        $this->assertSame('TRE-AC: Ola Maria Zona 1', $resultado->texto);
        $this->assertSame('GSM-7', $resultado->encoding);
        $this->assertSame(1, $resultado->segmentos);
    }

    public function test_usa_ucs_2_quando_ha_caractere_fora_do_gsm_7(): void
    {
        $resultado = (new ConvocacaoSmsMensagem)->renderizar(
            'TRE-AC: Ola {{NOME}} 😀',
            ['nome' => 'Maria'],
        );

        $this->assertSame('UCS-2', $resultado->encoding);
        $this->assertSame(1, $resultado->segmentos);
    }

    public function test_caractere_estendido_gsm_conta_duas_unidades(): void
    {
        $resultado = (new ConvocacaoSmsMensagem)->analisar('TRE-AC: ^');

        $this->assertSame('GSM-7', $resultado->encoding);
        $this->assertSame(10, $resultado->unidades);
    }

    public function test_aceita_500_caracteres_e_preserva_segmentos_reais_por_encoding(): void
    {
        $gsm7 = (new ConvocacaoSmsMensagem)->analisar('TRE-AC: '.str_repeat('A', 492));
        $ucs2 = (new ConvocacaoSmsMensagem)->analisar('TRE-AC: '.str_repeat('á', 492));

        $this->assertSame(500, mb_strlen($gsm7->texto, 'UTF-8'));
        $this->assertSame('GSM-7', $gsm7->encoding);
        $this->assertSame(4, $gsm7->segmentos);
        $this->assertSame(500, mb_strlen($ucs2->texto, 'UTF-8'));
        $this->assertSame('UCS-2', $ucs2->encoding);
        $this->assertSame(8, $ucs2->segmentos);
    }

    public function test_recusa_501_caracteres_sem_truncar(): void
    {
        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('500 caracteres');

        (new ConvocacaoSmsMensagem)->analisar('TRE-AC: '.str_repeat('A', 493));
    }

    #[DataProvider('mensagensInvalidas')]
    public function test_recusa_prefixo_ausente_ou_campo_desconhecido(
        string $modelo,
        array $dados,
        string $mensagem,
    ): void {
        $this->expectException(DomainException::class);
        $this->expectExceptionMessage($mensagem);

        (new ConvocacaoSmsMensagem)->renderizar($modelo, $dados);
    }

    public static function mensagensInvalidas(): array
    {
        return [
            'prefixo' => ['Ola {{NOME}}', ['nome' => 'Maria'], 'TRE-AC:'],
            'campo' => ['TRE-AC: {{CPF}}', ['cpf' => '1'], 'Campo de modelo'],
        ];
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSMENSAGEMTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsMigrationContractTest.php`
## <TESTS_UNIT_CONVOCACAOSMSMIGRATIONCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsMigrationContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsMigrationContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$this->assertStringContainsString("DB::TABLE('CE_SMS_RESPOSTA')->COUNT()", $respostas);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_schema_sms_substitui_legado_com_preflight_e_rollback_planejado(): void
public function test_acl_sms_preserva_perfis_e_declara_webhook_no_admin(): void
public function test_migration_incremental_expande_segmentos_e_protege_rollback(): void
public function test_migration_incremental_libera_novo_envio_e_preserva_trava_dos_estados_abertos(): void
public function test_migration_impede_reutilizar_destino_do_mesmo_eleitor_no_turno(): void
public function test_migration_incremental_substitui_destino_por_modelo_e_preserva_duplicidade_legada(): void
public function test_migration_remove_trava_global_e_preserva_unicidade_por_modelo_com_rollback_protegido(): void
public function test_migrations_textbee_separam_provedor_persistem_respostas_e_declaram_acl(): void
public function test_migration_permite_municipio_nulo_e_protege_rollback(): void
private function ler(string $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class ConvocacaoSmsMigrationContractTest extends TestCase
{
    public function test_schema_sms_substitui_legado_com_preflight_e_rollback_planejado(): void
    {
        $migration = $this->ler('database/migrations/2026_08_14_210000_replace_ce_wa_with_ce_sms_tables.php');

        foreach (['ce_wa_modelo_meta', 'ce_wa_modelo', 'ce_wa_lote', 'ce_wa_envio', 'ce_wa_envio_evento', 'ce_wa_telefone_manual'] as $tabela) {
            $this->assertStringContainsString($tabela, $migration);
        }
        foreach (['ce_sms_campo_variavel', 'ce_sms_modelo_situacao', 'ce_sms_envio_status', 'ce_sms_modelo', 'ce_sms_lote', 'ce_sms_lote_item', 'ce_sms_envio', 'ce_sms_envio_evento', 'ce_sms_telefone_manual'] as $tabela) {
            $this->assertStringContainsString('CREATE TABLE '.$tabela, $migration);
        }
        foreach (['external_id', 'provider_message_id', 'mensagem_texto', 'encoding', 'segmentos', 'provider_event_id'] as $coluna) {
            $this->assertStringContainsString($coluna, $migration);
        }
        foreach (['ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'] as $status) {
            $this->assertStringContainsString("['{$status}'", $migration);
        }
        $this->assertStringContainsString("where('queue', 'convocacoes-whatsapp')", $migration);
        $this->assertStringContainsString('TABELAS_LEGADAS_OPERACIONAIS', $migration);
        $this->assertStringContainsString('DOMINIOS_LEGADOS_CANONICOS', $migration);
        $this->assertStringContainsString('validarDominiosLegadosCanonicos', $migration);
        $this->assertStringContainsString('2026_07_29_101000_create_ce_wa_domain_tables.php', $migration);
        $this->assertStringContainsString('2026_08_04_120000_create_ce_wa_telefone_manual_table.php', $migration);
    }

    public function test_acl_sms_preserva_perfis_e_declara_webhook_no_admin(): void
    {
        $migration = $this->ler('database/migrations/2026_08_14_211000_replace_convocacao_whatsapp_with_sms_acl.php');

        foreach (['PLANELEITO_CONVOCACAO_OPERADOR', 'PLANELEITO_CONVOCACAO_GESTOR', 'PLANELEITO_ADMIN'] as $grupo) {
            $this->assertStringContainsString($grupo, $migration);
        }
        foreach (['convocacoes-sms.index', 'convocacoes-sms.envios.store', 'convocacoes-sms.modelos.store', 'integracoes.zenvia.sms.webhook.receber'] as $rota) {
            $this->assertStringContainsString($rota, $migration);
        }
        $this->assertStringContainsString("'integracoes.zenvia.sms.webhook.receber'", $migration);
        $this->assertStringContainsString('PLANELEITO_ADMIN', $migration);
        $this->assertStringContainsString('integracoes.meta.whatsapp.webhook.receber', $migration);
    }

    public function test_migration_incremental_expande_segmentos_e_protege_rollback(): void
    {
        $migration = $this->ler('database/migrations/2026_08_14_233500_expand_ce_sms_segment_constraint.php');

        $this->assertStringContainsString('CK_CE_SMS_ENV_SEG', mb_strtoupper($migration, 'UTF-8'));
        $this->assertStringContainsString('segmentos BETWEEN 1 AND 16', $migration);
        $this->assertStringContainsString("where('segmentos', '>', 3)", $migration);
        $this->assertStringContainsString('segmentos BETWEEN 1 AND 3', $migration);
        $this->assertStringContainsString('DROP CONSTRAINT ck_ce_sms_env_seg', $migration);
    }

    public function test_migration_incremental_libera_novo_envio_e_preserva_trava_dos_estados_abertos(): void
    {
        $migration = $this->ler('database/migrations/2026_08_15_120000_allow_sms_resend_after_communication.php');
        $normalizada = mb_strtoupper($migration, 'UTF-8');

        $this->assertGreaterThanOrEqual(2, substr_count($normalizada, 'UX_CE_SMS_ENVIO_ATIVO'));
        foreach (['PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO'] as $status) {
            $this->assertStringContainsString("'{$status}'", $normalizada);
        }
        foreach (['ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE'] as $status) {
            $this->assertStringContainsString("STATUS_CODIGO <> 'CANCELADO_ANTES_ENVIO'", $normalizada);
            $this->assertStringNotContainsString("STATUS_CODIGO = '{$status}'", $normalizada);
        }
        $this->assertStringContainsString('HAVING COUNT(*) > 1', $normalizada);
        $this->assertStringContainsString('ROLLBACK', $normalizada);
        $this->assertStringContainsString('DROP INDEX UX_CE_SMS_ENVIO_ATIVO', $normalizada);
    }

    public function test_migration_impede_reutilizar_destino_do_mesmo_eleitor_no_turno(): void
    {
        $migration = $this->ler('database/migrations/2026_08_15_130000_prevent_duplicate_sms_destination.php');
        $normalizada = mb_strtoupper($migration, 'UTF-8');

        $this->assertStringContainsString('UX_CE_SMS_ENVIO_DESTINO', $normalizada);
        $this->assertStringContainsString("STATUS_CODIGO <> 'CANCELADO_ANTES_ENVIO'", $normalizada);
        $this->assertStringContainsString('MACROPROJETO_TURNO_ID', $normalizada);
        $this->assertStringContainsString('NUM_INSCRICAO', $normalizada);
        $this->assertStringContainsString('TELEFONE_E164', $normalizada);
        $this->assertStringContainsString('HAVING COUNT(*) > 1', $normalizada);
        $this->assertStringContainsString('DROP INDEX UX_CE_SMS_ENVIO_DESTINO', $normalizada);
    }

    public function test_migration_incremental_substitui_destino_por_modelo_e_preserva_duplicidade_legada(): void
    {
        $arquivo = 'database/migrations/2026_08_28_120000_enforce_sms_model_once_per_recipient.php';
        $this->assertFileExists(base_path($arquivo));
        $migration = mb_strtoupper($this->ler($arquivo), 'UTF-8');

        $this->assertStringContainsString('IND_UNICIDADE_MODELO', $migration);
        $this->assertStringContainsString('DEFAULT 1 NOT NULL', $migration);
        $this->assertStringContainsString('ROW_NUMBER() OVER', $migration);
        $this->assertStringContainsString(
            'PARTITION BY MACROPROJETO_TURNO_ID, NUM_INSCRICAO, MODELO_ID',
            $migration,
        );
        $this->assertStringContainsString('UX_CE_SMS_ENVIO_MODELO', $migration);
        $this->assertStringContainsString("STATUS_CODIGO <> 'CANCELADO_ANTES_ENVIO'", $migration);
        $this->assertStringContainsString('DROP INDEX UX_CE_SMS_ENVIO_DESTINO', $migration);
        $this->assertStringContainsString('TELEFONE_E164', $migration);
        $this->assertStringContainsString('ROLLBACK', $migration);
        $this->assertStringNotContainsString('DELETE FROM CE_SMS_ENVIO', $migration);
        $this->assertStringNotContainsString('UPDATE CE_SMS_ENVIO SET STATUS_CODIGO', $migration);
    }

    public function test_migration_remove_trava_global_e_preserva_unicidade_por_modelo_com_rollback_protegido(): void
    {
        $arquivo = 'database/migrations/2026_08_31_220000_allow_concurrent_sms_models.php';
        $this->assertFileExists(base_path($arquivo));
        $migration = mb_strtoupper($this->ler($arquivo), 'UTF-8');

        $this->assertStringContainsString('UX_CE_SMS_ENVIO_MODELO', $migration);
        $this->assertStringContainsString('STATUS', $migration);
        $this->assertStringContainsString('VALID', $migration);
        $this->assertStringContainsString('DROP INDEX UX_CE_SMS_ENVIO_ATIVO', $migration);
        $this->assertStringContainsString('CREATE UNIQUE INDEX UX_CE_SMS_ENVIO_ATIVO', $migration);
        $this->assertStringContainsString('PENDENTE', $migration);
        $this->assertStringContainsString('PROCESSANDO', $migration);
        $this->assertStringContainsString('REJEITADO', $migration);
        $this->assertStringContainsString('INDETERMINADO', $migration);
        $this->assertStringContainsString('HAVING COUNT(*) > 1', $migration);
        $this->assertStringNotContainsString('UPDATE CE_SMS_ENVIO', $migration);
        $this->assertStringNotContainsString('DELETE FROM CE_SMS_ENVIO', $migration);
    }

    public function test_migrations_textbee_separam_provedor_persistem_respostas_e_declaram_acl(): void
    {
        $provedor = mb_strtoupper($this->ler('database/migrations/2026_08_16_120000_add_provider_metadata_to_ce_sms.php'), 'UTF-8');
        foreach (['PROVIDER_CODIGO', 'PROVIDER_BATCH_ID', 'PROVIDER_DEVICE_ID', 'PROVIDER_SIM_SUBSCRIPTION_ID'] as $coluna) {
            $this->assertStringContainsString($coluna, $provedor);
        }
        $this->assertStringContainsString("UPDATE CE_SMS_ENVIO SET PROVIDER_CODIGO = 'ZENVIA'", $provedor);
        $this->assertStringContainsString("THEN 'INTERNAL' ELSE 'ZENVIA'", $provedor);
        $this->assertStringContainsString('ACEITO PELO PROVEDOR SMS', $provedor);
        $this->assertStringContainsString('CASE WHEN PROVIDER_BATCH_ID IS NOT NULL THEN PROVIDER_CODIGO END', $provedor);
        $this->assertStringContainsString('CASE WHEN PROVIDER_MESSAGE_ID IS NOT NULL THEN PROVIDER_CODIGO END', $provedor);
        $this->assertStringContainsString('COLUNAEXISTE', str_replace('_', '', $provedor));
        $this->assertStringContainsString('ROLLBACK', $provedor);

        $respostas = mb_strtoupper($this->ler('database/migrations/2026_08_16_121000_create_ce_sms_resposta.php'), 'UTF-8');
        foreach (['CREATE TABLE CE_SMS_RESPOSTA', 'VINCULADA', 'AMBIGUA', 'SEM_ENVIO', 'PROVIDER_EVENT_ID', 'PROVIDER_MESSAGE_ID'] as $trecho) {
            $this->assertStringContainsString($trecho, $respostas);
        }
        $this->assertStringContainsString("DB::TABLE('CE_SMS_RESPOSTA')->COUNT()", $respostas);

        $acl = $this->ler('database/migrations/2026_08_16_122000_grant_textbee_sms_webhook_acl.php');
        $this->assertStringContainsString('integracoes.textbee.sms.webhook.receber', $acl);
        $this->assertStringContainsString('PLANELEITO_ADMIN', $acl);
        $this->assertStringNotContainsString('PLANELEITO_CONVOCACAO_OPERADOR', $acl);
    }

    public function test_migration_permite_municipio_nulo_e_protege_rollback(): void
    {
        $arquivo = 'database/migrations/2026_08_18_010000_allow_null_municipio_on_ce_sms_envio.php';
        $this->assertFileExists(base_path($arquivo));

        $migration = mb_strtoupper($this->ler($arquivo), 'UTF-8');
        $this->assertStringContainsString('USER_TAB_COLUMNS', $migration);
        $this->assertStringContainsString("COLUMN_NAME', 'MUNICIPIO'", $migration);
        $this->assertStringContainsString('MODIFY (MUNICIPIO NULL)', $migration);
        $this->assertStringContainsString("WHERENULL('MUNICIPIO')", str_replace('_', '', $migration));
        $this->assertStringContainsString('MODIFY (MUNICIPIO NOT NULL)', $migration);
        $this->assertStringContainsString('ROLLBACK', $migration);
        $this->assertStringNotContainsString('UPDATE CE_SMS_ENVIO', $migration);
    }

    private function ler(string $arquivo): string
    {
        return (string) file_get_contents(base_path($arquivo));
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSMIGRATIONCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsProcessamentoServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSPROCESSAMENTOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsProcessamentoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsProcessamentoServiceTest extends TestCase`

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
public function test_fora_da_janela_mantem_pendente_e_reprograma_para_a_proxima_abertura(): void
public function test_fechamento_durante_a_espera_da_cadencia_nao_reivindica_nem_chama_gateway(): void
public function test_fechamento_durante_a_revalidacao_restaura_pendente_sem_consumir_tentativa(): void
public function test_chamada_iniciada_antes_das_dezoito_pode_concluir_depois(): void
public function test_configuracao_de_janela_invalida_reprograma_em_cinco_minutos_sem_reivindicar(): void
public function test_aceite_com_id_do_lote_textbee_registra_envio(): void
public function test_confirmacao_posterior_nao_cancela_envio_ja_reservado(): void
public function test_destinatario_deixa_de_ser_nomeado_antes_da_chamada_cancela(): void
public function test_telefone_mudou_depois_da_reserva_cancela_sem_chamar_a_zenvia(): void
public function test_rejeicao_estruturada_sem_id_fica_rejeitada(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsProcessamentoRepositoryInterface;
use App\Services\ConvocacaoSms\Contracts\SmsGatewayInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoDoEnvio;
use App\Services\ConvocacaoSms\ConvocacaoSmsJanelaEnvio;
use App\Services\ConvocacaoSms\ConvocacaoSmsProcessamentoService;
use App\Services\ConvocacaoSms\ConvocacaoSmsTelefone;
use App\Services\ConvocacaoSms\SmsDisponibilidade;
use App\Services\ConvocacaoSms\SmsEnvioResultado;
use App\Services\ConvocacaoSms\TextBeeSmsCadencia;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Queue;
use Illuminate\Support\Sleep;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class ConvocacaoSmsProcessamentoServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'worker_enabled' => true,
            'sync_enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'token',
            'device_id' => 'device-1',
            'sim_subscription_id' => 2,
            'webhook_secret' => 'segredo',
        ]);
        config()->set('app.timezone', 'America/Rio_Branco');
        config()->set('planeleito.convocacao_sms.sending_start', '07:00');
        config()->set('planeleito.convocacao_sms.sending_end', '18:00');
        Cache::store('array')->clear();
        Carbon::setTestNow('2026-08-16 12:00:00');
        Sleep::fake(syncWithCarbon: true);
    }

    protected function tearDown(): void
    {
        Sleep::fake(false);
        Carbon::setTestNow();
        Mockery::close();
        parent::tearDown();
    }

    public function test_fora_da_janela_mantem_pendente_e_reprograma_para_a_proxima_abertura(): void
    {
        Queue::fake();
        Carbon::setTestNow('2026-08-16 18:00:00');
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioSemReivindicacao();
        $envios->shouldNotReceive('reivindicarProcessamento');
        $envios->shouldNotReceive('restaurarPendenteForaJanela');
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');

        (new EnviarConvocacaoSmsJob(10))->handle($service);

        Queue::assertPushed(
            EnviarConvocacaoSmsJob::class,
            static fn (EnviarConvocacaoSmsJob $job): bool => $job->envioId === 10 && (int) $job->delay === 46_800,
        );
    }

    public function test_fechamento_durante_a_espera_da_cadencia_nao_reivindica_nem_chama_gateway(): void
    {
        Queue::fake();
        Carbon::setTestNow('2026-08-16 17:59:50');
        $cadencia = new TextBeeSmsCadencia(Cache::store('array'));
        $cadencia->executar('device-1', 2, 6, static fn (): bool => true);
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioSemReivindicacao($cadencia);
        $envios->shouldNotReceive('reivindicarProcessamento');
        $envios->shouldNotReceive('restaurarPendenteForaJanela');
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');

        (new EnviarConvocacaoSmsJob(10))->handle($service);

        Queue::assertPushed(
            EnviarConvocacaoSmsJob::class,
            static fn (EnviarConvocacaoSmsJob $job): bool => $job->envioId === 10 && (int) $job->delay === 46_792,
        );
    }

    public function test_fechamento_durante_a_revalidacao_restaura_pendente_sem_consumir_tentativa(): void
    {
        Queue::fake();
        Carbon::setTestNow('2026-08-16 17:59:59');
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioBase();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturnUsing(function (): array {
            Carbon::setTestNow(now()->addSecond());

            return ['111' => ['num_inscricao' => '111', 'telefone_e164' => '5568999991111']];
        });
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'id' => 3,
            'texto_modelo' => 'TRE-AC: Olá {{NOME}}.',
        ]);
        $envios->shouldReceive('restaurarPendenteForaJanela')->once()->with(10)->andReturnTrue();
        $gateway->shouldNotReceive('enviar');

        (new EnviarConvocacaoSmsJob(10))->handle($service);

        Queue::assertPushed(
            EnviarConvocacaoSmsJob::class,
            static fn (EnviarConvocacaoSmsJob $job): bool => $job->envioId === 10 && (int) $job->delay === 46_800,
        );
    }

    public function test_chamada_iniciada_antes_das_dezoito_pode_concluir_depois(): void
    {
        Carbon::setTestNow('2026-08-16 17:59:59');
        [$service, $envios, , , $gateway] = $this->cenarioValido();
        $gateway->shouldReceive('enviar')->once()->andReturnUsing(function (): SmsEnvioResultado {
            Carbon::setTestNow(now()->addSeconds(5));

            return new SmsEnvioResultado(true, 'textbee-batch-id', false);
        });
        $envios->shouldReceive('registrarAceite')->once()->with(10, 'TEXTBEE', 'textbee-batch-id', 'device-1', 2);

        $service->processar(10);

        $this->assertSame('18:00:04', now()->format('H:i:s'));
    }

    public function test_configuracao_de_janela_invalida_reprograma_em_cinco_minutos_sem_reivindicar(): void
    {
        Queue::fake();
        Log::spy();
        config()->set('planeleito.convocacao_sms.sending_end', 'invalido');
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioSemReivindicacao();
        $envios->shouldNotReceive('reivindicarProcessamento');
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');

        (new EnviarConvocacaoSmsJob(10))->handle($service);

        Queue::assertPushed(
            EnviarConvocacaoSmsJob::class,
            static fn (EnviarConvocacaoSmsJob $job): bool => $job->envioId === 10 && (int) $job->delay === 300,
        );
    }

    public function test_aceite_com_id_do_lote_textbee_registra_envio(): void
    {
        [$service, $envios, , , $gateway] = $this->cenarioValido();
        $gateway->shouldReceive('enviar')->once()->with(
            '5568999991111',
            'TRE-AC: Olá Maria.',
            '123e4567-e89b-42d3-a456-426614174000',
        )->andReturn(new SmsEnvioResultado(true, 'textbee-batch-id', false));
        $envios->shouldReceive('registrarAceite')->once()->with(10, 'TEXTBEE', 'textbee-batch-id', 'device-1', 2);

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_confirmacao_posterior_nao_cancela_envio_ja_reservado(): void
    {
        [$service, $envios, , , $gateway] = $this->cenarioValido([
            'confirmacao_elo_codigo' => 'CONFIRMADO',
            'confirmacao_elo_bloqueia_envio' => true,
        ]);
        $gateway->shouldReceive('enviar')->once()->andReturn(
            new SmsEnvioResultado(true, 'textbee-batch-id', false),
        );
        $envios->shouldReceive('registrarAceite')->once()->with(10, 'TEXTBEE', 'textbee-batch-id', 'device-1', 2);

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_destinatario_deixa_de_ser_nomeado_antes_da_chamada_cancela(): void
    {
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioBase();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([]);
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');
        $envios->shouldReceive('cancelarAntesEnvio')->once()->with(10, 'DESTINATARIO_NAO_NOMEADO', Mockery::type('string'));

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_telefone_mudou_depois_da_reserva_cancela_sem_chamar_a_zenvia(): void
    {
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioBase();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111',
                'telefone_e164' => '5568969998888',
                'telefone_fonte' => 'telefone_manual',
            ],
        ]);
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');
        $envios->shouldReceive('cancelarAntesEnvio')->once()->with(
            10,
            'TELEFONE_ALTERADO_OU_INVALIDO',
            Mockery::type('string'),
        );

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_rejeicao_estruturada_sem_id_fica_rejeitada(): void
    {
        [$service, $envios, , , $gateway] = $this->cenarioValido();
        $gateway->shouldReceive('enviar')->once()->andReturn(
            new SmsEnvioResultado(false, null, true, 'INVALID_DESTINATION', 'Invalid destination'),
        );
        $envios->shouldReceive('registrarRejeicao')->once()->with(10, 'INVALID_DESTINATION', 'Invalid destination');

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_timeout_depois_de_iniciar_chamada_fica_indeterminado_sem_retry(): void
    {
        [$service, $envios, , , $gateway] = $this->cenarioValido();
        $gateway->shouldReceive('enviar')->once()->andThrow(new RuntimeException('token=segredo timeout'));
        $envios->shouldReceive('registrarIndeterminado')->once()->with(
            10,
            'RESULTADO_AMBIGUO',
            Mockery::on(static fn (string $detalhe): bool => ! str_contains($detalhe, 'segredo')),
        );

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_integracao_desabilitada_cancela_antes_da_rede_e_libera_reserva(): void
    {
        config()->set('planeleito.sms_textbee.enabled', false);
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioBase();
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');
        $envios->shouldReceive('cancelarAntesEnvio')->once()->with(
            10,
            'INTEGRACAO_INDISPONIVEL',
            Mockery::type('string'),
        );

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_contexto_do_worker_usa_data_eleitoral_formatada_pelo_repository(): void
    {
        $envio = $this->envio();
        unset($envio['dt_eleicao']);
        $envio['dt_eleicao_iso'] = '2026-10-04';

        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioBase($envio);
        $destinatarios->shouldReceive('buscarPorInscricoes')
            ->once()
            ->with(
                ['111'],
                '1',
                Mockery::on(static fn ($contexto): bool => $contexto->dataEleicao === '2026-10-04'),
            )
            ->andReturn([]);
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');
        $envios->shouldReceive('cancelarAntesEnvio')->once()->with(
            10,
            'DESTINATARIO_NAO_NOMEADO',
            Mockery::type('string'),
        );

        $service->processar(10);
        $this->addToAssertionCount(1);
    }

    public function test_pausa_do_aparelho_mantem_pendente_e_job_e_reprogramado_sem_chamar_gateway(): void
    {
        Queue::fake();
        $envios = Mockery::mock(ConvocacaoSmsProcessamentoRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $gateway = Mockery::mock(SmsGatewayInterface::class);
        $envios->shouldReceive('buscarEnvio')->once()->with(10)->andReturn($this->envio());
        $envios->shouldNotReceive('reivindicarProcessamento');
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $gateway->shouldNotReceive('enviar');
        $cadencia = new TextBeeSmsCadencia(Cache::store('array'));
        $cadencia->pausarPorLimite('device-1', 2, 900);
        $service = new ConvocacaoSmsProcessamentoService(
            $envios,
            $destinatarios,
            $modelos,
            $gateway,
            app(SmsDisponibilidade::class),
            $cadencia,
            new ConvocacaoSmsContextoDoEnvio,
            new ConvocacaoSmsJanelaEnvio,
        );

        (new EnviarConvocacaoSmsJob(10))->handle($service);

        Queue::assertPushed(
            EnviarConvocacaoSmsJob::class,
            static fn (EnviarConvocacaoSmsJob $job): bool => $job->envioId === 10 && (int) $job->delay === 900,
        );
    }

    /** @return array{ConvocacaoSmsProcessamentoService,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface} */
    private function cenarioBase(?array $envio = null): array
    {
        $envios = Mockery::mock(ConvocacaoSmsProcessamentoRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $gateway = Mockery::mock(SmsGatewayInterface::class);
        $envios->shouldReceive('buscarEnvio')->once()->with(10)->andReturn($envio ?? $this->envio());
        $envios->shouldReceive('reivindicarProcessamento')->once()->with(10)->andReturnTrue();

        return [new ConvocacaoSmsProcessamentoService(
            $envios,
            $destinatarios,
            $modelos,
            $gateway,
            app(SmsDisponibilidade::class),
            new TextBeeSmsCadencia(Cache::store('array')),
            new ConvocacaoSmsContextoDoEnvio,
            new ConvocacaoSmsJanelaEnvio,
        ), $envios, $destinatarios, $modelos, $gateway];
    }

    /** @return array{ConvocacaoSmsProcessamentoService,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface} */
    private function cenarioSemReivindicacao(?TextBeeSmsCadencia $cadencia = null): array
    {
        $envios = Mockery::mock(ConvocacaoSmsProcessamentoRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);
        $gateway = Mockery::mock(SmsGatewayInterface::class);
        $envios->shouldReceive('buscarEnvio')->once()->with(10)->andReturn($this->envio());

        return [new ConvocacaoSmsProcessamentoService(
            $envios,
            $destinatarios,
            $modelos,
            $gateway,
            app(SmsDisponibilidade::class),
            $cadencia ?? new TextBeeSmsCadencia(Cache::store('array')),
            new ConvocacaoSmsContextoDoEnvio,
            new ConvocacaoSmsJanelaEnvio,
        ), $envios, $destinatarios, $modelos, $gateway];
    }

    /** @return array{ConvocacaoSmsProcessamentoService,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface} */
    private function cenarioValido(array $dadosDestinatario = []): array
    {
        [$service, $envios, $destinatarios, $modelos, $gateway] = $this->cenarioBase();
        $telefone = (new ConvocacaoSmsTelefone)->selecionar([
            'telefone_perfil' => '+55 68 99999-1111',
        ]);
        $this->assertSame('5568999991111', $telefone['e164'] ?? null);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => array_merge([
                'num_inscricao' => '111', 'telefone_e164' => $telefone['e164'],
            ], $dadosDestinatario),
        ]);
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn([
            'id' => 3,
            'texto_modelo' => 'TRE-AC: Olá {{NOME}}.',
        ]);

        return [$service, $envios, $destinatarios, $modelos, $gateway];
    }

    /** @return array<string, mixed> */
    private function envio(): array
    {
        return [
            'id' => 10,
            'modelo_id' => 3,
            'macroprojeto_id' => 1,
            'macroprojeto_turno_id' => 9,
            'turno' => '1',
            'cod_pleito' => '3220',
            'dt_eleicao' => '2026-10-04',
            'num_zona' => '1',
            'num_inscricao' => '111',
            'telefone_e164' => '5568999991111',
            'mensagem_texto' => 'TRE-AC: Olá Maria.',
            'external_id' => '123e4567-e89b-42d3-a456-426614174000',
            'segmentos' => 6,
            'provider_device_id' => 'device-1',
            'provider_sim_subscription_id' => 2,
            'usuario_login' => 'operador',
            'usuario_nome' => 'Operador',
        ];
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSPROCESSAMENTOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsRecuperacaoLimiteServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSRECUPERACAOLIMITESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsRecuperacaoLimiteServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsRecuperacaoLimiteServiceTest extends TestCase`

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
public function test_reenfileira_somente_falha_5_ainda_elegivel_e_reidratada(): void
public function test_confirmado_no_convoca_mais_nao_e_alterado_nem_enfileirado(): void
public function test_simulacao_revalida_mas_nao_executa_dml_ou_job(): void
private function service(): array
private function envio(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRecuperacaoRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContextoDoEnvio;
use App\Services\ConvocacaoSms\ConvocacaoSmsRecuperacaoLimiteService;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\SmsDisponibilidade;
use Illuminate\Support\Facades\Queue;
use Mockery;
use Tests\TestCase;

class ConvocacaoSmsRecuperacaoLimiteServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Queue::fake();
        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'worker_enabled' => true,
            'sync_enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'token',
            'device_id' => 'device-1',
            'limit_max_attempts' => 2,
        ]);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_reenfileira_somente_falha_5_ainda_elegivel_e_reidratada(): void
    {
        [$service, $recuperacao, $destinatarios, $modelos] = $this->service();
        $recuperacao->shouldReceive('listarFalhasLimiteTextBee')->once()->with(2)->andReturn([$this->envio()]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111',
                'telefone_e164' => '5568999991111',
                'confirmacao_elo_codigo' => 'AGUARDANDO',
                'confirmacao_elo_bloqueia_envio' => false,
            ],
        ]);
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn(['id' => 3]);
        $recuperacao->shouldReceive('prepararReenvioFalhaLimiteTextBee')->once()->with(10, 2)->andReturnTrue();

        $resultado = $service->recuperar(executar: true);

        $this->assertSame([
            'encontrados' => 1,
            'elegiveis' => 1,
            'reenfileirados' => 1,
            'ignorados' => 0,
        ], $resultado);
        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 10);
    }

    public function test_confirmado_no_convoca_mais_nao_e_alterado_nem_enfileirado(): void
    {
        [$service, $recuperacao, $destinatarios, $modelos] = $this->service();
        $recuperacao->shouldReceive('listarFalhasLimiteTextBee')->once()->andReturn([$this->envio()]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111',
                'telefone_e164' => '5568999991111',
                'confirmacao_elo_codigo' => 'CONFIRMADO',
                'confirmacao_elo_bloqueia_envio' => true,
            ],
        ]);
        $modelos->shouldNotReceive('buscarConfiguracaoAtiva');
        $recuperacao->shouldNotReceive('prepararReenvioFalhaLimiteTextBee');

        $resultado = $service->recuperar(executar: true);

        $this->assertSame(0, $resultado['reenfileirados']);
        $this->assertSame(1, $resultado['ignorados']);
        Queue::assertNothingPushed();
    }

    public function test_simulacao_revalida_mas_nao_executa_dml_ou_job(): void
    {
        [$service, $recuperacao, $destinatarios, $modelos] = $this->service();
        $recuperacao->shouldReceive('listarFalhasLimiteTextBee')->once()->andReturn([$this->envio()]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => [
                'num_inscricao' => '111',
                'telefone_e164' => '5568999991111',
                'confirmacao_elo_codigo' => 'AGUARDANDO',
                'confirmacao_elo_bloqueia_envio' => false,
            ],
        ]);
        $modelos->shouldReceive('buscarConfiguracaoAtiva')->once()->andReturn(['id' => 3]);
        $recuperacao->shouldNotReceive('prepararReenvioFalhaLimiteTextBee');

        $resultado = $service->recuperar(executar: false);

        $this->assertSame(1, $resultado['elegiveis']);
        $this->assertSame(0, $resultado['reenfileirados']);
        Queue::assertNothingPushed();
    }

    /** @return array{ConvocacaoSmsRecuperacaoLimiteService,Mockery\MockInterface,Mockery\MockInterface,Mockery\MockInterface} */
    private function service(): array
    {
        $recuperacao = Mockery::mock(ConvocacaoSmsRecuperacaoRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $modelos = Mockery::mock(ConvocacaoSmsModeloRepositoryInterface::class);

        return [
            new ConvocacaoSmsRecuperacaoLimiteService(
                $recuperacao,
                $destinatarios,
                $modelos,
                new ConvocacaoSmsStatusService,
                app(SmsDisponibilidade::class),
                new ConvocacaoSmsContextoDoEnvio,
            ),
            $recuperacao,
            $destinatarios,
            $modelos,
        ];
    }

    /** @return array<string, mixed> */
    private function envio(): array
    {
        return [
            'id' => 10,
            'modelo_id' => 3,
            'macroprojeto_id' => 1,
            'macroprojeto_turno_id' => 9,
            'turno' => '1',
            'cod_pleito' => '3220',
            'dt_eleicao_iso' => '2026-10-04',
            'num_zona' => '1',
            'num_inscricao' => '111',
            'telefone_e164' => '5568999991111',
            'usuario_login' => 'operador',
            'usuario_nome' => 'Operador',
            'status_codigo' => 'NAO_ENTREGUE',
            'erro_codigo' => '5',
            'tentativas' => 1,
        ];
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSRECUPERACAOLIMITESERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsReenvioServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSREENVIOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsReenvioServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsReenvioServiceTest extends TestCase`

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
public function test_reenvio_rejeitado_confirmado_e_bloqueado_sem_transicao_ou_job(): void
public function test_reenvio_continua_restrito_ao_administrador(): void
public function test_reenvio_rejeitado_nao_confirmado_preserva_transicao_e_job(): void
private function service($envios, $destinatarios): ConvocacaoSmsReenvioService
private function contextoAdministrador(): ConvocacaoSmsContexto
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Jobs\ConvocacaoSms\EnviarConvocacaoSmsJob;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Services\ConvocacaoSms\ConvocacaoSmsReenvioService;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\SmsDisponibilidade;
use DomainException;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Support\Facades\Queue;
use Mockery;
use Tests\TestCase;

class ConvocacaoSmsReenvioServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'worker_enabled' => true,
            'sync_enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'token',
            'device_id' => 'device-1',
            'webhook_secret' => 'segredo',
        ]);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_reenvio_rejeitado_confirmado_e_bloqueado_sem_transicao_ou_job(): void
    {
        Queue::fake();
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $contexto = $this->contextoAdministrador();
        $envios->shouldReceive('buscarDetalhe')->once()->with(10, $contexto)->andReturn([
            'id' => 10, 'status_codigo' => 'REJEITADO', 'num_inscricao' => '111', 'num_zona' => '1',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->with(['111'], '1', $contexto)->andReturn([
            '111' => [
                'confirmacao_elo_codigo' => 'CONFIRMADO',
                'confirmacao_elo_bloqueia_envio' => true,
            ],
        ]);
        $envios->shouldNotReceive('prepararReenvio');

        try {
            $this->service($envios, $destinatarios)->reenviar(10, $contexto);
            $this->fail('O reenvio confirmado deveria ter sido recusado.');
        } catch (DomainException $exception) {
            $this->assertStringContainsString('confirmada no ELO', $exception->getMessage());
        }
        Queue::assertNothingPushed();
    }

    public function test_reenvio_continua_restrito_ao_administrador(): void
    {
        Queue::fake();
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $envios->shouldNotReceive('buscarDetalhe');
        $destinatarios->shouldNotReceive('buscarPorInscricoes');

        $contexto = new ConvocacaoSmsContexto(
            1, 9, '1', '3220', '2026-10-04', 'gestor', 'Gestor', true, false, ['1'], false,
        );

        $this->expectException(AuthorizationException::class);

        $this->service($envios, $destinatarios)->reenviar(10, $contexto);
    }

    public function test_reenvio_rejeitado_nao_confirmado_preserva_transicao_e_job(): void
    {
        Queue::fake();
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $contexto = $this->contextoAdministrador();
        $envios->shouldReceive('buscarDetalhe')->once()->andReturn([
            'id' => 10, 'status_codigo' => 'REJEITADO', 'num_inscricao' => '111', 'num_zona' => '1',
        ]);
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => ['confirmacao_elo_codigo' => 'AGUARDANDO', 'confirmacao_elo_bloqueia_envio' => false],
        ]);
        $envios->shouldReceive('prepararReenvio')->once()->with(10, $contexto)->andReturnTrue();

        $this->service($envios, $destinatarios)->reenviar(10, $contexto);

        Queue::assertPushed(EnviarConvocacaoSmsJob::class, static fn ($job): bool => $job->envioId === 10);
    }

    private function service($envios, $destinatarios): ConvocacaoSmsReenvioService
    {
        return new ConvocacaoSmsReenvioService(
            $envios,
            $destinatarios,
            new ConvocacaoSmsStatusService,
            app(SmsDisponibilidade::class),
        );
    }

    private function contextoAdministrador(): ConvocacaoSmsContexto
    {
        return new ConvocacaoSmsContexto(
            1, 9, '1', '3220', '2026-10-04', 'admin', 'Administrador', true, true, ['1'], false,
        );
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSREENVIOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsStatusServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSSTATUSSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsStatusServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsStatusServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_ja_comunicado_reutiliza_os_quatro_estados_canonicos(): void
public function test_filtro_de_destinatarios_distingue_estado_exato_do_agrupamento_ja_comunicado(): void
public function test_confirmado_tem_status_efetivo_entregue_mesmo_apos_falha_tecnica(): void
public function test_status_zenvia_progride_sem_regredir_entrega(): void
public function test_status_textbee_progride_monotonicamente_e_falha_nao_sobrepoe_entrega(): void
public function test_perfil_operacional_seleciona_modelo_novo_independentemente_do_estado_de_outro_modelo(): void
public function test_confirmacao_do_elo_bloqueia_reprocessamento_mas_nao_muda_selecao_de_modelo_novo(): void
public function test_telefone_de_comunicado_so_pode_ser_atualizado_por_gestor_antes_do_novo_envio(): void
public function test_reenvio_continua_exclusivo_do_admin_e_do_rejeitado_local(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Support\ConvocacaoSms\ConvocacaoSmsStatus;
use Tests\TestCase;

class ConvocacaoSmsStatusServiceTest extends TestCase
{
    public function test_ja_comunicado_reutiliza_os_quatro_estados_canonicos(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertSame([
            'ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE',
        ], ConvocacaoSmsStatus::JA_COMUNICADOS);
        $this->assertSame(ConvocacaoSmsStatus::JA_COMUNICADOS, $service->statusJaComunicados());
        foreach (ConvocacaoSmsStatus::JA_COMUNICADOS as $status) {
            $this->assertTrue($service->ehJaComunicado($status));
        }
        foreach (['PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO', 'CANCELADO_ANTES_ENVIO'] as $status) {
            $this->assertFalse($service->ehJaComunicado($status));
        }
    }

    public function test_filtro_de_destinatarios_distingue_estado_exato_do_agrupamento_ja_comunicado(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertSame([
            'PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO',
            'ACEITO', 'ENVIADO', 'ENTREGUE', 'NAO_ENTREGUE',
        ], ConvocacaoSmsStatus::DESTINATARIO_FILTRAVEIS_EXATOS);
        $this->assertSame(
            ConvocacaoSmsStatus::DESTINATARIO_FILTRAVEIS_EXATOS,
            $service->statusDestinatarioFiltraveisExatos(),
        );
        $this->assertTrue($service->correspondeFiltroDestinatario('ENVIADO', 'ENVIADO', 'JA_COMUNICADO'));
        $this->assertFalse($service->correspondeFiltroDestinatario('ENVIADO', 'ENTREGUE', 'JA_COMUNICADO'));
        $this->assertTrue($service->correspondeFiltroDestinatario('JA_COMUNICADO', 'ENTREGUE', 'JA_COMUNICADO'));
        $this->assertTrue($service->correspondeFiltroDestinatario('A_COMUNICAR', '', 'A_COMUNICAR'));
    }

    public function test_confirmado_tem_status_efetivo_entregue_mesmo_apos_falha_tecnica(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertSame('ENTREGUE', $service->statusEfetivoEntrega('ENVIADO', true));
        $this->assertSame('ENVIADO', $service->statusEfetivoEntrega('ENVIADO', false));
        $this->assertSame('ENTREGUE', $service->statusEfetivoEntrega('ENTREGUE', true));
        $this->assertSame('ENTREGUE', $service->statusEfetivoEntrega('NAO_ENTREGUE', true));
        $this->assertSame('NAO_ENTREGUE', $service->statusEfetivoEntrega('NAO_ENTREGUE', false));
        $this->assertTrue($service->correspondeFiltroDestinatario(
            'ENTREGUE',
            'ENVIADO',
            'JA_COMUNICADO',
            true,
        ));
        $this->assertFalse($service->correspondeFiltroDestinatario(
            'ENVIADO',
            'ENVIADO',
            'JA_COMUNICADO',
            true,
        ));
        $this->assertTrue($service->correspondeFiltroDestinatario(
            'ENTREGUE',
            'NAO_ENTREGUE',
            'JA_COMUNICADO',
            true,
        ));
        $this->assertFalse($service->correspondeFiltroDestinatario(
            'NAO_ENTREGUE',
            'NAO_ENTREGUE',
            'JA_COMUNICADO',
            true,
        ));
        $this->assertTrue($service->filtroDestinatarioDependeConfirmacaoElo('NAO_ENTREGUE'));
    }

    public function test_status_zenvia_progride_sem_regredir_entrega(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertSame('ENVIADO', $service->aplicarEventoZenvia('ACEITO', 'SENT'));
        $this->assertSame('ENTREGUE', $service->aplicarEventoZenvia('ENVIADO', 'DELIVERED'));
        $this->assertSame('ENTREGUE', $service->aplicarEventoZenvia('ENTREGUE', 'NOT_DELIVERED'));
        $this->assertNull($service->aplicarEventoZenvia('ACEITO', 'READ'));
    }

    public function test_status_textbee_progride_monotonicamente_e_falha_nao_sobrepoe_entrega(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertSame('ENVIADO', $service->aplicarEventoProvedor('ACEITO', 'TEXTBEE', 'MESSAGE_SENT'));
        $this->assertSame('ENTREGUE', $service->aplicarEventoProvedor('ENVIADO', 'TEXTBEE', 'MESSAGE_DELIVERED'));
        $this->assertSame('NAO_ENTREGUE', $service->aplicarEventoProvedor('ENVIADO', 'TEXTBEE', 'MESSAGE_FAILED'));
        $this->assertSame('ENTREGUE', $service->aplicarEventoProvedor('ENTREGUE', 'TEXTBEE', 'MESSAGE_FAILED'));
    }

    public function test_perfil_operacional_seleciona_modelo_novo_independentemente_do_estado_de_outro_modelo(): void
    {
        $service = new ConvocacaoSmsStatusService;

        foreach (['A_COMUNICAR', 'JA_COMUNICADO', 'PENDENTE', 'PROCESSANDO', 'REJEITADO', 'INDETERMINADO'] as $situacao) {
            $this->assertTrue($service->podeSelecionarParaEnvio($situacao, false));
            $this->assertFalse($service->podeSelecionarParaEnvio($situacao, true));
        }
        $this->assertFalse($service->podeSelecionarParaEnvio('SEM_CELULAR_VALIDO', false));
        $this->assertFalse($service->podeSelecionarParaEnvio('DESCONHECIDO', false));
    }

    public function test_confirmacao_do_elo_bloqueia_reprocessamento_mas_nao_muda_selecao_de_modelo_novo(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertTrue($service->confirmacaoEloBloqueiaEnvio('CONFIRMADO'));
        $this->assertFalse($service->confirmacaoEloBloqueiaEnvio('NAO_CONFIRMOU'));
        $this->assertFalse($service->confirmacaoEloBloqueiaEnvio('AGUARDANDO'));
        $this->assertTrue($service->podeSelecionarParaEnvio('A_COMUNICAR', false));
        $this->assertTrue($service->podeSelecionarParaEnvio('JA_COMUNICADO', false));
        $this->assertSame('A_COMUNICAR', $service->situacaoComunicacao('', true));
    }

    public function test_telefone_de_comunicado_so_pode_ser_atualizado_por_gestor_antes_do_novo_envio(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertTrue($service->podeAlterarTelefoneAntesEnvio('A_COMUNICAR', false));
        $this->assertTrue($service->podeAlterarTelefoneAntesEnvio('SEM_CELULAR_VALIDO', false));
        $this->assertTrue($service->podeAlterarTelefoneAntesEnvio('JA_COMUNICADO', true));
        $this->assertFalse($service->podeAlterarTelefoneAntesEnvio('JA_COMUNICADO', false));
        $this->assertFalse($service->podeAlterarTelefoneAntesEnvio('PENDENTE', true));
    }

    public function test_reenvio_continua_exclusivo_do_admin_e_do_rejeitado_local(): void
    {
        $service = new ConvocacaoSmsStatusService;

        $this->assertTrue($service->podeReenviar('REJEITADO', true));
        $this->assertFalse($service->podeReenviar('REJEITADO', false));
        $this->assertFalse($service->podeReenviar('NAO_ENTREGUE', true));
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSSTATUSSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsTelefoneManualRepositoryTest.php`
## <TESTS_UNIT_CONVOCACAOSMSTELEFONEMANUALREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsTelefoneManualRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsTelefoneManualRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function salvar_o_mesmo_telefone_nao_executa_dml_nem_auditoria(): void
public function colisao_do_indice_unico_repete_a_transacao_uma_vez(): void
public function restaurar_sem_correcao_e_idempotente_e_nao_executa_delete(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\ConvocacaoSmsTelefoneManualRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Database\Query\Builder;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class ConvocacaoSmsTelefoneManualRepositoryTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function salvar_o_mesmo_telefone_nao_executa_dml_nem_auditoria(): void
    {
        $builder = Mockery::mock(Builder::class);
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());
        DB::shouldReceive('table')->once()->with('ce_sms_telefone_manual')->andReturn($builder);
        $builder->shouldReceive('where')->once()->with('num_inscricao', '111')->andReturnSelf();
        $builder->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builder->shouldReceive('first')->once()->andReturn((object) [
            'id' => 7,
            'telefone_nacional' => '68969998888',
        ]);
        $auditoria = Mockery::mock(AuditLogService::class);
        $auditoria->shouldNotReceive('registrarAcao');

        $alterado = (new ConvocacaoSmsTelefoneManualRepository($auditoria))
            ->salvar('111', '68969998888', 'operador', 'Operador');

        $this->assertFalse($alterado);
    }

    #[Test]
    public function colisao_do_indice_unico_repete_a_transacao_uma_vez(): void
    {
        $colisao = new QueryException(
            'oracle',
            'insert into ce_sms_telefone_manual',
            [],
            new RuntimeException('ORA-00001: unique constraint violated'),
        );
        DB::shouldReceive('transaction')->once()->ordered()->andThrow($colisao);
        DB::shouldReceive('transaction')->once()->ordered()->andReturnFalse();

        $alterado = (new ConvocacaoSmsTelefoneManualRepository(Mockery::mock(AuditLogService::class)))
            ->salvar('111', '68969998888', 'operador', 'Operador');

        $this->assertFalse($alterado);
    }

    #[Test]
    public function restaurar_sem_correcao_e_idempotente_e_nao_executa_delete(): void
    {
        $builder = Mockery::mock(Builder::class);
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());
        DB::shouldReceive('table')->once()->with('ce_sms_telefone_manual')->andReturn($builder);
        $builder->shouldReceive('where')->once()->with('num_inscricao', '111')->andReturnSelf();
        $builder->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builder->shouldReceive('first')->once()->andReturnNull();

        $alterado = (new ConvocacaoSmsTelefoneManualRepository(Mockery::mock(AuditLogService::class)))
            ->remover('111');

        $this->assertFalse($alterado);
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSTELEFONEMANUALREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsTelefoneManualRequestTest.php`
## <TESTS_UNIT_CONVOCACAOSMSTELEFONEMANUALREQUESTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsTelefoneManualRequestTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsTelefoneManualRequestTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function salvar_normaliza_zona_acao_e_celular_nacional(): void
public function rejeita_fixo_prefixo_invalido_e_acao_desconhecida(): void
public function restaurar_nao_exige_telefone(): void
private function validator(array $payload): LaravelValidator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\ConvocacaoSms\ConvocacaoSmsTelefoneManualRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Validator as LaravelValidator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ConvocacaoSmsTelefoneManualRequestTest extends TestCase
{
    #[Test]
    public function salvar_normaliza_zona_acao_e_celular_nacional(): void
    {
        $validator = $this->validator([
            'acao' => ' salvar ',
            'zona' => '001',
            'telefone' => '(68) 96999-8888',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
        $this->assertSame('SALVAR', $validator->validated()['acao']);
        $this->assertSame('1', $validator->validated()['zona']);
        $this->assertSame('68969998888', $validator->validated()['telefone']);
    }

    #[Test]
    public function rejeita_fixo_prefixo_invalido_e_acao_desconhecida(): void
    {
        foreach ([
            ['acao' => 'SALVAR', 'zona' => '1', 'telefone' => '6832221111'],
            ['acao' => 'SALVAR', 'zona' => '1', 'telefone' => '68959998888'],
            ['acao' => 'EXCLUIR', 'zona' => '1', 'telefone' => '68969998888'],
        ] as $payload) {
            $this->assertTrue($this->validator($payload)->fails());
        }
    }

    #[Test]
    public function restaurar_nao_exige_telefone(): void
    {
        $validator = $this->validator(['acao' => 'RESTAURAR', 'zona' => '1']);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
    }

    /** @param array<string, mixed> $payload */
    private function validator(array $payload): LaravelValidator
    {
        $request = ConvocacaoSmsTelefoneManualRequest::create('/teste', 'PUT', $payload);
        $prepare = new \ReflectionMethod($request, 'prepareForValidation');
        $prepare->invoke($request);

        return Validator::make($request->all(), $request->rules(), $request->messages());
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSTELEFONEMANUALREQUESTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsTelefoneManualServiceTest.php`
## <TESTS_UNIT_CONVOCACAOSMSTELEFONEMANUALSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsTelefoneManualServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsTelefoneManualServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function salva_telefone_normalizado_reidratando_a_inscricao_da_rota(): void
public function usar_telefone_da_carga_remove_a_correcao_e_e_idempotente(): void
public function salvar_o_mesmo_telefone_da_carga_restaura_em_vez_de_duplicar(): void
public function bloqueia_externo_convocacao_fora_do_escopo_e_envio_reservado(): void
public function falha_fechado_quando_convocacao_nao_existe_no_escopo(): void
public function falha_fechado_depois_que_o_envio_foi_reservado(): void
public function gestor_restaura_telefone_do_elo_para_destinatario_ja_comunicado(): void
public function operador_nao_altera_telefone_de_destinatario_ja_comunicado(): void
private function cenario(): array
private function destinatario(array $sobrescrever = []): array
private function contexto(bool $podeAlterarTelefone = true, bool $gestor = false): ConvocacaoSmsContexto
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsTelefoneManualRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsContexto;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\ConvocacaoSmsTelefoneManualService;
use DomainException;
use Illuminate\Auth\Access\AuthorizationException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class ConvocacaoSmsTelefoneManualServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function salva_telefone_normalizado_reidratando_a_inscricao_da_rota(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()
            ->with(['111'], '1', Mockery::type(ConvocacaoSmsContexto::class))
            ->andReturn(['111' => $this->destinatario()]);
        $telefones->shouldReceive('salvar')->once()
            ->with('111', '68969998888', 'operador', 'Operador')->andReturnTrue();

        $resultado = $service->processar('111', [
            'acao' => 'SALVAR', 'zona' => '1', 'telefone' => '(68) 96999-8888',
            'num_inscricao' => '999',
        ], $this->contexto());

        $this->assertSame(['acao' => 'SALVAR', 'alterado' => true], $resultado);
    }

    #[Test]
    public function usar_telefone_da_carga_remove_a_correcao_e_e_idempotente(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->twice()->andReturn([
            '111' => $this->destinatario(['telefone_manual_ativo' => true]),
        ]);
        $telefones->shouldReceive('remover')->twice()->with('111')->andReturn(true, false);

        $primeiro = $service->processar('111', ['acao' => 'RESTAURAR', 'zona' => '1'], $this->contexto());
        $segundo = $service->processar('111', ['acao' => 'RESTAURAR', 'zona' => '1'], $this->contexto());

        $this->assertTrue($primeiro['alterado']);
        $this->assertFalse($segundo['alterado']);
    }

    #[Test]
    public function salvar_o_mesmo_telefone_da_carga_restaura_em_vez_de_duplicar(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => $this->destinatario(['telefone_manual_ativo' => true]),
        ]);
        $telefones->shouldReceive('remover')->once()->with('111')->andReturnTrue();
        $telefones->shouldNotReceive('salvar');

        $resultado = $service->processar('111', [
            'acao' => 'SALVAR', 'zona' => '1', 'telefone' => '68999991111',
        ], $this->contexto());

        $this->assertSame('RESTAURAR', $resultado['acao']);
    }

    #[Test]
    public function bloqueia_externo_convocacao_fora_do_escopo_e_envio_reservado(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldNotReceive('buscarPorInscricoes');
        $telefones->shouldNotReceive('salvar');
        $this->expectException(AuthorizationException::class);
        $service->processar('111', [
            'acao' => 'SALVAR', 'zona' => '1', 'telefone' => '68969998888',
        ], $this->contexto(false));
    }

    #[Test]
    public function falha_fechado_quando_convocacao_nao_existe_no_escopo(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([]);
        $telefones->shouldNotReceive('salvar');
        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('não foi encontrada');
        $service->processar('111', [
            'acao' => 'SALVAR', 'zona' => '2', 'telefone' => '68969998888',
        ], $this->contexto());
    }

    #[Test]
    public function falha_fechado_depois_que_o_envio_foi_reservado(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => $this->destinatario(['situacao_comunicacao' => 'PENDENTE']),
        ]);
        $telefones->shouldNotReceive('salvar');
        $this->expectException(DomainException::class);
        $this->expectExceptionMessage('antes da reserva');
        $service->processar('111', [
            'acao' => 'SALVAR', 'zona' => '1', 'telefone' => '68969998888',
        ], $this->contexto());
    }

    #[Test]
    public function gestor_restaura_telefone_do_elo_para_destinatario_ja_comunicado(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => $this->destinatario([
                'situacao_comunicacao' => 'JA_COMUNICADO',
                'telefone_manual_ativo' => true,
                'telefone_carga_nacional' => '68988887777',
            ]),
        ]);
        $telefones->shouldReceive('remover')->once()->with('111')->andReturnTrue();

        $resultado = $service->processar(
            '111',
            ['acao' => 'RESTAURAR', 'zona' => '1'],
            $this->contexto(true, true),
        );

        $this->assertSame(['acao' => 'RESTAURAR', 'alterado' => true], $resultado);
    }

    #[Test]
    public function operador_nao_altera_telefone_de_destinatario_ja_comunicado(): void
    {
        [$service, $destinatarios, $telefones] = $this->cenario();
        $destinatarios->shouldReceive('buscarPorInscricoes')->once()->andReturn([
            '111' => $this->destinatario(['situacao_comunicacao' => 'JA_COMUNICADO']),
        ]);
        $telefones->shouldNotReceive('remover');
        $this->expectException(DomainException::class);

        $service->processar(
            '111',
            ['acao' => 'RESTAURAR', 'zona' => '1'],
            $this->contexto(true, false),
        );
    }

    /** @return array{ConvocacaoSmsTelefoneManualService, Mockery\MockInterface, Mockery\MockInterface} */
    private function cenario(): array
    {
        $destinatarios = Mockery::mock(ConvocacaoSmsDestinatarioRepositoryInterface::class);
        $telefones = Mockery::mock(ConvocacaoSmsTelefoneManualRepositoryInterface::class);

        return [new ConvocacaoSmsTelefoneManualService(
            $destinatarios,
            $telefones,
            new ConvocacaoSmsStatusService,
        ), $destinatarios, $telefones];
    }

    /** @param array<string, mixed> $sobrescrever @return array<string, mixed> */
    private function destinatario(array $sobrescrever = []): array
    {
        return array_merge([
            'num_inscricao' => '111',
            'zona' => '1',
            'situacao_comunicacao' => 'A_COMUNICAR',
            'telefone_carga_nacional' => '68999991111',
            'telefone_manual_ativo' => false,
        ], $sobrescrever);
    }

    private function contexto(bool $podeAlterarTelefone = true, bool $gestor = false): ConvocacaoSmsContexto
    {
        return new ConvocacaoSmsContexto(
            1, 9, '1', '3220', '2026-10-04', 'operador', 'Operador',
            $gestor, false, ['1'], false, $podeAlterarTelefone,
        );
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSTELEFONEMANUALSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ConvocacaoSmsTelefoneTest.php`
## <TESTS_UNIT_CONVOCACAOSMSTELEFONETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ConvocacaoSmsTelefoneTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ConvocacaoSmsTelefoneTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_telefone_manual_tem_prioridade_sobre_perfil_e_carga(): void
public function test_selecao_da_carga_ignora_correcao_manual_para_permitir_restauracao(): void
public function test_prioriza_o_primeiro_celular_valido_e_formata_e164(): void
public function test_ignora_valor_invalido_e_segue_a_prioridade_elo(): void
public function test_normaliza_formatos_recuperaveis(
public static function telefonesNormalizados(): array
public function test_telefone_marcado_como_fixo_nao_impede_fonte_posterior_valida(): void
public function test_diagnostica_por_que_nao_ha_destino(array $dados, string $codigo, string $rotulo): void
public static function diagnosticosSemDestino(): array
public function test_retorna_nulo_quando_nao_existe_celular_valido(array $dados): void
public static function telefonesSemDestino(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ConvocacaoSmsTelefone;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

class ConvocacaoSmsTelefoneTest extends TestCase
{
    public function test_telefone_manual_tem_prioridade_sobre_perfil_e_carga(): void
    {
        $selecionado = (new ConvocacaoSmsTelefone)->selecionar([
            'telefone_manual' => '68969998888',
            'telefone_perfil' => '(68) 99999-1111',
            'num_tel_eleitor' => '(68) 99999-2222',
        ]);

        $this->assertSame('telefone_manual', $selecionado['fonte'] ?? null);
        $this->assertSame('5568969998888', $selecionado['e164'] ?? null);
    }

    public function test_selecao_da_carga_ignora_correcao_manual_para_permitir_restauracao(): void
    {
        $selecionado = (new ConvocacaoSmsTelefone)->selecionarCarga([
            'telefone_manual' => '68969998888',
            'telefone_perfil' => '(68) 99999-1111',
            'num_tel_eleitor' => '(68) 99999-2222',
        ]);

        $this->assertSame('telefone_perfil', $selecionado['fonte'] ?? null);
        $this->assertSame('5568999991111', $selecionado['e164'] ?? null);
    }

    public function test_prioriza_o_primeiro_celular_valido_e_formata_e164(): void
    {
        $telefone = new ConvocacaoSmsTelefone;

        $selecionado = $telefone->selecionar([
            'telefone_perfil' => '(68) 99999-1111',
            'num_tel_eleitor' => '(68) 99999-2222',
            'num_tel_eleitor_2' => null,
            'num_telefone' => null,
            'num_telefone_comercial' => null,
        ]);

        $this->assertSame([
            'fonte' => 'telefone_perfil',
            'nacional' => '68999991111',
            'e164' => '5568999991111',
            'normalizacao_codigo' => null,
            'normalizacao_rotulo' => null,
        ], $selecionado);
    }

    public function test_ignora_valor_invalido_e_segue_a_prioridade_elo(): void
    {
        $telefone = new ConvocacaoSmsTelefone;

        $selecionado = $telefone->selecionar([
            'telefone_perfil' => 'sem telefone',
            'num_tel_eleitor' => '(68) 99999-2222',
            'num_tel_eleitor_2' => '(68) 99999-3333',
        ]);

        $this->assertSame('num_tel_eleitor', $selecionado['fonte'] ?? null);
        $this->assertSame('5568999992222', $selecionado['e164'] ?? null);
    }

    #[DataProvider('telefonesNormalizados')]
    public function test_normaliza_formatos_recuperaveis(
        string $valor,
        string $nacional,
        string $normalizacaoCodigo,
        string $normalizacaoRotulo,
    ): void {
        $selecionado = (new ConvocacaoSmsTelefone)->selecionar([
            'telefone_perfil' => $valor,
        ]);

        $this->assertSame($nacional, $selecionado['nacional'] ?? null);
        $this->assertSame('55'.$nacional, $selecionado['e164'] ?? null);
        $this->assertSame($normalizacaoCodigo, $selecionado['normalizacao_codigo'] ?? null);
        $this->assertSame($normalizacaoRotulo, $selecionado['normalizacao_rotulo'] ?? null);
    }

    public static function telefonesNormalizados(): array
    {
        return [
            'codigo do pais com sinal' => [
                '+55 68 96999-8888', '68969998888',
                'PREFIXO_55_REMOVIDO', 'Prefixo 55 removido',
            ],
            'codigo do pais sem sinal' => [
                '5568969998888', '68969998888',
                'PREFIXO_55_REMOVIDO', 'Prefixo 55 removido',
            ],
            'prefixo nacional zero' => [
                '068969998888', '68969998888',
                'PREFIXO_0_REMOVIDO', 'Prefixo 0 removido',
            ],
            'local com nove digitos' => [
                '96999-8888', '68969998888',
                'DDD_68_INFERIDO', 'DDD 68 inferido',
            ],
            'local legado com oito digitos' => [
                '6999-8888', '68969998888',
                'DDD_68_INFERIDO+NONO_DIGITO_INFERIDO', 'DDD 68 inferido e nono dígito inferido',
            ],
            'legado com ddd' => [
                '(68) 6999-8888', '68969998888',
                'NONO_DIGITO_INFERIDO', 'Nono dígito inferido',
            ],
            'codigo do pais e legado com ddd' => [
                '55 68 6999-8888', '68969998888',
                'PREFIXO_55_REMOVIDO+NONO_DIGITO_INFERIDO', 'Prefixo 55 removido e nono dígito inferido',
            ],
        ];
    }

    public function test_telefone_marcado_como_fixo_nao_impede_fonte_posterior_valida(): void
    {
        $selecionado = (new ConvocacaoSmsTelefone)->selecionar([
            'num_tel_eleitor' => '68969998888',
            'tip_tel_eleitor' => 1,
            'num_tel_eleitor_2' => '96999-7777',
            'tip_tel_eleitor2' => 2,
        ]);

        $this->assertSame('num_tel_eleitor_2', $selecionado['fonte'] ?? null);
        $this->assertSame('5568969997777', $selecionado['e164'] ?? null);
        $this->assertSame('DDD_68_INFERIDO', $selecionado['normalizacao_codigo'] ?? null);
    }

    #[DataProvider('diagnosticosSemDestino')]
    public function test_diagnostica_por_que_nao_ha_destino(array $dados, string $codigo, string $rotulo): void
    {
        $avaliacao = (new ConvocacaoSmsTelefone)->avaliar($dados);

        $this->assertNull($avaliacao['telefone']);
        $this->assertSame($codigo, $avaliacao['diagnostico_codigo']);
        $this->assertSame($rotulo, $avaliacao['diagnostico_rotulo']);
    }

    public static function diagnosticosSemDestino(): array
    {
        return [
            'sem telefone' => [[], 'SEM_TELEFONE_INFORMADO', 'Sem telefone informado'],
            'somente fixo por formato' => [
                ['telefone_perfil' => '(68) 3222-1111'],
                'SOMENTE_TELEFONE_FIXO', 'Somente telefone fixo',
            ],
            'somente fixo pelo tipo elo' => [
                ['num_tel_eleitor' => '68969998888', 'tip_tel_eleitor' => 1],
                'SOMENTE_TELEFONE_FIXO', 'Somente telefone fixo',
            ],
            'local nao normalizavel' => [
                ['telefone_perfil' => '12345-6789'],
                'NUMERO_LOCAL_NAO_NORMALIZAVEL', 'Número local sem DDD não normalizável',
            ],
            'legado invalido' => [
                ['telefone_perfil' => '1234-5678'],
                'FORMATO_LEGADO_INVALIDO', 'Telefone legado não normalizável',
            ],
            'texto arbitrario' => [
                ['telefone_perfil' => 'ligar para Maria'],
                'FORMATO_INVALIDO', 'Telefone informado em formato inválido',
            ],
            'numero incompleto' => [
                ['telefone_perfil' => '9999'],
                'FORMATO_INVALIDO', 'Telefone informado em formato inválido',
            ],
            'multiplos numeros' => [
                ['telefone_perfil' => '68969998888 / 68969997777'],
                'FORMATO_INVALIDO', 'Telefone informado em formato inválido',
            ],
        ];
    }

    #[DataProvider('telefonesSemDestino')]
    public function test_retorna_nulo_quando_nao_existe_celular_valido(array $dados): void
    {
        $this->assertNull((new ConvocacaoSmsTelefone)->selecionar($dados));
    }

    public static function telefonesSemDestino(): array
    {
        return [
            'vazio' => [[]],
            'fixo' => [['telefone_perfil' => '(68) 3222-1111']],
            'texto arbitrario' => [['telefone_perfil' => 'ligar para Maria']],
            'numero incompleto' => [['telefone_perfil' => '9999']],
            'multiplos numeros' => [['telefone_perfil' => '68969998888 / 68969997777']],
        ];
    }
}
```
</TESTS_UNIT_CONVOCACAOSMSTELEFONETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatRotaMensagemRepositoryTest.php`
## <TESTS_UNIT_NATROTAMENSAGEMREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatRotaMensagemRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatRotaMensagemRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('zona', function ($table): void {
Schema::create('rota', function ($table): void {
Schema::create('nat_rota_conversa', function ($table): void {
Schema::create('nat_rota_mensagem', function ($table): void {
Schema::create('nat_rota_mensagem_leitura', function ($table): void {
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_lista_somente_rotas_com_nao_lidas_no_macroprojeto_e_escopo_zonal_do_usuario(): void
public function test_acesso_a_todas_as_zonas_inclui_rota_com_nao_lida_de_outra_zona(): void
public function test_escopo_restrito_sem_zonas_nao_retorna_rotas(): void
private function criarConversa(int $macroprojetoId, int $rotaId, ?string $arquivadaEm = null): int
private function criarMensagem(int $conversaId, ?string $usuarioLogin): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Nat\NatRotaMensagemRepository;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class NatRotaMensagemRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::dropIfExists('nat_rota_mensagem_leitura');
        Schema::dropIfExists('nat_rota_mensagem');
        Schema::dropIfExists('nat_rota_conversa');
        Schema::dropIfExists('rota');
        Schema::dropIfExists('zona');

        Schema::create('zona', function ($table): void {
            $table->increments('id');
            $table->integer('num_zona');
        });
        Schema::create('rota', function ($table): void {
            $table->increments('id');
            $table->integer('numero');
            $table->string('descricao')->nullable();
            $table->integer('zona_id')->nullable();
        });
        Schema::create('nat_rota_conversa', function ($table): void {
            $table->increments('id');
            $table->integer('macroprojeto_id');
            $table->string('escopo_tipo');
            $table->integer('rota_id')->nullable();
            $table->dateTime('arquivada_em')->nullable();
        });
        Schema::create('nat_rota_mensagem', function ($table): void {
            $table->increments('id');
            $table->integer('conversa_id');
            $table->string('usuario_login')->nullable();
        });
        Schema::create('nat_rota_mensagem_leitura', function ($table): void {
            $table->increments('id');
            $table->integer('mensagem_id');
            $table->string('usuario_login');
        });

        DB::table('zona')->insert([
            ['id' => 1, 'num_zona' => 4],
            ['id' => 2, 'num_zona' => 8],
        ]);
        DB::table('rota')->insert([
            ['id' => 39, 'numero' => 902, 'descricao' => 'Rota 902', 'zona_id' => 1],
            ['id' => 40, 'numero' => 903, 'descricao' => 'Somente lidas e próprias', 'zona_id' => 1],
            ['id' => 41, 'numero' => 904, 'descricao' => 'Fora do escopo', 'zona_id' => 2],
            ['id' => 42, 'numero' => 905, 'descricao' => 'Outro macroprojeto', 'zona_id' => 1],
            ['id' => 43, 'numero' => 906, 'descricao' => 'Arquivada', 'zona_id' => 1],
        ]);

        $conversaRota39 = $this->criarConversa(12, 39);
        $this->criarMensagem($conversaRota39, 'rota.39');
        $this->criarMensagem($conversaRota39, null);
        $this->criarMensagem($conversaRota39, ' NAT.TESTE ');
        $mensagemLida = $this->criarMensagem($conversaRota39, 'rota.39');
        DB::table('nat_rota_mensagem_leitura')->insert([
            'mensagem_id' => $mensagemLida,
            'usuario_login' => ' Nat.Teste ',
        ]);

        $conversaRota40 = $this->criarConversa(12, 40);
        $this->criarMensagem($conversaRota40, 'NAT.TESTE');
        $mensagemLidaRota40 = $this->criarMensagem($conversaRota40, 'rota.40');
        DB::table('nat_rota_mensagem_leitura')->insert([
            'mensagem_id' => $mensagemLidaRota40,
            'usuario_login' => 'nat.teste',
        ]);

        $this->criarMensagem($this->criarConversa(12, 41), 'rota.41');
        $this->criarMensagem($this->criarConversa(99, 42), 'rota.42');
        $this->criarMensagem($this->criarConversa(12, 43, '2026-08-17 10:00:00'), 'rota.43');
    }

    public function test_lista_somente_rotas_com_nao_lidas_no_macroprojeto_e_escopo_zonal_do_usuario(): void
    {
        $cards = app(NatRotaMensagemRepository::class)->cardsRotaComNaoLidas(
            12,
            [4],
            false,
            'nat.teste',
        );

        $this->assertSame([
            [
                'rota_id' => 39,
                'rota_numero' => 902,
                'rota_descricao' => 'Rota 902',
                'nao_lidas' => 2,
            ],
        ], $cards);
    }

    public function test_acesso_a_todas_as_zonas_inclui_rota_com_nao_lida_de_outra_zona(): void
    {
        $cards = app(NatRotaMensagemRepository::class)->cardsRotaComNaoLidas(
            12,
            [],
            true,
            'nat.teste',
        );

        $this->assertSame([39, 41], array_column($cards, 'rota_id'));
    }

    public function test_escopo_restrito_sem_zonas_nao_retorna_rotas(): void
    {
        $cards = app(NatRotaMensagemRepository::class)->cardsRotaComNaoLidas(
            12,
            [],
            false,
            'nat.teste',
        );

        $this->assertSame([], $cards);
    }

    private function criarConversa(int $macroprojetoId, int $rotaId, ?string $arquivadaEm = null): int
    {
        return (int) DB::table('nat_rota_conversa')->insertGetId([
            'macroprojeto_id' => $macroprojetoId,
            'escopo_tipo' => 'ROTA',
            'rota_id' => $rotaId,
            'arquivada_em' => $arquivadaEm,
        ]);
    }

    private function criarMensagem(int $conversaId, ?string $usuarioLogin): int
    {
        return (int) DB::table('nat_rota_mensagem')->insertGetId([
            'conversa_id' => $conversaId,
            'usuario_login' => $usuarioLogin,
        ]);
    }
}
```
</TESTS_UNIT_NATROTAMENSAGEMREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/NatRotaMensagemServiceTest.php`
## <TESTS_UNIT_NATROTAMENSAGEMSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/NatRotaMensagemServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class NatRotaMensagemServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_resumo_inclui_ultima_leitura_para_atualizar_confirmacao_sem_nova_mensagem(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Lda\LdaConversaMensagemRepository;
use App\Repositories\Nat\NatRotaMensagemRepository;
use App\Services\Nat\NatRotaMensagemService;
use Mockery;
use PHPUnit\Framework\TestCase;

class NatRotaMensagemServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_resumo_inclui_ultima_leitura_para_atualizar_confirmacao_sem_nova_mensagem(): void
    {
        $repository = Mockery::mock(NatRotaMensagemRepository::class);
        $repository->shouldReceive('contarNaoLidas')
            ->once()
            ->with([39], 1, 'nat.user')
            ->andReturn(0);
        $repository->shouldReceive('ultimaMensagemIdNoEscopo')
            ->once()
            ->with([39], 1)
            ->andReturn(100);
        $repository->shouldReceive('ultimaLeituraIdNoEscopo')
            ->once()
            ->with([39], 1)
            ->andReturn(77);
        $repository->shouldReceive('maxConversaAtivaIdNoEscopo')
            ->once()
            ->with([39], 1)
            ->andReturn(88);

        $ldaRepository = Mockery::mock(LdaConversaMensagemRepository::class);
        $ldaRepository->shouldNotReceive('buscarConversaPorIdNoEscopo');

        $service = new NatRotaMensagemService($repository, $ldaRepository);

        $resumo = $service->resumo(
            [['id' => 39, 'numero' => 902, 'descricao' => 'Rota 902']],
            1,
            ['login' => 'nat.user', 'nome' => 'Usuário NAT']
        );

        $this->assertSame([
            'total_nao_lidas' => 0,
            'ultima_mensagem_id' => 100,
            'ultima_leitura_id' => 77,
            'conversa_ativa_id' => 88,
        ], $resumo);
    }
}
```
</TESTS_UNIT_NATROTAMENSAGEMSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SmsDisponibilidadeTest.php`
## <TESTS_UNIT_SMSDISPONIBILIDADETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SmsDisponibilidadeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SmsDisponibilidadeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_libera_com_textbee_e_worker_sem_exigir_webhook(): void
public function test_falha_fechado_com_worker_desabilitado_sem_contar_webhook_ausente(): void
public function test_falha_fechado_sem_sincronizador_ativo(): void
public function test_exigir_lanca_erro_negocial_quando_indisponivel(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\SmsDisponibilidade;
use DomainException;
use Tests\TestCase;

class SmsDisponibilidadeTest extends TestCase
{
    public function test_libera_com_textbee_e_worker_sem_exigir_webhook(): void
    {
        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'worker_enabled' => true,
            'sync_enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'chave',
            'device_id' => 'device-1',
            'webhook_secret' => '',
        ]);

        $this->assertSame(['disponivel' => true, 'motivos' => []], app(SmsDisponibilidade::class)->diagnostico());
    }

    public function test_falha_fechado_com_worker_desabilitado_sem_contar_webhook_ausente(): void
    {
        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'worker_enabled' => false,
            'sync_enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'chave',
            'device_id' => 'device-1',
            'webhook_secret' => '',
        ]);

        $diagnostico = app(SmsDisponibilidade::class)->diagnostico();

        $this->assertFalse($diagnostico['disponivel']);
        $this->assertCount(1, $diagnostico['motivos']);
    }

    public function test_falha_fechado_sem_sincronizador_ativo(): void
    {
        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'worker_enabled' => true,
            'sync_enabled' => false,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'chave',
            'device_id' => 'device-1',
        ]);

        $diagnostico = app(SmsDisponibilidade::class)->diagnostico();

        $this->assertFalse($diagnostico['disponivel']);
        $this->assertStringContainsString('sincronização', implode(' ', $diagnostico['motivos']));
    }

    public function test_exigir_lanca_erro_negocial_quando_indisponivel(): void
    {
        config()->set('planeleito.sms_textbee.enabled', false);
        $this->expectException(DomainException::class);

        app(SmsDisponibilidade::class)->exigir();
    }
}
```
</TESTS_UNIT_SMSDISPONIBILIDADETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsCadenciaTest.php`
## <TESTS_UNIT_TEXTBEESMSCADENCIATEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsCadenciaTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsCadenciaTest extends TestCase`

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
public function test_serializa_por_aparelho_e_sim_usando_intervalo_calculado_pelos_segmentos(): void
public function test_cancelamento_anterior_a_chamada_nao_consome_a_janela(): void
public function test_aparelhos_ou_sims_distintos_possuem_janelas_independentes(): void
public function test_erro_de_limite_abre_pausa_sem_renovar_por_valor_menor(): void
private function cadencia(): TextBeeSmsCadencia
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\TextBeeSmsCadencia;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Sleep;
use Tests\TestCase;

class TextBeeSmsCadenciaTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee.min_interval_seconds', 15);
        config()->set('planeleito.sms_textbee.seconds_per_segment', 3);
        config()->set('planeleito.sms_textbee.limit_cooldown_seconds', 900);
        Cache::store('array')->clear();
        Carbon::setTestNow('2026-08-16 22:30:00');
        Sleep::fake(syncWithCarbon: true);
    }

    protected function tearDown(): void
    {
        Sleep::fake(false);
        Carbon::setTestNow();
        parent::tearDown();
    }

    public function test_serializa_por_aparelho_e_sim_usando_intervalo_calculado_pelos_segmentos(): void
    {
        $cadencia = $this->cadencia();
        $chamadas = 0;

        $cadencia->executar('device-1', 2, 6, static function () use (&$chamadas): bool {
            $chamadas++;

            return true;
        });
        $cadencia->executar('device-1', 2, 1, static function () use (&$chamadas): bool {
            $chamadas++;

            return true;
        });

        $this->assertSame(2, $chamadas);
        $this->assertSame(18, $cadencia->intervaloSegundos(6));
        $this->assertSame(15, $cadencia->intervaloSegundos(1));
        Sleep::assertSequence([Sleep::for(18)->seconds()]);
    }

    public function test_cancelamento_anterior_a_chamada_nao_consome_a_janela(): void
    {
        $cadencia = $this->cadencia();

        $cadencia->executar('device-1', null, 6, static fn (): bool => false);
        $cadencia->executar('device-1', null, 6, static fn (): bool => true);

        Sleep::assertNeverSlept();
    }

    public function test_aparelhos_ou_sims_distintos_possuem_janelas_independentes(): void
    {
        $cadencia = $this->cadencia();

        $cadencia->executar('device-1', 1, 6, static fn (): bool => true);
        $cadencia->executar('device-1', 2, 6, static fn (): bool => true);
        $cadencia->executar('device-2', 1, 6, static fn (): bool => true);

        Sleep::assertNeverSlept();
    }

    public function test_erro_de_limite_abre_pausa_sem_renovar_por_valor_menor(): void
    {
        $cadencia = $this->cadencia();

        $cadencia->pausarPorLimite('device-1', 2);
        $this->assertSame(900, $cadencia->segundosDePausa('device-1', 2));
        $this->assertSame(0, $cadencia->segundosDePausa('device-1', 1));

        Carbon::setTestNow(now()->addSeconds(300));
        $cadencia->pausarPorLimite('device-1', 2, 60);

        $this->assertSame(600, $cadencia->segundosDePausa('device-1', 2));
    }

    private function cadencia(): TextBeeSmsCadencia
    {
        return new TextBeeSmsCadencia(Cache::store('array'));
    }
}
```
</TESTS_UNIT_TEXTBEESMSCADENCIATEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsClientTest.php`
## <TESTS_UNIT_TEXTBEESMSCLIENTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsClientTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsClientTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_envia_individualmente_com_api_key_aparelho_sim_e_destino_e164(): void
public function test_sim_opcional_nao_e_enviado_quando_ausente(): void
public function test_erro_4xx_estruturado_inclusive_429_e_rejeicao_explicita(): void
public function test_erro_5xx_e_ambiguo(): void
public function test_resposta_de_sucesso_sem_sms_batch_id_e_ambigua(): void
public function test_falha_fechado_sem_configuracao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\TextBeeSmsClient;
use DomainException;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use RuntimeException;
use Tests\TestCase;

class TextBeeSmsClientTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'base_url' => 'https://api.textbee.dev',
            'api_key' => 'chave-secreta',
            'device_id' => 'device-123',
            'sim_subscription_id' => 2,
            'connect_timeout' => 2,
            'timeout' => 5,
        ]);
    }

    public function test_envia_individualmente_com_api_key_aparelho_sim_e_destino_e164(): void
    {
        Http::fake(['https://api.textbee.dev/api/v1/gateway/send-sms' => Http::response([
            'data' => ['smsBatchId' => 'batch-123'],
        ])]);

        $resultado = app(TextBeeSmsClient::class)->enviar('5568999991111', 'TRE-AC: Convocação', 'id-local');

        $this->assertTrue($resultado->aceito);
        $this->assertSame('batch-123', $resultado->idLote);
        Http::assertSent(static function (Request $request): bool {
            return $request->hasHeader('x-api-key', 'chave-secreta')
                && $request->url() === 'https://api.textbee.dev/api/v1/gateway/send-sms'
                && $request['deviceId'] === 'device-123'
                && $request['simSubscriptionId'] === 2
                && $request['recipients'] === ['+5568999991111']
                && $request['message'] === 'TRE-AC: Convocação'
                && ! isset($request['externalId']);
        });
    }

    public function test_sim_opcional_nao_e_enviado_quando_ausente(): void
    {
        config()->set('planeleito.sms_textbee.sim_subscription_id');
        Http::fake(['*' => Http::response(['data' => ['smsBatchId' => 'batch-1']])]);

        app(TextBeeSmsClient::class)->enviar('+5568999991111', 'Teste', 'id-local');

        Http::assertSent(static fn (Request $request): bool => ! isset($request['simSubscriptionId']));
    }

    public function test_erro_4xx_estruturado_inclusive_429_e_rejeicao_explicita(): void
    {
        Http::fake(['*' => Http::response(['error' => ['code' => 'RATE_LIMIT', 'message' => 'Quota exceeded']], 429)]);

        $resultado = app(TextBeeSmsClient::class)->enviar('5568999991111', 'Teste', 'id-local');

        $this->assertFalse($resultado->aceito);
        $this->assertTrue($resultado->rejeicaoExplicita);
        $this->assertSame('RATE_LIMIT', $resultado->codigoErro);
        $this->assertSame('Quota exceeded', $resultado->mensagemErro);
    }

    public function test_erro_5xx_e_ambiguo(): void
    {
        Http::fake(['*' => Http::response([], 503)]);
        $this->expectException(RuntimeException::class);
        app(TextBeeSmsClient::class)->enviar('5568999991111', 'Teste', 'id-local');
    }

    public function test_resposta_de_sucesso_sem_sms_batch_id_e_ambigua(): void
    {
        Http::fake(['*' => Http::response(['data' => []], 202)]);

        $this->expectException(RuntimeException::class);
        app(TextBeeSmsClient::class)->enviar('5568999991111', 'Teste', 'id-local');
    }

    public function test_falha_fechado_sem_configuracao(): void
    {
        config()->set('planeleito.sms_textbee.enabled', false);
        Http::fake();

        $this->expectException(DomainException::class);
        try {
            app(TextBeeSmsClient::class)->enviar('5568999991111', 'Teste', 'id-local');
        } finally {
            Http::assertNothingSent();
        }
    }
}
```
</TESTS_UNIT_TEXTBEESMSCLIENTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsSincronizacaoServiceTest.php`
## <TESTS_UNIT_TEXTBEESMSSINCRONIZACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsSincronizacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsSincronizacaoServiceTest extends TestCase`

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
public function test_entrega_consultada_registra_envio_e_entrega_em_ordem(): void
public function test_falha_individual_identifica_a_mensagem_sem_depender_do_lote_inteiro(): void
public function test_respostas_avancam_checkpoint_inclusivo_somente_depois_do_processamento(): void
public function test_falha_da_api_nao_avanca_checkpoint_nem_cria_evento(): void
private function service(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsSincronizacaoRepositoryInterface;
use App\Services\ConvocacaoSms\TextBeeSmsConsultaClient;
use App\Services\ConvocacaoSms\TextBeeSmsSincronizacaoService;
use App\Services\ConvocacaoSms\TextBeeSmsWebhookService;
use Illuminate\Support\Facades\Cache;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class TextBeeSmsSincronizacaoServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee', [
            'enabled' => true,
            'sync_enabled' => true,
            'sync_initial_from' => '2026-08-16T00:00:00Z',
            'device_id' => 'device-1',
        ]);
        config()->set('app.timezone', 'America/Rio_Branco');
        Cache::store('array')->clear();
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_entrega_consultada_registra_envio_e_entrega_em_ordem(): void
    {
        [$service, $consulta, $envios, $eventos] = $this->service();
        $envios->shouldReceive('listarTextBeePendentesSincronizacao')->once()->andReturn([[
            'id' => 10,
            'provider_batch_id' => 'batch-1',
            'provider_device_id' => 'device-1',
            'telefone_e164' => '5568999991111',
            'status_codigo' => 'ACEITO',
            'dt_criacao' => '2026-08-16 15:48:06',
        ]]);
        $consulta->shouldReceive('listarEnviadasDesde')->once()->with('2026-08-16T20:43:06Z')->andReturn([[
            '_id' => 'sms-1',
            'smsBatch' => 'batch-1',
            'device' => ['_id' => 'device-1'],
            'recipient' => '+5568999991111',
            'status' => 'delivered',
            'sentAt' => '2026-08-16T20:53:49Z',
            'deliveredAt' => '2026-08-16T20:53:54Z',
            'createdAt' => '2026-08-16T20:52:17Z',
        ]]);
        $eventos->shouldReceive('processar')->once()->ordered()->with(Mockery::on(
            static fn (array $evento): bool => $evento['webhookEvent'] === 'MESSAGE_SENT'
                && $evento['smsId'] === 'sms-1'
                && $evento['smsBatchId'] === 'batch-1',
        ))->andReturn(['recebidos' => 1, 'aplicados' => 1, 'ignorados' => 0]);
        $eventos->shouldReceive('processar')->once()->ordered()->with(Mockery::on(
            static fn (array $evento): bool => $evento['webhookEvent'] === 'MESSAGE_DELIVERED'
                && $evento['deliveredAt'] === '2026-08-16T20:53:54Z',
        ))->andReturn(['recebidos' => 1, 'aplicados' => 1, 'ignorados' => 0]);
        $consulta->shouldReceive('listarRecebidasDesde')->once()->with('2026-08-16T00:00:00Z')->andReturn([]);

        $resultado = $service->sincronizar();

        $this->assertSame(1, $resultado['envios_consultados']);
        $this->assertSame(2, $resultado['eventos_aplicados']);
        $this->assertSame(0, $resultado['respostas_consultadas']);
    }

    public function test_falha_individual_identifica_a_mensagem_sem_depender_do_lote_inteiro(): void
    {
        [$service, $consulta, $envios, $eventos] = $this->service();
        $envios->shouldReceive('listarTextBeePendentesSincronizacao')->once()->andReturn([[
            'id' => 10,
            'provider_batch_id' => 'batch-1',
            'provider_device_id' => 'device-1',
            'telefone_e164' => '5568999991111',
            'status_codigo' => 'ACEITO',
            'dt_criacao' => '2026-08-16 15:48:06',
        ]]);
        $consulta->shouldReceive('listarEnviadasDesde')->once()->with('2026-08-16T20:43:06Z')->andReturn([
            [
                '_id' => 'sms-outro', 'smsBatch' => 'batch-1', 'device' => ['_id' => 'device-1'],
                'recipient' => '+5568999992222', 'status' => 'failed', 'updatedAt' => '2026-08-16T20:54:00Z',
            ],
            [
                '_id' => 'sms-1', 'smsBatch' => 'batch-1', 'device' => ['_id' => 'device-1'],
                'recipient' => '+5568999991111', 'status' => 'failed', 'updatedAt' => '2026-08-16T20:54:01Z',
                'error' => ['code' => 'MODEM', 'message' => 'Falha da operadora'],
            ],
        ]);
        $eventos->shouldReceive('processar')->once()->with(Mockery::on(
            static fn (array $evento): bool => $evento['webhookEvent'] === 'MESSAGE_FAILED'
                && $evento['smsId'] === 'sms-1'
                && $evento['errorCode'] === 'MODEM',
        ))->andReturn(['recebidos' => 1, 'aplicados' => 1, 'ignorados' => 0]);
        $consulta->shouldReceive('listarRecebidasDesde')->once()->andReturn([]);

        $resultado = $service->sincronizar();

        $this->assertSame(1, $resultado['eventos_aplicados']);
    }

    public function test_respostas_avancam_checkpoint_inclusivo_somente_depois_do_processamento(): void
    {
        [$service, $consulta, $envios, $eventos] = $this->service();
        $envios->shouldReceive('listarTextBeePendentesSincronizacao')->once()->andReturn([]);
        $consulta->shouldNotReceive('listarEnviadasDesde');
        $consulta->shouldReceive('listarRecebidasDesde')->once()->with('2026-08-16T00:00:00Z')->andReturn([[
            '_id' => 'sms-r1',
            'device' => ['_id' => 'device-1'],
            'sender' => '+5568999991111',
            'message' => 'Confirmo',
            'receivedAt' => '2026-08-16T21:05:00Z',
            'createdAt' => '2026-08-16T21:05:02Z',
        ]]);
        $eventos->shouldReceive('processar')->once()->with(Mockery::on(
            static fn (array $evento): bool => $evento['webhookEvent'] === 'MESSAGE_RECEIVED'
                && $evento['sender'] === '+5568999991111'
                && $evento['message'] === 'Confirmo',
        ))->andReturn(['recebidos' => 1, 'aplicados' => 1, 'ignorados' => 0]);

        $resultado = $service->sincronizar();

        $this->assertSame(1, $resultado['respostas_aplicadas']);
        $this->assertSame(
            '2026-08-16T21:05:02Z',
            Cache::store('array')->get(TextBeeSmsSincronizacaoService::checkpointKey('device-1')),
        );
    }

    public function test_falha_da_api_nao_avanca_checkpoint_nem_cria_evento(): void
    {
        [$service, $consulta, $envios, $eventos] = $this->service();
        $envios->shouldReceive('listarTextBeePendentesSincronizacao')->once()->andReturn([]);
        $consulta->shouldNotReceive('listarEnviadasDesde');
        $consulta->shouldReceive('listarRecebidasDesde')->once()->andThrow(new RuntimeException('API indisponível'));
        $eventos->shouldNotReceive('processar');

        try {
            $service->sincronizar();
            $this->fail('A indisponibilidade deveria ser propagada.');
        } catch (RuntimeException) {
            $this->assertNull(Cache::store('array')->get(TextBeeSmsSincronizacaoService::checkpointKey('device-1')));
        }
    }

    /**
     * @return array{
     *   TextBeeSmsSincronizacaoService,
     *   Mockery\MockInterface,
     *   Mockery\MockInterface,
     *   Mockery\MockInterface
     * }
     */
    private function service(): array
    {
        $consulta = Mockery::mock(TextBeeSmsConsultaClient::class);
        $envios = Mockery::mock(ConvocacaoSmsSincronizacaoRepositoryInterface::class);
        $eventos = Mockery::mock(TextBeeSmsWebhookService::class);

        return [
            new TextBeeSmsSincronizacaoService($consulta, $envios, $eventos, Cache::store('array')),
            $consulta,
            $envios,
            $eventos,
        ];
    }
}
```
</TESTS_UNIT_TEXTBEESMSSINCRONIZACAOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsWebhookAutenticacaoTest.php`
## <TESTS_UNIT_TEXTBEESMSWEBHOOKAUTENTICACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsWebhookAutenticacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsWebhookAutenticacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_valida_hmac_sha256_hexadecimal_sobre_corpo_bruto_exato(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\TextBeeSmsWebhookAutenticacao;
use Tests\TestCase;

class TextBeeSmsWebhookAutenticacaoTest extends TestCase
{
    public function test_valida_hmac_sha256_hexadecimal_sobre_corpo_bruto_exato(): void
    {
        $corpo = '{"webhookEvent":"MESSAGE_SENT","smsId":"sms-1"}';
        $assinatura = hash_hmac('sha256', $corpo, 'segredo-forte');
        $auth = new TextBeeSmsWebhookAutenticacao('segredo-forte');

        $this->assertTrue($auth->assinaturaValida($corpo, $assinatura));
        $this->assertFalse($auth->assinaturaValida($corpo."\n", $assinatura));
        $this->assertFalse($auth->assinaturaValida($corpo, 'invalida'));
        $this->assertFalse((new TextBeeSmsWebhookAutenticacao(''))->assinaturaValida($corpo, $assinatura));
    }
}
```
</TESTS_UNIT_TEXTBEESMSWEBHOOKAUTENTICACAOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsWebhookControllerTest.php`
## <TESTS_UNIT_TEXTBEESMSWEBHOOKCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsWebhookControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsWebhookControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_rejeita_assinatura_antes_de_interpretar_json(): void
public function test_rejeita_json_invalido_corpo_grande_e_schema_invalido(): void
public function test_evento_valido_responde_duzentos(): void
private function controller(): TextBeeSmsWebhookController
private function requestAssinada(string $corpo): Request
private function request(string $corpo, string $assinatura): Request
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ConvocacaoSms\TextBeeSmsWebhookController;
use App\Services\ConvocacaoSms\TextBeeSmsWebhookAutenticacao;
use App\Services\ConvocacaoSms\TextBeeSmsWebhookService;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class TextBeeSmsWebhookControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_rejeita_assinatura_antes_de_interpretar_json(): void
    {
        $this->assertSame(401, $this->controller()->receber($this->request('{invalido', 'invalida'))->status());
    }

    public function test_rejeita_json_invalido_corpo_grande_e_schema_invalido(): void
    {
        $this->assertSame(400, $this->controller()->receber($this->requestAssinada('{invalido'))->status());
        $this->assertSame(413, $this->controller()->receber($this->requestAssinada(str_repeat('x', 65537)))->status());
        $this->assertSame(422, $this->controller()->receber($this->requestAssinada('{"webhookEvent":"MESSAGE_SENT"}'))->status());
    }

    public function test_evento_valido_responde_duzentos(): void
    {
        $corpo = json_encode([
            'webhookEvent' => 'MESSAGE_SENT', 'idempotencyKey' => 'event-1', 'smsId' => 'sms-1',
            'smsBatchId' => 'batch-1', 'deviceId' => 'device-1', 'recipient' => '+5568999991111',
        ], JSON_THROW_ON_ERROR);
        $service = Mockery::mock(TextBeeSmsWebhookService::class);
        $service->shouldReceive('processar')->once()->andReturn(['recebidos' => 1, 'aplicados' => 1, 'ignorados' => 0]);
        $controller = new TextBeeSmsWebhookController(new TextBeeSmsWebhookAutenticacao('segredo'), $service);

        $this->assertSame(200, $controller->receber($this->requestAssinada($corpo))->status());
    }

    private function controller(): TextBeeSmsWebhookController
    {
        $service = Mockery::mock(TextBeeSmsWebhookService::class);
        $service->shouldNotReceive('processar');

        return new TextBeeSmsWebhookController(new TextBeeSmsWebhookAutenticacao('segredo'), $service);
    }

    private function requestAssinada(string $corpo): Request
    {
        return $this->request($corpo, hash_hmac('sha256', $corpo, 'segredo'));
    }

    private function request(string $corpo, string $assinatura): Request
    {
        return Request::create('/rotas-publicas/integracoes/textbee/sms/webhook', 'POST', [], [], [], [
            'CONTENT_TYPE' => 'application/json', 'HTTP_X_SIGNATURE' => $assinatura,
        ], $corpo);
    }
}
```
</TESTS_UNIT_TEXTBEESMSWEBHOOKCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TextBeeSmsWebhookServiceTest.php`
## <TESTS_UNIT_TEXTBEESMSWEBHOOKSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TextBeeSmsWebhookServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TextBeeSmsWebhookServiceTest extends TestCase`

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
public function test_aplica_entrega_por_provedor_e_id_do_lote_sem_regredir(): void
public function test_resposta_e_vinculada_ao_unico_eleitor_do_envio_anterior_mais_recente(): void
public function test_resposta_com_telefone_associado_a_pessoas_distintas_fica_ambigua(): void
public function test_resposta_sem_envio_anterior_permanece_preservada_sem_vinculo(): void
public function test_evento_repetido_e_idempotente(): void
public function test_falha_5_nova_abre_pausa_para_o_aparelho_e_sim(): void
public function test_falha_5_duplicada_nao_renova_a_pausa(): void
private function service(): array
private function statusPayload(): array
private function respostaPayload(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRespostaRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\TextBeeSmsCadencia;
use App\Services\ConvocacaoSms\TextBeeSmsWebhookService;
use Illuminate\Support\Facades\Cache;
use Mockery;
use Tests\TestCase;

class TextBeeSmsWebhookServiceTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        config()->set('planeleito.sms_textbee.limit_cooldown_seconds', 900);
        Cache::store('array')->clear();
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_aplica_entrega_por_provedor_e_id_do_lote_sem_regredir(): void
    {
        [$service, $envios] = $this->service();
        $envios->shouldReceive('buscarPorLoteProvedor')->once()->with('TEXTBEE', 'batch-1')->andReturn([
            'id' => 10, 'status_codigo' => 'ENVIADO', 'telefone_e164' => '5568999991111',
            'provider_device_id' => 'device-1',
        ]);
        $envios->shouldReceive('aplicarEventoProvedor')->once()->with(
            10, 'TEXTBEE', 'event-1', 'sms-1', 'ENVIADO', 'ENTREGUE', 'MESSAGE_DELIVERED',
            null, null, Mockery::type('int'),
        )->andReturnTrue();

        $this->assertSame(1, $service->processar($this->statusPayload())['aplicados']);
    }

    public function test_resposta_e_vinculada_ao_unico_eleitor_do_envio_anterior_mais_recente(): void
    {
        [$service, , $respostas] = $this->service();
        $respostas->shouldReceive('buscarEnviosAnterioresCompativeis')->once()->with(
            '5568999991111', 'device-1', Mockery::type('int'),
        )->andReturn([
            ['id' => 12, 'num_zona' => '1', 'num_inscricao' => '111'],
            ['id' => 10, 'num_zona' => '1', 'num_inscricao' => '111'],
        ]);
        $respostas->shouldReceive('registrarRecebida')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === 12
                && $dados['vinculo_codigo'] === 'VINCULADA'
                && $dados['mensagem_texto'] === 'SIM, confirmo',
        ))->andReturnTrue();

        $this->assertSame(1, $service->processar($this->respostaPayload())['aplicados']);
    }

    public function test_resposta_com_telefone_associado_a_pessoas_distintas_fica_ambigua(): void
    {
        [$service, , $respostas] = $this->service();
        $respostas->shouldReceive('buscarEnviosAnterioresCompativeis')->once()->andReturn([
            ['id' => 12, 'num_zona' => '1', 'num_inscricao' => '111'],
            ['id' => 11, 'num_zona' => '2', 'num_inscricao' => '222'],
        ]);
        $respostas->shouldReceive('registrarRecebida')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === null && $dados['vinculo_codigo'] === 'AMBIGUA',
        ))->andReturnTrue();

        $this->assertSame(1, $service->processar($this->respostaPayload())['aplicados']);
    }

    public function test_resposta_sem_envio_anterior_permanece_preservada_sem_vinculo(): void
    {
        [$service, , $respostas] = $this->service();
        $respostas->shouldReceive('buscarEnviosAnterioresCompativeis')->once()->andReturn([]);
        $respostas->shouldReceive('registrarRecebida')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['envio_id'] === null && $dados['vinculo_codigo'] === 'SEM_ENVIO',
        ))->andReturnTrue();

        $this->assertSame(1, $service->processar($this->respostaPayload())['aplicados']);
    }

    public function test_evento_repetido_e_idempotente(): void
    {
        [$service, $envios] = $this->service();
        $envios->shouldReceive('buscarPorLoteProvedor')->once()->andReturn([
            'id' => 10, 'status_codigo' => 'ENVIADO', 'telefone_e164' => '5568999991111',
            'provider_device_id' => 'device-1',
        ]);
        $envios->shouldReceive('aplicarEventoProvedor')->once()->andReturnFalse();

        $this->assertSame(1, $service->processar($this->statusPayload())['ignorados']);
    }

    public function test_falha_5_nova_abre_pausa_para_o_aparelho_e_sim(): void
    {
        [$service, $envios, , $cadencia] = $this->service();
        $envios->shouldReceive('buscarPorLoteProvedor')->once()->andReturn([
            'id' => 10, 'status_codigo' => 'ACEITO', 'telefone_e164' => '5568999991111',
            'provider_device_id' => 'device-1', 'provider_sim_subscription_id' => 2,
        ]);
        $envios->shouldReceive('aplicarEventoProvedor')->once()->andReturnTrue();

        $resultado = $service->processar($this->falhaLimitePayload());

        $this->assertSame(1, $resultado['aplicados']);
        $this->assertSame(900, $cadencia->segundosDePausa('device-1', 2));
    }

    public function test_falha_5_duplicada_nao_renova_a_pausa(): void
    {
        [$service, $envios, , $cadencia] = $this->service();
        $envios->shouldReceive('buscarPorLoteProvedor')->once()->andReturn([
            'id' => 10, 'status_codigo' => 'NAO_ENTREGUE', 'telefone_e164' => '5568999991111',
            'provider_device_id' => 'device-1', 'provider_sim_subscription_id' => 2,
        ]);
        $envios->shouldReceive('aplicarEventoProvedor')->once()->andReturnFalse();

        $resultado = $service->processar($this->falhaLimitePayload());

        $this->assertSame(1, $resultado['ignorados']);
        $this->assertSame(0, $cadencia->segundosDePausa('device-1', 2));
    }

    /** @return array{TextBeeSmsWebhookService,Mockery\MockInterface,Mockery\MockInterface,TextBeeSmsCadencia} */
    private function service(): array
    {
        $envios = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $respostas = Mockery::mock(ConvocacaoSmsRespostaRepositoryInterface::class);
        $cadencia = new TextBeeSmsCadencia(Cache::store('array'));

        return [new TextBeeSmsWebhookService($envios, $respostas, new ConvocacaoSmsStatusService, $cadencia), $envios, $respostas, $cadencia];
    }

    /** @return array<string, mixed> */
    private function statusPayload(): array
    {
        return [
            'webhookEvent' => 'MESSAGE_DELIVERED', 'idempotencyKey' => 'event-1',
            'smsId' => 'sms-1', 'smsBatchId' => 'batch-1', 'deviceId' => 'device-1',
            'recipient' => '+5568999991111', 'deliveredAt' => '2026-08-16T12:00:00Z',
        ];
    }

    /** @return array<string, mixed> */
    private function respostaPayload(): array
    {
        return [
            'webhookEvent' => 'MESSAGE_RECEIVED', 'idempotencyKey' => 'event-r1',
            'smsId' => 'sms-r1', 'deviceId' => 'device-1', 'sender' => '+5568999991111',
            'message' => 'SIM, confirmo', 'receivedAt' => '2026-08-16T12:00:00Z',
        ];
    }

    /** @return array<string, mixed> */
    private function falhaLimitePayload(): array
    {
        return [
            'webhookEvent' => 'MESSAGE_FAILED', 'idempotencyKey' => 'event-limit-1',
            'smsId' => 'sms-1', 'smsBatchId' => 'batch-1', 'deviceId' => 'device-1',
            'recipient' => '+5568999991111', 'failedAt' => '2026-08-16T12:00:00Z',
            'errorCode' => '5', 'errorMessage' => 'Limite de envio atingido',
        ];
    }
}
```
</TESTS_UNIT_TEXTBEESMSWEBHOOKSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ZenviaSmsWebhookAutenticacaoTest.php`
## <TESTS_UNIT_ZENVIASMSWEBHOOKAUTENTICACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ZenviaSmsWebhookAutenticacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ZenviaSmsWebhookAutenticacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_exige_segredo_configurado_e_token_exato(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\ConvocacaoSms\ZenviaSmsWebhookAutenticacao;
use Tests\TestCase;

class ZenviaSmsWebhookAutenticacaoTest extends TestCase
{
    public function test_exige_segredo_configurado_e_token_exato(): void
    {
        $auth = new ZenviaSmsWebhookAutenticacao('segredo-forte');

        $this->assertTrue($auth->tokenValido('segredo-forte'));
        $this->assertFalse($auth->tokenValido('outro'));
        $this->assertFalse($auth->tokenValido(''));
        $this->assertFalse((new ZenviaSmsWebhookAutenticacao(''))->tokenValido(''));
    }
}
```
</TESTS_UNIT_ZENVIASMSWEBHOOKAUTENTICACAOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ZenviaSmsWebhookControllerTest.php`
## <TESTS_UNIT_ZENVIASMSWEBHOOKCONTROLLERTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ZenviaSmsWebhookControllerTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ZenviaSmsWebhookControllerTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_rejeita_segredo_antes_de_interpretar_json(): void
public function test_rejeita_json_invalido_e_corpo_acima_de_64_kib(): void
public function test_evento_valido_mas_nao_aplicavel_responde_duzentos(): void
private function controller(): ZenviaSmsWebhookController
private function request(string $corpo, string $segredo): Request
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ConvocacaoSms\ZenviaSmsWebhookController;
use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\ZenviaSmsWebhookAutenticacao;
use App\Services\ConvocacaoSms\ZenviaSmsWebhookService;
use Illuminate\Http\Request;
use Mockery;
use Tests\TestCase;

class ZenviaSmsWebhookControllerTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_rejeita_segredo_antes_de_interpretar_json(): void
    {
        $resposta = $this->controller()->receber($this->request('{invalido', 'errado'));

        $this->assertSame(401, $resposta->status());
    }

    public function test_rejeita_json_invalido_e_corpo_acima_de_64_kib(): void
    {
        $this->assertSame(400, $this->controller()->receber($this->request('{invalido', 'segredo'))->status());
        $this->assertSame(413, $this->controller()->receber($this->request(str_repeat('x', 65537), 'segredo'))->status());
    }

    public function test_evento_valido_mas_nao_aplicavel_responde_duzentos(): void
    {
        $payload = json_encode(['id' => 'e1', 'type' => 'MESSAGE_STATUS', 'channel' => 'WHATSAPP']);
        $resposta = $this->controller()->receber($this->request((string) $payload, 'segredo'));

        $this->assertSame(200, $resposta->status());
        $this->assertSame(1, $resposta->getData(true)['ignorados']);
    }

    private function controller(): ZenviaSmsWebhookController
    {
        $repository = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $repository->shouldNotReceive('buscarPorMensagemProvedor', 'aplicarEventoProvedor');

        return new ZenviaSmsWebhookController(
            new ZenviaSmsWebhookAutenticacao('segredo'),
            new ZenviaSmsWebhookService($repository, new ConvocacaoSmsStatusService),
        );
    }

    private function request(string $corpo, string $segredo): Request
    {
        return Request::create(
            '/rotas-publicas/integracoes/zenvia/sms/webhook',
            'POST',
            [],
            [],
            [],
            ['CONTENT_TYPE' => 'application/json', 'HTTP_X_PLANELEITO_WEBHOOK_TOKEN' => $segredo],
            $corpo,
        );
    }
}
```
</TESTS_UNIT_ZENVIASMSWEBHOOKCONTROLLERTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/ZenviaSmsWebhookServiceTest.php`
## <TESTS_UNIT_ZENVIASMSWEBHOOKSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/ZenviaSmsWebhookServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class ZenviaSmsWebhookServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_aplica_status_por_id_do_provedor_e_evento_idempotente(): void
public function test_ignora_mensagem_desconhecida_status_nao_sms_e_external_id_divergente(): void
public function test_persiste_causa_no_formato_oficial_v2_sem_expor_segredo(): void
private function payload(array $sobrescrever = []): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use App\Services\ConvocacaoSms\ConvocacaoSmsStatusService;
use App\Services\ConvocacaoSms\ZenviaSmsWebhookService;
use Mockery;
use Tests\TestCase;

class ZenviaSmsWebhookServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_aplica_status_por_id_do_provedor_e_evento_idempotente(): void
    {
        $repository = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $repository->shouldReceive('buscarPorMensagemProvedor')->once()->with('ZENVIA', 'zenvia-1')->andReturn([
            'id' => 10, 'status_codigo' => 'ACEITO', 'external_id' => 'local-1',
        ]);
        $repository->shouldReceive('aplicarEventoProvedor')->once()->with(
            10, 'ZENVIA', 'evento-1', 'zenvia-1', 'ACEITO', 'ENTREGUE', 'DELIVERED', null, null,
            Mockery::type('int'),
        )->andReturnTrue();

        $resultado = (new ZenviaSmsWebhookService(
            $repository,
            new ConvocacaoSmsStatusService,
        ))->processar($this->payload());

        $this->assertSame(['recebidos' => 1, 'aplicados' => 1, 'ignorados' => 0], $resultado);
    }

    public function test_ignora_mensagem_desconhecida_status_nao_sms_e_external_id_divergente(): void
    {
        $repository = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $repository->shouldReceive('buscarPorMensagemProvedor')->once()->with('ZENVIA', 'zenvia-1')->andReturn([
            'id' => 10, 'status_codigo' => 'ACEITO', 'external_id' => 'outro',
        ]);
        $repository->shouldNotReceive('aplicarEventoProvedor');
        $service = new ZenviaSmsWebhookService($repository, new ConvocacaoSmsStatusService);

        $this->assertSame(1, $service->processar($this->payload())['ignorados']);
        $this->assertSame(1, $service->processar($this->payload(['messageStatus' => ['code' => 'READ']]))['ignorados']);
        $this->assertSame(1, $service->processar($this->payload(['channel' => 'WHATSAPP']))['ignorados']);
    }

    public function test_persiste_causa_no_formato_oficial_v2_sem_expor_segredo(): void
    {
        $repository = Mockery::mock(ConvocacaoSmsEnvioRepositoryInterface::class);
        $repository->shouldReceive('buscarPorMensagemProvedor')->once()->with('ZENVIA', 'zenvia-1')->andReturn([
            'id' => 10, 'status_codigo' => 'ACEITO', 'external_id' => 'local-1',
        ]);
        $repository->shouldReceive('aplicarEventoProvedor')->once()->with(
            10, 'ZENVIA', 'evento-1', 'zenvia-1', 'ACEITO', 'NAO_ENTREGUE', 'NOT_DELIVERED', '42',
            'INVALID_DESTINATION — token=[redigido] bloqueado', Mockery::type('int'),
        )->andReturnTrue();

        $resultado = (new ZenviaSmsWebhookService(
            $repository,
            new ConvocacaoSmsStatusService,
        ))->processar($this->payload([
            'messageStatus' => [
                'code' => 'NOT_DELIVERED',
                'timestamp' => '2026-08-14T12:00:00Z',
                'causes' => [[
                    'channelErrorCode' => '42',
                    'reason' => 'INVALID_DESTINATION',
                    'details' => 'token=segredo bloqueado',
                ]],
            ],
        ]));

        $this->assertSame(1, $resultado['aplicados']);
    }

    /** @param array<string, mixed> $sobrescrever @return array<string, mixed> */
    private function payload(array $sobrescrever = []): array
    {
        return array_replace_recursive([
            'id' => 'evento-1',
            'timestamp' => '2026-08-14T12:00:00Z',
            'type' => 'MESSAGE_STATUS',
            'channel' => 'SMS',
            'message' => ['id' => 'zenvia-1', 'externalId' => 'local-1'],
            'messageStatus' => ['code' => 'DELIVERED', 'timestamp' => '2026-08-14T12:00:00Z'],
        ], $sobrescrever);
    }
}
```
</TESTS_UNIT_ZENVIASMSWEBHOOKSERVICETEST_PHP>

