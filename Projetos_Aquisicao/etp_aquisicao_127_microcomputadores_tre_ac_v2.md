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

### ANEXO III - ESTUDO TÉCNICO PRELIMINAR (ETP) Nº 0923968 / 2026 - PRESI/DG/CPC

\
**Processo SEI nº:** 0002394-92.2026.6.01.8000  
**Órgão:** Tribunal Regional Eleitoral do Acre (TRE-AC)  
**Unidade Solicitante:** Secretaria de Tecnologia da Informação (STI)  
**Assunto:** Aquisição de solução tecnológica com computadores de mesa da linha corporativa de alta performance acompanhados de monitores com webcam e ergonomia avançada, novos, de primeira utilização e integrantes da linha regular de produção do fabricante, com garantia técnica *on-site* de 60 (sessenta) meses em regime 24x7 e suporte oficial do fabricante com fornecimento de peças originais de reposição (120 Desktops Dell Pro Slim e 07 Workstations Dell Pro Max).  

---

### 1. Descrição da Necessidade da Contratação

A Presidência e a Diretoria-Geral do Tribunal Regional Eleitoral do Acre (TRE-AC) estabeleceram como diretriz prioritária a reestruturação e a elevação da capacidade operacional do parque computacional fixo de mesa. O diagnóstico institucional e as avaliações técnicas desenvolvidas pela Secretaria de Tecnologia da Informação (STI) e pela Coordenadoria de Logística e Soluções Corporativas (CSCOR) revelaram que os microcomputadores desktop em uso no Tribunal acumulam anos de uso continuado, apresentando expressivo desgaste físico, obsolescência de processadores e memória, e incompatibilidade com as novas exigências de segurança da informação, virtualização e desempenho impostas pelo Conselho Nacional de Justiça (CNJ) e pelo Tribunal Superior Eleitoral (TSE).

A renovação do parque fixo por meio de computadores de mesa corporativos de alto desempenho destina-se a solucionar gargalos históricos em postos de trabalho e ambientes técnicos estratégicos, assegurando estabilidade operacional, rapidez na instrução de processos judiciais e administrativos, e segurança ininterrupta durante a preparação do ciclo eleitoral de 2026 e as rotinas ordinárias do órgão.

O lote de 127 equipamentos (composto por 120 computadores corporativos tipo Slim com monitor/webcam e 07 workstations avançadas com placa de vídeo dedicada) foi dimensionado para suprir diretamente as seguintes necessidades corporativas e operacionais críticas:

1. **Auditoria de Urnas Eletrônicas e Testes de Votação Paralela:** A Seção de Auditórios e Apoio Logístico necessita de estações computacionais com alta capacidade de barramento e processamento para executar softwares de verificação de integridade, validação de assinaturas digitais, carga de dados e testes de estresse em lotes de urnas eletrônicas sem travamentos.
2. **Geração de Mídias de Urnas e Inseminação:** Durante a preparação do pleito, as salas de geração de mídias operam sob rigoroso cronograma e elevado volume de gravação de cartões de memória. O emprego de equipamentos munidos de portas USB 3.2/Type-C de alta velocidade e processadores de múltiplos núcleos garante a execução rápida e isenta de erros de leitura ou gravação.
3. **Laboratório de Inovação (NULAB) e Salas de Treinamento:** O provimento de equipamentos atualizados nas salas de treinamento permite a capacitação simultânea de centenas de mesários, servidores e magistrados nos sistemas oficiais da Justiça Eleitoral (SJE, PJe, Diploma, Apolo, Sistemas de Transmissão e Biometria). No NULAB, viabiliza o desenvolvimento de soluções em linguagem simples e a prototipagem de ferramentas digitais.
4. **Coordenadoria de Soluções Corporativas (CSCOR), Seção de Desenvolvimento e Banco de Dados (SDBD) e Infraestrutura de TI:** As equipes técnicas operam ecossistemas computacionais complexos baseados em contêineres Docker, ambientes virtualizados Linux via WSL2, administração de instâncias do banco de dados Oracle, compilação de código-fonte no GitLab e sustentação de painéis de *Business Intelligence* (BI). A disponibilização dos computadores Dell Pro Slim (16GB RAM / Core Ultra 5) e Workstations Dell Pro Max (32GB RAM / RTX A1000) assegura a estabilidade exigida para esses fluxos sem perda de produtividade.
5. **Assessoria de Engenharia, Arquitetura e Gestão Imobiliária (ASGIM) e Coordenadoria de Infraestrutura (CIE):** A equipe técnica de engenharia e arquitetura do Tribunal é responsável pela elaboração de projetos executivos, reformas de fóruns eleitorais e vistorias de acessibilidade predial (Programa *Cartório Acessível*). A adoção da tecnologia BIM (*Building Information Modelling*) em softwares pesados como AutoCAD 2025, Revit, QiBuilder, V-Ray 3D e orçamentação SINAPI exige a alta capacidade de processamento gráfico das 07 Workstations Dell Pro Max munidas de placa dedicada NVIDIA RTX A1000 de 8GB e monitores de 27".
6. **Cartórios Eleitorais (1ª à 9ª Zonas) e Postos de Atendimento ao Eleitor (PAEs):** Apoio fixo às seções de atendimento, guichês da Central de Atendimento ao Eleitor (CAE/OCA) e instrução de processos no PJe em 1º Grau, funcionando como ancoragem técnica para equipamentos periféricos e mini firewalls das ações itinerantes do *Programa Rolê da Cidadania*.

