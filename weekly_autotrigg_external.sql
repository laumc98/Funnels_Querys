/* AA : Channel's performance : weekly autotrigg ext notifications : prod */ 
SELECT
    str_to_date(concat(yearweek(notif.date), ' Sunday'),'%X%V %W') AS 'date',
    date(notif.date) as 'daily_date',
    notif.id  
FROM
(
    SELECT
        date(notifications.sent_at) AS 'date',
        TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) as 'id'
    FROM
        notifications
    WHERE
        (
            (
                notifications.template = 'talent-candidate-invited'
            )
            AND notifications.status = 'sent'
            AND notifications.sent_at >= '2021-08-15'
        )
) notif 