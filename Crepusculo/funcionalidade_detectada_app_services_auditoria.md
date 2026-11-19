# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_services_auditoria`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 6 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Auditoria/AuditLogService.php`
## <APP_SERVICES_AUDITORIA_AUDITLOGSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Auditoria/AuditLogService.php`
- **Namespace Declaração:** `App\Services\Auditoria`
- **Entidade / Classe:** `class AuditLogService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function registrarAcao(
private function resolverUsuario(): ?string
private function resolverRota(?Request $request): ?string
private function resolverIp(?Request $request): ?string
private function resolverRequestId(?Request $request): ?string
private function toJson(mixed $data): ?string
private function sanitizarDadosSensiveis(string $entidade, mixed $dados): mixed
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Auditoria;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Http\Request;

class AuditLogService
{
    public function __construct(
        private readonly AuditLogRepositoryInterface $repository
    ) {
    }

    public function registrarAcao(
        string $acao,
        string $entidade,
        int|string|null $registroId,
        string $comandoSql,
        array $bindings = [],
        mixed $dadosAntes = null,
        mixed $dadosDepois = null,
        bool $sucesso = true,
        ?string $erroMsg = null
    ): void {
        $acaoNormalizada = strtoupper(trim($acao));
        if (!in_array($acaoNormalizada, ['INSERT', 'UPDATE', 'DELETE'], true)) {
            throw new \InvalidArgumentException('A ação de auditoria deve ser INSERT, UPDATE ou DELETE.');
        }

        $request = request();
        $entidadeNormalizada = strtoupper(trim($entidade));
        $this->repository->inserir([
            'usuario' => $this->resolverUsuario(),
            'rota' => $this->resolverRota($request),
            'ip' => $this->resolverIp($request),
            'request_id' => $this->resolverRequestId($request),
            'entidade' => $entidadeNormalizada,
            'registro_id' => $registroId !== null ? (string) $registroId : null,
            'acao' => $acaoNormalizada,
            'comando_sql' => $comandoSql,
            'bindings_json' => $this->toJson($this->sanitizarDadosSensiveis($entidadeNormalizada, $bindings)),
            'dados_antes_json' => $this->toJson($this->sanitizarDadosSensiveis($entidadeNormalizada, $dadosAntes)),
            'dados_depois_json' => $this->toJson($this->sanitizarDadosSensiveis($entidadeNormalizada, $dadosDepois)),
            'sucesso' => $sucesso ? 'S' : 'N',
            'erro_msg' => $erroMsg ? mb_substr($erroMsg, 0, 4000) : null,
        ]);
    }

    private function resolverUsuario(): ?string
    {
        $usuarioSessao = session('user');

        if (is_array($usuarioSessao)) {
            $candidato = $usuarioSessao['username'] ?? $usuarioSessao['name'] ?? $usuarioSessao['user'] ?? null;
            if (is_string($candidato) && trim($candidato) !== '') {
                return trim($candidato);
            }
        }

        if (is_object($usuarioSessao)) {
            $candidato = $usuarioSessao->username ?? $usuarioSessao->name ?? $usuarioSessao->user ?? null;
            if (is_string($candidato) && trim($candidato) !== '') {
                return trim($candidato);
            }
        }

        $username = session('username');
        if (is_string($username) && trim($username) !== '') {
            return trim($username);
        }

        $authUserName = auth()->user()->name ?? null;
        if (is_string($authUserName) && trim($authUserName) !== '') {
            return trim($authUserName);
        }

        return null;
    }

    private function resolverRota(?Request $request): ?string
    {
        if (!$request) {
            return null;
        }

        $nome = $request->route()?->getName();
        if (is_string($nome) && trim($nome) !== '') {
            return trim($nome);
        }

        return $request->path();
    }

    private function resolverIp(?Request $request): ?string
    {
        if (!$request) {
            return null;
        }

        $ip = $request->ip();
        return is_string($ip) && trim($ip) !== '' ? trim($ip) : null;
    }

    private function resolverRequestId(?Request $request): ?string
    {
        if (!$request) {
            return null;
        }

        $header = $request->headers->get('X-Request-Id')
            ?? $request->headers->get('X-Correlation-Id');

        if (is_string($header) && trim($header) !== '') {
            return mb_substr(trim($header), 0, 100);
        }

        return null;
    }

    private function toJson(mixed $data): ?string
    {
        if ($data === null) {
            return null;
        }

        if (is_string($data)) {
            return $data;
        }

        if (is_object($data)) {
            $data = (array) $data;
        }

        return json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }

    private function sanitizarDadosSensiveis(string $entidade, mixed $dados): mixed
    {
        if (!str_starts_with($entidade, 'SVI_') || $dados === null) {
            return $dados;
        }

        if (is_object($dados)) {
            $dados = (array) $dados;
        }
        if (!is_array($dados)) {
            return '[REDACTED]';
        }

        $permitidos = [
            'ID', 'SOLICITACAO_ID', 'CONFIGURACAO_ID', 'MACROPROJETO_ID', 'TURNO_ID',
            'NUMERO_TURNO', 'STATUS', 'STATUS_CODIGO', 'STATUS_ANTERIOR', 'STATUS_NOVO',
            'TIPO_EVENTO', 'TIPO', 'CATEGORIA', 'SCAN_STATUS', 'SCANNER', 'MIME',
            'TAMANHO_BYTES', 'SHA256', 'TENTATIVAS', 'ATIVO', 'VERSAO', 'ORDEM',
            'DT_CRIACAO', 'DT_ATUALIZACAO', 'DT_EVENTO', 'DATA_VOTACAO', 'SCANEADO_EM',
            'EXPIRA_EM', 'USADO_EM', 'BLOQUEADO_EM', 'ENVIADO_EM', 'USUARIO',
        ];
        $estruturais = ['DADOS', 'WHERE', 'BINDINGS'];
        $resultado = [];

        foreach ($dados as $chave => $valor) {
            if (is_int($chave)) {
                $resultado[$chave] = $this->sanitizarDadosSensiveis($entidade, $valor);
                continue;
            }

            $campo = strtoupper((string) $chave);
            if (in_array($campo, $estruturais, true)) {
                $resultado[$chave] = $this->sanitizarDadosSensiveis($entidade, $valor);
                continue;
            }
            $resultado[$chave] = in_array($campo, $permitidos, true) ? $valor : '[REDACTED]';
        }

        return $resultado;
    }
}
```
</APP_SERVICES_AUDITORIA_AUDITLOGSERVICE_PHP>

