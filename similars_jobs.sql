/* AA : Channel's performance : similar jobs notifications : prod */ 
SELECT
      (CAST(date_trunc('week',CAST(("atomic"."com_torrelabs_similar_opportunity_clicked_1"."root_tstamp" + (INTERVAL '1 day')) AS timestamp)) AS timestamp) + (INTERVAL '-1 day')) AS "date",
      "atomic"."com_torrelabs_similar_opportunity_clicked_1"."clicked_opportunity_id" AS "clicked_opportunity_id",
      "atomic"."com_torrelabs_similar_opportunity_clicked_1"."opportunity_id" AS "AlfaID"
FROM
      "atomic"."com_torrelabs_similar_opportunity_clicked_1"
WHERE
      (
            "atomic"."com_torrelabs_similar_opportunity_clicked_1"."element_type" = 'job-preview-card'
            AND "atomic"."com_torrelabs_similar_opportunity_clicked_1"."root_tstamp" >= CAST(dateadd('day', -272, CAST(getdate() AS timestamp)) AS date)
            AND "atomic"."com_torrelabs_similar_opportunity_clicked_1"."root_tstamp" < CAST(getdate() AS date)
      )