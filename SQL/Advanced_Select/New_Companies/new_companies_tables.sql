-- NOTE: all table created in a database called hacker_rank
-- If you do not have that database create it with the following statement:
-- create database hacker_rank;
create table hacker_rank.Company (
    company_code   varchar(25) not null
  , founder        varchar(25) not null
  , constraint company_pk primary key (company_code)  
) engine = INNODB;


/* Removing constraint due to possibilities of multiple records in the table as per question 
 
-- hp: Lead_Manager works only for one company 
   , constraint lead_manager_un unique (lead_manager_code)
   , constraint lead_manager_pk primary key (lead_manager_code, company_code)
   , constraint lead_manager_fk foreign key (company_code) references Company(company_code)
*/


create table hacker_rank.Lead_Manager (
    lead_manager_code  varchar(25) not null
   , company_code      varchar(25) not null
  
) engine = INNODB;

create table hacker_rank.Senior_Manager (
     senior_manager_code  varchar(25) not null
   , lead_manager_code    varchar(25) not null 
   , company_code         varchar(25) not null
) engine = INNODB;


create table hacker_rank.Manager (
     manager_code         varchar(25) not null
   , senior_manager_code  varchar(25) not null
   , lead_manager_code    varchar(25) not null 
   , company_code         varchar(25) not null
) engine = INNODB;


create table hacker_rank.Employee (
     employee_code        varchar(25) not null
   , manager_code         varchar(25) not null
   , senior_manager_code  varchar(25) not null
   , lead_manager_code    varchar(25) not null 
   , company_code         varchar(25) not null
) engine = INNODB;

use hacker_rank

insert into Company values 
  ("C1", "Monika")
, ("C2", "Samantha")
;

insert into Lead_Manager values 
  ("LM1", "C1")
, ("LM2", "C2")
;

insert into Senior_Manager values 
  ("SM1", "LM1", "C1")
, ("SM2", "LM1", "C1")
, ("SM3", "LM2", "C2")
;

insert into Manager values 
  ("M1", "SM1", "LM1", "C1")
, ("M2", "SM3", "LM2", "C2")
, ("M3", "SM3", "LM2", "C2")
;

insert into Employee values 
  ("E1", "M1", "SM1", "LM1", "C1")
, ("E2", "M1", "SM1", "LM1", "C1")  
, ("E3", "M2", "SM3", "LM2", "C2")
, ("E4", "M3", "SM3", "LM2", "C2")
;

