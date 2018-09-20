drop sequence if exists client_seq;
drop sequence if exists client_group_seq;
drop sequence if exists client_group_role_seq;
drop sequence if exists drone_seq;
drop sequence if exists drone_project_seq;
drop sequence if exists token_log_seq;


create sequence client_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence client_group_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence client_group_role_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence drone_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence drone_project_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence token_log_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;

