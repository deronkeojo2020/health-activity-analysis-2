Hypothesis 1 (Sleep hours vs BMI)
People who sleep ≥7 hrs tend to have healthier BMI compared to those who sleep <7 hrs.
**Schema (MySQL v5.7)**

    -- Sleep table
    CREATE TABLE sleep (
      Id VARCHAR(50),
      Date DATE,
      TotalMinutesAsleep INT,
      TotalTimeInBed INT
    );
    
    INSERT INTO sleep VALUES
    ('U1', '2025-01-01', 420, 480), -- 7 hrs
    ('U1', '2025-01-02', 360, 420), -- 6 hrs
    ('U1', '2025-01-03', 480, 500), -- 8 hrs
    ('U1', '2025-01-04', 330, 400); -- 5.5 hrs
    
    -- Weight table
    CREATE TABLE weight (
      Id VARCHAR(50),
      Date DATE,
      WeightKg DECIMAL(6,2),
      BMI DECIMAL(5,2)
    );
    
    INSERT INTO weight VALUES
    ('U1', '2025-01-01', 70.5, 22.1),
    ('U1', '2025-01-02', 71.0, 22.3),
    ('U1', '2025-01-03', 70.8, 22.2),
    ('U1', '2025-01-04', 71.2, 22.4);
    

---

**Query #1**

    SELECT 
        CASE 
            WHEN s.TotalMinutesAsleep/60.0 >= 7 THEN 'Slept 7+ hrs'
            ELSE 'Slept <7 hrs'
        END AS SleepGroup,
        AVG(w.BMI) AS AvgBMI,
        COUNT(*) AS RecordCount
    FROM sleep s
    LEFT JOIN weight w
      ON s.Id = w.Id AND s.Date = w.Date
    GROUP BY SleepGroup;

| SleepGroup   | AvgBMI    | RecordCount |
| ------------ | --------- | ----------- |
| Slept 7+ hrs | 22.150000 | 2           |
| Slept <7 hrs | 22.350000 | 2           |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/v5PHcBb5YnzqzszgEJEipH/0)

