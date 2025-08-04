output "lb_target_group_name" {
  value = aws_lb_target_group.app_tg.name
}

output "artifact_bucket_name" {
  value = aws_s3_bucket.artifacts.bucket
}