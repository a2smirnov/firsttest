# Azure k8s cluster setup
# Step-by-step (could be depricated):
 run ./k8env to get credentials first
 export KUBECONFIG=./azurek8s
 then kubectl apply -f frontend.yaml to create frontend pods
      kubectl apply -f backend.yaml to create backend pods
# One script start|stop (whole config in app.yaml):
 k8start
 k8stop
# Aleksei Smirnov