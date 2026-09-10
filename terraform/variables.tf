variable "environment" {
  type = string
}

variable "frontend_host_port" {
  type = number
}

variable "backend_host_port" {
  type = number
}

variable "network_name" {
  type    = string
  default = "fa1-network"
}