IMAGE_NAME := grovemountain/consul-envoy
VERSION := 1.6.0-beta3-v1.11.0

BUILD_ID := $(shell git rev-parse --short HEAD 2>/dev/null || echo no-commit-id)
.DEFAULT_GOAL := help
help: ## List targets & descriptions
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build docker image
	docker build -t $(IMAGE_NAME):$(VERSION) .
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):$(VERSION)
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest

push: ## docker push the service images tagged 'latest' & 'BUILD_ID'
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest

run: ## run docker image locally
	docker run -it $(IMAGE_NAME):$(VERSION)

clean: ## Remove the current image version
	docker image rm $(IMAGE_NAME):latest
	docker image rm $(IMAGE_NAME):$(VERSION)
