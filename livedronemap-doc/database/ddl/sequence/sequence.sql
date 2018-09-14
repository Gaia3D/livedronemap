drop sequence if exists drone_seq;
drop sequence if exists drone_project_seq;



create sequence drone_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence drone_project_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;

