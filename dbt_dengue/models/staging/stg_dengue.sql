{{ config(materialized='table') }}

WITH raw_data AS (
    SELECT * FROM {{ source('minsaude', 'dengue_raw') }}
)

SELECT
    -- Identificação e Datas
    tp_not,
    CAST(dt_notific AS DATE) AS data_notificacao,
    CAST(NULLIF(dt_sin_pri, '') AS DATE) AS data_sintomas,
    CAST(NULLIF(dt_interna, '') AS DATE) AS data_internacao,
    CAST(NULLIF(dt_obito, '') AS DATE) AS data_obito,
    
    -- Localização
    sg_uf_not AS uf_notificacao,
    id_municip AS cod_ibge_municipio,
    
    -- Paciente
    CAST(NULLIF(nu_idade_n, '') AS INTEGER) AS idade_codigo,
    cs_sexo AS sexo,
    cs_gestant AS gestante_codigo,
    cs_raca AS raca_codigo,
    
    -- Sintomas Principais
    febre,
    mialgia,
    cefaleia,
    vomito,
    nausea,
    dor_retro AS dor_retroorbital,
    
    -- Desfecho e Gravidade
    hospitaliz AS flg_hospitalizacao, -- 1=Sim, 2=Não
    classi_fin AS classificacao_final,
    evolucao AS evolucao_caso -- 5=Óbito, 1=Cura
    
FROM raw_data
WHERE dt_notific IS NOT NULL 
  AND dt_notific != ''
  AND dt_notific LIKE '20%'