# Migração estrutural do Solene para fazer parte do Eco-Sistema Crepúsculo

Para compatibilizar e integrar plenamente as funcionalidades do Ecossistema Crepúsculo ao projeto SOLENE – Gestão de Cerimonial, o desenvolvimento deve seguir a premissa arquitetural de derivação e reuso corporativo estabelecida nas diretrizes do Tribunal Regional Eleitoral do Acre (TRE-AC).
O SOLENE não deve ser tratado como uma aplicação isolada, mas sim como um módulo especializado derivado da Plataforma Presença dentro do ecossistema corporativo Crepúsculo

## Diretriz fundamental
1. A Premissa Máxima: "Fonte Única da Verdade";
    1.1, A arquitetura do Crepúsculo estabelece que não devem existir cadastros paralelos ou redundantes de pessoas, eventos ou registros de frequência;
    1.2 Reuso da Entidade Pessoa: O SOLENE não possui base própria de cadastro de pessoas, pois, consome a entidade corporativa Pessoa mantida pelo ecossistema Crepúsculo (que já contempla magistrados, servidores, colaboradores, estagiários, autoridades externas e voluntários do autocadastro);
    1.3 Entidade Central Presença: O registro de comparecimento físico pertence ao domínio corporativo Presença;
    1.4 O SOLENE estende essa entidade por meio da tabela relacional ParticipanteEvento, agregando exclusivamente os metadados protocolares necessários

2. Módulos do Ecossistema Crepúsculo Incorporados ao SOLENE  
Para trazer o potencial completo do Crepúsculo para o SOLENE, o sistema orquestra e estende os seguintes componentes corporativos:  
    2.1 *Módulo Presença* (Fundação Operacional): Compartilha a gestão básica de eventos, convites, confirmações de comparência, check-in e consolidação de listas de frequência em tempo real;  
    2.2 *Módulo Visite* (Segurança Institucional Ativa): No momento do credenciamento (via CPF ou leitor de QR-Code), o SOLENE aciona a API do sistema Visite para checar restrições de acesso ou impedimentos. Se houver restrição, o sistema gera alertas silenciosos de segurança para o console da Segurança Institucional sem expor o convidado na recepção  
    2.3 *Módulo Autocadastro de Voluntários e Externos*: Utiliza a infraestrutura de links públicos e hashes seguros do Crepúsculo para que o próprio participante confirme sua presença, atualize dados pessoais e cadastre seus Acompanhantes (seguranças, assessores, motoristas e familiares);  
    2.4 *Módulo Notificações*: Gerencia a expedição eletrônica de convites individuais ou em lote e o envio automatizado de confirmações e comprovantes de credenciamento;  
    2.5 *Autenticação Corporativa e ACL Dinâmica (Authelia / SSO)*: O SOLENE adota o mecanismo de SSO corporativo via headers (Remote-User, Remote-Groups), utilizando controle de acesso dinâmico por perfis (SOLENE-ADMIN e SOLENE-ORGANIZADORES)









1. Os contratos de infraestrutura, de segurança, suas regras e diretrizes que orientam o Eco-Sistema Crepúsculo se sobrepõe às diretivas locais definidas no projeto Solene;
2. As regras de acesso e de segurança do Eco-Sistema Crepúsculo se sobrepõe às diretivas locais definidas no projeto Solene;
3. A interoperabilidade entre os projetos: "Presença", "AutoCadastro", "Elo", "SGRH",  são essenciais para manter as funcionalidades da aplicação;
4. O Crepúsculo possui as funcionalidade: funcionalidade_acesso_seguranca.md; funcionalidade_cadastro_eleitoral_agendamento.md; funcionalidade_colaboradores_eleitorais_voluntarios.md; funcionalidade_supervisores_predio.md; funcionalidade_diarias_passagens.md; funcionalidade_disque_eleicao.md; funcionalidade_lda_logistica_transmissao.md; funcionalidade_convocacao_sms.md; funcionalidade_planejamento_macroprojetos.md; funcionalidade_gestao_riscos.md; funcionalidade_gestao_tarefas_alertas.md; funcionalidade_treinamentos_mesarios.md; funcionalidade_locais_votacao.md; funcionalidade_forcas_seguranca.md; funcionalidade_servicos_auxiliares_e_modulo_publico.md, deverão estar compatibilizadas, no que couber, às funcionalidade do Solene;


## Cessão das funcionalidades do Solene
1. As regras de acesso e perfil serão herdadas do Eco-Sistema Crepúsculo;
2. A estrutura da base de dados: UML, MER, deverão ser compatibilizadas e sincronizadas com as bases do Eco-Sistema Crepúsculo;
    2.1 Preferencialmente as definições de variáveis, atributos e nome de tabelas se sobrepõe às inicialmente definidas na programação do Solene;

