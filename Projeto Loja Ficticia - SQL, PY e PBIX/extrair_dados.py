import pandas as pd
import mysql.connector
import os

conexao = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345",
    database="LojaFicticia"
)

#pasta das planilhas
pasta_saida = "dados_exportados"
os.makedirs(pasta_saida, exist_ok=True)

#views
views = {
    "Faturamento":"faturamento.csv",
    "ProdutosMiasVendido":"produtos_mais_vendidos.csv",
    "ProdutoMaisFaturou":"produto_mais_faturou.csv",
    "ProdutoMaisFaturou": "produto_mais_faturou.csv",
    "LucroTotal": "lucro_total.csv",
    "FaturamentoPorLoja": "faturamento_por_loja.csv",
    "LucroPorLoja": "lucro_por_loja.csv",
    "MediaPrazoEntrega": "prazo_medio_entrega.csv",
    "QtdDevolucoes": "qtd_devolucoes.csv"
}

#exportação

for view, arquivo in views.items():
    query = f"SELECT * FROM {view}"
    df = pd.read_sql(query, conexao)

    caminho = os.path.join(pasta_saida, arquivo)
    df.to_csv(caminho, index=False)

    print(f"Ok {view} exportada ({df.shape[0]} linhas)")

    conexao.close()
    print(" Todas as Views foram exportadas com sucesso.")
