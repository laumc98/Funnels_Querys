SELECT `opportunity_candidates`.`created` AS `created`, `People`.`gg_id` AS `People__gg_id`
FROM `opportunity_candidates`
LEFT JOIN `people` `People` ON `opportunity_candidates`.`person_id` = `People`.`id` LEFT JOIN `opportunities` `Opportunities` ON `opportunity_candidates`.`opportunity_id` = `Opportunities`.`id`
WHERE `Opportunities`.`remote` = 1 and `opportunity_candidates`.`created` between date_sub(now(), interval 262 day) and now() 
LIMIT 1048575