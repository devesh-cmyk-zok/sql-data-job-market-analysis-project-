# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining the path to finding optimal jobs.

Data hails from the course dataset, packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:
* **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
* **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
* **Visual Studio Code:** My go-to for database management and executing SQL queries.
* **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high-paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Insights:

-Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating immense earning potential at senior/specialized tiers.

-Diverse Employers: Companies like Mantys, Meta, and SmartAsset lead the pack in offering top salaries.

### 2. Skills for Top Paying Jobs.
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

```
Insights:
-SQL is leading with a bold count of 8.
-Python follows closely with a count of 7.
-Tableau is highly sought after with a count of 6.
-Other tools like R, Snowflake, Pandas, and Excel show consistent presence across top listings.

### 3. In-Demand Skills for Data Analysts
This query joined the job postings to the skills table to identify the top 5 most frequently demanded skills across all remote data analyst positions.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
### Top Demanded Skills

| Skills        | Demand Count |
| :---          | :---         |
| **SQL**       | 7,291        |
| **Excel**     | 4,611        |
| **Python**    | 4,330        |
| **Tableau**   | 3,745        |
| **Power BI**  | 2,609        |
Insights:
-Core Foundation: SQL and Excel dominate as baseline requirements for almost every analyst role.
-Programming & BI: Python alongside BI visualization platforms (Tableau, Power BI) form the standard modern analytical stack.

### 4. Skills Based on Salary
Exploring average salaries associated with each skill highlights which technical competencies yield the highest financial returns.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Insights:
-Big Data & Cloud Systems: High average salaries are commanded by niche tools like PySpark, Couchbase, Databricks, and Kafka.
-DevOps / Engineering Crossover: Version control and orchestration tools (GitLab, Airflow, Kubernetes) reflect a lucrative hybrid between analytics and data engineering.

### 5. Most Optimal Skills to Learn
Combining demand count and average salary reveals the highest-ROI skills—tools that are both high-demand and high-paying.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
), 
average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
### Top Optimal Skills (High Demand & High Salary)

| Skill ID | Skill      | Demand Count | Average Salary ($) |
| :---     | :---       | :---         | :---               |
| **8**    | Go         | 27           | $115,320           |
| **234**  | Confluence | 11           | $114,210           |
| **97**   | Hadoop     | 22           | $113,193           |
| **80**   | Snowflake  | 37           | $112,948           |
| **74**   | Azure      | 34           | $111,225           |
| **77**   | BigQuery   | 13           | $109,654           |
| **76**   | AWS        | 32           | $108,317           |
| **1**    | Python     | 236          | $101,397           |
| **182**  | Tableau    | 230          | $99,288            |

## 🧠 What I Learned
Throughout this project, I strengthened my technical SQL toolkit:
🧩 Complex Query Crafting: Mastered multi-table joins, subqueries, and CTEs (WITH clauses) for structured data flow.

📊 Data Aggregation: Leveraged GROUP BY, HAVING, and aggregate functions (COUNT(), AVG(), ROUND()) to synthesize large datasets.

💡 Analytical Problem Solving: Translated ambiguous business questions into actionable, optimized SQL queries.

## 📌 Conclusions
-SQL is King: Unquestionably the most demanded skill across the data analytics job market.

-Cloud & Warehousing Pay Off: Familiarity with Snowflake, BigQuery, AWS, and Azure provides a strong salary premium.

-Hybrid Skills Win: Analysts who blend traditional querying with programming (Python/R) and cloud tooling stand in the most optimal compensation bracket.