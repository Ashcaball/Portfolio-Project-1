/* First I'll select the data I'll be using the most */

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM `robust-team-356223.Covid_Research.CovidDeaths`
order by 1,2;

/* Total Cases vs. Total Deaths */
