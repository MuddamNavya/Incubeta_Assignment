# Pipeline Orchestration for Production

In a production environment, I would orchestrate the pipeline so that each layer runs in sequence. The raw transaction file would first be ingested into the Bronze layer (`retail_bronze.raw_transactions`). After the ingestion completes successfully, the Silver transformation process would run to perform data cleansing, type casting, null handling, filtering invalid transactions, and creating the `days_to_first_purchase` feature. Once the Silver layer is refreshed, the Gold layer would train the BigQuery ML K-Means model and generate customer segmentation predictions in the final analytics table.

For a simple implementation, I would use BigQuery Scheduled Queries to automate the execution of the SQL scripts. For a more scalable and maintainable solution, I would use Dataform because it provides dependency management, version control integration, and workflow orchestration for BigQuery transformations. I would also implement basic monitoring and data quality checks, such as row count validation, null checks, and job failure alerts, to ensure the reliability of the pipeline.

## Implementation Steps Followed

1. Uploaded `raw_transactions_10000.csv` into BigQuery and created the Bronze table:
   - `retail_bronze.raw_transactions`

2. Created the Silver layer transformation using `sql/silver_transform.sql`:
   - Converted date fields to DATE data types
   - Handled missing values using `COALESCE`
   - Defaulted missing `is_returned` values to `FALSE`
   - Filtered invalid transactions where `amount <= 0`
   - Created the `days_to_first_purchase` feature
   - Generated the output table: `retail_silver.cleaned_transactions`

3. Trained a BigQuery ML K-Means clustering model using `sql/gold_model_training.sql`:
   - Model: `retail_gold.customer_segments_model`
   - Features used: `amount` and `item_category`

4. Generated customer segmentation predictions using `ML.PREDICT()` in `sql/gold_prediction.sql`

5. Created the final Gold layer analytics table:
   - `retail_gold.analytics_customer_segments`