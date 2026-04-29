-- Responde: Perfil de risco, Faixa Etária, Sexo.
{{ config(materialized='table') }}

SELECT
    DISTINCT
    {{ dbt_utils.generate_surrogate_key(['data_notificacao', 'cod_ibge_municipio', 'idade_codigo', 'sexo']) }} as sk_paciente,
    idade_codigo,  
    CASE 
        WHEN sexo = 'M' THEN 'Masculino'
        WHEN sexo = 'F' THEN 'Feminino'
        ELSE 'Não Informado'
    END as desc_sexo,
    CASE
        WHEN idade_codigo < 15 THEN 'Criança' 
        WHEN idade_codigo BETWEEN 15 AND 60 THEN 'Adulto'
        ELSE 'Idoso'
    END as faixa_etaria
FROM {{ ref('stg_dengue') }}