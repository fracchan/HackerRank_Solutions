create table triangles (
    a     int unsigned   not null
  , b     int unsigned   not null
  , c     int unsigned   not null
) engine= INNODB;

insert into triangles values 
  (20,20,23)
, (20,20,20)
, (20,21,22)
, (13,14,30)
;

