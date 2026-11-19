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
##border: 1px solid #000;
padding: 5px;
vertical-align: top;
}

li {
text-align: justify;
line-height: 1.5;
}
</style>

### ANEXO III - ESTUDO TÉCNICO PRELIMINAR (ETP) Nº 0923968 / 2026 - PRESI/DG/CPC

\
**Processo SEI nº:** 0002394-92.2026.6.01.8000  
**Órgão:** Tribunal Regional Eleitoral do Acre (TRE-AC)  
**Unidade Solicitante:** Secretaria de Tecnologia da Informação (STI)  
**Assunto:** Aquisição de solução tecnológica com computadores de mesa da linha corporativa de alta performance acompanhados de monitores com webcam e ergonomia avançada, novos, de primeira utilização e integrantes da linha regular de produção do fabricante, com garantia técnica *on-site* de 60 (sessenta) meses em regime 24x7 e suporte oficial do fabricante com fornecimento de peças originais de reposição (120 Desktops Dell Pro Slim e 07 Workstations Dell Pro Max).  

---

#### 1. Descrição da Necessidade da Contratação

A Presidência e a Diretoria-Geral do Tribunal Regional Eleitoral do Acre (TRE-AC) estabeleceram como diretriz prioritária a reestruturação e a elevação da capacidade operacional do parque computacional fixo de mesa. O diagnóstico institucional e as avaliações técnicas desenvolvidas pela Secretaria de Tecnologia da Informação (STI) e pela Coordenadoria de Logística e Soluções Corporativas (CSCOR) revelaram que os microcomputadores desktop em uso no Tribunal acumulam anos de uso continuado, apresentando expressivo desgaste físico, obsolescência de processadores e memória, e incompatibilidade com as novas exigiências de segurança da informação, virtualização e desempenho impostas pelo Conselho Nacional de Justiça (CNJ) e pelo Tribunal Superior Eleitoral (TSE).

A renovação do parque fixo por meio de computadores de mesa corporativos de alto desempenho destina-se a solucionar gargalos históricos em postos de trabalho e ambientes técnicos estratégicos, assegurando estabilidade operacional, rapidez na instrução de processos judiciais e administrativos, e segurança ininterrupta durante a preparação do ciclo eleitoral de 2026 e as rotinas ordinárias do órgão.

O lote de 127 equipamentos (composto por 120 computadores corporativos tipo Slim com monitor/webcam e 07 workstations avançadas com placa de vídeo dedicada) foi dimensionado para suprir diretamente as seguintes necessidades corporativas e operacionais críticas:

1. **Auditoria de Urnas Eletrônicas e Testes de Votação Paralela:** A Seção de Auditórios e Apoio Logístico necessita de estações computacionais com alta capacidade de barramento e processamento para executar softwares de verificação de integridade, validação de assinaturas digitais, carga de dados e testes de estresse em lotes de urnas eletrônicas sem travamentos.
2. **Geração de Mídias de Urnas e Inseminação:** Durante a preparação do pleito, as salas de geração de mídias operam sob rigoroso cronograma e elevado volume de gravação de cartões de memória. O emprego de equipamentos munidos de portas USB 3.2/Type-C de alta velocidade e processadores de múltiplos núcleos garante a execução rápida e isenta de erros de leitura ou gravação.
3. **Laboratório de Inovação (NULAB) e Salas de Treinamento:** O provimento de equipamentos atualizados nas salas de treinamento permite a capacitação simultânea de centenas de mesários, servidores e magistrados nos sistemas oficiais da Justiça Eleitoral (SJE, PJe, Diploma, Apolo, Sistemas de Transmissão e Biometria). No NULAB, viabiliza o desenvolvimento de soluções em linguagem simples e a prototipagem de ferramentas digitais.
4. **Coordenadoria de Soluções Corporativas (CSCOR), Seção de Desenvolvimento e Banco de Dados (SDBD) e Infraestrutura de TI:** As equipes técnicas operam ecossistemas computacionais complexos baseados em contêineres Docker, ambientes virtualizados Linux via WSL2, administração de instâncias do banco de dados Oracle, compilação de código-fonte no GitLab e sustentação de painéis de *Business Intelligence* (BI). A disponibilização dos computadores Dell Pro Slim (16GB RAM / Core Ultra 5) e Workstations Dell Pro Max (32GB RAM / RTX A1000) assegura a estabilidade exigida para esses fluxos sem perda de produtividade.
5. **Assessoria de Engenharia, Arquitetura e Gestão Imobiliária (ASGIM) e Coordenadoria de Infraestrutura (CIE):** A equipe técnica de engenharia e arquitetura do Tribunal é responsável pela elaboração de projetos executivos, reformas de fóruns eleitorais e vistorias de acessibilidade predial (Programa *Cartório Acessível*). A adoção da tecnologia BIM (*Building Information Modelling*) em softwares pesados como AutoCAD 2025, Revit, QiBuilder, V-Ray 3D e orçamentação SINAPI exige a alta capacidade de processamento gráfico das 07 Workstations Dell Pro Max munidas de placa dedicada NVIDIA RTX A1000 de 8GB e monitores de 27".
6. **Cartórios Eleitorais (1ª à 9ª Zonas) e Postos de Atendimento ao Eleitor (PAEs):** Apoio fixo às seções de atendimento, guichês da Central de Atendimento ao Eleitor (CAE/OCA) e instrução de processos no PJe em 1º Grau, funcionando como ancoragem técnica para equipamentos perféricos e mini firewalls das ações itinerantes do *Programa Rolê da Cidadania*.

