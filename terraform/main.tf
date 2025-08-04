module "infra" {
  source       = "./modules/infra"
  github_token = var.github_token
}

# module "ci_cd" {
#   source       = "./modules/ci_cd"
#   github_token = var.github_token
#   depends_on   = [module.infra]
# }