/* First I'll select the data I'll be using the most in the TotalDeaths table */

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM `robust-team-356223.Covid_Research.CovidDeaths`
WHERE Continent is not null
order by 1,2;

/* Total Cases vs. Total Deaths */
/* Shows liklihood of dying if you contract covid in the US */
SELECT location, date, total_cases, total_deaths, population, (Total_deaths/total_cases)*100 AS DeathsPercentage
FROM `robust-team-356223.Covid_Research.CovidDeaths`
WHERE location LIKE 'United States'
ORDER BY 1,2

/* Looking at Total Cases vs Population */
/* Shows what percentage of population has Covid */
SELECT location, date, total_cases, population, (Total_cases/population)*100 AS ContractedCovidPercentage
FROM `robust-team-356223.Covid_Research.CovidDeaths`
WHERE location LIKE 'United States'
ORDER BY 1,2

/* Looking at countries with highest infection rate compared to population */
SELECT location, max(total_cases) AS HighestInfectionCount, population, max(Total_cases/population)*100 AS ContractedCovidPercentage
FROM `robust-team-356223.Covid_Research.CovidDeaths`
WHERE Continent is not null
Group By Location, population
ORDER BY ContractedCovidPercentage desc

/* Looking at Countires with highest death count per population*/
SELECT location, max(total_deaths) as TotalDeathCount
FROM `robust-team-356223.Covid_Research.CovidDeaths`
Where Continent is not null
Group By Location
ORDER BY TotalDeathCount desc

/* Lets break things down by continent */
SELECT continent, max(total_deaths) as TotalDeathCount
FROM `robust-team-356223.Covid_Research.CovidDeaths`
Where Continent is not null AND NOT location = 'World'
Group By continent
ORDER BY TotalDeathCount desc

/* Global Deaths Per Day */
SELECT date, sum(new_cases) AS Total_Cases, sum(new_deaths) as Total_Deaths, (sum(new_deaths))/(sum(new_cases))*100 AS Total_Deaths
FROM `robust-team-356223.Covid_Research.CovidDeaths`
WHERE Continent is not null
Group by date
ORDER BY 1,2

/* Global Deaths Overall */
SELECT sum(new_cases) AS Total_Global_Cases, sum(new_deaths) as Total_Global_Deaths, (sum(new_deaths))/(sum(new_cases))*100 AS Global_Deaths_Percent
FROM `robust-team-356223.Covid_Research.CovidDeaths`
WHERE Continent is not null
ORDER BY 1,2

#I will now start working with a second table called "CovidVaccinations"

/* Looking at Total Population vs Vaccination  Globally */
SELECT max(total_cases) AS Global_Cases, max(total_vaccinations) AS Global_Vaccination, (max(total_vaccinations)/max(total_cases)) AS VaccinationPercent
FROM `robust-team-356223.Covid_Research.CovidVaccinations` AS DEA
JOIN  `robust-team-356223.Covid_Research.CovidDeaths` AS VAC
  ON  dea.location = vac.location AND dea.date = vac.date
  
/* Now by country */  
SELECT dea.location, max(total_cases) AS Covid_Cases, max(total_vaccinations) AS Covid_Vaccination, (max(total_vaccinations)/max(total_cases)) AS VaccinationPercent
FROM `robust-team-356223.Covid_Research.CovidVaccinations` AS DEA
JOIN  `robust-team-356223.Covid_Research.CovidDeaths` AS VAC
  ON  dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
Group by location
Order by location asc
  
  
  

/* Looking at Total Population vs Vaccination 
SELECT dea.location, dea.date, vac.population, new_vaccinations, 
sum(new_vaccinations) over (Partition by dea.location order by dea.location, dea.date) AS RollingPeopleVaccinated
FROM `robust-team-356223.Covid_Research.CovidVaccinations` AS DEA
JOIN  `robust-team-356223.Covid_Research.CovidDeaths` AS VAC
  ON  dea.location = vac.location 
  AND dea.date = vac.date
WHERE dea.continent is not null
order by 1

SELECT dea.continent, dea.location, dea.date, vac.population, new_vaccinations
FROM `robust-team-356223.Covid_Research.CovidVaccinations` AS DEA
JOIN  `robust-team-356223.Covid_Research.CovidDeaths` AS VAC
  ON  dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent is not null
order by 2,3 */
