terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
}

resource "aws_instance" "my_ec2" {
  count             = 2
  ami               = "ami-01cc34ab2709337aa"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.my_subnet.id
  associate_public_ip_address = true
} 