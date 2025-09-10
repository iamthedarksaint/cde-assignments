#  Parch & Posey Data Engineering Project

This project demonstrates hands-on skills in **Linux, Bash scripting, and PostgreSQL**.

1. **File Movement** → Move CSV files from a source directory to a destination directory.
2. **ETL Pipeline** → Extract, Transform, and Load data from Raw → Transformed → Gold.
3. **Database Loader** → Load CSV and JSON files into PostgreSQL.

---

## Features

* **Dynamic Database Loading**: Automatically creates database & tables from CSV headers.
* **Safe Table Handling**: Drops old tables before importing new CSVs.
* **File Movement Automation**: Moves CSVs between folders as part of workflow.
* **ETL Pipeline**:

  * Fetch data from external URLs with `curl`.
  * Transform & clean data (rename columns, select subset).
  * Store processed data in a layered structure: Raw → Transformed → Gold.
* **Environment Variables**: `.env` file keeps database credentials & paths secure.

---

## Project Structure

```
Scripts/
│── .env
│── .gitignore                                   
│── bash_script/
│   ├── posey.sh
│   ├── parch_and_posey
│   ├── my_files           
│   ├── json_csv.sh           
│   ├-- etl.sh
│
│         
│── sql_script/    
│   ├── new.sql
│   ├── old.sql
│   └── ...  
├──README.md             
```

---

##  Setup

### 1. Install Dependencies

* PostgreSQL & psql CLI
* curl
* bash

Ubuntu/WSL2 install:

```bash
sudo apt update
sudo apt install postgresql-client curl -y
```

### 2. Configure `.env`

Example `.env` file:

```bash
# Database Config
DB_HOST=host
DB_PORT=port
DB_USER=user
DB_PASSWORD=password
DB_NAME=name


# ETL Source URL
URL="https://example.com/data.csv"
```

##  Running Each Part

### 1. Database Loader

```bash
bash bashscript/posey.sh
```

* Loads CSVs into PostgreSQL.
* Creates database `posey` if missing.
* Drops & recreates tables dynamically.

---

### 2. File Movement

```bash
bash bashscript/json_csv.sh
```

* Moves CSVs from one folder to another.
* Useful for organizing datasets or archiving.

---

### 3. ETL Pipeline

```bash
bash bashscript/etl.sh
```

**Workflow**:

1. Download CSV from external `URL` → **Raw folder**
2. Transform & clean data → **Transformed folder**
3. Push final dataset → **Gold folder**

---

## Troubleshooting

* `.env: No such file` → Make sure `.env` path matches script location.
* `psql: command not found` → Install PostgreSQL client.
* CSV files not found → Verify `CSV_PATH` in `.env`.
* Permissions → Make scripts executable:

```bash
chmod +x bashscript/*.sh
```

