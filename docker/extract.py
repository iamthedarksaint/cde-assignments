import pandas as pd  
import requests


def extract(csv_url):
    try:
        print("Extracting Data from the source.")
        response = requests.get(csv_url)
        if response.status_code == 200:
            print("Data Extracted!")

        df = pd.read_csv(csv_url)
     
        return df
        
    except Exception as e:
        print(f"Error while extracting {e}")




       


