create table temp(i varchar2(100));
insert into temp select distinct event_id from public_event_information;
drop table temp;
create table temp(i varchar2(100));
insert into temp select event_id from public_event_information;
drop table temp;

