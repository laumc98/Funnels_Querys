/* AA : channels performance : daily src mm by app date: prod */ 
SELECT
    date(oca.interested) AS 'date',
    tc.utm_campaign AS 'utm_campaign_src_mm',
    count(distinct occh.candidate_id) AS 'count_mm_src'
FROM
    opportunity_candidate_column_history occh
    INNER JOIN opportunity_columns oc ON occh.to = oc.id
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
    LEFT JOIN tracking_code_candidates tcc ON oca.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
WHERE
    oc.name = 'mutual matches'
    AND oca.interested >= '2022-03-01'
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
            o.reviewed >= '2021/01/01'
            AND o.objective NOT LIKE '**%'
            AND o.review = 'approved'
    )
    AND (
        tc.utm_campaign = 'lfpa'
        OR tc.utm_campaign = 'mmor'
        OR tc.utm_campaign = 'smnb'
        OR tc.utm_campaign = 'gco'
        OR tc.utm_campaign = 'mabv'
        OR tc.utm_campaign = 'rrp'
        OR tc.utm_campaign = 'mmag'
        OR tc.utm_campaign = 'jmmg'
        OR tc.utm_campaign = 'dncg'
        OR tc.utm_campaign = 'jngd'
        OR tc.utm_campaign = 'mfp'
        OR tc.utm_campaign = 'admp'
        OR tc.utm_campaign = 'kjem'
        OR tc.utm_campaign = 'mamg'
        OR tc.utm_campaign = 'afdg'
        OR tc.utm_campaign = 'xncs'
        OR tc.utm_campaign = 'fcc'
        OR tc.utm_campaign = 'ana'
        OR tc.utm_campaign = 'erg'
        OR tc.utm_campaign = 'mnmv'
        OR tc.utm_campaign = 'mahp'
        OR tc.utm_campaign = 'npd'
        OR tc.utm_campaign = 'llcg'
        OR tc.utm_campaign = 'lmmg'
        OR tc.utm_campaign = 'mpsm'
        OR tc.utm_campaign = 'jppr'
        OR tc.utm_campaign = 'mbvb'
        OR tc.utm_campaign = 'ago'
        OR tc.utm_campaign = 'bcgt'
        OR tc.utm_campaign = 'lfpa_ra'
        OR tc.utm_campaign = 'mmor_ra'
        OR tc.utm_campaign = 'smnb_ra'
        OR tc.utm_campaign = 'gco_ra'
        OR tc.utm_campaign = 'mabv_ra'
        OR tc.utm_campaign = 'rrp_ra'
        OR tc.utm_campaign = 'mmag_ra'
        OR tc.utm_campaign = 'jmmg_ra'
        OR tc.utm_campaign = 'dncg_ra'
        OR tc.utm_campaign = 'jngd_ra'
        OR tc.utm_campaign = 'mfp_ra'
        OR tc.utm_campaign = 'admp_ra'
        OR tc.utm_campaign = 'kjem_ra'
        OR tc.utm_campaign = 'mamg_ra'
        OR tc.utm_campaign = 'afdg_ra'
        OR tc.utm_campaign = 'xncs_ra'
        OR tc.utm_campaign = 'fcc_ra'
        OR tc.utm_campaign = 'ana_ra'
        OR tc.utm_campaign = 'erg_ra'
        OR tc.utm_campaign = 'mnmv_ra'
        OR tc.utm_campaign = 'mahp_ra'
        OR tc.utm_campaign = 'npd_ra'
        OR tc.utm_campaign = 'llcg_ra'
        OR tc.utm_campaign = 'lmmg_ra'
        OR tc.utm_campaign = 'mpsm_ra'
        OR tc.utm_campaign = 'jppr_ra'
        OR tc.utm_campaign = 'mbvb_ra'
        OR tc.utm_campaign = 'ago_ra'
        OR tc.utm_campaign = 'bcgt_ra'
    )
GROUP BY
    date(oca.interested),
    tc.utm_campaign
ORDER BY
    date(occh.created) ASC