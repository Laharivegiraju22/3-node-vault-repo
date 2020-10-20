output "vpid" {
	value = "${aws_vpc.main.id}"
	}

output "vault-subnetids" {
	value = "${aws_subnet.vault-subnet.*.id}"
	}

output "vault-subnets-cidr" {
	value = "${aws_subnet.vault-subnet.*.cidr_block}"
	}

