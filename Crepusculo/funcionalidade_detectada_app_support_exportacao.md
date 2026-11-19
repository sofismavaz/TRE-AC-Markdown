# 📦 Documentação Consolidada do Sistema Crepúsculo
## Funcionalidade: `funcionalidade_detectada_app_support_exportacao`
> **Fonte Confiável de Pesquisa para Engenharia de Software e Processamento de IA**  
> **Total de Arquivos PHP Consolidados:** 5  
> **Tamanho do Arquivo:** 12 KB  
> **Classificação do Mapeamento:** NOVA FUNCIONALIDADE IDENTIFICADA ALÉM DAS 15 INICIAIS

---

---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Exportacao/CamposPdfSelecionados.php`
## <APP_SUPPORT_EXPORTACAO_CAMPOSPDFSELECIONADOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Exportacao/CamposPdfSelecionados.php`
- **Namespace Declaração:** `App\Support\Exportacao`
- **Entidade / Classe:** `final class CamposPdfSelecionados`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function resolver(mixed $entrada, array $permitidos, array $padrao): array
private static function selecionar(array $entrada, array $permitidos): array
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Exportacao;

final class CamposPdfSelecionados
{
    /**
     * @param array<int|string, mixed> $permitidos
     * @param array<int, string> $padrao
     * @return array<int, string>
     */
    public static function resolver(mixed $entrada, array $permitidos, array $padrao): array
    {
        $chavesPermitidas = array_is_list($permitidos)
            ? array_values(array_filter($permitidos, 'is_string'))
            : array_keys($permitidos);
        $padraoSeguro = self::selecionar($padrao, $chavesPermitidas);

        if (! is_array($entrada)) {
            return $padraoSeguro;
        }

        $selecionados = self::selecionar($entrada, $chavesPermitidas);

        return $selecionados !== [] ? $selecionados : $padraoSeguro;
    }

    /**
     * @param array<int|string, mixed> $entrada
     * @param array<int, string> $permitidos
     * @return array<int, string>
     */
    private static function selecionar(array $entrada, array $permitidos): array
    {
        $selecionados = [];
        foreach ($entrada as $campo) {
            if (! is_string($campo)
                || ! in_array($campo, $permitidos, true)
                || in_array($campo, $selecionados, true)) {
                continue;
            }

            $selecionados[] = $campo;
        }

        return $selecionados;
    }
}
```
</APP_SUPPORT_EXPORTACAO_CAMPOSPDFSELECIONADOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Exportacao/CelulaPlanilhaSegura.php`
## <APP_SUPPORT_EXPORTACAO_CELULAPLANILHASEGURA_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Exportacao/CelulaPlanilhaSegura.php`
- **Namespace Declaração:** `App\Support\Exportacao`
- **Entidade / Classe:** `final class CelulaPlanilhaSegura`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function texto(string $valor): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Exportacao;

final class CelulaPlanilhaSegura
{
    public static function texto(string $valor): string
    {
        if ($valor !== '' && in_array($valor[0], ['=', '+', '-', '@'], true)) {
            return "'".$valor;
        }

        return $valor;
    }
}
```
</APP_SUPPORT_EXPORTACAO_CELULAPLANILHASEGURA_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Exportacao/EtiquetaLocalA4260Campos.php`
## <APP_SUPPORT_EXPORTACAO_ETIQUETALOCALA4260CAMPOS_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Exportacao/EtiquetaLocalA4260Campos.php`
- **Namespace Declaração:** `App\Support\Exportacao`
- **Entidade / Classe:** `final class EtiquetaLocalA4260Campos`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public static function disponiveis(): array
public static function permitidos(): array
public static function padrao(): array
public static function linhas(EtiquetaLocalA4260Pdf $etiqueta, array $campos): array
private static function valor(EtiquetaLocalA4260Pdf $etiqueta, string $campo): string
private static function certificados(?array $certificados): string
private static function textoOuNaoInformado(string $texto): string
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Exportacao;

