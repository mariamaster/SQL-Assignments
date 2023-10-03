-- Assignment 5

/* Answer 1 */
USE ap;
SELECT vendor_name AS "Vendor Name", 
	COUNT(DISTINCT invoice_number) AS "No. of Invoices Due",
	CONCAT('$ ', FORMAT(SUM(invoice_total),1)) AS "Invoice Total", 
	CONCAT('$ ', FORMAT(SUM(payment_total), 1)) AS "Payment Total", 
    CONCAT('$ ', FORMAT(SUM(credit_total), 1)) AS "Credit Total", 
    CONCAT('$ ', FORMAT(SUM(invoice_total - payment_total - credit_total), 1)) AS "Unpaid Balance"
FROM vendors JOIN invoices USING(vendor_id) 
WHERE (invoice_total - payment_total - credit_total) > 0 
GROUP BY vendor_name WITH ROLLUP;
-- group by: multiple rows of invoices under 1 vendor; therefore, group by vendors
-- roll up: subtotal of the columns at the bottom

-- format: format the value to have two decimal places.


/* Answer 2 */ 
USE om;
WITH customer_shopping_stats AS (
	SELECT customer_id, -- customer id is also in orders table
		order_id,
		SUM(order_qty) AS order_qty_sum, 
		SUM(unit_price * order_qty) AS total_price
	FROM orders
		JOIN order_details USING(order_id)
        JOIN items USING(item_id)
	GROUP BY customer_id, order_id
) -- one order
SELECT 
    CONCAT(customer_first_name,' ',customer_last_name) AS "Customer Name", 
    COUNT(DISTINCT order_id) AS "No. of Orders", 
    SUM(order_qty_sum) AS "Total Ordered Quantities", -- all orders
    CONCAT('$ ', FORMAT(SUM(total_price), 2)) AS "Total Amount Spent",
    ROUND(AVG(order_qty_sum),2) AS "Average Order Quantity",  
    CONCAT('$ ', FORMAT(AVG(total_price), 2)) AS "Average Order Amount"
FROM customer_shopping_stats 
    JOIN customers USING(customer_id)
GROUP BY customer_first_name, customer_last_name
ORDER BY customer_first_name, customer_last_name;
    -- join customers table to get names of customers */
    -- CTEs: double aggregate functions in main query 
    
/* I used a CTE because of the complexity of the query. CTE creates more
	readable code, and having a CTE, it can be referenced in multiple
    places of the code, unlike subqueries that we might have to write multiple 
    times for different sections of the code. They can also be used to look through 
    nested structures, and tested separately. */
    
-- we do a double SUM because SQL otherwise wouldn't know what to do in the main query.
-- even though we do all the hard work in the cte/subquery and it gives us an answer,
-- in the main query we have to do the SUM again because SQL doesn't know what to do.