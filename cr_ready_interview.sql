/* AA : channel performance : ready for interview by candidate recruiters: prod */ 
WITH 
groupped_services AS (
    SELECT
        opportunity_id,
        GROUP_CONCAT(service_code) AS services
    FROM
        opportunity_services
    WHERE
        deleted IS NULL
    GROUP BY
        opportunity_id
),
opps_services AS (
    SELECT
        o.id AS opportunity_id,
        CASE
            WHEN crawled THEN 'crawled'
            WHEN (
                (
                    FIND_IN_SET('1', gs.services)>0 /* agile */
                    OR FIND_IN_SET('7', gs.services)>0 /* staff augmentation */
                    OR FIND_IN_SET('20', gs.services)>0 /* hunt */
                )
            ) THEN 'rpo'
            WHEN (
                (
                    FIND_IN_SET('8', gs.services)>0 /* ats */
                    OR FIND_IN_SET('9', gs.services)>0 /* pro */
                    OR FIND_IN_SET('16', gs.services)>0 /* torre_os */
                ) AND o.created>='2023-12-01'
            ) THEN 'torre_os'
            WHEN (
                (
                    FIND_IN_SET('2', gs.services)>0 /* essentials */
                    OR FIND_IN_SET('6', gs.services)>0 /* self service */
                    OR services = ''
                    OR services IS NULL
                )  AND o.created>='2023-12-01'
            ) THEN 'torre_free'
            ELSE 'others'
        END AS business_line,
        (
            (
                FIND_IN_SET('11', gs.services)>0 /* boost */
                OR FIND_IN_SET('12', gs.services)>0 /* boost hqa */
                OR FIND_IN_SET('17', gs.services)>0 /* torre_reach_essential */
                OR FIND_IN_SET('18', gs.services)>0 /* torre_reach_syndication */
                OR FIND_IN_SET('19', gs.services)>0 /* torre_reach_sourcing */
            ) AND o.created>='2023-12-01'
        ) AS reach,
        services
    FROM
        opportunities o
    LEFT JOIN groupped_services gs ON
        gs.opportunity_id = o.id
),
cr_ready_interview AS (
    SELECT
        date(ready_for_interview.created) AS 'date',
        ready_for_interview.id AS 'ID',
        ready_for_interview.business_line,
        ready_for_interview.reach,
        ready_for_interview.utm_medium AS 'utm_medium',
        ready_for_interview.utm_campaign AS 'cr_campaign',
        count(*) AS 'ready_for_interview'
    FROM
    (
        SELECT
            occh.candidate_id,
            min(occh.created) AS 'created',
            o.id,
            ifnull(os.business_line,'torre_free') AS business_line,
            ifnull(os.reach,0) AS reach,
            tc.utm_medium,
            tc.utm_campaign
        FROM
            opportunity_candidate_column_history occh
            INNER JOIN opportunity_columns oc ON occh.to = oc.id
            INNER JOIN opportunities o ON oc.opportunity_id = o.id
            LEFT JOIN opps_services os ON oc.opportunity_id = os.opportunity_id
            LEFT JOIN opportunity_candidates oca ON occh.candidate_id = oca.id
            LEFT JOIN tracking_code_candidates tcc ON oca.id = tcc.candidate_id
            LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
        WHERE
            oc.funnel_tag = 'ready_for_interview'
            AND occh.created >= "2022-10-20"
            AND (tc.utm_campaign = 'amdm'
                OR tc.utm_campaign = 'mcog'
                OR tc.utm_campaign = 'dffa'
                OR tc.utm_campaign = 'czp'
                OR tc.utm_campaign = 'jdpb'
                OR tc.utm_campaign = 'dmc'
                OR tc.utm_campaign = 'nsr'
                OR tc.utm_campaign = 'mmor'
                OR tc.utm_campaign = 'JAMC'
                OR tc.utm_campaign = 'mgdd'
                OR tc.utm_campaign = 'mrh'
                OR tc.utm_campaign = 'srl'
                OR tc.utm_campaign = 'avs'
                OR tc.utm_campaign = 'sbr'
                OR tc.utm_campaign = 'tavp'
                OR tc.utm_campaign = 'rmr' 
                OR tc.utm_campaign = 'dgv'
                OR tc.utm_campaign = 'MER' 
                OR tc.utm_campaign = 'ACMP'
                OR tc.utm_campaign = 'dgc'
                OR tc.utm_campaign = 'fcr'
                OR tc.utm_campaign = 'mes'
                OR tc.utm_campaign = 'mcmn'
                OR tc.utm_campaign = 'mfo'
                OR tc.utm_campaign = 'smfp'
                OR tc.utm_campaign = 'gebj'
                OR tc.utm_campaign = 'aamf'
                OR tc.utm_campaign = 'eb'
                OR tc.utm_campaign = 'kglm'
                OR tc.utm_campaign = 'sm'
                OR tc.utm_campaign = 'brc'
                OR tc.utm_campaign = 'vaio'
                OR tc.utm_campaign = 'exrm'
                OR tc.utm_campaign = 'jsmn'
                OR tc.utm_campaign = 'lfas'
                OR tc.utm_campaign = 'malm'
                OR tc.utm_campaign = 'lbmp'
                OR tc.utm_campaign = 'capi'
                OR tc.utm_campaign = 'cals'
                OR tc.utm_campaign = 'bb'
                OR tc.utm_campaign = 'jcmv'
                OR tc.utm_campaign = 'egc'
                OR tc.utm_campaign = 'mdr'
                OR tc.utm_campaign = 'grtt'
                OR tc.utm_campaign = 'avpc'
            )
            AND tc.utm_medium IN ('src','rc_src','rc_src_trrx_inv','syn','rc_syn','rc_syn_trrx_inv','syn_paid','rc_syn_paid','rc_syn_paid_trrx_inv','syn_rqt','rc_syn_rqt')
            AND o.id NOT IN (
                SELECT DISTINCT opportunity_id
                FROM opportunity_organizations
                WHERE organization_id IN (748404,1510092)
                    AND active
            )
        GROUP BY
            occh.candidate_id
    ) AS ready_for_interview
    GROUP BY 
        date(ready_for_interview.created),
        ready_for_interview.id,
        ready_for_interview.business_line,
        ready_for_interview.reach,
        ready_for_interview.utm_medium,
        ready_for_interview.utm_campaign
    ORDER BY 
        date(ready_for_interview.created) ASC 
) SELECT * FROM cr_ready_interview;