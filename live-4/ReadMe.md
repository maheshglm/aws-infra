# Layered + Environment + Module based approach

We do not need to repeat the common resources in every project but we can reference to the common resources state.

This is implemented `local` backend so process will change when we implement the same approach with `S3` backend.

All the common resources are kept in commons folder relative to the live-4 (live) folder. Since the common resource
ex: VPC also can be different for different environments i.e. dev, prod, stg. We need to add environment based configuration
for common resources as well.

We can create project specific infra under `projects` folder which is also relative to the `live` folder.
and each project gets same concept as common resources. In addition, each project base folder will get `data.tf` to fetch 
data from remote state of common resources specific to environment.

```
project
    |
    |__base
            |
            |----data.tf, main.tf, variables.tf, outputs.tf    
    |--env
            |
            |----dev
                    |
                    |---terraform.tfvars
            |----prod
                    |
                    |----terraform.tfvars
```