## Persistência das regras do Solene
1. A identidade visual do Solene se suprepõe às definidas pelo Crepúsculo;  
2. A estrutura de iconografia, estilo visual e cores do Solene se suprepõe às definidas no Crepúsculo;  
3. Serão adicionadas as **Funcionalidades que deixarão a ferramenta Solene mais completa para uso**.  
4. Camada de Especialização Protocola do SOLENE  
Sobre a base herdada do Crepúsculo/Presença, o SOLENE agrega as regras de negócio exclusivas da liturgia do Judiciário:  
* 🏛️ Ordem Geral de Precedência (Decreto Federal nº 70.274/1972): Algoritmo automatizado para ordenação hierárquica da Mesa de Honra e assentos  
* 📜 Atos Eleitorais Específicos (Resolução TSE nº 23.677/2021): Fluxos especializados para cerimônias de posse de magistrados e diplomação dos eleitos  
* 🎨 Classificação por Cores Funcionais: Mapeamento visual do plenário e entrega de cartões de identificação por categorias (🔴 Vermelho para Desembargadores, 🔵 Azul para Autoridades Externas, 🟢 Verde para Homenageados/Diplomandos e 🟡 Amarelo para Convidados Gerais)  
* 🎙️ Motor de Nominatas Incrementais: Geração de nominatas geridas exclusivamente pelo cerimonialista, marcando autoridades já anunciadas em cinza itálico e novas chegadas em vermelho em destaque  
* 📁 Memória Institucional e Atas: Bloqueio pós-encerramento do evento (regra RN-005) e geração do acervo histórico permanente com Atas e Certidões em formato PDF/A.

# Funcionalidades que deixarão a ferramenta Solene mais completa para uso.

## Dashboard Principal
1. O dashboard padrão apresentará os eventos Institucionais existentes em formato "selo";
    1.1 Os eventos em andamento serão mostrados em cores vivas;
    1.2 Os eventos já encerrados serão mostrados em cores opacas;
    1.3 Os eventos serão mostrados em ordem de data decrecente;
2. O evento será vinculado a unidade Institucional do usuários que o criou;
    2.1 Qualquer membro da unidade Institucional poderá administrar o evento;

## Dashboard Administração
1. As funcionalidades que compõe o painel de administração poderão ser criadas, alteradas ou excluídas a qualquer momento;
    1.1 O administrador poderá alterar a cor do selo de descrição de evento;
2. Fazem parte do painel de Administração:
    2.1 Criar Evento;
        2.1 Grupo protocolar, quando houver;
        2.1.1 Mesa de honra (cor preta);
        2.1.2 Desembargadores (cor vermelha);
        2.1.3 Juízes (Cor azul);
        2.1.4 Ministros e Representantes de Estado (cor lilás)
        2.1.5 Autoridades e Secretários (Cor verde);
        2.1.6 Procuradores, promotores e defensores (cor Amarela);
        2.1.7 Homenageados (cor roxo);
        2.1.8 Convidados e acompanhantes do homenageado (cor bege);
        2.1.9 Convidados (cor cinza);
    2.2 Acessos;
        2.2.1 Unidade Institucional recebida do SSO Authelia;
            2.2.10 o perfil "solene" será atribuído a todos os servidores;
            2.2.11 o perfil "solene_auditor" será vinculado à unidade COAUD e as seções que a compõe;
        2.2.2 Somente o membro da unidade terá acesso de administrador do evento;
        2.2.3 Todos os servidores poderão visualizar os eventos;
    2.3 Locais;
    2.4 Categorias de evento, quando houver;
        2.40 Audiência Pública;
        2.41 Diplomação;
        2.42 Evento Institucional;
        2.43 Homenagem;
        2.44 Palestra;
        2.45 Posse;
        2.46 Reunião;
        2.47 Seminário;
        2.48 Solenidade;
    2.5 Órgãos;
        2.5.1 A existência de órgão é pré-requisito para a inclusão de cargos;
    2.6 Cargos;
        2.6.1 O cargo designa a posição da autoridade no Órgão;
    2.7 Convites exigência legal;
        2.7.1 A ordem é fator preponderante para a geração de nominata;
    2.8 Vinculação de Autoridades (pessoas e cargos);
        2.8.1 O convidado será vinculado ao cargo e órgão;
    2.9 Formas de tratamento;
        2.9.1 A pré-existência de pronome de tratamento em grupos baseados no cargo e título:
            2.9.10 Vossa Excelência (V. Ex.ª): Usado para altas autoridades do Estado (Presidente da República, ministros, governadores, deputados, senadores, juízes e embaixadores);            
            2.9.11 Vossa Senhoria (V. S.ª): Usado para autoridades de escalão intermediário, diretores de autarquias, chefes de repartições e na correspondência comercial em geral;
            2.9.12 Vossa Excelência: Usado para juízes de direito;
            2.9.13 Vossa Excelência Reverendíssima (V. Ex.ª Rev.ª): Usado para arcebispos e bispos;
            2.9.15 Vossa Reverência (V. Rev.ª): Usado para padres, pastores e sacerdotes em geral;
            2.9.16 Vossa Magnificência (V. Mag.ª): Usado para reitores de universidades;
    2.10 Funções de equipe
        2.10.1 As funcionalidades pré-existente serão:
            2.10.10 solene_adm;
            2.10.11 solene_org;
            2.10.12 solene_recepção;
            2.10.13 solene_apoio
            2.10.14 solene_orador
            2.10.15 solene_condução_fila

