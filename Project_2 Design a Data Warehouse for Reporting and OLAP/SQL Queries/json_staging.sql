-- Use Project database and schema
use database project2;
use schema STAGING;

-- Create file format for json files
create or replace file format json_format type = 'JSON';
create or replace stage json_stage file_format = json_format;

-- Create tables for json files
create or replace table yelp_academic_dataset_covid_features(recordjson variant);
create or replace table yelp_academic_dataset_business(recordjson variant);
create or replace table yelp_academic_dataset_checkin(recordjson variant);
create or replace table yelp_academic_dataset_review(recordjson variant);
create or replace table yelp_academic_dataset_tip(recordjson variant);
create or replace table yelp_academic_dataset_user(recordjson variant);

