USE DB_03361B_JFERNANDA_AULA06;

-- Pensando em um negócio de uma agenda de celular, dadas as tabelas
-- contatos, telefones e grupos de contatos

CREATE TABLE Grupos_de_Contato (
    id_grupo INT PRIMARY KEY AUTO_INCREMENT,
    nome_grupo VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Contatos (
    id_contato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);
-- Tabela auxiliar para ligar Contatos a Grupos 
CREATE TABLE Contatos_Grupos (
    id_contato INT NOT NULL,
    id_grupo INT NOT NULL,
    PRIMARY KEY (id_contato, id_grupo),
    CONSTRAINT fk_contatos
    FOREIGN KEY (id_contato) REFERENCES Contatos(id_contato),
    CONSTRAINT fk_grupos_de_contato
    FOREIGN KEY (id_grupo) REFERENCES Grupos_de_Contato(id_grupo)
);

-- Criação da tabela Telefones (com ligação direta a Contatos, permitindo múltiplos telefones por contato)
CREATE TABLE Telefones (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(20) NOT NULL,
    id_contato INT NOT NULL,
    CONSTRAINT fk_telefones_contatos
    FOREIGN KEY (id_contato) REFERENCES Contatos(id_contato)
);

INSERT INTO Grupos_de_Contato (nome_grupo) VALUES
("Família"),
("Trabalho"),
("Amigos");


INSERT INTO Contatos (nome, email) VALUES
("João Silva", "joao.silva@example.com"),
("Maria Souza", "maria.souza@example.com"),
("Pedro Santos", "pedro.santos@example.com");


INSERT INTO Contatos_Grupos (id_contato, id_grupo) VALUES
(1, 1), 
(1, 3), 
(2, 2),
(3, 1), 
(3, 3); 


INSERT INTO Telefones (numero, id_contato) VALUES
("11987654321", 1),
("11987654322", 1),
("21912345678", 2),
("21912345679", 2),
("31955551234", 3),
("31955551235", 3);


SELECT * FROM Grupos_de_Contato;

SELECT nome From Contatos;

SELECT * FROM Contatos;

SELECT * FROM Telefones;

SELECT * FROM Contatos_Grupos;


SELECT * FROM Contatos WHERE nome = 'Pedro Santos';

SELECT
    C.nome,
    T.numero
FROM
    Contatos AS C
JOIN
    Telefones AS T ON C.id_contato = T.id_contato
WHERE
    C.nome = 'João Silva';


SELECT
    C.nome,
    G.nome_grupo
FROM
    Contatos AS C
JOIN
    Contatos_Grupos AS CG ON C.id_contato = CG.id_contato
JOIN
    Grupos_de_Contato AS G ON CG.id_grupo = G.id_grupo
WHERE
    G.nome_grupo = 'Família';


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





