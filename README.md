# health-activity-analysis-2
End-to-end analysis of sleep, weight (BMI), and heart rate datasets using Excel and SQL.
# Health & Activity Data Analysis
An end-to-end analysis of **sleep, weight (BMI), and heart rate** datasets using **Excel dashboards** and **SQL queries**.  
This project demonstrates core data analyst skills including data cleaning, SQL querying, PivotTable analysis, and dashboard design.  

## Overview
Project: analysis of Sleep, Weight (BMI), and Heart Rate data using Excel and SQL.
Goal: demonstrate data cleaning, exploratory analysis, dashboards, and hypothesis testing.
The goal of this project is to explore how **daily sleep patterns, body weight, and resting heart rate** interact.  
By combining data preparation in SQL with analysis and visualization in Excel, I built a dashboard that highlights important health trends.  


## Tools
- Excel (PivotTables, Power Query, Charts, Slicers)
- SQL (DB Fiddle / MySQL)
- GitHub (project repository)

## Project Structure
- `data/` - cleaned and raw datasets
  - `Sleep_Weight_HR.xlsx` - cleaned/joined dataset used for dashboards
  - `Raw_Data.xlsx` (or original CSVs) - original files / raw imports
- `sql/`
  - `schema.sql` - SQL table definitions + sample inserts
  - `queries.sql` - analysis queries used in DB Fiddle
- `excel/`
  - `Health_Activity_Dashboard.xlsx` - final Excel workbook with PivotTables / charts
- `images/`
  - `dashboard.png` - screenshot of the dashboard

## How to reproduce
1. Open `sql/schema.sql` in DB Fiddle, run to create schema and insert sample data.
2. Run queries from `sql/queries.sql` to reproduce analysis tables.
3. Copy exported query results into `data/Sleep_Weight_HR.xlsx`.
4. Open `excel/Health_Activity_Dashboard.xlsx` to view dashboards (or rebuild using PivotTables).

## Key insights (example)
- Poor sleep ( < 6 hrs) is associated with a higher next-day resting HR (sample dataset).
- Overweight users show slightly higher average resting HR in this sample.
**Poor sleep (<6 hrs)** is associated with a higher average resting heart rate the next day.  
- **Overweight individuals (BMI ≥ 25)** consistently showed elevated resting heart rates.  
- Participants with **7–8 hours of sleep** had healthier BMI ranges in this dataset.  
- The combined effect of **poor sleep + overweight** suggests the highest cardiovascular risk zone.  

## Notes & next steps
- Add more real users to strengthen statistical power.
- Automate ETL with Python (Pandas) in the future.
Expand dataset with more participants to strengthen analysis.  
- Automate ETL and analysis in **Python (Pandas)**.  
- Recreate dashboard in **Power BI or Tableau** for interactive web-based sharing.

## Contact
Prepared by Aderonke Ojo — HealthCare Data Analyst | B.Sc. Computer Science | M.Sc. Information Tech | Healthcare Background | IBM & Google Certified
Created by **Aderonke Ojo**  
- [LinkedIn](https://www.linkedin.com/in/aderonke-ojo-7b85a1247)  
- [GitHub](#) (https://github.com/deronkeojo2020)
