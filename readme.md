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

