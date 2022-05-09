-- Successfull Queries Go Here
SELECT * FROM titles

-- Determine retirement eligiblity
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Select all employees born in the year 1952
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Select all employees born in the year 1953
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Select all employees born in the year 1954
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Select all employees born in the year 1955
SELECT first_name, last_name
FROM employees
Where birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Determine retirement eligiblity with hire date of 1985-1988
SELECT first_name, last_name
FROM employees
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Count of number of employees retiring
SELECT COUNT(first_name)
FROM employees
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retirement
SELECT first_name, last_name
INTO retirement_info
FROM employees
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

-- Drop retirement_info table in order to create new one
DROP TABLE retirement_info;

-- Create new retirement_info table
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Join department and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date,
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Join retirement_info and dept_emp
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_employee.to_date
FROM retirement_info
LEFT JOIN dept_employee
ON retirement_info.emp_no = dept_employee.emp_no;

-- Join retirement_info and dept_emp using aliases
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employee as de
ON ri.emp_no = de.emp_no;

-- Join departments and dept_manager using aliases
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Join retirement_info and dept_emp using aliases and create new table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_employee
FROM retirement_info as ri
LEFT JOIN dept_employee as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_employee

-- Employee count by dept number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_employee as ce
LEFT JOIN dept_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

DROP TABLE employee_info;
-- Create employee_info table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO employee_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employee as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_employee AS ce
		ON (dm.emp_no = ce.emp_no)

-- Department retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_employee AS ce
	INNER JOIN dept_employee AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)

-- Sales retirees
SELECT  ri.emp_no,
		ri.first_name,
		ri.last_name,
		di.dept_name
FROM retirement_info AS ri
	INNER JOIN dept_info as di
		ON (ri.emp_no = di.emp_no)
WHERE (di.dept_name = 'Sales');

-- Sales and development retirees
SELECT  ri.emp_no,
		ri.first_name,
		ri.last_name,
		di.dept_name
FROM retirement_info AS ri
	INNER JOIN dept_info as di
		ON (ri.emp_no = di.emp_no)
WHERE di.dept_name IN ('Sales', 'Development');















