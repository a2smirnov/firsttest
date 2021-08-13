#Infrastructrue must by deployed via terraform first (DB credentials taken from terraform output)!
## Building backend
./build-back dev|prod - bulds containers
./start-back dev|prod - builds containers and starts them
./stop-back dev|prod - stops and deletes containers
## Pushing images to Azure registry
./cloud-back-push dev|prod - pushes backend containers to ACR