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
   Creates the database/table and loads the validated dashboard CSV.
*/

/* ============================================================
   01. CREATE DATABASE & TABLE
   ============================================================ */

CREATE DATABASE IF NOT EXISTS sales_performance;

USE sales_performance;

truncate table sales_data;
-- Check available databases
SHOW DATABASES;

-- Create the main sales table
CREATE TABLE IF NOT EXISTS sales_data (
    row_id INT,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(30),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(30),
    country_region VARCHAR(100),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(30),
    product_id VARCHAR(30),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(12,4),
    quantity INT,
    discount DECIMAL(5,4),
    profit DECIMAL(12,4),
    year INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    month_start DATE,
    profit_margin DECIMAL(10,4),
    shipping_days INT
);

-- Verify table creation
SHOW TABLES;

DESCRIBE sales_data;

/* ============================================================
   02. LOAD DATA
   ============================================================ */

-- Check whether MySQL local file loading is enabled
SHOW VARIABLES LIKE 'local_infile';

-- Enable local_infile if required and permitted
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';

USE sales_performance;

-- Check existing records before loading
SELECT COUNT(*) AS existing_rows
FROM sales_data;

---------------------------------------------------------------
-- DATA LOAD
---------------------------------------------------------------

/*
IMPORTANT:
Run the TRUNCATE statement below ONLY when you intentionally
want to remove the existing records and reload the CSV.

TRUNCATE TABLE sales_data;
*/

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales_Performance_Dashboard_Final.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
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
);

-- Verify that data was loaded
SELECT COUNT(*) AS total_rows
FROM sales_data;

-- Preview the first 5 records
SELECT *
FROM sales_data
LIMIT 5;

/* ============================================================
   END OF SCRIPT
   ============================================================ */
