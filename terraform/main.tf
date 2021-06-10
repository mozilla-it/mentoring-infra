# # Docker registry
# module "ecr" {
#   source    = "github.com/mozilla-it/terraform-modules//aws/ecr?ref=master"
#   repo_name = "mentoring"
# }

# # Database
# module "database-prod" {
#   source               = "github.com/mozilla-it/terraform-modules//aws/database?ref=master"
#   instance             = "db.t3.micro"
#   type                 = "postgres"
#   name                 = "mentoring"
#   username             = "mentoring"
#   identifier           = "mentoring-prod"
#   storage_gb           = "5" # minimum allowed
#   db_version           = "12.5"
#   parameter_group_name = "default.postgres12"
#   multi_az             = "false"
#   subnets              = data.terraform_remote_state.vpc.outputs.private_subnets
#   vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id

#   cost_center = "1410"
#   project     = "mentoring"
#   environment = "prod"
# }

# # Route53
# resource "aws_route53_zone" "primary" {
#   name = "mentoring.mozilla.com"
# }

# # ACM
# resource "aws_acm_certificate" "mentoring_mozilla_com" {
#   domain_name       = "mentoring.mozilla.com"
#   validation_method = "DNS"
# }

# resource "aws_route53_record" "mentoring_mozilla_com" {
#   for_each = {
#     for dvo in aws_acm_certificate.mentoring_mozilla_com.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.primary.zone_id
# }

# resource "aws_acm_certificate_validation" "mentoring_mozilla_com" {
#   certificate_arn         = aws_acm_certificate.mentoring_mozilla_com.arn
#   validation_record_fqdns = [for record in aws_route53_record.mentoring_mozilla_com : record.fqdn]
# }
