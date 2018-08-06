# TODO: Move. Current DNS: NS1.C17841.SGVPS.NET, NS2.C17841.SGVPS.NET
resource "aws_route53_zone" "bnf_org" {
  name                 = "bnf.org"
  comment              = "bnf.org."
  force_destroy        = "true"
}

resource "aws_route53_record" "bnf_org-at_txt" {
  zone_id                     = "${aws_route53_zone.bnf_org.zone_id}"
  name                        = "bnf.org"
  type                        = "TXT"
  ttl                         = 3600
  records                     = [
    "MS=ms32307524"
  ]
}

