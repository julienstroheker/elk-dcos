#!/bin/bash
#-----------------------# PARAMETERS SECTION #-----------------------#
####################### DEFAULT PARAMETERS #######################
ELASTIC_NAME=elasticsearch
ELASTIC_EXECUTOR_NAME=elasticsearch-executor
LOGSTASH_NAME=logstash
KIBANA_NAME=kibana
####################### MANDATORIES PARAMETERS #######################
KIBANA_FQDN=YOURPUBLICFQDN
SSH_PRIVATE_KEY_NAME=NAMEYOURPRIVATEKEY
SSH_USER=YOURSSHUSER
#-----------------------# PARAMETERS SECTION #-----------------------#
sudo apt-get install jq -y

### TODO : Determine the infrastructure : DCOS / K8s / Swarm / OS ..
### TODO : For now tested and forced on DCOS

sh ./dcos/prepareEnvDCOS.sh

#-----------------------# PREPARING SECTION #-----------------------#

sed -i 's/!LOGSTASHNAME!/'${LOGSTASH_NAME}'/g' ./filebeat/scriptDeployFB.sh

sed -i 's/!PRIVATEKEYNAME!/'${SSH_PRIVATE_KEY_NAME}'/g' ./filebeat/deployFB.sh
sed -i 's/!SSHUSER!/'${SSH_USER}'/g' ./filebeat/deployFB.sh

sed -i 's/!LOGSTASHNAME!/'${LOGSTASH_NAME}'/g' ./metricbeat/scriptDeployMB.sh

sed -i 's/!PRIVATEKEYNAME!/'${SSH_PRIVATE_KEY_NAME}'/g' ./metricbeat/deployMB.sh
sed -i 's/!SSHUSER!/'${SSH_USER}'/g' ./metricbeat/deployMB.sh

### TODO : Check if the private key has been dl in the folder
rm ./yourKey/PLACEyourKEYhere
#-----------------------# PREPARING SECTION #-----------------------#


echo "Deploying Infrastructure"
sh ./dcos/infrastructure/deployInfrastructure.sh
echo "Deploying FileBeat on all nodes"
sh ./filebeat/deployFB.sh
echo "Deploying MetricBeat on all nodes"
sh ./metricbeat/deployMB.sh