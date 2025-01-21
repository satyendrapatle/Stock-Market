# Stock Market Analysis - KPIs

Use stock_analysis;
#1)Average Daily Trading Volume
SELECT 
    Ticker,
    CONCAT(ROUND(AVG(Volume) / 1000), ' K') AS Avg_Daily_Volume
FROM
    stock_data
GROUP BY Ticker
ORDER BY ticker;

#2)Most Volatile Stocks
SELECT 
    Ticker, ROUND(SUM(Beta)) AS Total_Beta
FROM
    stock_data
GROUP BY ticker
ORDER BY Total_beta DESC
LIMIT 1;

#3)Stocks with Highest Dividend and Lowest Dividend
with cte as
(Select
Ticker, sum(Dividend_Amount) as Highest_Dividend,
Rank() over (Order by sum(Dividend_Amount) desc) as RN
from stock_data
group by Ticker)
SELECT 
    Ticker, Highest_Dividend
FROM
    cte
WHERE
    RN = 1;
    
with cte as
(Select
Ticker, sum(Dividend_Amount) as Lowest_Dividend,
Rank() over (Order by sum(Dividend_Amount)) as RN
from stock_data
group by Ticker)
SELECT 
    Ticker, Lowest_Dividend
FROM
    cte
WHERE
    RN = 1;

#4)Highest and Lowest P/E Ratios
with cte as
(Select
Ticker, round(avg(PE_Ratio),2) as PE,
Rank() over (Order by avg(PE_Ratio) desc) as RN
from stock_data
group by Ticker)
SELECT 
    Ticker, PE as High_PE
FROM
    cte
WHERE
    RN = 1;
    
with cte as
(Select
Ticker, round(avg(PE_Ratio),2) as PE,
Rank() over (Order by avg(PE_Ratio)) as RN
from stock_data
group by Ticker)
SELECT 
    Ticker, PE as Low_PE
FROM
    cte
WHERE
    RN = 1;

#5)Stocks with Highest Market Cap
with cte as
(Select
Ticker, sum(Market_Cap) as Market_Cap,
Rank() over (Order by sum(Market_Cap) desc) as RN
from stock_data
group by Ticker)
SELECT 
    Ticker, Market_Cap
FROM
    cte
WHERE
    RN = 1;

#6)Stocks Near 52 Week High
SELECT 
    Ticker, date, Close, 52_Week_High
FROM
    stock_data
WHERE
    Close >= 52_Week_High;

#7)Stocks Near 52 Week Low
SELECT 
    Ticker, date, Close, 52_Week_Low
FROM
    stock_data
WHERE
    Close <= 52_Week_Low;

#8)Stocks with Strong Buy Signals and stocks with Strong Selling Signal
SELECT 
    Ticker,
    close,
    macd,
    CASE
        WHEN macd > 0 THEN 'Strong Buy Signal'
        ELSE 'Strong Selling Signal'
    END AS Category_MACD
FROM
    stock_data
LIMIT 10;

SELECT 
    Ticker,
    close,
    RSI,
    CASE
        WHEN RSI<45 then 'Strong Buy Signal'
        ELSE 'Strong Selling Signal'
    END AS Category_RSI
FROM
    stock_data
LIMIT 10;
