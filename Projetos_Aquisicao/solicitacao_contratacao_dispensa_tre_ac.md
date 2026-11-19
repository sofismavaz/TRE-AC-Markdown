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
font-size: 12pt;
font-weight: bold;
text-align: center;
margin-top: 12pt;
margin-bottom: 12pt;
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
font-size: 9pt;
margin-top: 12pt;
margin-bottom: 12pt;
}

th, td {
#border: 1px solid #000;
padding: 5px;
vertical-align: top;
}

li {
text-align: justify;
line-height: 1.5;
}
</style>

\
DEMANDANTES: 

* **Seção de Desenvolvimento e Banco de Dados (SDBD)**  
* **Coordenadoria de Logística e Soluções Corporativas (CSCOR)**  
* **Secretaria de Tecnologia da Informação (STI / TRE-AC)**

---

\
**PROCESSO SEI Nº:** 0001433-54.2026.6.01.8000  
**DOCUMENTO:** SOLICITAÇÃO DE CONTRATAÇÃO IMEDIATA POR DISPENSA DE LICITAÇÃO  
**ASSUNTO:** Contratação emergencial e imediata de serviço especializado de Inteligência Artificial (Plano Corporativo Claude Team) por dispensa de licitação, enquanto se instrui o procedimento licitatório de longo prazo.

---

#### 1. DA DEMANDA E CONTEXTO INSTITUCIONAL

A Secretaria de Tecnologia da Informação (STI) do Tribunal Regional Eleitoral do Acre (TRE-AC), por meio da Coordenadoria de Logística e Soluções Corporativas (CSCOR) e da Seção de Desenvolvimento e Banco de Dados (SDBD), submete o presente pedido para a **contratação imediata de serviço especializado de Inteligência Artificial (IA)**, mediante **dispensa de licitação**, com fulcro na Lei nº 14.133/2021.

A demanda justifica-se pelo reduzido quantitativo de profissionais de desenvolvimento de software em contraste com um acúmulo histórico de demandas institucionais. Para suprir essa limitação e cumprir as metas fixadas no Plano Diretor de TIC (PDTIC 2026), na Estratégia Nacional de TIC do Poder Judiciário (ENTIC-JUD) e na Resolução CNJ nº 615/2025, torna-se indispensável o uso de agentes de IA para aceleração do ciclo de vida de desenvolvimento de softwares, geração de testes automatizados, revisão de código e refatoração.

---

#### 2. ANÁLISE DO MODELO DE REEMBOLSO VERSUS CONTRATAÇÃO CORPORATIVA (LGPD E SEGURANÇA DA INFORMAÇÃO)

Durante a instrução do processo, avaliou-se a alternativa de instituição de mecanismo de ressarcimento/reembolso aos servidores para aquisição individual de licenças de IA, a exemplo do modelo adotado pela Resolução TRE-TO nº 614/2025. Contudo, após análise técnica aprofundada, conclui-se que o modelo de reembolso **não atende aos requisitos institucionais de segurança e governança**, apresentando os seguintes riscos críticos:

1. **Insegurança quanto à Proteção de Dados (LGPD):** Nas assinaturas individuais/avulsas, os termos de uso dos provedores de IA não oferecem garantia de não utilização dos dados para treinamento. As empresas contratadas individualmente podem utilizar o código-fonte, dados e prompts do Tribunal como massa de dados para aperfeiçoamento de modelos experimentais e públicos.
2. **Ausência de Governança e Auditabilidade:** Contas pessoais impede a integração com o Provedor de Identidade Institucional (SSO/SAML 2.0), a gestão centralizada de acessos, a revogação imediata de credenciais em desligamentos e a extração de logs de auditoria exigidos pelo CNJ.
3. **Desconformidade com a Resolução CNJ nº 615/2025:** O normativo do CNJ exige controle estrito sobre as ferramentas de IA generativa utilizadas no Judiciário, exigindo supervisão humana e garantia de sigilo institucional.

Em contrapartida, a **contratação corporativa** do plano **Claude Team** assegura, mediante Termos Comerciais e DPA (Data Processing Addendum):
* Garantia expressa de que os dados de entrada (*inputs*) e respostas (*outputs*) **não são utilizados para treinamento de modelos** da Anthropic.
* Autenticação centralizada via Single Sign-On (SSO/SAML 2.0).
* Gestão corporativa de privacidade e conformidade integral com a LGPD (Lei nº 13.709/2018).

---

#### 3. DA IMINÊNCIA DA NECESSIDADE E DOS SISTEMAS AFETADOS

