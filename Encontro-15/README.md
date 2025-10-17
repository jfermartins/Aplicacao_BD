# Desafio SQL - Gerenciamento de Livraria

Este repositório contém os scripts SQL para a criação de um banco de dados de livraria, inserção de dados de exemplo e consultas para gerar relatórios, explorando diferentes tipos de JOINs.

## Objetivo

O objetivo deste desafio é:

1.  Modelar um esquema de banco de dados relacional para uma livraria.
2.  Criar tabelas com as boas práticas de SQL, incluindo chaves primárias, chaves estrangeiras e outras constraints.
3.  Popular as tabelas com dados de exemplo que simulem cenários de vendas.
4.  Desenvolver consultas SQL para gerar relatórios específicos, utilizando `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN` (simulado), `LEFT EXCLUDING JOIN` e `RIGHT EXCLUDING JOIN`.

## Estrutura do Banco de Dados

O banco de dados é nomeado `livraria_db_Jane` e é composto por três tabelas principais:

### `Autores`

Armazena informações sobre os autores dos livros.

| Coluna      | Tipo     | Constraints         |
| :---------- | :------- | :------------------ |
| `id_autor`  | `INT`    | `PRIMARY KEY`, `AUTO_INCREMENT` |
| `nome_autor`| `VARCHAR(255)` | `NOT NULL`, `UNIQUE`|

### `Livros`

Armazena informações sobre os livros disponíveis, incluindo a referência ao seu autor.

| Coluna        | Tipo     | Constraints         |
| :------------ | :------- | :------------------ |
| `id_livro`    | `INT`    | `PRIMARY KEY`, `AUTO_INCREMENT` |
| `titulo_livro`| `VARCHAR(255)` | `NOT NULL`          |
| `id_autor`    | `INT`    | `NOT NULL`, `FOREIGN KEY` (referencia `Autores`) |

### `Vendas`

Registra cada item vendido em uma transação, incluindo a quantidade e a data da venda.

| Coluna        | Tipo     | Constraints         |
| :------------ | :------- | :------------------ |
| `id_venda`    | `INT`    | `PRIMARY KEY`, `AUTO_INCREMENT` |
| `id_livro`    | `INT`    | `NOT NULL`, `FOREIGN KEY` (referencia `Livros`) |
| `quantidade`  | `INT`    | `NOT NULL`          |
| `data_venda`  | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` |

## Arquivos SQL Fornecidos

Os seguintes arquivos SQL estão incluídos neste repositório:

1.  `esquema_livraria.sql`:
    *   Contém os comandos `CREATE DATABASE` e `CREATE TABLE` para configurar o banco de dados `livraria_db_Jane` e suas tabelas (`Autores`, `Livros`, `Vendas`).
    *   Define as chaves primárias, chaves estrangeiras e outras constraints para garantir a integridade dos dados.

2.  `dados_livraria.sql`:
    *   Contém os comandos `INSERT INTO` para popular as tabelas com dados de exemplo.
    *   Inclui autores como 'Machado de Assis', 'George Orwell', 'Monteiro Lobato' e 'Clarice Lispector'.
    *   Adiciona livros como 'Dom Casmurro', 'A Revolução dos Bichos', '1984', 'Sítio do Picapau Amarelo' e 'A Hora da Estrela'.
    *   Os dados de venda refletem as observações do enunciado original, onde 'Dom Casmurro' e 'A Revolução dos Bichos' não possuem registros de venda iniciais, e 'Machado de Assis' não teve livros vendidos.

3.  `desafio_aula15.sql`:
    *   Contém as consultas `SELECT` originais para os quatro relatórios solicitados no enunciado.
    *   Utiliza `INNER JOIN` e `LEFT JOIN` para combinar informações entre as tabelas.

4.  `desafio_aula15_joins.sql`:
    *   Este arquivo refatora as consultas dos relatórios e adiciona exemplos de diferentes tipos de JOINs, conforme solicitado:
        *   **INNER JOIN**: Retorna registros quando há correspondência em ambas as tabelas.
        *   **LEFT JOIN**: Retorna todos os registros da tabela da esquerda e os registros correspondentes da tabela da direita. Se não houver correspondência, o resultado da direita é `NULL`.
        *   **RIGHT JOIN**: Retorna todos os registros da tabela da direita e os registros correspondentes da tabela da esquerda. Se não houver correspondência, o resultado da esquerda é `NULL`.
        *   **FULL OUTER JOIN (Simulado)**: Retorna todos os registros quando há uma correspondência em uma das tabelas. Em sistemas como MySQL, que não possuem `FULL OUTER JOIN` nativo, ele é geralmente simulado usando a combinação de `LEFT JOIN` e `RIGHT JOIN` com `UNION`.
        *   **LEFT EXCLUDING JOIN**: Retorna registros da tabela da esquerda que não têm correspondência na tabela da direita. Geralmente implementado com `LEFT JOIN` e uma cláusula `WHERE` para `IS NULL` na coluna da tabela da direita.
        *   **RIGHT EXCLUDING JOIN**: Retorna registros da tabela da direita que não têm correspondência na tabela da esquerda. Implementado com `RIGHT JOIN` e uma cláusula `WHERE` para `IS NULL` na coluna da tabela da esquerda.

## Como Executar

Para configurar e executar este desafio SQL, siga os passos abaixo:

1.  **Crie o Banco de Dados e as Tabelas:**
    Execute o script `esquema_livraria.sql` no seu cliente MySQL (ou SGBD compatível).

    ```sql
    SOURCE caminho/para/esquema_livraria.sql;
    ```

2.  **Insira os Dados de Exemplo:**
    Após a criação das tabelas, execute o script `dados_livraria.sql` para popular o banco de dados.

    ```sql
    SOURCE caminho/para/dados_livraria.sql;
    ```

3.  **Execute os Relatórios e Exemplos de JOINs:**
    Para visualizar os relatórios originais, execute `desafio_aula15.sql`.
    Para explorar os diferentes tipos de JOINs, execute `desafio_aula15_joins.sql`.

    ```sql
    SOURCE caminho/para/desafio_aula15.sql;
    SOURCE caminho/para/desafio_aula15_joins.sql;
    ```

## Tipos de JOINs Utilizados e Explicação

### INNER JOIN

**O que faz:** Retorna apenas as linhas que têm correspondências em **ambas** as tabelas que estão sendo unidas.

**Exemplo de Aplicação (Relatório 1 - Catálogo Completo):**
```sql
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor;
```

### LEFT JOIN (ou LEFT OUTER JOIN)

**O que faz:** Retorna todas as linhas da tabela da **esquerda** e as linhas correspondentes da tabela da direita. Se não houver correspondência na tabela da direita, os valores das colunas da direita serão `NULL`.

**Exemplo de Aplicação (Relatório 4 - Status de Vendas):**
```sql
SELECT
    L.titulo_livro,
    A.nome_autor,
    SUM(V.quantidade) AS quantidade_vendida
