/* AA : channel performance : ready for interview by candidate recruiters: prod */ 
SELECT
    date(ready_for_interview.created) AS 'date',
    ready_for_interview.id AS 'ID',
    ready_for_interview.fulfillment,
    ready_for_interview.utm_medium AS 'utm_medium',
    ready_for_interview.utm_campaign AS 'cr_campaign',
    count(*) AS 'ready_for_interview'
FROM
(
    SELECT
        occh.candidate_id,
        min(occh.created) AS 'created',
        o.id,
        o.fulfillment,
        tc.utm_medium,
        tc.utm_campaign
    FROM
        opportunity_candidate_column_history occh
        INNER JOIN opportunity_columns oc ON occh.to = oc.id
        INNER JOIN opportunities o ON oc.opportunity_id = o.id
        LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
        LEFT JOIN tracking_code_candidates tcc ON oca.id = tcc.candidate_id
        LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
    WHERE
        oc.funnel_tag = 'ready_for_interview'
        AND occh.created >= "2022-10-20"
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
        )
        AND tc.utm_medium IN ('src','rc_src','rc_src_trrx_inv','syn','rc_syn','rc_syn_trrx_inv','syn_paid','rc_syn_paid','rc_syn_paid_trrx_inv','syn_rqt','rc_syn_rqt')
    GROUP BY
        occh.candidate_id
) AS ready_for_interview
GROUP BY 
    date(ready_for_interview.created),
    ready_for_interview.id,
    ready_for_interview.fulfillment,
    ready_for_interview.utm_medium,
    ready_for_interview.utm_campaign
ORDER BY 
    date(ready_for_interview.created) ASC 