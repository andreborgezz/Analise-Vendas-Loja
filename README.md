# Analise-Vendas-Loja
📊 Análise de Vendas de uma Loja — Projeto de Estudo
📌 Sobre o projeto

Este projeto foi desenvolvido como parte do meu processo de aprendizado em Análise de Dados, utilizando um cenário fictício de uma loja (física ou online) para simular situações reais de negócio.

O foco do projeto é entender os dados, estruturar um banco de dados coerente, criar regras de negócio com SQL e transformar essas informações em análises úteis para apoio à tomada de decisão.

🎯 Objetivos do projeto

Entender a estrutura de um banco de dados relacional aplicado a vendas

Criar análises e métricas de negócio utilizando SQL

Utilizar Python para extração e organização dos dados

Construir visualizações e dashboards no Power BI

Desenvolver raciocínio analítico e visão de negócio

🗂️ Estrutura dos dados

Os dados são fictícios e representam o funcionamento de uma loja real.
O banco de dados foi modelado para permitir análises de vendas, produtos, clientes, logística e desempenho por loja.

🧑‍💼 Clientes

id_cliente

nome

email

telefone

data_cadastro

📦 Produtos

id_produto

nome

descricao

preco

estoque

🧾 Pedidos

id_pedido

id_cliente

id_loja

data_pedido

valor_total

data_entrega

situacao

devolvido

custo_envio

📄 Itens do Pedido

id_item_pedido

id_pedido

id_produto

quantidade

preco_unitario

🏬 Lojas

id_loja

nome_loja

cidade

responsavel

📈 Análises desenvolvidas (SQL)

As regras de negócio foram implementadas através de views, facilitando o consumo dos dados no Power BI.

Faturamento total

Produto mais vendido (quantidade)

Produto que mais faturou

Lucro total

Faturamento por loja

Lucro por loja

Prazo médio de entrega

Quantidade de pedidos devolvidos

🐍 Uso do Python

O Python foi utilizado para:

Conectar ao banco de dados

Extrair os dados a partir das views SQL

Realizar validações simples

Gerar arquivos CSV para consumo no Power BI

📊 Power BI

O Power BI será utilizado para:

Criação de dashboards interativos

Visualização de KPIs (faturamento, lucro, prazo de entrega, devoluções)

Comparação de desempenho entre lojas e produtos

🚧 Status do projeto

🟡 Projeto em desenvolvimento

Até o momento:

Banco de dados criado e populado

Modelagem validada

Views SQL implementadas

Pipeline inicial com Python iniciado

Próximas etapas:

Finalizar extração dos dados com Python

Construção do dashboard no Power BI

Análise final e geração de insights.
