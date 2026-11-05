/* =====================================================================
   TechDF – Análise CRISP-DM (dados simulados)
   Autor: Gustavo Carvalho de Oliveira · UDF · Profa. Kadidja Valéria
   Dialeto: PostgreSQL. Também roda no DuckDB (scripts/rodar_sql_duckdb.py).

   Estrutura:
     0. Tabelas (modelo relacional da loja)
     1. Validações de qualidade (V1–V6)            -> Fase 2 do CRISP-DM
     2. Views pedido_limpo e item_limpo           -> Fase 3 do CRISP-DM
     3. KPIs (KPI 1–KPI 7)                        -> Fase 2 (exploração)
     4. Consultas de apoio (A e B)                -> Fases 3 e 2
   ===================================================================== */


-- =====================================================================
-- 0. TABELAS
-- =====================================================================
CREATE TABLE "Regiao" (
    "idRegiao" INTEGER PRIMARY KEY,
    "regiao"   VARCHAR(40) NOT NULL
);

CREATE TABLE "Categoria" (
    "idCategoria" INTEGER PRIMARY KEY,
    "categoria"   VARCHAR(40) NOT NULL
);

CREATE TABLE "Produto" (
    "idProduto"   INTEGER PRIMARY KEY,
    "idCategoria" INTEGER NOT NULL REFERENCES "Categoria",
    "produto"     VARCHAR(80) NOT NULL,
    "precoLista"  DECIMAL(10,2) NOT NULL
);

CREATE TABLE "FormaPagamento" (
    "idFormaPagamento" INTEGER PRIMARY KEY,
    "formaPagamento"   VARCHAR(30) NOT NULL
);

CREATE TABLE "Cliente" (
    "idCliente"          INTEGER PRIMARY KEY,
    "emailCliente"       VARCHAR(120) NOT NULL,
    "idRegiao"           INTEGER NOT NULL REFERENCES "Regiao",
    "dataCadastro"       DATE NOT NULL,
    "programaFidelidade" BOOLEAN NOT NULL
);

CREATE TABLE "Pedido" (
    "idPedido"         INTEGER PRIMARY KEY,
    "idCliente"        INTEGER NOT NULL REFERENCES "Cliente",
    "dataPedido"       DATE NOT NULL,
    "idFormaPagamento" INTEGER NOT NULL REFERENCES "FormaPagamento",
    "status"           VARCHAR(12) NOT NULL,       -- Entregue | Cancelado | Devolvido
    "prazoEntregaDias" INTEGER,                    -- nulo quando cancelado
    "avaliacao"        INTEGER,                    -- 1 a 5, opcional
    "valorFrete"       DECIMAL(10,2) NOT NULL
);

CREATE TABLE "ItemPedido" (
    "idItem"        INTEGER PRIMARY KEY,
    "idPedido"      INTEGER NOT NULL REFERENCES "Pedido",
    "idProduto"     INTEGER NOT NULL REFERENCES "Produto",
    "quantidade"    INTEGER NOT NULL,
    "precoUnitario" DECIMAL(12,2) NOT NULL
);

-- Carga no PostgreSQL (psql), a partir da pasta do repositório:
-- \copy "Regiao"         FROM 'dados/regiao.csv'          CSV HEADER
-- \copy "Categoria"      FROM 'dados/categoria.csv'       CSV HEADER
-- \copy "Produto"        FROM 'dados/produto.csv'         CSV HEADER
-- \copy "FormaPagamento" FROM 'dados/forma_pagamento.csv' CSV HEADER
-- \copy "Cliente"        FROM 'dados/cliente.csv'         CSV HEADER
-- \copy "Pedido"         FROM 'dados/pedido.csv'          CSV HEADER
-- \copy "ItemPedido"     FROM 'dados/item_pedido.csv'     CSV HEADER


-- =====================================================================
-- 1. VALIDAÇÕES DE QUALIDADE (base bruta)
-- =====================================================================

-- V1. Campos obrigatórios nulos
SELECT COUNT(*) AS nulos
FROM "Pedido"
WHERE "idCliente" IS NULL OR "dataPedido" IS NULL
   OR "idFormaPagamento" IS NULL OR "status" IS NULL;

-- V2. Itens com quantidade zero ou negativa
SELECT COUNT(*) AS itens_quantidade_invalida
FROM "ItemPedido"
WHERE "quantidade" <= 0;

-- V3. Pedidos com data futura (extração em 30/06/2026)
SELECT COUNT(*) AS datas_futuras
FROM "Pedido"
WHERE "dataPedido" > DATE '2026-06-30';

-- V4. Provável vírgula esquecida: preço pago > 10x o preço de lista do produto
SELECT COUNT(*) AS precos_suspeitos,
       ROUND(SUM(i."quantidade" * i."precoUnitario"), 2) AS valor_inflado
FROM "ItemPedido" i
JOIN "Produto" p ON p."idProduto" = i."idProduto"
WHERE i."precoUnitario" > 10 * p."precoLista";

