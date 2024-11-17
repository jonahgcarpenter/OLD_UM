update Paint1NF set QTY = '20' where COLORNAME = 'DustyMauve' and VOLUME = '48' and COLORANTCODE = 'B';
delete from Paint1NF where COLORNAME = 'DustyMauve' and VOLUME = '96' and COLORANTCODE = 'B';

update Paint1NF set QTY = '29' where COLORNAME = 'DustyMauve' and VOLUME = '48' and COLORANTCODE = 'T';
insert into Paint1NF (COLORCODE, COLORNAME, COLORANT, COLORANTCODE, CANSIZE, VOLUME, QTY) values ('004', 'DustyMauve', 'Medium Yellow', 'T', 'g', '96', '1');

update Paint1NF set QTY = '10' where COLORNAME = 'DustyMauve' and VOLUME = '48' and COLORANTCODE = 'V';
insert into Paint1NF (COLORCODE, COLORNAME, COLORANT, COLORANTCODE, CANSIZE, VOLUME, QTY) values ('004', 'DustyMauve', 'Magenta', 'V', 'g', '96', '1');

select * from Paint1NF where COLORCODE ='004' order by COLORANTCODE asc;


