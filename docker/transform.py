import pandas as pd  


def transform(df):
    
    df.dropna()

    df["Value"] = pd.to_numeric(df["Value"], errors='coerce')

    df = df[["Year", "Units", "Variable_code", "Variable_name", "Variable_category", "Value"]]
    print("Finished transformation")
    return df
    