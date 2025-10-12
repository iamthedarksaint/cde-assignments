import pandas as pd  
import requests
import time


# def extract(csv_url):
#     print("Extracting Data from the source.")
#     try:
#         response = requests.get(csv_url)
#         if response.status_code == 200:
#             print("Data Extracted!")

#         df = pd.read_csv(csv_url)
#         df.to_csv("variable.csv", index=False)
     
#         return df
        
#     except Exception as e:
#         print(f"Error while extracting {e}")
#         raise

def extract2(csv):
    print("Extracting Data from the source.")
    time.sleep(10)
    try:
        df = pd.read_csv(csv)
        print("Data extracted successfully!")
        return df
    except Exception as e:
        print(f"Error during extraction.: {e}")
        raise
       


