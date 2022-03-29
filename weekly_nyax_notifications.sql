select str_to_date(concat(yearweek(no.send_at), ' Sunday'), '%X%V %W') as date, count(*)
from notifications no
WHERE no.template like 'career-advisor-job-opportunity' and no.send_at between date_sub(now(), interval 262 day) and now() and no.status = 'sent'
group by 1