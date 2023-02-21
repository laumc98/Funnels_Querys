/* AA : Channel's performance : CCGs from syndication : prod */ 
SELECT
    notifications.sent_at AS notifications_date,
    TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) as AlfaID,
    count(*) AS total_invited
FROM
    notifications
WHERE
    (
        notifications.template = 'career-advisor-syndication-first-evaluation'
        AND notifications.status = 'sent'
        AND date(notifications.sent_at) >= '2022-01-01'
    )
GROUP BY 
    notifications_date,
    AlfaID