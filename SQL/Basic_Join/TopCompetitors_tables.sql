drop table if exists submissions;
drop table if exists challenges;
drop table if exists difficulty;
drop table if exists hackers;

create table hackers (
    hacker_id int  unsigned    not null primary key
  , name           varchar(25) not null
) engine = INNODB;

create table difficulty (
    difficulty_level int  unsigned  not null
  , score           int  unsigned not null
  , constraint diff_pk        primary key (difficulty_level, score)
) engine = INNODB;

create table challenges (
    challenge_id int  unsigned  not null primary key
  , hacker_id           int  unsigned not null
  , difficulty_level int unsigned not null
  , constraint ha_chall_dl_fk foreign key (difficulty_level)
    references difficulty (difficulty_level)
) engine = INNODB;


create table submissions (
    submission_id int  unsigned  not null primary key
  , hacker_id           int  unsigned not null
  , challenge_id  int  unsigned not null
  , score int unsigned not null
  , constraint ha_sub_ha_fk        foreign key(hacker_id) 
               references hackers  (hacker_id)
  , constraint ha_sub_ch_fk        foreign key(challenge_id) 
               references challenges  (challenge_id) 
) engine = INNODB;

insert into hackers values
  (5580, 'Rose'),
  (8439, 'Angela'),
  (27205, 'Frank'),
  (52243, 'Patrick'),
  (52348, 'Lisa'),
  (57645, 'Kimberly'),
  (77726, 'Bonnie'),
  (83082, 'Micheal'),
  (86870, 'Todd'),
  (90411, 'Joe');
  

insert into difficulty values
  (1,20), (2,30), (3,40), (4,60), (5,80), (6,100), (7,120);

insert into challenges values
  (4810, 77726, 4),
  (21089, 27205, 1),
  (36566, 5580, 7),
  (66730, 52243, 6),
  (71055, 52243, 2);
  
insert into submissions values
  (68628, 77726, 36566, 30),
  (65300, 77726, 21089, 10),
  (40326, 52243, 36566, 77), 
  (8941, 27205, 4810, 4),
  (83554, 77726, 66730, 30),
  (43353, 52243, 66730, 0),
  (55385, 52348, 71055, 20),
  (39784, 27205, 71055, 23),
  (94613, 86870, 71055, 30), 
  (45788, 52348, 36566, 0),
  (93058, 86870, 36566, 30),
  (7344, 8439, 66730, 92),
  (2721, 8439, 4810, 36),
  (523, 5580, 71055, 4),
  (49105, 52348, 66730, 0),
  (55877, 57645, 66730, 80),
  (38355, 27205, 66730, 35),
  (3924, 8439, 36566, 80),
  (97397, 90411, 66730, 100),
  (84162, 83082, 4810, 40),
  (97431, 90411, 71055, 30);