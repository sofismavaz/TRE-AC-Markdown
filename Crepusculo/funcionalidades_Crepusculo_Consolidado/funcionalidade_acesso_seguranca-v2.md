# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Controle de Acesso e Segurança (ACL)

### 1. Visão Geral e Escopo Funcional
**Propósito**: Gestão centralizada de autenticação, autorização baseada em papéis/grupos (ACL), gestão do catálogo de rotas, controle de sessão de usuários e aplicação de escopos operacionais (unidades e zonas eleitorais).

**Status do Sistema**: Desenvolvido e em Produção.
**Premissas do Módulo**:
- Nenhuma rota interna ou serviço protegido pode ser executado sem validação da ACL efetiva da rota.
- O contexto de acesso do usuário é montado uma única vez na sessão inicial (`ConfigureUserSession`) e propagado de forma imutável pelas camadas de Controller, Service e Repository.
- Integração nativa com o proxy reverso **Authelia** e Active Directory (AD) para autenticação SSO e duplo fator (MFA).

---

### 2. Regras de Negócio, Validações e Parâmetros

#### RN-ACL-001: Validação de Escopo Zonal e de Unidade
- Quando a rota exige escopo (`aplica_escopo_unidade = 1`), a consulta deve restringir os dados aos conjuntos `unidades_permitidas_ids` ou `cod_zonas_permitidas`.
- Se o usuário possui a flag `acesso_todas_zonas = true` ou acesso à Zona 0, o filtro territorial é ignorado.
- Se o usuário não possui unidades/zonas permitidas em seu perfil para uma rota restrita, o sistema deve falhar fechado (*fail-closed*) e retornar erro HTTP 403 (Acesso Negado) ou resultado vazio nas consultas.

#### RN-ACL-002: Imutabilidade do Contexto de Acesso
- Repositories e Services **nunca** devem descobrir o contexto de acesso lendo diretamente `session()`, `auth()` ou `request()`.
- O contexto deve ser injetado explicitamente via DTO/Value Object (ex: `EscopoUnidade`, `EscopoZonal`) oriundo da camada de Controller/Middleware.

#### RN-ACL-003: Bypass de Ambiência
- O bypass automático de autenticação para desenvolvimento local (`APP_ENV=local`) é **estritamente proibido** em ambiente de produção (`APP_ENV=production`).

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

#### DDL / DML Relacional (Tabelas do Núcleo de Acesso):
```sql
-- Catálogo de Grupos de Acesso
CREATE TABLE ADM_GRUPO_ACESSO (
    ID NUMBER(10) PRIMARY KEY,
    NOME VARCHAR2(100 NOT NULL UNIQUE),
    DESCRICAO VARCHAR2(255),
    ESCOPO_GLOBAL NUMBER(1) DEFAULT 0 NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Catálogo de Rotas Protegidas do Sistema
CREATE TABLE ADM_ACESSO_ROTA (
    ID NUMBER(10) PRIMARY KEY,
    ROTA_NOME VARCHAR2(150 NOT NULL UNIQUE),
    URI VARCHAR2(255) NOT NULL,
    METODO VARCHAR2(10) NOT NULL,
    MENU_PATH VARCHAR2(255),
    APLICA_ESCOPO_UNIDADE NUMBER(1) DEFAULT 1 NOT NULL,
    IGNORA_UNIDADES_PERMITIDAS NUMBER(1) DEFAULT 0 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Relacionamento N:N entre Grupos e Rotas
CREATE TABLE ADM_ACESSO_ROTA_GRUPO (
    ROTA_ID NUMBER(10) NOT NULL,
    GRUPO_ID NUMBER(10) NOT NULL,
    CONSTRAINT PK_ADM_ROTA_GRUPO PRIMARY KEY (ROTA_ID, GRUPO_ID),
    CONSTRAINT FK_ARG_ROTA FOREIGN KEY (ROTA_ID) REFERENCES ADM_ACESSO_ROTA(ID) ON DELETE CASCADE,
    CONSTRAINT FK_ARG_GRUPO FOREIGN KEY (GRUPO_ID) REFERENCES ADM_GRUPO_ACESSO(ID) ON DELETE CASCADE
);

-- Relacionamento N:N entre Grupos e Macroprojetos
CREATE TABLE ADM_GRUPO_MACROPROJETO (
    GRUPO_ID NUMBER(10) NOT NULL,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    CONSTRAINT PK_ADM_GRUPO_MACRO PRIMARY KEY (GRUPO_ID, MACROPROJETO_ID),
    CONSTRAINT FK_AGM_GRUPO FOREIGN KEY (GRUPO_ID) REFERENCES ADM_GRUPO_ACESSO(ID) ON DELETE CASCADE
);

-- Trilha de Auditoria Técnica de Operações (DML)
CREATE TABLE AUDITORIA_ACAO (
    ID NUMBER(10) PRIMARY KEY,
    USUARIO VARCHAR2(100) NOT NULL,
    USUARIO_NOME VARCHAR2(150),
    ENTIDADE VARCHAR2(100) NOT NULL,
    ACAO VARCHAR2(20) NOT NULL, -- INSERT, UPDATE, DELETE
    REGISTRO_ID VARCHAR2(100),
    PAYLOAD_ANTES CLOB,
    PAYLOAD_DEPOIS CLOB,
    IP_ORIGEM VARCHAR2(45),
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
```

