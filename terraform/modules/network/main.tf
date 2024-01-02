# main.tf

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block
  map_public_ip_on_launch = true

  availability_zone = var.availability_zone

  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block_2
  map_public_ip_on_launch = true

  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.vpc_name}-public-subnet-2"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_route_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

#######################################


# Create a Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr_block

  availability_zone = var.availability_zone

  tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr_block_2

  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.vpc_name}-private-subnet-2"
  }
}

# Create a NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  subnet_id = aws_subnet.public_subnet.id

  # Allocate an Elastic IP for the NAT Gateway
  allocation_id = aws_eip.nat_eip.id
}

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# Create a Route Table for the Private Subnet to route traffic through the NAT Gateway
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private_route_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

