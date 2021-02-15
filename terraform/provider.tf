provider "aws" {
  region = "us-west-2"
}

terraform {
  required_version = "~> 0.14"

  backend "s3" {
    # naming convention https://mana.mozilla.org/wiki/display/SRE/Terraform
    bucket = "mentoring-state-783633885093"
    key    = "state/terraform.tfstate"
    region = "us-west-2"
  }
}

