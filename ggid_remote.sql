SELECT `People - Applicant Coordinator Person`.`subject_identifier` AS `subjid`, `People - Applicant Coordinator Person`.`gg_id` AS `ggid`
FROM `opportunities`
LEFT JOIN `people` `People - Applicant Coordinator Person` ON `opportunities`.`applicant_coordinator_person_id` = `People - Applicant Coordinator Person`.`id`
WHERE `opportunities`.`remote` = 1 AND `People - Applicant Coordinator Person`.`gg_id` IS NOT NULL
LIMIT 1048575