# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_services_scde`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 3  
> **Tamanho do Arquivo:** 11 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Scde/ScdeClient.php`
## <APP_SERVICES_SCDE_SCDECLIENT_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Scde/ScdeClient.php`
- **Namespace Declaração:** `App\Services\Scde`
- **Entidade / Classe:** `class ScdeClient`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function consultarSituacaoSecao(int $codPleito, int $codEleicao, string $uf, int $numeroZona): array
public function validarConfiguracao(): void
private function configuracaoSegura(): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Scde;

use Illuminate\Http\Client\ConnectionException;
use Illuminate\Support\Facades\Http;
use RuntimeException;

class ScdeClient
{
    /** @var list<string> */
    private const HOSTS_PERMITIDOS = [
        'scde-api.tse.jus.br',
        'scde-apis.tse.jus.br',
        'scde-apih.tse.jus.br',
    ];

    /**
     * @return list<array<string, mixed>>
     */
    public function consultarSituacaoSecao(int $codPleito, int $codEleicao, string $uf, int $numeroZona): array
    {
        if ($codPleito <= 0 || $codEleicao <= 0 || $numeroZona <= 0 || mb_strtoupper(trim($uf)) !== 'AC') {
            throw new RuntimeException('Contexto inválido para consultar o SCDE.');
        }

        [$baseUrl, $token] = $this->configuracaoSegura();
        $url = sprintf(
            '%s/servicos-acompanhamento/rest/v1/situacao-secao-completo-analitico/%d/%d/AC/%d',
            $baseUrl,
            $codPleito,
            $codEleicao,
            $numeroZona,
        );

        try {
            $response = Http::acceptJson()
                ->withHeaders(['API-Authorization' => $token])
                ->connectTimeout(max(1, (int) config('services.scde.connect_timeout', 5)))
                ->timeout(max(1, (int) config('services.scde.timeout', 30)))
                ->withOptions([
                    'allow_redirects' => false,
                    'verify' => true,
                ])
                ->get($url);
        } catch (ConnectionException) {
            throw new RuntimeException('Não foi possível conectar ao SCDE.');
        }

        if (! $response->successful()) {
            throw new RuntimeException(sprintf('O SCDE respondeu com status HTTP %d.', $response->status()));
        }

        $payload = $response->json();
        if (! is_array($payload) || ! array_is_list($payload)) {
            throw new RuntimeException('O SCDE retornou JSON inválido para a consulta de seções.');
        }

        foreach ($payload as $registro) {
            if (! is_array($registro)) {
                throw new RuntimeException('O SCDE retornou item inválido na consulta de seções.');
            }
        }

        /** @var list<array<string, mixed>> $payload */
        return $payload;
    }

    public function validarConfiguracao(): void
    {
        $this->configuracaoSegura();
    }

    /** @return array{string,string} */
    private function configuracaoSegura(): array
    {
        $baseUrl = rtrim(trim((string) config('services.scde.base_url', '')), '/');
        $token = trim((string) config('services.scde.api_token', ''));
        $partes = parse_url($baseUrl);
        $host = is_array($partes) ? mb_strtolower((string) ($partes['host'] ?? '')) : '';
        $path = is_array($partes) ? (string) ($partes['path'] ?? '') : '';

        if ($token === '') {
            throw new RuntimeException('O token da integração SCDE não está configurado.');
        }
        if (! is_array($partes)
            || ($partes['scheme'] ?? null) !== 'https'
            || ! in_array($host, self::HOSTS_PERMITIDOS, true)
            || isset($partes['user'])
            || isset($partes['pass'])
            || isset($partes['port'])
            || ! in_array($path, ['', '/'], true)
            || (($partes['query'] ?? '') !== '')
            || (($partes['fragment'] ?? '') !== '')) {
            throw new RuntimeException('A URL configurada para o SCDE não é permitida.');
        }
        if (config('services.scde.verify_tls', true) !== true) {
            throw new RuntimeException('A validação TLS do SCDE deve permanecer habilitada.');
        }

        return [$baseUrl, $token];
    }
}
```
</APP_SERVICES_SCDE_SCDECLIENT_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Scde/ScdeConfiguracaoService.php`
## <APP_SERVICES_SCDE_SCDECONFIGURACAOSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Scde/ScdeConfiguracaoService.php`
- **Namespace Declaração:** `App\Services\Scde`
- **Entidade / Classe:** `class ScdeConfiguracaoService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function ativar(int $id): int
public function desativar(int $id): int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Scde;

use App\Repositories\Scde\ScdeConfiguracaoRepository;
use DomainException;
use RuntimeException;

class ScdeConfiguracaoService
{
    public function __construct(
        private readonly ScdeConfiguracaoRepository $repository,
        private readonly ScdeClient $client,
    ) {
    }

    public function ativar(int $id): int
    {
        if (! (bool) config('services.scde.sync_enabled', false)) {
            throw new DomainException('A sincronização SCDE está desabilitada neste ambiente.');
        }

        try {
            $this->client->validarConfiguracao();
        } catch (RuntimeException) {
            throw new DomainException('A integração SCDE não está configurada com segurança neste ambiente.');
        }

        return $this->repository->ativar($id);
    }

    public function desativar(int $id): int
    {
        return $this->repository->desativar($id);
    }
}
```
</APP_SERVICES_SCDE_SCDECONFIGURACAOSERVICE_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Services/Scde/ScdeStatusService.php`
## <APP_SERVICES_SCDE_SCDESTATUSSERVICE_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Services/Scde/ScdeStatusService.php`
- **Namespace Declaração:** `App\Services\Scde`
- **Entidade / Classe:** `class ScdeStatusService`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
public function atual(): array
private function vazio(string $estado, string $rotulo): array
private function data(mixed $valor): ?CarbonImmutable
private function formatar(?CarbonImmutable $data): ?string
private function textoSeguro(mixed $valor): ?string
private function inteiroOuNull(mixed $valor): ?int
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Services\Scde;

