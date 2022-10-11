/* AA : Channel's performance : opp proficiency : prod */ 
SELECT
    o.id,
    o.fulfillment
FROM
    opportunities o
WHERE 
    (o.created >= date(date_add(now(6), INTERVAL -1 day))
   AND o.created < date(now(6)))