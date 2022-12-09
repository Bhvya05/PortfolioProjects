 Select * 
 From PortfolioProject.dbo.CovidDeaths$
 where continent is Not null
 order by 3,4

  Select * 
 From PortfolioProject.dbo.CovidVaccinations$
 order by 3,4

 -- Select data that we are going to use

 Select location, date, total_cases, new_cases, total_deaths, population
 From PortfolioProject.dbo.CovidDeaths$
 order by 1,2;

 -- Looking at total cases and total deaths

  Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 From PortfolioProject.dbo.CovidDeaths$
 order by 1,2;

 SELECT MONTH(date) AS Monthly,
 date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 From PortfolioProject..CovidDeaths$
 order by DeathPercentage desc

 
  Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 From PortfolioProject.dbo.CovidDeaths$
 where location like 'India'
 order by 1,2;

 -- Looking  at Total Cases vs Population (shows what percentage of population got covid)
 
  Select location, date, population,total_cases, (total_cases/population)*100 as PercentPopuationInfected
 From PortfolioProject.dbo.CovidDeaths$
 where location like 'India'
 order by 1,2;

 -- Looking at countries with highest infection rate compared to population

 Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
 From PortfolioProject.dbo.CovidDeaths$
   Group By location, population
 order by PercentPopulationInfected desc


 -- Showing the countries witht the highest death count per population
  Select Location, Population, Max(total_deaths) as totalDeathCount
 From PortfolioProject.dbo.CovidDeaths$
   Group By location, population
 order by totalDeathCount desc

   Select Location, Population, Max(cast(total_deaths as int)) as totalDeathCount
 From PortfolioProject.dbo.CovidDeaths$
 where continent is not null
   Group By location, population
 order by totalDeathCount desc

 -- lets break things down my continent
 
Select Location, Max(cast(total_deaths as int)) as totalDeathCount
From PortfolioProject.dbo.CovidDeaths$
where continent is not null
Group By location
 order by totalDeathCount desc

 Select Location, Max(cast(total_deaths as int)) as totalDeathCount
From PortfolioProject.dbo.CovidDeaths$
where continent is null
Group By location
 order by totalDeathCount desc

Select continent, Max(cast(total_deaths as int)) as totalDeathCount
From PortfolioProject..CovidDeaths$
where continent is not null
Group By continent
order by totalDeathCount desc


-- breaking global numbers

  Select date, SUM(new_cases) as total_cases,  SUM(cast(new_deaths as int)) as total_deaths, 
  SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
 From PortfolioProject.dbo.CovidDeaths$
 where continent is not null
   Group By date
 order by 1,2

  Select SUM(new_cases) as total_cases,  SUM(cast(new_deaths as int)) as total_deaths, 
  SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
 From PortfolioProject.dbo.CovidDeaths$
 where continent is not null
  -- Group By date
 order by 1,2



 -- covid_vaccinations

 Select *
 From PortfolioProject..CovidVaccinations$

 -- join

  Select *
  From PortfolioProject..CovidDeaths$ dea
 Join PortfolioProject..CovidVaccinations$ vac
 on dea.location = vac.location
 and dea.date = vac.date


 -- looking at total population vs vaccination

 
  Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  From PortfolioProject..CovidDeaths$ dea
 Join PortfolioProject..CovidVaccinations$ vac
 on dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 2,3


 