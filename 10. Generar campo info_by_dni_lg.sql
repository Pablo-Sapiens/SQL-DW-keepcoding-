CREATE OR REPLACE TABLE keepcoding.dni_field
AS
SELECT 
ivr_id,
MAX(CASE WHEN
step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1
ELSE 0
END) AS info_by_dni_lg
FROM `keepcoding.ivr_steps` AS steps

GROUP BY ivr_id
ORDER BY info_by_dni_lg DESC
