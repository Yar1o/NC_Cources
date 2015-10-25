SET sqlformat ansiconsole
SET PAGESIZE 80
SET LINESIZE 120
--------------------------------------------------------------------------------
/*
2.1 Выборка данных
*/
/* 1. Построить логический план запроса, который получает фамилии сотрудников, E-mail,
их зарплату за последние три месяца с учетом комиссионных.
*/
SELECT LAST_NAME,  email ||'@Netcracker.com' AS "Email" FROM EMPLOYEES;
/*
LAST_NAME    Email
King         SKING@Netcracker.com
Kochhar      NKOCHHAR@Netcracker.com
De Haan      LDEHAAN@Netcracker.com
Hunold       AHUNOLD@Netcracker.com
Ernst        BERNST@Netcracker.com
Austin       DAUSTIN@Netcracker.com
Pataballa    VPATABAL@Netcracker.com
*/
/* 2. Выполнить запрос, который:
- получает фамилию сотрудников и их зарплату;
- зарплата превышает 15000$.
*/
SELECT last_name, salary FROM employees WHERE salary > 15000;
/*
LAST_NAME  SALARY
King       24,000
Kochhar    17,000
De Haan    17,000
*/
/* 3. Выполнить запрос, который получает фамилии сотрудников, зарплату, комиссионные,
их зарплату за год с учетом комиссионных.
*/
SELECT last_name, salary, NVL(commission_pct,0) "Commission",
  (salary+salary*NVL(commission_pct,0))*12 "Annual salary"
FROM employees;
/*
LAST_NAME    SALARY  Commission  Annual salary
King         24,000  0           288,000
Kochhar      17,000  0           204,000
De Haan      17,000  0           204,000
Hunold       9,000   0           108,000
Ernst        6,000   0           72,000
Austin       4,800   0           57,600
Pataballa    4,800   0           57,600
*/
--------------------------------------------------------------------------------
/*
2.2 Работа с множествами
*/
/* 1. Выполнить запрос, который:
- получает для каждого сотрудника cтроку в формате
'Dear '+A+ ' ' + B + ’! ' + ‘ Your salary = ‘ + C,
где A = {‘Mr.’,’Mrs.’} – сокращенный вариант обращения к мужчине или женщине
(предположить, что женщиной являются все сотрудницы, имя которых заканчивается на букву
‘a’ или ‘e’)
B – фамилия сотрудника;
C – годовая зарплата с учетом комиссионных сотрудника
*/
SELECT 'Dear' ||' '||'Mr.'||' '|| last_name||'! '||'Your salary = '|| (salary+salary*NVL(commission_pct,0))*12 "Annual salary"
FROM employees
WHERE NOT (first_name LIKE '%a'
OR first_name LIKE '%e')
UNION
SELECT 'Dear' ||' '||'Mrs.'||' '|| last_name||'! '||'Your salary = '|| (salary+salary*NVL(commission_pct,0))*12 "Annual salary"
FROM employees
WHERE first_name LIKE '%a'
OR first_name LIKE '%e';
/*
Annual salary
Dear Mr. Urman! Your salary = 93600
Dear Mr. Vargas! Your salary = 30000
Dear Mr. Weiss! Your salary = 96000
Dear Mr. Whalen! Your salary = 52800
Dear Mr. Zlotkey! Your salary = 151200
Dear Mrs. Atkinson! Your salary = 33600
Dear Mrs. Bissot! Your salary = 39600
Dear Mrs. Cambrault! Your salary = 108000
Dear Mrs. Dellinger! Your salary = 40800
*/
--------------------------------------------------------------------------------
/*
2.3 Операции соединения таблиц
*/
/*
1. Выполнить запрос, который:
- получает названия подразделений;
- подразделения расположены в городе Seattle
*/
SELECT d.department_name
FROM departments d, locations l
WHERE d.LOCATION_ID=l.LOCATION_ID AND l.CITY ='Seattle';
/*
DEPARTMENT_NAME
Administration
Purchasing
Executive
Finance
Accounting
Treasury
Corporate Tax
Control And Credit
Shareholder Services
*/
/*
2. Выполнить запрос, который:
- получает фамилию, должность, номер подразделения сотрудников
- сотрудники работают в городе Toronto.
*/
SELECT e.last_name, j.job_title, d.department_id
FROM employees e, jobs j, departments d, locations l
WHERE (d.LOCATION_ID=l.LOCATION_ID) AND (l.CITY ='Toronto') AND (e.department_id=d.department_id)
AND (e.job_id =j.JOB_ID);
/*
LAST_NAME  JOB_TITLE                 DEPARTMENT_ID
Hartstein  Marketing Manager         20
Fay        Marketing Representative  20
*/
/*
3. Выполнить запрос, который:
- получает номер и фамилию сотрудника, номер и фамилию его менеджера
- для сотрудников без менеджеров выводить фамилию менеджера в виде «No manager».
*/
SELECT worker.employee_id, worker.last_name, worker.manager_id "Manager ID",
  NVL(manager.last_name,'No Manager') "Manager last name"
