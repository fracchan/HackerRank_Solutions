create database hr_interviews;

use hr_interviews

-- The contest_id is the id of the contest, 
-- hacker_id is the id of the hacker who created the contest, 
-- and name is the name of the hacker.
create table Contests (
  contest_id  int  unsigned  not null 
, hacker_id int  unsigned  not null 
, name           varchar(25) not null
, constraint in_contest_pk     primary key (contest_id) 
) engine = INNODB;

-- The college_id is the id of the college, 
-- and contest_id is the id of the contest used to screen the candidates.
create table Colleges (
  college_id  int  unsigned  not null
, contest_id  int  unsigned  not null 
, constraint in_college_pk   primary key (college_id) 
, constraint in_college_fk   foreign key (contest_id) references Contests(contest_id) 
) engine = INNODB;

-- The challenge_id is the id of the challenge that belongs to one of the contests 
-- whose contest_id Samantha forgot, and college_id is the id of the college 
-- where the challenge was given to candidates.
create table Challenges (
  challenge_id  int  unsigned  not null
, college_id  int  unsigned  not null
, constraint in_challenge_pk   primary key (challenge_id) 
, constraint in_challenge_fk   foreign key (college_id) references Colleges(college_id) 
) engine = INNODB;


-- The challenge_id is the id of the challenge, 
-- total_views is the number of times the challenge was viewed by candidates, 
-- and total_unique_views is the number of times the challenge 
-- was viewed by unique candidates.

-- Had to remove the foreign key constraint since a challenge_id in the view_stats table
-- does not have a challenge_id in the challenges table
-- , constraint in_viewstats_fk   foreign key (challenge_id) references Challenges(challenge_id) 
create table View_Stats (
  challenge_id  int  unsigned  not null
, total_views   int  unsigned  not null   
, total_unique_views int unsigned not null
) engine = INNODB;

-- The challenge_id is the id of the challenge, 
-- total_submissions is the number of submissions for the challenge, 
-- and total_accepted_submission is the number of submissions that achieved full scores.

-- Had to remove the foreign key constraint since a challenge_id in the submissions_stats table
-- does not have a challenge_id in the challenges table
--, constraint in_substats_fk   foreign key (challenge_id) references Challenges(challenge_id)
create table Submission_Stats (
  challenge_id        int  unsigned  not null
, total_submissions   int  unsigned  not null   
, total_accepted_submissions int unsigned not null
) engine = INNODB;

insert into Contests values 
  (66406, 17973, 'Rose')
, (66556, 79153, 'Angela')
, (94828, 80275, 'Frank')
;

-- one contest per college
insert into Colleges values 
  (11219, 66406)
, (32473, 66556)
, (56685, 94828)
;

-- one or more challenges per college
insert into Challenges values 
  (18765, 11219)
, (47127, 11219)  
, (60292, 32473)
, (72974, 56685)
;

-- challenge 75516 not in the challenges
insert into View_Stats values 
  (47127, 26, 19) 
, (47127, 15, 14) 
, (18765, 43, 10)  
, (18765, 72, 13)
, (75516, 35, 17)
, (60292, 11, 10)
, (72974, 41, 15)
, (75516, 75, 11) 
;

-- challenge 75516 not in the challenges
insert into Submission_Stats values 
  (75516, 34, 12) 
, (47127, 27, 10)
, (47127, 56, 18) 
, (75516, 74, 12) 
, (75516, 83, 8) 
, (72974, 68, 24) 
, (72974, 82, 14)
, (47127, 28, 11)
;