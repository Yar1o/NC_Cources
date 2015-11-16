SET PAGESIZE 120;
SET LINESIZE 80;
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

--------------------------------------------------------------------------------
---------------------------------�����_1----------------------------------------
--------------------------------------------------------------------------------
/* 
1.1 ��������� ������, �������:
- �������� �������� ����������;
- �� ��������� ���������� ������ �������� ����������. 
*/
cl scr;
SELECT j.job_title
FROM jobs j
WHERE j.job_id IN
(
    SELECT jb.job_id
    FROM employees e LEFT OUTER JOIN jobs jb  
    ON jb.job_id = e.job_id
    GROUP by jb.job_id
);
/*
JOB_TITLE                         
-----------------------------------
Programmer                          
Human Resources Representative      
Accounting Manager                  
Sales Manager                       
Accountant                          
Marketing Manager                   
Administration Vice President       
Sales Representative                
Shipping Clerk                      
Administration Assistant             
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
1.2. ��������� ������, �������:
- �������� ������� ����������� � �� ��������;
- ������ �������� ����������� ������ ���� ������ ������� �������� �����������,
���������� � ������. 
*/
WITH
europe_sal AS
(
    SELECT	AVG(salary) sal
    FROM employees e  
      LEFT JOIN departments d ON e.department_id = d.department_id
      LEFT JOIN locations l ON	l.location_id = d.location_id
      LEFT JOIN countries cs ON cs.country_id = l.country_id
      LEFT JOIN regions reg ON reg.region_id = reg.region_id
    WHERE (region_name = 'Europe')
)
SELECT	e.first_name, e.salary
FROM	employees e, europe_sal esal
WHERE	e.salary > esal.sal
order by first_name;

/*
FIRST_NAME               SALARY
-------------------- ----------
Adam                       8200 
Alberto                   12000 
Alexander                  9000 
Allan                      9000 
Alyssa                     8800 
Christopher                8000 
Clara                     10500 
Daniel                     9000 
Danielle                   9500 
David                      6800 
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
1.3. ��������� ������, �������:
- �������� �������� �������������;
- � ��������� �������������� ������� �������� ����������� ������ ���� ������
������� �������� ����������� �� ���� ��������������. 
*/
WITH
empl_sal AS
(
    SELECT department_id, ROUND(NVL(AVG(e.salary), 0),2) AVG_each_dept_sal
    FROM employees e
    GROUP BY e.department_id
),
avg_dept_global AS
(
    SELECT d.department_id, d.department_name,
           NVL(esal.AVG_each_dept_sal, 0) total_avg
    FROM departments d LEFT JOIN empl_sal esal
      ON d.department_id = esal.department_id
)
SELECT department_name
FROM avg_dept_global
WHERE total_avg > (
                    SELECT ROUND(AVG(total_avg),2) FROM avg_dept_global
                  );
/*
DEPARTMENT_NAME              
------------------------------
Administration                 
Marketing                      
Purchasing                     
Human Resources                
Shipping                       
IT                             
Public Relations               
Sales                          
Executive                      
Finance                        
Accounting                     

11 rows selected 
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
1.4. ��������� ������, ������� �������� �������� ������ � �����������
����������� ����������� �� ��������� � ������� ��������. 
--����������
����� ������� Grant �������� � ������������ null,
� ������ � ���� ���� null :)
������� � �������� ���������� ������� ��� ��������� ��������� null-������)
EMPLOYEE_ID LAST_NAME                 DEPARTMENT_ID LOCATION_ID
----------- ------------------------- ------------- -----------
        178 Grant                                 0           0   
*/
WITH
t1 AS
(
    SELECT e.employee_id, 
           e.last_name, 
          cy.country_id,
          cy.country_name
    FROM employees e
         LEFT JOIN departments d ON d.department_id = e.department_id
         LEFT JOIN locations l ON d.location_id = l.location_id
         LEFT JOIN countries cy ON l.country_id = cy.country_id
),
t2 AS
(
     SELECT NVL(ec.country_id, 'NO_Country_ID') country_id,
            count(*) cnt
     FROM t1 ec
     GROUP BY ec.country_id
)
SELECT NVL(t1.country_name, 'HAVE_NO_COUNTRY') Country_Name, t2.cnt
FROM t2 LEFT JOIN t1 ON t1.country_id = t2.country_id
WHERE t2.cnt = (
                  SELECT min(cnt)
                  FROM t2
                );
