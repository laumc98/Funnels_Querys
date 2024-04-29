/* AA : channel performance : applications rc channels by candidate recruiters: prod */ 
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
),
cr_applications_all AS (
SELECT
    date(oc.interested) AS 'date',
    o.id AS ID,
    ifnull(os.business_line,'torre_free') AS business_line,
    ifnull(os.reach,0) AS reach,
    tc.utm_medium AS 'utm_medium',
    tc.utm_campaign AS 'cr_campaign',
    count(distinct oc.id) AS 'applications'
FROM
    opportunity_candidates oc 
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN opps_services os ON oc.opportunity_id = os.opportunity_id
    LEFT JOIN tracking_code_candidates tcc ON oc.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id 
WHERE
    oc.interested IS NOT NULL 
    AND oc.interested >=  "2022-10-20"
    AND o.crawled = FALSE
    AND tc.utm_medium IN ('rc_src','rc_src_trrx_inv','rc_syn','rc_syn_trrx_inv','rc_syn_paid','rc_syn_paid_trrx_inv','rc_trrx_inv','rc_cb_rcdt','rc_ccg','rc_sml_jobs','rc_am_sug','syn_rqt','rc_syn_rqt')
    AND o.id NOT IN (
        SELECT DISTINCT opportunity_id
        FROM opportunity_organizations
        WHERE organization_id IN (748404,1510092)
            AND active
    )
GROUP BY 
    date(oc.interested),
    o.id,
    os.business_line,
    os.reach,
    tc.utm_medium,
    tc.utm_campaign
) SELECT * FROM cr_applications_all;