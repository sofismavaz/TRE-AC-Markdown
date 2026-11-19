<style>
body {
font-family: Arial, sans-serif;
font-size: 12pt;
line-height: 1.5;
}

p {
text-align: justify;
text-indent: 1.25cm;
margin-top: 0;
margin-bottom: 0;
}

h1 {
font-size: 14pt;
font-weight: bold;
text-align: center;
}

h2 {
font-size: 12pt;
font-weight: bold;
margin-top: 18pt;
margin-bottom: 6pt;
}

h3 {
font-size: 12pt;
font-weight: bold;
margin-top: 12pt;
margin-bottom: 6pt;
}

table {
width: 100%;
border-collapse: collapse;
font-size: 8pt;
}

th, td {
border: 1px solid #000;
padding: 5px;
vertical-align: top;
}

li {
text-align: justify;
line-height: 1.5;
}
</style>

```
# PLANO DE GESTÃO DE RISCOS - MAPA DE RISCOS
```

\
**Processo SEI nº:** 0002395-77.2026.6.01.8000  
**Órgão:** Tribunal Regional Eleitoral do Acre (TRE-AC)  
**Unidade Demandante:** Secretaria de Tecnologia da Informação (STI/TRE-AC)  
**Objeto:** Aquisição de 170 (cento e setenta) Notebooks Corporativos de Alto Desempenho (Tipo I), mediante adesão à Ata de Registro de Preços nº 26/2026 da Universidade Federal do Acre (UFAC) — Pregão Eletrônico nº 90068/2025, fornecedor Plugnet Comércio e Representações Ltda. (Modelo HP EliteBook 6G1i 14 com garantia *on-site* de 60 meses).  
**Valor Global Estimado:** R$ 1.880.200,00 (um milhão, oitocentos e oitenta mil e duzentos reais)  
**Fonte de Custeio:** Ação 21EE – Gestão da Política de Segurança da Informação e Cibernética (Processo SEI nº 0002313-46.2026.6.01.8000).  
**Amparo Normativo:** Instrução Normativa TRE-AC nº 72/2024 (Anexo IV), Resolução CNJ nº 468/2022 (art. 10), Resolução TRE-AC nº 1.722/2017 e Resolução TRE-AC nº 1.727/2018.

---

### 1. FASE DE PLANEJAMENTO DA CONTRATAÇÃO

#### 1.1. Modelo MGR-02.01: Classificação e Avaliação de Riscos (Planejamento)

**Objetivo da Contratação:** Prover e padronizar a solução de computação móvel corporativa com requisitos de segurança de *endpoints* para 100% da força de trabalho ativa e magistrados do TRE-AC, assegurando a continuidade dos serviços, a proteção de dados eleitorais e a execução orçamentária no exercício de 2026.

| Evento de Risco / Ameaça | Probabilidade (A) | Impacto (B) | Nível de Risco (A x B) | Controle Existente | Eficácia do Controle | Risco Residual | Classificação do Risco | Apetite ao Risco |
| :--- | :---: | :---: | :---: | :--- | :--- | :---: | :---: | :---: |
| **R01. Descontinuidade do Modelo Registrado em Ata pelo Fabricante:** O fabricante (HP) descontinuar o modelo originalmente licitado (EliteBook 645 G11), inviabilizando a adesão inicial. | Média (2) | Alto (4) | **Elevado (8)** | Análise de equivalência e exigência de produto substituto de linha superior sem acréscimo de custos. | Eficaz | Baixo | Mitigar | Reduzido |
| **R02. Incompatibilidade da Fonte Orçamentária com as Normas Fiscais:** Risco de questionamento sobre o remanejamento orçamentário entre ações genéricas de custeio e investimento. | Média (2) | Alto (4) | **Elevado (8)** | Alocação direta na Ação 21EE (Cibersegurança), vinculada ao Processo SEI nº 0002313-46.2026.6.01.8000 e ao Ofício-Circular TSE nº 236/2026. | Muito Eficaz | Muito Baixo | Mitigar | Nulo |
| **R03. Inadequação das Especificações aos Requisitos de Cibersegurança:** Risco de aquisição de equipamentos sem módulos físicos de proteção, mantendo vulnerabilidades no trabalho remoto. | Baixa (1) | Muito Alto (5) | **Médio (5)** | Especificação rigorosa de hardware corporativo com TPM 2.0, biometria IR 5MP, obturador de privacidade e conformidade com a Resolução CNJ nº 396/2021. | Muito Eficaz | Muito Baixo | Evitar | Nulo |
| **R04. Divergência de Quantitativos e Parâmetros nos Artefatos:** Inconsistência de valores ou quantitativos entre DFD, ETP e Informação Orçamentária, gerando atraso na instrução. | Baixa (1) | Médio (3) | **Baixo (3)** | Compatibilização e revisão prévia pela Equipe de Planejamento da Contratação (EPC) e checklist anti-retrabalho. | Eficaz | Muito Baixo | Prevenir | Nulo |

