#!/bin/bash
# ==============================================================================
# Script: consolidar_md_crepusculo.sh
# Sistema: Ecossistema Monolítico "Crepúsculo" (Justiça Eleitoral)
# Descrição: Varre recursivamente o repositório em busca de todos os arquivos
#            de documentação e instrução em formato Markdown (.md), agrupando-os
#            em volumes consolidados otimizados para leitura por IA.
#
# Requisitos: Linux Ubuntu 24.04 LTS (Bash 5+, awk, sed, find, stat)
# ==============================================================================

set -e

# Configuração de Parâmetros e Diretórios
ROOT_DIR="${1:-.}"
OUTPUT_DIR="${2:-./documentacao_md_consolidada}"
MAX_SIZE_KB=1500 # Tamanho máximo por volume para otimização de janela de contexto (~1.5 MB)

mkdir -p "$OUTPUT_DIR"
TEMP_DIR=$(mktemp -d -t crep_md_XXXXXX)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "======================================================================"
echo "🚀 CONSOLIDAÇÃO DE DOCUMENTAÇÃO MARKDOWN (.MD) - CREPÚSCULO"
echo "Diretório Raiz: $(realpath "$ROOT_DIR")"
echo "Diretório de Destino: $(realpath "$OUTPUT_DIR")"
echo "Tamanho Máximo Otimizado por Volume: ${MAX_SIZE_KB} KB"
echo "======================================================================"

echo "🔍 Localizando arquivos .md no repositório..."

# Busca todos os arquivos .md a partir da raiz, ignorando arquivos de saída anteriores
mapfile -t MD_FILES < <(find "$ROOT_DIR" -type f -name "*.md" ! -path "*/$(basename "$OUTPUT_DIR")/*" | sort)

