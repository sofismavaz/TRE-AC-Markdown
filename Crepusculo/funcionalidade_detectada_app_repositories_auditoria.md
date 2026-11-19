# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_repositories_auditoria`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 4 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Auditoria/AuditLogRepository.php`
## <APP_REPOSITORIES_AUDITORIA_AUDITLOGREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Auditoria/AuditLogRepository.php`
- **Namespace Declaração:** `App\Repositories\Auditoria`
- **Entidade / Classe:** `class AuditLogRepository implements AuditLogRepositoryInterface`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table('AUDITORIA_ACAO as A')
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function inserir(array $payload): void
public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Auditoria;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class AuditLogRepository implements AuditLogRepositoryInterface
{
    public function inserir(array $payload): void
    {
        DB::insert("
            INSERT INTO AUDITORIA_ACAO (
                USUARIO,
                ROTA,
                IP,
                REQUEST_ID,
                ENTIDADE,
                REGISTRO_ID,
                ACAO,
                COMANDO_SQL,
                BINDINGS_JSON,
                DADOS_ANTES_JSON,
                DADOS_DEPOIS_JSON,
                SUCESSO,
                ERRO_MSG,
                DATA_EVENTO
            ) VALUES (
                :usuario,
                :rota,
                :ip,
                :request_id,
                :entidade,
                :registro_id,
                :acao,
                :comando_sql,
                :bindings_json,
                :dados_antes_json,
                :dados_depois_json,
                :sucesso,
                :erro_msg,
                SYSDATE
            )
        ", [
            'usuario' => $payload['usuario'] ?? null,
            'rota' => $payload['rota'] ?? null,
            'ip' => $payload['ip'] ?? null,
            'request_id' => $payload['request_id'] ?? null,
            'entidade' => $payload['entidade'] ?? '',
            'registro_id' => $payload['registro_id'] ?? null,
            'acao' => $payload['acao'] ?? '',
            'comando_sql' => $payload['comando_sql'] ?? '',
            'bindings_json' => $payload['bindings_json'] ?? null,
            'dados_antes_json' => $payload['dados_antes_json'] ?? null,
            'dados_depois_json' => $payload['dados_depois_json'] ?? null,
            'sucesso' => $payload['sucesso'] ?? 'S',
            'erro_msg' => $payload['erro_msg'] ?? null,
        ]);
    }

    public function listarPaginado(array $filtros, int $perPage = 20): LengthAwarePaginator
    {
        $query = DB::table('AUDITORIA_ACAO as A')
            ->selectRaw("
                A.ID,
                TO_CHAR(A.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS') AS DATA_EVENTO,
                A.USUARIO,
                A.ROTA,
                A.IP,
                A.REQUEST_ID,
                A.ENTIDADE,
                A.REGISTRO_ID,
                A.ACAO,
                A.COMANDO_SQL,
                A.BINDINGS_JSON,
                A.DADOS_ANTES_JSON,
                A.DADOS_DEPOIS_JSON,
                A.SUCESSO,
                A.ERRO_MSG
            ")
            ->orderByDesc('A.DATA_EVENTO')
            ->orderByDesc('A.ID');

        $acao = strtoupper(trim((string) ($filtros['acao'] ?? '')));
        if (in_array($acao, ['INSERT', 'UPDATE', 'DELETE'], true)) {
            $query->where('A.ACAO', $acao);
        }

        $entidade = strtoupper(trim((string) ($filtros['entidade'] ?? '')));
        if ($entidade !== '') {
            $query->whereRaw('UPPER(A.ENTIDADE) LIKE ?', ['%' . $entidade . '%']);
        }

        $usuario = trim((string) ($filtros['usuario'] ?? ''));
        if ($usuario !== '') {
            $query->whereRaw('UPPER(A.USUARIO) LIKE ?', ['%' . mb_strtoupper($usuario, 'UTF-8') . '%']);
        }

        $registroId = trim((string) ($filtros['registro_id'] ?? ''));
        if ($registroId !== '') {
            $query->where('A.REGISTRO_ID', $registroId);
        }

        $dataDe = trim((string) ($filtros['data_de'] ?? ''));
        if ($dataDe !== '') {
            $query->whereRaw("TRUNC(A.DATA_EVENTO) >= TO_DATE(?, 'YYYY-MM-DD')", [$dataDe]);
        }

        $dataAte = trim((string) ($filtros['data_ate'] ?? ''));
        if ($dataAte !== '') {
            $query->whereRaw("TRUNC(A.DATA_EVENTO) <= TO_DATE(?, 'YYYY-MM-DD')", [$dataAte]);
        }

        return $query->paginate($perPage)->withQueryString();
    }
}
```
</APP_REPOSITORIES_AUDITORIA_AUDITLOGREPOSITORY_PHP>

