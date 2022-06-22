/* AA : Channel's performance : weekly autotrigg sugg notifications 2 : prod */ 
SELECT
    str_to_date(concat(yearweek(`automated_messages_notifications`.`sent_at`),' Sunday'),'%X%V %W') AS `date`,
    count(*) AS `count_trigg_sugg2`
FROM
    `automated_messages_notifications`
    LEFT JOIN `people` `People - To Person` ON `automated_messages_notifications`.`to_person_id` = `People - To Person`.`id`
WHERE
    (
        `automated_messages_notifications`.`tracking_code` = 'utm_medium=am_sug&utm_source=message&utm_campaign=dft'
        AND `automated_messages_notifications`.`status` = 'sent'
        AND `automated_messages_notifications`.`sent_at` >= '2021-09-01'
    )
GROUP BY
    str_to_date(concat(yearweek(`automated_messages_notifications`.`sent_at`),' Sunday'),'%X%V %W')
ORDER BY
    str_to_date(concat(yearweek(`automated_messages_notifications`.`sent_at`),' Sunday'),'%X%V %W') ASC        