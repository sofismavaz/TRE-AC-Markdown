# Cria Artefatos de Documentação do Projeto

O **"Roteiro de Prompts por Papel"** revisado que incorpora o alinhamento normativo-patrimonial, os parâmetros temporais e de ciclo de vida contábil, e a inclusão da cláusula de **Governança Patrimonial** no papel de **Mensurador de Software (CFPS/IFPUG)**.

### Precisão Terminológica Normativa
Em observância à **NBC TSP 08 (Ativo Intangível)**, ao **MCASP (9ª ed.)** e à **Orientação SOF/TSE nº 15/2022**:
* **Ativos Intangíveis** (como softwares) estão sujeitos à **Amortização** (alocação sistemática do valor amortizável ao longo da vida útil econômica) e à **Redução ao Valor Recuperável (*Impairment*)**. 
* A **Depreciação** aplica-se formalmente aos bens materiais do Ativo Imobilizado (NBC TSP 07). Para assegurar estrita coerência normativa, o parâmetro `[indicador de depreciação]` é representado nos prompts em equivalência com a `[taxa/indicador de amortização acumulada e depreciação]`.

---

### Roteiro Reconstruído e Padronizado de Prompts por Papel

#### 1. Especialista em Governança de TI no Poder Judiciário e Engenheiro de Requisitos
* **Objetivo:** Elaborar o Documento de Formalização da Demanda (DFD), assegurando enquadramento nos Macrodesafios, parâmetros temporais de projeto e fundamentação para reconhecimento do Ativo Intangível.
* **Estrutura de Prompt:**
  > `"Atue como Especialista em Governança de TI no Poder Judiciário e Engenheiro de Requisitos. Com base na NBR ISO 21502:2021, PMBOK, Resolução CNJ nº 335/2020 (PDPJ-Br), NBR ISO/IEC/IEEE 12207, Orientação SOF/TSE nº 15/2022 e NBC TSP 08:`  
  > `1. Elabore o Documento de Formalização da Demanda (DFD) para a solução [Nome do Sistema / Solução OpenSource Archivemática e AtoM].`  
  > `2. PARÂMETROS TEMPORAIS E DE CICLO DE VIDA: Registre os marcos do projeto utilizando os parâmetros: [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e [indicador de depreciação / taxa de amortização acumulada].`  
  > `3. ENQUADRAMENTO ESTRATÉGICO: Vincule o projeto aos Macrodesafios do Poder Judiciário (ex.: 'Aperfeiçoamento da Governança e da Gestão' e 'Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética').`  
  > `4. FUNÇÃO PARAMETRIZÁVEL DE IMPACTO: Modele a função I_impacto = f(Macrodesafio, Indicador_Alvo, Diretriz_Gestao), detalhando a contribuição esperada nos indicadores institucionais (ex.: iGovTIC-JUD, Índice de Maturidade em Gestão por Processos e Riscos, Índice de Transparência Ativa).`  
  > `5. FUNDAMENTAÇÃO PATRIMONIAL: Apresente a justificativa de governança para o reconhecimento futuro da solução como Ativo Intangível Gerado Internamente ou Adaptado (potencial de serviços e benefícios econômicos futuros).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 2. Engenheiro de Requisitos Sênior
* **Objetivo:** Especificar a ERS segregando entregas pelas fases contábeis formais (Pesquisa vs. Desenvolvimento) e alinhando requisitos a parâmetros temporais e indicadores estratégicos.
* **Estrutura de Prompt:**
  > `"Atue como Engenheiro de Requisitos Sênior. Elabore a Especificação de Requisitos de Software (ERS) fundamentada na NBR ISO/IEC/IEEE 12207, MCASP (9ª ed.), NBC TSP 08 e Orientação SOF/TSE nº 15/2022:`  
  > `1. Classifique estritamente os Requisitos Funcionais (RF), Não Funcionais (RNF) e Regras de Negócio (RN) em duas etapas patrimoniais: a) Fase de Pesquisa (estudos de viabilidade, prototipagem, tratados como Variação Patrimonial Diminutiva — VPD); e b) Fase de Desenvolvimento (requisitos cujos custos são ativáveis como valor original do ativo intangível).`  
  > `2. ESTRUTURAÇÃO TEMPORAL: Incorpore os parâmetros [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] do software e o [indicador de depreciação / taxa de amortização acumulada] esperada pós-ativação.`  
  > `3. ALINHAMENTO ESTRATÉGICO: Associe os requisitos ao Macrodesafio correspondente e configure a função I_requisito = f(Macrodesafio, Taxa_Congestionamento, Meta_Ciclo) para orientar a repriorização do backlog conforme novas diretrizes de gestão.`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 3. Especialista em BPMN 2.0 e Modelagem de Processos
