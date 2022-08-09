# Provider block with region defined
provider "aws" {
  region = var.aws_region
}

module "unique_id" {
  source = "../../../modules//unique_id/v1.0.0"
}



