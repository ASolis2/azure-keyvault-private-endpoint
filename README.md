
# Azure Key Vault with Private Endpoint Deployment

This Terraform project deploys an Azure Key Vault with a private endpoint within a virtual network. The deployment includes a subnet for the private endpoint and necessary networking components.

## Purpose

- Secure sensitive data using Azure Key Vault.
- Restrict network access using a private endpoint.
- Demonstrate private endpoint configuration for Key Vault.

## Architecture

- Azure Key Vault with a private endpoint.
- Subnet within a Virtual Network.

## Files

- **main.tf**: Defines resources including Key Vault, private endpoint, and networking components.
- **variables.tf**: Input variables for the deployment.
- **outputs.tf**: Outputs including the private endpoint IP address and Key Vault name.

## Screenshots

- [terraform-apply-success.png](screenshots/terraform-apply-success.png): Terraform apply output showing successful resource creation.
- [terraform-output.png](screenshots/terraform-output.png): Output values showing key vault name and private endpoint IP address.
- [keyvault-list.png](screenshots/keyvault-list.png): Azure CLI output listing the created Key Vault.

## Deployment Commands

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Validate the Configuration:**
   ```bash
   terraform validate
   ```

3. **Plan the Deployment:**
   ```bash
   terraform plan -out=tfplan
   ```

4. **Apply the Deployment:**
   ```bash
   terraform apply -auto-approve
   ```

5. **View Outputs:**
   ```bash
   terraform output
   ```

6. **List Key Vaults in Resource Group:**
   ```bash
   az keyvault list --resource-group rg-keyvault-private-endpoint-001 --output table
   ```

7. **Check Key Vault URI:**
   ```bash
   az keyvault show --name kvsecure86071 --resource-group rg-keyvault-private-endpoint-001 --query "properties.vaultUri"
   ```

## Cleanup

To destroy the resources and avoid unnecessary charges:

```bash
terraform destroy -auto-approve
```

Ensure that all resources are removed to prevent any unexpected costs.

