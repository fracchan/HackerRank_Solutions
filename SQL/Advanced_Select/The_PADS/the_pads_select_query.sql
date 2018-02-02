select concat(Name, '(', substring(Occupation,1,1), ')')
from occupations
order by Name
;

select concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation
;

