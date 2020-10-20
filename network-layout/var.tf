variable "cidr" {
	default = "10.44.0.0/16"
	}

variable "az_count" {
	default = "3"
	}

variable "vpcname" {
	default = "vault-VPC"
	}

variable "subnets" {
	default = "vault-subnet"  
}
