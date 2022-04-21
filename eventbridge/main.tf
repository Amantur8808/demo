resource "aws_cloudwatch_event_target" "yada" {
  rule = var.event_rule
  arn  = var.event_arn
}


resource "aws_cloudwatch_event_rule" "console" {
  name        = var.event_name
  description = "Capture all EC2 scaling events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.s3"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
        "s3.amazonaws.com"
        ],
    "eventName": [
        "CreateBucket"
        ]
  }
}
PATTERN
}