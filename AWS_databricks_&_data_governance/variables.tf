variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner   = "Nastya"
    Project = "AWS databricks & data governance"
  }
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}
