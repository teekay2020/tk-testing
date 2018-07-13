module "server" {
  source  = "./_server"

  amis    = "${var.amis}"
  key     = "${aws_key_pair.deployer.key_name}"
  type    = "${var.type}"
}

module "client" {
  source  = "./_client"

  amis    = "${var.amis}"
  key     = "${aws_key_pair.deployer.key_name}"
  type    = "${var.type}"
}

