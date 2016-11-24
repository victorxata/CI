REM Create cluster structure 
echo Creating folder structure
md c:\mongodbSrv
md c:\mongodbSrv\mongodb 
md c:\mongodbSrv\mongodb\rs0-0
md c:\mongodbSrv\mongodb\rs0-1
md c:\mongodbSrv\mongodb\rs0-2

REM Start three instances 
echo Starting three instances of MongoDB
start cmd /c C:\mongodb\bin\mongod --port 27020 --dbpath c:\mongodbSrv\mongodb\rs0-0 --replSet rs0 --smallfiles --oplogSize 128
start cmd /c C:\mongodb\bin\mongod --port 27018 --dbpath c:\mongodbSrv\mongodb\rs0-1 --replSet rs0 --smallfiles --oplogSize 128
start cmd /c C:\mongodb\bin\mongod --port 27019 --dbpath c:\mongodbSrv\mongodb\rs0-2 --replSet rs0 --smallfiles --oplogSize 128

REM Pause 2 seconds
echo Pause 2 seconds to allow the servers to start
timeout /t 2

REM Start Mongo Shell on port 27020 and execute script to create replica set
echo Creating replicaSet using MongoDB Shell 
start cmd /c c:\mongodb\bin\mongo --port 27020 createReplicaSet.js

REM Installation finished
echo Installation finished. You can connect the cluster with this connection string:
echo mongodb://127.0.0.1:27020,127.0.0.1:27018,127.0.0.1:27019/?replicaSet=rs0
