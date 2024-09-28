CREATE OR REPLACE TABLE keepcoding.billing_acocount_field
AS
WITH ranked_rows AS (
  SELECT 
    ivr_id,
    NULLIF(billing_account_id, 'UNKNOWN') AS billing_account_id,
    ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY NULLIF(billing_account_id, 'UNKNOWN')) AS row_number
  FROM `keepcoding.ivr_steps`
  WHERE NULLIF(CAST(billing_account_id AS STRING), 'UNKNOWN') IS NOT NULL
)
SELECT 
calls.ivr_id,
ranked_rows.billing_account_id

FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN ranked_rows ON calls.ivr_id = ranked_rows.ivr_id AND ranked_rows.row_number = 1

ORDER BY ivr_id DESC


