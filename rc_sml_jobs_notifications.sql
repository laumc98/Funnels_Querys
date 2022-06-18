/* AA : Channel's performance : rc_sml_jobs notifications : prod */ 
SELECT
    str_to_date(concat(yearweek(notif.notifications_date), ' Sunday'),'%X%V %W') as date,
    date(notif.notifications_date) as 'daily_date',
    notif.AlfaID as 'AlfaID'
FROM
(
        SELECT
            no.send_at as 'notifications_date',
            TRIM('"' FROM JSON_EXTRACT(no.context, '$.opportunityId')) as AlfaID
        FROM
            notifications no
        WHERE
            no.template = 'career-advisor-invited-similar-job-opportunity'
            AND no.status = 'sent'
) notif