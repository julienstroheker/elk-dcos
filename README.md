# elk-dcos
Monitor your DCOS Cluster using Elastic search Logstash Kibana and Filebeat

This project have for main goal to document and automate the deployment of the ELK stack on a DCOS cluster.

When deployed, you should be able to see all the logs from your cluster (Master + Nodes) on Kibana

Project under development, tested and coded for Azure ACS

## Prerequisites

* OS = Ubuntu


## How-to
1. Clone this repo on the Master
2. Copy your private key inside the folder deploy/yourKey
3. Verify or replace the value inside the deploy.sh file
4. Deploy Marathon-lb from the universe
5. Execute deploy.sh from the infrastructure directory
6. Execute copyPrerequisitesNodes.sh from the filebeat directory


