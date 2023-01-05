resource "aws_sqs_queue" "aggregate_queue" {
  name = var.partner_name
}

resource "aws_lambda_function" "aggregate_lambda" {

  filename      = "aggregate.jar"
  function_name = "aggregate"
  role          = aws_iam_role.aggregate_lambda.arn
  handler       = "example.HandlerInteger"

  runtime = "java11"
}

resource "aws_lambda_event_source_mapping" "aggregate_lambda" {
  event_source_arn  = aws_sqs_queue.aggregate_queue.arn
  enabled           = true
  function_name     = aws_lambda_function.aggregate_lambda.arn
  batch_size       = 1
}