* **Objetivo:** Mapear o processo de trabalho TO-BE integrando as áreas de TI, Engenharia de Software, Contabilidade e Gestão Patrimonial, com pontos de controle de ciclo de vida do ativo.
* **Estrutura de Prompt:**
  > `"Atue como Especialista em BPMN 2.0. Mapeie e descreva o fluxo de processos TO-BE para especificação, desenvolvimento, homologação e ativação patrimonial da solução [Nome do Sistema]:`  
  > `1. Modele raias de responsabilidade (Pools/Lanes) para a Secretaria de TI, Coordenadoria de Finanças/Contabilidade, Setor Patrimonial e Unidades Demandantes.`  
  > `2. PONTOS DE CONTROLE PATRIMONIAL: Evidencie os marcos formais de transição entre a Fase de Pesquisa e a Fase de Desenvolvimento, o marco de disponibilidade operacional para início da amortização e a apuração dos parâmetros: [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e [indicador de depreciação / taxa de amortização acumulada].`  
  > `3. ENQUADRAMENTO ESTRATÉGICO E MÁQUINA DE ESTADOS: Vincule o fluxo ao Macrodesafio 'Aperfeiçoamento da Governança e da Gestão' e defina gateways parametrizados pela função I_processo = f(Macrodesafio, Tempo_Execucao, Indice_Maturidade_Contratual).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 4. Especialista em Draw.io e Mermaid.js
* **Objetivo:** Gerar diagramas visuais em código Mermaid.js demonstrando a integração entre desenvolvimento de software, rastreabilidade temporal e contabilização patrimonial.
* **Estrutura de Prompt:**
  > `"Atue como Especialista em Draw.io e Mermaid.js. Escreva o código Mermaid.js completo para representar:`  
  > `1. O diagrama de sequência e fluxo de integração entre as ferramentas de desenvolvimento/gestão de demandas (Jira/SIGEPRO), o sistema automatizado de apuração de custos e os sistemas contábeis/patrimoniais (SIAFI/ASI).`  
  > `2. RASTREABILIDADE TEMPORAL E PATRIMONIAL: Ilustre os eventos de passagem dos parâmetros [Data de início do projeto], [Data de fim do projeto], ativação com [perspectiva de tempo de vida útil] e registro do [indicador de depreciação / taxa de amortização acumulada].`  
  > `3. ALINHAMENTO ESTRATÉGICO: Identifique nos nós do diagrama o vínculo com o Macrodesafio 'Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética' e a função parametrizável I_visual = f(Macrodesafio, Modulo_Software, Indicador_Alvo).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 5. Arquiteto de Software Principal
* **Objetivo:** Projetar a Documentação de Arquitetura de Software (DAS) em conformidade com a PDPJ-Br, prevendo mensuração modular de custo ativável e monitoramento de vida útil tecnológica.
* **Estrutura de Prompt:**
  > `"Atue como Arquiteto de Software Principal. Elabore a Documentação de Arquitetura de Software (DAS) em estrita conformidade com a Resolução CNJ nº 335/2020 (PDPJ-Br) e a NBR ISO/IEC/IEEE 12207:`  
  > `1. Projete a solução em microsserviços e módulos conteinerizados, permitindo a mensuração individualizada dos custos de desenvolvimento de cada componente para fins de ativação patrimonial (Custo Direto ou Valor Justo via APF).`  
  > `2. CICLO DE VIDA E PARÂMETROS CONTÁBEIS: Defina os requisitos arquiteturais para registro e acompanhamento dos parâmetros: [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] dos componentes e [indicador de depreciação / taxa de amortização acumulada].`  
  > `3. ENQUADRAMENTO ESTRATÉGICO: Alinhe a arquitetura ao Macrodesafio 'Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética' e modele a função I_arquitetura = f(Macrodesafio, Indice_Disponibilidade, iGovTIC-JUD).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 6. Engenheiro de Dados e Modelador UML
* **Objetivo:** Estruturar o modelo de dados e diagramas UML incorporando entidades de controle de versão, classificação da LGPD, amortização e baixa por obsolescência.
* **Estrutura de Prompt:**
  > `"Atue como Engenheiro de Dados e Modelador UML. Crie os Diagramas de Classe, Diagrama de Entidade-Relacionamento (DER) e o Dicionário de Dados do sistema:`  
  > `1. Inclua entidades e atributos específicos para controle de versão, histórico de alterações, LGPD, além de campos patrimoniais obrigatórios: [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil], valor residual, [indicador de depreciação / taxa de amortização acumulada] e perdas por redução ao valor recuperável (*impairment*).`  
  > `2. ENQUADRAMENTO ESTRATÉGICO: Mapeie o modelo ao Macrodesafio 'Fortalecimento da Estratégia Nacional de TIC e de Proteção de Dados'.`  
  > `3. FUNÇÃO PARAMETRIZÁVEL DE DADOS: Formule a função I_dados = f(Macrodesafio, Indice_Adesao_LGPD, Taxa_Obsolescencia_Tecnologica) para sinalizar a necessidade de revisão da vida útil ou baixa do ativo por desuso.`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 7. Engenheiro de Qualidade de Software (QA)
