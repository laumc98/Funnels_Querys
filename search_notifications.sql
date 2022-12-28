/* AA : Channel's performance : Search notifications : prod */ 
SELECT
    (CAST(date_trunc('week',CAST((sp."root_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) AS "date",
    SUM(results_open) AS weekly_search
FROM
    "snowplow"."com_torrelabs_discovery_search_performance_5" sp
WHERE
    sp."search_target" = 'opportunities'
    AND date(sp."root_tstamp") > '2022-01-08'
GROUP BY
    1