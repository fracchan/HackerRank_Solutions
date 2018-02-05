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

-- Top Competitors
/*
To Avoid the following error message, need to group by all the columns in the select
statement. This message can or cannot appear base on the mysql options chosen. 

ERROR 1055 (42000) at line 1: Expression #2 of SELECT list is not in GROUP BY 
  clause and contains nonaggregated column 'run_0iw2oz7eqxy.ha.name' 
  which is not functionally dependent on columns in GROUP BY clause; 
  this is incompatible with sql_mode=only_full_group_by
*/
select ha.hacker_id, ha.name
from hackers ha
join submissions su using (hacker_id)
join challenges ch using (challenge_id)
join difficulty di using (difficulty_level)
where su.score = di.score
group by ha.hacker_id, ha.name
having count(ch.challenge_id) > 1
order by count(ch.challenge_id) desc, ha.hacker_id
;

