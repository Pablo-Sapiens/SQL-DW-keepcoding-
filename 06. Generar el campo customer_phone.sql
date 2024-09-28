CREATE OR REPLACE TABLE keepcoding.customer_phone_field
AS
SELECT 
calls.ivr_id,
steps.customer_phone

FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN `keepcoding.ivr_steps` AS steps ON calls.ivr_id = steps.ivr_id AND customer_phone != 'UNKNOWN'
ORDER BY customer_phone DESC
