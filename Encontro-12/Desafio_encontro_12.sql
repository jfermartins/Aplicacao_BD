-- Desafio encontro 12

-- Comandos GRANT para configurar permissões na tabela empresa_db.vendas

-- Ana, a Analista de BI: Apenas ler e analisar os dados.
GRANT SELECT ON empresa_db.vendas TO 'ana.analista'@'%';

-- Bruno, o Estagiário de Vendas: Apenas cadastrar novas vendas.
GRANT INSERT ON empresa_db.vendas TO 'bruno.estagiario'@'%';

-- Carla, a Gerente de Vendas: Controle total (ver, cadastrar, alterar e apagar).
GRANT SELECT, INSERT, UPDATE, DELETE ON empresa_db.vendas TO 'carla.gerente'@'%';