# DevOps course diploma task
Prerequisites: docker, docker compose, terraform, kubectl

To start project you should login to Azure first (with 'az login --use-device-code' or likewise)!!!

~/.ssh/id_rsa.pub must exist

# To get jobs done:
 ./start-all prod
 (look for project's URL in output)

# To destroy all:
 ./stop-all prod

# Some details:
 DB - Azure MySQL
 Cloud infrastructure deployment - Terraform
        use ./terrafrom apply to deploy cloud DB, cloud docker registry and k8s cluster with registry access
## backend - NGINX+PHP REST API (dockerized)
        edit ./backend/.env-(dev|prod)
             ./backend/api/config/settings.(dev|prod)
           to setup backend parameters
        use ./backend/build-back dev|prod to create containers
        use ./backend/start-back dev|prod to create and run local containers
	 use ./backend/cloud-back-push dev|prod to push docker images to cloud registry
	 use ./backend/stop-back dev|prod to stop and remove local containers

## frontend - HTML+JQuery (dockerized) - use frontend/build-front dev|prod to create containers
        edit ./frontend/.env-(dev|prod)
             ./frontend/app_js/config/settings.js-(dev|prod) 
           to setup frontend parameters
        use ./backend/build-back dev|prod to create local containers
        use ./backend/start-back dev|prod to create and run local containers
	 use ./frontend/cloud-front-push dev|prod to push docker image to cloud registry
	 use ./frontend/stop-front dev|prod to stop and remove local containers

## Azure k8s setup - 
        use ./k8s/k8env to setup environment for kubectl
	 use kubectl apply -f frontend.yaml to create frontends's pods
	 use kubectl apply -f backend.yaml to create backend's pods
	 use kubectl apply -f ingress.yaml to configure cluster ingress router

# Templates used:
 backend: https://only-to-top.ru/blog/programming/2019-11-06-rest-api-php.html
 frontend: https://only-to-top.ru/blog/programming/2019-11-11-jquery-ajax-json-php.html
# Aleksei Smirnov
