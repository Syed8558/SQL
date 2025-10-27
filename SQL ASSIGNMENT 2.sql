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
--------------------------------------------------------------------
--------------------------------------------------------------------
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
--select *
--from (
--select
    --country_id,
    --cust_credit_limit,
    --dense_rank()over(partition by COUNTRY_ID order by cust_credit_limit desc) as rank
--from sh.customers
--)ranked_customers
--where rank<=5

--4.Divide customers into 4 quartiles based on their credit limit using NTILE(4).
-- select 
--     cust_id,
--     CUST_FIRST_NAME,
--     cust_credit_limit,
--     NTILE(4)OVER (ORDER BY CUST_CREDIT_LIMIT DESC)AS quartile
--     from sh.customers

-- 5.Calculate a running total of credit limits ordered by customer_id.
-- select 
--     cust_id,
--     cust_credit_limit,
--     sum(cust_credit_limit)over(order by cust_id) as running_total
--     from sh.customers

--6.Show cumulative average credit limit by country.
-- select 
--     cust_id,
--     country_id,
--     cust_credit_limit,
--     avg(cust_credit_limit)over(partition by country_id order by cust_id)as cumulative_avg_credit_limit
-- from sh.customers

--7.Compare each customer’s credit limit to the previous one using LAG().
-- select 
--     cust_id,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     lag( CUST_CREDIT_LIMIT)over ( order by CUST_CREDIT_LIMIT)as prev_credit_limit
--     from sh.CUSTOMERS

--8.Show next customer’s credit limit using LEAD().
-- select 
--     cust_id,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     lead( CUST_CREDIT_LIMIT)over( order by CUST_CREDIT_LIMIT)as next_credit_limit
--     from sh.CUSTOMERS

--9.Display the difference between each customer’s credit limit and the previous one.
-- select 
--     cust_id,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     lag( CUST_CREDIT_LIMIT)over ( order by CUST_CREDIT_LIMIT)as prev_credit_limit,
--     cust_credit_limit-lag( CUST_CREDIT_LIMIT)over ( order by CUST_CREDIT_LIMIT)as credit_limit_diff
-- from sh.CUSTOMERS

-- 10.For each country, display the first and last credit limit using FIRST_VALUE() and LAST_VALUE().
-- select
--     COUNTRY_ID,
--     CUST_FIRST_NAME,
--     CUST_CREDIT_LIMIT,
--     FIRST_VALUE(CUST_CREDIT_LIMIT)OVER (
--         PARTITION BY COUNTRY_ID 
--         ORDER BY COUNTRY_ID ,CUST_CREDIT_LIMIT
--         ) AS FIRST_CREDIT_LIMIT,
--     LAST_VALUE(CUST_CREDIT_LIMIT)OVER (
--         PARTITION BY COUNTRY_ID
--         ORDER BY COUNTRY_ID, CUST_CREDIT_LIMIT
--     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
--     )AS LAST_CREDIT_LIMIT
--     FROM SH.CUSTOMERS

--11.Compute percentage rank (PERCENT_RANK()) of customers based on credit limit.
-- select 
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_credit_limit,
--     PERCENT_RANK() OVER (ORDER BY cust_credit_limit) AS percent_rank
-- from sh.customers

--12.Show each customer’s position in percentile (CUME_DIST() function).
-- select
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_credit_limit,
--     round(CUME_DIST() over (order by cust_credit_limit)*100,2)as percentile_rank
--     from sh.CUSTOMERS

--13.Display the difference between the maximum and current credit limit for each customer.
-- select
--     cust_id,
--     cust_credit_limit,
--    max(cust_credit_limit)over()as maximum_credit_limit,
--    max(cust_credit_limit)over()-cust_credit_limit as credit_limit_diff
--    from sh.customers
   
--14.Rank income levels by their average credit limit.
-- select
--     cust_income_level,
--     avg(cust_credit_limit)as avg_credit_limit,
--     rank()over(order by avg(cust_credit_limit) desc)as rank_by_avg_credit_limit
--     from sh.customers
--     GROUP BY cust_income_level
--     ORDER BY rank_by_avg_credit_limit

--15.Calculate the average credit limit over the last 10 customers (sliding window).
-- select
--     cust_id,
--     cust_credit_limit,
--     avg(cust_credit_limit)over(order by
--      cust_id
--      rows between 9 preceding and current row )as avg_credit_limit_of_last_ten
--from sh.customers
--order by cust_id

