CREATE OR REPLACE TABLE `retail-bqml-medallion.retail_gold.analytics_customer_segments` AS
SELECT
  *
FROM ML.PREDICT(
  MODEL `retail-bqml-medallion.retail_gold.customer_segments_model`,
  (
    SELECT
      transaction_id,
      customer_id,
      signup_date,
      purchase_date,
      amount,
      item_category,
      is_returned,
      days_to_first_purchase
    FROM `retail-bqml-medallion.retail_silver.cleaned_transactions`
  )
);