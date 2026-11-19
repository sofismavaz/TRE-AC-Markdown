# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_repositories_scde`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 1  
> **Tamanho do Arquivo:** 8 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Repositories/Scde/ScdeConfiguracaoRepository.php`
## <APP_REPOSITORIES_SCDE_SCDECONFIGURACAOREPOSITORY_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Repositories/Scde/ScdeConfiguracaoRepository.php`
- **Namespace Declaração:** `App\Repositories\Scde`
- **Entidade / Classe:** `class ScdeConfiguracaoRepository`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php
return $this->linhaParaArray(DB::table('scde_configuracao')->where('id', $id)->first());
return $this->linhaParaArray(DB::table('scde_configuracao')->where('ativo', 1)->first());
$linha = DB::table('scde_configuracao')->where('id', $id)->lockForUpdate()->first();
$linha = DB::table('scde_configuracao')->where('id', $id)->lockForUpdate()->first();
$linhas = DB::table('scde_configuracao')->orderBy('id')->lockForUpdate()->get();
```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function listar(?int $codPleito, ?int $codEleicao, ?bool $ativo, int $porPagina = 25): LengthAwarePaginator
public function listarTodos(?int $codPleito, ?int $codEleicao, ?bool $ativo): array
public function buscar(int $id): ?array
public function buscarAtiva(): ?array
public function criar(array $dados): int
public function atualizar(int $id, array $dados): int
public function excluir(int $id): int
public function ativar(int $id): int
public function desativar(int $id): int
private function consulta(?int $codPleito, ?int $codEleicao, ?bool $ativo): Builder
private function linhaParaArray(?object $linha): ?array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Repositories\Scde;

use App\Repositories\Concerns\AuditaDml;
use DomainException;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Query\Builder;
use Illuminate\Support\Facades\DB;

class ScdeConfiguracaoRepository
{
    use AuditaDml;

    public function listar(?int $codPleito, ?int $codEleicao, ?bool $ativo, int $porPagina = 25): LengthAwarePaginator
    {
        return $this->consulta($codPleito, $codEleicao, $ativo)
            ->orderByDesc('ativo')
            ->orderByDesc('id')
            ->paginate($porPagina);
    }

    /** @return list<object> */
    public function listarTodos(?int $codPleito, ?int $codEleicao, ?bool $ativo): array
    {
        return $this->consulta($codPleito, $codEleicao, $ativo)
            ->orderByDesc('ativo')
            ->orderByDesc('id')
            ->get()
            ->all();
    }

    /** @return array<string, mixed>|null */
    public function buscar(int $id): ?array
    {
        return $this->linhaParaArray(DB::table('scde_configuracao')->where('id', $id)->first());
    }

    /** @return array<string, mixed>|null */
    public function buscarAtiva(): ?array
    {
        return $this->linhaParaArray(DB::table('scde_configuracao')->where('ativo', 1)->first());
    }

    public function criar(array $dados): int
    {
        return (int) $this->inserirAuditado('scde_configuracao', 'SCDE_CONFIGURACAO', [
            'cod_pleito' => (int) $dados['cod_pleito'],
            'cod_eleicao' => (int) $dados['cod_eleicao'],
            'ativo' => 0,
            'dt_criacao' => DB::raw('SYSTIMESTAMP'),
        ], 'id');
    }

    public function atualizar(int $id, array $dados): int
    {
        return DB::transaction(function () use ($id, $dados): int {
            $linha = DB::table('scde_configuracao')->where('id', $id)->lockForUpdate()->first();
            if ($linha === null) {
                throw new DomainException('Configuracao SCDE nao encontrada.');
            }
            $configuracao = $this->linhaParaArray($linha);
            if ((int) $configuracao['ativo'] === 1) {
                throw new DomainException('Configuracao SCDE ativa nao pode ser editada.');
            }

            return $this->atualizarAuditadoPorId('scde_configuracao', 'SCDE_CONFIGURACAO', 'id', $id, [
                'cod_pleito' => (int) $dados['cod_pleito'],
                'cod_eleicao' => (int) $dados['cod_eleicao'],
                'dt_atualizacao' => DB::raw('SYSTIMESTAMP'),
            ]);
        });
    }

    public function excluir(int $id): int
    {
        return DB::transaction(function () use ($id): int {
            $linha = DB::table('scde_configuracao')->where('id', $id)->lockForUpdate()->first();
            if ($linha === null) {
                throw new DomainException('Configuracao SCDE nao encontrada.');
            }
            $configuracao = $this->linhaParaArray($linha);
            if ((int) $configuracao['ativo'] === 1) {
                throw new DomainException('Configuracao SCDE ativa nao pode ser excluida.');
            }

            return $this->removerAuditadoPorId('scde_configuracao', 'SCDE_CONFIGURACAO', 'id', $id);
        });
    }

    public function ativar(int $id): int
    {
        return DB::transaction(function () use ($id): int {
            $linhas = DB::table('scde_configuracao')->orderBy('id')->lockForUpdate()->get();
            $configuracoes = $linhas->map(fn (object $linha): array => $this->linhaParaArray($linha) ?? [])->all();
            $alvo = collect($configuracoes)->firstWhere('id', $id);
            if ($alvo === null) {
                throw new DomainException('Configuracao SCDE nao encontrada.');
            }
            if ((int) $alvo['ativo'] === 1) {
                return 0;
            }

            $afetados = 0;
            foreach ($configuracoes as $configuracao) {
                if ((int) ($configuracao['ativo'] ?? 0) !== 1) {
                    continue;
                }
                $afetados += $this->atualizarAuditadoPorId(
                    'scde_configuracao',
                    'SCDE_CONFIGURACAO',
                    'id',
                    (int) $configuracao['id'],
                    ['ativo' => 0, 'dt_atualizacao' => DB::raw('SYSTIMESTAMP')],
                );
            }

            $afetados += $this->atualizarAuditadoPorId(
                'scde_configuracao',
                'SCDE_CONFIGURACAO',
                'id',
                $id,
                [
                    'ativo' => 1,
                    'dt_ativacao' => DB::raw('SYSTIMESTAMP'),
                    'dt_atualizacao' => DB::raw('SYSTIMESTAMP'),
                ],
            );

            return $afetados;
        });
    }

    public function desativar(int $id): int
    {
        return DB::transaction(function () use ($id): int {
            $linha = DB::table('scde_configuracao')->where('id', $id)->lockForUpdate()->first();
            if ($linha === null) {
                throw new DomainException('Configuracao SCDE nao encontrada.');
            }
            $configuracao = $this->linhaParaArray($linha);
            if ((int) $configuracao['ativo'] !== 1) {
                return 0;
            }

            return $this->atualizarAuditadoPorId('scde_configuracao', 'SCDE_CONFIGURACAO', 'id', $id, [
                'ativo' => 0,
                'dt_atualizacao' => DB::raw('SYSTIMESTAMP'),
            ]);
        });
    }

    private function consulta(?int $codPleito, ?int $codEleicao, ?bool $ativo): Builder
    {
        $query = DB::table('scde_configuracao')->selectRaw(<<<'SQL'
id,
cod_pleito,
cod_eleicao,
ativo,
TO_CHAR(dt_criacao, 'DD/MM/YYYY HH24:MI:SS') AS dt_criacao_fmt,
TO_CHAR(dt_atualizacao, 'DD/MM/YYYY HH24:MI:SS') AS dt_atualizacao_fmt,
TO_CHAR(dt_ativacao, 'DD/MM/YYYY HH24:MI:SS') AS dt_ativacao_fmt,
TO_CHAR(dt_ultima_tentativa, 'DD/MM/YYYY HH24:MI:SS') AS dt_ultima_tentativa_fmt,
TO_CHAR(dt_ultimo_sucesso, 'DD/MM/YYYY HH24:MI:SS') AS dt_ultimo_sucesso_fmt,
TO_CHAR(dt_ultimo_erro, 'DD/MM/YYYY HH24:MI:SS') AS dt_ultimo_erro_fmt,
ds_ultimo_erro,
duracao_ultima_ms,
qtd_zonas,
qtd_secoes,
qtd_registros
SQL);
        if ($codPleito !== null) {
            $query->where('cod_pleito', $codPleito);
        }
        if ($codEleicao !== null) {
            $query->where('cod_eleicao', $codEleicao);
        }
        if ($ativo !== null) {
            $query->where('ativo', $ativo ? 1 : 0);
        }

        return $query;
    }

    /** @return array<string, mixed>|null */
    private function linhaParaArray(?object $linha): ?array
    {
        return $linha === null ? null : array_change_key_case((array) $linha, CASE_LOWER);
    }
}
```
</APP_REPOSITORIES_SCDE_SCDECONFIGURACAOREPOSITORY_PHP>

