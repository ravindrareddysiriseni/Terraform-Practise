terraform {
  backend "s3" {
    bucket = "raviterraformbucket"
    key    = "remotestate.tf"
    region = "us-east-1"
    dynamodb_table = "devopsbs1-terraform-state-lock"
    encrypt        = true

  }
}
