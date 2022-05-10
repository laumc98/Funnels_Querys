SELECT 
    str_to_date(concat(yearweek(coalesce(amn.sent_at, amn.send_at)), ' Sunday'), '%X%V %W') as 'date',
    count(*) as 'count_trigg_sugg'
FROM  
    opportunity_automated_messages as oam 
    left join automated_messages as am on (oam.automated_message_id = am.id)
    left join opportunity_columns as oc on (oam.column_id = oc.id)
    left join automated_messages_notifications as amn on (am.id = amn.automated_message_id)
    inner join opportunities o on (oam.opportunity_id = o.id)
WHERE
    oam.active = true 
    and am.active = true
    and amn.status = 'sent'
    and coalesce(amn.sent_at, amn.send_at) > '2021-08-15'
    and o.remote = 1
GROUP BY 1