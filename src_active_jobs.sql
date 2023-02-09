/* AA : Channel's performance : src active jobs : prod */ 
SELECT
    str_to_date(concat(yearweek(opportunity_channels.created), ' Sunday'),'%X%V %W') as date,
    opportunity_channels.opportunity_reference_id as 'AlfaID'
FROM 
    opportunity_channels
    INNER JOIN opportunity ON opportunity_channels.opportunity_reference_id = opportunity.ref_id
WHERE 
    opportunity_channels.channel = 'EXTERNAL_SOURCING'
GROUP BY
    str_to_date(concat(yearweek(opportunity_channels.created), ' Sunday'),'%X%V %W'),
    opportunity_channels.opportunity_reference_id