---

### 2. Demonstração do Alinhamento com o Planejamento Estratégico

A presente aquisição alinha-se estritamente aos instrumentos institucionais de governança e planejamento estratégico do Poder Judiciário Federal e do TRE-AC:

#### 2.1. Objetivos do Plano Estratégico Institucional (PEI 2021-2026)

- **Macrodesafio 13 / 9 — Desenvolvimento Ético de Soluções de Inovação Tecnológica e Segurança Cibernética:** Modernização da infraestrutura digital e fortalecimento dos ativos computacionais corporativos.
- **Macrodesafio 12 / 8 — Aperfeiçoamento da Gestão Orçamentária e Financeira:** Otimização da alocação de recursos públicos e execução eficiente da Lei Orçamentária Anual.
- **Macrodesafio 3 — Agilidade e Produtividade na Prestação Jurisdicional:** Celeridade no processamento do PJe e no atendimento ao cidadão eleitor.

#### 2.2. Contribuição Direta para Indicadores e Metas Institucionais (Dashboard Phronesis)

- **iGovTIC-TRE-AC (IE30):** Manutenção do Nível de Excelência (≥90\%) no Índice de Governança de TIC perante o CNJ (Resolução CNJ nº 370/2021).
- **Cumprimento do PDTIC (IE31):** Alcance da Ação D16 do Plano Diretor de TIC referente à substituição de equipamentos com mais de 5 anos de uso (≥70\%).
- **Índice de Satisfação dos Usuários de TIC (IE34):** Elevação da satisfação dos magistrados e servidores para patamar superior a $94\%.
- **Disponibilidade de Serviços Críticos (IDSC):** Garantia de disponibilidade computacional da rede e dos sistemas corporativos ≥99,8\%.
- **Mitigação do Índice de Perda Orçamentária (IE26 / IPO):** Aproveitamento eficiente dos recursos aprovados no orçamento, reduzindo o índice de perdas para patamar inferior a $3\% ao ano e assegurando o cumprimento da meta de $99\% de execução orçamentária da LOA 2026.
- **Prazo Médio de Contratação (IE25 / PMCC):** Otimização do prazo de instrução e celebração contratual mediante aproveitamento de Ata de Registro de Preços.

---

### 3. Requisitos da Contratação

A solução a ser contratada deve observar os seguintes requisitos técnicos, legais, operacionais e ambientais:

#### 3.1. Requisitos Técnicos dos Equipamentos

