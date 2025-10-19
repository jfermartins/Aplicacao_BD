USE DB_03361B_JFERNANDA_AULA06;

CREATE TABLE A15_Cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE A15_Fornecedor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL
);

CREATE TABLE A15_Produto (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_fornecedor INT,
    nome VARCHAR(100) NOT NULL,
    preco_unitario DECIMAL(10, 2),
    CHECK(preco_unitario > 0.0),
    CONSTRAINT fk_produto_fornecedor
    FOREIGN KEY (id_fornecedor) REFERENCES A15_Fornecedor(id)
);

CREATE TABLE A15_Venda (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    data_venda DATE NOT NULL,
    desconto DECIMAL(10, 2)
    CHECK(desconto >= 0.0 AND desconto <= 1.0),
    CONSTRAINT fk_venda_produto2
    FOREIGN KEY (id_cliente) REFERENCES A15_Cliente(id)
);

CREATE TABLE A15_Produto_Vendido (
	id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT
);

INSERT INTO A15_Cliente (nome, telefone) VALUES
('Ana Beatriz Silva', '(11) 98811-2233'),
('Bruno Oliveira', '(21) 98745-6612'),
('Carla Menezes', '(31) 98456-7890'),
('Diego Santos', '(41) 99912-3344'),
('Eduarda Lima', '(51) 98123-9988'),
('Felipe Rocha', '(61) 98222-4411'),
('Gabriela Torres', '(71) 98766-5500'),
('Henrique Souza', '(81) 98900-1122'),
('Isabela Ferreira', '(91) 98411-2233'),
('João Pedro Almeida', '(85) 98822-3344'),
('Karen Duarte', '(19) 98111-6677'),
('Leonardo Pires', '(27) 98777-8899'),
('Mariana Costa', '(62) 98555-4433'),
('Natália Gomes', '(92) 98200-7766'),
('Otávio Moreira', '(34) 98444-2233'),
('Patrícia Rezende', '(47) 98666-9988'),
('Rafael Martins', '(13) 98712-1100'),
('Sabrina Andrade', '(14) 98800-2233'),
('Thiago Azevedo', '(17) 98999-3344'),
('Vitória Nunes', '(16) 98222-4455');

INSERT INTO A15_Fornecedor (nome, cnpj, telefone, email) VALUES
('Sabor Brasil Alimentos LTDA', '12.345.678/0001-11', '(11) 3101-2233', 'contato@saborbrasil.com.br'),
('Delícia Alimentos e Bebidas ME', '23.456.789/0001-22', '(21) 3222-3344', 'vendas@deliciaalimentos.com.br'),
('Campo Verde Produtos Naturais LTDA', '34.567.890/0001-33', '(31) 3333-4455', 'comercial@campoverde.com.br'),
('Doce Vida Confeitaria Industrial S/A', '45.678.901/0001-44', '(41) 3444-5566', 'atendimento@docevida.com.br'),
('NutriMais Distribuidora de Alimentos LTDA', '56.789.012/0001-55', '(51) 3555-6677', 'contato@nutrimais.com.br'),
('Serrana Laticínios EIRELI', '67.890.123/0001-66', '(61) 3666-7788', 'vendas@serranalaticinios.com.br'),
('Bom Grão Cereais LTDA', '78.901.234/0001-77', '(71) 3777-8899', 'sac@bomgrao.com.br'),
('Fazenda Real Produtos Orgânicos ME', '89.012.345/0001-88', '(81) 3888-9900', 'contato@fazendareal.com.br'),
('Maré Alta Pescados LTDA', '90.123.456/0001-99', '(91) 3999-1010', 'vendas@marealtapescados.com.br'),
('PanGourmet Panificadora Industrial LTDA', '11.234.567/0001-10', '(85) 4000-1122', 'comercial@pangourmet.com.br'),
('Café do Cerrado Torrefação LTDA', '22.345.678/0001-21', '(19) 4111-2233', 'sac@cafedocerrado.com.br'),
('Frutaria Nacional Distribuição de Hortifrutis ME', '33.456.789/0001-32', '(27) 4222-3344', 'contato@frutarianacional.com.br'),
('Doce Campo Mel e Derivados LTDA', '44.567.890/0001-43', '(62) 4333-4455', 'vendas@docecampo.com.br'),
('Sabor do Mar Produtos Alimentícios LTDA', '55.678.901/0001-54', '(92) 4444-5566', 'comercial@sabordomar.com.br'),
('Granja Bela Vista Avicultura LTDA', '66.789.012/0001-65', '(34) 4555-6677', 'contato@granjabelavista.com.br'),
('Casa das Massas LTDA', '77.890.123/0001-76', '(47) 4666-7788', 'vendas@casadasmassas.com.br'),
('Frescor da Serra Laticínios ME', '88.901.234/0001-87', '(13) 4777-8899', 'contato@frescordaserra.com.br'),
('VerdeVale Produtos Congelados LTDA', '99.012.345/0001-98', '(14) 4888-9900', 'comercial@verdevale.com.br'),
('Raiz & Grão Produtos Naturais EIRELI', '10.123.456/0001-09', '(17) 4999-1011', 'vendas@raizegrao.com.br'),
('Bom Sabor Refeições Coletivas LTDA', '21.234.567/0001-20', '(16) 5000-2122', 'contato@bomsaborrefeicoes.com.br');

