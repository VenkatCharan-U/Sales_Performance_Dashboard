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
   Contains time-series trends, growth analysis, and delivery/shipping analysis.
*/

/* ============================================================
   11. TIME-SERIES ANALYSIS
   ============================================================ */
   
-- 11.1 Sales by Year
select
	year,
    round(sum(sales), 2) as total_sales
from sales_data
group by year
order by year;


-- 11.2 Profit by Year
select
	year,
    round(sum(profit), 2) as total_profit
from sales_data
group by year
order by year;


-- 11.3 Sales and Profit by Year
select
	year,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by year
order by year;


-- 11.4 Sales by Month
select
	month,
    month_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by month, month_name
order by month;


-- 11.5 Profit by Month
select
	month,
    month_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by month, month_name
order by month;


-- 11.6 Sales and Profit by Month
select
	month,
    month_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by month, month_name
order by month;


-- 11.7 Sales by Quarter
select
	quarter,
    round(sum(sales), 2) as total_sales
from sales_data
group by quarter
order by quarter;


-- 11.8 Profit by Quarter
select
	quarter,
    round(sum(profit), 2) as total_profit
from sales_data
group by quarter
order by quarter;


-- 11.9 Sales and Profit by Quarter
select
	quarter,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by quarter
order by quarter;


-- 11.10 Monthly sales Trend
select
	month_start,
    round(sum(sales), 2) as total_sales
from sales_data
group by month_start
order by month_start;


-- 11.11 Monthly Profit Trend
select
	month_start,
    round(sum(profit), 2) as total_profit
from sales_data
group by month_start
order by month_start;


-- 11.12 Monthly Sales and Profit Trend
select
	month_start,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
	) as profit_margin_percentage
from sales_data
group by month_start
order by month_start;


-- 11.13 Year-over-Year Sales Growth
with yearly_sales as (
	select
		year,
		sum(sales) as total_sales
    from sales_data
    group by year
)
select
	year,
    round(total_sales, 2) as total_sales,
    round(
		(
			(total_sales - lag(total_sales) over (order by year))
            / nullif(lag(total_sales) over (order by year), 0)
        ) * 100,
        2
    ) as sales_growth_percentage
from yearly_sales
order by year;


-- 11.14 Year-over-Year Profit Growth
with yearly_profit as (
	select
		year,
        round(sum(profit), 2) as total_profit
	from sales_data
    group by year
)
select
	year,
    total_profit,
    round(
		(	(total_profit - lag(total_profit) over (order by year))
			/ nullif(lag(total_profit) over (order by year), 0)
		) * 100,
        2
    ) as profit_growth_percentage
from yearly_profit
order by year;


-- 11.15 Best Sales Month
select
	month,
    month_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by month, month_name
order by total_sales desc
limit 1;


-- 11.16 Worst Sales Month
select
	month,
    month_name,
    round(sum(sales), 2) as total_sales
from sales_data
group by month, month_name
order by total_sales asc
limit 1;


-- 11.17 Best Profit Month
select
	month,
    month_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by month, month_name
order by total_profit desc
limit 1;


-- 11.18 Worst Profit Month
select
	month,
    month_name,
    round(sum(profit), 2) as total_profit
from sales_data
group by month, month_name
order by total_profit asc
limit 1;


-- 11.19 Year and Month Performance
select
	year,
    month,
    month_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by year, month, month_name
order by year, month;
    
    
-- 11.20 Best Performing Year
select
	year,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by year
order by total_profit desc
limit 1;

/* ============================================================
   12. SHIPPING & DELIVERY ANALYSIS
   ============================================================ */
   
-- 12.1 Orders by Shipping Mode
select
	ship_mode,
    count(*) as total_orders
from sales_data
group by ship_mode
order by total_orders desc;


-- 12.2 Sales by Shipping Mode
select
	ship_mode,
    count(*) as total_orders,
    round(sum(sales), 2) as total_sales
from sales_data
group by ship_mode
order by total_orders desc;


-- 12.3 Profit by Shipping Mode
select
	ship_mode,
    round(sum(profit), 2) as total_profit
from sales_data
group by ship_mode
order by total_profit desc;


-- 12.4 Profit Margin by Shipping Mode
select
	ship_mode,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by ship_mode
