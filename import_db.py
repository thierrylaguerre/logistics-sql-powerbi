import pandas as pd
import sqlite3

conn = sqlite3.connect('logistics.db')

fichiers = [
    'delivery_events', 'driver_monthly_metrics', 'drivers',
    'facilities', 'fuel_purchases', 'loads', 'maintenance_records',
    'routes', 'safety_incidents', 'trailers', 'trips',
    'truck_utilization_metrics', 'trucks', 'customers'
]

for f in fichiers:
    df = pd.read_csv(f'{f}.csv')
    df.to_sql(f, conn, if_exists='replace', index=False)
    print(f'{f} importé — {len(df)} lignes')

conn.close()
print('Base logistics.db créée !')