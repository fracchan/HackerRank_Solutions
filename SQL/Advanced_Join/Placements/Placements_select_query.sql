select s.name
from students s
join friends f using (ID)
join packages p1 using (ID)
join packages p2 on f.Friend_ID = p2.ID
where p2.Salary > p1.Salary
order by p2.Salary
;

/*
Write a query to output the names of those students whose best friends 
got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.

select *
from students s
join friends f using(ID)
join packages p1 using(ID)
join packages p2 on f.friend_ID = p2.ID
;

+----+----------+-----------+--------+----+--------+
| ID | Name     | Friend_ID | Salary | ID | Salary |
+----+----------+-----------+--------+----+--------+
|  4 | Scarlet  |         1 |  12.12 |  1 |   15.2 |
|  1 | Ashley   |         2 |   15.2 |  2 |  10.06 |
|  2 | Samantha |         3 |  10.06 |  3 |  11.55 |
|  3 | Julia    |         4 |  11.55 |  4 |  12.12 |
+----+----------+-----------+--------+----+--------+

select s.ID
, s.Name
, p1.Salary
, f.Friend_ID
, p2.Salary as "Friend Salary"
from students s
join friends f using (ID)
join packages p1 using (ID)
join packages p2 on f.Friend_ID = p2.ID
where p2.Salary > p1.Salary
order by p2.Salary
;

+----+----------+--------+-----------+---------------+
| ID | Name     | Salary | Friend_ID | Friend Salary |
+----+----------+--------+-----------+---------------+
|  2 | Samantha |  10.06 |         3 |         11.55 |
|  3 | Julia    |  11.55 |         4 |         12.12 |
|  4 | Scarlet  |  12.12 |         1 |          15.2 |
+----+----------+--------+-----------+---------------+

*/

