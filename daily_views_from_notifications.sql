SELECT
    CAST("atomic"."events"."collector_tstamp" AS date) AS "daily_date",
    "atomic"."events"."mkt_medium" AS "UTM",
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
    )
GROUP BY
    CAST("atomic"."events"."collector_tstamp" AS date),
    "atomic"."events"."mkt_medium"
ORDER BY
    CAST("atomic"."events"."collector_tstamp" AS date) ASC