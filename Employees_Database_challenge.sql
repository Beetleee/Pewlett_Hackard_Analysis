-- Deliverable 1a: retrieve info from employee table and titles, then create new table, then join both tables on pk emp_no, filter on bd.
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Deliverable 1b: retrieve the first occurance 
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
    first_name,
    last_name,
    title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;

-- Deliverable 1c: retrieve employees by their most recent job title 
-- who are about to retire.
SELECT COUNT(un.emp_no),
un.title
INTO retiring_titles
FROM unique_titles as un
GROUP BY title 
ORDER BY COUNT(title) DESC;


-- DELIVERABLE 2:
-- create a Mentorship Eligibility table 
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees as e
Left outer Join dept_emp as de
ON (e.emp_no = de.emp_no)
Left outer Join titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;