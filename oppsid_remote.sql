/* AA : Channel's performance : remote opp id : prod */ 
SELECT `opportunities`.`id` AS `id`
FROM `opportunities`
WHERE `opportunities`.`remote` = TRUE
