/* AA : Channel's performance : opp fulfillment : prod */ 
SELECT
    o.id,
    o.fulfillment
FROM
    opportunities o
WHERE 
    o.created >= date(date_add(now(6), INTERVAL -1 year))