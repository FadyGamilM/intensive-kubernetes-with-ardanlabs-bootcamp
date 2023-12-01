KIND_CLUSTER := intensive-k8s

CLUSTER_NAMESPACE := intensive-k8s-namespace 

cluster-up:
	kind create cluster --image kindest/node:v1.21.1@sha256:69860bda5563ac81e3c0057d654b5253219618a22ec3a346306239bba8cfa1a6 --name $(KIND_CLUSTER) --config infra/k8s/kind-config.yaml
	kubectl create namespace $(CLUSTER_NAMESPACE)
	kubectl config set-context --current --namespace=$(CLUSTER_NAMESPACE)

cluster-down:
	kind delete cluster --name $(KIND_CLUSTER)

create-depl:
# the -- separtes between the kubectl commands [before it] and shell command running within the container [after it]
	kubectl create deployment pingpong --image=alpine -- ping localhost

scale:
	kubectl scale deployment pingpong --replicas 3