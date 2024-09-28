CREATE OR REPLACE TABLE keepcoding.vdn_aggregation_field
AS
WITH vdn_aggregation_cte AS (
SELECT 
  calls.ivr_id,
  CASE
    WHEN STARTS_WITH(calls.vdn_label, 'ATC') THEN 'FRONT' 
    WHEN STARTS_WITH(calls.vdn_label, 'TECH') THEN 'TECH'
    WHEN calls.vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
    ELSE 'RESTO'
  END AS vdn_aggregation
FROM `keepcoding.ivr_calls` AS calls
)

SELECT 
  calls.ivr_id,
  vdn_aggregation_cte.vdn_aggregation
FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN vdn_aggregation_cte ON calls.ivr_id = vdn_aggregation_cte.ivr_id

