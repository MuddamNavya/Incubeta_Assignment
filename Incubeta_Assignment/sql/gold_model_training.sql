CREATE OR REPLACE MODEL `retail-bqml-medallion.retail_gold.customer_segments_model`
OPTIONS(
  model_type = 'kmeans',
  num_clusters = 4,
  standardize_features = TRUE
) AS
SELECT
  amount,
  item_category
FROM `retail-bqml-medallion.retail_silver.cleaned_transactions`;