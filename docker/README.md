# ETL Project in Docker

In this project, I built an **ETL (Extract, Transform, Load) pipeline** using Python and PostgreSQL, fully dockerized. The ETL extracts data from a source URL, transforms it using Python, and loads it into a PostgreSQL database.

---

## Project Structure

```
docker/
│
├── Dockerfile
├── docker_var.sh
├── .env
├── requirements.txt
├── extract.py
├── transform.py
├── load.py
├── run_pipeline.py
└── README.md
```

> `.env` is provided as a template. Users must create their own `.env` file with credentials and URLs.

---

## Prerequisites

* Docker installed and running
* Optional: DBeaver or `psql` to inspect the database
* Internet access to download the source CSV

---

## Setup Instructions

### 1. Prepare Environment Variables

1. Copy `.env` to `.env`.
2. Edit `.env` to include your database credentials and the URL for your data source.
3. Make sure `.env` is **not pushed to GitHub** for security.

---

### 2. Build and Run Containers

Use the provided script `dockervar.sh` to automate the process:

```bash
cd docker/
chmod +x dockervar.sh
./docker_var.sh
```

This script will:

1. Stop and remove any existing containers/images for this project.
2. Remove any existing custom network.
3. Create a Docker network for container communication.
4. Build the ETL Docker image.
5. Run a PostgreSQL container.
6. Run the ETL pipeline container connected to the network.

---

### 3. Verify Containers

```bash
docker ps
```

You should see:

```
CONTAINER ID   IMAGE          NAMES
xxxxxxx        postgres       postgres_cont
xxxxxxx        etl_pipeline   elt_cont
```

---

### 4. Check ETL Logs

```bash
docker logs elt_cont
```

You should see messages indicating the ETL pipeline is running:

```
Getting Postgres ready...
Speaking to the source
Finished transformation
Loading data into PostgreSQL
```

---

### 5. Connect to the PostgreSQL Database

You can connect from your host machine:

* **Using psql:**

```bash
psql -h localhost -p 5432 -U your-username -d your-database
```

* **Using DBeaver:**

1. Create a new PostgreSQL connection.
2. Host: `localhost`
3. Port: `55432`
4. Database: `your-database`
5. Username: `your-username`
6. Password: `your-password`

---

### 6. Running ETL Manually

If you want to manually run the ETL pipeline inside the container:

```bash
docker exec -it elt_cont bash
python3 run_pipeline.py
```

---

### 7. Dockerfile Explanation

```dockerfile
FROM python:3.12

WORKDIR /app

COPY requirements.txt extract.py transform.py load.py run_pipeline.py ./

RUN pip install -r requirements.txt

CMD ["python3", "run_pipeline.py"]
```

* Uses Python 3.12 image
* Copies all project files into `/app`
* Installs dependencies
* Runs the ETL pipeline when the container starts

---

### Notes

* The ETL container depends on the PostgreSQL container. Make sure Postgres is up before ETL runs.
* `.env` contains sensitive credentials and **should not** be committed.
* Containers communicate over a custom Docker network created in the script.
* Host port `55432` is mapped to the PostgreSQL container for external access.

