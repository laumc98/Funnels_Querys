/* AA : Channel's performance : src connections brought : prod */ 
SELECT 
    master_chief_events.*
FROM 
    master_chief_events
WHERE 
    master_chief_events.event = 'sourcing_connection_status_updated'