-- SQL Solutions for All 14 Problems

-- Problem 1: Recyclable and Low Fat Products
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- Problem 2: Find Customer Referee
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;

-- Problem 3: Employee Bonus
SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- Problem 4: Address of Each Person
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a
ON p.personId = a.personId;

-- Problem 5: Not Boring Movies
SELECT *
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

-- Problem 6: Average Selling Price
SELECT p.product_id,
ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price
FROM Prices p
JOIN UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

-- Problem 7: Actors and Directors Who Cooperated
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;

-- Problem 8: Group Sold Products By The Date
SELECT sell_date,
COUNT(DISTINCT product) AS num_sold,
GROUP_CONCAT(DISTINCT product ORDER BY product) AS products
FROM Activities
GROUP BY sell_date;

-- Problem 9: Product Sales Analysis III
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (
 SELECT product_id, MIN(year)
 FROM Sales
 GROUP BY product_id
);

-- Problem 10: Customers Who Never Order
SELECT name
FROM Customers
WHERE id NOT IN (
 SELECT customerId FROM Orders
);

-- Problem 11: Second Highest Salary
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- Problem 12: Employees Earning More Than Their Managers
SELECT e.name
FROM Employee e
JOIN Employee m
ON e.managerId = m.id
WHERE e.salary > m.salary;

-- Problem 13: Fix Names in a Table
SELECT user_id,
CONCAT(UPPER(LEFT(name,1)), LOWER(SUBSTRING(name,2))) AS name
FROM Users
ORDER BY user_id;

-- Problem 14: Patients With a Condition
SELECT *
FROM Patients
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%;