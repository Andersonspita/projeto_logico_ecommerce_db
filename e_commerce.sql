-- Criação do banco de dados para o e-commerce 
create database ecommerce;

use ecommerce;

CREATE TABLE  Cliente  (
   idCliente  INT NOT NULL AUTO_INCREMENT,
   PNome  VARCHAR(15) NOT NULL,
   MNome  VARCHAR(20) NOT NULL,
   LNome  VARCHAR(20) NOT NULL COMMENT 'Adicionar constraint de unidade para (nome completo)',
   CPF  INT(11) NOT NULL COMMENT 'Unique (CPF)',
   Endereço  VARCHAR(45) NOT NULL,
   Data_de_Nascimento  DATE NOT NULL,
  PRIMARY KEY ( idCliente ),
  UNIQUE INDEX  CPF_UNIQUE  (CPF)
  );
  
 CREATE TABLE  Pedido  (
   idPedido  INT NOT NULL AUTO_INCREMENT,
   Cliente_idCliente  INT NOT NULL,
   Status_do_pedido  ENUM('Em andamento', 'Processando', 'Enviado', 'Em transporte', 'Estraviado', 'Entregue') NOT NULL DEFAULT 'Processando',
   Descrição  VARCHAR(45) NULL,
   Frete  FLOAT NULL,
  PRIMARY KEY ( idPedido ,  Cliente_idCliente ),
  INDEX  fk_Pedido_Cliente_idx  ( Cliente_idCliente  ASC),
  CONSTRAINT  fk_Pedido_Cliente 
    FOREIGN KEY ( Cliente_idCliente )
    REFERENCES  mydb . Cliente  ( idCliente )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
    
CREATE TABLE  Relacao_produto_pedido  (
   Pedido_idPedido  INT NOT NULL,
   Produto_idProduto  INT NOT NULL,
   Quantidade  INT NOT NULL,
   Status  ENUM('Disponível', 'Sem estoque') NULL DEFAULT 'Disponível',
  PRIMARY KEY ( Pedido_idPedido ,  Produto_idProduto ),
  INDEX  fk_Relacao_de_Produto/pedido_Pedido_idx  ( Pedido_idPedido  ASC) VISIBLE,
  INDEX  fk_Relacaoo_de_Produto/pedido_Produto_idx  ( Produto_idProduto  ASC) VISIBLE,
  CONSTRAINT  fk_Relação de Produto/pedido_Pedido1 
    FOREIGN KEY ( Pedido_idPedido )
    REFERENCES  mydb . Pedido  ( idPedido )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT  fk_Relação de Produto/pedido_Produto1 
    FOREIGN KEY ( Produto_idProduto )
    REFERENCES  mydb . Produto  ( idProduto )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
    
CREATE TABLE  Produto  (
   idProduto  INT NOT NULL AUTO_INCREMENT,
   Categoria  VARCHAR(45) NOT NULL,
   Nome_produto  VARCHAR(45) NOT NULL,
   Descrição  VARCHAR(45) NULL,
   Valor_produto  FLOAT NOT NULL,
  PRIMARY KEY ( idProduto )
  );

CREATE TABLE  Produto_estoque  (
   Produto_idProduto  INT NOT NULL,
   Estoque_idEstoque  INT NOT NULL,
   Quantidade  INT NOT NULL,
  PRIMARY KEY ( Produto_idProduto ,  Estoque_idEstoque ),
  INDEX  fk_Produto_has_Estoque_Produto_idx  ( Produto_idProduto  ASC) VISIBLE,
  INDEX  fk_Produto_has_Estoque_Estoque_idx  ( Estoque_idEstoque  ASC) VISIBLE,
  CONSTRAINT  fk_Produto_has_Estoque_Produto1 
    FOREIGN KEY ( Produto_idProduto )
    REFERENCES  mydb . Produto  ( idProduto )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT  fk_Produto_has_Estoque_Estoque1 
    FOREIGN KEY ( Estoque_idEstoque )
    REFERENCES  mydb . Estoque  ( idEstoque )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
    

CREATE TABLE Produtos_vendedor_terceiro  (
   Produto_idProduto  INT NOT NULL,
   Terceiro_vendedor_idTerceiro_vendedor  INT NOT NULL,
   Quantidade  VARCHAR(45) NOT NULL,
  PRIMARY KEY ( Produto_idProduto ,  Terceiro_vendedor_idTerceiro_vendedor ),
  INDEX  fk_Produtos_por_vendedor_terceiro_Produto_idx  ( Produto_idProduto  ASC) VISIBLE,
  INDEX  fk_Produtos_por_vendedor_terceiro_Terceiro_vendedor_idx  ( Terceiro_vendedor_idTerceiro_vendedor  ASC) VISIBLE,
  CONSTRAINT  fk_Produtos_por_vendedor_terceiro_Produto 
    FOREIGN KEY ( Produto_idProduto )
    REFERENCES  mydb . Produto  ( idProduto )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT  fk_Produtos_por_vendedor_terceiro_Terceiro_vendedor 
    FOREIGN KEY ( Terceiro_vendedor_idTerceiro_vendedor )
    REFERENCES  mydb . Terceiro_vendedor  ( idTerceiro_vendedor )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
    
CREATE TABLE Terceiro_vendedor  (
   idTerceiro_vendedor  INT NOT NULL AUTO_INCREMENT,
   Razão_social  VARCHAR(45) NOT NULL,
   CNPJ  INT(14) NULL,
   Nome_fantasia  VARCHAR(45) NOT NULL,
   Local  VARCHAR(45) NOT NULL,
  PRIMARY KEY ( idTerceiro_vendedor ),
  UNIQUE INDEX  CNPJ_UNIQUE  ( CNPJ  ASC) VISIBLE,
  UNIQUE INDEX  Razão_social_UNIQUE  ( Razão_social  ASC) VISIBLE
  );
  
CREATE TABLE Disponibilizando_produto  (
   Produto_idProduto  INT NOT NULL,
   Fornecedor_idFornecedor  INT NOT NULL,
  PRIMARY KEY ( Produto_idProduto ,  Fornecedor_idFornecedor ),
  INDEX  fk_Disponibilizando_um_produto_produto_idx  ( Produto_idProduto  ASC) VISIBLE,
  INDEX  fk_Disponibilizando_um_produto_fornecedor_idx  ( Fornecedor_idFornecedor  ASC) VISIBLE,
  CONSTRAINT  fk_Disponibilizando_um_produto_produto
    FOREIGN KEY ( Produto_idProduto )
    REFERENCES  mydb . Produto  ( idProduto )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT  fk_Disponibilizando_um_produto_fornecedor
    FOREIGN KEY ( Fornecedor_idFornecedor )
    REFERENCES  mydb . Fornecedor  ( idFornecedor )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
    
CREATE TABLE Estoque  (
   idEstoque  INT NOT NULL AUTO_INCREMENT,
   Local  VARCHAR(45) NOT NULL,
  PRIMARY KEY ( idEstoque )
  );
  
CREATE TABLE Fornecedor  (
   idFornecedor  INT NOT NULL AUTO_INCREMENT,
   Razão_social  VARCHAR(45) NOT NULL,
   CNPJ  INT(14) NOT NULL,
   Endereço  VARCHAR(45) NOT NULL,
  PRIMARY KEY ( idFornecedor ),
  UNIQUE INDEX  CNPJ_UNIQUE  ( CNPJ  ASC) VISIBLE,
  UNIQUE INDEX  Razão_social_UNIQUE  ( Razão_social  ASC) VISIBLE
  );

