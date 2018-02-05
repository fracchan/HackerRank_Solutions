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

-- The Report
select if(gr.grade < 8, NULL, st.name) as 'name', gr.grade, st.marks
from students st
join grades gr on st.marks between gr.min_mark and gr.max_mark
order by gr.grade desc, st.name
;