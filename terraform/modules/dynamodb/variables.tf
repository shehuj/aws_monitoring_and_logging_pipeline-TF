variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
  default     = "id"
}

variable "tags" {
  description = "Tags to apply to DynamoDB table"
  type        = map(string)
  default     = {}
}   