Exercicio Aula 10

Diagrama de Entidade-Relacionamento (DER) para o Sistema de Contatos


Entidades

1. Grupos_de_Contato

Esta entidade armazena informações sobre os grupos aos quais os contatos podem pertencer.

•
id_grupo: Chave Primária (PK), identificador único para cada grupo. Auto-incrementável.

•
nome_grupo: Nome do grupo, deve ser único e não nulo.


2. Contatos

Esta entidade armazena as informações básicas de cada contato.

•
id_contato: Chave Primária (PK), identificador único para cada contato. Auto-incrementável.

•
nome: Nome do contato, não nulo.

•
email: Endereço de e-mail do contato, deve ser único.


3. Telefones

Esta entidade armazena os números de telefone associados a cada contato.

•
id_telefone: Chave Primária (PK), identificador único para cada telefone. Auto-incrementável.

•
numero: Número de telefone, não nulo.

•
id_contato: Chave Estrangeira (FK), referencia id_contato da tabela Contatos. Indica a qual contato o telefone pertence.


4. Contatos_Grupos (Tabela Associativa)

Esta é uma tabela auxiliar (ou associativa) que gerencia o relacionamento muitos-para-muitos entre Contatos e Grupos_de_Contato. Um contato pode pertencer a vários grupos, e um grupo pode ter vários contatos.

•
id_contato: Chave Primária (PK) e Chave Estrangeira (FK), referencia id_contato da tabela Contatos.

•
id_grupo: Chave Primária (PK) e Chave Estrangeira (FK), referencia id_grupo da tabela Grupos_de_Contato.

•
A combinação de (id_contato, id_grupo) forma a Chave Primária composta desta tabela, garantindo que um contato não seja adicionado ao mesmo grupo mais de uma vez.

Relacionamentos

1.
Contatos 1:N Telefones

•
Um Contato pode ter muitos Telefones.

•
Um Telefone pertence a um e apenas um Contato.

•
Implementado pela Chave Estrangeira id_contato na tabela Telefones referenciando id_contato em Contatos.



2.
Contatos N:M Grupos_de_Contato

•
Um Contato pode pertencer a muitos Grupos_de_Contato.

•
Um Grupo_de_Contato pode ter muitos Contatos.

•
Este relacionamento muitos-para-muitos é resolvido pela tabela associativa Contatos_Grupos.

•
Contatos_Grupos.id_contato é uma Chave Estrangeira para Contatos.id_contato.

•
Contatos_Grupos.id_grupo é uma Chave Estrangeira para Grupos_de_Contato.id_grupo.





Componentes Necessários

•
Entidades: Grupos_de_Contato, Contatos, Telefones, Contatos_Grupos.

•
Atributos: As colunas definidas em cada tabela.

•
Chaves Primárias (PK): id_grupo (Grupos_de_Contato), id_contato (Contatos), id_telefone (Telefones), (id_contato, id_grupo) (Contatos_Grupos).

•
Chaves Estrangeiras (FK): id_contato (Telefones), id_contato (Contatos_Grupos), id_grupo (Contatos_Grupos).

•
Restrições de Unicidade (UNIQUE): nome_grupo (Grupos_de_Contato), email (Contatos).

•
Restrições de Não Nulo (NOT NULL): nome_grupo (Grupos_de_Contato), nome (Contatos), numero (Telefones), id_contato (Telefones, Contatos_Grupos), id_grupo (Contatos_Grupos).

•
Auto-incremento: id_grupo, id_contato, id_telefone.


