variable "region" {
  description = "The region all AWS resources exist"
  type = string
}

variable "access_key" {
  description = "The access key of CLI service"
  type = string
}   

variable "secret_key" {
  description = "The secret key of CLI service"
  type = string
}

variable "azs" {
  description = "The availability zone for resources to span across"
  type = list(string)
}

# End of variable - provider section

variable "namespace" {
    description = "The default name for unique naming resources"
    type = string
}

variable "vpc_cidr" {
    description = "The vpc IP CIDR"
    type = string
    default = "10.0.0.0/16"
}

# End of VPC variable

variable "public_subnet_cidr" {
  description = "The value of CIDR of the subnet - public"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  description = "The value of CIDR of the subnet - private"
  type = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidr" {
  description = "The value of CIDR of the subnet - database"
  type = list(string)
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}