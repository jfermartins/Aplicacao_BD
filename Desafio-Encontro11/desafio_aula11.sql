USE DB_03361B_JFERNANDA_AULA06;

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS locadora_db;
USE locadora_db;

-- Criação da tabela Generos
CREATE TABLE IF NOT EXISTS Generos (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nome_genero VARCHAR(50) NOT NULL UNIQUE
);

-- Criação da tabela Filmes
CREATE TABLE IF NOT EXISTS Filmes (
    id_filme INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano_lancamento INT,
    nota_avaliacao DECIMAL(3,1),
    id_genero INT,
    FOREIGN KEY (id_genero) REFERENCES Generos(id_genero)
);


USE locadora_db;

-- Inserção de dados na tabela Generos
INSERT IGNORE INTO Generos (nome_genero) VALUES
('Ficção Científica'),
('Drama'),
('Animação'),
('Ação'),
('Comédia'),
('Terror'),
('Fantasia'),
('Documentário');

-- Inserção de dados na tabela Filmes
INSERT INTO Filmes (titulo, ano_lancamento, nota_avaliacao, id_genero) VALUES
('Matrix', 1999, 9.0, (SELECT id_genero FROM Generos WHERE nome_genero = 'Ficção Científica')),
('O Poderoso Chefão', 1972, 9.2, (SELECT id_genero FROM Generos WHERE nome_genero = 'Drama')),
('A Viagem de Chihiro', 2001, 8.6, (SELECT id_genero FROM Generos WHERE nome_genero = 'Animação')),
('Interestelar', 2014, 8.6, (SELECT id_genero FROM Generos WHERE nome_genero = 'Ficção Científica')),
('Blade Runner 2049', 2017, 8.0, (SELECT id_genero FROM Generos WHERE nome_genero = 'Ficção Científica')),
('Pulp Fiction', 1994, 8.9, (SELECT id_genero FROM Generos WHERE nome_genero = 'Drama')),
('O Rei Leão', 1994, 8.5, (SELECT id_genero FROM Generos WHERE nome_genero = 'Animação')),
('Forrest Gump: O Contador de Histórias', 1994, 8.8, (SELECT id_genero FROM Generos WHERE nome_genero = 'Drama')),
('A Origem', 2010, 8.8, (SELECT id_genero FROM Generos WHERE nome_genero = 'Ficção Científica')),
('Parasita', 2019, 8.5, (SELECT id_genero FROM Generos WHERE nome_genero = 'Drama')),
('Toy Story', 1995, 8.3, (SELECT id_genero FROM Generos WHERE nome_genero = 'Animação')),
('Duna', 2021, 7.9, (SELECT id_genero FROM Generos WHERE nome_genero = 'Ficção Científica')),
('O Resgate do Soldado Ryan', 1998, 8.6, (SELECT id_genero FROM Generos WHERE nome_genero = 'Drama')),
('Vingadores: Ultimato', 2019, 8.4, (SELECT id_genero FROM Generos WHERE nome_genero = 'Ação')),
('Clube da Luta', 1999, 8.8, (SELECT id_genero FROM Generos WHERE nome_genero = 'Drama'));

-- Clássicos do Século XX: Quais filmes do catálogo foram lançados antes do ano 2000?
SELECT titulo, ano_lancamento FROM Filmes WHERE ano_lancamento < 2000;

-- Aclamados pela Crítica: Quais filmes têm uma nota de avaliação maior ou igual a 8.8?
SELECT titulo, nota_avaliacao FROM Filmes WHERE nota_avaliacao >= 8.8;

-- Ficção Científica Moderna: Quais filmes são do gênero 'Ficção Científica' E foram lançados a partir de 2010?
SELECT F.titulo, F.ano_lancamento, G.nome_genero FROM Filmes AS F JOIN Generos AS G ON F.id_genero = G.id_genero WHERE G.nome_genero = 'Ficção Científica' AND F.ano_lancamento >= 2010;

-- Sessão da Tarde: Quais filmes são do gênero 'Drama' OU do gênero 'Animação'? 
SELECT F.titulo, G.nome_genero FROM Filmes AS F JOIN Generos AS G ON F.id_genero = G.id_genero WHERE G.nome_genero = 'Drama' OR G.nome_genero = 'Animação';

-- Excluindo um Título: Liste todos os filmes, exceto o filme com o título 'Matrix'.
SELECT titulo FROM Filmes WHERE titulo != 'Matrix';








