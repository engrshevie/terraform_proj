provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc_net" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.vpc_tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_net.id

  tags = {
    Name = "gw"
  }
}

resource "aws_subnet" "vpc_net_pub" {
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id     = aws_vpc.vpc_net.id
}

resource "aws_subnet" "vpc_net_pubb" {
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  vpc_id     = aws_vpc.vpc_net.id
}


resource "aws_route_table" "example" {
  vpc_id = aws_vpc.vpc_net.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}



resource "aws_route_table" "example1" {
  vpc_id = aws_vpc.vpc_net.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example1"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.vpc_net_pub.id
  route_table_id = aws_route_table.example.id
}


resource "aws_route_table_association" "aa" {
  subnet_id      = aws_subnet.vpc_net_pubb.id
  route_table_id = aws_route_table.example1.id
}

resource "aws_db_subnet_group" "education" {
  name       = "education"
  subnet_ids = [aws_subnet.vpc_net_pub.id, aws_subnet.vpc_net_pubb.id]

  tags = {
    Name = "Education"
  }
}
