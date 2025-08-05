module "infra" {
  source = "./modules/infra"
}

module "ci_cd" {
  source               = "./modules/ci_cd"
  github_token         = var.github_token
  lb_target_group_name = module.infra.lb_target_group_name
  artifact_bucket_name = module.infra.artifact_bucket_name
}

module "notification_alerts" {
  source = "./modules/notification_alerts"
}