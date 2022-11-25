/* AA : channel performance : applications by candidate recruiters: prod */ 
SELECT
    date(oc.interested) AS 'date',
    o.id AS ID,
    o.fulfillment,
    tc.utm_medium AS 'utm_medium',
    tc.utm_campaign AS 'cr_campaign',
    count(distinct oc.id) AS 'applications'
FROM
    opportunity_candidates oc 
    INNER JOIN opportunities o ON oc.opportunity_id = o.id 
    LEFT JOIN tracking_code_candidates tcc ON oc.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id 
WHERE
    oc.interested IS NOT NULL 
    AND oc.interested >= date(date_add(now(6), INTERVAL -3 month))
    AND (tc.utm_campaign = 'amdm'
        OR tc.utm_campaign = 'mcog'
        OR tc.utm_campaign = 'dffa'
        OR tc.utm_campaign = 'czp'
        OR tc.utm_campaign = 'jdpb'
        OR tc.utm_campaign = 'dmc'
        OR tc.utm_campaign = 'nsr'
        OR tc.utm_campaign = 'mmor'
    )
    AND tc.utm_medium IN ('src','rc_src','rc_src_trxx_inv','syn','rc_syn','rc_syn_trrx_inv','syn_paid','rc_syn_paid')
GROUP BY 
    date(oc.interested),
    o.id,
    o.fulfillment,
    tc.utm_medium,
    tc.utm_campaign