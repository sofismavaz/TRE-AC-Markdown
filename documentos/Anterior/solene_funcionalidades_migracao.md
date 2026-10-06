# SOLENE – GESTÃO DIGITAL DE CERIMONIAL E PROTOCOLO (TRE-AC)
## DOCUMENTO DE ESPECIFICAÇÃO RECOMPILADA DE FUNCIONALIDADES, MARCOS NORMATIVOS E PLANO DE MIGRAÇÃO PARA O ECOSSISTEMA CREPÚSCULO

---

### 1. INTRODUÇÃO E VISÃO GERAL DE TRANSFORMAÇÃO DIGITAL

O sistema **SOLENE – Gestão de Cerimonial** representa a solução tecnológica estratégica concebida para modernizar, integrar e padronizar o planejamento, a execução, o controle operacional e o registro histórico dos eventos oficiais, solenidades e atos formais de representação do Tribunal Regional Eleitoral do Acre (TRE-AC).

Fundamentado na **Resolução TRE-AC nº 349/2002**, que instituiu a **Comissão Permanente de Cerimonial e Protocolo (CPCT)**, o SOLENE transcende a automação funcional utilitária, consolidando-se como um guardião da liturgia institucional, da imagem pública do Poder Judiciário e da memória organizacional da Justiça Eleitoral no Estado do Acre (sediada na Alameda Ministro Miguel Ferrante, 224, Bairro Portal da Amazônia, CEP 69915-632, Rio Branco - AC; Tel: (68) 3212-6125; E-mail: `cerimonial@tre-ac.jus.br`).

A presente reestruturação documental tem por objetivo redefinir a arquitetura funcional e o roadmap de evolução do SOLENE, migrando-o de uma aplicação isolada/transicional para um **módulo customizado e especializado perfeitamente integrado ao monólito corporativo do Ecossistema Crepúsculo** (derivado diretamente do domínio **Presença – Registro de Frequência**).

---

### 2. AMAPLAÇÃO DA FUNDAMENTAÇÃO NORMATIVA E LEGISLAÇÃO COMPLEMENTAR

Para garantir a estrita conformidade jurídica e protocolar das operações do sistema em todas as modalidades de eventos realizados pelo Tribunal, o arcabouço normativo do SOLENE foi expandido, incorporando as diretrizes da legislação eleitoral, do cerimonial público, das resoluções do Conselho Nacional de Justiça (CNJ) e das normas de engenharia de software e contabilidade pública.

