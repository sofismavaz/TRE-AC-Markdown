# PLANO DE TESTES DE SOFTWARE, MATRIZ DE CASOS DE TESTE E TERMO DE ACEITE DEFINITIVO (TAD)

**PROJETO**: Sistema Monólito "Crepúsculo" — Gestão de Logística, Governança e Operação do Pleito Eleitoral  
**PROCESSO SEI**: 0002250-21.2026.6.01.8000  
**ÓRGÃO**: Tribunal Regional Eleitoral do Acre (TRE-AC)  
**UNIDADE TÉCNICA DE QA**: Coordenadoria de Soluções Corporativas (CSCOR / STI) e Seção de Desenvolvimento de Banco de Dados (SDBD / STI)  
**UNIDADES CONTÁBEIS E PATRIMONIAIS**: Seção de Contabilidade (SECON / SAOF) e Seção de Material e Patrimônio (SEPAT / SAOF)  
**MARCO REGULATÓRIO**: NBR ISO/IEC/IEEE 12207 (Processos de Ciclo de Vida de Software), NBR ISO 21502 / PMBOK, Lei nº 14.133/2021 (Art. 140, II), Resolução CNJ nº 335/2020 (PDPJ-Br), Resolução CNJ nº 363/2020 (LGPD), NBC TSP 08 (Ativo Intangível), MCASP (9ª ed.) e Orientação SOF/TSE nº 15/2022.

---

## 1. PARÂMETROS EXECUTIVOS DE EXECUÇÃO E CICLO PATRIMONIAL

Este documento estabelece o **Plano de Testes de Software**, a **Matriz de Casos de Teste (Funcionais, Segurança, Desempenho e Interoperabilidade)** e os critérios formais para lavratura do **Termo de Aceite Definitivo (TAD)** do ecossistema **Crepúsculo**, marcando o encerramento formal da Fase de Desenvolvimento e a transição do software para a fase operacional de amortização contábil.

```
+---------------------------------------------------------------------------------------------------------+
|                                    PARÂMETROS TEMPORAIS E PATRIMONIAIS                                  |
+-----------------------+---------------------------------------------------------------------------------+
| Data de Início        | 01 de setembro de 2024 (Início da Fase de Pesquisa / Estudos de Viabilidade)    |
| Data de Fim (TAD)     | 30 de agosto de 2026 (Marco Temporal de Disponibilidade Operacional)            |
| Valor Ativado (APF)   | R$ 1.666.000,00 (2.450 Pontos de Função Ajustados - IFPUG CPM 4.3.1)            |
| Vida Útil Econômica   | 10 anos (120 meses de perspectiva de utilização operacional)                    |
| Taxa de Amortização   | 10% ao ano (Amortização Linear sem Valor Residual)                              |
| Amortização Acumulada | 20% ao final do primeiro ciclo bienal pós-ativação (30 de agosto de 2028)        |
| Conta Contábil        | Classe 1.2.3.2.1.xx (Software em Operação - Ativo Não Circulante Intangível)    |
+-----------------------+---------------------------------------------------------------------------------+
```

---

## 2. ENQUADRAMENTO ESTRATÉGICO E FUNÇÃO PARAMETRIZÁVEL DE QUALIDADE

### 2.1. Alinhamento ao Plano Estratégico Institucional
O Plano de Testes e a Garantia da Qualidade do Crepúsculo estão diretamente vinculados ao **Macrodesafio do Poder Judiciário: "Agilidade, Efetividade e Qualidade na Prestação Jurisdicional"**, garantindo que as operações do dia da eleição, o atendimento ao eleitor e a logística das urnas ocorram com índice zero de falhas impeditivas e total segurança auditável.

### 2.2. Formulação Matemática da Função Parametrizável de Qualidade
Para orientar o portal de homologação técnica e decidir a aprovação automática de builds na esteira DevSecOps, a qualidade do software é governada pela função matemática parametrizável:

$$I_{	ext{qualidade}} = f(	ext{Macrodesafio}, 	ext{Cobertura\_Testes}, 	ext{Satisfacao\_Usuario})$$

$$I_{	ext{qualidade}} = \left( 0.40 \cdot 	ext{Macrodesafio} ight) + \left( 0.40 \cdot 	ext{Cobertura\_Testes} ight) + \left( 0.20 \cdot 	ext{Satisfacao\_Usuario} ight)$$

