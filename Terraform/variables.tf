variable "aws_region" {
  default = "us-east-1"
}

variable "my_ip" {
  description = ""
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  sensitive = true
}