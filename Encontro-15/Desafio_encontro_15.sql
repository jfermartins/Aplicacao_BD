-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS livraria_db_Jane;
USE livraria_db_Jane;

-- Tabela para Autores
CREATE TABLE IF NOT EXISTS Autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome_autor VARCHAR(255) NOT NULL UNIQUE
);

-- Tabela para Livros
CREATE TABLE IF NOT EXISTS Livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo_livro VARCHAR(255) NOT NULL,
    id_autor INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

-- Tabela para Vendas (registra cada item vendido em uma transação)
CREATE TABLE IF NOT EXISTS Vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT NOT NULL,
    quantidade INT NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);

-- Populando as tabelas
-- Autores
INSERT IGNORE INTO Autores (nome_autor) VALUES ('Machado de Assis');
INSERT IGNORE INTO Autores (nome_autor) VALUES ('George Orwell');
INSERT IGNORE INTO Autores (nome_autor) VALUES ('Monteiro Lobato');
INSERT IGNORE INTO Autores (nome_autor) VALUES ('Clarice Lispector');

-- Livros
INSERT IGNORE INTO Livros (titulo_livro, id_autor) VALUES ('Dom Casmurro', (SELECT id_autor FROM Autores WHERE nome_autor = 'Machado de Assis'));
INSERT IGNORE INTO Livros (titulo_livro, id_autor) VALUES ('A Revolução dos Bichos', (SELECT id_autor FROM Autores WHERE nome_autor = 'George Orwell'));
INSERT IGNORE INTO Livros (titulo_livro, id_autor) VALUES ('1984', (SELECT id_autor FROM Autores WHERE nome_autor = 'George Orwell'));
INSERT IGNORE INTO Livros (titulo_livro, id_autor) VALUES ('Sítio do Picapau Amarelo', (SELECT id_autor FROM Autores WHERE nome_autor = 'Monteiro Lobato'));
INSERT IGNORE INTO Livros (titulo_livro, id_autor) VALUES ('A Hora da Estrela', (SELECT id_autor FROM Autores WHERE nome_autor = 'Clarice Lispector'));

-- Vendas (apenas para livros que devem ter vendas, Dom Casmurro e A Revolução dos Bichos não terão vendas iniciais)
INSERT INTO Vendas (id_livro, quantidade) VALUES ((SELECT id_livro FROM Livros WHERE titulo_livro = '1984'), 2);
INSERT INTO Vendas (id_livro, quantidade) VALUES ((SELECT id_livro FROM Livros WHERE titulo_livro = 'Sítio do Picapau Amarelo'), 1);
INSERT INTO Vendas (id_livro, quantidade) VALUES ((SELECT id_livro FROM Livros WHERE titulo_livro = 'A Hora da Estrela'), 3);


-- Relatório 1 (Catálogo Completo): Título de cada livro e o nome do seu respectivo autor.
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
JOIN
    Autores AS A ON L.id_autor = A.id_autor;

-- Relatório 2 (Itens Vendidos): Título dos livros que foram vendidos e a quantidade vendida em cada transação.
SELECT
    L.titulo_livro,
    V.quantidade
FROM
    Vendas AS V
JOIN
    Livros AS L ON V.id_livro = L.id_livro;

-- Relatório 3 (Detalhes da Venda): Título do livro vendido, o nome do autor e a quantidade vendida.
SELECT
    L.titulo_livro,
    A.nome_autor,
    V.quantidade
FROM
    Vendas AS V
JOIN
    Livros AS L ON V.id_livro = L.id_livro
JOIN
    Autores AS A ON L.id_autor = A.id_autor;

-- Relatório 4 (Status de Vendas de Todos os Livros): Lista de TODOS os livros do catálogo e a quantidade vendida. Se um livro nunca foi vendido, a quantidade deve aparecer como NULL.
SELECT
    L.titulo_livro,
    A.nome_autor,
    SUM(V.quantidade) AS quantidade_vendida
FROM
    Livros AS L
