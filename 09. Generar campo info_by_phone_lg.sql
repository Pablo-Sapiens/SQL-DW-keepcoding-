CREATE OR REPLACE TABLE keepcoding.phone_field
AS
SELECT 
ivr_id,
MAX(CASE WHEN
step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK' THEN 1
ELSE 0
END) AS info_by_phone_lg
FROM `keepcoding.ivr_steps` AS steps

GROUP BY ivr_id
ORDER BY info_by_phone_lg ASC

