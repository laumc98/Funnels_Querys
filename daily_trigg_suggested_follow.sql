SELECT
    date(`notifications`.`send_at`) as `daily_date`,
    count(*) as `trigg_sugg_follow_up`
FROM
    `notifications`
WHERE
    `notifications`.`template` = 'career-advisor-manual-invited-reminder'
    AND `notifications`.`status` = 'sent'
    AND `notifications`.`sent_at` >= '2022-01-1'
GROUP BY 1