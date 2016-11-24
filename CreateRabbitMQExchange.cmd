REM Create Virtual Host
curl -i -u guest:guest -H "content-type:application/json" -XPUT http://localhost:15672/api/vhosts/foo

REM Delete Virtual Host
curl -i -u guest:guest -H "content-type:application/json" -XDELETE http://localhost:15672/api/vhosts/foo

REM Get all Virtual Hosts
curl -i -u guest:guest -H "content-type:application/json" -XGET http://localhost:15672/api/vhosts

REM Add permissions for a user in a Virtual Hosts
curl -i -u guest:guest -H "content-type:application/json" -XPUT -d"{""configure"":"".*"",""write"":"".*"",""read"":"".*""}" http://localhost:15672/api/permissions/foo/guest

REM Create Exchange
curl -i -u guest:guest -H "content-type:application/json" -XPUT -d"{""type"":""direct"",""durable"":true}" http://localhost:15672/api/exchanges/foo/vz.testExchange

REM Delete Exchange
curl -i -u guest:guest -H "content-type:application/json" -XDELETE http://localhost:15672/api/exchanges/foo/vz.testExchange

REM Create new Queue
curl -i -u guest:guest -H "content-type:application/json" -XPUT -d"{""type"":""direct"",""durable"":true}" http://localhost:15672/api/queues/foo/vz.testqueue

REM Get all Queues
curl -i -u guest:guest -H "content-type:application/json" -XGET http://localhost:15672/api/queues
curl -i -u guest:guest -H "content-type:application/json" -XGET http://localhost:15672/api/foo/queues

REM Associate Exchange with Queue (Binding)
curl -i -u guest:guest -H "content-type:application/json" -XPUT http://localhost:15672/api/bindings/foo/e/vz.testExchange/q/vz.testQueue

REM Get all Bindings
curl -i -u guest:guest -H "content-type:application/json" -XGET http://localhost:15672/api/bindings
curl -i -u guest:guest -H "content-type:application/json" -XGET http://localhost:15672/api/foo/bindings


@echo off
@echo ######### Script to execute before start test return
@echo #
@echo # First parameter username       guest
@echo # Second parameter password      guest
@echo # Third parameter RabbitMQ URL   http://localhost:15672
@echo # Fourth parameter vhost         foo
@echo # Fifth parameter exchange       vhi.testExchange1
@echo # Sixth parameter queue          vhi.testQueue1


REM Create Virtual Host
curl -i -u %1:%2 -H "content-type:application/json" -XPUT %3/api/vhosts/%4
REM Add permissions for a user in a Virtual Hosts
curl -i -u %1:%2 -H "content-type:application/json" -XPUT -d"{""configure"":"".*"",""write"":"".*"",""read"":"".*""}" %3/api/permissions/%4/%1
REM Create Exchange
curl -i -u %1:%2 -H "content-type:application/json" -XPUT -d"{""type"":""direct"",""durable"":true}" %3/api/exchanges/%4/%5
REM Create new Queue
curl -i -u %1:%2 -H "content-type:application/json" -XPUT -d"{""type"":""direct"",""durable"":true}" %3/api/queues/%4/%6
REM Associate Exchange with Queue (Binding)
curl -i -u %1:%2 -H "content-type:application/json" -XPUT %3/api/bindings/%4/e/%5/q/%6


REM Example
CreateRabbitMQEnv.cmd guest guest http://localhost:15672 foo1 fooexchange1 fooqueue1