## Dashboard recepcionista
1. O recepcionista função "solene_recepção" registrará o "Check-in" do convidados; 
    1.1 O "Check-in" será realizado pela ação de mudança do status "Ausente" do convidado;
        1.1.2 A qualquer momento o recepcionista poderá mudar o status de "Check-in"; 
2. A relação de convidados estará separada em presentes: parte superior e ausentes: parte inferior;
    2.1 Após a ação "Check-in", o nome do convidado será direcionado a parte de referência;
    2.2 A relação de presentes estará na parte superior da tela;
3. As colunas da relação de convidados poderão ser ordenadas;
4. Será possível adicionar convidados durante a realização do evento;
5. Será possível adicionar ocorrências durante a realização do evento;

## Criação do evento
1. O servidor que criar o evento será seu Administrador;
    1.1 A ferramenta deve ser capaz de importar a configuração e convidados de eventos encerrados;
        1.1.1 A personalização dos recursos de administração estarão vinculados a sua categoria pré-definida;
    1.2 As funcionalidades do painel de administração poderão ser criadas, alteradas ou excluídas a qualquer momento;
        1.1.1 Criar Evento;
        1.1.2 Acessos;
        1.1.3 Locais;
        1.1.4 Categorias de evento pré-existentes;
        1.1.5 Órgãos;
        1.1.6 Cargos;
        1.1.7 Convites exigência legal;
        1.1.8 Vinculação de autoridades (pessoas e cargos);
        1.1.9 Formas de tratamento (pronomes e vocativos);
        1.1.10 Funções de equipe;
2. A ferramenta deve ser capaz de orientar o criador, indicando através de infográfico como deverão ser inseridos os pré-requisitos de usabilidade:
    2.1 Grupo protocolar;
    2.2 Definição do grupo de acesso;
    2.3 Definição de Local;
    2.4 Categorias de Evento;
    2.5 Órgãos;       
    2.6 Cargos;
    2.7 Convites exigência legal;
3. Os recursos que possibilitam a alteração do evento estarão inabilitadas após o encerramento do evento;

## Controle da ocupação do ambiente 
1. A ferramenta deverá conhecer a capacidade total de ocupação do espaço;
    1.1 O administrador informará a capacidade de ocupação total do ambiente, conforme o "Lugares por grupo";
        1.1.1 A quantidade de assentos disponíveis do ambiente;
            1.1.10 A quantidade de assentos é caracterizada pelo somatório de todos os grupos definidos;
        1.1.2 A quantidade de pessoas que podem se acumular no ambiente;
            1.1.20 A quantidade de ocupantes é caracterizada pela quantidade de assentos adicionada a quantidade ocupantes no ambiente;
    1.2 O administrador classificará em grupos a ocupação do ambiente, conforme a ordem que julgar pertinente;
        1.2.1 O Administrador poderá criar, alterar, excluir os grupos de acesso a qualquer momento;
    1.3 O administrador poderá criar classes e grupos conforme a necessidade de divisão do espaço do ambiente;
        1.3.1 A ferramenta informará a diferença entre a quantidade de ocupação total e a somatória de assentos por grupos;
2. A ferramenta deverá ser capaz de obter a quantidade de participantes que realizarem o credenciamento;
    2.1 A confirmação da quantidade de credenciados virá da compilação do total de ingressantes, seja inclusão ou atualização individual identificados no "AutoCadastro";
    2.2 Informará o quantitativo por classificação e grupos em número e seu percentual;
    2.3 Informar o percentual de "over book", para assentos e total de ocupação de pessoas no ambiente;