*Escala de Avaliação: Probabilidade (1-Rara, 2-Média, 3-Alta) | Impacto (1-Insignificante, 2-Baixo, 3-Médio, 4-Alto, 5-Muito Alto) | Nível (Matriz AxB).*

---

#### 1.2. Modelo MGR-03.01: Plano de Resposta, Monitoramento e Controle (Planejamento)

| Ameaça / Evento de Risco | Resposta ao Risco | O que fazer? (Ação Preventiva / Mitigadora) | Área Impactada | Responsável | Data Inicial | Data Final | Andamento da Ação |
| :--- | :--- | :--- | :--- | :--- | :---: | :---: | :---: |
| **R01. Descontinuidade do Modelo** | Mitigar / Aceitar Substituto | Solicitar manifestação formal da fabricante (HP) e da fornecedora (Plugnet), exigindo o fornecimento do modelo substituto HP EliteBook 6G1i 14 com processador Intel Core Ultra 5 225U (NPU dedicada de IA) mantendo o preço registrado de R$ 11.060,00 e garantia de 60 meses. | STI / SDBD | Lucir Rocio Vaz (Técnico) | 23/09/2026 | 05/10/2026 | **Concluído** (Aceite confirmado no evento SEI 0919102) |
| **R02. Fonte Orçamentária** | Mitigar / Alocar na Ação 21EE | Vincular a contratação ao saldo disponível da Ação 21EE (R$ 2.553.656,00) tratada no Processo SEI nº 0002313-46.2026.6.01.8000, atendendo ao princípio da especialidade e à ENSEC-PJ (Res. CNJ 396/2021). | STI / SAOF / SPEO | Cleilton Nazaré Costa (Secretário da STI) | 25/09/2026 | 08/10/2026 | **Em Andamento** (Informação nº 0918910/2026 emitida) |
| **R03. Requisitos de Cibersegurança** | Evitar | Validar no ETP o enquadramento do hardware nas exigências de blindagem de *endpoints* da Portaria CRE nº 2/2026 e LGPD, erradicando a prática de BYOD. | STI / SCSEG | Ilis Sandro Ambrosio (Técnico) | 25/09/2026 | 07/10/2026 | **Concluído** (ETP consolidado) |
| **R04. Divergência nos Artefatos** | Prevenir | Alinhar rigorosamente todos os documentos ao censo de 170 usuários ativos, fixando o valor global exato de R$ 1.880.200,00 em todas as peças processuais. | EPC | Altamiro Lima da Silva (Administrativo) | 25/09/2026 | 07/10/2026 | **Concluído** (Artefatos sincronizados) |

---

### 2. FASE DE SELEÇÃO DO FORNECEDOR (INSTRUÇÃO DA ADESÃO À ARP)

#### 2.1. Modelo MGR-02.01: Classificação e Avaliação de Riscos (Seleção do Fornecedor)

**Objetivo da Fase:** Garantir a instrução célere e juridicamente hígida do procedimento de adesão por carona à ARP nº 26/2026 da UFAC, com integral atendimento aos requisitos do art. 86 da Lei nº 14.133/2021, Resolução CNJ nº 468/2022 e IN TRE-AC nº 72/2024.

| Evento de Risco / Ameaça | Probabilidade (A) | Impacto (B) | Nível de Risco (A x B) | Controle Existente | Eficácia do Controle | Risco Residual | Classificação do Risco | Apetite ao Risco |
| :--- | :---: | :---: | :---: | :--- | :--- | :---: | :---: | :---: |
| **R05. Recusa ou Demora na Anuência pelo Órgão Gerenciador (UFAC) ou Fornecedor:** O órgão gerenciador indeferir o pedido de adesão ou a empresa demorar a responder formalmente. | Média (2) | Alto (4) | **Elevado (8)** | Consulta prévia por e-mail/ofício e obtenção de confirmação de interesse de fornecimento e saldo de ata. | Eficaz | Baixo | Mitigar | Reduzido |
| **R06. Ultrapassagem dos Limites Legais de Adesão (50% da Ata):** O quantitativo pretendido exceder o limite individual de 50% dos itens registrados na ARP gerenciada. | Baixa (1) | Muito Alto (5) | **Médio (5)** | Verificação no edital e ata da UFAC: o Item 2 possui 875 unidades registradas; a pretensão de 170 unidades representa 19,4%, perfeitamente dentro do limite de 437 unidades (50%). | Muito Eficaz | Muito Baixo | Prevenir | Nulo |
| **R07. Questionamento sobre a Vantajosidade Econômica da Adesão:** Dúvidas jurídicas ou técnicas quanto à compatibilidade do preço registrado (R$ 11.060,00) com os valores de mercado. | Baixa (1) | Alto (4) | **Médio (4)** | Juntada da pesquisa de preços de mercado do Banco de Preços/PNCP (Cotação de 23/02/2026) demonstrando a compatibilidade dentro da faixa homogênea. | Muito Eficaz | Muito Baixo | Mitigar | Nulo |
| **R08. Existência de Impedimentos Cadastrais ou Certidões Vencidas do Fornecedor:** Identificação de sanções no SICAF/CEIS/CADIN ou pendências fiscais da empresa Plugnet. | Baixa (1) | Alto (4) | **Médio (4)** | Emissão e renovação periódica de certidões de regularidade fiscal, trabalhista e de sanções administrativas previamente à assinatura. | Eficaz | Baixo | Monitorar | Nulo |

