# SQL Analysis — Sales Performance Dashboard

Run the scripts in this order:

1. `01_Database_Setup_and_Load.sql`
2. `02_Data_Quality_and_Profiling.sql`
3. `03_Sales_Profitability_Customer_Product.sql`
4. `04_Time_Series_and_Shipping.sql`
5. `05_Business_Insights_and_Final_Validation.sql`

## Important validation note

The original SQL run shown in the screenshots returned **20,388 rows**, while the validated Python dataset contains **10,194 rows**. Since 20,388 = 2 × 10,194, the SQL table appears to have been loaded twice.

Before using SQL results for the final project, clear the existing table and load the CSV **once**, then confirm:

```sql
SELECT COUNT(*) AS total_records
FROM sales_data;
```

Expected result:

```text
10194
```

Also confirm the financial totals match the Python/validated dataset before proceeding to Power BI.
