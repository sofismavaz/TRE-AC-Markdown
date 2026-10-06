### JUSTIFICATIVA, FUNDAMENTAÇÃO LEGAL E ESTUDO COMPARATIVO DE REESTRUTURAÇÃO ORGANIZACIONAL DA STIC (TRE-AC)

### 1. FUNDAMENTAÇÃO LEGAL E ALINHAMENTO COM AS DIRETRIZES DO CNJ E TSE

A reestruturação da Secretaria de Tecnologia da Informação (STI) para **Secretaria de Tecnologia da Informação e Comunicação (STIC)** no Tribunal Regional Eleitoral do Acre (TRE-AC) encontra sólida sustentação no arcabouço normativo do Poder Judiciário Federal [1, 47, 48]:

#### 1.1 Resolução CNJ nº 370/2021 (ENTIC-JUD 2021-2026)
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

#### 1.2 Legislação do TRE-AC e Resolução nº 1.808/2025
- **Resolução TRE-AC nº 1.808/2025**: Atual Regimento Interno da Secretaria, que regula a STI nos Arts. 48 a 58 e a Assessoria de Gestão Eleitoral (AGEL) no Art. 40 [167, 168, 213].
- **Resolução TRE-AC nº 1.763/2021**: Plano Estratégico do TRE-AC (2021-2026), cujo Macrodesafio 6 impõe o "Aperfeiçoamento da Gestão Administrativa e da Governança Judiciária" mediante a revisão continuada de competências das unidades [162].
- **Resoluções Históricas (nº 1.215/2007 e nº 1.646/2011)**: Regimentos anteriores que demonstram a evolução do organograma e as lacunas históricas herdadas [49, 75, 90].

---

### 2. EVOLUÇÃO HISTÓRICA DOS NORMATIVOS E LACUNAS REMANESCENTES

A análise da evolução regulatória da Secretaria do TRE-AC revela um padrão de adequações pontuais que deixaram lacunas estruturais importantes [48]:

1. **Resolução TRE-AC nº 1.215/2007**: Estrutura inicial que tratava a TIC predominantemente como suporte operacional de informática (Coordenadoria de Infraestrutura e Coordenadoria de Logística e Soluções Corporativas) [68, 75].
2. **Resolução TRE-AC nº 1.646/2011**: Promoveu adequações redacionais e criou competências para a Seção de Suporte às Zonas Eleitorais e Seção de Planejamento e Estatística, porém manteve a área de TI focada em suporte básico e sem divisão especializada para governança, inteligência de dados ou cibersegurança [51, 75, 90].
3. **Resolução TRE-AC nº 1.808/2025**: Atualizou nomenclaturas (criando a SCSEG e a SSEC), porém **perpetuou lacunas críticas** [168, 169]:
   - **Ausência de Unidade de Inteligência de Dados / BI**: Inexistência de setor voltado para governança de dados, engenharia de dados e criação de dashboards em Business Intelligence [48].
   - **Falta de Segregação no Planejamento de Contratações de TIC**: O planejamento de contratações permaneceu difuso na Assistência de Governança (ASPGOVTI), sem equipe focada no acompanhamento prévio de ETPs e TRs [168, 233, 235].
   - **Fragmentação na Infraestrutura e Sustentação**: Atividades de servidores/redes e manutenção física de hardware pulverizadas em seções separadas sem gestão integrada de serviços [48].
   - **Desconexão da Gestão Eleitoral (AGEL)**: A Assessoria de Gestão Eleitoral (AGEL - Art. 40) foi mantida isolada na Diretoria-Geral, criando um hiato entre quem "planeja a eleição" no papel e as unidades da STI que efetivamente "preparam as urnas, geram as mídias e operam os sistemas eleitorais" [48, 167, 213].

---

### 3. DIAGNÓSTICO DOS GARGALOS E JUSTIFICATIVA TÉCNICA DAS OTIMIZAÇÕES

