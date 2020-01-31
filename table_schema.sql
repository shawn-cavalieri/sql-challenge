-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

-- List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no,employees.last_name,employees.first_name,employees.gender,salaries.salary
FROM employees
JOIN salaries on employees.emp_no = salaries.emp_no

-- List employees who were hired in 1986.

SELECT emp_no,first_name,last_name,hire_date FROM employees
WHERE extract(year from hire_date) = '1986';


-- List the manager of each department with the following information: department number, 
-- department name, the manager's employee number, last name, first name, 
-- and start and end employment dates.


SELECT dept_manager.dept_no,departments.dept_name,
employees.emp_no,employees.first_name,employees.last_name,
dept_manager.from_date,dept_manager.to_date
FROM dept_manager
JOIN departments on dept_manager.dept_no = departments.dept_no
JOIN employees on dept_manager.emp_no = employees.emp_no

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,
employees.first_name,departments.dept_name
FROM employees
JOIN dept_emp on employees.emp_no = dept_emp.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no;

-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name SIMILAR TO '(B)%';

-- List all employees in the Sales department, including their employee number, last name, 
-- first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,
departments.dept_name FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,
departments.dept_name FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.

SELECT last_name,COUNT(last_name) as "count_of_name" from employees
GROUP BY last_name
ORDER BY count_of_name DESC;