- **Item 1 — 120 Computadores Corporativos tipo Desktop de Alto Desempenho com Monitor de 23,8" e Webcam (Dell Pro Slim QCS1250):**
  - **Processador:** Intel Core Ultra 5-14500 (arquitetura de 64 bits de última geração, múltiplos núcleos de performance e eficiência, NPU integrada dedicada a tarefas de Inteligência Artificial);
  - **Memória RAM:** 16 GB DDR5 (expansível);
  - **Armazenamento:** SSD NVMe M.2 de 256 GB de altíssima velocidade;
  - **Conectividade:** Placa de rede Gigabit Ethernet (RJ-45) + placa sem fio integrada Wi-Fi 6E e Bluetooth 5.3;
  - **Chassi e Segurança:** Gabinete compacto corporativo (Slim) com fonte de eficiência 80 Plus, chip de segurança TPM 2.0 e licença do sistema operacional Microsoft Windows 11 Pro 64-bit ativada em fábrica (CATMAT 471895 / 485442);
  - **Monitor Integrado:** Monitor corporativo Dell de 23,8 polegadas, resolução Full HD (1920x1080), painel IPS antirreflexo, ajustes ergonômicos e webcam HD/FHD integrada com microfone e obturador físico de privacidade (CATMAT 480492).
- **Item 2 — 07 Computadores Workstation de Altíssima Performance com Monitor Ergonômico de 27" (Dell Pro Max T2 FCT2250):**
  - **Processador:** Intel Core Ultra 7 de altíssimo rendimento com arquitetura de múltiplos núcleos;
  - **Memória RAM:** 32 GB DDR5 com suporte a correção de erros (ECC);
  - **Armazenamento:** SSD NVMe M.2 de 512 GB de alta velocidade;
  - **Placa de Vídeo Dedicada:** NVIDIA RTX A1000 com 8 GB de memória GDDR6 dedicada;
  - **Conectividade:** Wi-Fi 7 + Bluetooth e chassi profissional do tipo minitorre/torre com certificação ISV para aplicações de engenharia e banco de dados;
  - **Segurança e SO:** TPM 2.0 e Windows 11 Pro 64-bit (CATMAT 617911 / 620952);
  - **Monitor Integrado:** Monitor ergonômico Dell de 27 polegadas, painel IPS, resolução QHD/Full HD, suporte com regulação de altura, rotação (*pivot* 90°) e inclinação (CATMAT 478330).

#### 3.2. Requisitos de Garantia e Suporte Técnico

- **Prazo de Garantia:** Garantia técnica *on-site* prestada diretamente pelo fabricante pelo período mínimo de **60 (sessenta) meses (5 anos)**, contados do recebimento definitivo dos equipamentos;
- **Nível de Serviço (SLA):** Regime de atendimento 24x7 com abertura de chamados via central 0800 e portal web, tempo máximo de atendimento no local (*on-site*) de até 24 horas úteis e fornecimento de peças originais de reposição sem custos adicionais ao Tribunal.

#### 3.3. Requisitos de Sustentabilidade e Logística Reversa

- Conformidade com o Plano de Logística Sustentável (PLS/TRE-AC) e com as Resoluções CNJ nº 347/2020 e nº 400/2021;
- Equipamentos detentores de certificações ambientais reconhecidas (*Energy Star*, *EPEAT* e conformidade com a diretiva *RoHS* de restrição a substâncias perigosas);
- Obrigação do fornecedor/fabricante em prover logística reversa e destinação ecologicamente adequada para componentes substituídos ou desativados.

---

### 4. Estimativa das Quantidades a Serem Contratadas

O quantitativo de 127 equipamentos (120 desktops corporativos e 07 workstations) foi apurado com base em mapeamento pormenorizado efetuado pela CSCOR e STI nas unidades administrativas, judiciais e técnicas do Tribunal:

#### Memória de Cálculo da Distribuição dos Equipamentos

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

### 5. Levantamento de Mercado e Análise das Alternativas Possíveis

Em estrito cumprimento ao **art. 18, § 1º, inciso V, da Lei nº 14.133/2021** e ao **art. 9º, inciso III, da Instrução Normativa SEGES/ME nº 58/2022**, a Equipe de Planejamento da Contratação (EPC) procedeu à prospecção de mercado para identificar e avaliar as diferentes soluções tecnológicas, operacionais e logísticas disponíveis no ambiente público e privado aptas a resolver o problema administrativo identificado.

#### 5.1. Prospecção das Alternativas Mercadológicas e Operacionais

##### Alternativa 1 — Realização de Licitatório Próprio (Pregão Eletrônico Convencional)

