Heart Rate dataset for Hypothesis 3: Poor Sleep vs
On days after sleep <6 hrs, average heart rate is higher.

**Schema (MySQL v5.7)**

    -- CREATE tables (use non-reserved column names)
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

    -- Detail: join previous night's sleep with next day's average HR
    SELECT 
      s.SleepDate AS SleepDate,
      CASE 
        WHEN s.TotalMinutesAsleep/60.0 < 6 THEN 'Poor Sleep (<6 hrs)'
        ELSE 'Normal Sleep (>=6 hrs)'
      END AS SleepCategory,
      d.Day AS HRDay,
      d.AvgHR
    FROM sleep s
    JOIN (
      SELECT Id, DATE(HRTime) AS Day, AVG(Value) AS AvgHR
      FROM heartrate
      GROUP BY Id, DATE(HRTime)
    ) d
      ON s.Id = d.Id
     AND d.Day = DATE_ADD(s.SleepDate, INTERVAL 1 DAY)
    ORDER BY s.SleepDate;

| SleepDate  | SleepCategory          | HRDay      | AvgHR   |
| ---------- | ---------------------- | ---------- | ------- |
| 2025-01-01 | Normal Sleep (>=6 hrs) | 2025-01-02 | 78.6667 |
| 2025-01-02 | Normal Sleep (>=6 hrs) | 2025-01-03 | 81.0000 |
| 2025-01-03 | Poor Sleep (<6 hrs)    | 2025-01-04 | 81.3333 |

---
**Query #2**

    
    
    -- Aggregated summary: average next-day HR by sleep category
    SELECT 
      CASE 
        WHEN s.TotalMinutesAsleep/60.0 < 6 THEN 'Poor Sleep (<6 hrs)'
        ELSE 'Normal Sleep (>=6 hrs)'
      END AS SleepCategory,
      ROUND(AVG(d.AvgHR),1) AS NextDayAvgHR,
      COUNT(*) AS Days
    FROM sleep s
    JOIN (
      SELECT Id, DATE(HRTime) AS Day, AVG(Value) AS AvgHR
      FROM heartrate
      GROUP BY Id, DATE(HRTime)
    ) d
      ON s.Id = d.Id
     AND d.Day = DATE_ADD(s.SleepDate, INTERVAL 1 DAY)
    GROUP BY SleepCategory;

| SleepCategory          | NextDayAvgHR | Days |
| ---------------------- | ------------ | ---- |
| Normal Sleep (>=6 hrs) | 79.8         | 2    |
| Poor Sleep (<6 hrs)    | 81.3         | 1    |

---

[View on DB Fiddle](https://www.db-fiddle.com/)