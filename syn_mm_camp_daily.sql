/* AA : channel performance : daily syn mm by campaign: prod */ 
SELECT
    date(occh.created) AS 'date',
    tc.utm_campaign AS 'utm_campaign_syn_mm',
    count(distinct occh.candidate_id) AS 'count_mm_syn'
FROM
    opportunity_candidate_column_history occh
    INNER JOIN opportunity_columns oc ON occh.to = oc.id
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
    LEFT JOIN tracking_code_candidates tcc ON oca.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
WHERE
    oc.name = 'mutual matches'
    AND occh.created >= '2022-05-01'
    AND oca.interested IS NOT NULL 
    AND o.objective NOT LIKE '**%'
    AND o.id IN (
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
    AND (
        tc.utm_campaign = 'jams'
        OR tc.utm_campaign = 'lfrr'
        OR tc.utm_campaign = 'mmam'
        OR tc.utm_campaign = 'cals'
        OR tc.utm_campaign = 'wers'
        OR tc.utm_campaign = 'amdm'
        OR tc.utm_campaign = 'mmor'
        OR tc.utm_campaign = 'mcog'
        OR tc.utm_campaign = 'dffa'
        OR tc.utm_campaign = 'czp'
        OR tc.utm_campaign = 'jdpb'
        OR tc.utm_campaign = 'dmc'
        OR tc.utm_campaign = 'nsr'
    )
    AND tc.utm_medium IN ('syn','rc_syn')
GROUP BY
    date(occh.created),
    tc.utm_campaign
ORDER BY
    date(occh.created) ASC