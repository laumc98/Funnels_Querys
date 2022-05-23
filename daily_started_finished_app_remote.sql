select
  opportunity_candidates.created as `daily_date`,
  IF(ISNULL(interested), 'started', 'finished') as finished,
  tc.utm_medium as UTM,
  count(distinct opportunity_candidates.id) as daily_applications
from
  opportunity_candidates
  inner join opportunities as o on opportunity_candidates.opportunity_id = o.id
  left join tracking_code_candidates as tcc
  left join tracking_codes as tc on tcc.tracking_code_id = tc.id on tcc.candidate_id = opportunity_candidates.id
  left join opportunity_members on o.id = opportunity_members.opportunity_id
  and poster = 1
  left join people on opportunity_members.person_id = people.id
  left join person_flags on people.id = person_flags.person_id
where
  opportunity_candidates.created >= "2021-06-01"
  and opportunity_candidates.created < date(date_add(now(6), INTERVAL 1 day))
  and o.objective not like '***%'
  and tc.utm_medium in (
    'srh_jobs',
    'am_inv',
    'ja_mtc',
    'am_sug',
    'rc_cb_rcdt',
    'rc_trrx_inv',
    'rc_ccg',
    'ro_sug',
    'rc_syn',
    'rc_src',
    'pr_sml_jobs',
    'syn',
    'src',
    'sml_jobs',
    'trr_crg',
    'trr_webinars',
    'google_jobs',
    'syn_rqt',
    'shr_ts',
    'ref_ts',
    'ref_ptn',
    'ref_cdt',
    'ref_vst_imp',
    'ja_rlvsgl_prs',
    'ja_allsgl_prs',
    'ja_rlvsgl_org',
    'ja_allsgl_org'
  )
  and (o.remote = 1)
group by 1,2,3