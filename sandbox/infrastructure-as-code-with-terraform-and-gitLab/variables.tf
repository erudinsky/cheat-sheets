variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "prefix" {
  type    = string
  default = "cochlea"
}

variable "cidr" {
  type    = string
  default = "10.6.0.0/16"
}

variable "cidr_subnet_bastion" {
  type    = string
  default = "10.6.0.0/24"

}

variable "cidr_subnet_prod" {
  type    = string
  default = "10.6.10.0/24"
}