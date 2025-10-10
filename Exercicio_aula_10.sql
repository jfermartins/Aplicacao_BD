USE DB_03361B_JFERNANDA_AULA06;
-- Pensando em um negócio de uma agenda de celular, dadas as tabelas
-- contatos, telefones e grupos de contatos

CREATE TABLE IF NOT EXISTS Grupos_contatos (
	id_grupo INT PRIMARY KEY AUTO_INCREMENT,
    nome_grupo VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Contatos (
    id_contato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Telefones(
    id_telefone INT PRIMARY KEY AUTO_INCREMENT, 
    id_contato INT NOT NULL,
    id_grupo INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    CONSTRAINT fk_telefones_contato
    FOREIGN KEY (id_contato) REFERENCES Contatos (id_contato),
    CONSTRAINT fk_telefones_grupo
    FOREIGN KEY (id_grupo) REFERENCES Grupos_contatos (id_grupo)
);


INSERT INTO Grupos_contatos (nome_grupo) VALUES ('Família'), ('Trabalho'), ('Amigos');

INSERT INTO Contatos (nome, email) VALUES
('Ana Silva', 'ana.silva@email.com'),
('Bruno Costa', 'bruno.costa@email.com'),
('Carlos Souza', 'carlos.souza@email.com');

INSERT INTO Contatos (nome, email) VALUES
('Pedro Alcantara', 'pedro.alcantara@email.com');

SELECT * FROM Contatos
WHERE nome = 'Pedro Alcantara';

SELECT * FROM Contatos
WHERE id_contato = 5;



INSERT INTO Telefones (id_contato, id_grupo, numero) VALUES
(1, 1, '(11) 99999-1111'),
(1, 3, '(11) 98888-1111'),
(2, 2, '(21) 97777-2222'),
(3, 3, '(31) 96666-3333');

SELECT * FROM Grupos_contatos;

SELECT * FROM Contatos;

SELECT * FROM Telefones;

SELECT
    c.nome AS "Nome do Contato",
    t.numero AS "Número de Telefone",
    g.nome_grupo AS "Grupo"
FROM
    Telefones t,
    Contatos c,
    Grupos_contatos g
WHERE
    t.id_contato = c.id_contato
    AND t.id_grupo = g.id_grupo
ORDER BY
    c.nome;
    
SELECT
    c.nome AS "Nome do Contato",
    t.numero AS "Número de Telefone",
    g.nome_grupo AS "Grupo"
FROM
    Telefones t
JOIN
    Contatos c ON t.id_contato = c.id_contato
JOIN
    Grupos_contatos g ON t.id_grupo = g.id_grupo
ORDER BY
    c.nome;
    
    
-- DESAFIO

CREATE TABLE IF NOT EXISTS Aula_10_Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

INSERT INTO Aula_10_Produtos (nome_produto, categoria, preco, estoque) VALUES
('Smartphone X', 'Eletrônicos', 2500.00, 50),
('Fone de Ouvido Z', 'Eletrônicos', 350.00, 0),
('Notebook Pro', 'Eletrônicos', 7800.00, 25),
('Caneca Branca', 'Cozinha', 25.00, 200),
('Smartwatch Y', 'Eletrônicos', 1800.00, 40),
('Teclado Gamer', 'Eletrônicos', 650.00, 80),
('Mouse sem Fio', 'Eletrônicos', 150.00, 120);


SELECT
    nome_produto AS "Produto",
    preco AS "Valor"
FROM
    Aula_10_Produtos
WHERE
    categoria = 'Eletrônicos' AND estoque > 0
ORDER BY
    preco DESC
LIMIT 3;





