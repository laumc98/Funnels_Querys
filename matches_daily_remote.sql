SELECT
    date("atomic"."com_torrelabs_match_distributed_3"."root_tstamp") as daily_date,
    model,
    count(*) AS daily_count
FROM
    "atomic"."com_torrelabs_match_distributed_3"
WHERE
    (
        "atomic"."com_torrelabs_match_distributed_3"."root_tstamp" >= '2021-08-08'
    )
    AND "atomic"."com_torrelabs_match_distributed_3"."opportunity_remote" = 1
GROUP BY 1,2