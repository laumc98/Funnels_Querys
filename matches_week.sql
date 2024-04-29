/* AA : Channel's performance : weekly job matches remote : prod */ 
SELECT
    (CAST(date_trunc('week',CAST(("snowplow"."com_torrelabs_match_distributed_3"."root_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) as Date,
    model,
    opportunity_ref AS AlfaID,
    count(*)
FROM
    "snowplow"."com_torrelabs_match_distributed_3"
WHERE
    (
        "snowplow"."com_torrelabs_match_distributed_3"."root_tstamp" >= '2021-08-8'
    )
GROUP BY 1,2,3