INSERT INTO A15_Produto (id_fornecedor, nome, preco_unitario) VALUES
-- 1. Sabor Brasil Alimentos LTDA
(1, 'Arroz Branco Tipo 1 5kg', 23.90),
(1, 'Feijão Carioca 1kg', 8.50),
(1, 'Farinha de Trigo 1kg', 6.20),

-- 2. Delícia Alimentos e Bebidas ME
(2, 'Suco Natural de Laranja 1L', 7.90),
(2, 'Refrigerante de Cola 2L', 6.80),
(2, 'Água Mineral sem Gás 500ml', 2.50),

-- 3. Campo Verde Produtos Naturais LTDA
(3, 'Granola Integral 1kg', 18.90),
(3, 'Aveia em Flocos 500g', 7.40),
(3, 'Linhaça Dourada 250g', 9.20),

-- 4. Doce Vida Confeitaria Industrial S/A
(4, 'Bolo de Chocolate 500g', 14.50),
(4, 'Biscoito Recheado 140g', 4.80),
(4, 'Pão de Mel 60g', 3.90),

-- 5. NutriMais Distribuidora de Alimentos LTDA
(5, 'Macarrão Espaguete 500g', 5.20),
(5, 'Molho de Tomate Tradicional 340g', 4.10),
(5, 'Arroz Parboilizado 5kg', 25.90),

-- 6. Serrana Laticínios EIRELI
(6, 'Leite Integral 1L', 5.50),
(6, 'Queijo Mussarela 500g', 28.90),
(6, 'Iogurte Natural 170g', 3.40),

-- 7. Bom Grão Cereais LTDA
(7, 'Milho para Pipoca 500g', 6.10),
(7, 'Farinha de Milho Amarela 1kg', 5.80),
(7, 'Cereal Matinal 300g', 9.90),

-- 8. Fazenda Real Produtos Orgânicos ME
(8, 'Tomate Orgânico 1kg', 10.50),
(8, 'Cenoura Orgânica 1kg', 9.30),
(8, 'Alface Crespa Orgânica 200g', 5.90),

-- 9. Maré Alta Pescados LTDA
(9, 'Filé de Tilápia Congelado 1kg', 39.90),
(9, 'Camarão Cinza 500g', 42.50),
(9, 'Lombo de Salmão 1kg', 79.90),

-- 10. PanGourmet Panificadora Industrial LTDA
(10, 'Pão Francês 1kg', 12.90),
(10, 'Croissant de Manteiga 80g', 5.20),
(10, 'Baguete Artesanal 300g', 8.70),

-- 11. Café do Cerrado Torrefação LTDA
(11, 'Café Torrado e Moído 500g', 19.50),
(11, 'Cápsulas de Café 10un', 24.90),
(11, 'Café em Grãos 1kg', 36.80),

-- 12. Frutaria Nacional Distribuição de Hortifrutis ME
(12, 'Banana Nanica 1kg', 6.40),
(12, 'Maçã Fuji 1kg', 9.10),
(12, 'Mamão Formosa 1kg', 7.80),

