/* AA : channel performance : src requests by candidate recruiters: prod */ 
SELECT
    date(notifications.sent_at) AS date,
    TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.opportunityId')) AS AlfaID,
    TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.utmCampaign')) AS cr_campaign,
    count(distinct notifications.id) AS requests
FROM
    notifications
WHERE
    (
        (
            notifications.template = 'career-advisor-sourcing-first-evaluation'
            OR notifications.template = 'career-advisor-sourcing-first-evaluation-matrix-c'
            OR notifications.template = 'career-advisor-sourcing-first-evaluation-matrix-a'
            OR notifications.template = 'career-advisor-sourcing-first-evaluation-matrix-b'
            OR notifications.template = 'career-advisor-sourcing-already-exist'
        )
        AND date(notifications.sent_at) >= '2022-10-29'
        AND notifications.status = 'sent'
        AND TRIM('"' FROM JSON_EXTRACT(notifications.context, '$.utmCampaign')) IN (
            'amdm',
            'mcog',
            'dffa',
            'czp',
            'jdpb',
            'dmc',
            'nsr',
            'mmor',
            'JAMC',
            'mgdd',
            'mrh',
            'srl',
            'avs',
            'sbr',
            'tavp',
            'rmr' ,
            'dgv',
            'MER' ,
            'ACMP',
            'dgc',
            'fcr',
            'mes',
            'mcmn',
            'mfo',
            'smfp',
            'gebj',
            'aamf'
        )
    )
GROUP BY
    date,
    AlfaID,
    cr_campaign