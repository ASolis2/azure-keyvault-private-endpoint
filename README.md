
# Azure Key Vault with Private Endpoint Deployment

## Project Overview
This project demonstrates how to deploy an Azure Key Vault with a private endpoint using Terraform. The private endpoint restricts access to the Key Vault over a private IP address within a virtual network, enhancing security by eliminating public exposure.

## Architecture
- Azure Key Vault
- Private Endpoint
- Subnet within a Virtual Network

## Files
- `main.tf`: Defines resources including Key Vault, private endpoint, and networking components.
- `variables.tf`: Input variables for the deployment.
- `outputs.tf`: Outputs including the private endpoint IP address and Key Vault name.

## Screenshots
- **terraform-apply-success.png**: Terraform apply output showing successful resource creation.
- **terraform-output.png**: Output values showing key vault name and private endpoint IP address.
- **keyvault-list.png**: Azure CLI output listing the created Key Vault.

## Deployment Commands
1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Apply Terraform configuration:
   ```bash
   terraform apply -auto-approve
   ```

3. Verify the resources:
   ```bash
   az group list --output table
   az keyvault list --resource-group rg-keyvault-private-endpoint-001 --output table
   ```

4. Query Key Vault URI:
   ```bash
   az keyvault show --name kvsecure86071 --resource-group rg-keyvault-private-endpoint-001 --query "properties.vaultUri"
   ```

## Cleanup
To destroy the resources:
```bash
terraform destroy -auto-approve
```

## Notes
- Ensure the Azure CLI is authenticated using `az login` before deploying resources.
- The private endpoint is accessible only within the defined virtual network.