#### 3.1 Incompatibilidade da AGEL Desconexa do Planejamento de TIC
A manutenção da Assessoria de Gestão Eleitoral (AGEL) subordinada diretamente à Diretoria-Geral (Art. 40 da Res. 1.808/2025) gerava uma disfunção administrativa grave [48, 167, 213]:
- A AGEL não possuía atribuições técnicas nem servidores de TIC para executar o que planejava.
- Toda a execução prática – preparação de urnas, testes de carga, geração de mídias, instalação dos sistemas CAND e de totalização – dependia das seções da STI [99, 100, 246].
- Isso gerava duplicidade de alinhamentos, ruído de comunicação e dependência cruzada entre a Diretoria-Geral e a STI.

#### 3.2 Otimização e Unificação por Afinidades Operacionais
A revisão promovida nesta proposta racionaliza a estrutura para maximizar a eficiência e enxugar o quadro administrativo:
- **Unificação na Infraestrutura (1.22 Seção de Infraestrutura e Serviços)**: A fusão das antigas seções de Provedor de Serviços e Engenharia de Hardware consolida a gestão do Data Center, redes, serviços em nuvem, servidores e cópias de segurança com a manutenção física e gestão do ciclo de vida dos equipamentos em uma única unidade resiliente [27, 28, 48].
- **Reorganização Enxuta da Gestão Eleitoral em 2 Seções (1.41 e 1.42)**: Em vez de manter 3 seções fragmentadas, agruparam-se todas as competências da eleição por estrita afinidade:
  1. *Eixo Físico e Operacional*: A **1.41 Seção de Logística, Manutenção e Simulados de Urnas** reúne toda a cadeia física do pleito (suprimentos, transporte, manutenção preventiva/corretiva das urnas, inseminação, geração de mídias e testes de simulados) [48, 100].
  2. *Eixo Sistêmico e Tecnológico*: A **1.42 Seção de Sistemas e Tecnologia Eleitoral** concentra os softwares do TSE (CAND, Totalização, Transmissão, Diplomação), treinamento dos cartórios e plano de transmissão em tempo real [48, 246].

---

### 4. ESTUDO COMPARATIVO COM DEMAIS TRIBUNAIS (BENCHMARKING)

A proposição de absorção da AGEL pela estrutura de TIC é respaldada pelo modelo adotado na Justiça Eleitoral em todo o Brasil [48, 50]:

#### Análise dos Regimentos Internos dos 27 TREs e TSE:
A pesquisa sobre a estrutura organizacional das Secretarias de TIC e Gestão Eleitoral nos Tribunais Regionais Eleitorais (TSE, TRE-AC, TRE-AP, TRE-AM, TRE-PA, TRE-RO, TRE-RR, TRE-TO, TRE-AL, TRE-BA, TRE-CE, TRE-MA, TRE-PB, TRE-PE, TRE-PI, TRE-RN, TRE-SE, TRE-DF, TRE-GO, TRE-MT, TRE-MS, TRE-ES, TRE-MG, TRE-RJ, TRE-SP, TRE-PR, TRE-RS, TRE-SC) revela [48, 50]:

- **25 Tribunais (92,6%)**: Integram a logística de urnas, suporte aos sistemas eleitorais e planejamento operacional da eleição **diretamente dentro da Secretaria de Tecnologia da Informação** (por meio de Coordenadorias ou Divisões de Eleições/Logística Eleitoral pertencentes à STI).
- **Apenas 2 Tribunais (7,4%)**: Mantinham estrutura de Assessoria Eleitoral isolada da STI, sendo o TRE-AC um desses casos atípicos até a presente revisão.

**Conclusão do Benchmark**: A integração da gestão eleitoral dentro da STIC alinha o TRE-AC às melhores práticas do Tribunal Superior Eleitoral e da quase totalidade dos Regionais, promovendo eficiência operacional, economia de recursos e maior segurança jurídica e técnica [48, 50].

---

### 5. QUADRO COMPARATIVO "DE-PARA" (RES. 1.808/2025 x NOVA PROPOSTA REVISADA STIC)

