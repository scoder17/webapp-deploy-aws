resource "aws_sns_topic" "pipeline_failure" {
  name = "pipeline-failure-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.pipeline_failure.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_lambda_function" "notify_pipeline_failure" {
  function_name = "notify-pipeline-failure"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  filename      = "${path.module}/lambda.zip"

  environment {
    variables = {
      TOPIC_ARN = aws_sns_topic.pipeline_failure.arn
    }
  }
}

resource "aws_cloudwatch_event_rule" "pipeline_failure_rule" {
  name        = "pipeline-failure-event"
  description = "Triggers on CodePipeline failure"

  event_pattern = jsonencode({
    "source": ["aws.codepipeline"],
    "detail-type": ["CodePipeline Pipeline Execution State Change"],
    "detail": {
      "state": ["FAILED"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.pipeline_failure_rule.name
  target_id = "lambda"
  arn       = aws_lambda_function.notify_pipeline_failure.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notify_pipeline_failure.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.pipeline_failure_rule.arn
}