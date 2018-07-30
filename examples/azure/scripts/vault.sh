#!/bin/bash

#Get our TF ouputs
cd ../terraform
VAULT_TENANT_ID=$(terraform output vault_tenant_id)
VAULT_RESOURCE_URI=$(terraform output vault_identifier_uri)
VAULT_CLIENT_ID=$(terraform output vault_client_id)
VAULT_SECRET_ID=$(terraform output vault_client_secret)
ORDER_PRINCIPAL_ID=$(terraform output order_principal_id)
cd ../scripts

#Auth method
vault auth enable azure

#Vault config
vault write auth/azure/config tenant_id="${VAULT_TENANT_ID}" \
    resource="${VAULT_RESOURCE_URI}" \
    client_id="${VAULT_CLIENT_ID}" \
    client_secret="${VAULT_SECRET_ID}"

#Go role
vault write auth/azure/role/order \
    policies=order \
    bound_service_principal_ids="${ORDER_PRINCIPAL_ID}"
