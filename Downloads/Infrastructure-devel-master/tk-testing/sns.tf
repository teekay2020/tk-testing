#resource "aws_sns_topic" "sns_tk" {
#  name                        = "sns_tk"
#}

#resource "aws_sns_topic_policy" "sns_tk" {
#  arn                         = "${aws_sns_topic.sns_tk.arn}"

#  policy                      = <<SNS_INSTANCES_ACCESS_POLICY
#{
#  "Version": "2012-10-17",
#  "Statement":[
#    {
#      "Effect": "Allow",
#      "Action": [
#        "sns:*"
#      ],
#      "Principal": {
#        "AWS": "*"
#      },
#      "Resource": "${aws_sns_topic.sns_tk.arn}"
#    }

#}
#SNS_INSTANCES_ACCESS_POLICY
#}
