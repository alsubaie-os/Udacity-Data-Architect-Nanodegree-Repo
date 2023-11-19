-- Standout Suggestion #1: Create a view that returns all employee attributes; results should resemble initial Excel file

CREATE VIEW HR AS
SELECT eh.employee_id 				AS "EMP_ID",
		e.employee_nm 				AS "EMP_NM",
		e.email						AS "EMAIL",
		e.hire_dt					AS "HIRE_DT",
		j.job_title 				AS "JOB_TITLE",
		s.salary					AS "SALARY",
		d.department_nm 			AS "DEPARTMENT", 
		(SELECT employee_nm FROM employee e WHERE eh.manager_id = e.employee_id) AS "MANAGER", 
		eh.start_dt					AS "START_DT", 
		eh.end_dt					AS "END_DT",
		l.location_nm				AS "LOCATION",
		l.address					AS "ADDRESS	CITY",
		st.state_nm					AS "STATE",
		edu.education_level			AS "EDUCATION LEVEL"
FROM employee_history eh
JOIN employee e 	ON eh.employee_id = e.employee_id
JOIN job j	 		ON eh.job_id = j.job_id
JOIN department d	ON eh.department_id = d.department_id
JOIN education edu	ON eh.education_id = edu.education_id
JOIN salary s		ON eh.salary_id = s.salary_id
JOIN location l 	ON eh.location_id = l.location_id
JOIN city c 		ON l.city_id = c.city_id
JOIN state st	 	ON c.state_id = st.state_id

SELECT * FROM HR

-- Standout Suggestion #2: Create a stored procedure with parameters that returns current and past jobs (include employee name, job title, department, manager name, start and end date for position) when given an employee name.

CREATE OR REPLACE FUNCTION get_employee_history(param_employee_name VARCHAR(100)) 
RETURNS TABLE (
	employee_id 	VARCHAR(10),
	employee_nm 	VARCHAR(100),
	job_title 		VARCHAR(50),
	department_name VARCHAR(50),
	manager_name	VARCHAR(100),
	start_date 		DATE,
	end_date 		DATE
) AS $$
BEGIN
	RETURN QUERY
	SELECT 
		eh.employee_id, 
		e.employee_nm, 
		j.job_title, 
		d.department_nm, 
		(SELECT emp.employee_nm FROM employee emp WHERE eh.employee_id = emp.employee_id) AS manager_name, 
		eh.start_dt, 
		eh.end_dt
	FROM 
		employee_history eh
	JOIN 
		employee e ON eh.employee_id = e.employee_id
	JOIN 
		job j ON eh.job_id = j.job_id
	JOIN 
		department d ON eh.department_id = d.department_id
	WHERE 
		e.employee_nm = param_employee_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_employee_history('Toni Lembeck');



-- Standout Suggestion #3: Implement user security on the restricted salary attribute.

-- Create user
CREATE USER NoMgr;
-- Grant access to the DB
GRANT SELECT ON HR TO NoMgr;
-- Revoke access to the salary table for the NoMgr user
REVOKE SELECT ON TABLE salary FROM NoMgr;


