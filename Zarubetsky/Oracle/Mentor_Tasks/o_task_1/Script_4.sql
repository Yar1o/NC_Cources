/*
4. �������� ������, ������� ������� ������� ��������� �� ������ ��������� 
(����������. ����� ���������� ������������ �� ���, ��� � ���������� �������
�������� ��� �� ���������� ����� ��������� (�N�)).
����� ���������� ������� �������� ������ �����:
- ������ ���������
- ��������
- � ������� ������ ���� ������ � ���������� ���������
- ��������� ������ �� ������ 3.
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