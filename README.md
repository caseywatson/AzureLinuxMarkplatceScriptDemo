> Code is as-is, no warranties. Not intended for production usage. See license information for more details.

This script can be used as part of an Azure Marketplace Linux-based VM offer to complete appliance/VM setup using...

* [Azure Active Directory](https://azure.microsoft.com/en-us/services/active-directory/) to authenticate the purchaser and allow the script to make necessary changes to the surrounding Azure resource group/subscription.
* [Azure's Instance Metadata Service (IMDS)](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/instance-metadata-service?tabs=linux) to obtain contextual information about a VM running in Azure. This information can be used among other things to determine the subscription and resource group in which the VM has been deployed as well as OS, disk, and networking details.
* The [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) to interrogate and make changes to the surrounding Azure environment.


