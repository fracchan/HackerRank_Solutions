create table Projects (
  Task_ID int unsigned not null
, Start_Date date not null
, End_Date date not null 
) engine=InnoDB;

insert into Projects values 
  (1, '2015-10-01', '2015-10-02')
, (2, '2015-10-02', '2015-10-03')
, (2, '2015-10-03', '2015-10-04')
, (2, '2015-10-13', '2015-10-14')
, (2, '2015-10-14', '2015-10-15')
, (2, '2015-10-28', '2015-10-29')
, (2, '2015-10-30', '2015-10-31')
;
