CREATE TABLE IF NOT EXISTS employee (
								employee_id VARCHAR(10) PRIMARY KEY,
								employee_nm VARCHAR(100),
								email		VARCHAR(100),
								hire_dt		DATE
								);
								
CREATE TABLE IF NOT EXISTS education (
								education_id  	SERIAL PRIMARY KEY,
								education_level VARCHAR(50)
								);		

CREATE TABLE IF NOT EXISTS job (
								job_id 		SERIAL PRIMARY KEY,
								job_title 	VARCHAR(50)
								);

CREATE TABLE IF NOT EXISTS department (
								department_id SERIAL PRIMARY KEY,
								department_nm VARCHAR(50)
								);							

CREATE TABLE IF NOT EXISTS salary (
								salary_id 	SERIAL PRIMARY KEY,
								salary 		INT
								);

CREATE TABLE IF NOT EXISTS state (
								state_id SERIAL PRIMARY KEY,
								state_nm VARCHAR(50)
								);

CREATE TABLE IF NOT EXISTS city (
								city_id 	SERIAL PRIMARY KEY,
								city_nm 	VARCHAR(50),
								state_id 	INT
								);

CREATE TABLE IF NOT EXISTS location (
								location_id SERIAL PRIMARY KEY,
								location_nm VARCHAR(50),
								address		VARCHAR(100),
								city_id		INT
								);

CREATE TABLE IF NOT EXISTS employee_history (
								history_id 		SERIAL 		PRIMARY KEY,
								employee_id 	VARCHAR(10)	REFERENCES employee (employee_id),
								job_id			INT			REFERENCES job (job_id),
								department_id	INT			REFERENCES department (department_id),
								salary_id 		INT			REFERENCES salary (salary_id),
								manager_id 		VARCHAR(10)	REFERENCES employee (employee_id),
								start_dt		DATE,
								end_dt			DATE,
								education_id	INT			REFERENCES education (education_id),
								location_id 	INT			REFERENCES location (location_id)
								);
