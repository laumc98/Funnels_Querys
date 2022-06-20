SELECT
    CAST("atomic"."events"."collector_tstamp" AS date) AS "daily_date",
    "atomic"."events"."mkt_medium" AS "UTM",
    SUBSTRING("atomic"."events"."page_urlpath",7,8) as "AlfaID",
    count(distinct "atomic"."events"."domain_userid") AS "daily_views_notifications"
FROM
    "atomic"."events"
WHERE
    (
        "atomic"."events"."event" = 'page_view'
        AND (
            lower("atomic"."events"."page_url") like '%post%'
        )
        AND (
            lower("atomic"."events"."page_urlpath") like '%post%'
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
            OR "atomic"."events"."mkt_medium" = 'rc_sml_jobs'
            OR "atomic"."events"."mkt_medium" = 'am_inv'
            OR "atomic"."events"."mkt_medium" = 'rc_am_sug'
            OR "atomic"."events"."mkt_medium" = 'rc_trrx_inv'
            OR "atomic"."events"."mkt_medium" = 'rc_syn'
            OR "atomic"."events"."mkt_medium" = 'rc_src'
            OR "atomic"."events"."mkt_medium" = 'rc_ccg'
        )
    )
GROUP BY
    CAST("atomic"."events"."collector_tstamp" AS date),
    "atomic"."events"."mkt_medium",
    SUBSTRING("atomic"."events"."page_urlpath",7,8)
ORDER BY
    CAST("atomic"."events"."collector_tstamp" AS date) ASC