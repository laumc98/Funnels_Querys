SELECT
    str_to_date(concat(yearweek(notif.notifications_date), 'Sunday'),'%X%V %W') AS `date`,
    date(notif.notifications_date) AS `daily_date`,
    notif.AlfaID as `AlfaID`
FROM
(
        SELECT
            `notifications`.`send_at` AS `notifications_date`,
            TRIM('"' FROM JSON_EXTRACT(`notifications`.`context`, '$.opportunityId')) as `AlfaID`
        FROM
            `notifications`
        WHERE
            (
                (
                    `notifications`.`template` = 'career-advisor-sourcing-first-evaluation-matrix-a'
                    OR `notifications`.`template` = 'career-advisor-sourcing-first-evaluation-matrix-b'
                    OR `notifications`.`template` = 'career-advisor-sourcing-first-evaluation-matrix-c'
                    OR `notifications`.`template` = 'career-advisor-sourcing-first-evaluation'
                )
                AND `notifications`.`status` = 'sent'
            )
) notif
