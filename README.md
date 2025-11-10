Goodbye DynamoDB — Terraform S3 Backend Now Supports Native Locking



#https://rafaelmedeiros94.medium.com/goodbye-dynamodb-terraform-s3-backend-now-supports-native-locking-06f74037ad39
#https://medium.com/aws-specialists/dynamodb-not-needed-for-terraform-state-locking-in-s3-anymore-29a8054fc0e9

Here is the Terraform code:
terraform {
  required_version = "~> 1.11.0"

  backend "s3" {
    bucket       = "s3-native-lock-setup"
    key          = "backend/terraform.tfstate"
    region       = "eu-north-1"
    profile      = "ProfileForAccount-12345678910"
    use_lockfile = true
  }
}


terraform {  
  backend "s3" {  
    bucket       = "your-terraform-state-bucket"  
    key          = "path/to/your/statefile.tfstate"  
    region       = "us-east-1"  
    encrypt      = true  
    use_lockfile = true  #S3 native locking
  }  
}
