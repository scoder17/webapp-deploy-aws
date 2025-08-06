resource "aws_codebuild_project" "app_build_plan" {
  name          = "app-build-plan"
  description   = "Builds Docker and runs Terraform plan"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec-plan.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/plan"
      stream_name = "plan-log"
    }
  }
}

resource "aws_codebuild_project" "app_build_apply" {
  name          = "app-build-apply"
  description   = "Applies Terraform"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec-apply.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/apply"
      stream_name = "apply-log"
    }
  }
}