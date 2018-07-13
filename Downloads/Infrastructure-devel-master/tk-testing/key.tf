resource "aws_key_pair" "deployer" {
  key_name               = "deployer-key"
  public_key             = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC98FPBJ7zOTIyKwyYJqR1haBF6rlUZ3b64cBSxtqNr8qdX5RneHkQDfnQulcLvQk3ivlslTCRb4ukN87xIPby44OJDFoX037l4qsn2JwT4X0MZpTAYjauJYBx2E7bsQBrXH7pd1UoBivuEFqmIXRl4P/CD9LnNogp3I9cQEwx5lsTzRuVOMBv8FXmLHOy9LxiOYUbkFVi5nooCvAooj3GzHBS9V4IItWql1hqgEqM1O1F93FKjHlrAgIPLnk/GjUjXh7YTtNLnVTFskosE5oaL5jh3rZvKfVazhpUUmY/eZVuDSuBo1HDkTtyciFvfNsFtbX43KsK1/RxFRZiKkDZz tk_test@aws"
}
