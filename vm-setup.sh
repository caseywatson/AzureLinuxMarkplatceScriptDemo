#! /bin/bash -e

echo "Installing pre-requisites..."

sudo apt-get install curl
sudo apt-get install jq

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "Pre-requisites installed."
read -p "Press [Enter] to continue..."

echo "Demo 1 | Login to Azure..."

az login

read -p "Press [Enter] to continue..."
echo "Showing AAD user metadata..."

az ad signed-in-user show

read -p "Press [Enter] to continue..."
echo "Demo 2 | Accessing instance metadata..."

curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01"

read -p "Press [Enter] to continue..."
