SELECT
    date(`opportunity_stats_hires`.`hiring_date`) AS `date`,
    count(
        distinct `opportunity_stats_hires`.`opportunity_id`
    ) AS `opps_hire_daily_prime7days`
FROM
    `opportunity_stats_hires`
    LEFT JOIN `opportunities` `Opportunities` ON `opportunity_stats_hires`.`opportunity_id` = `Opportunities`.`id`
WHERE
    (
        `opportunity_stats_hires`.`hiring_date` > "2021-7-18"
        AND `opportunity_stats_hires`.`hiring_date` < date(now(6))
        AND datediff(
            date(`opportunity_stats_hires`.`hiring_date`),
            date(`Opportunities`.`reviewed`)
        ) <= 7
        AND `Opportunities`.`fulfillment` = 'prime'
    )
GROUP BY
    date(`opportunity_stats_hires`.`hiring_date`)
ORDER BY
    date(`opportunity_stats_hires`.`hiring_date`) ASC