/* AA : Channel's performance : opp fulfillment : prod */ 
SELECT
    o.id,
    o.fulfillment,
    opportunity_organizations.organization_id AS 'Company_id'
FROM
    opportunities o
    LEFT JOIN opportunity_organizations ON opportunity_organizations.opportunity_id = o.id AND opportunity_organizations.active = 1
WHERE 
    o.created >= '2021-01-01'
    AND o.crawled = FALSE