# LEVANTAMENTO TÉCNICO E DOCUMENTAL PARA MIGRAÇÃO
## Projeto: Solene - Gestão de Cerimonial
**Volume:** 1  
**Data de Gerada:** 2026-09-20 15:55:32  
**Tamanho Máximo Alvo:** 500 KB  
**Extensões Incluídas:** md php  
**Plataforma de Destino:** Agente de Inteligência Artificial / LLM  

---

> **INSTRUÇÃO PARA O AGENTE DE IA:**  
> Este arquivo contém a compilação estruturada de arquivos do projeto **Solene - Gestão de Cerimonial**.
> Cada arquivo fonte está delimitado por tags estruturadas `<arquivo>`, contendo os metadados de localização (`<pasta>`, `<subpasta>`, `<nome_arquivo>`, `<extensao>`) e o bloco de código/texto em `<conteudo>`.
> Utilize estes metadados para mapear o modelo de dados, as regras de negócio e os fluxos de migração.

---


# ==============================================================================
# SEÇÃO TEMÁTICA POR EXTENSÃO: .md
# ==============================================================================

<arquivo>
  <pasta>raiz</pasta>
  <subpasta>raiz</subpasta>
  <nome_arquivo>CLAUDE.md</nome_arquivo>
  <caminho_completo>CLAUDE.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# CLAUDE.md

Orientações para o Claude Code neste repositório. Leia antes de mudar código.

## Visão geral

Solene Cerimonial — gestão de eventos e Nominata do TRE-AC. Reescrita em
Laravel do app original (Next.js + Firebase), espelhando a infraestrutura e o
modelo de autenticação do projeto **bena**.

**Stack:** Laravel 11 · PHP 8.2 · Oracle (XE 21 dev / externo prod) · Authelia
(SSO prod, simulado dev) · gov.br DS v3 (tema navy TRE-AC) · Docker.

## Princípios: TDD + XP

Toda mudança de comportamento começa por um **teste que falha**.

1. **Red:** escreva o teste, rode, confirme que falha pelo motivo certo.
2. **Green:** o mínimo de código para passar.
3. **Refactor:** com a barra verde, melhore o design; rode os testes a cada passo.

- Um teste falhando por vez.
- Nomes de teste = comportamento, em português, começando com `test_`.
- AAA (Arrange/Act/Assert). Sem `markTestSkipped`.
- Testes em **SQLite in-memory** (`phpunit.xml`); não dependem do Oracle.
- Lógica de domínio → `app/Services/` (testada isolada). Controllers finos.

## Comandos

```bash
./run-tests.sh                 # roda a suíte no container (sqlite)
./run-tests.sh --filter=Nome   # um teste
make up / make down / make shell / make pint / make test
docker compose exec app php artisan migrate
docker compose exec app php artisan db:seed --class=AcessoSeeder
```

Tudo roda em Docker. O container roda como uid 1000 — após criar arquivos no
host (root), rode `chown -R 1000:1000 .` ou os comandos falham por permissão.

## Arquitetura

```
HTTP → ConfigureUserSession → AuthorizeRouteAccess → Controller (fino)
     → Service (domínio) → Model/Eloquent → Oracle
```

- **Auth:** headers Authelia (`Remote-*`) ou bypass de dev. Identidade vira um
  `Usuario` (firstOrNew por username).
- **Autorização:** ACL dinâmica em `grupos_acesso` / `acesso_rotas` /
  `acesso_rota_grupo`. Curinga `*` = admin. `acl:sync` sincroniza o catálogo.
- **Services:** `AcessoRotaPermissaoService` (decisão de rota),
  `NominataService` (agrupamento protocolar), `AssentosService` (ocupação por cor).

## Convenções

- `declare(strict_types=1)` no topo. Type hints sempre.
- Domínio em português (Evento, Convidado, cargo, presente); infra em inglês
  (Controller, Service, Middleware).
- Laravel Pint (preset laravel) antes de commitar: `make pint`.
- Migrations compatíveis com Oracle e SQLite; identifiers ≤ 30 chars.

## Decisões tomadas

- **Oracle**, não Postgres/MySQL — restrição institucional do tribunal.
- **Visibilidade por grupo** (sem dono de evento): todo organizador vê tudo.
- **Authelia em prod, bypass em dev** (`AUTHELIA_DEV_BYPASS`, `/_dev/sessao`).
- **Drivers `database`** para sessions/cache/queue (sem Redis em dev).
- **PDF via DomPDF.** **gov.br DS v3** + tema navy `#003366` (mantendo a logo
  e a estética de cards do app original).

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonia - ATA Levantamento funcionalidades.md</nome_arquivo>
  <caminho_completo>docs/Cerimonia - ATA Levantamento funcionalidades.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
Compilação da Transcrição da Videorreunião 

**Reunião:** Coleta de Requisitos – Cerimonial   
**Data da gravação:** 08/07/2026   
**Participantes:** Lucir Rocio Vaz e Rose Jocely Lopes dos Santos Moreira   
**Fonte:** Transcrição da gravação da reunião. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Objetivo da Reunião 

Levantar requisitos para evolução do sistema de gerenciamento de eventos do Cerimonial, avaliando: 

* Fluxo de convites e confirmações;   
* Controle de presença;   
* Geração de nominatas;   
* Classificação e acomodação de participantes;   
* Integração com o sistema Visite;   
* Possível incorporação ao ecossistema Crepúsculo;   
* Registro histórico e segurança institucional. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Situação Atual do Processo 

1\. Convite e Lista de Convidados 

Atualmente: 

* Rafael e Luana, do Cerimonial, enviam convites às autoridades.   
* Os convidados respondem por e-mail confirmando presença ou informando substituições.   
* Uma assessora consolida a lista de confirmados.   
* O evento é criado previamente no sistema.   
* A responsável recebe perfil de administradora para cadastrar os participantes. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Reaproveitamento de Cadastros 

Foi informado que: 

* Os participantes cadastrados em eventos anteriores podem ser reutilizados.   
* Em cada novo evento são feitos apenas ajustes, inclusões e exclusões. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

2\. Atualização da Lista 

A lista permanece em atualização até poucas horas antes do evento. 

Processo atual: 

* Alterações são permitidas até aproximadamente 1 ou 2 horas antes do início.   
* Após esse momento a lista é considerada fechada.   
* Novos participantes são inseridos diretamente na recepção. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Recepção e Controle de Presença 

Processo Atual 

Na chegada: 

* O participante é localizado na lista.   
* Caso não esteja cadastrado, é incluído manualmente.   
* É informado seu nome e classificação.   
* Sua presença é registrada no sistema através de um clique. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Observação Importante 

Foi constatado que: 

* O sistema Visite não é utilizado durante os eventos do Cerimonial.   
* Não há checagem de restrições de acesso durante esse processo.   
* A identificação é apenas nominal. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Classificação dos Participantes 

A reunião identificou os seguintes grupos: 

Autoridades 

Exemplos: 

* Desembargadores;   
* Juízes;   
* Promotores;   
* Autoridades externas. 

Homenageados 

Participantes diretamente envolvidos na solenidade. 

Convidados 

Público geral convidado. 

Familiares 

Acompanhantes dos homenageados. 

Operacionais (proposta) 

Grupo sugerido durante a reunião: 

* Seguranças;   
* Assessores;   
* Motoristas;   
* Imprensa;   
* Equipes de apoio. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Sistema de Cores 

Foi descrito o uso de identificação por cores. 

Exemplos: 

* Vermelho: desembargadores e determinadas autoridades.   
* Outras cores (verde, azul e amarelo) conforme classificação institucional. 

O fluxo é: 

1. O participante chega.   
2. O sistema identifica sua categoria.   
3. Recebe um cartão da cor correspondente.   
4. Equipe do plenário orienta o assento adequado. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Distribuição Interna no Plenário 

Foi identificado que o sistema deve apoiar: 

* Localização dos assentos.   
* Identificação do local reservado.   
* Organização por categoria.   
* Apoio às equipes que conduzem as autoridades. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Nominata 

Conceito 

A nominata é o documento utilizado pelo cerimonialista para registrar e anunciar as autoridades presentes. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Fluxo Atual 

Primeira Nominata 

Gerada no início do evento. 

Contém: 

* Autoridades presentes;   
* Membros da Corte;   
* Demais convidados relevantes. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Nominatas Posteriores 

São geradas durante o evento para: 

* Detectar novas autoridades que chegaram;   
* Complementar anúncios já realizados. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Melhoria Solicitada 

Destacar visualmente: 

* Autoridades já anunciadas;   
* Autoridades ainda não anunciadas. 

Sugestão: 

* Já anunciadas → cinza.   
* Pendentes → vermelho ou outra cor de destaque. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Encerramento do Evento 

Foi sugerido: 

Botão de Finalização 

Ao finalizar: 

* Evento recebe status "Finalizado".   
* Não são mais realizadas alterações operacionais.   
* É produzida uma nominata final. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Produtos Gerados 

* PDF final.   
* Registro histórico.   
* Integração com processos administrativos. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Questões de Segurança 

Um dos principais temas debatidos. 

Problema Identificado 

Nos eventos: 

* Participantes entram sem validação no Visite.   
* Não há verificação automática de restrições.   
* Autoridades podem comparecer acompanhadas por seguranças ou assessores não cadastrados. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Proposta 

Integrar o sistema do Cerimonial ao Visite. 

Benefícios: 

* Verificação automática de restrições.   
* Alertas à segurança institucional.   
* Manutenção do protocolo de segurança do Tribunal. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Proposta de Integração com o Crepúsculo 

Foi discutida a utilização do Crepúsculo como plataforma base. 

Funcionalidades Desejadas 

Convites 

Envio automático de notificações. 

Autocadastro 

Participante recebe um link. 

Ele próprio: 

* Preenche dados;   
* Atualiza informações;   
* Passa pelas validações do sistema. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Vantagens 

* Redução do trabalho manual na recepção.   
* Menos filas.   
* Menos digitação.   
* Base histórica consolidada. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Requisitos Levantados 

Funcionais 

1. Criar eventos.   
2. Reaproveitar participantes de eventos anteriores.   
3. Enviar convites eletrônicos.   
4. Permitir confirmação de presença.   
5. Permitir registro de acompanhantes.   
6. Classificar participantes por categoria.   
7. Distribuir participantes por áreas do evento.   
8. Registrar presença em tempo real.   
9. Gerar nominatas sucessivas.   
10. Destacar participantes já anunciados.   
11. Gerar nominata final.   
12. Exportar PDF.   
13. Manter histórico dos eventos.   
14. Criar grupo específico para imprensa.   
15. Criar grupo específico para seguranças e acompanhantes.   
16. Integrar com autocadastro.   
17. Integrar com Visite.   
18. Emitir alertas de restrição de acesso. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Encaminhamentos 

Lucir 

* Elaborar documentação do processo.   
* Pesquisar legislação e normativos relacionados.   
* Estruturar proposta técnica para evolução da solução.   
* Avaliar integração com Visite e Crepúsculo. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

Rose 

* Avaliar submissão da iniciativa ao Laboratório de Inovação.   
* Revisar processo encaminhado por Lucir.   
* Apoiar refinamento dos requisitos do Cerimonial. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 

 

Conclusão 

A reunião consolidou os requisitos para uma nova versão da solução de Cerimonial, com foco em: 

* automação dos convites;   
* confirmação eletrônica de presença;   
* autocadastro;   
* geração de nominatas inteligentes;   
* controle operacional do evento;   
* integração com a plataforma Crepúsculo;   
* integração com o sistema Visite para reforço da segurança institucional;   
* criação de histórico permanente dos eventos realizados. [\[Coleta Req...Cerimonial | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc={fb329ea5-d86a-40d2-96bf-967299cf1b72}) 



```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonia - Documento de Requisitos.md</nome_arquivo>
  <caminho_completo>docs/Cerimonia - Documento de Requisitos.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
## Documento de Requisitos

* **Gestão de Cerimonial**  

* **Especificação Funcional e de Negócio**  

**Versão:** 2.0   
**Projeto:** Cerimonial   
**Plataforma Base:** Presença – Registro de Frequência   
**Ecossistema:** Crepúsculo   
**Órgão:** Tribunal Regional Eleitoral do Acre – TRE/AC  

#### 1. Introdução

A aplicação Cerimonial tem por finalidade apoiar o planejamento, execução, controle e registro histórico de solenidades, eventos institucionais, diplomações, posses, homenagens, visitas oficiais e demais atos protocolares realizados pelo Tribunal, fundamentado na legislação que trata da [Diplomação dos Candidatos Eleitos](https://www.tse.jus.br/eleicoes/historia/processo-eleitoral-brasileiro/diplomacao-dos-eleitos).  

A Comissão Permanente de Cerimonial (CPCT) constituída pela [Resolução nº 349/2002](https://www.justicaeleitoral.jus.br/arquivos/tre-ac-resolucao-n.-349-2002/@@display-file/file/tre-ac-2002-12-resolucao349.pdf) do Tribunal Regional Eleitoral do Acre (TRE-AC) é o setor responsável por organizar, coordenar e executar as solenidades oficiais, eventos institucionais e visitas de autoridades, tem como atribuições principais a gestão de convites, organização de pautas e acompanhamento do protocolo oficial, baseando suas diretrizes nos regulamentos estabelecidos pelo [Regimento Interno do TRE-AC](https://www.tre-ac.jus.br/legislacao/resolucoes-tre) e em normas de cerimonial harmonizadas com o [Decreto Federal nº 70.274/1972](https://www.planalto.gov.br/ccivil_03/decreto/d70274.htm).  

Além da organização de eventos, a comissão atua frequentemente como setor requisitante e gestor técnico em processos administrativos para aquisições e contratações de serviços e materiais de apoio (como decoração e preparação da infraestrutura dos eventos, além dos registros históricos e fotografias de seus participantes.  

Informações de Contato e Localização:  

* Endereço: Alameda Ministro Miguel Ferrante, 224, Bairro Portal da Amazônia, CEP 69915-632, Rio Branco \- AC.    
* Telefone: (68) 3212-6125.    
* E-mail: cerimonial@tre-ac.jus.br (atende demandas gerais e contratações do setor)  

#### 2\. Fundamentação Normativa

A construção da solução deverá observar:  

##### **2.1 Legislação Eleitoral**  

**Diplomação dos Eleitos**  

A diplomação constitui ato oficial da Justiça Eleitoral que certifica a eleição dos candidatos escolhidos pelo eleitorado e representa um dos principais eventos institucionais promovidos pelos Tribunais Eleitorais.  

A solução deverá contemplar fluxos compatíveis com cerimônias de diplomação, incluindo:  

* emissão e controle de convites;    
* credenciamento;    
* composição de mesa;    
* organização protocolar;    
* gestão de homenageados;    
* geração de registros históricos.  

 

##### 2.2 Resolução TRE-AC nº 349/2002 (0817667)

A Resolução n.º 349/2002 instituiu a Comissão Permanente de Cerimonial e Protocolo do TRE-AC, responsável pela organização, coordenação e execução dos atos solenes e protocolares da instituição. O sistema deverá apoiar as atividades desempenhadas pela comissão e pelos servidores designados para tais funções. 

##### 2.3 Decreto Federal nº 70.274/1972

O Decreto nº 70.274/1972 estabelece as Normas do Cerimonial Público e a Ordem Geral de Precedência.  

A solução deverá contemplar:  

* precedência de autoridades;    
* classificação protocolar;    
* composição de mesas de honra;    
* organização de autoridades por hierarquia;    
* geração de nominatas observando precedência institucional.  

 

#### 3\. Arquitetura Corporativa

##### 3.1 Relação com o Projeto Presença

O projeto Cerimonial integra a modelagem corporativa do projeto **Presença – Registro de Frequência**.  

O domínio "Presença" constitui o núcleo da arquitetura institucional.  

O módulo Cerimonial representa um contexto especializado de utilização desse domínio.  

**Princípios**  

* Uma única entidade Pessoa.    
* Uma única entidade Evento.    
* Uma única entidade Presença.    
* Uma única entidade Convite.    
* Uma única entidade Credenciamento.    
* Uma única entidade Histórico.  

Não poderão existir cadastros paralelos ou redundantes.  

#### 4\. Domínio de Negócio

##### 4.1 Modelo Conceitual

Pessoa    
└── Participante    
   
Evento    
├── Convite    
├── Confirmação    
├── Credenciamento    
├── Presença    
├── Nominata    
└── Ata    
   
Cerimonial    
├── Autoridades    
├── Mesa de Honra    
├── Homenageados    
├── Imprensa    
├── Seguranças    
├── Assentos    
└── Protocolo    
 

#### 5\. Tipos de Eventos  

O sistema deverá suportar:  

* Diplomação de eleitos;    
* Posse de magistrados;    
* Sessões solenes;    
* Homenagens;    
* Entrega de comendas;    
* Seminários;    
* Congressos;    
* Audiências públicas;    
* Eventos institucionais;    
* Visitas oficiais;    
* Cerimônias especiais.  

 

#### 6\. Gestão de Eventos

**RF001 – Criar Evento**  

Permitir:  

* nome;    
* descrição;    
* data;    
* horário;    
* local;    
* capacidade;    
* organizador;    
* unidade responsável;    
* tipo do evento.  

 

**RF002 – Status do Evento**  

Status possíveis:  

* Planejamento;    
* Convites enviados;    
* Credenciamento aberto;    
* Em execução;    
* Encerrado;    
* Arquivado.  

 

**RF003 – Reutilização de Eventos**  

Permitir reutilização de:  

* convidados;    
* autoridades;    
* layouts;    
* grupos;    
* listas de presença anteriores. 

 

#### 7\. Gestão de Participantes

**RF004 – Cadastro Corporativo**  

Consumir informações oriundas:  

* Magistrados;    
* Servidores;    
* Colaboradores;    
* Estagiários;    
* Requisitados;    
* Autocadastro externo.  

 

**RF005 – Classificação de Participantes**  

Categorias:  

**Autoridades**  

* Presidente;    
* Vice-Presidente;    
* Corregedor;    
* Desembargadores;    
* Juízes;    
* Membros do MP;    
* Chefes de Poder.  

**Homenageados**  

* Diplomandos;    
* Agraciados;    
* Empossandos.  

**Convidados**  

* Familiares;    
* Representantes institucionais;    
* Público externo.  

**Equipes Operacionais**  

* Cerimonial;    
* Imprensa;    
* Segurança;    
* Motoristas;    
* Apoio. 

 

#### 8\. Convites e Confirmações

**RF006 – Convites**  

Permitir:  

* envio por e-mail;    
* envio em lote;    
* envio individual;    
* reenvio automático.  

 

**RF007 – Confirmação de Presença**  

O convidado poderá:  

* confirmar participação;    
* recusar participação;    
* informar substituto;    
* informar acompanhantes. 

 

**RF008 – Acompanhantes**  

Permitir informar:  

* assessores;    
* familiares;    
* seguranças;    
* motoristas.  

Todos deverão ser vinculados ao participante principal.  

#### 9\. Autocadastro

**RF009 – Autocadastro**  

Participante externo deverá:  

* preencher seus dados;    
* atualizar informações;    
* anexar documentos quando necessário;    
* concordar com tratamento de dados. 

 

#### 10\. Credenciamento

**RF010 – Check-in**  

Permitir:  

* busca rápida;    
* QR Code;    
* CPF;    
* nome.  

 

#### RF011 – Registro de Presença

Registrar:  

* data;    
* horário;    
* unidade responsável;    
* operador.  

 

#### RF012 – Inclusão Emergencial

Permitir cadastrar participantes não previstos. [\[Cerimonial...ão virtual | Word\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/Doc.aspx?sourcedoc=%7B9235954C-0EE7-45C4-8AF7-8DD602592F04%7D&file=Cerimonial%20-%20ATA%20reuni%C3%A3o%20virtual.docx&action=default&mobileredirect=true)  

 

#### 11\. Integração com o Visite

**RF013 – Validação de Restrição**  

Durante o credenciamento:  

* consultar Visite;    
* verificar restrições;    
* identificar ocorrências.  

 

**RF014 – Alertas de Segurança**  

Quando houver restrição:  

* gerar alerta;    
* comunicar segurança institucional;    
* registrar ocorrência.  

 

#### 12\. Gestão de Assentos

**RF015 – Layout do Plenário**  

Permitir configurar:  

* fileiras;    
* setores;    
* mesa de honra;    
* áreas reservadas.  

 

**RF016 – Assentos Reservados**  

Permitir reserva por:  

* autoridade;    
* homenageado;    
* convidado;    
* grupo.  

 

**RF017 – Identificação por Cores**  

Exemplos:  

* Vermelho;    
* Azul;    
* Verde;    
* Amarelo.  

Conforme classificação definida pelo Cerimonial.  

#### 13\. Nominatas

**RF018 – Nominata Inicial**  

Gerar lista de autoridades presentes para abertura do evento.  

**RF019 – Nominata Incremental**  

Gerar apenas participantes que chegaram após a última leitura.  

**RF020 – Controle de Leitura**  

Registrar:  

* já anunciado;    
* pendente de anúncio.  

Com destaque visual.  

#### 14\. Mesa de Honra

**RF021 – Composição de Mesa**  

Permitir:  

* inclusão manual;    
* ordenação por precedência;    
* substituições.  

 

**RF022 – Ordem de Precedência**  

Deverá observar:  

* Decreto nº 70.274/1972;    
* regras da Justiça Eleitoral;    
* normas internas do TRE-AC.  

 

#### 15\. Ata e Encerramento

**RF023 – Encerramento**  

Ao finalizar:  

* bloquear alterações;    
* consolidar presenças;    
* consolidar credenciamentos.  

**RF024 – Ata do Evento**  

Gerar:  

* participantes;    
* presentes;    
* ausentes;    
* autoridades;    
* nominata final.  

 

**RF025 – Exportação**  

Permitir exportação:  

* PDF;    
* DOCX;    
* Planilha.  

#### 16\. Histórico Institucional

**RF026 – Acervo Histórico**  

Manter histórico de:  

* eventos;    
* participantes;    
* autoridades;    
* diplomações;    
* homenagens;    
* posses.  

**RF027 – Pesquisa Histórica**  

Permitir consulta por:  

* nome;    
* evento;    
* cargo;    
* período.  

#### 17\. Requisitos Não Funcionais

**RNF001**  

Integração nativa com Presença.  

**RNF002**  

Integração com Crepúsculo.  

**RNF003**  

Integração com Visite.  

**RNF004**  

Registro de auditoria completa.  

**RNF005**  

Controle de acesso baseado em perfis.  

**RNF006**  

Funcionamento em dispositivos móveis.  

**RNF007**  

Atualização em tempo real das presenças e nominatas.  

#### 18\. Resultado Esperado

A solução Cerimonial deverá permitir a gestão completa de cerimônias e atos protocolares do TRE-AC, utilizando o domínio corporativo de Presença como fundamento arquitetural, garantindo sincronização de dados, observância das normas de cerimonial público, suporte às atividades da Comissão Permanente de Cerimonial e Protocolo e integração aos mecanismos institucionais de segurança, credenciamento e registro histórico. 

 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - Apresentação da Gestão de Cerimonial.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - Apresentação da Gestão de Cerimonial.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
![Solene - Banner](images/Solene_Banner.PNG)  

![Solene - Fundo](images/Solene_FundoTela.PNG)  

![Solene - Ícone](images/Solene_Icone.PNG)  


# **Solene \- Gestão de Cerimonial**
Proposta de Modernização da Gestão de Eventos e Solenidades do Tribunal Regional Eleitoral do Acre 


Apresentação 

A evolução dos serviços prestados pela Justiça Eleitoral exige a adoção de soluções tecnológicas capazes de apoiar os processos administrativos e protocolares que sustentam a realização de eventos institucionais, solenidades oficiais e atos formais de representação. 

Nesse contexto, apresenta-se o **SOLENE – Gestão de Cerimonial**, iniciativa concebida para modernizar, integrar e consolidar a gestão das atividades desenvolvidas pela Comissão Permanente de Cerimonial e Protocolo do Tribunal Regional Eleitoral do Acre (TRE-AC), promovendo maior eficiência operacional, rastreabilidade das informações, segurança institucional e preservação da memória organizacional. 

O nome **SOLENE** foi escolhido por representar a natureza dos eventos conduzidos pela Justiça Eleitoral, remetendo aos atos formais que expressam a legitimidade democrática, o respeito às instituições e a valorização da cidadania. 

 

Contexto Institucional 

A Comissão Permanente de Cerimonial e Protocolo do TRE-AC, instituída pela **Resolução nº 349/2002**, é responsável por organizar, coordenar e executar cerimônias oficiais, sessões solenes, visitas institucionais, homenagens, posses, diplomações e demais eventos representativos da Justiça Eleitoral. [\[treacjusbr...epoint.com\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/Documents/Arquivos%20de%20Microsoft%20Copilot%20Chat/Historico_Cerimonial.md) 

Além das atividades protocolares, a comissão exerce funções relacionadas à gestão de convites, composição de mesas de honra, organização de autoridades, acompanhamento de precedências, coordenação logística dos eventos e preservação dos registros históricos das solenidades realizadas. [\[treacjusbr...epoint.com\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/Documents/Arquivos%20de%20Microsoft%20Copilot%20Chat/Historico_Cerimonial.md) 

Atualmente, grande parte dessas atividades depende de controles manuais, planilhas eletrônicas, mensagens eletrônicas e procedimentos operacionais descentralizados, o que dificulta a consolidação das informações e a construção de um acervo institucional estruturado. 

 

Motivação 

Durante o levantamento realizado junto à equipe do Cerimonial foram identificadas oportunidades de melhoria relacionadas a: 

* Gestão de convidados e autoridades;   
* Controle de confirmações de presença;   
* Credenciamento e recepção dos participantes;   
* Registro eletrônico de presença;   
* Produção de nominatas;   
* Organização de assentos e setores;   
* Controle de precedência protocolar;   
* Geração de documentos oficiais;   
* Preservação do histórico institucional;   
* Integração com os mecanismos de segurança do Tribunal. 

A ausência de uma plataforma específica para essas atividades cria retrabalho operacional e dificulta a obtenção de informações históricas relevantes para futuras solenidades. 

 

A Solução Proposta 

O **SOLENE – Gestão de Cerimonial** será uma solução corporativa desenvolvida para atender integralmente o ciclo de vida dos eventos institucionais promovidos pelo TRE-AC. 

A proposta não consiste apenas em informatizar procedimentos existentes, mas em estruturar um modelo corporativo permanente para gestão de eventos oficiais da Justiça Eleitoral. 

Entre suas principais capacidades destacam-se: 

Planejamento de Eventos 

* Cadastro e gerenciamento de eventos;   
* Definição de cronogramas;   
* Parametrização de protocolos;   
* Organização das equipes envolvidas. 

Gestão de Convites 

* Emissão eletrônica de convites;   
* Controle de confirmações;   
* Registro de acompanhantes;   
* Gestão de autoridades e convidados especiais. 

Credenciamento e Presença 

* Registro de comparecimento em tempo real;   
* Controle de recepção;   
* Identificação de participantes;   
* Consultas instantâneas de presença. 

Gestão Protocolar 

* Controle de precedência;   
* Composição de mesa de honra;   
* Distribuição de assentos;   
* Organização de autoridades. 

Nominatas Inteligentes 

* Geração automatizada de nominatas;   
* Atualização dinâmica durante o evento;   
* Controle de autoridades já anunciadas;   
* Consolidação de autoridades presentes. 

Memória Institucional 

* Registro permanente de eventos;   
* Histórico de autoridades participantes;   
* Histórico de solenidades;   
* Acervo documental estruturado. 

 

Fundamentação Normativa 

O projeto possui aderência às normas que regem os atos protocolares e institucionais da Justiça Eleitoral. 

Entre os principais referenciais normativos destacam-se: 

Código Eleitoral 

A diplomação constitui o ato por meio do qual a Justiça Eleitoral certifica oficialmente que o candidato eleito está apto a exercer o mandato para o qual foi escolhido pelo eleitorado. [\[treacjusbr...epoint.com\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/Documents/Arquivos%20de%20Microsoft%20Copilot%20Chat/Historico_Cerimonial.md) 

Resolução TSE nº 23.677/2021 

Regulamenta aspectos relacionados à diplomação dos candidatos eleitos, definindo requisitos, restrições e procedimentos aplicáveis ao ato de diplomação. [\[treacjusbr...epoint.com\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/Documents/Arquivos%20de%20Microsoft%20Copilot%20Chat/Historico_Cerimonial.md) 

Resolução TRE-AC nº 349/2002 

Institui a Comissão Permanente de Cerimonial e Protocolo do TRE-AC, órgão responsável pela condução das atividades contempladas pelo projeto. [\[treacjusbr...epoint.com\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/Documents/Arquivos%20de%20Microsoft%20Copilot%20Chat/Historico_Cerimonial.md) 

Decreto Federal nº 70.274/1972 

Estabelece as normas do Cerimonial Público e da Ordem Geral de Precedência da República Federativa do Brasil, fundamento para a organização das autoridades participantes de eventos oficiais. 

 

Integração com a Plataforma Corporativa 

O SOLENE foi concebido para atuar de forma integrada ao ecossistema corporativo do Tribunal. 

A solução compartilhará informações com: 

* Plataforma Presença;   
* Sistema Visite;   
* Plataforma Crepúsculo;   
* Cadastros corporativos de pessoas;   
* Serviços de autenticação institucional. 

Dessa forma, evita-se a duplicação de informações e estabelece-se uma única fonte institucional para dados relacionados a participantes, eventos e registros de presença. 

 

Benefícios Institucionais 

A implantação do SOLENE proporcionará: 

Governança 

* Padronização dos procedimentos do Cerimonial.   
* Maior rastreabilidade das informações. 

Eficiência Operacional 

* Redução de controles manuais.   
* Automação de tarefas repetitivas. 

Segurança 

* Integração com mecanismos de validação de acesso.   
* Apoio às equipes de segurança institucional. 

Transparência 

* Histórico consolidado dos eventos realizados.   
* Facilidade de consulta e auditoria. 

Preservação da Memória Institucional 

* Registro permanente das solenidades do Tribunal.   
* Consolidação do patrimônio histórico documental do TRE-AC. 

 

Considerações Finais 

O **SOLENE – Gestão de Cerimonial** representa uma iniciativa estratégica voltada à transformação digital das atividades protocolares da Justiça Eleitoral do Acre. 

Mais do que uma ferramenta administrativa, a solução propõe a criação de uma plataforma institucional capaz de apoiar a realização de eventos oficiais, fortalecer a governança dos processos de cerimonial e preservar a memória histórica do Tribunal Regional Eleitoral do Acre. 

Ao integrar tecnologia, protocolo, segurança e gestão documental em um único ambiente corporativo, o SOLENE contribuirá para uma atuação mais moderna, eficiente e alinhada aos princípios de excelência administrativa que orientam a Justiça Eleitoral brasileira. [\[treacjusbr...epoint.com\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/Documents/Arquivos%20de%20Microsoft%20Copilot%20Chat/Historico_Cerimonial.md) 

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial___ATA_24082026.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial___ATA_24082026.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
## **Projeto: SOLENE – Gestão de Cerimonial**

### **Reunião de Levantamento de Requisitos e Planejamento da Primeira Entrega**

**Data:** 24 de agosto de 2026  
 **Horário:** 11h06min  
 **Modalidade:** Videoconferência  
 **Projeto:** SOLENE – Gestão de Cerimonial  
 **Objetivo:** Avaliação do estágio de desenvolvimento da solução SOLENE, alinhamento dos requisitos para a solenidade de posse prevista para o dia 18, validação do fluxo operacional do Cerimonial e definição das entregas prioritárias da primeira versão do sistema. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **Participantes**

* Lucir Rocio Vaz  
* Rose Jocely Lopes dos Santos Moreira  
* Raphael Batista da Silva  
* Felipe Bezerra Lima  
* Thallys Bandeira Roque Maia Pinto [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **1\. Contextualização Inicial**

O servidor Raphael Batista informou que os convites referentes à próxima solenidade já haviam sido encaminhados aos convidados e que as confirmações já estavam sendo recebidas pelo Cerimonial. Informou também que existe uma lista consolidada de autoridades baseada na Resolução do Cerimonial, acrescida de indicações específicas dos desembargadores envolvidos na solenidade. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi registrado que o processo atual já se encontra em andamento, o que impossibilita a adoção integral do fluxo idealizado para a nova versão do SOLENE, especialmente quanto ao uso prévio do autocadastro pelos convidados. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **2\. Situação Atual do Sistema SOLENE**

A SDBD informa que o projeto encontra-se na fase inicial de implementação após a conclusão dos levantamentos de requisitos e da definição dos parâmetros funcionais da aplicação. A equipe está iniciando a codificação da nova versão integrada ao ecossistema Crepúsculo. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi esclarecido que a solução está sendo redesenhada para incorporar:

* autocadastro dos participantes;  
* integração com a base corporativa;  
* registro de confirmações;  
* gerenciamento de grupos de participantes;  
* geração de nominatas;  
* controle de presença;  
* integração futura com os mecanismos de segurança institucional. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **3\. Modelo de Autocadastro**

Foi apresentada a concepção da nova arquitetura funcional do aplicativo.

O modelo proposto prevê que:

1. O participante receba um link.  
2. O participante realize seu próprio cadastro.  
3. Os dados sejam registrados na base corporativa.  
4. O participante seja vinculado ao evento.  
5. O Cerimonial registre posteriormente sua presença efetiva no local da solenidade.

Esse modelo segue a mesma lógica já utilizada pelo Tribunal em sistemas relacionados aos mesários, voluntários e demais processos de autocadastro institucional. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi destacado que o autocadastro permitirá que:

* autoridades;  
* assessores;  
* familiares;  
* seguranças;  
* motoristas;  
* equipes de apoio;

possam ser previamente qualificados e vinculados ao evento. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **4\. Preocupação do Cerimonial com o Evento Imediato**

Raphael Batista demonstrou preocupação com a utilização da nova versão do sistema para o evento previsto para o dia 18, visto que os convites já foram emitidos seguindo o fluxo tradicional. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi discutida a possibilidade de:

* cadastrar manualmente os convidados já confirmados;  
* utilizar uma base auxiliar;  
* trabalhar com importação de dados;  
* adotar uma solução transitória até que a nova plataforma esteja plenamente operacional.

[\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Raphael ressaltou a necessidade de evitar retrabalho e defendeu a possibilidade de alimentar diretamente o sistema com informações que já estão sendo recebidas pelo Cerimonial. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **5\. Separação entre Confirmação e Presença**

Foi reforçado que o sistema deverá distinguir claramente duas situações:

### **Confirmação de Participação**

Quando o convidado responde ao convite informando que comparecerá ao evento. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Presença Efetiva**

Quando o participante comparece fisicamente ao Tribunal e realiza seu credenciamento. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi registrado que essa separação permitirá:

* melhor gestão dos assentos;  
* geração correta das nominatas;  
* acompanhamento da chegada das autoridades;  
* acompanhamento em tempo real pelas unidades organizadoras. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **6\. Painel de Acompanhamento para Autoridades**

Foi destacado que uma das funcionalidades previstas consiste na disponibilização de informações em tempo real para a Presidência.

Foi apresentado como caso de uso:

* visualizar autoridades já presentes;  
* visualizar autoridades ainda aguardadas;  
* auxiliar a tomada de decisão quanto ao início da solenidade. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **7\. Importação de Dados Existentes**

Raphael informou a existência de:

* planilhas de convidados;  
* relações de cargos;  
* listas de autoridades;  
* controles de confirmação. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

A equipe concordou em avaliar mecanismos para:

* importação por CSV;  
* reaproveitamento das listas existentes;  
* migração das confirmações para o sistema. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **8\. Agenda de Autoridades**

Durante a discussão foi identificado um requisito anteriormente não contemplado:

A necessidade de manutenção de uma agenda institucional dinâmica de autoridades. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi constatado que:

* os cargos sofrem alterações;  
* novas instituições surgem;  
* órgãos são extintos;  
* a lista de autoridades precisa ser constantemente atualizada. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Também foi observado que:

* existe uma lista obrigatória determinada pela resolução;  
* existem convidados adicionais definidos pela Presidência;  
* existem convidados específicos indicados pelo empossando. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **9\. Apresentação do Protótipo**

Foi feita uma demonstração da versão já migrada do sistema. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foram demonstradas as seguintes funcionalidades:

### **Cadastro de Evento**

* nome;  
* local;  
* data;  
* categoria do evento. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Definição de Capacidade**

Cadastro da quantidade de assentos por categoria:

* desembargadores;  
* juízes;  
* autoridades;  
* convidados.

[\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Cadastro de Participantes**

Inclusão manual de participantes no evento. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Confirmação de Presença**

Registro da presença do participante. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Geração de Nominata**

Exibição dos participantes presentes. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Exportação CSV**

Exportação da lista de participantes. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **10\. Discussão sobre Nominatas Incrementais**

Rose relembrou requisito anteriormente levantado:

Após a leitura da primeira nominata, as seguintes devem destacar apenas os participantes que chegaram posteriormente. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi acordado que:

* o cerimonialista será o único usuário apto a gerar nominatas;  
* a geração será manual;  
* cada nominata constituirá um marco temporal;  
* apenas os novos participantes deverão ser destacados. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Também foi avaliada a utilização de:

* negrito;  
* destaque visual;  
* mudança de cor;

para indicar os participantes ainda não anunciados. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **11\. Integração com Segurança Institucional**

Ficou esclarecido que o principal diferencial da solução está vinculado ao processo de validação prévia dos participantes. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Foi novamente enfatizado que o autocadastro futuramente permitirá:

* validação das pessoas convidadas;  
* cruzamento de informações institucionais;  
* integração com mecanismos de segurança;  
* apoio ao sistema Visite. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

A equipe registrou que essa funcionalidade é considerada crítica diante da presença de autoridades em eventos oficiais. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **12\. Estratégia para o Evento do Dia 18**

Foi discutida a necessidade de manter planos alternativos em razão do prazo reduzido. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Rose propôs trabalhar com:

### **Plano A**

Utilização da nova versão do SOLENE. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Plano B**

Utilização da solução empregada na cerimônia anterior. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

### **Plano C**

Operação por meio de listas impressas e controles manuais. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

Lucir informou que não seria possível garantir integralmente a entrega da nova solução até o dia 18, mas que a equipe realizaria todos os esforços necessários para disponibilizar uma versão minimamente funcional. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **METAS E DELIBERAÇÕES DEFINIDAS**

## **Meta 1 – Entrega Mínima Funcional do SOLENE**

**Responsável:** Lucir Rocio Vaz e equipe de desenvolvimento

**Objetivo:** Disponibilizar versão minimamente operacional do SOLENE até o evento previsto para o dia 18\. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

## **Meta 2 – Envio de Material pelo Cerimonial**

**Responsável:** Raphael Batista

**Objetivo:**

Encaminhar para a equipe de desenvolvimento:

* modelo de ofício;  
* modelo de convite;  
* planilha de autoridades;  
* classificação por cores;  
* resolução do Cerimonial. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

## **Meta 3 – Estudo de Importação de Dados**

**Responsável:** Felipe Bezerra e equipe técnica

**Objetivo:**

Avaliar:

* importação CSV;  
* reaproveitamento das listas do Cerimonial;  
* migração de convidados e confirmações. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

## **Meta 4 – Implementação da Agenda de Autoridades**

**Responsável:** Equipe SOLENE

**Objetivo:**

Criar estrutura para manutenção de:

* órgãos;  
* instituições;  
* autoridades;  
* cargos;  
* contatos oficiais. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

## **Meta 5 – Nominatas Incrementais**

**Responsável:** Felipe Bezerra

**Objetivo:**

Implementar:

* controle de leituras;  
* destaque visual para novos participantes;  
* geração manual de nominatas sucessivas. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

## **Meta 6 – Integração Futura com Segurança Institucional**

**Responsável:** Equipe SOLENE

**Objetivo:**

Desenvolver mecanismo baseado em:

* autocadastro;  
* validação de participantes;  
* integração com Visite;  
* comunicação com segurança institucional. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)

---

# **Encerramento**

Ao final da reunião, ficou acordado que Raphael enviará os documentos e listas necessárias para subsidiar os ajustes do sistema, enquanto a equipe de desenvolvimento avaliará as adaptações necessárias para que o SOLENE possa ser utilizado, ainda que parcialmente, na próxima solenidade. Permanecerão ativos os planos de contingência anteriormente definidos até a confirmação da disponibilidade da nova solução. [\[Solene \- L...antamentos | Video\]](https://treacjusbr-my.sharepoint.com/personal/lrocio_tre-ac_jus_br/_layouts/15/viewer.aspx?sourcedoc=%7B5e5f259c-bf41-499f-8a6d-7c8b62093e63%7D)


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - Dependências Ecossistema Crepusculo.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - Dependências Ecossistema Crepusculo.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
#### Dependência de Solução Existente 

Projeto Relacionado 

**Projeto: Presença – Registro de Frequência** 

A solução de Cerimonial não deve ser tratada como uma aplicação isolada. Sua concepção deriva diretamente dos conceitos, padrões arquiteturais e fluxos operacionais definidos no projeto **Presença – Registro de Frequência**, que servem como base para o modelo de controle de participantes e eventos. 

Dessa forma, os requisitos, regras de negócio e componentes já consolidados naquele projeto deverão ser considerados pré-requisitos para o desenvolvimento desta nova solução. 

 

#### Componentes Herdados 

A aplicação Cerimonial deverá reutilizar ou adaptar os seguintes conceitos já definidos no Projeto Presença: 

1\. Gestão de Eventos 

Capacidade de: 

* Criar eventos;   
* Definir período de realização;   
* Identificar responsáveis;   
* Manter histórico de eventos. 

 

2\. Gestão de Participantes 

Cadastro e manutenção de: 

* Servidores;   
* Magistrados;   
* Colaboradores;   
* Participantes externos;   
* Pessoas oriundas de autocadastro. 

 

3\. Controle de Presença 

Mecanismos para: 

* Registro de entrada;   
* Confirmação de comparecimento;   
* Consolidação de participantes presentes;   
* Geração de listas em tempo real. 

 

4\. Autocadastro 

Utilização do modelo já concebido para: 

* Convites eletrônicos;   
* Preenchimento de dados pelo participante;   
* Atualização cadastral;   
* Validação prévia antes do evento. 

 

5\. Integração com Base Corporativa 

A solução deverá aproveitar: 

* Cadastro corporativo de pessoas;   
* Cadastro de magistrados;   
* Cadastro de servidores;   
* Cadastro de colaboradores;   
* Outras bases institucionais disponíveis no ecossistema Crepúsculo. 

 

6\. Integração com o Visite 

A funcionalidade concebida no Projeto Presença para validação de participantes deverá ser expandida para: 

* Verificação de restrições de acesso;   
* Emissão de alertas de segurança;   
* Comunicação com a equipe de segurança institucional;   
* Registro de ocorrências relacionadas ao acesso. 

 

Extensões Específicas do Cerimonial 

Sobre a base herdada do Projeto Presença, deverão ser acrescentadas funcionalidades próprias do Cerimonial: 

Classificação de Participantes 

* Autoridades;   
* Magistrados;   
* Homenageados;   
* Convidados;   
* Familiares;   
* Imprensa;   
* Seguranças;   
* Equipes de apoio. 

 

Controle de Assentos 

* Distribuição por setores;   
* Controle por cores;   
* Reserva de assentos;   
* Mapeamento de plenário. 

 

Nominata 

* Geração dinâmica;   
* Geração incremental;   
* Controle de autoridades já anunciadas;   
* Emissão de nominata final. 

 

Cerimonial e Protocolo 

* Mesa de honra;   
* Ordem de precedência;   
* Controle de homenageados;   
* Registro histórico de eventos solenes. 

 

#### Premissa Arquitetural 

A aplicação **Cerimonial** deverá ser desenvolvida como um módulo especializado derivado dos conceitos do projeto **Presença – Registro de Frequência**, compartilhando a mesma modelagem de participantes, eventos, presença, notificações, autocadastro e integração com os serviços corporativos do ecossistema Crepúsculo. 

O Projeto Presença deverá ser considerado a fundação funcional e técnica da nova solução. 

   
Isso cria um vínculo formal entre os dois projetos e evita retrabalho, deixando explícito que a modelagem de **Evento → Participante → Convite → Confirmação → Presença → Histórico**, já construída no Projeto Presença, é o núcleo sobre o qual o módulo Cerimonial será implementado. 

 

#### Integração Estrutural com o Projeto Presença 

Relação entre os Projetos 

O projeto **Cerimonial** constitui uma especialização funcional da plataforma **Presença – Registro de Frequência**, compartilhando a mesma base conceitual, modelo de dados e infraestrutura de serviços. 

A relação entre os projetos não deve ser tratada como integração entre sistemas independentes, mas como módulos de um mesmo ecossistema de gestão de participação institucional. 

Enquanto o Projeto Presença atende o registro individual e coletivo de comparecimento em atividades institucionais, o Projeto Cerimonial expande esse modelo para contemplar eventos protocolares, solenidades, posses, homenagens e demais atos oficiais do Tribunal. 

 

#### Premissa de Modelagem 

A entidade **Presença** deverá ser considerada o elemento central da modelagem corporativa. 

A partir dela derivam diferentes contextos de negócio: 

* Capacitações;   
* Treinamentos;   
* Reuniões;   
* Auditorias;   
* Eventos institucionais;   
* Solenidades;   
* Cerimônias de posse;   
* Homenagens;   
* Atividades protocolares. 

O módulo Cerimonial representa um destes contextos especializados. 

 

#### Sincronia Obrigatória 

Toda evolução realizada no módulo Cerimonial deverá permanecer aderente à modelagem corporativa do Projeto Presença, garantindo: 

* Unicidade cadastral de pessoas;   
* Compartilhamento de eventos;   
* Compartilhamento de registros de presença;   
* Compartilhamento de notificações;   
* Compartilhamento dos mecanismos de credenciamento;   
* Compartilhamento dos mecanismos de autocadastro;   
* Compartilhamento das integrações de segurança;   
* Compartilhamento do histórico institucional. 

Não deverão existir estruturas paralelas ou redundantes para gerenciamento de pessoas, eventos ou presença. 

 

Modelo Conceitual Compartilhado 
```
1     Pessoa   
2        │   
3        ├── Participante   
4        │   
5     Evento   
6        │   
7        ├── Convite   
8        │   
9        ├── Confirmação   
10        │   
11        ├── Credenciamento   
12        │   
13        └── Presença   
14             	│   
15             	├── Capacitação   
16             	├── Reunião   
17             	├── Auditoria   
18             	├── Evento Institucional   
19             	└── Cerimonial 
```
 

Extensões do Cerimonial 

O módulo Cerimonial acrescenta atributos específicos ao registro de presença, tais como: 

* Categoria protocolar;   
* Autoridade convidada;   
* Ordem de precedência;   
* Mesa de honra;   
* Assento reservado;   
* Cor de identificação;   
* Homenageado;   
* Acompanhante;   
* Segurança;   
* Imprensa;   
* Nominata;   
* Controle de anúncio durante o evento. 

Entretanto, o registro de comparecimento continua pertencendo ao domínio corporativo **Presença**. 

 

Diretriz Arquitetural 

O Projeto Cerimonial deverá ser implementado como um módulo especializado da plataforma Presença, compartilhando integralmente sua modelagem de dados e serviços corporativos, de modo que qualquer registro efetuado em Cerimonial seja automaticamente reconhecido pelo ecossistema Presença e vice-versa. 

A evolução dos dois projetos deverá ocorrer de forma sincronizada, preservando uma única fonte de verdade para os conceitos de **Pessoa, Evento, Convite, Credenciamento e Presença**. 

   
Essa formulação deixa explícito que **Cerimonial é um subconjunto funcional do domínio "Presença"**, evitando que futuramente sejam criadas tabelas ou cadastros duplicados para participantes, eventos e registros de comparecimento. 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - DER Diagrama Entidade Relacionamento.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - DER Diagrama Entidade Relacionamento.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
## DER – Diagrama Entidade-Relacionamento 

Projeto: Solene - Gestão de Cerimonial (Integrado ao Domínio Presença) 

O DER abaixo considera a arquitetura definida no DRS/TDD, a integração com **Presença**, **Visite** e **Crepúsculo**, e a premissa de que **Cerimonial não possui cadastro próprio de pessoas**, reutilizando a entidade corporativa **Pessoa**. 

 
```
Visão Conceitual 

1     Pessoa   
2        |   
3        \+------\< ParticipanteEvento \>------ Evento   
4                      	|   
5                      	\+------ CategoriaParticipante   
6                      	|   
7                      	\+------ Assento   
8                      	|   
9                      	\+------ Presenca   
10                      	|   
11                      	\+------ Acompanhante   
12                      	|   
13                      	\+------ MesaHonra   
14                      	|   
15                      	\+------ NominataItem 
```
 

DER Completo 
```uml
1     @startuml   
2        
3     hide circle   
4     skinparam linetype ortho   
5        
6     entity Pessoa {   
7     	\* id : bigint   
8     	\--   
9         cpf : varchar   
10         nome : varchar   
11         email : varchar   
12         telefone : varchar   
13     }   
14        
15     entity Evento {   
16     	\* id : bigint   
17     	\--   
18         tipo\_evento\_id : bigint   
19         nome : varchar   
20         descricao : text   
21         data\_inicio : datetime   
22         data\_fim : datetime   
23         local\_id : bigint   
24         situacao : varchar   
25     }   
26        
27     entity TipoEvento {   
28     	\* id : bigint   
29     	\--   
30         descricao : varchar   
31     }   
32        
33     entity ParticipanteEvento {   
34     	\* id : bigint   
35     	\--   
36         evento\_id : bigint   
37         pessoa\_id : bigint   
38         categoria\_id : bigint   
39         confirmacao : boolean   
40         data\_confirmacao : datetime   
41     }   
42        
43     entity CategoriaParticipante {   
44     	\* id : bigint   
45     	\--   
46         nome : varchar   
47         cor\_identificacao : varchar   
48         precedencia : integer   
49     }   
50        
51     entity Convite {   
52     	\* id : bigint   
53     	\--   
54         evento\_id : bigint   
55         participante\_id : bigint   
56         enviado\_em : datetime   
57         status : varchar   
58     }   
59        
60     entity Presenca {   
61     	\* id : bigint   
62     	\--   
63         participante\_evento\_id : bigint   
64         data\_hora : datetime   
65         operador\_id : bigint   
66     }   
67        
68     entity Acompanhante {   
69     	\* id : bigint   
70     	\--   
71         participante\_evento\_id : bigint   
72         pessoa\_id : bigint   
73         tipo : varchar   
74     }   
75        
76     entity Assento {   
77     	\* id : bigint   
78     	\--   
79         evento\_id : bigint   
80         setor\_id : bigint   
81         codigo : varchar   
82         fila : varchar   
83         cadeira : integer   
84     }   
85        
86     entity ReservaAssento {   
87     	\* id : bigint   
88     	\--   
89         assento\_id : bigint   
90         participante\_evento\_id : bigint   
91     }   
92        
93     entity Setor {   
94     	\* id : bigint   
95     	\--   
96         descricao : varchar   
97         cor : varchar   
98     }   
99        
100     entity MesaHonra {   
101     	\* id : bigint   
102     	\--   
103         evento\_id : bigint   
104         participante\_evento\_id : bigint   
105         ordem : integer   
106     }   
107        
108     entity Nominata {   
109     	\* id : bigint   
110     	\--   
111         evento\_id : bigint   
112         tipo : varchar   
113         gerada\_em : datetime   
114     }   
115        
116     entity NominataItem {   
117     	\* id : bigint   
118     	\--   
119         nominata\_id : bigint   
120         participante\_evento\_id : bigint   
121         anunciado : boolean   
122         ordem : integer   
123     }   
124        
125     entity AtaEvento {   
126     	\* id : bigint   
127     	\--   
128         evento\_id : bigint   
129         data\_encerramento : datetime   
130         arquivo\_pdf : varchar   
131     }   
132        
133     entity Diplomacao {   
134     	\* id : bigint   
135     	\--   
136         evento\_id : bigint   
137         participante\_evento\_id : bigint   
138         diploma\_emitido : boolean   
139     }   
140        
141     entity RestricaoVisite {   
142     	\* id : bigint   
143     	\--   
144         pessoa\_id : bigint   
145         tipo\_restricao : varchar   
146         situacao : varchar   
147     }   
148        
149     TipoEvento ||--o{ Evento   
150        
151     Evento ||--o{ ParticipanteEvento   
152     Pessoa ||--o{ ParticipanteEvento   
153     CategoriaParticipante ||--o{ ParticipanteEvento   
154        
155     ParticipanteEvento ||--o{ Convite   
156     ParticipanteEvento ||--o{ Presenca   
157        
158     ParticipanteEvento ||--o{ Acompanhante   
159     Pessoa ||--o{ Acompanhante   
160        
161     Evento ||--o{ Assento   
162     Setor ||--o{ Assento   
163        
164     Assento ||--o| ReservaAssento   
165     ParticipanteEvento ||--o| ReservaAssento   
166        
167     Evento ||--o{ MesaHonra   
168     ParticipanteEvento ||--o{ MesaHonra   
169        
170     Evento ||--o{ Nominata   
171     Nominata ||--o{ NominataItem   
172     ParticipanteEvento ||--o{ NominataItem   
173        
174     Evento ||--|| AtaEvento   
175        
176     Evento ||--o{ Diplomacao   
177     ParticipanteEvento ||--o{ Diplomacao   
178        
179     Pessoa ||--o{ RestricaoVisite   
180        
181     @enduml 
```
 

Entidades Principais 

Pessoa (Domínio Presença) 

Cadastro corporativo compartilhado. 
```
1     Pessoa   
2     ├─ Magistrados   
3     ├─ Servidores   
4     ├─ Colaboradores   
5     ├─ Estagiários   
6     ├─ Autoridades Externas   
7     ├─ Jornalistas   
8     └─ Visitantes 
```
 

Evento 

Representa qualquer ato institucional. 

Exemplos: 

* Diplomação   
* Posse   
* Homenagem   
* Sessão Solene   
* Seminário   
* Audiência Pública 

 

ParticipanteEvento 

Entidade central do Cerimonial. 

Resolve o relacionamento N:N entre: 
```
1     Pessoa   
2     	↕   
3     ParticipanteEvento   
4     	↕   
5     Evento   
Controla: 
```
* presença;   
* confirmação;   
* precedência;   
* assento;   
* participação em nominata. 

 

CategoriaParticipante 

Permite classificar: 

1     Autoridade   
2     Magistrado   
3     Homenageado   
4     Convidado   
5     Imprensa   
6     Segurança   
7     Motorista   
8     Familiar   
9     Operacional 

 

Convite 

Controla: 

1     Enviado   
2     Confirmado   
3     Recusado   
4     Substituído   
5     Pendente 

 

Presença 

Pertence ao domínio corporativo Presença. 

1     Check-in   
2     Data   
3     Hora   
4     Operador 

 

Acompanhante 

Relaciona: 

1     Autoridade   
2       	↓   
3     Acompanhantes   
4       	↓   
5     Assessores   
6     Seguranças   
7     Familiares   
8     Motoristas 

 

Assentos 

Permite modelar: 
```
1     Plenário   
2        ├─ Setores   
3        ├─ Fileiras   
4        ├─ Cadeiras   
5        └─ Reservas 
```
 

Mesa de Honra 

Implementa a ordem protocolar prevista no Decreto 70.274/72. 

1     1º Presidente   
2     2º Vice-presidente   
3     3º Autoridade Convidada   
4     ... 

 

Nominata 

Controla: 

1     Nominata Inicial   
2     Nominata Incremental   
3     Nominata Final 

 

Diplomação 

Entidade especializada para eventos eleitorais. 

Armazena: 

1     Diplomando   
2     Cargo   
3     Mandato   
4     Diploma Emitido 

 

DER Físico Simplificado (Cardinalidades) 
```
1     Pessoa (1)   
2        |   
3        |----\< ParticipanteEvento \>----(1) Evento   
4                     	|   
5                     	\+----(1) CategoriaParticipante   
6                     	|   
7                     	\+----\< Convite   
8                     	|   
9                     	\+----\< Presenca   
10                     	|   
11                     	\+----\< Acompanhante   
12                     	|   
13                     	\+----\< MesaHonra   
14                     	|   
15                     	\+----\< NominataItem   
16        
17     Evento   
18        |   
19        \+----\< Assento   
20        |   
21        \+----\< Nominata   
22        |   
23        \+----|| AtaEvento   
24        |   
25        \+----\< Diplomacao   
26        
27     Pessoa   
28        |   
29        \+----\< RestricaoVisite 
```
 

Quantitativo de Entidades 

1     01 Pessoa (compartilhada)   
2     02 Evento   
3     03 TipoEvento   
4     04 ParticipanteEvento   
5     05 CategoriaParticipante   
6     06 Convite   
7     07 Presenca   
8     08 Acompanhante   
9     09 Assento   
10     10 ReservaAssento   
11     11 Setor   
12     12 MesaHonra   
13     13 Nominata   
14     14 NominataItem   
15     15 AtaEvento   
16     16 Diplomacao   
17     17 RestricaoVisite 

**Total: 17 entidades principais**, compatíveis com a estimativa de aproximadamente **217 Pontos de Função**, servindo como base para implementação em PostgreSQL e ORM PHP (Laravel/Symfony) dentro do ecossistema **Crepúsculo**. 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - Diagrama Sequência e de Pacotes.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - Diagrama Sequência e de Pacotes.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
Abaixo estão os diagramas em formato **PlantUML**, adequados para inclusão no DRS, TDD e futura importação para ferramentas como StarUML, Enterprise Architect, Visual Paradigm, Draw.io (via plugin PlantUML) ou Mermaid Converter. 

 

## 1\. Diagrama de Sequência 

### Fluxo Completo de Cerimonial e Presença 

```uml
1     @startuml   
2        
3     title Cerimonial \- Fluxo Principal de Convite, Credenciamento e Presença   
4        
5     actor "Cerimonial" as CER   
6     actor "Convidado" as CONV   
7     actor "Recepção" as REC   
8     actor "Cerimonialista" as CERM   
9     actor "Segurança" as SEG   
10        
11     participant "Cerimonial" as MODCER   
12     participant "Presença" as PRES   
13     participant "Visite" as VIS   
14     participant "Notificação" as NOT   
15        
16     CER \-\> MODCER : Criar Evento   
17        
18     MODCER \-\> PRES : Criar Evento Corporativo   
19     PRES \--\> MODCER : Evento Criado   
20        
21     CER \-\> MODCER : Selecionar Participantes   
22        
23     MODCER \-\> NOT : Enviar Convites   
24     NOT \-\> CONV : Convite   
25        
26     CONV \-\> MODCER : Confirmar Presença   
27     CONV \-\> MODCER : Informar Acompanhantes   
28        
29     MODCER \-\> PRES : Registrar Confirmações   
30        
31     \== Dia do Evento \==   
32        
33     REC \-\> MODCER : Pesquisar Participante   
34        
35     MODCER \-\> PRES : Consultar Participante   
36        
37     PRES \--\> MODCER : Dados do Participante   
38        
39     MODCER \-\> VIS : Validar Restrições   
40        
41     VIS \--\> MODCER : Situação do Acesso   
42        
43     alt Possui Restrição   
44        
45     MODCER \-\> SEG : Gerar Alerta   
46     SEG \-\> SEG : Aplicar Protocolo   
47        
48     else Sem Restrição   
49        
50     REC \-\> MODCER : Confirmar Presença   
51        
52     MODCER \-\> PRES : Registrar Presença   
53        
54     end   
55        
56     MODCER \--\> REC : Categoria / Cor / Assento   
57        
58     \== Cerimônia \==   
59        
60     CERM \-\> MODCER : Gerar Nominata Inicial   
61        
62     MODCER \-\> PRES : Consultar Presentes   
63        
64     PRES \--\> MODCER : Lista Atualizada   
65        
66     MODCER \--\> CERM : Nominata Inicial   
67        
68     loop Durante Evento   
69        
70     CERM \-\> MODCER : Gerar Nominata Incremental   
71        
72     MODCER \-\> PRES : Novos Presentes   
73        
74     PRES \--\> MODCER : Complemento   
75        
76     MODCER \--\> CERM : Novas Autoridades   
77        
78     end   
79        
80     \== Encerramento \==   
81        
82     CER \-\> MODCER : Finalizar Evento   
83        
84     MODCER \-\> PRES : Consolidar Presenças   
85        
86     MODCER \-\> MODCER : Gerar Ata   
87     MODCER \-\> MODCER : Gerar Nominata Final   
88        
89     MODCER \--\> CER : PDF/Ata/Nominata   
90        
91     @enduml 
```
 

2\. Diagrama de Componentes 

Arquitetura Corporativa 

Este diagrama evidencia que **Cerimonial é um módulo especializado do domínio Presença**. 
```uml
1     @startuml   
2        
3     title Arquitetura de Componentes \- Cerimonial   
4        
5     package "Crepúsculo" {   
6        
7         \[Portal Corporativo\]   
8        
9         component "Presença" as PRES   
10         component "Visite" as VIS   
11         component "Notificações" as NOT   
12         component "Autocadastro" as AUTO   
13        
14         component "Cerimonial" as CER   
15        
16     }   
17        
18     database "Base Corporativa" as DB   
19        
20     \[Portal Corporativo\] \--\> CER   
21        
22     CER \--\> PRES : Eventos\\nParticipantes\\nPresenças   
23        
24     CER \--\> VIS : Consulta Restrições   
25        
26     CER \--\> AUTO : Cadastro Externo   
27        
28     CER \--\> NOT : Convites   
29        
30     PRES \--\> DB   
31     VIS \--\> DB   
32     AUTO \--\> DB   
33     CER \--\> DB   
34        
35     component "Nominata" as NOM   
36     component "Mesa de Honra" as MESA   
37     component "Assentos" as ASS   
38     component "Credenciamento" as CRED   
39     component "Diplomação" as DIP   
40        
41     CER \-- NOM   
42     CER \-- MESA   
43     CER \-- ASS   
44     CER \-- CRED   
45     CER \-- DIP   
46        
47     @enduml 
```
 

3\. Diagrama de Pacotes 

Organização dos Módulos do Sistema 

Este diagrama orienta diretamente a estrutura de desenvolvimento. 
```
1     @startuml   
2        
3     title Organização dos Pacotes   
4        
5     package "br.jus.treac.crepusculo" {   
6        
7     	package "core" {   
8         	class Pessoa   
9         	class Evento   
10         	class Participante   
11         	class Presenca   
12         }   
13        
14     	package "seguranca" {   
15         	class Usuario   
16         	class Perfil   
17         	class Permissao   
18         }   
19        
20     	package "visite" {   
21         	class Restricao   
22         	class Ocorrencia   
23         	class Credenciamento   
24         }   
25        
26     	package "presenca" {   
27         	class Convite   
28         	class Confirmacao   
29         	class Frequencia   
30         	class Historico   
31         }   
32        
33     	package "cerimonial" {   
34        
35         	package "evento" {   
36             	class EventoCerimonial   
37             	class TipoEvento   
38             }   
39        
40         	package "participante" {   
41             	class Autoridade   
42             	class Homenageado   
43             	class Acompanhante   
44             	class Imprensa   
45             }   
46        
47         	package "protocolo" {   
48             	class Precedencia   
49             	class MesaHonra   
50             	class OrdemProtocolo   
51             }   
52        
53         	package "plenario" {   
54             	class Assento   
55             	class Setor   
56             	class Reserva   
57             }   
58        
59         	package "nominata" {   
60             	class Nominata   
61             	class NominataItem   
62             }   
63        
64         	package "diplomacao" {   
65             	class Diplomando   
66             	class Diploma   
67             	class SessaoDiplomacao   
68             }   
69         }   
70     }   
71        
72     cerimonial ..\> presenca   
73     cerimonial ..\> visite   
74     cerimonial ..\> core   
75        
76     presenca ..\> core   
77     visite ..\> core   
78        
79     @enduml 
```
 

Visão Arquitetural Consolidada 

A arquitetura resultante fica organizada da seguinte forma: 
```
1     Crepúsculo   
2     │   
3     ├── Core   
4     │ 	├── Pessoa   
5     │ 	├── Evento   
6     │ 	├── Participante   
7     │ 	└── Presença   
8     │   
9     ├── Visite   
10     │ 	├── Restrições   
11     │ 	├── Alertas   
12     │ 	└── Segurança   
13     │   
14     ├── Presença   
15     │ 	├── Convites   
16     │ 	├── Frequência   
17     │ 	├── Credenciamento   
18     │ 	└── Histórico   
19     │   
20     └── Cerimonial   
21       	├── Eventos Solenes   
22       	├── Protocolo   
23       	├── Diplomação   
24       	├── Mesa de Honra   
25       	├── Assentos   
26       	├── Nominatas   
27       	├── Autoridades   
28       	└── Credenciamento 
```
Essa modelagem deixa explícito que **Cerimonial depende do domínio Presença**, compartilhando entidades de negócio, enquanto agrega os conceitos de protocolo, precedência, diplomação, nominata e organização do plenário previstos na legislação eleitoral e nas normas de cerimonial público. 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - Documento de Requisitos de Software DRS.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - Documento de Requisitos de Software DRS.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# **Documento de Requisitos de Software (DRS)**

## **SOLENE – Gestão de Cerimonial**

**Versão:** 2.0  
 **Data:** *24/08/2026*  
 **Órgão:** Tribunal Regional Eleitoral do Acre (TRE-AC)  
 **Sistema:** SOLENE – Gestão de Cerimonial  
 **Plataforma Corporativa:** Crepúsculo  
 **Domínio de Negócio Base:** Presença – Registro de Frequência

---

# **Controle de Versões**

| Versão | Data | Responsável | Descrição |
| ----- | ----- | ----- | ----- |
| 1.0 | xx/xx/2026 | Equipe STI | Levantamento inicial |
| 2.0 | 24/08/2026 | Equipe SOLENE | Consolidação pós reunião de levantamento |

---

# **1\. Introdução**

## **1.1 Objetivo**

Este documento especifica os requisitos funcionais, não funcionais, regras de negócio, integrações, restrições técnicas e diretrizes de desenvolvimento do sistema **SOLENE – Gestão de Cerimonial**.

O sistema tem como objetivo apoiar a organização, execução, monitoramento e preservação dos eventos institucionais realizados pelo Tribunal Regional Eleitoral do Acre, incluindo cerimônias de posse, diplomações, homenagens, visitas oficiais, sessões solenes e demais eventos protocolares.

---

## **1.2 Escopo**

O SOLENE deverá permitir:

* Planejamento de eventos;  
* Gestão de convidados;  
* Controle de confirmações;  
* Credenciamento;  
* Controle de presença;  
* Gestão de autoridades;  
* Gestão de assentos;  
* Geração de nominatas;  
* Controle de precedência;  
* Emissão de relatórios;  
* Geração de atas;  
* Integração com sistemas corporativos;  
* Preservação do histórico institucional.

---

## **1.3 Sistemas Integrados**

| Sistema | Finalidade |
| ----- | ----- |
| Presença | Gerenciamento de participantes e presença |
| Visite | Segurança e restrição de acesso |
| Crepúsculo | Plataforma corporativa |
| SEI | Processos administrativos |
| Autocadastro | Registro de participantes externos |

---

# **2\. Visão Geral da Solução**

## **2.1 Contexto**

O sistema deverá substituir procedimentos atualmente realizados por:

* Planilhas Excel;  
* Listas manuais;  
* Controle por e-mail;  
* Controles dispersos em documentos.

---

## **2.2 Benefícios Esperados**

* Maior controle dos eventos;  
* Redução de retrabalho;  
* Rastreabilidade;  
* Padronização institucional;  
* Integração corporativa;  
* Segurança institucional;  
* Formação de memória organizacional.

---

# **3\. Perfis de Usuário**

## **Administrador**

Responsável pela parametrização da solução.

### **Permissões**

* Cadastro global;  
* Gestão de perfis;  
* Configurações.

---

## **Cerimonialista**

Responsável pela organização do evento.

### **Permissões**

* Criar evento;  
* Gerar nominatas;  
* Gerenciar convidados;  
* Encerrar evento.

---

## **Recepcionista**

Responsável pelo credenciamento.

### **Permissões**

* Confirmar chegada;  
* Registrar presença;  
* Consultar participantes.

---

## **Presidência**

Responsável pelo acompanhamento institucional.

### **Permissões**

* Consultas;  
* Painéis;  
* Relatórios.

---

## **Segurança Institucional**

Responsável pelas validações de segurança.

### **Permissões**

* Consultas de restrições;  
* Alertas;  
* Monitoramento.

---

# **4\. Requisitos Funcionais**

## **RF-001 – Cadastro de Eventos**

O sistema deverá permitir:

* Criar evento;  
* Editar evento;  
* Cancelar evento;  
* Encerrar evento.

### **Dados obrigatórios**

* Nome;  
* Tipo;  
* Data;  
* Hora;  
* Local;  
* Unidade responsável.

---

## **RF-002 – Classificação dos Eventos**

Categorias mínimas:

* Diplomação;  
* Posse;  
* Homenagem;  
* Sessão Solene;  
* Seminário;  
* Audiência Pública;  
* Evento Institucional.

---

## **RF-003 – Agenda Institucional de Autoridades**

O sistema deverá manter cadastro corporativo de autoridades.

### **Campos mínimos**

* Instituição;  
* Cargo;  
* Nome;  
* E-mail;  
* Telefone;  
* Status;  
* Ordem de precedência.

---

## **RF-004 – Listas de Autoridades**

Permitir criação de:

* Lista padrão institucional;  
* Lista da Presidência;  
* Lista do Empossando;  
* Lista personalizada.

---

## **RF-005 – Importação de Convidados**

Permitir importação através de:

* CSV;  
* XLSX.

---

## **RF-006 – Gestão de Convites**

Permitir:

* Inclusão individual;  
* Inclusão em lote;  
* Controle de envio;  
* Controle de resposta.

---

## **RF-007 – Registro de Confirmação**

Situações possíveis:

* Não confirmado;  
* Confirmado;  
* Representado;  
* Cancelado.

---

## **RF-008 – Controle de Representante**

Permitir substituir participante confirmado por representante autorizado.

---

## **RF-009 – Autocadastro**

Participantes externos deverão:

* Realizar cadastro;  
* Confirmar participação;  
* Informar acompanhantes.

---

## **RF-010 – Gestão de Acompanhantes**

Permitir vincular:

* Segurança;  
* Motorista;  
* Assessor;  
* Familiar;  
* Imprensa.

---

## **RF-011 – Credenciamento**

Permitir:

* Busca por CPF;  
* Busca por nome;  
* Busca por e-mail;  
* Busca por QR Code.

---

## **RF-012 – Registro de Presença**

Registrar:

* Data;  
* Hora;  
* Operador;  
* Local de acesso.

---

## **RF-013 – Controle de Assentos**

Permitir reservar assentos por:

* Autoridade;  
* Categoria;  
* Grupo;  
* Mesa de honra.

---

## **RF-014 – Classificação por Cores**

Permitir vinculação de cor à categoria protocolar.

Exemplos:

* Vermelho;  
* Azul;  
* Verde;  
* Amarelo.

---

## **RF-015 – Mesa de Honra**

Permitir:

* Ordenação;  
* Substituição;  
* Reorganização.

---

## **RF-016 – Nominata Inicial**

Gerar automaticamente a primeira relação de autoridades presentes.

---

## **RF-017 – Nominata Incremental**

Permitir gerar novas nominatas destacando apenas participantes ainda não anunciados.

---

## **RF-018 – Controle de Leituras**

Registrar:

* Número da nominata;  
* Data;  
* Hora;  
* Responsável.

---

## **RF-019 – Painel de Acompanhamento**

Disponibilizar:

* Confirmados;  
* Presentes;  
* Ausentes.

---

## **RF-020 – Ata do Evento**

Gerar ata contendo:

* Dados do evento;  
* Participantes;  
* Nominata final;  
* Histórico.

---

## **RF-021 – Exportação**

Permitir exportação para:

* PDF;  
* XLSX;  
* CSV.

---

# **5\. Regras de Negócio**

## **RN-001**

Todo participante deverá estar vinculado a um evento.

---

## **RN-002**

A confirmação de presença não implica comparecimento.

---

## **RN-003**

A presença somente será registrada após credenciamento.

---

## **RN-004**

Somente o perfil Cerimonialista poderá gerar nominatas.

---

## **RN-005**

Cada nominata gerada cria um marco temporal.

---

## **RN-006**

Participantes já anunciados deverão permanecer identificados.

---

## **RN-007**

A ordem de precedência seguirá:

* Decreto Federal nº 70.274/1972;  
* Normas da Justiça Eleitoral;  
* Regras internas do TRE-AC.

---

## **RN-008**

O sistema deverá permitir listas complementares indicadas pela Presidência ou pelo Empossando.

---

# **6\. Requisitos Não Funcionais**

## **RNF-001**

Aplicação web responsiva.

---

## **RNF-002**

Compatível com dispositivos móveis.

---

## **RNF-003**

Atualização em tempo real.

---

## **RNF-004**

Registro de auditoria completa.

---

## **RNF-005**

Controle de acesso baseado em perfis.

---

## **RNF-006**

Integração nativa com PostgreSQL.

---

## **RNF-007**

Compatível com PHP 8.x.

---

## **RNF-008**

Arquitetura compatível com a plataforma Crepúsculo.

---

## **RNF-009**

Possibilidade de operação em contingência.

---

# **7\. Casos de Uso Principais**

### **UC-01 – Criar Evento**

**Ator:** Cerimonialista

**Fluxo principal:**

1. Criar evento;  
2. Informar dados;  
3. Salvar;  
4. Disponibilizar para operacionalização.

---

### **UC-02 – Confirmar Participação**

**Ator:** Participante

**Fluxo principal:**

1. Recebe convite;  
2. Confirma presença;  
3. Registra acompanhantes;  
4. Atualiza status.

---

### **UC-03 – Credenciar Participante**

**Ator:** Recepcionista

**Fluxo principal:**

1. Localizar participante;  
2. Validar informações;  
3. Registrar chegada;  
4. Registrar presença.

---

### **UC-04 – Gerar Nominata**

**Ator:** Cerimonialista

**Fluxo principal:**

1. Solicitar geração;  
2. Sistema identifica novos presentes;  
3. Sistema destaca participantes não anunciados;  
4. Nominata é disponibilizada.

---

# **8\. Critérios de Aceitação da Solução**

A solução será considerada apta para produção quando permitir:

* Cadastro de eventos;  
* Importação de convidados;  
* Controle de confirmações;  
* Registro de presença;  
* Gestão de assentos;  
* Nominatas incrementais;  
* Exportação de relatórios;  
* Operação em contingência;  
* Integração com Presença;  
* Integração com Visite;  
* Integração com Crepúsculo.

---

# **9\. Roadmap de Implementação**

### **Fase 1**

* Eventos  
* Convidados  
* Importação CSV/XLSX  
* Categorias

### **Fase 2**

* Credenciamento  
* Presença  
* Painel Presidencial

### **Fase 3**

* Assentos  
* Mesa de Honra  
* Nominatas

### **Fase 4**

* Autocadastro  
* Convites  
* Integrações

### **Fase 5**

* Segurança  
* Visite  
* Auditoria

### **Fase 6**

* Diplomação  
* Memória institucional  
* Indicadores gerenciais

---

# **10\. Diagramas de Casos de Uso**

### **UCG-01 – Visão Geral do Sistema SOLENE**
```uml
@startuml

left to right direction

actor Administrador
actor Cerimonialista
actor Recepcionista
actor Presidencia
actor Seguranca
actor Participante

rectangle "SOLENE - Gestão de Cerimonial" {

usecase "Planejar Evento" as UC01
usecase "Gerenciar Autoridades" as UC02
usecase "Importar Convidados" as UC03
usecase "Enviar Convites" as UC04
usecase "Confirmar Participação" as UC05
usecase "Realizar Autocadastro" as UC06
usecase "Registrar Presença" as UC07
usecase "Gerar Nominata" as UC08
usecase "Gerenciar Assentos" as UC09
usecase "Gerar Ata" as UC10
usecase "Consultar Painel de Autoridades" as UC11
usecase "Validar Participantes" as UC12
usecase "Consultar Histórico" as UC13

}

Administrador --> UC01
Administrador --> UC02

Cerimonialista --> UC01
Cerimonialista --> UC02
Cerimonialista --> UC03
Cerimonialista --> UC04
Cerimonialista --> UC08
Cerimonialista --> UC09
Cerimonialista --> UC10
Cerimonialista --> UC13

Recepcionista --> UC07

Participante --> UC05
Participante --> UC06

Presidencia --> UC11

Seguranca --> UC12

@enduml
```

### **UCG-02 – Planejamento de Evento**

```uml
@startuml

left to right direction

actor Cerimonialista

rectangle "Planejamento de Evento" {

usecase "Criar Evento"
usecase "Definir Local"
usecase "Definir Capacidade"
usecase "Definir Categorias"
usecase "Configurar Assentos"
usecase "Definir Mesa de Honra"

}

Cerimonialista --> "Criar Evento"

"Criar Evento" .> "Definir Local" : <<include>>
"Criar Evento" .> "Definir Capacidade" : <<include>>
"Criar Evento" .> "Definir Categorias" : <<include>>
"Criar Evento" .> "Configurar Assentos" : <<include>>
"Criar Evento" .> "Definir Mesa de Honra" : <<include>>

@enduml
```
### **UCG-03 – Gestão de Convites**

```uml
@startuml

left to right direction

actor Cerimonialista
actor Participante

rectangle "Gestão de Convites" {

usecase "Selecionar Lista de Autoridades"
usecase "Importar Convidados"
usecase "Gerar Convites"
usecase "Enviar Convites"
usecase "Confirmar Participação"
usecase "Registrar Representante"

}

Cerimonialista --> "Selecionar Lista de Autoridades"
Cerimonialista --> "Importar Convidados"
Cerimonialista --> "Gerar Convites"
Cerimonialista --> "Enviar Convites"

Participante --> "Confirmar Participação"

"Confirmar Participação" .> "Registrar Representante" : <<extend>>

@enduml
```

### **UCG-04 – Autocadastro**

```uml
@startuml

left to right direction

actor Participante

rectangle "Autocadastro" {

usecase "Preencher Cadastro"
usecase "Atualizar Dados"
usecase "Informar Acompanhantes"
usecase "Confirmar Participação"

}

Participante --> "Preencher Cadastro"
Participante --> "Atualizar Dados"
Participante --> "Informar Acompanhantes"
Participante --> "Confirmar Participação"
@enduml
```

### **UCG-05 – Credenciamento e Presença**

```uml
@startuml

left to right direction

actor Recepcionista
actor Seguranca

rectangle "Credenciamento" {

usecase "Pesquisar Participante"
usecase "Validar Restrições"
usecase "Registrar Chegada"
usecase "Registrar Presença"
usecase "Emitir Alerta"

}

Recepcionista --> "Pesquisar Participante"

"Pesquisar Participante"
 .> "Validar Restrições"
 : <<include>>

"Validar Restrições"
 .> "Emitir Alerta"
 : <<extend>>

Recepcionista --> "Registrar Chegada"
Recepcionista --> "Registrar Presença"

Seguranca --> "Emitir Alerta"

@enduml
```

### **UCG-06 – Gestão da Solenidade**

```uml
@startuml

left to right direction

actor Cerimonialista

rectangle "Cerimônia" {

usecase "Gerar Nominata Inicial"
usecase "Gerar Nominata Incremental"
usecase "Controlar Autoridades Anunciadas"
usecase "Consultar Presentes"
usecase "Encerrar Evento"

}

Cerimonialista --> "Gerar Nominata Inicial"

"Gerar Nominata Incremental"
 .> "Controlar Autoridades Anunciadas"
 : <<include>>

"Gerar Nominata Incremental"
 .> "Consultar Presentes"
 : <<include>>

Cerimonialista --> "Gerar Nominata Incremental"
Cerimonialista --> "Encerrar Evento"

@enduml
```

### **UCG-07 – Painel Presidencial**

```uml
@startuml

left to right direction

actor Presidencia

rectangle "Painel Presidencial" {

usecase "Consultar Autoridades Confirmadas"
usecase "Consultar Autoridades Presentes"
usecase "Consultar Autoridades Ausentes"
usecase "Consultar Ocupação do Evento"

}

Presidencia --> "Consultar Autoridades Confirmadas"
Presidencia --> "Consultar Autoridades Presentes"
Presidencia --> "Consultar Autoridades Ausentes"
Presidencia --> "Consultar Ocupação do Evento"

@enduml
```

### **UCG-08 – Encerramento e Histórico**

```uml
@startuml

left to right direction

actor Cerimonialista

rectangle "Encerramento" {

usecase "Gerar Nominata Final"
usecase "Gerar Ata"
usecase "Exportar PDF"
usecase "Exportar XLSX"
usecase "Arquivar Evento"
usecase "Consultar Histórico"

}

Cerimonialista --> "Gerar Nominata Final"

"Gerar Ata"
 .> "Gerar Nominata Final"
 : <<include>>

"Gerar Ata"
 .> "Exportar PDF"
 : <<include>>

Cerimonialista --> "Arquivar Evento"
Cerimonialista --> "Consultar Histórico"

@enduml
```
### Mapa Funcional Consolidado
```
SOLENE
│
├── Planejamento
│   ├── Eventos
│   ├── Autoridades
│   ├── Assentos
│   └── Mesa de Honra
│
├── Convites
│   ├── Listas
│   ├── Importação
│   ├── Confirmação
│   └── Representação
│
├── Credenciamento
│   ├── Check-in
│   ├── Presença
│   ├── Visite
│   └── Segurança
│
├── Cerimônia
│   ├── Nominata Inicial
│   ├── Nominata Incremental
│   └── Controle de Autoridades
│
├── Presidência
│   └── Painel em Tempo Real
│
└── Histórico
    ├── Ata
    ├── Exportações
    ├── Diplomação
    └── Memória Institucional
```
Esses oito diagramas cobrem integralmente os requisitos consolidados do SOLENE v2.0 e podem ser inseridos diretamente no DRS como seção de Modelagem Funcional UML, servindo também de base para derivação automática das Issues do GitLab, Casos de Teste e Stories para as futuras sprints de desenvolvimento.

**Documento:** DRS-SOLENE-v2.0  
 **Status:** Em elaboração para submissão à Alta Administração e aprovação para desenvolvimento.

---

## Documento de Requisitos de Software (DRS) 

Projeto: Solene - Gestão de Cerimonial 

*    **Módulo Especializado da Plataforma Presença**

**Versão:** 1.0   
**Órgão:** Tribunal Regional Eleitoral do Acre – TRE-AC   
**Projeto:** Cerimonial   
**Sistema Base:** Presença – Registro de Frequência   
**Ecossistema:** Crepúsculo 

 

### 1\. Introdução 

#### 1.1 Finalidade 

Este documento descreve os requisitos funcionais, não funcionais, regras de negócio, integrações e restrições para desenvolvimento do módulo **Cerimonial**, destinado ao planejamento, organização, execução e registro histórico de eventos institucionais realizados pelo Tribunal. 

O módulo deverá operar como extensão do domínio corporativo **Presença**, aproveitando integralmente sua modelagem de dados e serviços compartilhados. 

 

#### 1.2 Objetivos 

A solução deverá: 

* Automatizar atividades do Cerimonial.   
* Apoiar a Comissão Permanente de Cerimonial e Protocolo.   
* Padronizar procedimentos protocolares.   
* Integrar-se ao Visite.   
* Integrar-se ao Crepúsculo.   
* Integrar-se ao domínio Presença.   
* Permitir rastreabilidade completa dos eventos.   
* Preservar histórico institucional. 

 

### 2\. Escopo 

O sistema deverá administrar: 

* Eventos institucionais.   
* Sessões solenes.   
* Diplomações.   
* Posse de magistrados.   
* Homenagens.   
* Visitas oficiais.   
* Entrega de títulos e comendas.   
* Eventos corporativos internos. 

 

### 3\. Premissas Arquiteturais 

RN001 – Plataforma Compartilhada 

O módulo Cerimonial não possuirá base própria de pessoas. 

Deverá utilizar: 

* Pessoa   
* Participante   
* Convite   
* Evento   
* Credenciamento   
* Presença 

oriundos da plataforma Presença. 

 

RN002 – Fonte Única de Verdade 

Todas as informações de presença deverão permanecer armazenadas exclusivamente no domínio Presença. 

O Cerimonial apenas acrescenta metadados protocolares. 

 

### 4\. Perfis de Usuário 

Administrador 

Responsável pela parametrização do sistema. 

 

Equipe de Cerimonial 

Responsável pelo planejamento e execução dos eventos. 

 

Recepcionista 

Responsável pelo credenciamento e confirmação de presença. 

 

Cerimonialista 

Responsável pelas nominatas e condução dos eventos. 

 

Segurança Institucional 

Responsável pelas validações oriundas do Visite. 

 

Participante 

Pessoa convidada para determinado evento. 

 

### 5\. Requisitos Funcionais 

RF-001 – Criar Evento 

Permitir cadastrar: 

* Nome   
* Tipo   
* Data   
* Hora   
* Local   
* Descrição   
* Organizadores   
* Unidade responsável 

 

RF-002 – Categorizar Evento 

Categorias mínimas: 

* Diplomação   
* Posse   
* Sessão Solene   
* Homenagem   
* Seminário   
* Audiência Pública   
* Evento Institucional 

 

RF-003 – Gerenciar Convites 

Permitir: 

* Cadastro individual   
* Importação em lote   
* Geração de convites   
* Envio de notificações 

 

RF-004 – Confirmar Participação 

O convidado poderá: 

* Confirmar presença.   
* Recusar participação.   
* Informar substituto.   
* Informar acompanhantes. 

 

RF-005 – Autocadastro 

Deverá permitir: 

* Cadastro do participante.   
* Atualização cadastral.   
* Inclusão de acompanhantes. 

 

RF-006 – Gestão de Participantes 

Categorias: 

* Autoridade   
* Magistrado   
* Homenageado   
* Convidado   
* Familiar   
* Imprensa   
* Segurança   
* Motorista   
* Apoio Operacional 

 

RF-007 – Gestão de Credenciamento 

Permitir: 

* Busca nominal.   
* Busca por CPF.   
* Busca por QR-Code.   
* Busca por e-mail. 

 

RF-008 – Registro de Presença 

Registrar: 

* Data.   
* Hora.   
* Operador.   
* Local. 

 

RF-009 – Inclusão Emergencial 

Permitir registro imediato de participante não previsto. 

 

RF-010 – Controle de Assentos 

Permitir: 

* Reservar assentos.   
* Definir setores.   
* Definir áreas restritas.   
* Definir mesa de honra. 

 

RF-011 – Identificação por Cores 

Permitir classificação visual por categorias. 

Exemplo: 

* Vermelho   
* Verde   
* Azul   
* Amarelo 

 

RF-012 – Geração de Nominata 

Permitir gerar nominata: 

* Inicial.   
* Intermediária.   
* Final. 

 

RF-013 – Controle de Anúncios 

Permitir marcar: 

* Anunciado.   
* Não anunciado. 

 

RF-014 – Composição de Mesa 

Permitir: 

* Inclusão.   
* Ordenação.   
* Reordenação.   
* Substituição. 

 

RF-015 – Encerramento do Evento 

Permitir concluir evento e consolidar seus registros. 

 

RF-016 – Exportação Documental 

Gerar: 

* PDF   
* DOCX   
* XLSX 

 

RF-017 – Histórico Institucional 

Manter acervo permanente dos eventos realizados. 

 

### 6\. Integrações 

RF-018 – Integração Presença 

Compartilhar: 

* Pessoas   
* Eventos   
* Participações   
* Convites   
* Presenças 

 

RF-019 – Integração Visite 

Consultar: 

* Restrições   
* Alertas   
* Impedimentos 

 

RF-020 – Integração Crepúsculo 

Permitir acesso aos serviços corporativos. 

 

### 7\. Regras de Negócio 

RN-001 

Participante deve pertencer a um evento. 

 

RN-002 

Participante pode estar vinculado a mais de um evento. 

 

RN-003 

Acompanhantes devem estar vinculados ao titular. 

 

RN-004 

Toda presença deve possuir registro temporal. 

 

RN-005 

Após encerrado o evento, registros somente poderão ser alterados mediante autorização administrativa. 

 

RN-006 

Toda nominata deverá refletir a situação real de presença no momento de sua emissão. 

 

RN-007 

A ordem de precedência deverá observar as normas do Cerimonial Público. 

 

### 8\. Requisitos Não Funcionais 

RNF-001 

Aplicação Web. 

RNF-002 

Interface responsiva. 

RNF-003 

Atualização em tempo real. 

RNF-004 

Registro de auditoria. 

RNF-005 

Controle de acesso baseado em perfis. 

RNF-006 

Alta disponibilidade. 

RNF-007 

Compatível com PHP 8.x. 

RNF-008 

Banco PostgreSQL. 

 

Documento Técnico de Desenvolvimento (TDD) 

1\. Arquitetura 
``` 
1     Crepúsculo   
2     │   
3     ├── Presença   
4     │	├── Pessoa   
5     │	├── Evento   
6     │	├── Convite   
7     │	├── Credenciamento   
8     │	└── Presença   
9     │   
10     ├── Visite   
11     │	├── Restrição   
12     │	├── Ocorrência   
13     │	└── Segurança   
14     │   
15     └── Cerimonial   
16      	├── Protocolo   
17      	├── Precedência   
18      	├── Assentos   
19      	├── Mesa Honra   
20      	├── Nominatas   
21      	└── Diplomação 
```
 

2\. Modelo de Dados 

Evento 

1     evento   
2     \-------   
3     id   
4     tipo\_evento\_id   
5     nome   
6     descricao   
7     data\_inicio   
8     data\_fim   
9     local   
10     capacidade   
11     situacao 

 

ParticipanteEvento 

1     participante\_evento   
2     \-------------------   
3     id   
4     evento\_id   
5     pessoa\_id   
6     categoria\_id   
7     confirmacao   
8     presenca   
9     credenciamento 

 

CategoriaParticipante 

1     categoria\_participante   
2     \-----------------------   
3     id   
4     nome   
5     cor\_identificacao   
6     precedencia 

 

Acompanhante 

1     acompanhante   
2     \-------------   
3     id   
4     titular\_id   
5     pessoa\_id   
6     tipo 

 

Assento 

1     assento   
2     \---------   
3     id   
4     evento\_id   
5     codigo   
6     setor   
7     fileira   
8     cadeira   
9     reservado 

 

ReservaAssento 

1     reserva\_assento   
2     \----------------   
3     id   
4     assento\_id   
5     participante\_evento\_id 

 

MesaHonra 

1     mesa\_honra   
2     \-----------   
3     id   
4     evento\_id   
5     nome   
6     ordem   
7     participante\_evento\_id 

 

Nominata 

1     nominata   
2     \----------   
3     id   
4     evento\_id   
5     tipo   
6     gerada\_em   
7     usuario\_id 

 

NominataItem 

1     nominata\_item   
2     \--------------   
3     id   
4     nominata\_id   
5     participante\_evento\_id   
6     anunciado   
7     ordem 

 

### 3\. Serviços 

Serviço de Convite 

1     CriarEvento   
2     CadastrarConvidados   
3     EnviarConvites   
4     ReceberConfirmações 

 

Serviço de Credenciamento 

1     ConsultarParticipante   
2     RegistrarChegada   
3     RegistrarPresença   
4     EmitirCredencial 

 

Serviço de Segurança 

1     ConsultarVisite   
2     ObterRestrições   
3     GerarAlerta   
4     NotificarSegurança 

 

Serviço de Nominatas 

1     GerarNominataInicial   
2     GerarNominataIncremental   
3     GerarNominataFinal 

 

### 4\. Fluxo Principal 
```
1     Criar Evento   
2      	↓   
3     Enviar Convites   
4      	↓   
5     Confirmações   
6      	↓   
7     Autocadastro   
8      	↓   
9     Credenciamento   
10      	↓   
11     Validação Visite   
12      	↓   
13     Registro Presença   
14      	↓   
15     Acomodação   
16      	↓   
17     Nominata Inicial   
18      	↓   
19     Nominatas Incrementais   
20      	↓   
21     Encerramento   
22      	↓   
23     Ata Final   
24      	↓   
25     Histórico 
```
 

### 5\. Roadmap de Desenvolvimento 

Fase 1 – Base Corporativa 

* Integração Presença   
* Cadastro de eventos   
* Cadastro de participantes   
* Convites 

Fase 2 – Credenciamento 

* Check-in   
* Presença   
* QR-Code   
* Integração Visite 

Fase 3 – Cerimonial 

* Precedência   
* Mesa de honra   
* Assentos   
* Cores 

Fase 4 – Nominatas 

* Nominata dinâmica   
* Controle de anúncios   
* Exportações 

Fase 5 – Diplomação 

* Gestão de diplomandos   
* Mesa solene   
* Protocolo eleitoral   
* Registro histórico 

### Fase 6 – Inteligência Institucional 

* Estatísticas   
* Indicadores   
* Painéis gerenciais   
* Histórico consolidado de eventos e presenças. 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial_-_Documento_de_Requisitos_e_DRS_v2.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial_-_Documento_de_Requisitos_e_DRS_v2.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# **Especificação Técnica Completa: Sistema SOLENE – Gestão de Cerimonial (TRE-AC)**

## **PARTE I: DOCUMENTO DE REQUISITOS (DR) \- ESPECIFICAÇÃO DE NEGÓCIO E PROTOCOLO**

### **1\. Contextualização Institucional Expandida**

O Cerimonial da Justiça Eleitoral transcende a mera organização de eventos; ele é o guardião da liturgia institucional e o garantidor da imagem pública do Poder Judiciário. Fundamentado na **Resolução nº 349/2002**, o cerimonial do Tribunal Regional Eleitoral do Acre (TRE-AC) assegura que os ritos de diplomação, posse e sessões solenes reflitam a soberania democrática. A **Comissão Permanente de Cerimonial e Protocolo** atua como fiel depositária da memória institucional, coordenando desde a gestão de autoridades até a preservação histórica dos atos solenes.

Para fins de governança e suporte administrativo, seguem os dados técnicos da unidade:

| Item | Especificação Técnica |
| :---- | :---- |
| **Endereço Sede** | Alameda Ministro Miguel Ferrante, 224, Bairro Portal da Amazônia, CEP 69915-632, Rio Branco \- AC |
| **Telefone Oficial** | (68) 3212-6125 |
| **E-mail Institucional** | cerimonial@tre-ac.jus.br |

**Análise de Impacto ("So What?"):** A transição do modelo analógico, baseado em planilhas isoladas e trocas de e-mails, para o ecossistema digital do SOLENE, é uma manobra de mitigação de riscos críticos. Ao digitalizar o protocolo, eliminamos o erro humano na aplicação da precedência e garantimos a integridade dos dados em tempo real. A modernização não apenas aumenta a eficiência operacional, mas blinda o Tribunal contra incidentes diplomáticos e falhas protocolares em eventos de alta complexidade.

### **2\. Fundamentação Normativa e Legal**

A conformidade legal é o alicerce para a legitimidade dos atos de diplomação e posse. O sistema SOLENE converte a complexidade jurídica em lógica algorítmica, garantindo que as regras de precedência e os ritos de diplomação sejam aplicados de forma automatizada e incontestável.

| Norma | Link Externo Direto | Aplicação Prática no Sistema |
| :---- | :---- | :---- |
| **Decreto Federal nº 70.274/1972** | [Link Planalto](https://www.planalto.gov.br/ccivil_03/decreto/d70274.htm) | Define o algoritmo de precedência na Mesa de Honra e assentos. |
| **Resolução TSE nº 23.677/2021** | [Link TSE](https://www.tse.jus.br/legislacao/compilada/res/2021/resolucao-no-23-677-de-16-de-dezembro-de-2021) | Regulamenta os procedimentos e requisitos para a diplomação. |
| **Código Eleitoral** | [Link TSE](https://www.tse.jus.br/legislacao/codigo-eleitoral/codigo-eleitoral-1/codigo-eleitoral-lei-nb0-4.737-de-15-de-julho-de-1965) | Fundamenta o ato de diplomação como certificação de mandato. |
| **Resolução TRE-AC nº 349/2002** | [Link TRE-AC](https://www.justicaeleitoral.jus.br/arquivos/tre-ac-resolucao-n.-349-2002/@@display-file/file/tre-ac-2002-12-resolucao349.pdf) | Institui a Comissão e define competências de cerimonial. |
| **Regimento Interno do TRE-AC** | [Link TRE-AC](https://www.tre-ac.jus.br/legislacao/resolucoes-tre) | Estabelece diretrizes para sessões solenes e posses na Corte. |

**Análise de Impacto ("So What?"):** O impacto normativo dita a arquitetura do código. Por exemplo, o **Decreto nº 70.274/1972** não é apenas uma referência, mas a base do motor de regras que ordena a Mesa de Honra. Ao codificar a norma, o sistema remove a subjetividade do cerimonialista, protegendo a instituição de questionamentos hierárquicos e assegurando a retidão do rito oficial.

### **3\. Histórico de Levantamentos e Análise Operacional**

O desenvolvimento do SOLENE foi validado através de marcos técnicos que traduziram a liturgia em requisitos sistêmicos.

* **Reunião de 08/07/2026:** Conduzida por Lucir Rocio Vaz e Rose Moreira, focou na integração ao ecossistema Crepúsculo e na necessidade de segurança via sistema Visite.  
* **Reunião de 24/08/2026:** Validou protótipos e a necessidade de importação via CSV/XLSX, além de estabelecer a agenda dinâmica de autoridades.

  #### **Delineamento Operacional e Estratégia de Contingência**

Uma distinção crítica foi estabelecida entre:

1. **Confirmação de Participação:** Intenção declarada pelo convidado.  
2. **Presença Efetiva:** Registro físico no momento do credenciamento (Check-in).

**Estratégia de Contingência:**

* **Plano A (SOLENE):** Fluxo digital total integrado.  
* **Plano B (Solução Anterior):** Utilização de sistema legado transicional.  
* **Plano C (Listas Impressas):** Procedimento manual para falha total de infraestrutura.

**Análise de Impacto ("So What?"):** A distinção entre confirmação e presença física é o que permite a geração de **Nominatas Incrementais**. Sem o dado de "Presença Efetiva", o Mestre de Cerimônias correria o risco fatal de anunciar uma autoridade ausente, gerando um constrangimento protocolar irremediável.

## **PARTE II: DOCUMENTO DE REQUISITOS DE SISTEMA (DRS) \- ESPECIFICAÇÃO ARQUITETURAL E MODELAGEM**

### **4\. Arquitetura de Sistemas e Integrações (Ecossistema Crepúsculo)**

O SOLENE é um módulo especializado da **Plataforma Presença**, operando sob a premissa de **"Fonte Única de Verdade"**. O sistema não cria cadastros isolados de pessoas; ele consome a entidade global 'Pessoa' do ecossistema Crepúsculo.

**Integrações Estratégicas:**

* **Presença:** Herança de lógica de eventos e registros de frequência.  
* **Visite:** Segurança institucional com verificação de restrições de acesso e alertas silenciosos.  
* **SEI:** Integração com processos administrativos de contratação e histórico.  
* **Autocadastro:** Portal para que voluntários e acompanhantes insiram seus dados, otimizando o fluxo de recepção.

**Análise de Impacto ("So What?"):** Esta arquitetura integrada transforma o credenciamento em uma barreira de segurança ativa. Ao cruzar os dados com o Visite, o cerimonial não apenas recebe o convidado, mas valida sua integridade perante o Tribunal, garantindo que a solenidade ocorra em ambiente controlado e seguro.

### **5\. Mapeamento de Requisitos, Regras e Casos de Uso**

#### **Requisitos Funcionais (Exaustivo)**

* **RF-001:** Cadastro de Eventos (Criar, Editar, Cancelar, Encerrar).  
* **RF-002:** Classificação de Eventos (Diplomação, Posse, Homenagem, Sessão Solene, etc.).  
* **RF-003:** Agenda Institucional Dinâmica de Autoridades.  
* **RF-004:** Gestão de Listas de Autoridades (Padrão, Presidência, Empossando).  
* **RF-005:** Importação de Convidados (CSV/XLSX).  
* **RF-006:** Gestão de Convites (Envio individual e em lote).  
* **RF-007:** Registro de Status de Confirmação (Confirmado, Representado, Cancelado).  
* **RF-008:** Controle de Representantes (Substituição de autoridade).  
* **RF-009:** Portal de Autocadastro para participantes externos.  
* **RF-010:** Gestão de Acompanhantes (Vinculação de segurança, motorista, familiar).  
* **RF-011:** Credenciamento Multimodal (Busca CPF, Nome, QR Code).  
* **RF-012:** Registro de Presença (Data, Hora, Operador, Local).  
* **RF-013:** Integração Visite (Validação de restrições no check-in).  
* **RF-014:** Alertas de Segurança (Comunicação imediata com a equipe de segurança).  
* **RF-015:** Configuração de Layout do Plenário (Setores, Mesa de Honra).  
* **RF-016:** Reserva de Assentos (Por autoridade, categoria ou grupo).  
* **RF-017:** Identificação Visual por Cores:  
  * 🔴 **Vermelho:** Magistrados e Membros da Corte (Alta Hierarquia).  
  * 🔵 **Azul:** Autoridades Externas.  
  * 🟢 **Verde:** Homenageados e Diplomandos.  
  * 🟡 **Amarelo:** Convidados Gerais e Familiares.  
* **RF-018:** Geração de Nominata Inicial (Autoridades presentes na abertura).  
* **RF-019:** Geração de Nominata Incremental (Somente autoridades que chegaram após a última leitura).  
* **RF-020:** Controle de Status de Leitura (Sinalização visual de "Anunciado" vs "Pendente").  
* **RF-021:** Gestão de Mesa de Honra (Ordenação, inclusão e substituição).  
* **RF-022:** Algoritmo de Precedência (Respeito automático ao Decreto 70.274/1972).  
* **RF-023:** Encerramento e Bloqueio de Alterações após finalização do evento.  
* **RF-024:** Geração Automática de Ata do Evento.  
* **RF-025:** Exportação de Documentos (PDF, DOCX, XLSX).  
* **RF-026:** Acervo Histórico Permanente.  
* **RF-027:** Ferramenta de Pesquisa Histórica por nome, cargo ou período.

  #### **Requisitos Não Funcionais**

* **RNF-001:** Interface Web Responsiva e Mobile-Friendly.  
* **RNF-002:** Atualização de dados em tempo real (Real-time updates).  
* **RNF-003:** Auditoria completa de logs (Trilha de modificações).  
* **RNF-004:** Controle de acesso baseado em Perfis (Role-Based Access Control).  
* **RNF-005:** Alta Disponibilidade e Desempenho sub-segundo para credenciamento.  
* **RNF-006:** Integração Nativa com Banco de Dados PostgreSQL.  
* **RNF-007:** Desenvolvimento em Stack PHP 8.x.  
* **RNF-008:** Arquitetura compatível com Plataforma Crepúsculo.  
* **RNF-009:** Capacidade de Operação em Modo de Contingência.

  #### **Regras de Negócio e Casos de Uso**

* **RN-007 (Precedência):** A ordem de assentos na Mesa de Honra é imutável perante a lógica do Decreto 70.274/1972.  
* **UC-04 (Nominata):** O cerimonialista gera a nominata; o sistema identifica quem chegou após o último marco temporal e destaca em **Vermelho** (pendente) ou **Cinza** (anunciado).

### **6\. Modelagem de Dados e DER Integrado**

O modelo de dados é normalizado para garantir a integridade histórica de cada solenidade.

**Entidades Principais (17):**

1. Pessoa | 2\. Evento | 3\. ParticipanteEvento | 4\. CategoriaParticipante | 5\. Convite | 6\. Presenca | 7\. Acompanhante | 8\. Assento | 9\. ReservaAssento | 10\. Setor | 11\. MesaHonra | 12\. Nominata | 13\. NominataItem | 14\. AtaEvento | 15\. Diplomacao | 16\. TipoEvento | 17\. RestricaoVisite.

**Cardinalidades e Relacionamentos:**

* **Pessoa (1) : (N) ParticipanteEvento:** Uma pessoa pode participar de múltiplos eventos históricos.  
* **Evento (1) : (N) ParticipanteEvento:** Um evento consolida diversos perfis de participantes.  
* **ParticipanteEvento (1) : (1) ReservaAssento:** O pivô central que vincula o protocolo (cadeira) à pessoa física.  
* **ParticipanteEvento (1) : (N) Acompanhante:** Permite o rastreio de seguranças e assessores vinculados à autoridade titular.

**Análise de Impacto ("So What?"):** A entidade **ParticipanteEvento** é o coração do sistema. Ela resolve a relação N:N entre Pessoas e Eventos, carregando consigo os metadados de categoria e cor. Sem essa estrutura normalizada, seria impossível gerar relatórios históricos precisos ou manter a ordem de precedência consistente ao longo dos anos.

### **7\. Viabilidade Técnica, Estimativa APF e Roadmap**

O SOLENE será desenvolvido internamente, aproveitando o conhecimento de domínio da equipe do TRE-AC.

#### **Análise de Pontos de Função (APF)**

* **Tamanho Funcional:** 217 PF.  
* **Esforço Estimado:** 2.604 horas.  
* **Custo de Pessoal (Base):** R$ 213.568,14.  
* **Reserva Técnica (20%):** R$ 42.713,63.  
* **Investimento Global:** **R$ 256.281,77**.

  #### **Roadmap de Implementação (6 Fases)**

1. **Fase 1: Análise e Arquitetura:** Definição de fluxos e integração com Domínio Presença.  
2. **Fase 2: Desenvolvimento Base:** Cadastro de eventos, participantes e importação massiva.  
3. **Fase 3: Módulos de Cerimonial:** Gestão de assentos, Mesa de Honra e motor de precedência.  
4. **Fase 4: Nominatas e Exportações:** Lógica incremental e geração de documentos oficiais (Atas).  
5. **Fase 5: Segurança e Auditoria:** Integração com sistema Visite e trilhas de segurança.  
6. **Fase 6: Inteligência Institucional:** Painéis gerenciais, diplomação e acervo histórico consolidado.

**Análise de Impacto ("So What?"):** A **Reserva Técnica de 20%** é uma salvaguarda estratégica vital. No rito eleitoral, mudanças súbitas em resoluções do TSE podem exigir adaptações imediatas na lógica do sistema. Esta reserva garante que o projeto não sofra paralisia operacional diante de novas exigências normativas, assegurando a entrega contínua de valor à Justiça Eleitoral do Acre.

1. 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial_-_Especificação_da_Iconografia_SOLENE.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial_-_Especificação_da_Iconografia_SOLENE.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
## **Manual de Identidade Visual: Sistema SOLENE – Gestão de Cerimonial**

Este manual estabelece as diretrizes fundamentais para a identidade visual do sistema **SOLENE**, a solução tecnológica estratégica do Tribunal Regional Eleitoral do Acre (TRE-AC). Fundamentado na **Resolução nº 349/2002**, que institui a Comissão Permanente de Cerimonial e Protocolo, o sistema SOLENE transcende a automação funcional, agindo como um guardião da memória institucional e do rigor protocolar exigido pela Justiça Eleitoral. A marca deve projetar uma "Brasilidade Sutil", unindo a solidez histórica do Judiciário à agilidade da gestão digital moderna, sempre pautada pela elegância, sobriedade e eficiência.

**Pilares da Marca**

* **Legitimidade Democrática:** Representada visualmente por eixos horizontais, simetria e pesos visuais sólidos que evocam a estabilidade das instituições.  
* **Soberania Institucional:** Um tom de voz visual sofisticado que reforça o respeito aos ritos e à ordem de precedência (Decreto Federal nº 70.274/1972).  
* **Brasilidade Sutil:** Uso de texturas e grafismos orgânicos aplicados de forma desaturada, celebrando a identidade nacional sem concessões ao clichê.  
* **Eficiência Tecnológica:** Design minimalista e responsivo que traduz a modernização dos processos de credenciamento e gestão de nominatas.

### **1\. Logomarca Principal e Simbolismo**

A logomarca SOLENE deve equilibrar a tradição secular do Poder Judiciário com a inovação tecnológica do ecossistema **Crepúsculo**.

* **O Símbolo:** Deve ser construído em estilo *flat* ou *semi-flat*, utilizando linhas limpas que formem uma metáfora visual de organização e equilíbrio. Recomenda-se a estilização de elementos arquitetônicos do Tribunal ou de uma balança estilizada em traços contemporâneos, enfatizando proporções equilibradas para transmitir estabilidade.  
* **Tipografia do Nome:** O nome "SOLENE" deve ser apresentado em caixa alta ou alta/baixa com espaçamento (kerning) generoso, sugerindo autoridade e clareza.  
* **Equilíbrio Visual:** A marca deve possuir uma base visual sólida, evitando ornamentos excessivos, focando em formas geométricas que facilitem a aplicação em diversos materiais institucionais.

### **2\. Ícone da Aplicação**

O ícone é a assinatura sintética do sistema, otimizado para reconhecimento imediato em interfaces digitais e dispositivos móveis.

* **Simplificação Radical:** O ícone deve isolar o elemento simbólico principal da logomarca, garantindo legibilidade em tamanhos reduzidos (16px a 128px).  
* **Adaptabilidade de Fundo:** Devem ser previstas variações para "Modo Escuro" (Dark Mode) e fundos claros, mantendo o contraste sem sacrificar a integridade do símbolo.  
* **Restrições de Design:** Proibido o uso de sombras complexas, gradientes de alta saturação ou detalhes filigranados que desapareçam em resoluções de baixa densidade.

### **3\. Paleta de Cores**

A paleta de cores resolve a dualidade entre a identidade das autoridades e as necessidades funcionais de alerta da interface, conforme os requisitos da **Ata de Levantamento**.

| Categoria | Uso Pretendido | Significado Institucional | Sugestão HEX |
| :---- | :---- | :---- | :---- |
| **Vinho Institucional** | Identificação de Desembargadores e alta cúpula. | Cor das vestes talares; dignidade e autoridade máxima. | `#800020` |
| **Cinza Executivo** | Fundo de UI, menus e autoridades já anunciadas. | Neutralidade, modernidade e conclusão de etapa. | `#F2F2F2` / `#4A4A4A` |
| **Bege Sofisticado** | Áreas de respiro, painéis e fundos institucionais. | Sobriedade, equilíbrio e elegância clássica. | `#E5D3B3` |
| **Vermelho Alerta** | Status "Pendente" na Nominata e Alertas Visite. | Atenção imediata; funcionalidade de segurança e urgência. | `#E30613` |
| **Cores de Setor** | Verde, Azul e Amarelo (Categorias Institucionais). | Organização por grupos e fluxos de recepção no plenário. | Variados (Saturados) |

### **4\. Tipografia Recomendada**

A hierarquia tipográfica reforça a transição entre o documento oficial (tradição) e a tela (modernidade).

* **Títulos e Identidade (Serifada):** Recomenda-se o uso de fontes como **Cinzel** ou **Playfair Display**. Estas fontes evocam a tipografia lapidar (gravada em pedra), transmitindo solidez, confiabilidade e a autoridade inerente aos atos oficiais.  
* **Corpo de Texto e Interface (Sans-Serif):** Para a interface (labels, botões e dados), recomenda-se **Montserrat** ou **Roboto**. A ausência de serifa prioriza a limpeza visual e a legibilidade em dispositivos móveis durante o credenciamento sob pressão operacional.

### **5\. Iconografia das Funcionalidades**

Os ícones devem ser intuitivos e respeitar a simbologia institucional do TRE-AC.

* **Convites:** Representação de envelope com sinal de transmissão, indicando o fluxo de envio eletrônico do sistema.  
* **Nominatas (RF018/RF019):** Ícone de lista estruturada com um marcador dinâmico que mude de cor entre Cinza (Anunciado) e Vermelho Alerta (Pendente).  
* **Assentos (Setores):** Representação do mapeamento do plenário, destacando a **Mesa de Honra** (conforme RF021).  
* **Credenciamento:** Metáfora de check-in integrando um elemento de QR Code e crachá.  
* **Diplomação:** Representação oficial baseada na **Resolução TSE nº 23.677/2021**, incorporando o motivo do **Selo Nacional** ou Brasão da República, diferenciando-o de certificados acadêmicos.

### **6\. Elementos Visuais e Brasilidade Sutil**

A aplicação de texturas e imagens deve seguir o critério de sofisticação institucional, evitando clichês.

1. **Padrões e Texturas:** Utilizar grafismos inspirados em azulejaria ou padrões indígenas como **marcas d'água de baixa opacidade** (3% a 5%) em fundos de tela. Estes elementos devem ser quase imperceptíveis, servindo apenas para dar profundidade à interface.  
2. **Uso de Imagens:** Priorizar fotografias da sede do TRE-AC, especificamente marcos como a **Alameda Ministro Miguel Ferrante**. As imagens devem passar por filtros de dessaturação ou tons de sépia suave para manter o foco no conteúdo do sistema.

### **7\. Diretrizes de Interface e UX (User Experience)**

O design de interface do SOLENE deve ser uma ferramenta de suporte crítico para o operador em eventos de alta complexidade.

**Mandamentos de Design de Interface**

* **Prioridade de Segurança (Integração Visite):** Ao detectar uma restrição de acesso no sistema **Visite** durante o check-in (RF013), a interface deve apresentar um padrão de alerta de alto contraste, visível para o operador, mas discreto para o convidado.  
* **Lógica de Nominata Incremental:** A UI deve separar claramente as autoridades presentes em dois blocos: "Para Anunciar" (destaque visual) e "Anunciados" (visual neutro), atualizando em tempo real conforme novos participantes chegam.  
* **Agilidade no Credenciamento:** O campo de busca (CPF/Nome) deve ser o elemento central da tela de recepção, com suporte para leitura de QR Code em milissegundos.  
* **Simplicidade Pragmática:** Reduzir cliques no fluxo de "Inclusão Emergencial" (RF012), garantindo que o cerimonialista não perca o tempo do protocolo.  
* **Responsividade Crítica:** A interface de consulta de assentos deve ser otimizada para tablets, auxiliando as equipes de apoio na condução de autoridades pelo plenário.

## **Manual de Identidade Visual: Iconografia Completa do Sistema SOLENE**

#### **1\. Fundamentos e Filosofia de Design**

O sistema SOLENE (Gestão de Cerimonial) transcende a funcionalidade utilitária para consolidar-se como o eixo de modernização dos atos protocolares do Tribunal Regional Eleitoral do Acre (TRE-AC). A iconografia proposta não é um adorno, mas uma infraestrutura semiótica projetada para refletir a legitimidade democrática e a excelência administrativa. A filosofia de design fundamenta-se no minimalismo  *semi-flat* , onde a simplicidade das linhas reduz a carga cognitiva sem sacrificar a solenidade. O projeto incorpora a "Brasilidade Sutil" através de motivos inspirados na "Ágora" (a praça de diálogo democrático) e na estilização do "S" de Solene em linhas que evocam a elegância orgânica de tulipas e lírios, mesclando a rigidez institucional com a fluidez da natureza amazônica.A estética visual adota uma grade de precisão ( *pixel-perfect grid* ) que equilibra o tradicional e o moderno. Ao utilizar padrões geométricos inspirados em grafismos indígenas e azulejos coloniais como texturas de fundo ( *layers*  de suporte), o sistema comunica uma identidade que é, simultaneamente, regional e universal. Esta abordagem garante que a eficiência digital do ecossistema Crepúsculo não apague a liturgia exigida pelos atos de posse e diplomação.**A relevância estratégica ("E daí?"):**  A clareza visual é o primeiro degrau da segurança operacional. Ao estabilizar um sistema iconográfico que harmoniza a seriedade do Tribunal com a agilidade digital, o SOLENE mitiga erros de protocolo e fortalece a percepção de transparência e governança, assegurando que a tecnologia dignifique, em vez de simplificar, o rito institucional.

#### **2\. Ecossistema Cromático e Semântica Visual**

A cor no SOLENE é tratada como um dado técnico. A arquitetura cromática foi desenhada para garantir acessibilidade e identificação instantânea sob condições de alta pressão.

##### **Hierarquia de Aplicação (Ratios de Escalonamento)**

Para evitar o excesso visual e manter a sobriedade, recomenda-se a regra  **70/20/10** :

* **70% Bege Neutro/Cinza Antracite:**  Tons de base para equilíbrio e conforto visual.  
* **20% Dourado Sofisticado/Cores Nacionais:**  Acentos de autoridade e brasilidade.  
* **10% Cores Funcionais:**  Alertas e categorização de fluxo.

##### **Paleta Primária**

* **Dourado Sofisticado:**  Aplicado em elementos de destaque e no logotipo ("S" estilizado), simbolizando a nobreza e a tradição.  
* **Cinza Antracite:**  Utilizado para a estrutura da interface, transmitindo solidez e autoridade técnica.  
* **Cores Nacionais (Verde Esmeralda, Amarelo Ouro, Azul Cerúleo):**  Integradas de forma elegante em elementos de microinteração para evocar a soberania nacional.

##### **Resolução do Paradoxo Cromático (Autoridade vs. Alerta)**

Conforme requisitos técnicos, a cor  **Vermelha**  possui uso dual. Para evitar ambiguidade semântica, o sistema adota tratamentos gráficos distintos:

1. **Status de Autoridade (Membros da Corte):**  O vermelho é aplicado de forma sólida dentro de círculos ou molduras elegantes.  

2. **Status de Alerta (Restrição de Acesso):**  O vermelho é aplicado como um  *glow*  pulsante ou borda de advertência em torno do ícone de segurança, sinalizando risco imediato via integração com o sistema 'Visite'.

| Cor | Aplicação Semântica | Categoria / Estado |  
| ------ | ------ | ------ |  
| **Vermelho** | Alta Hierarquia / Alerta Crítico | Desembargadores / Restrição 'Visite' |
| **Verde** | Confirmação / Presença | Magistrados / Check-in Concluído |
| **Azul** | Informativo / Externo | Promotores / Autoridades de Outros Órgãos |
| **Amarelo** | Atenção / Pendência | Homenageados / Diplomandos |
| **Cinza** | Inativo / Processado | Autoridades já anunciadas em Nominata |

**A relevância estratégica ("E daí?"):**  O alto contraste e a segmentação funcional permitem que o cerimonialista decodifique o plenário com um relance. A diferenciação entre categorias por tratamento de borda e cor elimina a latência na tomada de decisão, essencial para manter o fluxo do protocolo sem interrupções.

#### **3\. Catálogo Detalhado de Ícones Funcionais**

Os ícones do SOLENE são unidades atômicas que representam objetos de negócio específicos. Suas linhas são finas, elegantes e seguem o estilo  *semi-flat*  com sombras sutis de profundidade.

1. **Convite:**  Representação minimalista de um envelope oficial com selo digital. Simboliza a gestão de convites e o fluxo de autocadastro integrado ao Crepúsculo.  
2. **Segurança:**  Escudo estilizado com linhas de varredura. Representa a integração direta com o sistema 'Visite', sinalizando a validação automática de restrições de acesso.  
3. **Mesa de Honra:**  Ícone de bilateralidade simétrica, representando o centripetalismo da autoridade. O símbolo reflete a ordenação rigorosa por precedência conforme o  **Decreto Federal nº 70.274/1972** .  
4. **Nominata:**  Microfone de púlpito estilizado em linhas contínuas. Possui estados dinâmicos: vibrante (pendente de anúncio) e  **Cinza Transmido**  (autoridade já anunciada), otimizando o fluxo do mestre de cerimônias.  
5. **Diplomação:**  Representação moderna de uma certificação digital com o brasão da República simplificado. Vincula o ato à  **Resolução TSE nº 23.677/2021** , unindo tradição e modernidade eletrônica.  
6. **Mapa de Assentos:**  Grade geométrica inspirada na "Ágora" (praça circular), com marcações de setores coloridos para controle espacial do plenário.  
7. **Credenciamento:**  Estilização de um leitor ótico interagindo com um QR Code. Foca na agilidade do  *check-in*  e na redução de filas operacionais.  
8. **Histórico:**  Ícone de ampulheta integrada a um arquivo documental. Representa a preservação da memória institucional e o acervo das solenidades passadas.**A relevância estratégica ("E daí?"):**  A padronização iconográfica atua como uma linguagem franca entre as equipes de recepção, segurança e magistrados. Ao reduzir a ambiguidade visual, o sistema SOLENE assegura que a complexidade dos eventos de diplomação seja gerida com a precisão de um relógio institucional.

#### **4\. Diretrizes Técnicas e Implementação UI/UX**

A aplicação dos ícones deve seguir os princípios do  **Design Atômico** , garantindo que cada componente seja escalável e interoperável dentro do ecossistema Crepúsculo.

##### **Pixel-Perfect Grid e Escalabilidade**

Os ícones devem ser implementados em formato vetorial (SVG), construídos sobre uma grade de 24x24 pixels com áreas de respiro de 2 pixels. Isso garante a  **responsividade**  e a legibilidade em dispositivos móveis ( *tablets*  de recepção) e monitores de alta resolução em plenário.

##### **Estados e Adaptabilidade de Fundo**

A consistência visual exige que o comportamento dos ícones seja previsível:

* **Fundos Claros (Bege):**  Ícones em Cinza Antracite com preenchimento nas cores funcionais.  
* **Fundos Escuros (Antracite):**  Ícones com contornos em Dourado ou Branco Puro para maximizar o contraste.  
* **Microinterações:**  O uso de estados de "Hover" e "Active" deve utilizar a saturação das cores funcionais (Verde para sucesso, Amarelo para pendência) para fornecer  *feedback*  imediato ao operador.

##### **Manutenção e Interoperabilidade**

Para evitar a degradação da marca institucional a longo prazo, qualquer novo ícone adicionado ao sistema deve obrigatoriamente seguir o peso de linha de 1.5pt e a curvatura de borda definida para os ícones originais do SOLENE.**A relevância estratégica ("E daí?"):**  O cumprimento rigoroso destas especificações técnicas não é apenas uma questão de estética, mas de  **sustentabilidade do sistema** . A uniformidade entre dispositivos reforça a confiabilidade do SOLENE perante autoridades externas, projetando uma imagem de modernidade tecnológica indissociável da segurança jurídica e institucional do TRE-AC.Através deste design, o TRE-AC reafirma seu compromisso com a excelência, onde a tecnologia serve à tradição e a precisão visual dignifica a Justiça Eleitoral brasileira.


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - Extrato de Análise por Pontos de Função.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - Extrato de Análise por Pontos de Função.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
## Extrato de Análise por Pontos de Função 

Projeto: Solene \- Gestão Cerimonial SEI 0001599-86.2026.6.01.8000 

Integrado ao Domínio Corporativo Presença 

**Base metodológica:** APF/IFPUG (estimativa indicativa)   
**Objetivo:** Dimensionamento funcional, esforço, prazo e custo de desenvolvimento.   
**Equipe prevista:** 

* 01 Analista Judiciário   
* 02 Técnicos Judiciários 

**Remuneração considerada:** 

* Analista Judiciário: R$ 16.041,21/mês [\[magistrarc...sos.com.br\]](https://magistrarcursos.com.br/blog/novos-salarios-para-analistas-e-tecnicos-dos-tribunais-da-uniao/), [\[planalto.gov.br\]](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15293.htm)   
* Técnico Judiciário: R$ 9.776,74/mês [\[magistrarc...sos.com.br\]](https://magistrarcursos.com.br/blog/novos-salarios-para-analistas-e-tecnicos-dos-tribunais-da-uniao/), [\[planalto.gov.br\]](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15293.htm) 

 

### 1\. Premissas 

A aplicação Cerimonial não é um sistema isolado. 

Diversas funcionalidades são herdadas do domínio corporativo **Presença**, reduzindo significativamente o volume de funcionalidades inéditas. 

Foram considerados: 

* Cadastro de eventos;   
* Convites;   
* Confirmações;   
* Credenciamento;   
* Presença;   
* Autocadastro;   
* Integração Visite;   
* Mesa de honra;   
* Ordem de precedência;   
* Nominata;   
* Diplomação;   
* Assentos;   
* Ata e histórico;   
* Integrações corporativas. 

 

### 2\. Estimativa de Funções de Dados 

| Função  | Tipo  | Complexidade  | PF  |
| :---- | :---- | :---- | :---- |
| **Evento Cerimonial**  | ALI  | Média  | 10  |
| **Participante Evento**  | ALI  | Alta  | 15  |
| **Assentos**  | ALI  | Média  | 10  |
| **Mesa de Honra**  | ALI  | Média  | 10  |
| **Nominata**  | ALI  | Alta  | 15  |
| **Diplomação**  | ALI  | Média  | 10  |
| **Histórico de Eventos**  | ALI  | Média  | 10  |
| **Integração Presença**  | AIE  | Média  | 7  |
| **Integração Visite**  | AIE  | Média  | 7  |

Subtotal: 

**94 PF** 

 

### 3\. Estimativa de Transações 

Entradas Externas (EE) 

| Função  | PF  |
| :---- | :---- |
| **Criar Evento**  | 4  |
| **Cadastrar Autoridade**  | 4  |
| **Vincular Participantes**  | 4  |
| **Confirmar Presença**  | 4  |
| **Credenciar Participante**  | 6  |
| **Inclusão Emergencial**  | 6  |
| **Compor Mesa de Honra**  | 6  |
| **Reservar Assentos**  | 4  |
| **Encerrar Evento**  | 4  |

Subtotal: 

**42 PF** 

 

Consultas Externas (CE) 

| Função  | PF  |
| :---- | :---- |
| **Consultar Evento**  | 4  |
| **Consultar Participantes**  | 4  |
| **Consultar Presenças**  | 4  |
| **Consultar Assentos**  | 4  |
| **Consultar Autoridades**  | 4  |
| **Consultar Restrições Visite**  | 6  |

Subtotal: 

**26 PF** 

 

Saídas Externas (SE) 

| Função  | PF  |
| :---- | :---- |
| **Convite Eletrônico**  | 5  |
| **Relatório de Presença**  | 5  |
| **Nominata Inicial**  | 7  |
| **Nominata Incremental**  | 7  |
| **Nominata Final**  | 7  |
| **Ata do Evento**  | 7  |
| **Relatório Histórico**  | 5  |
| **Relatório Diplomação**  | 7  |
| **Alertas de Segurança**  | 5  |

Subtotal: 

**55 PF** 

 

### 4\. Tamanho Funcional 

| Categoria  | PF  |
| :---- | :---- |
| **Arquivos Lógicos Internos**  | 80  |
| **Arquivos de Interface**  | 14  |
| **Entradas Externas**  | 42  |
| **Consultas Externas**  | 26  |
| **Saídas Externas**  | 55  |

Total 

**217 Pontos de Função** 

 

### 5\. Classificação do Projeto 

| Faixa  | Porte  |
| :---- | :---- |
| **até 100 PF**  | Pequeno  |
| **101 a 300 PF**  | Médio  |
| **301 a 700 PF**  | Grande  |

Resultado: 

**217 PF → Projeto de Porte Médio** 

 

### 6\. Produtividade Adotada 

Conforme práticas normalmente utilizadas em tribunais e fábricas de software governamentais: 

1     1 PF \= 12 horas 

 

### 7\. Esforço Total 

1     217 PF × 12 h   
Resultado: 

1     2.604 horas 

 

### 8\. Capacidade da Equipe 

Analista 

Carga: 

1     160 h/mês 

Técnicos (2) 

Carga: 

1     320 h/mês 

Capacidade Total 

1     480 h/mês 

 

### 9\. Prazo Estimado 

1     2.604 h ÷ 480 h/mês   
Resultado: 

1     5,42 meses   
Arredondando para cronograma realista: 

Prazo de Desenvolvimento 

**6 meses** 

Distribuição: 

| Fase  | Meses  |
| :---- | :---- |
| **Análise e Arquitetura**  | 1  |
| **Desenvolvimento Base**  | 2  |
| **Desenvolvimento Cerimonial**  | 1  |
| **Integrações**  | 1  |
| **Homologação e Ajustes**  | 1  |

 

### 10\. Custo da Equipe 

Analista 

1     R$ 16.041,21/mês   
6 meses: 

1     R$ 96.247,26 

 

Técnico 1 

1     R$ 9.776,74/mês   
6 meses: 

1     R$ 58.660,44 

 

Técnico 2 

1     R$ 9.776,74/mês   
6 meses: 

1     R$ 58.660,44 

 

### 11\. Custo Total de Pessoal 

1     96.247,26   
2     \+58.660,44   
3     \+58.660,44   
Resultado: 

R$ 213.568,14 

 

### 12\. Custo por Ponto de Função 

1     R$ 213.568,14 ÷ 217 PF   
Resultado: 

R$ 984,18 por PF 

 

### 13\. Reserva Técnica 

Recomendação de 20% para: 

* homologações;   
* correções;   
* ajustes de requisitos;   
* adequações normativas. 

1     R$ 213.568,14 × 20%   
Resultado: 

**R$ 42.713,63** 

 

### 14\. Valor Global Estimado 

| Item  | Valor  |
| :---- | :---- |
| **Desenvolvimento**  | R$ 213.568,14  |
| **Reserva Técnica (20%)**  | R$ 42.713,63  |

Total Geral 

R$ 256.281,77 

 

Resumo Executivo 

| Indicador  | Valor  |
| :---- | :---- |
| **Pontos de Função**  | 217 PF  |
| **Porte**  | Médio  |
| **Esforço**  | 2.604 horas  |
| **Equipe**  | 1 Analista \+ 2 Técnicos  |
| **Prazo**  | 6 meses  |
| **Custo Base**  | R$ 213.568,14  |
| **Reserva Técnica**  | R$ 42.713,63  |
| **Investimento Total**  | **R$ 256.281,77**  |
| **Custo Médio por PF**  | R$ 984,18  |

**Conclusão:** o módulo **Cerimonial**, considerando sua integração nativa com os domínios **Presença**, **Visite** e **Crepúsculo**, apresenta dimensão estimada de **217 Pontos de Função**, caracterizando-se como um projeto de porte médio, com prazo aproximado de **6 meses** e investimento estimado de **R$ 256 mil** para desenvolvimento interno pela equipe proposta. [\[legislacao...cia.gov.br\]](https://legislacao.presidencia.gov.br/atos/?tipo=LEI&numero=15293&ano=2025&data=19/12/2025&ato=09eoXQU10djpWT61f), [\[planalto.gov.br\]](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15293.htm), [\[planalto.gov.br\]](https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2025/lei/l15293.htm) 


```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Cerimonial - Template de Oficio Convite.md</nome_arquivo>
  <caminho_completo>docs/Cerimonial - Template de Oficio Convite.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# MODELO DE OFÍCIO DE ENCAMINHAMENTO DE CONVITE FORMAL (SISTEMA SOLENE)

Este documento foi estruturado em formato **Markdown** para servir como o modelo conceitual de engenharia de templates do sistema **SOLENE – Gestão de Cerimonial** do Tribunal Regional Eleitoral do Acre (TRE-AC) [84, 100]. Ele estabelece o mapeamento lógico das variáveis (tags dinâmicas) e apresenta o documento final correspondente aos dados reais fornecidos pelo Cerimonial para o evento do dia 18 [157, 192, 194].

---

## 1. MODELO PARAMETRIZADO (TEMPLATE)
Este é o padrão que deve ser implementado no editor de documentos e no motor de geração de PDFs do sistema SOLENE, permitindo o preenchimento automático das informações a partir do cadastro do participante e do evento [19, 192].

```markdown
Ofício nº {{nr_sequencial}} / {{ano}} - PRESI/GAPRES/{{unidade}}

Rio Branco, {{data_oficio_por_extenso}}.

A Sua Excelência, o(a) Senhor(a) {{pronome_tratamento}} {{nome_autoridade}},
Digníssimo(a) {{cargo_dirigente}} {{instituicao}}

Assunto: {{assunto}}.

{{vocativo}},

1.      O Tribunal Regional Eleitoral do Acre tem a honra de convidar Vossa Excelência para Sessão Solene de {{tipo_evento}} do {{nome_homenageado}} como {{cargo_homenageado}}.

2.      E convida, ainda, na mesma Sessão, para a Eleição e Posse do Excelentíssimo Senhor {{cargo_presidente}} {{nome_presidente}} e Excelentíssimo Senhor {{cargo_vice}} {{nome_vice}}, nos Cargos de Presidente, Vice-Presidente e Corregedor Regional Eleitoral do TRE-AC.

3.      A cerimônia será realizada no dia {{data_evento_por_extenso}} ({{dia_semana_evento}}), às {{hora_evento}}, no {{local_evento}} desta Corte Eleitoral, situado na {{endereco_evento}}.

4.      Para fins de organização, solicitamos a gentileza de confirmar presença até o dia {{data_limite_confirmacao_por_extenso}}, pelo e-mail: {{email_cerimonial}}.

Cordialmente,


{{nome_assinatura_remetente}}
{{cargo_remetente}} do Tribunal Regional Eleitoral do Acre - TRE-AC.
```

---

## 2. EXEMPLO DE PREENCHIMENTO REAL (DADOS DE REFERÊNCIA)
Este exemplo reflete exatamente a instância populada com as informações contidas no arquivo de referência oficial do TRE-AC (`Solene - ModeloOficioCorrespondencia_Dados.md`) para a posse da administração [194]:

```markdown
Ofício nº 162 / 2026 - PRESI/GAPRES/CPCT

Rio Branco, 24 de agosto de 2026.

A Sua Excelência, o Senhor Desembargador CARLOS ROBERTO DA SILVA,
Digníssimo Presidente do Colégio de Presidentes dos Tribunais Regionais Eleitorais do Brasil - COPTREL.

Assunto: Convite para Sessão Solene de Posse e Eleição da Administração do TRE-AC.

Senhor Presidente,

1.      O Tribunal Regional Eleitoral do Acre tem a honra de convidar Vossa Excelência para Sessão Solene de Posse do Desembargador Samoel Evangelista como Membro Efetivo da Corte Eleitoral do Acre.

2.      E convida, ainda, na mesma Sessão, para a Eleição e Posse do Excelentíssimo Senhor Desembargador Lois Arruda e Excelentíssimo Senhor Desembargador Samoel Evangelista, nos Cargos de Presidente, Vice-Presidente e Corregedor Regional Eleitoral do TRE-AC.

3.      A cerimônia será realizada no dia 18 de setembro de 2026 (sexta-feira), às 17h, no Plenário desta Corte Eleitoral, situado na Alameda Miguel Ferrante, nº 224 – Portal da Amazônia, em Rio Branco-Acre.

4.      Para fins de organização, solicitamos a gentileza de confirmar presença até o dia 10 de setembro de 2026, pelo e-mail: cerimonial@tre-ac.jus.br.

Cordialmente,


Desembargador LOIS Carlos ARRUDA
Vice-Presidente, no exercício da Presidência do Tribunal Regional Eleitoral do Acre - TRE-AC.
```

---

## 3. MAPEAMENTO E ARQUITETURA DE DADOS (DICIONÁRIO DE VARIÁVEIS)
Para orientar a equipe de engenharia da STI no desenvolvimento do motor de templates, as tags de interpolação do Markdown mapeiam as seguintes colunas e regras de negócio do banco de dados PostgreSQL integrado [41, 192]:

| Tag no Markdown (Placeholder) | Origem do Dado (Modelo de Classes / Banco de Dados) | Exemplo de Saída Real |
| :--- | :--- | :--- |
| `{{nr_sequencial}}` | Atributo gerado automaticamente pela tabela `AtaEvento` ou processo SEI | `162` |
| `{{ano}}` | Ano extraído a partir da data de criação do documento | `2026` |
| `{{unidade}}` | Sigla da unidade produtora (Comissão Permanente de Cerimonial - CPCT) [86] | `CPCT` |
| `{{data_oficio_por_extenso}}` | Data corrente formatada por extenso | `24 de agosto de 2026` |
| `{{pronome_tratamento}}` | Atributo `Pessoa.tratamento` ou prefixo protocolar do cargo | `Senhor Desembargador` |
| `{{nome_autoridade}}` | Atributo `Pessoa.nome` (destinatário principal) | `CARLOS ROBERTO DA SILVA` |
| `{{cargo_dirigente}}` | Atributo `Pessoa.cargo_atual` ou representação formal | `Presidente` |
| `{{instituicao}}` | Atributo de vinculação institucional da Autoridade | `Colégio de Presidentes dos TREs - COPTREL` |
| `{{vocativo}}` | Saudação protocolar oficial baseada no cargo do destinatário | `Senhor Presidente` |
| `{{tipo_evento}}` | Atributo `TipoEvento.descricao` (ex: Posse, Diplomação) [120] | `Posse` |
| `{{nome_homenageado}}` | Atributo `Pessoa.nome` do homenageado do evento | `Samoel Evangelista` |
| `{{cargo_homenageado}}` | Posição ou comenda vinculada ao homenageado | `Membro Efetivo da Corte Eleitoral do Acre` |
| `{{nome_presidente}}` | Primeiro desembargador a ser eleito na sessão administrativa | `Lois Arruda` |
| `{{nome_vice}}` | Segundo desembargador (eleito Vice-Presidente e Corregedor) | `Samoel Evangelista` |
| `{{data_evento_por_extenso}}`| Atributo `Evento.data_inicio` formatado por extenso | `18 de setembro de 2026` |
| `{{dia_semana_evento}}` | Dia da semana calculado dinamicamente com base na data do evento | `sexta-feira` |
| `{{hora_evento}}` | Atributo `Evento.data_inicio` formatado para horas | `17h` |
| `{{local_evento}}` | Nome do recinto de realização do evento (Plenário do TRE-AC) | `Plenário` |
| `{{endereco_evento}}` | Endereço físico completo cadastrado para o local do evento [86] | `Alameda Miguel Ferrante, nº 224 – Portal da Amazônia` |
| `{{data_limite_confirmacao_por_extenso}}`| Data limite definida pelo Cerimonial para confirmações de presença | `10 de setembro de 2026` |
| `{{email_cerimonial}}` | E-mail corporativo do setor requisitante (Cerimonial) [86] | `cerimonial@tre-ac.jus.br` |
| `{{nome_assinatura_remetente}}` | Atributo `Pessoa.nome` do signatário (remetente) | `LOIS Carlos ARRUDA` |
| `{{cargo_remetente}}` | Cargo atual do signatário durante a emissão | `Vice-Presidente, no exercício da Presidência` |

--- 
### Imagem de fundo do Ofício
![Cerimonial - Templete Ofício Convite](images/Cerimonial_-_Imagem_Template_Convite.png)
```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>DOCUMENTACAO.md</nome_arquivo>
  <caminho_completo>docs/DOCUMENTACAO.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# Documentação — Solene Cerimonial

Sistema de gestão de **eventos institucionais** e geração de **Nominata** para
solenidades do **Tribunal Regional Eleitoral do Acre (TRE-AC)**. É a reescrita
em Laravel do app original (Next.js + Firebase), espelhando a infraestrutura e
o modelo de autenticação do projeto **bena**.

> Este documento descreve a arquitetura, o domínio, as regras de negócio, a
> autenticação/autorização e a identidade visual (paleta e fontes). Para as
> convenções de desenvolvimento (TDD/XP), veja [`CLAUDE.md`](../CLAUDE.md);
> para setup rápido, o [`README.md`](../README.md).

---

## 1. Stack e infraestrutura

| Camada | Tecnologia |
|--------|------------|
| Linguagem | PHP 8.2 (`declare(strict_types=1)` em todo arquivo) |
| Framework | Laravel 11 |
| Banco | **Oracle** — XE 21 em dev (container), instância externa em prod — via `yajra/laravel-oci8` |
| Autenticação | **Authelia** (SSO em prod via headers; bypass simulado em dev) |
| Autorização | **ACL dinâmica no banco** (grupos × rotas) |
| PDF | DomPDF (`barryvdh/laravel-dompdf`) |
| UI | **gov.br Design System v3** + tema navy TRE-AC + JS vanilla |
| Sessão/cache/fila | driver `database` (sem Redis em dev) |
| Containers | `app` (php-fpm + Oracle Instant Client + oci8), `nginx`, `oracle` |

### Topologia Docker

```
┌─────────┐      ┌──────────────┐      ┌──────────────────────┐
│  nginx  │─────▶│  app (fpm)   │─────▶│ oracle (gvenzl XE 21) │
│  :8083  │ 9000 │  PHP 8.2     │ 1521 │  :1524 (host)         │
└─────────┘      └──────────────┘      └──────────────────────┘
```

- App em `http://localhost:8083` · Oracle em `localhost:1524` (usuário `solene`).
- O container `app` roda como **uid 1000** — arquivos criados no host como root
  precisam de `chown -R 1000:1000 .`, senão os comandos falham por permissão.
- O Oracle leva ~2–3 min para ficar *healthy* na primeira subida.

### Decisões de infraestrutura

- **Oracle**, não Postgres/MySQL — restrição institucional do tribunal.
- **Authelia em prod, bypass em dev** (`AUTHELIA_DEV_BYPASS`, rota `/_dev/sessao`).
- **Drivers `database`** para sessão/cache/fila.
- **Migrations compatíveis com Oracle E SQLite** (testes), identifiers ≤ 30 chars.

---

## 2. Arquitetura

### Ciclo de requisição

```
HTTP
 │
 ▼
ConfigureUserSession ── identidade (Authelia/dev) → valida grupos → hidrata sessão
 │
 ▼
AuthorizeRouteAccess ── ACL por nome de rota (curinga *) → 403 se negado
 │
 ▼
Controller (fino) ── valida via FormRequest, orquestra
 │
 ▼
Service (domínio) ── regra de negócio isolada e testável
 │
 ▼
Model/Eloquent ── Oracle
```

### Camadas e responsabilidades

- **Middleware** — autenticação e autorização (ver §5).
- **Controllers finos** — só validam (FormRequest) e orquestram; sem regra de
  negócio. Ex.: `EventoController`, `ConvidadoController`, `AssentoController`,
  `AutoridadeController`, `NominataController`.
- **Services (`app/Services/`)** — a lógica de domínio, testada isoladamente:
  - `NominataService` — agrupamento protocolar dos presentes.
  - `AssentosService` — mapa de assentos, sentar/liberar, ocupação.
  - `AcessoRotaPermissaoService` — decisão de acesso a rota (hot path em query builder puro).
- **Models** — Eloquent; domínio em português.
- **Convenção de nomes:** domínio em **português** (Evento, Convidado, cargo,
  presente, Autoridade); infraestrutura em **inglês** (Controller, Service,
  Middleware, Request).

### Estrutura de pastas (resumo)

```
app/
  Http/Controllers/   Evento, Convidado, Assento, Autoridade, Nominata, DevSession
  Http/Middleware/    ConfigureUserSession, AuthorizeRouteAccess, EnsureNotProduction
  Http/Requests/      EventoRequest, ConvidadoRequest, SentarAssentoRequest
  Models/             Evento, Convidado, Autoridade, Usuario, GrupoAcesso, AcessoRota
  Services/           NominataService, AssentosService, AcessoRotaPermissaoService
  Console/Commands/   AclSyncCommand (acl:sync)
config/               acesso.php, authelia.php, oracle.php, …
database/migrations/  schema (Oracle + SQLite)
database/seeders/     AcessoSeeder, DevDadosSeeder, DatabaseSeeder
resources/views/      layouts/app, eventos/*, assentos/*, pdf/nominata, dev/sessao
public/css/           solene-theme.css (tema)
routes/web.php
tests/                Unit + Feature (SQLite in-memory)
```

---

## 3. Domínio

### Diagrama de entidades

```
Usuario                    GrupoAcesso ───┐ (N:N via acesso_rota_grupo)
(Authelia, sem senha)                     ├──▶ AcessoRota  (catálogo de rotas)
                                          ┘    rota_nome ('*' = curinga admin)

Evento 1───N Convidado N───1 Autoridade
  │            │                (cadastro global, reusável entre eventos)
  │            └─ cor + assento_numero = poltrona no mapa
  └─ cap_red / cap_blue / cap_green / cap_yellow = capacidade do plenário
```

### Modelos

**`Evento`** — a solenidade.
- Campos: `nome`, `data` (cast `date`), `local`.
- Capacidade de assentos por cor: `cap_red`, `cap_blue`, `cap_green`,
  `cap_yellow` (inteiros, defaults 36 / 15 / 45 / 60 = layout clássico do plenário).
- `CAPACIDADE_LABELS` (cor → rótulo): red = *Mesa / Desembargadores*,
  blue = *Juízes*, green = *Autoridades / Promotores*, yellow = *Convidados*.
- `capacidadesAssento(): array<cor,int>`.
- Relações: `convidados()`, `convidadosPresentes()`.

**`Convidado`** — pessoa vinculada a um evento (pode estar sentada).
- Campos: `evento_id`, `autoridade_id?`, `nome` (**CAIXA ALTA**), `titulacao?`,
  `cargo`, `cor`, `presente` (bool), `assento_numero?`.
- `CARGOS` (ordem protocolar): Mesa de Honra, Desembargadores, Juízes,
  Autoridades, Promotores Eleitorais, Convidados, Outros.
- `CORES`: black, red, blue, green, yellow.
- `estaSentado()` = `assento_numero !== null`.
- Relações: `evento()`, `autoridade()`.

**`Autoridade`** — cadastro **global** reutilizável entre eventos.
- Campos: `nome`, `titulacao?`, `cargo`.
- Ao sentar alguém numa poltrona, cria-se um `Convidado` vinculado à `Autoridade`.

**`Usuario`** — identidade do Authelia (sem cadastro/senha).
- `firstOrNew` por `username` a cada requisição; `nome`/`email` vêm dos headers.

**`GrupoAcesso`** / **`AcessoRota`** — base da ACL dinâmica (ver §5).
- `GrupoAcesso.nome` é sempre gravado em **UPPER** (mutator) para comparar
  literal contra o header (sem `UPPER()` na query crítica).
- Categorias: `admin`, `organizador`.
- `AcessoRota.CURINGA = '*'`.

---

## 4. Regras de negócio

### Eventos
- Campos obrigatórios: `nome` (3–200), `data` (data válida), `local` (3–200).
- Capacidades por cor: opcionais, inteiro `0..9999`; ausentes assumem o default.
- **Visibilidade por grupo** (sem dono de evento): todo organizador vê e gere
  todos os eventos.

### Convidados
- `nome` é normalizado para **CAIXA ALTA** ao salvar.
- `cargo` deve estar na lista protocolar (`Convidado::CARGOS`).
- `cor` define a categoria/seção do cartão de identificação.
- Começa **ausente**; presença é alternável em tempo real (toggle).

### Nominata (PDF) — `NominataService::agrupar()`
- Considera **apenas convidados presentes**.
- Agrupa por `cargo` na **ordem protocolar** de `CARGOS`.
- Dentro de cada cargo, ordena por nome (natural, case-insensitive).
- Cargos sem nenhum presente são **omitidos**.
- Sem nenhum presente → retorna com mensagem de erro (não gera PDF vazio).

### Exportação Excel/CSV
- Lista completa de convidados do evento (download via stream).

### Mapa de assentos — `AssentosService`
- Cada poltrona é **posicional**: `cor` = seção, `assento_numero` = posição (1..capacidade).
- `mapa(Evento)` monta, por categoria, a capacidade e o ocupante de cada
  poltrona, além de totais e taxa de ocupação.
- **Sentar** (`sentar`): valida cor válida, número dentro da capacidade e
  **não permite dupla ocupação**; cria um `Convidado` sentado e presente,
  vinculado à `Autoridade`. Autoridade nova entra no cadastro global.
- **Liberar** (`liberar`): remove o `Convidado` que ocupa a poltrona (a
  `Autoridade` permanece no cadastro).
- **Trava de integridade em 2 níveis:** checagem no serviço **+** índice único
  parcial no banco (`uq_conv_assento`). Como Oracle e SQLite tratam NULL em
  unique composta de formas diferentes, o índice é **parcial por driver**
  (Oracle via `CASE`, SQLite via `WHERE assento_numero IS NOT NULL`) — só linhas
  com poltrona são únicas; convidados sem assento podem coexistir.

> Nota: o fluxo "Adicionar convidado" na tela do evento cria convidados **sem
> poltrona** (presença/lista), enquanto o mapa de assentos é posicional. São
> conceitos paralelos: presença ≠ estar sentado.

---

## 5. Autenticação e autorização

A aplicação **não tem tela de login**. A identidade vem do **Authelia** (atrás
do reverse proxy do tribunal), que injeta headers; dois middlewares fazem o resto.

### `ConfigureUserSession` (identidade + sessão)
1. Resolve a identidade:
   - **Prod:** headers `Remote-User`, `Remote-Groups`, `Remote-Name`, `Remote-Email`.
   - **Dev:** se `AUTHELIA_DEV_BYPASS=true` e `APP_ENV != production`, usa um
     usuário simulado (override de `/_dev/sessao` na sessão, senão defaults do `.env`).
   - Sem identidade → **401**.
2. Normaliza os grupos para **UPPER** e valida contra `grupos_acesso` (ativos).
   Nenhum grupo conhecido → **403**.
3. Hidrata a sessão: `user`, `matchingGroups`, `is_admin`, `is_organizador`,
   `rotas_permitidas`.
4. `firstOrNew` do `Usuario` por `username` (atualiza nome/email) e
   `Auth::setUser()`.

### `AuthorizeRouteAccess` (ACL por rota)
1. Lê o nome da rota atual; rota **sem nome → 403**.
2. Se casar com `config('acesso.bypass_routes')` (suporta wildcard via
   `Str::is`, ex.: `dev.sessao.*`) → libera.
3. Senão consulta `AcessoRotaPermissaoService::podeAcessarRota()` com os grupos
   da sessão. **403** se nenhum grupo tiver vínculo com a rota (ou com o curinga `*`).

### Modelo ACL (dinâmico, no banco)

```
grupos_acesso ──< acesso_rota_grupo >── acesso_rotas
  (perfil)          (vínculo N:N)         (catálogo de rotas nomeadas)
```

- Curinga `*` em `acesso_rotas` = **admin** (acesso total).
- `acl:sync` mantém o catálogo `acesso_rotas` em dia com as rotas nomeadas do
  Laravel (insere novas, reativa, inativa as que sumiram, garante o `*`).

### Perfis (grupos)

| Grupo | Categoria | Acesso |
|-------|-----------|--------|
| `SOLENE-ADMIN` | admin | curinga `*` — tudo |
| `SOLENE-ORGANIZADORES` | organizador | CRUD de eventos/convidados, nominata, excel, assentos, autoridades |

### Rota nova → liberar na ACL
```bash
php artisan acl:sync                         # cataloga as rotas nomeadas
# adicionar o nome em AcessoSeeder::ROTAS_ORGANIZADOR e:
php artisan db:seed --class=AcessoSeeder     # vincula ao grupo
```
Nos testes, `tests/TestCase::setUp()` roda o `AcessoSeeder` automaticamente
(senão qualquer request com header bateria 403).

### `EnsureNotProduction`
Protege rotas de dev (`/_dev/sessao`): **404** em produção.

---

## 6. Identidade visual — Paleta de cores

Definida em [`public/css/solene-theme.css`](../public/css/solene-theme.css),
que sobrescreve os tokens primários do gov.br DS para a navy institucional do
TRE-AC. O dourado (herdado da logo) é o **acento elegante**.

### Núcleo (navy institucional)

| Token | Hex | Uso |
|-------|-----|-----|
| `--solene-navy` | `#003366` | cor primária — header, botões, títulos |
| `--solene-navy-2` | `#001f3f` | navy escuro — gradientes, hover |
| `--solene-gold` | `#b8a06a` | **acento** — fios, foco, badges, réguas |
| `--solene-gold-2` | `#9c854f` | dourado escuro — texto/realce |
| `--solene-teal` | `#2f8f8f` | acento sutil herdado da estética original |

### Neutros e superfícies

| Token | Hex | Uso |
|-------|-----|-----|
| `--solene-bg` | `#f5f7fa` | fundo da página |
| `--solene-card` | `#ffffff` | superfície de cards |
| `--solene-border` | `#e7ecf2` | bordas |
| `--solene-ink` | `#1e293b` | texto principal |
| `--solene-muted` | `#64748b` | texto secundário |

### Tokens gov.br sobrescritos (família primária)
`--color-primary-default #003366` · `darken-01 #001f3f` · `darken-02 #000d1a` ·
`lighten-01 #0066cc` · `lighten-02 #3399ff` · `pastel-01 #cce0ff` · `pastel-02 #e6f0ff`.

### Cores funcionais (assentos / status)

| Categoria | Cor | Hex |
|-----------|-----|-----|
| Mesa / Desembargadores | red | `#ef4444` |
| Juízes | blue | `#3b82f6` |
| Autoridades / Promotores | green | `#22c55e` |
| Convidados | yellow | `#eab308` |
| (cartão) Preto | black | `#111827` |
| Sucesso (flash) | verde | `#22c55e` / fundo `#ecfdf3` |
| Erro (flash) | vermelho | `#ef4444` / fundo `#fef2f2` |

### Outros tokens de design
- Raio padrão: `--solene-radius: 14px`.
- Sombras: `--solene-shadow-sm`, `--solene-shadow-md`.
- Easing de transições: `--solene-ease: cubic-bezier(.22,.61,.36,1)`.

---

## 7. Tipografia (fontes)

Carregadas via Google Fonts em [`resources/views/layouts/app.blade.php`](../resources/views/layouts/app.blade.php).
O pareamento **serifada (títulos) + sans (corpo)** é o que dá o tom elegante.

| Função | Fonte | Pesos | Onde |
|--------|-------|-------|------|
| **Títulos / display** | **Cormorant Garamond** (serifada) | 500, 600, 700 | `h1`, `h2`, `h3`, `.solene-display`, cabeçalhos de card, títulos de seção, valores de stat |
| **Corpo / UI** | **Raleway** (sans-serif) | 400, 500, 600, 700 | `body`, labels, tabelas, botões, navegação |
| **Ícones** | Font Awesome 5.15.4 (Free, weight 900) | — | ícones e o "ocupante" da poltrona (`\f007`) |

Fallbacks: `Cormorant Garamond, Georgia, serif` e `Raleway, sans-serif`.

---

## 8. Frontend / UI

- **Base:** gov.br Design System v3 (`@govbr-ds/core@3.7.0` via CDN) + tema próprio.
- **Layout:** `layouts/app.blade.php` — header navy sticky com fio dourado e a
  logo (`public/img/logo-solene.png`, transparente sobre o navy), flash messages,
  rodapé institucional. Stack `@stack('styles')` para CSS por página.
- **Cards** arredondados com sombra suave (estética herdada do app original),
  micro-interações discretas (fade-up, hover).
- **Responsividade:** o formulário de convidados reempilha por breakpoint
  (5→2→1 colunas); a tabela de convidados vira **cards empilhados** com rótulos
  (`data-label`) abaixo de 720px.
- **Mapa de assentos:** layout clássico do plenário (seções nomeadas: Mesa de
  Honra, Desembargadores / Juízes, Autoridades / Promotores, Convidados),
  poltronas clicáveis, painel de indicadores (anel de ocupação) e legenda com
  barras por categoria. JS vanilla (sem build): modais de sentar/ocupante,
  busca de autoridades por AJAX, tooltip no hover e toque no mobile.

---

## 9. Funcionalidades

| Funcionalidade | Rotas | Descrição |
|----------------|-------|-----------|
| **Eventos** (CRUD) | `eventos.*` | nome, data, local + capacidade de assentos por cor |
| **Convidados** | `convidados.*` | adicionar (CAIXA ALTA), editar, alternar presença, excluir |
| **Nominata (PDF)** | `eventos.nominata` | presentes por cargo na ordem protocolar, cabeçalho TRE-AC |
| **Excel/CSV** | `eventos.excel` | lista completa de convidados (download) |
| **Mapa de assentos** | `eventos.assentos` | plenário posicional, indicadores e ocupação por cor |
| **Sentar/Liberar** | `assentos.sentar`, `assentos.liberar` | clicar na poltrona → sentar autoridade / liberar |
| **Cadastro de autoridades** | `autoridades.buscar` | registro global reutilizável, busca por nome |
| **Sessão de dev** | `dev.sessao.*` | trocar usuário/grupos simulados (só dev) |

---

## 10. Banco de dados (tabelas principais)

| Tabela | Conteúdo |
|--------|----------|
| `eventos` | solenidades + `cap_red/blue/green/yellow` |
| `convidados` | pessoas do evento; `cor` + `assento_numero` (poltrona); FK `autoridade_id` |
| `autoridades` | cadastro global reutilizável (`nome`, `titulacao`, `cargo`) |
| `usuarios` | identidades do Authelia (`username`, `nome`, `email`) |
| `grupos_acesso` | perfis (nome UPPER, categoria, ativo) |
| `acesso_rotas` | catálogo de rotas nomeadas (`rota_nome`, `*` = curinga) |
| `acesso_rota_grupo` | vínculo N:N grupo × rota |
| `sessions`, `cache`, `jobs` | infraestrutura (driver database) |

Índices/constraints notáveis: `uq_conv_assento` (único parcial por driver,
impede dupla ocupação), `fk_conv_autoridade` (nullOnDelete),
`idx_autoridades_nome` (busca).

---

## 11. Testes (TDD)

- Toda mudança de comportamento começa por um **teste que falha** (Red → Green → Refactor).
- Suíte em **SQLite in-memory** (`phpunit.xml`) — não depende do Oracle.
- Nomes de teste = comportamento, em português, `test_…`; AAA; sem `markTestSkipped`.
- Lógica de domínio testada isolada nos Services.

```bash
./run-tests.sh                     # suíte completa (no container, sqlite)
./run-tests.sh --filter=Nome       # um teste/grupo
make test
```

> ⚠️ **Atenção Oracle vs SQLite:** unique composta com coluna *nullable* se
> comporta diferente entre os dois bancos (Oracle compara NULLs parciais e
> acusa duplicidade; SQLite trata como distinto). Migrations precisam ser
> compatíveis com ambos — veja `uq_conv_assento` para o padrão de índice
> parcial por driver. DDL no Oracle dá auto-commit por statement (sem rollback),
> então migração que falha no meio deixa estado parcial.

---

## 12. Comandos úteis

```bash
make up / make down / make shell / make pint / make test
docker compose exec app php artisan migrate
docker compose exec app php artisan db:seed --class=AcessoSeeder
docker compose exec app php artisan db:seed --class=DevDadosSeeder   # dados de exemplo
docker compose exec app php artisan acl:sync                         # catálogo de rotas
docker compose exec app php artisan view:clear                       # limpar cache de views
```

Após criar arquivos no host como root: `chown -R 1000:1000 .`.
Laravel Pint (preset laravel) antes de commitar: `make pint`.

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Solene_ATA_16092026_DemonstracaoVersaoBeta.md</nome_arquivo>
  <caminho_completo>docs/Solene_ATA_16092026_DemonstracaoVersaoBeta.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
ATA DE REUNIÃO

Reunião: Demonstração e Validação do Sistema Solene
 Data: 16/09/2026
 Formato: Videoconferência
 Participantes:

Lucir Rocio Vaz (SDBD)
Felipe Bezerra Lima (SDBD)
Raphael Batista Da Silva (Comissão de Cerimonial)
Rose Jocely Lopes dos Santos Moreira (Comissão de Cerimonial)

Objeto da reunião: Demonstração das funcionalidades do Sistema Solene e alinhamento operacional para utilização na próxima solenidade do Tribunal Regional Eleitoral do Acre.

1. Abertura

A reunião teve início com a apresentação da versão atualizada do Sistema Solene pela equipe da SDBD, com o objetivo de demonstrar as funcionalidades implementadas, validar regras de negócio e alinhar procedimentos operacionais junto à Comissão de Cerimonial.

2. Funcionalidades Demonstradas
2.1. Convites e confirmação de presença

Foi apresentada a melhoria no fluxo de confirmação de presença dos convidados. O sistema passou a direcionar o usuário para uma versão simplificada de autocadastro, permitindo o preenchimento de informações essenciais, tais como:

Nome;
CPF;
E-mail;
Telefone (opcional).

O ajuste visa garantir que os participantes não previamente cadastrados possam ser inseridos na base de dados, assegurando maior integridade das informações de credenciamento.

2.2. Criação e configuração de eventos

Foram demonstradas as telas de cadastro de eventos contendo:

Nome do evento;
Data;
Local;
Categoria;
Grupos protocolares;
Configurações relacionadas às solenidades.

Foi informado que eventos classificados como solenidades possuem controle automático dos convites obrigatórios das autoridades previstas na Resolução nº 349.

2.3. Cadastro de autoridades

O sistema apresenta preenchimento automático de informações relacionadas aos cargos institucionais, incluindo:

Cargo;
Titulação;
Instituição;
Dados de contato padrão do órgão.

Os participantes confirmaram a adequação dessa funcionalidade para agilizar o processo de cadastramento e expedição de convites.

2.4. Envio de convites

Foi demonstrado o envio individual e em lote dos convites eletrônicos.

O representante do Cerimonial sugeriu a futura implementação de campos de seleção para agrupamento de destinatários, possibilitando melhor controle dos envios por categorias de convidados. A demanda foi acolhida pela equipe de desenvolvimento para avaliação posterior.

2.5. Confirmação com acompanhante e representantes

Foi demonstrada a funcionalidade que permite:

Confirmar presença do convidado;
Confirmar presença com acompanhante;
Designar representante.

A Comissão de Cerimonial considerou a funcionalidade adequada e elogiou a solução adotada para tratamento de acompanhantes e representantes.

3. Credenciamento e Controle de Presença

Foi apresentado o fluxo de credenciamento dos participantes e o registro de presença em tempo real.

A equipe explicou que o status dos convidados será atualizado conforme o check-in for realizado, permitindo o acompanhamento instantâneo das autoridades presentes e dos ocupantes da mesa de honra.

Também foi esclarecido que:

O evento deverá ser iniciado formalmente no sistema;
Somente após sua abertura será possível gerar nominatas oficiais;
O sistema registrará automaticamente os marcos temporais de início e encerramento do evento.
4. Painel Operacional

Foi demonstrado o painel visual que permitirá o acompanhamento do evento em tempo real, exibindo:

Quantidade de presentes;
Autoridades já credenciadas;
Ocupação dos grupos protocolares;
Situação dos participantes ainda não credenciados.

A servidora Rose Jocely Lopes dos Santos Moreira sugeriu que, futuramente, seja possível visualizar o nome da autoridade ao posicionar o cursor sobre os elementos gráficos da tela. A sugestão foi registrada para avaliação posterior.

5. Relatórios e Plano de Contingência

A Comissão de Cerimonial destacou a necessidade de disponibilizar uma lista de convidados para contingência, a ser utilizada em caso de indisponibilidade do sistema ou da internet durante a solenidade.

Após discussão, ficou definido que a equipe de desenvolvimento providenciará:

Relatório contendo nomes dos convidados;
Cargo e titulação;
Ordenação adequada para conferência manual;
Exportação para impressão e utilização como plano de contingência.
6. Geração de Nominatas

Foi validada a regra de geração automática das nominatas, observando que:

Apenas participantes efetivamente credenciados serão considerados;
Novas nominatas poderão ser geradas durante o evento;
Autoridades já anunciadas serão diferenciadas visualmente das que ainda aguardam anúncio.

Ficou acordado que a permissão para geração das nominatas ficará restrita aos perfis definidos pela Comissão de Cerimonial, priorizando o uso pelo cerimonialista responsável.

Também foi discutida a necessidade de observância da ordem de precedência e antiguidade dos desembargadores, informação que será ajustada pelo Cerimonial durante o cadastramento dos participantes.

7. Operação do Evento

Foi informado que:

O sistema poderá ser utilizado tanto em tablets quanto em smartphones;
Serão realizados testes de usabilidade nos dispositivos disponíveis;
A equipe do Cerimonial encaminhará a relação dos servidores que atuarão como recepcionistas e operadores do sistema durante a solenidade;
Será criada a estrutura necessária para atribuição de perfis e permissões desses usuários.
8. Encaminhamentos

Ficaram definidos os seguintes encaminhamentos:

A equipe SDBD realizará as últimas atualizações do Sistema Solene em ambiente de produção.
Implementar relatório de contingência para impressão da lista de convidados.
Avaliar implementação futura de seleção em lote para envio de convites.
Avaliar funcionalidade de exibição dos nomes das autoridades ao posicionar o cursor sobre os elementos gráficos do painel.
Receber da Comissão de Cerimonial a relação dos operadores que atuarão na recepção e credenciamento.
Realizar testes em tablets e smartphones antes da realização do evento.
9. Encerramento

Os participantes registraram satisfação com a evolução do Sistema Solene, destacando que as funcionalidades apresentadas atendem às necessidades operacionais da solenidade. A Comissão de Cerimonial agradeceu o trabalho desenvolvido pela equipe da SDBD e manifestou expectativa positiva para utilização da solução no próximo evento institucional.

Nada mais havendo a tratar, a reunião foi encerrada.
```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>solene_backlog_ia_ATA16092026.md</nome_arquivo>
  <caminho_completo>docs/solene_backlog_ia_ATA16092026.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# Product Backlog & Especificação de Prompts de IA: Sistema SOLENE – Gestão de Cerimonial (TRE-AC)

**Papel:** Agile Product Owner & Prompt Engineer para Desenvolvimento Assistido por IA (Claude / Codex / Cursor)  
**Projeto:** SOLENE – Gestão de Cerimonial e Protocolo  
**Órgão:** Tribunal Regional Eleitoral do Acre (TRE-AC)  
**Plataforma de Governança e Código:** Ecossistema Crepúsculo / Plataforma Presença / GitLab PDPJ-Br  
**Referência Metodológica e Normativa:** ATA de Demonstração Versão Beta (16/09/2026), Resolução CNJ nº 395/2021 (FestLabs), Resolução TRE-AC nº 349/2002, NBR ISO/IEC/IEEE 12207, NBC TSP 08 / CPC 04 (R1).

---

## 1. Contextualização Temporal, Contábil e Patrimonial do Projeto

Em atendimento às normas da Secretaria do Tesouro Nacional (STN), ao Manual de Contabilidade Aplicado ao Setor Público (MCASP) e às diretrizes da Resolução CNJ nº 395/2021, o desenvolvimento do software **SOLENE** possui seus custos e entregas temporais mensurados e segregados por etapas patrimoniais.

```
========================================================================================
                      PARÂMETROS TEMPORAIS E PATRIMONIAIS DO PROJETO
========================================================================================
[Data de Início do Projeto]:          24/08/2026 (Abertura do Sprint de Desenvolvimento)
[Data de Fim / Homologação Beta]:      16/09/2026 (Validação do Protótipo em Videorreunião)
[Perspectiva de Vida Útil do Ativo]:   5 Anos (60 Meses)
[Indicador de Depreciação/Amortização]: Amortização Intangível Linear de 20% ao ano (1,67%/mês)
[Marco de Ativação Patrimonial]:       Setembro/2026 (Início da Operação em Produção)
========================================================================================
```

### Classificação Patrimonial das Atividades de Engenharia:
1. **[Fase de Pesquisa - VPD (Variação Patrimonial Diminutiva)]**: Compreende as atividades de levantamento de requisitos, estudo de viabilidade técnica, mapeamento de processos operacionais com a Comissão Permanente de Cerimonial e Protocolo (CPCT) e definição do modelo conceitual. Os custos com pessoal nesta etapa são lançados diretamente como despesa do exercício (VPD).
2. **[Fase de Desenvolvimento - Custo Ativável (Ativo Intangível em Construção)]**: Compreende a codificação dos módulos, elaboração de scripts SQL, desenvolvimento de APIs de integração com o sistema Visite, criação de interfaces responsivas, escrita de testes automatizados (TDD em PHPUnit) e compilação do backlog. Estes valores são capitalizados no Ativo Não Circulante (Intangível em Formação - Conta 1.2.4.1.1.x) do TRE-AC.

---

## 2. Função Parametrizável de Priorização Dinâmica do Backlog

Para viabilizar a recalibragem instantânea do backlog diante de alterações nas diretrizes da Alta Administração ou do Plano de Gestão do Tribunal, implementa-se a função de ordenação paramétrica do valor de prioridade de cada História de Usuário ($I_{\text{backlog}}$):

$$I_{\text{backlog}} = f(\text{Macrodesafio}, \text{Prioridade\_Story}, \text{Peso\_Indicador\_Estrategico})$$

### Formulação Matemática Normalizada:
$$I_{\text{backlog}} = \left( W_{\text{macro}} \times P_{\text{macro}} \right) + \left( W_{\text{story}} \times P_{\text{story}} \right) + \left( W_{\text{ind}} \times P_{\text{ind}} \right)$$

Onde:
* $W_{\text{macro}} = 0,40$: Peso relativo atribuído ao Alinhamento com os Macrodesafios do Poder Judiciário (CNJ).
* $P_{\text{macro}} \in [1, 5]$: Pontuação do Macrodesafio (ex: 5 = Segurança/Acessibilidade Crítica; 4 = Transformação Digital; 3 = Eficiência Operacional).
* $W_{\text{story}} = 0,35$: Peso da Severidade e Risco Técnico/Operacional da História de Usuário.
* $P_{\text{story}} \in [1, 5]$: Complexidade e Risco de Falha em Evento Presencial (5 = Bloqueador de Solenidade; 1 = Melhoria Estética).
* $W_{\text{ind}} = 0,25$: Peso da Contribuição para os Indicadores do Plano de Gestão do TRE-AC.
* $P_{\text{ind}} \in [1, 5]$: Grau de impacto nos indicadores do Planejamento Estratégico do Tribunal.

```python
def calcular_prioridade_backlog(macrodesafio_peso: float, story_risco: float, indicador_gestao: float) -> float:
    """
    Recalcula automaticamente a priorização das entregas diante de mudanças no plano de gestão.
    Retorna o Índice do Backlog (I_backlog) variando de 1.0 a 5.0.
    """
    w_macro, w_story, w_ind = 0.40, 0.35, 0.25
    i_backlog = (w_macro * macrodesafio_peso) + (w_story * story_risco) + (w_ind * indicador_gestao)
    return round(i_backlog, 2)
```

---

## 3. Product Backlog Detalhado e Prompts para IA (Claude / Codex / Cursor)

---

### ÉPICO 1: Gestão de Convites Eletrônicos, Autocadastro e Acompanhantes

#### US-01: Autocadastro Simplificado do Convidado via Link Eletrônico
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Fortalecimento da Transformação Digital` ($P_{\text{macro}} = 4$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $4,35$ (Prioridade Alta)

##### Descrição:
**Como** Convidado de uma solenidade oficial do TRE-AC,  
**Eu quero** acessar um link simplificado de confirmação de presença enviado junto ao convite eletrônico,  
**Para que** eu possa preencher/atualizar meus dados essenciais (`Nome, CPF, E-mail, Telefone`) na base corporativa sem a necessidade de digitação manual pela equipe do Cerimonial.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Confirmação de presença por convidado com dados válidos
  Dado que o convidado acessa o link seguro de autocadastro '/solene/confirmar/{hash_convite}'
  E a tela exibe o formulário com os campos 'Nome', 'CPF', 'E-mail' e 'Telefone' (opcional)
  Quando o convidado preencher um CPF válido e clicar em "Confirmar Presença"
  Então o sistema deve consultar a entidade 'Pessoa' do domínio Presença
  E atualizar/inserir o registro de pessoa mantendo o vínculo com 'ParticipanteEvento'
  E alterar o status do convite para 'Confirmado' com marca temporal de confirmação.

Cenário 2: Validação de CPF e prevenção de duplicidade
  Dado que o convidado digita um CPF inválido ou com formato incorreto
  Quando acionar o botão de envio
  Então o sistema deve exibir uma mensagem de erro estilizada "CPF inválido. Por favor, verifique os dígitos."
  E impedir a submissão do formulário até a correção.
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Engenheiro de Software Sênior especializado em PHP 8.3, Laravel 11 e Padrões da PDPJ-Br.**
> **Contexto:** Implemente o controller e a Request Validation do Autocadastro Simplificado do sistema SOLENE, estendendo a entidade `Pessoa` da Plataforma Presença sem duplicar dados.
> **Exigências Técnicas:**
> 1. Escreva o `AutocadastroController.php` contendo o método `confirmarPresenca(AutocadastroRequest $request, string $hashConvite)`.
> 2. Crie a `AutocadastroRequest` validando `cpf` (regra customizada de validação de CPF), `nome` (required, max:255), `email` (required, email) e `telefone` (nullable, formato com DDD).
> 3. Utilize transactions do banco de dados (`DB::transaction`) para atualizar a tabela `Pessoa` e a tabela `ParticipanteEvento` (`confirmacao = true`, `data_confirmacao = now()`).
> 4. Crie os testes unitários/integração no PHPUnit (`AutocadastroTest.php`) cobrindo os cenários BDD felizes e de exceção conforme a NBR ISO/IEC/IEEE 12207.

---

#### US-02: Gestão de Acompanhantes e Designação de Representantes
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Aperfeiçoamento da Gestão Administrativa e Governança` ($P_{\text{macro}} = 3$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $3,80$ (Prioridade Média-Alta)

##### Descrição:
**Como** Autoridade ou Convidado principal,  
**Eu quero** indicar se comparecerei acompanhado ou se designarei um representante oficial,  
**Para que** o Cerimonial do Tribunal consiga dimensionar os lugares reservado no plenário e qualificar previamente seguranças, assessores e motoristas.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Indicação de representante oficial por autoridade
  Dado que uma autoridade convidada não poderá comparecer pessoalmente
  Quando selecionar a opção "Designar Representante" no painel de confirmação
  E informar o Nome, Cargo, CPF e E-mail do representante
  Então o sistema deve cadastrar o representante na tabela 'Pessoa' e associá-lo como 'Representante' em 'ParticipanteEvento'
  E alterar o status do participante titular para 'Representado'.

Cenário 2: Inclusão de acompanhantes operacionais (Seguranças / Assessores)
  Dado que uma autoridade confirma presença com 2 acompanhantes operacionais
  Quando preencher os dados dos acompanhantes indicando o tipo ('Segurança', 'Assessor', 'Familiar')
  Então o sistema deve criar registros na tabela 'Acompanhante' vinculados ao ID do 'ParticipanteEvento' do titular.
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Engenheiro de Software Fullstack PHP e Vue.js 3 / Inertia.js.**
> **Contexto:** Implemente o componente de gerenciamento de Acompanhantes e Representantes para o sistema SOLENE no ecossistema Crepúsculo.
> **Exigências Técnicas:**
> 1. Escreva o Service `AcompanhanteService.php` com o método `vincularAcompanhantes(int $participanteId, array $acompanhantesData)`.
> 2. Mapeie o relacionamento na model `ParticipanteEvento` (`hasMany(Acompanhante::class)` e `belongsTo(Pessoa::class, 'representante_id')`).
> 3. Crie a migração SQL do PostgreSQL garantindo chaves estrangeiras com `onDelete('cascade')` para integridade referencial.
> 4. Forneça o teste automatizado em PHPUnit verificando a deleção em cascata e a correta atribuição do status 'Representado'.

---

### ÉPICO 2: Configuração e Controle Protocolares de Solenidades

#### US-03: Criação de Eventos Solenes e Automação da Resolução TRE-AC nº 349/2002
* **Classificação Patrimonial:** `[Fase de Pesquisa - VPD]` (Ajustes de Regras de Negócio) / `[Fase de Desenvolvimento - Custo Ativável]` (Codificação)
* **Macrodesafio Institucional:** `Fortalecimento da Transformação Digital` ($P_{\text{macro}} = 4$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $4,15$ (Prioridade Alta)

##### Descrição:
**Como** Cerimonialista (CPCT),  
**Eu quero** cadastrar um evento oficial marcando-o como "Solenidade",  
**Para que** o sistema vincule automaticamente a lista obrigatória de autoridades e órgãos estipulados na Resolução TRE-AC nº 349/2002 e nas regras de regimento do Tribunal.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Cadastro de evento do tipo Sessão Solene
  Dado que o cerimonialista cadastra um novo evento com nome "Solenidade de Posse de Membro da Corte"
  E seleciona o tipo 'Solenidade'
  Quando salvar o evento
  Então o sistema deve acionar o gatilho de carga da Resolução nº 349/2002
  E incluir automaticamente no evento os convites obrigatórios para a lista padrão de autoridades (Presidência, Governo do Estado, Assembleia Legislativa, MPF, OAB-AC).

Cenário 2: Configuração do local e capacidade do Plenário
  Dado que o evento é configurado para o "Plenário do TRE-AC"
  Quando o operador definir a capacidade máxima do evento
  Então o sistema deve validar se o quantitativo de assentos por setor não excede o limite físico cadastrado.
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Desenvolvedor Backend Laravel especialista em Event-Driven Architecture.**
> **Contexto:** Desenvolva o mecanismo de disparo automático de regras protocolares do SOLENE após a criação de eventos do tipo Solenidade.
> **Exigências Técnicas:**
> 1. Crie o evento de domínio `SolenidadeCriadaEvent` e o Listener `CarregarListaObrigatoriaResolucao349Listener`.
> 2. O Listener deve consultar a tabela `AgendaAutoridade` filtrando os órgãos marcados como `obrigatorio_resolucao_349 = true` e inserir em lote (`insertQuietly`) na tabela `ParticipanteEvento`.
> 3. Crie a Seed do banco de dados `Resolucao349Seeder.php` contendo a lista oficial de cargos e vocativos formais exigidos no Tribunal.
> 4. Forneça o teste PHPUnit garantindo que a criação do evento gera a quantidade exata de convites obrigatórios previstos na norma.

---

#### US-04: Preenchimento Automático de Dados de Autoridades e Vocativos Formais
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Inovação e Eficiência Operacional` ($P_{\text{macro}} = 3$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $3,65$ (Prioridade Média)

##### Descrição:
**Como** Operador do Cerimonial,  
**Eu quero** selecionar um cargo institucional durante o cadastro de um convidado e obter o preenchimento automático de sua titulação, instituição e vocativo formal,  
**Para que** a expedição de ofícios e a geração de nominatas respeitem rigorosamente o protocolo oficial sem exigência de digitação repetitiva.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Autocompletar dados de cargo e vocativo
  Dado que o operador está cadastrando uma autoridade e digita o cargo "Presidente do TJAC"
  Quando selecionar a opção sugerida pelo autocomplete
  Então o sistema deve preencher automaticamente:
    | Titulação  | Excelentíssimo(a) Senhor(a) Desembargador(a) |
    | Vocativo   | Vossa Excelência                             |
    | Instituição| Tribunal de Justiça do Estado do Acre        |
    | Tratamento | Senhor(a) Presidente                          |
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Desenvolvedor Frontend/Backend especialista em APIs REST e Autocomplete.**
> **Contexto:** Implemente o serviço de autocomplete de cargos e vocativos institucionais para o SOLENE.
> **Exigências Técnicas:**
> 1. Escreva o endpoint REST `GET /api/v1/autoridades/cargos-sugeridos?q={termo}` que realiza busca rápida via `ILIKE` com índice B-Tree/Trigram no PostgreSQL sobre a tabela `AgendaAutoridade`.
> 2. Retorne o payload JSON no padrão JSend contendo `cargo`, `titulacao`, `vocativo`, `instituicao` e `ordem_precedencia_default`.
> 3. Adicione camada de cache Redis com tempo de expiração de 24 horas para buscas frequentes.
> 4. Forneça a suíte de testes unitários validando a resposta do endpoint em menos de 50 milissegundos.

---

### ÉPICO 3: Credenciamento Móvel, Registro de Presença e Integração de Segurança

#### US-05: Credenciamento Móvel com Triagem Silenciosa de Segurança (Sistema Visite)
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Segurança Institucional e Gestão de Riscos` ($P_{\text{macro}} = 5$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $4,85$ (Prioridade Crítica - Bloqueador)

##### Descrição:
**Como** Recepcionista munido de smartphone/tablet na entrada do evento,  
**Eu quero** realizar o check-in do participante via leitura de QR Code ou busca por CPF/Nome e obter a validação automática de restrições de acesso pelo sistema Visite,  
**Para que** a entrada seja efetuada em poucos segundos e alertas de segurança sejam emitidos discretamente sem constrangimento público ao convidado.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Check-in com sucesso de convidado sem restrições
  Dado que a recepcionista lê o QR Code do convite do participante "Desembargador Francisco Dantas"
  Quando o aplicativo fizer a requisição de credenciamento
  E o serviço do sistema Visite retornar status "Sem Restrições"
  Então o sistema deve gravar o registro em 'Presenca' com data, hora e ID do operador
  E exibir na tela a cor funcional da categoria ('Vermelho' para Desembargador) e o assento reservado ('Plenário - Fila A, Cadeira 3').

Cenário 2: Check-in de participante com restrição de segurança ativa
  Dado que a recepcionista consulta o CPF de um participante com impedimento judicial registrado no sistema Visite
  Quando o credenciamento for acionado
  Então o aplicativo do SOLENE deve exibir um feedback visual discreto (borda amarela/vermelha pulsante com aviso interno)
  E disparar silenciosamente um alerta em tempo real (PushNotification/Websocket) para o console da Segurança Institucional do TRE-AC.
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Especialista em Arquitetura de Microsserviços e WebSockets (Pusher/Soketi).**
> **Contexto:** Desenvolva o serviço de Credenciamento Móvel e a integração assíncrona com o microsserviço de segurança `Visite` no sistema SOLENE.
> **Exigências Técnicas:**
> 1. Escreva a classe `CredenciamentoService.php` contendo o método `processarCheckIn(int $participanteId, int $operadorId, string $origem = 'MOBILE')`.
> 2. O método deve consultar a API do `VisiteService` com tempo limite (timeout) de 1,5 segundos. Em caso de falha de conexão com o Visite, aplicar política de *fallback* e permitir o check-in registrando flag de `validacao_pendente`.
> 3. Se a API retornar restrição ativa, disparar o evento `AlertaSegurancaDisparadoEvent::dispatch($participante, $restricao)` enviado para o canal privado de WebSockets da Segurança.
> 4. Crie os testes automáticos simulando a resposta da API do Visite com o HTTP Mock do Laravel.

---

### ÉPICO 4: Painel Operacional, Nominatas Incrementais e Contingência

#### US-06: Painel Operacional em Tempo Real com Destaque Dinâmico de Autoridades
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Inovação e Eficiência Operacional` ($P_{\text{macro}} = 4$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $4,20$ (Prioridade Alta)

##### Descrição:
**Como** Presidente do Tribunal ou Cerimonialista no Plenário,  
**Eu quero** visualizar um painel gráfico (*Dashboard*) com contadores de presença em tempo real, ocupação por setores e indicação do nome da autoridade ao passar o cursor sobre os elementos visuais,  
**Para que** a Mesa Diretora tome decisões informadas sobre o momento exato de abertura da solenidade.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Atualização em tempo real do Dashboard Operacional
  Dado que o painel operacional está aberto no monitor da Presidência
  Quando uma nova autoridade realizar o credenciamento na recepção
  Então o contador de "Presentes" deve ser incrementado instantaneamente via WebSocket sem recarregar a página
  E o indicador da categoria protocolar correspondente deve atualizar sua cor de preenchimento.

Cenário 2: Exibição de Tooltip de Autoridade ao passar o cursor
  Dado que o operador posiciona o ponteiro do mouse sobre uma cadeira preenchida no mapa de assentos
  Quando o evento de hover for disparado
  Então o sistema deve exibir um tooltip estilizado contendo: Nome do Participante, Cargo, Instituição e Horário exato do Check-in.
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Desenvolvedor Frontend especialista em Vue.js 3, TailwindCSS e Echo (WebSockets).**
> **Contexto:** Construa o componente de Dashboard do Painel Operacional em tempo real para a Presidência do TRE-AC.
> **Exigências Técnicas:**
> 1. Escreva o componente Vue `DashboardOperacional.vue` consumindo eventos via `Laravel Echo` no canal `private-evento.{id}`.
> 2. Implemente os cartões de métricas (`Total Confirmados`, `Presentes no Plenário`, `Aguardando Chegada`, `Mesa de Honra Concluída`).
> 3. Crie o mapa de assentos SVG interativo onde os círculos mudam de estado (`livre`, `ocupado`) com transição suave CSS e exibem o componente `<TooltipAutoridade />` no evento `@mouseenter`.
> 4. Garanta a renderização otimizada sem gargalos de performance quando houver até 500 participantes ativos no evento.

---

#### US-07: Geração Dinâmica de Nominatas Incrementais para o Mestre de Cerimônias
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Fortalecimento da Transformação Digital` ($P_{\text{macro}} = 5$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $4,90$ (Prioridade Crítica)

##### Descrição:
**Como** Cerimonialista responsável pela condução dos anúncios ao microfone,  
**Eu quero** gerar nominatas manuais sucessivas a partir de marcos temporais no sistema,  
**Para que** apenas as autoridades recém-chegadas e credenciadas após a última leitura sejam destacadas em vermelho para anúncio, mantendo as já anunciadas em tom cinza itálico.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Geração da Nominata Inicial na abertura do evento
  Dado que o evento é iniciado formalmente no sistema
  Quando o cerimonialista clicar em "Gerar Nominata Inicial"
  Então o sistema deve capturar todas as autoridades credenciadas até aquele instante
  E exibi-las ordenadas estritamente pela Ordem Geral de Precedência do Decreto Federal nº 70.274/1972
  E criar o Marco Temporal #1 da Nominata.

Cenário 2: Geração de Nominata Incremental durante a solenidade
  Dado que a solenidade está em andamento e novas autoridades realizaram check-in pós-Marco #1
  Quando o cerimonialista acionar "Gerar Nominata Incremental"
  Então o sistema deve gerar o Marco Temporal #2
  E apresentar os novos presentes em destaque **Vermelho Alerta** (Pendentes de Leitura)
  E exibir as autoridades lidas nos marcos anteriores em cor **Cinza Neutro Itálico** (Já Anunciadas).
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Desenvolvedor Backend PHP 8.3 especialista em Algoritmos de Ordenação e Manipulação de Collections.**
> **Contexto:** Desenvolva o motor de geração de Nominatas Incrementais com precedência protocolar e marcação temporal no sistema SOLENE.
> **Exigências Técnicas:**
> 1. Crie a Service `NominataService.php` contendo os métodos `gerarNominataInicial(int $eventoId)` e `gerarNominataIncremental(int $eventoId)`.
> 2. O cálculo da Nominata Incremental deve buscar registros em `Presenca` onde `data_hora >` o último `gerada_em` da tabela `Nominata` do evento.
> 3. Aplique o algoritmo de ordenação combinando a coluna `precedencia` da `CategoriaParticipante` e a antiguidade do cargo.
> 4. Escreva o teste de integração PHPUnit simulando 3 chegadas consecutivas de autoridades e verificando se o retorno do JSON diferencia os blocos `pendentes_anuncio` (destaque) e `ja_anunciados`.

---

#### US-08: Geração do Relatório Físico de Contingência (Plano C)
* **Classificação Patrimonial:** `[Fase de Desenvolvimento - Custo Ativável]`
* **Macrodesafio Institucional:** `Aperfeiçoamento da Gestão Administrativa e Governança` ($P_{\text{macro}} = 4$)
* **Índice de Priorização ($I_{\text{backlog}}$):** $4,00$ (Prioridade Alta)

##### Descrição:
**Como** Cerimonialista,  
**Eu quero** exportar e imprimir a qualquer momento um relatório físico completo de contingência antes ou durante a solenidade,  
**Para que** a equipe de recepção continue operando sem interrupções (Plano C) em caso de queda de energia ou indisponibilidade total da rede de internet do Tribunal.

##### Critérios de Aceitação (BDD / Given-When-Then):
```gherkin
Cenário 1: Exportação da Lista de Contingência para Impressão
  Dado que o operador aciona a opção "Exportar Lista de Contingência (PDF)"
  Quando a geração for concluída
  Então o sistema deve produzir um documento PDF formatado em ordem alfabética e por grupos protocolares
  Contendo: Nome Completo, Cargo, Titulação, Instituição, Categoria, Espaço para Assinatura Manual de Presença e Quadrículo de Check-in.
```

##### Prompt de Execução para IA (Cursor / Claude / Codex):
> **Atue como Desenvolvedor Backend especializado na geração de relatórios PDF com Dompdf ou Browsershot.**
> **Contexto:** Crie a funcionalidade de exportação da Lista de Contingência em PDF para uso impresso no sistema SOLENE.
> **Exigências Técnicas:**
> 1. Escreva a classe `RelatorioContingenciaService.php` gerando o layout HTML/CSS em Blade e convertendo para PDF de alta densidade.
> 2. O documento deve possuir cabeçalho oficial do TRE-AC, numeração de páginas "Página X de Y", ordenação primária por Categoria Protocolar e secundária por Nome Alfabético.
> 3. Inclua campos gráficos para marcação de caneta (checkbox de presença, hora de chegada e observação).
> 4. Crie o teste automatizado verificando a geração do arquivo PDF no scratch do sistema com tamanho funcional e tempo de execução inferior a 2 segundos.

---

## 4. Tabela Resumo do Product Backlog e Mapeamento Patrimonial

| Código Story | Título da História de Usuário | Macrodesafio Institucional (CNJ) | Etapa Patrimonial Contábil | Prioridade ($I_{\text{backlog}}$) | Sprint Alvo |
| :--- | :--- | :--- | :--- | :---: | :---: |
| **US-01** | Autocadastro Simplificado | Transformação Digital | `[Desenvolvimento - Custo Ativável]` | **4.35** | Sprint 1 |
| **US-02** | Gestão de Acompanhantes | Gestão Administrativa | `[Desenvolvimento - Custo Ativável]` | **3.80** | Sprint 1 |
| **US-03** | Automação da Resolução 349 | Transformação Digital | `[Pesquisa - VPD / Custo Ativável]` | **4.15** | Sprint 1 |
| **US-04** | Autocomplete de Vocativos | Inovação e Eficiência | `[Desenvolvimento - Custo Ativável]` | **3.65** | Sprint 2 |
| **US-05** | Credenciamento & Visite | Segurança Institucional | `[Desenvolvimento - Custo Ativável]` | **4.85** | Sprint 2 |
| **US-06** | Dashboard em Tempo Real | Inovação e Eficiência | `[Desenvolvimento - Custo Ativável]` | **4.20** | Sprint 2 |
| **US-07** | Nominatas Incrementais | Transformação Digital | `[Desenvolvimento - Custo Ativável]` | **4.90** | Sprint 3 |
| **US-08** | Relatório de Contingência | Governança & Risco | `[Desenvolvimento - Custo Ativável]` | **4.00** | Sprint 3 |

---

## 5. Diretrizes para Assistentes de IA no Cursor / Claude / Codex

Ao utilizar esta especificação com assistentes de inteligência artificial durante as sessões de desenvolvimento e refatoração de código do **SOLENE**, a equipe da SDBD do TRE-AC deve seguir rigorosamente as seguintes instruções:

1. **Injeção de Contexto:** Copie e cole o bloco de definições do BDD da História de Usuário correspondente no prompt de comando do Cursor/Claude.
2. **Padrão Arquitetural PDPJ-Br:** Nenhuma classe criada deve instanciar acessos diretos via `PDO` ou consultas SQL brutas no Controller. Utilize exclusivamente os Repositories/Services do ecossistema Crepúsculo.
3. **Proteção da Base Unificada:** Nunca sugira a criação de uma tabela alternativa de `Pessoas` ou `Servidores`. Toda referência individual deve apontar para o ID da tabela corporativa `Pessoa`.
4. **Verificação de Cobertura TDD:** Toda resposta da IA gerando código funcional deve ser acompanhada obrigatoriamente pela sua respectiva classe de teste automatizado PHPUnit/Pest.

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>docs</pasta>
  <subpasta>docs</subpasta>
  <nome_arquivo>Solene_-_Modelos_ATA_Certidao.md</nome_arquivo>
  <caminho_completo>docs/Solene_-_Modelos_ATA_Certidao.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# MODELOS DE ATA E CERTIDÃO DE SOLENIDADE: SISTEMA SOLENE (TRE-AC)

Este documento apresenta os modelos padronizados de **ATA DE SESSÃO SOLENE (REGISTRO HISTÓRICO)** e **CERTIDÃO DE ENCERRAMENTO DE EVENTO** em formato Markdown, estruturados para integração direta no backend da aplicação **SOLENE – Gestão de Cerimonial** do Tribunal Regional Eleitoral do Acre (TRE-AC).

Os templates utilizam a notação de interpolação de tags `{{variavel}}` para serem processados de forma dinâmica pelo motor de renderização da aplicação, realizando a fusão com os dados armazenados nas tabelas de banco de dados (`AtaEvento`, `Evento`, `Pessoa`, `Presenca`, `ParticipanteEvento` e `MesaHonra`) do ecossistema corporativo **Crepúsculo** (derivado do domínio **Presença**).

---

## 🏛️ CONTEXTUALIZAÇÃO PROTOCOLAR E BASE LEGAL

O registro escrito e formal dos atos de solenidade da Justiça Eleitoral do Acre é um imperativo de governança, transparência e segurança jurídica, amparado pelos seguintes dispositivos:
1. **[Resolução TRE-AC nº 349/2002](https://www.tre-ac.jus.br/legislacao/resolucoes-tre)**: Institui a Comissão Permanente de Cerimonial e Protocolo (CPCT), sediada na Alameda Ministro Miguel Ferrante, 224, Bairro Portal da Amazônia, CEP 69915-632, Rio Branco - AC (E-mail: `cerimonial@tre-ac.jus.br` | Tel: (68) 3212-6125), definindo as atribuições de conservação da memória institucional e de registro formal dos atos.
2. **[Código Eleitoral](https://www.tse.jus.br/legislacao/codigo-eleitoral/codigo-eleitoral-1/codigo-eleitoral-lei-nb0-4.737-de-15-de-julho-de-1965)**: Estabelece as regras para a realização de atos públicos formais eleitorais, onde o registro em ata é requisito de validade jurídica.
3. **[Resolução TSE nº 23.677/2021](https://www.tse.jus.br/legislacao/compilada/res/2021/resolucao-no-23-677-de-16-de-dezembro-de-2021)**: Disciplina os ritos solenes de Diplomação dos Candidatos Eleitos, exigindo o encerramento do ato com a lavratura do respectivo registro oficial.
4. **[Decreto Federal nº 70.274/1972](http://www.planalto.gov.br/ccivil_03/decreto/d70274.htm)**: Fornece as diretrizes para a precedência e composição das Mesas de Honra, cujas posições devem ser fielmente documentadas nos relatórios e atas finais das solenidades.

---

## 📝 SEÇÃO I: MODELO DE ATA DE SESSÃO SOLENE (REGISTRO HISTÓRICO)

### 1.1 Template Parametrizado (Markdown para a Plataforma SOLENE)

```markdown
# TRIBUNAL REGIONAL ELEITORAL DO ACRE
## COMISSÃO PERMANENTE DE CERIMONIAL E PROTOCOLO (CPCT)
### ATA DA SESSÃO SOLENE DE {{EVENTO_TIPO_NOME}}

Ao(s) {{EVENTO_DATA_EXTENSO}}, nesta cidade de Rio Branco, capital do Estado do Acre, às {{EVENTO_HORA_INICIO}}, no(a) {{EVENTO_LOCAL_NOME}}, situado na {{EVENTO_LOCAL_ENDERECO}}, reuniu-se o Tribunal Regional Eleitoral do Acre em Sessão Solene, sob a Presidência da Excelentíssima Senhora Desembargadora {{PRESIDENTE_NOME_COMPLETO}}, para a realização da Solenidade de {{EVENTO_TIPO_NOME}} do(a) {{HOMENAGEADO_TITULO}} {{HOMENAGEADO_NOME_COMPLETO}} no cargo/função de {{HOMENAGEADO_CARGO_NOME}}, em estrito cumprimento às disposições legais e regulamentares aplicáveis.

#### I. COMPOSIÇÃO DA MESA DE HONRA (ORDEM DE PRECEDÊNCIA DECRETO 70.274/1972)
A Mesa de Honra foi formalmente estabelecida e devidamente ordenada de acordo com os critérios protocolares, sob a coordenação da CPCT, apresentando a seguinte composição de autoridades em plenário:
{{BLOCO_MESA_HONRA}}
*   **Assento {{MESA_ORDEM}}**: {{MESA_AUTORIDADE_NOME_COMPLETO}} - {{MESA_AUTORIDADE_CARGO}} (Representando o(a) {{MESA_AUTORIDADE_INSTITUICAO}})
{{/BLOCO_MESA_HONRA}}

#### II. REGISTRO DE PARTICIPANTES E AUTORIDADES PRESENTES
Através do sistema de credenciamento e triagem digital da plataforma **SOLENE**, integrado nativamente ao ecossistema corporativo **Crepúsculo** e à **Plataforma Presença**, registrou-se o comparecimento e a confirmação de presença em tempo real das seguintes autoridades e convidados de destaque:
{{BLOCO_PARTICIPANTES_PRESENTES}}
*   **[{{PARTICIPANTE_COR_GRUPO}}]** {{PARTICIPANTE_NOME_COMPLETO}} - {{PARTICIPANTE_CARGO}} ({{PARTICIPANTE_INSTITUICAO}}) - Registro Temporal: {{PARTICIPANTE_CHECKIN_HORA}}
{{/BLOCO_PARTICIPANTES_PRESENTES}}

Registrou-se também a presença de equipes operacionais e de apoio devidamente cadastradas, incluindo acompanhantes, imprensa, seguranças e assessores, totalizando {{EVENTO_TOTAL_OPERACIONAIS}} registros auxiliares validados sob as diretrizes de segurança institucional.

#### III. DESENVOLVIMENTO DOS TRABALHOS
Iniciados os trabalhos de condução física e protocolo às {{EVENTO_HORA_INICIO_REAL}}, a Senhora Presidente da Corte Eleitoral, Desembargadora {{PRESIDENTE_NOME_COMPLETO}}, declarou aberta a Sessão Solene. O mestre de cerimônias oficial do Tribunal realizou o anúncio das autoridades e a leitura da Nominata Inicial de presentes gerada automaticamente pelo sistema SOLENE sob a identificação temporal {{NOMINATA_INICIAL_MARCO_TEMPORAL}}. Durante a execução da solenidade, foram geradas {{NOMINATA_INCREMENTAL_QUANTIDADE}} nominatas incrementais para processar novas entradas de autoridades identificadas pela equipe de recepção móvel na saída dos elevadores e no saguão de entrada. 

Seguindo o rito formal, o(a) empossando(a)/homenageado(a) prestou o seguinte compromisso regulamentar: *“{{HOMENAGEADO_COMPROMISSO_TEXTO}}”*. Declarando não haver qualquer incompatibilidade que o(a) impeça de assumir as atribuições inerentes ao cargo, o(a) empossando(a) entregou a sua declaração de bens, que passa a integrar os arquivos administrativos do TRE-AC, e foi formalmente empossado(a) na forma da Lei.

#### IV. ENCERRAMENTO E ASSINATURAS
Nada mais havendo a tratar, a Presidência do Tribunal Regional Eleitoral do Acre declarou encerrados os atos solenes às {{EVENTO_HORA_FIM_REAL}} do dia {{EVENTO_DATA_FORMATADA}}. Para constar, eu, {{DIRETOR_GERAL_NOME_COMPLETO}}, Diretora-Geral da Secretaria do TRE-AC, lavrei a presente Ata que, após lida e achada conforme por todos os presentes, vai assinada eletronicamente pelos legitimados e arquivada permanentemente na base de dados histórica do sistema **SOLENE**.

---
**EMPOSSANTE/PRESIDENTE:**
 Desembargadora {{PRESIDENTE_NOME_COMPLETO}}
 Presidente do Tribunal Regional Eleitoral do Acre - TRE-AC

**EMPOSSADO/HOMENAGEADO:**
 {{HOMENAGEADO_TITULO}} {{HOMENAGEADO_NOME_COMPLETO}}
 {{HOMENAGEADO_CARGO_NOME}}

**SECRETÁRIA/DIRETORA-GERAL:**
 {{DIRETOR_GERAL_NOME_COMPLETO}}
 Diretora-Geral do TRE-AC
```

---

### 1.2 Exemplo Instanciado (Caso Real de Posse de Jurista no TRE-AC)

```markdown
# TRIBUNAL REGIONAL ELEITORAL DO ACRE
## COMISSÃO PERMANENTE DE CERIMONIAL E PROTOCOLO (CPCT)
### ATA DA SESSÃO SOLENE DE POSSE

Aos vinte e cinco dias do mês de março do ano de dois mil e vinte e seis, nesta cidade de Rio Branco, capital do Estado do Acre, às onze horas, no Plenário do Tribunal Regional Eleitoral do Acre, situado na Alameda Ministro Miguel Ferrante, nº 224, Bairro Portal da Amazônia, reuniu-se o Tribunal Regional Eleitoral do Acre em Sessão Solene, sob a Presidência da Excelentíssima Senhora Presidente do Tribunal Regional Eleitoral do Acre, Desembargadora WALDIRENE OLIVEIRA DA CRUZ - LIMA CORDEIRO, para a realização da Solenidade de Posse do Advogado THALLES VINICIUS DE SOUZA SALES no cargo de Membro Efetivo da Classe de Jurista deste Tribunal, biênio 2026/2028, em estrito cumprimento às disposições legais e regulamentares aplicáveis.

#### I. COMPOSIÇÃO DA MESA DE HONRA (ORDEM DE PRECEDÊNCIA DECRETO 70.274/1972)
A Mesa de Honra foi formalmente estabelecida e devidamente ordenada de acordo com os critérios protocolares, sob a coordenação da CPCT, apresentando a seguinte composição de autoridades em plenário:
*   **Assento 1**: Desembargadora WALDIRENE OLIVEIRA DA CRUZ - LIMA CORDEIRO - Presidente (Tribunal Regional Eleitoral do Acre - TRE-AC)
*   **Assento 2**: Desembargador LOIS CARLOS ARRUDA - Vice-Presidente e Corregedor (Tribunal Regional Eleitoral do Acre - TRE-AC)
*   **Assento 3**: Doutor CARLOS ROBERTO DA SILVA - Presidente do COPTREL (Colégio de Presidentes dos Tribunais Regionais Eleitorais do Brasil)
*   **Assento 4**: Doutor SAMOEL EVANGELISTA - Membro Efetivo da Corte (Tribunal de Justiça do Estado do Acre - TJ-AC)

#### II. REGISTRO DE PARTICIPANTES E AUTORIDADES PRESENTES
Através do sistema de credenciamento e triagem digital da plataforma **SOLENE**, integrado nativamente ao ecossistema corporativo **Crepúsculo** e à **Plataforma Presença**, registrou-se o comparecimento e a confirmação de presença em tempo real das seguintes autoridades e convidados de destaque:
*   **[VERMELHO]** Desembargadora Waldirene Oliveira da Cruz - Lima Cordeiro - Presidente (TRE-AC) - Registro Temporal: 10:42:15
*   **[VERMELHO]** Desembargador Lois Carlos Arruda - Vice-Presidente (TRE-AC) - Registro Temporal: 10:45:30
*   **[AZUL]** Desembargador Carlos Roberto da Silva - Presidente (COPTREL) - Registro Temporal: 10:48:12
*   **[AZUL]** Desembargador Samoel Evangelista - Membro de Corte (TJ-AC) - Registro Temporal: 10:50:05
*   **[VERDE]** Doutor Thalles Vinicius de Souza Sales - Advogado (OAB-AC) - Registro Temporal: 10:52:19
*   **[AMARELO]** Senhora Maria Helena Sales - Convidada Geral (Familiar) - Registro Temporal: 10:55:00

Registrou-se também a presença de equipes operacionais e de apoio devidamente cadastradas, incluindo acompanhantes, imprensa, seguranças e assessores, totalizando 14 registros auxiliares validados sob as diretrizes de segurança institucional.

#### III. DESENVOLVIMENTO DOS TRABALHOS
Iniciados os trabalhos de condução física e protocolo às onze horas, a Senhora Presidente da Corte Eleitoral, Desembargadora Waldirene Oliveira da Cruz - Lima Cordeiro, declarou aberta a Sessão Solene. O mestre de cerimônias oficial do Tribunal realizou o anúncio das autoridades e a leitura da Nominata Inicial de presentes gerada automaticamente pelo sistema SOLENE sob a identificação temporal 25/03/2026-11:02:14. Durante a execução da solenidade, foram geradas 2 nominatas incrementais para processar novas entradas de autoridades identificadas pela equipe de recepção móvel na saída dos elevadores e no saguão de entrada.

Seguindo o rito formal, o empossando prestou o seguinte compromisso regulamentar: *“Prestar o compromisso formal de exercer com retidão as funções de Membro Efetivo da Classe de Jurista deste Tribunal, respeitando a Constituição e as Leis da República”*. Declarando não haver qualquer incompatibilidade que o impeça de assumir as atribuições inerentes ao cargo, o empossando entregou a sua declaração de bens, que passa a integrar os arquivos administrativos do TRE-AC, e foi formalmente empossado na forma da Lei, de acordo com o Decreto da Presidência da República publicado no Diário Oficial da União em 5 de março de 2026, Edição 43, Seção 2, Página 1, conforme previsto no art. 120, § 1º, III, da Constituição Federal.

#### IV. ENCERRAMENTO E ASSINATURAS
Nada mais havendo a tratar, a Presidência do Tribunal Regional Eleitoral do Acre declarou encerrados os atos solenes às doze horas e quinze minutos do dia vinte e cinco de março de dois mil e vinte e seis. Para constar, eu, Maria Verônica da Costa, Diretora-Geral da Secretaria do TRE-AC, lavrei a presente Ata que, após lida e achada conforme por todos os presentes, vai assinada eletronicamente pelos legitimados e arquivada permanentemente na base de dados histórica do sistema **SOLENE**.

---
**EMPOSSANTE/PRESIDENTE:**
 WALDIRENE OLIVEIRA DA CRUZ - LIMA CORDEIRO
 Desembargadora Presidente do Tribunal Regional Eleitoral do Acre - TRE-AC

**EMPOSSADO/HOMENAGEADO:**
 THALLES VINICIUS DE SOUZA SALES
 Advogado Empossado como Membro Efetivo na Classe de Jurista (Biênio 2026/2028)

**SECRETÁRIA/DIRETORA-GERAL:**
 MARIA VERÔNICA DA COSTA
 Diretora-Geral da Secretaria do TRE-AC
```

---

## 📜 SEÇÃO II: MODELO DE CERTIDÃO DE ENCERRAMENTO DE SOLENIDADE

### 2.1 Template Parametrizado (Markdown para a Plataforma SOLENE)

```markdown
# TRIBUNAL REGIONAL ELEITORAL DO ACRE
## SECRETARIA GERAL DA DIRETORIA-GERAL DO TRE-AC
### CERTIDÃO DE ENCERRAMENTO E ARQUIVAMENTO PROTOCOLAR

**CERTIDÃO Nº {{CERTIDAO_NUMERO}} / {{CERTIDAO_ANO}} - CPCT**

**CERTIFICO**, para os devidos fins de direito, controle administrativo e consolidação da Memória Institucional da Justiça Eleitoral do Acre, em estrita conformidade com as diretrizes da **Resolução TRE-AC nº 349/2002**, que o evento oficial cadastrado sob a identificação única **ID #{{EVENTO_ID}}** e intitulado **"{{EVENTO_NOME}}"** foi integralmente realizado, concluído e arquivado de forma sistêmica na plataforma **SOLENE – Gestão de Cerimonial** na data de {{EVENTO_ENCERRAMENTO_DATA_HORA}}.

**CERTIFICO**, em complementação, os seguintes detalhes consolidados a partir dos registros digitais de credenciamento do ecossistema **Crepúsculo** (Plataforma Presença) e de segurança pública integrada (**Sistema Visite**):

1.  **Do Objeto e Natureza Solene:** Trata-se de Sessão Solene de {{EVENTO_TIPO_NOME}}, realizada no Plenário do Tribunal Regional Eleitoral do Acre, situado na Alameda Ministro Miguel Ferrante, nº 224, Bairro Portal da Amazônia, em Rio Branco-Acre, tendo como homenageado(a)/empossando(a) o(a) Senhor(a) {{HOMENAGEADO_NOME_COMPLETO}} no cargo de {{HOMENAGEADO_CARGO_NOME}}.
2.  **Dos Registros de Presença Efetiva:** O sistema registrou o credenciamento de entrada em tempo real de **{{EVENTO_TOTAL_PRESENTES}} participantes**, incluindo membros da Corte Eleitoral, chefes de Poderes do Estado, representantes diplomáticos e convidados em geral, cujos dados nominais individuais constam detalhados na Ata Oficial do Evento.
3.  **Do Controle de Acesso e Segurança (Integração Visite):** Todas as consultas de CPF do público participante foram devidamente submetidas ao barramento de validação de restrições do sistema **Visite**. Foram identificadas {{EVENTO_TOTAL_OCORRENCIAS_SEGURANCA}} ocorrências restritivas, as quais foram processadas de forma ágil e silenciosa pela equipe de Segurança Institucional do TRE-AC, garantindo a manutenção do protocolo físico e ritos de segurança da Corte.
4.  **Do Processamento de Nominatas e Registros de Voz:** O Cerimonial realizou a geração e leitura de {{NOMINATA_INCREMENTAL_QUANTIDADE}} Nominatas de Autoridades, cujos logs de anúncio e marcos temporais foram completamente travados contra alterações após o encerramento do evento, em conformidade com a Regra de Negócio **RN-005** do sistema.
5.  **Do Diploma Eleitoral (Se aplicável):** Certifica-se que, para fins do rito regulado pela **Resolução TSE nº 23.677/2021**, o diploma digital correspondente foi emitido e vinculado ao registro do participante, com código verificador arquivado na base de dados.

O encerramento oficial do evento na plataforma digital ocorreu às {{EVENTO_ENCERRAMENTO_HORA_MINUTOS}}, momento em que o sistema bloqueou automaticamente qualquer edição sobre a lista de presenças, assentos, fotos oficiais ou arquivos de transmissão, gerando o arquivo final em formato padronizado PDF/A de preservação digital de longo prazo de ID **{{EVENTO_PDF_UUID}}**.

E, por ser verdade, eu, {{DIRETOR_GERAL_NOME_COMPLETO}}, Diretora-Geral da Secretaria do Tribunal Regional Eleitoral do Acre, emito a presente Certidão de fé pública, assinada digitalmente por meio da infraestrutura de chaves públicas institucional, em Rio Branco-Acre, na data de {{CERTIDAO_DATA_EMISSAO_EXTENSO}}.

---
**VALIDADOR DE FÉ PÚBLICA / DIRETORIA-GERAL:**
 {{DIRETOR_GERAL_NOME_COMPLETO}}
 Diretora-Geral do TRE-AC
 Documento assinado eletronicamente conforme padrões ICP-Brasil
```

---

### 2.2 Exemplo Instanciado (Caso Real de Solenidade do TRE-AC)

```markdown
# TRIBUNAL REGIONAL ELEITORAL DO ACRE
## SECRETARIA GERAL DA DIRETORIA-GERAL DO TRE-AC
### CERTIDÃO DE ENCERRAMENTO E ARQUIVAMENTO PROTOCOLAR

**CERTIDÃO Nº 89 / 2026 - CPCT**

**CERTIFICO**, para os devidos fins de direito, controle administrativo e consolidação da Memória Institucional da Justiça Eleitoral do Acre, em estrita conformidade com as diretrizes da **Resolução TRE-AC nº 349/2002**, que o evento oficial cadastrado sob a identificação única **ID #1599** e intitulado **"Solenidade de Posse de Membro de Corte - Classe de Jurista (Biênio 2026/2028)"** foi integralmente realizado, concluído e arquivado de forma sistêmica na plataforma **SOLENE – Gestão de Cerimonial** na data de 25 de março de 2026, às 12h15min.

**CERTIFICO**, em complementação, os seguintes detalhes consolidados a partir dos registros digitais de credenciamento do ecossistema **Crepúsculo** (Plataforma Presença) e de segurança pública integrada (**Sistema Visite**):

1.  **Do Objeto e Natureza Solene:** Trata-se de Sessão Solene de Posse, realizada no Plenário do Tribunal Regional Eleitoral do Acre, situado na Alameda Ministro Miguel Ferrante, nº 224, Bairro Portal da Amazônia, em Rio Branco-Acre, tendo como homenageado/empossando o Senhor Advogado THALLES VINICIUS DE SOUZA SALES no cargo de Membro Efetivo da Classe de Jurista (Biênio 2026/2028).
2.  **Dos Registros de Presença Efetiva:** O sistema registrou o credenciamento de entrada em tempo real de **82 participantes**, incluindo membros da Corte Eleitoral, chefes de Poderes do Estado, representantes diplomáticos e convidados em geral, cujos dados nominais individuais constam detalhados na Ata Oficial do Evento.
3.  **Do Controle de Acesso e Segurança (Integração Visite):** Todas as consultas de CPF do público participante foram devidamente submetidas ao barramento de validação de restrições do sistema **Visite**. Foram identificadas 0 ocorrências restritivas, as quais foram processadas de forma ágil e silenciosa pela equipe de Segurança Institucional do TRE-AC, garantindo a manutenção do protocolo físico e ritos de segurança da Corte.
4.  **Do Processamento de Nominatas e Registros de Voz:** O Cerimonial realizou a geração e leitura de 2 Nominatas de Autoridades, cujos logs de anúncio e marcos temporais foram completamente travados contra alterações após o encerramento do evento, em conformidade com a Regra de Negócio **RN-005** do sistema.
5.  **Do Diploma Eleitoral (Se aplicável):** Certifica-se que, para fins do rito regulado pela **Resolução TSE nº 23.677/2021**, o diploma digital correspondente de outorga de biênio foi emitido e vinculado ao registro do participante, com código verificador arquivado na base de dados para integridade de consulta externa.

O encerramento oficial do evento na plataforma digital ocorreu às 12 horas e 15 minutos, momento em que o sistema bloqueou automaticamente qualquer edição sobre a lista de presenças, assentos, fotos oficiais ou arquivos de transmissão, gerando o arquivo final em formato padronizado PDF/A de preservação digital de longo prazo de ID **d3b07384-d76f-42db-bf8d-d558ecc705bf**.

E, por ser verdade, eu, Maria Verônica da Costa, Diretora-Geral da Secretaria do Tribunal Regional Eleitoral do Acre, emito a presente Certidão de fé pública, assinada digitalmente por meio da infraestrutura de chaves públicas institucional, em Rio Branco-Acre, na data de vinte e cinco de março de dois mil e vinte e seis.

---
**VALIDADOR DE FÉ PÚBLICA / DIRETORIA-GERAL:**
 MARIA VERÔNICA DA COSTA
 Diretora-Geral da Secretaria do TRE-AC
 Documento assinado eletronicamente conforme padrões ICP-Brasil
```

---

## 🛠️ MAPEAMENTO TÉCNICO DE INTEGRAÇÃO (BD-ORM PHP/LAVEL)

Para guiar os programadores recém-empossados na correta implementação dos templates em Markdown no backend do SOLENE, apresenta-se abaixo o de/para relacional das tabelas de dados:

| Tag de Interpolação | Entidade de Origem (PostgreSQL) | Atributo / Campo Técnico | Regra de Negócio de Processamento |
| :--- | :--- | :--- | :--- |
| `{{EVENTO_TIPO_NOME}}` | `TipoEvento` | `descricao` | Classifica se é "Posse", "Diplomação", "Sessão Solene", "Abertura", "Homenagem", etc. |
| `{{EVENTO_NOME}}` | `Evento` | `nome` | Nome oficial atribuído à solenidade. |
| `{{EVENTO_LOCAL_NOME}}` | `Evento` | `local` | Nome físico do local (ex: Plenário, Plenarinho, Auditório). |
| `{{MESA_AUTORIDADE_NOME}}` | `Pessoa` | `nome` | Nome da autoridade em mesa de honra, ordenada de acordo com a tabela `MesaHonra` pelo campo `ordem` (Decreto 70.274/1972). |
| `{{PARTICIPANTE_COR_GRUPO}}` | `CategoriaParticipante` | `cor_identificacao` | Retorna a cor correspondente à categoria (Vermelho, Azul, Verde, Amarelo). |
| `{{PARTICIPANTE_CHECKIN_HORA}}` | `Presenca` | `data_hora` | Timestamp exato de entrada em tempo real. |
| `{{NOMINATA_INICIAL_MARCO}}` | `Nominata` | `gerada_em` | Data/hora do marco temporal de criação da primeira nominata de presentes do mestre de cerimônias. |
| `{{EVENTO_PDF_UUID}}` | `AtaEvento` | `arquivo_pdf` | Identificador único universal do arquivo digital PDF/A armazenado em disco para evitar fraudes ou alterações retroativas (**RN-005**). |

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>documentacao_md_consolidada</pasta>
  <subpasta>documentacao_md_consolidada</subpasta>
  <nome_arquivo>Levantamento_codigo.md</nome_arquivo>
  <caminho_completo>documentacao_md_consolidada/Levantamento_codigo.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
``` 


A versão Beta do projeto "Solene - Gestão de Cerimonial" foi implementada em produção;
Com o objetivo de processar a avaliação de uso e futuro ajustes, melhorias e migração; 
Sabedores de que Nesta FASE está sendo consolidada a documentação do projeto; Com o objetivo de conhecer e dimensionar a documentação e código já produzidos; 
Com o propósito de atenuar e otimizar o processamento a ser realizado por Esta ferramenta IA; 
Se utilizando das normas de engenharia de software:

. Criar um script em "bash" para execução em linux Ubuntu versão 24; 
. O script deverá ser parametrizável para utilização na busca de conteúdo de arquivos com extensão pré-definidas; 
. A denominação do projeto é: "Solene - Gestão de Cerimonial"; 
. A extensão dos arquivos é: "*.md" e "*.php"; 
. buscar à partir da pasta atual e suas sub-pastas; 
. selecionar todos os arquivos com extensão: "*.md" e "*.php"; 
. agrupar seus conteúdos em arquivo único, com limitação do tamanho; 
. criar novo arquivo versionado quando o tamanho máximo for alcançado; 
. O nome do arquivos estará relacionado sua funcionalidade
. agrupar seus conteúdos por funcionalidades temática; 
. agrupar seus conteúdos por extensão; 
. dimensionar o tamanho máximo do arquivo compilado conforme a capacidade de processamento Desta IA; 
. manter o máximo de informações essenciais no levantamento do projeto "Solene"; 
. saída: 
. O nome do script a ser criado é: "levantamento_migracao.sh"; 
. A pasta de destino da saída é: "Levantamento_Migracao"; 
. Os arquivos a serem gerados pelo script deverão estar no formato markdown "md"; 
. Cada conteúdo de arquivo estará sob a TAG "pasta", "subpasta" e "nome do arquivo"; 
. o conteúdo de saída será otimizado para o processamento de agente IA; 

``` 

Desenvolvi o script automatizado **`levantamento_migracao.sh`** em **Bash**, totalmente parametrizável e otimizado para execução em **Linux Ubuntu 24.04 LTS**. 

O arquivo executável foi publicado no seu painel **Studio** sob o nome **`levantamento_migracao.sh`**.

---

### 🛠️ Características Técnicas do Script

O script foi projetado seguindo as melhores práticas de Engenharia de Software e integração com **Agentes de Inteligência Artificial**:

1. **Parametrização Flexível:** Aceita argumentos via linha de comando para alterar extensões de busca (padrão: `md php`), tamanho máximo por arquivo (padrão: `500 KB`), diretório raiz e pasta de destino (`Levantamento_Migracao`).
2. **Dimensionamento para Janela de Contexto de IA:** O limite padrão de **500 KB** por volume gerado garante que os arquivos consolidados se ajustem com segurança à capacidade de processamento dos modelos de linguagem (~125.000 tokens), evitando truncamentos.
3. **Estrutura de Rotação e Versionamento Automatizado:** Quando o arquivo compilado atinge o tamanho limite, o script rotaciona a escrita automaticamente criando uma nova versão (`solene_levantamento_funcionalidades_v1.md`, `_v2.md`, etc.).
4. **Marcação Semântica para Agentes de IA:** Cada arquivo varrido é envelopado com tags estruturadas em formato XML/Markdown (`<pasta>`, `<subpasta>`, `<nome_arquivo>`, `<caminho_completo>`, `<extensao>` e `<conteudo>`), permitindo que a IA compreenda a árvore de diretórios e o contexto do projeto.
5. **Agrupamento Temático e por Extensão:** Realiza a ordenação das seções primeiro por tipo de arquivo (`.md` para documentação de arquitetura/processos e `.php` para o código-fonte) e por agrupamentos de diretórios.

---

### 📜 Código-Fonte do Script (`levantamento_migracao.sh`)

```bash
#!/bin/bash
# ==============================================================================
# SCRIPT DE LEVANTAMENTO E COMPILAÇÃO DE CÓDIGO/DOCUMENTAÇÃO PARA MIGRAÇÃO
# Projeto: Solene - Gestão de Cerimonial (TRE-AC)
# Alvo: Linux Ubuntu 24.04 LTS / Agentes de Inteligência Artificial
# ==============================================================================

set -euo pipefail

# Configurações Padrão (Parametrizáveis)
NOME_PROJETO="Solene - Gestão de Cerimonial"
PASTA_SAIDA="Levantamento_Migracao"
EXTENSOES=("md" "php")
TAMANHO_MAX_KB=500   # Tamanho limite em KB otimizado para Janela de Contexto de IA (~125k tokens)
DIRETORIO_RAIZ="."

# Função de Ajuda / Uso
exibir_ajuda() {
    cat << EOF
Uso: \$0 [OPÇÕES]

Script automatizado de levantamento de código e documentação para migração do projeto:
"\$NOME_PROJETO".

Opções:
  -e, --extensoes "ext1 ext2"   Lista de extensões separadas por espaço (Padrão: "md php")
  -o, --out-dir "DIRETORIO"     Pasta de destino para os arquivos consolidados (Padrão: "Levantamento_Migracao")
  -s, --max-size-kb TAMANHO     Tamanho máximo de cada arquivo gerado em KB (Padrão: 500)
  -d, --dir-raiz "CAMINHO"      Diretório de busca inicial (Padrão: ".")
  -h, --help                    Exibe esta mensagem de ajuda

Exemplo:
  \$0 -e "md php sql" -s 400 -o "Levantamento_Migracao"
EOF
    exit 0
}

# Parsing de Parâmetros de Linha de Comando
while [[ \$# -gt 0 ]]; do
    case "\$1" in
        -e|--extensoes)
            IFS=' ' read -r -a EXTENSOES <<< "\$2"
            shift 2
            ;;
        -o|--out-dir)
            PASTA_SAIDA="\$2"
            shift 2
            ;;
        -s|--max-size-kb)
            TAMANHO_MAX_KB="\$2"
            shift 2
            ;;
        -d|--dir-raiz)
            DIRETORIO_RAIZ="\$2"
            shift 2
            ;;
        -h|--help)
            exibir_ajuda
            ;;
        *)
            echo "Opção desconhecida: \$1"
            exibir_ajuda
            ;;
    esac
done

# Criação do diretório de saída
mkdir -p "\$PASTA_SAIDA"

# Variáveis do Processador de Arquivos
VERSAO=1
ARQUIVO_ATUAL="\\(PASTA_SAIDA/solene_levantamento_funcionalidades_v\\){VERSAO}.md"
TOTAL_ARQUIVOS_PROCESSADOS=0
DATA_GERACAO=\$(date '+%Y-%m-%d %H:%M:%S')

# Função para iniciar um novo arquivo consolidado versionado
iniciar_novo_arquivo() {
    ARQUIVO_ATUAL="\\(PASTA_SAIDA/solene_levantamento_funcionalidades_v\\){VERSAO}.md"
    cat << EOF > "\$ARQUIVO_ATUAL"
# LEVANTAMENTO TÉCNICO E DOCUMENTAL PARA MIGRAÇÃO
## Projeto: \$NOME_PROJETO
**Volume:** \$VERSAO  
**Data de Gerada:** \$DATA_GERACAO  
**Tamanho Máximo Alvo:** \${TAMANHO_MAX_KB} KB  
**Extensões Incluídas:** \${EXTENSOES[*]}  
**Plataforma de Destino:** Agente de Inteligência Artificial / LLM  

---

> **INSTRUÇÃO PARA O AGENTE DE IA:**  
> Este arquivo contém a compilação estruturada de arquivos do projeto **\$NOME_PROJETO**.
> Cada arquivo fonte está delimitado por tags estruturadas \`<arquivo>\`, contendo os metadados de localização (\`<pasta>\`, \`<subpasta>\`, \`<nome_arquivo>\`, \`<extensao>\`) e o bloco de código/texto em \`<conteudo>\`.
> Utilize estes metadados para mapear o modelo de dados, as regras de negócio e os fluxos de migração.

---

EOF
    echo "Novo volume gerado: \$ARQUIVO_ATUAL"
}

# Verificar se o arquivo atual excedeu o tamanho limite
verificar_tamanho_e_rotacionar() {
    if [[ -f "\$ARQUIVO_ATUAL" ]]; then
        local tamanho_atual_kb
        tamanho_atual_kb=\\((du -k "\\)ARQUIVO_ATUAL" | cut -f1)
        if [[ "\\(tamanho_atual_kb" -ge "\\)TAMANHO_MAX_KB" ]]; then
            echo "   [!] Volume v\\({VERSAO} atingiu \\){tamanho_atual_kb} KB. Rotacionando para novo volume..."
            VERSAO=\$((VERSAO + 1))
            iniciar_novo_arquivo
        fi
    fi
}

# Iniciar o primeiro volume
iniciar_novo_arquivo

echo "=============================================================================="
echo "Iniciando Levantamento de Código e Documentação - \$NOME_PROJETO"
echo "Diretório de Busca: \$DIRETORIO_RAIZ"
echo "Extensões Selecionadas: \${EXTENSOES[*]}"
echo "Pasta de Saída: \$PASTA_SAIDA"
echo "Tamanho Limite por Volume: \${TAMANHO_MAX_KB} KB"
echo "=============================================================================="

# Loop por Extensão (Agrupamento por Tipo)
for ext in "\${EXTENSOES[@]}"; do
    echo "Processing extensão: .\$ext..."

    # Construção do comando de busca com find
    # Ignora pastas comuns de cache/dependências se existirem
    mapfile -t LISTA_ARQUIVOS < <(find "\$DIRETORIO_RAIZ" \
        \\( -path "*/.git" -o -path "*/vendor" -o -path "*/node_modules" -o -path "*/\$PASTA_SAIDA" \\) -prune \
        -o -type f -name "*.\$ext" -print | sort)

    if [[ \${#LISTA_ARQUIVOS[@]} -eq 0 ]]; then
        echo "   Nenhum arquivo com extensão .\$ext encontrado."
        continue
    fi

    # Adicionar divisor de seção por extensão no arquivo
    cat << EOF >> "\$ARQUIVO_ATUAL"

# ==============================================================================
# SEÇÃO TEMÁTICA POR EXTENSÃO: .\$ext
# ==============================================================================

EOF

    for arquivo_path in "\${LISTA_ARQUIVOS[@]}"; do
        # Remover prefixo ./ se existir
        caminho_limpo="\${arquivo_path#./}"
        
        # Extrair metadados de caminho
        nome_arquivo=\\((basename "\\)caminho_limpo")
        caminho_diretorio=\\((dirname "\\)caminho_limpo")
        
        # Identificar pasta principal e subpasta
        if [[ "\$caminho_diretorio" == "." ]]; then
            pasta_principal="raiz"
            subpasta="raiz"
        else
            pasta_principal=\\((echo "\\)caminho_diretorio" | cut -d'/' -f1)
            subpasta="\$caminho_diretorio"
        fi

        verificar_tamanho_e_rotacionar

        # Escrever entrada do arquivo formatada para o agente de IA
        cat << EOF >> "\$ARQUIVO_ATUAL"
<arquivo>
  <pasta>\$pasta_principal</pasta>
  <subpasta>\$subpasta</subpasta>
  <nome_arquivo>\$nome_arquivo</nome_arquivo>
  <caminho_completo>\$caminho_limpo</caminho_completo>
  <extensao>\$ext</extensao>
  <conteudo>
\`\`\`$ext
EOF

        # Anexar conteúdo do arquivo tratando potenciais erros de leitura
        cat "$arquivo_path" >> "$ARQUIVO_ATUAL" 2>/dev/null || echo "// [Erro ao ler conteúdo do arquivo]" >> "$ARQUIVO_ATUAL"

        cat << EOF >> "$ARQUIVO_ATUAL"

\`\`\`
  </conteudo>
</arquivo>

EOF

        TOTAL_ARQUIVOS_PROCESSADOS=\$((TOTAL_ARQUIVOS_PROCESSADOS + 1))
        echo "   [OK] Processado: \$caminho_limpo"
    done
done

echo "=============================================================================="
echo " Levantamento Concluído com Sucesso!"
echo " Total de arquivos consolidados: \$TOTAL_ARQUIVOS_PROCESSADOS"
echo " Volumes gerados em '\\(PASTA_SAIDA/': \\)VERSAO arquivo(s)"
echo "=============================================================================="
```

---

### 🚀 Como Executar no Ubuntu 24.04

1. Dê permissão de execução ao script:
   ```bash
   chmod +x levantamento_migracao.sh
   ```
2. Execute com as configurações padrão na raiz do seu projeto:
   ```bash
   ./levantamento_migracao.sh
   ```
3. (Opcional) Personalize os parâmetros (ex: incluindo extensões `.sql` ou ajustando o tamanho máximo por volume):
   ```bash
   ./levantamento_migracao.sh -e "md php sql" -s 400 -o "Levantamento_Migracao"
   ```

---

### 📦 Estrutura do Arquivo de Saída Gerado (Exemplo para IA)

Cada volume gerado na pasta `Levantamento_Migracao/` apresentará a estrutura ideal para ingestão por agentes de IA:

```xml
<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Services/Cerimonial</subpasta>
  <nome_arquivo>NominataService.php</nome_arquivo>
  <caminho_completo>app/Services/Cerimonial/NominataService.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php
// Conteúdo do arquivo mantido de forma integral sem resumos
```
  </conteudo>
</arquivo>
```

💻 Gostaria de definir uma lista de diretrizes para a criação do plano de migração do banco PostgreSQL para a nova arquitetura de microsserviços com base nos dados que serão extraídos por este script?

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>raiz</pasta>
  <subpasta>raiz</subpasta>
  <nome_arquivo>README.md</nome_arquivo>
  <caminho_completo>README.md</caminho_completo>
  <extensao>md</extensao>
  <conteudo>
```md
# solene-laravel



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin http://git.tre-ac.jus.br/sti-dev/solene-laravel.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](http://git.tre-ac.jus.br/sti-dev/solene-laravel/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.

```
  </conteudo>
</arquivo>


# ==============================================================================
# SEÇÃO TEMÁTICA POR EXTENSÃO: .php
# ==============================================================================

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Console/Commands</subpasta>
  <nome_arquivo>AclSyncCommand.php</nome_arquivo>
  <caminho_completo>app/Console/Commands/AclSyncCommand.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Console\Commands;

use App\Models\AcessoRota;
use Illuminate\Console\Command;
use Illuminate\Routing\Route;
use Illuminate\Support\Facades\Route as RouteFacade;

/**
 * Mantém o catálogo `acesso_rotas` em sincronia com `Route::getRoutes()`.
 *
 * Comportamento:
 *  - INSERT pra rotas nomeadas novas
 *  - UPDATE de rota_path / menu_path quando mudaram
 *  - Reativa rotas que voltaram a existir
 *  - Marca ativo=0 nas que sumiram do código
 *  - Garante a presença da linha '*' (curinga de admin) sempre ativa
 *
 * Rotas sem nome são ignoradas — ACL identifica rota por nome.
 * Idempotente: rodar 2x não muda nada se o código não mudou.
 */
class AclSyncCommand extends Command
{
    protected $signature = 'acl:sync';

    protected $description = 'Sincroniza o catálogo acesso_rotas com as rotas nomeadas do Laravel.';

    public function handle(): int
    {
        $rotasCodigo = $this->coletarRotasNomeadas();
        $existentes = AcessoRota::all()->keyBy('rota_nome');

        $criadas = 0;
        $atualizadas = 0;
        $inativadas = 0;

        foreach ($rotasCodigo as $nome => $info) {
            $rota = $existentes->get($nome);

            if ($rota === null) {
                AcessoRota::create([
                    'rota_nome' => $nome,
                    'rota_path' => $info['rota_path'],
                    'menu_path' => $info['menu_path'],
                    'ativo' => true,
                ]);
                $criadas++;

                continue;
            }

            $mudou = $rota->rota_path !== $info['rota_path']
                || $rota->menu_path !== $info['menu_path']
                || $rota->ativo === false;

            $rota->fill([
                'rota_path' => $info['rota_path'],
                'menu_path' => $info['menu_path'],
                'ativo' => true,
            ])->save();

            if ($mudou) {
                $atualizadas++;
            }
        }

        foreach ($existentes as $nome => $rota) {
            if ($nome === AcessoRota::CURINGA) {
                continue;
            }
            if (! isset($rotasCodigo[$nome]) && $rota->ativo) {
                $rota->update(['ativo' => false]);
                $inativadas++;
            }
        }

        $curinga = $existentes->get(AcessoRota::CURINGA);
        if ($curinga === null) {
            AcessoRota::create([
                'rota_nome' => AcessoRota::CURINGA,
                'rota_path' => null,
                'menu_path' => null,
                'descricao' => 'Curinga de admin — qualquer grupo vinculado tem acesso a tudo.',
                'ativo' => true,
            ]);
            $criadas++;
        } elseif (! $curinga->ativo) {
            $curinga->update(['ativo' => true]);
        }

        $this->info("ACL sincronizada: {$criadas} criadas, {$atualizadas} atualizadas, {$inativadas} inativadas.");

        return self::SUCCESS;
    }

    /**
     * @return array<string, array{rota_path: string, menu_path: string}>
     */
    private function coletarRotasNomeadas(): array
    {
        $rotas = [];

        /** @var Route $route */
        foreach (RouteFacade::getRoutes() as $route) {
            $nome = $route->getName();
            if ($nome === null || $nome === '') {
                continue;
            }

            $rotas[$nome] = [
                'rota_path' => '/'.ltrim($route->uri(), '/'),
                'menu_path' => $this->derivarMenuPath($nome),
            ];
        }

        return $rotas;
    }

    /**
     * Deriva um breadcrumb default a partir do nome da rota.
     * "admin.feriados.create" → "Admin > Feriados > Create".
     * Admin pode editar manualmente via UI depois.
     */
    private function derivarMenuPath(string $nome): string
    {
        return collect(explode('.', $nome))
            ->map(fn (string $parte) => ucfirst($parte))
            ->implode(' > ');
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>AssentoController.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/AssentoController.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Http\Requests\SentarAssentoRequest;
use App\Models\Autoridade;
use App\Models\Convidado;
use App\Models\Evento;
use App\Services\AssentosService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Str;
use RuntimeException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class AssentoController extends Controller
{
    public function __construct(private readonly AssentosService $assentos) {}

    /**
     * Senta uma autoridade (existente ou nova) numa poltrona do evento.
     * Autoridade nova é gravada no cadastro global e reaproveitável depois.
     */
    public function sentar(SentarAssentoRequest $request, Evento $evento): RedirectResponse
    {
        $dados = $request->validated();

        $autoridade = isset($dados['autoridade_id'])
            ? Autoridade::findOrFail($dados['autoridade_id'])
            : Autoridade::create([
                'nome' => Str::upper(trim($dados['nome'])),
                'titulacao' => $dados['titulacao'] ?? null,
                'cargo' => $dados['cargo'],
            ]);

        try {
            $this->assentos->sentar($evento, $autoridade, $dados['cor'], (int) $dados['numero']);
        } catch (RuntimeException $e) {
            return redirect()
                ->route('eventos.assentos', $evento)
                ->with('erro', $e->getMessage());
        }

        return redirect()
            ->route('eventos.assentos', $evento)
            ->with('sucesso', "{$autoridade->nome} sentado(a).");
    }

    /** Libera a poltrona ocupada pelo convidado. */
    public function liberar(Evento $evento, Convidado $convidado): RedirectResponse
    {
        if ($convidado->evento_id !== $evento->id) {
            throw new NotFoundHttpException;
        }

        $nome = $convidado->nome;
        $this->assentos->liberar($convidado);

        return redirect()
            ->route('eventos.assentos', $evento)
            ->with('sucesso', "Poltrona de {$nome} liberada.");
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>AutoridadeController.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/AutoridadeController.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Autoridade;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AutoridadeController extends Controller
{
    /**
     * Busca autoridades no cadastro global por nome (para sentar em poltrona).
     * Retorna JSON consumido pelo modal do mapa de assentos.
     */
    public function buscar(Request $request): JsonResponse
    {
        $termo = trim((string) $request->query('q', ''));

        $autoridades = Autoridade::query()
            ->when($termo !== '', fn ($q) => $q->where('nome', 'like', '%'.$termo.'%'))
            ->orderBy('nome')
            ->limit(20)
            ->get(['id', 'nome', 'titulacao', 'cargo']);

        return response()->json($autoridades);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>Controller.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/Controller.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

abstract class Controller
{
    //
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>ConvidadoController.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/ConvidadoController.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Http\Requests\ConvidadoRequest;
use App\Models\Convidado;
use App\Models\Evento;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Str;

class ConvidadoController extends Controller
{
    public function store(ConvidadoRequest $request, Evento $evento): RedirectResponse
    {
        $dados = $request->validated();
        $dados['nome'] = Str::upper($dados['nome']);
        $dados['presente'] = false;

        $evento->convidados()->create($dados);

        return redirect()
            ->route('eventos.show', $evento)
            ->with('sucesso', 'Convidado adicionado.');
    }

    public function update(ConvidadoRequest $request, Convidado $convidado): RedirectResponse
    {
        $dados = $request->validated();
        $dados['nome'] = Str::upper($dados['nome']);

        $convidado->update($dados);

        return redirect()
            ->route('eventos.show', $convidado->evento_id)
            ->with('sucesso', 'Convidado atualizado.');
    }

    public function presenca(Convidado $convidado): RedirectResponse
    {
        $convidado->update(['presente' => ! $convidado->presente]);

        return back()->with('sucesso', 'Presença atualizada.');
    }

    public function destroy(Convidado $convidado): RedirectResponse
    {
        $eventoId = $convidado->evento_id;
        $convidado->delete();

        return redirect()
            ->route('eventos.show', $eventoId)
            ->with('sucesso', 'Convidado excluído.');
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>DevSessionController.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/DevSessionController.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;

/**
 * Troca o usuário/grupos simulado em runtime durante o desenvolvimento.
 * Substitui o Authelia local — sem container, sem TOTP. Bloqueado em
 * produção pelo middleware EnsureNotProduction (ver routes/web.php).
 */
class DevSessionController extends Controller
{
    public function form(Request $request): View
    {
        return view('dev.sessao', [
            'atual' => (array) $request->session()->get('dev_session', []),
            'defaults' => [
                'username' => config('authelia.dev_user'),
                'groups' => config('authelia.dev_groups'),
                'nome' => config('authelia.dev_name'),
                'email' => config('authelia.dev_email'),
            ],
        ]);
    }

    public function set(Request $request): RedirectResponse
    {
        $dados = $request->validate([
            'username' => ['required', 'string', 'max:100'],
            'groups' => ['required', 'string', 'max:200'],
            'nome' => ['required', 'string', 'max:200'],
            'email' => ['required', 'email', 'max:200'],
        ]);

        $request->session()->put('dev_session', $dados);

        return redirect('/')->with('sucesso', "Sessão simulada: {$dados['username']} ({$dados['groups']}).");
    }

    public function reset(Request $request): RedirectResponse
    {
        $request->session()->forget('dev_session');

        return redirect('/')->with('sucesso', 'Sessão simulada resetada para o default do .env.');
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>EventoController.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/EventoController.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Http\Requests\EventoRequest;
use App\Models\Evento;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class EventoController extends Controller
{
    public function index(): View
    {
        $eventos = Evento::query()
            ->withCount(['convidados', 'convidadosPresentes as presentes_count'])
            ->orderByDesc('data')
            ->get();

        return view('eventos.index', ['eventos' => $eventos]);
    }

    public function create(): View
    {
        return view('eventos.create');
    }

    public function store(EventoRequest $request): RedirectResponse
    {
        $evento = Evento::create($request->validated());

        return redirect()
            ->route('eventos.show', $evento)
            ->with('sucesso', "Evento \"{$evento->nome}\" criado.");
    }

    public function show(Evento $evento): View
    {
        $evento->load(['convidados' => fn ($q) => $q->orderBy('nome')]);

        return view('eventos.show', ['evento' => $evento]);
    }

    public function edit(Evento $evento): View
    {
        return view('eventos.edit', ['evento' => $evento]);
    }

    public function update(EventoRequest $request, Evento $evento): RedirectResponse
    {
        $evento->update($request->validated());

        return redirect()
            ->route('eventos.show', $evento)
            ->with('sucesso', 'Evento atualizado.');
    }

    public function destroy(Evento $evento): RedirectResponse
    {
        $nome = $evento->nome;
        $evento->delete();

        return redirect()
            ->route('eventos.index')
            ->with('sucesso', "Evento \"{$nome}\" excluído.");
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Controllers</subpasta>
  <nome_arquivo>NominataController.php</nome_arquivo>
  <caminho_completo>app/Http/Controllers/NominataController.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Evento;
use App\Services\AssentosService;
use App\Services\NominataService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\View\View;
use Symfony\Component\HttpFoundation\StreamedResponse;

class NominataController extends Controller
{
    public function __construct(
        private readonly NominataService $nominata,
        private readonly AssentosService $assentos,
    ) {}

    public function pdf(Evento $evento): Response|RedirectResponse
    {
        $evento->load('convidados');
        $grupos = $this->nominata->agrupar($evento->convidados);

        if ($grupos === []) {
            return back()->with('erro', 'Não há convidados com presença confirmada para exportar.');
        }

        $pdf = Pdf::loadView('pdf.nominata', [
            'evento' => $evento,
            'grupos' => $grupos,
        ]);

        return $pdf->download('nominata_'.Str::slug($evento->nome).'.pdf');
    }

    public function excel(Evento $evento): StreamedResponse
    {
        $evento->load(['convidados' => fn ($q) => $q->orderBy('nome')]);

        return response()->streamDownload(function () use ($evento) {
            $out = fopen('php://output', 'w');
            fwrite($out, "\xEF\xBB\xBF"); // BOM pra Excel reconhecer UTF-8
            fputcsv($out, ['Nome', 'Titulação', 'Cargo', 'Presença'], ';');
            foreach ($evento->convidados as $c) {
                fputcsv($out, [
                    $c->nome,
                    $c->titulacao ?? '',
                    $c->cargo,
                    $c->presente ? 'Presente' : 'Ausente',
                ], ';');
            }
            fclose($out);
        }, 'convidados_'.Str::slug($evento->nome).'.csv', ['Content-Type' => 'text/csv; charset=UTF-8']);
    }

    public function assentos(Evento $evento): View
    {
        $evento->load('convidados');

        return view('assentos.index', [
            'evento' => $evento,
            'mapa' => $this->assentos->mapa($evento),
            'totalPresentes' => $evento->convidados->where('presente', true)->count(),
        ]);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Middleware</subpasta>
  <nome_arquivo>AuthorizeRouteAccess.php</nome_arquivo>
  <caminho_completo>app/Http/Middleware/AuthorizeRouteAccess.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Services\AcessoRotaPermissaoService;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;

/**
 * Aplica a ACL dinâmica do banco a cada requisição.
 *
 *  1. Lê o nome da rota atual (route()->getName()).
 *  2. Se está em config('acesso.bypass_routes') (suporta wildcard via
 *     Str::is), libera.
 *  3. Senão, consulta o AcessoRotaPermissaoService usando os grupos do
 *     usuário em session('matchingGroups') (populados pelo
 *     ConfigureUserSession).
 *  4. 403 se não autorizado, ou rota sem nome.
 */
class AuthorizeRouteAccess
{
    public function __construct(private readonly AcessoRotaPermissaoService $service) {}

    public function handle(Request $request, Closure $next): Response
    {
        $rotaNome = $request->route()?->getName();

        if ($rotaNome === null || $rotaNome === '') {
            abort(403, 'Acesso não autorizado: rota sem nome.');
        }

        foreach ((array) config('acesso.bypass_routes', []) as $padrao) {
            if (Str::is($padrao, $rotaNome)) {
                return $next($request);
            }
        }

        /** @var list<string> $grupos */
        $grupos = (array) $request->session()->get('matchingGroups', []);

        if (! $this->service->podeAcessarRota($rotaNome, $grupos)) {
            abort(403, 'Acesso não autorizado para esta rota.');
        }

        return $next($request);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Middleware</subpasta>
  <nome_arquivo>ConfigureUserSession.php</nome_arquivo>
  <caminho_completo>app/Http/Middleware/ConfigureUserSession.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Models\AcessoRota;
use App\Models\GrupoAcesso;
use App\Models\Usuario;
use Closure;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

/**
 * Identifica o usuário (via Authelia ou bypass de dev), valida os grupos
 * contra o banco e hidrata a sessão com o escopo de acesso. Roda em toda
 * requisição autenticada.
 *
 * A checagem por rota vive no AuthorizeRouteAccess; aqui só hidratamos o
 * estado (matchingGroups / is_admin / is_organizador / rotas_permitidas).
 */
class ConfigureUserSession
{
    public function handle(Request $request, Closure $next): Response
    {
        [$username, $grupos, $nome, $email] = $this->resolverIdentidade($request);

        if ($username === null) {
            abort(401);
        }

        $gruposUpper = array_values(array_unique(array_map(
            fn (string $g) => strtoupper(trim($g)),
            $grupos,
        )));

        /** @var Collection<int, GrupoAcesso> $gruposBanco */
        $gruposBanco = GrupoAcesso::ativos()
            ->whereIn('nome', $gruposUpper)
            ->get();

        if ($gruposBanco->isEmpty()) {
            abort(403);
        }

        $matchingGroups = $gruposBanco->pluck('nome')->all();
        $gruposIds = $gruposBanco->pluck('id')->all();

        $isAdmin = $this->temAcessoCuringa($gruposIds);
        $categorias = $gruposBanco->pluck('categoria')->unique()->all();
        $isOrganizador = in_array(GrupoAcesso::CATEGORIA_ORGANIZADOR, $categorias, true);

        $rotasPermitidas = $isAdmin
            ? [AcessoRota::CURINGA]
            : $this->rotasDosGrupos($gruposIds);

        session([
            'user' => [
                'username' => $username,
                'groups' => $grupos,
            ],
            'matchingGroups' => $matchingGroups,
            'is_admin' => $isAdmin,
            'is_organizador' => $isOrganizador,
            'rotas_permitidas' => $rotasPermitidas,
        ]);

        $usuario = Usuario::firstOrNew(['username' => $username]);
        $usuario->fill([
            'nome' => $nome,
            'email' => $email,
        ]);
        $usuario->save();

        Auth::setUser($usuario);

        return $next($request);
    }

    /**
     * @param  list<int>  $gruposIds
     */
    private function temAcessoCuringa(array $gruposIds): bool
    {
        return DB::table('acesso_rota_grupo as arg')
            ->join('acesso_rotas as ar', 'ar.id', '=', 'arg.acesso_rota_id')
            ->where('arg.ativo', true)
            ->where('ar.ativo', true)
            ->whereIn('arg.grupo_acesso_id', $gruposIds)
            ->where('ar.rota_nome', AcessoRota::CURINGA)
            ->exists();
    }

    /**
     * @param  list<int>  $gruposIds
     * @return list<string>
     */
    private function rotasDosGrupos(array $gruposIds): array
    {
        return DB::table('acesso_rota_grupo as arg')
            ->join('acesso_rotas as ar', 'ar.id', '=', 'arg.acesso_rota_id')
            ->where('arg.ativo', true)
            ->where('ar.ativo', true)
            ->whereIn('arg.grupo_acesso_id', $gruposIds)
            ->pluck('ar.rota_nome')
            ->unique()
            ->values()
            ->all();
    }

    /**
     * @return array{0: ?string, 1: array<int, string>, 2: string, 3: string}
     */
    private function resolverIdentidade(Request $request): array
    {
        $username = $request->header('Remote-User');

        if ($username !== null) {
            return [
                $username,
                $this->extrairGrupos($request->header('Remote-Groups', '')),
                $request->header('Remote-Name', $username),
                $request->header('Remote-Email', $username.'@local'),
            ];
        }

        if ($this->bypassPermitido()) {
            return $this->identidadeSimulada($request);
        }

        return [null, [], '', ''];
    }

    /**
     * Em dev, prefere o override de sessão (gerenciado em /_dev/sessao)
     * sobre os defaults do .env. Permite trocar de usuário simulado em
     * runtime sem reiniciar o container.
     *
     * @return array{0: string, 1: array<int, string>, 2: string, 3: string}
     */
    private function identidadeSimulada(Request $request): array
    {
        $sessao = $request->hasSession()
            ? (array) $request->session()->get('dev_session', [])
            : [];

        $username = $sessao['username'] ?? config('authelia.dev_user');
        $grupos = $sessao['groups'] ?? config('authelia.dev_groups', '');
        $nome = $sessao['nome'] ?? config('authelia.dev_name', $username);
        $email = $sessao['email'] ?? config('authelia.dev_email', $username.'@local');

        return [
            (string) $username,
            $this->extrairGrupos((string) $grupos),
            (string) $nome,
            (string) $email,
        ];
    }

    private function bypassPermitido(): bool
    {
        return (bool) config('authelia.dev_bypass')
            && app()->environment() !== 'production';
    }

    /**
     * @return array<int, string>
     */
    private function extrairGrupos(string $header): array
    {
        return array_values(array_filter(array_map('trim', explode(',', $header))));
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Middleware</subpasta>
  <nome_arquivo>EnsureNotProduction.php</nome_arquivo>
  <caminho_completo>app/Http/Middleware/EnsureNotProduction.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Bloqueia rotas que só fazem sentido em desenvolvimento (ex: /_dev/sessao).
 * Em produção retorna 404 — não é só pra esconder; é pra evitar acidentes
 * de roteamento se essas rotas vazarem em alguma branch.
 */
class EnsureNotProduction
{
    public function handle(Request $request, Closure $next): Response
    {
        if (app()->environment('production')) {
            abort(404);
        }

        return $next($request);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Requests</subpasta>
  <nome_arquivo>ConvidadoRequest.php</nome_arquivo>
  <caminho_completo>app/Http/Requests/ConvidadoRequest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Requests;

use App\Models\Convidado;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ConvidadoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'nome' => ['required', 'string', 'min:2', 'max:200'],
            'titulacao' => ['nullable', 'string', 'max:200'],
            'cargo' => ['required', Rule::in(Convidado::CARGOS)],
            'cor' => ['required', Rule::in(Convidado::CORES)],
        ];
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Requests</subpasta>
  <nome_arquivo>EventoRequest.php</nome_arquivo>
  <caminho_completo>app/Http/Requests/EventoRequest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EventoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'nome' => ['required', 'string', 'min:3', 'max:200'],
            'data' => ['required', 'date'],
            'local' => ['required', 'string', 'min:3', 'max:200'],
            'cap_red' => ['nullable', 'integer', 'min:0', 'max:9999'],
            'cap_blue' => ['nullable', 'integer', 'min:0', 'max:9999'],
            'cap_green' => ['nullable', 'integer', 'min:0', 'max:9999'],
            'cap_yellow' => ['nullable', 'integer', 'min:0', 'max:9999'],
        ];
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Http/Requests</subpasta>
  <nome_arquivo>SentarAssentoRequest.php</nome_arquivo>
  <caminho_completo>app/Http/Requests/SentarAssentoRequest.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Http\Requests;

use App\Models\Convidado;
use App\Models\Evento;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SentarAssentoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'cor' => ['required', Rule::in(array_keys(Evento::CAPACIDADE_LABELS))],
            'numero' => ['required', 'integer', 'min:1'],
            'autoridade_id' => ['nullable', 'integer', 'exists:autoridades,id'],
            // Dados de uma nova autoridade — exigidos só quando não há id.
            'nome' => ['required_without:autoridade_id', 'nullable', 'string', 'min:3', 'max:200'],
            'titulacao' => ['nullable', 'string', 'max:200'],
            'cargo' => ['required_without:autoridade_id', 'nullable', Rule::in(Convidado::CARGOS)],
        ];
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Models</subpasta>
  <nome_arquivo>AcessoRota.php</nome_arquivo>
  <caminho_completo>app/Models/AcessoRota.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class AcessoRota extends Model
{
    public const CURINGA = '*';

    protected $table = 'acesso_rotas';

    protected $fillable = [
        'rota_nome',
        'rota_path',
        'menu_path',
        'descricao',
        'ativo',
    ];

    protected function casts(): array
    {
        return [
            'ativo' => 'boolean',
        ];
    }

    public function scopeAtivos(Builder $query): Builder
    {
        return $query->where('ativo', true);
    }

    /** @return BelongsToMany<GrupoAcesso, $this> */
    public function grupos(): BelongsToMany
    {
        return $this->belongsToMany(
            GrupoAcesso::class,
            'acesso_rota_grupo',
            'acesso_rota_id',
            'grupo_acesso_id',
        )
            ->withPivot('ativo')
            ->withTimestamps();
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Models</subpasta>
  <nome_arquivo>Autoridade.php</nome_arquivo>
  <caminho_completo>app/Models/Autoridade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * Cadastro global de autoridades, reutilizável entre eventos.
 */
class Autoridade extends Model
{
    protected $table = 'autoridades';

    protected $fillable = [
        'nome',
        'titulacao',
        'cargo',
    ];

    /** @return HasMany<Convidado, $this> */
    public function convidados(): HasMany
    {
        return $this->hasMany(Convidado::class);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Models</subpasta>
  <nome_arquivo>Convidado.php</nome_arquivo>
  <caminho_completo>app/Models/Convidado.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Convidado extends Model
{
    /**
     * Cargos na ordem protocolar usada na Nominata.
     *
     * @var list<string>
     */
    public const CARGOS = [
        'Mesa de Honra',
        'Desembargadores',
        'Juízes',
        'Autoridades',
        'Promotores Eleitorais',
        'Convidados',
        'Outros',
    ];

    /**
     * Cores possíveis do cartão de identificação.
     *
     * @var list<string>
     */
    public const CORES = ['black', 'red', 'blue', 'green', 'yellow'];

    protected $table = 'convidados';

    protected $fillable = [
        'evento_id',
        'autoridade_id',
        'nome',
        'titulacao',
        'cargo',
        'cor',
        'presente',
        'assento_numero',
    ];

    protected function casts(): array
    {
        return [
            'presente' => 'boolean',
            'assento_numero' => 'integer',
        ];
    }

    /** Está sentado numa poltrona específica? */
    public function estaSentado(): bool
    {
        return $this->assento_numero !== null;
    }

    /** @return BelongsTo<Evento, $this> */
    public function evento(): BelongsTo
    {
        return $this->belongsTo(Evento::class);
    }

    /** @return BelongsTo<Autoridade, $this> */
    public function autoridade(): BelongsTo
    {
        return $this->belongsTo(Autoridade::class);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Models</subpasta>
  <nome_arquivo>Evento.php</nome_arquivo>
  <caminho_completo>app/Models/Evento.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Evento extends Model
{
    /**
     * Categorias de assento (cor → rótulo) cuja capacidade é configurável
     * por evento. A ordem define a exibição no mapa de assentos.
     *
     * @var array<string, string>
     */
    public const CAPACIDADE_LABELS = [
        'red' => 'Mesa / Desembargadores',
        'blue' => 'Juízes',
        'green' => 'Autoridades / Promotores',
        'yellow' => 'Convidados',
    ];

    protected $table = 'eventos';

    protected $fillable = [
        'nome',
        'data',
        'local',
        'cap_red',
        'cap_blue',
        'cap_green',
        'cap_yellow',
    ];

    protected function casts(): array
    {
        return [
            'data' => 'date',
            'cap_red' => 'integer',
            'cap_blue' => 'integer',
            'cap_green' => 'integer',
            'cap_yellow' => 'integer',
        ];
    }

    /**
     * Capacidade de assentos por cor, conforme configurada no evento.
     *
     * @return array<string, int>
     */
    public function capacidadesAssento(): array
    {
        $caps = [];
        foreach (array_keys(self::CAPACIDADE_LABELS) as $cor) {
            $caps[$cor] = (int) ($this->{'cap_'.$cor} ?? 0);
        }

        return $caps;
    }

    /** @return HasMany<Convidado, $this> */
    public function convidados(): HasMany
    {
        return $this->hasMany(Convidado::class);
    }

    /** @return HasMany<Convidado, $this> */
    public function convidadosPresentes(): HasMany
    {
        return $this->convidados()->where('presente', true);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Models</subpasta>
  <nome_arquivo>GrupoAcesso.php</nome_arquivo>
  <caminho_completo>app/Models/GrupoAcesso.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class GrupoAcesso extends Model
{
    public const CATEGORIA_ADMIN = 'admin';

    public const CATEGORIA_ORGANIZADOR = 'organizador';

    protected $table = 'grupos_acesso';

    protected $fillable = [
        'nome',
        'descricao',
        'categoria',
        'ativo',
        'ignora_setores_permitidos',
    ];

    protected function casts(): array
    {
        return [
            'ativo' => 'boolean',
            'ignora_setores_permitidos' => 'boolean',
        ];
    }

    /**
     * Nome do grupo é case-insensitive: armazenamos sempre em UPPER pra
     * comparar literal contra o header Remote-Groups (que o middleware
     * também normaliza). Evita UPPER() na query crítica de permissão.
     */
    protected function nome(): Attribute
    {
        return Attribute::make(
            set: fn (string $value) => strtoupper(trim($value)),
        );
    }

    public function scopeAtivos(Builder $query): Builder
    {
        return $query->where('ativo', true);
    }

    /** @return BelongsToMany<AcessoRota, $this> */
    public function rotas(): BelongsToMany
    {
        return $this->belongsToMany(
            AcessoRota::class,
            'acesso_rota_grupo',
            'grupo_acesso_id',
            'acesso_rota_id',
        )
            ->withPivot('ativo')
            ->withTimestamps();
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Models</subpasta>
  <nome_arquivo>Usuario.php</nome_arquivo>
  <caminho_completo>app/Models/Usuario.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Model;

/**
 * Usuário identificado pelo Authelia (header Remote-User). Não há cadastro
 * nem senha: o middleware ConfigureUserSession faz firstOrNew por username
 * a cada requisição e hidrata nome/email vindos dos headers.
 */
class Usuario extends Model implements Authenticatable
{
    protected $table = 'usuarios';

    protected $fillable = [
        'username',
        'nome',
        'email',
    ];

    public function getAuthIdentifierName(): string
    {
        return 'username';
    }

    public function getAuthIdentifier(): mixed
    {
        return $this->username;
    }

    public function getAuthPasswordName(): string
    {
        return 'password';
    }

    public function getAuthPassword(): string
    {
        return '';
    }

    public function getRememberToken(): string
    {
        return '';
    }

    public function setRememberToken($value): void {}

    public function getRememberTokenName(): string
    {
        return '';
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Providers</subpasta>
  <nome_arquivo>AppServiceProvider.php</nome_arquivo>
  <caminho_completo>app/Providers/AppServiceProvider.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        //
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Services</subpasta>
  <nome_arquivo>AcessoRotaPermissaoService.php</nome_arquivo>
  <caminho_completo>app/Services/AcessoRotaPermissaoService.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\AcessoRota;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;

/**
 * Decisor de "este usuário pode acessar esta rota?".
 *
 * Roda em toda requisição via AuthorizeRouteAccess. Mantida em query
 * builder direto pra evitar overhead de Eloquent no hot path.
 *
 * Pressupõe que os nomes de grupo em `$grupos` já estão normalizados em
 * UPPER (responsabilidade do middleware ConfigureUserSession).
 */
class AcessoRotaPermissaoService
{
    /**
     * Verifica se algum grupo do usuário tem vínculo com a rota (ou curinga).
     * Usa EXISTS — encerra na primeira linha encontrada.
     *
     * @param  list<string>  $grupos
     */
    public function podeAcessarRota(string $rotaNome, array $grupos): bool
    {
        if ($grupos === []) {
            return false;
        }

        return $this->baseQuery($rotaNome, $grupos)->exists();
    }

    /**
     * Filtros comuns. Os nomes de grupo já vêm em UPPER do middleware.
     *
     * @param  list<string>  $grupos
     */
    private function baseQuery(string $rotaNome, array $grupos): Builder
    {
        return DB::table('acesso_rota_grupo as arg')
            ->join('grupos_acesso as ga', 'ga.id', '=', 'arg.grupo_acesso_id')
            ->join('acesso_rotas as ar', 'ar.id', '=', 'arg.acesso_rota_id')
            ->where('arg.ativo', true)
            ->where('ga.ativo', true)
            ->where('ar.ativo', true)
            ->whereIn('ga.nome', $grupos)
            ->where(function ($q) use ($rotaNome) {
                $q->where('ar.rota_nome', $rotaNome)
                    ->orWhere('ar.rota_nome', AcessoRota::CURINGA);
            });
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Services</subpasta>
  <nome_arquivo>AssentosService.php</nome_arquivo>
  <caminho_completo>app/Services/AssentosService.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Autoridade;
use App\Models\Convidado;
use App\Models\Evento;
use Illuminate\Support\Collection;
use Illuminate\Support\Str;
use RuntimeException;

/**
 * Mapa de assentos: cada convidado pode ocupar uma poltrona específica
 * (cor = seção, `assento_numero` = posição). Este serviço monta o mapa,
 * senta e libera ocupantes, validando capacidade e dupla ocupação.
 */
class AssentosService
{
    /**
     * Contagem de presentes por cor (independe de poltrona). Mantido para
     * usos que precisam só do total de presentes por categoria.
     *
     * @param  Collection<int, Convidado>  $convidados
     * @return array<string, int>
     */
    public function ocupacaoPorCor(Collection $convidados): array
    {
        $ocupacao = array_fill_keys(Convidado::CORES, 0);

        foreach ($convidados as $convidado) {
            if (! $convidado->presente) {
                continue;
            }
            $cor = $convidado->cor;
            if (array_key_exists($cor, $ocupacao)) {
                $ocupacao[$cor]++;
            }
        }

        return $ocupacao;
    }

    /**
     * Mapa posicional: para cada categoria (cor), a capacidade e o ocupante
     * de cada poltrona (1..capacidade). Inclui totais e taxa de ocupação.
     *
     * @return array{
     *     categorias: array<string, array{
     *         label: string, capacidade: int, ocupados: int, pct: int,
     *         assentos: array<int, Convidado|null>
     *     }>,
     *     capacidade_total: int,
     *     ocupados: int,
     *     livres: int,
     *     taxa: int
     * }
     */
    public function mapa(Evento $evento): array
    {
        // Convidados sentados, indexados por cor → número.
        $sentados = [];
        foreach ($evento->convidados as $convidado) {
            if ($convidado->assento_numero === null) {
                continue;
            }
            $sentados[$convidado->cor][$convidado->assento_numero] = $convidado;
        }

        $categorias = [];
        $capacidadeTotal = 0;
        $ocupadosTotal = 0;

        foreach ($evento->capacidadesAssento() as $cor => $capacidade) {
            $assentos = [];
            $ocupados = 0;
            for ($numero = 1; $numero <= $capacidade; $numero++) {
                $ocupante = $sentados[$cor][$numero] ?? null;
                $assentos[$numero] = $ocupante;
                if ($ocupante !== null) {
                    $ocupados++;
                }
            }

            $capacidadeTotal += $capacidade;
            $ocupadosTotal += $ocupados;

            $categorias[$cor] = [
                'label' => Evento::CAPACIDADE_LABELS[$cor] ?? $cor,
                'capacidade' => $capacidade,
                'ocupados' => $ocupados,
                'pct' => $capacidade > 0 ? (int) round($ocupados / $capacidade * 100) : 0,
                'assentos' => $assentos,
            ];
        }

        return [
            'categorias' => $categorias,
            'capacidade_total' => $capacidadeTotal,
            'ocupados' => $ocupadosTotal,
            'livres' => $capacidadeTotal - $ocupadosTotal,
            'taxa' => $capacidadeTotal > 0 ? (int) round($ocupadosTotal / $capacidadeTotal * 100) : 0,
        ];
    }

    /**
     * Senta uma autoridade numa poltrona específica do evento, criando o
     * convidado correspondente (presente). Valida a cor, a capacidade e a
     * dupla ocupação.
     *
     * @throws RuntimeException quando a cor/poltrona é inválida ou ocupada
     */
    public function sentar(Evento $evento, Autoridade $autoridade, string $cor, int $numero): Convidado
    {
        $capacidades = $evento->capacidadesAssento();

        if (! array_key_exists($cor, $capacidades)) {
            throw new RuntimeException("Categoria de assento inválida: {$cor}.");
        }
        if ($numero < 1 || $numero > $capacidades[$cor]) {
            throw new RuntimeException('Poltrona fora da capacidade desta categoria.');
        }
        if ($this->poltronaOcupada($evento, $cor, $numero)) {
            throw new RuntimeException('Esta poltrona já está ocupada.');
        }

        return $evento->convidados()->create([
            'autoridade_id' => $autoridade->id,
            'nome' => Str::upper($autoridade->nome),
            'titulacao' => $autoridade->titulacao,
            'cargo' => $autoridade->cargo,
            'cor' => $cor,
            'assento_numero' => $numero,
            'presente' => true,
        ]);
    }

    /** Libera a poltrona, removendo o convidado que a ocupa. */
    public function liberar(Convidado $convidado): void
    {
        $convidado->delete();
    }

    private function poltronaOcupada(Evento $evento, string $cor, int $numero): bool
    {
        return $evento->convidados()
            ->where('cor', $cor)
            ->where('assento_numero', $numero)
            ->exists();
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>app</pasta>
  <subpasta>app/Services</subpasta>
  <nome_arquivo>NominataService.php</nome_arquivo>
  <caminho_completo>app/Services/NominataService.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Convidado;
use Illuminate\Support\Collection;

/**
 * Monta a Nominata: agrupa os convidados PRESENTES por cargo, na ordem
 * protocolar (Convidado::CARGOS), com os nomes ordenados alfabeticamente
 * dentro de cada cargo. Cargos sem nenhum presente são omitidos.
 */
class NominataService
{
    /**
     * @param  Collection<int, Convidado>  $convidados
     * @return array<string, list<Convidado>>
     */
    public function agrupar(Collection $convidados): array
    {
        $presentes = $convidados
            ->filter(fn (Convidado $c) => (bool) $c->presente)
            ->groupBy(fn (Convidado $c) => $c->cargo);

        $resultado = [];

        foreach (Convidado::CARGOS as $cargo) {
            $doCargo = $presentes->get($cargo);

            if ($doCargo === null || $doCargo->isEmpty()) {
                continue;
            }

            $resultado[$cargo] = $doCargo
                ->sortBy(fn (Convidado $c) => $c->nome, SORT_NATURAL | SORT_FLAG_CASE)
                ->values()
                ->all();
        }

        return $resultado;
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>bootstrap</pasta>
  <subpasta>bootstrap</subpasta>
  <nome_arquivo>app.php</nome_arquivo>
  <caminho_completo>bootstrap/app.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use App\Console\Commands\AclSyncCommand;
use App\Http\Middleware\AuthorizeRouteAccess;
use App\Http\Middleware\ConfigureUserSession;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withCommands([
        AclSyncCommand::class,
    ])
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->alias([
            'configure.session' => ConfigureUserSession::class,
            'authorize.route' => AuthorizeRouteAccess::class,
        ]);

        $middleware->trustProxies(at: env('TRUSTED_PROXIES', '127.0.0.1'));
    })
    ->withExceptions(function (Exceptions $exceptions) {
        $exceptions->render(function (DomainException $e, $request) {
            if ($request->expectsJson()) {
                return response()->json(['message' => $e->getMessage()], 422);
            }

            if ($request->isMethod('post')) {
                return back()->with('erro', $e->getMessage());
            }

            return null;
        });
    })->create();

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>bootstrap</pasta>
  <subpasta>bootstrap</subpasta>
  <nome_arquivo>providers.php</nome_arquivo>
  <caminho_completo>bootstrap/providers.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use App\Providers\AppServiceProvider;

return [
    AppServiceProvider::class,
];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>acesso.php</nome_arquivo>
  <caminho_completo>config/acesso.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

return [
    /*
    |--------------------------------------------------------------------------
    | Rotas em bypass da ACL dinâmica
    |--------------------------------------------------------------------------
    |
    | Padrões aceitos: nome exato (`home`) ou wildcard via Str::is
    | (`dev.sessao.*`). Rotas listadas aqui pulam o
    | AcessoRotaPermissaoService e ficam sempre acessíveis a qualquer
    | usuário autenticado.
    |
    */
    'bypass_routes' => [
        'dev.sessao.*',
    ],
];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>app.php</nome_arquivo>
  <caminho_completo>config/app.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Application Name
    |--------------------------------------------------------------------------
    |
    | This value is the name of your application, which will be used when the
    | framework needs to place the application's name in a notification or
    | other UI elements where an application name needs to be displayed.
    |
    */

    'name' => env('APP_NAME', 'Laravel'),

    /*
    |--------------------------------------------------------------------------
    | Application Environment
    |--------------------------------------------------------------------------
    |
    | This value determines the "environment" your application is currently
    | running in. This may determine how you prefer to configure various
    | services the application utilizes. Set this in your ".env" file.
    |
    */

    'env' => env('APP_ENV', 'production'),

    /*
    |--------------------------------------------------------------------------
    | Application Debug Mode
    |--------------------------------------------------------------------------
    |
    | When your application is in debug mode, detailed error messages with
    | stack traces will be shown on every error that occurs within your
    | application. If disabled, a simple generic error page is shown.
    |
    */

    'debug' => (bool) env('APP_DEBUG', false),

    /*
    |--------------------------------------------------------------------------
    | Application URL
    |--------------------------------------------------------------------------
    |
    | This URL is used by the console to properly generate URLs when using
    | the Artisan command line tool. You should set this to the root of
    | the application so that it's available within Artisan commands.
    |
    */

    'url' => env('APP_URL', 'http://localhost'),

    /*
    |--------------------------------------------------------------------------
    | Application Timezone
    |--------------------------------------------------------------------------
    |
    | Here you may specify the default timezone for your application, which
    | will be used by the PHP date and date-time functions. The timezone
    | is set to "UTC" by default as it is suitable for most use cases.
    |
    */

    'timezone' => env('APP_TIMEZONE', 'UTC'),

    /*
    |--------------------------------------------------------------------------
    | Application Locale Configuration
    |--------------------------------------------------------------------------
    |
    | The application locale determines the default locale that will be used
    | by Laravel's translation / localization methods. This option can be
    | set to any locale for which you plan to have translation strings.
    |
    */

    'locale' => env('APP_LOCALE', 'en'),

    'fallback_locale' => env('APP_FALLBACK_LOCALE', 'en'),

    'faker_locale' => env('APP_FAKER_LOCALE', 'en_US'),

    /*
    |--------------------------------------------------------------------------
    | Encryption Key
    |--------------------------------------------------------------------------
    |
    | This key is utilized by Laravel's encryption services and should be set
    | to a random, 32 character string to ensure that all encrypted values
    | are secure. You should do this prior to deploying the application.
    |
    */

    'cipher' => 'AES-256-CBC',

    'key' => env('APP_KEY'),

    'previous_keys' => [
        ...array_filter(
            explode(',', env('APP_PREVIOUS_KEYS', ''))
        ),
    ],

    /*
    |--------------------------------------------------------------------------
    | Maintenance Mode Driver
    |--------------------------------------------------------------------------
    |
    | These configuration options determine the driver used to determine and
    | manage Laravel's "maintenance mode" status. The "cache" driver will
    | allow maintenance mode to be controlled across multiple machines.
    |
    | Supported drivers: "file", "cache"
    |
    */

    'maintenance' => [
        'driver' => env('APP_MAINTENANCE_DRIVER', 'file'),
        'store' => env('APP_MAINTENANCE_STORE', 'database'),
    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>authelia.php</nome_arquivo>
  <caminho_completo>config/authelia.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

return [
    /*
    |--------------------------------------------------------------------------
    | Bypass de desenvolvimento
    |--------------------------------------------------------------------------
    |
    | Quando true E APP_ENV != 'production', requisições sem headers Authelia
    | são autenticadas como o usuário simulado abaixo. Conveniência pra
    | iterar em features sem fluxo SSO; em produção é ignorado por design.
    */

    'dev_bypass' => env('AUTHELIA_DEV_BYPASS', false),

    'dev_user' => env('AUTHELIA_DEV_USER', 'lucas.dev'),
    'dev_groups' => env('AUTHELIA_DEV_GROUPS', 'estagiarios'),
    'dev_name' => env('AUTHELIA_DEV_NAME', 'Lucas Dev'),
    'dev_email' => env('AUTHELIA_DEV_EMAIL', 'lucas.dev@example.local'),
];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>auth.php</nome_arquivo>
  <caminho_completo>config/auth.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use App\Models\User;

return [

    /*
    |--------------------------------------------------------------------------
    | Authentication Defaults
    |--------------------------------------------------------------------------
    |
    | This option defines the default authentication "guard" and password
    | reset "broker" for your application. You may change these values
    | as required, but they're a perfect start for most applications.
    |
    */

    'defaults' => [
        'guard' => env('AUTH_GUARD', 'web'),
        'passwords' => env('AUTH_PASSWORD_BROKER', 'users'),
    ],

    /*
    |--------------------------------------------------------------------------
    | Authentication Guards
    |--------------------------------------------------------------------------
    |
    | Next, you may define every authentication guard for your application.
    | Of course, a great default configuration has been defined for you
    | which utilizes session storage plus the Eloquent user provider.
    |
    | All authentication guards have a user provider, which defines how the
    | users are actually retrieved out of your database or other storage
    | system used by the application. Typically, Eloquent is utilized.
    |
    | Supported: "session"
    |
    */

    'guards' => [
        'web' => [
            'driver' => 'session',
            'provider' => 'users',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | User Providers
    |--------------------------------------------------------------------------
    |
    | All authentication guards have a user provider, which defines how the
    | users are actually retrieved out of your database or other storage
    | system used by the application. Typically, Eloquent is utilized.
    |
    | If you have multiple user tables or models you may configure multiple
    | providers to represent the model / table. These providers may then
    | be assigned to any extra authentication guards you have defined.
    |
    | Supported: "database", "eloquent"
    |
    */

    'providers' => [
        'users' => [
            'driver' => 'eloquent',
            'model' => env('AUTH_MODEL', User::class),
        ],

        // 'users' => [
        //     'driver' => 'database',
        //     'table' => 'users',
        // ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Resetting Passwords
    |--------------------------------------------------------------------------
    |
    | These configuration options specify the behavior of Laravel's password
    | reset functionality, including the table utilized for token storage
    | and the user provider that is invoked to actually retrieve users.
    |
    | The expiry time is the number of minutes that each reset token will be
    | considered valid. This security feature keeps tokens short-lived so
    | they have less time to be guessed. You may change this as needed.
    |
    | The throttle setting is the number of seconds a user must wait before
    | generating more password reset tokens. This prevents the user from
    | quickly generating a very large amount of password reset tokens.
    |
    */

    'passwords' => [
        'users' => [
            'provider' => 'users',
            'table' => env('AUTH_PASSWORD_RESET_TOKEN_TABLE', 'password_reset_tokens'),
            'expire' => 60,
            'throttle' => 60,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Password Confirmation Timeout
    |--------------------------------------------------------------------------
    |
    | Here you may define the amount of seconds before a password confirmation
    | window expires and users are asked to re-enter their password via the
    | confirmation screen. By default, the timeout lasts for three hours.
    |
    */

    'password_timeout' => env('AUTH_PASSWORD_TIMEOUT', 10800),

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>cache.php</nome_arquivo>
  <caminho_completo>config/cache.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Support\Str;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Cache Store
    |--------------------------------------------------------------------------
    |
    | This option controls the default cache store that will be used by the
    | framework. This connection is utilized if another isn't explicitly
    | specified when running a cache operation inside the application.
    |
    */

    'default' => env('CACHE_STORE', 'database'),

    /*
    |--------------------------------------------------------------------------
    | Cache Stores
    |--------------------------------------------------------------------------
    |
    | Here you may define all of the cache "stores" for your application as
    | well as their drivers. You may even define multiple stores for the
    | same cache driver to group types of items stored in your caches.
    |
    | Supported drivers: "array", "database", "file", "memcached",
    |                    "redis", "dynamodb", "octane", "null"
    |
    */

    'stores' => [

        'array' => [
            'driver' => 'array',
            'serialize' => false,
        ],

        'database' => [
            'driver' => 'database',
            'connection' => env('DB_CACHE_CONNECTION'),
            'table' => env('DB_CACHE_TABLE', 'cache'),
            'lock_connection' => env('DB_CACHE_LOCK_CONNECTION'),
            'lock_table' => env('DB_CACHE_LOCK_TABLE'),
        ],

        'file' => [
            'driver' => 'file',
            'path' => storage_path('framework/cache/data'),
            'lock_path' => storage_path('framework/cache/data'),
        ],

        'memcached' => [
            'driver' => 'memcached',
            'persistent_id' => env('MEMCACHED_PERSISTENT_ID'),
            'sasl' => [
                env('MEMCACHED_USERNAME'),
                env('MEMCACHED_PASSWORD'),
            ],
            'options' => [
                // Memcached::OPT_CONNECT_TIMEOUT => 2000,
            ],
            'servers' => [
                [
                    'host' => env('MEMCACHED_HOST', '127.0.0.1'),
                    'port' => env('MEMCACHED_PORT', 11211),
                    'weight' => 100,
                ],
            ],
        ],

        'redis' => [
            'driver' => 'redis',
            'connection' => env('REDIS_CACHE_CONNECTION', 'cache'),
            'lock_connection' => env('REDIS_CACHE_LOCK_CONNECTION', 'default'),
        ],

        'dynamodb' => [
            'driver' => 'dynamodb',
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
            'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
            'table' => env('DYNAMODB_CACHE_TABLE', 'cache'),
            'endpoint' => env('DYNAMODB_ENDPOINT'),
        ],

        'octane' => [
            'driver' => 'octane',
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Cache Key Prefix
    |--------------------------------------------------------------------------
    |
    | When utilizing the APC, database, memcached, Redis, and DynamoDB cache
    | stores, there might be other applications using the same cache. For
    | that reason, you may prefix every cache key to avoid collisions.
    |
    */

    'prefix' => env('CACHE_PREFIX', Str::slug(env('APP_NAME', 'laravel'), '_').'_cache_'),

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>database.php</nome_arquivo>
  <caminho_completo>config/database.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Support\Str;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Database Connection Name
    |--------------------------------------------------------------------------
    |
    | Here you may specify which of the database connections below you wish
    | to use as your default connection for database operations. This is
    | the connection which will be utilized unless another connection
    | is explicitly specified when you execute a query / statement.
    |
    */

    'default' => env('DB_CONNECTION', 'sqlite'),

    /*
    |--------------------------------------------------------------------------
    | Database Connections
    |--------------------------------------------------------------------------
    |
    | Below are all of the database connections defined for your application.
    | An example configuration is provided for each database system which
    | is supported by Laravel. You're free to add / remove connections.
    |
    */

    'connections' => [

        'sqlite' => [
            'driver' => 'sqlite',
            'url' => env('DB_URL'),
            'database' => env('DB_DATABASE', database_path('database.sqlite')),
            'prefix' => '',
            'foreign_key_constraints' => env('DB_FOREIGN_KEYS', true),
            'busy_timeout' => null,
            'journal_mode' => null,
            'synchronous' => null,
        ],

        'mysql' => [
            'driver' => 'mysql',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '3306'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'unix_socket' => env('DB_SOCKET', ''),
            'charset' => env('DB_CHARSET', 'utf8mb4'),
            'collation' => env('DB_COLLATION', 'utf8mb4_unicode_ci'),
            'prefix' => '',
            'prefix_indexes' => true,
            'strict' => true,
            'engine' => null,
            'options' => extension_loaded('pdo_mysql') ? array_filter([
                PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
            ]) : [],
        ],

        'mariadb' => [
            'driver' => 'mariadb',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '3306'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'unix_socket' => env('DB_SOCKET', ''),
            'charset' => env('DB_CHARSET', 'utf8mb4'),
            'collation' => env('DB_COLLATION', 'utf8mb4_unicode_ci'),
            'prefix' => '',
            'prefix_indexes' => true,
            'strict' => true,
            'engine' => null,
            'options' => extension_loaded('pdo_mysql') ? array_filter([
                PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA'),
            ]) : [],
        ],

        'pgsql' => [
            'driver' => 'pgsql',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', '127.0.0.1'),
            'port' => env('DB_PORT', '5432'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'charset' => env('DB_CHARSET', 'utf8'),
            'prefix' => '',
            'prefix_indexes' => true,
            'search_path' => 'public',
            'sslmode' => 'prefer',
        ],

        'sqlsrv' => [
            'driver' => 'sqlsrv',
            'url' => env('DB_URL'),
            'host' => env('DB_HOST', 'localhost'),
            'port' => env('DB_PORT', '1433'),
            'database' => env('DB_DATABASE', 'laravel'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'charset' => env('DB_CHARSET', 'utf8'),
            'prefix' => '',
            'prefix_indexes' => true,
            // 'encrypt' => env('DB_ENCRYPT', 'yes'),
            // 'trust_server_certificate' => env('DB_TRUST_SERVER_CERTIFICATE', 'false'),
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Migration Repository Table
    |--------------------------------------------------------------------------
    |
    | This table keeps track of all the migrations that have already run for
    | your application. Using this information, we can determine which of
    | the migrations on disk haven't actually been run on the database.
    |
    */

    'migrations' => [
        'table' => 'migrations',
        'update_date_on_publish' => true,
    ],

    /*
    |--------------------------------------------------------------------------
    | Redis Databases
    |--------------------------------------------------------------------------
    |
    | Redis is an open source, fast, and advanced key-value store that also
    | provides a richer body of commands than a typical key-value system
    | such as Memcached. You may define your connection settings here.
    |
    */

    'redis' => [

        'client' => env('REDIS_CLIENT', 'phpredis'),

        'options' => [
            'cluster' => env('REDIS_CLUSTER', 'redis'),
            'prefix' => env('REDIS_PREFIX', Str::slug(env('APP_NAME', 'laravel'), '_').'_database_'),
        ],

        'default' => [
            'url' => env('REDIS_URL'),
            'host' => env('REDIS_HOST', '127.0.0.1'),
            'username' => env('REDIS_USERNAME'),
            'password' => env('REDIS_PASSWORD'),
            'port' => env('REDIS_PORT', '6379'),
            'database' => env('REDIS_DB', '0'),
        ],

        'cache' => [
            'url' => env('REDIS_URL'),
            'host' => env('REDIS_HOST', '127.0.0.1'),
            'username' => env('REDIS_USERNAME'),
            'password' => env('REDIS_PASSWORD'),
            'port' => env('REDIS_PORT', '6379'),
            'database' => env('REDIS_CACHE_DB', '1'),
        ],

    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>filesystems.php</nome_arquivo>
  <caminho_completo>config/filesystems.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Default Filesystem Disk
    |--------------------------------------------------------------------------
    |
    | Here you may specify the default filesystem disk that should be used
    | by the framework. The "local" disk, as well as a variety of cloud
    | based disks are available to your application for file storage.
    |
    */

    'default' => env('FILESYSTEM_DISK', 'local'),

    /*
    |--------------------------------------------------------------------------
    | Filesystem Disks
    |--------------------------------------------------------------------------
    |
    | Below you may configure as many filesystem disks as necessary, and you
    | may even configure multiple disks for the same driver. Examples for
    | most supported storage drivers are configured here for reference.
    |
    | Supported drivers: "local", "ftp", "sftp", "s3"
    |
    */

    'disks' => [

        'local' => [
            'driver' => 'local',
            'root' => storage_path('app/private'),
            'serve' => true,
            'throw' => false,
            'report' => false,
        ],

        'public' => [
            'driver' => 'local',
            'root' => storage_path('app/public'),
            'url' => env('APP_URL').'/storage',
            'visibility' => 'public',
            'throw' => false,
            'report' => false,
        ],

        's3' => [
            'driver' => 's3',
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
            'region' => env('AWS_DEFAULT_REGION'),
            'bucket' => env('AWS_BUCKET'),
            'url' => env('AWS_URL'),
            'endpoint' => env('AWS_ENDPOINT'),
            'use_path_style_endpoint' => env('AWS_USE_PATH_STYLE_ENDPOINT', false),
            'throw' => false,
            'report' => false,
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Symbolic Links
    |--------------------------------------------------------------------------
    |
    | Here you may configure the symbolic links that will be created when the
    | `storage:link` Artisan command is executed. The array keys should be
    | the locations of the links and the values should be their targets.
    |
    */

    'links' => [
        public_path('storage') => storage_path('app/public'),
    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>logging.php</nome_arquivo>
  <caminho_completo>config/logging.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Monolog\Handler\NullHandler;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\SyslogUdpHandler;
use Monolog\Processor\PsrLogMessageProcessor;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Log Channel
    |--------------------------------------------------------------------------
    |
    | This option defines the default log channel that is utilized to write
    | messages to your logs. The value provided here should match one of
    | the channels present in the list of "channels" configured below.
    |
    */

    'default' => env('LOG_CHANNEL', 'stack'),

    /*
    |--------------------------------------------------------------------------
    | Deprecations Log Channel
    |--------------------------------------------------------------------------
    |
    | This option controls the log channel that should be used to log warnings
    | regarding deprecated PHP and library features. This allows you to get
    | your application ready for upcoming major versions of dependencies.
    |
    */

    'deprecations' => [
        'channel' => env('LOG_DEPRECATIONS_CHANNEL', 'null'),
        'trace' => env('LOG_DEPRECATIONS_TRACE', false),
    ],

    /*
    |--------------------------------------------------------------------------
    | Log Channels
    |--------------------------------------------------------------------------
    |
    | Here you may configure the log channels for your application. Laravel
    | utilizes the Monolog PHP logging library, which includes a variety
    | of powerful log handlers and formatters that you're free to use.
    |
    | Available drivers: "single", "daily", "slack", "syslog",
    |                    "errorlog", "monolog", "custom", "stack"
    |
    */

    'channels' => [

        'stack' => [
            'driver' => 'stack',
            'channels' => explode(',', env('LOG_STACK', 'single')),
            'ignore_exceptions' => false,
        ],

        'single' => [
            'driver' => 'single',
            'path' => storage_path('logs/laravel.log'),
            'level' => env('LOG_LEVEL', 'debug'),
            'replace_placeholders' => true,
        ],

        'daily' => [
            'driver' => 'daily',
            'path' => storage_path('logs/laravel.log'),
            'level' => env('LOG_LEVEL', 'debug'),
            'days' => env('LOG_DAILY_DAYS', 14),
            'replace_placeholders' => true,
        ],

        'slack' => [
            'driver' => 'slack',
            'url' => env('LOG_SLACK_WEBHOOK_URL'),
            'username' => env('LOG_SLACK_USERNAME', 'Laravel Log'),
            'emoji' => env('LOG_SLACK_EMOJI', ':boom:'),
            'level' => env('LOG_LEVEL', 'critical'),
            'replace_placeholders' => true,
        ],

        'papertrail' => [
            'driver' => 'monolog',
            'level' => env('LOG_LEVEL', 'debug'),
            'handler' => env('LOG_PAPERTRAIL_HANDLER', SyslogUdpHandler::class),
            'handler_with' => [
                'host' => env('PAPERTRAIL_URL'),
                'port' => env('PAPERTRAIL_PORT'),
                'connectionString' => 'tls://'.env('PAPERTRAIL_URL').':'.env('PAPERTRAIL_PORT'),
            ],
            'processors' => [PsrLogMessageProcessor::class],
        ],

        'stderr' => [
            'driver' => 'monolog',
            'level' => env('LOG_LEVEL', 'debug'),
            'handler' => StreamHandler::class,
            'formatter' => env('LOG_STDERR_FORMATTER'),
            'with' => [
                'stream' => 'php://stderr',
            ],
            'processors' => [PsrLogMessageProcessor::class],
        ],

        'syslog' => [
            'driver' => 'syslog',
            'level' => env('LOG_LEVEL', 'debug'),
            'facility' => env('LOG_SYSLOG_FACILITY', LOG_USER),
            'replace_placeholders' => true,
        ],

        'errorlog' => [
            'driver' => 'errorlog',
            'level' => env('LOG_LEVEL', 'debug'),
            'replace_placeholders' => true,
        ],

        'null' => [
            'driver' => 'monolog',
            'handler' => NullHandler::class,
        ],

        'emergency' => [
            'path' => storage_path('logs/laravel.log'),
        ],

    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>mail.php</nome_arquivo>
  <caminho_completo>config/mail.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Default Mailer
    |--------------------------------------------------------------------------
    |
    | This option controls the default mailer that is used to send all email
    | messages unless another mailer is explicitly specified when sending
    | the message. All additional mailers can be configured within the
    | "mailers" array. Examples of each type of mailer are provided.
    |
    */

    'default' => env('MAIL_MAILER', 'log'),

    /*
    |--------------------------------------------------------------------------
    | Mailer Configurations
    |--------------------------------------------------------------------------
    |
    | Here you may configure all of the mailers used by your application plus
    | their respective settings. Several examples have been configured for
    | you and you are free to add your own as your application requires.
    |
    | Laravel supports a variety of mail "transport" drivers that can be used
    | when delivering an email. You may specify which one you're using for
    | your mailers below. You may also add additional mailers if needed.
    |
    | Supported: "smtp", "sendmail", "mailgun", "ses", "ses-v2",
    |            "postmark", "resend", "log", "array",
    |            "failover", "roundrobin"
    |
    */

    'mailers' => [

        'smtp' => [
            'transport' => 'smtp',
            'scheme' => env('MAIL_SCHEME'),
            'url' => env('MAIL_URL'),
            'host' => env('MAIL_HOST', '127.0.0.1'),
            'port' => env('MAIL_PORT', 2525),
            'username' => env('MAIL_USERNAME'),
            'password' => env('MAIL_PASSWORD'),
            'timeout' => null,
            'local_domain' => env('MAIL_EHLO_DOMAIN', parse_url(env('APP_URL', 'http://localhost'), PHP_URL_HOST)),
        ],

        'ses' => [
            'transport' => 'ses',
        ],

        'postmark' => [
            'transport' => 'postmark',
            // 'message_stream_id' => env('POSTMARK_MESSAGE_STREAM_ID'),
            // 'client' => [
            //     'timeout' => 5,
            // ],
        ],

        'resend' => [
            'transport' => 'resend',
        ],

        'sendmail' => [
            'transport' => 'sendmail',
            'path' => env('MAIL_SENDMAIL_PATH', '/usr/sbin/sendmail -bs -i'),
        ],

        'log' => [
            'transport' => 'log',
            'channel' => env('MAIL_LOG_CHANNEL'),
        ],

        'array' => [
            'transport' => 'array',
        ],

        'failover' => [
            'transport' => 'failover',
            'mailers' => [
                'smtp',
                'log',
            ],
        ],

        'roundrobin' => [
            'transport' => 'roundrobin',
            'mailers' => [
                'ses',
                'postmark',
            ],
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Global "From" Address
    |--------------------------------------------------------------------------
    |
    | You may wish for all emails sent by your application to be sent from
    | the same address. Here you may specify a name and address that is
    | used globally for all emails that are sent by your application.
    |
    */

    'from' => [
        'address' => env('MAIL_FROM_ADDRESS', 'hello@example.com'),
        'name' => env('MAIL_FROM_NAME', 'Example'),
    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>oracle.php</nome_arquivo>
  <caminho_completo>config/oracle.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

return [
    'oracle' => [
        'driver' => 'oracle',
        'tns' => env('DB_TNS', ''),
        'host' => env('DB_HOST', ''),
        'port' => env('DB_PORT', '1521'),
        'database' => env('DB_DATABASE', ''),
        'service_name' => env('DB_SERVICE_NAME', ''),
        'username' => env('DB_USERNAME', ''),
        'password' => env('DB_PASSWORD', ''),
        'charset' => env('DB_CHARSET', 'AL32UTF8'),
        'prefix' => env('DB_PREFIX', ''),
        'prefix_schema' => env('DB_SCHEMA_PREFIX', ''),
        'edition' => env('DB_EDITION', 'ora$base'),
        'server_version' => env('DB_SERVER_VERSION', '11g'),
        'load_balance' => env('DB_LOAD_BALANCE', 'yes'),
        'max_name_len' => env('ORA_MAX_NAME_LEN', 30),
        'dynamic' => [],
        'sessionVars' => [
            'NLS_TIME_FORMAT' => 'HH24:MI:SS',
            'NLS_DATE_FORMAT' => 'YYYY-MM-DD HH24:MI:SS',
            'NLS_TIMESTAMP_FORMAT' => 'YYYY-MM-DD HH24:MI:SS',
            'NLS_TIMESTAMP_TZ_FORMAT' => 'YYYY-MM-DD HH24:MI:SS TZH:TZM',
            'NLS_NUMERIC_CHARACTERS' => '.,',
        ],
    ],
];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>queue.php</nome_arquivo>
  <caminho_completo>config/queue.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Default Queue Connection Name
    |--------------------------------------------------------------------------
    |
    | Laravel's queue supports a variety of backends via a single, unified
    | API, giving you convenient access to each backend using identical
    | syntax for each. The default queue connection is defined below.
    |
    */

    'default' => env('QUEUE_CONNECTION', 'database'),

    /*
    |--------------------------------------------------------------------------
    | Queue Connections
    |--------------------------------------------------------------------------
    |
    | Here you may configure the connection options for every queue backend
    | used by your application. An example configuration is provided for
    | each backend supported by Laravel. You're also free to add more.
    |
    | Drivers: "sync", "database", "beanstalkd", "sqs", "redis", "null"
    |
    */

    'connections' => [

        'sync' => [
            'driver' => 'sync',
        ],

        'database' => [
            'driver' => 'database',
            'connection' => env('DB_QUEUE_CONNECTION'),
            'table' => env('DB_QUEUE_TABLE', 'jobs'),
            'queue' => env('DB_QUEUE', 'default'),
            'retry_after' => (int) env('DB_QUEUE_RETRY_AFTER', 90),
            'after_commit' => false,
        ],

        'beanstalkd' => [
            'driver' => 'beanstalkd',
            'host' => env('BEANSTALKD_QUEUE_HOST', 'localhost'),
            'queue' => env('BEANSTALKD_QUEUE', 'default'),
            'retry_after' => (int) env('BEANSTALKD_QUEUE_RETRY_AFTER', 90),
            'block_for' => 0,
            'after_commit' => false,
        ],

        'sqs' => [
            'driver' => 'sqs',
            'key' => env('AWS_ACCESS_KEY_ID'),
            'secret' => env('AWS_SECRET_ACCESS_KEY'),
            'prefix' => env('SQS_PREFIX', 'https://sqs.us-east-1.amazonaws.com/your-account-id'),
            'queue' => env('SQS_QUEUE', 'default'),
            'suffix' => env('SQS_SUFFIX'),
            'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
            'after_commit' => false,
        ],

        'redis' => [
            'driver' => 'redis',
            'connection' => env('REDIS_QUEUE_CONNECTION', 'default'),
            'queue' => env('REDIS_QUEUE', 'default'),
            'retry_after' => (int) env('REDIS_QUEUE_RETRY_AFTER', 90),
            'block_for' => null,
            'after_commit' => false,
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Job Batching
    |--------------------------------------------------------------------------
    |
    | The following options configure the database and table that store job
    | batching information. These options can be updated to any database
    | connection and table which has been defined by your application.
    |
    */

    'batching' => [
        'database' => env('DB_CONNECTION', 'sqlite'),
        'table' => 'job_batches',
    ],

    /*
    |--------------------------------------------------------------------------
    | Failed Queue Jobs
    |--------------------------------------------------------------------------
    |
    | These options configure the behavior of failed queue job logging so you
    | can control how and where failed jobs are stored. Laravel ships with
    | support for storing failed jobs in a simple file or in a database.
    |
    | Supported drivers: "database-uuids", "dynamodb", "file", "null"
    |
    */

    'failed' => [
        'driver' => env('QUEUE_FAILED_DRIVER', 'database-uuids'),
        'database' => env('DB_CONNECTION', 'sqlite'),
        'table' => 'failed_jobs',
    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>services.php</nome_arquivo>
  <caminho_completo>config/services.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'resend' => [
        'key' => env('RESEND_KEY'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

    'tre_ac' => [
        'base_url' => env('TRE_AC_API_BASE_URL', 'https://visao.tre-ac.jus.br/painel/view/api'),
        'timeout' => (int) env('TRE_AC_API_TIMEOUT', 8),
        'cache_ttl' => (int) env('TRE_AC_API_CACHE_TTL', 3600),
    ],

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>config</pasta>
  <subpasta>config</subpasta>
  <nome_arquivo>session.php</nome_arquivo>
  <caminho_completo>config/session.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Support\Str;

return [

    /*
    |--------------------------------------------------------------------------
    | Default Session Driver
    |--------------------------------------------------------------------------
    |
    | This option determines the default session driver that is utilized for
    | incoming requests. Laravel supports a variety of storage options to
    | persist session data. Database storage is a great default choice.
    |
    | Supported: "file", "cookie", "database", "apc",
    |            "memcached", "redis", "dynamodb", "array"
    |
    */

    'driver' => env('SESSION_DRIVER', 'database'),

    /*
    |--------------------------------------------------------------------------
    | Session Lifetime
    |--------------------------------------------------------------------------
    |
    | Here you may specify the number of minutes that you wish the session
    | to be allowed to remain idle before it expires. If you want them
    | to expire immediately when the browser is closed then you may
    | indicate that via the expire_on_close configuration option.
    |
    */

    'lifetime' => (int) env('SESSION_LIFETIME', 120),

    'expire_on_close' => env('SESSION_EXPIRE_ON_CLOSE', false),

    /*
    |--------------------------------------------------------------------------
    | Session Encryption
    |--------------------------------------------------------------------------
    |
    | This option allows you to easily specify that all of your session data
    | should be encrypted before it's stored. All encryption is performed
    | automatically by Laravel and you may use the session like normal.
    |
    */

    'encrypt' => env('SESSION_ENCRYPT', false),

    /*
    |--------------------------------------------------------------------------
    | Session File Location
    |--------------------------------------------------------------------------
    |
    | When utilizing the "file" session driver, the session files are placed
    | on disk. The default storage location is defined here; however, you
    | are free to provide another location where they should be stored.
    |
    */

    'files' => storage_path('framework/sessions'),

    /*
    |--------------------------------------------------------------------------
    | Session Database Connection
    |--------------------------------------------------------------------------
    |
    | When using the "database" or "redis" session drivers, you may specify a
    | connection that should be used to manage these sessions. This should
    | correspond to a connection in your database configuration options.
    |
    */

    'connection' => env('SESSION_CONNECTION'),

    /*
    |--------------------------------------------------------------------------
    | Session Database Table
    |--------------------------------------------------------------------------
    |
    | When using the "database" session driver, you may specify the table to
    | be used to store sessions. Of course, a sensible default is defined
    | for you; however, you're welcome to change this to another table.
    |
    */

    'table' => env('SESSION_TABLE', 'sessions'),

    /*
    |--------------------------------------------------------------------------
    | Session Cache Store
    |--------------------------------------------------------------------------
    |
    | When using one of the framework's cache driven session backends, you may
    | define the cache store which should be used to store the session data
    | between requests. This must match one of your defined cache stores.
    |
    | Affects: "apc", "dynamodb", "memcached", "redis"
    |
    */

    'store' => env('SESSION_STORE'),

    /*
    |--------------------------------------------------------------------------
    | Session Sweeping Lottery
    |--------------------------------------------------------------------------
    |
    | Some session drivers must manually sweep their storage location to get
    | rid of old sessions from storage. Here are the chances that it will
    | happen on a given request. By default, the odds are 2 out of 100.
    |
    */

    'lottery' => [2, 100],

    /*
    |--------------------------------------------------------------------------
    | Session Cookie Name
    |--------------------------------------------------------------------------
    |
    | Here you may change the name of the session cookie that is created by
    | the framework. Typically, you should not need to change this value
    | since doing so does not grant a meaningful security improvement.
    |
    */

    'cookie' => env(
        'SESSION_COOKIE',
        Str::slug(env('APP_NAME', 'laravel'), '_').'_session'
    ),

    /*
    |--------------------------------------------------------------------------
    | Session Cookie Path
    |--------------------------------------------------------------------------
    |
    | The session cookie path determines the path for which the cookie will
    | be regarded as available. Typically, this will be the root path of
    | your application, but you're free to change this when necessary.
    |
    */

    'path' => env('SESSION_PATH', '/'),

    /*
    |--------------------------------------------------------------------------
    | Session Cookie Domain
    |--------------------------------------------------------------------------
    |
    | This value determines the domain and subdomains the session cookie is
    | available to. By default, the cookie will be available to the root
    | domain and all subdomains. Typically, this shouldn't be changed.
    |
    */

    'domain' => env('SESSION_DOMAIN'),

    /*
    |--------------------------------------------------------------------------
    | HTTPS Only Cookies
    |--------------------------------------------------------------------------
    |
    | By setting this option to true, session cookies will only be sent back
    | to the server if the browser has a HTTPS connection. This will keep
    | the cookie from being sent to you when it can't be done securely.
    |
    */

    'secure' => env('SESSION_SECURE_COOKIE'),

    /*
    |--------------------------------------------------------------------------
    | HTTP Access Only
    |--------------------------------------------------------------------------
    |
    | Setting this value to true will prevent JavaScript from accessing the
    | value of the cookie and the cookie will only be accessible through
    | the HTTP protocol. It's unlikely you should disable this option.
    |
    */

    'http_only' => env('SESSION_HTTP_ONLY', true),

    /*
    |--------------------------------------------------------------------------
    | Same-Site Cookies
    |--------------------------------------------------------------------------
    |
    | This option determines how your cookies behave when cross-site requests
    | take place, and can be used to mitigate CSRF attacks. By default, we
    | will set this value to "lax" to permit secure cross-site requests.
    |
    | See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#samesitesamesite-value
    |
    | Supported: "lax", "strict", "none", null
    |
    */

    'same_site' => env('SESSION_SAME_SITE', 'lax'),

    /*
    |--------------------------------------------------------------------------
    | Partitioned Cookies
    |--------------------------------------------------------------------------
    |
    | Setting this value to true will tie the cookie to the top-level site for
    | a cross-site context. Partitioned cookies are accepted by the browser
    | when flagged "secure" and the Same-Site attribute is set to "none".
    |
    */

    'partitioned' => env('SESSION_PARTITIONED_COOKIE', false),

];

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>0001_01_01_000001_create_cache_table.php</nome_arquivo>
  <caminho_completo>database/migrations/0001_01_01_000001_create_cache_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cache', function (Blueprint $table) {
            $table->string('key')->primary();
            $table->mediumText('value');
            $table->integer('expiration');
        });

        Schema::create('cache_locks', function (Blueprint $table) {
            $table->string('key')->primary();
            $table->string('owner');
            $table->integer('expiration');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cache');
        Schema::dropIfExists('cache_locks');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>0001_01_01_000002_create_jobs_table.php</nome_arquivo>
  <caminho_completo>database/migrations/0001_01_01_000002_create_jobs_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('jobs', function (Blueprint $table) {
            $table->id();
            $table->string('queue')->index();
            $table->longText('payload');
            $table->unsignedTinyInteger('attempts');
            $table->unsignedInteger('reserved_at')->nullable();
            $table->unsignedInteger('available_at');
            $table->unsignedInteger('created_at');
        });

        Schema::create('job_batches', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->string('name');
            $table->integer('total_jobs');
            $table->integer('pending_jobs');
            $table->integer('failed_jobs');
            $table->longText('failed_job_ids');
            $table->mediumText('options')->nullable();
            $table->integer('cancelled_at')->nullable();
            $table->integer('created_at');
            $table->integer('finished_at')->nullable();
        });

        Schema::create('failed_jobs', function (Blueprint $table) {
            $table->id();
            $table->string('uuid')->unique();
            $table->text('connection');
            $table->text('queue');
            $table->longText('payload');
            $table->longText('exception');
            $table->timestamp('failed_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jobs');
        Schema::dropIfExists('job_batches');
        Schema::dropIfExists('failed_jobs');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_04_123216_create_sessions_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_04_123216_create_sessions_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            // user_id é o username do Authelia (string), não bigint.
            $table->string('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sessions');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_20_000000_create_usuarios_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_20_000000_create_usuarios_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('usuarios', function (Blueprint $table) {
            $table->id();
            $table->string('username', 120);
            $table->string('nome', 200)->nullable();
            $table->string('email', 200)->nullable();
            $table->timestamps();

            $table->unique('username', 'uq_usuarios_username');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('usuarios');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_20_000001_create_grupos_acesso_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_20_000001_create_grupos_acesso_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('grupos_acesso', function (Blueprint $table) {
            $table->id();
            $table->string('nome', 120);
            $table->string('descricao', 300)->nullable();
            // 'admin' | 'supervisor' | 'estagiario' — substitui o '0'/'S'/'E'
            // hardcoded em ConfigureUserSession. Determina o conjunto de
            // helpers semânticos (is_admin/is_supervisor/is_estagiario) e
            // os passos do onboarding.
            $table->string('categoria', 20);
            $table->boolean('ativo')->default(true);
            // Quando true, o grupo enxerga todos os setores (ignora o
            // pivot grupo_setor) e por consequência todos os estagiários.
            $table->boolean('ignora_setores_permitidos')->default(false);
            $table->timestamps();

            $table->unique('nome', 'uq_grupos_acesso_nome');
            $table->index('ativo', 'idx_grupos_acesso_ativo');
            $table->index('categoria', 'idx_grupos_acesso_cat');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('grupos_acesso');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_20_000002_create_acesso_rotas_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_20_000002_create_acesso_rotas_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('acesso_rotas', function (Blueprint $table) {
            $table->id();
            // rota_nome aceita o curinga '*': qualquer grupo vinculado a
            // essa linha é considerado admin (acesso a tudo).
            $table->string('rota_nome', 200);
            $table->string('rota_path', 300)->nullable();
            $table->string('menu_path', 500)->nullable();
            $table->string('descricao', 300)->nullable();
            $table->boolean('ativo')->default(true);
            $table->timestamps();

            $table->unique('rota_nome', 'uq_acesso_rotas_nome');
            $table->index('ativo', 'idx_acesso_rotas_ativo');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('acesso_rotas');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_20_000003_create_acesso_rota_grupo_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_20_000003_create_acesso_rota_grupo_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('acesso_rota_grupo', function (Blueprint $table) {
            $table->id();
            $table->foreignId('acesso_rota_id')
                ->constrained('acesso_rotas')
                ->cascadeOnDelete();
            $table->foreignId('grupo_acesso_id')
                ->constrained('grupos_acesso')
                ->cascadeOnDelete();
            // Permite desligar o vínculo sem deletar (preserva histórico
            // pra eventual auditoria futura).
            $table->boolean('ativo')->default(true);
            $table->timestamps();

            $table->unique(
                ['acesso_rota_id', 'grupo_acesso_id'],
                'uq_acesso_rota_grupo',
            );
            $table->index('ativo', 'idx_acesso_rota_grupo_ativo');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('acesso_rota_grupo');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_20_100000_create_eventos_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_20_100000_create_eventos_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('eventos', function (Blueprint $table) {
            $table->id();
            $table->string('nome', 200);
            $table->date('data');
            $table->string('local', 200);
            $table->timestamps();

            $table->index('data', 'idx_eventos_data');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('eventos');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_20_100100_create_convidados_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_20_100100_create_convidados_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('convidados', function (Blueprint $table) {
            $table->id();
            $table->foreignId('evento_id')
                ->constrained('eventos')
                ->cascadeOnDelete();
            $table->string('nome', 200);
            $table->string('titulacao', 200)->nullable();
            // Cargo na ordem protocolar (Mesa de Honra, Desembargadores, ...).
            $table->string('cargo', 60);
            // Cor do cartão de identificação (black/red/blue/green/yellow).
            $table->string('cor', 20);
            $table->boolean('presente')->default(false);
            $table->timestamps();

            $table->index('evento_id', 'idx_convidados_evento');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('convidados');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_22_000000_add_capacidade_assentos_to_eventos.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_22_000000_add_capacidade_assentos_to_eventos.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Capacidade de assentos por cor de cartão, por evento. Os defaults
     * reproduzem o layout fixo anterior do mapa de assentos.
     */
    public function up(): void
    {
        Schema::table('eventos', function (Blueprint $table) {
            $table->integer('cap_red')->default(36);
            $table->integer('cap_blue')->default(15);
            $table->integer('cap_green')->default(45);
            $table->integer('cap_yellow')->default(60);
        });
    }

    public function down(): void
    {
        Schema::table('eventos', function (Blueprint $table) {
            $table->dropColumn(['cap_red', 'cap_blue', 'cap_green', 'cap_yellow']);
        });
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_22_010000_create_autoridades_table.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_22_010000_create_autoridades_table.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Cadastro global de autoridades, reutilizável entre eventos. Ao sentar
     * alguém numa poltrona, cria-se um Convidado vinculado a uma Autoridade.
     */
    public function up(): void
    {
        Schema::create('autoridades', function (Blueprint $table) {
            $table->id();
            $table->string('nome', 200);
            $table->string('titulacao', 200)->nullable();
            $table->string('cargo', 60);
            $table->timestamps();

            $table->index('nome', 'idx_autoridades_nome');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('autoridades');
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/migrations</subpasta>
  <nome_arquivo>2026_05_22_010100_add_assento_to_convidados.php</nome_arquivo>
  <caminho_completo>database/migrations/2026_05_22_010100_add_assento_to_convidados.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Posiciona o convidado numa poltrona específica: a cor (já existente)
     * define a seção e `assento_numero` a posição dentro dela. Vínculo
     * opcional com a autoridade de origem (cadastro global).
     */
    public function up(): void
    {
        Schema::table('convidados', function (Blueprint $table) {
            $table->unsignedBigInteger('autoridade_id')->nullable();
            $table->integer('assento_numero')->nullable();

            $table->foreign('autoridade_id', 'fk_conv_autoridade')
                ->references('id')->on('autoridades')->nullOnDelete();
        });

        // Uma poltrona (evento+cor+número) só pode ter um ocupante — mas
        // convidados SEM poltrona (assento_numero nulo) podem repetir.
        // Unique parcial: Oracle só indexa quando todas as colunas são não
        // nulas (via CASE); SQLite usa índice parcial com WHERE.
        if (DB::getDriverName() === 'oracle') {
            DB::statement(
                'CREATE UNIQUE INDEX uq_conv_assento ON convidados ('.
                'CASE WHEN assento_numero IS NULL THEN NULL ELSE evento_id END, '.
                'CASE WHEN assento_numero IS NULL THEN NULL ELSE cor END, '.
                'assento_numero)'
            );
        } else {
            DB::statement(
                'CREATE UNIQUE INDEX uq_conv_assento ON convidados '.
                '(evento_id, cor, assento_numero) WHERE assento_numero IS NOT NULL'
            );
        }
    }

    public function down(): void
    {
        DB::statement('DROP INDEX uq_conv_assento');

        Schema::table('convidados', function (Blueprint $table) {
            $table->dropForeign('fk_conv_autoridade');
            $table->dropColumn(['autoridade_id', 'assento_numero']);
        });
    }
};

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/seeders</subpasta>
  <nome_arquivo>AcessoSeeder.php</nome_arquivo>
  <caminho_completo>database/seeders/AcessoSeeder.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\AcessoRota;
use App\Models\GrupoAcesso;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Artisan;

/**
 * Seed inicial dos grupos de acesso do Solene.
 *
 * - SOLENE-ADMIN: curinga (*), acesso total.
 * - SOLENE-ORGANIZADORES: gerencia eventos e convidados (visibilidade por
 *   grupo — todos os organizadores enxergam todos os eventos).
 *
 * Idempotente. Depende de `acl:sync` ter populado o catálogo acesso_rotas;
 * chamamos o comando explicitamente. Em produção, depois do seed inicial,
 * o admin gerencia tudo pela UI de /admin/acessos-rotas-grupos.
 */
class AcessoSeeder extends Seeder
{
    /**
     * Rotas liberadas para o ORGANIZADOR (todo o fluxo de eventos/convidados).
     *
     * @var list<string>
     */
    private const ROTAS_ORGANIZADOR = [
        'dashboard',
        'eventos.index',
        'eventos.create',
        'eventos.store',
        'eventos.show',
        'eventos.edit',
        'eventos.update',
        'eventos.destroy',
        'eventos.nominata',
        'eventos.excel',
        'eventos.assentos',
        'autoridades.buscar',
        'assentos.sentar',
        'assentos.liberar',
        'convidados.store',
        'convidados.update',
        'convidados.presenca',
        'convidados.destroy',
    ];

    public function run(): void
    {
        Artisan::call('acl:sync');

        $admin = GrupoAcesso::updateOrCreate(
            ['nome' => 'SOLENE-ADMIN'],
            [
                'descricao' => 'Administração — acesso total ao sistema via curinga.',
                'categoria' => GrupoAcesso::CATEGORIA_ADMIN,
                'ativo' => true,
                'ignora_setores_permitidos' => true,
            ],
        );

        $organizadores = GrupoAcesso::updateOrCreate(
            ['nome' => 'SOLENE-ORGANIZADORES'],
            [
                'descricao' => 'Cerimonial — cria e gerencia eventos, convidados e nominatas.',
                'categoria' => GrupoAcesso::CATEGORIA_ORGANIZADOR,
                'ativo' => true,
                'ignora_setores_permitidos' => false,
            ],
        );

        $this->vincularRotas($admin, [AcessoRota::CURINGA]);
        $this->vincularRotas($organizadores, self::ROTAS_ORGANIZADOR);
    }

    /**
     * @param  list<string>  $nomesRotas
     */
    private function vincularRotas(GrupoAcesso $grupo, array $nomesRotas): void
    {
        $ids = AcessoRota::query()
            ->whereIn('rota_nome', $nomesRotas)
            ->pluck('id', 'rota_nome');

        $payload = [];
        foreach ($nomesRotas as $nome) {
            $id = $ids->get($nome);
            if ($id === null) {
                continue;
            }
            $payload[$id] = ['ativo' => true];
        }

        $grupo->rotas()->syncWithoutDetaching($payload);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/seeders</subpasta>
  <nome_arquivo>DatabaseSeeder.php</nome_arquivo>
  <caminho_completo>database/seeders/DatabaseSeeder.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            AcessoSeeder::class,
        ]);
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>database</pasta>
  <subpasta>database/seeders</subpasta>
  <nome_arquivo>DevDadosSeeder.php</nome_arquivo>
  <caminho_completo>database/seeders/DevDadosSeeder.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Models\Evento;
use Illuminate\Database\Seeder;

/**
 * Dados de exemplo para desenvolvimento. NÃO rodar em produção.
 */
class DevDadosSeeder extends Seeder
{
    public function run(): void
    {
        $evento = Evento::create([
            'nome' => 'Sessão Solene de Posse',
            'data' => now()->addMonth()->toDateString(),
            'local' => 'Plenário do TRE-AC',
        ]);

        $convidados = [
            ['DESEMBARGADOR JOÃO PRESIDENTE', 'Excelentíssimo Senhor', 'Mesa de Honra', 'red', true],
            ['DESEMBARGADORA MARIA RELATORA', 'Excelentíssima Senhora', 'Desembargadores', 'red', true],
            ['JUIZ CARLOS ELEITORAL', 'Meritíssimo', 'Juízes', 'blue', true],
            ['PROMOTOR ANDRÉ JUSTIÇA', 'Excelentíssimo Senhor', 'Promotores Eleitorais', 'green', false],
            ['CONVIDADO PEDRO SILVA', '', 'Convidados', 'yellow', false],
        ];

        foreach ($convidados as [$nome, $titulacao, $cargo, $cor, $presente]) {
            $evento->convidados()->create(compact('nome', 'titulacao', 'cargo', 'cor', 'presente'));
        }
    }
}

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>public</pasta>
  <subpasta>public</subpasta>
  <nome_arquivo>index.php</nome_arquivo>
  <caminho_completo>public/index.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
<?php

use Illuminate\Http\Request;

define('LARAVEL_START', microtime(true));

// Determine if the application is in maintenance mode...
if (file_exists($maintenance = __DIR__.'/../storage/framework/maintenance.php')) {
    require $maintenance;
}

// Register the Composer autoloader...
require __DIR__.'/../vendor/autoload.php';

// Bootstrap Laravel and handle the request...
(require_once __DIR__.'/../bootstrap/app.php')
    ->handleRequest(Request::capture());

```
  </conteudo>
</arquivo>

<arquivo>
  <pasta>resources</pasta>
  <subpasta>resources/views/assentos</subpasta>
  <nome_arquivo>index.blade.php</nome_arquivo>
  <caminho_completo>resources/views/assentos/index.blade.php</caminho_completo>
  <extensao>php</extensao>
  <conteudo>
```php
@extends('layouts.app')

@section('title', 'Assentos · '.$evento->nome)

@php
    $porFileira = 15;
    $hex = ['red' => '#ef4444', 'blue' => '#3b82f6', 'green' => '#22c55e', 'yellow' => '#eab308'];

    // Layout clássico do plenário: seções nomeadas e fileiras por cor.
    // A capacidade vem do banco; aqui só distribuímos os números de cada
    // cor (posicionais) pelas seções, na ordem original.
    $secoesTemplate = [
        ['nome' => 'Mesa de Honra', 'fileiras' => [['red', 6]]],
        ['nome' => 'Desembargadores / Juízes', 'fileiras' => [['red', 15], ['red', 15], ['blue', 15]]],
        ['nome' => 'Autoridades / Promotores', 'fileiras' => [['green', 15], ['green', 15], ['green', 15]]],
        ['nome' => 'Convidados', 'fileiras' => [['yellow', 15], ['yellow', 15], ['yellow', 15], ['yellow', 15]]],
    ];

    // Próximo número livre por cor (1-based), respeitando a capacidade do banco.
    $contador = array_fill_keys(array_keys($mapa['categorias']), 0);
    $montarFileira = function (string $cor, int $qtd) use (&$contador, $mapa) {
        $cap = $mapa['categorias'][$cor]['capacidade'] ?? 0;
        $assentos = $mapa['categorias'][$cor]['assentos'] ?? [];
        $row = [];
        for ($k = 0; $k < $qtd && $contador[$cor] < $cap; $k++) {
            $contador[$cor]++;
            $row[] = [
                'cor' => $cor,
                'numero' => $contador[$cor],
                'label' => $mapa['categorias'][$cor]['label'] ?? $cor,
                'ocupante' => $assentos[$contador[$cor]] ?? null,
            ];
        }
        return $row;
    };

    $render = [];
    foreach ($secoesTemplate as $secao) {
        $rows = [];
        $ocup = 0;
        $total = 0;
        foreach ($secao['fileiras'] as [$cor, $qtd]) {
            $row = $montarFileira($cor, $qtd);
            if ($row === []) {
                continue;
            }
            foreach ($row as $s) {
                $total++;
                if ($s['ocupante']) {
                    $ocup++;
                }
            }
            $rows[] = $row;
        }
        if ($rows !== []) {
            $render[] = ['nome' => $secao['nome'], 'rows' => $rows, 'ocupados' => $ocup, 'total' => $total];
        }
    }

    // Capacidade acima do layout clássico → fileiras extras de 15, por cor.
    foreach ($mapa['categorias'] as $cor => $cat) {
        if ($contador[$cor] >= $cat['capacidade']) {
            continue;
        }
        $rows = [];
        $ocup = 0;
        $total = 0;
        while ($contador[$cor] < $cat['capacidade']) {
            $row = $montarFileira($cor, $porFileira);
            foreach ($row as $s) {
                $total++;
                if ($s['ocupante']) {
                    $ocup++;
                }
            }
            $rows[] = $row;
        }
        $render[] = ['nome' => $cat['label'].' (lugares extras)', 'rows' => $rows, 'ocupados' => $ocup, 'total' => $total];
    }
@endphp

@push('styles')
<style>
    .seat-hero {
        display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 1rem; margin: 1.25rem 0 1.5rem;
    }
    .seat-stat {
        background: var(--solene-card); border: 1px solid var(--solene-border);
        border-radius: var(--solene-radius); padding: 1rem 1.1rem;
        box-shadow: var(--solene-shadow-sm); position: relative; overflow: hidden;
    }
    .seat-stat::before { content: ""; position: absolute; left: 0; top: 0; bottom: 0; width: 4px;
        background: linear-gradient(var(--solene-gold-2), var(--solene-gold)); }
    .seat-stat__label { font-size: .72rem; text-transform: uppercase; letter-spacing: .8px;
        color: var(--solene-muted); font-weight: 700; }
    .seat-stat__value { font-family: 'Cormorant Garamond', Georgia, serif;
        font-size: 2.1rem; font-weight: 700; color: var(--solene-navy); line-height: 1.1; }
    .seat-stat__value small { font-size: 1rem; color: var(--solene-muted); font-weight: 600; }
    .seat-ring { --p: 0; width: 64px; height: 64px; flex: none; border-radius: 50%;
        background: conic-gradient(var(--solene-gold) calc(var(--p) * 1%), #eef2f7 0);
        display: grid; place-items: center; }
    .seat-ring span { width: 48px; height: 48px; border-radius: 50%; background: #fff;
        display: grid; place-items: center; font-weight: 700; color: var(--solene-navy); font-size: .85rem; }

    .seat-hint { text-align:center; color: var(--solene-muted); font-size: .85rem; margin-bottom: 1.25rem; }
    .seat-hint i { color: var(--solene-gold); }

    .seat-section { text-align: center; margin-bottom: 1.75rem; }
    .seat-section__title { font-family: 'Cormorant Garamond', Georgia, serif; font-size: 1.25rem;
        color: var(--solene-navy); margin-bottom: .75rem; position: relative; display: inline-block; }
    .seat-section__title small { display:block; font-family: 'Raleway', sans-serif; font-size:.72rem;
        letter-spacing:.5px; color: var(--solene-muted); font-weight:600; }
    .seat-section__title::after { content: ""; display: block; width: 40px; height: 2px; margin: .3rem auto 0;
        background: var(--solene-gold); }
    .seat-row { display: flex; justify-content: center; gap: 6px; margin-bottom: 6px; flex-wrap: wrap; }

    .seat { width: 24px; height: 24px; border-radius: 7px 7px 3px 3px; border: 1.5px solid transparent;
        padding: 0; cursor: pointer; position: relative;
        transition: transform .15s var(--solene-ease), box-shadow .15s var(--solene-ease); }
    .seat:hover, .seat:focus-visible { transform: translateY(-3px) scale(1.14);
        box-shadow: 0 6px 12px rgba(15,23,42,.22); outline: none; z-index: 2; }
    .seat.occupied { box-shadow: inset 0 -3px 0 rgba(0,0,0,.18); }
    .seat.occupied::after { content: "\f007"; font-family: "Font Awesome 5 Free"; font-weight: 900;
        font-size: .62rem; color: rgba(255,255,255,.92); position: absolute; inset: 0;
        display: grid; place-items: center; }
    .cat-red.occupied { background: #ef4444; } .cat-red.free { background: #fdeaea; border-color: #f3b4b4; }
    .cat-blue.occupied { background: #3b82f6; } .cat-blue.free { background: #e7effd; border-color: #b3cdf9; }
    .cat-green.occupied { background: #22c55e; } .cat-green.free { background: #e4f8ec; border-color: #a8e6c1; }
    .cat-yellow.occupied { background: #eab308; } .cat-yellow.free { background: #fdf6d9; border-color: #f0db8e; }

    /* Tooltip (hover no desktop) — quem está na poltrona */
    .seat-tip { position: absolute; bottom: 135%; left: 50%; transform: translateX(-50%) translateY(4px);
        background: var(--solene-navy-2); color: #fff; padding: .4rem .6rem; border-radius: 8px;
        font-size: .72rem; line-height: 1.25; white-space: nowrap; opacity: 0; pointer-events: none;
        transition: opacity .15s var(--solene-ease), transform .15s var(--solene-ease); z-index: 10;
        box-shadow: 0 6px 18px rgba(0,31,63,.3); border-bottom: 2px solid var(--solene-gold); }
    .seat-tip::after { content: ""; position: absolute; top: 100%; left: 50%; transform: translateX(-50%);
        border: 5px solid transparent; border-top-color: var(--solene-navy-2); }
    .seat-tip b { font-weight: 700; } .seat-tip span { opacity: .8; }
    .seat.occupied:hover .seat-tip, .seat.occupied:focus-visible .seat-tip {
        opacity: 1; transform: translateX(-50%) translateY(0); }

    .seat-empty { text-align:center; color: var(--solene-muted); padding: 2rem 1rem; }

    .seat-legend { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: .9rem 1.5rem; margin-top: 1.75rem; border-top: 1px solid var(--solene-border); padding-top: 1.5rem; }
    .seat-legend__row { display: flex; align-items: center; gap: .6rem; font-size: .85rem; }
    .seat-legend__sw { width: 16px; height: 16px; border-radius: 5px 5px 2px 2px; flex: none; }
    .seat-legend__txt { flex: 1; color: var(--solene-ink); }
    .seat-legend__count { color: var(--solene-muted); font-weight: 700; font-size: .8rem; white-space: nowrap; }
    .seat-legend__bar { height: 5px; border-radius: 999px; background: #eef2f7; margin-top: .3rem; overflow: hidden; }
    .seat-legend__fill { height: 100%; border-radius: 999px; }

    /* Modal */
    .modal-overlay { position: fixed; inset: 0; background: rgba(15,23,42,.55); backdrop-filter: blur(2px);
        display: none; align-items: center; justify-content: center; padding: 1rem; z-index: 100;
        animation: solene-fade-up .2s ease; }
    .modal-overlay.is-open { display: flex; }
    .modal-box { background: #fff; border-radius: 16px; width: 100%; max-width: 460px; max-height: 90vh;
        overflow: auto; box-shadow: 0 24px 60px rgba(15,23,42,.3); border-top: 4px solid var(--solene-gold); }
    .modal-head { display: flex; align-items: center; justify-content: space-between; gap: 1rem;
        padding: 1rem 1.25rem; border-bottom: 1px solid var(--solene-border); }
    .modal-head h3 { margin: 0; font-size: 1.3rem; }
    .modal-close { background: none; border: 0; font-size: 1.3rem; color: var(--solene-muted); cursor: pointer; line-height: 1; }
    .modal-body { padding: 1.25rem; }
    .modal-label { font-size: .8rem; font-weight: 700; color: var(--solene-muted); text-transform: uppercase;
        letter-spacing: .5px; margin: 0 0 .4rem; }
    .modal-body input, .modal-body select { width: 100%; padding: .55rem; border: 1px solid var(--solene-border);
        border-radius: 8px; margin-bottom: .75rem; }
    .modal-divider { display: flex; align-items: center; gap: .75rem; color: var(--solene-muted); font-size: .8rem;
        margin: 1.1rem 0; }
    .modal-divider::before, .modal-divider::after { content: ""; flex: 1; height: 1px; background: var(--solene-border); }
    .busca-results { display: flex; flex-direction: column; gap: .4rem; max-height: 220px; overflow: auto; margin-top: .5rem; }
    .busca-item { text-align: left; border: 1px solid var(--solene-border); background: #fff; border-radius: 10px;
        padding: .55rem .75rem; cursor: pointer; transition: background .15s, border-color .15s; }
    .busca-item:hover { background: var(--color-primary-pastel-02); border-color: var(--solene-navy); }
    .busca-item b { display: block; color: var(--solene-navy); }
    .busca-item span { font-size: .78rem; color: var(--solene-muted); }
    .busca-vazio { color: var(--solene-muted); font-size: .85rem; text-align: center; padding: .75rem; }
    .ocupante-card { text-align: center; padding: .5rem 0 1.25rem; }
    .ocupante-card .nome { font-family: 'Cormorant Garamond', Georgia, serif; font-size: 1.5rem; color: var(--solene-navy); }
    .ocupante-card .meta { color: var(--solene-muted); font-size: .9rem; margin-top: .2rem; }
</style>
@endpush

@section('content')
    <a href="{{ route('eventos.show', $evento) }}" class="solene-btn solene-btn--ghost" style="margin-bottom:1rem;">
        <i class="fas fa-arrow-left"></i> Voltar para o evento
    </a>

    <div style="text-align:center;">
        <h1><i class="fas fa-chair" style="color:var(--solene-gold);"></i> Distribuição de Assentos</h1>
        <p style="color:var(--solene-muted);">{{ $evento->nome }}</p>
    </div>

    <div class="seat-hero">
        <div class="seat-stat">
            <div class="seat-stat__label">Presentes</div>
            <div class="seat-stat__value">{{ $totalPresentes }}</div>
        </div>
        <div class="seat-stat">
            <div class="seat-stat__label">Lugares ocupados</div>
            <div class="seat-stat__value">{{ $mapa['ocupados'] }} <small>/ {{ $mapa['capacidade_total'] }}</small></div>
        </div>
        <div class="seat-stat" style="display:flex;align-items:center;gap:1rem;">
            <div class="seat-ring" style="--p: {{ $mapa['taxa'] }};"><span>{{ $mapa['taxa'] }}%</span></div>
            <div>
                <div class="seat-stat__label">Ocupação</div>
                <div style="color:var(--solene-muted);font-size:.85rem;">{{ $mapa['livres'] }} lugares livres</div>
            </div>
        </div>
    </div>

    <div class="solene-card" style="padding:2rem 1.5rem;">
        @if ($mapa['capacidade_total'] === 0)
            <div class="seat-empty">
                <i class="fas fa-couch" style="font-size:2rem;color:var(--solene-border);"></i>
                <p style="margin-top:.75rem;">Nenhum assento configurado para este evento.<br>
                    Defina a capacidade na <a href="{{ route('eventos.edit', $evento) }}" style="color:var(--solene-navy);font-weight:600;">edição do evento</a>.</p>
            </div>
        @else
            <p class="seat-hint"><i class="fas fa-hand-pointer"></i> Clique numa poltrona livre para sentar uma autoridade. Passe o mouse (ou toque) para ver quem está sentado.</p>

            @foreach ($render as $secao)
                <div class="seat-section">
                    <div class="seat-section__title">
                        {{ $secao['nome'] }}
                        <small>{{ $secao['ocupados'] }} / {{ $secao['total'] }} ocupados</small>
                    </div>
                    @foreach ($secao['rows'] as $row)
                        <div class="seat-row">
                            @foreach ($row as $s)
                                @if ($s['ocupante'])
                                    <button type="button" class="seat cat-{{ $s['cor'] }} occupied"
                                            data-ocupada="1" data-id="{{ $s['ocupante']->id }}"
                                            data-nome="{{ $s['ocupante']->nome }}" data-titulacao="{{ $s['ocupante']->titulacao }}"
                                            data-cargo="{{ $s['ocupante']->cargo }}" data-cor="{{ $s['cor'] }}" data-numero="{{ $s['numero'] }}"
                                            aria-label="Poltrona {{ $s['numero'] }} — {{ $s['ocupante']->nome }}">
                                        <span class="seat-tip"><b>{{ $s['ocupante']->nome }}</b><br><span>{{ $s['ocupante']->cargo }}</span></span>
                                    </button>
                                @else
                                    <button type="button" class="seat cat-{{ $s['cor'] }} free"
                                            data-cor="{{ $s['cor'] }}" data-numero="{{ $s['numero'] }}"
                                            data-label="{{ $s['label'] }}"
                                            aria-label="Poltrona {{ $s['numero'] }} livre — clique para sentar"></button>
                                @endif
                            @endforeach
                        </div>
                    @endforeach
                </div>
            @endforeach

            <div class="seat-legend">
                @foreach ($mapa['categorias'] as $cor => $cat)
                    @continue($cat['capacidade'] === 0)
                    <div>
                        <div class="seat-legend__row">
                            <span class="seat-legend__sw" style="background:{{ $hex[$cor] ?? '#999' }};"></span>
                            <span class="seat-legend__txt">{{ $cat['label'] }}</span>
                            <span class="seat-legend__count">{{ $cat['ocupados'] }} / {{ $cat['capacidade'] }}</span>
                        </div>
                        <div class="seat-legend__bar">
                            <div class="seat-legend__fill" style="width:{{ $cat['pct'] }}%;background:{{ $hex[$cor] ?? '#999' }};"></div>
                        </div>
                    </div>
                @endforeach
            </div>
        @endif
    </div>

    {{-- Modal: sentar autoridade numa poltrona livre --}}
    <div class="modal-overlay" id="modal-sentar" role="dialog" aria-modal="true">
        <div class="modal-box">
            <div class="modal-head">
                <h3 id="sentar-titulo">Sentar autoridade</h3>
                <button type="button" class="modal-close" data-close>&times;</button>
            </div>
            <div class="modal-body">
                <p class="modal-label">Buscar no cadastro</p>
                <input type="search" id="busca-input" placeholder="Digite o nome da autoridade…" autocomplete="off">
                <div class="busca-results" id="busca-results"></div>

                <div class="modal-divider">ou cadastrar nova</div>

                <form id="form-sentar-nova" method="POST" action="{{ route('assentos.sentar', $evento) }}">
                    @csrf
                    <input type="hidden" name="cor" id="sn-cor">
                    <input type="hidden" name="numero" id="sn-numero">
                    <p class="modal-label">Nome</p>
                    <input name="nome" minlength="3" placeholder="Nome completo" style="text-transform:uppercase;">
                    <p class="modal-label">Titulação</p>
                    <input name="titulacao" placeholder="Ex: Excelentíssimo Senhor">
                    <p class="modal-label">Cargo</p>
                    <select name="cargo">
                        @foreach (\App\Models\Convidado::CARGOS as $cargo)<option value="{{ $cargo }}">{{ $cargo }}</option>@endforeach
                    </select>
                    <button type="submit" class="solene-btn" style="width:100%;justify-content:center;">
                        <i class="fas fa-user-plus"></i> Cadastrar e sentar
                    </button>
                </form>

                {{-- Form auxiliar para sentar autoridade já existente (preenchido via busca) --}}
                <form id="form-sentar-existente" method="POST" action="{{ route('assentos.sentar', $evento) }}" hidden>
                    @csrf
                    <input type="hidden" name="cor" id="se-cor">
                    <input type="hidden" name="numero" id="se-numero">
                    <input type="hidden" name="autoridade_id" id="se-autoridade">
                </form>
            </div>
        </div>
    </div>

    {{-- Modal: ocupante da poltrona + liberar --}}
    <div class="modal-overlay" id="modal-ocupante" role="dialog" aria-modal="true">
        <div class="modal-box">
            <div class="modal-head">
                <h3>Poltrona ocupada</h3>
                <button type="button" class="modal-close" data-close>&times;</button>
            </div>
            <div class="modal-body">
                <div class="ocupante-card">
                    <div class="nome" id="oc-nome"></div>
                    <div class="meta" id="oc-meta"></div>
                </div>
                <form id="form-liberar" method="POST">
                    @csrf
                    @method('DELETE')
                    <button type="submit" class="solene-btn solene-btn--danger" style="width:100%;justify-content:center;"
                            onclick="return confirm('Liberar esta poltrona?');">
                        <i class="fas fa-user-slash"></i> Liberar poltrona
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        (function () {
            const eventoId = {{ $evento->id }};
            const buscarUrl = "{{ route('autoridades.buscar') }}";
            const liberarBase = "{{ url('eventos/'.$evento->id.'/assentos') }}";

            const mSentar = document.getElementById('modal-sentar');
            const mOcup = document.getElementById('modal-ocupante');
            const open = (m) => m.classList.add('is-open');
            const close = (m) => m.classList.remove('is-open');

            document.querySelectorAll('[data-close]').forEach((b) =>
                b.addEventListener('click', () => { close(mSentar); close(mOcup); }));
            [mSentar, mOcup].forEach((m) => m.addEventListener('click', (e) => { if (e.target === m) close(m); }));
            document.addEventListener('keydown', (e) => { if (e.key === 'Escape') { close(mSentar); close(mOcup); } });

            document.querySelectorAll('.seat').forEach((seat) => {
                seat.addEventListener('click', () => {
                    const cor = seat.dataset.cor, numero = seat.dataset.numero;
                    if (seat.dataset.ocupada) {
                        document.getElementById('oc-nome').textContent = seat.dataset.nome;
                        const tit = seat.dataset.titulacao ? seat.dataset.titulacao + ' · ' : '';
                        document.getElementById('oc-meta').textContent = tit + seat.dataset.cargo + ' · Poltrona ' + numero;
                        document.getElementById('form-liberar').action = liberarBase + '/' + seat.dataset.id;
                        open(mOcup);
                    } else {
                        document.getElementById('sentar-titulo').textContent = 'Sentar em ' + seat.dataset.label + ' · poltrona ' + numero;
                        document.getElementById('sn-cor').value = cor;
                        document.getElementById('sn-numero').value = numero;
                        document.getElementById('se-cor').value = cor;
                        document.getElementById('se-numero').value = numero;
                        document.getElementById('busca-input').value = '';
                        document.getElementById('busca-results').innerHTML = '';
                        open(mSentar);
                        setTimeout(() => document.getElementById('busca-input').focus(), 50);
                    }
                });
            });

            // Busca de autoridades (debounce)
            let t = null;
            const input = document.getElementById('busca-input');
            const results = document.getElementById('busca-results');
            input.addEventListener('input', () => {
                clearTimeout(t);
                const q = input.value.trim();
                t = setTimeout(() => buscar(q), 250);
            });
            function buscar(q) {
                fetch(buscarUrl + '?q=' + encodeURIComponent(q), { headers: { 'Accept': 'application/json' } })
                    .then((r) => r.json())
                    .then((lista) => {
                        results.innerHTML = '';
                        if (!lista.length) {
                            results.innerHTML = '<div class="busca-vazio">Nenhuma autoridade encontrada. Cadastre abaixo.</div>';
                            return;
                        }
                        lista.forEach((a) => {
                            const btn = document.createElement('button');
                            btn.type = 'button';
                            btn.className = 'busca-item';
                            const meta = (a.titulacao ? a.titulacao + ' · ' : '') + a.cargo;
                            btn.innerHTML = '<b>' + a.nome + '</b><span>' + meta + '</span>';
                            btn.addEventListener('click', () => {
                                document.getElementById('se-autoridade').value = a.id;
                                document.getElementById('form-sentar-existente').submit();
                            });
                            results.appendChild(btn);
                        });
                    })
                    .catch(() => { results.innerHTML = '<div class="busca-vazio">Erro ao buscar.</div>'; });
            }
        })();
    </script>
@endsection

```
  </conteudo>
</arquivo>