order by profit_margin_percentage desc;


-- 12.5 Average Delivery Time
select
	ship_mode,
    round(avg(datediff(ship_date, order_date)), 2)
    as avg_delivery_days
from sales_data
group by ship_mode
order by avg_delivery_days;


-- 12.6 Minimum and Maximum Delivery Time
select
	ship_mode,
    min(datediff(ship_date, order_date)) as minimum_delivery_days,
    max(datediff(ship_date, order_date)) as maximum_delivery_days,
    round(avg(datediff(ship_date, order_date)), 2)
		as average_delivery_days
from sales_data
group by ship_mode
order by average_delivery_days;


-- 12.7 Overall Delivery Performance
select
	count(*) as total_orders,
    round(avg(datediff(ship_date, order_date)), 2)
		as average_shipping_days,
	min(datediff(ship_date, order_date))
		as fastest_shipping_days,
	max(datediff(ship_date, order_date))
		as slowest_shipping_days
from sales_data;


-- 12.8 Long Delivery Orders
select
	ship_mode,
    count(*) as long_delivery_orders
from sales_data
where datediff(ship_date, order_date) > 5
group by ship_mode
order by long_delivery_orders desc;


-- 12.9 Long Delivery Percentage
select
	ship_mode,
    count(*) as total_orders,
    sum(
		case
			when datediff(ship_date, order_date) > 5
            then 1
            else 0
		end
    ) as long_delivery_orders,
    round(
		sum(
			case
				when datediff(ship_date, order_date) > 5
                then 1
                else 0
			end
		) * 100.0 / count(*),
        2
    ) as long_delivery_percentage
from sales_data
group by ship_mode
order by long_delivery_percentage desc;


-- 12.10 Shipping Performance by Region
select
	region,
    count(*) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(avg(datediff(ship_date, order_date)), 2)
		as average_delivery_days
from sales_data
group by region
order by average_delivery_days desc;


-- 12.11 Shipping Mode by Region
select
	region,
    ship_mode,
    count(*) as total_orders,
    round(avg(datediff(ship_date, order_date)), 2)
		as average_delivery_days
from sales_data
group by region, ship_mode
order by region, average_delivery_days;


-- 12.12 Shipping Mode by Customer Segment
select
	segment,
    ship_mode,
    count(*) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from sales_data
group by segment, ship_mode
order by segment, total_orders desc;


-- 12.13 Average Delivery Time by Customer Segment
select
	segment,
    count(*) as total_orders,
    round(avg(datediff(ship_date, order_date)), 2)
		as average_delivery_days
from sales_data
group by segment
order by average_delivery_days;


-- 12.14 Shipping Trend Over Time
select
	year,
    ship_mode,
    count(*) as total_orders,
    round(avg(datediff(ship_date, order_date)), 2)
		as average_delivery_days
from sales_data
group by year, ship_mode
order by year, ship_mode;


-- 12.15 Best Shipping Mode
select
	ship_mode,
    count(*) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage,
    round(
		avg(datediff(ship_date, order_date)),
        2
    ) as average_delivery_days
from sales_data
group by ship_mode
order by
	average_delivery_days asc,
    profit_margin_percentage desc;
    

-- 12.16 Worst Shipping Mode by Profitability
select
	ship_mode,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage
from sales_data
group by ship_mode
order by profit_margin_percentage asc
limit 1;


-- 12.17 Worst Shipping Mode by Delivery Time
select
	ship_mode,
    round(
		avg(datediff(ship_date, order_date)),
        2
    ) as average_delivery_days
from sales_data
group by ship_mode
order by average_delivery_days desc
limit 1;


-- 12.18 Shipping Mode Overall Performance
select
	ship_mode,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(
		(sum(profit) / nullif(sum(sales), 0)) * 100,
        2
    ) as profit_margin_percentage,
    round(
		avg(datediff(ship_date, order_date)), 
        2
    ) as average_delivery_days,
    sum(
		case
			when datediff(ship_date, order_date) > 5
            then 1
            else 0
		end
    ) as long_delivery_orders
from sales_data
group by ship_mode
order by total_profit desc;

/* ============================================================
   END OF SCRIPT
   ============================================================ */
