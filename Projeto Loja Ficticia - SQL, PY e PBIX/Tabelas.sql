CREATE DATABASE LojaFicticia;

USE LojaFicticia;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE itens_pedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

ALTER TABLE pedidos
ADD COLUMN data_entrega DATE,
ADD COLUMN situacao VARCHAR(30) NOT NULL,
ADD COLUMN devolvido BOOLEAN NOT NULL DEFAULT FALSE;

UPDATE pedidos
SET
    situacao = 'Entregue',
    data_entrega = DATE_ADD(data_pedido, INTERVAL 4 DAY),
    devolvido = FALSE
WHERE data_pedido < '2025-03-01';

UPDATE pedidos
SET
    situacao = 'Em transporte',
    data_entrega = NULL,
    devolvido = FALSE
WHERE data_pedido BETWEEN '2025-03-01' AND '2025-04-15';

UPDATE pedidos
SET
    situacao = 'Processando',
    data_entrega = NULL,
    devolvido = FALSE
WHERE data_pedido > '2025-04-15';

UPDATE pedidos
SET
    situacao = 'Devolvido',
    devolvido = TRUE,
    data_entrega = DATE_ADD(data_pedido, INTERVAL 6 DAY)
WHERE id_pedido IN (3, 11, 24, 37, 52, 61);

#CRIEI A COLUNA DE CUSTO DO FRETE.
ALTER TABLE pedidos
ADD COLUMN custo_envio DECIMAL(10,2);

UPDATE pedidos
SET custo_envio = 19.90
WHERE valor_total <= 200;

UPDATE pedidos
SET custo_envio = 29.90
WHERE valor_total BETWEEN 201 AND 800;

UPDATE pedidos
SET custo_envio = 49.90
WHERE valor_total > 800;

UPDATE pedidos
SET custo_envio = 0.00
WHERE id_pedido IN (5, 14, 33, 48, 67);







