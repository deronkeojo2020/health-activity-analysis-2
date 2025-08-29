**Schema (MySQL v5.7)**

    CREATE TABLE weight (
      Id VARCHAR(50),
      Date DATE,
      WeightKg DECIMAL(6,2),
      BMI DECIMAL(5,2)
    );
    
    INSERT INTO weight (Id, Date, WeightKg, BMI) VALUES
    ('U1', '2025-01-01', 70.5, 22.1),
    ('U1', '2025-01-05', 71.0, 22.3),
    ('U1', '2025-01-10', 70.8, 22.2),
    ('U1', '2025-01-15', 72.0, 22.6),
    ('U1', '2025-01-20', 71.5, 22.4),
    ('U1', '2025-01-25', 72.2, 22.7);
    

---

**Query #1**

    -- Average weight and BMI
    SELECT AVG(WeightKg) AS AvgWeight, AVG(BMI) AS AvgBMI
    FROM weight;

| AvgWeight | AvgBMI    |
| --------- | --------- |
| 71.333333 | 22.383333 |

---
**Query #2**

    
    
    -- Maximum and minimum recorded weight
    SELECT MAX(WeightKg) AS MaxWeight, MIN(WeightKg) AS MinWeight
    FROM weight;

| MaxWeight | MinWeight |
| --------- | --------- |
| 72.20     | 70.50     |

---
**Query #3**

    
    
    -- BMI categories count
    SELECT 
        CASE 
            WHEN BMI < 18.5 THEN 'Underweight'
            WHEN BMI < 25 THEN 'Normal'
            WHEN BMI < 30 THEN 'Overweight'
            ELSE 'Obese'
        END AS BMICategory,
        COUNT(*) AS Count
    FROM weight
    GROUP BY BMICategory;

| BMICategory | Count |
| ----------- | ----- |
| Normal      | 6     |

---
**Query #4**

    
    
    -- Weight trend over time
    SELECT Date, WeightKg
    FROM weight
    ORDER BY Date;

| Date       | WeightKg |
| ---------- | -------- |
| 2025-01-01 | 70.50    |
| 2025-01-05 | 71.00    |
| 2025-01-10 | 70.80    |
| 2025-01-15 | 72.00    |
| 2025-01-20 | 71.50    |
| 2025-01-25 | 72.20    |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/4PTJGt29dS8ygBvsQMqCip/1)