use App\Repositories\Scde\ScdeConfiguracaoRepository;
use Carbon\CarbonImmutable;
use Throwable;

class ScdeStatusService
{
    public function __construct(
        private readonly ScdeConfiguracaoRepository $repository,
        private readonly ScdeClient $client,
    ) {
    }

    /** @return array<string, mixed> */
    public function atual(): array
    {
        if (! (bool) config('services.scde.sync_enabled', false)) {
            return $this->vazio('desabilitada', 'Sincronização desabilitada neste ambiente.');
        }

        try {
            $this->client->validarConfiguracao();
        } catch (Throwable) {
            return $this->vazio('indisponivel', 'Integração não configurada com segurança.');
        }

        $configuracao = $this->repository->buscarAtiva();
        if ($configuracao === null) {
            return $this->vazio('sem_configuracao_ativa', 'Nenhuma configuração está ativa.');
        }

        $tentativa = $this->data($configuracao['dt_ultima_tentativa'] ?? null);
        $sucesso = $this->data($configuracao['dt_ultimo_sucesso'] ?? null);
        $erro = $this->data($configuracao['dt_ultimo_erro'] ?? null);
        if ($tentativa !== null && ($sucesso === null || $tentativa->greaterThan($sucesso))
            && ($erro === null || $tentativa->greaterThan($erro))) {
            [$estado, $rotulo] = ['em_execucao', 'Sincronização em execução.'];
        } elseif ($erro !== null && ($sucesso === null || $erro->greaterThan($sucesso))) {
            [$estado, $rotulo] = ['erro', 'A última sincronização falhou.'];
        } elseif ($sucesso !== null) {
            [$estado, $rotulo] = ['sucesso', 'Última sincronização concluída.'];
        } else {
            [$estado, $rotulo] = ['aguardando', 'Aguardando a primeira execução do scheduler.'];
        }

        return [
            'estado' => $estado,
            'rotulo' => $rotulo,
            'configuracao_id' => (int) $configuracao['id'],
            'cod_pleito' => (int) $configuracao['cod_pleito'],
            'cod_eleicao' => (int) $configuracao['cod_eleicao'],
            'ultima_tentativa' => $this->formatar($tentativa),
            'ultimo_sucesso' => $this->formatar($sucesso),
            'ultimo_erro' => $this->formatar($erro),
            'mensagem_erro' => $this->textoSeguro($configuracao['ds_ultimo_erro'] ?? null),
            'duracao_ms' => $this->inteiroOuNull($configuracao['duracao_ultima_ms'] ?? null),
            'qtd_zonas' => $this->inteiroOuNull($configuracao['qtd_zonas'] ?? null),
            'qtd_secoes' => $this->inteiroOuNull($configuracao['qtd_secoes'] ?? null),
            'qtd_registros' => $this->inteiroOuNull($configuracao['qtd_registros'] ?? null),
        ];
    }

    /** @return array<string, mixed> */
    private function vazio(string $estado, string $rotulo): array
    {
        return [
            'estado' => $estado,
            'rotulo' => $rotulo,
            'configuracao_id' => null,
            'cod_pleito' => null,
            'cod_eleicao' => null,
            'ultima_tentativa' => null,
            'ultimo_sucesso' => null,
            'ultimo_erro' => null,
            'mensagem_erro' => null,
            'duracao_ms' => null,
            'qtd_zonas' => null,
            'qtd_secoes' => null,
            'qtd_registros' => null,
        ];
    }

    private function data(mixed $valor): ?CarbonImmutable
    {
        if ($valor === null || trim((string) $valor) === '') {
            return null;
        }

        try {
            return CarbonImmutable::parse($valor);
        } catch (Throwable) {
            return null;
        }
    }

    private function formatar(?CarbonImmutable $data): ?string
    {
        return $data?->timezone(config('app.timezone'))->format('d/m/Y H:i:s');
    }

    private function textoSeguro(mixed $valor): ?string
    {
        $texto = trim((string) ($valor ?? ''));
        return $texto === '' ? null : mb_substr($texto, 0, 1000);
    }

    private function inteiroOuNull(mixed $valor): ?int
    {
        return $valor === null || $valor === '' ? null : (int) $valor;
    }
}
```
</APP_SERVICES_SCDE_SCDESTATUSSERVICE_PHP>

