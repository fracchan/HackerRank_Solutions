-- Revising Aggregations - The Count Function
select count(*)
from city
where population > 100000
;

-- Revising Aggregations - The Sum Function
select sum(population)
from city
where district = 'california'
;

-- Revising Aggregations - Averages
select avg(population)
from city
where district = 'california'
;

-- Average Population
select floor(avg(population))
from city
;

-- Japan Population
select sum(population)
from city
where countrycode = 'JPN'
;

-- Population Density Difference
select max(population) - min(population)
from city
;

-- The Blunder
select ceil(avg(salary) - avg(replace(salary, '0',''))) as 'error'
from employees
;

-- Top Earners
-- group by `num` and order by `num` num is the column (e.g. 1 is the first column)
-- limit `num` num is the number of rows to display
select (salary * months)
, count(*)
from employee
group by 1
order by 1 desc
limit 1
;

-- Weather Observation Station 2
select round(sum(lat_n),2)
, round(sum(long_w),2)
from station
;

-- Weather Observation Station 13
-- cannot use between for the where clause since between is inclusive
-- the challenge requires to not include the extremes
select truncate(sum(lat_n),4)
from station
where lat_n > 38.7880 
  and lat_n < 137.2345
;

-- Weather Observation Station 14
select truncate(max(lat_n),4)
from station
where lat_n < 137.2345
;

-- Weather Observation Station 15
select round(long_w,4)
from station
where lat_n = (
    select max(lat_n)
    from station
    where lat_n < 137.2345
  )
;

select round(long_w,4)
from station
where lat_n < 137.2345
order by lat_n desc
limit 1
;

-- Weather Observation Station 16
select round(min(lat_n),4)
from station
where lat_n > 38.7780
;

select round(lat_n,4)
from station
where lat_n > 38.7780
order by lat_n
limit 1
;

-- Weather Observation Station 17
select round(long_w,4)
from station
where lat_n > 38.7780
order by lat_n
limit 1
;
-- Weather Observation Station 18
-- not using absolute value for the Manhattan Distance since ordered them from 
-- biggest to smallest
-- not even all the parentheses are actually necessary
select round(((max(lat_n) - min(lat_n)) + (max(long_w)-min(long_w))),4)
from station
;

-- Weather Observation Station 19
-- euclidean distance
select round(
    sqrt(pow(max(lat_n) - min(lat_n),2) + pow(max(long_w)-min(long_w),2))
 ,4)
from station
;

-- Weather Observation Station 20
-- median
-- WHERE 1 is a no-op. But if you add a WHERE clause to the top one query, 
-- you need to add the identical WHERE clause to the other.
SELECT round(avg(t1.lat_n),4) as 'median' 
FROM (
    SELECT @rownum:=@rownum+1 as `row_number`, s.lat_n
    FROM station s,  (SELECT @rownum:=0) r
    WHERE 1
    ORDER BY s.lat_n
) as t1, 
(
  SELECT count(*) as total_rows
  FROM station s
  WHERE 1
) as t2
WHERE t1.row_number in (floor((total_rows+1)/2), floor((total_rows+2)/2));
