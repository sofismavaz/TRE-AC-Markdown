Processo SEI 0002758-64.2026.6.01.8000 - Atualização SEI v5.0  - Plano de Migração do Sistema Eletrônico de Informações (SEI) — Versão 4.0.12 para 5.0.5

---

Despacho nº 0928973 / 2026 - PRESI/DG/STI/CSCOR/SDBD

Abro o presente processo com a finalidade de registrar e acompanhar as atividades relacionadas à atualização do Sistema Eletrônico de Informações (SEI) para a versão 5, contemplando a aplicação dos patches de segurança necessários, com vistas à futura disponibilização do acesso externo ao sistema.

À consideração superior.

---
Solicitação HE 0929064 - INSTRUÇÃO NORMATIVA Nº 64, DE 04 AGOSTO DE 2022

Senhor(a) Diretor(a) Geral/Presidente

Nos termos da IN TRE/AC n 64 de 04 de Agosto de 2022, requeiro autorização para adoção de jornada extraordinária nesta unidade nos períodos relacionados, pelas justificativas que ao final apresento:

|Dia(s)/Mês	|Servidores	|Qtd/He/dia	|Descrição da atividade	|Tipo de dia: 1. ÚTIL; 2. SÁBADO; 3. DOMINGOS/FERIADOS| Forma de Pagamento: 1- Pecúnia; 2- Banco de horas|
|---|---|---|---|---|---|
|30/10/2026	|FRANCISCO VITAL DE MASCARENHAS FILHO; JOSÉ JAIR CAVALCANTE DE FIGUEIREDO; JONATHAN MESSIAS E SILVA| 8| - Restauração do banco de dados NAOSEI; - levantamento dos requisitos de infraestrutura; - realização do backup.| 3 |2|

2. Selecione o processo do PROINTE ao qual a atividade é vinculada

Selecione o processo do PROINTE ao qual a atividade é vinculada:

