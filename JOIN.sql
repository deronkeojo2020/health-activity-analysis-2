**Schema (MySQL v5.7)**

    -- Sleep table
    CREATE TABLE sleep (
      Id VARCHAR(50),
      Date DATE,
      TotalMinutesAsleep INT,
      TotalTimeInBed INT
    );
    
    INSERT INTO sleep VALUES
    ('U1', '2025-01-01', 420, 480),
    ('U1', '2025-01-02', 390, 450),
    ('U1', '2025-01-03', 480, 500);
    
    -- Weight table
    CREATE TABLE weight (
      Id VARCHAR(50),
      Date DATE,
      WeightKg DECIMAL(6,2),
      BMI DECIMAL(5,2)
    );
    
    INSERT INTO weight VALUES
    ('U1', '2025-01-01', 70.5, 22.1),
    ('U1', '2025-01-03', 71.0, 22.3);
    
    -- Heart Rate table
    CREATE TABLE heartrate (
      Id VARCHAR(50),
      Time DATETIME,
      Value INT
    );
    
    INSERT INTO heartrate VALUES
    ('U1', '2025-01-01 08:00:00', 72),
    ('U1', '2025-01-01 12:00:00', 85),
    ('U1', '2025-01-02 08:00:00', 70),
    ('U1', '2025-01-03 20:00:00', 80);
    

---

**Query #1**

    -- 1. Join Sleep and Weight (daily data)
    SELECT 
        s.Date,
        s.TotalMinutesAsleep/60.0 AS SleepHrs,
        s.TotalMinutesAsleep*1.0/s.TotalTimeInBed*100 AS Efficiency,
        w.WeightKg,
        w.BMI
    FROM sleep s
    LEFT JOIN weight w
      ON s.Id = w.Id AND s.Date = w.Date
    ORDER BY s.Date;

| Date       | SleepHrs | Efficiency | WeightKg | BMI   |
| ---------- | -------- | ---------- | -------- | ----- |
| 2025-01-01 | 7.0000   | 87.50000   | 70.50    | 22.10 |
| 2025-01-02 | 6.5000   | 86.66667   |          |       |
| 2025-01-03 | 8.0000   | 96.00000   | 71.00    | 22.30 |

---
**Query #2**

    
    
    -- 2. Add Daily Heart Rate Average
    SELECT 
        s.Date,
        s.TotalMinutesAsleep/60.0 AS SleepHrs,
        w.WeightKg,
        w.BMI,
        AVG(h.Value) AS AvgDailyHR
    FROM sleep s
    LEFT JOIN weight w
      ON s.Id = w.Id AND s.Date = w.Date
    LEFT JOIN heartrate h
      ON s.Id = h.Id AND s.Date = DATE(h.Time)
    GROUP BY s.Date, w.WeightKg, w.BMI, s.TotalMinutesAsleep
    ORDER BY s.Date;

| Date       | SleepHrs | WeightKg | BMI   | AvgDailyHR |
| ---------- | -------- | -------- | ----- | ---------- |
| 2025-01-01 | 7.0000   | 70.50    | 22.10 | 78.5000    |
| 2025-01-02 | 6.5000   |          |       | 70.0000    |
| 2025-01-03 | 8.0000   | 71.00    | 22.30 | 80.0000    |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/vQGcq87qn8KNdJk4mZo1oA/0)