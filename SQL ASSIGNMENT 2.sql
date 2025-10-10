--🧮 SQL Scenario-Based Questions on SH.CUSTOMERS
--🧱 A. Aggregation & Grouping (20 Questions)
----------------------------------------------------------------------------------
--1.Find the total, average, minimum, and maximum credit limit of all customers.
--SELECT 
-- SUM(cust_credit_limit) as total_credit_limit,
-- avg (cust_credit_limit) as avg_credit_limit,
-- max(cust_credit_limit) as maximum_credit_limit,
-- min(cust_credit_limit) as minimum_credit_limit
--from 
--sh.CUSTOMERS

--2.Count the number of customers in each income level.
 --select cust_income_level,COUNT(*) AS customer_count
 -- FROM  sh.CUSTOMERS GROUP BY cust_income_level

--3.Show total credit limit by state and country.
--select cust_state_province,country_id ,
--sum(cust_credit_limit)as total_credit_limit 
--from sh.CUSTOMERS 
--group by CUST_STATE_PROVINCE,country_id 
--order by CUST_STATE_PROVINCE,country_id

--4.Display average credit limit for each marital status and gender combination.
--select cust_marital_status,cust_gender ,avg(cust_credit_limit) as avg_credit_limit
--from sh.CUSTOMERS
--group by cust_marital_status,cust_gender 
--ORDER by cust_marital_status,cust_gender

--5.Find the top 3 states with the highest average credit limit.
--select cust_state_province,cust_credit_limit, avg(cust_credit_limit) as average_credit_limit
--from sh.customers
--group by  cust_state_province,cust_credit_limit 
--order by average_credit_limit desc fetch first 3 rows ONLY

--6.Find the country with the maximum total customer credit limit.
--select cust_credit_limit ,sum(cust_credit_limit) as total_credit_limit
--from sh.CUSTOMERS
--group by CUST_CREDIT_LIMIT order by total_credit_limit DESC
--fetch first 1 row only 

--7.Show the number of customers whose credit limit exceeds their state average.
--select cust_state_province,cust_credit_limit,avg(cust_credit_limit)as avg_credit_limit
--from sh.CUSTOMERS
--group by cust_state_province, CUST_CREDIT_LIMIT order by cust_credit_limit DESC

--8.Calculate total and average credit limit for customers born after 1980.
--SELECT
--cust_credit_limit ,
--cust_year_of_birth ,
--SUM(CUST_CREDIT_LIMIT) AS total_credit_limit,
--AVG(cust_credit_limit) AS average_credit_limit
--FROM sh.customers
--where CUST_YEAR_OF_BIRTH>'1980'
--GROUP BY CUST_CREDIT_LIMIT, CUST_YEAR_OF_BIRTH
--ORDER BY CUST_YEAR_OF_BIRTH

--9.Find states having more than 50 customers.
--select 
--CUST_STATE_PROVINCE,
--COUNT(*) AS customer_count
--FROM SH.CUSTOMERS
--GROUP BY CUST_STATE_PROVINCE HAVING COUNT(*)>50

--10.List countries where the average credit limit is higher than the global average.
--SELECT 
--COUNTRY_ID ,
--AVG(CUST_CREDIT_LIMIT)AS avg_credit_limit
--FROM SH.customers
--GROUP BY COUNTRY_ID
--HAVING (avg_credit_limit)>(
--SELECT AVG(CUST_CREDIT_LIMIT) FROM SH.customers)

--11.Calculate the variance and standard deviation of customer credit limits by country.
--SELECT
--COUNTRY_ID,
--VARIANCE(CUST_CREDIT_LIMIT)AS VARIANCE_CREDIT_LIMIT,
--STDDEV(CUST_CREDIT_LIMIT)AS STANDARD_DEVIATION_CREDIT_LIMIT
--FROM SH.customers
--GROUP BY COUNTRY_ID

--12.Find the state with the smallest range (max–min) in credit limits.
--SELECT CUST_state_PROVINCE, credit_range
--FROM (
--SELECT
--CUST_STATE_PROVINCE,
--MAX(cust_credit_limit) - MIN(cust_credit_limit) AS credit_range
--FROM sh.customers
--GROUP BY CUST_STATE_PROVINCE
--)
--WHERE credit_range = (
--SELECT MIN(MAX(cust_credit_limit) - MIN(cust_credit_limit))
--FROM sh.customers
--GROUP BY CUST_STATE_PROVINCE
--)

--13.Show the total number of customers per income level and the percentage contribution of each.
--SELECT 
--cust_income_level,
--COUNT(*)AS TOTAL_CUSTOMERS,
--ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM SH.CUSTOMERS), 2)
--AS PERCENTAGE_CONTRIBUTION
--FROM SH.CUSTOMERS
--GROUP BY CUST_INCOME_LEVEL
--ORDER BY PERCENTAGE_CONTRIBUTION DESC

