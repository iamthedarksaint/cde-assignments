from extract import extract2
from transform import transform
from load import connect_db, create_table, insert_record
import os 

# csv_url=os.getenv("URL")
csv_url = "data/survey.csv"


if __name__ == "__main__":
    conn = None
    try:
        df = extract2(csv_url)
        transform = transform(df)     
        conn = connect_db()
        create_table(conn)
        insert_record(conn, df)
    except Exception as e:
        print(f"Error occured during execution: {e}")
    finally:
        if conn:
            conn.close()
            print("Database connection closed.")