* **Objetivo:** Elaborar o Plano de Testes e estabelecer o Termo de Aceite Definitivo que marca o fim da fase de desenvolvimento e o início da alocação sistemática da amortização contábil.
* **Estrutura de Prompt:**
  > `"Atue como Engenheiro de Qualidade de Software (QA). Desenvolva o Plano de Testes de Software e a Matriz de Casos de Teste (funcionais, segurança, desempenho e interoperabilidade) alinhados à NBR ISO/IEC/IEEE 12207:`  
  > `1. Estabeleça os critérios formais do Termo de Aceite Definitivo que ateste que o software está em condições operacionais pretendidas pela administração, definindo o marco temporal exato para cessar a capitalização de custos e registrar a [Data de fim do projeto], iniciando a contagem da [perspectiva de tempo de vida útil] e do [indicador de depreciação / taxa de amortização acumulada].`  
  > `2. PARÂMETROS DE EXECUÇÃO: Registre explicitamente no plano os parâmetros [Data de início do projeto] e [Data de fim do projeto].`  
  > `3. ENQUADRAMENTO ESTRATÉGICO: Alinhe a estratégia ao Macrodesafio 'Agilidade, Efetividade e Qualidade na Prestação Jurisdicional' e configure a função I_qualidade = f(Macrodesafio, Cobertura_Testes, Satisfacao_Usuario).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 8. Agile Product Owner e Prompt Engineer para Desenvolvimento com IA
* **Objetivo:** Decompor o backlog em histórias de usuário etiquetadas por fase patrimonial e macrodesafio, gerando prompts de execução com parâmetros temporais do projeto.
* **Estrutura de Prompt:**
  > `"Atue como Agile Product Owner e Prompt Engineer para Desenvolvimento com IA (Claude/Codex/Cursor). Escreva o Product Backlog (Epics e User Stories em BDD/Given-When-Then):`  
  > `1. Etiquete cada História de Usuário com sua respectiva classificação: a) Etapa Patrimonial ('[Fase de Pesquisa - VPD]' ou '[Fase de Desenvolvimento - Custo Ativável]'); e b) Macrodesafio Institucional correspondente.`  
  > `2. CONTEXTUALIZAÇÃO TEMPORAL DO PROJETO: Insira no cabeçalho do backlog os parâmetros globais [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e [indicador de depreciação / taxa de amortização acumulada].`  
  > `3. FUNÇÃO PARAMETRIZÁVEL: Implemente a função I_backlog = f(Macrodesafio, Prioridade_Story, Peso_Indicador_Estrategico) para recalcular automaticamente a priorização das entregas diante de mudanças no plano de gestão.`  
  > `4. PROMPTS DE EXECUÇÃO: Para cada história, elabore o prompt otimizado para assistentes de IA gerarem código aderente às normas da PDPJ-Br e NBR ISO/IEC/IEEE 12207.`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 9. Mensurador de Software Certificado (CFPS/IFPUG) e Gestor Contratual
