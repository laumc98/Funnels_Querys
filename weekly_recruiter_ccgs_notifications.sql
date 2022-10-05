/* AA : Channel's performance : ccgs notifications : prod */
SELECT
   str_to_date(concat(yearweek(notif.notifications_date), ' Sunday'),'%X%V %W') AS `date`,
   date(notif.notifications_date) AS `daily_date`,
   notif.sent_notifications as `count_ccgs`
FROM
   (
      SELECT
         date(career_advisor.deleted) AS notifications_date,
         count(*) AS sent_notifications
      FROM
         career_advisor
         LEFT JOIN people ON career_advisor.person_id = people.id
      WHERE
         (
            career_advisor.current = 'career-advisor-job-opportunity'
            OR career_advisor.current = 'career-advisor-invited-job-opportunity'
         )
         AND career_advisor.notification_status = 'sent'
         AND career_advisor.active = false
         AND people.subject_identifier IS NULL
         AND career_advisor.deleted >= '2022-07-17'
      GROUP BY
         date(career_advisor.deleted)
   ) notif