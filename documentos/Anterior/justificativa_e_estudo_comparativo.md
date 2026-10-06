### JUSTIFICATIVA, FUNDAMENTAÇÃO LEGAL E ESTUDO COMPARATIVO DE REESTRUTURAÇÃO ORGANIZACIONAL DA STIC (TRE-AC)

#### 1. FUNDAMENTAÇÃO LEGAL E ALINHAMENTO COM AS DIRETRIZES DO CNJ E TSE

A reestruturação da Secretaria de Tecnologia da Informação (STI) para **Secretaria de Tecnologia da Informação e Comunicação (STIC)** no Tribunal Regional Eleitoral do Acre (TRE-AC) encontra sólida sustentação no arcabouço normativo do Poder Judiciário Federal [1, 47, 48]:

### 1.1 Resolução CNJ nº 370/2021 (ENTIC-JUD 2021-2026)
- **Art. 21 (Macroprocessos Obrigatórios)**: Determina que os órgãos do Poder Judiciário constituam e mantenham estruturas organizacionais compatíveis com suas demandas, cobrindo compulsoriamente quatro macroprocessos fundamentais [26, 27, 28]:
  1. *Governança e Gestão de TIC* (Planejamento, Transformação Digital, Orçamento, Contratações, Riscos, Competências e Comunicação) [26, 27];
  2. *Segurança da Informação e Proteção de Dados* (Incidentes, Riscos, Continuidade e Nuvem) [27];
  3. *Desenvolvimento de Soluções e Aplicações* (Requisitos, Arquitetura, Sustentação e Ciclo Seguro) [27];
  4. *Infraestrutura e Serviços* (Disponibilidade, Ativos, Catálogo de Serviços, Central de Atendimento e Satisfação) [27, 28].
- **Art. 6º (Alinhamento Estratégico)**: Exige que o Plano Diretor de TIC (PDTIC) esteja estritamente alinhado ao Planejamento Estratégico Institucional e à ENTIC-JUD [11, 40].
- **Art. 15 (Transformação Digital)**: Exige a estruturação de ações de transformação digital de serviços, interoperabilidade e monitoramento contínuo [20, 21].
- **Art. 24 (Quadro Permanente de TIC)**: Exige dimensionamento adequado do quadro permanente de servidores dedicados exclusivamente às atividades de TIC [29].
- **Arts. 36 e 37 (Gestão de Continuidade e Riscos)**: Exige planos formais de continuidade de negócios e de gestão de riscos de TIC [36, 37].
- **Arts. 45 e 46 (Acompanhamento e Avaliação por OKRs e iGovTIC-JUD)**: Estabelece a metodologia OKR e o índice iGovTIC-JUD para mensurar a maturidade e efetividade da gestão de TIC no tribunal [44, 45].

### 1.2 Legislação do TRE-AC e Resolução nº 1.808/2025
- **Resolução TRE-AC nº 1.808/2025**: Atual Regimento Interno da Secretaria, que regula a STI nos Arts. 48 a 58 e a Assessoria de Gestão Eleitoral (AGEL) no Art. 40 [167, 168, 213].
- **Resolução TRE-AC nº 1.763/2021**: Plano Estratégico do TRE-AC (2021-2026), cujo Macrodesafio 6 impõe o "Aperfeiçoamento da Gestão Administrativa e da Governança Judiciária" mediante a revisão continuada de competências das unidades [162].
- **Resoluções Históricas (nº 1.215/2007 e nº 1.646/2011)**: Regimentos anteriores que demonstram a evolução do organograma e as lacunas históricas herdadas [49, 75, 90].

---

#### 2. EVOLUÇÃO HISTÓRICA DOS NORMATIVOS E LACUNAS REMANESCENTES

A análise da evolução regulatória da Secretaria do TRE-AC revela um padrão de adequações pontuais que deixaram lacunas estruturais importantes [48]:

1. **Resolução TRE-AC nº 1.215/2007**: Estrutura inicial que tratava a TIC predominantemente como suporte operacional de informática (Coordenadoria de Infraestrutura e Coordenadoria de Logística e Soluções Corporativas) [68, 75].
2. **Resolução TRE-AC nº 1.646/2011**: Promoveu adequações redacionais e criou competências para a Seção de Suporte às Zonas Eleitorais e Seção de Planejamento e Estatística, porém manteve a área de TI focada em suporte básico e sem divisão especializada para governança, inteligência de dados ou cibersegurança [51, 75, 90].
3. **Resolução TRE-AC nº 1.808/2025**: Atualizou nomenclaturas (criando a SCSEG e a SSEC), porém **perpetuou lacunas críticas** [168, 169]:
   - **Ausência de Unidade de Inteligência de Dados / BI**: Inexistência de setor voltado para governança de dados, engenharia de dados e criação de dashboards em Business Intelligence [48].
   - **Falta de Segregação no Planejamento de Contratações de TIC**: O planejamento de contratações permaneceu difuso na Assistência de Governança (ASPGOVTI), sem equipe focada no acompanhamento prévio de ETPs e TRs [168, 233, 235].
   - **Indefinição na Sustentação em Produção e Manutenção de Hardware**: Inexistência de áreas dedicadas ao deploy seguro (CI/CD) e manutenção especializada de hardware [48].
   - **Desconexão da Gestão Eleitoral (AGEL)**: A Assessoria de Gestão Eleitoral (AGEL - Art. 40) foi mantida isolada na Diretoria-Geral, criando um hiato entre quem "planeja a eleição" no papel e as unidades da STI que efetivamente "preparam as urnas, geram as mídias e operam os sistemas eleitorais" [48, 167, 213].

