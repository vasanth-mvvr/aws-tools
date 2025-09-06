variable "project_name" {
  default = "jenkins"
}

variable "common_tags" {
  type = map
  default = {
    name = "jenkins"
    Jenkins = "true"
  }
}

variable "zone_name" {
  default = "vasanthreddy.space"
}