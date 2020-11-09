variable "ibmcloud_api_key" {}

variable "region" {}

variable "ibmcloud_timeout" {
  default = 900
}

variable "resource_group"{}

variable "basename" {
}

variable "tags" {
  default = ["terraform", "cos"]
}
