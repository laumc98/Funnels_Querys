/* AA : Channel's performance : syn active jobs : prod */ 
SELECT
    str_to_date(concat(yearweek(opportunity_channels.created), ' Sunday'),'%X%V %W') as date,
    opportunity_channels.opportunity_reference_id as 'AlfaID'
FROM 
    opportunity_channels
WHERE 
    opportunity_channels.channel = 'EXTERNAL_NETWORKS'
GROUP BY
    date(opportunity_channels.created),
    opportunity_channels.opportunity_reference_id