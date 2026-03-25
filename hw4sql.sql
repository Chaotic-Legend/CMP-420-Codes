-- CMP 420: Database Systems - Homework Assignment #4
-- Name: Isaac D. Hoyos

-- 1. Write an insert statement to add your name to the employee table. 
INSERT INTO employee 
(Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES 
('Isaac', 'D', 'Hoyos', '123456789', '2003-07-10',
 '123 Main St, NY', 'M', 40000, NULL, 5);

-- 2. Retrieve all last names of all employees ordered alphabetically by last name.
SELECT Lname
FROM employee
ORDER BY Lname ASC;

-- 3. Retrieve the names of all employees in department 5 who work more than 10 hours per week on the ProductX project.
SELECT e.Fname, e.Lname
FROM employee e
JOIN works_on w ON e.Ssn = w.Essn
JOIN project p ON w.Pno = p.Pnumber
WHERE e.Dno = 5
  AND p.Pname = 'ProductX'
  AND w.Hours > 10;

-- 4. Retrieve all employees in department 5 whose salary is between $25,000 and $45,000.
SELECT *
FROM employee
WHERE Dno = 5
  AND Salary BETWEEN 25000 AND 45000;

-- 5. Retrieve the birth date and address of the employee(s) whose name is 'Joyce A English'.
SELECT Bdate, Address
FROM employee
WHERE Fname = 'Joyce'
  AND Minit = 'A'
  AND Lname = 'English';

-- 6. List the names of all employees who have a dependent with the same first name as themselves.
SELECT e.Fname, e.Lname
FROM employee e
JOIN dependent d ON e.Ssn = d.Essn
WHERE e.Fname = d.Dependent_name;

-- 7. Find the names of all employees who are directly supervised by 'Franklin Wong'.
SELECT e.Fname, e.Lname
FROM employee e
JOIN employee s ON e.Super_ssn = s.Ssn
WHERE s.Fname = 'Franklin'
  AND s.Lname = 'Wong';

-- 8. For each department whose average employee salary is more than $30,000, retrieve the department name and the number of employees working for that department. 
SELECT d.Dname, COUNT(*) AS NumEmployees
FROM department d
JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dname
HAVING AVG(e.Salary) > 30000;

-- 9. Retrieve the number of male employees in each department making more than $30,000.
SELECT Dno, COUNT(*) AS NumMaleEmployees
FROM employee
WHERE Sex = 'M'
  AND Salary > 30000
GROUP BY Dno;

-- 10. Retrieve the names of all employees who work in the department that has the employee with the highest salary among all employees. 
SELECT Fname, Lname
FROM employee
WHERE Dno = (
    SELECT Dno
    FROM employee
    WHERE Salary = (SELECT MAX(Salary) FROM employee)
);