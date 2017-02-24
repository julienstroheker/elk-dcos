#!/bin/bash

ssh-add ./yourKeys/privateKey
# Will be prompted for you passphrase

sudo apt-get install jq -y
curl http://leader.mesos:1050/system/health/v1/nodes | jq '.nodes[].host_ip' | sed 's/\"//g' | sed '/172/d' > nodes.txt

cat nodes.txt | while read line
do
   ssh Julien@$line 'sudo bash -s' -o StrictHostKeyChecking=no -i ./yourKeys/privateKey < ./deployFilebeatNodes.sh
done