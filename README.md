
# Azure Key Vault with Private Endpoint

This Terraform configuration deploys an Azure Key Vault with a private endpoint, securing access within a Virtual Network.

## Purpose
- Secure Azure Key Vault access using a private endpoint.
- Deploy Key Vault and its private endpoint within a specific resource group.
- Output Key Vault name and private endpoint IP address.

## Files
- **main.tf**: Defines resources including Key Vault, private endpoint, and networking components.
- **variables.tf**: Input variables for the deployment.
- **outputs.tf**: Outputs including the private endpoint IP address and Key Vault name.

## Screenshots
- [terraform-apply-success.png](./screenshots/terraform-apply-success.png): Terraform apply output showing successful resource creation.
- [terraform-output.png](./screenshots/terraform-output.png): Output values showing key vault name and private endpoint IP address.
- [keyvault-list.png](./screenshots/keyvault-list.png): Azure CLI output listing the created Key Vault.

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
    terraform apply tfplan
    ```

5. **Check Outputs:**
    ```bash
    terraform output
    ```

6. **List Key Vault:**
    ```bash
    az keyvault list --resource-group rg-keyvault-private-endpoint-001 --output table
    ```

