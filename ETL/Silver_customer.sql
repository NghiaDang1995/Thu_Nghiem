



create table silver.customer as
with CTE as (
select *,
		row_number () over (partition by customer_id order by ingestion_at desc) as "row_number"
from bronze.customer)
select 
	"index",
	customer_id,
	customer_name,
	customer_type,
	channel,
	province,
	region,
	address,
	-- 1. Chuyển phone thành VARCHAR và thêm số '0' ở đầu nếu thiếu (giả định chuẩn 10 chữ số)
   '0' || cast(phone as varchar) as phone,
    -- 2. Chuyển tax_code thành VARCHAR, nếu NULL thì giữ nguyên NULL, tránh lỗi float
    CAST(tax_code AS VARCHAR) AS tax_code,
    -- 3. Chuyển join_date sang kiểu DATE
    CAST(join_date AS DATE) AS join_date,
    credit_limit,
    status,
    ingestion_at,
    "row_number"
from CTE 
where "row_number" = 1 

