# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Cadastro Eleitoral, Agendamento e Filas de Atendimento

### 1. Visão Geral e Escopo Funcional
**Propósito**: Gestão integral do atendimento presencial ao eleitor nos Cartórios e Central de Atendimento, englobando agendamento de horários web, emissão e chamada de senhas presenciais (Filas), gestão de guichês, painel de chamadas em tempo real e formulários de avaliação de pesquisa de satisfação.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-CAD-001: Capacidade por Unidade em `CAD_UNIDADE`
- A tabela `CAD_UNIDADE` é a **fonte única da verdade** para indicar quais submódulos do Cadastro Eleitoral estão habilitados em cada unidade:
  - `usa_agendamentos`: Quando 'S', habilita a exibição da unidade no portal público de agendamento, geração de slots e reservas.
  - `usa_filas`: Quando 'S', permite que a unidade emita e chame senhas na triagem e guichês.
  - `usa_pesquisa_satisfacao`: Quando 'S', habilita o formulário de pesquisa de satisfação pós-atendimento.
- Validações de backend devem rejeitar requisições diretas para unidades desabilitadas (`usa_agendamentos = 'N'` ou `usa_filas = 'N'`), retornando erro HTTP 422.

#### RN-CAD-002: Ciclos e Sequencial de Senhas Presenciais
- A emissão de senhas organiza-se em blocos de **001 a 999** por unidade e serviço.
- **Emissão Automática**: Ao atingir a senha 999, o sistema reinicia automaticamente o contador para 001, incrementando o `ciclo_atendimento`.
- **Emissão Manual**: Se o operador informar manualmente um número menor que a última senha emitida no mesmo dia, o sistema inicia um novo ciclo sem colisão de chave primária.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Unidades do Cadastro e Flags de Capacidade
CREATE TABLE CAD_UNIDADE (
    ID_UNIDADE NUMBER(10) PRIMARY KEY,
    COD_OBJETO_LOCALIDADE VARCHAR2(20) NOT NULL,
    NOME VARCHAR2(150) NOT NULL,
    SIGLA VARCHAR2(20),
    USA_AGENDAMENTOS VARCHAR2(1) DEFAULT 'S' NOT NULL,
    USA_FILAS VARCHAR2(1) DEFAULT 'S' NOT NULL,
    USA_PESQUISA_SATISFACAO VARCHAR2(1) DEFAULT 'S' NOT NULL,
    ATIVO VARCHAR2(1) DEFAULT 'S' NOT NULL
);

-- Guichês de Atendimento
CREATE TABLE CAD_GUICHE (
    ID_GUICHE NUMBER(10) PRIMARY KEY,
    ID_UNIDADE NUMBER(10) NOT NULL,
    NUMERO_GUICHE NUMBER(5) NOT NULL,
    DESCRICAO VARCHAR2(100),
    ATIVO VARCHAR2(1) DEFAULT 'S' NOT NULL,
    CONSTRAINT FK_CG_UNIDADE FOREIGN KEY (ID_UNIDADE) REFERENCES CAD_UNIDADE(ID_UNIDADE)
);

-- Senhas de Filas Operacionais
CREATE TABLE CAD_FILA_SENHA (
    ID_SENHA NUMBER(10) PRIMARY KEY,
    ID_UNIDADE NUMBER(10) NOT NULL,
    ID_SERVICO NUMBER(10) NOT NULL,
    ID_PRIORIDADE NUMBER(10) NOT NULL,
    NUMERO_SENHA NUMBER(5) NOT NULL,
    CICLO NUMBER(5) DEFAULT 1 NOT NULL,
    SIGLA VARCHAR2(5) NOT NULL,
    STATUS VARCHAR2(20) DEFAULT 'EMITIDA' NOT NULL, -- EMITIDA, CHAMADA, EM_ATENDIMENTO, FINALIZADA, CANCELADA, NAO_COMPARECEU
    NOME_CLIENTE VARCHAR2(150),
    CPF_CLIENTE VARCHAR2(11),
    MODO_EMISSAO VARCHAR2(20) DEFAULT 'AUTOMATICA' NOT NULL, -- AUTOMATICA, MANUAL
    ID_USUARIO_ATENDIMENTO VARCHAR2(100),
    ID_GUICHE NUMBER(10),
    DT_EMISSAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DT_CHAMADA TIMESTAMP,
    DT_INICIO TIMESTAMP,
    DT_FIM TIMESTAMP
);

-- Formulário de Pesquisa de Satisfação
CREATE TABLE CAD_PESQUISA_SATISFACAO (
    ID NUMBER(10) PRIMARY KEY,
    ID_UNIDADE NUMBER(10) NOT NULL,
    AVALIACAO_ATENDIMENTO NUMBER(2) NOT NULL,
    AVALIACAO_TEMPO_ESPERA NUMBER(2) NOT NULL,
    AVALIACAO_INSTALACOES NUMBER(2) NOT NULL,
    COMENTARIOS VARCHAR2(1000),
    DT_SUBMISSAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Serviço de Escopo e Capacidades (`CadastroEleitoralAgendamentoEscopoService.php`)
```php
namespace App\Services\CadastroEleitoral;

use App\Repositories\CadastroEleitoral\Contracts\CadastroEleitoralUnidadeRepositoryInterface;
use App\Support\Access\EscopoZonal;
use DomainException;

class CadastroEleitoralAgendamentoEscopoService
{
    public function __construct(private readonly CadastroEleitoralUnidadeRepositoryInterface $unidadeRepository) {}

    public function validarUnidadeParaAgendamento(int $idUnidade, EscopoZonal $escopo): void
    {
        $unidade = $this->unidadeRepository->buscarUnidade($idUnidade);
        
        if (!$unidade || $unidade->ativo !== 'S') {
            throw new DomainException('Unidade inativa ou não encontrada.');
        }

        if ($unidade->usa_agendamentos !== 'S') {
            throw new DomainException('Esta unidade não possui o serviço de agendamentos habilitado.');
        }

        if (!$escopo->isIrrestrito() && !in_array($idUnidade, $escopo->unidadesPermitidas())) {
            throw new DomainException('Acesso não autorizado para a unidade informada.');
        }
    }
}
```

---

### 5. Fronteiras de Integração
- **ELO / TSE**: Consulta remota de eleitores cadastrados para validação automática de dados antes da confirmação da reserva.
- **Painel de Chamadas Web**: Comunicação em tempo real por polling assíncrono para os monitores da recepção.
