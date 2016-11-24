#!/bin/bash
# Install MongoDB
echo "Installing MongoDB"
brew update
brew install mongodb

# Create cluster structure
echo "Creating three folders for the three instances of the cluster"
mkdir -p ~/srv/mongodb/rs0-0 ~/srv/mongodb/rs0-1 ~/srv/mongodb/rs0-2

# Start three instances
echo "Starting up three instances of MongoDB in ports 27020, 27018 and 27019"
osascript -e 'tell app "Terminal"
	do script "mongod --port 27020 --dbpath ~/srv/mongodb/rs0-0 --replSet rs0 --smallfiles --oplogSize 128"
	end tell'
osascript -e 'tell app "Terminal"
	do script "mongod --port 27018 --dbpath ~/srv/mongodb/rs0-1 --replSet rs0 --smallfiles --oplogSize 128"
	end tell'
osascript -e 'tell app "Terminal"
	do script "mongod --port 27019 --dbpath ~/srv/mongodb/rs0-2 --replSet rs0 --smallfiles --oplogSize 128"
	end tell'

# Pause 2 seconds
echo "Pause 2 seconds to allow the servers to start"
sleep 2

# Start Mongo Shell on port 27020 and execute script to create replica set
echo "Creating replicaSet using MongoDB Shell"
mongo --port 27020  < ./createReplicaSet.js 

echo "Installation finished. You can connect the cluster with this connection string:"
echo "mongodb://127.0.0.1:27020,127.0.0.1:27018,127.0.0.1:27019/?replicaSet=rs0"
exit