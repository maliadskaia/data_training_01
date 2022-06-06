# data_training_01
AWS databricks &amp; data governance

AWS databricks & data governance intro

Overall architecture
(see this image to zoom in) 

Input data
The input data format should be downloaded from here. It’s monthly NYC yellow taxi data. Every month is either in CSV or Parquet format.
The input data dictionary can be found here.

Databricks 
Pipeline description
A single input S3 bucket should be created for all input files. 

AWS lambda should be created to move or copy every file uploaded to an input bucket to separate buckets/folders based on the file format. 

Above buckets (+ output buckets) should be mounted to the databricks workspace.

Databricks scheduled job with at least two tasks (raw-to-structured, structured-to-canonical) should be created to run for every N minutes/hours. 

raw-to-structured reads both CSV and Parquet files from respective buckets/folders. Then it should append rows to a single structured delta table. It should be incremental and only process new files (incremental loading). 

For example, you upload a single file and it is processed by the pipeline. Then you upload two more files. Then next pipeline run picks these two files and these two files only.

Structured-to-canonical reads the output of the previous job, also incrementally. Then it maintains the following canonical tables: 

Monthly report on the number of trips, total amount charged, and total tips.

Month
Total trips
Total charged
Total tips
2020-01
2059
56181$
1151$



Trips started per hour of the day. E.g: 
Hour
Total trips count
0
51415
…
…
23
4141


Average tip amount per day of the week, e.g: 
Day of week
Avg tip amount
Monday
5$
…
…
Sunday
0.2$


Data quality issues, e.g: 
File name
Failed validations
yellow_tripdata_2020-07.csv
[  “invalid_passanger_count”  ]


Data quality checks
Perform following data quality checks: 
There should not be 0 passengers in a taxi ride.
Pickup time should not be > drop-off time. 
Rows that fail validations are not included in the canonical table calculations. 
Information about failed validations is persisted in the “Data quality issues” canonical table.
Pipeline testing 
Unit tests 
Write at least a single unit test for spark code.
Databricks testing
Initially, process a single file from 2018. A file from 2018 has fewer fields than the newer files. Then note the delta table schema and test how schema evolution works as you process newer files.
You can upload an arbitrary number of files for every subsequent run, but upload older files first, e.g: 
2019-01 -> 2019-02 -> 2019-03 -> … 

Technical requirements 
Databricks runtime
Use 10.4 LTS.
Delta tables
All delta tables should be registered in metastore and visible in workspaces data (see below screenshot).  
But they shouldn’t be created manually, jobs have to register them automatically.

Project deployment from local machine 
Use Databricks API or databricks CLI or DBX to create deployment scripts. You should be able to run one or two commands in your terminal to create and run the entire pipeline (job with multiple tasks). No manual cluster creation/edits, no manual job creation.
Also, if you go with DBX option, no need for CI/CD (thought you can play around with it as well if you find it interesting and have capacity to do so).
Project structure
You can use any language of your choice. Also, you can (and likely should) use databricks notebooks for development. 
But a final project should be a non-notebook structured project, committed to a repository of your choice. Gradle/Scala/dbx example: 


Databricks tips 
You might find these concepts useful: 
https://databricks.com/blog/2019/09/24/diving-into-delta-lake-schema-enforcement-evolution.html#:~:text=Schema%20evolution%20is%20a%20feature,one%20or%20more%20new%20columns. 
https://docs.databricks.com/ingestion/auto-loader/index.html 
https://databricks.com/blog/2017/05/22/running-streaming-jobs-day-10x-cost-savings.html 
https://docs.databricks.com/delta/delta-update.html 
https://databricks.com/blog/2022/02/04/saving-time-and-costs-with-cluster-reuse-in-databricks-jobs.html 
But you are free to use any techniques to get the job done!
Data governance (dictionary, lineage, etc)
That’s the creative part! 
Watch the first 10 minutes of Amundsen: A Data Discovery Platform From Lyft | Lyft 

Watch Observability for Data Pipelines With OpenLineage

Implement Data Dictionary and/or Data Lineage for the above pipeline. Partial implementation, e.g only for some tables and only for a few columns is fine! Don’t worry about documentation of every single column, this task is meant to bring up a conceptual discussion and not make you bored!
 
You can use any tool/approach you like.  An idea: EC2 hosted Marquez from the above video.

