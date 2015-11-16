/*
2. �������� ������, ������� ������� �������� � �������������� � ����� ������: 
1) �������� ������������
2) ������� ����� ������������ � ����������� ��������� � ������������.
*/

SELECT d.department_name, 
       max(e.salary)-min(e.salary) AS Salary_Delta
FROM departments d INNER JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_name;