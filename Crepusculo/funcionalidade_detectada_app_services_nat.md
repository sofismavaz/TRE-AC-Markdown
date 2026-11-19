# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_services_nat`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 6  
> **Tamanho do Arquivo:** 20 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatAtribuicaoService.php`
## <APP_SERVICES_NAT_NATATRIBUICAOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatAtribuicaoService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatAtribuicaoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly NatLocalSecaoRepository $localSecaoRepository)
public function resolverOuValidarRota(string $codObjetoLocal, ?int $rotaIdInformada): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Repositories\Nat\NatLocalSecaoRepository;
use RuntimeException;

class NatAtribuicaoService
{
    public function __construct(private readonly NatLocalSecaoRepository $localSecaoRepository)
    {
    }

    public function resolverOuValidarRota(string $codObjetoLocal, ?int $rotaIdInformada): array
    {
        $local = $this->localSecaoRepository->buscarLocal($codObjetoLocal);
        if ($local === null) {
            throw new RuntimeException('Local de votação não encontrado.');
        }

        $rotaAutomatica = $this->localSecaoRepository->buscarRotaAutomaticaPorLocal($codObjetoLocal);
        if ($rotaAutomatica !== null) {
            return [
                'rota_id' => (int) $rotaAutomatica->id,
                'zona_id' => (int) $local->zona_id,
                'municipio_id' => (int) $local->municipio_id,
                'automatica' => true,
            ];
        }

        if ($rotaIdInformada === null || $rotaIdInformada <= 0) {
            throw new RuntimeException('Selecione a rota responsável pela ocorrência.');
        }

        $rotasElegiveis = collect($this->localSecaoRepository->listarRotasElegiveisPorLocal($codObjetoLocal))
            ->map(static fn ($rota) => (int) ($rota['id'] ?? 0))
            ->filter(static fn ($id) => $id > 0)
            ->values();

        if (!$rotasElegiveis->contains($rotaIdInformada)) {
            throw new RuntimeException('A rota informada não pertence à mesma zona e município do local de votação.');
        }

        return [
            'rota_id' => $rotaIdInformada,
            'zona_id' => (int) $local->zona_id,
            'municipio_id' => (int) $local->municipio_id,
            'automatica' => false,
        ];
    }
}
```
</APP_SERVICES_NAT_NATATRIBUICAOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatEscopoService.php`
## <APP_SERVICES_NAT_NATESCOPOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatEscopoService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatEscopoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function zonasPermitidas(): array
public function acessoTodasZonas(): bool
public function escopo(): EscopoZonal
public function usuarioAuditoria(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Support\Access\EscopoZonal;

class NatEscopoService
{
    public function zonasPermitidas(): array
    {
        return $this->escopo()->zonas();
    }

    public function acessoTodasZonas(): bool
    {
        return $this->escopo()->acessoTodas();
    }

    public function escopo(): EscopoZonal
    {
        return EscopoZonal::from(
            (array) session('cod_zonas_permitidas', []),
            session('acesso_todas_zonas') === true,
        );
    }

    public function usuarioAuditoria(): array
    {
        return [
            'login' => trim((string) session('user.username', '')) ?: null,
            'nome' => trim((string) session('user.name', '')) ?: null,
        ];
    }
}
```
</APP_SERVICES_NAT_NATESCOPOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatOcorrenciaBadgeService.php`
## <APP_SERVICES_NAT_NATOCORRENCIABADGESERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatOcorrenciaBadgeService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatOcorrenciaBadgeService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly NatOcorrenciaRepository $repository)
public function resumo(array $rotas, array $zonasPermitidas, bool $acessoTodasZonas, Request $request): array
public function marcarVisualizadas(array $rotas, array $zonasPermitidas, bool $acessoTodasZonas, Request $request): void
private function normalizarRotaIds(array $rotas): array
private function visualizadasPorRota(Request $request): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Repositories\Nat\NatOcorrenciaRepository;
use Illuminate\Http\Request;

class NatOcorrenciaBadgeService
{
    private const SESSION_KEY = 'nat_ocorrencias_visualizadas_por_rota';

    public function __construct(private readonly NatOcorrenciaRepository $repository)
    {
    }

    public function resumo(array $rotas, array $zonasPermitidas, bool $acessoTodasZonas, Request $request): array
    {
        $rotaIds = $this->normalizarRotaIds($rotas);
        if ($rotaIds === []) {
            return [
                'total_abertas' => 0,
                'total_novas' => 0,
            ];
        }

        return [
            'total_abertas' => $this->repository->contarNaoFinalizadasPorRotas(
                $rotaIds,
                $zonasPermitidas,
                $acessoTodasZonas
            ),
            'total_novas' => $this->repository->contarNovasNaoFinalizadasPorRotas(
                $rotaIds,
                $this->visualizadasPorRota($request),
                $zonasPermitidas,
                $acessoTodasZonas
            ),
        ];
    }

    public function marcarVisualizadas(array $rotas, array $zonasPermitidas, bool $acessoTodasZonas, Request $request): void
    {
        $rotaIds = $this->normalizarRotaIds($rotas);
        if ($rotaIds === []) {
            return;
        }

        $atuais = $this->visualizadasPorRota($request);
        foreach ($this->repository->maiorNaoFinalizadaPorRotas($rotaIds, $zonasPermitidas, $acessoTodasZonas) as $rotaId => $maiorId) {
            $rotaId = (int) $rotaId;
            $maiorId = (int) $maiorId;
            if ($rotaId <= 0 || $maiorId <= 0) {
                continue;
            }

            $atuais[$rotaId] = max((int) ($atuais[$rotaId] ?? 0), $maiorId);
        }

        $request->session()->put(self::SESSION_KEY, $atuais);
    }

    private function normalizarRotaIds(array $rotas): array
    {
        return collect($rotas)
            ->map(static fn ($rota) => is_array($rota) ? ($rota['id'] ?? null) : $rota)
            ->map(static fn ($valor) => is_numeric($valor) ? (int) $valor : null)
            ->filter(static fn ($valor) => is_int($valor) && $valor > 0)
            ->unique()
            ->values()
            ->all();
    }

    private function visualizadasPorRota(Request $request): array
    {
        $dados = $request->session()->get(self::SESSION_KEY, []);
        if (!is_array($dados)) {
            return [];
        }

        return collect($dados)
            ->mapWithKeys(static fn ($valor, $rotaId) => is_numeric($rotaId) && is_numeric($valor)
                ? [(int) $rotaId => (int) $valor]
                : [])
            ->filter(static fn ($valor, $rotaId) => $rotaId > 0 && $valor > 0)
            ->all();
    }
}
```
</APP_SERVICES_NAT_NATOCORRENCIABADGESERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatOcorrenciaEventoService.php`
## <APP_SERVICES_NAT_NATOCORRENCIAEVENTOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatOcorrenciaEventoService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatOcorrenciaEventoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function registrar(array $dados): int
public function listarPorOcorrencia(int $idOcorrencia): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Repositories\Nat\NatOcorrenciaEventoRepository;

class NatOcorrenciaEventoService
{
    public function __construct(
        private readonly NatOcorrenciaEventoRepository $repository,
        private readonly NatEscopoService $escopoService,
    ) {
    }

    public function registrar(array $dados): int
    {
        $usuario = $this->escopoService->usuarioAuditoria();

        return $this->repository->criar($dados + [
            'usuario_criacao' => $usuario['login'],
            'usuario_nome_criacao' => $usuario['nome'],
        ]);
    }

    public function listarPorOcorrencia(int $idOcorrencia): array
    {
        return $this->repository->listarPorOcorrencia($idOcorrencia);
    }
}
```
</APP_SERVICES_NAT_NATOCORRENCIAEVENTOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatOcorrenciaService.php`
## <APP_SERVICES_NAT_NATOCORRENCIASERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatOcorrenciaService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatOcorrenciaService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$statusAtribuida = DB::table('nat_status_ocorrencia')->where('codigo', 'ATRIBUIDA')->value('id_status');
$statusNovo = (int) DB::table('nat_status_ocorrencia')->where('codigo', 'EM_ANDAMENTO')->value('id_status');
$statusNovo = (int) DB::table('nat_status_ocorrencia')->where('codigo', 'FINALIZADA')->value('id_status');
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function abrir(array $dados): int
public function iniciarAtendimento(int $idOcorrencia, ?int $rotaId = null): void
public function finalizar(int $idOcorrencia, string $descricaoResolucao, ?int $rotaId = null): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Repositories\Nat\NatLocalSecaoRepository;
use App\Repositories\Nat\NatOcorrenciaRepository;
use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class NatOcorrenciaService
{
    public function __construct(
        private readonly NatOcorrenciaRepository $repository,
        private readonly NatTipoOcorrenciaRepository $tipoRepository,
        private readonly NatLocalSecaoRepository $localSecaoRepository,
        private readonly NatAtribuicaoService $atribuicaoService,
        private readonly NatOcorrenciaEventoService $eventoService,
        private readonly NatEscopoService $escopoService,
    ) {
    }

    public function abrir(array $dados): int
    {
        $tipo = $this->tipoRepository->buscar((int) $dados['id_tipo_ocorrencia']);
        if ($tipo === null || ($tipo->ativo ?? 'N') !== 'S') {
            throw new RuntimeException('Tipo de ocorrência inválido ou inativo.');
        }

        $local = $this->localSecaoRepository->buscarLocal((string) $dados['cod_objeto_local_votacao']);
        if ($local === null) {
            throw new RuntimeException('Local de votação não encontrado.');
        }
        if (!$this->escopoService->acessoTodasZonas() && !in_array((int) ($local->zona_numero ?? 0), $this->escopoService->zonasPermitidas(), true)) {
            throw new RuntimeException('O local de votação informado está fora do escopo da sua sessão.');
        }

        if (!$this->localSecaoRepository->secaoPertenceAoLocal((string) $dados['cod_objeto_local_votacao'], (string) $dados['num_secao'])) {
            throw new RuntimeException('A seção informada não pertence ao local de votação selecionado.');
        }

        $statusAtribuida = DB::table('nat_status_ocorrencia')->where('codigo', 'ATRIBUIDA')->value('id_status');
        if (!$statusAtribuida) {
            throw new RuntimeException('Status ATRIBUIDA não encontrado.');
        }

        $resolucaoRota = $this->atribuicaoService->resolverOuValidarRota((string) $dados['cod_objeto_local_votacao'], isset($dados['rota_id']) ? (int) $dados['rota_id'] : null);
        $usuario = $this->escopoService->usuarioAuditoria();

        return DB::transaction(function () use ($dados, $resolucaoRota, $statusAtribuida, $usuario) {
            $idOcorrencia = $this->repository->criar([
                'rota_id' => $resolucaoRota['rota_id'],
                'id_tipo_ocorrencia' => (int) $dados['id_tipo_ocorrencia'],
                'id_status' => (int) $statusAtribuida,
                'cod_objeto_local_votacao' => (string) $dados['cod_objeto_local_votacao'],
                'num_secao' => (string) $dados['num_secao'],
                'zona_id' => (int) $resolucaoRota['zona_id'],
                'municipio_id' => (int) $resolucaoRota['municipio_id'],
                'descricao_problema' => (string) $dados['descricao_problema'],
                'nome_solicitante' => $dados['nome_solicitante'] ?? null,
                'telefone_solicitante' => $dados['telefone_solicitante'] ?? null,
                'usuario_criacao' => $usuario['login'],
                'usuario_nome_criacao' => $usuario['nome'],
            ]);

            $this->eventoService->registrar([
                'id_ocorrencia' => $idOcorrencia,
                'id_status_anterior' => null,
                'id_status_novo' => (int) $statusAtribuida,
                'tipo_evento' => 'ABERTURA',
                'descricao' => 'Ocorrência aberta e atribuída.',
                'payload_json' => json_encode([
                    'rota_automatica' => $resolucaoRota['automatica'],
                    'rota_id' => $resolucaoRota['rota_id'],
                    'num_secao' => (string) $dados['num_secao'],
                ], JSON_UNESCAPED_UNICODE),
            ]);

            return $idOcorrencia;
        });
    }

    public function iniciarAtendimento(int $idOcorrencia, ?int $rotaId = null): void
    {
        $atual = $this->repository->buscar($idOcorrencia, $this->escopoService->zonasPermitidas(), $this->escopoService->acessoTodasZonas());
        if ($atual === null) {
            throw new RuntimeException('Ocorrência não encontrada.');
        }
        if ($rotaId !== null && (int) $atual->rota_id !== $rotaId) {
            throw new RuntimeException('A ocorrência não pertence à rota selecionada.');
        }
        if ((string) $atual->status_codigo !== 'ATRIBUIDA') {
            throw new RuntimeException('Somente ocorrências atribuídas podem ser iniciadas.');
        }

        $statusNovo = (int) DB::table('nat_status_ocorrencia')->where('codigo', 'EM_ANDAMENTO')->value('id_status');
        if ($statusNovo <= 0) {
            throw new RuntimeException('Status EM_ANDAMENTO não encontrado.');
        }

        $usuario = $this->escopoService->usuarioAuditoria();
        DB::transaction(function () use ($idOcorrencia, $atual, $statusNovo, $usuario) {
            $this->repository->marcarEmAndamento($idOcorrencia, $statusNovo, $usuario);
            $this->eventoService->registrar([
                'id_ocorrencia' => $idOcorrencia,
                'id_status_anterior' => (int) $atual->id_status,
                'id_status_novo' => $statusNovo,
                'tipo_evento' => 'INICIO_ATENDIMENTO',
                'descricao' => 'Ocorrência colocada em atendimento.',
            ]);
        });
    }

    public function finalizar(int $idOcorrencia, string $descricaoResolucao, ?int $rotaId = null): void
    {
        $descricaoResolucao = trim($descricaoResolucao);
        if ($descricaoResolucao === '') {
            throw new RuntimeException('Informe a descrição da resolução.');
        }

        $atual = $this->repository->buscar($idOcorrencia, $this->escopoService->zonasPermitidas(), $this->escopoService->acessoTodasZonas());
        if ($atual === null) {
            throw new RuntimeException('Ocorrência não encontrada.');
        }
        if ($rotaId !== null && (int) $atual->rota_id !== $rotaId) {
            throw new RuntimeException('A ocorrência não pertence à rota selecionada.');
        }
        if ((string) $atual->status_codigo !== 'EM_ANDAMENTO') {
            throw new RuntimeException('Somente ocorrências em andamento podem ser finalizadas.');
        }

        $statusNovo = (int) DB::table('nat_status_ocorrencia')->where('codigo', 'FINALIZADA')->value('id_status');
        if ($statusNovo <= 0) {
            throw new RuntimeException('Status FINALIZADA não encontrado.');
        }

        $usuario = $this->escopoService->usuarioAuditoria();
        DB::transaction(function () use ($idOcorrencia, $atual, $statusNovo, $descricaoResolucao, $usuario) {
            $this->repository->marcarFinalizada($idOcorrencia, $statusNovo, $descricaoResolucao, $usuario);
            $this->eventoService->registrar([
                'id_ocorrencia' => $idOcorrencia,
                'id_status_anterior' => (int) $atual->id_status,
                'id_status_novo' => $statusNovo,
                'tipo_evento' => 'FINALIZACAO',
                'descricao' => 'Ocorrência finalizada.',
                'payload_json' => json_encode([
                    'descricao_resolucao' => $descricaoResolucao,
                ], JSON_UNESCAPED_UNICODE),
            ]);
        });
    }
}
```
</APP_SERVICES_NAT_NATOCORRENCIASERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Nat/NatTipoOcorrenciaService.php`
## <APP_SERVICES_NAT_NATTIPOOCORRENCIASERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Nat/NatTipoOcorrenciaService.php`
- **Namespace Declaração:** `App\Services\Nat`
- **Entidade / Classe:** `class NatTipoOcorrenciaService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function criar(array $dados): int
public function atualizar(int $id, array $dados): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Nat;

use App\Repositories\Nat\NatTipoOcorrenciaRepository;
use RuntimeException;

class NatTipoOcorrenciaService
{
    public function __construct(
        private readonly NatTipoOcorrenciaRepository $repository,
        private readonly NatEscopoService $escopoService,
    ) {
    }

    public function criar(array $dados): int
    {
        if ($this->repository->nomeExiste($dados['nome'])) {
            throw new RuntimeException('Já existe um tipo de ocorrência com este nome.');
        }

        $usuario = $this->escopoService->usuarioAuditoria();

        return $this->repository->criar($dados + [
            'usuario_criacao' => $usuario['login'],
            'usuario_nome_criacao' => $usuario['nome'],
        ]);
    }

    public function atualizar(int $id, array $dados): void
    {
        if ($this->repository->nomeExiste($dados['nome'], $id)) {
            throw new RuntimeException('Já existe um tipo de ocorrência com este nome.');
        }

        $usuario = $this->escopoService->usuarioAuditoria();

        $this->repository->atualizar($id, $dados + [
            'usuario_atualizacao' => $usuario['login'],
            'usuario_nome_atualizacao' => $usuario['nome'],
        ]);
    }
}
```
</APP_SERVICES_NAT_NATTIPOOCORRENCIASERVICE_PHP>