FROM
    Livros AS L
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor
LEFT JOIN
    Vendas AS V ON L.id_livro = V.id_livro
GROUP BY
    L.id_livro, L.titulo_livro, A.nome_autor;
```

### RIGHT JOIN (ou RIGHT OUTER JOIN)

**O que faz:** Retorna todas as linhas da tabela da **direita** e as linhas correspondentes da tabela da esquerda. Se não houver correspondência na tabela da esquerda, os valores das colunas da esquerda serão `NULL`.

**Exemplo de Aplicação (Autores e seus Livros):**
```sql
SELECT
    A.nome_autor,
    L.titulo_livro
FROM
    Livros AS L
RIGHT JOIN
    Autores AS A ON L.id_autor = A.id_autor;
```

### FULL OUTER JOIN (Simulado para MySQL)

**O que faz:** Retorna todas as linhas quando há uma correspondência em uma das tabelas. É a combinação de `LEFT JOIN` e `RIGHT JOIN`. Em MySQL, que não possui `FULL OUTER JOIN` nativo, é simulado usando `UNION` entre um `LEFT JOIN` e um `RIGHT JOIN` (com filtro para evitar duplicatas da interseção).

**Exemplo de Aplicação (Todos os Livros e Autores):**
```sql
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
LEFT JOIN
    Autores AS A ON L.id_autor = A.id_autor
UNION
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
RIGHT JOIN
    Autores AS A ON L.id_autor = A.id_autor
WHERE
    L.id_livro IS NULL; -- Filtra para incluir apenas os autores sem livros do RIGHT JOIN
```

### LEFT EXCLUDING JOIN

**O que faz:** Retorna apenas as linhas da tabela da esquerda que **não** têm correspondência na tabela da direita. É útil para encontrar registros 

que não possuem um relacionamento.

**Exemplo de Aplicação (Livros não vendidos):**
```sql
SELECT
    L.titulo_livro,
    A.nome_autor
FROM
    Livros AS L
INNER JOIN
    Autores AS A ON L.id_autor = A.id_autor
LEFT JOIN
    Vendas AS V ON L.id_livro = V.id_livro
WHERE
    V.id_venda IS NULL;
```

### RIGHT EXCLUDING JOIN

**O que faz:** Retorna apenas as linhas da tabela da direita que **não** têm correspondência na tabela da esquerda. Útil para encontrar registros na tabela da direita que não possuem um relacionamento.

**Exemplo de Aplicação (Autores sem livros):**
```sql
SELECT
    A.nome_autor
FROM
    Autores AS A
LEFT JOIN
    Livros AS L ON A.id_autor = L.id_autor
WHERE
    L.id_livro IS NULL;
```

