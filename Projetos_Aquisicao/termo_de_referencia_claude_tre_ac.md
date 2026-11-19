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
border: 1px solid #000;
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
**MINUTA DE TERMO DE REFERÊNCIA (TR)**
**PROCESSO SEI Nº:** 0001433-54.2026.6.01.8000  
**DISPENSA DE LICITAÇÃO Nº:** XX/2026 (Art. 75, Inciso II, da Lei nº 14.133/2021)  
**OBJETO:** Contratação de serviço especializado de Inteligência Artificial (IA), incluindo o fornecimento de licenças de uso da plataforma corporativa Claude Team (da Anthropic PBC, disponibilizadas pela Sauter Tecnologia e Serviços Ltda), para apoio às atividades de desenvolvimento de sistemas, engenharia de software, automação de processos e gestão de TI no âmbito do TRE-AC.

---

### 1. DO OBJETO

1.1. O presente Termo de Referência tem por objeto a contratação de serviço especializado de Inteligência Artificial (IA), contemplando o fornecimento de **10 (dez) licenças de uso corporativas da plataforma Claude Team** (sendo 8 licenças na modalidade *Standard* e 2 licenças na modalidade *Premium*), de titularidade da Anthropic PBC, disponibilizadas e intermediadas pela empresa representante oficial **Sauter Tecnologia e Serviços Ltda.**, com faturamento em moeda nacional (BRL), pelo período de 12 (doze) meses.

1.2. A contratação abrange:  

- Acesso à interface web, desktop e mobile da plataforma Claude Team;
- Acesso aos modelos de linguagem avançados (Claude Opus, Claude Sonnet, Claude Haiku e Claude Fable na licença Premium);
- Janela de contexto estendida de até 1.000.000 (um milhão) de tokens por requisição;
- Ferramentas integradas para desenvolvimento e análise de código (*Claude Code*), redação técnica, pesquisa corporativa e criação de documentos;
- Painel administrativo centralizado com autenticação via Single Sign-On (SSO/SAML 2.0) integrado ao provedor de identidade do TRE-AC;
- Garantia formal e contratual de privacidade e proteção de dados (LGPD), assegurando que o conteúdo submetido (*inputs*) e gerado (*outputs*) **não seja utilizado para treinamento de modelos**.

---

### 2. DA JUSTIFICATIVA E ALINHAMENTO ESTRATÉGICO

2.1. **Da Necessidade Institucional:** A Secretaria de Tecnologia da Informação (STI) do TRE-AC enfrenta um histórico acúmulo de demandas de desenvolvimento de software em desacordo com seu quadro reduzido de pessoal técnico. A adoção de ferramentas de IA assistida constitui estratégia indispensável para ampliar a capacidade produtiva da equipe, acelerar o ciclo de vida dos softwares e automatizar tarefas repetitivas (geração de código, testes unitários automatizados, documentação e refatoração).

2.2. **Dos Sistemas Estratégicos Impactados:** O fornecimento dos agentes de IA atenderá diretamente e de forma imediata o desenvolvimento, evolução e sustentação das seguintes soluções do Tribunal:
* **Sistema VERITAS (Cadastro de Magistrados):** Aplicação em Laravel 12 / PHP 8.2 / Oracle para centralização do histórico funcional de magistrados, atendimento ao CNJ e TCU.
* **Sistema SOLENE (Gestão de Cerimonial):** Modernização da gestão de eventos institucionais, credenciamento e nominatas dinâmicas (Resolução TRE-AC nº 349/2002).
* **Sistema DIÁRIAS (Gestão de Viagens a Serviço):** Remodelagem dos fluxos de concessão de diárias e passagens (IN TRE-AC nº 65/2023 e IN nº 75/2024).
* **Sistema JANUS:** Automação de rotinas processuais com suporte de IA.
* **Sistemas Corporativos Diversos:** Sustentação do AutoCadastro, Presença, VISIT (Gestão de Acesso Físico), Balcão Virtual e integrações PJe/SEI.

