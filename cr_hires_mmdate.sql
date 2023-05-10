/* AA : channel performance : hires by candidate recruiters by mm date: prod */ 
SELECT
    date(occh.created) AS 'date',
    o.id AS ID,
    o.fulfillment,
    tc.utm_medium AS 'utm_medium',
    tc.utm_campaign AS 'cr_campaign',
    count(distinct ooh.opportunity_candidate_id) AS 'hires'
FROM
    opportunity_operational_hires ooh
    LEFT JOIN opportunities o ON ooh.opportunity_id = o.id
    LEFT JOIN tracking_code_candidates tcc ON ooh.opportunity_candidate_id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
    LEFT JOIN opportunity_candidate_column_history occh ON occh.candidate_id = ooh.opportunity_candidate_id
    LEFT JOIN opportunity_columns oc ON occh.to = oc.id
WHERE
    ooh.hiring_date IS NOT NULL
    AND ooh.hiring_date >= "2022-10-20"
    AND oc.name = 'mutual matches'
    AND (tc.utm_campaign = 'amdm'
        OR tc.utm_campaign = 'mcog'
        OR tc.utm_campaign = 'dffa'
        OR tc.utm_campaign = 'czp'
        OR tc.utm_campaign = 'jdpb'
        OR tc.utm_campaign = 'dmc'
        OR tc.utm_campaign = 'nsr'
        OR tc.utm_campaign = 'mmor'
        OR tc.utm_campaign = 'JAMC'
        OR tc.utm_campaign = 'mgdd'
        OR tc.utm_campaign = 'mrh'
        OR tc.utm_campaign = 'srl'
        OR tc.utm_campaign = 'avs'
        OR tc.utm_campaign = 'sbr'
        OR tc.utm_campaign = 'tavp'
        OR tc.utm_campaign = 'rmr' 
        OR tc.utm_campaign = 'dgv'
        OR tc.utm_campaign = 'MER' 
        OR tc.utm_campaign = 'ACMP'
        OR tc.utm_campaign = 'dgc' 
    )
    AND tc.utm_medium IN ('src','rc_src','rc_src_trrx_inv','syn','rc_syn','rc_syn_trrx_inv','syn_paid','rc_syn_paid','rc_syn_paid_trrx_inv')
GROUP BY
    date(occh.created),
    o.id,
    o.fulfillment,
    tc.utm_medium,
    tc.utm_campaign