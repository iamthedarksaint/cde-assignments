#!/bin/bash

echo MY ETL PIPELINE

echo Extracting data from source....

sleep 5

export BASE_DIR="/home/hassan/cde/linux_and_git/assignment/cde_linux_git_assignment-/etl"


export url="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

mkdir -p "$BASE_DIR/raw"

curl -O --output-dir "$BASE_DIR/raw" $url

if [ $? -eq 0 ] 
   then
       echo "Data Extracted Successfully!"
   else
       echo "Extraction Failed. Check the URL or something around you curl command sha."
       exit 1
fi

# Rename coumn Variable_code to variable_code
sed -i '1s/Variable_code/variable_code/' "$BASE_DIR/raw/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Select the needed columns

mkdir "$BASE_DIR/Transformed"

cut -d, -f1,9,5,6 "$BASE_DIR/raw/annual-enterprise-survey-2023-financial-year-provisional.csv" > "$BASE_DIR/Transformed/2023_year_finance.csv"

echo Tranformed and loaded into 2023_year_finance.csv

#Move to Gold
mkdir "$BASE_DIR/Gold"
cp "$BASE_DIR/Transformed/2023_year_finance.csv" "$BASE_DIR/Gold/"

echo Successfully moved to Gold
