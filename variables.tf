variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "public_subnet1_cidr" {}
variable "public_subnet2_cidr" {}
variable "public_subnet3_cidr" {}
variable "public_subnet1_name" {}
variable "public_subnet2_name" {}
variable "public_subnet3_name" {}
variable "Main_Route_Table" {}
variable "environemnt" { default = "dev" }
variable "AMIs" {
  description = "AMIs by Region"
  default = {
    us-east-1 = "xxxxx"
    us-east-2 = "xxxxx"
  }
}
variable "instance_type" {
  default = {
    dev  = "t3.micro"
    test = "t3.small"
    prod = "t2.medium"
  }

}
