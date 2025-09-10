export DB_HOST="localhost"
export DB_PORT="5433"
export DB_USER="postgres"
export DB_NAME="posey"
export DB_PASSWORD="postgres"

export CSV_PATH="/home/hassan/cde/linux_and_git/assignment/cde_linux_git_assignment-/parch_and_posey"

export PGPASSWORD="$DB_PASSWORD"

DB_EXISTS=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME';")

if [ "$DB_EXISTS" != "1" ]; then
    echo "Database $DB_NAME does not exist. Creating..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -c "CREATE DATABASE $DB_NAME;"
    echo "Database $DB_NAME created successfully."
else
    echo "Database $DB_NAME already exists."
fi


for csv_file in "$CSV_PATH"/*.csv; do
    filename=$(basename -- "$csv_file")
    table="${filename%.*}"

    echo "Loading $csv_file into table $table"

    header=$(head -n 1 "$csv_file")
    columns=$(echo "$header" | sed 's/,/ TEXT,/g')
    columns="$columns TEXT"

    # Drop existing table
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "DROP TABLE IF EXISTS $table;"

    # Create new table
    create_table="CREATE TABLE $table ($columns);"
    echo "Creating table $table..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "$create_table"

    # Import data
    echo "Importing data into $table..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "\copy $table FROM '$csv_file' CSV HEADER"

done

echo "Loaded into Database Successfully!"