( )Candidaturas (RC3); ( )Horário Eleitoral (HE4); ( )Votação Paralela (VP5); ( )Votação (Logística do dia "E") ( (LD6); ( ) Transmissão, Apuração, Totalização e Divulgação dos Resultados (TA7); ( )Prestação de contas (PC8); ( )Recursos humanos (RH94); ( )Atos e Normativos (AN96); ( )Treinamento de Mesários (TM91); ( )Comunicação Institucional (CI98); ( )Transporte (TR910); ( )Alimentação de Mesários (AM93); ( )Disque Eleições (DE95); ( )Urnas Eletrônicas (EU97); ( )Reuniões internas e externas (RE911); ( )Contratações aquisições (CT99); ( )Plantão;( )Cadastro Eleitoral (CE18); ( )Outros

 

JUSTIFICATIVA DO PEDIDO

Preparativos técnicos prévios à migração do SEI v4 para v5:

- atualização do ambiente de testes denominado "NAOSEI" com dos dados mais recentes do ambiente de produção para posterior teste de migração SEI, a fim de validar o procedimento;

- levantamento dos requisitos de infraestrutura exigidos pela nova versão;

- realização de cópias de segurança (backup) do banco de dados e dos documentos do ambiente de produção;

Rio Branco, 28 de outubro de 2026.

---

Despacho nº 0929067 / 2026 - PRESI/DG/STI/CSCOR

Considerando a recente necessidade de correção de vulnerabilidade de segurança identificada (conhecida como PHP2Shell) no PHP, linguagem utilizada no desenvolvimento do Sistema Eletrônico de Informações (SEI), que permite a execução de código remoto sem autenticação. 

Considerando que o sistema SEI é executado neste TRE num container Docker, circunstância que impõe procedimentos de atualização distintos daqueles normalmente adotados em servidores físicos ou virtuais convencionais, que majoritariamente são utilizados na infraestrutura deste Tribunal. 

Considerando que a imagem Docker atualmente utilizada para execução do SEI neste Regional foi originalmente disponibilizada pelo Tribunal Regional Eleitoral de Rondônia (TRE-RO); 

Considerando que o SEI em operação neste Tribunal está na versão 4.0 e que já foi concedida, pelo Tribunal Regional Federal da 4ª Região (TRF4), a autorização necessária para atualização para a versão 5.0 do sistema; 

Considerando que o TRE-RO já mantém o SEI versão 5.0 em ambiente de produção, executando-o em contêiner Docker atualizado e com as correções aplicáveis à vulnerabilidade mencionada, possuindo, portanto, experiência técnica comprovada tanto na atualização do sistema quanto na adequação do respectivo ambiente tecnológico; 

Considerando, ainda, o histórico de longa parceria e colaboração entre este Tribunal e o TRE-RO em temas relacionados à tecnologia da informação, o que favorece a troca de conhecimento e reduz riscos na execução. 

Esta Coordenadoria, em atuação conjunta com a CIE, propõe a adoção das seguintes providências: 

Aproveitar a necessidade de aplicação da correção de segurança relacionada ao PHP para promover, concomitantemente, a atualização do SEI para sua versão mais recente homologada para uso por este Tribunal, qual seja, a versão 5; 
Encaminhar expediente à Secretaria de Tecnologia da Informação do TRE-RO, solicitando: 
a renovação das credenciais de acesso ao repositório de imagens Docker e ao git mantido por aquele Regional; 
o compartilhamento de eventual documentação técnica, manuais, roteiros operacionais ou demais artefatos produzidos para subsidiar o processo de migração do SEI da versão 4 para a versão 5; 
o apoio técnico da equipe durante as etapas de preparação, atualização e validação da migração, preferencialmente mediante apoio presencial de servidor com experiência comprovada na implementação do procedimento. Não sendo viável o deslocamento, sugere-se a prestação do suporte de forma remota, em cronograma a ser definido de comum acordo entre as equipes técnicas envolvidas. 
Esclareço que as medidas ora propostas visam não apenas à correção da vulnerabilidade identificada no ambiente atual, mas também à atualização tecnológica do sistema para sua versão mais recente, permitindo, adicionalmente, o aproveitamento da experiência acumulada pelo TRE-RO no processo de migração. Busca-se, dessa forma, obter apoio na preparação do ambiente, na execução dos procedimentos de atualização, na validação pós-implantação e no tratamento tempestivo de eventuais intercorrências, contribuindo para a redução dos riscos operacionais e para o aumento das chances de sucesso da iniciativa.

Por fim, solicito a autorização para prestação de serviço extraordinário, conforme descrito no formulário SEI 0929067.

À consideração superior.

---

Despacho nº 0929664 / 2026 - PRESI/DG/STI/GSTI

 

Senhor Diretor-Geral,

1. Trata-se de proposta técnica submetida pela Coordenadoria de Soluções Corporativas (CSCOR) em conjunto com a Coordenadoria de Infraestrutura (CIE), formalizada por meio do Despacho nº 0929067/2026 e instruída com a Solicitação de Horas Extraordinárias – HE nº 0929064. A iniciativa visa à execução das atividades preparatórias e estruturais para a migração do Sistema Eletrônico de Informações (SEI) da versão 4.0 para a versão 5.0, contemplando a urgente mitigação da vulnerabilidade crítica PHP2Shell (execução remota de código arbitrário) e a futura disponibilização do acesso externo.

2. As atividades planejadas na Solicitação HE nº 0929064 compreendem: a restauração e atualização da base de dados do ambiente de homologação/testes ("NAOSEI"); o levantamento dos novos requisitos de infraestrutura e contêineres Docker; e a geração de rotinas preventivas de cópias de segurança integrais (backup) do banco de dados e dos documentos digitais de produção. Tais etapas constituem salvaguardas operacionais indispensáveis para assegurar a integridade, a confidencialidade e a disponibilidade do acervo processual do Tribunal, mitigando riscos de solução de continuidade.

3. A matéria encontra estrita consonância com as competências da STI e de suas unidades subordinadas (arts. 48, 51, 56 e 91 da Resolução TRE-AC nº 1.808/2025 – Regimento Interno da Secretaria), bem como com os princípios de continuidade do serviço público, segurança cibernética e governança digital estabelecidos na Resolução CNJ nº 370/2021 (ENTIC-JUD), na Resolução CNJ nº 396/2021 (ENSEC-PJ) e na Resolução TSE nº 23.763/2026 (Política de Segurança da Informação da Justiça Eleitoral).

4. Diante do manifesto interesse institucional, da criticidade de segurança envolvida e da necessidade de intervenção técnica em horário que não cause impacto às rotinas ordinárias do Tribunal, MANISFESTO CONCORDÂNCIA INTEGRAL com o plano de trabalho e com a execução das atividades relacionadas no formulário SEI nº 0929064.

5. Considerando que a autorização para prestação de serviço extraordinário e a gestão administrativa da Secretaria competem à Direção-Geral (conforme as disposições da Instrução Normativa TRE-AC nº 64/2022 c/c os arts. 36 e 87 da Resolução TRE-AC nº 1.808/2025), ENCAMINHEM-SE os presentes autos à Diretoria-Geral, submetendo a Solicitação HE nº 0929064 à superior apreciação e deliberação.

Rio Branco, 29 de outubro de 2026.

 

CLEILTON DE NAZARÉ COSTA

Secretário de Tecnologia da Informação

Tribunal Regional Eleitoral do Acre

---

Informação Nº 0929686 - PRESI/DG/STI/GSTI

 

Senhor Diretor-Geral,

Senhores Coordenadores da CIE e da CSCOR,

1. Trata-se de expediente instaurado com o objetivo de planejar, subsidiar e executar as atividades técnicas preparatórias e definitivas voltadas à migração do Sistema Eletrônico de Informações (SEI) da versão 4.0 para a versão 5.0 neste Tribunal Regional Eleitoral do Acre, contemplando a urgente correção da vulnerabilidade crítica de segurança (PHP2Shell) no contêiner PHP/Docker e a futura disponibilização do acesso externo à plataforma, nos termos do Despacho nº 0928973/2026 e do Despacho nº 0929067/2026.

2. Inicialmente, registro que esta Secretaria de Tecnologia da Informação acata integralmente as medidas propostas pela Coordenadoria de Soluções Corporativas (CSCOR) e pela Coordenadoria de Infraestrutura (CIE), reconhecendo a conveniência e a oportunidade técnica de sincronizar a mitigação das vulnerabilidades com o avanço de versão do sistema. A presente Informação consubstancia as providências de cooperação interinstitucional levadas a efeito por esta Secretaria e estabelece as diretrizes de trabalho a cargo de suas unidades subordinadas.


3. Com o objetivo de conferir celeridade e segurança ao procedimento, na manhã de hoje, 29 de outubro de 2026 (quinta-feira), este Secretário de Tecnologia da Informação realizou reunião virtual de alinhamento com o Secretário de TI do Tribunal Regional Eleitoral de Rondônia (TRE-RO), servidor Eduardo Gil Tivanello, e com o servidor Marco Yêrco Mendizabel Cabrera, integrante do corpo técnico daquela Secretaria, o qual participou ativamente do processo de migração do SEI da versão 4 para a versão 5 no âmbito daquele Regional, acumulando ampla experiência nos procedimentos de homologação e sustentação em contêineres Docker.

4. Durante o diálogo interinstitucional, a equipe técnica do TRE-RO comunicou a impossibilidade do deslocamento presencial de servidores a Rio Branco/AC para prestação de apoio local, haja vista que a unidade técnica rondoniense encontra-se em fase conclusiva de atendimento a uma grande demanda de sistemas que exige a dedicação exclusiva de toda a equipe.

5. Não obstante a impossibilidade de assistência presencial, o Secretário de TI do TRE-RO assegurou cooperação técnica remota a este Tribunal, disponibilizando expressamente o servidor Marco Yêrco Mendizabel Cabrera para prestar orientação e suporte à equipe da STI/TRE-AC, caso necessário, durante as fases de preparação, conversão e homologação.

6. Ademais, foi formalmente compartilhado pelo TRE-RO o manual de migração contendo o roteiro operacional e as parametrizações técnicas de contêineres e banco de dados, cujo repositório encontra-se armazenado no endereço: https://gitlab.tre-ro.jus.br/docker/sei.

7. Por oportuno, registro que o Coordenador de Soluções Corporativas (CSCOR/STI) deste Regional deverá manter contato direto com o servidor Marco Yêrco Mendizabel Cabrera a fim de obter as respectivas credenciais de acesso ao repositório de imagens Docker e ao ambiente GitLab mantidos pela Justiça Eleitoral rondoniense. Tal acesso deverá observar estritamente a gestão de privilégios mínimos e os protocolos de autenticação e confidencialidade previstos na Resolução TSE nº 23.763/2026 (Política de Segurança da Informação da Justiça Eleitoral) e nas normas internas de segurança do Tribunal.

8. Diante das tratativas concluídas e do modelo de suporte técnico remoto pactuado entre os Tribunais cooperantes, submeto o presente expediente:

a) à Diretoria-Geral, para formal conhecimento do plano de cooperação e das medidas de segurança adotadas pela STI, bem como para superior deliberação quanto à autorização de jornada extraordinária solicitada pela unidade técnica no formulário Solicitação HE (SEI nº 0929064), à luz da Instrução Normativa TRE-AC nº 64/2022 c/c o art. 87 da Resolução TRE-AC nº 1.808/2025; e

