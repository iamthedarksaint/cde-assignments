# import pandas as pd  
# from sqlalchemy import create_engine
import psycopg2
import os
import time
from dotenv import load_dotenv

load_dotenv()

db_name = os.getenv("POSTGRES_DB")
db_user = os.getenv("POSTGRES_USER")
db_host = os.getenv("HOST")
db_password = os.getenv("POSTGRES_PASSWORD")
db_port = os.getenv("POSTGRES_PORT")



def connect_db():
    print("Connecting to postgres.....")
    time.sleep(10)
    try:
        conn = psycopg2.connect(
            host=db_host,
            port=db_port,
            dbname=db_name,
            user=db_user,
            password=db_password
        )
        print("Connection to the database established.")
        return conn
    except psycopg2.Error as e:
        print(f"Connection to the database failed!: {e}")
        raise

def create_table(conn):
    print("Creating the table....")
    time.sleep(10)
    try:
        cursor = conn.cursor()
        cursor.execute("""
            CREATE SCHEMA IF NOT EXISTS cde;
            DROP TABLE IF EXISTS cde.survey;
            CREATE TABLE IF NOT EXISTS cde.survey(
                id SERIAL PRIMARY KEY,
                Year INT,
                Units TEXT,
                Variable_code TEXT,
                Variable_name TEXT,
                Variable_category TEXT,
                Value TEXT         
            )
        """)
        conn.commit()
        print("Table created successfully!")
    except psycopg2.Error as e:
        print(f"Failed to create table: {e}")
        raise


def insert_record(conn, df):
    print("Inserting data into the database..")
    try:
        cursor = conn.cursor()
        for _, row in df.iterrows():
            cursor.execute("""
                INSERT INTO cde.survey (
                    Year,
                    Units,
                    Variable_code,
                    Variable_name,
                    Variable_category,
                    Value        
                ) VALUES (%s, %s, %s, %s, %s, %s)
                """,(
                    row['Year'],
                    row['Units'],
                    row['Variable_code'],
                    row['Variable_name'],
                    row['Variable_category'],
                    row['Value']
                ))
        conn.commit()
        print("Data successfully inserted!")
    except psycopg2.Error as e:
        print("Failed to Insert records: {e}")
        raise


