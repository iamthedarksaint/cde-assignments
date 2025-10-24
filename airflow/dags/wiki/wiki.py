from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator
from airflow.providers.standard.operators.python import PythonOperator
from pendulum import datetime, DateTime
from datetime import timedelta
import os

destination="/opt/airflow/dags/wiki/data"
url = "https://dumps.wikimedia.org/other/pageviews/"

        
with DAG(
    dag_id="wiki_data",
    start_date=datetime(2025, 10, 20),
    schedule="@hourly",
    catchup=False,
    default_args={
        "retries":3,
        "retry_delay": timedelta(minutes=20)
    }
):  
    
    cleanup_dir = BashOperator(
        task_id="cleanup_dir",
        bash_command=f"rm -f {destination}/*",
    )

    extract_page  = BashOperator(
        task_id="extract_page",
        bash_command=(
            f"curl -f -O -L --output-dir {destination} "
            f"{url}{{{{ logical_date.year }}}}/{{{{ logical_date.format('YYYY-MM') }}}}/"
            f"pageviews-{{{{ (logical_date - macros.timedelta(hours=3)).format('YYYYMMDD-HHmmss') }}}}.gz"
        ),
    )

    unzip_page = BashOperator(
        task_id="unzip_page",
        bash_command=(
            f"gunzip -f {destination}/pageviews-{{{{ (logical_date - macros.timedelta(hours=3)).format('YYYYMMDD-HHmmss') }}}}.gz"
        ),
    )


    cleanup_dir >> extract_page >> unzip_page