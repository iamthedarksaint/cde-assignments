import pandas as pd 
import time 


def transform(df):
    print("Transforming the data....")
    time.sleep(10)
    try:
        df = df.dropna()
        df = df.drop_duplicates()
        df["Value"] = pd.to_numeric(df["Value"], errors='coerce')
        df = df[["Year", "Units", "Variable_code", "Variable_name", "Variable_category", "Value"]]
        print("Finished transformation")
        return df
    except Exception as e:
        print(f"Error occurred during transformation: {e}")
        