#!/bin/bash
############## PARAMETERS #########################
ELASTIC_NAME=elastic
ELASTIC_EXECUTOR_NAME=elasticsearch-executor
LOGSTASH_NAME=logstash
KIBANA_NAME=kibana
PRIVATE_KEY_NAME=TOFILL
############## PARAMETERS #########################

sed -i 's/!ELASTICNAME!/'${ELASTIC_NAME}'/g' elasticdeploy.json
sed -i 's/!ELASTICEXECUTORNAME!/'${ELASTIC_EXECUTOR_NAME}'/g' elasticdeploy.json

sed -i 's/!ELASTICNAME!/'${ELASTIC_NAME}'/g' logstashdeploy.json
sed -i 's/!ELASTICEXECUTORNAME!/'${ELASTIC_EXECUTOR_NAME}'/g' logstashdeploy.json
sed -i 's/!LOGSTASHNAME!/'${LOGSTASH_NAME}'/g' logstashdeploy.json
sed -i 's/!LOGSTASHNAME!/'${LOGSTASH_NAME}'/g' ../filebeat/deployFilebeatNodes.sh

sed -i 's/!ELASTICNAME!/'${ELASTIC_NAME}'/g' kibanadeploy.json
sed -i 's/!ELASTICEXECUTORNAME!/'${ELASTIC_EXECUTOR_NAME}'/g' kibanadeploy.json
sed -i 's/!KIBANANAME!/'${KIBANA_NAME}'/g' kibanadeploy.json

sed -i 's/!PRIVATEKEYNAME!/'${PRIVATE_KEY_NAME}'/g' ../filebeat/copyPrerequisitesNodes.sh

curl -X POST --data-binary @elasticdeploy.json http://marathon.mesos:8080/v2/apps --header "Content-Type:application/json"
sleep 5
curl -X POST --data-binary @logstashdeploy.json http://marathon.mesos:8080/v2/apps --header "Content-Type:application/json"
sleep 5
curl -X POST --data-binary @kibanadeploy.json http://marathon.mesos:8080/v2/apps --header "Content-Type:application/json"