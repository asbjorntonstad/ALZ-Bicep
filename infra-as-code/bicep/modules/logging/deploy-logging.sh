#!/bin/bash

TEMPLATEFILE="logging.bicep"
PARAMETERS="@parameters/logging.parameters.all.json"

ManagementSubscriptionId="43bbe08b-b297-4da1-a7e2-197f446c1e95"
az account set --subscription $ManagementSubscriptionId

TopLevelMGPrefix="F13"
dateYMD=$(date +%Y%m%dT%H%M%S%NZ)
GROUP="rg-$TopLevelMGPrefix-logging-001"
NAME="alz-loggingDeployment-${dateYMD}"
TEMPLATEFILE="infra-as-code/bicep/modules/logging/logging.bicep"
PARAMETERS="@infra-as-code/bicep/modules/logging/parameters/logging.parameters.all.json"

az group create --name $GROUP --location eastus

az deployment group create --name ${NAME:0:63} --resource-group $GROUP --template-file $TEMPLATEFILE --parameters $PARAMETERS