--16.For each state, calculate the cumulative total of credit limits ordered by city.
-- select
--     CUST_STATE_PROVINCE,
--     cust_credit_limit,
--     cust_city,
--     sum(cust_credit_limit)over ( partition by (cust_state_province) order by cust_city,CUST_STATE_PROVINCE
--     rows between UNBOUNDED preceding and current row)as cumulative_total
--     from sh.customers

--17.Find customers whose credit limit equals the median credit limit (use PERCENTILE_CONT(0.5)).
-- SELECT
--     cust_id,         
--     cust_first_name,      
--     cust_credit_limit
-- FROM
--     sh.customers
-- WHERE
--     cust_credit_limit = (
--         SELECT
--             PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY cust_credit_limit) 
--         FROM
--             sh.customers)

--18.Display the highest 3 credit holders per state using ROW_NUMBER() and PARTITION BY.
-- select
--     cust_state_province,
--     cust_first_name,
--     cust_last_name,
--     cust_credit_limit,
--     row_num
--     from ( 
--         select
--         cust_state_province,
--         cust_first_name,
--         cust_last_name,
--         cust_credit_limit,
--         ROW_NUMBER ()over (partition by cust_state_province order by cust_credit_limit desc)as row_num
--         from sh.customers
--         )
--         where row_num<=3
--         order by cust_state_province,row_num

 --19.Identify customers whose credit limit increased compared to previous row (using LAG).
-- SELECT *
-- FROM (
--     SELECT
--         cust_id,
--         cust_first_name,
--         cust_last_name,
--         cust_credit_limit,
--         LAG(cust_credit_limit) OVER (ORDER BY cust_id) AS previous_credit_limit
--     FROM SH.CUSTOMERS
-- )
-- WHERE cust_credit_limit > previous_credit_limit

--20.Calculate moving average of credit limits with a window of 3.
-- select 
--     cust_id,
--     cust_credit_limit,
--     avg(cust_credit_limit)over(order by cust_id
--     rows between 2  preceding and current row) as moving_avg_of_3_rows
--     from sh.CUSTOMERS

--21.Show cumulative percentage of total credit limit per country.









--22.Rank customers by age (derived from CUST_YEAR_OF_BIRTH).
-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_LAST_NAME,
--     CUST_YEAR_OF_BIRTH,
--     EXTRACT(YEAR FROM SYSDATE)-CUST_YEAR_OF_BIRTH AS AGE,
--     RANK()OVER(ORDER BY EXTRACT(YEAR FROM SYSDATE)-CUST_YEAR_OF_BIRTH DESC)AS AGE_RANK
-- FROM SH.CUSTOMERS

--23.Calculate difference in age between current and previous customer in the same state.
-- SELECT 
--     CUST_STATE_PROVINCE,
--     CUST_YEAR_OF_BIRTH,
--     EXTRACT(YEAR FROM SYSDATE) -CUST_YEAR_OF_BIRTH AS AGE,

--     LAG(EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)
--     OVER(PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_YEAR_OF_BIRTH)AS PREV_CUSTOMER_AGE,

--     (EXTRACT(YEAR FROM SYSDATE)-CUST_YEAR_OF_BIRTH)-
--     LAG( EXTRACT(YEAR FROM SYSDATE)-CUST_YEAR_OF_BIRTH)
-- OVER(PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_YEAR_OF_BIRTH)AS LAG_AGE_DIFF
-- FROM SH.CUSTOMERS


--24.Use RANK() and DENSE_RANK() to show how ties are treated differently.






--25.Compare each state’s average credit limit with country average using window partition.
-- select 
--     country_id,
--     cust_state_province,
--     avg(cust_credit_limit) over(partition by cust_state_province)as state_avg_limit,
--     AVG(cust_Credit_Limit) OVER () AS Country_avg_Limit,
--     (AVG(cust_Credit_Limit) OVER (PARTITION BY cust_State_province) - AVG(CUST_CREDIT_LIMIT) OVER ()) AS Diff_From_Country
--     FROM sh.customers

--26.Show total credit per state and also its rank within each country.
-- SELECT
--     country_id,
--     cust_state_province,
--     SUM(cust_credit_limit) AS total_credit,
--     RANK() OVER (PARTITION BY COUNTRY_ID ORDER BY SUM(cust_credit_limit) DESC) AS state_rank
-- FROM sh.customers
-- GROUP BY country_id,cust_state_province

