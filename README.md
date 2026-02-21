# Amazon Sales Data Analysis Project
<img width="1022" height="601" alt="Dashboard_screenshot" src="https://github.com/user-attachments/assets/c5d89408-6740-48f9-8577-4b78fea4bff6" />  

## Project Overview  

Validating and analysing sales data using SQL and using Excel to build a dashboard.  
The goal of this project was to simulate a real-world scenario where sales data is cleaned, analysed, and transformed into actionable insights through a dashboard. It was done to demonstrate:  
* SQL querying, aggregation and KPI calculations
* Data Validation and cleaning
* Data Vizualisation in Excel and end-to-end analytical workflow
## Tools Used  
* **MySQL Workbench** - Data storage, validation and SQL analysis
* **Microsoft Excel** - Data visualisation and dashboard creation
* **GitHub** - Version control and project sharing
## Analysis Pipeline  
### 1. Data Loading and Validation  
Created a database and a table. Then I loaded raw sales data csv file into mySQL Workbench using this code:  
```LOAD DATA LOCAL INFILE 'inserted file path' INTO TABLE 'inserted table_name' FIELDS TERMINATED BY 'comma' ENCLOSED BY 'double qoute' LINES TERMINATED BY '/n' IGNORE 1 ROWS```   
Performed data validation to ensure no null values in critical fields, no duplicates, has correct data types and consistent formats, and ran logical checks such as ```total_revenue = discounted_price * quantity_sold```  
### 2. SQL Analysis (KPIs)  
Extracted insights using various SQL queries and the following KPIs were calculated:  
* **Total Revenue** which was at a value of **$USD 32 866 573,74**
* **Total Orders** were at **50 000**
* **Total Products** were at **4 000**
* **The Average Order Value** was **$USD 657,33**
Some other business questions that were answered using SQL include:
* Monthly revenue trends
* Total revenue by product_category
* Revenue by region
* payment_method distribuutions
* average rating by category
  
I shall attach a sample of SQL Queries below. For a full file, please find the full SQL file with all queries in the SQL files folder or download here [PROJECT QUERIES.sql](https://github.com/user-attachments/files/25427367/PROJECT.QUERIES.sql). Sample SQL queries for monthly revenue and KPIs:  
``` SELECT MONTHNAME(order_date) AS month, SUM(total_revenue) AS monthly_revenue FROM amazon_sales_dataset GROUP BY month ORDER BY monthly_revenue; ```

``` SELECT ROUND(SUM(total_revenue), 2) AS total_revenue, COUNT(DISTINCT order_id) AS total_orders, COUNT(DISTINCT product_id) AS total_products, ROUND(AVG(total_revenue), 2) AS avg_order_valueFROM amazon_sales_dataset; ```  
### 3. Excel Dashboard Creation  
Exported each query result to Excel and created:  
**Visualisations:**  
1. **Monthly Revenue** line chart which tracks revenue trends over time
2. **Revenue by category** bar chart which compares performance across product_categories
3. **Revenue by region** bar graph which gives geographic sales distribution
4. **Payment methods** doughnut chart which gives percentage breakdown of payment types  
**Dashboard features:**
* Interactive slicers
* KPI cards with key metrics
* Consistent colour scheme with a clean, professional layout
## Insights and Findings  
* Peak sales revenue was identified in January and August with the lowest sales revenue identified to be in February which was a difference of about **$USD 400 000**.
* Top-performing product category by revenue was for beauty products
* Regional markets had closely similar sales with the Middle East region having slightly higher overall revenue.
* Payment method breakdown gave most orders payed using **Wallet** as the most popular payment method among customers and the use of a **Credit card** was the least popular. The difference was not by a long way as the payment method distribution had each method having about a 20% chance of being used to pay for an order.
* The average rating by category gave an average category of about 3 for all categories with the book category having the highest rating at 3.02 and the lowest average rated category being the Beauty category at 2.99. Not much of a difference, which means customers buying beauty products are just as satisfied with their products as customers buying books.
