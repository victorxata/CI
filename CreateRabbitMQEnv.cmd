@echo off
@echo # First parameter username       %1
@echo # Second parameter password      %2
@echo # Third parameter RabbitMQ URL   %3
@echo # Fourth parameter vhost         %4
@echo # Fifth parameter exchange       %5
@echo # Sixth parameter queue          %6
@echo .
@echo .
@echo  Create Virtual Host
curl -i -u %1:%2 -H "content-type:application/json" -XPUT %3/api/vhosts/%4
@echo  Add permissions for a user in a Virtual Hosts
curl -i -u %1:%2 -H "content-type:application/json" -XPUT -d"{""configure"":"".*"",""write"":"".*"",""read"":"".*""}" %3/api/permissions/%4/%1
@echo  Create Exchange
curl -i -u %1:%2 -H "content-type:application/json" -XPUT -d"{""type"":""direct"",""durable"":true}" %3/api/exchanges/%4/%5
@echo  Create new Queue
curl -i -u %1:%2 -H "content-type:application/json" -XPUT -d"{""type"":""direct"",""durable"":true}" %3/api/queues/%4/%6
@echo  Associate Exchange with Queue (Binding)
curl -i -u %1:%2 -H "content-type:application/json" -XPOST %3/api/bindings/%4/e/%5/q/%6
