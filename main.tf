provider "aws" {
    access_key = "ASDASDQ221312SADSADSAD"
    secret_key = "xxxxxxxxx"
    region = "us-east-1"
}
 
module "vault_vpc" {
    source      = "./network-layout/"
}
 
module "vault" {
    source         = "./vault/"
   vpc_id          = "${module.vault_vpc.vpid}" 
pub-subnets        = "${module.vault_vpc.vault-subnetids}"
key_name	   = "oct19"
}
output "endpoints" {
  value ="${module.vault.endpoints}"
}
