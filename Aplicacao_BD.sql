CREATE DATABASE DB_03361B_JFERNANDA_AULA06;

USE DB_03361B_JFERNANDA_AULA06;

CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20),
    telefone VARCHAR(20)
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela de Produtos
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    id_produto INT,
    id_cliente INT,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO fornecedores (nome, cnpj, telefone) VALUES
('Papelaria São José', '12.345.678/0001-90', '(11) 2222-3333'),
('Distribuidora Alfa', '98.765.432/0001-10', '(11) 4444-5555');

INSERT INTO clientes (nome, email, telefone) VALUES
('Maria Silva', 'maria.silva@email.com', '(11) 99999-8888'),
('João Pereira', 'joao.pereira@email.com', '(11) 98888-7777');

INSERT INTO produtos (nome, preco, estoque, id_fornecedor) VALUES
('Caneta Azul', 2.50, 100, 1),
('Caderno 10 matérias', 25.00, 50, 2),
('Borracha Branca', 1.20, 200, 1);

INSERT INTO vendas (data_venda, id_produto, id_cliente, quantidade, valor_total) VALUES
('2025-10-06', 1, 1, 10, 25.00),
('2025-10-06', 2, 2, 2, 50.00);

SELECT * FROM clientes;

SELECT 
    v.id_venda,
    c.nome AS cliente,
    p.nome AS produto,
    v.quantidade,
    v.valor_total,
    v.data_venda
FROM 
    vendas v, clientes c, produtos p
WHERE 
    v.id_cliente = c.id_cliente
    AND v.id_produto = p.id_produto;

SELECT 
    v.id_venda,
    c.nome AS cliente,
    p.nome AS produto,
    f.nome AS fornecedor,
    v.quantidade,
    v.valor_total,
    v.data_venda
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN produtos p ON v.id_produto = p.id_produto
JOIN fornecedores f ON p.id_fornecedor = f.id_fornecedor;

