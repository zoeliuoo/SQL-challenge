CREATE TABLE "departments" (
    "dept_no" varchar(10)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" serial   NOT NULL,
    "dept_no" varchar(10)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(10)   NOT NULL,
    "emp_no" serial   NOT NULL,
    "from_date" date   NOT NULL,
	"to_date" date NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" serial   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar(10)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" serial   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" serial   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);


-- 1, List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, last_name, first_name, gender, salary
FROM employees 
JOIN salaries 
ON employees.emp_no = salaries.emp_no;


-- 2, List employees who were hired in 1986.

SELECT * 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31' ;


-- 3, List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT 
departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name, dept_manager.from_date, dept_manager.to_date
FROM dept_manager
    JOIN employees 
	ON dept_manager.emp_no = employees.emp_no
    JOIN departments 
    ON dept_manager.dept_no = departments.dept_no;
	
	
-- 4, List the department of each employee with the following information: employee number, last name, first name, and department name.

CREATE VIEW emp_dep AS 
SELECT
employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM employees
    JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no 
	JOIN departments
	ON dept_emp.dept_no = departments.dept_no;

SELECT emp_no, last_name, first_name, dept_name FROM emp_dep;


-- 5, List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name 
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6, List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT emp_no, last_name, first_name, dept_name
FROM emp_dep
WHERE dept_name = 'Sales';

-- 7, List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT emp_no, last_name, first_name, dept_name
FROM emp_dep
WHERE dept_name = 'Sales' OR dept_name = 'Development';


-- 8, In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name,
COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY count DESC;
