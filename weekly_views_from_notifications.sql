SELECT
    (CAST(date_trunc('week',CAST(("atomic"."events"."derived_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) AS "date",
    "atomic"."events"."mkt_medium" AS "UTM",
    count(*) AS "weekly_views_notifications"
FROM
    "atomic"."events"
WHERE
    (
        "atomic"."events"."event" = 'page_view'
        AND (
            lower("atomic"."events"."page_url") like '%post%'
        )
        AND (
            "atomic"."events"."mkt_medium" = 'am_sug'
            OR "atomic"."events"."mkt_medium" = 'srh_jobs'
            OR "atomic"."events"."mkt_medium" = 'ja_mtc'
            OR "atomic"."events"."mkt_medium" = 'ja_allsgl_org'
            OR "atomic"."events"."mkt_medium" = 'ja_allsgl_prs'
            OR "atomic"."events"."mkt_medium" = 'ja_rlvsgl_prs'
            OR "atomic"."events"."mkt_medium" = 'ja_rlvsgl_org'
            OR "atomic"."events"."mkt_medium" = 'rc_cb_rcdt'
            OR "atomic"."events"."mkt_medium" = 'sml_jobs'
            OR "atomic"."events"."mkt_medium" = 'am_inv'
            OR "atomic"."events"."mkt_medium" = 'rc_am_sug'
            OR "atomic"."events"."mkt_medium" = 'rc_trrx_inv'
            OR "atomic"."events"."mkt_medium" = 'rc_syn'
            OR "atomic"."events"."mkt_medium" = 'rc_src'
            OR "atomic"."events"."mkt_medium" = 'rc_ccg'
        )
    )
GROUP BY
    (CAST(date_trunc('week',CAST(("atomic"."events"."derived_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')),
    "atomic"."events"."mkt_medium"
ORDER BY
    (CAST(date_trunc('week',CAST(("atomic"."events"."derived_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) ASC