-- NOTE: the queries necessary to create and populate a test table are in "The PADS" challenge
/*
The logic of this query is:
1) Reshape Occupation into 4 columns with their index in each occupation, 
   this leads to Temp table (which has many NULL).
2) Then group Temp by index and select corresponding Name for each Occupation.
*/

set @d:=0, @p:=0, @s:=0, @a:=0;
select min(Doctor), max(Professor), min(Singer), max(Actor)
from (
  select
    case
      when Occupation = "Doctor" then (@d:=@d+1)
      when Occupation = "Professor" then (@p:=@p+1)
      when Occupation = "Singer" then (@s:=@s+1)
      when Occupation = "Actor" then (@a:=@a+1)
    end as RowNumber
  , case when Occupation = "Doctor" then Name end as "Doctor"
  , case when Occupation = "Professor" then Name end as "Professor" 
  , case when Occupation = "Singer" then Name end as "Singer" 
  , case when Occupation = "Actor" then Name end as "Actor" 
  from occupations
  order by Name 
) as o
group by RowNumber 
; 

/*
All the steps to get to the solution:
1) Reshape the Occupation table to have a column for each occupation 
select *
from (
  select
    case when Occupation = "Doctor" then Name end as "Doctor"
  , case when Occupation = "Professor" then Name end as "Professor" 
  , case when Occupation = "Singer" then Name end as "Singer" 
  , case when Occupation = "Actor" then Name end as "Actor" 
  from occupations 
) as o 
;  

+----------+-----------+--------+-------+
| Doctor   | Professor | Singer | Actor |
+----------+-----------+--------+-------+
| Samantha | NULL      | NULL   | NULL  |
| NULL     | NULL      | NULL   | Julia |
| NULL     | NULL      | NULL   | Maria |
| NULL     | NULL      | Meera  | NULL  |
| NULL     | Ashely    | NULL   | NULL  |
| NULL     | Ketty     | NULL   | NULL  |
| NULL     | Christeen | NULL   | NULL  |
| NULL     | NULL      | NULL   | Jane  |
| Jenny    | NULL      | NULL   | NULL  |
| NULL     | NULL      | Priya  | NULL  |
+----------+-----------+--------+-------+

2) Adding the row number for each occupation 
   each row has only a one NULL value

set @d:=0, @p:=0, @s:=0, @a:=0;
select *
from (
  select
    case
      when Occupation = "Doctor" then (@d:=@d+1)
      when Occupation = "Professor" then (@p:=@p+1)
      when Occupation = "Singer" then (@s:=@s+1)
      when Occupation = "Actor" then (@a:=@a+1)
    end as RowNumber
  , case when Occupation = "Doctor" then Name end as "Doctor"
  , case when Occupation = "Professor" then Name end as "Professor" 
  , case when Occupation = "Singer" then Name end as "Singer" 
  , case when Occupation = "Actor" then Name end as "Actor" 
  from occupations
) as o 
;  

+-----------+----------+-----------+--------+-------+
| RowNumber | Doctor   | Professor | Singer | Actor |
+-----------+----------+-----------+--------+-------+
|         1 | Samantha | NULL      | NULL   | NULL  |
|         1 | NULL     | NULL      | NULL   | Julia |
|         2 | NULL     | NULL      | NULL   | Maria |
|         1 | NULL     | NULL      | Meera  | NULL  |
|         1 | NULL     | Ashely    | NULL   | NULL  |
|         2 | NULL     | Ketty     | NULL   | NULL  |
|         3 | NULL     | Christeen | NULL   | NULL  |
|         3 | NULL     | NULL      | NULL   | Jane  |
|         2 | Jenny    | NULL      | NULL   | NULL  |
|         2 | NULL     | NULL      | Priya  | NULL  |
+-----------+----------+-----------+--------+-------+

3) Add the order by keyword

set @d:=0, @p:=0, @s:=0, @a:=0;
select *
from (
  select
    case
      when Occupation = "Doctor" then (@d:=@d+1)
      when Occupation = "Professor" then (@p:=@p+1)
      when Occupation = "Singer" then (@s:=@s+1)
      when Occupation = "Actor" then (@a:=@a+1)
    end as RowNumber
  , case when Occupation = "Doctor" then Name end as "Doctor"
  , case when Occupation = "Professor" then Name end as "Professor" 
  , case when Occupation = "Singer" then Name end as "Singer" 
  , case when Occupation = "Actor" then Name end as "Actor" 
  from occupations
  order by Name 
) as o 
;  

+-----------+----------+-----------+--------+-------+
| RowNumber | Doctor   | Professor | Singer | Actor |
+-----------+----------+-----------+--------+-------+
|         1 | NULL     | Ashely    | NULL   | NULL  |
|         2 | NULL     | Christeen | NULL   | NULL  |
|         1 | NULL     | NULL      | NULL   | Jane  |
|         1 | Jenny    | NULL      | NULL   | NULL  |
|         2 | NULL     | NULL      | NULL   | Julia |
|         3 | NULL     | Ketty     | NULL   | NULL  |
|         3 | NULL     | NULL      | NULL   | Maria |
|         1 | NULL     | NULL      | Meera  | NULL  |
|         2 | NULL     | NULL      | Priya  | NULL  |
|         2 | Samantha | NULL      | NULL   | NULL  |
+-----------+----------+-----------+--------+-------+

4) Add the group by keyword
   NOTE: Not the wanted result - we only get the firs occurrence of each number

set @d:=0, @p:=0, @s:=0, @a:=0;
select *
from (
  select
    case
      when Occupation = "Doctor" then (@d:=@d+1)
      when Occupation = "Professor" then (@p:=@p+1)
      when Occupation = "Singer" then (@s:=@s+1)
      when Occupation = "Actor" then (@a:=@a+1)
    end as RowNumber
  , case when Occupation = "Doctor" then Name end as "Doctor"
  , case when Occupation = "Professor" then Name end as "Professor" 
  , case when Occupation = "Singer" then Name end as "Singer" 
  , case when Occupation = "Actor" then Name end as "Actor" 
  from occupations
  order by Name 
) as o
group by RowNumber 
; 
 
+-----------+--------+-----------+--------+-------+
| RowNumber | Doctor | Professor | Singer | Actor |
+-----------+--------+-----------+--------+-------+
|         1 | NULL   | Ashely    | NULL   | NULL  |
|         2 | NULL   | Christeen | NULL   | NULL  |
|         3 | NULL   | Ketty     | NULL   | NULL  |
+-----------+--------+-----------+--------+-------+

5) Add min() and max() to return a name for specific index and specific occupation. 
   If there is a name, it will return it, if not, return NULL.

   For each row/column there are many null values, and up to one name. 
   Min() or max() will only return a null value if there are no non-null values, 
   so it basically tells the table to pick the one that isn't null. 
   Min or max doesnt matter, as there is never more than one present.
   
   NOTE: if you use sum(Doctor) it returns 0 where there are Names 
   and Null if there isn't
   NOTE: used both min() and max() to show that it doesn not make any difference

set @d:=0, @p:=0, @s:=0, @a:=0;
select min(Doctor), max(Professor), min(Singer), max(Actor)
from (
  select
    case
      when Occupation = "Doctor" then (@d:=@d+1)
      when Occupation = "Professor" then (@p:=@p+1)
      when Occupation = "Singer" then (@s:=@s+1)
      when Occupation = "Actor" then (@a:=@a+1)
    end as RowNumber
  , case when Occupation = "Doctor" then Name end as "Doctor"
  , case when Occupation = "Professor" then Name end as "Professor" 
  , case when Occupation = "Singer" then Name end as "Singer" 
  , case when Occupation = "Actor" then Name end as "Actor" 
  from occupations
  order by Name 
) as o
group by RowNumber 
; 
 
+-------------+----------------+-------------+------------+
| min(Doctor) | max(Professor) | min(Singer) | max(Actor) |
+-------------+----------------+-------------+------------+
| Jenny       | Ashely         | Meera       | Jane       |
| Samantha    | Christeen      | Priya       | Julia      |
| NULL        | Ketty          | NULL        | Maria      |
+-------------+----------------+-------------+------------+

*/
