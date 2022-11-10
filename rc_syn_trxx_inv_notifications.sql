/* AA : Channel's performance : rc_syn_trxx_inv notifications : prod */ 
SELECT
    str_to_date(concat(yearweek(notif.date), ' Sunday'),'%X%V %W') AS 'date',
    date(notif.date) as 'daily_date',
    notif.AlfaID 
FROM
(
    SELECT
        date(career_advisor.created) AS `date`,
        TRIM('"' FROM JSON_EXTRACT(career_advisor.context, '$.opportunityId')) as 'AlfaID'
    FROM
        career_advisor
    WHERE
        career_advisor.current = 'career-advisor-syndication-already-exist'
        AND career_advisor.notification_status = 'sent'
) notif