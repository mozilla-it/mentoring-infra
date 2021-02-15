data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "itsre-state-783633885093"
    key    = "terraform/deploy.tfstate"
    region = "eu-west-1"
  }
}

# TODO: Fill once the app is deployed
#data "aws_elb" "mentoring_prod" {
#  name = "" # To be determined
#}
