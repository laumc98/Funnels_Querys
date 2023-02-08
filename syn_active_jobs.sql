/* AA : Channel's performance : syn active jobs : prod */ 
SELECT
    date(opportunity_channels.created) as daily_date,
    opportunity_channels.opportunity_reference_id as 'AlfaID'
FROM 
    opportunity_channels
    INNER JOIN opportunity ON opportunity_channels.opportunity_reference_id = opportunity.ref_id
WHERE 
    opportunity_channels.channel = 'EXTERNAL_NETWORKS'
    AND opportunity.max_proficiency <> 'EXPERT'
    AND opportunity.max_proficiency <> 'MASTER'
GROUP BY
    date(opportunity_channels.created),
    opportunity_channels.opportunity_reference_id