/*
COUNTRY_NAME                                    CNT
---------------------------------------- ----------
Germany                                           1 
HAVE_NO_COUNTRY                                   1 
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
1.5. ��������� ������, ������� �������� ������� ���������� � ����� �������
������� �� ��� ����� ������ � �����������. 
*/
WITH
t1 AS
(
    SELECT e.employee_id,
           e.last_name,
           e.salary*TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date)) total_salary
    FROM employees e
),
t2 AS
(
    SELECT MAX(total_salary) total_salary
    FROM t1
)
SELECT t1.last_name
FROM t1
WHERE t1.total_salary = (SELECT MAX(total_salary)
                         FROM t1);
/*
LAST_NAME               
-------------------------
King                      
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
1.6. ��������� ������, ������� �������� ������ ����� � �������������,
� ������� �� �������� ����������. 
*/
WITH
t1 AS
(
    SELECT d.department_name,
           cc.country_name,
           COUNT(e.employee_id) e_count
    FROM departments d 
         LEFT JOIN employees e ON d.department_id = e.department_id
         LEFT JOIN locations l ON d.location_id = l.location_id
         LEFT JOIN countries cc ON l.country_id = cc.country_id
    GROUP BY d.department_name, cc.country_name
)
SELECT department_name,
       country_name
FROM t1
WHERE t1.e_count = 0;
/*
DEPARTMENT_NAME                COUNTRY_NAME                           
------------------------------ ----------------------------------------
Control And Credit             United States of America                 
Recruiting                     United States of America                 
Treasury                       United States of America                 
IT Support                     United States of America                 
Shareholder Services           United States of America                 
Payroll                        United States of America                 
Construction                   United States of America                 
Government Sales               United States of America                 
Retail Sales                   United States of America                 
Benefits                       United States of America                
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/* 
1.7. ��������� ������, ������� ��������:
- �������� �������������
- ����� ������� ����������� �������������;
- �������, ������� ����� ������� ����������� ������������� ���������� �� �����
������� ���� ����������� ��������;
- ���� � ������������� ��� �����������, �� �������, ��� ����� �� �������
����� ����. 
*/
WITH
sum_sal AS
(
    SELECT e.department_id dept_id, SUM(e.salary) salsum
    FROM employees e
    GROUP BY e.department_id
)
SELECT d.department_name, 
       NVL(av.salsum, 0),
       NVL(ROUND((av.salsum / ( 
                                SELECT SUM(e.salary)
                                FROM employees e
                               )
                 )*100,2
                 ),
           0) PCT_of_total_Salary
FROM departments d LEFT OUTER JOIN sum_sal av
  ON d.department_id = av.dept_id;
/*
DEPARTMENT_NAME                    SALSUM PCT_OF_TOTAL_SALARY
------------------------------ ---------- -------------------
Finance                             51600                7.46 
Purchasing                          24900                 3.6 
Executive                           58000                8.39 
Marketing                           19000                2.75 
Public Relations                    10000                1.45 
Accounting                          20300                2.94 
Shipping                           156400               22.62 
Sales                              304500               44.04 
Human Resources                      6500                0.94 
IT                                  28800                4.17 
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/* 
1.8. ��������� ������, �������:
- �������� ������� �����������;
- �������� ����������� ������ ���� ������ 
������� �������� �����������, ����������
� ������ ��������������
*/
WITH
not_same_dept AS
(
    SELECT e1.employee_id e1_id, e2.employee_id e2_id, e2.salary slr
    FROM employees e1 INNER JOIN employees e2
    ON e1.department_id != e2.department_id
),
grouped_by_AVG_Salary AS
(
    SELECT nsd.e1_id avg_id, ROUND(AVG(nsd.slr),2) avg_sal
    FROM not_same_dept nsd
    GROUP BY nsd.e1_id
)
SELECT e.last_name
FROM employees e INNER JOIN grouped_by_AVG_Salary gAVG
  ON e.employee_id = gAVG.avg_id
