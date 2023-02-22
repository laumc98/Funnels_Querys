/* AA : Channel's performance : CCGs from sourcing & syndication : prod */ 
SELECT
    str_to_date(concat(yearweek(people.created), ' Sunday'),'%X%V %W') AS 'date_created',
    notifications.template,
    TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) as AlfaID,
    count(*) AS total_invited
FROM
    people
    INNER JOIN notifications ON people.id = notifications.to
WHERE
    (
        people.subject_identifier IS NULL
            OR people.subject_identifier != people.gg_id
    )
    AND 
    (
        notifications.template = 'career-advisor-sourcing-first-evaluation'
            OR notifications.template = 'career-advisor-sourcing-first-evaluation-matrix-a'
            OR notifications.template = 'career-advisor-sourcing-first-evaluation-matrix-b'
            OR notifications.template = 'career-advisor-sourcing-first-evaluation-matrix-c'
            OR notifications.template = 'career-advisor-syndication-first-evaluation'
    )
    AND date(people.created) > date(date_add(now(6), INTERVAL -1 year))
    AND TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) != ''
GROUP BY
    date_created,
    template,
    AlfaID