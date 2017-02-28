#### Not tested yet #####

curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.2.1-amd64.deb
sudo dpkg -i metricbeat-5.2.1-amd64.deb

sudo mv /etc/metricbeat/metricbeat.yml /etc/metricbeat/metricbeat.yml.BAK

sudo tee /etc/metricbeat/metricbeat.yml <<-EOF 
metricbeat.modules:
- module: system
  metricsets:
    - cpu
    - filesystem
    - memory
    - network
    - process
  enabled: true
  period: 10s
  processes: ['.*']
  cpu_ticks: false
metricbeat.modules:
- module: docker
  metricsets: ["cpu", "info", "memory", "network", "diskio", "container"]
  hosts: ["unix:///var/run/docker.sock"]
  enabled: true
  period: 10s
output.logstash:
   hosts: ["!LOGSTASHNAME!.marathon.mesos:10514"] 
EOF

#curl -XPUT 'http://!ELASTICEXECUTORNAME!.!ELASTICNAME!.mesos:1025/_template/metricbeat' -d@/etc/metricbeat/metricbeat.template.json

sudo /etc/init.d/metricbeat start

#/usr/share/metricbeat/scripts/import_dashboards -es http://elasticsearch-executor.elasticsearch.mesos:1025