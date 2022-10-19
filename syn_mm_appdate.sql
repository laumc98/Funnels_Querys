SELECT
    date(oca.interested) AS 'date',
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
    AND oca.interested >= '2022-04-01'
    AND date(oca.interested) = date(occh.created)
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
    )
GROUP BY
    date(oca.interested),
    tc.utm_campaign
ORDER BY
    date(occh.created) ASC