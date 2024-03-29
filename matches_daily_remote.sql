/* AA : Channel's performance : daily job matches remote : prod */
SELECT
    date("atomic"."com_torrelabs_match_distributed_3"."root_tstamp") as daily_date,
    model,
    opportunity_ref AS AlfaID,
    count(*) AS daily_count
FROM
    "atomic"."com_torrelabs_match_distributed_3"
WHERE
    (
        "atomic"."com_torrelabs_match_distributed_3"."root_tstamp" >= '2021-08-08'
    )
GROUP BY 1,2,3