--27.Find customers whose credit limit is above the 90th percentile of their income level.










--28.Display top 3 and bottom 3 customers per country by credit limit.
-- with ranked_customers as (
--     select cust_id,country_id,cust_credit_limit,
--     row_number() over (partition by country_id order by cust_credit_limit desc) as rn_top,
--     row_number() over (partition by country_id order by cust_credit_limit asc) as rn_bottom
-- from sh.customers
-- )
-- select * from 
-- ranked_customers where rn_top <= 3 or rn_bottom <= 3 order by country_id, rn_top, rn_bottom

--29.Calculate rolling sum of 5 customers’ credit limit within each country.
-- select
--     cust_id,
--     country_id,
--     cust_credit_limit,
--     sum(cust_credit_limit)over(
--     partition by country_id order by cust_id
--     rows between 4 preceding and current row
--     ) as rolling_sum_of_five
-- from sh.customers
-- order by country_id,cust_id

--30.For each marital status, display the most and least wealthy customers using analytical functions.
-- with ranked_customers AS (
--     Select
--         cust_id,
--         cust_first_name,
--         cust_last_name,
--         cust_marital_status,
--         cust_credit_limit,
--         ROW_NUMBER() Over (
--             Partition by cust_marital_status
--             Order by cust_credit_limit desc
--         ) AS rn_highest,
--         ROW_NUMBER() over (
--             partition by cust_marital_status
--             Order by cust_credit_limit asc
--         ) AS rn_lowest
--     FROM sh.customers
-- )
-- Select
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_marital_status,
--     cust_credit_limit,
--     Case
--         When rn_highest = 1 Then'Most Wealthy'
--         When rn_lowest = 1 Then 'Least Wealthy'
--     end AS wealth_rank
-- from ranked_customers
-- where rn_highest = 1 or rn_lowest = 1
-- order by cust_marital_status, wealth_rank

--🧠 C. Conditional, CASE, and DECODE (10 Questions)

--1.Categorize customers into income tiers: Platinum, Gold, Silver, Bronze.
-- SELECT
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_income_level,
--     CASE
--         WHEN cust_income_level LIKE 'Over $170%' THEN 'Platinum'
--         WHEN cust_income_level LIKE '$90,000 - $%' THEN 'Gold'
--         WHEN cust_income_level LIKE '$30,000 - $89,999%' 
--              OR cust_income_level LIKE '$50,000 - $69,999%' 
--              OR cust_income_level LIKE '$70,000 - $89,999%' THEN 'Silver'
--         ELSE 'Bronze'
--     END AS income_tier
-- FROM sh.customers

--2.Display “High”, “Medium”, or “Low” income categories based on credit limit.
-- select
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_credit_limit,
--     CASE
--         when cust_credit_limit>=15000 then 'high'
--         when cust_credit_limit>=5000 then 'medium'
--     else 'low'
--     end as income_category
-- from sh.CUSTOMERS

--3.Replace NULL income levels with “Unknown” using NVL.
-- Select
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     nvl(cust_income_level, 'Unknown') AS income_level
-- from sh.customers
-- where cust_income_level is null

--4.Show customer details and mark whether they have above-average credit limit or not.
-- select 
--      cust_id,
--      cust_first_name,
--      cust_last_name,
--      cust_credit_limit,
--      CASE
--         when cust_credit_limit>(select avg(cust_credit_limit)from sh.customers)
--         then 'Above Average'
--     else 'Below Average'
--     end as cust_credit_status
-- from sh.customers

--5.Use DECODE to convert marital status codes (S/M/D) into full text.
-- select
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_marital_status,
--     Decode(
--     cust_marital_status,
--     'S', 'Single',
--     'M', 'Married',
--     'D', 'Divorced',
--     'Unknown'
--      ) as marital_status_full
-- from sh.customers

--6.Use CASE to show age group (≤30, 31–50, >50) from CUST_YEAR_OF_BIRTH.
-- select
--     cust_id,
--     cust_first_name,
--     cust_last_name,
--     cust_year_of_birth,
--     (2025 - cust_year_of_birth) as age,
--     case
--         when (2025 - cust_year_of_birth) <= 30 then '≤30'
--         when (2025 - cust_year_of_birth) between 31 and  50 then'31–50'
--         else '>50'
--     end as age_group
-- from sh.customers

