#!/bin/bash

# Création des 3 serveurs qui va héberger nos clusters
###################################################################
bash ./scripts/create-servers.sh

# Initialisation du cluster Swarm
######################################################################""
bash ./scripts/initialize-swarm.sh

# Création du réseau
######################################################################""
bash ./scripts/create-network.sh

# Ajout de l'ihm de visualisation du cluster Swarm
######################################################################""
bash ./scripts/add-visualizer.sh