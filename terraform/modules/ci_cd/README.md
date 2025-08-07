# ci_cd

This module is used to create a CI/CD pipeline on AWS using CodePipeline, CodeBuild, and CodeDeploy.  
It automates building Docker images, running Terraform plans, applying infrastructure changes, and deploying application updates with blue-green deployment strategy.

## Requirements

| Name   | Version |
|--------|---------|
| terraform | >= 1.11.0  |
|aws     | ~>6.7.0   |


## Resources

| Name                                    | Type     |
|-----------------------------------------|----------|
| aws_codebuild_project.app_build_plan    | resource |
| aws_codebuild_project.app_build_apply   | resource |
| aws_codedeploy_app.app                   | resource |
| aws_codedeploy_deployment_group.webapp_group | resource |
| aws_codepipeline.webapp_pipeline         | resource |
| aws_iam_role.codebuild_role              | resource |
| aws_iam_role_policy.codebuild_policy     | resource |
| aws_iam_role_policy_attachment.codebuild_attach | resource |
| aws_iam_role.codepipeline_role           | resource |
| aws_iam_role_policy_attachment.codepipeline_attach | resource |
| aws_iam_role.codedeploy_role             | resource |
| aws_iam_role_policy_attachment.codedeploy_attach | resource |

## Data Sources

| Name                      | Type           |
|---------------------------|----------------|
| aws_ssm_parameter.github_token | data |

## Inputs

| Name                 | Description                                                  | Type   | Default       |
|----------------------|--------------------------------------------------------------|--------|---------------|
| aws_region           | AWS region to deploy resources                               | string | "us-east-1"   |
| lb_target_group_name | The name of the ALB target group                              | string |           N/A    |
| artifact_bucket_name | Name of the S3 bucket used as artifact store for CodePipeline| string |  N/A             |
| blue_asg_name        | The name of the blue Auto Scaling Group                      | string |  N/A             |
| green_asg_name       | The name of the green Auto Scaling Group                     | string |   N/A            |
| listener_arn         | The ARN of the Load Balancer listener                         | string |  N/A             |

## Outputs

No outputs.