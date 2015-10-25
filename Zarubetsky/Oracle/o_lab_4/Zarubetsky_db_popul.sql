SET PAGESIZE 120;
SET LINESIZE 80;
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';
/*
1.1.1 Создать представление, которое:
- получает фамилию и имя сотрудников;     
- получает зарплату, начисленную каждому сотруднику за весь период его работы в компании с
учетом комиссионных; 
- получает для каждого сотрудника количество лет работы в компании;
- имя сотрудников представить как: первая буква в верхнем регистре, остальные - в нижнем;
- количество месяцев округлить до ближайшего целого;
- отсортировать сотрудников в порядке возрастания размера начисленной зарплаты. 
*/
------------------------------------------------------------------------------------
COL last_name format A13;
COL first_name format A13;
COL Total_SAl format 99999999999;

DROP VIEW First_View CASCADE CONSTRAINTS;
DROP VIEW Second_View CASCADE CONSTRAINTS;
DROP VIEW Third_View CASCADE CONSTRAINTS;

create view First_View (Last_Name, First_Name, Total_SAl, Total_Stage) as
       select initcap(last_name),
	      initcap(first_name), 
              round(((sysdate - hire_date)/12),0)*
			(salary+salary*NVL(commission_pct,0)) as Total_SAl,
	      round(((sysdate - hire_date)/365), 0) as Total_Stage
from employees
order by Total_SAl;

select * from First_View;

/*
LAST_NAME     FIRST_NAME       TOTAL_SAL TOTAL_STAGE                            
------------- ------------- ------------ -----------                            
Markle        Steven             1047200          16                            
Philtanker    Hazel              1051600          16                            
Olson         Tj                 1056300          17                            
Gee           Ki                 1159200          16                            
Perkins       Randall            1205000          16                            
Landry        James              1224000          17                            
Colmenares    Karen              1232500          16                            
Grant         Douglas            1248000          16                            
Sullivan      Martha             1275000          17                            
Vargas        Peter              1315000          17                            
*/
------------------------------------------------------------------------------------
/*
1.1.2. Создать представление, которое:
- получает фамилии, имена сотрудников; +
- получает для сотрудников надбавку к зарплате "Tax", которая определяется как 4% за каждый
год работы для Programmer, 3% за каждый год работы для Accountant, 2% за каждый год работы для
Sales Manager и 0.1% за каждый год работы для Administration Assistant. +
Выполните запрос к созданному представлению. 
*/

COL yearz format 999;
COL Tax format 99999;
COL salary format 999999;
COL job_title format A31;
COL first_name format A12;
COL last_name format A11;

create view Second_View (last_name, first_name, Tax) as
	select last_name, 
		first_name,
		decode(job_title, 'Programmer',  salary*0.04*round(((sysdate - e.hire_date)/365), 0),
				  'Accountant',   salary*0.03*round(((sysdate - e.hire_date)/365), 0),
				  'Sales Manager', salary*0.02*round(((sysdate - e.hire_date)/365), 0),
				  'Administration Assistant', salary*0.01*round(((sysdate - e.hire_date)/365), 0),
				   0 )
					commission
		from employees e join jobs j on e.job_id = j.job_id;
select * from Second_View;

/*
LAST_NAME   FIRST_NAME      TAX                                                 
----------- ------------ ------                                                 
King        Steven            0                                                 
Kochhar     Neena             0                                                 
De Haan     Lex               0                                                 
Hunold      Alexander      9360                                                 
Ernst       Bruce          5760                                                 
Austin      David          3648                                                 
Pataballa   Valli          3456                                                 
Lorentz     Diana          2856                                                 
Greenberg   Nancy             0                                                 
Faviet      Daniel         5670                        
*/
------------------------------------------------------------------------------------
/*
- получает фамилии сотрудников
- получает количество выходных дней (суббота, воскресенье) с момента их зачисления на
работу, например, если сотрудник был зачислен в прошлую пятницу, а сегодня понедельник, то у него
уже было 2 выходных дня, хотя всего прошло 3 дня с момента его зачисления.
- сотрудники зачислены в июле 1998 года;
- отсортировать сотрудников в порядке убывания количествв выходных дней.
Выполните запрос к созданному представлению. 
*/


alter session set nls_date_language=english;

create view Third_View (last_name, Hollidays) as
	 select last_name,
		((((trunc(next_day(sysdate,'SATURDAY')))-(next_day(hire_date, 'SATURDAY')))/7)*2) as Hollidays
	FROM employees
	where hire_date between to_date('01/07/1998', 'DD/MM/YYYY') and to_date('31/07/1998', 'DD/MM/YYYY');
select * FROM Third_View;

/*
LAST_NAME    HOLLIDAYS                                                          
----------- ----------                                                          
Vargas            1804                                                          
Gates             1802                                                          
McCain            1806                 
*/


------------------------------------------------------------------------------------
/*--------------------ЧАСТЬ 2-------------------------------------------------------
2.0. Загрузить структуру новой БД с учетом созданного пользователя под именем new_db.
2.1. Для всех таблиц новой БД создать генераторы последовательности, обеспечивающие
автоматическое создание новых значений колонок, входящих в первичный ключ.
*/

create sequence part_part_id
	increment by 1
	start with 1;

create sequence part_project_id
	increment by 1
	start with 1;

create sequence project_pr_id
	increment by 1
	start with 1;

create sequence job_job_id
	increment by 1
	start with 1;

create sequence emp_emp_id
	increment by 1
	start with 1;

create sequence loc_loc_id
	increment by 1
	start with 1;

create sequence dept_dept_id
	increment by 1
	start with 1;


