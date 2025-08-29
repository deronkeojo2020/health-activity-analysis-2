Query SQL
-- Average weight and BMI
SELECT AVG(WeightKg) AS AvgWeight, AVG(BMI) AS AvgBMI
FROM weight;

-- Maximum and minimum recorded weight
SELECT MAX(WeightKg) AS MaxWeight, MIN(WeightKg) AS MinWeight
FROM weight;

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

-- Weight trend over time
SELECT Date, WeightKg
FROM weight
ORDER BY Date;
  
