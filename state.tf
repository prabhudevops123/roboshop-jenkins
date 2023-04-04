terraform {
  backend "s3" {
    bucket = "terraform-prabhu"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}