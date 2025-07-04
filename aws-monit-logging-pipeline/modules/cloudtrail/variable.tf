variable "trail_name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_key_prefix" {
  type    = string
  default = "cloudtrail"
}

variable "include_global_service_events" {
  type    = bool
  default = true
}