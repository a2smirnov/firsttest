# Azure k8s cluster setup
## Base config in ./manifests/, kustomizations - ./manifests.prod/ and ./manifests.dev/
## 'dev' uses persistent volumes from Azure file share and reduced replicas count
Run kubectl kustomize ./manifests.(dev|prod)/ to view kustomization result

# Simple kubectl connection:
run ./k8env to get credentials first

export KUBECONFIG=./azurek8s
# One script start|stop 
k8start prod|dev

k8stop prod|dev
# To check cluster status:
    echo "$(terraform output -raw kube_config)" > ./azurek8s
    export KUBECONFIG=./azurek8s
    kubectl get nodes -n prod|dev
    kubectl get all --all-namespaces
# To get url to site:
echo "Use link http://"$(kubectl -n kube-system get svc addon-http-application-routing-nginx-ingress --output jsonpath='{.status.loadBalancer.ingress[0].ip}')" to access web application"

### canary doesn't works yet )