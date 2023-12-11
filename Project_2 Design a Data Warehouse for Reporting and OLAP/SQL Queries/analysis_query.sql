-- SQL generated report that clearly includes business name, temperature, precipitation, and ratings.
SELECT b.name, t.min_temp, t.max_temp , AVG(f.stars) AS average_stars, p.precipitation
FROM PROJECT2.DWH.Fact f
JOIN PROJECT2.DWH.dim_Business b
ON f.business_id = b.business_id
JOIN PROJECT2.DWH.dim_Temperature t
ON f.date = t.date
JOIN PROJECT2.DWH.dim_Precipitation p
ON f.date = p.date
GROUP BY b.name, t.min_temp, t.max_temp, p.precipitation