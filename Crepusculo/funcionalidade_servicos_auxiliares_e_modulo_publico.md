# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_servicos_auxiliares_e_modulo_publico`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 159  
> **Tamanho do Arquivo:** 975 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ColaboradoresEleitorais/EventoVoluntarioPublicoController.php`
## <APP_HTTP_CONTROLLERS_COLABORADORESELEITORAIS_EVENTOVOLUNTARIOPUBLICOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ColaboradoresEleitorais/EventoVoluntarioPublicoController.php`
- **Namespace Declaração:** `App\Http\Controllers\ColaboradoresEleitorais`
- **Entidade / Classe:** `class EventoVoluntarioPublicoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(): Response
public function consultar(EventoVoluntarioPublicoLookupRequest $request): Response
private function responder(array $dados): Response
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ColaboradoresEleitorais;

use App\Http\Controllers\Controller;
use App\Http\Requests\ColaboradoresEleitorais\EventoVoluntarioPublicoLookupRequest;
use App\Services\ColaboradoresEleitorais\EventoVoluntarioPublicoService;
use Symfony\Component\HttpFoundation\Response;

class EventoVoluntarioPublicoController extends Controller
{
    public function __construct(
        private readonly EventoVoluntarioPublicoService $service
    ) {}

    public function index(): Response
    {
        return $this->responder([
            'consultaRealizada' => false,
            'nomeAnonimizado' => null,
            'ocorrencias' => [],
        ]);
    }

    public function consultar(EventoVoluntarioPublicoLookupRequest $request): Response
    {
        $dados = $request->validated();
        $resultado = $this->service->consultar($dados['num_inscricao']);

        return $this->responder([
            'consultaRealizada' => true,
            'nomeAnonimizado' => $resultado['nome_anonimizado'],
            'ocorrencias' => $resultado['ocorrencias'],
        ]);
    }

    /** @param array<string, mixed> $dados */
    private function responder(array $dados): Response
    {
        $response = response()->view(
            'colaboradores-eleitorais.eventos-publicos.index',
            $dados
        );
        $response->headers->set('Cache-Control', 'no-store, private, max-age=0');
        $response->headers->set('Pragma', 'no-cache');
        $response->headers->set('Expires', '0');
        $response->headers->set('Referrer-Policy', 'no-referrer');
        $response->headers->set('X-Content-Type-Options', 'nosniff');
        $response->headers->set('X-Frame-Options', 'DENY');
        $response->headers->set('X-Robots-Tag', 'noindex, nofollow');
        $response->headers->set(
            'Content-Security-Policy',
            "default-src 'self'; base-uri 'self'; form-action 'self'; frame-ancestors 'none'; object-src 'none'; script-src 'none'; style-src 'self'; img-src 'self' data:; font-src 'self'"
        );

        return $response;
    }
}
```
</APP_HTTP_CONTROLLERS_COLABORADORESELEITORAIS_EVENTOVOLUNTARIOPUBLICOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Gel/GelSyncController.php`
## <APP_HTTP_CONTROLLERS_GEL_GELSYNCCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Gel/GelSyncController.php`
- **Namespace Declaração:** `App\Http\Controllers\Gel`
- **Entidade / Classe:** `class GelSyncController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function sincronizarAc(): JsonResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Gel;

use App\Http\Controllers\Controller;
use App\Services\Gel\GelSyncService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use Illuminate\Http\JsonResponse;

class GelSyncController extends Controller
{
    public function __construct(
        private readonly GelSyncService $service,
        private readonly LocalVotacaoSyncStatusService $statusService,
    ) {
    }

    public function sincronizarAc(): JsonResponse
    {
        $this->autorizarAdmin();

        try {
            $resultado = $this->service->sincronizarAcCompleto();
        } catch (\Throwable $e) {
            $this->statusService->registrarErro('sync:gel:ac', $e, [
                'etapa' => 'gel_ac',
                'origem' => 'interface-web',
            ]);

            return response()->json([
                'mensagem' => 'Erro na sincronização GEL AC: ' . $e->getMessage(),
            ], 500);
        }

        $this->statusService->registrarSucesso('sync:gel:ac', $resultado, [
            'etapa' => 'gel_ac',
            'origem' => 'interface-web',
            'mensagem' => 'Sincronização GEL AC concluída com sucesso.',
        ]);

        return response()->json([
            'mensagem' => 'Sincronização GEL AC concluída com sucesso.',
            'resultado' => $resultado,
        ]);
    }
}
```
</APP_HTTP_CONTROLLERS_GEL_GELSYNCCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Rcand/RcandController.php`
## <APP_HTTP_CONTROLLERS_RCAND_RCANDCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Rcand/RcandController.php`
- **Namespace Declaração:** `App\Http\Controllers\Rcand`
- **Entidade / Classe:** `class RcandController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(RcandFiltroRequest $request): View
public function dados(RcandFiltroRequest $request): JsonResponse
public function exportarPdf(RcandFiltroRequest $request): Response
private function filtros(RcandFiltroRequest $request): array
private function aba(RcandFiltroRequest $request): string
private function visaoCand(RcandFiltroRequest $request, string $aba): string
private function perPage(RcandFiltroRequest $request): int
private function camposPdfPermitidos(string $aba, string $visaoCand): array
private function camposPdfPadrao(string $aba, string $visaoCand): array
private function autorizarRcand(string $rotaNome): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Rcand;

use App\Http\Controllers\Controller;
use App\Http\Requests\Rcand\RcandFiltroRequest;
use App\Repositories\Rcand\RcandRepository;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use App\Support\Exportacao\CamposPdfSelecionados;
use App\Support\Rcand\RcandVisaoCand;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\JsonResponse;
use Illuminate\View\View;
use Symfony\Component\HttpFoundation\Response;

class RcandController extends Controller
{
    private const ABAS = [
        'gerencial' => 'Gerencial',
        'detalhes' => 'Detalhes',
        'segundo-grau' => '2º GRAU',
        'draps' => 'DRAPs',
        'cand' => 'CAND',
        'glossario' => 'Glossário',
    ];

    private const CAMPOS_PDF_PERMITIDOS = [
        'cd_eleicao' => 'Código da eleição',
        'nm_eleicao' => 'Eleição',
        'nr_processo' => 'Processo',
        'partidos' => 'Partidos',
        'tipo_registro' => 'Tipo',
        'cand_processo' => 'Processo CAND',
        'cand_situacao_processo' => 'Situação CAND',
        'cand_tipo_processo' => 'Tipo CAND',
        'julgados_pje_sn' => 'Julgado PJe',
        'julgados_cand_sn' => 'Julgado CAND',
        'if_cand_x_pje' => 'CAND x PJe',
        'cert_publ_sn' => 'Cert. Publ S/N',
        'inform_candidato_sn' => 'Inform. Candidato S/N',
        'sem_int_mpe' => 'Parecer MPE S/N',
        'todas_peticoes_lidas' => 'Petições Avulsas',
        'impugnacoes' => 'Impugnações',
        'edital' => 'Juntada do Edital',
        'certidao_publicacao' => 'Publicação DJE',
        'primeira_diligencia' => 'Primeira Diligência',
        'resposta_juntada_diligencia' => 'Resposta Diligência',
        'informacao_candidato' => 'Informação do Candidato',
        'envio_mpf' => 'Envio ao MPF',
        'intimacao_mp_parecer' => 'Juntada Parecer MPE',
        'conclusao' => 'Conclusão',
        'peticoes_avulsas' => 'Petições Avulsas Datas',
        'primeiro_julgamento' => 'Primeiro Julgamento',
        'data_primeiro_recurso' => 'Primeiro Recurso',
        'contrarrazao' => 'Contrarrazão',
        'remessa_tre' => 'Remessa ao TRE',
        'recurso' => 'Recurso',
        'teor_julgamento' => 'Teor do julgamento',
        'st_divergencia' => 'Integridade PJe/CAND',
    ];

    private const CAMPOS_PDF_VISOES_CAND = [
        RcandVisaoCand::PROCESSOS => [
            'cd_eleicao' => 'Código da eleição',
            'nm_eleicao' => 'Eleição',
            'nr_processo' => 'Processo',
            'partidos' => 'Partidos',
            'ds_situacao_processo' => 'Situação CAND',
            'tp_processo' => 'Tipo',
        ],
        RcandVisaoCand::COMPARACAO => [
            'cd_eleicao' => 'Código da eleição',
            'nm_eleicao' => 'Eleição',
            'nr_processo' => 'Processo',
            'partidos' => 'Partidos',
            'julgados_pje_sn' => 'Julgado PJe',
            'julgados_cand_sn' => 'Julgado CAND',
            'if_cand_x_pje' => 'Comparação CAND x PJe',
        ],
        RcandVisaoCand::PEDIDOS => [
            'cd_eleicao' => 'Código da eleição',
            'nm_eleicao' => 'Eleição',
            'sq_pedido' => 'Pedido',
            'partidos' => 'Partidos',
            'sg_ue' => 'UE',
            'nr_processo_drap' => 'Processo DRAP',
            'st_popula' => 'Status',
        ],
        RcandVisaoCand::CANDIDATOS => [
            'cd_eleicao' => 'Código da eleição',
            'nm_eleicao' => 'Eleição',
            'nm_candidato' => 'Candidato',
            'nm_urna' => 'Nome de urna',
            'sq_pedido' => 'Pedido',
            'nr_candidato' => 'Número',
            'partidos' => 'Partidos',
        ],
    ];

    private const CAMPOS_PDF_PADRAO = [
        'cd_eleicao',
        'nr_processo',
        'partidos',
        'tipo_registro',
        'cand_situacao_processo',
        'julgados_pje_sn',
        'julgados_cand_sn',
        'if_cand_x_pje',
    ];

    public function __construct(
        private readonly RcandRepository $repository,
        private readonly LocalVotacaoSyncStatusService $statusService,
    ) {}

    public function index(RcandFiltroRequest $request): View
    {
        $this->autorizarRcand('rcand.index');
        $aba = $this->aba($request);
        $visaoCand = $this->visaoCand($request, $aba);
        $filtros = $this->filtros($request);
        $perPage = $this->perPage($request);
        $paginatorQuery = $request->except('page', 'cand_page', 'candexweb_pedidos_page', 'candexweb_candidatos_page', 'zona', 'municipio');
        $registros = null;
        $registrosVisaoCand = null;
        $totaisVisoesCand = [];

        if ($aba === 'cand') {
            $pageName = RcandVisaoCand::pageName($visaoCand);
            $registrosVisaoCand = match ($visaoCand) {
                RcandVisaoCand::PROCESSOS => $this->repository->listarCandPaginado($filtros, $perPage, $pageName),
                RcandVisaoCand::COMPARACAO => $this->repository->listarPaginado($filtros, $aba, $perPage, $pageName),
                RcandVisaoCand::PEDIDOS => $this->repository->listarCandexwebPedidosPaginado($filtros, $perPage, $pageName),
                RcandVisaoCand::CANDIDATOS => $this->repository->listarCandexwebCandidatosPaginado($filtros, $perPage, $pageName),
                default => throw new \InvalidArgumentException('Visualização CAND inválida.'),
            };
            $registrosVisaoCand->appends($paginatorQuery);
            $totaisVisoesCand = $this->repository->totaisVisoesCand($filtros);
        } else {
            $registros = $this->repository
                ->listarPaginado($filtros, $aba, $perPage, 'page')
                ->appends($paginatorQuery);
        }

        return view('rcand.index', [
            'abas' => self::ABAS,
            'abaAtual' => $aba,
            'abaTitulo' => self::ABAS[$aba],
            'visoesCand' => RcandVisaoCand::opcoes(),
            'visaoCandAtual' => $visaoCand,
            'filtros' => $filtros,
            'opcoes' => $this->repository->opcoes(),
            'resumo' => $this->repository->resumo($filtros, $aba),
            'graficos' => $this->repository->graficos($filtros, $aba),
            'registros' => $registros,
            'registrosVisaoCand' => $registrosVisaoCand,
            'totaisVisoesCand' => $totaisVisoesCand,
            'syncStatus' => collect($this->statusService->obterRegistrosMonitorados())->keyBy('chave'),
            'camposPdf' => $this->camposPdfPermitidos($aba, $visaoCand),
            'camposPdfPadrao' => $this->camposPdfPadrao($aba, $visaoCand),
            'podeSincronizarRcand' => session('is_admin') === true
                || $this->usuarioTemAcessoRotaSessao('administracao-global.sync-rcand.index'),
        ]);
    }

    public function dados(RcandFiltroRequest $request): JsonResponse
    {
        $this->autorizarRcand('rcand.dados');
        $aba = $this->aba($request);
        $filtros = $this->filtros($request);
        $registros = $this->repository->listarPaginado($filtros, $aba, $this->perPage($request));

        return response()->json([
            'aba' => $aba,
            'resumo' => $this->repository->resumo($filtros, $aba),
            'graficos' => $this->repository->graficos($filtros, $aba),
            'registros' => $registros->items(),
            'total' => $registros->total(),
            'pagina' => $registros->currentPage(),
        ]);
    }

    public function exportarPdf(RcandFiltroRequest $request): Response
    {
        $this->autorizarRcand('rcand.exportar-pdf');
        $aba = $this->aba($request);
        $visaoCand = $this->visaoCand($request, $aba);
        $filtros = $this->filtros($request);
        $camposPermitidos = $this->camposPdfPermitidos($aba, $visaoCand);
        $campos = CamposPdfSelecionados::resolver(
            $request->query('campos'),
            $camposPermitidos,
            $this->camposPdfPadrao($aba, $visaoCand),
        );
        $tituloVisao = $aba === 'cand' ? ' - '.RcandVisaoCand::rotulo($visaoCand) : '';
        $registros = $aba === 'cand'
            ? $this->repository->listarParaExportacao($filtros, $aba, $visaoCand)
            : $this->repository->listarParaExportacao($filtros, $aba);

        $pdf = Pdf::loadView('rcand.pdf', [
            'titulo' => 'Relatório RCAND - '.self::ABAS[$aba].$tituloVisao,
            'aba' => $aba,
            'registros' => $registros,
            'filtros' => $filtros,
            'camposPdf' => $camposPermitidos,
            'camposSelecionados' => $campos,
            'geradoEm' => now()->format('d/m/Y H:i'),
        ])->setPaper('a4', 'landscape');

        $sufixoVisao = $aba === 'cand' ? '-'.$visaoCand : '';

        return $pdf->download('painel-rcand-'.$aba.$sufixoVisao.'.pdf');
    }

    /** @return array<string, string> */
    private function filtros(RcandFiltroRequest $request): array
    {
        $dados = $request->validated();

        return array_filter([
            'processo' => trim((string) ($dados['processo'] ?? '')),
            'partido' => trim((string) ($dados['partido'] ?? '')),
            'tipo' => trim((string) ($dados['tipo'] ?? '')),
            'divergencia' => trim((string) ($dados['divergencia'] ?? '')),
            'integridade' => trim((string) ($dados['integridade'] ?? '')),
            'situacao_cand' => trim((string) ($dados['situacao_cand'] ?? '')),
            'julgamento' => trim((string) ($dados['julgamento'] ?? '')),
            'cert_publicacao' => trim((string) ($dados['cert_publicacao'] ?? '')),
            'informacao' => trim((string) ($dados['informacao'] ?? '')),
            'impugnacao' => trim((string) ($dados['impugnacao'] ?? '')),
            'julgado_pje' => trim((string) ($dados['julgado_pje'] ?? '')),
            'data_primeiro_recurso' => trim((string) ($dados['data_primeiro_recurso'] ?? '')),
            'contrarrazao' => trim((string) ($dados['contrarrazao'] ?? '')),
            'remessa_tre' => trim((string) ($dados['remessa_tre'] ?? '')),
        ], static fn (string $valor): bool => $valor !== '');
    }

    private function aba(RcandFiltroRequest $request): string
    {
        $aba = (string) $request->query('aba', 'gerencial');
        if ($aba === 'primeiro-grau') {
            return 'segundo-grau';
        }

        return array_key_exists($aba, self::ABAS) ? $aba : 'gerencial';
    }

    private function visaoCand(RcandFiltroRequest $request, string $aba): string
    {
        if ($aba !== 'cand') {
            return RcandVisaoCand::PADRAO;
        }

        return RcandVisaoCand::resolver((string) $request->validated('visao_cand', ''));
    }

    private function perPage(RcandFiltroRequest $request): int
    {
        $perPage = (int) $request->query('per_page', 50);

        return max(10, min(100, $perPage));
    }

    /** @return array<string, string> */
    private function camposPdfPermitidos(string $aba, string $visaoCand): array
    {
        return $aba === 'cand'
            ? self::CAMPOS_PDF_VISOES_CAND[$visaoCand]
            : self::CAMPOS_PDF_PERMITIDOS;
    }

    /** @return array<int, string> */
    private function camposPdfPadrao(string $aba, string $visaoCand): array
    {
        if ($aba === 'cand') {
            return array_keys(self::CAMPOS_PDF_VISOES_CAND[$visaoCand]);
        }

        return self::CAMPOS_PDF_PADRAO;
    }

    private function autorizarRcand(string $rotaNome): void
    {
        if (session('is_admin') === true || $this->usuarioTemAcessoRotaSessao($rotaNome)) {
            return;
        }

        abort(403, 'Operacao permitida apenas para usuarios autorizados no RCAND.');
    }
}
```
</APP_HTTP_CONTROLLERS_RCAND_RCANDCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Rcand/RcandSyncController.php`
## <APP_HTTP_CONTROLLERS_RCAND_RCANDSYNCCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Rcand/RcandSyncController.php`
- **Namespace Declaração:** `App\Http\Controllers\Rcand`
- **Entidade / Classe:** `class RcandSyncController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(): View
public function sincronizarPje(): JsonResponse
public function sincronizarCand(): JsonResponse
public function sincronizarConsolidado(): JsonResponse
public function sincronizarSequencial(): JsonResponse
private function executarSincronizacaoHttp(string $etapa, string $mensagemSucesso, callable $executar): JsonResponse
private function autorizarRcandSync(string $rotaNome): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Rcand;

use App\Http\Controllers\Controller;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use App\Services\Rcand\RcandSyncService;
use Illuminate\Http\JsonResponse;
use Illuminate\View\View;

class RcandSyncController extends Controller
{
    public function __construct(
        private readonly RcandSyncService $service,
        private readonly LocalVotacaoSyncStatusService $statusService,
    ) {
    }

    public function index(): View
    {
        $this->autorizarRcandSync('administracao-global.sync-rcand.index');

        return view('administracao-global.sincronizacao-local-votacao.index');
    }

    public function sincronizarPje(): JsonResponse
    {
        $this->autorizarRcandSync('administracao-global.sync-rcand.pje.executar');

        return $this->executarSincronizacaoHttp(
            'rcand_pje',
            'Sincronização RCAND PJe concluída com sucesso.',
            fn () => $this->service->sincronizarPje()
        );
    }

    public function sincronizarCand(): JsonResponse
    {
        $this->autorizarRcandSync('administracao-global.sync-rcand.cand.executar');

        return $this->executarSincronizacaoHttp(
            'rcand_cand',
            'Sincronização RCAND CAND concluída com sucesso.',
            fn () => $this->service->sincronizarCand()
        );
    }

    public function sincronizarConsolidado(): JsonResponse
    {
        $this->autorizarRcandSync('administracao-global.sync-rcand.consolidado.executar');

        return $this->executarSincronizacaoHttp(
            'rcand_consolidado',
            'Consolidação RCAND concluída com sucesso.',
            fn () => $this->service->sincronizarConsolidado()
        );
    }

    public function sincronizarSequencial(): JsonResponse
    {
        $this->autorizarRcandSync('administracao-global.sync-rcand.sequencial.executar');

        try {
            $resultado = $this->service->sincronizarSequencial();
        } catch (\Throwable $e) {
            $this->statusService->registrarErro('sync:rcand:sequencial', $e, [
                'etapa' => 'rcand_sequencial',
                'origem' => 'interface-web',
            ]);

            return response()->json([
                'mensagem' => 'Erro na sincronização sequencial RCAND: ' . $e->getMessage(),
            ], 500);
        }

        $totalOrigem = array_sum(array_map(static fn (array $item): int => (int) ($item['origem_total'] ?? 0), $resultado));
        $totalDestino = (int) ($resultado['rcand_consolidado']['destino_total'] ?? 0);

        foreach ($resultado as $etapa => $resultadoEtapa) {
            $this->statusService->registrarSucesso('sync:rcand:sequencial', $resultadoEtapa, [
                'etapa' => (string) $etapa,
                'origem' => 'interface-web',
                'mensagem' => "Sincronização da etapa {$etapa} concluída com sucesso.",
            ]);
        }

        $this->statusService->registrarSucesso('sync:rcand:sequencial', [
            'dblink' => (string) ($resultado['rcand_cand']['dblink'] ?? ''),
            'origem_total' => $totalOrigem,
            'destino_total' => $totalDestino,
        ], [
            'etapa' => 'rcand_sequencial',
            'origem' => 'interface-web',
            'mensagem' => 'Sincronização sequencial RCAND concluída com sucesso.',
        ]);

        return response()->json([
            'mensagem' => 'Sincronização sequencial RCAND concluída com sucesso.',
            'resultado' => [
                'dblink' => (string) ($resultado['rcand_cand']['dblink'] ?? ''),
                'origem_total' => $totalOrigem,
                'destino_total' => $totalDestino,
                'etapas' => $resultado,
            ],
        ]);
    }

    private function executarSincronizacaoHttp(string $etapa, string $mensagemSucesso, callable $executar): JsonResponse
    {
        try {
            $resultado = $executar();

            $this->statusService->registrarSucesso('sync:rcand', $resultado, [
                'etapa' => $etapa,
                'origem' => 'interface-web',
                'mensagem' => $mensagemSucesso,
            ]);

            return response()->json([
                'mensagem' => $mensagemSucesso,
                'resultado' => $resultado,
            ]);
        } catch (\Throwable $e) {
            $this->statusService->registrarErro('sync:rcand', $e, [
                'etapa' => $etapa,
                'origem' => 'interface-web',
            ]);

            return response()->json([
                'mensagem' => 'Erro na sincronização de ' . $etapa . ': ' . $e->getMessage(),
            ], 500);
        }
    }

    private function autorizarRcandSync(string $rotaNome): void
    {
        if (session('is_admin') === true || $this->usuarioTemAcessoRotaSessao($rotaNome)) {
            return;
        }

        abort(403, 'Operacao permitida apenas para usuarios autorizados no RCAND.');
    }
}
```
</APP_HTTP_CONTROLLERS_RCAND_RCANDSYNCCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/SeuVotoImporta/SeuVotoImportaAdminController.php`
## <APP_HTTP_CONTROLLERS_SEUVOTOIMPORTA_SEUVOTOIMPORTAADMINCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/SeuVotoImporta/SeuVotoImportaAdminController.php`
- **Namespace Declaração:** `App\Http\Controllers\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaAdminController extends Controller`

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
public function show(int $id): View
public function atualizarStatus(int $id, SeuVotoImportaStatusRequest $request): RedirectResponse
public function atualizarTurno(int $id, int $turno, SeuVotoImportaTurnoRequest $request): RedirectResponse
public function downloadAnexo(int $id, int $anexo): StreamedResponse
public function exportarPdf(Request $request): Response
public function editarConfiguracao(Request $request): View
public function atualizarConfiguracao(SeuVotoImportaConfiguracaoRequest $request): RedirectResponse
private function filtros(Request $request): array
private function dataFiltro(mixed $valor): string
private function usuarioSessao(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\SeuVotoImporta;

use App\Http\Controllers\Controller;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaConfiguracaoRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaStatusRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaTurnoRequest;
use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaFluxoStatusService;
use App\Support\Exportacao\CamposPdfSelecionados;
use App\Support\SeuVotoImporta\SeuVotoImportaMascarador;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\CarbonImmutable;
use DomainException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Throwable;

class SeuVotoImportaAdminController extends Controller
{
    private const CAMPOS_PDF = [
        'protocolo' => 'Protocolo',
        'status' => 'Estado',
        'nome' => 'Eleitor',
        'titulo' => 'Título eleitoral',
        'zona' => 'Zona',
        'municipio' => 'Município',
        'local' => 'Local de votação',
        'email' => 'E-mail',
        'telefone' => 'Telefone',
        'recebida_em' => 'Recebida em',
    ];

    private const CAMPOS_PDF_PADRAO = [
        'protocolo', 'status', 'nome', 'zona', 'municipio', 'local', 'recebida_em',
    ];

    public function __construct(
        private readonly SeuVotoImportaSolicitacaoRepository $repository,
        private readonly SeuVotoImportaFluxoStatusService $fluxo,
        private readonly SeuVotoImportaMascarador $mascarador,
    ) {
    }

    public function index(Request $request): View
    {
        $filtros = $this->filtros($request);

        return view('seu-voto-importa.admin.index', [
            'solicitacoes' => $this->repository->listarAdministrativo($filtros, $this->escopoZonalSessao()),
            'filtros' => $filtros,
            'statusSolicitacao' => $this->repository->statusSolicitacao(),
            'camposPdf' => self::CAMPOS_PDF,
            'camposPdfPadrao' => self::CAMPOS_PDF_PADRAO,
        ]);
    }

    public function show(int $id): View
    {
        $detalhe = $this->repository->buscarDetalheAdministrativo($id, $this->escopoZonalSessao());
        abort_if($detalhe === null, 404, 'Solicitação não encontrada no escopo permitido.');

        return view('seu-voto-importa.admin.show', $detalhe + [
            'statusSolicitacao' => $this->repository->statusSolicitacao(),
            'statusTurno' => $this->repository->statusTurno(),
            'mascarador' => $this->mascarador,
        ]);
    }

    public function atualizarStatus(int $id, SeuVotoImportaStatusRequest $request): RedirectResponse
    {
        $detalhe = $this->repository->buscarDetalheAdministrativo($id, $this->escopoZonalSessao());
        abort_if($detalhe === null, 404, 'Solicitação não encontrada no escopo permitido.');
        $atual = (string) $this->valor($detalhe['solicitacao'], 'status_codigo');
        $novo = (string) $request->validated('status_codigo');

        $mensagem = $request->validated('mensagem_publica');
        $mensagemAtual = $this->valor($detalhe['solicitacao'], 'mensagem_publica');
        if ($atual === $novo && $mensagem === $mensagemAtual) {
            return back()->with('status', 'Nenhuma alteração foi necessária.');
        }
        try {
            if ($atual !== $novo) {
                $this->fluxo->validarSolicitacao($atual, $novo);
            }
        } catch (DomainException $exception) {
            return back()->withErrors(['status_codigo' => $exception->getMessage()]);
        }

        try {
            $alterada = $this->repository->alterarStatus(
                $id,
                $atual,
                $novo,
                $mensagem,
                $this->usuarioSessao(),
                $this->escopoZonalSessao(),
            );
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('estado', $exception);

            return back()->withErrors(['status_codigo' => 'Não foi possível atualizar a solicitação.']);
        }

        return $alterada
            ? back()->with('status', 'Estado da solicitação atualizado.')
            : back()->withErrors(['status_codigo' => 'A solicitação foi alterada por outro usuário. Recarregue a página.']);
    }

    public function atualizarTurno(int $id, int $turno, SeuVotoImportaTurnoRequest $request): RedirectResponse
    {
        abort_unless(in_array($turno, [1, 2], true), 404);
        $detalhe = $this->repository->buscarDetalheAdministrativo($id, $this->escopoZonalSessao());
        abort_if($detalhe === null, 404, 'Solicitação não encontrada no escopo permitido.');
        $registroTurno = collect($detalhe['turnos'])->first(
            fn (object $item): bool => (int) $this->valor($item, 'numero_turno') === $turno,
        );
        abort_if($registroTurno === null, 404, 'Turno não disponível para esta solicitação.');

        $atual = (string) $this->valor($registroTurno, 'status_codigo');
        $novo = (string) $request->validated('status_codigo');
        try {
            if ($atual !== $novo) {
                $this->fluxo->validarTurno($atual, $novo);
            }
        } catch (DomainException $exception) {
            return back()->withErrors(["turno_{$turno}" => $exception->getMessage()]);
        }

        $horario = $request->validated('horario_previsto');
        $data = (string) $request->validated('data_votacao');
        try {
            $alterada = $this->repository->atualizarTurno(
                $id,
                $turno,
                $atual,
                [
                    'STATUS_CODIGO' => $novo,
                    'DATA_VOTACAO' => $data,
                    'PONTO_EMBARQUE' => $request->validated('ponto_embarque'),
                    'HORARIO_PREVISTO' => $horario !== null ? $data.' '.$horario.':00' : null,
                    'OBSERVACAO_PUBLICA' => $request->validated('observacao_publica'),
                ],
                $this->usuarioSessao(),
                $this->escopoZonalSessao(),
            );
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('logistica_turno', $exception);

            return back()->withErrors(["turno_{$turno}" => 'Não foi possível atualizar a logística.']);
        }

        return $alterada
            ? back()->with('status', "Logística do {$turno}º turno atualizada.")
            : back()->withErrors(["turno_{$turno}" => 'O turno foi alterado por outro usuário. Recarregue a página.']);
    }

    public function downloadAnexo(int $id, int $anexo): StreamedResponse
    {
        $registro = $this->repository->buscarAnexoAdministrativo($id, $anexo, $this->escopoZonalSessao());
        abort_if($registro === null, 404, 'Anexo não encontrado no escopo permitido.');
        abort_unless(
            in_array((string) $this->valor($registro, 'scan_status'), ['PENDENTE', 'LIMPO'], true),
            404,
            'Anexo indisponível.',
        );

        $disco = (string) $this->valor($registro, 'disco');
        $caminho = (string) $this->valor($registro, 'caminho');
        abort_unless($disco === 'local', 404, 'Anexo indisponível.');
        abort_unless(
            preg_match('/^seu-voto-importa\/quarentena\/[a-f0-9-]+\.(pdf|jpg|png)$/i', $caminho) === 1,
            404,
            'Anexo indisponível.',
        );
        try {
            $existe = Storage::disk($disco)->exists($caminho);
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('verificacao_anexo', $exception);
            abort(404, 'Anexo indisponível.');
        }
        abort_unless($existe, 404, 'Anexo indisponível.');

        try {
            return Storage::disk($disco)->download(
                $caminho,
                (string) $this->valor($registro, 'nome_original'),
                [
                    'Content-Type' => (string) $this->valor($registro, 'mime'),
                    'X-Content-Type-Options' => 'nosniff',
                    'Cache-Control' => 'private, no-store, max-age=0',
                ],
            );
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('download_anexo', $exception);
            abort(404, 'Anexo indisponível.');
        }
    }

    public function exportarPdf(Request $request): Response
    {
        $filtros = $this->filtros($request);
        $campos = CamposPdfSelecionados::resolver(
            $request->query('campos'),
            self::CAMPOS_PDF,
            self::CAMPOS_PDF_PADRAO,
        );

        return Pdf::loadView('seu-voto-importa.admin.pdf', [
            'solicitacoes' => $this->repository->exportarAdministrativo($filtros, $this->escopoZonalSessao()),
            'campos' => $campos,
            'rotulos' => self::CAMPOS_PDF,
            'geradoEm' => now()->format('d/m/Y H:i'),
        ])->setPaper('a4', 'landscape')->stream('seu-voto-importa.pdf');
    }

    public function editarConfiguracao(Request $request): View
    {
        $this->autorizarAdmin();
        $macroprojetoId = (int) $request->query('macroprojeto_id', $this->macroprojetoAtivoIdSessao());
        abort_if($macroprojetoId <= 0, 422, 'Selecione um macroprojeto antes de configurar a janela.');

        return view('seu-voto-importa.admin.configuracao', [
            'macroprojetoId' => $macroprojetoId,
            'configuracao' => $this->repository->buscarConfiguracaoPorMacroprojeto($macroprojetoId),
        ]);
    }

    public function atualizarConfiguracao(SeuVotoImportaConfiguracaoRequest $request): RedirectResponse
    {
        $this->autorizarAdmin();
        $dados = $request->validated();
        try {
            $this->repository->salvarConfiguracao([
                'MACROPROJETO_ID' => (int) $dados['macroprojeto_id'],
                'DT_ABERTURA' => str_replace('T', ' ', (string) $dados['dt_abertura']).':00',
                'DT_ENCERRAMENTO' => str_replace('T', ' ', (string) $dados['dt_encerramento']).':00',
                'DT_PRIMEIRO_TURNO' => $dados['dt_primeiro_turno'],
                'DT_SEGUNDO_TURNO' => $dados['dt_segundo_turno'] ?: null,
                'SEGUNDO_TURNO_CONFIRMADO' => (int) $dados['segundo_turno_confirmado'],
                'AVISO_PRIVACIDADE' => $dados['aviso_privacidade'],
                'ATIVO' => (int) $dados['ativo'],
            ], $this->usuarioSessao());
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('configuracao', $exception);

            return back()->withInput()->withErrors(['configuracao' => 'Não foi possível salvar a configuração.']);
        }

        return redirect()->route('seu-voto-importa.admin.config.edit', [
            'macroprojeto_id' => (int) $dados['macroprojeto_id'],
        ])->with('status', 'Configuração atualizada.');
    }

    /** @return array<string, mixed> */
    private function filtros(Request $request): array
    {
        return [
            'macroprojeto_id' => $this->macroprojetoAtivoIdSessao(),
            'protocolo' => mb_substr(trim((string) $request->query('protocolo', '')), 0, 30, 'UTF-8'),
            'status' => mb_substr(mb_strtoupper(trim((string) $request->query('status', '')), 'UTF-8'), 0, 40, 'UTF-8'),
            'zona' => max(0, (int) $request->query('zona', 0)),
            'municipio' => mb_substr(trim((string) $request->query('municipio', '')), 0, 160, 'UTF-8'),
            'data_inicio' => $this->dataFiltro($request->query('data_inicio')),
            'data_fim' => $this->dataFiltro($request->query('data_fim')),
        ];
    }

    private function dataFiltro(mixed $valor): string
    {
        $data = trim((string) $valor);
        if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $data)) {
            return '';
        }
        try {
            return CarbonImmutable::createFromFormat('!Y-m-d', $data)->format('Y-m-d');
        } catch (\Throwable) {
            return '';
        }
    }

    private function usuarioSessao(): string
    {
        $usuario = session('user');
        if (is_array($usuario)) {
            return trim((string) ($usuario['username'] ?? $usuario['name'] ?? '')) ?: 'USUARIO_INTERNO';
        }

        return 'USUARIO_INTERNO';
    }

    private function valor(array|object $registro, string $campo): mixed
    {
        if (is_array($registro)) {
            return $registro[$campo] ?? $registro[mb_strtoupper($campo, 'UTF-8')] ?? null;
        }

        return $registro->{$campo} ?? $registro->{mb_strtoupper($campo, 'UTF-8')} ?? null;
    }

    private function registrarFalhaTecnica(string $operacao, Throwable $exception): void
    {
        Log::error('Falha técnica na administração do Seu Voto Importa.', [
            'operacao' => $operacao,
            'exception_class' => $exception::class,
        ]);
    }
}
```
</APP_HTTP_CONTROLLERS_SEUVOTOIMPORTA_SEUVOTOIMPORTAADMINCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/SeuVotoImporta/SeuVotoImportaPublicoController.php`
## <APP_HTTP_CONTROLLERS_SEUVOTOIMPORTA_SEUVOTOIMPORTAPUBLICOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/SeuVotoImporta/SeuVotoImportaPublicoController.php`
- **Namespace Declaração:** `App\Http\Controllers\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaPublicoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function identificacao(): View
public function identificar(SeuVotoImportaIdentificacaoRequest $request): RedirectResponse
public function nova(Request $request): View|RedirectResponse
public function identificarRepresentante(SeuVotoImportaRepresentanteRequest $request): JsonResponse
public function store(SeuVotoImportaSolicitacaoStoreRequest $request): RedirectResponse
public function sucesso(Request $request): View|RedirectResponse
public function acessoForm(): View
public function entrar(SeuVotoImportaProtocoloRequest $request): RedirectResponse
public function acompanhamento(Request $request): View|RedirectResponse
public function logout(Request $request): RedirectResponse
private function turnstileSiteKey(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\SeuVotoImporta;

use App\Http\Controllers\Controller;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaIdentificacaoRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaProtocoloRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaRepresentanteRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaSolicitacaoStoreRequest;
use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaAcessoService;
use App\Services\SeuVotoImporta\SeuVotoImportaAnexoService;
use App\Services\SeuVotoImporta\SeuVotoImportaIdentificacaoService;
use App\Services\SeuVotoImporta\SeuVotoImportaSessionService;
use App\Services\SeuVotoImporta\SeuVotoImportaSolicitacaoService;
use App\Services\SeuVotoImporta\SeuVotoImportaTurnstileService;
use App\Support\SeuVotoImporta\SeuVotoImportaDominios;
use App\Support\SeuVotoImporta\SeuVotoImportaMascarador;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Log;
use Illuminate\View\View;
use RuntimeException;
use Throwable;

class SeuVotoImportaPublicoController extends Controller
{
    public function __construct(
        private readonly SeuVotoImportaSolicitacaoRepository $repository,
        private readonly SeuVotoImportaIdentificacaoService $identificacaoService,
        private readonly SeuVotoImportaSolicitacaoService $solicitacaoService,
        private readonly SeuVotoImportaAnexoService $anexoService,
        private readonly SeuVotoImportaAcessoService $acessoService,
        private readonly SeuVotoImportaSessionService $sessionService,
        private readonly SeuVotoImportaTurnstileService $turnstile,
        private readonly SeuVotoImportaMascarador $mascarador,
    ) {
    }

    public function identificacao(): View
    {
        $configuracao = $this->repository->buscarConfiguracaoAberta();

        return view('seu-voto-importa.publico.identificacao', [
            'disponivel' => $configuracao !== null && $this->turnstile->configurado(),
            'turnstileSiteKey' => $this->turnstileSiteKey(),
        ]);
    }

    public function identificar(SeuVotoImportaIdentificacaoRequest $request): RedirectResponse
    {
        $dados = $request->validated();
        if (!$this->turnstile->validar((string) $dados['cf-turnstile-response'], 'svi_identificar', $request->ip())) {
            return back()->withInput($request->except('cf-turnstile-response'))
                ->withErrors(['seguranca' => 'Não foi possível confirmar a verificação de segurança.']);
        }

        try {
            $contexto = $this->identificacaoService->iniciar(
                $request,
                (string) $dados['num_inscricao'],
                (string) $dados['dt_nascimento'],
            );
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('identificacao', $exception);
            $this->identificacaoService->encerrar($request);

            return back()->withErrors(['identificacao' => 'Não foi possível iniciar a solicitação. Tente novamente.']);
        }
        if ($contexto === null) {
            return back()->withInput($request->except('dt_nascimento', 'cf-turnstile-response'))
                ->withErrors(['identificacao' => 'Não foi possível iniciar a solicitação com os dados informados.']);
        }

        try {
            $duplicada = $this->repository->buscarPorMacroTitulo(
                (int) $contexto['macroprojeto_id'],
                (string) $contexto['num_inscricao'],
            ) !== null;
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('verificacao_duplicidade', $exception);
            $this->identificacaoService->encerrar($request);

            return back()->withErrors(['identificacao' => 'Não foi possível iniciar a solicitação. Tente novamente.']);
        }
        if ($duplicada) {
            $this->identificacaoService->encerrar($request);

            return redirect()->route('seu-voto-importa.publico.acesso.form')
                ->with('status', $this->mensagemDuplicidade());
        }

        return redirect()->route('seu-voto-importa.publico.solicitacao.nova');
    }

    public function nova(Request $request): View|RedirectResponse
    {
        $contexto = $this->identificacaoService->contexto($request);
        if ($contexto === null) {
            return redirect()->route('seu-voto-importa.publico.identificacao');
        }

        return view('seu-voto-importa.publico.formulario', [
            'eleitor' => $contexto,
            'tituloMascarado' => $this->mascarador->titulo((string) $contexto['num_inscricao']),
            'dominios' => SeuVotoImportaDominios::class,
            'catalogos' => $this->repository->catalogosPublicos(),
            'turnstileSiteKey' => $this->turnstileSiteKey(),
        ]);
    }

    public function identificarRepresentante(SeuVotoImportaRepresentanteRequest $request): JsonResponse
    {
        $dados = $request->validated();
        try {
            $representante = $this->identificacaoService->identificarRepresentante(
                $request,
                (string) $dados['solicitante_titulo'],
                (string) $dados['solicitante_dt_nascimento'],
            );
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('identificacao_representante', $exception);
            $representante = null;
        }

        return $representante === null
            ? response()->json(['message' => 'Não foi possível identificar o representante.'], 422)
            : response()->json($representante);
    }

    public function store(SeuVotoImportaSolicitacaoStoreRequest $request): RedirectResponse
    {
        $contexto = $this->identificacaoService->contexto($request);
        if ($contexto === null) {
            return redirect()->route('seu-voto-importa.publico.identificacao');
        }
        $dados = $request->validated();
        if (!$this->turnstile->validar((string) $dados['cf-turnstile-response'], 'svi_enviar', $request->ip())) {
            return back()->withInput($request->except('cf-turnstile-response'))
                ->withErrors(['seguranca' => 'Não foi possível confirmar a verificação de segurança.']);
        }

        if ($dados['solicitante_tipo_codigo'] !== 'ELEITOR') {
            try {
                $representante = $this->identificacaoService->identificarRepresentante(
                    $request,
                    (string) $dados['solicitante_titulo'],
                    (string) $dados['solicitante_dt_nascimento'],
                );
            } catch (Throwable $exception) {
                $this->registrarFalhaTecnica('reidratacao_representante', $exception);
                $representante = null;
            }
            if ($representante === null) {
                return back()->withInput($request->except(
                    'cf-turnstile-response', 'solicitante_dt_nascimento',
                    'comprovante_representacao', 'comprovante_condicao',
                ))->withErrors(['solicitante_titulo' => 'Não foi possível confirmar os dados do representante.']);
            }
            $dados['solicitante_nome'] = $representante['nome'];
        }

        $anexos = [];
        try {
            foreach (['comprovante_representacao' => 'REPRESENTACAO', 'comprovante_condicao' => 'CONDICAO'] as $campo => $categoria) {
                if (($categoria === 'REPRESENTACAO' && $dados['solicitante_tipo_codigo'] === 'ELEITOR')
                    || ($categoria === 'CONDICAO' && $dados['comprovacao_tipo_codigo'] !== 'ANEXO')) {
                    continue;
                }
                $arquivo = $request->file($campo);
                if ($arquivo instanceof UploadedFile) {
                    $anexos[] = $this->anexoService->preparar($categoria, $arquivo);
                }
            }
        } catch (RuntimeException) {
            $this->anexoService->descartar($anexos);

            return back()->withInput($request->except(
                'cf-turnstile-response', 'solicitante_dt_nascimento',
                'comprovante_representacao', 'comprovante_condicao',
            ))->withErrors(['anexos' => 'O anexo não passou pela verificação de segurança.']);
        }

        try {
            $resultado = $this->solicitacaoService->criar($contexto, $dados, $anexos);
        } catch (Throwable $exception) {
            $this->anexoService->descartar($anexos);
            $this->registrarFalhaTecnica('envio_solicitacao', $exception);

            return back()->withInput($request->except(
                'cf-turnstile-response', 'solicitante_dt_nascimento',
                'comprovante_representacao', 'comprovante_condicao',
            ))->withErrors(['solicitacao' => 'Não foi possível registrar a solicitação. Tente novamente.']);
        }

        $this->identificacaoService->encerrar($request);
        if ($resultado['duplicada']) {
            $this->anexoService->descartar($anexos);

            return redirect()->route('seu-voto-importa.publico.acesso.form')
                ->with('status', $this->mensagemDuplicidade());
        }

        return redirect()->route('seu-voto-importa.publico.solicitacao.sucesso')
            ->with('svi_protocolo', $resultado['protocolo']);
    }

    public function sucesso(Request $request): View|RedirectResponse
    {
        $protocolo = trim((string) $request->session()->get('svi_protocolo', ''));
        if ($protocolo === '') {
            return redirect()->route('seu-voto-importa.publico.identificacao');
        }

        return view('seu-voto-importa.publico.sucesso', ['protocolo' => $protocolo]);
    }

    public function acessoForm(): View
    {
        return view('seu-voto-importa.publico.acesso', [
            'disponivel' => $this->turnstile->configurado(),
            'turnstileSiteKey' => $this->turnstileSiteKey(),
        ]);
    }

    public function entrar(SeuVotoImportaProtocoloRequest $request): RedirectResponse
    {
        $dados = $request->validated();
        if (!$this->turnstile->validar((string) $dados['cf-turnstile-response'], 'svi_acesso', $request->ip())) {
            return back()->withInput($request->except('cf-turnstile-response'))
                ->withErrors(['seguranca' => 'Não foi possível confirmar a verificação de segurança.']);
        }

        try {
            $autenticado = $this->acessoService->entrar((string) $dados['protocolo'], $request);
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('acesso_protocolo', $exception);
            $autenticado = false;
        }

        return $autenticado
            ? redirect()->route('seu-voto-importa.publico.acompanhamento')
            : back()->withInput($request->except('cf-turnstile-response'))
                ->withErrors(['protocolo' => 'Não foi possível acessar a solicitação com o protocolo informado.']);
    }

    public function acompanhamento(Request $request): View|RedirectResponse
    {
        $id = $this->sessionService->solicitacaoId($request);
        try {
            $solicitacao = $id !== null ? $this->repository->buscarAcompanhamentoPorId($id) : null;
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnica('acompanhamento', $exception);
            $this->sessionService->encerrar($request);

            return redirect()->route('seu-voto-importa.publico.acesso.form')
                ->with('erro', 'O acompanhamento está temporariamente indisponível.');
        }
        if ($solicitacao === null) {
            $this->sessionService->encerrar($request);

            return redirect()->route('seu-voto-importa.publico.acesso.form');
        }

        $solicitacao['num_inscricao'] = $this->mascarador->titulo((string) $solicitacao['num_inscricao']);
        $solicitacao['eleitor_telefone'] = $this->mascarador->telefone((string) $solicitacao['eleitor_telefone']);

        return view('seu-voto-importa.publico.acompanhamento', ['solicitacao' => $solicitacao]);
    }

    public function logout(Request $request): RedirectResponse
    {
        $this->sessionService->encerrar($request);

        return redirect()->route('seu-voto-importa.publico.acesso.form')->with('status', 'Sessão encerrada.');
    }

    private function turnstileSiteKey(): string
    {
        return trim((string) config('planeleito.seu_voto_importa.turnstile.site_key', ''));
    }

    private function mensagemDuplicidade(): string
    {
        return 'Já existe uma solicitação para os dados informados. Use o protocolo para acompanhar ou procure o atendimento do TRE-AC.';
    }

    private function registrarFalhaTecnica(string $operacao, Throwable $exception): void
    {
        Log::error('Falha técnica no fluxo público Seu Voto Importa.', [
            'operacao' => $operacao,
            'exception_class' => $exception::class,
        ]);
    }
}
```
</APP_HTTP_CONTROLLERS_SEUVOTOIMPORTA_SEUVOTOIMPORTAPUBLICOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/EnergiaController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_ENERGIACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/EnergiaController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class EnergiaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly EnergiaRepository $repository)
public function gerenciar(): View
public function form(?int $id = null): View
public function index(): JsonResponse
public function show(int $id): JsonResponse
public function store(EnergiaRequest $request)
public function update(EnergiaRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\EnergiaRequest;
use App\Repositories\TabelasAuxiliares\EnergiaRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class EnergiaController extends Controller
{
    public function __construct(private readonly EnergiaRepository $repository)
    {
    }

    public function gerenciar(): View
    {
        return view('tabelas-auxiliares.energias.index', [
            'energias' => $this->repository->listar(),
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $registro = null;
        if ($id !== null) {
            $registro = $this->repository->buscar($id);
            if (!$registro) {
                abort(404);
            }
        }

        return view('tabelas-auxiliares.energias.form', [
            'energia' => $registro,
        ]);
    }

    public function index(): JsonResponse
    {
        $dados = $this->repository->listar()->map(function ($registro) {
            return [
                'ID' => $registro->id,
                'DESCRICAO' => $registro->descricao,
                'IDHTML' => $registro->idhtml,
            ];
        });

        return response()->json($dados);
    }

    public function show(int $id): JsonResponse
    {
        $registro = $this->repository->buscar($id);

        if (!$registro) {
            return response()->json(['mensagem' => 'Registro não encontrado.'], 404);
        }

        return response()->json([
            'ID' => $registro->id,
            'DESCRICAO' => $registro->descricao,
            'IDHTML' => $registro->idhtml,
        ]);
    }

    public function store(EnergiaRequest $request)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $id = $this->repository->criar($dados);

        if ($request->wantsJson()) {
            return response()->json([
                'mensagem' => 'Tipo de energia criado com sucesso!',
                'id' => $id,
            ], 201);
        }

        return redirect()
            ->route('tabelas-auxiliares.energias.index')
            ->with('status', 'Tipo de energia criado com sucesso!');
    }

    public function update(EnergiaRequest $request, int $id)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $atualizados = $this->repository->atualizar($id, $dados);

        if ($atualizados === 0) {
            return response()->json(['mensagem' => 'Registro não encontrado.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Tipo de energia atualizado com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.energias.index')
            ->with('status', 'Tipo de energia atualizado com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $removidos = $this->repository->remover($id);

        if ($removidos === 0) {
            return response()->json(['mensagem' => 'Registro não encontrado.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Tipo de energia excluído com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.energias.index')
            ->with('status', 'Tipo de energia excluído com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_ENERGIACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/EsferaController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_ESFERACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/EsferaController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class EsferaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly EsferaRepository $repository)
public function index(Request $request): View
public function form(?int $id = null): View
public function store(EsferaRequest $request)
public function update(EsferaRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\EsferaRequest;
use App\Repositories\TabelasAuxiliares\EsferaRepository;
use Illuminate\Http\Request;
use Illuminate\View\View;

class EsferaController extends Controller
{
    public function __construct(private readonly EsferaRepository $repository)
    {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));

        return view('tabelas-auxiliares.esferas.index', [
            'esferas' => $this->repository->listar($busca !== '' ? $busca : null),
            'busca' => $busca,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $esfera = $id !== null ? $this->repository->buscar($id) : null;

        if ($id !== null && $esfera === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.esferas.form', compact('esfera'));
    }

    public function store(EsferaRequest $request)
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()
            ->route('tabelas-auxiliares.esferas.index')
            ->with('status', 'Esfera criada com sucesso!');
    }

    public function update(EsferaRequest $request, int $id)
    {
        $this->autorizarAdmin();

        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        $this->repository->atualizar($id, $request->validated());

        return redirect()
            ->route('tabelas-auxiliares.esferas.index')
            ->with('status', 'Esfera atualizada com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $this->repository->remover($id);

        return redirect()
            ->route('tabelas-auxiliares.esferas.index')
            ->with('status', 'Esfera excluída com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_ESFERACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/InternetController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_INTERNETCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/InternetController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class InternetController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly InternetRepository $repository)
public function gerenciar(): View
public function form(?int $id = null): View
public function index(): JsonResponse
public function show(int $id): JsonResponse
public function store(InternetRequest $request)
public function update(InternetRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\InternetRequest;
use App\Repositories\TabelasAuxiliares\InternetRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class InternetController extends Controller
{
    public function __construct(private readonly InternetRepository $repository)
    {
    }

    public function gerenciar(): View
    {
        return view('tabelas-auxiliares.internets.index', [
            'internets' => $this->repository->listar(),
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $registro = null;
        if ($id !== null) {
            $registro = $this->repository->buscar($id);
            if (!$registro) {
                abort(404);
            }
        }

        return view('tabelas-auxiliares.internets.form', [
            'internet' => $registro,
        ]);
    }

    public function index(): JsonResponse
    {
        $dados = $this->repository->listar()->map(fn ($registro) => [
            'ID' => $registro->id,
            'DESCRICAO' => $registro->descricao,
        ]);

        return response()->json($dados);
    }

    public function show(int $id): JsonResponse
    {
        $registro = $this->repository->buscar($id);

        if (!$registro) {
            return response()->json(['mensagem' => 'Registro não encontrado.'], 404);
        }

        return response()->json([
            'ID' => $registro->id,
            'DESCRICAO' => $registro->descricao,
        ]);
    }

    public function store(InternetRequest $request)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $id = $this->repository->criar($dados);

        if ($request->wantsJson()) {
            return response()->json([
                'mensagem' => 'Tipo de internet criado com sucesso!',
                'id' => $id,
            ], 201);
        }

        return redirect()
            ->route('tabelas-auxiliares.internets.index')
            ->with('status', 'Tipo de internet criado com sucesso!');
    }

    public function update(InternetRequest $request, int $id)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $atualizados = $this->repository->atualizar($id, $dados);

        if ($atualizados === 0) {
            return response()->json(['mensagem' => 'Registro não encontrado.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Tipo de internet atualizado com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.internets.index')
            ->with('status', 'Tipo de internet atualizado com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $removidos = $this->repository->remover($id);

        if ($removidos === 0) {
            return response()->json(['mensagem' => 'Registro não encontrado.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Tipo de internet excluído com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.internets.index')
            ->with('status', 'Tipo de internet excluído com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_INTERNETCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/MunicipioController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_MUNICIPIOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/MunicipioController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class MunicipioController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('ZONA')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly MunicipioRepository $repository)
public function gerenciar(): View
public function listar(Request $request): View
public function form(?int $id = null): View
public function index(): JsonResponse
public function listarComZona(): JsonResponse
public function show(int $id): JsonResponse
public function store(MunicipioRequest $request)
public function update(MunicipioRequest $request, int $id)
public function destroy(Request $request, int $id)
public function porZona(Request $request): JsonResponse
private function listarZonas()
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\MunicipioRequest;
use App\Repositories\TabelasAuxiliares\MunicipioRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class MunicipioController extends Controller
{
    public function __construct(private readonly MunicipioRepository $repository)
    {
    }

    public function gerenciar(): View
    {
        return view('tabelas-auxiliares.municipios.index', [
            'municipios' => $this->repository->listar(null, null),
            'zonas' => $this->listarZonas(),
            'busca' => '',
            'zonaId' => null,
        ]);
    }

    public function listar(Request $request): View
    {
        $busca = $request->get('busca');
        $zonaId = $request->get('zona');

        return view('tabelas-auxiliares.municipios.tabela', [
            'municipios' => $this->repository->listar($busca, $zonaId ? (int) $zonaId : null),
            'busca' => $busca,
            'zonaId' => $zonaId,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $registro = null;
        if ($id !== null) {
            $registro = $this->repository->buscar($id);
            if (!$registro) {
                abort(404);
            }
        }

        return view('tabelas-auxiliares.municipios.form', [
            'municipio' => $registro,
            'zonas' => $this->listarZonas(),
        ]);
    }

    public function index(): JsonResponse
    {
        return response()->json($this->repository->todas());
    }

    public function listarComZona(): JsonResponse
    {
        return response()->json($this->repository->listarComZona());
    }

    public function show(int $id): JsonResponse
    {
        $municipio = $this->repository->buscar($id);

        if (!$municipio) {
            return response()->json(['mensagem' => 'Município não encontrado.'], 404);
        }

        return response()->json($municipio);
    }

    public function store(MunicipioRequest $request)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $id = $this->repository->criar($dados);

        if ($request->wantsJson()) {
            return response()->json([
                'mensagem' => 'Município criado com sucesso!',
                'id' => $id,
            ], 201);
        }

        return redirect()
            ->route('tabelas-auxiliares.municipios.index')
            ->with('status', 'Município criado com sucesso!');
    }

    public function update(MunicipioRequest $request, int $id)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $atualizados = $this->repository->atualizar($id, $dados);

        if ($atualizados === 0) {
            return response()->json(['mensagem' => 'Município não encontrado.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Município atualizado com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.municipios.index')
            ->with('status', 'Município atualizado com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $removidos = $this->repository->remover($id);

        if ($removidos === 0) {
            return response()->json(['mensagem' => 'Município não encontrado.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Município excluído com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.municipios.index')
            ->with('status', 'Município excluído com sucesso!');
    }

    public function porZona(Request $request): JsonResponse
    {
        $zonaId = $request->input('zona_id');

        return response()->json($this->repository->porZona($zonaId ? (int) $zonaId : null));
    }

    private function listarZonas()
    {
        return DB::table('ZONA')
            ->selectRaw('ID as id, NUM_ZONA as num_zona, DESCRICAO as descricao')
            ->orderBy('NUM_ZONA')
            ->get();
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_MUNICIPIOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/OpcaoBinariaController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_OPCAOBINARIACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/OpcaoBinariaController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class OpcaoBinariaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly OpcaoBinariaRepository $repository)
public function index(Request $request): View
public function form(?int $id = null): View
public function store(OpcaoBinariaRequest $request)
public function update(OpcaoBinariaRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\OpcaoBinariaRequest;
use App\Repositories\TabelasAuxiliares\OpcaoBinariaRepository;
use Illuminate\Http\Request;
use Illuminate\View\View;

class OpcaoBinariaController extends Controller
{
    public function __construct(private readonly OpcaoBinariaRepository $repository)
    {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));

        return view('tabelas-auxiliares.opcoes-binarias.index', [
            'opcoes' => $this->repository->listar($busca !== '' ? $busca : null),
            'busca' => $busca,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $opcao = $id !== null ? $this->repository->buscar($id) : null;

        if ($id !== null && $opcao === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.opcoes-binarias.form', compact('opcao'));
    }

    public function store(OpcaoBinariaRequest $request)
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()
            ->route('tabelas-auxiliares.opcoes-binarias.index')
            ->with('status', 'Opção binária criada com sucesso!');
    }

    public function update(OpcaoBinariaRequest $request, int $id)
    {
        $this->autorizarAdmin();

        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        $this->repository->atualizar($id, $request->validated());

        return redirect()
            ->route('tabelas-auxiliares.opcoes-binarias.index')
            ->with('status', 'Opção binária atualizada com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $this->repository->remover($id);

        return redirect()
            ->route('tabelas-auxiliares.opcoes-binarias.index')
            ->with('status', 'Opção binária excluída com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_OPCAOBINARIACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/OperadoraController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_OPERADORACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/OperadoraController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class OperadoraController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly OperadoraRepository $repository)
public function index(Request $request): View
public function form(?int $id = null): View
public function store(OperadoraRequest $request)
public function update(OperadoraRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\OperadoraRequest;
use App\Repositories\TabelasAuxiliares\OperadoraRepository;
use Illuminate\Http\Request;
use Illuminate\View\View;

class OperadoraController extends Controller
{
    public function __construct(private readonly OperadoraRepository $repository)
    {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));

        return view('tabelas-auxiliares.operadoras.index', [
            'operadoras' => $this->repository->listar($busca !== '' ? $busca : null),
            'busca' => $busca,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $operadora = $id !== null ? $this->repository->buscar($id) : null;

        if ($id !== null && $operadora === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.operadoras.form', compact('operadora'));
    }

    public function store(OperadoraRequest $request)
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()
            ->route('tabelas-auxiliares.operadoras.index')
            ->with('status', 'Operadora criada com sucesso!');
    }

    public function update(OperadoraRequest $request, int $id)
    {
        $this->autorizarAdmin();

        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        $this->repository->atualizar($id, $request->validated());

        return redirect()
            ->route('tabelas-auxiliares.operadoras.index')
            ->with('status', 'Operadora atualizada com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $this->repository->remover($id);

        return redirect()
            ->route('tabelas-auxiliares.operadoras.index')
            ->with('status', 'Operadora excluída com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_OPERADORACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/QualidadeController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_QUALIDADECONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/QualidadeController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class QualidadeController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly QualidadeRepository $repository)
public function index(Request $request): View
public function form(?int $id = null): View
public function store(QualidadeRequest $request)
public function update(QualidadeRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\QualidadeRequest;
use App\Repositories\TabelasAuxiliares\QualidadeRepository;
use Illuminate\Http\Request;
use Illuminate\View\View;

class QualidadeController extends Controller
{
    public function __construct(private readonly QualidadeRepository $repository)
    {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));

        return view('tabelas-auxiliares.qualidades.index', [
            'qualidades' => $this->repository->listar($busca !== '' ? $busca : null),
            'busca' => $busca,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $qualidade = $id !== null ? $this->repository->buscar($id) : null;

        if ($id !== null && $qualidade === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.qualidades.form', compact('qualidade'));
    }

    public function store(QualidadeRequest $request)
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()
            ->route('tabelas-auxiliares.qualidades.index')
            ->with('status', 'Qualidade criada com sucesso!');
    }

    public function update(QualidadeRequest $request, int $id)
    {
        $this->autorizarAdmin();

        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        $this->repository->atualizar($id, $request->validated());

        return redirect()
            ->route('tabelas-auxiliares.qualidades.index')
            ->with('status', 'Qualidade atualizada com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $this->repository->remover($id);

        return redirect()
            ->route('tabelas-auxiliares.qualidades.index')
            ->with('status', 'Qualidade excluída com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_QUALIDADECONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/TipoSinalController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_TIPOSINALCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/TipoSinalController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class TipoSinalController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly TipoSinalRepository $repository)
public function index(Request $request): View
public function form(?int $id = null): View
public function store(TipoSinalRequest $request)
public function update(TipoSinalRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\TipoSinalRequest;
use App\Repositories\TabelasAuxiliares\TipoSinalRepository;
use Illuminate\Http\Request;
use Illuminate\View\View;

class TipoSinalController extends Controller
{
    public function __construct(private readonly TipoSinalRepository $repository)
    {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));

        return view('tabelas-auxiliares.tipos-sinal.index', [
            'tiposSinal' => $this->repository->listar($busca !== '' ? $busca : null),
            'busca' => $busca,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $tipoSinal = $id !== null ? $this->repository->buscar($id) : null;

        if ($id !== null && $tipoSinal === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.tipos-sinal.form', compact('tipoSinal'));
    }

    public function store(TipoSinalRequest $request)
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()
            ->route('tabelas-auxiliares.tipos-sinal.index')
            ->with('status', 'Tipo de sinal criado com sucesso!');
    }

    public function update(TipoSinalRequest $request, int $id)
    {
        $this->autorizarAdmin();

        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        $this->repository->atualizar($id, $request->validated());

        return redirect()
            ->route('tabelas-auxiliares.tipos-sinal.index')
            ->with('status', 'Tipo de sinal atualizado com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $this->repository->remover($id);

        return redirect()
            ->route('tabelas-auxiliares.tipos-sinal.index')
            ->with('status', 'Tipo de sinal excluído com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_TIPOSINALCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/TipoTomadaController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_TIPOTOMADACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/TipoTomadaController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class TipoTomadaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly TipoTomadaRepository $repository)
public function index(Request $request): View
public function form(?int $id = null): View
public function store(TipoTomadaRequest $request)
public function update(TipoTomadaRequest $request, int $id)
public function destroy(Request $request, int $id)
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\TipoTomadaRequest;
use App\Repositories\TabelasAuxiliares\TipoTomadaRepository;
use Illuminate\Http\Request;
use Illuminate\View\View;

class TipoTomadaController extends Controller
{
    public function __construct(private readonly TipoTomadaRepository $repository)
    {
    }

    public function index(Request $request): View
    {
        $busca = trim((string) $request->query('busca', ''));

        return view('tabelas-auxiliares.tipos-tomada.index', [
            'tiposTomada' => $this->repository->listar($busca !== '' ? $busca : null),
            'busca' => $busca,
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $tipoTomada = $id !== null ? $this->repository->buscar($id) : null;

        if ($id !== null && $tipoTomada === null) {
            abort(404);
        }

        return view('tabelas-auxiliares.tipos-tomada.form', compact('tipoTomada'));
    }

    public function store(TipoTomadaRequest $request)
    {
        $this->autorizarAdmin();
        $this->repository->criar($request->validated());

        return redirect()
            ->route('tabelas-auxiliares.tipos-tomada.index')
            ->with('status', 'Tipo de tomada criado com sucesso!');
    }

    public function update(TipoTomadaRequest $request, int $id)
    {
        $this->autorizarAdmin();

        if ($this->repository->buscar($id) === null) {
            abort(404);
        }

        $this->repository->atualizar($id, $request->validated());

        return redirect()
            ->route('tabelas-auxiliares.tipos-tomada.index')
            ->with('status', 'Tipo de tomada atualizado com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $this->repository->remover($id);

        return redirect()
            ->route('tabelas-auxiliares.tipos-tomada.index')
            ->with('status', 'Tipo de tomada excluído com sucesso!');
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_TIPOTOMADACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/TabelasAuxiliares/ZonaController.php`
## <APP_HTTP_CONTROLLERS_TABELASAUXILIARES_ZONACONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/TabelasAuxiliares/ZonaController.php`
- **Namespace Declaração:** `App\Http\Controllers\TabelasAuxiliares`
- **Entidade / Classe:** `class ZonaController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly ZonaRepository $repository)
public function gerenciar(): View
public function form(?int $id = null): View
public function index(): JsonResponse
public function show(int $id): JsonResponse
public function store(ZonaRequest $request)
public function update(ZonaRequest $request, int $id)
public function destroy(Request $request, int $id)
public function porZona(Request $request): JsonResponse
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\TabelasAuxiliares;

use App\Http\Controllers\Controller;

use App\Http\Requests\TabelasAuxiliares\ZonaRequest;
use App\Repositories\TabelasAuxiliares\ZonaRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class ZonaController extends Controller
{
    public function __construct(private readonly ZonaRepository $repository)
    {
    }

    public function gerenciar(): View
    {
        return view('tabelas-auxiliares.zonas.index', [
            'zonas' => $this->repository->listar(),
        ]);
    }

    public function form(?int $id = null): View
    {
        $this->autorizarAdmin();
        $registro = null;
        if ($id !== null) {
            $registro = $this->repository->buscar($id);
            if (!$registro) {
                abort(404);
            }
        }

        return view('tabelas-auxiliares.zonas.form', [
            'zona' => $registro,
        ]);
    }

    public function index(): JsonResponse
    {
        return response()->json($this->repository->listar());
    }

    public function show(int $id): JsonResponse
    {
        $zona = $this->repository->buscar($id);

        if (!$zona) {
            return response()->json(['mensagem' => 'Zona não encontrada.'], 404);
        }

        return response()->json($zona);
    }

    public function store(ZonaRequest $request)
    {
       $this->autorizarAdmin();
        $dados = $request->validated();

        $id = $this->repository->criar($dados);

        if ($request->wantsJson()) {
            return response()->json([
                'mensagem' => 'Zona criada com sucesso!',
                'id' => $id,
            ], 201);
        }

        return redirect()
            ->route('tabelas-auxiliares.zonas.index')
            ->with('status', 'Zona criada com sucesso!');
    }

    public function update(ZonaRequest $request, int $id)
    {
        $this->autorizarAdmin();
        $dados = $request->validated();

        $atualizados = $this->repository->atualizar($id, $dados);

        if ($atualizados === 0) {
            return response()->json(['mensagem' => 'Zona não encontrada.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Zona atualizada com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.zonas.index')
            ->with('status', 'Zona atualizada com sucesso!');
    }

    public function destroy(Request $request, int $id)
    {
        $this->autorizarAdmin();
        $removidos = $this->repository->remover($id);

        if ($removidos === 0) {
            return response()->json(['mensagem' => 'Zona não encontrada.'], 404);
        }

        if ($request->wantsJson()) {
            return response()->json(['mensagem' => 'Zona excluída com sucesso!']);
        }

        return redirect()
            ->route('tabelas-auxiliares.zonas.index')
            ->with('status', 'Zona excluída com sucesso!');
    }

    public function porZona(Request $request): JsonResponse
    {
        $grupo = $request->input('grupodeacesso');
        $numero = $grupo ? (int) $grupo : null;

        return response()->json($this->repository->buscarPorNumero($numero));
    }
}
```
</APP_HTTP_CONTROLLERS_TABELASAUXILIARES_ZONACONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/ColaboradoresEleitorais/EventoVoluntarioPublicoLookupRequest.php`
## <APP_HTTP_REQUESTS_COLABORADORESELEITORAIS_EVENTOVOLUNTARIOPUBLICOLOOKUPREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/ColaboradoresEleitorais/EventoVoluntarioPublicoLookupRequest.php`
- **Namespace Declaração:** `App\Http\Requests\ColaboradoresEleitorais`
- **Entidade / Classe:** `class EventoVoluntarioPublicoLookupRequest extends FormRequest`

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
public function messages(): array
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\ColaboradoresEleitorais;

use App\Rules\TituloEleitoralRule;
use App\Support\Validation\TituloEleitoral;
use Illuminate\Foundation\Http\FormRequest;

class EventoVoluntarioPublicoLookupRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'num_inscricao' => [
                'bail',
                'required',
                'string',
                'max:20',
                new TituloEleitoralRule(),
            ],
        ];
    }

    public function messages(): array
    {
        return [
            'num_inscricao.required' => 'Informe o título eleitoral.',
            'num_inscricao.string' => 'Informe um título eleitoral válido.',
            'num_inscricao.max' => 'Informe um título eleitoral válido.',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'num_inscricao' => TituloEleitoral::prepararEntrada($this->input('num_inscricao')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_COLABORADORESELEITORAIS_EVENTOVOLUNTARIOPUBLICOLOOKUPREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/Rcand/RcandFiltroRequest.php`
## <APP_HTTP_REQUESTS_RCAND_RCANDFILTROREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/Rcand/RcandFiltroRequest.php`
- **Namespace Declaração:** `App\Http\Requests\Rcand`
- **Entidade / Classe:** `final class RcandFiltroRequest extends FormRequest`

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

namespace App\Http\Requests\Rcand;

use App\Support\Rcand\RcandImpugnacao;
use App\Support\Rcand\RcandVisaoCand;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

final class RcandFiltroRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, array<int, mixed>> */
    public function rules(): array
    {
        return [
            'processo' => ['nullable', 'string', 'max:40'],
            'partido' => ['nullable', 'integer', Rule::exists('rcand_partido', 'nr_partido')],
            'tipo' => ['nullable', 'string', 'max:20'],
            'divergencia' => ['nullable', 'string', 'max:80'],
            'integridade' => ['nullable', 'string', 'max:80'],
            'situacao_cand' => ['nullable', 'string', 'max:120'],
            'julgamento' => ['nullable', 'string', 'max:20'],
            'cert_publicacao' => ['nullable', 'string', 'max:10'],
            'informacao' => ['nullable', 'string', 'max:10'],
            'impugnacao' => ['nullable', 'string', Rule::in(RcandImpugnacao::todos())],
            'julgado_pje' => ['nullable', 'string', 'max:10'],
            'data_primeiro_recurso' => ['nullable', 'string', 'max:20'],
            'contrarrazao' => ['nullable', 'string', 'max:20'],
            'remessa_tre' => ['nullable', 'string', 'max:20'],
            'visao_cand' => ['nullable', 'string', Rule::in(RcandVisaoCand::todos())],
        ];
    }
}
```
</APP_HTTP_REQUESTS_RCAND_RCANDFILTROREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/SeuVotoImporta/SeuVotoImportaConfiguracaoRequest.php`
## <APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTACONFIGURACAOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/SeuVotoImporta/SeuVotoImportaConfiguracaoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaConfiguracaoRequest extends FormRequest`

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

namespace App\Http\Requests\SeuVotoImporta;

use Illuminate\Foundation\Http\FormRequest;

class SeuVotoImportaConfiguracaoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'macroprojeto_id' => ['required', 'integer', 'min:1'],
            'dt_abertura' => ['required', 'date_format:Y-m-d\TH:i'],
            'dt_encerramento' => ['required', 'date_format:Y-m-d\TH:i', 'after_or_equal:dt_abertura'],
            'dt_primeiro_turno' => ['required', 'date_format:Y-m-d'],
            'dt_segundo_turno' => ['nullable', 'required_if:segundo_turno_confirmado,1', 'date_format:Y-m-d', 'after:dt_primeiro_turno'],
            'segundo_turno_confirmado' => ['nullable', 'boolean'],
            'aviso_privacidade' => ['required', 'string', 'max:10000'],
            'ativo' => ['nullable', 'boolean'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'segundo_turno_confirmado' => $this->boolean('segundo_turno_confirmado') ? 1 : 0,
            'ativo' => $this->boolean('ativo') ? 1 : 0,
            'aviso_privacidade' => trim((string) $this->input('aviso_privacidade')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTACONFIGURACAOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/SeuVotoImporta/SeuVotoImportaIdentificacaoRequest.php`
## <APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTAIDENTIFICACAOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/SeuVotoImporta/SeuVotoImportaIdentificacaoRequest.php`
- **Namespace Declaração:** `App\Http\Requests\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaIdentificacaoRequest extends FormRequest`

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
public function messages(): array
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\SeuVotoImporta;

use App\Rules\TituloEleitoralRule;
use App\Support\Validation\DataNascimentoEleitoral;
use App\Support\Validation\TituloEleitoral;
use Illuminate\Foundation\Http\FormRequest;

class SeuVotoImportaIdentificacaoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'num_inscricao' => ['required', new TituloEleitoralRule],
            'dt_nascimento' => ['required', 'date_format:Y-m-d', 'before:today'],
            'cf-turnstile-response' => ['required', 'string', 'max:2048'],
        ];
    }

    public function messages(): array
    {
        return [
            'num_inscricao.required' => 'Informe o título eleitoral.',
            'dt_nascimento.required' => 'Informe a data de nascimento.',
            'dt_nascimento.date_format' => 'Informe uma data de nascimento válida.',
            'cf-turnstile-response.required' => 'Confirme a verificação de segurança.',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'num_inscricao' => TituloEleitoral::prepararEntrada($this->input('num_inscricao')),
            'dt_nascimento' => DataNascimentoEleitoral::prepararEntrada($this->input('dt_nascimento')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTAIDENTIFICACAOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/SeuVotoImporta/SeuVotoImportaProtocoloRequest.php`
## <APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTAPROTOCOLOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/SeuVotoImporta/SeuVotoImportaProtocoloRequest.php`
- **Namespace Declaração:** `App\Http\Requests\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaProtocoloRequest extends FormRequest`

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
public function messages(): array
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\SeuVotoImporta;

use Illuminate\Foundation\Http\FormRequest;

class SeuVotoImportaProtocoloRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'protocolo' => ['required', 'string', 'regex:/^SVI-[0-9]{4}-[A-F0-9]{12}$/'],
            'cf-turnstile-response' => ['required', 'string', 'max:2048'],
        ];
    }

    public function messages(): array
    {
        return [
            'protocolo.required' => 'Informe o protocolo.',
            'protocolo.regex' => 'Informe um protocolo válido.',
            'cf-turnstile-response.required' => 'Confirme a verificação de segurança.',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'protocolo' => mb_strtoupper(trim((string) $this->input('protocolo')), 'UTF-8'),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTAPROTOCOLOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/SeuVotoImporta/SeuVotoImportaRepresentanteRequest.php`
## <APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTAREPRESENTANTEREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/SeuVotoImporta/SeuVotoImportaRepresentanteRequest.php`
- **Namespace Declaração:** `App\Http\Requests\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaRepresentanteRequest extends FormRequest`

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
public function messages(): array
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\SeuVotoImporta;

use App\Rules\TituloEleitoralRule;
use App\Support\Validation\DataNascimentoEleitoral;
use App\Support\Validation\TituloEleitoral;
use Illuminate\Foundation\Http\FormRequest;

class SeuVotoImportaRepresentanteRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'solicitante_titulo' => ['required', new TituloEleitoralRule],
            'solicitante_dt_nascimento' => ['required', 'date_format:Y-m-d', 'before:today'],
        ];
    }

    public function messages(): array
    {
        return [
            'solicitante_titulo.required' => 'Informe o título do representante.',
            'solicitante_dt_nascimento.required' => 'Informe a data de nascimento do representante.',
            'solicitante_dt_nascimento.date_format' => 'Informe uma data de nascimento válida.',
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'solicitante_titulo' => TituloEleitoral::prepararEntrada($this->input('solicitante_titulo')),
            'solicitante_dt_nascimento' => DataNascimentoEleitoral::prepararEntrada(
                $this->input('solicitante_dt_nascimento')
            ),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTAREPRESENTANTEREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/SeuVotoImporta/SeuVotoImportaSolicitacaoStoreRequest.php`
## <APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTASOLICITACAOSTOREREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/SeuVotoImporta/SeuVotoImportaSolicitacaoStoreRequest.php`
- **Namespace Declaração:** `App\Http\Requests\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaSolicitacaoStoreRequest extends FormRequest`

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
public function withValidator(Validator $validator): void
protected function prepareForValidation(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\SeuVotoImporta;

use App\Rules\TelefoneRule;
use App\Rules\TituloEleitoralRule;
use App\Support\SeuVotoImporta\SeuVotoImportaDominios;
use App\Support\Validation\DataNascimentoEleitoral;
use App\Support\Validation\TelefoneBrasileiro;
use App\Support\Validation\TituloEleitoral;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\File;
use Illuminate\Validation\Validator;

class SeuVotoImportaSolicitacaoStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $arquivo = File::types(['pdf', 'jpg', 'jpeg', 'png'])->max(10 * 1024);

        return [
            'solicitante_tipo_codigo' => ['required', Rule::in(SeuVotoImportaDominios::SOLICITANTES)],
            'solicitante_titulo' => ['nullable', 'required_unless:solicitante_tipo_codigo,ELEITOR', new TituloEleitoralRule],
            'solicitante_dt_nascimento' => ['nullable', 'required_unless:solicitante_tipo_codigo,ELEITOR', 'date_format:Y-m-d', 'before:today'],
            'solicitante_telefone' => ['nullable', 'required_unless:solicitante_tipo_codigo,ELEITOR', new TelefoneRule],
            'comprovante_representacao' => ['nullable', 'required_unless:solicitante_tipo_codigo,ELEITOR', $arquivo],
            'eleitor_telefone' => ['required', new TelefoneRule],
            'contato_preferencia_codigo' => ['required', Rule::in(SeuVotoImportaDominios::CONTATOS)],
            'endereco_logradouro' => ['required', 'string', 'max:255'],
            'endereco_numero' => ['required', 'string', 'max:30'],
            'endereco_bairro' => ['required', 'string', 'max:160'],
            'endereco_referencia' => ['nullable', 'string', 'max:500'],
            'veiculo_acessa_codigo' => ['required', Rule::in(SeuVotoImportaDominios::OPCOES)],
            'endereco_alt_logradouro' => ['nullable', 'required_if:veiculo_acessa_codigo,NAO', 'string', 'max:255'],
            'endereco_alt_numero' => ['nullable', 'required_if:veiculo_acessa_codigo,NAO', 'string', 'max:30'],
            'endereco_alt_bairro' => ['nullable', 'required_if:veiculo_acessa_codigo,NAO', 'string', 'max:160'],
            'endereco_alt_referencia' => ['nullable', 'required_if:veiculo_acessa_codigo,NAO', 'string', 'max:500'],
            'declaracao_espera' => ['accepted'],
            'condicoes' => ['required', 'array', 'min:1'],
            'condicoes.*' => ['required', 'distinct', Rule::in(SeuVotoImportaDominios::CONDICOES)],
            'condicao_descricao' => ['nullable', 'string', 'max:1000'],
            'comprovacao_tipo_codigo' => ['required', Rule::in(SeuVotoImportaDominios::COMPROVACOES)],
            'comprovante_condicao' => ['nullable', 'required_if:comprovacao_tipo_codigo,ANEXO', $arquivo],
            'impacto_codigo' => ['required', Rule::in(SeuVotoImportaDominios::IMPACTOS)],
            'impacto_descricao' => ['required', 'string', 'max:2000'],
            'equipamentos' => ['required', 'array', 'min:1'],
            'equipamentos.*' => ['required', 'distinct', Rule::in(SeuVotoImportaDominios::EQUIPAMENTOS)],
            'equipamento_outro' => ['nullable', 'string', 'max:500'],
            'transporte_publico_codigo' => ['required', Rule::in(SeuVotoImportaDominios::TRANSPORTE_PUBLICO)],
            'acompanhante_codigo' => ['required', Rule::in(SeuVotoImportaDominios::OPCOES)],
            'acompanhante_nome' => ['nullable', 'required_if:acompanhante_codigo,SIM', 'string', 'max:200'],
            'acompanhante_telefone' => ['nullable', 'required_if:acompanhante_codigo,SIM', new TelefoneRule],
            'segundo_turno_codigo' => ['required', Rule::in(SeuVotoImportaDominios::OPCOES)],
            'declaracao_sem_transporte' => ['accepted'],
            'declaracao_analise' => ['accepted'],
            'declaracao_sem_ajudante' => ['accepted'],
            'declaracao_compartilhado' => ['accepted'],
            'declaracao_horario' => ['accepted'],
            'declaracao_privacidade' => ['accepted'],
            'declaracao_endereco_responsabilidade' => ['accepted'],
            'declaracao_endereco_acesso' => ['accepted'],
            'declaracao_veracidade' => ['accepted'],
            'observacoes' => ['nullable', 'string', 'max:2000'],
            'cf-turnstile-response' => ['required', 'string', 'max:2048'],
        ];
    }

    public function withValidator(Validator $validator): void
    {
        $validator->after(function (Validator $validator): void {
            $condicoes = array_values(array_filter((array) $this->input('condicoes', []), 'is_string'));
            if (in_array('MOBILIDADE_REDUZIDA', $condicoes, true)
                && trim((string) $this->input('condicao_descricao', '')) === '') {
                $validator->errors()->add('condicao_descricao', 'Descreva a mobilidade reduzida.');
            }

            $equipamentos = array_values(array_filter((array) $this->input('equipamentos', []), 'is_string'));
            if (in_array('NENHUM', $equipamentos, true) && count($equipamentos) > 1) {
                $validator->errors()->add('equipamentos', 'Nenhum equipamento não pode ser combinado com outra opção.');
            }
            if (in_array('OUTRO', $equipamentos, true)
                && trim((string) $this->input('equipamento_outro', '')) === '') {
                $validator->errors()->add('equipamento_outro', 'Descreva o outro equipamento.');
            }
        });
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'solicitante_titulo' => TituloEleitoral::prepararEntrada($this->input('solicitante_titulo')),
            'solicitante_dt_nascimento' => DataNascimentoEleitoral::prepararEntrada(
                $this->input('solicitante_dt_nascimento')
            ),
            'solicitante_telefone' => TelefoneBrasileiro::prepararEntrada($this->input('solicitante_telefone')),
            'eleitor_telefone' => TelefoneBrasileiro::prepararEntrada($this->input('eleitor_telefone')),
            'acompanhante_telefone' => TelefoneBrasileiro::prepararEntrada($this->input('acompanhante_telefone')),
        ]);
    }
}
```
</APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTASOLICITACAOSTOREREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/SeuVotoImporta/SeuVotoImportaStatusRequest.php`
## <APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTASTATUSREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/SeuVotoImporta/SeuVotoImportaStatusRequest.php`
- **Namespace Declaração:** `App\Http\Requests\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaStatusRequest extends FormRequest`

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

namespace App\Http\Requests\SeuVotoImporta;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SeuVotoImportaStatusRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status_codigo' => ['required', Rule::in([
                'RECEBIDA', 'EM_ANALISE', 'PENDENCIA', 'DEFERIDA', 'INDEFERIDA', 'CANCELADA',
            ])],
            'mensagem_publica' => ['nullable', 'string', 'max:2000'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'status_codigo' => mb_strtoupper(trim((string) $this->input('status_codigo')), 'UTF-8'),
            'mensagem_publica' => trim((string) $this->input('mensagem_publica')) ?: null,
        ]);
    }
}
```
</APP_HTTP_REQUESTS_SEUVOTOIMPORTA_SEUVOTOIMPORTASTATUSREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/EnergiaRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_ENERGIAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/EnergiaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class EnergiaRequest extends FormRequest`

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

namespace App\Http\Requests\TabelasAuxiliares;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class EnergiaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    public function rules(): array
    {
        $registroId = $this->route('id');

        return [
            'descricao' => [
                'required',
                'string',
                'max:120',
                Rule::unique('ENERGIA', 'DESCRICAO')->ignore($registroId, 'ID'),
            ],
            'idhtml' => [
                'required',
                'string',
                'max:60',
            ],
        ];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_ENERGIAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/EsferaRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_ESFERAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/EsferaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class EsferaRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\TabelasAuxiliares;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class EsferaRequest extends CodigoDescricaoOrdemAtivoRequest
{
    protected function tabela(): string
    {
        return 'esfera';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'da esfera', 'entidade' => 'uma esfera'];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_ESFERAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/InternetRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_INTERNETREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/InternetRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class InternetRequest extends FormRequest`

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

namespace App\Http\Requests\TabelasAuxiliares;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class InternetRequest extends FormRequest
{
    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    public function rules(): array
    {
        $registroId = $this->route('id');

        return [
            'descricao' => [
                'required',
                'string',
                'max:120',
                Rule::unique('INTERNET', 'DESCRICAO')->ignore($registroId, 'ID'),
            ],
        ];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_INTERNETREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/MunicipioRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_MUNICIPIOREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/MunicipioRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class MunicipioRequest extends FormRequest`

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

namespace App\Http\Requests\TabelasAuxiliares;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class MunicipioRequest extends FormRequest
{
    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    public function rules(): array
    {
        $id = $this->route('id');

        return [
            'zona_id' => ['required', 'integer', 'exists:ZONA,ID'],
            'localidade' => [
                'required',
                'string',
                'max:150',
                Rule::unique('MUNICIPIO', 'LOCALIDADE')
                    ->where(fn ($query) => $query
                        ->where('COD_OBJETO_LOCALIDADE', $this->input('cod_objeto_localidade'))
                        ->where('ZONAID', $this->input('zona_id')))
                    ->ignore($id, 'ID'),
            ],
            'cod_objeto_localidade' => [
                'required',
                'string',
                'max:50',
            ],
        ];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_MUNICIPIOREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/OpcaoBinariaRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_OPCAOBINARIAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/OpcaoBinariaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class OpcaoBinariaRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\TabelasAuxiliares;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class OpcaoBinariaRequest extends CodigoDescricaoOrdemAtivoRequest
{
    protected function tabela(): string
    {
        return 'opcao_binaria';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'da opção', 'entidade' => 'uma opção binária'];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_OPCAOBINARIAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/OperadoraRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_OPERADORAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/OperadoraRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class OperadoraRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\TabelasAuxiliares;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class OperadoraRequest extends CodigoDescricaoOrdemAtivoRequest
{
    protected function tabela(): string
    {
        return 'operadora';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'da operadora', 'entidade' => 'uma operadora'];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_OPERADORAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/QualidadeRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_QUALIDADEREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/QualidadeRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class QualidadeRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\TabelasAuxiliares;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class QualidadeRequest extends CodigoDescricaoOrdemAtivoRequest
{
    protected function tabela(): string
    {
        return 'qualidade';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'da qualidade', 'entidade' => 'uma qualidade'];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_QUALIDADEREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/TipoSinalRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_TIPOSINALREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/TipoSinalRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class TipoSinalRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\TabelasAuxiliares;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class TipoSinalRequest extends CodigoDescricaoOrdemAtivoRequest
{
    protected function tabela(): string
    {
        return 'tipo_sinal';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'do tipo de sinal', 'entidade' => 'um tipo de sinal'];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_TIPOSINALREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/TipoTomadaRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_TIPOTOMADAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/TipoTomadaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class TipoTomadaRequest extends CodigoDescricaoOrdemAtivoRequest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tabela(): string
protected function contextoMensagens(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Requests\TabelasAuxiliares;

use App\Http\Requests\CodigoDescricaoOrdemAtivoRequest;

class TipoTomadaRequest extends CodigoDescricaoOrdemAtivoRequest
{
    protected function tabela(): string
    {
        return 'tipo_tomada';
    }

    protected function contextoMensagens(): array
    {
        return ['complemento' => 'do tipo de tomada', 'entidade' => 'um tipo de tomada'];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_TIPOTOMADAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Requests/TabelasAuxiliares/ZonaRequest.php`
## <APP_HTTP_REQUESTS_TABELASAUXILIARES_ZONAREQUEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Requests/TabelasAuxiliares/ZonaRequest.php`
- **Namespace Declaração:** `App\Http\Requests\TabelasAuxiliares`
- **Entidade / Classe:** `class ZonaRequest extends FormRequest`

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

namespace App\Http\Requests\TabelasAuxiliares;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ZonaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return session('is_admin') === true;
    }

    public function rules(): array
    {
        $id = $this->route('id');

        return [
            'num_zona' => [
                'required',
                'integer',
                'min:1',
                Rule::unique('ZONA', 'NUM_ZONA')->ignore($id, 'ID'),
            ],
            'descricao' => [
                'required',
                'string',
                'max:150',
            ],
        ];
    }
}
```
</APP_HTTP_REQUESTS_TABELASAUXILIARES_ZONAREQUEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Providers/AppServiceProvider.php`
## <APP_PROVIDERS_APPSERVICEPROVIDER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Providers/AppServiceProvider.php`
- **Namespace Declaração:** `App\Providers`
- **Entidade / Classe:** `class AppServiceProvider extends ServiceProvider`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$table = $app['config']['session.table'];
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function register(): void
public function boot(): void
public static function guardExclusiveMigrationCommands(CommandStarting $event, bool $isTestingEnvironment): void
public static function shouldForceHttps(string $environment): bool
private static function isExclusiveMigrationPath(mixed $path): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Providers;

use App\Repositories\Acesso\AcessoRotaGrupoRepository;
use App\Repositories\Acesso\Contracts\AcessoRotaGrupoRepositoryInterface;
use App\Repositories\Auditoria\AuditLogRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoAdminRepository;
use App\Repositories\CadastroEleitoral\CadastroEleitoralAgendamentoRepository;
use App\Repositories\CadastroEleitoral\CadastroEleitoralFilaPainelRepository;
use App\Repositories\CadastroEleitoral\CadastroEleitoralFilaRepository;
use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoAdminRepositoryInterface;
use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoRepositoryInterface;
use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaPainelRepositoryInterface;
use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralFilaRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\CandidaturaColaboradorRepository;
use App\Repositories\ColaboradoresEleitorais\ColaboradorEleitoralEscalaRepository;
use App\Repositories\ColaboradoresEleitorais\Contracts\CandidaturaColaboradorRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ColaboradorEleitoralEscalaRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\EventoVoluntarioRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\ProcessoEleitoralRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\VoluntarioExternoConfirmacaoRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\VoluntarioExternoExclusaoRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\Contracts\VoluntarioManualRepositoryInterface;
use App\Repositories\ColaboradoresEleitorais\EventoVoluntarioRepository;
use App\Repositories\ColaboradoresEleitorais\ProcessoEleitoralRepository;
use App\Repositories\ColaboradoresEleitorais\VoluntarioExternoConfirmacaoRepository;
use App\Repositories\ColaboradoresEleitorais\VoluntarioExternoExclusaoRepository;
use App\Repositories\ColaboradoresEleitorais\VoluntarioManualRepository;
use App\Repositories\Diarias\Contracts\DiariasAlteracaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasAuditoriaSensivelRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasCidadeRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasConfirmadoraRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasConformidadeRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasConsultaSolicitacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasCreditoPassagemRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasDisponibilidadeRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasDocumentoSeiRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasFinanceiroPaginacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasFinanceiroRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasFluxoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasImportacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasLegadoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasLogisticaCadastroRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasParametrosAdministrativosRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasParametrosCalculoProviderInterface;
use App\Repositories\Diarias\Contracts\DiariasParcelamentoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasPrestacaoPaginacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasPrestacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasProrrogacaoBackfillRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasProrrogacaoConsultaRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasProrrogacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasProrrogacaoTransporteRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasPurgeHomologacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasSolicitacaoRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasTransporteTerrestreRepositoryInterface;
use App\Repositories\Diarias\Contracts\DiariasTrechoRepositoryInterface;
use App\Repositories\Diarias\DiariasAlteracaoRepository;
use App\Repositories\Diarias\DiariasAuditoriaSensivelRepository;
use App\Repositories\Diarias\DiariasCidadeRepository;
use App\Repositories\Diarias\DiariasConfirmadoraRepository;
use App\Repositories\Diarias\DiariasConformidadeRepository;
use App\Repositories\Diarias\DiariasConsultaSolicitacaoRepository;
use App\Repositories\Diarias\DiariasCreditoPassagemRepository;
use App\Repositories\Diarias\DiariasDisponibilidadeRepository;
use App\Repositories\Diarias\DiariasDocumentoSeiRepository;
use App\Repositories\Diarias\DiariasFinanceiroRepository;
use App\Repositories\Diarias\DiariasFluxoRepository;
use App\Repositories\Diarias\DiariasImportacaoRepository;
use App\Repositories\Diarias\DiariasLegadoRepository;
use App\Repositories\Diarias\DiariasLogisticaCadastroRepository;
use App\Repositories\Diarias\DiariasParametrosAdministrativosRepository;
use App\Repositories\Diarias\DiariasParametrosCalculoProvider;
use App\Repositories\Diarias\DiariasParcelamentoRepository;
use App\Repositories\Diarias\DiariasPrestacaoRepository;
use App\Repositories\Diarias\DiariasProrrogacaoBackfillRepository;
use App\Repositories\Diarias\DiariasProrrogacaoConsultaRepository;
use App\Repositories\Diarias\DiariasProrrogacaoRepository;
use App\Repositories\Diarias\DiariasProrrogacaoTransporteRepository;
use App\Repositories\Diarias\DiariasPurgeHomologacaoRepository;
use App\Repositories\Diarias\DiariasSolicitacaoRepository;
use App\Repositories\Diarias\DiariasTransporteTerrestreRepository;
use App\Repositories\Diarias\DiariasTrechoRepository;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAssuntoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoAtendimentoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoCatalogoRepositoryInterface;
use App\Repositories\DisqueEleicao\Contracts\DisqueEleicaoRelatorioRepositoryInterface;
use App\Repositories\DisqueEleicao\DisqueEleicaoAssuntoRepository;
use App\Repositories\DisqueEleicao\DisqueEleicaoAtendimentoRepository;
use App\Repositories\DisqueEleicao\DisqueEleicaoCatalogoRepository;
use App\Repositories\DisqueEleicao\DisqueEleicaoRelatorioRepository;
use App\Repositories\Lda\CargoEquipeRepository;
use App\Repositories\Lda\Contracts\CargoEquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\EquipeRepositoryInterface;
use App\Repositories\Lda\Contracts\VoluntarioRotaDistribuicaoRepositoryInterface;
use App\Repositories\Lda\EquipeRepository;
use App\Repositories\Lda\VoluntarioRotaDistribuicaoRepository;
use App\Repositories\Planejamento\Contracts\GrupoUnidadeRepositoryInterface;
use App\Repositories\Planejamento\Contracts\MacroprojetoRepositoryInterface;
use App\Repositories\Planejamento\Contracts\ProjetoRepositoryInterface;
use App\Repositories\Planejamento\Contracts\SubprojetoRepositoryInterface;
use App\Repositories\Planejamento\GrupoUnidadeRepository;
use App\Repositories\Planejamento\MacroprojetoRepository;
use App\Repositories\Planejamento\ProjetoRepository;
use App\Repositories\Planejamento\SubprojetoRepository;
use App\Repositories\Riscos\Contracts\RiscoCicloRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoContextoRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoDominioRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoImportacaoRepositoryInterface;
use App\Repositories\Riscos\Contracts\RiscoRepositoryInterface;
use App\Repositories\Riscos\RiscoCicloRepository;
use App\Repositories\Riscos\RiscoContextoRepository;
use App\Repositories\Riscos\RiscoDominioRepository;
use App\Repositories\Riscos\RiscoImportacaoRepository;
use App\Repositories\Riscos\RiscoRepository;
use App\Repositories\SupervisoresPredio\CadastroSupervisorPredioNotificacaoRepository;
use App\Repositories\SupervisoresPredio\Contracts\CadastroSupervisorPredioNotificacaoRepositoryInterface;
use App\Repositories\Tarefas\CategoriaTarefaRepository;
use App\Repositories\Tarefas\Contracts\CategoriaTarefaRepositoryInterface;
use App\Repositories\Tarefas\Contracts\FaseTarefaRepositoryInterface;
use App\Repositories\Tarefas\Contracts\TarefaRepositoryInterface;
use App\Repositories\Tarefas\FaseTarefaRepository;
use App\Repositories\Tarefas\TarefaRepository;
use App\Repositories\Treinamentos\Contracts\TreinamentoTsePublicoRepositoryInterface;
use App\Repositories\Treinamentos\TreinamentoTsePublicoRepository;
use App\Services\Diarias\ApiDiariasPessoaGateway;
use App\Services\Diarias\Contracts\DiariasPessoaGatewayInterface;
use App\Services\Diarias\DiariasAlteracaoService;
use App\Services\Diarias\DiariasAutorizacaoService;
use App\Services\Diarias\DiariasConflitoViagemService;
use App\Services\Diarias\DiariasDocumentoEtapaSeiService;
use App\Services\Diarias\DiariasPagamentoService;
use App\Services\Diarias\DiariasPrestacaoService;
use App\Services\Diarias\DiariasProrrogacaoService;
use App\Services\Diarias\DiariasSolicitacaoService;
use App\Services\Diarias\DiariasUnidadeContextoService;
use App\Services\Diarias\DiariasWorkflowService;
use App\Session\DatabaseSessionHandlerWithUsername;
use Illuminate\Console\Events\CommandStarting;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;
use Symfony\Component\Console\Exception\RuntimeException;
use Symfony\Component\Mailer\Transport\Smtp\SmtpTransport;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(AuditLogRepositoryInterface::class, AuditLogRepository::class);
        $this->app->bind(AcessoRotaGrupoRepositoryInterface::class, AcessoRotaGrupoRepository::class);
        $this->app->bind(CandidaturaColaboradorRepositoryInterface::class, CandidaturaColaboradorRepository::class);
        $this->app->bind(ColaboradorEleitoralEscalaRepositoryInterface::class, ColaboradorEleitoralEscalaRepository::class);
        $this->app->bind(DisqueEleicaoAssuntoRepositoryInterface::class, DisqueEleicaoAssuntoRepository::class);
        $this->app->bind(DisqueEleicaoAtendimentoRepositoryInterface::class, DisqueEleicaoAtendimentoRepository::class);
        $this->app->bind(DisqueEleicaoCatalogoRepositoryInterface::class, DisqueEleicaoCatalogoRepository::class);
        $this->app->bind(DisqueEleicaoRelatorioRepositoryInterface::class, DisqueEleicaoRelatorioRepository::class);
        $this->app->bind(
            \App\Repositories\Nat\Contracts\NatVistoriaSecaoPerguntaRepositoryInterface::class,
            \App\Repositories\Nat\NatVistoriaSecaoPerguntaRepository::class,
        );
        $this->app->bind(
            \App\Repositories\Nat\Contracts\NatVistoriaSecaoRepositoryInterface::class,
            \App\Repositories\Nat\NatVistoriaSecaoRepository::class,
        );
        $this->app->bind(EventoVoluntarioRepositoryInterface::class, EventoVoluntarioRepository::class);
        $this->app->bind(
            TreinamentoTsePublicoRepositoryInterface::class,
            TreinamentoTsePublicoRepository::class
        );
        $this->app->bind(VoluntarioExternoConfirmacaoRepositoryInterface::class, VoluntarioExternoConfirmacaoRepository::class);
        $this->app->bind(VoluntarioExternoExclusaoRepositoryInterface::class, VoluntarioExternoExclusaoRepository::class);
        $this->app->bind(VoluntarioManualRepositoryInterface::class, VoluntarioManualRepository::class);
        $this->app->bind(VoluntarioRotaDistribuicaoRepositoryInterface::class, VoluntarioRotaDistribuicaoRepository::class);
        $this->app->bind(CadastroEleitoralAgendamentoRepositoryInterface::class, CadastroEleitoralAgendamentoRepository::class);
        $this->app->bind(CadastroEleitoralAgendamentoAdminRepositoryInterface::class, CadastroEleitoralAgendamentoAdminRepository::class);
        $this->app->bind(CadastroEleitoralFilaRepositoryInterface::class, CadastroEleitoralFilaRepository::class);
        $this->app->bind(CadastroSupervisorPredioNotificacaoRepositoryInterface::class, CadastroSupervisorPredioNotificacaoRepository::class);
        $this->app->bind(CadastroEleitoralFilaPainelRepositoryInterface::class, CadastroEleitoralFilaPainelRepository::class);
        $this->app->bind(SubprojetoRepositoryInterface::class, SubprojetoRepository::class);
        $this->app->bind(RiscoRepositoryInterface::class, RiscoRepository::class);
        $this->app->bind(RiscoDominioRepositoryInterface::class, RiscoDominioRepository::class);
        $this->app->bind(RiscoImportacaoRepositoryInterface::class, RiscoImportacaoRepository::class);
        $this->app->bind(RiscoCicloRepositoryInterface::class, RiscoCicloRepository::class);
        $this->app->bind(RiscoContextoRepositoryInterface::class, RiscoContextoRepository::class);
        $this->app->bind(CategoriaTarefaRepositoryInterface::class, CategoriaTarefaRepository::class);
        $this->app->bind(CargoEquipeRepositoryInterface::class, CargoEquipeRepository::class);
        $this->app->bind(EquipeRepositoryInterface::class, EquipeRepository::class);
        $this->app->bind(FaseTarefaRepositoryInterface::class, FaseTarefaRepository::class);
        $this->app->bind(GrupoUnidadeRepositoryInterface::class, GrupoUnidadeRepository::class);
        $this->app->bind(MacroprojetoRepositoryInterface::class, MacroprojetoRepository::class);
        $this->app->bind(ProjetoRepositoryInterface::class, ProjetoRepository::class);
        $this->app->bind(ProcessoEleitoralRepositoryInterface::class, ProcessoEleitoralRepository::class);
        $this->app->bind(TarefaRepositoryInterface::class, TarefaRepository::class);
        $this->app->bind(DiariasCidadeRepositoryInterface::class, DiariasCidadeRepository::class);
        $this->app->bind(DiariasAlteracaoRepositoryInterface::class, DiariasAlteracaoRepository::class);
        $this->app->bind(DiariasAuditoriaSensivelRepositoryInterface::class, DiariasAuditoriaSensivelRepository::class);
        $this->app->bind(DiariasConformidadeRepositoryInterface::class, DiariasConformidadeRepository::class);
        $this->app->bind(DiariasConfirmadoraRepositoryInterface::class, DiariasConfirmadoraRepository::class);
        $this->app->bind(DiariasConsultaSolicitacaoRepositoryInterface::class, DiariasConsultaSolicitacaoRepository::class);
        $this->app->bind(DiariasDisponibilidadeRepositoryInterface::class, DiariasDisponibilidadeRepository::class);
        $this->app->bind(DiariasDocumentoSeiRepositoryInterface::class, DiariasDocumentoSeiRepository::class);
        $this->app->when([DiariasWorkflowService::class, DiariasPagamentoService::class])
            ->needs(DiariasDocumentoEtapaSeiService::class)
            ->give(static fn ($app) => $app->make(DiariasDocumentoEtapaSeiService::class));
        $this->app->when([
            DiariasWorkflowService::class,
            DiariasSolicitacaoService::class,
            DiariasAlteracaoService::class,
            DiariasProrrogacaoService::class,
            DiariasPrestacaoService::class,
        ])
            ->needs(DiariasAutorizacaoService::class)
            ->give(static fn ($app) => $app->make(DiariasAutorizacaoService::class));
        $this->app->when([
            DiariasWorkflowService::class,
            DiariasAlteracaoService::class,
        ])
            ->needs(DiariasUnidadeContextoService::class)
            ->give(static fn ($app) => $app->make(DiariasUnidadeContextoService::class));
        $this->app->bind(DiariasSolicitacaoRepositoryInterface::class, DiariasSolicitacaoRepository::class);
        $this->app->bind(DiariasFluxoRepositoryInterface::class, DiariasFluxoRepository::class);
        $this->app->bind(DiariasTrechoRepositoryInterface::class, DiariasTrechoRepository::class);
        $this->app->bind(DiariasTransporteTerrestreRepositoryInterface::class, DiariasTransporteTerrestreRepository::class);
        $this->app->bind(DiariasFinanceiroRepositoryInterface::class, DiariasFinanceiroRepository::class);
        $this->app->bind(DiariasFinanceiroPaginacaoRepositoryInterface::class, DiariasFinanceiroRepository::class);
        $this->app->bind(DiariasParcelamentoRepositoryInterface::class, DiariasParcelamentoRepository::class);
        $this->app->bind(DiariasCreditoPassagemRepositoryInterface::class, DiariasCreditoPassagemRepository::class);
        $this->app->bind(DiariasPrestacaoRepositoryInterface::class, DiariasPrestacaoRepository::class);
        $this->app->bind(DiariasPrestacaoPaginacaoRepositoryInterface::class, DiariasPrestacaoRepository::class);
        $this->app->bind(DiariasPurgeHomologacaoRepositoryInterface::class, DiariasPurgeHomologacaoRepository::class);
        $this->app->bind(DiariasProrrogacaoRepositoryInterface::class, DiariasProrrogacaoRepository::class);
        $this->app->bind(DiariasProrrogacaoBackfillRepositoryInterface::class, DiariasProrrogacaoBackfillRepository::class);
        $this->app->bind(DiariasProrrogacaoConsultaRepositoryInterface::class, DiariasProrrogacaoConsultaRepository::class);
        $this->app->bind(DiariasProrrogacaoTransporteRepositoryInterface::class, DiariasProrrogacaoTransporteRepository::class);
        $this->app->bind(DiariasLegadoRepositoryInterface::class, DiariasLegadoRepository::class);
        $this->app->bind(DiariasImportacaoRepositoryInterface::class, DiariasImportacaoRepository::class);
        $this->app->bind(DiariasLogisticaCadastroRepositoryInterface::class, DiariasLogisticaCadastroRepository::class);
        $this->app->bind(DiariasParametrosAdministrativosRepositoryInterface::class, DiariasParametrosAdministrativosRepository::class);
        $this->app->bind(DiariasParametrosCalculoProviderInterface::class, DiariasParametrosCalculoProvider::class);
        $this->app->bind(DiariasPessoaGatewayInterface::class, ApiDiariasPessoaGateway::class);
        $this->app->bind(DiariasConflitoViagemService::class);
        $this->app->bind(\App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoAdminCadastroRepositoryInterface::class, CadastroEleitoralAgendamentoAdminRepository::class);
        $this->app->bind(\App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralAgendamentoAdminConsultaRepositoryInterface::class, CadastroEleitoralAgendamentoAdminRepository::class);
        $this->app->bind(\App\Repositories\Tarefas\Contracts\TarefaReferenciaRepositoryInterface::class, TarefaRepository::class);
        $this->app->bind(\App\Repositories\Tarefas\Contracts\TarefaConsultaRepositoryInterface::class, TarefaRepository::class);
        $this->app->bind(\App\Repositories\Tarefas\Contracts\TarefaAndamentoRepositoryInterface::class, TarefaRepository::class);
        $this->app->bind(\App\Repositories\Tarefas\Contracts\TarefaSolicitacaoPrazoRepositoryInterface::class, TarefaRepository::class);
        $this->app->bind(\App\Repositories\Tarefas\Contracts\TarefaEscritaRepositoryInterface::class, TarefaRepository::class);
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDestinatarioRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsDestinatarioRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsDashboardRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsDashboardRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsModeloRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsModeloRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsEnvioRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsProcessamentoRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsEnvioRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsSincronizacaoRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsEnvioRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRecuperacaoRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsEnvioRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsRespostaRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsRespostaRepository::class,
        );
        $this->app->bind(
            \App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsTelefoneManualRepositoryInterface::class,
            \App\Repositories\ConvocacaoSms\ConvocacaoSmsTelefoneManualRepository::class,
        );
        $this->app->bind(
            \App\Services\ConvocacaoSms\Contracts\SmsGatewayInterface::class,
            \App\Services\ConvocacaoSms\TextBeeSmsClient::class,
        );
        $this->app->singleton(
            \App\Services\ConvocacaoSms\ZenviaSmsWebhookAutenticacao::class,
            static fn (): \App\Services\ConvocacaoSms\ZenviaSmsWebhookAutenticacao => new \App\Services\ConvocacaoSms\ZenviaSmsWebhookAutenticacao(
                (string) config('planeleito.sms_zenvia.webhook_secret', ''),
            ),
        );
        $this->app->singleton(
            \App\Services\ConvocacaoSms\TextBeeSmsWebhookAutenticacao::class,
            static fn (): \App\Services\ConvocacaoSms\TextBeeSmsWebhookAutenticacao => new \App\Services\ConvocacaoSms\TextBeeSmsWebhookAutenticacao(
                (string) config('planeleito.sms_textbee.webhook_secret', ''),
            ),
        );

        $this->app->when([
            \App\Http\Controllers\LocaisVotacao\LocalVotacaoCrudController::class,
            \App\Http\Controllers\LocaisVotacao\DashboardLocaisVotacaoController::class,
            \App\Http\Controllers\ForcasSeguranca\ForcasSegurancaLocalVotacaoController::class,
        ])->needs(\App\Services\Planejamento\MacroprojetoTurnoDataEleicaoService::class)
            ->give(\App\Services\Planejamento\MacroprojetoTurnoDataEleicaoService::class);

    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Event::listen(CommandStarting::class, function (CommandStarting $event) {
            self::guardExclusiveMigrationCommands($event, app()->environment('testing'));
        });

        Session::extend('database-with-username', function ($app) {
            $connection = $app['db']->connection($app['config']['session.connection']);
            $table = $app['config']['session.table'];
            $lifetime = $app['config']['session.lifetime'];

            return new DatabaseSessionHandlerWithUsername($connection, $table, $lifetime, $app);
        });

        if (self::shouldForceHttps((string) config('app.env'))) {
            URL::forceScheme('https');
        }

        if (config('mail.disable_auto_tls')) {
            $mailer = Mail::getFacadeRoot()?->mailer();
            if ($mailer && method_exists($mailer, 'getSymfonyTransport')) {
                /** @var \Symfony\Component\Mailer\Transport\TransportInterface|SmtpTransport $transport */
                $transport = $mailer->getSymfonyTransport();
                if ($transport instanceof SmtpTransport && method_exists($transport, 'setAutoTls')) {
                    $transport->{'setAutoTls'}(false);
                }
            }
        }
    }

    public static function guardExclusiveMigrationCommands(CommandStarting $event, bool $isTestingEnvironment): void
    {
        if ($isTestingEnvironment) {
            return;
        }

        $blockedCommands = ['migrate', 'migrate:rollback', 'migrate:fresh', 'migrate:refresh', 'migrate:reset'];

        if (! in_array($event->command, $blockedCommands, true)) {
            return;
        }

        $input = $event->input;

        if ($input->hasOption('help') && $input->getOption('help')) {
            return;
        }

        if (in_array($event->command, ['migrate:fresh', 'migrate:refresh', 'migrate:reset'], true)) {
            throw new RuntimeException(
                "EXECUÇÃO BLOQUEADA: O comando 'php artisan {$event->command}' é altamente destrutivo e proibido neste projeto fora do ambiente de testes."
            );
        }

        $path = $input->hasOption('path') ? $input->getOption('path') : null;

        if (! self::isExclusiveMigrationPath($path)) {
            throw new RuntimeException(
                "MIGRAÇÃO GLOBAL BLOQUEADA: Toda migration deve ser executada isoladamente (modo exclusivo), com arquivo único em database/migrations.\n".
                "Por favor, use:\n".
                "php artisan migrate:exclusive <nome_do_arquivo>\n".
                "Ou:\n".
                "php artisan {$event->command} --path=database/migrations/<nome_do_arquivo>.php"
            );
        }
    }

    public static function shouldForceHttps(string $environment): bool
    {
        return in_array($environment, ['production', 'local'], true);
    }

    private static function isExclusiveMigrationPath(mixed $path): bool
    {
        if (is_array($path)) {
            if (count($path) !== 1) {
                return false;
            }
            $path = array_values($path)[0];
        }

        if (! is_string($path)) {
            return false;
        }

        $normalized = trim(str_replace('\\', '/', $path));

        return preg_match('#^database/migrations/[^/]+\.php$#', $normalized) === 1;
    }
}
```
</APP_PROVIDERS_APPSERVICEPROVIDER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Concerns/AuditaDml.php`
## <APP_REPOSITORIES_CONCERNS_AUDITADML_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Concerns/AuditaDml.php`
- **Namespace Declaração:** `App\Repositories\Concerns`
- **Entidade / Classe:** `trait AuditaDml`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table($tabela)->where($colunaId, $id);
? DB::table($tabela)->insertGetId($dados, $sequencia)
: DB::table($tabela)->insertGetId($dados);
static fn (): bool => DB::table($tabela)->insert($dados),
static fn (): bool => DB::table($tabela)->insert($dados),
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
protected function inicializarAuditoria(AuditLogService $auditLogService): void
protected function buscarRegistro(string $tabela, string $colunaId, mixed $id, bool $bloquear = false): ?array
protected function buscarRegistros(string $tabela, string $coluna, mixed $valor, bool $bloquear = false): array
protected function buscarRegistrosPorEscopo(string $tabela, Closure $escopo, bool $bloquear = false): array
protected function inserirAuditado(
protected function inserirSemIdAuditado(
protected function inserirLoteAuditado(
protected function atualizarAuditadoPorId(
protected function atualizarEscopoAuditado(
protected function removerAuditadoPorId(
protected function removerEscopoAuditado(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Concerns;

use App\Services\Auditoria\AuditLogService;
use Closure;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use LogicException;
use Throwable;

trait AuditaDml
{
    private AuditLogService $auditLogService;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    protected function inicializarAuditoria(AuditLogService $auditLogService): void
    {
        $this->auditLogService = $auditLogService;
    }

    protected function buscarRegistro(string $tabela, string $colunaId, mixed $id, bool $bloquear = false): ?array
    {
        if ($id === null || $id === '') {
            return null;
        }

        $query = DB::table($tabela)->where($colunaId, $id);
        if ($bloquear) {
            $query->lockForUpdate();
        }

        $registro = $query->first();
        if (! $registro) {
            return null;
        }

        return $this->normalizarValor($registro);
    }

    protected function buscarRegistros(string $tabela, string $coluna, mixed $valor, bool $bloquear = false): array
    {
        return $this->buscarRegistrosPorEscopo(
            $tabela,
            static fn ($query) => $query->where($coluna, $valor),
            $bloquear
        );
    }

    /**
     * @return array<int, mixed>
     */
    protected function buscarRegistrosPorEscopo(string $tabela, Closure $escopo, bool $bloquear = false): array
    {
        $query = $this->queryComEscopo($tabela, $escopo);
        if ($bloquear) {
            $query->lockForUpdate();
        }

        return $query
            ->get()
            ->map(fn ($item) => $this->normalizarValor($item))
            ->all();
    }

    protected function inserirAuditado(
        string $tabela,
        string $entidade,
        array $dados,
        string $colunaId = 'ID',
        ?string $sequencia = null
    ): int {
        $comandoSql = 'INSERT BUILDER: '.$tabela;

        return $this->executarMutacaoAuditada(
            'INSERT',
            $entidade,
            null,
            $comandoSql,
            $dados,
            null,
            function () use ($tabela, $dados, $sequencia): int {
                return $sequencia !== null
                    ? DB::table($tabela)->insertGetId($dados, $sequencia)
                    : DB::table($tabela)->insertGetId($dados);
            },
            fn (int $id): ?array => $this->buscarRegistro($tabela, $colunaId, $id),
            static fn (): int => 1,
            static fn (int $id): int => $id
        );
    }

    protected function inserirSemIdAuditado(
        string $tabela,
        string $entidade,
        array $dados,
        int|string|null $registroId = null,
        ?Closure $localizadorDepois = null
    ): bool {
        if ($localizadorDepois === null) {
            throw new \InvalidArgumentException('Insert sem id auditado exige localizador do estado persistido.');
        }

        $comandoSql = 'INSERT BUILDER: '.$tabela;

        return $this->executarMutacaoAuditada(
            'INSERT',
            $entidade,
            $registroId,
            $comandoSql,
            $dados,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $localizadorDepois, true),
            static fn (): bool => DB::table($tabela)->insert($dados),
            fn (bool $resultado, array $antes): array => $this->resolverDeltaInsert(
                $antes,
                $this->buscarRegistrosPorEscopo($tabela, $localizadorDepois),
                $resultado ? 1 : 0
            ),
            static fn (bool $resultado): int => $resultado ? 1 : 0
        );
    }

    /**
     * @param  array<int, array<string, mixed>>  $dados
     */
    protected function inserirLoteAuditado(
        string $tabela,
        string $entidade,
        array $dados,
        int|string|null $registroId = null,
        ?Closure $localizadorDepois = null
    ): bool {
        if ($dados === []) {
            return true;
        }

        if ($localizadorDepois === null) {
            throw new \InvalidArgumentException('Insert em lote auditado exige localizador do estado persistido.');
        }

        $comandoSql = 'INSERT BATCH BUILDER: '.$tabela;

        return $this->executarMutacaoAuditada(
            'INSERT',
            $entidade,
            $registroId,
            $comandoSql,
            $dados,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $localizadorDepois, true),
            static fn (): bool => DB::table($tabela)->insert($dados),
            fn (bool $resultado, array $antes): array => $this->resolverDeltaInsert(
                $antes,
                $this->buscarRegistrosPorEscopo($tabela, $localizadorDepois),
                $resultado ? count($dados) : 0
            ),
            static fn (bool $resultado): int => $resultado ? count($dados) : 0
        );
    }

    protected function atualizarAuditadoPorId(
        string $tabela,
        string $entidade,
        string $colunaId,
        mixed $id,
        array $dados
    ): int {
        $comandoSql = 'UPDATE BUILDER: '.$tabela.' WHERE '.$colunaId.' = ?';
        $bindings = [
            'where' => [$colunaId => $id],
            'dados' => $dados,
        ];

        return $this->executarMutacaoAuditada(
            'UPDATE',
            $entidade,
            $id,
            $comandoSql,
            $bindings,
            fn (): ?array => $this->buscarRegistro($tabela, $colunaId, $id, true),
            static fn (): int => DB::table($tabela)
                ->where($colunaId, $id)
                ->update($dados),
            fn (): ?array => $this->buscarRegistro($tabela, $colunaId, $id),
            static fn (int $afetados): int => $afetados
        );
    }

    protected function atualizarEscopoAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        Closure $escopo,
        array $dados,
        array $bindings = []
    ): int {
        $comandoSql = 'UPDATE BUILDER: '.$tabela;
        $bindingsEfetivos = $bindings + ['dados' => $dados];

        return $this->executarMutacaoAuditada(
            'UPDATE',
            $entidade,
            $registroId,
            $comandoSql,
            $bindingsEfetivos,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $escopo, true),
            fn (): int => $this->queryComEscopo($tabela, $escopo)->update($dados),
            fn (int $afetados, array $antes): array => $this->buscarRegistrosDepoisAtualizacao($tabela, $escopo, $antes),
            static fn (int $afetados): int => $afetados
        );
    }

    protected function removerAuditadoPorId(
        string $tabela,
        string $entidade,
        string $colunaId,
        mixed $id
    ): int {
        $comandoSql = 'DELETE BUILDER: '.$tabela.' WHERE '.$colunaId.' = ?';
        $bindings = [$id];

        return $this->executarMutacaoAuditada(
            'DELETE',
            $entidade,
            $id,
            $comandoSql,
            $bindings,
            fn (): ?array => $this->buscarRegistro($tabela, $colunaId, $id, true),
            static fn (): int => DB::table($tabela)
                ->where($colunaId, $id)
                ->delete(),
            null,
            static fn (int $afetados): int => $afetados
        );
    }

    protected function removerEscopoAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        Closure $escopo,
        array $bindings = []
    ): int {
        $comandoSql = 'DELETE BUILDER: '.$tabela;

        return $this->executarMutacaoAuditada(
            'DELETE',
            $entidade,
            $registroId,
            $comandoSql,
            $bindings,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $escopo, true),
            fn (): int => $this->queryComEscopo($tabela, $escopo)->delete(),
            null,
            static fn (int $afetados): int => $afetados
        );
    }

    protected function inserirSqlAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        string $sql,
        array $bindings,
        Closure $localizadorDepois
    ): int {
        return $this->executarMutacaoAuditada(
            'INSERT',
            $entidade,
            $registroId,
            $sql,
            $bindings,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $localizadorDepois, true),
            static fn (): int => DB::affectingStatement($sql, $bindings),
            fn (int $afetados, array $antes): array => $this->resolverDeltaInsert(
                $antes,
                $this->buscarRegistrosPorEscopo($tabela, $localizadorDepois),
                $afetados
            ),
            static fn (int $afetados): int => $afetados
        );
    }

    protected function atualizarSqlAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        string $sql,
        array $bindings,
        Closure $escopoAntes,
        ?Closure $escopoDepois = null
    ): int {
        return $this->executarMutacaoAuditada(
            'UPDATE',
            $entidade,
            $registroId,
            $sql,
            $bindings,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $escopoAntes, true),
            static fn (): int => DB::affectingStatement($sql, $bindings),
            fn (int $afetados, array $antes): array => $escopoDepois !== null
                ? $this->buscarRegistrosPorEscopo($tabela, $escopoDepois)
                : $this->buscarRegistrosDepoisAtualizacao($tabela, $escopoAntes, $antes),
            static fn (int $afetados): int => $afetados
        );
    }

    protected function removerSqlAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        string $sql,
        array $bindings,
        Closure $escopoAntes
    ): int {
        return $this->executarMutacaoAuditada(
            'DELETE',
            $entidade,
            $registroId,
            $sql,
            $bindings,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $escopoAntes, true),
            static fn (): int => DB::affectingStatement($sql, $bindings),
            null,
            static fn (int $afetados): int => $afetados
        );
    }

    protected function incrementarEscopoAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        Closure $escopo,
        string $coluna,
        int|float $quantidade = 1,
        array $dadosAdicionais = [],
        array $bindings = []
    ): int {
        return $this->alterarContadorEscopoAuditado(
            false,
            $tabela,
            $entidade,
            $registroId,
            $escopo,
            $coluna,
            $quantidade,
            $dadosAdicionais,
            $bindings
        );
    }

    protected function decrementarEscopoAuditado(
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        Closure $escopo,
        string $coluna,
        int|float $quantidade = 1,
        array $dadosAdicionais = [],
        array $bindings = []
    ): int {
        return $this->alterarContadorEscopoAuditado(
            true,
            $tabela,
            $entidade,
            $registroId,
            $escopo,
            $coluna,
            $quantidade,
            $dadosAdicionais,
            $bindings
        );
    }

    protected function auditarDml(
        string $acao,
        string $entidade,
        int|string|null $registroId,
        string $comandoSql,
        array $bindings = [],
        mixed $antes = null,
        mixed $depois = null,
        bool $sucesso = true,
        ?string $erro = null
    ): void {
        if (! $sucesso) {
            $this->registrarFalhaTecnicaAuditaDml($acao, $entidade, $erro ?? 'Falha de DML sem mensagem.');

            return;
        }

        $this->auditLogService->registrarAcao(
            $acao,
            $entidade,
            $registroId,
            $comandoSql,
            $bindings,
            $this->normalizarValor($antes),
            $this->normalizarValor($depois),
            $sucesso,
            $erro
        );
    }

    private function executarMutacaoAuditada(
        string $acao,
        string $entidade,
        int|string|null $registroId,
        string $comandoSql,
        array $bindings,
        ?Closure $capturarAntes,
        Closure $executarDml,
        ?Closure $capturarDepois,
        Closure $resolverAfetados,
        ?Closure $resolverRegistroId = null
    ): mixed {
        $fase = 'inicio';

        try {
            return DB::transaction(function () use (
                $acao,
                $entidade,
                $registroId,
                $comandoSql,
                $bindings,
                $capturarAntes,
                $executarDml,
                $capturarDepois,
                $resolverAfetados,
                $resolverRegistroId,
                &$fase
            ): mixed {
                $fase = 'snapshot_antes';
                $antes = $capturarAntes !== null ? $capturarAntes() : null;

                $fase = 'dml';
                $resultado = $executarDml();
                $afetados = max(0, (int) $resolverAfetados($resultado));
                if ($afetados === 0) {
                    return $resultado;
                }

                $fase = 'snapshot_depois';
                $depois = $capturarDepois !== null ? $capturarDepois($resultado, $antes) : null;

                if (! $this->auditaDmlMudancaEfetiva($acao, $antes, $depois)) {
                    return $resultado;
                }

                $bindingsEfetivos = $bindings;
                $bindingsEfetivos['afetados'] = $afetados;
                $idEfetivo = $resolverRegistroId !== null
                    ? $resolverRegistroId($resultado, $antes, $depois)
                    : $registroId;

                $fase = 'auditoria';
                $this->auditarDml(
                    $acao,
                    $entidade,
                    $idEfetivo,
                    $comandoSql,
                    $bindingsEfetivos,
                    $acao === 'INSERT' ? null : $antes,
                    $depois
                );

                return $resultado;
            });
        } catch (Throwable $exception) {
            $this->registrarFalhaTecnicaAuditaDml($acao, $entidade, $exception->getMessage(), $fase);
            throw $exception;
        }
    }

    private function auditaDmlMudancaEfetiva(string $acao, mixed $antes, mixed $depois): bool
    {
        if ($acao === 'INSERT') {
            if (! $this->auditaDmlPossuiSnapshot($depois)) {
                throw new LogicException('INSERT aplicado sem snapshot persistido para auditoria.');
            }

            return true;
        }

        if ($acao === 'UPDATE') {
            if (! $this->auditaDmlPossuiSnapshot($antes) || ! $this->auditaDmlPossuiSnapshot($depois)) {
                throw new LogicException('UPDATE aplicado sem snapshots completos para auditoria.');
            }

            return $this->auditaDmlCanonicalizar($antes) !== $this->auditaDmlCanonicalizar($depois);
        }

        if ($acao === 'DELETE') {
            if (! $this->auditaDmlPossuiSnapshot($antes)) {
                throw new LogicException('DELETE aplicado sem snapshot anterior para auditoria.');
            }

            return true;
        }

        throw new LogicException('Acao DML nao suportada pelo executor auditado.');
    }

    private function alterarContadorEscopoAuditado(
        bool $decrementar,
        string $tabela,
        string $entidade,
        int|string|null $registroId,
        Closure $escopo,
        string $coluna,
        int|float $quantidade,
        array $dadosAdicionais,
        array $bindings
    ): int {
        $operacao = $decrementar ? 'decrement' : 'increment';
        $bindingsEfetivos = $bindings + [
            'operacao' => $operacao,
            'coluna' => $coluna,
            'quantidade' => $quantidade,
            'dados' => $dadosAdicionais,
        ];

        return $this->executarMutacaoAuditada(
            'UPDATE',
            $entidade,
            $registroId,
            strtoupper($operacao).' BUILDER: '.$tabela,
            $bindingsEfetivos,
            fn (): array => $this->buscarRegistrosPorEscopo($tabela, $escopo, true),
            fn (): int => $decrementar
                ? $this->queryComEscopo($tabela, $escopo)->decrement($coluna, $quantidade, $dadosAdicionais)
                : $this->queryComEscopo($tabela, $escopo)->increment($coluna, $quantidade, $dadosAdicionais),
            fn (int $afetados, array $antes): array => $this->buscarRegistrosDepoisAtualizacao($tabela, $escopo, $antes),
            static fn (int $afetados): int => $afetados
        );
    }

    private function auditaDmlPossuiSnapshot(mixed $valor): bool
    {
        return $valor !== null && $valor !== [];
    }

    private function auditaDmlCanonicalizar(mixed $valor): mixed
    {
        $valor = $this->normalizarValor($valor);
        if (! is_array($valor)) {
            return $valor;
        }

        foreach ($valor as $chave => $item) {
            $valor[$chave] = $this->auditaDmlCanonicalizar($item);
        }

        if (array_is_list($valor)) {
            usort($valor, static fn (mixed $a, mixed $b): int => strcmp(
                json_encode($a, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?: '',
                json_encode($b, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?: ''
            ));

            return $valor;
        }

        ksort($valor);

        return $valor;
    }

    /**
     * @param  array<int, mixed>  $antes
     * @param  array<int, mixed>  $depois
     * @return array<int, mixed>
     */
    private function resolverDeltaInsert(array $antes, array $depois, int $afetados): array
    {
        $ocorrenciasAnteriores = [];
        foreach ($antes as $registro) {
            $chave = $this->chaveCanonicaAuditaDml($registro);
            $ocorrenciasAnteriores[$chave] = ($ocorrenciasAnteriores[$chave] ?? 0) + 1;
        }

        $delta = [];
        foreach ($depois as $registro) {
            $chave = $this->chaveCanonicaAuditaDml($registro);
            if (($ocorrenciasAnteriores[$chave] ?? 0) > 0) {
                $ocorrenciasAnteriores[$chave]--;

                continue;
            }

            $delta[] = $this->normalizarValor($registro);
        }

        if ($delta === [] && $afetados > 0) {
            throw new LogicException('INSERT aplicado sem snapshot persistido para auditoria.');
        }

        if (count($delta) !== $afetados) {
            throw new LogicException(
                'Quantidade afetada pelo INSERT diverge do delta persistido para auditoria.'
            );
        }

        return $delta;
    }

    private function chaveCanonicaAuditaDml(mixed $valor): string
    {
        return json_encode(
            $this->auditaDmlCanonicalizar($valor),
            JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
        );
    }

    private function registrarFalhaTecnicaAuditaDml(
        string $acao,
        string $entidade,
        string $mensagem,
        string $fase = 'dml'
    ): void {
        $entidadeNormalizada = strtoupper(trim($entidade));
        if (str_starts_with($entidadeNormalizada, 'SVI_')) {
            $mensagem = 'Falha técnica em DML do módulo SVI.';
        }

        Log::error('Falha em operacao DML auditada.', [
            'acao' => strtoupper(trim($acao)),
            'entidade' => $entidadeNormalizada,
            'fase' => $fase,
            'erro' => $mensagem,
        ]);
    }

    private function normalizarValor(mixed $valor): mixed
    {
        if (is_object($valor)) {
            return (array) $valor;
        }

        if (is_array($valor)) {
            return array_map(fn ($item) => $this->normalizarValor($item), $valor);
        }

        return $valor;
    }

    /**
     * @param  array<int, mixed>  $antes
     * @return array<int, mixed>
     */
    private function buscarRegistrosDepoisAtualizacao(string $tabela, Closure $escopo, array $antes): array
    {
        foreach (['id', 'ID'] as $coluna) {
            $ids = [];

            foreach ($antes as $registro) {
                if (! is_array($registro)
                    || ! array_key_exists($coluna, $registro)
                    || (! is_int($registro[$coluna]) && ! is_string($registro[$coluna]))) {
                    $ids = [];
                    break;
                }

                $ids[] = $registro[$coluna];
            }

            if ($ids !== []) {
                $ids = array_values(array_unique($ids, SORT_REGULAR));

                return $this->buscarRegistrosPorEscopo(
                    $tabela,
                    static fn ($query) => $query->whereIn($coluna, $ids)
                );
            }
        }

        return $this->buscarRegistrosPorEscopo($tabela, $escopo);
    }

    /** @return Builder */
    private function queryComEscopo(string $tabela, Closure $escopo)
    {
        $query = DB::table($tabela);
        $resultado = $escopo($query);

        return $resultado instanceof Builder ? $resultado : $query;
    }
}
```
</APP_REPOSITORIES_CONCERNS_AUDITADML_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Gel/GelRespostaRepository.php`
## <APP_REPOSITORIES_GEL_GELRESPOSTAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Gel/GelRespostaRepository.php`
- **Namespace Declaração:** `App\Repositories\Gel`
- **Entidade / Classe:** `class GelRespostaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarCategoriasUltimaVistoriaPorCodigosLocais(array $codigosLocais): array
public function listarRespostasUltimaVistoriaPorCategoria(string $codObjeto, int $codCategoriaVistoria): array
private function normalizarCodigos(array $codigos): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Gel;

use Illuminate\Support\Facades\DB;

class GelRespostaRepository
{
    /**
     * @param array<int, string|int> $codigosLocais
     * @return array<string, array<int, object>>
     */
    public function listarCategoriasUltimaVistoriaPorCodigosLocais(array $codigosLocais): array
    {
        $codigos = $this->normalizarCodigos($codigosLocais);
        if (empty($codigos)) {
            return [];
        }

        $placeholders = implode(', ', array_fill(0, count($codigos), '?'));
        $sql = <<<SQL
WITH respostas_rankeadas AS (
    SELECT
        r.*,
        DENSE_RANK() OVER (
            PARTITION BY TRIM(cod_objeto_local_votacao)
            ORDER BY dat_vistoria DESC NULLS LAST, cod_vistoria DESC
        ) AS rank_vistoria
    FROM vw_gel_respostas_ac r
    WHERE TRIM(cod_objeto_local_votacao) IN ($placeholders)
)
SELECT
    TRIM(cod_objeto_local_votacao) AS cod_objeto_local_votacao,
    cod_vistoria,
    txt_tipo_vistoria,
    dat_vistoria,
    cod_categoria_vistoria,
    MIN(ordem_categoria) AS ordem_categoria,
    categoria,
    COUNT(*) AS total_respostas
FROM respostas_rankeadas
WHERE rank_vistoria = 1
  AND cod_categoria_vistoria IS NOT NULL
GROUP BY
    TRIM(cod_objeto_local_votacao),
    cod_vistoria,
    txt_tipo_vistoria,
    dat_vistoria,
    cod_categoria_vistoria,
    categoria
ORDER BY
    cod_objeto_local_votacao,
    ordem_categoria,
    categoria
SQL;

        $linhas = DB::select($sql, $codigos);
        $resultado = [];
        foreach ($linhas as $linha) {
            $codigo = trim((string) data_get($linha, 'cod_objeto_local_votacao', ''));
            if ($codigo === '') {
                continue;
            }
            $resultado[$codigo][] = $linha;
        }

        return $resultado;
    }

    /**
     * @return array<int, object>
     */
    public function listarRespostasUltimaVistoriaPorCategoria(string $codObjeto, int $codCategoriaVistoria): array
    {
        $codigo = trim($codObjeto);
        if ($codigo === '' || $codCategoriaVistoria <= 0) {
            return [];
        }

        $sql = <<<SQL
WITH respostas_rankeadas AS (
    SELECT
        r.*,
        DENSE_RANK() OVER (
            PARTITION BY TRIM(cod_objeto_local_votacao)
            ORDER BY dat_vistoria DESC NULLS LAST, cod_vistoria DESC
        ) AS rank_vistoria
    FROM vw_gel_respostas_ac r
    WHERE TRIM(cod_objeto_local_votacao) = ?
)
SELECT
    uf,
    municipio,
    zona,
    TRIM(cod_objeto_local_votacao) AS cod_objeto_local_votacao,
    numero_local,
    nome_local,
    cod_vistoria,
    txt_tipo_vistoria,
    dat_vistoria,
    ordem_categoria,
    categoria,
    ordem_questao,
    questao,
    tipo_questao,
    resposta,
    cod_question_vistoria,
    cod_categoria_vistoria
FROM respostas_rankeadas
WHERE rank_vistoria = 1
  AND cod_categoria_vistoria = ?
ORDER BY
    ordem_questao,
    questao
SQL;

        return DB::select($sql, [$codigo, $codCategoriaVistoria]);
    }

    /**
     * @param array<int, string|int> $codigos
     * @return array<int, string>
     */
    private function normalizarCodigos(array $codigos): array
    {
        return array_values(array_unique(array_filter(array_map(
            static fn ($codigo): string => trim((string) $codigo),
            $codigos
        ), static fn (string $codigo): bool => $codigo !== '')));
    }
}
```
</APP_REPOSITORIES_GEL_GELRESPOSTAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Rcand/RcandRepository.php`
## <APP_REPOSITORIES_RCAND_RCANDREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Rcand/RcandRepository.php`
- **Namespace Declaração:** `App\Repositories\Rcand`
- **Entidade / Classe:** `class RcandRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('planeleito.rcand_consolidado_processos as processo')
$query = DB::table('planeleito.rcand_cand_processos as processo')
$query = DB::table('planeleito.rcand_candexweb_pedidos as pedido')
$query = DB::table('planeleito.rcand_candexweb_candidatos as candidato')
return DB::table('planeleito.rcand_consolidado_processos as processo')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarPaginado(array $filtros, mixed $aba = 'gerencial', int $perPage = 50, string $pageName = 'page'): LengthAwarePaginator
public function listarCandPaginado(array $filtros, int $perPage = 50, string $pageName = 'cand_page'): LengthAwarePaginator
public function listarCandexwebPedidosPaginado(array $filtros, int $perPage = 50, string $pageName = 'candexweb_pedidos_page'): LengthAwarePaginator
public function listarCandexwebCandidatosPaginado(array $filtros, int $perPage = 50, string $pageName = 'candexweb_candidatos_page'): LengthAwarePaginator
public function listarParaExportacao(
public function totaisVisoesCand(array $filtros): array
public function resumo(array $filtros, string $aba = 'gerencial'): array
public function graficos(array $filtros, string $aba = 'gerencial'): array
public function opcoes(): array
private function query(array $filtros, string $aba = 'gerencial'): Builder
private function queryCand(array $filtros): Builder
private function queryCandexwebPedidos(array $filtros): Builder
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Rcand;

use App\Support\Rcand\RcandImpugnacao;
use App\Support\Rcand\RcandVisaoCand;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class RcandRepository
{
    private const ABAS = ['gerencial', 'detalhes', 'segundo-grau', 'draps', 'cand', 'glossario'];

    /** @param array<string, string> $filtros */
    public function listarPaginado(array $filtros, mixed $aba = 'gerencial', int $perPage = 50, string $pageName = 'page'): LengthAwarePaginator
    {
        if (is_int($aba)) {
            $perPage = $aba;
            $aba = 'gerencial';
        }

        return $this->query($filtros, (string) $aba)
            ->orderBy('processo.nr_processo')
            ->paginate($perPage, ['*'], $pageName);
    }

    /** @param array<string, string> $filtros */
    public function listarCandPaginado(array $filtros, int $perPage = 50, string $pageName = 'cand_page'): LengthAwarePaginator
    {
        return $this->queryCand($filtros)
            ->orderBy('processo.tp_processo')
            ->orderBy('processo.cd_eleicao')
            ->orderBy('processo.nr_processo')
            ->paginate($perPage, ['*'], $pageName);
    }

    /** @param array<string, string> $filtros */
    public function listarCandexwebPedidosPaginado(array $filtros, int $perPage = 50, string $pageName = 'candexweb_pedidos_page'): LengthAwarePaginator
    {
        return $this->queryCandexwebPedidos($filtros)
            ->orderBy('pedido.cd_eleicao')
            ->orderBy('pedido.sg_ue')
            ->orderBy('pedido.sq_pedido')
            ->paginate($perPage, ['*'], $pageName);
    }

    /** @param array<string, string> $filtros */
    public function listarCandexwebCandidatosPaginado(array $filtros, int $perPage = 50, string $pageName = 'candexweb_candidatos_page'): LengthAwarePaginator
    {
        return $this->queryCandexwebCandidatos($filtros)
            ->orderBy('candidato.cd_eleicao')
            ->orderBy('candidato.sq_pedido')
            ->orderBy('candidato.nr_candidato')
            ->paginate($perPage, ['*'], $pageName);
    }

    /** @param array<string, string> $filtros */
    public function listarParaExportacao(
        array $filtros,
        string $aba = 'gerencial',
        string $visaoCand = RcandVisaoCand::PADRAO,
    ): Collection {
        if ($aba === 'cand') {
            return match ($visaoCand) {
                RcandVisaoCand::PROCESSOS => $this->queryCand($filtros)
                    ->orderBy('processo.tp_processo')
                    ->orderBy('processo.cd_eleicao')
                    ->orderBy('processo.nr_processo')
                    ->get(),
                RcandVisaoCand::COMPARACAO => $this->query($filtros, 'cand')
                    ->orderBy('processo.nr_processo')
                    ->get(),
                RcandVisaoCand::PEDIDOS => $this->queryCandexwebPedidos($filtros)
                    ->orderBy('pedido.cd_eleicao')
                    ->orderBy('pedido.sg_ue')
                    ->orderBy('pedido.sq_pedido')
                    ->get(),
                RcandVisaoCand::CANDIDATOS => $this->queryCandexwebCandidatos($filtros)
                    ->orderBy('candidato.cd_eleicao')
                    ->orderBy('candidato.sq_pedido')
                    ->orderBy('candidato.nr_candidato')
                    ->get(),
                default => throw new \InvalidArgumentException('Visualização CAND inválida.'),
            };
        }

        return $this->query($filtros, $aba)
            ->orderBy('processo.nr_processo')
            ->get();
    }

    /**
     * @param  array<string, string>  $filtros
     * @return array<string, int>
     */
    public function totaisVisoesCand(array $filtros): array
    {
        return [
            RcandVisaoCand::PROCESSOS => $this->queryCand($filtros)->count(),
            RcandVisaoCand::COMPARACAO => $this->query($filtros, 'cand')->count(),
            RcandVisaoCand::PEDIDOS => $this->queryCandexwebPedidos($filtros)->count(),
            RcandVisaoCand::CANDIDATOS => $this->queryCandexwebCandidatos($filtros)->count(),
        ];
    }

    /** @param array<string, string> $filtros */
    public function resumo(array $filtros, string $aba = 'gerencial'): array
    {
        $base = $this->query($filtros, $aba);
        $total = (clone $base)->count();
        $divergentes = (clone $base)->where('if_cand_x_pje', 'Diferente')->count();
        $julgados = (clone $base)->where('julgados_pje_sn', 'Sim')->count();

        return [
            'total' => $total,
            'com_pje' => (clone $base)->where('st_existe_pje', 'Sim')->count(),
            'com_cand' => (clone $base)->where('st_existe_cand', 'Sim')->count(),
            'divergentes' => $divergentes,
            'julgados' => $julgados,
            'sem_julgamento' => max(0, $total - $julgados),
            'cand_pje' => $divergentes > 0 ? 'Divergente' : 'OK',
        ];
    }

    /** @param array<string, string> $filtros */
    public function graficos(array $filtros, string $aba = 'gerencial'): array
    {
        return [
            'publicacao_edital' => $this->serie($filtros, $aba, 'cert_publ_sn'),
            'julgados' => $this->serie($filtros, $aba, 'julgados_pje_sn'),
            'parecer_mpe' => $this->serie($filtros, $aba, 'sem_int_mpe'),
            'informacao_candidato' => $this->serie($filtros, $aba, 'inform_candidato_sn'),
            'peticoes_avulsas' => $this->serie($filtros, $aba, 'todas_peticoes_lidas'),
            'cand_pje' => $this->serie($filtros, $aba, 'if_cand_x_pje'),
        ];
    }

    public function opcoes(): array
    {
        return [
            'tipos' => $this->valoresDistintos('tipo_registro'),
            'divergencias' => $this->valoresDistintos('if_cand_x_pje'),
            'situacoes_cand' => $this->valoresDistintos('cand_situacao_processo'),
            'certidoes_publicacao' => $this->valoresDistintos('cert_publ_sn'),
            'informacoes_candidato' => $this->valoresDistintos('inform_candidato_sn'),
            'impugnacoes' => RcandImpugnacao::todos(),
            'julgamentos_pje' => $this->valoresDistintos('julgados_pje_sn'),
            'datas_primeiro_recurso' => $this->valoresDistintos('data_primeiro_recurso'),
            'contrarrazoes' => $this->valoresDistintos('contrarrazao'),
            'remessas_tre' => $this->valoresDistintos('remessa_tre'),
            'partidos' => $this->opcoesPartidos(),
        ];
    }

    /** @param array<string, string> $filtros */
    private function query(array $filtros, string $aba = 'gerencial'): Builder
    {
        $query = DB::table('planeleito.rcand_consolidado_processos as processo')
            ->select('processo.*')
            ->leftJoinSub($this->subconsultaPartidosProcessos(), 'partidos_rel', function ($join): void {
                $join->on('partidos_rel.cd_eleicao', '=', 'processo.cd_eleicao')
                    ->on(
                        'partidos_rel.nr_processo_sem_formatacao',
                        '=',
                        'processo.nr_processo_sem_formatacao'
                    );
            })
            ->addSelect('partidos_rel.partidos');
        $aba = $this->normalizarAba($aba);

        if ($aba === 'draps') {
            $query->where('processo.tipo_registro', 'DRAP');
        }

        if (($filtros['processo'] ?? '') !== '') {
            $processo = mb_strtoupper($filtros['processo']);
            $processoNumerico = preg_replace('/\D+/', '', $processo);
            $query->where(function (Builder $q) use ($processo, $processoNumerico): void {
                $q->whereRaw('UPPER(processo.nr_processo) LIKE ?', ['%'.$processo.'%'])
                    ->orWhereRaw('UPPER(processo.cand_processo) LIKE ?', ['%'.$processo.'%']);

                if ($processoNumerico !== '') {
                    $q->orWhereRaw('UPPER(processo.nr_processo_sem_formatacao) LIKE ?', ['%'.$processoNumerico.'%']);
                }
            });
        }

        foreach ($this->mapaFiltrosConsolidado() as $filtro => $coluna) {
            if (($filtros[$filtro] ?? '') !== '') {
                $query->where('processo.'.$coluna, $filtros[$filtro]);
            }
        }

        if (($filtros['impugnacao'] ?? '') === RcandImpugnacao::SIM) {
            $query->where('processo.impugnacoes', RcandImpugnacao::SIM);
        } elseif (($filtros['impugnacao'] ?? '') === RcandImpugnacao::NAO) {
            $query->where(function (Builder $q): void {
                $q->where('processo.impugnacoes', RcandImpugnacao::NAO)
                    ->orWhere(function (Builder $legado): void {
                        $legado->whereNull('processo.impugnacoes')
                            ->where('processo.st_existe_pje', RcandImpugnacao::SIM);
                    });
            });
        }

        if (($filtros['julgamento'] ?? '') === 'julgado') {
            $query->where('processo.julgados_pje_sn', 'Sim');
        } elseif (($filtros['julgamento'] ?? '') === 'nao_julgado') {
            $query->where('processo.julgados_pje_sn', 'Não');
        }

        $this->aplicarFiltroPartidoProcesso($query, $filtros, 'processo');

        return $query;
    }

    /** @param array<string, string> $filtros */
    private function queryCand(array $filtros): Builder
    {
        $query = DB::table('planeleito.rcand_cand_processos as processo')
            ->select('processo.*')
            ->leftJoinSub($this->subconsultaPartidosProcessos(), 'partidos_rel', function ($join): void {
                $join->on('partidos_rel.cd_eleicao', '=', 'processo.cd_eleicao')
                    ->on(
                        'partidos_rel.nr_processo_sem_formatacao',
                        '=',
                        'processo.nr_processo_sem_formatacao'
                    );
            })
            ->addSelect('partidos_rel.partidos');

        if (($filtros['processo'] ?? '') !== '') {
            $processo = mb_strtoupper($filtros['processo']);
            $processoNumerico = preg_replace('/\D+/', '', $processo);
            $query->where(function (Builder $q) use ($processo, $processoNumerico): void {
                $q->whereRaw('UPPER(processo.nr_processo) LIKE ?', ['%'.$processo.'%']);

                if ($processoNumerico !== '') {
                    $q->orWhereRaw('UPPER(processo.nr_processo_sem_formatacao) LIKE ?', ['%'.$processoNumerico.'%']);
                }
            });
        }

        if (($filtros['tipo'] ?? '') !== '') {
            $query->where('processo.tp_processo', $filtros['tipo']);
        }

        if (($filtros['situacao_cand'] ?? '') !== '') {
            $query->where('processo.ds_situacao_processo', $filtros['situacao_cand']);
        }

        $this->aplicarFiltroPartidoProcesso($query, $filtros, 'processo');

        return $query;
    }

    /** @param array<string, string> $filtros */
    private function queryCandexwebPedidos(array $filtros): Builder
    {
        $query = DB::table('planeleito.rcand_candexweb_pedidos as pedido')
            ->select('pedido.*')
            ->leftJoinSub($this->subconsultaPartidosPedidos(), 'partidos_rel', function ($join): void {
                $join->on('partidos_rel.cd_eleicao', '=', 'pedido.cd_eleicao')
                    ->on('partidos_rel.sq_pedido', '=', 'pedido.sq_pedido');
            })
            ->addSelect('partidos_rel.partidos');

        if (($filtros['processo'] ?? '') !== '') {
            $processo = mb_strtoupper($filtros['processo']);
            $processoNumerico = preg_replace('/\D+/', '', $processo);
            $query->where(function (Builder $q) use ($processo, $processoNumerico): void {
                $q->whereRaw('UPPER(pedido.nr_processo_drap) LIKE ?', ['%'.$processo.'%']);

                if ($processoNumerico !== '') {
                    $q->orWhereRaw('UPPER(REGEXP_REPLACE(pedido.nr_processo_drap, \'[^0-9]\', \'\')) LIKE ?', ['%'.$processoNumerico.'%'])
                        ->orWhereRaw('TO_CHAR(pedido.sq_pedido) LIKE ?', ['%'.$processoNumerico.'%']);
                }
            });
        }

        if (($filtros['partido'] ?? '') !== '') {
            $query->whereExists(function (Builder $exists) use ($filtros): void {
                $exists->selectRaw('1')
                    ->from('planeleito.rcand_cw_pedido_partido as filtro_partido')
                    ->whereColumn('filtro_partido.cd_eleicao', 'pedido.cd_eleicao')
                    ->whereColumn('filtro_partido.sq_pedido', 'pedido.sq_pedido')
                    ->where('filtro_partido.nr_partido', (int) $filtros['partido']);
            });
        }

        return $query;
    }

    /** @param array<string, string> $filtros */
    private function queryCandexwebCandidatos(array $filtros): Builder
    {
        $query = DB::table('planeleito.rcand_candexweb_candidatos as candidato')
            ->select('candidato.*')
            ->leftJoin('planeleito.rcand_partido as partido', function ($join): void {
                $join->on('partido.cd_eleicao', '=', 'candidato.cd_eleicao')
                    ->on('partido.nr_partido', '=', 'candidato.nr_partido');
            })
            ->selectRaw($this->rotuloPartidoSql('partido').' AS partidos');

        if (($filtros['processo'] ?? '') !== '') {
            $processo = mb_strtoupper($filtros['processo']);
            $processoNumerico = preg_replace('/\D+/', '', $processo);
            $query->where(function (Builder $q) use ($processo, $processoNumerico): void {
                $q->whereRaw('UPPER(candidato.nm_candidato) LIKE ?', ['%'.$processo.'%'])
                    ->orWhereRaw('UPPER(candidato.nm_urna) LIKE ?', ['%'.$processo.'%']);

                if ($processoNumerico !== '') {
                    $q->orWhereRaw('TO_CHAR(candidato.nr_candidato) LIKE ?', ['%'.$processoNumerico.'%'])
                        ->orWhereRaw('TO_CHAR(candidato.sq_pedido) LIKE ?', ['%'.$processoNumerico.'%']);
                }
            });
        }

        if (($filtros['partido'] ?? '') !== '') {
            $query->where('candidato.nr_partido', (int) $filtros['partido']);
        }

        return $query;
    }

    /** @param array<string, string> $filtros */
    private function serie(array $filtros, string $aba, string $coluna): array
    {
        return (clone $this->query($filtros, $aba))
            ->select([])
            ->selectRaw("COALESCE(processo.{$coluna}, '-') AS label, COUNT(*) AS total")
            ->groupByRaw("COALESCE(processo.{$coluna}, '-')")
            ->orderBy('label')
            ->get()
            ->map(static fn ($item): array => [
                'label' => (string) $item->label,
                'total' => (int) $item->total,
            ])
            ->all();
    }

    private function valoresDistintos(string $coluna): array
    {
        return DB::table('planeleito.rcand_consolidado_processos as processo')
            ->select('processo.'.$coluna)
            ->whereNotNull('processo.'.$coluna)
            ->distinct()
            ->orderBy('processo.'.$coluna)
            ->pluck('processo.'.$coluna)
            ->map(static fn ($valor): string => (string) $valor)
            ->all();
    }

    /** @return array<int, array{numero:int,rotulo:string}> */
    private function opcoesPartidos(): array
    {
        return DB::table('planeleito.rcand_partido as partido')
            ->where(function (Builder $query): void {
                $query->whereExists(function (Builder $exists): void {
                    $exists->selectRaw('1')
                        ->from('planeleito.rcand_cand_proc_partido as vinculo_cand')
                        ->whereColumn('vinculo_cand.cd_eleicao', 'partido.cd_eleicao')
                        ->whereColumn('vinculo_cand.nr_partido', 'partido.nr_partido');
                })->orWhereExists(function (Builder $exists): void {
                    $exists->selectRaw('1')
                        ->from('planeleito.rcand_cw_pedido_partido as vinculo_pedido')
                        ->whereColumn('vinculo_pedido.cd_eleicao', 'partido.cd_eleicao')
                        ->whereColumn('vinculo_pedido.nr_partido', 'partido.nr_partido');
                })->orWhereExists(function (Builder $exists): void {
                    $exists->selectRaw('1')
                        ->from('planeleito.rcand_candexweb_candidatos as candidato')
                        ->whereColumn('candidato.cd_eleicao', 'partido.cd_eleicao')
                        ->whereColumn('candidato.nr_partido', 'partido.nr_partido');
                });
            })
            ->select('partido.nr_partido')
            ->selectRaw('MAX(partido.sg_partido) AS sg_partido')
            ->selectRaw('MAX(partido.nm_partido) AS nm_partido')
            ->groupBy('partido.nr_partido')
            ->orderBy('partido.nr_partido')
            ->get()
            ->map(static fn ($partido): array => [
                'numero' => (int) $partido->nr_partido,
                'rotulo' => (int) $partido->nr_partido
                    .' - '.trim((string) $partido->sg_partido)
                    .' - '.trim((string) $partido->nm_partido),
            ])
            ->all();
    }

    private function aplicarFiltroPartidoProcesso(Builder $query, array $filtros, string $alias): void
    {
        if (($filtros['partido'] ?? '') === '') {
            return;
        }

        $query->whereExists(function (Builder $exists) use ($filtros, $alias): void {
            $exists->selectRaw('1')
                ->from('planeleito.rcand_cand_proc_partido as filtro_partido')
                ->whereColumn('filtro_partido.cd_eleicao', $alias.'.cd_eleicao')
                ->whereColumn(
                    'filtro_partido.nr_processo_sem_formatacao',
                    $alias.'.nr_processo_sem_formatacao'
                )
                ->where('filtro_partido.nr_partido', (int) $filtros['partido']);
        });
    }

    private function subconsultaPartidosProcessos(): Builder
    {
        return $this->agruparPartidos(
            DB::table('planeleito.rcand_cand_proc_partido as vinculo')
                ->join('planeleito.rcand_partido as partido', function ($join): void {
                    $join->on('partido.cd_eleicao', '=', 'vinculo.cd_eleicao')
                        ->on('partido.nr_partido', '=', 'vinculo.nr_partido');
                })
                ->select([
                    'vinculo.cd_eleicao',
                    'vinculo.nr_processo_sem_formatacao',
                    'vinculo.nr_partido',
                ])
                ->selectRaw($this->rotuloPartidoSql('partido').' AS rotulo_partido'),
            ['cd_eleicao', 'nr_processo_sem_formatacao']
        );
    }

    private function subconsultaPartidosPedidos(): Builder
    {
        return $this->agruparPartidos(
            DB::table('planeleito.rcand_cw_pedido_partido as vinculo')
                ->join('planeleito.rcand_partido as partido', function ($join): void {
                    $join->on('partido.cd_eleicao', '=', 'vinculo.cd_eleicao')
                        ->on('partido.nr_partido', '=', 'vinculo.nr_partido');
                })
                ->select(['vinculo.cd_eleicao', 'vinculo.sq_pedido', 'vinculo.nr_partido'])
                ->selectRaw($this->rotuloPartidoSql('partido').' AS rotulo_partido'),
            ['cd_eleicao', 'sq_pedido']
        );
    }

    /** @param array<int, string> $chaves */
    private function agruparPartidos(Builder $linhas, array $chaves): Builder
    {
        $sqlite = DB::connection()->getDriverName() === 'sqlite';

        if ($sqlite) {
            $linhas->orderBy('vinculo.nr_partido');
        }

        $query = DB::query()->fromSub($linhas, 'partido_ordenado')->select($chaves);
        $agregacao = $sqlite
            ? 'GROUP_CONCAT(rotulo_partido, char(10))'
            : 'LISTAGG(rotulo_partido, CHR(10)) WITHIN GROUP (ORDER BY nr_partido)';

        return $query
            ->selectRaw($agregacao.' AS partidos')
            ->groupBy($chaves);
    }

    private function rotuloPartidoSql(string $alias): string
    {
        $numero = DB::connection()->getDriverName() === 'sqlite'
            ? "CAST({$alias}.nr_partido AS TEXT)"
            : "TO_CHAR({$alias}.nr_partido)";

        return "CASE WHEN {$alias}.nr_partido IS NULL THEN NULL ELSE "
            .$numero
            ." || ' - ' || COALESCE(TRIM({$alias}.sg_partido), '-')"
            ." || ' - ' || COALESCE(TRIM({$alias}.nm_partido), '-') END";
    }

    /** @return array<string, string> */
    private function mapaFiltrosConsolidado(): array
    {
        return [
            'tipo' => 'tipo_registro',
            'divergencia' => 'if_cand_x_pje',
            'integridade' => 'st_divergencia',
            'situacao_cand' => 'cand_situacao_processo',
            'cert_publicacao' => 'cert_publ_sn',
            'informacao' => 'inform_candidato_sn',
            'julgado_pje' => 'julgados_pje_sn',
            'data_primeiro_recurso' => 'data_primeiro_recurso',
            'contrarrazao' => 'contrarrazao',
            'remessa_tre' => 'remessa_tre',
        ];
    }

    private function normalizarAba(string $aba): string
    {
        if ($aba === 'primeiro-grau') {
            return 'segundo-grau';
        }

        return in_array($aba, self::ABAS, true) ? $aba : 'gerencial';
    }
}
```
</APP_REPOSITORIES_RCAND_RCANDREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/SeuVotoImporta/SeuVotoImportaEleitorRepository.php`
## <APP_REPOSITORIES_SEUVOTOIMPORTA_SEUVOTOIMPORTAELEITORREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/SeuVotoImporta/SeuVotoImportaEleitorRepository.php`
- **Namespace Declaração:** `App\Repositories\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaEleitorRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$registro = DB::table('planeleito.eleitor as e')
$registro = DB::table('planeleito.eleitor as e')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarNomePorTituloNascimento(string $titulo, string $dataNascimento): ?string
public function buscarPorTituloNascimento(string $titulo, string $dataNascimento): ?array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\SeuVotoImporta;

use App\Support\LocaisVotacao\LocalVotacaoCatalogo;
use App\Support\Validation\TituloEleitoral;
use Illuminate\Support\Facades\DB;

class SeuVotoImportaEleitorRepository
{
    public function buscarNomePorTituloNascimento(string $titulo, string $dataNascimento): ?string
    {
        $titulo = TituloEleitoral::normalizar($titulo) ?? '';
        $dataNascimento = trim($dataNascimento);
        if ($titulo === '' || $dataNascimento === '') {
            return null;
        }

        $registro = DB::table('planeleito.eleitor as e')
            ->selectRaw('TRIM(e.nom_eleitor) AS nome')
            ->whereRaw('TRIM(e.num_inscricao) = ?', [$titulo])
            ->whereIn('e.cod_sit_eleitor', [0, 9])
            ->whereRaw(<<<'SQL'
CASE
    WHEN REGEXP_LIKE(TO_CHAR(e.dat_nasc), '^[0-9]{8}$')
        THEN SUBSTR(TO_CHAR(e.dat_nasc), 1, 4) || '-' || SUBSTR(TO_CHAR(e.dat_nasc), 5, 2) || '-' || SUBSTR(TO_CHAR(e.dat_nasc), 7, 2)
    ELSE TO_CHAR(e.dat_nasc, 'YYYY-MM-DD')
END = ?
SQL, [$dataNascimento])
            ->first();

        $nome = trim((string) ($registro->nome ?? ''));

        return $nome === '' ? null : $nome;
    }

    public function buscarPorTituloNascimento(string $titulo, string $dataNascimento): ?array
    {
        $titulo = TituloEleitoral::normalizar($titulo) ?? '';
        $dataNascimento = trim($dataNascimento);
        if ($titulo === '' || $dataNascimento === '') {
            return null;
        }

        $registro = DB::table('planeleito.eleitor as e')
            ->join('planeleito.secoes as s', 's.cod_objeto', '=', 'e.cod_objeto_secao')
            ->leftJoin('planeleito.secao_alocacao_provisoria as sap', 'sap.cod_objeto_secao', '=', 's.cod_objeto')
            ->join(LocalVotacaoCatalogo::EFETIVOS.' as lv', function ($join): void {
                $join->whereRaw('TRIM(lv.cod_objeto) = NVL(TRIM(sap.cod_objeto_local_provisorio), TRIM(s.cod_objeto_local))');
            })
            ->selectRaw(<<<'SQL'
TRIM(e.num_inscricao) AS num_inscricao,
TRIM(e.nom_eleitor) AS nome,
CASE
    WHEN REGEXP_LIKE(TO_CHAR(e.dat_nasc), '^[0-9]{8}$')
        THEN SUBSTR(TO_CHAR(e.dat_nasc), 1, 4) || '-' || SUBSTR(TO_CHAR(e.dat_nasc), 5, 2) || '-' || SUBSTR(TO_CHAR(e.dat_nasc), 7, 2)
    ELSE TO_CHAR(e.dat_nasc, 'YYYY-MM-DD')
END AS dt_nascimento,
TO_NUMBER(REGEXP_REPLACE(TRIM(lv.cod_objeto_zona), '[^0-9]', '')) AS zona_numero,
LPAD(TRIM(s.num_secao), 3, '0') AS secao_numero,
TRIM(lv.cod_objeto) AS local_cod_objeto,
TO_NUMBER(REGEXP_REPLACE(TRIM(TO_CHAR(lv.num_local)), '[^0-9]', '')) AS local_numero,
TRIM(lv.nom_local) AS local_nome,
TRIM(lv.des_endereco) AS local_endereco,
TRIM(lv.nom_localidade) AS municipio_nome
SQL)
            ->whereRaw('TRIM(e.num_inscricao) = ?', [$titulo])
            ->whereIn('e.cod_sit_eleitor', [0, 9])
            ->whereRaw(<<<'SQL'
CASE
    WHEN REGEXP_LIKE(TO_CHAR(e.dat_nasc), '^[0-9]{8}$')
        THEN SUBSTR(TO_CHAR(e.dat_nasc), 1, 4) || '-' || SUBSTR(TO_CHAR(e.dat_nasc), 5, 2) || '-' || SUBSTR(TO_CHAR(e.dat_nasc), 7, 2)
    ELSE TO_CHAR(e.dat_nasc, 'YYYY-MM-DD')
END = ?
SQL, [$dataNascimento])
            ->first();

        if ($registro === null || trim((string) ($registro->nome ?? '')) === '') {
            return null;
        }

        return [
            'num_inscricao' => trim((string) $registro->num_inscricao),
            'nome' => trim((string) $registro->nome),
            'dt_nascimento' => trim((string) $registro->dt_nascimento),
            'zona_numero' => (int) $registro->zona_numero,
            'secao_numero' => trim((string) $registro->secao_numero),
            'local_cod_objeto' => trim((string) $registro->local_cod_objeto),
            'local_numero' => isset($registro->local_numero) ? (int) $registro->local_numero : null,
            'local_nome' => trim((string) $registro->local_nome),
            'local_endereco' => trim((string) ($registro->local_endereco ?? '')),
            'municipio_nome' => trim((string) $registro->municipio_nome),
        ];
    }
}
```
</APP_REPOSITORIES_SEUVOTOIMPORTA_SEUVOTOIMPORTAELEITORREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/SeuVotoImporta/SeuVotoImportaSolicitacaoRepository.php`
## <APP_REPOSITORIES_SEUVOTOIMPORTA_SEUVOTOIMPORTASOLICITACAOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/SeuVotoImporta/SeuVotoImportaSolicitacaoRepository.php`
- **Namespace Declaração:** `App\Repositories\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaSolicitacaoRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$registro = DB::table('SVI_CONFIGURACAO')
$registro = DB::table('SVI_CONFIGURACAO')->where('MACROPROJETO_ID', $macroprojetoId)->first();
$registro = DB::table('SVI_SOLICITACAO')
$id = DB::table('SVI_SOLICITACAO')
$resultado[$chave] = DB::table($tabela)->select(['CODIGO', 'DESCRICAO'])
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarConfiguracaoAberta(): ?array
public function buscarConfiguracaoPorMacroprojeto(int $macroprojetoId): ?array
public function buscarPorMacroTitulo(int $macroprojetoId, string $titulo): ?array
public function buscarIdPorProtocolo(string $protocolo): ?int
public function catalogosPublicos(): array
public function criarCompleta(
public function criarAnexo(array $dados): int
public function buscarAcompanhamentoPorId(int $id): ?array
public function listarAdministrativo(array $filtros, EscopoZonal $escopo): LengthAwarePaginator
public function exportarAdministrativo(array $filtros, EscopoZonal $escopo): Collection
public function buscarDetalheAdministrativo(int $id, EscopoZonal $escopo): ?array
public function buscarAnexoAdministrativo(int $solicitacaoId, int $anexoId, EscopoZonal $escopo): ?array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\SeuVotoImporta;

use App\Repositories\Concerns\AuditaDml;
use App\Support\Access\EscopoZonal;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class SeuVotoImportaSolicitacaoRepository
{
    use AuditaDml;

    public function buscarConfiguracaoAberta(): ?array
    {
        $registro = DB::table('SVI_CONFIGURACAO')
            ->where('ATIVO', 1)
            ->whereRaw('SYSDATE BETWEEN DT_ABERTURA AND DT_ENCERRAMENTO')
            ->orderByDesc('ID')
            ->first();

        return $registro === null ? null : $this->mapearConfiguracao($registro);
    }

    public function buscarConfiguracaoPorMacroprojeto(int $macroprojetoId): ?array
    {
        $registro = DB::table('SVI_CONFIGURACAO')->where('MACROPROJETO_ID', $macroprojetoId)->first();

        return $registro === null ? null : $this->mapearConfiguracao($registro);
    }

    public function buscarPorMacroTitulo(int $macroprojetoId, string $titulo): ?array
    {
        $registro = DB::table('SVI_SOLICITACAO')
            ->select(['ID', 'PROTOCOLO'])
            ->where('MACROPROJETO_ID', $macroprojetoId)
            ->where('NUM_INSCRICAO', $titulo)
            ->first();

        return $registro === null ? null : [
            'id' => (int) $registro->id,
            'protocolo' => (string) $registro->protocolo,
        ];
    }

    public function buscarIdPorProtocolo(string $protocolo): ?int
    {
        $id = DB::table('SVI_SOLICITACAO')
            ->where('PROTOCOLO', $protocolo)
            ->value('ID');

        return $id === null ? null : (int) $id;
    }

    /** @return array<string, array<int, array{codigo:string,descricao:string}>> */
    public function catalogosPublicos(): array
    {
        $tabelas = [
            'solicitantes' => 'SVI_SOLICITANTE_TIPO',
            'contatos' => 'SVI_CONTATO_PREFERENCIA',
            'condicoes' => 'SVI_CONDICAO',
            'equipamentos' => 'SVI_EQUIPAMENTO',
        ];
        $resultado = [];
        foreach ($tabelas as $chave => $tabela) {
            $resultado[$chave] = DB::table($tabela)->select(['CODIGO', 'DESCRICAO'])
                ->where('ATIVO', 1)->orderBy('ORDEM')->get()
                ->map(static fn (object $item): array => [
                    'codigo' => (string) $item->codigo,
                    'descricao' => (string) $item->descricao,
                ])->all();
        }

        return $resultado;
    }

    /**
     * @param array<string, mixed> $dados
     * @param array<int, string> $condicoes
     * @param array<int, string> $equipamentos
     * @param array<int, array<string, mixed>> $turnos
     * @param array<int, array<string, mixed>> $anexos
     */
    public function criarCompleta(
        array $dados,
        array $condicoes,
        array $equipamentos,
        array $turnos,
        array $anexos = [],
    ): int
    {
        return DB::transaction(function () use ($dados, $condicoes, $equipamentos, $turnos, $anexos): int {
            $dados['DT_CRIACAO'] = DB::raw('SYSDATE');
            $id = $this->inserirAuditado('SVI_SOLICITACAO', 'SVI_SOLICITACAO', $dados, 'ID');

            $this->inserirLoteAuditado(
                'SVI_SOLICITACAO_CONDICAO',
                'SVI_SOLICITACAO_CONDICAO',
                array_map(static fn (string $codigo): array => [
                    'SOLICITACAO_ID' => $id, 'CONDICAO_CODIGO' => $codigo, 'DT_CRIACAO' => DB::raw('SYSDATE'),
                ], $condicoes),
                $id,
                static fn ($query) => $query->where('SOLICITACAO_ID', $id),
            );
            $this->inserirLoteAuditado(
                'SVI_SOLICITACAO_EQUIP',
                'SVI_SOLICITACAO_EQUIP',
                array_map(static fn (string $codigo): array => [
                    'SOLICITACAO_ID' => $id, 'EQUIPAMENTO_CODIGO' => $codigo, 'DT_CRIACAO' => DB::raw('SYSDATE'),
                ], $equipamentos),
                $id,
                static fn ($query) => $query->where('SOLICITACAO_ID', $id),
            );

            foreach ($turnos as $turno) {
                $this->inserirAuditado('SVI_SOLICITACAO_TURNO', 'SVI_SOLICITACAO_TURNO', [
                    'SOLICITACAO_ID' => $id,
                    'NUMERO_TURNO' => $turno['NUMERO_TURNO'],
                    'STATUS_CODIGO' => $turno['STATUS_CODIGO'],
                    'DATA_VOTACAO' => $turno['DATA_VOTACAO'],
                    'DT_CRIACAO' => DB::raw('SYSDATE'),
                ], 'ID');
            }

            foreach ($anexos as $anexo) {
                $anexo['SOLICITACAO_ID'] = $id;
                $anexo['DT_CRIACAO'] = DB::raw('SYSDATE');
                $this->inserirAuditado('SVI_ANEXO', 'SVI_ANEXO', $anexo, 'ID');
            }

            $this->inserirAuditado('SVI_HISTORICO', 'SVI_HISTORICO', [
                'SOLICITACAO_ID' => $id,
                'TIPO_EVENTO' => 'SOLICITACAO_CRIADA',
                'STATUS_NOVO' => 'RECEBIDA',
                'DT_EVENTO' => DB::raw('SYSDATE'),
            ], 'ID');

            return $id;
        });
    }

    /** @param array<string, mixed> $dados */
    public function criarAnexo(array $dados): int
    {
        $dados['DT_CRIACAO'] = DB::raw('SYSDATE');

        return $this->inserirAuditado('SVI_ANEXO', 'SVI_ANEXO', $dados, 'ID');
    }

    /** @return array<string, mixed>|null */
    public function buscarAcompanhamentoPorId(int $id): ?array
    {
        $registro = DB::table('SVI_SOLICITACAO as s')
            ->leftJoin('SVI_SOLICITACAO_STATUS as st', 'st.CODIGO', '=', 's.STATUS_CODIGO')
            ->selectRaw('s.ID, s.PROTOCOLO, s.NUM_INSCRICAO, s.ELEITOR_TELEFONE,
                s.STATUS_CODIGO, st.DESCRICAO AS STATUS_DESCRICAO, s.MENSAGEM_PUBLICA, s.DT_CRIACAO')
            ->where('s.ID', $id)
            ->first();
        if ($registro === null) {
            return null;
        }

        $turnos = DB::table('SVI_SOLICITACAO_TURNO as t')
            ->join('SVI_TURNO_STATUS as st', 'st.CODIGO', '=', 't.STATUS_CODIGO')
            ->selectRaw('t.NUMERO_TURNO, t.DATA_VOTACAO, t.STATUS_CODIGO, st.DESCRICAO AS STATUS_DESCRICAO,
                t.PONTO_EMBARQUE, t.HORARIO_PREVISTO, t.OBSERVACAO_PUBLICA')
            ->where('t.SOLICITACAO_ID', $id)
            ->orderBy('t.NUMERO_TURNO')
            ->get()->map(static fn (object $turno): array => (array) $turno)->all();

        return [
            'id' => (int) $registro->id,
            'protocolo' => (string) $registro->protocolo,
            'num_inscricao' => (string) $registro->num_inscricao,
            'eleitor_telefone' => (string) $registro->eleitor_telefone,
            'status_codigo' => (string) $registro->status_codigo,
            'status_descricao' => (string) $registro->status_descricao,
            'mensagem_publica' => (string) ($registro->mensagem_publica ?? ''),
            'dt_criacao' => (string) $registro->dt_criacao,
            'turnos' => $turnos,
        ];
    }

    /**
     * @param array<string, mixed> $filtros
     */
    public function listarAdministrativo(array $filtros, EscopoZonal $escopo): LengthAwarePaginator
    {
        return $this->consultaAdministrativa($filtros, $escopo)
            ->orderByDesc('s.DT_CRIACAO')
            ->orderByDesc('s.ID')
            ->paginate(25)
            ->withQueryString();
    }

    /**
     * @param array<string, mixed> $filtros
     * @return Collection<int, \stdClass>
     */
    public function exportarAdministrativo(array $filtros, EscopoZonal $escopo): Collection
    {
        return $this->consultaAdministrativa($filtros, $escopo)
            ->orderBy('s.ZONA_NUMERO')
            ->orderBy('s.ELEITOR_NOME')
            ->get();
    }

    /** @return array<string, mixed>|null */
    public function buscarDetalheAdministrativo(int $id, EscopoZonal $escopo): ?array
    {
        $registro = $this->consultaAdministrativa([], $escopo)
            ->addSelect([
                's.CONFIGURACAO_ID', 's.DT_NASCIMENTO', 's.SECAO_NUMERO', 's.LOCAL_NUMERO',
                's.LOCAL_COD_OBJETO', 's.LOCAL_ENDERECO', 's.SOLICITANTE_TIPO_CODIGO',
                's.SOLICITANTE_NOME', 's.SOLICITANTE_TITULO', 's.SOLICITANTE_TELEFONE',
                's.CONTATO_PREFERENCIA_CODIGO', 's.ENDERECO_LOGRADOURO', 's.ENDERECO_NUMERO',
                's.ENDERECO_BAIRRO', 's.ENDERECO_MUNICIPIO', 's.ENDERECO_REFERENCIA',
                's.VEICULO_ACESSA_CODIGO', 's.ENDERECO_ALTERNATIVO', 's.CONDICAO_DESCRICAO',
                's.END_ALT_LOGRADOURO', 's.END_ALT_NUMERO', 's.END_ALT_BAIRRO', 's.END_ALT_REFERENCIA',
                's.COMPROVACAO_TIPO_CODIGO', 's.AUTODECLARACAO_TEXTO',
                's.IMPACTO_CODIGO', 's.IMPACTO_DESCRICAO', 's.EQUIPAMENTO_OUTRO',
                's.TRANSPORTE_PUBLICO_CODIGO', 's.ACOMPANHANTE_CODIGO', 's.ACOMPANHANTE_NOME',
                's.ACOMPANHANTE_TELEFONE', 's.SEGUNDO_TURNO_CODIGO', 's.OBSERVACOES',
            ])
            ->where('s.ID', $id)
            ->first();

        if ($registro === null) {
            return null;
        }

        return [
            'solicitacao' => (array) $registro,
            'condicoes' => DB::table('SVI_SOLICITACAO_CONDICAO as sc')
                ->join('SVI_CONDICAO as c', 'c.CODIGO', '=', 'sc.CONDICAO_CODIGO')
                ->select(['sc.CONDICAO_CODIGO', 'c.DESCRICAO'])->where('sc.SOLICITACAO_ID', $id)
                ->orderBy('c.ORDEM')->get(),
            'equipamentos' => DB::table('SVI_SOLICITACAO_EQUIP as se')
                ->join('SVI_EQUIPAMENTO as e', 'e.CODIGO', '=', 'se.EQUIPAMENTO_CODIGO')
                ->select(['se.EQUIPAMENTO_CODIGO', 'e.DESCRICAO'])->where('se.SOLICITACAO_ID', $id)
                ->orderBy('e.ORDEM')->get(),
            'turnos' => DB::table('SVI_SOLICITACAO_TURNO as t')
                ->join('SVI_TURNO_STATUS as st', 'st.CODIGO', '=', 't.STATUS_CODIGO')
                ->selectRaw("t.ID, t.NUMERO_TURNO, t.STATUS_CODIGO, st.DESCRICAO AS STATUS_DESCRICAO,
                    TO_CHAR(t.DATA_VOTACAO, 'YYYY-MM-DD') AS DATA_VOTACAO, t.PONTO_EMBARQUE,
                    TO_CHAR(t.HORARIO_PREVISTO, 'HH24:MI') AS HORARIO_PREVISTO, t.OBSERVACAO_PUBLICA")
                ->where('t.SOLICITACAO_ID', $id)->orderBy('t.NUMERO_TURNO')->get(),
            'anexos' => DB::table('SVI_ANEXO')->select([
                'ID', 'CATEGORIA', 'NOME_ORIGINAL', 'MIME', 'TAMANHO_BYTES', 'SHA256', 'SCAN_STATUS', 'SCANEADO_EM',
            ])->where('SOLICITACAO_ID', $id)->orderBy('CATEGORIA')->get(),
            'historico' => DB::table('SVI_HISTORICO')->where('SOLICITACAO_ID', $id)
                ->orderByDesc('DT_EVENTO')->orderByDesc('ID')->get(),
        ];
    }

    /** @return array<string, mixed>|null */
    public function buscarAnexoAdministrativo(int $solicitacaoId, int $anexoId, EscopoZonal $escopo): ?array
    {
        $query = DB::table('SVI_ANEXO as a')
            ->join('SVI_SOLICITACAO as s', 's.ID', '=', 'a.SOLICITACAO_ID')
            ->selectRaw('a.ID, a.SOLICITACAO_ID, a.DISCO, a.CAMINHO, a.NOME_ORIGINAL, a.MIME,
                a.TAMANHO_BYTES, a.SCAN_STATUS')
            ->where('a.ID', $anexoId)
            ->where('a.SOLICITACAO_ID', $solicitacaoId);
        $this->aplicarEscopoZonal($query, $escopo);
        $registro = $query->first();

        return $registro === null ? null : (array) $registro;
    }

    public function alterarStatus(
        int $id,
        string $statusEsperado,
        string $novoStatus,
        ?string $mensagemPublica,
        string $usuario,
        EscopoZonal $escopo,
    ): bool {
        return DB::transaction(function () use ($id, $statusEsperado, $novoStatus, $mensagemPublica, $usuario, $escopo): bool {
            $registro = $this->consultaAdministrativa([], $escopo)->where('s.ID', $id)->lockForUpdate()->first();
            if ($registro === null || (string) $registro->status_codigo !== $statusEsperado) {
                return false;
            }

            $this->atualizarAuditadoPorId('SVI_SOLICITACAO', 'SVI_SOLICITACAO', 'ID', $id, [
                'STATUS_CODIGO' => $novoStatus,
                'MENSAGEM_PUBLICA' => $mensagemPublica,
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
                'VERSAO' => DB::raw('VERSAO + 1'),
            ]);
            $this->inserirAuditado('SVI_HISTORICO', 'SVI_HISTORICO', [
                'SOLICITACAO_ID' => $id,
                'TIPO_EVENTO' => $statusEsperado === $novoStatus ? 'MENSAGEM_PUBLICA_ATUALIZADA' : 'STATUS_ALTERADO',
                'STATUS_ANTERIOR' => $statusEsperado,
                'STATUS_NOVO' => $novoStatus,
                'MENSAGEM_PUBLICA' => $mensagemPublica,
                'USUARIO' => $usuario,
                'DT_EVENTO' => DB::raw('SYSDATE'),
            ], 'ID');

            return true;
        });
    }

    /** @param array<string, mixed> $dados */
    public function atualizarTurno(
        int $solicitacaoId,
        int $numeroTurno,
        string $statusEsperado,
        array $dados,
        string $usuario,
        EscopoZonal $escopo,
    ): bool {
        return DB::transaction(function () use ($solicitacaoId, $numeroTurno, $statusEsperado, $dados, $usuario, $escopo): bool {
            if ($this->consultaAdministrativa([], $escopo)->where('s.ID', $solicitacaoId)->lockForUpdate()->first() === null) {
                return false;
            }
            $turno = DB::table('SVI_SOLICITACAO_TURNO')->where('SOLICITACAO_ID', $solicitacaoId)
                ->where('NUMERO_TURNO', $numeroTurno)->lockForUpdate()->first();
            if ($turno === null || (string) $turno->status_codigo !== $statusEsperado) {
                return false;
            }

            $turnoId = (int) $turno->id;
            $this->atualizarAuditadoPorId('SVI_SOLICITACAO_TURNO', 'SVI_SOLICITACAO_TURNO', 'ID', $turnoId, [
                'STATUS_CODIGO' => $dados['STATUS_CODIGO'],
                'DATA_VOTACAO' => $dados['DATA_VOTACAO'],
                'PONTO_EMBARQUE' => $dados['PONTO_EMBARQUE'],
                'HORARIO_PREVISTO' => $dados['HORARIO_PREVISTO'],
                'OBSERVACAO_PUBLICA' => $dados['OBSERVACAO_PUBLICA'],
                'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
            ]);
            $this->inserirAuditado('SVI_HISTORICO', 'SVI_HISTORICO', [
                'SOLICITACAO_ID' => $solicitacaoId,
                'TURNO_ID' => $turnoId,
                'TIPO_EVENTO' => 'LOGISTICA_TURNO_ALTERADA',
                'STATUS_ANTERIOR' => $statusEsperado,
                'STATUS_NOVO' => $dados['STATUS_CODIGO'],
                'MENSAGEM_PUBLICA' => $dados['OBSERVACAO_PUBLICA'],
                'USUARIO' => $usuario,
                'DT_EVENTO' => DB::raw('SYSDATE'),
            ], 'ID');

            return true;
        });
    }

    /** @param array<string, mixed> $dados */
    public function salvarConfiguracao(array $dados, string $usuario): int
    {
        return DB::transaction(function () use ($dados, $usuario): int {
            $macroprojetoId = (int) $dados['MACROPROJETO_ID'];
            $existente = DB::table('SVI_CONFIGURACAO')->where('MACROPROJETO_ID', $macroprojetoId)
                ->lockForUpdate()->first();
            if ($existente === null) {
                $dados['DT_CRIACAO'] = DB::raw('SYSDATE');
                $id = $this->inserirAuditado('SVI_CONFIGURACAO', 'SVI_CONFIGURACAO', $dados, 'ID');
            } else {
                $id = (int) $existente->id;
                $dados['DT_ATUALIZACAO'] = DB::raw('SYSDATE');
                $this->atualizarAuditadoPorId('SVI_CONFIGURACAO', 'SVI_CONFIGURACAO', 'ID', $id, $dados);
            }

            if ((int) $dados['SEGUNDO_TURNO_CONFIRMADO'] === 1 && $dados['DT_SEGUNDO_TURNO'] !== null) {
                $this->criarSegundosTurnosConfirmados($macroprojetoId, $dados['DT_SEGUNDO_TURNO'], $usuario);
            }

            return $id;
        });
    }

    /** @return array<string, string> */
    public function statusSolicitacao(): array
    {
        return $this->catalogoStatusAtivo('SVI_SOLICITACAO_STATUS');
    }

    public function registrarEventoAdministrativo(
        int $solicitacaoId,
        string $tipoEvento,
        string $usuario,
        EscopoZonal $escopo,
    ): bool {
        if ($this->consultaAdministrativa([], $escopo)->where('s.ID', $solicitacaoId)->first() === null) {
            return false;
        }

        $this->inserirAuditado('SVI_HISTORICO', 'SVI_HISTORICO', [
            'SOLICITACAO_ID' => $solicitacaoId,
            'TIPO_EVENTO' => mb_substr(mb_strtoupper($tipoEvento, 'UTF-8'), 0, 60, 'UTF-8'),
            'USUARIO' => $usuario,
            'DT_EVENTO' => DB::raw('SYSDATE'),
        ], 'ID');

        return true;
    }

    /** @return array<string, string> */
    public function statusTurno(): array
    {
        return $this->catalogoStatusAtivo('SVI_TURNO_STATUS');
    }

    /** @return array<string, string> */
    private function catalogoStatusAtivo(string $tabela): array
    {
        return DB::table($tabela)
            ->select(['CODIGO', 'DESCRICAO'])
            ->where('ATIVO', 1)
            ->orderBy('ORDEM')
            ->get()
            ->mapWithKeys(static fn (object $item): array => [
                (string) $item->codigo => (string) $item->descricao,
            ])->all();
    }

    /**
     * @param array<string, mixed> $filtros
     */
    private function consultaAdministrativa(array $filtros, EscopoZonal $escopo): Builder
    {
        $query = DB::table('SVI_SOLICITACAO as s')
            ->join('SVI_SOLICITACAO_STATUS as st', 'st.CODIGO', '=', 's.STATUS_CODIGO')
            ->selectRaw('s.ID, s.PROTOCOLO, s.MACROPROJETO_ID, s.NUM_INSCRICAO, s.ELEITOR_NOME,
                s.IDADE, s.ZONA_NUMERO, s.LOCAL_NOME, s.MUNICIPIO_NOME, s.ELEITOR_EMAIL,
                s.ELEITOR_TELEFONE, s.STATUS_CODIGO, st.DESCRICAO AS STATUS_DESCRICAO,
                s.MENSAGEM_PUBLICA, s.DT_CRIACAO');

        $this->aplicarEscopoZonal($query, $escopo);
        $macroprojetoId = (int) ($filtros['macroprojeto_id'] ?? 0);
        if ($macroprojetoId > 0) {
            $query->where('s.MACROPROJETO_ID', $macroprojetoId);
        }
        $protocolo = mb_strtoupper(trim((string) ($filtros['protocolo'] ?? '')), 'UTF-8');
        if ($protocolo !== '') {
            $query->whereRaw('UPPER(s.PROTOCOLO) LIKE ?', ['%'.$protocolo.'%']);
        }
        $status = mb_strtoupper(trim((string) ($filtros['status'] ?? '')), 'UTF-8');
        if ($status !== '') {
            $query->where('s.STATUS_CODIGO', $status);
        }
        $zona = (int) ($filtros['zona'] ?? 0);
        if ($zona > 0) {
            $query->where('s.ZONA_NUMERO', $zona);
        }
        $municipio = mb_strtoupper(trim((string) ($filtros['municipio'] ?? '')), 'UTF-8');
        if ($municipio !== '') {
            $query->whereRaw('UPPER(s.MUNICIPIO_NOME) LIKE ?', ['%'.$municipio.'%']);
        }
        $inicio = trim((string) ($filtros['data_inicio'] ?? ''));
        if ($inicio !== '') {
            $query->whereRaw("TRUNC(s.DT_CRIACAO) >= TO_DATE(?, 'YYYY-MM-DD')", [$inicio]);
        }
        $fim = trim((string) ($filtros['data_fim'] ?? ''));
        if ($fim !== '') {
            $query->whereRaw("TRUNC(s.DT_CRIACAO) <= TO_DATE(?, 'YYYY-MM-DD')", [$fim]);
        }

        return $query;
    }

    private function aplicarEscopoZonal(Builder $query, EscopoZonal $escopo): void
    {
        if ($escopo->acessoTodas()) {
            return;
        }
        if ($escopo->semAcesso()) {
            $query->whereRaw('1 = 0');
            return;
        }
        $query->whereIn('s.ZONA_NUMERO', $escopo->zonas());
    }

    private function criarSegundosTurnosConfirmados(int $macroprojetoId, mixed $dataSegundoTurno, string $usuario): void
    {
        $solicitacoes = DB::table('SVI_SOLICITACAO as s')
            ->where('s.MACROPROJETO_ID', $macroprojetoId)
            ->where('s.SEGUNDO_TURNO_CODIGO', 'SIM')
            ->whereNotExists(static function (Builder $query): void {
                $query->selectRaw('1')->from('SVI_SOLICITACAO_TURNO as t')
                    ->whereColumn('t.SOLICITACAO_ID', 's.ID')->where('t.NUMERO_TURNO', 2);
            })->pluck('s.ID');

        foreach ($solicitacoes as $solicitacaoId) {
            $turnoId = $this->inserirAuditado('SVI_SOLICITACAO_TURNO', 'SVI_SOLICITACAO_TURNO', [
                'SOLICITACAO_ID' => (int) $solicitacaoId,
                'NUMERO_TURNO' => 2,
                'STATUS_CODIGO' => 'AGUARDANDO_AGENDAMENTO',
                'DATA_VOTACAO' => $dataSegundoTurno,
                'DT_CRIACAO' => DB::raw('SYSDATE'),
            ], 'ID');
            $this->inserirAuditado('SVI_HISTORICO', 'SVI_HISTORICO', [
                'SOLICITACAO_ID' => (int) $solicitacaoId,
                'TURNO_ID' => $turnoId,
                'TIPO_EVENTO' => 'SEGUNDO_TURNO_CONFIRMADO',
                'STATUS_NOVO' => 'AGUARDANDO_AGENDAMENTO',
                'USUARIO' => $usuario,
                'DT_EVENTO' => DB::raw('SYSDATE'),
            ], 'ID');
        }
    }

    /** @return array<string, mixed> */
    private function mapearConfiguracao(object $registro): array
    {
        return [
            'id' => (int) $registro->id,
            'macroprojeto_id' => (int) $registro->macroprojeto_id,
            'dt_abertura' => (string) $registro->dt_abertura,
            'dt_encerramento' => (string) $registro->dt_encerramento,
            'dt_primeiro_turno' => (string) $registro->dt_primeiro_turno,
            'dt_segundo_turno' => isset($registro->dt_segundo_turno) ? (string) $registro->dt_segundo_turno : null,
            'segundo_turno_confirmado' => (int) $registro->segundo_turno_confirmado === 1,
            'aviso_privacidade' => (string) $registro->aviso_privacidade,
            'ativo' => (int) $registro->ativo === 1,
        ];
    }
}
```
</APP_REPOSITORIES_SEUVOTOIMPORTA_SEUVOTOIMPORTASOLICITACAOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/EnergiaRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_ENERGIAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/EnergiaRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class EnergiaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('ENERGIA')
return DB::table('ENERGIA')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar()
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Support\Facades\DB;

class EnergiaRepository
{
    use AuditaDml;

    public function listar()
    {
        return DB::table('ENERGIA')
            ->selectRaw('ID AS id, DESCRICAO AS descricao, IDHTML AS idhtml')
            ->orderBy('ID')
            ->get();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('ENERGIA')
            ->selectRaw('ID AS id, DESCRICAO AS descricao, IDHTML AS idhtml')
            ->where('ID', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado('ENERGIA', 'ENERGIA', [
            'DESCRICAO' => $dados['descricao'],
            'IDHTML' => $dados['idhtml'],
        ]);
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('ENERGIA', 'ENERGIA', 'ID', $id, [
            'DESCRICAO' => $dados['descricao'],
            'IDHTML' => $dados['idhtml'],
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('ENERGIA', 'ENERGIA', 'ID', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_ENERGIAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/EsferaRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_ESFERAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/EsferaRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class EsferaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('esfera')
return DB::table('esfera')
return DB::table('esfera')
return DB::table('esfera')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
public function ativasOrdenadas(): array
public function codigosAtivos(): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class EsferaRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('esfera')
            ->selectRaw("
                id,
                codigo,
                descricao,
                ordem,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('descricao');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Fonte central das esferas ativas, ordenadas para renderização.
     *
     * @return array<int, object>
     */
    public function ativasOrdenadas(): array
    {
        return DB::table('esfera')
            ->select('id', 'codigo', 'descricao', 'ordem')
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get()
            ->all();
    }

    /**
     * Lista de códigos válidos para validação convergente.
     *
     * @return array<int, string>
     */
    public function codigosAtivos(): array
    {
        return DB::table('esfera')
            ->orderBy('ordem')
            ->pluck('codigo')
            ->map(static fn ($codigo) => (string) $codigo)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('esfera')
            ->where('id', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'esfera',
            'ESFERA',
            [
                'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
                'descricao' => trim((string) $dados['descricao']),
                'ordem' => (int) $dados['ordem'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            'id'
        );
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('esfera', 'ESFERA', 'id', $id, [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('esfera', 'ESFERA', 'id', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_ESFERAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/InternetRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_INTERNETREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/InternetRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class InternetRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('INTERNET')
return DB::table('INTERNET')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar()
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Support\Facades\DB;

class InternetRepository
{
    use AuditaDml;

    public function listar()
    {
        return DB::table('INTERNET')
            ->selectRaw('ID AS id, DESCRICAO AS descricao')
            ->orderBy('ID')
            ->get();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('INTERNET')
            ->selectRaw('ID AS id, DESCRICAO AS descricao')
            ->where('ID', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado('INTERNET', 'INTERNET', [
            'DESCRICAO' => $dados['descricao'],
        ]);
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('INTERNET', 'INTERNET', 'ID', $id, [
            'DESCRICAO' => $dados['descricao'],
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('INTERNET', 'INTERNET', 'ID', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_INTERNETREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/MunicipioRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_MUNICIPIOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/MunicipioRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class MunicipioRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('MUNICIPIO as m')
return DB::table('MUNICIPIO')
return DB::table('MUNICIPIO as m')
return DB::table('MUNICIPIO')
$query = DB::table('MUNICIPIO')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, ?int $zonaId = null): LengthAwarePaginator
public function todas(): Collection
public function listarComZona(): Collection
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
public function porZona(?int $zonaId = null): Collection
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class MunicipioRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, ?int $zonaId = null): LengthAwarePaginator
    {
        $query = DB::table('MUNICIPIO as m')
            ->leftJoin('ZONA as z', 'z.id', '=', 'm.zonaid')
            ->selectRaw('m.id, m.localidade, m.cod_objeto_localidade, m.zonaid, z.num_zona, z.descricao as zona_descricao')
            ->orderBy('z.num_zona')
            ->orderBy('m.localidade');

        if ($busca) {
            $busca = trim($busca);
            $query->where(function ($q) use ($busca) {
                $like = '%' . strtoupper($busca) . '%';
                $q->whereRaw('UPPER(m.localidade) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(m.cod_objeto_localidade) LIKE ?', [$like]);
            });
        }

        if ($zonaId) {
            $query->where('m.zonaid', $zonaId);
        }

        return $query->paginate(10)->withQueryString();
    }

    public function todas(): Collection
    {
        return DB::table('MUNICIPIO')
            ->selectRaw('ID as id, ZONAID as zona_id, LOCALIDADE as localidade, COD_OBJETO_LOCALIDADE as cod_objeto_localidade')
            ->get();
    }

    public function listarComZona(): Collection
    {
        return DB::table('MUNICIPIO as m')
            ->join('ZONA as z', 'm.zonaid', '=', 'z.id')
            ->selectRaw('m.id, m.zonaid as zona_id, z.num_zona, z.descricao as zona_descricao, m.localidade, m.cod_objeto_localidade')
            ->orderBy('z.num_zona')
            ->orderBy('m.localidade')
            ->get();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('MUNICIPIO')
            ->selectRaw('ID as id, ZONAID as zona_id, LOCALIDADE as localidade, COD_OBJETO_LOCALIDADE as cod_objeto_localidade')
            ->where('ID', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado('MUNICIPIO', 'MUNICIPIO', [
            'ZONAID' => $dados['zona_id'],
            'LOCALIDADE' => $dados['localidade'],
            'COD_OBJETO_LOCALIDADE' => $dados['cod_objeto_localidade'],
        ]);
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('MUNICIPIO', 'MUNICIPIO', 'ID', $id, [
            'ZONAID' => $dados['zona_id'],
            'LOCALIDADE' => $dados['localidade'],
            'COD_OBJETO_LOCALIDADE' => $dados['cod_objeto_localidade'],
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('MUNICIPIO', 'MUNICIPIO', 'ID', $id);
    }

    public function porZona(?int $zonaId = null): Collection
    {
        $query = DB::table('MUNICIPIO')
            ->selectRaw('ID as id, ZONAID as zona_id, LOCALIDADE as localidade, COD_OBJETO_LOCALIDADE as cod_objeto_localidade')
            ->orderBy('LOCALIDADE');

        if ($zonaId) {
            $query->where('ZONAID', $zonaId);
        }

        return $query->get();
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_MUNICIPIOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/OpcaoBinariaRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_OPCAOBINARIAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/OpcaoBinariaRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class OpcaoBinariaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('opcao_binaria')
return DB::table('opcao_binaria')
return DB::table('opcao_binaria')
return DB::table('opcao_binaria')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
public function ativasOrdenadas(): array
public function codigosAtivos(): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class OpcaoBinariaRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('opcao_binaria')
            ->selectRaw("
                id,
                codigo,
                descricao,
                ordem,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('descricao');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Fonte central das opcoes binarias ativas, ordenadas para renderizacao.
     *
     * @return array<int, object>
     */
    public function ativasOrdenadas(): array
    {
        return DB::table('opcao_binaria')
            ->select('id', 'codigo', 'descricao', 'ordem')
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get()
            ->all();
    }

    /**
     * Lista de codigos validos para validacao convergente.
     *
     * @return array<int, string>
     */
    public function codigosAtivos(): array
    {
        return DB::table('opcao_binaria')
            ->orderBy('ordem')
            ->pluck('codigo')
            ->map(static fn ($codigo) => (string) $codigo)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('opcao_binaria')
            ->where('id', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'opcao_binaria',
            'OPCAO_BINARIA',
            [
                'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
                'descricao' => trim((string) $dados['descricao']),
                'ordem' => (int) $dados['ordem'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            'id'
        );
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('opcao_binaria', 'OPCAO_BINARIA', 'id', $id, [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('opcao_binaria', 'OPCAO_BINARIA', 'id', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_OPCAOBINARIAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/OperadoraRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_OPERADORAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/OperadoraRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class OperadoraRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('operadora')
return DB::table('operadora')
return DB::table('operadora')
return DB::table('operadora')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
public function ativasOrdenadas(): array
public function codigosAtivos(): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class OperadoraRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('operadora')
            ->selectRaw("
                id,
                codigo,
                descricao,
                ordem,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('descricao');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Fonte central das operadoras ativas, ordenadas para renderizacao.
     *
     * @return array<int, object>
     */
    public function ativasOrdenadas(): array
    {
        return DB::table('operadora')
            ->select('id', 'codigo', 'descricao', 'ordem')
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get()
            ->all();
    }

    /**
     * Lista de codigos validos para validacao convergente.
     *
     * @return array<int, string>
     */
    public function codigosAtivos(): array
    {
        return DB::table('operadora')
            ->orderBy('ordem')
            ->pluck('codigo')
            ->map(static fn ($codigo) => (string) $codigo)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('operadora')
            ->where('id', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'operadora',
            'OPERADORA',
            [
                'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
                'descricao' => trim((string) $dados['descricao']),
                'ordem' => (int) $dados['ordem'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            'id'
        );
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('operadora', 'OPERADORA', 'id', $id, [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('operadora', 'OPERADORA', 'id', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_OPERADORAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/QualidadeRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_QUALIDADEREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/QualidadeRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class QualidadeRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('qualidade')
return DB::table('qualidade')
return DB::table('qualidade')
return DB::table('qualidade')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
public function ativasOrdenadas(): array
public function codigosAtivos(): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class QualidadeRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('qualidade')
            ->selectRaw("
                id,
                codigo,
                descricao,
                ordem,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('descricao');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Fonte central das opcoes de qualidade ativas, ordenadas para renderizacao.
     *
     * @return array<int, object>
     */
    public function ativasOrdenadas(): array
    {
        return DB::table('qualidade')
            ->select('id', 'codigo', 'descricao', 'ordem')
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get()
            ->all();
    }

    /**
     * Lista de codigos validos para validacao convergente.
     *
     * @return array<int, string>
     */
    public function codigosAtivos(): array
    {
        return DB::table('qualidade')
            ->orderBy('ordem')
            ->pluck('codigo')
            ->map(static fn ($codigo) => (string) $codigo)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('qualidade')
            ->where('id', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'qualidade',
            'QUALIDADE',
            [
                'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
                'descricao' => trim((string) $dados['descricao']),
                'ordem' => (int) $dados['ordem'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            'id'
        );
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('qualidade', 'QUALIDADE', 'id', $id, [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('qualidade', 'QUALIDADE', 'id', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_QUALIDADEREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/TipoSinalRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_TIPOSINALREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/TipoSinalRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class TipoSinalRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('tipo_sinal')
return DB::table('tipo_sinal')
return DB::table('tipo_sinal')
return DB::table('tipo_sinal')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
public function ativasOrdenadas(): array
public function codigosAtivos(): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class TipoSinalRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('tipo_sinal')
            ->selectRaw("
                id,
                codigo,
                descricao,
                ordem,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('descricao');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Fonte central dos tipos de sinal ativos, ordenados para renderizacao.
     *
     * @return array<int, object>
     */
    public function ativasOrdenadas(): array
    {
        return DB::table('tipo_sinal')
            ->select('id', 'codigo', 'descricao', 'ordem')
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get()
            ->all();
    }

    /**
     * Lista de codigos validos para validacao convergente.
     *
     * @return array<int, string>
     */
    public function codigosAtivos(): array
    {
        return DB::table('tipo_sinal')
            ->orderBy('ordem')
            ->pluck('codigo')
            ->map(static fn ($codigo) => (string) $codigo)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('tipo_sinal')
            ->where('id', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'tipo_sinal',
            'TIPO_SINAL',
            [
                'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
                'descricao' => trim((string) $dados['descricao']),
                'ordem' => (int) $dados['ordem'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            'id'
        );
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('tipo_sinal', 'TIPO_SINAL', 'id', $id, [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('tipo_sinal', 'TIPO_SINAL', 'id', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_TIPOSINALREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/TipoTomadaRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_TIPOTOMADAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/TipoTomadaRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class TipoTomadaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('tipo_tomada')
return DB::table('tipo_tomada')
return DB::table('tipo_tomada')
return DB::table('tipo_tomada')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
public function ativasOrdenadas(): array
public function codigosAtivos(): array
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class TipoTomadaRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('tipo_tomada')
            ->selectRaw("
                id,
                codigo,
                descricao,
                ordem,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('descricao');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(codigo) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(descricao) LIKE ?', [$like]);
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Fonte central dos tipos de tomadas ativas, ordenadas para renderização.
     *
     * @return array<int, object>
     */
    public function ativasOrdenadas(): array
    {
        return DB::table('tipo_tomada')
            ->select('id', 'codigo', 'descricao', 'ordem')
            ->orderBy('ordem')
            ->orderBy('descricao')
            ->get()
            ->all();
    }

    /**
     * Lista de códigos válidos para validação convergente.
     *
     * @return array<int, string>
     */
    public function codigosAtivos(): array
    {
        return DB::table('tipo_tomada')
            ->orderBy('ordem')
            ->pluck('codigo')
            ->map(static fn ($codigo) => (string) $codigo)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('tipo_tomada')
            ->where('id', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'tipo_tomada',
            'TIPO_TOMADA',
            [
                'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
                'descricao' => trim((string) $dados['descricao']),
                'ordem' => (int) $dados['ordem'],
                'dt_criacao' => DB::raw('SYSDATE'),
            ],
            'id'
        );
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('tipo_tomada', 'TIPO_TOMADA', 'id', $id, [
            'codigo' => mb_strtoupper(trim((string) $dados['codigo']), 'UTF-8'),
            'descricao' => trim((string) $dados['descricao']),
            'ordem' => (int) $dados['ordem'],
            'dt_atualizacao' => DB::raw('SYSDATE'),
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('tipo_tomada', 'TIPO_TOMADA', 'id', $id);
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_TIPOTOMADAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/TabelasAuxiliares/ZonaRepository.php`
## <APP_REPOSITORIES_TABELASAUXILIARES_ZONAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/TabelasAuxiliares/ZonaRepository.php`
- **Namespace Declaração:** `App\Repositories\TabelasAuxiliares`
- **Entidade / Classe:** `class ZonaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('ZONA')
return DB::table('ZONA')
$query = DB::table('ZONA')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(): Collection
public function buscar(int $id): ?object
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function remover(int $id): int
public function buscarPorNumero(?int $numero = null): Collection
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\TabelasAuxiliares;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class ZonaRepository
{
    use AuditaDml;

    public function listar(): Collection
    {
        return DB::table('ZONA')
            ->selectRaw('ID as id, NUM_ZONA as num_zona, DESCRICAO as descricao')
            ->orderBy('NUM_ZONA')
            ->get();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('ZONA')
            ->selectRaw('ID as id, NUM_ZONA as num_zona, DESCRICAO as descricao')
            ->where('ID', $id)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado('ZONA', 'ZONA', [
            'NUM_ZONA' => $dados['num_zona'],
            'DESCRICAO' => $dados['descricao'],
        ]);
    }

    public function atualizar(int $id, array $dados): int
    {
        return $this->atualizarAuditadoPorId('ZONA', 'ZONA', 'ID', $id, [
            'NUM_ZONA' => $dados['num_zona'],
            'DESCRICAO' => $dados['descricao'],
        ]);
    }

    public function remover(int $id): int
    {
        return $this->removerAuditadoPorId('ZONA', 'ZONA', 'ID', $id);
    }

    public function buscarPorNumero(?int $numero = null): Collection
    {
        $query = DB::table('ZONA')
            ->selectRaw('ID as id, NUM_ZONA as num_zona, DESCRICAO as descricao')
            ->orderBy('NUM_ZONA');

        if ($numero) {
            $query->where('NUM_ZONA', $numero);
        }

        return $query->get();
    }
}
```
</APP_REPOSITORIES_TABELASAUXILIARES_ZONAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/ColaboradoresEleitorais/EventoVoluntarioPublicoService.php`
## <APP_SERVICES_COLABORADORESELEITORAIS_EVENTOVOLUNTARIOPUBLICOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/ColaboradoresEleitorais/EventoVoluntarioPublicoService.php`
- **Namespace Declaração:** `App\Services\ColaboradoresEleitorais`
- **Entidade / Classe:** `class EventoVoluntarioPublicoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function consultar(mixed $numInscricao): array
private function normalizarOcorrencias(array $ocorrencias): array
private function dataHora(string $valor): ?DateTimeImmutable
private function formatarPeriodo(DateTimeImmutable $inicio, DateTimeImmutable $fim): string
private function textoPublico(mixed $valor, string $padrao = '—'): string
private function textoOpcional(mixed $valor): ?string
private function anonimizarNome(mixed $valor): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\ColaboradoresEleitorais;

use App\Repositories\ColaboradoresEleitorais\Contracts\EventoVoluntarioRepositoryInterface;
use App\Repositories\Treinamentos\Contracts\TreinamentoTsePublicoRepositoryInterface;
use App\Support\Validation\TituloEleitoral;
use DateTimeImmutable;

class EventoVoluntarioPublicoService
{
    /** @var array<int, string> */
    private const MESES = [
        1 => 'JAN',
        2 => 'FEV',
        3 => 'MAR',
        4 => 'ABR',
        5 => 'MAI',
        6 => 'JUN',
        7 => 'JUL',
        8 => 'AGO',
        9 => 'SET',
        10 => 'OUT',
        11 => 'NOV',
        12 => 'DEZ',
    ];

    public function __construct(
        private readonly EventoVoluntarioRepositoryInterface $repository,
        private readonly TreinamentoTsePublicoRepositoryInterface $treinamentosRepository
    ) {}

    /**
     * @return array{
     *     nome_anonimizado:?string,
     *     ocorrencias:array<int, array{
     *         macroprojeto:string,
     *         acao:string,
     *         evento:string,
     *         local:string,
     *         modalidade:?string,
     *         endereco:?string,
     *         sala:?string,
     *         inicio_iso:string,
     *         fim_iso:string,
     *         dia:string,
     *         mes:string,
     *         ano:string,
     *         periodo:string
     *     }>
     * }
     */
    public function consultar(mixed $numInscricao): array
    {
        $titulo = TituloEleitoral::normalizar($numInscricao);
        if ($titulo === null) {
            return ['nome_anonimizado' => null, 'ocorrencias' => []];
        }

        $eventos = $this->normalizarOcorrencias(
            $this->repository->listarOcorrenciasPublicasPorTitulo($titulo)
        );
        $treinamentos = $this->normalizarOcorrencias(
            $this->treinamentosRepository->listarOcorrenciasPublicasPorTitulo($titulo)
        );
        $cards = [...$eventos['cards'], ...$treinamentos['cards']];

        usort(
            $cards,
            static fn (array $primeiro, array $segundo): int => [
                $primeiro['inicio_iso'],
                $primeiro['fim_iso'],
                $primeiro['acao'],
                $primeiro['evento'],
            ] <=> [
                $segundo['inicio_iso'],
                $segundo['fim_iso'],
                $segundo['acao'],
                $segundo['evento'],
            ]
        );

        $nomeEleitoral = $eventos['nome_eleitoral'] ?? $treinamentos['nome_eleitoral'];

        return [
            'nome_anonimizado' => $cards === [] ? null : $this->anonimizarNome($nomeEleitoral),
            'ocorrencias' => $cards,
        ];
    }

    /**
     * @param  array<int, array<string, mixed>>  $ocorrencias
     * @return array{
     *     nome_eleitoral:?string,
     *     cards:array<int, array{
     *         macroprojeto:string,
     *         acao:string,
     *         evento:string,
     *         local:string,
     *         modalidade:?string,
     *         endereco:?string,
     *         sala:?string,
     *         inicio_iso:string,
     *         fim_iso:string,
     *         dia:string,
     *         mes:string,
     *         ano:string,
     *         periodo:string
     *     }>
     * }
     */
    private function normalizarOcorrencias(array $ocorrencias): array
    {
        $cards = [];
        $nomeEleitoral = null;
        foreach ($ocorrencias as $ocorrencia) {
            $inicio = $this->dataHora((string) ($ocorrencia['inicio'] ?? ''));
            $fim = $this->dataHora((string) ($ocorrencia['fim'] ?? ''));
            if ($inicio === null || $fim === null || $fim <= $inicio) {
                continue;
            }

            $cards[] = [
                'macroprojeto' => $this->textoPublico($ocorrencia['macroprojeto'] ?? null),
                'acao' => $this->textoPublico($ocorrencia['acao'] ?? null),
                'evento' => $this->textoPublico($ocorrencia['evento'] ?? null),
                'local' => $this->textoPublico($ocorrencia['local'] ?? null, 'Local a confirmar'),
                'modalidade' => $this->textoOpcional($ocorrencia['modalidade'] ?? null),
                'endereco' => $this->textoOpcional($ocorrencia['endereco'] ?? null),
                'sala' => $this->textoOpcional($ocorrencia['sala'] ?? null),
                'inicio_iso' => $inicio->format('Y-m-d\TH:i'),
                'fim_iso' => $fim->format('Y-m-d\TH:i'),
                'dia' => $inicio->format('d'),
                'mes' => self::MESES[(int) $inicio->format('n')],
                'ano' => $inicio->format('Y'),
                'periodo' => $this->formatarPeriodo($inicio, $fim),
            ];
            $nomeCandidato = trim((string) ($ocorrencia['nome_eleitor'] ?? ''));
            if ($nomeEleitoral === null && $nomeCandidato !== '') {
                $nomeEleitoral = $nomeCandidato;
            }
        }

        return [
            'nome_eleitoral' => $nomeEleitoral,
            'cards' => $cards,
        ];
    }

    private function dataHora(string $valor): ?DateTimeImmutable
    {
        if (preg_match('/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/', $valor) !== 1) {
            return null;
        }

        $dataHora = DateTimeImmutable::createFromFormat('!Y-m-d\TH:i', $valor);

        return $dataHora === false ? null : $dataHora;
    }

    private function formatarPeriodo(DateTimeImmutable $inicio, DateTimeImmutable $fim): string
    {
        if ($inicio->format('Y-m-d') === $fim->format('Y-m-d')) {
            return sprintf(
                '%s, das %s às %s',
                $inicio->format('d/m/Y'),
                $inicio->format('H:i'),
                $fim->format('H:i')
            );
        }

        return sprintf(
            '%s às %s até %s às %s',
            $inicio->format('d/m/Y'),
            $inicio->format('H:i'),
            $fim->format('d/m/Y'),
            $fim->format('H:i')
        );
    }

    private function textoPublico(mixed $valor, string $padrao = '—'): string
    {
        $texto = trim((string) $valor);

        return $texto !== '' ? $texto : $padrao;
    }

    private function textoOpcional(mixed $valor): ?string
    {
        $texto = trim((string) $valor);

        return $texto !== '' ? $texto : null;
    }

    private function anonimizarNome(mixed $valor): string
    {
        $palavras = preg_split('/\s+/u', trim((string) $valor), -1, PREG_SPLIT_NO_EMPTY) ?: [];
        if ($palavras === []) {
            return 'Eleitor identificado';
        }

        $primeiroNome = mb_strtoupper(
            mb_substr($palavras[0], 0, 1, 'UTF-8'),
            'UTF-8'
        ).mb_substr($palavras[0], 1, null, 'UTF-8');
        $demaisPalavras = array_map(
            static fn (string $palavra): string => mb_strtoupper(
                mb_substr($palavra, 0, 1, 'UTF-8'),
                'UTF-8'
            ).'***',
            array_slice($palavras, 1)
        );

        return implode(' ', [$primeiroNome, ...$demaisPalavras]);
    }
}
```
</APP_SERVICES_COLABORADORESELEITORAIS_EVENTOVOLUNTARIOPUBLICOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Gel/GelSyncService.php`
## <APP_SERVICES_GEL_GELSYNCSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Gel/GelSyncService.php`
- **Namespace Declaração:** `App\Services\Gel`
- **Entidade / Classe:** `class GelSyncService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$destinoEtapa = (int) DB::table('planeleito.' . $definicao['table'])->count();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function etapasCarga(): array
public function tabelasEmOrdemCarga(): array
public function tabelasEmOrdemTruncate(): array
public function sincronizarAcCompleto(?string $syncRunId = null): array
public function montarSqlInsercao(string $etapa, string $dblink, string $syncRunId): string
public function montarSqlContagem(string $etapa, string $dblink): string
public function montarSqlViewRespostas(): string
private function resolverDblink(): string
private function validarDblink(string $dblink): void
private function resolverUf(): string
private function resolverCdUf(): int
private function literal(string $valor): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Gel;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use RuntimeException;

class GelSyncService
{
    private const ETAPAS = [
        'formulario' => ['table' => 'gel_formulario'],
        'categoria' => ['table' => 'gel_categoria'],
        'question' => ['table' => 'gel_question'],
        'question_option' => ['table' => 'gel_question_option'],
        'dispositivo_cadastrado' => ['table' => 'gel_dispositivo_cadastrado'],
        'dispositivo_zona' => ['table' => 'gel_dispositivo_zona'],
        'vistoria' => ['table' => 'gel_vistoria'],
        'categoria_vistoria' => ['table' => 'gel_categoria_vistoria'],
        'question_vistoria' => ['table' => 'gel_question_vistoria'],
        'question_option_vistoria' => ['table' => 'gel_question_option_vistoria'],
        'question_vistoria_valor' => ['table' => 'gel_question_vistoria_valor'],
        'vistoria_imagem' => ['table' => 'gel_vistoria_imagem'],
    ];

    /** @return array<string, array{table:string}> */
    public function etapasCarga(): array
    {
        return self::ETAPAS;
    }

    /** @return list<string> */
    public function tabelasEmOrdemCarga(): array
    {
        return array_values(array_map(
            static fn (array $etapa): string => $etapa['table'],
            self::ETAPAS
        ));
    }

    /** @return list<string> */
    public function tabelasEmOrdemTruncate(): array
    {
        return array_reverse($this->tabelasEmOrdemCarga());
    }

    /** @return array{dblink:string,sync_run_id:string,origem_total:int,destino_total:int,etapas:array<string,array{dblink:string,origem_total:int,destino_total:int}>} */
    public function sincronizarAcCompleto(?string $syncRunId = null): array
    {
        $dblink = $this->resolverDblink();
        $syncRunId = $syncRunId ?: (string) Str::uuid();

        foreach ($this->tabelasEmOrdemTruncate() as $tabela) {
            DB::statement('TRUNCATE TABLE planeleito.' . $tabela);
        }

        $etapas = [];
        $origemTotal = 0;
        $destinoTotal = 0;

        foreach (self::ETAPAS as $etapa => $definicao) {
            DB::statement($this->montarSqlInsercao($etapa, $dblink, $syncRunId));

            $origem = DB::selectOne($this->montarSqlContagem($etapa, $dblink));
            $origemEtapa = (int) ($origem->total ?? $origem->TOTAL ?? 0);
            $destinoEtapa = (int) DB::table('planeleito.' . $definicao['table'])->count();

            $etapas[$etapa] = [
                'dblink' => $dblink,
                'origem_total' => $origemEtapa,
                'destino_total' => $destinoEtapa,
            ];

            $origemTotal += $origemEtapa;
            $destinoTotal += $destinoEtapa;
        }

        return [
            'dblink' => $dblink,
            'sync_run_id' => $syncRunId,
            'origem_total' => $origemTotal,
            'destino_total' => $destinoTotal,
            'etapas' => $etapas,
        ];
    }

    public function montarSqlInsercao(string $etapa, string $dblink, string $syncRunId): string
    {
        $this->validarDblink($dblink);
        $uf = $this->resolverUf();
        $cdUf = $this->resolverCdUf();
        $run = $this->literal($syncRunId);

        return match ($etapa) {
            'formulario' => <<<SQL
INSERT INTO planeleito.gel_formulario (
    sq_formulario, cd_uf, ds_descricao, sync_run_id, synced_at
)
SELECT
    f.sq_formulario, f.cd_uf, f.ds_descricao, '{$run}', SYSDATE
FROM ADMGEL.formulario@{$dblink} f
WHERE f.cd_uf = {$cdUf}
SQL,
            'categoria' => <<<SQL
INSERT INTO planeleito.gel_categoria (
    cod_categoria, cod_objeto, nom_categoria, seq_categoria, txt_orientacao, seq_formulario, sync_run_id, synced_at
)
SELECT
    c.cod_categoria, c.cod_objeto, c.nom_categoria, c.seq_categoria, c.txt_orientacao, c.seq_formulario, '{$run}', SYSDATE
FROM ADMGEL.categoria@{$dblink} c
JOIN ADMGEL.formulario@{$dblink} f ON f.sq_formulario = c.seq_formulario
WHERE f.cd_uf = {$cdUf}
SQL,
            'question' => <<<SQL
INSERT INTO planeleito.gel_question (
    cod_question, cod_objeto, des_question, seq_question, tip_question, txt_question, ind_categoria, txt_orientacao, bol_required, sync_run_id, synced_at
)
SELECT
    q.cod_question, q.cod_objeto, q.des_question, q.seq_question, q.tip_question, q.txt_question, q.ind_categoria, q.txt_orientacao, q.bol_required, '{$run}', SYSDATE
FROM ADMGEL.question@{$dblink} q
JOIN ADMGEL.categoria@{$dblink} c ON c.cod_categoria = q.ind_categoria
JOIN ADMGEL.formulario@{$dblink} f ON f.sq_formulario = c.seq_formulario
WHERE f.cd_uf = {$cdUf}
SQL,
            'question_option' => <<<SQL
INSERT INTO planeleito.gel_question_option (
    cod_question_option, cod_objeto, des_question_option, seq_question_option, txt_question_option, ind_question, sync_run_id, synced_at
)
SELECT
    qo.cod_question_option, qo.cod_objeto, qo.des_question_option, qo.seq_question_option, qo.txt_question_option, qo.ind_question, '{$run}', SYSDATE
FROM ADMGEL.question_option@{$dblink} qo
JOIN ADMGEL.question@{$dblink} q ON q.cod_question = qo.ind_question
JOIN ADMGEL.categoria@{$dblink} c ON c.cod_categoria = q.ind_categoria
JOIN ADMGEL.formulario@{$dblink} f ON f.sq_formulario = c.seq_formulario
WHERE f.cd_uf = {$cdUf}
SQL,
            'dispositivo_cadastrado' => <<<SQL
INSERT INTO planeleito.gel_dispositivo_cadastrado (
    cod_dispositivo_cadastrado, dat_dispositivo_cadastrado, txt_email_responsavel, txt_titulo, txt_uf,
    dat_desabilitado_em, txt_nome_responsavel, txt_email_autorizado_por, txt_nome_autorizado_por, sync_run_id, synced_at
)
SELECT
    d.cod_dispositivo_cadastrado, d.dat_dispositivo_cadastrado, d.txt_email_responsavel, d.txt_titulo, d.txt_uf,
    d.dat_desabilitado_em, d.txt_nome_responsavel, d.txt_email_autorizado_por, d.txt_nome_autorizado_por, '{$run}', SYSDATE
FROM ADMGEL.dispositivo_cadastrado@{$dblink} d
WHERE d.txt_uf = '{$uf}'
SQL,
            'dispositivo_zona' => <<<SQL
INSERT INTO planeleito.gel_dispositivo_zona (
    ind_dispositivo_cadastrado, zona, sync_run_id, synced_at
)
SELECT
    dz.ind_dispositivo_cadastrado, dz.zona, '{$run}', SYSDATE
FROM ADMGEL.dispositivo_zona@{$dblink} dz
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = dz.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            'vistoria' => <<<SQL
INSERT INTO planeleito.gel_vistoria (
    cod_vistoria, txt_cargo_resp_informacao, txt_cargo_resp_local, txt_cargo_resp_vistoria,
    num_latitude_lv, num_longitude_lv, txt_mat_resp_informacao, txt_mat_resp_vistoria,
    txt_nome_municipio_sede, txt_nome_resp_informacao, txt_nome_resp_local, txt_nome_resp_vistoria,
    txt_novo_lv_bairro, txt_novo_lv_cep, txt_novo_lv_endereco, txt_novo_lv_nome, num_precisao_gps,
    txt_telefone_fixo, txt_telefone_orelhao_prox, txt_telefone_outros, txt_telefone_rural,
    ind_local_votacao, ind_zona, dat_criacao, dat_recebimento, dat_vistoria, txt_telefone_resp_local,
    ind_dispositivo_cadastrado, dat_envio_elo, txt_usuario_envio_elo, dat_upload_imagem, txt_hash_imagem,
    txt_name_imagem, bol_lv_dados_alterado, dat_alteracao, txt_usuario_alteracao, txt_novo_lv_telefone,
    bol_is_vinculado, txt_tipo_vistoria, sync_run_id, synced_at
)
SELECT
    v.cod_vistoria, v.txt_cargo_resp_informacao, v.txt_cargo_resp_local, v.txt_cargo_resp_vistoria,
    v.num_latitude_lv, v.num_longitude_lv, v.txt_mat_resp_informacao, v.txt_mat_resp_vistoria,
    v.txt_nome_municipio_sede, v.txt_nome_resp_informacao, v.txt_nome_resp_local, v.txt_nome_resp_vistoria,
    v.txt_novo_lv_bairro, v.txt_novo_lv_cep, v.txt_novo_lv_endereco, v.txt_novo_lv_nome, v.num_precisao_gps,
    v.txt_telefone_fixo, v.txt_telefone_orelhao_prox, v.txt_telefone_outros, v.txt_telefone_rural,
    v.ind_local_votacao, v.ind_zona, v.dat_criacao, v.dat_recebimento, v.dat_vistoria, v.txt_telefone_resp_local,
    v.ind_dispositivo_cadastrado, v.dat_envio_elo, v.txt_usuario_envio_elo, v.dat_upload_imagem, v.txt_hash_imagem,
    v.txt_name_imagem, v.bol_lv_dados_alterado, v.dat_alteracao, v.txt_usuario_alteracao, v.txt_novo_lv_telefone,
    v.bol_is_vinculado, v.txt_tipo_vistoria, '{$run}', SYSDATE
FROM ADMGEL.vistoria@{$dblink} v
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            'categoria_vistoria' => <<<SQL
INSERT INTO planeleito.gel_categoria_vistoria (
    cod_categoria_vistoria, cod_objeto_vistoria, nom_categoria_vistoria, seq_categoria_vistoria,
    ind_vistoria, txt_orientacao, sync_run_id, synced_at
)
SELECT
    cv.cod_categoria_vistoria, cv.cod_objeto_vistoria, cv.nom_categoria_vistoria, cv.seq_categoria_vistoria,
    cv.ind_vistoria, cv.txt_orientacao, '{$run}', SYSDATE
FROM ADMGEL.categoria_vistoria@{$dblink} cv
JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            'question_vistoria' => <<<SQL
INSERT INTO planeleito.gel_question_vistoria (
    cod_question_vistoria, cod_objeto, des_question_vistoria, seq_question_vistoria, tip_question_vistoria,
    txt_question_vistoria, ind_categoria_vistoria, txt_orientacao, bol_required, sync_run_id, synced_at
)
SELECT
    qv.cod_question_vistoria, qv.cod_objeto, qv.des_question_vistoria, qv.seq_question_vistoria, qv.tip_question_vistoria,
    qv.txt_question_vistoria, qv.ind_categoria_vistoria, qv.txt_orientacao, qv.bol_required, '{$run}', SYSDATE
FROM ADMGEL.question_vistoria@{$dblink} qv
JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = qv.ind_categoria_vistoria
JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            'question_option_vistoria' => <<<SQL
INSERT INTO planeleito.gel_question_option_vistoria (
    cod_question_option_vistoria, cod_objeto, des_question_option_vistoria, seq_question_option_vistoria,
    txt_question_option_vistoria, ind_question_vistoria, sync_run_id, synced_at
)
SELECT
    qov.cod_question_option_vistoria, qov.cod_objeto, qov.des_question_option_vistoria, qov.seq_question_option_vistoria,
    qov.txt_question_option_vistoria, qov.ind_question_vistoria, '{$run}', SYSDATE
FROM ADMGEL.question_option_vistoria@{$dblink} qov
JOIN ADMGEL.question_vistoria@{$dblink} qv ON qv.cod_question_vistoria = qov.ind_question_vistoria
JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = qv.ind_categoria_vistoria
JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            'question_vistoria_valor' => <<<SQL
INSERT INTO planeleito.gel_question_vistoria_valor (
    ind_question_vistoria, vlr, sync_run_id, synced_at
)
SELECT
    qvv.ind_question_vistoria, qvv.vlr, '{$run}', SYSDATE
FROM ADMGEL.question_vistoria_valor@{$dblink} qvv
JOIN ADMGEL.question_vistoria@{$dblink} qv ON qv.cod_question_vistoria = qvv.ind_question_vistoria
JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = qv.ind_categoria_vistoria
JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            'vistoria_imagem' => <<<SQL
INSERT INTO planeleito.gel_vistoria_imagem (
    cod_vistoria_imagem, dat_upload_imagem, txt_hash, txt_name_imagem, txt_titulo,
    ind_categoria_vistoria, sync_run_id, synced_at
)
SELECT
    vi.cod_vistoria_imagem, vi.dat_upload_imagem, vi.txt_hash, vi.txt_name_imagem, vi.txt_titulo,
    vi.ind_categoria_vistoria, '{$run}', SYSDATE
FROM ADMGEL.vistoria_imagem@{$dblink} vi
JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = vi.ind_categoria_vistoria
JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria
JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado
WHERE d.txt_uf = '{$uf}'
SQL,
            default => throw new RuntimeException('Etapa GEL desconhecida: ' . $etapa),
        };
    }

    public function montarSqlContagem(string $etapa, string $dblink): string
    {
        $this->validarDblink($dblink);
        $uf = $this->resolverUf();
        $cdUf = $this->resolverCdUf();

        return match ($etapa) {
            'formulario' => "SELECT COUNT(*) AS total FROM ADMGEL.formulario@{$dblink} f WHERE f.cd_uf = {$cdUf}",
            'categoria' => "SELECT COUNT(*) AS total FROM ADMGEL.categoria@{$dblink} c JOIN ADMGEL.formulario@{$dblink} f ON f.sq_formulario = c.seq_formulario WHERE f.cd_uf = {$cdUf}",
            'question' => "SELECT COUNT(*) AS total FROM ADMGEL.question@{$dblink} q JOIN ADMGEL.categoria@{$dblink} c ON c.cod_categoria = q.ind_categoria JOIN ADMGEL.formulario@{$dblink} f ON f.sq_formulario = c.seq_formulario WHERE f.cd_uf = {$cdUf}",
            'question_option' => "SELECT COUNT(*) AS total FROM ADMGEL.question_option@{$dblink} qo JOIN ADMGEL.question@{$dblink} q ON q.cod_question = qo.ind_question JOIN ADMGEL.categoria@{$dblink} c ON c.cod_categoria = q.ind_categoria JOIN ADMGEL.formulario@{$dblink} f ON f.sq_formulario = c.seq_formulario WHERE f.cd_uf = {$cdUf}",
            'dispositivo_cadastrado' => "SELECT COUNT(*) AS total FROM ADMGEL.dispositivo_cadastrado@{$dblink} d WHERE d.txt_uf = '{$uf}'",
            'dispositivo_zona' => "SELECT COUNT(*) AS total FROM ADMGEL.dispositivo_zona@{$dblink} dz JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = dz.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            'vistoria' => "SELECT COUNT(*) AS total FROM ADMGEL.vistoria@{$dblink} v JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            'categoria_vistoria' => "SELECT COUNT(*) AS total FROM ADMGEL.categoria_vistoria@{$dblink} cv JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            'question_vistoria' => "SELECT COUNT(*) AS total FROM ADMGEL.question_vistoria@{$dblink} qv JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = qv.ind_categoria_vistoria JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            'question_option_vistoria' => "SELECT COUNT(*) AS total FROM ADMGEL.question_option_vistoria@{$dblink} qov JOIN ADMGEL.question_vistoria@{$dblink} qv ON qv.cod_question_vistoria = qov.ind_question_vistoria JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = qv.ind_categoria_vistoria JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            'question_vistoria_valor' => "SELECT COUNT(*) AS total FROM ADMGEL.question_vistoria_valor@{$dblink} qvv JOIN ADMGEL.question_vistoria@{$dblink} qv ON qv.cod_question_vistoria = qvv.ind_question_vistoria JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = qv.ind_categoria_vistoria JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            'vistoria_imagem' => "SELECT COUNT(*) AS total FROM ADMGEL.vistoria_imagem@{$dblink} vi JOIN ADMGEL.categoria_vistoria@{$dblink} cv ON cv.cod_categoria_vistoria = vi.ind_categoria_vistoria JOIN ADMGEL.vistoria@{$dblink} v ON v.cod_vistoria = cv.ind_vistoria JOIN ADMGEL.dispositivo_cadastrado@{$dblink} d ON d.cod_dispositivo_cadastrado = v.ind_dispositivo_cadastrado WHERE d.txt_uf = '{$uf}'",
            default => throw new RuntimeException('Etapa GEL desconhecida: ' . $etapa),
        };
    }

    public function montarSqlViewRespostas(): string
    {
        $uf = $this->resolverUf();

        return <<<SQL
CREATE OR REPLACE VIEW vw_gel_respostas_ac AS
WITH respostas_multiplas AS (
    SELECT
        qvv.ind_question_vistoria,
        LISTAGG(qvv.vlr, '; ') WITHIN GROUP (ORDER BY qvv.vlr) AS resposta
    FROM gel_question_vistoria_valor qvv
    GROUP BY qvv.ind_question_vistoria
)
SELECT
    '{$uf}' AS uf,
    lv.nom_localidade AS municipio,
    v.ind_zona AS zona,
    lv.cod_objeto AS cod_objeto_local_votacao,
    lv.num_local AS numero_local,
    lv.nom_local AS nome_local,
    v.cod_vistoria,
    v.txt_tipo_vistoria,
    v.dat_vistoria,
    cv.seq_categoria_vistoria AS ordem_categoria,
    cv.nom_categoria_vistoria AS categoria,
    qv.seq_question_vistoria AS ordem_questao,
    qv.des_question_vistoria AS questao,
    qv.tip_question_vistoria AS tipo_questao,
    COALESCE(rm.resposta, qv.txt_question_vistoria) AS resposta,
    qv.cod_question_vistoria,
    cv.cod_categoria_vistoria
FROM gel_vistoria v
LEFT JOIN local_votacao_st lv ON TRIM(lv.cod_objeto) = TRIM(v.ind_local_votacao)
JOIN gel_categoria_vistoria cv ON cv.ind_vistoria = v.cod_vistoria
JOIN gel_question_vistoria qv ON qv.ind_categoria_vistoria = cv.cod_categoria_vistoria
LEFT JOIN respostas_multiplas rm ON rm.ind_question_vistoria = qv.cod_question_vistoria
SQL;
    }

    private function resolverDblink(): string
    {
        $dblink = (string) config('planeleito.sync.gel_dblink', 'cad_tse');
        $this->validarDblink($dblink);

        return $dblink;
    }

    private function validarDblink(string $dblink): void
    {
        if ($dblink === '' || preg_match('/^[A-Za-z0-9_#$.]+$/', $dblink) !== 1) {
            throw new RuntimeException('DBLINK invalido para sincronizacao GEL.');
        }
    }

    private function resolverUf(): string
    {
        $uf = strtoupper(trim((string) config('planeleito.sync.gel_uf', 'AC')));
        if (preg_match('/^[A-Z]{2}$/', $uf) !== 1) {
            throw new RuntimeException('UF invalida para sincronizacao GEL.');
        }

        return $this->literal($uf);
    }

    private function resolverCdUf(): int
    {
        $cdUf = (int) config('planeleito.sync.gel_cd_uf', 24);
        if ($cdUf <= 0) {
            throw new RuntimeException('Codigo de UF invalido para sincronizacao GEL.');
        }

        return $cdUf;
    }

    private function literal(string $valor): string
    {
        return str_replace("'", "''", $valor);
    }
}
```
</APP_SERVICES_GEL_GELSYNCSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Rcand/RcandSyncService.php`
## <APP_SERVICES_RCAND_RCANDSYNCSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Rcand/RcandSyncService.php`
- **Namespace Declaração:** `App\Services\Rcand`
- **Entidade / Classe:** `class RcandSyncService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('planeleito.rcand_pje_processos')->insert($chunk);
'destino_total' => (int) DB::table('planeleito.rcand_pje_processos')->count(),
'destino_total' => (int) DB::table('planeleito.rcand_cand_processos')->count(),
$destinoPedidos = (int) DB::table('planeleito.rcand_candexweb_pedidos')->count();
$destinoCandidatos = (int) DB::table('planeleito.rcand_candexweb_candidatos')->count();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function sincronizarPje(): array
public function sincronizarCand(): array
public function sincronizarCandexweb(): array
public function sincronizarConsolidado(): array
public function sincronizarSequencial(): array
public function calcularCamposPbit(array $linha): array
public function montarSqlConsultaPje(): string
public function montarSqlInsercaoCatalogoPartidos(string $dblink, array $eleicao = []): string
public function montarSqlInsercaoCandProcessoPartidos(string $dblink, array $eleicao = []): string
public function montarSqlInsercaoCand(string $dblink, array $eleicao = []): string
public function montarSqlContagemCand(string $dblink, array $eleicao = []): string
public function montarSqlInsercaoCandexwebPedidoPartidos(string $dblink, array $eleicao = []): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Rcand;

use Illuminate\Support\Facades\DB;
use RuntimeException;

class RcandSyncService
{
    private const CARGOS_PRESIDENCIA = [1, 2];

    /** @return array{connection:string, origem_total:int, destino_total:int} */
    public function sincronizarPje(): array
    {
        $connectionName = (string) config('planeleito.sync.rcand_pje_connection', 'rcand_pje');
        $linhas = DB::connection($connectionName)->select($this->montarSqlConsultaPje());

        DB::statement('TRUNCATE TABLE planeleito.rcand_pje_processos');

        $registros = [];
        foreach ($linhas as $linha) {
            $registros[] = $this->normalizarLinhaPje((array) $linha);
        }

        foreach (array_chunk($registros, 500) as $chunk) {
            DB::table('planeleito.rcand_pje_processos')->insert($chunk);
        }

        return [
            'connection' => $connectionName,
            'origem_total' => count($linhas),
            'destino_total' => (int) DB::table('planeleito.rcand_pje_processos')->count(),
        ];
    }

    /** @return array{dblink:string, origem_total:int, destino_total:int} */
    public function sincronizarCand(): array
    {
        $dblink = $this->resolverDblink('rcand_cand_dblink', 'cand', 'RCAND CAND');
        $codigosEleicao = $this->codigosEleicao();
        $contextoSchema = $this->resolverContextoSchema();
        $origemTotal = 0;

        DB::statement('TRUNCATE TABLE planeleito.rcand_cand_proc_partido');
        DB::statement('TRUNCATE TABLE planeleito.rcand_partido');
        DB::statement('TRUNCATE TABLE planeleito.rcand_cand_processos');

        foreach ($codigosEleicao as $codigoEleicao) {
            $eleicao = $this->selecionarContextoEleicao($contextoSchema, $dblink, $codigoEleicao);

            DB::statement($this->montarSqlInsercaoCatalogoPartidos($dblink, $eleicao));
            DB::statement($this->montarSqlInsercaoCand($dblink, $eleicao));
            DB::statement($this->montarSqlInsercaoCandProcessoPartidos($dblink, $eleicao));

            $origem = DB::selectOne($this->montarSqlContagemCand($dblink, $eleicao));
            $origemTotal += (int) ($origem->total ?? $origem->TOTAL ?? 0);
        }

        return [
            'dblink' => $dblink,
            'origem_total' => $origemTotal,
            'destino_total' => (int) DB::table('planeleito.rcand_cand_processos')->count(),
        ];
    }

    /** @return array{dblink:string, origem_total:int, destino_total:int} */
    public function sincronizarCandexweb(): array
    {
        $dblink = $this->resolverDblink('rcand_cand_dblink', 'cand', 'RCAND CANDEXWEB');
        $codigosEleicao = $this->codigosEleicao();
        $contextoSchema = $this->resolverContextoSchema();
        $origemTotal = 0;

        DB::statement('TRUNCATE TABLE planeleito.rcand_cw_pedido_partido');
        DB::statement('TRUNCATE TABLE planeleito.rcand_candexweb_candidatos');
        DB::statement('TRUNCATE TABLE planeleito.rcand_candexweb_pedidos');

        foreach ($codigosEleicao as $codigoEleicao) {
            $eleicao = $this->selecionarContextoEleicao($contextoSchema, $dblink, $codigoEleicao);

            DB::statement($this->montarSqlInsercaoCandexwebPedidos($dblink, $eleicao));
            DB::statement($this->montarSqlInsercaoCandexwebCandidatos($dblink, $eleicao));
            DB::statement($this->montarSqlInsercaoCandexwebPedidoPartidos($dblink, $eleicao));

            $origemPedidos = DB::selectOne($this->montarSqlContagemCandexwebPedidos($dblink, $eleicao));
            $origemCandidatos = DB::selectOne($this->montarSqlContagemCandexwebCandidatos($dblink, $eleicao));
            $origemTotal += (int) ($origemPedidos->total ?? $origemPedidos->TOTAL ?? 0);
            $origemTotal += (int) ($origemCandidatos->total ?? $origemCandidatos->TOTAL ?? 0);
        }

        $destinoPedidos = (int) DB::table('planeleito.rcand_candexweb_pedidos')->count();
        $destinoCandidatos = (int) DB::table('planeleito.rcand_candexweb_candidatos')->count();

        return [
            'dblink' => $dblink,
            'origem_total' => $origemTotal,
            'destino_total' => $destinoPedidos + $destinoCandidatos,
        ];
    }

    /** @return array{dblink:string, origem_total:int, destino_total:int} */
    public function sincronizarConsolidado(): array
    {
        DB::statement('TRUNCATE TABLE planeleito.rcand_consolidado_processos');
        DB::statement($this->montarSqlInsercaoConsolidado());

        $destino = (int) DB::table('planeleito.rcand_consolidado_processos')->count();

        return [
            'dblink' => '',
            'origem_total' => $destino,
            'destino_total' => $destino,
        ];
    }

    /** @return array<string, array<string, int|string>> */
    public function sincronizarSequencial(): array
    {
        return [
            'rcand_pje' => $this->sincronizarPje(),
            'rcand_cand' => $this->sincronizarCand(),
            'rcand_candexweb' => $this->sincronizarCandexweb(),
            'rcand_consolidado' => $this->sincronizarConsolidado(),
        ];
    }

    /**
     * @param  array<string, mixed>  $linha
     * @return array{julgados_pje_sn:string,sem_int_mpe:string,todas_peticoes_lidas:string,cert_publ_sn:string,julgamento_if_cand:int,julgados_cand_sn:string,inform_candidato_sn:string,if_cand_x_pje:string}
     */
    public function calcularCamposPbit(array $linha): array
    {
        $julgadosPje = $this->valorPreenchido($linha['primeiro_julgamento'] ?? null) ? 'Sim' : 'Não';
        $semIntMpe = $this->valorPreenchido($linha['intimacao_mp_parecer'] ?? null) ? 'Sim' : 'Não';
        $todasPeticoesLidas = $this->valorPreenchido($linha['peticoes_avulsas'] ?? null) ? 'Sim' : 'Não';
        $certPubl = $this->valorPreenchido($linha['certidao_publicacao'] ?? null) ? 'Sim' : 'Não';
        $informCandidato = $this->valorPreenchido($linha['informacao_candidato'] ?? null) ? 'Sim' : 'Não';
        $julgamentoIfCand = $this->situacaoCandAguardandoJulgamento($linha['cand_situacao_processo'] ?? null) ? 2 : 1;
        $julgadosCand = $julgamentoIfCand === 2 ? 'Não' : 'Sim';

        return [
            'julgados_pje_sn' => $julgadosPje,
            'sem_int_mpe' => $semIntMpe,
            'todas_peticoes_lidas' => $todasPeticoesLidas,
            'cert_publ_sn' => $certPubl,
            'julgamento_if_cand' => $julgamentoIfCand,
            'julgados_cand_sn' => $julgadosCand,
            'inform_candidato_sn' => $informCandidato,
            'if_cand_x_pje' => $julgadosPje === $julgadosCand ? 'Igual' : 'Diferente',
        ];
    }

    public function montarSqlConsultaPje(): string
    {
        $anoEleicao = $this->literalNumericoConfig('rcand_ano_eleicao', '2024');

        return <<<SQL
with q_proc_cand as (
    select
        cp.*,
        p.id_proc_referencia,
        case
            when cd_assunto_principal in ('12044') then 'DRAP'
            when cd_assunto_principal in ('11618') then 'RRC'
            when cd_assunto_principal in ('11619') then 'RRCI'
            else 'Outros'
        end tp_registro
    from client.tb_cabecalho_processo cp
    join client.tb_processo_trf p
        on p.id_processo_trf = cp.id_processo_trf
    where cp.cd_classe_judicial = '11532'
      and cp.nr_ano_eleicao = '{$anoEleicao}'
      and cp.nr_processo is not null
),
q_proc_com_edital_drap as (
    select pe.id_processo_trf, min(dt_atualizacao) dt_primeiro_edital
    from client.tb_cabecalho_processo cp
    join core.tb_processo_evento pe on cp.id_processo_trf = pe.id_processo_trf
    join core.tb_processo_documento pd on pe.id_processo_documento = pd.id_processo_documento
    left join client.tb_complemento_segmentado cs on cs.id_movimento_processo = pe.id_processo_evento
    where cp.cd_assunto_principal in ('12044')
      and pd.id_processo_trf = cp.id_processo_trf
      and pe.id_evento = 255
      and ds_texto_final_externo ilike 'Juntada de edital'
      and pe.in_ativo is true
    group by pe.id_processo_trf
),
q_proc_com_edital_drap_e_rcc as (
    select
        q.id_processo_trf,
        q.id_processo_trf as id_processo_trf_origem,
        q.dt_primeiro_edital
    from q_proc_com_edital_drap q
    union
    select
        tptc.id_processo_trf_conexo,
        q.id_processo_trf as id_processo_trf_origem,
        q.dt_primeiro_edital
    from client.tb_processo_trf_conexao tptc
    join q_proc_com_edital_drap q on q.id_processo_trf = tptc.id_processo_trf
    join q_proc_cand conexo on conexo.id_processo_trf = tptc.id_processo_trf_conexo
    where conexo.tp_registro in ('RRC', 'RRCI')
    union
    select
        tptc.id_processo_trf,
        q.id_processo_trf as id_processo_trf_origem,
        q.dt_primeiro_edital
    from client.tb_processo_trf_conexao tptc
    join q_proc_com_edital_drap q on q.id_processo_trf = tptc.id_processo_trf_conexo
    join q_proc_cand conexo on conexo.id_processo_trf = tptc.id_processo_trf
    where conexo.tp_registro in ('RRC', 'RRCI')
),
q_publicacao_apos_edital as (
    select e.id_processo_trf, min(pe.dt_atualizacao) dt_prim_publ_apos_edital
    from q_proc_com_edital_drap_e_rcc e
    join core.tb_processo_evento pe on pe.id_processo_trf = e.id_processo_trf_origem
    where pe.id_evento = 256
      and (pe.ds_texto_final_externo ilike 'Publicado edital%' or pe.ds_texto_final_externo ilike 'Publicado Intimação em%')
      and pe.in_ativo is true
      and pe.dt_atualizacao > e.dt_primeiro_edital
    group by e.id_processo_trf
),
q_proc_diligencia as (
    select cp.id_processo_trf, min(pe.dt_atualizacao) dt_primeira_diligencia, max(pe.dt_atualizacao) dt_ultima_diligencia
    from q_proc_cand cp
    join core.tb_processo_evento pe on cp.id_processo_trf = pe.id_processo_trf
    join core.tb_processo_documento pd on pe.id_processo_documento = pd.id_processo_documento
    join client.tb_complemento_segmentado cs on cs.id_movimento_processo = pe.id_processo_evento
    where pd.id_processo_trf = cp.id_processo_trf
      and pe.id_evento = 255
      and ((cs.ds_valor_complemento = 'intimação') or (pe.ds_texto_final_externo ilike '%Juntada de intimação%'))
      and pe.in_ativo is true
    group by cp.id_processo_trf
),
q_info_cand as (
    select cp.id_processo_trf, min(pe.dt_atualizacao) dt_prim_info_cand
    from q_proc_cand cp
    join core.tb_processo_evento pe on cp.id_processo = pe.id_processo
    where (
        lower(pe.ds_texto_final_interno) ilike 'juntada de informação de%'
        or exists (
            select 1 from core.tb_processo_documento tpd2
            where tpd2.id_processo_documento = pe.id_processo_documento
              and tpd2.ds_processo_documento ilike 'Informa_o de Federa_o.html'
        )
    )
      and pe.in_ativo is true
    group by cp.id_processo_trf
),
q_eventos_julgamento as (
    select
        cp.id_processo_trf,
        pe.id_processo_evento,
        pe.dt_atualizacao,
        e.cd_evento,
        e.ds_evento,
        case
            when e.cd_evento in ('12444', '12660', '12673', '12694', '15023') then 'deferido'
            when e.cd_evento in ('14213', '12699', '12689', '12679', '12684') then 'deferido'
            when e.cd_evento in ('12667', '14210', '15024') then 'indeferido'
            when e.cd_evento in ('12695', '14214', '12700', '12690', '12680', '12685') then 'indeferido'
            when e.cd_evento = '12649' then 'homologado'
            when e.cd_evento = '14211' then 'renúncia'
            when e.cd_evento in ('12697', '14216', '12702', '12692', '12682', '12687') then 'cassado'
            when e.cd_evento in ('12696', '14215', '12701', '12691', '12681', '12686') then 'cancelado'
            when e.cd_evento = '237' then 'PROVIM'
            when e.cd_evento in ('238', '871') then 'PROV PARC'
            when e.cd_evento = '239' then 'NÃO PROVIM'
            when e.cd_evento = '15408' then 'NÃO CONHEC'
            else null
        end ds_teor_julgamento
    from q_proc_cand cp
    join core.tb_processo_evento pe on pe.id_processo_trf = cp.id_processo_trf
    join core.tb_evento e on pe.id_evento = e.id_evento
    where pe.in_ativo is true
      and (
          e.cd_evento = '12200'
          or e.breadcrumb like '%193%'
          or e.cd_evento = '12444'
      )
),
q_primeiro_julgamento as (
    select id_processo_trf, min(dt_atualizacao) dt_primeiro_julgamento
    from q_eventos_julgamento
    group by id_processo_trf
),
q_teor_julgamento as (
    select distinct on (id_processo_trf)
        id_processo_trf,
        case
            when ds_teor_julgamento is not null then ds_teor_julgamento
            else '**não mapeado - ' || cd_evento || ds_evento
        end ds_teor_julgamento
    from q_eventos_julgamento
    where cd_evento <> '12200'
    order by
        id_processo_trf,
        case when ds_teor_julgamento is null then 1 else 0 end,
        dt_atualizacao,
        id_processo_evento
),
q_proc_julg as (
    select
        primeiro.id_processo_trf,
        primeiro.dt_primeiro_julgamento,
        teor.ds_teor_julgamento
    from q_primeiro_julgamento primeiro
    left join q_teor_julgamento teor on teor.id_processo_trf = primeiro.id_processo_trf
),
q_homolg_renuncia as (
    select pe.id_processo_trf, min(pe.dt_atualizacao) dt_renuncia
    from core.tb_processo_evento pe
    join q_proc_julg j on j.id_processo_trf = pe.id_processo_trf
    join core.tb_evento e on e.id_evento = pe.id_evento
    where e.cd_evento = '14211'
      and pe.in_ativo is true
    group by pe.id_processo_trf
),
q_parecer_mp as (
    select cp.id_processo_trf, min(pe.dt_atualizacao) dt_parecer
    from q_proc_cand cp
    join core.tb_processo_evento pe on cp.id_processo_trf = pe.id_processo_trf
    join core.tb_processo_documento pd on pe.id_processo_documento = pd.id_processo_documento
    where (
        pd.ds_processo_documento ilike '%parecer da procuradoria%'
        or pd.ds_processo_documento ilike '%parecer do ministério público eleitoral%'
        or pd.ds_processo_documento ilike '%Manifestação do Ministério Público Eleitoral%'
        or pd.ds_processo_documento ilike '%Manifestação do MPE%'
        or pd.ds_processo_documento ilike '%Cota ministerial%'
    )
      and pe.in_ativo is true
    group by cp.id_processo_trf
),
q_envio_mpf as (
    select cp.id_processo_trf, min(exp.dt_criacao_expediente) dt_envio_mpf
    from q_proc_cand cp
    join client.tb_processo_expediente exp on exp.id_processo_trf = cp.id_processo_trf
    join client.tb_proc_parte_expediente dest on dest.id_processo_expediente = exp.id_processo_expediente
    where exp.dt_exclusao is null
      and dest.id_procuradoria is not null
      and dest.nm_pessoa_parte ilike '%Procuradoria Regional Eleitoral%'
    group by cp.id_processo_trf
),
q_concluso_para_mp as (
    select cp.id_processo_trf, min(pe.dt_atualizacao) dt_prim_concl_mp
    from q_proc_cand cp
    join q_info_cand info on info.id_processo_trf = cp.id_processo_trf
    join core.tb_processo_evento pe on cp.id_processo_trf = pe.id_processo_trf
    left join client.tb_complemento_segmentado cs on cs.id_movimento_processo = pe.id_processo_evento
    where ((cs.ds_valor_complemento = 'para decisão') or (pe.ds_texto_final_externo ilike '%para decisão%'))
      and pe.dt_atualizacao >= dt_prim_info_cand
      and pe.in_ativo is true
    group by cp.id_processo_trf
),
q_concluso_para_mp_apos_julg_renuncia as (
    select cp.id_processo_trf, to_char(max(pe.dt_atualizacao), 'dd/mm') || ' - Concluso após Renúncia.' dt_concl_mp_apos_julg
    from q_proc_cand cp
    join q_homolg_renuncia r on r.id_processo_trf = cp.id_processo_trf
    left join core.tb_processo_evento pe on cp.id_processo_trf = pe.id_processo_trf
    left join client.tb_complemento_segmentado cs on cs.id_movimento_processo = pe.id_processo_evento
    where ((cs.ds_valor_complemento = 'para decisão') or (pe.ds_texto_final_externo ilike '%para decisão%'))
      and pe.dt_atualizacao < r.dt_renuncia
      and pe.in_ativo is true
    group by cp.id_processo_trf
),
q_resp_juntada_dilig as (
    select cp.id_processo_trf, to_char(min(pe.dt_atualizacao), 'dd/mm') dt_inclusao_adv
    from q_proc_cand cp
    join q_proc_diligencia dilig on dilig.id_processo_trf = cp.id_processo_trf
    join core.tb_processo_evento pe on cp.id_processo_trf = pe.id_processo_trf
    join core.tb_processo_documento pd on pe.id_processo_documento = pd.id_processo_documento
    join client.tb_complemento_segmentado cs on cs.id_movimento_processo = pe.id_processo_evento
    join acl.tb_usuario_login ul on ul.id_usuario = pd.id_usuario_inclusao
    join acl.tb_usuario_papel tup on tup.id_usuario = ul.id_usuario
    join acl.tb_papel tp on tp.id_papel = tup.id_papel
    where cs.ds_valor_complemento = 'petição'
      and pe.in_ativo is true
      and lower(tp.ds_nome) like 'advogado'
      and pe.dt_atualizacao > dilig.dt_primeira_diligencia
    group by cp.id_processo_trf
),
q_recurso as (
    select distinct on (pe.id_processo_trf)
        pe.id_processo_trf,
        min(pe.dt_atualizacao) dt_recurso,
        case
            when cs.ds_valor_complemento = 'Embargos de declaração' then 'EmbDecl'
            when cs.ds_valor_complemento = 'recurso eleitoral' then 'REl'
            else '**não mapeado - '
        end recurso_interposto
    from core.tb_processo_evento pe
    join core.tb_processo_documento pd on pe.id_processo_documento = pd.id_processo_documento
    join client.tb_complemento_segmentado cs on cs.id_movimento_processo = pe.id_processo_evento
    where cs.ds_valor_complemento in ('recurso eleitoral','Embargos de declaração','agravo','questão de ordem','agravo em recurso especial eleitoral','recurso ordinário eleitoral','recurso especial eleitoral','recurso')
      and pe.in_ativo is true
    group by pe.id_processo_trf, cs.ds_valor_complemento
),
q_contrarrazao as (
    select pe.id_processo_trf, min(pe.dt_atualizacao) dt_contrarrazao
    from core.tb_processo_evento pe
    join core.tb_processo_documento pd on pe.id_processo_documento = pd.id_processo_documento
    join core.tb_tipo_processo_documento ttpd on pd.id_tipo_processo_documento = ttpd.id_tipo_processo_documento and pd.id_processo_trf = pe.id_processo_trf
    where ds_tipo_processo_documento ilike '%Contrarrazões%'
    group by pe.id_processo_trf
),
q_peticao_avulsa_task as (
    select cp.id_processo_trf, string_agg(to_char(create_, 'dd/mm'), ', ' order by create_) dt_peticao_avulsa_task
    from public.jbpm_taskinstance task
    join public.jbpm_variableinstance var on task.procinst_ = var.processinstance_ and lower(task.name_) = lower('Analisar Petição Avulsa')
    join client.tb_cabecalho_processo cp on var.longvalue_ = cp.id_processo_trf and var.class_ = 'L' and var.name_ = 'processo'
    group by cp.id_processo_trf
),
q_peticoes_avulsas as (
    select id_processo_trf, string_agg(dt_peticao_avulsa_task, ', ' order by dt_peticao_avulsa_task) dt_peticao_avulsa
    from q_peticao_avulsa_task
    group by id_processo_trf
),
q_remessa as (
    select pe.id_processo_trf, min(pe.dt_atualizacao) dt_remessa
    from core.tb_processo_evento pe
    where pe.id_evento = 258
      and pe.in_ativo is true
    group by pe.id_processo_trf
)
select
    p.nr_vara as zona,
    p.ds_municipio as municipio,
    substr(p.nr_processo, 1, 10) as nr_processo,
    trim(replace(replace(p.nr_processo, '-', ''), '.', '')) as nr_processo_sem_formatacao,
    p.tp_registro as tipo_registro,
    to_char(e.dt_primeiro_edital, 'dd/mm') as edital,
    (select to_char(dt_prim_publ_apos_edital, 'dd/mm') from q_publicacao_apos_edital pae where pae.id_processo_trf = p.id_processo_trf) as certidao_publicacao,
    case when di.dt_primeira_diligencia is null then null else to_char(di.dt_primeira_diligencia, 'dd/mm') end as primeira_diligencia,
    case when jd.dt_inclusao_adv is null then null else jd.dt_inclusao_adv end as resposta_juntada_diligencia,
    case when ic.dt_prim_info_cand is null then null else 'Sim' end as informacao_candidato,
    to_char(empf.dt_envio_mpf, 'dd/mm') as envio_mpf,
    to_char(par.dt_parecer, 'dd/mm') as intimacao_mp_parecer,
    coalesce(dt_concl_mp_apos_julg, to_char(cmp.dt_prim_concl_mp, 'dd/mm')) as conclusao,
    null::text as impugnacoes,
    pa.dt_peticao_avulsa as peticoes_avulsas,
    to_char(pj.dt_primeiro_julgamento, 'dd/mm') as primeiro_julgamento,
    to_char(rec.dt_recurso, 'dd/mm') as data_primeiro_recurso,
    to_char(contrarrazao.dt_contrarrazao, 'dd/mm') as contrarrazao,
    to_char(rem.dt_remessa, 'dd/mm') as remessa_tre,
    rec.recurso_interposto as recurso,
    pj.ds_teor_julgamento as teor_julgamento
from q_proc_cand p
left join q_proc_com_edital_drap_e_rcc e on e.id_processo_trf = p.id_processo_trf
left join q_proc_diligencia di on di.id_processo_trf = p.id_processo_trf
left join q_resp_juntada_dilig jd on jd.id_processo_trf = p.id_processo_trf
left join q_info_cand ic on ic.id_processo_trf = p.id_processo_trf
left join q_envio_mpf empf on empf.id_processo_trf = p.id_processo_trf
left join q_parecer_mp par on par.id_processo_trf = p.id_processo_trf
left join q_concluso_para_mp cmp on cmp.id_processo_trf = p.id_processo_trf
left join q_concluso_para_mp_apos_julg_renuncia cmpj on cmpj.id_processo_trf = p.id_processo_trf
left join q_peticoes_avulsas pa on pa.id_processo_trf = p.id_processo_trf
left join q_proc_julg pj on pj.id_processo_trf = p.id_processo_trf
left join q_recurso rec on rec.id_processo_trf = p.id_processo_trf
left join q_contrarrazao contrarrazao on contrarrazao.id_processo_trf = p.id_processo_trf
left join q_remessa rem on rem.id_processo_trf = p.id_processo_trf
where p.nr_processo is not null
order by p.nr_vara, p.id_processo_trf
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlInsercaoCatalogoPartidos(string $dblink, array $eleicao = []): string
    {
        $eleicao = $this->normalizarEleicao($eleicao);
        $cdEleicao = (string) $eleicao['cd_eleicao'];

        return <<<SQL
INSERT INTO planeleito.rcand_partido (
    cd_eleicao,
    nr_partido,
    sg_partido,
    nm_partido
)
SELECT
    {$cdEleicao} AS cd_eleicao,
    p.nr_partido,
    MAX(TRIM(p.sg_partido)) AS sg_partido,
    MAX(TRIM(p.nm_partido)) AS nm_partido
FROM cand_partido@{$dblink} p
WHERE p.cd_eleicao = {$cdEleicao}
  AND p.nr_partido IS NOT NULL
  AND p.sg_partido IS NOT NULL
  AND p.nm_partido IS NOT NULL
GROUP BY p.nr_partido
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlInsercaoCandProcessoPartidos(string $dblink, array $eleicao = []): string
    {
        $eleicao = $this->normalizarEleicao($eleicao);
        $unidadeEleitoral = mb_strtoupper((string) $eleicao['tp_abrangencia']) === 'F'
            ? 'BR'
            : $this->literalUfConfig();
        $cdEleicao = (string) $eleicao['cd_eleicao'];
        $cargoNaoPresidencial = $this->condicaoCargoNaoPresidencialSql('c.cd_cargo_eleicao');

        return <<<SQL
INSERT INTO planeleito.rcand_cand_proc_partido (
    cd_eleicao,
    nr_processo_sem_formatacao,
    nr_partido
)
WITH relacao AS (
    SELECT
        c.nr_processo,
        c.nr_partido
    FROM cand_candidato@{$dblink} c
    JOIN cand_ue@{$dblink} ue
      ON ue.sg_ue = c.sg_ue
    WHERE c.cd_eleicao = {$cdEleicao}
      AND ue.sg_ue = '{$unidadeEleitoral}'
      AND {$cargoNaoPresidencial}
      AND c.nr_processo IS NOT NULL
      AND c.nr_partido IS NOT NULL
    UNION
    SELECT
        d.nr_processo,
        pi.nr_partido
    FROM cand_drap@{$dblink} d
    JOIN cand_ue@{$dblink} ue
      ON ue.sg_ue = d.sg_ue
    JOIN cand_partido_isolado@{$dblink} pi
      ON pi.cd_eleicao = d.cd_eleicao
     AND pi.sq_drap = d.sq_drap
    WHERE d.cd_eleicao = {$cdEleicao}
      AND ue.sg_ue = '{$unidadeEleitoral}'
      AND d.nr_processo IS NOT NULL
      AND pi.nr_partido IS NOT NULL
    UNION
    SELECT
        d.nr_processo,
        pc.nr_partido
    FROM cand_drap@{$dblink} d
    JOIN cand_ue@{$dblink} ue
      ON ue.sg_ue = d.sg_ue
    JOIN cand_partido_coligacao@{$dblink} pc
      ON pc.cd_eleicao = d.cd_eleicao
     AND pc.sq_drap = d.sq_drap
    WHERE d.cd_eleicao = {$cdEleicao}
      AND ue.sg_ue = '{$unidadeEleitoral}'
      AND d.nr_processo IS NOT NULL
      AND pc.nr_partido IS NOT NULL
)
SELECT
    {$cdEleicao} AS cd_eleicao,
    REGEXP_REPLACE(nr_processo, '[^0-9]', '') AS nr_processo_sem_formatacao,
    nr_partido
FROM relacao
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlInsercaoCand(string $dblink, array $eleicao = []): string
    {
        $eleicao = $this->normalizarEleicao($eleicao);
        $unidadeEleitoral = mb_strtoupper((string) $eleicao['tp_abrangencia']) === 'F'
            ? 'BR'
            : $this->literalUfConfig();
        $cdEleicao = (string) $eleicao['cd_eleicao'];
        $nmEleicao = $this->literalString($eleicao['nm_eleicao']);
        $tpAbrangencia = $this->literalString($eleicao['tp_abrangencia']);
        $nrTurno = $this->literalNumber($eleicao['nr_turno']);
        $dtEleicao = $this->literalDate($eleicao['dt_eleicao']);
        $cargoNaoPresidencial = $this->condicaoCargoNaoPresidencialSql('c.cd_cargo_eleicao');

        return <<<SQL
INSERT INTO planeleito.rcand_cand_processos (
    cd_eleicao,
    nm_eleicao,
    tp_abrangencia,
    nr_turno,
    dt_eleicao,
    nr_processo,
    nr_processo_sem_formatacao,
    ds_situacao_processo,
    tp_processo,
    impugnacoes
)
WITH impugnacoes_candidato AS (
    SELECT
       h.cd_eleicao,
       h.sq_candidato
    FROM cand_historico_ocorrencia@{$dblink} h
    WHERE h.cd_eleicao = {$cdEleicao}
      AND h.tp_ocorrencia = 'I'
    GROUP BY h.cd_eleicao, h.sq_candidato
),
candidato AS (
    SELECT
       c.nr_processo,
       c.cd_situacao_candidato,
       CASE WHEN i.sq_candidato IS NOT NULL THEN 'Sim' ELSE 'Não' END AS impugnacoes
    FROM cand_candidato@{$dblink} c
    JOIN cand_ue@{$dblink} ue
      ON ue.sg_ue = c.sg_ue
    LEFT JOIN impugnacoes_candidato i
      ON i.cd_eleicao = c.cd_eleicao
     AND i.sq_candidato = c.sq_candidato
    WHERE ue.sg_ue = '{$unidadeEleitoral}'
      AND {$cargoNaoPresidencial}
),
drap AS (
    SELECT
      sq_drap,
      nr_processo,
      tp_situacao_drap,
      CASE tp_situacao_drap
        WHEN 'A' THEN 'Aguardando julgamento'
        WHEN 'I' THEN 'Impugnado'
        WHEN 'D' THEN 'Deferido'
        WHEN 'IN' THEN 'Indeferido'
        WHEN 'DR' THEN 'Deferido com recurso'
        WHEN 'IR' THEN 'Indeferido com recurso'
        WHEN 'IV' THEN 'Invalidado'
        WHEN 'PJ' THEN 'Pendente julgamento'
        WHEN 'VR' THEN 'Invalidado com recurso'
      END ds_situacao_drap
    FROM cand_drap@{$dblink} cd
    JOIN cand_ue@{$dblink} ue
      ON ue.sg_ue = cd.sg_ue
    WHERE ue.sg_ue = '{$unidadeEleitoral}'
)
SELECT
  {$cdEleicao} AS cd_eleicao,
  {$nmEleicao} AS nm_eleicao,
  {$tpAbrangencia} AS tp_abrangencia,
  {$nrTurno} AS nr_turno,
  {$dtEleicao} AS dt_eleicao,
  c.nr_processo,
  REGEXP_REPLACE(c.nr_processo, '[^0-9]', '') AS nr_processo_sem_formatacao,
  sc.nm_situacao_candidato ds_situacao_processo,
  'RRC' tp_processo,
  c.impugnacoes
FROM candidato c
JOIN cand_situacao_candidato@{$dblink} sc
  ON c.cd_situacao_candidato = sc.cd_situacao_candidato
WHERE c.nr_processo IS NOT NULL
UNION
SELECT
  {$cdEleicao} AS cd_eleicao,
  {$nmEleicao} AS nm_eleicao,
  {$tpAbrangencia} AS tp_abrangencia,
  {$nrTurno} AS nr_turno,
  {$dtEleicao} AS dt_eleicao,
  nr_processo,
  REGEXP_REPLACE(nr_processo, '[^0-9]', '') AS nr_processo_sem_formatacao,
  ds_situacao_drap,
  'DRAP' tp_processo,
  NULL AS impugnacoes
FROM drap
WHERE nr_processo IS NOT NULL
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlContagemCand(string $dblink, array $eleicao = []): string
    {
        $sql = preg_replace('/^INSERT INTO planeleito\.rcand_cand_processos \([\s\S]*?\)\s*WITH/m', 'WITH', $this->montarSqlInsercaoCand($dblink, $eleicao));

        return "SELECT COUNT(*) AS total FROM (\n".$sql."\n)";
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlInsercaoCandexwebPedidoPartidos(string $dblink, array $eleicao = []): string
    {
        $eleicao = $this->normalizarEleicao($eleicao);
        $cdEleicao = (string) $eleicao['cd_eleicao'];
        $ues = $this->listaUesCandexwebSql();

        return <<<SQL
INSERT INTO planeleito.rcand_cw_pedido_partido (
    cd_eleicao,
    sq_pedido,
    nr_partido
)
SELECT DISTINCT
    pp.cd_eleicao,
    pp.sq_pedido,
    pp.nr_partido
FROM admcandexweb.candex_partido_pedido@{$dblink} pp
JOIN admcandexweb.candex_pedido@{$dblink} p
  ON p.cd_eleicao = pp.cd_eleicao
 AND p.sq_pedido = pp.sq_pedido
WHERE pp.cd_eleicao = {$cdEleicao}
  AND p.sg_ue in ({$ues})
  AND pp.nr_partido IS NOT NULL
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlInsercaoCandexwebPedidos(string $dblink, array $eleicao = []): string
    {
        $eleicao = $this->normalizarEleicao($eleicao);
        $cdEleicao = (string) $eleicao['cd_eleicao'];
        $nmEleicao = $this->literalString($eleicao['nm_eleicao']);
        $tpAbrangencia = $this->literalString($eleicao['tp_abrangencia']);
        $nrTurno = $this->literalNumber($eleicao['nr_turno']);
        $dtEleicao = $this->literalDate($eleicao['dt_eleicao']);
        $ues = $this->listaUesCandexwebSql();

        return <<<SQL
INSERT INTO planeleito.rcand_candexweb_pedidos (
    cd_eleicao,
    nm_eleicao,
    tp_abrangencia,
    nr_turno,
    dt_eleicao,
    sq_pedido,
    sg_ue,
    cd_cargo,
    tp_agremiacao,
    tp_pedido,
    st_declaracao,
    dt_aceite,
    nr_zona_aceite,
    dt_migracao_cand,
    dt_conclusao,
    st_popula,
    nr_processo_drap,
    st_declaracao_mural,
    nr_partido_incluiu_pedido,
    ts_ultima_alteracao,
    nr_versao_pedido
)
SELECT
    {$cdEleicao} AS cd_eleicao,
    {$nmEleicao} AS nm_eleicao,
    {$tpAbrangencia} AS tp_abrangencia,
    {$nrTurno} AS nr_turno,
    {$dtEleicao} AS dt_eleicao,
    p.sq_pedido,
    p.sg_ue,
    p.cd_cargo,
    p.tp_agremiacao,
    p.tp_pedido,
    p.st_declaracao,
    p.dt_aceite,
    p.nr_zona_aceite,
    p.dt_migracao_cand,
    p.dt_conclusao,
    p.st_popula,
    p.nr_processo_drap,
    p.st_declaracao_mural,
    p.nr_partido_incluiu_pedido,
    p.ts_ultima_alteracao,
    p.nr_versao_pedido
FROM admcandexweb.candex_pedido@{$dblink} p
WHERE p.cd_eleicao = {$cdEleicao}
  AND p.sg_ue in ({$ues})
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlInsercaoCandexwebCandidatos(string $dblink, array $eleicao = []): string
    {
        $eleicao = $this->normalizarEleicao($eleicao);
        $cdEleicao = (string) $eleicao['cd_eleicao'];
        $nmEleicao = $this->literalString($eleicao['nm_eleicao']);
        $tpAbrangencia = $this->literalString($eleicao['tp_abrangencia']);
        $nrTurno = $this->literalNumber($eleicao['nr_turno']);
        $dtEleicao = $this->literalDate($eleicao['dt_eleicao']);
        $ues = $this->listaUesCandexwebSql();
        $cargoNaoPresidencial = $this->condicaoCargoNaoPresidencialSql('c.cd_cargo');

        return <<<SQL
INSERT INTO planeleito.rcand_candexweb_candidatos (
    cd_eleicao,
    nm_eleicao,
    tp_abrangencia,
    nr_turno,
    dt_eleicao,
    sq_candidato,
    sq_pedido,
    sg_ue,
    cd_cargo,
    nr_candidato,
    nm_candidato,
    nm_urna,
    nr_partido,
    st_declaracao,
    st_declaracao_mural,
    st_declaracao_presta_conta,
    st_declaracao_divulgacao,
    nm_social,
    ts_ultima_alteracao,
    nr_versao_candidato
)
SELECT
    {$cdEleicao} AS cd_eleicao,
    {$nmEleicao} AS nm_eleicao,
    {$tpAbrangencia} AS tp_abrangencia,
    {$nrTurno} AS nr_turno,
    {$dtEleicao} AS dt_eleicao,
    c.sq_candidato,
    c.sq_pedido,
    p.sg_ue,
    c.cd_cargo,
    c.nr_candidato,
    c.nm_candidato,
    c.nm_urna,
    c.nr_partido,
    c.st_declaracao,
    c.st_declaracao_mural,
    c.st_declaracao_presta_conta,
    c.st_declaracao_divulgacao,
    c.nm_social,
    c.ts_ultima_alteracao,
    c.nr_versao_candidato
FROM admcandexweb.candex_candidato@{$dblink} c
JOIN admcandexweb.candex_pedido@{$dblink} p
  ON p.cd_eleicao = c.cd_eleicao
 AND p.sq_pedido = c.sq_pedido
WHERE p.cd_eleicao = {$cdEleicao}
  AND p.sg_ue in ({$ues})
  AND {$cargoNaoPresidencial}
SQL;
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlContagemCandexwebPedidos(string $dblink, array $eleicao = []): string
    {
        $sql = preg_replace('/^INSERT INTO planeleito\.rcand_candexweb_pedidos \([\s\S]*?\)\s*SELECT/m', 'SELECT', $this->montarSqlInsercaoCandexwebPedidos($dblink, $eleicao));

        return "SELECT COUNT(*) AS total FROM (\n".$sql."\n)";
    }

    /** @param array<string, mixed> $eleicao */
    public function montarSqlContagemCandexwebCandidatos(string $dblink, array $eleicao = []): string
    {
        $sql = preg_replace('/^INSERT INTO planeleito\.rcand_candexweb_candidatos \([\s\S]*?\)\s*SELECT/m', 'SELECT', $this->montarSqlInsercaoCandexwebCandidatos($dblink, $eleicao));

        return "SELECT COUNT(*) AS total FROM (\n".$sql."\n)";
    }

    public function montarSqlInsercaoConsolidado(): string
    {
        return <<<'SQL'
INSERT INTO planeleito.rcand_consolidado_processos (
    cd_eleicao,
    nm_eleicao,
    tp_abrangencia,
    nr_turno,
    dt_eleicao,
    nr_processo,
    nr_processo_sem_formatacao,
    zona,
    municipio,
    tipo_registro,
    edital,
    certidao_publicacao,
    primeira_diligencia,
    resposta_juntada_diligencia,
    informacao_candidato,
    envio_mpf,
    intimacao_mp_parecer,
    conclusao,
    impugnacoes,
    peticoes_avulsas,
    primeiro_julgamento,
    data_primeiro_recurso,
    contrarrazao,
    remessa_tre,
    recurso,
    teor_julgamento,
    cand_situacao_processo,
    cand_tipo_processo,
    st_existe_pje,
    st_existe_cand,
    st_divergencia,
    julgados_pje_sn,
    sem_int_mpe,
    todas_peticoes_lidas,
    cert_publ_sn,
    cand_processo,
    julgamento_if_cand,
    julgados_cand_sn,
    inform_candidato_sn,
    if_cand_x_pje
)
SELECT
    c.cd_eleicao AS cd_eleicao,
    c.nm_eleicao AS nm_eleicao,
    c.tp_abrangencia AS tp_abrangencia,
    c.nr_turno AS nr_turno,
    c.dt_eleicao AS dt_eleicao,
    COALESCE(p.nr_processo, c.nr_processo) AS nr_processo,
    COALESCE(p.nr_processo_sem_formatacao, c.nr_processo_sem_formatacao) AS nr_processo_sem_formatacao,
    p.zona,
    p.municipio,
    COALESCE(p.tipo_registro, c.tp_processo) AS tipo_registro,
    p.edital,
    p.certidao_publicacao,
    p.primeira_diligencia,
    p.resposta_juntada_diligencia,
    p.informacao_candidato,
    p.envio_mpf,
    p.intimacao_mp_parecer,
    p.conclusao,
    c.impugnacoes AS impugnacoes,
    p.peticoes_avulsas,
    p.primeiro_julgamento,
    p.data_primeiro_recurso,
    p.contrarrazao,
    p.remessa_tre,
    p.recurso,
    p.teor_julgamento,
    c.ds_situacao_processo,
    c.tp_processo,
    CASE WHEN p.nr_processo_sem_formatacao IS NULL THEN 'Não' ELSE 'Sim' END AS st_existe_pje,
    CASE WHEN c.nr_processo_sem_formatacao IS NULL THEN 'Não' ELSE 'Sim' END AS st_existe_cand,
    CASE
        WHEN p.nr_processo_sem_formatacao IS NULL THEN 'Ausente no PJe'
        WHEN c.nr_processo_sem_formatacao IS NULL THEN 'Ausente no CAND'
        WHEN NVL(UPPER(TRIM(p.tipo_registro)), '-') <> NVL(UPPER(TRIM(c.tp_processo)), '-') THEN 'Tipo divergente'
        ELSE 'OK'
    END AS st_divergencia,
    CASE WHEN p.primeiro_julgamento IS NULL THEN 'Não' ELSE 'Sim' END AS julgados_pje_sn,
    CASE WHEN p.intimacao_mp_parecer IS NULL THEN 'Não' ELSE 'Sim' END AS sem_int_mpe,
    CASE WHEN p.peticoes_avulsas IS NULL THEN 'Não' ELSE 'Sim' END AS todas_peticoes_lidas,
    CASE WHEN p.certidao_publicacao IS NULL THEN 'Não' ELSE 'Sim' END AS cert_publ_sn,
    c.nr_processo AS cand_processo,
    CASE WHEN UPPER(TRIM(c.ds_situacao_processo)) = 'AGUARDANDO JULGAMENTO' THEN 2 ELSE 1 END AS julgamento_if_cand,
    CASE WHEN UPPER(TRIM(c.ds_situacao_processo)) = 'AGUARDANDO JULGAMENTO' THEN 'Não' ELSE 'Sim' END AS julgados_cand_sn,
    CASE WHEN p.informacao_candidato IS NULL THEN 'Não' ELSE 'Sim' END AS inform_candidato_sn,
    CASE
        WHEN (CASE WHEN p.primeiro_julgamento IS NULL THEN 'Não' ELSE 'Sim' END) =
             (CASE WHEN UPPER(TRIM(c.ds_situacao_processo)) = 'AGUARDANDO JULGAMENTO' THEN 'Não' ELSE 'Sim' END)
        THEN 'Igual'
        ELSE 'Diferente'
    END AS if_cand_x_pje
FROM planeleito.rcand_pje_processos p
FULL OUTER JOIN planeleito.rcand_cand_processos c
    ON c.nr_processo_sem_formatacao = p.nr_processo_sem_formatacao
SQL;
    }

    /** @return array<int, int> */
    public function codigosEleicao(): array
    {
        $config = config('planeleito.sync.rcand_eleicao_codigos', '');
        $tokens = is_array($config)
            ? $config
            : preg_split('/[,\s;]+/', (string) $config, -1, PREG_SPLIT_NO_EMPTY);

        $codigos = [];
        foreach ($tokens ?: [] as $token) {
            $valor = trim((string) $token);
            if ($valor === '') {
                continue;
            }

            if (! ctype_digit($valor)) {
                throw new RuntimeException('RCAND_ELEICAO_CODIGOS deve conter apenas codigos numericos separados por virgula.');
            }

            $codigos[] = (int) $valor;
        }

        $codigos = array_values(array_unique($codigos));
        if ($codigos !== []) {
            return $codigos;
        }

        return [$this->resolverCodigoEleicao()];
    }

    private function resolverDblink(string $configKey, string $default, string $contexto): string
    {
        $dblink = (string) config("planeleito.sync.{$configKey}", $default);

        if ($dblink === '' || preg_match('/^[A-Za-z0-9_#$.]+$/', $dblink) !== 1) {
            throw new RuntimeException("DBLINK invalido para sincronizacao {$contexto}.");
        }

        return $dblink;
    }

    private function resolverContextoSchema(): string
    {
        $schema = strtolower(trim((string) config('planeleito.sync.rcand_cand_context_schema', 'admcentral')));

        if ($schema === '' || preg_match('/^[a-z][a-z0-9_#]*$/', $schema) !== 1) {
            throw new RuntimeException('Schema do pacote de contexto invalido para sincronizacao RCAND CAND.');
        }

        return $schema;
    }

    /** @return array{cd_eleicao:int,nm_eleicao:?string,tp_abrangencia:?string,nr_turno:?int,dt_eleicao:?string} */
    private function selecionarContextoEleicao(string $contextoSchema, string $dblink, int $codigoEleicao): array
    {
        DB::statement("BEGIN {$contextoSchema}.pc_contexto.set_eleicao@{$dblink}(:codigo); END;", ['codigo' => $codigoEleicao]);

        $linha = DB::selectOne("select {$contextoSchema}.pc_contexto.contexto_info@{$dblink} as info from dual");
        $info = (string) ($linha->info ?? $linha->INFO ?? '');
        $metadados = $this->parseContextoInfo($info);
        $metadados['cd_eleicao'] = $codigoEleicao;

        return $this->normalizarEleicao($metadados);
    }

    /** @return array<string, string> */
    private function parseContextoInfo(string $info): array
    {
        $metadados = [];
        foreach (explode(';', $info) as $parte) {
            $partes = explode('=', $parte, 2);
            if (count($partes) !== 2) {
                continue;
            }

            $chave = strtolower(trim($partes[0]));
            $valor = trim($partes[1]);
            if ($chave !== '' && $valor !== '') {
                $metadados[$chave] = $valor;
            }
        }

        return $metadados;
    }

    /**
     * @param  array<string, mixed>  $eleicao
     * @return array{cd_eleicao:int,nm_eleicao:?string,tp_abrangencia:?string,nr_turno:?int,dt_eleicao:?string}
     */
    private function normalizarEleicao(array $eleicao): array
    {
        $codigo = $eleicao['cd_eleicao'] ?? null;
        if (! is_int($codigo) && (! is_string($codigo) || ! ctype_digit(trim($codigo)))) {
            $codigo = $this->resolverCodigoEleicao();
        }

        $turno = $eleicao['nr_turno'] ?? null;
        $turno = is_int($turno) || (is_string($turno) && ctype_digit(trim($turno))) ? (int) $turno : null;

        $data = trim((string) ($eleicao['dt_eleicao'] ?? ''));
        if (preg_match('/^\d{4}-\d{2}-\d{2}/', $data, $matches) === 1) {
            $data = $matches[0];
        } else {
            $data = '';
        }

        return [
            'cd_eleicao' => (int) $codigo,
            'nm_eleicao' => $this->valorTextoOuNulo($eleicao['nm_eleicao'] ?? null),
            'tp_abrangencia' => $this->valorTextoOuNulo($eleicao['tp_abrangencia'] ?? null),
            'nr_turno' => $turno,
            'dt_eleicao' => $data !== '' ? $data : null,
        ];
    }

    private function resolverCodigoEleicao(): int
    {
        $codigo = trim((string) config('planeleito.sync.rcand_eleicao_codigo', ''));
        if ($codigo === '' || ! ctype_digit($codigo)) {
            throw new RuntimeException('RCAND_ELEICAO_CODIGO deve ser informado para sincronizacao CAND.');
        }

        return (int) $codigo;
    }

    private function literalNumericoConfig(string $configKey, string $default): string
    {
        $valor = trim((string) config("planeleito.sync.{$configKey}", $default));

        return preg_match('/^\d+$/', $valor) === 1 ? $valor : $default;
    }

    private function literalNumber(mixed $valor): string
    {
        if (is_int($valor) || (is_string($valor) && ctype_digit(trim($valor)))) {
            return (string) (int) $valor;
        }

        return 'NULL';
    }

    private function literalString(mixed $valor): string
    {
        $texto = $this->valorTextoOuNulo($valor);
        if ($texto === null) {
            return 'NULL';
        }

        return "'".str_replace("'", "''", $texto)."'";
    }

    private function literalDate(mixed $valor): string
    {
        $data = trim((string) $valor);
        if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $data) !== 1) {
            return 'NULL';
        }

        return "TO_DATE('{$data}', 'YYYY-MM-DD')";
    }

    private function listaUesCandexwebSql(): string
    {
        $ues = array_values(array_unique([$this->literalUfConfig(), 'BR']));

        return implode(', ', array_map(fn (string $ue): string => "'".$ue."'", $ues));
    }

    private function condicaoCargoNaoPresidencialSql(string $coluna): string
    {
        $cargos = implode(', ', array_map(
            static fn (int $cargo): string => (string) $cargo,
            self::CARGOS_PRESIDENCIA
        ));

        return "({$coluna} IS NULL OR {$coluna} NOT IN ({$cargos}))";
    }

    private function literalUfConfig(): string
    {
        $uf = strtoupper(trim((string) config('planeleito.sync.rcand_uf', 'AC')));

        return preg_match('/^[A-Z]{2}$/', $uf) === 1 ? $uf : 'AC';
    }

    private function valorTextoOuNulo(mixed $valor): ?string
    {
        if ($valor === null) {
            return null;
        }

        $texto = trim((string) $valor);

        return $texto !== '' ? $texto : null;
    }

    private function valorPreenchido(mixed $valor): bool
    {
        return $valor !== null && trim((string) $valor) !== '';
    }

    private function situacaoCandAguardandoJulgamento(mixed $valor): bool
    {
        return mb_strtoupper(trim((string) $valor)) === 'AGUARDANDO JULGAMENTO';
    }

    /** @param array<string, mixed> $linha */
    private function normalizarLinhaPje(array $linha): array
    {
        $get = function (string $campo) use ($linha): ?string {
            $valor = $linha[$campo] ?? $linha[strtoupper($campo)] ?? null;
            if ($valor === null) {
                return null;
            }
            $texto = trim((string) $valor);

            return $texto !== '' ? $texto : null;
        };

        return [
            'zona' => $get('zona'),
            'municipio' => $get('municipio'),
            'nr_processo' => $get('nr_processo'),
            'nr_processo_sem_formatacao' => $get('nr_processo_sem_formatacao'),
            'tipo_registro' => $get('tipo_registro'),
            'edital' => $get('edital'),
            'certidao_publicacao' => $get('certidao_publicacao'),
            'primeira_diligencia' => $get('primeira_diligencia'),
            'resposta_juntada_diligencia' => $get('resposta_juntada_diligencia'),
            'informacao_candidato' => $get('informacao_candidato'),
            'envio_mpf' => $get('envio_mpf'),
            'intimacao_mp_parecer' => $get('intimacao_mp_parecer'),
            'conclusao' => $get('conclusao'),
            'impugnacoes' => $get('impugnacoes'),
            'peticoes_avulsas' => $get('peticoes_avulsas'),
            'primeiro_julgamento' => $get('primeiro_julgamento'),
            'data_primeiro_recurso' => $get('data_primeiro_recurso'),
            'contrarrazao' => $get('contrarrazao'),
            'remessa_tre' => $get('remessa_tre'),
            'recurso' => $get('recurso'),
            'teor_julgamento' => $get('teor_julgamento'),
        ];
    }
}
```
</APP_SERVICES_RCAND_RCANDSYNCSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/SeuVotoImporta/SeuVotoImportaAnexoService.php`
## <APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTAANEXOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/SeuVotoImporta/SeuVotoImportaAnexoService.php`
- **Namespace Declaração:** `App\Services\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaAnexoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function salvar(int $solicitacaoId, string $categoria, UploadedFile $arquivo): array
public function preparar(string $categoria, UploadedFile $arquivo): array
public function descartar(array $anexos): void
private function nomeOriginal(UploadedFile $arquivo): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\SeuVotoImporta;

use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use RuntimeException;
use Throwable;

class SeuVotoImportaAnexoService
{
    public function __construct(
        private readonly SeuVotoImportaSolicitacaoRepository $repository,
    ) {
    }

    /** @return array{id:int,caminho:string,scan_status:string} */
    public function salvar(int $solicitacaoId, string $categoria, UploadedFile $arquivo): array
    {
        $dados = $this->preparar($categoria, $arquivo);
        try {
            $dados['SOLICITACAO_ID'] = $solicitacaoId;
            $anexoId = $this->repository->criarAnexo($dados);

            return [
                'id' => $anexoId,
                'caminho' => (string) $dados['CAMINHO'],
                'scan_status' => (string) $dados['SCAN_STATUS'],
            ];
        } catch (Throwable $exception) {
            $this->descartar([$dados]);
            throw $exception;
        }
    }

    /** @return array<string, mixed> */
    public function preparar(string $categoria, UploadedFile $arquivo): array
    {
        if (!in_array($categoria, ['REPRESENTACAO', 'CONDICAO'], true)) {
            throw new RuntimeException('Categoria de anexo inválida.');
        }
        $extensao = match ($arquivo->getMimeType()) {
            'application/pdf' => 'pdf',
            'image/jpeg' => 'jpg',
            'image/png' => 'png',
            default => throw new RuntimeException('Tipo real do anexo não permitido.'),
        };
        $caminho = $arquivo->storeAs(
            'seu-voto-importa/quarentena',
            Str::uuid()->toString().'.'.$extensao,
            'local',
        );
        if (!is_string($caminho) || $caminho === '') {
            throw new RuntimeException('Não foi possível armazenar o anexo privado.');
        }

        try {
            $absoluto = Storage::disk('local')->path($caminho);
            $sha256 = hash_file('sha256', $absoluto);
            if (!is_string($sha256)) {
                throw new RuntimeException('Não foi possível calcular a integridade do anexo.');
            }
            return [
                'CATEGORIA' => $categoria,
                'DISCO' => 'local',
                'CAMINHO' => $caminho,
                'NOME_ORIGINAL' => $this->nomeOriginal($arquivo),
                'MIME' => (string) $arquivo->getMimeType(),
                'TAMANHO_BYTES' => (int) $arquivo->getSize(),
                'SHA256' => $sha256,
                'SCAN_STATUS' => 'PENDENTE',
                'SCANNER' => null,
                'SCANEADO_EM' => null,
            ];
        } catch (Throwable $exception) {
            Storage::disk('local')->delete($caminho);
            throw $exception;
        }
    }

    /** @param array<int, array<string, mixed>> $anexos */
    public function descartar(array $anexos): void
    {
        foreach ($anexos as $anexo) {
            $caminho = trim((string) ($anexo['CAMINHO'] ?? ''));
            if ($caminho !== '') {
                Storage::disk('local')->delete($caminho);
            }
        }
    }

    private function nomeOriginal(UploadedFile $arquivo): string
    {
        $nome = basename(str_replace('\\', '/', $arquivo->getClientOriginalName()));
        $nome = preg_replace('/[\x00-\x1F\x7F]+/u', '', $nome) ?? '';

        return mb_substr($nome !== '' ? $nome : 'anexo', 0, 255, 'UTF-8');
    }
}
```
</APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTAANEXOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/SeuVotoImporta/SeuVotoImportaFluxoStatusService.php`
## <APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTAFLUXOSTATUSSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/SeuVotoImporta/SeuVotoImportaFluxoStatusService.php`
- **Namespace Declaração:** `App\Services\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaFluxoStatusService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function validarSolicitacao(string $atual, string $novo): void
public function validarTurno(string $atual, string $novo): void
private function validar(array $fluxo, string $atual, string $novo, string $tipo): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\SeuVotoImporta;

use DomainException;

class SeuVotoImportaFluxoStatusService
{
    /** @var array<string, list<string>> */
    private const SOLICITACAO = [
        'RECEBIDA' => ['EM_ANALISE', 'CANCELADA'],
        'EM_ANALISE' => ['PENDENCIA', 'DEFERIDA', 'INDEFERIDA', 'CANCELADA'],
        'PENDENCIA' => ['EM_ANALISE', 'DEFERIDA', 'INDEFERIDA', 'CANCELADA'],
        'DEFERIDA' => ['CANCELADA'],
        'INDEFERIDA' => ['EM_ANALISE', 'CANCELADA'],
        'CANCELADA' => [],
    ];

    /** @var array<string, list<string>> */
    private const TURNO = [
        'AGUARDANDO_AGENDAMENTO' => ['AGENDADA', 'CANCELADA'],
        'AGENDADA' => ['AGUARDANDO_AGENDAMENTO', 'CONCLUIDA', 'CANCELADA'],
        'CONCLUIDA' => [],
        'CANCELADA' => ['AGUARDANDO_AGENDAMENTO'],
    ];

    public function validarSolicitacao(string $atual, string $novo): void
    {
        $this->validar(self::SOLICITACAO, $atual, $novo, 'solicitação');
    }

    public function validarTurno(string $atual, string $novo): void
    {
        $this->validar(self::TURNO, $atual, $novo, 'turno');
    }

    /**
     * @param array<string, list<string>> $fluxo
     */
    private function validar(array $fluxo, string $atual, string $novo, string $tipo): void
    {
        $atual = mb_strtoupper(trim($atual), 'UTF-8');
        $novo = mb_strtoupper(trim($novo), 'UTF-8');

        if (!array_key_exists($atual, $fluxo) || !in_array($novo, $fluxo[$atual], true)) {
            throw new DomainException("Transição de {$tipo} não permitida.");
        }
    }
}
```
</APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTAFLUXOSTATUSSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/SeuVotoImporta/SeuVotoImportaIdentificacaoService.php`
## <APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTAIDENTIFICACAOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/SeuVotoImporta/SeuVotoImportaIdentificacaoService.php`
- **Namespace Declaração:** `App\Services\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaIdentificacaoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function iniciar(Request $request, string $titulo, string $dataNascimento): ?array
public function contexto(Request $request): ?array
public function encerrar(Request $request): void
public function identificarRepresentante(
private function ehRioBranco(string $municipio): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\SeuVotoImporta;

use App\Repositories\SeuVotoImporta\SeuVotoImportaEleitorRepository;
use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use Carbon\CarbonImmutable;
use Illuminate\Http\Request;

class SeuVotoImportaIdentificacaoService
{
    private const SESSION_KEY = 'seu_voto_importa_identificacao';

    public function __construct(
        private readonly SeuVotoImportaEleitorRepository $eleitores,
        private readonly SeuVotoImportaSolicitacaoRepository $solicitacoes,
    ) {
    }

    /** @return array<string, mixed>|null */
    public function iniciar(Request $request, string $titulo, string $dataNascimento): ?array
    {
        $configuracao = $this->solicitacoes->buscarConfiguracaoAberta();
        $eleitor = $configuracao !== null
            ? $this->eleitores->buscarPorTituloNascimento($titulo, $dataNascimento)
            : null;

        if ($configuracao === null
            || $eleitor === null
            || !$this->ehRioBranco((string) ($eleitor['municipio_nome'] ?? ''))) {
            $request->session()->forget(self::SESSION_KEY);
            return null;
        }

        $data = CarbonImmutable::parse((string) $eleitor['dt_nascimento']);
        $contexto = [
            'num_inscricao' => (string) $eleitor['num_inscricao'],
            'nome' => (string) $eleitor['nome'],
            'dt_nascimento' => $data->format('Y-m-d'),
            'idade' => $data->age,
            'zona_numero' => (int) $eleitor['zona_numero'],
            'secao_numero' => (string) $eleitor['secao_numero'],
            'local_cod_objeto' => (string) $eleitor['local_cod_objeto'],
            'local_numero' => $eleitor['local_numero'] ?? null,
            'local_nome' => (string) $eleitor['local_nome'],
            'local_endereco' => (string) ($eleitor['local_endereco'] ?? ''),
            'municipio_nome' => (string) $eleitor['municipio_nome'],
            'configuracao_id' => (int) $configuracao['id'],
            'macroprojeto_id' => (int) $configuracao['macroprojeto_id'],
            'aviso_privacidade' => (string) $configuracao['aviso_privacidade'],
            'dt_primeiro_turno' => (string) ($configuracao['dt_primeiro_turno'] ?? ''),
            'dt_segundo_turno' => isset($configuracao['dt_segundo_turno'])
                ? (string) $configuracao['dt_segundo_turno']
                : null,
            'segundo_turno_confirmado' => ($configuracao['segundo_turno_confirmado'] ?? false) === true,
            'expira_em' => CarbonImmutable::now()->addMinutes(30)->toIso8601String(),
        ];

        $request->session()->regenerate();
        $request->session()->put(self::SESSION_KEY, $contexto);

        return $contexto;
    }

    /** @return array<string, mixed>|null */
    public function contexto(Request $request): ?array
    {
        $contexto = $request->session()->get(self::SESSION_KEY);
        if (!is_array($contexto)) {
            return null;
        }

        try {
            if (!CarbonImmutable::parse((string) ($contexto['expira_em'] ?? ''))->isFuture()) {
                $request->session()->forget(self::SESSION_KEY);
                return null;
            }
        } catch (\Throwable) {
            $request->session()->forget(self::SESSION_KEY);
            return null;
        }

        return $contexto;
    }

    public function encerrar(Request $request): void
    {
        $request->session()->forget(self::SESSION_KEY);
    }

    /** @return array{nome:string}|null */
    public function identificarRepresentante(
        Request $request,
        string $titulo,
        string $dataNascimento,
    ): ?array {
        if ($this->contexto($request) === null) {
            return null;
        }

        $nome = $this->eleitores->buscarNomePorTituloNascimento($titulo, $dataNascimento);

        return $nome === null ? null : ['nome' => $nome];
    }

    private function ehRioBranco(string $municipio): bool
    {
        $normalizado = iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', mb_strtoupper(trim($municipio), 'UTF-8'));

        return trim((string) $normalizado) === 'RIO BRANCO';
    }
}
```
</APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTAIDENTIFICACAOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/SeuVotoImporta/SeuVotoImportaSessionService.php`
## <APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTASESSIONSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/SeuVotoImporta/SeuVotoImportaSessionService.php`
- **Namespace Declaração:** `App\Services\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaSessionService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function iniciar(Request $request, int $solicitacaoId): void
public function autenticado(Request $request): bool
public function tocar(Request $request): void
public function solicitacaoId(Request $request): ?int
public function encerrar(Request $request): void
private function dados(Request $request): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\SeuVotoImporta;

use Carbon\CarbonImmutable;
use Illuminate\Http\Request;
use Throwable;

class SeuVotoImportaSessionService
{
    private const SESSION_KEY = 'seu_voto_importa_publico';
    private const INATIVIDADE_MINUTOS = 30;
    private const DURACAO_ABSOLUTA_MINUTOS = 120;

    public function iniciar(Request $request, int $solicitacaoId): void
    {
        if ($solicitacaoId <= 0) {
            throw new \InvalidArgumentException('Solicitação inválida para a sessão pública.');
        }

        $request->session()->regenerate();
        $agora = CarbonImmutable::now();
        $request->session()->put(self::SESSION_KEY, [
            'solicitacao_id' => $solicitacaoId,
            'iniciada_em' => $agora->toIso8601String(),
            'ultima_atividade_em' => $agora->toIso8601String(),
        ]);
    }

    public function autenticado(Request $request): bool
    {
        $dados = $this->dados($request);
        if ((int) ($dados['solicitacao_id'] ?? 0) <= 0) {
            return false;
        }

        try {
            $agora = CarbonImmutable::now();
            $inicio = CarbonImmutable::parse((string) ($dados['iniciada_em'] ?? ''));
            $ultimaAtividade = CarbonImmutable::parse((string) ($dados['ultima_atividade_em'] ?? ''));

            return $agora->lessThanOrEqualTo($inicio->addMinutes(self::DURACAO_ABSOLUTA_MINUTOS))
                && $agora->lessThanOrEqualTo($ultimaAtividade->addMinutes(self::INATIVIDADE_MINUTOS));
        } catch (Throwable) {
            return false;
        }
    }

    public function tocar(Request $request): void
    {
        if (!$this->autenticado($request)) {
            return;
        }

        $dados = $this->dados($request);
        $dados['ultima_atividade_em'] = CarbonImmutable::now()->toIso8601String();
        $request->session()->put(self::SESSION_KEY, $dados);
    }

    public function solicitacaoId(Request $request): ?int
    {
        $id = (int) ($this->dados($request)['solicitacao_id'] ?? 0);

        return $id > 0 ? $id : null;
    }

    public function encerrar(Request $request): void
    {
        $request->session()->forget(self::SESSION_KEY);
        $request->session()->invalidate();
        $request->session()->regenerateToken();
    }

    /** @return array<string, mixed> */
    private function dados(Request $request): array
    {
        $dados = $request->session()->get(self::SESSION_KEY, []);

        return is_array($dados) ? $dados : [];
    }
}
```
</APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTASESSIONSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/SeuVotoImporta/SeuVotoImportaSolicitacaoService.php`
## <APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTASOLICITACAOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/SeuVotoImporta/SeuVotoImportaSolicitacaoService.php`
- **Namespace Declaração:** `App\Services\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaSolicitacaoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly SeuVotoImportaSolicitacaoRepository $repository)
public function criar(array $contexto, array $dados, array $anexos = []): array
private function payload(array $contexto, array $dados, string $protocolo): array
private function opcional(mixed $valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\SeuVotoImporta;

use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use Illuminate\Database\QueryException;

class SeuVotoImportaSolicitacaoService
{
    public function __construct(private readonly SeuVotoImportaSolicitacaoRepository $repository)
    {
    }

    /**
     * @param array<string, mixed> $contexto
     * @param array<string, mixed> $dados
     * @param array<int, array<string, mixed>> $anexos
     * @return array{id:int,protocolo:?string,duplicada:bool}
     */
    public function criar(array $contexto, array $dados, array $anexos = []): array
    {
        $macroprojetoId = (int) ($contexto['macroprojeto_id'] ?? 0);
        $titulo = (string) ($contexto['num_inscricao'] ?? '');
        $existente = $this->repository->buscarPorMacroTitulo($macroprojetoId, $titulo);
        if ($existente !== null) {
            return [
                'id' => (int) $existente['id'],
                'protocolo' => null,
                'duplicada' => true,
            ];
        }

        $ano = (int) substr((string) ($contexto['dt_primeiro_turno'] ?? date('Y')), 0, 4);
        $ano = $ano >= 2000 ? $ano : (int) date('Y');
        $protocolo = 'SVI-'.$ano.'-'.strtoupper(bin2hex(random_bytes(6)));
        $payload = $this->payload($contexto, $dados, $protocolo);
        $turnos = [[
            'NUMERO_TURNO' => 1,
            'STATUS_CODIGO' => 'AGUARDANDO_AGENDAMENTO',
            'DATA_VOTACAO' => (string) $contexto['dt_primeiro_turno'],
        ]];

        if (($contexto['segundo_turno_confirmado'] ?? false) === true
            && ($dados['segundo_turno_codigo'] ?? null) === 'SIM'
            && trim((string) ($contexto['dt_segundo_turno'] ?? '')) !== '') {
            $turnos[] = [
                'NUMERO_TURNO' => 2,
                'STATUS_CODIGO' => 'AGUARDANDO_AGENDAMENTO',
                'DATA_VOTACAO' => (string) $contexto['dt_segundo_turno'],
            ];
        }

        try {
            $id = $this->repository->criarCompleta(
                $payload,
                array_values((array) $dados['condicoes']),
                array_values((array) $dados['equipamentos']),
                $turnos,
                $anexos,
            );
        } catch (QueryException $exception) {
            $existente = $this->repository->buscarPorMacroTitulo($macroprojetoId, $titulo);
            if ($existente === null) {
                throw $exception;
            }

            return [
                'id' => (int) $existente['id'],
                'protocolo' => null,
                'duplicada' => true,
            ];
        }

        return ['id' => $id, 'protocolo' => $protocolo, 'duplicada' => false];
    }

    /** @param array<string, mixed> $contexto @param array<string, mixed> $dados @return array<string, mixed> */
    private function payload(array $contexto, array $dados, string $protocolo): array
    {
        $representante = ($dados['solicitante_tipo_codigo'] ?? 'ELEITOR') !== 'ELEITOR';
        $enderecoAlternativo = ($dados['veiculo_acessa_codigo'] ?? null) === 'NAO';
        $condicaoDetalhada = in_array('MOBILIDADE_REDUZIDA', (array) ($dados['condicoes'] ?? []), true);
        $equipamentoOutro = in_array('OUTRO', (array) ($dados['equipamentos'] ?? []), true);
        $acompanhante = ($dados['acompanhante_codigo'] ?? null) === 'SIM';

        return [
            'PROTOCOLO' => $protocolo,
            'MACROPROJETO_ID' => (int) $contexto['macroprojeto_id'],
            'CONFIGURACAO_ID' => (int) $contexto['configuracao_id'],
            'NUM_INSCRICAO' => (string) $contexto['num_inscricao'],
            'ELEITOR_NOME' => (string) $contexto['nome'],
            'DT_NASCIMENTO' => (string) $contexto['dt_nascimento'],
            'IDADE' => (int) $contexto['idade'],
            'ZONA_NUMERO' => (int) $contexto['zona_numero'],
            'SECAO_NUMERO' => (string) $contexto['secao_numero'],
            'LOCAL_COD_OBJETO' => (string) $contexto['local_cod_objeto'],
            'LOCAL_NUMERO' => $contexto['local_numero'] ?? null,
            'LOCAL_NOME' => (string) $contexto['local_nome'],
            'LOCAL_ENDERECO' => $this->opcional($contexto['local_endereco'] ?? null),
            'MUNICIPIO_NOME' => (string) $contexto['municipio_nome'],
            'SOLICITANTE_TIPO_CODIGO' => (string) $dados['solicitante_tipo_codigo'],
            'SOLICITANTE_NOME' => $representante ? $this->opcional($dados['solicitante_nome'] ?? null) : null,
            'SOLICITANTE_TITULO' => $representante ? $this->opcional($dados['solicitante_titulo'] ?? null) : null,
            'SOLICITANTE_TELEFONE' => $representante ? $this->opcional($dados['solicitante_telefone'] ?? null) : null,
            'ELEITOR_TELEFONE' => (string) $dados['eleitor_telefone'],
            'ELEITOR_EMAIL' => null,
            'CONTATO_PREFERENCIA_CODIGO' => (string) $dados['contato_preferencia_codigo'],
            'ENDERECO_LOGRADOURO' => trim((string) $dados['endereco_logradouro']),
            'ENDERECO_NUMERO' => trim((string) $dados['endereco_numero']),
            'ENDERECO_BAIRRO' => trim((string) $dados['endereco_bairro']),
            'ENDERECO_MUNICIPIO' => 'RIO BRANCO',
            'ENDERECO_REFERENCIA' => $this->opcional($dados['endereco_referencia'] ?? null),
            'VEICULO_ACESSA_CODIGO' => (string) $dados['veiculo_acessa_codigo'],
            'ENDERECO_ALTERNATIVO' => null,
            'END_ALT_LOGRADOURO' => $enderecoAlternativo ? $this->opcional($dados['endereco_alt_logradouro'] ?? null) : null,
            'END_ALT_NUMERO' => $enderecoAlternativo ? $this->opcional($dados['endereco_alt_numero'] ?? null) : null,
            'END_ALT_BAIRRO' => $enderecoAlternativo ? $this->opcional($dados['endereco_alt_bairro'] ?? null) : null,
            'END_ALT_REFERENCIA' => $enderecoAlternativo ? $this->opcional($dados['endereco_alt_referencia'] ?? null) : null,
            'CONDICAO_DESCRICAO' => $condicaoDetalhada ? $this->opcional($dados['condicao_descricao'] ?? null) : null,
            'COMPROVACAO_TIPO_CODIGO' => (string) $dados['comprovacao_tipo_codigo'],
            'AUTODECLARACAO_TEXTO' => null,
            'IMPACTO_CODIGO' => (string) $dados['impacto_codigo'],
            'IMPACTO_DESCRICAO' => $this->opcional($dados['impacto_descricao'] ?? null),
            'EQUIPAMENTO_OUTRO' => $equipamentoOutro ? $this->opcional($dados['equipamento_outro'] ?? null) : null,
            'TRANSPORTE_PUBLICO_CODIGO' => (string) $dados['transporte_publico_codigo'],
            'ACOMPANHANTE_CODIGO' => (string) $dados['acompanhante_codigo'],
            'ACOMPANHANTE_NOME' => $acompanhante ? $this->opcional($dados['acompanhante_nome'] ?? null) : null,
            'ACOMPANHANTE_TELEFONE' => $acompanhante ? $this->opcional($dados['acompanhante_telefone'] ?? null) : null,
            'SEGUNDO_TURNO_CODIGO' => (string) $dados['segundo_turno_codigo'],
            'OBSERVACOES' => $this->opcional($dados['observacoes'] ?? null),
            'STATUS_CODIGO' => 'RECEBIDA',
            'DECLARACAO_ESPERA' => 1,
            'DECLARACAO_SEM_TRANSPORTE' => 1,
            'DECLARACAO_ANALISE' => 1,
            'DECLARACAO_SEM_AJUDANTE' => 1,
            'DECLARACAO_COMPARTILHADO' => 1,
            'DECLARACAO_HORARIO' => 1,
            'DECLARACAO_PRIVACIDADE' => 1,
            'VERSAO' => 1,
        ];
    }

    private function opcional(mixed $valor): ?string
    {
        $valor = trim((string) $valor);

        return $valor !== '' ? $valor : null;
    }
}
```
</APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTASOLICITACAOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/SeuVotoImporta/SeuVotoImportaTurnstileService.php`
## <APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTATURNSTILESERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/SeuVotoImporta/SeuVotoImportaTurnstileService.php`
- **Namespace Declaração:** `App\Services\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaTurnstileService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(?TurnstileService $turnstile = null)
public function configurado(): bool
public function validar(string $token, string $acao, ?string $ip): bool
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\SeuVotoImporta;

use App\Services\Acesso\TurnstileService;

class SeuVotoImportaTurnstileService
{
    private TurnstileService $turnstile;

    public function __construct(?TurnstileService $turnstile = null)
    {
        $this->turnstile = $turnstile ?? new TurnstileService;
    }

    public function configurado(): bool
    {
        return $this->turnstile->configurado('planeleito.seu_voto_importa.turnstile');
    }

    public function validar(string $token, string $acao, ?string $ip): bool
    {
        return $this->turnstile->validar(
            'planeleito.seu_voto_importa.turnstile',
            $token,
            $acao,
            $ip,
            'seu-voto-importa',
        );
    }
}
```
</APP_SERVICES_SEUVOTOIMPORTA_SEUVOTOIMPORTATURNSTILESERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Rcand/RcandImpugnacao.php`
## <APP_SUPPORT_RCAND_RCANDIMPUGNACAO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Rcand/RcandImpugnacao.php`
- **Namespace Declaração:** `App\Support\Rcand`
- **Entidade / Classe:** `final class RcandImpugnacao`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function todos(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Rcand;

final class RcandImpugnacao
{
    public const SIM = 'Sim';

    public const NAO = 'Não';

    /** @return array<int, string> */
    public static function todos(): array
    {
        return [self::SIM, self::NAO];
    }
}
```
</APP_SUPPORT_RCAND_RCANDIMPUGNACAO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Rcand/RcandVisaoCand.php`
## <APP_SUPPORT_RCAND_RCANDVISAOCAND_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Rcand/RcandVisaoCand.php`
- **Namespace Declaração:** `App\Support\Rcand`
- **Entidade / Classe:** `final class RcandVisaoCand`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function opcoes(): array
public static function todos(): array
public static function resolver(?string $visao): string
public static function rotulo(string $visao): string
public static function pageName(string $visao): string
private static function opcao(string $visao): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Rcand;

use InvalidArgumentException;

final class RcandVisaoCand
{
    public const PROCESSOS = 'processos';

    public const COMPARACAO = 'comparacao';

    public const PEDIDOS = 'pedidos';

    public const CANDIDATOS = 'candidatos';

    public const PADRAO = self::PROCESSOS;

    /** @return array<string, array{rotulo:string,page_name:string}> */
    public static function opcoes(): array
    {
        return [
            self::PROCESSOS => [
                'rotulo' => 'Processos CAND',
                'page_name' => 'cand_page',
            ],
            self::COMPARACAO => [
                'rotulo' => 'Comparação CAND × PJe',
                'page_name' => 'page',
            ],
            self::PEDIDOS => [
                'rotulo' => 'Pré-registros CANDEXWEB',
                'page_name' => 'candexweb_pedidos_page',
            ],
            self::CANDIDATOS => [
                'rotulo' => 'Candidatos CANDEXWEB',
                'page_name' => 'candexweb_candidatos_page',
            ],
        ];
    }

    /** @return array<int, string> */
    public static function todos(): array
    {
        return array_keys(self::opcoes());
    }

    public static function resolver(?string $visao): string
    {
        if ($visao === null || $visao === '') {
            return self::PADRAO;
        }

        if (! in_array($visao, self::todos(), true)) {
            throw new InvalidArgumentException('Visualização CAND inválida.');
        }

        return $visao;
    }

    public static function rotulo(string $visao): string
    {
        return self::opcao($visao)['rotulo'];
    }

    public static function pageName(string $visao): string
    {
        return self::opcao($visao)['page_name'];
    }

    /** @return array{rotulo:string,page_name:string} */
    private static function opcao(string $visao): array
    {
        return self::opcoes()[$visao]
            ?? throw new InvalidArgumentException('Visualização CAND inválida.');
    }
}
```
</APP_SUPPORT_RCAND_RCANDVISAOCAND_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/SeuVotoImporta/SeuVotoImportaDominios.php`
## <APP_SUPPORT_SEUVOTOIMPORTA_SEUVOTOIMPORTADOMINIOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/SeuVotoImporta/SeuVotoImportaDominios.php`
- **Namespace Declaração:** `App\Support\SeuVotoImporta`
- **Entidade / Classe:** `final class SeuVotoImportaDominios`

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

namespace App\Support\SeuVotoImporta;

final class SeuVotoImportaDominios
{
    public const SOLICITANTES = ['ELEITOR', 'CURADOR', 'APOIADOR', 'PROCURADOR'];
    public const CONTATOS = ['WHATSAPP', 'LIGACAO', 'SMS'];
    public const OPCOES = ['SIM', 'NAO'];
    public const CONDICOES = [
        'FISICA', 'VISUAL', 'AUDITIVA', 'INTELECTUAL', 'MULTIPLA', 'TEA', 'MOBILIDADE_REDUZIDA',
    ];
    public const IMPACTOS = ['DIFICULTA', 'IMPEDE'];
    public const EQUIPAMENTOS = [
        'CADEIRA_MANUAL', 'CADEIRA_MOTORIZADA', 'ANDADOR', 'MULETAS', 'BENGALA',
        'PROTESE', 'OXIGENIO', 'CAO_GUIA', 'OUTRO', 'NENHUM',
    ];
    public const TRANSPORTE_PUBLICO = ['SIM', 'NAO', 'NAO_SABE'];
    public const COMPROVACOES = ['AUTODECLARACAO', 'ANEXO'];
    public const SOLICITACAO_STATUS = [
        'RECEBIDA', 'EM_ANALISE', 'PENDENCIA', 'DEFERIDA', 'INDEFERIDA', 'CANCELADA',
    ];
    public const TURNO_STATUS = [
        'AGUARDANDO_AGENDAMENTO', 'AGENDADA', 'CONCLUIDA', 'CANCELADA',
    ];
}
```
</APP_SUPPORT_SEUVOTOIMPORTA_SEUVOTOIMPORTADOMINIOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/SeuVotoImporta/SeuVotoImportaMascarador.php`
## <APP_SUPPORT_SEUVOTOIMPORTA_SEUVOTOIMPORTAMASCARADOR_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/SeuVotoImporta/SeuVotoImportaMascarador.php`
- **Namespace Declaração:** `App\Support\SeuVotoImporta`
- **Entidade / Classe:** `class SeuVotoImportaMascarador`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function titulo(?string $titulo): string
public function email(?string $email): string
public function telefone(?string $telefone): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\SeuVotoImporta;

class SeuVotoImportaMascarador
{
    public function titulo(?string $titulo): string
    {
        $digitos = preg_replace('/\D+/', '', (string) $titulo) ?? '';

        return $digitos === '' ? '' : str_repeat('*', max(0, strlen($digitos) - 4)).substr($digitos, -4);
    }

    public function email(?string $email): string
    {
        $email = trim((string) $email);
        if (!str_contains($email, '@')) {
            return '';
        }

        [$local, $dominio] = explode('@', $email, 2);
        $visivel = mb_substr($local, 0, min(2, mb_strlen($local)), 'UTF-8');

        return $visivel.'***@'.$dominio;
    }

    public function telefone(?string $telefone): string
    {
        $digitos = preg_replace('/\D+/', '', (string) $telefone) ?? '';
        if (strlen($digitos) < 4) {
            return '';
        }

        return '('.substr($digitos, 0, 2).') *****-**'.substr($digitos, -2);
    }
}
```
</APP_SUPPORT_SEUVOTOIMPORTA_SEUVOTOIMPORTAMASCARADOR_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `bootstrap/providers.php`
## <BOOTSTRAP_PROVIDERS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `bootstrap/providers.php`
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
<?php

return [
    App\Providers\AppServiceProvider::class,
];
```
</BOOTSTRAP_PROVIDERS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_09_110000_create_rcand_sync_tables.php`
## <DATABASE_MIGRATIONS_2026_07_09_110000_CREATE_RCAND_SYNC_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_09_110000_create_rcand_sync_tables.php`
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
CREATE TABLE rcand_pje_processos (
    id_rcand_pje_processo       NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    dt_carga                    DATE DEFAULT SYSDATE NOT NULL,
    zona                        VARCHAR2(20 CHAR),
    municipio                   VARCHAR2(150 CHAR),
    nr_processo                 VARCHAR2(40 CHAR),
    nr_processo_sem_formatacao  VARCHAR2(40 CHAR),
    tipo_registro               VARCHAR2(20 CHAR),
    edital                      VARCHAR2(20 CHAR),
    certidao_publicacao         VARCHAR2(20 CHAR),
    primeira_diligencia         VARCHAR2(20 CHAR),
    resposta_juntada_diligencia VARCHAR2(20 CHAR),
    informacao_candidato        VARCHAR2(10 CHAR),
    intimacao_mp_parecer        VARCHAR2(20 CHAR),
    conclusao                   VARCHAR2(120 CHAR),
    impugnacoes                 VARCHAR2(20 CHAR),
    peticoes_avulsas            VARCHAR2(1000 CHAR),
    primeiro_julgamento         VARCHAR2(20 CHAR),
    data_primeiro_recurso       VARCHAR2(20 CHAR),
    contrarrazao                VARCHAR2(20 CHAR),
    remessa_tre                 VARCHAR2(20 CHAR),
    recurso                     VARCHAR2(120 CHAR),
    teor_julgamento             VARCHAR2(500 CHAR)
)
SQL);
        DB::statement('CREATE INDEX ix_rcand_pje_proc ON rcand_pje_processos (nr_processo_sem_formatacao)');
        DB::statement('CREATE INDEX ix_rcand_pje_zona ON rcand_pje_processos (zona)');
        DB::statement('CREATE INDEX ix_rcand_pje_tipo ON rcand_pje_processos (tipo_registro)');

        DB::statement(<<<'SQL'
CREATE TABLE rcand_cand_processos (
    id_rcand_cand_processo      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    dt_carga                    DATE DEFAULT SYSDATE NOT NULL,
    nr_processo                 VARCHAR2(40 CHAR),
    nr_processo_sem_formatacao  VARCHAR2(40 CHAR),
    ds_situacao_processo        VARCHAR2(120 CHAR),
    tp_processo                 VARCHAR2(20 CHAR)
)
SQL);
        DB::statement('CREATE INDEX ix_rcand_cand_proc ON rcand_cand_processos (nr_processo_sem_formatacao)');
        DB::statement('CREATE INDEX ix_rcand_cand_tipo ON rcand_cand_processos (tp_processo)');

        DB::statement(<<<'SQL'
CREATE TABLE rcand_consolidado_processos (
    id_rcand_consolidado        NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    dt_carga                    DATE DEFAULT SYSDATE NOT NULL,
    nr_processo                 VARCHAR2(40 CHAR),
    nr_processo_sem_formatacao  VARCHAR2(40 CHAR),
    zona                        VARCHAR2(20 CHAR),
    municipio                   VARCHAR2(150 CHAR),
    tipo_registro               VARCHAR2(20 CHAR),
    edital                      VARCHAR2(20 CHAR),
    certidao_publicacao         VARCHAR2(20 CHAR),
    primeira_diligencia         VARCHAR2(20 CHAR),
    resposta_juntada_diligencia VARCHAR2(20 CHAR),
    informacao_candidato        VARCHAR2(10 CHAR),
    intimacao_mp_parecer        VARCHAR2(20 CHAR),
    conclusao                   VARCHAR2(120 CHAR),
    impugnacoes                 VARCHAR2(20 CHAR),
    peticoes_avulsas            VARCHAR2(1000 CHAR),
    primeiro_julgamento         VARCHAR2(20 CHAR),
    data_primeiro_recurso       VARCHAR2(20 CHAR),
    contrarrazao                VARCHAR2(20 CHAR),
    remessa_tre                 VARCHAR2(20 CHAR),
    recurso                     VARCHAR2(120 CHAR),
    teor_julgamento             VARCHAR2(500 CHAR),
    cand_situacao_processo      VARCHAR2(120 CHAR),
    cand_tipo_processo          VARCHAR2(20 CHAR),
    st_existe_pje               VARCHAR2(10 CHAR),
    st_existe_cand              VARCHAR2(10 CHAR),
    st_divergencia              VARCHAR2(80 CHAR)
)
SQL);
        DB::statement('CREATE INDEX ix_rcand_cons_proc ON rcand_consolidado_processos (nr_processo_sem_formatacao)');
        DB::statement('CREATE INDEX ix_rcand_cons_zona ON rcand_consolidado_processos (zona)');
        DB::statement('CREATE INDEX ix_rcand_cons_tipo ON rcand_consolidado_processos (tipo_registro)');
        DB::statement('CREATE INDEX ix_rcand_cons_div ON rcand_consolidado_processos (st_divergencia)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_rcand_cons_div');
        DB::statement('DROP INDEX ix_rcand_cons_tipo');
        DB::statement('DROP INDEX ix_rcand_cons_zona');
        DB::statement('DROP INDEX ix_rcand_cons_proc');
        DB::statement('DROP TABLE rcand_consolidado_processos');

        DB::statement('DROP INDEX ix_rcand_cand_tipo');
        DB::statement('DROP INDEX ix_rcand_cand_proc');
        DB::statement('DROP TABLE rcand_cand_processos');

        DB::statement('DROP INDEX ix_rcand_pje_tipo');
        DB::statement('DROP INDEX ix_rcand_pje_zona');
        DB::statement('DROP INDEX ix_rcand_pje_proc');
        DB::statement('DROP TABLE rcand_pje_processos');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_09_110000_CREATE_RCAND_SYNC_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_09_130000_add_pbit_calculated_fields_to_rcand_tables.php`
## <DATABASE_MIGRATIONS_2026_07_09_130000_ADD_PBIT_CALCULATED_FIELDS_TO_RCAND_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_09_130000_add_pbit_calculated_fields_to_rcand_tables.php`
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
ALTER TABLE rcand_consolidado_processos ADD (
    julgados_pje_sn        VARCHAR2(10 CHAR),
    sem_int_mpe            VARCHAR2(10 CHAR),
    todas_peticoes_lidas   VARCHAR2(10 CHAR),
    cert_publ_sn           VARCHAR2(10 CHAR),
    cand_processo          VARCHAR2(40 CHAR),
    julgamento_if_cand     NUMBER(1),
    julgados_cand_sn       VARCHAR2(10 CHAR),
    inform_candidato_sn    VARCHAR2(10 CHAR),
    if_cand_x_pje          VARCHAR2(20 CHAR)
)
SQL);

        DB::statement('CREATE INDEX ix_rcand_cons_jpje ON rcand_consolidado_processos (julgados_pje_sn)');
        DB::statement('CREATE INDEX ix_rcand_cons_cert ON rcand_consolidado_processos (cert_publ_sn)');
        DB::statement('CREATE INDEX ix_rcand_cons_info ON rcand_consolidado_processos (inform_candidato_sn)');
        DB::statement('CREATE INDEX ix_rcand_cons_ifcpje ON rcand_consolidado_processos (if_cand_x_pje)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_rcand_cons_ifcpje');
        DB::statement('DROP INDEX ix_rcand_cons_info');
        DB::statement('DROP INDEX ix_rcand_cons_cert');
        DB::statement('DROP INDEX ix_rcand_cons_jpje');

        foreach ([
            'if_cand_x_pje',
            'inform_candidato_sn',
            'julgados_cand_sn',
            'julgamento_if_cand',
            'cand_processo',
            'cert_publ_sn',
            'todas_peticoes_lidas',
            'sem_int_mpe',
            'julgados_pje_sn',
        ] as $coluna) {
            DB::statement("ALTER TABLE rcand_consolidado_processos DROP COLUMN {$coluna}");
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_07_09_130000_ADD_PBIT_CALCULATED_FIELDS_TO_RCAND_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_10_120000_create_gel_ac_sync_tables.php`
## <DATABASE_MIGRATIONS_2026_07_10_120000_CREATE_GEL_AC_SYNC_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_10_120000_create_gel_ac_sync_tables.php`
- **Namespace Declaração:** ``
- **Entidade / Classe:** `return new class extends Migration`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return (int) DB::table('user_tables')->where('table_name', strtoupper($table))->count() > 0;
return (int) DB::table('user_indexes')->where('index_name', strtoupper($index))->count() > 0;
return (int) DB::table('user_views')->where('view_name', strtoupper($view))->count() > 0;
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function up(): void
public function down(): void
private function viewSql(): string
private function createTableIfMissing(string $table, string $sql): void
private function createIndexIfMissing(string $index, string $sql): void
private function dropTableIfExists(string $table): void
private function dropViewIfExists(string $view): void
private function tableExists(string $table): bool
private function indexExists(string $index): bool
private function viewExists(string $view): bool
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
        $this->createTableIfMissing('GEL_FORMULARIO', <<<'SQL'
CREATE TABLE gel_formulario (
    sq_formulario NUMBER(3, 0) NOT NULL,
    cd_uf NUMBER(2, 0),
    ds_descricao VARCHAR2(200 CHAR),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_formulario PRIMARY KEY (sq_formulario)
)
SQL);

        $this->createTableIfMissing('GEL_CATEGORIA', <<<'SQL'
CREATE TABLE gel_categoria (
    cod_categoria NUMBER(19, 0) NOT NULL,
    cod_objeto VARCHAR2(255 CHAR),
    nom_categoria VARCHAR2(255 CHAR),
    seq_categoria NUMBER(10, 0) NOT NULL,
    txt_orientacao VARCHAR2(1000 CHAR),
    seq_formulario NUMBER(3, 0),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_categoria PRIMARY KEY (cod_categoria)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_CAT_FORM', 'CREATE INDEX ix_gel_cat_form ON gel_categoria (seq_formulario)');

        $this->createTableIfMissing('GEL_QUESTION', <<<'SQL'
CREATE TABLE gel_question (
    cod_question NUMBER(19, 0) NOT NULL,
    cod_objeto VARCHAR2(255 CHAR),
    des_question VARCHAR2(255 CHAR),
    seq_question NUMBER(10, 0) NOT NULL,
    tip_question VARCHAR2(255 CHAR),
    txt_question VARCHAR2(255 CHAR),
    ind_categoria NUMBER(19, 0),
    txt_orientacao VARCHAR2(1000 CHAR),
    bol_required NUMBER(1, 0),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_question PRIMARY KEY (cod_question)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_QUES_CAT', 'CREATE INDEX ix_gel_ques_cat ON gel_question (ind_categoria)');

        $this->createTableIfMissing('GEL_QUESTION_OPTION', <<<'SQL'
CREATE TABLE gel_question_option (
    cod_question_option NUMBER(19, 0) NOT NULL,
    cod_objeto VARCHAR2(255 CHAR),
    des_question_option VARCHAR2(255 CHAR),
    seq_question_option NUMBER(10, 0) NOT NULL,
    txt_question_option VARCHAR2(255 CHAR),
    ind_question NUMBER(19, 0),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_qopt PRIMARY KEY (cod_question_option)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_QOPT_QUES', 'CREATE INDEX ix_gel_qopt_ques ON gel_question_option (ind_question)');

        $this->createTableIfMissing('GEL_DISPOSITIVO_CADASTRADO', <<<'SQL'
CREATE TABLE gel_dispositivo_cadastrado (
    cod_dispositivo_cadastrado NUMBER(19, 0) NOT NULL,
    dat_dispositivo_cadastrado TIMESTAMP(6),
    txt_email_responsavel VARCHAR2(255 CHAR),
    txt_titulo VARCHAR2(255 CHAR),
    txt_uf VARCHAR2(255 CHAR),
    dat_desabilitado_em TIMESTAMP(6),
    txt_nome_responsavel VARCHAR2(255 CHAR),
    txt_email_autorizado_por VARCHAR2(255 CHAR),
    txt_nome_autorizado_por VARCHAR2(255 CHAR),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_disp PRIMARY KEY (cod_dispositivo_cadastrado)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_DISP_UF', 'CREATE INDEX ix_gel_disp_uf ON gel_dispositivo_cadastrado (txt_uf)');

        $this->createTableIfMissing('GEL_DISPOSITIVO_ZONA', <<<'SQL'
CREATE TABLE gel_dispositivo_zona (
    ind_dispositivo_cadastrado NUMBER(19, 0) NOT NULL,
    zona NUMBER(5, 0) NOT NULL,
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_disp_zona PRIMARY KEY (ind_dispositivo_cadastrado, zona)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_DZ_DISP', 'CREATE INDEX ix_gel_dz_disp ON gel_dispositivo_zona (ind_dispositivo_cadastrado)');

        $this->createTableIfMissing('GEL_VISTORIA', <<<'SQL'
CREATE TABLE gel_vistoria (
    cod_vistoria NUMBER(19, 0) NOT NULL,
    txt_cargo_resp_informacao VARCHAR2(255 CHAR),
    txt_cargo_resp_local VARCHAR2(255 CHAR),
    txt_cargo_resp_vistoria VARCHAR2(255 CHAR),
    num_latitude_lv NUMBER(11, 8),
    num_longitude_lv NUMBER(11, 8),
    txt_mat_resp_informacao VARCHAR2(255 CHAR),
    txt_mat_resp_vistoria VARCHAR2(255 CHAR),
    txt_nome_municipio_sede VARCHAR2(255 CHAR),
    txt_nome_resp_informacao VARCHAR2(255 CHAR),
    txt_nome_resp_local VARCHAR2(255 CHAR),
    txt_nome_resp_vistoria VARCHAR2(255 CHAR),
    txt_novo_lv_bairro VARCHAR2(255 CHAR),
    txt_novo_lv_cep VARCHAR2(255 CHAR),
    txt_novo_lv_endereco VARCHAR2(255 CHAR),
    txt_novo_lv_nome VARCHAR2(255 CHAR),
    num_precisao_gps NUMBER(8, 3),
    txt_telefone_fixo VARCHAR2(255 CHAR),
    txt_telefone_orelhao_prox VARCHAR2(255 CHAR),
    txt_telefone_outros VARCHAR2(255 CHAR),
    txt_telefone_rural VARCHAR2(255 CHAR),
    ind_local_votacao VARCHAR2(255 CHAR),
    ind_zona VARCHAR2(255 CHAR),
    dat_criacao TIMESTAMP(6),
    dat_recebimento TIMESTAMP(6),
    dat_vistoria TIMESTAMP(6),
    txt_telefone_resp_local VARCHAR2(255 CHAR),
    ind_dispositivo_cadastrado NUMBER(19, 0),
    dat_envio_elo TIMESTAMP(6),
    txt_usuario_envio_elo VARCHAR2(255 CHAR),
    dat_upload_imagem TIMESTAMP(6),
    txt_hash_imagem VARCHAR2(255 CHAR),
    txt_name_imagem VARCHAR2(255 CHAR),
    bol_lv_dados_alterado NUMBER(1, 0),
    dat_alteracao TIMESTAMP(6),
    txt_usuario_alteracao VARCHAR2(100 CHAR),
    txt_novo_lv_telefone VARCHAR2(100 CHAR),
    bol_is_vinculado NUMBER(1, 0) NOT NULL,
    txt_tipo_vistoria VARCHAR2(255 CHAR) NOT NULL,
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_vistoria PRIMARY KEY (cod_vistoria)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_VIST_DISP', 'CREATE INDEX ix_gel_vist_disp ON gel_vistoria (ind_dispositivo_cadastrado)');
        $this->createIndexIfMissing('IX_GEL_VIST_LOCAL', 'CREATE INDEX ix_gel_vist_local ON gel_vistoria (ind_local_votacao)');
        $this->createIndexIfMissing('IX_GEL_VIST_ZONA', 'CREATE INDEX ix_gel_vist_zona ON gel_vistoria (ind_zona)');
        $this->createIndexIfMissing('IX_GEL_VIST_DATA', 'CREATE INDEX ix_gel_vist_data ON gel_vistoria (dat_vistoria)');

        $this->createTableIfMissing('GEL_CATEGORIA_VISTORIA', <<<'SQL'
CREATE TABLE gel_categoria_vistoria (
    cod_categoria_vistoria NUMBER(19, 0) NOT NULL,
    cod_objeto_vistoria VARCHAR2(255 CHAR),
    nom_categoria_vistoria VARCHAR2(255 CHAR),
    seq_categoria_vistoria NUMBER(10, 0),
    ind_vistoria NUMBER(19, 0),
    txt_orientacao VARCHAR2(1000 CHAR),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_cat_vist PRIMARY KEY (cod_categoria_vistoria)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_CATVIST_VIST', 'CREATE INDEX ix_gel_catvist_vist ON gel_categoria_vistoria (ind_vistoria)');

        $this->createTableIfMissing('GEL_QUESTION_VISTORIA', <<<'SQL'
CREATE TABLE gel_question_vistoria (
    cod_question_vistoria NUMBER(19, 0) NOT NULL,
    cod_objeto VARCHAR2(255 CHAR),
    des_question_vistoria VARCHAR2(255 CHAR),
    seq_question_vistoria NUMBER(10, 0),
    tip_question_vistoria VARCHAR2(255 CHAR),
    txt_question_vistoria VARCHAR2(500 CHAR),
    ind_categoria_vistoria NUMBER(19, 0),
    txt_orientacao VARCHAR2(1000 CHAR),
    bol_required NUMBER(1, 0),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_q_vist PRIMARY KEY (cod_question_vistoria)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_QVIST_CATVIST', 'CREATE INDEX ix_gel_qvist_catvist ON gel_question_vistoria (ind_categoria_vistoria)');

        $this->createTableIfMissing('GEL_QUESTION_OPTION_VISTORIA', <<<'SQL'
CREATE TABLE gel_question_option_vistoria (
    cod_question_option_vistoria NUMBER(19, 0) NOT NULL,
    cod_objeto VARCHAR2(255 CHAR),
    des_question_option_vistoria VARCHAR2(255 CHAR),
    seq_question_option_vistoria NUMBER(10, 0),
    txt_question_option_vistoria VARCHAR2(255 CHAR),
    ind_question_vistoria NUMBER(19, 0),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_qo_vist PRIMARY KEY (cod_question_option_vistoria)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_QOV_QVIST', 'CREATE INDEX ix_gel_qov_qvist ON gel_question_option_vistoria (ind_question_vistoria)');

        $this->createTableIfMissing('GEL_QUESTION_VISTORIA_VALOR', <<<'SQL'
CREATE TABLE gel_question_vistoria_valor (
    ind_question_vistoria NUMBER(19, 0) NOT NULL,
    vlr VARCHAR2(255 CHAR) NOT NULL,
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL
)
SQL);
        $this->createIndexIfMissing('IX_GEL_QVV_QVIST', 'CREATE INDEX ix_gel_qvv_qvist ON gel_question_vistoria_valor (ind_question_vistoria)');

        $this->createTableIfMissing('GEL_VISTORIA_IMAGEM', <<<'SQL'
CREATE TABLE gel_vistoria_imagem (
    cod_vistoria_imagem NUMBER(19, 0) NOT NULL,
    dat_upload_imagem TIMESTAMP(6),
    txt_hash VARCHAR2(1000 CHAR),
    txt_name_imagem VARCHAR2(255 CHAR),
    txt_titulo VARCHAR2(255 CHAR),
    ind_categoria_vistoria NUMBER(19, 0),
    sync_run_id VARCHAR2(36 CHAR),
    synced_at DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT pk_gel_vist_img PRIMARY KEY (cod_vistoria_imagem)
)
SQL);
        $this->createIndexIfMissing('IX_GEL_VI_CATVIST', 'CREATE INDEX ix_gel_vi_catvist ON gel_vistoria_imagem (ind_categoria_vistoria)');

        DB::statement($this->viewSql());
    }

    public function down(): void
    {
        $this->dropViewIfExists('VW_GEL_RESPOSTAS_AC');

        foreach ([
            'GEL_VISTORIA_IMAGEM',
            'GEL_QUESTION_VISTORIA_VALOR',
            'GEL_QUESTION_OPTION_VISTORIA',
            'GEL_QUESTION_VISTORIA',
            'GEL_CATEGORIA_VISTORIA',
            'GEL_VISTORIA',
            'GEL_DISPOSITIVO_ZONA',
            'GEL_DISPOSITIVO_CADASTRADO',
            'GEL_QUESTION_OPTION',
            'GEL_QUESTION',
            'GEL_CATEGORIA',
            'GEL_FORMULARIO',
        ] as $table) {
            $this->dropTableIfExists($table);
        }
    }

    private function viewSql(): string
    {
        return <<<'SQL'
CREATE OR REPLACE VIEW vw_gel_respostas_ac AS
WITH respostas_multiplas AS (
    SELECT
        qvv.ind_question_vistoria,
        LISTAGG(qvv.vlr, '; ') WITHIN GROUP (ORDER BY qvv.vlr) AS resposta
    FROM gel_question_vistoria_valor qvv
    GROUP BY qvv.ind_question_vistoria
)
SELECT
    'AC' AS uf,
    lv.nom_localidade AS municipio,
    v.ind_zona AS zona,
    lv.cod_objeto AS cod_objeto_local_votacao,
    lv.num_local AS numero_local,
    lv.nom_local AS nome_local,
    v.cod_vistoria,
    v.txt_tipo_vistoria,
    v.dat_vistoria,
    cv.seq_categoria_vistoria AS ordem_categoria,
    cv.nom_categoria_vistoria AS categoria,
    qv.seq_question_vistoria AS ordem_questao,
    qv.des_question_vistoria AS questao,
    qv.tip_question_vistoria AS tipo_questao,
    COALESCE(rm.resposta, qv.txt_question_vistoria) AS resposta,
    qv.cod_question_vistoria,
    cv.cod_categoria_vistoria
FROM gel_vistoria v
LEFT JOIN local_votacao_st lv ON TRIM(lv.cod_objeto) = TRIM(v.ind_local_votacao)
JOIN gel_categoria_vistoria cv ON cv.ind_vistoria = v.cod_vistoria
JOIN gel_question_vistoria qv ON qv.ind_categoria_vistoria = cv.cod_categoria_vistoria
LEFT JOIN respostas_multiplas rm ON rm.ind_question_vistoria = qv.cod_question_vistoria
SQL;
    }

    private function createTableIfMissing(string $table, string $sql): void
    {
        if (!$this->tableExists($table)) {
            DB::statement($sql);
        }
    }

    private function createIndexIfMissing(string $index, string $sql): void
    {
        if (!$this->indexExists($index)) {
            DB::statement($sql);
        }
    }

    private function dropTableIfExists(string $table): void
    {
        if ($this->tableExists($table)) {
            DB::statement('DROP TABLE ' . strtolower($table));
        }
    }

    private function dropViewIfExists(string $view): void
    {
        if ($this->viewExists($view)) {
            DB::statement('DROP VIEW ' . strtolower($view));
        }
    }

    private function tableExists(string $table): bool
    {
        return (int) DB::table('user_tables')->where('table_name', strtoupper($table))->count() > 0;
    }

    private function indexExists(string $index): bool
    {
        return (int) DB::table('user_indexes')->where('index_name', strtoupper($index))->count() > 0;
    }

    private function viewExists(string $view): bool
    {
        return (int) DB::table('user_views')->where('view_name', strtoupper($view))->count() > 0;
    }
};
```
</DATABASE_MIGRATIONS_2026_07_10_120000_CREATE_GEL_AC_SYNC_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_22_130000_add_eleicao_metadata_to_rcand_tables.php`
## <DATABASE_MIGRATIONS_2026_07_22_130000_ADD_ELEICAO_METADATA_TO_RCAND_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_22_130000_add_eleicao_metadata_to_rcand_tables.php`
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
        foreach (['rcand_cand_processos', 'rcand_consolidado_processos'] as $tabela) {
            DB::statement(<<<SQL
ALTER TABLE {$tabela} ADD (
    cd_eleicao      NUMBER(10),
    nm_eleicao      VARCHAR2(150 CHAR),
    tp_abrangencia  VARCHAR2(20 CHAR),
    nr_turno        NUMBER(2),
    dt_eleicao      DATE
)
SQL);
        }

        DB::statement('CREATE INDEX ix_rcand_cand_eleicao ON rcand_cand_processos (cd_eleicao)');
        DB::statement('CREATE INDEX ix_rcand_cons_eleicao ON rcand_consolidado_processos (cd_eleicao)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_rcand_cons_eleicao');
        DB::statement('DROP INDEX ix_rcand_cand_eleicao');

        foreach (['rcand_consolidado_processos', 'rcand_cand_processos'] as $tabela) {
            foreach (['dt_eleicao', 'nr_turno', 'tp_abrangencia', 'nm_eleicao', 'cd_eleicao'] as $coluna) {
                DB::statement("ALTER TABLE {$tabela} DROP COLUMN {$coluna}");
            }
        }
    }
};
```
</DATABASE_MIGRATIONS_2026_07_22_130000_ADD_ELEICAO_METADATA_TO_RCAND_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_07_22_131000_create_rcand_candexweb_tables.php`
## <DATABASE_MIGRATIONS_2026_07_22_131000_CREATE_RCAND_CANDEXWEB_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_07_22_131000_create_rcand_candexweb_tables.php`
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
CREATE TABLE rcand_candexweb_pedidos (
    id_rcand_candexweb_pedido   NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    dt_carga                    DATE DEFAULT SYSDATE NOT NULL,
    cd_eleicao                  NUMBER(10),
    nm_eleicao                  VARCHAR2(150 CHAR),
    tp_abrangencia              VARCHAR2(20 CHAR),
    nr_turno                    NUMBER(2),
    dt_eleicao                  DATE,
    sq_pedido                   NUMBER(19),
    sg_ue                       VARCHAR2(10 CHAR),
    cd_cargo                    NUMBER(10),
    tp_agremiacao               VARCHAR2(20 CHAR),
    tp_pedido                   VARCHAR2(20 CHAR),
    st_declaracao               VARCHAR2(20 CHAR),
    dt_aceite                   DATE,
    nr_zona_aceite              NUMBER(10),
    dt_migracao_cand            DATE,
    dt_conclusao                DATE,
    st_popula                   VARCHAR2(20 CHAR),
    nr_processo_drap            VARCHAR2(40 CHAR),
    st_declaracao_mural         VARCHAR2(20 CHAR),
    nr_partido_incluiu_pedido   NUMBER(10),
    ts_ultima_alteracao         DATE,
    nr_versao_pedido            NUMBER(10)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE rcand_candexweb_candidatos (
    id_rcand_candexweb_candidato NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    dt_carga                     DATE DEFAULT SYSDATE NOT NULL,
    cd_eleicao                   NUMBER(10),
    nm_eleicao                   VARCHAR2(150 CHAR),
    tp_abrangencia               VARCHAR2(20 CHAR),
    nr_turno                     NUMBER(2),
    dt_eleicao                   DATE,
    sq_candidato                 NUMBER(19),
    sq_pedido                    NUMBER(19),
    sg_ue                        VARCHAR2(10 CHAR),
    cd_cargo                     NUMBER(10),
    nr_candidato                 NUMBER(10),
    nm_candidato                 VARCHAR2(200 CHAR),
    nm_urna                      VARCHAR2(200 CHAR),
    nr_partido                   NUMBER(10),
    st_declaracao                VARCHAR2(20 CHAR),
    st_declaracao_mural          VARCHAR2(20 CHAR),
    st_declaracao_presta_conta   VARCHAR2(20 CHAR),
    st_declaracao_divulgacao     VARCHAR2(20 CHAR),
    nm_social                    VARCHAR2(200 CHAR),
    ts_ultima_alteracao          DATE,
    nr_versao_candidato          NUMBER(10)
)
SQL);

        DB::statement('CREATE INDEX ix_rcand_cw_ped_ele ON rcand_candexweb_pedidos (cd_eleicao)');
        DB::statement('CREATE INDEX ix_rcand_cw_ped_sq ON rcand_candexweb_pedidos (sq_pedido)');
        DB::statement('CREATE INDEX ix_rcand_cw_ped_ue ON rcand_candexweb_pedidos (sg_ue)');
        DB::statement('CREATE INDEX ix_rcand_cw_ped_proc ON rcand_candexweb_pedidos (nr_processo_drap)');
        DB::statement('CREATE INDEX ix_rcand_cw_cand_ele ON rcand_candexweb_candidatos (cd_eleicao)');
        DB::statement('CREATE INDEX ix_rcand_cw_cand_ped ON rcand_candexweb_candidatos (sq_pedido)');
        DB::statement('CREATE INDEX ix_rcand_cw_cand_nr ON rcand_candexweb_candidatos (nr_candidato)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_rcand_cw_cand_nr');
        DB::statement('DROP INDEX ix_rcand_cw_cand_ped');
        DB::statement('DROP INDEX ix_rcand_cw_cand_ele');
        DB::statement('DROP INDEX ix_rcand_cw_ped_proc');
        DB::statement('DROP INDEX ix_rcand_cw_ped_ue');
        DB::statement('DROP INDEX ix_rcand_cw_ped_sq');
        DB::statement('DROP INDEX ix_rcand_cw_ped_ele');
        DB::statement('DROP TABLE rcand_candexweb_candidatos');
        DB::statement('DROP TABLE rcand_candexweb_pedidos');
    }
};
```
</DATABASE_MIGRATIONS_2026_07_22_131000_CREATE_RCAND_CANDEXWEB_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_01_120000_create_rcand_partido_filter_tables.php`
## <DATABASE_MIGRATIONS_2026_08_01_120000_CREATE_RCAND_PARTIDO_FILTER_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_01_120000_create_rcand_partido_filter_tables.php`
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
CREATE TABLE rcand_partido (
    dt_carga       DATE DEFAULT SYSDATE NOT NULL,
    cd_eleicao     NUMBER(10) NOT NULL,
    nr_partido     NUMBER(10) NOT NULL,
    sg_partido     VARCHAR2(55 CHAR) NOT NULL,
    nm_partido     VARCHAR2(100 CHAR) NOT NULL,
    CONSTRAINT pk_rcand_partido PRIMARY KEY (cd_eleicao, nr_partido)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE rcand_cand_proc_partido (
    dt_carga                       DATE DEFAULT SYSDATE NOT NULL,
    cd_eleicao                     NUMBER(10) NOT NULL,
    nr_processo_sem_formatacao     VARCHAR2(40 CHAR) NOT NULL,
    nr_partido                     NUMBER(10) NOT NULL,
    CONSTRAINT pk_rcand_cand_proc_part PRIMARY KEY (cd_eleicao, nr_processo_sem_formatacao, nr_partido)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE rcand_cw_pedido_partido (
    dt_carga       DATE DEFAULT SYSDATE NOT NULL,
    cd_eleicao     NUMBER(10) NOT NULL,
    sq_pedido      NUMBER(19) NOT NULL,
    nr_partido     NUMBER(10) NOT NULL,
    CONSTRAINT pk_rcand_cw_pedido_part PRIMARY KEY (cd_eleicao, sq_pedido, nr_partido)
)
SQL);

        DB::statement('CREATE INDEX ix_rcand_partido_nr ON rcand_partido (nr_partido, cd_eleicao)');
        DB::statement('CREATE INDEX ix_rcand_cpp_nr_ele_proc ON rcand_cand_proc_partido (nr_partido, cd_eleicao, nr_processo_sem_formatacao)');
        DB::statement('CREATE INDEX ix_rcand_cwpp_nr_ele_ped ON rcand_cw_pedido_partido (nr_partido, cd_eleicao, sq_pedido)');
    }

    public function down(): void
    {
        DB::statement('DROP INDEX ix_rcand_cwpp_nr_ele_ped');
        DB::statement('DROP INDEX ix_rcand_cpp_nr_ele_proc');
        DB::statement('DROP INDEX ix_rcand_partido_nr');
        DB::statement('DROP TABLE rcand_cw_pedido_partido');
        DB::statement('DROP TABLE rcand_cand_proc_partido');
        DB::statement('DROP TABLE rcand_partido');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_01_120000_CREATE_RCAND_PARTIDO_FILTER_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_12_120000_add_envio_mpf_to_rcand_tables.php`
## <DATABASE_MIGRATIONS_2026_08_12_120000_ADD_ENVIO_MPF_TO_RCAND_TABLES_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_12_120000_add_envio_mpf_to_rcand_tables.php`
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
ALTER TABLE rcand_pje_processos ADD (
    envio_mpf VARCHAR2(20 CHAR)
)
SQL);

        DB::statement(<<<'SQL'
ALTER TABLE rcand_consolidado_processos ADD (
    envio_mpf VARCHAR2(20 CHAR)
)
SQL);
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE rcand_consolidado_processos DROP COLUMN envio_mpf');
        DB::statement('ALTER TABLE rcand_pje_processos DROP COLUMN envio_mpf');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_12_120000_ADD_ENVIO_MPF_TO_RCAND_TABLES_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_08_12_130000_add_impugnacoes_to_rcand_cand_processos.php`
## <DATABASE_MIGRATIONS_2026_08_12_130000_ADD_IMPUGNACOES_TO_RCAND_CAND_PROCESSOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_08_12_130000_add_impugnacoes_to_rcand_cand_processos.php`
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
ALTER TABLE rcand_cand_processos ADD (
    impugnacoes VARCHAR2(3 CHAR)
)
SQL);
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE rcand_cand_processos DROP COLUMN impugnacoes');
    }
};
```
</DATABASE_MIGRATIONS_2026_08_12_130000_ADD_IMPUGNACOES_TO_RCAND_CAND_PROCESSOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/colaboradores-eleitorais/eventos-publicos/index.blade.php`
## <RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_EVENTOS_PUBLICOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/colaboradores-eleitorais/eventos-publicos/index.blade.php`
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
@extends('layouts.eventos-eleitor-publico')

@section('titulo', 'Meus eventos — TRE-AC')

@section('conteudo')
    <section class="consulta-card" aria-labelledby="consulta-titulo">
        <div class="consulta-card-texto">
            <p class="consulta-etiqueta">Consulta pública</p>
            <h2 id="consulta-titulo">Encontre seus eventos e treinamentos</h2>
            <p>Informe o número do seu título eleitoral. Digite somente os números ou use a pontuação do documento.</p>
        </div>

        <form
            method="POST"
            action="{{ route('colaboradores-eleitorais.eventos-publicos.consultar') }}"
            class="consulta-formulario"
            autocomplete="off"
        >
            @csrf
            <div class="consulta-campo">
                <label for="num_inscricao" class="form-label">Título eleitoral</label>
                <input
                    type="text"
                    inputmode="numeric"
                    class="form-control @error('num_inscricao') is-invalid @enderror"
                    id="num_inscricao"
                    name="num_inscricao"
                    maxlength="20"
                    value="{{ $consultaRealizada ? '' : old('num_inscricao') }}"
                    aria-describedby="num-inscricao-ajuda @error('num_inscricao') num-inscricao-erro @enderror"
                    required
                    @if (! $consultaRealizada) autofocus @endif
                >
                <div id="num-inscricao-ajuda" class="form-text">O número será usado apenas para localizar o cronograma.</div>
                @error('num_inscricao')
                    <div id="num-inscricao-erro" class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>
            <button type="submit" class="btn-consultar">
                <i class="fa-solid fa-magnifying-glass" aria-hidden="true"></i>
                <span>{{ $consultaRealizada ? 'Consultar novamente' : 'Consultar agenda' }}</span>
            </button>
        </form>
    </section>

    @if ($consultaRealizada)
        <section class="resultado-consulta" aria-labelledby="resultado-titulo">
            <div class="resultado-cabecalho">
                <p class="resultado-etiqueta">Cronograma</p>
                <h2 id="resultado-titulo">Agenda encontrada</h2>
                @if ($nomeAnonimizado !== null)
                    <p class="resultado-identidade">
                        <i class="fa-solid fa-user-shield" aria-hidden="true"></i>
                        <span>Identificação: <strong>{{ $nomeAnonimizado }}</strong></span>
                    </p>
                @endif
            </div>

            @if ($ocorrencias === [])
                <div class="resultado-vazio" role="status">
                    <i class="fa-regular fa-calendar-xmark" aria-hidden="true"></i>
                    <p>Não foi possível encontrar eventos ou treinamentos disponíveis para esta consulta.</p>
                    <span>Confira o número informado ou tente novamente mais tarde.</span>
                </div>
            @else
                <ol class="eventos-lista" aria-label="Cronograma de eventos e treinamentos em ordem cronológica">
                    @foreach ($ocorrencias as $ocorrencia)
                        <li>
                            <article class="evento-card">
                                <div class="evento-data" aria-hidden="true">
                                    <strong>{{ $ocorrencia['dia'] }}</strong>
                                    <span>{{ $ocorrencia['mes'] }}</span>
                                    <small>{{ $ocorrencia['ano'] }}</small>
                                </div>
                                <div class="evento-conteudo">
                                    <div class="evento-metadados">
                                        <span class="evento-acao">{{ $ocorrencia['acao'] }}</span>
                                        <span class="evento-macroprojeto">{{ $ocorrencia['macroprojeto'] }}</span>
                                    </div>
                                    <h3>{{ $ocorrencia['evento'] }}</h3>
                                    <p class="evento-local">
                                        <i class="fa-solid fa-location-dot" aria-hidden="true"></i>
                                        <span>{{ $ocorrencia['local'] }}</span>
                                    </p>
                                    @if (($ocorrencia['modalidade'] ?? null) !== null)
                                        <p class="evento-detalhe">
                                            <i class="fa-solid fa-chalkboard-user" aria-hidden="true"></i>
                                            <span><strong>Modalidade:</strong> {{ $ocorrencia['modalidade'] }}</span>
                                        </p>
                                    @endif
                                    @if (($ocorrencia['endereco'] ?? null) !== null)
                                        <p class="evento-detalhe">
                                            <i class="fa-regular fa-map" aria-hidden="true"></i>
                                            <span><strong>Endereço:</strong> {{ $ocorrencia['endereco'] }}</span>
                                        </p>
                                    @endif
                                    @if (($ocorrencia['sala'] ?? null) !== null)
                                        <p class="evento-detalhe">
                                            <i class="fa-solid fa-door-open" aria-hidden="true"></i>
                                            <span><strong>Sala:</strong> {{ $ocorrencia['sala'] }}</span>
                                        </p>
                                    @endif
                                    <p class="evento-periodo">
                                        <i class="fa-regular fa-clock" aria-hidden="true"></i>
                                        <time datetime="{{ $ocorrencia['inicio_iso'] }}">{{ $ocorrencia['periodo'] }}</time>
                                        <time datetime="{{ $ocorrencia['fim_iso'] }}" class="visually-hidden">Término do evento</time>
                                    </p>
                                </div>
                            </article>
                        </li>
                    @endforeach
                </ol>
            @endif
        </section>
    @endif
@endsection
```
</RESOURCES_VIEWS_COLABORADORES_ELEITORAIS_EVENTOS_PUBLICOS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/layouts/eventos-eleitor-publico.blade.php`
## <RESOURCES_VIEWS_LAYOUTS_EVENTOS_ELEITOR_PUBLICO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/layouts/eventos-eleitor-publico.blade.php`
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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Consulta pública de eventos e treinamentos eleitorais">
    <meta name="robots" content="noindex, nofollow">
    <meta name="referrer" content="no-referrer">
    <title>@yield('titulo', 'Meus eventos')</title>
    <link rel="icon" type="image/x-icon" href="/rotas-publicas/favicon.ico">
    <link rel="stylesheet" href="/rotas-publicas/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/rotas-publicas/vendor/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="/rotas-publicas/css/meus-eventos.css">
</head>
<body>
    <header class="cabecalho-publico">
        <div class="container cabecalho-publico-conteudo">
            <img
                src="/rotas-publicas/img/eleicoes-2026-tre-ac.png"
                alt="Eleições 2026, Tribunal Regional Eleitoral do Acre"
                width="182"
                height="80"
                class="cabecalho-publico-logo"
            >
            <div class="cabecalho-publico-texto">
                <p class="cabecalho-publico-selo">Eleições 2026</p>
                <h1>Meus eventos</h1>
                <p>Consulte seus eventos e treinamentos</p>
            </div>
        </div>
    </header>

    <main class="container conteudo-publico" id="conteudo-principal">
        @yield('conteudo')
    </main>

    <footer class="rodape-publico">
        <div class="container">
            <strong>Tribunal Regional Eleitoral do Acre — TRE-AC</strong>
            <span>Fique atento às datas e participe pontualmente.</span>
        </div>
    </footer>
</body>
</html>
```
</RESOURCES_VIEWS_LAYOUTS_EVENTOS_ELEITOR_PUBLICO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/layouts/nat-externo-publico.blade.php`
## <RESOURCES_VIEWS_LAYOUTS_NAT_EXTERNO_PUBLICO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/layouts/nat-externo-publico.blade.php`
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
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('titulo', 'NAT')</title>
    <link rel="stylesheet" href="/rotas-publicas/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/rotas-publicas/vendor/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="/rotas-publicas/vendor/select2/css/select2.min.css">
    <style>
        body {
            min-height: 100vh;
            background:
                radial-gradient(circle at top right, rgba(13, 110, 253, 0.12), transparent 24%),
                linear-gradient(180deg, #f8fbff 0%, #eef4fb 100%);
        }

        .nat-ext-shell {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0.55rem 0.6rem 1.5rem;
        }

        .nat-ext-brandbar {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border-radius: 0.85rem;
            box-shadow: 0 0.65rem 1.4rem rgba(29, 68, 124, 0.14);
            color: #fff;
            margin-bottom: 0.75rem;
            padding: 0.55rem 0.85rem;
        }

        .nat-ext-brandcopy {
            min-width: 0;
        }

        .nat-ext-brand {
            font-size: 1rem;
            font-weight: 700;
            letter-spacing: 0.01em;
            line-height: 1.05;
        }

        .nat-ext-user {
            color: rgba(255, 255, 255, 0.86);
            font-size: 0.78rem;
            line-height: 1.1;
            margin: 0.05rem 0 0;
            max-width: 14rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .nat-ext-logout {
            --bs-btn-padding-y: 0.18rem;
            --bs-btn-padding-x: 0.55rem;
            --bs-btn-font-size: 0.78rem;
            border-radius: 999px;
            line-height: 1.1;
        }

        .nat-ext-content .card {
            border: 0;
            border-radius: 1rem;
            box-shadow: 0 1rem 2rem rgba(36, 64, 99, 0.08);
        }

        .nat-ext-footer {
            color: #5f6f85;
            font-size: 0.82rem;
            margin-top: 1.25rem;
            text-align: center;
        }

        .select2-container .select2-selection--single,
        .select2-container .select2-selection--multiple {
            min-height: 38px;
            border-color: var(--bs-border-color);
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 36px;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 36px;
        }

        @@media (max-width: 575.98px) {
            .nat-ext-shell {
                padding-top: 0.45rem;
            }

            .nat-ext-brandbar {
                border-radius: 0.75rem;
                padding: 0.5rem 0.75rem;
            }

            .nat-ext-user {
                max-width: 10.5rem;
            }
        }
    </style>
    @stack('estilos')
    @stack('styles')
</head>
<body>
<main class="nat-ext-shell">
    <section class="nat-ext-brandbar">
        <div class="d-flex align-items-center justify-content-between gap-2">
            <div class="nat-ext-brandcopy">
                <div class="nat-ext-brand">@isset($topoRotasLabel) NAT - {{ $topoRotasLabel }} @else NAT @endisset</div>
                @if(session('nat_externo.nome'))
                    <p class="nat-ext-user mb-0">{{ session('nat_externo.nome') }}</p>
                @elseif(session('mesario_publico.nome'))
                    <p class="nat-ext-user mb-0">{{ session('mesario_publico.nome') }}</p>
                @endif
            </div>
            @if(session('nat_externo.autenticado'))
                <form method="POST" action="{{ route('nat.externo.logout') }}">
                    @csrf
                    <button type="submit" class="btn btn-outline-light btn-sm nat-ext-logout">
                        <i class="fa-solid fa-right-from-bracket me-1"></i> Sair
                    </button>
                </form>
            @elseif(session('mesario_publico.autenticado'))
                <form method="POST" action="{{ route('mesario.publico.logout') }}">
                    @csrf
                    <button type="submit" class="btn btn-outline-light btn-sm nat-ext-logout">
                        <i class="fa-solid fa-right-from-bracket me-1"></i> Sair
                    </button>
                </form>
            @endif
        </div>
    </section>

    <div class="nat-ext-content">
        @yield('conteudo')
    </div>

    <div class="nat-ext-footer">
        Desenvolvido pela STI/AGEL/CSCOR/ASPGOVTI/SDBD/TRE-AC
    </div>
</main>

<script src="/rotas-publicas/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/rotas-publicas/vendor/jquery/jquery-3.7.1.min.js"></script>
<script src="/rotas-publicas/vendor/select2/js/select2.min.js"></script>
<script>
    if (window.jQuery) {
        window.jQuery.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
            }
        });
    }
</script>
@stack('scripts')
</body>
</html>
```
</RESOURCES_VIEWS_LAYOUTS_NAT_EXTERNO_PUBLICO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/lda/partials/gel-respostas-categoria.blade.php`
## <RESOURCES_VIEWS_LDA_PARTIALS_GEL_RESPOSTAS_CATEGORIA_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/lda/partials/gel-respostas-categoria.blade.php`
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
@php
    $respostas = $respostas ?? [];
    $categoria = $categoria ?? 'Categoria GEL';
    $vistoria = $vistoria ?? [];
    $formatarData = static function ($valor): string {
        $texto = trim((string) $valor);
        if ($texto === '') {
            return '—';
        }

        try {
            return \Illuminate\Support\Carbon::parse($texto)->format('d/m/Y H:i');
        } catch (\Throwable) {
            return $texto;
        }
    };
@endphp

@if(empty($respostas))
    <div class="alert alert-warning py-2 px-3 mb-0 small">
        Nenhuma resposta GEL localizada para esta categoria.
    </div>
@else
    <div class="small text-muted mb-2">
        <span class="fw-semibold">{{ $categoria }}</span>
        <span>· Vistoria {{ data_get($vistoria, 'cod_vistoria', '—') }}</span>
        <span>· {{ $formatarData(data_get($vistoria, 'dat_vistoria')) }}</span>
        @if(data_get($vistoria, 'txt_tipo_vistoria'))
            <span>· {{ data_get($vistoria, 'txt_tipo_vistoria') }}</span>
        @endif
    </div>
    <div class="table-responsive">
        <table class="table table-sm table-bordered align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th>Questão</th>
                    <th>Resposta</th>
                </tr>
            </thead>
            <tbody>
                @foreach($respostas as $respostaGel)
                    <tr>
                        <td>{{ data_get($respostaGel, 'questao') ?: 'Questão sem texto' }}</td>
                        <td>{{ trim((string) data_get($respostaGel, 'resposta', '')) !== '' ? data_get($respostaGel, 'resposta') : '—' }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
@endif
```
</RESOURCES_VIEWS_LDA_PARTIALS_GEL_RESPOSTAS_CATEGORIA_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/rcand/index.blade.php`
## <RESOURCES_VIEWS_RCAND_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/rcand/index.blade.php`
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
function rcandChartDataset(series) {
function rcandBuildChart(id, type, series) {
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
@extends('layouts.app')

@section('titulo', 'Painel RCAND')

@section('conteudo')
    @php
        $queryBase = request()->except(['aba', 'visao_cand', 'page', 'cand_page', 'candexweb_pedidos_page', 'candexweb_candidatos_page', 'zona', 'municipio']);
        $visaoCandQueryBase = request()->except(['visao_cand', 'page', 'cand_page', 'candexweb_pedidos_page', 'candexweb_candidatos_page', 'zona', 'municipio']);
        $statusSequencial = $syncStatus->get('rcand_sequencial');
        $statusPje = $syncStatus->get('rcand_pje');
        $statusCand = $syncStatus->get('rcand_cand');
        $statusCandexweb = $syncStatus->get('rcand_candexweb');
        $statusConsolidado = $syncStatus->get('rcand_consolidado');
        $mostrarGraficos = !in_array($abaAtual, ['cand', 'glossario'], true);
        $tituloExportacao = $abaAtual === 'cand'
            ? ($visoesCand[$visaoCandAtual]['rotulo'] ?? $abaTitulo)
            : $abaTitulo;
    @endphp

    <div class="d-flex flex-wrap justify-content-between align-items-center mt-3 mb-3 gap-2">
        <h1 class="h4 mb-0 text-primary"><i class="fa-solid fa-scale-balanced me-2"></i> Painel RCAND</h1>
        <div class="btn-group btn-group-sm">
            @if($podeSincronizarRcand ?? false)
                <a href="{{ route('administracao-global.sync-rcand.index') }}" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrows-rotate me-1"></i> Sincronização
                </a>
            @endif
            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalExportarPdfRcand">
                <i class="fa-solid fa-file-pdf me-1"></i> Exportar PDF
            </button>
        </div>
    </div>

    <div class="nav nav-pills gap-1 mb-3 rcand-tabs" role="tablist" aria-label="Páginas do painel RCAND">
        <a data-rcand-aba="gerencial" class="nav-link @if($abaAtual === 'gerencial') active @endif" href="{{ route('rcand.index', array_merge($queryBase, ['aba' => 'gerencial'])) }}">Gerencial</a>
        <a data-rcand-aba="detalhes" class="nav-link @if($abaAtual === 'detalhes') active @endif" href="{{ route('rcand.index', array_merge($queryBase, ['aba' => 'detalhes'])) }}">Detalhes</a>
        <a data-rcand-aba="segundo-grau" class="nav-link @if($abaAtual === 'segundo-grau') active @endif" href="{{ route('rcand.index', array_merge($queryBase, ['aba' => 'segundo-grau'])) }}">2º GRAU</a>
        <a data-rcand-aba="draps" class="nav-link @if($abaAtual === 'draps') active @endif" href="{{ route('rcand.index', array_merge($queryBase, ['aba' => 'draps'])) }}">DRAPs</a>
        <a data-rcand-aba="cand" class="nav-link @if($abaAtual === 'cand') active @endif" href="{{ route('rcand.index', array_merge($queryBase, ['aba' => 'cand'])) }}">CAND</a>
        <a data-rcand-aba="glossario" class="nav-link @if($abaAtual === 'glossario') active @endif" href="{{ route('rcand.index', array_merge($queryBase, ['aba' => 'glossario'])) }}">Glossário</a>
    </div>

    <form method="GET" action="{{ route('rcand.index') }}" class="border rounded p-3 mb-3 bg-white">
        <input type="hidden" name="aba" value="{{ $abaAtual }}">
        @if ($abaAtual === 'cand')
            <input type="hidden" name="visao_cand" value="{{ $visaoCandAtual }}">
        @endif
        <div class="row g-2 align-items-end">
            <div class="col-md-3">
                <label class="form-label small text-muted">Processo</label>
                <input type="text" name="processo" class="form-control form-control-sm" value="{{ $filtros['processo'] ?? '' }}">
            </div>
            <div class="col-md-3">
                <label class="form-label small text-muted" for="rcandPartido">Partido</label>
                <select id="rcandPartido" name="partido" class="form-select form-select-sm rcand-partido-select2" data-placeholder="Todos os partidos">
                    <option value="">Todos os partidos</option>
                    @foreach ($opcoes['partidos'] as $partido)
                        <option value="{{ $partido['numero'] }}" @selected(($filtros['partido'] ?? '') === (string) $partido['numero'])>{{ $partido['rotulo'] }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Tipo</label>
                <select name="tipo" class="form-select form-select-sm" @disabled($abaAtual === 'draps')>
                    <option value="">Todos</option>
                    @foreach ($opcoes['tipos'] as $tipo)
                        <option value="{{ $tipo }}" @selected(($filtros['tipo'] ?? '') === (string) $tipo || ($abaAtual === 'draps' && $tipo === 'DRAP'))>{{ $tipo }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Julgamento</label>
                <select name="julgamento" class="form-select form-select-sm">
                    <option value="">Todos</option>
                    <option value="julgado" @selected(($filtros['julgamento'] ?? '') === 'julgado')>Julgado</option>
                    <option value="nao_julgado" @selected(($filtros['julgamento'] ?? '') === 'nao_julgado')>Não julgado</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label small text-muted">Divergência CAND x PJe</label>
                <select name="divergencia" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['divergencias'] as $divergencia)
                        <option value="{{ $divergencia }}" @selected(($filtros['divergencia'] ?? '') === (string) $divergencia)>{{ $divergencia }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label small text-muted">Situação CAND</label>
                <select name="situacao_cand" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['situacoes_cand'] as $situacao)
                        <option value="{{ $situacao }}" @selected(($filtros['situacao_cand'] ?? '') === (string) $situacao)>{{ $situacao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Cert. publicação</label>
                <select name="cert_publicacao" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['certidoes_publicacao'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['cert_publicacao'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Informação</label>
                <select name="informacao" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['informacoes_candidato'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['informacao'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Impugnações</label>
                <select name="impugnacao" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['impugnacoes'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['impugnacao'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Julgados PJe S/N</label>
                <select name="julgado_pje" class="form-select form-select-sm">
                    <option value="">Todos</option>
                    @foreach ($opcoes['julgamentos_pje'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['julgado_pje'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Primeiro recurso</label>
                <select name="data_primeiro_recurso" class="form-select form-select-sm">
                    <option value="">Todos</option>
                    @foreach ($opcoes['datas_primeiro_recurso'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['data_primeiro_recurso'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Contrarrazão</label>
                <select name="contrarrazao" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['contrarrazoes'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['contrarrazao'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small text-muted">Remessa TRE</label>
                <select name="remessa_tre" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    @foreach ($opcoes['remessas_tre'] as $opcao)
                        <option value="{{ $opcao }}" @selected(($filtros['remessa_tre'] ?? '') === (string) $opcao)>{{ $opcao }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-8 d-flex gap-2">
                <button type="submit" class="btn btn-sm btn-primary">
                    <i class="fa-solid fa-filter me-1"></i> Filtrar
                </button>
                <a href="{{ route('rcand.index', array_filter([
                    'aba' => $abaAtual,
                    'visao_cand' => $abaAtual === 'cand' ? $visaoCandAtual : null,
                ])) }}" class="btn btn-sm btn-outline-secondary">Limpar</a>
            </div>
        </div>
    </form>

    <div class="modal fade" id="modalExportarPdfRcand" tabindex="-1" aria-labelledby="modalExportarPdfRcandLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <form class="modal-content" method="GET" action="{{ route('rcand.exportar-pdf') }}" target="_blank">
                <input type="hidden" name="aba" value="{{ $abaAtual }}">
                @if ($abaAtual === 'cand')
                    <input type="hidden" name="visao_cand" value="{{ $visaoCandAtual }}">
                @endif
                @foreach ($filtros as $campo => $valor)
                    <input type="hidden" name="{{ $campo }}" value="{{ $valor }}">
                @endforeach
                <div class="modal-header">
                    <h5 class="modal-title" id="modalExportarPdfRcandLabel"><i class="fa-solid fa-file-pdf text-danger me-1"></i> Exportar {{ $tituloExportacao }} para PDF</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-2">
                        @foreach ($camposPdf as $campo => $label)
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="rcandPdfCampo{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))>
                                    <label class="form-check-label" for="rcandPdfCampo{{ $campo }}">{{ $label }}</label>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger"><i class="fa-solid fa-file-pdf me-1"></i> Gerar PDF</button>
                </div>
            </form>
        </div>
    </div>

    <div class="border rounded p-3 mb-3 bg-white">
        <div class="row g-3 align-items-center">
            <div class="col-md-3">
                <div class="text-muted small">Última sincronização</div>
                <div class="fw-semibold">{{ data_get($statusSequencial, 'executado_em_formatado') ?? 'Sem registro' }}</div>
                <div class="small text-muted">{{ data_get($statusSequencial, 'mensagem') ?? 'Execute a sincronização RCAND para atualizar os dados locais.' }}</div>
            </div>
            <div class="col-md-3 small">
                <strong>PJe:</strong> {{ data_get($statusPje, 'executado_em_formatado') ?? '-' }}<br>
                <strong>CAND:</strong> {{ data_get($statusCand, 'executado_em_formatado') ?? '-' }}
            </div>
            <div class="col-md-3 small">
                <strong>CANDEXWEB:</strong> {{ data_get($statusCandexweb, 'executado_em_formatado') ?? '-' }}<br>
                <strong>Consolidado:</strong> {{ data_get($statusConsolidado, 'executado_em_formatado') ?? '-' }}<br>
                <strong>Destino:</strong> {{ (int) data_get($statusConsolidado, 'resultado.destino_total', 0) }} registros
            </div>
            <div class="col-md-3 text-md-end">
                <span class="badge bg-light text-dark border">{{ $abaTitulo }}</span>
            </div>
        </div>
    </div>

    <div class="row g-3 mb-3 rcand-kpis">
        <div class="col-md"><div class="border rounded p-3 h-100 bg-white"><div class="text-muted small">Total</div><div class="h4 mb-0">{{ (int) $resumo['total'] }}</div></div></div>
        <div class="col-md"><div class="border rounded p-3 h-100 bg-white"><div class="text-muted small">Julgamento: Cand x PJE</div><div class="h5 mb-0">{{ $resumo['cand_pje'] ?? '-' }}</div></div></div>
        <div class="col-md"><div class="border rounded p-3 h-100 bg-white"><div class="text-muted small">Divergentes</div><div class="h4 mb-0">{{ (int) $resumo['divergentes'] }}</div></div></div>
        <div class="col-md"><div class="border rounded p-3 h-100 bg-white"><div class="text-muted small">Julgados</div><div class="h4 mb-0">{{ (int) $resumo['julgados'] }}</div></div></div>
        <div class="col-md"><div class="border rounded p-3 h-100 bg-white"><div class="text-muted small">Não julgados</div><div class="h4 mb-0">{{ (int) $resumo['sem_julgamento'] }}</div></div></div>
    </div>

    @if ($abaAtual === 'glossario')
        <div class="border rounded p-4 bg-white mb-3">
            <h2 class="h5 text-primary mb-3">Glossário</h2>
            <div class="row g-3">
                <div class="col-md-6">
                    <p><strong>Cert. Publ S/N:</strong> indica se houve movimento de publicação do edital no DJE após a juntada do edital.</p>
                    <p><strong>Julgados PJE S/N:</strong> indica se o processo possui primeiro julgamento registrado no PJe.</p>
                    <p><strong>Parecer MPE S/N:</strong> indica a presença de parecer, manifestação ou cota ministerial juntada pelo Ministério Público Eleitoral.</p>
                    <p><strong>Todas petições lidas?</strong> reproduz a DAX do PBIT sobre o campo de petições avulsas.</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Inform Candidato S/N:</strong> indica presença de informação do candidato no fluxo do PJe.</p>
                    <p><strong>Julgados CAND S/N:</strong> considera não julgado quando a situação CAND está aguardando julgamento.</p>
                    <p><strong>IF CAND x PJE:</strong> compara os indicadores de julgamento do PJe e do CAND.</p>
                    <p><strong>Integridade PJe/CAND:</strong> aponta ausência em uma das bases ou divergência de tipo de processo.</p>
                    <p><strong>Envio ao MPF:</strong> data da primeira expedição ativa para a Procuradoria Regional Eleitoral.</p>
                </div>
            </div>
        </div>
    @endif

    @if ($mostrarGraficos)
        <div class="row g-3 mb-3 rcand-charts">
            <div class="col-lg-4"><div class="border rounded p-3 bg-white h-100"><h2 class="h6 mb-3">Publicação do Edital no DJE</h2><div class="rcand-chart-frame"><canvas id="rcandChartPublicacao"></canvas></div></div></div>
            <div class="col-lg-4"><div class="border rounded p-3 bg-white h-100"><h2 class="h6 mb-3">Processos Julgados</h2><div class="rcand-chart-frame"><canvas id="rcandChartJulgados"></canvas></div></div></div>
            <div class="col-lg-4"><div class="border rounded p-3 bg-white h-100"><h2 class="h6 mb-3">Juntada de Parecer do MPE</h2><div class="rcand-chart-frame"><canvas id="rcandChartMpe"></canvas></div></div></div>
            <div class="col-lg-6"><div class="border rounded p-3 bg-white h-100"><h2 class="h6 mb-3">Informação do Candidato</h2><div class="rcand-chart-frame rcand-chart-frame-wide"><canvas id="rcandChartInformacao"></canvas></div></div></div>
            <div class="col-lg-6"><div class="border rounded p-3 bg-white h-100"><h2 class="h6 mb-3">Petições Avulsas</h2><div class="rcand-chart-frame rcand-chart-frame-wide"><canvas id="rcandChartPeticoes"></canvas></div></div></div>
        </div>
    @endif

    @if ($abaAtual === 'cand')
        <nav class="nav nav-pills flex-wrap gap-2 mb-3" aria-label="Tabelas da aba CAND">
            @foreach ($visoesCand as $chaveVisao => $configuracaoVisao)
                @php($visaoAtiva = $visaoCandAtual === $chaveVisao)
                <a
                    data-rcand-visao="{{ $chaveVisao }}"
                    class="nav-link d-flex align-items-center gap-2 @if($visaoAtiva) active @endif"
                    href="{{ route('rcand.index', array_merge($visaoCandQueryBase, [
                        'aba' => 'cand',
                        'visao_cand' => $chaveVisao,
                    ])) }}"
                    @if($visaoAtiva) aria-current="page" @endif
                >
                    {{ $configuracaoVisao['rotulo'] }}
                    <span class="badge rounded-pill {{ $visaoAtiva ? 'bg-white text-primary' : 'bg-light text-dark border' }}" data-rcand-visao-total="{{ $chaveVisao }}">{{ (int) ($totaisVisoesCand[$chaveVisao] ?? 0) }}</span>
                </a>
            @endforeach
        </nav>

        <div class="border rounded p-3 bg-white mb-3" data-rcand-visao-tabela="{{ $visaoCandAtual }}">
            <h2 class="h6 mb-3">{{ $visoesCand[$visaoCandAtual]['rotulo'] }}</h2>

            @switch($visaoCandAtual)
                @case('processos')
                    <div class="table-responsive">
                        <table class="table table-sm table-striped align-middle">
                            <thead class="table-light"><tr><th>Processo</th><th>Partidos</th><th>Situação</th><th>Tipo</th></tr></thead>
                            <tbody>
                                @forelse ($registrosVisaoCand as $item)
                                    <tr>
                                        <td>
                                            <strong>{{ $item->nr_processo ?? '-' }}</strong><br>
                                            <span class="text-muted small">{{ $item->cd_eleicao ?? '-' }} · {{ $item->nm_eleicao ?? '-' }}</span>
                                        </td>
                                        <td class="rcand-partidos">{{ $item->partidos ?? '-' }}</td>
                                        <td>{{ $item->ds_situacao_processo ?? '-' }}</td>
                                        <td>{{ $item->tp_processo ?? '-' }}</td>
                                    </tr>
                                @empty
                                    <tr><td colspan="4" class="text-center text-muted">Nenhum processo CAND encontrado.</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    @break

                @case('comparacao')
                    <div class="table-responsive">
                        <table class="table table-sm table-striped align-middle">
                            <thead class="table-light"><tr><th>Processo</th><th>Partidos</th><th>PJe</th><th>CAND</th><th>Comparação</th></tr></thead>
                            <tbody>
                                @forelse ($registrosVisaoCand as $item)
                                    <tr>
                                        <td>{{ $item->nr_processo ?? $item->cand_processo ?? '-' }}</td>
                                        <td class="rcand-partidos">{{ $item->partidos ?? '-' }}</td>
                                        <td>{{ $item->julgados_pje_sn ?? '-' }}</td>
                                        <td>{{ $item->julgados_cand_sn ?? '-' }}</td>
                                        <td>{{ $item->if_cand_x_pje ?? '-' }}</td>
                                    </tr>
                                @empty
                                    <tr><td colspan="5" class="text-center text-muted">Nenhuma comparação encontrada.</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    @break

                @case('pedidos')
                    <div class="table-responsive">
                        <table class="table table-sm table-striped align-middle">
                            <thead class="table-light"><tr><th>Pedido</th><th>Partidos</th><th>UE</th><th>Processo DRAP</th><th>Status</th></tr></thead>
                            <tbody>
                                @forelse ($registrosVisaoCand as $item)
                                    <tr>
                                        <td>
                                            <strong>{{ $item->sq_pedido ?? '-' }}</strong><br>
                                            <span class="text-muted small">{{ $item->cd_eleicao ?? '-' }} · {{ $item->nm_eleicao ?? '-' }}</span>
                                        </td>
                                        <td class="rcand-partidos">{{ $item->partidos ?? '-' }}</td>
                                        <td>{{ $item->sg_ue ?? '-' }}</td>
                                        <td>{{ $item->nr_processo_drap ?? '-' }}</td>
                                        <td>{{ $item->st_popula ?? '-' }}</td>
                                    </tr>
                                @empty
                                    <tr><td colspan="5" class="text-center text-muted">Nenhum pedido CANDEXWEB encontrado.</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    @break

                @case('candidatos')
                    <div class="table-responsive">
                        <table class="table table-sm table-striped align-middle">
                            <thead class="table-light"><tr><th>Candidato</th><th>Pedido</th><th>Número</th><th>Partidos</th></tr></thead>
                            <tbody>
                                @forelse ($registrosVisaoCand as $item)
                                    <tr>
                                        <td>
                                            <strong>{{ $item->nm_candidato ?? '-' }}</strong><br>
                                            <span class="text-muted small">{{ $item->nm_urna ?? '-' }} · {{ $item->cd_eleicao ?? '-' }}</span>
                                        </td>
                                        <td>{{ $item->sq_pedido ?? '-' }}</td>
                                        <td>{{ $item->nr_candidato ?? '-' }}</td>
                                        <td class="rcand-partidos">{{ $item->partidos ?? '-' }}</td>
                                    </tr>
                                @empty
                                    <tr><td colspan="4" class="text-center text-muted">Nenhum candidato CANDEXWEB encontrado.</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    @break
            @endswitch

            @if ($registrosVisaoCand->hasPages())
                {{ $registrosVisaoCand->links('pagination::bootstrap-5') }}
            @endif
        </div>
    @elseif ($abaAtual !== 'glossario')
        <div class="border rounded p-3 bg-white mb-3">
            <h2 class="h6 mb-3">TODOS PROCESSOS</h2>
            <div class="table-responsive">
                <table class="table table-sm table-striped align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Processo</th>
                            <th>Partidos</th>
                            <th>Situação</th>
                            <th>Andamento PJe</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($registros as $item)
                            <tr>
                                <td>
                                    <strong>{{ $item->nr_processo ?? '-' }}</strong><br>
                                    <span class="text-muted small">{{ $item->tipo_registro ?? '-' }}</span><br>
                                    @if (($item->cd_eleicao ?? null) !== null || ($item->nm_eleicao ?? null) !== null)
                                        <span class="text-muted small">{{ $item->cd_eleicao ?? '-' }} · {{ $item->nm_eleicao ?? '-' }}</span><br>
                                    @endif
                                    <span class="small"><strong>Processo CAND:</strong> {{ $item->cand_processo ?? '-' }}</span>
                                </td>
                                <td class="rcand-partidos">{{ $item->partidos ?? '-' }}</td>
                                <td>
                                    <strong>CAND:</strong> {{ $item->cand_situacao_processo ?? '-' }}<br>
                                    <strong>Tipo CAND:</strong> {{ $item->cand_tipo_processo ?? '-' }}<br>
                                    <strong>CAND x PJe:</strong> {{ $item->if_cand_x_pje ?? '-' }}<br>
                                    <strong>Integridade:</strong> {{ $item->st_divergencia ?? '-' }}
                                </td>
                                <td>
                                    <strong>Edital:</strong> {{ $item->edital ?? '-' }} · <strong>Publicação DJE:</strong> {{ $item->certidao_publicacao ?? '-' }} ({{ $item->cert_publ_sn ?? '-' }})<br>
                                    <strong>Informação:</strong> {{ $item->inform_candidato_sn ?? '-' }} · <strong>Envio ao MPF:</strong> {{ $item->envio_mpf ?? '-' }} · <strong>Parecer MPE:</strong> {{ $item->intimacao_mp_parecer ?? '-' }} ({{ $item->sem_int_mpe ?? '-' }})<br>
                                    <strong>Impugnações:</strong> {{ $item->impugnacoes ?? '-' }} · <strong>Petições:</strong> {{ $item->todas_peticoes_lidas ?? '-' }}@if (!empty($item->peticoes_avulsas)) ({{ $item->peticoes_avulsas }})@endif<br>
                                    <strong>Julgado PJe:</strong> {{ $item->julgados_pje_sn ?? '-' }} · <strong>Julgado CAND:</strong> {{ $item->julgados_cand_sn ?? '-' }}<br>
                                    <strong>Primeiro julgamento:</strong> {{ $item->primeiro_julgamento ?? '-' }} · <strong>Teor:</strong> {{ $item->teor_julgamento ?? '-' }}<br>
                                    <strong>Recurso:</strong> {{ $item->data_primeiro_recurso ?? '-' }} · <strong>Contrarrazão:</strong> {{ $item->contrarrazao ?? '-' }} · <strong>Remessa TRE:</strong> {{ $item->remessa_tre ?? '-' }}
                                </td>
                            </tr>
                        @empty
                            <tr><td colspan="4" class="text-center text-muted">Nenhum processo RCAND encontrado com os filtros selecionados.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
            @if ($registros->hasPages())
                {{ $registros->links('pagination::bootstrap-5') }}
            @endif
        </div>
    @endif
@endsection

@push('styles')
    <style>
        .rcand-chart-frame {
            position: relative;
            width: 100%;
            height: 220px;
        }

        .rcand-chart-frame-wide {
            height: 190px;
        }

        .rcand-partidos {
            white-space: pre-line;
        }
    </style>
@endpush

@push('scripts')
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            if (!window.jQuery || !window.jQuery.fn || !window.jQuery.fn.select2) {
                return;
            }

            const campoPartido = window.jQuery('.rcand-partido-select2');
            if (campoPartido.length && !campoPartido.hasClass('select2-hidden-accessible')) {
                campoPartido.select2({
                    width: '100%',
                    allowClear: true,
                    placeholder: campoPartido.data('placeholder')
                });
            }
        });
    </script>
@endpush

@if ($mostrarGraficos)
@push('scripts')
    <script src="{{ asset('vendor/chartjs/chart.umd.min.js') }}"></script>
    <script>
        const rcandDashboardData = @json(['aba' => $abaAtual, 'graficos' => $graficos]);

        function rcandChartDataset(series) {
            const rows = Array.isArray(series) ? series : [];
            return {
                labels: rows.map((item) => item.label),
                datasets: [{
                    data: rows.map((item) => item.total),
                    backgroundColor: ['#2563eb', '#16a34a', '#f59e0b', '#dc2626', '#7c3aed', '#0891b2'],
                    borderWidth: 1
                }]
            };
        }

        function rcandBuildChart(id, type, series) {
            const canvas = document.getElementById(id);
            if (!canvas || typeof Chart === 'undefined') {
                return;
            }

            new Chart(canvas, {
                type,
                data: rcandChartDataset(series),
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: { legend: { position: 'bottom' } },
                    scales: type === 'bar' ? { y: { beginAtZero: true, ticks: { precision: 0 } } } : {}
                }
            });
        }

        rcandBuildChart('rcandChartPublicacao', 'pie', rcandDashboardData.graficos.publicacao_edital);
        rcandBuildChart('rcandChartJulgados', 'pie', rcandDashboardData.graficos.julgados);
        rcandBuildChart('rcandChartMpe', 'pie', rcandDashboardData.graficos.parecer_mpe);
        rcandBuildChart('rcandChartInformacao', 'bar', rcandDashboardData.graficos.informacao_candidato);
        rcandBuildChart('rcandChartPeticoes', 'bar', rcandDashboardData.graficos.peticoes_avulsas);
    </script>
@endpush
@endif
```
</RESOURCES_VIEWS_RCAND_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/rcand/pdf.blade.php`
## <RESOURCES_VIEWS_RCAND_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/rcand/pdf.blade.php`
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
        body { font-family: DejaVu Sans, sans-serif; font-size: 10px; color: #222; }
        h1 { font-size: 18px; margin: 0 0 8px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 4px; vertical-align: top; white-space: pre-line; }
        th { background: #f2f2f2; }
        .muted { color: #666; }
    </style>
</head>
<body>
    <h1>{{ $titulo ?? 'Relatório RCAND' }}</h1>
    <p class="muted">Gerado em {{ $geradoEm }}</p>

    <table>
        <thead>
            <tr>
                @foreach ($camposSelecionados as $campo)
                    <th>{{ $camposPdf[$campo] ?? $campo }}</th>
                @endforeach
            </tr>
        </thead>
        <tbody>
            @forelse ($registros as $item)
                <tr>
                    @foreach ($camposSelecionados as $campo)
                        <td>{{ data_get($item, $campo, '-') }}</td>
                    @endforeach
                </tr>
            @empty
                <tr><td colspan="{{ count($camposSelecionados) ?: 1 }}" class="muted">Nenhum registro encontrado com os filtros selecionados.</td></tr>
            @endforelse
        </tbody>
    </table>
</body>
</html>
```
</RESOURCES_VIEWS_RCAND_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/acompanhamento.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_ACOMPANHAMENTO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/acompanhamento.blade.php`
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
@extends('seu-voto-importa.publico.layout')
@section('titulo', 'Acompanhamento — Seu Voto Importa')
@section('conteudo')
<div class="card svi-card mb-3"><div class="card-body">
    <h1 class="h4">Acompanhamento da solicitação</h1>
    <dl class="row mb-0">
        <dt class="col-sm-4">Protocolo</dt><dd class="col-sm-8">{{ $solicitacao['protocolo'] }}</dd>
        <dt class="col-sm-4">Título</dt><dd class="col-sm-8">{{ $solicitacao['num_inscricao'] }}</dd>
        <dt class="col-sm-4">Telefone</dt><dd class="col-sm-8">{{ $solicitacao['eleitor_telefone'] }}</dd>
        <dt class="col-sm-4">Situação</dt><dd class="col-sm-8"><strong>{{ $solicitacao['status_descricao'] }}</strong></dd>
    </dl>
    @if($solicitacao['mensagem_publica'])<div class="alert alert-info mt-3 mb-0">{{ $solicitacao['mensagem_publica'] }}</div>@endif
</div></div>
@foreach($solicitacao['turnos'] as $turno)
<div class="card svi-card mb-3"><div class="card-body">
    <h2 class="h5">{{ $turno['numero_turno'] }}º turno — {{ $turno['status_descricao'] }}</h2>
    <p class="mb-1"><strong>Data:</strong> {{ $turno['data_votacao'] }}</p>
    @if($turno['ponto_embarque'])<p class="mb-1"><strong>Embarque:</strong> {{ $turno['ponto_embarque'] }}</p>@endif
    @if($turno['horario_previsto'])<p class="mb-1"><strong>Horário previsto:</strong> {{ $turno['horario_previsto'] }}</p>@endif
    @if($turno['observacao_publica'])<p class="mb-0">{{ $turno['observacao_publica'] }}</p>@endif
</div></div>
@endforeach
@endsection
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_ACOMPANHAMENTO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/formulario.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_FORMULARIO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/formulario.blade.php`
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
@extends('seu-voto-importa.publico.layout')
@section('titulo', 'Formulário — Seu Voto Importa')
@section('conteudo')
<form method="POST" action="{{ route('seu-voto-importa.publico.solicitacao.store') }}" enctype="multipart/form-data" data-turnstile-action="svi_enviar">
@csrf
<div class="card svi-card mb-3"><div class="card-body">
    <h1 class="h4">Formulário de solicitação</h1>
    <dl class="row mb-0">
        <dt class="col-sm-3">Eleitor</dt><dd class="col-sm-9">{{ $eleitor['nome'] }}</dd>
        <dt class="col-sm-3">Título</dt><dd class="col-sm-9">{{ $tituloMascarado }}</dd>
        <dt class="col-sm-3">Idade</dt><dd class="col-sm-9">{{ $eleitor['idade'] }} anos</dd>
        <dt class="col-sm-3">Votação</dt><dd class="col-sm-9">Zona {{ $eleitor['zona_numero'] }}, seção {{ $eleitor['secao_numero'] }} — {{ $eleitor['local_nome'] }}</dd>
        <dt class="col-sm-3">Endereço do local de votação</dt><dd class="col-sm-9">{{ $eleitor['local_endereco'] }}, {{ $eleitor['municipio_nome'] }}</dd>
    </dl>
</div></div>

<div class="card svi-card mb-3"><div class="card-body">
<fieldset><legend>Solicitante</legend><div class="row g-3">
    <div class="col-md-6"><label class="form-label required-label" for="solicitante_tipo_codigo">Quem solicita</label><select class="form-select" id="solicitante_tipo_codigo" name="solicitante_tipo_codigo" required>
        <option value="">Selecione</option>
        @foreach($catalogos['solicitantes'] as $item)<option value="{{ $item['codigo'] }}" @selected(old('solicitante_tipo_codigo') === $item['codigo'])>{{ $item['descricao'] }}</option>@endforeach
    </select></div>
    <div class="col-12 row g-3 m-0 p-0" id="representanteCampos">
        <div class="col-md-4"><label class="form-label required-label" for="solicitante_titulo">Título do representante</label><input class="form-control" id="solicitante_titulo" name="solicitante_titulo" value="{{ old('solicitante_titulo') }}" inputmode="numeric" autocomplete="off"></div>
        <div class="col-md-4"><label class="form-label required-label" for="solicitante_dt_nascimento">Data de nascimento do representante</label><input class="form-control" type="date" id="solicitante_dt_nascimento" name="solicitante_dt_nascimento" autocomplete="off"></div>
        <div class="col-md-4 d-flex align-items-end"><button class="btn btn-outline-primary w-100" type="button" id="consultarRepresentanteElo" disabled><i class="fa-solid fa-magnifying-glass"></i> Consultar no ELO</button></div>
        <div class="col-md-6"><label class="form-label required-label" for="solicitante_nome">Nome do representante</label><input class="form-control" id="solicitante_nome" name="solicitante_nome" value="" readonly aria-describedby="representanteRetorno"></div>
        <div class="col-md-6"><label class="form-label required-label" for="solicitante_telefone">Telefone do representante</label><input class="form-control" id="solicitante_telefone" name="solicitante_telefone" value="{{ old('solicitante_telefone') }}" inputmode="tel"></div>
        <div class="col-12"><div id="representanteRetorno" class="form-text" role="status">Informe o título e a data de nascimento e selecione “Consultar no ELO”.</div></div>
        <div class="col-12"><label class="form-label required-label" for="comprovante_representacao">Comprovante de representação</label><input class="form-control" type="file" id="comprovante_representacao" name="comprovante_representacao" accept=".pdf,.jpg,.jpeg,.png"><div class="form-text">PDF, JPG ou PNG, até 10 MB.</div></div>
    </div>
</div></fieldset>
</div></div>

<div class="card svi-card mb-3"><div class="card-body">
<fieldset><legend>Dados complementares do eleitor</legend><div class="row g-3">
    <div class="col-md-6"><label class="form-label required-label" for="eleitor_telefone">Telefone</label><input class="form-control" id="eleitor_telefone" name="eleitor_telefone" value="{{ old('eleitor_telefone') }}" inputmode="tel" required></div>
    <div class="col-md-6"><label class="form-label required-label" for="contato_preferencia_codigo">Contato preferencial</label><select class="form-select" id="contato_preferencia_codigo" name="contato_preferencia_codigo" required><option value="">Selecione</option>@foreach($catalogos['contatos'] as $item)<option value="{{ $item['codigo'] }}" @selected(old('contato_preferencia_codigo') === $item['codigo'])>{{ $item['descricao'] }}</option>@endforeach</select></div>
</div></fieldset>
</div></div>

<div class="card svi-card mb-3"><div class="card-body"><fieldset><legend>Endereço</legend><div class="row g-3">
    <div class="col-md-6"><label class="form-label required-label" for="endereco_logradouro">Logradouro</label><input class="form-control" id="endereco_logradouro" name="endereco_logradouro" value="{{ old('endereco_logradouro') }}" required maxlength="255"></div>
    <div class="col-md-2"><label class="form-label required-label" for="endereco_numero">Número</label><input class="form-control" id="endereco_numero" name="endereco_numero" value="{{ old('endereco_numero') }}" required maxlength="30"></div>
    <div class="col-md-4"><label class="form-label required-label" for="endereco_bairro">Bairro</label><input class="form-control" id="endereco_bairro" name="endereco_bairro" value="{{ old('endereco_bairro') }}" required maxlength="160"></div>
    <div class="col-md-5"><label class="form-label">Município</label><input class="form-control" value="RIO BRANCO" readonly aria-readonly="true"></div>
    <div class="col-md-7"><label class="form-label" for="endereco_referencia">Ponto de referência (opcional)</label><input class="form-control" id="endereco_referencia" name="endereco_referencia" value="{{ old('endereco_referencia') }}" maxlength="500"></div>
    <div class="col-md-5"><label class="form-label required-label" for="veiculo_acessa_codigo">O veículo consegue chegar ao endereço?</label><select class="form-select" id="veiculo_acessa_codigo" name="veiculo_acessa_codigo" required><option value="">Selecione</option><option value="SIM" @selected(old('veiculo_acessa_codigo') === 'SIM')>Sim</option><option value="NAO" @selected(old('veiculo_acessa_codigo') === 'NAO')>Não</option></select></div>
    <div class="col-12 row g-3 m-0 p-0" id="enderecoAlternativoCampos">
        <div class="col-12"><strong>Endereço alternativo acessível ao veículo</strong></div>
        <div class="col-md-6"><label class="form-label" for="endereco_alt_logradouro">Logradouro</label><input class="form-control" id="endereco_alt_logradouro" name="endereco_alt_logradouro" value="{{ old('endereco_alt_logradouro') }}" maxlength="255"></div>
        <div class="col-md-2"><label class="form-label" for="endereco_alt_numero">Número</label><input class="form-control" id="endereco_alt_numero" name="endereco_alt_numero" value="{{ old('endereco_alt_numero') }}" maxlength="30"></div>
        <div class="col-md-4"><label class="form-label" for="endereco_alt_bairro">Bairro</label><input class="form-control" id="endereco_alt_bairro" name="endereco_alt_bairro" value="{{ old('endereco_alt_bairro') }}" maxlength="160"></div>
        <div class="col-md-5"><label class="form-label">Município</label><input class="form-control" value="RIO BRANCO" readonly aria-readonly="true"></div>
        <div class="col-md-7"><label class="form-label" for="endereco_alt_referencia">Ponto de referência</label><input class="form-control" id="endereco_alt_referencia" name="endereco_alt_referencia" value="{{ old('endereco_alt_referencia') }}" maxlength="500"></div>
    </div>
    <div class="col-12 form-check ms-2"><input class="form-check-input" type="checkbox" id="declaracao_espera" name="declaracao_espera" value="1" required @checked(old('declaracao_espera'))><label class="form-check-label required-label" for="declaracao_espera"><strong>Declaro estar ciente de que o motorista aguardará o eleitor por até 5 (cinco) minutos no ponto de embarque, contados do horário previamente informado pela Justiça Eleitoral. Após esse período, o veículo poderá prosseguir com a rota programada.</strong></label></div>
</div></fieldset></div></div>

<div class="card svi-card mb-3"><div class="card-body"><fieldset><legend>Condição e transporte</legend><div class="row g-3">
    <div class="col-12"><span class="form-label required-label d-block">Deficiência ou mobilidade</span><p class="form-text">Podem ser assinaladas mais de uma condição.</p><div class="row">@foreach($catalogos['condicoes'] as $item)<div class="col-md-6 form-check"><input class="form-check-input" type="checkbox" name="condicoes[]" id="condicao_{{ $item['codigo'] }}" value="{{ $item['codigo'] }}" @checked(in_array($item['codigo'], old('condicoes', []), true))><label class="form-check-label" for="condicao_{{ $item['codigo'] }}">{{ $item['descricao'] }}</label></div>@endforeach</div></div>
    <div class="col-12" id="condicaoDescricaoCampo"><label class="form-label" for="condicao_descricao">Descrição da mobilidade reduzida</label><textarea class="form-control" id="condicao_descricao" name="condicao_descricao" rows="2" maxlength="1000">{{ old('condicao_descricao') }}</textarea></div>
    <div class="col-12"><span class="form-label required-label d-block">Comprovação</span><div class="row g-3">
        <div class="col-md-6"><div class="card h-100"><div class="card-body form-check m-0 ps-5">
            <input class="form-check-input" type="radio" id="comprovacao_autodeclaracao" name="comprovacao_tipo_codigo" value="AUTODECLARACAO" required @checked(old('comprovacao_tipo_codigo') === 'AUTODECLARACAO')>
            <label class="form-check-label d-block" for="comprovacao_autodeclaracao"><strong>Autodeclaração: Declaro, sob as penas da lei, que as informações prestadas neste formulário correspondem à condição de deficiência ou mobilidade reduzida do eleitor para o qual foi solicitado o serviço de transporte</strong></label>
        </div></div></div>
        <div class="col-md-6"><div class="card h-100"><div class="card-body form-check m-0 ps-5">
            <input class="form-check-input" type="radio" id="comprovacao_anexo" name="comprovacao_tipo_codigo" value="ANEXO" required @checked(old('comprovacao_tipo_codigo') === 'ANEXO')>
            <label class="form-check-label d-block" for="comprovacao_anexo"><strong>Anexar comprovante</strong><span class="d-block form-text">Utilize um documento em PDF, JPG ou PNG, com até 10 MB.</span></label>
        </div></div></div>
    </div></div>
    <div class="col-12" id="comprovanteCondicaoCampo"><label class="form-label" for="comprovante_condicao">Comprovante da condição</label><input class="form-control" type="file" id="comprovante_condicao" name="comprovante_condicao" accept=".pdf,.jpg,.jpeg,.png"><div class="form-text">PDF, JPG ou PNG, até 10 MB.</div></div>
    <div class="col-md-5"><label class="form-label required-label" for="impacto_codigo">A condição</label><select class="form-select" id="impacto_codigo" name="impacto_codigo" required><option value="">Selecione</option><option value="DIFICULTA" @selected(old('impacto_codigo') === 'DIFICULTA')>Dificulta o deslocamento</option><option value="IMPEDE" @selected(old('impacto_codigo') === 'IMPEDE')>Impede o deslocamento</option></select></div>
    <div class="col-md-7" id="impactoDescricaoCampo"><label class="form-label required-label" id="impactoDescricaoRotulo" for="impacto_descricao">Descreva como a condição dificulta/impede a ida ao local de votação</label><textarea class="form-control" id="impacto_descricao" name="impacto_descricao" rows="3" maxlength="2000" required>{{ old('impacto_descricao') }}</textarea></div>
    <div class="col-md-6"><label class="form-label required-label" for="transporte_publico_codigo">Há transporte público acessível?</label><select class="form-select" id="transporte_publico_codigo" name="transporte_publico_codigo" required><option value="">Selecione</option><option value="SIM" @selected(old('transporte_publico_codigo') === 'SIM')>Sim</option><option value="NAO" @selected(old('transporte_publico_codigo') === 'NAO')>Não</option><option value="NAO_SABE" @selected(old('transporte_publico_codigo') === 'NAO_SABE')>Não sabe</option></select></div>
    <div class="col-12"><span class="form-label required-label d-block">Equipamentos utilizados</span><p class="form-text">Podem ser assinalados mais de um equipamento.</p><div class="row">@foreach($catalogos['equipamentos'] as $item)<div class="col-md-6 form-check"><input class="form-check-input" type="checkbox" name="equipamentos[]" id="equipamento_{{ $item['codigo'] }}" value="{{ $item['codigo'] }}" @checked(in_array($item['codigo'], old('equipamentos', []), true))><label class="form-check-label" for="equipamento_{{ $item['codigo'] }}">{{ $item['descricao'] }}</label></div>@endforeach</div></div>
    <div class="col-12" id="equipamentoOutroCampo"><label class="form-label" for="equipamento_outro">Outro equipamento</label><input class="form-control" id="equipamento_outro" name="equipamento_outro" value="{{ old('equipamento_outro') }}" maxlength="500"></div>
</div></fieldset></div></div>

<div class="card svi-card mb-3"><div class="card-body"><fieldset><legend>Acompanhante e turnos</legend><div class="row g-3">
    <div class="col-md-4"><label class="form-label required-label" for="acompanhante_codigo">Terá acompanhante?</label><select class="form-select" id="acompanhante_codigo" name="acompanhante_codigo" required><option value="">Selecione</option><option value="NAO" @selected(old('acompanhante_codigo') === 'NAO')>Não</option><option value="SIM" @selected(old('acompanhante_codigo') === 'SIM')>Sim</option></select></div>
    <div class="col-md-8 row g-3 m-0 p-0" id="acompanhanteCampos"><div class="col-md-7"><label class="form-label" for="acompanhante_nome">Nome</label><input class="form-control" id="acompanhante_nome" name="acompanhante_nome" value="{{ old('acompanhante_nome') }}"></div><div class="col-md-5"><label class="form-label" for="acompanhante_telefone">Telefone</label><input class="form-control" id="acompanhante_telefone" name="acompanhante_telefone" value="{{ old('acompanhante_telefone') }}" inputmode="tel"></div></div>
    <div class="col-md-6"><label class="form-label required-label" for="segundo_turno_codigo">Deseja transporte em eventual segundo turno?</label><select class="form-select" id="segundo_turno_codigo" name="segundo_turno_codigo" required><option value="">Selecione</option><option value="SIM" @selected(old('segundo_turno_codigo') === 'SIM')>Sim</option><option value="NAO" @selected(old('segundo_turno_codigo') === 'NAO')>Não</option></select></div>
    <div class="col-12"><label class="form-label" for="observacoes">Observações</label><textarea class="form-control" id="observacoes" name="observacoes" rows="3" maxlength="2000">{{ old('observacoes') }}</textarea></div>
</div></fieldset></div></div>

<div class="card svi-card mb-3"><div class="card-body"><fieldset><legend>Declarações</legend>
@foreach([
    'declaracao_endereco_responsabilidade' => 'Declaro estar ciente de que é de responsabilidade do eleitor deslocar-se até o ponto de embarque informado.',
    'declaracao_endereco_acesso' => 'Declaro estar ciente de que o ponto de embarque informado deverá permitir o acesso do veículo disponibilizado pela Justiça Eleitoral.',
    'declaracao_veracidade' => 'Declaro que as informações prestadas neste formulário são verdadeiras.',
    'declaracao_sem_transporte' => 'Declaro que o eleitor não dispõe de meios próprios para comparecer ao local de votação.',
    'declaracao_analise' => 'Estou ciente de que o preenchimento deste formulário não garante, por si só, a disponibilização do transporte, estando o atendimento sujeito à análise da Justiça Eleitoral e à disponibilidade operacional.',
    'declaracao_sem_ajudante' => 'Estou ciente de que o serviço prestado pela Justiça Eleitoral consiste exclusivamente no transporte do eleitor entre o ponto de embarque e o local de votação, não sendo disponibilizado acompanhante, cuidador ou auxiliar para apoio físico durante o deslocamento ou embarque e desembarque.',
    'declaracao_compartilhado' => 'Estou ciente de que o transporte poderá ser compartilhado com outros eleitores.',
    'declaracao_horario' => 'Estou ciente de que os horários informados pela Justiça Eleitoral poderão sofrer ajustes em razão da organização das rotas.',
] as $campo => $rotulo)
<div class="form-check mb-3"><input class="form-check-input" type="checkbox" id="{{ $campo }}" name="{{ $campo }}" value="1" required @checked(old($campo))><label class="form-check-label required-label" for="{{ $campo }}"><strong>{{ $rotulo }}</strong></label></div>
@endforeach
<div class="alert alert-light border small mt-3" style="white-space: pre-line">{{ $eleitor['aviso_privacidade'] }}</div>
<div class="form-check mb-2"><input class="form-check-input" type="checkbox" id="declaracao_privacidade" name="declaracao_privacidade" value="1" required @checked(old('declaracao_privacidade'))><label class="form-check-label required-label" for="declaracao_privacidade"><strong>Li e estou ciente das informações sobre o tratamento dos meus dados pessoais.</strong></label></div>
</fieldset></div></div>

@include('seu-voto-importa.publico.partials.turnstile')
<div class="d-flex justify-content-end"><button class="btn btn-primary btn-lg" type="submit"><i class="fa-solid fa-paper-plane"></i> Enviar solicitação</button></div>
</form>
@endsection
@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', () => {
    const toggle = (controlId, targetId, showWhen, requiredIds = []) => {
        const control = document.getElementById(controlId), target = document.getElementById(targetId);
        if (!control || !target) return;
        const sync = (focar = false) => {
            const show = typeof showWhen === 'function' ? showWhen(control) : control.value === showWhen;
            target.classList.toggle('d-none', !show);
            target.setAttribute('aria-hidden', show ? 'false' : 'true');
            requiredIds.forEach((id) => { const input = document.getElementById(id); if (input) input.required = show; });
            if (show && focar) target.querySelector('input, select, textarea')?.focus();
        };
        control.addEventListener('change', () => sync(true)); sync();
    };

    toggle('solicitante_tipo_codigo', 'representanteCampos', (c) => c.value !== '' && c.value !== 'ELEITOR', ['solicitante_titulo', 'solicitante_dt_nascimento', 'solicitante_nome', 'solicitante_telefone', 'comprovante_representacao']);
    toggle('veiculo_acessa_codigo', 'enderecoAlternativoCampos', 'NAO', ['endereco_alt_logradouro', 'endereco_alt_numero', 'endereco_alt_bairro', 'endereco_alt_referencia']);
    toggle('acompanhante_codigo', 'acompanhanteCampos', 'SIM', ['acompanhante_nome', 'acompanhante_telefone']);

    const comprovacoes = [...document.querySelectorAll('[name="comprovacao_tipo_codigo"]')];
    const comprovanteCondicaoCampo = document.getElementById('comprovanteCondicaoCampo');
    const comprovanteCondicao = document.getElementById('comprovante_condicao');
    const syncComprovacao = () => {
        const selecionada = comprovacoes.find((item) => item.checked)?.value ?? '';
        const exibirAnexo = selecionada === 'ANEXO';
        comprovanteCondicaoCampo?.classList.toggle('d-none', !exibirAnexo);
        comprovanteCondicaoCampo?.setAttribute('aria-hidden', exibirAnexo ? 'false' : 'true');
        if (comprovanteCondicao) comprovanteCondicao.required = exibirAnexo;
    };
    comprovacoes.forEach((item) => item.addEventListener('change', syncComprovacao));
    syncComprovacao();

    const condicao = document.getElementById('condicao_MOBILIDADE_REDUZIDA');
    const condicaoCampo = document.getElementById('condicaoDescricaoCampo');
    const syncCondicao = () => { const show = !!condicao?.checked; condicaoCampo?.classList.toggle('d-none', !show); const input = document.getElementById('condicao_descricao'); if (input) input.required = show; };
    condicao?.addEventListener('change', syncCondicao); syncCondicao();

    const outro = document.getElementById('equipamento_OUTRO'), outroCampo = document.getElementById('equipamentoOutroCampo');
    const syncOutro = () => { const show = !!outro?.checked; outroCampo?.classList.toggle('d-none', !show); const input = document.getElementById('equipamento_outro'); if (input) input.required = show; };
    outro?.addEventListener('change', syncOutro); syncOutro();

    const impacto = document.getElementById('impacto_codigo'), impactoRotulo = document.getElementById('impactoDescricaoRotulo');
    const syncImpacto = () => { if (!impactoRotulo) return; const verbo = impacto?.value === 'IMPEDE' ? 'impede' : (impacto?.value === 'DIFICULTA' ? 'dificulta' : 'dificulta/impede'); impactoRotulo.textContent = `Descreva como a condição ${verbo} a ida ao local de votação`; };
    impacto?.addEventListener('change', syncImpacto); syncImpacto();

    const titulo = document.getElementById('solicitante_titulo');
    const nascimento = document.getElementById('solicitante_dt_nascimento');
    const nome = document.getElementById('solicitante_nome');
    const retorno = document.getElementById('representanteRetorno');
    const consultar = document.getElementById('consultarRepresentanteElo');
    const tipoSolicitante = document.getElementById('solicitante_tipo_codigo');
    let consultaAtual = 0;
    const ehRepresentante = () => !!tipoSolicitante?.value && tipoSolicitante.value !== 'ELEITOR';
    const sincronizarBotaoRepresentante = () => {
        if (consultar) consultar.disabled = !ehRepresentante() || !titulo?.value || !nascimento?.value;
    };
    const invalidarRepresentante = () => {
        consultaAtual++;
        if (nome) nome.value = '';
        if (retorno) retorno.textContent = 'Informe o título e a data de nascimento e selecione “Consultar no ELO”.';
        sincronizarBotaoRepresentante();
    };
    const identificarRepresentante = async () => {
        if (!ehRepresentante() || !titulo?.value || !nascimento?.value) return;
        const consulta = ++consultaAtual;
        nome.value = '';
        retorno.textContent = 'Consultando representante...';
        consultar.disabled = true;
        try {
            const response = await fetch(@json(route('seu-voto-importa.publico.representante.identificar')), {
                method: 'POST', headers: {'Accept': 'application/json', 'Content-Type': 'application/json', 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content},
                body: JSON.stringify({solicitante_titulo: titulo.value, solicitante_dt_nascimento: nascimento.value}),
            });
            const data = await response.json();
            if (consulta !== consultaAtual) return;
            if (!response.ok || !data.nome) throw new Error('nao-identificado');
            nome.value = data.nome; retorno.textContent = 'Representante identificado.';
        } catch (_) {
            if (consulta !== consultaAtual) return;
            nome.value = ''; retorno.textContent = 'Não foi possível identificar o representante. Confira os dados.';
        } finally {
            if (consulta === consultaAtual) sincronizarBotaoRepresentante();
        }
    };
    titulo?.addEventListener('input', invalidarRepresentante);
    nascimento?.addEventListener('change', invalidarRepresentante);
    tipoSolicitante?.addEventListener('change', invalidarRepresentante);
    consultar?.addEventListener('click', identificarRepresentante);
    sincronizarBotaoRepresentante();
});
</script>
@endpush
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_FORMULARIO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/identificacao.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_IDENTIFICACAO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/identificacao.blade.php`
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
@extends('seu-voto-importa.publico.layout')
@section('titulo', 'Solicitar transporte — Seu Voto Importa')
@section('conteudo')
<div class="card svi-card"><div class="card-body p-4">
    <h1 class="h4">Solicitar transporte eleitoral acessível</h1>
    <p>Informe os dados do eleitor que necessitará do transporte para iniciar uma nova solicitação.</p>
    @if(!$disponivel)
        <div class="alert alert-info mb-0">O período de solicitações não está disponível. Consulte os canais oficiais do TRE-AC.</div>
    @else
        <form method="POST" action="{{ route('seu-voto-importa.publico.identificar') }}" class="row g-3" data-turnstile-action="svi_identificar">
            @csrf
            <div class="col-md-6">
                <label class="form-label required-label" for="num_inscricao">Título eleitoral</label>
                <input class="form-control" id="num_inscricao" name="num_inscricao" value="{{ old('num_inscricao') }}" inputmode="numeric" maxlength="20" required autocomplete="off">
            </div>
            <div class="col-md-6">
                <label class="form-label required-label" for="dt_nascimento">Data de nascimento</label>
                <input class="form-control" type="date" id="dt_nascimento" name="dt_nascimento" value="{{ old('dt_nascimento') }}" required autocomplete="bday">
            </div>
            <div class="col-12">@include('seu-voto-importa.publico.partials.turnstile')</div>
            <div class="col-12 d-flex justify-content-end">
                <button class="btn btn-primary" type="submit"><i class="fa-solid fa-arrow-right"></i> Continuar</button>
            </div>
        </form>
    @endif
</div></div>
@endsection
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_IDENTIFICACAO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/layout.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_LAYOUT_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/layout.blade.php`
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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('titulo', 'Seu Voto Importa')</title>
    <link rel="stylesheet" href="/rotas-publicas/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/rotas-publicas/vendor/fontawesome/css/all.min.css">
    <style>
        body { background: #f4f6f9; color: #243142; }
        .svi-shell { max-width: 1050px; margin: 0 auto; padding: 1rem; }
        .svi-topo { background: #0b3d70; color: #fff; border-radius: .75rem; padding: 1rem 1.25rem; }
        .svi-card { border: 0; border-radius: .75rem; box-shadow: 0 .15rem .7rem rgba(0, 0, 0, .08); }
        fieldset { min-width: 0; }
        legend { font-size: 1.05rem; font-weight: 600; }
        .required-label::after { content: " *"; color: #b42318; }
    </style>
    @stack('styles')
</head>
<body>
<main class="svi-shell">
    <header class="svi-topo mb-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
        <div>
            <strong class="fs-5">Seu Voto Importa</strong><br>
            <span class="small">Transporte para eleitor com deficiência ou mobilidade reduzida</span>
        </div>
        @if(session('seu_voto_importa_publico.solicitacao_id'))
            <form method="POST" action="{{ route('seu-voto-importa.publico.logout') }}">
                @csrf
                <button class="btn btn-outline-light btn-sm" type="submit"><i class="fa-solid fa-right-from-bracket"></i> Sair</button>
            </form>
        @endif
    </header>

    @include('seu-voto-importa.publico.partials.navegacao-inicial')

    @if(session('status'))
        <div class="alert alert-success" role="status">{{ session('status') }}</div>
    @endif
    @if(session('erro'))
        <div class="alert alert-danger" role="alert">{{ session('erro') }}</div>
    @endif
    @if($errors->any())
        <div class="alert alert-danger" role="alert">
            <strong>Revise os dados informados.</strong>
            <ul class="mb-0 mt-1">
                @foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach
            </ul>
        </div>
    @endif

    @yield('conteudo')
</main>

<script src="/rotas-publicas/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
@stack('scripts')
</body>
</html>
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_LAYOUT_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/partials/navegacao-inicial.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_PARTIALS_NAVEGACAO_INICIAL_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/partials/navegacao-inicial.blade.php`
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
@php
    $novaSolicitacaoAtiva = request()->routeIs(
        'seu-voto-importa.publico.identificacao',
        'seu-voto-importa.publico.identificar',
        'seu-voto-importa.publico.solicitacao.*',
    );
    $acompanhamentoAtivo = request()->routeIs(
        'seu-voto-importa.publico.acesso.*',
        'seu-voto-importa.publico.acompanhamento',
    );
@endphp

<nav class="mb-3" aria-label="Ações do Seu Voto Importa">
    <div class="row g-2">
        <div class="col-12 col-sm-6">
            <a
                class="btn {{ $novaSolicitacaoAtiva ? 'btn-primary' : 'btn-outline-primary' }} w-100"
                href="{{ route('seu-voto-importa.publico.identificacao') }}"
                @if($novaSolicitacaoAtiva) aria-current="page" @endif
            >
                <i class="fa-solid fa-file-circle-plus me-1" aria-hidden="true"></i>
                Nova solicitação
            </a>
        </div>
        <div class="col-12 col-sm-6">
            <a
                class="btn {{ $acompanhamentoAtivo ? 'btn-primary' : 'btn-outline-primary' }} w-100"
                href="{{ route('seu-voto-importa.publico.acesso.form') }}"
                @if($acompanhamentoAtivo) aria-current="page" @endif
            >
                <i class="fa-solid fa-magnifying-glass me-1" aria-hidden="true"></i>
                Acompanhar solicitação
            </a>
        </div>
    </div>
</nav>
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_PARTIALS_NAVEGACAO_INICIAL_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/partials/turnstile.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_PARTIALS_TURNSTILE_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/partials/turnstile.blade.php`
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
<div data-turnstile-container data-sitekey="{{ $turnstileSiteKey }}" aria-label="Verificação de segurança"></div>
<span class="visually-hidden" data-turnstile-status role="status" aria-live="polite"></span>
<noscript><div class="alert alert-warning">Ative o JavaScript para realizar a verificação de segurança.</div></noscript>
@once
@push('scripts')
<script>
window.sviTurnstileReady = function () {
    document.querySelectorAll('form[data-turnstile-action]').forEach((form) => {
        const container = form.querySelector('[data-turnstile-container]');
        const status = form.querySelector('[data-turnstile-status]');
        if (!container || container.dataset.widgetId) return;
        const widgetId = turnstile.render(container, {
            sitekey: container.dataset.sitekey,
            action: form.dataset.turnstileAction,
            execution: 'execute',
            callback: (token) => {
                if (status) status.textContent = 'Verificação concluída. Enviando os dados.';
                let input = form.querySelector('input[name="cf-turnstile-response"]');
                if (!input) {
                    input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'cf-turnstile-response';
                    form.appendChild(input);
                }
                input.value = token;
                HTMLFormElement.prototype.submit.call(form);
            },
            'error-callback': () => {
                if (status) status.textContent = 'Não foi possível concluir a verificação. Tente novamente.';
                const button = form.querySelector('button[type="submit"]');
                if (button) { button.disabled = false; button.removeAttribute('aria-busy'); }
            }
        });
        container.dataset.widgetId = String(widgetId);
        form.addEventListener('submit', (event) => {
            if (form.querySelector('input[name="cf-turnstile-response"]')?.value) return;
            event.preventDefault();
            if (status) status.textContent = 'Verificando segurança. Aguarde.';
            const button = form.querySelector('button[type="submit"]');
            if (button) { button.disabled = true; button.setAttribute('aria-busy', 'true'); }
            turnstile.execute(widgetId);
        });
    });
};
</script>
<script src="https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit&onload=sviTurnstileReady" async defer></script>
@endpush
@endonce
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_PARTIALS_TURNSTILE_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/seu-voto-importa/publico/sucesso.blade.php`
## <RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_SUCESSO_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/seu-voto-importa/publico/sucesso.blade.php`
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
@extends('seu-voto-importa.publico.layout')
@section('titulo', 'Solicitação recebida — Seu Voto Importa')
@section('conteudo')
<div class="card svi-card"><div class="card-body p-4 text-center">
    <i class="fa-solid fa-circle-check text-success fs-1 mb-3"></i>
    <h1 class="h4">Solicitação recebida</h1>
    <p>Protocolo: <strong>{{ $protocolo }}</strong></p>
    <p class="text-muted">Guarde este protocolo. Ele será necessário para acompanhar a solicitação.</p>
    <a class="btn btn-primary" href="{{ route('seu-voto-importa.publico.acesso.form') }}">Acompanhar solicitação</a>
</div></div>
@endsection
```
</RESOURCES_VIEWS_SEU_VOTO_IMPORTA_PUBLICO_SUCESSO_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/cargos-equipe/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_CARGOS_EQUIPE_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/cargos-equipe/form.blade.php`
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

@php
    /** @var object|null $cargo */
    $titulo = $cargo ? 'Editar Cargo da Equipe' : 'Novo Cargo da Equipe';
    $rotaSalvar = $cargo
        ? route('tabelas-auxiliares.cargos-equipe.update', $cargo->id)
        : route('tabelas-auxiliares.cargos-equipe.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-id-badge"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina os cargos que poderão ser associados à equipe das rotas.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.cargos-equipe.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if($cargo)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-6">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" id="nome" name="nome" maxlength="120" required
                           class="form-control @error('nome') is-invalid @enderror"
                           value="{{ old('nome', $cargo->nome ?? '') }}">
                    @error('nome')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="ativo" class="form-label">Status</label>
                    <select id="ativo" name="ativo" class="form-select @error('ativo') is-invalid @enderror">
                        <option value="1" {{ old('ativo', ($cargo->ativo ?? 'S') === 'S') ? 'selected' : '' }}>Ativo</option>
                        <option value="0" {{ old('ativo', ($cargo->ativo ?? 'S') === 'S') ? '' : 'selected' }}>Inativo</option>
                    </select>
                    @error('ativo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12">
                    <label for="descricao" class="form-label">Descrição</label>
                    <textarea id="descricao" name="descricao" rows="3" maxlength="1000"
                              class="form-control @error('descricao') is-invalid @enderror">{{ old('descricao', $cargo->descricao ?? '') }}</textarea>
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_CARGOS_EQUIPE_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/cargos-equipe/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_CARGOS_EQUIPE_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/cargos-equipe/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Cargos da Equipe')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-id-badge"></i>
                    Cargos da Equipe
                </h5>
                <small class="text-muted">Cadastre os cargos utilizados para compor a equipe vinculada às rotas.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.cargos-equipe.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Novo cargo
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-sm align-middle mb-0">
                <thead class="table-light text-uppercase small">
                <tr>
                    <th style="width: 10%">ID</th>
                    <th>Nome</th>
                    <th>Descrição</th>
                    <th style="width: 15%">Status</th>
                    <th style="width: 15%" class="text-center">Ações</th>
                </tr>
                </thead>
                <tbody>
                @forelse($cargos as $cargo)
                    <tr>
                        <td>{{ $cargo->id }}</td>
                        <td>{{ $cargo->nome }}</td>
                        <td>{{ $cargo->descricao ?? '—' }}</td>
                        <td>
                            @if(($cargo->ativo ?? 'S') === 'S')
                                <span class="badge text-bg-success">Ativo</span>
                            @else
                                <span class="badge text-bg-secondary">Inativo</span>
                            @endif
                        </td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a class="btn btn-outline-secondary"
                                   href="{{ route('tabelas-auxiliares.cargos-equipe.form', $cargo->id) }}"
                                   title="Editar">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <form method="POST"
                                      action="{{ route('tabelas-auxiliares.cargos-equipe.destroy', $cargo->id) }}"
                                      onsubmit="return confirm('Confirma a exclusão deste cargo?');">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-outline-danger">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">Nenhum cargo cadastrado.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_CARGOS_EQUIPE_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/energias/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_ENERGIAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/energias/form.blade.php`
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

@php
    /** @var object|null $energia */
    $titulo = $energia ? 'Editar Tipo de Energia' : 'Novo Tipo de Energia';
    $rotaSalvar = $energia
        ? route('tabelas-auxiliares.energias.update', $energia->id)
        : route('tabelas-auxiliares.energias.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-bolt"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina as fontes de energia disponíveis nas tabelas auxiliares.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.energias.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($energia)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-8">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="120" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $energia->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-4">
                    <label for="idhtml" class="form-label">ID HTML</label>
                    <input type="text" id="idhtml" name="idhtml" maxlength="60" required
                           class="form-control @error('idhtml') is-invalid @enderror"
                           value="{{ old('idhtml', $energia->idhtml ?? '') }}">
                    <small class="text-muted">Identificador utilizado em relatórios/gráficos.</small>
                    @error('idhtml')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_ENERGIAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/energias/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_ENERGIAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/energias/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Tipos de Energia')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-bolt"></i>
                    Tipos de Energia
                </h5>
                <small class="text-muted">Gerencie as fontes de energia utilizadas nos cadastros de LDA.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.energias.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova energia
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-sm align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th style="width: 10%">ID</th>
                        <th>Descrição</th>
                        <th style="width: 20%">ID HTML</th>
                        <th style="width: 15%" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                @forelse($energias as $energia)
                    <tr>
                        <td>{{ $energia->id }}</td>
                        <td>{{ $energia->descricao }}</td>
                        <td><code>{{ $energia->idhtml }}</code></td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a class="btn btn-outline-secondary"
                                   href="{{ route('tabelas-auxiliares.energias.form', $energia->id) }}"
                                   title="Editar">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <form method="POST"
                                      action="{{ route('tabelas-auxiliares.energias.destroy', $energia->id) }}"
                                      onsubmit="return confirm('Confirma a exclusão deste tipo de energia?');">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-outline-danger">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="4" class="text-center text-muted py-4">Nenhuma energia cadastrada.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_ENERGIAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/esferas/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_ESFERAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/esferas/form.blade.php`
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

@php
    /** @var object|null $esfera */
    $titulo = $esfera ? 'Editar Esfera' : 'Nova Esfera';
    $rotaSalvar = $esfera
        ? route('tabelas-auxiliares.esferas.update', $esfera->id)
        : route('tabelas-auxiliares.esferas.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-landmark"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina o código estável, a descrição e a ordem da esfera.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.esferas.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($esfera)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-3">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="20" required
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $esfera->codigo ?? '') }}">
                    <small class="text-muted">Chave estável (ex.: FEDERAL, MUNICIPAL).</small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="160" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $esfera->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $esfera->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_ESFERAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/esferas/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_ESFERAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/esferas/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Esfera')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-landmark"></i>
                    Esfera
                </h5>
                <small class="text-muted">Gerencie as esferas administrativas usadas como domínio auxiliar.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.esferas.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova esfera
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.esferas.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-8">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código ou descrição">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.esferas.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Descrição</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 18%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($esferas as $esfera)
                        <tr>
                            <td>
                                <strong>Descrição:</strong> {{ $esfera->descricao }}
                            </td>
                            <td><code>{{ $esfera->codigo }}</code></td>
                            <td>{{ $esfera->ordem }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.esferas.form', $esfera->id) }}"
                                       title="Editar"
                                       aria-label="Editar esfera {{ $esfera->descricao }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.esferas.destroy', $esfera->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão desta esfera?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir esfera {{ $esfera->descricao }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhuma esfera cadastrada.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($esferas, 'links'))
            <div class="card-footer">{{ $esferas->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_ESFERAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/internets/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_INTERNETS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/internets/form.blade.php`
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

@php
    /** @var object|null $internet */
    $titulo = $internet ? 'Editar Tipo de Internet' : 'Novo Tipo de Internet';
    $rotaSalvar = $internet
        ? route('tabelas-auxiliares.internets.update', $internet->id)
        : route('tabelas-auxiliares.internets.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-wifi"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Informe as opções de conexão disponíveis nos cadastros.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.internets.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($internet)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-8">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="120" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $internet->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_INTERNETS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/internets/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_INTERNETS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/internets/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Tipos de Internet')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-wifi"></i>
                    Tipos de Internet
                </h5>
                <small class="text-muted">Cadastre as opções de conexão utilizadas nos locais de difícil acesso.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.internets.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova internet
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-sm align-middle mb-0">
                <thead class="table-light text-uppercase small">
                <tr>
                    <th style="width: 10%">ID</th>
                    <th>Descrição</th>
                    <th style="width: 15%" class="text-center">Ações</th>
                </tr>
                </thead>
                <tbody>
                @forelse($internets as $internet)
                    <tr>
                        <td>{{ $internet->id }}</td>
                        <td>{{ $internet->descricao }}</td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a class="btn btn-outline-secondary"
                                   href="{{ route('tabelas-auxiliares.internets.form', $internet->id) }}"
                                   title="Editar">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <form method="POST"
                                      action="{{ route('tabelas-auxiliares.internets.destroy', $internet->id) }}"
                                      onsubmit="return confirm('Confirma a exclusão deste tipo de internet?');">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-outline-danger">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="3" class="text-center text-muted py-4">Nenhum tipo de internet cadastrado.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_INTERNETS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/lda-recursos-logisticos/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_RECURSOS_LOGISTICOS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/lda-recursos-logisticos/form.blade.php`
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

@php
    /** @var object|null $opcao */
    $titulo = $opcao ? 'Editar Recurso logístico LDA' : 'Novo Recurso logístico LDA';
    $rotaSalvar = $opcao
        ? route('tabelas-auxiliares.lda-recursos-logisticos.update', $opcao->id)
        : route('tabelas-auxiliares.lda-recursos-logisticos.store');
    $opcaoProtegida = \App\Support\Lda\RecursoLogistico::ehUrnaSecao($opcao->codigo ?? null);
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-boxes-stacked"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina código, ordem e rótulo dos recursos logísticos.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.lda-recursos-logisticos.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($opcao)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-4">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="80" required
                           @readonly($opcaoProtegida)
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $opcao->codigo ?? '') }}">
                    <small class="text-muted">
                        {{ $opcaoProtegida ? 'Código técnico protegido; nome, ordem, peso e estado continuam editáveis.' : 'Chave estável de referência técnica.' }}
                    </small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-5">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" id="nome" name="nome" maxlength="160" required
                           class="form-control @error('nome') is-invalid @enderror"
                           value="{{ old('nome', $opcao->nome ?? '') }}">
                    @error('nome')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $opcao->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>
                <div class="col-12 col-md-3">
                    <label for="peso_unitario_kg" class="form-label">Peso unitário kg</label>
                    <input type="number" id="peso_unitario_kg" name="peso_unitario_kg" min="0" step="0.001" required
                           class="form-control @error('peso_unitario_kg') is-invalid @enderror"
                           value="{{ old('peso_unitario_kg', $opcao->peso_unitario_kg ?? 0) }}">
                    @error('peso_unitario_kg')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12">
                    <div class="form-check">
                        <input type="checkbox" id="ativo" name="ativo" value="1" class="form-check-input" @checked(old('ativo', isset($opcao) ? (int) ($opcao->ativo ?? 0) === 1 : true))>
                        <label class="form-check-label" for="ativo">Recurso ativo</label>
                    </div>
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_RECURSOS_LOGISTICOS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/lda-recursos-logisticos/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_RECURSOS_LOGISTICOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/lda-recursos-logisticos/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Recursos logísticos LDA')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-boxes-stacked"></i>
                    Recursos logísticos LDA
                </h5>
                <small class="text-muted">Gerencie as opções de recursos disponíveis para LDA e Locais de Votação.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.lda-recursos-logisticos.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Novo recurso
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.lda-recursos-logisticos.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-5">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código ou nome">
                </div>
                <div class="col-12 col-md-3">
                    <label for="ativo" class="form-label">Ativo</label>
                    <select id="ativo" name="ativo" class="form-select">
                        <option value="">Todos</option>
                        <option value="1" @selected(($ativo ?? '') === '1')>Sim</option>
                        <option value="0" @selected(($ativo ?? '') === '0')>Não</option>
                    </select>
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.lda-recursos-logisticos.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Nome</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 14%;">Peso unitário kg</th>
                        <th style="width: 12%;">Ativo</th>
                        <th style="width: 16%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($opcoes as $opcao)
                        @php
                            $opcaoProtegida = \App\Support\Lda\RecursoLogistico::ehUrnaSecao($opcao->codigo ?? null);
                        @endphp
                        <tr>
                            <td>{{ $opcao->nome }}</td>
                            <td><code>{{ $opcao->codigo }}</code></td>
                            <td>{{ $opcao->ordem }}</td>
                            <td>{{ number_format((float) ($opcao->peso_unitario_kg ?? 0), 3, ",", ".") }}</td>
                            <td>{{ (int) $opcao->ativo === 1 ? 'Sim' : 'Não' }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.lda-recursos-logisticos.form', $opcao->id) }}"
                                       title="Editar"
                                       aria-label="Editar recurso logístico {{ $opcao->nome }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    @if($opcaoProtegida)
                                        <button type="button"
                                                class="btn btn-outline-secondary"
                                                disabled
                                                title="Recurso técnico protegido"
                                                aria-label="Recurso técnico {{ $opcao->nome }} não pode ser excluído">
                                            <i class="fa-solid fa-lock"></i>
                                        </button>
                                    @else
                                        <form method="POST"
                                              action="{{ route('tabelas-auxiliares.lda-recursos-logisticos.destroy', $opcao->id) }}"
                                              onsubmit="return confirm('Confirma a exclusão deste recurso logístico?');">
                                            @csrf
                                            @method('DELETE')
                                            <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir recurso logístico {{ $opcao->nome }}">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    @endif
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">Nenhum recurso logístico cadastrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($opcoes, 'links'))
            <div class="card-footer">{{ $opcoes->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_RECURSOS_LOGISTICOS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/lda-situacoes/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_SITUACOES_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/lda-situacoes/form.blade.php`
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

@php
    /** @var object|null $opcao */
    $titulo = $opcao ? 'Editar Situação LDA' : 'Nova Situação LDA';
    $rotaSalvar = $opcao
        ? route('tabelas-auxiliares.lda-situacoes.update', $opcao->id)
        : route('tabelas-auxiliares.lda-situacoes.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-list-check"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina código, ordem e rótulo das situações usadas no domínio de LDA.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.lda-situacoes.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($opcao)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-4">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="80" required
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $opcao->codigo ?? '') }}">
                    <small class="text-muted">Chave estável de referência técnica.</small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-5">
                    <label for="nome" class="form-label">Nome</label>
                    <input type="text" id="nome" name="nome" maxlength="160" required
                           class="form-control @error('nome') is-invalid @enderror"
                           value="{{ old('nome', $opcao->nome ?? '') }}">
                    @error('nome')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $opcao->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12">
                    <label for="descricao" class="form-label">Descrição</label>
                    <textarea id="descricao" name="descricao" rows="4" maxlength="500"
                              class="form-control @error('descricao') is-invalid @enderror">{{ old('descricao', $opcao->descricao ?? '') }}</textarea>
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12">
                    <div class="form-check">
                        <input type="checkbox" id="ativo" name="ativo" value="1" class="form-check-input" @checked(old('ativo', isset($opcao) ? (int) ($opcao->ativo ?? 0) === 1 : true))>
                        <label class="form-check-label" for="ativo">Situação ativa</label>
                    </div>
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_SITUACOES_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/lda-situacoes/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_SITUACOES_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/lda-situacoes/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Situações LDA')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-list-check"></i>
                    Situações LDA
                </h5>
                <small class="text-muted">Gerencie as opções administrativas que ordenam o futuro checkbox de situação do LDA.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.lda-situacoes.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova situação
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.lda-situacoes.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-5">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código, nome ou descrição">
                </div>
                <div class="col-12 col-md-3">
                    <label for="ativo" class="form-label">Ativo</label>
                    <select id="ativo" name="ativo" class="form-select">
                        <option value="">Todos</option>
                        <option value="1" @selected(($ativo ?? '') === '1')>Sim</option>
                        <option value="0" @selected(($ativo ?? '') === '0')>Não</option>
                    </select>
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.lda-situacoes.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Nome</th>
                        <th style="width: 16%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 12%;">Ativo</th>
                        <th style="width: 16%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($opcoes as $opcao)
                        <tr>
                            <td>
                                <strong>Nome:</strong> {{ $opcao->nome }} <br>
                                <strong>Descrição:</strong> {{ $opcao->descricao ?: '—' }}
                            </td>
                            <td><code>{{ $opcao->codigo }}</code></td>
                            <td>{{ $opcao->ordem }}</td>
                            <td>{{ (int) $opcao->ativo === 1 ? 'Sim' : 'Não' }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.lda-situacoes.form', $opcao->id) }}"
                                       title="Editar"
                                       aria-label="Editar situação LDA {{ $opcao->nome }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.lda-situacoes.destroy', $opcao->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão desta situação LDA?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir situação LDA {{ $opcao->nome }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">Nenhuma situação LDA cadastrada.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($opcoes, 'links'))
            <div class="card-footer">{{ $opcoes->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_LDA_SITUACOES_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/municipios/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_MUNICIPIOS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/municipios/form.blade.php`
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

@php
    /** @var object|null $municipio */
    $titulo = $municipio ? 'Editar Município' : 'Novo Município';
    $rotaSalvar = $municipio
        ? route('tabelas-auxiliares.municipios.update', $municipio->id)
        : route('tabelas-auxiliares.municipios.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-city"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina os dados oficiais do município.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.municipios.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($municipio)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-6">
                    <label for="localidade" class="form-label">Localidade</label>
                    <input type="text" id="localidade" name="localidade" maxlength="150" required
                           class="form-control @error('localidade') is-invalid @enderror"
                           value="{{ old('localidade', $municipio->localidade ?? '') }}">
                    @error('localidade')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-4">
                    <label for="cod_objeto_localidade" class="form-label">Código</label>
                    <input type="text" id="cod_objeto_localidade" name="cod_objeto_localidade" maxlength="50" required
                           class="form-control @error('cod_objeto_localidade') is-invalid @enderror"
                           value="{{ old('cod_objeto_localidade', $municipio->cod_objeto_localidade ?? '') }}">
                    @error('cod_objeto_localidade')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-4">
                    <label for="zona_id" class="form-label">Zona</label>
                    <select id="zona_id" name="zona_id" class="form-select @error('zona_id') is-invalid @enderror" required>
                        <option value="">Selecione</option>
                        @foreach($zonas as $zona)
                            <option value="{{ $zona->id }}" {{ (string) old('zona_id', $municipio->zona_id ?? '') === (string) $zona->id ? 'selected' : '' }}>
                                {{ $zona->num_zona }} · {{ $zona->descricao }}
                            </option>
                        @endforeach
                    </select>
                    @error('zona_id')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_MUNICIPIOS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/municipios/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_MUNICIPIOS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/municipios/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Municípios')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex flex-wrap gap-3 align-items-end">
                <div>
                    <h5 class="mb-1 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-city"></i>
                        Municípios
                    </h5>
                    <small class="text-muted">Cadastre as localidades e seus vínculos de zona.</small>
                </div>
                <div class="ms-auto">
                    <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.municipios.form') }}">
                        <i class="fa-solid fa-plus me-1"></i> Novo município
                    </a>
                </div>
            </div>

            <form id="filtroMunicipios" class="row g-2 mt-3" method="GET" action="{{ route('tabelas-auxiliares.municipios.listar') }}">
                <div class="col-md-6">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" class="form-control form-control-sm" id="busca" name="busca"
                           value="{{ $busca }}" placeholder="Nome ou código...">
                </div>
                <div class="col-md-4">
                    <label for="zona" class="form-label">Zona</label>
                    <select id="zona" name="zona" class="form-select form-select-sm">
                        <option value="">Todas</option>
                        @foreach($zonas as $zona)
                            <option value="{{ $zona->id }}" {{ (string) $zonaId === (string) $zona->id ? 'selected' : '' }}>
                                {{ $zona->num_zona }} · {{ $zona->descricao }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-outline-secondary btn-sm w-100">
                        <i class="fa-solid fa-filter me-1"></i> Filtrar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div id="listaMunicipios" class="mt-3">
        @include('tabelas-auxiliares.municipios.tabela', ['municipios' => $municipios])
    </div>
@endsection

@push('scripts')
    <script>
        document.addEventListener('submit', function (event) {
            if (event.target.id === 'filtroMunicipios') {
                event.preventDefault();
                const url = event.target.action + '?' + new URLSearchParams(new FormData(event.target)).toString();
                fetch(url, {
                    headers: {'X-Requested-With': 'XMLHttpRequest'}
                }).then(resp => resp.text()).then(html => {
                    document.getElementById('listaMunicipios').innerHTML = html;
                });
            }
        });
    </script>
@endpush
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_MUNICIPIOS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/municipios/tabela.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_MUNICIPIOS_TABELA_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/municipios/tabela.blade.php`
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
<div class="card shadow-sm">
    <div class="table-responsive">
        <table class="table table-striped table-hover table-sm align-middle mb-0">
            <thead class="table-light text-uppercase small">
                <tr>
                    <th style="width: 8%">ID</th>
                    <th>Localidade</th>
                    <th style="width: 15%">Código</th>
                    <th style="width: 20%">Zona</th>
                    <th style="width: 15%" class="text-center">Ações</th>
                </tr>
            </thead>
            <tbody>
            @forelse($municipios as $municipio)
                <tr>
                    <td>{{ $municipio->id }}</td>
                    <td>{{ $municipio->localidade }}</td>
                    <td><code>{{ $municipio->cod_objeto_localidade }}</code></td>
                    <td>
                        @if(!empty($municipio->num_zona))
                            {{ $municipio->num_zona }} · {{ $municipio->zona_descricao }}
                        @else
                            <span class="text-muted">Sem zona</span>
                        @endif
                    </td>
                    <td class="text-center">
                        <div class="btn-group btn-group-sm">
                            <a class="btn btn-outline-secondary"
                               href="{{ route('tabelas-auxiliares.municipios.form', $municipio->id) }}"
                               title="Editar">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </a>
                            <form method="POST"
                                  action="{{ route('tabelas-auxiliares.municipios.destroy', $municipio->id) }}"
                                  onsubmit="return confirm('Confirma a exclusão deste município?');">
                                @csrf
                                @method('DELETE')
                                <button class="btn btn-outline-danger">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="5" class="text-center text-muted py-4">Nenhum município encontrado.</td>
                </tr>
            @endforelse
            </tbody>
        </table>
    </div>
    <div class="card-footer">
        {{ $municipios->links('pagination::bootstrap-5') }}
    </div>
</div>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_MUNICIPIOS_TABELA_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/nat-vistoria-perguntas/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_NAT_VISTORIA_PERGUNTAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/nat-vistoria-perguntas/form.blade.php`
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
@section('titulo', ($pergunta ? 'Editar' : 'Nova').' pergunta da vistoria NAT')
@section('conteudo')
<div class="container py-3"><div class="d-flex justify-content-between align-items-center mb-3"><h1 class="h3 mb-0">{{ $pergunta ? 'Editar' : 'Nova' }} pergunta</h1><a class="btn btn-outline-secondary" href="{{ route('tabelas-auxiliares.nat-vistoria-perguntas.index') }}">Voltar</a></div>@if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<div class="card shadow-sm"><div class="card-body"><form method="POST" action="{{ $pergunta ? route('tabelas-auxiliares.nat-vistoria-perguntas.update', $pergunta->id) : route('tabelas-auxiliares.nat-vistoria-perguntas.store') }}">@csrf @if($pergunta)@method('PUT')@endif
<div class="row g-3"><div class="col-md-5"><label class="form-label" for="codigo">Código estável</label><input class="form-control" id="codigo" name="codigo" maxlength="50" value="{{ old('codigo', $pergunta->codigo ?? '') }}" @readonly($pergunta !== null) required></div><div class="col-md-7"><label class="form-label" for="ordem">Ordem</label><input class="form-control" id="ordem" type="number" min="1" name="ordem" value="{{ old('ordem', $pergunta->ordem ?? 1) }}" required></div><div class="col-12"><label class="form-label" for="texto">Pergunta</label><textarea class="form-control" id="texto" name="texto" maxlength="500" rows="3" required>{{ old('texto', $pergunta->texto ?? '') }}</textarea></div><div class="col-12"><input type="hidden" name="ativo" value="0"><div class="form-check"><input class="form-check-input" id="ativo" type="checkbox" name="ativo" value="1" @checked((int)old('ativo', $pergunta->ativo ?? 1) === 1)><label class="form-check-label" for="ativo">Ativa para novas vistorias</label></div></div></div><button class="btn btn-primary mt-3" type="submit"><i class="fa-solid fa-floppy-disk me-1"></i> Salvar</button></form></div></div></div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_NAT_VISTORIA_PERGUNTAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/nat-vistoria-perguntas/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_NAT_VISTORIA_PERGUNTAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/nat-vistoria-perguntas/index.blade.php`
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
@section('titulo', 'Perguntas da vistoria NAT')
@section('conteudo')
<div class="container-fluid py-3"><div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3"><h1 class="h3 mb-0">Perguntas da vistoria NAT</h1><a class="btn btn-primary" href="{{ route('tabelas-auxiliares.nat-vistoria-perguntas.form') }}"><i class="fa-solid fa-plus me-1"></i> Nova pergunta</a></div>
@if(session('status'))<div class="alert alert-success">{{ session('status') }}</div>@endif @if($errors->any())<div class="alert alert-danger"><ul class="mb-0">@foreach($errors->all() as $erro)<li>{{ $erro }}</li>@endforeach</ul></div>@endif
<form class="row g-2 mb-3" method="GET"><div class="col-md-8"><label class="form-label" for="busca">Busca</label><input class="form-control" id="busca" name="busca" value="{{ $busca }}"></div><div class="col-md-4 d-flex align-items-end gap-2"><button class="btn btn-primary" type="submit">Filtrar</button><button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#modal-exportar-perguntas-pdf"><i class="fa-solid fa-file-pdf me-1"></i> Exportar PDF</button></div></form>
<div class="table-responsive"><table class="table table-sm table-striped align-middle"><thead><tr><th>Ordem</th><th>Código</th><th>Pergunta</th><th>Status</th><th>Ações</th></tr></thead><tbody>@forelse($perguntas as $pergunta)<tr><td>{{ $pergunta->ordem }}</td><td><code>{{ $pergunta->codigo }}</code></td><td>{{ $pergunta->texto }}</td><td>{{ (int)$pergunta->ativo === 1 ? 'Ativa' : 'Inativa' }}</td><td class="text-nowrap"><a class="btn btn-sm btn-outline-primary" href="{{ route('tabelas-auxiliares.nat-vistoria-perguntas.form', $pergunta->id) }}" aria-label="Editar"><i class="fa-solid fa-pen"></i></a><form class="d-inline" method="POST" action="{{ route('tabelas-auxiliares.nat-vistoria-perguntas.situacao', $pergunta->id) }}">@csrf @method('PATCH')<input type="hidden" name="ativo" value="{{ (int)$pergunta->ativo === 1 ? 0 : 1 }}"><button class="btn btn-sm btn-outline-{{ (int)$pergunta->ativo === 1 ? 'warning' : 'success' }}" type="submit" aria-label="{{ (int)$pergunta->ativo === 1 ? 'Inativar' : 'Ativar' }}"><i class="fa-solid fa-{{ (int)$pergunta->ativo === 1 ? 'pause' : 'play' }}"></i></button></form></td></tr>@empty<tr><td colspan="5" class="text-center text-muted">Nenhuma pergunta encontrada.</td></tr>@endforelse</tbody></table></div>{{ $perguntas->links('pagination::bootstrap-5') }}</div>
<div class="modal fade" id="modal-exportar-perguntas-pdf" tabindex="-1" aria-labelledby="modal-exportar-perguntas-pdf-label" aria-hidden="true"><div class="modal-dialog"><form class="modal-content" method="GET" action="{{ route('tabelas-auxiliares.nat-vistoria-perguntas.exportar-pdf') }}" target="_blank"><div class="modal-header"><h2 class="modal-title h5" id="modal-exportar-perguntas-pdf-label">Exportar para PDF</h2><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button></div><div class="modal-body"><input type="hidden" name="busca" value="{{ $busca }}">@foreach($camposPdf as $campo => $rotulo)<div class="form-check"><input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}" id="pergunta-campo-{{ $campo }}" @checked(in_array($campo, $camposPdfPadrao, true))><label class="form-check-label" for="pergunta-campo-{{ $campo }}">{{ $rotulo }}</label></div>@endforeach</div><div class="modal-footer"><button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button><button class="btn btn-danger" type="submit">Gerar PDF</button></div></form></div></div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_NAT_VISTORIA_PERGUNTAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/nat-vistoria-perguntas/pdf.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_NAT_VISTORIA_PERGUNTAS_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/nat-vistoria-perguntas/pdf.blade.php`
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
<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><style>body{font-family:DejaVu Sans,sans-serif;font-size:10px}table{width:100%;border-collapse:collapse}th,td{border:1px solid #bbb;padding:5px}th{background:#eee}</style></head><body><h1>Perguntas da vistoria NAT</h1><p>Gerado em {{ $geradoEm }}</p><table><thead><tr>@foreach($campos as $campo)<th>{{ $rotulos[$campo] }}</th>@endforeach</tr></thead><tbody>@foreach($perguntas as $pergunta)<tr>@foreach($campos as $campo)<td>@switch($campo)@case('codigo'){{ $pergunta->codigo }}@break @case('texto'){{ $pergunta->texto }}@break @case('ordem'){{ $pergunta->ordem }}@break @case('status'){{ (int)$pergunta->ativo === 1 ? 'Ativa' : 'Inativa' }}@break @endswitch</td>@endforeach</tr>@endforeach</tbody></table></body></html>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_NAT_VISTORIA_PERGUNTAS_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/opcoes-binarias/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_OPCOES_BINARIAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/opcoes-binarias/form.blade.php`
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

@php
    /** @var object|null $opcao */
    $titulo = $opcao ? 'Editar Opção Binária' : 'Nova Opção Binária';
    $rotaSalvar = $opcao
        ? route('tabelas-auxiliares.opcoes-binarias.update', $opcao->id)
        : route('tabelas-auxiliares.opcoes-binarias.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-toggle-on"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina a descrição e a ordem da opção do tipo Sim/Não.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.opcoes-binarias.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($opcao)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-3">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="20" required
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $opcao->codigo ?? '') }}">
                    <small class="text-muted">Chave estável (ex.: SIM, NAO).</small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="160" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $opcao->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $opcao->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_OPCOES_BINARIAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/opcoes-binarias/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_OPCOES_BINARIAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/opcoes-binarias/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Opção Binária')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-toggle-on"></i>
                    Opção Binária
                </h5>
                <small class="text-muted">Gerencie as opções do tipo Sim/Não usadas como domínio auxiliar.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.opcoes-binarias.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova opção
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.opcoes-binarias.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-8">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Descrição">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.opcoes-binarias.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Descrição</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 18%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($opcoes as $opcao)
                        <tr>
                            <td>
                                <strong>Descrição:</strong> {{ $opcao->descricao }}
                            </td>
                            <td><code>{{ $opcao->codigo }}</code></td>
                            <td>{{ $opcao->ordem }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.opcoes-binarias.form', $opcao->id) }}"
                                       title="Editar"
                                       aria-label="Editar opção binária {{ $opcao->descricao }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.opcoes-binarias.destroy', $opcao->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão desta opção binária?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir opção binária {{ $opcao->descricao }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhuma opção binária cadastrada.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($opcoes, 'links'))
            <div class="card-footer">{{ $opcoes->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_OPCOES_BINARIAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/operadoras/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_OPERADORAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/operadoras/form.blade.php`
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

@php
    /** @var object|null $operadora */
    $titulo = $operadora ? 'Editar Operadora' : 'Nova Operadora';
    $rotaSalvar = $operadora
        ? route('tabelas-auxiliares.operadoras.update', $operadora->id)
        : route('tabelas-auxiliares.operadoras.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-signal"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina o código estável, a descrição e a ordem da operadora.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.operadoras.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($operadora)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-3">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="20" required
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $operadora->codigo ?? '') }}">
                    <small class="text-muted">Chave estável (ex.: VIVO, CLARO).</small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="160" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $operadora->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $operadora->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_OPERADORAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/operadoras/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_OPERADORAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/operadoras/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Operadora')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-signal"></i>
                    Operadora
                </h5>
                <small class="text-muted">Gerencie as operadoras de telefonia usadas como domínio auxiliar.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.operadoras.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova operadora
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.operadoras.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-8">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código ou descrição">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.operadoras.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Descrição</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 18%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($operadoras as $operadora)
                        <tr>
                            <td>
                                <strong>Descrição:</strong> {{ $operadora->descricao }}
                            </td>
                            <td><code>{{ $operadora->codigo }}</code></td>
                            <td>{{ $operadora->ordem }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.operadoras.form', $operadora->id) }}"
                                       title="Editar"
                                       aria-label="Editar operadora {{ $operadora->descricao }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.operadoras.destroy', $operadora->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão desta operadora?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir operadora {{ $operadora->descricao }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhuma operadora cadastrada.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($operadoras, 'links'))
            <div class="card-footer">{{ $operadoras->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_OPERADORAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/qualidades/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_QUALIDADES_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/qualidades/form.blade.php`
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

@php
    /** @var object|null $qualidade */
    $titulo = $qualidade ? 'Editar Qualidade' : 'Nova Qualidade';
    $rotaSalvar = $qualidade
        ? route('tabelas-auxiliares.qualidades.update', $qualidade->id)
        : route('tabelas-auxiliares.qualidades.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-star-half-stroke"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina o código estável, a descrição e a ordem da qualidade.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.qualidades.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($qualidade)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-3">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="20" required
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $qualidade->codigo ?? '') }}">
                    <small class="text-muted">Chave estável (ex.: OTIMA, BOA).</small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="160" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $qualidade->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $qualidade->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_QUALIDADES_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/qualidades/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_QUALIDADES_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/qualidades/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Qualidade')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-star-half-stroke"></i>
                    Qualidade
                </h5>
                <small class="text-muted">Gerencie as opções de qualidade (Ótima/Boa/Regular/Ruim/Inexistente) usadas como domínio auxiliar.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.qualidades.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova qualidade
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.qualidades.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-8">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código ou descrição">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.qualidades.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Descrição</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 18%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($qualidades as $qualidade)
                        <tr>
                            <td>
                                <strong>Descrição:</strong> {{ $qualidade->descricao }}
                            </td>
                            <td><code>{{ $qualidade->codigo }}</code></td>
                            <td>{{ $qualidade->ordem }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.qualidades.form', $qualidade->id) }}"
                                       title="Editar"
                                       aria-label="Editar qualidade {{ $qualidade->descricao }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.qualidades.destroy', $qualidade->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão desta qualidade?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir qualidade {{ $qualidade->descricao }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhuma qualidade cadastrada.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($qualidades, 'links'))
            <div class="card-footer">{{ $qualidades->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_QUALIDADES_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/tipos-sinal/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_SINAL_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/tipos-sinal/form.blade.php`
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

@php
    /** @var object|null $tipoSinal */
    $titulo = $tipoSinal ? 'Editar Tipo de Sinal' : 'Novo Tipo de Sinal';
    $rotaSalvar = $tipoSinal
        ? route('tabelas-auxiliares.tipos-sinal.update', $tipoSinal->id)
        : route('tabelas-auxiliares.tipos-sinal.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-tower-cell"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina o código estável, a descrição e a ordem do tipo de sinal.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.tipos-sinal.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($tipoSinal)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-3">
                    <label for="codigo" class="form-label">Código</label>
                    <input type="text" id="codigo" name="codigo" maxlength="20" required
                           class="form-control @error('codigo') is-invalid @enderror"
                           value="{{ old('codigo', $tipoSinal->codigo ?? '') }}">
                    <small class="text-muted">Chave estável (ex.: 3G, 4G, 5G).</small>
                    @error('codigo')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-6">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="160" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $tipoSinal->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-3">
                    <label for="ordem" class="form-label">Ordem</label>
                    <input type="number" id="ordem" name="ordem" min="0" required
                           class="form-control @error('ordem') is-invalid @enderror"
                           value="{{ old('ordem', $tipoSinal->ordem ?? 0) }}">
                    @error('ordem')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_SINAL_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/tipos-sinal/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_SINAL_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/tipos-sinal/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Tipo de Sinal')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-tower-cell"></i>
                    Tipo de Sinal
                </h5>
                <small class="text-muted">Gerencie os tipos de sinal móvel (3G/4G/5G) usados como domínio auxiliar.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.tipos-sinal.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Novo tipo de sinal
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.tipos-sinal.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-8">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código ou descrição">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.tipos-sinal.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Descrição</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 18%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($tiposSinal as $tipoSinal)
                        <tr>
                            <td>
                                <strong>Descrição:</strong> {{ $tipoSinal->descricao }}
                            </td>
                            <td><code>{{ $tipoSinal->codigo }}</code></td>
                            <td>{{ $tipoSinal->ordem }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.tipos-sinal.form', $tipoSinal->id) }}"
                                       title="Editar"
                                       aria-label="Editar tipo de sinal {{ $tipoSinal->descricao }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.tipos-sinal.destroy', $tipoSinal->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão deste tipo de sinal?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir tipo de sinal {{ $tipoSinal->descricao }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhum tipo de sinal cadastrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($tiposSinal, 'links'))
            <div class="card-footer">{{ $tiposSinal->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_SINAL_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/tipos-tomada/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_TOMADA_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/tipos-tomada/form.blade.php`
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

@php
    /** @var object|null $tipoTomada */
    $titulo = $tipoTomada ? 'Editar Tipo de Tomada' : 'Novo Tipo de Tomada';
    $rotaSalvar = $tipoTomada
        ? route('tabelas-auxiliares.tipos-tomada.update', $tipoTomada->id)
        : route('tabelas-auxiliares.tipos-tomada.store');
@endphp

@section('titulo', 'Tabelas Auxiliares - ' . $titulo)

@section('conteudo')
    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm col-md-8 offset-md-2">
        <div class="card-body bg-light border-bottom">
            <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                <i class="fa-solid fa-plug"></i>
                {{ $titulo }}
            </h5>
            <small class="text-muted">Preencha as informações do tipo de tomada.</small>
        </div>

        <form method="POST" action="{{ $rotaSalvar }}" class="card-body row g-3">
            @csrf
            @if($tipoTomada)
                @method('PUT')
            @endif

            <div class="col-md-4">
                <label for="codigo" class="form-label">Código lógico <span class="text-danger">*</span></label>
                <input type="text"
                       id="codigo"
                       name="codigo"
                       class="form-control"
                       value="{{ old('codigo', $tipoTomada->codigo ?? '') }}"
                       placeholder="EX.: 3PINOS_NBR"
                       maxlength="20"
                       required>
                <div class="form-text">Código estável em maiúsculo (A-Z, 0-9 e _).</div>
            </div>

            <div class="col-md-8">
                <label for="descricao" class="form-label">Descrição <span class="text-danger">*</span></label>
                <input type="text"
                       id="descricao"
                       name="descricao"
                       class="form-control"
                       value="{{ old('descricao', $tipoTomada->descricao ?? '') }}"
                       placeholder="EX.: 3 pinos (NBR)"
                       maxlength="160"
                       required>
                <div class="form-text">Rótulo textual apresentado nas opções de seleção.</div>
            </div>

            <div class="col-md-4">
                <label for="ordem" class="form-label">Ordem <span class="text-danger">*</span></label>
                <input type="number"
                       id="ordem"
                       name="ordem"
                       class="form-control"
                       value="{{ old('ordem', $tipoTomada->ordem ?? 0) }}"
                       min="0"
                       required>
                <div class="form-text">Define o posicionamento nas listas (ordem crescente).</div>
            </div>

            <div class="col-12 border-top pt-3 d-flex gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                </button>
                <a href="{{ route('tabelas-auxiliares.tipos-tomada.index') }}" class="btn btn-outline-secondary">
                    Voltar
                </a>
            </div>
        </form>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_TOMADA_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/tipos-tomada/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_TOMADA_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/tipos-tomada/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Tipo de Tomada')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    @if ($errors->any())
        <div class="alert alert-warning small">
            <ul class="mb-0 ps-3">
                @foreach ($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-plug"></i>
                    Tipo de Tomada
                </h5>
                <small class="text-muted">Gerencie os tipos de tomadas elétricas usados como domínio auxiliar.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.tipos-tomada.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Novo tipo de tomada
            </a>
        </div>

        <div class="card-body border-top">
            <form method="GET" action="{{ route('tabelas-auxiliares.tipos-tomada.index') }}" class="row g-3 align-items-end">
                <div class="col-12 col-md-8">
                    <label for="busca" class="form-label">Buscar</label>
                    <input type="text" id="busca" name="busca" class="form-control" value="{{ $busca ?? '' }}" placeholder="Código ou descrição">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i> Filtrar</button>
                    <a href="{{ route('tabelas-auxiliares.tipos-tomada.index') }}" class="btn btn-outline-secondary flex-fill">Limpar</a>
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Descrição</th>
                        <th style="width: 18%;">Código</th>
                        <th style="width: 12%;">Ordem</th>
                        <th style="width: 18%;" class="text-center">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($tiposTomada as $tipo)
                        <tr>
                            <td>
                                <strong>Descrição:</strong> {{ $tipo->descricao }}
                            </td>
                            <td><code>{{ $tipo->codigo }}</code></td>
                            <td>{{ $tipo->ordem }}</td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm">
                                    <a class="btn btn-outline-secondary"
                                       href="{{ route('tabelas-auxiliares.tipos-tomada.form', $tipo->id) }}"
                                       title="Editar"
                                       aria-label="Editar tipo de tomada {{ $tipo->descricao }}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <form method="POST"
                                          action="{{ route('tabelas-auxiliares.tipos-tomada.destroy', $tipo->id) }}"
                                          onsubmit="return confirm('Confirma a exclusão deste tipo de tomada?');">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-outline-danger" title="Excluir" aria-label="Excluir tipo de tomada {{ $tipo->descricao }}">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Nenhum tipo de tomada cadastrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        @if (method_exists($tiposTomada, 'links'))
            <div class="card-footer">{{ $tiposTomada->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_TIPOS_TOMADA_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/_form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA__FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/_form.blade.php`
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
@php
    $errors = $errors ?? new \Illuminate\Support\ViewErrorBag();
    $editando = $registro !== null;
    $territorioEfetivo = $registro ?? $territorio;
    $tituloFormulario = $editando ? 'Editar percentual aplicado' : 'Cadastrar percentual aplicado';
    $rotaSalvar = $editando
        ? route('tabelas-auxiliares.urnas-contingencia-urbana.update', $registro->id)
        : route('tabelas-auxiliares.urnas-contingencia-urbana.store');
    $zonaSelecionada = old('zona_id', $territorioEfetivo->zona_id ?? '');
    $municipioSelecionado = old('municipio_id', $territorioEfetivo->municipio_id ?? '');
    $percentual = old('percentual');
    if ($percentual === null && $editando) {
        $percentual = number_format((float) $registro->percentual, 2, ',', '');
    } elseif ($percentual === null && $territorioEfetivo !== null) {
        $percentual = '15,00';
    }
    $qtdUrnaAuditoria = old(
        'qtd_urna_auditoria',
        $registro->qtd_urna_auditoria ?? 0
    );
@endphp

<form method="POST" action="{{ $rotaSalvar }}"
      class="{{ $modal ? 'modal-content' : 'row g-3' }}"
      data-percentual-contingencia-form>
    @csrf
    @if($editando)
        @method('PUT')
    @endif
    @if($territorioToken !== null)
        <input type="hidden" name="territorio_token" value="{{ $territorioToken }}">
    @endif

    @if($modal)
        <div class="modal-header">
            <h2 class="modal-title h5" id="modalPercentualContingenciaLabel">
                <i class="fa-solid fa-percent text-primary me-2"></i>{{ $tituloFormulario }}
            </h2>
            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button>
        </div>
        <div class="modal-body">
            <p class="text-muted small">O percentual será aplicado a UC URBANA e UC RURAL SC deste território.</p>
    @endif

    <div class="alert alert-warning small {{ $modal ? '' : 'col-12' }} {{ isset($errors) && $errors->any() ? '' : 'd-none' }}"
         role="alert" tabindex="-1" data-percentual-contingencia-erros>
        <ul class="mb-0 ps-3">
            @if(isset($errors))
                @foreach($errors->all() as $erro)
                    <li>{{ $erro }}</li>
                @endforeach
            @endif
        </ul>
    </div>

    @if($modal)
        <div class="row g-3">
    @endif
        @if($bloquearTerritorio)
            <div class="col-12 col-md-3">
                <label class="form-label" for="percentual_contingencia_zona">Zona</label>
                <input class="form-control" id="percentual_contingencia_zona" type="text"
                       value="{{ $territorioEfetivo->num_zona }} · {{ $territorioEfetivo->zona_descricao }}"
                       disabled>
                <input type="hidden" name="zona_id" value="{{ $zonaSelecionada }}">
            </div>

            <div class="col-12 col-md-4">
                <label class="form-label" for="percentual_contingencia_municipio">Município</label>
                <input class="form-control" id="percentual_contingencia_municipio" type="text"
                       value="{{ $territorioEfetivo->municipio }}" disabled>
                <input type="hidden" name="municipio_id" value="{{ $municipioSelecionado }}">
            </div>
        @else
            <div class="col-12 col-md-3">
                <label class="form-label" for="zona_id">Zona</label>
                <select class="form-select @error('zona_id') is-invalid @enderror"
                        id="zona_id" name="zona_id" required>
                    <option value="">Selecione</option>
                    @foreach($zonas as $zona)
                        <option value="{{ $zona->id }}" @selected((string) $zonaSelecionada === (string) $zona->id)>
                            {{ $zona->num_zona }} · {{ $zona->descricao }}
                        </option>
                    @endforeach
                </select>
                @error('zona_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>

            <div class="col-12 col-md-4">
                <label class="form-label" for="municipio_id">Município</label>
                <select class="form-select @error('municipio_id') is-invalid @enderror"
                        id="municipio_id" name="municipio_id" data-exigir-zona="1" required>
                    <option value="">Selecione a Zona primeiro</option>
                    @foreach($municipios as $municipio)
                        <option value="{{ $municipio->id }}"
                                data-zona-id="{{ $municipio->zona_id }}"
                                @selected((string) $municipioSelecionado === (string) $municipio->id)>
                            {{ $municipio->localidade }}
                        </option>
                    @endforeach
                </select>
                @error('municipio_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>
        @endif

        <div class="col-12 col-md-2">
            <label class="form-label" for="percentual">Percentual</label>
            <div class="input-group">
                <input class="form-control @error('percentual') is-invalid @enderror"
                       id="percentual" name="percentual" type="text" inputmode="decimal"
                       maxlength="6" value="{{ $percentual }}" placeholder="0,00" required>
                <span class="input-group-text">%</span>
                @error('percentual')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>
        </div>

        <div class="col-12 col-md-3">
            <label class="form-label" for="qtd_urna_auditoria">Qtd. urnas de auditoria</label>
            <input class="form-control @error('qtd_urna_auditoria') is-invalid @enderror"
                   id="qtd_urna_auditoria" name="qtd_urna_auditoria" type="number"
                   inputmode="numeric" min="0" max="9999999999" step="1"
                   value="{{ $qtdUrnaAuditoria }}" required>
            @error('qtd_urna_auditoria')<div class="invalid-feedback">{{ $message }}</div>@enderror
        </div>
    @if($modal)
        </div>
    @endif

    @if($modal)
        </div>
        <div class="modal-footer">
            <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-primary" type="submit" data-percentual-contingencia-salvar>
                <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
            </button>
        </div>
    @else
        <div class="col-12 text-end">
            <button class="btn btn-primary" type="submit">
                <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
            </button>
        </div>
    @endif
</form>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA__FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/_municipios-script.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA__MUNICIPIOS_SCRIPT_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/_municipios-script.blade.php`
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const zona = document.getElementById('zona_id');
        const municipio = document.getElementById('municipio_id');

        if (!zona || !municipio) {
            return;
        }

        const filtrarMunicipios = function (limparSelecao) {
            if (limparSelecao) {
                municipio.value = '';
            }

            const zonaSelecionada = zona.value;
            const exigirZona = municipio.dataset.exigirZona === '1';

            Array.from(municipio.options).forEach(function (opcao, indice) {
                if (indice === 0) {
                    return;
                }

                const permitida = zonaSelecionada !== ''
                    ? opcao.dataset.zonaId === zonaSelecionada
                    : !exigirZona;
                opcao.hidden = !permitida;
                opcao.disabled = !permitida;
            });
        };

        zona.addEventListener('change', function () {
            filtrarMunicipios(true);
        });
        filtrarMunicipios(false);
    });
</script>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA__MUNICIPIOS_SCRIPT_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/form.blade.php`
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

@php
    $editando = $registro !== null;
    $titulo = $editando ? 'Editar percentual' : 'Novo percentual';
@endphp

@section('titulo', $titulo.' de urnas de contingência')

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center gap-2 mb-3">
                <div>
                    <h1 class="h4 mb-1 text-primary">
                        <i class="fa-solid fa-percent me-1"></i> {{ $titulo }}
                    </h1>
                    <p class="text-muted small mb-0">Informe a combinação territorial e o percentual entre 0,00% e 100,00%.</p>
                </div>
                <a class="btn btn-outline-secondary btn-sm" href="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.index') }}">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @include('tabelas-auxiliares.urnas-contingencia-urbana._form')
        </div>
    </div>
@endsection

@push('scripts')
    @include('tabelas-auxiliares.urnas-contingencia-urbana._municipios-script')
@endpush
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/index.blade.php`
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

@section('titulo', 'Percentuais de urnas de contingência')

@section('conteudo')
    @if(session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
                <div>
                    <h1 class="h4 mb-1 text-primary">
                        <i class="fa-solid fa-percent me-1"></i>
                        Percentuais de urnas de contingência
                    </h1>
                    <p class="text-muted small mb-0">Cadastre o percentual aplicável a cada combinação de Zona e Município.</p>
                </div>
                <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.form') }}">
                    <i class="fa-solid fa-plus me-1"></i> Novo percentual
                </a>
            </div>

            <form class="row g-2 mt-3" method="GET" action="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.index') }}">
                <div class="col-12 col-md-4">
                    <label class="form-label" for="zona_id">Zona</label>
                    <select class="form-select form-select-sm" id="zona_id" name="zona_id">
                        <option value="">Todas</option>
                        @foreach($zonas as $zona)
                            <option value="{{ $zona->id }}" @selected((string) $zonaId === (string) $zona->id)>
                                {{ $zona->num_zona }} · {{ $zona->descricao }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-12 col-md-4">
                    <label class="form-label" for="municipio_id">Município</label>
                    <select class="form-select form-select-sm" id="municipio_id" name="municipio_id" data-exigir-zona="0">
                        <option value="">Todos</option>
                        @foreach($municipios as $municipio)
                            <option value="{{ $municipio->id }}"
                                    data-zona-id="{{ $municipio->zona_id }}"
                                    @selected((string) $municipioId === (string) $municipio->id)>
                                {{ $municipio->localidade }} · Zona {{ $municipio->num_zona }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-12 col-md-4 d-flex align-items-end gap-2">
                    <button class="btn btn-outline-primary btn-sm flex-fill" type="submit">
                        <i class="fa-solid fa-filter me-1"></i> Filtrar
                    </button>
                    <a class="btn btn-outline-secondary btn-sm flex-fill" href="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.index') }}">
                        Limpar
                    </a>
                    <button class="btn btn-outline-danger btn-sm flex-fill" type="button"
                            data-bs-toggle="modal" data-bs-target="#modal-exportar-urnas-urbanas-pdf">
                        <i class="fa-solid fa-file-pdf me-1"></i> Exportar para PDF
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card shadow-sm mt-3">
        <div class="table-responsive">
            <table class="table table-sm table-striped align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Configuração</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                @forelse($registros as $registro)
                    <tr>
                        <td>
                            <strong>Zona:</strong> {{ $registro->num_zona }} · {{ $registro->zona_descricao }}<br>
                            <strong>Município:</strong> {{ $registro->municipio }}<br>
                            <strong>Percentual:</strong> {{ number_format((float) $registro->percentual, 2, ',', '.') }}%<br>
                            <strong>Qtd. urnas de auditoria:</strong> {{ number_format((int) $registro->qtd_urna_auditoria, 0, ',', '.') }}
                        </td>
                        <td class="text-nowrap">
                            <a class="btn btn-sm btn-outline-primary"
                               href="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.form', $registro->id) }}"
                               title="Editar percentual" aria-label="Editar percentual">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </a>
                            <form class="d-inline" method="POST"
                                  action="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.destroy', $registro->id) }}"
                                  onsubmit="return confirm('Confirma a exclusão deste percentual?');">
                                @csrf
                                @method('DELETE')
                                <button class="btn btn-sm btn-outline-danger" type="submit"
                                        title="Excluir percentual" aria-label="Excluir percentual">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="2" class="text-center text-muted py-4">Nenhum percentual encontrado.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
        @if($registros->hasPages())
            <div class="card-footer">
                {{ $registros->links('pagination::bootstrap-5') }}
            </div>
        @endif
    </div>

    <div class="modal fade" id="modal-exportar-urnas-urbanas-pdf" tabindex="-1"
         aria-labelledby="modal-exportar-urnas-urbanas-pdf-label" aria-hidden="true">
        <div class="modal-dialog">
            <form class="modal-content" method="GET"
                  action="{{ route('tabelas-auxiliares.urnas-contingencia-urbana.exportar-pdf') }}">
                <div class="modal-header">
                    <h2 class="modal-title h5" id="modal-exportar-urnas-urbanas-pdf-label">Exportar para PDF</h2>
                    <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="zona_id" value="{{ $zonaId }}">
                    <input type="hidden" name="municipio_id" value="{{ $municipioId }}">
                    @foreach($camposPdf as $campo => $rotulo)
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="campos[]" value="{{ $campo }}"
                                   id="urna-urbana-campo-{{ $campo }}"
                                   @checked(in_array($campo, $camposPdfPadrao, true))>
                            <label class="form-check-label" for="urna-urbana-campo-{{ $campo }}">{{ $rotulo }}</label>
                        </div>
                    @endforeach
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline-secondary" type="button" data-bs-dismiss="modal">Cancelar</button>
                    <button class="btn btn-danger" type="submit">
                        <i class="fa-solid fa-file-pdf me-1"></i> Gerar PDF
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection

@push('scripts')
    @include('tabelas-auxiliares.urnas-contingencia-urbana._municipios-script')
@endpush
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/pdf.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA_PDF_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/urnas-contingencia-urbana/pdf.blade.php`
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
        body { font-family: DejaVu Sans, sans-serif; font-size: 10px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #bbb; padding: 5px; text-align: left; }
        th { background: #eee; }
        .numero { text-align: right; }
    </style>
</head>
<body>
    <h1>Percentuais de urnas de contingência</h1>
    <p>Gerado em {{ $geradoEm }}</p>
    <table>
        <thead>
            <tr>
                @foreach($campos as $campo)
                    <th>{{ $rotulos[$campo] }}</th>
                @endforeach
            </tr>
        </thead>
        <tbody>
        @forelse($registros as $registro)
            <tr>
                @foreach($campos as $campo)
                    <td @class(['numero' => in_array($campo, ['percentual', 'qtd_urna_auditoria'], true)])>
                        @switch($campo)
                            @case('zona')
                                {{ $registro->num_zona }} · {{ $registro->zona_descricao }}
                                @break
                            @case('municipio')
                                {{ $registro->municipio }}
                                @break
                            @case('percentual')
                                {{ number_format((float) $registro->percentual, 2, ',', '.') }}%
                                @break
                            @case('qtd_urna_auditoria')
                                {{ number_format((int) $registro->qtd_urna_auditoria, 0, ',', '.') }}
                                @break
                        @endswitch
                    </td>
                @endforeach
            </tr>
        @empty
            <tr><td colspan="{{ count($campos) }}">Nenhum percentual encontrado.</td></tr>
        @endforelse
        </tbody>
    </table>
</body>
</html>
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_URNAS_CONTINGENCIA_URBANA_PDF_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/zonas/form.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_ZONAS_FORM_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/zonas/form.blade.php`
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

@php
    /** @var object|null $zona */
    $titulo = $zona ? 'Editar Zona' : 'Nova Zona';
    $rotaSalvar = $zona
        ? route('tabelas-auxiliares.zonas.update', $zona->id)
        : route('tabelas-auxiliares.zonas.store');
@endphp

@section('titulo', $titulo)

@section('conteudo')
    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                        <i class="fa-solid fa-layer-group"></i>
                        {{ $titulo }}
                    </h5>
                    <small class="text-muted">Defina o número e a descrição utilizados nos cadastros dependentes.</small>
                </div>
                <a href="{{ route('tabelas-auxiliares.zonas.index') }}" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left-long me-1"></i> Voltar
                </a>
            </div>

            @if ($errors->any())
                <div class="alert alert-warning small">
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $erro)
                            <li>{{ $erro }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form method="POST" action="{{ $rotaSalvar }}" class="row g-3">
                @csrf
                @if ($zona)
                    @method('PUT')
                @endif

                <div class="col-12 col-md-4">
                    <label for="num_zona" class="form-label">Número</label>
                    <input type="number" id="num_zona" name="num_zona" min="1" required
                           class="form-control @error('num_zona') is-invalid @enderror"
                           value="{{ old('num_zona', $zona->num_zona ?? '') }}">
                    @error('num_zona')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 col-md-8">
                    <label for="descricao" class="form-label">Descrição</label>
                    <input type="text" id="descricao" name="descricao" maxlength="150" required
                           class="form-control @error('descricao') is-invalid @enderror"
                           value="{{ old('descricao', $zona->descricao ?? '') }}">
                    @error('descricao')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>

                <div class="col-12 text-end">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Salvar
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_ZONAS_FORM_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `resources/views/tabelas-auxiliares/zonas/index.blade.php`
## <RESOURCES_VIEWS_TABELAS_AUXILIARES_ZONAS_INDEX_BLADE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `resources/views/tabelas-auxiliares/zonas/index.blade.php`
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

@section('titulo', 'Tabelas Auxiliares - Zonas')

@section('conteudo')
    @if (session('status'))
        <div class="alert alert-success d-flex align-items-center gap-2 small">
            <i class="fa-solid fa-circle-check"></i>
            <span>{{ session('status') }}</span>
        </div>
    @endif

    <div class="card shadow-sm">
        <div class="card-body d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h5 class="mb-0 text-primary d-flex align-items-center gap-2">
                    <i class="fa-solid fa-layer-group"></i>
                    Zonas Eleitorais
                </h5>
                <small class="text-muted">Gerencie a numeração e descrição das zonas para os demais cadastros.</small>
            </div>
            <a class="btn btn-primary btn-sm" href="{{ route('tabelas-auxiliares.zonas.form') }}">
                <i class="fa-solid fa-plus me-1"></i> Nova zona
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-sm align-middle mb-0">
                <thead class="table-light text-uppercase small">
                <tr>
                    <th style="width: 10%">ID</th>
                    <th style="width: 15%">Número</th>
                    <th>Descrição</th>
                    <th style="width: 15%" class="text-center">Ações</th>
                </tr>
                </thead>
                <tbody>
                @forelse($zonas as $zona)
                    <tr>
                        <td>{{ $zona->id }}</td>
                        <td><span class="badge bg-primary-subtle text-primary">{{ $zona->num_zona }}</span></td>
                        <td>{{ $zona->descricao }}</td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a class="btn btn-outline-secondary"
                                   href="{{ route('tabelas-auxiliares.zonas.form', $zona->id) }}"
                                   title="Editar">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <form method="POST"
                                      action="{{ route('tabelas-auxiliares.zonas.destroy', $zona->id) }}"
                                      onsubmit="return confirm('Confirma a exclusão desta zona?');">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-outline-danger">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="4" class="text-center text-muted py-4">Nenhuma zona cadastrada.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
```
</RESOURCES_VIEWS_TABELAS_AUXILIARES_ZONAS_INDEX_BLADE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/GelSyncWebTest.php`
## <TESTS_FEATURE_GELSYNCWEBTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/GelSyncWebTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class GelSyncWebTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_post_web_gel_ac_exige_admin_e_nao_executa_para_usuario_sem_permissao(): void
public function test_post_web_gel_ac_delega_para_service_e_registra_sucesso(): void
public function __construct(array $resultado, private ?Throwable $erro = null)
public function sincronizarAcCompleto(?string $syncRunId = null): array
public function registrarSucesso(string $rotina, array $resultado = [], array $meta = []): void
public function registrarErro(string $rotina, Throwable|string $erro, array $meta = []): void
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
use App\Http\Middleware\RequireMacroprojetoTurnoContext;
use App\Services\Gel\GelSyncService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use Tests\TestCase;
use Throwable;

class GelSyncWebTest extends TestCase
{
    public function test_post_web_gel_ac_exige_admin_e_nao_executa_para_usuario_sem_permissao(): void
    {
        $this->withoutMiddleware([ConfigureUserSession::class, AuthorizeRouteAccess::class, RequireMacroprojetoContext::class, RequireMacroprojetoTurnoContext::class]);
        $service = new GelSyncServiceWebFake([
            'dblink' => 'cad_tse',
            'sync_run_id' => 'RUN-WEB',
            'origem_total' => 1,
            'destino_total' => 1,
            'etapas' => [],
        ]);
        $status = new LocalVotacaoSyncStatusServiceWebFake();

        $this->app->instance(GelSyncService::class, $service);
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->withSession([
            'is_admin' => false,
            'rotas_permitidas' => [],
        ])->post('/sincronizacao/gel/ac/executar')
            ->assertForbidden();

        $this->assertSame(0, $service->chamadas);
        $this->assertCount(0, $status->sucessos);
        $this->assertCount(0, $status->erros);
    }

    public function test_post_web_gel_ac_delega_para_service_e_registra_sucesso(): void
    {
        $this->withoutMiddleware([ConfigureUserSession::class, AuthorizeRouteAccess::class, RequireMacroprojetoContext::class, RequireMacroprojetoTurnoContext::class]);
        $resultado = [
            'dblink' => 'cad_tse',
            'sync_run_id' => 'RUN-WEB',
            'origem_total' => 12,
            'destino_total' => 12,
            'etapas' => [
                'formulario' => ['dblink' => 'cad_tse', 'origem_total' => 1, 'destino_total' => 1],
            ],
        ];
        $service = new GelSyncServiceWebFake($resultado);
        $status = new LocalVotacaoSyncStatusServiceWebFake();

        $this->app->instance(GelSyncService::class, $service);
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->withSession([
            'is_admin' => true,
            'matchingGroups' => ['PLANELEITO_ADMIN'],
            'rotas_permitidas' => ['administracao-global.sync-gel.ac.executar'],
        ])->post('/sincronizacao/gel/ac/executar')
            ->assertOk()
            ->assertJsonPath('mensagem', 'Sincronização GEL AC concluída com sucesso.')
            ->assertJsonPath('resultado.dblink', 'cad_tse')
            ->assertJsonPath('resultado.origem_total', 12)
            ->assertJsonPath('resultado.destino_total', 12);

        $this->assertSame(1, $service->chamadas);
        $this->assertCount(1, $status->sucessos);
        $this->assertSame('sync:gel:ac', $status->sucessos[0]['rotina']);
        $this->assertSame($resultado, $status->sucessos[0]['resultado']);
        $this->assertSame('gel_ac', $status->sucessos[0]['meta']['etapa'] ?? null);
        $this->assertSame('interface-web', $status->sucessos[0]['meta']['origem'] ?? null);
    }
}

class GelSyncServiceWebFake extends GelSyncService
{
    public int $chamadas = 0;

    /** @var array<string, mixed> */
    private array $resultado;

    public function __construct(array $resultado, private ?Throwable $erro = null)
    {
        $this->resultado = $resultado;
    }

    public function sincronizarAcCompleto(?string $syncRunId = null): array
    {
        $this->chamadas++;

        if ($this->erro !== null) {
            throw $this->erro;
        }

        return $this->resultado;
    }
}

class LocalVotacaoSyncStatusServiceWebFake extends LocalVotacaoSyncStatusService
{
    /** @var list<array{rotina:string,resultado:array<string, mixed>,meta:array<string, mixed>}> */
    public array $sucessos = [];

    /** @var list<array{rotina:string,erro:Throwable|string,meta:array<string, mixed>}> */
    public array $erros = [];

    public function registrarSucesso(string $rotina, array $resultado = [], array $meta = []): void
    {
        $this->sucessos[] = [
            'rotina' => $rotina,
            'resultado' => $resultado,
            'meta' => $meta,
        ];
    }

    public function registrarErro(string $rotina, Throwable|string $erro, array $meta = []): void
    {
        $this->erros[] = [
            'rotina' => $rotina,
            'erro' => $erro,
            'meta' => $meta,
        ];
    }
}
```
</TESTS_FEATURE_GELSYNCWEBTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Feature/SeuVotoImportaAdminEscopoTest.php`
## <TESTS_FEATURE_SEUVOTOIMPORTAADMINESCOPOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Feature/SeuVotoImportaAdminEscopoTest.php`
- **Namespace Declaração:** `Tests\Feature`
- **Entidade / Classe:** `class SeuVotoImportaAdminEscopoTest extends TestCase`

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
public function listagem_repassa_exatamente_o_escopo_da_sessao(
public static function escopos(): array
public function detalhe_fora_da_zona_responde_como_nao_encontrado(): void
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
use App\Http\Middleware\RequireMacroprojetoTurnoContext;
use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Support\Access\EscopoZonal;
use Illuminate\Pagination\LengthAwarePaginator;
use Mockery;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaAdminEscopoTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        $this->withoutMiddleware([
            ConfigureUserSession::class,
            AuthorizeRouteAccess::class,
            RequireMacroprojetoContext::class,
            RequireMacroprojetoTurnoContext::class,
        ]);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    /** @param list<int> $zonas */
    #[Test]
    #[DataProvider('escopos')]
    public function listagem_repassa_exatamente_o_escopo_da_sessao(
        array $zonas,
        bool $todas,
        bool $semAcesso,
    ): void {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('listarAdministrativo')->once()->with(
            Mockery::type('array'),
            Mockery::on(static fn (EscopoZonal $escopo): bool => $escopo->zonas() === $zonas
                && $escopo->acessoTodas() === $todas
                && $escopo->semAcesso() === $semAcesso),
        )->andReturn(new LengthAwarePaginator([], 0, 25));
        $repository->shouldReceive('statusSolicitacao')->once()->andReturn([]);
        $this->app->instance(SeuVotoImportaSolicitacaoRepository::class, $repository);

        $response = $this->withSession([
            'cod_zonas_permitidas' => $zonas,
            'acesso_todas_zonas' => $todas,
            'macroprojeto_ativo_id' => 15,
        ])->get('/seu-voto-importa');

        $response->assertOk();
    }

    public static function escopos(): array
    {
        return [
            'gestor da zona' => [[3], false, false],
            'administrador estadual' => [[0], true, false],
            'usuario sem zona' => [[], false, true],
        ];
    }

    #[Test]
    public function detalhe_fora_da_zona_responde_como_nao_encontrado(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarDetalheAdministrativo')->once()->with(
            99,
            Mockery::on(static fn (EscopoZonal $escopo): bool => $escopo->zonas() === [2] && !$escopo->acessoTodas()),
        )->andReturn(null);
        $this->app->instance(SeuVotoImportaSolicitacaoRepository::class, $repository);

        $response = $this->withSession([
            'cod_zonas_permitidas' => [2],
            'acesso_todas_zonas' => false,
        ])->get('/seu-voto-importa/99');

        $response->assertNotFound();
    }
}
```
</TESTS_FEATURE_SEUVOTOIMPORTAADMINESCOPOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AppServiceProviderMigrationGuardTest.php`
## <TESTS_UNIT_APPSERVICEPROVIDERMIGRATIONGUARDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AppServiceProviderMigrationGuardTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AppServiceProviderMigrationGuardTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_bloqueia_migrate_sem_path(): void
public function test_bloqueia_migrate_com_path_de_diretorio(): void
public function test_bloqueia_migrate_com_path_fora_da_pasta_de_migrations(): void
public function test_bloqueia_migrate_com_subdiretorio_ou_multiplos_arquivos(): void
public function test_permiter_migrate_com_arquivo_unico_valido(): void
public function test_permite_rollback_exclusivo_quando_laravel_entrega_path_em_array(): void
public function test_bloqueia_array_com_mais_de_uma_migration(): void
public function test_bloqueia_comandos_destrutivos_fora_de_testes(): void
public function test_nao_bloqueia_quando_ambiente_e_testing(): void
public function test_nao_bloqueia_help_do_comando(): void
public function test_force_https_e_aplicado_em_producao_e_local(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Providers\AppServiceProvider;
use Illuminate\Console\Events\CommandStarting;
use Mockery;
use Symfony\Component\Console\Exception\RuntimeException;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Tests\TestCase;

class AppServiceProviderMigrationGuardTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_bloqueia_migrate_sem_path(): void
    {
        $event = $this->makeEvent('migrate', false, null);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('MIGRAÇÃO GLOBAL BLOQUEADA');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);
    }

    public function test_bloqueia_migrate_com_path_de_diretorio(): void
    {
        $event = $this->makeEvent('migrate', false, 'database/migrations');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('database/migrations/<nome_do_arquivo>.php');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);
    }

    public function test_bloqueia_migrate_com_path_fora_da_pasta_de_migrations(): void
    {
        $event = $this->makeEvent('migrate', false, 'app/Providers/AppServiceProvider.php');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('database/migrations/<nome_do_arquivo>.php');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);
    }

    public function test_bloqueia_migrate_com_subdiretorio_ou_multiplos_arquivos(): void
    {
        $event = $this->makeEvent('migrate', false, 'database/migrations/lote/2026_01_01_000000_exemplo.php');

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('arquivo único');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);
    }

    public function test_permiter_migrate_com_arquivo_unico_valido(): void
    {
        $event = $this->makeEvent('migrate', false, 'database/migrations/2026_06_20_230000_create_macroprojeto_turno_table.php');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);

        $this->assertTrue(true);
    }

    public function test_permite_rollback_exclusivo_quando_laravel_entrega_path_em_array(): void
    {
        $event = $this->makeEvent('migrate:rollback', false, [
            'database/migrations/2026_07_26_120000_add_grupo_responsavel_to_risco_acoes.php',
        ]);

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);

        $this->assertTrue(true);
    }

    public function test_bloqueia_array_com_mais_de_uma_migration(): void
    {
        $event = $this->makeEvent('migrate:rollback', false, [
            'database/migrations/2026_07_26_120000_primeira.php',
            'database/migrations/2026_07_26_120100_segunda.php',
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('arquivo único');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);
    }

    public function test_bloqueia_comandos_destrutivos_fora_de_testes(): void
    {
        $event = $this->makeEvent('migrate:fresh', false, null);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('altamente destrutivo');

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);
    }

    public function test_nao_bloqueia_quando_ambiente_e_testing(): void
    {
        $event = $this->makeEvent('migrate', false, null);

        AppServiceProvider::guardExclusiveMigrationCommands($event, true);

        $this->assertTrue(true);
    }

    public function test_nao_bloqueia_help_do_comando(): void
    {
        $event = $this->makeEvent('migrate', true, null);

        AppServiceProvider::guardExclusiveMigrationCommands($event, false);

        $this->assertTrue(true);
    }

    public function test_force_https_e_aplicado_em_producao_e_local(): void
    {
        $this->assertTrue(AppServiceProvider::shouldForceHttps('production'));
        $this->assertTrue(AppServiceProvider::shouldForceHttps('local'));
        $this->assertFalse(AppServiceProvider::shouldForceHttps('testing'));
    }

    private function makeEvent(string $command, bool $help, mixed $path): CommandStarting
    {
        $input = Mockery::mock(InputInterface::class);
        $input->shouldReceive('hasOption')->with('help')->andReturn(true);
        $input->shouldReceive('getOption')->with('help')->andReturn($help);
        $input->shouldReceive('hasOption')->with('path')->andReturn(true);
        $input->shouldReceive('getOption')->with('path')->andReturn($path);

        $output = Mockery::mock(OutputInterface::class);

        return new CommandStarting($command, $input, $output);
    }
}
```
</TESTS_UNIT_APPSERVICEPROVIDERMIGRATIONGUARDTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/AuditaDmlGlobalContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_AUDITADMLGLOBALCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/AuditaDmlGlobalContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class AuditaDmlGlobalContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('alvo')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_controllers_nao_executam_dml(): void
public function test_services_e_repositories_de_negocio_usam_somente_o_gateway_auditado(): void
public function test_inserts_sem_id_e_em_lote_fornecem_localizador_persistido(): void
public function test_guardrail_detecta_dml_eloquent_estatico_e_chamada_multilinha(): void
public function executar(): void
public function test_inserts_filhos_de_tarefa_nao_usam_id_da_tarefa_pai_como_identidade(): void
private function localizarDmlDireto(array $diretorios, array $excecoes = []): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use PhpParser\Node\Expr\MethodCall;
use PhpParser\Node\Expr\StaticCall;
use PhpParser\Node\Identifier;
use PhpParser\Node\Name;
use PhpParser\NodeFinder;
use PhpParser\ParserFactory;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use ReflectionMethod;
use Tests\TestCase;

class AuditaDmlGlobalContractTest extends TestCase
{
    public function test_controllers_nao_executam_dml(): void
    {
        $this->assertSame([], $this->localizarDmlDireto([
            app_path('Http/Controllers'),
        ]));
    }

    public function test_services_e_repositories_de_negocio_usam_somente_o_gateway_auditado(): void
    {
        $excecoes = [
            'app/Repositories/Auditoria/AuditLogRepository.php' => 'Escrita da propria AUDITORIA_ACAO.',
            'app/Repositories/Concerns/AuditaDml.php' => 'Gateway transacional auditado.',
            'app/Repositories/ForcasSeguranca/ForcasSegurancaAcessoRepository.php' => 'Autenticacao tecnica externa.',
            'app/Services/SeuVotoImporta/SeuVotoImportaAnexoService.php' => 'Exclusao exclusiva de arquivo privado; todo DML de metadados usa repository auditado.',
            'app/Repositories/Nat/NatExternoRepository.php' => 'Autenticacao, desafio e evento tecnico externo.',
            'app/Repositories/Nat/NatRotaMensagemRepository.php' => 'Mensageria tecnica nominalmente excluida da auditoria funcional.',
            'app/Repositories/Lda/LdaConversaMensagemRepository.php' => 'Mensageria LDA nominalmente excluida da auditoria funcional.',
            'app/Repositories/Treinamentos/TreinamentoTseSyncRepository.php' => 'Sincronizacao externa do TSE.',
            'app/Services/Gel/GelSyncService.php' => 'Sincronizacao externa GEL.',
            'app/Services/Gel/GelTempoDeslocamentoService.php' => 'Reconstrucao sincronizada de tempos GEL.',
            'app/Services/LocaisVotacao/LocalVotacaoSyncService.php' => 'Sincronizacao de catalogos eleitorais.',
            'app/Services/Rcand/RcandSyncService.php' => 'Sincronizacao externa RCAND.',
            'app/Repositories/Lda/JecmonKitOnlineRepository.php' => 'Snapshot tecnico reconstruivel dos kits online do JEC-MONITOR.',
            'app/Repositories/Scde/ScdeSituacaoSecaoRepository.php' => 'Snapshot SCDE reconstruivel e metadados tecnicos da sincronizacao.',
        ];

        foreach ($excecoes as $justificativa) {
            $this->assertNotSame('', trim($justificativa));
        }

        $this->assertSame([], $this->localizarDmlDireto([
            app_path('Repositories'),
            app_path('Services'),
        ], array_keys($excecoes)));
    }

    public function test_inserts_sem_id_e_em_lote_fornecem_localizador_persistido(): void
    {
        $parser = (new ParserFactory)->createForNewestSupportedVersion();
        $finder = new NodeFinder;
        $violacoes = [];

        foreach ([app_path('Repositories'), app_path('Services')] as $diretorio) {
            $arquivos = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($diretorio, RecursiveDirectoryIterator::SKIP_DOTS)
            );

            foreach ($arquivos as $arquivo) {
                if (! $arquivo->isFile() || $arquivo->getExtension() !== 'php') {
                    continue;
                }

                $ast = $parser->parse((string) file_get_contents($arquivo->getPathname()));
                foreach ($finder->findInstanceOf($ast, MethodCall::class) as $chamada) {
                    if (! $chamada->name instanceof Identifier
                        || ! in_array($chamada->name->toString(), ['inserirSemIdAuditado', 'inserirLoteAuditado'], true)
                        || count($chamada->args) >= 5) {
                        continue;
                    }

                    $violacoes[] = str_replace(base_path().DIRECTORY_SEPARATOR, '', $arquivo->getPathname())
                        .':'.$chamada->getStartLine().' '.$chamada->name->toString();
                }
            }
        }

        sort($violacoes);
        $this->assertSame([], $violacoes);
    }

    public function test_guardrail_detecta_dml_eloquent_estatico_e_chamada_multilinha(): void
    {
        $diretorio = storage_path('framework/testing/audita-dml-guardrail');
        if (! is_dir($diretorio)) {
            mkdir($diretorio, 0777, true);
        }
        $arquivo = $diretorio.'/ViolacaoAuditavel.php';
        file_put_contents($arquivo, <<<'PHP'
<?php

namespace Tests\Fixtures;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ViolacaoAuditavel extends Model
{
    public function executar(): void
    {
        self::create(['nome' => 'estatico']);

        DB::table('alvo')
            ->where('id', 1)
            ->update(['nome' => 'multilinha']);
    }
}
PHP);

        try {
            $metodo = new ReflectionMethod($this, 'localizarDmlDireto');
            $metodo->setAccessible(true);
            $violacoes = $metodo->invoke($this, [$diretorio]);

            $this->assertCount(2, $violacoes);
            $this->assertTrue(collect($violacoes)->contains(static fn (string $item): bool => str_contains($item, 'create')));
            $this->assertTrue(collect($violacoes)->contains(static fn (string $item): bool => str_contains($item, 'update')));
        } finally {
            @unlink($arquivo);
            @rmdir($diretorio);
        }
    }

    public function test_inserts_filhos_de_tarefa_nao_usam_id_da_tarefa_pai_como_identidade(): void
    {
        $conteudo = (string) file_get_contents(app_path('Repositories/Tarefas/TarefaRepository.php'));

        foreach (['TAREFA_ANDAMENTO', 'TAREFA_SOLICITACAO_PRAZO'] as $tabela) {
            $padrao = '/inserirSqlAuditado\(\s*\''.$tabela.'\'\s*,\s*\''.$tabela.'\'\s*,\s*null\s*,/s';
            $this->assertMatchesRegularExpression($padrao, $conteudo);
        }
    }

    /**
     * @param  array<int, string>  $diretorios
     * @param  array<int, string>  $excecoes
     * @return array<int, string>
     */
    private function localizarDmlDireto(array $diretorios, array $excecoes = []): array
    {
        $mutadores = [
            'insert', 'insertGetId', 'insertOrIgnore', 'insertUsing', 'insertOrIgnoreUsing',
            'update', 'updateOrInsert', 'updateFrom', 'delete', 'destroy', 'forceDestroy',
            'upsert', 'increment', 'decrement', 'incrementEach', 'decrementEach', 'truncate',
            'create', 'forceCreate', 'firstOrCreate', 'updateOrCreate',
            'save', 'saveOrFail', 'saveQuietly', 'touch',
            'restore', 'forceDelete', 'deleteQuietly', 'statement', 'unprepared',
            'affectingStatement',
        ];
        $parser = (new ParserFactory)->createForNewestSupportedVersion();
        $finder = new NodeFinder;
        $violacoes = [];

        foreach ($diretorios as $diretorio) {
            $arquivos = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($diretorio, RecursiveDirectoryIterator::SKIP_DOTS)
            );

            foreach ($arquivos as $arquivo) {
                if (! $arquivo->isFile() || $arquivo->getExtension() !== 'php') {
                    continue;
                }

                $caminho = str_replace(base_path().DIRECTORY_SEPARATOR, '', $arquivo->getPathname());
                if (in_array($caminho, $excecoes, true)) {
                    continue;
                }

                $ast = $parser->parse((string) file_get_contents($arquivo->getPathname()));
                if ($ast === null) {
                    continue;
                }

                $chamadas = $finder->find($ast, static function ($node): bool {
                    return $node instanceof MethodCall || $node instanceof StaticCall;
                });

                foreach ($chamadas as $chamada) {
                    if (! $chamada->name instanceof Identifier) {
                        continue;
                    }

                    $metodo = $chamada->name->toString();
                    if (! in_array($metodo, $mutadores, true)) {
                        continue;
                    }

                    if ($chamada instanceof StaticCall
                        && $chamada->class instanceof Name
                        && in_array(strtolower($chamada->class->getLast()), ['carbon', 'date', 'datetime', 'datetimeimmutable'], true)) {
                        continue;
                    }

                    $violacoes[] = $caminho.':'.$chamada->getStartLine().' '.$metodo;
                }
            }
        }

        sort($violacoes);

        return $violacoes;
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_AUDITADMLGLOBALCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/GelRespostaRepositorySqlTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_GELRESPOSTAREPOSITORYSQLTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/GelRespostaRepositorySqlTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GelRespostaRepositorySqlTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_repository_consulta_view_local_com_filtro_por_local_categoria_e_ultima_vistoria(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class GelRespostaRepositorySqlTest extends TestCase
{
    public function test_repository_consulta_view_local_com_filtro_por_local_categoria_e_ultima_vistoria(): void
    {
        $path = app_path('Repositories/Gel/GelRespostaRepository.php');

        $this->assertFileExists($path);
        $conteudo = file_get_contents($path);
        $this->assertIsString($conteudo);

        $this->assertStringContainsString('vw_gel_respostas_ac', $conteudo);
        $this->assertStringContainsString('DENSE_RANK() OVER', $conteudo);
        $this->assertStringContainsString('dat_vistoria DESC NULLS LAST, cod_vistoria DESC', $conteudo);
        $this->assertStringContainsString('TRIM(cod_objeto_local_votacao)', $conteudo);
        $this->assertStringContainsString('cod_categoria_vistoria = ?', $conteudo);
        $this->assertStringContainsString('ordem_questao', $conteudo);

        $this->assertStringNotContainsString('@cad_tse', $conteudo);
        $this->assertStringNotContainsString('ROWNUM', $conteudo);
        $this->assertStringNotContainsString('FETCH FIRST', $conteudo);
        $this->assertStringNotContainsString(' limit ', strtolower($conteudo));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_GELRESPOSTAREPOSITORYSQLTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/RcandModuleContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RCANDMODULECONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/RcandModuleContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RcandModuleContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_scheduler_integra_rcand_ao_sequencial_diario_e_preserva_comando_manual(): void
public function test_status_de_sincronizacao_monitora_etapas_rcand(): void
public function test_rotas_rcand_estao_versionadas_e_vinculadas_ao_grupo_proprio(): void
public function test_views_rcand_expoem_painel_exportacao_pdf_e_status_sync(): void
public function test_painel_rcand_evita_loop_de_resize_dos_graficos(): void
public function test_paginacao_rcand_usa_parametros_independentes_para_cand(): void
public function test_aba_cand_contrata_navegacao_secundaria_validada_e_sem_nova_rota(): void
public function test_rcand_2026_nao_expoe_filtros_territoriais_de_primeiro_grau(): void
public function test_menu_rcand_expoe_modulo_proprio_com_item_painel(): void
public function test_migration_incremental_corrige_menu_path_acl_rcand(): void
public function test_migration_incremental_cria_perfil_operacional_rcand_para_rotas_do_painel(): void
public function test_migration_incremental_rcand_declara_campos_calculados_do_pbit(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
$inicioRotasRcand = strpos($routes, "Route::prefix('/rcand')");
$this->assertSame(3, substr_count($blocoRotasRcand, 'Route::get('));
$inicioRotasRcand = strpos($routes, "Route::prefix('/rcand')");
$this->assertSame(3, substr_count($blocoRotasRcand, 'Route::get('));
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use App\Services\MenuCatalogService;
use Tests\TestCase;

class RcandModuleContractTest extends TestCase
{
    public function test_scheduler_integra_rcand_ao_sequencial_diario_e_preserva_comando_manual(): void
    {
        $console = (string) file_get_contents(base_path('routes/console.php'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/painel-rcand.md'));

        $this->assertSame(1, substr_count($console, "Schedule::command('sync:local-votacao:sequencial')"));
        $this->assertSame(0, substr_count($console, "Schedule::command('sync:rcand:sequencial')"));
        $this->assertSame(1, substr_count($console, "Artisan::command('sync:rcand:sequencial'"));
        $this->assertStringContainsString('agendado para as 23h', $contrato);
        $this->assertStringContainsString('permanecem', $contrato);
    }

    public function test_status_de_sincronizacao_monitora_etapas_rcand(): void
    {
        $service = new LocalVotacaoSyncStatusService;
        $registros = collect($service->obterRegistrosMonitorados())->keyBy('chave');

        foreach (['rcand_pje', 'rcand_cand', 'rcand_candexweb', 'rcand_consolidado', 'rcand_sequencial'] as $etapa) {
            $this->assertArrayHasKey($etapa, $registros->all());
        }
    }

    public function test_rotas_rcand_estao_versionadas_e_vinculadas_ao_grupo_proprio(): void
    {
        $routes = (string) file_get_contents(base_path('routes/web.php'));
        $migration = (string) file_get_contents(database_path('migrations/2026_07_09_120000_register_rcand_acl_routes.php'));

        foreach (['rcand.index', 'rcand.dados', 'rcand.exportar-pdf'] as $routeName) {
            $this->assertStringContainsString("->name('".substr($routeName, strlen('rcand.'))."')", $routes);
            $this->assertStringContainsString($routeName, $migration);
        }

        $this->assertStringContainsString('PLANELEITO_RCAND_ADMIN', $migration);
        $this->assertStringContainsString('administracao-global.sync-rcand.sequencial.executar', $migration);
    }

    public function test_views_rcand_expoem_painel_exportacao_pdf_e_status_sync(): void
    {
        $view = (string) file_get_contents(resource_path('views/rcand/index.blade.php'));
        $pdf = (string) file_get_contents(resource_path('views/rcand/pdf.blade.php'));
        $sync = (string) file_get_contents(resource_path('views/administracao-global/sincronizacao-local-votacao/index.blade.php'));

        $this->assertStringContainsString('Painel RCAND', $view);
        $this->assertStringContainsString('modalExportarPdfRcand', $view);
        $this->assertStringContainsString('rcand.exportar-pdf', $view);
        $this->assertStringContainsString('Última sincronização', $view);
        $this->assertStringContainsString('vendor/chartjs/chart.umd.min.js', $view);
        $this->assertStringContainsString('rcandDashboardData', $view);

        foreach (['gerencial', 'detalhes', 'segundo-grau', 'draps', 'cand', 'glossario'] as $aba) {
            $this->assertStringContainsString('data-rcand-aba="'.$aba.'"', $view);
        }

        foreach (['Gerencial', 'Detalhes', '2º GRAU', 'DRAPs', 'CAND', 'Glossário'] as $paginaPbit) {
            $this->assertStringContainsString($paginaPbit, $view);
        }
        $this->assertStringNotContainsString('1º GRAU', $view);
        $this->assertStringContainsString('Relatório RCAND', $pdf);
        $this->assertStringContainsString('Sincronizar RCAND', $sync);
        $this->assertStringContainsString('executarRcandSequencial', $sync);
    }

    public function test_painel_rcand_evita_loop_de_resize_dos_graficos(): void
    {
        $view = (string) file_get_contents(resource_path('views/rcand/index.blade.php'));

        $this->assertStringContainsString('rcand-chart-frame', $view);
        $this->assertStringContainsString('maintainAspectRatio: true', $view);
        $this->assertStringNotContainsString('maintainAspectRatio: false', $view);
        $this->assertStringContainsString('@if ($mostrarGraficos)', $view);
        $this->assertStringContainsString('rcandBuildChart', $view);
    }

    public function test_paginacao_rcand_usa_parametros_independentes_para_cand(): void
    {
        $controller = (string) file_get_contents(app_path('Http/Controllers/Rcand/RcandController.php'));
        $repository = (string) file_get_contents(app_path('Repositories/Rcand/RcandRepository.php'));
        $view = (string) file_get_contents(resource_path('views/rcand/index.blade.php'));

        $this->assertStringContainsString("request()->except(['aba', 'visao_cand', 'page', 'cand_page', 'candexweb_pedidos_page', 'candexweb_candidatos_page', 'zona', 'municipio'])", $view);
        $this->assertSame(2, substr_count($view, "links('pagination::bootstrap-5')"));
        $this->assertStringContainsString('hasPages()', $view);
        $this->assertStringNotContainsString('->links()', $view);
        $this->assertStringContainsString("except('page', 'cand_page', 'candexweb_pedidos_page', 'candexweb_candidatos_page', 'zona', 'municipio')", $controller);
        $this->assertStringContainsString('RcandVisaoCand::pageName($visaoCand)', $controller);
        $this->assertStringContainsString('listarCandPaginado($filtros, $perPage, $pageName)', $controller);
        $this->assertStringContainsString("paginate(\$perPage, ['*'], \$pageName)", $repository);
        $this->assertStringContainsString("string \$pageName = 'cand_page'", $repository);
    }

    public function test_aba_cand_contrata_navegacao_secundaria_validada_e_sem_nova_rota(): void
    {
        $request = (string) file_get_contents(app_path('Http/Requests/Rcand/RcandFiltroRequest.php'));
        $view = (string) file_get_contents(resource_path('views/rcand/index.blade.php'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/painel-rcand.md'));
        $routes = (string) file_get_contents(base_path('routes/web.php'));

        $this->assertStringContainsString("'visao_cand'", $request);
        $this->assertSame(1, substr_count($view, 'data-rcand-visao="'));
        $this->assertStringContainsString('data-rcand-visao-total=', $view);
        $this->assertStringContainsString('visao_cand=processos|comparacao|pedidos|candidatos', $contrato);

        $inicioRotasRcand = strpos($routes, "Route::prefix('/rcand')");
        $fimRotasRcand = strpos($routes, "\n});", $inicioRotasRcand);
        $blocoRotasRcand = substr($routes, $inicioRotasRcand, $fimRotasRcand - $inicioRotasRcand);
        $this->assertSame(3, substr_count($blocoRotasRcand, 'Route::get('));
    }

    public function test_rcand_2026_nao_expoe_filtros_territoriais_de_primeiro_grau(): void
    {
        $controller = (string) file_get_contents(app_path('Http/Controllers/Rcand/RcandController.php'));
        $repository = (string) file_get_contents(app_path('Repositories/Rcand/RcandRepository.php'));
        $view = (string) file_get_contents(resource_path('views/rcand/index.blade.php'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/painel-rcand.md'));

        $this->assertStringNotContainsString('name="zona"', $view);
        $this->assertStringNotContainsString('name="municipio"', $view);
        $this->assertStringNotContainsString('$opcoes[\'zonas\']', $view);
        $this->assertStringNotContainsString('$opcoes[\'municipios\']', $view);
        $this->assertStringNotContainsString('<div class="text-muted small">Zona</div>', $view);

        $this->assertStringNotContainsString("'zona' => ['nullable', 'string', 'max:20']", $controller);
        $this->assertStringNotContainsString("'municipio' => ['nullable', 'string', 'max:150']", $controller);
        $this->assertStringNotContainsString("'zona' => trim", $controller);
        $this->assertStringNotContainsString("'municipio' => trim", $controller);

        $this->assertStringNotContainsString("'zonas' =>", $repository);
        $this->assertStringNotContainsString("'municipios' =>", $repository);
        $this->assertStringNotContainsString("'zona' => 'zona'", $repository);
        $this->assertStringNotContainsString("'municipio' => 'municipio'", $repository);
        $this->assertStringNotContainsString('zona_rotulo', $repository);

        $this->assertStringContainsString('nao devem ser exibidos como filtros', $contrato);
        $this->assertStringContainsString('nao devem restringir consultas', $contrato);
    }

    public function test_menu_rcand_expoe_modulo_proprio_com_item_painel(): void
    {
        $menuConfig = (string) file_get_contents(config_path('planeleito_menu.php'));
        $layout = (string) file_get_contents(resource_path('views/layouts/app.blade.php'));
        $service = app(MenuCatalogService::class);
        $menu = $service->buildForLayout(['rcand.index']);

        $this->assertStringContainsString('rcand.index', $menuConfig);
        $this->assertStringContainsString('RCAND > Painel', $menuConfig);
        $this->assertStringContainsString('Painel', $menuConfig);
        $this->assertStringContainsString('rcandDropdown', $layout);
        $this->assertSame('RCAND', data_get($menu, 'rcand.label'));
        $this->assertSame('Painel', data_get($menu, 'rcand.itens.0.label'));
        $this->assertSame('RCAND > Painel', $service->menuPathForRoute('rcand.index'));
    }

    public function test_migration_incremental_corrige_menu_path_acl_rcand(): void
    {
        $migration = (string) file_get_contents(database_path('migrations/2026_07_09_131000_update_rcand_acl_menu_path.php'));

        $this->assertStringContainsString('RCAND > Painel', $migration);
        $this->assertStringContainsString('rcand.index', $migration);
        $this->assertStringContainsString('administracao-global.sync-rcand.sequencial.executar', $migration);
    }

    public function test_migration_incremental_cria_perfil_operacional_rcand_para_rotas_do_painel(): void
    {
        $migration = (string) file_get_contents(database_path('migrations/2026_07_15_120000_grant_rcand_panel_routes_to_rcand_group.php'));

        $this->assertStringContainsString("private const GRUPO_NOME = 'PLANELEITO_RCAND';", $migration);
        $this->assertStringContainsString("'rcand.index'", $migration);
        $this->assertStringContainsString("'rcand.dados'", $migration);
        $this->assertStringContainsString("'rcand.exportar-pdf'", $migration);
        $this->assertStringNotContainsString("'administracao-global.sync-rcand.index'", $migration);
        $this->assertStringNotContainsString("'administracao-global.sync-rcand.sequencial.executar'", $migration);
        $this->assertStringContainsString("'ignora_unidades_permitidas' => 0", $migration);
        $this->assertStringContainsString("'expande_escopo_por_atividade' => 0", $migration);
    }

    public function test_migration_incremental_rcand_declara_campos_calculados_do_pbit(): void
    {
        $migration = (string) file_get_contents(database_path('migrations/2026_07_09_130000_add_pbit_calculated_fields_to_rcand_tables.php'));

        foreach ([
            'julgados_pje_sn',
            'sem_int_mpe',
            'todas_peticoes_lidas',
            'cert_publ_sn',
            'cand_processo',
            'julgamento_if_cand',
            'julgados_cand_sn',
            'inform_candidato_sn',
            'if_cand_x_pje',
        ] as $coluna) {
            $this->assertStringContainsString($coluna, $migration);
        }
    }

    public function test_migration_incremental_rcand_separa_envio_ao_mpf_nos_snapshots(): void
    {
        $caminho = database_path('migrations/2026_08_12_120000_add_envio_mpf_to_rcand_tables.php');

        $this->assertFileExists($caminho);
        $migration = mb_strtolower((string) file_get_contents($caminho));

        $this->assertStringContainsString('alter table rcand_pje_processos add', $migration);
        $this->assertStringContainsString('alter table rcand_consolidado_processos add', $migration);
        $this->assertSame(4, substr_count($migration, 'envio_mpf'));
        $this->assertStringContainsString('alter table rcand_consolidado_processos drop column envio_mpf', $migration);
        $this->assertStringContainsString('alter table rcand_pje_processos drop column envio_mpf', $migration);
    }

    public function test_migration_incremental_rcand_adiciona_impugnacao_ao_snapshot_cand(): void
    {
        $caminho = database_path('migrations/2026_08_12_130000_add_impugnacoes_to_rcand_cand_processos.php');

        $this->assertFileExists($caminho);
        $migration = mb_strtolower((string) file_get_contents($caminho));

        $this->assertStringContainsString('alter table rcand_cand_processos add', $migration);
        $this->assertSame(2, substr_count($migration, 'impugnacoes'));
        $this->assertStringContainsString('alter table rcand_cand_processos drop column impugnacoes', $migration);
    }

    public function test_plano_de_paridade_pbit_esta_versionado(): void
    {
        $plano = (string) file_get_contents(base_path('docs/planejamento/painel-rcand-paridade-pbit.md'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/painel-rcand.md'));

        foreach (['Gerencial', 'Detalhes', '2º GRAU', 'DRAPs', 'CAND', 'Glossário'] as $pagina) {
            $this->assertStringContainsString($pagina, $plano);
            $this->assertStringContainsString($pagina, $contrato);
        }

        $this->assertStringContainsString('paridade funcional', mb_strtolower($contrato));
    }

    public function test_restore_manifest_classifica_tabelas_rcand_como_sync(): void
    {
        $manifest = (string) file_get_contents(app_path('Support/DatabaseRestore/RestoreTableManifest.php'));

        $this->assertStringContainsString("'rcand_pje_processos'", $manifest);
        $this->assertStringContainsString("'rcand_cand_processos'", $manifest);
        $this->assertStringContainsString("'rcand_candexweb_pedidos'", $manifest);
        $this->assertStringContainsString("'rcand_candexweb_candidatos'", $manifest);
        $this->assertStringContainsString("'rcand_consolidado_processos'", $manifest);
    }

    public function test_migrations_rcand_2026_declaram_eleicao_e_candexweb_sem_campos_sensiveis(): void
    {
        $eleicao = (string) file_get_contents(database_path('migrations/2026_07_22_130000_add_eleicao_metadata_to_rcand_tables.php'));
        $candexweb = (string) file_get_contents(database_path('migrations/2026_07_22_131000_create_rcand_candexweb_tables.php'));
        $candexwebLower = mb_strtolower($candexweb);

        foreach (['cd_eleicao', 'nm_eleicao', 'tp_abrangencia', 'nr_turno', 'dt_eleicao'] as $coluna) {
            $this->assertStringContainsString($coluna, $eleicao);
            $this->assertStringContainsString($coluna, $candexweb);
        }

        $this->assertStringContainsString('rcand_candexweb_pedidos', $candexweb);
        $this->assertStringContainsString('rcand_candexweb_candidatos', $candexweb);

        foreach (['cpf', 'titulo', 'nr_rg', 'dt_nascimento', 'hash', 'representante'] as $sensivel) {
            $this->assertStringNotContainsString($sensivel, $candexwebLower);
        }
    }

    public function test_migration_exclusiva_cria_catalogo_e_relacoes_de_partido_sem_fks(): void
    {
        $caminho = database_path('migrations/2026_08_01_120000_create_rcand_partido_filter_tables.php');

        $this->assertFileExists($caminho);

        $migration = strtoupper((string) file_get_contents($caminho));

        foreach (['RCAND_PARTIDO', 'RCAND_CAND_PROC_PARTIDO', 'RCAND_CW_PEDIDO_PARTIDO'] as $tabela) {
            $this->assertStringContainsString("CREATE TABLE {$tabela}", $migration);
            $this->assertStringContainsString("DROP TABLE {$tabela}", $migration);
        }

        $this->assertStringContainsString('PRIMARY KEY (CD_ELEICAO, NR_PARTIDO)', $migration);
        $this->assertStringContainsString(
            'PRIMARY KEY (CD_ELEICAO, NR_PROCESSO_SEM_FORMATACAO, NR_PARTIDO)',
            $migration
        );
        $this->assertStringContainsString('PRIMARY KEY (CD_ELEICAO, SQ_PEDIDO, NR_PARTIDO)', $migration);
        $this->assertStringContainsString(
            'ON RCAND_CAND_PROC_PARTIDO (NR_PARTIDO, CD_ELEICAO, NR_PROCESSO_SEM_FORMATACAO)',
            $migration
        );
        $this->assertStringContainsString(
            'ON RCAND_CW_PEDIDO_PARTIDO (NR_PARTIDO, CD_ELEICAO, SQ_PEDIDO)',
            $migration
        );
        $this->assertStringNotContainsString('FOREIGN KEY', $migration);
        $this->assertStringNotContainsString('REFERENCES ', $migration);
    }

    public function test_partidos_rcand_sao_sync_e_estao_contratados_antes_do_codigo(): void
    {
        $manifest = (string) file_get_contents(app_path('Support/DatabaseRestore/RestoreTableManifest.php'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/painel-rcand.md'));
        $restauracao = (string) file_get_contents(base_path('docs/contratos/homologacao-banco.md'));
        $plano = (string) file_get_contents(base_path('docs/planejamento/rcand-filtro-partido.md'));

        foreach (['rcand_partido', 'rcand_cand_proc_partido', 'rcand_cw_pedido_partido'] as $tabela) {
            $this->assertStringContainsString("'{$tabela}'", $manifest);
            $this->assertStringContainsString($tabela, $contrato);
            $this->assertStringContainsString($tabela, $restauracao);
            $this->assertStringContainsString(strtoupper($tabela), strtoupper($plano));
        }
    }

    public function test_filtro_partido_esta_presente_na_interface_json_e_pdf_sem_nova_rota(): void
    {
        $controller = (string) file_get_contents(app_path('Http/Controllers/Rcand/RcandController.php'));
        $request = (string) file_get_contents(app_path('Http/Requests/Rcand/RcandFiltroRequest.php'));
        $repository = (string) file_get_contents(app_path('Repositories/Rcand/RcandRepository.php'));
        $view = (string) file_get_contents(resource_path('views/rcand/index.blade.php'));
        $pdf = (string) file_get_contents(resource_path('views/rcand/pdf.blade.php'));
        $routes = (string) file_get_contents(base_path('routes/web.php'));

        $this->assertStringContainsString("'partido' => ['nullable', 'integer'", $request);
        $this->assertStringContainsString("Rule::exists('rcand_partido', 'nr_partido')", $request);
        $this->assertStringContainsString('RcandFiltroRequest $request', $controller);
        $this->assertGreaterThanOrEqual(2, substr_count($controller, "'partidos' => 'Partidos'"));
        $this->assertStringContainsString("'partidos'", $controller);
        $this->assertStringContainsString('name="partido"', $view);
        $this->assertStringContainsString('Todos os partidos', $view);
        $this->assertStringContainsString('rcand-partido-select2', $view);
        $this->assertGreaterThanOrEqual(5, substr_count($view, 'partidos'));
        $this->assertStringContainsString('white-space: pre-line', $pdf);
        $this->assertStringContainsString('whereExists', $repository);
        $this->assertStringNotContainsString('@cand', $repository);
        $this->assertStringNotContainsString('dblink', strtolower($repository));

        $inicioRotasRcand = strpos($routes, "Route::prefix('/rcand')");
        $this->assertNotFalse($inicioRotasRcand);
        $fimRotasRcand = strpos($routes, "\n});", $inicioRotasRcand);
        $this->assertNotFalse($fimRotasRcand);
        $blocoRotasRcand = substr($routes, $inicioRotasRcand, $fimRotasRcand - $inicioRotasRcand);
        $this->assertSame(3, substr_count($blocoRotasRcand, 'Route::get('));
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_RCANDMODULECONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/SeuVotoImportaAdminContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SEUVOTOIMPORTAADMINCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/SeuVotoImportaAdminContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class SeuVotoImportaAdminContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function rotas_internas_sao_nomeadas_e_as_estaticas_antecedem_o_detalhe(): void
public function controller_repassa_escopo_em_todos_os_fluxos_e_exportacao_reutiliza_filtros(): void
public function repository_falha_fechado_e_aplica_zona_na_consulta_compartilhada(): void
public function listagem_responsiva_tem_duas_colunas_modal_pdf_e_paginacao_bootstrap(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php
strpos($rotas, "Route::get('/{id}'"),
strpos($rotas, "Route::get('/exportar-pdf'"),
```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit\Architecture\SourceContracts;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaAdminContractTest extends TestCase
{
    #[Test]
    public function rotas_internas_sao_nomeadas_e_as_estaticas_antecedem_o_detalhe(): void
    {
        $rotas = (string) file_get_contents(base_path('routes/web.php'));

        foreach ([
            'seu-voto-importa.admin.index',
            'seu-voto-importa.admin.exportar-pdf',
            'seu-voto-importa.admin.config.edit',
            'seu-voto-importa.admin.config.update',
            'seu-voto-importa.admin.show',
            'seu-voto-importa.admin.status.update',
            'seu-voto-importa.admin.turno.update',
            'seu-voto-importa.admin.anexo.download',
        ] as $rota) {
            $this->assertStringContainsString("name('".str_replace('seu-voto-importa.admin.', '', $rota)."')", $rotas, $rota);
        }

        $this->assertLessThan(
            strpos($rotas, "Route::get('/{id}'"),
            strpos($rotas, "Route::get('/exportar-pdf'"),
        );
        $this->assertStringNotContainsString("name('codigo.reenviar')", $rotas);
    }

    #[Test]
    public function controller_repassa_escopo_em_todos_os_fluxos_e_exportacao_reutiliza_filtros(): void
    {
        $controller = (string) file_get_contents(app_path('Http/Controllers/SeuVotoImporta/SeuVotoImportaAdminController.php'));

        $this->assertStringContainsString('escopoZonalSessao()', $controller);
        $this->assertStringContainsString('CamposPdfSelecionados::resolver', $controller);
        $this->assertStringContainsString('$this->filtros($request)', $controller);
        $this->assertStringContainsString('autorizarAdmin()', $controller);
        $this->assertStringContainsString('nosniff', $controller);
    }

    #[Test]
    public function repository_falha_fechado_e_aplica_zona_na_consulta_compartilhada(): void
    {
        $repository = (string) file_get_contents(app_path('Repositories/SeuVotoImporta/SeuVotoImportaSolicitacaoRepository.php'));

        $this->assertStringContainsString('private function consultaAdministrativa', $repository);
        $this->assertStringContainsString("whereRaw('1 = 0')", $repository);
        $this->assertStringContainsString("whereIn('s.ZONA_NUMERO'", $repository);
        $this->assertStringContainsString("paginate(25)", $repository);
        $this->assertStringContainsString('consultaAdministrativa($filtros, $escopo)', $repository);
    }

    #[Test]
    public function listagem_responsiva_tem_duas_colunas_modal_pdf_e_paginacao_bootstrap(): void
    {
        $view = (string) file_get_contents(resource_path('views/seu-voto-importa/admin/index.blade.php'));

        $this->assertStringContainsString('<th>Solicitação</th>', $view);
        $this->assertStringContainsString('<th>Ações</th>', $view);
        $this->assertStringContainsString('Exportar para PDF', $view);
        $this->assertStringContainsString('name="campos[]"', $view);
        $this->assertStringContainsString("links('pagination::bootstrap-5')", $view);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SEUVOTOIMPORTAADMINCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/SeuVotoImportaLogsContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SEUVOTOIMPORTALOGSCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/SeuVotoImportaLogsContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class SeuVotoImportaLogsContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function fluxo_publico_nao_propaga_excecao_que_possa_conter_bindings_pessoais(): void
public function fluxo_obsoleto_de_codigo_email_e_hmac_foi_removido_do_runtime(): void
public function falha_do_gateway_auditado_redige_mensagem_do_driver_para_entidades_svi(): void
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

class SeuVotoImportaLogsContractTest extends TestCase
{
    #[Test]
    public function fluxo_publico_nao_propaga_excecao_que_possa_conter_bindings_pessoais(): void
    {
        $controller = (string) file_get_contents(app_path('Http/Controllers/SeuVotoImporta/SeuVotoImportaPublicoController.php'));

        $this->assertStringContainsString('registrarFalhaTecnica', $controller);
        $this->assertStringContainsString("'exception_class' => \$exception::class", $controller);
        $this->assertStringNotContainsString('throw $exception', $controller);
        $this->assertStringNotContainsString('$exception->getMessage()', $controller);
    }

    #[Test]
    public function fluxo_obsoleto_de_codigo_email_e_hmac_foi_removido_do_runtime(): void
    {
        foreach ([
            app_path('Jobs/SeuVotoImporta/EnviarCodigoSeuVotoImportaJob.php'),
            app_path('Mail/SeuVotoImporta/SeuVotoImportaCodigoMail.php'),
            app_path('Services/SeuVotoImporta/SeuVotoImportaCodigoService.php'),
            app_path('Repositories/SeuVotoImporta/SeuVotoImportaAcessoRepository.php'),
            app_path('Http/Requests/SeuVotoImporta/SeuVotoImportaCodigoRequest.php'),
            resource_path('views/seu-voto-importa/publico/codigo-solicitar.blade.php'),
            resource_path('views/seu-voto-importa/publico/codigo-validar.blade.php'),
            resource_path('views/emails/seu-voto-importa/codigo.blade.php'),
        ] as $arquivo) {
            $this->assertFileDoesNotExist($arquivo, $arquivo);
        }

        $configuracao = (string) file_get_contents(config_path('planeleito.php'));
        $this->assertStringNotContainsString('SEU_VOTO_IMPORTA_CODIGO_SECRET', $configuracao);
    }

    #[Test]
    public function falha_do_gateway_auditado_redige_mensagem_do_driver_para_entidades_svi(): void
    {
        $trait = (string) file_get_contents(app_path('Repositories/Concerns/AuditaDml.php'));

        $this->assertStringContainsString("str_starts_with(\$entidadeNormalizada, 'SVI_')", $trait);
        $this->assertStringContainsString("'Falha técnica em DML do módulo SVI.'", $trait);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SEUVOTOIMPORTALOGSCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/SeuVotoImportaPrivacidadeContractTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SEUVOTOIMPORTAPRIVACIDADECONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/SeuVotoImportaPrivacidadeContractTest.php`
- **Namespace Declaração:** `Tests\Unit\Architecture\SourceContracts`
- **Entidade / Classe:** `class SeuVotoImportaPrivacidadeContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function declaracao_registra_ciencia_sem_consentimento_generico(): void
public function formulario_nao_coleta_email_e_exibe_endereco_do_local_de_votacao(): void
public function formulario_exige_escolha_do_solicitante_consulta_elo_por_botao_e_usa_cartoes(): void
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

class SeuVotoImportaPrivacidadeContractTest extends TestCase
{
    #[Test]
    public function declaracao_registra_ciencia_sem_consentimento_generico(): void
    {
        $formulario = (string) file_get_contents(
            resource_path('views/seu-voto-importa/publico/formulario.blade.php')
        );

        $this->assertStringContainsString(
            'Li e estou ciente das informações sobre o tratamento dos meus dados pessoais.',
            $formulario,
        );
        $this->assertStringContainsString('white-space: pre-line', $formulario);
        $this->assertStringNotContainsString('{!!', $formulario);
        $this->assertStringNotContainsString(
            'autorizo o tratamento nos termos informados',
            $formulario,
        );
    }

    #[Test]
    public function formulario_nao_coleta_email_e_exibe_endereco_do_local_de_votacao(): void
    {
        $formulario = (string) file_get_contents(
            resource_path('views/seu-voto-importa/publico/formulario.blade.php')
        );

        $this->assertStringNotContainsString('name="eleitor_email"', $formulario);
        $this->assertStringContainsString("{{ \$eleitor['local_endereco'] }}", $formulario);
        $this->assertStringContainsString('Dados complementares do eleitor', $formulario);
    }

    #[Test]
    public function formulario_exige_escolha_do_solicitante_consulta_elo_por_botao_e_usa_cartoes(): void
    {
        $formulario = (string) file_get_contents(
            resource_path('views/seu-voto-importa/publico/formulario.blade.php')
        );

        $this->assertStringContainsString('<option value="">Selecione</option>', $formulario);
        $this->assertStringNotContainsString("old('solicitante_tipo_codigo', 'ELEITOR')", $formulario);
        $this->assertStringContainsString('id="consultarRepresentanteElo"', $formulario);
        $this->assertStringContainsString('Consultar no ELO', $formulario);
        $this->assertStringContainsString("consultar?.addEventListener('click', identificarRepresentante)", $formulario);
        $this->assertStringContainsString('type="radio"', $formulario);
        $this->assertGreaterThanOrEqual(2, substr_count($formulario, 'name="comprovacao_tipo_codigo"'));
        $this->assertStringContainsString(
            'Autodeclaração: Declaro, sob as penas da lei, que as informações prestadas neste formulário correspondem à condição de deficiência ou mobilidade reduzida do eleitor para o qual foi solicitado o serviço de transporte',
            $formulario,
        );
        $this->assertStringNotContainsString('name="autodeclaracao_texto"', $formulario);
        $this->assertStringContainsString('invalidarRepresentante', $formulario);

        $detalheAdmin = (string) file_get_contents(
            resource_path('views/seu-voto-importa/admin/show.blade.php')
        );
        $this->assertStringContainsString('$s->autodeclaracao_texto', $detalheAdmin);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_SEUVOTOIMPORTAPRIVACIDADECONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlAtomicidadeTest.php`
## <TESTS_UNIT_AUDITADMLATOMICIDADETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlAtomicidadeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlAtomicidadeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create('audita_dml_alvo', function ($table): void {
Schema::create('auditoria_eventos_test', function ($table): void {
$this->assertSame(0, DB::table('auditoria_eventos_test')->count());
DB::table('audita_dml_alvo')->insert(['id' => 1, 'valor' => 'igual']);
$this->assertSame(0, DB::table('auditoria_eventos_test')->count());
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_update_sem_registro_afetado_nao_gera_auditoria(): void
public function test_update_sem_diferenca_persistida_nao_gera_auditoria(): void
public function test_update_com_mudanca_gera_evento_com_quantidade_afetada(): void
public function test_falha_do_dml_nao_gera_evento_de_auditoria(): void
public function test_falha_da_auditoria_reverte_o_dml(): void
public function test_insert_sem_snapshot_confirmado_reverte_o_dml(): void
public function test_update_sql_bruto_e_auditado_atomicamente(): void
public function test_delete_sql_bruto_e_auditado_atomicamente(): void
public function test_insert_sql_bruto_e_auditado_atomicamente(): void
public function test_insert_sem_id_audita_somente_delta_quando_localizador_contem_registro_antigo(): void
public function test_insert_em_lote_audita_somente_delta_quando_localizador_contem_registro_antigo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use LogicException;
use RuntimeException;
use Tests\TestCase;

class AuditaDmlAtomicidadeTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Schema::dropIfExists('auditoria_eventos_test');
        Schema::dropIfExists('audita_dml_alvo');

        Schema::create('audita_dml_alvo', function ($table): void {
            $table->integer('id')->primary();
            $table->string('valor');
            $table->integer('quantidade')->default(0);
        });

        Schema::create('auditoria_eventos_test', function ($table): void {
            $table->increments('id');
            $table->string('acao');
            $table->string('registro_id')->nullable();
            $table->text('bindings_json')->nullable();
            $table->text('dados_depois_json')->nullable();
        });
    }

    public function test_update_sem_registro_afetado_nao_gera_auditoria(): void
    {
        $afetados = $this->repository()->updatePorId(404, ['valor' => 'novo']);

        $this->assertSame(0, $afetados);
        $this->assertSame(0, DB::table('auditoria_eventos_test')->count());
    }

    public function test_update_sem_diferenca_persistida_nao_gera_auditoria(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 1, 'valor' => 'igual']);

        $afetados = $this->repository()->updatePorId(1, ['valor' => 'igual']);

        $this->assertSame(1, $afetados);
        $this->assertSame(0, DB::table('auditoria_eventos_test')->count());
    }

    public function test_update_com_mudanca_gera_evento_com_quantidade_afetada(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 1, 'valor' => 'antes']);

        $afetados = $this->repository()->updatePorId(1, ['valor' => 'depois']);

        $evento = DB::table('auditoria_eventos_test')->first();
        $this->assertSame(1, $afetados);
        $this->assertNotNull($evento);
        $this->assertSame('UPDATE', $evento->acao);
        $this->assertSame(1, json_decode((string) $evento->bindings_json, true, flags: JSON_THROW_ON_ERROR)['afetados']);
    }

    public function test_falha_do_dml_nao_gera_evento_de_auditoria(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 1, 'valor' => 'existente']);

        try {
            $this->repository()->insertPorId(1, ['valor' => 'duplicado']);
            $this->fail('O insert duplicado deveria falhar.');
        } catch (QueryException) {
            // comportamento esperado
        }

        $this->assertSame(0, DB::table('auditoria_eventos_test')->count());
        $this->assertSame('existente', DB::table('audita_dml_alvo')->where('id', 1)->value('valor'));
    }

    public function test_falha_da_auditoria_reverte_o_dml(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 1, 'valor' => 'antes']);

        try {
            $this->repository(true)->updatePorId(1, ['valor' => 'depois']);
            $this->fail('A falha da auditoria deveria interromper a operacao.');
        } catch (RuntimeException $exception) {
            $this->assertSame('falha ao persistir auditoria', $exception->getMessage());
        }

        $this->assertSame('antes', DB::table('audita_dml_alvo')->where('id', 1)->value('valor'));
        $this->assertSame(0, DB::table('auditoria_eventos_test')->count());
    }

    public function test_insert_sem_snapshot_confirmado_reverte_o_dml(): void
    {
        try {
            $this->repository()->insertSemSnapshot(2, ['valor' => 'nao deve persistir']);
            $this->fail('A ausencia do snapshot deveria interromper a operacao.');
        } catch (\LogicException $exception) {
            $this->assertSame('INSERT aplicado sem snapshot persistido para auditoria.', $exception->getMessage());
        }

        $this->assertFalse(DB::table('audita_dml_alvo')->where('id', 2)->exists());
        $this->assertSame(0, DB::table('auditoria_eventos_test')->count());
    }

    public function test_update_sql_bruto_e_auditado_atomicamente(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 3, 'valor' => 'antes', 'quantidade' => 0]);

        $afetados = $this->repository()->updateSql(3, 'depois');

        $this->assertSame(1, $afetados);
        $this->assertSame('depois', DB::table('audita_dml_alvo')->where('id', 3)->value('valor'));
        $this->assertSame('UPDATE', DB::table('auditoria_eventos_test')->value('acao'));
    }

    public function test_delete_sql_bruto_e_auditado_atomicamente(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 4, 'valor' => 'remover', 'quantidade' => 0]);

        $afetados = $this->repository()->deleteSql(4);

        $this->assertSame(1, $afetados);
        $this->assertFalse(DB::table('audita_dml_alvo')->where('id', 4)->exists());
        $this->assertSame('DELETE', DB::table('auditoria_eventos_test')->value('acao'));
    }

    public function test_insert_sql_bruto_e_auditado_atomicamente(): void
    {
        $afetados = $this->repository()->insertSql(5, 'incluido');

        $this->assertSame(1, $afetados);
        $this->assertSame('incluido', DB::table('audita_dml_alvo')->where('id', 5)->value('valor'));
        $this->assertSame('INSERT', DB::table('auditoria_eventos_test')->value('acao'));
    }

    public function test_insert_sem_id_audita_somente_delta_quando_localizador_contem_registro_antigo(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 10, 'valor' => 'antigo', 'quantidade' => 0]);

        $this->repository()->insertSemIdEscopoAmplo(11, 'novo');

        $depois = json_decode(
            (string) DB::table('auditoria_eventos_test')->value('dados_depois_json'),
            true,
            flags: JSON_THROW_ON_ERROR
        );
        $this->assertSame([11], array_column($depois, 'id'));
    }

    public function test_insert_em_lote_audita_somente_delta_quando_localizador_contem_registro_antigo(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 20, 'valor' => 'antigo', 'quantidade' => 0]);

        $this->repository()->insertLoteEscopoAmplo([
            ['id' => 21, 'valor' => 'novo-1', 'quantidade' => 0],
            ['id' => 22, 'valor' => 'novo-2', 'quantidade' => 0],
        ]);

        $depois = json_decode(
            (string) DB::table('auditoria_eventos_test')->value('dados_depois_json'),
            true,
            flags: JSON_THROW_ON_ERROR
        );
        sort($depois);
        $this->assertSame([21, 22], array_column($depois, 'id'));
    }

    public function test_insert_sql_bruto_audita_somente_delta_quando_localizador_contem_registro_antigo(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 30, 'valor' => 'antigo', 'quantidade' => 0]);

        $this->repository()->insertSqlEscopoAmplo(31, 'novo');

        $depois = json_decode(
            (string) DB::table('auditoria_eventos_test')->value('dados_depois_json'),
            true,
            flags: JSON_THROW_ON_ERROR
        );
        $this->assertSame([31], array_column($depois, 'id'));
    }

    public function test_insert_reverte_quando_cardinalidade_do_delta_diverge_de_afetados(): void
    {
        try {
            $this->repository()->insertSqlComLocalizadorIncompleto();
            $this->fail('A divergencia entre afetados e snapshot deveria falhar.');
        } catch (LogicException) {
            // comportamento esperado
        }

        $this->assertFalse(DB::table('audita_dml_alvo')->whereIn('id', [40, 41])->exists());
        $this->assertSame(0, DB::table('auditoria_eventos_test')->count());
    }

    public function test_incremento_e_decremento_auditados_registram_mudancas_reais(): void
    {
        DB::table('audita_dml_alvo')->insert(['id' => 6, 'valor' => 'contador', 'quantidade' => 10]);

        $this->assertSame(1, $this->repository()->incrementar(6, 3));
        $this->assertSame(13, DB::table('audita_dml_alvo')->where('id', 6)->value('quantidade'));
        $this->assertSame(1, $this->repository()->decrementar(6, 2));
        $this->assertSame(11, DB::table('audita_dml_alvo')->where('id', 6)->value('quantidade'));
        $this->assertSame(2, DB::table('auditoria_eventos_test')->count());
    }

    private function repository(bool $falharAuditoria = false): object
    {
        $auditRepository = new class($falharAuditoria) implements AuditLogRepositoryInterface
        {
            public function __construct(private readonly bool $falhar) {}

            public function inserir(array $payload): void
            {
                if ($this->falhar) {
                    throw new RuntimeException('falha ao persistir auditoria');
                }

                DB::table('auditoria_eventos_test')->insert([
                    'acao' => $payload['acao'],
                    'registro_id' => $payload['registro_id'],
                    'bindings_json' => $payload['bindings_json'],
                    'dados_depois_json' => $payload['dados_depois_json'],
                ]);
            }

            public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
            {
                throw new RuntimeException('Operacao nao usada neste teste.');
            }
        };

        return new class(new AuditLogService($auditRepository))
        {
            use AuditaDml;

            public function updatePorId(int $id, array $dados): int
            {
                return $this->atualizarAuditadoPorId(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    'id',
                    $id,
                    $dados
                );
            }

            public function insertPorId(int $id, array $dados): int|string
            {
                return $this->inserirAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    ['id' => $id] + $dados,
                    'id'
                );
            }

            public function insertSemSnapshot(int $id, array $dados): bool
            {
                return $this->inserirSemIdAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    ['id' => $id, 'quantidade' => 0] + $dados,
                    $id,
                    static fn ($query) => $query->where('id', -1)
                );
            }

            public function insertSemIdEscopoAmplo(int $id, string $valor): bool
            {
                return $this->inserirSemIdAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    ['id' => $id, 'valor' => $valor, 'quantidade' => 0],
                    null,
                    static fn ($query) => $query->where('id', '>=', 10)
                );
            }

            public function insertLoteEscopoAmplo(array $dados): bool
            {
                return $this->inserirLoteAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    $dados,
                    null,
                    static fn ($query) => $query->where('id', '>=', 20)
                );
            }

            public function updateSql(int $id, string $valor): int
            {
                return $this->atualizarSqlAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    $id,
                    'UPDATE audita_dml_alvo SET valor = ? WHERE id = ?',
                    [$valor, $id],
                    static fn ($query) => $query->where('id', $id)
                );
            }

            public function deleteSql(int $id): int
            {
                return $this->removerSqlAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    $id,
                    'DELETE FROM audita_dml_alvo WHERE id = ?',
                    [$id],
                    static fn ($query) => $query->where('id', $id)
                );
            }

            public function insertSql(int $id, string $valor): int
            {
                return $this->inserirSqlAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    $id,
                    'INSERT INTO audita_dml_alvo (id, valor, quantidade) VALUES (?, ?, 0)',
                    [$id, $valor],
                    static fn ($query) => $query->where('id', $id)
                );
            }

            public function insertSqlEscopoAmplo(int $id, string $valor): int
            {
                return $this->inserirSqlAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    null,
                    'INSERT INTO audita_dml_alvo (id, valor, quantidade) VALUES (?, ?, 0)',
                    [$id, $valor],
                    static fn ($query) => $query->where('id', '>=', 30)
                );
            }

            public function insertSqlComLocalizadorIncompleto(): int
            {
                return $this->inserirSqlAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    null,
                    "INSERT INTO audita_dml_alvo (id, valor, quantidade) VALUES (40, 'a', 0), (41, 'b', 0)",
                    [],
                    static fn ($query) => $query->where('id', 40)
                );
            }

            public function incrementar(int $id, int $quantidade): int
            {
                return $this->incrementarEscopoAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    $id,
                    static fn ($query) => $query->where('id', $id),
                    'quantidade',
                    $quantidade
                );
            }

            public function decrementar(int $id, int $quantidade): int
            {
                return $this->decrementarEscopoAuditado(
                    'audita_dml_alvo',
                    'AUDITA_DML_ALVO',
                    $id,
                    static fn ($query) => $query->where('id', $id),
                    'quantidade',
                    $quantidade
                );
            }
        };
    }
}
```
</TESTS_UNIT_AUDITADMLATOMICIDADETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlCrudRepositoriesTest.php`
## <TESTS_UNIT_AUDITADMLCRUDREPOSITORIESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlCrudRepositoriesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlCrudRepositoriesTest extends TestCase`

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
public function test_energia_repository_criar_registra_auditoria_insert(): void
public function test_energia_repository_atualizar_registra_auditoria_update(): void
public function test_energia_repository_remover_registra_auditoria_delete(): void
public function test_nat_tipo_ocorrencia_repository_criar_registra_auditoria_com_coluna_id_customizada(): void
public function test_lda_situacao_opcao_repository_criar_registra_auditoria_insert(): void
public function test_cadastro_eleitoral_pesquisa_satisfacao_criar_resposta_registra_auditoria(): void
private function registrarRepositorioAuditoriaFalso(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\CadastroEleitoral\CadastroEleitoralPesquisaSatisfacaoRepository;
use App\Repositories\TabelasAuxiliares\EnergiaRepository;
use App\Repositories\Lda\LdaSituacaoOpcaoRepository;
use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class AuditaDmlCrudRepositoriesTest extends TestCase
{
    private array $auditPayloads = [];

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $this->registrarRepositorioAuditoriaFalso();
        session([
            'user' => [
                'username' => 'auditor.teste',
                'name' => 'Auditor Teste',
            ],
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_energia_repository_criar_registra_auditoria_insert(): void
    {
        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')
            ->once()
            ->with([
                'DESCRICAO' => 'Solar',
                'IDHTML' => 'sol',
            ])
            ->andReturn(7);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('ID', 7)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'ID' => 7,
            'DESCRICAO' => 'Solar',
            'IDHTML' => 'sol',
        ]);

        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderDepois);

        $repository = new EnergiaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $id = $repository->criar([
            'descricao' => 'Solar',
            'idhtml' => 'sol',
        ]);

        $this->assertSame(7, $id);
        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('ENERGIA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('7', $this->auditPayloads[0]['registro_id']);
        $this->assertSame('auditor.teste', $this->auditPayloads[0]['usuario']);
        $this->assertStringContainsString('Solar', (string) $this->auditPayloads[0]['dados_depois_json']);
    }

    public function test_energia_repository_atualizar_registra_auditoria_update(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('ID', 5)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'ID' => 5,
            'DESCRICAO' => 'Antiga',
            'IDHTML' => 'old',
        ]);

        $builderUpdate = Mockery::mock();
        $builderUpdate->shouldReceive('where')->once()->with('ID', 5)->andReturnSelf();
        $builderUpdate->shouldReceive('update')
            ->once()
            ->with([
                'DESCRICAO' => 'Nova',
                'IDHTML' => 'new',
            ])
            ->andReturn(1);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('ID', 5)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'ID' => 5,
            'DESCRICAO' => 'Nova',
            'IDHTML' => 'new',
        ]);

        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderUpdate);
        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderDepois);

        $repository = new EnergiaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $afetados = $repository->atualizar(5, [
            'descricao' => 'Nova',
            'idhtml' => 'new',
        ]);

        $this->assertSame(1, $afetados);
        $this->assertSame('UPDATE', $this->auditPayloads[0]['acao']);
        $this->assertSame('5', $this->auditPayloads[0]['registro_id']);
        $this->assertStringContainsString('Antiga', (string) $this->auditPayloads[0]['dados_antes_json']);
        $this->assertStringContainsString('Nova', (string) $this->auditPayloads[0]['dados_depois_json']);
    }

    public function test_energia_repository_remover_registra_auditoria_delete(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('ID', 9)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'ID' => 9,
            'DESCRICAO' => 'Remover',
            'IDHTML' => 'rm',
        ]);

        $builderDelete = Mockery::mock();
        $builderDelete->shouldReceive('where')->once()->with('ID', 9)->andReturnSelf();
        $builderDelete->shouldReceive('delete')->once()->andReturn(1);

        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('ENERGIA')->andReturn($builderDelete);

        $repository = new EnergiaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $afetados = $repository->remover(9);

        $this->assertSame(1, $afetados);
        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('9', $this->auditPayloads[0]['registro_id']);
        $this->assertStringContainsString('Remover', (string) $this->auditPayloads[0]['dados_antes_json']);
        $this->assertNull($this->auditPayloads[0]['dados_depois_json']);
    }

    public function test_nat_tipo_ocorrencia_repository_criar_registra_auditoria_com_coluna_id_customizada(): void
    {
        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['nome'] === 'Sem energia'
                    && $payload['ativo'] === 'S'
                    && $payload['dt_criacao'] === 'SYSDATE';
            }), 'id_tipo_ocorrencia')
            ->andReturn(13);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_tipo_ocorrencia', 13)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_tipo_ocorrencia' => 13,
            'nome' => 'Sem energia',
            'ativo' => 'S',
        ]);

        DB::shouldReceive('table')->once()->with('nat_tipo_ocorrencia')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('nat_tipo_ocorrencia')->andReturn($builderDepois);

        $repository = new NatTipoOcorrenciaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $id = $repository->criar([
            'nome' => 'Sem energia',
            'descricao' => 'Teste',
            'ordem' => 1,
            'ativo' => true,
            'usuario_criacao' => 'auditor.teste',
            'usuario_nome_criacao' => 'Auditor Teste',
        ]);

        $this->assertSame(13, $id);
        $this->assertSame('NAT_TIPO_OCORRENCIA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('13', $this->auditPayloads[0]['registro_id']);
    }

    public function test_lda_situacao_opcao_repository_criar_registra_auditoria_insert(): void
    {
        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['codigo'] === 'CHEGOU_DESTINO'
                    && $payload['nome'] === 'Chegou ao destino'
                    && $payload['ordem'] === 10
                    && $payload['ativo'] === 1
                    && $payload['dt_criacao'] === 'SYSDATE';
            }))
            ->andReturn(21);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id', 21)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id' => 21,
            'codigo' => 'CHEGOU_DESTINO',
            'nome' => 'Chegou ao destino',
        ]);

        DB::shouldReceive('table')->once()->with('lda_situacao_opcao')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('lda_situacao_opcao')->andReturn($builderDepois);

        $repository = new LdaSituacaoOpcaoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $id = $repository->criar([
            'codigo' => 'CHEGOU_DESTINO',
            'nome' => 'Chegou ao destino',
            'descricao' => 'Primeira etapa',
            'ordem' => 10,
            'ativo' => true,
        ]);

        $this->assertSame(21, $id);
        $this->assertSame('LDA_SITUACAO_OPCAO', $this->auditPayloads[0]['entidade']);
        $this->assertSame('21', $this->auditPayloads[0]['registro_id']);
    }

    public function test_cadastro_eleitoral_pesquisa_satisfacao_criar_resposta_registra_auditoria(): void
    {
        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')
            ->once()
            ->with(Mockery::on(function (array $payload): bool {
                return $payload['id_unidade'] === 22
                    && $payload['avaliacao_tempo_espera'] === 'OTIMO'
                    && $payload['dt_criacao'] === 'SYSDATE';
            }), 'id_pesquisa_satisfacao')
            ->andReturn(31);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_pesquisa_satisfacao', 31)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_pesquisa_satisfacao' => 31,
            'id_unidade' => 22,
            'avaliacao_tempo_espera' => 'OTIMO',
        ]);

        DB::shouldReceive('table')->once()->with('cad_pesquisa_satisfacao')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('cad_pesquisa_satisfacao')->andReturn($builderDepois);

        $repository = new CadastroEleitoralPesquisaSatisfacaoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $id = $repository->criarResposta([
            'id_unidade' => 22,
            'avaliacao_tempo_espera' => 'OTIMO',
            'avaliacao_atendimento' => 'BOM',
            'avaliacao_local' => 'OTIMO',
            'ip_resposta' => '127.0.0.1',
            'user_agent' => 'Teste',
        ]);

        $this->assertSame(31, $id);
        $this->assertSame('CAD_PESQUISA_SATISFACAO', $this->auditPayloads[0]['entidade']);
        $this->assertSame('31', $this->auditPayloads[0]['registro_id']);
    }

    private function registrarRepositorioAuditoriaFalso(): void
    {
        $auditRepo = Mockery::mock(AuditLogRepositoryInterface::class);
        $auditRepo->shouldReceive('inserir')
            ->andReturnUsing(function (array $payload): void {
                $this->auditPayloads[] = $payload;
            });

        $this->app->instance(AuditLogRepositoryInterface::class, $auditRepo);
    }
}
```
</TESTS_UNIT_AUDITADMLCRUDREPOSITORIESTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlEscopoTest.php`
## <TESTS_UNIT_AUDITADMLESCOPOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlEscopoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlEscopoTest extends TestCase`

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
public function test_insert_sem_id_natural_registra_um_evento_com_snapshot_persistido(): void
public function test_insert_em_lote_registra_um_evento_com_snapshot_coletivo(): void
public function test_update_coletivo_registra_um_evento_com_antes_e_depois_integrais(): void
public function test_delete_coletivo_registra_um_evento_com_snapshot_anterior(): void
public function test_falha_de_dml_nao_registra_evento_e_relanca_excecao(): void
public function test_update_sem_linhas_afetadas_nao_registra_evento(): void
public function test_insert_preserva_dados_sensiveis_xml_usuario_e_request_id(): void
public function test_insert_em_lote_vazio_nao_executa_dml_nem_gera_evento(): void
public function test_falha_de_insert_sem_id_nao_registra_evento_e_relanca_excecao(): void
public function test_falha_de_delete_coletivo_nao_registra_evento_e_relanca_excecao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Closure;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class AuditaDmlEscopoTest extends TestCase
{
    /** @var array<int, array<string, mixed>> */
    private array $eventos = [];

    protected function setUp(): void
    {
        parent::setUp();

        $auditRepository = Mockery::mock(AuditLogRepositoryInterface::class);
        $auditRepository->shouldReceive('inserir')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (array $payload): void {
                $this->eventos[] = $payload;
            });
        $this->app->instance(AuditLogRepositoryInterface::class, $auditRepository);

        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());

        session(['user' => ['username' => 'auditor.diarias']]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_insert_sem_id_natural_registra_um_evento_com_snapshot_persistido(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('codigo', 'AEREO')->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection);

        $insert = Mockery::mock();
        $insert->shouldReceive('insert')->once()->with([
            'codigo' => 'AEREO',
            'label' => 'Aereo',
        ])->andReturnTrue();

        $depois = Mockery::mock();
        $depois->shouldReceive('where')->once()->with('codigo', 'AEREO')->andReturnSelf();
        $depois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['codigo' => 'AEREO', 'label' => 'Aereo'],
        ]));

        DB::shouldReceive('table')->times(3)->with('diarias_modal_transporte')->andReturn($antes, $insert, $depois);

        $resultado = $this->repository()->insertSemId(
            'diarias_modal_transporte',
            'AEREO',
            ['codigo' => 'AEREO', 'label' => 'Aereo'],
            static fn ($query) => $query->where('codigo', 'AEREO')
        );

        $this->assertTrue($resultado);
        $this->assertCount(1, $this->eventos);
        $this->assertSame('INSERT', $this->eventos[0]['acao']);
        $this->assertSame('DIARIAS_MODAL_TRANSPORTE', $this->eventos[0]['entidade']);
        $this->assertSame('AEREO', $this->eventos[0]['registro_id']);
        $this->assertStringContainsString('Aereo', (string) $this->eventos[0]['dados_depois_json']);
    }

    public function test_insert_em_lote_registra_um_evento_com_snapshot_coletivo(): void
    {
        $linhas = [
            ['codigo_externo' => '1', 'nome' => 'Cidade A'],
            ['codigo_externo' => '2', 'nome' => 'Cidade B'],
        ];

        $antes = Mockery::mock();
        $antes->shouldReceive('whereIn')->once()->with('codigo_externo', ['1', '2'])->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection);

        $insert = Mockery::mock();
        $insert->shouldReceive('insert')->once()->with($linhas)->andReturnTrue();

        $depois = Mockery::mock();
        $depois->shouldReceive('whereIn')->once()->with('codigo_externo', ['1', '2'])->andReturnSelf();
        $depois->shouldReceive('get')->once()->andReturn(new Collection(array_map(
            static fn (array $linha): object => (object) $linha,
            $linhas
        )));

        DB::shouldReceive('table')->times(3)->with('diarias_cidade')->andReturn($antes, $insert, $depois);

        $this->repository()->insertLote(
            'diarias_cidade',
            $linhas,
            static fn ($query) => $query->whereIn('codigo_externo', ['1', '2'])
        );

        $this->assertCount(1, $this->eventos);
        $this->assertSame('INSERT', $this->eventos[0]['acao']);
        $this->assertNull($this->eventos[0]['registro_id']);
        $this->assertStringContainsString('Cidade A', (string) $this->eventos[0]['dados_depois_json']);
        $this->assertStringContainsString('Cidade B', (string) $this->eventos[0]['dados_depois_json']);
    }

    public function test_update_coletivo_registra_um_evento_com_antes_e_depois_integrais(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('solicitacao_id', 12)->andReturnSelf();
        $antes->shouldReceive('whereIn')->once()->with('status', ['CONFIRMADA'])->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 1, 'solicitacao_id' => 12, 'beneficiario_cpf' => '12345678901', 'status' => 'CONFIRMADA'],
            (object) ['id' => 2, 'solicitacao_id' => 12, 'beneficiario_cpf' => '98765432100', 'status' => 'CONFIRMADA'],
        ]));

        $update = Mockery::mock();
        $update->shouldReceive('where')->once()->with('solicitacao_id', 12)->andReturnSelf();
        $update->shouldReceive('whereIn')->once()->with('status', ['CONFIRMADA'])->andReturnSelf();
        $update->shouldReceive('update')->once()->with(['status' => 'PAGA'])->andReturn(2);

        $depois = Mockery::mock();
        $depois->shouldReceive('whereIn')->once()->with('id', [1, 2])->andReturnSelf();
        $depois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 1, 'solicitacao_id' => 12, 'beneficiario_cpf' => '12345678901', 'status' => 'PAGA'],
            (object) ['id' => 2, 'solicitacao_id' => 12, 'beneficiario_cpf' => '98765432100', 'status' => 'PAGA'],
        ]));

        DB::shouldReceive('table')->times(3)->with('diarias_ajuda_custo')->andReturn($antes, $update, $depois);

        $afetados = $this->repository()->updateEscopo(
            'diarias_ajuda_custo',
            12,
            static fn ($query) => $query
                ->where('solicitacao_id', 12)
                ->whereIn('status', ['CONFIRMADA']),
            ['status' => 'PAGA'],
            ['where' => ['solicitacao_id' => 12]]
        );

        $this->assertSame(2, $afetados);
        $this->assertCount(1, $this->eventos);
        $this->assertSame('UPDATE', $this->eventos[0]['acao']);
        $this->assertSame('12', $this->eventos[0]['registro_id']);
        $this->assertStringContainsString('CONFIRMADA', (string) $this->eventos[0]['dados_antes_json']);
        $this->assertStringContainsString('PAGA', (string) $this->eventos[0]['dados_depois_json']);
        $this->assertStringContainsString('12345678901', (string) $this->eventos[0]['dados_depois_json']);
        $this->assertStringContainsString('solicitacao_id', (string) $this->eventos[0]['bindings_json']);
        $this->assertStringContainsString('status', (string) $this->eventos[0]['bindings_json']);
        $this->assertSame(2, json_decode((string) $this->eventos[0]['bindings_json'], true)['afetados']);
    }

    public function test_delete_coletivo_registra_um_evento_com_snapshot_anterior(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('solicitacao_id', 77)->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 8, 'solicitacao_id' => 77],
        ]));

        $delete = Mockery::mock();
        $delete->shouldReceive('where')->once()->with('solicitacao_id', 77)->andReturnSelf();
        $delete->shouldReceive('delete')->once()->andReturn(1);

        DB::shouldReceive('table')->times(2)->with('diarias_solicitacao_adicional')->andReturn($antes, $delete);

        $afetados = $this->repository()->deleteEscopo(
            'diarias_solicitacao_adicional',
            77,
            static fn ($query) => $query->where('solicitacao_id', 77),
            ['where' => ['solicitacao_id' => 77]]
        );

        $this->assertSame(1, $afetados);
        $this->assertCount(1, $this->eventos);
        $this->assertSame('DELETE', $this->eventos[0]['acao']);
        $this->assertStringContainsString('77', (string) $this->eventos[0]['dados_antes_json']);
        $this->assertNull($this->eventos[0]['dados_depois_json']);
        $this->assertSame(1, json_decode((string) $this->eventos[0]['bindings_json'], true)['afetados']);
    }

    public function test_falha_de_dml_nao_registra_evento_e_relanca_excecao(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('id', 9)->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 9, 'valor' => 'antes'],
        ]));

        $update = Mockery::mock();
        $update->shouldReceive('where')->once()->with('id', 9)->andReturnSelf();
        $update->shouldReceive('update')->once()->andThrow(new RuntimeException('falha Oracle'));

        DB::shouldReceive('table')->twice()->with('diarias_parametro')->andReturn($antes, $update);

        try {
            $this->repository()->updateEscopo(
                'diarias_parametro',
                9,
                static fn ($query) => $query->where('id', 9),
                ['valor' => 'depois'],
                ['where' => ['id' => 9]]
            );
            $this->fail('A excecao original deveria ser relancada.');
        } catch (RuntimeException $e) {
            $this->assertSame('falha Oracle', $e->getMessage());
        }

        $this->assertSame([], $this->eventos);
    }

    public function test_update_sem_linhas_afetadas_nao_registra_evento(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('id', 404)->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection);

        $update = Mockery::mock();
        $update->shouldReceive('where')->once()->with('id', 404)->andReturnSelf();
        $update->shouldReceive('update')->once()->with(['ativo' => 0])->andReturn(0);

        DB::shouldReceive('table')->times(2)->with('diarias_veiculo')->andReturn($antes, $update);

        $afetados = $this->repository()->updateEscopo(
            'diarias_veiculo',
            404,
            static fn ($query) => $query->where('id', 404),
            ['ativo' => 0],
            ['where' => ['id' => 404]]
        );

        $this->assertSame(0, $afetados);
        $this->assertSame([], $this->eventos);
    }

    public function test_insert_preserva_dados_sensiveis_xml_usuario_e_request_id(): void
    {
        $this->app['request']->headers->set('X-Request-Id', 'req-diarias-123');
        $dados = [
            'cpf' => '12345678901',
            'email' => 'pessoa@tre-ac.jus.br',
            'banco' => '001',
            'agencia' => '1234',
            'conta' => '98765-4',
            'pix' => '12345678901',
            'xml_retorno' => '<retorno><status>OK</status></retorno>',
        ];

        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('cpf', '12345678901')->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection);

        $insert = Mockery::mock();
        $insert->shouldReceive('insert')->once()->with($dados)->andReturnTrue();
        $depois = Mockery::mock();
        $depois->shouldReceive('where')->once()->with('cpf', '12345678901')->andReturnSelf();
        $depois->shouldReceive('get')->once()->andReturn(new Collection([(object) $dados]));
        DB::shouldReceive('table')->times(3)->with('diarias_dado_sensivel')->andReturn($antes, $insert, $depois);

        $this->repository()->insertSemId(
            'diarias_dado_sensivel',
            'SENS-1',
            $dados,
            static fn ($query) => $query->where('cpf', '12345678901')
        );

        $this->assertCount(1, $this->eventos);
        $this->assertSame('auditor.diarias', $this->eventos[0]['usuario']);
        $this->assertSame('req-diarias-123', $this->eventos[0]['request_id']);
        foreach (['12345678901', 'pessoa@tre-ac.jus.br', '001', '1234', '98765-4', '<retorno><status>OK</status></retorno>'] as $valor) {
            $this->assertStringContainsString($valor, (string) $this->eventos[0]['dados_depois_json']);
        }
    }

    public function test_insert_em_lote_vazio_nao_executa_dml_nem_gera_evento(): void
    {
        $resultado = $this->repository()->insertLote('diarias_cidade', [], static fn ($query) => $query);

        $this->assertTrue($resultado);
        $this->assertSame([], $this->eventos);
    }

    public function test_falha_de_insert_sem_id_nao_registra_evento_e_relanca_excecao(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('codigo', 'GRUPO')->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection);

        $insert = Mockery::mock();
        $insert->shouldReceive('insert')->once()->andThrow(new RuntimeException('falha no insert'));
        DB::shouldReceive('table')->twice()->with('diarias_grupo')->andReturn($antes, $insert);

        try {
            $this->repository()->insertSemId(
                'diarias_grupo',
                'GRUPO',
                ['codigo' => 'GRUPO'],
                static fn ($query) => $query->where('codigo', 'GRUPO')
            );
            $this->fail('A excecao original deveria ser relancada.');
        } catch (RuntimeException $e) {
            $this->assertSame('falha no insert', $e->getMessage());
        }

        $this->assertSame([], $this->eventos);
    }

    public function test_falha_de_delete_coletivo_nao_registra_evento_e_relanca_excecao(): void
    {
        $antes = Mockery::mock();
        $antes->shouldReceive('where')->once()->with('solicitacao_id', 99)->andReturnSelf();
        $antes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $antes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 1, 'solicitacao_id' => 99],
        ]));

        $delete = Mockery::mock();
        $delete->shouldReceive('where')->once()->with('solicitacao_id', 99)->andReturnSelf();
        $delete->shouldReceive('delete')->once()->andThrow(new RuntimeException('falha no delete'));
        DB::shouldReceive('table')->twice()->with('diarias_solicitacao_trecho')->andReturn($antes, $delete);

        try {
            $this->repository()->deleteEscopo(
                'diarias_solicitacao_trecho',
                99,
                static fn ($query) => $query->where('solicitacao_id', 99),
                ['where' => ['solicitacao_id' => 99]]
            );
            $this->fail('A excecao original deveria ser relancada.');
        } catch (RuntimeException $e) {
            $this->assertSame('falha no delete', $e->getMessage());
        }

        $this->assertSame([], $this->eventos);
    }

    private function repository(): object
    {
        return new class(app(AuditLogService::class))
        {
            use AuditaDml;

            public function insertSemId(
                string $tabela,
                int|string $id,
                array $dados,
                ?Closure $localizador = null
            ): bool {
                return $this->inserirSemIdAuditado($tabela, strtoupper($tabela), $dados, $id, $localizador);
            }

            public function insertLote(string $tabela, array $dados, Closure $localizador): bool
            {
                return $this->inserirLoteAuditado($tabela, strtoupper($tabela), $dados, null, $localizador);
            }

            public function updateEscopo(
                string $tabela,
                int|string|null $id,
                Closure $escopo,
                array $dados,
                array $bindings
            ): int {
                return $this->atualizarEscopoAuditado($tabela, strtoupper($tabela), $id, $escopo, $dados, $bindings);
            }

            public function deleteEscopo(
                string $tabela,
                int|string|null $id,
                Closure $escopo,
                array $bindings
            ): int {
                return $this->removerEscopoAuditado($tabela, strtoupper($tabela), $id, $escopo, $bindings);
            }
        };
    }
}
```
</TESTS_UNIT_AUDITADMLESCOPOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlOperacoesCompostasRepositoriesTest.php`
## <TESTS_UNIT_AUDITADMLOPERACOESCOMPOSTASREPOSITORIESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlOperacoesCompostasRepositoriesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlOperacoesCompostasRepositoriesTest extends TestCase`

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
public function test_nat_ocorrencia_repository_marcar_em_andamento_registra_auditoria_update(): void
public function test_rota_repository_sincronizar_locais_registra_delete_e_insert_reais(): void
public function test_local_transmissao_repository_vincular_locais_registra_apenas_novos(): void
public function test_equipe_repository_sincronizar_por_vinculo_registra_criacao_do_vinculo_e_sync_da_equipe(): void
private function registrarRepositorioAuditoriaFalso(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Repositories\Lda\EquipeRepository;
use App\Repositories\Lda\LocalTransmissaoRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Lda\RotaRepository;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class AuditaDmlOperacoesCompostasRepositoriesTest extends TestCase
{
    private array $auditPayloads = [];

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $this->registrarRepositorioAuditoriaFalso();
        session([
            'user' => [
                'username' => 'auditor.operacoes',
                'name' => 'Auditor Operacoes',
            ],
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_nat_ocorrencia_repository_marcar_em_andamento_registra_auditoria_update(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('id_ocorrencia', 18)->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'id_ocorrencia' => 18,
            'id_status' => 1,
        ]);

        $builderUpdate = Mockery::mock();
        $builderUpdate->shouldReceive('where')->once()->with('id_ocorrencia', 18)->andReturnSelf();
        $builderUpdate->shouldReceive('update')->once()->with(Mockery::on(function (array $payload): bool {
            return $payload['id_status'] === 2
                && $payload['dt_inicio_atendimento'] === 'SYSDATE'
                && $payload['usuario_atualizacao'] === 'operador';
        }))->andReturn(1);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id_ocorrencia', 18)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id_ocorrencia' => 18,
            'id_status' => 2,
        ]);

        DB::shouldReceive('table')->once()->with('nat_ocorrencia')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('nat_ocorrencia')->andReturn($builderUpdate);
        DB::shouldReceive('table')->once()->with('nat_ocorrencia')->andReturn($builderDepois);

        $repository = new NatOcorrenciaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->marcarEmAndamento(18, 2, [
            'login' => 'operador',
            'nome' => 'Operador',
        ]);

        $this->assertSame('UPDATE', $this->auditPayloads[0]['acao']);
        $this->assertSame('NAT_OCORRENCIA', $this->auditPayloads[0]['entidade']);
        $this->assertSame('18', $this->auditPayloads[0]['registro_id']);
    }

    public function test_rota_repository_sincronizar_locais_registra_delete_e_insert_reais(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('rl_sync.ROTA_ID', 44)->andReturnSelf();
        $builderAntes->shouldReceive('whereExists')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['ROTA_ID' => 44, 'COD_OBJETO_LOCAL' => '10'],
        ]));

        $builderDelete = Mockery::mock();
        $builderDelete->shouldReceive('where')->once()->with('rl_sync.ROTA_ID', 44)->andReturnSelf();
        $builderDelete->shouldReceive('whereExists')->once()->with(Mockery::type(\Closure::class))->andReturnSelf();
        $builderDelete->shouldReceive('delete')->once()->andReturn(1);

        $builderAntesInsert = Mockery::mock();
        $builderAntesInsert->shouldReceive('where')->once()->with('ROTA_ID', 44)->andReturnSelf();
        $builderAntesInsert->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntesInsert->shouldReceive('get')->once()->andReturn(new Collection);

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insert')->once()->with([
            ['ROTA_ID' => 44, 'COD_OBJETO_LOCAL' => '10'],
            ['ROTA_ID' => 44, 'COD_OBJETO_LOCAL' => '20'],
        ])->andReturnTrue();

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('ROTA_ID', 44)->andReturnSelf();
        $builderDepois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['ROTA_ID' => 44, 'COD_OBJETO_LOCAL' => '10'],
            (object) ['ROTA_ID' => 44, 'COD_OBJETO_LOCAL' => '20'],
        ]));

        DB::shouldReceive('table')->once()->with('ROTA_LOCAL as rl_sync')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('ROTA_LOCAL as rl_sync')->andReturn($builderDelete);
        DB::shouldReceive('table')->once()->with('ROTA_LOCAL')->andReturn($builderAntesInsert);
        DB::shouldReceive('table')->once()->with('ROTA_LOCAL')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('ROTA_LOCAL')->andReturn($builderDepois);

        $repository = new RotaRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->sincronizarLocais(44, ['10', '20']);

        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('ROTA_LOCAL', $this->auditPayloads[0]['entidade']);
        $this->assertSame('INSERT', $this->auditPayloads[1]['acao']);
        $this->assertStringContainsString('20', (string) $this->auditPayloads[1]['dados_depois_json']);
    }

    public function test_local_transmissao_repository_vincular_locais_registra_apenas_novos(): void
    {
        $builderExists = Mockery::mock();
        $builderExists->shouldReceive('where')->once()->with('local_transmissao_id', 8)->andReturnSelf();
        $builderExists->shouldReceive('where')->once()->with('cod_objeto_local', '100')->andReturnSelf();
        $builderExists->shouldReceive('exists')->once()->andReturnTrue();

        $builderExistsNovo = Mockery::mock();
        $builderExistsNovo->shouldReceive('where')->once()->with('local_transmissao_id', 8)->andReturnSelf();
        $builderExistsNovo->shouldReceive('where')->once()->with('cod_objeto_local', '200')->andReturnSelf();
        $builderExistsNovo->shouldReceive('exists')->once()->andReturnFalse();

        DB::shouldReceive('selectOne')->once()->andReturn(null);

        $builderAntesInsert = Mockery::mock();
        $builderAntesInsert->shouldReceive('where')->once()->with('local_transmissao_id', 8)->andReturnSelf();
        $builderAntesInsert->shouldReceive('where')->once()->with('cod_objeto_local', '200')->andReturnSelf();
        $builderAntesInsert->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntesInsert->shouldReceive('get')->once()->andReturn(new Collection);

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insert')->once()->with([
            'local_transmissao_id' => 8,
            'cod_objeto_local' => '200',
        ])->andReturnTrue();

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('local_transmissao_id', 8)->andReturnSelf();
        $builderDepois->shouldReceive('where')->once()->with('cod_objeto_local', '200')->andReturnSelf();
        $builderDepois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['local_transmissao_id' => 8, 'cod_objeto_local' => '200'],
        ]));

        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderExists);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderExistsNovo);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderAntesInsert);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderDepois);

        $repository = new LocalTransmissaoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->vincularLocaisVotacao(8, ['100', '200']);

        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('TBTRANSMISSAOVOTACAO', $this->auditPayloads[0]['entidade']);
        $this->assertStringNotContainsString('100', (string) $this->auditPayloads[0]['dados_depois_json']);
        $this->assertStringContainsString('200', (string) $this->auditPayloads[0]['dados_depois_json']);
    }

    public function test_equipe_repository_sincronizar_por_vinculo_registra_criacao_do_vinculo_e_sync_da_equipe(): void
    {
        $builderVinculoBusca = Mockery::mock();
        $builderVinculoBusca->shouldReceive('select')->once()->with('ID')->andReturnSelf();
        $builderVinculoBusca->shouldReceive('where')->once()->with('TIPO_VINCULO', 'ROTA')->andReturnSelf();
        $builderVinculoBusca->shouldReceive('where')->once()->with('VINCULO_ID', 77)->andReturnSelf();
        $builderVinculoBusca->shouldReceive('first')->once()->andReturn(null);

        $builderVinculoInsert = Mockery::mock();
        $builderVinculoInsert->shouldReceive('insertGetId')->once()->with(Mockery::on(static fn (array $payload): bool => $payload['TIPO_VINCULO'] === 'ROTA' && $payload['VINCULO_ID'] === 77
        ), 'ID')->andReturn(12);

        $builderVinculoDepois = Mockery::mock();
        $builderVinculoDepois->shouldReceive('where')->once()->with('ID', 12)->andReturnSelf();
        $builderVinculoDepois->shouldReceive('first')->once()->andReturn((object) ['ID' => 12, 'TIPO_VINCULO' => 'ROTA']);

        $builderEquipeAntes = Mockery::mock();
        $builderEquipeAntes->shouldReceive('where')->once()->with('EQUIPE_VINCULO_ID', 12)->andReturnSelf();
        $builderEquipeAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderEquipeAntes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['EQUIPE_VINCULO_ID' => 12, 'NUM_INSCRICAO' => '111'],
        ]));

        $builderEquipeDelete = Mockery::mock();
        $builderEquipeDelete->shouldReceive('where')->once()->with('EQUIPE_VINCULO_ID', 12)->andReturnSelf();
        $builderEquipeDelete->shouldReceive('delete')->once()->andReturn(1);

        $builderEquipeInsert1 = Mockery::mock();
        $builderEquipeInsert1->shouldReceive('insertGetId')->once()->with(Mockery::on(static fn (array $payload): bool => $payload['ROTA_ID'] === 77
                && $payload['EQUIPE_VINCULO_ID'] === 12
                && $payload['NUM_INSCRICAO'] === '222'
                && $payload['COD_OBJETO_LOCAL_RESPONSAVEL'] === 'LOCAL-10'
        ), 'ID')->andReturn(21);
        $builderEquipeDepois1 = Mockery::mock();
        $builderEquipeDepois1->shouldReceive('where')->once()->with('ID', 21)->andReturnSelf();
        $builderEquipeDepois1->shouldReceive('first')->once()->andReturn((object) ['ID' => 21, 'NUM_INSCRICAO' => '222', 'COD_OBJETO_LOCAL_RESPONSAVEL' => 'LOCAL-10']);

        $builderEquipeInsert2 = Mockery::mock();
        $builderEquipeInsert2->shouldReceive('insertGetId')->once()->with(Mockery::on(static fn (array $payload): bool => $payload['NUM_INSCRICAO'] === '333' && array_key_exists('COD_OBJETO_LOCAL_RESPONSAVEL', $payload)
        ), 'ID')->andReturn(22);
        $builderEquipeDepois2 = Mockery::mock();
        $builderEquipeDepois2->shouldReceive('where')->once()->with('ID', 22)->andReturnSelf();
        $builderEquipeDepois2->shouldReceive('first')->once()->andReturn((object) ['ID' => 22, 'NUM_INSCRICAO' => '333', 'COD_OBJETO_LOCAL_RESPONSAVEL' => null]);

        DB::shouldReceive('table')->once()->with('EQUIPE_VINCULO')->andReturn($builderVinculoBusca);
        DB::shouldReceive('table')->once()->with('EQUIPE_VINCULO')->andReturn($builderVinculoInsert);
        DB::shouldReceive('table')->once()->with('EQUIPE_VINCULO')->andReturn($builderVinculoDepois);
        DB::shouldReceive('table')->once()->with('EQUIPE')->andReturn($builderEquipeAntes);
        DB::shouldReceive('table')->once()->with('EQUIPE')->andReturn($builderEquipeDelete);
        DB::shouldReceive('table')->once()->with('EQUIPE')->andReturn($builderEquipeInsert1);
        DB::shouldReceive('table')->once()->with('EQUIPE')->andReturn($builderEquipeDepois1);
        DB::shouldReceive('table')->once()->with('EQUIPE')->andReturn($builderEquipeInsert2);
        DB::shouldReceive('table')->once()->with('EQUIPE')->andReturn($builderEquipeDepois2);

        $repository = new EquipeRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->sincronizarPorVinculo('ROTA', 77, [
            [
                'cargo_id' => 1,
                'num_inscricao' => '222',
                'observacao' => 'Titular',
                'cod_objeto_local_responsavel' => 'LOCAL-10',
            ],
            [
                'cargo_id' => 2,
                'num_inscricao' => '333',
                'observacao' => 'Apoio',
                'cod_objeto_local_responsavel' => null,
            ],
        ]);

        $this->assertCount(4, $this->auditPayloads);
        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('EQUIPE_VINCULO', $this->auditPayloads[0]['entidade']);
        $this->assertSame('DELETE', $this->auditPayloads[1]['acao']);
        $this->assertSame('EQUIPE', $this->auditPayloads[1]['entidade']);
        $this->assertSame('INSERT', $this->auditPayloads[2]['acao']);
        $this->assertStringContainsString('LOCAL-10', (string) $this->auditPayloads[2]['dados_depois_json']);
        $this->assertSame('INSERT', $this->auditPayloads[3]['acao']);
        $this->assertStringContainsString('333', (string) $this->auditPayloads[3]['dados_depois_json']);
    }

    private function registrarRepositorioAuditoriaFalso(): void
    {
        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (array $payload): void {
                $this->auditPayloads[] = $payload;
            });

        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }
}
```
</TESTS_UNIT_AUDITADMLOPERACOESCOMPOSTASREPOSITORIESTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/AuditaDmlTransmissaoAvancadaRepositoriesTest.php`
## <TESTS_UNIT_AUDITADMLTRANSMISSAOAVANCADAREPOSITORIESTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/AuditaDmlTransmissaoAvancadaRepositoriesTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class AuditaDmlTransmissaoAvancadaRepositoriesTest extends TestCase`

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
public function test_local_votacao_repository_atualizar_coordenadas_registra_update(): void
public function test_local_votacao_repository_sincronizar_transmissoes_preferenciais_registra_comandos_reais(): void
public function test_trajeto_local_votacao_repository_salvar_agregado_registra_dml_auditado(): void
public function test_local_votacao_deslocamento_repository_salvar_registra_insert(): void
private function registrarRepositorioAuditoriaFalso(): void
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
use App\Repositories\LocaisVotacao\LocalVotacaoRepository;
use App\Repositories\LocaisVotacao\TrajetoLocalVotacaoRepository;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Mockery;
use ReflectionClass;
use Tests\TestCase;

class AuditaDmlTransmissaoAvancadaRepositoriesTest extends TestCase
{
    private array $auditPayloads = [];

    protected function setUp(): void
    {
        parent::setUp();

        DB::shouldReceive('raw')->andReturnUsing(static fn ($expr) => $expr);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
        $this->registrarRepositorioAuditoriaFalso();
        $this->resetarCachesEstáticos();
        session([
            'user' => [
                'username' => 'auditor.transmissao',
                'name' => 'Auditor Transmissao',
            ],
        ]);
    }

    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    public function test_local_votacao_repository_atualizar_coordenadas_registra_update(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('cod_objeto', 'LV-10')->andReturnSelf();
        $builderAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn((object) [
            'cod_objeto' => 'LV-10',
            'num_latitude' => null,
            'num_longitude' => null,
        ]);

        $builderUpdate = Mockery::mock();
        $builderUpdate->shouldReceive('where')->once()->with('cod_objeto', 'LV-10')->andReturnSelf();
        $builderUpdate->shouldReceive('update')->once()->with([
            'num_latitude' => -9.975,
            'num_longitude' => -67.812,
        ])->andReturn(1);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('cod_objeto', 'LV-10')->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'cod_objeto' => 'LV-10',
            'num_latitude' => -9.975,
            'num_longitude' => -67.812,
        ]);

        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_st')->andReturn($builderAntes);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_st')->andReturn($builderUpdate);
        DB::shouldReceive('table')->once()->with('planeleito.local_votacao_st')->andReturn($builderDepois);

        $repository = new LocalVotacaoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->atualizarCoordenadas('LV-10', -9.975, -67.812);

        $this->assertSame('UPDATE', $this->auditPayloads[0]['acao']);
        $this->assertSame('LOCAL_VOTACAO_ST', $this->auditPayloads[0]['entidade']);
        $this->assertSame('LV-10', $this->auditPayloads[0]['registro_id']);
    }

    public function test_local_votacao_repository_sincronizar_transmissoes_preferenciais_registra_comandos_reais(): void
    {
        DB::shouldReceive('selectOne')->zeroOrMoreTimes()->andReturn(null);

        $builderValidacaoEfetivos = Mockery::mock();
        $builderValidacaoEfetivos->shouldReceive('whereIn')->once()->with('id', [11, 12])->andReturnSelf();
        $builderValidacaoEfetivos->shouldReceive('pluck')->once()->with('id')->andReturn(collect([11, 12]));

        $builderDeleteAntes = Mockery::mock();
        $builderDeleteAntes->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-20')->andReturnSelf();
        $builderDeleteAntes->shouldReceive('where')->once()->with(Mockery::on(static function ($callback) use ($builderDeleteAntes): bool {
            $callback($builderDeleteAntes);

            return true;
        }))->andReturnSelf();
        $builderDeleteAntes->shouldReceive('whereIn')->once()->with('local_transmissao_id', [7, 11, 12])->andReturnSelf();
        $builderDeleteAntes->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderDeleteAntes->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['cod_objeto_local' => 'LV-20', 'local_transmissao_id' => 7],
        ]));

        $builderHistoricos = Mockery::mock();
        $builderHistoricos->shouldReceive('leftJoin')->once()->with(
            'planeleito.vw_locais_transmissao_efetivos as lt_efetivo',
            'lt_efetivo.id',
            '=',
            'tv_historico.local_transmissao_id'
        )->andReturnSelf();
        $builderHistoricos->shouldReceive('where')->once()->with('tv_historico.cod_objeto_local', 'LV-20')->andReturnSelf();
        $builderHistoricos->shouldReceive('whereNotNull')->once()->with('tv_historico.local_transmissao_id')->andReturnSelf();
        $builderHistoricos->shouldReceive('whereNull')->once()->with('lt_efetivo.id')->andReturnSelf();
        $builderHistoricos->shouldReceive('select')->once()->with('tv_historico.local_transmissao_id')->andReturnSelf();
        $builderHistoricos->shouldReceive('orderBy')->once()->with('tv_historico.local_transmissao_id')->andReturnSelf();
        $builderHistoricos->shouldReceive('get')->once()->andReturn(collect());

        $builderTodosEfetivos = Mockery::mock();
        $builderTodosEfetivos->shouldReceive('pluck')->once()->with('id')->andReturn(collect([7, 11, 12]));

        $builderDelete = Mockery::mock();
        $builderDelete->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-20')->andReturnSelf();
        $builderDelete->shouldReceive('where')->once()->with(
            Mockery::on(static function ($callback) use ($builderDelete): bool {
                $callback($builderDelete);

                return true;
            })
        )->andReturnSelf();
        $builderDelete->shouldReceive('whereIn')->once()->with('local_transmissao_id', [7, 11, 12])->andReturnSelf();
        $builderDelete->shouldReceive('delete')->once()->andReturn(1);

        $builderAntesInsert = Mockery::mock();
        $builderAntesInsert->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-20')->andReturnSelf();
        $builderAntesInsert->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $builderAntesInsert->shouldReceive('get')->once()->andReturn(new Collection);

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insert')->once()->with([
            ['cod_objeto_local' => 'LV-20', 'local_transmissao_id' => 11],
            ['cod_objeto_local' => 'LV-20', 'local_transmissao_id' => 12],
        ])->andReturnTrue();

        $builderInsertDepois = Mockery::mock();
        $builderInsertDepois->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-20')->andReturnSelf();
        $builderInsertDepois->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['cod_objeto_local' => 'LV-20', 'local_transmissao_id' => 11],
            (object) ['cod_objeto_local' => 'LV-20', 'local_transmissao_id' => 12],
        ]));

        DB::shouldReceive('table')->once()->with('planeleito.vw_locais_transmissao_efetivos')->andReturn($builderValidacaoEfetivos);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao as tv_historico')->andReturn($builderHistoricos);
        DB::shouldReceive('table')->once()->with('planeleito.vw_locais_transmissao_efetivos')->andReturn($builderTodosEfetivos);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderDeleteAntes);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderDelete);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderAntesInsert);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderInsert);
        DB::shouldReceive('table')->once()->with('planeleito.tbtransmissaovotacao')->andReturn($builderInsertDepois);

        $repository = new LocalVotacaoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->sincronizarTransmissoesPreferenciais('LV-20', ['lt:11', 'lt:12']);

        $this->assertCount(2, $this->auditPayloads);
        $this->assertSame('DELETE', $this->auditPayloads[0]['acao']);
        $this->assertSame('TBTRANSMISSAOVOTACAO', $this->auditPayloads[0]['entidade']);
        $this->assertSame('LV-20', $this->auditPayloads[0]['registro_id']);
        $this->assertSame('INSERT', $this->auditPayloads[1]['acao']);
        $this->assertStringContainsString('12', (string) $this->auditPayloads[1]['dados_depois_json']);
    }

    public function test_trajeto_local_votacao_repository_salvar_agregado_registra_dml_auditado(): void
    {
        $childBefore = Mockery::mock();
        $childBefore->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-10')->andReturnSelf();
        $childBefore->shouldReceive('where')->once()->with('macroprojeto_id', 12)->andReturnSelf();
        $childBefore->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $childBefore->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 31, 'trajeto_id' => 21, 'cod_objeto_local' => 'LV-10'],
        ]));

        $childDelete = Mockery::mock();
        $childDelete->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-10')->andReturnSelf();
        $childDelete->shouldReceive('where')->once()->with('macroprojeto_id', 12)->andReturnSelf();
        $childDelete->shouldReceive('delete')->once()->andReturn(1);

        $parentBefore = Mockery::mock();
        $parentBefore->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-10')->andReturnSelf();
        $parentBefore->shouldReceive('where')->once()->with('macroprojeto_id', 12)->andReturnSelf();
        $parentBefore->shouldReceive('lockForUpdate')->once()->andReturnSelf();
        $parentBefore->shouldReceive('get')->once()->andReturn(new Collection([
            (object) ['id' => 21, 'cod_objeto_local' => 'LV-10', 'macroprojeto_id' => 12, 'ordem_preferencia' => 1],
        ]));

        $parentDelete = Mockery::mock();
        $parentDelete->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-10')->andReturnSelf();
        $parentDelete->shouldReceive('where')->once()->with('macroprojeto_id', 12)->andReturnSelf();
        $parentDelete->shouldReceive('delete')->once()->andReturn(1);

        $parentInsert = Mockery::mock();
        $parentInsert->shouldReceive('insertGetId')->once()->with(
            Mockery::on(static fn (array $payload): bool => $payload['ordem_preferencia'] === 1
                && $payload['descricao'] === 'Via fluvial'),
            'id'
        )->andReturn(41);

        $parentAfter = Mockery::mock();
        $parentAfter->shouldReceive('where')->once()->with('id', 41)->andReturnSelf();
        $parentAfter->shouldReceive('first')->once()->andReturn((object) [
            'id' => 41, 'cod_objeto_local' => 'LV-10', 'macroprojeto_id' => 12, 'ordem_preferencia' => 1,
        ]);

        $childInsert = Mockery::mock();
        $childInsert->shouldReceive('insertGetId')->once()->with(
            Mockery::on(static fn (array $payload): bool => $payload['trajeto_id'] === 41
                && $payload['lda_id'] === 8
                && $payload['acesso_id'] === 4
                && $payload['distancia_km'] === 18.7),
            'id'
        )->andReturn(51);

        $childAfter = Mockery::mock();
        $childAfter->shouldReceive('where')->once()->with('id', 51)->andReturnSelf();
        $childAfter->shouldReceive('first')->once()->andReturn((object) [
            'id' => 51, 'trajeto_id' => 41, 'cod_objeto_local' => 'LV-10', 'acesso_id' => 4,
        ]);

        DB::shouldReceive('table')->once()->with('lda_trajeto_trecho')->andReturn($childBefore);
        DB::shouldReceive('table')->once()->with('lda_trajeto_trecho')->andReturn($childDelete);
        DB::shouldReceive('table')->once()->with('lda_trajeto')->andReturn($parentBefore);
        DB::shouldReceive('table')->once()->with('lda_trajeto')->andReturn($parentDelete);
        DB::shouldReceive('table')->once()->with('lda_trajeto')->andReturn($parentInsert);
        DB::shouldReceive('table')->once()->with('lda_trajeto')->andReturn($parentAfter);
        DB::shouldReceive('table')->once()->with('lda_trajeto_trecho')->andReturn($childInsert);
        DB::shouldReceive('table')->once()->with('lda_trajeto_trecho')->andReturn($childAfter);

        $repository = new TrajetoLocalVotacaoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->salvarPorLocal('LV-10', 12, [[
            'ordem_preferencia' => 1,
            'descricao' => 'Via fluvial',
            'trechos' => [[
                'ordem' => 1,
                'acesso_id' => 4,
                'origem' => 'TRE',
                'destino' => 'Local',
                'distancia_km' => 18.7,
                'tempo_deslocamento_horas' => 2.5,
                'observacao' => 'Barco',
            ]],
        ]], 8);

        $this->assertCount(4, $this->auditPayloads);
        $this->assertSame(
            ['LDA_TRAJETO_TRECHO', 'LDA_TRAJETO', 'LDA_TRAJETO', 'LDA_TRAJETO_TRECHO'],
            array_column($this->auditPayloads, 'entidade')
        );
        $this->assertSame(['DELETE', 'DELETE', 'INSERT', 'INSERT'], array_column($this->auditPayloads, 'acao'));
    }

    public function test_local_votacao_deslocamento_repository_salvar_registra_insert(): void
    {
        $builderAntes = Mockery::mock();
        $builderAntes->shouldReceive('where')->once()->with('cod_objeto_local', 'LV-10')->andReturnSelf();
        $builderAntes->shouldReceive('where')->once()->with('macroprojeto_turno_id', 501)->andReturnSelf();
        $builderAntes->shouldReceive('first')->once()->andReturn(null);

        $builderInsert = Mockery::mock();
        $builderInsert->shouldReceive('insertGetId')->once()->with(
            Mockery::on(static function (array $dados): bool {
                return $dados['cod_objeto_local'] === 'LV-10'
                    && $dados['macroprojeto_turno_id'] === 501
                    && $dados['dt_saida_prevista']->format('Y-m-d H:i:s') === '2026-05-26 08:00:00'
                    && $dados['observacao_deslocamento'] === 'Saida prevista';
            }),
            'id'
        )->andReturn(55);

        $builderDepois = Mockery::mock();
        $builderDepois->shouldReceive('where')->once()->with('id', 55)->andReturnSelf();
        $builderDepois->shouldReceive('first')->once()->andReturn((object) [
            'id' => 55,
            'cod_objeto_local' => 'LV-10',
            'macroprojeto_turno_id' => 501,
            'observacao_deslocamento' => 'Saida prevista',
        ]);
        DB::shouldReceive('table')->times(3)->with('local_votacao_deslocamento')
            ->andReturn($builderAntes, $builderInsert, $builderDepois);

        $repository = new LocalVotacaoDeslocamentoRepository(app(\App\Services\Auditoria\AuditLogService::class));
        $repository->salvarPorLocal('LV-10', 501, [
            'dt_saida_prevista' => '2026-05-26 08:00:00',
            'dt_chegada_prevista' => '2026-05-26 10:00:00',
            'observacao_deslocamento' => 'Saida prevista',
        ]);

        $this->assertSame('INSERT', $this->auditPayloads[0]['acao']);
        $this->assertSame('LOCAL_VOTACAO_DESLOCAMENTO', $this->auditPayloads[0]['entidade']);
        $this->assertSame('55', $this->auditPayloads[0]['registro_id']);
    }

    private function registrarRepositorioAuditoriaFalso(): void
    {
        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')
            ->zeroOrMoreTimes()
            ->andReturnUsing(function (array $payload): void {
                $this->auditPayloads[] = $payload;
            });

        $this->app->instance(AuditLogRepositoryInterface::class, $repository);
    }

    private function resetarCachesEstáticos(): void
    {
        $reflection = new ReflectionClass(LocalVotacaoRepository::class);
        foreach (['ordemPreferenciaDisponivel', 'ldaIdDisponivel', 'codObjetoLocalVotacaoEmLocalTransmissaoDisponivel'] as $property) {
            $prop = $reflection->getProperty($property);
            $prop->setAccessible(true);
            $prop->setValue(null, null);
        }
    }
}
```
</TESTS_UNIT_AUDITADMLTRANSMISSAOAVANCADAREPOSITORIESTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/CoordenadorAcessibilidadeAuditaDmlTest.php`
## <TESTS_UNIT_COORDENADORACESSIBILIDADEAUDITADMLTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/CoordenadorAcessibilidadeAuditaDmlTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class CoordenadorAcessibilidadeAuditaDmlTest extends TestCase`

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
public function repository_de_coordenador_encaminha_insert_update_e_delete_para_audita_dml(): void
protected function inserirAuditado(string $tabela, string $entidade, array $dados, string $colunaId = 'ID', ?string $sequencia = null): int
protected function atualizarAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id, array $dados): int
protected function removerAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id): int
protected function salvarRespostasQuestionario(int $idCoordenador, array $dados): void
public function exclusao_de_coordenador_audita_respostas_antes_do_cadastro(): void
protected function removerAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id): int
public function questionario_de_coordenador_audita_update_e_insert(): void
public function salvarRespostas(int $idCoordenador, array $dados): void
protected function inserirAuditado(string $tabela, string $entidade, array $dados, string $colunaId = 'ID', ?string $sequencia = null): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\CoordenadorAcessibilidadeRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class CoordenadorAcessibilidadeAuditaDmlTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        DB::shouldReceive('raw')->andReturnUsing(static fn ($valor) => $valor);
        DB::shouldReceive('transaction')
            ->byDefault()
            ->andReturnUsing(static fn (callable $callback): mixed => $callback());
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function repository_de_coordenador_encaminha_insert_update_e_delete_para_audita_dml(): void
    {
        DB::shouldReceive('transaction')->times(3)->andReturnUsing(static fn ($callback) => $callback());
        $respostas = Mockery::mock();
        $respostas->shouldReceive('where')->once()->with('id_coordenador_acessibilidade', 41)->andReturnSelf();
        $respostas->shouldReceive('orderBy')->once()->with('id_coordenador_resposta')->andReturnSelf();
        $respostas->shouldReceive('pluck')->once()->with('id_coordenador_resposta')->andReturn(collect());
        DB::shouldReceive('table')->once()->with('cad_coordenador_resposta')->andReturn($respostas);
        $cadastroInativo = Mockery::mock();
        $cadastroInativo->shouldReceive('whereRaw')->once()->andReturnSelf();
        $cadastroInativo->shouldReceive('where')->once()->with('ativo', 0)->andReturnSelf();
        $cadastroInativo->shouldReceive('whereNotExists')->once()->andReturnSelf();
        $cadastroInativo->shouldReceive('first')->once()->with(['id_coordenador_acessibilidade'])->andReturnNull();
        DB::shouldReceive('table')
            ->once()
            ->with('cad_coordenador_acessibilidade')
            ->andReturn($cadastroInativo);

        $repository = new class(Mockery::mock(AuditLogService::class)) extends CoordenadorAcessibilidadeRepository {
            public array $operacoes = [];

            protected function inserirAuditado(string $tabela, string $entidade, array $dados, string $colunaId = 'ID', ?string $sequencia = null): int
            {
                $this->operacoes[] = ['INSERT', $tabela, $entidade, $colunaId, $sequencia, $dados];
                return 41;
            }

            protected function atualizarAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id, array $dados): int
            {
                $this->operacoes[] = ['UPDATE', $tabela, $entidade, $colunaId, $id, $dados];
                return 1;
            }

            protected function removerAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id): int
            {
                $this->operacoes[] = ['DELETE', $tabela, $entidade, $colunaId, $id];
                return 1;
            }

            protected function salvarRespostasQuestionario(int $idCoordenador, array $dados): void
            {
            }
        };

        $id = $repository->criar($this->dadosCoordenador());
        $atualizados = $repository->atualizar(41, $this->dadosCoordenador());
        $removidos = $repository->remover(41);

        $this->assertSame(41, $id);
        $this->assertSame(1, $atualizados);
        $this->assertSame(1, $removidos);
        $this->assertSame(['INSERT', 'UPDATE', 'DELETE'], array_column($repository->operacoes, 0));
        $this->assertSame('CAD_COORDENADOR_ACESSIBILIDADE', $repository->operacoes[0][2]);
    }

    #[Test]
    public function exclusao_de_coordenador_audita_respostas_antes_do_cadastro(): void
    {
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());
        $respostas = Mockery::mock();
        $respostas->shouldReceive('where')->once()->with('id_coordenador_acessibilidade', 63)->andReturnSelf();
        $respostas->shouldReceive('orderBy')->once()->with('id_coordenador_resposta')->andReturnSelf();
        $respostas->shouldReceive('pluck')->once()->with('id_coordenador_resposta')->andReturn(collect([11, 12]));
        DB::shouldReceive('table')->once()->with('cad_coordenador_resposta')->andReturn($respostas);

        $repository = new class(Mockery::mock(AuditLogService::class)) extends CoordenadorAcessibilidadeRepository {
            public array $remocoes = [];

            protected function removerAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id): int
            {
                $this->remocoes[] = [$tabela, $entidade, $colunaId, $id];
                return 1;
            }
        };

        $repository->remover(63);

        $this->assertSame([
            ['cad_coordenador_resposta', 'CAD_COORDENADOR_RESPOSTA', 'id_coordenador_resposta', 11],
            ['cad_coordenador_resposta', 'CAD_COORDENADOR_RESPOSTA', 'id_coordenador_resposta', 12],
            ['cad_coordenador_acessibilidade', 'CAD_COORDENADOR_ACESSIBILIDADE', 'id_coordenador_acessibilidade', 63],
        ], $repository->remocoes);
    }

    #[Test]
    public function questionario_de_coordenador_audita_update_e_insert(): void
    {
        $perguntas = Mockery::mock();
        $perguntas->shouldReceive('where')->once()->with('ativa', 'S')->andReturnSelf();
        $perguntas->shouldReceive('orderBy')->once()->with('ordem')->andReturnSelf();
        $perguntas->shouldReceive('get')->once()->with(['id_supervisor_pergunta', 'codigo'])->andReturn(collect([
            (object) ['id_supervisor_pergunta' => 1, 'codigo' => 'autoriza_whatsapp'],
            (object) ['id_supervisor_pergunta' => 2, 'codigo' => 'aceite_lgpd'],
        ]));
        DB::shouldReceive('table')->once()->with('cad_supervisor_pergunta')->andReturn($perguntas);

        $respostaExistente = Mockery::mock();
        $respostaExistente->shouldReceive('where')->once()->with('id_coordenador_acessibilidade', 63)->andReturnSelf();
        $respostaExistente->shouldReceive('where')->once()->with('id_supervisor_pergunta', 1)->andReturnSelf();
        $respostaExistente->shouldReceive('first')->once()->with(['id_coordenador_resposta'])->andReturn((object) [
            'id_coordenador_resposta' => 11,
        ]);
        $respostaNova = Mockery::mock();
        $respostaNova->shouldReceive('where')->once()->with('id_coordenador_acessibilidade', 63)->andReturnSelf();
        $respostaNova->shouldReceive('where')->once()->with('id_supervisor_pergunta', 2)->andReturnSelf();
        $respostaNova->shouldReceive('first')->once()->with(['id_coordenador_resposta'])->andReturnNull();
        DB::shouldReceive('table')->twice()->with('cad_coordenador_resposta')->andReturn($respostaExistente, $respostaNova);

        $repository = new class(Mockery::mock(AuditLogService::class)) extends CoordenadorAcessibilidadeRepository {
            public array $operacoes = [];

            public function salvarRespostas(int $idCoordenador, array $dados): void
            {
                $this->salvarRespostasQuestionario($idCoordenador, $dados);
            }

            protected function inserirAuditado(string $tabela, string $entidade, array $dados, string $colunaId = 'ID', ?string $sequencia = null): int
            {
                $this->operacoes[] = ['INSERT', $tabela, $entidade, $dados['valor_resposta']];
                return 12;
            }

            protected function atualizarAuditadoPorId(string $tabela, string $entidade, string $colunaId, mixed $id, array $dados): int
            {
                $this->operacoes[] = ['UPDATE', $tabela, $entidade, $dados['valor_resposta']];
                return 1;
            }
        };

        $repository->salvarRespostas(63, [
            'possui_whatsapp' => true,
            'aceite_lgpd' => false,
        ]);

        $this->assertSame([
            ['UPDATE', 'cad_coordenador_resposta', 'CAD_COORDENADOR_RESPOSTA', 'SIM'],
            ['INSERT', 'cad_coordenador_resposta', 'CAD_COORDENADOR_RESPOSTA', 'NAO'],
        ], $repository->operacoes);
    }

    private function dadosCoordenador(): array
    {
        return [
            'nome_coordenador' => 'Maria da Silva',
            'cpf_coordenador' => '52998224725',
            'num_inscricao' => '000123456789',
            'cod_objeto_local_votacao' => '100',
            'email' => 'maria@example.com',
            'telefone' => '68999998888',
            'possui_whatsapp' => true,
            'nome_social' => null,
            'profissao' => 'Analista de sistemas',
            'data_nasc' => '1990-05-20',
            'tamanho_camisa' => 'M',
            'endereco_completo' => 'Rua das Flores, 100',
            'experiencias_anteriores' => 'Mesário',
            'nivel_conhecimento_informatica' => 'AVANCADO',
            'nivel_escolaridade' => 'SUPERIOR_COMPLETO',
            'pix_cpf' => '52998224725',
            'codigo_banco' => '001',
            'agencia' => '1234',
            'conta' => '56789-0',
            'tipo_conta' => 'C',
            'autoriza_email' => true,
            'disponibilidade_ead' => true,
            'aceite_lgpd' => true,
            'ip_resposta' => '127.0.0.1',
            'user_agent' => 'PHPUnit',
        ];
    }
}
```
</TESTS_UNIT_COORDENADORACESSIBILIDADEAUDITADMLTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EventoVoluntarioPublicoServiceTest.php`
## <TESTS_UNIT_EVENTOVOLUNTARIOPUBLICOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EventoVoluntarioPublicoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EventoVoluntarioPublicoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function normaliza_titulo_ordena_ocorrencias_e_formata_uma_agenda_por_card(): void
public function titulo_invalido_retorna_vazio_sem_consultar_persistencia(): void
public function preserva_primeiro_nome_unicode_e_anonimiza_as_demais_palavras(): void
public function mescla_eventos_e_turmas_elo_em_ordem_cronologica_com_nome_eleitoral_prioritario(): void
public function usa_nome_do_elo_como_fallback_e_ignora_turma_com_periodo_invalido(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\Contracts\EventoVoluntarioRepositoryInterface;
use App\Repositories\Treinamentos\Contracts\TreinamentoTsePublicoRepositoryInterface;
use App\Services\ColaboradoresEleitorais\EventoVoluntarioPublicoService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class EventoVoluntarioPublicoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function normaliza_titulo_ordena_ocorrencias_e_formata_uma_agenda_por_card(): void
    {
        $repository = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $repository->shouldReceive('listarOcorrenciasPublicasPorTitulo')
            ->once()
            ->with('000123456789')
            ->andReturn([
                [
                    'nome_eleitor' => '  Maria   da Silva  ',
                    'macroprojeto' => 'Eleições 2026',
                    'acao' => 'Suporte Técnico',
                    'evento' => 'Montagem das urnas',
                    'local' => 'Local de votação',
                    'inicio' => '2026-10-03T13:00',
                    'fim' => '2026-10-04T18:30',
                ],
                [
                    'nome_eleitor' => '  Maria   da Silva  ',
                    'macroprojeto' => 'Eleições 2026',
                    'acao' => 'Suporte Técnico',
                    'evento' => 'Capacitação',
                    'local' => 'Plenário',
                    'inicio' => '2026-10-02T10:00',
                    'fim' => '2026-10-02T12:00',
                ],
                [
                    'nome_eleitor' => '  Maria   da Silva  ',
                    'macroprojeto' => 'Eleições 2026',
                    'acao' => 'Suporte Técnico',
                    'evento' => 'Capacitação',
                    'local' => 'Plenário',
                    'inicio' => '2026-10-02T08:00',
                    'fim' => '2026-10-02T10:00',
                ],
            ]);

        $treinamentos = Mockery::mock(TreinamentoTsePublicoRepositoryInterface::class);
        $treinamentos->shouldReceive('listarOcorrenciasPublicasPorTitulo')
            ->once()
            ->with('000123456789')
            ->andReturn([]);

        $resultado = (new EventoVoluntarioPublicoService($repository, $treinamentos))
            ->consultar('123.456.789');
        $cards = $resultado['ocorrencias'];

        $this->assertSame('Maria D*** S***', $resultado['nome_anonimizado']);
        $this->assertStringNotContainsString('Maria da Silva', json_encode($resultado, JSON_THROW_ON_ERROR));
        $this->assertCount(3, $cards);
        $this->assertSame([
            '2026-10-02T08:00',
            '2026-10-02T10:00',
            '2026-10-03T13:00',
        ], array_column($cards, 'inicio_iso'));
        $this->assertSame(['Capacitação', 'Capacitação', 'Montagem das urnas'], array_column($cards, 'evento'));
        $this->assertSame('02', $cards[0]['dia']);
        $this->assertSame('OUT', $cards[0]['mes']);
        $this->assertSame('2026', $cards[0]['ano']);
        $this->assertSame('02/10/2026, das 08:00 às 10:00', $cards[0]['periodo']);
        $this->assertSame(
            '03/10/2026 às 13:00 até 04/10/2026 às 18:30',
            $cards[2]['periodo']
        );
        $this->assertSame([
            'macroprojeto',
            'acao',
            'evento',
            'local',
            'modalidade',
            'endereco',
            'sala',
            'inicio_iso',
            'fim_iso',
            'dia',
            'mes',
            'ano',
            'periodo',
        ], array_keys($cards[0]));
    }

    #[Test]
    public function titulo_invalido_retorna_vazio_sem_consultar_persistencia(): void
    {
        $repository = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $repository->shouldNotReceive('listarOcorrenciasPublicasPorTitulo');
        $treinamentos = Mockery::mock(TreinamentoTsePublicoRepositoryInterface::class);
        $treinamentos->shouldNotReceive('listarOcorrenciasPublicasPorTitulo');

        $this->assertSame(
            ['nome_anonimizado' => null, 'ocorrencias' => []],
            (new EventoVoluntarioPublicoService($repository, $treinamentos))
                ->consultar('titulo-invalido')
        );
    }

    #[Test]
    public function preserva_primeiro_nome_unicode_e_anonimiza_as_demais_palavras(): void
    {
        $repository = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $repository->shouldReceive('listarOcorrenciasPublicasPorTitulo')->once()->andReturn([[
            'nome_eleitor' => '  álvares   de Sá  ',
            'macroprojeto' => 'Eleições 2026',
            'acao' => 'Suporte Técnico',
            'evento' => 'Capacitação',
            'local' => 'Plenário',
            'inicio' => '2026-10-02T08:00',
            'fim' => '2026-10-02T10:00',
        ]]);

        $treinamentos = Mockery::mock(TreinamentoTsePublicoRepositoryInterface::class);
        $treinamentos->shouldReceive('listarOcorrenciasPublicasPorTitulo')->once()->andReturn([]);

        $resultado = (new EventoVoluntarioPublicoService($repository, $treinamentos))
            ->consultar('123456789012');

        $this->assertSame('Álvares D*** S***', $resultado['nome_anonimizado']);
    }

    #[Test]
    public function mescla_eventos_e_turmas_elo_em_ordem_cronologica_com_nome_eleitoral_prioritario(): void
    {
        $eventos = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $eventos->shouldReceive('listarOcorrenciasPublicasPorTitulo')->once()->andReturn([[
            'nome_eleitor' => 'Maria da Silva',
            'macroprojeto' => 'Eleições 2026',
            'acao' => 'Suporte Técnico',
            'evento' => 'Evento intermediário',
            'local' => 'TRE-AC',
            'inicio' => '2026-09-20T10:00',
            'fim' => '2026-09-20T12:00',
        ]]);

        $treinamentos = Mockery::mock(TreinamentoTsePublicoRepositoryInterface::class);
        $treinamentos->shouldReceive('listarOcorrenciasPublicasPorTitulo')->once()->andReturn([
            [
                'nome_eleitor' => 'Joana Souza',
                'macroprojeto' => 'Eleições 2026',
                'acao' => 'Turma do ELO',
                'evento' => 'Turma presencial',
                'local' => 'Cartório Eleitoral',
                'modalidade' => 'Presencial',
                'endereco' => 'Avenida Ceará, 861',
                'sala' => 'Sala 2',
                'inicio' => '2026-08-10T08:00',
                'fim' => '2026-08-10T12:00',
            ],
            [
                'nome_eleitor' => 'Joana Souza',
                'macroprojeto' => 'Eleições 2026',
                'acao' => 'Turma do ELO',
                'evento' => 'Turma virtual',
                'local' => '',
                'modalidade' => 'Virtual',
                'endereco' => '',
                'sala' => '',
                'inicio' => '2026-10-10T14:00',
                'fim' => '2026-10-10T16:00',
            ],
        ]);

        $resultado = (new EventoVoluntarioPublicoService($eventos, $treinamentos))
            ->consultar('123456789012');

        $this->assertSame('Maria D*** S***', $resultado['nome_anonimizado']);
        $this->assertSame([
            'Turma presencial',
            'Evento intermediário',
            'Turma virtual',
        ], array_column($resultado['ocorrencias'], 'evento'));
        $this->assertSame('Presencial', $resultado['ocorrencias'][0]['modalidade']);
        $this->assertSame('Avenida Ceará, 861', $resultado['ocorrencias'][0]['endereco']);
        $this->assertSame('Sala 2', $resultado['ocorrencias'][0]['sala']);
        $this->assertSame('Local a confirmar', $resultado['ocorrencias'][2]['local']);
        $this->assertNull($resultado['ocorrencias'][2]['endereco']);
        $this->assertNull($resultado['ocorrencias'][2]['sala']);
    }

    #[Test]
    public function usa_nome_do_elo_como_fallback_e_ignora_turma_com_periodo_invalido(): void
    {
        $eventos = Mockery::mock(EventoVoluntarioRepositoryInterface::class);
        $eventos->shouldReceive('listarOcorrenciasPublicasPorTitulo')->once()->andReturn([]);

        $treinamentos = Mockery::mock(TreinamentoTsePublicoRepositoryInterface::class);
        $treinamentos->shouldReceive('listarOcorrenciasPublicasPorTitulo')->once()->andReturn([
            [
                'nome_eleitor' => 'Álvares de Sá',
                'macroprojeto' => 'Eleições 2026',
                'acao' => 'Turma do ELO',
                'evento' => 'Turma válida',
                'local' => 'Moodle',
                'modalidade' => 'EAD(Moodle)',
                'endereco' => '',
                'sala' => '',
                'inicio' => '2026-09-11T08:00',
                'fim' => '2026-09-11T12:00',
            ],
            [
                'nome_eleitor' => 'Nome indevido',
                'macroprojeto' => 'Eleições 2026',
                'acao' => 'Turma do ELO',
                'evento' => 'Turma inválida',
                'local' => 'Moodle',
                'modalidade' => 'EAD(Moodle)',
                'endereco' => '',
                'sala' => '',
                'inicio' => '2026-09-12T12:00',
                'fim' => '2026-09-12T08:00',
            ],
        ]);

        $resultado = (new EventoVoluntarioPublicoService($eventos, $treinamentos))
            ->consultar('123456789012');

        $this->assertSame('Álvares D*** S***', $resultado['nome_anonimizado']);
        $this->assertSame(['Turma válida'], array_column($resultado['ocorrencias'], 'evento'));
        $this->assertSame('EAD(Moodle)', $resultado['ocorrencias'][0]['modalidade']);
    }
}
```
</TESTS_UNIT_EVENTOVOLUNTARIOPUBLICOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EventoVoluntarioPublicoUiTest.php`
## <TESTS_UNIT_EVENTOVOLUNTARIOPUBLICOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EventoVoluntarioPublicoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EventoVoluntarioPublicoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function view_preserva_semantica_e_recursos_de_acessibilidade(): void
public function css_define_layouts_de_desktop_e_celular_sem_rolagem_horizontal_obrigatoria(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class EventoVoluntarioPublicoUiTest extends TestCase
{
    #[Test]
    public function view_preserva_semantica_e_recursos_de_acessibilidade(): void
    {
        $view = file_get_contents(
            dirname(__DIR__, 2).'/resources/views/colaboradores-eleitorais/eventos-publicos/index.blade.php'
        );
        $layout = file_get_contents(
            dirname(__DIR__, 2).'/resources/views/layouts/eventos-eleitor-publico.blade.php'
        );

        $this->assertIsString($view);
        $this->assertIsString($layout);
        $this->assertStringContainsString('<label for="num_inscricao"', $view);
        $this->assertStringContainsString('aria-describedby=', $view);
        $this->assertStringContainsString('<ol class="eventos-lista"', $view);
        $this->assertStringContainsString('resultado-identidade', $view);
        $this->assertStringContainsString('$nomeAnonimizado', $view);
        $this->assertStringContainsString('<article class="evento-card">', $view);
        $this->assertStringContainsString('<time datetime=', $view);
        $this->assertStringContainsString('$ocorrencia[\'modalidade\']', $view);
        $this->assertStringContainsString('$ocorrencia[\'endereco\']', $view);
        $this->assertStringContainsString('$ocorrencia[\'sala\']', $view);
        $this->assertStringContainsString('eventos e treinamentos', $view);
        $this->assertStringContainsString('class="visually-hidden"', $view);
        $this->assertStringContainsString('alt="Eleições 2026, Tribunal Regional Eleitoral do Acre"', $layout);
        $this->assertStringNotContainsString('<script', $layout);
        $this->assertStringNotContainsString('<style', $layout);
    }

    #[Test]
    public function css_define_layouts_de_desktop_e_celular_sem_rolagem_horizontal_obrigatoria(): void
    {
        $css = file_get_contents(
            dirname(__DIR__, 2).'/public/rotas-publicas/css/meus-eventos.css'
        );

        $this->assertIsString($css);
        $this->assertStringContainsString('grid-template-columns: minmax(0, 1.25fr) minmax(300px, .75fr)', $css);
        $this->assertStringContainsString('@media (max-width: 767.98px)', $css);
        $this->assertStringContainsString('@media (max-width: 380px)', $css);
        $this->assertStringContainsString('grid-template-columns: 1fr', $css);
        $this->assertStringContainsString('overflow-wrap: anywhere', $css);
        $this->assertStringContainsString('.evento-detalhe', $css);
        $this->assertStringContainsString(':focus-visible', $css);
        $this->assertStringContainsString('@media (prefers-reduced-motion: reduce)', $css);
        $this->assertStringNotContainsString('overflow-x: scroll', $css);
        $this->assertStringNotContainsString('min-width: 980px', $css);
    }
}
```
</TESTS_UNIT_EVENTOVOLUNTARIOPUBLICOUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/EventoVoluntarioRepositoryPublicoTest.php`
## <TESTS_UNIT_EVENTOVOLUNTARIOREPOSITORYPUBLICOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/EventoVoluntarioRepositoryPublicoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class EventoVoluntarioRepositoryPublicoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function consulta_publica_filtra_dominio_ativo_e_retorna_nome_eleitoral_para_anonimizacao(): void
public function titulo_invalido_nao_acessa_o_banco(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\ColaboradoresEleitorais\EventoVoluntarioRepository;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Contracts\Database\Query\Expression;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class EventoVoluntarioRepositoryPublicoTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function consulta_publica_filtra_dominio_ativo_e_retorna_nome_eleitoral_para_anonimizacao(): void
    {
        $query = Mockery::mock();
        $query->shouldReceive('join')->times(6)->andReturnSelf();
        $query->shouldReceive('leftJoin')
            ->once()
            ->with(
                'planeleito.vw_eleitor_secao_zona_localidade as ELEITOR',
                Mockery::type(\Closure::class)
            )
            ->andReturnSelf();
        $query->shouldReceive('selectRaw')
            ->once()
            ->withArgs(function (string $sql): bool {
                $sql = mb_strtoupper($sql, 'UTF-8');
                $this->assertStringContainsString('ELEITOR.NOM_ELEITOR AS NOME_ELEITOR', $sql);
                $this->assertStringNotContainsString('ATIVIDADE', $sql);
                $this->assertStringNotContainsString('ZONA_TRABALHO', $sql);
                $this->assertStringNotContainsString('COUNT(', $sql);

                return true;
            })
            ->andReturnSelf();
        $query->shouldReceive('whereIn')
            ->once()
            ->with(Mockery::type(Expression::class), [
                '000123456789',
                '00123456789',
                '0123456789',
                '123456789',
            ])
            ->andReturnSelf();
        $query->shouldReceive('whereRaw')
            ->once()
            ->with("TRIM(NVL(EV.STATUS_CODIGO, 'ATIVO')) = 'ATIVO'")
            ->andReturnSelf();
        $query->shouldReceive('where')->once()->with('PE.ATIVO', 1)->andReturnSelf();
        $query->shouldReceive('where')->once()->with('M.ATIVO', 'S')->andReturnSelf();
        $query->shouldReceive('whereRaw')
            ->once()
            ->with("UPPER(TRIM(M.TIPO)) = 'ELEICAO'")
            ->andReturnSelf();
        $query->shouldReceive('orderBy')->once()->with('EA.DT_INICIO')->andReturnSelf();
        $query->shouldReceive('orderBy')->once()->with('EA.DT_FIM')->andReturnSelf();
        $query->shouldReceive('orderByRaw')->once()->with('UPPER(PE.NOME)')->andReturnSelf();
        $query->shouldReceive('orderByRaw')->once()->with('UPPER(EV.NOME)')->andReturnSelf();
        $query->shouldReceive('orderBy')->once()->with('EA.ID')->andReturnSelf();
        $query->shouldReceive('get')->once()->andReturn(collect([
            (object) [
                'nome_eleitor' => 'Maria da Silva',
                'macroprojeto' => 'Eleições 2026',
                'acao' => 'Suporte Técnico',
                'evento' => 'Capacitação',
                'local' => 'Plenário',
                'inicio' => '2026-09-28T14:00',
                'fim' => '2026-09-28T18:00',
            ],
            (object) [
                'nome_eleitor' => 'Maria da Silva',
                'macroprojeto' => 'Eleições 2026',
                'acao' => 'Suporte Técnico',
                'evento' => 'Capacitação',
                'local' => 'Plenário',
                'inicio' => '2026-09-29T08:00',
                'fim' => '2026-09-29T12:00',
            ],
        ]));

        DB::shouldReceive('raw')
            ->once()
            ->with('TRIM(EVP.NUM_INSCRICAO)')
            ->andReturn(Mockery::mock(Expression::class));
        DB::shouldReceive('table')
            ->once()
            ->with('CE_EVENTO_VOLUNTARIO_PARTICIPANTE as EVP')
            ->andReturn($query);

        $resultado = (new EventoVoluntarioRepository(Mockery::mock(AuditLogService::class)))
            ->listarOcorrenciasPublicasPorTitulo('123.456.789');

        $this->assertCount(2, $resultado);
        $this->assertSame([
            'nome_eleitor',
            'macroprojeto',
            'acao',
            'evento',
            'local',
            'inicio',
            'fim',
        ], array_keys($resultado[0]));
        $this->assertSame('Maria da Silva', $resultado[0]['nome_eleitor']);
        $this->assertSame('2026-09-29T08:00', $resultado[1]['inicio']);
    }

    #[Test]
    public function titulo_invalido_nao_acessa_o_banco(): void
    {
        DB::shouldReceive('table')->never();

        $resultado = (new EventoVoluntarioRepository(Mockery::mock(AuditLogService::class)))
            ->listarOcorrenciasPublicasPorTitulo('invalido');

        $this->assertSame([], $resultado);
    }
}
```
</TESTS_UNIT_EVENTOVOLUNTARIOREPOSITORYPUBLICOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/GelSyncCommandTest.php`
## <TESTS_UNIT_GELSYNCCOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/GelSyncCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GelSyncCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_comando_repopular_tempo_deslocamento_gel_executa_dry_run(): void
public function test_comando_sync_gel_ac_registra_sucesso_e_imprime_etapas(): void
public function test_comando_sync_gel_ac_registra_erro_e_retorna_falha(): void
public function __construct(array $resultado, private ?Throwable $erro = null)
public function sincronizarAcCompleto(?string $syncRunId = null): array
public function registrarSucesso(string $rotina, array $resultado = [], array $meta = []): void
public function registrarErro(string $rotina, Throwable|string $erro, array $meta = []): void
public function __construct(private array $resultado)
public function repopular(bool $dryRun = false): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Gel\GelSyncService;
use App\Services\Gel\GelTempoDeslocamentoService;
use App\Services\LocaisVotacao\LocalVotacaoSyncStatusService;
use RuntimeException;
use Tests\TestCase;
use Throwable;

class GelSyncCommandTest extends TestCase
{

    public function test_comando_repopular_tempo_deslocamento_gel_executa_dry_run(): void
    {
        $resultado = [
            'dry_run' => true,
            'candidatos' => 3,
            'analisados' => 2,
            'inseridos' => 0,
            'por_classificacao' => [
                'ATE_1H' => 1,
                'MAIS_1H' => 1,
                'SEM_INFO_APROVEITAVEL' => 0,
            ],
            'por_fonte' => [
                'PRINCIPAL' => 1,
                'FALLBACK' => 1,
            ],
        ];

        $service = new GelTempoDeslocamentoServiceFake($resultado);
        $this->app->instance(GelTempoDeslocamentoService::class, $service);

        $this->artisan('sync:gel:tempo-deslocamento --dry-run')
            ->expectsOutput('Simulacao de repopulacao de tempo de deslocamento GEL concluida.')
            ->assertExitCode(0);

        $this->assertSame(1, $service->chamadas);
        $this->assertTrue($service->dryRunRecebido);
    }

    public function test_comando_sync_gel_ac_registra_sucesso_e_imprime_etapas(): void
    {
        $resultado = [
            'dblink' => 'cad_tse',
            'sync_run_id' => 'RUN-001',
            'origem_total' => 2,
            'destino_total' => 2,
            'etapas' => [
                'formulario' => ['dblink' => 'cad_tse', 'origem_total' => 1, 'destino_total' => 1],
                'categoria' => ['dblink' => 'cad_tse', 'origem_total' => 1, 'destino_total' => 1],
            ],
        ];

        $service = new GelSyncServiceFake($resultado);
        $status = new LocalVotacaoSyncStatusServiceFake();

        $this->app->instance(GelSyncService::class, $service);
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->artisan('sync:gel:ac')
            ->expectsOutput('Iniciando sincronização GEL AC...')
            ->expectsOutput('Sincronização GEL AC concluída com sucesso.')
            ->assertExitCode(0);

        $this->assertSame(1, $service->chamadas);
        $this->assertCount(1, $status->sucessos);
        $this->assertCount(0, $status->erros);
        $this->assertSame('sync:gel:ac', $status->sucessos[0]['rotina']);
        $this->assertSame($resultado, $status->sucessos[0]['resultado']);
        $this->assertSame('gel_ac', $status->sucessos[0]['meta']['etapa'] ?? null);
        $this->assertSame('artisan', $status->sucessos[0]['meta']['origem'] ?? null);
    }

    public function test_comando_sync_gel_ac_registra_erro_e_retorna_falha(): void
    {
        $erro = new RuntimeException('Falha remota');
        $service = new GelSyncServiceFake([], $erro);
        $status = new LocalVotacaoSyncStatusServiceFake();

        $this->app->instance(GelSyncService::class, $service);
        $this->app->instance(LocalVotacaoSyncStatusService::class, $status);

        $this->artisan('sync:gel:ac')
            ->expectsOutput('Iniciando sincronização GEL AC...')
            ->expectsOutput('Erro na sincronização GEL AC: Falha remota')
            ->assertExitCode(1);

        $this->assertSame(1, $service->chamadas);
        $this->assertCount(0, $status->sucessos);
        $this->assertCount(1, $status->erros);
        $this->assertSame('sync:gel:ac', $status->erros[0]['rotina']);
        $this->assertSame($erro, $status->erros[0]['erro']);
        $this->assertSame('gel_ac', $status->erros[0]['meta']['etapa'] ?? null);
        $this->assertSame('artisan', $status->erros[0]['meta']['origem'] ?? null);
    }
}

class GelSyncServiceFake extends GelSyncService
{
    public int $chamadas = 0;

    /** @var array<string, mixed> */
    private array $resultado;

    public function __construct(array $resultado, private ?Throwable $erro = null)
    {
        $this->resultado = $resultado;
    }

    public function sincronizarAcCompleto(?string $syncRunId = null): array
    {
        $this->chamadas++;

        if ($this->erro !== null) {
            throw $this->erro;
        }

        return $this->resultado;
    }
}

class LocalVotacaoSyncStatusServiceFake extends LocalVotacaoSyncStatusService
{
    /** @var list<array{rotina:string,resultado:array<string, mixed>,meta:array<string, mixed>}> */
    public array $sucessos = [];

    /** @var list<array{rotina:string,erro:Throwable|string,meta:array<string, mixed>}> */
    public array $erros = [];

    public function registrarSucesso(string $rotina, array $resultado = [], array $meta = []): void
    {
        $this->sucessos[] = [
            'rotina' => $rotina,
            'resultado' => $resultado,
            'meta' => $meta,
        ];
    }

    public function registrarErro(string $rotina, Throwable|string $erro, array $meta = []): void
    {
        $this->erros[] = [
            'rotina' => $rotina,
            'erro' => $erro,
            'meta' => $meta,
        ];
    }
}
class GelTempoDeslocamentoServiceFake extends GelTempoDeslocamentoService
{
    public int $chamadas = 0;
    public bool $dryRunRecebido = false;

    /** @param array<string, mixed> $resultado */
    public function __construct(private array $resultado)
    {
    }

    public function repopular(bool $dryRun = false): array
    {
        $this->chamadas++;
        $this->dryRunRecebido = $dryRun;

        return $this->resultado;
    }
}
```
</TESTS_UNIT_GELSYNCCOMMANDTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/GelSyncServiceTest.php`
## <TESTS_UNIT_GELSYNCSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/GelSyncServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GelSyncServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_configuracao_gel_define_recorte_ac_padrao(): void
public function test_sqls_de_carga_preservam_filtros_ac_e_nao_copiam_segredos(): void
public function test_ordem_de_truncate_e_carga_respeita_dependencias(): void
public function test_sql_da_view_consolida_respostas_e_local_votacao_local(): void
public function test_sincronizacao_rejeita_dblink_invalido_antes_de_dml(): void
public function test_sincronizar_ac_trunca_em_ordem_reversa_e_carrega_em_ordem_de_dependencia(): void
public function count(): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Gel\GelSyncService;
use Illuminate\Support\Facades\DB;
use Mockery;
use RuntimeException;
use Tests\TestCase;

class GelSyncServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_configuracao_gel_define_recorte_ac_padrao(): void
    {
        $configFile = (string) file_get_contents(config_path('planeleito.php'));

        $this->assertSame('cad_tse', config('planeleito.sync.gel_dblink'));
        $this->assertSame('AC', config('planeleito.sync.gel_uf'));
        $this->assertSame(24, config('planeleito.sync.gel_cd_uf'));
        $this->assertStringContainsString("'gel_dblink' => env('PLANELEITO_SYNC_GEL_DBLINK', 'cad_tse')", $configFile);
        $this->assertStringContainsString("'gel_uf' => env('PLANELEITO_SYNC_GEL_UF', 'AC')", $configFile);
        $this->assertStringContainsString("'gel_cd_uf' => (int) env('PLANELEITO_SYNC_GEL_CD_UF', 24)", $configFile);
    }

    public function test_sqls_de_carga_preservam_filtros_ac_e_nao_copiam_segredos(): void
    {
        config([
            'planeleito.sync.gel_uf' => 'AC',
            'planeleito.sync.gel_cd_uf' => 24,
        ]);

        $service = new GelSyncService();
        $todosSqls = [];

        foreach ($service->etapasCarga() as $etapa => $definicao) {
            $sql = $service->montarSqlInsercao($etapa, 'cad_tse', 'RUN-001');
            $todosSqls[] = $sql;

            $this->assertStringContainsString('INSERT INTO planeleito.' . $definicao['table'], $sql);
            $this->assertStringContainsString('@cad_tse', $sql);
            $this->assertStringContainsString('RUN-001', $sql);
        }

        $sqlUnificado = implode("\n", $todosSqls);

        $this->assertStringContainsString('f.cd_uf = 24', $sqlUnificado);
        $this->assertStringContainsString("d.txt_uf = 'AC'", $sqlUnificado);
        $this->assertStringContainsString('JOIN ADMGEL.dispositivo_cadastrado@cad_tse d', $sqlUnificado);
        $this->assertStringContainsString('JOIN ADMGEL.vistoria@cad_tse v', $sqlUnificado);
        $this->assertStringNotContainsString('CONFIGURACAO', strtoupper($sqlUnificado));
        $this->assertStringNotContainsString('TXT_TOKEN', strtoupper($sqlUnificado));
        $this->assertStringNotContainsString('COD_MAC', strtoupper($sqlUnificado));
        $this->assertStringNotContainsString('TXT_METADADOS_DISPOSITIVO', strtoupper($sqlUnificado));
    }

    public function test_ordem_de_truncate_e_carga_respeita_dependencias(): void
    {
        $service = new GelSyncService();

        $this->assertSame([
            'gel_formulario',
            'gel_categoria',
            'gel_question',
            'gel_question_option',
            'gel_dispositivo_cadastrado',
            'gel_dispositivo_zona',
            'gel_vistoria',
            'gel_categoria_vistoria',
            'gel_question_vistoria',
            'gel_question_option_vistoria',
            'gel_question_vistoria_valor',
            'gel_vistoria_imagem',
        ], $service->tabelasEmOrdemCarga());

        $this->assertSame(array_reverse($service->tabelasEmOrdemCarga()), $service->tabelasEmOrdemTruncate());
    }

    public function test_sql_da_view_consolida_respostas_e_local_votacao_local(): void
    {
        $sql = (new GelSyncService())->montarSqlViewRespostas();

        $this->assertStringContainsString('CREATE OR REPLACE VIEW vw_gel_respostas_ac AS', $sql);
        $this->assertStringContainsString('FROM gel_question_vistoria_valor qvv', $sql);
        $this->assertStringContainsString('LISTAGG(qvv.vlr', $sql);
        $this->assertStringContainsString('COALESCE(rm.resposta, qv.txt_question_vistoria) AS resposta', $sql);
        $this->assertStringContainsString('LEFT JOIN local_votacao_st lv', $sql);
        $this->assertStringContainsString('lv.cod_objeto AS cod_objeto_local_votacao', $sql);
        $this->assertStringContainsString("'AC' AS uf", $sql);
    }

    public function test_sincronizacao_rejeita_dblink_invalido_antes_de_dml(): void
    {
        config(['planeleito.sync.gel_dblink' => 'cad_tse;drop']);

        DB::shouldReceive('statement')->never();
        DB::shouldReceive('selectOne')->never();

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('DBLINK invalido para sincronizacao GEL.');

        (new GelSyncService())->sincronizarAcCompleto();
    }

    public function test_sincronizar_ac_trunca_em_ordem_reversa_e_carrega_em_ordem_de_dependencia(): void
    {
        config([
            'planeleito.sync.gel_dblink' => 'cad_tse',
            'planeleito.sync.gel_uf' => 'AC',
            'planeleito.sync.gel_cd_uf' => 24,
        ]);

        $service = new GelSyncService();
        $ordem = [];

        foreach ($service->tabelasEmOrdemTruncate() as $tabela) {
            DB::shouldReceive('statement')
                ->once()
                ->with('TRUNCATE TABLE planeleito.' . $tabela)
                ->andReturnUsing(function () use (&$ordem, $tabela) {
                    $ordem[] = 'truncate:' . $tabela;
                    return true;
                });
        }

        foreach ($service->etapasCarga() as $etapa => $definicao) {
            DB::shouldReceive('statement')
                ->once()
                ->with(Mockery::on(function (string $sql) use ($definicao): bool {
                    return str_contains($sql, 'INSERT INTO planeleito.' . $definicao['table'])
                        && str_contains($sql, '@cad_tse')
                        && !str_contains(strtoupper($sql), 'TXT_TOKEN')
                        && !str_contains(strtoupper($sql), 'COD_MAC')
                        && !str_contains(strtoupper($sql), 'TXT_METADADOS_DISPOSITIVO');
                }))
                ->andReturnUsing(function () use (&$ordem, $etapa) {
                    $ordem[] = 'insert:' . $etapa;
                    return true;
                });

            DB::shouldReceive('selectOne')
                ->once()
                ->with(Mockery::on(fn (string $sql): bool => str_contains($sql, '@cad_tse')))
                ->andReturn((object) ['total' => 1]);

            DB::shouldReceive('table')
                ->once()
                ->with('planeleito.' . $definicao['table'])
                ->andReturn(new class {
                    public function count(): int
                    {
                        return 1;
                    }
                });
        }

        $resultado = $service->sincronizarAcCompleto('RUN-TESTE');

        $this->assertSame('truncate:gel_vistoria_imagem', $ordem[0]);
        $this->assertSame('truncate:gel_formulario', $ordem[11]);
        $this->assertSame('insert:formulario', $ordem[12]);
        $this->assertSame('insert:vistoria_imagem', $ordem[array_key_last($ordem)]);
        $this->assertSame('RUN-TESTE', $resultado['sync_run_id']);
        $this->assertSame(12, count($resultado['etapas']));
        $this->assertSame(12, $resultado['origem_total']);
        $this->assertSame(12, $resultado['destino_total']);
    }
}
```
</TESTS_UNIT_GELSYNCSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/GelSyncWebContractTest.php`
## <TESTS_UNIT_GELSYNCWEBCONTRACTTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/GelSyncWebContractTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class GelSyncWebContractTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_tela_de_sincronizacao_expoe_execucao_gel_ac(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class GelSyncWebContractTest extends TestCase
{
    public function test_tela_de_sincronizacao_expoe_execucao_gel_ac(): void
    {
        $routes = (string) file_get_contents(base_path('routes/web.php'));
        $view = (string) file_get_contents(resource_path('views/administracao-global/sincronizacao-local-votacao/index.blade.php'));
        $js = (string) file_get_contents(public_path('js/administracao-global/sync-local-votacao.js'));
        $contrato = (string) file_get_contents(base_path('docs/contratos/sincronizacao-gel.md'));

        $this->assertStringContainsString("administracao-global.sync-gel.ac.executar", $routes);
        $this->assertStringContainsString("/sincronizacao/gel/ac/executar", $routes);
        $this->assertStringContainsString('Sincronizar GEL AC', $view);
        $this->assertStringContainsString('btnSincronizarGelAc', $view);
        $this->assertStringContainsString('resultadoSincronizacaoGelAc', $view);
        $this->assertStringContainsString('executarGelAc', $view);
        $this->assertStringContainsString('btnSincronizarGelAc', $js);
        $this->assertStringContainsString('resultadoSincronizacaoGelAc', $js);
        $this->assertStringContainsString('planeleito_admin', mb_strtolower($contrato, 'UTF-8'));
    }
}
```
</TESTS_UNIT_GELSYNCWEBCONTRACTTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LdaRecursosLogisticosAuxiliaresUiTest.php`
## <TESTS_UNIT_LDARECURSOSLOGISTICOSAUXILIARESUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LdaRecursosLogisticosAuxiliaresUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LdaRecursosLogisticosAuxiliaresUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_admin_global_expoe_item_de_recursos_logisticos_em_tabelas_auxiliares(): void
public function index_e_formulario_do_crud_expoem_campos_de_dominio(): void
public function formulario_lda_solicita_e_aplica_contagem_calculada_de_secoes_fisicas(): void
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

class LdaRecursosLogisticosAuxiliaresUiTest extends TestCase
{
    #[Test]
    public function menu_admin_global_expoe_item_de_recursos_logisticos_em_tabelas_auxiliares(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));
        $rotas = file_get_contents(base_path('routes/web.php'));
        $contrato = file_get_contents(base_path('docs/contratos/lda-recursos-logisticos.md'));

        $this->assertIsString($conteudo);
        $this->assertIsString($rotas);
        $this->assertIsString($contrato);
        $this->assertStringContainsString("'label' => 'Recursos logísticos LDA'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.lda-recursos-logisticos.index'", $conteudo);
        $this->assertStringContainsString("'route_patterns' => ['tabelas-auxiliares.lda-recursos-logisticos.*']", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Administração Global > Tabelas Auxiliares > Recursos logísticos LDA'", $conteudo);
        $this->assertStringContainsString('LdaRecursoLogisticoOpcaoController', $rotas);
        $this->assertStringContainsString('planeleito_admin', mb_strtolower($contrato, 'UTF-8'));
    }

    #[Test]
    public function index_e_formulario_do_crud_expoem_campos_de_dominio(): void
    {
        $index = file_get_contents(resource_path('views/tabelas-auxiliares/lda-recursos-logisticos/index.blade.php'));
        $form = file_get_contents(resource_path('views/tabelas-auxiliares/lda-recursos-logisticos/form.blade.php'));

        $this->assertIsString($index);
        $this->assertIsString($form);
        $this->assertStringContainsString('Recursos logísticos LDA', $index);
        $this->assertStringContainsString('Código', $index);
        $this->assertStringContainsString('Ordem', $index);
        $this->assertStringContainsString('Peso unitário kg', $index);
        $this->assertStringContainsString("route('tabelas-auxiliares.lda-recursos-logisticos.form')", $index);
        $this->assertStringContainsString('codigo', $form);
        $this->assertStringContainsString('nome', $form);
        $this->assertStringContainsString('ordem', $form);
        $this->assertStringContainsString('ativo', $form);
        $this->assertStringContainsString('peso_unitario_kg', $form);
        $this->assertStringContainsString('Peso unitário kg', $form);
        $this->assertStringContainsString('opcaoProtegida', $form);
        $this->assertStringContainsString('readonly', $form);
        $this->assertStringContainsString('opcaoProtegida', $index);
    }

    #[Test]
    public function formulario_lda_solicita_e_aplica_contagem_calculada_de_secoes_fisicas(): void
    {
        $form = file_get_contents(resource_path('views/lda/form.blade.php'));

        $this->assertIsString($form);
        $this->assertStringContainsString("finalidade: 'lda'", $form);
        $this->assertStringContainsString('secoes_fisicas', $form);
        $this->assertStringContainsString('recursos-logisticos:urna-secao-atualizada', $form);
    }
}
```
</TESTS_UNIT_LDARECURSOSLOGISTICOSAUXILIARESUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/LdaSituacoesAuxiliaresUiTest.php`
## <TESTS_UNIT_LDASITUACOESAUXILIARESUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/LdaSituacoesAuxiliaresUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class LdaSituacoesAuxiliaresUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function menu_admin_global_expoe_item_de_situacoes_lda_em_tabelas_auxiliares(): void
public function index_e_formulario_do_crud_de_situacoes_lda_expoem_campos_de_dominio(): void
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

class LdaSituacoesAuxiliaresUiTest extends TestCase
{
    #[Test]
    public function menu_admin_global_expoe_item_de_situacoes_lda_em_tabelas_auxiliares(): void
    {
        $conteudo = file_get_contents(config_path('planeleito_menu.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString("'label' => 'Situações LDA'", $conteudo);
        $this->assertStringContainsString("'route' => 'tabelas-auxiliares.lda-situacoes.index'", $conteudo);
        $this->assertStringContainsString("'route_patterns' => ['tabelas-auxiliares.lda-situacoes.*']", $conteudo);
        $this->assertStringContainsString("'menu_path' => 'Administração Global > Tabelas Auxiliares > Situações LDA'", $conteudo);
    }

    #[Test]
    public function index_e_formulario_do_crud_de_situacoes_lda_expoem_campos_de_dominio(): void
    {
        $index = file_get_contents(resource_path('views/tabelas-auxiliares/lda-situacoes/index.blade.php'));
        $form = file_get_contents(resource_path('views/tabelas-auxiliares/lda-situacoes/form.blade.php'));

        $this->assertIsString($index);
        $this->assertIsString($form);

        $this->assertStringContainsString('Situações LDA', $index);
        $this->assertStringContainsString('Código', $index);
        $this->assertStringContainsString('Ordem', $index);
        $this->assertStringContainsString("route('tabelas-auxiliares.lda-situacoes.form')", $index);

        $this->assertStringContainsString('codigo', $form);
        $this->assertStringContainsString('nome', $form);
        $this->assertStringContainsString('descricao', $form);
        $this->assertStringContainsString('ordem', $form);
        $this->assertStringContainsString('ativo', $form);
    }
}
```
</TESTS_UNIT_LDASITUACOESAUXILIARESUITEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RcandRepositoryPartidoTest.php`
## <TESTS_UNIT_RCANDREPOSITORYPARTIDOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RcandRepositoryPartidoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RcandRepositoryPartidoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
DB::table('planeleito.rcand_consolidado_processos')->where('id', 1)->update(['impugnacoes' => 'Sim']);
DB::table('planeleito.rcand_consolidado_processos')->where('id', 2)->update(['impugnacoes' => null]);
DB::table('planeleito.rcand_consolidado_processos')->where('id', 3)->update([
DB::table('planeleito.rcand_consolidado_processos')->where('id', 2)->update([
DB::table('planeleito.rcand_partido')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
public function test_opcoes_deduplicam_numero_entre_eleicoes_e_ignoram_partido_sem_dados(): void
public function test_opcoes_de_impugnacao_sao_binarias_mesmo_sem_ocorrencias_na_carga(): void
public function test_filtro_de_impugnacao_classifica_nulos_legados_apenas_quando_existe_pje(): void
public function test_filtros_e_cards_de_julgamento_refletem_o_indicador_pje_materializado(): void
public function test_drap_com_varios_partidos_nao_duplica_linha_total_ou_grafico(): void
public function test_ausencia_do_filtro_preserva_registros_sem_associacao(): void
public function test_filtro_e_apresentacao_alcancam_cand_pedidos_e_candidatos_candexweb(): void
public function test_totais_das_visoes_cand_respeitam_filtro_sem_multiplicar_partidos(): void
public function test_exportacao_cand_seleciona_a_fonte_da_visao(): void
private function criarTabelas(): void
private function popularCenario(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Rcand\RcandRepository;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class RcandRepositoryPartidoTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        DB::statement("ATTACH DATABASE ':memory:' AS planeleito");
        $this->criarTabelas();
        $this->popularCenario();
    }

    public function test_opcoes_deduplicam_numero_entre_eleicoes_e_ignoram_partido_sem_dados(): void
    {
        $partidos = (new RcandRepository)->opcoes()['partidos'];

        $this->assertSame([
            ['numero' => 10, 'rotulo' => '10 - REP - Republicanos'],
            ['numero' => 20, 'rotulo' => '20 - PODE - Podemos'],
        ], $partidos);
    }

    public function test_opcoes_de_impugnacao_sao_binarias_mesmo_sem_ocorrencias_na_carga(): void
    {
        $this->assertSame(['Sim', 'Não'], (new RcandRepository)->opcoes()['impugnacoes']);
    }

    public function test_filtro_de_impugnacao_classifica_nulos_legados_apenas_quando_existe_pje(): void
    {
        DB::table('planeleito.rcand_consolidado_processos')->where('id', 1)->update(['impugnacoes' => 'Sim']);
        DB::table('planeleito.rcand_consolidado_processos')->where('id', 2)->update(['impugnacoes' => null]);
        DB::table('planeleito.rcand_consolidado_processos')->where('id', 3)->update([
            'impugnacoes' => null,
            'st_existe_pje' => 'Não',
        ]);

        $repository = new RcandRepository;
        $comImpugnacao = $repository->listarPaginado(['impugnacao' => 'Sim'], 'gerencial', 50);
        $semImpugnacao = $repository->listarPaginado(['impugnacao' => 'Não'], 'gerencial', 50);

        $this->assertSame(['0001'], collect($comImpugnacao->items())->pluck('nr_processo')->all());
        $this->assertSame(['0002', '0004'], collect($semImpugnacao->items())->pluck('nr_processo')->all());
    }

    public function test_filtros_e_cards_de_julgamento_refletem_o_indicador_pje_materializado(): void
    {
        DB::table('planeleito.rcand_consolidado_processos')->where('id', 2)->update([
            'julgados_pje_sn' => 'Não',
            'if_cand_x_pje' => 'Diferente',
        ]);

        $repository = new RcandRepository;
        $filtroGeral = $repository->listarPaginado(['julgamento' => 'nao_julgado'], 'gerencial', 50);
        $filtroPje = $repository->listarPaginado(['julgado_pje' => 'Não'], 'gerencial', 50);
        $resumo = $repository->resumo([], 'gerencial');

        $this->assertSame(['0002'], collect($filtroGeral->items())->pluck('nr_processo')->all());
        $this->assertSame(['0002'], collect($filtroPje->items())->pluck('nr_processo')->all());
        $this->assertSame(3, $resumo['julgados']);
        $this->assertSame(1, $resumo['sem_julgamento']);
        $this->assertSame(1, $resumo['divergentes']);
    }

    public function test_drap_com_varios_partidos_nao_duplica_linha_total_ou_grafico(): void
    {
        $repository = new RcandRepository;
        $filtros = ['partido' => '10'];

        $pagina = $repository->listarPaginado($filtros, 'draps', 50);
        $resumo = $repository->resumo($filtros, 'draps');
        $graficos = $repository->graficos($filtros, 'draps');

        $this->assertSame(1, $pagina->total());
        $this->assertCount(1, $pagina->items());
        $this->assertSame(
            "10 - REP - Republicanos\n20 - PODE - Podemos",
            $pagina->items()[0]->partidos
        );
        $this->assertSame(1, $resumo['total']);
        $this->assertSame(1, collect($graficos['julgados'])->sum('total'));
    }

    public function test_ausencia_do_filtro_preserva_registros_sem_associacao(): void
    {
        $repository = new RcandRepository;
        $pagina = $repository->listarPaginado([], 'gerencial', 50);
        $filtrada = $repository->listarPaginado(['partido' => '10'], 'gerencial', 50);

        $this->assertSame(4, $pagina->total());
        $this->assertTrue(collect($pagina->items())->contains(
            static fn ($item): bool => $item->nr_processo_sem_formatacao === '0003'
                && $item->partidos === null
        ));
        $this->assertSame(3, $filtrada->total());
        $this->assertFalse(collect($filtrada->items())->contains(
            static fn ($item): bool => $item->nr_processo_sem_formatacao === '0003'
        ));
    }

    public function test_filtro_e_apresentacao_alcancam_cand_pedidos_e_candidatos_candexweb(): void
    {
        $repository = new RcandRepository;

        $cand = $repository->listarCandPaginado(['partido' => '20'], 50);
        $pedidos = $repository->listarCandexwebPedidosPaginado(['partido' => '20'], 50);
        $candidatos = $repository->listarCandexwebCandidatosPaginado(['partido' => '10'], 50);

        $this->assertSame(1, $cand->total());
        $this->assertSame("10 - REP - Republicanos\n20 - PODE - Podemos", $cand->items()[0]->partidos);
        $this->assertSame(1, $pedidos->total());
        $this->assertSame('20 - PODE - Podemos', $pedidos->items()[0]->partidos);
        $this->assertSame(1, $candidatos->total());
        $this->assertSame('10 - REP - Republicanos', $candidatos->items()[0]->partidos);
    }

    public function test_totais_das_visoes_cand_respeitam_filtro_sem_multiplicar_partidos(): void
    {
        $repository = new RcandRepository;

        $this->assertSame([
            'processos' => 4,
            'comparacao' => 4,
            'pedidos' => 2,
            'candidatos' => 2,
        ], $repository->totaisVisoesCand([]));
        $this->assertSame([
            'processos' => 3,
            'comparacao' => 3,
            'pedidos' => 0,
            'candidatos' => 1,
        ], $repository->totaisVisoesCand(['partido' => '10']));
    }

    public function test_exportacao_cand_seleciona_a_fonte_da_visao(): void
    {
        $repository = new RcandRepository;

        $this->assertSame(4, $repository->listarParaExportacao([], 'cand', 'processos')->count());
        $this->assertSame(4, $repository->listarParaExportacao([], 'cand', 'comparacao')->count());
        $this->assertSame(2, $repository->listarParaExportacao([], 'cand', 'pedidos')->count());
        $this->assertSame(2, $repository->listarParaExportacao([], 'cand', 'candidatos')->count());
        $this->assertSame(101, $repository->listarParaExportacao([], 'cand', 'pedidos')->first()->sq_pedido);
        $this->assertSame('Candidato A', $repository->listarParaExportacao([], 'cand', 'candidatos')->first()->nm_candidato);
    }

    private function criarTabelas(): void
    {
        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_consolidado_processos (
    id INTEGER PRIMARY KEY,
    cd_eleicao INTEGER,
    nm_eleicao TEXT,
    nr_processo TEXT,
    nr_processo_sem_formatacao TEXT,
    tipo_registro TEXT,
    cand_processo TEXT,
    cand_situacao_processo TEXT,
    cand_tipo_processo TEXT,
    if_cand_x_pje TEXT,
    julgados_pje_sn TEXT,
    st_existe_pje TEXT,
    st_existe_cand TEXT,
    st_divergencia TEXT,
    cert_publ_sn TEXT,
    sem_int_mpe TEXT,
    inform_candidato_sn TEXT,
    todas_peticoes_lidas TEXT,
    impugnacoes TEXT,
    data_primeiro_recurso TEXT,
    contrarrazao TEXT,
    remessa_tre TEXT
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_cand_processos (
    id INTEGER PRIMARY KEY,
    cd_eleicao INTEGER,
    nm_eleicao TEXT,
    nr_processo TEXT,
    nr_processo_sem_formatacao TEXT,
    ds_situacao_processo TEXT,
    tp_processo TEXT
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_candexweb_pedidos (
    id INTEGER PRIMARY KEY,
    cd_eleicao INTEGER,
    nm_eleicao TEXT,
    sq_pedido INTEGER,
    sg_ue TEXT,
    nr_processo_drap TEXT,
    st_popula TEXT
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_candexweb_candidatos (
    id INTEGER PRIMARY KEY,
    cd_eleicao INTEGER,
    nm_eleicao TEXT,
    sq_candidato INTEGER,
    sq_pedido INTEGER,
    nr_candidato INTEGER,
    nm_candidato TEXT,
    nm_urna TEXT,
    nr_partido INTEGER
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_partido (
    cd_eleicao INTEGER NOT NULL,
    nr_partido INTEGER NOT NULL,
    sg_partido TEXT NOT NULL,
    nm_partido TEXT NOT NULL,
    PRIMARY KEY (cd_eleicao, nr_partido)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_cand_proc_partido (
    cd_eleicao INTEGER NOT NULL,
    nr_processo_sem_formatacao TEXT NOT NULL,
    nr_partido INTEGER NOT NULL,
    PRIMARY KEY (cd_eleicao, nr_processo_sem_formatacao, nr_partido)
)
SQL);

        DB::statement(<<<'SQL'
CREATE TABLE planeleito.rcand_cw_pedido_partido (
    cd_eleicao INTEGER NOT NULL,
    sq_pedido INTEGER NOT NULL,
    nr_partido INTEGER NOT NULL,
    PRIMARY KEY (cd_eleicao, sq_pedido, nr_partido)
)
SQL);
    }

    private function popularCenario(): void
    {
        DB::table('planeleito.rcand_partido')->insert([
            ['cd_eleicao' => 6257, 'nr_partido' => 10, 'sg_partido' => 'REP', 'nm_partido' => 'Republicanos'],
            ['cd_eleicao' => 6259, 'nr_partido' => 10, 'sg_partido' => 'REP', 'nm_partido' => 'Republicanos'],
            ['cd_eleicao' => 6259, 'nr_partido' => 20, 'sg_partido' => 'PODE', 'nm_partido' => 'Podemos'],
            ['cd_eleicao' => 6259, 'nr_partido' => 30, 'sg_partido' => 'NOVO', 'nm_partido' => 'Novo sem dados'],
        ]);

        DB::table('planeleito.rcand_consolidado_processos')->insert([
            $this->consolidado(1, 6259, '0001', 'DRAP'),
            $this->consolidado(2, 6259, '0002', 'RRC'),
            $this->consolidado(3, 6259, '0003', 'RRC'),
            $this->consolidado(4, 6257, '0004', 'RRC'),
        ]);

        DB::table('planeleito.rcand_cand_processos')->insert([
            ['id' => 1, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'nr_processo' => '0001', 'nr_processo_sem_formatacao' => '0001', 'ds_situacao_processo' => 'Deferido', 'tp_processo' => 'DRAP'],
            ['id' => 2, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'nr_processo' => '0002', 'nr_processo_sem_formatacao' => '0002', 'ds_situacao_processo' => 'Deferido', 'tp_processo' => 'RRC'],
            ['id' => 3, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'nr_processo' => '0003', 'nr_processo_sem_formatacao' => '0003', 'ds_situacao_processo' => 'Deferido', 'tp_processo' => 'RRC'],
            ['id' => 4, 'cd_eleicao' => 6257, 'nm_eleicao' => 'Federal', 'nr_processo' => '0004', 'nr_processo_sem_formatacao' => '0004', 'ds_situacao_processo' => 'Deferido', 'tp_processo' => 'RRC'],
        ]);

        DB::table('planeleito.rcand_cand_proc_partido')->insert([
            ['cd_eleicao' => 6259, 'nr_processo_sem_formatacao' => '0001', 'nr_partido' => 10],
            ['cd_eleicao' => 6259, 'nr_processo_sem_formatacao' => '0001', 'nr_partido' => 20],
            ['cd_eleicao' => 6259, 'nr_processo_sem_formatacao' => '0002', 'nr_partido' => 10],
            ['cd_eleicao' => 6257, 'nr_processo_sem_formatacao' => '0004', 'nr_partido' => 10],
        ]);

        DB::table('planeleito.rcand_candexweb_pedidos')->insert([
            ['id' => 1, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'sq_pedido' => 101, 'sg_ue' => 'AC', 'nr_processo_drap' => '0001', 'st_popula' => 'S'],
            ['id' => 2, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'sq_pedido' => 102, 'sg_ue' => 'AC', 'nr_processo_drap' => '0003', 'st_popula' => 'S'],
        ]);
        DB::table('planeleito.rcand_cw_pedido_partido')->insert([
            ['cd_eleicao' => 6259, 'sq_pedido' => 101, 'nr_partido' => 20],
        ]);

        DB::table('planeleito.rcand_candexweb_candidatos')->insert([
            ['id' => 1, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'sq_candidato' => 201, 'sq_pedido' => 101, 'nr_candidato' => 10123, 'nm_candidato' => 'Candidato A', 'nm_urna' => 'A', 'nr_partido' => 10],
            ['id' => 2, 'cd_eleicao' => 6259, 'nm_eleicao' => 'Estadual', 'sq_candidato' => 202, 'sq_pedido' => 102, 'nr_candidato' => 20123, 'nm_candidato' => 'Candidato B', 'nm_urna' => 'B', 'nr_partido' => null],
        ]);
    }

    /** @return array<string, int|string> */
    private function consolidado(int $id, int $eleicao, string $processo, string $tipo): array
    {
        return [
            'id' => $id,
            'cd_eleicao' => $eleicao,
            'nm_eleicao' => $eleicao === 6257 ? 'Federal' : 'Estadual',
            'nr_processo' => $processo,
            'nr_processo_sem_formatacao' => $processo,
            'tipo_registro' => $tipo,
            'cand_processo' => $processo,
            'cand_situacao_processo' => 'Deferido',
            'cand_tipo_processo' => $tipo,
            'if_cand_x_pje' => 'Igual',
            'julgados_pje_sn' => 'Sim',
            'st_existe_pje' => 'Sim',
            'st_existe_cand' => 'Sim',
            'st_divergencia' => 'OK',
            'cert_publ_sn' => 'Sim',
            'sem_int_mpe' => 'Sim',
            'inform_candidato_sn' => 'Sim',
            'todas_peticoes_lidas' => 'Sim',
            'impugnacoes' => 'Não',
            'data_primeiro_recurso' => '',
            'contrarrazao' => '',
            'remessa_tre' => '',
        ];
    }
}
```
</TESTS_UNIT_RCANDREPOSITORYPARTIDOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/RcandSyncServiceTest.php`
## <TESTS_UNIT_RCANDSYNCSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/RcandSyncServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class RcandSyncServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function test_configuracao_pgsql_rcand_usa_variaveis_db_pg(): void
public function test_configuracao_rcand_cand_define_contexto_operacional_padrao(): void
public function test_configuracao_rcand_eleicoes_usa_fallback_legado_quando_lista_vazia(): void
public function test_query_cand_usa_unidade_eleitoral_da_abrangencia_em_2026(): void
public function test_query_cand_materializa_impugnacao_pela_ocorrencia_do_candidato(): void
public function test_queries_cand_carregam_catalogo_rrc_e_todos_os_partidos_de_drap(): void
public function test_queries_excluem_presidente_e_vice_somente_das_cargas_de_candidatos(): void
public function test_query_cand_rejeita_dblink_invalido(): void
public function test_sincronizar_cand_define_contexto_antes_de_truncar_e_inserir(): void
public function count(): int
public function test_query_candexweb_projeta_somente_campos_operacionais_sem_dados_sensiveis(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\Rcand\RcandSyncService;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class RcandSyncServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    public function test_configuracao_pgsql_rcand_usa_variaveis_db_pg(): void
    {
        $connection = config('database.connections.rcand_pje');
        $configFile = (string) file_get_contents(config_path('database.php'));

        $this->assertIsArray($connection);
        $this->assertSame('pgsql', $connection['driver']);
        $this->assertStringContainsString("'host' => env('DB_HOST_PG', '10.24.2.13')", $configFile);
        $this->assertStringContainsString("'port' => env('DB_PORT_PG', '5432')", $configFile);
        $this->assertStringContainsString("'database' => env('DB_BANCO_PG', 'pje')", $configFile);
        $this->assertStringContainsString("'username' => env('DB_USERNAME_PG')", $configFile);
        $this->assertStringContainsString("'password' => env('DB_PASSWORD_PG')", $configFile);
    }

    public function test_configuracao_rcand_cand_define_contexto_operacional_padrao(): void
    {
        $configFile = (string) file_get_contents(config_path('planeleito.php'));

        $this->assertSame('6259', config('planeleito.sync.rcand_eleicao_codigo'));
        $this->assertSame('6259', config('planeleito.sync.rcand_eleicao_codigos'));
        $this->assertSame('2026', config('planeleito.sync.rcand_ano_eleicao'));
        $this->assertSame('admcentral', config('planeleito.sync.rcand_cand_context_schema'));
        $this->assertSame([6259], (new RcandSyncService)->codigosEleicao());
        $this->assertStringContainsString("'rcand_eleicao_codigos' => env('RCAND_ELEICAO_CODIGOS', '6259')", $configFile);
        $this->assertStringContainsString("'rcand_eleicao_codigo' => env('RCAND_ELEICAO_CODIGO', '6259')", $configFile);
        $this->assertStringContainsString("'rcand_ano_eleicao' => env('RCAND_ANO_ELEICAO', '2026')", $configFile);
        $this->assertStringContainsString("'rcand_cand_context_schema' => env('RCAND_CAND_CONTEXT_SCHEMA', 'admcentral')", $configFile);
    }

    public function test_configuracao_rcand_eleicoes_usa_fallback_legado_quando_lista_vazia(): void
    {
        config([
            'planeleito.sync.rcand_eleicao_codigos' => '',
            'planeleito.sync.rcand_eleicao_codigo' => '6257',
        ]);

        $this->assertSame([6257], (new RcandSyncService)->codigosEleicao());
    }

    public function test_query_cand_usa_unidade_eleitoral_da_abrangencia_em_2026(): void
    {
        config(['planeleito.sync.rcand_uf' => 'AC']);

        $service = new RcandSyncService;

        $sqlFederal = $service->montarSqlInsercaoCand('cand', [
            'cd_eleicao' => 6257,
            'nm_eleicao' => 'Eleição Geral Federal 2026',
            'tp_abrangencia' => 'F',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ]);
        $sqlEstadual = $service->montarSqlInsercaoCand('cand', [
            'cd_eleicao' => 6259,
            'nm_eleicao' => 'Eleições Gerais Estaduais 2026',
            'tp_abrangencia' => 'E',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ]);

        $this->assertStringContainsString('cand_candidato@cand', $sqlFederal);
        $this->assertStringContainsString('cand_drap@cand', $sqlFederal);
        $this->assertStringContainsString('cand_ue@cand', $sqlFederal);
        $this->assertStringContainsString('cand_situacao_candidato@cand', $sqlFederal);
        $this->assertStringContainsString('cd_eleicao', $sqlFederal);
        $this->assertStringContainsString('6257 AS cd_eleicao', $sqlFederal);
        $this->assertStringContainsString("'Eleição Geral Federal 2026' AS nm_eleicao", $sqlFederal);
        $this->assertSame(2, substr_count($sqlFederal, "ue.sg_ue = 'BR'"));
        $this->assertSame(2, substr_count($sqlEstadual, "ue.sg_ue = 'AC'"));
        $this->assertStringNotContainsString('sg_ue_superior', $sqlFederal);
        $this->assertStringNotContainsString('sg_ue_superior', $sqlEstadual);
        $this->assertStringNotContainsString('select *', strtolower($sqlFederal));
        $this->assertStringNotContainsString('c.*', strtolower($sqlFederal));
        $this->assertStringNotContainsString('admcentral.', strtolower($sqlFederal));
    }

    public function test_query_cand_materializa_impugnacao_pela_ocorrencia_do_candidato(): void
    {
        config(['planeleito.sync.rcand_uf' => 'AC']);

        $sql = mb_strtolower((new RcandSyncService)->montarSqlInsercaoCand('cand', [
            'cd_eleicao' => 6259,
            'nm_eleicao' => 'Eleições Gerais Estaduais 2026',
            'tp_abrangencia' => 'E',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ]));

        $this->assertStringContainsString('cand_historico_ocorrencia@cand', $sql);
        $this->assertStringContainsString('i.cd_eleicao = c.cd_eleicao', $sql);
        $this->assertStringContainsString('i.sq_candidato = c.sq_candidato', $sql);
        $this->assertStringContainsString("h.tp_ocorrencia = 'i'", $sql);
        $this->assertStringContainsString("when i.sq_candidato is not null then 'sim'", $sql);
        $this->assertStringContainsString('end as impugnacoes', $sql);
    }

    public function test_queries_cand_carregam_catalogo_rrc_e_todos_os_partidos_de_drap(): void
    {
        $service = new RcandSyncService;
        $eleicao = [
            'cd_eleicao' => 6259,
            'nm_eleicao' => 'Eleições Gerais Estaduais 2026',
            'tp_abrangencia' => 'E',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ];

        $catalogo = strtolower($service->montarSqlInsercaoCatalogoPartidos('cand', $eleicao));
        $relacoes = strtolower($service->montarSqlInsercaoCandProcessoPartidos('cand', $eleicao));

        $this->assertStringContainsString('insert into planeleito.rcand_partido', $catalogo);
        $this->assertStringContainsString('cand_partido@cand', $catalogo);
        $this->assertStringContainsString('6259 as cd_eleicao', $catalogo);
        $this->assertStringContainsString('p.nr_partido', $catalogo);
        $this->assertStringContainsString('p.sg_partido', $catalogo);
        $this->assertStringContainsString('p.nm_partido', $catalogo);

        $this->assertStringContainsString('insert into planeleito.rcand_cand_proc_partido', $relacoes);
        $this->assertStringContainsString('cand_candidato@cand', $relacoes);
        $this->assertStringContainsString('c.nr_partido', $relacoes);
        $this->assertStringContainsString('cand_partido_isolado@cand', $relacoes);
        $this->assertStringContainsString('cand_partido_coligacao@cand', $relacoes);
        $this->assertStringContainsString('d.sq_drap', $relacoes);
        $this->assertStringContainsString("regexp_replace(nr_processo, '[^0-9]', '')", $relacoes);
        $this->assertStringNotContainsString('select *', $catalogo.$relacoes);
        $this->assertStringNotContainsString('c.*', $catalogo.$relacoes);
    }

    public function test_queries_excluem_presidente_e_vice_somente_das_cargas_de_candidatos(): void
    {
        config(['planeleito.sync.rcand_uf' => 'AC']);

        $service = new RcandSyncService;
        $eleicao = [
            'cd_eleicao' => 6257,
            'nm_eleicao' => 'Eleição Geral Federal 2026',
            'tp_abrangencia' => 'F',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ];
        $condicaoCargoCand = '(c.cd_cargo_eleicao IS NULL OR c.cd_cargo_eleicao NOT IN (1, 2))';
        $condicaoCargoCandexweb = '(c.cd_cargo IS NULL OR c.cd_cargo NOT IN (1, 2))';

        $sqlCand = $service->montarSqlInsercaoCand('cand', $eleicao);
        $sqlRelacoesCand = $service->montarSqlInsercaoCandProcessoPartidos('cand', $eleicao);
        $sqlCandexwebPedidos = $service->montarSqlInsercaoCandexwebPedidos('cand', $eleicao);
        $sqlCandexwebCandidatos = $service->montarSqlInsercaoCandexwebCandidatos('cand', $eleicao);

        $this->assertSame(1, substr_count($sqlCand, $condicaoCargoCand));
        $this->assertSame(1, substr_count($sqlRelacoesCand, $condicaoCargoCand));
        $this->assertSame(1, substr_count($sqlCandexwebCandidatos, $condicaoCargoCandexweb));
        $this->assertStringContainsString(
            $condicaoCargoCand,
            $service->montarSqlContagemCand('cand', $eleicao)
        );
        $this->assertStringContainsString(
            $condicaoCargoCandexweb,
            $service->montarSqlContagemCandexwebCandidatos('cand', $eleicao)
        );
        $this->assertStringNotContainsString($condicaoCargoCandexweb, $sqlCand.$sqlRelacoesCand);

        $this->assertStringContainsString('FROM cand_drap@cand cd', $sqlCand);
        $this->assertStringContainsString('cand_partido_isolado@cand', $sqlRelacoesCand);
        $this->assertStringContainsString('cand_partido_coligacao@cand', $sqlRelacoesCand);
        $this->assertStringContainsString("p.sg_ue in ('AC', 'BR')", $sqlCandexwebPedidos);
        $this->assertStringNotContainsString('NOT IN (1, 2)', $sqlCandexwebPedidos);
    }

    public function test_query_cand_rejeita_dblink_invalido(): void
    {
        config(['planeleito.sync.rcand_cand_dblink' => 'cand;drop']);

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('DBLINK invalido para sincronizacao RCAND CAND.');

        (new RcandSyncService)->sincronizarCand();
    }

    public function test_sincronizar_cand_define_contexto_antes_de_truncar_e_inserir(): void
    {
        config([
            'planeleito.sync.rcand_cand_dblink' => 'cand',
            'planeleito.sync.rcand_eleicao_codigos' => '6257,6259',
        ]);

        $ordem = [];

        DB::shouldReceive('statement')
            ->once()
            ->with('TRUNCATE TABLE planeleito.rcand_cand_proc_partido')
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'truncate-relacao';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with('TRUNCATE TABLE planeleito.rcand_partido')
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'truncate-catalogo';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with('TRUNCATE TABLE planeleito.rcand_cand_processos')
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'truncate-processos';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with('BEGIN admcentral.pc_contexto.set_eleicao@cand(:codigo); END;', ['codigo' => 6257])
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'contexto-6257';

                return true;
            });

        DB::shouldReceive('selectOne')
            ->once()
            ->with('select admcentral.pc_contexto.contexto_info@cand as info from dual')
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'meta-6257';

                return (object) ['info' => 'UF=BR; cd_eleicao=6257; tipo=Federal; nr_turno=1; nm_eleicao=Eleição Geral Federal 2026; tp_abrangencia=F; dt_eleicao=2026-10-04 00:00:00'];
            });

        DB::shouldReceive('statement')
            ->once()
            ->with(Mockery::on(function (string $sql): bool {
                return str_contains($sql, 'INSERT INTO planeleito.rcand_partido')
                    && str_contains($sql, 'cand_partido@cand')
                    && str_contains($sql, '6257 AS cd_eleicao');
            }))
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'catalogo-6257';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with(Mockery::on(function (string $sql): bool {
                return str_contains($sql, 'INSERT INTO planeleito.rcand_cand_processos')
                    && str_contains($sql, 'cand_candidato@cand')
                    && str_contains($sql, '6257 AS cd_eleicao')
                    && ! str_contains(strtolower($sql), 'admcentral.');
            }))
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'insert-6257';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with(Mockery::on(function (string $sql): bool {
                return str_contains($sql, 'INSERT INTO planeleito.rcand_cand_proc_partido')
                    && str_contains($sql, 'cand_partido_isolado@cand')
                    && str_contains($sql, 'cand_partido_coligacao@cand')
                    && str_contains($sql, '6257 AS cd_eleicao');
            }))
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'relacoes-6257';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with('BEGIN admcentral.pc_contexto.set_eleicao@cand(:codigo); END;', ['codigo' => 6259])
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'contexto-6259';

                return true;
            });

        DB::shouldReceive('selectOne')
            ->once()
            ->with('select admcentral.pc_contexto.contexto_info@cand as info from dual')
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'meta-6259';

                return (object) ['info' => 'UF=BR; cd_eleicao=6259; tipo=Estadual; nr_turno=1; nm_eleicao=Eleições Gerais Estaduais 2026; tp_abrangencia=E; dt_eleicao=2026-10-04 00:00:00'];
            });

        DB::shouldReceive('statement')
            ->once()
            ->with(Mockery::on(function (string $sql): bool {
                return str_contains($sql, 'INSERT INTO planeleito.rcand_partido')
                    && str_contains($sql, 'cand_partido@cand')
                    && str_contains($sql, '6259 AS cd_eleicao');
            }))
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'catalogo-6259';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with(Mockery::on(function (string $sql): bool {
                return str_contains($sql, 'INSERT INTO planeleito.rcand_cand_processos')
                    && str_contains($sql, 'cand_drap@cand')
                    && str_contains($sql, '6259 AS cd_eleicao')
                    && ! str_contains(strtolower($sql), 'admcentral.');
            }))
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'insert-6259';

                return true;
            });

        DB::shouldReceive('statement')
            ->once()
            ->with(Mockery::on(function (string $sql): bool {
                return str_contains($sql, 'INSERT INTO planeleito.rcand_cand_proc_partido')
                    && str_contains($sql, 'cand_candidato@cand')
                    && str_contains($sql, '6259 AS cd_eleicao');
            }))
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'relacoes-6259';

                return true;
            });

        DB::shouldReceive('table')
            ->once()
            ->with('planeleito.rcand_cand_processos')
            ->andReturn(new class
            {
                public function count(): int
                {
                    return 2;
                }
            });

        DB::shouldReceive('selectOne')
            ->twice()
            ->with(Mockery::on(fn (string $sql): bool => str_contains($sql, 'FROM (')))
            ->andReturn((object) ['total' => 1], (object) ['total' => 1]);

        $resultado = (new RcandSyncService)->sincronizarCand();

        $this->assertSame([
            'truncate-relacao',
            'truncate-catalogo',
            'truncate-processos',
            'contexto-6257',
            'meta-6257',
            'catalogo-6257',
            'insert-6257',
            'relacoes-6257',
            'contexto-6259',
            'meta-6259',
            'catalogo-6259',
            'insert-6259',
            'relacoes-6259',
        ], $ordem);
        $this->assertSame('cand', $resultado['dblink']);
        $this->assertSame(2, $resultado['origem_total']);
        $this->assertSame(2, $resultado['destino_total']);
    }

    public function test_query_candexweb_projeta_somente_campos_operacionais_sem_dados_sensiveis(): void
    {
        $service = new RcandSyncService;
        $eleicao = [
            'cd_eleicao' => 6259,
            'nm_eleicao' => 'Eleições Gerais Estaduais 2026',
            'tp_abrangencia' => 'E',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ];

        $sqlPedidos = $service->montarSqlInsercaoCandexwebPedidos('cand', $eleicao);
        $sqlCandidatos = $service->montarSqlInsercaoCandexwebCandidatos('cand', $eleicao);
        $sql = strtolower($sqlPedidos."\n".$sqlCandidatos);

        $this->assertStringContainsString('insert into planeleito.rcand_candexweb_pedidos', $sql);
        $this->assertStringContainsString('insert into planeleito.rcand_candexweb_candidatos', $sql);
        $this->assertStringContainsString('admcandexweb.candex_pedido@cand', $sql);
        $this->assertStringContainsString('admcandexweb.candex_candidato@cand', $sql);
        $this->assertStringContainsString("p.sg_ue in ('AC', 'BR')", $sqlPedidos);
        $this->assertStringContainsString('6259 as cd_eleicao', $sql);

        foreach (['nr_cpf', 'cpf_', 'nr_titulo', 'nr_rg', 'dt_nascimento', 'tx_hash', 'nr_hash', 'representante'] as $sensivel) {
            $this->assertStringNotContainsString($sensivel, $sql);
        }
    }

    public function test_query_candexweb_carrega_todos_os_partidos_do_pedido(): void
    {
        $sql = strtolower((new RcandSyncService)->montarSqlInsercaoCandexwebPedidoPartidos('cand', [
            'cd_eleicao' => 6259,
            'nm_eleicao' => 'Eleições Gerais Estaduais 2026',
            'tp_abrangencia' => 'E',
            'nr_turno' => 1,
            'dt_eleicao' => '2026-10-04',
        ]));

        $this->assertStringContainsString('insert into planeleito.rcand_cw_pedido_partido', $sql);
        $this->assertStringContainsString('admcandexweb.candex_partido_pedido@cand', $sql);
        $this->assertStringContainsString('admcandexweb.candex_pedido@cand', $sql);
        $this->assertStringContainsString('pp.cd_eleicao', $sql);
        $this->assertStringContainsString('pp.sq_pedido', $sql);
        $this->assertStringContainsString('pp.nr_partido', $sql);
        $this->assertStringContainsString("p.sg_ue in ('ac', 'br')", $sql);

        foreach (['nr_cpf', 'nr_titulo', 'nr_rg', 'dt_nascimento', 'tx_hash', 'representante'] as $sensivel) {
            $this->assertStringNotContainsString($sensivel, $sql);
        }
    }

    public function test_sincronizar_candexweb_substitui_relacao_partidaria_na_mesma_carga(): void
    {
        config([
            'planeleito.sync.rcand_cand_dblink' => 'cand',
            'planeleito.sync.rcand_eleicao_codigos' => '6259',
        ]);

        $ordem = [];

        foreach ([
            'rcand_cw_pedido_partido' => 'truncate-relacao',
            'rcand_candexweb_candidatos' => 'truncate-candidatos',
            'rcand_candexweb_pedidos' => 'truncate-pedidos',
        ] as $tabela => $etapa) {
            DB::shouldReceive('statement')
                ->once()
                ->with("TRUNCATE TABLE planeleito.{$tabela}")
                ->andReturnUsing(function () use (&$ordem, $etapa) {
                    $ordem[] = $etapa;

                    return true;
                });
        }

        DB::shouldReceive('statement')
            ->once()
            ->with('BEGIN admcentral.pc_contexto.set_eleicao@cand(:codigo); END;', ['codigo' => 6259])
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'contexto-6259';

                return true;
            });

        DB::shouldReceive('selectOne')
            ->once()
            ->with('select admcentral.pc_contexto.contexto_info@cand as info from dual')
            ->andReturnUsing(function () use (&$ordem) {
                $ordem[] = 'meta-6259';

                return (object) ['info' => 'cd_eleicao=6259; nr_turno=1; nm_eleicao=Eleições Gerais Estaduais 2026; tp_abrangencia=E; dt_eleicao=2026-10-04 00:00:00'];
            });

        foreach ([
            'INSERT INTO planeleito.rcand_candexweb_pedidos' => 'pedidos-6259',
            'INSERT INTO planeleito.rcand_candexweb_candidatos' => 'candidatos-6259',
            'INSERT INTO planeleito.rcand_cw_pedido_partido' => 'relacoes-6259',
        ] as $trecho => $etapa) {
            DB::shouldReceive('statement')
                ->once()
                ->with(Mockery::on(static fn (string $sql): bool => str_contains($sql, $trecho)))
                ->andReturnUsing(function () use (&$ordem, $etapa) {
                    $ordem[] = $etapa;

                    return true;
                });
        }

        DB::shouldReceive('selectOne')
            ->twice()
            ->with(Mockery::on(static fn (string $sql): bool => str_contains($sql, 'FROM (')))
            ->andReturn((object) ['total' => 1], (object) ['total' => 2]);

        DB::shouldReceive('table')
            ->once()
            ->with('planeleito.rcand_candexweb_pedidos')
            ->andReturn(new class
            {
                public function count(): int
                {
                    return 1;
                }
            });

        DB::shouldReceive('table')
            ->once()
            ->with('planeleito.rcand_candexweb_candidatos')
            ->andReturn(new class
            {
                public function count(): int
                {
                    return 2;
                }
            });

        $resultado = (new RcandSyncService)->sincronizarCandexweb();

        $this->assertSame([
            'truncate-relacao',
            'truncate-candidatos',
            'truncate-pedidos',
            'contexto-6259',
            'meta-6259',
            'pedidos-6259',
            'candidatos-6259',
            'relacoes-6259',
        ], $ordem);
        $this->assertSame(3, $resultado['origem_total']);
        $this->assertSame(3, $resultado['destino_total']);
    }

    public function test_campos_calculados_pbit_reproduzem_regras_do_powerbi(): void
    {
        $service = new RcandSyncService;

        $calculados = $service->calcularCamposPbit([
            'primeiro_julgamento' => '12/08',
            'intimacao_mp_parecer' => '08/08',
            'peticoes_avulsas' => null,
            'certidao_publicacao' => '03/08',
            'informacao_candidato' => 'Sim',
            'cand_situacao_processo' => 'Deferido',
        ]);

        $this->assertSame('Sim', $calculados['julgados_pje_sn']);
        $this->assertSame('Sim', $calculados['sem_int_mpe']);
        $this->assertSame('Não', $calculados['todas_peticoes_lidas']);
        $this->assertSame('Sim', $calculados['cert_publ_sn']);
        $this->assertSame(1, $calculados['julgamento_if_cand']);
        $this->assertSame('Sim', $calculados['julgados_cand_sn']);
        $this->assertSame('Sim', $calculados['inform_candidato_sn']);
        $this->assertSame('Igual', $calculados['if_cand_x_pje']);

        $divergente = $service->calcularCamposPbit([
            'primeiro_julgamento' => null,
            'intimacao_mp_parecer' => null,
            'peticoes_avulsas' => '05/08',
            'certidao_publicacao' => null,
            'informacao_candidato' => null,
            'cand_situacao_processo' => 'Deferido',
        ]);

        $this->assertSame('Não', $divergente['julgados_pje_sn']);
        $this->assertSame('Não', $divergente['sem_int_mpe']);
        $this->assertSame('Sim', $divergente['todas_peticoes_lidas']);
        $this->assertSame('Não', $divergente['cert_publ_sn']);
        $this->assertSame(1, $divergente['julgamento_if_cand']);
        $this->assertSame('Sim', $divergente['julgados_cand_sn']);
        $this->assertSame('Não', $divergente['inform_candidato_sn']);
        $this->assertSame('Diferente', $divergente['if_cand_x_pje']);
    }

    public function test_query_consolidado_materializa_campos_calculados_do_pbit(): void
    {
        $sql = (new RcandSyncService)->montarSqlInsercaoConsolidado();

        foreach ([
            'cd_eleicao',
            'nm_eleicao',
            'julgados_pje_sn',
            'sem_int_mpe',
            'todas_peticoes_lidas',
            'cert_publ_sn',
            'cand_processo',
            'julgamento_if_cand',
            'julgados_cand_sn',
            'inform_candidato_sn',
            'if_cand_x_pje',
            'envio_mpf',
        ] as $coluna) {
            $this->assertStringContainsString($coluna, $sql);
        }

        $this->assertStringContainsString("WHEN p.primeiro_julgamento IS NULL THEN 'Não' ELSE 'Sim' END AS julgados_pje_sn", $sql);
        $this->assertStringContainsString('AGUARDANDO JULGAMENTO', $sql);
        $this->assertStringContainsString('AS julgados_cand_sn', $sql);
        $this->assertStringContainsString('END AS if_cand_x_pje', $sql);
        $this->assertStringContainsString('c.cd_eleicao AS cd_eleicao', $sql);
        $this->assertStringContainsString('c.nm_eleicao AS nm_eleicao', $sql);
        $this->assertStringContainsString('p.envio_mpf', $sql);
        $this->assertStringContainsString('c.impugnacoes AS impugnacoes', $sql);
        $this->assertStringNotContainsString("p.impugnacoes = 'Sim'", $sql);
    }

    public function test_query_pje_materializa_movimentos_eleitorais_sem_dependencias_legadas(): void
    {
        config(['planeleito.sync.rcand_ano_eleicao' => '2026']);

        $sql = mb_strtolower((new RcandSyncService)->montarSqlConsultaPje());

        $this->assertStringContainsString("cp.nr_ano_eleicao = '2026'", $sql);
        $this->assertStringContainsString('q_proc_com_edital_drap_e_rcc as', $sql);
        $this->assertStringContainsString('id_processo_trf_origem', $sql);
        $this->assertStringNotContainsString('tptc.nr_processo is not null', $sql);
        $this->assertStringContainsString('join q_proc_com_edital_drap_e_rcc e', $sql);
        $this->assertStringNotContainsString('q_proc_impugnacao as', $sql);
        $this->assertStringNotContainsString("pd.ds_processo_documento ilike '%impugna%'", $sql);
        $this->assertStringContainsString('null::text as impugnacoes', $sql);
        $this->assertStringNotContainsString('core.tb_processo_documento_bin pdb', $sql);
        $this->assertStringContainsString("lower(task.name_) = lower('analisar petição avulsa')", $sql);
        $this->assertStringContainsString('client.tb_processo_expediente', $sql);
        $this->assertStringContainsString('client.tb_proc_parte_expediente', $sql);
        $this->assertStringContainsString('exp.dt_exclusao is null', $sql);
        $this->assertStringContainsString('procuradoria regional eleitoral', $sql);
        $this->assertStringContainsString('as envio_mpf', $sql);
        $this->assertStringContainsString('manifestação do ministério público eleitoral', $sql);
        $this->assertSame(1, substr_count($sql, 'join q_info_cand info'));
    }

    public function test_query_pje_considera_julgamento_em_sessao_antes_do_resultado_especifico(): void
    {
        config(['planeleito.sync.rcand_ano_eleicao' => '2026']);

        $sql = mb_strtolower((new RcandSyncService)->montarSqlConsultaPje());

        $this->assertStringContainsString('q_eventos_julgamento as', $sql);
        $this->assertMatchesRegularExpression(
            "/q_eventos_julgamento as \\(.*pe\\.in_ativo is true.*e\\.cd_evento = '12200'.*\\),\\s*q_primeiro_julgamento as/s",
            $sql
        );
        $this->assertMatchesRegularExpression(
            '/q_primeiro_julgamento as \\(.*min\\(dt_atualizacao\\) dt_primeiro_julgamento.*group by id_processo_trf.*\\)/s',
            $sql
        );
        $this->assertStringContainsString("when e.cd_evento in ('12444', '12660', '12673', '12694', '15023') then 'deferido'", $sql);
        $this->assertStringContainsString("when e.cd_evento in ('12667', '14210', '15024') then 'indeferido'", $sql);
        $this->assertStringContainsString('left join q_teor_julgamento', $sql);
    }

    public function test_query_pje_nao_contem_host_antigo_do_powerbi(): void
    {
        config(['planeleito.sync.rcand_ano_eleicao' => '2024']);

        $sql = (new RcandSyncService)->montarSqlConsultaPje();

        $this->assertStringContainsString('with q_proc_cand as', strtolower($sql));
        $this->assertStringContainsString("cp.nr_ano_eleicao = '2024'", $sql);
        $this->assertStringNotContainsString('ops.tre-se.gov.br', $sql);
        $this->assertStringNotContainsString('PostgreSQL.Database', $sql);
    }
}
```
</TESTS_UNIT_RCANDSYNCSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaAdminAnexoTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAADMINANEXOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaAdminAnexoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaAdminAnexoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function permite_download_interno_de_anexo_pendente_sem_varredura(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\SeuVotoImporta\SeuVotoImportaAdminController;
use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaFluxoStatusService;
use App\Support\Access\EscopoZonal;
use App\Support\SeuVotoImporta\SeuVotoImportaMascarador;
use Illuminate\Support\Facades\Storage;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Tests\TestCase;

class SeuVotoImportaAdminAnexoTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function permite_download_interno_de_anexo_pendente_sem_varredura(): void
    {
        Storage::fake('local');
        $caminho = 'seu-voto-importa/quarentena/123e4567-e89b-12d3-a456-426614174000.pdf';
        Storage::disk('local')->put($caminho, '%PDF-1.4');
        session(['cod_zonas_permitidas' => [1], 'acesso_todas_zonas' => false]);

        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarAnexoAdministrativo')
            ->once()
            ->with(7, 8, Mockery::on(
                static fn (EscopoZonal $escopo): bool => $escopo->zonas() === [1]
                    && !$escopo->acessoTodas()
            ))
            ->andReturn([
                'scan_status' => 'PENDENTE',
                'disco' => 'local',
                'caminho' => $caminho,
                'nome_original' => 'condicao.pdf',
                'mime' => 'application/pdf',
            ]);

        $controller = new SeuVotoImportaAdminController(
            $repository,
            Mockery::mock(SeuVotoImportaFluxoStatusService::class),
            Mockery::mock(SeuVotoImportaMascarador::class),
        );

        $this->assertInstanceOf(StreamedResponse::class, $controller->downloadAnexo(7, 8));
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAADMINANEXOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaAnexoServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAANEXOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaAnexoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaAnexoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function guarda_em_disco_privado_sem_exigir_scanner_antimalware(): void
public function anexo_com_mime_real_nao_permitido_nao_chega_ao_repository(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaAnexoService;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use RuntimeException;
use Tests\TestCase;

class SeuVotoImportaAnexoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function guarda_em_disco_privado_sem_exigir_scanner_antimalware(): void
    {
        Storage::fake('local');
        $arquivo = UploadedFile::fake()->image('condicao.jpg');
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('criarAnexo')->once()->with(Mockery::on(
            static fn (array $dados): bool => $dados['SOLICITACAO_ID'] === 7
                && $dados['CATEGORIA'] === 'CONDICAO'
                && $dados['SCAN_STATUS'] === 'PENDENTE'
                && $dados['SCANNER'] === null
                && $dados['SCANEADO_EM'] === null
                && str_starts_with($dados['CAMINHO'], 'seu-voto-importa/quarentena/')
                && preg_match('/^[a-f0-9]{64}$/', $dados['SHA256']) === 1
        ))->andReturn(8);
        $resultado = (new SeuVotoImportaAnexoService($repository))->salvar(7, 'CONDICAO', $arquivo);

        Storage::disk('local')->assertExists($resultado['caminho']);
        $this->assertSame('PENDENTE', $resultado['scan_status']);
    }

    #[Test]
    public function anexo_com_mime_real_nao_permitido_nao_chega_ao_repository(): void
    {
        Storage::fake('local');
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldNotReceive('criarAnexo');
        try {
            (new SeuVotoImportaAnexoService($repository))->preparar(
                'CONDICAO',
                UploadedFile::fake()->create('condicao.txt', 1, 'text/plain'),
            );
            $this->fail('O anexo com MIME real não permitido deveria ser rejeitado.');
        } catch (RuntimeException $exception) {
            $this->assertSame('Tipo real do anexo não permitido.', $exception->getMessage());
        }

        $this->assertSame([], Storage::disk('local')->allFiles('seu-voto-importa/quarentena'));
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAANEXOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaAuditoriaPrivacidadeTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAAUDITORIAPRIVACIDADETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaAuditoriaPrivacidadeTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaAuditoriaPrivacidadeTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function audita_dml_remove_dados_pessoais_e_de_saude_do_payload_svi(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaAuditoriaPrivacidadeTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function audita_dml_remove_dados_pessoais_e_de_saude_do_payload_svi(): void
    {
        $repository = Mockery::mock(AuditLogRepositoryInterface::class);
        $repository->shouldReceive('inserir')->once()->with(Mockery::on(static function (array $registro): bool {
            $json = implode(' ', [
                (string) $registro['bindings_json'],
                (string) $registro['dados_antes_json'],
                (string) $registro['dados_depois_json'],
            ]);

            return str_contains($json, '[REDACTED]')
                && str_contains($json, 'RECEBIDA')
                && !str_contains($json, '000123456789')
                && !str_contains($json, 'eleitor@example.com')
                && !str_contains($json, 'Deficiência física')
                && !str_contains($json, 'Autodeclaração detalhada')
                && !str_contains($json, 'Impacto detalhado')
                && !str_contains($json, 'Rua das Flores');
        }));

        (new AuditLogService($repository))->registrarAcao(
            'INSERT',
            'SVI_SOLICITACAO',
            7,
            'INSERT BUILDER: SVI_SOLICITACAO',
            ['dados' => [
                'NUM_INSCRICAO' => '000123456789',
                'ELEITOR_EMAIL' => 'eleitor@example.com',
                'CONDICAO_DESCRICAO' => 'Deficiência física',
                'AUTODECLARACAO_TEXTO' => 'Autodeclaração detalhada',
                'IMPACTO_DESCRICAO' => 'Impacto detalhado',
                'ENDERECO_LOGRADOURO' => 'Rua das Flores',
                'STATUS_CODIGO' => 'RECEBIDA',
            ]],
            null,
            ['ID' => 7, 'NUM_INSCRICAO' => '000123456789', 'STATUS_CODIGO' => 'RECEBIDA'],
        );

        $this->addToAssertionCount(1);
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAAUDITORIAPRIVACIDADETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaFluxoStatusServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAFLUXOSTATUSSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaFluxoStatusServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaFluxoStatusServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function permite_as_transicoes_operacionais_previstas(): void
public function rejeita_salto_de_estado_e_estado_desconhecido(): void
public function rejeita_conclusao_de_turno_sem_agendamento(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\SeuVotoImporta\SeuVotoImportaFluxoStatusService;
use DomainException;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class SeuVotoImportaFluxoStatusServiceTest extends TestCase
{
    #[Test]
    public function permite_as_transicoes_operacionais_previstas(): void
    {
        $service = new SeuVotoImportaFluxoStatusService();

        $service->validarSolicitacao('RECEBIDA', 'EM_ANALISE');
        $service->validarSolicitacao('EM_ANALISE', 'PENDENCIA');
        $service->validarSolicitacao('PENDENCIA', 'DEFERIDA');
        $service->validarSolicitacao('DEFERIDA', 'CANCELADA');
        $service->validarTurno('AGUARDANDO_AGENDAMENTO', 'AGENDADA');
        $service->validarTurno('AGENDADA', 'CONCLUIDA');

        $this->addToAssertionCount(6);
    }

    #[Test]
    public function rejeita_salto_de_estado_e_estado_desconhecido(): void
    {
        $service = new SeuVotoImportaFluxoStatusService();

        $this->expectException(DomainException::class);
        $service->validarSolicitacao('RECEBIDA', 'DEFERIDA');
    }

    #[Test]
    public function rejeita_conclusao_de_turno_sem_agendamento(): void
    {
        $service = new SeuVotoImportaFluxoStatusService();

        $this->expectException(DomainException::class);
        $service->validarTurno('AGUARDANDO_AGENDAMENTO', 'CONCLUIDA');
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAFLUXOSTATUSSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaIdentificacaoServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAIDENTIFICACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaIdentificacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaIdentificacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function sessao_de_preenchimento_contem_somente_dados_eleitorais_permitidos(): void
public function identificacao_rejeita_local_de_votacao_fora_de_rio_branco(): void
public function representante_so_e_identificado_dentro_da_sessao_ativa_do_formulario(): void
public function representante_nao_e_consultado_sem_sessao_ativa(): void
private function requestComSessao(): Request
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\SeuVotoImporta\SeuVotoImportaEleitorRepository;
use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaIdentificacaoService;
use Carbon\CarbonImmutable;
use Illuminate\Http\Request;
use Illuminate\Session\ArraySessionHandler;
use Illuminate\Session\Store;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaIdentificacaoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        CarbonImmutable::setTestNow();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function sessao_de_preenchimento_contem_somente_dados_eleitorais_permitidos(): void
    {
        CarbonImmutable::setTestNow('2026-08-21 10:00:00');
        $eleitores = Mockery::mock(SeuVotoImportaEleitorRepository::class);
        $eleitores->shouldReceive('buscarPorTituloNascimento')->once()->andReturn([
            'num_inscricao' => '000123456789', 'nome' => 'Eleitora Teste',
            'dt_nascimento' => '1990-05-20', 'zona_numero' => 1, 'secao_numero' => '101',
            'local_cod_objeto' => 'LOCAL-1', 'local_numero' => 10,
            'local_nome' => 'Escola Teste', 'local_endereco' => 'Rua do local',
            'municipio_nome' => 'Rio Branco',
            'des_endereco' => 'DADO PROIBIDO', 'num_cpf' => '12345678900',
        ]);
        $solicitacoes = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $solicitacoes->shouldReceive('buscarConfiguracaoAberta')->once()->andReturn([
            'id' => 4, 'macroprojeto_id' => 15, 'aviso_privacidade' => 'Aviso aprovado',
        ]);
        $request = $this->requestComSessao();

        $service = new SeuVotoImportaIdentificacaoService($eleitores, $solicitacoes);
        $contexto = $service->iniciar($request, '000123456789', '1990-05-20');

        $this->assertSame('Eleitora Teste', $contexto['nome']);
        $this->assertSame(36, $contexto['idade']);
        $this->assertSame('Rua do local', $contexto['local_endereco']);
        $this->assertArrayNotHasKey('des_endereco', $contexto);
        $this->assertArrayNotHasKey('num_cpf', $contexto);
        $this->assertSame($contexto, $service->contexto($request));
    }

    #[Test]
    public function identificacao_rejeita_local_de_votacao_fora_de_rio_branco(): void
    {
        $eleitores = Mockery::mock(SeuVotoImportaEleitorRepository::class);
        $eleitores->shouldReceive('buscarPorTituloNascimento')->once()->andReturn([
            'num_inscricao' => '000123456789', 'nome' => 'Eleitora Teste',
            'dt_nascimento' => '1990-05-20', 'zona_numero' => 4, 'secao_numero' => '101',
            'local_cod_objeto' => 'LOCAL-1', 'local_numero' => 10,
            'local_nome' => 'Escola Teste', 'local_endereco' => 'Rua do local',
            'municipio_nome' => 'Cruzeiro do Sul',
        ]);
        $solicitacoes = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $solicitacoes->shouldReceive('buscarConfiguracaoAberta')->once()->andReturn([
            'id' => 4, 'macroprojeto_id' => 15, 'aviso_privacidade' => 'Aviso aprovado',
        ]);

        $contexto = (new SeuVotoImportaIdentificacaoService($eleitores, $solicitacoes))
            ->iniciar($this->requestComSessao(), '000123456789', '1990-05-20');

        $this->assertNull($contexto);
    }

    #[Test]
    public function representante_so_e_identificado_dentro_da_sessao_ativa_do_formulario(): void
    {
        CarbonImmutable::setTestNow('2026-08-27 10:00:00');
        $eleitores = Mockery::mock(SeuVotoImportaEleitorRepository::class);
        $eleitores->shouldReceive('buscarNomePorTituloNascimento')->once()
            ->with('000123456789', '1985-02-10')->andReturn('Representante Teste');
        $solicitacoes = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $request = $this->requestComSessao();
        $request->session()->put('seu_voto_importa_identificacao', [
            'expira_em' => CarbonImmutable::now()->addMinutes(30)->toIso8601String(),
        ]);

        $resultado = (new SeuVotoImportaIdentificacaoService($eleitores, $solicitacoes))
            ->identificarRepresentante($request, '000123456789', '1985-02-10');

        $this->assertSame(['nome' => 'Representante Teste'], $resultado);
    }

    #[Test]
    public function representante_nao_e_consultado_sem_sessao_ativa(): void
    {
        $eleitores = Mockery::mock(SeuVotoImportaEleitorRepository::class);
        $eleitores->shouldNotReceive('buscarNomePorTituloNascimento');
        $solicitacoes = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);

        $resultado = (new SeuVotoImportaIdentificacaoService($eleitores, $solicitacoes))
            ->identificarRepresentante($this->requestComSessao(), '000123456789', '1985-02-10');

        $this->assertNull($resultado);
    }

    private function requestComSessao(): Request
    {
        $request = Request::create('/rotas-publicas/seu-voto-importa', 'POST');
        $request->setLaravelSession(new Store('array', new ArraySessionHandler(120)));

        return $request;
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAIDENTIFICACAOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaMascaradorTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAMASCARADORTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaMascaradorTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaMascaradorTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function mascara_dados_de_contato_e_titulo(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Support\SeuVotoImporta\SeuVotoImportaMascarador;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaMascaradorTest extends TestCase
{
    #[Test]
    public function mascara_dados_de_contato_e_titulo(): void
    {
        $mascarador = new SeuVotoImportaMascarador;

        $this->assertSame('********9012', $mascarador->titulo('123456789012'));
        $this->assertSame('jo***@example.com', $mascarador->email('joao@example.com'));
        $this->assertSame('(68) *****-**89', $mascarador->telefone('68999998889'));
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAMASCARADORTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaMenuTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAMENUTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaMenuTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaMenuTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function catalogo_exibe_operacoes_eleitorais_somente_com_rota_svi_permitida(): void
public function catalogo_resolve_menu_path_das_rotas_administrativas_svi(): void
public function layout_renderiza_dropdown_de_operacoes_eleitorais_condicionado_a_itens(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\MenuCatalogService;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaMenuTest extends TestCase
{
    #[Test]
    public function catalogo_exibe_operacoes_eleitorais_somente_com_rota_svi_permitida(): void
    {
        $catalogo = app(MenuCatalogService::class);

        $autorizado = $catalogo->buildForLayout(['seu-voto-importa.admin.index']);
        $this->assertArrayHasKey('operacoes_eleitorais', $autorizado);
        $this->assertSame('Operações Eleitorais', $autorizado['operacoes_eleitorais']['label']);
        $this->assertSame(
            ['Seu Voto Importa'],
            array_column($autorizado['operacoes_eleitorais']['itens'], 'label'),
        );

        $administrador = $catalogo->buildForLayout(['*']);
        $this->assertSame(
            ['Seu Voto Importa', 'Acessibilidade'],
            array_column($administrador['operacoes_eleitorais']['itens'], 'label'),
        );

        $semAcesso = $catalogo->buildForLayout([]);
        $this->assertArrayHasKey('operacoes_eleitorais', $semAcesso);
        $this->assertSame([], $semAcesso['operacoes_eleitorais']['itens']);
    }

    #[Test]
    public function catalogo_resolve_menu_path_das_rotas_administrativas_svi(): void
    {
        $this->assertSame(
            'Operações Eleitorais > Seu Voto Importa',
            app(MenuCatalogService::class)->menuPathForRoute('seu-voto-importa.admin.show'),
        );
    }

    #[Test]
    public function layout_renderiza_dropdown_de_operacoes_eleitorais_condicionado_a_itens(): void
    {
        $layout = (string) file_get_contents(resource_path('views/layouts/app.blade.php'));

        $this->assertStringContainsString("!empty(\$menuLayout['operacoes_eleitorais']['itens'])", $layout);
        $this->assertStringContainsString('id="operacoesEleitoraisDropdown"', $layout);
        $this->assertStringContainsString("\$menuLayout['operacoes_eleitorais']['label']", $layout);
        $this->assertStringContainsString("\$menuLayout['operacoes_eleitorais']['itens'] as \$itemMenu", $layout);
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAMENUTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaMigrationsTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAMIGRATIONSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaMigrationsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaMigrationsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function migrations_separam_dominios_negocio_acesso_e_acl(): void
public function migrations_executadas_exclusivamente_estao_registradas_no_contrato(): void
public function nomes_de_constraints_sao_compativeis_com_oracle_legado(): void
public function revisao_do_formulario_preserva_legado_e_adiciona_campos_estruturados(): void
public function revisao_da_acl_substitui_codigo_por_protocolo_e_vincula_os_dois_grupos(): void
private function migration(string $arquivo): string
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

class SeuVotoImportaMigrationsTest extends TestCase
{
    #[Test]
    public function migrations_separam_dominios_negocio_acesso_e_acl(): void
    {
        $dominios = $this->migration('2026_08_21_160000_create_svi_domain_tables.php');
        $negocio = $this->migration('2026_08_21_161000_create_svi_business_tables.php');
        $acesso = $this->migration('2026_08_21_162000_create_svi_access_tables.php');
        $acl = $this->migration('2026_08_21_163000_grant_svi_acl.php');

        foreach (['SVI_SOLICITANTE_TIPO', 'SVI_CONTATO_PREFERENCIA', 'SVI_CONDICAO',
            'SVI_EQUIPAMENTO', 'SVI_SOLICITACAO_STATUS', 'SVI_TURNO_STATUS'] as $tabela) {
            $this->assertStringContainsString("'{$tabela}' =>", $dominios);
        }
        $this->assertStringContainsString('CREATE TABLE {$tabela}', $dominios);
        $this->assertStringNotContainsString('CONSTRAINT CK_{$tabela}', $dominios);

        foreach (['SVI_CONFIGURACAO', 'SVI_SOLICITACAO', 'SVI_SOLICITACAO_CONDICAO',
            'SVI_SOLICITACAO_EQUIP', 'SVI_SOLICITACAO_TURNO', 'SVI_ANEXO', 'SVI_HISTORICO'] as $tabela) {
            $this->assertStringContainsString('CREATE TABLE '.$tabela, $negocio);
        }
        $this->assertStringContainsString('UNIQUE (MACROPROJETO_ID, NUM_INSCRICAO)', $negocio);

        $this->assertStringContainsString('CREATE TABLE SVI_ACESSO_DESAFIO', $acesso);
        $this->assertStringContainsString('CODIGO_HMAC', $acesso);
        $this->assertStringContainsString('TENTATIVAS', $acesso);
        $this->assertStringContainsString('CREATE TABLE SVI_NOTIFICACAO', $acesso);

        $this->assertStringContainsString('PLANELEITO_SEU_VOTO_IMPORTA_GESTOR', $acl);
        $this->assertStringContainsString("'ignora_unidades_permitidas' => 0", $acl);
        $this->assertStringContainsString("'seu-voto-importa.admin.index'", $acl);
        $this->assertStringContainsString("'seu-voto-importa.publico.acompanhamento'", $acl);
        $this->assertStringContainsString('PLANELEITO_ADMIN', $acl);
    }

    #[Test]
    public function migrations_executadas_exclusivamente_estao_registradas_no_contrato(): void
    {
        $contrato = (string) file_get_contents(base_path('docs/contratos/migrations-exclusivas.md'));

        foreach ([
            '2026_08_21_160000_create_svi_domain_tables.php`, lote 313',
            '2026_08_21_161000_create_svi_business_tables.php`, lote 314',
            '2026_08_21_162000_create_svi_access_tables.php`, lote 315',
            '2026_08_21_163000_grant_svi_acl.php`, lote 316',
        ] as $registro) {
            $this->assertStringContainsString($registro, $contrato);
        }
        $this->assertStringContainsString('Não foi usado `migrate` global', $contrato);
    }

    #[Test]
    public function nomes_de_constraints_sao_compativeis_com_oracle_legado(): void
    {
        foreach (glob(database_path('migrations/2026_08_21_16*_svi_*.php')) ?: [] as $arquivo) {
            $conteudo = (string) file_get_contents($arquivo);
            preg_match_all('/CONSTRAINT\s+([A-Z0-9_]+)/', $conteudo, $matches);

            foreach ($matches[1] as $nome) {
                $this->assertLessThanOrEqual(30, strlen($nome), basename($arquivo).': '.$nome);
            }
        }
    }

    #[Test]
    public function revisao_do_formulario_preserva_legado_e_adiciona_campos_estruturados(): void
    {
        $migration = $this->migration('2026_08_27_214000_evolve_svi_public_form.php');

        $this->assertStringContainsString('ELEITOR_EMAIL NULL', $migration);
        foreach ([
            'END_ALT_LOGRADOURO',
            'END_ALT_NUMERO',
            'END_ALT_BAIRRO',
            'END_ALT_REFERENCIA',
            'AUTODECLARACAO_TEXTO',
            'IMPACTO_DESCRICAO',
        ] as $coluna) {
            $this->assertStringContainsString($coluna, $migration);
        }

        $this->assertStringContainsString('Rollback recusado', $migration);
        $this->assertStringNotContainsString('DROP TABLE SVI_ACESSO_DESAFIO', $migration);
        $this->assertStringNotContainsString('DROP TABLE SVI_NOTIFICACAO', $migration);
    }

    #[Test]
    public function revisao_da_acl_substitui_codigo_por_protocolo_e_vincula_os_dois_grupos(): void
    {
        $migration = $this->migration('2026_08_27_215000_replace_svi_code_access_with_protocol_acl.php');

        foreach ([
            'seu-voto-importa.publico.acesso.form',
            'seu-voto-importa.publico.acesso.entrar',
            'seu-voto-importa.publico.representante.identificar',
            'PLANELEITO_SEU_VOTO_IMPORTA_GESTOR',
            'PLANELEITO_ADMIN',
        ] as $valor) {
            $this->assertStringContainsString($valor, $migration);
        }

        foreach ([
            'seu-voto-importa.publico.codigo.form',
            'seu-voto-importa.publico.codigo.solicitar',
            'seu-voto-importa.publico.codigo.validar.form',
            'seu-voto-importa.publico.codigo.validar',
            'seu-voto-importa.admin.codigo.reenviar',
        ] as $rotaLegada) {
            $this->assertStringContainsString($rotaLegada, $migration);
        }
        $this->assertStringContainsString("'ativo' => 0", $migration);
    }

    private function migration(string $arquivo): string
    {
        return (string) file_get_contents(database_path('migrations/'.$arquivo));
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAMIGRATIONSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaRequestsTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTAREQUESTSTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaRequestsTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaRequestsTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function identificacao_normaliza_titulo_e_data_brasileira_e_exige_turnstile(): void
public function formulario_exige_endereco_alternativo_estruturado_quando_veiculo_nao_chega(): void
public function formulario_exige_detalhes_condicionais_e_impede_nenhum_equipamento_com_outro(): void
public function formulario_nao_exige_email_referencia_ou_texto_livre_e_exige_impacto(): void
public function protocolo_e_representante_usam_normalizacoes_centrais(): void
public function formulario_completo_valido_nao_depende_de_email(): void
public function formulario_exige_escolha_do_solicitante_e_da_comprovacao(): void
public function formulario_exige_arquivo_somente_na_comprovacao_por_anexo(): void
private function solicitacaoValida(): array
private function validator(string $requestClass, array $dados): LaravelValidator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Requests\SeuVotoImporta\SeuVotoImportaIdentificacaoRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaProtocoloRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaRepresentanteRequest;
use App\Http\Requests\SeuVotoImporta\SeuVotoImportaSolicitacaoStoreRequest;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Validator as LaravelValidator;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaRequestsTest extends TestCase
{
    #[Test]
    public function identificacao_normaliza_titulo_e_data_brasileira_e_exige_turnstile(): void
    {
        $validator = $this->validator(SeuVotoImportaIdentificacaoRequest::class, [
            'num_inscricao' => '123 456 789',
            'dt_nascimento' => '20/05/1990',
            'cf-turnstile-response' => 'token-turnstile',
        ]);

        $this->assertFalse($validator->fails(), (string) $validator->errors()->first());
        $this->assertSame('000123456789', $validator->validated()['num_inscricao']);
        $this->assertSame('1990-05-20', $validator->validated()['dt_nascimento']);

        $semTurnstile = $this->validator(SeuVotoImportaIdentificacaoRequest::class, [
            'num_inscricao' => '123456789',
            'dt_nascimento' => '1990-05-20',
        ]);
        $this->assertTrue($semTurnstile->errors()->has('cf-turnstile-response'));
    }

    #[Test]
    public function formulario_exige_endereco_alternativo_estruturado_quando_veiculo_nao_chega(): void
    {
        $dados = $this->solicitacaoValida();
        $dados['veiculo_acessa_codigo'] = 'NAO';
        unset($dados['endereco_alt_logradouro']);

        $validator = $this->validator(SeuVotoImportaSolicitacaoStoreRequest::class, $dados);

        $this->assertTrue($validator->errors()->has('endereco_alt_logradouro'));
    }

    #[Test]
    public function formulario_exige_detalhes_condicionais_e_impede_nenhum_equipamento_com_outro(): void
    {
        $dados = $this->solicitacaoValida();
        $dados['condicoes'] = ['MOBILIDADE_REDUZIDA'];
        $dados['equipamentos'] = ['NENHUM', 'BENGALA'];

        $validator = $this->validator(SeuVotoImportaSolicitacaoStoreRequest::class, $dados);

        $this->assertTrue($validator->errors()->has('condicao_descricao'));
        $this->assertTrue($validator->errors()->has('equipamentos'));
    }

    #[Test]
    public function formulario_nao_exige_email_referencia_ou_texto_livre_e_exige_impacto(): void
    {
        $dados = $this->solicitacaoValida();
        unset($dados['endereco_referencia'], $dados['autodeclaracao_texto'], $dados['impacto_descricao']);

        $validator = $this->validator(SeuVotoImportaSolicitacaoStoreRequest::class, $dados);

        $this->assertFalse($validator->errors()->has('endereco_referencia'));
        $this->assertFalse($validator->errors()->has('eleitor_email'));
        $this->assertFalse($validator->errors()->has('autodeclaracao_texto'));
        $this->assertTrue($validator->errors()->has('impacto_descricao'));
    }

    #[Test]
    public function protocolo_e_representante_usam_normalizacoes_centrais(): void
    {
        $protocolo = $this->validator(SeuVotoImportaProtocoloRequest::class, [
            'protocolo' => ' svi-2026-abcdef123456 ',
            'cf-turnstile-response' => 'token-turnstile',
        ]);
        $this->assertFalse($protocolo->fails(), (string) $protocolo->errors()->first());
        $this->assertSame('SVI-2026-ABCDEF123456', $protocolo->validated()['protocolo']);

        $representante = $this->validator(SeuVotoImportaRepresentanteRequest::class, [
            'solicitante_titulo' => '123 456 789',
            'solicitante_dt_nascimento' => '20/05/1990',
        ]);
        $this->assertFalse($representante->fails(), (string) $representante->errors()->first());
        $this->assertSame('000123456789', $representante->validated()['solicitante_titulo']);
        $this->assertSame('1990-05-20', $representante->validated()['solicitante_dt_nascimento']);

        $semNascimento = $this->validator(SeuVotoImportaRepresentanteRequest::class, [
            'solicitante_titulo' => '123 456 789',
        ]);
        $this->assertTrue($semNascimento->errors()->has('solicitante_dt_nascimento'));
    }

    #[Test]
    public function formulario_completo_valido_nao_depende_de_email(): void
    {
        $validator = $this->validator(SeuVotoImportaSolicitacaoStoreRequest::class, $this->solicitacaoValida());

        $this->assertFalse($validator->fails(), $validator->errors()->toJson(JSON_UNESCAPED_UNICODE));
        $this->assertArrayNotHasKey('eleitor_email', $validator->validated());
        $this->assertArrayNotHasKey('autodeclaracao_texto', $validator->validated());
    }

    #[Test]
    public function formulario_exige_escolha_do_solicitante_e_da_comprovacao(): void
    {
        $dados = $this->solicitacaoValida();
        $dados['solicitante_tipo_codigo'] = '';
        $dados['comprovacao_tipo_codigo'] = '';

        $validator = $this->validator(SeuVotoImportaSolicitacaoStoreRequest::class, $dados);

        $this->assertTrue($validator->errors()->has('solicitante_tipo_codigo'));
        $this->assertTrue($validator->errors()->has('comprovacao_tipo_codigo'));
    }

    #[Test]
    public function formulario_exige_arquivo_somente_na_comprovacao_por_anexo(): void
    {
        $dados = $this->solicitacaoValida();
        $dados['comprovacao_tipo_codigo'] = 'ANEXO';

        $validator = $this->validator(SeuVotoImportaSolicitacaoStoreRequest::class, $dados);

        $this->assertTrue($validator->errors()->has('comprovante_condicao'));
    }

    /** @return array<string, mixed> */
    private function solicitacaoValida(): array
    {
        return [
            'solicitante_tipo_codigo' => 'ELEITOR',
            'eleitor_telefone' => '(68) 99999-8888',
            'contato_preferencia_codigo' => 'WHATSAPP',
            'endereco_logradouro' => 'Rua das Flores',
            'endereco_numero' => '100',
            'endereco_bairro' => 'Centro',
            'endereco_municipio' => 'Rio Branco',
            'endereco_referencia' => 'Próximo à praça',
            'veiculo_acessa_codigo' => 'SIM',
            'declaracao_espera' => '1',
            'condicoes' => ['FISICA'],
            'comprovacao_tipo_codigo' => 'AUTODECLARACAO',
            'autodeclaracao_texto' => 'Texto forjado que não pode integrar os dados validados.',
            'impacto_codigo' => 'DIFICULTA',
            'impacto_descricao' => 'Dificulta o deslocamento sem apoio de transporte.',
            'equipamentos' => ['CADEIRA_MANUAL'],
            'transporte_publico_codigo' => 'NAO',
            'acompanhante_codigo' => 'NAO',
            'segundo_turno_codigo' => 'SIM',
            'declaracao_sem_transporte' => '1',
            'declaracao_analise' => '1',
            'declaracao_sem_ajudante' => '1',
            'declaracao_compartilhado' => '1',
            'declaracao_horario' => '1',
            'declaracao_privacidade' => '1',
            'declaracao_endereco_responsabilidade' => '1',
            'declaracao_endereco_acesso' => '1',
            'declaracao_veracidade' => '1',
            'cf-turnstile-response' => 'token-turnstile',
        ];
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
        $validator = Validator::make($request->all(), $request->rules(), $request->messages());

        if (method_exists($request, 'withValidator')) {
            $request->withValidator($validator);
        }

        return $validator;
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTAREQUESTSTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaSessionServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTASESSIONSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaSessionServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaSessionServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function autentica_somente_a_solicitacao_e_aplica_prazos_absoluto_e_de_inatividade(): void
public function tocar_renova_atividade_sem_ampliar_o_prazo_absoluto(): void
private function requestComSessao(): Request
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\SeuVotoImporta\SeuVotoImportaSessionService;
use Carbon\CarbonImmutable;
use Illuminate\Http\Request;
use Illuminate\Session\ArraySessionHandler;
use Illuminate\Session\Store;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaSessionServiceTest extends TestCase
{
    #[Test]
    public function autentica_somente_a_solicitacao_e_aplica_prazos_absoluto_e_de_inatividade(): void
    {
        CarbonImmutable::setTestNow('2026-08-21 10:00:00');
        $request = $this->requestComSessao();
        $service = new SeuVotoImportaSessionService;

        $service->iniciar($request, 42);

        $this->assertSame(42, $service->solicitacaoId($request));
        $this->assertTrue($service->autenticado($request));
        $this->assertNull($request->session()->get('matchingGroups'));

        CarbonImmutable::setTestNow('2026-08-21 10:29:59');
        $this->assertTrue($service->autenticado($request));

        CarbonImmutable::setTestNow('2026-08-21 10:30:01');
        $this->assertFalse($service->autenticado($request));

        CarbonImmutable::setTestNow();
    }

    #[Test]
    public function tocar_renova_atividade_sem_ampliar_o_prazo_absoluto(): void
    {
        CarbonImmutable::setTestNow('2026-08-21 10:00:00');
        $request = $this->requestComSessao();
        $service = new SeuVotoImportaSessionService;
        $service->iniciar($request, 42);

        CarbonImmutable::setTestNow('2026-08-21 10:20:00');
        $service->tocar($request);

        CarbonImmutable::setTestNow('2026-08-21 10:49:00');
        $this->assertTrue($service->autenticado($request));

        CarbonImmutable::setTestNow('2026-08-21 12:00:01');
        $this->assertFalse($service->autenticado($request));

        CarbonImmutable::setTestNow();
    }

    private function requestComSessao(): Request
    {
        $request = Request::create('/rotas-publicas/seu-voto-importa/acompanhamento', 'GET');
        $request->setLaravelSession(new Store('array', new ArraySessionHandler(120)));

        return $request;
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTASESSIONSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaSolicitacaoServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTASOLICITACAOSERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaSolicitacaoServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaSolicitacaoServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function cria_pedido_com_snapshot_permitido_e_primeiro_turno(): void
public function devolve_pedido_existente_sem_criar_duplicata(): void
public function inclui_metadados_de_anexos_previamente_colocados_em_quarentena(): void
public function descarta_campos_condicionais_quando_a_condicao_nao_foi_acionada(): void
private function contexto(): array
private function dados(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use App\Services\SeuVotoImporta\SeuVotoImportaSolicitacaoService;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaSolicitacaoServiceTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function cria_pedido_com_snapshot_permitido_e_primeiro_turno(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarPorMacroTitulo')->once()->with(15, '000123456789')->andReturn(null);
        $repository->shouldReceive('criarCompleta')->once()->with(
            Mockery::on(static fn (array $dados): bool => $dados['MACROPROJETO_ID'] === 15
                && $dados['STATUS_CODIGO'] === 'RECEBIDA'
                && $dados['ELEITOR_EMAIL'] === null
                && $dados['ENDERECO_MUNICIPIO'] === 'RIO BRANCO'
                && $dados['ENDERECO_ALTERNATIVO'] === null
                && $dados['AUTODECLARACAO_TEXTO'] === null
                && $dados['IMPACTO_DESCRICAO'] === 'Dificulta a ida ao local de votação.'
                && !array_key_exists('DES_ENDERECO', $dados)),
            ['FISICA'],
            ['CADEIRA_MANUAL'],
            Mockery::on(static fn (array $turnos): bool => count($turnos) === 1
                && $turnos[0]['NUMERO_TURNO'] === 1
                && $turnos[0]['STATUS_CODIGO'] === 'AGUARDANDO_AGENDAMENTO'),
            []
        )->andReturn(77);

        $resultado = (new SeuVotoImportaSolicitacaoService($repository))->criar(
            $this->contexto(),
            $this->dados(),
        );

        $this->assertSame(77, $resultado['id']);
        $this->assertFalse($resultado['duplicada']);
        $this->assertMatchesRegularExpression('/^SVI-2026-[A-F0-9]{12}$/', $resultado['protocolo']);
    }

    #[Test]
    public function devolve_pedido_existente_sem_criar_duplicata(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarPorMacroTitulo')->once()->andReturn([
            'id' => 18, 'protocolo' => 'SVI-2026-EXISTENTE01',
        ]);
        $repository->shouldNotReceive('criarCompleta');

        $resultado = (new SeuVotoImportaSolicitacaoService($repository))->criar($this->contexto(), $this->dados());

        $this->assertSame(18, $resultado['id']);
        $this->assertTrue($resultado['duplicada']);
        $this->assertNull($resultado['protocolo']);
    }

    #[Test]
    public function inclui_metadados_de_anexos_previamente_colocados_em_quarentena(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarPorMacroTitulo')->once()->andReturn(null);
        $repository->shouldReceive('criarCompleta')->once()->with(
            Mockery::type('array'), ['FISICA'], ['CADEIRA_MANUAL'], Mockery::type('array'),
            Mockery::on(static fn (array $anexos): bool => count($anexos) === 1
                && $anexos[0]['CATEGORIA'] === 'CONDICAO'
                && $anexos[0]['SCAN_STATUS'] === 'PENDENTE')
        )->andReturn(79);

        $resultado = (new SeuVotoImportaSolicitacaoService($repository))->criar(
            $this->contexto(),
            $this->dados(),
            [[
                'CATEGORIA' => 'CONDICAO', 'CAMINHO' => 'seu-voto-importa/quarentena/x.pdf',
                'SCAN_STATUS' => 'PENDENTE',
            ]],
        );

        $this->assertSame(79, $resultado['id']);
    }

    #[Test]
    public function descarta_campos_condicionais_quando_a_condicao_nao_foi_acionada(): void
    {
        $repository = Mockery::mock(SeuVotoImportaSolicitacaoRepository::class);
        $repository->shouldReceive('buscarPorMacroTitulo')->once()->andReturn(null);
        $repository->shouldReceive('criarCompleta')->once()->with(
            Mockery::on(static fn (array $dados): bool => $dados['SOLICITANTE_NOME'] === null
                && $dados['SOLICITANTE_TITULO'] === null
                && $dados['SOLICITANTE_TELEFONE'] === null
                && $dados['ENDERECO_ALTERNATIVO'] === null
                && $dados['END_ALT_LOGRADOURO'] === null
                && $dados['END_ALT_NUMERO'] === null
                && $dados['END_ALT_BAIRRO'] === null
                && $dados['END_ALT_REFERENCIA'] === null
                && $dados['CONDICAO_DESCRICAO'] === null
                && $dados['AUTODECLARACAO_TEXTO'] === null
                && $dados['EQUIPAMENTO_OUTRO'] === null
                && $dados['ACOMPANHANTE_NOME'] === null
                && $dados['ACOMPANHANTE_TELEFONE'] === null),
            ['FISICA'],
            ['CADEIRA_MANUAL'],
            Mockery::type('array'),
            [],
        )->andReturn(80);

        $dados = array_replace($this->dados(), [
            'solicitante_nome' => 'Não deve persistir',
            'solicitante_titulo' => '000123456789',
            'solicitante_telefone' => '68999998888',
            'endereco_alt_logradouro' => 'Não deve persistir',
            'endereco_alt_numero' => '10',
            'endereco_alt_bairro' => 'Não deve persistir',
            'endereco_alt_referencia' => 'Não deve persistir',
            'condicao_descricao' => 'Não deve persistir',
            'autodeclaracao_texto' => 'Não deve persistir',
            'comprovacao_tipo_codigo' => 'ANEXO',
            'equipamento_outro' => 'Não deve persistir',
            'acompanhante_nome' => 'Não deve persistir',
            'acompanhante_telefone' => '68999998888',
        ]);

        $resultado = (new SeuVotoImportaSolicitacaoService($repository))->criar($this->contexto(), $dados);

        $this->assertSame(80, $resultado['id']);
    }

    /** @return array<string, mixed> */
    private function contexto(): array
    {
        return [
            'num_inscricao' => '000123456789', 'nome' => 'Eleitora Teste',
            'dt_nascimento' => '1990-05-20', 'idade' => 36,
            'zona_numero' => 1, 'secao_numero' => '101',
            'local_cod_objeto' => 'LOCAL-1', 'local_numero' => 10,
            'local_nome' => 'Escola Teste', 'local_endereco' => 'Rua do local',
            'municipio_nome' => 'Rio Branco', 'configuracao_id' => 4,
            'macroprojeto_id' => 15, 'dt_primeiro_turno' => '2026-10-04',
            'dt_segundo_turno' => '2026-10-25', 'segundo_turno_confirmado' => false,
        ];
    }

    /** @return array<string, mixed> */
    private function dados(): array
    {
        return [
            'solicitante_tipo_codigo' => 'ELEITOR', 'eleitor_telefone' => '68999998888',
            'contato_preferencia_codigo' => 'WHATSAPP',
            'endereco_logradouro' => 'Rua das Flores', 'endereco_numero' => '100',
            'endereco_bairro' => 'Centro', 'endereco_municipio' => 'Rio Branco',
            'endereco_referencia' => 'Próximo à praça', 'veiculo_acessa_codigo' => 'SIM',
            'condicoes' => ['FISICA'], 'comprovacao_tipo_codigo' => 'AUTODECLARACAO',
            'autodeclaracao_texto' => 'A condição exige transporte adequado.',
            'impacto_codigo' => 'DIFICULTA',
            'impacto_descricao' => 'Dificulta a ida ao local de votação.',
            'equipamentos' => ['CADEIRA_MANUAL'],
            'transporte_publico_codigo' => 'NAO', 'acompanhante_codigo' => 'NAO',
            'segundo_turno_codigo' => 'SIM',
        ];
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTASOLICITACAOSERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaStatusCatalogoRepositoryTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTASTATUSCATALOGOREPOSITORYTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaStatusCatalogoRepositoryTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaStatusCatalogoRepositoryTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
Schema::create($tabela, static function (Blueprint $table): void {
DB::table('SVI_SOLICITACAO_STATUS')->insert([
DB::table('SVI_TURNO_STATUS')->insert([
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function setUp(): void
protected function tearDown(): void
public function mapeia_catalogos_de_estado_sem_depender_do_casing_retornado_pelo_driver(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Repositories\SeuVotoImporta\SeuVotoImportaSolicitacaoRepository;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaStatusCatalogoRepositoryTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        foreach (['SVI_SOLICITACAO_STATUS', 'SVI_TURNO_STATUS'] as $tabela) {
            Schema::create($tabela, static function (Blueprint $table): void {
                $table->string('codigo');
                $table->string('descricao');
                $table->unsignedTinyInteger('ativo');
                $table->unsignedTinyInteger('ordem');
            });
        }
    }

    protected function tearDown(): void
    {
        Schema::dropIfExists('SVI_TURNO_STATUS');
        Schema::dropIfExists('SVI_SOLICITACAO_STATUS');

        parent::tearDown();
    }

    #[Test]
    public function mapeia_catalogos_de_estado_sem_depender_do_casing_retornado_pelo_driver(): void
    {
        DB::table('SVI_SOLICITACAO_STATUS')->insert([
            ['codigo' => 'DEFERIDA', 'descricao' => 'Deferida', 'ativo' => 1, 'ordem' => 2],
            ['codigo' => 'RECEBIDA', 'descricao' => 'Recebida', 'ativo' => 1, 'ordem' => 1],
            ['codigo' => 'INATIVA', 'descricao' => 'Inativa', 'ativo' => 0, 'ordem' => 3],
        ]);
        DB::table('SVI_TURNO_STATUS')->insert([
            ['codigo' => 'CONCLUIDA', 'descricao' => 'Concluída', 'ativo' => 1, 'ordem' => 2],
            ['codigo' => 'AGUARDANDO', 'descricao' => 'Aguardando', 'ativo' => 1, 'ordem' => 1],
        ]);

        $repository = app(SeuVotoImportaSolicitacaoRepository::class);

        $this->assertSame([
            'RECEBIDA' => 'Recebida',
            'DEFERIDA' => 'Deferida',
        ], $repository->statusSolicitacao());
        $this->assertSame([
            'AGUARDANDO' => 'Aguardando',
            'CONCLUIDA' => 'Concluída',
        ], $repository->statusTurno());
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTASTATUSCATALOGOREPOSITORYTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/SeuVotoImportaTurnstileServiceTest.php`
## <TESTS_UNIT_SEUVOTOIMPORTATURNSTILESERVICETEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/SeuVotoImportaTurnstileServiceTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class SeuVotoImportaTurnstileServiceTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function aceita_somente_resposta_com_acao_e_hostname_esperados(): void
public function falha_fechado_quando_provedor_esta_indisponivel(): void
public function rejeita_chaves_de_teste_em_producao(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\SeuVotoImporta\SeuVotoImportaTurnstileService;
use Illuminate\Support\Facades\Http;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class SeuVotoImportaTurnstileServiceTest extends TestCase
{
    #[Test]
    public function aceita_somente_resposta_com_acao_e_hostname_esperados(): void
    {
        config()->set('planeleito.seu_voto_importa.turnstile', [
            'site_key' => 'site-key-realista',
            'secret_key' => 'segredo',
            'hostname' => 'planeleito.tre-ac.jus.br',
            'timeout' => 3,
        ]);
        Http::fake([
            'challenges.cloudflare.com/*' => Http::response([
                'success' => true,
                'action' => 'svi_identificar',
                'hostname' => 'planeleito.tre-ac.jus.br',
            ]),
        ]);

        $service = new SeuVotoImportaTurnstileService;

        $this->assertTrue($service->validar('token', 'svi_identificar', '127.0.0.1'));
        $this->assertFalse($service->validar('token', 'outra_acao', '127.0.0.1'));
    }

    #[Test]
    public function falha_fechado_quando_provedor_esta_indisponivel(): void
    {
        config()->set('planeleito.seu_voto_importa.turnstile', [
            'site_key' => 'site-key-realista',
            'secret_key' => 'segredo',
            'hostname' => 'planeleito.tre-ac.jus.br',
            'timeout' => 3,
        ]);
        Http::fake(fn () => Http::response([], 503));

        $this->assertFalse((new SeuVotoImportaTurnstileService)->validar('token', 'svi_identificar', null));
    }

    #[Test]
    public function rejeita_chaves_de_teste_em_producao(): void
    {
        config()->set('app.env', 'production');
        config()->set('planeleito.seu_voto_importa.turnstile', [
            'site_key' => '1x00000000000000000000AA',
            'secret_key' => '1x0000000000000000000000000000000AA',
            'hostname' => 'planeleito.tre-ac.jus.br',
            'timeout' => 3,
        ]);

        $service = new SeuVotoImportaTurnstileService;

        $this->assertFalse($service->configurado());
        $this->assertFalse($service->validar('token', 'svi_identificar', '127.0.0.1'));
        Http::assertNothingSent();
    }
}
```
</TESTS_UNIT_SEUVOTOIMPORTATURNSTILESERVICETEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/TarefaMonitoramentoPublicoUiTest.php`
## <TESTS_UNIT_TAREFAMONITORAMENTOPUBLICOUITEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/TarefaMonitoramentoPublicoUiTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class TarefaMonitoramentoPublicoUiTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function test_view_publica_expoe_grafico_de_pizza_de_status(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use Tests\TestCase;

class TarefaMonitoramentoPublicoUiTest extends TestCase
{
    public function test_view_publica_expoe_grafico_de_pizza_de_status(): void
    {
        $conteudo = file_get_contents(resource_path('views/planejamento/tarefas/monitoramento_publico.blade.php'));

        $this->assertIsString($conteudo);
        $this->assertStringContainsString('chartStatusTarefasPublico', $conteudo);
        $this->assertStringContainsString('Distribuição de status das tarefas', $conteudo);
        $this->assertStringContainsString('rotas-publicas/vendor/chartjs/chart.umd.min.js', $conteudo);
        $this->assertStringContainsString('new Chart(canvas, {', $conteudo);
        $this->assertStringContainsString('@json($statusDistribuicao ?? [])', $conteudo);
        $this->assertStringContainsString("type: 'pie'", $conteudo);
    }
}
```
</TESTS_UNIT_TAREFAMONITORAMENTOPUBLICOUITEST_PHP>

