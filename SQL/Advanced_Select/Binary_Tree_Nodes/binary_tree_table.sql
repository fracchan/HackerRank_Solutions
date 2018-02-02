create table bst (
    n     int unsigned   not null
  , p     int unsigned
  , constraint bst_pk    primary key (n)
) engine= INNODB;

insert into bst values (1,2);

insert into bst values 
  (3,2)
, (6,8)
, (9,8)
, (2,5)
, (8,5)
, (5,null)
;

