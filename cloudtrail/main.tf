data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "foobar" {
  count                         = var.cloudtrail == true ? 1 : 0
  name                          = var.cloudtrail_name
  s3_bucket_name                = var.s3_bucket
  s3_key_prefix                 = var.s3_key
  include_global_service_events = var.global_events
}


resource "aws_s3_bucket" "foo" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::chelekkk"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::chelekkk/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

output "s3_bucket" {
  value = aws_s3_bucket.foo.id
}