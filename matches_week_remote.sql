/* AA : Channel's performance : weekly job matches remote : prod */ 
SELECT
    date("snowplow"."com_torrelabs_match_distributed_3"."root_tstamp") as date,
    model,
    opportunity_ref AS AlfaID,
    count(*)
FROM
    "snowplow"."com_torrelabs_match_distributed_3"
WHERE
    (
        "snowplow"."com_torrelabs_match_distributed_3"."root_tstamp" >= '2021-08-17'
    )
GROUP BY 1,2,3