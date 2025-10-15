USE DB_03361B_JFERNANDA_AULA06;

SHOW TABLES;

-- Criação da tabela Padaria_Produtos
CREATE TABLE Padaria_Produtos (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Produto VARCHAR(100) NOT NULL UNIQUE,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL CHECK (Preco > 0),
    Estoque INT NOT NULL CHECK (Estoque >= 0)
);


-- Inserir pelo menos 4 registros na tabela de produtos
INSERT INTO Padaria_Produtos (Nome_Produto, Descricao, Preco, Estoque) VALUES
('Pão Francês', 'Pão crocante e fresco, ideal para o café da manhã.', 0.50, 200),
('Bolo de Chocolate', 'Bolo caseiro com cobertura de chocolate.', 25.00, 10),
('Sonho de Creme', 'Doce frito recheado com creme de baunilha.', 4.50, 30),
('Café Expresso', 'Café forte e encorpado.', 3.00, 50);

-- restrição CHECK 
INSERT INTO Padaria_Produtos (Nome_Produto, Descricao, Preco, Estoque)
VALUES ('Coxinha', 'Coxinha de frango com catupiry.', 6.00, -10);

-- Atualizar pelo menos 1 desses registros
UPDATE Padaria_Produtos
SET Preco = 0.60, Estoque = 150
WHERE ID_Produto = 2;

UPDATE Padaria_Produtos
SET Preco = 3.50, Estoque = 150
WHERE Nome_Produto = 'Pão Francês';

-- Excluir 1 desses registros
DELETE FROM Padaria_Produtos
WHERE Nome_Produto = 'Sonho de Creme';

-- Fazer a consulta dessa tabela
SELECT * FROM Padaria_Produtos;
