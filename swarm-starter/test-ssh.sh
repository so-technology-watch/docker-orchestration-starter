#!/bin/bash

leaderIp=$(docker-machine ip leader1)

tput bold; tput setaf 2; echo "To see your swarm, go to : http://$leaderIp:5000/"
tput sgr0
echo "Done !"
