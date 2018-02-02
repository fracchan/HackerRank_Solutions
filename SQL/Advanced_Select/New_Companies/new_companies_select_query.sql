-- solution using an advanced select technique, no join
select co.company_code
, co.founder
, count(distinct lm.lead_manager_code) as 'LM'
, count(distinct sm.senior_manager_code) as 'SM'
, count(distinct ma.manager_code) as 'M'
, count(distinct emp.employee_code) as 'E'
from Company co, Lead_Manager lm, Senior_Manager sm, Manager ma, Employee emp
where co.company_code = lm.company_code
	and lm.company_code = sm.company_code
	and sm.company_code = ma.company_code
	and ma.company_code = emp.company_code
group by co.company_code, co.founder
order by co.company_code
;

-- solution using the join keyword

Select co.company_code
, co.founder
, count(distinct lm.lead_manager_code) as 'LM'
, count(distinct sm.senior_manager_code) as 'SM'
, count(distinct ma.manager_code) as 'M'
, count(distinct emp.employee_code) as 'E'
from Company co
join Lead_Manager lm using (company_code)
join Senior_Manager sm using (company_code)
join Manager ma using (company_code)  
join Employee emp using (company_code) 
group by co.company_code, co.founder
order by co.company_code
;


