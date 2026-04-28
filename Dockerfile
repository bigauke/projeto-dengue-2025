# 1. Partimos de uma imagem oficial e estável do Airflow
FROM apache/airflow:2.7.1-python3.11

# 2. Travamos as versões do dbt e de suas dependências para evitar o "Dependency Hell"
# Note que usamos a versão 1.7 do dbt, que é super estável com o Airflow 2.7
RUN pip install --no-cache-dir \
    dbt-postgres==1.7.0 \
    dbt-core==1.7.0 \
    protobuf==4.25.3