b) às Coordenadorias de Soluções Corporativas (CSCOR) e de Infraestrutura (CIE), para formal conhecimento e adoção imediata das providências executivas decorrentes das tratativas com o TRE-RO, compreendendo: i) o contato da chefia da CSCOR com o servidor rondoniense Marco Yêrco Mendizabel Cabrera para recepção das credenciais institucionais de acesso; ii) a clonagem dos artefatos e análise do manual de migração; a preparação do ambiente de testes "NAOSEI"; e iii) a execução das rotinas de backup e segurança estabelecidas no plano de trabalho.


É o que informo.

Rio Branco, 29 de outubro de 2026.

 

CLEILTON DE NAZARÉ COSTA

Secretário de Tecnologia da Informação

Tribunal Regional Eleitoral do Acre

---

Plano Nº 20 / 2026 - PRESI/DG/STI/CSCOR/SDBD

Plano de Migração do Sistema Eletrônico de Informações (SEI) — Versão 4.0.12 para 5.0.5
1. Visão Geral e Engenharia da Evolução de Software
O Tribunal Regional Eleitoral do Acre (TRE-AC) demanda a modernização de sua plataforma principal de gestão documental e administrativa, o Sistema Eletrônico de Informações (SEI). A migração da versão 4.0.12 para a versão 5.0.5 é motivada pela descontinuidade do suporte de segurança e encerramento do ciclo de vida útil da série PHP 7.x (utilizada nas versões SEI 4.0 e 4.1), impondo a transição para o runtime otimizado do PHP 8.2 e PHP 8.4 no SEI 5.0.

