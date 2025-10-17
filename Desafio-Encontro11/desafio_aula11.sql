-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS locadora_db_Jane;
USE locadora_db_Jane;

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
    CONSTRAINT fk_filmes_genero
    FOREIGN KEY (id_genero) REFERENCES Generos(id_genero)
);

-- Criação da tabela Vendas
CREATE TABLE IF NOT EXISTS Vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_filme INT NOT NULL,
    quantidade INT NOT NULL,
    data_venda DATE NOT NULL,
    CONSTRAINT fk_vendas_filme
    FOREIGN KEY (id_filme) REFERENCES Filmes(id_filme)
);



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

-- Inserção de dados na tabela Vendas
INSERT INTO Vendas (id_filme, quantidade, data_venda) VALUES
((SELECT id_filme FROM Filmes WHERE titulo = 'Matrix'), 2, '2025-01-10'),
((SELECT id_filme FROM Filmes WHERE titulo = 'O Poderoso Chefão'), 1, '2025-01-15'),
((SELECT id_filme FROM Filmes WHERE titulo = 'A Viagem de Chihiro'), 3, '2025-01-12'),
((SELECT id_filme FROM Filmes WHERE titulo = 'Interestelar'), 1, '2025-02-01'),
((SELECT id_filme FROM Filmes WHERE titulo = 'Matrix'), 1, '2025-02-05'),
((SELECT id_filme FROM Filmes WHERE titulo = 'Pulp Fiction'), 2, '2025-02-10'),
((SELECT id_filme FROM Filmes WHERE titulo = 'O Rei Leão'), 1, '2025-02-15'),
((SELECT id_filme FROM Filmes WHERE titulo = 'A Origem'), 2, '2025-03-01'),
((SELECT id_filme FROM Filmes WHERE titulo = 'Vingadores: Ultimato'), 3, '2025-03-05');

-- 1) Clássicos do Século XX: Quais filmes do catálogo foram lançados antes do ano 2000?
SELECT titulo, ano_lancamento FROM Filmes WHERE ano_lancamento < 2000;

-- 2) Aclamados pela Crítica: Quais filmes têm uma nota de avaliação maior ou igual a 8.8?
SELECT titulo, nota_avaliacao FROM Filmes WHERE nota_avaliacao >= 8.8;

-- 3) Ficção Científica Moderna: Quais filmes são do gênero 'Ficção Científica' E foram lançados a partir de 2010?
SELECT F.titulo, F.ano_lancamento, G.nome_genero FROM Filmes AS F JOIN Generos AS G ON F.id_genero = G.id_genero WHERE G.nome_genero = 'Ficção Científica' AND F.ano_lancamento >= 2010;

-- 4) Sessão da Tarde: Quais filmes são do gênero 'Drama' OU do gênero 'Animação'? 
SELECT F.titulo, G.nome_genero FROM Filmes AS F JOIN Generos AS G ON F.id_genero = G.id_genero WHERE G.nome_genero = 'Drama' OR G.nome_genero = 'Animação';

-- 5) Excluindo um Título: Liste todos os filmes, exceto o filme com o título 'Matrix'.
SELECT titulo FROM Filmes WHERE titulo != 'Matrix';
-- OU
SELECT TITULO from Filmes WHERE titulo <> 'Matrix';








