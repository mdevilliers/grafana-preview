grafana-preview
---------------

Grafana preview allows you to interate dashboard development locally on top of your production observability
data (logs, traces, metrics).

### To use - 

Port forward to the following services 

| Service       | Local port    | Notes   |
| ------------- | ------------- | ------- |
| Prometheus    | 0.0.0.0:9000  | Default |
| Loki          | 0.0.0.0:3100  |         |
| Jaeger        | 0.0.0.0:16686 |         |


```
make grafana_preview # creates an instance of Grafana in docker
```

Launch 0.0.0.0:3000


### To use https://github.com/weaveworks/grafanalib

Create a 'dashboards' folder.
Create a dashboard.
Edit the CMD in builder.Dockerfile

Make the builder docker image 

```
make docker_build
```

Make the dashboards 

```
make build_dashboards
```

Launch a grafana instance

```
make grafana_preview
```

View your dashboards.
