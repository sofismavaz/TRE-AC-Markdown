# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Forças de Segurança Públicas

### 1. Visão Geral e Escopo Funcional
**Propósito**: Credenciamento, solicitação de acesso e controle de presença de representantes de órgãos de segurança pública (Polícia Militar, Polícia Civil, Polícia Federal, Polícia Rodoviária Federal, Forças Armadas) nos locais de votação e pontos de transmissão.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-SEG-001: Autenticação de Representantes
- A solicitação de acesso pelo representante público é autenticada via envio de código temporário de verificação por e-mail/SMS.
- O cadastro do representante passa por triagem administrativa: status `PENDENTE`, `ATIVO`, `BLOQUEADO`, `REJEITADO`.

#### RN-SEG-002: Anonimização de Dados em Visões Públicas
- Visões externas e relatórios consultivos fornecidos às Forças de Segurança aplicam anonimização de dados pessoais sensíveis (Máscara de Título, CPF e Telefone em HTML e PDF).

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Representantes Credenciados
CREATE TABLE FORCAS_SEGURANCA_REPRESENTANTE (
    ID NUMBER(10) PRIMARY KEY,
    NOME VARCHAR2(150) NOT NULL,
    CPF VARCHAR2(11) NOT NULL UNIQUE,
    EMAIL VARCHAR2(150) NOT NULL,
    TELEFONE VARCHAR2(20) NOT NULL,
    ORGAO_SEGURANCA VARCHAR2(50) NOT NULL, -- PM, PC, PF, PRF, EXERCITO, OUTRO
    CARGO_PATENTE VARCHAR2(100),
    STATUS VARCHAR2(20) DEFAULT 'PENDENTE' NOT NULL, -- PENDENTE, ATIVO, BLOQUEADO, REJEITADO
    MOTIVO_STATUS VARCHAR2(500),
    USUARIO_APROVADOR VARCHAR2(100),
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Códigos Temporários de Acesso
CREATE TABLE FORCAS_SEGURANCA_ACESSO_CODIGO (
    ID NUMBER(10) PRIMARY KEY,
    EMAIL VARCHAR2(150) NOT NULL,
    CODIGO VARCHAR2(6) NOT NULL,
    USADO NUMBER(1) DEFAULT 0 NOT NULL,
    DT_EXPIRACAO TIMESTAMP NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Controller de Autenticação Externa (`ForcasSegurancaAuthController.php`)
```php
namespace App\Http\Controllers\ForcasSeguranca;

use App\Http\Controllers\Controller;
use App\Services\ForcasSeguranca\ForcasSegurancaAuthService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;

class ForcasSegurancaAuthController extends Controller
{
    public function __construct(private readonly ForcasSegurancaAuthService $authService) {}

    public function enviarCodigo(Request $request): RedirectResponse
    {
        $request->validate(['email' => 'required|email']);
        $this->authService->gerarEEnviarCodigo($request->input('email'));

        return redirect()->route('forcas-seguranca.validar-form')
            ->with('sucesso', 'Código de verificação enviado para o e-mail informado.');
    }
}
```

---

### 5. Fronteiras de Integração
- **Notificação e Mensageria**: Disparo de e-mails com códigos temporários de acesso e avisos de liberação de credenciamento.
