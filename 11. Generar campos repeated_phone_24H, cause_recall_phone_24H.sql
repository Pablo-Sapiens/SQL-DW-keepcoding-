CREATE OR REPLACE TABLE keepcoding.rep_or_cause_call_field
AS
WITH ranked_calls AS (
  SELECT 
    ivr_id,
    phone_number,
    FORMAT_TIMESTAMP('%Y%m%d', start_date) AS start_date_id,
    FORMAT_TIMESTAMP('%Y%m%d', end_date) AS end_date_id,
    start_date,
    end_date,
    
    
    ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_date) AS rrow,
    
    
    LAG(end_date, 1) OVER (PARTITION BY phone_number ORDER BY start_date) AS previous_end_date,
    
    
    LEAD(start_date, 1) OVER (PARTITION BY phone_number ORDER BY start_date) AS next_start_date

  FROM `keepcoding.ivr_calls`
  WHERE phone_number != 'UNKNOWN'
  ORDER BY phone_number
)

SELECT 
  calls.ivr_id,
  --ranked_calls.phone_number,
  --ranked_calls.start_date_id,
  --ranked_calls.end_date_id,
  --ranked_calls.rrow,

  
  CASE
    WHEN rrow = 1 THEN 0 
    WHEN TIMESTAMP_DIFF(ranked_calls.start_date, ranked_calls.previous_end_date, HOUR) <= 24 THEN 1 
    ELSE 0
  END AS repeated_phone_24H,

  
  CASE
    WHEN next_start_date IS NULL THEN 0
    --WHEN LEAD(ranked_calls.start_date, 1) OVER (PARTITION BY ranked_calls.phone_number ORDER BY ranked_calls.start_date) IS NULL THEN 0 
    WHEN TIMESTAMP_DIFF(ranked_calls.next_start_date, ranked_calls.end_date, HOUR) <= 24 THEN 1 
    ELSE 0
  END AS cause_recall_phone_24H

FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN ranked_calls ON calls.ivr_id = ranked_calls.ivr_id

ORDER BY ranked_calls.phone_number DESC;