---

#### 3. DIAGNÓSTICO DOS GARGALOS E JUSTIFICATIVA TÉCNICA DA REESTRUTURAÇÃO

### 3.1 Incompatibilidade da AGEL Desconexa do Planejamento de TIC
A manutenção da Assessoria de Gestão Eleitoral (AGEL) subordinada diretamente à Diretoria-Geral (Art. 40 da Res. 1.808/2025) gerava uma disfunção administrativa grave [48, 167, 213]:
- A AGEL não possuía atribuições técnicas nem servidores de TIC para executar o que planejava.
- Toda a execução prática – preparação de urnas, testes de carga, geração de mídias, instalação dos sistemas CAND e de totalização – dependia das seções da STI [99, 100, 246].
- Isso gerava duplicidade de alinhamentos, ruído de comunicação e dependência cruzada entre a Diretoria-Geral e a STI.

### 3.2 Ausência de Unidades de Execução Efetiva do Planejamento Eleitoral
Na estrutura da Resolução 1.808/2025, não havia dentro da STI uma Coordenadoria com foco **exclusivo e integral** no ciclo de vida da eleição [48, 168]:
- As atribuições ficavam divididas entre a Seção de Urnas Eletrônicas (SEUE) na Infraestrutura e a Seção de Sistemas Eleitorais e Corporativos (SSEC) na Coordenadoria de Soluções Corporativas [168, 169].
- A nova proposta cria a **Coordenadoria de Gestão e Logística de Urna (1.4)**, reunindo Logística de Materiais e Urnas (1.41), Manutenção e Simulados (1.42) e Sistemas Eleitorais (1.43), garantindo um comando único para a execução do pleito [47, 48].

### 3.3 Necessidade de Unidades para Implementação de Diretrizes do TSE e Simulados
O TSE renova a cada eleição as resoluções sobre sistemas eleitorais, testes de integridade e auditoria [48]. A nova estrutura provê:
- **Unidade específica para Simulados e Testes de Carga (1.42)**: Responsável por realizar exaustivos testes de estresse, simulação de votos, auditoria das urnas e testes de confirmação das mídias antes do dia da votação [48].
- **Unidade específica para Sistemas Eleitorais (1.43)**: Dedicada a implementar, capacitar e operar os sistemas oficiais do TSE (CAND, Divulga, Totalização, Horário Eleitoral e Diplomação) [48, 246, 281].

---

#### 4. ESTUDO COMPARATIVO COM DEMAIS TRIBUNAIS (BENCHMARKING)

A proposição de absorção da AGEL pela estrutura de TIC é respaldada pelo modelo adotado na Justiça Eleitoral em todo o Brasil [48, 50]:

### Análise dos Regimentos Internos dos 27 TREs e TSE:
A pesquisa sobre a estrutura organizacional das Secretarias de TIC e Gestão Eleitoral nos Tribunais Regionais Eleitorais (TSE, TRE-AC, TRE-AP, TRE-AM, TRE-PA, TRE-RO, TRE-RR, TRE-TO, TRE-AL, TRE-BA, TRE-CE, TRE-MA, TRE-PB, TRE-PE, TRE-PI, TRE-RN, TRE-SE, TRE-DF, TRE-GO, TRE-MT, TRE-MS, TRE-ES, TRE-MG, TRE-RJ, TRE-SP, TRE-PR, TRE-RS, TRE-SC) revela [48, 50]:

- **25 Tribunais (92,6%)**: Integram a logística de urnas, suporte aos sistemas eleitorais e planejamento operacional da eleição **diretamente dentro da Secretaria de Tecnologia da Informação** (por meio de Coordenadorias ou Divisões de Eleições/Logística Eleitoral pertencentes à STI).
- **Apenas 2 Tribunais (7,4%)**: Mantinham estrutura de Assessoria Eleitoral isolada da STI, sendo o TRE-AC um desses casos atypicos até a presente revisão.

**Conclusão do Benchmark**: A integração da gestão eleitoral dentro da STIC alroinha o TRE-AC às melhores práticas do Tribunal Superior Eleitoral e da quase totalidade dos Regionais, promovendo eficiência operacional, economia de recursos e maior segurança jurídica e técnica [48, 50].

