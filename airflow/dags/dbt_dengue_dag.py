from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Configurações básicas da DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'pipeline_dengue_2025',
    default_args=default_args,
    description='Orquestrador do Pipeline de Dados da Dengue (dbt)',
    schedule_interval=None,  # 'None' para dispararmos manualmente
    catchup=False,
    tags=['dbt', 'dengue']
) as dag:

    # Tarefa que entra na pasta e executa o dbt dentro do container
    run_dbt = BashOperator(
        task_id='dbt_run_pipeline',
        bash_command='cd /opt/airflow/dbt_dengue && dbt run --profiles-dir . --target prod',
    )

    run_dbt