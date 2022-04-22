module "lambda" {
  source = "../aws_lambda"
  lambda_function = [{
    filename    = "${path.module}/python/lambda_function.zip"
    role        = module.lambda.lambdarole
    lambda_name = var.lambda_name
    handler     = var.handler
    runtime     = var.runtime
  }]

  role_name = var.role_name

  lambda_tags = merge(local.common_tags,
    {
      Name = var.lambda_tags
  })

  lbrole_tags = merge(local.common_tags,
    {
      Name = var.lb_role
  })

}

####################################################################################################################################

module "cloudtrail" {
  source          = "../cloudtrail"
  s3_bucket       = module.cloudtrail.s3_bucket
  cloudtrail_name = var.cloudtrail_name
  s3_key          = var.s3_key
  global_events   = var.global_events
  bucket_name     = var.bucket_name
  force_destroy   = var.force_destroy
  cloudtrail      = var.cloudtrail
}

####################################################################################################################################

module "eventbridge" {
  source     = "../eventbridge"
  event_arn  = module.lambda.lambda_arn
  event_rule = module.eventbridge.rule
  depends_on = [module.lambda]
  event_name = var.event_name
}

####################################################################################################################################

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/CloudWatchEventsBuiltInTargetExecutionAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess"
  ])

  role       = module.lambda.la_role
  policy_arn = each.value
}

data "archive_file" "zip_the_python_code" {
  type        = var.archive_type
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/lambda_function.zip"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id  = var.statement
  action        = var.action
  function_name = module.lambda.lambdaname
  principal     = var.principal
  source_arn    = module.eventbridge.logo
  depends_on    = [module.eventbridge]
}
