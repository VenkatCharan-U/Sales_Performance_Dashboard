/*
=================================================================
PROJECT   : Sales Performance Analysis
DATABASE  : sales_performance
TABLE     : sales_data
AUTHOR    : Venkat Charan Upparam
DIALECT   : MySQL 8.0+
=================================================================
*/

/* PURPOSE
   Contains sales, profitability, discount, customer, and product analysis.
*/

/* ============================================================
   06. SALES ANALYSIS
   ============================================================ */


-- 06.1 Total Sales
select
	sum(sales) as total_sales
from sales_data;


-- 06.2 Average Sales per Record
select 
	avg(sales) as average_sales
from sales_data;


-- 06.3 Minimum and Maximum Sales
select 
	min(sales) as minimum_sales,
    max(sales) as maximum_sales
from sales_data;


-- 06.4 Total Sales by Category
select 
	category,
    sum(sales) as total_sales
from sales_data
group by category
order by total_sales desc;


-- 06.5 Total Sales by Sub-category
select 
	sub_category,
    sum(sales) as total_sales
from sales_data
group by sub_category
order by total_sales desc;


-- 06.6 Total Sales by Region
select
	region,
    sum(sales) as total_sales
from sales_data
group by region
order by total_sales desc;


-- 06.7 Total Sales by Segment
select
	segment,
    sum(sales) as total_sales
from sales_data
group by segment
order by total_sales desc;


-- 06.8 Total Sales by Year
select
	year,
    sum(sales) as total_sales
from sales_data
group by year
order by year;


-- 06.9 Total Sales by Month
select
	month,
    month_name,
    sum(sales) as total_sales
from sales_data
group by month, month_name
order by month;


-- 06.10 Top 10 products by sales
select
	product_id,
    product_name,
    sum(sales) as total_sales
from sales_data
group by product_id, product_name
order by total_sales desc
limit 10;


-- 06.11 Top 10 Customers by sales
select
	customer_id,
    customer_name,
    sum(sales) as total_sales
from sales_data
group by customer_id, customer_name
order by total_sales desc
limit 10;

/* ============================================================
   07. PROFITABILITY ANALYSIS
   ============================================================ */
   
-- 07.1 Total Profit
select
	sum(profit) as total_profit
from sales_data;


-- 07.2 Average Profit per Record
select
	avg(profit) as average_profit
from sales_data;


-- 07.3 Minimum and Maximum Profit
select
	min(profit) as minimum_profit,
    max(profit) as maximum_profit
from sales_data;


-- 07.4 Total Profit by Category
select
	category,
    sum(profit) as total_profit
from sales_data
group by category
order by total_profit desc;


-- 07.5 Total Profit by Sub - Category
select
	sub_category,
    sum(profit) as total_profit
from sales_data
group by sub_category
order by total_profit desc;


-- 07.6 Total Profit by Region
select
	region,
    sum(profit) as total_profit
from sales_data
group by region
order by total_profit desc;


-- 07.7 Total Profit by Segment
select
	segment,
    sum(profit) as total_profit
from sales_data
group by segment
order by total_profit desc;


-- 07.8 Total Profit by Year
select
	year,
    sum(profit) as total_profit
from sales_data
group by year
order by year;


-- 07.9 Most Profitable Products
select
	product_id,
    product_name,
    sum(profit) as total_profit
from sales_data
group by product_id, product_name
order by total_profit desc
limit 10;


-- 07.10 Most loss-making Products
select
	product_id,
    product_name,
    sum(profit) as total_profit
from sales_data
group by product_id, product_name
order by total_profit asc
limit 10;

/* ============================================================
   08. DISCOUNT & PERFORMANCE ANALYSIS
   ============================================================ */
   
-- 08.1 Average Discount
select
	avg(discount) as average_discount
from sales_data;


-- 08.2 Minimum and Maximum Discount
select 
	min(discount) as minimum_discount,
    max(discount) as maximum_discount
from sales_data;


-- 08.3 Discount Distribution
select
	discount,
    count(*) as total_records
from sales_data
group by discount
order by discount;


-- 08.4 Sales and Profit by Discount
select
	discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    avg(profit) as average_profit
from sales_data
group by discount
order by discount;


-- 08.5 Discount Performance
select 
	discount,
    count(*) as total_records,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from sales_data
group by discount
order by total_profit desc;


-- 08.6 Discount by Category
select 
	category,
    avg(discount) as average_discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from sales_data
group by category
order by total_profit desc;


-- 08.7 Discount by Sub-category
select 
	sub_category,
    avg(discount) as average_discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from sales_data
group by sub_category
order by total_profit desc;


-- 08.8 Discount by Region
select 
	region,
    avg(discount) as average_discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from sales_data
group by region
order by total_profit desc;


-- 08.9 Discount by Segment
select
	segment,
    avg(discount) as average_discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from sales_data
group by segment
order by total_profit desc;


-- 08.10 High Discount and loss-making records
select
	product_id,
    product_name,
    category,
    sub_category,
    discount,
    sales,
    profit
from sales_data
where discount >= 0.5
	and profit < 0
