/* AA : Channel's performance : daily job matches remote : prod */
SELECT
    date("snowplow"."com_torrelabs_match_distributed_3"."root_tstamp") AS daily_date,
    model,
    opportunity_ref AS AlfaID
FROM
    "snowplow"."com_torrelabs_match_distributed_3"
WHERE
    (
        "snowplow"."com_torrelabs_match_distributed_3"."root_tstamp" >= '2021-07-17'
    )
GROUP BY
    date("snowplow"."com_torrelabs_match_distributed_3"."root_tstamp"),
    model,
    opportunity_ref