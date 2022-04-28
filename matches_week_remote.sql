select (CAST(date_trunc('week', CAST(("atomic"."com_torrelabs_match_distributed_3"."root_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) as date, count(*), model
from "atomic"."com_torrelabs_match_distributed_3"
WHERE ("atomic"."com_torrelabs_match_distributed_3"."root_tstamp" >= CAST(dateadd('day', -272, CAST(getdate() AS timestamp)) AS date)
   AND "atomic"."com_torrelabs_match_distributed_3"."root_tstamp" < CAST(getdate() AS date))
   AND "atomic"."com_torrelabs_match_distributed_3"."opportunity_remote" = 1
group by model, 1
