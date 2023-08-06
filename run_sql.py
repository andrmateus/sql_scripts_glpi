import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt

# Função para executar a consulta SQL e retornar o resultado como DataFrame
def executar_consulta(consulta):
    # Conectar ao banco de dados (substitua 'seu_host', 'seu_usuario', 'sua_senha' e 'seu_banco_de_dados' pelas informações corretas)
    conn = mysql.connector.connect(
        host='192.168.31.94',
        user='consulta',
        password='C0n5ult0NC0CL1N1C45@2021',
        database='glpi'
    )

    # Criar um cursor para executar a consulta
    cursor = conn.cursor()

    # Executar a consulta
    cursor.execute(consulta)

    # Obter os dados da consulta
    dados = cursor.fetchall()

    # Obter os nomes das colunas
    colunas = [coluna[0] for coluna in cursor.description]

    # Criar um DataFrame com os dados e as colunas
    resultado = pd.DataFrame(dados, columns=colunas)

    # Fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conn.close()

    return resultado

# Consulta SQL
with open('chamados com SLA removido.sql', 'r') as file:
    query = file.read()

resultado = executar_consulta(query)

display(resultado)

'''
tab1_filtrado = resultado.query("status != 'Equipamentos de Terceiros > Devolvido ao Fornecedor'")
tab1_filtrado = tab1_filtrado.query("status != 'Ciclo de Vida > Furtado'")

qtd = tab1_filtrado.groupby(['fornecedor','status', 'localizacao']).size()

#qtd = resultado['status'].value_counts()
#xqtd = qtd.sort_values(ascending=False)


display(qtd)'''
#qtd.plot(x='status', y='localizacao', kind='barh')

#%%
