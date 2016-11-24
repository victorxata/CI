#!/bin/bash
# Install MongoDB
echo "Installing MongoDB"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Create cluster structure
echo "Creating three folders for the three instances of the cluster"
sudo mkdir -p /srv/mongodb/rs0-0 /srv/mongodb/rs0-1 /srv/mongodb/rs0-2

# Start three instances
echo "Starting up three instances of MongoDB in ports 27020, 27018 and 27019"
gnome-terminal -e "sudo mongod --port 27020 --dbpath /srv/mongodb/rs0-0 --replSet rs0 --smallfiles --oplogSize 128"
gnome-terminal -e "sudo mongod --port 27018 --dbpath /srv/mongodb/rs0-1 --replSet rs0 --smallfiles --oplogSize 128"
gnome-terminal -e "sudo mongod --port 27019 --dbpath /srv/mongodb/rs0-2 --replSet rs0 --smallfiles --oplogSize 128"

# Pause 2 seconds
echo "Pause 2 seconds to allow the servers to start"
sleep 2

# Start Mongo Shell on port 27020 and execute script to create replica set
mongo --port 27020  < ./createReplicaSet.js 

echo "Installation finished. You can connect the cluster with this connection string:"
echo "mongodb://127.0.0.1:27020,127.0.0.1:27018,127.0.0.1:27019/?replicaSet=rs0"
exit