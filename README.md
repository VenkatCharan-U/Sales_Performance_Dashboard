# Sales Performance Dashboard

An end-to-end retail sales analytics and business intelligence project
using **Python, MySQL/SQL, and Power BI**.

## 📊 Project Overview

This project transforms transactional retail sales data into a
structured analytical solution. The workflow covers data loading and
preparation in Python, exploratory and time-series analysis, data
validation, structured analysis in MySQL using SQL, and interactive
reporting in Power BI.

The final solution is designed to answer practical business questions
around sales, profitability, customers, products, regions, discounts,
and shipping performance.

## 🎯 Business Problem

Retail transaction data contains useful information about orders,
customers, products, discounts, sales, profit, and shipping, but raw
records do not directly explain business performance.

This project focuses on questions such as:

-   How much sales revenue and profit are being generated?
-   How do sales and profit change over time?
-   Which categories, products, customers, segments, and regions perform
    strongly?
-   Which products or records generate losses?
-   How does discounting relate to profitability?
-   How do shipping modes and delivery times perform?
-   What practical actions could improve business performance?

## 🎯 Objectives

-   Prepare and validate the retail dataset for analysis.
-   Perform data loading, cleaning, EDA, and validation using Python.
-   Analyze monthly and quarterly sales and profit trends.
-   Store the validated dataset in MySQL.
-   Perform structured SQL profiling and business analysis.
-   Analyze customers, products, categories, segments, regions,
    discounts, and shipping.
-   Build interactive Power BI dashboards using DAX.
-   Translate analytical results into business insights and
    recommendations.

## 📂 Dataset

  Metric                             Value
  ----------------------- ----------------
  Records                           10,194
  Unique Orders                      5,111
  Unique Customers                     804
  Unique Products                    1,862
  Categories                             3
  Sub-categories                        17
  Regions                                4
  Quantity                          38,654
  Total Sales               \$2,326,534.35
  Total Profit                \$292,296.81
  Overall Profit Margin             12.56%
  Earliest Order                2023-01-03
  Latest Order                  2026-12-30

The dataset contains order, customer, geographical, product, financial,
time, and operational fields. Derived fields include year, month,
quarter, month start, profit margin, and shipping days.

## 🛠️ Tech Stack

  -----------------------------------------------------------------------
  Technology                          Purpose
  ----------------------------------- -----------------------------------
  Python                              Data loading, cleaning, EDA,
                                      time-series analysis, validation

  Pandas                              Data manipulation and analysis

  NumPy                               Numerical operations

  Matplotlib                          Visualization

  Seaborn                             Exploratory visualization

  Statsmodels                         Time-series/statistical analysis

  MySQL                               Database storage

  SQL                                 Profiling and business analysis

  MySQL Workbench                     Database management and SQL
                                      execution

  Power BI                            Interactive dashboards

  DAX                                 KPI and analytical measures

  Git / GitHub                        Version control and portfolio
                                      presentation
  -----------------------------------------------------------------------

## 🔄 Project Workflow

**Raw Retail Data → Python Data Loading → Data Cleaning & Preparation →
EDA → Time-Series Analysis → Data Validation → Validated Dataset → MySQL
→ SQL Analysis → Business Analysis → Power BI → Business Insights &
Recommendations**

The project deliberately uses Python, SQL, and Power BI as complementary
stages rather than repeating the same analysis in every tool.

## 🐍 Python Analysis

### Data Loading & Cleaning

Python was used to load the retail dataset, inspect its structure and
data types, prepare date fields, and create analytical fields required
for downstream analysis.

The final analytical dataset contains **10,194 records and 28 fields**.

### Exploratory Data Analysis

EDA examined:

-   Sales and profit
-   Orders and quantity
-   Customers
-   Products and categories
-   Customer segments
-   Regions
-   Discounts
-   Profitability

### Time-Series Analysis

Monthly and quarterly patterns were examined across the four-year
period.

Key results:

-   Highest sales month: **November --- \$352,665.99**
-   Lowest sales month: **February --- \$59,751.25**
-   Highest profit month: **December --- \$44,229.85**
-   Lowest profit month: **January --- \$9,497.25**
-   Time-series coverage: **January 2023 to December 2026**
-   ADF test p-value: **0.0002546**, supporting stationarity of the
    analyzed series.

### Data Validation

The final dataset was validated before SQL and dashboard development.

-   Missing values: **0**
-   Complete duplicate rows: **0**
-   Invalid sales/quantity/discount values: **0**
-   Negative-profit records: **1,901**
-   Shipping days: **0--11 days**
-   Average shipping time: **3.96 days**
-   Invalid shipping days: **0**

Negative-profit records were retained because they represent a genuine
business condition rather than a data-quality error.

## 🗄️ MySQL & SQL Analysis

The validated dataset was stored in:

-   **Database:** `sales_performance`
-   **Main table:** `sales_data`

SQL was used for independent profiling and structured business analysis.

### Analysis Areas

-   Data quality checks
-   Dataset profiling
-   Sales performance
-   Profitability
-   Discount impact
-   Customer analysis
-   Product analysis
-   Category and segment analysis
-   Regional performance
-   Time-series analysis
-   Shipping and delivery performance
-   Business insights
-   Final validation