final class EtiquetaLocalA4260Campos
{
    /** @return array<string, string> */
    public static function disponiveis(): array
    {
        return [
            'zona' => 'Zona',
            'municipio' => 'Município',
            'nome_local' => 'Local de votação',
            'endereco' => 'Endereço',
            'certificado_jeconnect' => 'Certificado JECONNECT',
        ];
    }

    /** @return list<string> */
    public static function permitidos(): array
    {
        return array_keys(self::disponiveis());
    }

    /** @return list<string> */
    public static function padrao(): array
    {
        return ['zona', 'municipio', 'endereco', 'certificado_jeconnect'];
    }

    /**
     * @param  list<string>  $campos
     * @return list<array{rotulo:string,valor:string}>
     */
    public static function linhas(EtiquetaLocalA4260Pdf $etiqueta, array $campos): array
    {
        $disponiveis = self::disponiveis();
        $linhas = [];

        foreach ($campos as $campo) {
            if (! isset($disponiveis[$campo])) {
                continue;
            }

            $linhas[] = [
                'rotulo' => $disponiveis[$campo],
                'valor' => self::valor($etiqueta, $campo),
            ];
        }

        return $linhas;
    }

    private static function valor(EtiquetaLocalA4260Pdf $etiqueta, string $campo): string
    {
        return match ($campo) {
            'zona' => $etiqueta->zona !== '' ? $etiqueta->zona.'ª Zona' : 'Não informada',
            'municipio' => self::textoOuNaoInformado($etiqueta->municipio),
            'nome_local' => self::textoOuNaoInformado($etiqueta->nomeLocal),
            'endereco' => self::textoOuNaoInformado($etiqueta->endereco),
            'certificado_jeconnect' => self::certificados($etiqueta->certificados),
            default => '',
        };
    }

    /** @param list<string>|null $certificados */
    private static function certificados(?array $certificados): string
    {
        if ($certificados === null) {
            return 'Certificado indisponível';
        }
        if ($certificados === []) {
            return 'Sem certificado';
        }

        return collect($certificados)
            ->map(static function ($certificado): string {
                $certificado = trim((string) $certificado);

                return $certificado !== '' ? $certificado : 'Certificado não informado';
            })
            ->implode(' | ');
    }

