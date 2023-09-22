/* AA : Channel's performance : Daily hires remote : prod */ 
SELECT
    date(all_hires.hire_date) AS 'daily_date',
    o.fulfillment AS 'fulfillment',
    tc.utm_medium AS 'Tracking Codes__utm_medium',
    count(distinct all_hires.candidate_id) AS 'daily_hires_channel_remote'
FROM
    (
        SELECT
            DATE(ooh.hiring_date) AS 'hire_date',
            ooh.opportunity_candidate_id AS 'candidate_id'
        FROM 
            opportunity_operational_hires ooh
        WHERE
            ooh.hiring_date > '2021-7-18'
            
        UNION
        
        SELECT
            MIN(occh.created) AS 'hire_date',
            occh.candidate_id AS 'candidate_id'
        FROM
            opportunity_candidate_column_history occh
            INNER JOIN opportunity_candidates ocan ON occh.candidate_id = ocan.id
            INNER JOIN opportunities o ON ocan.opportunity_id = o.id
        WHERE
            occh.created >= '2022-01-01'
            AND occh.to_funnel_tag = 'hired'
            AND (
                o.fulfillment LIKE 'self%'
                OR o.fulfillment LIKE 'essentials%'
                OR o.fulfillment LIKE 'pro%'
                OR o.fulfillment LIKE 'ats%'
            )
        GROUP BY
            occh.candidate_id
    ) AS all_hires
    INNER JOIN opportunity_candidates ocan ON all_hires.candidate_id = ocan.id
    INNER JOIN opportunities o ON ocan.opportunity_id = o.id
    LEFT JOIN tracking_code_candidates tcc ON ocan.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
WHERE 
    o.id IN (
        SELECT
            DISTINCT o.id AS opportunity_id
        FROM
            opportunities o
            INNER JOIN opportunity_members omp ON omp.opportunity_id = o.id
            AND omp.poster = TRUE
            INNER JOIN person_flags pf ON pf.person_id = omp.person_id
            AND pf.opportunity_crawler = FALSE
        WHERE
            date(coalesce(null, o.first_reviewed, o.last_reviewed)) >= '2021/01/01'
            AND o.objective NOT LIKE '**%'
            AND o.review = 'approved'
        )
    AND o.crawled = FALSE
GROUP BY 
    date(all_hires.hire_date),
    tc.utm_medium,
    o.fulfillment