* **Objetivo:** Realizar a Análise de Pontos de Função (APF) para valoração do Ativo Intangível pelo Valor Justo, calcular a memória de custeio e incluir as diretrizes obrigatórias de Governança Patrimonial.
* **Estrutura de Prompt:**
  > `"Atue como Mensurador de Software Certificado (CFPS/IFPUG) e Gestor Contratual. Realize a contagem de Análise de Pontos de Função (APF) do projeto segundo o CPM/IFPUG, identificando ALI, AIE, EE, SE e CE:`  
  > `1. MENSURAÇÃO E VALORAÇÃO PATRIMONIAL: Apure o tamanho funcional em PF e calcule a memória de estimativa pelo Valor Justo do Ativo Intangível (Tamanho Funcional x Valor Unitário do PF praticado no mercado ou contrato), fornecendo o suporte para reconhecimento contábil conforme os itens 5.2 e 5.3 da Orientação SOF/TSE nº 15/2022 e a IN TCU nº 84/2020.`  
  > `2. GOVERNANÇA PATRIMONIAL: Inclua uma seção orientativa para a TI e o Setor Patrimonial diferenciando manutenção rotineira (despesa/VPD) de novas funcionalidades capitalizáveis, bem como procedimentos de notificação para baixa patrimonial por desuso, substituição ou obsolescência técnica (conforme apontado nas auditorias contábeis do Judiciário).`  
  > `3. PARÂMETROS TEMPORAIS E CONTÁBEIS: Incorpore à memória de cálculo os parâmetros [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] do software e o [indicador de depreciação / taxa de amortização acumulada].`  
  > `4. ENQUADRAMENTO ESTRATÉGICO: Vincule o orçamento e o dimensionamento aos Macrodesafios 'Aperfeiçoamento da Gestão Orçamentária e Financeira' e 'Aperfeiçoamento da Governança e da Gestão', definindo a função I_financeiro = f(Macrodesafio, Valor_Justo_Software, Indice_Perda_Orçamentaria).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 10. Analista de O&M e Designer de Manuais Técnicos
* **Objetivo:** Redigir manuais operacionais e guias técnicos em linguagem simples, orientando a governança patrimonial, o ciclo de uso e os procedimentos de baixa por desuso ou obsolescência.
* **Estrutura de Prompt:**
  > `"Atue como Analista de O&M e Designer de Manuais Técnicos. Desenvolva o Manual de Operação e Manutenção do Software e o Guia do Usuário alinhados à NBR ISO/IEC/IEEE 12207:`  
  > `1. Aplique técnicas de Linguagem Simples e Direito Visual para assegurar clareza aos magistrados, servidores e colaboradores.`  
  > `2. SEÇÃO DE GOVERNANÇA PATRIMONIAL DO SOFTWARE: Estabeleça orientações práticas para as unidades administrativas e de TI quanto aos registros dos parâmetros [Data de início do projeto], [Data de fim do projeto], acompanhamento da [perspectiva de tempo de vida útil] e apuração do [indicador de depreciação / taxa de amortização acumulada]. Detalhe os procedimentos formais de notificação à área patrimonial em caso de manutenção evolutiva (capitalizável) versus corretiva (despesa/VPD), bem como o fluxo de baixa patrimonial por desuso, substituição tecnológica ou obsolescência.`  
  > `3. ENQUADRAMENTO ESTRATÉGICO: Conecte a documentação aos Macrodesafios 'Aperfeiçoamento da Comunicação Institucional e Combate à Desinformação' e 'Aperfeiçoamento da Gestão de Pessoas', modelando a função I_adocao = f(Macrodesafio, Indice_Capacitacao, Satisfacao_Usuarios_TI).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

### Estrutura Mestre de Instanciação Atualizada

```text
[PAPEL]: Atue como <Inserir Papel de 1 a 10>
[MARCO LEGAL E CONTÁBIL]: NBR ISO 21502:2021, PMBOK, NBR ISO/IEC/IEEE 12207, Lei nº 14.133/2021, Resolução CNJ nº 335/2020 (PDPJ-Br), Orientação SOF/TSE nº 15/2022, MCASP (9ª ed.), NBC TSP 08 e IN TCU nº 84/2020.
[PARÂMETROS TEMPORAIS E CONTÁBEIS]:
  - Data de início do projeto: [Data de início do projeto]
  - Data de fim do projeto: [Data de fim do projeto]
  - Perspectiva de tempo de vida útil: [perspectiva de tempo de vida útil]
  - Indicador de depreciação / Amortização: [indicador de depreciação]
