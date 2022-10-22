SELECT
    CAST("snowplow"."events"."collector_tstamp" AS date) AS "daily_date",
    SUBSTRING("snowplow"."events"."page_urlpath",7,8) as "Alfa ID",
    "snowplow"."events"."mkt_medium" AS "UTM",
    count(distinct "snowplow"."events"."domain_userid") AS "daily_views_notifications"
FROM
    "snowplow"."events"
WHERE
    (
        "snowplow"."events"."event" = 'page_view'
        AND (
            lower("snowplow"."events"."page_url") like '%post%'
        )
        AND (
            lower("snowplow"."events"."page_urlpath") like '%post%'
        )
    )
GROUP BY
    CAST("snowplow"."events"."collector_tstamp" AS date),
    "snowplow"."events"."mkt_medium",
    SUBSTRING("snowplow"."events"."page_urlpath",7,8)
ORDER BY
    CAST("snowplow"."events"."collector_tstamp" AS date) ASC