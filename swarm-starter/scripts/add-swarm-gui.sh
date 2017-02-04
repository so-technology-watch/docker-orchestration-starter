#!/bin/bash

echo 'Add Swarm GUI (visualization tool)'
echo '##################################'
runVisualizationToolCommand="docker run -it -d -p 5000:8080 -v /var/run/docker.sock:/var/run/docker.sock --restart=unless-stopped  julienbreux/docker-swarm-gui:latest"
if [ "$OSTYPE" == "msys" ]; then
    # Pass by ssh. Too compatibility problems with the docker client on Windows (volumes, warning messages ...)
    echo '!! Windows detected !! -> Execute command by ssh'
    docker-machine ssh leader1 "$runVisualizationToolCommand"
else
    eval "$(docker-machine env leader1)"
    $runVisualizationToolCommand
fi