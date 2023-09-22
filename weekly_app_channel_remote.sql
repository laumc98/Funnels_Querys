/* AA : Channel's performance : weekly app remote : prod */ 
SELECT
    str_to_date(concat(yearweek(oc.interested), ' Sunday'),'%X%V %W') AS 'date',
    o.id AS 'ID',
    o.fulfillment AS 'fulfillment',
    tc.utm_medium AS 'Tracking Codes__utm_medium',
    count(distinct oc.id) AS 'weekly_app_channel_remote'
FROM
    opportunity_candidates oc 
    INNER JOIN opportunities o ON oc.opportunity_id = o.id 
    LEFT JOIN tracking_code_candidates tcc ON oc.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id 
WHERE
    oc.interested IS NOT NULL 
    AND oc.interested > '2021-7-18'
    AND o.objective NOT LIKE '**%'
    AND oc.application_step IS NOT NULL
    AND o.crawled = FALSE
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
GROUP BY 
    str_to_date(concat(yearweek(oc.interested), ' Sunday'),'%X%V %W'),
    o.id,
    o.fulfillment,
    tc.utm_medium