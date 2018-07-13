###########
# NETWORK #
###########


#####
#VPC#
#####

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

enable_dns_support = true
  enable_dns_hostnames = true

tags {
    Name = "server"
  }
}

################
#Private Subnet#
################

resource "aws_subnet" "eu-west-1a-private" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.1.0/24"
#  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
   Name =  "Private1 Subnet"
  }
}

resource "aws_subnet" "eu-west-1b-private" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.2.0/24"
#  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
  tags = {
   Name =  "Private2 Subnet"
  }
}

resource "aws_subnet" "eu-west-1c-private" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.3.0/24"
#  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
  tags = {
   Name =  "Private3 Subnet"
  }
}

resource "aws_route_table" "private-subnet" {
      vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "private-subnet-1a" {
    subnet_id      = "${aws_subnet.eu-west-1a-private.id}"
    route_table_id = "${aws_route_table.private-subnet.id}"
}

resource "aws_route_table_association" "private-subnet-1b" {
    subnet_id      = "${aws_subnet.eu-west-1b-private.id}"
    route_table_id = "${aws_route_table.private-subnet.id}"
}

resource "aws_route_table_association" "private-subnet-1c" {
    subnet_id      = "${aws_subnet.eu-west-1c-private.id}"
    route_table_id = "${aws_route_table.private-subnet.id}"
}

resource "aws_main_route_table_association" "main" {
  vpc_id                 = "${aws_vpc.main.id}"
  route_table_id         = "${aws_route_table.private-subnet.id}"
}

###############
#Public Subnet#
###############

resource "aws_subnet" "eu-west-1a-public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.4.0/24"
#  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
   Name =  "Public Subnet"
  }
}

resource "aws_route_table" "public-subnet" {
    vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "public-subnet" {
    subnet_id      = "${aws_subnet.eu-west-1a-public.id}"
    route_table_id = "${aws_route_table.public-subnet.id}"
}
