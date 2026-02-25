terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28.0"
    }
  }
   backend "s3" {
    bucket = "terraform-tata-bucket"
    key    = "my-infra-eks"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true

  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


