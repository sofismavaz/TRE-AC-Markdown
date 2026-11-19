# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Diárias e Passagens (Concessão, Prestação e SIAFI)

### 1. Visão Geral e Escopo Funcional
**Propósito**: Gestão completa de concessão de diárias e passagens aéreas/terrestres, alteração e prorrogação de afastamentos, prestação de contas, restituições, ressarcimentos de transporte, cotação e emissão pela SETRAN, conferência financeira SPEF, publicação no DJE e lote de pagamento para exportação SIAFI.

**Status do Sistema**: Desenvolvido e em Produção.
**Norma Regente**: Instrução Normativa TRE-AC nº 65/2021 (e alterações).

---

### 2. Regras de Negócio e Parâmetros

#### RN-DIA-001: Antecedência Mínima e Exceções (Arts. 7–9 IN 65)
- O prazo de antecedência mínima para solicitação é parametrizável em `diarias_parametro.ANTECEDENCIA_MINIMA_DIAS` (padrão 15 dias).
- Solicitações com antecedência menor que o parâmetro exigem justificativa de urgência.
- Passagem aérea de iniciativa do Regional com partida em menos de 10 dias exige motivo operacional em `justificativa_10_dias`.
- Início do afastamento em sexta-feira, sábado, domingo ou feriado exige justificativa explicita de necessidade do serviço no fim de semana (`justificativa_fim_semana_feriado`).

#### RN-DIA-002: Chegada de Voo Noturno (Art. 13 §4 IN 65)
- Quando a chegada do voo aéreo de ida ocorrer em horário noturno (hora < 7h ou ≥ 21h), a chegada deve anteceder a programação oficial do evento (`evento_inicio_em`) em no mínimo **12 horas**.
- O descumprimento é validado na confirmação SETRAN e registrado na auditoria de conformidade COCIN.

#### RN-DIA-003: Uso Compulsorio de Crédito de Passagem (Art. 16 IN 65)
- Ao cotar ou emitir passagem para um eleitor/servidor que possua bilhete aéreo não utilizado (crédito aberto em `diarias_credito_passagem` pelo mesmo CPF e companhia), o sistema exige a vinculação compulsória e abatimento do saldo de crédito antes do empenho de novos recursos.

