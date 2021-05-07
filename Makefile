
GRAFANA_VERSION=7.3.5

DOCKER_IMAGE_NAME=dashboards-builder
DOCKER_CONTAINER_NAME=dashboards-builder

DOCKER_PYTHON_LINT += run
DOCKER_PYTHON_LINT += --volume $(shell pwd):/code
DOCKER_PYTHON_LINT += mvantellingen/python-lint:latest
DOCKER_PYTHON_LINT += flake8
DOCKER_PYTHON_LINT += --ignore=E501 # ignore line too long E501
DOCKER_PYTHON_LINT += src/

.PHONY: lint-python
lint-python:
	docker $(DOCKER_PYTHON_LINT)

DOCKER_PREVIEW_FLAGS += run
DOCKER_PREVIEW_FLAGS += --volume "$(shell pwd)/built:/var/lib/grafana/dashboards"
DOCKER_PREVIEW_FLAGS += --volume "$(shell pwd)/config/grafana/datasources:/etc/grafana/provisioning/datasources"
DOCKER_PREVIEW_FLAGS += --volume "$(shell pwd)/config/grafana/dashboards:/etc/grafana/provisioning/dashboards"
DOCKER_PREVIEW_FLAGS += -e GF_AUTH_ANONYMOUS_ENABLED=true
DOCKER_PREVIEW_FLAGS += -e GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
DOCKER_PREVIEW_FLAGS += -p 3000:3000
DOCKER_PREVIEW_FLAGS += --rm
DOCKER_PREVIEW_FLAGS += grafana/grafana:$(GRAFANA_VERSION)

# grafana_preview - launches an instance of grafana that automatially deploys the dashboards in the ./built folder
.PHONY: grafana_preview
grafana_preview:
	docker $(DOCKER_PREVIEW_FLAGS)

DOCKER_BUILD_DASHBOARDS_FLAGS += run
DOCKER_BUILD_DASHBOARDS_FLAGS += --rm
DOCKER_BUILD_DASHBOARDS_FLAGS += --volume "$(shell pwd):/dashboards"
DOCKER_BUILD_DASHBOARDS_FLAGS += $(DOCKER_IMAGE_NAME)

# build_dashboards mounts the current folder and builds the
# dashboards to the ./built folder
.PHONY: build_dashboards
build_dashboards:
	docker $(DOCKER_BUILD_DASHBOARDS_FLAGS)

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

