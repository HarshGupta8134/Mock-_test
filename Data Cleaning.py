import pandas as pd
import numpy as np
df = pd.read_csv("sales_data.csv")
df.drop_duplicates(inplace=True)  
df.fillna(df.mean(), inplace=True)  
df['ProfitMargin'] = df['Category'].map({'Electronics': 0.4, 'Clothing': 0.5}) 
z_scores = (df['Sales'] - df['Sales'].mean()) / df['Sales'].std()
df = df[abs(z_scores) < 3] 
df['Month'] = pd.to_datetime(df['OrderDate']).dt.month
df['Weekday'] = pd.to_datetime(df['OrderDate']).dt.day_name()
df['CumulativeSales'] = df.groupby('Category')['Sales'].cumsum()

df['SalesGrowth'] = df['Sales'].pct_change()
df['Trend'] = np.where(df['SalesGrowth'] > 0.1, 'Growing', 
np.where(df['SalesGrowth'] < -0.1, 'Declining', 'Stable'))
mean_sales = df['Sales'].mean()
median_sales = df['Sales'].median()
variance_sales = df['Sales'].var()
correlation = df['UnitPrice'].corr(df['Quantity'])