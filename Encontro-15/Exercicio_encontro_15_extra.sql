USE DB_03361B_JFERNANDA_AULA06;

-- 1. Consulta que retorna nome e preço do produto, nome, CNPJ e telefone do respectivo fornecedor
DESCRIBE A15_Fornecedor;
DESCRIBE A15_Produto;

SELECT
    p.nome AS nome_produto,
    p.preco_unitario AS preco_produto,
    f.nome AS nome_fornecedor,
    f.cnpj AS cnpj_fornecedor,
    f.telefone AS telefone_fornecedor
FROM
    A15_Produto AS p
JOIN
    A15_Fornecedor AS f ON p.id_fornecedor = f.id;

-- 2. Consulta que retorna o nome e telefone de cada cliente e quantas compras cada cliente já fez
DESCRIBE A15_Cliente;
DESCRIBE A15_Venda;

SELECT
    c.nome AS nome_cliente,
    c.telefone AS telefone_cliente,
    COUNT(v.id) AS total_compras
FROM
    A15_Cliente AS c
LEFT JOIN
    A15_Venda AS v ON c.id = v.id_cliente
GROUP BY
    c.id, c.nome, c.telefone
ORDER BY
    c.nome;

-- 3. (DESAFIO) Consulta que lista o id e data de cada venda, nome e telefone do cliente e o valor
-- total da venda feita
DESCRIBE A15_Venda;
DESCRIBE A15_Cliente;
DESCRIBE A15_Produto_Vendido;
DESCRIBE A15_Produto;

SELECT
    v.id AS id_venda,
    v.data_venda,
    c.nome AS nome_cliente,
    c.telefone AS telefone_cliente,
    SUM(pv.quantidade * p.preco_unitario * (1 - v.desconto)) AS valor_total_venda
FROM
    A15_Venda AS v
JOIN
    A15_Cliente AS c ON v.id_cliente = c.id
JOIN
    A15_Produto_Vendido AS pv ON v.id = pv.id_venda
JOIN
    A15_Produto AS p ON pv.id_produto = p.id
GROUP BY
    v.id, v.data_venda, c.nome, c.telefone
ORDER BY
    v.data_venda, v.id;
    
--  Consulta que lista o id e data de cada venda, nome e telefone do cliente e o valor
-- total da venda feita mostrando também o desconto dado e o valor bruto da venda
SELECT
    v.id AS id_venda,
    v.data_venda,
    c.nome AS nome_cliente,
    c.telefone AS telefone_cliente,
    SUM(pv.quantidade * p.preco_unitario) AS valor_bruto_venda,
    CONCAT(CAST(v.desconto * 100 AS UNSIGNED), '%') AS percentual_desconto,
    ROUND(SUM(pv.quantidade * p.preco_unitario * (1 - v.desconto)), 2) AS valor_total_venda_liquido -- Arredondado para 2 casas decimais
FROM
    A15_Venda AS v
JOIN
    A15_Cliente AS c ON v.id_cliente = c.id
JOIN
    A15_Produto_Vendido AS pv ON v.id = pv.id_venda
JOIN
    A15_Produto AS p ON pv.id_produto = p.id
GROUP BY
    v.id, v.data_venda, c.nome, c.telefone, v.desconto
ORDER BY
    v.data_venda, v.id;
    
    
    
    
    -- Deletar os inserts duplicados
DELETE t1
FROM A15_Produto t1
INNER JOIN A15_Produto t2
WHERE
    t1.id > t2.id AND
    t1.id_fornecedor = t2.id_fornecedor AND
    t1.nome = t2.nome AND
    t1.preco_unitario = t2.preco_unitario;