---

#### 2. Demonstração do Alinhamento com o Planejamento Estratégico

A presente aquisição alinha-se estritamente aos instrumentos institucionais de governança e planejamento estratégico do Poder Judiciário Federal e do TRE-AC:

##### 2.1. Objetivos do Plano Estratégico Institucional (PEI 2021-2026)
- **Macrodesafio 13 / 9 — Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética:** Modernização da infraestrutura digital e fortalecimento dos ativos computacionais corporativos.
- **Macrodesafio 12 / 8 — Aperfeiçoamento da Gestão Orçamentária e Financeira:** Otimização da alocação de recursos públicos e execução eficiente da Lei Orçamentária Anual.
- **Macrodesafio 3 — Agilidade e Produtividade na Prestação Jurisdicional:** Celeridade no processamento do PJe e no atendimento ao cidadão eleitor.

##### 2.2. Contribuição Direta para Indicadores e Metas Institucionais (Dashboard Phronesis)
- **iGovTIC-TRE-AC (IE30):** Manutenção do Nível de Excelência (>= 90%) no Índice de Governança de TIC perante o CNJ (Resolução CNJ nº 370/2021).
- **Cumprimento do PDTIC (IE31):** Alcance da Ação D16 do Plano Diretor de TIC referente à substituição de equipamentos com mais de 5 anos de uso (>= 70\%).
- **Índice de Satisfação dos Usuários de TIC (IE34):** Elevação da satisfação dos magistrados e servidores para patamar superior a 94\%.
- **Disponibilidade de Serviços Críticos (IDSC):** Garantia de disponibilidade computacional da rede e dos sistemas corporativos >= 99,8\%.
- **Mitigação do Índice de Perda Orçamentária (IE26 / IPO):** Aproveitamento eficiente dos recursos aprovados no orçamento, reduzindo o índice de perdas para patamar inferior a 3\% ao ano e assegurando o cumprimento da meta de 99\% de execução orçamentária da LOA 2026.
- **Prazo Médio de Contratação (IE25 / PMCC):** Otimização do prazo de instrução e celebração contratual mediante aproveitamento de Ata de Registro de Preços.

---

#### 3. Requisitos da Contratação

A solução a ser contratada deve observar os seguintes requisitos técnicos, legais, operacionais e ambientais:

##### 3.1. Requisitos Técnicos dos Equipamentos
- **Item 1 — 120 Computadores Corporativos tipo Desktop de Alto Desempenho com Monitor de 23,8" e Webcam (Dell Pro Slim QCS1250):**
  - **Processador:** Intel Core Ultra 5-14500 (arquitetura de 64 bits de última geração, múltiplos núcleos de performance e eficiência, NPU integrada dedicada a tarefas de Inteligência Artificial);
  - **Memória RAM:** 16 GB DDR5 (expansível);
  - **Armazenamento:** SSD NVMe M.2 de 256 GB de altíssima velocidade;
  - **Conectividade:** Placa de rede Gigabit Ethernet (RJ-45) + placa sem fio integrada Wi-Fi 6E e Bluetooth 5.3;
  - **Chassi e Segurança:** Gabinete compacto corporativo (Slim) com fonte de eficiência 80 Plus, chip de segurança TPM 2.0 e licença do sistema operacional Microsoft Windows 11 Pro 64-bit ativada em fábrica (CATMAT 471895);
  - **Monitor Integrado:** Monitor corporativo Dell de 23,8 polegadas, resolução Full HD (1920x1080), painel IPS antirreflexo, ajustes ergonômicos e webcam HD/FHD integrada com microfone e obturador físico de privacidade (CATMAT 480492).