--7.Label customers as “Old Credit Holder” or “New Credit Holder” based on year of birth < 1980.
-- select
--     cust_first_name,
--     cust_last_name,
--     cust_year_of_birth,
--     extract(year  from sysdate)- cust_year_of_birth as age_of_customer,
--     case
--         when CUST_YEAR_OF_BIRTH<1980 then 'old Credit Holder'
--         else 'New credit holder'
--     end as age_group_of_credit
--     from sh.customers

--8.Create a loyalty tag — “Premium” if credit limit > 50,000 and income_level = ‘E’.
-- select
--     cust_first_name,
--     cust_last_name,
--     cust_income_level,
--     cust_credit_limit,
--     case
--         when cust_credit_limit>'50000' or cust_income_level='E' then'premium'
--         else  'standard'
--     end as premium_tag
-- from sh.customers
-- where cust_credit_limit > 50000 or cust_income_level = 'E'

--9.Assign grades (A–F) based on credit limit range using CASE.
-- select
--     cust_first_name,
--     cust_last_name,
--     cust_Credit_Limit,
--     case
--         when cust_credit_limit>=15000 then 'A'
--         when cust_credit_limit>=11000 then 'B'
--         when cust_credit_limit>=7000 then 'C'
--         when cust_credit_limit>=2000 then 'D'
--     else 'F'
--     END AS grades_for_credit
-- from sh.customers

--10.Show country, state, and number of premium customers using conditional aggregation.
-- SELECT 
--     country_id,
--     cust_State_province,
--     COUNT(CASE WHEN cust_credit_limit > 50000 THEN 1 END) AS premium_customers
-- FROM 
--     sh.customers
-- GROUP BY 
--     country_id, cust_state_province
-------------------------------------------------------------
--📅 D. Date & Conversion Functions (10 Questions)

--1.Convert CUST_YEAR_OF_BIRTH to age as of today.
-- select
--     cust_year_of_birth,
--    extract(year from current_date)-cust_year_of_birth as age_today
--     from sh.customers

--2.Display all customers born between 1980 and 1990.
-- Select 
--     cust_first_name,
--     cust_last_name,
--     cust_year_of_birth
--     from sh.customers
-- where cust_year_of_birth between 1980 and 1990
-- order by cust_year_of_birth 

--3.Format date of birth into “Month YYYY” using TO_CHAR.
-- select
--     cust_first_name,
--     cust_last_name,
--     cust_year_of_birth,
--     To_char(To_date(cust_year_of_birth, 'YYYY'), 'Month YYYY') as formatted_dob
-- from
--     sh.customers

--4.Convert income level text (like 'A: Below 30,000') to numeric lower limit.
-- SELECT
--     cust_income_level,
--     CASE
--         WHEN cust_income_level = 'A: Below 30,000' THEN 0
--         WHEN cust_income_level = 'B: 30,000 - 49,999' THEN 30000
--         WHEN cust_income_level = 'C: 50,000 - 69,999' THEN 50000
--         WHEN cust_income_level = 'D: 70,000 - 89,999' THEN 70000
--         WHEN cust_income_level = 'E: 90,000 - 109,999' THEN 90000
--         WHEN cust_income_level = 'F: 110,000 - 129,999' THEN 110000
--         WHEN cust_income_level = 'G: 130,000 or more' THEN 130000
--         ELSE NULL
--     END AS income_lower_limit
-- FROM 
--     sh.customers

--5.Display customer birth decades (e.g., 1960s, 1970s).
-- Select
--     cust_first_name,
--     cust_last_name,
--     cust_year_of_birth,
--     (floor(cust_year_of_birth / 10) * 10) || 's' as birth_decade
-- from
--     sh.customers

--6.Show customers grouped by age bracket (10-year intervals).
-- SELECT 
--     (FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(cust_year_of_birth, 'YYYY')) / 12 / 10) * 10) AS age_bracket_start,
--     COUNT(*) AS customer_count
-- FROM 
--     sh.customers
-- GROUP BY 
--     FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(cust_year_of_birth, 'YYYY')) / 12 / 10)
-- ORDER BY 
--     age_bracket_start

--7.Convert country_id to uppercase and state name to lowercase.
-- select
--     country_id,
--     cust_state_province,
--     upper(country_id) as country_id_upper,
--     lower(cust_state_province) as state_lower
-- from
--     sh.customers

