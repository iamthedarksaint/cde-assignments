import pandas as pd  
import requests


def extract(csv_url):
    try:
        response = requests.get(csv_url)
        if response.status_code == 200:
            print("Speaking to the source")

        df = pd.read_csv(csv_url)
     
        return df
        
    except Exception as e:
        print(f"Error while extracting {e}")




       


