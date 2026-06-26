# 📊 Retail Sales Analysis using SQL

## Business Intelligence Report

## Project Title: Retail Sales Analysis using SQL  
## Prepared By: Krishna Jinde

------------------------------------------------------------------------

# 🛠️ Tools Used

- MySQL Server
- MySQL Workbench
- SQL
- CSV Dataset
- GitHub

------------------------------------------------------------------------

# 📌 1. Business Problem

Retail businesses generate thousands of sales transactions every day.
Raw transaction data alone cannot support strategic business decisions.
This project uses SQL to transform retail sales data into meaningful
business insights that improve decision-making, customer understanding,
and sales performance.

------------------------------------------------------------------------

# 🎯 2. Project Objectives

- Create a retail sales database in MySQL
- Clean and validate the dataset
- Perform Exploratory Data Analysis (EDA)
- Answer real-world business questions using SQL
- Generate actionable business insights

------------------------------------------------------------------------

# 📂 3. Dataset Overview

The dataset contains:

- Transaction ID
- Sale Date
- Sale Time
- Customer ID
- Gender
- Age
- Product Category
- Quantity
- Price per Unit
- Cost of Goods Sold (COGS)
- Total Sale

------------------------------------------------------------------------

# 🗄️ 4. Database Setup

- Created database: **p1_retail_db**
- Created table: **retail_sales**
- Imported retail sales CSV dataset into MySQL.

------------------------------------------------------------------------

# 🧹 5. Data Cleaning

The dataset was checked for:

- Missing values
- NULL values
- Duplicate records
- Incorrect data types

Invalid records were removed before analysis to ensure data accuracy.

------------------------------------------------------------------------

# 📈 6. Exploratory Data Analysis (EDA)

Performed exploratory analysis to understand:

- Total number of transactions
- Unique customers
- Product categories
- Customer demographics
- Sales distribution

------------------------------------------------------------------------

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

------------------------------------------------------------------------

# 🔍 8. Key Findings

- Customer purchasing behaviour varies across product categories.
- Premium transactions contribute significantly to revenue.
- Monthly sales analysis identifies seasonal demand.
- High-value customers generate a large share of total sales.
- Shift analysis helps identify peak shopping hours.

------------------------------------------------------------------------

# 💡 9. Business Recommendations

- Focus marketing on high-performing categories.
- Reward loyal and high-value customers.
- Increase inventory before peak sales periods.
- Improve promotions for low-performing categories.
- Schedule staff according to peak shopping shifts.

------------------------------------------------------------------------

# 🚀 10. Skills Demonstrated

- SQL
- MySQL
- Database Design
- Data Cleaning
- Exploratory Data Analysis (EDA)
- Aggregate Functions
- Window Functions
- Common Table Expressions (CTE)
- Business Analysis
- Customer Segmentation

------------------------------------------------------------------------

# ✅ 11. Conclusion

This project demonstrates practical SQL skills by building a retail
sales database, cleaning data, performing exploratory analysis, and
solving real business problems using SQL queries. The insights support
better decisions in sales, marketing, customer retention, and inventory
management.

------------------------------------------------------------------------

# 🛠️ Technologies Used

- MySQL Server
- MySQL Workbench
- SQL
- GitHub

------------------------------------------------------------------------

## 👨‍💻 Author : - KRISHNA JINDE

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **LinkedIn**:**(linkedin.com/in/krishna-jinde-70845285)**

Thank you for your support, and I look forward to connecting with you!
