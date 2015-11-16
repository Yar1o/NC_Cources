/*
4. Написать скрипт, который сделает перевод работника на другую должность 
(примечание. Выбор сотрудника произвольный из тех, что в предыдущем запросе
отмечены как не занимавшие ранее должность (‘N’)).
После выполнения скрипта работник должен иметь:
- другую должность
- зарплату
- в истории должна быть запись о предыдущей должности
- Выполнить запрос из задачи 3.
*/
cl scr;
INSERT INTO job_history
VALUES(
100,
to_date((SELECT e.hire_date FROM employees e WHERE e.employee_id = 100), 'DD-MON-YY'),
to_date('01-JUL-99', 'DD-MON-YY'),
'AC_ACCOUNT',
90);

UPDATE employees
SET job_id = 'PR_REP',
    salary = 666
WHERE employee_id = 100;

-- 
-- Employees Job_History owerview
--
@@Script_3.sql
---    
--commit;
rollback;

-------------------------------------------