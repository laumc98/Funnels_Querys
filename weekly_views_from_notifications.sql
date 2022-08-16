SELECT
    (CAST(date_trunc('week',CAST(("atomic"."events"."collector_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) AS "date",
    "atomic"."events"."mkt_medium" AS "UTM",
    count(distinct "atomic"."events"."domain_userid") AS "weekly_views_notifications"
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
    )
GROUP BY
    (CAST(date_trunc('week',CAST(("atomic"."events"."collector_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')),
    "atomic"."events"."mkt_medium"
ORDER BY
    (CAST(date_trunc('week',CAST(("atomic"."events"."collector_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) ASC