/* AA : Channel's performance : app info : prod */ 
SELECT
    opportunity_candidates.interested AS 'application date',
    opportunity_candidates.opportunity_id AS 'ID',
    opportunities.fulfillment AS 'fulfillment',
    people.gg_id AS 'gg_id'
FROM 
    opportunity_candidates
    LEFT JOIN people ON opportunity_candidates.person_id = people.id
    LEFT JOIN opportunities ON opportunity_candidates.opportunity_id = opportunities.id
WHERE 
    opportunity_candidates.interested IS NOT NULL 
    AND opportunity_candidates.interested > '2022-10-25'