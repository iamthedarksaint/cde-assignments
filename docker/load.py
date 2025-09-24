import pandas as pd  
from sqlalchemy import create_engine
import psycopg2
import os

db_name = os.getenv("POSTGRES_DB")
db_user = os.getenv("POSTGRES_USER")
db_host = os.getenv("POSTGRES_HOST")
db_password = os.getenv("POSTGRES_PASSWORD")
db_port = os.getenv("POSTGRES_PORT")


def load(df):
    conn = f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
    engine = create_engine(conn)
    df.to_sql("data", engine, schema="public", if_exists="append", index=False)
    print("loaded into database")