---

#### 5. QUADRO COMPARATIVO "DE-PARA" (RES. 1.808/2025 x NOVA PROPOSTA STIC)

| Estrutura Atual (Resolução TRE-AC nº 1.808/2025) [167, 168, 169] | Nova Estrutura Proposta (STIC) [47] | Justificativa da Alteração / Melhoria Alcançada [48] |
| :--- | :--- | :--- |
| **Secretaria de Tecnologia da Informação (STI)** [168] | **Secretaria de Tecnologia da Informação e Comunicação (STIC)** [47] | Adequação da nomenclatura nacional, alinhando TIC e Comunicação Tecnológica [47]. |
| **Assessoria de Gestão Eleitoral (AGEL)** *(vinculada à DG - Art. 40)* [167, 213] | **1.4 Coordenadoria de Gestão e Logística de Urna** *(subordinada à STIC)* [47] | Absorção total da AGEL pela STIC, unificando planejamento e execução operacional [48]. |
| **Assistência de Planejamento e Governança de TIC (ASPGOVTI)** [168, 233] | **1.02 Coordenadoria de Planejamento de TIC**<br>• *1.021 Seção de Governança de TIC*<br>• *1.022 Seção de Planejamento de Contratação* [47] | Elevação da governança ao nível tático e segregação do Planejamento de Contratações (ETP/TR) [48]. |
| *(Inexistente / atribuição difusa)* [48] | **1.03 Seção de Inteligência de Dados** [47] | Criação de setor para BI, analytics, governança de dados e atendimento às metas do CNJ (DataJud) [7, 48]. |
| **Seção de Cibersegurança (SCSEG)** *(na Infraestrutura)* [168, 244] | **1.21 Seção de Segurança e Inovação** [47] | Agrupamento de cibersegurança com cultura de inovação e prototipagem tecnológica [48, 186]. |
| *(Inexistente - pulverizada no suporte)* [48] | **1.22 Seção de Manutenção de Hardware** [47] | Unidade focada na manutenção preventiva/corretiva e controle de obsolescência do parque [28, 48]. |
| **Seção de Redes (SEREDE)** [168, 239] | **1.23 Seção Provedor de Serviços** [47] | Gestão centralizada de Data Centers, virtualização, nuvem e backups institucionais [27, 47, 239]. |
| **Seção de Suporte aos Usuários (SSU)** [168, 243] | **1.24 Seção de Suporte aos Usuários** [47] | Manutenção da Central de Serviços (Helpdesk N1/N2) e fomento à satisfação do usuário [23, 243]. |
| **Seção de Desenvolvimento e Banco de Dados (SDBD)** [169, 248] | **1.31 Seção de Desenvolvimento de Sistemas**<br>• **1.33 Seção de Banco de Dados** [47] | Desmembramento para especialização da engenharia de software e da administração de SGBD [47, 248]. |
| **Seção de Sistemas Eleitorais e Corporativos (SSEC)** [169, 246] | **1.32 Seção de Sustentação e Manutenção Sistêmica**<br>• **1.34 Seção de Sustentação de Produção** [47] | Foco exclusivo em sustentação de sistemas corporativos, deploy contínuo (CI/CD) e testes de carga [47, 48]. |
| **Seção de Urnas Eletrônicas (SEUE)** [168] | **1.41 Seção de Logística de Materiais e Urna**<br>• **1.42 Seção de Manutenção e Simulados**<br>• **1.43 Seção de Sistemas Eleitorais** [47] | Estruturação completa do ciclo eleitoral em 3 seções especializadas em materiais, simulados e sistemas [47, 48]. |

---

#### 6. MELHORIAS E GANHOS DE EFICIÊNCIA ALCANÇADOS

A implementação da nova proposta trará os seguintes benefícios diretos para o TRE-AC [48]:

1. **Eficiência Operacional no Pleito**: Eliminação da barreira administrativa entre o planejamento (antiga AGEL) e a execução técnica de preparação de urnas e sistemas eleitorais [48, 213].
2. **Prontidão e Confiabilidade Sistêmica**: Realização sistemática de simulados de eleição, testes de estresse, auditorias e verificações de integridade por uma seção especializada (1.42) [48, 100].
3. **Conformidade Total com a Resolução CNJ nº 370/2021**: Cobertura integral dos 4 macroprocessos obrigatórios estabelecidos no Art. 21 da ENTIC-JUD [21, 26, 27, 28].
4. **Decisão Baseada em Dados**: A Seção de Inteligência de Dados (1.03) fornecerá dashboards e estatísticas para subsidiar decisões estratégicas da Corte e do TSE em tempo real [7, 283].
5. **Transparência e Alinhamento com o Benchmark Nacional**: Alinhamento do TRE-AC com o padrão adotado por 92,6% dos Tribunais Regionais Eleitorais e pelo TSE [48, 50].
