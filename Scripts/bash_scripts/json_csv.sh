echo A script to move all json file from one folder to another folder named json_and_csv

CURRENT="./my_files"
DESTINATION="./json_and_csv"

mkdir -p "$DESTINATION"

echo "Moving files from $CURRENT"
cp "$CURRENT"/*.csv "$DESTINATION"
cp "$CURRENT"/*.json "$DESTINATION"

echo "Moved all json and csv files into $destination" 
