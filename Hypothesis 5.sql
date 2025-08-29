joined Sleep + Weight + Heart Rate

**Schema (MySQL v5.7)**

    -- Sleep dataset
    CREATE TABLE sleep (
      Id VARCHAR(50),
      SleepDate DATE,
      TotalMinutesAsleep INT,
      TotalTimeInBed INT
    );
    
    INSERT INTO sleep (Id, SleepDate, TotalMinutesAsleep, TotalTimeInBed) VALUES
    ('U1', '2025-01-01', 420, 480),
    ('U1', '2025-01-02', 360, 420),
    ('U1', '2025-01-03', 300, 420),
    ('U1', '2025-01-04', 330, 400);
    
    -- Weight dataset
    CREATE TABLE weight (
      Id VARCHAR(50),
      RecordDate DATE,
      WeightKg DECIMAL(5,2),
      BMI DECIMAL(5,2)
    );
    
    INSERT INTO weight (Id, RecordDate, WeightKg, BMI) VALUES
    ('U1', '2025-01-01', 70.0, 22.5),
    ('U1', '2025-01-02', 71.0, 22.8),
    ('U1', '2025-01-03', 72.0, 23.1),
    ('U1', '2025-01-04', 72.5, 23.3);
    
    -- Heart Rate dataset
    CREATE TABLE heartrate (
      Id VARCHAR(50),
      HRTime DATETIME,
      Value INT
    );
    
    INSERT INTO heartrate (Id, HRTime, Value) VALUES
    ('U1', '2025-01-01 08:00:00', 72),
    ('U1', '2025-01-01 12:00:00', 85),
    ('U1', '2025-01-01 20:00:00', 78),
    ('U1', '2025-01-02 08:00:00', 70),
    ('U1', '2025-01-02 12:00:00', 90),
    ('U1', '2025-01-02 20:00:00', 76),
    ('U1', '2025-01-03 08:00:00', 68),
    ('U1', '2025-01-03 12:00:00', 95),
    ('U1', '2025-01-03 20:00:00', 80),
    ('U1', '2025-01-04 08:00:00', 74),
    ('U1', '2025-01-04 12:00:00', 88),
    ('U1', '2025-01-04 20:00:00', 82);
    

---

**Query #1**

    SELECT 
      s.SleepDate AS Date,
      ROUND(s.TotalMinutesAsleep/60.0,1) AS SleepHours,
      w.BMI,
      ROUND(d.AvgDailyHR,1) AS RestingHR,
      CASE 
        WHEN s.TotalMinutesAsleep/60.0 < 6 THEN 'Poor Sleep'
        ELSE 'Normal Sleep'
      END AS SleepCategory,
      CASE 
        WHEN w.BMI >= 25 THEN 'Overweight'
        ELSE 'Normal'
      END AS BMICategory
    FROM sleep s
    JOIN weight w
      ON s.Id = w.Id
     AND s.SleepDate = w.RecordDate
    JOIN (
      SELECT Id, DATE(HRTime) AS Day, AVG(Value) AS AvgDailyHR
      FROM heartrate
      WHERE HOUR(HRTime) BETWEEN 6 AND 10
      GROUP BY Id, DATE(HRTime)
    ) d
      ON s.Id = d.Id
     AND s.SleepDate = d.Day
    ORDER BY s.SleepDate;

| Date       | SleepHours | BMI   | RestingHR | SleepCategory | BMICategory |
| ---------- | ---------- | ----- | --------- | ------------- | ----------- |
| 2025-01-01 | 7.0        | 22.50 | 72.0      | Normal Sleep  | Normal      |
| 2025-01-02 | 6.0        | 22.80 | 70.0      | Normal Sleep  | Normal      |
| 2025-01-03 | 5.0        | 23.10 | 68.0      | Poor Sleep    | Normal      |
| 2025-01-04 | 5.5        | 23.30 | 74.0      | Poor Sleep    | Normal      |

---

[View on DB Fiddle](https://www.db-fiddle.com/)