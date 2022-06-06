# --------- s3 ---------
resource "aws_s3_bucket" "bucket_all_inputs" {
  bucket = "Bucket-for-all-input-files"
  tags   = merge(var.common_tags, { Name = "Bucket-for-all-input-files" })
}
