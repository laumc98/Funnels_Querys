/* AA : channel performance : started applications by candidate recruiters: prod */ 
SELECT
  date(opportunity_candidates.created) AS 'date',
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
  opportunity_candidates.created >= "2022-10-01"
  AND o.objective not like '***%'
  AND tc.utm_medium IN ('rc_syn','syn_paid','rc_syn_paid','rc_syn_trrx_inv')
  AND tc.utm_campaign IN ('amdm','mcog','dffa','czp','jdpb','dmc','nsr','mmor')
GROUP BY 1,2,3,4