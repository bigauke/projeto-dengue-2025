SELECT
    uf_notificacao,
    SUM(qtd_casos) as total_casos,
    SUM(qtd_obitos) as total_obitos,
    ROUND((SUM(qtd_obitos)::numeric / NULLIF(SUM(qtd_casos), 0)) * 100, 4) as taxa_letalidade_pct
FROM {{ ref('fct_notificacoes') }}
GROUP BY 1