select str_to_date(concat(yearweek(oc.created), ' Sunday'), '%X%V %W') as date, count(*) as 'count_trigg_ext'
from opportunity_candidates oc
    inner join member_evaluations me on me.candidate_id = oc.id 
    inner join people p on oc.person_id = p.id
    inner join opportunities o on oc.opportunity_id = o.id
where (me.interested is not null 
    and me.not_interested is null
    and me.send_disqualified_notification = false
    and oc.column_id is null
    and oc.application_step is null
    and o.remote = 1
    and oc.created between date_sub(now(), interval 262 day) and now())
group by 1
    