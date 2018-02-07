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
