FROM python:3.12

WORKDIR /app

# RUN apt update && apt install -y python3 python3-pip build-essential libpq-dev

COPY requirements.txt extract.py transform.py load.py run_pipeline.py ./

RUN pip install -r requirements.txt

# RUN chmod +x export_var.sh

CMD ["python3", "run_pipeline.py"]


