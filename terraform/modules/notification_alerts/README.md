# notification_alerts

This module is used to set up a notification system that alerts via email when an AWS CodePipeline execution fails. It creates the necessary SNS topic, Lambda function, CloudWatch event rules, and IAM roles/policies to automate the notification process.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0  |
|aws     | ~>6.7.0   |

## Resources

| Name                                         | Type      |
|----------------------------------------------|-----------|
| aws_sns_topic.pipeline_failure                | resource  |
| aws_sns_topic_subscription.email              | resource  |
| aws_lambda_function.notify_pipeline_failure   | resource  |
| aws_cloudwatch_event_rule.pipeline_failure_rule | resource  |
| aws_cloudwatch_event_target.lambda_target     | resource  |
| aws_lambda_permission.allow_eventbridge       | resource  |
| aws_iam_role.lambda_exec_role                 | resource  |
| aws_iam_role_policy_attachment.lambda_basic   | resource  |
| aws_iam_policy.sns_publish                    | resource  |
| aws_iam_policy_attachment.lambda_sns_publish  | resource  |


## Data Sources

No data block used.

## Inputs

| Name                | Description                               | Type   | Default               |
|---------------------|-------------------------------------------|--------|-----------------------|
| aws_region          | AWS region to deploy resources            | string | `"us-east-1"`         |
| notification_email  | Email address to receive pipeline failure notifications | string | `"sadarsh460@gmail.com"` |

## Outputs

No outputs.