-- V5. Pedidos duplicados: mesmo cliente, data, pagamento e mesma lista de itens (duplo clique)
WITH assinatura AS (
    SELECT pe."idPedido", pe."idCliente", pe."dataPedido", pe."idFormaPagamento",
           string_agg(CAST(i."idProduto" AS VARCHAR) || 'x' || CAST(i."quantidade" AS VARCHAR), ','
                      ORDER BY i."idProduto", i."quantidade") AS itens
    FROM "Pedido" pe
    JOIN "ItemPedido" i ON i."idPedido" = pe."idPedido"
    WHERE pe."dataPedido" <= DATE '2026-06-30'
    GROUP BY 1, 2, 3, 4
)
SELECT COUNT(*) - COUNT(DISTINCT ("idCliente", "dataPedido", "idFormaPagamento", itens)) AS pedidos_duplicados
FROM assinatura;

-- V6. Status incoerente: pedido cancelado com avaliação registrada
SELECT COUNT(*) AS cancelados_com_avaliacao
FROM "Pedido"
WHERE "status" = 'Cancelado' AND "avaliacao" IS NOT NULL;


-- =====================================================================
-- 2. BASE LIMPA (Fase 3: selecionar e limpar)
--    pedido_limpo: remove datas futuras e duplicatas (mantém o menor id),
--                  apaga a avaliação de pedidos cancelados
--    item_limpo:   remove quantidade <= 0 e divide por 100 o preço > 10x o de lista
-- =====================================================================
CREATE VIEW pedido_base AS
WITH assinatura AS (
    SELECT pe."idPedido", pe."idCliente", pe."dataPedido", pe."idFormaPagamento",
           string_agg(CAST(i."idProduto" AS VARCHAR) || 'x' || CAST(i."quantidade" AS VARCHAR), ','
                      ORDER BY i."idProduto", i."quantidade") AS itens
    FROM "Pedido" pe
    JOIN "ItemPedido" i ON i."idPedido" = pe."idPedido"
    WHERE pe."dataPedido" <= DATE '2026-06-30'
    GROUP BY 1, 2, 3, 4
),
numerado AS (
    SELECT "idPedido",
           ROW_NUMBER() OVER (PARTITION BY "idCliente", "dataPedido", "idFormaPagamento", itens
                              ORDER BY "idPedido") AS ordem
    FROM assinatura
)
SELECT pe."idPedido", pe."idCliente", pe."dataPedido", pe."idFormaPagamento", pe."status",
       pe."prazoEntregaDias",
       CASE WHEN pe."status" = 'Cancelado' THEN NULL ELSE pe."avaliacao" END AS "avaliacao",
       pe."valorFrete"
FROM "Pedido" pe
JOIN numerado n ON n."idPedido" = pe."idPedido" AND n.ordem = 1;

CREATE VIEW item_limpo AS
SELECT i."idItem", i."idPedido", i."idProduto", p."idCategoria", i."quantidade",
       CASE WHEN i."precoUnitario" > 10 * p."precoLista" THEN ROUND(i."precoUnitario" / 100, 2)
            ELSE i."precoUnitario" END AS "precoUnitario"
FROM "ItemPedido" i
JOIN "Produto" p ON p."idProduto" = i."idProduto"
JOIN pedido_base pb ON pb."idPedido" = i."idPedido"
WHERE i."quantidade" > 0;

CREATE VIEW pedido_limpo AS
SELECT pb.*, s.subtotal,
       CASE WHEN pb."prazoEntregaDias" > 5 THEN 1 ELSE 0 END AS atrasado
FROM pedido_base pb
JOIN (SELECT "idPedido", SUM("quantidade" * "precoUnitario") AS subtotal
      FROM item_limpo GROUP BY 1) s ON s."idPedido" = pb."idPedido";


-- =====================================================================
-- 3. KPIs (sobre a base limpa; receita = pedidos entregues)
-- =====================================================================

-- KPI 1. Faturamento, pedidos entregues, ticket médio e taxa de atraso
SELECT ROUND(SUM(subtotal), 2)            AS faturamento,
       COUNT(*)                           AS pedidos_entregues,
       ROUND(AVG(subtotal), 2)            AS ticket_medio,
       ROUND(100.0 * AVG(atrasado), 1)    AS perc_atrasados
FROM pedido_limpo
WHERE "status" = 'Entregue';

-- KPI 2. Faturamento e pedidos por mês
SELECT CAST(date_trunc('month', "dataPedido") AS DATE) AS mes,
       COUNT(*) AS pedidos,
       ROUND(SUM(subtotal), 2) AS faturamento
FROM pedido_limpo
WHERE "status" = 'Entregue'
GROUP BY 1
ORDER BY 1;

