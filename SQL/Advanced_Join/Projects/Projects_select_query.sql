/*
Need to use min function for end_date since end_date is not part of the group by clause. 
Need an aggregate in the select and order by clause for any cols not in the group by clause.
*/
select Start_Date, min(End_Date)
from (
 select Start_Date 
 from Projects 
 where Start_Date 
 not in (select End_Date from Projects)
) a,
(select End_Date 
 from Projects 
 where End_Date 
 not in (select Start_Date from Projects)
) b
where Start_Date < End_Date
group by Start_Date
order by datediff(min(End_Date), Start_Date), Start_Date
;


/*
STEPS:
1)
select Start_Date 
from Projects 
where Start_Date 
not in (select End_Date from Projects)
;

+------------+
| Start_Date |
+------------+
| 2015-10-01 |
| 2015-10-13 |
| 2015-10-28 |
| 2015-10-30 |
+------------+

2) 
select End_Date 
from Projects 
where End_Date 
not in (select Start_Date from Projects)
;
 
+------------+
| End_Date   |
+------------+
| 2015-10-04 |
| 2015-10-15 |
| 2015-10-29 |
| 2015-10-31 |
+------------+

3)
select Start_Date, End_Date
from (
 select Start_Date 
 from Projects 
 where Start_Date 
 not in (select End_Date from Projects)
) a,
(select End_Date 
 from Projects 
 where End_Date 
 not in (select Start_Date from Projects)
) b
;

+------------+------------+
| Start_Date | End_Date   |
+------------+------------+
| 2015-10-01 | 2015-10-04 |
| 2015-10-13 | 2015-10-04 |
| 2015-10-28 | 2015-10-04 |
| 2015-10-30 | 2015-10-04 |
| 2015-10-01 | 2015-10-15 |
| 2015-10-13 | 2015-10-15 |
| 2015-10-28 | 2015-10-15 |
| 2015-10-30 | 2015-10-15 |
| 2015-10-01 | 2015-10-29 |
| 2015-10-13 | 2015-10-29 |
| 2015-10-28 | 2015-10-29 |
| 2015-10-30 | 2015-10-29 |
| 2015-10-01 | 2015-10-31 |
| 2015-10-13 | 2015-10-31 |
| 2015-10-28 | 2015-10-31 |
| 2015-10-30 | 2015-10-31 |
+------------+------------+

4)
select Start_Date, End_Date
from (
 select Start_Date 
 from Projects 
 where Start_Date 
 not in (select End_Date from Projects)
) a,
(select End_Date 
 from Projects 
 where End_Date 
 not in (select Start_Date from Projects)
) b
where Start_Date < End_Date
;

+------------+------------+
| Start_Date | End_Date   |
+------------+------------+
| 2015-10-01 | 2015-10-04 |
| 2015-10-01 | 2015-10-15 |
| 2015-10-13 | 2015-10-15 |
| 2015-10-01 | 2015-10-29 |
| 2015-10-13 | 2015-10-29 |
| 2015-10-28 | 2015-10-29 |
| 2015-10-01 | 2015-10-31 |
| 2015-10-13 | 2015-10-31 |
| 2015-10-28 | 2015-10-31 |
| 2015-10-30 | 2015-10-31 |
+------------+------------+

5)
select Start_Date, min(End_Date)
from (
 select Start_Date 
 from Projects 
 where Start_Date 
 not in (select End_Date from Projects)
) a,
(select End_Date 
 from Projects 
 where End_Date 
 not in (select Start_Date from Projects)
) b
where Start_Date < End_Date
group by Start_Date
;

+------------+---------------+
| Start_Date | min(End_Date) |
+------------+---------------+
| 2015-10-01 | 2015-10-04    |
| 2015-10-13 | 2015-10-15    |
| 2015-10-28 | 2015-10-29    |
| 2015-10-30 | 2015-10-31    |
+------------+---------------+

6)
select Start_Date, min(End_Date), datediff(min(End_Date), Start_Date)
from (
 select Start_Date 
 from Projects 
 where Start_Date 
 not in (select End_Date from Projects)
) a,
(select End_Date 
 from Projects 
 where End_Date 
 not in (select Start_Date from Projects)
) b
where Start_Date < End_Date
group by Start_Date
order by datediff(min(End_Date), Start_Date)
;

+------------+---------------+-------------------------------------+
| Start_Date | min(End_Date) | datediff(min(End_Date), Start_Date) |
+------------+---------------+-------------------------------------+
| 2015-10-01 | 2015-10-04    |                                   3 |
| 2015-10-13 | 2015-10-15    |                                   2 |
| 2015-10-28 | 2015-10-29    |                                   1 |
| 2015-10-30 | 2015-10-31    |                                   1 |
+------------+---------------+-------------------------------------+

*/