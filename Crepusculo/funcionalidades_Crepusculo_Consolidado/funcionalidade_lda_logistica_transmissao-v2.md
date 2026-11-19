# Projeto Crepúsculo — Especificação Técnica Consolidada (v2)
## Módulo: LDA, Logística, Rotas e Transmissão de Dados

### 1. Visão Geral e Escopo Funcional
**Propósito**: Planejamento e acompanhamento operacional da logística para Locais de Difícil Acesso (LDA), rotas de transporte (terrestre, fluvial, aéreo), vistorias técnicas de transmissão, cadastramento de Locais de Transmissão (LT), polos de transmissão e monitoramento dos kits JEC-MONITOR.

**Status do Sistema**: Desenvolvido e em Produção.

---

### 2. Regras de Negócio e Parâmetros

#### RN-LDA-001: Precedência de Tempo de Deslocamento
- O tempo de deslocamento para um local de votação/LDA é resolvido na seguinte ordem de prioridade:
  1. Trajeto oficial cadastrado no macroprojeto ativo (`LDA_TRAJETO_TRECHO`).
  2. Classificação de tempo oriunda da análise GEL (`GEL_TEMPO_DESLOCAMENTO`).
  3. Sem informação aproveitável (Apresenta aviso "Não informado").

#### RN-LDA-002: Integração com Kits JEC-MONITOR
- O módulo conecta-se ao sistema corporativo JEC-MONITOR via API OAuth Client Credentials.
- A sincronização dos kits de transmissão opera em background e armazena os snapshots em `JECMON_KIT_SNAPSHOT`.
- A falha temporária ou timeout na API do JEC-MONITOR não bloqueia a exibição nem o salvamento dos formulários de LDA/LT no sistema.

---

### 3. Modelagem de Dados e Entidades (Oracle 21c)

```sql
-- Locais de Difícil Acesso (LDA)
CREATE TABLE LDA (
    ID NUMBER(10) PRIMARY KEY,
    COD_OBJETO_LOCAL_VOTACAO VARCHAR2(20) NOT NULL UNIQUE,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    DESCRICAO_ACESSO VARCHAR2(1000),
    TEMPO_ESTIMADO_HORAS NUMBER(5,2),
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Trecho de Trajeto de LDA
CREATE TABLE LDA_TRAJETO_TRECHO (
    ID NUMBER(10) PRIMARY KEY,
    LDA_ID NUMBER(10) NOT NULL,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    ORDEM NUMBER(5) NOT NULL,
    MODAL_TRANSPORTE VARCHAR2(50) NOT NULL, -- TERRESTRE_4X4, EMBARCACAO, HELICOPTERO, CAMINHADA
    DISTANCIA_KM NUMBER(8,2),
    TEMPO_TRECHO_HORAS NUMBER(5,2) NOT NULL,
    OBSERVACOES VARCHAR2(500),
    CONSTRAINT FK_LTT_LDA FOREIGN KEY (LDA_ID) REFERENCES LDA(ID) ON DELETE CASCADE
);

-- Locais de Transmissão (LT)
CREATE TABLE LOCAL_TRANSMISSAO (
    ID NUMBER(10) PRIMARY KEY,
    MACROPROJETO_ID NUMBER(10) NOT NULL,
    NOME VARCHAR2(150) NOT NULL,
    ZONA_NUM NUMBER(5) NOT NULL,
    MUNICIPIO_COD VARCHAR2(20) NOT NULL,
    TIPO_TRANSMISSAO VARCHAR2(50) NOT NULL, -- SATELLITE_JE, JE_CONNECT, 4G_OFFICIAL
    ATIVO NUMBER(1) DEFAULT 1 NOT NULL,
    DT_CRIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Vínculo de Kits JEC-MONITOR
CREATE TABLE JECMON_KIT_VINCULO (
    ID NUMBER(10) PRIMARY KEY,
    KIT_ID VARCHAR2(50) NOT NULL UNIQUE,
    COD_OBJETO_LOCAL_VOTACAO VARCHAR2(20),
    LOCAL_TRANSMISSAO_ID NUMBER(10),
    DT_VINCULO TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_JKV_LT FOREIGN KEY (LOCAL_TRANSMISSAO_ID) REFERENCES LOCAL_TRANSMISSAO(ID)
);
```

---

### 4. Componentes e Código PHP Essencial

#### Service de Atrelamento de Kits JEC-MONITOR (`JecmonKitService.php`)
```php
namespace App\Services\Lda;

use App\Repositories\Lda\Contracts\JecmonKitRepositoryInterface;
use Illuminate\Support\Facades\Http;
use Exception;

class JecmonKitService
{
    public function __construct(private readonly JecmonKitRepositoryInterface $repository) {}

    public function sincronizarKitsComJecmonitor(int $processoEleitoralId): array
    {
        $token = $this->obterTokenOAuth();
        
        try {
            $response = Http::withToken($token)
                ->timeout(5)
                ->get(config('services.jecmonitor.url') . '/v1/kits', ['processo' => $processoEleitoralId]);

            if ($response->successful()) {
                $kits = $response->json('data', []);
                $this->repository->salvarSnapshotKits($processoEleitoralId, $kits);
                return ['sucesso' => true, 'total' => count($kits)];
            }
        } catch (Exception $e) {
            // Em caso de falha de rede/API, degrada para leitura da cache local
        }

        return ['sucesso' => false, 'modo' => 'degradado_local'];
    }

    private function obterTokenOAuth(): string
    {
        return cache()->remember('jecmonitor_oauth_token', 3500, function () {
            $res = Http::asForm()->post(config('services.jecmonitor.token_url'), [
                'grant_type' => 'client_credentials',
                'client_id' => config('services.jecmonitor.client_id'),
                'client_secret' => config('services.jecmonitor.client_secret'),
            ]);
            return $res->json('access_token');
        });
    }
}
```

---

### 5. Fronteiras de Integração
- **JEC-MONITOR**: Barramento de transmissão do TSE para monitoramento de pacotes de sinal e conectividade via satélite.
- **GEL**: Leitura de tempos de deslocamento e análises de rotas georreferenciadas.
