# --------- s3 ---------
resource "aws_s3_bucket" "datatraining_bucket_allinputs" {
  bucket = "datatraining-allinputs"
  tags   = var.common_tags
}
