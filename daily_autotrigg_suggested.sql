/* AA : Channel's performance : daily Autotrigg sugg notifications : prod */ 
SELECT
    date(`notifications`.`sent_at`) AS `daily_date`,
    count(*) AS `count_trigg_sugg`
FROM
    `notifications`
WHERE
    (
        (
            `notifications`.`template` = 'talent-candidate-manually-invited'
        )
        AND `notifications`.`status` = 'sent'
        AND `notifications`.`sent_at` >= '2022-01-1'
    )
GROUP BY date(`notifications`.`sent_at`)
