CREATE VIEW daily_returns AS
SELECT 
	a.Date,
	(CONVERT(FLOAT,a.[Close]) - CONVERT(FLOAT,b.[CLOSE]) )/ CONVERT(FLOAT,b.[Close]) AS daily_return
FROM nvda_us_d AS a
JOIN nvda_us_d AS b 
	ON b.Date = (
		SELECT MAX(Date)
		FROM nvda_us_d
		WHERE Date<a.Date ---
	)
; 

---Identifying extreme return days 
SELECT 
	Date,
	daily_return 
FROM daily_returns
WHERE daily_return = (SELECT MAX(daily_return) AS Maximum FROM daily_returns)
	OR daily_return = (SELECT MIN(daily_return) AS Minimum FROM daily_returns)
;
