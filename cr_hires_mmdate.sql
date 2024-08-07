/* AA : channel performance : hires by candidate recruiters by mm date: prod */ 
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
cr_hires_mmdate AS (
    SELECT
        date(occh.created) AS 'date',
        o.id AS ID,
        ifnull(os.business_line,'torre_free') AS business_line,
        ifnull(os.reach,0) AS reach,
        tc.utm_medium AS 'utm_medium',
        tc.utm_campaign AS 'cr_campaign',
        count(distinct ooh.opportunity_candidate_id) AS 'hires'
    FROM
        opportunity_operational_hires ooh
        LEFT JOIN opportunities o ON ooh.opportunity_id = o.id
        LEFT JOIN opps_services os ON ooh.opportunity_id = os.opportunity_id
        LEFT JOIN tracking_code_candidates tcc ON ooh.opportunity_candidate_id = tcc.candidate_id
        LEFT JOIN tracking_codes tc ON tcc.tracking_code_id = tc.id
        LEFT JOIN opportunity_candidate_column_history occh ON occh.candidate_id = ooh.opportunity_candidate_id
        LEFT JOIN opportunity_columns oc ON occh.to = oc.id
    WHERE
        ooh.hiring_date IS NOT NULL
        AND ooh.hiring_date >= "2022-10-20"
        AND oc.name = 'mutual matches'
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
        date(occh.created),
        o.id,
        os.business_line,
        os.reach,
        tc.utm_medium,
        tc.utm_campaign
) SELECT * FROM cr_hires_mmdate;