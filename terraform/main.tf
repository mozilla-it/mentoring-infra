# Docker registry
module "ecr" {
  source    = "github.com/mozilla-it/terraform-modules//aws/ecr?ref=master"
  repo_name = "mentoring"
}

# Database
module "database-prod" {
  source               = "github.com/mozilla-it/terraform-modules//aws/database?ref=master"
  instance             = "db.t3.micro"
  type                 = "postgres"
  name                 = "mentoring"
  username             = "mentoring"
  identifier           = "mentoring-prod"
  storage_gb           = "5" # minimum allowed
  db_version           = "12.5"
  parameter_group_name = "default.postgres12"
  multi_az             = "false"
  subnets              = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id

  cost_center = "1410"
  project     = "mentoring"
  environment = "prod"
}

# Route53
resource "aws_route53_zone" "primary" {
  name = "mentoring.mozilla.com"
}
