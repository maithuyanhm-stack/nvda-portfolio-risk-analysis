---By day
---Daily volatility 
SELECT 
	STDEV(daily_return) AS volatility
FROM daily_returns
;

---Annualized volatility
SELECT
	STDEV(daily_return)*SQRT(252) AS annualized_volatility
FROM daily_returns
;

---By month
---Monthly volatility 
SELECT
	MONTH(Date) AS month,
	STDEV(daily_return) AS volatility
FROM daily_returns
GROUP BY MONTH(Date)
;
---Max and Min volatility of month 
SELECT 
	*
FROM monthly_vol
WHERE volatility = (SELECT MAX(volatility) AS Maximum_vol FROM monthly_vol)
	OR volatility = (SELECT MIN(volatility) AS Minimum_vol FROM monthly_vol)
;
---Annualized volatility
SELECT
	MONTH(Date) AS month,
	STDEV(daily_return)*SQRT(252) AS annualized_volatility
FROM daily_returns
GROUP BY MONTH(Date)
;
