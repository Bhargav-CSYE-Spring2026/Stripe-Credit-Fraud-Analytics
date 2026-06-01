import pandas as pd
from google.cloud import bigquery
import os

PROJECT_ID = "stripe-fraud-analytics"
DATASET    = "raw"
TABLE      = "transactions"
CSV_PATH   = r"C:\Users\bharg\Downloads\creditcard\creditcard.csv"
KEY_PATH   = os.path.join(os.path.dirname(__file__), "..", "gcp-key.json")

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.path.abspath(KEY_PATH)

print("Loading CSV...")
df = pd.read_csv(CSV_PATH)

df.columns = [c.lower() for c in df.columns]

print(f"Shape: {df.shape}")
print(f"Columns: {list(df.columns)}")
print(f"Fraud cases: {df['class'].sum()} out of {len(df)} rows")

client = bigquery.Client(project=PROJECT_ID)

table_id = f"{PROJECT_ID}.{DATASET}.{TABLE}"

job_config = bigquery.LoadJobConfig(
    write_disposition="WRITE_TRUNCATE",
    autodetect=True,
)

print(f"Uploading to {table_id}...")
job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
job.result()

table = client.get_table(table_id)
print(f"Done. {table.num_rows} rows loaded to {table_id}")
