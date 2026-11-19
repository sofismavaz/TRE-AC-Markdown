# Descrição do cenário
. O Núcleo de segurança (NÚCLEO DE INTELIGÊNCIA, SEGURANÇA INSTITUCIONAL E  POLÍCIA JUDICIAL - NISIPJ), precisa registrar as possíveis ocorrências ao longo do expediente.
. Com a inexistência de um sistema que trate do tema, o Núcleo solicita que seja disponibilizado um formulário, cujo o objetivo é permitir o registro dos fatos, documentando e descrevendo as circunstância vivenciadas.
. A unidade SDBD está impossibilitada de agir em virtude de outras prioridades, mas solidária com a demanda, propõe adoção de um formulário eletrônico a ser construído no formato HTML, cujas informações estejam no formato JSON (com campo e registro), e podem ser encaminhadas no corpo da mensagem de email por um agente padrão do dispositivo móvel.

# Diretivas
. Diante do exposto, o conteúdo do formulário eletrônico deve ser adicionado ao corpo da mensagem de email
. O formulário conterá as instruções para chamar o agente padrão do disposito, seja móvel ou seja computador

# Expectativa do cliente
. Esta IA terá liberdade para criar o modelo proposto do formulário, adotando CSS e leiaute que torne-a intuitiva e agradável de se utilizar;
. Esta IA deve adotar cores que seja formais, neutras e que demonstrem a seriedade imposta pela utilização do recurso;
. Esta IA deve otimizar o conteúdo de registros em formato JSON, inserindo-o no corpo de mensagem de e-mail
. Esta IA deve criar o formulário com instruções para identificar e chamar o agente padrão de e-mail do dispositivo, seja ele móvel ou computador 

---

# Formulário de Ocorrências
. O título de formulário será: "BOLETIM DE OCORRÊNCIA DE SEGURANÇA INSTITUCIONAL"
. O Destinatório da mensagem de e-mail será: "OCORRÊNCIA DE SEGURANÇA"<4300@tre-ac.jus.br>
. O assunto da mensagem de e-mail será: "Natureza da ocorrência" + o conteúdo escolhido pelo requerente
. O corpo da mensagem de e-mail será: o conteúdo JSON compilado, objeto do frmulário preenchido

# Título
. BOLETIM DE OCORRÊNCIA DE SEGURANÇA INSTITUCIONAL
. Descrição: "Registro por Agentes de Polícia Judicial — NISIPJ/TRE-AC"

# Descrição da atividade
. A polícia judicial é responsável pela segurança institucional, e deverá ter fácil acesso ao formulário de registros de pssíveis cocorências ao longo da jornada de expediente do Tribunal.

# Necessidade
. criar um formulário de ocorrência a partir do formaulário do arquivo: Modelo_BOSI_NISIPJ_TRE_AC.docx;
. o arquivo deve ser croiado no formato html;
    . deve ser possível preencher os campos;
    . deve ser possível alterá-los antes de submeter para envio;
. O formulário será dividido por seções de afinidade;
. O formulário deve ser compatível com a utlização em computador e dispositivo móvel;

# características
. I — IDENTIFICAÇÃO DO REGISTRO
    . O campo "Nome do comunicante ou agente" será de conteúdo textual e de livre preenchimento;
    . O campo "Data/hora do registro" será no formato data e virá pre-prenchido com a data atual;
        . O conteúdo poderá ser alterado;
    . Os campos "Data e hora da ocorrência", "Horário de término", serão no formato data e hora, e virão pre-preenchido com a data e hora do preenchimento do formulário;
        . Os conteúdos poderão ser alterados;
    . O campo "Âmbito" será de multipla escolha:
        . os valores possíveis para preencimento são: "Interna", "Externa", "Operação eleitoral", "Segurança de autoridades"
        . preferencialmente deve ser mostrado em lista de escolha;
    . O campo "Local", ""endereço", "setor", "Município", "zona eleitoral", "Ordem de missão", "operação" serão de conteúdo textual e de livre preenchimento;
