/*
3. Ќаписать запрос, который выведет табличку с сотрудниками с пол€ми: 
1) им€ и фамили€ работника 
2) должность
3) зарплата
4) признак Ц занимал ли работник ранее другую должность в компании (СYТ) или нет (СNТ).
*/

SELECT e.first_name || ' ' || e.last_name as Employee,
       j.job_title,
       e.salary,
       DECODE(t.employee_id, '', 'N', 'Y' ) AS "NOT_SINGLE_POSITION_IN_COMPANY"
FROM employees e INNER JOIN jobs j ON j.job_id = e.job_id
                 LEFT JOIN ( SELECT DISTINCT employee_id
                               FROM job_history 
                             ) t
                 ON e.employee_id = t.employee_id;
                 
                 