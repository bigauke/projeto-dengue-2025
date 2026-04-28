-- Cria o schema da camada bruta
CREATE SCHEMA IF NOT EXISTS bronze;

-- Cria a tabela com todas as 121 colunas exatas do SINAN 2025
CREATE TABLE IF NOT EXISTS bronze.dengue_raw (
    tp_not VARCHAR, id_agravo VARCHAR, dt_notific VARCHAR, sem_not VARCHAR, nu_ano VARCHAR, 
    sg_uf_not VARCHAR, id_municip VARCHAR, id_regiona VARCHAR, id_unidade VARCHAR, dt_sin_pri VARCHAR, 
    sem_pri VARCHAR, ano_nasc VARCHAR, nu_idade_n VARCHAR, cs_sexo VARCHAR, cs_gestant VARCHAR, 
    cs_raca VARCHAR, cs_escol_n VARCHAR, sg_uf VARCHAR, id_mn_resi VARCHAR, id_rg_resi VARCHAR, 
    id_pais VARCHAR, dt_invest VARCHAR, id_ocupa_n VARCHAR, febre VARCHAR, mialgia VARCHAR, 
    cefaleia VARCHAR, exantema VARCHAR, vomito VARCHAR, nausea VARCHAR, dor_costas VARCHAR, 
    conjuntvit VARCHAR, artrite VARCHAR, artralgia VARCHAR, petequia_n VARCHAR, leucopenia VARCHAR, 
    laco VARCHAR, dor_retro VARCHAR, diabetes VARCHAR, hematolog VARCHAR, hepatopat VARCHAR, 
    renal VARCHAR, hipertensa VARCHAR, acido_pept VARCHAR, auto_imune VARCHAR, dt_chik_s1 VARCHAR, 
    dt_chik_s2 VARCHAR, dt_prnt VARCHAR, res_chiks1 VARCHAR, res_chiks2 VARCHAR, resul_prnt VARCHAR, 
    dt_soro VARCHAR, resul_soro VARCHAR, dt_ns1 VARCHAR, resul_ns1 VARCHAR, dt_viral VARCHAR, 
    resul_vi_n VARCHAR, dt_pcr VARCHAR, resul_pcr_ VARCHAR, sorotipo VARCHAR, histopa_n VARCHAR, 
    imunoh_n VARCHAR, hospitaliz VARCHAR, dt_interna VARCHAR, uf VARCHAR, municipio VARCHAR, 
    tpautocto VARCHAR, coufinf VARCHAR, copaisinf VARCHAR, comuninf VARCHAR, classi_fin VARCHAR, 
    criterio VARCHAR, doenca_tra VARCHAR, clinc_chik VARCHAR, evolucao VARCHAR, dt_obito VARCHAR, 
    dt_encerra VARCHAR, alrm_hipot VARCHAR, alrm_plaq VARCHAR, alrm_vom VARCHAR, alrm_sang VARCHAR, 
    alrm_hemat VARCHAR, alrm_abdom VARCHAR, alrm_letar VARCHAR, alrm_hepat VARCHAR, alrm_liq VARCHAR, 
    dt_alrm VARCHAR, grav_pulso VARCHAR, grav_conv VARCHAR, grav_ench VARCHAR, grav_insuf VARCHAR, 
    grav_taqui VARCHAR, grav_extre VARCHAR, grav_hipot VARCHAR, grav_hemat VARCHAR, grav_melen VARCHAR, 
    grav_metro VARCHAR, grav_sang VARCHAR, grav_ast VARCHAR, grav_mioc VARCHAR, grav_consc VARCHAR, 
    grav_orgao VARCHAR, dt_grav VARCHAR, mani_hemor VARCHAR, epistaxe VARCHAR, gengivo VARCHAR, 
    metro VARCHAR, petequias VARCHAR, hematura VARCHAR, sangram VARCHAR, laco_n VARCHAR, 
    plasmatico VARCHAR, evidencia VARCHAR, plaq_menor VARCHAR, con_fhd VARCHAR, complica VARCHAR, 
    tp_sistema VARCHAR, nduplic_n VARCHAR, dt_digita VARCHAR, cs_flxret VARCHAR, flxrecebi VARCHAR, 
    migrado_w VARCHAR
);

-- Ingestão bruta: copia do CSV para a tabela
COPY bronze.dengue_raw 
FROM '/data/DENGBR25.csv' 
DELIMITER ',' 
CSV HEADER;