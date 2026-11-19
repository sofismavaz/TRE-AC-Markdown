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

### ANEXO I - DOCUMENTO DE FORMALIZAÇÃO DE DEMANDA (DFD) Nº 0914656 / 2026 - PRESI/DG/STI/CSCOR/SDBD (VERSÃO REFORMULADA CONSOLIDADA)

\
**Processo SEI nº:** 0002395-77.2026.6.01.8000 — Aquisição de Notebooks Corporativos para Servidores, Magistrados e Unidades do TRE-AC  
**Processo Orçamentário Vinculado:** 0002313-46.2026.6.01.8000 (Ação 21EE — Gestão da Política de Segurança da Informação e Cibernética)  
**Órgão:** Tribunal Regional Eleitoral do Acre (TRE-AC)  
**Unidade Requisitante:** Secretaria de Tecnologia da Informação (STI/TRE-AC)  
**Gestor Responsável:** Cleilton de Nazaré Costa — Secretário de Tecnologia da Informação (E-mail: gsti@tre-ac.jus.br / Tel: 3212-6196)  
**Integrantes Técnicos de TIC:** Ilis Sandro Antonio Areno Ambrosio (Coordenador da CSCOR) e Lucir Rocio Vaz (Chefe da SDBD)  
**Integrante Administrativo:** A ser indicado pela Secretaria de Administração, Orçamento e Finanças (SAOF)  

---

### 1. Identificação das Unidades Demandantes

A presente demanda é formulada de maneira unificada e Institucional pela **Secretaria de Tecnologia da Informação (STI)**, em atendimento às diretrizes estratégicas e operacionais do Presidente Desembargador Lois Arruda e da Diretoria-Geral do Tribunal Regional Eleitoral do Acre (TRE-AC), abrangendo a totalidade dos órgãos diretivos, colegiados, secretarias, assessorias técnicas, juízos eleitorais e postos avançados do Estado do Acre, a saber:

1. **Órgãos do Tribunal, Colegiados e Alta Gestão:**
   - Presidência, Vice-Presidência e Corregedoria Regional Eleitoral (CRE);
   - Gabinetes dos Membros Titulares e Substitutos da Corte Eleitoral e Procuradoria Regional Eleitoral (PRE);
   - Juízes Auxiliares da Presidência e da Corregedoria;
   - Ouvidoria Regional Eleitoral e Escola Judiciária Eleitoral (EJE).

2. **Alta Gestão Administrativa, Secretarias e Assessorias Especializadas:**
   - Diretoria-Geral (DG / GADG);
   - Secretaria de Tecnologia da Informação (STI) e Coordenadorias (CSCOR e CIE);
   - Secretaria de Administração, Orçamento e Finanças (SAOF) e Coordenadorias (COMAP, COFIN e COSEG);
   - Secretaria Judiciária (SEJUD) e Coordenadorias (CRIP e COSES);
   - Coordenadoria de Gestão de Pessoas (COGEP);
   - Assessoria de Comunicação Social (ASCOM);
   - Assessoria de Planejamento, Estratégia e Gestão (ASPLAN);
   - Assessoria de Engenharia, Arquitetura e Gestão Imobiliária (ASGIM).

3. **Núcleos Operacionais Críticos, Laboratórios de Inovação e Ambientes Técnicos de TIC:**
   - Seção de Auditórios e Geração de Mídias de Urnas Eletrônicas;
   - Seção de Logística e Preparação de Urnas Eleitorais (SEUE);
   - Laboratório de Inovação da Justiça Eleitoral (NULAB);
   - Salas de Treinamento de Mesários, Servidores e Magistrados;
   - Seção de Segurança Institucional (SSEG) e Ambientes de Simulação Cibernética;
   - Seção de Desenvolvimento e Banco de Dados (SDBD);
   - Seção de Redes e Infraestrutura de TI (SEREDE);
   - Seção de Suporte ao Usuário e Atendimento (SSU).

