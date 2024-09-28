CREATE OR REPLACE TABLE keepcoding.ivr_detail AS
SELECT 
  calls.ivr_id AS calls_ivr_id,
  calls.phone_number AS calls_phone_number,  -- 92 registros UNKNOWN
  calls.ivr_result AS calls_ivr_result,
  calls.vdn_label AS calls_vdn_label,
  calls.start_date AS calls_start_date,
  FORMAT_TIMESTAMP('%Y%m%d', calls.start_date)  AS calls_start_date_id,
  calls.end_date AS calls_end_date ,
  FORMAT_TIMESTAMP('%Y%m%d', calls.end_date) AS calls_end_date_id,
  calls.total_duration AS calls_total_duration ,
  calls.customer_segment AS calls_customer_segment,
  calls.ivr_language AS calls_ivr_language ,
  calls.steps_module AS calls_steps_module,
  calls.module_aggregation AS calls_module_aggregation,
  modules.module_sequece AS module_sequece,
  modules.module_name AS module_name,
  modules.module_duration AS module_duration,
  modules.module_result AS module_result,
  steps.step_sequence AS step_sequence,   -- 29.000 registros con -9999999
  steps.step_name AS step_name, -- 29.000 registros UNKNOWN
  steps.step_result AS step_result, -- -- 29.000 registros UNKNOWN
  steps.step_description_error AS step_description_error ,  -- todos 'UNKNOWN' y 'UNKNOWN ERROR'
  IF(document_type = 'DESCONOCIDO','UNKNOWN', document_type) AS steps_document_type ,  --  26.000 registros UNKNOWN
  steps.document_identification AS steps_document_identification,  -- 26.000 UNKNOWN
  steps.customer_phone AS steps_customer_phone, --27000 UNKNOWN
  steps.billing_account_id AS steps_billing_account_id  -- 27000 UNKNOWN
  
FROM `keepcoding.ivr_calls` AS calls

LEFT JOIN `keepcoding.ivr_modules` AS modules
ON calls.ivr_id = modules.ivr_id

LEFT JOIN `keepcoding.ivr_steps`  AS steps
ON modules.ivr_id = steps.ivr_id AND modules.module_sequece = steps.module_sequece

ORDER BY calls.ivr_id, modules.module_sequece





