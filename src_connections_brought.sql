/* AA : Channel's performance : src connections brought : prod */ 
SELECT 
    master_chief_events.*,
    sourcing_connections.linkedin_username
FROM 
    master_chief_events
    LEFT JOIN sourcing_connections ON master_chief_events.target_user_gg_id = sourcing_connections.candidate_gg_id
WHERE 
    master_chief_events.event = 'sourcing_connection_status_updated'