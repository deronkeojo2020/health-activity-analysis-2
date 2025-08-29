Hypothesis 2: Sleep Efficiency vs Weight
Lower sleep efficiency (<85%) is associated with higher weight.

**Schema (MySQL v5.7)**

    -- Sleep table
    CREATE TABLE sleep (
      Id VARCHAR(50),
      Date DATE,
      TotalMinutesAsleep INT,
      TotalTimeInBed INT
    );
    
    INSERT INTO sleep VALUES
    ('U1', '2025-01-01', 420, 480), -- 87.5% efficiency
    ('U1', '2025-01-02', 360, 420), -- 85.7%
    ('U1', '2025-01-03', 300, 420), -- 71.4%
    ('U1', '2025-01-04', 330, 400); -- 82.5%
    
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
    ('U1', '2025-01-03', 71.8, 22.6),
    ('U1', '2025-01-04', 72.2, 22.7);
    

---

**Query #1**

    SELECT 
        CASE 
            WHEN (s.TotalMinutesAsleep * 1.0 / s.TotalTimeInBed) >= 0.85 THEN 'Efficient (>=85%)'
            ELSE 'Inefficient (<85%)'
        END AS EfficiencyGroup,
        AVG(w.WeightKg) AS AvgWeight,
        AVG(w.BMI) AS AvgBMI,
        COUNT(*) AS RecordCount
    FROM sleep s
    LEFT JOIN weight w
      ON s.Id = w.Id AND s.Date = w.Date
    GROUP BY EfficiencyGroup;

| EfficiencyGroup    | AvgWeight | AvgBMI    | RecordCount |
| ------------------ | --------- | --------- | ----------- |
| Efficient (>=85%)  | 70.750000 | 22.200000 | 2           |
| Inefficient (<85%) | 72.000000 | 22.650000 | 2           |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/aqZfzDavHJw3UbPc3tf7VH/0)