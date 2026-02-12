
import pandas as pd
from sqlalchemy import create_engine

file_path = 'C:/project 2/marketing_AB.csv'
df = pd.read_csv(file_path)
df.columns = [c.replace(' ', '_').lower() for c in df.columns]
df = df.rename(columns={'unnamed:_0': 'index_id'})
conn_string = 'postgresql://neondb_owner:npg_hEqv3LJi1fCy@ep-crimson-bar-ah8sqxll-pooler.c-3.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require' 
 
try:
    engine = create_engine(conn_string)
    df.to_sql('marketing_ab', engine, if_exists='replace', index=False)
    print("fayno")
except Exception as e:
    print(f"anti_fayno{e}")