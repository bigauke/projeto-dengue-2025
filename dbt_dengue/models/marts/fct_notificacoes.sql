{{ config(materialized='table') }}

SELECT
    -- Dimensões e Chaves
    data_notificacao,
    uf_notificacao,  -- <--- ADICIONADO: Essencial para o modelo de letalidade
    cod_ibge_municipio as id_municipio,
    {{ dbt_utils.generate_surrogate_key(['data_notificacao', 'cod_ibge_municipio', 'idade_codigo', 'sexo']) }} as sk_paciente,
    
    -- Métricas de Volume
    1 as qtd_casos,
    
    -- Métricas de Gravidade (Tratando possíveis nulos com COALESCE)
    COALESCE(CASE WHEN evolucao_caso = '5' THEN 1 ELSE 0 END, 0) as qtd_obitos,
    COALESCE(CASE WHEN flg_hospitalizacao = '1' THEN 1 ELSE 0 END, 0) as qtd_hospitalizacoes,
    
    -- Eficiência (Tempo de Resposta em dias)
    -- Usamos NULLIF para evitar erros caso a data_sintomas venha vazia
    data_notificacao - COALESCE(data_sintomas, data_notificacao) as dias_atraso_notificacao,
    
    -- Sintomas
    CASE WHEN febre = '1' THEN 1 ELSE 0 END as flg_febre,
    CASE WHEN mialgia = '1' THEN 1 ELSE 0 END as flg_mialgia

FROM {{ ref('stg_dengue') }}