create table wands_property (
   code    int unsigned not null
,  age     int unsigned not null
,  is_evil int unsigned not null
,  constraint wands_property_pk primary key (code,age) 
,  constraint is_evil_values check (is_evil in (0,1))
) engine = INNODB;


create table wands (
   id           int unsigned not null auto_increment
,  code         int unsigned not null
,  coins_needed int unsigned not null
,  power        int unsigned not null
,  constraint wands_pk   primary key (id)
,  constraint wands_fk   foreign key (code) references wands_property(code)
) engine = INNODB;


insert into wands_property values
(1, 45, 0), 
(2, 40, 0), 
(3, 4, 1), 
(4, 20, 0), 
(5, 17, 0);

insert into wands (code, coins_needed, power) values
  (4, 3688, 8),
  (3, 9365, 3),
  (3, 7187, 10),
  (3, 734, 8),
  (1, 6020, 2),
  (2, 6773, 7),
  (3, 9873, 9),
  (3, 7721, 7),
  (1, 1647, 10),
  (4, 504, 5),
  (2, 7587, 5),
  (5, 9897, 10),
  (3, 4651, 8),
  (2, 5408, 1),
  (2, 6018, 7),
  (4, 7710, 5),
  (2, 8798, 7),
  (2, 3312, 3),
  (4, 7651, 6),
  (5, 5689, 3);
