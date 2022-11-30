variable "pg_user" {
  default = "pgadmin"
  description = "the default user name from the postgresql database"
}

variable "pg_password" {
  description = "the password for the postgres database"
  sensitive = true
}