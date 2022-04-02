SELECT 
    str_to_date(concat(yearweek(coalesce(amn.sent_at, amn.send_at)), ' Sunday'), '%X%V %W') as 'date',
    count(*) as 'count_trigg_sugg'
FROM  
    opportunity_automated_messages as oam 
    left join automated_messages as am on (oam.automated_message_id = am.id)
    left join opportunity_columns as oc on (oam.column_id = oc.id)
    left join automated_messages_notifications as amn on (am.id = amn.automated_message_id)
    left join people as sender on (amn.from_person_id = sender.id)
    left join people as receiver on (amn.to_person_id = receiver.id)
WHERE
    oam.active = true 
    and am.active = true
    and amn.status = 'sent'
    and coalesce(amn.sent_at, amn.send_at) between date_sub(now(), interval 262 day) and now()
GROUP BY 1