[ENQUADRAMENTO ESTRATÉGICO]: Mapeamento no(s) Macrodesafio(s) Institucional(is) <Selecionar Macrodesafio 1 a 13>.
[FUNÇÃO PARAMETRIZÁVEL DE IMPACTO]: I_impacto = f(Macrodesafio, Indicador_Estratégico, Parâmetro_Gestão) para acolher mudanças de diretrizes e políticas públicas.
[CONTEXTO DE ENTRADA]: Projeto/Sistema [Nome da Solução] / Documento de Formalização da Demanda (DFD).
[ENTREGA REQUISITADA]: <Especificar o artefato técnico ou funcional pretendido>.
[FORMATO OBRIGATÓRIO DE SAÍDA]: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md).
```
---

# Cria Documentação de Conclusão do Projeto

Cria a documentação da **Fase de Conclusão, Aceite, Transição e Incorporação Patrimonial de Projetos de Software**.

Essa seção alinha os artefatos de encerramento às exigências da **Lei nº 14.133/2021** (art. 140), **Resolução CNJ nº 335/2020** (PDPJ-Br), **Resolução CNJ nº 363/2020** (LGPD), **NBR ISO/IEC/IEEE 12207**, **NBR ISO 21502 / PMBOK**, **NBC TSP 08**, **MCASP (9ª ed.)**, **Orientação SOF/TSE nº 15/2022**, **IN TCU nº 84/2020**, aos **Macrodesafios Institucionais** e às determinações de auditoria contábil-patrimonial do Poder Judiciário (prevenção do desuso indevido e da subavaliação de ativos gerados internamente).

---

### Nova Seção do Roteiro: Prompts de Conclusão, Aceite, Transição e Incorporação Patrimonial

#### 1. Declaração de Prontidão e Aceite Provisório (Disponibilização e Transição)
* **Objetivo:** Formalizar a conclusão das etapas de desenvolvimento e testes unitários/integrados, emitindo o Termo de Recebimento Provisório (TRP) e o Certificado de Prontidão para Implantação.
* **Estrutura de Prompt:**
  > `"Atue como Engenheiro de Qualidade de Software (QA) e Gestor do Projeto. Com base no art. 140 da Lei nº 14.133/2021, NBR ISO/IEC/IEEE 12207 (Processos de Transição e Aceitação) e NBR ISO 21502:`  
  > `1. Elabore a Declaração de Prontidão e o Termo de Recebimento Provisório (TRP) para a solução [Nome do Sistema / Solução OpenSource Archivemática e AtoM].`  
  > `2. EVIDÊNCIAS TÉCNICAS: Inclua o Relatório de Cobertura de Testes e Homologação Técnica (comprovando a ausência de defeitos críticos ou bloqueantes) e o Plano de Deploy/Rollout para o ambiente de homologação/produção.`  
  > `3. PARÂMETROS TEMPORAIS E CONTÁBEIS: Registre os parâmetros [Data de início do projeto] e [Data de fim do projeto] (marco de encerramento da fase de desenvolvimento), indicando a estimativa para [perspectiva de tempo de vida útil] e o início da apuração da [taxa de amortização acumulada e depreciação].`  
  > `4. ALINHAMENTO ESTRATÉGICO: Conecte o aceite provisório ao Macrodesafio 'Agilidade, Efetividade e Qualidade na Prestação Jurisdicional' e à função parametrizável I_aceite = f(Macrodesafio, Taxa_Cobertura_Testes, Tempo_Atendimento_Erros).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 2. Dossiê do Produto e Rastreabilidade de Requisitos
* **Objetivo:** Consolidação do Dossiê Técnico do Software (Baseline da Engenharia), garantindo a rastreabilidade integral entre requisitos de negócio, decisões arquiteturais, código-fonte e casos de teste.
* **Estrutura de Prompt:**
  > `"Atue como Engenheiro de Requisitos Sênior e Arquiteto de Software Principal. Com base na NBR ISO/IEC/IEEE 12207 (Processos de Definição de Requisitos e Arquitetura) e Resolução CNJ nº 335/2020:`  
  > `1. Elabore o Dossiê Técnico do Software (Baseline da Engenharia) da solução [Nome do Sistema].`  
  > `2. CONTEÚDO TÉCNICO: Consolide a Especificação de Requisitos de Software (ERS), Histórias de Usuário (BDD), Registros de Decisão Arquitetural (ADRs), Modelagem de Dados/APIs e a Matriz de Rastreabilidade de Requisitos (vinculando requisitos de negócio, componentes de código, microsserviços e casos de teste).`  
  > `3. SEGREGAÇÃO PATRIMONIAL: Destaque a separação formal entre os requisitos referentes à Fase de Pesquisa (VPD/despesa) e à Fase de Desenvolvimento (custo ativável do intangível), segundo a NBC TSP 08 e Orientação SOF/TSE nº 15/2022.`  
  > `4. PARÂMETROS DO ATIVO: Associe o dossiê aos parâmetros [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e [taxa de amortização acumulada e depreciação].`  
  > `5. ALINHAMENTO ESTRATÉGICO: Configure a função I_dossie = f(Macrodesafio, Indice_Rastreabilidade, Complexidade_Arquitetural) vinculada ao Macrodesafio 'Aperfeiçoamento da Governança e da Gestão'.`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 3. Parecer de Alinhamento Estratégico
