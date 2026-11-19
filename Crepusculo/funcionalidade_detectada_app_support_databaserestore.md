# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_support_databaserestore`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 2  
> **Tamanho do Arquivo:** 35 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Support/DatabaseRestore/RestoreDataExporter.php`
## <APP_SUPPORT_DATABASERESTORE_RESTOREDATAEXPORTER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/DatabaseRestore/RestoreDataExporter.php`
- **Namespace Declaração:** `App\Support\DatabaseRestore`
- **Entidade / Classe:** `final class RestoreDataExporter`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
$query = DB::table($table);
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function exportReferenceTables(?string $directory = null): array
public function exportPrivateTables(?string $directory = null): array
private function cursorRows(string $table): iterable
private function normalizeRow(array $row): array
private function sanitizeReferenceRow(array $row): array
private function ensureDirectory(string $directory): void
private function writeManifest(string $path, array $tables, string $type): void
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\DatabaseRestore;

use DateTimeInterface;
use Illuminate\Support\Facades\DB;

final class RestoreDataExporter
{
    /**
     * @return array<string, int>
     */
    public function exportReferenceTables(?string $directory = null): array
    {
        $directory = $directory !== null && trim($directory) !== ''
            ? rtrim($directory, DIRECTORY_SEPARATOR)
            : RestoreTableManifest::referenceDataDirectory();

        $this->ensureDirectory($directory);

        $exported = [];
        foreach (RestoreTableManifest::referenceTables() as $table) {
            $rows = array_map(
                fn (array $row): array => $this->sanitizeReferenceRow($row),
                iterator_to_array($this->cursorRows($table), false),
            );
            file_put_contents(
                $directory . DIRECTORY_SEPARATOR . $table . '.json',
                json_encode($rows, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n",
            );
            $exported[$table] = count($rows);
        }

        $this->writeManifest($directory . DIRECTORY_SEPARATOR . 'manifest.json', $exported, 'reference');

        return $exported;
    }

    /**
     * @return array<string, int>
     */
    public function exportPrivateTables(?string $directory = null): array
    {
        $directory = $directory !== null && trim($directory) !== ''
            ? rtrim($directory, DIRECTORY_SEPARATOR)
            : RestoreTableManifest::privateDataDirectory();

        $this->ensureDirectory($directory);

        $exported = [];
        foreach (RestoreTableManifest::privateDataTables() as $table) {
            $path = $directory . DIRECTORY_SEPARATOR . $table . '.jsonl';
            $handle = fopen($path, 'wb');
            if ($handle === false) {
                throw new \RuntimeException("Nao foi possivel abrir arquivo para escrita: {$path}");
            }

            $count = 0;
            foreach ($this->cursorRows($table) as $row) {
                fwrite($handle, json_encode($row, JSON_UNESCAPED_UNICODE) . "\n");
                $count++;
            }

            fclose($handle);
            $exported[$table] = $count;
        }

        $this->writeManifest(dirname($directory) . DIRECTORY_SEPARATOR . 'private-manifest.json', $exported, 'private');

        return $exported;
    }

    /**
     * @return iterable<int, array<string, mixed>>
     */
    private function cursorRows(string $table): iterable
    {
        $query = DB::table($table);
        foreach (RestoreTableManifest::primaryKeyFor($table) as $column) {
            $query->orderBy($column);
        }

        foreach ($query->cursor() as $row) {
            yield $this->normalizeRow((array) $row);
        }
    }

    /**
     * @param array<string, mixed> $row
     * @return array<string, mixed>
     */
    private const REFERENCE_IGNORED_COLUMNS = [
        'usuario_criacao',
        'usuario_nome_criacao',
        'usuario_atualizacao',
        'usuario_nome_atualizacao',
    ];

    private function normalizeRow(array $row): array
    {
        $normalized = [];
        foreach ($row as $key => $value) {
            if ($value instanceof DateTimeInterface) {
                $value = $value->format('Y-m-d H:i:s');
            }

            $normalized[strtolower((string) $key)] = $value;
        }

        return $normalized;
    }

    private function sanitizeReferenceRow(array $row): array
    {
        return array_diff_key($row, array_flip(self::REFERENCE_IGNORED_COLUMNS));
    }

    private function ensureDirectory(string $directory): void
    {
        if (!is_dir($directory) && !mkdir($directory, 0775, true) && !is_dir($directory)) {
            throw new \RuntimeException("Nao foi possivel criar diretorio: {$directory}");
        }
    }

    /**
     * @param array<string, int> $tables
     */
    private function writeManifest(string $path, array $tables, string $type): void
    {
        file_put_contents($path, json_encode([
            'generated_at' => date('c'),
            'type' => $type,
            'tables' => array_map(
                static fn (string $table, int $rows): array => ['table' => $table, 'rows' => $rows],
                array_keys($tables),
                array_values($tables),
            ),
        ], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n");
    }
}
```
</APP_SUPPORT_DATABASERESTORE_RESTOREDATAEXPORTER_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/DatabaseRestore/RestoreTableManifest.php`
## <APP_SUPPORT_DATABASERESTORE_RESTORETABLEMANIFEST_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/DatabaseRestore/RestoreTableManifest.php`
- **Namespace Declaração:** `App\Support\DatabaseRestore`
- **Entidade / Classe:** `final class RestoreTableManifest`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function allTables(): array
public static function referenceTables(): array
public static function privateDataTables(): array
public static function syncTables(): array
public static function ignoredTables(): array
public static function primaryKeys(): array
public static function primaryKeyFor(string $table): array
public static function sourceRowCounts(): array
public static function sourceRowCountFor(string $table): int
public static function referenceDataDirectory(): string
public static function referenceDataPath(string $table): string
public static function privateDataDirectory(): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\DatabaseRestore;

final class RestoreTableManifest
{
    /** @var array<int, string> */
    private const ALL_TABLES = array (
  0 => 'acesso',
  1 => 'adm_acesso_rota',
  2 => 'adm_acesso_rota_grupo',
  3 => 'adm_grupo_acesso',
  4 => 'adm_grupo_macroprojeto',
  5 => 'auditoria_acao',
  6 => 'bairro',
  7 => 'cache',
  8 => 'cache_locks',
  9 => 'cad_agendamento',
  10 => 'cad_bloqueio_agenda',
  11 => 'cad_convocacao_mesario_tse',
  12 => 'cad_documento',
  13 => 'cad_eleitor',
  14 => 'cad_fila_config_unidade',
  15 => 'cad_fila_contador_unidade',
  16 => 'cad_fila_evento',
  17 => 'cad_fila_painel_evento',
  18 => 'cad_fila_prioridade',
  19 => 'cad_fila_senha',
  20 => 'cad_funcionamento_unidade',
  21 => 'cad_guiche',
  22 => 'cad_pesquisa_satisfacao',
  23 => 'cad_regra_unidade',
  24 => 'cad_restricao_serv_periodo',
  25 => 'cad_servico',
  26 => 'cad_servico_documento',
  27 => 'cad_servico_guiche',
  28 => 'cad_slot_agenda',
  29 => 'cad_supervisor_banco',
  30 => 'cad_supervisor_pergunta',
  31 => 'cad_supervisor_predio',
  32 => 'cad_supervisor_predio_notificacao',
  33 => 'cad_supervisor_resposta',
  34 => 'cad_tipo_guiche',
  35 => 'cad_unidade',
  36 => 'cargos_equipe',
  37 => 'categoria_tarefa',
  38 => 'ce_candidatura_colaborador',
  39 => 'ce_candidatura_notificacao',
  40 => 'ce_evento_voluntario',
  41 => 'ce_evento_voluntario_agenda',
  42 => 'ce_evento_voluntario_participante',
  43 => 'ce_evento_voluntario_status',
  44 => 'ce_processo_eleitoral',
  45 => 'ce_selecao_escala',
  46 => 'ce_voluntario_email_confirmacao',
  47 => 'eleitor',
  48 => 'energia',
  49 => 'equipe',
  50 => 'equipe_vinculo',
  51 => 'esfera',
  52 => 'estado_tarefa',
  53 => 'failed_jobs',
  54 => 'fase_tarefa',
  55 => 'grupo_unidade',
  56 => 'grupo_unidade_membro',
  57 => 'internet',
  58 => 'jobs',
  59 => 'job_batches',
  60 => 'lda',
  61 => 'lda_ativo_glpi',
  62 => 'lda_deslocamento',
  63 => 'lda_situacao_mesario',
  64 => 'lda_situacao_opcao',
  65 => 'lda_trajeto',
  66 => 'lda_trajeto_trecho',
  67 => 'lda_vistoria_transmissao',
  68 => 'lda_vistoria_transmissao_sinal',
  69 => 'local_transmissao',
  70 => 'local_votacao_st',
  71 => 'local_votacao_vagas',
  72 => 'macroprojeto',
  73 => 'macroprojeto_turno',
  74 => 'migrations',
  75 => 'municipio',
  76 => 'nat_externo_desafio_login',
  77 => 'nat_externo_evento',
  78 => 'nat_externo_macroprojeto',
  79 => 'nat_ocorrencia',
  80 => 'nat_ocorrencia_evento',
  81 => 'nat_ocorrencia_mesario_publico',
  82 => 'nat_rota_conversa',
  83 => 'nat_rota_mensagem',
  84 => 'nat_rota_mensagem_leitura',
  85 => 'nat_status_ocorrencia',
  86 => 'nat_tipo_ocorrencia',
  87 => 'opcao_binaria',
  88 => 'operadora',
  89 => 'password_reset_tokens',
  90 => 'projeto',
  91 => 'qualidade',
  92 => 'rcand_cand_processos',
  93 => 'rcand_consolidado_processos',
  94 => 'rcand_pje_processos',
  95 => 'risco',
  96 => 'risco_alvo',
  97 => 'rota',
  98 => 'rota_local',
  99 => 'secao_alocacao_provisoria',
  100 => 'secoes',
  101 => 'secoes_agregadas',
  102 => 'sessions',
  103 => 'subprojeto',
  104 => 'subprojeto_impacto',
  105 => 'tarefa',
  106 => 'tarefa_alerta_agendamento',
  107 => 'tarefa_alerta_auditoria',
  108 => 'tarefa_alerta_execucao',
  109 => 'tarefa_alerta_execucao_destinatario',
  110 => 'tarefa_alerta_execucao_dest_tarefa',
  111 => 'tarefa_alerta_execucao_tentativa',
  112 => 'tarefa_andamento',
  113 => 'tarefa_lote',
  114 => 'tarefa_solicitacao_prazo',
  115 => 'tbldaacesso',
  116 => 'tbldaenergia',
  117 => 'tbtransmissaovotacao',
  118 => 'tipo_sinal',
  119 => 'tipo_tomada',
  120 => 'treinamento',
  121 => 'treinamento_tse_convocado',
  122 => 'treinamento_tse_turma',
  123 => 'users',
  124 => 'zona',
  125 => 'rcand_candexweb_pedidos',
  126 => 'rcand_candexweb_candidatos',
  127 => 'ce_voluntario_exclusao',
  128 => 'disque_eleicao_assunto',
  129 => 'disque_eleicao_atendimento',
  130 => 'ce_sms_campo_variavel',
  131 => 'ce_sms_modelo_situacao',
  132 => 'ce_sms_envio_status',
  133 => 'ce_sms_modelo',
  134 => 'ce_sms_lote',
  135 => 'ce_sms_lote_item',
  136 => 'ce_sms_envio',
  137 => 'ce_sms_envio_evento',
  147 => 'ce_sms_resposta',
  140 => 'rcand_partido',
  141 => 'rcand_cand_proc_partido',
  142 => 'rcand_cw_pedido_partido',
  143 => 'ce_sms_telefone_manual',
  144 => 'mrj',
  145 => 'mrj_sync_stage',
  146 => 'local_votacao_deslocamento',
  148 => 'nat_vistoria_secao_pergunta',
  149 => 'nat_vistoria_secao',
  150 => 'nat_vistoria_secao_resposta',
  151 => 'disque_eleicao_domicilio_extra',
  152 => 'svi_solicitante_tipo',
  153 => 'svi_contato_preferencia',
  154 => 'svi_condicao',
  155 => 'svi_equipamento',
  156 => 'svi_solicitacao_status',
  157 => 'svi_turno_status',
  158 => 'svi_configuracao',
  159 => 'svi_solicitacao',
  160 => 'svi_solicitacao_condicao',
  161 => 'svi_solicitacao_equip',
  162 => 'svi_solicitacao_turno',
  163 => 'svi_anexo',
  164 => 'svi_historico',
  165 => 'svi_acesso_desafio',
  166 => 'svi_notificacao',
  167 => 'rota_transmissao_vinculo',
  168 => 'jecmon_kit_online',
  169 => 'jecmon_kit_online_sync',
  170 => 'scde_configuracao',
  171 => 'scde_secao_situacao',
  172 => 'ca_registro_status',
  173 => 'ca_atendimento_tipo',
  174 => 'ca_ocorrencia_tipo',
  175 => 'ca_registro_configuracao',
  176 => 'ca_registro_eleicao',
  177 => 'ca_registro_atendimento',
  178 => 'ca_registro_ocorrencia',
  179 => 'ca_registro_historico',
);

    /** @var array<int, string> */
    private const REFERENCE_TABLES = array (
  0 => 'acesso',
  1 => 'adm_grupo_acesso',
  2 => 'adm_acesso_rota',
  3 => 'macroprojeto',
  4 => 'adm_grupo_macroprojeto',
  5 => 'adm_acesso_rota_grupo',
  6 => 'macroprojeto_turno',
  7 => 'zona',
  8 => 'municipio',
  9 => 'cad_unidade',
  10 => 'opcao_binaria',
  11 => 'qualidade',
  12 => 'operadora',
  13 => 'tipo_sinal',
  14 => 'tipo_tomada',
  15 => 'esfera',
  16 => 'energia',
  17 => 'internet',
  18 => 'cad_tipo_guiche',
  19 => 'cad_fila_prioridade',
  20 => 'cad_documento',
  21 => 'cad_servico',
  22 => 'cad_servico_documento',
  23 => 'cad_guiche',
  24 => 'cad_servico_guiche',
  25 => 'cad_funcionamento_unidade',
  26 => 'cad_fila_config_unidade',
  27 => 'cad_regra_unidade',
  28 => 'cad_restricao_serv_periodo',
  29 => 'cad_bloqueio_agenda',
  30 => 'cad_supervisor_banco',
  31 => 'cad_supervisor_pergunta',
  32 => 'cargos_equipe',
  33 => 'categoria_tarefa',
  34 => 'estado_tarefa',
  35 => 'fase_tarefa',
  36 => 'ce_evento_voluntario_status',
  37 => 'grupo_unidade',
  38 => 'grupo_unidade_membro',
  39 => 'lda_situacao_opcao',
  40 => 'nat_status_ocorrencia',
  41 => 'nat_tipo_ocorrencia',
  42 => 'nat_externo_macroprojeto',
  43 => 'disque_eleicao_assunto',
  44 => 'ce_sms_campo_variavel',
  45 => 'ce_sms_modelo_situacao',
  46 => 'ce_sms_envio_status',
  47 => 'nat_vistoria_secao_pergunta',
  48 => 'disque_eleicao_domicilio_extra',
  49 => 'svi_solicitante_tipo',
  50 => 'svi_contato_preferencia',
  51 => 'svi_condicao',
  52 => 'svi_equipamento',
  53 => 'svi_solicitacao_status',
  54 => 'svi_turno_status',
  55 => 'ca_registro_status',
  56 => 'ca_atendimento_tipo',
  57 => 'ca_ocorrencia_tipo',
);

    /** @var array<int, string> */
    private const PRIVATE_DATA_TABLES = array (
  0 => 'auditoria_acao',
  1 => 'cad_eleitor',
  2 => 'cad_fila_contador_unidade',
  3 => 'cad_fila_senha',
  4 => 'cad_pesquisa_satisfacao',
  5 => 'cad_slot_agenda',
  6 => 'cad_supervisor_predio',
  7 => 'ce_voluntario_email_confirmacao',
  8 => 'equipe_vinculo',
  9 => 'lda',
  10 => 'lda_vistoria_transmissao',
  11 => 'local_transmissao',
  12 => 'nat_externo_desafio_login',
  13 => 'nat_externo_evento',
  14 => 'projeto',
  15 => 'risco',
  16 => 'rota',
  17 => 'tarefa_alerta_agendamento',
  18 => 'tarefa_alerta_auditoria',
  19 => 'tarefa_lote',
  20 => 'treinamento',
  21 => 'cad_agendamento',
  22 => 'cad_fila_evento',
  23 => 'cad_fila_painel_evento',
  24 => 'cad_supervisor_predio_notificacao',
  25 => 'cad_supervisor_resposta',
  26 => 'equipe',
  27 => 'lda_ativo_glpi',
  28 => 'lda_deslocamento',
  29 => 'lda_situacao_mesario',
  30 => 'lda_trajeto',
  31 => 'lda_trajeto_trecho',
  32 => 'lda_vistoria_transmissao_sinal',
  33 => 'nat_ocorrencia',
  34 => 'nat_rota_conversa',
  35 => 'rota_local',
  36 => 'subprojeto',
  37 => 'tarefa_alerta_execucao',
  38 => 'tbldaacesso',
  39 => 'tbldaenergia',
  40 => 'tbtransmissaovotacao',
  41 => 'ce_processo_eleitoral',
  42 => 'nat_ocorrencia_evento',
  43 => 'nat_ocorrencia_mesario_publico',
  44 => 'nat_rota_mensagem',
  45 => 'subprojeto_impacto',
  46 => 'tarefa',
  47 => 'tarefa_alerta_execucao_destinatario',
  48 => 'ce_candidatura_colaborador',
  49 => 'ce_evento_voluntario',
  50 => 'ce_selecao_escala',
  51 => 'nat_rota_mensagem_leitura',
  52 => 'risco_alvo',
  53 => 'tarefa_alerta_execucao_dest_tarefa',
  54 => 'tarefa_alerta_execucao_tentativa',
  55 => 'tarefa_andamento',
  56 => 'tarefa_solicitacao_prazo',
  57 => 'ce_candidatura_notificacao',
  58 => 'ce_evento_voluntario_agenda',
  59 => 'ce_evento_voluntario_participante',
  60 => 'ce_voluntario_exclusao',
  61 => 'disque_eleicao_atendimento',
  62 => 'ce_sms_modelo',
  63 => 'ce_sms_lote',
  64 => 'ce_sms_lote_item',
  65 => 'ce_sms_envio',
  66 => 'ce_sms_envio_evento',
  69 => 'ce_sms_resposta',
  68 => 'ce_sms_telefone_manual',
  67 => 'local_votacao_deslocamento',
  70 => 'nat_vistoria_secao',
  71 => 'nat_vistoria_secao_resposta',
  72 => 'svi_configuracao',
  73 => 'svi_solicitacao',
  74 => 'svi_solicitacao_condicao',
  75 => 'svi_solicitacao_equip',
  76 => 'svi_solicitacao_turno',
  77 => 'svi_anexo',
  78 => 'svi_historico',
  79 => 'svi_acesso_desafio',
  80 => 'svi_notificacao',
  81 => 'rota_transmissao_vinculo',
  82 => 'scde_configuracao',
  83 => 'ca_registro_configuracao',
  84 => 'ca_registro_eleicao',
  85 => 'ca_registro_atendimento',
  86 => 'ca_registro_ocorrencia',
  87 => 'ca_registro_historico',
);

    /** @var array<int, string> */
    private const SYNC_TABLES = array (
  0 => 'bairro',
  1 => 'cad_convocacao_mesario_tse',
  2 => 'eleitor',
  3 => 'local_votacao_st',
  4 => 'local_votacao_vagas',
  5 => 'secao_alocacao_provisoria',
  6 => 'secoes',
  7 => 'secoes_agregadas',
  8 => 'rcand_cand_processos',
  9 => 'rcand_consolidado_processos',
  10 => 'rcand_pje_processos',
  11 => 'treinamento_tse_convocado',
  12 => 'treinamento_tse_turma',
  13 => 'rcand_candexweb_pedidos',
  14 => 'rcand_candexweb_candidatos',
  15 => 'rcand_partido',
  16 => 'rcand_cand_proc_partido',
  17 => 'rcand_cw_pedido_partido',
  18 => 'mrj',
  19 => 'jecmon_kit_online',
  20 => 'jecmon_kit_online_sync',
  21 => 'scde_secao_situacao',
);

    /** @var array<int, string> */
    private const IGNORED_TABLES = array (
  0 => 'cache',
  1 => 'cache_locks',
  2 => 'failed_jobs',
  3 => 'jobs',
  4 => 'job_batches',
  5 => 'migrations',
  6 => 'password_reset_tokens',
  7 => 'sessions',
  8 => 'users',
  9 => 'mrj_sync_stage',
);

    /** @var array<string, array<int, string>> */
    private const PRIMARY_KEYS = array (
  'ca_registro_status' => array (0 => 'codigo'),
  'ca_atendimento_tipo' => array (0 => 'codigo'),
  'ca_ocorrencia_tipo' => array (0 => 'codigo'),
  'ca_registro_configuracao' => array (0 => 'id'),
  'ca_registro_eleicao' => array (0 => 'id'),
  'ca_registro_atendimento' => array (0 => 'id'),
  'ca_registro_ocorrencia' => array (0 => 'id'),
  'ca_registro_historico' => array (0 => 'id'),
  'jecmon_kit_online' => array (0 => 'codigo_processo_eleitoral', 1 => 'kit_id'),
  'jecmon_kit_online_sync' => array (0 => 'codigo_processo_eleitoral'),
  'scde_configuracao' => array (0 => 'id'),
  'scde_secao_situacao' => array (
    0 => 'cod_pleito',
    1 => 'cod_eleicao',
    2 => 'sg_ue_uf',
    3 => 'nr_zona',
    4 => 'nr_secao',
    5 => 'cd_tipo_cargo_pergunta',
  ),
  'svi_solicitante_tipo' => array (0 => 'codigo'),
  'svi_contato_preferencia' => array (0 => 'codigo'),
  'svi_condicao' => array (0 => 'codigo'),
  'svi_equipamento' => array (0 => 'codigo'),
  'svi_solicitacao_status' => array (0 => 'codigo'),
  'svi_turno_status' => array (0 => 'codigo'),
  'svi_configuracao' => array (0 => 'id'),
  'svi_solicitacao' => array (0 => 'id'),
  'svi_solicitacao_condicao' => array (0 => 'solicitacao_id', 1 => 'condicao_codigo'),
  'svi_solicitacao_equip' => array (0 => 'solicitacao_id', 1 => 'equipamento_codigo'),
  'svi_solicitacao_turno' => array (0 => 'id'),
  'svi_anexo' => array (0 => 'id'),
  'svi_historico' => array (0 => 'id'),
  'svi_acesso_desafio' => array (0 => 'id'),
  'svi_notificacao' => array (0 => 'id'),
  'nat_vistoria_secao_pergunta' =>
  array (
    0 => 'id',
  ),
  'nat_vistoria_secao' =>
  array (
    0 => 'id',
  ),
  'nat_vistoria_secao_resposta' =>
  array (
    0 => 'id',
  ),
  'ce_sms_telefone_manual' =>
  array (
    0 => 'id',
  ),
  'mrj' =>
  array (
    0 => 'cod_objeto',
  ),
  'local_votacao_deslocamento' =>
  array (
    0 => 'id',
  ),
  'acesso' => 
  array (
    0 => 'id',
  ),
  'adm_acesso_rota' => 
  array (
    0 => 'id',
  ),
  'adm_acesso_rota_grupo' => 
  array (
    0 => 'id',
  ),
  'adm_grupo_acesso' => 
  array (
    0 => 'id',
  ),
  'adm_grupo_macroprojeto' => 
  array (
    0 => 'id',
  ),
  'auditoria_acao' => 
  array (
    0 => 'id',
  ),
  'cache' => 
  array (
    0 => 'key',
  ),
  'cache_locks' => 
  array (
    0 => 'key',
  ),
  'cad_agendamento' => 
  array (
    0 => 'id_agendamento',
  ),
  'cad_bloqueio_agenda' => 
  array (
    0 => 'id_bloqueio',
  ),
  'cad_convocacao_mesario_tse' => 
  array (
    0 => 'id_convocacao_mesario_tse',
  ),
  'cad_documento' => 
  array (
    0 => 'id_documento',
  ),
  'cad_eleitor' => 
  array (
    0 => 'id_eleitor',
  ),
  'cad_fila_config_unidade' => 
  array (
    0 => 'id_unidade',
  ),
  'cad_fila_contador_unidade' => 
  array (
    0 => 'id_unidade',
  ),
  'cad_fila_evento' => 
  array (
    0 => 'id_fila_evento',
  ),
  'cad_fila_painel_evento' => 
  array (
    0 => 'id_painel_evento',
  ),
  'cad_fila_prioridade' => 
  array (
    0 => 'id_prioridade',
  ),
  'cad_fila_senha' => 
  array (
    0 => 'id_fila_senha',
  ),
  'cad_funcionamento_unidade' => 
  array (
    0 => 'id_funcionamento',
  ),
  'cad_guiche' => 
  array (
    0 => 'id_guiche',
  ),
  'cad_pesquisa_satisfacao' => 
  array (
    0 => 'id_pesquisa_satisfacao',
  ),
  'cad_regra_unidade' => 
  array (
    0 => 'id_unidade',
  ),
  'cad_restricao_serv_periodo' => 
  array (
    0 => 'id_restricao',
  ),
  'cad_servico' => 
  array (
    0 => 'id_servico',
  ),
  'cad_servico_documento' => 
  array (
    0 => 'id_servico',
    1 => 'id_documento',
  ),
  'cad_servico_guiche' => 
  array (
    0 => 'id_servico',
    1 => 'id_guiche',
  ),
  'cad_slot_agenda' => 
  array (
    0 => 'id_slot',
  ),
  'cad_supervisor_banco' => 
  array (
    0 => 'id_supervisor_banco',
  ),
  'cad_supervisor_pergunta' => 
  array (
    0 => 'id_supervisor_pergunta',
  ),
  'cad_supervisor_predio' => 
  array (
    0 => 'id_supervisor_predio',
  ),
  'cad_supervisor_predio_notificacao' => 
  array (
    0 => 'id_notificacao',
  ),
  'cad_supervisor_resposta' => 
  array (
    0 => 'id_supervisor_resposta',
  ),
  'cad_tipo_guiche' => 
  array (
    0 => 'id_tipo_guiche',
  ),
  'cad_unidade' => 
  array (
    0 => 'id_unidade',
  ),
  'cargos_equipe' => 
  array (
    0 => 'id',
  ),
  'ce_sms_campo_variavel' =>
  array (
    0 => 'codigo',
  ),
  'ce_sms_modelo_situacao' =>
  array (
    0 => 'codigo',
  ),
  'ce_sms_envio_status' =>
  array (
    0 => 'codigo',
  ),
  'ce_sms_modelo' =>
  array (
    0 => 'id',
  ),
  'ce_sms_lote' =>
  array (
    0 => 'id',
  ),
  'ce_sms_lote_item' =>
  array (
    0 => 'id',
  ),
  'ce_sms_envio' =>
  array (
    0 => 'id',
  ),
  'ce_sms_envio_evento' =>
  array (
    0 => 'id',
  ),
  'ce_sms_resposta' =>
  array (
    0 => 'id',
  ),
  'categoria_tarefa' => 
  array (
    0 => 'id',
  ),
  'ce_candidatura_colaborador' => 
  array (
    0 => 'id',
  ),
  'ce_candidatura_notificacao' => 
  array (
    0 => 'id',
  ),
  'ce_evento_voluntario' => 
  array (
    0 => 'id',
  ),
  'ce_evento_voluntario_agenda' => 
  array (
    0 => 'id',
  ),
  'ce_evento_voluntario_participante' => 
  array (
    0 => 'id',
  ),
  'ce_evento_voluntario_status' => 
  array (
    0 => 'codigo',
  ),
  'ce_processo_eleitoral' => 
  array (
    0 => 'id',
  ),
  'ce_selecao_escala' => 
  array (
    0 => 'id',
  ),
  'ce_voluntario_email_confirmacao' => 
  array (
    0 => 'id',
  ),
  'ce_voluntario_exclusao' =>
  array (
    0 => 'id',
  ),
  'disque_eleicao_assunto' =>
  array (
    0 => 'id',
  ),
  'disque_eleicao_domicilio_extra' =>
  array (
    0 => 'id',
  ),
  'disque_eleicao_atendimento' =>
  array (
    0 => 'id',
  ),
  'energia' => 
  array (
    0 => 'id',
  ),
  'equipe' => 
  array (
    0 => 'id',
  ),
  'equipe_vinculo' => 
  array (
    0 => 'id',
  ),
  'esfera' => 
  array (
    0 => 'id',
  ),
  'estado_tarefa' => 
  array (
    0 => 'id',
  ),
  'failed_jobs' => 
  array (
    0 => 'id',
  ),
  'fase_tarefa' => 
  array (
    0 => 'id',
  ),
  'grupo_unidade' => 
  array (
    0 => 'id',
  ),
  'grupo_unidade_membro' => 
  array (
    0 => 'id',
  ),
  'internet' => 
  array (
    0 => 'id',
  ),
  'jobs' => 
  array (
    0 => 'id',
  ),
  'job_batches' => 
  array (
    0 => 'id',
  ),
  'lda' => 
  array (
    0 => 'id',
  ),
  'lda_ativo_glpi' => 
  array (
    0 => 'id',
  ),
  'lda_deslocamento' => 
  array (
    0 => 'id',
  ),
  'lda_situacao_mesario' => 
  array (
    0 => 'id',
  ),
  'lda_situacao_opcao' => 
  array (
    0 => 'id',
  ),
  'lda_trajeto' =>
  array (
    0 => 'id',
  ),
  'lda_trajeto_trecho' => 
  array (
    0 => 'id',
  ),
  'lda_vistoria_transmissao' => 
  array (
    0 => 'id',
  ),
  'lda_vistoria_transmissao_sinal' => 
  array (
    0 => 'id',
  ),
  'local_transmissao' => 
  array (
    0 => 'id',
  ),
  'local_votacao_st' => 
  array (
    0 => 'cod_objeto',
  ),
  'macroprojeto' => 
  array (
    0 => 'id',
  ),
  'macroprojeto_turno' => 
  array (
    0 => 'id',
  ),
  'migrations' => 
  array (
    0 => 'id',
  ),
  'municipio' => 
  array (
    0 => 'id',
  ),
  'nat_externo_desafio_login' => 
  array (
    0 => 'id',
  ),
  'nat_externo_evento' => 
  array (
    0 => 'id',
  ),
  'nat_externo_macroprojeto' => 
  array (
    0 => 'id',
  ),
  'nat_ocorrencia' => 
  array (
    0 => 'id_ocorrencia',
  ),
  'nat_ocorrencia_evento' => 
  array (
    0 => 'id_ocorrencia_evento',
  ),
  'nat_ocorrencia_mesario_publico' => 
  array (
    0 => 'id_ocorrencia_mesario_publico',
  ),
  'nat_rota_conversa' => 
  array (
    0 => 'id',
  ),
  'nat_rota_mensagem' => 
  array (
    0 => 'id',
  ),
  'nat_rota_mensagem_leitura' => 
  array (
    0 => 'id',
  ),
  'nat_status_ocorrencia' => 
  array (
    0 => 'id_status',
  ),
  'nat_tipo_ocorrencia' => 
  array (
    0 => 'id_tipo_ocorrencia',
  ),
  'opcao_binaria' => 
  array (
    0 => 'id',
  ),
  'operadora' => 
  array (
    0 => 'id',
  ),
  'password_reset_tokens' => 
  array (
    0 => 'email',
  ),
  'projeto' => 
  array (
    0 => 'id',
  ),
  'qualidade' => 
  array (
    0 => 'id',
  ),
  'risco' => 
  array (
    0 => 'id',
  ),
  'risco_alvo' => 
  array (
    0 => 'id',
  ),
  'rcand_candexweb_candidatos' =>
  array (
    0 => 'id_rcand_candexweb_candidato',
  ),
  'rcand_candexweb_pedidos' =>
  array (
    0 => 'id_rcand_candexweb_pedido',
  ),
  'rcand_partido' =>
  array (
    0 => 'cd_eleicao',
    1 => 'nr_partido',
  ),
  'rcand_cand_proc_partido' =>
  array (
    0 => 'cd_eleicao',
    1 => 'nr_processo_sem_formatacao',
    2 => 'nr_partido',
  ),
  'rcand_cw_pedido_partido' =>
  array (
    0 => 'cd_eleicao',
    1 => 'sq_pedido',
    2 => 'nr_partido',
  ),
  'rota' => 
  array (
    0 => 'id',
  ),
  'rota_local' => 
  array (
    0 => 'id',
  ),
  'rota_transmissao_vinculo' =>
  array (
    0 => 'id',
  ),
  'secoes' => 
  array (
    0 => 'cod_objeto',
  ),
  'secoes_agregadas' => 
  array (
    0 => 'cod_objeto_secao_agregadora',
    1 => 'cod_objeto_secao',
  ),
  'sessions' => 
  array (
    0 => 'id',
  ),
  'subprojeto' => 
  array (
    0 => 'id',
  ),
  'subprojeto_impacto' => 
  array (
    0 => 'id',
  ),
  'tarefa' => 
  array (
    0 => 'id',
  ),
  'tarefa_alerta_agendamento' => 
  array (
    0 => 'id',
  ),
  'tarefa_alerta_auditoria' => 
  array (
    0 => 'id',
  ),
  'tarefa_alerta_execucao' => 
  array (
    0 => 'id',
  ),
  'tarefa_alerta_execucao_destinatario' => 
  array (
    0 => 'id',
  ),
  'tarefa_alerta_execucao_dest_tarefa' => 
  array (
    0 => 'id',
  ),
  'tarefa_alerta_execucao_tentativa' => 
  array (
    0 => 'id',
  ),
  'tarefa_andamento' => 
  array (
    0 => 'id',
  ),
  'tarefa_lote' => 
  array (
    0 => 'id',
  ),
  'tarefa_solicitacao_prazo' => 
  array (
    0 => 'id',
  ),
  'tbldaacesso' => 
  array (
    0 => 'id',
  ),
  'tbldaenergia' => 
  array (
    0 => 'id',
  ),
  'tipo_sinal' => 
  array (
    0 => 'id',
  ),
  'tipo_tomada' => 
  array (
    0 => 'id',
  ),
  'treinamento' => 
  array (
    0 => 'id',
  ),
  'treinamento_tse_convocado' =>
  array (
    0 => 'id',
  ),
  'treinamento_tse_turma' =>
  array (
    0 => 'id',
  ),
  'users' => 
  array (
    0 => 'id',
  ),
  'zona' => 
  array (
    0 => 'id',
  ),
);

    /** @var array<string, int> */
    private const SOURCE_ROW_COUNTS = array (
  'ca_registro_status' => 2,
  'ca_atendimento_tipo' => 6,
  'ca_ocorrencia_tipo' => 7,
  'ca_registro_configuracao' => 0,
  'ca_registro_eleicao' => 0,
  'ca_registro_atendimento' => 0,
  'ca_registro_ocorrencia' => 0,
  'ca_registro_historico' => 0,
  'jecmon_kit_online' => 0,
  'jecmon_kit_online_sync' => 0,
  'scde_configuracao' => 0,
  'scde_secao_situacao' => 0,
  'svi_solicitante_tipo' => 4,
  'svi_contato_preferencia' => 3,
  'svi_condicao' => 7,
  'svi_equipamento' => 10,
  'svi_solicitacao_status' => 6,
  'svi_turno_status' => 4,
  'svi_configuracao' => 0,
  'svi_solicitacao' => 0,
  'svi_solicitacao_condicao' => 0,
  'svi_solicitacao_equip' => 0,
  'svi_solicitacao_turno' => 0,
  'svi_anexo' => 0,
  'svi_historico' => 0,
  'svi_acesso_desafio' => 0,
  'svi_notificacao' => 0,
  'acesso' => 6,
  'adm_acesso_rota' => 510,
  'adm_acesso_rota_grupo' => 618,
  'adm_grupo_acesso' => 17,
  'adm_grupo_macroprojeto' => 19,
  'auditoria_acao' => 4015,
  'bairro' => 485,
  'mrj' => 0,
  'mrj_sync_stage' => 0,
  'local_votacao_deslocamento' => 6,
  'nat_vistoria_secao_pergunta' => 9,
  'nat_vistoria_secao' => 0,
  'nat_vistoria_secao_resposta' => 0,
  'cache' => 3,
  'cache_locks' => 0,
  'cad_agendamento' => 173,
  'cad_bloqueio_agenda' => 0,
  'cad_convocacao_mesario_tse' => 7654,
  'cad_documento' => 4,
  'cad_eleitor' => 182,
  'cad_fila_config_unidade' => 12,
  'cad_fila_contador_unidade' => 10,
  'cad_fila_evento' => 10857,
  'cad_fila_painel_evento' => 3818,
  'cad_fila_prioridade' => 2,
  'cad_fila_senha' => 2549,
  'cad_funcionamento_unidade' => 126,
  'cad_guiche' => 62,
  'cad_pesquisa_satisfacao' => 3814,
  'cad_regra_unidade' => 0,
  'cad_restricao_serv_periodo' => 0,
  'cad_servico' => 3,
  'cad_servico_documento' => 0,
  'cad_servico_guiche' => 18,
  'cad_slot_agenda' => 85,
  'cad_supervisor_banco' => 463,
  'cad_supervisor_pergunta' => 4,
  'cad_supervisor_predio' => 132,
  'cad_supervisor_predio_notificacao' => 57,
  'cad_supervisor_resposta' => 528,
  'cad_tipo_guiche' => 2,
  'cad_unidade' => 33,
  'cargos_equipe' => 5,
  'categoria_tarefa' => 17,
  'ce_candidatura_colaborador' => 341,
  'ce_candidatura_notificacao' => 269,
  'ce_evento_voluntario' => 1,
  'ce_evento_voluntario_agenda' => 1,
  'ce_evento_voluntario_participante' => 2,
  'ce_evento_voluntario_status' => 2,
  'ce_processo_eleitoral' => 12,
  'ce_selecao_escala' => 0,
  'ce_voluntario_email_confirmacao' => 3,
  'ce_voluntario_exclusao' => 0,
  'ce_sms_campo_variavel' => 10,
  'ce_sms_modelo_situacao' => 2,
  'ce_sms_envio_status' => 9,
  'ce_sms_modelo' => 0,
  'ce_sms_lote' => 0,
  'ce_sms_lote_item' => 0,
  'ce_sms_envio' => 0,
  'ce_sms_envio_evento' => 0,
  'ce_sms_resposta' => 0,
  'disque_eleicao_assunto' => 17,
  'disque_eleicao_domicilio_extra' => 2,
  'disque_eleicao_atendimento' => 0,
  'eleitor' => 614718,
  'energia' => 4,
  'equipe' => 33,
  'equipe_vinculo' => 28,
  'esfera' => 4,
  'estado_tarefa' => 3,
  'failed_jobs' => 5,
  'fase_tarefa' => 19,
  'grupo_unidade' => 1,
  'grupo_unidade_membro' => 9,
  'internet' => 6,
  'jobs' => 0,
  'job_batches' => 0,
  'lda' => 92,
  'lda_ativo_glpi' => 1,
  'lda_deslocamento' => 6,
  'lda_situacao_mesario' => 1,
  'lda_situacao_opcao' => 3,
  'lda_trajeto' => 99,
  'lda_trajeto_trecho' => 104,
  'lda_vistoria_transmissao' => 0,
  'lda_vistoria_transmissao_sinal' => 0,
  'local_transmissao' => 272,
  'local_votacao_st' => 680,
  'local_votacao_vagas' => 680,
  'macroprojeto' => 4,
  'macroprojeto_turno' => 8,
  'migrations' => 190,
  'municipio' => 23,
  'nat_externo_desafio_login' => 78,
  'nat_externo_evento' => 258,
  'nat_externo_macroprojeto' => 1,
  'nat_ocorrencia' => 70,
  'nat_ocorrencia_evento' => 208,
  'nat_ocorrencia_mesario_publico' => 6,
  'nat_rota_conversa' => 136,
  'nat_rota_mensagem' => 128,
  'nat_rota_mensagem_leitura' => 130,
  'nat_status_ocorrencia' => 3,
  'nat_tipo_ocorrencia' => 30,
  'opcao_binaria' => 2,
  'operadora' => 3,
  'password_reset_tokens' => 0,
  'projeto' => 7,
  'qualidade' => 5,
  'risco' => 1,
  'risco_alvo' => 6,
  'rcand_partido' => 0,
  'rcand_cand_proc_partido' => 0,
  'rcand_cw_pedido_partido' => 0,
  'rota' => 31,
  'rota_local' => 224,
  'rota_transmissao_vinculo' => 0,
  'secao_alocacao_provisoria' => 0,
  'secoes' => 2406,
  'secoes_agregadas' => 0,
  'sessions' => 16,
  'subprojeto' => 27,
  'subprojeto_impacto' => 320,
  'tarefa' => 1206,
  'tarefa_alerta_agendamento' => 1,
  'tarefa_alerta_auditoria' => 4,
  'tarefa_alerta_execucao' => 3,
  'tarefa_alerta_execucao_destinatario' => 76,
  'tarefa_alerta_execucao_dest_tarefa' => 1142,
  'tarefa_alerta_execucao_tentativa' => 76,
  'tarefa_andamento' => 159,
  'tarefa_lote' => 32,
  'tarefa_solicitacao_prazo' => 292,
  'tbldaacesso' => 130,
  'tbldaenergia' => 69,
  'tbtransmissaovotacao' => 807,
  'tipo_sinal' => 3,
  'tipo_tomada' => 4,
  'treinamento' => 0,
  'treinamento_tse_convocado' => 41,
  'treinamento_tse_turma' => 7,
  'users' => 0,
  'zona' => 9,
);

    /**
     * @return array<int, string>
     */
    public static function allTables(): array
    {
        return self::ALL_TABLES;
    }

    /**
     * @return array<int, string>
     */
    public static function referenceTables(): array
    {
        return self::REFERENCE_TABLES;
    }

    /**
     * @return array<int, string>
     */
    public static function privateDataTables(): array
    {
        return self::PRIVATE_DATA_TABLES;
    }

    /**
     * @return array<int, string>
     */
    public static function syncTables(): array
    {
        return self::SYNC_TABLES;
    }

    /**
     * @return array<int, string>
     */
    public static function ignoredTables(): array
    {
        return self::IGNORED_TABLES;
    }

    /**
     * @return array<string, array<int, string>>
     */
    public static function primaryKeys(): array
    {
        return self::PRIMARY_KEYS;
    }

    /**
     * @return array<int, string>
     */
    public static function primaryKeyFor(string $table): array
    {
        return self::PRIMARY_KEYS[strtolower($table)] ?? [];
    }

    /**
     * @return array<string, int>
     */
    public static function sourceRowCounts(): array
    {
        return self::SOURCE_ROW_COUNTS;
    }

    public static function sourceRowCountFor(string $table): int
    {
        return self::SOURCE_ROW_COUNTS[strtolower($table)] ?? 0;
    }

    public static function referenceDataDirectory(): string
    {
        return base_path('database/seeders/data/restore-reference');
    }

    public static function referenceDataPath(string $table): string
    {
        return self::referenceDataDirectory() . DIRECTORY_SEPARATOR . strtolower($table) . '.json';
    }

    public static function privateDataDirectory(): string
    {
        $configured = config('planeleito.restore.private_data_path');

        return is_string($configured) && trim($configured) !== ''
            ? rtrim($configured, DIRECTORY_SEPARATOR)
            : storage_path('app/restore/private');
    }

    public static function privateDataPath(string $table, string $extension = 'jsonl'): string
    {
        return self::privateDataDirectory() . DIRECTORY_SEPARATOR . strtolower($table) . '.' . ltrim($extension, '.');
    }
}
```
</APP_SUPPORT_DATABASERESTORE_RESTORETABLEMANIFEST_PHP>

