# Create a new database or use an existing database
CREATE DATABASE PROJECT2;
SHOW DATABASES;
USE DATABASE PROJECT2;

# Create a schema or use an existing schema
CREATE SCHEMA STAGING;
USE SCHEMA STAGING;

# After the above steps, create the tables in the json_staging.sql file and create the tables in the csv_staging.sql file.

# After creating the tables, load the data from the sourse files to create the tables in the staging schema.
put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/yelp_academic_dataset_covid_features.json' @json_stage auto_compress=true parallel=4;
copy into "YELP_ACADEMIC_DATASET_COVID_FEATURES" from @json_stage/yelp_academic_dataset_covid_features.json file_format=json_format on_error='skip_file';


put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/yelp_academic_dataset_business.json' @json_stage auto_compress=true parallel=4;
copy into "YELP_ACADEMIC_DATASET_BUSINESS" from @json_stage/yelp_academic_dataset_business.json file_format=json_format on_error='skip_file';


put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/yelp_academic_dataset_checkin.json' @json_stage auto_compress=true parallel=4;
copy into "YELP_ACADEMIC_DATASET_CHECKIN" from @json_stage/yelp_academic_dataset_checkin.json file_format=json_format on_error='skip_file';


put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/yelp_academic_dataset_review.json' @json_stage auto_compress=true parallel=4;
copy into "YELP_ACADEMIC_DATASET_REVIEW" from @json_stage/yelp_academic_dataset_review.json file_format=json_format on_error='skip_file';


put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/yelp_academic_dataset_tip.json' @json_stage auto_compress=true parallel=4;
copy into "YELP_ACADEMIC_DATASET_TIP" from @json_stage/yelp_academic_dataset_tip.json file_format=json_format on_error='skip_file';


put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/yelp_academic_dataset_user.json' @json_stage auto_compress=true parallel=4;
copy into "YELP_ACADEMIC_DATASET_USER" from @json_stage/yelp_academic_dataset_user.json file_format=json_format on_error='skip_file';


put file:////Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/Las Vegas McCarran.csv @csv_stage auto_compress=true parallel=4;
copy into "LAS_VEGAS_MCCARRAN" from @csv_stage/Las Vegas McCarran.csv.gz file_format=csvformat on_error='skip_file';


put 'file:///Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/temperature.csv' @csv_stage auto_compress=true parallel=4;
copy into "lv_temperature"("date", "min", "max", "normal_min", "normal_max")
from (select to_date(t.$1, 'yyyymmdd'), t.$2, t.$3, t.$4, t.$5 from @csv_stage/temperature.csv t) file_format=csv_format ON_ERROR = 'continue';

put 'file:////Users/osamaalsubaie/Desktop/Data Architect/Designing Data Systems/Project/Data/precipitation.csv' @csv_stage auto_compress=true parallel=4;
copy into "lv_precipitation"("date", "precipitation", "precipitation_normal")
from (select to_date(t.$1, 'yyyymmdd'), t.$2, t.$3 from @csv_stage/precipitation.csv t) file_format=csv_format ON_ERROR = 'continue';
