
GRAFANA_VERSION=7.3.5

DOCKER_IMAGE_NAME=dashboards-builder
DOCKER_CONTAINER_NAME=dashboards-builder

DOCKER_PREVIEW_FLAGS += run
DOCKER_PREVIEW_FLAGS += --volume "$(shell pwd)/built:/var/lib/grafana/dashboards"
DOCKER_PREVIEW_FLAGS += --volume "$(shell pwd)/config/grafana/datasources:/etc/grafana/provisioning/datasources"
DOCKER_PREVIEW_FLAGS += --volume "$(shell pwd)/config/grafana/dashboards:/etc/grafana/provisioning/dashboards"
DOCKER_PREVIEW_FLAGS += -e GF_AUTH_ANONYMOUS_ENABLED=true
DOCKER_PREVIEW_FLAGS += -e GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
DOCKER_PREVIEW_FLAGS += -p 3000:3000
DOCKER_PREVIEW_FLAGS += grafana/grafana:$(GRAFANA_VERSION)

# grafana_preview - launches an instance of grafana that automatially deploys the dashboards in the ./built folder
.PHONY: grafana_preview
grafana_preview:
	docker $(DOCKER_PREVIEW_FLAGS)

# docker_build - builds the a docker container containing grafanalib
.PHONY: docker_build
docker_build: docker_clean
	docker build -f builder.Dockerfile \
		--tag "${DOCKER_IMAGE_NAME}" .

# docker_clean - removes any docker objects
.PHONY: docker_clean
docker_clean:
	docker rm "${DOCKER_CONTAINER_NAME}" || true
	docker rmi "${DOCKER_IMAGE_NAME}" || true