TOTAL_MD=${#MD_FILES[@]}
echo "📊 Total de arquivos Markdown (.md) localizados: $TOTAL_MD"

if [ "$TOTAL_MD" -eq 0 ]; then
    echo "⚠️ Nenhum arquivo .md encontrado no diretório: '$ROOT_DIR'."
    exit 0
fi

TEMP_CONSOLIDATED="$TEMP_DIR/todos_markdowns.tmp"

# Processa cada arquivo Markdown
for md_file in "${MD_FILES[@]}"; do
    REL_PATH=$(realpath --relative-to="$ROOT_DIR" "$md_file" 2>/dev/null || echo "$md_file" | sed 's|^\./||')
    
    # Constrói a TAG única no formato <PASTA_SUBPASTA_NOMEARQUIVO_MD>
    TAG_NAME=$(echo "$REL_PATH" | sed 's|\.md$||' | tr '/.\\-' '____' | tr '[:lower:]' '[:upper:]')_MD

    # Extração de Seções e Registros Relevantes para DFD, DRS e Modelagem (UML/MER)
    REQUISITOS_SECAO=$(grep -i -E "^#.*(requisito|funcionalidade|regra|escopo|especificação)" "$md_file" || echo "Sem cabeçalhos diretos de requisitos identificados")
    ENTIDADES_SECAO=$(grep -i -E "^#.*(entidade|tabela|modelo|dados|banco|mer)" "$md_file" || echo "Sem cabeçalhos diretos de modelagem de dados identificados")
    PROCESSOS_SECAO=$(grep -i -E "^#.*(fluxo|processo|dfd|diagrama|interação|drs)" "$md_file" || echo "Sem cabeçalhos diretos de processos/DFD identificados")

    # Escreve o bloco envelopado pela TAG
    cat <<EOF >> "$TEMP_CONSOLIDATED"

---
# 📁 ARQUIVO DE ORIGEM: \`$REL_PATH\`
## <${TAG_NAME}>

### 🧬 Mapeamento Estrutural para DFD, DRS e Modelagens (MER / UML)
- **Caminho Relativo no Servidor:** \`$REL_PATH\`
- **Tag Rastreável:** \`$TAG_NAME\`

#### 📋 Estrutura de Requisitos & Regras (DRS / ERS):
\`\`\`text
$REQUISITOS_SECAO
\`\`\`

#### 🗄️ Estrutura de Dados & Entidades (MER / UML):
\`\`\`text
$ENTIDADES_SECAO
\`\`\`

#### ⚙️ Fluxos de Trabalho & Processos (DFD):
\`\`\`text
$PROCESSOS_SECAO
\`\`\`

### 📖 Conteúdo Integral do Arquivo Markdown:
$(cat "$md_file")

</${TAG_NAME}>

EOF

done

echo ""
echo "======================================================================"
echo "📦 FRACIONAMENTO E CÁLCULO DE TAMANHO DOS ARQUIVOS MARKDOWN"
echo "======================================================================"

# Calcula tamanho total bruto em KB
TOTAL_BYTES=$(stat -c%s "$TEMP_CONSOLIDATED" 2>/dev/null || stat -f%z "$TEMP_CONSOLIDATED")
TOTAL_KB=$((TOTAL_BYTES / 1024))

echo "📏 Tamanho Total Bruto Acumulado: ${TOTAL_KB} KB"

# Se o tamanho total for menor ou igual ao limite por arquivo, gera arquivo único
if [ "$TOTAL_KB" -le "$MAX_SIZE_KB" ]; then
    TARGET_FILE="$OUTPUT_DIR/Crepusculo_Documentacao_Consolidada.md"
    
    cat <<EOF > "$TARGET_FILE"
# 📦 Documentação Consolidada do Ecossistema Crepúsculo
> **Base Unificada de Instruções e Documentação em Markdown (.md)**
> **Total de Arquivos Originais Incluídos:** $TOTAL_MD
> **Tamanho Total:** ${TOTAL_KB} KB
> **Aplicação:** Insumo direto para Inteligência Artificial na geração de DFD, DRS, ERS, MER e UML.

---
EOF
    cat "$TEMP_CONSOLIDATED" >> "$TARGET_FILE"
    echo "✅ Arquivo Único Gerado: $TARGET_FILE (${TOTAL_KB} KB)"
else
    # Fraciona em volumes de tamanho compatível (~1500 KB)
    echo "⚠️ Tamanho (${TOTAL_KB} KB) excede o limite ideal por fonte (${MAX_SIZE_KB} KB). Fracionando em volumes..."
    
    awk -v RS="\n---\n" -v prefix="$OUTPUT_DIR/Crepusculo_Documentacao_Vol" -v max_kb="$MAX_SIZE_KB" -v total_files="$TOTAL_MD" '
    BEGIN {
        part = 1;
        curr_size = 0;
        file = prefix part ".md";
        print "# 📦 Documentação Consolidada do Ecossistema Crepúsculo (Volume " part ")\n> **Base Unificada de Instruções e Documentação (.md) Fracionada**\n> **Limite Otimizado por Volume:** " max_kb " KB\n\n---" > file;
    }
    {
        block_len = length($0) / 1024;
        if (curr_size + block_len > max_kb && curr_size > 0) {
            close(file);
            part++;
            curr_size = 0;
            file = prefix part ".md";
            print "# 📦 Documentação Consolidada do Ecossistema Crepúsculo (Volume " part ")\n> **Base Unificada de Instruções e Documentação (.md) Fracionada**\n> **Limite Otimizado por Volume:** " max_kb " KB\n\n---" > file;
        }
        print "\n---\n" $0 >> file;
        curr_size += block_len;
    }
    ' "$TEMP_CONSOLIDATED"

    for part_file in "$OUTPUT_DIR/Crepusculo_Documentacao_Vol"*.md; do
        P_SIZE=$(stat -c%s "$part_file" 2>/dev/null || stat -f%z "$part_file")
        P_KB=$((P_SIZE / 1024))
        echo "   🧩 Volume Gerado: $(basename "$part_file") (${P_KB} KB)"
    done
fi

echo ""
echo "======================================================================"
echo "🎯 RESUMO DE FONTES GERADAS PARA PROCESSAMENTO NESTA IA"
echo "======================================================================"
ls -lh "$OUTPUT_DIR"/*.md | awk '{print "📄 " $9, "| Tamanho:", $5}'

echo ""
echo "✅ Processo concluído com sucesso!"
echo "Os arquivos Markdown gerados em '$OUTPUT_DIR' estão otimizados e prontos para consumo pela IA nas tarefas de geração de DFD, DRS e modelagens."
