locals {
  common_tags = {
    Name = ""
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "lambda_name" {
  type    = string
  default = "test"
}

variable "handler" {
  type    = string
  default = "lambda_function.lambda_handler"
}

variable "runtime" {
  type    = string
  default = "python3.7"
}

variable "role_name" {
  type    = string
  default = "LambdaRole"
}

variable "lambda_tags" {
  type    = string
  default = "test"
}

variable "lb_role" {
  type    = string
  default = "test"
}

variable "cloudtrail_name" {
  type    = string
  default = "tf-trail-foobar"
}

variable "s3_key" {
  type    = string
  default = "prefix"
}

variable "global_events" {
  type    = bool
  default = false
}

variable "bucket_name" {
  type    = string
  default = "chelekkk"
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "cloudtrail" {
  type    = bool
  default = true
}

variable "event_name" {
  type    = string
  default = "capture-ec2-scaling-events"
}

variable "archive_type" {
  type    = string
  default = "zip"
}

variable "statement" {
  type    = string
  default = "AllowExecutionFromCloudWatch"
}

variable "action" {
  type    = string
  default = "lambda:InvokeFunction"
}

variable "principal" {
  type    = string
  default = "events.amazonaws.com"
}