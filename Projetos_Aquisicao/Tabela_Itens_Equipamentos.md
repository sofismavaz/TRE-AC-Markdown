# Relação de itens a sere adquiridos

Relacionar os (Itens): Scanner, Multfuncional, Impressora, Projetor, Totem Digital

. Criar uma tabela relacionando os Itens;
. as colunas da tabela serão:
    . "Descrição / Especificação": descrição do Item da relação;
    . "Marca/Modelo": marca ou modelo do Item, quando houver;
    . "Valor Unitário": valor do Item da relação;
    . "Garantia": se refere ao tempo de garantia oferecido no documento relativo ao "Item" ofertado
    . "Tipo de Contrato": será definido conforme os tipos:
        . sempre que na descrição for encontrada a palavra "serviço" o tipo de contrato será "locação"
        . sempre que na descrição for encontrada a palavra "locação" o tipo de contrato será "locação"
        . sempre que na descrição for encontrada a palavra "comodato" o tipo de contrato será "locação"
        . na ausência dos termos "serviço" ou "locação", será aquisição
    . "Métrica": formato de mensuração ou aferição do contrato, sendo:
        . sempre que for encontrado a palavra "mensal" a "Métrica" será "mensal"
        . sempre que for ausênte a palavra "mensal" a "Métrica" será "por unidade"        . 
    . "Órgão": Instituição emissora do documento;
    . "ATA": identificação do documento;
    . "Item": colocação do Item na relação de registro do documento;
    . "Quantidade": quantidade de itens do registro;
    . "CATMAT": identificação da categoria do material, quando houver;
    . "Valor Total": valor total do Item da relação;
    . "Empresa Representante ou Fornecedor": Representante do fabricante do Item;
    . "Nome do arquivo PDF": Nome do arquivo que identifica o PDF lido;

## Observação
. não é necessário que todas as opções sejam preenchidas;
. são necessários os Órgãos, descrição e valor unitário;

## Características
. buscar entre os fabricantes de itens
. criar uma tabela com as características de "Marca/Modelo" relacionando: 1. Descrição; 2.Fabricante; 3. Modelo; 4. Características;  5. Ciclo mensal de uso; Garantia do Fabricante 

## Saída:
. Criar uma tabela contendo todos os Itens encontrados nos documento PDF da fonte;
. criar um arquivo no formato markdown