## Painel de acompanhamento do evento
1. A ferramenta deverá ser capaz de consolidar em um painel os registros de definição e gestão da ocupação do amebiente;
    1.2 O painel deverá consolidar as quantidades protocolares definidas pelo Administrador;
    1.3 Para o Perfil de Administrador, além dos quantitativos e percentuais, será adicionada a relação de ocupantes de cada grupo;
    1.4 Para o grupo "Mesa Diretora", ao se passar o mouse na figura será mostrado o nome relacionado
        1.4.1 A ordem de visualização será a de maior antiguidade, conforme as normas definidas pelo Tribunal de Justiça;
2. A ferramenta deve ser capaz de informar o percentual de evolução de credenciamento;
    2.1 Demonstrar em linha temporal de evolução, relacionando:
        2.1.1 Quantitativo de credenciamentos;
        2.1.2 Relação entre a data de realização do evento com o percentual evolutivo de credenciamento;
3. Alerta de aproximação
    3.1 A ferramenta deve ser capaz de sinalizar a aproximação;
    3.2 Será considerado crítico o percentual de 40%;
    3.3 O Administrador definirá quais são fatores a serem monitorados;
        3.3.1 Quantidade de credenciamentos;
        3.3.2 Credenciamento de dirigentes do evento;
        3.3.3 Sempre que existir, o credenciamento de:
            3.3.30 Autoridades;
            3.3.31 Homenageados;
            3.3.32 Impressa;
        3.3.4 Data de realização do evento;
    3.4 A ferramenta deve ser capaz de enviar email de confirmação aos convidados que efetuaram o credenciados
        3.4.1 A ferramenta poderá enviar alerta SMS, com antecedencia pré-definida, da realização do evento aos convidados;

## Definição de perfil de uso
1. Todos os servidores podem criar eventos, sem restrição de quantidade;
    1.1 A ferramenta irá atribuir ao criador do evento o perfil de Administrador;
    1.2 O grupo do servidor terá acesso exclusivo de Administrador ao evento;
    1.3 O Administrador terá permissão para personalizar seu evento: criar, alterar ou modificar os grupos, parâmetros de definição e programação;
2. O administrador captará voluntários para atuarem nas funções organizacionais;
    2.1 Qualquer servidor poderá se voluntariar;
    2.2 A funcionalidade de captação de voluntários será herdada do Eco-Sistema Crepúsculo;
3. O administrador deferirá a inscrição do voluntário;
    3.1 O administrador distribuirá as funções entre os inscritos deferidos;
    3.2 O administrador poderá incluir, alterar ou excluir o inscrito a qualquer momento;

## Atividades pré-definidas do perfil de funções  
1. A função de administrar é característica do administrador  
    1.1 O servidor com perfil **solene**, originário do SSO/Authelia, que for da mesma unidade Institucional do criador:  
        1.1.1 Herdará as funcionalidades atribuídas ao criador do evento;  
        1.1.2 Terá acesso a todas as funcionalidades do evento;  
2. O perfil **solene_org**;  
    2.1 Poderá incluir e enviar convites;  
    2.2 Poderá alterar os conteúdos dos: Grupo protocolar, Locais, Órgãos, Cargos, Convites exigência legal, Vinculação de Autoridades, Formas de tratamento;  
    2.3 Incluir, alterar, excluir, mover registros do protocolo;  
    2.4 Poderá gerar extração de registros;  
    2.5 Poderá gerar ATA;  
    2.6 Poderá gerar certidão encerramento;  
    2.7 Poderá exportar documentos para o SEI;  
    2.8 Poderá pré-definir data, hora e envio de mensagens, seja por e-mail ou sms, aos convidados e equipe organizacional;  
    2.9 Poderá criar instruções e roteiros vinculando-os ao perfil destinatário;  
3. O perfil **solene_recepção**;  
    3.1 Poderá realizar o "check-in" de convidados (presente ou ausente);  
    3.2 Poderá incluir e enviar convites;  
    3.3 Poderá incluir ocorrências do evento;  
4. O perfil **solene_apoio**;  
    4.1 Poderá receber Instruções e roteiros;  
5. O perfil **solene_orador**;  
    5.1 Poderá gerar a nominata;  
6. solene_condução_fila;  
    6.1 Poderá receber Instruções e roteiros;  

## Tempo de vida do evento
1. O evento terá data de início e fim;  
    1.1 É possível salvar a versão de rascunho ou preparação do evento;  
        1.1.1 É versão de rascunho, quando os registros forem importados de outro evento encerrado;  
        1.1.2 É versão de preparação, quando o evento é de nova categoria ou modelo recém creiado;  
2. O evento pode ser excluído enquanto estiver no modo de rascunho ou preparação;  
    2.1 O evento deixará de ser rascunho ou preparação quando forem enviados os convites;  
        2.1.1 A aplicação deve ser capaz de enviar um e-mail de cancelamento do evento sempre que for excluído ou cancelado;  
