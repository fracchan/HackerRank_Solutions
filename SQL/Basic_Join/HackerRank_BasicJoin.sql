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

-- Ollivander's Inventory
/*
Following solution does not work on HackerRank website due to 
the "sql_mode=only_full_group_by" mode chosen by HackerRank
that make impossible to group by fewer fields than the ones
in the select clause

select wa.id, wp.age, wa.coins_needed, wa.power
from wands wa
join wands_property wp using(code)
where is_evil = 0 
group by wa.code, wa.power
having min(wa.coins_needed)
order by wa.power desc, wp.age desc
;
*/

select wa.id, wp.age, wa.coins_needed, wa.power 
from wands as wa
join wands_property as wp on (wa.code = wp.code) 
where wp.is_evil = 0 
and wa.coins_needed = (select min(coins_needed) 
                      from wands as w1 
                      where w1.code = wa.code 
                      and w1.power = wa.power 
                      ) 
order by wa.power desc, wp.age desc
;

-- Challenges
select ha.hacker_id
, ha.name
, count(ch.challenge_id) as total
from hackers ha
join challenges ch using (hacker_id)
group by hacker_id, ha.name
having total =
-- this total is max number of challenge created by a single hacker
-- outputs all the hacker_id
  (select max(t1.cnt)
   from (select count(challenge_id) as cnt
         from challenges
         group by hacker_id) t1
   )
   or total in 
-- this total is a list of all the different number of challenges created by the
-- various hackers skipping the number of challenges if more than one hacker
-- created the same amount of challenges
   (select t2.cnt 
    from (select count(challenge_id) as cnt
          from challenges
          group by hacker_id) t2
    group by t2.cnt
    having count(t2.cnt)=1 
    )
order by count(ch.challenge_id) desc, ha.hacker_id
;

-- Contest Leaderboard
SELECT ha.hacker_id, ha.name, SUM(max_score) AS total_score
FROM hackers ha 
JOIN (
  SELECT hacker_id
  , challenge_id
  , MAX(score) AS max_score
  FROM submissions
  GROUP BY hacker_id, challenge_id
  HAVING max_score > 0
) AS t1
ON ha.hacker_id = t1.hacker_id
GROUP BY ha.hacker_id, ha.name
ORDER BY total_score DESC, ha.hacker_id
;

