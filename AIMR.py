from statsmodels.tsa.arima.model import ARIMA

monthly_sales = df.groupby('Month')['Sales'].sum()
model = ARIMA(monthly_sales, order=(1, 1, 1))
fit_model = model.fit()
forecast = fit_model.forecast(steps=12)
print(forecast)