WHERE e.salary > gAVG.avg_sal;
/*
LAST_NAME               
-------------------------
King                      
Bernstein                 
Hall                      
Olsen                     
Banda                     
Ozer                      
Kumar                     
Johnson                   
Popp                      
Errazuriz                 
*/

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---------------------------------�����_2----------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
2.1. ��������� ���� INSERT-�������, ���������������� ������ ���������� � �����
�������� � �������������� ���� ���������, ������� ����� ��������:
- �� ��������� Software Developer;
- � ������ Ukraine;
- � ������ Odessa;
- � ������������� NC Office. 
*/
INSERT ALL
  INTO jobs VALUES 
        ( 'SW_DEV'
        , 'Software Developer'
        , 4200
        , 9000)
  INTO countries VALUES ('UA','Ukraine',1)
  INTO locations VALUES (3300
                        ,'Mihaylovskaya'
                        ,'6666F'
                        ,'Odessa'
                        ,'Odessa'
                        ,'UA')
  INTO departments VALUES (280
                          ,'NC Office'
                          ,100
                          ,3300)
  INTO employees VALUES (207
                         ,'Jaroslav'
                         ,'Zarubetsky'
                         ,'yaroslav886@rambler.ru'
                         ,null
                         ,SYSDATE
                         ,'SW_DEV'
                         ,9999
                         ,0.2
                         ,100
                         ,280
                         )
SELECT * FROM DUAL; 
commit;
/*
5 rows inserted.
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
2.2 ������������� ������, � ������� �� �������� ����������.
*/
DELETE 
FROM departments 
WHERE department_id NOT IN 
( 
    SELECT DISTINCT d.department_id 
    FROM employees e, 
         departments d 
    WHERE e.department_id = d.department_id 
); 
DELETE 
FROM locations 
WHERE location_id NOT IN 
( 
    SELECT DISTINCT l.LOCATION_ID 
    FROM employees e, 
         departments d, 
         locations l
    WHERE e.department_id = d.department_id 
    AND l.location_id = d.location_id 
); 
DELETE 
FROM countries 
WHERE country_id NOT IN 
( 
    SELECT DISTINCT cc.country_id 
    FROM employees e , 
         departments d , 
         locations l , 
         countries cc 
    WHERE e.department_id = d.department_id 
    AND l.location_id = d.location_id 
    AND l.country_id = cc.country_id 
);
rollback;
/*
16 rows deleted.
16 rows deleted.
21 rows deleted.
rollback complete.
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
3. ����������, ������� ������ ���� �������� � ������������� � ����� ������ �������
���������, ��������� ������������ �� 10%
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mon/yyyy';

CREATE TABLE tmp AS
WITH
t1 AS /* (AVG �������� � ��������������) */
(
    SELECT e.department_id
          ,ROUND(NVL(AVG(e.salary), 0),2) AVG_SAL
    FROM employees e
    GROUP BY e.department_id
),
t2 AS /* MIN(AVG �������� � ��������������) */
(
SELECT d.department_id, tt.AVG_SAL
FROM departments d LEFT JOIN t1 tt ON d.department_id = tt.department_id
WHERE AVG_SAL = (SELECT MIN(AVG_SAL) FROM t1)
),
t3 AS /* ����� ������ ����������� */
(
SELECT e.employee_id
      ,TO_DATE(SYSDATE, 'DD-MON-YYYY') - TO_DATE(e.hire_date, 'DD-MON-YYYY') dayz
      ,e.department_id
FROM employees e
),
t4 AS 
(
    SELECT t3.employee_id
          ,t3.department_id
          ,dayz
          ,e.commission_pct
    FROM t3,t2,employees e
    WHERE t3.department_id = t2.department_id 
      AND e.employee_id = t3.employee_id
)
    SELECT * FROM t4 WHERE DAYZ = (SELECT MAX(dayz) FROM t4);

SELECT employee_id FROM tmp;

UPDATE employees
SET commission_pct = 0.1
WHERE employee_id = (SELECT employee_id FROM tmp);
commit;
DROP TABLE tmp;
/*
      session SET altered.
      table TMP created.
      1 rows updated.
      rollback complete.
      table TMP dropped.
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
/*
4. ��������� ���� ����������� �� ������������� � ����� ������ �����������
����������� � ������������� � ����� ������� ������� ���������. 
*/
cl scr;
UPDATE Employees 
SET Department_ID = (
      SELECT Department_ID
      FROM Employees
      GROUP BY Department_ID
      HAVING AVG(Salary) = (
            SELECT MAX(AVG(Salary))
            FROM Employees
            GROUP BY Department_ID
            )
      )
WHERE Department_ID IN (
      SELECT Department_ID
      FROM Employees
      GROUP BY Department_ID
      HAVING COUNT(Employee_ID) = (
            SELECT MIN(COUNT(Employee_ID))
            FROM Employees
            GROUP BY Department_ID
            )
     );
rollback;

