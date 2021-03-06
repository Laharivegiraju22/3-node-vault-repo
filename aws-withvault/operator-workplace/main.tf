variable "name" { default = "dynamic-aws-creds-operator" }
variable "region" { default = "us-east-1" }
variable "path" { default = "../vault-adminspace/terraform.tfstate" }
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
  role    = data.terraform_remote_state.admin.outputs.role
}
provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.creds.access_key
 secret_key = data.vault_aws_access_credentials.creds.secret_key
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = "ami-0dba2cb6798deb6d8"
  instance_type = "t2.micro"

  tags = {
    Name  = var.name
    TTL   = var.ttl
    owner = "${var.name}-guide"
  }
 key_name                    = "oct19"
}
