**Schema (MySQL v5.7)**

    CREATE TABLE sleep (
      Id VARCHAR(50),
      Date DATE,
      TotalMinutesAsleep INT,
      TotalTimeInBed INT
    );
    
    INSERT INTO sleep (Id, Date, TotalMinutesAsleep, TotalTimeInBed) VALUES
    ('U1', '2025-01-01', 420, 480),  -- 7 hrs sleep out of 8 hrs in bed
    ('U1', '2025-01-02', 390, 450),  -- 6.5 hrs sleep
    ('U1', '2025-01-03', 480, 500),  -- 8 hrs sleep
    ('U1', '2025-01-04', 300, 420),  -- 5 hrs sleep
    ('U1', '2025-01-05', 450, 480);  -- 7.5 hrs sleep
    

---

**Query #1**

    -- Average sleep hours
    SELECT AVG(TotalMinutesAsleep)/60 AS AvgSleepHours
    FROM sleep;

| AvgSleepHours |
| ------------- |
| 6.80000000    |

---
**Query #2**

    
    
    -- Sleep efficiency %
    SELECT AVG(TotalMinutesAsleep*1.0/TotalTimeInBed)*100 AS AvgEfficiency
    FROM sleep;

| AvgEfficiency |
| ------------- |
| 87.069047600  |

---
**Query #3**

    
    
    -- % Nights with >= 7 hours sleep
    SELECT 
        SUM(CASE WHEN TotalMinutesAsleep >= 420 THEN 1 ELSE 0 END)*100.0/COUNT(*) AS PercentGoodSleep
    FROM sleep;

| PercentGoodSleep |
| ---------------- |
| 60.00000         |

---
**Query #4**

    
    
    -- Sleep hours per day (trend)
    SELECT Date, TotalMinutesAsleep/60.0 AS HoursSlept
    FROM sleep
    ORDER BY Date;

| Date       | HoursSlept |
| ---------- | ---------- |
| 2025-01-01 | 7.0000     |
| 2025-01-02 | 6.5000     |
| 2025-01-03 | 8.0000     |
| 2025-01-04 | 5.0000     |
| 2025-01-05 | 7.5000     |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/7Sqf3xP3sjyyMUaJA5ro6r/1)