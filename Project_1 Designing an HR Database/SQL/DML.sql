INSERT INTO employee (employee_id, employee_nm, email, hire_dt)
SELECT DISTINCT ps.Emp_ID, ps.Emp_NM, ps.email, ps.hire_dt
FROM proj_stg ps

INSERT INTO education (education_level)
SELECT DISTINCT ps.education_lvl
FROM proj_stg ps

INSERT INTO job (job_title)
SELECT DISTINCT ps.job_title
FROM proj_stg ps

INSERT INTO department (department_nm)
SELECT DISTINCT ps.department_nm
FROM proj_stg ps

INSERT INTO salary (salary)
SELECT DISTINCT ps.salary
FROM proj_stg ps

INSERT INTO state (state_nm)
SELECT DISTINCT ps.state
FROM proj_stg ps

INSERT INTO city (city_nm, state_id)
SELECT DISTINCT ps.city, s.state_id
FROM proj_stg ps
JOIN state s ON ps.state = s.state_nm;

INSERT INTO location (location_nm, address, city_id)
SELECT DISTINCT ps.location, ps.address, c.city_id
FROM proj_stg ps
JOIN city c ON ps.city = c.city_nm;

INSERT INTO employee_history (employee_id, job_id, department_id, salary_id, manager_id, start_dt, end_dt, education_id, location_id)
SELECT ps.Emp_ID, j.job_id, d.department_id, s.salary_id, (SELECT employee_id FROM employee WHERE employee_nm = ps.manager), ps.start_dt, ps.end_dt, edu.education_id, l.location_id
FROM proj_stg ps
INNER JOIN job j 			ON ps.job_title = j.job_title
INNER JOIN department d 	ON ps.department_nm = d.department_nm
INNER JOIN salary s 		ON ps.salary = s.salary
INNER JOIN education edu 	ON ps.education_lvl = edu.education_level
INNER JOIN location l 		ON ps.location = l.location_nm