#### 2.1. Atos Solenes, Eleitorais e Protocolares
*   **[Código Eleitoral (Lei Federal nº 4.737/1965)](https://www.tse.jus.br/legislacao/codigo-eleitoral/codigo-eleitoral-1/codigo-eleitoral-lei-nb0-4.737-de-15-de-julho-de-1965):** Fundamenta o ato de diplomação como a certificação oficial de que o candidato eleito está apto a assumir e exercer o mandato outorgado pelo eleitorado.
*   **[Resolução TSE nº 23.677/2021](https://www.tse.jus.br/legislacao/compilada/res/2021/resolucao-no-23-677-de-16-de-dezembro-de-2021):** Regulamenta os requisitos, restrições e ritos aplicáveis às sessões solenes de diplomação dos eleitos.
*   **[Decreto Federal nº 70.274/1972](https://www.planalto.gov.br/ccivil_03/decreto/d70274.htm):** Estabelece as normas do Cerimonial Público e a Ordem Geral de Precedência da República Federativa do Brasil, servindo de base algorítmica para a composição automatizada de Mesas de Honra, precedência de autoridades e distribuição de assentos.
*   **[Resolução TRE-AC nº 349/2002](https://www.tre-ac.jus.br/legislacao/resolucoes-tre):** Institui a Comissão Permanente de Cerimonial e Protocolo do TRE-AC, definindo suas atribuições executivas e administrativas.
*   **[Regimento Interno do TRE-AC](https://www.tre-ac.jus.br/legislacao/resolucoes-tre):** Regula os procedimentos regimentais para sessões solenes de posse de Membros Especiais da Corte e solenidades administrativas.

#### 2.2. Normativos do CNJ para Eventos Não-Solenes e Capacitações
*   **Instrução Normativa DG/CNJ nº 111/2026:** Regulamenta a organização, classificação, prazos, solicitações e logística para a realização de *Eventos Institucionais* no âmbito do Poder Judiciário.
*   **Resolução CNJ nº 400/2021 (alterada pela Resolução CNJ nº 550/2024):** Institui a Política de Sustentabilidade do Poder Judiciário e conceitua formalmente os *Eventos de Capacitação* (incluindo palestras, seminários, congressos e simpósios) para fins de registro de frequência e indicadores de logística sustentável.
*   **Resolução CNJ nº 645/2025:** Disciplina a proteção de dados pessoais (LGPD) e os limites para captação, transmissão e gravação audiovisual durante a realização de *Audiências Públicas* e eventos abertos promovidos pelos Tribunais.
*   **Resolução CNJ nº 138/2011:** Estabelece as diretrizes para a convocação, condução e garantia de amplo acesso da sociedade civil às *Audiências e Consultas Públicas* do Judiciário.

#### 2.3. Governança, Inovação, Engenharia e Contabilidade Pública
*   **Resolução CNJ nº 395/2021 (FestLabs):** Institui a Política de Gestão da Inovação do Poder Judiciário, estimulando a construção colaborativa de soluções tecnológicas nos Laboratórios de Inovação.
*   **NBR ISO/IEC/IEEE 12207:** Norma técnica de Engenharia de Software que disciplina os processos do ciclo de vida do sistema, desde a concepção até a manutenção.
*   **NBC TSP 08 / CPC 04 (R1) & Manual de Contabilidade Aplicada ao Setor Público (MCASP/STN):** Regula a mensuração, valoração e amortização intangível do software como ativo patrimonial do Tribunal.

---

### 3. ARQUITETURA DE COMPATIBILIZAÇÃO COM O MONÓLITO CREPÚSCULO

A premissa fundamental da migração é que o **SOLENE deixa de ser uma aplicação autônoma para se tornar um módulo especializado derivado do domínio corporativo `Presença`** dentro do ecossistema Crepúsculo.

```
                     ECOSSISTEMA CREPÚSCULO (Monólito)
                                   │
         ┌─────────────────────────┼─────────────────────────┐
         ▼                         ▼                         ▼
   ┌───────────┐             ┌───────────┐             ┌───────────┐
   │ AC_PESSOA │             │ PRESENÇA  │             │  VISITE   │
   │ (Pessoa)  │             │ (Evento)  │             │ (Segur.)  │
   └─────┬─────┘             └─────┬─────┘             └─────┬─────┘
         │                         │                         │
         └───────────────────┐     │     ┌───────────────────┘
                             ▼     ▼     ▼
                    ┌─────────────────────────┐
                    │  MÓDULO CUSTOMIZADO:    │
                    │         SOLENE          │
                    │ (ParticipanteEvento,    │
                    │  Nominatas, Precedência,│
                    │  Assentos, Atas/AtaEv)  │
                    └─────────────────────────┘
```

#### 3.1. A Premissa Máxima: "Fonte Única da Verdade"
1.  **Reuso Absoluto da Entidade `Pessoa` (`AC_PESSOA.VW_VOLUNTARIO_PERFIL` / `PESSOA`):** O SOLENE **não possui base de dados própria de cadastro de pessoas**. Ele consome e estende a entidade corporativa `Pessoa` mantida pelo Crepúsculo (que unifica magistrados, servidores, colaboradores, estagiários, eleitores, autoridades externas e participantes do autocadastro).
2.  **Entidade Central `Presença`:** O registro de comparecimento físico e temporal pertence estritamente ao domínio corporativo `Presença`. O SOLENE estende essa entidade por meio da tabela relacional `ParticipanteEvento`, agregando exclusivamente os metadados protocolares necessários (categoria protocolar, cor de identificação, assento reservado, ordem na mesa de honra, status de nominata).
3.  **Matriz de Hierarquia Normativa e Técnica:**
    *   **Infraestrutura, Banco de Dados e Segurança:** As regras do ecossistema Crepúsculo (banco Oracle/PostgreSQL, autenticação SSO Authelia, controle de transações) **sobrepõem-se** às diretivas locais do SOLENE.
    *   **Identidade Visual e Protocolo:** A identidade visual do SOLENE (logomarca, tipografia, cores funcionais, ícones de linhas finas e templates de convites) **sobrepõe-se** à interface genérica do Crepúsculo no escopo do Cerimonial.

#### 3.2. Módulos do Crepúsculo Incorporados ao SOLENE
*   **Módulo Presença (Núcleo Operacional):** Compartilha a infraestrutura de criação de eventos, convites, confirmações e consolidação de listas de frequência em tempo real.
*   **Módulo Visite (Segurança Institucional Ativa):** No momento do credenciamento (via CPF ou QR Code), o SOLENE aciona o barramento do **Visite** para checar restrições de acesso. Em caso de impedimento, o sistema gera **alertas silenciosos** para o console da Segurança Institucional sem expor a autoridade na recepção.
*   **Módulo Autocadastro de Voluntários e Externos:** Utiliza a infraestrutura de links públicos e hashes seguros do Crepúsculo para que os convidados confirmem presença, atualizem dados e cadastrem **Acompanhantes** (seguranças, motoristas, assessores, familiares) ou designem **Representantes**.
*   **Módulo Notificações (SMS / WhatsApp / E-mail):** Gerencia a expedição eletrônica de convites individuais/lote e comunicados de confirmação.
*   **Autenticação SSO Authelia & Matriz ACL Dinâmica:** Acesso unificado via headers (`Remote-User`, `Remote-Groups`) com permissões granulares baseadas em perfis:
    *   `SOLENE-ADMIN`: Administrador do sistema / Gestor do Cerimonial (acesso global e parametrizações).
    *   `SOLENE_ORG`: Organizador da unidade / Cerimonialista (criação de eventos, pautas, edição de protocolo, geração de nominatas, atas e certidões).
    *   `SOLENE_RECEPÇÃO`: Recepcionista (credenciamento, busca híbrida, check-in e inclusões emergenciais).
    *   `SOLENE_APOIO` / `SOLENE_CONDUÇÃO`: Equipe de apoio ao plenário e orientação de assentos (recebe roteiros e mapas de assentos).
    *   `SOLENE_ORADOR`: Mestre de Cerimônias (acesso exclusivo ao gerador e leitor de Nominatas Incrementais).

---

### 4. REESTRUTURAÇÃO DO MAPA FUNCIONAL E EVOLUÇÃO DO SOLENE

Abaixo apresenta-se a reconstrução expandida da estrutura do arquivo `Funcionalidades_Solene.md`, incorporando as melhorias homologadas nas demonstrações e na reunião de produção do evento real de posse:

```
SOLENE (Módulo Customizado do Crepúsculo)
│
├── 1. Planejamento e Parametrização de Eventos
│   ├── 1.1 Cadastro de Eventos (Solenes e Não-Solenes)
│   ├── 1.2 Reutilização de Cadastros e Matriz Protocolar
│   ├── 1.3 Agenda Institucional Dinâmica de Autoridades e Órgãos
│   └── 1.4 Configuração de Perfis e Equipes de Apoio (Atas 04/2024 e 24/08/2026)
│
├── 2. Gestão de Convites, Confirmações e Autocadastro
│   ├── 2.1 Emissão de Convites Eletrônicos (Individuais e Lote)
│   ├── 2.2 Autocadastro Simplificado via Link/Hash Seguro
│   ├── 2.3 Gestão de Acompanhantes e Designação de Representantes
│   ├── 2.4 Importação Massiva de Dados (CSV / XLSX) e Validação CPF
│   └── 2.5 Modelos de Ofícios e Correspondências Parametrizadas (Markdown/PDF)
│
├── 3. Credenciamento Móvel, Acomodação e Segurança
│   ├── 3.1 Credenciamento Multimodal (QR Code, CPF, Nome)
│   ├── 3.2 Triagem Silenciosa de Segurança Integrada (API Visite)
│   ├── 3.3 Classificação e Entrega de Cartões por Cores Funcionais
│   └── 3.4 Layout de Plenário e Reserva de Mapa de Assentos
│
├── 4. Condução da Solenidade e Nominatas Inteligentes
│   ├── 4.1 Abertura Oficial e Marcos Temporais de Evento
│   ├── 4.2 Motor de Nominatas Incrementais (Destaque Vermelho/Cinza)
│   ├── 4.3 Algoritmo de Precedência Automatizado (Decreto nº 70.274/1972)
│   └── 4.4 Painel Operacional em Tempo Real para a Presidência
│
├── 5. Encerramento, Atas, Certidões e Memória Institucional
│   ├── 5.1 Bloqueio Pós-Encerramento e Imutabilidade (RN-005)
│   ├── 5.2 Emissão de Ata Oficial de Registro Histórico (Markdown/PDF-A)
│   ├── 5.3 Emissão de Certidão de Encerramento com Fé Pública (Diretoria-Geral)
│   └── 5.4 Acervo Histórico Permanente e Dicionário de Pesquisa
│
└── 6. Backlog de Evolução e Melhorias Pós-Operacionais (Solene-BL)
    ├── SOLENE-BL-001 a SOLENE-BL-010 (Melhorias de Interface e Regras)
    └── Encaminhamentos da Reunião de Produção de 17/09/2026
```

#### Detalhamento dos Módulos Funcionais Evoluídos:

##### MÓDULO 1: Planejamento e Parametrização do Evento
*   **Parametrização Flexível por Categoria:** Eventos classificados como "Solenidade" ou "Diplomação" ativam automaticamente os convites obrigatórios da Resolução nº 349/2002 e a matriz de precedência. Eventos de outras categorias (Audiências Públicas, Seminários, Reuniões) utilizam configurações simplificadas.
*   **Agenda Institucional Dinâmica de Autoridades:** Preserva a estrutura do cargo e do órgão/instituição de forma permanente, permitindo a substituição simples do ocupante sem perder o histórico do cargo em solenidades passadas.

##### MÓDULO 2: Gestão de Convites, Confirmações e Autocadastro
*   **Autocadastro Simplificado:** O convidado acessa o link do convite e preenche apenas `Nome, CPF, E-mail e Telefone`, realizando a validação automática na base de dados corporativa.
*   **Controle de Acompanhantes e Representantes:** O participante indica se comparecerá acompanhado por assessores/seguranças ou se designou um representante oficial, alimentando previamente a triagem da recepção.
*   **Importação Massiva (CSV/XLSX):** Ferramenta de carga rápida para importar planilhas do Cerimonial, realizando o *matching* por CPF ou criando pré-cadastros de participantes externos.

##### MÓDULO 3: Credenciamento Móvel, Acomodação e Segurança
*   **Check-in Responsivo Multimodal:** Operação em tablets e smartphones permitindo credenciamento em milissegundos via leitor de QR Code ou busca por Nome/CPF.
*   **Validação do Sistema Visite:** Consulta automática de restrições de acesso no momento do check-in. Caso haja restrição, a tela exibe um aviso velado para a recepcionista e notifica a Segurança Institucional por WebSocket.
*   **Sistema de Cores Funcionais:** Indicação visual e entrega de cartões coloridos para orientação no plenário:
    *   🔴 **Vermelho:** Magistrados, Desembargadores e Altas Autoridades.
    *   🔵 **Azul:** Autoridades Externas e Juízes.
    *   🟢 **Verde:** Homenageados, Empossandos e Diplomandos.
    *   🟡 **Amarelo:** Convidados Gerais e Familiares.

##### MÓDULO 4: Condução da Solenidade e Nominatas Inteligentes
*   **Motor de Nominatas Incrementais:** Permite ao cerimonialista gerar chamadas sucessivas de autoridades presentes. O sistema identifica quem fez check-in após o último marco temporal e os destaca em **Vermelho Alerta** (pendentes de anúncio), enquanto exibe as autoridades já anunciadas em **Cinza Itálico**.
*   **Ordem de Precedência Automatizada:** Ordenação rigorosa da Mesa de Honra e nominatas baseada no Decreto nº 70.274/1972 e antiguidade dos Desembargadores.
*   **Painel Presidencial em Tempo Real:** Dashboard para acompanhamento discreto da Mesa de Honra e do Plenário, com suporte a *tooltips* que exibem Nome, Cargo e Instituição ao posicionar o cursor sobre os assentos.

##### MÓDULO 5: Encerramento, Atas, Certidões e Memória Institucional
*   **Trava de Imutabilidade (RN-005):** Ao encerrar o evento, o sistema bloqueia qualquer alteração na lista de presenças ou assentos, garantindo a integridade auditável.
*   **Geração Automatizada de Ata e Certidão:** Emissão imediata dos documentos oficiais em Markdown e PDF/A assinado eletronicamente, alimentando o acervo histórico permanente do TRE-AC.

##### MÓDULO 6: Backlog de Evolução e Melhorias Pós-Operacionais (Solene-BL)
Mapeamento das melhorias levantadas na operação de produção do dia 17/09/2026:
*   `SOLENE-BL-001`: Implementação do estado explícito "Não comparecerá".
*   `SOLENE-BL-002`: Aperfeiçoamento da gestão de representantes de última hora na recepção.
*   `SOLENE-BL-003`: Inclusão coletiva em lote de servidores ativos do Tribunal.
*   `SOLENE-BL-004`: Tratamento definitivo de enconding UTF-8 para caracteres especiais.
*   `SOLENE-BL-005`: Melhoria da usabilidade e áreas de toque nos cartões para tablets.
*   `SOLENE-BL-006`: Ajuste fino de permissões de acesso por perfil ACL.
*   `SOLENE-BL-007`: Aperfeiçoamento da gestão de precedência customizada por evento.
*   `SOLENE-BL-008`: Consolidação da atualização contínua da Agenda de Autoridades.
*   `SOLENE-BL-009`: Preservação da matriz protocolar padrão independente de edições.
*   `SOLENE-BL-010`: Emissão do Relatório Físico de Contingência (Plano C) para impressão.

---

### 5. PLANO DE MIGRAÇÃO E RE-ENGENHARIA ESTRUTURAL

A transição da estrutura atual para o monólito Crepúsculo seguirá um plano rigoroso de re-engenharia para garantir a estabilidade do ambiente de produção.

#### 5.1. Mapeamento de Schemas do Banco de Dados
A modelagem relacional de 17 tabelas do SOLENE será mapeada diretamente para os schemas corporativos do Tribunal no **Oracle / PostgreSQL**:

| Entidade do SOLENE | Schema / Tabela Corporativa no Crepúsculo | Ação de Migração / Reuso |
| :--- | :--- | :--- |
| `Pessoa` | `AC_PESSOA.VW_VOLUNTARIO_PERFIL` / `PESSOA` | **Reuso Absoluto** (Sem duplicidade) |
| `Evento` | `PLANELEITO.EVENTO` | **Reuso** (Campos base estendidos) |
| `ParticipanteEvento` | `PLANELEITO.PARTICIPANTE_EVENTO` | **Customização/Extensão** (Atributos de cor e categoria) |
| `Presenca` | `PLANELEITO.PRESENCA` | **Reuso** (Registro de Timestamp e Operador) |
| `RestricaoVisite` | `VISITE.RESTRICAO` | **Integração por API / View** |
| `Assento` | `PLANELEITO.SOLENE_ASSENTO` | Tabela customizada mantida no schema |
| `MesaHonra` | `PLANELEITO.SOLENE_MESA_HONRA` | Tabela customizada mantida no schema |
| `Nominata` / `NominataItem` | `PLANELEITO.SOLENE_NOMINATA` | Tabela customizada mantida no schema |
| `AtaEvento` / `Certidao` | `PLANELEITO.SOLENE_ATA_EVENTO` | Tabela customizada mantida no schema |

#### 5.2. Estrutura de Pacotes PHP (Laravel 11)
A organização das classes no monólito Crepúsculo obedecerá ao namespace corporativo:
*   `App\Services\Cerimonial\NominataService`
*   `App\Services\Cerimonial\PrecedenciaService`
*   `App\Services\Cerimonial\AssentosService`
*   `App\Http\Controllers\Cerimonial\EventoCerimonialController`
*   `App\Repositories\Cerimonial\ParticipanteCerimonialRepository`

#### 5.3. Roadmap de Migração em 6 Fases
1.  **Fase 1 (Harmonização de Schemas):** Compatibilização das migrations e views para Oracle, conectando o SOLENE ao schema `AC_PESSOA` e `PLANELEITO`.
2.  **Fase 2 (Credenciamento & Visite):** Implementação das APIs do leitor móvel e integração de webhooks de segurança com o sistema Visite.
3.  **Fase 3 (Protocolo & Assentos):** Refatoração do motor de precedência (Decreto nº 70.274/1972) e mapa de assentos com cores funcionais.
4.  **Fase 4 (Nominatas & Real-Time):** Implementação do gerador de Nominatas Incrementais com WebSocket para atualização sub-segundo no painel do orador e presidência.
5.  **Fase 5 (Autocadastro & Notificações):** Integração do portal de autocadastro público de acompanhantes e motor de envios de convites via SMS/WhatsApp.
6.  **Fase 6 (Atas, Certidões e Memória):** Módulo de geração de Atas/Certidões em PDF/A, congelamento imutável e acervo histórico.

#### 5.4. Diretrizes de Testes e Homologação
Conforme apontado na avaliação técnica pós-evento real de posse, o processo de homologação exige:
*   **Testes Exaustivos de Front-End e UX Mobile:** Validação da usabilidade da interface em tablets e smartphones em cenários de credenciamento simultâneo na recepção.
*   **Testes de Carga e Logs no Banco Oracle:** Análise de performance da conexão Oracle em produção (em substituição ao SQLite de desenvolvimento).
*   **Testes de Webhooks e Resiliência de Apis:** Validação dos webhooks de comunicação entre SOLENE, CadÚnico, Visite e Presença, garantindo a operação sem travamentos mesmo em caso de falha temporária de rede.
*   **Planos de Contingência Mantidos:** Garantia de operação contínua por meio do **Plano A** (SOLENE Integrado), **Plano B** (Solução Legada) e **Plano C** (Relatórios Físicos de Contingência impressos).

---
*Documento compilado e padronizado para integração técnica e documental no ecossistema corporativo Crepúsculo do TRE-AC.*
