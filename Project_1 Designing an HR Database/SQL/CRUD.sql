--Question #1: Return a list of employees with Job Titles and Department Names.
 
SELECT eh.employee_id, e.employee_nm, j.job_title, d.department_nm
FROM employee_history eh
JOIN employee e 	ON eh.employee_id = e.employee_id
JOIN job j	 		ON eh.job_id = j.job_id
JOIN department d	ON eh.department_id = d.department_id

--Question #2: Insert Web Programmer as a new job title.

INSERT INTO job (job_title)
VALUES 			('Web Programmer');

SELECT * FROM job

--Question #3: Correct the job title from web programmer to web developer.

UPDATE job
SET 	job_title = 'Web Developer'
WHERE 	job_title = 'Web Programmer';

SELECT * FROM job

--Question #4: Delete the job title Web Developer from the database.

DELETE FROM job
WHERE job_title = 'Web Developer';

SELECT * FROM job

--Question #5: How many employees are in each department?

SELECT COUNT(eh.*), d.department_nm
FROM employee_history eh
JOIN department d
ON eh.department_id = d.department_id
GROUP BY department_nm

--Question #6: Write a query that returns current and past jobs (include employee name, job title, department, manager name, start and end date for position) for employee Toni Lembeck.

SELECT 	e.employee_nm 	AS "employee name", 
		j.job_title 	AS "job title", 
		d.department_nm AS "department name", 
		(SELECT employee_nm FROM employee e WHERE eh.manager_id = e.employee_id) AS "manager name", 
		eh.start_dt		AS "start date", 
		eh.end_dt		AS "end date"
FROM employee_history eh
JOIN employee e 	ON eh.employee_id = e.employee_id
JOIN job j	 		ON eh.job_id = j.job_id
JOIN department d	ON eh.department_id = d.department_id
WHERE employee_nm = 'Toni Lembeck'
 