CREATE DATABASE DB_03361B_JFERNANDA_AULA06;

USE DB_03361B_JFERNANDA_AULA06;

DROP TABLE Vendas CASCADE;

DROP TABLE Produtos CASCADE;

DROP TABLE Clientes CASCADE;

DROP TABLE Fornecedores CASCADE;

-- Pensando em um negócio de papelaria, dadas as tabelas de produtos,
-- vendas e fornecedores, pergunta-se quais comandos para criar, inserir e visualizar
-- os registros dessas tabelas.

CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    id_produto INT,
    id_cliente INT,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

INSERT INTO Fornecedores (nome, cnpj, telefone) VALUES
('Papelaria São José', '12.345.678/0001-90', '(11) 2222-3333'),
('Distribuidora Alfa', '98.765.432/0001-10', '(11) 4444-5555');

INSERT INTO Clientes (nome, cpf, email, telefone) VALUES
('Maria Silva', '87687687678','maria.silva@email.com', '(11) 99999-8888'),
('João Pereira','87687687679','joao.pereira@email.com', '(11) 98888-7777');

INSERT INTO Produtos (nome, preco, estoque, id_fornecedor) VALUES
('Caneta Azul', 2.50, 100, 1),
('Caderno 10 matérias', 25.00, 50, 2),
('Borracha Branca', 1.20, 200, 1);

INSERT INTO Vendas (data_venda, id_produto, id_cliente, quantidade, valor_total) VALUES
('2025-10-06', 1, 1, 10, 25.00),
('2025-10-06', 2, 2, 2, 50.00);

SELECT * 
FROM Fornecedores;

SELECT *
FROM Clientes;

SELECT *
FROM Produtos;

SELECT *
FROM Vendas;

SELECT 
    v.id_venda,
    c.nome AS Cliente,
    p.nome AS Produto,
    v.quantidade,
    v.valor_total,
    v.data_venda
FROM 
    Vendas v, Clientes c, Produtos p
WHERE 
    v.id_cliente = c.id_cliente
    AND v.id_produto = p.id_produto;

SELECT 
    v.id_venda,
    c.nome AS Cliente,
    p.nome AS Produto,
    f.nome AS Fornecedor,
    v.quantidade,
    v.valor_total,
    v.data_venda
FROM Vendas v
JOIN Clientes c ON v.id_cliente = c.id_cliente
JOIN Produtos p ON v.id_produto = p.id_produto
JOIN Fornecedores f ON p.id_fornecedor = f.id_fornecedor;

