-- Revising the Select Query I
select *
from city
where population > 100000
and countrycode = 'USA'
;

-- Revising the Select Query II
select name
from city
where countrycode = 'USA'
and population > 120000
;

-- Select All
select *
from city
;

-- Select By ID
select *
from city
where ID = 1661
;

-- Japanese Cities' Attributes
select *
from city
where countrycode='JPN'
;

-- Japanese Cities' Names
select name
from city
where countrycode = 'JPN'
;

-- Weather Observation Station 1
select city, state
from station
;

-- Weather Observation Station 3
select distinct city
from station
where mod(id,2) = 0
;

-- Weather Observation Station 4
select count(city) - count(distinct city)
from station
;

-- Weather Observation Station 5
(select city, length(city)
from station
order by length(city), city
limit 1)
union
(select city, length(city)
from station
order by length(city) desc, city
limit 1)
;

-- Weather Observation Station 6
select distinct city
from station
where left(city,1) in ('a','e','i','o','u')
;

-- Weather Observation Station 7
select distinct city
from station
where right(city,1) in ('a','e','i','o','u')
;

-- Weather Observation Station 8
select distinct city
from station
where left(city,1) in ('a','e','i','o','u')
and right(city,1) in ('a','e','i','o','u')
;

-- Weather Observation Station 9
select distinct city
from station
where left(city,1) not in ('a','e','i','o','u')
;

-- Weather Observation Station 10
select distinct city
from station
where right(city,1) not in ('a','e','i','o','u')
;

-- Weather Observation Station 11
select distinct city
from station
where left(city,1) not in ('a','e','i','o','u')
or right(city,1) not in ('a','e','i','o','u')
;

-- Weather Observation Station 12
select distinct city
from station
where left(city,1) not in ('a','e','i','o','u')
and right(city,1) not in ('a','e','i','o','u')
;

-- Higher Than 75 Marks
select name
from students
where marks > 75
order by right(name,3), ID
;

-- Employee Names
select name 
from employee 
order by name;

-- Employee Salaries
select name 
from employee
where salary > 2000
and months < 10
order by employee_id
;