Para garantir a continuidade dos serviços jurisdicionais e administrativos nas unidades do Tribunal, este plano adota preceitos rígidos de Engenharia de Software aplicados à evolução de sistemas legados de missão crítica. A estratégia estabelece um caminho de atualização incremental em dois saltos obrigatórios:

```
[ SEI 4.0.12 ] ──► [ SEI 4.1.05 (Versão Intermediária) ] ──► [ SEI 5.0.5v2 (Produção Otimizada) ]
```
A permanência na versão intermediária 4.1.05 é vedada, pois, embora resolva incompatibilidades estruturais de esquema de banco de dados, ela mantém vulnerabilidades conhecidas que são corrigidas definitivamente na versão 5.0.5.

2. Governança, Equipe e Deliberações das Atas Institucionais
A condução do projeto está fundamentada nas decisões pactuadas em reuniões de alinhamento técnico entre o TRE-AC e o Tribunal Regional Eleitoral de Rondônia (TRE-RO), que atua como órgão mentor em razão da experiência prévia na transição para o SEI 5.

2.1 Mapeamento de Papéis e Responsabilidades
Secretaria de Tecnologia da Informação (STI / TRE-AC) : Cleilton Nazaré Costa (Secretário de TI) — Direção estratégica e aprovação das janelas de mudanças. 
Coordenação Técnica e Sistemas Corporativos e SDBD : Ilis Sandro Antonio Areno Ambrozio (Coordenador da execução), Lucir Rocio Vaz, Thallys Bandeira Roque Maia Pinto, Marco Aurélio Bortoli, Felipe Bezerra, Clicia Quintela Freitas, Silvio Forastiero Frazão e Cleiber Castro. 
Infraestrutura e Operações : Francisco Vital de Mascarenhas Filho, José Jair Cavalcante de Figueiredo, Jonathan Messias e Silva e Rosimar Rodrigues Lima — Gestão de contingência, SGBD Oracle, BACULA e Docker. 
Mentoria e Suporte Especializado (TRE-RO) : Ermeson de Oliveira Laurindo (SESOLUTI / TRE-RO) — Disponibilização de artefatos Docker, apoio no sequenciamento de scripts e validação técnica. 
2.2 Síntese das Deliberações Executivas (Atas de 29/10/2026, 03/11/2026 e 06/11/2026)
Reutilização de Artefatos Docker : Adota-se as imagens pré-compiladas no Registry oficial do TRE-RO (registry.tre-ro.jus.br/trero/sei:4.1.5 e registry.tre-ro.jus.br/trero/sei:5.0.5v2), dispensando a construção local de contêineres pelo TRE-AC.
Configuração de Segurança do Docker : Obrigatoriedade de instalação do certificado da Autoridade Certificadora do TRE-RO (registry.tre-ro.jus.br.crt) nos servidores de aplicação do TRE-AC para viabilizar a autenticação TLS e o download das imagens.
Proteção do Repositório Físico (Storage) : Durante a fase de testes em homologação ("Não SEI"), o volume do repositório de arquivos anexos deve ser montado no contêiner estritamente em modo Somente Leitura ( ro ) . Essa medida impede que rotinas automatizadas de limpeza executadas no ambiente de testes excluam acidentalmente arquivos da produção.
Equalização da Homologação (Staging) : Restauração integral da base de dados Oracle de produção em ambiente de homologação via BACULA/RMAN com dados atualizados (30/10/2026), garantindo que os testes reflitam a volumetria e as particularidades reais do órgão.
Simulação Assistida pré-Cutover : Execução do procedimento de migração de forma conjunta entre TRE-AC e TRE-RO em ambiente de homologação antes de qualquer intervenção no ambiente produtivo.
3. Mapeamento da Infraestrutura de TIC do TRE-AC
A execução do roteiro de atualização considera a topologia distribuída de tecnologia da informação do TRE-AC:

