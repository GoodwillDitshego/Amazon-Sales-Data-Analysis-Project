create database amazon_project;
use amazon_project;
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/dgood/OneDrive/Documents/GitHub Projects/amazon sales project/data/amazon_sales_raw_dataset' INTO TABLE amazon_sales_dataset
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS; -- used to load data from csv into MySQL
select* from amazon_sales_dataset LIMIT 10; -- check if data has been uploaded
ALTER TABLE amazon_sales_dataset MODIFY COLUMN discount_percent double;
alter table amazon_sales_dataset modify column order_date DATE;
ALTER TABLE amazon_sales_dataset MODIFY column order_id varchar(50);
ALTER TABLE amazon_sales_dataset MODIFY COLUMN price double;
ALTER TABLE amazon_sales_dataset MODIFY COLUMN quantity_sold int;
ALTER TABLE amazon_sales_dataset MODIFY COLUMN rating double;
ALTER TABLE amazon_sales_dataset MODIFY COLUMN review_count int;
SELECT
	SUM(customer_region IS NULL) AS null_region, 
    SUM(order_id IS NULL) AS null_Oid,
    SUM(order_date IS NULL) AS null_date,
    SUM(price IS NULL) AS null_price,
    SUM(quantity_sold IS NULL) AS null_quantity,
    SUM(total_revenue IS NULL) AS null_total
FROM amazon_sales_dataset; -- This is done to search for nulls--
-- I then look for duplicates -- 
SELECT order_id, COUNT(*) FROM amazon_sales_dataset GROUP BY order_id HAVING COUNT(*) > 1;
CREATE TABLE clean_table AS (SELECT DISTINCT * FROM amazon_sales_dataset); 
DROP TABLE amazon_sales_dataset;
ALTER TABLE clean_table RENAME TO amazon_sales_dataset;
select* from amazon_sales_dataset;
SELECT* FROM amazon_sales_dataset WHERE ROUND(total_revenue, 2) != ROUND(discounted_price*quantity_sold, 2); -- LOOKING FOR LOGICAL INCONSISTENCY --
-- PERFORM SOME DISTRIBUTION AND RANGE CHECKS --
SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order FROM amazon_sales_dataset;
SELECT MIN(price), MAX(price), AVG(price), MIN(quantity_sold), MAX(quantity_sold), AVG(quantity_sold) FROM amazon_sales_dataset;
-- FIRST REAL INSIGHTS -- 
SELECT SUM(total_revenue) FROM amazon_sales_dataset;
SELECT product_category, SUM(total_revenue) AS revenue FROM amazon_sales_dataset GROUP BY product_category ORDER BY revenue DESC;
SELECT customer_region, SUM(total_revenue) AS revenue_reg FROM amazon_sales_dataset GROUP BY customer_region ORDER BY revenue_reg DESC;
SELECT payment_method, COUNT(*) AS orders, SUM(total_revenue) AS revenue FROM amazon_sales_dataset GROUP BY payment_method;
SELECT product_category, AVG(rating) AS avg_rating FROM amazon_sales_dataset GROUP BY product_category ORDER BY avg_rating DESC;
SELECT product_id, SUM(total_revenue) AS revenue FROM amazon_sales_dataset GROUP BY product_id ORDER BY revenue DESC LIMIT 10;
SELECT MONTHNAME(order_date) AS month, SUM(total_revenue) AS monthly_revenue FROM amazon_sales_dataset GROUP BY month ORDER BY monthly_revenue;
SELECT 
	ROUND(SUM(total_revenue), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT product_id) AS total_products,
    ROUND(AVG(total_revenue), 2) AS avg_order_value
FROM amazon_sales_dataset;