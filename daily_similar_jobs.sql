/* AA : Channel's performance : Similar jobs notifications : prod */ 
SELECT
      date("atomic"."com_torrelabs_similar_opportunity_clicked_1"."root_tstamp")  AS "daily_date",
      "atomic"."com_torrelabs_similar_opportunity_clicked_1"."clicked_opportunity_id" AS "clicked_opportunity_id",
      "atomic"."com_torrelabs_similar_opportunity_clicked_1"."opportunity_id" AS "AlfaID"
FROM
      "atomic"."com_torrelabs_similar_opportunity_clicked_1"
WHERE
      (
            "atomic"."com_torrelabs_similar_opportunity_clicked_1"."element_type" = 'job-preview-card'
            AND "atomic"."com_torrelabs_similar_opportunity_clicked_1"."root_tstamp" >= '2022-01-01'
            AND "atomic"."com_torrelabs_similar_opportunity_clicked_1"."root_tstamp" < CAST(getdate() AS date)
      )