--8.Show customers where credit limit > average of their birth decade.
-- SELECT 
--     c.cust_id,
--     c.cust_first_name,
--     c.cust_year_of_birth,
--     c.cust_credit_limit,
--     d.avg_credit_limit AS decade_avg_credit_limit
-- FROM 
--     sh.customers c
-- JOIN (
--     SELECT 
--         FLOOR(cust_year_of_birth / 10) * 10 AS birth_decade,
--         AVG(cust_credit_limit) AS avg_credit_limit
--     FROM 
--         sh.customers
--     WHERE cust_year_of_birth IS NOT NULL
--     GROUP BY 
--         FLOOR(cust_year_of_birth / 10) * 10
-- ) d 
-- ON FLOOR(c.cust_year_of_birth / 10) * 10 = d.birth_decade
-- WHERE 
--     c.cust_credit_limit > d.avg_credit_limit

--9.Convert all numeric credit limits to currency format $999,999.00.
-- Select
--     cust_first_name,
--     cust_last_name,  
--     cust_credit_limit,
--     TO_CHAR(cust_credit_limit, '$999,999.00')as numeric_credit
--     from sh.customers

--10.Find customers whose credit limit was NULL and replace with average (using NVL).
-- Select
--     cust_id,
--     cust_first_name,
--     cust_credit_limit,
--     NVL(cust_credit_limit, (SELECT AVG(cust_credit_limit) FROM sh.customers)) AS updated_credit_limit
--     from sh.customers
--     WHERE cust_credit_limit IS NULL

--🔢 E. String Functions (10 Questions)
--1.Show customers whose first and last name start with the same letter.
-- SELECT 
--     cust_id,
--     cust_first_name,
--     cust_last_name
-- FROM 
--     sh.customers
-- WHERE 
--     UPPER(SUBSTR(cust_first_name, 1, 1)) = UPPER(SUBSTR(cust_last_name, 1, 1))

--2.Display full names in “Last, First” format.
-- Select
--     cust_first_name,
--     cust_last_name,
--     cust_last_name ||','||cust_first_name
--     from sh.customers

--3.Find customers whose last name ends with 'SON'.
-- SELECT 
--     cust_last_name
-- FROM sh.customers
-- WHERE SUBSTR(cust_last_name, -3) = 'SON'

--4.Display length of each customer’s full name.
-- select
--     cust_first_name,
--     cust_last_name,
--     cust_first_name|| cust_last_name,
--     length(cust_first_name|| cust_last_name)as full_name_length
--     from sh.customers

--5.Replace vowels in customer names with '*'.
-- Select
--     cust_first_name,
--     cust_last_name,
--     cust_first_name||cust_first_name as full_name,
--     REGEXP_REPLACE(cust_first_name||cust_first_name,'[AEIOUaeiou]', '*') AS replaced_name
--     from sh.customers

--6.Show customers whose income level description contains ‘90’.
-- Select
--     cust_first_name,
--     cust_last_name,
--     cust_income_level
--     from sh.customers
-- where regexp_like(cust_income_level, '90')

--7.Display initials of each customer (first letters of first and last name).
-- select
--     cust_first_name,
--     cust_last_name,
--     substr(cust_first_name, 1, 1) || substr(cust_last_name, 1, 1) as initials
-- from sh.customers

--8.Concatenate city and state to create full address.
-- select
--     cust_city,
--     cust_state_province,
--      cust_city||','||cust_state_province as full_address
--     from sh.customers

--9.Extract numeric value from income level using REGEXP_SUBSTR.
-- SELECT
--     cust_income_level,
--     REGEXP_SUBSTR(cust_income_level,'\d+') AS numeric_value
-- FROM sh.customers

--10.Count how many customers have a 3-letter first name.
-- select
--     cust_first_name,
--     count(*)cust_first_name
--     from sh.customers
--     where length(cust_first_name)=3
--     group by cust_first_name

--🧩 F. Joins with Analytical Logic (10 Questions)
--1.Join SH.CUSTOMERS and SH.SALES to find customers with the highest sales totals.
-- SELECT 
--     c.CUST_ID,
--     c.CUST_FIRST_NAME,
--     c.CUST_LAST_NAME,
--     SUM(s.AMOUNT_SOLD) AS TOTAL_SALES
-- FROM 
--     SH.CUSTOMERS c
-- JOIN 
--     SH.SALES s
--     ON c.CUST_ID = s.CUST_ID
-- GROUP BY 
--     c.CUST_ID, c.CUST_FIRST_NAME, c.CUST_LAST_NAME
-- ORDER BY 
--     TOTAL_SALES DESC

