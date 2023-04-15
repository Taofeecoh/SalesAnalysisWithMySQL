SELECT * FROM sales.transactions;
SELECT COUNT(*) FROM sales.transactions WHERE sales_amount <= 0;

-- Removing non relevant values from table
DELETE FROM sales.transactions
WHERE sales_amount = 0;

-- Exploring duplicate values using the 'currency' column
SELECT DISTINCT(currency) FROM sales.transactions;
SELECT COUNT(*) FROM sales.transactions WHERE currency = 'INR';
SELECT COUNT(*) FROM sales.transactions WHERE currency = 'INR\r';
SELECT COUNT(*) FROM sales.transactions WHERE currency = 'USD';
SELECT COUNT(*) FROM sales.transactions WHERE currency = 'USD\r';

-- Update table, replace vlaues with necesaary ones
UPDATE sales.transactions 
SET currency = 'INR' WHERE currency = 'INR\r';

UPDATE sales.transactions 
SET currency = 'USD' WHERE currency = 'USD\r'; 

-- Convert different currency to the exchange rate for the exact year
SELECT * FROM sales.transactions WHERE currency = 'USD';
UPDATE sales.transactions
SET sales_amount = (sales_amount * 75) WHERE currency = 'USD' AND order_date LIKE '2017%';

-- After converting to the current rate, set the currency value to the useful
UPDATE sales.transactions 
SET currency = 'INR' WHERE currency = 'USD'; 

/* Alternatively, this could be performed using the unique identifier of this table, but this table doesn't have.
Another method would be to use Subquery with all the useful columns in this table
*/

-- Using Subquery
SELECT COUNT(*) FROM 
(
	SELECT product_code, customer_code, market_code, order_date, sales_qty, sales_amount, COUNT(*)
    FROM sales.transactions
    GROUP BY product_code, customer_code, market_code, order_date, sales_qty, sales_amount
    HAVING COUNT(*) > 1
    -- ORDER BY product_code, order_date DESC
) AS DerivedDuplicate;

SELECT * FROM sales.transactions;