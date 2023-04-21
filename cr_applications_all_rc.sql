/* AA : channel performance : applications rc channels by candidate recruiters: prod */ 
SELECT
    date(oc.interested) AS 'date',
    o.id AS ID,
    o.fulfillment,
    tc.utm_medium AS 'utm_medium',
    count(distinct oc.id) AS 'applications'
FROM
    opportunity_candidates oc 
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN tracking_code_candidates tcc ON oc.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id 
WHERE
    oc.interested IS NOT NULL 
    AND oc.interested >=  "2022-10-20"
    AND tc.utm_medium IN ('rc_src','rc_src_trrx_inv','rc_syn','rc_syn_trrx_inv','rc_syn_paid','rc_syn_paid_trrx_inv','rc_trrx_inv','rc_cb_rcdt','rc_ccg','rc_sml_jobs','rc_am_sug')
GROUP BY 
    date(oc.interested),
    o.id,
    o.fulfillment,
    tc.utm_medium