---

#### 2.2. Modelo MGR-03.01: Plano de Resposta, Monitoramento e Controle (Seleção do Fornecedor)

| Ameaça / Evento de Risco | Resposta ao Risco | O que fazer? (Ação Preventiva / Mitigadora) | Área Impactada | Responsável | Data Inicial | Data Final | Andamento da Ação |
| :--- | :--- | :--- | :--- | :--- | :---: | :---: | :---: |
| **R05. Anuência da UFAC e Fornecedor** | Mitigar | Encaminhar pedido formal de autorização à UFAC (UASG 154044) e obter o Ofício de Aceite incondicional da Plugnet mantendo todas as obrigações editalícias. | STI / GADG | Cleilton Nazaré Costa | 05/10/2026 | 14/10/2026 | **Em Andamento** (Manifestação da empresa obtida) |
| **R06. Limites de Adesão (50%)** | Prevenir | Instruir o processo com a demonstração aritmética do saldo disponível na ARP nº 26/2026 (170 de 875 unidades = 19,4%). | EPC / SDBD | Lucir Rocio Vaz | 25/09/2026 | 07/10/2026 | **Concluído** (Atestado no ETP) |
| **R07. Vantajosidade de Preços** | Mitigar | Anexar o Mapa Comparativo e o Relatório Resumido de Cotação da UFAC (Proc. 23107.021121/2024-88) comprovando que R$ 11.060,00 reflete a realidade de mercado com garantia de 60m. | EPC / SAOF | Altamiro Lima da Silva | 25/09/2026 | 07/10/2026 | **Concluído** (Anexado ao processo) |
| **R08. Regularidade do Fornecedor** | Monitorar / Tratar | Consultar SICAF, CNDT, Receita Federal e Certidão do CNJ antes da remessa à ASJUR e renovar imediatamente antes da assinatura do Contrato. | SAOF / SLC | Agente de Contratação | 10/10/2026 | 20/10/2026 | **Pendente** (Aguardando fase contratual) |

---

### 3. FASE DE GESTÃO E FISCALIZAÇÃO DO CONTRATO

#### 3.1. Modelo MGR-02.01: Classificação e Avaliação de Riscos (Gestão Contratual)

**Objetivo da Fase:** Assegurar o cumprimento integral das obrigações contratuais, a entrega tempestiva dos 170 notebooks no prazo de 60 dias corridos, o recebimento com suporte *on-site* de 60 meses e a entrada em operação sem prejuízo ao encerramento do exercício de 2026.

| Evento de Risco / Ameaça | Probabilidade (A) | Impacto (B) | Nível de Risco (A x B) | Controle Existente | Eficácia do Controle | Risco Residual | Classificação do Risco | Apetite ao Risco |
| :--- | :---: | :---: | :---: | :--- | :--- | :---: | :---: | :---: |
| **R09. Atraso na Entrega dos Equipamentos pelo Fornecedor:** Ocupação da fábrica ou gargalos na cadeia logística da HP impedindo a entrega no prazo editalício de 60 dias corridos. | Média (2) | Muito Alto (5) | **Elevado (10)** | Exigência de declaração prévia de compromisso de prazo (evento SEI 0919102), monitoramento semanal pela fiscalização técnica e aplicação do IAE. | Eficaz | Baixo | Mitigar | Reduzido |
| **R10. Entrega de Bens com Vícios ou Divergência de Especificação:** Notebooks entregues sem teclado retroiluminado, sem biometria IR, sem TPM 2.0 ativo ou com avarias no transporte. | Baixa (1) | Alto (4) | **Médio (4)** | Inspeção detalhada de recebimento provisório por amostragem de 100%, testes de bancada e recusa de itens em desconformidade. | Muito Eficaz | Muito Baixo | Mitigar | Nulo |
| **R11. Demora na Carga da Imagem Corporativa e Tombamento:** Atraso na preparação técnica dos 170 notebooks pela STI, postergando a distribuição aos usuários finais. | Média (2) | Médio (3) | **Médio (6)** | Automação do script de customização (Windows 11 Pro, VPN, PJe, SEI, Antivírus) e cronograma em lote de 4 Fases (35 dias úteis). | Eficaz | Baixo | Prevenir | Médio |
| **R12. Falhas na Prestação da Garantia *On-Site* de 60 Meses:** Demora no atendimento de chamados técnicos ou falta de peças originais de reposição pelo fabricante ao longo de 5 anos. | Baixa (1) | Alto (4) | **Médio (4)** | Glosas em faturamento/garantia contratual, acionamento do suporte direto HP Gold e aplicação das sanções da IN SGD/ME nº 94/2022. | Eficaz | Baixo | Mitigar | Nulo |

