-- Top 10 filmes mais lucrativos
SELECT
  f.MOV_SRK,
  f.NM_TIT,
  (f.VL_REV - f.VL_BDG) AS lucro,
  f.in_adl
FROM data_warehouse.FCT_MOV f
WHERE f.vl_bdg > 1000
ORDER BY lucro DESC
LIMIT 10;

-- Lucro médio por gênero
SELECT
  g.NM_GEN AS genero,
  AVG(f.VL_REV - f.VL_BDG) AS lucro_medio
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.MOV_GEN mg ON mg.MOV_SRK = f.MOV_SRK
JOIN data_warehouse.DIM_GEN g ON g.GEN_SRK = mg.GEN_SRK
GROUP BY g.NM_GEN
ORDER BY lucro_medio DESC;

-- Popularidade média por gênero
SELECT
  g.NM_GEN AS genero,
  AVG(f.VL_POP) AS popularidade_media
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.MOV_GEN mg ON mg.MOV_SRK = f.MOV_SRK
JOIN data_warehouse.DIM_GEN g ON g.GEN_SRK = mg.GEN_SRK
GROUP BY g.NM_GEN
ORDER BY popularidade_media DESC;

-- Lucro médio por ano de lançamento
SELECT
  d.ANO AS ano,
  AVG(f.VL_REV - f.VL_BDG) AS lucro_medio
FROM data_warehouse.FCT_MOV f
LEFT JOIN data_warehouse.DIM_DAT d ON d.DAT_SRK = f.DAT_SRK
GROUP BY d.ANO
ORDER BY d.ANO;

-- 100 produtoras mais lucrativas
SELECT DISTINCT
  c.NM_PRD_COM AS produtora,
  SUM(f.VL_REV - f.VL_BDG) AS lucro_total
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.MOV_COM mc ON mc.MOV_SRK = f.MOV_SRK
JOIN data_warehouse.DIM_PRD_COM c ON c.COM_SRK = mc.COM_SRK
GROUP BY c.NM_PRD_COM
ORDER BY lucro_total DESC
LIMIT 100;

-- Distribuição da quantidade de filmes por país
SELECT
  c.NM_PRD_CNT AS pais,
  COUNT(DISTINCT f.MOV_SRK) AS quantidade_filmes
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.MOV_CNT mc ON mc.MOV_SRK = f.MOV_SRK
JOIN data_warehouse.DIM_CNT c ON c.CNT_SRK = mc.CNT_SRK
GROUP BY c.NM_PRD_CNT
ORDER BY quantidade_filmes DESC;

-- Lucro médio por país
SELECT
  c.NM_PRD_CNT AS pais,
  AVG(f.VL_REV - f.VL_BDG) AS lucro_medio
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.MOV_CNT mc ON mc.MOV_SRK = f.MOV_SRK
JOIN data_warehouse.DIM_CNT c ON c.CNT_SRK = mc.CNT_SRK
GROUP BY c.NM_PRD_CNT
ORDER BY lucro_medio DESC;

-- Lucro médio por faixa de duração
SELECT
  CASE
    WHEN f.QT_RUN IS NULL THEN 'Desconhecido'
    WHEN f.QT_RUN < 90 THEN 'Curto (<90)'
    WHEN f.QT_RUN BETWEEN 90 AND 120 THEN 'Médio (90-120)'
    ELSE 'Longo (>120)'
  END AS faixa_duracao,
  AVG(f.VL_REV - f.VL_BDG) AS lucro_medio
FROM data_warehouse.FCT_MOV f
GROUP BY faixa_duracao
ORDER BY faixa_duracao;

-- Gêneros mais lucrativos de cada ano
WITH lucro_genero_ano AS (
    SELECT
        d.ANO AS ano,
        g.NM_GEN AS genero,
        SUM(f.VL_REV - f.VL_BDG) AS lucro_total
    FROM data_warehouse.FCT_MOV f
    JOIN data_warehouse.DIM_DAT d ON d.DAT_SRK = f.DAT_SRK
    JOIN data_warehouse.MOV_GEN mg ON mg.MOV_SRK = f.MOV_SRK
    JOIN data_warehouse.DIM_GEN g ON g.GEN_SRK = mg.GEN_SRK
    GROUP BY d.ANO, g.NM_GEN
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY ano ORDER BY lucro_total DESC) AS rn
    FROM lucro_genero_ano
)
SELECT
    ano,
    genero,
    lucro_total
FROM ranked
WHERE rn = 1
ORDER BY ano DESC;

-- Lucro médio de filmes por mês desde 1980
SELECT
    d.MES AS mes,
    AVG(f.VL_REV - f.VL_BDG) AS media_lucro
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.DIM_DAT d
    ON d.DAT_SRK = f.DAT_SRK
WHERE d.ANO >= 1980
GROUP BY d.MES
ORDER BY d.MES;

-- Parte do mês mais lucrativa para se lançar filmes
SELECT
    CASE
        WHEN d.DIA <= 15 THEN '1-15'
        ELSE '16-31'
    END AS metade_mes,
    AVG(f.VL_REV - f.VL_BDG) AS media_lucro
FROM data_warehouse.FCT_MOV f
JOIN data_warehouse.DIM_DAT d
    ON d.DAT_SRK = f.DAT_SRK
GROUP BY
    CASE
        WHEN d.DIA <= 15 THEN '1-15'
        ELSE '16-31'
    END
ORDER BY metade_mes;