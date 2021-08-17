# DevOps course diploma task
Prerequisites: docker, docker compose, terraform, kubectl

To start project you should login to Azure first (with 'az login --use-device-code' or likewise)!!!

~/.ssh/id_rsa.pub must exist

# To get all jobs done:
./start-all prod
(look for project's URL in output)

# To destroy all:
./stop-all prod

# Some details
## Infrastructure (created by Terraform):
DB - Azure MySQL
Registry - ACR
K8s - Azure k8s cluster
Azure files as volume for dev environment
./terrafrom apply to deploy infrastructure

## Backend - NGINX+PHP REST API (dockerized)
to setup backend parameters edit:
 ./backend/.env-(dev|prod)
 ./backend/api/config/settings.(dev|prod)

./backend/build-back dev|prod to create local containers
./backend/start-back dev|prod to create and run local containers
./backend/cloud-back-push dev|prod to push docker images to cloud registry
./backend/upload-back to upload sources to Azure file share for pod mounts
./backend/stop-back dev|prod to stop and remove local containers

## Frontend - HTML+JQuery (dockerized) - use frontend/build-front dev|prod to create containers
to setup frontend parameters edit:
 ./frontend/.env-(dev|prod)
 ./frontend/app_js/config/settings.js-(dev|prod) 

./frontend/build-front dev|prod to create local container
./frontend/start-front dev|prod to create and run local containers
./frontend/cloud-front-push dev|prod to push docker image to cloud registry
./frontend/upload-front to upload sources to Azure file share for pod mounts
./frontend/stop-front dev|prod to stop and remove local container

## Azure k8s setup - 
./k8s/k8env to get environment for kubectl from Terraform
./k8s/k8secret to create k8s secret to mount Azure file share as volumes for dev environment
./k8start dev|prod to deploy dev application

# Templates used when creating application:
## backend: https://only-to-top.ru/blog/programming/2019-11-06-rest-api-php.html
## frontend: https://only-to-top.ru/blog/programming/2019-11-11-jquery-ajax-json-php.html
# Author: Aleksei Smirnov
