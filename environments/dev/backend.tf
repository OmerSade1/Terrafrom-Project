terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-omer-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-terraform-lock-dev"
  }
}
