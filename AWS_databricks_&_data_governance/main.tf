# --------- s3 ---------
resource "aws_s3_bucket" "datatraining_bucket_allinputs" {
  bucket = "datatraining-all-inputs"
  tags   = var.common_tags
}

resource "aws_s3_bucket" "datatraining_bucket_csv" {
  bucket = "datatraining-csv"
  tags   = var.common_tags
}

resource "aws_s3_bucket" "datatraining_bucket_parquet" {
  bucket = "datatraining-parquet"
  tags   = var.common_tags
}
