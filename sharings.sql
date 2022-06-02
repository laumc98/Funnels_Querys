/* AA : Channel's performance : sharings notifications : prod */ 
SELECT
   (CAST(date_trunc('week',CAST(("atomic"."com_torrelabs_referrer_token_generated_1"."root_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) AS "date",
   "atomic"."com_torrelabs_referrer_token_generated_1"."user_gg_id" AS "gg_id",
   SUBSTRING("atomic"."com_torrelabs_referrer_token_generated_1"."action",13,20) AS "AlfaID"
FROM
   "atomic"."com_torrelabs_referrer_token_generated_1"
   LEFT JOIN "atomic"."com_torrelabs_user_context_1" "Com Torrelabs User Context 1 - Root" ON "atomic"."com_torrelabs_referrer_token_generated_1"."root_id" = "Com Torrelabs User Context 1 - Root"."root_id"
WHERE
   (
      "Com Torrelabs User Context 1 - Root"."is_test" = 0
      AND (
         lower(
            "atomic"."com_torrelabs_referrer_token_generated_1"."action"
         ) like 'opportunity%'
      )
      AND (
         NOT (
            lower(
               "atomic"."com_torrelabs_referrer_token_generated_1"."action"
            ) like '%draft%'
         )
         OR "atomic"."com_torrelabs_referrer_token_generated_1"."action" IS NULL
      )
      AND (
         NOT (
            lower(
               "atomic"."com_torrelabs_referrer_token_generated_1"."action"
            ) like '%undefined%'
         )
         OR "atomic"."com_torrelabs_referrer_token_generated_1"."action" IS NULL
      )
      AND "atomic"."com_torrelabs_referrer_token_generated_1"."root_tstamp" >= CAST(
         dateadd('day', -272, CAST(getdate() AS timestamp)) AS date
      )
      AND "atomic"."com_torrelabs_referrer_token_generated_1"."root_tstamp" < CAST(getdate() AS date)
   )