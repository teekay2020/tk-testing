
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "route_table" {
  value = "${aws_route_table.private-subnet.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.main.cidr_block}"
}
