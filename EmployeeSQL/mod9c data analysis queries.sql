-- (1) List the employee number, last name, first name, sex, and salary of each employee.
	SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
	FROM Employees as e
	INNER JOIN Salaries as s ON
	e.emp_no=s.emp_no;

-- (2) List the first name, last name, and hire date for the employees who were hired in 1986.
	select last_name, first_name, hire_date
	from Employees
	where extract('year' from hire_date) = 1986;

-- (3) List the manager of each department along with their department number, department name, employee number, last name, and first name.
	SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
	FROM department_managers as m

		LEFT JOIN Employees as e 
		ON (m.emp_no=e.emp_no)

		LEFT JOIN Departments as d 
		ON (m.dept_no=d.dept_no);

-- (4) List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
	SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
	FROM dept_emp as de

		JOIN Employees as e 
		ON (de.emp_no=e.emp_no)
		
		JOIN Departments as d 
		ON (de.dept_no=d.dept_no)
		
		ORDER BY de.emp_no;

-- (5) List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
	select first_name, last_name, sex
	from Employees
	where first_name = 'Hercules'
		and LEFT(last_name, 1) = 'B'

-- (6) List each employee in the Sales department, including their employee number, last name, and first name.

	-- create combined dataset, including dept ID's and Names
	select e.emp_no, e.last_name, e.first_name
	from Employees as e

		join dept_emp as de
		on (e.emp_no=de.emp_no)

	-- filter down to only the requested departments
	where de.dept_no in
	(
	select d.dept_no
	from Departments as d
	where d.dept_name = 'Sales'
	);

-- (7) List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
	-- create combined dataset, including dept ID's and Names
	select e.emp_no, e.last_name, e.first_name, d.dept_name
	from Employees as e

		join dept_emp as de
		on (e.emp_no=de.emp_no)

			join Departments as d
			on (de.dept_no=d.dept_no)

	-- filter down to only the requested departments
	where de.dept_no in
	(
	select d.dept_no
	from Departments as d
	where d.dept_name = 'Sales' or d.dept_name = 'Development'
	)

	-- add some order
	order by d.dept_name, e.emp_no;

-- (8) List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
	SELECT last_name, COUNT(last_name) AS "surname_count"
	FROM Employees
	GROUP BY last_name
	ORDER BY surname_count DESC;
