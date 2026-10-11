
CREATE TABLE gold.dim_region AS
WITH unique_locations AS (
    SELECT DISTINCT 
        region,
        province
    FROM silver.sales_transaction
    WHERE region IS NOT NULL AND province IS NOT NULL
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY region, province) AS "index",
    region,
    province
FROM unique_locations;