#### Visão de Unidades Organogramas:
- **`VW_UNIDADE`**: Visão do schema corporativo contendo a árvore hierárquica de unidades administrativas, zonas eleitorais e cartórios.

---

### 4. Componentes e Código PHP Essencial

#### Middleware de Sessão e Configuração de Acesso (`ConfigureUserSession.php`)
```php
namespace App\Http\Middleware;

use App\Services\Acesso\AcessoRotaPermissaoService;
use App\Support\Access\EscopoZonal;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ConfigureUserSession
{
    public function __construct(private readonly AcessoRotaPermissaoService $permissaoService) {}

    public function handle(Request $request, Closure $next): Response
    {
        $username = $request->header('HTTP_REMOTE_USER') ?? session('username');
        
        if (!$username && config('app.env') === 'local') {
            $username = 'usuario.local';
        }

        if (!$username) {
            return redirect()->route('login');
        }

        // Carrega grupos do Authelia/AD e monta permissões na sessão
        $grupos = $request->header('HTTP_REMOTE_GROUPS') ? explode(',', $request->header('HTTP_REMOTE_GROUPS')) : session('user_groups', []);
        
        session([
            'username' => $username,
            'user_groups' => $grupos,
            'is_admin' => in_array('PLANELEITO_ADMIN', $grupos),
        ]);

        $rotaAtual = $request->route()?->getName();
        if ($rotaAtual && !$this->permissaoService->podeAcessarRota($rotaAtual, $grupos)) {
            if ($request->expectsJson()) {
                return response()->json(['error' => 'Acesso negado para a rota informada.'], 403);
            }
            abort(403, 'Acesso não autorizado para esta funcionalidade.');
        }

        return $next($request);
    }
}
```

#### Contrato do Repositório de Acesso (`AcessoRepositoryInterface.php`)
```php
namespace App\Repositories\Acesso\Contracts;

use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;

interface AcessoRepositoryInterface
{
    public function listarGrupos(?string $busca = null, int $perPage = 15): LengthAwarePaginator;
    public function buscarGrupo(int $id): ?object;
    public function listarRotasPorGrupo(array $grupoIds): Collection;
    public function listarMacroprojetosPorGrupo(array $grupoIds): Collection;
    public function sincronizarRotasGrupo(int $grupoId, array $rotaIds): void;
    public function sincronizarMacroprojetosGrupo(int $grupoId, array $macroprojetoIds): void;
}
```

---

### 5. Fronteiras de Integração e Segurança
- **Provedores de Identidade**: Authelia / Active Directory via HTTP Headers (`HTTP_REMOTE_USER`, `HTTP_REMOTE_GROUPS`, `HTTP_REMOTE_NAME`, `HTTP_REMOTE_EMAIL`).
- **Auditoria Imutável**: Toda alteração de grupos ou rotas dispara registro automático em `AUDITORIA_ACAO` via trait `AuditaDml`.
