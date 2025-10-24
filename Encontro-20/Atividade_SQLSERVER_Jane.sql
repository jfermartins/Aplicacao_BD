CREATE DATABASE Atividade_SQLSERVER_Jane;

USE Atividade_SQLSERVER_Jane;

CREATE TABLE Professor (
    matricula INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Curso (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) UNIQUE NOT NULL,
    total_creditos INT NOT NULL,
    carga_horaria INT NOT NULL
);

CREATE TABLE Disciplina (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_professor INT NOT NULL,
    id_curso INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    creditos INT NOT NULL,
    CONSTRAINT FK_Disciplina_Professor
        FOREIGN KEY (id_professor)
        REFERENCES Professor(matricula),        
    CONSTRAINT FK_Disciplina_Curso
        FOREIGN KEY (id_curso)
        REFERENCES Curso(id),        
    -- Constraint para garantir que o nome da disciplina seja único dentro de um curso
    CONSTRAINT UQ_Disciplina_Curso
        UNIQUE (nome, id_curso)
);


CREATE TABLE Aluno (
    matricula INT PRIMARY KEY IDENTITY(1,1),
    id_curso INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    CONSTRAINT FK_Aluno_Curso
        FOREIGN KEY (id_curso)
        REFERENCES Curso(id)
);

CREATE TABLE Aluno_Disciplina (
    matricula_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    CONSTRAINT FK_AD_Aluno
        FOREIGN KEY (matricula_aluno)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE,        
    CONSTRAINT FK_AD_Disciplina
        FOREIGN KEY (id_disciplina)
        REFERENCES Disciplina(id)
        ON DELETE CASCADE,        
    -- Definindo Chave Primária Composta
    PRIMARY KEY (matricula_aluno, id_disciplina)
);


INSERT INTO Professor (nome, sobrenome, email) VALUES
('Maria', 'Silva', 'maria.silva@escola.com'),
('Carlos', 'Souza', 'carlos.souza@escola.com'),
('Ana', 'Oliveira', 'ana.oliveira@escola.com'),
('Pedro', 'Santos', 'pedro.santos@escola.com'),
('Juliana', 'Costa', 'juliana.costa@escola.com');

INSERT INTO Curso (nome, total_creditos, carga_horaria) VALUES
('Computação', 240, 3600), 
('Administração', 200, 3000),
('Engenharia Civil', 300, 4500),
('Arquitetura', 220, 3300),
('Direito', 260, 3900);

INSERT INTO Disciplina (id_professor, id_curso, nome, carga_horaria, creditos) VALUES
(
    (SELECT matricula FROM Professor WHERE nome = 'Maria'), 
    (SELECT id FROM Curso WHERE nome = 'Computação'), 
    'Aplicação de Banco de Dados', 60, 4
),
(
    (SELECT matricula FROM Professor WHERE nome = 'Carlos'), 
    (SELECT id FROM Curso WHERE nome = 'Computação'), 
    'Análise de Dados', 60, 4
),
(
    (SELECT matricula FROM Professor WHERE nome = 'Ana'), 
    (SELECT id FROM Curso WHERE nome = 'Computação'), 
    'Programação Web', 80, 5
),
(
    (SELECT matricula FROM Professor WHERE nome = 'Pedro'), 
    (SELECT id FROM Curso WHERE nome = 'Administração'), 
    'Contabilidade', 40, 3
),
(
    (SELECT matricula FROM Professor WHERE nome = 'Juliana'), 
    (SELECT id FROM Curso WHERE nome = 'Engenharia Civil'), 
    'Cálculo I', 80, 5
);

INSERT INTO Aluno (id_curso, nome, sobrenome, email) VALUES
(
    (SELECT id FROM Curso WHERE nome = 'Computação'), 
    'João', 'Pereira', 'joao.pereira@aluno.com'
),
(
    (SELECT id FROM Curso WHERE nome = 'Computação'), 
    'Mariana', 'Alves', 'mariana.alves@aluno.com'
),
(
    (SELECT id FROM Curso WHERE nome = 'Administração'), 
    'Rafaela', 'Gomes', 'rafaela.gomes@aluno.com'
),
(
    (SELECT id FROM Curso WHERE nome = 'Direito'), 
    'Felipe', 'Lima', 'felipe.lima@aluno.com'
),
(
    (SELECT id FROM Curso WHERE nome = 'Arquitetura'), 
    'Gabriela', 'Nunes', 'gabriela.nunes@aluno.com'
);

INSERT INTO Aluno_Disciplina (matricula_aluno, id_disciplina) VALUES
(
    (SELECT matricula FROM Aluno WHERE nome = 'João' AND sobrenome = 'Pereira'), 
    (SELECT id FROM Disciplina WHERE nome = 'Aplicação de Banco de Dados')
), -- João matriculado em Aplicação de Banco de Dados
(
    (SELECT matricula FROM Aluno WHERE nome = 'João' AND sobrenome = 'Pereira'), 
    (SELECT id FROM Disciplina WHERE nome = 'Análise de Dados')
), -- João matriculado em Análise de Dados
(
    (SELECT matricula FROM Aluno WHERE nome = 'João' AND sobrenome = 'Pereira'), 
    (SELECT id FROM Disciplina WHERE nome = 'Programação Web')
), -- João matriculado em Programação Web (extra)
(
    (SELECT matricula FROM Aluno WHERE nome = 'Mariana' AND sobrenome = 'Alves'), 
    (SELECT id FROM Disciplina WHERE nome = 'Aplicação de Banco de Dados')
), -- Mariana matriculada em Aplicação de Banco de Dados
(
    (SELECT matricula FROM Aluno WHERE nome = 'Mariana' AND sobrenome = 'Alves'), 
    (SELECT id FROM Disciplina WHERE nome = 'Programação Web')
); -- Mariana matriculada em Programação Web


-- Query 1: Curso
SELECT * FROM Curso;

-- Query 2: Disciplina
SELECT * FROM Disciplina;

-- Query 3: Aluno
SELECT * FROM Aluno;

-- Query 4: Professor
SELECT * FROM Professor;

-- Query 5: Aluno_Disciplina
SELECT * FROM Aluno_Disciplina;

-- Liste todas as disciplinas de "Computação", usando apenas o ID do curso (SEM JOIN);
SELECT 
    id, 
    id_professor, 
    id_curso, 
    nome, 
    carga_horaria, 
    creditos
FROM 
    Disciplina
WHERE 
    id_curso = (SELECT id FROM Curso WHERE nome = 'Computação');

--Liste as disciplinas em que cada aluno está matriculado, com matricula e nome do aluno, 
-- nome do curso, e nome, creditos e carga horária da disciplina;

SELECT
    A.matricula AS matricula_aluno,
    A.nome AS nome_aluno,
    C.nome AS nome_curso,
    D.nome AS nome_disciplina,
    D.creditos AS creditos_disciplina,
    D.carga_horaria AS carga_horaria_disciplina
FROM
    Aluno A
INNER JOIN 
    Aluno_Disciplina AD ON A.matricula = AD.matricula_aluno
INNER JOIN 
    Disciplina D ON AD.id_disciplina = D.id
INNER JOIN 
    Curso C ON A.id_curso = C.id
ORDER BY
    A.matricula, D.nome;

-- Listar as tabelas
SELECT
    name AS NomeDaTabela
FROM
    sys.tables
WHERE
    type = 'U'
ORDER BY
    name;