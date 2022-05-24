SELECT
    c.year AS year,
    c.week AS week,
    str_to_date(concat(yearweek(dt.created),' Sunday'),'%X%V %W') AS date,
    dt.created AS daily_date,
    dt.daily_native AS daily_native,
    wk.daily_native AS weekly
FROM
    (
        SELECT
            year(v.created) AS year,
            week(v.created, 0) AS week,
            date(v.created) AS created,
            sum(IF(pf.opportunity_crawler, 1, 0)) AS daily_crawled,
            sum(IF(NOT pf.opportunity_crawler, 1, 0)) AS daily_native
        FROM
            views AS v
            INNER JOIN opportunities o ON o.id = v.target_id
            INNER JOIN opportunity_members om ON o.id = om.opportunity_id
            AND om.poster = TRUE
            INNER JOIN person_flags pf ON om.person_id = pf.person_id
        WHERE
            v.created >= '2021-06-03'
            AND o.remote = TRUE
        GROUP BY
            1,
            2,
            3
    ) AS dt
    INNER JOIN (
        SELECT
            year(v.created) AS year,
            week(v.created, 0) AS week,
            sum(IF(pf.opportunity_crawler, 1, 0)) AS daily_crawled,
            sum(IF(NOT pf.opportunity_crawler, 1, 0)) AS daily_native
        FROM
            views AS v
            INNER JOIN opportunities o ON o.id = v.target_id
            INNER JOIN opportunity_members om ON o.id = om.opportunity_id
            AND om.poster = TRUE
            INNER JOIN person_flags pf ON om.person_id = pf.person_id
        WHERE
            v.created >= '2021-06-03'
            AND o.remote = TRUE
        GROUP BY
            1,
            2
    ) wk ON dt.year = wk.year
    AND dt.week = wk.week
    RIGHT JOIN calendar c ON dt.created = c.date
WHERE
    c.date BETWEEN '2021-01-01'
    AND curdate()