#### RN-DIA-004: Confirmações Paralelas de Unidades Confirmadoras
- A aprovação inicial na etapa `UNIDADE` exige a confirmação paralela de todas as unidades confirmadoras dos beneficiários envolvidos no pedido (mapeadas em `diarias_confirmadora_mapeamento`: COAUDI, COGEP, DG, PRESI, SAOF, SEJUD, STI, VICE-CRE).
- A concessão cabe à Presidência (`PRESI`) quando qualquer beneficiario for magistrado, membro da Corte ou exercer a Diretoria-Geral (CJ-4).

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Solicitação Principal
CREATE TABLE DIARIAS_SOLICITACAO (
    ID NUMBER(10) PRIMARY KEY,
    TIPO_ID NUMBER(10) DEFAULT 1 NOT NULL, -- NORMAL, PRORROGACAO
    REQUERENTE_USERNAME VARCHAR2(100) NOT NULL,
    STATUS VARCHAR2(30) DEFAULT 'RASCUNHO' NOT NULL, -- RASCUNHO, SOLICITADA, VALIDADA, COTADA, AUTORIZADA, CONFIRMADA, LANCADA, PAGA_PARCIAL, PAGA, FINALIZADA, REJEITADA, CANCELADA, EM_ALTERACAO
    PROCESSO_SEI VARCHAR2(50),
    JUSTIFICATIVA_FIM_SEMANA VARCHAR2(1000),
    JUSTIFICATIVA_10_DIAS VARCHAR2(1000),
    JUSTIFICATIVA_PERNOITE VARCHAR2(4000),
    VALOR_TOTAL NUMBER(12,2) DEFAULT 0 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Beneficiários
CREATE TABLE DIARIAS_SOLICITACAO_BENEFICIARIO (
    ID NUMBER(10) PRIMARY KEY,
    SOLICITACAO_ID NUMBER(10) NOT NULL,
    CPF VARCHAR2(11) NOT NULL,
    NOME VARCHAR2(150) NOT NULL,
    VINCULO VARCHAR2(50) NOT NULL, -- EFETIVO, CEDIDO, REQUISITADO, COLABORADOR_EVENTUAL
    RECEBE_AUXILIO_ALIMENTACAO_TRE VARCHAR2(3) DEFAULT 'NAO' NOT NULL, -- SIM, NAO
    RECEBE_AUXILIO_ALIMENTACAO_ORIGEM VARCHAR2(3) DEFAULT 'NAO' NOT NULL,
    VALOR_AUXILIO_ALIMENTACAO_ORIGEM NUMBER(10,2) DEFAULT 0 NOT NULL,
    CONSTRAINT FK_DSB_SOLICITACAO FOREIGN KEY (SOLICITACAO_ID) REFERENCES DIARIAS_SOLICITACAO(ID) ON DELETE CASCADE
);

-- Trechos do Roteiro
CREATE TABLE DIARIAS_SOLICITACAO_TRECHO (
    ID NUMBER(10) PRIMARY KEY,
    SOLICITACAO_ID NUMBER(10) NOT NULL,
    ORIGEM_CIDADE_ID NUMBER(10) NOT NULL,
    DESTINO_CIDADE_ID NUMBER(10) NOT NULL,
    DATA_HORA_SAIDA TIMESTAMP NOT NULL,
    DATA_HORA_CHEGADA TIMESTAMP NOT NULL,
    MODAL_TRANSPORTE_CODIGO VARCHAR2(20) NOT NULL, -- AEREO, TERRESTRE_OFICIAL, TERRESTRE_PROPRIO
    PERNOITE VARCHAR2(3) DEFAULT 'NAO' NOT NULL,
    EVENTO_INICIO_EM TIMESTAMP,
    EVENTO_FIM_EM TIMESTAMP,
    CONSTRAINT FK_DST_SOLICITACAO FOREIGN KEY (SOLICITACAO_ID) REFERENCES DIARIAS_SOLICITACAO(ID) ON DELETE CASCADE
);

-- Diárias Individuais Calculadas
CREATE TABLE DIARIAS_DIARIA (
    ID NUMBER(10) PRIMARY KEY,
    SOLICITACAO_ID NUMBER(10) NOT NULL,
    BENEFICIARIO_ID NUMBER(10) NOT NULL,
    QTDE_DIARIAS NUMBER(5,1) NOT NULL,
    VALOR_DIARIA NUMBER(10,2) NOT NULL,
    VALOR_ADICIONAL_DESLOCAMENTO NUMBER(10,2) DEFAULT 0 NOT NULL,
    VALOR_TOTAL NUMBER(10,2) NOT NULL,
    STATUS VARCHAR2(30) DEFAULT 'CALCULADA' NOT NULL,
    CONSTRAINT FK_DD_SOLICITACAO FOREIGN KEY (SOLICITACAO_ID) REFERENCES DIARIAS_SOLICITACAO(ID)
);

-- Lote SIAFI para Pagamento
CREATE TABLE DIARIAS_LOTE_SIAFI (
    ID NUMBER(10) PRIMARY KEY,
    LOTE_UUID VARCHAR2(36) NOT NULL UNIQUE,
    UG_PAGADORA VARCHAR2(10) NOT NULL,
    GESTAO VARCHAR2(10) NOT NULL,
    VALOR_TOTAL NUMBER(12,2) NOT NULL,
    STATUS VARCHAR2(20) DEFAULT 'GERADO' NOT NULL,
    DT_GERACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Engine de Cálculo de Diárias e Adicionais (`DiariasCalculoService.php`)
```php
namespace App\Services\Diarias;

use App\Repositories\Diarias\Contracts\DiariasParametroRepositoryInterface;
use App\Support\Diarias\DiariasDeslocamentoCurto;

class DiariasCalculoService
{
    public function __construct(private readonly DiariasParametroRepositoryInterface $parametroRepository) {}

    public function calcularDiariasEBeneficios(array $solicitacao, array $beneficiario, array $trechos): array
    {
        $distanciaMinimaKm = $this->parametroRepository->distanciaMinimaKm();
        $valorBase = $this->parametroRepository->buscarValorDiariaAtivo($beneficiario['vinculo']);
        
        $diasInteiros = 0;
        $meiasDiarias = 0;
        $adicionalDeslocamento = 0.0;

        foreach ($trechos as $trecho) {
            $eCurto = DiariasDeslocamentoCurto::trecho($trecho['distancia_km'], $trecho['limitrofe'], $distanciaMinimaKm);
            
            if ($eCurto && $trecho['pernoite'] === 'NAO') {
                $meiasDiarias += 0.5;
            } else {
                $diasInteiros += 1.0;
            }

            if ($trecho['modal_transporte_codigo'] === 'AEREO' || $trecho['modal_transporte_codigo'] === 'TERRESTRE_PROPRIO') {
                $adicionalDeslocamento += $this->parametroRepository->valorAdicionalDeslocamento();
            }
        }

        $subtotal = ($diasInteiros + $meiasDiarias) * $valorBase;
        
        // Aplica desconto de Auxílio-Alimentação se aplicável
        if ($beneficiario['recebe_auxilio_alimentacao_tre'] === 'SIM') {
            $descontoAlimentacao = ($diasInteiros + $meiasDiarias) * $this->parametroRepository->valorDescontoAlimentacaoDiario();
            $subtotal = max(0, $subtotal - $descontoAlimentacao);
        }

        return [
            'qtde_diarias' => $diasInteiros + $meiasDiarias,
            'valor_diaria' => $valorBase,
            'valor_adicional_deslocamento' => $adicionalDeslocamento,
            'valor_total' => $subtotal + $adicionalDeslocamento,
        ];
    }
}
```

---

### 5. Fronteiras de Integração
- **SEI (Sistema Eletrônico de Informações)**: Automação via SOAP/Web Services para criação e juntada idempotente de processos administrativos de concessão e comprovação.
- **SIAFI**: Geração e exportação XML/TXT do Documento Habil (DH) para liquidação financeira e ordem bancária.
- **DJE**: Publicação automática dos atos de concessão.
- **API Pessoa**: Reidratação autoritativa de vínculos funcionais de servidores, cedidos e requisitados por CPF.
