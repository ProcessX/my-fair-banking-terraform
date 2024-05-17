#! /bin/bash
sudo apt-get update
sudo apt -y install git-all
sudo chmod 600 /home/azureuser/.ssh/id_rsa
echo ${ssh_key} > /home/azureuser/.ssh/id_rsa
sudo apt -y install ansible
sudo chmod -R 700 /home/azureuser/.ansible
sudo chown -R azureuser:azureuser /home/azureuser/.ansible