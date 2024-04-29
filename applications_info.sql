/* AA : Channel's performance : app info : prod */ 
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
                 FIND_IN_SET('1', gs.services)>0 /* agile */
                 OR FIND_IN_SET('7', gs.services)>0 /* staff augmentation */
                 OR FIND_IN_SET('20', gs.services)>0 /* hunt */
            ) THEN 'rpo'
            WHEN (
                FIND_IN_SET('8', gs.services)>0 /* ats */
                OR FIND_IN_SET('9', gs.services)>0 /* pro */
                OR FIND_IN_SET('16', gs.services)>0 /* torre_os */
            ) THEN 'torre_os'
            WHEN (
                (
                 FIND_IN_SET('2', gs.services)>0 /* essentials */
                 OR FIND_IN_SET('6', gs.services)>0 /* self service */
                 OR services = ''
                 OR services IS NULL
                 )
            ) THEN 'torre_free'
            WHEN (
                FIND_IN_SET('11', gs.services)>0 /* boost */
                OR FIND_IN_SET('12', gs.services)>0 /* boost hqa */
            ) THEN 'boost'
            ELSE 'others'
        END AS business_line,
        (
            FIND_IN_SET('17', gs.services)>0 /* torre_reach_essential */
            OR FIND_IN_SET('18', gs.services)>0 /* torre_reach_syndication */
            OR FIND_IN_SET('19', gs.services)>0 /* torre_reach_sourcing */
        ) AS reach,
        services
    FROM
        groupped_services gs
        INNER JOIN opportunities o ON gs.opportunity_id=o.id
),
app_info AS (
    SELECT
        opportunity_candidates.interested AS 'application date',
        opportunity_candidates.opportunity_id AS 'ID',
        ifnull(os.business_line,'torre_free') AS business_line,
        people.gg_id AS 'gg_id',
        people.username AS 'Username'
    FROM 
        opportunity_candidates
        LEFT JOIN people ON opportunity_candidates.person_id = people.id
        LEFT JOIN opportunities ON opportunity_candidates.opportunity_id = opportunities.id
        LEFT JOIN opps_services os ON opportunity_candidates.opportunity_id = os.opportunity_id
    WHERE 
        opportunity_candidates.interested IS NOT NULL 
        AND opportunity_candidates.interested > '2022-10-25'
) SELECT * FROM app_info;