* **Objetivo:** Emitir o relatório formal demonstrando a contribuição da entrega do software para os Objetivos Estratégicos, Macrodesafios e Indicadores Institucionais.
* **Estrutura de Prompt:**
  > `"Atue como Especialista em Governança de TI e Planejamento Estratégico. Com base na NBR ISO 21502, PMBOK, Resolução CNJ nº 325/2020 e no Plano Estratégico Institucional:`  
  > `1. Elabore o Parecer de Alinhamento Estratégico e Relatório de Benefícios do software [Nome do Sistema].`  
  > `2. MAPEAMENTO DE IMPACTO: Demonstre o impacto direto da solução nos Macrodesafios do Poder Judiciário (ex.: 'Aperfeiçoamento da Governança e da Gestão' e 'Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética').`  
  > `3. MÁQUINA DE PARAMETRIZAÇÃO: Modele a função I_impacto = f(Macrodesafio, Indicador_Alvo, Diretriz_Gestao), detalhando a fórmula de cálculo e a contribuição em indicadores reais (ex.: iGovTIC-JUD, Taxa de Congestionamento Líquida, Índice de Transparência Ativa), garantindo que a função aceite repriorizações do planejamento.`  
  > `4. CONTEXTO TEMPORAL: Incorpore os parâmetros globais [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e [taxa de amortização acumulada e depreciação].`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 4. Relação de Entregáveis / Inventário de Produtos
* **Objetivo:** Relacionar objetivamente todos os ativos de software, código-fonte, esquemas de banco de dados, repositórios e manuais incorporados ao ecossistema de TI.
* **Estrutura de Prompt:**
  > `"Atue como Agile Product Owner e Gerente de Configuração. Com base na NBR ISO/IEC/IEEE 12207 (Gestão de Configuração e Ativos de Software):`  
  > `1. Elabore a Relação de Entregáveis e Inventário de Ativos Gerados para o software [Nome do Sistema].`  
  > `2. DETALHAMENTO DO INVENTÁRIO: Liste os repositórios do código-fonte (commits, tags de versão release), microsserviços, esquemas/scripts de banco de dados, esteiras de DevOps/CI-CD, Manual do Usuário e Guia de Operação e Manutenção.`  
  > `3. PREVENÇÃO DE ACHADOS DE AUDITORIA: Registre a solução no inventário formal de TI para evitar a subavaliação do patrimônio (conforme auditoria contábil sobre sistemas sem registro contábil) e instrua a vinculação operacional.`  
  > `4. REGISTRO DE PARÂMETROS: Associe o inventário aos parâmetros [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e [taxa de amortização acumulada e depreciação].`  
  > `5. ALINHAMENTO ESTRATÉGICO: Configure a função I_inventario = f(Macrodesafio, Qtd_Ativos_Gerados, Indice_Reuso_PDPJ) conectada ao Macrodesafio 'Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética'.`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 5. Termo para Incorporação Patrimonial do Ativo Intangível