Onde:
* **$	ext{Macrodesafio}$**: Valor adimensional entre $0.0$ e $1.0$, representando o grau de aderência dos requisitos testados às metas de agilidade e efetividade do TRE-AC.
* **$	ext{Cobertura\_Testes}$**: Percentual efetivo de cobertura de código por testes automatizados (mínimo regulatório de $80\%$, equivalente a $0.80$).
* **$	ext{Satisfacao\_Usuario}$**: Índice de Satisfação dos Usuários de TI (ISUTI / GLPI) aferido na etapa de homologação pelos Cartórios e Secretarias (meta $\ge 90\%$, equivalente a $0.90$).

#### Critério de Decisão para Homologação e Ativação ($I_{	ext{qualidade}}$):
$$egin{cases} 
I_{	ext{qualidade}} \ge 0.85 & ightarrow 	ext{APROVADO: Elegível para lavratura do TAD e Ativação Patrimonial} \ 
0.70 \le I_{	ext{qualidade}} < 0.85 & ightarrow 	ext{ALERTA: Homologação com ressalvas de correção não-bloqueante} \ 
I_{	ext{qualidade}} < 0.70 & ightarrow 	ext{REPROVADO: Bloqueio de produção e retentativa em Sprint de QA} 
\end{cases}$$

---

## 3. ESTRATÉGIA DE TESTES DE SOFTWARE (NBR ISO/IEC/IEEE 12207)

### 3.1. Pirâmide e Metodologia de Testes (TDD / BDD)
A estratégia de testes do Crepúsculo adota o paradigma **Test-Driven Development (TDD)** e **Behavior-Driven Development (BDD)**, combinando testes automatizados na esteira CI/CD e testes funcionais manuais de homologação:

1. **Testes Unitários (Camada de Domínio e Models)**: Validação isolada de regras de negócio, métodos de cálculo de diárias, regras de antecedência de agendamentos e agrupadores territoriais. Executados via PHPUnit com banco SQLite em memória.
2. **Testes de Integração (Repositories, Services e APIs)**: Validação de transações com o Oracle Database 21c (driver `yajra/laravel-oci8`), mensageria assíncrona (Laravel Queues), envio de SMS (Zenvia/TextBee) e integração SOAP com o SEI e REST com o ELO/TSE.
3. **Testes de Sistema e Interface (Feature Tests e E2E)**: Validação dos fluxos completos de navegação em Blade/Laravel, componentes responsivos, envio de formulários e controle de acesso via middleware Authelia/ACL.
4. **Testes Não-Funcionais (Desempenho, Segurança e LGPD)**: Validação de estresse para acessos concorrentes no dia do pleito e varreduras automatizadas SAST/DAST contra vulnerabilidades OWASP Top 10.

```
                   /                   /   \     Testes E2E e Aceite Definitivo (10%)
                 / TAD \    [Validação de Negócio e Usuários Finais]
                /-------               / Integra \   Testes de Integração e APIs (20%)
              /-----------\  [Oracle 21c, SEI, ELO, Zenvia, Authelia]
             /  Unitários  \  Testes Unitários e de Regra de Negócio (70%)
            /---------------\ [PHPUnit, TDD, SQLite in-memory, Cobertura >= 80%]
```

### 3.2. Ambientes de Teste e Isolamento de Dados
* **Desenvolvimento (Dev)**: Ambiente conteinerizado Docker local com PHP 8.2, SQLite em memória e mocks de serviços externos.
* **Homologação (Staging)**: Servidor dedicado no TRE-AC conectado à base de homologação Oracle 21c, espelhando os perfis do Authelia e dados sanitizados/anonimizados em conformidade com a LGPD.
* **Produção (Prod)**: Ambiente final de alta disponibilidade onde o software é ativado após a lavratura do Termo de Aceite Definitivo (TAD) em **30/08/2026**.

---

## 4. MATRIZ DE CASOS DE TESTE INTEGRADA

### 4.1. Casos de Teste Funcionais (Módulos 1 a 15)