The SQL results were checked against the validated Python dataset to
maintain consistency across the project.

## 📊 Power BI Dashboards

Power BI was used as the final reporting and visualization layer.

The model uses a dedicated date table related to
`sales_data[order_date]`. Core DAX measures include:

-   Total Sales
-   Total Profit
-   Total Quantity
-   Total Orders
-   Total Customers
-   Average Order Value
-   Profit Margin %

### Dashboard 1 --- Executive Sales & Profit Overview

Provides a high-level view of:

-   Total Sales
-   Total Profit
-   Total Orders
-   Total Quantity
-   Total Customers
-   Profit Margin
-   Monthly Sales Trend
-   Monthly Profit Trend
-   Regional sales and profit

**Dashboard screenshot:**\
*Add the final Dashboard 1 screenshot here.*

### Dashboard 2 --- Product & Customer Insights

Focuses on:

-   Customer contribution
-   Average Order Value
-   Profit Margin
-   Sales by Category
-   Profit by Category
-   Sales by Segment
-   Profit by Segment
-   Top 10 Products by Sales

**Dashboard screenshot:**\
*Add the final Dashboard 2 screenshot here.*

### Dashboard 3 --- Regional & Operations Performance

Focuses on:

-   Sales by State
-   Sales by Region
-   Profit by Ship Mode
-   Customers by Region
-   Quantity by Ship Mode
-   Average Shipping Days

**Dashboard screenshot:**\
*Add the final Dashboard 3 screenshot here.*

## 🔑 Key Performance Indicators

  KPI                                    Result
  ---------------------------- ----------------
  Total Sales                    \$2,326,534.35
  Total Profit                     \$292,296.81
  Total Orders                            5,111
  Total Quantity                         38,654
  Total Customers                           804
  Average Order Value                  \$455.20
  Profit Margin                          12.56%
  Average Profit per Order              \$57.19
  Average Sales per Customer         \$2,893.70

## 🔍 Key Findings

1.  The business generated approximately **\$2.33M in sales** and
    **\$292.30K in profit**.
2.  The overall business-level profit margin was **12.56%**.
3.  **November** recorded the highest monthly sales, while **December**
    recorded the highest monthly profit.
4.  The dataset contains **1,901 negative-profit records**, highlighting
    areas that require profitability review.
5.  Average shipping time was approximately **3.96 days**, with delivery
    ranging from 0 to 11 days.
6.  The analysis provides multiple views of performance across products,
    customers, categories, segments, regions, discounts, and shipping
    operations.

## 💡 Business Insights

-   Sales volume should be evaluated together with profitability rather
    than using revenue alone.
-   Loss-making products or transactions should be reviewed for pricing,
    discounting, and cost-related issues.
-   High-sales periods require appropriate inventory and operational
    planning.
-   Customer and segment performance can help prioritize retention and
    sales efforts.
-   Regional performance comparisons can identify stronger and weaker
    markets.
-   Discount strategies should be evaluated against their effect on
    profit.
-   Shipping performance can be monitored to identify operational
    delays.

## 🚀 Recommendations

-   Monitor sales and profit together using the Power BI KPIs.
-   Review loss-making products and transactions regularly.
-   Optimize discounting based on profitability rather than sales volume
    alone.
-   Prepare inventory and operational capacity for high-sales periods.
-   Prioritize valuable customers and high-performing segments.
-   Compare regional performance to identify improvement opportunities.
-   Monitor shipping modes and delivery times.
-   Refresh the dashboard periodically for continued performance
    monitoring.

## 📁 Project Structure

``` text
Sales_Performance_Dashboard/
├── DataSet/
├── Documentation/
├── Images/
├── PowerBI/
│   └── Sales_Performance_Dashboard.pbix
├── Python/
│   ├── 01_Data_Loading_and_Cleaning.ipynb
│   ├── 02_Exploratory_Data_Analysis.ipynb
│   ├── 03_Time_Series_Analysis.ipynb
│   └── 04_Data_Validation.ipynb
├── SQL/
│   ├── 01_Database_Setup_and_Load.sql
│   ├── 02_Data_Quality_and_Profiling.sql
│   ├── 03_Sales_Profitability_Customer_Product.sql
│   ├── 04_Time_Series_and_Shipping.sql
│   ├── 05_Business_Insights_and_Final_Validation.sql
│   └── README_SQL.md
├── README.md
└── .gitignore
```

## ▶️ How to Use

1.  Review the dataset in `DataSet/`.
2.  Run the Python notebooks in sequence for preparation, EDA,
    time-series analysis, and validation.
3.  Create/load the MySQL database using the SQL scripts.
4.  Run the SQL analysis scripts.
5.  Open `Sales_Performance_Dashboard.pbix` in Power BI.
6.  Refresh the data connection if required.
7.  Explore the three dashboard pages.

## 📌 Project Outcome

This project demonstrates an end-to-end analytics workflow in which raw
retail transactions are transformed into validated data, structured SQL
analysis, interactive Power BI dashboards, and actionable business
insights.

## 👤 Author

**Venkat Charan**
