# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Convocação por SMS e Mensageria

### 1. Visão Geral e Escopo Funcional
**Propósito**: Comunicação massiva para convocação de mesários, colaboradores e voluntários via SMS (integrado às gateways TextBee e Zenvia), controle de modelos parametrizáveis de mensagens, filas de envio escalonadas por chip/SIM, controle de recebimento/leitura e webhooks de status.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-SMS-001: Cadência e Escalonamento de Envio por SIM
- Para evitar bloqueios pelas operadoras, os envios via Android/TextBee utilizam controle de cadência (`TextBeeSmsCadencia`).
- A cadência respeita a quantidade de segmentos GSM-7/UCS-2 por mensagem e insere pausa entre envios sucessivos por dispositivo (`deviceId`) e subscrição de chip (`simSubscriptionId`).
- Em caso de falha de limite (código Android 5), o sistema abre pausa automática para o aparelho/SIM sem truncar nem perder a mensagem enfileirada.

#### RN-SMS-002: Janela de Envio e Revalidação com o ELO/TSE
- As convocações são restritas à janela de horário permitida.
- Antes do disparo do lote, o sistema revalida o status da convocação no snapshot do ELO (`CAD_CONVOCACAO_MESARIO_TSE`).
- Se a convocação do eleitor já estiver confirmada no ELO (`DES_IND_CONFIRMOU_PRESENCA = 'SIM'`), o envio para o mesmo modelo de convocação é evitado, prevenindo cobranças ou mensagens redundantes.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Lotes de Convocação por SMS
CREATE TABLE CE_SMS_LOTE (
    ID NUMBER(10) PRIMARY KEY,
    LOTE_UUID VARCHAR2(36) NOT NULL UNIQUE,
    MACROPROJETO_TURNO_ID NUMBER(10) NOT NULL,
    MODELO_ID NUMBER(10) NOT NULL,
    SENDER_IDENTIFICADOR VARCHAR2(50) DEFAULT '29175' NOT NULL,
    TOTAL_SELECIONADOS NUMBER(8) DEFAULT 0 NOT NULL,
    TOTAL_ENFILEIRADOS NUMBER(8) DEFAULT 0 NOT NULL,
    TOTAL_IGNORADOS NUMBER(8) DEFAULT 0 NOT NULL,
    USUARIO_CRIACAO VARCHAR2(100) NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Modelos de Mensagens Configuráveis
CREATE TABLE CE_SMS_MODELO (
    ID NUMBER(10) PRIMARY KEY,
    TITULO VARCHAR2(100) NOT NULL,
    TEXTO_TEMPLATE VARCHAR2(1000) NOT NULL,
    ZONA_NUM NUMBER(5),
    TIPO_FUNCAO VARCHAR2(50),
    EXIGE_RESPOSTA NUMBER(1) DEFAULT 1 NOT NULL,
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Mensagens Individuais Enfileiradas
CREATE TABLE CE_SMS_MENSAGEM (
    ID NUMBER(10) PRIMARY KEY,
    LOTE_ID NUMBER(10) NOT NULL,
    NUM_INSCRICAO VARCHAR2(12) NOT NULL, -- Título do Eleitor
    TELEFONE_E164 VARCHAR2(20) NOT NULL,
    TEXTO_FINAL VARCHAR2(1000) NOT NULL,
    PROVEDOR VARCHAR2(20) DEFAULT 'TEXTBEE' NOT NULL, -- TEXTBEE, ZENVIA
    PROVIDER_BATCH_ID VARCHAR2(100),
    DEVICE_ID VARCHAR2(100),
    SIM_SUBSCRIPTION_ID NUMBER(5),
    STATUS VARCHAR2(30) DEFAULT 'PENDENTE' NOT NULL, -- PENDENTE, PROCESSANDO, ENVIADO, ENTREGUE, NAO_ENTREGUE, REJEITADO, CANCELADO
    DT_ENVIO TIMESTAMP,
    DT_ENTREGA TIMESTAMP,
    CONSTRAINT FK_CSM_LOTE FOREIGN KEY (LOTE_ID) REFERENCES CE_SMS_LOTE(ID) ON DELETE CASCADE
);

-- Respostas Recebidas via Webhook
CREATE TABLE CE_SMS_RESPOSTA (
    ID NUMBER(10) PRIMARY KEY,
    MENSAGEM_ID NUMBER(10),
    TELEFONE_E164 VARCHAR2(20) NOT NULL,
    TEXTO_RESPOSTA VARCHAR2(1000) NOT NULL,
    PROVEDOR VARCHAR2(20) NOT NULL,
    DT_RECEBIMENTO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_CSR_MENSAGEM FOREIGN KEY (MENSAGEM_ID) REFERENCES CE_SMS_MENSAGEM(ID) ON DELETE SET NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Worker e Controle de Cadência (`TextBeeSmsWorkerService.php`)
```php
namespace App\Services\ConvocacaoSms;

use App\Repositories\ConvocacaoSms\Contracts\ConvocacaoSmsEnvioRepositoryInterface;
use Exception;

class TextBeeSmsWorkerService
{
    public function __construct(
        private readonly ConvocacaoSmsEnvioRepositoryInterface $repository,
        private readonly TextBeeSmsCadencia $cadencia
    ) {}

    public function processarEnvio(int $mensagemId): void
    {
        $mensagem = $this->repository->buscarEnvio($mensagemId);
        
        if (!$mensagem || $mensagem['status'] !== 'PENDENTE') {
            return;
        }

        $deviceId = $mensagem['device_id'] ?? config('services.textbee.default_device_id');
        $simId = $mensagem['sim_subscription_id'] ?? null;

        // Executa sob janela de cadência do chip
        $enviado = $this->cadencia->executar($deviceId, $simId, $mensagem['segmentos'], function () use ($mensagem) {
            return $this->repository->reivindicarEDisparar($mensagem['id']);
        });

        if (!$enviado) {
            // Reagenda para o próximo ciclo de janela disponível
            $this->repository->restaurarPendenteForaJanela($mensagemId);
        }
    }
}
```

---

### 5. Fronteiras de Integração
- **TextBee (Android Gateway)**: Envio via aparelhos móveis dedicados.
- **Zenvia**: Gateway corporativa fallback para envio direto via Shortcode (29175).
