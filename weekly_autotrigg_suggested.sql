/* AA : Channel's performance : weekly autotrigg sugg notifications : prod */ 
SELECT
    str_to_date(concat(yearweek(`notifications`.`sent_at`), ' Sunday'),'%X%V %W') AS `date`,
    count(*) AS `count_trigg_sugg`
FROM
    `notifications`
WHERE
    (
        (
            `notifications`.`template` = 'talent-candidate-manually-invited'
        )
        AND `notifications`.`status` = 'sent'
        AND `notifications`.`sent_at` >= '2021-09-01'
    )
GROUP BY 1