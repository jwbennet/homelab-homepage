.PHONY: image
image: ## Create Docker image containing the website
	@docker buildx build --platform linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8 -t jwbennet/homelab-homepage:latest . --build-arg TIMESTAMP=$(date --iso-8601=seconds) --push

.PHONY: test
test: ## Test built Docker image
	@docker container run -ti --rm -p 8080:80 docker.io/jwbennet/homelab-homepage:latest

.PHONY: deploy
deploy: ## Deploy Kubernetes assets
	@kubectl apply -f k8s/deployment.yaml
	@kubectl apply -f k8s/service.yaml
	@kubectl apply -f k8s/ingress.yaml

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