- **Item 2 — 07 Computadores Workstation de Altíssima Performance com Monitor Ergonômico de 27" (Dell Pro Max T2 FCT2250):**
  - **Processador:** Intel Core Ultra 7 de altíssimo rendimento com arquitetura de múltiplos núcleos;
  - **Memória RAM:** 32 GB DDR5 com suporte a correção de erros (ECC);
  - **Armazenamento:** SSD NVMe M.2 de 512 GB de alta velocidade;
  - **Placa de Vídeo Dedicada:** NVIDIA RTX A1000 com 8 GB de memória GDDR6 dedicada;
  - **Conectividade:** Wi-Fi 7 + Bluetooth e chassi profissional do tipo minitorre/torre com certificação ISV para aplicações de engenharia e banco de dados;
  - **Segurança e SO:** TPM 2.0 e Windows 11 Pro 64-bit (CATMAT 617911 / 620952);
  - **Monitor Integrado:** Monitor ergonômico Dell de 27 polegadas, painel IPS, resolução QHD/Full HD, suporte com regulação de altura, rotação (*pivot* 90°) e inclinação (CATMAT 478330).

##### 3.2. Requisitos de Garantia e Suporte Técnico
- **Prazo de Garantia:** Garantia técnica *on-site* prestada diretamente pelo fabricante pelo período mínimo de **60 (sessenta) meses (5 anos)**, contados do recebimento definitivo dos equipamentos;
- **Nível de Serviço (SLA):** Regime de atendimento 24x7 com abertura de chamados via central 0800 e portal web, tempo máximo de atendimento no local (*on-site*) de até 24 horas úteis e fornecimento de peças originais de reposição sem custos adicionais ao Tribunal.

##### 3.3. Requisitos de Sustentabilidade e Logística Reversa
- Conformidade com o Plano de Logística Sustentável (PLS/TRE-AC) e com as Resoluções CNJ nº 347/2020 e nº 400/2021;
- Equipamentos detentores de certificações ambientais reconhecidas (*Energy Star*, *EPEAT* e conformidade com a diretiva *RoHS* de restrição a substâncias perigosas);
- Obrigação do fornecedor/fabricante em prover logística reversa e destinação ecologicamente adequada para componentes substituídos ou desativados.

---

#### 4. Estimativa das Quantidades a Serem Contratadas

O quantitativo de 127 equipamentos (120 desktops corporativos e 07 workstations) foi apurado com base em mapeamento pormenorizado efetuado pela CSCOR e STI nas unidades administrativas, judiciais e técnicas do Tribunal:

##### Memória de Cálculo da Distribuição dos Equipamentos

| Unidade / Ambiente Destinatário | Item 1 — Desktop Dell Pro Slim (120 un.) | Item 2 — Workstation Dell Pro Max (07 un.) | Total por Unidade |
| :--- | :---: | :---: | :---: |
| **Salas de Treinamento de Servidores e Mesários** (Capital e Interior) | 30 | 0 | 30 |
| **Auditório e Ambiente de Geração de Mídias / Auditoria de Urnas** | 20 | 0 | 20 |
| **Laboratório de Inovação (NULAB) e Salas de Projetos** | 10 | 0 | 10 |
| **Seção de Logística de Urnas (SEUE) e Segurança Institucional (SSEG)** | 10 | 0 | 10 |
| **Cartórios Eleitorais (1ª a 9ª Zonas) e Postos de Atendimento (PAEs)** | 30 | 0 | 30 |
| **Secretarias Judiciária (SEJUD), SAOF, COGEP, ASCOM, ASPLAN e Unidades** | 20 | 0 | 20 |
| **Assessoria de Engenharia, Arquitetura e Gestão Imobiliária (ASGIM)** | 0 | 4 | 4 |
| **Coordenadoria de Infraestrutura de TI (CIE)** | 0 | 1 | 1 |
| **Coordenadoria de Soluções Corporativas e Banco de Dados (CSCOR/SDBD)** | 0 | 2 | 2 |
| **TOTAL GERAL** | **120** | **07** | **127** |

---

#### 5. Levantamento de Mercado e Análise das Alternativas Possíveis

