create table hackers (
    hacker_id int unsigned not null
  , name varchar(25) not null
  , constraint hackers_pk primary key (hacker_id)
) engine = INNODB;

create table challenges (
    challenge_id int unsigned not null
  , hacker_id  int unsigned not null
  , constraint challenges_pk primary key (challenge_id)
  , constraint challenges_fk foreign key (hacker_id) references hackers (hacker_id) 
) engine = INNODB;

-- Insert statements for Sample Input 0
insert into hackers values
  (5077, "Rose")
, (21283, "Angela")
, (62743, "Frank")
, (88255, "Patrick")
, (96196, "Lisa")
; 

insert into challenges values
  (61654, 5077)
, (58302, 21283)
, (40587, 88255)
, (29477, 5077)
, (1220, 21283)
, (69514, 21283)
, (46561, 62743)
, (58077, 62743)
, (18483, 88255)
, (76766, 21283)
, (52382, 5077)
, (74467, 21283)
, (33625, 96196)
, (26053, 88255)
, (42665, 62743)
, (12859, 62743)
, (70094, 21283)
, (34599, 88255)
, (54680, 88255)
, (61881, 5077)
;
