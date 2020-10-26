## Provider Details ##
provider "aws" {
  region = "us-east-2"
  profile = "terraformRDS"
}

## Ec2 Resource ##
resource "aws_instance" "web" {
  ami           = "ami-0a54aef4ef3b5f881"
  instance_type = "t2.micro"
  count         = "2"
}

## Amazon RDS ##
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "RDS_Test"
  username             = "admin"
  password             = "administratorRDS"
}

## Subnet Details ##
resource "aws_subnet" "terraformSubnet" {
  cidr_block       = "10.0.0.0/16"
  vpc_id           = "vpc-4475c02f"
}

## Securitygroup Details ##
resource "aws_security_group" "terraformSecurityGroup" {
  name        = "RDS_SecurityGroup"
  vpc_id      = "vpc-4475c02f"
  description = "Create security group for ec2 using Terraform"
  ingress {
    description = "Allow Inbound Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "Allow Inbound Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "Allow Inbound Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Ravindar Guribelli"
  }
}
