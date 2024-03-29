/* AA : Channel's performance : ccgs notifications : prod */
SELECT
   str_to_date(concat(yearweek(notif.date), ' Sunday'),'%X%V %W') AS `date`,
   date(notif.date) AS `daily_date`,
   notif.AlfaID as 'AlfaID'
FROM
   (
      SELECT
         date(notifications.sent_at) AS 'date',
         TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) as 'AlfaID'
      FROM
         notifications
         LEFT JOIN people ON notifications.to = people.id
      WHERE
         (
            (notifications.template = 'career-advisor-job-opportunity'
                  OR notifications.template = 'career-advisor-invited-job-opportunity')
            AND notifications.status = 'sent'
            AND (people.subject_identifier IS NULL 
                     OR people.subject_identifier != people.gg_id)
            AND people.name not like '%test%'
            AND TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.utmMedium')) = 'rc_ccg'
         )
   ) notif