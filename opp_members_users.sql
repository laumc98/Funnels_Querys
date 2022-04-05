SELECT `opportunity_members`.`opportunity_id` AS `ID`,`People`.`gg_id` AS `gg_id`
FROM `opportunity_members` INNER JOIN `opportunities` `Opportunities` ON `opportunity_members`.`opportunity_id` = `Opportunities`.`id`
LEFT JOIN `people` `People` ON `opportunity_members`.`person_id` = `People`.`id`
WHERE (`Opportunities`.`remote` = TRUE
   AND `opportunity_members`.`member` = TRUE)
LIMIT 1048575