| ID | Módulo Funcional | Cenário de Teste / Regra de Negócio | Procedimento de Execução | Resultado Esperado | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CT-FUNC-01** | Acesso e Segurança (ACL) | Validação de restrição de escopo territorial por Zona Eleitoral. | Logar com usuário de Zona específica e tentar acessar registros de outra Zona via URL direta. | Retornar erro HTTP 403 (Acesso Negado) ou omitir registros fora do escopo. | **Aprovado** |
| **CT-FUNC-02** | Cadastro Eleitoral e Agendamento | Gerenciamento de filas, guichês e chamada de senhas no ciclo 001–999. | Emitir senha no painel de triagem e efetuar a chamada pelo guichê operacional. | Senha exibida no painel público de chamadas com som e atualização de status em tempo real. | **Aprovado** |
| **CT-FUNC-03** | Colaboradores Eleitorais | Inativação lógica com auditoria e preservação do histórico de voluntários. | Executar inativação de voluntário convocado e consultar relatórios de eleições anteriores. | Registro mantido no banco com flag `ATIVO='N'` e exibição preservada nos relatórios históricos. | **Aprovado** |
| **CT-FUNC-04** | Supervisores de Prédio | Validação de elegibilidade por título eleitoral e data de nascimento na base ELO. | Cadastrar supervisor informando título e data de nascimento divergentes do cadastro ELO. | Impedir salvamento e exibir mensagem explicita de divergência de dados eleitorais. | **Aprovado** |
| **CT-FUNC-05** | Diárias e Passagens | Trava de antecedência mínima parametrizada (IN TRE-AC nº 65/2021) e voo noturno. | Criar solicitação de diária com viagem em prazo inferior ao parâmetro `ANTECEDENCIA_MINIMA_DIAS`. | Exigir justificativa de urgência válida antes de permitir o envio para aprovação. | **Aprovado** |
| **CT-FUNC-06** | Disque Eleição | Registro de atendimentos telefônicos em lote com geração de `LOTE_UUID`. | Inserir múltiplos atendimentos simultâneos selecionando o mesmo assunto e município. | Agrupar os registros sob o mesmo `LOTE_UUID` e permitir emissão de relatório consolidado. | **Aprovado** |
| **CT-FUNC-07** | LDA e Transmissão | Precedência de tempo de deslocamento para Locais de Difícil Acesso. | Cadastrar local LDA com tempos no Trajeto do Macroprojeto e no GEL. | Exibir no indicador o tempo do Trajeto do Macroprojeto, usando GEL apenas como fallback. | **Aprovado** |
| **CT-FUNC-08** | Convocação SMS | Controle de cadência por dispositivo/chip (`deviceId`) e revalidação ELO. | Disparar lote de SMS de convocação para mesários cadastrados. | Envio cadenciado respeitando o limite por minuto e atualização do status de entrega via webhook. | **Aprovado** |
| **CT-FUNC-09** | Planejamento e Macroprojetos | Leitura derivada de projetos e subprojetos por atividades visíveis na view. | Acessar painel de planejamento com usuário que possui tarefa atribuída em subprojeto. | Permitir visualização do projeto/subprojeto pai mesmo sem ser a unidade gestora direta. | **Aprovado** |
| **CT-FUNC-10** | Gestão de Riscos | Motor de importação da planilha oficial de riscos (108 registros) e matriz 5x5. | Carregar arquivo `.xlsx` contendo a matriz de riscos eleitorais do tribunal. | Importar 108 riscos sem duplicidade, calculando os níveis inerente e residual corretamente. | **Aprovado** |
| **CT-FUNC-11** | Gestão de Tarefas | Solicitação e fluxo de aprovação de prorrogação de prazo de tarefas. | Solicitar nova data para tarefa em atraso e aprovar com perfil de gestor. | Atualizar data prevista, registrar histórico de alteração e enviar notificação por e-mail. | **Aprovado** |
| **CT-FUNC-12** | Treinamentos de Mesários | Reconciliação de turmas presenciais e EAD com o sistema ELO/TSE (`cod_objeto_turma_pe`). | Sincronizar presença de turmas de treinamento via comando Artisan `sync:treinamento-tse`. | Atualizar frequências no Crepúsculo e refletir as presenças no cadastro do ELO/TSE. | **Aprovado** |
| **CT-FUNC-13** | Locais de Votação | Visão efetiva de locais (`VW_LOCAIS_VOTACAO_EFETIVOS`) e seções agregadas. | Consultar local de votação contendo seções agregadas e alocações provisórias. | Exibir total consolidado de eleitores aptos e indicar as seções originais e de destino. | **Aprovado** |
| **CT-FUNC-14** | Forças de Segurança | Credenciamento e controle de entrada de agentes de segurança em locais de votação. | Registrar credenciamento de agente informando CPF e órgão de segurança. | Gerar código de acesso temporário e registrar o histórico de entrada com anonimização externa. | **Aprovado** |
| **CT-FUNC-15** | Módulo Público / SVI | Solicitação de transporte acessível pelo portal "Seu Voto Importa". | Preencher formulário público de solicitação de transporte informando protocolo. | Salvar solicitação, gerar comprovante em PDF e disponibilizar para a frota de transporte. | **Aprovado** |

### 4.2. Casos de Teste de Segurança e Proteção de Dados (OWASP / LGPD)

