
#  Data Pipeline with Python, DBT, PostgreSQL & Metabase

##  Project Overview

This project demonstrates a complete **data pipeline** using Docker containers for:

* **ETL with Python**
* **Data transformation with DBT**
* **Data storage in PostgreSQL**
* **Visualization with Metabase**

All services are containerized using **Docker Compose**, allowing quick setup and consistent environments for both local development and production.

---

##  Project Architecture

```text
+----------------+       +-----------------+       +-----------------+       +----------------+
|   Python (ETL) | ---> |  PostgreSQL DB  | ---> |      DBT        | ---> |   Metabase UI  |
+----------------+       +-----------------+       +-----------------+       +----------------+
```

* **Python** extracts, transforms, and loads data into Postgres.
* **DBT** performs SQL-based transformations and modeling.
* **Metabase** provides analytics and dashboard visualization.

---

##  Dockerized Services

| Service      | Description                     | Port        |
| ------------ | ------------------------------- | ----------- |
| **db**       | PostgreSQL database             | `5000:5432` |
| **python**   | Runs ETL pipeline scripts       | —           |
| **dbt**      | Runs DBT transformations        | —           |
| **metabase** | Business Intelligence dashboard | `3000:3000` |

---

##  Setup Instructions

### Clone the Repository

```bash
git clone https://github.com/iamthedarksaint/cde_assignments.git
cd <cde_assignments>
```

###  Environment Variables

Create a `.env` file in the root directory:

```bash
POSTGRES_DB=db
POSTGRES_USER=db_user
POSTGRES_PASSWORD=password
DBT_PROFILES_DIR=/root/.dbt
```

*(Adjust values if needed.)*

---

###  Project Structure

```
.
├── docker-compose.yml
├── Dockerfile
├── .env
├── requirements.txt
├── data/
│   └── my_csv_file.csv
├── scripts/
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   └── run_pipeline.py
├── dbt/
│   └── my_project/
│       ├── dbt_project.yml
│       ├── models/
│       └── profiles.yml
└── postgres/
    └── data/
```

---

###  Run the Pipeline

Build and start all services:

```bash
docker-compose up --build
```

This will:

* Start PostgreSQL, Python, DBT, and Metabase containers.
* Run the ETL and DBT transformations.
* Make Metabase available at [http://localhost:3000](http://localhost:3000).

---

###  Connect Metabase

1. Open **[http://localhost:3000](http://localhost:3000)**
2. Complete the setup wizard
3. Connect to your Postgres database with these credentials:

   * **Host:** `db`
   * **Port:** `5432`
   * **Database:** `db`
   * **Username:** `db_user`
   * **Password:** `password`

Once connected, Metabase automatically detects your DBT models and tables.

---

###  Create Visualizations

1. Go to **Browse Data → Select Database → Choose a Table**
2. Click **Summarize → Group by** and **Aggregate** fields
3. Select a visualization type (Bar, Line, Pie, etc.)
4. Save and add visuals to a dashboard
5. Optionally, add filters and schedule reports

---

## 🧩 Useful Commands

| Command                                         | Description                    |
| ----------------------------------------------- | ------------------------------ |
| `docker-compose up --build`                     | Build and start all containers |
| `docker-compose down`                           | Stop and remove all containers |
| `docker exec -it pg_cont psql -U db_user -d db` | Connect to Postgres            |
| `docker exec -it dbt_cont dbt debug`            | Test DBT connection            |
| `docker exec -it dbt_cont dbt run`              | Manually run DBT models        |

---

## 🧠 Notes

* Metabase stores its data in memory by default. To persist dashboards, configure Metabase to use PostgreSQL as its **application database**.
* My ETL scripts are all mounted from the `scripts/` directory, so you can edit them locally and re-run the pipeline.

---

## 🧰 Technologies Used

* 🐍 **Python 3.11**
* 🧮 **DBT (Data Build Tool)**
* 🐘 **PostgreSQL 15**
* 📊 **Metabase**
* 🐳 **Docker & Docker Compose**

---

## 👨‍💻 Author

**Hassan Azeez**
*Data Engineer*
📧 [bojzino128@gmail.com]

