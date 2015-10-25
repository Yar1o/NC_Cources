--Ярослав Зарубецкий--


DROP TABLE project CASCADE CONSTRAINTS;
DROP TABLE part_project CASCADE CONSTRAINTS;
DROP TABLE part CASCADE CONSTRAINTS;
DROP TABLE part_emp CASCADE CONSTRAINTS;
DROP TABLE job CASCADE CONSTRAINTS;
DROP TABLE loc CASCADE CONSTRAINTS;
DROP TABLE dept CASCADE CONSTRAINTS;
DROP TABLE emp CASCADE CONSTRAINTS;


CREATE TABLE emp (
	em_num NUMBER(10),
	em_name NVARCHAR2(20),
	em_surn NVARCHAR2(20),
	em_patr NVARCHAR2(20),
	em_hdt DATE,
	em_sal NUMBER(7,2),
	em_comm NUMBER(7,2),
	em_id NUMBER(10),
	job_id NUMBER(4),
	dept_id NUMBER(6)
);

CREATE TABLE dept(
	dept_num NUMBER(6),
	dept_name NVARCHAR2(20),
	dept_desc NVARCHAR2(200),
	dept_id NUMBER(6),
	loc_id	NUMBER(6)
);


CREATE TABLE loc(
	loc_town NVARCHAR2(20),
	loc_street NVARCHAR2(20),
	loc_post NVARCHAR2(10),
	loc_id NUMBER(6)
);

CREATE TABLE job(
	job_name NVARCHAR2(20),
	job_spec NVARCHAR2(20),
	job_level NVARCHAR2(10),
	job_id NUMBER(4)
);

CREATE TABLE part_emp(
	part_id NUMBER(12),
	em_id NUMBER(10)
);

CREATE TABLE part(
	part_num NUMBER(12),
	part_desc NVARCHAR2(200),
	part_autor NVARCHAR2(10),
	part_id NUMBER(12)
);

CREATE TABLE part_project(
	part_id NUMBER(12),
	pr_id NUMBER(6)
);



CREATE TABLE project(
	pr_desc NVARCHAR2(150),
	pr_client NVARCHAR2(20),
	pr_tel NUMBER(15),
	pr_town NVARCHAR2(20),
	pr_email NVARCHAR2(20),
	pr_begin_d DATE,
	pr_end_d DATE,
	pr_id NUMBER(6)
);


------------------------------------------------
-- ограничения целосности типа "первичный ключ" 

alter table emp add constraint emp_pk
	primary key (em_id);
alter table dept add constraint dept_pk
	primary key (dept_id);
alter table loc add constraint loc_pk
	primary key (loc_id);
alter table job add constraint job_pk
	primary key (job_id);
alter table part add constraint part_pk
	primary key (part_id);
alter table project add constraint project_pk
	primary key (pr_id);

alter table part_project add constraint part_project_pk
	primary key (part_id,pr_id);
alter table part_emp add constraint part_emp_pk
	primary key (part_id,em_id);

------------------------------------------------
--ограничения целосности типа "внешний ключ"

alter table emp add constraint emp_job_FK
	foreign key (job_id) references job(job_id);
alter table emp add constraint emp_dept_FK
	foreign key (dept_id) references dept(dept_id);

alter table dept add constraint dept_loc_FK
	foreign key (loc_id) references loc(loc_id);


alter table part_project add constraint part_project_project_FK
	foreign key (pr_id) references project(pr_id);
alter table part_project add constraint part_project_part_FK
	foreign key (part_id) references part(part_id);


alter table part_emp add constraint part_emp_emp_FK
	foreign key (em_id) references emp(em_id);
alter table part_emp add constraint part_emp_part_FK
	foreign key (part_id) references part(part_id);

----------------------------------------------------------
-- ограничения целосности типа "контроль значений"

alter table emp add constraint check_to_noname
	check (trim(em_name) is not null);
alter table emp add constraint check_to_surname
	check (trim(em_surn) is not null);
alter table emp add constraint check_to_patr
	check (trim(em_patr) is not null);


alter table loc add constraint check_town
	check (trim(loc_town) is not null);
alter table loc add constraint check_street
	check (trim(loc_street) is not null);



alter table job add constraint check_name
	check (trim(job_name) is not null);
alter table job add constraint check_spec
	check (trim(job_spec) is not null);
alter table job add constraint check_level
	check (trim(job_level) is not null);


alter table project add constraint check_client
	check (trim(pr_client) is not null);
alter table project add constraint check_begin_date
	check (trim(pr_begin_d) is not null);
alter table project add constraint check_descriprion
	check (trim(pr_desc) is not null);

alter table part add constraint check_number
	check (trim(part_num) is not null);
alter table part add constraint check_description
	check (trim(part_desc) is not null);
alter table part add constraint check_autor
	check (trim(part_autor) is not null);



--ограничения целосности типа "потенциальный ключ"

alter table dept modify (dept_num not null);
alter table dept modify (dept_name not null);
ALTER TABLE dept ADD CONSTRAINT dept_key UNIQUE (dept_num,dept_name); 

alter table emp modify (em_name not null);
alter table emp modify (em_surn not null);
alter table emp modify (em_patr not null);
alter table emp modify (em_hdt not null);
ALTER TABLE emp ADD CONSTRAINT emp_key UNIQUE (em_name, em_surn, em_patr,em_hdt); 


alter table job modify (job_name not null);
alter table job modify (job_spec not null);
alter table job modify (job_level not null);
ALTER TABLE job ADD CONSTRAINT job_key UNIQUE (job_name, job_spec, job_level);
