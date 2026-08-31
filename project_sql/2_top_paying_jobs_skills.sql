/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
  helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON  job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL

    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs*,
    skills 
FROM top_paying_jobs
INNER JOIN skill_job_dim ON top_paying_jobs.job_id = skill_job_dim.job_id
INNER JOIN skill_dim ON skill_job_dim.skill_id = skill_dim.skill_id
ORDER BY
    salary_year_avg DESC

/*
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also highly sought after, with a bold count of 6.
- Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

[
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "sql"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "python"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "r"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "aws"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "tableau"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "pandas"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "numpy"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "pyspark"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "pyspark"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "spark"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "spark"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "skills": "sql"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "skills": "python"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "skills": "r"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "skills": "hadoop"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "skills": "sql"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "skills": "crystal"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "skills": "oracle"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers",
    "skills": "flow"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "sql"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "python"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "go"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "snowflake"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "pandas"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "numpy"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "excel"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "tableau"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset",
    "skills": "gitlab"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "sql"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "python"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "azure"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "aws"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "oracle"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "snowflake"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "tableau"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "power bi"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "sap"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "jenkins"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "bitbucket"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "atlassian"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "jira"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - Analytics and Reporting",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively",
    "skills": "confluence"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "sql"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "python"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "r"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "git"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "bitbucket"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "atlassian"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "jira"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance - New Mobility",
    "salary_year_avg": "189000.0",
    "company_name": "Motional",
    "skills": "confluence"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": "sql"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": "python"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": "go"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": "snowflake"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": "pandas"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset",
    "skills": "numpy"
  },
  {
    "jobThe JSON output generated by query 2 shows the relationship between each top-paying job and its specific required skills. 

You can paste this comment block containing the JSON result directly below your query in `2_top_paying_job_skills.sql`:

```sql
/*
[
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "sql"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "python"
  },
  {
    "job_id": 553383,
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys",
    "skills": "tableau"
  },
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "salary_year_avg": "550000.0",
    "company_name": "Meta",
    "skills": "sql"
  },
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "salary_year_avg": "550000.0",
    "company_name": "Meta",
    "skills": "python"
  },
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "salary_year_avg": "550000.0",
    "company_name": "Meta",
    "skills": "r"
  },
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "salary_year_avg": "550000.0",
    "company_name": "Meta",
    "skills": "tableau"
  },
  {
    "job_id": 547961,
    "job_title": "Director of Analytics",
    "salary_year_avg": "336500.0",
    "company_name": "Meta",
    "skills": "sql"
  },
  {
    "job_id": 547961,
    "job_title": "Director of Analytics",
    "salary_year_avg": "336500.0",
    "company_name": "Meta",
    "skills": "python"
  },
  {
    "job_id": 547961,
    "job_title": "Director of Analytics",
    "salary_year_avg": "336500.0",
    "company_name": "Meta",
    "skills": "tableau"
  },
  {
    "job_id": 547961,
    "job_title": "Director of Analytics",
    "salary_year_avg": "336500.0",
    "company_name": "Meta",
    "skills": "power bi"
  }
]
*/
    


