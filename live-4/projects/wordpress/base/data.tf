data "terraform_remote_state" "vpc" {
  backend = "local"
  config  = {
    path = "../../../commons/vpc/base/${var.environment}.terraform.tfstate"
  }
}

