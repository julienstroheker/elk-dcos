#!/bin/bash

# DCOS environment

#-----------------------# PREPARING SECTION #-----------------------#
sed -i 's/!ELASTICNAME!/'${ELASTIC_NAME}'/g' ./infrastructure/elasticdeploy.json
sed -i 's/!ELASTICEXECUTORNAME!/'${ELASTIC_EXECUTOR_NAME}'/g' ./infrastructure/elasticdeploy.json

sed -i 's/!ELASTICNAME!/'${ELASTIC_NAME}'/g' ./infrastructure/logstashdeploy.json
sed -i 's/!ELASTICEXECUTORNAME!/'${ELASTIC_EXECUTOR_NAME}'/g' ./infrastructure/logstashdeploy.json
sed -i 's/!LOGSTASHNAME!/'${LOGSTASH_NAME}'/g' ./infrastructure/logstashdeploy.json

sed -i 's/!ELASTICNAME!/'${ELASTIC_NAME}'/g' ./infrastructure/kibanadeploy.json
sed -i 's/!ELASTICEXECUTORNAME!/'${ELASTIC_EXECUTOR_NAME}'/g' ./infrastructure/kibanadeploy.json
sed -i 's/!KIBANANAME!/'${KIBANA_NAME}'/g' ./infrastructure/kibanadeploy.json
sed -i 's/!KIBANAFQDN!/'${KIBANA_FQDN}'/g' ./infrastructure/kibanadeploy.json

curl http://leader.mesos:1050/system/health/v1/nodes | jq '.nodes[].host_ip' | sed 's/\"//g' | sed '/172/d' > nodes.txt