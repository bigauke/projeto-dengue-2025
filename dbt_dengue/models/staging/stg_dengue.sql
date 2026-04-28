{{ config(materialized='table') }}

WITH raw_data AS (
    SELECT * FROM {{ source('minsaude', 'dengue_raw') }}
)

SELECT
    tp_not,
    -- Converte a string de data para o formato real de DATE
    CAST(dt_notific AS DATE) AS data_notificacao,
    
    sg_uf_not AS uf_notificacao,
    id_municip AS cod_ibge_municipio,
    
    -- Idade vem com um código bizarro às vezes, vamos limpar depois, mas já como INT
    CAST(NULLIF(nu_idade_n, '') AS INTEGER) AS idade_codigo,
    
    cs_sexo AS sexo,
    
    -- Sintomas e classificações
    febre,
    mialgia,
    classi_fin AS classificacao_final

FROM raw_data
-- Filtra lixos onde a data de notificação venha vazia
WHERE dt_notific IS NOT NULL 
  AND dt_notific != ''