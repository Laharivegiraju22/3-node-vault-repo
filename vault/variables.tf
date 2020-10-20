# AWS region and AZs in which to deploy
variable "aws_region" {
  default = "us-east-1"
}

# variable "availability_zones" {
#        default = "ap-southeast-1a"
# }

variable "ami_id" {
        default = "ami-0ac80df6eff0e70b5"
}

variable "vpc_id" {
        default = "vpc-0cc9ba1d60e487bc7"
}

variable "pub-subnets" {
        type = list(string)
       # default = "subnet-0dd1aafb170c227bd"
        default = ["subnet-0e0b911031d09b4e7","subnet-0a74f623b04e549fd","subnet-0b24f3a33f7dbfb05"]
        }

# All resources will be tagged with this
variable "environment_name" {
  default = "raft-demo"
}

variable "vault_transit_private_ip" {
  description = "The private ip of the first Vault node for Auto Unsealing"
  default = "10.44.0.0"
}


variable "vault_server_names" {
  description = "Names of the Vault nodes that will join the cluster"
  type = list(string)
  default = [ "vault_2", "vault_3", "vault_4" ]
}

variable "vault_server_private_ips" {
 # description = "The private ips of the Vault nodes that will join the cluster"
  # @see https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html
  type = list(string)
  default = ["10.44.0.1","10.44.0.2","10.44.0.3"]
}


# URL for Vault OSS binary
variable "vault_zip_file" {
  default = "https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip"
}

# Instance size
variable "instance_type" {
  default = "t2.micro"
}

# SSH key name to access EC2 instances (should already exist) in the AWS Region
variable "key_name" {
}
