USE DB_03361B_JFERNANDA_AULA06;

-- Desafio 1: Mapeamento de Departamentos

DESCRIBE A18_Departamento;
DESCRIBE A18_Funcionario ;

-- lista TODOS os departamentos e 
-- quantos funcionários trabalham em cada um.

SELECT 
    d.nome_departamento AS Departamento,
    CASE 
        WHEN COUNT(f.matricula) = 0 THEN NULL
        ELSE COUNT(f.matricula)
    END AS Quantidade_Funcionarios
FROM A18_Departamento d
LEFT JOIN A18_Funcionario f
    ON d.id = f.id_departamento
GROUP BY d.id, d.nome_departamento
ORDER BY d.nome_departamento;

-- Tarefa: Escreva a consulta SQL que gera este relatório. O nome do
-- funcionário deve aparecer como NULL para o departamento sem funcionários.

SELECT
  d.nome_departamento AS Departamento,
  f.nome AS Nome_Funcionario,
  CASE
    WHEN COUNT(f.matricula) OVER (PARTITION BY d.id) = 0 THEN NULL
    ELSE COUNT(f.matricula) OVER (PARTITION BY d.id)
  END AS Quantidade_Funcionarios
FROM A18_Departamento d
LEFT JOIN A18_Funcionario f
  ON d.id = f.id_departamento
ORDER BY d.nome_departamento, f.nome;
    
-- Desafio 2: Classificação de Salários
-- Problema: Agora, o RH quer um relatório que mostre o nome de cada
-- funcionário e o seu nível salarial (Junior, Pleno ou Senior), de acordo
-- com o salário de cada um.

DESCRIBE A18_Nivel_Cargo;

SELECT 
    CONCAT(f.nome, ' ', f.sobrenome) AS Nome_Funcionario,
    c.salario AS Salario,
    n.nivel AS Nivel_Salarial
FROM A18_Funcionario f
INNER JOIN A18_Cargo c
    ON f.id_cargo = c.id
INNER JOIN A18_Nivel_Cargo n
    ON c.salario BETWEEN n.sal_min AND n.sal_max
ORDER BY c.salario DESC;
    
-- Desafio 3: Relatório Específico
-- Problema: Para finalizar, o RH pediu uma lista específica: eles querem
-- o nome de todos os funcionários do nível 'Pleno' que trabalham no
-- departamento de 'Financeiro'.
-- Tarefa: Escreva a consulta SQL para este filtro.

SELECT 
    CONCAT(f.nome, ' ', f.sobrenome) AS Nome_Funcionario,
    d.nome_departamento AS Departamento,
	c.nome_cargo AS Nome_Cargo,
    n.nivel AS Nivel_Salarial,
    c.salario AS Salario
FROM A18_Funcionario f
INNER JOIN A18_Cargo c
    ON f.id_cargo = c.id
INNER JOIN A18_Nivel_Cargo n
    ON c.salario BETWEEN n.sal_min AND n.sal_max
INNER JOIN A18_Departamento d
    ON f.id_departamento = d.id
WHERE 
    n.nivel = 'Pleno'
    AND d.nome_departamento = 'Financeiro'
ORDER BY f.nome; -- ordenando por nome
