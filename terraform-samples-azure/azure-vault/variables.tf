variable "vault-rg-name" {
  type = string
}

variable "vault-name" {
  type = string
}

variable "location" {
  type = string
}

variable "key-permissions" {
  type = list(string)
}

variable "secret-permissions" {
  type = list(string)
}

variable "storage-permissions" {
  type = list(string)
}

variable "publickey-name" {
  type = string
}

variable "publickey-opts" {
  type = list(string)
}