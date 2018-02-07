/*
Samantha interviews many candidates from different colleges 
using coding challenges and contests. 

Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions,
 total_accepted_submissions, total_views, and total_unique_views 
 for each contest sorted by contest_id. 
 
 Exclude the contest from the result if all four sums are 0.

Note: A specific contest can be used to screen candidates at more than one college, 
but each college only holds 1 screening contest.
*/

-- ======================================================================================
-- STEP BY STEP solution

select challenge_id
, sum(total_views) as sum_view
, sum(total_unique_views) as sum_unique_view
from view_stats
group by challenge_id
;
+--------------+----------+-----------------+
| challenge_id | sum_view | sum_unique_view |
+--------------+----------+-----------------+
|        18765 |      115 |              23 |
|        47127 |       41 |              33 |
|        60292 |       11 |              10 |
|        72974 |       41 |              15 |
|        75516 |      110 |              28 |
+--------------+----------+-----------------+

select challenge_id
, sum(total_submissions) as sum_sub
, sum(total_accepted_submissions) as sum_acc_sub
from submission_stats
group by challenge_id
;
++--------------+---------+-------------+
| challenge_id | sum_sub | sum_acc_sub |
+--------------+---------+-------------+
|        47127 |     111 |          39 |
|        72974 |     150 |          38 |
|        75516 |     191 |          32 |
+--------------+---------+-------------+



/*
-- NOTE: you cannot use a join because you are going to have multiple values sum together
WRONG:
select challenge_id
, sum(total_views) as sum_view
, sum(total_unique_views) as sum_unique_view
, sum(total_submissions) as sum_sub
, sum(total_accepted_submissions) as sum_acc_sub
from view_stats
left join submission_stats using (challenge_id)
group by challenge_id
;

see for example that for challenge_id 47127 the sum_sub went from 111 to 222
+--------------+----------+-----------------+---------+-------------+
| challenge_id | sum_view | sum_unique_view | sum_sub | sum_acc_sub |
+--------------+----------+-----------------+---------+-------------+
|        18765 |      115 |              23 |    NULL |        NULL |
|        47127 |      123 |              99 |     222 |          78 |
|        60292 |       11 |              10 |    NULL |        NULL |
|        72974 |       82 |              30 |     150 |          38 |
|        75516 |      330 |              84 |     382 |          64 |
+--------------+----------+-----------------+---------+-------------+
*/


select con.contest_id
, col.college_id
, cha.challenge_id
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
;

+------------+------------+--------------+
| contest_id | college_id | challenge_id |
+------------+------------+--------------+
|      66406 |      11219 |        18765 |
|      66406 |      11219 |        47127 |
|      66556 |      32473 |        60292 |
|      94828 |      56685 |        72974 |
+------------+------------+--------------+


select con.contest_id
, col.college_id
, cha.challenge_id
, vie.total_views
, vie.total_unique_views
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
join view_stats vie on cha.challenge_id = vie.challenge_id
;

+------------+------------+--------------+-------------+--------------------+
| contest_id | college_id | challenge_id | total_views | total_unique_views |
+------------+------------+--------------+-------------+--------------------+
|      66406 |      11219 |        47127 |          26 |                 19 |
|      66406 |      11219 |        47127 |          15 |                 14 |
|      66406 |      11219 |        18765 |          43 |                 10 |
|      66406 |      11219 |        18765 |          72 |                 13 |
|      66556 |      32473 |        60292 |          11 |                 10 |
|      94828 |      56685 |        72974 |          41 |                 15 |
+------------+------------+--------------+-------------+--------------------+


-- ATT!! You cannot make assumptions
-- you might have views without submissions and submissions without views
-- need to use left join for both tables

select con.contest_id
, con.hacker_id
, con.name
, col.college_id
, cha.challenge_id
, t1.sum_view
, t1.sum_unique_view
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
left join (
  select challenge_id
  , sum(total_views) as sum_view
  , sum(total_unique_views) as sum_unique_view
  from view_stats
  group by challenge_id
) t1 on cha.challenge_id = t1.challenge_id
;

+------------+-----------+--------+------------+--------------+----------+-----------------+
| contest_id | hacker_id | name   | college_id | challenge_id | sum_view | sum_unique_view |
+------------+-----------+--------+------------+--------------+----------+-----------------+
|      66406 |     17973 | Rose   |      11219 |        18765 |      115 |              23 |
|      66406 |     17973 | Rose   |      11219 |        47127 |       41 |              33 |
|      66556 |     79153 | Angela |      32473 |        60292 |       11 |              10 |
|      94828 |     80275 | Frank  |      56685 |        72974 |       41 |              15 |
+------------+-----------+--------+------------+--------------+----------+-----------------+


