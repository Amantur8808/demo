output "lambda_arn" {
  value = data.aws_lambda_function.existing.arn
}

output "la_role" {
  value = data.aws_iam_role.aws_role.id
}

output "lambdarole" {
  value = aws_iam_role.lambda_role.arn
}

output "lambdaname" {
  value = data.aws_lambda_function.existing.function_name
}