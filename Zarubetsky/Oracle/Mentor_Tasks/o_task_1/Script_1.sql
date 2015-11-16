/*
1.  Написать запрос, который выведет табличку с сотрудниками с двумя полями:
1) имя и фамилия работника,
2) адрес локации в которой расположен его департамент.
*/
cl scr;
SELECT FIRST_NAME || ' ' || LAST_NAME as Employee
      ,l.street_address
FROM employees e LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    LEFT OUTER JOIN locations l ON d.location_id = l.location_id;

