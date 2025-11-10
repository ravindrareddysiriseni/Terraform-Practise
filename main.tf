provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

terraform {
  required_version = "1.13.4" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<=6.19.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.vpc_name}"
    Owner       = "Ravindra Reddy Siriseni"
    environemnt = "${var.environemnt}"
  }

}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.IGW_name}"
  }

}

resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.public_subnet1_name}"
  }

}

resource "aws_subnet" "subnet2_public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.public_subnet2_name}"
  }

}

resource "aws_subnet" "subnet3_public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = "us-east-1c"
  tags = {
    Name = "${var.public_subnet3_name}"
  }

}

resource "aws_subnet" "subnet1-private" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.private_subnet1_name}"
  }

}

resource "aws_route_table" "terraform_public" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "${var.Main_Route_Table}"
  }
}

resource "aws_route_table_association" "terraform_public" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform_public.id
}

resource "aws_security_group" "Allow_all" {
  name        = "Allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["212020517509"]

}

resource "aws_instance" "ubuntu_server" {
  ami                         = "ami-0ecb62995f68bb549"
  availability_zone           = "us-east-1a"
  instance_type               = "t3.micro"
  key_name                    = "NewKey"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.Allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name  = "Ubuntu-Server by Terraform"
    Owner = "Ravindra Reddy Siriseni"

  }

}

resource "aws_instance" "ubuntu_server1" {
  ami                         = "ami-0c398cb65a93047f2"
  availability_zone           = "us-east-1b"
  instance_type               = "t3.micro"
  key_name                    = "NewKey"
  subnet_id                   = aws_subnet.subnet2_public.id
  vpc_security_group_ids      = ["${aws_security_group.Allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name  = "Ubuntu-Server1 by Terraform"
    Owner = "Ravindra Reddy Siriseni"

  }

}


