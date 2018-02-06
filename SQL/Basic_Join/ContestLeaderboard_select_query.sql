/*
This file shows the thinking process of developing the final select query.

All four select statements are successful, but the execution time varies between them.
Especially the first two solutions are slower than the other two having an additional 
layer of subquery. But writing an optimal solution at the first try is usually pure luck.
*/

select hacker_id, name, total_score
from (
  select hacker_id, name, sum(max_score) as total_score
  from (
    select hacker_id, name, max(score) as max_score
    from hackers
    join submissions using (hacker_id)
    group by hacker_id, name, challenge_id
  ) t1
  group by hacker_id, name
) t2
where total_score > 0
order by total_score desc, hacker_id
;

-- MOVING THE SCORE > 0 FROM A WHERE CLAUSE ON THE OUTEST SELECT TO THE INNERMOST ONE
-- if the max score is 0, nothing changes in the sum, but we get rid of all the null score
-- and if a hacker has only null scores, we do not have a sum score of 0 for him.
select hacker_id, name, total_score
from (
  select hacker_id, name, sum(max_score) as total_score
  from (
    select hacker_id, name, max(score) as max_score
    from hackers
    join submissions using (hacker_id)
    group by hacker_id, name, challenge_id
    having max(score) > 0
  ) t1
  group by hacker_id, name
) t2
order by total_score desc, hacker_id
;

/*
Removing one query layer. We join the submissions and hackers table only for 
showing the final result. Thus removing the inner join and the group by name part. 
We obtain this result using:
A) Cartesian join
B) Inner join

NOTE: these last two queries have equivalent execution time. I had one or the other 
performing better. Usually an inner join is more efficient than a cartesian join.
*/
-- A) CARTESIAN JOIN
SELECT ha.hacker_id, ha.name, SUM(max_score) AS total_score
FROM hackers ha, 
(
  SELECT hacker_id
  , challenge_id
  , MAX(score) AS max_score
  FROM submissions
  GROUP BY hacker_id, challenge_id
  HAVING max_score > 0
) AS t1
WHERE ha.hacker_id = t1.hacker_id
GROUP BY ha.hacker_id, ha.name
ORDER BY total_score DESC, ha.hacker_id
;

-- B) INNER JOIN
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

