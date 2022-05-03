SELECT
    str_to_date(concat(yearweek(`notifications`.`send_at`), 'Sunday'),'%X%V %W') AS `date`,
    TRIM('"'FROM JSON_EXTRACT(`notifications`.`context`, '$.opportunityId')) as `AlfaID`
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