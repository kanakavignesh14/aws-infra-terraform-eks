terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
   backend "s3" {
    bucket = "my-terra-final"
    key    = "roboshop-EKS-kk"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true

  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


