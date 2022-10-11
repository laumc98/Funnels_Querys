SELECT
    str_to_date(concat(yearweek(notif.date), ' Sunday'),'%X%V %W') AS 'date',
    date(notif.date) as 'daily_date',
    notif.AlfaID 
FROM
(
    SELECT
        date(notifications.sent_at) AS `date`,
        TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) as 'AlfaID'
    FROM
        notifications
    WHERE
        notifications.template = 'career-advisor-manual-invited-reminder'
        AND notifications.status = 'sent'
        AND notifications.sent_at >= '2021-08-15'
) notif