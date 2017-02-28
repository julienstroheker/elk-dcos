#!/bin/bash

ssh-add ../yourKey/!PRIVATEKEYNAME!
# Will be prompted for you passphrase

cat nodes.txt | while read line
do
   ssh !SSHUSER!@$line -o StrictHostKeyChecking=no -i ../yourKey/!PRIVATEKEYNAME! < ./scriptDeployFB.sh
done
