terraform {
  backend "s3" {
    bucket = "bedrock-tfstate-ifeoluwa"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}