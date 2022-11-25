/* AA : channel performance : hires by candidate recruiters: prod */ 
SELECT
    date(ooh.hiring_date) AS 'date',
    ooh.opportunity_id AS ID,
    tc.utm_medium AS 'utm_medium',
    tc.utm_campaign AS 'cr_campaign',
    count(distinct ooh.opportunity_candidate_id) AS 'hires'
FROM
    opportunity_operational_hires ooh
    LEFT JOIN tracking_code_candidates tcc ON ooh.opportunity_candidate_id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
WHERE
    ooh.hiring_date IS NOT NULL
    AND ooh.hiring_date >= date(date_add(now(6), INTERVAL -3 month))
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
    date(ooh.hiring_date),
    ooh.opportunity_id,
    tc.utm_medium,
    tc.utm_campaign