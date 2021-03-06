# Starter to launch a Swarm cluster

![badge](https://img.shields.io/badge/Ready%20to%20use%20%3F%20-In%20progress-red.svg)

> **Objectif :** Create and run 3 servers (leader, worker1 and worker2) configured and declared on a swarm cluster

## Prerequisites
1. Docker ecosystem tools (1.13 or later)
  * docker engine
  * docker machine
2. VirtualBox
3. GUI Bash if you are on Windows

> **For Windows : Install the latest version of Docker ToolBox**

## Create and run the Swarm Cluster

```bash
chmod +x init-swarm-cluster.sh
```
```bash
./init-swarm-cluster.sh
```

## Some Checks

* List the 3 virtual servers
```bash
docker-machine ls
```
> **Note :** Normally, your client docker client is plug on the `leader1` (see the * under the ACTIVE column)
> So all docker command are executed on the `leader1` instance

* List the configuration of the Swarm
```bash
docker-machine ssh leader1 #Only if you are on Windows
docker node list
```
The three instances must be in a ACTIVE state


## Use the Visualization UI

See the result on : http://{leader1_ip}:5000/

## Deploy a service

* Lauch a test service
```bash
docker service create --replicas 1 --constraint node.role!=manager --name helloworld alpine ping docker.com
```
This command will create a service from the alpine image :
* Just one instance
* Anywhere on the cluster but not on the manager node (here: worker1 or worker2)
* On started, the container will launch the `ping docker.com` command

* See all service declared on your cluster
```bash
docker service list
```

* See how containers have been deployed on the different servers
```bash
docker service ps helloworld
```

* Scale the service, and watch again the configuration
```bash
docker service scale helloworld=10
docker service list # see the REPLICATS column
docker service ps helloworld # Never a instance are deployed on the leader1 server
```

## Delete the service
```bash
docker service rm helloworld
```
