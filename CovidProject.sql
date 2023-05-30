--Data to be used
select Location, date, total_cases, new_cases, total_deaths, population
from Portfolio.dbo.CovidDeaths

-- Total Cases vs Total Deaths
-- shows likelihood of dying if you contract Covid
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from Portfolio.dbo.CovidDeaths
where location like '%states%'
order by 1,2

-- Total Cases vs Population
-- shows what percentage of population got Covid
select Location, date, total_cases, Population, (total_cases/Population)*100 as CasesperPopulation
from Portfolio.dbo.CovidDeaths
where location like '%states%'
order by 1,2

-- Countries with highest infection rate per population
select Location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected
from Portfolio.dbo.CovidDeaths
group by Location, Population
order by PercentPopulationInfected desc

-- countries with highest death rate per population
select Location, max(cast(total_deaths as int)) as HighestDeathCount
from Portfolio.dbo.CovidDeaths
where continent is not null
group by Location
order by HighestDeathCount desc

-- continents with highest death count per population
select location, max(cast(total_deaths as int)) as HighestDeathCount
from Portfolio.dbo.CovidDeaths
where continent is null
group by location
order by HighestDeathCount desc

-- global numbers
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from Portfolio.dbo.CovidDeaths
where continent is not null
group by date
order by 1,2

-- total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingVaccinations
from Portfolio.dbo.CovidDeaths dea
join Portfolio.dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

--use cte
with PopvsVac (Continent, location, date, population, new_vaccinations, RollingVaccinations)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingVaccinations
from Portfolio.dbo.CovidDeaths dea
join Portfolio.dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingVaccinations/population)*100 as RollingVacPer
from PopvsVac

-- create view to store data

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingVaccinations
from Portfolio.dbo.CovidDeaths dea
join Portfolio.dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null