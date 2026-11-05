"""Executa o techdf.sql inteiro no DuckDB (sem instalar o PostgreSQL) e imprime cada resultado.
Uso, a partir da raiz do repositório:  python scripts/rodar_sql_duckdb.py"""
import re, json, pathlib, duckdb

RAIZ = pathlib.Path(__file__).resolve().parent.parent
TABELAS = {'Regiao': 'regiao', 'Categoria': 'categoria', 'Produto': 'produto', 'FormaPagamento': 'forma_pagamento',
           'Cliente': 'cliente', 'Pedido': 'pedido', 'ItemPedido': 'item_pedido'}


def blocos(sql):
    """Divide o arquivo em comandos, guardando o comentário de título (V1, KPI 1, A...) de cada um."""
    saida, titulo, atual = [], None, []
    for linha in sql.splitlines():
        m = re.match(r'--\s*((?:V\d|KPI \d|[AB])\..*)', linha)
        if m and not atual:
            titulo = m.group(1).strip()
        if linha.strip().startswith('--') or linha.strip().startswith('/*') or not linha.strip():
            if not atual:
                continue
        atual.append(linha)
        if linha.rstrip().endswith(';'):
            saida.append((titulo, '\n'.join(atual).rstrip(';')))
            titulo, atual = None, []
    return saida


def executar():
    sql = re.sub(r'/\*.*?\*/', '', (RAIZ / 'techdf.sql').read_text(encoding='utf-8'), flags=re.S)
    con = duckdb.connect()
    resultados = []
    for titulo, cmd in blocos(sql):
        con.execute(cmd)
        m = re.match(r'\s*CREATE TABLE "(\w+)"', cmd)
        if m:
            con.execute(f'''INSERT INTO "{m.group(1)}" SELECT * FROM read_csv_auto('{RAIZ / "dados" / (TABELAS[m.group(1)] + ".csv")}', header=true)''')
            continue
        if cmd.lstrip().upper().startswith('SELECT') or cmd.lstrip().upper().startswith('WITH'):
            df = con.execute(cmd).fetchdf()
            resultados.append((titulo, cmd, df))
        elif cmd.lstrip().upper().startswith('CREATE VIEW'):
            resultados.append((re.search(r'CREATE VIEW (\w+)', cmd).group(1), cmd, None))
    return resultados


if __name__ == '__main__':
    for titulo, _, df in executar():
        print('=' * 80, '\n', titulo)
        print('(view criada)' if df is None else df.to_string(index=False))
