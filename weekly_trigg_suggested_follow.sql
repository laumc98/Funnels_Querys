SELECT
    str_to_date(concat(yearweek(`notifications`.`sent_at`), ' Sunday'),'%X%V %W') AS `date`,
    count(*) as `trigg_sugg_follow_up`
FROM
    `notifications`
WHERE
    `notifications`.`template` = 'career-advisor-manual-invited-reminder'
    AND `notifications`.`status` = 'sent'
    AND `notifications`.`sent_at` >= '2021-08-15'
GROUP BY 1