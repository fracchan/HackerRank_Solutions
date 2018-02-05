-- NOTE: name is a keyword in mysql, so for testing I preferred to use a different 
-- column name st_name
drop table if exists students;
create table students (
    id          int  unsigned    not null
  , st_name   varchar(25)      not null
  , marks int unsigned not null
  , primary key (id) 
  , constraint id_range          check (id > 0)
  , constraint marks_range      check   (marks > 0)
)engine = INNODB;

insert into students values (1, 'Julia', 88); 
insert into students values (2, 'Samantha', 68); 
insert into students values (3, 'Maria', 99); 
insert into students values (4, 'Scarlet', 78); 
insert into students values (5, 'Ashley', 63); 
insert into students values (6, 'Jane', 81); 

drop table if exists grades;
create table grades (
  grade int unsigned not null auto_increment
  , min_mark int unsigned not null
  , max_mark int unsigned not null
  , primary key (grade)
) engine = INNODB;


drop procedure if exists load_grades_data;
delimiter #
create procedure load_grades_data()
begin 

declare mark_increment int unsigned default 10;
declare min_mark_var int unsigned default 0;
declare max_mark_var int unsigned default 9;
declare counter int unsigned default 0;

  start transaction;
  while counter < 10 do
    insert into grades (min_mark, max_mark) values
      (min_mark_var, max_mark_var);
    set min_mark_var = min_mark_var + mark_increment;
    set max_mark_var = max_mark_var + mark_increment;
    set counter = counter + 1;
  end while;
  commit;
end #
delimiter ;
    

call load_grades_data();

update grades set max_mark = 100 where grade = 10;