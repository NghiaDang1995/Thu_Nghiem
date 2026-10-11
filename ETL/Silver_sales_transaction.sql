
create table silver.sales_transaction as
with CTE as
(select 
	*,
	row_number () over(partition by order_id order by ingestion_at desc) as "row_number"
from bronze.sales_transaction)

select 
	"index",
	order_id,
	cast(order_date as date) as order_date,
	order_month,
	order_quarter,
	order_year,
	customer_id,
	region,
	province,
	channel,
	employee_id,
	product_id,
	product_category,
	quantity,
	unit_price,
	discount_pct,
	discount_amount,
	gross_amount,
	net_amount,
	delivery_status,
	payment_method,
	payment_status,
	ingestion_at,
	"row_number"
from CTE
where "row_number" = 1
	
	
	
	
	
	