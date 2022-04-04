select str_to_date(concat(yearweek(no.send_at), ' Sunday'), '%X%V %W') as date, TRIM('"' FROM JSON_EXTRACT(no.context, '$.opportunityId')) as AlfaID
from notifications no
WHERE no.template like 'career-advisor-sourcing-first-evaluation' and no.send_at between date_sub(now(), interval 262 day) and now() and no.status = 'sent'