-- see if you do an inner join instead of outer join

select con.contest_id
, con.hacker_id
, con.name
, col.college_id
, cha.challenge_id
, t1.sum_view
, t1.sum_unique_view
, t2.sum_sub
, t2.sum_acc_sub
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
join (
  select challenge_id
  , sum(total_views) as sum_view
  , sum(total_unique_views) as sum_unique_view
  from view_stats
  group by challenge_id
) t1 on cha.challenge_id = t1.challenge_id
join (
  select challenge_id
  , sum(total_submissions) as sum_sub
  , sum(total_accepted_submissions) as sum_acc_sub
  from submission_stats
  group by challenge_id
) t2 on t1.challenge_id = t2.challenge_id
;


+------------+-----------+-------+------------+--------------+----------+-----------------+---------+-------------+
| contest_id | hacker_id | name  | college_id | challenge_id | sum_view | sum_unique_view | sum_sub | sum_acc_sub |
+------------+-----------+-------+------------+--------------+----------+-----------------+---------+-------------+
|      66406 |     17973 | Rose  |      11219 |        47127 |       41 |              33 |     111 |          39 |
|      94828 |     80275 | Frank |      56685 |        72974 |       41 |              15 |     150 |          38 |
+------------+-----------+-------+------------+--------------+----------+-----------------+---------+-------------+


-- NOTE: outer join for both view_stats and submission_stats tables on the challenge_id
-- of the challenges table

select con.contest_id
, con.hacker_id
, con.name
, col.college_id
, cha.challenge_id
, t1.sum_view
, t1.sum_unique_view
, t2.sum_sub
, t2.sum_acc_sub
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
left join (
  select challenge_id
  , sum(total_views) as sum_view
  , sum(total_unique_views) as sum_unique_view
  from view_stats
  group by challenge_id
) t1 on cha.challenge_id = t1.challenge_id
left join (
  select challenge_id
  , sum(total_submissions) as sum_sub
  , sum(total_accepted_submissions) as sum_acc_sub
  from submission_stats
  group by challenge_id
) t2 on cha.challenge_id = t2.challenge_id
;

+------------+-----------+--------+------------+--------------+----------+-----------------+---------+-------------+
| contest_id | hacker_id | name   | college_id | challenge_id | sum_view | sum_unique_view | sum_sub | sum_acc_sub |
+------------+-----------+--------+------------+--------------+----------+-----------------+---------+-------------+
|      66406 |     17973 | Rose   |      11219 |        18765 |      115 |              23 |    NULL |        NULL |
|      66406 |     17973 | Rose   |      11219 |        47127 |       41 |              33 |     111 |          39 |
|      66556 |     79153 | Angela |      32473 |        60292 |       11 |              10 |    NULL |        NULL |
|      94828 |     80275 | Frank  |      56685 |        72974 |       41 |              15 |     150 |          38 |
+------------+-----------+--------+------------+--------------+----------+-----------------+---------+-------------+

select con.contest_id
, con.hacker_id
, con.name
, col.college_id
, cha.challenge_id
, t1.sum_view
, t1.sum_unique_view
, coalesce(t2.sum_sub, 0)
, coalesce(t2.sum_acc_sub, 0)
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
left join (
  select challenge_id
  , sum(total_views) as sum_view
  , sum(total_unique_views) as sum_unique_view
  from view_stats
  group by challenge_id
) t1 on cha.challenge_id = t1.challenge_id
left join (
  select challenge_id
  , sum(total_submissions) as sum_sub
  , sum(total_accepted_submissions) as sum_acc_sub
  from submission_stats
  group by challenge_id
) t2 on cha.challenge_id = t2.challenge_id
;

+------------+-----------+--------+------------+--------------+----------+-----------------+-------------------------+-----------------------------+
| contest_id | hacker_id | name   | college_id | challenge_id | sum_view | sum_unique_view | coalesce(t2.sum_sub, 0) | coalesce(t2.sum_acc_sub, 0) |
+------------+-----------+--------+------------+--------------+----------+-----------------+-------------------------+-----------------------------+
|      66406 |     17973 | Rose   |      11219 |        18765 |      115 |              23 |                       0 |                           0 |
|      66406 |     17973 | Rose   |      11219 |        47127 |       41 |              33 |                     111 |                          39 |
|      66556 |     79153 | Angela |      32473 |        60292 |       11 |              10 |                       0 |                           0 |
|      94828 |     80275 | Frank  |      56685 |        72974 |       41 |              15 |                     150 |                          38 |
+------------+-----------+--------+------------+--------------+----------+-----------------+-------------------------+-----------------------------+