--14.For each income level, find how many customers have NULL credit limits.
--SELECT 
--CUST_INCOME_LEVEL,
--COUNT(*)AS TOTAL_CUSTOMERS,
--COUNT(CASE WHEN CUST_CREDIT_LIMIT IS NULL THEN 1 END) AS null_credit_limit_customers
--FROM SH.CUSTOMERS
--GROUP BY CUST_INCOME_LEVEL
--ORDER BY null_credit_limit_customers DESC

--15.Display countries where the sum of credit limits exceeds 10 million.
--SELECT 
--COUNTRY_ID,
--CUST_CREDIT_LIMIT,
--sum(CUST_CREDIT_LIMIT)AS TOTAL_CREDIT_LIMIT
--from sh.CUSTOMERS
--GROUP BY COUNTRY_ID,CUST_CREDIT_LIMIT
--HAVING SUM(CUST_CREDIT_LIMIT) > 10000000
--ORDER BY TOTAL_CREDIT_LIMIT DESC

--16.Find the state that contributes the highest total credit limit to its country.
--SELECT
--COUNTRY_ID,
--CUST_STATE_PROVINCE,
--TOTAL_CREDIT_LIMIT
--FROM(
    --SELECT
        --COUNTRY_ID,
        --CUST_STATE_PROVINCE,
        --SUM(CUST_CREDIT_LIMIT)AS TOTAL_CREDIT_LIMIT,
        --RANK() OVER (PARTITION BY COUNTRY_ID ORDER BY SUM(CUST_CREDIT_LIMIT) DESC) AS RANK_IN_COUNTRY
    --FROM SH.CUSTOMERS
    --GROUP BY COUNTRY_ID,CUST_STATE_PROVINCE
   -- )
    --WHERE RANK_IN_COUNTRY=1
    --ORDER BY TOTAL_CREDIT_LIMIT DESC

--17.Show total credit limit per year of birth, sorted by total descending.
--SELECT 
--CUST_YEAR_OF_BIRTH,
--SUM(CUST_CREDIT_LIMIT)AS TOTAL_CREDIT_LIMIT
--FROM SH.CUSTOMERS
--GROUP BY  CUST_YEAR_OF_BIRTH 
--ORDER BY  TOTAL_CREDIT_LIMIT DESC,CUST_YEAR_OF_BIRTH DESC
           

--18.Identify customers who hold the maximum credit limit in their respective country.
--SELECT
--COUNTRY_ID,
--CUST_FIRST_NAME,
--CUST_LAST_NAME,
--CUST_CREDIT_LIMIT
--FROM 
--SH.CUSTOMERS c
--WHERE 
--CUST_CREDIT_LIMIT = (
    --SELECT MAX(CUST_CREDIT_LIMIT)
    --FROM SH.CUSTOMERS
    --WHERE COUNTRY_ID = c.COUNTRY_ID
    --)
--ORDER BY 
--COUNTRY_ID,
--CUST_CREDIT_LIMIT DESC;

--19.Show the difference between maximum and average credit limit per country.
--select 
--country_id,
    --max(cust_credit_limit) as maximum_credit_limit,
    --avg(cust_credit_limit)as avg_credit_limit,
    --max(cust_credit_limit)- avg(cust_credit_limit) as difference 
    --from sh.CUSTOMERS
    --group by country_id

    --20.Display the overall rank of each state based on its total credit limit (using GROUP BY + analytic rank).
--SELECT 
--cust_state_province,
--total_credit_limit,
--RANK() OVER (ORDER BY total_credit_limit DESC) AS state_rank
--FROM (
--SELECT 
    --cust_state_province,
    --SUM(cust_credit_limit) AS total_credit_limit
    --FROM sh.customers
    --GROUP BY cust_state_province
--) ranked_states;

--📊 B. Analytical / Window Functions (30 Questions)

--1.Assign row numbers to customers ordered by credit limit descending.
--select 
--cust_id,
--CUST_FIRST_NAME,
--cust_credit_limit,
--ROW_NUMBER() over(ORDER by cust_credit_limit desc)as ROW_NUMBER
--from sh.CUSTOMERS

--2.Rank customers within each state by credit limit.
--select 
--cust_id,
--CUST_STATE_PROVINCE,
--cust_credit_limit,
--ROW_NUMBER() over(PARTITION BY CUST_STATE_PROVINCE ORDER by cust_credit_limit desc)as CREDIT_RANK
--from sh.CUSTOMERS

--3.Use DENSE_RANK() to find the top 5 credit holders per country.
SELECT 
    COUNTRY_ID,
    CUST_CREDIT_LIMIT,
    DENSE_RANK()OVER(PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC)AS TOP_CREDIT_HOLDERS
    FROM SH.CUSTOMERS