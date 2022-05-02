SELECT
    date(`opportunity_changes_history`.`created`) AS `date`,
    count(
        distinct `opportunity_changes_history`.`opportunity_id`
    ) AS `opps_commited_daily`
FROM
    `opportunity_changes_history`
    LEFT JOIN `opportunities` `opportunities__via__opportunit` ON `opportunity_changes_history`.`opportunity_id` = `opportunities__via__opportunit`.`id`
WHERE
    (
        `opportunity_changes_history`.`type` = 'outbound'
        AND `opportunity_changes_history`.`value` = 0
        AND `opportunities__via__opportunit`.`reviewed` > "2021-7-18"
        AND `opportunities__via__opportunit`.`reviewed` < date(now(6))
    )
GROUP BY
    date(`opportunity_changes_history`.`created`)
ORDER BY
    date(`opportunity_changes_history`.`created`) ASC