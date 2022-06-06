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




### Data quality checks
#### Perform following data quality checks: 

- There should not be 0 passengers in a taxi ride.
- Pickup time should not be > drop-off time. 

Rows that fail validations are not included in the canonical table calculations.
Information about failed validations is persisted in the “Data quality issues” canonical table.




### Pipeline testing 
#### Unit tests 
Write at least a single unit test for spark code.

#### Databricks testing
Initially, process a single file from 2018. A file from 2018 has fewer fields than the newer files. Then note the delta table schema and test how schema evolution works as you process newer files.
You can upload an arbitrary number of files for every subsequent run, but upload older files first, e.g: 
2019-01 -> 2019-02 -> 2019-03 -> … 




### Technical requirements 
#### Databricks runtime
Use 10.4 LTS.
#### Delta tables
All delta tables should be registered in metastore and visible in workspaces data (see below screenshot).  
But they shouldn’t be created manually, jobs have to register them automatically.
#### Project deployment from local machine 
Use Databricks API or databricks CLI or DBX to create deployment scripts. You should be able to run one or two commands in your terminal to create and run the entire pipeline (job with multiple tasks). No manual cluster creation/edits, no manual job creation.
Also, if you go with DBX option, no need for CI/CD (thought you can play around with it as well if you find it interesting and have capacity to do so).




### Project structure
You can use any language of your choice. Also, you can (and likely should) use databricks notebooks for development. 
But a final project should be a non-notebook structured project, committed to a repository of your choice.
