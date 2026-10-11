

CREATE TABLE silver.employee AS
with CTE as (
select *,
		row_number () over (partition by employee_id order by ingestion_at desc) as "row_number"
from bronze.employee
)
select 
	"index",
	employee_id,
	full_name,
	gender,
	cast(date_of_birth as date) as date_of_birth,
	cast(join_date as date) as join_date,
	"position",
	region,
	team,
	email,
	'0' || CAST(phone AS VARCHAR) AS phone,
	status,
	"version",
	cast(effective_date as date) as effective_date,
	resign_date,
	transfer_note,
	ingestion_at,
	"row_number"
from CTE 
where "row_number" = 1 