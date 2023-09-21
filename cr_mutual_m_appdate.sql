/* AA : channel performance : mutual matches per app date by candidate recruiters: prod */ 
SELECT
    date(mutual_matches.interested) AS 'date',
    mutual_matches.id AS 'ID',
    mutual_matches.fulfillment,
    mutual_matches.utm_medium AS 'utm_medium',
    mutual_matches.utm_campaign AS 'cr_campaign',
    count(*) AS 'mutualm'
FROM
(
    SELECT
        occh.candidate_id,
        min(occh.created) AS 'created',
        oca.interested,
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
        oc.name = 'mutual matches'
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
        )
        AND tc.utm_medium IN ('src','rc_src','rc_src_trrx_inv','syn','rc_syn','rc_syn_trrx_inv','syn_paid','rc_syn_paid','rc_syn_paid_trrx_inv')
    GROUP BY
        occh.candidate_id
) AS mutual_matches
GROUP BY 
    date(mutual_matches.interested),
    mutual_matches.id,
    mutual_matches.fulfillment,
    mutual_matches.utm_medium,
    mutual_matches.utm_campaign
ORDER BY 
    date(mutual_matches.interested) ASC 