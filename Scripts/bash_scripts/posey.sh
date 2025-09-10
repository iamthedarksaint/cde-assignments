set -a
source ../.env
set +a

export PGPASSWORD="$DB_PASSWORD"

# Create database if it doesn’t exist
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -tc \
"SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -c "CREATE DATABASE $DB_NAME;"

for csv_file in "$CSV_PATH"/*.csv; do
    filename=$(basename -- "$csv_file")
    table="${filename%.*}"

    echo "Loading $csv_file into table $table"

    header=$(head -n 1 "$csv_file")
    columns=$(echo "$header" | sed 's/,/ TEXT,/g')
    columns="$columns TEXT"

    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "DROP TABLE IF EXISTS $table;"
    create_table="CREATE TABLE $table ($columns);"
    echo "Creating table $table..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "$create_table"

    echo "Importing data into $table..."
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "\copy $table FROM '$csv_file' CSV HEADER"
done

echo "Loaded into Database Successfully!"
