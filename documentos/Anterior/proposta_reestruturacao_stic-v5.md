# PROPOSTA DE REESTRUTURAÇÃO ORGANIZACIONAL DA SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO E COMUNICAÇÃO (STIC) DO TRE-AC

## APRESENTAÇÃO DA PROPOSTA

A presente proposta tem por objetivo formalizar a reestruturação organizacional da **Secretaria de Tecnologia da Informação (STI)** do Tribunal Regional Eleitoral do Acre (TRE-AC), promovendo sua transição e elevação para o novo patamar tecnológico sob a designação de **Secretaria de Tecnologia da Informação e Comunicação (STIC)**.

## Histórico evolução do quadro de pessoal
  * Destacar saídas de servidores do quadro permanente de TI
  * Demonstrar a iniciativa das outras unidades quanto ao aumento do quadro de servidores, demanda de reposição e necessidade de adequação à nova realidade
  * Destacar o quanto a STI foi saqueada ao longo do tempo, tendo seus servidores retirados, transferidos e se aposentando e as funções retiradas da estrutura

### OBJETIVOS DA PROPOSTA

* Expandir a contextualização
* Enumerar o quanto a reestruturação trará de benefícios à Instituição

Esta reformulação atende rigorosamente às diretrizes nacionais estabelecidas pelo Conselho Nacional de Justiça (CNJ), em especial a **Resolução CNJ nº 370/2021** (Estratégia Nacional de Tecnologia da Informação e Comunicação do Poder Judiciário – ENTIC-JUD 2021-2026), à **Resolução CNJ nº 468/2022** (Diretrizes para Contratações de STIC no Poder Judiciário), ao **Plano Estratégico Institucional do TRE-AC (Resolução TRE-AC nº 1.763/2021)** e às diretrizes de atualização do **Regimento Interno da Secretaria (Resolução TRE-AC nº 1.808/2025)**.

A reestruturação visa atingir os seguintes objetivos estratégicos:

1. **Adequação Normativa e Designação Atualizada**: Renomear e reestruturar a unidade para **Secretaria de Tecnologia da Informação e Comunicação (STIC)**, refletindo a integração entre infraestrutura tecnológica, governança de dados, cibersegurança e comunicação técnica.  
2. **Redistribuição Funcional por Afinidade de Processos**: Agrupar atribuições por similaridade de execução, eliminando superposições de competências, reduzindo gargalos operacionais e otimizando a força de trabalho disponível.  
3. **Integração Orgânica do Planejamento e Execução Eleitoral**: Absorver integralmente as atribuições da antiga *Assessoria de Gestão Eleitoral (AGEL)* – isolada na Diretoria-Geral – e incorporá-las à nova **Coordenadoria de Gestão da Logística e da Eleição (CGLE)**, integrando a gestão de hardwares eleitorais, suprimentos e sistemas ao ciclo tecnológico do pleito.  
4. **Instituição da Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral**: Criar o órgão colegiado multidisciplinar, presidido pelo(a) Secretário(a) de TIC, encarregado de conduzir de forma contínua o planejamento, a execução e a avaliação dos pleitos oficiais e comunitários na Justiça Eleitoral do Acre.  
5. **Otimização das Unidades de Infraestrutura e Soluções Corporativas**: Estruturar a infraestrutura e a engenharia de software em seções com responsabilidades claras sobre Data Centers, nuvem, rede corporativa, segurança cibernética, desenvolvimento ágil e suporte cartorário.  
6. **Atendimento Integral aos Macroprocessos Mínimos do CNJ**: Incorporar as estruturas exigidas pelo Art. 21 da ENTIC-JUD (Governança, Planejamento de Contratações, Inteligência de Dados, Segurança da Informação, Inovação, Sustentação em Produção e Simulados Eleitorais).  
7. **Integração Orgânica da Inteligência de Dados**: absorver as atribuição de estruração das bases de dados através da fusão de função isoladas no planejamento, objetivando exercutar as funções táticas de contrução do ambiente propício a servir as demais Assistência de planejamento com dados e registros que poderão gerar informações gerenciais, que subsidiarão as decisões da Governança do Tribunal.

 ---

 ## DIAGNÓSTICO DO CENÁRIO TECNOLÓGICO ATUAL

* Expandir a contextualização:

A reestruturação proposta baseia-se na maturidade do ambiente operacional existente no TRE-AC, que atende ao seguinte diagnóstico técnico:

1. **Infraestrutura Física e Lógica Operacional**: A infraestrutura central de servidores corporativos, redes de computadores, virtualização e links de comunicação encontra-se consolidada, testada e homologada em ambiente de produção.  
2. **Padronização e Segurança Operacional**: O parque de servidores atua sobre o sistema operacional **Linux Ubuntu 24 (LTS)** em larga escala, com controle de acesso corporativo centralizado no **Microsoft Active Directory (AD)**, proteção de perímetro via *firewalls* avançados e balanceamento por *HAProxy*. O acesso remoto e o teletrabalho utilizam conexões seguras por VPN com **Múltiplo Fator de Autenticação (MFA/Authelia)**.  
3. **Atendimento Integral ao Quadro Funcional**: O ambiente computacional provê acesso a 100% dos servidores do quadro permanente, magistrados, colaboradores terceirizados, estagiários e requisitados no Estado, abrangendo a Sede, os Cartórios Eleitorais (1ª a 9ª Zonas) e os Postos de Atendimento ao Eleitor (PAEs) em municípios isolados.  
4. **Padronização do Desenvolvimento de Software com IA**: As soluções corporativas internas são desenvolvidas sobre arquitetura padronizada em **PHP, Laravel e banco de dados Oracle**, incorporando suporte a agentes de Inteligência Artificial para otimização de código e automação de rotinas.  
5. **Plano de Modernização do Parque de Computadores Fixos e Workstations (DFD nº 0002394-92.2026.6.01.8000)**: Em cumprimento às diretrizes da Presidência do TRE-AC, a STIC formulou a contratação de **127 equipamentos computacionais de alta performance** (120 desktops Dell Pro Slim Core Ultra i5 e 07 Workstations Dell Pro Max Core Ultra i7 com placas NVIDIA RTX A1000 de 8GB), destinados a suportar ambientes críticos como auditoria de urnas, geração de mídias, laboratório de inovação (NULAB), desenvolvimento de sistemas, projetos de engenharia predial (BIM/Revit/AutoCAD) e cartórios eleitorais.  
6. **Expectativa de Alta Capacidade Computacional e Mobilidade**: Os postos fixos e móveis demandam poder de processamento para conteinerização (Docker, Kubernetes), ambientes Linux (WSL2), inteligência de dados (Power BI, Oracle, PostgreSQL), monitoramento em tempo real (Zabbix, GLPI) e atuação da Equipe de Tratamento e Resposta a Incidentes Cibernéticos (ETIR).  
 7. Ressaltar a dispersão de atividades de outras unidades, como um analista de sistemas da área de TI lotado na ASPLAN, objetivando criar paineis informativos, em dissonância com a falta de acesso às bases e infraestrutura disponível na STI

 ---

 ## NOVA ESTRUTURA ORGANIZACIONAL CODIFICADA DA STIC

* considerar a estrutura a seguir como base da apresentação

A arquitetura corporativa da **STIC** é codificada conforme a seguinte árvore hierárquica oficial:

```
1. 1. Secretaria de Tecnologia da Informação e Comunicação (STIC)  (CJ3)  
2.    1.01 Gabinete da STIC (GSTIC)  (FC5)  
3.    1.02 Núcleo de Planejamento e Governança de TIC (NPGTIC)  (FC6)  
4.     	1.021 Assistência de Planejamento e de Contratação (NPGTIC)  (FC5)  
5.    1.03 Assessoria de Inteligência de Dados (ASID)  (CJ1)  
6.     	1.031 Assistência de Engenharia de Dados (ASID)  (FC6)  
7.    1.2 Coordenadoria de Infraestrutura (CIE)  (CJ2)  
8.      1.21 Seção de Segurança Cibernética (SSEC)  (FC6)  
9.      1.22 Seção de Redes (SEREDE)  (FC6)  
10.       1.221 Assistência Seção de Redes (SEREDE)  (FC5)  
11.     1.23 Seção de Suporte aos Usuários (SSU)  (FC6)  
12.       1.231 Assistência Seção de Suporte aos Usuários (SSU)  (FC5)  
13.   1.3 Coordenadoria de Sistemas Corporativos (CSCOR)  (CJ2)  
14.     1.31 Seção de Desenvolvimento de Sistemas (SDSIS)  (FC6)  
15.       1.331 Assistência Seção de Desenvolvimento de Sistemas (SDSIS)  (FC5)  
16.     1.32 Seção de Gestão e Sustentação de Sistemas (SGSIS)  (FC6)  
17.       1.321 Assistência Seção de Gestão e Sustentação de Sistemas (SGSIS)  (FC5)  
18.     1.33 Seção de Administração de Banco de Dados (SABD)  (FC6)  
19.       1.331 Assistência Seção de Administração de Banco de Dados (SABD)  (FC5)  
20.   1.4 Coordenadoria de Operação Logística e Gestão da Eleição (CGLE)  (CJ2)  
21.      1.41 Seção de Logística de Materiais, equipamentos e Urnas Eletrônicas (SLMEUE)  (FC6) 
22.      1.42 Seção de Sistemas Eleitorais de Urnas (SSEUE)  (FC6)  
23.   
24. * Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral (Órgão Colegiado) (CPPGPE)  

Unidade a serem fundidas à STIC: Origem AGEL e ASPLAN
Comissionamento a unidade a ser adicionada
1. 1. Assessoria de Gestão Eleitoral (AGEL)  (CJ3)  
2.  1.1 Assessoria I da Assessoria de Gestão Eleitoral (AGEL)  (CJ1)
3. 1 Assessoria I da Assessoria de Planejamento Institucional (ASPLAN)  (CJ1)

```

---

## MAPEAMENTO DETALHADO DAS ATRIBUIÇÕES DE CADA UNIDADES E SUBUNIDADES

* Detalhar as características: Função Principal, Vínculo e Cargo e Atribuições
* Ao final, criar o demonstrativo de benefícios a serem criados à outras unidades que demandam e dependem do serviço da STI
* De acordo com as normas de engenharia da computação voltados a infraestrutura, manutenção, desenvolvimento de softwares e logística, complementar e compatibilizar as atribuições das unidades

### 1. Secretaria de Tecnologia da Informação e Comunicação (STIC)  (CJ3)

* **Função Principal**: Unidade de direção superior responsável por planejar, organizar, dirigir e supervisionar as atividades de TIC, logística eleitoral, infraestrutura, segurança da informação e governança. Precipuamente, o Secretário(a) exerce a Presidência da Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral.  
* **Vínculo e Cargo**: Dirigida por Secretário(a), titular de Cargo em Comissão (CJ3).  
* **Atribuições**:  
  * Dirigir a execução da ENTIC-JUD no âmbito do TRE-AC, em alinhamento com a Resolução CNJ nº 370/2021, Resolução CNJ nº 468/2022 e diretrizes do TSE.  
  * Submeter ao Comitê de Governança de TIC e à Administração Superior o Plano Diretor de TIC (PDTIC), o Plano Anual de Contratações de TIC (PAC-TIC) e o Plano de Continuidade de Serviços.  
  * Supervisionar a integração do planejamento eleitoral, coordenando a recepção do voto informatizado, totalização e transmissão de resultados em tempo real.  
  * Presidir e conduzir os trabalhos da Comissão Permanente de Planejamento e Gestão do Pleito Eleitoral.
* criar um regimento interno com as funcionalidades essenciais a serem desenvolvidas pela "COMISSÃO PERMANENTE DE PLANEJAMENTO E GESTÃO DO PLEITO ELEITORAL"

---

### 1.01 Gabinete da STIC (GSTIC)  (FC5)

* **Função Principal**: Suporte administrativo, operacional, documental e de representação institucional da Secretaria.  
* **Vínculo**: Subordinado ao Secretário(a), sob condução de servidor(a) titular de Função Comissionada (FC5).  
* **Atribuições**:  
  * Gerir o expediente, a agenda institucional, o fluxo de processos administrativos do SEI e as comunicações internas e externas da Secretaria.  
  * Elaborar minutas de portarias, ordens de serviço, relatórios de gestão e memórias de reunião.  
  * Realizar a interlocução de comunicação interna entre as Coordenadorias subordinadas, a Diretoria-Geral e a Presidência.

---

### 1.02 Núcleo de Planejamento e Governança de TIC (NPGTIC)  (FC6)

* **Função Principal**: Gestão tática do alinhamento estratégico, governança, gestão de riscos, métricas (OKRs e iGovTIC-JUD) e planejamento central das contratações de TIC.  
* **Vínculo**: Vinculado diretamente à Secretaria, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Implementar e monitorar a aplicação do PDTIC, dos OKRs de TIC e do indicador iGovTIC-JUD do CNJ.  
  * Mapear e formalizar os processos de trabalho da STIC, mantendo a base de conhecimento e o catálogo de serviços atualizados.  
  * Coordenar a Gestão de Riscos de TIC e a Continuidade de Negócios da área tecnológica.

#### 1.021 Assistência de Planejamento e de Contratação (NPGTIC)  (FC5)

* **Função Principal**: Execução tática e instrução operacional das contratações de TIC.  
* **Vínculo**: Vinculado diretamente a unidade NPGTIC, sob condução de servidor(a) em Função Comissionada (FC5).
* **Atribuições**:  
  * Consolidar e gerir o Plano Anual de Contratações de TIC (PAC-TIC).  
  * Apoiar as equipes no planejamento da elaboração de Estudos Técnicos Preliminares (ETP), Termos de Referência (TR) e Análises de Riscos das contratações.  
  * Monitorar a fase preparatória, o cumprimento de prazos editalícios e a execução orçamentária dos contratos de TIC.

---

### 1.03 Assessoria de Inteligência de Dados (AIDTIC)  (CJ1)
A AIDTIC é construída à partir da fusão da Função Comissionada que hoje está ligada a ASPLAN. Objetiva lotar o servidor Analista de sistemas que está deslocado para dentro da área técnica, onde exercitará as funções táticas de contrução do ambiente propício a servir as demais Assistência de planejamento com dados e registros que poderão gerar informações gerenciais, que subsidiarão as decisões da Governança do Tribunal.
* **Função Principal**: Assessorar a Secretaria de Tecnologia da Informação e as unidades do Tribunal no uso estratégico de dados, mediante análises, soluções de inteligência de negócios, indicadores, estudos estatísticos e produtos analíticos que subsidiem a tomada de decisões e o aprimoramento da gestão institucional. Gestão de dados institucionais, engenharia de dados, desenvolvimento de painéis em Business Intelligence (BI), ciência de dados e apoio à tomada de decisão da Alta Gestão.  
* **Vínculo**: Vinculada diretamente à Secretaria, sob condução de servidor(a) titular de Cargo em Comissão (CJ1).  
* **Atribuições**:  
  * Projetar, construir e manter painéis e dashboards gerenciais em BI para monitoramento de indicadores de desempenho do Tribunal, das Zonas Eleitorais e das eleições.  
  * Implementar políticas de governança de dados, qualidade de dados e interoperabilidade, atendendo aos requisitos do CNJ (DataJud) e da LGPD.  
  * Realizar análise preditiva e estatística de dados eleitorais e administrativos para subsidiar decisões estratégicas da Corte.  
  * I – coordenar iniciativas de inteligência de dados e *Business Intelligence* (BI), promovendo o uso estratégico de informações para o aprimoramento da gestão do Tribunal;  
  * II – desenvolver e manter painéis, *dashboards*, indicadores, relatórios e demais soluções analíticas para o monitoramento do desempenho do Tribunal, das Zonas Eleitorais e dos processos eleitorais;  
  * III – realizar estudos estatísticos, análises preditivas e outras técnicas de análise de dados eleitorais e administrativos, visando identificar tendências, padrões, riscos e oportunidades de melhoria;  
  * IV – propor e apoiar a definição de indicadores, métricas, conceitos e modelos analíticos destinados ao acompanhamento de resultados e ao suporte à tomada de decisão estratégica;  
  * V – assessorar a Administração e as unidades do Tribunal em iniciativas relacionadas à inteligência de dados, disseminando metodologias, boas práticas e cultura orientada por dados.   

### 1.031 Assistência de Engenharia de Dados (AIDTIC)  (FC6)

* **Função Principal**: Executar atividades técnicas de engenharia de dados destinadas à integração, extração, ingestão, transformação, validação, organização e disponibilização de dados provenientes de sistemas e outras fontes institucionais, assegurando sua qualidade técnica, rastreabilidade, segurança e disponibilidade para utilização analítica.  
* **Vínculo**: Vinculado diretamente a unidade AIDTIC, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * I – projetar, implementar e manter processos de integração, extração, transformação, carga e disponibilização de dados provenientes dos sistemas e demais fontes institucionais;  
  * II – estruturar e manter repositórios, modelos e arquiteturas de dados destinados a suportar soluções analíticas, de BI e de inteligência de dados;  
  * III – implementar mecanismos de tratamento, padronização, validação e monitoramento da qualidade, integridade e consistência dos dados;  
  * IV – apoiar tecnicamente a implementação de padrões de interoperabilidade, governança, segurança, proteção de dados e compartilhamento de informações, inclusive aqueles decorrentes de determinações de órgãos de controle e do CNJ;  
  * V – manter processos de documentação, catalogação, metadados e rastreabilidade dos dados, assegurando sua disponibilidade e confiabilidade para utilização analítica;  
  * VI – prover suporte técnico às soluções de inteligência de dados, estudos estatísticos, painéis e demais produtos analíticos desenvolvidos pela Assessoria.

---

### 1.2 Coordenadoria de Infraestrutura (CIE) (CJ2)
* **Função Principal**: Gestão, coordenação e sustentação da infraestrutura física e lógica, serviços de rede, Data Centers, segurança cibernética, engenharia de hardware e atendimento de suporte.  
* **Vínculo**: Dirigida por Coordenador(a), titular de Cargo em Comissão (CJ2).  
* **Unidades Subordinadas**:

#### 1.21 Seção de Segurança Cibernética (SSEC)  (FC6)  
* **Vínculo**: Vinculado diretamente a unidade CIE, sob condução de servidor(a) em Função Comissionada (FC6).  
* **Atribuições**:  
  * Implementar a Política de Segurança da Informação (PSI), controle de acessos lógicos, gestão de identidades e auditoria de vulnerabilidades.  
  * Operar os mecanismos de cibersegurança (firewalls, IDS/IPS, antimalware, proteção de nuvem, VPN/Authelia) e gerenciar a Equipe de Tratamento e Resposta a Incidentes Cibernéticos (ETIR).  
  * Fomentar e testar soluções tecnológicas inovadoras em parceria com o NULAB e redes de inovação do Poder Judiciário.

#### 1.22 Seção de Redes (SEREDE)  (FC6)  + 1.221 Assistência Seção de Redes (SEREDE)  (FC5)  
* **Vínculo**: Vinculado diretamente a unidade CIE, sob condução de servidor(a) em Função Comissionada (FC6).  
* **Atribuições**:  
  * Administrar os centros de processamento de dados (Data Centers principal e redundante), servidores físicos/virtuais (Ubuntu 24, HAProxy), hipervisores e ambientes em nuvem.  
  * Gerir os serviços corporativos de rede (DNS, DHCP, Active Directory, e-mail institucional, sistemas de arquivos) e a infraestrutura de backup e disaster recovery.  
  * Gerenciar o parque de microinformática, nobreaks, ativos de rede, emitindo laudos técnicos, aceites e controle de obsolescência e garantia.

#### 1.23 Seção de Suporte aos Usuários (SSU)  (FC6)  + 1.231 Assistência Seção de Suporte aos Usuários (SSU)  (FC5)  
* **Vínculo**: Vinculado diretamente a unidade CIE, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Operar a Central de Serviços (Helpdesk Nível 1 e Nível 2) para atendimento a servidores, magistrados, colaboradores e cartórios eleitorais.  
  * Garantir o cumprimento dos prazos de atendimento (SLA) e manter atualizada a base de conhecimento de soluções.  
  * Avaliar a satisfação dos usuários e prover suporte técnico presencial e remoto aos Cartórios Eleitorais do interior e aos PAEs.

---

### 1.3 Coordenadoria de Sistemas Corporativos (CSCOR)

* **Função Principal**: Engenharia, desenvolvimento, manutenção, sustentação, administração de bancos de dados e garantia de disponibilidade das soluções tecnológicas do Tribunal.  
* **Vínculo**: Dirigida por Coordenador(a), titular de Cargo em Comissão (CJ2).  
* **Unidades Subordinadas**:

#### 1.31 Seção de Desenvolvimento de Sistemas (SDSIS)  (FC6)  + 1.331 Assistência Seção de Desenvolvimento de Sistemas (SDSIS)  (FC5)  
* **Vínculo**: Vinculado diretamente a unidade CSCOR, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Projetar, construir e codificar novos sistemas e aplicações corporativas em linguagem padronizada (PHP, Laravel, Oracle), adotando suporte de agentes de Inteligência Artificial.  
  * Garantir a acessibilidade (eMAG), portabilidade, responsividade e segurança desde a concepção (Security by Design).  
  * Adotar metodologias ágeis de desenvolvimento, controle de versão (GitLab) e documentação técnica.

#### 1.32 Seção de Gestão e Sustentação de Sistemas (SGSIS)  (FC6)  + 1.321 Assistência Seção de Gestão e Sustentação de Sistemas (SGSIS)  (FC5)  
* **Vínculo**: Vinculado diretamente a unidade CSCOR, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Prestar manutenção evolutiva, corretiva e adaptativa nos sistemas corporativos em uso no Tribunal.  
  * Avaliar, adaptar, homologar e integrar soluções de software desenvolvidas por outros Tribunais ou pelo TSE antes da implantação local.  
  * Gerenciar a interoperabilidade e integração de sistemas internos com as plataformas nacionais do CNJ (DataJud, PJe) e TSE.

#### 1.33 Seção de Administração de Banco de Dados (SABD)  (FC6)  + 1.331 Assistência Seção de Administração de Banco de Dados (SABD)  (FC5)  
* **Vínculo**: Vinculado diretamente a unidade CSCOR, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Administrar, otimizar (tuning) e monitorar os Sistemas Gerenciadores de Bancos de Dados (Oracle, PostgreSQL) do Tribunal.  
  * Executar rotinas de extração, transformação e carga (ETL), garantindo a integridade dos dados e o suporte à Assessoria de Inteligência de Dados.  
  * Gerir o ambiente de produção e homologação (CI/CD, Docker, Kubernetes), monitorando em tempo real a disponibilidade, performance e tempo de resposta das aplicações.

---

### 1.4 Coordenadoria de Operação Logística e Gestão da Eleição (CGLE)  (CJ2)  

* **Função Principal**: Unidade especializada no planejamento operacional, logística, simulados, manutenção de equipamentos e condução dos sistemas de votação informatizada.  
* **Integração Absoluta da AGEL**: Absorve integralmente as atribuições da antiga Assessoria de Gestão Eleitoral (Art. 40 da Res. 1.808/2025), eliminando o isolamento administrativo e unificando o planejamento ao suporte tecnológico direto.  
* **Vínculo**: Dirigida por Coordenador(a), titular de Cargo em Comissão (CJ2).  
* **Unidades Subordinadas**:

#### 1.41 Seção de Logística de Materiais, equipamentos e Urnas Eletrônicas (SLMEUE)  (FC6)  
* **Vínculo**: Vinculado diretamente a unidade CGLE, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Planejar, gerenciar e executar a logística de suprimentos, materiais e equipamentos de microinformática e urns eletrônicas.   
  * Coordenar em parceria com a COSEG/SETRAN a distribuição, transporte, armazenamento seguro e recolhimento das urnas e insumos antes e após o pleito.  
  * Elaborar tabelas de distribuição, controle de estoque, roteirização logística e dimensionamento físico para eleições oficiais e comunitárias.

#### 1.42 Seção de Sistemas Eleitorais de Urnas (SSEUE)  (FC6)  
* **Vínculo**: Vinculado diretamente a unidade CGLE, sob condução de servidor(a) em Função Comissionada (FC6).
* **Atribuições**:  
  * Realizar as revisões periódicas, testes de mesa, manutenções preventivas e corretivas do parque de urnas eletrônicas (modelos UE) e periféricos.  
  * Organizar e executar os **Simulados de Eleição, Testes de Carga, Testes de Confirmação, Teste de Autenticidade e Teste de Integridade (Votação Paralela)**.  
  * Operar as rotinas de geração de mídias de carga e votação, inseminação, lacre e auditoria física e eletrônica das urnas. 
  * Operacionalizar, homologar e prestar suporte aos sistemas de eleição fornecidos pelo TSE (CAND, Horário Eleitoral, Totalização, Transmissão, Diplomação, Justifica, Oficialização).  
  * Capacitar servidores dos Cartórios Eleitorais, juízes eleitorais e membros das Juntas Apuradoras na utilização das soluções e redes de transmissão.  
  * Executar os planos de transmissão de dados de votação e divulgação dos resultados em tempo real no dia do pleito.

---

### COMISSÃO PERMANENTE DE PLANEJAMENTO E GESTÃO DO PLEITO ELEITORAL

Missão: Fazer cumprir a legislação eleitoral, Resolução TSE nº 23.751/2026, e demais normativos que envolvem o pleito eleitoral, seja eleição oficial ou comunitária.

* **Natureza**: Órgão colegiado multidisciplinar de caráter permanente, responsável pela coordenação, direção, execução e avaliação continuada das eleições oficiais e não-oficiais (comunitárias) no Estado do Acre.  

* **Presidência**: Presidida pelo(a) **Secretário(a) de Tecnologia da Informação e Comunicação**.  
* **Composição de Membros**:  
  * **Secretaria de Tecnologia da Informação e Comunicação (STIC)**: 02 (duas) vagas (incluindo o Presidente);  
  * **Coordenadoria de Gestão da Logística e da Eleição (CGLE)**: 01 (uma) vaga;  
  * **Assessoria de Planejamento Institucional (ASPLAN)**: 01 (uma) vaga;  
  * **Secretaria de Administração, Orçamento e Finanças (SAOF)**: 02 (duas) vagas;  
  * **Coordenadoria de Gestão de Pessoas (COGEP)**: 01 (uma) vaga;  
  * **Juízos e Cartórios das Zonas Eleitorais**: 02 (duas) vagas (representando Capital e Interior);  
  * **Corregedoria Regional Eleitoral (CRE)**: 01 (uma) vaga;  
  * **Secretaria Judiciária (SEJUD)**: 02 (duas) vagas.  
* **Membro Consultor**:  
  * **Juiz Auxiliar indicado pela Presidência do TRE-AC**, com a anuência da Corregedoria Regional Eleitoral (01 vaga).  
* **Atribuições Principais**:  
  * Mapear e cumprir os regramentos legais e resoluções emitidas pelo TSE para cada pleito.  
  * Implementar o Cronograma Geral de Operações das Eleições, traçando metas, prazos, requisições de transporte, pessoal e contratações de apoio.  
  * Providenciar convênios, requisições de veículos, alocação de prédios públicos e locais de votação.  
  * Consolidar os relatórios finais do pleito, identificando pontos de melhoria, gargalos e propondo inovações tecnológicas e organizacionais para os pleitos futuros.  

  * **Competência do Juiz Consultor**: Produzir os atos normativos, decisões judiciais e interlocuções institucionais necessários à plena execução do pleito que extrapoladores a alçada administrativa da Comissão.  

---

# Histórico de reestruturação

* Regimento Interno da Secretaria - Resolução TRE-AC nº 1.215/2007  
https://www.justicaeleitoral.jus.br/++theme++justica_eleitoral/pdfjs/web/viewer.html?file=https://www.justicaeleitoral.jus.br/arquivos/tre-ac-regimento-interno-da-secretaria-2016/@@download/file/TRE-AC-Regimento-Tribunal-alterado-Res-1324-1646-1676-1682-1690-1704.pdf  

---

* Alteração Regimento Interno da Secretaria - Resolução TRE-AC nº 1.646/2011  
https://www.justicaeleitoral.jus.br/++theme++justica_eleitoral/pdfjs/web/viewer.html?file=https://www.justicaeleitoral.jus.br/arquivos/tre-ac-resolucao-n.-1646-2011/@@download/file/TRE-AC-2011-01-resolucao-1646.pdf  

---

* Regimento Interno da Secretaria - Resolução TRE/AC n. 1.808/2025  
https://www.tre-ac.jus.br/legislacao/arquivos-resolucoes-do-tre-ac/tre-ac-resolucao-1808-2025-regimento-interno-da-secretaria/@@display-file/file/tre-ac-resolucao-1808-2025-regimento-interno-da-secretaria.pdf  

---

* Cria cargos efetivos, cargos em comissão e funções comissionadas no quadro de pessoal do Tribunal Superior Eleitoral e dos Tribunais Regionais Eleitorais. https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2026/lei/l15374.htm

---

## Contextualização da proposta

Trazer para a formulação da proposta:

* Trazer Mapa estatístico comparativo dos Regimentos internos da Secretarias de Tecnologia da Informação do Acre com os outros Tribunais Regionais Eleitorais (TRE-AC): TSE, Acre (TRE-AC), Amapá (TRE-AP), Amazonas (TRE-AM), Pará (TRE-PA), Rondônia (TRE-RO), Roraima (TRE-RR), Tocantins (TRE-TO), Alagoas (TRE-AL), Bahia (TRE-BA), Ceará (TRE-CE), Maranhão (TRE-MA), Paraíba (TRE-PB), Pernambuco (TRE-PE), Piauí (TRE-PI), Rio Grande do Norte (TRE-RN), Sergipe (TRE-SE), Distrito Federal (TRE-DF), Goiás (TRE-GO), Mato Grosso (TRE-MT), Mato Grosso do Sul (TRE-MS), Espírito Santo (TRE-ES), Minas Gerais (TRE-MG), Rio de Janeiro (TRE-RJ), São Paulo (TRE-SP), Paraná (TRE-PR), Rio Grande do Sul (TRE-RS), Santa Catarina (TRE-SC);  

* Trazer o quanto a inovação da estrutura avança na direção da modernidade e otimização na busca de melhorias funcionais da TIC e quanto poderá inspirar os demais Regionais;

* Abordar a nova perspectiva criada pela LEI Nº 15.374, DE 2 DE ABRIL DE 2026, que Cria cargos efetivos, cargos em comissão e funções comissionadas no quadro de pessoal do Tribunal Superior Eleitoral e dos Tribunais Regionais Eleitorais;

* Abordar a iniciativa das demais unidades do Tribunal, quanto as suas propostas de reestruturações, em processo já em andamento;
  * trazer os Parâmetros de Eficiência e Força de Trabalho enfatizando a disponibilidade de níveis proporcionais;

* Trazer a atual estrutura do organograma do TRE-AC
  * considerar que será possível incorporar a unidade AGEU à furura unidade "Coordenadoria de Gestão da Logística e da Eleição (CGLE)" criada na STIC;
  * considerar a distribuição de funções do link: https://www.tre-ac.jus.br/transparencia-e-prestacao-de-contas/gestao-de-pessoas/cargos-em-comissao-e-funcoes-de-confianca-agosto-2026 , para adequá-la e dar viabilidade à nova proposta;
  * Demonstrar a fusão das unidades STI + AGEU;
    - compatibilizar as funções e comissionamentos na integração para a nova proposta;
    - trazer a memória de cálculo, para demonstrar a utilização de CJ de origem da AGEU e a criação de FC para a novas unidades criadas;
  * considerar a Reserva Legal e Limites de Criação por Lei Federal;
  * considerar o Modelo de Correlação Orçamentária (Custo x Quantitativo);
  * considerar as Diretrizes de Distribuição Interna e Lotação (Resolução CNJ nº 219/2016);
  * 
* Trazer o arcabouço legal que fundamenta o cálculo, re-cálculo e re-distribuição dos Cargos em Comissão (CJ) e Funções Comissionadas (FC)
  - demonstrar o modelo de cáuculo que cria o valor atribuído a cada CJ e FC;
  - dimensionar, em valores, os valores totais de comissionamentos da atual estrutura e a aplicada a nova proposta;
  - demonstrar o quadro comparativo com a adição de cargos e comissionamentos da Lei 15.374;
* Obter o método de cálculo fundamentando a transformação de valores de Funções e Comissionametos
  - O objetivo é ter o maior número possível de CJ1, FC6 
  - Considerar o menor percentual de sobras na divisão e proporcionalidades alcançadas na divisão
    - demonstrar em quadros comparativos a memória de cáculo da transformação das funções
    - considerar o valor atribuído à FC: Função de Confiança (ou Função Comissionada) de: FC1, FC2, FC3, FC4, FC5 e FC6
    - considerar o valor atribuído à CJ: CJ: Cargo em Comissão (ou Cargo Judiciário em comissão) de: CJ1, CJ2, CJ3 e CJ4
    - considerar que existe um limite de criação destas CJ e FC
    - considerar que, dentro dos limites, são possíveis de serem criadas um número de CJ
    - considerar que, dentro dos limites, são possíveis de serem criadas um número de FC
    - considerar a possibilidade de converter CJ de acordo com seus valores em maior número quantitativo de FC
    - demonstrar quantidades de CJ possível e maximizar a quantidade de CJ1 dentro dos intervalos de valores disponíveis
      - considerar que são exigências: 
        - 1 (uma) CJ4 - A ser atribuída ao Diretor(a)-Geral
        - 4 (quatro) CJ4 - A serem atribuídas aos secretários: de TI, de SAOF, de SEJUD e SGP
        - Cj2 - A serem atribuídas aos Coordenadores
        - CJ1 - Tantas quantas forem possíveis de serem criadas dentro dos limites impostos 

# Construção da Proposta

* Elaborar o documento com riqueza de detalhes;
* Não resumir;
* Construir a apresenação da proposta com Fundamentação a partir do estudo e Contextualização Destas orientações, base legal, regimentos e procedimentos SEI elencados abaixo
* Criar a APRESENTAÇÃO DA PROPOSTA
  * arguir com riqueza de detalhes, sejam normativos, sobrecarga de atividades, atribuição de responsabilidades empregadas na atual estrutura;
  * arguir o atendimento às exigências CNJ, dentre os outros dispositivos legais, que devem elevar a pontuação junto ao CNJ;
* Descrever OBJETIVOS DA PROPOSTA
* trazer o DIAGNÓSTICO DO CENÁRIO TECNOLÓGICO ATUAL
  * Ressaltar a dispersão de funcionalidades 
  * Ressaltar a dispersão de servidores da TI
* Demonstrar a NOVA ESTRUTURA ORGANIZACIONAL CODIFICADA DA STIC
  * Ressaltar a importância de aglutinar as atividades em ambiente próprio para fluidez das entregas
  * Ressaltar a importância de alocar servidores nas novas unidades
* Detalhar o MAPEAMENTO DETALHADO E ATRIBUIÇÕES DAS UNIDADES E SUBUNIDADES
  * Enriquecer com tópicos: Função Principal; Vínculo; Atribuições
* Detalhar Atribuições e Funções Comissionadas vinculadas às unidades
  * Incluir a importância da lotação de servidores aliada às funções comussionadas
* Detalhar as atividades e Responsabilidades da COMISSÃO PERMANENTE DE PLANEJAMENTO E GESTÃO DO PLEITO ELEITORAL
  * Vincular as atividades à Resolução TSE de execução do pleito eleitoral 
* Inlcuir na documentação a seção de referências e Histórico de reestruturação

---

# Saída:   
- solicite a permissão para criar o próximo documento;
- criar o documento formal de abertura do processo administrativo num arquivo "Termo Inicial";  
- criar o documento formal com a Contextualização, Fundamentação e Justificativa da proposta;  
- criar o documento formal com a argumentação de convencimento para a adoção da proposta;  
- ao final, criar um prompt que ao ser executado produza os mesmos arquivos de saída, com exatamente os resultados;
- criar os arquivos no formato markdown   

---

<0000692-19.2023.6.01.8000>

### Processos SEI anteriores à proposta

PROCESSO:  0000692-19.2023.6.01.8000  
INTERESSADO:  GAPRES  
ASSUNTO:  Proposta de Reestruturação   

Despacho nº 0579084 / 2023 - PRESI/DG/GADG  
Trata-se de proposta de reestruturação da Secretaria do Tribunal Regional Eleitoral do Acre com vistas à melhoria dos processos internos, tal como previsto no Planejamento Estratégico deste Tribunal, buscando o aperfeiçoamento da gestão administrativa e governança institucional.  
A proposta é firmada na possibilidade jurídica e orçamentária prevista na Resolução TSE nº 23.698/2022, que alterou sua estrutura orgânica, com transformação de cargos em comissão, autorizando, igualmente, o aproveitamento pelos regionais do saldo de 35% advindos do valor integral do cargo em comissão, desde que não haja aumento de despesas.  
Desta feita, apresenta-se as justificativas e proposta de organograma contemplando as criações, mudanças e ransformações que se apresentam possíveis dentro do limite orçamentário e convenientes para o alcance das metas estratégicas e da arantia da prestação jurisdicional.  

1. CRIAÇÃO DA ASSESSORIA DE GESTÃO ELEITORAL - AGEL  

Em 1996, com o surgimento da urna eletrônica nas eleições, os tribunais regionais eleitorais viabilizaram o provimento de vários cargos técnicos na área de tecnologia, com vistas à prestação de suporte técnico nas eleições.  
Desde então, informalmente, a área de tecnologia passou a absorver as atividades de preparação das eleições e a concentrar grande parte do processo, haja vista que o sistema eletrônico de votação exigia, e ainda exige em algumas atividades, conhecimentos técnicos específicos.  
De se mencionar, também, a implementação de novas tecnologias voltadas ao aprimoramento das eleições, o que ocorre de forma contínua.  
Referidas atividades, contudo, não se encontram previstas integralmente nos regimentos internos da maioria dos tribunais eleitorais, dos quais não constam as atribuições e responsabilidades afetas ao processo eleitoral, tampouco a quais unidades incumbem, valendo-se de nomeação de comissões para a gestão de projetos críticos.  
Junte-se a isso a evolução do eleitorado do Acre, que trouxe maior complexidade para a logística das eleições, sobretudo pela criação de seções eleitorais muito distantes das sedes das zonas (locais de difícil acesso), que demandam estrutura tecnológica, de transporte, de pessoal e de treinamentos aquém da capacidade de planejamento e execução dos cartórios eleitorais, que, no caso do TRE-AC, contam com quadro de pessoal por vezes composto de servidores requisitados, e insuficiente até mesmo para a realização das atividades cotidianas.  
Diante da reconhecida complexidade dos pleitos eleitorais, é comum e necessário que os tribunais iniciem o planejamento de eleições já no ano anterior à realização, praticamente logo após o encerramento de um ano eleitoral. Tal planejamento viabiliza, dentre outras providências imprescindíveis, as contratações necessárias à execução das ações voltadas às eleições.  
Ocorre que, muitas dessas atividades sem unidades formalmente responsáveis são hoje planejadas e gerenciadas por comissões e grupos de trabalho, com formação multidisciplinar somente no ano da eleição, como solução para o preenchimento das lacunas regimentais já mencionadas.  
Com o decorrer do tempo, algumas atividades outrora realizadas pela área de tecnologia foram direcionadas para unidades específicas do tribunal, com ganho significativo na gestão, como é o caso da administração do cadastro eleitoral, atualmente sob a responsabilidade da; o registro de candidaturas, antes executado em sua integralidade pela área de tecnologia, foi assumido pela Secretaria Judiciária, com efeitos positivos na gestão desse processo, que demanda mais conhecimentos jurídicos que de tecnologia.  
Atualmente, ainda se observa grande sobrecarga de atividades afetas às eleições sobre a área de tecnologia, que, além de planejar ações, elaborar proposta orçamentária das demandas técnicas, gerenciar a execução, também propõe normatização, afastando, inclusive, a boa prática da segregação de funções para processos complexos e que exigem alto nível de segurança e eficiência.  Muitas dessas atividades sequer envolvem uso de conhecimentos técnicos, sistemas de computação ou equipamentos, porém, em razão do costume, da falta de designação de unidade responsável e da precariedade de estrutura de pessoal dos cartórios e regionais, ainda estão sob a responsabilidade da área de tecnologia.  
Nesse contexto, com vistas a garantir maior eficiência nos processos relacionados às eleições, alguns regionais (TRE-SC, TRE-BA, TRE-MT, TRE-MA, TRE-PB) e o próprio TSE estão promovendo a reestruturação de seus organogramas, com o propósito de criar unidades responsáveis pela gestão eleitoral, subordinadas diretamente à Presidência ou à Diretoria-Geral, assessorando a alta gestão na elaboração de propostas de normatização, regulamentação e definição de estratégias de atuação eficientes.  
No âmbito do TRE-AC, a proposta que se apresenta é a de criação de uma unidade concentradora de assuntos eleitorais, no que tange ao planejamento das ações voltadas às eleições, proposições inovadoras e de regulamentação, tanto das atividades sob a responsabilidade do Tribunal como de apoio aos cartórios eleitorais, além de manter a integração com os demais regionais e o TSE nas questões relacionadas às eleições, com subordinação direta à Diretoria-Geral do Tribunal.  
Assim, a Direção-Geral do TRE-AC contará com uma assessoria dedicada exclusivamente ao processo eleitoral, dissociando-o do planejamento estratégico institucional, que continuará sob a responsabilidade da Assessoria de Planejamento, Estratégia e Gestão– ASPLAN.  
Além disso, tornar-se-á desnecessária a constituição de várias comissões e grupos de trabalho, que sobrecarregam as demais unidades do Tribunal, principalmente a Secretaria de Tecnologia, a qual poderá dedicar-se ao atendimento das demandas de ordem técnica, como segurança da informação, infraestrutura e desenvolvimento de soluções tecnológicas, preparação dos recursos tecnológicos necessários à execução das atividades das eleições demandadas pelas unidades responsáveis e cartórios eleitorais, dentre outras.  
Sugere-se, portanto, que a nova estrutura conte com um Assessor CJ3 e um Assessor CJ1, para suprir a estrutura mínima necessária, diante das atribuições propostas para a unidade, e, ainda, para que se guarde alinhamento aos Regionais e ao TSE, que já contam com essa estrutura, à medida que cria estrutura similar à existente na Direção-Geral do TSE (Organograma — Tribunal Superior Eleitoral (tse.jus.br)).  
Serão atribuições da Assessoria de Gestão Eleitoral (AGEL) assessorar a Diretoria-Geral no planejamento, monitoramento e gestão do processo eleitoral, no âmbito do Estado do Acre, acompanhar a execução do planejamento das eleições, visando garantir o cumprimento da legislação eleitoral e normativos do TRE-AC, além de:  
I – Gerenciar a elaboração do Plano Integrado das Eleições, auxiliando os gerentes de processo no planejamento e execução das atividades;  
II - Assessorar a elaboração da proposta orçamentária de pleitos eleitorais;  
III - Realizar a análise de risco do processo eleitoral com os gerentes;  
IV - Promover a integração dos processos eleitorais;  
V- Acompanhar a execução do Plano Integrado das Eleições, realizando o monitoramento e a execução das atividades e atuação dos gerentes;  
VI - Promover ações conjuntas de soluções de problemas relativos aos processos de eleição;  
VII - Colher sugestões de melhorias e análise de viabilidade;  
VIII - Elaborar e publicar relatório de avaliação das eleições, incluindo proposta de otimização dos trabalhos.  
IX - Planejar e propor iniciativas para otimizar o processo eleitoral, implementando ações para operacionalizar a efetividade dos serviços de eleição;  
X - Planejar, definir e estruturar formas de apoio técnico para atuação nos cartórios eleitorais do Estado no período eleitoral, em parceria com a Corregedoria;  
XI - Promover alinhamento das atividades dos processos de eleição com as unidades administrativas envolvidas no processo eleitoral.  
XII - Promover alinhamento das normas e atividades dos processos da eleição com o Tribunal Superior Eleitoral.  

2. MUDANÇAS NA ESTRUTURA DA SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO - GSTI  

A proposta de criação da Assessoria de Gestão Eleitoral tem impacto na estrutura organizacional da Secretaria de Tecnologia da Informação deste Tribunal, uma vez que conta com uma coordenadoria dedicada exclusivamente às eleições, a Coordenadoria de Eleições – COELE, que foi criada em virtude da atribuição, à área técnica, da responsabilidade de elaborar o planejamento e a logística das eleições.  
Contudo, diante da criação de uma unidade voltada à gestão das eleições, a existência de uma coordenadoria exclusiva para as eleições na STI não se faz mais necessária, uma vez que, embora remanesça algumas atividades relacionadas às eleições na área técnica, como a manutenção das urnas eletrônicas e de suporte aos sistemas eleitorais, a parte que caberá à STI no planejamento das eleições deverá ser redistribuída dentre as unidades de suporte da Secretaria de Tecnologia da Informação.  
Destarte, sendo retiradas da STI algumas atribuições relativas às eleições, será necessária a reformulação de sua estrutura interna para receber as atribuições eminentemente técnicas, passando a dedicar-se às soluções tecnológicas corporativas.  
Pelo que se propõe, a nova coordenadoria, que substituirá a atual COELE, abrigará a Seção de Desenvolvimento e Banco de Dados – SDBD, mudando sua nomenclatura para Coordenadoria de Soluções Corporativas – CSCOR, alinhada ao que se observa em grande parte dos Tribunais Regionais Eleitorais, que contam com uma unidade semelhante.  
Na CSCOR, portanto, além da SDBD, ficará também a Seção de Sistemas Eleitorais e Corporativos – SSEC, cujas atribuições são, em parte, herdadas da SESEL, que faz parte da estrutura atual (vide proposta de organograma anexa).  
Ainda no viés de reestruturação da STI, considerando que a SEUE lida basicamente com as urnas eletrônicas e procedimentos técnicos a elas relacionados, por uma questão de afinidade, propõe-se que a unidade seja subordinada à Coordenadoria de Infraestrutura - CIE.  
Além disso, considerando a obrigatoriedade de existir uma unidade dedicada à defesa cibernética, com atribuições operacionais, propõe-se transformar a Assistência de Cibersegurança - ACSEG (atualmente vinculada ao Gabinete da STI) em Seção de Cibersegurança, ligada à Coordenadoria de Infraestrutura.  
Desse modo, a Coordenadoria de Infraestrutura passará a ter 4 (quatro) seções subordinadas: a Seção de Redes –SEREDE, a Seção de Suporte ao Usuário – SSU, a Seção de Urnas Eletrônicas – SEUE e a Seção de Cibersegurança, cuja sigla sugere-se que seja ser SCSEG.  

3. MUDANÇAS NA ASSESSORIA JURÍDICA - ASDG  

Quanto à unidade Assessoria Jurídica da Diretoria-Geral, propõe-se a alteração do nome para “Assessoria Jurídica”, considerando que as suas atribuições não se restringem ao assessoramento da Diretoria-Geral. Como conhecido, a atuação da referida unidade abrange todo o Tribunal, em especial os setores de Gestão de Pessoas e da Secretaria de Administração.  
Além disso, constata-se que o volume de processos que tramitam na unidade é expressivo e desproporcional à força de trabalho, sendo essencial que mais um cargo de Assessor (CJ1) seja criado, para suprir a demanda e não prejudicar o trâmite dos processos administrativos do Tribunal, particularmente os que se referem a contratação.  
Convém mencionar que 70% (setenta por cento) dos processos que tramitam na Assessoria Jurídica tratam de questões que envolvem contratações públicas. Os referidos processos tramitam do início, com a efetiva contratação, que pode se dar de forma direta, ou por meio de processo licitatório, quando exige análise de minutas de editais, contratos, atas, termos de referência, requisitos de apuração de preços de referência, até o seu encerramento, após a entrega (ou não) do objeto, que pode gerar análises acessórias das mais diversas, como, por exemplo, prorrogações contratuais, apurações de responsabilidades por descumprimento de obrigações, alterações contratuais diversas, reajustes em geral, etc.  
Quanto aos processos que envolvem questões de pessoal, apesar da menor quantidade, muitas das vezes possuem maior complexidade, por envolverem questões menos rotineiras, exigindo estudos mais dedicados aos casos concretos.  
Em 2022 foram apresentadas mais de 700 manifestações formais, em processos que exigem análise pormenorizada.  
Importante registrar que as atividades da Assessoria não se restringem aos pareceres formais em processos de contratação e de pessoal. São diárias as consultas informais, além de rotineira a participação em reuniões, comissões e eventos de capacitação.  
Menciona-se, ainda, que no curso deste ano serão necessários ajustes nos processos de contratação, decorrente da aplicação da Lei 14.133/2021. Isso, porque a revogação da Lei 8.666/93 foi adiada, após a constatação de que a Administração Pública em geral não estava preparada para a nova Lei de Licitações e Contratos Administrativos. Em particular, a Justiça Eleitoral (em todo o país), que não pode dedicar atenção especial ao tema no ano passado, em razão do foco nas Eleições Gerais.  
As atividades da assessoria jurídica são muito específicas e não há como atribuir substituto de outra unidade em caso de férias de um dos dois servidores atualmente lotados na unidade. Em razão disso, no período de férias, tende a gerar atrasos nos procedimentos, sendo necessário que a unidade conte com estrutura que suporte tais períodos críticos.  
Por fim, importa lembrar que a assessoria jurídica é um importante instrumento para mitigar riscos de falhas de ordem administrativa, que, até mesmo, podem culminar em responsabilização civil, administrativa e criminal dos gestores.  

4. CRIAÇÃO DA ASSESSORIA DE GOVERNANÇA E PLANEJAMENTO DA SAOF - ASGOVSAOF  

A Secretaria de Administração, Orçamento e Finanças tem por atribuição as matérias relacionadas com as questões orçamentárias, financeiras e de contratações, inclusive todo o planejamento relacionados com essas áreas, sendo necessária a criação de uma assessoria que permita ao titular da unidade exercer precipuamente o papel de coordenação, reduzindo a atuação operacional, como hoje ocorre.  
Competirá à assessoria o acompanhamento da gestão dos procedimentos de contratações, em apoio às equipes de planejamento das contratações, apoio na gestão orçamentária do Tribunal, na execução dos planos anuais de contratações, no acompanhamento da execução das iniciativas do planejamento estratégico e demais atividades inerentes à Secretaria.  
Seriam atribuições da Assessoria:  
I - assegurar que as diretrizes de governança e da gestão de contratações do órgão sejam preservadas de acordo com as normas de contratações públicas e diretrizes do CNJ e TCU;  
II - garantir que as contratações públicas estejam alinhadas ao Planejamento Estratégico do Tribunal;  
III - promover o direcionamento, a avaliação e o monitoramento da gestão de contratações;  
IV - estudar, propor e fomentar a implantação e a melhoria contínua dos processos de governança das contratações;  
V - assistir o titular da SAOF na definição e atualização de normativos afetos à governança;  
VI - coletar, coordenar e consolidar a elaboração de relatórios de gestão e de governança no âmbito da SAOF;  
VII - avaliar e consolidar os resultados das variáveis que compõem os indicadores estratégicos demandados pelo secretário da SAOF;  
VIII - avaliar a prestação de informações relativas à consecução dos objetivos institucionais estabelecidos no planejamento estratégico do Tribunal;  
IX - elaborar, em conjunto com as unidades da SAOF, o mapeamento de atividades e gestão de riscos;  
X - avaliar os resultados da elaboração e da atualização da Gestão de Riscos nas unidades administrativas da SAOF;  
XI - assessorar a SAOF nas atividades relacionadas ao planejamento estratégico do tribunal;  
XII – elaborar, em conjunto com as unidades, ato normativo sobre matérias correlacionadas à área de atuação da SAOF e de manuais de trabalho, visando à otimização e padronização de atividades e rotinas;  
XIII - orientar, acompanhar e consolidar a elaboração de relatórios e de respostas, relativos à SAOF, a órgãos de controle;  
XIV - promover levantamentos de dados estatísticos destinados a subsidiar informações sobre indicadores e metas da SAOF;  
XV - compilar as informações das diversas unidades da SAOF, para elaboração do Relatório Anual de Gestão, visando ao atendimento do cronograma de atividades da secretaria, encaminhando à área competente o resultado do trabalho;  
XVI - subsidiar com estudos, análises e pesquisas os despachos e outras manifestações da secretária ou secretário da SAOF em procedimentos administrativos;  
XVII - propor e elaborar relatórios gerenciais para monitoramento das atividades produzidas pelas unidades da SAOF;  
XVIII – monitorar os serviços disponíveis no sítio do Tribunal, afetos à SAOF, propondo, quando for o caso, as devidas atualizações e ajustes;  
XIX - gerenciar projetos especiais atribuídos pela secretária ou secretário da SAOF;  
XX - acompanhar as demandas de interesse da SAOF que aguardam providências de outras unidades do tribunal ou do TSE;  
XXI – emitir pareceres sobre assuntos que lhe forem encaminhados, sempre que demandado  
XXII – Prestar assessoria à SAOF, nas atividades de planejamento e gestão, consistente:  
- na elaboração de seu plano de ações em alinhamento às diretrizes estratégicas;  
- na realização das atividades definidas pela unidade de assessoria de planejamento, estratégia e gestão da Diretoria-Geral;  
- no planejamento estratégico, viabilizando a interligação e compatibilização dos planos gerenciais, táticos e operacionais;  
- no acompanhamento e análise da compatibilização entre a execução do plano de ação e o planejamento estratégico previsto, apresentando os desvios ocorridos e potenciais, bem como as ações corretivas e preventivas;  
- na elaboração, proposta, execução e acompanhamento de projetos e programas voltados para a gestão pela qualidade;  
- no estabelecimento, em conjunto com as coordenadorias e seções das unidades administrativas, de metas e indicadores de desempenho;  
XXII - executar outras atividades pertinentes determinadas pela secretária ou secretário da SAOF.  

5. CRIAÇÃO DA UNIDADE PREGÃO  

Atualmente a função de pregoeiro é desempenhada por servidores de outras unidades, que acumulam atividades, o que, por vezes, prejudica o bom andamento dos pregões. É o que acontece com os Assistentes dos Juízes Membros que, em ano eleitoral, priorizam, como não poderia deixar de ser, as atividades relacionadas com os processos judiciais.  
A dedicação exclusiva de servidor para essa atividade já se mostrou bastante proveitosa nos anos de 2018 e 2019, pois o servidor designado fica com dedicação exclusiva a essa atividade, permitindo-lhe maior especialização na matéria e agilidade na conclusão dos certames licitatórios.  
As atribuições do Pregoeiro seriam todas aquelas relacionadas com a realização efetiva do certame licitatório, desde o recebimento do edital publicado no local oficial, até a adjudicação do objeto ou o encaminhamento para decisão de recurso impetrado contra as suas decisões.  

6. CRIAÇÃO DA SEÇÃO DE GESTÃO DE CONTRATOS - SEGC  

A gestão de contratos é, juntamente com a elaboração dos estudos técnicos preliminares, fator que contribui para a formalização de prorrogações excepcionais de contratos e a realização de contratos emergenciais, o que deve ser evitado ao máximo pela Administração. Atualmente a gestão desses contratos é realizada pelas próprias unidades demandantes dos serviços. E isso tem algumas implicações, pois as constantes alterações de lotação de servidores impede uma maior especialização na área, sendo comum a designação de servidor sem qualquer experiência/conhecimento para essa tarefa, resultando em gestão deficiente. Para além disso, os servidores das unidades têm outras atribuições, não sendo possível a dedicação integral à gestão contratual.  
A criação da Seção de Gestão de Contratos permitirá maior especialização da força de trabalho lotada na unidade, pois a missão precípua será exatamente a gestão dos contratos.  
Pretende-se que a atuação da seção se dê logo após a publicação do contrato, competindo-lhe, a partir daí, gerir o contrato, com a requisição dos documentos necessários ao início da execução do serviço, encaminhamento dos pagamentos mensais, após o atesto do(s) fiscal(ais), verificação de manutenção dos requisitos de habilitação, notificação sobre aplicação de penalidades, verificação da entrega da garantia e demais requisitos exigidos contratualmente.  
Importante registrar que a seção não será responsável pela elaboração de artefatos das contratações (estudo técnico preliminar, termo de referência, projeto básico, mapa de risco e etc.), pois sua atuação inicia-se após a assinatura do contrato e tem por objetivo a gestão do mesmo. Os artefatos da contratação devem continuar a ser elaborados pelas equipes de planejamento.  
Seriam atribuições da unidade, dentre outras:  
I - promover a juntada, no procedimento administrativo, de todos os documentos contratuais recebidos;  
II - anotar, de forma organizada, em registro próprio, todas as ocorrências  
relacionadas com a execução do contrato;  
III - manter arquivo com dados atualizados do representante da contratada, contendo documentos pertinentes à sua qualificação, ao desempenho de suas atribuições e a forma de contato;  
IV - registrar os ajustes acordados, no âmbito de suas atribuições, com o  
representante da contratada, colhendo sua assinatura e promovendo a sua juntada aos autos;  
V - conferir o cumprimento do objeto e demais obrigações pactuadas, especialmente o atendimento às especificações atinentes ao objeto e sua garantia, bem como os prazos fixados no  
contrato, visitando o local onde o contrato esteja sendo executado e registrando os pontos críticos  
encontrados, inclusive com a produção de provas, datando, assinando e colhendo a assinatura do  
preposto da contratada para instruir possível procedimento de sanção contratual, com o apoio dos eventuais fiscais;  
VI - comunicar à Administração sobre o descumprimento, pela contratada, de quaisquer das obrigações passíveis de rescisão contratual e/ou aplicação de penalidades;  
VII - comunicar à contratada os danos porventura causados por seus empregados, requerendo as providências reparadoras;  
VIII - analisar, conferir, atestar notas fiscais e emitir nota técnica; esta, no caso de despesas superiores a dois mil reais;  
XIX - comunicar à Administração eventual subcontratação da execução, sem previsão editalícia ou sem conhecimento da Administração; X - fiscalizar, pessoalmente, os registros dos empregados da contratada locados nos serviços, para verificar a regularidade trabalhista;  
XI - oficiar à contratada sobre a necessidade de atualização documental para manutenção das condições de habilitação ou atendimento de exigências legais supervenientes;  
XII - comunicar à Administração, mediante provocação do requisitante, a  
necessidade de se realizar acréscimos ou supressões no objeto contratado, com vista à economicidade e  
à eficiência na execução contratual;  
ATRIBUIR ASSISTÊNCIA AO NÚCLEO DE GESTÃO DE QUALIDADE - NUGEQ  
Atualmente, o Núcleo de Gestão da Qualidade é composto por servidores lotados em outras unidades, designados por portaria da Presidência, sob a presidência da Juíza Auxiliar da Presidência.  
Nesse cenário, é sabido que o volume de atividades relacionadas à gestão dos requisitos para o prêmio de qualidade é crescente, considerando que a cada ano o Conselho Nacional de Justiça - CNJ inclui novos temas que exigem revisões dos planejamentos e acompanhamento constantes das atividades impactadas.  
Em vista disso, propõe-se a criação de uma Assistência VI – FC6 para o NUGEQ, por entender que seja necessária dedicação exclusiva na gestão dos requisitos de qualidade, de forma que o servidor designado para essa função seja também responsável pela elaboração do plano estratégico de atendimento aos requisitos de qualidade, e, ao mesmo tempo, pelo acompanhamento da sua execução pelas unidades responsáveis.  
7. TRANSFORMAÇÕES DE CJ  
As transformações de cargos em comissão constantes na presente proposta visam ao aproveitamento das sobras de recursos, com a consequente valorização das atividades ora desenvolvidas pelos titulares das unidades beneficiadas, que, de igual forma, ao longo da evolução do processo eleitoral, das novas determinações legais e de orientações dos órgãos de controle externo, vem agregando novas atribuições, que exigem, cada vez mais, responsabilidade, eficiência, esforço e iniciativa por parte dos servidores que ocupam tais cargos.  
Considera-se que as unidades compreendidas na transformação dos cargos, são responsáveis por atividades críticas que impactam no eficiente andamento dos processos administrativos e na imagem institucional e por consequência no atingimento dos objetivos estratégicos e no cumprimento da missão institucional.  
As unidades envolvidas são as seguintes:  
Assessoria de Planejamento, Estratégia e Gestão: de CJ2 para CJ3;  
Assessor Jurídico Chefe da Assessoria Jurídica: de CJ2 para CJ3;  
Assessor Jurídico Adjunto da Assessoria Jurídica: de CJ1 para CJ2;  
Assessoria Jurídica da Presidência: de CJ2 para CJ3;  
Chefe de Gabinete da Diretoria-Geral: de CJ1 para CJ2;  
Assessoria de Comunicações: de CJ1 para CJ2;  
Chefe de Gabinete da Presidência: de CJ1 para CJ2;  
Chefe de Gabinete da Corregedoria: de CJ1 para CJ2;  
Assessoria Jurídica da Corregedoria: de CJ1 para CJ2;  
8. CRIAÇÃO DA ASSISTÊNCIA DE SUSTENTABILIDADE, ACESSIBILIDADE E INCLUSÃO - ASSAI  
Atualmente existem 3 (três) comissões diferentes tratando dos temas sustentabilidade, acessibilidade e inclusão no TRE do Acre, designadas por meio de portarias da Presidência.  
O que se propõe é que seja criada uma unidade com competência unificada para gerenciar as ações sobre tais temas, inclusive com gestão financeira dos recursos designados para suas execuções.  
A criação dessa unidade, como nos demais regionais, não elimina a designação de servidor responsável pelo Núcleo de Sustentabilidade (NSA), em atendimento à Resolução CNJ n. 400/2021.  
Serão atribuições da unidade ASSAI:     
Art. 23. Compete à Assistência de Sustentabilidade, Acessibilidade e Inclusão:  
I - propor e, no que couber, implementar planos, programas, projetos e ações voltados à promoção da sustentabilidade, acessibilidade e inclusão, e à oferta de suporte biopsicossocial e institucional à pessoa com deficiência;  
II - auxiliar no desenvolvimento de ações e no atendimento de demandas de sustentabilidade, acessibilidade e inclusão;  
III - propor ações de sensibilização e capacitação do quadro de pessoal e, no que couber, do quadro auxiliar, a fim de promover conscientização e promoção de direitos, e o atendimento adequado às pessoas com deficiência ou mobilidade reduzida;  
IV - monitorar as ações das unidades responsáveis pelos indicadores referentes a sustentabilidade, acessibilidade e inclusão;  
V - participar do acompanhamento funcional dos servidores e servidoras com deficiência;  
VI - elaborar relatório anual acerca das ações desenvolvidas para a promoção da sustentabilidade, acessibilidade e inclusão no Tribunal.  
VII - incentivar e promover parcerias eficazes com outros tribunais, conselhos, entidades sem fins lucrativos e com a sociedade civil, com foco na sustentabilidade, acessibilidade e inclusão, a fim de compartilhar experiências e estratégias, possibilitando a atualização em assuntos relacionados.  
Art. 24 Ao Núcleo de Sustentabilidade, compete:  
I - planejar, implementar e monitorar as metas anuais do Plano de Logística Sustentável (PLS) do Tribunal;  
II - incentivar o combate ao desperdício e promover atividades voltadas para a prática de consumo consciente e para a eficiência do gasto público;  
III - gerenciar e monitorar indicadores de impacto ambiental em consonância com o planejamento estratégico do Tribunal e revisar ações, projetos e iniciativas;  
IV - elaborar relatório de desempenho do Plano de Logística Sustentável com a consolidação dos resultados alcançados, a evolução dos indicadores e a identificação das ações a serem desenvolvidas ou modificadas para o ano subsequente;  
V - promover, periodicamente, o envio de dados socioambientais para os órgãos de controle;  
VI - informar indicadores solicitados por órgãos de controle;  
VII – fomentar a redução do impacto negativo das atividades do órgão no meio ambiente, com a adequada gestão dos resíduos gerados;  
VIII - trabalhar em prol da consolidação da política de sustentabilidade, mediante inserção de critério socioambiental em procedimento licitatório de aquisição e serviço;  
IX - desenvolver ação de conscientização e educação ambiental;  
X - fomentar engajamento institucional com vistas à preservação do equilíbrio do meio ambiente;  
XI - propor implementação de programa e projeto para utilização sustentável da água, eficiência energética e conservação de energia;  
XII - participar de eventos relacionados à sustentabilidade, acessibilidade e inclusão.  
Ao GAPRES, para submeter a proposta ao Presidente do Tribunal, com a sugestão que seja ouvido o Corregedor Regional Eleitoral.  


---


Ata - PRESI/DG/GADG  
Data: 05/07/2023  
Horário: 13h  
Local: SARA  
Formato: Virtual  

Participantes:  
* Carlos Venicius Ferreira Ribeiro  
* Francisco Vital de Mascarenhas Filho  
* Sandro Roberto de Oliveira Bezerra  
* Rosana Magalhaes da Silva  

Pauta:

1. A reunião teve como objetivo colher informações da unidade SEJUD sobre eventuais necessidades de criação ou transformação de cargos em comissão (CJ) na unidade, visando subsidiar  analise da possibilidade de atendimento com a sobra de CJ existente atualmente. 

DEFINIÇÕES / DECISÕES / ESCLARECIMENTOS:

A reunião foi conduzida pela Diretora-Geral, que solicitou ao Secretário Judiciário que informasse sobre a demanda da unidade em relação à criação de cargos em comissão, considerando tratar-se de verba direcionada a esse fim. O Secretário Judiciário reiterou o que havia falado à Diretora-Geral, quanto a sua discordância em como a proposta de reestruturação tramitou, sem ouvir a SEJUD e outras unidades que também precisam de uma melhor estrutura e, que poderiam ser impactadas com a proposta para melhorias, ante o saldo orçamentário, ao que a Diretora-Geral afirmou que a proposta em tramitação atende as prioridades estratégicas da Presidência do Tribunal, tendo sido a proposta apresentada ao Presidente e ao Corregedor, que aprovaram a proposta. O Secretário Judiciário exemplificou e mencionou as seguintes atividades que sobrecarregam a unidade e que seria importante que fossem criadas unidades para atuarem em tais atribuições: 1. Atendimento das demandas do CNJ quanto a processos judiciais e metas; 2. Gestão documental, que também impacta no Prêmio CNJ e está tendo grande relevância, tendência que deverá permanecer como exigência daquele Conselho nos próximos anos; 3. Cobrança de multas na JE, ante a nova Resolução TSE n. 23.709/22. Mencionou, ainda, que se poderia também discutir a possibilidade da criação de uma assessoria na SEJUD, até mesmo de Planejamento. A DG explicou que os valores destinados a pagamento de CJ não podem ser destinados a criação de unidades como seção e assistências, por vedação legal. A DG também explicou como foram feitas as simulações de criações e transformações e optou-se por atender o que era mais grave para a administração, situação que não é de conhecimento do Secretário, naturalmente. A DG solicitou informações sobre se havia proposta de reestruturação interna da SEJUD, conforme foi feito pela STI, para aproveitar o ensejo do processo. O Secretário Judiciário informou que, no momento, não teria como apresentar uma proposta de mudanças internas, mas que precisaria de um tempo maior para discutir internamente com as unidades subordinadas, visto que não consultado sobre a possibilidade de reestruturação. A DG informou que a qualquer momento a SEJUD poderia e pode apresentar propostas de mudanças internas. A Diretora-Geral informou que não haveria prejuízo se a proposta fosse encaminhada posteriormente, já que não teria impacto na proposta de aproveitamento de CJ, ora em tramitação. O Secretário Judiciário registrou que a reestruturação proposta é uma das maiores já efetivadas no TRE e deve ser melhor discutida, inclusive sendo constituída uma comissão para verificar as necessidades das diversas unidades, embora o saldo de orçamento não possa contemplar a todos. No entanto, mencionou que poderiam ser verificados vários cenários para o aproveitamento dos recursos, tanto da SEJUD quanto de outras unidades, objetivando melhor dividir o que disposto no orçamento. Exemplificou o TRE do Amapá, onde a reestruturação aprovada, ante a Resolução TSE n. 23.698/22, criou diversas CJ 1 contemplando vários setores. Sugeriu, ainda, uma reunião com o senhor Presidente para falarem a respeito da reestruturação, ao que a Diretora-Geral informou que o Presidente e Corregedor já conhecem a proposta e tem interesse na aprovação da proposta, já que atende aos problemas graves enfrentados pela administração nesses últimos anos. A DG explicou ao Secretário que o fato de a SEJUD não ter sido consultada, não significa que a proposta não seja importante para o Tribunal, já que aprovada por ambos os Desembargadores. Explicou, ainda, que não seria possível atender a todas as demandas e alguém não seria atendido, e que não se trata de "repartir o bolo", como mencionado pelo Secretário, mas de analisar o que é mais grave e urgente para o Tribunal como um todo, e essa visão geral tem a direção geral, que concentra todas as demandas. Também foi registrado pela DG que a Secretaria Judiciária foi a única que não sofreu redução de estrutura, como aconteceu com a STI, DG, SAOF e CRE que cederam funções para gerar outras estratégicas como o Núcleo de Gestão da Qualidade e gestão de contratos. Considera a DG que a SEJUD é uma das unidades mais estáveis do Tribunal com um excelente corpo funcionou, mencionando ainda, não ver nenhum problema nos trabalhos da SEJUD, tendo, inclusive feito elogio. O Secretário registrou que conseguem realizar os serviços com bastante esforço, razão pela qual deve haver uma melhor estrutura, o que não discordou a DG, inclusive registrando que é uma característica de várias unidades do TRE, não somente da SEJUD. O Secretário citou exemplos, como a demanda relativa a publicação exigida no Prêmio CNJ deste ano, quanto a gestão documental e as afetas aos processos judiciais, como o painel de saneamento e cumprimento das metas. Questionou o titular da SEJUD, como exemplo, qual o motivo de se transformar uma CJ1 da ASCOM em uma CJ2, como previsto na proposta, bem como outras CJs, sem ouvir previamente outras unidades, que podem ser melhor estruturadas, tendo a Diretora-Geral informado que o estudo vem sendo feito desde o final de  2022, quando se iniciou as simulações financeiras com a área competente, a SAOF, para se obter o saldo real das sobras de CJ e compreender como se daria o aproveitamento das sobras. A DG explicou ao Secretário que o aumento de CJ1 para CJ2 da ASCOM é estratégico pra o Tribunal, como as demais transformações, e que esse assunto foi discutido com os desembargadores dirigentes do Tribunal, e que por isso não havia cabimento nova reunião, que só atrasaria o processo, uma vez que atende também os interesses da próxima gestão que se aproxima.


PROVIDÊNCIAS/RESPONSÁVEIS:

A Diretora-Geral sugeriu que a SEJUD apresentasse, quando possível, proposta de modificações internas, que envolvesse a seção de atas e notas taquigráficas (SEANT), que atualmente conta com mais recursos tecnológicos e poderia agregar algumas das atividades mencionadas pelo Secretário. A Diretoria-Geral encaminhará manifestação ao Presidente acerca do que foi proposto pela unidade SEJUD. O Secretário deverá tratar com unidades da SEJUD alterações na estrutura interna. Assim, nada mais havendo, a reunião foi encerrada e, para registro, foi produzida a presente ata, que vai assinada pelos integrantes presentes.

---

Despacho nº 0596866 / 2023 - PRESI/GAPRES

Trata-se de minuta de resolução encaminhada pela Diretoria-Geral (0584099), que dispõe sobre a alteração da estrutura orgânica do Tribunal Regional Eleitoral do Acre, aprovada pela Resolução TRE-AC n. 1.770/2021 e modificada pela Resolução TRE-AC n. 1.777/2022.

Encaminhados os autos à Diretoria-Geral, a fim de que esta e as unidades a ela subordinadas apresentassem as adequações que entendessem necessárias, retornaram os autos à Presidência,finalizando-se a instrução do presente feito no âmbito da Administração deste Regional.

Razão disso, encaminhe-se à Secretaria Judiciária para registro, autuação e distribuição à Presidência (Art. 59, RI-TRE/AC), bem como registrar que o feito será levado em mesa para julgamento na sessão do dia 10 de julho de 2023.

Ao depois, conclusos.

Desembargador FRANCISCO DJALMA
 Presidente

---

TRIBUNAL REGIONAL ELEITORAL DO ACRE  
Alameda Ministro Miguel Ferrante, 224 - Bairro Portal da Amazônia - CEP 69915-632 - Rio Branco - AC

**Minuta**

RESOLUÇÃO N. 	, DE 

Alterar a estrutura orgânica do Tribunal Regional Eleitoral do Acre, aprovada pela Resolução TRE-AC n. 1.770/2021 e modificada pela Resolução TRE-AC n. 1.777/2022.  
   
O TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições que lhe são conferidas pelo artigo 96, inciso I, alínea "b", da Constituição da República, e pelo art. 30, inciso II, do Código Eleitoral e no inciso IV do art. 17, II da Resolução TRE-AC n. 1.720, de 16 de junho de 2017, alterada pelas Resoluções n. 1.735 e 1.736/2018; 1.740/2019 e 1.748/2020 (Regimento Interno),

CONSIDERANDO que o parágrafo único do art. 24 da Lei nº 11.416/2006 autoriza a transformação de cargos em comissão e funções comissionadas, sem aumento de despesa;

CONSIDERANDO a Resolução TSE nº 23.698/2022, que alterou sua estrutura orgânica, com transformação de cargos em comissão;

CONSIDERANDO a conveniência e oportunidade de reorganizar a Secretaria do Tribunal, visando a otimização dos serviços administrativos e judiciais prestados pela Justiça Eleitoral do Acre; e

CONSIDERANDO a viabilidade jurídica, orçamentária e de pessoal para a reestruturação proposta,

RESOLVE:

Art. 1º Aprovar a utilização dos recursos orçamentários provenientes do saldo de 35% advindos do valor integral do cargo em comissão, quando houver opção do servidor ocupante pela retribuição do cargo efetivo, a teor do que preceitua o art. 24, parágrafo único, da Lei n. 11.416, de 15 de dezembro de 2006, para criação e transformação, sem aumento de despesa, de cargos em comissão.

§ 1º O valor paradigma a ser considerado para fins da transformação de que trata o *caput* é o resultante da totalidade dos cargos em comissão existentes neste Tribunal, providos ou não, multiplicado pelo valor integral constante do Anexo III da Lei n. 11.416/2006, com redação dada pelas Leis n. 13.317, de 20 de julho de 2016, e n. 14.523, de 9 de janeiro de 2023\.

§ 2º O valor residual para transformação de que trata o *caput* é resultante da diferença apurada no parágrafo anterior deduzido da situação atual de ocupação de optantes pela retribuição do cargo efetivo;

§ 3º No caso de cargos não providos, para apuração da situação atual, será utilizado o valor integral constante do Anexo III da Lei n. 11.416/2006, com redação dada pelas Leis n. 13.317, de 20 de julho de 2016, e n. 14.523, de 9 de janeiro de 2023\.

§ 4º A situação atual tratada no § 2º tem como base o Anexo V da Resolução TRE-AC n. 1.777/2022.

§ 5º A Coordenadoria de Gestão de Pessoas e a Secretaria de Administração, Orçamento e Finanças deverão manter monitoramento quanto à utilização dos recursos orçamentários referidos nesta Resolução.

Art. 2º Alterar a estrutura orgânica do Tribunal Regional Eleitoral do Acre, aprovada pela Resolução TRE-AC n. 1.770/2021, para:

1. modificar o nome das seguintes unidades:  
> 1. a "Assessoria Jurídica da Diretoria-Geral - ASDG", subordinada à Diretoria-Geral, passará a ser a "Assessoria Jurídica - ASJUR"; e  
> 2. a "Seção de Legislação e Normas - SELEG", subordinada à Coordenadoria de Gestão de Pessoas, passará a ser a "Seção de Apoio aos Inativos e Cadastro de Magistrados - SAREMI".  
2. extinguir as seguintes unidades administrativas:  
> 1. Coordenadoria de Eleições - COELE, antes vinculada à Secretaria de Tecnologia da Informação; e  
> 2. Seção de Sistemas Eleitorais - SESEL antes vinculada à Coordenadoria de Eleições.  
3. criar as seguintes unidades administrativas:  
> 1. Assessoria de Gestão Eleitoral - AGEL, subordinada à Diretoria-Geral;  
> 2. Pregão - PREGÃO, subordinada à Secretaria de Administração, Orçamento e Finanças;  
> 3. Assessoria de Governança e Planejamento da Secretaria de Administração, Orçamento e Finanças - ASGOVSAOF;  
> 4. Seção de Gestão de Contratos - SGEC, subordinada à Coordenadoria de Material e Patrimônio;  
> 5. Coordenadoria de Soluções Corporativas - CSCOR, vinculada à Secretaria de Tecnologia da Informação;  
> 6. Seção de Sistemas Eleitorais e Corporativos – SSEC, subordinada à Coordenadoria de Soluções Corporativas; e  
> 7. Seção de Cibersegurança - SCSEG, subordinada à Coordenadoria de Infraestrutura.  
4. remanejar as seguintes unidades administrativas:  
> 1. Seção de Urnas Eletrônicas, antes vinculada à Coordenadoria de Eleições, para a Coordenadoria de Infraestrutura; e  
> 2. Seção de Desenvolvimento e Banco de Dados – SDBD, antes vinculada à Coordenadoria de Infraestrutura, para a Coordenadoria de Soluções Corporativas.  
5. criar os seguintes cargos em comissão:  
> 1. Assessor III, a ser retribuído com um Cargo em Comissão de Nível 3 - CJ3, vinculado à unidade Assessoria de Gestão Eleitoral;  
> 2. Assessor I, a ser retribuído com um Cargo em Comissão de Nível 1 - CJ1, vinculado à unidade Assessoria de Gestão Eleitoral;  
> 3. Pregoeiro, a ser retribuído com um Cargo em Comissão de Nível 2 - CJ2, vinculado à unidade Pregão;  
> 4. Assessor I, a ser retribuído com um Cargo em Comissão de Nível 1 - CJ1, vinculado à unidade Assessoria de Governança e Planejamento da Secretaria de Administração, Orçamento e Finanças; e  
> 5. Assessor I, a ser retribuído com um Cargo em Comissão de Nível 1 - CJ1 - Assessor Jurídico - Nível I, vinculado à Assessoria Jurídica.  
6. transformar os seguintes cargos em comissão:  
> 1. Assessoria de Planejamento, Estratégia e Gestão, atualmente retribuída com um Cargo em Comissão de Nível 2 - CJ2, que passará a ser retribuída com um Cargo em Comissão de Nível 3 - CJ3;  
> 2. Assessoria Jurídica da Presidência, atualmente retribuída com um Cargo em Comissão de Nível 2 - CJ2, que passará a ser retribuída com um Cargo em Comissão de Nível 3 - CJ3 - Assessor Jurídico - Nível III;  
> 3. Assessoria Jurídica, atualmente retribuída com um Cargo em Comissão de Nível 2 - CJ2, que passará a ser retribuída com um Cargo em Comissão de Nível 3 - CJ3 - Assessor Jurídico Chefe - Nível III;  
> 4. Assessoria Jurídica, atualmente retribuída com um Cargo em Comissão de Nível 1 - CJ1, que passará a ser retribuída com um Cargo em Comissão de Nível 2 - CJ2 - Assessor Jurídico - Nível II;  
> 5. Chefe de Gabinete da Presidência, atualmente retribuído com um Cargo em Comissão de Nível 1 - CJ1, que passará a ser retribuído com um Cargo em Comissão de Nível 2 - CJ2;  
> 6. Assessoria de Comunicação Social, atualmente retribuída com um Cargo em Comissão de Nível 1 - CJ1, que passará a ser retribuída com um Cargo em Comissão de Nível 2 - CJ2;  
> 7. Chefe de Gabinete da Diretoria-Geral, atualmente retribuído com um Cargo em Comissão de Nível 1 - CJ1, que passará a ser retribuído com um Cargo em Comissão de Nível 2 - CJ2;  
> 8. Chefe de Gabinete da Corregedoria, atualmente retribuído com um Cargo em Comissão de Nível 1 - CJ1, que passará a ser retribuído com um Cargo em Comissão de Nível 2 - CJ2; e  
> 9. Assessoria Jurídica da Corregedoria, atualmente retribuída com um Cargo em Comissão de Nível 1 - CJ1, que passará a ser retribuída com um Cargo em Comissão de Nível 2 - CJ2 - Assessor Jurídico.  
7. extinguir as seguintes funções comissionadas:  
> 1. Assistente V da Corregedoria, antes retribuída com uma Função Comissionada de Nível 5 - FC5; e  
> 2. Assistente I da Coordenadoria de Infraestrutura, antes retribuída uma Função Comissionada de Nível 1 - FC1.  
8. criar uma função comissionada de Chefe de Seção (FC6) para a Seção de Gestão de Contratos.  
9. Remanejar os seguintes cargos em comissão e funções comissionadas:  
> 1. Coordenador da Coordenadoria de Eleições (CJ2) para Coordenador da Coordenadoria de Soluções Corporativas;  
> 2. Chefe de Seção da Seção de Sistemas Eleitorais (FC6) para chefe da Seção de Sistemas Eleitorais e Corporativos;  
> 3. Assistente VI da Assistência de Cibersegurança (FC6) para chefe da Seção de Cibersegurança;  
> 4. Assistente V do Núcleo Socioambiental (FC5) para Assistente V da Assistência de Sustentabilidade, Acessibilidade e Inclusão - ASSAI, vinculada à Assessoria de Planejamento Estratégia e Gestão; e  
> 5. Assistente VI da Assessoria de Planejamento Estratégia e Gestão (FC6) para Núcleo de Gestão da Qualidade, vinculado à Presidência.

§ 1º. As criações, extinções, remanejamentos e transformações previstas no *caput* não importarão em aumento de despesas.

Art. 3º O novo organograma da estrutura do Tribunal Regional Eleitoral do Acre passará a ser o constante no Anexo I desta Resolução, revogando-se o contido no Anexo I do da Resolução TRE-AC n. 1.770/2021 ([0460562](https://sei.tre-ac.jus.br/sei/controlador.php?acao=protocolo_visualizar&id_protocolo=491419&id_procedimento_atual=614067&infra_sistema=100000100&infra_unidade_atual=110000988&infra_hash=c7f4e1dc68fe9f6973ec0a531fe7715176af9771787e3226447e82d1d7dce36d3c38ac293dcf19251d67ad471057a89e94dad9421d51c0d50db2d0166219ac423f7cd13d6942cfe78336ac28287cdcbc9f4bdf3a9ba36c1b71668e92762958b7)).

Art. 4º A tabela de Cargos Comissionados, constante no Anexo II da Resolução TRE-AC n. 1.770/2021 ([0460562](https://sei.tre-ac.jus.br/sei/controlador.php?acao=protocolo_visualizar&id_protocolo=491419&id_procedimento_atual=614067&infra_sistema=100000100&infra_unidade_atual=110000988&infra_hash=c7f4e1dc68fe9f6973ec0a531fe7715176af9771787e3226447e82d1d7dce36d3c38ac293dcf19251d67ad471057a89e94dad9421d51c0d50db2d0166219ac423f7cd13d6942cfe78336ac28287cdcbc9f4bdf3a9ba36c1b71668e92762958b7)), passará a ser a constante no Anexo II desta Resolução.

Art. 5º A tabela de Funções Comissionadas, constante no Anexo III da Resolução TRE-AC n. 1.770/2021 ([0460562](https://sei.tre-ac.jus.br/sei/controlador.php?acao=protocolo_visualizar&id_protocolo=491419&id_procedimento_atual=614067&infra_sistema=100000100&infra_unidade_atual=110000988&infra_hash=c7f4e1dc68fe9f6973ec0a531fe7715176af9771787e3226447e82d1d7dce36d3c38ac293dcf19251d67ad471057a89e94dad9421d51c0d50db2d0166219ac423f7cd13d6942cfe78336ac28287cdcbc9f4bdf3a9ba36c1b71668e92762958b7)), passará a ser a constante no Anexo III desta Resolução.

Art. 6º O Regulamento da Secretaria deverá ser ajustado aos termos desta resolução, no prazo de 90 (noventa) dias.

Art. 7º Esta Resolução entrará em vigor na data de sua publicação.

Plenário do Tribunal Regional Eleitoral do Acre, em Rio Branco,  \_\_de \_\_\_\_\_\_ de 2023\.

---

**ANEXO I DA RESOLUÇÃO TRE-AC N.\_\_\_\_**

**ORGANOGRAMA**

(A SER INCLUÍDO)  
   
   
**ANEXO II DA RESOLUÇÃO TRE-AC N.\_\_\_\_**

**CARGOS COMISSIONADOS**

| UNIDADES \\ CARGOS EM COMISSÃO | DIRETORIA-GERAL | SECRETARIAS | ASSESSOR III | PREGOEIRO | COORDENADORIAS | ASSESSOR II | CHEFE DE GABINETE | ASSESSOR I |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|  | CJ4 | CJ3 | CJ3 | CJ2 | CJ2 | CJ2 | CJ2 | CJ1 |
| PRESIDÊNCIA | - | - | 01 | - | - | 01 | 01 | 01 |
| VICE-PRESIDÊNCIA/CORREGEDORIA REGIONAL ELEITORAL | - | - | - | - | 01 | 01 | 01 | - |
| ESCOLA JUDICIÁRIA ELEITORAL | - | - | - | - | - | - | - | - |
| COORDENADORIA DE CONTROLE INTERNO E AUDITORIA | - | - | - | - | 01 | - | - | - |
| SECRETARIA DO TRIBUNAL | 01 | - | 03 | - | 01 | 01 | 01 | 02 |
| SECRETARIA JUDICIÁRIA | - | 01 | - | - | 02 | - | - | - |
| SECRETARIA DE ADMINISTRAÇÃO, ORÇAMENTO E FINANÇAS | - | 01 | - | 01 | 03 | - | - | 01 |
| SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO | - | 01 | - | - | 02 | - | - | - |
| **TOTAL** | **01** | **03** | **04** | **01** | **10** | **03** | **03** | **04** |
|  | **01** | **07** |  | **17** |  |  |  | **04** |

**ANEXO III DA RESOLUÇÃO TRE-AC N.\_\_\_\_**

**FUNÇÕES COMISSIONADAS**

| UNIDADES \\ FUNÇÕES COMISSIONADAS | CHEFE DE SEÇÃO | ASSISTENTE VI | OFICIAL DE GABINETE I | ASSISTENTE V | ASSISTENTE I |
| :---: | :---: | :---: | :---: | :---: | :---: |
|  | FC6 | FC6 | FC5 | FC5 | FC1 |
| PRESIDÊNCIA | - | 02 | - | 01 | - |
| VICE-PRESIDÊNCIA/CORREGEDORIA REGIONAL ELEITORAL | 03 | - | - | - | 03 |
| ASSISTÊNCIA AOS JUÍZES MEMBROS | - | 05 | - | - | - |
| ESCOLA JUDICIÁRIA ELEITORAL | - | 01 | - | - | - |
| SECRETARIA DO TRIBUNAL | - | - | 01 | 01 | - |
| SECRETARIA JUDICIÁRIA | 06 | - | 01 | - | 04 |
| COORDENADORIA DE CONTROLE INTERNO E AUDITORIA | 03 | - | - | - | 02 |
| COORDENADORIA DE GESTÃO DE PESSOAS | 05 | - | - | - | 03 |
| SECRETARIA DE ADMINISTRAÇÃO, ORÇAMENTO E FINANÇAS | 10 | - | 01 | - | 12 |
| SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO | 05 | 02 | 01 | - | 02 |
| **TOTAL** | **32** | **10** | **04** | **02** | **26** |
|  | **42** |  | **06** |  | **26** |

---

Despacho nº 0593915 / 2023 - PRESI/DG/GADG

Senhor Presidente,

Em cumprimento ao Despacho GAPRES 059388, foram realizadas reuniões individualizadas, com o objetivo de colher informações das unidades SEJUD, COCIN e COGEP, sobre eventuais necessidades de criação ou transformação de cargos em comissão (CJ) nessas unidades, visando subsidiar a Diretoria-Geral na análise de adequação da proposta anteriormente apresentada.

Diante do que consta nas atas 0596923, 0596944 e 0596950, percebe-se, de forma clara, que as necessidades do Tribunal como um todo, no que diz respeito a recursos humanos, são muito superiores à capacidade de resolução por meio do aproveitamento das sobras de CJ atualmente existentes.

Os apontamentos trazidos pelos titulares das unidades descrevem uma situação ideal, que exigiria do Tribunal uma reforma do organograma em grandes dimensões, e com disponibilidade orçamentária muito maior, inclusive com criação de secretaria, coordenadoria e seções, o que não se mostra factível neste momento. 

Sendo assim, dentro do que é possível realizar presentemente, foram consideradas as prioridades definidas pela Presidência.

De início, registre-se não ser possível a utilização das sobras de CJ para criação de funções comissionadas (FC), o que é impeditivo para a criação de novas seções, consoante previsto no parágrafo único do art. 24 da Lei n. 11.416/2006, combinado com a Resolução TSE n. 23.698, de 22 de abril de 2022.

Assim sendo, as sobras devem ser direcionadas para a criação e/ou transformação de cargos em comissão, cuja competência é do Pleno do Tribunal, na forma do inciso IV do art. 17 do Regimento Interno deste TRE, tendo como relator o Presidente, conforme preceitua o inciso V do art. 19, combinado com o art. 59 do Regimento citado.

a proposta apresentada pela diretoria-geral (0584099) para atender as diretrizes superiores levou em conta fatos ocorridos durante a gestão 2021/2023, com graves consequências nos processos de licitação, de eleições e nos resultados da gestão da qualidade, constituindo-se em desafios estratégicos para a atual e a futura administração do tribunal. 

Além disso, a proposta visa o aperfeiçoamento da gestão administrativa, buscando atingir a produtividade ideal, celeridade necessária e adequação jurídica nos processos administrativos e na gestão de gastos públicos.

Ao mesmo tempo, objetiva a realização das ações que constam no  Plano de Gestão 2021-2023, nos processos iniciados na atual gestão e de caráter contínuo, tais como licitações mais céleres, execução orçamentária eficiente, aderência orçamentária e contratação em tempo.

Em que pese as demandas, em sua maioria legítimas, apresentadas pelas unidades SEJUD, COCIN e COGEP, não há como transpor a limitação financeira relacionada às sobras de CJ, que representam apenas 35% do valor integral, fato que, por si só, já impede o atendimento de todas as necessidades do Tribunal, em termos de estrutura organizacional, e que nos afasta na situação ideal de funcionamento de muitas unidades.

Resta, portanto, o atendimento às demandas mais graves e urgentes, ficando as demais para momento mais oportuno e possível.

As justificativas que subsidiam a priorização de criação das CJ sugeridas, estão, de forma detalhada, por unidade, contidas no evento 0579084, inclusive as transformações de CJ, que, ressalto, resultam de aproveitamento de valor residual, insuficiente para criação de novos CJ  com valor integral, além dos já propostos, podendo ser aproveitado para acréscimo na remuneração dos assessores da Presidência, Corregedoria e Diretoria-Geral, nesta ordem, e, após, dos chefes desses mesmos gabinetes.

Além disso, a proposta propicia à Administração maior flexibilidade em relação ao uso das sobras de CJ, com rigoroso controle por parte da COGEP e SAOF, uma vez que os CJ transformados podem, a qualquer tempo, sofrer nova modificação, para atendimento a outros direcionamentos emanados da Presidência do Tribunal. 

Diante do exposto, esta Diretoria-Geral mantém a proposta de criação e transformação de CJ apresentada à Presidência, sugerindo, desta feita, que seja incluída a mudança de nomenclatura da SELEG para SAREMI, conforme solicitado pela COGEP, e a mudança de subordinação da unidade Pregão para a SAOF.

Sugere-se, por fim, que seja dado prazo de 30 (trinta) dias para que as unidades impactadas apresentem as respectivas mudanças regimentais necessárias.

É o que submeto à Presidência.

---

evento: Certidão 0598597


Certifico, em atenção ao Despacho GAPRES n. 0598366, que foram juntadas a este Procedimento cópias da Resolução TRE-AC n. 1.781/2023 (evento n. 0598595), relativa à Instrução n. 0600181-13.2023.6.01.0000, bem como da certidão de publicação da referida norma (evento n. 0598670), ocorrida nesta data, no Diário da Justiça Eletrônico n. 125, páginas 03 a 08. Certifico, ainda, que a aludida resolução - que "Altera a estrutura orgânica do Tribunal Regional Eleitoral do Acre, aprovada pela Resolução TRE-AC n. 1.770/2021 e modificada pela Resolução TRE-AC n. 1.777/2022." - foi disponibilizada na página deste Tribunal na internet (link https://www.tre-ac.jus.br/legislacao/resolucoes-tre). Dou fé.

---

Despacho nº 0598680 / 2023 - PRESI/GAPRES

Cuida-se da expedição da Resolução n. 1.781/2023 cujo teor altera a estrutura orgânica do Tribunal Regional Eleitoral do Acre, aprovada pela Resolução TRE-AC n. 1.770/2021 e modificada pela Resolução TRE-AC n. 1.777/2022.

Encaminhe-se à Diretoria-Geral para as providências destinadas à implementação da mencionada norma.

Desembargador FRANCISCO DJALMA
Presidente

---

Portaria Presidência Nº 154/2023 PRESI/GAPRES

O DESEMBARGADOR FRANCISCO DJALMA, PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

TENDO EM VISTA a necessidade de se implementar as atividades do Tribunal Regional Eleitoral do Acre para o biênio 2021/2023;

TENDO EM VISTA a aprovação da Resolução TRE/AC 1.781/2023  que instituiu a nova estrutura orgânica do Tribunal Regional Eleitoral do Acre;

TENDO EM VISTA o que consta no processo SEI nº 0000692-19.2023.6.01.8000,

R  E  S  O  L  V  E:

Art. 1º. EXONERAR a servidora MARIA VERÔNICA DA COSTA do Cargo em Comissão de Assessor II, Código CJ2, da Presidência, nos termos do item XIV do Art. 2º da Portaria Presidência 141, de 12 de agosto de 2021; LOTÁ-LA na Assessoria da Presidência e NOMEÁ-LA para ocupar o Cargo em Comissão de Assessor Jurídico, Código CJ3, Nível III;

Art. 2º. EXONERAR a servidora KAREN MESQUITA DA SILVA TEIXEIRA DA ROCHA do Cargo em Comissão de Chefe de Gabinete, Código CJ1, do Gabinete da Presidência, nos termos do item XIII do Art. 2º da Portaria Presidência 141, de 12 de agosto de 2021; LOTÁ-LA no Gabinete da Presidência e NOMEÁ-LA para ocupar o Cargo em Comissão de Chefe de Gabinete, Código CJ2, Nível II;

Art. 3º. EXONERAR a servidora DANIELE CARLOS DE OLIVEIRA NUNES do Cargo em Comissão de Assessor I, Código CJ1, da Assessoria de Comunicação Social, nos termos do item II do Art. 5º da Portaria Presidência 151, de 18 de agosto de 2021; LOTÁ-LA na Assessoria de Comunicação Social e NOMEÁ-LA para ocupar o Cargo em Comissão de Assessor, Código CJ2, Nível II;

Art. 4º. EXONERAR a servidora LUCIANA DE ARRUDA MACEDO SANTOS do Cargo em Comissão de Assessor I, Código CJ1, da Corregedoria Regional Eleitoral, nos termos do item II do Art. 5º da Portaria Presidência 191, de 16 de setembro de 2022; LOTÁ-LA na Assessoria da Corregedoria Regional Eleitoral e NOMEÁ-LA para ocupar o Cargo em Comissão de Assessor Jurídico, Código CJ2, Nível II;

Art. 5º. EXONERAR a servidora ELMA LARISSA NUNES DOS SANTOS FERREIRA, Técnico Judiciário do Tribunal de Justiça do Estado do Acre, do Cargo em Comissão de Chefe de Gabinete, Código CJ1, da Corregedoria Regional Eleitoral, nos termos do item III do Art. 5º da Portaria Presidência 191, de 16 de setembro de 2022; LOTÁ-LA no Gabinete da Corregedoria Regional Eleitoral e NOMEÁ-LA para ocupar o Cargo em Comissão de Chefe de Gabinete, Código CJ2, Nível II;

Art. 6º. EXONERAR o servidor CARLOS ALBERTO CIDRAL do Cargo em Comissão de Assessor II, Código CJ2, da Assessoria Jurídica da Diretoria-Geral, nos termos do item X do Art. 2º da Portaria Presidência 141, de 12 de agosto de 2021; LOTÁ-LO na Assessoria Jurídica e NOMEÁ-LO para ocupar o Cargo em Comissão de Assessor Jurídico Chefe, Código CJ3, Nível III;

Art. 7º. EXONERAR o servidor BRENO BEZERRA DE SOUZA do Cargo em Comissão de Assessor I, Código CJ1, da Assessoria Jurídica da Diretoria-Geral, nos termos do Art. 3º da Portaria Presidência n. 241/2021, de 09 de dezembro de 2021; LOTÁ-LO na Assessoria Jurídica e NOMEÁ-LO para ocupar o Cargo em Comissão de Assessor Jurídico, Código CJ2, Nível II;

Art. 8º. EXONERAR a servidora VALÉRIA ASSIS LIMA do Cargo em Comissão de Chefe de Gabinete, Código CJ1, do Gabinete da Diretoria-Geral, nos termos do item XII do Art. 2º da Portaria Presidência 141, de 12 de agosto de 2021; LOTÁ-LA no Gabinete da Diretoria-Geral e NOMEÁ-LA para ocupar o Cargo em Comissão de Chefe de Gabinete, Código CJ2, Nível II;

Art. 9º. EXONERAR o servidor JOSÉ FRANCISCO DA SILVA GALVÃO do Cargo em Comissão de Assessor II, Código CJ2, da Assessoria de Planejamento, Estratégia e Gestão, nos termos do Art. 2º da Portaria Presidência n. 4, de 2 de agosto de 2020; LOTÁ-LO na Assessoria de Planejamento, Estratégia e Gestão e NOMEÁ-LO para ocupar o Cargo em Comissão de Assessor, Código CJ3, Nível III;

Art. 10º. EXONERAR o servidor FERNANDO JORGE DA SILVA E SOUSA da Função Comissionada de Assistente I, Código FC1, da Seção de Suporte ao Usuário da Secretaria de Tecnologia da Informação.

Art. 11º. Esta portaria produzirá efeitos a partir desta data.

Publique-se e cumpra-se com as cautelas necessárias.

Desembargador FRANCISCO DJALMA
Presidente

Rio Branco, 18 de julho de 2023.

---

Portaria Presidência Nº 153/2023 PRESI/GAPRES

O DESEMBARGADOR FRANCISCO DJALMA, PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

TENDO EM VISTA a necessidade de implementação das atividades do Tribunal Regional Eleitoral do Acre para o biênio 2021/2023;

TENDO EM VISTA a aprovação da Resolução TRE/AC n. 1.781/2023, que instituiu a nova estrutura orgânica do Tribunal Regional Eleitoral do Acre;

TENDO EM VISTA o que dispõe o Art. 35 da Lei n. 8.112, de 11 de dezembro de 1990;

TENDO EM VISTA o que consta no Processo SEI n. 0000692-19.2023.6.01.8000,

R  E  S  O  L  V  E:

Art. 1º. DISPENSAR os servidores abaixo relacionados das funções de confiança descritas neste artigo.

I - a servidora ELLEN CRISTINA SILVA DE OLIVEIRA da função comissionada de Oficial de Gabinete, Código FC5, do Gabinete da Secretaria de Administração, Orçamento e Finanças, a qual foi designada por meio da Portaria Presidência 141/2021.

II - o servidor ROBSON GOES CORDEIRO da função comissionada de Assistente I, Código FC1, da Seção de Compras, Licitações e Contratos da Coordenadoria de Material e Patrimônio, o qual foi designado por meio da Portaria Presidência 141/2021.

III - o servidor SILVIO FORASTIERO FRAZÃO da função comissionada de Assistente de Cibersegurança, Código FC6, do Gabinete da Secretaria de Tecnologia da Informação, o qual foi designado por meio da Portaria Presidência 241/2021.

Art. 2º. LOTAR a servidora ELLEN CRISTINA SILVA DE OLIVEIRA na Assessoria de Governança e Planejamento da Secretaria de Administração, Orçamento e Finanças - ASGOVSAOF e NOMEÁ-LA para ocupar o cargo em Comissão de Nível 1 - CJ1, da referida unidade.

Art. 3º. LOTAR os servidores relacionados neste artigo nas unidades descritas e DESIGNÁ-LOS para exercer as funções comissionadas abaixo relacionadas.

I - o servidor ROBSON GOES CORDEIRO na Seção de Gestão de Contratos - SGEC, da Coordenadoria de Material e Patrimônio, e designá-lo para exercer a função comissionada de Chefe de Seção, Código FC6.

II - o servidor SILVIO FORASTIERO FRAZÃO na Seção de Cibersegurança - SCSEG, da Coordenadoria de Infraestrutura, e designá-lo para ocupar a função comissionada de Chefe de Seção, Código FC6.

Art. 4º. Esta portaria produzirá efeitos a partir de sua publicação.

Publique-se e cumpra-se com as cautelas necessárias.

Desembargador FRANCISCO DJALMA
Presidente

Rio Branco, 17 de julho de 2023.
  
---

Decisão nº 641 / 2023 - PRESI/ASPRES

Trata-se de procedimento instaurado pela atual Administração, visando a submeter à aprovação da Corte, proposta de Resolução objetivando alterar a Resolução TRE-AC n. 1.770/2021, modificada pelas Resoluções TRE-AC n. 1.777/2022 e n. 1.781/2023, que dispõe sobre a estrutura orgânica e a lotação dos cargos em comissão e funções comissionadas deste Tribunal Regional Eleitoral.

A presente reestruturação foi iniciada pela Secretaria de Administração, Orçamento e Finanças (0616333), a partir dos anexos de eventos 0616283, 0616285 e 0616287 e minuta de resolução 0616415.

No curso do procedimento a Coordenadoria de Gestão de Pessoas-COGEP (0619717); A Escola Judiciária Eleitoral-EJE (0616489) e  a Assistência de Sustentabilidade, Acessibilidade e Inclusão – ASSAI, por meio do procedimento SEI 0001896-98.2023.6.01.8000, formularam pedido de reestruturação, criação de funções comissionadas e de assistência. Também consta pedido de estruturação do Núcleo de Inteligência de Segurança Institucional - SEI nº SEI 0001785-17.2023.6.01.8000.

Com relação à estruturação reivindicadas pelas Unidades acima, a Diretoria-Geral manifestou-se no evento (0621556), sugerindo a deflagração de estudos para a proposição de estrutura ideal das unidades administrativas da Secretaria do Tribunal, a partir de uma análise aprofundada, alinhada aos demais Regionais, com posterior envio ao TSE.

O Secretário de Administração, Orçamento e Finanças juntou nova minuta corrigida 0626460.

A Assessoria Jurídica da Diretoria-Geral apresentou Parecer constante do evento 0626374.

Retornado os autos à Secretaria de Administração, Orçamento e Finanças, este informou no evento 0631799 que a proposta de alteração não importa em aumento de despesa, conforme demonstrado nas planilhas juntadas nos eventos 0626250 e 0626264. Acrescentou ainda não ser necessário homologação da alteração da estrutura por parte do Tribunal Superior Eleitoral, pois tal exigência foi suprimida por meio da Resolução TSE n. 23.683, de 22 de fevereiro de 2022, que acrescentou o § 3º ao art. 9º da Resolução TSE n. 22.138/2005.

Encaminhados os autos à Diretoria-Geral, esta também entendeu desnecessário o envio da reestruturação pretendida ao Tribunal Superior Eleitoral (0631938).

É o relato do necessário.

O presente procedimento versa sobre medidas providenciais visando a submeter à aprovação da Corte proposta de alteração mínima e pontual da estrutura orgânica e a lotação dos cargos em comissão e funções comissionadas deste Tribunal Regional Eleitoral para melhor suprir as necessidades do serviço.

Fato é que, não obstante a recente reestruturação aprovada na Corte, atualmente, as contratações em curso para realização de inúmeras obras, tais como reforma e ampliação do depósito de urnas, reforma das Sedes das 4ª, 5ª e 7ª Zonas Eleitorais, expansão das instalações da Sede deste TRE para o 4º andar, instalação da usina de geração de energia fotovoltaica, dentre outras, estão a evidenciar que o quadro de servidores deste Regional se apresenta defasado, o que se observa no dia-a-dia, pelo acúmulo de demandas e insuficiência do material humano para supri-las,  podendo citar o exemplo do número reduzido de profissionais com formação em engenharia civil, para acompanhamento das obras e intervenção prévia em outros procedimentos licitatórios a serem deflagrados oportunamente, já que um dos engenheiros civis que compõem o quadro de pessoal foi removido para o TRE/GO.

Noutro vértice, dado o volume de serviço na assessoria da presidência deste Sodalício, faz-se necessário o reforço da equipe para dar cabo às inúmeras demandas que chegam e que necessitam uma célere análise, garantindo um padrão aceitável de eficiência e resolutividade.

Quanto às manifestações das demais unidades, não há dúvidas de que estas e muitas outras precisam de melhorias na sua estrutura compatível com os moldes dos Tribunais Regionais Eleitorais do país que prestam um serviço de qualidade e assim obtém boa qualificação no programa do selo de qualidade do CNJ, de modo que antevejo necessidade de criação de cargos efetivos e cargos de confiança e funções comissionadas, tanto no segundo quanto no primeiro grau de jurisdição.

Prova disso é o numero elevado de servidores requisitados de órgãos da administração pública municipal, estadual e federal, algumas negadas, conforme  processo SEI nº 0000677-47.2023.6.01.8001. Recentemente estive no Palácio Rio Branco (12.12.2023), onde fiz a entrega de diversos expedientes ao próprio Governador do Estado, que tratam de renovações de requisições de servidores à Justiça Eleitoral aguardando deferimento.

Registro que através do processo SEI nº 0002829-42.2021.6.01.8000 foi realizado o levantamento das necessidades de provimento de cargos efetivos, funções comissionadas e cargos em comissão na Secretaria e Cartórios Eleitorais deste Tribunal, sendo encaminhado ao Presidente do Tribunal Superior Eleitoral (0486246) referida proposta para envio ao Congresso Nacional.

Por intermédio do Ofício GAB-DG nº 2715/2022 (0505405 e anexo 0505403) a Corte Superior Eleitoral encaminhou a este Regional a análise técnica apresentada pela Secretaria de Planejamento, Orçamento, Finanças e Contabilidade daquele Tribunal Superior acerca do levantamento das necessidades de provimento de cargos na Secretaria e nos Cartórios Eleitorais deste Regional, que por sua importância cabe a sua transcrição da parte conclusiva:

“Diante do exposto, submete-se o assunto à apreciação superior, com sugestão de que o TRE/AC seja informado de que não há disponibilidade orçamentária para a criação de cargos efetivos e de cargos e funções comissionadas nos exercícios financeiros de 2022 e 2023 e da necessidade de observância dos limites da LRF, considerada ainda a perspectiva de realização de revisões gerais nesse período. Ainda, caso seja interesse da Alta Administração, sejam realizados estudos preliminares pela SGP para verificação do impacto e da possibilidade se criar cargos efetivos no âmbito desta Justiça Especializada em anos vindouros, nos termos dos itens 10 a 18 desta Informação e da minuta de ofício anexa.

Como se verifica, o Tribunal Superior Eleitoral informou que, por questão orçamentária e respeito aos limites impostos pela Lei de Responsabilidade Fiscal, impossibilitava o atendimento das necessidades deste Tribunal com relação à criação de cargos efetivos e de cargos e funções comissionadas nos exercícios financeiros de 2022 e 2023, deixando em aberto a possibilidade de atendimento nos exercícios financeiros seguintes. Isso nos autoriza a postular novamente a criação de cargos e funções com vistas aos exercícios de 2024 e 2025.

Portanto, determino a reabertura do SEI 0002829-42.2021.6.01.8000 para fins de atualização das necessidades de estruturação das unidades deste Regional,  com relação ao provimento de cargos efetivos, funções comissionadas e cargos em comissão na Secretaria e Cartórios Eleitorais deste Tribunal.

A atualização das necessidades de criação e cargos efetivos e comissionados realizadas no SEI 0002829-42.2021.6.01.8000 decorre da modificação do cenário, isso porque consta da planilha (0483473) o pedido de criação de cargo para arquivista. No entanto, em data de 05.12.2023 foi baixada a Portaria nº 308/2023 (0630167), publicada no Diário da Justiça Eletrônico nº 216, de 07.12.2023, página 2/3, alterando a área de atividade do cargo de Analista Judiciário - Área Judiciária do quadro de pessoal permanente da Secretaria deste Tribunal vago em para Analista Judiciário – Área Apoio Especializado – Especialidade Arquivologia, a ser provido por meio do concurso unificado a ser realizado pelo TSE, importando em supressão daquele pedido em nova planilha a ser apresentada.

Para a atualização das necessidades de criação de cargos efetivos e cargos comissionados convoco o Grupo de Trabalho constituído pela Portaria Presidência nº 248/2021 (0466865), representado pelos seus atuais titulares, para no prazo de 15 (quinze) dias, contados a partir do final do recesso forense, realizar a tarefa de atualização das planilhas constantes do SEI nº 0002829-42.2021.6.01.8000.

Concluído esse levantamento será novamente oficiado ao Tribunal Superior Eleitoral reiterando a solicitação de criação de cargos efetivos, cargos comissionados e funções comissionadas.

Desta forma, havendo resposta positiva da Corte Superior Eleitoral, as reivindicações da COGEP, EJE, ASSAI e NISI serão possíveis de serem concretizadas.

Translade-se cópia desta Decisão para o SEI nº 0002829-42.2021.6.01.8000. Após, dê-se ciência aos atuais titulares dos cargos mencionados pela Portaria Presidência nº 248/2021 (0466865) quanto à incumbência estabelecida nesta Decisão.

No tocante ao presente procedimento, dou por finalizada a instrução do presente feito.

Encaminhe-se o feito à Secretaria Judiciária para, a partir do ID 0616283, autuar no PJe e distribuir a esta Presidência, a fim de ser levada, em mesa, para apreciação do Plenário a modificação proposta na sessão do dia 18.12.2023.

Ao depois, conclusos.

Des. JÚNIOR ALBERTO

Presidente do TRE/AC

---

Portaria Presidência Nº 14/2024 PRESI/GAPRES

O PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, DESEMBARGADOR JÚNIOR ALBERTO, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

CONSIDERANDO a necessidade de implementação das atividades do Tribunal Regional Eleitoral do Acre para o biênio 2023/2025;

CONSIDERANDO a reapresentação do servidor Robson Goes Cordeiro ao Governo do Estado do Acre ( 0635358), em 29 de dezembro de 2023;

CONSIDERANDO o que dispõe o Art. 35 da Lei n. 8.112, de 11 de dezembro de 1990;

CONSIDERANDO o que consta no Processo SEI n. 0000692-19.2023.6.01.8000,

R  E  S  O  L  V  E:

Art. 1º REVOGAR o item I, do Art. 3º da Portaria Presidência n. 153/2023 PRESI/GAPRES (0599190), que lotou o servidor Robson Goes Cordeiro, na Seção de Gestão de Contratos - SGEC, da Coordenadoria de Material e Patrimônio, e o designou para exercer a função comissionada de Chefe de Seção, Código FC6;

Art. 2º REVOGAR o inciso XXVII do Art. 2º da Portaria Presidência n. 141/2021 PRES/GAPRES (0436519), que lotou o servidor Manoel Raimundo de Souza, Técnico Judiciário, Área Administrativa, na Seção de Protocolo da Coordenadoria de Serviços Gerais e o designou para exercer a função comissionada de Chefe de Seção, Código FC6;

Art. 3º. LOTAR o servidor Manoel Raimundo de Souza, Técnico Judiciário, Área Administrativa, na Seção de Gestão de Contratos - SGEC, da Coordenadoria de Material e Patrimônio, e o designá-lo para exercer a função comissionada de Chefe de Seção, Código FC6;

Art. 4º. Esta portaria entra em vigor na data de sua publicação, com efeitos retroativos a contar de 29 de dezembro de 2023.

Publique-se e cumpra-se com as cautelas necessárias.

Desembargador JÚNIOR ALBERTO
Presidente

Rio Branco, 12 de janeiro de 2024.

---

Portaria Presidência Nº 15/2024 PRESI/GAPRES

O PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, DESEMBARGADOR JÚNIOR ALBERTO, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

CONSIDERANDO a necessidade de se implementar as atividades do Tribunal Regional Eleitoral do Acre para o biênio 2023/2025;

CONSIDERANDO o que consta no documento SEI nº 0000692-19.2023.6.01.8000, 

R  E  S  O  L  V  E:

Art. 1º. REVOGAR a Portaria Presidência n. 203/2021 PRESI/GAPRES, (0450554), que designou o servidor Rodolfo Elias Quiroga​, Arquiteto e Urbanista, do quadro de pessoal da Secretaria de Estado de Desenvolvimento Urbano e Regional - SEDUR, para exercer a função comissionada de Chefe da Seção de Obras e Manutenção dos Imóveis (SOMI), código FC6.

Art. 2º. LOTAR o servidor Rodolfo Elias Quiroga​, Arquiteto e Urbanista, do quadro de pessoal da Secretaria de Estado de Desenvolvimento Urbano e Regional - SEDUR, na Assessoria de Gestão de Imóveis - ASGIM, e designá-lo para exercer a função comissionada de Assistente VI, Código FC6, da referida Assessoria.

Art. 3º. Esta portaria entra em vigor na data de sua publicação, com efeitos retroativos a contar de 29 de dezembro de 2023..

Publique-se e cumpra-se com as cautelas necessárias.

Desembargador JÚNIOR ALBERTO
Presidente

Rio Branco, 12 de janeiro de 2024.

---

Portaria Presidência Nº 16/2024 PRESI/GAPRES

O PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, DESEMBARGADOR JÚNIOR ALBERTO, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

CONSIDERANDO a necessidade de se implementar as atividades do Tribunal Regional Eleitoral do Acre para o biênio 2023/2025;

CONSIDERANDO o que consta no documento SEI nº 0000692-19.2023.6.01.8000, 

R  E  S  O  L  V  E:

Art. 1º. REVOGAR a Portaria Presidência n. 271/2021 PRESI/GAPRES, (0395553), que manteve a lotação da servidora Suellen da costa Vieira Soler​, ocupante do cargo de Analista Judiciário, área administrativa, especialidade Engenharia, na Seção de Obras e Manutenção de Imóveis (SOMI) da Coordenadoria de Serviço Gerais (COSEG) e a designou para exercer a função comissionada de Assistente I, código FC1.

Art. 2º. LOTAR a servidora Suellen da costa Vieira Soler​, ocupante do cargo de Analista Judiciário, área administrativa, especialidade Engenharia, na Assessoria de Gestão de Imóveis - ASGIM, e designá-lo para exercer a função comissionada de Assistente I, Código FC1, da referida Assessoria.

Art. 3º. Esta portaria entra em vigor na data de sua publicação, com efeitos retroativos a contar de 29 de dezembro de 2023.

Publique-se e cumpra-se com as cautelas necessárias.

Desembargador JÚNIOR ALBERTO
Presidente

Rio Branco, 12 de janeiro de 2024.

</0000692-19.2023.6.01.8000>

---

<0001971-11.2021.6.01.8000>  

Despacho nº 0442332 / 2021 - PRESI/DG/GADG

Considerando a crescente demanda de alocação de servidores para atividades que exigem dedicação exclusiva, originárias de recomendações do Conselho Nacional De Justiça e Tribunal Superior Eleitoral, e as dificuldades para suprir tais indicações, além de atender as diversas comissões e núcleos de trabalho subordinados à Presidência do Tribunal, inicio este procedimento com o fim de propor que sejam analisadas as atuais Funções Comissionadas - FC1 vagas, constantes no evento  0442331, visando à redistribuição/junção na estrutura desta Secretaria, para atender às demandas nas atividades do Tribunal.

À SAO, COGEP e ASJUR, para manifestação.

Rosana Magalhães da Silva
Diretora-Geral

---

</0001971-11.2021.6.01.8000>  

---

<0000251-33.2026.6.01.8000>  

PORTARIA	PRESIDÊNCIA	Nº	311/2025	PRESI/GAPRES
O	Vice-Presidente,	no	exercício	da	Presidência	do	Tribunal	Regional	Eleitoral	no	Estado	Acre, Desembargador	LOIS	ARRUDA,	no	uso	das	atribuições	legais,	destacando-se,	neste	particular,	as	disposições contidas	no	Art.	19,	XI,	XII	e	XIII	c/c	LV	e	LVII,	do	Regimento	Interno	e, Considerando	o	contido	no	processo	SEI	0000202-26.2025.6.01.8000, 

R	E	S	O	L	V	E:

Art.	1º.	Exonerar	o	servidor	Rafael	Costa	Marinho	do	Cargo	em	Comissão	de	Assessor	I,	Código	CJ-1, vinculado	à	Assessoria	de	Planejamento,	Estratégia	e	Gestão.
Art.	2º.	Esta	portaria	produzirá	efeitos	a	partir	do	dia	04	de	dezembro	de	2025.

Publique-se	e	cumpra-se	com	as	cautelas	necessárias.
Desembargador	LOIS	ARRUDA,
Vice-Presidente	e	Corregedor	Regional	Eleitoral,	no	exercício	da	Presidência.
Rio	Branco,	03	de	dezembro	de	2025

---

Despacho nº 0840686 / 2026 - PRESI/DG/ASPLAN

Senhora Diretora-Geral, 

Considerando a exoneração do servidor Rafael Costa Marinho do cargo em comissão de Assessor I, Código CJ1, vinculado à Assessoria de Planejamento, Estratégia e Gestão, solicito a indicação de servidor para ocupação do aludido cargo, a fim de dar continuidade aos trabalhos desta Assessoria. 

Respeitosamente, 

---

Despacho nº 0840839 / 2026 - PRESI/DG/GADG

A Assessoria de Planejamento, Estratégia e Gestão (ASPLAN), por meio do Despacho n. 0840686, solicita a indicação de servidor para ocupar o cargo em comissão de Assessor I, Código CJ-1, vinculado à referida unidade, em razão da exoneração do servidor Rafael Costa Marinho.

Após tratativas desta Diretoria-Geral com a Secretaria de Tecnologia da Informação, e estando as áreas de acordo, indica-se o servidor José Jair Cavalcante de Figueiredo para exercer o mencionado cargo.

Encaminhe-se ao Gabinete da Presidência para conhecimento e providências cabíveis, com ciência aos interessados.

---

Portaria Presidência Nº 14/2026 PRESI/GAPRES

A Desembargadora Waldirene Cordeiro, Presidente do Tribunal Regional Eleitoral do Acre, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, LV e LVII, do Regimento Interno,

Considerando o contido no processo sei n. 0000251-33.2026.6.01.8000,

R E S O L V E:

Art. 1º. Dispensar o servidor José Jair Cavalcante de Figueiredo a Função de Confiança de Assistente I, código FC-1, da Seção de Desenvolvimento e Banco de Dados (SDBD), para qual foi designado por meio da Portaria Presidência n. 242/2025.

Art. 2º. Lotar o referido servidor na Assessoria de Planejamento, Estratégia e Gestão, e designá-lo para exercer o Cargo em Comissão de Assessor I, código CJ-1, da mencionada seção.

Art. 3º. Esta Portaria entra em vigor na data de sua publicação.

Publique-se e cumpra-se com as cautelas necessárias.

Desembargadora Waldirene Cordeiro

Presidente do Tribunal Regional Eleitoral do Acre

Rio Branco, 28 de janeiro de 2026.

</0000251-33.2026.6.01.8000>  

---

<0002067-50.2026.6.01.8000>  

</0002067-50.2026.6.01.8000>  

---

<0000690-49.2023.6.01.8000>  

# Transferência de autorização. Provimento de Cargos entre TRE's.Concurso Remoção 2023.

---

TRIBUNAL REGIONAL ELEITORAL DO PARA
RUA JOÃO DIOGO, 288 - Bairro CAMPINA - CEP 66015902 - Belém - PA
Ofício-Circular nº 84 / 2023 - TRE/PRE/DG/SGP/CODES/SGD
As Suas Excelências as(os) Senhoras(es)
Presidentes dos Tribunais Regionais Eleitorais 
Assunto: Provimento de Cargos - Portaria nº 244, de 31 de março de 2023
Senhoras(es) Presidentes:
Belém, 04 de abril de 2023.
Com cordiais cumprimentos, como é de conhecimento geral, a Emenda Constitucional nº 95, de 15 de dezembro de 2016, alterou o Ato das Disposições Constitucionais Transitórias para instituir o Novo Regime Fiscal no âmbito dos Orçamentos Fiscal e da Seguridade Social da União, o que gerou uma série de restrições orçamentárias no âmbito da Justiça Eleitoral.
Por meio da Portaria nº 244, de 31 de março de 2023, o  TSE dispôs sobre a suspensão de provimentos de cargos efetivos vagos no âmbito da Justiça Eleitoral e estabeleceu o quantitativo  para provimento dos cargos, conforme Anexo I da mencionada Portaria, ficando o TRE/PA contemplado com a autorização para provimento de 1 (um) cargo de Analista Judiciário e 3 (três) cargos de Técnico Judiciário.
Por meio do Art. 1º, § 5º, da Portaria citada, o TSE assim se manifestou:
§ 5º Poderá ser realizada a transferência de autorizações dos quantitativos para provimento relativas ao inciso IV,  constantes no Anexo I desta portaria, mediante manifestação
expressa do órgão ofertante, a ser encaminhada ao Tribunal Superior Eleitoral para aprovação, condicionada à existência de saldo não provido.
Como se observa, o novel dispositivo incluído prevê a transferência, entre órgãos da Justiça Eleitoral, de autorizações dos quantitativos para provimento trazidos no mencionado Anexo I, mediante expressa manifestação do órgão ofertante e aprovação do Tribunal Superior Eleitoral, condicionada à existência de saldo não provido.
O TRE/PA  possui, atualmente, 12 (doze) cargos vagos de Técnico Judiciário, com autorização para provimento de 3 (três), conforme estabelece a Portaria nº 244/2023 - TSE.
Diante disto e com fulcro no artigo 1º, § 5º, da Portaria TSE nº 244/2023, consulto Vossas Excelências acerca da possibilidade de transferência das autorizações de provimento dos cargos vagos de Técnico Judiciário constantes no Anexo I da aludida Portaria desse TRE para o TRE/PA, ainda que parcial, tendo em vista que, como ressalvado acima, este Regional
encontra-se impedido de provê-los.

Atenciosamente

---

Despacho nº 0587796 / 2023 - PRESI/GAPRES

Trata-se de Ofício-Circular nº 84 / 2023 - TRE/PRE/DG/SGP/CODES/SGD cujo teor consulta a possibilidade de transferência, para este Regional, das autorizações de provimento dos cargos vagos de Técnico Judiciário do Tribunal Regional Eleitoral do Pará, considerando o impedimento de provê-los (0579038).​

Ao conhecimento da Diretoria-Geral.

Encaminhe-se à Coordenadoria de Gestão de Pessoas.

Desembargador FRANCISCO DJALMA
Presidente

---

Despacho nº 0588349 / 2023 - PRESI/DG/COGEP

Em atendimento ao despacho GAPRES 0587796, levando em consideração a publicação da Portaria TSE nº 244/2023 (0588344), passo a expor:

A referida portaria trata da suspensão de provimentos de cargos efetivos no âmbito da Justiça Eleitoral, bem como estabelece o quantitativo para provimento de 4 (quatro) cargos efetivos para o TRE-AC, sendo 1 (um) de Analista Judiciário e 3 (três) de Técnico Judiciário, observando os parâmetros constantes do § 1º do art. 1º:

VACÂNCIAS COM PROVIMENTOS AUTORIZADOS (§ 1º do art. 1º da Portaria TSE nº 244/2023)

Inciso I	
Vacâncias a partir de 01/04/2022

(art. 33, I, II e VIII, Lei nº 8112/90)

EXONERAÇÃO

DEMISSÃO

POSSE EM OUTRO CARGO INACUMULÁVEL

Incisos II e III	
Vacâncias decorrentes de

READAPTAÇÃO

REVERSÃO

APROVEITAMENTO

REINTEGRAÇÃO

RECONDUÇÃO

CUMPRIMENTO DE SENTENÇA JUDICIAL

Inciso IV	
Vacâncias ocorridas até 31/03/2022 e as dos incisos VII e IV

do art. 33 da Lei nº 8.112/90 ocorridas a qualquer tempo

TODAS, INCLUSIVE AS ORIUNDAS DE APOSENTADORIA E FALECIMENTO

 

Atualmente, temos 9 (nove) cargos efetivos vagos, conforme segue:

CARGOS VAGOS

EX-SERVIDOR

ORIGEM DA VACÂNCIA

DATA DA VACÂNCIA

PORTARIA TSE N. 244/2023

PASSÍVEL DE PROVIMENTO PELA PORTARIA?

 

02 (dois) de Técnicos Judiciários - Apoio Especializado - Programação de Sistemas

 

ARILTON SILVA DE OLIVEIRA

REDISTRIBUIÇÃO - APOSENTADORIA

01/07/2015

art. 1º,§1º, IV

SIM

FRANKLEY FRANCALINO DA ROCHA

REDISTRIBUIÇÃO - POSSE EM CARGO INACUMULÁVEL

09/03/2020

art. 1º,§1º, I

SIM

 

01 (um) de Técnico Judiciário - Apoio Especializado - Digitação

 

RICARDO MELO FILHO

APOSENTADORIA

19/01/2022

art. 1º,§1º, IV

SIM

 

02 (dois) de Técnico Judiciário - Área Administrativa

SAMIRA DOS SANTOS MACHADO

APOSENTADORIA

13/04/2022

art. 1º,§1º, IV

SIM

ERIKA TALITA DO AMARAL

POSSE EM CARGO INACUMULÁVEL

15/12/2022

art. 1º,§1º, I

 

 

01 (um) Analista Judiciário - Apoio Especializado - Análise de Sistemas

 

FRANCISCA DJENANE MARINHO MARQUES

REDISTRIBUIÇÃO - APOSENTADORIA

03/06/2020

art. 1º,§1º, IV

SIM

03 (três) Analista Judiciário - Área Judiciária

DEVANIL MARIA LUIZ

APOSENTADORIA

30/06/2022

art. 1º,§1º, IV

SIM

AGEU DE ALENCAR MIRANDA*

POSSE EM CARGO INACUMULÁVEL

28/04/2023

art. 1º,§1º, I

SIM

LAÍS TOJAL COELHO DE BARROS*

POSSE EM CARGO INACUMULÁVEL

17/04/2023

art. 1º,§1º, I

SIM

*Pendente de publicação de portaria

 

Correlacionando as autorizações com a origem dos cargos vagos, verifica-se a possibilidade de provimento do quantitativo total de cargos autorizados pela Portaria TSE nº 244/2023. Contudo, caso a Administração decida por realizar os provimentos autorizados, é necessária a realização de concurso de remoção interno, bem como a verificação de concursos em outros órgãos com cargos de mesma denominação, visto que este Regional não possui concurso válido.

Por fim, no tocante à transferência de autorizações solicitada pelo TRE-PA através do Ofício-Circular nº 84/2023 (0579038), esta Coordenadoria não é favorável, pois impossibilitaria o provimento de cargos quando da conclusão do iminente concurso unificado, que será realizado pelo TSE ainda em 2023.

Ao GAPRES e ao conhecimento da Direitoria-Geral.

---

Despacho nº 0588430 / 2023 - PRESI/DG/COGEP

Desconsiderar o despacho anterior, evento 0588349.

Em atendimento ao despacho GAPRES 0587796, levando em consideração a publicação da Portaria TSE nº 244/2023 (0588344), passo a expor:

A referida portaria trata da suspensão de provimentos de cargos efetivos no âmbito da Justiça Eleitoral, bem como estabelece o quantitativo para provimento de 4 (quatro) cargos efetivos para o TRE-AC, sendo 1 (um) de Analista Judiciário e 3 (três) de Técnico Judiciário, observando os parâmetros constantes do § 1º do art. 1º:

VACÂNCIAS COM PROVIMENTOS AUTORIZADOS (§ 1º do art. 1º da Portaria TSE nº 244/2023)

Inciso I	
Vacâncias a partir de 01/04/2022

(art. 33, I, II e VIII, Lei nº 8112/90)

EXONERAÇÃO

DEMISSÃO

POSSE EM OUTRO CARGO INACUMULÁVEL

Incisos II e III	
Vacâncias decorrentes de

READAPTAÇÃO

REVERSÃO

APROVEITAMENTO

REINTEGRAÇÃO

RECONDUÇÃO

CUMPRIMENTO DE SENTENÇA JUDICIAL

Inciso IV	
Vacâncias ocorridas até 31/03/2022 e as dos incisos VII e IV

do art. 33 da Lei nº 8.112/90 ocorridas a qualquer tempo

TODAS, INCLUSIVE AS ORIUNDAS DE APOSENTADORIA E FALECIMENTO

 

Atualmente, temos 10 (dez) cargos efetivos vagos, conforme segue:

CARGOS VAGOS

EX-SERVIDOR

ORIGEM DA VACÂNCIA

DATA DA VACÂNCIA

PORTARIA TSE N. 244/2023

PASSÍVEL DE PROVIMENTO PELA PORTARIA?

 

02 (dois) de Técnicos Judiciários - Apoio Especializado - Programação de Sistemas

 

ARILTON SILVA DE OLIVEIRA

REDISTRIBUIÇÃO - APOSENTADORIA

01/07/2015

art. 1º,§1º, IV

SIM

FRANKLEY FRANCALINO DA ROCHA

REDISTRIBUIÇÃO - POSSE EM CARGO INACUMULÁVEL

09/03/2020

art. 1º,§1º, I

SIM

 

01 (um) de Técnico Judiciário - Apoio Especializado - Digitação

 

RICARDO MELO FILHO

APOSENTADORIA

19/01/2022

art. 1º,§1º, IV

SIM

 

02 (dois) de Técnico Judiciário - Área Administrativa

SAMIRA DOS SANTOS MACHADO

APOSENTADORIA

13/04/2022

art. 1º,§1º, IV

SIM

ERIKA TALITA DO AMARAL

POSSE EM CARGO INACUMULÁVEL

15/12/2022

art. 1º,§1º, I

 

 

01 (um) de Analista Judiciário - Apoio Especializado - Análise de Sistemas

 

FRANCISCA DJENANE MARINHO MARQUES

REDISTRIBUIÇÃO - APOSENTADORIA

03/06/2020

art. 1º,§1º, IV

SIM

04 (quatro) de Analista Judiciário - Área Judiciária

DEVANIL MARIA LUIZ

APOSENTADORIA

30/06/2022

art. 1º,§1º, IV

SIM

ALTAMIRO DANTAS CRUZ

APOSENTADORIA

12/05/2023

art. 1º,§1º, IV

SIM

AGEU DE ALENCAR MIRANDA*

POSSE EM CARGO INACUMULÁVEL

28/04/2023

art. 1º,§1º, I

SIM

LAÍS TOJAL COELHO DE BARROS*

POSSE EM CARGO INACUMULÁVEL

17/04/2023

art. 1º,§1º, I

SIM

*Pendente de publicação de portaria

 

Correlacionando as autorizações com a origem dos cargos vagos, verifica-se a possibilidade de provimento do quantitativo total de cargos autorizados pela Portaria TSE nº 244/2023. Contudo, caso a Administração decida por realizar os provimentos autorizados, é necessária a realização de concurso de remoção interno, bem como a verificação de concursos em outros órgãos com cargos de mesma denominação, visto que este Regional não possui concurso válido.

Por fim, no tocante à transferência de autorizações solicitada pelo TRE-PA através do Ofício-Circular nº 84/2023 (0579038), esta Coordenadoria não é favorável, pois impossibilitaria o provimento de cargos quando da conclusão do iminente concurso unificado, que será realizado pelo TSE ainda em 2023.

Ao GAPRES e ao conhecimento da Direitoria-Geral.

---

Ofício nº 116 / 2023 - PRESI/GAPRES

Rio Branco, 31 de maio de 2023.

A Sua Excelência o Senhor 

Desembargador LEONAM GONDIM DA CRUZ JÚNIOR

Presidente do TRIBUNAL REGIONAL ELEITORAL DO PARÁ

Belém - PA

Assunto: Resposta Ofício-Circular nº 84 / 2023 - TRE/PRE/DG/SGP/CODES/SGD.

 

Senhor Presidente.

 

Com os cumprimentos desta Gestão e em atenção ao Ofício-Circular nº 84/2023 - TRE/PRE/DG/SGP/CODES/SGD, cumpre-me comunicar a impossibilidade de se efetuar a transferência de autorizações de provimento dos cargos vagos de Técnico Judiciário deste Regional.

Sem mais para o momento, renovo as manifestações das mais respeitosas homenagens pessoais. 

 

Atenciosamente,

 

Desembargador FRANCISCO DJALMA

                                       Presidente

---

Informação Nº 0592044 - PRESI/DG/COGEP

 

Senhor Diretor-Geral,

Em atendimento ao Despacho GADG 0588482, há dois concursos disponíveis em que os candidatos poderão ser cedidos para nomeação neste Regional, do Tribunal Regional Federal da 1ª Região (eventos 0592042 e  0592037) e do Tribunal Regional do Trabalho da 14ª Região (eventos 0592040 e 0589489).

Em discussão com o Coordenador de Orçamento e Finanças, chegou-se ao entendimento de que os cargos passíveis de nomeação, conforme Anexo I da Portaria TSE nº 244, são apenas os cargos vagos provenientes de aposentadorias. Segue a retificação da tabela contida no evento 0588430:

CARGOS VAGOS

EX-SERVIDOR

ORIGEM DA VACÂNCIA

DATA DA VACÂNCIA

PORTARIA TSE N. 244/2023

PASSÍVEL DE PROVIMENTO PELA PORTARIA?

 

02 (dois) de Técnicos Judiciários - Apoio Especializado - Programação de Sistemas

 

ARILTON SILVA DE OLIVEIRA

REDISTRIBUIÇÃO - APOSENTADORIA

01/07/2015

art. 1º,§1º, IV

SIM

FRANKLEY FRANCALINO DA ROCHA

REDISTRIBUIÇÃO - POSSE EM CARGO INACUMULÁVEL

09/03/2020

art. 1º,§1º, I

NÃO

 

01 (um) de Técnico Judiciário - Apoio Especializado - Digitação

 

RICARDO MELO FILHO

APOSENTADORIA

19/01/2022

art. 1º,§1º, IV

SIM

 

02 (dois) de Técnico Judiciário - Área Administrativa

SAMIRA DOS SANTOS MACHADO

APOSENTADORIA

13/04/2022

art. 1º,§1º, IV

SIM

ERIKA TALITA DO AMARAL

POSSE EM CARGO INACUMULÁVEL

15/12/2022

art. 1º,§1º, I

NÃO

 

01 (um) de Analista Judiciário - Apoio Especializado - Análise de Sistemas

 

FRANCISCA DJENANE MARINHO MARQUES

REDISTRIBUIÇÃO - APOSENTADORIA

03/06/2020

art. 1º,§1º, IV

SIM

04 (quatro) de Analista Judiciário - Área Judiciária

DEVANIL MARIA LUIZ

APOSENTADORIA

30/06/2022

art. 1º,§1º, IV

SIM

ALTAMIRO DANTAS CRUZ

APOSENTADORIA

12/05/2023

art. 1º,§1º, IV

SIM

AGEU DE ALENCAR MIRANDA*

POSSE EM CARGO INACUMULÁVEL

28/04/2023

art. 1º,§1º, I

NÃO

LAÍS TOJAL COELHO DE BARROS*

POSSE EM CARGO INACUMULÁVEL

17/04/2023

art. 1º,§1º, I

NÃO

 

Atenciosamente,

---

Parecer nº 0594910 / 2023 - PRESI/DG/ASDG

 

Trata-se de consulta formulada pelo Diretor-Geral em exercício quanto à possibilidade jurídica de se realizar concurso interno de remoção com a previsão, em edital, de que o deslocamento dos servidores para os novos locais de lotação dependerá do provimento dos cargos vagos, de modo a preservar a força de trabalho dos cartórios eleitorais.

Inicialmente, convém destacar que disposição semelhante à proposta tem estado em nossos editais de concursos internos de remoção, basta ver, por exemplo, a idêntica redação dos editais do 20º (0174442 - 2017) e do 24º (0462835 - 2021) concursos internos de remoção:

 

6. DAS DISPOSIÇÕES GERAIS

6.1. A Administração, em face do princípio da continuidade dos serviços e do interesse público, poderá, por meio de ato fundamentado, determinar o momento mais conveniente e oportuno para efetivar as remoções.

6.2. A efetivação das remoções estão condicionadas à nomeação de novos(as) servidores(as).

(...)

 

A verdade é que não há regra expressa no ordenamento para determinar o momento em que deve ocorrer o efetivo deslocamento do servidor que tem direito à remoção. Assim, salvo melhor juízo, a solução deve se dar através de  princípios e, nesse sentido, certamente é possível invocar os princípios da supremacia do interesse público sobre o privado, o princípio da continuidade dos serviços públicos e o princípio da eficiência como determinantes para apontar que cabe à Administração escolher o melhor momento para remoção, desde que o faça, é claro, através de decisão fundamentada e com o objetivo de salvaguardar o interesse público.

O art. 36, parágrafo único, inciso III, alínea "c", da Lei 8.112/90, reza que a remoção, na hipótese dos autos, se dará de acordo com as normas que vierem a ser preestabelecidas pelo órgão promotor do concurso. Dessa forma, ao que parece, a lei deixou a cargo da Administração Pública, estabelecer o regramento dos concursos de remoção, desde que o faça de maneira prévia, razão pela qual tem-se a citada resolução do TSE e os editais que estabelecem os pormenores da competição.

Assim, por entender que a medida proposta visa concretizar princípios jurídicos da Administração Pública ínsitos no art. 37 e outros da Constituição Federal, opina-se pela possibilidade jurídica de condicionar a efetivação de remoção ao preenchimento da vaga por outro servidor.

É o parecer. 

 

À GADG para consideração superior.

---

Parecer nº 0608646 / 2023 - PRESI/DG/ASDG

ADMINISTRATIVO. MINUTA DE EDITAL. CONCURSO DE REMOÇÃO. EXAME PRÉVIO. MINUTA APROVADA. RESSALVA.

 

Trata-se de proposta de concurso interno de remoção, no âmbito da Justiça Eleitoral do Acre.

A realização de concursos de remoção encontra previsão legal na alínea "c" do inciso III do art. 36 da Lei 8.112/90, que assim dispõe:

Art. 36.  Remoção é o deslocamento do servidor, a pedido ou de ofício, no âmbito do mesmo quadro, com ou sem mudança de sede.

(...)

III -  a pedido, para outra localidade, independentemente do interesse da Administração:

(...)

c) em virtude de processo seletivo promovido, na hipótese em que o número de interessados for superior ao número de vagas, de acordo com normas preestabelecidas pelo órgão ou entidade em que aqueles estejam lotados.

No âmbito da Justiça Eleitoral, o deslocamento por meio de remoção está regulamentado pela Resolução TSE n. 23.701/20202, conforme art. 5º, inciso III, alínea "c" e seção III do Capítulo V do Título I.

Oportuno mencionar, ainda, que a realização do certame está relacionada com a publicação da Portaria TSE nº 244/2023 (0588344), que autorizou o provimento de 1 (um) cargo de Analista Judiciário e de 3 (três) cargos de Técnico Judiciário. Nos termos do § 1º do art. 22 da citada Resolução, a realização do concurso de remoção deve preceder às nomeações.

Da análise da minuta do instrumento convocatório do certame juntada ao Evento SEI n. 0605918, verifica-se que está em conformidade com a regras contidas na Resolução que regulamenta o tema, notadamente em relação aos seguintes pontos:

De acordo com o item 2.1, não há restrição à participação de servidores em estágio probatório, considerando não haver impedimento específico na Resolução do TSE;
O prazo de trânsito estabelecido no item 6.3 está em conformidade com a regra do art. 18 da Lei 8.112/90 e com o art. 9º daquela Resolução;
Conforme consta no item 6.6, as despesas com a mudança ficarão a cargo do próprio servidor, em conformidade com a regra do art. 10 da Resolução regulamentadora;
Os critérios de classificação contidos no item 4.1. estão em conformidade com a regra da Resolução citada acima;
No que se refere às demais regras de participação e de procedimentos de realização, convém registrar que, de acordo com o art. 22 da Resolução, cabe ao TRE-AC as definições. Neste ponto, registre-se que foram estipuladas regras que garantam o direito de contestar os resultados e impugnar o termos do edital. Denota-se, portanto, que os direitos de defesa e petição foram garantidos. Saliente-se, ainda, que, no geral, as regras estipuladas se mostram razoáveis e pertinentes.

No que se refere ao período de inscrições, a que se refere o item 1.1., recomenda-se, apenas, que seja concedido prazo razoável o registro do interesse dos servidores. A princípio, um prazo mínimo de 03 (três) dias úteis parece pertinente.

Recomenda-se, contudo, a exclusão do subitem 2.2., considerando não haver previsão legal para a restrição nele prevista.

Feitas essas considerações, esta assessoria aprova da minuta do instrumento convocatório para o XXV Concurso Interno de Remoção da Justiça Eleitoral do Acre juntada ao Evento SEI n. 0605918 com as ressalvas registradas no parágrafo anterior.

 

RECOMENDAÇÃO ADICIONAL

Considerando ter sido incluída a vaga decorrente da provável redistribuição do cargo ocupado pelo servidor Renato Floering Tavares (0605007), recomenda-se que o Edital seja publicado após ser efetivado deslocamento.

 

REMESSA

Ao Coordenador de Gestão de Pessoas, para o ajuste recomendado na minuta do Edital do concurso.

Após, à Diretoria-Geral, para consideração superior, com o registro de que a decisão compete ao Presidente do Tribunal.

---

Edital Nº XXV - PRESI/GAPRES

 

EDITAL DE CONVOCAÇÃO

XXV CONCURSO INTERNO DE REMOÇÃO

 

Dispõe sobre Concurso Interno de Remoção, no âmbito do Tribunal Regional Eleitoral do Acre.

 

O Presidente do Tribunal Regional Eleitoral do Acre, no uso de suas atribuições regimentais e tendo em vista o disposto no art. 36 da Lei n. 8112/1990 e na Resolução TSE n. 23.701, de 31 de maio de 2022, resolve expedir o presente EDITAL DE CONVOCAÇÃO PARA O XXV CONCURSO INTERNO DE REMOÇÃO a pedido, para preenchimento das vagas constantes do Anexo I deste Edital.

 

1. DAS DISPOSIÇÕES PRELIMINARES

1.1. Ficam abertas inscrições, no período de 12 a 14 de dezembro de 2023, para o XXV Concurso Interno de Remoção, a ser realizado para preenchimento das vagas indicadas no Anexo I deste Edital e de outras que porventura venham a surgir com a movimentação dos servidores(as).

1.2. O preenchimento das vagas surgidas com o remanejamento proveniente de remoção dar-se-á com os(as) próprios(as) servidores(as) participantes deste Concurso, observada a ordem de classificação.

1.3. A realização do Concurso Interno de Remoção de que trata este Edital ficará a cargo da Coordenadoria de Gestão de Pessoas – COGEP, por meio de suas unidades.

 

2. DOS REQUISITOS PARA A PARTICIPAÇÃO NO CONCURSO

2.1. Poderão participar deste Concurso todos(as) os(as) servidores(as) ocupantes de cargos efetivos de Analista Judiciário - Área Judiciária e Técnico Judiciário – Área Administrativa, em exercício na data de publicação deste Edital, inclusive os que estejam cumprindo estágio probatório.

2.2. A lotação do(a) servidor(a) removido(a) deve ser compatível com as atribuições do seu cargo efetivo.

 

3. DAS INSCRIÇÕES

3.1. A inscrição do(a) candidato(a) implicará no conhecimento e na tácita aceitação das normas e condições estabelecidas neste Edital.

3.2 Efetivadas as inscrições, não serão aceitos pedidos de alteração de lotações pretendidas. Todavia, o(a) interessado(a) poderá desistir da remoção mediante solicitação, por escrito, protocolada no SEI n. 0000690-49.2023.6.01.8000 até o último dia do prazo para a inscrição.

3.3. As inscrições serão efetuadas mediante preenchimento do modelo de formulário constituído pelo Anexo II deste Edital.

3.4. Os(As) candidatos(as) poderão fazer mais de uma opção de unidade de lotação, com indicação da ordem de preferência.

3.5. O formulário de inscrição, conforme modelo - Anexo II, preenchido e assinado pelo(a) interessado(a), deverá ser anexado ao SEI n. 0000690-49.2023.6.01.8000 até o último dia do prazo para inscrições.

3.6. Será admitido o recebimento do formulário de inscrição via correios ou correio eletrônico dirigido à Seção de Protocolo, que receberá o documento, procedendo à juntada ao procedimento eletrônico referido.

3.7. As informações constantes do formulário serão prestadas sob inteira responsabilidade do(a) candidato(a) e sua inveracidade acarretará as cominações legais pertinentes, além da anulação do ato de remoção, se já efetivado, sem ônus para a Administração.

3.8. Verificada qualquer irregularidade formal, a Seção de Cadastro e Registros Funcionais - SECARF consultará o(a) candidato(a) para esclarecimentos.

3.9. Será admitida a realização de inscrição por procurador, mediante a apresentação de procuração por instrumento público e/ou particular, neste caso, sem necessidade de reconhecimento de firma, acompanhada de cópia legível do documento de identidade do(a) candidato(a) e de seu representante.

3.10. O(A) candidato(a) inscrito(a) por procuração assume total responsabilidade pelas informações prestadas por seu(sua) procurador(a), arcando com as consequências de eventuais erros de seu representante no preenchimento do formulário de inscrição e sua entrega.

 

4. DA CLASSIFICAÇÃO NO CONCURSO

4.1. Observar-se-ão, sucessivamente, para fins de classificação e, se necessário, de desempate, os seguintes critérios:

a) Maior tempo de efetivo exercício em cargo efetivo do Tribunal Regional Eleitoral do Acre;

b) Maior tempo de efetivo exercício em cargo efetivo da Justiça Eleitoral;

c) Maior tempo de efetivo exercício como ocupante de cargo em comissão na Justiça Eleitoral ou como requisitado, com base na Lei nº 6.999/1982 , anterior à ocupação do cargo efetivo na Justiça Eleitoral;

d) Maior tempo de efetivo exercício em cargo efetivo do Poder Judiciário da União;

e) Maior tempo de efetivo exercício no serviço público federal;

f) Maior tempo de efetivo exercício em cargo efetivo do Poder Judiciário Estadual;

g) Maior tempo de efetivo exercício no serviço público;

h) Maior tempo de serviço prestado à Justiça Eleitoral;

i) Maior tempo de exercício na função de jurado;

j) Maior idade.

4.2. O tempo de serviço será apurado em dias, somente sendo considerado aquele já averbado no TRE/AC até a véspera da publicação deste Edital.

4.3. O tempo de exercício na função de jurado deverá ser comprovado por meio de certidão que contenha os dias em que o servidor efetivamente exerceu a função de jurado até o último dia de inscrição estabelecido no presente Edital, não se aceitando nenhuma outra forma de comprovação.

4.4. Caberá à SECARF o levantamento dos dados referentes aos critérios de classificação.

4.5. Após apuração do resultado pela SECARF, o procedimento será submetido à Coordenadoria de Gestão de Pessoas e encaminhado ao Diretor-Geral, no prazo máximo de 15 dias, contados do primeiro dia útil seguinte ao término das inscrições, para decisão e divulgação, mediante publicação no Diário da Justiça Eletrônico.

4.6. Não havendo pedido de reconsideração ou recurso, o(a) Diretor(a)-Geral homologará o resultado final do concurso, que deverá ser novamente publicado no DJE.

 

5. DOS RECURSOS E DA CLASSIFICAÇÃO FINAL

5.1. Os(As) interessados(as) terão o prazo de 3 (três) dias, a contar da publicação do resultado, para apresentar pedido de reconsideração, dirigido ao(à) Diretor(a)-Geral, que proferirá a decisão no prazo de 10 (dez) dias, contados da conclusão.

5.2. Da decisão do(a) Diretor(a)-Geral caberá recurso ao Presidente do Tribunal, no prazo de 3 (três) dias, a contar da ciência do(a) interessado(a).

5.3. Interposto recurso ou pedido de reconsideração, a SECARF intimará os(as) demais interessados(os) para querendo, no prazo de 3 (três) dias, apresentarem as suas alegações.

5.4. O recurso deverá ser instruído com a indicação dos itens impugnados, com justificativa pormenorizada acerca do fundamento da impugnação e a documentação comprobatória de todas as alegações.

5.5. O recurso será decidido no prazo de 10 (dez) dias, contados da data da conclusão ao Presidente do Tribunal.

5.6. Decidido o recurso, o resultado final do concurso será homologado pela Presidência do Tribunal e publicado no DJE.

 

6. DAS DISPOSIÇÕES GERAIS

6.1. A Administração, em face do princípio da continuidade dos serviços e do interesse público, poderá, por meio de ato fundamentado, determinar o momento mais conveniente e oportuno para efetivar as remoções.

6.2. A efetivação das remoções estão condicionadas à nomeação de novos(as) servidores(as).

6.3. O(A) servidor(a) removido(a) para exercício em outro município terá, no mínimo, 10 (dez) e, no máximo, 30 (trinta) dias, observada a conveniência da Administração, a contar da publicação do ato de remoção, para a retomada do efetivo desempenho das atribuições do cargo, incluído nesse prazo o tempo necessário para o deslocamento para a nova sede, quando for o caso.

6.4. Será facultado ao(à) servidor(a) declinar do prazo estabelecido no item 6.3.

6.5. Na hipótese de o(a) servidor(a) encontrar-se em licença ou afastado(a) legalmente, o prazo de que trata o item 6.3 será contado a partir do término do impedimento.

6.6. As despesas decorrentes da mudança para a nova sede correrão às expensas do(a) servidor(a).

6.7. Os(As) titulares das unidades de destino e de origem dos(as) candidatos(as) selecionados(as) no Concurso de que trata este Edital serão comunicados(as), pela COGEP, do resultado do certame.

6.8. Os casos omissos serão decididos pelo(a) Diretor(a)-Geral.

6.9. Este Edital entrará em vigor na data de sua publicação.

 

Rio Branco, 05 de dezembro de 2023.

 

Desembargador JÚNIOR ALBERTO

Presidente

 

ANEXO I

CONCURSO DE REMOÇÃO

QUADRO DE VAGAS

Município

Unidade

Cargo

Área de atividade

Quantidade

Rio Branco

Secretaria

Analista Judiciário

Judiciária

1

Rio Branco

1ª Zona Eleitoral

Analista Judiciário

Judiciária

1

Cruzeiro do Sul

4ª Zona Eleitoral

Analista Judiciário

Judiciária

1

Tarauacá

5ª Zona Eleitoral

Analista Judiciário

Judiciária

1

Rio Branco

Secretaria

Técnico Judiciário

Administrativa

2

Cruzeiro do Sul

4ª Zona Eleitoral

Técnico Judiciário

Administrativa

1

Rio Branco

9ª Zona Eleitoral

Técnico Judiciário

Administrativa

1

 

 

ANEXO II

 

CONCURSO INTERNO DE REMOÇÃO

FORMULÁRIO PARA INSCRIÇÃO

 

Eu, ______________________________________________________________, ( ) Analista Judiciário- Área Judiciária, ( ) Técnico Judiciário – Área Administrativa, matrícula n._____________, endereço eletrônico (e-mail):_____________________________, lotado(a) atualmente na(o) ______________________________________________deste TRE-AC, requeiro minha inscrição no XXV CONCURSO DE REMOÇÃO, para a vaga constante do Anexo I deste Edital, declarando que estou de acordo com todas as condições para o certame e consignando minhas opções de lotação na ordem abaixo estabelecida:

 

(1ª opção) ________________________________________________

 

(2ª opção) ________________________________________________

 

(3ª opção) ________________________________________________

 

(4ª opção) ________________________________________________

 

(5ª opção) ________________________________________________

 

(6ª opção) ________________________________________________

 

_____________________, ______de ______________ de 2023.

 

__________________________________________________

Assinatura do(a) Candidato(a)

Em 07 de dezembro de 2023.

---

Despacho nº 0873830 / 2026 - PRESI/DG/COGEP

Senhora Diretora-Geral,

Trata-se do Ofício-Circular GAB-DG nº 77/2026 (0870693), oriundo do Tribunal Superior Eleitoral, que encaminha a Orientação SOF/TSE nº 6 (0870696), atualizada no mês de maio de 2026, bem como a Portaria TSE nº 229/2026 (0870694), que revoga a Portaria TSE nº 69/2026 e passa a disciplinar a realização de provimentos de cargos efetivos no âmbito da Justiça Eleitoral no exercício financeiro de 2026.

Conforme consignado nos autos, a Portaria TSE nº 229/2026 autoriza provimentos relativos às vagas criadas pela Lei nº 15.374/2026, bem como às vacâncias remanescentes, cabendo a este Regional adotar as providências administrativas necessárias à adequada instrução do feito, inclusive quanto à realização prévia de concurso interno de remoção, nos termos do § 1º do art. 22 da Resolução TSE nº 23.701/2022.

No âmbito desta Coordenadoria, será possível proceder ao levantamento dos cargos vagos, à consolidação das vacâncias passíveis de provimento e à elaboração da minuta do concurso interno de remoção.

Contudo, antes da adoção das providências subsequentes, mostra-se necessária deliberação superior quanto às áreas e especialidades dos cargos a serem providos, especialmente no tocante aos cargos de Analista Judiciário, considerando que a definição da respectiva área de atividade e, quando for o caso, da especialidade, constitui etapa essencial para a adequada identificação das vagas, para a elaboração do concurso interno de remoção e para o posterior encaminhamento dos atos de nomeação.

Ressalta-se que tal definição possui impacto direto na gestão da força de trabalho deste Tribunal, devendo observar as necessidades institucionais das unidades, a estrutura administrativa vigente, as atribuições dos cargos e o planejamento de pessoal da Administração.

Dessa forma, submeto os autos à apreciação dessa Diretoria-Geral, sugerindo-se o encaminhamento à Administração Superior, para que sejam definidas as áreas de atividade e especialidades dos cargos efetivos a serem providos, principalmente em relação aos cargos de Analista Judiciário, a fim de possibilitar a continuidade da instrução processual por esta Coordenadoria.

Após a definição, retornem os autos à COGEP para adoção das providências cabíveis.

À consideração superior.

---

Despacho nº 0886294 / 2026 - PRESI/DG/GADG

1. Trata-se de procedimento administrativo instaurado, originalmente, a partir do Ofício-Circular n. 84/2023 - TRE/PRE/DG/SGP/CODES/SGD (0579038), por meio do qual o Tribunal Regional Eleitoral do Pará consultou os demais Tribunais Regionais acerca da possibilidade de transferência de autorizações para provimento de cargos efetivos.

2. No decorrer de sua tramitação, os autos passaram a concentrar sucessivas comunicações do Tribunal Superior Eleitoral, orientações orçamentárias, portarias anuais de autorização de provimentos, procedimentos de remoção, vacâncias, nomeações e outras matérias relacionadas à gestão do quadro de pessoal, referentes a exercícios e situações funcionais distintos.

3. Em 2026, o Ofício-Circular GAB-DG n. 22/2026 (0847958) encaminhou a Orientação SOF/TSE n. 6 (0847960), então atualizada, e a Portaria TSE n. 69/2026 (0847959). Na ocasião, a COGEP informou que as providências relativas ao cargo efetivo vago existente estavam sendo adotadas no Processo SEI n. 0001445-05.2025.6.01.8000 (0848498).

4. Posteriormente, o Ofício-Circular GAB-DG n 45/2026 (0859013) comunicou a publicação da Lei n. 15.374, de 2 de abril de 2026 (0859016), que criou, para o Tribunal Regional Eleitoral do Acre, 5 (cinco) cargos de Analista Judiciário, 5 (cinco) cargos de Técnico Judiciário, 2 (dois) cargos em comissão de nível CJ-3 e 7 (sete) funções comissionadas de nível FC-6.

5. A publicação da lei foi levada ao conhecimento da Presidência pelo Despacho n. 0859017, tendo sido registrada ciência e determinada sua comunicação à Corte por meio do Despacho n. 0860560, providência certificada pela GAJUD na Informação n. 0860915.

6. Sobreveio o Ofício-Circular GAB-DG n. 77/2026 (0870693), que encaminhou a versão atualizada da Orientação SOF/TSE n. 6 (0870696) e a Portaria TSE n. 229/2026 (0870694), que revogou a Portaria TSE n. 69/2026 e autorizou:

a)  no Anexo I, o provimento de até 1 (um) cargo vago de Analista Judiciário e 1 (um) cargo vago de Técnico Judiciário, integrantes do quadro anteriormente existente; e

b) no Anexo II, o provimento dos 5 (cinco) cargos de Analista Judiciário e dos 5 (cinco) cargos de Técnico Judiciário criados pela Lei n. 15.374/2026.

7. Por meio do Despacho n. 0870702, esta Diretoria-Geral encaminhou os autos à COGEP para levantamento dos cargos vagos, consolidação das vacâncias passíveis de provimento e preparação do concurso interno de remoção, providência ratificada pela Presidência no Despacho n. 0871843.

8. A SECARF, na Informação n. 0872201, registrou a existência de um cargo vago de Analista Judiciário - Área de Apoio Especializado - Especialidade Tecnologia da Informação, decorrente da aposentadoria da servidora Rosana Magalhães da Silva, acrescentando que os cargos criados pela Lei nº 15.374/2026 dependeriam de regulamentação deste Tribunal.

9. Em seguida, a COGEP, no Despacho n. 0873830, destacou a necessidade de prévia definição das áreas de atividade e das especialidades dos cargos novos, especialmente os de Analista Judiciário, por se tratar de providência indispensável à realização de concurso de remoção e às futuras nomeações.

10. O Despacho n.0878000, firmado após reunião com os titulares da SAOF, GAJUD e STI, que continha proposta preliminar de distribuição dos cargos, foi expressamente marcado como “DESCONSIDERAR”, não produzindo, portanto, definição administrativa válida ou efeito decisório sobre a matéria.

11. Paralelamente, tramita o Processo SEI n. 0001059-72.2025.6.01.8000, que contém proposta de transformação da atual Coordenadoria de Gestão de Pessoas em Secretaria de Gestão de Pessoas. Conforme levantamento constante daqueles autos, o TRE-AC é o único Tribunal Regional Eleitoral no qual a gestão de pessoas ainda se encontra estruturada em nível de Coordenadoria, circunstância que evidencia a relevância institucional e a necessidade de fortalecimento da área.

12. O exame da matéria deve considerar, de maneira clara e não exaustiva, o seguinte quadro normativo:

a)  a Lei n. 15.374/2026 criou para o TRE-AC 5 (cinco) cargos de Analista Judiciário, 5 (cinco) cargos de Técnico Judiciário, 2 (dois) CJ-3 e 7 (sete) FC-6, sem definir a área de atividade, a especialidade ou a unidade de lotação dos cargos efetivos;

b)  o art. 1º da Resolução TSE nº 23.761/2026 estabelece que os cargos e as funções criados pela Lei nº 15.374/2026 poderão ser implementados e providos, enquanto o art. 2º determina que os cargos efetivos sejam enquadrados nas áreas de atividade e especialidades regulamentadas pela Resolução TSE n. 23.741/2024;

c) o parágrafo único do art. 2º da Resolução TSE n. 23.761/2026 determina que, quando os cargos forem destinados às Zonas Eleitorais, seja priorizado o quantitativo previsto no art. 1º, inciso I, da Lei n. 13.150/2015, correspondente a 1 (um) cargo de Analista Judiciário e 1 (um) cargo de Técnico Judiciário para cada Zona Eleitoral;

d) a Resolução TSE n. 23.741/2024 atualiza as áreas, especialidades, denominações, atribuições e requisitos dos cargos efetivos, inclusive substituindo a denominação “Análise de Sistemas” por “Tecnologia da Informação”;

e) a Portaria TSE n. 229/2026 distingue as autorizações relativas aos cargos anteriormente existentes e vagos, constantes do Anexo I, daquelas destinadas aos cargos novos da Lei n. 15.374/2026, constantes do Anexo II, não sendo admissível utilizar uma autorização para finalidade diversa daquela a que foi destinada;

f) o art. 22, § 1º, da Resolução TSE n. 23.701/2022 estabelece que o concurso interno de remoção deve preceder a nomeação de candidatos habilitados em concurso público para o provimento de cargos efetivos;

g) o art. 10 da Resolução TSE n. 20.572/2000 atribui aos Presidentes dos Tribunais Regionais Eleitorais competência para fixar a lotação dos cargos efetivos e aprovar alteração de área de atividade ou criação de especialidade, nos casos previstos naquele normativo; e

h) os arts. 3º e 4º da Resolução TSE n. 23.761/2026 submetem a implementação dos cargos em comissão e das funções comissionadas aos critérios organizacionais da Resolução TSE n. 22.138/2005 e determinam que a nova estrutura seja aprovada pelo Plenário do respectivo Tribunal Regional Eleitoral.

13. No plano interno, o art. 17, inciso IV, do Regimento Interno do TRE-AC atribui ao Tribunal a competência para organizar sua Secretaria e seus serviços auxiliares, enquanto as disposições regimentais relativas à Presidência contemplam a expedição dos atos de provimento e de lotação. À Diretoria-Geral, nos termos do art. 87 da Resolução TRE/AC n. 1.808/2025, compete coordenar a instrução, integrar as manifestações técnicas e submeter as matérias à instância competente, não se mostrando adequado que esta Diretoria-Geral defina, por simples despacho, as áreas, especialidades ou a distribuição definitiva dos cargos.

14. Há, contudo, questão jurídica que demanda manifestação específica: se o enquadramento inicial dos cargos novos nas áreas e especialidades pode ser aprovado pela Presidência, mediante portaria, à luz do art. 10 da Resolução TSE n. 20.572/2000 e das competências regimentais de provimento e lotação, ou se a matéria deve ser submetida ao Tribunal Pleno e formalizada por resolução, em razão do art. 17, inciso IV, do Regimento Interno e da repercussão sobre o quadro permanente do Tribunal.

15. Verifica-se, ainda, que a concentração, nestes autos, de comunicações gerais, autorizações anuais, vacâncias, provimentos, remoções e situações funcionais individualizadas tornou menos nítida a delimitação dos objetos e dificultou a identificação do estágio atual de cada providência.

16. Essa multiplicidade de matérias e de referências documentais, embora decorrente do desenvolvimento natural do procedimento ao longo dos anos, eleva o risco de omissões, duplicidade de providências, utilização inadequada de saldos ou associação de documentos a situações distintas. A organização das matérias em processos específicos, devidamente relacionados, assegura maior rastreabilidade, clareza decisória, controle dos prazos e segurança para a Administração.

17. Diante desse panorama, no exercício das atribuições conferidas à Diretoria-Geral, indispensável adotar as providências a seguir.

 

DOS DEZ CARGOS EFETIVOS CRIADOS PELA LEI Nº 15.374/2026

18. À COGEP, para que autue processo específico destinado exclusivamente ao enquadramento, à distribuição e ao provimento dos 5 (cinco) cargos de Analista Judiciário e dos 5 (cinco) cargos de Técnico Judiciário criados pela Lei n. 15.374/2026, fazendo constar:

I – como interessado, o Tribunal Regional Eleitoral do Acre;

II – como assunto, “Implementação dos cargos efetivos criados pela Lei nº 15.374/2026 – definição de áreas de atividade, especialidades e lotação”; e

III – o relacionamento com o presente processo, sem traslado indiscriminado de todo o seu conteúdo.

19. Deverão ser trasladadas para o novo processo, além deste despacho, apenas as peças necessárias à compreensão e à decisão da matéria, especialmente:

I – Ofício-Circular GAB-DG n. 45/2026 (0859013);

II – Lei n. 15.374/2026 (0859016);

III – Ofício-Circular GAB-DG n. 77/2026 (0870693);

IV – Portaria TSE n. 229/2026 (0870694);

V – Orientação SOF/TSE n. 6 (0870696);

VI – Despachos n. 0870702 e n. 0871843;

VII – Despacho COGEP n. 0873830;

VIII – Resoluções TSE n. 23.741/2024 e n. 23.761/2026; e

IX – outros documentos que a COGEP considere indispensáveis, desde que diretamente relacionados aos dez cargos novos.

20. No novo processo, a COGEP deverá elaborar informação técnica conclusiva, contendo:

I – quadro atualizado da força de trabalho, discriminado por cargo, área, especialidade, unidade de lotação, situação de ocupação e vacância;

II – demonstração da atual distribuição de Analistas e Técnicos entre a Secretaria, a Corregedoria, as Zonas Eleitorais e as demais unidades;

III – identificação das Zonas Eleitorais que eventualmente não disponham do quantitativo de 1 (um) Analista e 1 (um) Técnico, para fins de aplicação do art. 2º, parágrafo único, da Resolução TSE n. 23.761/2026;

IV – levantamento objetivo das necessidades das unidades, considerando atribuições, volume e complexidade do trabalho, riscos de descontinuidade, criticidade para as Eleições 2026, força de trabalho disponível e planejamento institucional;

V – identificação das áreas e especialidades existentes no Concurso Público Nacional Unificado da Justiça Eleitoral, dos candidatos habilitados ou integrantes de cadastro de reserva e das condições concretas para nomeação;

VI – conferência da nomenclatura, das atribuições e dos requisitos de cada área e especialidade, nos termos da Resolução TSE n. 23.741/2024;

VII – apresentação de proposta técnica fundamentada de distribuição dos 5 (cinco) cargos de Analista e dos 5 (cinco) cargos de Técnico, acompanhada, sempre que viável, de cenários alternativos e da demonstração das vantagens e limitações de cada solução;

VIII – análise dos reflexos sobre eventual concurso interno de remoção, observada a Resolução TSE n. 23.701/2022;

IX – avaliação da necessidade de lotação imediata ou diferida dos cargos e dos riscos decorrentes de cada alternativa;

X – cronograma estimado das providências necessárias ao aproveitamento da autorização de provimento no exercício de 2026; e

XI – levantamento comparativo, de caráter subsidiário, das soluções adotadas por Tribunais Regionais Eleitorais de porte semelhante, sem prejuízo da prevalência das necessidades específicas do TRE-AC.

21. Para a formação do diagnóstico, a COGEP deverá solicitar manifestações objetivas e padronizadas às unidades cujas atividades possam justificar áreas ou especialidades específicas, especialmente à SEJUD, à SAOF, à STI, cabendo à ASPLAN avaliar o alinhamento das alternativas com o planejamento, a governança e a estratégia institucional.

22. Concluída a instrução técnica, encaminhem-se os autos à SAOF para manifestação quanto:

I – à disponibilidade orçamentária e financeira;

II – à manutenção dos limites físico-financeiros autorizados pelo TSE;

III – à distinção entre os quantitativos dos Anexos I e II da Portaria TSE n. 229/2026; e

IV – ao cronograma necessário para eventual provimento ainda no exercício de 2026.

23. Após, encaminhem-se os autos à ASJUR para análise específica e conclusiva acerca:

I – da autoridade competente para definir inicialmente as áreas de atividade e as especialidades dos cargos criados pela Lei n. 15.374/2026;

II – do alcance do art. 10, incisos I e II, da Resolução TSE n. 20.572/2000 e de sua aplicabilidade aos cargos novos;

III – da incidência do art. 17, inciso IV, do Regimento Interno do TRE-AC e das disposições do Regimento Interno da Secretaria;

IV – da necessidade de submissão da matéria ao Tribunal Pleno ou da possibilidade de decisão pela Presidência;

V – do instrumento adequado para formalização da definição, indicando se deverá ser expedida resolução, portaria ou outro ato normativo;

VI – da necessidade de alteração ou atualização dos atos internos que consolidam o quadro de pessoal;

VII – da conformidade da proposta com as Resoluções TSE n. 20.572/2000, n. 23.701/2022, n. 23.741/2024 e n. 23.761/2026; e

VIII – das providências jurídicas que devem anteceder o concurso interno de remoção e as nomeações.

24. Cumpridas as diligências, retornem os autos à Diretoria-Geral para consolidação e encaminhamento à Presidência, a quem caberá decidir sobre o prosseguimento e, conforme a conclusão jurídica, deliberar ou submeter a proposta ao Tribunal Pleno.

25. A instrução deverá receber prioridade compatível com a vigência da autorização de provimento para o exercício de 2026, sem prejuízo das atividades críticas relacionadas à preparação e à realização das Eleições 2026.

DAS AUTORIZAÇÕES RELATIVAS A CARGOS ANTERIORMENTE VAGOS

26. Quanto às autorizações constantes do Anexo I da Portaria TSE n. 229/2026, a COGEP/SECARF deverá certificar, nestes autos:

I – o cumprimento da Decisão n. 525/2026 (0872805), proferida no Processo SEI n. 0001445-05.2025.6.01.8000, que autorizou o provimento do cargo de Analista Judiciário - Área de Apoio Especializado - Especialidade Tecnologia da Informação, indicando se houve expedição e publicação do ato de nomeação, posse, entrada em exercício ou eventual providência ainda pendente;

II – se o provimento referido no inciso anterior consumiu o saldo de 1 (um) cargo de Analista Judiciário constante do Anexo I da Portaria TSE n, 229/2026;

III – se existe cargo efetivamente vago de Técnico Judiciário apto a utilizar a autorização constante do mesmo Anexo I, com indicação da origem e da data da vacância, da área de atividade, da especialidade, da lotação e da existência de candidato habilitado; e

IV – se há processo específico em andamento para eventual provimento do cargo de Técnico Judiciário.

27. Caso exista cargo vago de Técnico Judiciário apto ao provimento e a matéria ainda não esteja sendo tratada em processo próprio, deverá a COGEP promover nova autuação, relacionando-a a estes autos e trasladando somente os documentos necessários.

28. A COGEP deverá, ainda, apresentar quadro sintético de controle das matérias potencialmente pendentes nestes autos, indicando, para cada uma:

I – o objeto;

II – o cargo ou a vacância envolvida;

III – o evento de origem;

IV – a autorização normativa correspondente;

V – o processo específico em que a matéria está sendo tratada;

VI – a situação atual; e

VII – a próxima providência, se houver.

29. As situações concluídas, superadas por norma posterior ou já absorvidas por processo específico deverão ser assim identificadas, de modo a evitar duplicidade de atuação. Eventuais matérias ainda ativas e sem processo próprio deverão ser individualizadas em nova autuação.

DOS CARGOS EM COMISSÃO E DAS FUNÇÕES COMISSIONADAS

30. Os 2 (dois) cargos em comissão CJ-3 e as 7 (sete) funções comissionadas FC-6 criados pela Lei n. 15.374/2026 não integrarão o processo específico destinado aos dez cargos efetivos, por envolverem alteração da estrutura organizacional e procedimento decisório próprio.

31. Registre-se que a proposta constante do Processo SEI n. 0001059-72.2025.6.01.8000 demonstra a necessidade de fortalecimento da área de gestão de pessoas e a singularidade da estrutura atualmente existente no TRE-AC. Tal circunstância constitui elemento relevante de prioridade administrativa e deverá ser expressamente considerada na futura deliberação.

32. A proposta apresentada pela COGEP, contudo, utiliza, direta ou mediante transformação, os 2 (dois) CJ-3 e as 7 (sete) FC-6 criados pela Lei n. 15.374/2026. Embora não retire cargos ou funções atualmente destinados a outras unidades, a medida compromete a integralidade dos novos recursos organizacionais e, por isso, produz repercussão sobre a estrutura do Tribunal como um todo.

33. Assim, sem afastar a relevância da criação da Secretaria de Gestão de Pessoas e sem desconsiderar os estudos, manifestações e providências já produzidos no Processo SEI n. 0001059-72.2025.6.01.8000, a destinação dos novos cargos em comissão e funções comissionadas deverá ser examinada sob perspectiva institucional integrada.

34. À GADG, para autuação de processo específico de revisão integrada da estrutura organizacional do Tribunal, sob coordenação da Diretoria-Geral e com apoio técnico da ASPLAN, da COGEP e da SAOF, relacionando-se o Processo SEI n. 0001059-72.2025.6.01.8000 como subsídio, sem reprodução desnecessária de todo o seu conteúdo.

35. A instrução do processo de revisão organizacional deverá abranger, de forma proporcional e objetiva:

I – diagnóstico da estrutura atualmente existente;

II – levantamento das necessidades das unidades;

III – mapeamento dos cargos em comissão e funções comissionadas atuais e daqueles criados pela Lei n. 15.374/2026;

IV – natureza, volume e complexidade dos serviços;

V – adequação dos níveis de direção, chefia e assessoramento;

VI – alinhamento com a estratégia, a governança e os riscos institucionais;

VII – simetria de competências com a estrutura do Tribunal Superior Eleitoral;

VIII – alternativas de distribuição, transformação e implementação, inclusive por etapas;

IX – demonstração de ausência de aumento de despesas e de compatibilidade orçamentária, financeira e fiscal; e

X – minuta do correspondente ato normativo.

36. O diagnóstico deverá conter capítulo específico sobre a área de gestão de pessoas, considerando o fato de o TRE-AC ser o único Tribunal Regional Eleitoral que ainda não possui Secretaria de Gestão de Pessoas, avaliando-se, de maneira fundamentada, a possibilidade de seu fortalecimento ou implementação prioritária dentro do desenho organizacional integrado.

37. As providências determinadas no Despacho n. 0897875, proferido no Processo SEI n. 0001059-72.2025.6.01.8000, poderão prosseguir para fins de aperfeiçoamento técnico da proposta setorial, cujos resultados serão aproveitados no processo de revisão integrada, sem que disso decorra vinculação ou destinação definitiva dos novos cargos e funções antes da conclusão da análise institucional.

38. A nova estrutura organizacional somente poderá ser implementada após instrução técnica e orçamentária, manifestação da ASJUR e aprovação do Tribunal Pleno, nos termos do art. 4º da Resolução TSE n. 23.761/2026, dos arts. 6º e 9º da Resolução TSE n. 22.138/2005 e do art. 108 da Resolução TRE/AC n. 1.808/2025.

39. A programação dos estudos de reestruturação deverá preservar a prioridade das atividades diretamente relacionadas às Eleições 2026, sem prejuízo da adequada organização documental e do aproveitamento dos estudos que já se encontram concluídos ou em elaboração.

40. Cumpridas as providências relativas à autuação, ao traslado das peças e ao quadro de controle das pendências, retornem estes autos à Diretoria-Geral para acompanhamento e deliberação quanto ao seu encerramento ou à manutenção exclusivamente como processo de referência das orientações gerais expedidas pelo Tribunal Superior Eleitoral.

41. À COGEP, à GADG e à ASPLAN, para cumprimento, com ciência à SAOF, à SEJUD, à STI e à ASJUR.

---

Despacho nº 0900754 / 2026 - PRESI/DG/COGEP

PREVISÃO ORÇAMENTÁRIA PARA IMPLEMENTAÇÃO DA LEI Nº 15.374/2026 NO ÂMBITO DO TRE-AC

 

Período: setembro a dezembro de 2026

Considerando a Lei nº 15.374, de 2 de abril de 2026, que criou cargos efetivos, cargos em comissão e funções comissionadas no quadro de pessoal do Tribunal Superior Eleitoral e dos Tribunais Regionais Eleitorais;

Considerando que, nos termos do Anexo da referida Lei, foram destinados ao Tribunal Regional Eleitoral do Acre:

Cargo/Função	Quantidade
Analista Judiciário	5
Técnico Judiciário	5
Cargo em Comissão – CJ-3	2
Função Comissionada – FC-6	7
Total	19
Considerando, ainda, que a Portaria TSE nº 229, de 20 de maio de 2026, autorizou expressamente, para o exercício financeiro de 2026, o provimento dos 5 cargos de Analista Judiciário e dos 5 cargos de Técnico Judiciário criados pela Lei nº 15.374/2026 para o TRE-AC;

Apresenta-se a estimativa de impacto orçamentário decorrente da implementação integral da estrutura, considerando o início dos efeitos financeiros em 1º de setembro de 2026.

 

1. Premissas adotadas

Para os cargos efetivos, considera-se o ingresso no primeiro padrão da Classe A – A-1, conforme dispõe a Lei nº 11.416/2006.

Foram utilizados os valores remuneratórios vigentes a partir de 1º de julho de 2026, decorrentes da Lei nº 15.293/2025:

Cargo/Função

Vencimento Básico

GAJ – 140%

Remuneração considerada

Analista Judiciário – A-1

R$ 6.683,70

R$ 9.357,18

R$ 16.040,88

Técnico Judiciário – A-1

R$ 4.073,63

R$ 5.703,08

R$ 9.776,71

CJ-3

—

—

R$ 16.665,13

FC-6

—

—

R$ 3.956,81

A projeção considera quatro meses completos de remuneração, correspondentes aos meses de setembro, outubro, novembro e dezembro de 2026.

Considera-se, ainda, a gratificação natalina proporcional a 4/12, partindo da premissa de que os servidores entrarão em exercício em setembro de 2026 por período igual ou superior a 15 dias naquele mês.

Para fins de planejamento, foi adotado percentual estimativo de 18% para encargos patronais incidentes sobre a remuneração dos cargos efetivos e correspondente gratificação natalina, devendo o percentual ser ajustado pela unidade orçamentária caso seja adotado parâmetro específico diverso pelo TRE-AC.

Não foram considerados, inicialmente, Adicional de Qualificação – AQ, Gratificação de Atividade Externa – GAE, Gratificação de Atividade de Segurança – GAS, auxílio-transporte ou assistência pré-escolar, uma vez que dependem da situação individual dos servidores que vierem a ser nomeados.

 

2. Despesa mensal com remuneração

2.1. Cargos efetivos

Cargo

Quant.

Valor unitário mensal

Despesa mensal

Analista Judiciário – A-1

5

R$ 16.040,88

R$ 80.204,40

Técnico Judiciário – A-1

5

R$ 9.776,71

R$ 48.883,55

Subtotal – cargos efetivos

10

 

R$ 129.087,95

2.2. Cargos e funções comissionadas

Cargo/Função

Quant.

Valor unitário mensal

Despesa mensal

CJ-3

2

R$ 16.665,13

R$ 33.330,26

FC-6

7

R$ 3.956,81

R$ 27.697,67

Subtotal – CJ/FC

9

 

R$ 61.027,93

Dessa forma, a implementação integral dos cargos e funções representa uma despesa remuneratória mensal de:

R$ 190.115,88

 

3. Remuneração de setembro a dezembro de 2026

Cargo/Função

Despesa mensal

4 meses

5 Analistas Judiciários

R$ 80.204,40

R$ 320.817,60

5 Técnicos Judiciários

R$ 48.883,55

R$ 195.534,20

2 CJ-3

R$ 33.330,26

R$ 133.321,04

7 FC-6

R$ 27.697,67

R$ 110.790,68

Total

R$ 190.115,88

R$ 760.463,52

Portanto, exclusivamente a título de remuneração ordinária, o impacto entre setembro e dezembro de 2026 será estimado em R$ 760.463,52.

 

4. Gratificação natalina – 13º salário

Considerando quatro meses de exercício no ano de 2026, estima-se o pagamento de 4/12 da remuneração de dezembro.

Remuneração mensal total: R$ 190.115,88

4/12 da remuneração:

R$ 63.371,96

Assim, a despesa acumulada com remuneração ordinária e gratificação natalina alcança:

R$ 760.463,52 + R$ 63.371,96 = R$ 823.835,48

 

5. Encargos patronais estimados

A remuneração mensal correspondente exclusivamente aos 10 novos cargos efetivos é de R$ 129.087,95.

No período de setembro a dezembro:

R$ 129.087,95 × 4 = R$ 516.351,80

Gratificação natalina proporcional dos cargos efetivos:

R$ 129.087,95 × 4/12 = R$ 43.029,32

Base estimada para encargos:

R$ 516.351,80 + R$ 43.029,32 = R$ 559.381,12

Aplicando-se, para fins estimativos, o percentual de 18%:

Encargos patronais estimados: R$ 100.688,60

 

6. Auxílio-alimentação

A Portaria Conjunta nº 1, de 3 de fevereiro de 2026, fixou o auxílio-alimentação dos servidores do Poder Judiciário da União em R$ 1.860,51 mensais.

Para os 10 novos servidores efetivos:

R$ 1.860,51 × 10 servidores = R$ 18.605,10 mensais.

No período de quatro meses:

R$ 18.605,10 × 4 = R$ 74.420,40

 

7. Consolidação da previsão orçamentária

Natureza da despesa

Valor estimado

Remuneração – setembro a dezembro

R$ 760.463,52

Gratificação natalina proporcional – 4/12

R$ 63.371,96

Encargos patronais estimados

R$ 100.688,60

Auxílio-alimentação – 10 servidores

R$ 74.420,40

TOTAL ESTIMADO

R$ 998.944,48

Dessa forma, para implementação dos cargos e funções criados pela Lei nº 15.374/2026 destinados ao TRE-AC, com efeitos financeiros a partir de setembro de 2026, estima-se, inicialmente, a necessidade de dotação de aproximadamente:

R$ 998.944,48

para o período de setembro a dezembro de 2026.

 

8. Assistência médica e odontológica

Para fins de uma previsão orçamentária mais abrangente, pode-se acrescentar o valor per capita utilizado pela Justiça Eleitoral em 2026 para assistência médica e odontológica, correspondente a R$ 791,21 mensais.

Considerando exclusivamente os 10 novos servidores:

R$ 791,21 × 10 × 4 meses = R$ 31.648,40

Com essa inclusão, a previsão passa a:

R$ 998.944,48 + R$ 31.648,40 =

R$ 1.030.592,88

Este valor constitui uma estimativa mais abrangente para fins de reserva orçamentária.

 

9. Despesas variáveis não incluídas

A previsão deverá ser posteriormente complementada, conforme o perfil dos servidores nomeados, em relação à assistência pré-escolar, auxílio-transporte, Adicional de Qualificação – AQ e eventuais gratificações específicas decorrentes das especialidades dos cargos.

A assistência pré-escolar possui, em 2026, valor mensal de R$ 1.288,47 por beneficiário. Assim, cada dependente que preencher os requisitos para concessão poderá representar, entre setembro e dezembro, despesa adicional de R$ 5.153,88.

Quanto ao Adicional de Qualificação, o valor de referência vigente a partir de julho de 2026 é de R$ 771,55. A primeira graduação exigida para ingresso no cargo não gera AQ, razão pela qual não se mostra adequado presumir sua incidência para todos os nomeados. Caso, entretanto, todos os 10 servidores apresentem título de especialização passível de reconhecimento, a despesa adicional estimada no período, incluindo gratificação natalina proporcional e encargos de 18%, seria de aproximadamente R$ 39.451,92.

 

10. Distribuição temporal da necessidade orçamentária

Considerando remuneração, encargos patronais estimados e auxílio-alimentação, a distribuição aproximada será:

Competência

Valor

Setembro/2026

R$ 231.956,81

Outubro/2026

R$ 231.956,81

Novembro/2026

R$ 231.956,81

Dezembro/2026, incluindo 13º proporcional

R$ 303.074,05

TOTAL

R$ 998.944,48

Caso seja incluída a assistência médica e odontológica dos 10 novos servidores, a necessidade de recursos será de aproximadamente R$ 239.868,91 em cada um dos meses de setembro, outubro e novembro, e R$ 310.986,15 em dezembro, perfazendo R$ 1.030.592,88 no exercício.

 

11. Observação quanto aos cargos CJ-3

Para fins de segurança orçamentária, a presente estimativa considera o valor integral dos dois cargos CJ-3, isto é, R$ 16.665,13 por cargo.

Entretanto, nos termos do art. 18, § 2º, da Lei nº 11.416/2006, caso os cargos CJ-3 sejam ocupados por servidores integrantes das carreiras do Poder Judiciário ou servidores cedidos, é facultada a opção pela remuneração do cargo efetivo acrescida de 65% do valor do cargo em comissão.

Nessa hipótese, o acréscimo correspondente a cada CJ-3 seria de aproximadamente R$ 10.832,33 mensais.

Caso ambos os CJ-3 sejam ocupados por servidores já integrantes da folha e exerçam essa opção, o custo incremental dos dois cargos, no período de setembro a dezembro, incluindo a gratificação natalina proporcional, cairia de aproximadamente R$ 144.431,13 para R$ 93.880,19, representando redução estimada de R$ 50.550,94.

Nesse cenário, a previsão básica de R$ 998.944,48 seria reduzida para aproximadamente:

R$ 948.393,54.

Para fins de solicitação de disponibilidade ou suplementação orçamentária, contudo, recomenda-se trabalhar com o valor integral dos cargos CJ-3, preservando margem suficiente caso seja necessária a nomeação de ocupante sem vínculo efetivo ou não seja exercida a opção prevista no art. 18, § 2º, da Lei nº 11.416/2006.

 

12. Conclusão

Ante o exposto, considerando a implementação, a partir de setembro de 2026, dos 5 cargos de Analista Judiciário, 5 cargos de Técnico Judiciário, 2 cargos em comissão CJ-3 e 7 funções comissionadas FC-6 destinados ao Tribunal Regional Eleitoral do Acre pela Lei nº 15.374/2026, estima-se impacto orçamentário básico de R$ 998.944,48 no exercício de 2026.

Incluindo-se a previsão per capita de assistência médica e odontológica para os 10 novos servidores efetivos, o montante estimado alcança R$ 1.030.592,88.

Sugere-se, portanto, para fins de planejamento e disponibilidade orçamentária, a adoção de previsão de aproximadamente R$ 1.031.000,00, sem prejuízo de posterior ajuste decorrente da situação individual dos servidores nomeados, especialmente quanto a adicional de qualificação, assistência pré-escolar, auxílio-transporte, assistência à saúde e eventuais gratificações específicas.

 

À GADG, para ciência. 

---

Despacho nº 0914785 / 2026 - PRESI/DG/COGEP

Senhor Diretor,

Considerando o teor do Ofício-Circular GAB-DG nº 45/2026, que comunica a publicação da Lei nº 15.374/2026, a qual dispõe sobre a criação de cargos efetivos, cargos em comissão e funções comissionadas no âmbito do Tribunal Superior Eleitoral e dos Tribunais Regionais Eleitorais, conforme evento 0859013;

Considerando as orientações expedidas pela SOF/TSE, constantes do evento 0870696;

Considerando as manifestações desta Coordenadoria, constantes dos eventos 0900754 e 0873830, em atendimento à determinação contida no despacho GADG 0900749;

Considerando, ainda, a informação da SEPAG 0902486, que registra o lançamento, na planilha do SIGEPRO, da previsão relativa aos provimentos, cargos, funções e benefícios;

Informo que há autorização e previsão orçamentária para o provimento de 5 (cinco) cargos de Analista Judiciário e 5 (cinco) cargos de Técnico Judiciário.

Para o prosseguimento das providências destinadas ao efetivo provimento dos cargos, faz-se necessária a definição, pela Administração, das áreas de atividade e especialidades correspondentes aos cargos a serem providos, especialmente quanto aos cargos de Analista Judiciário, de modo a possibilitar a adoção das medidas subsequentes pela área de gestão de pessoas.

À consideração superior.

---

Informação Nº 0905343 - PRESI/DG/GADG

ESTUDO PARA REVISÃO INTEGRADA DA ESTRUTURA ORGANIZACIONAL DO TRE-AC

Objeto e premissas da revisão

O presente estudo tem por finalidade subsidiar a revisão integrada da estrutura organizacional do Tribunal Regional Eleitoral do Acre, considerando os cargos em comissão e as funções comissionadas criados pela Lei n. 15.374/2026, as alterações estruturais promovidas nos últimos anos e as demandas de aperfeiçoamento atualmente formalizadas pelas unidades.

A análise parte de premissa diversa da mera distribuição dos novos recursos entre os pleitos existentes. Busca-se verificar, primeiramente, como se formou a estrutura atual, quais modificações efetivamente criaram capacidade institucional e quais se limitaram predominantemente à elevação de níveis retributivos, para, a partir daí, construir uma estrutura mais coerente com as necessidades atuais do Tribunal.

A Lei n. 15.374/2026 criou especificamente para o TRE-AC, além de dez cargos efetivos, 2 cargos em comissão CJ-3 e 7 funções comissionadas FC-6, circunstância que ensejou a abertura de processo próprio de revisão integrada da estrutura.

O Despacho DG n. 0886294 estabeleceu que eventual revisão deveria considerar diagnóstico da estrutura atual, levantamento das necessidades, natureza, volume e complexidade dos serviços, adequação dos níveis de direção, chefia e assessoramento, riscos institucionais e alternativas de implementação, inclusive por etapas. A área de Gestão de Pessoas recebeu tratamento prioritário, sem que os novos recursos fossem previamente vinculados a determinada solução setorial.

2. Histórico: formação da estrutura atual

2.1. A reestruturação de 2023 e a utilização do saldo dos 35%

O principal marco para compreensão da estrutura atualmente existente é o Processo SEI n. 0000692-19.2023.6.01.8000. Naquele procedimento, a Administração passou a utilizar, como espaço financeiro para alteração da estrutura, a diferença decorrente da opção de ocupantes de cargos em comissão pela remuneração do cargo efetivo acrescida de 65% do valor do CJ - o denominado saldo dos 35%.

A regulamentação considerou como paradigma o valor integral da totalidade dos cargos em comissão e, como saldo disponível para transformações, a diferença entre esse paradigma e a despesa decorrente das opções remuneratórias dos respectivos ocupantes. Previu-se, inclusive, monitoramento permanente pela área de Gestão de Pessoas e pela SAOF.

A utilização desse espaço financeiro permitiu implementar alterações que, em parte, correspondiam a necessidades institucionais concretas. Foram criadas, entre outras, a Assessoria de Gestão Eleitoral - AGEL, a unidade de Pregão, a Assessoria de Governança e Planejamento da SAOF, a Seção de Gestão de Contratos, a Coordenadoria de Soluções Corporativas e a Seção de Cibersegurança, além de remanejamentos na STI.

Essas modificações devem ser distinguidas daquelas que simplesmente elevaram o nível de cargos já existentes.

2.2. As nove elevações de nível promovidas em 2023

No mesmo processo, entretanto, foram promovidas nove transformações de cargos em comissão já existentes, todas aumentando o respectivo nível:

Unidade/cargo | Situação anterior | Situação após 2023
Assessoria de Planejamento, Estratégia e Gestão  ASPLAN | CJ-2 | CJ-3
Assessor Jurídico-Chefe da ASJUR | CJ-2 | CJ-3
Assessoria Jurídica da Presidência | CJ-2 | CJ-3
Assessor Jurídico Adjunto da ASJUR | CJ-1 | CJ-2
Chefia do Gabinete da Diretoria-Geral | CJ-1 | CJ-2
Assessoria de Comunicação Social | CJ-1 | CJ-2
Chefia do Gabinete da Presidência | CJ-1 | CJ-2
Chefia do Gabinete da Corregedoria | CJ-1 | CJ-2
Assessoria Jurídica da Corregedoria | CJ-1 | CJ-2

Essas transformações constam expressamente da Resolução TRE-AC n. 1.781/2023 e dos documentos que instruíram a reestruturação.

Tem-se, portanto, 3 cargos elevados de CJ-2 para CJ-3 e 6 cargos elevados de CJ-1 para CJ-2.

O ponto merece atenção porque, diferentemente da criação da AGEL, da SGEC ou da reorganização da STI, por exemplo, essas nove operações não criaram novas unidades executoras nem aumentaram, por si mesmas, a força de trabalho. Houve essencialmente alteração do nível remuneratório de posições que já integravam a estrutura.

Não se identificou, nos documentos examinados, avaliação posterior que demonstre, mediante indicadores de produtividade, redução de riscos, tempo de resposta ou melhoria dos serviços, ganho institucional diretamente relacionado a essas nove elevações.

Isso não significa afirmar que as unidades ou seus titulares não sejam relevantes. Significa apenas que, sob a perspectiva estritamente organizacional, o aumento do nível do CJ não equivale necessariamente a aumento de capacidade administrativa.

2.3. A consequência institucional

A opção adotada em 2023 produziu uma estrutura mais elevada no plano hierárquico, mas não resolveu as carências operacionais.

Posteriormente, surgiram ou permaneceram demandas relativas à Gestão de Pessoas, Ouvidoria, Auditoria, Gestão Documental, Memória, STI e outras áreas.

Há, inclusive, elemento adicional de governança: auditoria posterior registrou a necessidade de aprimorar o acompanhamento dos recursos relacionados aos 35%, justamente porque a disponibilidade depende da situação remuneratória dos ocupantes dos cargos. O próprio normativo determina que COGEP e SAOF mantenham esse monitoramento.

A experiência sugere, portanto, que a revisão atual deve privilegiar estrutura funcional e capacidade executora, evitando que a classificação hierárquica seja orientada predominantemente por argumentos de equiparação ou isonomia entre unidades.

Esse fenômeno aparece, por exemplo, no pedido de transformação da ASPGOVTI em Assessoria CJ-2: um dos fundamentos expressamente utilizados é a comparação com a estrutura conferida anteriormente à ASGOVSAOF, embora se proponha manter inalteradas as atribuições da própria unidade.

3. Primeira prioridade: Secretaria de Gestão de Pessoas

A criação da Secretaria de Gestão de Pessoas é indicada, neste estudo, como primeira prioridade da revisão (tramita o sei  sei n. 0001059-72.2025.6.01.8000).

A proposta nasceu em 2025, quando a COGEP registrou que o TRE-AC era o único Regional cuja área de Gestão de Pessoas ainda permanecia estruturada em nível de Coordenadoria. O modelo originalmente apreciado pela Presidência continha três Coordenadorias e Gabinete. Posteriormente, a proposta foi modificada para duas Coordenadorias, nove Seções e nove Assistentes FC-1. A própria DG registrou que a configuração posterior era distinta daquela originalmente considerada e, por isso, reclamava nova avaliação do mérito organizacional.

A configuração mais recente pretende consumir, direta ou mediante transformação, todos os 2 CJ-3 e as 7 FC-6 criados pela Lei n. 15.374/2026, circunstância que foi corretamente apontada pela DG como capaz de inviabilizar o atendimento das demais necessidades estruturais do Tribunal.

Por isso, propõe-se preservar a criação da Secretaria, mas racionalizar sua composição.

3.1. Estrutura proposta para a SGP

Secretaria de Gestão de Pessoas - SGP - CJ-3

Coordenadoria de Administração de Pessoas – COAPE — CJ-2

Unidade | Nível
Seção de Cadastro – SECAD | FC-6
Seção de Frequência – SEFRE | FC-6
Seção de Apoio aos Inativos e Cadastro de Magistrados – SAREMI | FC-6
Seção de Pagamentos – SEPAG | FC-6

Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES — CJ-2

Unidade | Nível
Seção de Desenvolvimento – SEDEN | FC-6
Seção de Capacitação – SCAP | FC-6
Seção de Saúde – SESAU | FC-6
Seção de Benefícios – SEBEN | FC-6

A sigla SCAP é preferível à SECAP porque esta já é utilizada na Secretaria Judiciária, duplicidade que a própria análise jurídica identificou.

Por agora, não se propõe a criação da Cálculos e Registros Financeiros - SCRF.

Os autos descrevem detalhadamente as atividades que seriam transferidas da SEPAG à nova unidade - cálculos, reposições ao erário, fichas financeiras, exercícios anteriores, reembolsos e registros financeiros - e as distinguem das atividades de elaboração e conferência da folha.

Entretanto, não consta demonstração suficientemente objetiva de quantitativo de servidores, volume de cálculos ou carga de trabalho que torne indispensável a existência de uma chefia FC-6 autônoma para essa atividade. Esse é, inclusive, um dos elementos que a DG apontou como ainda pendentes na proposta: dimensionamento de servidores, relação entre funções gerenciais e força executora, volume, complexidade e riscos dos serviços.

Assim, os cálculos e registros financeiros permaneceriam no âmbito da SEPAG, mediante segregação interna das tarefas de elaboração, conferência e validação, com trilha documental própria para cálculos retroativos, passivos, reposições ao erário e situações excepcionais.

O controle deve ser obtido pelo processo de trabalho, e não necessariamente pela criação de mais uma chefia.

3.2. Assistentes FC-1

Também não se recomenda a regra automática de uma FC-1 para cada Seção.

A própria DG já identificou a necessidade de justificativa individualizada para essas funções.

As 3 FC-1 já existentes na atual COGEP seriam preservadas na SGP e distribuídas após dimensionamento da força de trabalho, com prioridade às áreas de maior risco e volume, especialmente SEPAG, Saúde e Cadastro/Frequência.

Caso ainda existam FC-1 vagas no Tribunal, deverão ser examinadas para reforço pontual. Em setembro de 2025 havia registro de seis FC-1 vagas, mas esse dado precisa ser atualizado antes da decisão.

3.3. Recursos necessários para essa SGP

A estrutura atual da COGEP possui 1 CJ-2, 5 FC-6 e 3 FC-1.

Para chegar à configuração proposta seriam necessários:

Operação | Recurso
SGP | 1 dos novos CJ-3
COAPE | Atual CJ-2 da COGEP
CODES | Transformação do segundo novo CJ-3 em CJ-2
8 Seções | 5 FC-6 atuais + 3 novas FC-6
Assistentes | 3 FC-1 atuais, sem ampliação automática

Consequentemente, a SGP utilizaria apenas 3 das 7 novas FC-6, permanecendo 4 FC-6 disponíveis para a revisão global.

4. Segundo movimento: reavaliação das elevações de nível promovidas em 2023

A partir da criação da SGP, propõe-se reavaliar as nove elevações de CJ promovidas em 2023, distinguindo-se as razões organizacionais para eventual recalibração dos cargos da necessidade financeira de viabilizar novas unidades.

Não se propõe desfazer as unidades efetivamente criadas naquela oportunidade, como AGEL, SGEC, CSCOR ou outras estruturas que passaram a desempenhar atividades próprias.

A revisão deverá alcançar os nove cargos que já existiam e foram elevados em 2023, examinando, em relação a cada um, a natureza das atribuições, o nível de responsabilidade, o posicionamento na estrutura, o volume e a complexidade dos serviços, os riscos institucionais e os resultados decorrentes da elevação.

O restabelecimento dos níveis anteriores permanece como cenário de referência para a análise financeira, mas sua implementação integral não deve ser considerada automática. A próxima Administração poderá adotar a recalibração total, parcial ou por etapas, de acordo com a instrução técnica, a necessidade financeira efetivamente demonstrada e a avaliação organizacional de cada unidade.

O cenário máximo de restabelecimento dos níveis anteriores seria o seguinte:

Unidade/cargo | Nível atual | Nível anterior
ASPLAN | CJ-3 | CJ-2
Assessor Jurídico-Chefe da ASJUR | CJ-3 | CJ-2
Assessoria Jurídica da Presidência | CJ-3 | CJ-2
Assessor Jurídico Adjunto da ASJUR | CJ-2 | CJ-1
Chefia do GADG | CJ-2 | CJ-1
ASCOM | CJ-2 | CJ-1
Chefia do GAPRES | CJ-2 | CJ-1
Chefia do Gabinete da Corregedoria | CJ-2 | CJ-1
Assessoria Jurídica da Corregedoria | CJ-2 | CJ-1

Nesse cenário, haveria:

3 CJ-3 → 3 CJ-2; e

6 CJ-2 → 6 CJ-1.

A redução dos níveis não tornaria esses cargos disponíveis para nova destinação, pois eles permaneceriam vinculados às respectivas unidades. O efeito das transformações consistiria na geração de diferença financeira, cuja efetiva disponibilidade deverá ser certificada antes de qualquer utilização.

A operação não deve ser apresentada como desvalorização das unidades ou de seus atuais titulares. O objeto da revisão é o cargo, e não a pessoa. Trata-se de avaliar a proporcionalidade dos níveis adotados em 2023 e a possibilidade de direcionar recursos para necessidades estruturais ainda não atendidas.

5. Razão administrativa para a reavaliação dos níveis

Há uma diferença fundamental entre a solução de 2023 e a ora examinada.

Em 2023, as elevações foram viabilizadas por saldo cuja existência estava relacionada às opções remuneratórias das pessoas que ocupavam os CJs. O modelo, portanto, exigia monitoramento contínuo e poderia sofrer alterações conforme a ocupação dos cargos.

A revisão proposta busca avaliar a possibilidade de redução do custo nominal integral de cargos anteriormente elevados, de modo a produzir, caso as transformações sejam aprovadas, espaço estrutural mais estável e menos dependente da opção remuneratória de seus ocupantes.

Isso também evita perpetuar um círculo de equiparações: uma unidade é elevada; outra invoca isonomia; uma terceira aponta posição semelhante; e os recursos passam a financiar progressivamente níveis hierárquicos, sem aumento equivalente da força executora.

A revisão passa a trabalhar com três critérios diferentes: direção estratégica, para a qual se justificam CJ de maior nível; assessoramento técnico especializado, normalmente compatível com CJ-1; e execução operacional, que deve ser fortalecida prioritariamente por FC-6, FC-1 e força de trabalho.

A constatação de que a Assessoria de Dados e Business Intelligence já existe na ASPLAN, com CJ-1 próprio, reduz a necessidade de criação de novos cargos. Assim, eventual recalibração dos nove cargos não deve ser justificada exclusivamente pela obtenção de recursos, mas também pela avaliação objetiva da adequação dos respectivos níveis à estrutura e às atribuições exercidas.

6. Memória preliminar do espaço financeiro

Os autos da SGP registram, a partir de julho de 2026:

CJ-3: R$ 16.665,13;

CJ-2: R$ 14.659,71.

O valor anterior do CJ-1 registrado nos controles era de R$ 10.990,74, enquanto CJ-2 e CJ-3 correspondiam, respectivamente, a R$ 13.573,81 e R$ 15.430,68.

Aplicado o mesmo reajuste de 8% que conduz os valores de CJ-2 e CJ-3 aos montantes vigentes desde julho de 2026, o CJ-1 corresponderia, preliminarmente, a aproximadamente R$ 11.870,00. Esse valor deverá ser formalmente certificado pela SAOF antes da consolidação da proposta.

Considerado o cenário máximo de restabelecimento dos níveis anteriores, a memória preliminar seria:

Operação | Economia mensal estimada
3 CJ-3 → 3 CJ-2 | R$ 6.016,26
6 CJ-2 → 6 CJ-1 | R$ 16.738,26
Subtotal – recalibração dos nove cargos | R$ 22.754,52
Transformação do segundo novo CJ-3 em CJ-2 para a CODES | R$ 2.005,42
Espaço nominal máximo estimado | R$ 24.759,94/mês

A diferença de R$ 2.005,42 entre CJ-3 e CJ-2 consta expressamente das contas já examinadas pela ASJUR.

A proposta atualmente exige apenas um novo CJ-1, destinado à Assessoria de Gestão Documental e Memória, pois a Assessoria de Dados e Business Intelligence será remanejada da ASPLAN para a STI com o CJ-1 que já integra sua estrutura.

Sob o aspecto estritamente aritmético, o cenário máximo de transformação comportaria o valor integral de um CJ-1, estimado em R$ 11.870,00, e apresentaria margem nominal aproximada de R$ 12.889,94. Esse resultado, contudo, não significa que o saldo esteja definitivamente disponível nem que seja necessário promover a redução integral dos nove cargos.

6.1. Limites da memória preliminar

A reestruturação promovida em 2023 utilizou recursos decorrentes do saldo dos 35% tanto para elevações de níveis quanto para outras alterações organizacionais. Como a presente proposta preserva as unidades efetivamente criadas naquela oportunidade, será necessário verificar se parte da economia resultante de eventual recalibração deverá ser utilizada para assegurar a cobertura integral dessas estruturas, independentemente da opção remuneratória de seus atuais ocupantes.

Para subsidiar eventual prosseguimento e consolidação da proposta, a SAOF deverá elaborar memória de cálculo global, contemplando:

I - o custo integral da estrutura anterior à reestruturação de 2023;

II - o custo integral da estrutura atualmente vigente;

III - a identificação das unidades ou transformações ainda custeadas com recursos dependentes das opções remuneratórias dos ocupantes dos cargos em comissão;

IV -o custo integral dos cargos e funções criados pela Lei nº 15.374/2026;

V - o custo integral de cada cenário de transformação considerado, inclusive das alternativas de implementação parcial ou por etapas;

VI - o custo integral da estrutura final projetada; e

VII - o saldo efetivamente disponível após todas as transformações, considerados os valores integrais dos cargos e funções, independentemente da situação remuneratória de seus ocupantes.

Somente após essa apuração será possível definir quais transformações são necessárias e suficientes para viabilizar o CJ-1 destinado à Assessoria de Gestão Documental e Memória, bem como se haverá saldo remanescente para outras necessidades institucionais.

A análise também deverá observar as exigências jurídicas e regulamentares aplicáveis à transformação de cargos em comissão e às providências perante o Tribunal Superior Eleitoral.

7. Aplicação dos recursos às necessidades atuais

A distribuição proposta deixa de seguir a lógica de “quem pediu primeiro” ou “quem possui unidade semelhante” e passa a observar:

risco institucional + transversalidade + lacuna estrutural + melhoria concreta do serviço + possibilidade de solução sem novos recursos.

Com base nesses critérios, apresenta-se, para avaliação da próxima Administração, o seguinte cenário preliminar:

Prioridade | Demanda | Solução proposta | Recurso adicional
1 | Gestão de Pessoas | Criar a SGP no modelo enxuto acima | 1 CJ-3 + transformação de 1 CJ-3 em CJ-2 + 3 FC-6
2 | SECEP/COAUDI | Retirar a SECEP da Auditoria e vinculá-la à Presidência, acompanhada de suas funções atuais | Sem novo recurso
3 | SEUE | Transferir da CIE para a CSCOR | Sem novo recurso
4 | Gestão Documental e Memória | Criar Assessoria de Gestão Documental e Memória vinculada à DG, sem Seções subordinadas, mantendo a SLDAG na SEJUD e o Centro de Memória sob a guarda e a gestão da EJE | 1 CJ-1, sujeito à confirmação financeira e jurídica
5 | Dados e BI | Remanejar para a STI a Assessoria de Dados e Business Intelligence atualmente vinculada à ASPLAN, acompanhada do respectivo CJ-1 e da força de trabalho dedicada às atividades da unidade | Sem novo recurso
6 | Ouvidoria | Elevar para FC-6 a função atribuída ao responsável administrativo da unidade, por simetria com as demais unidades integrantes da alta administração | 1 FC-6
7 | COAUDI | Restituir FC-1 à SEAPTIC, se confirmada disponibilidade | 1 FC-1 já existente ou vaga
8 | ASSAI | Manter a unidade na configuração atual, com a FC-6 e o apoio operacional existente, sem transformação em Assessoria ou criação de CJ-1 | Sem novo recurso
9 | ASPGOVTI | Manter a estrutura atual e reavaliar após o remanejamento de Dados e BI | Nenhum
10 | Reserva para necessidades supervenientes | Preservar 3 FC-6 | 3 FC-6

8. Fundamentação das escolhas

8.1. SECEP: segregação da Auditoria Interna e vinculação à Presidência

A desvinculação da Seção de Exame de Contas Eleitorais e Partidárias - SECEP da COAUDI merece prioridade por envolver questão de segregação de funções, e não necessidade de ampliação remuneratória da unidade. As atividades de exame e instrução das prestações de contas eleitorais e partidárias possuem natureza distinta da função avaliativa e de controle posterior própria da Auditoria Interna.

O levantamento constante dos autos demonstra, ainda, que a solução encontra respaldo na organização da Justiça Eleitoral: apenas quatro TREs mantinham a unidade de contas vinculada à Auditoria, enquanto outros a vinculavam à Secretaria Judiciária ou à Presidência, modelo também adotado pelo TSE em relação à ASEPA.

Considerando a natureza especializada e sensível da atividade, propõe-se desvincular a SECEP da COAUDI e vinculá-la diretamente à Presidência, acompanhada das funções comissionadas e da força de trabalho que atualmente integram sua estrutura.

A medida corrige a vinculação organizacional, fortalece a independência da Auditoria Interna e preserva a capacidade operacional da SECEP, sem necessidade de utilização de novos cargos ou funções criados pela Lei n. 15.374/2026.

8.2. SEUE: correção de um efeito da própria reestruturação de 2023

A transferência da SEUE para a Coordenadoria de Infraestrutura ocorreu no contexto da reforma de 2023. Posteriormente, a própria STI demonstrou que a alteração da força de trabalho tornou a solução desbalanceada e sobrecarregou a CIE.

Considera-se tecnicamente recomendável avaliar o retorno da SEUE à área de maior afinidade operacional, a CSCOR, sem alteração de funções ou cargos.

Custo adicional: zero.

8.3. Gestão Documental e Memória: coordenação integrada e aproveitamento das estruturas existentes

Os processos demonstram a existência de lacuna institucional relacionada à coordenação transversal das políticas de Gestão Documental e de Gestão de Memória. Embora possuam objetos e atividades próprias, ambas integram o PRONAME e exigem atuação articulada entre as áreas de Arquivo, Biblioteca, Memória, Tecnologia da Informação e demais unidades produtoras ou custodiadoras de documentos.

A Gestão Documental compreende os procedimentos relativos à produção, classificação, tramitação, avaliação, destinação, preservação e acesso aos documentos. A Gestão de Memória, por sua vez, volta-se à preservação, valorização e divulgação da história institucional, mediante ações culturais, educativas, museológicas e de difusão do patrimônio histórico.

Considerando a necessidade de otimizar os recursos disponíveis, propõe-se a criação da Assessoria de Gestão Documental e Memória – AGDM, vinculada à Diretoria-Geral, sem a criação inicial de Seções subordinadas. A unidade exercerá funções de coordenação técnica e administrativa, integração institucional, acompanhamento dos instrumentos do PRONAME e apoio às instâncias responsáveis pelas políticas de Gestão Documental e de Memória.

A criação da AGDM não importará transferência para a Diretoria-Geral do Centro de Memória nem alteração das competências atribuídas à Escola Judiciária Eleitoral. Nos termos das Resoluções TRE-AC n. 1.647/2011 e n. 1.786/2023, o Centro de Memória e seus ambientes físico e virtual permanecerão sob a guarda e a gestão da EJE, que continuará responsável pela execução das ações culturais, educativas, museológicas e de divulgação da memória institucional.

A Comissão de Gestão da Memória da Justiça Eleitoral do Acre - CMJEAC permanecerá como instância colegiada responsável pela coordenação da política institucional de memória, cabendo à AGDM prestar-lhe suporte técnico e administrativo e promover a articulação de suas deliberações com as demais unidades do Tribunal.

A Seção de Legislação, Documentação e Arquivo-Geral - SLDAG permanecerá vinculada à Secretaria Judiciária, preservadas suas atribuições relacionadas à legislação, documentação, biblioteca, arquivo geral e execução dos procedimentos arquivísticos sob sua responsabilidade. A SLDAG atuará de forma articulada com a AGDM na implementação da política institucional de Gestão Documental, sem alteração de sua subordinação administrativa.

Nesse arranjo, a AGDM não exercerá subordinação hierárquica sobre a SLDAG, a EJE ou a CMJEAC. Caber-lhe-á promover a coordenação técnica e administrativa necessária à integração das políticas, respeitadas a subordinação da SLDAG à SEJUD, a guarda e a gestão do Centro de Memória pela EJE e as competências colegiadas da CMJEAC.

O modelo observa a Resolução CNJ n. 324/2020, que distingue as atividades de Gestão Documental e de Gestão de Memória e determina a interlocução entre as áreas de Arquivo, Museu, Memorial, Biblioteca e Gestão Documental, sem estabelecer que devam integrar a mesma unidade ou possuir idêntica vinculação hierárquica.

A Assessoria deverá atuar como unidade central de coordenação da política de Gestão Documental, enquanto a SLDAG permanecerá como unidade executora e custodiante do Arquivo-Geral. No eixo da Memória, a AGDM prestará apoio técnico e administrativo à integração institucional, sem substituir as atribuições normativas da EJE e da CMJEAC.

A solução permite estabelecer coordenação transversal para as duas políticas, preservar as estruturas e competências já existentes e evitar, neste momento, a criação de Coordenadoria ou de novas Seções. A necessidade de reforço funcional poderá ser reavaliada após a implantação do modelo e a mensuração de sua carga de trabalho e de seus resultados.

Recurso proposto: 1 CJ-1, a ser viabilizado por transformação somente após a confirmação financeira pela SAOF e a análise jurídica. A FC-6 anteriormente considerada para a criação de unidade específica de Memória permanecerá na reserva institucional.

8.4. Dados e Business Intelligence

A Assessoria de Dados e Business Intelligence já integra a estrutura da ASPLAN, com cargo em comissão CJ-1, embora suas atividades possuam natureza predominantemente tecnológica e estejam diretamente relacionadas à arquitetura, integração, tratamento, qualidade, análise e disponibilização de dados.

Não se propõe, portanto, a criação de nova Assessoria nem a utilização de cargo adicional. Propõe-se o remanejamento da Assessoria de Dados e Business Intelligence da ASPLAN para a STI, acompanhada do respectivo CJ-1 e da força de trabalho atualmente dedicada às suas atividades.

A medida corrige a vinculação organizacional sem aumento de despesa e sem consumo dos recursos criados pela Lei nº 15.374/2026 ou das diferenças financeiras decorrentes das demais transformações propostas.

A transferência também permite delimitar de forma mais clara as competências: a ASPGOVTI permanecerá responsável pelo planejamento e pela governança de TIC, enquanto a Assessoria de Dados e Business Intelligence se concentrará na arquitetura, integração, tratamento, qualidade, análise e disponibilização de dados institucionais.

O remanejamento deverá ser acompanhado de ajuste das competências da ASPLAN e da STI, bem como da verificação dos impactos sobre a força de trabalho das unidades envolvidas.

Recurso adicional: nenhum, por se tratar de remanejamento da unidade e do CJ-1 já existente.

8.5. ASPGOVTI

O pedido de transformação da ASPGOVTI em Assessoria CJ-2 possui mérito quanto à importância da governança de TIC. Entretanto, o próprio requerimento afirma que as competências poderiam permanecer inalteradas e utiliza como um dos fundamentos a isonomia com outra unidade.

No modelo ora proposto, não se recomenda a elevação.

A unidade deve permanecer no nível atual e ser reavaliada após o remanejamento da Assessoria de Dados e Business Intelligence para a STI, quando será possível mensurar o novo arranjo de atribuições.

Essa decisão é coerente com o princípio central da revisão: nível remuneratório não deve decorrer de equiparação, mas da natureza efetiva da função exercida.

8.6. Ouvidoria

A Ouvidoria apresenta demanda diferenciada.

Os autos registram que se trata de unidade integrante da alta administração, que possui apenas um servidor efetivo e cuja função administrativa máxima permanece em FC-5, diferentemente das demais unidades desse mesmo nível institucional.

Nesse caso, a simetria não se apresenta como mera equiparação remuneratória entre unidades de naturezas distintas. A Ouvidoria integra a alta administração e se encontra, objetivamente, em patamar inferior ao conferido às demais unidades integrantes desse mesmo nível da estrutura, que contam, no mínimo, com FC-6.

A adequação para FC-6 mostra-se, assim, razoável e proporcional, por corrigir assimetria interna sem criação de cargo em comissão ou ampliação de níveis hierárquicos.

Propõe-se, portanto, destinar uma das FC-6 criadas pela Lei nº 15.374/2026 ao responsável administrativo da Ouvidoria Eleitoral, ficando a atual FC-5 disponível para remanejamento conforme as demais necessidades institucionais.

Eventual necessidade de reforço da força de trabalho da unidade deverá ser examinada separadamente, no âmbito do dimensionamento institucional.

8.7. COAUDI

A COAUDI solicitou especificamente a restituição de uma FC-1 anteriormente vinculada à SEAPTIC e registrou, à época, a existência de seis FC-1 vagas.

Para eventual implementação da medida, será necessária a atualização, pela COGEP, do quadro de funções vagas. Confirmada a disponibilidade, poderá ser priorizada a restituição de uma FC-1 à SEAPTIC.

8.8. ASSAI

A proposta formulada pela ASSAI pretende sua transformação em Assessoria de Sustentabilidade, Acessibilidade e Inclusão, mediante criação de cargo em comissão CJ-1, com manutenção da FC-6 atualmente existente. Na versão mais recente, prevê-se ainda a devolução à Diretoria-Geral da FC-1 atualmente utilizada como apoio à unidade.

Os autos demonstram a relevância e a progressiva ampliação das atribuições relacionadas à sustentabilidade, acessibilidade e inclusão. Demonstram, igualmente, que a deficiência inicialmente identificada estava especialmente relacionada à insuficiência da força de trabalho. Em 2025, a Administração adotou medidas concretas de reforço, elevando a função da titular para FC-6 e lotando segundo servidor na ASSAI, mediante utilização de FC-1 da Diretoria-Geral.

As normas do CNJ invocadas no processo estabelecem requisitos relacionados à existência, permanência e adequada composição das unidades de sustentabilidade e acessibilidade, inclusive quanto à suficiência de pessoal, mas não condicionam seu atendimento à classificação da unidade como Assessoria nem à atribuição de cargo em comissão CJ-1.

Considerando que a transformação pretendida não ampliaria a capacidade executora da unidade, mas importaria essencialmente em elevação de seu nível hierárquico e remuneratório, propõe-se manter a ASSAI em sua configuração atual, com a FC-6 e o apoio operacional existente, sem criação de CJ-1, preservada a possibilidade de reavaliação da força de trabalho sempre que demonstrada necessidade.

9. Quadro financeiro e estrutural dos recursos

9.1. FC-6 criadas pela Lei n, 15.374/2026

Destinação | Quantidade
Novas Seções da SGP | 3
Ouvidoria Eleitoral | 1
Reserva institucional | 3
Total | 7

A criação da Assessoria de Gestão Documental e Memória sem Seções subordinadas permite preservar em reserva a FC-6 anteriormente considerada para uma unidade específica de Memória. A execução das atividades permanecerá apoiada nas estruturas já existentes da EJE, da SLDAG e da CMJEAC.

Com a destinação de uma das novas FC-6 à Ouvidoria, a atual FC-5 da unidade ficará disponível para remanejamento conforme as necessidades institucionais. Permanecem, ainda, 3 FC-6 novas em reserva.

Essa reserva não representa falta de planejamento. Evita o comprometimento integral dos recursos antes de serem conhecidos os efeitos da nova estrutura e as necessidades supervenientes.

Para eventual implementação do cenário proposto, será necessária a apresentação, pela COGEP, de mapa atualizado das funções comissionadas vagas ou passíveis de remanejamento, especialmente das FC-1, bem como o registro da disponibilidade da FC-5 que poderá decorrer da adequação da estrutura da Ouvidoria.

9.2. Cargos em comissão

Movimento | Resultado estrutural ou financeiro
Transformação de 3 CJ-3 em 3 CJ-2, no cenário máximo | Manutenção dos mesmos cargos nas respectivas unidades, em níveis inferiores, e geração de diferença financeira

Transformação de 6 CJ-2 em 6 CJ-1, no cenário máximo | Manutenção dos mesmos cargos nas respectivas unidades, em níveis inferiores, e geração de diferença financeira
1 novo CJ-3 | Secretaria de Gestão de Pessoas

Transformação de 1 novo CJ-3 em CJ-2 | CODES e geração de diferença financeira
CJ-2 atual da COGEP | COAPE

Diferença financeira decorrente das transformações | Possibilidade de criação, por transformação, de 1 CJ-1, sujeita à confirmação financeira e jurídica
Novo CJ-1 | Assessoria de Gestão Documental e Memória
CJ-1 atualmente vinculado à Assessoria de Dados e BI na ASPLAN | Remanejamento, com a respectiva unidade, para a STI

A redução dos níveis dos nove cargos não os torna disponíveis para nova destinação. O resultado das transformações consiste na geração de diferença financeira que poderá, caso confirmada sua efetiva disponibilidade, viabilizar o CJ-1 destinado à Assessoria de Gestão Documental e Memória.

Como apenas um novo CJ-1 é necessário, caberá à instrução técnica demonstrar se a criação da AGDM exige o restabelecimento integral dos nove cargos aos níveis anteriores ou se poderá ser viabilizada mediante transformação parcial ou implementação por etapas. Qualquer escolha deverá observar critérios objetivos e tratamento organizacional coerente entre unidades equivalentes.

9.3. Força de trabalho

Além da disponibilidade de cargos e funções, a implementação das novas unidades e dos remanejamentos dependerá da definição da respectiva força de trabalho.

A COGEP deverá indicar os servidores passíveis de lotação na Secretaria de Gestão de Pessoas e na Assessoria de Gestão Documental e Memória, especificando sua origem, formação ou experiência compatível e os impactos sobre as unidades de procedência.

Quanto à Assessoria de Dados e Business Intelligence, deverá ser identificado o quadro atualmente dedicado às atividades da unidade e avaliado seu remanejamento para a STI, juntamente com o CJ-1 existente.

O dimensionamento deverá considerar, ainda, os dez cargos efetivos criados para o TRE-AC pela Lei nº 15.374/2026 e as prioridades definidas para o respectivo provimento.

10. Estrutura resultante recomendada

Caso implementado o cenário proposto, o Tribunal poderá alcançar, simultaneamente, os seguintes resultados:

1. Secretaria de Gestão de Pessoas criada com duas Coordenadorias equilibradas e oito Seções executoras, sem Seção autônoma de Cálculos e sem atribuição automática de FC-1 a todas as Seções;

2. correção da vinculação da SECEP, eliminando incompatibilidade com a Auditoria;

3. correção da vinculação da SEUE, reduzindo a sobrecarga identificada na STI;

4. criação da Assessoria de Gestão Documental e Memória, vinculada à Diretoria-Geral e sem Seções subordinadas, com preservação da SLDAG na estrutura da SEJUD e do Centro de Memória sob a guarda e a gestão da EJE;

5. remanejamento da Assessoria de Dados e Business Intelligence da ASPLAN para a STI, acompanhada do respectivo CJ-1, sem utilização de novo recurso;

6. adequação da função administrativa da Ouvidoria ao nível FC-6, ficando disponível para remanejamento a atual FC-5;

7.  recomposição pontual da COAUDI, se confirmada a disponibilidade de FC-1;

8. manutenção da ASSAI em sua configuração atual, com FC-6 e apoio operacional existente, sem criação de CJ-1;

9. preservação da ASPGOVTI, sem promover nova elevação fundada em isonomia; e

10. manutenção de reserva de 3 FC-6, além da FC-5 que poderá ser liberada pela adequação da Ouvidoria, para necessidades que venham a ser demonstradas objetivamente.

11. Conclusão proposta para o estudo

A análise histórica demonstra que a estrutura atual do TRE-AC resultou de sucessivas alterações, entre as quais assume especial relevância a reestruturação promovida em 2023 mediante utilização dos recursos decorrentes do saldo dos 35% dos cargos em comissão.

Aquela reforma contemplou medidas estruturantes, especialmente a criação de unidades destinadas ao atendimento de necessidades institucionais específicas, como a Assessoria de Gestão Eleitoral - AGEL, a Seção de Gestão de Contratos - SGEC e unidades da Secretaria de Tecnologia da Informação, mas também promoveu a elevação de três cargos CJ-2 para CJ-3 e de seis cargos CJ-1 para CJ-2 sem correspondente criação de novas unidades ou ampliação direta da capacidade executora.

As demandas posteriormente apresentadas pela Gestão de Pessoas, Auditoria, Ouvidoria, Gestão Documental, Memória e Tecnologia da Informação evidenciam que permanecem assimetrias e lacunas relevantes, razão pela qual se mostra oportuno reexaminar o emprego desses recursos sob perspectiva institucional mais ampla.

Propõe-se, assim, como alternativa a ser avaliada pela próxima Administração, a reavaliação dos nove cargos cuja elevação decorreu da reestruturação de 2023, considerando critérios objetivos relacionados às atribuições, responsabilidades, complexidade, riscos e resultados de cada unidade. O restabelecimento integral dos níveis anteriores constitui cenário de referência, mas a implementação poderá ser total, parcial ou por etapas, conforme os resultados da instrução técnica.

A criação da Secretaria de Gestão de Pessoas é indicada neste estudo como primeira prioridade da revisão, em consonância com a diretriz anteriormente estabelecida pela Presidência, porém mediante estrutura redimensionada, composta por duas Coordenadorias e oito Seções, sem criação autônoma de unidade de cálculos e sem vinculação automática de FC-1 a todas as Seções.

A combinação dos recursos criados pela Lei n. 15.374/2026 com as transformações e os remanejamentos propostos permite, desde logo, identificar como estruturalmente viáveis a criação da SGP no modelo reduzido, a adequação da Ouvidoria, a preservação de 3 FC-6 em reserva e os remanejamentos da SECEP, da SEUE e da Assessoria de Dados e Business Intelligence, esta última acompanhada do CJ-1 já existente na ASPLAN.

A criação da Assessoria de Gestão Documental e Memória, por exigir um novo CJ-1, permanece condicionada à certificação do custo global da estrutura pela SAOF, à confirmação da efetiva disponibilidade financeira, à análise jurídica das transformações e à definição da força de trabalho necessária.

No eixo de Gestão Documental e Memória, o modelo busca otimizar os recursos disponíveis mediante a criação de uma única Assessoria CJ-1, sem novas Seções subordinadas, preservando a SLDAG na SEJUD, o Centro de Memória sob a guarda e a gestão da EJE e a CMJEAC como instância colegiada de coordenação da política de memória.

No eixo de Dados e BI, a proposta não cria unidade nem cargo. Limita-se a remanejar para a STI a Assessoria atualmente existente na ASPLAN, acompanhada do respectivo CJ-1 e da força de trabalho dedicada às atividades, corrigindo sua vinculação sem aumento de despesa.

A solução privilegia a função institucional antes da hierarquia, a capacidade executora antes da equiparação remuneratória e a necessidade demonstrada antes da distribuição dos recursos, oferecendo desenho mais equilibrado para a realidade e o porte do TRE-AC.

A adequação proposta para a Ouvidoria não contraria essa premissa, por decorrer de assimetria objetiva entre unidades integrantes do mesmo nível institucional, solucionada de forma proporcional mediante FC-6, sem criação de cargo em comissão.

A configuração apresentada possui caráter técnico e preliminar, devendo sua eventual consolidação ser precedida da certificação, pela SAOF, dos valores integrais dos cargos e funções envolvidos e da memória de cálculo global das transformações, bem como da apresentação, pela COGEP, do quadro atualizado das funções comissionadas vagas ou disponíveis para remanejamento e do dimensionamento da força de trabalho.

Caso a próxima Administração considere oportuno o prosseguimento da proposta, esta poderá ser ajustada aos resultados da instrução técnica e submetida à análise jurídica quanto à viabilidade das transformações e dos remanejamentos, à delimitação das competências das unidades envolvidas e às providências exigidas pela regulamentação do Tribunal Superior Eleitoral, antes da elaboração da minuta de resolução e de sua submissão às instâncias competentes.

12. Encaminhamento à próxima Administração

Considerando o encerramento da gestão da Excelentíssima Senhora Desembargadora Waldirene Cordeiro à frente do Tribunal Regional Eleitoral do Acre, registra-se que o presente estudo integra o conjunto de informações destinado a subsidiar a transição administrativa.

A proposta ora apresentada possui caráter técnico e preliminar, não importando decisão administrativa nem vinculação da gestão subsequente. Seu objetivo é preservar a memória dos levantamentos realizados, das alternativas examinadas e das questões ainda pendentes de instrução, especialmente quanto à certificação dos impactos financeiros pela SAOF, à atualização do quadro de cargos e funções e ao dimensionamento da força de trabalho pela COGEP e à posterior análise jurídica das transformações e dos remanejamentos eventualmente considerados.

Assim, providencie o Gabinete da Diretoria-Geral o relacionamentos dos demais processos solicitando alteração de estrutura a este SEI.

Em seguida, encaminhem-se estes autos ao Senhor Chefe de Gabinete, para submissão ao Diretor-Geral, com vistas ao conhecimento e à oportuna apreciação das propostas e, caso entenda pertinente, à juntada aos demais documentos relativos à reestruturação que a próxima Administração porventura pretenda promover.

À nova Administração caberá definir a conveniência, a oportunidade e a prioridade das medidas propostas, podendo acolhê-las, ajustá-las, implementá-las por etapas ou determinar estudos complementares, conforme suas diretrizes e as necessidades institucionais do Tribunal.

</0000690-49.2023.6.01.8000>  

---

<0001059-72.2025.6.01.8000>  

Proposta de criação da Secretaria de Gestão de Pessoas

---
Informação Nº 0773307 - PRESI/DG/COGEP

Senhor Diretor,

 

Trata-se de proposta para a criação da Secretaria Secretaria de Gestão de Pessoas deste Tribunal. 

 

Esclareço inicialmente que tramita no Congresso Nacional o Projeto de Lei n. 4/2024, de autoria do TSE, que cria cargos efetivos, cargos em comissão e funções comissionadas no Quadro de Pessoal daquele Superior e dos TRE's e que, se aprovado, serão expedidas as instruções necessárias à aplicação da respectiva lei.

 

Conforme aquele PL, no TRE/AC são previstos os acréscimos de 5 cargos de Analista Judiciário, 5 Cargos de Técnico Judiciário, e a criação de 2 CJ-3 e de 7 FC-6.

 

Como prevê o Código Eleitoral, art. 30, II, aos Tribunais Regionais Eleitorais cabe, dentre outras atribuições, organizar a sua Secretaria, provendo-lhes os cargos na forma da lei. Por sua vez, a Lei n. 11.416/2006, no art. 24, prevê que os órgãos do Poder Judiciário da União fixarão em ato próprio a lotação dos cargos efetivos, das funções comissionadas e dos cargos em comissão de sua estrutura.

 

No âmbito da Justiça Eleitoral o TSE definiu, na Resolução n. 22.138/205, no art. 9º, que aos TRE's incumbirá o detalhamento das respectivas estruturas organizacionais e a distribuição dos cargos em comissão e funções comissionadas, que devem guardar simetria de competências com a daquele Superior.

 

Se objetiva que a Coordenadoria de Gestão de Pessoas, não contemplada com melhorias nas últimas reestruturações ocorridas neste Regional, apesar das inúmeras atividades ordinárias em que atua, somadas às diversas outras atribuições que foram acrescidas com o passar dos anos, seja transformada em Secretaria, a exemplo dos demais Regionais. Aliás, este TRE é o único do país em que a unidade de gestão de pessoas ainda está em nível de Coordenadoria e não de Secretaria, visto que outros tribunais de porte idêntico, como o do Amapá e o de Roraima, ante as necessidades, possuem Secretaria de Gestão de Pessoas em suas estruturas. 

 

Na atual situação, diversas atividades não podem ser melhor desenvolvidas, a exemplo da atuação efetiva no plano estratégico de gestão de pessoas, a instituição de comitê de governança, riscos e controles, objetivando o aprimoramento da governança e o gerenciamento de riscos na área, a análise e avaliação de norma interna para verificação dos perfis profissionais para ocupação de liderança, permitindo que as escolhas para funções de confiança ou cargo em comissão sejam fundadas em perfis definidos, o planejamento da força de trabalho, a implantação da gestão por competência, as melhorias dos indicadores de governança e gestão de pessoas etc. Não se pode também, deixar de mencionar quanto a inexistência de unidade de legislação na COGEP, estando a análise jurídica de pessoal afeta à ASJUR do Tribunal, que também atua em diversos outros assuntos de interesse das unidades.

 

Efetivando-se a criação da SGP neste TRE, será possível maior atendimento às previsões contidas na Resolução CNJ n. 240/2016, que dispõe sobre a Política Nacional de Gestão de Pessoas no Poder Judiciário.

 

É temerária a situação atual e poderá refletir nas respostas a diversas atribuições previstas e as que surgem a cada dia.

 

Se não é possível, no momento, criar a Secretaria de Gestão de Pessoas - SGP, com as Coordenadorias de Desenvolvimento, de Pessoal e de Saúde e Qualidade de Vida, e dotar o TRE Acre de estruturação semelhante a dos demais, ante a limitação de recursos e de pessoal, que se aguarde a aprovação do predito PL para efetivar a referida criação, mas que tenhamos a proposta da referida criação tramitando.

 

Conforme proposta de organograma juntado no evento 0783331, se pretende a criação da SGP, com as seguintes unidades vinculadas:

 

I) Gabinete, vinculado diretamente à SGP, com a chefia de gabinete I correspondente, retribuída com uma FC-5, a exemplo das demais secretarias deste TRE;

 

II) Coordenadoria de Desenvolvimento, vinculada diretamente à SGP, retribuída com uma CJ-2, tendo as seguintes unidades vinculadas:

a) Seção de Acompanhamento, Avaliação e Desenvolvimento, retribuída com uma FC-6;

b) Seção de Capacitação, retribuída com uma FC-6;

 

Se propõe o desmembramento da Seção de Capacitação e Desenvolvimento em Seção de Acompanhamento, Avaliação e Desenvolvimento, e a Seção de Capacitação, visto que na atual estrutura uma única unidade-SEDES, labora naquelas situações. Com isso, uma Seção atuaria na capacitação, com o efetivo planejamento de cursos, elaboração e acompanhamento do Plano Anual de Capacitação, acompanhamento do orçamento respectivo e outras atividades correlatas, ao passo que a Seção de Acompanhamento, Avaliação e Desenvolvimento atuaria na análise de servidores quanto aos perfis profissionais, com sugestão de unidade de lotação, acompanhamento de processos relativos a adicionais de qualificação, acompanhamento do estágio probatório, atuação na atividades afetas à gestão por competência, ainda não efetivada, contratação e acompanhamento de estagiários para a Secretaria e Cartórios etc. Hoje, é a SEDES que lida com todos esses assuntos.

 

Pela proposta, então, a Seção de Capacitação e Desenvolvimento - SEDES passaria a ser uma unidade vinculada à Coordenadoria de Desenvolvimento, sendo criada a Seção de Capacitação, e as respectivas assistências - FCs -1 subordinadas.

 

III) Coordenadoria de Saúde e Qualidade de vida, vinculada à SGP, retribuída com uma CJ-2, com as seguintes unidades vinculadas:

a) Seção de Atenção à Saúde, retribuída com uma FC-6;

b) Seção de Benefícios, retribuída com uma FC-6.

 

Assim, se propõe a criação de uma Coordenadoria específica de Saúde e Qualidade de Vida, com duas unidades vinculadas, a Seção de Atenção à Saúde e a Seção de Benefícios, passando uma unidade de atenção à saúde, voltada às diversas atribuições que envolvem a saúde de magistrados e servidores, e uma unidade voltada aos benefícios.

 

Atualmente, tais atividades estão concentradas na SASBEN, o que não tem se demonstrado adequado, pois tem que lidar desde a elaboração de TR para contratações afetas à área de saúde, até o lançamento e acompanhamento de licenças médicas e perícias, benefícios como auxílio-alimentação, auxílio-creche, além de contato com servidores e as atribuições afetas ao plano de saúde que abrange os mesmos.

 

Dessa forma, também será possível avançar nas exigências advindas do CNJ, a exemplo da Resolução n. 343/20, daquele Conselho. 

 

Como previsto, então, uma unidade atuará com a área de saúde e qualidade de vida, e a outra com benefícios, a exemplo do que ocorre em outros órgãos da Justiça Eleitoral, em que a unidade de benefícios é desvinculada de qualquer outra.

 

Também se propõe a vinculação das respectivas Funções Comissionadas - FC 1 àquelas seções.

 

IV) Coordenadoria de Pessoal, vinculada diretamente à SGP, retribuída com uma CJ-2, tendo as seguintes unidades vinculadas:

a) Seção de Cadastros e Registros Funcionais, retribuída com uma FC-6;

b) Seção de Folha de Pagamento, retribuída com uma FC-6;

c) Seção de Apoio, Registro de Magistrados, de Inativos e de Legislação, retribuída com uma FC-6;

 

Ante necessidade de serviço e as diversas atribuições afetas à SECARF e à SEPAG, se propõe que vinculadas às mesmas estejam 2 Assistências - FC-1 para cada uma, para a melhor desenvolvimento das atividades, e uma Assistência vinculada à Seção de Apoio, Registro de Magistrados, de Inativos e de Legislação, visto que deverá atuar também com a legislação de pessoal. 

 

As responsabilidades afetas à SECARF e à SEPAG não mais suportam apenas uma Assistência, o que tem se mostrado insuficiente ante as demandas cada vez mais crescentes, devendo haver uma melhor estruturação das mesmas. A SECARF lida com toda a vida funcional do servidor efetivo, cedido e requisitado, como cadastro no sistema, averbação, expedição de certidão, informações no sistema Sigepro, expedição de CTC, registro e controle de banco de horas, anotação de ponto, fechamento de ponto, apuração de serviço extraordinário, publicação no transparência, anotação e controle de férias, atendimento a servidor etc.

 

Quanto a SEPAG, as atribuições não se resumem a elaboração de folhas de pagamentos de Juízes da Corte e Eleitorais, Membros do Ministério Público Eleitoral e dos servidores deste TRE, folhas suplementares, folhas de 13º salário, de serviço extraordinário, expedição de informações advindas de órgãos ou unidades de controle, mas atuam, dentre outros, na elaboração da DIRF, na apuração de valores de serviços extraordinários, no sistema e-social, na publicação do transparência, na expedição de CTC relativa a remuneração recebida, na apuração de valores de pessoal para informe à unidade orçamentária, na apuração de valores retroativos, quando autorizado o pagamento, no atendimento a servidores ativos e inativos quanto a pagamentos. A estrutura mínima pode acarretar até mesmo reprimenda a este órgão, ante a necessidade, por exemplo, de cumprimento de prazos para prestar esclarecimentos aos órgãos de controle.

 

Assim, a vinculação de 2 Assistências (FC 1) para cada uma daquelas unidades servirá para a melhoria dos serviços nas referidas unidades.

 

Em relação a atual SAREMI, se propõe seja também atribuída a incumbência de atuar com a legislação de pessoal, visto que atualmente a COGEP não possui nenhuma unidade que assim atue. Com isso, também fará manifestações afetas àqueles normativos, bem como na elaboração de normas internas, subsidiando a Coordenadoria e a SGP na tomada de decisões. Vinculada à unidade, se propõe uma assistência - FC-1.

 

Posteriormente, acaso efetivada a reestruturação como se propõe nesta manifestação, deverão ser definidas as respectivas atribuições no Regimento Interno da Secretaria. 

 

É a proposta que envio à Diretoria.

 
---

Proposta

 

PROPOSTA DE REESTRUTURAÇÃO DA ÁREA DE GESTÃO DE PESSAS

 

Trata-se de proposta de reestruturação da atual Coordenadoria de Gestão de Pessoas, com vistas à sua transformação em Secretaria de Gestão de Pessoas, considerando os documentos já juntados aos autos, a crescente complexidade das atribuições desempenhadas pela unidade e a necessidade de conferir maior racionalidade administrativa, especialização das atividades, melhor distribuição das responsabilidades e fortalecimento da governança de pessoas no âmbito deste Tribunal.

A área de gestão de pessoas exerce papel essencial e estratégico para o funcionamento da Justiça Eleitoral, pois concentra atividades relacionadas à vida funcional de magistradas, magistrados, servidoras, servidores, requisitados, cedidos, inativos, pensionistas, estagiários e demais colaboradores, além de atuar em matérias sensíveis como folha de pagamento, cadastro funcional, frequência, capacitação, desenvolvimento, saúde, benefícios, qualidade de vida, legislação de pessoal, apoio aos inativos e cadastro de magistrados.

Nesse contexto, verifica-se que a atual estrutura da COGEP não mais se mostra suficiente para absorver, com a eficiência necessária, o conjunto de atribuições que foram incorporadas à unidade ao longo dos anos, especialmente diante das novas exigências normativas, dos controles internos e externos, da gestão por competências, do eSocial, da saúde ocupacional, da capacitação continuada, da valorização da força de trabalho e das políticas de desenvolvimento de pessoas no âmbito do Poder Judiciário.

A reestruturação ora proposta busca conferir maior racionalidade administrativa, especialização das atividades, melhor distribuição das responsabilidades e fortalecimento da governança de pessoas, promovendo uma divisão mais equilibrada das atribuições entre unidades voltadas à administração da vida funcional e aquelas destinadas ao desenvolvimento, saúde e valorização da força de trabalho.

 

Assim, propõe-se a transformação da atual Coordenadoria de Gestão de Pessoas em Secretaria de Gestão de Pessoas – SGP, retribuída com CJ-3, estruturada com duas Coordenadorias, ambas retribuídas com CJ-2, denominadas:

I - Coordenadoria de Administração de Pessoas – COAPE – CJ-2; e

II - Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES – CJ-2.

 

1. Estrutura proposta

 

I - Secretaria de Gestão de Pessoas – SGP – CJ-3

Unidade responsável pela direção, coordenação superior, planejamento, supervisão e integração das políticas, programas, projetos e atividades relacionados à gestão de pessoas no âmbito do Tribunal.

Compete à Secretaria orientar estrategicamente as unidades subordinadas, propor normas e aperfeiçoamentos, acompanhar indicadores, promover a governança de pessoas, subsidiar a Administração nas decisões da área e assegurar o alinhamento das ações de gestão de pessoas às diretrizes institucionais, às normas do TSE e do CNJ e aos objetivos estratégicos do Tribunal.

 

II - Coordenadoria de Administração de Pessoas – COAPE – CJ-2

Unidade responsável pela coordenação das atividades relacionadas à administração da vida funcional, cadastro, frequência, folha de pagamento, cálculos financeiros, registros funcionais, apoio aos inativos e cadastro de magistrados, bem como demais matérias relacionadas à gestão administrativa de pessoal.

Ficam vinculadas à COAPE as seguintes unidades:

 

a) Seção de Cadastro – FC-6

À Seção de Cadastro compete registrar o provimento e a vacância dos cargos, bem como os cargos, as funções, o cadastro funcional, a lotação de servidores, as averbações e as aposentadorias em sistema próprio.

Compete-lhe, ainda, registrar as designações e dispensas de funções comissionadas, bem como as nomeações e exonerações dos cargos em comissão e das funções comissionadas, além de expedir certidões de tempo de serviço e contribuição e verificar o cumprimento dos requisitos legais para investidura em cargos e funções.

A unidade também é responsável por organizar e manter atualizado o registro dos servidores em teletrabalho, trabalho híbrido e trabalho presencial, bem como a relação de dados cadastrais dos servidores requisitados, realizando, ainda, a análise técnica dos processos requisitórios.

Cabe, ainda, à Seção de Cadastro fornecer mensalmente à SEPAG os subsídios necessários ao pagamento ou aos descontos relativos às atividades de servidoras e servidores que tiverem reflexos financeiros, consolidar as informações relativas à unidade para publicação no sítio eletrônico do Tribunal e atualizar o rol de responsáveis do Tribunal para lançamento em sistema próprio, quando necessário.

Compete, por fim, lançar em sistemas próprios, quando for o caso, as informações atinentes às suas atividades, bem como desenvolver outras atividades inerentes à sua finalidade, determinadas pelo superior hierárquico.

A Seção de Cadastro contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

b) Seção de Frequência – FC-6

À Seção de Frequência compete controlar a frequência dos servidores, elaborar e controlar a escala de férias, registrar licenças e outros afastamentos, bem como manter o controle dos dias a compensar a que fazem jus os servidores.

Compete-lhe, ainda, encaminhar aos órgãos cedentes a comunicação da frequência mensal dos servidores requisitados e cedidos da Secretaria, realizar o cadastro biométrico no equipamento de ponto desta Secretaria e manter o controle dos registros de frequência dos servidores, das substituições, do serviço extraordinário, do banco de horas e de suas formas de compensação, efetuando os lançamentos quando determinado pela autoridade superior.

A unidade também é responsável por apurar a frequência mensal dos servidores e o banco de horas, com vistas à elaboração das respectivas folhas de pagamento e à realização de acertos de contas.

Cabe, ainda, à Seção lançar em sistemas próprios, quando for o caso, as informações atinentes às suas atividades, bem como desenvolver outras atividades inerentes à sua finalidade, determinadas pelo superior hierárquico.

A Seção de Frequência contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

c) Seção de Apoio aos Inativos e Cadastro de Magistrados – SAREMI – FC-6

À Seção de Apoio aos Inativos e Cadastro de Magistrados compete atuar nas atividades de apoio, registro e acompanhamento relacionadas a magistrados, inativos, pensionistas e demais beneficiários vinculados à gestão de pessoas, inclusive quanto à instrução de processos, manutenção de registros, atualização cadastral, prestação de informações, apoio à análise de direitos e atendimento aos interessados.

Compete ainda à SAREMI prestar apoio técnico em matérias relacionadas à legislação de pessoal, quando demandada, subsidiando a Coordenadoria e a Secretaria na instrução de processos administrativos, elaboração de manifestações, consolidação de informações e cumprimento de determinações superiores.

A SAREMI contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

d) Seção de Cálculos e Registros Financeiros – SCRF – FC-6

À Seção de Cálculos e Registros Financeiros compete executar as atividades de cálculos necessárias ao pagamento dos servidores e autoridades, abrangendo o pagamento de indenizações, reembolsos, gratificações aos magistrados e demais autoridades, restituições ao Erário, banco de horas e serviços extraordinários.

Compete-lhe, ainda, prestar informações constantes dos registros financeiros de servidores, emitindo certidões, atestados e declarações aos interessados sobre elementos constantes das fichas financeiras individuais, quando solicitado, bem como controlar processos de reposição ao erário, inclusive parcelamentos e demais devoluções de valores recebidos indevidamente por servidores, magistrados, pensionistas e demais beneficiários.

A unidade também é responsável por manter atualizados os registros financeiros funcionais e históricos de pagamentos, descontos, tributos e contribuições sociais dos servidores, autoridades e beneficiários de pensão, com vistas a subsidiar informações necessárias à instrução de procedimentos administrativos e ao pagamento dos direitos decorrentes da prestação dos serviços.

Cabe à Seção fornecer os dados necessários ao cumprimento das obrigações fiscais, previdenciárias e trabalhistas relacionadas aos registros financeiros sob sua responsabilidade, bem como efetuar o cálculo dos valores dos proventos de aposentadorias e pensões dos beneficiários, com vistas à instrução dos respectivos procedimentos de concessão e pagamento.

Compete, ainda, prestar informações em processos, procedimentos e expedientes que versem sobre dados e cálculos de vencimentos, proventos, vantagens e descontos, inclusive quando se referirem a exercícios pretéritos, mantendo sob sua responsabilidade as fichas financeiras individuais dos servidores, magistrados, pensionistas e demais beneficiários da folha.

Por fim, cabe à Seção de Cálculos e Registros Financeiros promover a comunicação aos interessados acerca de reposições ao erário, parcelamentos e demais acertos financeiros, realizando o respectivo controle na forma da legislação aplicável, bem como proceder à análise e à elaboração de cálculos que visem ao reembolso da remuneração e do encargo patronal dos servidores cedidos.

A SCRF contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

e) Seção de Pagamento – SEPAG – FC-6

À Seção de Pagamento compete executar as atividades de conferência de dados e confecção da folha de pagamento dos servidores e autoridades, abrangendo o pagamento de indenizações, reembolsos, gratificações aos magistrados e demais autoridades, restituições ao Erário, descontos de caráter compulsório ou judicial e consignações voluntárias.

Compete-lhe, ainda, elaborar folhas de pagamento ordinárias e suplementares dos membros do Tribunal, juízes, promotores eleitorais, chefes de cartório, servidores ativos, inativos e pensionistas, procedendo aos descontos de natureza legal, bem como prestar informações para fins de empréstimos com consignação em folha de pagamento, calcular margens consignáveis e expedir os documentos correspondentes.

A unidade também é responsável por proceder às averbações referentes a consignações em favor de entidades autorizadas, providenciando o encaminhamento dos respectivos relatórios à Coordenadoria de Orçamento e Finanças, além de manter atualizado o cadastro de entidades consignatárias, com o registro do total de pagamento das importâncias descontadas dos servidores ativos, inativos e pensionistas.

Cabe à Seção preparar demonstrativos de apropriação de despesas, avisos de crédito e relatórios de pagamentos efetuados, encaminhando-os ao órgão de execução financeira, bem como manter atualizadas as tabelas de vencimentos, proventos, vantagens e gratificações.

Compete, ainda, providenciar o envio e o acompanhamento dos eventos ao ambiente do eSocial referentes ao pagamento de pessoal, fornecer os elementos necessários à elaboração da proposta orçamentária relativamente às despesas com vencimentos, proventos e gratificações eleitorais, bem como subsidiar solicitações de créditos adicionais.

Por fim, cabe à Seção de Pagamento cientificar o servidor dos atos ordinatórios, quando assim determinado por superior hierárquico, por qualquer meio que assegure a ciência do interessado, sempre que se tratar de matéria de sua competência.

A SEPAG contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

III - Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES – CJ-2

Unidade responsável pela coordenação das atividades voltadas ao desenvolvimento de pessoas, capacitação, formação continuada, gestão por competências, saúde, benefícios, qualidade de vida, valorização da força de trabalho, acompanhamento funcional, estágio, ambientação, desenvolvimento gerencial e demais ações destinadas ao aperfeiçoamento profissional e institucional.

Ficam vinculadas à CODES as seguintes unidades:

 

a) Seção de Desenvolvimento – SEDEN – FC-6

Unidade responsável pelas atividades de desenvolvimento de pessoas, gestão por competências, acompanhamento funcional, estágio probatório, avaliação de desempenho, ambientação de novos servidores, acompanhamento de estagiários, análise de perfis profissionais, apoio à movimentação e lotação de pessoal, desenvolvimento gerencial, clima organizacional e demais ações voltadas ao aprimoramento da força de trabalho.

A SEDEN contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

b) Seção de Capacitação – SECAP – FC-6

Unidade responsável pelo planejamento, execução, acompanhamento e avaliação das ações de capacitação, incluindo elaboração e monitoramento do Plano Anual de Capacitação, instrução de contratações de cursos, acompanhamento orçamentário das ações educacionais, certificações, registros de capacitação, apoio à participação em eventos, ações de formação continuada e demais atividades relacionadas à educação corporativa.

A SECAP contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

c) Seção de Saúde – SESAU – FC-6

Unidade responsável pelas ações relacionadas à saúde dos magistrados, servidores e colaboradores, compreendendo o acompanhamento de licenças médicas, perícias, saúde ocupacional, campanhas de prevenção, ações de qualidade de vida, programas de atenção à saúde, suporte às demandas psicossociais relacionadas ao trabalho, acompanhamento de exames periódicos e demais atividades correlatas.

A SESAU contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

d) Seção de Benefícios – SEBEN – FC-6

Unidade responsável pela gestão dos benefícios concedidos aos magistrados, servidores e demais beneficiários, incluindo auxílio-alimentação, assistência pré-escolar, assistência médico-odontológica, plano de saúde, auxílio-transporte, benefícios legais e regulamentares, bem como pela instrução de processos, atualização cadastral, conferência de requisitos, controle de pagamentos e atendimento aos interessados.

A SEBEN contará com uma Assistência – FC-1, destinada ao apoio direto às atividades da unidade.

 

2. Quadro resumido da estrutura proposta

|Unidade|Sigla|Nível| 
|--- |--- |--- |--- |
|Secretaria de Gestão de Pessoas|SGP|CJ-3| 
|Coordenadoria de Administração de Pessoas|COAPE|CJ-2| 
|Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida|CODES|CJ-2| 
|Seção de Cadastro|—|FC-6| 
|Assistência da Seção de Cadastro|—|FC-1| 
|Seção de Frequência|—|FC-6| 
|Assistência da Seção de Frequência|—|FC-1| 
|Seção de Apoio aos Inativos e Cadastro de Magistrados|SAREMI|FC-6| 
|Assistência da SAREMI|—|FC-1| 
|Seção de Cálculos e Registros Financeiros|SCRF|FC-6| 
|Assistência da SCRF|—|FC-1| 
|Seção de Pagamento|SEPAG|FC-6| 
|Assistência da SEPAG|—|FC-1| 
|Seção de Desenvolvimento|SEDEN|FC-6| 
|Assistência da SEDEN|—|FC-1| 
|Seção de Capacitação|SECAP|FC-6| 
|Assistência da SECAP|—|FC-1| 
|Seção de Saúde|SESAU|FC-6| 
|Assistência da SESAU|—|FC-1| 
|Seção de Benefícios|SEBEN|FC-6| 
|Assistência da SEBEN|—|FC-1| 
 

3. Organograma proposto




 

4. Justificativa da proposta

 

A criação da Secretaria de Gestão de Pessoas – SGP, em nível CJ-3, confere à unidade posição compatível com a natureza estratégica das atividades desempenhadas e com a necessidade de fortalecimento da governança de pessoas no âmbito deste Tribunal.

 

A divisão da estrutura em duas Coordenadorias permite melhor organização das atribuições, separando as atividades de administração funcional e financeira daquelas relacionadas ao desenvolvimento, saúde e qualidade de vida da força de trabalho.

A Coordenadoria de Administração de Pessoas – COAPE concentrará as unidades responsáveis pela administração da vida funcional, registros cadastrais, frequência, folha de pagamento, cálculos financeiros, registros financeiros, apoio aos inativos e cadastro de magistrados. Essa divisão permitirá maior especialização técnica, melhor controle dos fluxos de trabalho e redução da sobrecarga atualmente concentrada nas unidades existentes.

 

O desmembramento da atual SECARF em Seção de Cadastro e Seção de Frequência mostra-se necessário em razão da amplitude e da natureza distinta das atividades atualmente concentradas em uma única unidade. Enquanto a Seção de Cadastro ficará voltada aos registros funcionais, provimentos, vacâncias, cargos, funções, averbações, aposentadorias, certidões, teletrabalho, dados cadastrais e processos requisitórios, a Seção de Frequência assumirá o controle de frequência, férias, afastamentos, banco de horas, serviço extraordinário, substituições e demais registros de comparecimento e compensação.

 

A divisão da SEPAG em Seção de Pagamento e Seção de Cálculos e Registros Financeiros também se justifica pela complexidade das atividades relacionadas à folha de pagamento. A SEPAG ficará concentrada na conferência de dados, elaboração de folhas, consignações, relatórios, eSocial, proposta orçamentária e demais providências operacionais do pagamento, enquanto a SCRF ficará responsável pelos cálculos, registros financeiros, fichas financeiras, exercícios anteriores, reposições ao erário, reembolsos e informações financeiras individualizadas.

 

A manutenção da SAREMI – Seção de Apoio aos Inativos e Cadastro de Magistrados assegura unidade própria para atendimento de demandas específicas relativas a magistrados, inativos, pensionistas e demais beneficiários, além de permitir apoio técnico em matérias de legislação de pessoal, contribuindo para maior segurança na instrução dos processos administrativos.

 

A Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES, por sua vez, reunirá as unidades responsáveis pelas ações de desenvolvimento, capacitação, saúde, benefícios e valorização da força de trabalho, permitindo atuação integrada nas políticas de gestão de pessoas que envolvem formação continuada, gestão por competências, qualidade de vida, saúde ocupacional, benefícios e desenvolvimento institucional.

 

A previsão de uma Assistência FC-1 para cada Seção permitirá o suporte mínimo necessário ao funcionamento das unidades, contribuindo para a adequada distribuição das tarefas, continuidade administrativa, melhoria dos fluxos internos e maior capacidade de resposta às demandas ordinárias e extraordinárias.

 

Ressalta-se que o detalhamento definitivo das atribuições poderá ser objeto de posterior regulamentação no Regimento Interno da Secretaria ou em ato normativo próprio, de modo a assegurar maior precisão quanto às competências, fluxos de trabalho e responsabilidades de cada unidade.

 

5. Conclusão

Diante do exposto, propõe-se a reestruturação da atual Coordenadoria de Gestão de Pessoas, com sua transformação em Secretaria de Gestão de Pessoas – SGP, retribuída com CJ-3, composta pela Coordenadoria de Administração de Pessoas – COAPE e pela Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES, ambas retribuídas com CJ-2.

 

A proposta contempla a criação e reorganização de unidades especializadas, com Seções retribuídas com FC-6 e respectivas Assistências FC-1, nos termos do organograma apresentado, visando ao fortalecimento institucional da área de gestão de pessoas, à melhoria da governança administrativa, à especialização das atividades, à redução da sobrecarga das unidades atualmente existentes e ao aprimoramento do atendimento às crescentes demandas relacionadas à administração, desenvolvimento, saúde, benefícios, capacitação e valorização da força de trabalho deste Tribunal.

 

Ressalte-se que se trata de estrutura enxuta, que não prevê assessorias nem chefia de gabinete, uma vez que a existência de duas coordenadorias funcionais, organizadas por eixo de atuação e compostas por seções especializadas, mostra-se suficiente para assegurar a coordenação das atividades e o apoio necessário à Secretaria.

 

Registre-se, ainda, que a estrutura ideal para a área de gestão de pessoas poderia contemplar três coordenadorias, com maior segregação temática das atribuições. Contudo, considerando a necessidade de conferir efetividade à reestruturação, entende-se mais adequado priorizar o fortalecimento das seções executoras, pois de nada adianta criar coordenadorias para distribuir, supervisionar e cobrar serviços se as unidades responsáveis pela execução direta das atividades não dispuserem de estrutura mínima para absorver e dar vazão às demandas.

 

Assim, a presente proposta busca equilibrar racionalidade administrativa e capacidade operacional, privilegiando uma estrutura viável, funcional e orientada à execução, de modo a assegurar maior eficiência, especialização e capacidade de resposta da Secretaria de Gestão de Pessoas às demandas institucionais.

 

À consideração superior.

---

https://www.tse.jus.br/legislacao/compilada/res/2026/resolucao-no-23-761-de-19-de-maio-de-2026?texto=compilado Aprova instruções para a aplicação da Lei nº 15.374/2026, de 2 de abril de 2026, que cria cargos efetivos, cargos em comissão e funções comissionadas no quadro de pessoal do Tribunal Superior Eleitoral e dos Tribunais Regionais Eleitorais.

https://legislacao.presidencia.gov.br/atos/?tipo=LEI&numero=15374&ano=2026&ato=c45o3a610djpWTc2b Cria cargos efetivos, cargos em comissão e funções comissionadas no quadro de pessoal do Tribunal Superior Eleitoral e dos Tribunais Regionais Eleitorais.


---

Despacho nº 0893557 / 2026 - PRESI/DG/SAOF/GASAOF

O presente procedimento veio a esta Secretaria para verificação da viabilidade financeira de implementação da proposta (0885799) de transformação da Coordenadoria de Gestão de Pessoas (COGEP) em Secretaria de Gestão de Pessoas (SGP), tendo como fundamento os cargos/funções criados pela Lei n. 15.374, de 2 de abril de 2026 (0858088), conforme determinado no Despacho GADG 0892881.

2. Inicialmente registro que a mencionada Lei criou, no âmbito deste Regional, os seguintes cargos comissionados (CJ) e funções de confiança (FC). Deixo de mencionar os cargos efetivos por não ser objeto da presente análise, embora considere adequado aproveitar o momento para definir as especialidades dos cargos efetivos criados: 

 

TABELA DE CARGOS/FUNÇÕES CRIADOAS PELA LEI N. 15.374/2026

|Cargo em Comissão/Função Comissionada|Quantidade|Valor Optante pelo CJ|Valor Optante pelo cargo efetivo (65%)|Valor limite para proposta de reestruturação| 
|--- |--- |--- |--- |--- |
|CJ-3|2|R$ 18.812,93|R$ 12.228,40|R$ 37.625,86| 
|FC-6|7|-|R$ 3.956,81|R$ 27.697,67| 
 

3. O Tribunal Superior Eleitoral (TSE), ao regulamentar a lei (Resolução TSE n. 23.761/2026 - 0893582), estabeleceu que:

 

Art. 3º Para a implementação dos cargos em comissão e das funções comissionadas previstos no Anexo da Lei nº 15.374, de 2 de abril de 2026, os Tribunais Regionais Eleitorais deverão observar os critérios estabelecidos no art. 6º da Resolução TSE nº 22.138, de 19 de dezembro de 2005.

Parágrafo único. A denominação dos cargos em comissão e das funções comissionadas deverá observar o Anexo IV da Resolução TSE nº 22.138, de 19 de dezembro de 2005, e o Anexo II da Resolução TSE nº 23.683, de 22 de fevereiro de 2022.

Art. 4º A nova estrutura organizacional deverá ser aprovada pelo Plenário de cada Tribunal Regional Eleitoral, observando-se o disposto no § 3º do art. 9º da Resolução TSE nº 22.138, de 19 de dezembro de 2005.

Art. 5º A implementação e o provimento dos cargos e das funções comissionadas previstos no art. 1º desta Resolução ficam condicionados:

I - aos limites autorizados no Anexo V da Lei nº 15.346, de 14 de janeiro de 2026;

II - à observância dos quantitativos de cargos efetivos autorizados no Anexo I da Portaria TSE nº 69, de 10 de fevereiro de 2026, e dos demais procedimentos fixados na mencionada Portaria, bem como às regulamentações do Tribunal Superior Eleitoral sobre os provimentos de cargos no âmbito da Justiça Eleitoral, publicados em cada exercício financeiro; e

III - ao enquadramento aos limites de gastos com pessoal, nos termos dispostos na Lei Complementar nº 101, de 4 de maio de 2000 - Lei de Responsabilidade Fiscal).

 

4. De acordo com o transcrito acima, entendo que a proposta objeto do presente procedimento observa as regras da Resolução TSE n. 22.138, de 19 de dezembro de 2005, bem como as alterações promovidas pela Resolução TSE n. 23.683/2022. Registro que a regra prevista no art. 10, abaixo transcrita, está sendo cumprida. Sem embargo dessa conclusão, entendo, todavia, que a questão deve ser analisada pela Assessoria Jurídica:

 

Art. 10. A critério dos tribunais eleitorais, poderá haver transformação, sem aumento de despesas, dos cargos em comissão e das funções comissionadas que compõem o Quadro de Pessoal, vedada a transformação de função em cargo e vice-versa (art. 9º da Lei nº 10.475, de 27 de junho de 2002) , e a da função comissionada de Chefe de Cartório Eleitoral.

Parágrafo único. A transformação de que trata este artigo deverá ser submetida ao Tribunal Superior Eleitoral, para homologação, quando se referir aos cargos de direção e chefia, que observará a estrutura organizacional dos tribunais integrantes dos grupos estabelecidos na forma do art. 3º da Portaria-TSE nº 558 , de 17 de novembro de 2005.

 

5. A partir da definição dos limites possíveis para uma eventual reestruturação, tendo como base os cargos/funções criados pela lei recente, resta realizar um comparativo entre a estrutura atual da Coordenadoria de Gestão de Pessoas e a proposta de sua transformação em Secretaria, a fim de verificar a viabilidade financeira. Com esse desiderato, apresento a estrutura atual da área de Gestão de Pessoas:

TABELA DE CARGOS/FUNÇÕES DA COORDENADORIA DE GESTÃO DE PESSOAS, COM BASE NA RESOLUÇÃO TRE-AC N. 1.787/2023 (0634410)

|Cargo em Comissão/Função Comissionada|Quantidade|Valor Optante pelo CJ|Valor Optante pelo cargo efetivo (65%)|Valor utilizado atualmente|
|--- |--- |--- |--- |--- |
|CJ-2|1|R$ 14.659,71|R$ 9.528,81|R$ 9.528,81|
|FC-6|5|-|R$ 3.956,81|R$ 19.784,05|
|FC-1|3|-|R$ 1.312,57|R$ 3.937,71|

6. A Proposta de Reestruturação apresentada no evento 0885799 requer, para sua implementação, a seguinte estrutura de cargos/funções:

TABELA DE CARGOS/FUNÇÕES DA PROPOSTA DE REESTRUTURAÇÃO DA ÁREA DE GESTÃO DE PESSOAS

|"Cargo em Comissão / Função Comissionada"|Quantidade|Valor Optante pelo CJ|Valor Optante pelo cargo efetivo (65%)|Valor necessário para a reestruturação se optante pelo CJ|Valor necessário para a reestruturação se optante pelo cargo efetivo (65%)|
|--- |--- |--- |--- |--- |--- |
|CJ-3|1|R$ 16.665,13|R$ 10.832,33|R$ 16.665,13|R$ 10.832,33|
|CJ-2|2|R$ 14.659,71|R$ 9.528,81|R$ 29.319,42|R$ 19.057,62| 
|FC-6|9|-|R$ 3.956,81|-|R$ 35.611,29|
|FC-1|9|-|R$ 1.312,57|-|R$ 11.813,13| 

7. A seguir apresento o quadro comparativo da situação atual e o necessário para a reestruturação proposta:

TABELA COM O COMPARATIVO DA SITUAÇÃO ATUAL X SITUAÇÃO PRETENDIDA

|Cargo em Comissão/Função Comissionada|Situação Atual Optante pelo CJ|Situação Atual Optante pelo cargo efetivo (65%)|Situação Pretendida Optante pelo CJ|Situação Pretendida Optante pelo cargo efetivo (65%)|Diferença quando a opção é pelo CJ|Diferença quando a opção é pelo cargo efetivo (65%)| 
|CJ-3|-|-|R$ 16.665,13|R$ 10.832,33|R$ 16.665,13|R$ 10.832,33| 
|CJ-2|-|R$ 9.528,81|R$ 29.319,42|R$ 19.057,62|R$ 19.790,61|R$ 9.528,81| 
|FC-6|-|R$ 19.784,05|-|R$ 35.611,29|-|R$ 15.827,24| 
|FC-1|-|R$ 3.937,71|-|R$ 11.813,13|-|R$ 7.875,42| 

8. Isto posto, resta que:

 

a) Tratando-se dos Cargos em Comissão (CJ), caso a Administração decida designar o Secretário de Gestão de Pessoas (SGP), ocupante do Cargo Comissionado CJ-3, e os 2 (dois) Coordenadores, ocupantes dos Cargos Comissionados CJ-2, de pessoas que optem pela remuneração do CJ integral, seriam necessários R$ 36.455,74 (trinta e seis mil quatrocentos e cinquenta e cinco reais e setenta e quatro centavos), o que permite afirmar ser possível a alteração pretendida.

b) No caso das Funções de Confiança (FC), o acréscimo é de R$ 23.702,55 (vinte e três mil setecentos e dois reais e cinquenta e cinco centavos), sendo, portando, possível a reestruturação. 

 

9. Em sendo aprovada a reestruturação nos termos propostos, a SGP deverá realizar monitoramento das nomeações para cargos em comissão, a fim de verificar se as alterações terão reflexo na despesa total com esses cargos, conforme previsto no art. 1º da Resolução TRE-AC n. 1.787/2023:

 

Art. 1º Aprovar a utilização dos recursos orçamentários provenientes do saldo de 35% advindos do valor integral do cargo em comissão, quando houver opção do servidor ocupante pela retribuição do cargo efetivo, a teor do que preceitua o art. 24, parágrafo único, da Lei n. 11.416, de 15 de dezembro de 2006, para criação e transformação, sem aumento de despesa, de cargos em comissão.

§ 1º O valor paradigma a ser considerado para fins da transformação de que trata o caput é o resultante da totalidade dos cargos em comissão existentes neste Tribunal, providos ou não, multiplicado pelo valor integral constante do Anexo III da Lei n. 11.416/2006, com redação dada pelas Leis n. 13.317, de 20 de julho de 2016, e n. 14.523, de 9 de janeiro de 2023;

§ 2º O valor residual para transformação de que trata o caput é resultante da diferença apurada no parágrafo anterior deduzido da situação atual de ocupação de optantes pela retribuição do cargo efetivo;

§ 3º No caso de cargos não providos, para apuração da situação atual, será utilizado o valor integral constante do Anexo III da Lei n. 11.416/2006, com redação dada pelas Leis n. 13.317, de 20 de julho de 2016, e n. 14.523, de 9 de janeiro de 2023;

§ 4º A situação atual tratada no § 2º tem como base o Anexo II da Resolução TRE-AC n. 1.781/2023;

§ 5º A Coordenadoria de Gestão de Pessoas e a Secretaria de Administração, Orçamento e Finanças deverão manter monitoramento quanto à utilização dos recursos orçamentários referidos nesta Resolução

 

10. Assim sendo, retorno os autos à Diretoria-Geral, sugerindo que os dados inseridos neste despacho sejam conferidos pela Coordenadoria de Gestão de Pessoas, unidade competente para o monitoramento e acompanhamento das alterações da Estrutura Organizacional do Tribunal. Sugiro que após essa conferência, a questão seja submetida à apreciação da Assessoria Jurídica. 

---

Despacho nº 0896097 / 2026 - PRESI/DG/COGEP

Em atenção ao Despacho nº 0894264/2026 – PRESI/DG/GADG, esta Coordenadoria de Gestão de Pessoas procedeu à conferência da Proposta de Reestruturação COGEP/SGP (0885799) e dos elementos constantes do Despacho nº 0893557/2026 – PRESI/DG/SAOF/GASAOF, especialmente quanto aos quesitos formulados pela Diretoria-Geral.

A proposta tem por objeto a transformação da atual Coordenadoria de Gestão de Pessoas em Secretaria de Gestão de Pessoas – SGP, estruturada em duas Coordenadorias, quais sejam, a Coordenadoria de Administração de Pessoas – COAPE e a Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES, com nove Seções destinadas à execução das atividades da área.

Passa-se à manifestação quanto aos quesitos apresentados.

a) Da correspondência entre os cargos e funções criados pela Lei nº 15.374/2026 e aqueles utilizados na estrutura proposta

A Lei nº 15.374, de 2 de abril de 2026, criou, especificamente para o Tribunal Regional Eleitoral do Acre, 2 (dois) cargos em comissão de nível CJ-3 e 7 (sete) funções comissionadas de nível FC-6.

Por sua vez, conforme consignado no Despacho SAOF nº 0893557, a estrutura atualmente existente na área de Gestão de Pessoas dispõe de 1 (um) CJ-2, 5 (cinco) FC-6 e 3 (três) FC-1, enquanto a estrutura proposta demanda, ao final, 1 (um) CJ-3, 2 (dois) CJ-2, 9 (nove) FC-6 e 9 (nove) FC-1.
A composição pretendida pode ser obtida mediante o seguinte arranjo:

I – utilização de 1 (um) dos cargos CJ-3 criados pela Lei nº 15.374/2026 para a titularidade da Secretaria de Gestão de Pessoas;

II – manutenção do atual cargo CJ-2 da COGEP, que passará a corresponder a uma das Coordenadorias da nova Secretaria;

III – transformação do segundo cargo CJ-3 criado pela Lei nº 15.374/2026 em 1 (um) cargo CJ-2, destinado à titularidade da segunda Coordenadoria;

IV – manutenção das atuais 5 (cinco) funções FC-6 da estrutura da COGEP, acrescidas de 4 (quatro) das 7 (sete) FC-6 criadas pela Lei nº 15.374/2026, totalizando as 9 (nove) FC-6 necessárias às Seções previstas na proposta; e

V – transformação das 3 (três) FC-6 remanescentes, dentre aquelas criadas pela Lei nº 15.374/2026, em 6 (seis) FC-1, que, somadas às 3 (três) FC-1 já existentes na estrutura atual, perfazem as 9 (nove) FC-1 previstas.

Dessa forma, há correspondência entre os cargos e funções disponibilizados pela Lei nº 15.374/2026, aqueles já integrantes da estrutura atual da COGEP e os necessários à implantação da estrutura proposta, mediante as transformações acima indicadas, sem qualquer transformação de cargo em comissão em função comissionada ou vice-versa, em consonância com o art. 24, parágrafo único, da Lei nº 11.416/2006 e com o art. 10 da Resolução TSE nº 22.138/2005.

b) Dos valores remuneratórios adotados

Quanto à divergência apontada no valor do CJ-3, verifica-se que a primeira tabela constante do Despacho SAOF nº 0893557 atribuiu ao CJ-3 o valor de R$ 18.812,93.

Todavia, conforme o Anexo II da Lei nº 15.293, de 19 de dezembro de 2025, vigente a partir de 1º de julho de 2026, o valor integral do CJ-3 corresponde a R$ 16.665,13, enquanto o valor de R$ 18.812,93 corresponde ao CJ-4. Para o CJ-2, o valor é de R$ 14.659,71.

Assim, o valor de R$ 16.665,13 utilizado posteriormente no próprio Despacho SAOF, na tabela referente à estrutura pretendida, é o valor correto do CJ-3.

Em consequência, o valor integral correspondente aos 2 (dois) CJ-3 criados pela Lei nº 15.374/2026 é de R$ 33.330,26, e não de R$ 37.625,86, razão pela qual se entende necessária a retificação desse ponto pela unidade responsável pela análise financeira.

Registre-se que essa correção recomenda, igualmente, nova conferência da conclusão financeira constante do item 8, alínea “a”, do Despacho SAOF, especialmente para o cenário em que os ocupantes dos três cargos em comissão da estrutura proposta venham a perceber a remuneração integral dos respectivos CJs, considerando também, nessa análise, os saldos decorrentes da opção pela remuneração do cargo efetivo disciplinados pela Resolução TRE-AC nº 1.787/2023. 

Quanto às funções comissionadas, os valores de R$ 3.956,81 para FC-6 e R$ 1.312,57 para FC-1 estão de acordo com os valores vigentes desde 1º de julho de 2026.

Observa-se apenas pequena correção aritmética: o acréscimo correspondente a 4 (quatro) FC-6 e 6 (seis) FC-1 é de R$ 23.702,66, e não R$ 23.702,55. Considerando que as 7 (sete) FC-6 criadas pela Lei nº 15.374/2026 representam R$ 27.697,67, permanece saldo financeiro de R$ 3.995,01 nesse grupo, não se alterando, portanto, a conclusão quanto à suficiência financeira das funções comissionadas.

c) Dos quantitativos de cargos e funções existentes, criados e objeto de transformação

Após a conferência, os quantitativos podem ser consolidados da seguinte forma:

Situação atual da COGEP: 

1 CJ-2;

5 FC-6;

3 FC-1.

Cargos e funções acrescidos pela Lei nº 15.374/2026:

2 CJ-3;

7 FC-6.

Transformações necessárias:

1 CJ-3 em 1 CJ-2;

3 FC-6 em 6 FC-1.

Estrutura resultante:

1 CJ-3;

2 CJ-2;

9 FC-6;

9 FC-1.

Os quantitativos, portanto, são compatíveis com a estrutura organizacional constante da Proposta nº 0885799, que prevê uma Secretaria, duas Coordenadorias e nove Seções.

Convém que o quadro de transformação acima seja incorporado expressamente à versão consolidada da proposta, a fim de tornar inequívoca a origem de cada cargo e função e facilitar tanto a análise jurídica quanto a posterior elaboração do ato normativo de alteração da estrutura.

d) Da adequação das denominações e da estrutura proposta às normas do Tribunal Superior Eleitoral

A Resolução TSE nº 23.761/2026 determina que a implementação dos cargos em comissão e funções comissionadas criados pela Lei nº 15.374/2026 observe os critérios do art. 6º da Resolução TSE nº 22.138/2005, bem como as denominações previstas no Anexo IV dessa Resolução e no Anexo II da Resolução TSE nº 23.683/2022.

Sob o aspecto hierárquico, a estrutura proposta mostra-se compatível com a regulamentação do TSE, uma vez que estabelece três níveis de unidades de linha:

Secretaria de Gestão de Pessoas; Coordenadorias; Seções.

Essa organização observa o art. 6º, II, da Resolução TSE nº 22.138/2005, em sua redação vigente, que prevê a hierarquização das unidades de linha em, no máximo, três níveis – Secretaria ou Diretoria, Coordenadoria e Seção.

Da mesma forma, as funções de direção e chefia encontram correspondência nas denominações regulamentares: Secretário para CJ-3, Coordenador para CJ-2 e Chefe de Seção para FC-6. Para a FC-1, a denominação prevista é Assistente I.

Nesse ponto específico, entende-se necessária apenas uma adequação formal da proposta.

As expressões “Assistência da Seção de Cadastro”, “Assistência da SAREMI”, “Assistência da SEPAG” e equivalentes não devem caracterizar unidades formais subordinadas às respectivas Seções. Isso porque o art. 6º, V, da Resolução TSE nº 22.138/2005 estabelece as Seções como unidades operacionais básicas para a realização dos serviços e veda seu desdobramento em segmentos de menor porte. Assim,  o texto da proposta e o respectivo organograma foram ajustados para indicar que cada Seção contará com 1 (um) Assistente I – FC-1, vinculado à unidade para apoio às respectivas atividades, sem que isso implique a criação de uma unidade administrativa denominada “Assistência”.

A alteração é meramente formal e não modifica o quantitativo de funções, a distribuição das atividades ou a concepção administrativa da proposta e já foi realizada na Proposta Reestruturação Gestão de Pessoas (0896099).

e) Dos demais elementos necessários à consolidação da proposta

No que se refere aos demais elementos necessários à consolidação, esta Coordenadoria ratifica os fundamentos administrativos que deram origem à proposta.

A divisão da estrutura em duas Coordenadorias permite separar as atividades de administração funcional e financeira das atividades relacionadas ao desenvolvimento, capacitação, saúde, benefícios e qualidade de vida, ao mesmo tempo em que fortalece as Seções responsáveis pela execução direta dos serviços.

A proposta foi concebida deliberadamente como estrutura enxuta, sem assessorias ou chefia de gabinete, priorizando as unidades executoras e a especialização das atividades, justamente para evitar a criação de níveis intermediários sem correspondente capacidade operacional.

Para sua consolidação, sugere-se os seguintes ajustes:

I – corrigir o valor do CJ-3 e os cálculos dele decorrentes no estudo financeiro;

II– corrigir o valor do acréscimo relativo às funções comissionadas para R$ 23.702,66;

III– submeter novamente os cálculos à SAOF para confirmação da inexistência de aumento de despesa, especialmente após a correção do valor do CJ-3

Explicita-se que no quadro da estrutura, a origem dos cargos e funções são as oriundas da Lei 15.374 de 02 de abril de 2026 (0858088).

Diante do exposto, esta Coordenadoria manifesta-se pela manutenção da proposta de transformação da Coordenadoria de Gestão de Pessoas em Secretaria de Gestão de Pessoas, por considerá-la adequada, sob o aspecto organizacional e funcional, às necessidades da área de gestão de pessoas, ratificando-se a estrutura composta pela SGP, pela COAPE, pela CODES e pelas nove Seções previstas na Proposta nº 0885799, com as adequações formais e correções acima apontadas.

Sugere-se, assim, o retorno dos autos à Secretaria de Administração, Orçamento e Finanças para retificação e confirmação dos aspectos financeiros, especialmente em razão da correção do valor do CJ-3.

É a manifestação.

---

Despacho nº 0896818 / 2026 - PRESI/DG/SAOF/GASAOF

Diante do que consta do Despacho COGEP 0896097, refaço parte do Despacho GASAOF 0893557, com as devidas correções/alterações:

2. O presente procedimento veio a esta Secretaria para verificação da viabilidade financeira de implementação da proposta (0885799) de transformação da Coordenadoria de Gestão de Pessoas (COGEP) em Secretaria de Gestão de Pessoas (SGP), tendo como fundamento os cargos/funções criados pela Lei n. 15.374, de 2 de abril de 2026 (0858088), conforme determinado no Despacho GADG 0892881.

3. Inicialmente registro que a mencionada Lei criou, no âmbito deste Regional, os seguintes cargos comissionados (CJ) e funções de confiança (FC). Deixo de mencionar os cargos efetivos por não ser objeto da presente análise, embora considere adequado aproveitar o momento para definir as especialidades dos cargos efetivos criados:

|Cargo em Comissão/Função Comissionada|Quantidade|Valor Optante pelo CJ|Valor Optante pelo cargo efetivo (65%)|Valor limite para proposta de reestruturação|  
|--- |--- |--- |--- |--- |  
|CJ-3|2|R$ 16.665,13|R$ 10.832,33|R$ 33.330,26|  
|FC-6|7|-|R$ 3.956,81|R$ 27.697,67|  
 

4. O Tribunal Superior Eleitoral (TSE), ao regulamentar a lei (Resolução TSE n. 23.761/2026 - 0893582), estabeleceu que:

 

Art. 3º Para a implementação dos cargos em comissão e das funções comissionadas previstos no Anexo da Lei nº 15.374, de 2 de abril de 2026, os Tribunais Regionais Eleitorais deverão observar os critérios estabelecidos no art. 6º da Resolução TSE nº 22.138, de 19 de dezembro de 2005.

Parágrafo único. A denominação dos cargos em comissão e das funções comissionadas deverá observar o Anexo IV da Resolução TSE nº 22.138, de 19 de dezembro de 2005, e o Anexo II da Resolução TSE nº 23.683, de 22 de fevereiro de 2022.

Art. 4º A nova estrutura organizacional deverá ser aprovada pelo Plenário de cada Tribunal Regional Eleitoral, observando-se o disposto no § 3º do art. 9º da Resolução TSE nº 22.138, de 19 de dezembro de 2005.

Art. 5º A implementação e o provimento dos cargos e das funções comissionadas previstos no art. 1º desta Resolução ficam condicionados:

I - aos limites autorizados no Anexo V da Lei nº 15.346, de 14 de janeiro de 2026;

II - à observância dos quantitativos de cargos efetivos autorizados no Anexo I da Portaria TSE nº 69, de 10 de fevereiro de 2026, e dos demais procedimentos fixados na mencionada Portaria, bem como às regulamentações do Tribunal Superior Eleitoral sobre os provimentos de cargos no âmbito da Justiça Eleitoral, publicados em cada exercício financeiro; e

III - ao enquadramento aos limites de gastos com pessoal, nos termos dispostos na Lei Complementar nº 101, de 4 de maio de 2000 - Lei de Responsabilidade Fiscal).

 

5. De acordo com o transcrito acima, entendo que a proposta objeto do presente procedimento observa as regras da Resolução TSE n. 22.138, de 19 de dezembro de 2005, bem como as alterações promovidas pela Resolução TSE n. 23.683/2022. Registro que a regra prevista no art. 10, abaixo transcrita, está sendo cumprida. Sem embargo dessa conclusão, entendo, todavia, que a questão deve ser analisada pela Assessoria Jurídica:

 

Art. 10. A critério dos tribunais eleitorais, poderá haver transformação, sem aumento de despesas, dos cargos em comissão e das funções comissionadas que compõem o Quadro de Pessoal, vedada a transformação de função em cargo e vice-versa (art. 9º da Lei nº 10.475, de 27 de junho de 2002) , e a da função comissionada de Chefe de Cartório Eleitoral.

Parágrafo único. A transformação de que trata este artigo deverá ser submetida ao Tribunal Superior Eleitoral, para homologação, quando se referir aos cargos de direção e chefia, que observará a estrutura organizacional dos tribunais integrantes dos grupos estabelecidos na forma do art. 3º da Portaria-TSE nº 558 , de 17 de novembro de 2005.

 

6. A partir da definição dos limites possíveis para uma eventual reestruturação, tendo como base os cargos/funções criados pela lei recente, resta realizar um comparativo entre a estrutura atual da Coordenadoria de Gestão de Pessoas e a proposta de sua transformação em Secretaria, a fim de verificar a viabilidade financeira. Com esse desiderato, apresento a estrutura atual da área de Gestão de Pessoas:

TABELA DE CARGOS/FUNÇÕES DA COORDENADORIA DE GESTÃO DE PESSOAS, COM BASE NA RESOLUÇÃO TRE-AC N. 1.787/2023 (0634410)

|Cargo em Comissão / Função Comissionada|Quantidade|Valor Optante pelo CJ|Valor Optante pelo cargo efetivo (65%)|Valor utilizado atualmente|
|--- |--- |--- |--- |--- |
|CJ-2|1|R$ 14.659,71|R$ 9.528,81|R$ 9.528,81|
|FC-6|5|-|R$ 3.956,81|R$ 19.784,05|
|FC-1|3|-|R$ 1.312,57|R$ 3.937,71|

7. A Proposta de Reestruturação apresentada no evento 0885799 requer, para sua implementação, a seguinte estrutura de cargos/funções:

TABELA DE CARGOS/FUNÇÕES DA PROPOSTA DE REESTRUTURAÇÃO DA ÁREA DE GESTÃO DE PESSOAS

|"Cargo em Comissão / Função Comissionada"|Quantidade|Valor Optante pelo CJ|"Valor Optante pelo cargo efetivo (65%)"|"Valor necessário para a reestruturação se optante pelo CJ"|"Valor necessário para a reestruturação se optante pelo cargo efetivo (65%)"|
|--- |--- |--- |--- |--- |--- |
|CJ-3|1|R$ 16.665,13|R$ 10.832,33|R$ 16.665,13|R$ 10.832,33|
|CJ-2|2|R$ 14.659,71|R$ 9.528,81|R$ 29.319,42|R$ 19.057,62|
|FC-6|9|-|R$ 3.956,81|-|R$ 35.611,29|
|FC-1|9|-|R$ 1.312,57|-|R$ 11.813,13|
 

8. A seguir apresento o quadro comparativo da situação atual e o necessário para a reestruturação proposta:

TABELA COM O COMPARATIVO DA SITUAÇÃO ATUAL X SITUAÇÃO PRETENDIDA

|Cargo em Comissão/Função Comissionada|Situação Atual Optante pelo CJ|Situação Atual Optante pelo cargo efetivo (65%)|Situação Pretendida Optante pelo CJ|Situação Pretendida Optante pelo cargo efetivo (65%)|Diferença quando a opção é pelo CJ|Diferença quando a opção é pelo cargo efetivo (65%)| 
|--- |--- |--- |--- |--- |--- |--- | 
|CJ-3|-|-|R$ 16.665,13|R$ 10.832,33|R$ 16.665,13|R$ 10.832,33| 
|CJ-2|-|R$ 9.528,81|R$ 29.319,42|R$ 19.057,62|R$ 19.790,61|R$ 9.528,81| 
|FC-6|-|R$ 19.784,05|-|R$ 35.611,29|-|R$ 15.827,24| 
|FC-1|-|R$ 3.937,71|-|R$ 11.813,13|-|R$ 7.875,42| 
 

9. Isto posto, resta que:

 

a) Tratando-se dos Cargos em Comissão (CJ), caso a Administração decida designar ocupantes que optem pela remuneração do CJ integral para os cargos de Secretário de Gestão de Pessoas (SGP), ocupante do Cargo Comissionado CJ-3, e os 2 (dois) Coordenadores, ocupantes dos Cargos Comissionados CJ-2, seriam necessários R$ 36.455,74 (trinta e seis mil quatrocentos e cinquenta e cinco reais e setenta e quatro centavos), seria inviável a reestruturação, ainda que adicionados os R$ 1.857,11 (um mil oitocentos e cinquenta e sete reais e onze centavos) da sobra da última reestruturação, ocorrida em 2023 (0626250). Assim sendo, a reestruturação somente é possível se um dos cargos em comissão (o CJ-3 ou um dos CJ-2) for ocupado por servidor do quadro que opte por receber pelo cargo efetivo adicionado dos 65% do valor do cargo em comissão.

b) No caso das Funções de Confiança (FC), o acréscimo é de R$ 23.702,66 (vinte e três mil setecentos e dois reais e sessenta e seis centavos), sendo, portando, possível a reestruturação.

 

10. Em sendo aprovada a reestruturação nos termos propostos, a SGP deverá realizar monitoramento das nomeações para cargos em comissão, a fim de verificar se as alterações terão reflexo na despesa total com esses cargos, conforme previsto no art. 1º da Resolução TRE-AC n. 1.787/2023:

 

Art. 1º Aprovar a utilização dos recursos orçamentários provenientes do saldo de 35% advindos do valor integral do cargo em comissão, quando houver opção do servidor ocupante pela retribuição do cargo efetivo, a teor do que preceitua o art. 24, parágrafo único, da Lei n. 11.416, de 15 de dezembro de 2006, para criação e transformação, sem aumento de despesa, de cargos em comissão.

§ 1º O valor paradigma a ser considerado para fins da transformação de que trata o caput é o resultante da totalidade dos cargos em comissão existentes neste Tribunal, providos ou não, multiplicado pelo valor integral constante do Anexo III da Lei n. 11.416/2006, com redação dada pelas Leis n. 13.317, de 20 de julho de 2016, e n. 14.523, de 9 de janeiro de 2023;

§ 2º O valor residual para transformação de que trata o caput é resultante da diferença apurada no parágrafo anterior deduzido da situação atual de ocupação de optantes pela retribuição do cargo efetivo;

§ 3º No caso de cargos não providos, para apuração da situação atual, será utilizado o valor integral constante do Anexo III da Lei n. 11.416/2006, com redação dada pelas Leis n. 13.317, de 20 de julho de 2016, e n. 14.523, de 9 de janeiro de 2023;

§ 4º A situação atual tratada no § 2º tem como base o Anexo II da Resolução TRE-AC n. 1.781/2023;

§ 5º A Coordenadoria de Gestão de Pessoas e a Secretaria de Administração, Orçamento e Finanças deverão manter monitoramento quanto à utilização dos recursos orçamentários referidos nesta Resolução

 

11. Assim sendo, retorno os autos à Diretoria-Geral.

---

Parecer nº 0897784 / 2026 - PRESI/DG/ASJUR

DIREITO ADMINISTRATIVO. ORGANIZAÇÃO ADMINISTRATIVA. REESTRUTURAÇÃO DA COORDENADORIA DE GESTÃO DE PESSOAS. CRIAÇÃO DA SECRETARIA DE GESTÃO DE PESSOAS. CARGOS EM COMISSÃO E FUNÇÕES COMISSIONADAS INSTITUÍDOS PELA LEI Nº 15.374/2026. TRANSFORMAÇÃO SEM AUMENTO DE DESPESA. RESOLUÇÕES-TSE Nº 22.138/2005 E Nº 23.761/2026. LEI Nº 11.416/2006. COMPETÊNCIA DO TRIBUNAL PLENO. NECESSIDADE DE ALTERAÇÃO DO REGIMENTO INTERNO DA SECRETARIA DO TRE/AC. OBSERVÂNCIA DAS CONDIÇÕES ORÇAMENTÁRIAS, FINANCEIRAS E FISCAIS. MANUTENÇÃO DA NATUREZA DE ASSESSORAMENTO DAS FUNÇÕES DE ASSISTENTE I. DUPLICIDADE DE SIGLA. PARECER FAVORÁVEL À CONTINUIDADE E À APROVAÇÃO EM TESE, MEDIANTE O CUMPRIMENTO DE CONDICIONANTES. ANÁLISE RESTRITA À LEGALIDADE, SEM INCURSÃO NO MÉRITO, NA CONVENIÊNCIA OU NA OPORTUNIDADE ADMINISTRATIVA.

 

RELATÓRIO

1. Trata-se de proposta (ID 0885799) de reestruturação da área de gestão de pessoas do Tribunal Regional Eleitoral do Acre, apresentada pela Coordenadoria de Gestão de Pessoas – COGEP, em decorrência da criação, pela Lei nº 15.374/2026, de novos cargos efetivos, cargos em comissão e funções comissionadas para os tribunais regionais eleitorais.

2. Conforme a documentação acostada aos autos, a proposta tem por objeto transformar a atual Coordenadoria de Gestão de Pessoas-COGEP em Secretaria de Gestão de Pessoas – SGP, dirigida por titular de cargo em comissão CJ-3, e instituir, em sua estrutura, duas coordenadorias, cada uma dirigida por titular de cargo em comissão CJ-2:

I – Coordenadoria de Administração de Pessoas – COAPE; e

II – Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES.

3. A proposta prevê, ainda, nove seções, chefiadas por funções comissionadas FC-6, distribuídas da seguinte forma:

I – no âmbito da COAPE:

a) Seção de Cadastro;

b) Seção de Frequência;

c) Seção de Apoio aos Inativos e Cadastro de Magistrados – SAREMI;

d) Seção de Cálculos e Registros Financeiros – SCRF; e

e) Seção de Pagamento – SEPAG;

 

II – no âmbito da CODES:

a) Seção de Desenvolvimento – SEDEN;

b) Seção de Capacitação – SECAP;

c) Seção de Saúde – SESAU; e

d) Seção de Benefícios – SEBEN.

 

4. Propõe-se, igualmente, a alocação de uma função comissionada FC-1, com a denominação de Assistente I, para prestar apoio direto a cada seção, totalizando nove funções dessa natureza. A versão ajustada da proposta esclarece que as assistências não constituirão unidades administrativas autônomas nem subdivisões das seções.

5. Segundo consta no Despacho COGEP (ID 0896097), a estrutura atual da área conta com um cargo CJ-2, cinco funções FC-6 e três funções FC-1. Destaca que a Lei nº 15.374/2026 destinou ao TRE/AC dois cargos CJ-3 e sete funções FC-6, além de cargos efetivos que, por opção da unidade proponente, não integram esta reestruturação.

6. A conformação pretendida resultaria em um cargo CJ-3, dois cargos I - CJ-2, nove funções FC-6 e nove funções FC-1, mediante:

I - utilização de um dos novos cargos CJ-3 para a Secretaria;

II – manutenção do atual cargo CJ-2 e transformação do segundo cargo CJ-3 em outro CJ-2;

III – manutenção das cinco funções FC-6 existentes e utilização de quatro das sete novas FC-6; e

IV – transformação das três FC-6 restantes (criadas pela Lei n. 15.374/2026) em seis funções FC-1, que, somadas às três funções já existentes, totalizariam nove FC-1.

 

7. A Secretaria de Administração, Orçamento e Finanças – SAOF, por meio do Despacho nº 0896818/2026, concluiu pela viabilidade financeira das funções comissionadas, mas registrou que a ocupação simultânea dos três cargos em comissão pelo valor integral dependeria de recursos adicionais. Segundo a unidade técnica, a execução seria viável se ao menos um desses cargos fosse ocupado por servidor legalmente habilitado que exercesse a opção remuneratória prevista no art. 18, § 2º, da Lei nº 11.416/2006.

8. A Diretoria-Geral, encaminhou o processo a esta Assessoria Jurídica para exame da regularidade legal e normativa da proposta (ID 0882733).

9. É o necessário consignar. Passa-se a análise.

 

FUNDAMENTAÇÃO

Delimitação do exame jurídico

10. O presente parecer se limita exclusivamente a juridicidade da proposta, abrangendo a competência para sua aprovação, a adequação do instrumento normativo, a conformidade da estrutura e das nomenclaturas, a possibilidade de transformação dos cargos e funções e as condicionantes orçamentárias e fiscais.

11. Destaque-se que não integra o objeto deste parecer a avaliação do mérito administrativo da reestruturação. Assim, não se examinam a conveniência, a oportunidade, a eficiência gerencial, o dimensionamento ótimo das unidades, a distribuição quantitativa da força de trabalho, o volume de serviço ou a maior ou menor adequação administrativa das soluções propostas. Essas matérias estão sujeitas à apreciação técnica da COGEP, da Diretoria-Geral, da Presidência e, em última instância, do Tribunal Pleno.

12. As informações técnicas, financeiras e funcionais fornecidas pela COGEP e pela SAOF são consideradas nos limites de suas respectivas competências, ressalvadas inconsistências objetivamente verificáveis.

13. O exame também não abrange a lotação ou o provimento dos cargos efetivos criados pela Lei nº 15.374/2026, uma vez que a própria proposta os excluiu de seu objeto. Eventual utilização desses cargos deverá observar a regulamentação específica expedida pelo TSE, atualmente consubstanciada na Portaria TSE n. 226/2026.

14. Por fim, não foi apresentada minuta integral da resolução destinada a implementar a reestruturação. A conclusão jurídica, por isso, incide sobre o modelo proposto e não substitui a revisão da redação final do ato normativo.

 

Da Competência e instrumento normativo

15. A Constituição Federal assegura aos tribunais competência para organizar suas secretarias e serviços auxiliares, nos termos do art. 96, inciso I, alínea “b”, sem prejuízo da observância das normas gerais aplicáveis aos servidores e da disponibilidade orçamentária prevista no art. 169, CF.

16. No âmbito do TRE/AC, o art. 17, inciso IV, do Regimento Interno atribui ao Tribunal a competência para organizar sua Secretaria e seus serviços auxiliares. Os arts. 160 e 299 preveem que a organização e as atribuições das unidades sejam disciplinadas por resolução e pelo Regimento Interno da Secretaria, aprovado pela Corte.

17. A Resolução TRE/AC nº 1.808/2025, que contém o Regimento Interno da Secretaria, disciplina atualmente a estrutura da COGEP nos arts. 9º e 42 a 47. Seu art. 108 admite propostas de alteração apresentadas por membro do Tribunal ou pela Diretoria-Geral e exige aprovação por maioria absoluta.

18. Assim, a manifestação da COGEP constitui subsídio técnico, porquanto a alteração deve ser formalizada por proposta da autoridade regimentalmente legitimada e submetida ao Tribunal Pleno, acompanhada de exposição de motivos, manifestação orçamentária e minuta de resolução.

19. Consigne-se, ainda, que não é juridicamente suficiente criar a nova Secretaria e suas unidades apenas por portaria, despacho ou ato interno da Diretoria-Geral. A reestruturação altera o Regimento Interno da Secretaria e, portanto, exige resolução plenária aprovada pelo quórum, conforme previsão do art. 108 da Resolução TRE/AC nº 1.808/2025.

 

Compatibilidade da estrutura e das nomenclaturas

20. A Lei n. 15.374/2026 criou para o TRE/AC, entre outros recursos, dois cargos em comissão CJ-3 e sete funções comissionadas FC-6.

21. Com efeito, a Resolução TSE n. 23.761/2026 autoriza os tribunais regionais eleitorais a implementar os recursos instituídos pela referida lei, exigindo aprovação plenária e observância da Resolução-TSE nº 22.138/2005.

22. O art. 6º da Resolução TSE n. 22.138/2005, em sua redação atual, estabelece até três níveis hierárquicos de linha: secretaria ou diretoria, coordenadoria e seção. Também determina que as seções constituem unidades operacionais básicas, sem subdivisões formais.

23. A estrutura “Secretaria – Coordenadorias – Seções” da proposta observa, portanto, o limite de três níveis hierárquicos. Além disso, as nomenclaturas e os níveis retributivos também correspondem aos anexos da regulamentação do TSE:

I - Secretário: CJ-3;

II – Coordenador: CJ-2;

III – Chefe de Seção: FC-6; e

IV – Assistente I: FC-1.

 

24. As funções FC-1, contudo, não podem constituir um quarto nível hierárquico nem unidades denominadas “Assistências”. Os Assistentes I devem figurar como funções de apoio e assessoramento vinculadas às seções, sem autonomia administrativa, competência própria, quadro subordinado ou representação separada no organograma como unidade estrutural.

25. Outrossim, o art. 37, inciso V, da Constituição e o art. 5º da Lei n. 11.416/2006 reservam cargos em comissão e funções comissionadas às atribuições de direção, chefia e assessoramento. A regulamentação não deve atribuir aos Assistentes I apenas tarefas ordinárias e indiferenciadas de execução. Suas atribuições deverão ostentar efetivo conteúdo de assistência ou assessoramento, como controle, consolidação, acompanhamento, orientação técnica e suporte qualificado à chefia da seção.

26. Identificou-se, ainda, impedimento formal quanto à sigla “SECAP”, proposta para a Seção de Capacitação. Essa sigla já é utilizada no Regimento Interno da Secretaria, pela Seção de Controle e Acompanhamento de Processos, vinculada à Secretaria Judiciária. Assim, com vista a evitar duplicidade, recomenda-se a alteração da sigla proposta.

27. Quanto as Seções de Cadastro e de Frequência (não constam siglas na proposta) também deverão receber siglas próprias e não coincidentes com as de outras unidades antes da elaboração definitiva dos anexos e do organograma.

 

Transformação dos cargos e funções

28. O art. 24, parágrafo único, da Lei nº 11.416/2006 e o art. 10 da Resolução-TSE nº 22.138/2005 admitem a transformação de cargos em comissão e funções comissionadas, desde que:

I – não haja aumento de despesa;

II – não ocorra transformação de função comissionada em cargo em comissão, ou vice-versa; e

III – seja preservada a natureza legal das atribuições.

 

29. A proposta respeita a vedação de transformação entre espécies, pois converte um cargo CJ-3 em um cargo CJ-2 e três funções FC-6 em seis funções FC-1.

30. Considerados os valores vigentes desde 1º de julho de 2026, estabelecidos pela Lei n. 15.293/2025, verifica-se:

 
|Transformação|Valor de origem|Valor resultante|Redução mensal|
|--- |--- |--- |--- |
|1 CJ-3 em 1 CJ-2|R$ 16.665,13|R$ 14.659,71|R$ 2.005,42|
|3 FC-6 em 6 FC-1|R$ 11.870,43|R$ 7.875,42|R$ 3.995,01|
|Total|R$ 28.535,56|R$ 22.535,13|R$ 6.000,43|

 

31. Sob o paradigma dos valores integrais, a estrutura atualmente disponível somada aos recursos criados pela Lei nº 15.374/2026 alcança R$ 99.409,40 mensais. A estrutura final proposta corresponde a R$ 93.408,97 mensais, produzindo redução estrutural de R$ 6.000,43 por mês.

32. Portanto, quanto ao custo nominal dos cargos e funções transformados, não há aumento de despesa, estando atendido o requisito previsto na Lei nº 11.416/2006 e na Resolução-TSE nº 22.138/2005.

33. Consigne-se que o ato normativo deverá conter anexo específico demonstrando, de forma auditável, a origem, a transformação, a denominação, o nível e a unidade de lotação de cada cargo ou função. Assim, recomenda-se separar nesse demonstrativo:

I - os recursos já integrantes da estrutura do TRE/AC;

II – os recursos criados pela Lei nº 15.374/2026;

III – as transformações realizadas; e

IV – a estrutura final resultante.

34. Com efeito, o art. 9º, § 3º, da Resolução-TSE nº 22.138/2005 dispensa as alterações de estrutura posteriores a 11 de março de 2020 da homologação genérica prevista no § 2º, exigindo, porém, comunicação e demonstração da ausência de aumento de despesa à unidade competente do TSE.

35. De outro norte, o parágrafo único do art. 10 da mesma resolução mantém previsão específica de submissão ao TSE das transformações relativas a cargos e funções de direção e chefia. Embora o art. 4º da Resolução-TSE nº 23.761/2026 remeta expressamente ao rito do art. 9º, § 3º, a permanência da regra específica do art. 10 recomenda, por segurança jurídica, que a tabela de transformação seja submetida ao TSE antes do provimento dos recursos transformados, salvo orientação formal do órgão competente daquela Corte no sentido de que a comunicação prevista no art. 9º, § 3º, é suficiente para as transformações decorrentes da Lei nº 15.374/2026.

 

Condicionantes orçamentárias e financeiras

36. A propósito, a ausência de aumento no valor nominal da transformação não esgota o exame financeiro. A implementação e o provimento dos cargos também estão condicionados:

I – às dotações da Lei Orçamentária Anual;

II – às autorizações e limites da Lei de Diretrizes Orçamentárias;

III – ao art. 169, § 1º, da Constituição;

IV – aos limites de despesa com pessoal da Lei Complementar nº 101/2000; e

V – ao art. 5º da Resolução-TSE nº 23.761/2026.

 

37. A Resolução TRE/AC nº 1.787/2023 prevê a utilização do saldo correspondente à diferença entre o valor integral de cargos em comissão e o pagamento efetuado aos servidores que optem pela remuneração do cargo efetivo acrescida de 65% do cargo em comissão. Essa sistemática exige acompanhamento contínuo pela COGEP e pela SAOF, conforme seu art. 1º, § 5º.

38. Segundo o Despacho SAOF nº 0896818/2026, se os três cargos em comissão da estrutura final forem remunerados integralmente, haverá necessidade adicional de R$ 36.455,74. Os novos cargos CJ-3 correspondem a R$ 33.330,26, aos quais a unidade técnica acrescentou saldo anteriormente apurado de R$ 1.857,11, resultando em insuficiência de R$ 1.268,37.

39. A SAOF concluiu que a execução financeira se torna possível se ao menos um dos cargos for ocupado por servidor legalmente apto que exerça a opção remuneratória prevista no art. 18, § 2º, da Lei nº 11.416/2006.

40. Essa circunstância não torna ilícita a estrutura em abstrato, mas condiciona sua execução. A opção remuneratória é faculdade pessoal do servidor e não pode ser juridicamente imposta ou presumida como permanente.

41. A resolução poderá aprovar a estrutura, mas o provimento simultâneo dos três cargos somente deverá ocorrer após certificação da SAOF de que existe disponibilidade financeira. Se não houver servidor que exerça validamente a opção ou outra fonte orçamentária suficiente, deverá ser mantido vago o cargo necessário ao equilíbrio financeiro, ou revista a estrutura.

42. Antes da submissão ao Tribunal Pleno, recomenda-se que a SAOF apresente manifestação conclusiva atualizada contendo:

I – memória consolidada dos cálculos;

II – impacto mensal e anualizado;

III – repercussão no exercício vigente e, quando juridicamente exigível, nos exercícios subsequentes;

IV – indicação das dotações e autorizações constantes da LOA e da LDO;

V – demonstração da compatibilidade com os limites de despesa com pessoal;

VI – distinção entre o custo integral da estrutura e o cenário de execução baseado em opções remuneratórias; e

VII – indicação da condição de provimento ou vacância necessária para evitar aumento de despesa.

 

43. Qualquer alteração posterior na opção remuneratória dos ocupantes deverá ser precedida de nova verificação financeira, de modo a impedir que uma estrutura inicialmente equilibrada passe a produzir despesa sem cobertura.

 

Alteração do Regimento e distribuição das competências

44. A transformação da COGEP em Secretaria exige alteração expressa da Resolução TRE/AC nº 1.808/2025, especialmente:

I – do art. 9º, que contém a estrutura organizacional;

II – dos arts. 42 a 47, que disciplinam a atual COGEP e suas seções;

III – das disposições relativas às atribuições de secretários, coordenadores e chefes de seção;

IV – das normas sobre responsabilidade das unidades; e

V – dos anexos referentes à estrutura, organograma, cargos e funções.

 

45. Cumpre ressaltar que a regulamentação não deve deixar para ato administrativo inferior a definição das competências essenciais das novas unidades. Com efeito, o Tribunal Pleno deve aprovar, ao menos, a distribuição material das atribuições entre a Secretaria, as coordenadorias e as seções. Atos internos poderão detalhar procedimentos e fluxos, mas não substituir a competência normativa reservada à Corte.

46. Portanto, reputa-se que a versão final deverá apresentar quadro de correspondência entre as competências atuais e as novas unidades. Ainda, é necessário demonstrar que todas as atribuições previstas no Regimento Interno vigente foram preservadas, transferidas ou expressamente revogadas, evitando lacunas ou sobreposições.

47. Ademais, resta adequado que o quadro contemple, entre outros temas atualmente relacionados à gestão de pessoas, cadastro e ingresso de servidores, posse, movimentação, frequência, pagamento, cálculos financeiros, registros e obrigações acessórias, aposentadorias e pensões, recadastramento, registros perante órgãos de controle, desenvolvimento, capacitação, avaliação, saúde, perícias, benefícios, estágio e cooperação técnica.

48. Por conseguinte, ainda se recomenda que a minuta delimite com precisão as competências da Seção de Pagamento e da Seção de Cálculos e Registros Financeiros, assim como das unidades responsáveis por cadastro, benefícios e saúde, evitando duplicidade na elaboração, conferência, autorização e registro de cálculos e pagamentos.

49. Outrossim, a conveniência de determinada distribuição de tarefas entre as unidades constitui matéria de mérito administrativo e não é decidida neste parecer. Juridicamente, exige-se apenas que a distribuição seja completa, coerente, não contraditória e compatível com as competências institucionais e com os controles internos.

 

Requisitos para ocupação dos cargos e funções

50. O provimento dos cargos e funções deverá observar, em todo o Tribunal, os percentuais e requisitos previstos na Lei nº 11.416/2006, especialmente:

I – destinação mínima de 80% das funções comissionadas a servidores integrantes das carreiras dos quadros de pessoal do Poder Judiciário da União;

II – destinação mínima de 50% dos cargos em comissão a servidores efetivos integrantes dos quadros próprios;

III – exigência de formação em nível superior para o exercício dos cargos em comissão; e

IV – participação dos titulares de funções gerenciais em programas de desenvolvimento gerencial, nos prazos legais.

 

51. Desse modo, a comprovação desses requisitos deve anteceder os atos de nomeação ou designação, não constituindo a aprovação da estrutura autorização automática para o provimento de todos os cargos e funções.

 

CONCLUSÃO

52. Frente a essas considerações, esta Assessoria opina pela regularidade jurídica em tese e pelo prosseguimento da proposta de transformação da Coordenadoria de Gestão de Pessoas em Secretaria de Gestão de Pessoas, com um cargo CJ-3, duas coordenadorias CJ-2, nove seções FC-6 e nove funções de Assistente I FC-1, por estar o desenho básico compatível com a Lei nº 15.374/2026 e com as Resoluções-TSE nº 22.138/2005 e nº 23.761/2026.

53. Contudo, a aprovação definitiva fica condicionada ao cumprimento cumulativo das seguintes providências:

 

I – elaboração de minuta de resolução que altere expressamente a Resolução TRE/AC nº 1.808/2025, inclusive seus dispositivos de competências e anexos;

II – submissão da matéria ao Tribunal Pleno, mediante iniciativa regimentalmente adequada e aprovação por maioria absoluta;

III – inclusão de tabela demonstrativa da origem, transformação, denominação, nível e lotação de todos os cargos e funções;

IV – correção da duplicidade da sigla “SECAP” e definição de siglas exclusivas para as Seções de Cadastro e de Frequência;

V – exclusão de qualquer representação das funções de Assistente I como unidades ou subdivisões estruturais;

VI – definição das atribuições dos Assistentes I com efetivo conteúdo de assistência ou assessoramento, vedada sua caracterização como mera força ordinária de execução;

VII – apresentação de quadro de correspondência que distribua todas as competências atualmente atribuídas à COGEP e às suas unidades;

VIII – delimitação das responsabilidades relacionadas a cálculos, folha de pagamento, registros financeiros, benefícios, cadastro e controles internos;

IX – manifestação conclusiva e atualizada da SAOF sobre a disponibilidade orçamentária e financeira, com memória de cálculo, impacto anualizado e demonstração de compatibilidade com a LOA, a LDO e os limites fiscais;

X – condicionamento do provimento simultâneo dos três cargos em comissão à existência de cobertura financeira, mantendo-se vago o cargo necessário caso não se concretize a opção remuneratória considerada pela SAOF;

XI – manutenção do acompanhamento contínuo pela COGEP e pela SAOF, nos termos da Resolução TRE/AC nº 1.787/2023;

XII – comunicação da alteração e demonstração da ausência de aumento de despesa à unidade competente do TSE, na forma do art. 9º, § 3º, da Resolução-TSE nº 22.138/2005;

XIII – por cautela, submissão ao TSE da tabela de transformação, em atenção ao art. 10, parágrafo único, da Resolução-TSE nº 22.138/2005, salvo orientação formal daquela Corte que reconheça suficiente o procedimento previsto no art. 4º da Resolução-TSE nº 23.761/2026; e

XIV – observância dos percentuais, requisitos de escolaridade e demais condições legais no momento do provimento dos cargos e funções.

 

54. Após a incorporação dessas providências, recomenda-se que a minuta definitiva de resolução retorne à Assessoria Jurídica para conferência de sua correspondência com a proposta examinada e com o Regimento Interno.

55. Reitera-se que a presente manifestação se restringe ao controle de legalidade e regularidade formal, não ingressando na conveniência, oportunidade, eficiência gerencial ou mérito administrativo da reestruturação, matérias reservadas às unidades técnicas, à Administração e ao Tribunal Pleno.

56. É o parecer submetido à apreciação.

57. À Diretoria-Geral para consideração superior.

---
0898990

MINUTA DE RESOLUÇÃO TRE-AC Nº ___/2026

Processo SEI nº 0001059-72.2025.6.01.8000

Altera a Resolução TRE-AC nº 1.808/2025, que aprova o Regimento Interno da Secretaria do Tribunal Regional Eleitoral do Acre, reestrutura a área de gestão de pessoas, transforma a Coordenadoria de Gestão de Pessoas em Secretaria de Gestão de Pessoas, dispõe sobre a transformação e a lotação de cargos em comissão e funções comissionadas, define competências e dá outras providências.

 

O TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições que lhe são conferidas pelo art. 96, inciso I, alínea “b”, da Constituição Federal e pelo Regimento Interno do Tribunal;

CONSIDERANDO o disposto na Lei nº 11.416, de 15 de dezembro de 2006, especialmente quanto às atribuições de direção, chefia e assessoramento dos cargos em comissão e funções comissionadas e à possibilidade de transformação desses recursos sem aumento de despesa;

CONSIDERANDO os cargos em comissão e as funções comissionadas destinados ao Tribunal Regional Eleitoral do Acre pela Lei nº 15.374/2026;

CONSIDERANDO o disposto nas Resoluções TSE nº 22.138/2005 e nº 23.761/2026;

CONSIDERANDO a necessidade de adequar a estrutura da área de gestão de pessoas à crescente complexidade das atividades relacionadas à administração funcional, folha de pagamento, cálculos financeiros, desenvolvimento de pessoas, capacitação, saúde, benefícios e qualidade de vida;

CONSIDERANDO a necessidade de conferir maior especialização às unidades executoras, aprimorar a segregação de funções, fortalecer os controles internos e ampliar a capacidade operacional da área de gestão de pessoas;

CONSIDERANDO a proposta apresentada pela Coordenadoria de Gestão de Pessoas no Processo SEI nº 0001059-72.2025.6.01.8000;

CONSIDERANDO o Parecer nº 0897784/2026 – PRESI/DG/ASJUR, que reconheceu a regularidade jurídica, em tese, da reestruturação proposta, condicionada à adequação do Regimento Interno, à definição das competências das novas unidades, à demonstração da transformação dos cargos e funções e à observância das condições orçamentárias, financeiras e fiscais;

RESOLVE:

CAPÍTULO I

DA REESTRUTURAÇÃO

 

Art. 1º A Coordenadoria de Gestão de Pessoas – COGEP é transformada em Secretaria de Gestão de Pessoas – SGP, unidade subordinada à Diretoria-Geral, dirigida por titular de cargo em comissão CJ-3.

Art. 2º A Secretaria de Gestão de Pessoas – SGP passa a ser composta pelas seguintes unidades:

I – Coordenadoria de Administração de Pessoas – COAPE, dirigida por titular de cargo em comissão CJ-2, à qual ficam vinculadas:

a) Seção de Cadastro – SECAD, chefiada por titular de função comissionada FC-6;

b) Seção de Frequência – SEFRE, chefiada por titular de função comissionada FC-6;

c) Seção de Apoio aos Inativos e Cadastro de Magistrados – SAREMI, chefiada por titular de função comissionada FC-6;

d) Seção de Cálculos e Registros Financeiros – SCRF, chefiada por titular de função comissionada FC-6; e

e) Seção de Pagamento – SEPAG, chefiada por titular de função comissionada FC-6.

II – Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES, dirigida por titular de cargo em comissão CJ-2, à qual ficam vinculadas:

a) Seção de Desenvolvimento – SEDEN, chefiada por titular de função comissionada FC-6;

b) Seção de Capacitação – SCAP, chefiada por titular de função comissionada FC-6;

c) Seção de Saúde – SESAU, chefiada por titular de função comissionada FC-6; e

d) Seção de Benefícios – SEBEN, chefiada por titular de função comissionada FC-6.

§ 1º Cada Seção contará com 1 (uma) função comissionada de Assistente I – FC-1, vinculada diretamente à respectiva unidade para o exercício de atribuições de assistência e assessoramento.

§ 2º As funções de Assistente I – FC-1 não constituem unidades administrativas autônomas, não representam subdivisão das Seções e não integram nível hierárquico de linha.

§ 3º As funções referidas no § 1º não possuirão quadro próprio de servidores, competência administrativa autônoma ou representação independente no organograma institucional.

Art. 3º A estrutura, a vinculação hierárquica, os níveis retributivos e a distribuição dos cargos em comissão e funções comissionadas da Secretaria de Gestão de Pessoas são os constantes dos Anexos I e II desta Resolução.

 

CAPÍTULO II

 

DAS ALTERAÇÕES DO REGIMENTO INTERNO DA SECRETARIA

 

Art. 4º O art. 9º da Resolução TRE-AC nº 1.808/2025 passa a vigorar, quanto à área de gestão de pessoas, com a substituição da Coordenadoria de Gestão de Pessoas – COGEP pela Secretaria de Gestão de Pessoas – SGP e com a inclusão das unidades previstas no art. 2º desta Resolução e no Anexo I.

Art. 5º Os arts. 42 a 47 da Resolução TRE-AC nº 1.808/2025 passam a vigorar com a seguinte redação:

“Art. 42. Da Secretaria de Gestão de Pessoas – SGP

À Secretaria de Gestão de Pessoas compete:

I – planejar, dirigir, coordenar, supervisionar e integrar as políticas, programas, projetos e atividades relacionados à gestão de pessoas no âmbito do Tribunal;

II – propor políticas, normas, diretrizes, projetos e práticas administrativas relacionadas à administração e ao desenvolvimento de pessoas, à saúde, à qualidade de vida e à valorização da força de trabalho;

III – promover a governança de pessoas, acompanhar indicadores, riscos e controles internos da área e assegurar o alinhamento das ações às diretrizes institucionais e às normas do Conselho Nacional de Justiça, do Tribunal Superior Eleitoral e deste Tribunal;

IV – coordenar a elaboração das propostas orçamentárias relacionadas às despesas de pessoal e aos programas, projetos e ações de gestão de pessoas, em articulação com as Coordenadorias e Seções competentes;

V – propor a realização de concursos públicos e sua prorrogação, com o apoio técnico das unidades competentes;

VI – propor contratações, convênios, acordos de cooperação e outros instrumentos necessários à execução das atividades de gestão de pessoas;

VII – orientar e supervisionar as unidades subordinadas quanto à aplicação da legislação de pessoal e ao cumprimento dos direitos, deveres, impedimentos e obrigações funcionais;

VIII – promover a racionalização, a padronização, o mapeamento e o aperfeiçoamento dos processos de trabalho da área, bem como ações de gestão do conhecimento e de continuidade administrativa;

IX – acompanhar o planejamento estratégico e a execução dos planos de ação relativos à gestão de pessoas;

X – subsidiar a Presidência e a Diretoria-Geral na tomada de decisões relacionadas à força de trabalho;

XI – coordenar e consolidar informações destinadas aos órgãos de controle, quando relacionadas à área de gestão de pessoas;

XII – acompanhar, em conjunto com a unidade orçamentária e financeira, a utilização dos recursos relativos aos cargos em comissão e funções comissionadas, inclusive quanto às condições previstas na Resolução TRE-AC nº 1.787/2023;

XIII – acompanhar o cumprimento dos requisitos legais para ocupação dos cargos em comissão e funções comissionadas; e

XIV – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 43. Da Coordenadoria de Administração de Pessoas – COAPE

À Coordenadoria de Administração de Pessoas compete:

I – coordenar, orientar e supervisionar as atividades das Seções de Cadastro, Frequência, Apoio aos Inativos e Cadastro de Magistrados, Cálculos e Registros Financeiros e Pagamento;

II – coordenar as atividades relacionadas à administração da vida funcional, ingresso, movimentação, registros funcionais, frequência, aposentadorias, pensões, folha de pagamento, cálculos e registros financeiros;

III – estabelecer e acompanhar os fluxos de informações entre as unidades responsáveis pela geração do fato funcional, cálculo financeiro e processamento da folha de pagamento;

IV – assegurar a observância da segregação de funções e dos controles internos aplicáveis aos processos de pagamento e administração de pessoal;

V – consolidar dados e informações de sua área de atuação para subsidiar a Secretaria de Gestão de Pessoas, a Diretoria-Geral e a Presidência;

VI – acompanhar indicadores, riscos, prazos e planos de ação relacionados às matérias de sua competência;

VII – coordenar a elaboração das informações necessárias à proposta orçamentária de pessoal; e

VIII – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 44. Da Seção de Cadastro – SECAD

À Seção de Cadastro compete:

I – instruir e registrar os atos relacionados ao ingresso, posse, exercício, provimento e vacância de cargos;

II – verificar o cumprimento dos requisitos legais para investidura em cargos e funções;

III – registrar cargos, funções comissionadas, cargos em comissão, designações, dispensas, nomeações e exonerações;

IV – manter atualizado o cadastro funcional, a lotação e os registros de movimentação dos servidores;

V – registrar averbações e, após a respectiva concessão pela autoridade competente, os atos de aposentadoria e demais ocorrências funcionais em sistema próprio;

VI – expedir certidões de tempo de serviço e de contribuição e outras certidões relacionadas aos registros funcionais sob sua responsabilidade;

VII – organizar e manter atualizados os registros relativos ao teletrabalho, trabalho híbrido e trabalho presencial;

VIII – manter os dados cadastrais dos servidores requisitados e cedidos e realizar a análise técnica dos processos de requisição e cessão, no âmbito de suas atribuições;

IX – providenciar os dados necessários à emissão de crachás e carteiras funcionais;

X – fornecer às unidades responsáveis por cálculos e pagamento as ocorrências funcionais devidamente certificadas que produzam reflexos financeiros, sem proceder ao cálculo pecuniário correspondente;

XI – consolidar as informações de sua competência destinadas à transparência institucional e manter atualizados os registros e o rol de responsáveis que lhe forem atribuídos; e

XII – efetuar os registros de sua competência nos sistemas institucionais e desenvolver outras atividades inerentes à sua finalidade.”

“Art. 45. Da Seção de Frequência – SEFRE

À Seção de Frequência compete:

I – controlar e apurar a frequência dos servidores;

II – elaborar, registrar e controlar as escalas de férias;

III – registrar e controlar licenças, afastamentos e demais ocorrências que produzam efeitos na frequência, observado o pronunciamento técnico da unidade de saúde quando exigido;

IV – controlar substituições, serviço extraordinário, banco de horas, dias a compensar e respectivas formas de compensação;

V – encaminhar aos órgãos de origem a comunicação da frequência dos servidores requisitados ou cedidos, quando cabível;

VI – realizar e manter atualizado o cadastro biométrico relacionado ao sistema de controle de frequência;

VII – apurar mensalmente a frequência, o serviço extraordinário e o banco de horas para fins de pagamento, compensação ou acerto de contas;

VIII – encaminhar à SCRF e à SEPAG, conforme o fluxo aplicável, as ocorrências e quantitativos devidamente certificados que produzam reflexos financeiros, sem realizar a conversão desses quantitativos em valores pecuniários; e

IX – efetuar os registros de sua competência nos sistemas institucionais e desenvolver outras atividades inerentes à sua finalidade.”

“Art. 46. Da Seção de Apoio aos Inativos e Cadastro de Magistrados – SAREMI

À Seção de Apoio aos Inativos e Cadastro de Magistrados compete:

I – promover o recadastramento de aposentados e pensionistas e manter atualizados seus registros;

II – instruir, acompanhar e analisar os processos de concessão e revisão de aposentadorias e pensões;

III – realizar a análise dos requisitos jurídicos e funcionais para aposentadorias e pensões, elaborando simulações funcionais e manifestação técnica acerca do direito do interessado, cabendo à SCRF a apuração dos respectivos valores financeiros;

IV – orientar os servidores e demais interessados acerca dos requisitos relativos à aposentadoria e à pensão;

V – manter e prestar informações referentes a aposentados, pensionistas e demais beneficiários de sua área de atuação;

VI – efetuar os registros relativos aos atos de pessoal perante o Tribunal de Contas da União e outros órgãos de controle, nos limites de sua competência, inclusive quanto à admissão, desligamento, aposentadoria, pensão e falecimento, utilizando os dados fornecidos pelas demais unidades;

VII – acompanhar decisões e orientações dos órgãos de controle relacionadas à sua área de atuação;

VIII – manter atualizados os dados cadastrais dos membros do Tribunal, juízes e demais magistrados vinculados à Justiça Eleitoral;

IX – acompanhar períodos de atuação e afastamentos de membros e juízes eleitorais, bem como manter os registros necessários ao controle da antiguidade e dos términos de biênio;

X – fornecer às unidades competentes os períodos de atuação necessários à apuração das gratificações eleitorais e demais parcelas correlatas;

XI – expedir certidões relacionadas aos dados de membros, magistrados, aposentados e pensionistas mantidos pela unidade;

XII – prestar apoio técnico em matérias relacionadas à legislação de pessoal, quando demandada pela Coordenadoria ou pela Secretaria; e

XIII – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 47. Da Seção de Cálculos e Registros Financeiros – SCRF

À Seção de Cálculos e Registros Financeiros compete:

I – elaborar cálculos financeiros decorrentes de direitos, vantagens, indenizações, reembolsos e demais parcelas devidas a servidores, magistrados, pensionistas e demais beneficiários, a partir dos fatos e parâmetros funcionais devidamente certificados pelas unidades competentes;

II – calcular gratificações devidas a magistrados e demais autoridades, inclusive aquelas decorrentes de períodos de atuação informados pela SAREMI;

III – efetuar os cálculos relativos ao serviço extraordinário, banco de horas e demais ocorrências informadas pela SEFRE que produzam repercussão financeira;

IV – elaborar os cálculos de proventos de aposentadoria e de pensões, observada a análise do direito realizada pela SAREMI;

V – elaborar cálculos relativos a exercícios anteriores, passivos, diferenças remuneratórias e demais acertos financeiros;

VI – instruir e controlar os processos de reposição ao erário, inclusive parcelamentos e devoluções de valores recebidos indevidamente, promovendo a ciência dos interessados;

VII – proceder à análise e aos cálculos relativos ao reembolso da remuneração e dos encargos patronais de servidores cedidos;

VIII – manter atualizados os registros financeiros históricos, as fichas financeiras individuais e as memórias de cálculo;

IX – emitir certidões, atestados e declarações relativos aos registros financeiros sob sua responsabilidade;

X – apurar e consolidar os dados financeiros necessários ao cumprimento das obrigações fiscais, previdenciárias, trabalhistas e acessórias relacionadas à folha de pagamento, encaminhando-os à unidade responsável pela respectiva transmissão quando necessário;

XI – prestar informações e instruir processos que versem sobre dados e cálculos de vencimentos, proventos, vantagens e descontos; e

XII – desenvolver outras atividades inerentes à sua finalidade.

Parágrafo único. Não compete à SCRF confeccionar ou processar a folha de pagamento nem autorizar a realização de despesa, cabendo-lhe a elaboração e a manutenção dos cálculos e registros financeiros que subsidiarão o processamento da folha pela SEPAG.””

Art. 6º Ficam acrescidos à Resolução TRE-AC nº 1.808/2025 os arts. 47-A a 47-J, com a seguinte redação:

“Art. 47-A. Da Seção de Pagamento – SEPAG

À Seção de Pagamento compete:

I – receber e conferir, sob os aspectos de integridade, consistência e conformidade formal, os dados funcionais e financeiros encaminhados pelas unidades competentes para processamento em folha;

II – elaborar e processar as folhas de pagamento ordinárias e suplementares dos membros do Tribunal, juízes, promotores eleitorais, servidores ativos, aposentados, pensionistas e demais beneficiários;

III – processar, em folha, indenizações, reembolsos, gratificações, reposições ao erário, descontos legais ou judiciais e consignações voluntárias, com base nos atos, registros e cálculos previamente certificados;

IV – prestar informações para fins de empréstimos consignados, calcular margens consignáveis e expedir os documentos correspondentes;

V – proceder às averbações de consignações e manter atualizado o cadastro das entidades consignatárias;

VI – preparar demonstrativos de apropriação de despesas, relações bancárias, avisos de crédito, consignações a recolher e relatórios de pagamentos, encaminhando-os às unidades competentes pela execução orçamentária e financeira;

VII – manter atualizadas as tabelas utilizadas no processamento da folha de pagamento;

VIII – emitir contracheques, comprovantes de rendimentos e demais documentos cuja geração decorra diretamente da folha de pagamento;

IX – providenciar a transmissão e o acompanhamento dos eventos do eSocial relacionados ao pagamento de pessoal e das demais obrigações acessórias vinculadas à folha que estejam sob responsabilidade da unidade;

X – fornecer os elementos necessários à elaboração da proposta orçamentária relativa a vencimentos, proventos, vantagens e gratificações e subsidiar pedidos de créditos adicionais;

XI – cientificar os interessados acerca de atos ordinatórios relacionados às matérias de sua competência, quando determinado pela autoridade competente; e

XII – desenvolver outras atividades inerentes à sua finalidade.

§ 1º A conferência realizada pela SEPAG não substitui a responsabilidade da unidade que certificou o fato funcional nem a responsabilidade da SCRF pela elaboração do cálculo financeiro que lhe competir.

§ 2º Não compete à SEPAG elaborar cálculos individualizados de exercícios anteriores, passivos, aposentadorias, pensões, reposições ao erário ou outros cálculos atribuídos à SCRF, ressalvadas as operações automáticas inerentes ao sistema de folha a partir de parâmetros previamente estabelecidos e validados.”

“Art. 47-B. Da Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES

À Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida compete:

I – coordenar, orientar e supervisionar as atividades das Seções de Desenvolvimento, Capacitação, Saúde e Benefícios;

II – coordenar as políticas e ações de desenvolvimento de pessoas, gestão por competências, capacitação, saúde, qualidade de vida e benefícios;

III – promover a integração das ações de valorização, desenvolvimento e atenção à força de trabalho;

IV – coordenar ações relacionadas ao desenvolvimento gerencial, clima organizacional, saúde ocupacional e qualidade de vida no trabalho;

V – consolidar indicadores, riscos, necessidades orçamentárias e planos de ação das unidades subordinadas;

VI – propor programas, projetos, contratações e parcerias relacionados às matérias de sua competência; e

VII – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 47-C. Da Seção de Desenvolvimento – SEDEN

À Seção de Desenvolvimento compete:

I – planejar e executar ações de desenvolvimento de pessoas e gestão por competências;

II – realizar o levantamento e a análise de perfis profissionais, aptidões, interesses e competências dos servidores;

III – subsidiar tecnicamente a definição e a revisão de lotações e movimentações de pessoal, cabendo à SECAD efetuar os registros funcionais decorrentes dos atos aprovados;

IV – acompanhar servidores em estágio probatório e propor critérios e instrumentos para avaliação de desempenho;

V – coordenar e acompanhar os processos de avaliação de desempenho funcional;

VI – promover ações de ambientação e integração de novos servidores e colaboradores;

VII – identificar problemas de desempenho e propor ações de desenvolvimento destinadas à correção das lacunas identificadas;

VIII – acompanhar o programa de estágio, inclusive quanto ao levantamento das necessidades das unidades, acompanhamento dos estagiários e expedição dos documentos e certificados correspondentes;

IX – apoiar tecnicamente os procedimentos relacionados a concursos públicos, quando demandada;

X – desenvolver ações de desenvolvimento gerencial, gestão do clima organizacional, sucessão e gestão do conhecimento; e

XI – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 47-D. Da Seção de Capacitação – SCAP

À Seção de Capacitação compete:

I – elaborar, com o apoio da Escola Judiciária Eleitoral quando cabível, o Plano Anual de Capacitação, acompanhar sua execução e avaliar seus resultados;

II – planejar, divulgar, organizar e acompanhar cursos de habilitação, atualização, aperfeiçoamento e demais ações educacionais;

III – instruir processos de contratação e participação em ações de capacitação;

IV – controlar a frequência dos participantes, propor instrumentos de avaliação e analisar os resultados das ações educacionais;

V – manter atualizado o registro das capacitações realizadas pelos servidores;

VI – gerenciar banco de instrutores e as atividades de instrutoria interna;

VII – expedir e registrar certificados;

VIII – implementar, executar e acompanhar ações de educação a distância e outras metodologias de aprendizagem;

IX – acompanhar, em conjunto com as unidades orçamentária e financeira, os créditos destinados à capacitação, fornecendo os dados necessários à elaboração e ao acompanhamento da proposta orçamentária;

X – analisar, acompanhar e instruir processos relativos aos adicionais de qualificação decorrentes de ações de capacitação, graduação e pós-graduação, observada a legislação aplicável;

XI – acompanhar e instruir processos relativos ao auxílio-bolsa de estudos e outros programas educacionais;

XII – propor convênios, acordos e instrumentos de cooperação técnica, científica, educacional e cultural relacionados à sua área de atuação; e

XIII – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 47-E. Da Seção de Saúde – SESAU

À Seção de Saúde compete:

I – planejar, executar e acompanhar as ações de atenção à saúde de magistrados, servidores e colaboradores;

II – desenvolver programas de promoção da saúde, prevenção de doenças, saúde ocupacional e qualidade de vida no trabalho;

III – promover ações educativas de orientação à saúde, inclusive cursos, palestras, campanhas e atividades correlatas;

IV – prestar ou coordenar, conforme os serviços disponibilizados pelo Tribunal, atendimento médico, odontológico e psicossocial;

V – realizar ou providenciar avaliações de saúde para ingresso e posse em cargos do Tribunal;

VI – acompanhar exames periódicos e outras ações de vigilância em saúde;

VII – realizar, providenciar ou homologar perícias, atestados, laudos e pareceres médicos nos casos previstos em lei ou regulamento;

VIII – instruir tecnicamente os processos de licença por motivo de saúde e comunicar às unidades funcionais competentes o resultado administrativo necessário ao registro do afastamento;

IX – organizar e manter os prontuários e demais registros de saúde, observadas as normas de sigilo e proteção das informações;

X – promover orientação e encaminhamento a profissionais especializados, quando necessário;

XI – coordenar, acompanhar ou providenciar os programas, avaliações e laudos de saúde e segurança ocupacional atribuídos à área de saúde;

XII – realizar o levantamento das necessidades de materiais e medicamentos destinados aos serviços de saúde e manter os controles correspondentes;

XIII – participar, em sua área de competência, da elaboração e do acompanhamento dos planos de emergência das edificações utilizadas pelo Tribunal; e

XIV – desenvolver outras atividades inerentes à sua finalidade.

Parágrafo único. As competências da SESAU possuem natureza técnico-assistencial e de saúde, não abrangendo a administração cadastral ou financeira dos benefícios geridos pela SEBEN.”

“Art. 47-F. Da Seção de Benefícios – SEBEN

À Seção de Benefícios compete:

I – gerir os benefícios concedidos aos magistrados, servidores e demais beneficiários, inclusive auxílio-alimentação, assistência pré-escolar, auxílio-transporte, assistência médico-odontológica, plano de saúde e outros benefícios legais ou regulamentares;

II – instruir os processos de concessão, alteração, suspensão e exclusão de benefícios;

III – verificar o cumprimento dos requisitos legais e regulamentares para concessão e manutenção dos benefícios;

IV – manter atualizados os cadastros dos beneficiários e dependentes;

V – efetuar a apuração dos parâmetros, quantitativos e valores padronizados próprios dos benefícios, nos termos das normas aplicáveis;

VI – encaminhar à SEPAG os dados devidamente certificados para implantação, alteração ou exclusão dos benefícios em folha;

VII – encaminhar à SCRF os casos que exijam cálculos individualizados, retroativos ou acertos financeiros não realizados automaticamente pelo sistema;

VIII – promover o cadastramento e a exclusão de beneficiários dos planos e programas de assistência administrados pela unidade;

IX – orientar os beneficiários acerca da legislação, normas e regulamentos pertinentes;

X – acompanhar e controlar os pagamentos e reembolsos relacionados aos benefícios sob sua responsabilidade; e

XI – desenvolver outras atividades inerentes à sua finalidade.”

“Art. 47-G. Do Secretário de Gestão de Pessoas

Sem prejuízo das atribuições gerais previstas neste Regimento, incumbe ao Secretário de Gestão de Pessoas:

I – dirigir, coordenar e supervisionar a Secretaria e suas unidades;

II – estabelecer prioridades e diretrizes para execução das políticas de gestão de pessoas;

III – representar a área de gestão de pessoas perante a Administração e outras unidades institucionais;

IV – aprovar e encaminhar estudos, propostas, planos, relatórios e manifestações da Secretaria;

V – acompanhar indicadores, riscos, controles internos e resultados da área;

VI – assegurar a integração entre as Coordenadorias e a observância da segregação de funções;

VII – propor medidas de aperfeiçoamento da estrutura, dos processos e da força de trabalho; e

VIII – exercer outras atribuições inerentes à função de direção.”

“Art. 47-H. Dos Coordenadores

Sem prejuízo das atribuições gerais previstas neste Regimento, incumbe aos Coordenadores da SGP:

I – coordenar, orientar e supervisionar as Seções subordinadas;

II – distribuir prioridades e acompanhar a execução dos trabalhos;

III – assegurar a integração entre as Seções e o cumprimento dos fluxos, controles e prazos estabelecidos;

IV – acompanhar indicadores, riscos e controles internos de sua área;

V – revisar e consolidar informações e manifestações destinadas à Secretaria;

VI – promover a melhoria contínua dos processos e a adequada gestão do conhecimento; e

VII – exercer outras atribuições inerentes à função de direção e coordenação.”

“Art. 47-I. Dos Chefes de Seção

Sem prejuízo das atribuições gerais previstas neste Regimento, incumbe aos Chefes de Seção:

I – planejar, organizar, distribuir, orientar e supervisionar as atividades da respectiva unidade;

II – estabelecer prioridades e acompanhar prazos e resultados;

III – revisar, validar e certificar as informações produzidas pela Seção, nos limites de sua competência;

IV – implementar e manter os controles internos necessários à segurança dos processos de trabalho;

V – acompanhar os riscos relacionados às atividades da unidade e propor medidas de tratamento;

VI – promover a documentação, a padronização e a atualização dos procedimentos de trabalho;

VII – assegurar a preservação e a transferência do conhecimento técnico necessário à continuidade das atividades;

VIII – prestar informações à Coordenadoria e propor medidas de aperfeiçoamento dos serviços; e

IX – exercer outras atribuições inerentes à função de chefia.”

“Art. 47-J. Dos Assistentes I

As funções de Assistente I – FC-1 vinculadas às Seções da Secretaria de Gestão de Pessoas possuem natureza de assistência e assessoramento e destinam-se a:

I – prestar suporte qualificado ao Chefe da Seção no acompanhamento de processos, prazos, metas e demandas da unidade;

II – auxiliar na consolidação, análise e conferência de dados e informações destinados à tomada de decisão da chefia;

III – elaborar minutas, relatórios, demonstrativos, painéis, checklists e outros instrumentos de apoio técnico e gerencial;

IV – apoiar o acompanhamento de indicadores, riscos, controles internos, planos, projetos e contratos relacionados à unidade;

V – auxiliar na revisão, padronização, documentação e melhoria dos processos e procedimentos de trabalho;

VI – apoiar a organização e atualização da base de conhecimento da unidade e as ações de transferência de conhecimento;

VII – realizar verificações de conformidade e consistência de informações, sob orientação da chefia;

VIII – apoiar a consolidação de informações destinadas às auditorias e aos órgãos de controle;

IX – auxiliar a chefia na articulação com outras unidades e no acompanhamento das providências decorrentes dessa atuação; e

X – exercer outras atividades de assistência ou assessoramento diretamente relacionadas às competências da respectiva Seção.

§ 1º É vedada a caracterização da função de Assistente I como unidade administrativa, segmento subordinado à Seção ou mero posto de execução ordinária e indiferenciada.

§ 2º O Assistente I não possui competência administrativa autônoma nem poderá praticar atos decisórios reservados à chefia ou a autoridade superior, salvo quando formalmente designado para substituição, nos termos das normas aplicáveis.””

 

CAPÍTULO III

DOS CARGOS EM COMISSÃO E FUNÇÕES COMISSIONADAS

 

Art. 7º Para implementação da estrutura de que trata esta Resolução, são aprovadas, sem aumento de despesa, as seguintes transformações:

I – transformação de 1 (um) cargo em comissão CJ-3, criado pela Lei nº 15.374/2026, em 1 (um) cargo em comissão CJ-2; e

II – transformação de 3 (três) funções comissionadas FC-6, criadas pela Lei nº 15.374/2026, em 6 (seis) funções comissionadas de Assistente I – FC-1.

§ 1º As transformações previstas neste artigo observarão os valores e demonstrativos constantes do Anexo II.

§ 2º A estrutura final da Secretaria de Gestão de Pessoas será composta por:

I – 1 (um) cargo em comissão CJ-3;

II – 2 (dois) cargos em comissão CJ-2;

III – 9 (nove) funções comissionadas FC-6; e

IV – 9 (nove) funções comissionadas FC-1.

Art. 8º A aprovação da estrutura prevista nesta Resolução não constitui autorização automática para o provimento simultâneo de todos os cargos em comissão.

Art. 9º O provimento simultâneo do cargo CJ-3 e dos 2 (dois) cargos CJ-2 integrantes da estrutura da SGP fica condicionado à prévia certificação, pela Secretaria de Administração, Orçamento e Finanças – SAOF, da existência de disponibilidade orçamentária e financeira suficiente.

§ 1º Na inexistência de disponibilidade suficiente para o custeio integral da estrutura, deverá permanecer vago o cargo necessário à manutenção do equilíbrio financeiro, até que haja disponibilidade orçamentária ou seja adotada solução administrativa compatível com a legislação.

§ 2º A opção remuneratória prevista no art. 18, § 2º, da Lei nº 11.416/2006 possui caráter pessoal e não poderá ser imposta nem presumida como condição permanente de equilíbrio financeiro da estrutura.

§ 3º Qualquer alteração na opção remuneratória dos ocupantes dos cargos em comissão que possa produzir repercussão financeira deverá ser precedida de nova verificação pela SAOF.

Art. 10. O provimento dos cargos em comissão e funções comissionadas observará os percentuais, requisitos de escolaridade e demais condições previstos na Lei nº 11.416/2006 e na legislação aplicável.

 

CAPÍTULO IV

DOS CONTROLES, DA IMPLEMENTAÇÃO E DAS DISPOSIÇÕES TRANSITÓRIAS

 

Art. 11. A Secretaria de Gestão de Pessoas e a Secretaria de Administração, Orçamento e Finanças manterão acompanhamento contínuo dos recursos orçamentários relacionados aos cargos em comissão e funções comissionadas, nos termos da legislação e dos atos normativos deste Tribunal.

Art. 12. Após a aprovação desta Resolução, deverão ser adotadas as providências necessárias para:

I – comunicar ao Tribunal Superior Eleitoral a alteração da estrutura e demonstrar a ausência de aumento de despesa, na forma do art. 9º, § 3º, da Resolução TSE nº 22.138/2005;

II – submeter ao Tribunal Superior Eleitoral, por cautela, o quadro de transformação constante do Anexo II, em atenção ao art. 10, parágrafo único, da Resolução TSE nº 22.138/2005, antes do provimento dos recursos transformados, salvo orientação formal daquela Corte no sentido de ser suficiente a comunicação referida no inciso I; e

III – atualizar os sistemas administrativos, organogramas, cadastros, manuais, atos de lotação e demais registros institucionais.

Art. 13. Os processos administrativos, registros, sistemas, contratos, arquivos, atividades e pendências das unidades atuais serão transferidos às unidades sucessoras segundo a correspondência estabelecida no Anexo III, sem interrupção dos serviços.

§ 1º Até a revisão dos atos administrativos internos, as referências à Coordenadoria de Gestão de Pessoas – COGEP serão entendidas como referências à Secretaria de Gestão de Pessoas – SGP, quando compatíveis com as competências instituídas por esta Resolução.

§ 2º As referências às unidades SECARF, SEDES e SASBEN serão interpretadas segundo a distribuição material de competências constante do Anexo III.

Art. 14. A Diretoria-Geral e a Secretaria de Gestão de Pessoas poderão expedir atos destinados a detalhar procedimentos, fluxos, formulários, prazos e rotinas necessários à execução desta Resolução, vedada a modificação das competências essenciais atribuídas pelo Tribunal Pleno às unidades.

Art. 15. Integram esta Resolução:

I – Anexo I – Estrutura Organizacional da Secretaria de Gestão de Pessoas;

II – Anexo II – Demonstrativo de Origem, Transformação, Destinação e Custo dos Cargos em Comissão e Funções Comissionadas;

III – Anexo III – Quadro de Correspondência das Competências;

IV – Anexo IV – Organograma da Secretaria de Gestão de Pessoas; e

V – Anexo V – Matriz de Segregação de Responsabilidades.

Art. 16. Ficam substituídos, no que se refere à área de gestão de pessoas, os anexos da Resolução TRE-AC nº 1.808/2025 relativos à estrutura, ao organograma e aos cargos e funções, pelos correspondentes anexos desta Resolução.

Art. 17. Esta Resolução entra em vigor na data de sua publicação, observado, quanto ao provimento dos cargos e funções, o cumprimento das condições orçamentárias, financeiras e procedimentais previstas neste ato.

Plenário do Tribunal Regional Eleitoral do Acre, em Rio Branco/AC, ___ de __________ de 2026.

 

ANEXO I

ESTRUTURA ORGANIZACIONAL DA SECRETARIA DE GESTÃO DE PESSOAS

!Unidade|Sigla|Vinculação|Nível|Apoio funcional| 
|--- |--- |--- |--- |--- |--- |
|Secretaria de Gestão de Pessoas|SGP|Diretoria-Geral|CJ-3|—| 
|Coordenadoria de Administração de Pessoas|COAPE|SGP|CJ-2|—| 
|Seção de Cadastro|SECAD|COAPE|FC-6|1 Assistente I – FC-1| 
|Seção de Frequência|SEFRE|COAPE|FC-6|1 Assistente I – FC-1| 
|Seção de Apoio aos Inativos e Cadastro de Magistrados|SAREMI|COAPE|FC-6|1 Assistente I – FC-1| 
|Seção de Cálculos e Registros Financeiros|SCRF|COAPE|FC-6|1 Assistente I – FC-1| 
|Seção de Pagamento|SEPAG|COAPE|FC-6|1 Assistente I – FC-1| 
|Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida|CODES|SGP|CJ-2|—| 
|Seção de Desenvolvimento|SEDEN|CODES|FC-6|1 Assistente I – FC-1| 
|Seção de Capacitação|SCAP|CODES|FC-6|1 Assistente I – FC-1| 
|Seção de Saúde|SESAU|CODES|FC-6|1 Assistente I – FC-1| 
|Seção de Benefícios|SEBEN|CODES|FC-6|1 Assistente I – FC-1| 

Quadro-resumo

|Recurso|Quantidade| 
|--- |--- |
|CJ-3|1| 
|CJ-2|2| 
|FC-6|9| 
|FC-1 – Assistente I|9| 


Nota: as funções de Assistente I – FC-1 são funções de assessoramento vinculadas às respectivas Seções e não constituem unidades administrativas autônomas.

ANEXO II

DEMONSTRATIVO DE ORIGEM, TRANSFORMAÇÃO, DESTINAÇÃO E CUSTO

A – Recursos integrantes da estrutura atual da área de gestão de pessoas

|Recurso|Quantidade|Valor unitário considerado|Valor mensal|
|--- |--- |--- |--- |
|CJ-2|1|R$ 14.659,71|R$ 14.659,71|
|FC-6|5|R$ 3.956,81|R$ 19.784,05|
|FC-1|3|R$ 1.312,57|R$ 3.937,71|
|Total|9|—|R$ 38.381,47|

B – Recursos destinados ao TRE-AC pela Lei nº 15.374/2026 utilizados nesta reestruturação

Recurso de origem

|Recurso de origem|Quantidade|Valor unitário considerado|Valor mensal| 
|--- |--- |--- |--- | 
|CJ-3|2|R$ 16.665,13|R$ 33.330,26| 
|FC-6|7|R$ 3.956,81|R$ 27.697,67| 
|Total|9|—|R$ 61.027,93| 

Total nominal disponível antes das transformações: R$ 99.409,40 mensais.

Os cargos efetivos criados pela Lei nº 15.374/2026 não integram o objeto desta reestruturação.

C – Transformações

|Transformação|Valor de origem|Valor resultante|Redução mensal| 
|--- |--- |--- |--- | 
|1 CJ-3 em 1 CJ-2|R$ 16.665,13|R$ 14.659,71|R$ 2.005,42| 
|3 FC-6 em 6 FC-1|R$ 11.870,43|R$ 7.875,42|R$ 3.995,01| 
|Total|R$ 28.535,56|R$ 22.535,13|R$ 6.000,43| 

D – Estrutura resultante

Recurso|Quantidade|Valor unitário considerado|Valor mensal| 
|--- |--- |--- |--- | 
|CJ-3|1|R$ 16.665,13|R$ 16.665,13| 
|CJ-2|2|R$ 14.659,71|R$ 29.319,42| 
|FC-6|9|R$ 3.956,81|R$ 35.611,29| 
|FC-1|9|R$ 1.312,57|R$ 11.813,13| 
|Total|21|—|R$ 93.408,97| 

Redução estrutural nominal mensal decorrente das transformações: R$ 6.000,43.

E – Rastreamento da origem e destinação

|Origem|Situação|Destinação proposta| 
|--- |--- |--- |
|1 CJ-2 existente na COGEP|Mantido|COAPE – Coordenador – CJ-2|
|1 CJ-3 criado pela Lei nº 15.374/2026|Mantido|SGP – Secretário – CJ-3|
|1 CJ-3 criado pela Lei nº 15.374/2026|Transformado em CJ-2|CODES – Coordenador – CJ-2|
|5 FC-6 existentes na estrutura da COGEP|Mantidas, com adequação de denominação e lotação|SECAD, SAREMI, SEPAG, SEDEN e SESAU|
|4 das 7 FC-6 criadas pela Lei nº 15.374/2026|Mantidas como FC-6|SEFRE, SCRF, SCAP e SEBEN|
|3 das 7 FC-6 criadas pela Lei nº 15.374/2026|Transformadas|6 Assistentes I – FC-1|
|3 FC-1 já integrantes da estrutura da COGEP|Mantidas e redistribuídas|SECAD, SEDEN e SESAU|
|6 FC-1 resultantes da transformação|Criadas por transformação|SEFRE, SAREMI, SCRF, SEPAG, SCAP e SEBEN|

A distribuição das funções FC-1 tem por objetivo assegurar uma função de Assistente I em cada uma das nove Seções, preservada sua natureza de assessoramento.

ANEXO III

QUADRO DE CORRESPONDÊNCIA DAS COMPETÊNCIAS

|Competência atualmente exercida|Unidade(s) destinatária(s)|Tratamento| 
|--- |--- |--- |
|Planejamento, coordenação, orientação e supervisão geral da gestão de pessoas|SGP|Preservada| 
|Formulação de normas, projetos, diretrizes e práticas de gestão de pessoas|SGP|Preservada| 
|Proposição de concursos públicos e prorrogação|SGP, com apoio da SEDEN|Preservada e especializada| 
|Elaboração da proposta orçamentária da área de gestão de pessoas|SGP, COAPE e CODES|Preservada e distribuída por eixo| 
|Proposição de contratações relativas à gestão de pessoas|SGP e unidade técnica competente|Preservada| 
|Orientação acerca de direitos, deveres e proibições|SGP e unidades especializadas|Preservada| 
|Expedição de certidões relacionadas à área de pessoal|SECAD, SAREMI, SCRF e SGP, conforme a matéria|Distribuída por especialidade| 
|Projetos e programas de valorização e desenvolvimento de pessoas|SGP e CODES|Preservada| 
|Racionalização de métodos, procedimentos e rotinas|SGP, COAPE e CODES|Preservada| 
|Planejamento estratégico e planos de ação da área|SGP|Preservada| 
|Cadastro funcional, cargos, funções e lotação|SECAD|Transferida da SECARF| 
|Ingresso, posse, provimento e vacância|SECAD|Preservada e explicitada| 
|Averbações e registro de atos de aposentadoria já concedidos|SECAD|Preservada| 
|Certidões de tempo de serviço e contribuição|SECAD|Preservada| 
|Requisitos para investidura em cargos e funções|SECAD|Preservada| 
|Crachás e carteiras funcionais|SECAD|Preservada| 
|Teletrabalho, trabalho híbrido e registros cadastrais de requisitados|SECAD|Preservada e explicitada| 
|Frequência, férias, afastamentos e compensações|SEFRE|Desmembrada da SECARF| 
|Serviço extraordinário, banco de horas e substituições|SEFRE|Especializada| 
|Comunicação de frequência aos órgãos de origem|SEFRE|Preservada| 
|Cadastro biométrico do ponto|SEFRE|Preservada| 
|Recadastramento de aposentados e pensionistas|SAREMI|Preservada| 
|Concessão e revisão de aposentadorias e pensões – análise do direito|SAREMI|Preservada| 
|Cálculo dos valores de aposentadorias e pensões|SCRF|Segregado da análise do direito| 
|Registros de atos de pessoal perante o TCU e outros órgãos de controle|SAREMI|Preservada| 
|Acompanhamento de decisões do TCU na área de pessoal|SAREMI|Preservada| 
|Cadastro de membros e juízes eleitorais, períodos de atuação e afastamentos|SAREMI|Preservada| 
|Controle de antiguidade e término de biênios de membros e magistrados|SAREMI|Preservada| 
|Informação de períodos de atuação para gratificações eleitorais|SAREMI → SCRF → SEPAG|Segregada entre fato, cálculo e pagamento| 
|Apoio ao planejamento estratégico anteriormente atribuído à SAREMI|COAPE e SGP|Transferida| 
|Elaboração e processamento da folha|SEPAG|Preservada| 
|Folhas ordinárias e suplementares|SEPAG|Preservada| 
|Descontos legais, judiciais e consignações|SEPAG|Preservada| 
|Margens e entidades consignatárias|SEPAG|Preservada| 
|Demonstrativos de apropriação, relações bancárias e informações à execução financeira|SEPAG|Preservada| 
|Cadastro financeiro histórico e fichas financeiras|SCRF|Transferida e especializada| 
|Certidões e declarações financeiras individualizadas|SCRF|Transferida| 
|Contracheques e comprovantes gerados pela folha|SEPAG|Preservada| 
|Cálculos de vencimentos, vantagens, proventos e passivos|SCRF|Transferida da SEPAG| 
|Cálculos de exercícios anteriores|SCRF|Especializada| 
|Reposição ao erário e parcelamentos|SCRF, com desconto processado pela SEPAG|Segregada| 
|Reembolso de remuneração e encargo patronal de servidores cedidos|SCRF|Explicitada| 
|Obrigações fiscais, previdenciárias, trabalhistas e acessórias relativas à folha|SCRF – dados e memória; SEPAG – transmissão/processamento quando de sua competência|Segregada| 
|Subsídios orçamentários relativos à folha|SEPAG → COAPE/SGP|Preservada| 
|Plano Anual de Capacitação|SCAP|Transferida da SEDES| 
|Organização, contratação e avaliação de ações de capacitação|SCAP|Transferida da SEDES| 
|Registros de cursos, certificados, instrutoria interna e EAD|SCAP|Preservada| 
|Gestão dos créditos orçamentários destinados à capacitação|SCAP/CODES, em articulação com a área financeira|Preservada| 
|Adicional de Qualificação|SCAP|Preservada| 
|Auxílio-bolsa de estudos|SCAP|Preservada| 
|Cooperação técnica, científica, educacional e cultural relacionada à capacitação|SCAP/CODES|Preservada| 
|Levantamento de perfis, aptidões e interesses profissionais|SEDEN|Transferida da SEDES| 
|Apoio técnico à lotação e movimentação|SEDEN, com registro pela SECAD|Segregada| 
|Estágio probatório e avaliação de desempenho|SEDEN|Preservada| 
|Problemas de desempenho e ações de desenvolvimento|SEDEN|Preservada| 
|Ambientação de novos servidores|SEDEN|Especializada| 
|Gestão e acompanhamento de estagiários|SEDEN|Preservada| 
|Desenvolvimento gerencial, gestão do conhecimento e clima organizacional|SEDEN/CODES|Especializada| 
|Assistência médica, odontológica e ações de saúde|SESAU|Desmembrada da SASBEN| 
|Exames periódicos e avaliação de saúde para ingresso|SESAU|Preservada| 
|Perícias, licenças médicas, atestados e homologação de laudos|SESAU|Preservada| 
|Prontuários e registros de saúde|SESAU|Preservada| 
|Orientação psicossocial e encaminhamento especializado|SESAU|Preservada| 
|Programas de promoção da saúde e qualidade de vida|SESAU/CODES|Preservada| 
|Materiais e medicamentos dos serviços de saúde|SESAU|Preservada| 
|Participação da área de saúde em planos de emergência|SESAU|Preservada| 
|Auxílio-alimentação, assistência pré-escolar e auxílio-transporte|SEBEN|Desmembrada da SASBEN| 
|Administração do plano e da assistência à saúde enquanto benefício|SEBEN|Desmembrada da SASBEN| 
|Cadastro e exclusão de beneficiários e dependentes|SEBEN|Preservada| 
|Verificação dos requisitos para benefícios|SEBEN|Especializada| 
|Informações de benefícios para implantação em folha|SEBEN → SEPAG|Segregada| 

Nota: não se propõe a supressão material de competências atualmente atribuídas à área de gestão de pessoas. As atividades foram preservadas, especializadas ou distribuídas entre unidades sucessoras. Obrigações acessórias cuja denominação tenha sido superada por alterações legislativas ficam compreendidas na competência genérica relativa às obrigações fiscais, previdenciárias e trabalhistas vigentes.

ANEXO IV

ORGANOGRAMA DA SECRETARIA DE GESTÃO DE PESSOAS

SECRETARIA DE GESTÃO DE PESSOAS – SGP – CJ-3

→ Coordenadoria de Administração de Pessoas – COAPE – CJ-2

Seção de Cadastro – SECAD – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Frequência – SEFRE – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Apoio aos Inativos e Cadastro de Magistrados – SAREMI – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Cálculos e Registros Financeiros – SCRF – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Pagamento – SEPAG – FC-6

Apoio funcional: 1 Assistente I – FC-1

→ Coordenadoria de Desenvolvimento, Saúde e Qualidade de Vida – CODES – CJ-2

Seção de Desenvolvimento – SEDEN – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Capacitação – SCAP – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Saúde – SESAU – FC-6

Apoio funcional: 1 Assistente I – FC-1

Seção de Benefícios – SEBEN – FC-6

Apoio funcional: 1 Assistente I – FC-1

As referências aos Assistentes I indicam exclusivamente funções de apoio e assessoramento vinculadas às respectivas Seções, não representando unidades administrativas ou quarto nível hierárquico.

ANEXO V

MATRIZ DE SEGREGAÇÃO DE RESPONSABILIDADES

|Processo|Unidade responsável pelo fato/análise|Unidade responsável pelo cálculo|Unidade responsável pelo processamento/registro| 
|--- |--- |--- |--- | 
|Ingresso, posse, provimento e vacância|SECAD|SCRF, apenas se houver acerto financeiro específico|SECAD nos registros funcionais; SEPAG quando houver reflexo em folha| 
|Movimentação e lotação|SEDEN realiza análise técnica; autoridade competente decide|—|SECAD registra| 
|Frequência, banco de horas e serviço extraordinário|SEFRE apura e certifica quantitativos|SCRF converte em valores quando necessário|SEPAG processa em folha| 
|Aposentadoria|SAREMI analisa requisitos e direito|SCRF calcula proventos|SECAD registra o ato; SEPAG implanta em folha| 
|Pensão|SAREMI analisa requisitos e direito|SCRF calcula o valor|SEPAG implanta em folha| 
|Gratificações de magistrados e autoridades|SAREMI ou unidade competente certifica o período/fato|SCRF calcula|SEPAG processa em folha| 
|Benefícios|SEBEN verifica direito, requisitos e parâmetros|SEBEN nos valores padronizados; SCRF nos cálculos individualizados ou retroativos|SEPAG implanta ou altera em folha| 
|Licença por motivo de saúde|SESAU realiza análise técnica/pericial|—|SEFRE registra a ocorrência de frequência e SECAD promove o registro funcional quando cabível| 
|Reposição ao erário|Unidade de origem informa o fato; SCRF instrui e controla|SCRF calcula|SEPAG efetua desconto em folha quando determinado| 
|Exercícios anteriores e passivos|Unidade competente certifica o direito/fato|SCRF calcula|SEPAG processa quando autorizado| 
|Reembolso de servidor cedido|SECAD/SAREMI fornecem dados funcionais, conforme o caso|SCRF calcula remuneração e encargo patronal|Unidade financeira executa os procedimentos de cobrança/recolhimento cabíveis| 
|Folha de pagamento|SECAD, SEFRE, SAREMI, SCRF e SEBEN fornecem dados certificados|SCRF nos casos de sua competência|SEPAG consolida, confere formalmente e processa a folha| 
|Registros financeiros históricos|Unidades de origem fornecem informações|SCRF consolida|SCRF mantém fichas e memórias financeiras| 
|eSocial – eventos relacionados ao pagamento|Unidades competentes fornecem e certificam os dados de origem|SCRF fornece dados financeiros quando necessário|SEPAG transmite e acompanha os eventos de pagamento| 
|Atos de pessoal perante órgãos de controle|SAREMI, com dados da SECAD e demais unidades|—|SAREMI registra e acompanha| 

Regras gerais de controle:

 

A unidade responsável pelo fato funcional deverá certificar a ocorrência e os parâmetros sob sua responsabilidade antes de seu encaminhamento para cálculo ou pagamento.

A SCRF responderá pela correção dos cálculos financeiros que elaborar, preservada a responsabilidade da unidade de origem pela correção do fato e dos parâmetros funcionais informados.

A SEPAG responderá pela correta consolidação e processamento da folha, sem substituir a análise do direito ou o cálculo atribuído às demais unidades.

Nenhuma das unidades da SGP exercerá, por força desta Resolução, competência de autorização de despesa ou execução financeira reservada às autoridades e unidades competentes.

Sempre que possível, a elaboração do cálculo, sua conferência e o processamento do pagamento deverão observar segregação entre agentes distintos, como medida de controle interno.

Os fluxos operacionais poderão ser detalhados em manuais ou atos internos, desde que preservadas as competências e responsabilidades estabelecidas nesta Resolução.

 
---

Informação Orçamentária Nº 0916129 - PRESI/DG/SAOF/COFIN/SPEO

 

Trata-se de proposta de transformação da Coordenadoria de Gestão de Pessoas – Cogep em Secretaria de Gestão de Pessoas – SGP, no âmbito deste Tribunal.

Atualmente, a estrutura da Coordenadoria de Gestão de Pessoas dispõe de 1 (um) cargo em comissão CJ-2, 5 (cinco) funções comissionadas FC-6 e 3 (três) funções comissionadas FC-1.

Nos termos da proposta apresentada, a futura Secretaria de Gestão de Pessoas passará a contar com 1 (um) cargo em comissão CJ-3, 2 (dois) cargos em comissão CJ-2, 9 (nove) funções comissionadas FC-6 e 9 (nove) funções comissionadas FC-1.

Assim, comparativamente à estrutura atualmente existente, a implantação da nova Secretaria demandará o acréscimo de 1 (um) CJ-3, 1 (um) CJ-2, 4 (quatro) FC-6 e 6 (seis) FC-1.

Nesse contexto, registra-se que a Lei nº 15.374/2026 criou cargos efetivos, cargos em comissão e funções comissionadas no âmbito da Justiça Eleitoral. Para o Tribunal Regional Eleitoral do Acre foram criados 5 (cinco) cargos efetivos de Analista Judiciário, 5 (cinco) cargos efetivos de Técnico Judiciário, 2 (dois) cargos em comissão CJ-3 e 7 (sete) funções comissionadas FC-6.

Os cargos em comissão e as funções comissionadas criados pela referida Lei integram os recursos utilizados para viabilizar o incremento de CJ's e FC's necessário à composição final da SGP. Os demais cargos e funções já constam na estrutura da Cogep.

Em razão da proposta de implantação da Secretaria de Gestão de Pessoas, esta unidade foi demandada, por meio do Despacho GASAOF nº 0909419, a prestar informações de natureza orçamentária e financeira acerca dos seguintes aspectos:

a) manifestação conclusiva e atualizada quanto à disponibilidade orçamentária e financeira;

b) apresentação da memória de cálculo e do impacto anualizado; e

c) demonstração da compatibilidade da despesa com a Lei Orçamentária Anual – LOA, com a Lei de Diretrizes Orçamentárias – LDO e com os limites fiscais aplicáveis.

Quanto ao item “a”, verifica-se a existência de disponibilidade orçamentária suficiente para suportar as despesas decorrentes da implantação da estrutura proposta para a Secretaria de Gestão de Pessoas.

O TRE/AC recebeu dotação orçamentária suplementar no montante de R$ 6.131.334,00, consignada na Ação 20TP – Ativos Civis da União, destinada ao atendimento de despesas com pessoal, abrangendo, entre outras, despesas com décimo terceiro salário, provimento de cargos vagos, implementação da Gratificação por Atuação de Alta Complexidade, Técnica e Administrativa – GAACTA, bem como despesas relacionadas aos cargos em comissão e funções comissionadas vagos apurados em 31 de julho de 2026.

Considerando a dotação atualmente disponível e os valores necessários à implantação da nova estrutura, conforme memórias de cálculo constantes dos eventos 0918561, 0918564, 0918566, 0918567, 0918568 e 0918570, conclui-se pela existência de suporte orçamentário suficiente para o custeio dos cargos em comissão e das funções comissionadas contemplados na proposta.

Relativamente ao item “b”, as memórias de cálculo constantes dos eventos 0918561, 0918564, 0918566, 0918567, 0918568 e 0918570 demonstram os impactos decorrentes da alteração proposta, inclusive sua projeção anualizada, permitindo aferir os efeitos da implantação da nova estrutura sobre as despesas com pessoal deste Tribunal.

Dessa forma, os referidos demonstrativos atendem, sob o aspecto orçamentário-financeiro, à informação solicitada no Despacho GASAOF nº 0909419.

No que se refere ao item “c”, a criação dos cargos efetivos, cargos em comissão e funções comissionadas promovida pela Lei nº 15.374/2026 encontra fundamento no art. 169, § 1º, da Constituição Federal, segundo o qual a concessão de vantagens, a criação de cargos, empregos e funções e a admissão ou contratação de pessoal estão condicionadas à existência de prévia dotação orçamentária suficiente e à autorização específica na Lei de Diretrizes Orçamentárias.

No âmbito da LDO 2026, Lei nº 15.321/2025, destacam-se os arts. 125, 127 e 128, especialmente o inciso IV do caput do art. 128, que autoriza a criação de cargos, funções e gratificações, bem como o provimento de cargos efetivos, observados os quantitativos e os limites orçamentários estabelecidos no anexo específico da Lei Orçamentária Anual.

A Lei nº 15.346/2026 – LOA 2026, por sua vez, contempla, em seu art. 9º, inciso V, o Anexo V, destinado às autorizações específicas relacionadas às despesas com pessoal e encargos sociais, nos termos do art. 169, § 1º, inciso II, da Constituição Federal.

No referido Anexo V, Quadro I, item 2.5.3, consta expressamente o Projeto de Lei nº 4/2024, posteriormente convertido na Lei nº 15.374/2026, com autorização para a criação e o provimento dos cargos e funções nele especificados, inclusive aqueles destinados à Justiça Eleitoral.

Ressalte-se, todavia, que a criação legal dos cargos e funções não implica, por si só, geração automática e irrestrita da correspondente despesa. Sua efetiva implementação encontra-se condicionada à existência de dotação orçamentária suficiente e à observância dos limites e condições estabelecidos na Lei Complementar nº 101/2000 – Lei de Responsabilidade Fiscal, bem como dos limites individualizados de despesas primárias estabelecidos pela Lei Complementar nº 200/2023.

Tal condicionamento encontra-se, inclusive, expressamente previsto no art. 4º da Lei nº 15.374/2026.

No caso concreto, as dotações atualmente disponíveis na Ação 20TP, associadas aos demonstrativos de impacto constantes dos autos, evidenciam a existência de suporte orçamentário para a implementação da estrutura proposta, sem prejuízo da observância, durante sua execução, dos limites fiscais aplicáveis às despesas com pessoal e das demais restrições incidentes sobre as despesas primárias da Justiça Eleitoral.

Diante do exposto, sob o enfoque estritamente orçamentário e financeiro, conclui-se que:

a) há disponibilidade orçamentária suficiente para suportar as despesas decorrentes da implantação da estrutura proposta para a Secretaria de Gestão de Pessoas, considerando as dotações atualmente consignadas ao TRE/AC;

b) as memórias de cálculo constantes dos eventos 0918561, 0918564, 0918566, 0918567, 0918568 e 0918570 demonstram os impactos da alteração proposta, inclusive em bases anualizadas;

c) a criação dos cargos em comissão e funções comissionadas instituídos pela Lei nº 15.374/2026 encontra respaldo nas autorizações constantes da LDO 2026 e da LOA 2026; e

d) a efetiva implementação da nova estrutura deverá permanecer compatível com as dotações orçamentárias disponíveis, com a programação financeira e com os limites fiscais estabelecidos pela Lei Complementar nº 101/2000 e pela Lei Complementar nº 200/2023.

Assim, não se identifica, no âmbito das competências desta unidade e sob a perspectiva orçamentária e financeira, óbice à implantação da Secretaria de Gestão de Pessoas nos termos da estrutura proposta.

A presente manifestação restringe-se aos aspectos orçamentários e financeiros, não abrangendo juízo quanto à conveniência e oportunidade administrativa da reorganização, à definição da estrutura organizacional ou à competência para edição dos atos correspondentes.

À COFIN, para conhecimento e demais providências que julgar necessárias.

</0001059-72.2025.6.01.8000>  

Reestruturação da ASSAI

---

<0001896-98.2023.6.01.8000>  

---

Solicitação - PRESI/DG/ASSAI

Senhora Diretora-Geral

Esta servidora assumiu a Assistência de Sustentabilidade, Acessibilidade e Inclusão - ASSAI - no dia 14 de agosto de 2023, conforme Portaria PRESI n. 191/2023.

Além das atribuições do Núcleo Socioambiental, a ASSAI incorporou as atribuições atinentes à Acessibilidade e Inclusão.

De acordo com o Art. 15º, § 1º, II, da Resolução CNJ n. 400/2021, o TRE/AC deveria observar a lotação mínima de 2 servidores na unidade de sustentabilidade:

Art. 15. A unidade de sustentabilidade deve, preferencialmente, ser subordinada diretamente à Presidência, à Secretaria-Geral ou à Diretoria-Geral do órgão do Poder Judiciário.
§ 1o Deverá ser observada a seguinte lotação mínima na unidade de sustentabilidade:
I – 3 (três) servidores(as), nos tribunais que possuam mais de 5.000 servidores do quadro de pessoal;
II – 2 (dois) servidores(as), nos tribunais cuja quantidade de servidores seja inferior ao quantitativo mencionado no inciso I;

 

De acordo com o Art. 22º, § 2º, da Resolução CNJ n. 401/2021, é vedada a composição da unidade de acessibilidade por servidor único:

Art. 22. A unidade de acessibilidade e inclusão deve ter caráter permanente para assessorar o planejamento, a implementação e o monitoramento de ações que visem ao cumprimento desta Resolução.
...
§ 2o A unidade de acessibilidade e inclusão deve contar com integrantes em número compatível com a necessidade de execução e acompanhamento tempestivo das ações pertinentes a sua área de atuação, vedada a composição por servidor(a) único(a).

 

Atualmente, a unidade conta com apenas uma servidora acumulando as funções de sustentabilidade e acessibilidade, sendo que dois servidores seria a lotação mínima para cada uma das áreas.

Os efeitos dessa escassez de servidores são sentidos diariamente, diante das imensas demandas da unidade, principalmente demandas relacionadas ao Prêmio CNJ de Qualidade.

Apenas para título de exemplificação cito a exigência advinda do Art. 24 da Resolução CNJ n. 400/2021:

Art. 24. Os órgãos do Poder Judiciário devem implementar plano de compensação ambiental até o ano 2030 (Agenda 2030 – ONU), a fim de reduzir, permanentemente, a emissão de gases de efeito estufa, resultante de seu funcionamento.

 

Para cumprir com o disposto no artigo citado, os tribunais terão que fazer um inventário de emissão de gases de efeito estufa (SEI n. 0001034-30.2023.6.01.8000), um trabalho complexo, que requer uma força de trabalho totalmente incompatível com a encontrada na ASSAI atualmente.

Seria exaustivo listar todas as demandas da unidade, as quais tenho me dedicado intensamente, sem, no entanto, vislumbrar a efetividade que as atividades requerem. Não por falta de competência ou comprometimento com o trabalho, mas porque a força de trabalho alocada na unidade não é suficiente.

Por todo o exposto, por entender que a Administração está ciente da importância das ações de Sustentabilidade, Acessibilidade e Inclusão e por tratar-se de tema de suma importância que cada vez mais ganhará espaço na Administração Pública, demandando a cada dia mais esforços nas consecuções dos objetivos almejados;

Venho solicitar a reestruturação da ASSAI no termos abaixo:

1 - Alteração de "Assistência de Sustentabilidade, Acessibilidade e Inclusão" para "Assessoria de Sustentabilidade, Acessibilidade e Inclusão"

2 - Criação do Cargo em Comissão Assessor I, a ser retribuído com um Cargo em Comissão de Nível 1 - CJ-1

3 - Manter o Assistente V, retribuído com uma Função Comissionada de Nível 5 - FC-5.

À ASPLAN para conhecimento,

Respeitosamente,

---

Despacho nº 0622598 / 2023 - PRESI/ASPRES

Trata-se de pedido de reestruturação, formulado pela titular da Assistência de Sustentabilidade, Acessibilidade e Inclusão – ASSAI, onde requer (0619056):

1. Alteração de Assistência para Assessoria de Sustentabilidade, Acessibilidade e Inclusão;

2. Criação do cargo em comissão de Assessor I, a ser retribuído com CJ-1;

3. Permanência na ASSAI do cargo de Assistente V, retribuído com FC-5.

É o relato necessário. Decido.

Não há dúvidas de que a Assistência de Sustentabilidade, Acessibilidade e Inclusão – ASSAI precisa de melhoria na sua estrutura compatível com os moldes estabelecidos pelo Conselho Nacional de Justiça.

O Art. 15, § 1º, II, da Resolução CNJ n. 400/2021, estabelece a lotação mínima de 2 servidores na unidade de sustentabilidade:

Art. 15. A unidade de sustentabilidade deve, preferencialmente, ser subordinada diretamente à Presidência, à Secretaria-Geral ou à Diretoria-Geral do órgão do Poder Judiciário.

§ 1º Deverá ser observada a seguinte lotação mínima na unidade de sustentabilidade:

I – 3 (três) servidores(as), nos tribunais que possuam mais de 5.000 servidores do quadro de pessoal;

II – 2 (dois) servidores(as), nos tribunais cuja quantidade de servidores seja inferior ao quantitativo mencionado no inciso I;

§ 2º Os órgãos seccionais da Justiça Federal devem criar suas próprias unidades, observados os quantitativos mínimos estabelecidos no § 1o deste artigo.

Além disso, a Resolução CNJ nº 401/2021 estabelece que a unidade de acessibilidade e inclusão deve contar com integrantes em número compatível com a necessidade de execução e acompanhamento das ações pertinentes a sua área de atuação, vedada a composição por servidor único, in verbis:

Art. 22. A unidade de acessibilidade e inclusão deve ter caráter permanente para assessorar o planejamento, a implementação e o monitoramento de ações que visem ao cumprimento desta Resolução.

§ 1º A unidade de acessibilidade e inclusão deve, preferencialmente, ser subordinada diretamente à Presidência, à Secretaria-Geral, ou à Diretoria-Geral do órgão do Poder Judiciário.

§ 2º A unidade de acessibilidade e inclusão deve contar com integrantes em número compatível com a necessidade de execução e acompanhamento tempestivo das ações pertinentes a sua área de atuação, vedada a composição por servidor(a) único(a).

 

Para o atendimento das necessidades das Unidades deste Regional, inclusive da ASSAI, há a necessidade de criação de cargos efetivos e cargos de confiança e funções comissionadas.

Diante disso, esta Presidência por meio da Decisão de evento 0632180 determinou a reabertura do SEI 0002829-42.2021.6.01.8000 para fins de atualização das necessidades de estruturação das unidades deste Regional, com relação ao provimento de cargos efetivos, funções comissionadas e cargos em comissão na Secretaria e Cartórios Eleitorais deste Tribunal. E, concluído essa atualização será oficiado ao Tribunal Superior Eleitoral reiterando a solicitação de criação de cargos efetivos, cargos comissionados e funções comissionadas.

Assim, determino o sobrestamento do presente feito no GAPRES pelo prazo de 90 (noventa) dias.

 

Des. JÚNIOR ALBERTO

Presidente do TRE/AC

---

Despacho nº 0717851 / 2024 - PRESI/DG/COGEP

Em atenção ao despacho da Diretoria (0717713), manifesto-me no seguinte sentido:

 

a) Ante as crescentes demandas das unidades, inclusive a da ASSAI, não há dúvida que há necessidade de uma reestruturação, para o bom desenvolvimento das atividades, inclusive em razão das exigências advindas do CNJ;

b) No entanto, para uma melhor atuação das unidades nos assuntos que lhes competem há a necessidade de pessoal, o que esse Regional tem limitação, como vivenciamos, a exemplo de várias unidades que não podem contar com assistências, visto que simplesmente não há servidores para supri-las. Além disso, existem as limitações relativas a requisições, cargos em comissão e funções comissionadas, na Secretaria deste órgão, tanto em termos percentuais quanto a temporalidade - Lei n. 11.416/06, Lei 6.999/82 e Resolução TSE n. 23.523/17.

 

Atualmente tramita no Congresso Nacional o Projeto de Lei n. 04/2024, que objetiva a criação de cargos efetivos, cargos em comissão e funções comissionadas nos quadros de pessoal dessa Justiça, estando prevista para este Regional a criação de 5 novos cargos de Analista Judiciário, de 5 novos cargos de Técnico Judiciário, 2 CJ 3 e 7 FC 6.

 

No momento, então, não vejo possibilidade de atender a demanda da ASSAI, com a criação de uma CJ 1 e de uma FC 5 àquela unidade. 

 

Creio que quando houver discussão relativa a nova reestruturação, especialmente após aprovado o projeto que tramita, visto que teremos novos cargos e funções, deva ser priorizada a unidade de gestão de pessoas, ante a demanda crescente de responsabilidade e a diminuta estrutura, conforme já externado à administração. Não é demais lembrar que o único TRE do país que não conta com uma SGP é o TRE/AC, tendo as atividades aumentado de forma significativa. Do contrário, iremos sempre priorizar outras unidades em detrimento da gestão de pessoas, que inclusive conta com servidores em abono de permanência e podem a qualquer momento irem para a inatividade, o que certamente prejudicará os serviços.

 

Se o CNJ, por Resolução, define o quantitativo de servidores da unidade que atua na sustentabilidade e na acessibilidade, a gestão de pessoas deverá ser estruturada para também atuar em suas demandas diárias. 

 

À Diretoria.

---

Despacho nº 0727490 / 2024 - PRESI/GAAUX

 

Em atenção ao despacho GADG (evento 0719337), entendo oportuno trazer as seguintes considerações:

1. Primeiramente, destaco a importância dos requisitos do Eixo Governança que estão sob gestão da Assistência de Sustentabilidade, Acessibilidade e Inclusão, para o Prêmio CNJ de Qualidade:

1.1. Socioambiental, Resolução CNJ nº 400/2021 - requisito que exige o mínimo percentual do Índice de Desenvolvimento Sustentável em 65%, e máximo igual ou acima de 80%. Destacamos que o último resultado do Tribunal, referente a 2023, foi de 46,7%, ficando em 27º lugar entre os Tribunais Regionais Eleitorais, não alcançando qualquer pontuação para o Prêmio CNJ 2024. Ressalto que a pontuação para o prêmio de 2025 passará a ser de até 50 pontos, dobro da pontuação máxima atribuída em 2024, que era de 25 pontos. Esse aumento da valorização no Prêmio reflete a importância que o CNJ vem dando à Sustentabilidade no atual e preocupante cenário, impondo a necessidade de atuação do Poder Judiciário no enfrentamento da desafiadora crise climática, redução direta dos impactos de suas atividades sobre o meio ambiente e, ainda, aceleração da implementação de medidas de sustentabilidade. Para tanto, o CNJ tem realizado eventos, programas, celebração de compromissos pela sustentabilidade e vem atuando junto aos tribunais para que também adotem medidas que reflitam na melhoria dos indicadores;

1.2. Acessibilidade e Inclusão, Resolução CNJ nº 401/2021, Recomendação CNJ nº 144/2023 - requisito que exige ações de promoção à acessibilidade (tecnológica, comunicacional e capacitação) e inclusão pelo órgão. Também terá aumento de 40 para até 45 pontos, em 2025.

1.3. Destinação ambientalmente adequada do material de eleições (Resolução TSE n. 23.474/2016 e Resolução CNJ n. 400/2021): corresponde a 10 pontos do Eixo Governança e estará cumprido se forem realizadas ações para destinação ambientalmente adequada de materiais de eleições, inclusive decorrentes de apreensões de propaganda eleitoral irregular. Assim, a ASSAI atua diretamente junto às zonas eleitorais para recolhimento do material e devido encaminhamento ao CATAR, cooperativa que possui acordo de cooperação com o TRE.

2. A unidade ASSAI conta somente com uma servidora do quadro efetivo, Sra. Renata Nogueira Colaça Pires, com atuação não apenas no monitoramento dos requisitos acima, mas também na própria realização de ações envolvendo os demais setores do Tribunal, na temática da sustentabilidade e acessibilidade.

3. A par das atribuições da ASSAI, a servidora Renata Nogueira Colaça Pires integra as comissões temáticas de acessibilidade e sustentabilidade, bem como compõe o Laboratório de Inovação e Objetivos de Desenvolvimento Sustentável deste Tribunal, como uma das laboratoristas.

4. Se não bastassem todas essas ações e demandas estratégicas envolvendo o setor da ASSAI e a única servidora nele lotada, recentemente este Tribunal Regional Eleitoral manifestou a intenção no 1º Congresso Internacional realizado pelo CNJ nos dias 23 e 24 de outubro de 2024, de aderir ao Pacto Nacional do Poder Judiciário pela Sustentabilidade.

5. Trata-se de um Pacto que deverá ter a adesão de todos os Tribunais, em que objetiva o impulsionamento de ações, iniciativas e projetos voltados à sustentabilidade, reforçando a proteção ao meio-ambiente, a promoção do bem-estar social e à boa governança.

6. Todos os Tribunais que aderirem ao Pacto terão o prazo de 12 meses para realizar os projetos e iniciativas que estão dispostos em 03 eixos indicados no instrumento, os quais em linhas gerais, posso pontuar os seguintes:

6.1. Eixo ambiental: com a implementação do Programa Justiça Carbono Zero, priorização de julgamento das ações climáticas e ambientais e promoção da educação ambiental e capacitação de magistrados e servidores para a temática socioambiental;

6.2. Eixo social: com a adoção de política de reserva de vagas prevista no Programa Transformação, para mulheres em situação de vulnerabilidade, nos termos da Resolução n. 497/2023;  implementação de iniciativa institucional para inclusão de outros grupos  vulneráveis, a exemplo dos egressos do sistema prisional, pessoas em situação de rua e pessoas com deficiência, bem como fortalecimento de ações de acessibilidade, com adaptação dos espaços físicos e criação de plano de ação para ampliar o índice de acessibilidade. 

6.3. Eixo Governança:  implementação ou aperfeiçoamento do portal de dados abertos, melhoria dos sistemas de julgamento colegiado e adoção de serviços de boletim com um resumo didático e em linguagem simples, dos julgamentos mais relevantes realizados pelo Tribunal. 

7. Inclusive, para ficar o registro, o Pacto Nacional também prevê uma pontuação adicional para o Prêmio CNJ de Qualidade ao Tribunal que aderir ao instrumento e realizar as ações no prazo de 12 meses estipulado. 

8. Em arremate, a ASSAI ainda está sendo responsável por supervisionar todas as contratações do Tribunal, para implementar a política das contratações sustentáveis.  

9. Veja-se que são muitas demandas técnicas, de alto grau de responsabilidade, que exigem tempo de estudo, dedicação e implementação, algumas a serem desenvolvidas diretamente pelo Setor e outras em conjunto com os demais setores do Tribunal e parceria com instituições externas, em contínuo monitoramento e supervisionamento da ASSAI.

10. Feitas as considerações acima, observa-se a importância da ASSAI na implementação das políticas de governança do Tribunal, sendo necessário VALORIZAR E FORTALECER o setor para cumprir as atribuições que estão sob sua gestão e fazem parte do seu escopo. 

11. Dessa forma, manifesto-me de acordo com a PRIMEIRA PROPOSTA de reestruturação, que foi apresentada inicialmente pela titular da unidade no evento 0619056, por entender que sua operabilidade não encontra óbice no quadro defasado de servidores nem na disponibilidade orçamentária. 

Devolvo os autos ao Gabinete da Diretoria-Geral.

Rio Branco, 30 de outubro de 2024.

 

Louise Kristina Lopes de Oliveira Santana
Juíza Auxiliar da Presidência/ Coordenadora do Núcleo
Laboratório de Inovação e Gestão da Qualidade

---

Despacho nº 0734154 / 2024 - PRESI/GAAUX

Como forma de trazer mais subsídios para resolução da demanda objeto do presente SEI, esta magistrada formulou tratativas com a Servidora Renata Colaça, que está responsável pela ASSAI, bem como com o Servidor Carlos Venícius, que está na função de Diretor Geral Substituto.

Foi possível verificar na reunião que existe uma função comissionada FC1 sem utilização no setor GASAOF e outra função FC1 também sem utilização no NISIPJ. 

Assim, sugere-se a seguinte proposta de melhoria/reestruturação a ser implementada de forma IMEDIATA, até que o TSE crie novos cargos e funções e até que seja possível a transformação da ASSAI em Assessoria: 

1) Manter a Assistência de Sustentabilidade, Acessibilidade e Inclusão com as atribuições que já possui e a servidora Renata Colaça à frente do setor. 

2) Transformar uma FC6 para a Assistente da ASSAI, com o acréscimo da FC1 não utilizada pela GASAOF à FC5 atualmente recebida pela servidora.

3) Transferir a FC1 atualmente não utilizada pelo NISIPJ, para nomear um segundo servidor(a) para a ASSAI, auxiliando a assistente nas demandas de competência do setor e assim trazendo um reforço de pessoal, em atenção ao quantitativo mínimo previsto no artigo 15, § 1º, inciso II da Resolução CNJ n. 400/2021. 

Pertinente destacar que a proposta acima não implica em aumento de despesa nem em prejuízo para qualquer servidor, já que as duas FC1 ora mencionadas não estão sendo usadas.

Consigno ainda que já identificamos uma servidora interessada em integrar a ASSAI e trabalhar em conjunto com a Assistente Renata Colaça, inclusive com anuência do seu superior, possibilitando a execução imediata da proposta acima, caso acolhida pela Presidência.  

Assim, encaminho os autos ao Gabinete da Presidência para análise e deliberação. 

Rio Branco, 25 de novembro de 2024. 

 

Louise Kristina Lopes de Oliveira Santana

         Juíza Auxiliar da Presidência 

---

Portaria Presidência Nº 20/2025 PRESI/GAPRES

O DESEMBARGADOR JÚNIOR ALBERTO, PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

CONSIDERANDO a aprovação da Resolução TRE/AC 1.808/2025  que instituiu a nova estrutura orgânica do Tribunal Regional Eleitoral do Acre;

CONSIDERANDO o contido no processo SEI 0001896-98.2023.6.01.8000;

CONSIDERANDO o contido no processo SEI 0000901-90.2020.6.01.8000;

 

R  E  S  O  L  V  E:

 

Art. 1º. Exonerar RENATA NOGUEIRA COLAÇA PIRES  da Função Comissionada FC-5, Assistente V, para a qual foi designada por meio da Portaria Presidência n. 191/2023 PRESI/GAPRES, de 14 de agosto de 2023.

Art. 2º. Designar a sobredita servidora para ocupar a Função Comissionada FC-6, Assistente VI, Assistência de Sustentabilidade, Acessibilidade e Inclusão, permanecendo sua lotação na mesma unidade.

Art. 3º. Esta portaria entra em vigor na data de sua publicação, com efeitos a contar de 31 de janeiro de 2025.

 

Publique-se e cumpra-se com as cautelas necessárias.

 

Desembargador JÚNIOR ALBERTO

                                    Presidente

Rio Branco, 04 de fevereiro de 2025.

---

Portaria Presidência Nº 37/2025 PRESI/GAPRES

O DESEMBARGADOR JÚNIOR ALBERTO, PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

CONSIDERANDO a aprovação da Resolução TRE/AC 1.808/2025  que instituiu a nova estrutura orgânica do Tribunal Regional Eleitoral do Acre;

CONSIDERANDO o contido no processo SEI 0001896-98.2023.6.01.8000;

CONSIDERANDO o contido no processo SEI 0000901-90.2020.6.01.8000;

 

R  E  S  O  L  V  E:

 

Art. 1º. Dispensar da Função Comissionada FC-1, Assistente I, da Seção de Assistência à Saúde e Benefícios da Coordenadoria de Gestão de Pessoas, a servidora JAQUELINE BEZERRA DE ALBUQUERQUE ASSEM, para a qual foi designada por meio da Portaria Presidência n. 141/2021 PRESI/GAPRES, de 12 de agosto de 2021.

Art. 2º. Designar a sobredita servidora para ocupar a Função Comissionada FC-1, de Assistente I - DG, da  Diretoria-Geral, e lotá-la na Assistência de Sustentabilidade, Acessibilidade e Inclusão - ASSAI, a partir do dia 17 de fevereiro de 2025.

Art. 3º. Esta portaria entra em vigor na data de sua publicação, com efeitos a contar de 17 de fevereiro de 2025.

 

Publique-se e cumpra-se com as cautelas necessárias.

 

Desembargador JÚNIOR ALBERTO

                                    Presidente

Rio Branco, 19 de fevereiro de 2025.

---

Portaria Presidência Nº 54/2025 PRESI/GAPRES

O DESEMBARGADOR JÚNIOR ALBERTO, PRESIDENTE DO TRIBUNAL REGIONAL ELEITORAL DO ACRE, no uso das atribuições legais, destacando-se, neste particular, as disposições contidas no Art. 19, XI, XII e XIII c/c LV e LVII, do Regimento Interno e,

CONSIDERANDO a aprovação da Resolução TRE/AC 1.808/2025  que instituiu a nova estrutura orgânica do Tribunal Regional Eleitoral do Acre;

CONSIDERANDO o contido no processo SEI 0001896-98.2023.6.01.8000;

CONSIDERANDO o contido no processo SEI 0000901-90.2020.6.01.8000;

CONSIDERANDO as informações contidas no Despacho ASSAI 0754748;

 

R  E  S  O  L  V  E:

 

Art. 1º. Tornar sem efeito a Portaria Presidência nº 37/2025 PRESI/GAPRES (0753810), de 19 de fevereiro de 2025.

Art. 2º. Revogar o inciso III, do art. 2º, da Portaria Presidência nº 241/2021 PRESI/GAPRES (0462911), de 06 de dezembro de 2021, que lotou a servidora Jaqueline Bezerra de Albuquerque, na Seção de Assistência à Saúde e Benefícios, da Coordenadoria de Gestão de Pessoas.

Art. 3º. Lotar a servidora JAQUELINE BEZERRA DE ALBUQUERQUE ASSEM, na Assistência de Sustentabilidade, Acessibilidade e Inclusão - ASSAI, e designá-la para ocupar a Função Comissionada FC-1, de Assistente I - DG, da Diretoria-Geral, a partir do dia 17 de fevereiro de 2025.

Art. 4º. Esta portaria entra em vigor na data de sua publicação, com efeitos a contar de 17 de fevereiro de 2025.

Publique-se e cumpra-se com as cautelas necessárias.

 

 

Desembargador JÚNIOR ALBERTO

                                    Presidente

Rio Branco, 17 de março de 2025.

---

Despacho nº 0902721 / 2026 - PRESI/DG/ASSAI

Senhor Assessor,

Submeto à apreciação dessa Assessoria a proposta de reestruturação da Assistência de Sustentabilidade, Acessibilidade e Inclusão – ASSAI, retomando solicitação anteriormente apresentada (0619056).

Em outubro de 2023, foi submetida à Administração proposta para transformação da ASSAI em Assessoria de Sustentabilidade, Acessibilidade e Inclusão, com a criação de um Cargo em Comissão de nível CJ-1 e a manutenção da função comissionada então existente. A solicitação fundamentou-se, especialmente, na ampliação das atribuições da unidade, que passou a reunir as agendas de sustentabilidade e acessibilidade e inclusão, áreas submetidas a crescentes demandas normativas e institucionais.

Posteriormente, em novembro de 2024, diante da impossibilidade de implementação imediata da estrutura definitiva, a Presidência propôs uma solução provisória, com o reforço da unidade, expressamente “até que o TSE crie novos cargos e funções e até que seja possível a transformação da ASSAI em Assessoria”.

Na ocasião, a proposta contemplou a disponibilização de uma FC-1 para o ingresso de segundo servidor na unidade, reconhecendo-se a necessidade de adequação da estrutura às atribuições da ASSAI.

Considerando que, em 2026, foram criados novos cargos e funções para os Tribunais Regionais Eleitorais, entende-se superada a circunstância que fundamentou a adoção daquela solução provisória, mostrando-se oportuno retomar a proposta de reestruturação originalmente apresentada.

As atribuições previstas no Regimento Interno conferem à ASSAI atuação de natureza transversal, voltada ao planejamento, à proposição, ao assessoramento e ao monitoramento de ações nas áreas de sustentabilidade, acessibilidade e inclusão, abrangendo, entre outras, a elaboração e revisão do Plano de Logística Sustentável, o acompanhamento de indicadores e metas, a articulação institucional e a orientação quanto à adoção de critérios de sustentabilidade.

A relevância dessas atribuições também vem sendo reforçada pelas recentes normativas do Conselho Nacional de Justiça e do Tribunal Superior Eleitoral, com a ampliação das responsabilidades dos Tribunais em matéria de sustentabilidade, descarbonização, acessibilidade e inclusão. São exemplos a evolução da Política de Sustentabilidade do Poder Judiciário, o Programa Justiça Carbono Zero e, no âmbito da Justiça Eleitoral, iniciativas como o Programa Seu Voto Importa e a estruturação dos Coordenadores de Acessibilidade.

A atual gestão, por sua vez, tem demonstrado especial valorização dessas pautas, o que tem possibilitado a ampliação e o fortalecimento de projetos e programas institucionais nessas áreas, tornando ainda mais necessária a adequação da estrutura administrativa responsável pelo seu planejamento e acompanhamento.

Nesse contexto, a transformação da ASSAI em Assessoria permitirá conferir maior coerência entre a natureza estratégica de suas atribuições e sua posição na estrutura organizacional do Tribunal, fortalecendo sua atuação como unidade de assessoramento e suporte à tomada de decisão administrativa.

Diante do exposto, considerando a criação dos novos cargos e funções pelo TSE e o compromisso anteriormente manifestado pela Administração quanto à evolução da estrutura da unidade, submeto à apreciação dessa ASPLAN a proposta de:

1. transformação da atual Assistência de Sustentabilidade, Acessibilidade e Inclusão – ASSAI em Assessoria de Sustentabilidade, Acessibilidade e Inclusão;

2. criação de um Cargo em Comissão de nível CJ-1 para a Assessoria; e

3. manutenção da FC-6 atualmente existente na unidade.

Registra-se que a FC-1 atualmente disponibilizada à ASSAI, proveniente da estrutura da Diretoria-Geral, será devolvida àquela unidade, de modo que a presente proposta demanda, para sua implementação, apenas a criação da CJ-1 destinada à Assessoria.

Caso acolhida, solicita-se o encaminhamento da matéria à Diretoria-Geral, para as providências pertinentes e posterior submissão à apreciação da Presidência.

Respeitosamente,

---

Despacho nº 0902862 / 2026 - PRESI/DG/ASPLAN

À Diretoria-Geral

 

Senhora Diretora-Geral, 

 

Trata-se de proposta de reestruturação da Assistência de Sustentabilidade, Acessibilidade e Inclusão – ASSAI, com a transformação da unidade em Assessoria, criação de Cargo em Comissão nível CJ-1 e manutenção da FC-6 atualmente existente.

Após análise dos autos, manifesto concordância com a proposta apresentada pela ASSAI, por entender que a medida se mostra adequada e necessária diante da ampliação das atribuições institucionais da unidade, das crescentes demandas relacionadas às políticas de sustentabilidade, acessibilidade e inclusão e do fortalecimento dessas agendas no âmbito do Poder Judiciário e da própria Justiça Eleitoral, inclusive no TRE-AC.

Destaco, ainda, que a matéria já foi objeto de análise favorável em manifestações anteriores constantes dos autos. No Despacho nº 0727490, houve concordância expressa com a primeira proposta de reestruturação apresentada pela unidade (evento 0619056), reconhecendo-se a importância estratégica da ASSAI e a necessidade de seu fortalecimento institucional.

 

 (...) 10. Feitas as considerações acima, observa-se a importância da ASSAI na implementação das políticas de governança do Tribunal, sendo necessário VALORIZAR E FORTALECER o setor para cumprir as atribuições que estão sob sua gestão e fazem parte do seu escopo.

 

Da mesma forma, o Despacho nº 0734154 consignou proposta de reestruturação imediata e provisória, com reforço de pessoal e funções comissionadas, até que fosse possível a transformação da ASSAI em Assessoria, evidenciando o reconhecimento da necessidade de adequação da estrutura da unidade às suas atribuições.

Considerando, portanto, que os pressupostos que fundamentaram as manifestações anteriores permanecem válidos e que houve a criação de novos cargos e funções para os Tribunais Regionais Eleitorais, entendo oportuno o acolhimento da proposta ora apresentada pela ASSAI.

Ante o exposto, manifesto-me favoravelmente à proposta de reestruturação da ASSAI, nos termos do Despacho nº 0902721, e encaminho este procedimento para apreciação superior.

 

José Francisco da Silva Galvão

Assessor de Planejamento, Estratégia e Gestão

</0001896-98.2023.6.01.8000>  

---

<0001585-05.2026.6.01.8000>  

Solicitação de criação de unidade na STI

---

Solicitação - PRESI/DG/STI/GSTI

À Senhora Diretora-Geral,

Submeto à consideração superior proposta de criação da Assessoria de Dados e Business Intelligence, vinculada à Secretaria de Tecnologia da Informação, com a finalidade de estruturar, de forma permanente e especializada, as atividades de gestão, tratamento, integração, análise e disponibilização de dados institucionais.

O Tribunal dispõe de grande volume de dados distribuídos em sistemas corporativos, bases eleitorais, sistemas administrativos, painéis, planilhas setoriais e relatórios encaminhados a órgãos de controle. Contudo, a ausência de unidade formalmente responsável por consolidar, validar e transformar esses dados em informações gerenciais reduz a capacidade institucional de apoiar a tomada de decisão com dados confiáveis, tempestivos e padronizados.

Atualmente, demandas relacionadas a indicadores, estatísticas, relatórios e painéis gerenciais são atendidas de forma pontual e dispersa, muitas vezes com uso de planilhas, consultas manuais e processos não padronizados. Esse modelo mostra-se cada vez menos adequado à complexidade das demandas institucionais, especialmente em ano eleitoral, quando se intensificam as necessidades de monitoramento, planejamento logístico, gestão de pessoal, acompanhamento de ocorrências, apoio às zonas eleitorais e prestação de informações ao TSE, à Presidência, à Diretoria-Geral e às demais unidades do Tribunal.

A criação da Assessoria permitirá organizar essas atividades em unidade técnica própria, voltada ao desenvolvimento de painéis gerenciais, automação de relatórios, construção de indicadores, integração de bases de dados, produção de análises e apoio qualificado à tomada de decisão.

A vinculação à Secretaria de Tecnologia da Informação justifica-se pela natureza técnica das atividades envolvidas, que demandam conhecimentos em bancos de dados, integração de sistemas, segurança da informação, automação, arquitetura de soluções, governança de dados, desenvolvimento de painéis e sustentação de ambientes tecnológicos.

Registre-se que parte dessas atividades, especialmente as relacionadas à alimentação de portais e painéis, vem sendo absorvida de forma contingencial pela ASPLAN. Todavia, as ações de tratamento, integração, automação, segurança, sustentação tecnológica e governança técnica de dados possuem aderência direta às competências da STI.

Assim, propõe-se a institucionalização dessas atividades na Assessoria de Dados e Business Intelligence, bem como a realocação do servidor Jair Figueiredo para compor a unidade, considerando sua experiência nas atividades atualmente desempenhadas.

A medida apresenta retorno institucional relevante, pois fortalece a governança de dados, qualifica a produção de informações gerenciais, reduz retrabalho, diminui a dependência de controles manuais e amplia a capacidade de resposta do Tribunal às demandas internas e externas.

Além disso, a alocação formal de força de trabalho na STI possui impacto positivo na avaliação da maturidade institucional em governança de TIC, especialmente no iGovTIC-Jud, uma vez que o quantitativo de servidores vinculados à área de tecnologia é elemento relevante para aferir a capacidade operacional, a estruturação da unidade e a suficiência de recursos humanos destinados às demandas tecnológicas do órgão.

Nesse sentido, a criação da Assessoria, com a correspondente realocação de servidor que já atua em atividades técnicas de análise, tratamento e disponibilização de dados, contribui para retratar de forma mais adequada a força de trabalho efetivamente dedicada à TIC, fortalecendo a governança institucional e favorecendo o desempenho do Tribunal em indicadores nacionais de qualidade e gestão pública.

No âmbito eleitoral, a unidade poderá apoiar o acompanhamento da preparação das eleições, logística de urnas, locais de votação, colaboradores eleitorais, ocorrências, transmissão, suporte técnico e atendimento às zonas eleitorais. No âmbito administrativo, poderá subsidiar áreas como gestão de pessoas, orçamento, contratações, planejamento estratégico, produtividade, capacitação, saúde, benefícios e demais setores que dependam de informações estruturadas.

Diante do exposto, solicito a avaliação da presente proposta e, em caso de concordância superior, o encaminhamento às unidades competentes para adoção das providências necessárias à criação da Assessoria de Dados e Business Intelligence, vinculada à Secretaria de Tecnologia da Informação, com definição de suas atribuições regimentais, estrutura mínima e correspondente realocação de força de trabalho.

Sugere-se, para fins de regulamentação, a seguinte redação:

“Compete à Assessoria de Dados e Business Intelligence planejar, desenvolver, manter e aprimorar soluções de dados, indicadores, painéis gerenciais, relatórios analíticos e estudos estatísticos, com vistas a subsidiar a tomada de decisão institucional, o acompanhamento da estratégia, a gestão administrativa, a gestão eleitoral, a transparência e a melhoria dos processos de trabalho do Tribunal.

São atribuições da Assessoria de Dados e Business Intelligence: coletar, integrar, tratar, validar e consolidar dados institucionais; propor metodologias de indicadores e análise de dados; desenvolver painéis e relatórios de Business Intelligence; apoiar as unidades na definição e interpretação de indicadores; monitorar a qualidade e a consistência das informações; documentar bases, modelos, métricas e regras de negócio; apoiar a governança de dados; fomentar a cultura de dados; e atuar em conjunto com as demais unidades da Secretaria de Tecnologia da Informação na sustentação e evolução das soluções técnicas necessárias.”

Assim, submeto a presente proposta à consideração de Vossa Senhoria.

Respeitosamente,

---

# Neste procedimento SEI será inserida a proposta e todo o arcabouço de documentação e argumentos.

### Construção da Proposta

---

# Saída:   
- criar o documento formal de abertura do processo administrativo num arquivo "Termo Inicial";  
- criar o documento formal com a Contextualização, Fundamentação e Justificativa da proposta;  
- criar o documento formal com a argumentação de convencimento para a adoção da proposta;  
- criar os arquivos no formato markdown   
---


---


</0001585-05.2026.6.01.8000>  

---


