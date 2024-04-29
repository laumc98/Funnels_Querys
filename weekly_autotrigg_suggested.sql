/* AA : Channel's performance : weekly autotrigg sugg notifications : prod */ 
WITH 
groupped_services AS (
    SELECT
        opportunity_id,
        GROUP_CONCAT(service_code) AS services
    FROM
        opportunity_services
    WHERE
        deleted IS NULL
    GROUP BY
        opportunity_id
),
opps_services AS (
    SELECT
        o.id AS opportunity_id,
        CASE
            WHEN crawled THEN 'crawled'
            WHEN (
                (
                    FIND_IN_SET('1', gs.services)>0 /* agile */
                    OR FIND_IN_SET('7', gs.services)>0 /* staff augmentation */
                    OR FIND_IN_SET('20', gs.services)>0 /* hunt */
                )
            ) THEN 'rpo'
            WHEN (
                (
                    FIND_IN_SET('8', gs.services)>0 /* ats */
                    OR FIND_IN_SET('9', gs.services)>0 /* pro */
                    OR FIND_IN_SET('16', gs.services)>0 /* torre_os */
                ) AND o.created>='2023-12-01'
            ) THEN 'torre_os'
            WHEN (
                (
                    FIND_IN_SET('2', gs.services)>0 /* essentials */
                    OR FIND_IN_SET('6', gs.services)>0 /* self service */
                    OR services = ''
                    OR services IS NULL
                )  AND o.created>='2023-12-01'
            ) THEN 'torre_free'
            ELSE 'others'
        END AS business_line,
        (
            (
                FIND_IN_SET('11', gs.services)>0 /* boost */
                OR FIND_IN_SET('12', gs.services)>0 /* boost hqa */
                OR FIND_IN_SET('17', gs.services)>0 /* torre_reach_essential */
                OR FIND_IN_SET('18', gs.services)>0 /* torre_reach_syndication */
                OR FIND_IN_SET('19', gs.services)>0 /* torre_reach_sourcing */
            ) AND o.created>='2023-12-01'
        ) AS reach,
        services
    FROM
        opportunities o
    LEFT JOIN groupped_services gs ON
        gs.opportunity_id = o.id
),weekly_autotrigg_sugg AS (
    SELECT
        str_to_date(concat(yearweek(notifications.sent_at), ' Monday'),'%X%V %W') AS 'Date',
        ifnull(os.business_line,'torre_free') AS business_line,
        ifnull(os.reach,0) AS reach,
        count(*) AS 'Notifications_sugg'
    FROM
        notifications
        LEFT JOIN opps_services os ON CONVERT(JSON_EXTRACT(notifications.context, '$."opportunityId"'), UNSIGNED) = os.opportunity_id
    WHERE
        notifications.template = 'talent-candidate-manually-invited'
        AND notifications.status = 'sent'
        AND notifications.sent_at >= '2023-01-01'
    GROUP BY    
        str_to_date(concat(yearweek(notifications.sent_at), ' Monday'),'%X%V %W'),
        os.business_line,
        os.reach
) SELECT * FROM weekly_autotrigg_sugg;