---

#### 3.2. Modelo MGR-03.01: Plano de Resposta, Monitoramento e Controle (Gestão Contratual)

| Ameaça / Evento de Risco | Resposta ao Risco | O que fazer? (Ação Preventiva / Mitigadora) | Área Impactada | Responsável | Data Inicial | Data Final | Andamento da Ação |
| :--- | :--- | :--- | :--- | :--- | :---: | :---: | :---: |
| **R09. Atraso na Entrega (60 dias)** | Mitigar / Reter / Aplicar Glosa | Emitir a Ordem de Fornecimento de Bens (OFB) imediatamente após o empenho; aplicar o Indicador de Atraso de Entrega (IAE - TR/Edital UFAC) com glosa de 0,1666%/dia se houver mora injustificada. | STI / Fiscal Técnico / SAOF | Fiscal Técnico do Contrato / Gestor Contratual | Data da OFB | +60 dias corridos | **Pendente** (Aguardando emissão da OFB) |
| **R10. Vícios ou Divergências Técnicas** | Mitigar / Rejeitar | Realizar triagem física no Almoxarifado Central (TRE-AC); lavrar Termo de Rejeição e notificar o fornecedor para substituição no prazo de 10 dias úteis sem custos adicionais. | STI / SSU / Almoxarifado | Comissão de Recebimento / Fiscal Técnico | Recebimento | +10 dias úteis | **Pendente** (Aguardando entrega física) |
| **R11. Demora no Tombamento e Carga** | Prevenir | Utilizar servidores de implantação em rede (FOG/WDS) para carga simultânea de imagem em lote e cadastramento patrimonial automatizado. | STI / SSU / SEPAT | Equipe de Suporte ao Usuário (SSU) | Recebimento | +25 dias úteis | **Pendente** (Aguardando entrega física) |
| **R12. Falhas na Garantia 60m *On-Site*** | Mitigar / Notificar Fabricante | Acompanhar os Níveis de Serviço (SLA de atendimento *on-site* em até 24h/48h); registrar chamados no canal oficial HP corporativo e notificar a contratada sob pena de multa. | STI / SSU | Gestor do Contrato / SSU | Distribuição | 60 meses | **Pendente** (Fase de execução contratual) |

---

### 4. CONCLUSÃO DA EQUIPE DE PLANEJAMENTO DA CONTRATAÇÃO

A Equipe de Planejamento da Contratação, designada nos termos da Instrução Normativa TRE-AC nº 72/2024 e da Resolução CNJ nº 468/2022, procedeu à identificação, análise, avaliação e estruturação do plano de resposta para todos os riscos mapeados nas fases de Planejamento, Seleção do Fornecedor e Gestão Contratual.

Considerando que:
1. Os riscos de maior relevância técnica (descontinuidade do modelo e fonte orçamentária) foram **plenamente mitigados e sanados** com o aceite da fabricante para o modelo superior HP EliteBook 6G1i 14 (evento SEI 0919102) e a vinculação da despesa aos recursos autônomos da Ação 21EE (Informação nº 0918910/2026/STI);
2. As medidas de controle preventivas e mitigadoras encontram-se devidamente atribuídas aos respectivos responsáveis com prazos definidos;
3. O nível de risco residual em todas as etapas situa-se dentro da margem de aceitabilidade institucional do Tribunal Regional Eleitoral do Acre;

\
Esta Equipe conclui pela **PLENA VIABILIDADE E OPORTUNIDADE** do prosseguimento da contratação.

\
Rio Branco - AC, 07 de outubro de 2026.


* **Cleilton Nazaré Costa**  
Secretário de Tecnologia da Informação — Integrante Demandante  
* **Ilis Sandro Antonio Areno Ambrosio**  
Integrante Técnico  
* **Lucir Rocio Vaz**  
Integrante Técnico  
* **Altamiro Lima da Silva**  
Integrante Administrativo  
