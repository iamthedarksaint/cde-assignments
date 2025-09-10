echo A script to move all json file from one folder to another folder named json_and_csv

current_folder="."
json_and_csv_folder="./json_and_csv"

echo "Moving files from $current_folder"
mv *.csv *.json  "$json_and_csv_folder"

echo "Moved all json and csv files into a $json_and_csv_folder" 
