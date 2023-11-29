/* AA : Funnels performance : Beautification requests: prod */ 
SELECT 
    tasks.id,
    tasks.created,
    tasks.deadline, 
    tasks.completed,
    tasks.in_progress_at,
    tasks.trigger,
    tasks.assigned_to,
    tasks.completed_by,
    tasks.active_minutes_spent,
    TIMESTAMPDIFF(minute, tasks.in_progress_at, tasks.completed) AS time_to_complete,
    tasks.user_gg_id,
    tasks.completion_comment
FROM 
    tasks
WHERE 
    tasks.trigger IN ('li-import-request','li-import-request-crawling-errors')
    AND tasks.id NOT IN (
        SELECT 
            tasks.parent_task_id
        FROM 
            tasks  
        WHERE 
            tasks.trigger = 'inspection-task-completed-without-execution'
    )
    AND tasks.id NOT IN (
        SELECT 
            tasks.id
        FROM 
            tasks  
        WHERE 
            LOWER(tasks.completion_comment) LIKE '%completed with manual update.%'
    )
    AND tasks.id NOT IN (
        SELECT 
            tasks.id
        FROM 
            tasks  
        WHERE 
            LOWER(tasks.completion_comment) LIKE '%autocompleted with reason:%'
    )