-- Use Project database and schema --
use database PROJECT2;
use schema ODS;

-- Create table Location --
CREATE TABLE IF NOT EXISTS Location (
    location_id NUMBER IDENTITY PRIMARY KEY,
    address VARCHAR,
    city VARCHAR,
    state VARCHAR,
    postal_code VARCHAR,
    latitude DOUBLE,
    longitude DOUBLE
);

INSERT INTO Location (address, city, state, postal_code, latitude, longitude)
SELECT DISTINCT 
    RECORDJSON:address,
    RECORDJSON:city,
    RECORDJSON:state,
    RECORDJSON:postal_code,
    RECORDJSON:latitude,
    RECORDJSON:longitude
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_BUSINESS;

-- Create table Business --
CREATE TABLE IF NOT EXISTS Business (
    business_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    is_open INT,
    stars DOUBLE,
    location_id INT REFERENCES PROJECT2.ODS.Location(location_id)
);

INSERT INTO Business (business_id, name, is_open, stars, location_id)
SELECT DISTINCT
    RECORDJSON:business_id,
    RECORDJSON:name,
    RECORDJSON:is_open,
    RECORDJSON:stars,
    Location.location_id
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_BUSINESS
JOIN PROJECT2.ODS.Location location
ON
    RECORDJSON:city = location.city and
    RECORDJSON:address = location.address and
    RECORDJSON:latitude = location.latitude and
    RECORDJSON:longitude = location.longitude and
    RECORDJSON:state = location.state;

-- Create table Customer --
CREATE TABLE IF NOT EXISTS Customer (
    customer_id VARCHAR PRIMARY KEY,
    name VARCHAR(50),
    review_count INT,
    average_stars FLOAT
);

INSERT INTO Customer (customer_id, name, review_count, average_stars)
SELECT DISTINCT
    RECORDJSON:user_id,
    RECORDJSON:name,
    RECORDJSON:review_count,
    RECORDJSON:average_stars
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_USER;

-- Create table Review --
CREATE TABLE IF NOT EXISTS Review (
    review_id VARCHAR PRIMARY KEY,
    stars DOUBLE,
    date DATE,
    text VARCHAR,
    useful INT,
    funny INT,
    cool INT,
    business_id VARCHAR REFERENCES PROJECT2.ODS.Business(business_id),
    customer_id VARCHAR REFERENCES PROJECT2.ODS.Customer(customer_id)
);

INSERT INTO Review (review_id, stars, date, text, useful, funny, cool, business_id, customer_id)
SELECT DISTINCT
    RECORDJSON:review_id,
    RECORDJSON:stars,
    RECORDJSON:date,
    RECORDJSON:text,
    RECORDJSON:useful,
    RECORDJSON:funny,
    RECORDJSON:cool,
    RECORDJSON:business_id,
    RECORDJSON:user_id
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_REVIEW;

-- Create table Checkin --
CREATE TABLE IF NOT EXISTS Checkin (
    business_id VARCHAR PRIMARY KEY REFERENCES PROJECT2.ODS.Business(business_id),
    date VARCHAR
);

INSERT INTO Checkin (business_id, date)
SELECT DISTINCT
    RECORDJSON:business_id,
    RECORDJSON:date
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_CHECKIN;

-- Create table Tip --
CREATE TABLE IF NOT EXISTS Tip (
    business_id VARCHAR PRIMARY KEY REFERENCES PROJECT2.ODS.Business(business_id),
    customer_id VARCHAR REFERENCES PROJECT2.ODS.Customer(customer_id),
    date VARCHAR,
    compliment_count INT
);

INSERT INTO Tip (business_id, customer_id, date, compliment_count)
SELECT DISTINCT
    RECORDJSON:business_id,
    RECORDJSON:user_id,
    RECORDJSON:date,
    RECORDJSON:compliment_count
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_TIP;

-- Create table Covid --
CREATE TABLE IF NOT EXISTS Covid(
  business_id VARCHAR PRIMARY KEY REFERENCES PROJECT2.ODS.Business(business_id),
   call_action VARCHAR,
   grubhub VARCHAR,
   request_a_quote VARCHAR,
   temporary_closed VARCHAR,
   virtual_services VARCHAR,
   delivery_or_takeout VARCHAR,
   highlights VARCHAR
);

INSERT INTO Covid (business_id, call_action, grubhub, request_a_quote, temporary_closed, virtual_services, delivery_or_takeout, highlights)
SELECT DISTINCT
    RECORDJSON:business_id,
    RECORDJSON:call_action,
    RECORDJSON:grubhub,
    RECORDJSON:request_a_quote,
    RECORDJSON:temporary_closed,
    RECORDJSON:virtual_services,
    RECORDJSON:delivery_or_takeout,
    RECORDJSON:highlights
FROM PROJECT2.STAGING.YELP_ACADEMIC_DATASET_COVID_FEATURES;

-- Create table Temperature --
CREATE TABLE IF NOT EXISTS Temperature(
    date DATE PRIMARY KEY,
    min_temp DOUBLE,
    max_temp DOUBLE,
    normal_min DOUBLE,
    normal_max DOUBLE
);

INSERT INTO Temperature (date, min_temp, max_temp, normal_min, normal_max)
SELECT DISTINCT
    "date" DATE,
    "min" DOUBLE,
    "max" DOUBLE,
    "normal_min" DOUBLE,
    "normal_max" DOUBLE
FROM PROJECT2.STAGING."lv_temperature";

-- Create table Precipitation --
CREATE TABLE IF NOT EXISTS Precipitation(
    date DATE PRIMARY KEY,
    precipitation VARCHAR,
    precipitation_normal DOUBLE
);

INSERT INTO Precipitation (date, precipitation, precipitation_normal)
SELECT DISTINCT
    "date" DATE,
    "precipitation" VARCHAR,
    "precipitation_normal" DOUBLE
FROM PROJECT2.STAGING."lv_precipitation";