- **Descrição:** Instauração de certame licitatório inédito conduzido integralmente pelo TRE-AC para aquisição direta dos 127 equipamentos.
- **Desvantagens e Inviabilidade Técnica/Temporal:**
  - *Exiguidade Temporal Crítica:* A deflagração de uma licitação própria no segundo semestre do exercício financeiro de 2026 demandaria de 90 a 120 dias para o cumprimento das fases preparatória, editalícia, publicação, julgamento de propostas, prazos recursais, adjudicação e homologação. Esse rito extrapolaria o encerramento do ano civil, acarretando a perda irremediável dos recursos orçamentários disponíveis na LOA 2026 e inviabilizando a entrega dos computadores para a preparação do ciclo eleitoral.
  - *Elevado Custo Operacional e Financeiro:* A condução de um processo licitatório próprio mobiliza tempo excessivo e mão de obra dos escassos servidores alocados na Secretaria de TI, na Seção de Licitações e na Assessoria Jurídica. O custo administrativo da elaboração de editais complexos, análises de propostas e julgamento de recursos representa um dispêndio desproporcional para o erário, divergindo do princípio da eficiência (art. 37, *caput*, da CF/1988).
  - *Riscos do Cenário Comercial Crítico:* O mercado internacional de tecnologia enfrenta disputas por insumos raros e escassez global de semicondutores. Um certame isolado submeteria o órgão a riscos de licitação deserta, fracassada ou com preços cotados acima da margem orçamentária devido à flutuação cambial.

##### Alternativa 2 — Locação de Equipamentos de Informática (*Outsourcing* de Desktops/Workstations)

- **Descrição:** Contratação de serviço contínuo de locação de microcomputadores e workstations com manutenção inclusa por período determinado.
- **Desvantagens e Inviabilidade Orçamentária/Patrimonial:**
  - *Inexistência de Previsão Orçamentária:* A locação caracteriza-se como despesa corrente/continuada de custeio (Elemento de Despesa 33.90.39/33.90.40). O TRE-AC não possui disponibilidade orçamentária nessa categoria no exercício de 2026, tampouco na proposta para o exercício financeiro subsequente (2027), inviabilizando juridicamente o compromisso.
  - *Desvantagem Patrimonial:* O pagamento recorrente de aluguéis ao longo de vários anos consome recursos públicos expressivos sem agregar ativos permanentes ao patrimônio da União, ao passo que a aquisição com garantia *on-site* de 60 meses estende a vida útil dos equipamentos por período superior a 7 anos sem custos adicionais.
  - *Restrições de Segurança e Customização:* Equipamentos locados impõem severas restrições para a instalação de imagens corporativas customizadas, softwares de auditoria de urnas e chaves criptográficas de segurança da Justiça Eleitoral.

##### Alternativa 3 — Adesão por Carona a Ata de Registro de Preços Vigente de Outro Órgão Federal (Solução Selecionada)

- **Descrição:** Processamento da aquisição mediante adesão, na condição de órgão não participante, a registro de preços válido e homologado no âmbito da Administração Pública Federal (art. 86 da Lei nº 14.133/2021).
- **Vantagens Determinantes:**
  - *Celeridade e Eficiência:* Elimina a fase externa de licitação, permitindo a formalização do empenho e a entrega dos bens dentro da janela do exercício financeiro de 2026.
  - *Vantajosidade Econômica e Escala:* Aproveita preços homologados em certames de grande porte promovidos por universidades federais (UFAM), garantindo custos unitários inferiores aos obtidos em licitações isoladas.
  - *Otimização da Mão de Obra:* Economiza centenas de horas de trabalho da pequena equipe de TI e licitações do TRE-AC, direcionando a força de trabalho para a implantação das estações e suporte direto ao processo eleitoral.

---

#### 5.2. Análise Detalhada das Atas de Registro de Preços Pesquisadas no Mercado

A Equipe de Planejamento efetuou levantamento exaustivo no Portal Nacional de Contratações Públicas (PNCP) e em bancos de dados de atas de registro de preços vigentes:

