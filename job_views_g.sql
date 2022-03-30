select year(v.created) as year, week(v.created, 0) as week, date(v.created) as created, count(*) as weekly 
from views v 
inner join opportunities o on o.id = v.target_id
inner join opportunity_members omp on omp.opportunity_id = v.target_id 
inner join person_flags pf on pf.person_id = omp.person_id 
where o.objective not like '***%' and o.remote = 1 and omp.poster = true and pf.opportunity_crawler = false and v.target_type = 'opportunity' and v.created between date_sub(now(), interval 262 day) and now() 
group by 1,2