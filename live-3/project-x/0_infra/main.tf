# Provider block with region defined
provider "aws" {
  region = var.aws_region
}

module "unique_id" {
  source = "../../../modules//unique_id/v1.0.0"
}

# invoke VPC

# invoke mysql

# invoke LB

# invoke ASG

# invoke DNS Route53

