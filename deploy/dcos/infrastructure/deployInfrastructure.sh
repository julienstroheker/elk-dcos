#!/bin/bash

echo "Deploying Elastic Search"
curl -X POST --data-binary @elasticdeploy.json http://marathon.mesos:8080/v2/apps --header "Content-Type:application/json" > /dev/null
sleep 5
echo "Deploying Logstash"
curl -X POST --data-binary @logstashdeploy.json http://marathon.mesos:8080/v2/apps --header "Content-Type:application/json" > /dev/null
sleep 5
echo "Deploying Kibana"
curl -X POST --data-binary @kibanadeploy.json http://marathon.mesos:8080/v2/apps --header "Content-Type:application/json" > /dev/null
sleep 5