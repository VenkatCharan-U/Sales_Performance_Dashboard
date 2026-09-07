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
   Contains business-focused insights and final integrity/financial validation.
*/

/* ============================================================
   13. BUSINESS INSIGHTS
   ============================================================ */
   
-- 13.1 Most Profitable Categories
select
	category,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by category
order by total_profit desc;


-- 13.2 High Sales but Low Profit Products
select
	product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by product_name
having sum(sales) > (
	select avg(product_sales)
    from (
		select sum(sales) as product_sales
        from sales_data
        group by product_name
    ) as product_summary
)
and sum(profit) < (
	select avg(product_profit)
    from (
		select sum(profit) as product_profit
        from sales_data
        group by product_name
    ) as profit_summary
)
order by total_sales desc;


-- 13.3 Regional Business Performance
select
	region,
    count(distinct order_id) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by region
order by total_profit desc;


-- 13.4 Most Valuable Customers
select
    customer_id,
    customer_name,
    count(distinct order_id) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by customer_id, customer_name
order by total_profit desc
limit 10;


-- 13.5 Discount vs. Profit Analysis
select
	round(discount * 100, 0) as discount_percentage,
    count(*) as total_records,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by round(discount * 100, 0)
order by discount_percentage;


-- 13.6 Sales vs. Profit Performance
select
	case
		when profit > 0 then 'Profitable'
        when profit < 0 then 'Loss'
        else 'Break-even'
	end as business_status,
    count(*) as total_records,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by
	case
		when profit > 0 then 'Profitable'
        when profit < 0 then 'Loss'
        else 'Break-even'
	end
order by total_profit desc;


-- 13.7 Loss-Making Products
select
	product_name,
    category,
    sub_category,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by 
	product_name,
    category,
    sub_category
having sum(profit) < 0
order by total_profit asc
limit 20;


-- 13.8 Overall Business KPI Summary
select
	count(*) as total_records,
    count(distinct order_id) as unique_orders,
    count(distinct customer_id) as unique_customers,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(avg(sales), 2) as average_sales_per_record,
    round(avg(profit), 2) as average_profit_per_record,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100, 
        2
    ) as overall_profit_margin_percentage
from sales_data;

/* ============================================================
   14. FINAL BUSINESS VALIDATION
   ============================================================ */
   
-- 14.1 Confirm Table Size
select
	count(*) as total_records
from sales_data;


WITH distinct_rows AS (
    SELECT
        row_id,
        order_id,
        order_date,
        ship_date,
        ship_mode,
        customer_id,
        customer_name,
        segment,
        country_region,
        city,
        state_province,
        postal_code,
        region,
        product_id,
        category,
        sub_category,
        product_name,
        sales,
        quantity,
        discount,
        profit,
        year,
        month,
        month_name,
        quarter,
        month_start,
        profit_margin,
        shipping_days
    FROM sales_data
    GROUP BY
        row_id,
        order_id,
        order_date,
        ship_date,
        ship_mode,
        customer_id,
        customer_name,
        segment,
        country_region,
        city,
        state_province,
        postal_code,
        region,
        product_id,
        category,
        sub_category,
        product_name,
        sales,
        quantity,
        discount,
        profit,
        year,
        month,
        month_name,
        quarter,
        month_start,
        profit_margin,
        shipping_days
)
SELECT
    (SELECT COUNT(*) FROM sales_data) AS total_records,
    (SELECT COUNT(*) FROM sales_data) - (SELECT COUNT(*) FROM distinct_rows) AS duplicate_records;


-- 14.3 Check Duplicate Order IDs
select
	count(*) as total_records,
    count(distinct order_id) as unique_orders
from sales_data;


-- 14.4 Check NULL values
select
	sum(order_id is null) as null_order_id,
    sum(customer_id is null) as null_customer_id,
    sum(product_id is null) as null_product_id,
    sum(product_name is null) as null_product_name,
    sum(category is null) as null_category,
    sum(sales is null) as null_sales,
    sum(profit is null) as null_profit,
    sum(discount is null) as null_discount
from sales_data;


-- 14.5 Check invalid numeric values
select
	min(sales) as minimum_sales,
    max(sales) as maximum_sales,
    min(profit) as minimum_profit,
    max(profit) as maximum_profit,
    min(discount) as minimum_discount,
    max(discount) as maximum_discount
from sales_data;


-- 14.6 Validate overall financial totals
select
	count(*) as total_records,
    count(distinct order_id) as unique_orders,
    count(distinct customer_id) as unique_customers,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(avg(sales), 2) as average_sales,
    round(avg(profit), 2) as average_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data;


-- 14.7 Validate Overall Profit Margin
select
	round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin
from sales_data;


-- 14.8 Final Business Status Validation
select
	case
		when profit > 0 then 'Profitable'
        when profit < 0 then 'Loss'
        else 'Break-even'
	end as business_status,
    count(*) as total_records,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by
	case
		when profit > 0 then 'Profitable'
        when profit < 0 then 'Loss'
        else 'Break-even'
	end
order by total_profit desc;

/* ============================================================
   END OF SCRIPT
   ============================================================ */

/* ============================================================
   END OF SCRIPT
   ============================================================ */
