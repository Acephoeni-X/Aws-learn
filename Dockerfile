FROM python:3.14-slim

WORKDIR /app

COPY requirements.txt .

COPY app.py .

RUN python -m pip install -r requirements.txt

EXPOSE 80

ENTRYPOINT ["python", "app.py"]
