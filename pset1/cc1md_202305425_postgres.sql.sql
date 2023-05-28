/* Script SQL do pset referente ao bando de dados 'lojas uvv'
 Henrique miranda kiepper cc1md_202305425_postgresql.sql */
/* comando drop user e database se já houver algum usuario e banco de dados com mesmo nome dos que serão criados a seguir */
drop database if exists uvv;
drop user if exists henrique; 
    /* Criando usuário com senha e com as permissôes necessarias para criar banco de dados e ter uma senha */

        CREATE USER henrique
        WITH 
        createdb 
        createrole 
        encrypted password '123';

    /* Criando o banco de dados com os devidos parâmetros */
        CREATE DATABASE uvv 
        WITH 
        owner              henrique
        encoding           "UTF8"
        lc_collate         'pt_BR.UTF-8'
        lc_ctype           'pt_BR.UTF-8'
        allow_connections = TRUE;

       /* comentário do bando de dados */
            COMMENT ON DATABASE uvv
            IS 'Banco de dados da uvv com foco de inserir dados das lojas uvv';

       /* conectando ao usuário e ao banco de dados  */
            \setenv PGPASSWORD 123
            \c uvv henrique;
           
    /* Criando um esquema dentro do banco de dados. */
        CREATE SCHEMA IF NOT EXISTS lojas
        AUTHORIZATION henrique;

        /* Inserindo comentário do schema */
            COMMENT ON SCHEMA lojas
            IS 'Esquema referente as Lojas UVV';

        /* definindo como caminho principal */
            ALTER USER henrique
            SET SEARCH_PATH TO lojas, "$user", public;
           /* criação das tabelas*/
           /* criação da tabela produtos com primary key e comentários */
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
/* comentários da tabela */
COMMENT ON TABLE lojas.produtos IS 'tabela para os dados dos produtos insira dados como (nome,preço,detalhes,imagens)';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'apresenta a chave primaria da tabela ''produtos'', mostra o códico dos produtos';
COMMENT ON COLUMN lojas.produtos.nome IS 'mostra o nome do usuario';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'mostra o preço do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'mostra os detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'mostra a imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'mostra o mime type referente a imagem';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'mostra o arquivo de imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'mostra o arquivo charset referenre a imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'mostra a data da ultima atualização da imagem do produto';

 /* criação da tabela lojas com primary key e comentários */
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255),
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);
/*comentários daa tabela lojas */
COMMENT ON TABLE lojas.lojas IS 'tabela para os dados das lojas insira dados como (nome,endereço,latitude,longitude,logo)';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'apresenta a chave primaria da tabela ''lojas'', identifica cada loja';
COMMENT ON COLUMN lojas.lojas.nome IS 'mostra o nome das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'mostra o endereço web das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'mostra o endereço fisico das lojas';
COMMENT ON COLUMN lojas.lojas.latitude IS 'mostra a latitude da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'mostra a longitude da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'mostra a logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'mostra o mime type do logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'mostra o arquivo com a logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'mostra o arquivo charset da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'mostra a data da ultima atualização da logo da loja';

/*criação da tabela estoques */

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38),
                
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);
/* comentários da tabela estoques */
COMMENT ON TABLE lojas.estoques IS 'tabela para os dados de estoque, tabela que serve de relação N:N entre as tabelas ''lojas'' e ''produtos'', insira dados como (loja,produto,quantidade)';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'apresenta a chave primaria da tabela ''estoques'', mostra o estoque dos produtos';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'mostra ao loja referente ao estoque, chave estrangeira referente a tabela ''lojas'' ';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'mostra o produto no estoque, chave estrangeira referente a tabela ''produtos'' ';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'mostra a quantidade de produtos no estoque';

/*criação da tabela clientes */

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
/* comentários da tabela clientes */
COMMENT ON TABLE lojas.clientes IS 'tabela para os dados dos clientes insira dados como (email,nome,telefone)';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'apresente a chave primaria da tabela ''clientes'', identifica cada cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'mostra o email do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'mostra o nome do usuario';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'mostra um telefone do usuario';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'mostra um telefone do usuario';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'mostra um telefone do usuario';

/*criação da tabela pedidos */

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
/* comentários da tabela pedidos */
COMMENT ON TABLE lojas.pedidos IS 'tabela para os dados dos pedidos insira dados como (data,cliente,status do produto,loja)';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'apresente a chave primaria da tabela ''pedidos'', identifica cada pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'mostra a data do pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'mostra o cliente que realizou o pedido, chave estrangeira referente a tabela ''clientes''';
COMMENT ON COLUMN lojas.pedidos.status IS 'mostra o status do produto';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'mostra a loja que o pedido foi feito, chave estrangeira referente a tabela ''lojas'' ';

