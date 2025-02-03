terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-omer-dev-v2"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-terraform-lock-dev"
  }
}
