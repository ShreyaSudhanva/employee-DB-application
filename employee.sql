create database employee;
use employee;

CREATE TABLE company(
    comp_name varchar(20),
    comp_address varchar(100),
    comp_id integer not null,
    contact_no integer,
    primary key(comp_id)
);

INSERT INTO company VALUES("abc","4th block, Navi Mumbai",123,4567896);

CREATE TABLE department(
    dname varchar(20),
    dnumber integer not NULL AUTO_INCREMENT  ,
    comp_id integer,
    primary key(dnumber),
    UNIQUE (dname),
    FOREIGN key(comp_id) REFERENCES company(comp_id) ON UPDATE CASCADE on DELETE CASCADE
);

INSERT INTO department(dname,comp_id) VALUES
("Production",123),("Quality",123),("Service",123),("Management",123),("Research",123);

CREATE TABLE employee(
    emp_id integer AUTO_INCREMENT,
    bdate DATE ,
    address varchar(100),
    sex varchar(10),
    fname varchar(20) not null,
    minit varchar(20),
    lname varchar(20) not null,
    dno integer,
    primary key(emp_id),
    foreign key(dno) references department(dnumber) on update CASCADE on DELETE set null 
);


INSERT INTO employee(bdate,address,sex, fname, minit, lname) VALUES
("1998-07-28","Mysore","Male", "Ashok","S","R"),
("2000-08-06","Pondicherry","Female", "Shreya","","Sudhanva"),
("2000-06-14","Bangkok","female", "Preethi","K","S"),
("1992-02-17","Bangalore","Male", "Rohit","Suresh","Saraf"),
("1996-11-25","Goa","Male", "Naruto","Kumar","Uzumaki");


CREATE TABLE pay_grade(
    grade_id integer AUTO_INCREMENT ,
    grade_name varchar(20),
    grade_basic integer not null,
    grade_da integer,
    grade_pf integer,
    grade_bonus INTEGER ,
    primary key (grade_id)
);

INSERT INTO pay_grade(grade_name,grade_basic,grade_da,grade_pf,grade_bonus) VALUES
("Worker",10000,500,500,100),
("Assistant officer",10000,500,500,100),
("Clerk",10000,500,500,100),
("Analyst",10000,500,500,100),
("Accountant",10000,500,500,100);


CREATE TABLE salary(
    transaction_id int AUTO_INCREMENT ,
    emp_net_salary int ,
    emp_gross int ,
    emp_salary_year char(10),
    emp_salary_month VARCHAR (10),
    emp_id int not null,
    recieve_date date,
    grade_no int,
    PRIMARY key (transaction_id),
    FOREIGN KEY (emp_id) references employee(emp_id) on UPDATE CASCADE  on delete CASCADE ,
    FOREIGN KEY (grade_no) REFERENCES pay_grade(grade_id) on UPDATE CASCADE on delete set null
);

INSERT into salary(emp_net_salary,emp_gross,emp_salary_year,emp_salary_month,emp_id,recieve_date,grade_no) VALUES
(10000,20000,2020,"June",1,"2020-06-04",1),
(10000,20000,2020,"June",2,"2020-06-04",3),
(10000,20000,2020,"June",3,"2020-06-04",4),
(10000,20000,2020,"June",4,"2020-06-04",1),
(10000,20000,2020,"June",5,"2020-06-04",2);

alter table department drop foreign key department_ibfk_1;
alter table department drop column comp_id;
drop table company;

CREATE table company_details(
	year int auto_increment,
    turnover int not null,
    tax int not null,
    revenue int not null,
    primary key(year)
);

alter table comapny_details auto_increment=2000;

create trigger calc_rev 
before insert
on company_details
for each row
set new.revenue = new.turnover-new.tax;

create trigger capitalize
before insert on department for each row
SET new.dname = CONCAT(UCASE(LEFT(new.dname, 1)),  SUBSTRING(new.dname, 2));

create trigger capitalize_emp
before insert on employee for each row
SET new.fname = CONCAT(UCASE(LEFT(new.fname, 1)), SUBSTRING(new.fname, 2)),
new.lname = CONCAT(UCASE(LEFT(new.lname, 1)), SUBSTRING(new.lname, 2)),
new.sex = CONCAT(UCASE(LEFT(new.sex, 1)), SUBSTRING(new.sex, 2));
