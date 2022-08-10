# project-y

```
cd 0_infra
terraform init
terraform plan -var-file ../{dev|prod|stg}/terraform.tfvars
terraform apply -var-file ../{dev|prod|stg}/terraform.tfvars
```