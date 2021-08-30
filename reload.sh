#!/bin/bash

docker stop $(docker ps -qa) &&
docker rm $(docker ps -qa) &&
docker rmi -f $(docker images -qa) &&
docker vloume rm $(docker volume ls -q) &&
docker network rm $(docker network ls -q) 2>/dev/null

# sudo rm -rf /home/emabel/data/wp/*
# sudo rm -rf /home/emabel/data/db/*