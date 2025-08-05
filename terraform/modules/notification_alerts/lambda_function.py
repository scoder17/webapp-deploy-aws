import os
import json
import boto3

sns = boto3.client('sns')
topic_arn = os.environ['TOPIC_ARN']

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))

    detail = event.get('detail', {})
    pipeline = detail.get('pipeline', 'unknown')
    execution_id = detail.get('execution-id', 'unknown')

    message = f"🚨 CodePipeline '{pipeline}' FAILED.\nExecution ID: {execution_id}"
    
    sns.publish(
        TopicArn=topic_arn,
        Subject="CodePipeline Failure Notification",
        Message=message
    )

    return {
        'statusCode': 200,
        'body': 'Notification sent.'
    }