-- KPI 3. Top 5 categorias por faturamento (participação no total)
SELECT c."categoria",
       ROUND(SUM(i."quantidade" * i."precoUnitario"), 2) AS faturamento,
       ROUND(100.0 * SUM(i."quantidade" * i."precoUnitario")
             / SUM(SUM(i."quantidade" * i."precoUnitario")) OVER (), 1) AS perc_faturamento
FROM item_limpo i
JOIN pedido_limpo pl ON pl."idPedido" = i."idPedido" AND pl."status" = 'Entregue'
JOIN "Categoria" c ON c."idCategoria" = i."idCategoria"
GROUP BY 1
ORDER BY faturamento DESC
LIMIT 5;

-- KPI 4. Participação de cada forma de pagamento no faturamento
SELECT fp."formaPagamento",
       COUNT(*) AS pedidos,
       ROUND(100.0 * SUM(pl.subtotal) / SUM(SUM(pl.subtotal)) OVER (), 1) AS perc_faturamento
FROM pedido_limpo pl
JOIN "FormaPagamento" fp ON fp."idFormaPagamento" = pl."idFormaPagamento"
WHERE pl."status" = 'Entregue'
GROUP BY 1
ORDER BY 3 DESC;

-- KPI 5. Prazo médio e percentual de pedidos atrasados por região (hipótese H2)
SELECT r."regiao",
       COUNT(*) AS entregas,
       ROUND(AVG(pl."prazoEntregaDias"), 1) AS prazo_medio_dias,
       ROUND(100.0 * AVG(pl.atrasado), 1)   AS perc_atrasados
FROM pedido_limpo pl
JOIN "Cliente" cl ON cl."idCliente" = pl."idCliente"
JOIN "Regiao"  r  ON r."idRegiao"   = cl."idRegiao"
WHERE pl."status" = 'Entregue'
GROUP BY 1
ORDER BY 3;

-- KPI 6. Avaliação média por faixa de prazo de entrega
SELECT CASE WHEN "prazoEntregaDias" <= 3 THEN '1. até 3 dias'
            WHEN "prazoEntregaDias" <= 5 THEN '2. 4 a 5 dias'
            WHEN "prazoEntregaDias" <= 7 THEN '3. 6 a 7 dias'
            ELSE '4. 8 dias ou mais' END AS faixa_prazo,
       COUNT(*) AS pedidos_avaliados,
       ROUND(AVG("avaliacao"), 2) AS avaliacao_media
FROM pedido_limpo
WHERE "status" = 'Entregue' AND "avaliacao" IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- KPI 7. Recompra em até 90 dias após a primeira compra, por atraso na primeira entrega (hipótese H1)
--        (só primeiras compras até 31/03/2026, para que os 90 dias seguintes estejam na base)
WITH primeira AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY "idCliente" ORDER BY "dataPedido", "idPedido") AS n
    FROM pedido_limpo
    WHERE "status" = 'Entregue'
)
SELECT CASE WHEN f.atrasado = 1 THEN 'Primeira entrega atrasada' ELSE 'Primeira entrega no prazo' END AS primeira_entrega,
       COUNT(*) AS clientes,
       ROUND(100.0 * AVG(CASE WHEN EXISTS (
                 SELECT 1 FROM pedido_limpo o
                 WHERE o."idCliente" = f."idCliente" AND o."idPedido" <> f."idPedido"
                   AND o."dataPedido" > f."dataPedido"
                   AND o."dataPedido" <= f."dataPedido" + INTERVAL '90 days') THEN 1 ELSE 0 END), 1) AS perc_recompra_90d
FROM primeira f
WHERE f.n = 1 AND f."dataPedido" <= DATE '2026-03-31'
GROUP BY 1
ORDER BY 1;


-- =====================================================================
-- 4. CONSULTAS DE APOIO
-- =====================================================================

-- A. Tabela RFM por cliente na data da extração (base da P1 — o notebook completa ticket e mix de produtos)
SELECT pl."idCliente",
       DATE '2026-06-30' - MAX(pl."dataPedido") AS recencia_dias,
       COUNT(*) AS frequencia,
       ROUND(SUM(pl.subtotal), 2) AS valor_total,
       ROUND(AVG(pl."prazoEntregaDias"), 1) AS prazo_medio
FROM pedido_limpo pl
WHERE pl."status" = 'Entregue'
GROUP BY 1
ORDER BY valor_total DESC
LIMIT 10;

-- B. Hipótese H3: frequência de compra e ticket médio por participação no programa de fidelidade
SELECT CASE WHEN c."programaFidelidade" THEN 'Participa' ELSE 'Não participa' END AS fidelidade,
       COUNT(DISTINCT c."idCliente") AS clientes,
       ROUND(1.0 * COUNT(*) / COUNT(DISTINCT c."idCliente"), 2) AS pedidos_por_cliente,
       ROUND(AVG(pl.subtotal), 2) AS ticket_medio
FROM pedido_limpo pl
JOIN "Cliente" c ON c."idCliente" = pl."idCliente"
WHERE pl."status" = 'Entregue'
GROUP BY 1
ORDER BY 1;
