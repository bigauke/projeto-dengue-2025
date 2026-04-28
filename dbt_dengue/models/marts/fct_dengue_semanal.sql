{{ config(MATERIALIZED='table') }}

SELECT
-- Agrupamos pela data ( arredondadno para o niívio da semana)
DATE_TRUNC('week', data_notificacao) AS semana_referenciada,
uf_notificacao,
COUNT(*) AS total_casos,
-- Contagem específica para casos confirmados
COUNT(*) FILTER (WHERE febre = '1') AS casos_com_febre
FROM {{ ref('stg_dengue') }}
GROUP BY 1, 2
ORDER BY 1 DESC, 2 ASC