--2.For each customer, show their total sales amount and their rank within country.
-- SELECT 
--     c.cust_id,
--     c.cust_first_name || ', ' || c.cust_last_name AS customer_name,
--     c.country_id,
--     SUM(s.amount_sold) AS total_sales,
--     RANK() OVER (
--         PARTITION BY c.country_id 
--         ORDER BY SUM(s.amount_sold) DESC
--     ) AS country_rank
-- FROM 
--     sh.customers c
-- JOIN 
--     sh.sales s ON c.cust_id = s.cust_id
-- GROUP BY 
--     c.cust_id, c.cust_last_name, c.cust_first_name, c.country_id
-- ORDER BY 
--     c.country_id, country_rank

--3.Find customers who purchased more than average sales amount of their country.
-- WITH customer_totals AS (
--     SELECT 
--         c.cust_id,
--         c.cust_first_name || ' ' || c.cust_last_name AS customer_name,
--         c.country_id,
--         SUM(s.amount_sold) AS total_sales
--     FROM 
--         sh.customers c
--     JOIN 
--         sh.sales s ON c.cust_id = s.cust_id
--     GROUP BY 
--         c.cust_id, c.cust_first_name, c.cust_last_name, c.country_id
-- ),
-- country_avg AS (
--     SELECT 
--         country_id,
--         AVG(total_sales) AS avg_sales
--     FROM 
--         customer_totals
--     GROUP BY 
--         country_id
-- )
-- SELECT 
--     ct.cust_id,
--     ct.customer_name,
--     ct.country_id,
--     ct.total_sales,
--     ca.avg_sales
-- FROM 
--     customer_totals ct
-- JOIN 
--     country_avg ca ON ct.country_id = ca.country_id
-- WHERE 
--     ct.total_sales > ca.avg_sales
-- ORDER BY 
--     ct.country_id, ct.total_sales DESC

--4.Display top 3 spenders per state.
-- WITH customer_sales AS (
--     SELECT 
--         c.cust_id,
--         c.cust_first_name || ' ' || c.cust_last_name AS customer_name,
--         c.cust_state_province AS state,
--         SUM(s.amount_sold) AS total_sales
--     FROM 
--         sh.customers c
--     JOIN 
--         sh.sales s ON c.cust_id = s.cust_id
--     GROUP BY 
--         c.cust_id, c.cust_first_name, c.cust_last_name, c.cust_state_province
-- ),
-- ranked_customers AS (
--     SELECT 
--         cust_id,
--         customer_name,
--         state,
--         total_sales,
--         RANK() OVER (
--             PARTITION BY state 
--             ORDER BY total_sales DESC
--         ) AS state_rank
--     FROM 
--         customer_sales
-- )
-- SELECT 
--     cust_id,
--     customer_name,
--     state,
--     total_sales,
--     state_rank
-- FROM 
--     ranked_customers
-- WHERE 
--     state_rank <= 3
-- ORDER BY 
--     state, state_rank

--5.Rank customers within each country by total sales quantity.
-- WITH customer_totals AS (
--     SELECT
--         c.cust_id,
--         c.cust_first_name || ' ' || c.cust_last_name AS customer_name,
--         c.country_id,
--         SUM(s.quantity_sold) AS total_quantity
--     FROM
--         sh.customers c
--     JOIN
--         sh.sales s ON c.cust_id = s.cust_id
--     GROUP BY
--         c.cust_id, c.cust_first_name, c.cust_last_name, c.country_id
-- )
-- SELECT
--     cust_id,
--     customer_name,
--     country_id,
--     total_quantity,
--     RANK() OVER (PARTITION BY country_id ORDER BY total_quantity DESC) AS country_rank
-- FROM
--     customer_totals
-- ORDER BY
--     country_id,
--     country_rank

