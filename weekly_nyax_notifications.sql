select str_to_date(concat(yearweek(no.send_at), ' Sunday'), '%X%V %W') as date, p.subject_identifier as subjid, p.gg_id as ggid
from notifications no
left join people p on no.to = p.id
WHERE no.template like 'career-advisor-job-opportunity' and no.send_at between date_sub(now(), interval 262 day) and now() and no.status = 'sent'