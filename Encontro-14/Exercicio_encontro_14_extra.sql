-- Tabela PROFESSOR
-- Matrícula com 6 dígitos, iniciando por 2.
CREATE TABLE PROFESSOR (
    matricula INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    titulacao VARCHAR(50) NOT NULL
) AUTO_INCREMENT = 200000; -- Força o primeiro ID a ser 200000 (ou o próximo disponível)

-- Tabela ALUNO
-- Matrícula com 6 números, iniciando por 1.
CREATE TABLE ALUNO (
    matricula INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15)
) AUTO_INCREMENT = 100000; -- Força o primeiro ID a ser 100000 (ou o próximo disponível)

-- Tabela DISCIPLINA (Sem alteração)
-- id_professor é uma chave estrangeira para PROFESSOR.matricula.
CREATE TABLE DISCIPLINA (
    id INT PRIMARY KEY AUTO_INCREMENT, -- Adicionando AUTO_INCREMENT para o ID da disciplina também
    id_professor INT NOT NULL,
    nome VARCHAR(100) UNIQUE NOT NULL,
    carga_horaria INT NOT NULL,
    CONSTRAINT fk_professor
        FOREIGN KEY (id_professor)
        REFERENCES PROFESSOR (matricula)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Tabela de junção para a relação N:N entre ALUNO e DISCIPLINA (Sem alteração)
CREATE TABLE ALUNO_DISCIPLINA (
    matricula_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    PRIMARY KEY (matricula_aluno, id_disciplina),
    CONSTRAINT fk_aluno
        FOREIGN KEY (matricula_aluno)
        REFERENCES ALUNO (matricula)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_disciplina
        FOREIGN KEY (id_disciplina)
        REFERENCES DISCIPLINA (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Professores
-- Irá gerar matrículas a partir de 200000
INSERT INTO PROFESSOR (nome, email, telefone, titulacao) VALUES
('Dr. Ana Silva', 'ana.silva@escola.edu', '99991-1111', 'Doutorado em Computação'), -- matricula 200000
('Msc. Bruno Costa', 'bruno.costa@escola.edu', '99992-2222', 'Mestrado em Matemática'), -- matricula 200001
('Esp. Carla Dias', 'carla.dias@escola.edu', '99993-3333', 'Especialização em História'); -- matricula 200002

-- Alunos
-- Irá gerar matrículas a partir de 100000
INSERT INTO ALUNO (nome, email, telefone) VALUES
('João Pereira', 'joao.pereira@aluno.edu', '98881-1111'), -- matricula 100000
('Maria Oliveira', 'maria.oliveira@aluno.edu', '98882-2222'), -- matricula 100001
('Pedro Santos', 'pedro.santos@aluno.edu', '98883-3333'), -- matricula 100002
('Sofia Lima', 'sofia.lima@aluno.edu', '98884-4444'), -- matricula 100003
('Lucas Rocha', 'lucas.rocha@aluno.edu', '98885-5555'); -- matricula 100004

-- Disciplinas
-- Irá gerar IDs a partir de 1. Usaremos os IDs gerados para os professores (200000, 200001, 200002)
INSERT INTO DISCIPLINA (id_professor, nome, carga_horaria) VALUES
(200000, 'Computação', 60), -- id 1, Prof Ana Silva
(200001, 'Cálculo I', 80), -- id 2, Prof Bruno Costa
(200001, 'Álgebra Linear', 60), -- id 3, Prof Bruno Costa
(200002, 'História do Brasil', 40); -- id 4, Prof Carla Dias

-- Matrículas (Relação ALUNO_DISCIPLINA)
-- Usaremos os IDs gerados para os alunos (100000, 100001, 100002, 100003, 100004) e disciplinas (1, 2, 3, 4)
INSERT INTO ALUNO_DISCIPLINA (matricula_aluno, id_disciplina) VALUES
(100000, 1), -- João (100000): Computação (1)
(100000, 2), -- João (100000): Cálculo I (2)
(100001, 1), -- Maria (100001): Computação (1)
(100001, 3), -- Maria (100001): Álgebra Linear (3)
(100002, 2), -- Pedro (100002): Cálculo I (2)
(100002, 4), -- Pedro (100002): História do Brasil (4)
(100003, 1), -- Sofia (100003): Computação (1)
(100003, 2), -- Sofia (100003): Cálculo I (2)
(100003, 3), -- Sofia (100003): Álgebra Linear (3)
(100003, 4); -- Sofia (100003): História do Brasil (4)
-- Lucas (100004): Nenhuma disciplina matriculada


-- 1. MOSTRAR O PROFESSOR DE CADA DISCIPLINA
SELECT
    D.nome AS Disciplina,
    P.nome AS Professor
FROM
    DISCIPLINA D
JOIN
    PROFESSOR P ON D.id_professor = P.matricula;

-- 2. MOSTRAR TODOS OS ALUNOS MATRICULADOS NA DISCIPLINA DE "COMPUTAÇÃO"
SELECT
    A.nome AS Aluno
FROM
    ALUNO A
JOIN
    ALUNO_DISCIPLINA AD ON A.matricula = AD.matricula_aluno
JOIN
    DISCIPLINA D ON AD.id_disciplina = D.id
WHERE
    D.nome = 'Computação';

-- 3. MOSTRAR TODOS OS ALUNOS NÃO MATRICULADOS EM UMA DISCIPLINA
SELECT
    A.nome AS Aluno_Nao_Matriculado
FROM
    ALUNO A
LEFT JOIN
    ALUNO_DISCIPLINA AD ON A.matricula = AD.matricula_aluno
WHERE
    AD.matricula_aluno IS NULL;

-- 4. (DESAFIO) MOSTRAR A CONTAGEM DE ALUNOS POR DISCIPLINA E O NOME DO DOCENTE DESTA.
SELECT
    D.nome AS Disciplina,
    P.nome AS Professor,
    COUNT(AD.matricula_aluno) AS Total_Alunos
FROM
    DISCIPLINA D
JOIN
    PROFESSOR P ON D.id_professor = P.matricula
LEFT JOIN
    ALUNO_DISCIPLINA AD ON D.id = AD.id_disciplina
GROUP BY
    D.nome, P.nome
ORDER BY
    Total_Alunos DESC, D.nome;
    
    SELECT * FROM PROFESSOR;
    