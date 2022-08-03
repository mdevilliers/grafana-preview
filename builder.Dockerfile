FROM python:3.10.0-buster as builder

RUN pip install --upgrade pip
RUN pip install 'grafanalib==0.6.3' 'pyyaml'
WORKDIR /dashboards

CMD ["python", "todo"]
