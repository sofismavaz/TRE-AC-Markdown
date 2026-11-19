# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_supervisores_predio`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 11  
> **Tamanho do Arquivo:** 45 KB  
> **Classificação do Mapeamento:** Pertencente às 15 Funcionalidades Mapeadas em Coleta_CodigoCrep.md

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/ColaboradoresEleitorais/VoluntarioExternoConfirmacaoController.php`
## <APP_HTTP_CONTROLLERS_COLABORADORESELEITORAIS_VOLUNTARIOEXTERNOCONFIRMACAOCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/ColaboradoresEleitorais/VoluntarioExternoConfirmacaoController.php`
- **Namespace Declaração:** `App\Http\Controllers\ColaboradoresEleitorais`
- **Entidade / Classe:** `class VoluntarioExternoConfirmacaoController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$mapeadas = DB::table('zona')->selectRaw('TO_CHAR(num_zona) as num_zona')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(private readonly VoluntarioExternoConfirmacaoRepositoryInterface $repository)
public function confirmar(Request $request, int $id): JsonResponse
private function zonasPermitidasVoluntarios(array $zonasBase): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\ColaboradoresEleitorais;

use App\Http\Controllers\Controller;

use App\Repositories\ColaboradoresEleitorais\Contracts\VoluntarioExternoConfirmacaoRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VoluntarioExternoConfirmacaoController extends Controller
{
    public function __construct(private readonly VoluntarioExternoConfirmacaoRepositoryInterface $repository)
    {
    }

    public function confirmar(Request $request, int $id): JsonResponse
    {
        $zonasPermitidas = $this->zonasPermitidasVoluntarios($this->zonasPermitidasSessao());
        $voluntario = $this->repository->buscarNoEscopo($id, $this->acessoTodasZonasSessao(), $zonasPermitidas);
        if (!$voluntario) {
            return response()->json(['mensagem' => 'Voluntário não encontrado no escopo autorizado.'], 404);
        }

        $email = trim((string) ($voluntario->email ?? ''));
        if ($email === '') {
            return response()->json(['mensagem' => 'O voluntário não possui e-mail para confirmação.'], 422);
        }
        if ((int) ($voluntario->confirmado_sistema ?? 0) === 1) {
            return response()->json(['mensagem' => 'O e-mail já está confirmado pelo sistema.', 'status' => 'Ativo']);
        }
        if (mb_strtoupper(trim((string) ($voluntario->status_origem ?? '')), 'UTF-8') !== 'PENDENTE') {
            return response()->json(['mensagem' => 'Somente e-mails pendentes podem ser confirmados pelo sistema.'], 422);
        }

        $usuario = trim((string) session('user.username', ''));
        $usuarioNome = trim((string) session('user.name', ''));
        if ($usuario === '') {
            abort(403, 'Usuário autenticado não identificado.');
        }

        $confirmacao = DB::transaction(fn () => $this->repository->confirmar($id, $email, $usuario, $usuarioNome !== '' ? $usuarioNome : null));

        return response()->json([
            'mensagem' => 'E-mail confirmado pelo sistema com sucesso.',
            'status' => 'Ativo',
            'confirmado_por' => $confirmacao->usuario_nome_confirmacao ?: $confirmacao->usuario_confirmacao,
            'confirmado_em' => $confirmacao->dt_confirmacao,
        ]);
    }

    private function zonasPermitidasVoluntarios(array $zonasBase): array
    {
        $zonas = collect($zonasBase)->map(static fn ($zona) => is_numeric($zona) ? (int) $zona : null)
            ->filter(static fn ($zona) => $zona !== null && $zona > 0)->values();
        if ($zonas->isEmpty()) {
            return [];
        }
        $mapeadas = DB::table('zona')->selectRaw('TO_CHAR(num_zona) as num_zona')
            ->whereIn('id', $zonas->all())->orWhereIn('num_zona', $zonas->all())->pluck('num_zona')
            ->map(static fn ($valor) => trim((string) $valor))->filter()->unique()->values()->all();

        return $mapeadas ?: $zonas->map(static fn ($zona) => (string) $zona)->all();
    }
}
```
</APP_HTTP_CONTROLLERS_COLABORADORESELEITORAIS_VOLUNTARIOEXTERNOCONFIRMACAOCONTROLLER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ColaboradoresEleitorais/Contracts/VoluntarioExternoConfirmacaoRepositoryInterface.php`
## <APP_REPOSITORIES_COLABORADORESELEITORAIS_CONTRACTS_VOLUNTARIOEXTERNOCONFIRMACAOREPOSITORYINTERFACE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ColaboradoresEleitorais/Contracts/VoluntarioExternoConfirmacaoRepositoryInterface.php`
- **Namespace Declaração:** `App\Repositories\ColaboradoresEleitorais\Contracts`
- **Entidade / Classe:** `interface VoluntarioExternoConfirmacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function buscarNoEscopo(int $pessoaId, bool $acessoTodasZonas, array $zonasPermitidas): ?object;
public function confirmar(int $pessoaId, string $email, string $usuario, ?string $usuarioNome): object;
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ColaboradoresEleitorais\Contracts;

interface VoluntarioExternoConfirmacaoRepositoryInterface
{
    public function buscarNoEscopo(int $pessoaId, bool $acessoTodasZonas, array $zonasPermitidas): ?object;
    public function confirmar(int $pessoaId, string $email, string $usuario, ?string $usuarioNome): object;
}
```
</APP_REPOSITORIES_COLABORADORESELEITORAIS_CONTRACTS_VOLUNTARIOEXTERNOCONFIRMACAOREPOSITORYINTERFACE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/ColaboradoresEleitorais/VoluntarioExternoConfirmacaoRepository.php`
## <APP_REPOSITORIES_COLABORADORESELEITORAIS_VOLUNTARIOEXTERNOCONFIRMACAOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/ColaboradoresEleitorais/VoluntarioExternoConfirmacaoRepository.php`
- **Namespace Declaração:** `App\Repositories\ColaboradoresEleitorais`
- **Entidade / Classe:** `class VoluntarioExternoConfirmacaoRepository implements VoluntarioExternoConfirmacaoRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('VW_VOLUNTARIO_PERFIL_EFETIVO as v')
$existente = DB::table('CE_VOLUNTARIO_EMAIL_CONFIRMACAO')->where('PESSOA_ID', $pessoaId)->first();
return DB::table('CE_VOLUNTARIO_EMAIL_CONFIRMACAO')->where('PESSOA_ID', $pessoaId)->first();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(AuditLogService $auditLogService)
public function buscarNoEscopo(int $pessoaId, bool $acessoTodasZonas, array $zonasPermitidas): ?object
public function confirmar(int $pessoaId, string $email, string $usuario, ?string $usuarioNome): object
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\ColaboradoresEleitorais;

use App\Repositories\Concerns\AuditaDml;
use App\Repositories\ColaboradoresEleitorais\Contracts\VoluntarioExternoConfirmacaoRepositoryInterface;
use App\Services\Auditoria\AuditLogService;
use Illuminate\Support\Facades\DB;

class VoluntarioExternoConfirmacaoRepository implements VoluntarioExternoConfirmacaoRepositoryInterface
{
    use AuditaDml;

    public function __construct(AuditLogService $auditLogService)
    {
        $this->inicializarAuditoria($auditLogService);
    }

    public function buscarNoEscopo(int $pessoaId, bool $acessoTodasZonas, array $zonasPermitidas): ?object
    {
        $query = DB::table('VW_VOLUNTARIO_PERFIL_EFETIVO as v')
            ->join('planeleito.vw_eleitor_secao_zona_localidade as ev', function ($join) {
                $join->whereRaw('TRIM(ev.num_inscricao) = TRIM(v.num_inscricao)');
            })
            ->selectRaw('v.id, v.nome_civil, v.email, v.status, v.status_origem, v.confirmado_sistema, ev.num_zona')
            ->where('v.id', $pessoaId);

        if (!$acessoTodasZonas) {
            if (empty($zonasPermitidas)) {
                $query->whereRaw('1 = 0');
            } else {
                $query->whereIn(DB::raw("TRIM(NVL(ev.num_zona, ''))"), $zonasPermitidas);
            }
        }

        return $query->first();
    }

    public function confirmar(int $pessoaId, string $email, string $usuario, ?string $usuarioNome): object
    {
        $existente = DB::table('CE_VOLUNTARIO_EMAIL_CONFIRMACAO')->where('PESSOA_ID', $pessoaId)->first();
        $dados = [
            'EMAIL_CONFIRMADO' => trim($email),
            'STATUS' => 'Ativo',
            'USUARIO_CONFIRMACAO' => trim($usuario),
            'USUARIO_NOME_CONFIRMACAO' => $usuarioNome !== null ? trim($usuarioNome) : null,
            'DT_CONFIRMACAO' => DB::raw('SYSDATE'),
            'ATIVO' => 1,
            'DT_ATUALIZACAO' => DB::raw('SYSDATE'),
        ];

        if ($existente) {
            $this->atualizarAuditadoPorId('CE_VOLUNTARIO_EMAIL_CONFIRMACAO', 'CE_VOLUNTARIO_EMAIL_CONFIRMACAO', 'ID', $existente->id, $dados);
        } else {
            $dados['PESSOA_ID'] = $pessoaId;
            $this->inserirAuditado('CE_VOLUNTARIO_EMAIL_CONFIRMACAO', 'CE_VOLUNTARIO_EMAIL_CONFIRMACAO', $dados);
        }

        return DB::table('CE_VOLUNTARIO_EMAIL_CONFIRMACAO')->where('PESSOA_ID', $pessoaId)->first();
    }
}
```
</APP_REPOSITORIES_COLABORADORESELEITORAIS_VOLUNTARIOEXTERNOCONFIRMACAOREPOSITORY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/ColaboradoresEleitorais/VoluntarioExternoAlocacaoRotaQuery.php`
## <APP_SUPPORT_COLABORADORESELEITORAIS_VOLUNTARIOEXTERNOALOCACAOROTAQUERY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/ColaboradoresEleitorais/VoluntarioExternoAlocacaoRotaQuery.php`
- **Namespace Declaração:** `App\Support\ColaboradoresEleitorais`
- **Entidade / Classe:** `class VoluntarioExternoAlocacaoRotaQuery`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('EQUIPE as EQR')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function criar(bool $acessoTodasZonas, array $zonasPermitidas)
public static function criarContagem(bool $acessoTodasZonas, array $zonasPermitidas)
public static function criarExistencia(bool $acessoTodasZonas, array $zonasPermitidas)
public static function criarPorLocalVoto(bool $acessoTodasZonas, array $zonasPermitidas)
public static function carregarDetalhesPagina(
public static function mesclarDetalhesPagina(Collection $voluntarios, iterable $detalhes): Collection
private static function baseQuery(bool $acessoTodasZonas, array $zonasPermitidas, bool $incluirCargo = true)
private static function aplicarFiltroInscricoesPagina($query, array $inscricoes): void
private static function chaveInscricaoLocal(string $inscricao, string $codObjetoLocal): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\ColaboradoresEleitorais;

use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class VoluntarioExternoAlocacaoRotaQuery
{
    /**
     * @param array<int, string> $zonasPermitidas
     */
    public static function criar(bool $acessoTodasZonas, array $zonasPermitidas)
    {
        $query = self::baseQuery($acessoTodasZonas, $zonasPermitidas)
            ->selectRaw("
                TRIM(EQR.NUM_INSCRICAO) AS NUM_INSCRICAO,
                COUNT(*) AS QTD_ROTAS,
                LISTAGG(
                    'Rota #' || TRIM(TO_CHAR(RR.NUMERO))
                    || CASE WHEN RR.DESCRICAO IS NOT NULL THEN ' - ' || TRIM(RR.DESCRICAO) ELSE '' END
                    || CASE WHEN CER.NOME IS NOT NULL THEN ' | Cargo: ' || TRIM(CER.NOME) ELSE '' END,
                    CHR(10)
                ) WITHIN GROUP (ORDER BY RR.NUMERO, CER.NOME, RR.DESCRICAO) AS ROTAS_ALOCADAS
            ")
            ->groupByRaw('TRIM(EQR.NUM_INSCRICAO)');

        return $query;
    }

    /**
     * @param array<int, string> $zonasPermitidas
     */
    public static function criarContagem(bool $acessoTodasZonas, array $zonasPermitidas)
    {
        return self::baseQuery($acessoTodasZonas, $zonasPermitidas, false)
            ->selectRaw('
                TRIM(EQR.NUM_INSCRICAO) AS NUM_INSCRICAO,
                COUNT(*) AS QTD_ROTAS
            ')
            ->groupByRaw('TRIM(EQR.NUM_INSCRICAO)');
    }

    /**
     * @param array<int, string> $zonasPermitidas
     */
    public static function criarExistencia(bool $acessoTodasZonas, array $zonasPermitidas)
    {
        return self::baseQuery($acessoTodasZonas, $zonasPermitidas, false)
            ->selectRaw('1')
            ->whereRaw('TRIM(EQR.NUM_INSCRICAO) = TRIM(v.NUM_INSCRICAO)');
    }

    /**
     * @param array<int, string> $zonasPermitidas
     */
    public static function criarPorLocalVoto(bool $acessoTodasZonas, array $zonasPermitidas)
    {
        return self::baseQuery($acessoTodasZonas, $zonasPermitidas)
            ->join('ROTA_LOCAL as RLR', 'RLR.ROTA_ID', '=', 'RR.ID')
            ->selectRaw("
                TRIM(EQR.NUM_INSCRICAO) AS NUM_INSCRICAO,
                TRIM(RLR.COD_OBJETO_LOCAL) AS COD_OBJETO_LOCAL,
                COUNT(*) AS QTD_ROTAS_COM_LOCAL_VOTO,
                LISTAGG(
                    'Rota #' || TRIM(TO_CHAR(RR.NUMERO))
                    || CASE WHEN RR.DESCRICAO IS NOT NULL THEN ' - ' || TRIM(RR.DESCRICAO) ELSE '' END
                    || CASE WHEN CER.NOME IS NOT NULL THEN ' | Cargo: ' || TRIM(CER.NOME) ELSE '' END,
                    CHR(10)
                ) WITHIN GROUP (ORDER BY RR.NUMERO, CER.NOME, RR.DESCRICAO) AS ROTAS_COM_LOCAL_VOTO
            ")
            ->groupByRaw('TRIM(EQR.NUM_INSCRICAO), TRIM(RLR.COD_OBJETO_LOCAL)');
    }

    /**
     * @param Collection<int, object> $voluntarios
     * @param array<int, string> $zonasPermitidas
     * @return Collection<int, object>
     */
    public static function carregarDetalhesPagina(
        Collection $voluntarios,
        bool $acessoTodasZonas,
        array $zonasPermitidas
    ): Collection {
        if ($voluntarios->isEmpty()) {
            return $voluntarios;
        }

        $inscricoes = $voluntarios
            ->map(static fn (object $voluntario): string => trim((string) ($voluntario->num_inscricao ?? '')))
            ->filter(static fn (string $inscricao): bool => $inscricao !== '')
            ->unique()
            ->values()
            ->all();

        if (empty($inscricoes)) {
            return self::mesclarDetalhesPagina($voluntarios, collect());
        }

        $rotas = self::criar($acessoTodasZonas, $zonasPermitidas);
        self::aplicarFiltroInscricoesPagina($rotas, $inscricoes);

        $rotasPorLocal = self::criarPorLocalVoto($acessoTodasZonas, $zonasPermitidas);
        self::aplicarFiltroInscricoesPagina($rotasPorLocal, $inscricoes);

        $detalhes = DB::query()
            ->fromSub($rotas, 'AR')
            ->leftJoinSub($rotasPorLocal, 'ARV', function ($join) {
                $join->whereRaw('TRIM(ARV.NUM_INSCRICAO) = TRIM(AR.NUM_INSCRICAO)');
            })
            ->selectRaw('
                AR.NUM_INSCRICAO as num_inscricao,
                AR.QTD_ROTAS as qtd_rotas,
                AR.ROTAS_ALOCADAS as rotas_alocadas,
                ARV.COD_OBJETO_LOCAL as cod_objeto_local,
                ARV.QTD_ROTAS_COM_LOCAL_VOTO as qtd_rotas_com_local_voto,
                ARV.ROTAS_COM_LOCAL_VOTO as rotas_com_local_voto
            ')
            ->get();

        return self::mesclarDetalhesPagina($voluntarios, $detalhes);
    }

    /**
     * @param Collection<int, object> $voluntarios
     * @param iterable<int, object> $detalhes
     * @return Collection<int, object>
     */
    public static function mesclarDetalhesPagina(Collection $voluntarios, iterable $detalhes): Collection
    {
        $detalhes = collect($detalhes);
        $rotasPorInscricao = $detalhes
            ->filter(static fn (object $item): bool => trim((string) ($item->num_inscricao ?? '')) !== '')
            ->groupBy(static fn (object $item): string => trim((string) $item->num_inscricao))
            ->map(static fn (Collection $itens): ?object => $itens->first());
        $rotasPorInscricaoELocal = $detalhes
            ->filter(static fn (object $item): bool => trim((string) ($item->num_inscricao ?? '')) !== ''
                && trim((string) ($item->cod_objeto_local ?? '')) !== '')
            ->groupBy(static fn (object $item): string => self::chaveInscricaoLocal(
                (string) $item->num_inscricao,
                (string) $item->cod_objeto_local
            ))
            ->map(static fn (Collection $itens): ?object => $itens->first());

        return $voluntarios->map(static function (object $voluntario) use ($rotasPorInscricao, $rotasPorInscricaoELocal): object {
            $inscricao = trim((string) ($voluntario->num_inscricao ?? ''));
            $codObjetoLocal = trim((string) ($voluntario->cod_objeto_local_voto ?? ''));
            $rota = $rotasPorInscricao->get($inscricao);
            $rotaLocal = $codObjetoLocal !== ''
                ? $rotasPorInscricaoELocal->get(self::chaveInscricaoLocal($inscricao, $codObjetoLocal))
                : null;

            $voluntario->qtd_rotas_alocadas = (string) ((int) ($rota->qtd_rotas ?? 0));
            $voluntario->rotas_alocadas = $rota->rotas_alocadas ?? null;
            $voluntario->qtd_rotas_com_local_voto = (string) ((int) ($rotaLocal->qtd_rotas_com_local_voto ?? 0));
            $voluntario->rota_contem_local_voto = ((int) $voluntario->qtd_rotas_com_local_voto) > 0 ? '1' : '0';
            $voluntario->rotas_com_local_voto = $rotaLocal->rotas_com_local_voto ?? null;

            return $voluntario;
        });
    }

    /**
     * @param array<int, string> $zonasPermitidas
     */
    private static function baseQuery(bool $acessoTodasZonas, array $zonasPermitidas, bool $incluirCargo = true)
    {
        $query = DB::table('EQUIPE as EQR')
            ->join('EQUIPE_VINCULO as EVR', function ($join) {
                $join->whereRaw('EVR.ID = EQR.EQUIPE_VINCULO_ID')
                    ->where('EVR.TIPO_VINCULO', 'ROTA');
            })
            ->join('ROTA as RR', 'RR.ID', '=', 'EVR.VINCULO_ID');

        if ($incluirCargo) {
            $query->join('CARGOS_EQUIPE as CER', 'CER.ID', '=', 'EQR.CARGO_ID');
        }

        if (!$acessoTodasZonas) {
            $query->join('ZONA as ZR', 'ZR.ID', '=', 'RR.ZONA_ID');

            $zonas = collect($zonasPermitidas)
                ->map(static fn ($zona) => trim((string) $zona))
                ->filter(static fn (string $zona): bool => $zona !== '')
                ->unique()
                ->values()
                ->all();

            if (empty($zonas)) {
                $query->whereRaw('1 = 0');
            } else {
                $query->whereIn(DB::raw('TRIM(TO_CHAR(ZR.NUM_ZONA))'), $zonas);
            }
        }

        return $query;
    }

    /**
     * @param array<int, string> $inscricoes
     */
    private static function aplicarFiltroInscricoesPagina($query, array $inscricoes): void
    {
        $query->whereRaw(
            "TRIM(EQR.NUM_INSCRICAO) IN (
                SELECT pagina.NUM_INSCRICAO
                FROM JSON_TABLE(
                    ?,
                    '$[*]' COLUMNS (NUM_INSCRICAO VARCHAR2(100) PATH '$')
                ) pagina
            )",
            [json_encode(array_values($inscricoes), JSON_THROW_ON_ERROR)]
        );
    }

    private static function chaveInscricaoLocal(string $inscricao, string $codObjetoLocal): string
    {
        return trim($inscricao) . '|' . trim($codObjetoLocal);
    }
}
```
</APP_SUPPORT_COLABORADORESELEITORAIS_VOLUNTARIOEXTERNOALOCACAOROTAQUERY_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_01_120000_create_cad_supervisor_banco_table.php`
## <DATABASE_MIGRATIONS_2026_05_01_120000_CREATE_CAD_SUPERVISOR_BANCO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_01_120000_create_cad_supervisor_banco_table.php`
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
CREATE TABLE cad_supervisor_banco (
    id_supervisor_banco   NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo_banco          VARCHAR2(20 CHAR) NOT NULL,
    nome_banco            VARCHAR2(255 CHAR) NOT NULL,
    ispb                  VARCHAR2(20 CHAR),
    ativo                 CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    dt_criacao            DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao        DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT uk_csb_codigo UNIQUE (codigo_banco),
    CONSTRAINT ck_csb_ativo CHECK (ativo IN ('S', 'N'))
)
SQL
        );
    }

    public function down(): void
    {
        DB::statement('DROP TABLE cad_supervisor_banco');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_01_120000_CREATE_CAD_SUPERVISOR_BANCO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_01_131000_create_cad_supervisor_pergunta_table.php`
## <DATABASE_MIGRATIONS_2026_05_01_131000_CREATE_CAD_SUPERVISOR_PERGUNTA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_01_131000_create_cad_supervisor_pergunta_table.php`
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
CREATE TABLE cad_supervisor_pergunta (
    id_supervisor_pergunta   NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    codigo                   VARCHAR2(100 CHAR) NOT NULL,
    grupo                    VARCHAR2(60 CHAR) NOT NULL,
    label                    VARCHAR2(500 CHAR) NOT NULL,
    tipo                     VARCHAR2(30 CHAR) DEFAULT 'CHECKBOX' NOT NULL,
    obrigatoria              CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    ativa                    CHAR(1 CHAR) DEFAULT 'S' NOT NULL,
    ordem                    NUMBER NOT NULL,
    dt_criacao               DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao           DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT uk_cspg_codigo UNIQUE (codigo),
    CONSTRAINT ck_cspg_obrigatoria CHECK (obrigatoria IN ('S', 'N')),
    CONSTRAINT ck_cspg_ativa CHECK (ativa IN ('S', 'N'))
)
SQL
        );

        DB::statement(<<<'SQL'
INSERT INTO cad_supervisor_pergunta (codigo, grupo, label, tipo, obrigatoria, ativa, ordem)
SELECT codigo, grupo, label, tipo, obrigatoria, ativa, ordem
FROM (
    SELECT 'autoriza_email' AS codigo, 'AUTORIZACOES_DISPONIBILIDADES' AS grupo, 'Autorizo receber convocação por e-mail' AS label, 'CHECKBOX' AS tipo, 'S' AS obrigatoria, 'S' AS ativa, 10 AS ordem FROM dual
    UNION ALL
    SELECT 'disponibilidade_ead' AS codigo, 'AUTORIZACOES_DISPONIBILIDADES' AS grupo, 'Tenho disponibilidade, facilidades e recursos para fazer treinamento a distância - EAD' AS label, 'CHECKBOX' AS tipo, 'S' AS obrigatoria, 'S' AS ativa, 20 AS ordem FROM dual
    UNION ALL
    SELECT 'autoriza_whatsapp' AS codigo, 'AUTORIZACOES_DISPONIBILIDADES' AS grupo, 'Autorizo receber convocação por Whatsapp' AS label, 'CHECKBOX' AS tipo, 'S' AS obrigatoria, 'S' AS ativa, 30 AS ordem FROM dual
    UNION ALL
    SELECT 'disponibilidade_viagem_interior' AS codigo, 'AUTORIZACOES_DISPONIBILIDADES' AS grupo, 'Disponibilidade de viajar para o interior nas eleições' AS label, 'CHECKBOX' AS tipo, 'S' AS obrigatoria, 'S' AS ativa, 40 AS ordem FROM dual
    UNION ALL
    SELECT 'disponibilidade_viagem_rural' AS codigo, 'AUTORIZACOES_DISPONIBILIDADES' AS grupo, 'Disponibilidade de viajar para zona rural ou locais de difícil acesso (Ldas) nas eleições' AS label, 'CHECKBOX' AS tipo, 'S' AS obrigatoria, 'S' AS ativa, 50 AS ordem FROM dual
    UNION ALL
    SELECT 'aceite_lgpd' AS codigo, 'LGPD' AS grupo, 'Li e aceito os termos de uso e tratamento dos meus dados pessoais conforme descrito acima.' AS label, 'CHECKBOX' AS tipo, 'S' AS obrigatoria, 'S' AS ativa, 60 AS ordem FROM dual
)
SQL
        );
    }

    public function down(): void
    {
        DB::statement('DROP TABLE cad_supervisor_pergunta');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_01_131000_CREATE_CAD_SUPERVISOR_PERGUNTA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_05_01_131100_create_cad_supervisor_resposta_table.php`
## <DATABASE_MIGRATIONS_2026_05_01_131100_CREATE_CAD_SUPERVISOR_RESPOSTA_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_05_01_131100_create_cad_supervisor_resposta_table.php`
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
CREATE TABLE cad_supervisor_resposta (
    id_supervisor_resposta    NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_supervisor_predio      NUMBER NOT NULL,
    id_supervisor_pergunta    NUMBER NOT NULL,
    valor_resposta            VARCHAR2(3 CHAR) NOT NULL,
    dt_criacao                DATE DEFAULT SYSDATE NOT NULL,
    dt_atualizacao            DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT uk_cspr_supervisor_pergunta UNIQUE (id_supervisor_predio, id_supervisor_pergunta),
    CONSTRAINT fk_cspr_supervisor
        FOREIGN KEY (id_supervisor_predio) REFERENCES cad_supervisor_predio (id_supervisor_predio),
    CONSTRAINT fk_cspr_pergunta
        FOREIGN KEY (id_supervisor_pergunta) REFERENCES cad_supervisor_pergunta (id_supervisor_pergunta),
    CONSTRAINT ck_cspr_valor CHECK (valor_resposta IN ('SIM', 'NAO'))
)
SQL
        );

        DB::statement(<<<'SQL'
INSERT INTO cad_supervisor_resposta (
    id_supervisor_predio,
    id_supervisor_pergunta,
    valor_resposta,
    dt_criacao,
    dt_atualizacao
)
SELECT a.id_supervisor_predio,
       p.id_supervisor_pergunta,
       CASE p.codigo
           WHEN 'autoriza_email' THEN a.autoriza_email
           WHEN 'disponibilidade_ead' THEN a.disponibilidade_ead
           WHEN 'autoriza_whatsapp' THEN a.autoriza_whatsapp
           WHEN 'disponibilidade_viagem_interior' THEN a.disponibilidade_viagem_interior
           WHEN 'disponibilidade_viagem_rural' THEN a.disponibilidade_viagem_rural
           WHEN 'aceite_lgpd' THEN a.aceite_lgpd
       END AS valor_resposta,
       a.dt_criacao,
       a.dt_atualizacao
FROM cad_supervisor_predio_autorizacao a
INNER JOIN cad_supervisor_pergunta p
    ON p.codigo IN (
        'autoriza_email',
        'disponibilidade_ead',
        'autoriza_whatsapp',
        'disponibilidade_viagem_interior',
        'disponibilidade_viagem_rural',
        'aceite_lgpd'
    )
SQL
        );
    }

    public function down(): void
    {
        DB::statement('DROP TABLE cad_supervisor_resposta');
    }
};
```
</DATABASE_MIGRATIONS_2026_05_01_131100_CREATE_CAD_SUPERVISOR_RESPOSTA_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_22_100000_create_ce_voluntario_email_confirmacao_table.php`
## <DATABASE_MIGRATIONS_2026_06_22_100000_CREATE_CE_VOLUNTARIO_EMAIL_CONFIRMACAO_TABLE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_22_100000_create_ce_voluntario_email_confirmacao_table.php`
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
private function tableExists(string $table): bool
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
        if ($this->tableExists('CE_VOLUNTARIO_EMAIL_CONFIRMACAO')) {
            return;
        }

        DB::statement(<<<'SQL'
CREATE TABLE CE_VOLUNTARIO_EMAIL_CONFIRMACAO (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    PESSOA_ID NUMBER NOT NULL,
    EMAIL_CONFIRMADO VARCHAR2(255 CHAR) NOT NULL,
    STATUS VARCHAR2(255 CHAR) DEFAULT 'ATIVO' NOT NULL,
    USUARIO_CONFIRMACAO VARCHAR2(120 CHAR) NOT NULL,
    USUARIO_NOME_CONFIRMACAO VARCHAR2(160 CHAR),
    DT_CONFIRMACAO DATE DEFAULT SYSDATE NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
    DT_ATUALIZACAO DATE,
    CONSTRAINT CK_CE_VOL_EMAIL_CONF_ATIVO CHECK (ATIVO IN (0, 1))
)
SQL
        );
        DB::statement('CREATE UNIQUE INDEX UX_CE_VOL_EMAIL_CONF_01 ON CE_VOLUNTARIO_EMAIL_CONFIRMACAO (PESSOA_ID)');
        DB::statement('CREATE INDEX IX_CE_VOL_EMAIL_CONF_01 ON CE_VOLUNTARIO_EMAIL_CONFIRMACAO (LOWER(TRIM(EMAIL_CONFIRMADO)), ATIVO)');
    }

    public function down(): void
    {
        if ($this->tableExists('CE_VOLUNTARIO_EMAIL_CONFIRMACAO')) {
            DB::statement('DROP TABLE CE_VOLUNTARIO_EMAIL_CONFIRMACAO');
        }
    }

    private function tableExists(string $table): bool
    {
        $row = DB::selectOne('SELECT COUNT(*) AS TOTAL FROM USER_TABLES WHERE TABLE_NAME = ?', [strtoupper($table)]);
        return (int) ($row->total ?? $row->TOTAL ?? 0) > 0;
    }
};
```
</DATABASE_MIGRATIONS_2026_06_22_100000_CREATE_CE_VOLUNTARIO_EMAIL_CONFIRMACAO_TABLE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `database/migrations/2026_06_22_100300_backfill_status_confirmacao_voluntario.php`
## <DATABASE_MIGRATIONS_2026_06_22_100300_BACKFILL_STATUS_CONFIRMACAO_VOLUNTARIO_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `database/migrations/2026_06_22_100300_backfill_status_confirmacao_voluntario.php`
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
        // Converge o status persistido pela confirmacao interna para a mesma
        // capitalizacao da fonte (ac_pessoa.vw_voluntario_perfil = 'Ativo').
        // O valor legado 'ATIVO' divergia da fonte e fazia NVL(c.status, v.status)
        // produzir dois valores distintos ('ATIVO' e 'Ativo') nos filtros.
        DB::statement(<<<'SQL'
UPDATE CE_VOLUNTARIO_EMAIL_CONFIRMACAO
   SET STATUS = 'Ativo',
       DT_ATUALIZACAO = SYSDATE
 WHERE STATUS = 'ATIVO'
SQL
        );
    }

    public function down(): void
    {
        DB::statement(<<<'SQL'
UPDATE CE_VOLUNTARIO_EMAIL_CONFIRMACAO
   SET STATUS = 'ATIVO',
       DT_ATUALIZACAO = SYSDATE
 WHERE STATUS = 'Ativo'
SQL
        );
    }
};
```
</DATABASE_MIGRATIONS_2026_06_22_100300_BACKFILL_STATUS_CONFIRMACAO_VOLUNTARIO_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/Architecture/SourceContracts/VoluntarioExternoEmailConfirmacaoTest.php`
## <TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_VOLUNTARIOEXTERNOEMAILCONFIRMACAOTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/Architecture/SourceContracts/VoluntarioExternoEmailConfirmacaoTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class VoluntarioExternoEmailConfirmacaoTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function schema_e_view_preservam_origem_e_aplicam_confirmacao_apenas_ao_mesmo_email(): void
public function rota_e_acl_de_confirmacao_sao_exclusivas_do_grupo_administrativo(): void
public function confirma_email_pendente_obtido_no_backend_e_registra_operador_da_sessao(): void
public function confirmacao_persiste_status_na_mesma_capitalizacao_da_fonte(): void
public function backfill_normaliza_status_legado_para_capitalizacao_da_fonte(): void
public function nao_confirma_voluntario_fora_do_escopo(): void
public function interface_exibe_botao_modal_e_dados_do_responsavel(): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Http\Controllers\ColaboradoresEleitorais\VoluntarioExternoConfirmacaoController;
use App\Repositories\ColaboradoresEleitorais\Contracts\VoluntarioExternoConfirmacaoRepositoryInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class VoluntarioExternoEmailConfirmacaoTest extends TestCase
{
    protected function tearDown(): void
    {
        session()->flush();
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function schema_e_view_preservam_origem_e_aplicam_confirmacao_apenas_ao_mesmo_email(): void
    {
        $tabela = file_get_contents(database_path('migrations/2026_06_22_100000_create_ce_voluntario_email_confirmacao_table.php'));
        $view = file_get_contents(database_path('migrations/2026_06_22_100100_create_vw_voluntario_perfil_efetivo.php'));
        $this->assertStringContainsString('CREATE TABLE CE_VOLUNTARIO_EMAIL_CONFIRMACAO', $tabela);
        $this->assertStringContainsString('UX_CE_VOL_EMAIL_CONF_01', $tabela);
        $this->assertStringContainsString('NVL(c.status, v.status) AS status', $view);
        $this->assertStringContainsString('v.status AS status_origem', $view);
        $this->assertStringContainsString('LOWER(TRIM(c.email_confirmado)) = LOWER(TRIM(v.email))', $view);
    }

    #[Test]
    public function rota_e_acl_de_confirmacao_sao_exclusivas_do_grupo_administrativo(): void
    {
        $rotas = file_get_contents(base_path('routes/web.php'));
        $acl = file_get_contents(database_path('migrations/2026_06_22_100200_grant_voluntario_confirmar_email_acl.php'));
        $this->assertStringContainsString('externos.voluntarios.confirmar-email', $rotas);
        $this->assertStringContainsString("private const GROUP_NAME = 'PLANELEITO_COLABORADORES_ADMIN'", $acl);
        $this->assertStringNotContainsString('PLANELEITO_COLABORADORES_EXTERNOS', $acl);
    }

    #[Test]
    public function confirma_email_pendente_obtido_no_backend_e_registra_operador_da_sessao(): void
    {
        session()->put(['user' => ['username' => 'operador', 'name' => 'Operador Teste'], 'acesso_todas_zonas' => true]);
        $repository = Mockery::mock(VoluntarioExternoConfirmacaoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with(10, true, [])->andReturn((object) ['email' => 'pessoa@teste.gov.br', 'status_origem' => 'PENDENTE', 'confirmado_sistema' => 0]);
        $repository->shouldReceive('confirmar')->once()->with(10, 'pessoa@teste.gov.br', 'operador', 'Operador Teste')->andReturn((object) ['usuario_nome_confirmacao' => 'Operador Teste', 'usuario_confirmacao' => 'operador', 'dt_confirmacao' => '22/06/2026 10:00']);
        DB::shouldReceive('transaction')->once()->andReturnUsing(static fn ($callback) => $callback());
        $response = (new VoluntarioExternoConfirmacaoController($repository))->confirmar(Request::create('/', 'POST'), 10);
        $this->assertSame(200, $response->status());
        $this->assertSame('Ativo', $response->getData(true)['status'] ?? null);
    }

    #[Test]
    public function confirmacao_persiste_status_na_mesma_capitalizacao_da_fonte(): void
    {
        $repositorio = file_get_contents(app_path('Repositories/ColaboradoresEleitorais/VoluntarioExternoConfirmacaoRepository.php'));
        $controller = file_get_contents(app_path('Http/Controllers/ColaboradoresEleitorais/VoluntarioExternoConfirmacaoController.php'));
        $this->assertStringContainsString("'STATUS' => 'Ativo'", $repositorio);
        $this->assertStringNotContainsString("'STATUS' => 'ATIVO'", $repositorio);
        $this->assertStringNotContainsString("'status' => 'ATIVO'", $controller);
    }

    #[Test]
    public function backfill_normaliza_status_legado_para_capitalizacao_da_fonte(): void
    {
        $backfill = file_get_contents(database_path('migrations/2026_06_22_100300_backfill_status_confirmacao_voluntario.php'));
        $this->assertStringContainsString('UPDATE CE_VOLUNTARIO_EMAIL_CONFIRMACAO', $backfill);
        $this->assertStringContainsString("SET STATUS = 'Ativo'", $backfill);
        $this->assertStringContainsString("WHERE STATUS = 'ATIVO'", $backfill);
    }

    #[Test]
    public function nao_confirma_voluntario_fora_do_escopo(): void
    {
        session()->put(['acesso_todas_zonas' => true]);
        $repository = Mockery::mock(VoluntarioExternoConfirmacaoRepositoryInterface::class);
        $repository->shouldReceive('buscarNoEscopo')->once()->with(99, true, [])->andReturnNull();
        $repository->shouldNotReceive('confirmar');
        $response = (new VoluntarioExternoConfirmacaoController($repository))->confirmar(Request::create('/', 'POST'), 99);
        $this->assertSame(404, $response->status());
    }

    #[Test]
    public function interface_exibe_botao_modal_e_dados_do_responsavel(): void
    {
        $blade = file_get_contents(resource_path('views/colaboradores-eleitorais/externos/voluntarios/index.blade.php'));
        $this->assertStringContainsString('btn-confirmar-email-voluntario', $blade);
        $this->assertStringContainsString('podeConfirmarEmail ?? false', $blade);
        $this->assertStringContainsString('modalConfirmarEmailVoluntario', $blade);
        $this->assertStringContainsString('<strong>Confirmado por:</strong>', $blade);
        $this->assertStringContainsString('<strong>Confirmado em:</strong>', $blade);
    }
}
```
</TESTS_UNIT_ARCHITECTURE_SOURCECONTRACTS_VOLUNTARIOEXTERNOEMAILCONFIRMACAOTEST_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `tests/Unit/DistribuirSupervisoresCapacitacoesCommandTest.php`
## <TESTS_UNIT_DISTRIBUIRSUPERVISORESCAPACITACOESCOMMANDTEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `tests/Unit/DistribuirSupervisoresCapacitacoesCommandTest.php`
- **Namespace Declaração:** `Tests\Unit`
- **Entidade / Classe:** `class DistribuirSupervisoresCapacitacoesCommandTest extends TestCase`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
protected function tearDown(): void
public function comando_executa_somente_simulacao_por_padrao(): void
public function comando_exibe_detalhes_e_aplica_quando_commit_e_informado(): void
public function comando_retorna_falha_operacional_sem_propagar_excecao(): void
private function resultado(bool $commit, int $inseridos): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace Tests\Unit;