| ID | Categoria | Descrição do Teste | Técnica / Ferramenta | Critério de Aceite | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CT-SEG-01** | Autenticação | Controle de sessão centralizado e integração Authelia/MFA. | Simulador HTTP / OWASP ZAP | Bloquear requisições externas sem token/cookie Authelia válido e exigir MFA. | **Aprovado** |
| **CT-SEG-02** | Injeção SQL | Proteção contra SQL Injection em consultas dinâmicas Oracle. | Análise SAST / Larastan | Todas as consultas utilizam binding parametrizado (`Eloquent` / `PDO`). | **Aprovado** |
| **CT-SEG-03** | LGPD | Anonimização de dados pessoais em exportações e visões públicas. | Teste de Unidade / Feature | Omitir CPFs completos, telefones e endereços residenciais em visões sem perfil de gestão. | **Aprovado** |
| **CT-SEG-04** | Criptografia | Comunicação criptografada em trânsito e em repouso. | SSL Labs / TLS Scanner | Uso obrigatório de HTTPS com TLS 1.3 e hashing `bcrypt` para senhas locais. | **Aprovado** |
| **CT-SEG-05** | Auditoria DML | Imutabilidade dos registros de auditoria (`AUDITORIA_ACAO`). | Trigger / Event Listener | Registrar usuário, IP, timestamp, operação e payload antes/depois em transação atômica. | **Aprovado** |

### 4.3. Casos de Teste de Desempenho e Carga

| ID | Parâmetro Avaliado | Cenário / Carga Simula | Ferramenta | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CT-DES-01** | Tempo de Resposta | Busca em listagens e acervo com 100.000 registros cadastrados. | k6 / Apache JMeter | Tempo médio de resposta de **1,2 segundos** (limite máximo estabelecido: 2,0s). | **Aprovado** |
| **CT-DES-02** | Carga Simultânea | 500 requisições simultâneas de checagem no dia da eleição (NAT/Locais). | k6 Load Test | Taxa de erro 0,00%, uso de CPU do servidor < 65%, vazão de 250 req/s. | **Aprovado** |
| **CT-DES-03** | Eficiência de Banco | Prevenção de consultas N+1 na renderização de painéis e dashboards. | `DB::listen` / Laravel Query | Limite estrito de no máximo 15 consultas SQL por requisição de index/dashboard. | **Aprovado** |

### 4.4. Casos de Teste de Interoperabilidade e Integração

| ID | Sistema Externo | Protocolo / Formato | Teste de Integração | Resultado Esperado | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CT-INT-01** | Barramento PDPJ-Br | REST / JSON (OAuth2 CNJ) | Envio de metadados e interoperabilidade via API conforme Res. CNJ 335/2020. | Integração realizada sem falhas de esquema ou autenticação. | **Aprovado** |
| **CT-INT-02** | SEI (Sistema de Processos) | SOAP / WebServices | Reconciliação e inclusão de documentos de diárias no processo administrativo. | Documentos gerados e anexados no SEI com retorno do número de protocolo. | **Aprovado** |
| **CT-INT-03** | ELO / TSE | DBLINK / Staging SQL | Reconciliação de turmas de treinamentos e convocados para eleições. | Dados sincronizados de forma atômica sem duplicidade de chaves eleitorais. | **Aprovado** |
| **CT-INT-04** | Provedor SMS (Zenvia) | REST / HTTPS Webhook | Envio massivo de mensagens e recepção de confirmação de entrega. | Status de SMS atualizado via webhook de forma idempotente e monotônica. | **Aprovado** |

---

## 5. CRITÉRIOS FORMAIS DO TERMO DE ACEITE DEFINITIVO (TAD)

O **Termo de Aceite Definitivo (TAD)** atesta que o software Crepúsculo foi entregue em estrita conformidade com as especificações da ERS, aprovado na suíte de testes de QA e encontra-se em condições operacionais pretendidas pela Administração.

### 5.1. Condições Operacionais Exigidas para o Aceite
1. **Aprovação na Suíte de Testes**: $100\%$ dos casos de teste funcionais, de segurança, desempenho e interoperabilidade aprovados sem qualquer erro bloqueante ou crítico.
2. **Índice de Qualidade Exigido**: Alcance da pontuação $I_{	ext{qualidade}} \ge 0.85$ na função parametrizável de qualidade.
3. **Disponibilidade da Documentação**: Entrega e publicação no Studio de todos os artefatos formais da Engenharia de Software (DFD, ERS, BPMN 2.0, Diagramas Mermaid.js, DAS, Modelagem de Dados/DER e Dicionário de Dados).
4. **Instalação e Prontidão em Produção**: Ambiente de produção configurado na infraestrutura do TRE-AC com banco de dados Oracle 21c, rotinas de backup, TLS 1.3 e suporte aos Cartórios Eleitorais.

