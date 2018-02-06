create table Students (
    ID int unsigned not null
  , Name varchar(25) not null
  , constraint students_pk primary key (ID)
) engine = INNODB;

create table Friends (
    ID int unsigned not null
  , Friend_ID int unsigned not null
  , constraint friends_fk foreign key (ID) references Students(ID)
) engine = INNODB;

create table Packages (
    ID int unsigned not null
  , Salary float unsigned not null
  , constraint packages_fk foreign key (ID) references Students(ID)
) engine = INNODB;

insert into Students values
  (1, "Ashley")
, (2, "Samantha")
, (3, "Julia")
, (4, "Scarlet")
;

insert into Friends values
  (1,2)
, (2,3)
, (3,4)
, (4,1)
;

insert into Packages values
  (1, 15.20)
, (2, 10.06)
, (3, 11.55)
, (4, 12.12)
;   
