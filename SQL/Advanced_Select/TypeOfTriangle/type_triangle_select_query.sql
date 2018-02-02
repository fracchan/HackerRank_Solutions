/*
scalene - 3 different length sides but  a + b >= c
ATT! You first have to determine if it is a triangle or not even not a triangle could
have two number the same!!
*/

select 
  case
    when a + b <= c or b + c <= a or a + c <= b then 'Not A Triangle'
    when a = b and b = c then 'Equilateral'
    when a = b or b = c or a = c then 'Isosceles'
    else 'Scalene'
  end as 'type triangle'
from triangles
;
