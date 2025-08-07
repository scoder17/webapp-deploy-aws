output "lb_target_group_name" {
  value = aws_lb_target_group.app_tg.name
}

output "artifact_bucket_name" {
  value = aws_s3_bucket.artifacts.bucket
}

output "blue_asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "green_asg_name" {
  value = aws_autoscaling_group.app_asg_green.name
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}