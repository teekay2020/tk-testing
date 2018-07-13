# === SERVER -> CLIENT

resource "aws_vpc_peering_connection" "server-client" {
  vpc_id                            = "${module.server.vpc_id}"
  peer_vpc_id                       = "${module.client.vpc_id}"

  auto_accept                       = "true"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags {
    Name                            = "server-client"
  }
}

resource "aws_route" "server-client" {
  route_table_id                    = "${module.server.route_table}"
  destination_cidr_block            = "${module.client.vpc_cidr}"
  vpc_peering_connection_id         = "${aws_vpc_peering_connection.server-client.id}"
}

resource "aws_route" "client-server" {
  route_table_id                    = "${module.client.route_table}"
  destination_cidr_block            = "${module.server.vpc_cidr}"
  vpc_peering_connection_id         = "${aws_vpc_peering_connection.server-client.id}"

}