FROM employees worker
LEFT JOIN employees manager
ON (worker.manager_id=manager.employee_id);
/*
EMPLOYEE_ID  LAST_NAME    Manager ID  Manager last name
201          Hartstein    100         King
149          Zlotkey      100         King
148          Cambrault    100         King
147          Errazuriz    100         King
146          Partners     100         King
145          Russell      100         King
124          Mourgos      100         King
100          King                     No Manager
*/
/*
4. Выполнить запрос, который:
- получает номер и название подразделений;
- подразделения расположены в стране UNITED STATES OF AMERICA
- в подразделениях не должно быть сотрудников.
*/
SELECT d.department_id dep_id,
  d.department_name dep_name
FROM employees e
RIGHT JOIN departments d
ON d.department_id = e.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
INNER JOIN countries c
ON l.country_id    = c.country_id
WHERE country_name = 'United States of America'
AND e.EMPLOYEE_ID IS NULL
ORDER BY d.DEPARTMENT_ID;
/*
DEP_ID  DEP_NAME
120     Treasury
130     Corporate Tax
140     Control And Credit
150     Shareholder Services
160     Benefits
170     Manufacturing
180     Construction
190     Contracting
*/
--------------------------------------------------------------------------------
/*
2.4 Агрегация данных
*/
/*
1. Выполнить запрос, который:
- получает кол-во сотрудников в каждом подразделении;
- кол-во сотрудников не должно быть меньше 2;
*/
SELECT COUNT(*) "Workers number"
FROM EMPLOYEES e
JOIN departments d USING (department_id)
GROUP BY department_id
HAVING COUNT(*)>1;
/*
Workers number
6
6
3
2
2
45
34
5
*/
/*
2. Выполнить запрос, который:
- получает названия должностей и среднюю зарплату по должности;
- должность должна быть связана с управлением, т.е. содержать слово Manager;
- средняя зарплата не должна быть менее 10 тысяч.
*/
SELECT job_title, AVG(salary) "Average salary"
FROM JOBS j
JOIN EMPLOYEES e USING (job_id)
GROUP BY job_title
HAVING job_title LIKE '%Manager%'
AND AVG(salary)>=10000;
/*
JOB_TITLE           Average salary
Accounting Manager  12,000
Finance Manager     12,000
Purchasing Manager  11,000
Sales Manager       12,200
Marketing Manager   13,000
*/
/*
3. Выполнить запрос, который:
- получает кол-во сотрудников в каждом подразделении;
- последней строкой ответа на запрос должно быть общее кол-во сотрудников.
*/
SELECT department_id, COUNT(*) "Workers number"
FROM EMPLOYEES e
GROUP BY ROLLUP (department_id);
/*
DEPARTMENT_ID  Workers number  
10             1               
20             2               
30             6               
40             1               
50             45              
60             5 
70             1               
80             34              
90             3 
*/