USE DB_03361B_JFERNANDA_AULA06;

-- Desafio Encontro 14

-- Criar uma consulta que retorne uma lista contendo apenas os clientes que
-- já fizeram alguma venda, mostrando o nome do cliente e o nome do produto que compraram.

-- Usando INNER JOIN "Explícito" (funciona como uma interseção, retornando apenas os registros
-- que possuem uma correspondência em ambas as tabelas. Ou seja, um cliente só aparecerá no
-- resultado se o seu id_cliente estiver tanto na tabela Aula08_Clientes quanto na tabela Aula08_Vendas.
SELECT
    c.nome AS nome_cliente,
    p.nome AS nome_produto
FROM
    Aula08_Clientes c
INNER JOIN
    Aula08_Vendas v ON c.id_cliente = v.id_cliente
INNER JOIN
    Aula08_Produtos p ON v.id_produto = p.id_produto;
    
-- Usando JOIN "Implícito" (Padrão para INNER JOIN)
SELECT
    c.nome AS nome_cliente,
    p.nome AS nome_produto
FROM
    Aula08_Clientes c
JOIN
    Aula08_Vendas v ON c.id_cliente = v.id_cliente
JOIN
    Aula08_Produtos p ON v.id_produto = p.id_produto;
    
    
-- Criar uma consulta que retorne uma lista de TODOS os clientes cadastrados,
-- mostrando o nome do cliente e o produto que compraram. Se um cliente nunca comprou nada,
-- o nome do produto deve aparecer como NULL.
SELECT
    c.nome AS nome_cliente,
    p.nome AS nome_produto
FROM
    Aula08_Clientes c
LEFT JOIN
    Aula08_Vendas v ON c.id_cliente = v.id_cliente
LEFT JOIN
    Aula08_Produtos p ON v.id_produto = p.id_produto;


