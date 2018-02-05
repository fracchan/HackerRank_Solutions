-- Asia Population
select sum(ci.population)
from city ci
join country co on ci.countrycode = co.code
where co.continent = 'asia'
;

-- African Cities
select ci.name
from city ci
join country co on ci.countrycode = co.code
where co.continent = 'africa'
;

-- Average Population of Each Continent
select co.continent
, floor(avg(ci.population))
from city ci
join country co on ci.countrycode = co.code
group by co.continent
;

-- 