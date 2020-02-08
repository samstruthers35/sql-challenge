--CREATE TABLE departments (
--    dept_no VARCHAR  NOT NULL ,
--    dept_name VARCHAR  NOT NULL ,
--    PRIMARY KEY (
--        dept_no
--    )
--);


--CREATE TABLE dept_emp (
--    emp_no INTEGER  NOT NULL ,
--    dept_no VARCHAR  NOT NULL ,
--    from_date VARCHAR  NOT NULL ,
--    to_date VARCHAR  NOT NULL
--);

--CREATE TABLE dept_manager (
--    dept_no VARCHAR  NOT NULL ,
--    emp_no INTEGER  NOT NULL ,
--    from_date VARCHAR  NOT NULL ,
--    to_date VARCHAR  NOT NULL 
--);

--CREATE TABLE employees (
--    emp_no INTEGER  NOT NULL ,
--    birth_date VARCHAR  NOT NULL ,
--    first_name VARCHAR  NOT NULL ,
--    last_name VARCHAR  NOT NULL ,
--    gender VARCHAR  NOT NULL ,
--    hire_date VARCHAR  NOT NULL ,
--    PRIMARY KEY (
--       emp_no
--    )
--);

--CREATE TABLE salaries (
--    emp_no INTEGER  NOT NULL ,
--    salary VARCHAR  NOT NULL ,
--    from_date VARCHAR  NOT NULL ,
--    to_date VARCHAR  NOT NULL 
--);

--CREATE TABLE titles (
--    emp_no INTEGER  NOT NULL ,
--    title VARCHAR  NOT NULL ,
--    from_date VARCHAR  NOT NULL ,
--    to_date VARCHAR  NOT NULL 
--);

--ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
--REFERENCES employees (emp_no);

--ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
--REFERENCES departments (dept_no);

--ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
--REFERENCES departments (dept_no);

--ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
--REFERENCES employees (emp_no);

--ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
--REFERENCES employees (emp_no);

--ALTER TABLE titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
--REFERENCES employees (emp_no);

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM salaries AS s
INNER JOIN employees AS e 
ON e.emp_no = s.emp_no;
--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date LIKE '1986%';
--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM departments AS d

INNER JOIN dept_manager AS m 
ON m.dept_no = d.dept_no

JOIN employees AS e 
ON e.emp_no = m.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_no
FROM employees AS E
INNER JOIN dept_emp AS d 
ON e.emp_no = d.emp_no


--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%';
--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name, dp.dept_no, d.dept_no, d.emp_no
FROM employees AS e

INNER JOIN dept_emp AS d 
ON e.emp_no = d.emp_no

INNER JOIN departments AS dp 
ON dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales'
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name, dp.dept_no, d.dept_no, d.emp_no
FROM employees AS e

INNER JOIN dept_emp AS d 
ON e.emp_no = d.emp_no

INNER JOIN departments AS dp 
ON dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales' OR dp.dept_name LIKE 'Development'
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;