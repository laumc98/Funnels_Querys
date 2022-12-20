/* AA : channel performance : applications rc channels by candidate recruiters: prod */ 
SELECT
    date(oc.interested) AS 'date',
    tc.utm_medium AS 'utm_medium',
    people.name AS 'Candidate recruiter',
    count(distinct oc.id) AS 'applications'
FROM
    opportunity_candidates oc 
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN people ON o.candidate_recruiter_person_id = people.id
    LEFT JOIN tracking_code_candidates tcc ON oc.id = tcc.candidate_id
    LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id 
WHERE
    oc.interested IS NOT NULL 
    AND oc.interested >=  "2022-10-20"
    AND o.candidate_recruiter_person_id IS NOT NULL 
    AND o.candidate_recruiter_person_id != 65
    AND tc.utm_medium IN ('rc_src','rc_src_trrx_inv','rc_syn','rc_syn_trrx_inv','rc_syn_paid','rc_trrx_inv','rc_cb_rcdt','rc_ccg','rc_sml_jobs','rc_am_sug')
GROUP BY 
    date(oc.interested),
    tc.utm_medium,
    people.name