select str_to_date(concat(yearweek(no.send_at), ' Sunday'), '%X%V %W') as date, count(*) as count_sourcing
from notifications no
WHERE no.template like 'career-advisor-sourcing-first-evaluation' and no.send_at > "2022-2-6"
group by 1