4. **Juízos Eleitorais de 1º Grau e Cartórios Eleitorais (Capital e Interior):**
   - Cartórios Eleitorais da 1ª à 9ª Zonas Eleitorais, sediados nos municípios de Rio Branco (1ª e 9ª Zonas / Central de Atendimento ao Eleitor — CAE e OCA), Cruzeiro do Sul (2ª Zona), Sena Madureira (3ª Zona), Feijó (4ª Zona), Tarauacá (5ª Zona), Brasileia (6ª Zona), Xapuri (7ª Zona) e Plácido de Castro (8ª Zona);
   - Postos de Atendimento ao Eleitor (PAEs) em municípios isolados, ribeirinhos e de fronteira: Jordão, Marechal Thaumaturgo, Porto Walter, Santa Rosa do Purus, Bujari, Porto Acre, Acrelândia, Assis Brasil, Mâncio Lima, Rodrigues Alves, Capixaba, Manoel Urbano e Epitaciolândia.

---

### 2. Objeto a ser Contratado

Aquisição de solução tecnológica integrada de computação móvel corporativa destinada a **possibilitar a substituição dos atuais 170 (cento e setenta) equipamentos móveis corporativos que se encontram em avançado estágio de degradação física e obsolescência tecnológica**, por **170 Notebooks Corporativos de Alto Desempenho (Tipo I - CATMAT 618643)**, novos, de primeira utilização e integrantes de linha regular de produção do fabricante, dotados de processador corporativo de última geração equipado com **núcleos de processamento com NPU (Neural Processing Unit) dedicada para Inteligência Artificial** e com **requisitos avançados de cibersegurança em hardware** (módulo criptográfico TPM 2.0 ativo em hardware, leitor biométrico de impressão digital, câmera infravermelha IR 5MP compatível com Windows Hello, obturador físico de privacidade e suporte a Windows 11 Pro 64-bit), acompanhados de fonte de alimentação corporativa, maleta de transporte reforçada, garantia técnica *on-site* do fabricante por 60 (sessenta) meses e suporte técnico oficial.

#### Tabela Descritiva do Objeto e Estimativa de Custos

| Item | Descrição Resumida do Equipamento | Especificação Técnica Mínima / Parâmetros da Solução | CATMAT | Qtd | Valor Unitário Registrado (R$) | Valor Total Estimado (R$) |
| :---: | :--- | :--- | :---: | :---: | :---: | :---: |
| **1** | **Notebook Corporativo de Alto Desempenho (Tipo I)** | Processador corporativo móvel de última geração (mínimo de 10 núcleos físicos / 12 threads), NPU integrada dedicada para Inteligência Artificial, 16 GB a 32 GB de memória RAM DDR5 5600 MHz (expansível), SSD NVMe PCIe 4.0 de 512 GB a 1 TB, tela antirreflexo de 14" WUXGA (1920x1200) IPS, placa gráfica de alto rendimento, teclado ABNT2 retroiluminado resistente a derramamento de líquidos, Wi-Fi 6E, Bluetooth 5.3, portas Thunderbolt 4 / USB-C (com *Power Delivery* e DisplayPort), leitor de impressão digital, módulo criptográfico TPM 2.0 ativo em hardware, webcam HD/FHD IR 5MP com biometria facial e obturador físico de privacidade, bateria de longa duração (mínimo 56Wh com carga rápida), sistema operacional Microsoft Windows 11 Pro 64-bit ativado em fábrica e **Garantia Técnica Oficial *On-Site* do Fabricante por 60 Meses (5 anos)**. | 618643 | 170 | R$ 11.060,00 | R$ 1.880.200,00 |
| **TOTAL** | **Solução de Computação Móvel Corporativa** | **Substituição dos 170 Equipamentos Obsoletos por Notebooks Tipo I com NPU de IA e Cibersegurança em Hardware (Garantia 60m *On-Site*)** | — | **170** | — | **R$ 1.880.200,00** |