/*
3 rows updated.
rollback complete.
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---------------------------------�����_3----------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
3.1. ��������� ������ �� ���������
-�������� �������������
-�������
� ������ �������� ����������, ������� � �������������. 
*/
SELECT d.department_name, e.last_name, level
FROM employees e LEFT JOIN departments d
    ON e.department_id = d.department_id
START WITH e.manager_id is null
CONNECT BY prior e.employee_id = e.manager_id 
ORDER BY level;
/*
DEPARTMENT_NAME                LAST_NAME                      LEVEL
------------------------------ ------------------------- ----------
Executive                      King                               1 
Executive                      De Haan                            2 
Purchasing                     Raphaely                           2 
Shipping                       Weiss                              2 
Shipping                       Fripp                              2 
Shipping                       Kaufling                           2 
Shipping                       Vollman                            2 
Shipping                       Mourgos                            2 
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
3.2. ��������� ������ �� ��������� �������� �������������, ������� � ������
�������� ����������, ������� � �����������. 
*/
SELECT d.department_name, e.last_name, level
FROM employees e LEFT JOIN departments d
    ON e.department_id = d.department_id
START WITH e.manager_id is NOT NULL
CONNECT BY prior e.manager_id = e.employee_id
ORDER BY level DESC;
/*
DEPARTMENT_NAME                LAST_NAME                      LEVEL
------------------------------ ------------------------- ----------
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
Executive                      King                               4 
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
3.3. ��������� ������ �� ��������� 
- ������� ����������,
- ������ �������������
- �������� �������������
- ����� ���� ��������
- ���� ���� ��� ���������� ����� /.
������ ������ ������ �������� ���������� ������ ���� ������������� �� ���������
�������������. 
*/

SELECT e.last_name,
       d.department_id,
       d.department_name,
       level,
       LTRIM(SYS_CONNECT_BY_PATH(e.last_name, '/'), '/') as Path
FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id
    START WITH e.manager_id is null
    CONNECT BY prior e.employee_id = e.manager_id
    ORDER SIBLINGS BY d.department_name;
/*
LAST_NAME     DEPARTMENT_ID DEPARTMENT_NAME           LEVEL PATH                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
------------  ------------- ---------------------- -------- --------------------------------
King                     90 Executive                     1 King                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
Kochhar                  90 Executive                     2 King/Kochhar                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
Higgins                 110 Accounting                    3 King/Kochhar/Higgins                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
Gietz                   110 Accounting                    4 King/Kochhar/Higgins/Gietz                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
Whalen                   10 Administration                3 King/Kochhar/Whalen                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
Greenberg               100 Finance                       3 King/Kochhar/Greenberg                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
Faviet                  100 Finance                       4 King/Kochhar/Greenberg/Faviet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
Chen                    100 Finance                       4 King/Kochhar/Greenberg/Chen                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
Sciarra                 100 Finance                       4 King/Kochhar/Greenberg/Sciarra                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
Urman                   100 Finance                       4 King/Kochhar/Greenberg/Urman                                   
*/
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*
4. ��������� ������ �� ���������:
- ��������� �� ����������, ������� � ��������� ����� �������� ����
- ������ ������: ����� ��� � ������ (��� �����), ������ �������� ������,
- �� ������� ������ ���������� ������������ ����� ������ ����� ���������������
���������� ���� � ������. 
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'dd MONTH';
COL calendar SET FORMAT A13;

WITH numbers ( n ) AS
( 
    SELECT 1 AS n FROM dual                                        /*         ��������� ����                   */
    UNION ALL                                                      /* �� �������, ������� � ��������� ������   */
    SELECT n + 1 AS
    FROM numbers
    WHERE n < ( SELECT LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE,'MM'),1)) /* ��������� ���� ���������� ������         */
                       - ADD_MONTHS(TRUNC(SYSDATE,'MM'),-1)        /* ������ ���� �������� ������              */
                       +1                                          /* ��� ���� ����                            */
                FROM DUAL                                          
              )
),
t1 AS
(
    SELECT n FROM numbers
)
SELECT ADD_MONTHS(TRUNC(SYSDATE,'MONTH'),-1) - 1 + n AS calendar   /* � ������� ��� �������� ������ ���������   */
FROM t1;                                                           /* �������� ����������                       */

/*
CALENDAR    
-------------
01 OCTOBER    
02 OCTOBER    
03 OCTOBER    
04 OCTOBER    
05 OCTOBER    
06 OCTOBER    
07 OCTOBER    
08 OCTOBER    
09 OCTOBER    
10 OCTOBER    
*/





