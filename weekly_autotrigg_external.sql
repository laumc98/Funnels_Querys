SELECT str_to_date(concat(yearweek(`notifications`.`send_at`), ' Sunday'), '%X%V %W') AS `date`, count(*) AS `count_trigg_ext`
FROM `notifications`
WHERE (`notifications`.`template` = 'nps'
   AND `notifications`.`status` = 'sent'
   AND `notifications`.`send_at` between date_sub(now(), interval 262 day) and now())
GROUP BY 1