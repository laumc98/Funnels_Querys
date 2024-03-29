/* AA : Channel's performance : nyax notifications : prod */ 
SELECT
    str_to_date(concat(yearweek(notif.notifications_date), ' Sunday'),'%X%V %W') as date,
    date(notif.notifications_date) as 'daily_date',
    notif.AlfaID as 'AlfaID'
FROM
(
        SELECT
            no.sent_at as 'notifications_date',
            TRIM('"' FROM JSON_EXTRACT(no.context, '$.opportunityId')) as AlfaID
        FROM
            notifications no
        WHERE
            no.template = 'career-advisor-job-opportunity'
            AND no.sent_at >= "2021-08-01"
            AND no.sent_at < date(date_add(now(6), INTERVAL 1 day))
            AND no.status = 'sent'
) notif