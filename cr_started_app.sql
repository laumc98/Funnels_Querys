/* AA : channel performance : started applications by candidate recruiters: prod */ 
SELECT
  date(opportunity_candidates.created) AS 'date',
  o.id AS ID,
  o.fulfillment,
  tc.utm_medium AS 'utm_medium',
  tc.utm_campaign AS 'cr_campaign',
  IF(ISNULL(interested), 'started', 'finished') AS 'finished',
  count(distinct opportunity_candidates.id) AS 'started_finished_app'
FROM
  opportunity_candidates
  INNER JOIN opportunities as o on opportunity_candidates.opportunity_id = o.id
  LEFT JOIN tracking_code_candidates as tcc
  LEFT JOIN tracking_codes as tc on tcc.tracking_code_id = tc.id on tcc.candidate_id = opportunity_candidates.id
WHERE
  opportunity_candidates.created >= "2022-10-20"
  AND o.objective not like '***%'
  AND tc.utm_medium IN ('src','rc_src','rc_src_trrx_inv','syn','rc_syn','syn_paid','rc_syn_paid','rc_syn_trrx_inv','rc_syn_paid_trrx_inv')
  AND tc.utm_campaign IN ('amdm','mcog','dffa','czp','jdpb','dmc','nsr','mmor','JAMC','mgdd','mrh','srl','avs','sbr','tavp','rmr' ,'dgv','MER','ACMP','dgc','fcr','mes','mcmn','mfo','smfp','gebj','aamf','eb','kglm','sm','brc','vaio','exrm','jsmn')
GROUP BY 1,2,3,4,5,6