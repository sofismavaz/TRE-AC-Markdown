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