module "infra" {
  source = "./modules/infra"
}

module "ci_cd" {
  source               = "./modules/ci_cd"
  lb_target_group_name = module.infra.lb_target_group_name
  artifact_bucket_name = module.infra.artifact_bucket_name
  blue_asg_name        = module.infra.blue_asg_name
  green_asg_name       = module.infra.green_asg_name
  listener_arn         = module.infra.listener_arn
}

module "notification_alerts" {
  source = "./modules/notification_alerts"
}