# Delete non-empty Object Storage bucket using MINIO and Terraform

Terraform scripts to recursively delete all the objects of a Cloud Object Storage (COS) bucket using MINIO client.

### Deploy COS
1. Clone this repository
   ```sh
   git clone https://github.com/VidyasagarMSC/cos-object-cleanup.git
   ```
2. Create `terraform.tfvars` file from the template and update the file with your details
   ```sh
   cp terraform.tfvars.template terraform.tfvars
   ```
3. Run both `terraform` commands
   ```sh
   terraform init
   terraform apply
   ```
### Destroy

```sh
terraform destroy
```
