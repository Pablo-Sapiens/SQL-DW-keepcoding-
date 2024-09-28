CREATE OR REPLACE TABLE keepcoding.ivr_summary 
AS
SELECT 
  calls_ivr_id,
  calls_phone_number,
  calls_ivr_result,
  vdn.vdn_aggregation,
  calls_start_date,
  calls_end_date,
  calls_total_duration,
  calls_customer_segment,
  calls_ivr_language,
  COUNT(DISTINCT(step_name)) AS steps_module,
  calls_module_aggregation,
  IFNULL(documents.document_type,'UNKNOWN') AS document_type,
  IFNULL(documents.document_identification, 'UNKNOWN') AS document_identification,
  IFNULL(customer_phone.customer_phone, 'UNKNOWN') AS customer_phone,
  IFNULL(billing.billing_account_id, 'UNKNOWN') AS billing_account_id,
  masiva.masiva_lg,
  phone.info_by_phone_lg,
  dni.info_by_dni_lg,
  calltype.repeated_phone_24H,
  calltype.cause_recall_phone_24H

FROM `keepcoding.ivr_detail` AS detail

LEFT JOIN `keepcoding.vdn_aggregation_field` AS vdn
ON detail.calls_ivr_id = vdn.ivr_id

LEFT JOIN `keepcoding.documents_fields` AS documents
ON detail.calls_ivr_id = documents.ivr_id

LEFT JOIN `keepcoding.customer_phone_field` AS customer_phone
ON detail.calls_ivr_id = customer_phone.ivr_id

LEFT JOIN `keepcoding.billing_acocount_field` AS billing
ON detail.calls_ivr_id = billing.ivr_id

LEFT JOIN `keepcoding.masiva_field` AS masiva
ON detail.calls_ivr_id = masiva.ivr_id

LEFT JOIN `keepcoding.phone_field` AS phone
ON detail.calls_ivr_id = phone.ivr_id

LEFT JOIN `keepcoding.dni_field` AS dni
ON detail.calls_ivr_id = dni.ivr_id

LEFT JOIN `keepcoding.rep_or_cause_call_field` AS calltype
ON detail.calls_ivr_id = calltype.ivr_id

GROUP BY
  calls_ivr_id,
  calls_phone_number,
  calls_ivr_result,
  vdn.vdn_aggregation,
  calls_start_date,
  calls_end_date,
  calls_total_duration,
  calls_customer_segment,
  calls_ivr_language,
  calls_module_aggregation,
  documents.document_type,
  documents.document_identification,
  customer_phone,
  billing_account_id,
  masiva_lg,
  info_by_phone_lg,
  info_by_dni_lg,
  repeated_phone_24H,
  cause_recall_phone_24H
