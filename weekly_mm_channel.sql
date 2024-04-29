/* AA : Channel's performance : weekly mm remote : prod */ 
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
),weekly_mutual_matches AS (
    SELECT
        str_to_date(concat(yearweek(mutual_matches.created), ' Monday'),'%X%V %W') AS 'Date',
        mutual_matches.business_line AS 'business_line',
        mutual_matches.reach,
        mutual_matches.utm_medium AS 'UTM',
        count(*) AS 'MM'
    FROM
    (
        SELECT 
            occh.candidate_id,
            oca.opportunity_id,
            IFNULL(os.business_line,'torre_free') AS business_line,
            ifnull(os.reach,0) AS reach,
            tc.utm_medium,
            MIN(occh.created) AS created
        FROM
            opportunity_candidate_column_history occh
            INNER JOIN opportunity_columns oc ON occh.to = oc.id
            INNER JOIN opportunities o ON oc.opportunity_id = o.id
            LEFT JOIN opps_services os ON oc.opportunity_id = os.opportunity_id
            LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
            LEFT JOIN tracking_code_candidates tcc ON oca.id = tcc.candidate_id
            LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
        WHERE
            oc.name = 'mutual matches'
            AND occh.created >= '2022-06-01'
            AND oca.interested IS NOT NULL 
            AND o.objective NOT LIKE '**%'
            AND o.crawled = FALSE
            AND o.id NOT IN (
                SELECT DISTINCT opportunity_id
                FROM opportunity_organizations
                WHERE organization_id IN (748404,1510092)
                    AND active
            )
        GROUP BY
            occh.candidate_id,
            oca.opportunity_id,
            os.business_line,
            os.reach,
            tc.utm_medium
    ) AS mutual_matches
    GROUP BY 
        str_to_date(concat(yearweek(mutual_matches.created), ' Monday'),'%X%V %W'),
        mutual_matches.business_line,
        mutual_matches.reach,
        mutual_matches.utm_medium
) SELECT * FROM weekly_mutual_matches;