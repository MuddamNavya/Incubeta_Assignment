CREATE OR REPLACE TABLE `retail-bqml-medallion.retail_silver.cleaned_transactions` AS
SELECT
  transaction_id,
  customer_id,
  COALESCE(SAFE_CAST(signup_date AS DATE), SAFE_CAST(purchase_date AS DATE)) AS signup_date,
  SAFE_CAST(purchase_date AS DATE) AS purchase_date,
  SAFE_CAST(amount AS FLOAT64) AS amount,
  item_category,
  COALESCE(SAFE_CAST(is_returned AS BOOL), FALSE) AS is_returned,
  DATE_DIFF(
    SAFE_CAST(purchase_date AS DATE),
    COALESCE(SAFE_CAST(signup_date AS DATE), SAFE_CAST(purchase_date AS DATE)),
    DAY
  ) AS days_to_first_purchase
FROM `retail-bqml-medallion.retail_bronze.raw_transactions`
WHERE SAFE_CAST(amount AS FLOAT64) > 0;