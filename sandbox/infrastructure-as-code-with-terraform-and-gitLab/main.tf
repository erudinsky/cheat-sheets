terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_vpc" "vpc" {
  tags = {
    Name = "${var.prefix} VPC"
  }
  cidr_block           = var.cidr
  enable_dns_support   = true
  instance_tenancy     = "default"
  enable_dns_hostnames = true
}

resource "aws_subnet" "bastion-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_subnet_bastion
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"
  tags = {
    Name = "bastion-subnet"
  }
}

resource "aws_subnet" "prod-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_subnet_prod
  map_public_ip_on_launch = false
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "prod-subnet"
  }
}
