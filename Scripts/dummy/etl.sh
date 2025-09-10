#!/bin/bash

echo MY ETL PIPELINE

echo Extracting data from source....

sleep 5

export URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

mkdir -p "./raw"

curl -O --output-dir "./raw" $URL

if [ $? -eq 0 ]; then
    echo "Data Extracted Successfully!"
else
    echo "Extraction Failed. Check the URL or something around you curl command sha."
    exit 1
fi

# Rename coumn Variable_code to variable_code
sed -i '1s/Variable_code/variable_code/' "./raw/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Select the needed columns

mkdir "./Transformed"

cut -d, -f1,9,5,6 "./raw/annual-enterprise-survey-2023-financial-year-provisional.csv" > "./Transformed/2023_year_finance.csv"

if [ $? -eq 0 ]; then
    echo Tranformed and loaded into 2023_year_finance.csv
else
    echo "Unable to change columns, please check again!"
    exit 1
fi

#Move to Gold
mkdir "./Gold"
cp "./Transformed/2023_year_finance.csv" "./Gold/"

if [ $? -eq 0 ]; then
    echo "Loaded into Gold successfully!"
else 
    echo "Unable to load into Gold"
    exit 1
fi
   

echo "Extracted, Transformed and Loaded successfully!"
