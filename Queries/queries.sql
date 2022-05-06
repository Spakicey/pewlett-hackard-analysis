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