---

### 3. Justificativa e Fundamentação da Necessidade da Contratação

#### 3.1. Diagnóstico do Acervo Patrimonial e Inconfiabilidade dos Equipamentos Atuais
A necessidade de renovação do parque computacional móvel do TRE-AC fundamenta-se nos dados analíticos consolidados no **RELATÓRIO CONSOLIDADO DE BENS PATRIMONIAIS E INVENTÁRIO DE TIC DO TRE-AC** e no histórico registrado pela Coordenadoria de Material e Patrimônio (COMAP) e Seção de Patrimônio (SEPAT).

O inventário patrimonial revela que o acervo computacional portátil do Tribunal possui 361 unidades cadastradas. Desse total, **221 notebooks e ultrabooks (61,2%) encontram-se com a garantia técnica contratual totalmente expirada**. Notadamente, no lote de 170 equipamentos móveis alocados aos postos de trabalho de servidores ativos, magistrados e cartórios que serão objeto de substituição nesta contratação, **100% das máquinas estão com garantias expiradas e acumulam tempo de uso entre 4 e 16 anos** (superando o teto regulamentar de 4 a 5 anos estabelecido pela Portaria SGD/MGI nº 2.715/2023, pela Diretriz D16 do PDTIC-PJ e D15 do PDTI/TRE-AC).

A Tabela a seguir sintetiza o diagnóstico do histórico de entradas, tempo de uso transcorrido e status de garantia dos lotes de notebooks portáteis do Regional:

#### Tabela 1: Histórico Patrimonial e Diagnóstico da Frota de Portáteis do TRE-AC