-- 13. Doce Campo Mel e Derivados LTDA
(13, 'Mel Puro 500g', 21.90),
(13, 'Geleia de Morango 320g', 12.40),
(13, 'Própolis em Gotas 30ml', 18.60),

-- 14. Sabor do Mar Produtos Alimentícios LTDA
(14, 'Atum em Lata 170g', 9.90),
(14, 'Sardinha em Óleo 125g', 6.70),
(14, 'Patê de Salmão 150g', 11.80),

-- 15. Granja Bela Vista Avicultura LTDA
(15, 'Ovos Brancos 12un', 14.90),
(15, 'Ovos Caipiras 10un', 17.50),
(15, 'Peito de Frango Congelado 1kg', 21.80),

-- 16. Casa das Massas LTDA
(16, 'Lasanha Bolonhesa 600g', 19.90),
(16, 'Ravioli de Queijo 400g', 16.80),
(16, 'Massa Fresca para Talharim 500g', 13.50),

-- 17. Frescor da Serra Laticínios ME
(17, 'Queijo Minas Frescal 500g', 22.40),
(17, 'Manteiga com Sal 200g', 11.70),
(17, 'Requeijão Cremoso 200g', 8.90),

-- 18. VerdeVale Produtos Congelados LTDA
(18, 'Legumes Congelados 1kg', 16.90),
(18, 'Batata Palito Congelada 2kg', 24.80),
(18, 'Ervilha Congelada 500g', 9.70),

-- 19. Raiz & Grão Produtos Naturais EIRELI
(19, 'Castanha de Caju 200g', 15.90),
(19, 'Mix de Nuts 250g', 17.80),
(19, 'Chia em Grãos 300g', 10.40),

-- 20. Bom Sabor Refeições Coletivas LTDA
(20, 'Prato Executivo de Frango', 22.90),
(20, 'Prato Vegetariano Completo', 25.50),
(20, 'Prato de Carne Bovina com Acompanhamentos', 28.40);

INSERT INTO A15_Venda (id_cliente, data_venda, desconto) VALUES
(1, '2025-10-01', 0.05),
(2, '2025-10-01', 0.00),
(3, '2025-10-02', 0.10),
(4, '2025-10-02', 0.00),
(5, '2025-10-03', 0.15),
(6, '2025-10-03', 0.05),
(7, '2025-10-04', 0.00),
(8, '2025-10-04', 0.00),
(9, '2025-10-05', 0.08),
(10, '2025-10-05', 0.00),
(11, '2025-10-06', 0.12),
(12, '2025-10-06', 0.00),
(13, '2025-10-07', 0.05),
(14, '2025-10-07', 0.00),
(15, '2025-10-08', 0.10),
(16, '2025-10-08', 0.00),
(17, '2025-10-09', 0.07),
(18, '2025-10-09', 0.00),
(19, '2025-10-10', 0.03),
(20, '2025-10-10', 0.00);

INSERT INTO A15_Produto_Vendido (id_venda, id_produto, quantidade) VALUES
-- Venda 1
(1, 1, 2),
(1, 2, 1),
-- Venda 2
(2, 5, 3),
-- Venda 3
(3, 8, 2),
(3, 9, 1),
(3, 10, 1),
-- Venda 4
(4, 11, 2),
-- Venda 5
(5, 15, 1),
(5, 16, 1),
(5, 17, 2),
-- Venda 6
(6, 19, 3),
(6, 20, 2),
-- Venda 7
(7, 21, 1),
(7, 22, 2),
(7, 23, 1),
-- Venda 8
(8, 25, 2),
-- Venda 9
(9, 27, 1),
(9, 28, 2),
-- Venda 10
(10, 31, 1),
(10, 33, 1),
-- Venda 11
(11, 35, 2),
(11, 36, 1),
-- Venda 12
(12, 39, 2),
-- Venda 13
(13, 40, 1),
(13, 42, 2),
-- Venda 14
(14, 43, 2),
(14, 44, 3),
-- Venda 15
(15, 46, 1),
-- Venda 16
(16, 48, 2),
(16, 49, 1),
-- Venda 17
(17, 52, 3),
(17, 53, 2),
-- Venda 18
(18, 56, 1),
-- Venda 19
(19, 58, 1),
(19, 59, 2),
-- Venda 20
(20, 60, 3);