1. **Ata de Registro de Preços nº 12/2026 da Universidade Federal do Amazonas — UFAM (Edital de Pregão Eletrônico nº 107/2025 - Evento SEI 0919546):**
   - **Opção Eleita como a Mais Vantajosa e Compatível:** A ARP nº 12/2026 da UFAM contempla exatamente as especificações técnicas da linha corporativa Dell desejadas pelo Tribunal, oferecendo garantia *on-site 24x7* de 60 meses e plena concordância da fabricante/fornecedora em atender ao pedido.
   - **Item 1 da Ata (Workstation):** Computador tipo 1 (Workstation Dell Pro Max T2 FCT2250 / Core Ultra 7, 32GB DDR5 ECC, SSD 512GB, RTX A1000 8GB + Monitor 27"), CATMAT 620952 / 617911, quantidade registrada de 600 unidades (saldo de carona plenamente suficiente para as 07 unidades demandadas), Valor Unitário de **R$ 31.875,00**.
   - **Item 2 da Ata (Desktop):** Computador tipo 2 (Desktop Dell Pro Slim QCS1250 / Core Ultra i5-14500, 16GB DDR5, SSD 256GB + Monitor 23,8" com Webcam), CATMAT 485442 / 471895, quantidade registrada de 15 unidades + saldo regulamentar de carona (600 unidades no lote gerenciado) plenamente suficiente para as 120 unidades demandadas, Valor Unitário de **R$ 15.569,00**.
   - *Valor Global da Solução:* **R$ 2.091.405,00**.

2. **Termo de Referência do Processo PA nº 23520.007292/2025-02 da Universidade Federal do Oeste da Bahia — UFOB (Evento SEI 0923871):**
   - Os Itens 1, 2 e 3 do TR da UFOB apresentam configurações de computadores compatíveis. Contudo, a análise da ata confirmou que **não há saldo de carona suficiente** para autorizar a adesão no quantitativo integral de 127 equipamentos requeridos pelo TRE-AC, inviabilizando o atendimento da demanda.

3. **Ata de Registro de Preços nº 26/2026 da Universidade Federal do Acre — UFAC (Evento SEI 0919133):**
   - Os Itens 4 e 8 da ARP nº 26/2026 da UFAC foram analisados. No entanto, comparativamente, apresentam **valores unitários superiores aos homologados na ata da UFAM** e **não detêm margem de saldo aderente suficiente** para autorizar a carona, sendo descartados por desvantajosidade econômica e técnica.

---

### 6. Estimativa do Valor da Contratação e Vantajosidade Econômica

A estimativa do valor global da contratação fundamenta-se estritamente nos preços registrados na **Ata de Registro de Preços nº 12/2026 da UFAM (PE nº 107/2025)**:

#### Tabela de Consolidação Orçamentária

| Item DFD | Modelo / Referência da Ata UFAM | Descrição Resumida da Configuração | CATMAT | Qtd | Valor Unitário (R$) | Valor Total Estimado (R$) |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **1** | **Dell Pro Slim QCS1250** (Item 2 - ARP 12/2026 UFAM) | Core Ultra i5-14500, 16GB DDR5, SSD 256GB NVMe, Wi-Fi 6E + Monitor Dell 23,8" com Webcam integrada, Win 11 Pro, Garantia 60m *on-site 24x7* | 471895 / 485442 | 120 | R$ 15.569,00 | R$ 1.868.280,00 |
| **2** | **Dell Pro Max T2 FCT2250** (Item 1 - ARP 12/2026 UFAM) | Core Ultra 7, 32GB DDR5, SSD 512GB NVMe, Placa Dedicada NVIDIA RTX A1000 8GB, Wi-Fi 7 + Monitor Dell 27" Ergonômico, Win 11 Pro, Garantia 60m *on-site 24x7* | 617911 / 620952 | 07 | R$ 31.875,00 | R$ 223.125,00 |
| **TOTAL** | **Solução de Computação de Mesa Corporativa** | **Equipamentos Fixo-Corporativos de Alto Desempenho com Monitores** | — | **127** | — | **R$ 2.091.405,00** |

*Montante Global Estimado:* **R$ 2.091.405,00 (dois milhões, noventa e um mil, quatrocentos e cinco reais)**.

---

### 7. Descrição da Solução como um Todo

A solução abrange não apenas o fornecimento físico dos 127 microcomputadores e workstations acompanhados de seus respectivos monitores, mas engloba um pacote integrado de suporte e serviços essenciais:

1. Entrega física dos equipamentos no Almoxarifado Central do TRE-AC devidamente embalados e identificados;
2. Instalação e ativação das licenças de fábrica do sistema operacional Microsoft Windows 11 Pro 64-bit e suporte ao chip de segurança TPM 2.0;
3. Integração com a imagem corporativa do Tribunal (PJe, SEI, VPN, Antivírus corporativo e ferramentas do TSE);
4. Garantia integral do fabricante pelo prazo de 60 meses *on-site* 24x7 com reposição de peças originais.

---

### 8. Justificativa para o Parcelamento ou Não da Solução

Optou-se pelo **não parcelamento do objeto** (fornecimento em lote único subdividido nos itens padronizados do fabricante), haja vista que a solução compreende equipamentos padronizados da mesma linha corporativa e do mesmo fabricante (Dell). A adjudicação unificada assegura a padronização de drives, imagens de sistema, facilidade de manutenção pela equipe de suporte da STI e maior ganho de escala na negociação do valor global.

---

### 9. Demonstração dos Resultados Pretendidos em Termos de Eficiência e Economia

A concretização da contratação proporcionará os seguintes resultados diretos para o TRE-AC:

- **Ganho de Eficiência:** Eliminação de paralisações por falhas de hardware, aceleração na instrução de processos no PJe/SEI e suporte de alta performance para os projetos BIM/engenharia da ASGIM e rotinas do NULAB;
- **Redução do Custo Operacional de TI:** Mitigação de despesas recorrentes com manutenção corretiva em equipamentos obsoletos fora de garantia;
- **Execução Orçamentária Plena:** Aplicação eficiente dos recursos aprovados para o exercício de 2026, atingindo a meta de $99\% de execução orçamentária e reduzindo o Índice de Perda Orçamentária (IE26) para patamar inferior a $3\%.

---

### 10. Providências a Serem Adotadas Previamente à Celebração do Contrato

1. **Revisão Extemporânea do PCA 2026:** Inclusão formal da demanda no Plano de Contratações Anual de 2026 (Processo SEI nº 0000803-32.2025.6.01.8000), amparada no art. 6º da Resolução TSE nº 23.702/2022 e na IN TRE-AC nº 71/2024;
2. **Adequação Orçamentária:** Efetivação do remanejamento orçamentário da Ação 20GP-Custeio para a Ação 20GP-Investimento (ND 44.90.52.41 / PI INV EQUTIC) na janela de Créditos Adicionais de 2026, com emissão da Certidão de Reserva Orçamentária pela SAOF/SPEO (Informação nº 0896127);
3. **Formalização do Aceite:** Obtenção de concordância formal do órgão gerenciador (UFAM) e do fornecedor registrado quanto aos quantitativos e ao prazo editalício de entrega de 60 dias corridos.

---

### 11. Posicionamento Conclusivo sobre a Viabilidade e Razoabilidade da Contratação

Com base no levantamento técnico, na fundamentação jurídica e na demonstração de vantajosidade econômica, a Equipe de Planejamento da Contratação (EPC) posiciona-se **FAVORAVELMENTE À VIABILIDADE E RAZOABILIDADE DA CONTRATAÇÃO**, recomendando o prosseguimento da instrução para formalização da adesão à **Ata de Registro de Preços nº 12/2026 da UFAM** no montante global de **R$ 2.091.405,00**.

\
Rio Branco - AC, 17 de outubro de 2026.

\
**EQUIPE DE PLANEJAMENTO DA CONTRATAÇÃO (EPC)**  
*Resolução CNJ nº 468/2022 / IN TRE-AC nº 72/2024*  
\
**Cleilton Nazaré Costa**  
Secretário de Tecnologia da Informação — Integrante Demandante  
**Ilis Sandro Antonio Areno Ambrosio**  
Coordenador — Integrante Técnico  
**Lucir Rocio Vaz**  
Chefe de Seção — Integrante Técnico  
**Altamiro Lima da Silva**  
Integrante Administrativo  
