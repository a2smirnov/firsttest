# Azure k8s cluster setup
# Step-by-step deloying (could be depricated):
run ./k8env to get credentials first
export KUBECONFIG=./azurek8s
# One script start|stop (whole config in app.yaml):
k8start
k8stop
# To check cluster status:
    echo "$(terraform output -raw kube_config)" > ./azurek8s
    export KUBECONFIG=./azurek8s
    kubectl get nodes
    kubectl get all --all-namespaces 