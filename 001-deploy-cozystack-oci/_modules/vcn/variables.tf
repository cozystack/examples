variable "name" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "dns_label" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr_block = string
  }))
  default = {}
}

variable "vlans" {
  type = map(object({
    cidr_block = string
    nsg_ids    = optional(list(string))
  }))
  default = {}
}