--6.Calculate each customer’s contribution percentage to country-level sales.
-- WITH customer_totals AS (
--     SELECT
--         c.cust_id,
--         c.cust_first_name || ' ' || c.cust_last_name AS customer_name,
--         c.country_id,
--         SUM(s.amount_sold) AS total_sales
--     FROM
--         sh.customers c
--     JOIN
--         sh.sales s ON c.cust_id = s.cust_id
--     GROUP BY
--         c.cust_id, c.cust_first_name, c.cust_last_name, c.country_id
-- ),
-- country_totals AS (
--     SELECT
--         country_id,
--         SUM(total_sales) AS country_sales
--     FROM
--         customer_totals
--     GROUP BY
--         country_id
-- )
-- SELECT
--     ct.cust_id,
--     ct.customer_name,
--     ct.country_id,
--     ct.total_sales,
--     ROUND((ct.total_sales / ctot.country_sales) * 100, 2) AS contribution_pct
-- FROM
--     customer_totals ct
-- JOIN
--     country_totals ctot ON ct.country_id = ctot.country_id
-- ORDER BY
--     ct.country_id,
--     contribution_pct DESC

--7.Identify customers whose sales have decreased compared to previous month.























--8.Show customers who have never made a sale.
-- SELECT c.*
-- FROM sh.customers c
-- LEFT JOIN sh.sales s ON c.Cust_ID = s.Cust_ID
-- WHERE s.Cust_ID IS NULL

--9.Find correlation between credit limit and total sales (using GROUP BY + analytics).
-- WITH total_sales_per_customer AS (
--     SELECT
--         s.Cust_ID,
--         SUM(s.Amount_sold) AS total_sales
--     FROM sh.sales s
--     GROUP BY s.Cust_ID
-- ),
-- customer_sales_data AS (
--     SELECT
--         c.Cust_ID,
--         c.cust_Credit_Limit,
--         t.total_sales
--     FROM sh.customers c
--     JOIN total_sales_per_customer t ON c.Cust_ID = t.Cust_ID
-- )
-- SELECT
--     CORR(cust_Credit_Limit, total_sales) AS credit_sales_correlation
-- FROM customer_sales_data

--10.Show moving average of monthly sales per customer.
-- SELECT
--     c.cust_id,
--     TO_CHAR(TRUNC(s.time_id, 'MM'), 'YYYY-MM') AS month,
--     SUM(s.amount_sold) AS monthly_sales,
--     ROUND(
--         AVG(SUM(s.amount_sold)) 
--         OVER (
--             PARTITION BY c.cust_id 
--             ORDER BY TRUNC(s.time_id, 'MM') 
--             ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
--         ), 
--         2
--     ) AS moving_avg_3_month
-- FROM
--     sh.sales s
-- JOIN
--     sh.customers c ON s.cust_id = c.cust_id
-- GROUP BY
--     c.cust_id,
--     TRUNC(s.time_id, 'MM')
-- ORDER BY
--     c.cust_id,
--     month;

--📈 G. Advanced Analytical Patterns (10 Questions)
--1.Compute z-score normalization of customer credit limits.
-- SELECT
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     ROUND(
--         (CUST_CREDIT_LIMIT - AVG(CUST_CREDIT_LIMIT) OVER ()) 
--         / STDDEV(CUST_CREDIT_LIMIT) OVER (), 2
--     ) AS Z_SCORE
-- FROM SH.CUSTOMERS
-- WHERE CUST_CREDIT_LIMIT IS NOT NULL

--2.Calculate the Gini coefficient of credit limit inequality per country.
-- WITH RankedCreditData AS (
--    SELECT
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (
--             PARTITION BY COUNTRY_ID
--             ORDER BY CUST_CREDIT_LIMIT ASC
--         ) AS account_rank_i,

--         COUNT(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) AS total_accounts_n,

--          SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) AS total_limit_sum_y
--     FROM
--         SH.CUSTOMERS
--     WHERE
--         CUST_CREDIT_LIMIT IS NOT NULL
--         AND CUST_CREDIT_LIMIT > 0
-- )
-- SELECT
--     COUNTRY_ID,
--      SUM(
--         (2 * account_rank_i - total_accounts_n - 1) * CUST_CREDIT_LIMIT
--     ) /
--     (
--         MAX(total_accounts_n) * MAX(total_limit_sum_y)
--     ) AS Gini_Coefficient
-- FROM
--     RankedCreditData
-- GROUP BY
--     COUNTRY_ID
-- HAVING
--     MAX(total_accounts_n) > 1
--     AND MAX(total_limit_sum_y) > 0
-- ORDER BY
--     Gini_Coefficient DESC;