3. Não será possível excluir o evento após o início do credenciamento;  
    3.1 O primeiro credenciamento caracteriza o início do evento;  
    3.2 O evento será encerrado, quando houver a ação de cancelamento ou exclusão;
4. O evento poderá ser arquivado após a data de realização ou seu encerramento;  
    4.1.1 Os metadados do evento arquivado estarão disponíveis para exportação para o Archivemática Institucional;  
    4.1.2 O administrador ou organizador poderá processar a ação de exportação do evento;  

## Amproveitar dados existentes
1. Será possível criar o evento com registros originados de outros eventos encerrados ou arquivados;
    1.1 A ferramenta poderá listar outros eventos e suas características;
    1.2 O evento de rascunho será criado com registros existentes de outros eventos;

## Encerramento do evento
1.  Gerar a ATA de encerramento;
    1.1 A ATA seguirá o padrão de documentos oficiais, formada pelos registros de inserção no SEI;
        1.1.1 Conterá os cabeçalhos das listas de convite;
        1.1.2 Conterá o cabeçalho da lista de presentes;
        1.1.3 Conterá o cabeçalho do protocolo;
        1.1.4 Conterá registros realizados durante a realização do evento;
2. Gerar a certidão de encerramento;
    2.1 A certidão de encerramento seguirá o padrão de documentos oficiais;
        2.1.1 breve anotação histórica do evento e avaliação do responsável;
    2.2 A certidão subsidiará o encerramento do evento;
        2.2.1 poderá ser em data posterior ao evento;
3. Inserção de registros e documentos no SEI;
    3.1 A lista de convidados;
        3.1.1 A relação de convidados, data e hora, identificação do convite;
        3.1.2 O modelo do convite enviado;
    3.2 A lista de comparecimento;
        3.2.1 A relação de presentes, data e hora de "check-in";
    3.3 O protocolo seguido;
    3.4 A nominata, em ordem de pronunciamento;
    3.5 A certidão de encerramento;
    3.6 A inserção dos registro e documentos serão precedidos da:
        3.6.1 da identificação do usuário e senha;
        3.6.2 da unidade que tem acesso ao procedimento;
        3.6.3 do número do procedimento SEI;

## Protocolo de validação do evento
1. O evento será iniciado conforme o "protocolo oficial";  
    1.1 O administrador ou organizador executará a ação de início, mediante mensagem de convalidação de início;  
2. A nominata será gerada, quando solicitada pelo perfil **solene_orador**;
    2.1 A nominata exige que o "Check-in" seja iniciado;  
        2.1.1 O "Check-in" é caracterizado pela presença de pelo menos um convidado;  
        2.1.2 A ferramenta deverá alertar o orador sobre o número de dirigente, autoridade, homenageados, e demais presentes;  
        2.1.3 A nominada será gerada pelo orador após o início do evento;  
        2.1.4 A ferramenta deverá alerta o orador da emissão da ultima ou ultimas nominatas;
3. A presença será registrada através do "Check-in" individual;  
    3.1 A presença será registrada após o início do evento;  
    3.2 A ferramenta deve ser capaz de armazenar a presença individual;  
    3.3 A ferramenta deve ser capaz de alterar o status de presença (presente versos ausente);  
    3.4 A ferramenta encaminhará em lote os registros dos presentes ao final do evento;  
        3.4.1 O final do evento é pré-definido pelo Administrador;  
        3.4.2 O lote de presença é submetido as regras do sistema "Presença";  
    3.5 Permanecerá em destaque o convidado que ainda não estiver presente;  
    3.6 A relação de convidados poderá ser ordenada por suas colunas;  
4. O encerramento exige a geração da nominata;  
    4.1 A ação de encerramento propciará a execução do "Encerramento do evento";  

## Definição do protocolo oficial
1. A **Gestão de conteúdo** do protocolo será uma seção da Administração do evento  
    1.1 O criador do evento incluirá o conteúdo informativo de protocolo a ser seguido;  
2. O protocolo seguirá o formato de formulário com linhas, com:  
    2.1 data;  
    2.2 horário;  
    2.3 tempo de apresentação;  
    2.4 responsável;  
    2.5 descrição da atividade;  
3. O formulário será identado na ordem crescente de data e hora;  
    3.1 O formulário permitirá a criação, alteração, remoção e reposicionamento sequencial de suas linhas;  
