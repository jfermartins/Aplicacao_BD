USE DB_03361B_JFERNANDA_AULA06;
-- Você foi contratado para criar um banco de dados para uma padaria que precisa
-- organizar e manipular informações sobre seus produtos, fornecedores e vendas.

CREATE TABLE Aula08_Fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE Aula08_Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE Aula08_Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT fk_fornecedores_produtos
    FOREIGN KEY (id_fornecedor) REFERENCES Aula08_Fornecedores(id_fornecedor)
);

CREATE TABLE Aula08_Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    id_produto INT NOT NULL,
    id_cliente INT,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10,2),
    CONSTRAINT fk_venda_produto
    FOREIGN KEY (id_produto) REFERENCES Aula08_Produtos(id_produto),
    CONSTRAINT fk_venda_cliente
    FOREIGN KEY (id_cliente) REFERENCES Aula08_Clientes(id_cliente)
);

INSERT INTO Aula08_Fornecedores (nome, cnpj, telefone) 
VALUES
('Monte Trigo', '12.345.678/0001-90', '(11) 2222-3333'),
('Distribuidora Açucar', '98.765.432/0001-10', '(11) 4444-5555');

INSERT INTO Aula08_Clientes (nome, cpf, email, telefone)
 VALUES
('Maria Silva', '87687687678','maria.silva@email.com', '(11) 99999-8888'),
('João Pereira','87687687679','joao.pereira@email.com', '(11) 98888-7777');

INSERT INTO Aula08_Produtos (nome, preco, estoque, id_fornecedor) 
VALUES
('Bolo de Chocolate', 12.50, 20, 1),
('Bolo de Fubá', 9.00, 25, 2),
('Sonho', 3.20, 50, 1);

INSERT INTO Aula08_Vendas (data_venda, id_produto, id_cliente, quantidade, valor_total) 
VALUES
('2025-06-03', 1, 1, 10, 125.00),
('2025-06-03', 2, 2, 2, 18.00);

SELECT * 
FROM Aula08_Fornecedores;

SELECT *
FROM Aula08_Clientes;

SELECT *
FROM Aula08_Produtos;

SELECT *
FROM Aula08_Vendas;

SELECT 
    v.id_venda,
    c.nome AS Cliente,
    p.nome AS Produto,
    v.quantidade,
    v.valor_total,
    v.data_venda
FROM 
    Aula08_Vendas v, Aula08_Clientes c, Aula08_Produtos p
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
FROM Aula08_Vendas v
JOIN Aula08_Clientes c ON v.id_cliente = c.id_cliente
JOIN Aula08_Produtos p ON v.id_produto = p.id_produto
JOIN Aula08_Fornecedores f ON p.id_fornecedor = f.id_fornecedor;

-- Você foi contratado para criar o banco de dados de uma locadora de carros. 
-- O sistema precisa armazenar informações sobre os clientes, os automóveis disponíveis e as locações realizadas. 

USE DB_03361B_JFERNANDA_AULA06;