JOIN
    Autores AS A ON L.id_autor = A.id_autor
LEFT JOIN
    Vendas AS V ON L.id_livro = V.id_livro
GROUP BY
    L.id_livro, L.titulo_livro, A.nome_autor;
    
-- Utilizando TODOS os JOINS
USE livraria_db_Jane;

-- Relatório 1 (Catálogo Completo - INNER JOIN): Título de cada livro e o nome do seu respectivo autor.
-- Mostra apenas livros que têm autores e autores que têm livros.
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor;

-- Relatório 2 (Itens Vendidos - INNER JOIN): Título dos livros que foram vendidos e a quantidade vendida em cada transação.
-- Mostra apenas vendas que têm livros e livros que foram vendidos.
SELECT
    L.titulo_livro,
    V.quantidade
FROM
    Vendas AS V
INNER JOIN
    Livros AS L ON V.id_livro = L.id_livro;

-- Relatório 3 (Detalhes da Venda - INNER JOIN): Título do livro vendido, o nome do autor e a quantidade vendida.
-- Mostra apenas vendas que têm livros e autores associados.
SELECT
    L.titulo_livro,
    A.nome_autor,
    V.quantidade
FROM
    Vendas AS V
INNER JOIN
    Livros AS L ON V.id_livro = L.id_livro
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor;

-- Relatório 4 (Status de Vendas de Todos os Livros - LEFT JOIN): Lista de TODOS os livros do catálogo e a quantidade vendida.
-- Se um livro nunca foi vendido, a quantidade deve aparecer como NULL.
-- Inclui todos os livros (esquerda) e as vendas correspondentes (direita, se existirem).
SELECT
    L.titulo_livro,
    A.nome_autor,
    SUM(V.quantidade) AS quantidade_vendida
FROM
    Livros AS L
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor
LEFT JOIN
    Vendas AS V ON L.id_livro = V.id_livro
GROUP BY
    L.id_livro, L.titulo_livro, A.nome_autor;

-- Exemplo de RIGHT JOIN (Mostra todos os autores e os livros que eles escreveram)
-- Neste caso, é similar ao LEFT JOIN entre Autores e Livros, mas com a ordem invertida.
-- Inclui todos os autores (direita) e os livros correspondentes (esquerda, se existirem).
SELECT
    A.nome_autor,
    L.titulo_livro
FROM
    Livros AS L
RIGHT JOIN
    Autores AS A ON L.id_autor = A.id_autor;

-- Exemplo de FULL OUTER JOIN (simulado em MySQL, que não tem FULL OUTER JOIN nativo)
-- Mostra todos os livros e todos os autores, unindo correspondências e mostrando NULL onde não há.
-- Esta consulta combina o resultado de um LEFT JOIN e um RIGHT JOIN (excluindo a interseção para evitar duplicatas, ou usando UNION ALL e filtrando).
-- Para MySQL, uma forma comum é usar UNION de LEFT JOIN e RIGHT JOIN.
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
LEFT JOIN
    Autores AS A ON L.id_autor = A.id_autor
UNION
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
RIGHT JOIN
    Autores AS A ON L.id_autor = A.id_autor
WHERE
    L.id_livro IS NULL; -- Filtra para incluir apenas os autores sem livros do RIGHT JOIN

-- Exemplo de LEFT EXCLUDING JOIN (Livros que não foram vendidos)
-- Mostra todos os livros que não possuem nenhum registro na tabela Vendas.
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor
LEFT JOIN
    Vendas AS V ON L.id_livro = V.id_livro
WHERE
    V.id_venda IS NULL;

-- Exemplo de RIGHT EXCLUDING JOIN (Autores que não escreveram nenhum livro)
-- Mostra todos os autores que não possuem nenhum registro na tabela Livros.
SELECT
    A.nome_autor
FROM
    Autores AS A
LEFT JOIN
    Livros AS L ON A.id_autor = L.id_autor
WHERE
    L.id_livro IS NULL;
