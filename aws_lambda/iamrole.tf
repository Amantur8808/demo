data "aws_iam_role" "aws_role" {
  name       = var.role_name
  depends_on = [aws_iam_role.lambda_role]
}


resource "aws_iam_role" "lambda_role" {
  name               = var.role_name
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF

  tags = var.lbrole_tags
}