use App\Services\SupervisoresPredio\SupervisorPredioCapacitacaoDistribuicaoService;
use DomainException;
use Mockery;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

class DistribuirSupervisoresCapacitacoesCommandTest extends TestCase
{
    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    #[Test]
    public function comando_executa_somente_simulacao_por_padrao(): void
    {
        $service = Mockery::mock(SupervisorPredioCapacitacaoDistribuicaoService::class);
        $service->shouldReceive('distribuir')->once()->with(false)->andReturn($this->resultado(false, 0));
        $this->app->instance(SupervisorPredioCapacitacaoDistribuicaoService::class, $service);

        $this->artisan('supervisores-predio:distribuir-capacitacoes')
            ->expectsOutput('Simulação concluída. 243 alocação(ões) planejada(s); 0 já existente(s).')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_exibe_detalhes_e_aplica_quando_commit_e_informado(): void
    {
        $service = Mockery::mock(SupervisorPredioCapacitacaoDistribuicaoService::class);
        $service->shouldReceive('distribuir')->once()->with(true)->andReturn($this->resultado(true, 243));
        $this->app->instance(SupervisorPredioCapacitacaoDistribuicaoService::class, $service);

        $this->artisan('supervisores-predio:distribuir-capacitacoes', [
            '--commit' => true,
            '--detalhes' => true,
        ])
            ->expectsOutput('Distribuição aplicada. 243 vínculo(s) inserido(s); 0 já existente(s).')
            ->expectsOutputToContain('000000000001')
            ->assertExitCode(0);
    }

    #[Test]
    public function comando_retorna_falha_operacional_sem_propagar_excecao(): void
    {
        $service = Mockery::mock(SupervisorPredioCapacitacaoDistribuicaoService::class);
        $service->shouldReceive('distribuir')->once()->with(false)->andThrow(new DomainException('Conjunto de turmas inválido.'));
        $this->app->instance(SupervisorPredioCapacitacaoDistribuicaoService::class, $service);

        $this->artisan('supervisores-predio:distribuir-capacitacoes')
            ->expectsOutput('Falha: Conjunto de turmas inválido.')
            ->assertExitCode(1);
    }

    /** @return array<string, mixed> */
    private function resultado(bool $commit, int $inseridos): array
    {
        return [
            'commit' => $commit,
            'grupo' => 'planeleito_admin',
            'municipio' => 'RIO BRANCO',
            'capacidade' => 25,
            'total_supervisores' => 243,
            'total_eventos' => 10,
            'total_ja_alocados' => 0,
            'total_planejados' => 243,
            'total_inseridos' => $inseridos,
            'eventos' => [[
                'id' => 101,
                'nome' => 'Supervisores de Prédio: Capacitação - Turma 1',
                'inicio' => '2026-09-28 08:00:00',
                'total_atual' => 0,
                'total_planejado' => 25,
                'total_final' => 25,
                'zonas_finais' => ['1' => 14, '9' => 11],
            ]],
            'alocacoes' => [[
                'evento_id' => 101,
                'evento_nome' => 'Supervisores de Prédio: Capacitação - Turma 1',
                'inicio' => '2026-09-28 08:00:00',
                'num_inscricao' => '000000000001',
                'nome' => 'ANA TESTE',
                'num_zona_trabalho' => '1',
                'local_atuacao' => 'LOCAL 1',
            ]],
        ];
    }
}
```
</TESTS_UNIT_DISTRIBUIRSUPERVISORESCAPACITACOESCOMMANDTEST_PHP>

