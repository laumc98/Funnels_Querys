SELECT str_to_date(concat(yearweek(`notifications`.`send_at`), ' Sunday'), '%X%V %W') AS `date`, count(*) AS `count_ccgs`
FROM `notifications` INNER JOIN `person_flags` `Person Flags - To` ON `notifications`.`to` = `Person Flags - To`.`person_id`
WHERE (`notifications`.`template` = 'career-advisor-job-opportunity'
   AND `notifications`.`status` = 'sent'
   AND `Person Flags - To`.`community_created_claimed_at` is null
   AND `notifications`.`send_at` between date_sub(now(), interval 262 day) and now())
GROUP BY 1
