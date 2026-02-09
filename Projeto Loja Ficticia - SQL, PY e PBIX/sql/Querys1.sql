USE LojaFicticia;


# Faturamento:
create view Faturamento AS
    select
        (sum(valor_total)) AS Faturamento
from pedidos;


# Produtos mais vendidos
CREATE VIEW ProdutosMaisVendido AS
SELECT
    pr.id_produto,
    pr.nome,
    SUM(ip.quantidade) AS total_vendido
FROM itens_pedido ip
JOIN produtos pr
    ON ip.id_produto = pr.id_produto
GROUP BY
    pr.id_produto,
    pr.nome
ORDER BY
    total_vendido DESC;


select * from produtosmaisvendido;
# Quantos produtos foram devolvidos
create view QtdDevolução AS
    SELECT count(devolvido)
    from pedidos
    where devolvido = '1';

select * from qtddevolução;


# Prazo medio de entrega
CREATE VIEW MediaPrazoEntrega AS
SELECT
    AVG(DATEDIFF(data_entrega, data_pedido)) AS prazo_medio_dias
FROM pedidos
WHERE data_entrega IS NOT NULL;

select * from mediaprazoentrega;


#(faturamento = quantidade × preço_unitario)
CREATE VIEW ProdutoMaisFaturou AS
SELECT
    pr.id_produto,
    pr.nome,
    SUM(ip.quantidade * ip.preco_unitario) AS faturamento_produto
FROM itens_pedido ip
JOIN produtos pr
    ON ip.id_produto = pr.id_produto
GROUP BY
    pr.id_produto,
    pr.nome
ORDER BY
    faturamento_produto DESC;


#(lucro = faturamento − custo_envio)
CREATE VIEW LucroTotal AS
SELECT
    SUM(valor_total - custo_envio) AS lucro_total
FROM pedidos
WHERE devolvido = FALSE;


# Faturamento por loja (com responsável)
CREATE VIEW FaturamentoPorLoja AS
SELECT
    l.id_loja,
    l.nome_loja,
    l.responsavel,
    SUM(p.valor_total) AS faturamento_loja
FROM pedidos p
JOIN lojas l
    ON p.id_loja = l.id_loja
GROUP BY
    l.id_loja,
    l.nome_loja,
    l.responsavel;


# Lucro por loja (com responsável)
CREATE VIEW LucroPorLoja AS
SELECT
    l.id_loja,
    l.nome_loja,
    l.responsavel,
    SUM(p.valor_total - p.custo_envio) AS lucro_loja
FROM pedidos p
JOIN lojas l
    ON p.id_loja = l.id_loja
WHERE p.devolvido = FALSE
GROUP BY
    l.id_loja,
    l.nome_loja,
    l.responsavel;

#qtd devoluções
CREATE VIEW QtdDevolucoes AS
SELECT COUNT(*) AS total_devolucoes
FROM pedidos
WHERE devolvido = TRUE;

CREATE OR REPLACE VIEW QtdDevolucoesPorLoja AS
SELECT
    l.id_loja,
    l.nome_loja,
    COUNT(p.id_pedido) AS qtd_devolucoes
FROM pedidos p
JOIN lojas l
    ON p.id_loja = l.id_loja
WHERE p.devolvido = TRUE
GROUP BY
    l.id_loja,
    l.nome_loja;

select * from QtdDevolucoesPorLoja;

CREATE OR REPLACE VIEW DevolucoesPorLojaProduto AS
SELECT
    l.id_loja,
    l.nome_loja,
    pr.id_produto,
    pr.nome AS nome_produto,
    SUM(ip.quantidade) AS qtd_produtos_devolvidos,
    SUM(ip.quantidade * ip.preco_unitario) AS valor_total_devolvido
FROM pedidos p
JOIN lojas l
    ON p.id_loja = l.id_loja
JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
JOIN produtos pr
    ON ip.id_produto = pr.id_produto
WHERE p.devolvido = TRUE
GROUP BY
    l.id_loja,
    l.nome_loja,
    pr.id_produto,
    pr.nome;



SHOW TABLES;





