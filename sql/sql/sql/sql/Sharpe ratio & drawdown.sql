---Sharpe ratio
SELECT 
	(AVG(daily_return)-0.033/252)/STDEV(daily_return) AS sharpe_ratio
FROM daily_returns
;

---Max drawdowns
CREATE VIEW cumulative_return AS 
SELECT
    a.Date,
    EXP(SUM(LOG(1 + b.daily_return))) AS portfolio_value 
FROM daily_returns AS a
JOIN daily_returns AS b
    ON b.Date <= a.Date 
GROUP BY a.Date
;

CREATE VIEW running_peak AS
SELECT
    a.Date,
    a.portfolio_value,
    (
        SELECT MAX(b.portfolio_value)
        FROM cumulative_returns AS b
        WHERE b.Date <= a.Date
    ) AS peak_value
FROM cumulative_return AS a
;

CREATE VIEW drawdowns AS
SELECT
    Date,
    (portfolio_value - peak_value) / peak_value AS drawdown
FROM running_peak
;

SELECT
    MIN(drawdown) AS max_drawdown
FROM drawdowns
;
