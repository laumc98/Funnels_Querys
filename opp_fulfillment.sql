/* AA : Channel's performance : opp fulfillment : prod */ 
SELECT
    o.id,
    o.fulfillment
FROM
    opportunities o
WHERE 
    o.created >= '2021-01-01'
    AND o.crawled = FALSE