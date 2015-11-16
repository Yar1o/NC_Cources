/*
3. �������� ������, ������� ������� �������� � ������������ � ������: 
1) ��� � ������� ��������� 
2) ���������
3) ��������
4) ������� � ������� �� �������� ����� ������ ��������� � �������� (�Y�) ��� ��� (�N�).
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
                 
                 