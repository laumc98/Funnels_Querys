/* AA : Channel's performance : weekly app remote : prod */ 
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
),weekly_applications AS (
    SELECT
        str_to_date(concat(yearweek(oc.interested), ' Monday'),'%X%V %W') AS 'Date',
        IFNULL(os.business_line,'torre_free') AS 'business_line',
        ifnull(os.reach,0) AS reach,
        tc.utm_medium AS 'UTM',
        count(distinct oc.id) AS 'App'
    FROM
        opportunity_candidates oc 
        INNER JOIN opportunities o ON oc.opportunity_id = o.id 
        LEFT JOIN opps_services os ON oc.opportunity_id = os.opportunity_id
        LEFT JOIN tracking_code_candidates tcc ON oc.id = tcc.candidate_id
        LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id 
    WHERE
        oc.interested IS NOT NULL 
        AND oc.interested > '2022-7-18'
        AND o.objective NOT LIKE '**%'
        AND oc.application_step IS NOT NULL
        AND o.crawled = FALSE
        AND o.id NOT IN (
            SELECT DISTINCT opportunity_id
            FROM opportunity_organizations
            WHERE organization_id IN (748404,1510092)
                AND active
        )
    GROUP BY 
        str_to_date(concat(yearweek(oc.interested), ' Monday'),'%X%V %W'),
        os.business_line,
        os.reach,
        tc.utm_medium
) SELECT * FROM weekly_applications;