-- 1. CRIAR: Crie um banco de dados meu_dia_a_dia_SEU_NOME (em SEU_NOME substitua pelo seu nome) e, dentro dele, uma tabela tarefas
CREATE DATABASE IF NOT EXISTS meu_dia_a_dia_nanda;
USE meu_dia_a_dia_nanda;

CREATE TABLE IF NOT EXISTS tarefas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(200) NOT NULL,
    status VARCHAR(20)
);

-- 2. INSERIR: Insira 3 tarefas na tabela, todas com o status inicial 'Pendente'
INSERT INTO tarefas (descricao, status) VALUES
('Estudar SQL', 'Pendente'),
('Fazer compras', 'Pendente'),
('Ligar para o cliente', 'Pendente');

-- 3. ATUALIZAR: Altere o status de uma tarefa para 'Em Andamento' e de outra para 'Concluído'
UPDATE tarefas SET status = 'Em Andamento' WHERE id = 1;
UPDATE tarefas SET status = 'Concluído' WHERE id = 2;

-- 4. ALTERAR: Adicione uma nova coluna prioridade (INT) à tabela. Em seguida, use UPDATE para definir a prioridade 1 para a tarefa que ainda está pendente
ALTER TABLE tarefas ADD COLUMN prioridade INT;
UPDATE tarefas SET prioridade = 1 WHERE id = 3;

-- 5. VERIFICAR: Inclua um SELECT * FROM tarefas; no final do script para exibir o resultado
SELECT * FROM tarefas;