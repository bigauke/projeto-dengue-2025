-- Responde: Onde estão os casos e quais regiões são críticas.

-- models/marts/dim_localizacao.sql
{{ config(materialized='table') }}

SELECT
    DISTINCT
    cod_ibge_municipio as id_municipio, -- Mapeando o nome novo para o alias antigo
    uf_notificacao as sigla_uf,
    CASE 
        WHEN uf_notificacao IN ('SP', 'RJ', 'MG', 'ES') THEN 'Sudeste'
        WHEN uf_notificacao IN ('BA', 'PE', 'CE', 'RN', 'PB', 'AL', 'SE', 'MA', 'PI') THEN 'Nordeste'
        -- ... demais regras ...
        ELSE 'Outra'
    END as regiao
FROM {{ ref('stg_dengue') }}