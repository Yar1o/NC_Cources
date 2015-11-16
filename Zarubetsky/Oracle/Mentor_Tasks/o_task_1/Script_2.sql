/*
2. Написать запрос, который выведет табличку с департаментами с двумя полями: 
1) название департамента
2) разница между максимальной и минимальной зарплатой в департаменте.
*/

SELECT d.department_name, 
       max(e.salary)-min(e.salary) AS Salary_Delta
FROM departments d INNER JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_name;