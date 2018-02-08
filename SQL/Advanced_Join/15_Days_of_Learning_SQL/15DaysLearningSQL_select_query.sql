/*
Julia conducted a 15 days of learning SQL contest. 
The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

Write a query to print total number of unique hackers who made at least 1 submission 
each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number 
of submissions each day. 
If more than one such hacker has a maximum number of submissions, 
print the lowest hacker_id. 

The query should print this information for each day of the contest, sorted by the date.
*/

/*
Output 4 columns:
1) distinct date 
2) unique_hackers_every_day based on the previous days
3) max_num_sub_of_one_hacker
4) hacker_id

Not all related together:
col 2) depends on col 1)
col 3) depends on col 1)
col 4) depends on col 3)

*/

-- col 1
select s1.submission_date
from submissions s1
group by s1.submission_date
;


-- Adding col 3:
-- NOTE: col 3 needs to return one value for every row
/*
select submission_date
, count(submission_id) as cnt_sub
, hacker_id
from submissions
group by submission_date, hacker_id
order by submission_date, cnt_sub desc
;
*/
select s1.submission_date
, (select hacker_id
   from submissions s2
   where s1.submission_date = s2.submission_date
   group by hacker_id
   order by count(submission_id) desc, hacker_id limit 1
  ) as hack
from submissions s1
group by s1.submission_date
;

-- Adding col 4:
select s1.submission_date
, (select hacker_id
   from submissions s2
   where s1.submission_date = s2.submission_date
   group by hacker_id
   order by count(submission_id) desc, hacker_id limit 1
  ) as hack
, (select name
   from hackers h1
   where h1.hacker_id = hack
  ) as hack_name
from submissions s1
group by s1.submission_date
;

-- col 2 
/*
Need to count unique hacker for a particular day and if that hacker has a submission
on all the previous dates - thus if the number of distinct submission_date for that
hacker is the same as the number of days from the first day.

select s1.submission_date
, (select count(distinct s2.hacker_id)
   from submissions s2
   where s2.submission_date = s1.submission_date) as 'cnt_hack'
from submissions s1
group by s1.submission_date
;

+-----------------+----------+
| submission_date | cnt_hack |
+-----------------+----------+
| 2016-03-01      |        4 |
| 2016-03-02      |        3 |
| 2016-03-03      |        3 |
| 2016-03-04      |        4 |
| 2016-03-05      |        4 |
| 2016-03-06      |        1 |
+-----------------+----------+

*/
select s1.submission_date
, (select count(distinct s2.hacker_id)
   from submissions s2
   where s2.submission_date = s1.submission_date
   and (select count(distinct s3.submission_date)
        from submissions s3
        where s3.hacker_id = s2.hacker_id and 
        s3.submission_date < s2.submission_date
       ) = datediff(s2.submission_date, '2016-03-01')
  ) as 'cnt_hack'
from submissions s1
group by s1.submission_date
;

-- ====================================================================
/*
Combining the four columns together:

select s1.submission_date
, (select count(distinct s2.hacker_id)
   from submissions s2
   where s2.submission_date = s1.submission_date
   and (select count(distinct s3.submission_date)
        from submissions s3
        where s3.hacker_id = s2.hacker_id and 
        s3.submission_date < s2.submission_date
       ) = datediff(s2.submission_date, '2016-03-01')
  ) as 'cnt_hack'
, (select hacker_id
   from submissions s2
   where s1.submission_date = s2.submission_date
   group by hacker_id
   order by count(submission_id) desc, hacker_id limit 1
  ) as hack
, (select name
   from hackers h1
   where h1.hacker_id = hack
  ) as hack_name
from submissions s1
group by s1.submission_date
;

Unfortunately this solution goes in timeout on HackerRank.
Reading the various comments I found out @fengli97 had the same approach
but his/her version didn't have a timeout problem using a select distinct in
the from clause [(select distinct submission_date from submissions) s1].
This way he/she has the distinct dates immediately available and in the subqueries
it run faster. 
*/


select s1.submission_date
, (select count(distinct s2.hacker_id)
   from submissions s2
   where s2.submission_date = s1.submission_date
   and (select count(distinct s3.submission_date)
        from submissions s3
        where s3.hacker_id = s2.hacker_id and 
        s3.submission_date < s1.submission_date
       ) = datediff(s1.submission_date, '2016-03-01')
  ) as 'cnt_hack'
, (select s2.hacker_id
   from submissions s2
   where s1.submission_date = s2.submission_date
   group by s2.hacker_id
   order by count(s2.submission_id) desc, s2.hacker_id limit 1
  ) as hack
, (select h1.name
   from hackers h1
   where h1.hacker_id = hack
  ) as hack_name
from (select distinct submission_date from submissions) s1
group by s1.submission_date
;