| Fabricante / Marca | Linha / Modelo Registrado | Ano de Entrada | Processo / Empenho | Qtd | Tempo de Uso Transcorrido | Status da Garantia Contratual | Diagnóstico Operacional |
| :--- | :--- | :---: | :--- | :---: | :---: | :---: | :--- |
| **Daten Tecnologia** | DT02 M5 (Core 2 Duo P8600, 2GB) | 2010 | Proc. 9.962/2010 (2010NE000424) | 1 | **16 Anos** | Expirada em 2013 | Inconfiável; fora de operação |
| **HP Inc. / TRE-CE** | ProBook 4430s (Core i3-2330M) | 2012 / 2013 | Proc. 2.506/2013 / Cessão | 39 | **13 a 14 Anos** | Expirada em 2015 | Desgaste físico severo; sem peças |
| **Positivo Informática** | Master N250i (Core i5-4200M) | 2014 | Proc. 10.247/2014 (2014NE010247) | 59 | **12 Anos** | Expirada em 2017 | Baterias viciadas; lentidão extrema |
| **Apple Inc.** | MacBook Pro MF840 (Retina 13") | 2016 | Proc. 0002179-29.2016 (2016NE000793) | 2 | **10 Anos** | Expirada em 2017 | Incompatível com sistemas do TSE |
| **Dell Computadores** | Latitude 14 3400 (Core i5-8265U) | 2019 | Proc. 0002910-59.2019.6.01 (2019NE000750) | 40 | **7 Anos** | Expirada em 13/12/2024 | Falhas em placa-mãe; superaquecimento |
| **TSE / Repasses** | Positivo / Daten DCM4D / HP | 2022 | Proc. 0003141-81.2022.6.01 / NF 202225 | 60 | **4 Anos** | Sem garantia ativa | Repasse extraorçamentário sem suporte |
| **Daten Tecnologia** | DCM4A-4 (Core i5 11ª Gen, 8GB, SSD) | 2022 | Proc. 0001287-52.2022.6.01 (2022NE000344) | 140 | **4 Anos** | Vigente (até Nov/2027) | Parque intermediário ativo |
| **TOTAL DE PORTÁTEIS** | **Acervo Computacional Móvel** | **2010 a 2022** | **Diversos Processos Patrimoniais** | **361** | **Média: 7,4 Anos** | **61,2% Expirado / 38,8% Vigente** | **170 Unidades Requerem Substituição Urgente** |

A inconfiabilidade decorrente da inconsistência de funcionamento desses 170 computadores defasados gera paralisações frequentes, travamentos durante a instrução de processos no PJe e SEI, elevado custo de manutenção corretiva avulsa e alto risco de indisponibilidade no atendimento eleitoral.

#### 3.2. Aparelhamento dos Servidores e Necessidade de Equipamentos Portáteis no Cotidiano
A evolução dos métodos de trabalho na Justiça Eleitoral exige que servidoras, servidores, magistradas e magistrados estejam devidamente aparelhados com equipamentos portáteis corporativos de alto desempenho no seu dia a dia. A disponibilização de notebooks institucionais garante:
1. **Continuidade Operacional e Trabalho Híbrido:** Imediata transição entre o posto presencial e o trabalho remoto ou de plantão judicional sem perda de capacidade computacional, com acesso seguro via VPN e certificados digitais;
2. **Atendimento Direto aos Serviços Eleitorais Finalísticos:** O atendimento continuado ao eleitorado, a instrução de processos de registro de candidatura, a prestação de contas partidárias e a fiscalização de propaganda são executados de forma direta pelos servidores por meio dessas ferramentas móveis;
3. **Erradicação da Prática de BYOD (*Bring Your Own Device*) e Conformidade com a LGPD:** A disponibilização dos 170 notebooks padronizados extirpa o uso inadequado de computadores pessoais não homologados para tarefas públicas. A medida atende ao art. 46 da Lei Geral de Proteção de Dados (LGPD — Lei nº 13.709/2018), à Resolução TSE nº 23.659/2021 e aos arts. 8º e 9º da Portaria CRE nº 2/2026, blindando o tratamento de dados biográficos e biométricos de eleitores no Sistema Elo e PJe contra vazamentos.

#### 3.3. Elevada Demanda de Atividades Externas sem Equipamentos para Cessão
É intensa a demanda por atividades executadas pelos servidores fora das dependências físicas da Sede do Tribunal, em locais onde **não existem computadores disponíveis para cessão ou empréstimo**. Os servidores do TRE-AC atuam frequentemente em campo nas seguintes frentes:
- **Ações Itinerantes nos 98 LDAs (Locais de Difícil Acesso):** Alistamento eleitoral, revisão biométrica e emissão de títulos em aldeias indígenas, comunidades ribeirinhas e seringais isolados (*Programa Rolê da Cidadania*);
- **Vistorias Técnicas de Engenharia e Arquitetura (ASGIM/CIE):** Planejamento, reforma e avaliação de acessibilidade predial nos fóruns do interior (*Programa Cartório Acessível*), exigindo a execução da metodologia BIM (*Building Information Modelling*) em softwares de alta exigência gráfica (AutoCAD 2025, Revit, QiBuilder, V-Ray e tabela SINAPI) diretamente no canteiro de obras;
- **Correições Ordinárias e Inspeções Cartorárias (CRE):** Atuação presencial da equipe da Corregedoria nos cartórios eleitorais do interior para auditagem de procedimentos e livros cartorários.

#### 3.4. Eliminação da Necessidade de Recolhimento Recorrente de Máquinas
Atualmente, para viabilizar os atos preparatórios e a logística das eleições, a STI e a CSCOR são forçadas a **recolher recorrentemente os notebooks que estão sob a guarda dos servidores em suas unidades de origem**. Essa prática indesejada causa sérios transtornos administrativos, desestruturando a rotina ordinária das secretarias e cartórios eleitorais, paralisa a instrução de processos e gera desgaste físico nos equipamentos pelo transporte constante. A contratação dos 170 notebooks eliminará em definitivo esse gargalo, provendo uma frota permanente e homologada.

#### 3.5. Suporte às Atividades Críticas da Eleição e Cobertura de Pontos Estratégicos
A renovação do parque portáti destina-se a prover suporte tecnológico direto às seguintes operações fundamentais do pleito eleitoral:
1. **Treinamento de Mesários, Servidores e Magistrados:** Aparelhamento das salas de capacitação presencial e virtual nos sistemas oficiais da Justiça Eleitoral (SJE, PJe, Apolo, Diploma e Biometria);
2. **Atendimento aos 98 Locais de Difícil Acesso (LDAs):** Alocação garantida de **1 (um) notebook corporativo para cada um dos 98 LDAs catalogados** no Estado do Acre (municípios como Jordão, Santa Rosa do Purus, Marechal Thaumaturgo, Porto Walter, entre outros), assegurando a transmissão descentralizada de boletins de urna e a conectividade via satélite/mini-firewalls;
3. **Atendimento aos 40 Locais de Transmissão da Capital:** Disponibilização de **1 (um) notebook de alto rendimento para cada um dos 40 Pontos de Transmissão de Resultados de Rio Branco**, garantindo a celeridade e a segurança na totalização dos votos;
4. **Vistoria e Inspeção dos Locais de Votação:** Suporte móvel para equipes de logística e juízes eleitorais durante a vistoria das seções eleitorais em todo o Estado.

#### 3.6. Atendimento à Demanda Reprimida de Magistrados e Trabalho Remoto
Existe uma expressiva demanda reprimida por notebooks corporativos para atender aos **17 Membros da Corte Eleitoral e Procuradores**, aos **9 Juízes Eleitorais Titulares**, a assessores jurídicos e às equipes que executam atividades em regime de trabalho remoto ou de plantão judiciário. A portabilidade dos notebooks Tipo I permitirá o acompanhamento em tempo real das sessões plenárias presenciais e telepresenciais, a realização de audiências judiciais e a assinatura eletrônica célere de acórdãos e decisões liminares urgentes no PJe de qualquer localidade.

#### 3.7. Inovações Tecnológicas: NPU para Inteligência Artificial e Cibersegurança em Hardware
A opção por computadores equipados com **NPU (Neural Processing Unit) dedicada para Inteligência Artificial** e **requisitos avançados de cibersegurança em hardware** justifica-se pelos seguintes avanços institucionais:
- **Aceleração NPU para IA:** Descarrega da CPU principal as tarefas de automação, OCR em documentos digitalizados do PJe, transcrição de áudio/vídeo em audiências e execução de assistentes virtuais, reduzindo o consumo de energia e aumentando a fluidez do sistema;
- **Cibersegurança de Endpoint em Hardware (Zero Trust):** O chip criptográfico TPM 2.0 ativo em hardware, a biometria facial IR 5MP com Windows Hello, o leitor de impressão digital e o obturador físico de privacidade cumprem rigorosamente os requisitos da Estratégia Nacional de Segurança Cibernética (ENSEC-PJ / Resolução CNJ nº 396/2021, art. 11) e da Política de Segurança da Informação da Justiça Eleitoral (PSI-JE / Resolução TSE nº 23.763/2026, art. 9º), blindando os *endpoints* móveis contra invasões e captura de credenciais.

---

### 4. Estimativa Preliminar do Valor da Contratação

A estimativa orçamentária do valor global da contratação fundamenta-se nos preços registrados na **Ata de Registro de Preços (ARP) nº 26/2026** (decorrente do Pregão Eletrônico SRP nº 90068/2025 da Universidade Federal do Acre — UFAC, UASG 154044), fornecidos pela empresa registrada **Plugnet Comércio e Representações Ltda.**:

#### Tabela Descritiva dos Custos Estimados

| Item | Descrição Resumida do Equipamento | Unidade | Quantidade | Valor Unitário Registrado (R$) | Valor Total Estimado (R$) |
| :---: | :--- | :---: | :---: | :---: | :---: |
| **1** | Notebook Corporativo de Alto Desempenho Tipo I (CATMAT 618643) | Unidade | 170 | R$ 11.060,00 | R$ 1.880.200,00 |
| **TOTAL** | **Investimento Global na Solução de Computação Móvel** | — | **170** | — | **R$ 1.880.200,00** |

*Nota Orçamentária:* O investimento total estimado para a substituição dos 170 equipamentos móveis perfaz o montante de **R$ 1.880.200,00 (um milhão, oitocentos e oitenta mil e duzentos reais)**, valor a ser confirmado no ETP e na ICVEC.

---

### 5. Quantidade Justificada a ser Contratada e Memória de Cálculo

O dimensionamento do quantitativo de 170 notebooks decorre estritamente do censo atualizado da força de trabalho ativa e do corpo de magistrados do TRE-AC (Resolução CNJ nº 102/2009 — Anexos IV e V):

#### Tabela 2: Quadro de Mapeamento dos Usuários Ativos da Justiça Eleitoral do Acre

| Categoria do Público-Alvo | Detalhamento dos Cargos e Funções Contempladas | Qtd Usuários | Qtd Notebooks |
| :--- | :--- | :---: | :---: |
| **Servidores Efetivos do Quadro Permanente** | Analistas Judiciários (44) e Técnicos Judiciários (75) ativos ocupados na Sede e Cartórios | 119 | 119 |
| **Servidores Requisitados e Comissionados** | Servidores cedidos/requisitados de outros órgãos (21) e ocupantes de cargo em comissão sem vínculo (4) | 25 | 25 |
| **Membros da Corte Eleitoral e Procuradores** | Desembargadores TJAC (4), Juízes de Direito/Federal (6), Juristas (3), PRE (2) e Juízes Auxiliares (2) | 17 | 17 |
| **Juízes Eleitorais de 1º Grau** | Juízes Eleitorais Titulares das 9 Zonas Eleitorais (Capital e Interior do Estado) | 09 | 09 |
| **TOTAL GERAL CONSOLIDADO** | **Força de Trabalho Ativa e Corpo de Magistrados do TRE-AC** | **170** | **170** |

---

### 6. Previsão da Data em que deve ser Entregue o Bem

- **Prazo de Entrega pelo Fornecedor:** Até **60 (sessenta) dias corridos**, contados a partir do recebimento formal da Ordem de Fornecimento de Bens (OFB) e emissão da Nota de Empenho;
- **Previsão de Entrada em Operação:** Até **novembro de 2026**, assegurando que 100% da força de trabalho e magistrados estejam equipados com os novos computadores portáteis para o encerramento do exercício e preparação do pleito subsequente.

---

### 7. Grau de Prioridade

- **Grau de Prioridade:** **ALTO**
- **Justificativa:** 
  1. Estado crítico de degradação física e inconfiabilidade operacional dos 170 notebooks atuais (100% fora de garantia e com até 16 anos de uso);
  2. Imperiosa necessidade de suprir os 98 Locais de Difícil Acesso (LDAs) e os 40 Pontos de Transmissão da Capital;
  3. Necessidade de atender à equipe de engenharia/arquitetura (ASGIM) em modelagem BIM e às equipes de TI (SDBD/CSCOR);
  4. Urgência na execução dos recursos da Ação 21EE (Cibersegurança) no exercício de 2026, atingindo a meta de 99% de execução orçamentária da LOA.

---

### 8. Alinhamento Estratégico e Indicadores Institucionais

A aquisição pauta-se nos seguintes diplomas de governança:
1. **Plano Estratégico Institucional (PEI 2021-2026):** Macrodesafios 13/9 (Inovação Tecnológica e Cibersegurança), 12/8 (Gestão Orçamentária Eficiente) e 11/7 (Qualidade de Vida no Trabalho);
2. **Plano Diretor de TIC (PDTI 2025-2027):** Ações estratégicas **PDI-04** e **PDI-08**, além do cumprimento da **Diretriz D15/D16** de substituição de parque obsoleto;
3. **Resoluções do CNJ e TSE:** ENTIC-JUD (Resolução CNJ nº 370/2021), ENSEC-PJ (Resolução CNJ nº 396/2021) e PSI-JE (Resolução TSE nº 23.763/2026);
4. **Phronesis (Indicadores de Gestão):** Manutenção do **iGovTIC-TRE-AC (IE30 $\ge 90\%$)**, **PDTIC (IE31 $\ge 70\%$)**, **Satisfação do Usuário (IE34 $\ge 94\%$)**, **IDSC ($\ge 99,8\%$)**, **99% de execução da LOA 2026** e **Índice de Perda Orçamentária (IE26 < 3%)**;
5. **Plano de Logística Sustentável (PLS/TRE-AC):** Certificações *Energy Star*, *EPEAT Gold*, conformidade com a diretiva *RoHS* e logística reversa de resíduos eletrônicos (Resolução CNJ nº 400/2021).

---

### 9. Informações Adicionais, Processamento por Registro de Preços, PCA 2026 e Encaminhamentos

#### 9.1. Processamento por Registro de Preços e Adesão (Carona)
- **( X ) Sim:** Recomenda-se o processamento da aquisição mediante **adesão por carona à Ata de Registro de Preços nº 26/2026** (Pregão Eletrônico SRP nº 90068/2025 da UFAC), na condição de órgão não participante, com amparo no art. 86 da Lei nº 14.133/2021, Decreto Federal nº 11.462/2023, Resolução CNJ nº 468/2022 e IN TRE-AC nº 72/2024 (fornecedor registrado Plugnet Comércio e Representações Ltda. / modelo HP EliteBook 6G1i 14).

#### 9.2. Inclusão Extemporânea no PCA 2026 e Adequação Orçamentária (Ação 21EE)
- **Alteração Extemporânea do PCA 2026:** Antecipação da demanda prevista originalmente no PCA 2027 para inclusão no **PCA 2026 (Processo SEI nº 0000803-32.2025.6.01.8000)**, amparada no art. 6º, parágrafo único, da Resolução TSE nº 23.702/2022, no Decreto nº 10.947/2022 e no art. 17, parágrafo único, da IN TRE-AC nº 71/2024;
- **Alocação na Ação 21EE (Cibersegurança):** Em consonância com a Informação STI nº 0918910/2026 e em atendimento ao Ofício-Circular GAB-DG/TSE nº 236/2026 (Processo SEI nº 0002313-46.2026.6.01.8000), o custeio de **R$ 1.880.200,00 será alocado diretamente nos recursos da Ação 21EE — Gestão da Política de Segurança da Informação e Cibernética (ND 44.90.52.41 / PI INV EQUTIC)**, eliminando o risco de perda orçamentária e blindando os *endpoints* móveis.

#### 9.3. Encaminhamento Institucional
Submete-se o presente DFD reformulado aos seguintes encaminhamentos:
1. **À ASGOVSAOF:** Para análise prévia de conformidade instrucional dos artefatos da contratação;
2. **À GASAOF / SAOF:** Para manifestação orçamentária e posterior envio à **SPEO** para emissão da Declaração de Reserva Orçamentária vinculada à Ação 21EE;
3. **À Diretoria-Geral e Presidência do TRE-AC:** Para deliberação motivada, aprovação da alteração do PCA 2026 e autorização de prosseguimento da contratação.

Rio Branco - AC, 25 de setembro de 2026.

\  
____________________________________________________  
**Cleilton de Nazaré Costa**  
Secretário de Tecnologia da Informação — TRE-AC  
*Gestor Responsável da Unidade Demandante*  
