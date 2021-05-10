FROM python:3.9.0-buster as builder

RUN pip install --upgrade pip
RUN pip install 'grafanalib==0.5.10' 'pyyaml'
WORKDIR /dashboards

CMD ["python", "todo"]
