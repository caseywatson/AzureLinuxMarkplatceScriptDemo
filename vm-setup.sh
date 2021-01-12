#!/bin/bash -e

demo() {
    echo
    echo "DEMO | $1"
    read -p "Press [Enter] to continue..."
    echo
}

usage() {
    echo "Usage: $0 [-i] [-p]";
    echo "[-i]   Skips the Azure IMDS query. Useful when not running this script on an Azure VM.";
    echo "[-p]   Skips pre-requisite installation.";
}

while getopts "pi" opt; do
    case $opt in
        p)
            skip_prereq_install="TRUE" # Saves time if we know pre-reqs are already installed...
        ;;
        i)
            skip_imds="TRUE" # Skips IMDS query when we're not running on an Azure VM...
        ;;
        \?)
            usage
            exit 1
        ;;
    esac
done

if [[ -z $skip_prereq_install ]]; then
    echo "Installing demo pre-requisites..."

    sudo apt-get install curl
    sudo apt-get install jq 

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash # Install the Azure CLI...

    echo "Demo pre-requisites installed."
fi

demo "Log in to Azure..."

# Authenticate using interactive sign-in...
# See [https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli#sign-in-interactively] for more information...

if [[ -z $(az ad signed-in-user show --query objectId 2>/dev/null) ]]; then
    az login
else
    echo "Already logged in. Proceeding to next demo..."
fi

demo "Show current user AAD metadata..."

# See [https://docs.microsoft.com/en-us/cli/azure/ad/signed-in-user?view=azure-cli-latest] for more information...

az ad signed-in-user show

if [[ -z $skip_imds ]]; then
    demo "Access Azure VM instance metadata..."

    # Access current Azure instance metadata...
    # See [https://docs.microsoft.com/en-us/azure/virtual-machines/linux/instance-metadata-service?tabs=linux] for more information...

    curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01"
    echo
fi

demo "List all resource groups..."

az group list --query '[].{Name:name, Location:location}'
echo