/*criação da  tabela envios */

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
/*comentários da tabela envios */
COMMENT ON TABLE lojas.envios IS 'tabela para os dados dos envios insira dados como (loja,cliente,endereço,status)';
COMMENT ON COLUMN lojas.envios.envio_id IS 'apresenta a chave primaria da tabela ''envios'', identifica cada envio';
COMMENT ON COLUMN lojas.envios.loja_id IS 'mostra a loja que o pedido foi feito, chave estrangeira referente a tabela ''lojas'' ';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'mostra o cliente que realizou o pedido, chave estrangeira referente a tabela ''clientes'' ';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'mostra o endereço que deve ser realizado a entrega';
COMMENT ON COLUMN lojas.envios.status IS 'apresenta o status de envio que o produto está';

/*criação da tabela pedidos_itens */

CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2),
                quantidade NUMERIC(38),
                envio_id NUMERIC(38) NOT NULL,
                
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
/*comentários da tabela pedidos_itens */
COMMENT ON TABLE public.pedidos_itens IS 'tabela para os dados dos itens de um pedido insira dados como (numero,preço,quantidade,envio)';
COMMENT ON COLUMN public.pedidos_itens.pedido_id IS 'apresenta a chave primaria da tabela  ''pedidos_itens''e chave estrangeira da tabela ''pedidos'', mostra o códico dos pedidos';
COMMENT ON COLUMN public.pedidos_itens.produto_id IS 'apresenta a chave primaria da tabela ''pedidos_itens''e chave estrangeira da tabela ''produtos'', mostra o códico dos produtos';
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha IS 'mostra o número da linha do produto';
COMMENT ON COLUMN public.pedidos_itens.preco_unitario IS 'mostra o preço do produto';
COMMENT ON COLUMN public.pedidos_itens.quantidade IS 'mostra a quantidade que foi pedida de um produto';
COMMENT ON COLUMN public.pedidos_itens.envio_id IS 'mostra o códico de envio, chave estrangeira referente a tabela ''envios'' ';



/*relacionamentos entre tabelas*/
/*Relacionamento não identificado entre as tabelas 'produtos' e 'pedidos_itens'*/

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/* relacionamento não identificado entre as tabelas 'estoques' e 'produtos'*/

ALTER TABLE lojas.estoques 
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificasdo entre as tabelas 'pedidos' e 'lojas'*/

ALTER TABLE lojas.pedidos 
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificado entre as tabelas 'estoques' e 'lojas' */

ALTER TABLE lojas.estoques 
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificado entre as tabelas 'envios' e 'lojas' */

ALTER TABLE lojas.envios 
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificado entre as tabelas 'envios' e 'clientes' */

ALTER TABLE lojas.envios 
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificado entre as tabelas 'pedidos' e 'clientes' */

ALTER TABLE lojas.pedidos 
ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificado entre as tabelas 'pedidos_itens' e 'pedidos' */

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*relacionamento não identificado entre as tabelas 'pedidos_itens' e 'envios' */

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


/*criação das constraints de limitação do banco de dados*/

  /*Constraints da tabela 'produtos' que impedem que os preços sejam iguais a 0*/

ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK( preco_unitario > 0 );

 /* Constraint da tabela 'estoqques' que impedem que a quantidade no estoque seja negativo*/
   ALTER TABLE lojas.estoques
            ADD CONSTRAINT cc_estoques_quantidade
            CHECK( quantidade > 0 );
           
   /*Constraint da tabela 'clientes' que impedem que os telefones sejam repetidos*/
ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_clientes_telefone
CHECK( telefone1 <> telefone2 AND
 telefone2 <> telefone3 AND 
 telefone1 <> telefone3 );
           
/* Constraints da tabela 'produtos' que impede que valores diferentes dos permitidos sejam adicionados*/
ALTER TABLE  lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK( status in('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO') );

/*constraints da tabela 'envios' que impede que valores diferentes dos permitidos sejam adicionados*/
ALTER TABLE  lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK( status in('CRIADO','ENVIADO','TRANSITO','ENTREGUE') );

/*Constraints da tabela 'produtos_itens' que impedem que os preços sejam iguais a 0*/
ALTER TABLE lojas.pedidos_itens
            ADD CONSTRAINT cc_pedidos_itens_preco_unitario
            CHECK( preco_unitario > 0 );
