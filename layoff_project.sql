
-- DATA CLEANING

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Handle Null or blank values
-- 4. Remove any unnecessary columns

-- Preview raw data
select * from layoffs;

-- Create staging table
CREATE TABLE layoffs_staging LIKE layoffs;

-- Check staging table structure
select * from layoffs_staging;

-- Copy data into staging table
insert layoffs_staging
select * from layoffs;

select * from layoffs_staging;

-- Add row number to identify duplicates
select *,
row_number() over 
(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoffs_staging;

-- Removing Duplicates

with duplicates_cte as
(
select *,
row_number() over 
(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoffs_staging
)
-- Preview duplicates
select * from duplicates_cte 
where row_num > 1;

-- Create a new staging table with row_num column
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Check new table
select * from layoffs_staging2;

-- Insert data with row numbers for duplicate removal
insert into layoffs_staging2
select *,
row_number() over 
(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoffs_staging;

select * from layoffs_staging2;

-- Disable safe updates to allow DELETE
SET SQL_SAFE_UPDATES = 0;

-- Delete duplicates
DELETE FROM layoffs_staging2 
WHERE
    row_num > 1;

-- Verify deletion of duplicates
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    row_num > 1;

-- Standardizing Data

-- Trim company names
SELECT 
    company, TRIM(company)
FROM
    layoffs_staging2;
    
UPDATE layoffs_staging2 
SET 
    company = TRIM(company);

-- Standardize industry names (example: Crypto)
SELECT DISTINCT
    industry
FROM
    layoffs_staging2
ORDER BY 1;
    
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    industry LIKE 'Crypto%';
    
UPDATE layoffs_staging2 
SET 
    industry = 'Crypto'
WHERE
    industry LIKE 'Crypto%';

SELECT DISTINCT
    industry
FROM
    layoffs_staging2;

-- Standardize country names
SELECT DISTINCT
    country
FROM
    layoffs_staging2
ORDER BY 1;

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    country LIKE 'United States%';

SELECT DISTINCT
    country, TRIM(TRAILING '.' FROM country)
FROM
    layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2 
SET 
    country = TRIM(TRAILING '.' FROM country)
WHERE
    country LIKE 'United States%';

SELECT DISTINCT
    country
FROM
    layoffs_staging2
ORDER BY 1;

-- Convert date column to DATE type
SELECT 
    `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM
    layoffs_staging2;

UPDATE layoffs_staging2 
SET 
    `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT 
    `date`
FROM
    layoffs_staging2;

alter table layoffs_staging2
modify column `date` DATE;

SELECT 
    *
FROM
    layoffs_staging2;

-- Handling Null Values

SELECT 
    *
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;

-- Replace empty industry values with NULL
UPDATE layoffs_staging2 
SET 
    industry = NULL
WHERE
    industry = '';
    
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    industry IS NULL;

-- Fill missing industry based on company
SELECT 
    t1.industry, t2.industry
FROM
    layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company
        AND t1.location = t2.location
WHERE
    t1.industry IS NULL
        AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
        JOIN
    layoffs_staging2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    t1.industry IS NULL
        AND t2.industry IS NOT NULL;

select * from layoffs_staging2;

-- Delete rows with missing layoffs numbers
DELETE
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;

select * from layoffs_staging2;

-- Drop temporary row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

select * from layoffs_staging2;

-- EXPLORATORY DATA ANALYSIS (EDA)

select * from layoffs_staging2;

-- Max layoffs and percentage laid off
SELECT 
    MAX(total_laid_off), MAX(percentage_laid_off)
FROM
    layoffs_staging2;
    
-- Companies with 100% layoffs, ordered by layoffs
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Companies with 100% layoffs, ordered by funding
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Total layoffs by company
SELECT 
    company, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company
ORDER BY 2 desc;

-- Date range of layoffs
select min(`date`), max(`date`)
from layoffs_staging2;

-- Total layoffs by industry
SELECT 
    industry, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY industry
ORDER BY 2 desc;

-- Total layoffs by country
SELECT 
    country, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY country
ORDER BY 2 desc;

-- Total layoffs by year
SELECT 
    year(`date`), SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY year(`date`)
ORDER BY 2 desc;

-- Total layoffs by stage
SELECT 
    stage, SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY stage
ORDER BY 2 desc;

-- Monthly layoffs
SELECT 
    SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM
    layoffs_staging2
WHERE
    SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Rolling total layoffs
WITH Rolling_Total as
(
SELECT 
    SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS totaloff
FROM
    layoffs_staging2
WHERE
    SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, totaloff, SUM(totaloff) over(order by `MONTH`) AS rolling_total
FROM Rolling_Total;

-- Yearly layoffs by company
SELECT 
    company, YEAR(`date`), SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Top 5 layoffs per year
WITH company_year(company, years, total_laid_off) as 
(
SELECT 
    company, YEAR(`date`), SUM(total_laid_off)
FROM
    layoffs_staging2
GROUP BY company, YEAR(`date`)
),
Company_year_rank as
(
SELECT *, dense_rank() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year 
WHERE years IS NOT NULL
)
SELECT * 
FROM Company_year_rank 
WHERE ranking <= 5;
