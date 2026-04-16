# Project Overview

This project focuses on analyzing sales transaction data using PostgreSQL.
The goal is to extract meaningful insights such as total revenue, customer behavior, and product performance.

#  Objectives
  Analyze yearly and monthly sales trends
  Identify top-performing categories
  Handle missing (NULL) values in dataset
  Perform data cleaning and transformation
  Generate business insights using SQL queries

# create data 


CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit NUMERIC(10,2),
    cogs NUMERIC(10,2),
    total_sale NUMERIC(10,2)
);

## Data Analysis and Finding 

The following sql query were developed to answer specific business question 

1. ** write a sql query to retrieve all column for sales made on '2022-11-05':
   ``` sql
   select * from transactions where sale_date = '2022-11-05' ;
```

3. ** WASQ for retrieve all transaction where the category is "clothing" and the quentity sold is more than 4 in the month of nov-2022
'''sql
   
   select * from transactions
   where 
	 category = 'Clothing'
	 and 
	 TO_CHAR(sale_date,'yyyy-mm')= '2022-11'
	 and 
	 quantity >=4;

'''

3. ** write a query to calculate the total sales for each category?
'''sql
   
select category,sum(total_sale) as total_sales 
from transactions
group by category ; 


4. ** write a sql query to find the average gae of customer who purchase item from the 'Beauty' categotry?
'''sql
  select 
	round(avg(age)) as agv_age
	from transactions
	where category = 'Beauty';
   
'''

5. **  write a sql query to find all transsactions where the total sales is greater than 1000?
'''sql

  select *
	from transactions
	where total_sale > 1000;

'''

6. ** write a sql query to find  the total number of transactions(transaction_id) made by each gender in each category?
'''sql
select gender , category,
count(transaction_id) as tota_transaction
from transactions
group by gender, category

'''

7.** write a query to calculate the average sale for each month . find out best selling month in each year?
'''sql

select * 
	from 
		(select 
		extract (year from  sale_date) as year,
		extract(month from sale_date) as month,
		
		avg(total_sale) as avg_sales,
		rank() over(partition by extract (year from  sale_date) order by avg(total_sale) desc ) as rank
		from transactions
		group by year , month
		) as t1

where rank=1;

'''


8. ** write a sql query to find the top 5 customer based on the highest total sales 
'''sql
   
select customer_id,
sum(total_sale)	 as per_per_sale
from transactions
group by customer_id 
order by sum(total_sale) desc
limit 5 ;
'''

9. ** write a sql query to find the number of unique customer who  purchase item from each category?
'''sql
select category, count(distinct customer_id) as unique_cust
from  transactions
group by category
order by unique_cust
limit 5 ;
''' 

10. ** write a sql query to  create each shift and number of orders (example morning <=12,afternoon between 12&17 and evening >17)
'''sql 

with hourly_sale
as (
	select *,
			case 
			when extract(hour from sale_time) < 12  then 'morning' 
			when extract(hour from sale_time) between 12 and 17 then 'afternoon' 
			else 'evening'
		end as shift
	
		from  transactions
)

select shift,
count(*) total_oredr
from hourly_sale
group by shift;
'''
-- end of project 


# Findings
-- Identified clear year-wise growth trends in total sales
-- Discovered top-performing categories contributing maximum revenue
-- Observed customer behavior based on age and gender patterns
-- Found seasonal trends affecting sales performance
-- Detected data inconsistencies and handled missing values effectively

# Reports
-- Generated Year-wise Revenue Report
-- Created Category-wise Sales Analysis Report
-- Built Customer Segmentation Report (Age & Gender)
-- Prepared Data Cleaning Report for handling NULL values
-- Developed SQL-based reports for business decision-making

# Conclusion

This project demonstrates practical knowledge of SQL, including data cleaning, aggregation, and analysis.
The insights derived from the dataset can help businesses improve strategy, optimize sales, and understand customer behavior more effectively.