| Estrutura Atual (Resolução TRE-AC nº 1.808/2025) [167, 168, 169] | Nova Estrutura Proposta Revisada (STIC) [47] | Justificativa da Alteração / Melhoria Alcançada [48] |
| :--- | :--- | :--- |
| **Secretaria de Tecnologia da Informação (STI)** [168] | **1. Secretaria de Tecnologia da Informação e Comunicação (STIC)** [47] | Adequação da nomenclatura nacional, alinhando TIC e Comunicação Tecnológica [47]. |
| **Assessoria de Gestão Eleitoral (AGEL)** *(vinculada à DG - Art. 40)* [167, 213] | **1.4 Coordenadoria de Gestão e Logística de Eleição** *(subordinada à STIC)* [47] | Absorção total da AGEL pela STIC, unificando planejamento e execução operacional do pleito em 2 seções finalísticas [48]. |
| **Assistência de Planejamento e Governança de TIC (ASPGOVTI)** [168, 233] | **1.02 Núcleo de Planejamento de TIC**<br>• *1.021 Assistência de Governança de TIC*<br>• *1.022 Assistência de Planejamento e de Contratação* [47] | Estruturação em Núcleo com Assistências especializadas para Governança e Planejamento de Contratações (ETP/TR) [48]. |
| *(Inexistente / atribuição difusa)* [48] | **1.03 Assessoria de Inteligência de Dados** [47] | Criação de Assessoria para BI, analytics, governança de dados e atendimento às metas do CNJ (DataJud) [7, 48]. |
| **Seção de Cibersegurança (SCSEG)** *(na Infraestrutura)* [168, 244] | **1.21 Seção de Segurança e Inovação Tecnológica** [47] | Agrupamento da segurança cibernética com inovação tecnológica e prototipagem [48, 186]. |
| **Seção de Redes (SEREDE)** + *(Hardware pulverizado)* [168, 239] | **1.22 Seção de Infraestrutura e Serviços** [47] | **Unificação estratégica**: Fusão das atribuições de Data Center, redes, nuvem, backups com a engenharia e manutenção do parque de hardware [27, 28, 48]. |
| **Seção de Suporte aos Usuários (SSU)** [168, 243] | **1.23 Seção de Suporte aos Usuários** [47] | Manutenção da Central de Serviços (Helpdesk N1/N2) e gestão de satisfação do usuário [23, 243]. |
| **Seção de Desenvolvimento e Banco de Dados (SDBD)** [169, 248] | **1.31 Seção de Desenvolvimento de Sistemas**<br>• **1.33 Seção de Sustentação e Banco de Dados** [47] | Especialização do desenvolvimento ágil e integração da sustentação de ambientes de produção ao banco de dados [47, 248]. |
| **Seção de Sistemas Eleitorais e Corporativos (SSEC)** [169, 246] | **1.32 Seção de Sustentação e Manutenção Sistêmica** [47] | Foco exclusivo na manutenção evolutiva, corretiva e interoperabilidade de sistemas corporativos [47, 48]. |
| **Seção de Urnas Eletrônicas (SEUE)** [168] | **1.41 Seção de Logística, Manutenção e Simulados de Urnas**<br>• **1.42 Seção de Sistemas e Tecnologia Eleitoral** [47] | **Agrupamento enxuto por afinidade**: Reorganização em apenas 2 seções especializadas cobrindo o eixo físico/logístico e o eixo sistêmico do pleito [47, 48]. |

---

### 6. MELHORIAS E GANHOS DE EFICIÊNCIA ALCANÇADOS

A implementação da nova proposta trará os seguintes benefícios diretos para o TRE-AC [48]:

1. **Racionalização da Estrutura**: Redução e unificação de unidades de infraestrutura e gestão eleitoral, simplificando a comunicação e a gestão de pessoal [48].
2. **Eficiência Operacional no Pleito**: Integração total do ciclo eleitoral em duas seções altamente sinérgicas (Física/Logística x Sistêmica/Tecnológica) [48, 213].
3. **Gestão Única de Infraestrutura**: Centralização dos serviços de Data Center, rede, nuvem e parque de hardware na Seção de Infraestrutura e Serviços (1.22) [27, 28, 48].
4. **Conformidade Total com a Resolução CNJ nº 370/2021**: Cobertura integral dos 4 macroprocessos obrigatórios estabelecidos no Art. 21 da ENTIC-JUD [21, 26, 27, 28].
5. **Decisão Baseada em Dados**: A Assessoria de Inteligência de Dados (1.03) fornecerá dashboards e estatísticas para subsidiar decisões estratégicas da Corte e do TSE em tempo real [7, 283].
