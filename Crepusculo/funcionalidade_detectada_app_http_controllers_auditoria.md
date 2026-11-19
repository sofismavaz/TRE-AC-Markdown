# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_http_controllers_auditoria`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 2 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Http/Controllers/Auditoria/AuditLogController.php`
## <APP_HTTP_CONTROLLERS_AUDITORIA_AUDITLOGCONTROLLER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Http/Controllers/Auditoria/AuditLogController.php`
- **Namespace Declaração:** `App\Http\Controllers\Auditoria`
- **Entidade / Classe:** `class AuditLogController extends Controller`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function index(Request $request)
private function normalizarData($valor): ?string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Http\Controllers\Auditoria;

use App\Http\Controllers\Controller;

use App\Repositories\Auditoria\Contracts\AuditLogRepositoryInterface;
use Illuminate\Http\Request;

class AuditLogController extends Controller
{
    public function __construct(
        private readonly AuditLogRepositoryInterface $repository
    ) {
    }

    public function index(Request $request)
    {
        $filtros = [
            'acao' => $request->input('acao'),
            'entidade' => $request->input('entidade'),
            'usuario' => $request->input('usuario'),
            'registro_id' => $request->input('registro_id'),
            'data_de' => $this->normalizarData($request->input('data_de')),
            'data_ate' => $this->normalizarData($request->input('data_ate')),
        ];

        $logs = $this->repository->listarPaginado($filtros, 25);

        return view('planejamento.auditoria.index', [
            'logs' => $logs,
            'filtros' => $filtros,
        ]);
    }

    private function normalizarData($valor): ?string
    {
        if (!is_string($valor)) {
            return null;
        }

        $valor = trim($valor);
        if ($valor === '') {
            return null;
        }

        if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $valor)) {
            return null;
        }

        return $valor;
    }
}
```
</APP_HTTP_CONTROLLERS_AUDITORIA_AUDITLOGCONTROLLER_PHP>