    private static function textoOuNaoInformado(string $texto): string
    {
        $texto = trim($texto);

        return $texto !== '' ? $texto : 'Não informado';
    }
}
```
</APP_SUPPORT_EXPORTACAO_ETIQUETALOCALA4260CAMPOS_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Exportacao/EtiquetaLocalA4260Pdf.php`
## <APP_SUPPORT_EXPORTACAO_ETIQUETALOCALA4260PDF_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Exportacao/EtiquetaLocalA4260Pdf.php`
- **Namespace Declaração:** `App\Support\Exportacao`
- **Entidade / Classe:** `final readonly class EtiquetaLocalA4260Pdf`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function __construct(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Exportacao;

final readonly class EtiquetaLocalA4260Pdf
{
    /** @param list<string>|null $certificados */
    public function __construct(
        public string $codObjetoLocal,
        public string $zona,
        public string $municipio,
        public string $nomeLocal,
        public string $endereco,
        public ?array $certificados,
    ) {}
}
```
</APP_SUPPORT_EXPORTACAO_ETIQUETALOCALA4260PDF_PHP>


---
# 📁 ARQUIVO DE ORIGEM: `app/Support/Exportacao/EtiquetaLocalA4260PdfRenderer.php`
## <APP_SUPPORT_EXPORTACAO_ETIQUETALOCALA4260PDFRENDERER_PHP>

### 🧬 Metadados Estruturais para Modelagem (UML / MER / DFD / ERS)
- **Caminho Relativo no Repositório:** `app/Support/Exportacao/EtiquetaLocalA4260PdfRenderer.php`
- **Namespace Declaração:** `App\Support\Exportacao`
- **Entidade / Classe:** `class EtiquetaLocalA4260PdfRenderer`

#### 🗄️ Referências de Banco de Dados (MER / Modelo de Dados):
```php

```

#### 🔗 Relacionamentos & Associações (Diagrama de Classes UML):
```php

```

#### ⚙️ Funções, Métodos & Processos (DFD / ERS / Regras de Negócio):
```php
public function renderizar(Collection $etiquetas, array $campos): string
private function desenharEtiqueta(
```

#### 🌐 Endpoints & Rotas de Interface (DRS / Arquitetura de Rotas):
```php

```

### 💻 Código Fonte PHP Completo:
```php
<?php

namespace App\Support\Exportacao;

use Illuminate\Support\Collection;
use TCPDF;

class EtiquetaLocalA4260PdfRenderer
{
    private const COLUNAS = 3;

    private const ETIQUETAS_POR_PAGINA = 21;

    private const LARGURA_ETIQUETA_MM = 63.5;

    private const ALTURA_ETIQUETA_MM = 38.1;

    private const MARGEM_LATERAL_MM = 7.2;

    private const MARGEM_SUPERIOR_MM = 15.2;

    private const PASSO_HORIZONTAL_MM = 66.1;

    private const RECUO_INTERNO_MM = 2.0;

    /**
     * @param  Collection<int, EtiquetaLocalA4260Pdf>  $etiquetas
     * @param  list<string>  $campos
     */
    public function renderizar(Collection $etiquetas, array $campos): string
    {
        $pdf = new TCPDF('P', 'mm', 'A4', true, 'UTF-8', false);
        $pdf->SetCreator('Planeleito');
        $pdf->SetAuthor('TRE-AC');
        $pdf->SetTitle('Etiquetas de locais - Pimaco A4260');
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetMargins(0, 0, 0);
        $pdf->SetAutoPageBreak(false, 0);
        $pdf->setCellPaddings(0, 0, 0, 0);

        foreach ($etiquetas->values() as $indice => $etiqueta) {
            $posicao = $indice % self::ETIQUETAS_POR_PAGINA;
            if ($posicao === 0) {
                $pdf->AddPage('P', 'A4');
            }

            $coluna = $posicao % self::COLUNAS;
            $linha = intdiv($posicao, self::COLUNAS);
            $x = self::MARGEM_LATERAL_MM + ($coluna * self::PASSO_HORIZONTAL_MM);
            $y = self::MARGEM_SUPERIOR_MM + ($linha * self::ALTURA_ETIQUETA_MM);
            $this->desenharEtiqueta($pdf, $etiqueta, $campos, $x, $y);
        }

        return $pdf->Output('etiquetas-locais-pimaco-a4260.pdf', 'S');
    }

    /** @param list<string> $campos */
    private function desenharEtiqueta(
        TCPDF $pdf,
        EtiquetaLocalA4260Pdf $etiqueta,
        array $campos,
        float $x,
        float $y
    ): void {
        $linhas = EtiquetaLocalA4260Campos::linhas($etiqueta, $campos);
        $texto = collect($linhas)
            ->map(static fn (array $linha): string => mb_strtoupper($linha['rotulo'], 'UTF-8').': '.$linha['valor'])
            ->implode("\n");
        $recuo = self::RECUO_INTERNO_MM;
        $largura = self::LARGURA_ETIQUETA_MM - (2 * $recuo);
        $altura = self::ALTURA_ETIQUETA_MM - (2 * $recuo);

        $pdf->SetTextColor(0, 0, 0);
        $pdf->SetFont('helvetica', '', 7.5);
        $pdf->MultiCell(
            $largura,
            $altura,
            $texto,
            0,
            'L',
            false,
            0,
            $x + $recuo,
            $y + $recuo,
            true,
            0,
            false,
            true,
            $altura,
            'T',
            true
        );
    }
}
```
</APP_SUPPORT_EXPORTACAO_ETIQUETALOCALA4260PDFRENDERER_PHP>

