SELECT "atomic"."com_torrelabs_referrer_token_generated_1"."root_tstamp" AS "root_tstamp", "atomic"."com_torrelabs_referrer_token_generated_1"."user_gg_id" AS "user_gg_id",SUBSTRING("atomic"."com_torrelabs_referrer_token_generated_1"."action" , 13, 20) AS "AlfaID" 
FROM "atomic"."com_torrelabs_referrer_token_generated_1"
LEFT JOIN "atomic"."com_torrelabs_user_context_1" "Com Torrelabs User Context 1 - Root" ON "atomic"."com_torrelabs_referrer_token_generated_1"."root_id" = "Com Torrelabs User Context 1 - Root"."root_id"
WHERE "Com Torrelabs User Context 1 - Root"."is_test" = 0 
   AND ((lower("atomic"."com_torrelabs_referrer_token_generated_1"."action") like 'opportunity%')
   AND (NOT (lower("atomic"."com_torrelabs_referrer_token_generated_1"."action") like '%draft%')
    OR "atomic"."com_torrelabs_referrer_token_generated_1"."action" IS NULL) 
   AND (NOT (lower("atomic"."com_torrelabs_referrer_token_generated_1"."action") like '%undefined%') 
    OR "atomic"."com_torrelabs_referrer_token_generated_1"."action" IS NULL))
LIMIT 1048575