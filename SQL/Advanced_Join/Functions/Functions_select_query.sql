(select f1.x, f1.y
from Functions f1
inner join Functions f2 on f1.x = f2.y
and f1.y = f2.x
where f1.x < f1.y)
union 
(select dup.x, dup.y
from Functions dup
where dup.x = dup.y
group by x,y
having count(*) > 1)
order by x
;

/*
select * 
from functions
;
+----+----+
| x  | y  |
+----+----+
| 20 | 20 |
| 20 | 20 |
| 20 | 21 |
| 23 | 22 |
| 22 | 23 |
| 21 | 20 |
| 24 | 24 |
+----+----+

Final select query is a union of two queries:
1) Select query to find pairs with x != y

select f1.x, f1.y
from Functions f1
inner join Functions f2 on f1.x = f2.y
and f1.y = f2.x
where f1.x < f1.y
;
+----+----+
| x  | y  |
+----+----+
| 22 | 23 |
| 20 | 21 |
+----+----+

2) Select query to find pairs with x == y and not counting a single line as a pair

select dup.x, dup.y
from Functions dup
where dup.x = dup.y
group by x,y
having count(*) > 1
;
+----+----+
| x  | y  |
+----+----+
| 20 | 20 |
+----+----+

*/

/*
NOT WORKING:
 this query does not remove single line where x=y.
 they get counted as two lines and printed.

select distinct f1.x, f1.y
from Functions f1
join Functions f2 on f1.x = f2.y
and f1.y = f2.x
order by f1.x
;
*/