# data_training_01
AWS databricks & data governance

Input data
The input data is monthly NYC yellow taxi data. Every month is either in CSV or Parquet format.
The input data dictionary: https://www1.nyc.gov/assets/tlc/downloads/pdf/data_dictionary_trip_records_yellow.pdf.


## Databricks 
### Pipeline description

a) A single input S3 bucket should be created for all input files. 

b) AWS lambda should be created to move or copy every file uploaded to an input bucket to separate buckets/folders based on the file format. 

c) Above buckets (+ output buckets) should be mounted to the databricks workspace.

d) Databricks scheduled job with at least two tasks (raw-to-structured, structured-to-canonical) should be created to run for every N minutes/hours. 

  - raw-to-structured reads both CSV and Parquet files from respective buckets/folders. Then it should append rows to a single structured delta table. It should be incremental and only process new files (incremental loading). 
    
    - For example, you upload a single file and it is processed by the pipeline. Then you upload two more files. Then next pipeline run picks these two files and these two files only.
  
  - Structured-to-canonical reads the output of the previous job, also incrementally. Then it maintains the following canonical tables: 

    - Monthly report on the number of trips, total amount charged, and total tips.
