select date(no.send_at) as date, count(*)
from notifications no
WHERE no.template like 'career-advisor-invited-job-opportunity' and no.send_at between date_sub(now(), interval 8 day) and now() and no.status = 'sent'
group by 1