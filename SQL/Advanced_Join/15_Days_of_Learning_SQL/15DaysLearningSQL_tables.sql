create database learning_SQL;

use learning_SQL

create table Hackers (
  hacker_id int  unsigned  not null 
, name           varchar(25) not null
, constraint le_hackers_pk     primary key (hacker_id) 
) engine = INNODB;

create table Submissions (
  submission_date date not null
, submission_id int not null
, hacker_id int  unsigned  not null 
, score int  unsigned  not null 
, constraint le_subs_pk  primary key (submission_id)
, constraint le_subs_fk  foreign key (hacker_id) references Hackers(hacker_id)
) engine=InnoDB;


insert into Hackers values
   (15758, 'Rose')
,  (20703, 'Angela')
,  (36396, 'Frank')
,  (38289, 'Patrick')
,  (44065, 'Lisa')
,  (53473, 'Kimberly')
,  (62529, 'Bonnie')
,  (79722, 'Micheal')
;
  

insert into Submissions values 
  ('2016-03-01',  8494, 20703, 0)
, ('2016-03-01', 22403, 53473, 15)
, ('2016-03-01', 23965, 79722, 60)
, ('2016-03-01', 30173, 36396, 70)
, ('2016-03-02', 34928, 20703, 0)
, ('2016-03-02', 38740, 15758, 60)
, ('2016-03-02', 42769, 79722, 25)
, ('2016-03-02', 44364, 79722, 60)
, ('2016-03-03', 45440, 20703, 0)
, ('2016-03-03', 49050, 36396, 70)
, ('2016-03-03', 50273, 79722, 5)
, ('2016-03-04', 50344, 20703, 0)
, ('2016-03-04', 51360, 44065, 90)
, ('2016-03-04', 54404, 53473, 65)
, ('2016-03-04', 61533, 79722, 45)
, ('2016-03-05', 72852, 20703, 0)
, ('2016-03-05', 74546, 38289, 0)
, ('2016-03-05', 76487, 62529, 0)
, ('2016-03-05', 82439, 36396, 10)
, ('2016-03-05', 90006, 36396, 40)
, ('2016-03-06', 90404, 20703, 0)
;
