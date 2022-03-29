SELECT str_to_date(concat(yearweek(`opportunities`.`created`), ' Sunday'), '%X%V %W') AS `created_date_remote`, `People - Applicant Coordinator Person`.`subject_identifier` AS `subjid`, `People - Applicant Coordinator Person`.`gg_id` AS `ggid`
FROM `opportunities`
LEFT JOIN `people` `People - Applicant Coordinator Person` ON `opportunities`.`applicant_coordinator_person_id` = `People - Applicant Coordinator Person`.`id`
WHERE `opportunities`.`remote` = 1 AND `People - Applicant Coordinator Person`.`gg_id` IS NOT NULL AND `opportunities`.`created` BETWEEN date_sub(now(), interval 272 day) and now()
LIMIT 1048575