order by profit asc;


-- 08.11 Products with Highest discounts
select 
	product_id,
    product_name,
    category,
    sub_category,
    discount,
    sales,
    profit
from sales_data
order by discount desc
limit 10;


-- 08.12 Most Loss-Making Discounts
select
	discount,
    count(*) as total_records,
    sum(sales) as total_sales,
    sum(profit) as total_profit
from sales_data
where profit < 0
group by discount
order by total_profit desc;


-- 08.13 Profit Margin by Discount level
select 
	discount,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100
	) as profit_margin_percentage
from sales_data
group by discount
order by discount;


-- 08.14 Overall Profit Margin
select
	round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as overall_profit_margin_percentage
from sales_data;


-- 08.15 High Discount vs Low Discount Performance
select 
	case
		when discount = 0 then 'No Discount'
        when discount <= 0.20 then 'Low Discount'
        when discount <= 0.40 then 'Medium Discount'
        else 'High Discount'
	end as discount_category,
    
    count(*) as total_records,
    sum(sales) as total_sales,
    sum(profit) as total_profit,
    
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100
    ) as profit_margin_percentage
    
from sales_data

group by 
	case
		when discount = 0 then 'No Discount'
        when discount <= 0.20 then 'Low Discount'
        when discount <= 0.40 then 'Medium Discount'
        else 'High Discount'
	end 

order by total_profit desc;

/* ============================================================
   09. CUSTOMER ANALYSIS
   ============================================================ */
   
   
-- 09.1 Total Customers
select
	count(distinct customer_id) as total_customers
from sales_data;


-- 09.2 Average Sales Per Customer
select
	round(sum(sales) / count(distinct customer_id), 2) as average_sales_per_customer
from sales_data;


-- 09.3 Total Sales by Customer
select
	customer_id,
    customer_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by customer_id, customer_name
order by total_sales desc;


-- 09.4 Top 10 Customers by sales
select 
	customer_id,
    customer_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by customer_id, customer_name
order by total_sales desc
limit 10;


-- 09.5 Total Profit by Customer
select
	customer_id,
    customer_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by customer_id, customer_name
order by total_profit desc;


-- 09.6 Top 10 Customers by Profit
select 
	customer_id,
    customer_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by customer_id, customer_name
order by total_profit desc
limit 10;


-- 09.7 Loss-Making Customers
select
	customer_id,
    customer_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by customer_id, customer_name
having sum(profit) < 0
order by total_profit asc;


-- 09.8 Customer Profit Margin
select
	customer_id,
    customer_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by customer_id, customer_name
order by profit_margin_percentage desc;


-- 09.9 Customer Performance by Segment
select
	segment,
    count(distinct customer_id) as total_customers,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by segment
order by total_profit desc;


-- 09.10 Most Valuable Customers
select
	customer_id,
    customer_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by customer_id, customer_name
having sum(profit) > 0
order by total_profit desc
limit 10;

/* ============================================================
   10. PRODUCT ANALYSIS
   ============================================================ */
   
-- 10.1 Total Products
select 
	count(distinct product_id) as total_products
from sales_data;


-- 10.2 Total Sales by Product
select
	product_id,
    product_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by product_id, product_name
order by total_sales desc;
   
   
-- 10.3 Top 10 Products by Sales
select
	product_id,
    product_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by product_id, product_name
order by total_sales desc
limit 10;


-- 10.4 Total Profit by Product
select
	product_id,
    product_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by product_id, product_name
order by total_profit desc;


-- 10.5 Top 10 Products by Profit
select
	product_id,
    product_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by product_id, product_name
order by total_profit desc
limit 10;

-- 10.6 Loss-Making Products
select
	product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by product_id, product_name
having sum(profit) < 0
order by total_profit asc;


-- 10.7 Top 10 Loss-Making products
select
	product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by product_id, product_name
having sum(profit) < 0
order by total_profit asc
limit 10;
   
   
-- 10.8 Product Profit Margin
select
	product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by product_id, product_name
order by profit_margin_percentage desc;


-- 10.9 Top 10 Products by Profit Margin
select
	product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by product_id, product_name
order by profit_margin_percentage desc
limit 10;


-- 10.10 Product Performance by Category
select
	category,
    count(distinct product_id) as total_products,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by category
order by total_sales desc;


-- 10.11 Top Product in Each Category
with product_sales as (
	select
		category,
        product_id,
        product_name,
        round(sum(sales), 2) as total_sales
	from sales_data
    group by category, product_id, product_name
),
ranked_products as (
	select
		category,
        product_id,
        product_name,
        total_sales,
        rank() over(
			partition by category
            order by total_sales desc
        ) as product_rank
	from product_sales
)
select
	category,
    product_id,
    product_name,
    total_sales
from ranked_products
where product_rank = 1
order by category;


-- 10.12 Product Analysis Summary
select
	count(distinct product_id) as total_products,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage,
    count(distinct case
		when profit < 0 then product_id
    end) as products_with_loss
from sales_data;

/* ============================================================
   END OF SCRIPT
   ============================================================ */