4. O protocolo estará disponível para novos registros após iniciado o evento;  
    4.1 A linha de formulário do protocolo estará disponível para preenchimento ao final da tela de "check-in";   
    4.2 Terá a Capitulação "Registros e Ocorrências"  
    4.3 Será criada um seção de identificação do início do evento, denominada "Registros e Ocorrências";  
        4.3.1 A data e hora serão obtidas do sistema operacoinal;  
        4.3.2 O campo "descrição da atividade" será de preenchimento obrigatório;  
        4.3.3 O campo "responsável" será preenchido com a identificação de quem efetuou o registro;  
        4.3.4 Os demais campos serão opcionais;  
    4.4 Qualquer membro da equipe poderá registrar informação;  
    4.5 O protocolo não aceitará registros após a emissão da certidão de encerramento;  
5. O administrador ou organizador poderá criar arquivos de coneúdo;
    5.1 Os textos poderão ser vinculados aos perfis organizacionais;

## Definição Convite
1. O convite é de característica precedente do Credenciamento;
    1.1 O convite será enviado majoritariamente por e-mail;
        1.1.1 A aplicação será capaz de enviar convite a mais de um endereço de email simultaneamente;
        1.1.2 A aplicação será capaz de enviar convite a e-mail de grupos;
        1.1.3 A aplicação será capaz de receber a notificação de mensagem entregue (viabilizar a integração das funcionalidades de entrega da mensagem);
2. O convite conterá a descrição detalhada do evento proposto;
    2.1 
3. O convite poderá ser compartilhado ou de grupo;
    3.1 O convidado poderá compartilhar o convite com àqueles que forem:
        3.1.1 Lhe representar;
        3.1.2 Lhe acompanhar;
        3.1.3 Lhe substituir;
    3.2 O convite compartilhado terá vinculação com aquele que o compartilhou;
    3.2 O convite enviado a e-mail de grupos entregará o link de "AutoCadastro";
    3.3 O convite compartilhado ou de grupo estará submetido ao credenciamento individualizado, sob as regras do "AutoCadastro";

## Definição de extração e importação de registros parametrizados
1. A exportação de registros conterá:
    1.1 Identificação Institucional [Tribunal Regional Eleitoral do Acre];
    1.2 Título do evento [Nome do Evento];
    1.3 Descrição do evento [Descrição];
    1.4 Local do Evento;
    1.5 Categoria;
    1.6 Data e hora;
    1.7 grupo protocolar: Compilação dos registros que personalizam o evento
    1.8 Registros: [Nome], [Titulação], [Cargo], [Presença]
2. A aplicação poderá exportar os registros nos formatos parametrizados;
    2.1 Os formatos reconhecidos para extração serão: 
        2.1.1 Markdown (md);
        2.1.2 Comma-Separated Values (CSV);
        2.1.3 Microsoft planilhas (XMLX);
        2.1.4 Portable Document Format (PDF);
3. A aplicação deverá ser capaz de importar arquivos no formatado CSV;
    3.1 A aplicação informará o leiaute a ser recebido na importação;
4. A aplicação será capaz de gerar a Etiqueta de identificação dos presentes;
    4.1 O papel de fundo será o tema da aplicação;
    4.2 O formato será previamente definidor pelo Administrador;

## Auditoria
1. O perfil de auditoria será herdado da unidade COAUD e suas unidades (SSO/Authrlia);
2. A auditoria terá permissão de "extração e importação de registros parametrizados"
3. A auditoria tera acrecida a exportação de registros de log;
    3.1 Serão acrecidos os registros: desde a criação ao encerramento;
    3.2 Serão acrecidos os registros de "Histórico do convite";

## Capacidade por grupo protocolar
1. O Ambiente será dividido em grupos
    1.1 O dimensionamento do grupo fará parte da Administração do evento
        1.1.1 O grupo poderá ser criado, alterado, ou excluído;
        1.1.2 A quantidade que compõe o grupo poderá ser alterada a qualquer momento;

## Padrão de comportamento das telas
1. A relação sempre permitirá a ordenação por suas colunas;
2. A barra superior será composta por:
    2.1 À esquerda o logotipo "Solene";
    2.2 Ao centro a identificação do evento;
    2.3 À direita a identificação do usuário e seu perfil;
    2.4 Ao lado esquerdo do "identificação do usuário e seu perfil" a opção Administração;
3. A ação de "Avanço" e "Retorno" de telas sempre devem obdecer a origem e hierarquia da estrutura;
    3.1 Em todas as telas será mostrada a ação de "Avanço" e "Retorno" relativa a posição;
    3.2 A ação de "Avanço" e "Retorno" será representada apenas pela seta de direcionamento;
    3.3 A ação de avanço estará no canto superior direito;
    3.4 A ação de retorno estará no canto superior esquerdo;
