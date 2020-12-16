FROM python:3.9.0-buster as builder

RUN pip install grafanalib

CMD ["generate-dashboard"]
