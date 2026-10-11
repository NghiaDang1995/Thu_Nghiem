
create table gold.dim_product as
with unique_product as 
(select distinct product_id,
				product_category,
				unit_price
from silver.sales_transaction				)
select 	row_number() over ( order by product_id asc ) as "index",
		product_id,
		product_category,
		unit_price
from unique_product