3.1 Edificações e Unidades Operacionais
Prédio Sede : Atendimento administrativo e operacional para 300 servidores.
Cartórios Eleitorais : 9 sedes de Cartório Eleitoral distribuídas nos municípios do Estado do Acre.
Postos e Centrais : 15 Postos de Atendimento Eleitoral (PAE) e 2 Centrais de Atendimento Eleitoral (CAE).
3.2 Comunicação de Dados e Conectividade
Rede Principal de Fibra Óptica : Circuitos fornecidos pela empresa "Sem Fronteiras", interligando as sedes dos Cartórios Eleitorais.
Rede de Satélite e Redundância : Links via satélite da empresa "Starlink", interligando todos os PAEs e atuando como mecanismo automático de backup para os links de fibra óptica.
3.3 Computação, Armazenamento, SGBD e Segurança
Virtualização e SO : Servidores físicos de alta capacidade (32 e 64 processadores/núcleos), gerenciados pelo hipervisor XEN rodando Linux Ubuntu.
Storage de Arquivos : 6 Torres de Storage espelhadas e interligadas por fibra óptica para sustentação do repositório de documentos anexos do SEI.
Bancos de Dados : Oracle Database 19c como SGBD principal de produção (hospedado em Máquina Virtual dedicada), suplementado por MySQL, PostgreSQL e MariaDB como bases secundárias.
Gestão de Backup : Gerenciador BACULA conduzindo rotinas diárias em disco e fita magnética (proteção contra ransomware), integrado a restaurações RMAN no Oracle.
Autenticação e Clientes : Servidor Active Directory (AD) integrado ao software Authelia para autenticação em duplo fator (2FA) e suporte a OIDC, atendendo a mais de 400 estações de trabalho com Windows 11 e mais de 400 usuários ativos.
4. Matriz de Atualização Tecnológica do SEI 5.0.5
A transição para o SEI 5.0.5 exige a substituição e parametrização dos componentes da pilha de aplicação:

Componente, Plataforma Anterior (SEI 4.0.12), Nova Plataforma (SEI 5.0.5), Requisitos de Configuração e Impactos Operacionais

Linguagem / Runtime, PHP 7.3, PHP 8.2 / PHP 8.4, "Habilitação do OPCache e JIT (opcache.jit=1254, jit_buffer_size=256M). Ajustes no código de módulos customizados para tratar Warnings do PHP 8."

Servidor Web / FPM, Apache 2.4 / PHP-FPM, Apache 2.4 / PHP-FPM, "Configuração no php.ini: short_open_tag=1, max_input_vars=1000, upload_max_filesize=200M, post_max_size=256M."