--3.Find customers whose credit limit is above the 75th percentile and below the 90th percentile.
-- WITH CountryPercentiles AS (
--     SELECT
--         COUNTRY_ID,
--         PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT) AS P75_LIMIT,
--         PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT) AS P90_LIMIT
--     FROM SH.CUSTOMERS
--     WHERE CUST_CREDIT_LIMIT IS NOT NULL
--       AND CUST_CREDIT_LIMIT > 0
--     GROUP BY COUNTRY_ID
-- )
-- SELECT
--     C.CUST_ID,
--     C.COUNTRY_ID,
--     C.CUST_CREDIT_LIMIT,
--     CP.P75_LIMIT,
--     CP.P90_LIMIT
-- FROM SH.CUSTOMERS C
-- JOIN CountryPercentiles CP
--     ON C.COUNTRY_ID = CP.COUNTRY_ID
-- WHERE
--     C.CUST_CREDIT_LIMIT > CP.P75_LIMIT
--     AND C.CUST_CREDIT_LIMIT < CP.P90_LIMIT
-- ORDER BY
--     C.COUNTRY_ID,
--     C.CUST_CREDIT_LIMIT

--4.Use analytical functions to compute the rank difference between two states.
-- WITH country_sales AS (
--     SELECT
--         c.COUNTRY_ID,
--         SUM(s.AMOUNT_SOLD) AS TOTAL_SALES
--     FROM SH.CUSTOMERS c
--     JOIN SH.SALES s
--         ON c.CUST_ID = s.CUST_ID
--     GROUP BY c.COUNTRY_ID
-- ),
-- ranked AS (
--     SELECT
--         COUNTRY_ID,
--         TOTAL_SALES,
--         RANK() OVER (ORDER BY TOTAL_SALES DESC) AS SALES_RANK
--     FROM country_sales
-- )
-- SELECT
--     a.COUNTRY_ID AS COUNTRY_1_ID,
--     b.COUNTRY_ID AS COUNTRY_2_ID,
--     a.SALES_RANK AS COUNTRY_1_RANK,
--     b.SALES_RANK AS COUNTRY_2_RANK,
--     ABS(a.SALES_RANK - b.SALES_RANK) AS RANK_DIFFERENCE
-- FROM ranked a
-- JOIN ranked b
--     ON a.COUNTRY_ID = 52790   
--    AND b.COUNTRY_ID = 52776;

--5.Find the median and interquartile range of credit limit per state.
-- SELECT
--     cust_state_province,
--     MEDIAN(cust_credit_limit) AS median_credit_limit,
--     PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cust_credit_limit) AS q1,
--     PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cust_credit_limit) AS q3,
--     PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cust_credit_limit)
--       - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cust_credit_limit) AS iqr
-- FROM
--     sh.customers
-- GROUP BY
--     cust_state_province
-- ORDER BY
--     cust_state_province;

--6.Identify outliers in credit limit using IQR method.
-- WITH state_stats AS (
--     SELECT
--         cust_state_province,
--         PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cust_credit_limit) AS q1,
--         PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cust_credit_limit) AS q3,
--         (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cust_credit_limit)
--          - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cust_credit_limit)) AS iqr
--     FROM
--         sh.customers
--     GROUP BY
--         cust_state_province
-- )
-- SELECT
--     c.cust_state_province,
--     c.cust_id,
--     c.cust_credit_limit,
--     s.q1,
--     s.q3,
--     s.iqr,
--     (s.q1 - 1.5 * s.iqr) AS lower_bound,
--     (s.q3 + 1.5 * s.iqr) AS upper_bound,
--     CASE
--         WHEN c.cust_credit_limit < (s.q1 - 1.5 * s.iqr) THEN 'Below Lower Bound (Outlier)'
--         WHEN c.cust_credit_limit > (s.q3 + 1.5 * s.iqr) THEN 'Above Upper Bound (Outlier)'
--         ELSE 'Normal'
--     END AS outlier_flag
-- FROM
--     sh.customers c
-- JOIN
--     state_stats s
-- ON
--     c.cust_state_province = s.cust_state_province
-- ORDER BY
--     c.cust_state_province,
--     c.cust_credit_limit;

--7.Calculate credit limit growth per customer over years (if historical data exists).























--8.Create a running average of credit limit by customer ID.