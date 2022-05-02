SELECT
    date(`opportunities`.`reviewed`) AS `date`,
    count(distinct `opportunities`.`id`) AS `opps_approved_weekly`
FROM
    `opportunities`
    LEFT JOIN `opportunity_organizations` `Opportunity Organizations` ON `opportunities`.`id` = `Opportunity Organizations`.`opportunity_id`
WHERE
    (
        `opportunities`.`reviewed` IS NOT NULL
        AND `opportunities`.`reviewed` > "2021-7-18"
        AND `opportunities`.`reviewed` < date(date_add(now(6), INTERVAL 1 day))
        AND `opportunities`.`review` = 'approved'
        AND (
            `Opportunity Organizations`.`organization_id` <> 665801
            OR `Opportunity Organizations`.`organization_id` IS NULL
        )
    )
GROUP BY
    date(`opportunities`.`reviewed`)
ORDER BY
    date(`opportunities`.`reviewed`) ASC