* **Objetivo:** Emitir a Nota de Apropriação e o Relatório Contábil de Mensuração para notificar os setores financeiro e patrimonial para tombamento do software no Ativo Não Circulante (Intangível).
* **Estrutura de Prompt:**
  > `"Atue como Mensurador de Software Certificado (CFPS/IFPUG) e Contador Público. Com base na NBC TSP 08, MCASP (9ª ed.), Orientação SOF/TSE nº 15/2022, Lei nº 14.133/2021 e IN TCU nº 84/2020:`  
  > `1. Elabore o Termo para Incorporação Patrimonial do Ativo Intangível e a Nota de Apropriação Contábil do software [Nome do Sistema].`  
  > `2. VALORAÇÃO E APF: Anexe o Extrato da Análise de Pontos de Função (APF/IFPUG) auditado e apresente a memória de cálculo do Valor Justo (Tamanho Funcional em PF x Valor Unitário do PF contratual/mercado) ou Custo Direto de Desenvolvimento para ativação inicial no Ativo Não Circulante.`  
  > `3. GOVERNANÇA PATRIMONIAL E AUDITORIA: Estabeleça orientações para a TI e o Setor Patrimonial quanto aos registros da [Data de início do projeto], [Data de fim do projeto] (marco de início da amortização), [perspectiva de tempo de vida útil] e [taxa de amortização acumulada e depreciação]. Inclua as regras para segregação de custos de manutenção (VPD) e o fluxo formal de notificação para baixa patrimonial por desuso, substituição ou obsolescência (prevenindo apontamentos de auditoria contábil).`  
  > `4. ALINHAMENTO ESTRATÉGICO: Vincule a incorporação ao Macrodesafio 'Aperfeiçoamento da Gestão Orçamentária e Financeira' e formule a função I_patrimonio = f(Macrodesafio, Valor_Ativo_Intangivel, Taxa_Amortizacao_Anual).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

#### 6. Conformidade com a Resolução CNJ nº 335/2020 (PDPJ-Br) e Engenharia de Software
* **Objetivo:** Elaborar o Dossiê de Conformidade Regulatória (PDPJ-Br, LGPD, Segurança) e o Termo de Encerramento do Projeto (TEP) para transferência da solução à equipe de Sustentação.
* **Estrutura de Prompt:**
  > `"Atue como Arquiteto de Software Principal, Engenheiro de Segurança e Gestor do Projeto. Com base na Resolução CNJ nº 335/2020 (PDPJ-Br), Resolução CNJ nº 363/2020 (LGPD), ISO/IEC 25010 e NBR ISO 21502:`  
  > `1. Elabore o Dossiê de Conformidade Regulatória e Qualidade de Software do sistema [Nome do Sistema].`  
  > `2. REQUISITOS DE CONFORMIDADE: Inclua: a) Comprovação de integração ao Barramento do CNJ via APIs e microsserviços; b) Termo de Cessão de Direitos Autorais / Licenciamento Aberto para reuso na PDPJ-Br; c) Relatório de Impacto à Proteção de Dados Pessoais (RIPD/LGPD); d) Relatório de Varredura de Vulnerabilidades (Análise SAST/DAST - OWASP); e e) Termo de Encerramento do Projeto (TEP) consolidando custos, prazos, lições aprendidas e transferência para Sustentação.`  
  > `3. PARÂMETROS TEMPORAIS E DE REVISÃO: Registre no TEP os parâmetros [Data de início do projeto], [Data de fim do projeto], [perspectiva de tempo de vida útil] e a [taxa de amortização acumulada e depreciação] aplicável.`  
  > `4. ALINHAMENTO ESTRATÉGICO: Associe o dossiê ao Macrodesafio 'Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética' e defina a função I_conformidade = f(Macrodesafio, Nivel_Seguranca_OWASP, Aderencia_PDPJ).`  
  > `EXIGÊNCIA DE SAÍDA: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md)."`

---

### 7. Modelo Mestre de Instanciação de Prompt de Conclusão de Projeto (Aprimorado)

Este modelo padronizado deve ser utilizado para acionar o agente de IA na fase final de entrega e incorporação patrimonial do software:

```text
[PAPEL]: Atue como <Inserir Papel de Conclusão: Gestor de Projeto / QA / Arquiteto / PO / Contador Público>
[MARCO REGULATÓRIO E CONTÁBIL]: Lei nº 14.133/2021 (art. 140), Resolução CNJ nº 335/2020 (PDPJ-Br), Resolução CNJ nº 363/2020 (LGPD), NBR ISO/IEC/IEEE 12207, NBR ISO 21502 / PMBOK, NBC TSP 08, MCASP (9ª ed.), Orientação SOF/TSE nº 15/2022 e IN TCU nº 84/2020.
[PARÂMETROS TEMPORAIS E PATRIMONIAIS]:
  - Data de início do projeto: [Data de início do projeto]
  - Data de fim do projeto: [Data de fim do projeto]
  - Perspectiva de tempo de vida útil: [perspectiva de tempo de vida útil]
  - Taxa de amortização acumulada e depreciação: [indicador de depreciação]
[ENQUADRAMENTO ESTRATÉGICO]: Mapeamento no(s) Macrodesafio(s) Institucional(is) <Selecionar Macrodesafio 1 a 13>.
[FUNÇÃO PARAMETRIZÁVEL DE IMPACTO]: I_impacto = f(Macrodesafio, Indicador_Estratégico, Parâmetro_Gestão) para garantir aderência às diretrizes institucionais do Poder Judiciário.
[GOVERNANÇA PATRIMONIAL E AUDITORIA]: Instrução para reconhecimento inicial do Ativo Intangível (evitando subavaliação) e definição de rotinas de notificação para baixa patrimonial por desuso, substituição ou obsolescência técnica.
[CONTEXTO DE ENTRADA]: Projeto/Sistema [Nome da Solução OpenSource / Sistema Interno] / Documento de Formalização da Demanda (DFD).
[ARTEFATO DE CONCLUSÃO REQUISITADO]: <Selecionar um dos 6 itens da fase de conclusão>.
[FORMATO OBRIGATÓRIO DE SAÍDA]: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md).
```
---