2.3. **Da Inviabilidade do Modelo de Reembolso:** Analisou-se a viabilidade de adotar modelo de reembolso de licenças individuais (a exemplo do TRE-TO), mas concluiu-se por sua inadequação jurídica e técnica. As assinaturas individuais não garantem a proteção dos dados institucionais sob a LGPD (permitindo o reuso de código e informações sensíveis do Tribunal para treinamento de modelos públicos), além de inviabilizar o controle de acessos corporativo (SSO), auditoria e governança exigidos pela **Resolução CNJ nº 615/2025**.

2.4. **Do Alinhamento Estratégico:** A demanda encontra amparo na Estratégia Nacional de TIC do Poder Judiciário (ENTIC-JUD), na Resolução CNJ nº 370/2021, na Resolução CNJ nº 615/2025 (Governança de IA no Judiciário) e nas diretrizes do Plano Diretor de TIC (PDTIC 2026) do TRE-AC.

2.5. **Da Contratação Imediata e Estratégia de Longo Prazo:** Trata-se de contratação imediata por dispensa de licitação para atendimento das necessidades prementes das equipes de TIC, sem prejuízo do concomitante amadurecimento e instrução de procedimento licitatório para contratação corporativa de longo prazo (período previsto de 36 a 60 meses).

---

### 3. ESPECIFICAÇÃO TÉCNICA E REQUISITOS DA SOLUÇÃO

3.1. **Composição das Licenças:**
* **8 (oito) Licenças Claude Team Standard:** Destinadas aos servidores e técnicos envolvidos no uso cotidiano de análise de requisitos, redação técnica, suporte, administração de bancos de dados e desenvolvimento moderado.
* **2 (duas) Licenças Claude Team Premium:** Destinadas aos especialistas de desenvolvimento avançado e arquitetura, oferecendo franquia de consumo 5 (cinco) vezes maior e acesso prioritário aos modelos mais avançados, incluindo o *Claude Fable*.

3.2. **Recursos Mínimos da Plataforma:**
* Acesso completo aos modelos Claude Opus, Claude Sonnet, Claude Haiku e Claude Fable (licença Premium).
* Capacidade de processamento de até 1.000.000 (um milhão) de tokens por contexto.
* Suporte nativo às ferramentas *Claude Code* (execução e análise de código), *Claude Cowork*, *Slides*, *Docs*, pesquisa corporativa e projetos compartilhados.
* Painel administrativo único para gerenciamento centralizado das 10 licenças.

3.3. **Requisitos de Segurança da Informação, Privacidade e LGPD:**
* **Garantia de Não Treinamento:** O fornecedor deverá garantir que os dados submetidos pelo TRE-AC e as respostas geradas pela plataforma não serão utilizados para treinamento ou aprimoramento de modelos públicos de IA da Anthropic PBC.
* **Autenticação Corporativa:** Suporte à integração Single Sign-On (SSO via SAML 2.0 ou OIDC) com o provedor de identidade do TRE-AC (Microsoft Entra ID / Authelia / Active Directory), assegurando o controle de credenciais pela STI.
* **Conformidade Normativa:** Aderência estrita à Lei Geral de Proteção de Dados (Lei nº 13.709/2018), aos Termos Comerciais (*Commercial Terms*) e ao Adendo de Processamento de Dados (*DPA*) da Anthropic PBC.
* **Supervisão Humana:** Em cumprimento ao art. 19 da Resolução CNJ nº 615/2025, todas as saídas (*outputs*) da IA estarão sujeitas à validação, revisão e responsabilidade técnica exclusiva dos servidores do Tribunal, sendo vedada a execução automatizada sem validação.

---

### 4. DO MODELO DE EXECUÇÃO E ENTREGAVEIS

4.1. **Prazo e Forma de Disponibilização:**
* As licenças deverão ser disponibilizadas e ativadas no ambiente corporativo do TRE-AC no prazo máximo de **até 7 (sete) dias úteis**, contados do recebimento formal do pedido de compra / Nota de Empenho emitida pelo Tribunal.
* A CONTRATADA deverá prestar suporte técnico inicial para a configuração do painel administrativo e integração do Single Sign-On (SSO).

