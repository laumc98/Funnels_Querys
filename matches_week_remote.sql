/* AA : Channel's performance : weekly job matches remote : prod */ 
select
    (CAST(date_trunc('week',CAST(("atomic"."com_torrelabs_match_distributed_3"."root_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) as date,
    count(*),
    model
from
    "atomic"."com_torrelabs_match_distributed_3"
WHERE
    (
        "atomic"."com_torrelabs_match_distributed_3"."root_tstamp" >= '2021-08-08'
        AND "atomic"."com_torrelabs_match_distributed_3"."root_tstamp" < CAST(getdate() AS date)
    )
group by model,1