CREATE TABLE Cliente_Locadora (
     id_cliente INT PRIMARY KEY AUTO_INCREMENT,
     nome VARCHAR(50) NOT NULL,
     sobrenome VARCHAR(50) NOT NULL,
     telefone VARCHAR(20),
     email VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Automovel (
    id_automovel INT PRIMARY KEY AUTO_INCREMENT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    tipo VARCHAR(50),
    placa VARCHAR(10) UNIQUE NOT NULL,
    ano INT,
    cor VARCHAR(30),
    valor_diaria DECIMAL(10, 2) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

CREATE TABLE Locacao (
	 id_locacao INT PRIMARY KEY AUTO_INCREMENT,
	 id_cliente INT NOT NULL,
     id_automovel INT NOT NULL,
     data_inicio_locacao DATE NOT NULL,
     data_fim_locacao DATE NOT NULL,
     valor_total DECIMAL(10, 02),
     status_locacao VARCHAR(20) DEFAULT 'Ativa',
     CONSTRAINT fk_cliente_locacao
     FOREIGN KEY (id_cliente) REFERENCES Cliente_Locadora (id_cliente),
     CONSTRAINT fk_automovel_locacao
     FOREIGN KEY (id_automovel) REFERENCES Automovel (id_automovel)
     );
     
     
INSERT INTO Cliente_Locadora (nome, sobrenome, telefone, email) 
VALUES
('Ana', 'Silva', '(11) 98765-4321', 'ana.silva@email.com'),
('Bruno', 'Costa', '(21) 91234-5678', 'bruno.costa@email.com'),
('Carla', 'Mendes', '(31) 99988-7766', 'carla.mendes@email.com'),
('Daniel', 'Oliveira', '(41) 98877-6655', 'daniel.oliveira@email.com'),
('Eduarda', 'Pereira', '(51) 97766-5544', 'eduarda.pereira@email.com');

INSERT INTO Automovel (marca, modelo, tipo, placa, ano, cor, valor_diaria, disponivel) 
VALUES
('Fiat', 'Mobi', 'Hatch', 'ABC1D23', 2022, 'Branco', 95.50, TRUE),
('Hyundai', 'HB20', 'Hatch', 'DEF4E56', 2023, 'Prata', 110.00, TRUE),
('Chevrolet', 'Onix Plus', 'Sedan', 'GHI7F89', 2023, 'Preto', 125.75, TRUE),
('Jeep', 'Renegade', 'SUV', 'JKL0G12', 2022, 'Cinza', 180.00, TRUE),
('Toyota', 'Corolla', 'Sedan', 'MNO3H45', 2024, 'Azul', 210.50, TRUE);

INSERT INTO Locacao (id_cliente, id_automovel, data_inicio_locacao, data_fim_locacao, valor_total, status_locacao) 
VALUES
(1, 2, '2025-09-01', '2025-09-05', 440.00, 'Finalizada'),
(3, 1, '2025-09-10', '2025-09-17', 668.50, 'Finalizada'),
(2, 4, '2025-10-05', '2025-10-12', NULL, 'Ativa'),
(5, 3, '2025-10-07', '2025-10-10', NULL, 'Ativa'),
(4, 5, '2025-10-08', '2025-10-15', NULL, 'Ativa');


SELECT * FROM Cliente_Locadora;

SELECT * FROM Automovel WHERE disponivel = TRUE;

SELECT 
    C.nome,
    C.sobrenome,
    A.marca,
    A.modelo,
    L.data_inicio_locacao,
    L.data_fim_locacao
FROM 
    Locacao AS L
JOIN 
    Cliente_Locadora AS C ON L.id_cliente = C.id_cliente
JOIN 
    Automovel AS A ON L.id_automovel = A.id_automovel;
    
    SELECT 
    A.marca,
    A.modelo,
    A.placa,
    L.data_inicio_locacao,
    L.data_fim_locacao,
    C.nome AS nome_cliente
FROM 
    Locacao AS L
JOIN 
    Automovel AS A ON L.id_automovel = A.id_automovel
JOIN
    Cliente_Locadora AS C ON L.id_cliente = C.id_cliente
WHERE 
    '2025-09-12' BETWEEN L.data_inicio_locacao AND L.data_fim_locacao;
    
    SELECT 
    C.nome,
    C.sobrenome,
    A.marca,
    A.modelo,
    L.data_inicio_locacao,
    L.data_fim_locacao
FROM 
    Locacao AS L,
    Cliente_Locadora AS C,
    Automovel AS A
WHERE 
    L.id_cliente = C.id_cliente 
    AND L.id_automovel = A.id_automovel;
    
    SELECT 
    A.marca,
    A.modelo,
    A.placa,
    L.data_inicio_locacao,
    L.data_fim_locacao,
    C.nome AS nome_cliente
FROM 
    Locacao AS L,
    Automovel AS A,
    Cliente_Locadora AS C
WHERE 
    L.id_automovel = A.id_automovel
    AND L.id_cliente = C.id_cliente
    AND '2025-09-12' BETWEEN L.data_inicio_locacao AND L.data_fim_locacao;

-- A coordenação pedagógica solicitou que você desenvolva um sistema para organizar comentários e avaliações
-- feitos por alunos sobre os professores e cursos.

USE DB_03361B_JFERNANDA_AULA06;

CREATE TABLE Curso (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Aluno (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    id_curso INT NOT NULL, 
    CONSTRAINT fk_id_curso
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Professor (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome_professor VARCHAR(100) NOT NULL
);

CREATE TABLE Professor_curso (
    id_professor INT NOT NULL,
    id_curso INT NOT NULL,
    CONSTRAINT pk_professor_Curso 
    PRIMARY KEY (id_professor, id_curso),
    CONSTRAINT fk_professor_curso_professor 
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    CONSTRAINT fk_professor_curso_curso 
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Comentario (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    comentario TEXT,
    nota_professor DECIMAL(3,1),
    data_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_aluno INT NOT NULL,
    id_professor INT NOT NULL,
    id_curso INT,
    CONSTRAINT FK_comentario_aluno 
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_comentario_professor 
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    CONSTRAINT FK_comentario_curso 
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

INSERT INTO Curso (nome_curso) 
VALUES
('Ciência da Computação'),
('Engenharia de Software'),
('Análise e Desenvolvimento de Sistemas'),
('Design Digital');

INSERT INTO Professor (nome_professor) 
VALUES
('Dr. Alan Turing'),
('Dra. Ada Lovelace'),
('Dr. Linus Torvalds'),
('Dra. Grace Hopper');

INSERT INTO Aluno (nome, sobrenome, id_curso) 
VALUES
('João', 'Silva', 1),
('Maria', 'Santos', 1),
('Pedro', 'Almeida', 2),
('Ana', 'Oliveira', 3),
('Carlos', 'Pereira', 3),
('Beatriz', 'Costa', 4);


INSERT INTO Professor_curso (id_professor, id_curso) 
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(4, 3),
(4, 4);

INSERT INTO Comentario (comentario, nota_professor, id_aluno, id_professor, id_curso) 
VALUES
('Ótima didática, aula muito clara!', 9.5, 1, 1, 1), 
('A matéria é complexa, mas o professor explica bem.', 8.0, 3, 1, 2),
('A professora é uma inspiração! Adorei a aula.', 10.0, 2, 2, 1),
('Gostei dos exemplos práticos.', 8.5, 4, 2, 3),
('Achei a avaliação muito difícil e o conteúdo corrido.', 5.5, 3, 3, 2),
('Aula muito dinâmica e interessante.', 9.0, 6, 4, 4);

SELECT
    a.nome,
    a.sobrenome,
    c.nome_curso
FROM
    Aluno a
JOIN
    Curso c ON a.id_curso = c.id_curso
ORDER BY
    c.nome_curso, a.nome;
    
    
SELECT
    p.nome_professor,
    c.nome_curso
FROM
    Professor p
JOIN
    Professor_curso pc ON p.id_professor = pc.id_professor
JOIN
    Curso c ON pc.id_curso = c.id_curso
ORDER BY
    p.nome_professor, c.nome_curso;
    
SELECT
    p.nome_professor,
    c.nota_professor,
    c.comentario,
    a.nome AS nome_aluno,
    a.sobrenome AS sobrenome_aluno
FROM
    Comentario c
JOIN
    Professor p ON c.id_professor = p.id_professor
JOIN
    Aluno a ON c.id_aluno = a.id_aluno
ORDER BY
    p.nome_professor, c.nota_professor DESC;
    
SELECT
    p.nome_professor,
    a.nome AS nome_aluno,
    c.nota_professor,
    c.comentario
FROM
    Comentario c
JOIN
    Professor p ON c.id_professor = p.id_professor
JOIN
    Aluno a ON c.id_aluno = a.id_aluno
WHERE
    c.nota_professor < 6.0;
    
SELECT
    p.nome_professor,
    a.nome AS nome_aluno,
    c.nota_professor,
    c.comentario
FROM
    Comentario c
JOIN
    Professor p ON c.id_professor = p.id_professor
JOIN
    Aluno a ON c.id_aluno = a.id_aluno
WHERE
    c.nota_professor > 6.0
ORDER BY
    c.nota_professor DESC;
    
SELECT
    p.nome_professor,
    COUNT(c.id_comentario) AS total_de_avaliacoes,
    AVG(c.nota_professor) AS media_das_notas
FROM
    Professor p
JOIN
    Comentario c ON p.id_professor = c.id_professor
GROUP BY
    p.id_professor, p.nome_professor
ORDER BY
    media_das_notas DESC;
    
SELECT
    p.nome_professor,
    COUNT(c.id_comentario) AS total_de_avaliacoes,
    ROUND(AVG(c.nota_professor), 2) AS media_das_notas
FROM
    Professor p
JOIN
    Comentario c ON p.id_professor = c.id_professor
GROUP BY
    p.id_professor, p.nome_professor
ORDER BY
    media_das_notas DESC;
    
    
SELECT
    a.nome,
    a.sobrenome,
    c.nome_curso
FROM
    Aluno a,
    Curso c
WHERE
    a.id_curso = c.id_curso
ORDER BY
    c.nome_curso, a.nome;
    
    
SELECT
    p.nome_professor,
    c.nome_curso
FROM
    Professor p,
    Professor_curso pc,
    Curso c
WHERE
    p.id_professor = pc.id_professor
    AND pc.id_curso = c.id_curso
ORDER BY
    p.nome_professor, c.nome_curso;
    

SELECT
    p.nome_professor,
    c.nota_professor,
    c.comentario,
    a.nome AS nome_aluno,
    a.sobrenome AS sobrenome_aluno
FROM
    Comentario c,
    Professor p,
    Aluno a
WHERE
    c.id_professor = p.id_professor
    AND c.id_aluno = a.id_aluno
ORDER BY
    p.nome_professor, c.nota_professor DESC;
    

INSERT INTO Curso (nome_curso) 
VALUES ('Ciência de Dados');

SELECT
    c.id_curso,
    c.nome_curso
FROM
    Curso c
LEFT JOIN
    Aluno a ON c.id_curso = a.id_curso
WHERE
    a.id_aluno IS NULL;
    
SELECT
    id_curso,
    nome_curso
FROM
    Curso
WHERE
    id_curso NOT IN (SELECT DISTINCT id_curso 
    FROM Aluno 
    WHERE id_curso IS NOT NULL);



    


















