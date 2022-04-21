output "logo" {
  value = aws_cloudwatch_event_rule.console.arn
}


output "rule" {
  value = aws_cloudwatch_event_rule.console.name
}