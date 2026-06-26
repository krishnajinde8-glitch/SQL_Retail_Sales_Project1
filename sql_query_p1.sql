##DATA CLEANING## 

DROP TABLE IF EXISTS RETAIL_SALES;
create table retail_sales
			(
			transactions_id	INT PRIMARY KEY,
			sale_date	DATE,
			sale_time	TIME,
			customer_id	INT,
			gender 	VARCHAR(15),
			age	 INT,
			category VARCHAR(15),  	
			quantiy	INT,
			price_per_unit FLOAT,	
			cogs	FLOAT,
			total_sale FLOAT
			);
select * from retail_sales
limit 10;

select 
count (*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select * from retail_sales
where 
			transactions_id	is null
			or
			sale_date is null
			or
			sale_time is null
			or
			gender 	is null
			or
			category is null  	
			or
			quantiy is null
			or
			cogs	is null
			or
			total_sale is null;


delete from retail_sales
where 
			transactions_id	is null
			or
			sale_date is null
			or
			sale_time is null
			or
			gender 	is null
			or
			category is null  	
			or
			quantiy is null
			or
			cogs	is null
			or
			total_sale is null;

-- DATA EXPLORATION 
-- HOW MANY SALES WE HAVE ?

SELECT COUNT(*) as total_sale from retail_sales;

-- HOW MANY SALES WE HAVE ?
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category as total_sale from retail_sales;

select * from retail_sales;

--- Data analysis & Business key problem and answers
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing ',' and the quantity sold is more than 4 in the month of Nov-2022.
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders.
-- (Example: Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
select *
from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.

select *
from retail_sales
where category = 'Clothing'
	and 
	to_char(sale_date, 'YYYY-MM')= '2022-11'
	and 
	quantiy >=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
		sum(total_sale) as net_sale,
		count(*) as total_orders
from retail_sales
group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
	round(avg(age),2) as AVG_Age
from retail_sales
where category ='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
	gender,
	category,
	count(transactions_id) as Transactions 
from retail_sales
group by 1,2
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.
select year,
		month,
		Total_sales
from
(
select
 	 extract (year from sale_date) as year,
	 extract (month from sale_date) as month,
	 round(avg(total_sale)) as Total_sales,
	 rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) as Rank
from retail_sales
group by 1,2
) as t1
where rank =1

--order by 1,3 desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
	category,
	count (Distinct customer_id) as count_of_unique_customer
from retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders.
-- (Example: Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH HOURLY_SALE
AS
(
select *,
	case
		when extract (hour from sale_time) <12 then 'MORNING'
		when extract (hour from sale_time) BETWEEN 12 AND 17 then 'AFTERNOON'
		else 'EVENING'
	end as shift
from retail_sales
)
SELECT 
	shift,
	count(*) as Total_orders
	from hourly_sale
	group by shift

