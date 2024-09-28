CREATE OR REPLACE TABLE keepcoding.documents_fields
AS
WITH unique_document AS (
SELECT 
ivr_id,
NULLIF(NULLIF(document_type,'UNKNOWN'),'DESCONOCIDO') AS document_type,
document_identification,
--RANK() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY document_type) AS rrank,
--DENSE_RANK() OVER (PARTITION BY CAST(ivr_id AS STRING) ORDER BY document_type) AS ddense,
--ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING)ORDER BY document_type) AS rrow

FROM `keepcoding.ivr_steps`

WHERE NULLIF(NULLIF(document_type,'UNKNOWN'),'DESCONOCIDO') IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(ivr_id AS STRING)ORDER BY document_type) = 1
)

SELECT calls.ivr_id, unique_document.document_type, unique_document.document_identification
FROM `keepcoding.ivr_calls` AS calls
LEFT JOIN unique_document ON calls.ivr_id = unique_document.ivr_id
ORDER BY unique_document.document_type DESC