4. O resumo do evento estará centralizada na parte superior da tela entre a posição de setas direcionais;
5. No canto superior esquerdo, ao lado da "identificação do usuário e seu perfil" será mostrado "os três pontinhos";
    5.1 "os três pontinhos", quando acionado, apresentará as funcionalidades da aplicação;

# Correções de telas na versão atual:
* Corrigir o mapa de caracteres que aparece na na tela: ¿ 
* As telas de Administração estão fora do pradrão de CSS
* Buscar a ordem de precedência dos convidados junto às normas do TJ/AC
    * Mesa diretora
    * Convidados
    * Autoridades
    * Mesa de Honra
* A tela de edição deverá habilitar a mudança posicional de ordem ou sequência;
* Incluir a caixa de digitação de texto para os campos onde as opções de escolha forem maiores que 10 registros;
* Os botões: Avanço, Volta, permanencem na barra superior, sempre presentes apesar da rolagem da tela;


# Desafio
1. Identificar autoridades 
    1.1 busca por API ou bases públicas atualizadas;
2. Lista de desembargadores, juízes e homenageados vivos;
    2.1 A ordem de visualização será a de maior antiguidade, conforme as normas definidas pelo Tribunal de Justiça;
3. Adicionar o infográfico de parametrização do evento

# Relatório de uso da versão Beta

1. Falha no treinamento das equipes operacionais;
    1.2 Inexistiu treinamento de equipes;
2. Testes e avaliação de homologação;
    2.1 inexistiram os testes e avaliação com a versão;
    2.2 
3. Perfil de acesso;
    3.1 Apenas os servidores previamente credenciados puderam acessar a aplicação;
4. Imersão da equipe operacional;
    4.1 Inexistiu a interação da equipe operacional com a ferramenta antes do evento;
5. Cumprimento dos pré-requisitos exigidos
    5.1 Inexistiu o convite para autoridades e demais conviddos;
    5.2 Fixação na relação de exigidos em norma
    
# Registro sob a ótica do servidor Felipe Bezarra

# Problemas na implantação do Solene em produção - Posse do Des. Samoel Evangelista
Este documento relata os problemas que impediram a implantação e funcionamento integral do Solene em produção a tempo para a sessão solene de posse do Des. Samoel Evangelista, no dia 18/09/2026. Ele engloba as etapas de pré-implantação que foram puladas ou não definidas, o treinamento e testes apropriados para compreensão do fluxo pela equipe do cerimonial, e as falhas internas e externas não previstas que comprometeram a funcionalidade do sistema na hora do evento.

---
## Os problemas que só apareceram em produção - por grau de seriedade
### 1. Os tablets da rede de visitantes não marcavam presença

**O que se via:** durante a solenidade, quem estava com tablet conectado à
rede de visitantes do tribunal clicava em "presente" e recebia *"Não foi
possível atualizar a presença"*. Da rede interna funcionava normalmente. E, no
mesmo tablet que falhava, **adicionar** um convidado funcionava.

**Por quê:** o proxy daquela rede deixa passar os tipos de requisição mais
comuns (GET e POST) e **barra** os outros (PATCH e DELETE) — e marcar presença
usava PATCH. A mensagem era genérica justamente porque quem respondia não era
o Solene: a requisição nem chegava ao servidor. Os registros do Apache
confirmaram: nenhum PATCH vindo daqueles tablets.

**O que resolveu:** o sistema passou a mandar sempre POST, escrevendo o tipo
real da operação num parâmetro na URL (`_method`). É o mesmo truque que o
Laravel já usa nos formulários comuns.

### 2. Acentos e sinais especiais viraram `¿`

**O que se via:** nomes de órgãos e de pessoas com uma interrogação de cabeça
para baixo no meio — `OAB ¿ Seção do Acre`, `d¿Albuquerque`.

