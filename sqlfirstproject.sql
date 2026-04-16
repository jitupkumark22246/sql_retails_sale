select sum(price_per_unit) as total_price ,category from transactions 
group by category

select * from transactions

select price_per_unit from transactions
where price_per_unit > (select avg(price_per_unit) from transactions)

select 
count(*) from transactions

select * from transactions
where transaction_id is null;

select * from transactions
where sale_date is null;

---- data cleaning 

select * from transactions
where 
	transaction_id is null
	or
	sale_time is null 
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantity is null
	or 
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null ;

-- fill null age to avg age 
UPDATE transactions
SET age = (
    SELECT ROUND(AVG(age)) FROM transactions
)
WHERE age IS NULL;
	
--- delete null values row 
delete from transactions
where 
	transaction_id is null
	or
	sale_time is null 
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantity is null
	or 
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null ;
	
select count(*) from transactions

--- data exploration 

-- how many sales you have?

select count(*) as total_sale from transactions

-- how many unique customer you have?

select   count( distinct customer_id) as total_cust from transactions

-- -- how many unique category you have?

select   count( distinct category) as total_cust from transactions

select distinct category from transactions

-- data analyst and business key prolem & answer 

select * from transactions

-- Q1... write a sql query to retrieve all column for sales made on '2022-11-05'

select * from transactions
where sale_date = '2022-11-05' ;


--Q2... WASQ for retrieve all transaction where the category is "clothing" and the quentity sold is more than 4 in the month of nov-2022

select * from transactions
where 
	category = 'Clothing'
	and 
	TO_CHAR(sale_date,'yyyy-mm')= '2022-11'
	and 
	quantity >=4;

--Q3... write a query to calculate the total sales for each category?

select category,sum(total_sale) as total_sales from transactions
group by category ;  -- here you wwant to write '1' in space of category ,, so this is write query 


--Q4... write a sql query to find the average gae of customer who purchase item from the 'Beauty' categotry?
select 
	round(avg(age)) as agv_age
	from transactions
	where category = 'Beauty';

--Q5 ... write a sql query to find all transsactions where the total sales is greater than 1000?

select *
	
	from transactions
	where total_sale > 1000;

--Q6... write a sql query to find  the total number of transactions(transaction_id) made by each gender in each category?

select gender , category,  count(transaction_id) as tota_transaction
from transactions
group by gender, category

--Q7... write a query to calculate the average sale for each month . find out best selling month in each year?

select distinct extract (year from  sale_date) as uni_agf from transactions
order by uni_agf  -- this is for find unique year 

-- quetion solution 
select 
extract (year from  sale_date) as year,
extract(month from sale_date) as month,

avg(total_sale) as avg_sales

from transactions
group by year , month 
order by 1,2;

-- but here qustion has only one month each year for highest sales  so ,,, i use window function 

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


--Q8...  write a sql query to find the top 5 customer based on the highest total sales 

select customer_id,
	sum(total_sale)	 as per_per_sale
	from transactions
	group by customer_id 
order by sum(total_sale) desc
limit 5 ;

--Q9.... write a sql query to find the number of unique customer who  purchase item from each category?

select category, count(distinct customer_id) as unique_cust
from  transactions
group by category
order by unique_cust
limit 5 ;


--Q10... write a sql query to  create each shift and number of orders (example morning <=12,afternoon between 12&17 and evening >17)

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
group by shift

		
-- end of project 
		
