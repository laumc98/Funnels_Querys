/* AA : Channel's performance : ccgs notifications : prod */ 
SELECT
   str_to_date(concat(yearweek(`notifications_date`), ' Sunday'),'%X%V %W') AS `date`,
   date(notif.notifications_date) AS `daily_date`,
   notif.AlfaID as `AlfaID`
FROM
(
      SELECT
         `notifications`.`send_at` AS `notifications_date`,
         TRIM('"' FROM JSON_EXTRACT(`notifications`.`context`, '$.opportunityId')) as AlfaID
      FROM
         `notifications`
         INNER JOIN `person_flags` `Person Flags - To` ON `notifications`.`to` = `Person Flags - To`.`person_id`
      WHERE
         (
            `notifications`.`template` = 'career-advisor-job-opportunity'
            AND `notifications`.`status` = 'sent'
            AND `Person Flags - To`.`community_created_claimed_at` is null
            AND `notifications`.`send_at` >= "2021-06-01"
            AND `notifications`.`send_at` < date(date_add(now(6), INTERVAL 1 day))
         )
      ORDER BY `notifications_date` ASC
) notif