-- WORKING SOLUTIONS
select con.contest_id
, con.hacker_id
, con.name
, sum(tt.sumsub)
, sum(tt.sumaccsub)
, sum(tt.sum_view)
, sum(tt.sum_unique_view)
from contests con
join (
  select col.contest_id
  , col.college_id
  , cha.challenge_id
  , t1.sum_view
  , t1.sum_unique_view
  , coalesce(t2.sum_sub, 0) as sumsub
  , coalesce(t2.sum_acc_sub, 0) as sumaccsub
  from colleges col
  join challenges cha using (college_id)
  left join (
    select challenge_id
    , sum(total_views) as sum_view
    , sum(total_unique_views) as sum_unique_view
    from view_stats
    group by challenge_id
  ) t1 on cha.challenge_id = t1.challenge_id
  left join (
    select challenge_id
    , sum(total_submissions) as sum_sub
    , sum(total_accepted_submissions) as sum_acc_sub
    from submission_stats
    group by challenge_id
  ) t2 on cha.challenge_id = t2.challenge_id
) tt on con.contest_id = tt.contest_id
group by con.contest_id, con.hacker_id, con.name
having (sum(tt.sum_view) + sum(tt.sum_unique_view) + sum(tt.sumsub) + sum(tt.sumaccsub))>0
order by con.contest_id
;

-- =========================== FINAL SOLUTION ===============================
-- we can an inner layer moving the left joins outside
-- the answer use coalesce for all the fields 

select con.contest_id
, con.hacker_id
, con.name
, sum(coalesce(t2.sum_sub, 0))
, sum(coalesce(t2.sum_acc_sub, 0))
, sum(coalesce(t1.sum_view, 0))
, sum(coalesce(t1.sum_unique_view, 0))
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
left join (
  select challenge_id
  , sum(total_views) as sum_view
  , sum(total_unique_views) as sum_unique_view
  from view_stats
  group by challenge_id
) t1 on cha.challenge_id = t1.challenge_id
left join (
  select challenge_id
  , sum(total_submissions) as sum_sub
  , sum(total_accepted_submissions) as sum_acc_sub
  from submission_stats
  group by challenge_id
) t2 on cha.challenge_id = t2.challenge_id
group by con.contest_id, con.hacker_id, con.name
having (sum(coalesce(t1.sum_view, 0)) + sum(coalesce(t1.sum_unique_view, 0))
  + sum(coalesce(t2.sum_sub, 0)) + sum(coalesce(t2.sum_acc_sub, 0))) > 0
order by contest_id
;

/*
ATT!! You cannot use in the having clause the + without using coalesce for every values
sum a NULL values to other make the all sum NULL and so 0

- sum(NULL) = 0
- sum(NULL + 1 + 2) = 0
- sum(0 + 1 + 2) = 3

so the following having clause would not work:
  having (sum(t1.sum_view) + sum(t1.sum_unique_view) 
    + sum(t2.sum_sub) + sum(t2.sum_acc_sub)) > 0

If you want to remove the coalesce function you need to use the or keyword in the
having clause 
*/

select con.contest_id
, con.hacker_id
, con.name
, sum(t2.sum_sub)
, sum(t2.sum_acc_sub)
, sum(t1.sum_view)
, sum(t1.sum_unique_view)
from contests con
join colleges col using (contest_id)
join challenges cha using (college_id)
left join (
  select challenge_id
  , sum(total_views) as sum_view
  , sum(total_unique_views) as sum_unique_view
  from view_stats
  group by challenge_id
) t1 on cha.challenge_id = t1.challenge_id
left join (
  select challenge_id
  , sum(total_submissions) as sum_sub
  , sum(total_accepted_submissions) as sum_acc_sub
  from submission_stats
  group by challenge_id
) t2 on cha.challenge_id = t2.challenge_id
group by con.contest_id, con.hacker_id, con.name
having sum(t1.sum_view) != 0
  or sum(t1.sum_unique_view) != 0
  or sum(t2.sum_sub) != 0
  or sum(t2.sum_acc_sub) != 0
order by contest_id
;
