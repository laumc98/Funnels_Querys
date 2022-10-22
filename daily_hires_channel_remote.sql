/* AA : Channel's performance : Daily hires remote : prod */ 
SELECT
    date(ooh.hiring_date) AS 'daily_date',
    o.fulfillment AS 'fulfillment',
    tc.utm_medium AS 'Tracking Codes__utm_medium',
    count(distinct ooh.opportunity_candidate_id) AS 'daily_hires_channel_remote'
FROM 
    opportunity_operational_hires ooh
    LEFT JOIN tracking_code_candidates tcc ON ooh.opportunity_candidate_id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
    LEFT JOIN opportunities o ON ooh.opportunity_id = o.id
WHERE
    ooh.hiring_date IS NOT NULL 
    AND ooh.hiring_date > '2021-7-1'
    AND ooh.opportunity_id IN (
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
GROUP BY
    date(ooh.hiring_date),
    tc.utm_medium,
    o.fulfillment