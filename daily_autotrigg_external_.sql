SELECT
    date(oc.created) as daily_date,
    count(*) as 'count_trigg_ext'
FROM
    opportunity_candidates oc
    inner join member_evaluations me on me.candidate_id = oc.id
    inner join people p on oc.person_id = p.id
    inner join opportunities o on oc.opportunity_id = o.id
WHERE
    (
        me.interested is not null
        and me.not_interested is null
        and me.send_disqualified_notification = false
        and oc.column_id is null
        and oc.application_step is null
        and o.remote = 1
        and oc.created >= "2022-01-01"
        and oc.created < date(date_add(now(6), INTERVAL 1 day))
    )
GROUP BY 1