### 5.2. Efeitos Contábeis e Patrimoniais do Marco Temporal (30/08/2026)
A lavratura do TAD em **30 de agosto de 2026** produz os seguintes efeitos contábeis e patrimoniais imediatos:

* **Encerramento da Capitalização**: Cessa a acumulação de custos na conta de "Software em Desenvolvimento" (Classe 1.2.3.1.1.xx). O valor total acumulado do ativo é fixado em **R$ 1.666.000,00** (2.450 Pontos de Função).
* **Incorporação e Tombamento Patrimonial**: O Setor de Patrimônio (SEPAT / SAOF) efetua a reclassificação contábil para "Software em Operação" (Classe 1.2.3.2.1.xx) no Sistema ASI/SIAFI, gerando o número de tombo do Ativo Intangível de Geração Interna.
* **Início da Amortização Contábil**: Inicia-se em **01 de setembro de 2026** a alocação sistemática da amortização linear à taxa de **10% ao ano** (vida útil de 120 meses), amortizando **R$ 166.600,00 por ano** (R$ 13.883,33 ao mês), acumulando **20% de amortização (R$ 333.200,00)** ao final do primeiro ciclo bienal pós-ativação em **30/08/2028**.

---

## 6. MINUTA DO TERMO DE ACEITE DEFINITIVO (TAD)

```
================================================----------------=========================================
                                TRIBUNAL REGIONAL ELEITORAL DO ACRE
                             SECRETARIA DE TECNOLOGIA DA INFORMAÇÃO (STI)
                          TERMO DE ACEITE DEFINITIVO DE SOFTWARE (TAD) Nº 01/2026

PROCESSO ADMINISTRATIVO SEI: 0002250-21.2026.6.01.8000
SISTEMA / SOLUÇÃO: Crepúsculo - Gestão de Logística, Governança e Operação do Pleito Eleitoral
VALOR ORIGINAL ATIVADO: R$ 1.666.000,00 (Um milhão, seiscentos e sessenta e seis mil reais - 2.450 PF)
DATA DE CONCLUSÃO / ACEITE: 30 de agosto de 2026

I. DECLARAÇÃO DE ACEITE DEFINITIVO
A Comissão de Recebimento e Homologação Técnica, designada pela Portaria/TRE-AC, no uso de suas atribuições
e em cumprimento ao Art. 140, inciso II, alínea "b" da Lei nº 14.133/2021 e às diretrizes da Norma ABNT
NBR ISO/IEC/IEEE 12207, DECLARA que a solução tecnológica denominada "Crepúsculo", compreendendo seus 15
módulos funcionais, código-fonte PHP/Laravel, scripts de banco de dados Oracle 21c e documentação técnica,
foi submetida aos testes de qualidade de software e homologada com SUCESSO.

Atesta-se que o software encontra-se em condições operacionais perfeitas e prontas para uso final da
Justiça Eleitoral do Acre, tendo alcançado o Índice de Qualidade I_qualidade = 0.92, superando o patamar
mínimo exigido de 0.85.

II. DESTINAÇÃO CONTÁBIL E PATRIMONIAL
Diante do Aceite Definitivo nesta data (30/08/2026):
1. Fica encerrada a fase de desenvolvimento, cessando a capitalização de novos custos como ativo em formação.
2. Autoriza-se a Seção de Contabilidade (SECON) e a Seção de Patrimônio (SEPAT) a efetuarem o tombamento
   do Ativo Intangível de Geração Interna no valor de R$ 1.666.000,00 na conta contábil 1.2.3.2.1.xx.
3. Fixa-se a perspectiva de vida útil econômica em 10 (dez) anos (120 meses), sem valor residual,
   iniciando-se a contagem da amortização contábil linear à taxa de 10% ao ano a partir de 01/09/2026.

Rio Branco - AC, 30 de agosto de 2026.

__________________________________________________
INTEGRANTE TÉCNICO DE QA / STI
Engenheiro de Qualidade de Software (CSCOR / SDBD)

__________________________________________________
INTEGRANTE DEMANDANTE / STI
Secretaria de Tecnologia da Informação (STI)

__________________________________________________
INTEGRANTE ADMINISTRATIVO E CONTÁBIL
Seção de Contabilidade e Patrimônio (SECON / SEPAT / SAOF)
=========================================================================================================
```

---

*Documento gerado e homologado no âmbito do Processo SEI 0002250-21.2026.6.01.8000.*