```text
[PAPEL]: Atue como <Inserir Papel de Conclusão: Gestor de Projeto / QA / Arquiteto / PO / Contador Público>
[MARCO REGULATÓRIO E CONTÁBIL]: Lei nº 14.133/2021 (art. 140), Resolução CNJ nº 335/2020 (PDPJ-Br), Resolução CNJ nº 363/2020 (LGPD), NBR ISO/IEC/IEEE 12207, NBR ISO 21502 / PMBOK, NBC TSP 08, MCASP (9ª ed.), Orientação SOF/TSE nº 15/2022 e IN TCU nº 84/2020.
[PARÂMETROS TEMPORAIS E PATRIMONIAIS]:
  - Data de início do projeto: [01 de setembro de 2024]
  - Data de fim do projeto: [30 de agosto de 2026]
  - Perspectiva de tempo de vida útil: [10 anos]
  - Taxa de amortização acumulada e depreciação: [20%]
[ENQUADRAMENTO ESTRATÉGICO]: Mapeamento no(s) Macrodesafio(s) Institucional(is) <Selecionar Macrodesafio 1 a 13>.
[FUNÇÃO PARAMETRIZÁVEL DE IMPACTO]: I_impacto = f(Macrodesafio, Indicador_Estratégico, Parâmetro_Gestão) para garantir aderência às diretrizes institucionais do Poder Judiciário.
[GOVERNANÇA PATRIMONIAL E AUDITORIA]: Instrução para reconhecimento inicial do Ativo Intangível (evitando subavaliação) e definição de rotinas de notificação para baixa patrimonial por desuso, substituição ou obsolescência técnica.
[CONTEXTO DE ENTRADA]: Projeto: [Crepúsculo - Gestão de Logística do Pleito Eleitoral].
[FORMATO OBRIGATÓRIO DE SAÍDA]: Crie e exporte a resposta completa e estruturada em um arquivo no formato Markdown (.md).
```
<Contexto_Surge_Crepúsculo>
A Justiça Eleitoral do Acre, vem refinando seus processos de distribuição de urnas e gestão da logística dos pleitos eleitorais.

Desde 2008, busca substituir os processos de distribuição realizados por formulários e planilhas em papel, por recursos sistematizados de forma eletrônica, através de sistemas como NATUMS (Núcleo de Apoio Técnico às Unidade Móveis de Suporte), que se limitava a acompanhar o trajeto dos técnicos em visitação às seções eleitorais durante o dia da eleição, onde o profissional atuava como instrutor e solucionador de problemas de mal funcionamento nas urnas eletrônicas.
Ano a Ano, passo a passo, a equipe identifica necessidades de controle e acompanhamento, visando equacionar a preparação dos materiais, equipamentos e suprimentos, conciliando-os com as equipes que se deslocam para os locais onde as seções devem estar disponíveis para a votação.
Os maiores desafios estão elencados na integração entre os inúmeros sistemas que circundam o pleito, que se originam no fechamento do cadastro eleitoral e culminam na diplimação do candidato eleito.
Sempre em busca de atender plenamento a legislação eleitoral, a equipe da STI tenta se antecipar e equacionar as demandas exigidas na legislação com as atividades administrativas e aquelas que envolvem as auditorias e impossição de cumprimento de metas nacionais.
De forma que o projeto Crepúsculo, em sua forma de funcionamento está alguns passos mais à frente do que já esteve na última eleição, e provavelmente estará muito aquem do que deveria estar para o futuro, sendo uma conquista o atual momento de evolução atingido.

diante de tantos desafios, 

</Contexto_Surge_Crepúsculo>

