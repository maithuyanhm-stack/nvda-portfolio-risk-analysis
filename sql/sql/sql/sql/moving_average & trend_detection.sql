---7 days moving average 
CREATE VIEW MA_7 AS
SELECT 
	a.Date,
	(SELECT AVG(CONVERT(FLOAT,b.[Close]))
	 FROM nvda_us_d AS b
	 WHERE b.date <= a.Date
		AND b.Date > DATEADD(DAY, -7, a.Date)
		) AS ma_7
FROM nvda_us_d AS a
;

---20 days moving average 
CREATE VIEW MA_20 AS
SELECT 
	a.Date,
	(SELECT AVG(CONVERT(FLOAT,b.[Close]))
	 FROM nvda_us_d AS b
	 WHERE b.date <= a.Date
		AND b.Date > DATEADD(DAY, -20, a.Date)
		) AS ma_20
FROM nvda_us_d AS a
;



---Compare MA7 & MA20
SELECT
	n.Date,
	m7.ma_7,
	m20.ma_20,
	CASE
		WHEN m7.ma_7 > m20.ma_20 THEN 'Uptrend'
		WHEN m7.ma_7 < m20.ma_20 THEN 'Downtrend'
		ELSE 'Sideways'
	END AS trend
FROM nvda_us_d AS n
JOIN MA_7 AS m7 
	ON n.date = m7.Date
JOIN MA_20 AS m20
	ON n.Date = m20.Date
;

--- Trend detection (7 days moving average)
 SELECT 
	n.Date,
	m.ma_7,
	CONVERT(FLOAT, n.[Close]) AS Close_price,
	CASE
		WHEN CONVERT(FLOAT, n.[Close])> m.ma_7 THEN 'Uptrend'
		WHEN CONVERT(FLOAT, n.[Close])<m.ma_7 THEN 'Downtrend'
		ELSE 'Neutral'
	END AS trend
FROM nvda_us_d AS n
JOIN MA_7 AS m
	ON n.Date = m.Date
ORDER BY n.Date
;

--- Trend detection (20 days moving average)
SELECT 
	n.Date,
	CONVERT(FLOAT, n.[Close]) AS Close_price,
	m.ma_20,
	CASE
		WHEN CONVERT(FLOAT, n.[Close])> m.ma_20 THEN 'Uptrend'
		WHEN CONVERT(FLOAT, n.[Close])< m.ma_20 THEN 'Downtrend'
		ELSE 'Neutral'
	END AS trend
FROM nvda_us_d AS n
JOIN MA_20 AS m
	ON n.Date = m.Date
ORDER BY n.Date
;
