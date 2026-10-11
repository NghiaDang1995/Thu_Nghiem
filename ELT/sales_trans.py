import pandas as pd

from sqlalchemy import create_engine
df = pd.read_csv(r"C:\Users\DELL\Desktop\DAC K49\Sales Transaction.csv")
print(df.head())

df['ingestion_at'] = pd.Timestamp.now()
engine = create_engine('postgresql+psycopg2://postgres:1593578426@localhost:5432/postgres')
print("Connection established successfully!")

df.to_sql(
    name = 'sales_transaction',
    con = engine,
    schema = 'bronze',
    if_exists = 'append'
)