Select *
From [Portfolio project]..CovidDeaths
where continent is not null
order by 3,4

Select * 
From [Portfolio project]..CovidVaccinations
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From [Portfolio project]..CovidDeaths
order by 1,2

-- Total cases vs total deaths
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
order by 1,2





-- Looking at total cases vs Population
-- This will show the percentage of population that got covid in Spain
Select Location, date, total_cases, population, (total_cases/population)*100 as InfectedPopulationPercentage
From [Portfolio project]..CovidDeaths
Where location like '%Spain%' 
order by 1,2





--  Countries with highest infection rate per capita
Select Location, MAX(total_cases) as highestinfectioncount, population, MAX((total_cases/population))*100 as infectedPopulationPercentage
From [Portfolio project]..CovidDeaths 
Group by location, population
order by infectedPopulationPercentage desc 





-- Showing countries with highest Death count per population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio project]..CovidDeaths 
where continent is not null
Group by location
order by TotalDeathCount desc




-- Showing continents with highest Death count per population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio project]..CovidDeaths 
where continent is null
Group by location
order by TotalDeathCount desc







-- Total cases, total deaths and deathpercentage all over the world since the start until 30/04/21
SELECT date,
       SUM(total_cases) as total_cases,
       SUM(cast(total_deaths as int)) as total_deaths,
       (SUM(cast(total_deaths as int))/SUM(total_cases))*100 as DeathPercentage
FROM [Portfolio project]..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1;





-- Total cases, total deaths and deathpercentage all over the world 
SELECT SUM(new_cases) as total_cases, 
       SUM(cast(new_deaths as int)) as total_deaths, 
       (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as deathpercentage
FROM [Portfolio project]..CovidDeaths 
WHERE continent IS NOT NULL
ORDER BY 1,2






-- Most vaccinated territories in each continent
WITH RankedVaccinationPercentage AS (
    SELECT
        vac.location,
        TRY_CAST(vac.people_vaccinated AS numeric) AS people_vaccinated,
        dea.population,
        vac.continent,
        (TRY_CAST(vac.people_vaccinated AS numeric) * 100.0 / dea.population) AS VaccinationPercentage,
        RANK() OVER (PARTITION BY vac.continent ORDER BY (TRY_CAST(vac.people_vaccinated AS numeric) * 100.0 / dea.population) DESC) AS VaccinationRank
    FROM
        [Portfolio project]..CovidVaccinations vac
    JOIN
        [Portfolio project]..CovidDeaths dea
    ON
        vac.location = dea.location
        AND vac.date = dea.date
    WHERE
        dea.continent IS NOT NULL
)
SELECT
    location,
    people_vaccinated,
    population,
    continent,
    VaccinationPercentage
FROM
    RankedVaccinationPercentage
WHERE
    VaccinationRank = 1;

	



-- Global Population, total vaccinated population and vaccinated percentage
WITH TempTable AS (
    SELECT
        dea.location,
        dea.population,
        MAX(CONVERT(float, vac.people_vaccinated)) AS PeopleVaccinated,
        (MAX(CONVERT(float, vac.people_vaccinated)) / dea.population) * 100 AS VaccinationPercentage
    FROM
        [Portfolio project]..CovidDeaths dea
    JOIN
        [Portfolio project]..CovidVaccinations vac
    ON
        dea.location = vac.location
        AND dea.date = vac.date
    WHERE
        dea.continent IS NOT NULL
    GROUP BY
        dea.location,
        dea.population
)

-- Calcular la suma de los valores y eliminar la variable location
SELECT
    SUM(Population) AS TotalPopulation,
    SUM(PeopleVaccinated) AS TotalPeopleVaccinated,
    SUM(PeopleVaccinated) / SUM(Population) * 100 AS TotalVaccinationPercentage
FROM
    TempTable;









-- percentage of people vaccinated in each country
	SELECT
    dea.location,
    dea.population,
    MAX(CONVERT(float, vac.people_vaccinated)) AS PeopleVaccinated,
    (MAX(CONVERT(float, vac.people_vaccinated)) / dea.population) * 100 AS VaccinationPercentage
FROM
    [Portfolio project]..CovidDeaths dea
JOIN
    [Portfolio project]..CovidVaccinations vac
ON
    dea.location = vac.location
    AND dea.date = vac.date
WHERE
    dea.continent IS not NULL
GROUP BY 
    dea.location,
    dea.population
ORDER BY
    dea.location;








-- Total population vs vaccinated population
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.people_vaccinated,
    (CONVERT(float,vac.people_vaccinated) / dea.population) * 100 AS VaccinationPercentage
FROM
    [Portfolio project]..CovidDeaths dea
JOIN
    [Portfolio project]..CovidVaccinations vac
ON
    dea.location = vac.location
    AND dea.date = vac.date
WHERE
    dea.continent IS NOT NULL
GROUP BY
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.people_vaccinated
ORDER BY
    dea.location,
    dea.date;








-- Total population vs vaccinated population in Spain

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(int, vac.new_vaccinations)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) as VaccinatedPopulationAsOf,
       (SUM(CONVERT(int, vac.new_vaccinations)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date)/population)*100 as VaccinationPercentage
FROM [Portfolio project]..CovidDeaths dea
JOIN [Portfolio project]..CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
AND dea.location like '%Spain%'
ORDER BY 2, 3;

 