A necessidade de disponibilização das ferramentas de IA é **iminente e crítica**, pois a equipe técnica encontra-se em fase decisiva de desenvolvimento e evolução de diversos sistemas estratégicos do Tribunal. A ausência do suporte dos agentes de IA impacta diretamente os prazos de entrega das seguintes soluções:

1. **SISTEMA VERITAS (Cadastro de Magistrados):** Aplicação web corporativa em desenvolvimento (utilizando Laravel 12, PHP 8.2, Oracle Database e Docker) para gestão unificada do histórico funcional, profissional e emissão de certidões automatizadas para CNJ e TCU.
2. **SISTEMA SOLENE (Gestão de Cerimonial):** Solução corporativa destinada à modernização da gestão de eventos institucionais, credenciamento, emissão de convites e gestão de nominatas dinâmicas sob a Resolução TRE-AC nº 349/2002.
3. **SISTEMA DIÁRIAS (Gestão de Viagens a Serviço):** Remodelagem integral do sistema de concessão de diárias e passagens, com cálculo automatizado, integração obrigatória ao SEI e fluxo financeiro regido pela IN TRE-AC nº 65/2023 e IN nº 75/2024.
4. **SISTEMA JANUS:** Solução de automação processual judicial que requer expansão e integração contínua de rotinas inteligentes.
5. **SISTEMAS CORPORATIVOS EM SUSTENTAÇÃO:** Manutenção e evolução do Balcão Virtual, PJe, Sistema SEI e canais de atendimento inteligente via WhatsApp/Chatbot.

---

#### 4. DA VIABILIDADE DA CONTRATAÇÃO IMEDIATA POR DISPENSA DE LICITAÇÃO E PLANO FUTURO DE LONGO PRAZO

Para garantir o atendimento imediato da demanda sem paralisar o desenvolvimento dos sistemas estratégicos, propõe-se a **contratação imediata por Dispensa de Licitação**, fundamentada no art. 75 da Lei nº 14.133/2021, em razão do baixo valor financeiro global envolvido e do caráter emergencial das entregas de TIC.

Paralelamente à execução desta contratação imediata, a STI dará prosseguimento e amadurecimento ao procedimento licitatório regular (ou Adesão à Ata de Registro de Preços) para estruturação de um contrato de longo prazo, com vigência prevista entre **36 e 60 meses**, garantindo a sustentabilidade tecnológica contínua da Justiça Eleitoral do Acre.

---

#### 5. PROPOSTA COMERCIAL E VALORES DA CONTRATAÇÃO

Com base na Proposta Comercial oficial apresentada pela empresa **Sauter Tecnologia e Serviços Ltda** (CNPJ nº 36.569.241/0001-01), credenciada como parceira Select oficial da Anthropic no Brasil, o escopo de licenciamento para o período de 12 (doze) meses estrutura-se da seguinte forma:

| Descrição do Item | Quantidade | Valor Unitário Mensal | Valor Total Mensal | Valor Total (12 Meses) |
| :--- | :---: | :---: | :---: | :---: |
| **Claude Team Standard** (Usuários de uso cotidiano em desenvolvimento e gestão) | 8 licenças | R$ 188,74 | R$ 1.509,99 | R$ 18.119,85 |
| **Claude Team Premium** (Usuários de uso intensivo, desenvolvimento avançado e agentes) | 2 licenças | R$ 943,74 | R$ 1.887,48 | R$ 22.649,81 |
| **VALOR TOTAL GLOBAL** | **10 licenças** | **R$ 3.397,47** | **R$ 3.397,47** | **R$ 40.769,66** |

**Condições Comerciais:**
* **Valor Global:** R$ 40.769,66 (quarenta mil, setecentos e sessenta e nove reais e sessenta e seis centavos), com todos os impostos e encargos inclusos.
* **Prazo de Disponibilização:** Em até 7 (sete) dias úteis após o aceite formal.
* **Condições de Pagamento:** Faturamento em moeda nacional (BRL), pagamento em até 30 dias após emissão da Nota Fiscal.

---

#### 6. DA CONCLUSÃO E ENCAMINHAMENTO

Diante do exposto, demonstrada a inviabilidade do modelo de reembolso frente à LGPD, a necessidade iminente de apoio aos projetos estratégicos (Veritas, Solene, Diárias, Janus) e a vantajosidade econômica do valor de R$ 40.769,66 anuais, **SOLICITA-SE**:

1. A aprovação da **contratação imediata por dispensa de licitação** de 10 licenças do plano Claude Team (8 Standard e 2 Premium) com a empresa Sauter Tecnologia e Serviços Ltda, pelo valor global de R$ 40.769,66.
2. O prosseguimento da instrução processual em paralelo para amadurecimento e modelagem de contratação corporativa de longo prazo (36 a 60 meses).

\
Rio Branco/AC, outubro de 2026.