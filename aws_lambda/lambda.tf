data "aws_lambda_function" "existing" {
  function_name = "test"
  depends_on    = [aws_lambda_function.aws_lambda]
}


resource "aws_lambda_function" "aws_lambda" {
  for_each      = { for x in var.lambda_function : x.lambda_name => x }
  function_name = each.value.lambda_name
  filename      = each.value.filename
  role          = each.value.role
  handler       = each.value.handler
  runtime       = each.value.runtime
  tags          = var.lambda_tags
}


