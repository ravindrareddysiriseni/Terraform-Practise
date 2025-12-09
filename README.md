Goodbye DynamoDB — Terraform S3 Backend Now Supports Native Locking



#https://rafaelmedeiros94.medium.com/goodbye-dynamodb-terraform-s3-backend-now-supports-native-locking-06f74037ad39
#https://medium.com/aws-specialists/dynamodb-not-needed-for-terraform-state-locking-in-s3-anymore-29a8054fc0e9

S3-Native State Locking
With S3-native state locking, we no longer need DynamoDB for state locking. Instead, we use a lock file directly within the S3 bucket. This approach requires fewer resources to deploy and reduces the IAM permissions required for accessing Terraform state, as managing a DynamoDB table is no longer necessary.

This new feature simplifies the setup process for new AWS technicians, as the lock files stored in S3 will resemble local Terraform state files, making it easier to understand and manage.

#terraform init --backend-config=backend.json

Here is the Terraform code, In terraform.tf we have to add use_locfile = true.

terraform {
  backend "s3" {
    bucket = "raviterraformbucket"
    key    = "remotestate.tf"
    region = "us-east-1"
    use_lockfile = true
    encrypt        = true

  }
}


Here we are tring to apply the terraform by using terraform apply in linux machine.
<img width="783" height="548" alt="image" src="https://github.com/user-attachments/assets/e7f43fec-4ea5-4111-ae22-02eef98c0d98" />

At same time we are trying to execute terraform apply from windows machine, we are getting the state lock error. this is we are getting without using DynamoDB Lock machanism.

<img width="1853" height="798" alt="image" src="https://github.com/user-attachments/assets/3bd58ab0-da8c-4c45-9e30-a9ea5b622f6f" />


dynamodb_table = "devopsbs1-terraform-state-lock" is Depricated. Use parameter "use_lockfile" instead.
<img width="1831" height="384" alt="image" src="https://github.com/user-attachments/assets/080f9858-628b-4e7e-bba0-b674fe9f2c29" />





