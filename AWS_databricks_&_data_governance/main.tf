# --------- s3 ---------
resource "aws_s3_bucket" "bucket_all_inputs" {
  bucket = "data-training-bucket-for-all-input-files-databrix"
  tags   = var.common_tags
}
