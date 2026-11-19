# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: Gestão de Riscos Eleitorais

### 1. Visão Geral e Escopo Funcional
**Propósito**: Mapeamento, avaliação e acompanhamento do ciclo de vida de riscos eleitorais (controles internos, planos de tratamento, contingências, monitoramento e comunicações), além do motor de importação automatizada de matrizes corporativas em Excel (Anexo 3683109 / 108 riscos).

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-RIS-001: Matriz de Risco (Probabilidade x Impacto)
- **Escala de Avaliação**: Probabilidade (1 a 5) e Impacto (1 a 5).
- **Risco Inerente**: Risco_Inerente = Probabilidade * Impacto.
  - Faixas: 1-4 (Baixo), 5-9 (Médio), 10-15 (Alto), 16-25 (Extremo).
- **Risco Residual**: Calculado pela média ponderada da eficácia dos controles ativos vinculados. Se houver controle pendente de avaliação, a pontuação residual permanece nula (*indisponível*).

#### RN-RIS-002: Arquivamento e Importação de Planilhas
- Exclusão de risco no sistema opera como **arquivamento reversível** (`status = 'ARQUIVADO'`), preservando o histórico de controles e tratamentos.
- Importação da matriz de riscos em Excel (Anexo 3683109): Valida 108 códigos únicos e grava um lote atômico (`RISCO_IMPORTACAO_LOTE`). Erros estruturais cancelam o lote; divergências pontuais são salvas como pendências editáveis (`RISCO_IMPORTACAO_PENDENCIA`).
- O texto original do responsável importado (`responsavel_original`) é imutável para auditoria e exibido como ajuda até a seleção da unidade oficial.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Risco Eleitoral
CREATE TABLE RISCO (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    PROJETO_ID NUMBER(10) NOT NULL,
    UNIDADE_RESPONSAVEL_ID NUMBER(10),
    CODIGO_RISCO VARCHAR2(20) NOT NULL, -- R01, R02... R108
    TITULO VARCHAR2(300) NOT NULL,
    DESCRICAO VARCHAR2(2000),
    PROBABILIDADE_INERENTE NUMBER(2) NOT NULL,
    IMPACTO_INERENTE NUMBER(2) NOT NULL,
    PONTUACAO_INERENTE NUMBER(5,2) NOT NULL,
    NIVEL_INERENTE VARCHAR2(20) NOT NULL, -- BAIXO, MEDIO, ALTO, EXTREMO
    PONTUACAO_RESIDUAL NUMBER(5,2),
    NIVEL_RESIDUAL VARCHAR2(20),
    STATUS VARCHAR2(20) DEFAULT 'ABERTO' NOT NULL, -- ABERTO, ARQUIVADO, CONCLUIDO
    ORIGEM VARCHAR2(20) DEFAULT 'IMPORTACAO' NOT NULL, -- IMPORTACAO, MANUAL
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Controles de Risco
CREATE TABLE RISCO_CONTROLE (
    ID NUMBER(10) PRIMARY KEY,
    RISCO_ID NUMBER(10) NOT NULL,
    DESCRICAO VARCHAR2(1000) NOT NULL,
    CLASSIFICACAO VARCHAR2(50) NOT NULL, -- PREVENTIVO, DETECTIVO, CORRETIVO
    EFICACIA_PORCENTAGEM NUMBER(5,2),
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT FK_RC_RISCO FOREIGN KEY (RISCO_ID) REFERENCES RISCO(ID) ON DELETE CASCADE
);

-- Lote de Importação de Riscos
CREATE TABLE RISCO_IMPORTACAO_LOTE (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    HASH_ARQUIVO VARCHAR2(64) NOT NULL UNIQUE,
    TOTAL_ITENS NUMBER(5) NOT NULL,
    TOTAL_AVISOS NUMBER(5) DEFAULT 0 NOT NULL,
    USUARIO_CRIACAO VARCHAR2(100) NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
```

---

### 4. Componentes e Código PHP Essencial

#### Motor de Cálculo de Risco (`RiscoCalculoService.php`)
```php
namespace App\Services\Riscos;

class RiscoCalculoService
{
    public function calcularInerente(int $probabilidade, int $impacto): array
    {
        $pontuacao = $probabilidade * $impacto;
        $nivel = $this->classificarNivel($pontuacao);

        return [
            'pontuacao' => $pontuacao,
            'nivel' => $nivel,
            'apetite' => $this->apetitePorNivel($nivel),
        ];
    }

    public function classificarNivel(float $valor): string
    {
        if ($valor <= 4.0) return 'BAIXO';
        if ($valor <= 9.0) return 'MEDIO';
        if ($valor <= 15.0) return 'ALTO';
        return 'EXTREMO';
    }

    public function apetitePorNivel(string $nivel): string
    {
        return match ($nivel) {
            'BAIXO', 'MEDIO' => 'ACEITAR',
            'ALTO' => 'MITIGAR',
            'EXTREMO' => 'EVITAR_OU_TRANSFERIR',
            default => 'ANALISAR',
        };
    }
}
```

---

### 5. Fronteiras de Integração
- **Excel (PhpSpreadsheet)**: Leitura das 12 abas e 108 códigos de risco do modelo corporativo v2.