Mecanismo de Busca, Apache Solr 8.x, Apache Solr 9.6.1, "Requer Java 17. Conexão HTTPS com certificado Keystore PKCS12, autenticação de usuário (sei), e restrição de acesso via SOLR_IP_ALLOWLIST."

Conversão para PDF, JODConverter legado, JODConverter 4.4.8, Executado em contêiner dedicado com Java 17 e LibreOffice Headless (http://servidor_jod:8080/conversion?format=pdf).

Cache em Memória, Memcached 1.x, Memcached 1.6, Compartilhamento obrigatório de sessões de usuário entre os nós do SEI e do SIP na chave CacheSEI.

Editor de Texto, CKEditor 4, CKEditor 5, "Novo editor web responsivo com suporte a comentários por trecho, tabelas avançadas e links automáticos. Sem suporte ao corretor ortográfico pago (uso do corretor nativo)."

Gestão de Lixeira, Auditoria (Legado), Tabela lixeira nativa, Retenção temporária de conteúdos excluídos/cancelados por 45 dias (SEI_NUM_DIAS_LIXEIRA=45) com expurgo diário automatizado.

Framework Interface, Bootstrap 4.6.2, Bootstrap 5.3.1, "Suporte a tema escuro (""Cinza Escuro""), ajustes de leiaute e inclusão de recurso de arrastar e soltar anexos."

5. Roteiro Técnico Passo a Passo da Migração
5.1 Fase de Staging e Preparação do Ambiente "Não SEI"
Instalação do Certificado CA do Registry : Nos servidores do ambiente de homologação, instala-se a Autoridade Certificadora do TRE-RO para permitir autenticação no repositório Docker.
Restauração de Dados Oracle via RMAN : Restaura-se a cópia de produção do Oracle na instância de homologação. Em seguida, ajusta-se as URLs do SIP para refletir o endereço do ambiente de testes nas tabelas do sistema.
Mapeamento de Arquivos em Modo Somente Leitura : No arquivo de composição do Docker, o volume de armazenamento dos anexos é montado estritamente em modo de leitura (:ro).
5.2 Salto 1: Migração do SEI 4.0.12 para SEI 4.1.05
Download e Inicialização do Contêiner 4.1.5 : Obtenção da imagem correspondente no repositório e inicialização dos serviços.
Execução dos Scripts de Banco de Dados : Com os serviços web do SEI e SIP ativos (necessário para resoluções WSDL internas), executa-se a sequência de atualização no console:
atualizar_versao_sip.php
atualizar_recursos_sei.php
atualizar_versao_sei.php
Validação de Logs : Verifica-se que a última linha de cada arquivo de log contém o marcador "FIM".
5.3 Salto 2: Migração do SEI 4.1.05 para SEI 5.0.5
Transição de Imagem para SEI 5.0.5v2 : Atualiza-se o arquivo de composição do Docker para apontar para a imagem final da versão 5.0.5.
Parametrização das Configurações :
Apontar CacheSEI para o Memcached 1.6 (porta 11211).
Configurar a chave Solr apontando para o servidor Apache Solr 9.6.1 com usuário sei e senha criptografada.
Configurar a chave JODConverter apontando para o serviço em contêiner.
Execução da Segunda Rodada de Scripts : Execução sequencial dos scripts atualizar_versao_sip.php, atualizar_recursos_sei.php e atualizar_versao_sei.php.
Tratamento de Exceções de Esquema (CNPJ) : Caso ocorra erro de conversão do campo CNPJ nas tabelas do SEI (transição de formato numérico para alfanumérico), executa-se o tratamento prévio orientado nas notas do TRF4 para limpeza ou conversão de registros inconsistentes antes de reexecutar o script.
6. Janela de Cutover e Operação em Produção
A virada oficial do ambiente produtivo deve ocorrer em janela de manutenção programada (final de semana), seguindo o fluxo cronometrado:

```
[ 1. Notificação e Bloqueio ] ──► [ 2. Backup Final RMAN/BACULA ] ──► [ 3. Execução dos Scripts 4.0->4.1->5.0 ]

│

[ 6. Liberação e Reindexação ] ◄── [ 5. Virada DNS / Proxy Reverso ] ◄── [ 4. Liberação Storage Read-Write ]
```

Aviso Formal e Congelamento (Data Freeze) : Notificação aos mais de 400 usuários. Ativação da tela de manutenção no arquivo de configuração do SEI.
Backup de Segurança Definitivo : Execução de backup completo da base Oracle via RMAN/BACULA e geração de Snapshot no hipervisor XEN da máquina virtual de aplicação.
Execução Sequencial Oficial : Aplicação consecutiva dos scripts de atualização (4.0.12 ➔ 4.1.05 ➔ 5.0.5) sobre a base oficial de produção.
Ajuste de Permissões no Storage : Remoção da restrição de leitura e restabelecimento do acesso em modo Leitura e Escrita no volume das 6 Torres de Storage.
Virada de Infraestrutura e Liberação : Alteração das regras do Proxy Reverso/HAProxy para direcionar o tráfego HTTPS interno e externo aos novos contêineres do SEI 5.0.5. Desativação do modo de manutenção.
7. Pós-Migração, Reindexação Solr 9.6.1 e Serviços Integrados
7.1 Reindexação Massiva Paralela no Solr 9.6.1
Para evitar lentidão no banco de dados e acelerar a construção do novo índice de pesquisa textual no Solr 9.6.1, a reindexação deve ser disparada por linha de comando, dividida em instâncias paralelas por intervalos temporais (utilizando o script indexacao_protocolos_completa.php em segundo plano para faixas de anos).

7.2 Ativação do Módulo SEI Federação
Habilitação do parâmetro 'Federacao' => array('Habilitado' => true).
Validação da rotina agendada processarFederacao no SIP (execução a cada 5 minutos).
Cadastro do CNPJ do TRE-AC no menu Administração / Instalações Federação do SIP, permitindo o envio e recebimento de processos administrativos com o TRF4, TRE-RO e Tribunal Superior Eleitoral.
7.3 Diretriz de Módulos e Pesquisa Pública
Módulo de Pesquisa Pública : Para mitigar riscos de exposição indevida de documentos e minutas em elaboração, mantém-se a configuração estrita do módulo para exibir exclusivamente os andamentos processuais , sem liberação do conteúdo dos arquivos anexos.
Módulos Adicionais e IA : Em alinhamento com as recomendações de segurança, recomenda-se a manutenção da menor quantidade possível de módulos de terceiros (como os módulos de IA não oficiais da Anatel), aguardando as soluções oficiais desenvolvidas pelo TRF4 para evitar pontos de vulnerabilidade no sistema.
8. Engenharia de Qualidade, Matriz de Riscos e Protocolo de Rollback
8.1 Matriz de Riscos e Mitigações
Evento de Risco, Impacto, Probabilidade, Estratégia de Mitigação

Exclusão de arquivos no Storage durante testes, Crítico, Baixa, Montagem do volume de arquivos obrigatoriamente como Read-Only no ambiente de homologação.

Falha de execução dos scripts SQL de migração, Alto, Média, Execução prévia do procedimento em Staging; criação de Snapshot da VM no XEN e backup RMAN antes do Cutover.

Incompatibilidade de Certificados SSL/TLS no Docker, Média, Média, Instalação da CA do Registry do TRE-RO no diretório de certificados dos servidores locais.

Indisponibilidade ou sobrecarga do Apache Solr, Médio, Baixa, "Isolamento do serviço em servidor dedicado com Java 17, limite de memória JVM ajustado e IP Allowlist."

8.2 Protocolo de Garantia de Integridade dos Dados
Antes e imediatamente após a migração, a equipe de Banco de Dados deve executar e comparar as consultas quantitativas no Oracle Database (COUNT(*) em PROCEDIMENTO, DOCUMENTO, ASSINATURA, ANDAMENTO, USUARIO).

Critério de Aceitação : A variação entre a base de origem e a base migrada deve ser exatamente ZERO .

Para validação da integridade dos arquivos anexos no Storage, executa-se a checagem criptográfica por amostragem via hash SHA-256.

8.3 Plano de Rollback Automático
Se durante a janela de Cutover for identificada falha irrecurable na atualização do banco ou na inicialização dos contêineres:

Comutação de Rede : Reverter o apontamento do HAProxy/Proxy Reverso para os contêineres do SEI 4.0.12 (Ambiente Blue).
Restauração do SGBD : Restaurar a base Oracle a partir da cópia fria realizada no BACULA/RMAN imediatamente antes do início da janela.
Tempo Estimado de Rollback : Menor que 30 minutos.
