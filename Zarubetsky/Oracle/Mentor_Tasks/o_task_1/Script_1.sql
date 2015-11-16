/*
1.  �������� ������, ������� ������� �������� � ������������ � ����� ������:
1) ��� � ������� ���������,
2) ����� ������� � ������� ���������� ��� �����������.
*/
cl scr;
SELECT FIRST_NAME || ' ' || LAST_NAME as Employee
      ,l.street_address
FROM employees e LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    LEFT OUTER JOIN locations l ON d.location_id = l.location_id;

