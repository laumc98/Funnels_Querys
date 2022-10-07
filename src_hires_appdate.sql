/* AA : channel performance : weekly src hires by campaign: prod */ 
SELECT
    date(oc.interested) AS 'date',
    tc.utm_campaign AS 'utm_campaign_src_hires',
    count(distinct ooh.opportunity_candidate_id) AS 'count_hires_src'
FROM
    opportunity_operational_hires ooh
    LEFT JOIN tracking_code_candidates tcc ON ooh.opportunity_candidate_id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
    LEFT JOIN opportunity_candidates oc ON ooh.opportunity_candidate_id = oc.id
WHERE
    ooh.hiring_date IS NOT NULL
    AND ooh.hiring_date >= '2022-05-01'
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
        OR tc.utm_campaign = 'DPO'
        OR tc.utm_campaign = 'jdmb'
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
        OR tc.utm_campaign = 'DPO_ra'
        OR tc.utm_campaign = 'jdmb_ra'
    )
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
            o.reviewed >= '2021/01/01'
            AND o.objective NOT LIKE '**%'
            AND o.review = 'approved'
    )
GROUP BY
    date(oc.interested),
    tc.utm_campaign