**Por quê:** o banco Oracle do tribunal não está configurado no formato de
texto mais completo (`AL32UTF8`). Acento comum (á, ç, ã) passa sem problema. O
que não passa são os sinais "tipográficos": o **travessão** (–, diferente do
hífen -), a **apóstrofe curva** (’, diferente da reta ') e as reticências (…).
Eles foram gravados errados e ficaram errados.

**O que resolveu:** parar de usar esses sinais — hífen simples e apóstrofe
reta em tudo — e corrigir os registros antigos **à mão**, pelo painel. Rodar os seeders de novo não funcionaria porque duplicaria os cadastros devido aos nomes diferentes.

### 3. A busca de colaboradores não encontrava quem tem acento no nome

**O que se via:** um colega chamado MÁRCIO JUCÁ DE OLIVEIRA existia na API
Pessoa e simplesmente não aparecia na busca do sistema. Nenhum erro — a lista
voltava vazia, como se a pessoa não existisse.

**Por quê:** a API Pessoa espera receber o texto da busca num formato de
caracteres antigo (ISO-8859-1), e nós mandávamos no formato moderno (UTF-8). O
"Á" que saía daqui não era o "Á" que ela procurava lá.

**O que resolveu:** converter o texto antes de enviar. E, por garantia, quando
o nome tem acento, o sistema faz **duas** buscas — com e sem acento — e junta
os resultados, porque a própria base tem "MARCIO" e "MÁRCIO" convivendo.

### 4. O credenciamento do Auto Cadastro não identificava os convidados registrados 

Para responder "esse CPF já está na lista de convidados desse evento?", o CadÚnico precisa ligar para o Solene — e para ligar, ele precisa saber a URL e o token que prova que a comunicação é mesmo com o CadÚnico. Esses dois dados ficam no .env (variáveis de ambiente), mas por questão de velocidade o sistema costuma guardar uma cópia rápida dessas informações na memória, em vez de reler o arquivo toda hora.

O problema: essa cópia rápida tinha sido feita num momento em que o endereço e a senha do Solene ainda estavam em branco. Depois, alguém preencheu o arquivo corretamente — mas o sistema continuou usando a cópia antiga, em branco, sem perceber que devia atualizar.

Então, toda vez que um visitante digitava o CPF no balcão, o CadÚnico tentava ligar para o Solene e perguntar "essa pessoa está na lista?" — mas, com a cópia em branco, nem sabia para onde ligar. E como o sistema foi desenhado para nunca travar o visitante por causa de uma falha de comunicação, ele sempre respondia "não sei, deixa eu tratar como se fosse desconhecida" — mandando a pessoa preencher o cadastro completo, mesmo já estando convidada.

**O que resolveu:** a correção foi mandar o sistema jogar fora a cópia antiga e reler o arquivo de verdade, onde o endereço e a senha já estavam certos.

---
## As falhas externas ao sistema
### 1. Falta de uso prático do sistema e avaliação de experiência do usuário

O sistema não foi testado em uma situação prática de controle de fluxo de evento, em ambiente simulado ou real. Testes práticos de uso amplo do sistema com tablets conectados na rede de convidados do tribunal teriam diagnosticado 100% das falhas que se sucederam na sessão solene do dia 18/09/2026.

É necessário segmentar as atribuições de desenvolvimento e testes do sistema entre a equipe de desenvolvimento e os usuários finais (equipe de cerimonial).
Os testes que ficaram em falta no sistema foram os seguintes:
- Testes exaustivos do front-end para identificar irregularidades no comportamento da interface e gargalos na experiência do usuário (gerais ou específicos para o uso de tablets).
- Testes de comunicação com o banco Oracle no ambiente de produção, com análise minuciosa dos logs. Os testes automatizados elaborados e executados pelo Claude, apesar de cobrirem muito do escopo do projeto, eram limitados por utilizarem uma arquitetura de banco de dados diferente e mais simplificada (SQLite) diferente e mais simplificada do que a de produção (Oracle).
- Teste de funcionamento dos webhooks de integração entre o Solene, o CadÚnico e o Presença, com análise minuciosa dos logs. De forma a garantir o funcionamento do Solene, o sistema não implementou nenhum bloqueio no fluxo caso algo na comunicação entre os sistemas falhassem, então a análise do retorno é essencial.

### 2. Falta de treinamento e experiência com as funcionalidades do sistema

Devido ao prazo apertado, não houve ampla oportunidade para treinamento prático e uso monitorado do sistema pelos usuários finais, a equipe do cerimonial. 

Na última reunião para averiguar o sistema, no dia 16, foi feita uma exposição rápida de toda a modelagem, e da maioria das funcionalidades prontas do sistema (CRUDS, criação de evento, registro de convidados, designação de representantes, confirmação de presença, visualização de assentos), mas não houve uma especificação sólida do fluxo de ações projetado para os usuários, nem foram sugeridos exercícios de uso do sistema para os usuários.

Para a próxima versão do sistema, podemos implementar um formulário de múltiplas etapas (wizard) para revisão dos dados que o sistema vai englobar (órgãos, cargos, convites obrigatórios, etc).

### 3. Não foram cadastrado todos os convidados previstos para o evento no sistema

O fluxo de credenciamento, levando em conta os dados necessários para registro, foi pensado de forma que o maior parte do montante de registros de convidados seriam feitos previamente ao evento, para que apenas a presença fosse marcada após confirmação visual pela equipe de recepção.

O que aconteceu foi que a maioria dos convidados que estavam confirmados para o evento não tinham sido inseridos no sistema para o controle, então até a solução paliativa, a geração da relação dos convidados em PDF, não se mostrou funcional.



