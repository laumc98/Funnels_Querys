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
    AND oc.interested >=  "2022-10-20"
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
        OR tc.utm_campaign = 'fcr'
        OR tc.utm_campaign = 'mes'
        OR tc.utm_campaign = 'mcmn'
        OR tc.utm_campaign = 'mfo'
        OR tc.utm_campaign = 'smfp'
        OR tc.utm_campaign = 'gebj'
        OR tc.utm_campaign = 'aamf'
        OR tc.utm_campaign = 'eb'
        OR tc.utm_campaign = 'kglm'
        OR tc.utm_campaign = 'sm'
        OR tc.utm_campaign = 'brc'
        OR tc.utm_campaign = 'vaio'
        OR tc.utm_campaign = 'exrm'
        OR tc.utm_campaign = 'jsmn'
        OR tc.utm_campaign = 'lfas'
        OR tc.utm_campaign = 'malm'
        OR tc.utm_campaign = 'lbmp'
        OR tc.utm_campaign = 'capi'
        OR tc.utm_campaign = 'cals'
        OR tc.utm_campaign = 'bb'
        OR tc.utm_campaign = 'jcmv'
        OR tc.utm_campaign = 'egc'
        OR tc.utm_campaign = 'mdr'
    )
    AND tc.utm_medium IN ('src','rc_src','rc_src_trrx_inv','syn','rc_syn','rc_syn_trrx_inv','syn_paid','rc_syn_paid','rc_syn_paid_trrx_inv','syn_rqt','rc_syn_rqt')
GROUP BY 
    date(oc.interested),
    o.id,
    o.fulfillment,
    tc.utm_medium,
    tc.utm_campaign