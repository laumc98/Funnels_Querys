SELECT str_to_date(concat(yearweek(`Views`.`created`), ' Sunday'), '%X%V %W') AS date_views,`Views`.`target_id` as id
FROM `opportunities`
LEFT JOIN `views` `Views` ON `opportunities`.`id` = `Views`.`target_id`
WHERE `Views`.`target_type` = 'opportunity' AND `opportunities`.`remote` = 1 AND `Views`.`created` between date_sub(now(), interval 262 day) AND now()
LIMIT 1048575
