
-- 1. Tạo lại bảng dim_date với định dạng full_date là YYYY/MM/DD
CREATE TABLE IF NOT EXISTS gold.dim_date (
    date_key INT PRIMARY KEY,          -- Khóa dạng số nguyên: YYYYMMDD (VD: 20240822)
    full_date VARCHAR(10) NOT NULL,    -- Ngày dạng chuỗi 'YYYY/MM/DD'
    day INT NOT NULL,                  -- Ngày trong tháng (1-31)
    month INT NOT NULL,                -- Tháng (1-12)
    month_name VARCHAR(20) NOT NULL,   -- Tên tháng
    quarter INT NOT NULL,              -- Quý (1-4)
    year INT NOT NULL,                 -- Năm
    day_of_week INT NOT NULL,          -- Thứ trong tuần (1-7)
    day_name VARCHAR(20) NOT NULL,     -- Tên thứ
    is_weekend BOOLEAN NOT NULL        -- Cờ ngày cuối tuần
);

-- 2. Nạp dữ liệu với định dạng ngày theo ý muốn (YYYY/MM/DD)
INSERT INTO gold.dim_date (
    date_key, 
    full_date, 
    day, 
    month, 
    month_name, 
    quarter, 
    year, 
    day_of_week, 
    day_name, 
    is_weekend
)
SELECT 
    TO_CHAR(d, 'YYYYMMDD')::INT AS date_key,
    TO_CHAR(d, 'YYYY/MM/DD') AS full_date, -- Đổi dấu gạch ngang thành gạch chéo ở đây
    EXTRACT(DAY FROM d)::INT AS day,
    EXTRACT(MONTH FROM d)::INT AS month,
    TO_CHAR(d, 'Month') AS month_name,
    EXTRACT(QUARTER FROM d)::INT AS quarter,
    EXTRACT(YEAR FROM d)::INT AS year,
    EXTRACT(ISODOW FROM d)::INT AS day_of_week,
    TO_CHAR(d, 'Day') AS day_name,
    CASE 
        WHEN EXTRACT(ISODOW FROM d) IN (6, 7) THEN TRUE 
        ELSE FALSE 
    END AS is_weekend
FROM generate_series('2020-01-01'::date, '2030-12-31'::date, INTERVAL '1 day') AS t(d)
ON CONFLICT (date_key) DO NOTHING;