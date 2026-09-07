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
   Checks data quality, profiles the dataset, and records baseline KPIs.
*/

/* ============================================================
   03. DATA QUALITY CHECKS
   ============================================================ */

USE sales_performance;

-- 03.1 Total Records
SELECT COUNT(*) AS total_rows
FROM sales_data;


-- 03.2 Duplicate Row IDs
SELECT COUNT(*) AS duplicate_rows
FROM (
    SELECT
        row_id,
        COUNT(*) AS cnt
    FROM sales_data
    GROUP BY row_id
    HAVING COUNT(*) > 1
) AS duplicates;


-- 03.3 Missing Values in Key Columns
SELECT
    SUM(row_id IS NULL) AS missing_row_id,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(order_date IS NULL) AS missing_order_date,
    SUM(ship_date IS NULL) AS missing_ship_date,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(sales IS NULL) AS missing_sales,
    SUM(quantity IS NULL) AS missing_quantity,
    SUM(discount IS NULL) AS missing_discount,
    SUM(profit IS NULL) AS missing_profit
FROM sales_data;


-- 03.4 Invalid Shipping Days
-- Expected: 0 invalid records
SELECT COUNT(*) AS invalid_shipping_days
FROM sales_data
WHERE shipping_days IS NULL
   OR shipping_days < 0;

/* ============================================================
   04. DATASET PROFILING
   ============================================================ */

-- 04.1 Total Records
SELECT COUNT(*) AS total_rows
FROM sales_data;


-- 04.2 Unique Orders
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM sales_data;


-- 04.3 Unique Customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_data;


-- 04.4 Unique Products
SELECT COUNT(DISTINCT product_id) AS unique_products
FROM sales_data;


-- 04.5 Categories
SELECT COUNT(DISTINCT category) AS total_categories
FROM sales_data;


-- 04.6 Sub-categories
SELECT COUNT(DISTINCT sub_category) AS total_sub_categories
FROM sales_data;


-- 04.7 Regions
SELECT COUNT(DISTINCT region) AS total_regions
FROM sales_data;


-- 04.8 Order Date Range
SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM sales_data;


-- 04.9 Overall Sales and Profit
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profits,
    AVG(sales) AS average_sales,
    AVG(profit) AS average_profits
FROM sales_data;


-- 04.10 Overall Dataset Summary
SELECT
    COUNT(*) AS total_records,
    SUM(quantity) AS total_quantity,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profits,
    AVG(discount) AS average_discount,
    AVG(profit_margin) AS average_profit_margin
FROM sales_data;

/* ============================================================
   05. BASELINE RESULTS
   ============================================================

   Current validation run:

   Total records        : 20,388
   Unique orders        : 5,111
   Unique customers     : 804
   Unique products      : 1,862
   Categories           : 3
   Sub-categories       : 17
   Regions              : 4
   Earliest order       : 2023-01-03
   Latest order         : 2026-12-30

   Total quantity       : 77,308
   Total sales          : 4,653,068.71
   Total profit         : 584,593.63
   Average sales        : 228.23
   Average profit       : 28.67
   Overall profit margin: 12.56%

   NOTE:
   These values are reference values from the current dataset.
   Re-run Section 14 after any data reload or transformation.
   ============================================================ */

/* ============================================================
   END OF SCRIPT
   ============================================================ */
