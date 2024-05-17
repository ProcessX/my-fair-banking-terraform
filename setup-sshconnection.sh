#! /bin/bash
sudo apt-get update
sudo apt -y install git-all


echo ${ssh_key} >> ~/.ssh/authorized_keys
chmod -R go= ~/.ssh
chown -R azureuser:azureuser ~/.ssh