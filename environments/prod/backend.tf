terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-omer-prod"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-terraform-lock-prod"
  }
}