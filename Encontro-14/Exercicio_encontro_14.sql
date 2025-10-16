USE DB_03361B_JFERNANDA_AULA06;

-- Mostrar Produtos com preço acima de R$5,00
SELECT *
FROM Padaria_Produtos
WHERE Preco > 5.00;

-- Mostrar Produtos com nome contendo "Bolo"
SELECT *
FROM Padaria_Produtos
WHERE Nome_Produto LIKE '%Bolo%';

-- Mostrar Produtos com estoque abaixo de 20 unidades
SELECT *
FROM Padaria_Produtos
WHERE Estoque < 20;

-- Mostrar Produtos com preço entre R$3,00 e R$10,00
SELECT *
FROM Padaria_Produtos
WHERE Preco BETWEEN 3.00 AND 10.00;

-- Mostrar Produtos que começam com "Pão"
SELECT *
FROM Padaria_Produtos
WHERE Nome_Produto LIKE 'Pão%';

-- Mostrar Produtos com nome "Croissant" e estoque maior que 30
SELECT *
FROM Padaria_Produtos
WHERE Nome_Produto = 'Croissant' AND Estoque > 30;





