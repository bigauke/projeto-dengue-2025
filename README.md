# 🚀 Data Engineering Project: Dengue Analytics (DataSUS)

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Grafana](https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white)

## 📋 Sobre o Projeto
Este projeto implementa uma pipeline completa de Engenharia de Dados para análise epidemiológica da Dengue no Brasil, utilizando dados reais do SINAN (DataSUS). O objetivo foi transformar dados brutos e complexos em um **Dashboard Executivo** capaz de responder perguntas críticas sobre volumetria, perfis de pacientes e distribuição geográfica.

---

## 🏗️ Arquitetura e Fluxo de Dados

A arquitetura foi desenhada seguindo os princípios de **Modern Data Stack**, garantindo escalabilidade e separação de preocupações.

```mermaid
graph LR
    A[CSV Bruto: SINAN] --> B[PostgreSQL: Bronze Layer]
    B --> C{dbt: Transformation}
    C --> D[Silver: stg_dengue]
    D --> E[Gold: Star Schema]
    E --> F[dim_paciente]
    E --> G[dim_localizacao]
    E --> H[fct_notificacoes]
    H --> I[mrt_letalidade]
    I --> J[Grafana: Dashboard]


etalhes Técnicos:

    Ingestão: Dados carregados via COPY para uma camada Bronze bruta.

    Transformação (dbt):

        Silver Layer: Limpeza de strings, padronização de datas e tipagem correta.

        Gold Layer (Star Schema): Modelagem dimensional para otimização de queries analíticas. Uso de surrogate keys e pacotes como dbt_utils.

    Visualização: Grafana conectado ao Postgres, consumindo as tabelas Fato e Dimensões.

🛡️ Desafios Enfrentados e Soluções (The "Pro" Engineering)

Durante o desenvolvimento, enfrentei desafios reais comuns em dados públicos brasileiros:
1. O Mistério da Idade (SINAN Coding)

Problema: A base armazena idade como um código (ex: 4025 para 25 anos, 3010 para 10 meses). Inicialmente, o modelo classificou quase 100% dos pacientes como "Idosos".
Solução: Implementação de lógica matemática via SQL (MOD(idade, 1000)) para extrair a idade real e classificar corretamente as faixas etárias em Crianças, Adultos e Idosos.
2. Dicionários de Dados Inexistentes (IBGE vs. UF)

Problema: O campo de estado continha códigos numéricos do IBGE (ex: 35) em vez de siglas amigáveis (ex: SP).
Solução: Criação de um mapeamento dinâmico (CASE WHEN) no SQL para traduzir os códigos geográficos, garantindo que o usuário final visualize "SP", "MG" e não apenas números.
3. Otimização de Performance

Problema: Queries complexas de agregação direto na Fato (1.6M+ linhas) podem ser lentas.
Solução: Criação de uma Data Mart específica (mrt_dengue_letalidade) pré-agregada, reduzindo o tempo de carregamento dos painéis no Grafana para milissegundos.
📊 Insights Extraídos

Após a construção do Dashboard, os seguintes insights foram consolidados:

    Epicentro: O estado de São Paulo (SP) concentra o maior volume de notificações, seguido por Minas Gerais e Paraná.

    Perfil de Risco: Contrariando percepções comuns, 71% dos casos afetam adultos (15-59 anos), indicando exposição alta em idade ativa.

    Sazonalidade: Identificado pico crítico entre os meses de Março e Maio de 2025.

🛠️ Como Executar o Projeto

    Clone o repositório:
    Bash

    git clone [https://github.com/seu-usuario/dengue-analytics.git](https://github.com/seu-usuario/dengue-analytics.git)

    Suba o ambiente Docker:
    Bash

    docker-compose up -d

    Execute o dbt para transformar os dados:
    Bash

    docker exec -it airflow_dengue bash -c "cd dbt_dengue && dbt run"

    Acesse o Grafana:
    localhost:3000 (Importe o arquivo JSON da pasta /dashboards).

Contato:
Daniel Linhares - [https://www.linkedin.com/in/daniel-linhares-analista/] - danielinhares@gmail.com

---