A Equipe de Planejamento da Contratação (EPC) realizou ampla pesquisa de mercado em atas de registro de preços vigentes gerenciadas por órgãos federais e instituições de ensino superior, avaliando a compatibilidade técnica, os valores homologados e a disponibilidade de saldo aderente:

##### 5.1. Análise das ARPs Pesquisadas no Mercado

1. **Ata de Registro de Preços nº 12/2026 da Universidade Federal do Amazonas — UFAM (Edital de Pregão Eletrônico nº 107/2025 - Evento SEI 0919546):**
   - **Opção Eleita como Mais Vantajosa:** A ARP contempla exatamente os equipamentos Dell de linha corporativa desejados, com saldo disponível de 600 unidades para carona e plena concordância do fornecedor.
   - **Item 1 da Ata (Workstation):** Computador tipo 1 (Workstation Dell Pro Max T2 FCT2250 / Core Ultra 7, 32GB DDR5, SSD 512GB, RTX A1000 8GB + Monitor 27"), CATMAT 620952 / 617911, Valor Unitário de **R$ 31.875,00**.
   - **Item 2 da Ata (Desktop):** Computador tipo 2 (Desktop Dell Pro Slim QCS1250 / Core Ultra i5-14500, 16GB DDR5, SSD 256GB + Monitor 23,8" com Webcam), CATMAT 485442 / 471895, Valor Unitário de **R$ 15.569,00**.
2. **Termo de Referência do Processo PA nº 23520.007292/2025-02 da Universidade Federal do Oeste da Bahia — UFOB (Evento SEI 0923871):**
   - Os Itens 1, 2 e 3 do TR da UFOB apresentam configurações compatíveis, contudo, o saldo registrado de carona não possui quantitativo suficiente para suprir a demanda integral de 127 equipamentos do TRE-AC, tornando a opção inviável.
3. **Ata de Registro de Preços nº 26/2026 da Universidade Federal do Acre — UFAC (Evento SEI 0919133):**
   - Os Itens 4 e 8 da ARP nº 26/2026 da UFAC foram analisados, mas apresentam valor unitário superior ao registrado na ata da UFAM e não contam com margem de autorização suficiente para adesão no quantitativo requerido.

##### 5.2. Justificativa para a Escolha do Rito de Adesão (Carona)
A adesão por carona à **Ata de Registro de Preços nº 12/2026 da UFAM** afigura-se como a solução mais eficiente, célere e econômica pelas seguintes razões:
- **Exiguidade Temporal:** A deflagração de licitação própria no segundo semestre inviabilizaria o recebimento e a entrada em produção dos equipamentos dentro do exercício financeiro de 2026;
- **Mitigação de Riscos do Mercado Internacional:** O cenário global crítico de escassez de semicondutores e disputas por insumos de tecnologia elevaria substancialmente os custos de uma nova licitação;
- **Padronização e Vantajosidade:** Garantia de aquisição de equipamentos de primeira linha corporativa (Dell) com valores já homologados em certame federal competitivo.

---

#### 6. Estimativa do Valor da Contratação e Vantajosidade Econômica

A estimativa do valor global da contratação fundamenta-se estritamente nos preços registrados na **Ata de Registro de Preços nº 12/2026 da UFAM (PE nº 107/2025)**:

##### Tabela de Consolidação Orçamentária

| Item DFD | Modelo / Referência da Ata UFAM | Descrição Resumida da Configuração | CATMAT | Qtd | Valor Unitário (R$) | Valor Total Estimado (R$) |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **1** | **Dell Pro Slim QCS1250** (Item 2 - ARP 12/2026 UFAM) | Core Ultra i5-14500, 16GB DDR5, SSD 256GB NVMe, Wi-Fi 6E + Monitor Dell 23,8" com Webcam integrada, Win 11 Pro, Garantia 60m *on-site 24x7* | 471895 / 480492 | 120 | R$ 15.569,00 | R$ 1.868.280,00 |
| **2** | **Dell Pro Max T2 FCT2250** (Item 1 - ARP 12/2026 UFAM) | Core Ultra 7, 32GB DDR5, SSD 512GB NVMe, Placa Dedicada NVIDIA RTX A1000 8GB, Wi-Fi 7 + Monitor Dell 27" Ergonômico, Win 11 Pro, Garantia 60m *on-site 24x7* | 617911 / 620952 | 07 | R$ 31.875,00 | R$ 223.125,00 |
| **TOTAL** | **Solução de Computação de Mesa Corporativa** | **Equipamentos Fixo-Corporativos de Alto Desempenho com Monitores** | — | **127** | — | **R$ 2.091.405,00** |

*Montante Global Estimado:* **R$ 2.091.405,00 (dois milhões, noventa e um mil, quatrocentos e cinco reais)**.

---

#### 7. Descrição da Solução como um Todo

A solução abrange não apenas o fornecimento físico dos 127 microcomputadores e workstations acompanhados de seus respectivos monitores, mas engloba um pacote integrado de suporte e serviços essenciais:
1. Entrega física dos equipamentos no Almoxarifado Central do TRE-AC devidamente embalados e identificados;
2. Instalação e ativação das licenças de fábrica do sistema operacional Microsoft Windows 11 Pro 64-bit e suporte ao chip de segurança TPM 2.0;
3. Integração com a imagem corporativa do Tribunal (PJe, SEI, VPN, Antivírus corporativo e ferramentas do TSE);
4. Garantia integral do fabricante pelo prazo de 60 meses *on-site* 24x7 com reposição de peças originais.

---

#### 8. Justificativa para o Parcelamento ou Não da Solução

Optou-se pelo **não parcelamento do objeto** (fornecimento em lote único subdividido nos itens padronizados do fabricante), haja vista que a solução compreende equipamentos padronizados da mesma linha corporativa e do mesmo fabricante (Dell). A adjudicação unificada assegura a padronização de drives, imagens de sistema, facilidade de manutenção pela equipe de suporte da STI e maior ganho de escala na negociação do valor global.

---

#### 9. Demonstração dos Resultados Pretendidos em Termos de Eficiência e Economia

A concretização da contratação proporcionará os seguintes resultados diretos para o TRE-AC:
- **Ganho de Eficiência:** Eliminação de paralisações por falhas de hardware, aceleração na instrução de processos no PJe/SEI e suporte de alta performance para os projetos BIM/engenharia da ASGIM e rotinas do NULAB;
- **Redução do Custo Operacional de TI:** Mitigação de despesas recorrentes com manutenção corretiva em equipamentos obsoletos fora de garantia;
- **Execução Orçamentária Plena:** Aplicação eficiente dos recursos aprovados para o exercício de 2026, atingindo a meta de 99\% de execução orçamentária e reduzindo o Índice de Perda Orçamentária (IE26) para patamar inferior a 3\%.

---

#### 10. Providências a Serem Adotadas Previamente à Celebração do Contrato

1. **Revisão Extemporânea do PCA 2026:** Inclusão formal da demanda no Plano de Contratações Anual de 2026 (Processo SEI nº 0000803-32.2025.6.01.8000), amparada no art. 6º da Resolução TSE nº 23.702/2022 e na IN TRE-AC nº 71/2024;
2. **Adequação Orçamentária:** Efetivação do remanejamento orçamentário da Ação 20GP-Custeio para a Ação 20GP-Investimento (ND 44.90.52.41 / PI INV EQUTIC) na janela de Créditos Adicionais de 2026, com emissão da Certidão de Reserva Orçamentária pela SAOF/SPEO (Informação nº 0896127);
3. **Formalização do Aceite:** Obtenção de concordância formal do órgão gerenciador (UFAM) e do fornecedor registrado quanto aos quantitativos e ao prazo editalício de entrega de 60 dias corridos.

---

#### 11. Posicionamento Conclusivo sobre a Viabilidade e Razoabilidade da Contratação

Com base no levantamento técnico, na fundamentação jurídica e na demonstração de vantajosidade econômica, a Equipe de Planejamento da Contratação (EPC) posiciona-se **FAVORAVELMENTE À VIABILIDADE E RAZOABILIDADE DA CONTRATAÇÃO**, recomendando o prosseguimento da instrução para formalização da adesão à **Ata de Registro de Preços nº 12/2026 da UFAM** no montante global de **R$ 2.091.405,00**.

Rio Branco - AC, 17 de outubro de 2026.

**EQUIPE DE PLANEJAMENTO DA CONTRATAÇÃO (EPC)**  
*Resolução CNJ nº 468/2022 / IN TRE-AC nº 72/2024*  

\
**Cleilton Nazaré Costa**  
Secretário de Tecnologia da Informação — Integrante Demandante

\
**Ilis Sandro Antonio Areno Ambrosio**  
Coordenador — Integrante Técnico

\
**Lucir Rocio Vaz**  
Chefe de Seção — Integrante Técnico

\
**Altamiro Lima da Silva**  
Integrante Administrativo  
