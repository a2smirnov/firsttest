# terraform
# AZURE MySQL server and database creation using variables, output, terraform.tfvars
# Server have public access limited to two specific address
# DB credentials used by docker to build backend
#
# Azure docker repository creation
#
# Azure k8s cluster creation (with access to repository)
#
# To check status:
#    echo "$(terraform output -raw kube_config)" > ./azurek8s
#    export KUBECONFIG=./azurek8s
#    kubectl get nodes
#    kubectl get all --all-namespaces
#
# Aleksei Smirnov