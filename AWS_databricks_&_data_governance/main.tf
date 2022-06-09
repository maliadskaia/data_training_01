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

# --------- lambda ---------
data "aws_lambda_code_signing_config" "existing_csc" {
  arn = "arn:aws:lambda:us-east-1:390148573654:function:datatraining-separate-due-to-file-format"
}
