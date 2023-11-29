/* AA : Channel's performance : sourcing connections : prod */ 
SELECT 
    tasks.*,
    opportunities.opportunity_id
FROM 
    tasks
    LEFT JOIN opportunities ON tasks.opportunity_id = opportunities.id
WHERE 
    (tasks.trigger = 'sourcing-connection-request'
        OR tasks.trigger = 'sourcing-connection-request-agile'
        OR tasks.trigger = 'sourcing-connection-request-boost'
        OR tasks.trigger = 'sourcing-connection-request-pro'
        OR tasks.trigger = 'sourcing-connection-request-ss')
    AND tasks.created >= '2023-11-20'
    AND tasks.id NOT IN (
        SELECT 
            tasks.id
        FROM 
            tasks  
        WHERE 
            LOWER(tasks.completion_comment) LIKE '%completed with manual update.%'
    )