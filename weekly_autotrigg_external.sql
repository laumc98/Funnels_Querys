/* AA : Channel's performance : weekly autotrigg ext notifications : prod */ 
SELECT
    str_to_date(concat(yearweek(`notifications`.`sent_at`), ' Sunday'),'%X%V %W') AS `date`,
    count(*) AS `count_trigg_ext`
FROM
    `notifications`
WHERE
    (
        (
            `notifications`.`template` = 'talent-candidate-invited'
        )
        AND `notifications`.`status` = 'sent'
        AND `notifications`.`sent_at` >= '2021-08-15'
    )
GROUP BY 1