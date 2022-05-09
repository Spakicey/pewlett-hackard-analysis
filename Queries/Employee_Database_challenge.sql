-- Retirement titles (Deliverable 1)
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		ts.title,
		ts.from_date,
		ts.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS ts
		ON (e.emp_no = ts.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01') 
ORDER BY rt.emp_no, rt.to_date DESC;

-- Count number of employees by job title who are retiring
SELECT COUNT(ut.title), ut.title
INTO retiring_titles_count
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Employees eligible for mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ts.title
INTO mentorship_eligible
FROM employees AS e
	INNER JOIN dept_employee AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS ts
		ON (e.emp_no = ts.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY (e.emp_no);

-- Count of employees eligible for mentorship
SELECT COUNT(me.title), me.title
FROM mentorship_eligible AS me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;

-- Count of hire dates
SELECT COUNT(me.from_date), me.from_date
FROM mentorship_eligible AS me
GROUP BY me.from_date
ORDER BY me.from_date ASC;
