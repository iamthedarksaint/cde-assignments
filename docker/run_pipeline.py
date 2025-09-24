from extract import extract
from transform import transform
from load import load
import os 

csv_url=os.getenv("URL")


extract = extract(csv_url)
transform = transform(extract)
load(transform)    