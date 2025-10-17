USE DB_03361B_JFERNANDA_AULA06;

-- Exibir o nome dos produtos e o nome do fornecedor de cada um
SELECT
    p.nome AS nome_produto,
    f.nome AS nome_fornecedor
FROM
    Aula08_Produtos AS p
INNER JOIN
    Aula08_Fornecedores AS f ON p.id_fornecedor = f.id_fornecedor;
    
-- Listar os produtos vendidos com suas quantidades e data da venda
SELECT
    p.nome AS nome_produto,
    v.quantidade,
    v.data_venda
FROM
    Aula08_Vendas AS v
INNER JOIN
    Aula08_Produtos AS p ON v.id_produto = p.id_produto;
    
-- Ver o nome do produto, valor total da venda e nome do fornecedor
SELECT
    p.nome AS nome_produto,
    v.valor_total,
    f.nome AS nome_fornecedor
FROM
    Aula08_Vendas AS v
INNER JOIN
    Aula08_Produtos AS p ON v.id_produto = p.id_produto
INNER JOIN
    Aula08_Fornecedores AS f ON p.id_fornecedor = f.id_fornecedor;
    
-- Exibir produtos com estoque abaixo de 30 unidades e seus fornecedores
SELECT
    p.nome AS nome_produto,
    p.estoque,
    f.nome AS nome_fornecedor
FROM
    Aula08_Produtos AS p
INNER JOIN
    Aula08_Fornecedores AS f ON p.id_fornecedor = f.id_fornecedor
WHERE
    p.estoque < 30;



