/* AA : Channel's performance :daily not interested users from sourcing: prod */ 
SELECT
    str_to_date(concat(yearweek(users.date), ' Sunday'),'%X%V %W') AS date,
    date(users.date) AS daily_date,
    users.not_interested AS not_interested
FROM(
    SELECT
        date(career_advisor.created) AS "date",
        count(distinct career_advisor.person_id) AS "not_interested"
    FROM
        career_advisor
    WHERE
        career_advisor.current = 'career-advisor-sourcing-not-interested-1'
        AND career_advisor.created >= '2022-06-28'
    GROUP BY
        date(career_advisor.created)
) users