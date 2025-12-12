terraform {
  backend "s3" {
    bucket = "prod-terra-shobhi"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