/*
2.2. Для каждой таблицы новой БД создать 2 команды на внесение данных (внести две строки).
*/

insert into emp values (
	1,
	'Zarubetsky',
	'Jaroslav',
	'Antonovich',
	to_date('20/09/2015', 'DD/MM/YYYY'),
	1000,
	emp_emp_id.nextval,
	1,
	1);

insert into emp values (
	2,
	'Trofimchuk',
	'Vladislav',
	'Andreevich',
	to_date('23/11/2013', 'DD/MM/YYYY'),
	1555,
	emp_emp_id.nextval,
	2,
	2);

insert into dept values (
	1,
	'Kherson-United',
	'Some old office',
	dept_dept_id.nextval,
	1);


insert into dept values (
	2,
	'Odessa-Nova',
	'New office in Odessa-city',
	dept_dept_id.nextval,
	2);

insert into loc values (
	'Odessa',
	'Govorova, 11-a',
	15333,
	loc_loc_id.nextval);

insert into loc values (
	'Kherson',
	'Ushakova, 12',
	14433,
	loc_loc_id.nextval);

insert into job values ('Sales Manager','Junior',1,job_job_id.nextval);
insert into job values ('Inventor','Master',2,job_job_id.nextval);

insert into part_emp values (1,1);
insert into part_emp values (2,2);

insert into part_project values (1,1);
insert into part_project values (2,2);

insert into part values (1, 'Main part of my project', 'Junior developer', part_part_id);
insert into part values (2, 'Second of my project', 'Master Inventor', part_part_id);

insert into project values ('Some describe_1', 'ONPU', 03333334444, 'Odessa', 'qqq@rambler.ru', to_date('20/09/2015', 'DD/MM/YYYY'), null, project_pr_id);
insert into project values ('Some describe_2', 'MARS-developing', 0666663312, 'Odessa', 'wwwq@rambler.ru', to_date('13/09/2012', 'DD/MM/YYYY'), null, project_pr_id );



------------------------------------------------------------------------------------------------------------
/*
2.3. Выполнить команду по фиксации всех изменений в БД.
*/

commit;

/*
Commit complete.
*/
------------------------------------------------------------------------------------------------------------
/*
2.4. Для одной из таблиц, содержащей ограничение целостности внешнего ключа, выполнить
команду по изменению значения колонки внешнего ключа на значение, отсутствующее в колонке
первичного ключа соответствующей таблицы. Проверить реакцию СУБД на подобное изменение.
*/

update emp set dept_id=6;

/*
SQL> update employee set dept_id=3;
update employee set dept_id=3
*
ERROR at line 1:
ORA-02291: integrity constraint (NEW_DB.EMP_DEPT_FK) violated - parent key not
found
*/
------------------------------------------------------------------------------------------------------------
/*
2.5. Для одной из таблиц, содержащей ограничение целостности первичного ключа, выполнить
команду по изменению значения колонки первичного ключа на значение, отсутствующее в колонке
внешнего ключа соответствующей таблицы. Проверить реакцию СУБД на подобное изменение.
*/

update dept set dept_id=3
	where dept_name = 'on shevchenco str';

/*
ERROR at line 1:
ORA-02292: integrity constraint (NEW_DB.EMP_DEPT_FK) violated - child record
found
*/
------------------------------------------------------------------------------------------------------------

/*
2.6. Для одной из таблиц, содержащей ограничение целостности первичного ключа, выполнить
одну команду по удалению строки со значением колонки первичного ключа, присутствующее в
колонке внешнего ключа соответствующей таблицы. Проверить реакцию СУБД на изменение.
*/

delete from dept
	where dept_name = 'Odessa-Nova';

/*
ERROR at line 1:
ORA-00950: invalid DROP option
*/


/*
2.7. Для одной из таблиц изменить ограничение целостности внешнего ключа,
обеспечивающее каскадное удаление. Повторить задание 2.6 для измененной таблицы.
*/

alter table employee drop constraint emp_dept_FK;
alter table employee add constraint emp_dept_FK
	foreign key (dept_id) references dept(dept_id) on delete cascade;

delete from dept
	where dept_name = 'Odessa-Nova';
/*
SQL> delete from dept
  2     where dept_name = 'Odessa-Nova';

1 row deleted.

/*
2.8. Выполнить команду по отмене (откату) операции удаления из пункта 2.6 
*/
rollback;

/*
rollback complete.
*/
/*---------------------ЧАСТЬ 3----------------------------------------------------------------
Этап 3. Ведение операций изменения БД ( старая БД ) В старой БД выполнить следующие операции.

3.1. Увеличить комиссионные на n% всем сотрудникам, которые находятся на должности
«Administration Assistant», где n – количество лет, которые проработали сотрудники.
*/


UPDATE employees
SET commision_pct = commision_pct*round(((sysdate - e.hire_date)/365)
WHERE job_title = 'Administration Assistant';

/*
3.2. Уволить всех сотрудников (удалить из таблицы), которые проработали более 20 лет на
должности Shipping Clerk. Перед удалением сохранить информацию об увольняемых сотрудниках в
отдельную таблицу employee_drop, которая содержит такую же структуру, как и таблица employee.
При создании таблицы использовать конструкцию типа CREATE TABLE … AS SELECT …
Указанная операция автоматически создаст таблицу и заполнит ее значениями из ответа на
запрос. Команды увольнения и сохранения в истории оформить в виде отдельной транзакции. 
*/

CREATE TABLE employee_drop AS 
	DELETE FROM emloyee
	WHERE job_title='Shipping Clerk' AND round(((sysdate - e.hire_date)/365)>20;
