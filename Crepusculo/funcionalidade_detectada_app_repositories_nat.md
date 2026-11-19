# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_repositories_nat`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 4  
> **Tamanho do Arquivo:** 39 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Nat/NatExternoRepository.php`
## <APP_REPOSITORIES_NAT_NATEXTERNOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Nat/NatExternoRepository.php`
- **Namespace Declaração:** `App\Repositories\Nat`
- **Entidade / Classe:** `class NatExternoRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$registro = DB::table('nat_externo_macroprojeto as ne')
return (int) DB::table('nat_externo_desafio_login')->insertGetId([
DB::table('nat_externo_desafio_login')
return DB::table('nat_externo_desafio_login')
DB::table('nat_externo_desafio_login')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly IntegranteEquipeRotaPorEmailQuery $integranteEquipeQuery)
public function buscarConfiguracaoAtiva(): ?array
public function buscarIntegrantePorEmail(string $email): ?array
public function criarDesafio(array $dados): int
public function invalidarDesafiosAtivosPorEmail(string $email): void
public function buscarDesafioValidoPorEmail(string $email): ?object
public function incrementarTentativas(int $id): int
public function marcarDesafioUsado(int $id): void
public function registrarEvento(array $dados): int
public function pesquisarLocaisPorRotas(string $termo, array $rotaIds, int $limite = 15): array
public function localPertenceAoConjuntoRotas(string $codObjetoLocal, array $rotaIds): bool
public function listarRotasElegiveisPorLocalNoConjunto(string $codObjetoLocal, array $rotaIds): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Nat;

use App\Repositories\Lda\Queries\IntegranteEquipeRotaPorEmailQuery;
use App\Support\LocaisVotacao\LocalVotacaoCatalogo;
use Illuminate\Support\Facades\DB;

class NatExternoRepository
{
    public function __construct(private readonly IntegranteEquipeRotaPorEmailQuery $integranteEquipeQuery)
    {
    }

    public function buscarConfiguracaoAtiva(): ?array
    {
        $registro = DB::table('nat_externo_macroprojeto as ne')
            ->join('macroprojeto as mp', 'mp.id', '=', 'ne.macroprojeto_id')
            ->selectRaw("
                ne.id,
                ne.macroprojeto_id,
                mp.nome as macroprojeto_nome,
                ne.ativo,
                ne.permite_login_externo,
                ne.permite_abertura_ocorrencia,
                ne.permite_assumir_ocorrencia,
                ne.permite_finalizar_ocorrencia,
                TO_CHAR(ne.dt_inicio, 'YYYY-MM-DD HH24:MI:SS') as dt_inicio_fmt,
                TO_CHAR(ne.dt_fim, 'YYYY-MM-DD HH24:MI:SS') as dt_fim_fmt
            ")
            ->where('ne.ativo', 'S')
            ->where('ne.permite_login_externo', 'S')
            ->where(function ($query) {
                $query->whereNull('ne.dt_inicio')
                    ->orWhereRaw('ne.dt_inicio <= SYSDATE');
            })
            ->where(function ($query) {
                $query->whereNull('ne.dt_fim')
                    ->orWhereRaw('ne.dt_fim >= SYSDATE');
            })
            ->orderByDesc('ne.id')
            ->first();

        if ($registro !== null) {
            return (array) $registro;
        }

        return null;
    }

    public function buscarIntegrantePorEmail(string $email): ?array
    {
        $email = mb_strtolower(trim($email), 'UTF-8');
        if ($email === '') {
            return null;
        }

        $rows = collect($this->integranteEquipeQuery->executar($email));

        if ($rows->isEmpty()) {
            return null;
        }

        $primeiro = $rows->first();
        $rotas = $rows
            ->map(static function ($row) {
                return [
                    'id' => (int) $row->rota_id,
                    'numero' => (int) $row->rota_numero,
                    'descricao' => (string) ($row->rota_descricao ?? ''),
                    'zona_id' => (int) ($row->zona_id ?? 0),
                    'zona_numero' => (int) ($row->zona_numero ?? 0),
                ];
            })
            ->unique('id')
            ->values()
            ->all();

        $zonas = collect($rotas)
            ->pluck('zona_numero')
            ->filter(static fn ($zona) => is_int($zona) && $zona > 0)
            ->unique()
            ->values()
            ->all();

        return [
            'email' => (string) ($primeiro->email ?? $email),
            'integrante_referencia' => (string) ($primeiro->num_inscricao ?? ''),
            'nome' => trim((string) ($primeiro->nome ?? '')) ?: null,
            'rotas' => $rotas,
            'rotas_ids' => array_values(array_map(static fn (array $rota) => (int) $rota['id'], $rotas)),
            'zonas' => array_values($zonas),
        ];
    }

    public function criarDesafio(array $dados): int
    {
        return (int) DB::table('nat_externo_desafio_login')->insertGetId([
            'macroprojeto_id' => $dados['macroprojeto_id'],
            'email' => $dados['email'],
            'integrante_referencia' => $dados['integrante_referencia'],
            'rotas_json' => $dados['rotas_json'],
            'codigo_hash' => $dados['codigo_hash'],
            'tentativas' => 0,
            'ip_origem' => $dados['ip_origem'] ?? null,
            'user_agent' => $dados['user_agent'] ?? null,
            'expira_em' => $dados['expira_em'],
            'dt_criacao' => DB::raw('SYSDATE'),
        ], 'id');
    }

    public function invalidarDesafiosAtivosPorEmail(string $email): void
    {
        DB::table('nat_externo_desafio_login')
            ->whereRaw('LOWER(TRIM(email)) = ?', [mb_strtolower(trim($email), 'UTF-8')])
            ->whereNull('usado_em')
            ->whereNull('bloqueado_em')
            ->update([
                'bloqueado_em' => DB::raw('SYSDATE'),
            ]);
    }

    public function buscarDesafioValidoPorEmail(string $email): ?object
    {
        return DB::table('nat_externo_desafio_login')
            ->selectRaw("
                id,
                macroprojeto_id,
                email,
                integrante_referencia,
                rotas_json,
                codigo_hash,
                tentativas,
                ip_origem,
                user_agent,
                expira_em,
                TO_CHAR(expira_em, 'YYYY-MM-DD HH24:MI:SS') as expira_em_fmt
            ")
            ->whereRaw('LOWER(TRIM(email)) = ?', [mb_strtolower(trim($email), 'UTF-8')])
            ->whereNull('usado_em')
            ->whereNull('bloqueado_em')
            ->whereRaw('expira_em >= SYSDATE')
            ->orderByDesc('id')
            ->first();
    }

    public function incrementarTentativas(int $id): int
    {
        DB::table('nat_externo_desafio_login')
            ->where('id', $id)
            ->update([
                'tentativas' => DB::raw('NVL(tentativas, 0) + 1'),
            ]);

        return (int) DB::table('nat_externo_desafio_login')->where('id', $id)->value('tentativas');
    }
    public function marcarDesafioUsado(int $id): void
    {
        DB::table('nat_externo_desafio_login')
            ->where('id', $id)
            ->update([
                'usado_em' => DB::raw('SYSDATE'),
            ]);
    }

    public function registrarEvento(array $dados): int
    {
        return (int) DB::table('nat_externo_evento')->insertGetId([
            'macroprojeto_id' => $dados['macroprojeto_id'] ?? null,
            'tipo_evento' => $dados['tipo_evento'],
            'email' => $dados['email'] ?? null,
            'integrante_referencia' => $dados['integrante_referencia'] ?? null,
            'rotas_json' => $dados['rotas_json'] ?? null,
            'payload_json' => $dados['payload_json'] ?? null,
            'ip_origem' => $dados['ip_origem'] ?? null,
            'user_agent' => $dados['user_agent'] ?? null,
            'dt_evento' => DB::raw('SYSDATE'),
        ], 'id');
    }

    public function pesquisarLocaisPorRotas(string $termo, array $rotaIds, int $limite = 15): array
    {
        $ids = $this->normalizarIds($rotaIds);
        if (empty($ids)) {
            return [];
        }

        $query = DB::table('rota_local as rl')
            ->join(LocalVotacaoCatalogo::EFETIVOS . ' as lv', DB::raw('TRIM(lv.cod_objeto)'), '=', DB::raw('TRIM(rl.cod_objeto_local)'))
            ->leftJoin('zona as z', DB::raw('TRIM(lv.cod_objeto_zona)'), '=', DB::raw('TO_CHAR(z.num_zona)'))
            ->leftJoin('municipio as m', function ($join) {
                $join->on('m.zonaid', '=', 'z.id')
                    ->on('m.cod_objeto_localidade', '=', 'lv.cod_objeto_localidade');
            })
            ->selectRaw("
                TRIM(lv.cod_objeto) as id,
                NVL(TRIM(lv.cod_objeto_zona), 'S/ Zona') || ' - ' || lv.nom_localidade || ' - ' || lv.nom_local || ' (Local ' || lv.num_local || ')' as text
            ")
            ->whereIn('rl.rota_id', $ids)
            ->groupByRaw("
                TRIM(lv.cod_objeto),
                TRIM(lv.cod_objeto_zona),
                lv.nom_localidade,
                lv.nom_local,
                lv.num_local
            ")
            ->orderByRaw("TO_NUMBER(REGEXP_REPLACE(TRIM(lv.cod_objeto_zona), '[^0-9]', '')) NULLS LAST")
            ->orderBy('lv.nom_localidade')
            ->orderBy('lv.num_local');

        $termo = trim($termo);
        if ($termo !== '') {
            $like = '%' . mb_strtoupper($termo, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(NVL(lv.nom_local, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(lv.nom_localidade, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('TO_CHAR(lv.num_local) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(TRIM(lv.cod_objeto_zona), \'\')) LIKE ?', [$like]);
            });
        }

        return $query->limit($limite)->get()->map(static fn ($item) => (array) $item)->all();
    }

    public function localPertenceAoConjuntoRotas(string $codObjetoLocal, array $rotaIds): bool
    {
        $ids = $this->normalizarIds($rotaIds);
        if (empty($ids)) {
            return false;
        }

        return DB::table('rota_local')
            ->whereRaw('TRIM(cod_objeto_local) = ?', [trim($codObjetoLocal)])
            ->whereIn('rota_id', $ids)
            ->exists();
    }

    public function listarRotasElegiveisPorLocalNoConjunto(string $codObjetoLocal, array $rotaIds): array
    {
        $ids = $this->normalizarIds($rotaIds);
        if (empty($ids)) {
            return [];
        }

        return DB::table('rota_local as rl')
            ->join('rota as r', 'r.id', '=', 'rl.rota_id')
            ->leftJoin('municipio as m', 'm.id', '=', 'r.municipio_id')
            ->leftJoin('zona as z', 'z.id', '=', 'r.zona_id')
            ->selectRaw("
                r.id,
                r.numero,
                r.descricao,
                r.zona_id,
                r.municipio_id,
                m.localidade as municipio,
                z.num_zona as zona
            ")
            ->whereRaw('TRIM(rl.cod_objeto_local) = ?', [trim($codObjetoLocal)])
            ->whereIn('rl.rota_id', $ids)
            ->orderBy('r.numero')
            ->get()
            ->map(static fn ($item) => (array) $item)
            ->unique('id')
            ->values()
            ->all();
    }

    public function buscarRotaAutomaticaPorLocalNoConjunto(string $codObjetoLocal, array $rotaIds): ?array
    {
        $rotas = $this->listarRotasElegiveisPorLocalNoConjunto($codObjetoLocal, $rotaIds);
        return count($rotas) === 1 ? $rotas[0] : null;
    }

    /**
     * @param array<int, mixed> $rotaIds
     * @return array<int, int>
     */
    private function normalizarIds(array $rotaIds): array
    {
        return collect($rotaIds)
            ->map(static fn ($valor) => is_numeric($valor) ? (int) $valor : null)
            ->filter(static fn ($valor) => is_int($valor) && $valor > 0)
            ->unique()
            ->values()
            ->all();
    }
}
```
</APP_REPOSITORIES_NAT_NATEXTERNOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Nat/NatOcorrenciaEventoRepository.php`
## <APP_REPOSITORIES_NAT_NATOCORRENCIAEVENTOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Nat/NatOcorrenciaEventoRepository.php`
- **Namespace Declaração:** `App\Repositories\Nat`
- **Entidade / Classe:** `class NatOcorrenciaEventoRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return DB::table('nat_ocorrencia_evento as e')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function criar(array $dados): int
public function listarPorOcorrencia(int $idOcorrencia): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Nat;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Support\Facades\DB;

class NatOcorrenciaEventoRepository
{
    use AuditaDml;

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'nat_ocorrencia_evento',
            'NAT_OCORRENCIA_EVENTO',
            [
                'id_ocorrencia' => $dados['id_ocorrencia'],
                'id_status_anterior' => $dados['id_status_anterior'] ?? null,
                'id_status_novo' => $dados['id_status_novo'] ?? null,
                'tipo_evento' => $dados['tipo_evento'],
                'descricao' => $dados['descricao'] ?? null,
                'payload_json' => $dados['payload_json'] ?? null,
                'dt_evento' => DB::raw('SYSDATE'),
                'usuario_criacao' => $dados['usuario_criacao'] ?? null,
                'usuario_nome_criacao' => $dados['usuario_nome_criacao'] ?? null,
            ],
            'id_ocorrencia_evento',
            'id_ocorrencia_evento'
        );
    }

    public function listarPorOcorrencia(int $idOcorrencia): array
    {
        return DB::table('nat_ocorrencia_evento as e')
            ->leftJoin('nat_status_ocorrencia as sa', 'sa.id_status', '=', 'e.id_status_anterior')
            ->leftJoin('nat_status_ocorrencia as sn', 'sn.id_status', '=', 'e.id_status_novo')
            ->selectRaw("
                e.id_ocorrencia_evento,
                e.tipo_evento,
                e.descricao,
                e.payload_json,
                TO_CHAR(e.dt_evento, 'DD/MM/YYYY HH24:MI') as dt_evento_fmt,
                e.usuario_criacao,
                e.usuario_nome_criacao,
                sa.nome as status_anterior_nome,
                sn.nome as status_novo_nome
            ")
            ->where('e.id_ocorrencia', $idOcorrencia)
            ->orderByDesc('e.id_ocorrencia_evento')
            ->get()
            ->map(static fn ($item) => (array) $item)
            ->all();
    }
}
```
</APP_REPOSITORIES_NAT_NATOCORRENCIAEVENTOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Nat/NatOcorrenciaRepository.php`
## <APP_REPOSITORIES_NAT_NATOCORRENCIAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Nat/NatOcorrenciaRepository.php`
- **Namespace Declaração:** `App\Repositories\Nat`
- **Entidade / Classe:** `class NatOcorrenciaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('nat_ocorrencia as no')
$query = DB::table('rota as r')
$query = DB::table('nat_ocorrencia as no')
$query = DB::table('nat_ocorrencia as no')
$query = DB::table('nat_ocorrencia as no')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listarPaginado(array $filtros = [], array $zonasPermitidas = [], bool $acessoTodasZonas = false, ?int $rotaId = null, int $perPage = 10): LengthAwarePaginator
public function contarPorStatus(array $filtros = [], array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
public function buscar(int $idOcorrencia, array $zonasPermitidas = [], bool $acessoTodasZonas = false): ?object
public function criar(array $dados): int
public function marcarEmAndamento(int $idOcorrencia, int $idStatusEmAndamento, array $usuario): void
public function marcarFinalizada(int $idOcorrencia, int $idStatusFinalizada, string $descricaoResolucao, array $usuario): void
public function listarRotasNoEscopo(array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
public function listarAtivasPorLocalERota(string $codObjetoLocalVotacao, int $rotaId, array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
public function maiorNaoFinalizadaPorRotas(array $rotaIds, array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
public function contarNovasNaoFinalizadasPorRotas(array $rotaIds, array $visualizadasPorRota, array $zonasPermitidas = [], bool $acessoTodasZonas = false): int
public function contarNaoFinalizadasPorRotas(array $rotaIds, array $zonasPermitidas = [], bool $acessoTodasZonas = false): int
public function contarNaoFinalizadasPorRota(array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Nat;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use App\Support\LocaisVotacao\LocalVotacaoCatalogo;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class NatOcorrenciaRepository
{
    use AuditaDml;

    public function listarPaginado(array $filtros = [], array $zonasPermitidas = [], bool $acessoTodasZonas = false, ?int $rotaId = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = $this->baseQuery($zonasPermitidas, $acessoTodasZonas, $rotaId);

        if (!empty($filtros['status'])) {
            $status = mb_strtoupper((string) $filtros['status']);
            if ($status === 'NAO_FINALIZADA') {
                $query->whereIn('ns.codigo', ['ATRIBUIDA', 'EM_ANDAMENTO']);
            } else {
                $query->whereRaw('UPPER(ns.codigo) = ?', [$status]);
            }
        }
        if (!empty($filtros['tipo'])) {
            $query->where('no.id_tipo_ocorrencia', (int) $filtros['tipo']);
        }
        if (!empty($filtros['rota_id'])) {
            $query->where('no.rota_id', (int) $filtros['rota_id']);
        }
        if (!empty($filtros['rota_ids']) && is_array($filtros['rota_ids'])) {
            $rotaIds = array_values(array_filter(array_map('intval', $filtros['rota_ids']), static fn ($valor) => $valor > 0));
            if (!empty($rotaIds)) {
                $query->whereIn('no.rota_id', $rotaIds);
            }
        }
        if (!empty($filtros['zona_id'])) {
            $query->where('no.zona_id', (int) $filtros['zona_id']);
        }
        if (!empty($filtros['municipio_id'])) {
            $query->where('no.municipio_id', (int) $filtros['municipio_id']);
        }
        if (!empty($filtros['secao'])) {
            $query->whereRaw('UPPER(NVL(no.num_secao, \'\')) LIKE ?', ['%' . mb_strtoupper((string) $filtros['secao'], 'UTF-8') . '%']);
        }
        if (!empty($filtros['busca'])) {
            $like = '%' . mb_strtoupper((string) $filtros['busca'], 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(NVL(lv.nom_local, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(m.localidade, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(no.descricao_problema, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(nto.nome, \'\')) LIKE ?', [$like]);
            });
        }

        return $query->orderByDesc('no.id_ocorrencia')->paginate($perPage)->withQueryString();
    }

    public function contarPorStatus(array $filtros = [], array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
    {
        $query = DB::table('nat_ocorrencia as no')
            ->join('nat_tipo_ocorrencia as nto', 'nto.id_tipo_ocorrencia', '=', 'no.id_tipo_ocorrencia')
            ->join('nat_status_ocorrencia as ns', 'ns.id_status', '=', 'no.id_status')
            ->join('rota as r', 'r.id', '=', 'no.rota_id')
            ->join('municipio as m', 'm.id', '=', 'no.municipio_id')
            ->join('zona as z', 'z.id', '=', 'no.zona_id')
            ->join(LocalVotacaoCatalogo::EFETIVOS . ' as lv', DB::raw('TRIM(lv.cod_objeto)'), '=', DB::raw('TRIM(no.cod_objeto_local_votacao)'));

        if (!empty($filtros['status'])) {
            $status = mb_strtoupper((string) $filtros['status']);
            if ($status === 'NAO_FINALIZADA') {
                $query->whereIn('ns.codigo', ['ATRIBUIDA', 'EM_ANDAMENTO']);
            } else {
                $query->whereRaw('UPPER(ns.codigo) = ?', [$status]);
            }
        }
        if (!empty($filtros['tipo'])) {
            $query->where('no.id_tipo_ocorrencia', (int) $filtros['tipo']);
        }
        if (!empty($filtros['rota_id'])) {
            $query->where('no.rota_id', (int) $filtros['rota_id']);
        }
        if (!empty($filtros['zona_id'])) {
            $query->where('no.zona_id', (int) $filtros['zona_id']);
        }
        if (!empty($filtros['municipio_id'])) {
            $query->where('no.municipio_id', (int) $filtros['municipio_id']);
        }
        if (!empty($filtros['secao'])) {
            $query->whereRaw('UPPER(NVL(no.num_secao, \'\')) LIKE ?', ['%' . mb_strtoupper((string) $filtros['secao'], 'UTF-8') . '%']);
        }
        if (!empty($filtros['busca'])) {
            $like = '%' . mb_strtoupper((string) $filtros['busca'], 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(NVL(lv.nom_local, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(m.localidade, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(no.descricao_problema, \'\')) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(nto.nome, \'\')) LIKE ?', [$like]);
            });
        }

        if (!$acessoTodasZonas) {
            if (empty($zonasPermitidas)) {
                return [];
            }
            $query->whereIn('z.num_zona', array_map('intval', $zonasPermitidas));
        }

        return $query
            ->selectRaw('ns.codigo, ns.nome, COUNT(*) as total')
            ->groupBy('ns.codigo', 'ns.nome')
            ->orderBy('ns.codigo')
            ->get()
            ->mapWithKeys(static fn ($item) => [(string) $item->codigo => [
                'nome' => (string) $item->nome,
                'total' => (int) $item->total,
            ]])
            ->all();
    }

    public function buscar(int $idOcorrencia, array $zonasPermitidas = [], bool $acessoTodasZonas = false): ?object
    {
        return $this->baseQuery($zonasPermitidas, $acessoTodasZonas)
            ->where('no.id_ocorrencia', $idOcorrencia)
            ->first();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'nat_ocorrencia',
            'NAT_OCORRENCIA',
            [
                'rota_id' => $dados['rota_id'],
                'id_tipo_ocorrencia' => $dados['id_tipo_ocorrencia'],
                'id_status' => $dados['id_status'],
                'cod_objeto_local_votacao' => trim((string) $dados['cod_objeto_local_votacao']),
                'num_secao' => trim((string) $dados['num_secao']),
                'zona_id' => $dados['zona_id'],
                'municipio_id' => $dados['municipio_id'],
                'descricao_problema' => trim((string) $dados['descricao_problema']),
                'descricao_resolucao' => $dados['descricao_resolucao'] ?? null,
                'nome_solicitante' => $dados['nome_solicitante'] ?? null,
                'telefone_solicitante' => $dados['telefone_solicitante'] ?? null,
                'dt_abertura' => DB::raw('SYSDATE'),
                'dt_atribuicao' => DB::raw('SYSDATE'),
                'usuario_criacao' => $dados['usuario_criacao'] ?? null,
                'usuario_nome_criacao' => $dados['usuario_nome_criacao'] ?? null,
            ],
            'id_ocorrencia',
            'id_ocorrencia'
        );
    }

    public function marcarEmAndamento(int $idOcorrencia, int $idStatusEmAndamento, array $usuario): void
    {
        $this->atualizarAuditadoPorId('nat_ocorrencia', 'NAT_OCORRENCIA', 'id_ocorrencia', $idOcorrencia, [
            'id_status' => $idStatusEmAndamento,
            'dt_inicio_atendimento' => DB::raw('SYSDATE'),
            'dt_atualizacao' => DB::raw('SYSDATE'),
            'usuario_atualizacao' => $usuario['login'] ?? null,
            'usuario_nome_atualizacao' => $usuario['nome'] ?? null,
        ]);
    }

    public function marcarFinalizada(int $idOcorrencia, int $idStatusFinalizada, string $descricaoResolucao, array $usuario): void
    {
        $this->atualizarAuditadoPorId('nat_ocorrencia', 'NAT_OCORRENCIA', 'id_ocorrencia', $idOcorrencia, [
            'id_status' => $idStatusFinalizada,
            'descricao_resolucao' => trim($descricaoResolucao),
            'dt_finalizacao' => DB::raw('SYSDATE'),
            'dt_atualizacao' => DB::raw('SYSDATE'),
            'usuario_atualizacao' => $usuario['login'] ?? null,
            'usuario_nome_atualizacao' => $usuario['nome'] ?? null,
        ]);
    }

    public function listarRotasNoEscopo(array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
    {
        $query = DB::table('rota as r')
            ->leftJoin('municipio as m', 'm.id', '=', 'r.municipio_id')
            ->leftJoin('zona as z', 'z.id', '=', 'r.zona_id')
            ->selectRaw("r.id, r.numero, r.descricao, r.zona_id, r.municipio_id, m.localidade as municipio, z.num_zona as zona,
                (
                    SELECT COUNT(*)
                    FROM VW_SECOES_AGREGADAS ws_total
                    JOIN ROTA_LOCAL rl_total2
                        ON rl_total2.cod_objeto_local = ws_total.cod_objeto_local
                    WHERE rl_total2.rota_id = r.id
                ) AS total_secoes")
            ->orderBy('r.numero');

        if (!$acessoTodasZonas) {
            if (empty($zonasPermitidas)) {
                return [];
            }
            $query->whereIn('z.num_zona', array_map('intval', $zonasPermitidas));
        }

        return $query->get()->map(static fn ($item) => (array) $item)->all();
    }

    public function listarAtivasPorLocalERota(string $codObjetoLocalVotacao, int $rotaId, array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
    {
        $query = $this->baseQuery($zonasPermitidas, $acessoTodasZonas, $rotaId)
            ->whereRaw('TRIM(no.cod_objeto_local_votacao) = ?', [trim($codObjetoLocalVotacao)])
            ->whereIn('ns.codigo', ['ATRIBUIDA', 'EM_ANDAMENTO'])
            ->orderByDesc('no.id_ocorrencia');

        return $query->get()->map(static fn ($item) => (array) $item)->all();
    }

    public function maiorNaoFinalizadaPorRotas(array $rotaIds, array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($rotaIds === []) {
            return [];
        }

        return $this->baseQueryNaoFinalizadasPorRotas($rotaIds, $zonasPermitidas, $acessoTodasZonas)
            ->selectRaw('no.rota_id, MAX(no.id_ocorrencia) as maior_id')
            ->groupBy('no.rota_id')
            ->get()
            ->mapWithKeys(static fn ($item) => [(int) $item->rota_id => (int) $item->maior_id])
            ->all();
    }

    public function contarNovasNaoFinalizadasPorRotas(array $rotaIds, array $visualizadasPorRota, array $zonasPermitidas = [], bool $acessoTodasZonas = false): int
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($rotaIds === []) {
            return 0;
        }

        $visualizadasPorRota = collect($visualizadasPorRota)
            ->mapWithKeys(static fn ($valor, $rotaId) => is_numeric($rotaId) && is_numeric($valor)
                ? [(int) $rotaId => (int) $valor]
                : [])
            ->all();

        return (int) $this->baseQueryNaoFinalizadasPorRotas($rotaIds, $zonasPermitidas, $acessoTodasZonas)
            ->where(function ($query) use ($rotaIds, $visualizadasPorRota) {
                foreach ($rotaIds as $rotaId) {
                    $query->orWhere(function ($sub) use ($rotaId, $visualizadasPorRota) {
                        $sub->where('no.rota_id', $rotaId)
                            ->where('no.id_ocorrencia', '>', (int) ($visualizadasPorRota[$rotaId] ?? 0));
                    });
                }
            })
            ->count();
    }

    public function contarNaoFinalizadasPorRotas(array $rotaIds, array $zonasPermitidas = [], bool $acessoTodasZonas = false): int
    {
        $rotaIds = $this->normalizarIds($rotaIds);
        if ($rotaIds === []) {
            return 0;
        }

        return (int) $this->baseQueryNaoFinalizadasPorRotas($rotaIds, $zonasPermitidas, $acessoTodasZonas)->count();
    }

    public function contarNaoFinalizadasPorRota(array $zonasPermitidas = [], bool $acessoTodasZonas = false): array
    {
        $query = DB::table('nat_ocorrencia as no')
            ->join('nat_status_ocorrencia as ns', 'ns.id_status', '=', 'no.id_status')
            ->join('rota as r', 'r.id', '=', 'no.rota_id')
            ->whereIn('ns.codigo', ['ATRIBUIDA', 'EM_ANDAMENTO'])
            ->selectRaw("
                no.rota_id,
                r.numero as rota_numero,
                r.descricao as rota_descricao,
                COUNT(*) as total,
                SUM(CASE WHEN ns.codigo = 'ATRIBUIDA' THEN 1 ELSE 0 END) as atribuidas,
                SUM(CASE WHEN ns.codigo = 'EM_ANDAMENTO' THEN 1 ELSE 0 END) as em_andamento
            ")
            ->groupBy('no.rota_id', 'r.numero', 'r.descricao')
            ->orderBy('r.numero');

        if (!$acessoTodasZonas) {
            $query->join('zona as z', 'z.id', '=', 'no.zona_id');
            if (empty($zonasPermitidas)) {
                return [];
            }
            $query->whereIn('z.num_zona', array_map('intval', $zonasPermitidas));
        }

        return $query->get()->map(static fn ($item) => [
            'rota_id'       => (int) $item->rota_id,
            'rota_numero'   => (int) $item->rota_numero,
            'rota_descricao' => (string) ($item->rota_descricao ?? ''),
            'total'         => (int) $item->total,
            'atribuidas'    => (int) $item->atribuidas,
            'em_andamento'  => (int) $item->em_andamento,
        ])->all();
    }

    private function baseQuery(array $zonasPermitidas = [], bool $acessoTodasZonas = false, ?int $rotaId = null)
    {
        $query = DB::table('nat_ocorrencia as no')
            ->join('nat_tipo_ocorrencia as nto', 'nto.id_tipo_ocorrencia', '=', 'no.id_tipo_ocorrencia')
            ->join('nat_status_ocorrencia as ns', 'ns.id_status', '=', 'no.id_status')
            ->join('rota as r', 'r.id', '=', 'no.rota_id')
            ->join('municipio as m', 'm.id', '=', 'no.municipio_id')
            ->join('zona as z', 'z.id', '=', 'no.zona_id')
            ->join(LocalVotacaoCatalogo::EFETIVOS . ' as lv', DB::raw('TRIM(lv.cod_objeto)'), '=', DB::raw('TRIM(no.cod_objeto_local_votacao)'))
            ->selectRaw("
                no.id_ocorrencia,
                no.rota_id,
                no.id_tipo_ocorrencia,
                no.id_status,
                no.cod_objeto_local_votacao,
                no.num_secao,
                no.zona_id,
                no.municipio_id,
                no.descricao_problema,
                no.descricao_resolucao,
                no.nome_solicitante,
                no.telefone_solicitante,
                no.usuario_criacao,
                no.usuario_nome_criacao,
                TO_CHAR(no.dt_abertura, 'DD/MM/YYYY HH24:MI') as dt_abertura_fmt,
                TO_CHAR(no.dt_atribuicao, 'DD/MM/YYYY HH24:MI') as dt_atribuicao_fmt,
                TO_CHAR(no.dt_inicio_atendimento, 'DD/MM/YYYY HH24:MI') as dt_inicio_atendimento_fmt,
                TO_CHAR(no.dt_finalizacao, 'DD/MM/YYYY HH24:MI') as dt_finalizacao_fmt,
                nto.nome as tipo_nome,
                ns.codigo as status_codigo,
                ns.nome as status_nome,
                r.numero as rota_numero,
                r.descricao as rota_descricao,
                m.localidade as municipio_nome,
                z.num_zona as zona_numero,
                lv.nom_local as local_nome,
                lv.num_local as local_numero
            ");

        if ($rotaId !== null && $rotaId > 0) {
            $query->where('no.rota_id', $rotaId);
        }

        if (!$acessoTodasZonas) {
            if (empty($zonasPermitidas)) {
                $query->whereRaw('1 = 0');
            } else {
                $query->whereIn('z.num_zona', array_map('intval', $zonasPermitidas));
            }
        }

        return $query;
    }
    private function baseQueryNaoFinalizadasPorRotas(array $rotaIds, array $zonasPermitidas = [], bool $acessoTodasZonas = false)
    {
        $query = DB::table('nat_ocorrencia as no')
            ->join('nat_status_ocorrencia as ns', 'ns.id_status', '=', 'no.id_status')
            ->whereIn('no.rota_id', $rotaIds)
            ->whereIn('ns.codigo', ['ATRIBUIDA', 'EM_ANDAMENTO']);

        if (!$acessoTodasZonas) {
            $query->join('zona as z', 'z.id', '=', 'no.zona_id');
            if (empty($zonasPermitidas)) {
                $query->whereRaw('1 = 0');
            } else {
                $query->whereIn('z.num_zona', array_map('intval', $zonasPermitidas));
            }
        }

        return $query;
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
}
```
</APP_REPOSITORIES_NAT_NATOCORRENCIAREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Nat/NatTipoOcorrenciaRepository.php`
## <APP_REPOSITORIES_NAT_NATTIPOOCORRENCIAREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Nat/NatTipoOcorrenciaRepository.php`
- **Namespace Declaração:** `App\Repositories\Nat`
- **Entidade / Classe:** `class NatTipoOcorrenciaRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('nat_tipo_ocorrencia')
return DB::table('nat_tipo_ocorrencia')
return DB::table('nat_tipo_ocorrencia')
$query = DB::table('nat_tipo_ocorrencia')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?string $busca = null, ?string $ativo = null, int $perPage = 10): LengthAwarePaginator
public function listarAtivos(): array
public function buscar(int $id): ?object
public function nomeExiste(string $nome, ?int $ignorarId = null): bool
public function criar(array $dados): int
public function atualizar(int $id, array $dados): void
public function remover(int $id): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Nat;

use App\Services\Auditoria\AuditLogService;

use App\Repositories\Concerns\AuditaDml;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class NatTipoOcorrenciaRepository
{
    use AuditaDml;

    public function listar(?string $busca = null, ?string $ativo = null, int $perPage = 10): LengthAwarePaginator
    {
        $query = DB::table('nat_tipo_ocorrencia')
            ->selectRaw("
                id_tipo_ocorrencia,
                nome,
                descricao,
                ordem,
                ativo,
                TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI') as dt_criacao_fmt,
                TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI') as dt_atualizacao_fmt
            ")
            ->orderBy('ordem')
            ->orderBy('nome');

        if ($busca !== null && $busca !== '') {
            $like = '%' . mb_strtoupper($busca, 'UTF-8') . '%';
            $query->where(function ($sub) use ($like) {
                $sub->whereRaw('UPPER(nome) LIKE ?', [$like])
                    ->orWhereRaw('UPPER(NVL(descricao, \'\')) LIKE ?', [$like]);
            });
        }

        if ($ativo !== null && $ativo !== '') {
            $query->where('ativo', $ativo === 'S' ? 'S' : 'N');
        }

        return $query->paginate($perPage)->withQueryString();
    }

    public function listarAtivos(): array
    {
        return DB::table('nat_tipo_ocorrencia')
            ->select('id_tipo_ocorrencia', 'nome', 'descricao')
            ->where('ativo', 'S')
            ->orderBy('ordem')
            ->orderBy('nome')
            ->get()
            ->map(static fn ($item) => (array) $item)
            ->all();
    }

    public function buscar(int $id): ?object
    {
        return DB::table('nat_tipo_ocorrencia')
            ->where('id_tipo_ocorrencia', $id)
            ->first();
    }

    public function nomeExiste(string $nome, ?int $ignorarId = null): bool
    {
        $query = DB::table('nat_tipo_ocorrencia')
            ->whereRaw('UPPER(nome) = ?', [mb_strtoupper(trim($nome), 'UTF-8')]);

        if ($ignorarId !== null) {
            $query->where('id_tipo_ocorrencia', '<>', $ignorarId);
        }

        return $query->exists();
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado(
            'nat_tipo_ocorrencia',
            'NAT_TIPO_OCORRENCIA',
            [
                'nome' => trim((string) $dados['nome']),
                'descricao' => $dados['descricao'] !== null ? trim((string) $dados['descricao']) : null,
                'ordem' => (int) $dados['ordem'],
                'ativo' => $dados['ativo'] ? 'S' : 'N',
                'dt_criacao' => DB::raw('SYSDATE'),
                'usuario_criacao' => $dados['usuario_criacao'] ?? null,
                'usuario_nome_criacao' => $dados['usuario_nome_criacao'] ?? null,
            ],
            'id_tipo_ocorrencia',
            'id_tipo_ocorrencia'
        );
    }

    public function atualizar(int $id, array $dados): void
    {
        $this->atualizarAuditadoPorId('nat_tipo_ocorrencia', 'NAT_TIPO_OCORRENCIA', 'id_tipo_ocorrencia', $id, [
            'nome' => trim((string) $dados['nome']),
            'descricao' => $dados['descricao'] !== null ? trim((string) $dados['descricao']) : null,
            'ordem' => (int) $dados['ordem'],
            'ativo' => $dados['ativo'] ? 'S' : 'N',
            'dt_atualizacao' => DB::raw('SYSDATE'),
            'usuario_atualizacao' => $dados['usuario_atualizacao'] ?? null,
            'usuario_nome_atualizacao' => $dados['usuario_nome_atualizacao'] ?? null,
        ]);
    }

    public function remover(int $id): void
    {
        $this->removerAuditadoPorId('nat_tipo_ocorrencia', 'NAT_TIPO_OCORRENCIA', 'id_tipo_ocorrencia', $id);
    }
}
```
</APP_REPOSITORIES_NAT_NATTIPOOCORRENCIAREPOSITORY_PHP>

