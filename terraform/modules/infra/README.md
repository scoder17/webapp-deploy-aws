# infra

This module is being used to create an infra for the project. This includes creation of ECR repo, S3, SG, ALB and ASG, etc. 

## Requirements

| Name      | Version    |
|-----------|------------|
| terraform | >= 1.11.0  |
| random    | ~> 3.7.2   |
| aws       | ~> 6.7.0   |

## Resources

| Name                                      | Type     |
|-------------------------------------------|----------|
| aws_lb.app_lb                             | resource |
| aws_lb_target_group.app_tg                | resource |
| aws_lb_listener.http                      | resource |
| aws_launch_template.app_lt                | resource |
| aws_autoscaling_group.app_asg             | resource |
| aws_autoscaling_group.app_asg_green       | resource |
| aws_cloudwatch_metric_alarm.cpu_high      | resource |
| aws_ecr_repository.app                    | resource |
| aws_iam_role.ec2_role                     | resource |
| aws_iam_instance_profile.ec2_profile      | resource |
| aws_iam_role_policy_attachment.ec2_ssm_attach        | resource |
| aws_iam_role_policy_attachment.ec2_ecr_attach        | resource |
| aws_iam_role_policy_attachment.ec2_logs_attach       | resource |
| aws_iam_role_policy_attachment.ec2_codedeploy_attach | resource |
| aws_iam_role_policy.ec2_s3_codedeploy     | resource |
| aws_vpc.main                             | resource |
| aws_subnet.public                        | resource |
| aws_subnet.private                       | resource |
| aws_internet_gateway.gw                  | resource |
| aws_nat_gateway.nat                      | resource |
| aws_eip.nat                             | resource |
| aws_route_table.public                   | resource |
| aws_route_table_association.public       | resource |
| aws_route_table.private                  | resource |
| aws_route_table_association.private      | resource |
| aws_s3_bucket.artifacts                  | resource |
| random_id.suffix                        | resource |
| aws_security_group.alb_sg                | resource |
| aws_security_group.ec2_sg                | resource |



## Data Sources

| Name                      | Type        |
|---------------------------|-------------|
| data.aws_ami.amazon_linux | data        |
| data.aws_availability_zones.available    | data     |
| data.aws_iam_policy_document.ec2_assume   | data    |

## Inputs

| Name             | Description          | Type          | Default                    |
|------------------|---------------------|---------------|----------------------------|
| aws_region       | AWS region          | string        | "us-east-1"                |
| project_name     | Project name        | string        | "devops-app"               |
| vpc_cidr         | VPC CIDR block      | string        | "10.0.0.0/16"              |
| public_subnets   | Public subnet CIDRs | list(string)  | ["10.0.1.0/24", "10.0.2.0/24"] |
| private_subnets  | Private subnet CIDRs| list(string)  | ["10.0.3.0/24", "10.0.4.0/24"] |
| instance_type    | EC2 instance type   | string        | "t3.micro"                 |
| desired_capacity | Desired ASG size    | number        | 2                          |
| max_size         | Max ASG size        | number        | 3                          |
| min_size         | Min ASG size        | number        | 1                          |


## Outputs

| Name                 | Description                                           |
|----------------------|-------------------------------------------------------|
| lb_target_group_name  | The name of the AWS load balancer target group        |
| artifact_bucket_name  | The name of the AWS S3 bucket used for artifacts      |
| blue_asg_name        | The name of the blue AWS Auto Scaling group           |
| green_asg_name       | The name of the green AWS Auto Scaling group          |
| listener_arn         | The ARN of the AWS load balancer HTTP listener        |