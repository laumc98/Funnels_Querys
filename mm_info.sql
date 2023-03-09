/* AA : Channel's performance : mm info : prod */ 
SELECT
    p.username AS Username,
    o.id AS Id,
    min(date(occh.created)) AS mm_date,
    o.fulfillment
FROM
    opportunity_candidate_column_history occh
    INNER JOIN opportunity_columns oc ON occh.to = oc.id
    INNER JOIN opportunities o ON oc.opportunity_id = o.id
    LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
    LEFT JOIN people p ON oca.person_id = p.id
WHERE
    oc.name = 'mutual matches'
    AND date(occh.created) >= '2022-10-21'
GROUP BY
    p.username,
    o.id