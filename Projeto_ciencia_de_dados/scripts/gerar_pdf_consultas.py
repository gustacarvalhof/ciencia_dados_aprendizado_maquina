"""Gera TechDF_Analise_SQL.pdf: capa, uma consulta por página (SQL colorido + resultado) e encerramento.
Uso, a partir da raiz do repositório:  python scripts/gerar_pdf_consultas.py   (requer: playwright install chromium)"""
import html, pathlib, sys
from pygments import highlight
from pygments.lexers import PostgresLexer
from pygments.formatters import HtmlFormatter
from playwright.sync_api import sync_playwright

sys.path.insert(0, str(pathlib.Path(__file__).parent))
from rodar_sql_duckdb import executar, RAIZ

DESCRICAO = {'pedido_base': 'View pedido_base — remove datas futuras e duplicatas e limpa a avaliação de cancelados (Fase 3)',
             'item_limpo': 'View item_limpo — remove quantidade inválida e corrige preço sem vírgula (Fase 3)',
             'pedido_limpo': 'View pedido_limpo — base limpa com subtotal e indicador de atraso, usada pelos KPIs'}


def fmt(v):
    if isinstance(v, float):
        return f'{v:,.2f}'.replace(',', 'X').replace('.', ',').replace('X', '.')
    if isinstance(v, int) and abs(v) >= 1000:
        return f'{v:,}'.replace(',', '.')
    return html.escape(str(v))


def tabela(df):
    cab = ''.join(f'<th>{html.escape(str(c))}</th>' for c in df.columns)
    linhas = ''.join('<tr><td class="n">%d</td>%s</tr>' % (i + 1, ''.join(f'<td>{fmt(v)}</td>' for v in row))
                     for i, row in enumerate(df.itertuples(index=False)))
    return f'<table><tr><th></th>{cab}</tr>{linhas}</table>'


DECOR = '''<div class="faixa"></div>
<svg class="deco" viewBox="0 0 260 150"><rect x="20" y="95" width="34" height="55" rx="4" fill="#81c784"/>
<rect x="66" y="70" width="34" height="80" rx="4" fill="#66bb6a"/><rect x="112" y="85" width="34" height="65" rx="4" fill="#81c784"/>
<rect x="158" y="45" width="34" height="105" rx="4" fill="#43a047"/><rect x="204" y="15" width="34" height="135" rx="4" fill="#ef6c00"/></svg>'''

CSS = '''@page { size: A4; margin: 0 } body { margin: 0; font-family: "DejaVu Sans", Arial, sans-serif; color: #263238 }
.pag { width: 210mm; height: 297mm; position: relative; background: #f6faf6; page-break-after: always; overflow: hidden; box-sizing: border-box; padding: 34mm 18mm 0 }
.faixa { position: absolute; top: 0; left: 0; right: 0; height: 22mm; background: repeating-linear-gradient(90deg, #1b5e20 0 26mm, #43a047 26mm 44mm, #a5d6a7 44mm 48mm) }
.deco { position: absolute; right: 12mm; bottom: 10mm; width: 62mm }
h1 { font-size: 40pt; color: #1b5e20; margin: 55mm 0 6mm; line-height: 1.05 } h2 { color: #2e7d32; font-size: 15pt; margin: 0 0 12mm }
.meta { font-size: 11pt; line-height: 1.6 } .aviso { margin-top: 10mm; background: #fff; border: 1px solid #c8e6c9; padding: 4mm 5mm; font-size: 9.5pt; width: 125mm }
.tit { font-family: "DejaVu Sans Mono", monospace; color: #2e7d32; font-weight: bold; font-size: 13pt; margin-bottom: 5mm }
.highlight pre { font-family: "DejaVu Sans Mono", monospace; font-size: 8.3pt; line-height: 1.45; white-space: pre-wrap; margin: 0 0 7mm; font-weight: bold }
table { border-collapse: collapse; font-size: 8.3pt; margin-left: 8mm; background: #fff } th { background: #eef3ee; font-weight: normal }
th, td { border: 1px solid #d5ddd5; padding: 1mm 2.2mm; text-align: left } td.n { color: #777; background: #eef3ee; text-align: right }
.nota { font-size: 9.5pt; color: #555; margin-left: 8mm }'''


def gerar():
    estilo = HtmlFormatter(style='friendly').get_style_defs('.highlight')
    paginas = [f'''<div class="pag">{DECOR}<h1>TechDF<br>Análise<br>SQL</h1><h2>Validações, base limpa e KPIs do CRISP-DM</h2>
<div class="meta">Ciência de Dados e Aprendizagem de Máquina (A1) · UDF<br>Profa. Kadidja Valéria<br><br>Gustavo Carvalho de Oliveira (P1 e P2)</div>
<div class="aviso">Dados simulados de uma loja on-line fictícia de informática no DF: 1.200 clientes e 4.776 pedidos (jan./2025 a jun./2026), com erros inseridos de propósito.</div></div>''']
    for titulo, cmd, df in executar():
        cab = DESCRICAO.get(titulo, titulo)
        corpo = tabela(df) if df is not None else '<p class="nota">A view não retorna uma tabela: ela é a base consultada pelas próximas páginas.</p>'
        paginas.append(f'<div class="pag">{DECOR}<div class="tit">-- {html.escape(cab)}</div>{highlight(cmd.strip(), PostgresLexer(), HtmlFormatter())}{corpo}</div>')
    paginas.append(f'<div class="pag">{DECOR}<h1 style="margin-top:90mm">Obrigado!</h1><h2>TechDF · Análise SQL · Gustavo Carvalho de Oliveira</h2></div>')
    doc = f'<html><head><meta charset="utf-8"><style>{estilo}{CSS}</style></head><body>{"".join(paginas)}</body></html>'
    with sync_playwright() as p:
        nav = p.chromium.launch(); pg = nav.new_page(); pg.set_content(doc)
        pg.pdf(path=str(RAIZ / 'TechDF_Analise_SQL.pdf'), format='A4', print_background=True); nav.close()
    print('PDF gerado com', len(paginas), 'páginas')


if __name__ == '__main__':
    gerar()
