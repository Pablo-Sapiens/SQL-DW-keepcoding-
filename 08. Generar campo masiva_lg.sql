CREATE OR REPLACE TABLE keepcoding.masiva_field
AS 
SELECT 
ivr_id,

MAX(IF(module_name = 'AVERIA_MASIVA', 1, 0)) AS masiva_lg

FROM `keepcoding.ivr_modules`
GROUP BY ivr_id
ORDER BY ivr_id