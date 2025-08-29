**Schema (MySQL v5.7)**

    CREATE TABLE heartrate (
      Id VARCHAR(50),
      Time DATETIME,
      Value INT
    );
    
    INSERT INTO heartrate (Id, Time, Value) VALUES
    ('U1', '2025-01-01 08:00:00', 72),
    ('U1', '2025-01-01 12:00:00', 85),
    ('U1', '2025-01-01 20:00:00', 78),
    ('U1', '2025-01-02 08:00:00', 70),
    ('U1', '2025-01-02 12:00:00', 90),
    ('U1', '2025-01-02 20:00:00', 76),
    ('U1', '2025-01-03 08:00:00', 68),
    ('U1', '2025-01-03 12:00:00', 95),
    ('U1', '2025-01-03 20:00:00', 80);
    

---

**Query #1**

    -- Average heart rate overall
    SELECT AVG(Value) AS AvgHeartRate
    FROM heartrate;

| AvgHeartRate |
| ------------ |
| 79.3333      |

---
**Query #2**

    
    
    -- Daily average heart rate
    SELECT DATE(Time) AS Day, AVG(Value) AS AvgDailyHR
    FROM heartrate
    GROUP BY DATE(Time)
    ORDER BY Day;

| Day        | AvgDailyHR |
| ---------- | ---------- |
| 2025-01-01 | 78.3333    |
| 2025-01-02 | 78.6667    |
| 2025-01-03 | 81.0000    |

---
**Query #3**

    
    
    -- Maximum and minimum heart rate per day
    SELECT DATE(Time) AS Day,
           MAX(Value) AS MaxHR,
           MIN(Value) AS MinHR
    FROM heartrate
    GROUP BY DATE(Time)
    ORDER BY Day;

| Day        | MaxHR | MinHR |
| ---------- | ----- | ----- |
| 2025-01-01 | 85    | 72    |
| 2025-01-02 | 90    | 70    |
| 2025-01-03 | 95    | 68    |

---
**Query #4**

    
    
    -- Time of day pattern (Morning/Afternoon/Evening)
    SELECT 
        CASE 
            WHEN HOUR(Time) BETWEEN 5 AND 11 THEN 'Morning'
            WHEN HOUR(Time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS TimeOfDay,
        AVG(Value) AS AvgHR
    FROM heartrate
    GROUP BY TimeOfDay;

| TimeOfDay | AvgHR   |
| --------- | ------- |
| Afternoon | 90.0000 |
| Evening   | 78.0000 |
| Morning   | 70.0000 |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/6FuHjaaPDQdSmQyRck5eAo/0)
  