II — NATUREZA DA OCORRÊNCIA
    . O campo "Natureza" será de multipla escolha:
        . os valores possíveis para preencimento são: "Ocorrência com pessoa", "Trânsito", "deslocamento", "Incidente com arma", "Incidente com equipamento", "CFTV", "Alarme", "Controle de acesso", "Energia", "Incêndio", "Urna", "Material eleitoral", "Segurança de magistrado", "Solicitação de imagens", "Extravio", "Localização de material", "Suspeita de ilícito", "Outro";
        . preferencialmente deve ser mostrado em lista de escolha;
III — PESSOAS ENVOLVIDAS
    . O campo "Nome ou condição" será de conteúdo textual e de livre preenchimento;
    . O campo "Contato ou vínculo institucional estritamente necessário" será de conteúdo textual e de livre preenchimento; 
    . O campo "Contato ou vínculo institucional estritamente necessário" será de conteúdo textual e de livre preenchimento; 
IV — HISTÓRICO Ou DESCRIÇÃO OBJETIVA DOS FATOS
    . Será disposto o campo para livre descrição textual;
    . Apresentar a mensagem de instrução "Separar fatos presenciados, declarações de terceiros e informações ainda não confirmadas."
V — SOLICITAÇÃO, MOTIVO E RESULTADO PRETENDIDO
    . Será disposto o campo para livre descrição textual;
VI — MATERIAIS, DANOS, IMAGENS E OUTROS ELEMENTOS
    . Será disposto o campo para livre descrição textual;
    . O campo "Identificação ou localização dos arquivos ou materiais" será de livre descrição textual;
    . O campo "Responsável pelo recebimento ou preservação" será de livre descrição textual;
VII — PROVIDÊNCIAS ADOTADAS E COMUNICAÇÕES
    . O campo "Ações" será de multipla escolha:
        . os valores possíveis para preencimento são: "Proteção de pessoas", "Isolamento", "preservação", "Apoio policial", "Apoio médico" "Acionamento técnico", "Preservação de imagens", "Comunicação à chefia", "Outro";
        . preferencialmente deve ser mostrado em lista de escolha;
    . O campo "Cronologia" será de livre descrição textual;
    . O campo "Órgãos ouunidades acionados, e pessoa contatada e horário" será de livre descrição textual;
VIII — AVALIAÇÃO PRELIMINAR E ENCAMINHAMENTOS
    . O campo "Criticidade operacional" será de multipla escolha:
        . os valores possíveis para preencimento são: "Baixa", "Moderada", "Alta", "Crítica", "A avaliar"
        . preferencialmente deve ser mostrado em lista de escolha;
    . O campo Fundamentação objetiva do risco
    . O campo "Situação final" será de multipla escolha:
        . os valores possíveis para preencimento são: "Normalizada", "Sob acompanhamento", "Encaminhada", "Pendente"
        . preferencialmente deve ser mostrado em lista de escolha;
    . O campo "Destinatário, ou providências pendentes, ou responsável" será de livre descrição textual;
    . O campo "Nùmero do processo SEI" será de livre descrição textual;
    . O campo "Número do Boletim de Ocorrência Policial, ou OCORRE JE" será de livre descrição textual;
IX — ANEXOS E ASSINATURAS
    . O campo "Anexos" será de livre descrição textual;
        . os valores possíveis para preencimento são: "Fotografias", "Imagens CFTV", "Documentos", "Outros", "Nenhum"
        . preferencialmente deve ser mostrado em lista de escolha;
    . O campo "Relação de anexos e local seguro de armazenamento" será de livre descrição textual;
    . O campo "Demais agentes, ou matrículas" será de livre descrição textual;

Ao término de preenchimento, o requerente deve marcar que: "Revisei as informações e confirmo o encaminhamento."
somente após a escolha o conteúdo será anexado a mensagem para envio 
    
# Nota de Rodapé
    . Deverá mostrar "NOTA: Registro administrativo e operacional. Não substitui boletim policial, comunicação legalmente exigida ou registro no OCORRE JE, quando cabível. Dados e anexos devem circular apenas a destinatários autorizados."