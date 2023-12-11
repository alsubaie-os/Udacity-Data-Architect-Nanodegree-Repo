-- Use Project database and schema --
use database PROJECT2;
use schema DWH;

-- Create table customer --
CREATE TABLE IF NOT EXISTS dim_Customer (
    customer_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    review_count INT,
    average_stars FLOAT
);

INSERT INTO dim_Customer (customer_id, name, review_count, average_stars)
SELECT customer_id, name, review_count, average_stars
FROM PROJECT2.ODS.Customer;

-- Create table business --
CREATE TABLE IF NOT EXISTS dim_Business (
    business_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    is_open INT,
    stars DOUBLE,
    city VARCHAR,
    state VARCHAR,
    postal_code VARCHAR,
    checkin_dates VARCHAR
);

INSERT INTO dim_Business (business_id, name, is_open, stars, city, state, postal_code, checkin_dates)
SELECT b.business_id, b.name, b.is_open, b.stars, l.city, l.state, l.postal_code, c.date
FROM PROJECT2.ODS.Business b
JOIN PROJECT2.ODS.Location l
ON b.location_id = l.location_id
JOIN PROJECT2.ODS.Checkin c
ON b.business_id = c.business_id;

-- Create table temprature --
CREATE TABLE IF NOT EXISTS dim_Temperature (
    date VARCHAR PRIMARY KEY,
    min_temp DOUBLE,
    max_temp DOUBLE,
    normal_min DOUBLE,
    normal_max DOUBLE
);

INSERT INTO dim_Temperature (date, min_temp, max_temp, normal_min, normal_max)
SELECT date, min_temp, max_temp, normal_min, normal_max
FROM PROJECT2.ODS.Temperature;

-- Create table precipitation --
CREATE TABLE IF NOT EXISTS dim_Precipitation (
    date DATE PRIMARY KEY,
    precipitation VARCHAR,
    precipitation_normal DOUBLE
);

INSERT INTO dim_Precipitation (date, precipitation, precipitation_normal)
SELECT date, precipitation, precipitation_normal
FROM PROJECT2.ODS.Precipitation;

-- Create table Fact --
CREATE TABLE IF NOT EXISTS Fact (
    fact_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR REFERENCES PROJECT2.DWH.dim_Customer(customer_id),
    business_id VARCHAR REFERENCES PROJECT2.DWH.dim_Business(business_id),
    stars DOUBLE,
    date VARCHAR REFERENCES PROJECT2.DWH.dim_Temperature(date)
);

INSERT INTO Fact (fact_id, customer_id, business_id, stars, date)
SELECT review_id, customer_id, business_id, stars, date
FROM PROJECT2.ODS.Review;

-- Query for data analysis

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