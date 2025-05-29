create table retail(transactions_id int,sale_date date,	sale_time time,	customer_id int,	gender varchar(30),	age	 int ,category varchar(40),
quantiy int,price_per_unit	 int,cogs float,total_sale int);
select*from retail;
select*from retail
where sale_date is null
or sale_time is null
or customer_id is null
or age is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null;
delete from retail;
delete from retail where gender  is null or sale_date  is null or  sale_time is null or cogs is null or total_sale is null or transactions_id is null;
select*from retail;

select count(*) as total from retail;



select  count(*) as totalsales from retail;
select count(distinct customer_id) as cust from retail;
select  category,count(*) as cat from retail group by 1;
--Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select *from retail
where sale_date='2022-11-05';
---Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select *from  retail
where category='Clothing' and  to_char(sale_date,'yyyy-mm') ='2022-11' and quantiy>=4;

----Write a SQL query to calculate the total sales (total_sale) for each category.:
select category ,sum(total_sale) as total_sale from retail
group by 1;
---Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age),2)as avgage from retail
where category='Beauty';
select*from retail;

---Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select  transactions_id,sum(total_sale) as totalsales from retail
group by 1
having sum(total_sale)>1000;
---Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category,gender,count(*) as totaltransactions ,rank() over(partition by category order by count(*)  desc ) as ran from retail
group by 1,2;
--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select*from(select extract(year from sale_date ) as year,extract(month from sale_date) as month,round(avg(total_sale) ,2)as avgsales ,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as ran from retail
group by 1 ,2) t 
where ran=1;

---**Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id,sum(total_sale)as totalsale from retail
group by 1
order by 2 desc
limit 5;
---Write a SQL query to find the number of unique customers who purchased items from each category.:
select category,count(distinct customer_id)as uniquecustomers from retail
group by 1;
---Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select count(*) as orders,
(case when extract(hour from sale_time)<12 then 'Morning'  when extract(hour from sale_time) between 12 and 17 then 'Afternoon'  else  'Evening' end )as shifts from  retail
group by 2
order by 1 desc;