4.2. **Vigência:** O contrato/instrumento equivalente terá vigência de **12 (doze) meses**, a contar da disponibilização efetiva das licenças.

---

### 5. DA ESTIMATIVA DE CUSTOS E CONDIÇÕES DE PAGAMENTO

5.1. **Da Proposta Comercial:** A presente contratação ampara-se na proposta comercial emitida pela empresa **Sauter Tecnologia e Serviços Ltda.** (CNPJ nº 36.569.241/0001-01), credenciada como parceira oficial *Select* da Anthropic PBC no Brasil.

5.2. **Detalhamento do Valor:**

| Item | Descrição do Licenciamento | Qtd | Valor Unitário Mensal (R$) | Valor Total Mensal (R$) | Valor Total 12 Meses (R$) |
| :---: | :--- | :---: | :---: | :---: | :---: |
| 1 | **Claude Team Standard** (Assento de uso cotidiano) | 8 | R$ 188,74 | R$ 1.509,99 | R$ 18.119,85 |
| 2 | **Claude Team Premium** (Assento de uso intensivo / Dev) | 2 | R$ 943,74 | R$ 1.887,48 | R$ 22.649,81 |
| **-** | **VALOR TOTAL GLOBAL DO CONTRATO** | **10** | **R$ 3.397,47** | **R$ 3.397,47** | **R$ 40.769,66** |

5.3. **Composição do Preço:** No valor global de **R$ 40.769,66 (quarenta mil, setecentos e sessenta e nove reais e sessenta e seis centavos)** estão inclusos todos os impostos, taxas, fretes, tributos e encargos trabalhistas, previdenciários e sociais incidentes.

5.4. **Condições de Pagamento:**
* O pagamento será realizado em moeda nacional (BRL), via transferência bancária, no prazo de até **30 (trinta) dias** contados da apresentação e aceite da Nota Fiscal devidamente atestada pela fiscalização do contrato.

---

### 6. DO MODELO DE GESTÃO E FISCALIZAÇÃO DO CONTRATO

6.1. A execução do contrato será acompanhada e fiscalizada por servidores formalmente designados pelo TRE-AC, nos termos do art. 117 da Lei nº 14.133/2021 e da Resolução CNJ nº 468/2022:
* **Gestor do Contrato:** Titular da Coordenadoria de Logística e Soluções Corporativas (CSCOR).
* **Fiscal Técnico:** Servidor lotado na Seção de Desenvolvimento e Banco de Dados (SDBD).
* **Fiscal Administrativo:** Servidor indicado pela Secretaria de Administração/STI.

6.2. Compete à fiscalização técnica verificar a disponibilização contínua das licenças, o funcionamento do SSO e o cumprimento das garantias de privacidade de dados.

---

### 7. DOS DEVERES DAS PARTES

7.1. **Deveres da CONTRATADA:**
a) Disponibilizar o quantitativo de 10 licenças ativas do plano Claude Team (8 Standard e 2 Premium) dentro do prazo fixado;
b) Emitir a Nota Fiscal em moeda nacional conforme a legislação tributária brasileira;
c) Manter durante a execução contratual todas as condições de habilitação e qualificação exigidas;
d) Garantir o suporte técnico necessário à administração das licenças e resolução de incidentes.

7.2. **Deveres do CONTRATANTE (TRE-AC):**
a) Fornecer as informações necessárias para a configuração do domínio e integração do SSO;
b) Exigir que os usuários observem as políticas de uso aceitável e sigilo de credenciais;
c) Efetuar o pagamento nos prazos e condições estabelecidos;
d) Garantir a supervisão humana sobre as saídas geradas pelos agentes de IA.

---

### 8. DO ENQUADRAMENTO LEGAL

8.1. A presente contratação enquadra-se na hipótese de **Dispensa de Licitação em razão do valor**, fundamentada no **art. 75, inciso II, da Lei nº 14.133/2021** (valor total inferior aos limites regulamentares para contratação de bens e serviços comuns de TIC).

\
Rio Branco/AC, outubro de 2026.