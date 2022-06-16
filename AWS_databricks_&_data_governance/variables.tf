variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner   = "Nastya"
    Project = "AWS_databricks__data_governance"
  }
}

variable "region" {
  description = "AWS Region"
  default     = "us-west-1"
}
