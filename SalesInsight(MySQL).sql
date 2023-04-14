SELECT * FROM sales.transactions WHERE sales_amount >= 0;

SELECT market_code, COUNT(*) TotalTransactions, SUM(sales_amount) TotalSales FROM sales.transactions WHERE sales_amount >= 0 GROUP BY market_code; 

/* Join tables */
SELECT * FROM sales.transactions 
FULL JOIN sales.markets
ON market_code = market_code;
-- WHERE market_code = 'Mark001' AND zone <> '';

   /* Insights on 2020 sales */
   
SELECT COUNT(*) FROM sales.date AS JustYear 
 WHERE year = 2020;
 
 -- Both syntax output similar result but perform one is more efficient
 
 SELECT count(*) FROM 
 (SELECT * FROM sales.date
 WHERE year = 2020
 ) AS Der;
 
/* Insights on merged tables */
SELECT Mk.markets_name, Dt.year, SUM(Tr.sales_amount) TotalSales, ROUND(AVG(Tr.sales_amount), 2) AverageSales, COUNT(Pr.product_type) ProductsCount
FROM sales.transactions AS Tr
INNER JOIN  sales.date AS Dt
 ON Tr.order_date = Dt.date
INNER JOIN sales.markets AS Mk
 ON Tr.market_code = Mk.markets_code
INNER JOIN sales.products AS Pr
 ON Tr.product_code = Pr.product_code
GROUP BY Mk.markets_name, Dt.year
ORDER BY Dt.year, Mk.markets_name;


/* Insights on Markets */
SELECT COUNT(markets_name), markets_name FROM sales.markets
GROUP BY markets_name;
SELECT * FROM sales.markets WHERE markets_name = 'Bhopal';
 
 
 
