Select * From [Portfolio Project]..['Covid Deaths$']
order by 3,4

--Select * From [Portfolio Project]..CovidVaccinations$
--order by 3,4

--Select Data that we are going to be using

Select Location, date, total_cases, New_cases, total_deaths, population From [Portfolio Project]..['Covid Deaths$']
order by 1,2

--Looking at Total Cases vs Total Deaths
--Shows likelyhood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (Total_deaths/Total_cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths$']
order by 1,2

--Look at the Total Cases vs Population
--Sow what percentage of population is got affected
Select Location, date, population, total_cases, (Total_cases/population)*100 as AffectPercentage
From [Portfolio Project]..['Covid Deaths$']
order by 1,2


--Looking at Contries with Higher Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((Total_cases/Population))*100 as AffectPercentage
From [Portfolio Project]..['Covid Deaths$']
Group by Location, Population
order by AffectPercentage desc

--Showing Countries with Highest Death count per population
Select Location, Population, max(total_deaths) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
where continent is not null 
Group by Location, Population
order by TotalDeathCount desc

--Break the above data using the Continents
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
where continent is not null 
Group by continent
order by TotalDeathCount desc

--Showing the continents with the highest death count per population
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
where continent is not null 
Group by continent
order by TotalDeathCount desc


--GLOBAL NUMBERS
Select date, SUM(new_cases) as NewCasesSum, SUM(cast(new_deaths as int)) as NewDeathsSum, (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths$']
where continent is not null
Group by date
order by 1,2

Select SUM(new_cases) as NewCasesSum, SUM(cast(new_deaths as int)) as NewDeathsSum, (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths$']
where continent is not null
--Group by date
order by 1,2


--Looking at total population vs vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [Portfolio Project]..['Covid Deaths$'] dea
join [Portfolio Project]..CovidVaccinations$ vac
 on dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 1,2,3

