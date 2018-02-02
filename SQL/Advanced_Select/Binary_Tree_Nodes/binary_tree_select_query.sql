select n
, case
    when p is null then 'Root'
    when (select count(*) > 0 from bst where p=b.n) then 'Inner'
    else 'Leaf'
  end as 'Node Type'
from bst as b
order by n
;
