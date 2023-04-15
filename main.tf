# Creating the VPC first
resource "aws_vpc" "eus1vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "${var.namespace}-eus1vpc"
    "Owner" = "${var.namespace}"
  }
}

# Create subnet after VPC

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.eus1vpc.id
  cidr_block = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    "Name" = "eus1pub - ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.eus1vpc.id
  cidr_block = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    "Name" = "eus1pri - ${count.index + 1}"
  }
}

resource "aws_subnet" "database_subnets" {
    count = length(var.database_subnet_cidr)
    vpc_id = aws_vpc.eus1vpc.id
    cidr_block = element(var.database_subnet_cidr, count.index)
    availability_zone = element(var.azs, count.index)

    tags = {
        "Name" = "eus1db - ${count.index + 1}"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.eus1vpc.id

  tags = {
    "Name" = "Main Internet Gateway"
  }
}

resource "aws_route_table" "pub_routetable" {
  vpc_id = aws_vpc.eus1vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    "Name" = "eus1rt"
  }
}

resource "aws_route_table_association" "pub_associate" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.pub_routetable.id
}