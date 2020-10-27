variable "name" { default = "dynamic-aws-creds-operator" }
variable "region" { default = "us-east-1" }
variable "path" { default = "../../vault-adminspace/terraform.tfstate" }
variable "ttl" { default = "1" }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = "${var.path}"
  }
}
data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.s3-role
}
provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.creds.access_key
 secret_key = data.vault_aws_access_credentials.creds.secret_key
   }

# Create AWS S3 bucket
resource "aws_s3_bucket" "s3bucket" {
bucket = "my-vaultdemo123-bucket"
acl = "private"
versioning {
enabled = true
}

tags = {
Name = "my-vaultdemo123-bucket"
}

}
