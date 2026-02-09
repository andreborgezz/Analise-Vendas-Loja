import pandas as pd
from sqlalchemy import create_engine
import os


# configuracoes do banco

DB_USER = "root"
DB_PASSWORD = "12345"
DB_HOST = "localhost"
DB_NAME = "LojaFicticia"

PASTA_SAIDA = "dados_exportados"

VIEWS = {
    "Faturamento": "faturamento.csv",
    "ProdutosMaisVendido": "produtos_mais_vendidos.csv",
    "ProdutoMaisFaturou": "produto_mais_faturou.csv",
    "LucroTotal": "lucro_total.csv",
    "FaturamentoPorLoja": "faturamento_por_loja.csv",
    "LucroPorLoja": "lucro_por_loja.csv",
    "MediaPrazoEntrega": "prazo_medio_entrega.csv",
    "DevolucoesPorLojaProduto":"DevolucoesPorLojaProduto.csv"
}

# preparacao

os.makedirs(PASTA_SAIDA, exist_ok=True)

engine = create_engine(
    f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
)

# funcoes

def formatar_dados(df: pd.DataFrame) -> pd.DataFrame:
    """
    Aplica formatações seguras:
    - Arredonda colunas numéricas
    - Converte floats inteiros para int quando aplicável
    """

    colunas_numericas = df.select_dtypes(include="number").columns

    for coluna in colunas_numericas:
        if pd.api.types.is_float_dtype(df[coluna]):
            df[coluna] = df[coluna].round(2)

            # Se virar número inteiro, converte
            if (df[coluna] % 1 == 0).all():
                df[coluna] = df[coluna].astype(int)

    return df


def exportar_view(view: str, arquivo: str):
    query = f"SELECT * FROM {view}"
    df = pd.read_sql(query, engine)

    df = formatar_dados(df)

    caminho = os.path.join(PASTA_SAIDA, arquivo)
    df.to_csv(caminho, index=False)

    print(f"✔ {view} exportada ({df.shape[0]} linhas)")


# excecução

for view, arquivo in VIEWS.items():
    try:
        exportar_view(view, arquivo)
    except Exception as e:
        print(f"❌ Erro ao exportar {view}")
        print(e)

print("✅ Todas as views foram processadas com sucesso.")
