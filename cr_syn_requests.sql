/* AA : channel performance : syn requests by candidate recruiters: prod */ 
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
            notifications.template = 'career-advisor-syndication-first-evaluation'
            OR notifications.template = 'career-advisor-syndication-already-exist'
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
            'rmr',
            'dgv',
            'MER',
            'ACMP',
            'dgc',
            'fcr',
            'mes',
            'mcmn',
            'mfo',
            'smfp',
            'gebj',
            'aamf',
            'eb',
            'kglm'
    )
    )
GROUP BY
    date,
    AlfaID,
    cr_campaign