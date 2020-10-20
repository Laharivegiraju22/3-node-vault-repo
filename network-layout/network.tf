######## availability zones list

data "aws_availability_zones" "available" {}

#######  vpc creation

resource "aws_vpc" "main" {
    cidr_block = var.cidr 
    tags = {
        Name = "vault-VPC"
    }
}

####### Subnets creation



resource "aws_subnet" "vault-subnet" {
	count 			= var.az_count
	cidr_block		= cidrsubnet(aws_vpc.main.cidr_block, 9, count.index)
	availability_zone	= data.aws_availability_zones.available.names[count.index]
	vpc_id			= aws_vpc.main.id
	tags = {
		Name = "${var.subnets}-${count.index+1}"
		}
	}




######## Internet gateway creation

resource "aws_internet_gateway" "igw" {
	vpc_id			= aws_vpc.main.id
	tags = {	
		Name = "Vault-IGateway"
		}
	}


######### Route creation for public trafic through IGW

resource "aws_route" "Test_internet_access" {
	route_table_id		= aws_vpc.main.main_route_table_id
	destination_cidr_block	= "0.0.0.0/0"
	gateway_id		= aws_internet_gateway.igw.id
	}



